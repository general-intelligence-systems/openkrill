# modules/routes.nix
#
# Declarative ingress for openkrill services.
#
# Instead of each app module reaching into gateway-api internals,
# apps declare `openkrill.ingress.routes.<name> = { subdomain; namespace; ... }`.
#
# When openkrill.ingress.enable is true, this module:
#   1. Creates Gateway/main in kube-system with per-route listeners
#      (HTTPS with TLS termination + HTTP)
#   2. Creates a cert-manager Certificate per route (signed by
#      openkrill-signing-authority), with TLS Secrets in kube-system
#   3. Creates an HTTPRoute per listener per route for app traffic
#
# Both HTTP and HTTPS listeners forward to the backend — no redirects.
# TLS between Traefik and backends is handled by the pods themselves;
# Traefik trusts their certs via the trust-manager CA bundle.
#
# The Gateway uses gatewayClassName "traefik" — the GatewayClass
# created by the traefik module.
#
# Authentication is decoupled from this module.  Routes declare an
# auth type per path (forward, token, basic, oauth, none).  Auth
# provider modules (e.g. Authelia) register their HTTPRoute filters
# under openkrill.ingress.authFilters.<type>.  This module applies
# registered filters to matching rules — it has no knowledge of any
# specific auth provider.

{ config, lib, ... }:
with lib;
let
  cfg    = config.openkrill.ingress;
  domain = config.openkrill.domain;

  authTypes = [ "forward" "token" "basic" "oauth" "none" ];

  # Look up registered filters for an auth type.
  # Returns [] if no provider has registered filters for this type.
  filtersForAuth = authType:
    optionals (cfg.authFilters ? ${authType}) cfg.authFilters.${authType};

  # Merge auth-provider filters with any user-specified filters
  effectiveFilters = authType: extraFilters:
    (filtersForAuth authType) ++ extraFilters;

  # Resolve paths for a route.  When paths is empty, produce a single
  # catch-all entry from the route-level defaults.
  resolvedPaths = route:
    if route.paths == {} then
      [{
        path      = "/";
        pathType  = "PathPrefix";
        isCatchAll = true;  # omit matches block for catch-all
        auth      = route.auth;
        service   = route.service;
        port      = route.port;
        filters   = route.filters;
      }]
    else
      mapAttrsToList (path: pcfg: {
        inherit path;
        pathType   = pcfg.pathType;
        isCatchAll = (path == "/" && pcfg.pathType == "PathPrefix");
        auth       = pcfg.auth;
        service    = if pcfg.service != null then pcfg.service else route.service;
        port       = if pcfg.port != null then pcfg.port else route.port;
        filters    = pcfg.filters ++ route.filters;
      }) route.paths;

  # Collect all enabled route definitions
  routes = filterAttrs (_: r: r.enable) cfg.routes;

  # Build the HTTPS + HTTP listener pair for a single route.
  #
  # Listener ports must match Traefik's *entrypoint* ports (8443/8000),
  # not the conventional external ports (443/80).  Traefik's Gateway API
  # provider matches Gateway listeners to entrypoints by container port
  # number, not by Service port.  The k3s LoadBalancer Service handles
  # the external 443→8443 and 80→8000 mapping separately.
  mkListeners = name: route:
    let
      hostname = "${route.subdomain}.${route.domain}";
      secretName = "${route.subdomain}-tls";
    in [
      {
        name = "${route.subdomain}-https";
        port = 8443;   # Traefik "websecure" entrypoint
        protocol = "HTTPS";
        inherit hostname;
        tls = {
          mode = "Terminate";
          certificateRefs = [{
            kind = "Secret";
            name = secretName;
          }];
        };
        allowedRoutes.namespaces.from = "All";
      }
      {
        name = "${route.subdomain}-http";
        port = 8000;   # Traefik "web" entrypoint
        protocol = "HTTP";
        inherit hostname;
        allowedRoutes.namespaces.from = "All";
      }
    ];

  # Build a cert-manager Certificate for a single route
  mkCertificate = name: route: {
    apiVersion = "cert-manager.io/v1";
    kind = "Certificate";
    metadata = {
      name = "${route.subdomain}-tls";
      namespace = "kube-system";
    };
    spec = {
      secretName = "${route.subdomain}-tls";
      dnsNames = [ "${route.subdomain}.${route.domain}" ];
      issuerRef = {
        inherit (route.issuerRef) name kind;
      };
    };
  };

  # Build a single HTTPRoute rule from a resolved path entry
  mkRule = route: pathEntry:
    let
      filters = effectiveFilters pathEntry.auth pathEntry.filters;
    in
    ({
      backendRefs = [{
        namespace = route.namespace;
        port = pathEntry.port;
        name = pathEntry.service;
      }];
    }
    # Omit matches for catch-all "/" PathPrefix (Gateway API default matches all)
    // optionalAttrs (!pathEntry.isCatchAll) {
      matches = [{
        path = {
          type = pathEntry.pathType;
          value = pathEntry.path;
        };
      }];
    }
    // optionalAttrs (filters != []) {
      inherit filters;
    });

  # Build the app-traffic HTTPRoute (HTTPS listener)
  #
  # All HTTPRoutes live in kube-system so they share the namespace with
  # auth middleware (Traefik resolves extensionRef relative to the
  # HTTPRoute's own namespace).  Backend services are referenced
  # cross-namespace via backendRefs.
  mkAppRoute = name: route: {
    name = name;
    value = {
      namespace = "kube-system";
      hostnames = [ "${route.subdomain}.${route.domain}" ];
      parentRefs = [{
        name = "main";
        namespace = "kube-system";
        sectionName = "${route.subdomain}-https";
      }];
      rules = map (mkRule route) (resolvedPaths route);
    };
  };

  # Build the app-traffic HTTPRoute (HTTP listener)
  mkHttpAppRoute = name: route: {
    name = "${route.subdomain}-http";
    value = {
      namespace = "kube-system";
      hostnames = [ "${route.subdomain}.${route.domain}" ];
      parentRefs = [{
        name = "main";
        namespace = "kube-system";
        sectionName = "${route.subdomain}-http";
      }];
      rules = map (mkRule route) (resolvedPaths route);
    };
  };

  # Aggregate all listeners from all routes
  allListeners = concatLists (mapAttrsToList mkListeners routes);

  # Aggregate all certificates
  allCertificates = mapAttrsToList mkCertificate routes;

  # Aggregate app HTTPRoutes (one per listener per route)
  appRoutes     = listToAttrs (mapAttrsToList mkAppRoute routes);
  httpAppRoutes = listToAttrs (mapAttrsToList mkHttpAppRoute routes);

  # Collect unique backend namespaces and build a ReferenceGrant in each,
  # allowing HTTPRoutes in kube-system to reference Services there.
  backendNamespaces = unique (mapAttrsToList (_: r: r.namespace) routes);

  referenceGrants = listToAttrs (map (ns: {
    name = "allow-kube-system-routes-${ns}";
    value = {
      namespace = ns;
      from = [{
        group = "gateway.networking.k8s.io";
        kind  = "HTTPRoute";
        namespace = "kube-system";
      }];
      to = [{
        group = "";
        kind  = "Service";
      }];
    };
  }) backendNamespaces);

  # Per-path option submodule
  pathSubmodule = types.submodule ({ ... }: {
    options = {
      auth = mkOption {
        type = types.enum authTypes;
        default = "forward";
        description = ''
          Auth type for this path.  Determines which auth provider
          filters (if any) are applied to the HTTPRoute rule.
          See specs/auth.md for details on each type.
        '';
      };

      pathType = mkOption {
        type = types.enum [ "PathPrefix" "Exact" "RegularExpression" ];
        default = "PathPrefix";
        description = ''
          Gateway API path match type.  Maps directly to the
          HTTPRouteMatch path.type field.
        '';
      };

      service = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = ''
          Backend Service name override.  When null, inherits
          from the route-level service option.
        '';
      };

      port = mkOption {
        type = types.nullOr types.port;
        default = null;
        description = ''
          Backend Service port override.  When null, inherits
          from the route-level port option.
        '';
      };

      filters = mkOption {
        type = with types; listOf attrs;
        default = [];
        description = ''
          Additional Gateway API HTTPRoute filters for this path.
          These are appended after any auth-provider filters.
        '';
      };
    };
  });

  # Per-route option submodule
  routeSubmodule = types.submodule ({ name, ... }: {
    options = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Whether this route is active.";
      };

      subdomain = mkOption {
        type = types.str;
        description = ''
          Subdomain prefix. The full hostname becomes
          <subdomain>.<domain>.
        '';
      };

      domain = mkOption {
        type = types.str;
        default = domain;
        description = ''
          Domain suffix. The full hostname becomes
          <subdomain>.<domain>. Defaults to openkrill.domain.
        '';
      };

      namespace = mkOption {
        type = types.str;
        description = "Kubernetes namespace where the backend Service lives.";
      };

      service = mkOption {
        type = types.str;
        default = name;
        description = "Name of the default backend Service. Defaults to the route name.";
      };

      port = mkOption {
        type = types.port;
        description = "Default port on the backend Service.";
      };

      auth = mkOption {
        type = types.enum authTypes;
        default = "forward";
        description = ''
          Default auth type for this route.  Used when paths is empty
          (catch-all) or as the default for path entries that don't
          specify their own auth type.

          Auth types:
            forward - ForwardAuth SSO (e.g. Authelia)
            token   - App handles token/API-key auth
            basic   - App handles HTTP Basic auth
            oauth   - App handles its own OAuth/OIDC
            none    - No authentication
        '';
      };

      paths = mkOption {
        type = types.attrsOf pathSubmodule;
        default = {};
        description = ''
          Per-path rules.  Keys are URL paths (e.g. "/", "/api").
          Each path can specify its own auth type, path match type,
          and optional backend service/port override.

          When empty, a single catch-all rule is created using the
          route-level auth, service, and port.
        '';
      };

      issuerRef = mkOption {
        type = types.submodule {
          options = {
            name = mkOption {
              type = types.str;
              default = "openkrill-signing-authority";
              description = "Name of the cert-manager ClusterIssuer for this route's TLS certificate.";
            };
            kind = mkOption {
              type = types.enum [ "ClusterIssuer" "Issuer" ];
              default = "ClusterIssuer";
              description = "Kind of the cert-manager issuer reference.";
            };
          };
        };
        default = {};
        description = ''
          cert-manager issuer reference for TLS certificates on this route.
          Defaults to the self-signed CA (openkrill-signing-authority).
          Set name = "letsencrypt" for publicly-trusted certificates.
        '';
      };

      filters = mkOption {
        type = with types; listOf attrs;
        default = [];
        description = ''
          Additional Gateway API HTTPRoute filters applied to all
          rules in this route, alongside any auth-provider filters.
        '';
      };
    };
  });

