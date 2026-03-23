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
  # hostDomain is the base domain used for deriving component hostnames.
  # It may differ from serverName when the server is hosted on a subdomain
  # (e.g. serverName = "chat.example.com", hostDomain = "example.com").
  hostDomain = cfg.hostDomain;

  defaults = {
    # ── Matrix identity ───────────────────────────────────────────────
    serverName = cfg.serverName;

    # ── Synapse homeserver ────────────────────────────────────────────
    synapse = {
      ingress = { host = "chat.${hostDomain}"; enabled = false; };
      persistence.storageClass = "local-path";
    };

    # ── PostgreSQL (built-in) ─────────────────────────────────────────
    postgres = {
      persistence.storageClass = "local-path";
    };

    # ── Element Web client ────────────────────────────────────────────
    elementWeb = {
      ingress = { host = "web-chat.${hostDomain}"; enabled = false; };
      # Lock to this homeserver and auto-redirect to SSO
      additional."0-openkrill-sso.json" = builtins.toJSON {
        disable_custom_urls = true;
        sso_redirect_options = { immediate = true; };
        oidc_static_clients = {
          "auth-chat.${hostDomain}" = {
            client_id = elementClientID;
          };
        };
      };
      # Disable forced session verification prompt
      additional."1-openkrill-overrides.json" = builtins.toJSON {
        force_verification = false;
      };
    };

    # ── Matrix Authentication Service ─────────────────────────────────
    matrixAuthenticationService = {
      ingress = { host = "auth-chat.${hostDomain}"; enabled = false; };
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
              - https://web-chat.${hostDomain}/
              - https://web-chat.${hostDomain}/?no_universal_links=true
        passwords:
          enabled: false
      '';
    } // lib.optionalAttrs (cfg.adminUsers != []) {
      # Declare admin users so MAS grants urn:mas:admin and
      # urn:synapse:admin:* scopes without manual mas-cli promotion.
      additional."1-openkrill-admin".config = ''
        policy:
          data:
            admin_users: ${builtins.toJSON cfg.adminUsers}
      '';
    };

    # ── Element Admin console ────────────────────────────────────────
    elementAdmin = {
      ingress = { host = "admin-chat.${hostDomain}"; enabled = false; };
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
