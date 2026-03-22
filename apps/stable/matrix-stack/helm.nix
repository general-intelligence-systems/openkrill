# Helm values for the element-hq/matrix-stack chart.
#
# The chart deploys a complete Matrix stack: Synapse (homeserver),
# Element Web (client), Matrix Authentication Service (MAS), and
# optionally Matrix RTC (VoIP).  Each component has its own ingress.
#
# The chart includes a built-in PostgreSQL for quick setup.  For
# production use, override synapse.postgres and
# matrixAuthenticationService.postgres via values to point at an
# external database (e.g. the shared CNPG cluster).
#
# Ingress is disabled in the chart — openkrill.ingress.routes handles
# all external routing via Gateway API HTTPRoutes instead.
{ lib, charts, kubelib, cfg, domain }:
let
  defaults = {
    # ── Matrix identity ───────────────────────────────────────────────
    # The server name appears in user IDs (@user:serverName).
    # Cannot be changed after initial deployment.
    serverName = cfg.serverName;

    # ── Synapse homeserver ────────────────────────────────────────────
    synapse = {
      ingress.host = "chat.${domain}";
      ingress.enabled = false;
      persistence.storageClass = "local-path";
    };

    # ── PostgreSQL (built-in) ─────────────────────────────────────────
    postgres = {
      persistence.storageClass = "local-path";
    };

    # ── Element Web client ────────────────────────────────────────────
    elementWeb = {
      ingress.host = "web.chat.${domain}";
      ingress.enabled = false;
    };

    # ── Matrix Authentication Service ─────────────────────────────────
    matrixAuthenticationService = {
      ingress.host = "matrix-auth.${domain}";
      ingress.enabled = false;
    };

    # ── Element Admin console ────────────────────────────────────────
    elementAdmin = {
      ingress.host = "admin.chat.${domain}";
      ingress.enabled = false;
    };

    # ── Matrix RTC — disabled by default ──────────────────────────────
    # Enable via values if VoIP/Element Call is needed.
    matrixRTC = {
      enabled = false;
    };

    # ── Well-known delegation ─────────────────────────────────────────
    # Serves /.well-known/matrix/* from the serverName domain for
    # client and federation discovery.
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
