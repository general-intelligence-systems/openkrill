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
# The chart manages its own Kubernetes Ingress resources — it does
# NOT use openkrill.ingress.routes.  Traefik (via k3s) handles both
# Gateway API and Kubernetes Ingress, so both coexist.
{ lib, charts, kubelib, cfg, domain }:
let
  defaults = {
    # ── Matrix identity ───────────────────────────────────────────────
    # The server name appears in user IDs (@user:serverName).
    # Cannot be changed after initial deployment.
    serverName = cfg.serverName;

    # ── Synapse homeserver ────────────────────────────────────────────
    synapse = {
      ingress.host = "matrix.${domain}";
    };

    # ── Element Web client ────────────────────────────────────────────
    elementWeb = {
      ingress.host = "element.${domain}";
    };

    # ── Matrix Authentication Service ─────────────────────────────────
    matrixAuthenticationService = {
      ingress.host = "account.${domain}";
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
    };

    # ── Shared ingress settings ───────────────────────────────────────
    # Applied to all component ingresses.  Override per-component
    # via values if needed.
    ingress = {
      className = "traefik";
    };
  };
in
kubelib.fromHelm {
  name      = "matrix-stack";
  chart     = charts.element-hq.matrix-stack.latest;
  namespace = cfg.namespace;
  values    = lib.recursiveUpdate defaults cfg.values;
  extraOpts = [ "--skip-schema-validation" ];
}
