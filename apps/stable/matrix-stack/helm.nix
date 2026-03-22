# Helm values for the element-hq/matrix-stack chart.
#
# The chart deploys a complete Matrix stack: Synapse (homeserver),
# Element Web (client), Matrix Authentication Service (MAS), and
# optionally Matrix RTC (VoIP).  Each component has its own ingress.
#
# SSO is pre-configured: MAS authenticates via Authelia (OIDC).
# Local passwords are disabled — users are redirected straight to
# Authelia on login.  User attributes (localpart, display name, email)
# are automatically imported from the OIDC provider.
#
# Ingress is disabled in the chart — openkrill.ingress.routes handles
# all external routing via Gateway API HTTPRoutes instead.
{ lib, charts, kubelib, cfg, domain, providerID, clientSecret, autheliaIssuer, elementClientID }:
let
  defaults = {
    # ── Matrix identity ───────────────────────────────────────────────
    serverName = cfg.serverName;

    # ── Synapse homeserver ────────────────────────────────────────────
    synapse = {
      ingress = { host = "chat.${cfg.serverName}"; enabled = false; };
      persistence.storageClass = "local-path";
    };

    # ── PostgreSQL (built-in) ─────────────────────────────────────────
    postgres = {
      persistence.storageClass = "local-path";
    };

    # ── Element Web client ────────────────────────────────────────────
    elementWeb = {
      ingress = { host = "web-chat.${cfg.serverName}"; enabled = false; };
      # Lock to this homeserver and auto-redirect to SSO
      additional."0-openkrill-sso.json" = builtins.toJSON {
        disable_custom_urls = true;
        sso_redirect_options = { immediate = true; };
        oidc_static_clients = {
          "auth-chat.${cfg.serverName}" = {
            client_id = elementClientID;
          };
        };
      };
    };

    # ── Matrix Authentication Service ─────────────────────────────────
    matrixAuthenticationService = {
      ingress = { host = "auth-chat.${cfg.serverName}"; enabled = false; };
      # SSO via Authelia — disable local passwords, auto-provision users
      additional."0-openkrill-sso".config = ''
        upstream_oauth2:
          providers:
            - id: ${providerID}
              human_name: Authelia
              issuer: "${autheliaIssuer}"
              client_id: "matrix-authentication-service"
              client_secret: "${clientSecret}"
              token_endpoint_auth_method: client_secret_basic
              scope: "openid profile email"
              discovery_mode: insecure
              fetch_userinfo: true
              claims_imports:
                skip_confirmation: true
                localpart:
                  action: require
                  template: "{{ user.preferred_username }}"
                displayname:
                  action: force
                  template: "{{ user.name }}"
                email:
                  action: force
                  template: "{{ user.email }}"
        clients:
          - client_id: ${elementClientID}
            client_auth_method: none
            redirect_uris:
              - https://web-chat.${cfg.serverName}/
              - https://web-chat.${cfg.serverName}/?no_universal_links=true
        passwords:
          enabled: false
      '';
    };

    # ── Element Admin console ────────────────────────────────────────
    elementAdmin = {
      ingress = { host = "admin-chat.${cfg.serverName}"; enabled = false; };
    };

    # ── Matrix RTC — disabled by default ──────────────────────────────
    matrixRTC = {
      enabled = false;
    };

    # ── Well-known delegation ─────────────────────────────────────────
    wellKnownDelegation = {
      ingress.host = cfg.serverName;
      ingress.enabled = false;
    };

    # ── Shared ingress settings (disabled — using openkrill routes) ──
    ingress = {
      className = "traefik";
      enabled = false;
    };
  };
in
kubelib.fromHelm {
  name      = "matrix-stack";
  chart     = charts.contrib.element-hq.matrix-stack.versions."26.3.0";
  namespace = cfg.namespace;
  values    = lib.recursiveUpdate defaults cfg.values;
  extraOpts = [ "--skip-schema-validation" ];
}
