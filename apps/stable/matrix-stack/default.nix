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
# SSO via Authelia is configured automatically.  Users log in through
# Authelia (backed by LLDAP) and are provisioned in Matrix on first login.
#
# Minimal config:
#   openkrill.apps.matrix-stack.enable = true;
#   openkrill.apps.matrix-stack.serverName = "example.com";
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg     = config.openkrill.apps.matrix-stack;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  domain  = config.openkrill.domain;

  # Generate a deterministic 26-char ULID-like ID from a seed string.
  mkULID = seed:
    let
      alphabet = "0123456789ABCDEFGHJKMNPQRSTVWXYZ";
      hash = builtins.hashString "sha256" seed;
      hexToIdx = c: {
        "0"=0; "1"=1; "2"=2; "3"=3; "4"=4; "5"=5; "6"=6; "7"=7;
        "8"=8; "9"=9; "a"=10; "b"=11; "c"=12; "d"=13; "e"=14; "f"=15;
      }.${c};
      chars = lib.genList (i:
        let val = lib.mod (hexToIdx (builtins.substring i 1 hash)) 32;
        in builtins.substring val 1 alphabet
      ) 26;
    in lib.concatStrings chars;

  # MAS upstream OIDC provider ID (ULID).
  providerID = mkULID "matrix-stack-oidc-${cfg.serverName}";

  # Static Element Web client ID (skips OAuth consent screen).
  elementClientID = mkULID "element-web-client-${cfg.serverName}";

  # Client secret: must match on both Authelia and MAS side.
  clientSecret = "matrix-authentication-service-oidc-client-secret-${cfg.serverName}";

  # The auth subdomain where MAS is served
  authHost = "auth-chat.${cfg.hostDomain}";

  # Authelia issuer URL — assumes Authelia is on auth.<hostDomain>
  autheliaIssuer = "https://auth.${cfg.hostDomain}";
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
      example = "chat.example.com";
    };

    hostDomain = mkOption {
      type = types.str;
      default = cfg.serverName;
      description = ''
        Base domain for deriving component hostnames (chat.*, web-chat.*,
        admin-chat.*, auth-chat.*).  Defaults to serverName.  Set this
        when hosting on a subdomain, e.g. serverName = "chat.example.com"
        with hostDomain = "example.com".
      '';
      example = "example.com";
    };

    adminUsers = mkOption {
      type = types.listOf types.str;
      default = [ "admin" ];
      description = ''
        Matrix usernames (localparts only, without @) that should be
        granted admin access in MAS.  These users can use Element Admin
        and the Synapse admin API.
      '';
      example = [ "admin" ];
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

    # Element Admin console — protected by ForwardAuth
    openkrill.ingress.routes.chat-admin = {
      subdomain  = "admin-chat";
      namespace  = cfg.namespace;
      service    = "matrix-stack-element-admin";
      port       = 8080;
      auth       = "forward";
      issuerRef.name = "letsencrypt";
    };

    # Element Web client — handles its own auth via Matrix/MAS
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

    # ── SSO: register MAS as an Authelia OIDC client ──────────────────
    openkrill.apps.authelia.oidcClients = [
      {
        name = "Matrix Authentication Service";
        client_id = "matrix-authentication-service";
        client_secret = "$plaintext$" + clientSecret;
        redirect_uris = [
          "https://${authHost}/upstream/callback/${providerID}"
        ];
        scopes = [ "openid" "profile" "email" ];
        grant_types = [ "authorization_code" "refresh_token" ];
        token_endpoint_auth_method = "client_secret_basic";
        # Backchannel logout: when a user logs out of Authelia,
        # MAS is notified and terminates all related sessions.
        extraConfig.backchannel_logout_uri =
          "https://${authHost}/upstream/backchannel-logout/${providerID}";
        extraConfig.backchannel_logout_session_required = true;
      }
    ];

    # ── SSO: Authelia session cookie for the hostDomain ───────────────
    # Authelia defaults to openkrill.domain; we also need a cookie for
    # the hostDomain so the OIDC authorization flow works.
    openkrill.apps.authelia.sessionCookies = mkIf (cfg.hostDomain != domain) [
      { domain = domain;          subdomain = "auth"; }
      { domain = cfg.hostDomain;  subdomain = "auth"; }
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
    openkrill.manifests.matrix-stack.content =
      let
        # Filter out Helm hook resources that we replace with our own
        # non-hook versions (init-secrets.nix).  The chart renders them
        # with helm.sh/hook annotations that ArgoCD can't execute.
        hookNames = [
          "matrix-stack-init-secrets"
          "matrix-stack-deployment-markers-pre"
          "matrix-stack-deployment-markers-post"
          "matrix-stack-synapse-check-config"
        ];
        isHookResource = r:
          builtins.elem (r.metadata.name or "") hookNames;
        chartResources = import ./helm.nix {
          inherit lib charts kubelib cfg domain;
          inherit providerID clientSecret autheliaIssuer elementClientID;
        };
      in
      (builtins.filter (r: !(isHookResource r)) chartResources)
      ++ (import ./init-secrets.nix {
        inherit lib k8s;
        namespace = cfg.namespace;
      });
  };
}
