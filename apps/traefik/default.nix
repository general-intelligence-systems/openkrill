# apps/traefik — Traefik CRD resources
# Generates traefik.io/v1alpha1 IngressRoute, IngressRouteTCP,
# Middleware, and MiddlewareTCP custom resources.
# Traefik itself is assumed to be already running (e.g. bundled by k3s).
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps.traefik;
  helpers = import ../../modules/lib/helpers.nix { inherit lib; };

  # ── Shared sub-submodules ────────────────────────────────────────

  middlewareRefModule = types.submodule {
    options = {
      name = mkOption {
        type = types.str;
        description = "Name of the referenced Middleware resource.";
      };
      namespace = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Namespace of the referenced Middleware resource.";
      };
    };
  };

  tlsDomainModule = types.submodule {
    options = {
      main = mkOption {
        type = types.str;
        description = "Main domain name.";
      };
      sans = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "Subject alternative domain names.";
      };
    };
  };

  tlsOptionRefModule = types.submodule {
    options = {
      name = mkOption {
        type = types.str;
        description = "Name of the referenced TLSOption.";
      };
      namespace = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Namespace of the referenced TLSOption.";
      };
    };
  };

  tlsStoreRefModule = types.submodule {
    options = {
      name = mkOption {
        type = types.str;
        description = "Name of the referenced TLSStore.";
      };
      namespace = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Namespace of the referenced TLSStore.";
      };
    };
  };

  # ── IngressRoute sub-submodules ──────────────────────────────────

  httpServiceModule = types.submodule {
    options = {
      name = mkOption {
        type = types.str;
        description = "Name of the referenced Kubernetes Service or TraefikService.";
      };
      namespace = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Namespace of the referenced Service.";
      };
      kind = mkOption {
        type = types.enum [ "Service" "TraefikService" ];
        default = "Service";
        description = "Kind of the Service.";
      };
      port = mkOption {
        type = types.nullOr (types.either types.int types.str);
        default = null;
        description = "Port of the Kubernetes Service. Can be a number or named port.";
      };
      scheme = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Scheme for the request (http/https). Defaults to https when port is 443.";
      };
      passHostHeader = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = "Whether the client Host header is forwarded. Default: true.";
      };
      weight = mkOption {
        type = types.nullOr types.int;
        default = null;
        description = "Weight for TraefikService weighted round robin.";
      };
      nativeLB = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = "Use pod IPs directly instead of ClusterIP. Default: false.";
      };
      serversTransport = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Name of ServersTransport resource to use.";
      };
      strategy = mkOption {
        type = types.nullOr (types.enum [ "wrr" "p2c" "hrw" "leasttime" ]);
        default = null;
        description = "Load balancing strategy.";
      };
    };
  };

  httpRouteModule = types.submodule {
    options = {
      match = mkOption {
        type = types.str;
        description = "Router rule expression (e.g. Host(`example.com`)).";
      };
      kind = mkOption {
        type = types.enum [ "Rule" ];
        default = "Rule";
        description = "Kind of the route. Only Rule is supported.";
      };
      priority = mkOption {
        type = types.nullOr types.int;
        default = null;
        description = "Router priority.";
      };
      middlewares = mkOption {
        type = types.listOf middlewareRefModule;
        default = [];
        description = "References to Middleware resources.";
      };
      services = mkOption {
        type = types.listOf httpServiceModule;
        default = [];
        description = "Backend services to route to.";
      };
    };
  };

  httpTlsModule = types.submodule {
    options = {
      secretName = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Name of the Kubernetes Secret containing TLS certificate.";
      };
      certResolver = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Name of the certificate resolver.";
      };
      domains = mkOption {
        type = types.listOf tlsDomainModule;
        default = [];
        description = "Domains for certificate issuance.";
      };
      options = mkOption {
        type = types.nullOr tlsOptionRefModule;
        default = null;
        description = "Reference to a TLSOption resource.";
      };
      store = mkOption {
        type = types.nullOr tlsStoreRefModule;
        default = null;
        description = "Reference to a TLSStore resource.";
      };
    };
  };

  # ── IngressRoute submodule ───────────────────────────────────────
  ingressRouteModule = types.submodule ({ name, ... }: {
    options = {
      namespace = mkOption {
        type = types.str;
        description = "Namespace for this IngressRoute.";
      };
      entryPoints = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "Entry point names to bind to (e.g. web, websecure).";
      };
      routes = mkOption {
        type = types.listOf httpRouteModule;
        description = "HTTP route definitions.";
      };
      tls = mkOption {
        type = types.nullOr httpTlsModule;
        default = null;
        description = "TLS configuration.";
      };
    };
  });

  # ── IngressRouteTCP sub-submodules ───────────────────────────────

  tcpServiceModule = types.submodule {
    options = {
      name = mkOption {
        type = types.str;
        description = "Name of the referenced Kubernetes Service.";
      };
      namespace = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Namespace of the referenced Service.";
      };
      port = mkOption {
        type = types.either types.int types.str;
        description = "Port of the Kubernetes Service. Can be a number or named port.";
      };
      weight = mkOption {
        type = types.nullOr types.int;
        default = null;
        description = "Weight for balancing between multiple services.";
      };
      nativeLB = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = "Use pod IPs directly instead of ClusterIP.";
      };
      tls = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = "Whether to use TLS when dialing the backend.";
      };
      serversTransport = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Name of ServersTransportTCP resource to use.";
      };
    };
  };

  tcpRouteModule = types.submodule {
    options = {
      match = mkOption {
        type = types.str;
        description = "Router rule expression (e.g. HostSNI(`*`)).";
      };
      priority = mkOption {
        type = types.nullOr types.int;
        default = null;
        description = "Router priority.";
      };
      middlewares = mkOption {
        type = types.listOf middlewareRefModule;
        default = [];
        description = "References to MiddlewareTCP resources.";
      };
      services = mkOption {
        type = types.listOf tcpServiceModule;
        default = [];
        description = "Backend TCP services to route to.";
      };
    };
  };

  tcpTlsModule = types.submodule {
    options = {
      secretName = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Name of the Kubernetes Secret containing TLS certificate.";
      };
      certResolver = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Name of the certificate resolver.";
      };
      domains = mkOption {
        type = types.listOf tlsDomainModule;
        default = [];
        description = "Domains for certificate issuance.";
      };
      options = mkOption {
        type = types.nullOr tlsOptionRefModule;
        default = null;
        description = "Reference to a TLSOption resource.";
      };
      store = mkOption {
        type = types.nullOr tlsStoreRefModule;
        default = null;
        description = "Reference to a TLSStore resource.";
      };
      passthrough = mkOption {
        type = types.bool;
        default = false;
        description = "Whether TLS termination is skipped (passthrough to backend).";
      };
    };
  };

  # ── IngressRouteTCP submodule ────────────────────────────────────
  ingressRouteTCPModule = types.submodule ({ name, ... }: {
    options = {
      namespace = mkOption {
        type = types.str;
        description = "Namespace for this IngressRouteTCP.";
      };
      entryPoints = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "Entry point names to bind to.";
      };
      routes = mkOption {
        type = types.listOf tcpRouteModule;
        description = "TCP route definitions.";
      };
      tls = mkOption {
        type = types.nullOr tcpTlsModule;
        default = null;
        description = "TLS configuration. Required for HostSNI matching.";
      };
    };
  });

  # ── Middleware submodule (passthrough spec) ───────────────────────
  middlewareModule = types.submodule ({ name, ... }: {
    options = {
      namespace = mkOption {
        type = types.str;
        description = "Namespace for this Middleware.";
      };
      spec = mkOption {
        type = types.attrsOf types.anything;
        description = ''
          Middleware spec. Set exactly one middleware type key, e.g.:
          spec.headers = { stsSeconds = 315360000; };
          spec.rateLimit = { average = 100; burst = 50; };
          spec.basicAuth = { secret = "my-secret"; };
          spec.forwardAuth = { address = "http://auth.example.com"; };
          spec.stripPrefix = { prefixes = [ "/api" ]; };
          spec.chain = { middlewares = [ { name = "auth"; } { name = "headers"; } ]; };
        '';
      };
    };
  });

  # ── MiddlewareTCP submodule (passthrough spec) ───────────────────
  middlewareTCPModule = types.submodule ({ name, ... }: {
    options = {
      namespace = mkOption {
        type = types.str;
        description = "Namespace for this MiddlewareTCP.";
      };
      spec = mkOption {
        type = types.attrsOf types.anything;
        description = ''
          MiddlewareTCP spec. Set exactly one middleware type key, e.g.:
          spec.ipAllowList = { sourceRange = [ "10.0.0.0/8" ]; };
          spec.inFlightConn = { amount = 100; };
        '';
      };
    };
  });

  # ── Resource builders ────────────────────────────────────────────

  # Remove null values from an attrset (one level deep)
  compact = filterAttrs (_: v: v != null);

  mkMiddlewareRef = mw: compact {
    inherit (mw) name namespace;
  };

  mkTlsDomain = d: {
    inherit (d) main;
  } // optionalAttrs (d.sans != []) {
    inherit (d) sans;
  };

  mkTlsOptionRef = ref: compact {
    inherit (ref) name namespace;
  };

  mkTlsStoreRef = ref: compact {
    inherit (ref) name namespace;
  };

  # ── HTTP IngressRoute builder ──

  mkHttpService = svc: compact {
    inherit (svc) name namespace kind port scheme passHostHeader weight nativeLB serversTransport strategy;
  };

  mkHttpRoute = route: {
    inherit (route) match kind;
  }
  // optionalAttrs (route.priority != null) { inherit (route) priority; }
  // optionalAttrs (route.middlewares != []) {
    middlewares = map mkMiddlewareRef route.middlewares;
  }
  // optionalAttrs (route.services != []) {
    services = map mkHttpService route.services;
  };

  mkHttpTls = tls:
    compact {
      inherit (tls) secretName certResolver;
    }
    // optionalAttrs (tls.domains != []) {
      domains = map mkTlsDomain tls.domains;
    }
    // optionalAttrs (tls.options != null) {
      options = mkTlsOptionRef tls.options;
    }
    // optionalAttrs (tls.store != null) {
      store = mkTlsStoreRef tls.store;
    };

  mkIngressRoute = name: ir: {
    apiVersion = "traefik.io/v1alpha1";
    kind = "IngressRoute";
    metadata = {
      inherit name;
      namespace = ir.namespace;
    };
    spec = {
      routes = map mkHttpRoute ir.routes;
    }
    // optionalAttrs (ir.entryPoints != []) { inherit (ir) entryPoints; }
    // optionalAttrs (ir.tls != null) { tls = mkHttpTls ir.tls; };
  };

  # ── TCP IngressRouteTCP builder ──

  mkTcpService = svc: compact {
    inherit (svc) name namespace port weight nativeLB tls serversTransport;
  };

  mkTcpRoute = route: {
    inherit (route) match;
  }
  // optionalAttrs (route.priority != null) { inherit (route) priority; }
  // optionalAttrs (route.middlewares != []) {
    middlewares = map mkMiddlewareRef route.middlewares;
  }
  // optionalAttrs (route.services != []) {
    services = map mkTcpService route.services;
  };

  mkTcpTls = tls: let
    base = compact {
      inherit (tls) secretName certResolver;
    }
    // optionalAttrs tls.passthrough { inherit (tls) passthrough; }
    // optionalAttrs (tls.domains != []) {
      domains = map mkTlsDomain tls.domains;
    }
    // optionalAttrs (tls.options != null) {
      options = mkTlsOptionRef tls.options;
    }
    // optionalAttrs (tls.store != null) {
      store = mkTlsStoreRef tls.store;
    };
  in base;

  mkIngressRouteTCP = name: irtcp: {
    apiVersion = "traefik.io/v1alpha1";
    kind = "IngressRouteTCP";
    metadata = {
      inherit name;
      namespace = irtcp.namespace;
    };
    spec = {
      routes = map mkTcpRoute irtcp.routes;
    }
    // optionalAttrs (irtcp.entryPoints != []) { inherit (irtcp) entryPoints; }
    // optionalAttrs (irtcp.tls != null) { tls = mkTcpTls irtcp.tls; };
  };

  # ── Middleware builders ──

  mkMiddleware = name: mw: {
    apiVersion = "traefik.io/v1alpha1";
    kind = "Middleware";
    metadata = {
      inherit name;
      namespace = mw.namespace;
    };
    spec = mw.spec;
  };

  mkMiddlewareTCP = name: mw: {
    apiVersion = "traefik.io/v1alpha1";
    kind = "MiddlewareTCP";
    metadata = {
      inherit name;
      namespace = mw.namespace;
    };
    spec = mw.spec;
  };

  # ── Collect all resources ────────────────────────────────────────

  allResources =
    (mapAttrsToList mkIngressRoute cfg.ingressRoutes)
    ++ (mapAttrsToList mkIngressRouteTCP cfg.ingressRouteTCPs)
    ++ (mapAttrsToList mkMiddleware cfg.middlewares)
    ++ (mapAttrsToList mkMiddlewareTCP cfg.middlewareTCPs);
