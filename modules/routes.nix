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

{ config, lib, ... }:
with lib;
let
  cfg    = config.openkrill.ingress;
  domain = config.openkrill.domain;

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
        name = "openkrill-signing-authority";
        kind = "ClusterIssuer";
      };
    };
  };

  # Build the app-traffic HTTPRoute (HTTPS listener)
  mkAppRoute = name: route: {
    name = name;
    value = {
      namespace = route.namespace;
      hostnames = [ "${route.subdomain}.${route.domain}" ];
      parentRefs = [{
        name = "main";
        namespace = "kube-system";
        sectionName = "${route.subdomain}-https";
      }];
      rules = [
        ({
          backendRefs = [{
            namespace = route.namespace;
            port = route.port;
            name = route.service;
          }];
        } // optionalAttrs (route.filters != []) {
          inherit (route) filters;
        })
      ];
    };
  };

  # Build the app-traffic HTTPRoute (HTTP listener)
  mkHttpAppRoute = name: route: {
    name = "${route.subdomain}-http";
    value = {
      namespace = route.namespace;
      hostnames = [ "${route.subdomain}.${route.domain}" ];
      parentRefs = [{
        name = "main";
        namespace = "kube-system";
        sectionName = "${route.subdomain}-http";
      }];
      rules = [
        ({
          backendRefs = [{
            namespace = route.namespace;
            port = route.port;
            name = route.service;
          }];
        } // optionalAttrs (route.filters != []) {
          inherit (route) filters;
        })
      ];
    };
  };

  # Aggregate all listeners from all routes
  allListeners = concatLists (mapAttrsToList mkListeners routes);

  # Aggregate all certificates
  allCertificates = mapAttrsToList mkCertificate routes;

  # Aggregate app HTTPRoutes (one per listener per route)
  appRoutes     = listToAttrs (mapAttrsToList mkAppRoute routes);
  httpAppRoutes = listToAttrs (mapAttrsToList mkHttpAppRoute routes);

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
        description = "Name of the backend Service. Defaults to the route name.";
      };

      port = mkOption {
        type = types.port;
        description = "Port on the backend Service.";
      };

      filters = mkOption {
        type = with types; listOf attrs;
        default = [];
        description = ''
          Gateway API HTTPRoute filters (e.g. forward-auth).
          Passed directly into the HTTPRoute rule.
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
        assertion = config.openkrill.apps.cert-manager.selfSignedCA.enable;
        message = "openkrill.ingress requires openkrill.apps.cert-manager.selfSignedCA.enable = true (provides ClusterIssuer/openkrill-signing-authority)";
      }
    ];

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

    # ── cert-manager Certificates ───────────────────────────────────
    openkrill.manifests.ingress.content = allCertificates;
  };
}
