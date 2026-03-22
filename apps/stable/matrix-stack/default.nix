# apps/matrix-stack — Element Matrix Stack (ESS Community)
#
# Deploys the official Element Server Suite Community stack via the
# element-hq/matrix-stack Helm chart.  Includes:
#   - Synapse (Matrix homeserver)
#   - Element Web (Matrix client)
#   - Matrix Authentication Service (MAS)
#   - Well-known delegation
#   - Optional: Matrix RTC (VoIP via LiveKit)
#   - Built-in PostgreSQL (for quick setup; override via values for CNPG)
#
# This replaces the separate conduwuit + element-web modules with a
# single unified Matrix deployment.  External routing is handled by
# openkrill.ingress.routes (Gateway API HTTPRoutes).
#
# Minimal config:
#   openkrill.apps.matrix-stack.enable = true;
#   openkrill.apps.matrix-stack.serverName = "example.com";
#
# After deployment, create an initial user via:
#   kubectl exec -n matrix-stack -it deploy/matrix-stack-matrix-authentication-service \
#     -- mas-cli manage register-user
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg     = config.openkrill.apps.matrix-stack;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  domain  = config.openkrill.domain;
in
{
  options.openkrill.apps.matrix-stack = {
    enable = mkEnableOption "Element Matrix Stack (Synapse + Element Web + MAS)";

    namespace = mkOption {
      type = types.str;
      default = "matrix-stack";
      description = "Kubernetes namespace for the Matrix stack.";
    };

    serverName = mkOption {
      type = types.str;
      description = ''
        The Matrix server name.  This is the domain that appears in
        user IDs (@user:server_name).  Cannot be changed after initial
        deployment.
      '';
      example = "example.com";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Routes ────────────────────────────────────────────────────────
    # Synapse homeserver — Matrix clients need direct API access so
    # ForwardAuth (Authelia) would break /_matrix calls.
    openkrill.ingress.routes.chat = {
      subdomain  = "chat";
      namespace  = cfg.namespace;
      service    = "matrix-stack-synapse";
      port       = 8008;
      auth       = "none";
      issuerRef.name = "letsencrypt";
    };

    # Element Admin console
    openkrill.ingress.routes.chat-admin = {
      subdomain  = "admin-chat";
      namespace  = cfg.namespace;
      service    = "matrix-stack-element-admin";
      port       = 8080;
      auth       = "forward";
      issuerRef.name = "letsencrypt";
    };

    # Element Web client — handles its own auth via Matrix login
    openkrill.ingress.routes.chat-web = {
      subdomain  = "web-chat";
      namespace  = cfg.namespace;
      service    = "matrix-stack-element-web";
      port       = 80;
      auth       = "none";
      issuerRef.name = "letsencrypt";
    };

    # MAS auth service — handles OIDC flows, must not go through ForwardAuth
    openkrill.ingress.routes.chat-auth = {
      subdomain  = "auth-chat";
      namespace  = cfg.namespace;
      service    = "matrix-stack-matrix-authentication-service";
      port       = 8080;
      auth       = "none";
      issuerRef.name = "letsencrypt";
    };

    # ── OIDC: register MAS as an Authelia client ────────────────────────
    openkrill.apps.authelia.oidcClients = [
      {
        name = "Matrix Authentication Service";
        client_id = "matrix-authentication-service";
        # Override default secret (which uses openkrill.domain = cia.net) to
        # match the MAS-side secret that uses the Matrix serverName domain.
        client_secret = "$plaintext$matrix-authentication-service-oidc-client-secret-kremlin.email";
        redirect_uris = [
          "https://auth-chat.kremlin.email/upstream/callback/01KMB6NHWFQQ3QDGG583YTDR21"
        ];
        scopes = [ "openid" "profile" "email" ];
        token_endpoint_auth_method = "client_secret_basic";
      }
    ];

    # ── ArgoCD Application CR ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.matrix-stack = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "matrix-stack.yaml";
      };
      destination = {
        server = "https://kubernetes.default.svc";
        namespace = cfg.namespace;
      };
      syncPolicy = {
        automated = { prune = true; selfHeal = true; };
        syncOptions = [ "CreateNamespace=true" ];
      };
    };

    # ── Manifests ──────────────────────────────────────────────────────
    openkrill.manifests.matrix-stack.content = import ./helm.nix {
      inherit lib charts kubelib cfg domain;
    };
  };
}