in
{
  options.openkrill.apps.traefik = {
    enable = mkEnableOption "Traefik CRD resources (IngressRoute, Middleware, etc.)";

    ingressRoutes = mkOption {
      type = types.attrsOf ingressRouteModule;
      default = {};
      description = "IngressRoute CRD instances for HTTP routing.";
    };

    ingressRouteTCPs = mkOption {
      type = types.attrsOf ingressRouteTCPModule;
      default = {};
      description = "IngressRouteTCP CRD instances for TCP routing.";
    };

    middlewares = mkOption {
      type = types.attrsOf middlewareModule;
      default = {};
      description = "Middleware CRD instances for HTTP request processing.";
    };

    middlewareTCPs = mkOption {
      type = types.attrsOf middlewareTCPModule;
      default = {};
      description = "MiddlewareTCP CRD instances for TCP connection processing.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── VictoriaMetrics scrape + alerts ────────────────────────────────
    # Traefik is k3s-bundled in kube-system; no network policy needed.
    openkrill.apps.victoriametrics.vmservicescrapes.traefik =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        selector.matchLabels."app.kubernetes.io/name" = "traefik";
        namespaceSelector.matchNames = [ "kube-system" ];
        endpoints = [{ port = "traefik"; path = "/metrics"; }];
      };

    openkrill.apps.victoriametrics.vmrules.traefik-alerts =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        groups = [{
          name = "traefik";
          rules = [
            {
              alert = "TraefikHighHTTP5xxRate";
              expr = ''sum(rate(traefik_service_requests_total{code=~"5.."}[5m])) / sum(rate(traefik_service_requests_total[5m])) > 0.05'';
              "for" = "5m";
              labels.severity = "warning";
              annotations = {
                summary = "Traefik high 5xx error rate";
                description = "More than 5% of Traefik requests are returning 5xx errors.";
              };
            }
            {
              alert = "TraefikBackendDown";
              expr = ''traefik_service_server_up == 0'';
              "for" = "5m";
              labels.severity = "critical";
              annotations = {
                summary = "Traefik backend {{ $labels.service }} is down";
                description = "Traefik reports backend server {{ $labels.service }} has been down for 5 minutes.";
              };
            }
          ];
        }];
      };

    # When gateway-api is also enabled, configure Traefik as the
    # Gateway API controller and register its GatewayClass.
    openkrill.apps.helm.chartConfigs.traefik = mkIf config.openkrill.apps."gateway-api".enable {
      valuesContent = ''
        gatewayClass:
          # Disable the Helm chart's built-in GatewayClass creation.
          # We manage the GatewayClass declaratively via
          # openkrill.apps."gateway-api".gatewayclasses.traefik (below),
          # which is deployed by the gateway-api ArgoCD app.  If the Helm
          # chart also tries to create it, the install fails because the
          # existing resource lacks Helm ownership metadata.
          enabled: false
        providers:
          kubernetesGateway:
            enabled: true
      '';
    };

    openkrill.apps."gateway-api".gatewayclasses.traefik = mkIf config.openkrill.apps."gateway-api".enable {
      namespace = "kube-system";
      controllerName = "traefik.io/gateway-controller";
    };

    # ForwardAuth middleware — created when Authelia is also enabled.
    openkrill.apps.traefik.middlewares.forwardauth-authelia = mkIf config.openkrill.apps.authelia.enable {
      namespace = "kube-system";
      spec = {
        forwardAuth = {
          address = "http://authelia.${config.openkrill.apps.authelia.namespace}.svc.cluster.local/api/authz/forward-auth";
          trustForwardHeader = true;
          authResponseHeaders = [
            "Remote-User"
            "Remote-Groups"
            "Remote-Email"
            "Remote-Name"
          ];
        };
      };
    };

    openkrill.apps.argocd.applications.traefik = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "traefik.yaml";
      };
      destination = {
        server = "https://kubernetes.default.svc";
      };
      syncPolicy = {
        automated = { prune = true; selfHeal = true; };
      };
    };

    openkrill.manifests.traefik.content = allResources;
  };
}