in
{
  options.openkrill.ingress = {
    enable = mkEnableOption "openkrill managed ingress and default gateway";

    routes = mkOption {
      type = types.attrsOf routeSubmodule;
      default = {};
      description = ''
        Per-app route definitions. Each entry creates:
          - A listener pair (HTTPS + HTTP) on the default Gateway
          - A cert-manager Certificate for TLS termination
          - An HTTPRoute per listener for app traffic
      '';
    };

    authFilters = mkOption {
      type = types.attrsOf (with types; listOf attrs);
      default = {};
      internal = true;
      description = ''
        Auth type → list of Gateway API HTTPRoute filters.
        Populated by auth provider modules (e.g. Authelia).

        Example: authFilters.forward = [{ type = "ExtensionRef"; ... }]

        routes.nix reads this when building HTTPRoute rules and applies
        the filters matching each path's auth type.  This keeps the
        ingress module completely auth-provider-agnostic.
      '';
    };
  };

  config = mkIf cfg.enable {
    # ── Assertions ──────────────────────────────────────────────────
    assertions = [
      {
        assertion = config.openkrill.apps."gateway-api".enable;
        message = "openkrill.ingress requires openkrill.apps.gateway-api.enable = true";
      }
      {
        assertion = config.openkrill.apps.cert-manager.enable;
        message = "openkrill.ingress requires openkrill.apps.cert-manager.enable = true";
      }
      {
        assertion =
          config.openkrill.apps.cert-manager.selfSignedCA.enable
          || all (r: r.issuerRef.name != "openkrill-signing-authority") (attrValues routes);
        message = "openkrill.ingress requires openkrill.apps.cert-manager.selfSignedCA.enable = true when any route uses the default issuer (openkrill-signing-authority)";
      }
    ];

    # ── CoreDNS ingress host resolution ──────────────────────────────
    # Every route hostname must be resolvable from within the cluster.
    # Since the domain is typically private (no public DNS), we tell
    # CoreDNS to synthesise CNAME records pointing each hostname to
    # the Traefik service.  Pods then reach Traefik's ClusterIP, which
    # matches the Gateway listener and routes to the backend.
    openkrill.apps.core-dns.ingressHosts = mkIf config.openkrill.apps.core-dns.enable
      (mapAttrsToList (_: r: "${r.subdomain}.${r.domain}") routes);

    # ── Default Gateway ─────────────────────────────────────────────
    openkrill.apps."gateway-api".gateways.main = mkDefault {
      namespace = "kube-system";
      gatewayClassName = "traefik";
      listeners = allListeners;
    };

    # ── HTTPRoutes (app traffic on both HTTPS and HTTP listeners) ───
    openkrill.apps."gateway-api".httproutes = mkMerge [
      appRoutes
      httpAppRoutes
    ];

    # ── ReferenceGrants (allow kube-system HTTPRoutes → backend Services) ─
    openkrill.apps."gateway-api".referencegrants = referenceGrants;

    # ── cert-manager Certificates ───────────────────────────────────
    openkrill.manifests.gateway-api.content = allCertificates;
  };
}
