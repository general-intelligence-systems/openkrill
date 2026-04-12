# Helm values for the general-intelligence-systems/jambonz chart.
#
# Deploys the full jambonz CPaaS stack: SBC SIP/RTP edge services,
# feature servers, API server, webapp portal, and data stores
# (MySQL, Redis).
#
# The chart's built-in ingress is disabled — openkrill manages
# routing via Gateway API / Traefik.  SBC SIP and RTP DaemonSets
# are configured to run on nodes labelled `jambonz-dedicated=true`
# and tolerate the `jambonz=dedicated:NoSchedule` taint.
{ lib, charts, kubelib, cfg, route }:
let
  defaults = {
    # No managed cloud provider — bare-metal / self-hosted K8s.
    cloud = "none";

    # Derive baseUrl from the openkrill ingress route.
    baseUrl = "${route.subdomain}.${route.domain}";

    # Disable the chart's built-in ingress — openkrill manages
    # routing externally via Gateway API / Traefik.
    global.traefik.tls.enabled = false;

    # ── SBC SIP DaemonSet ──────────────────────────────────────────
    # Schedule on dedicated jambonz nodes with host networking.
    sbc.sip = {
      nodeSelector = { "jambonz-dedicated" = "true"; };
      tolerations = [{
        key      = "jambonz";
        operator = "Equal";
        value    = "dedicated";
        effect   = "NoSchedule";
      }];
    };

    # ── SBC RTP DaemonSet ──────────────────────────────────────────
    # Schedule on the same dedicated jambonz nodes.
    sbc.rtp = {
      nodeSelector = { "jambonz-dedicated" = "true"; };
      tolerations = [{
        key      = "jambonz";
        operator = "Equal";
        value    = "dedicated";
        effect   = "NoSchedule";
      }];
    };

    # Use local-path for persistent volumes by default.
    mysql.storageClassName       = "local-path";
    redis.storageClassName       = "local-path";
    monitoring = {
      postgres.storageClassName  = "local-path";
      grafana.storageClassName   = "local-path";
      influxdb.storageClassName  = "local-path";
      loki.storageClassName      = "local-path";
    };
  };
in
kubelib.fromHelm {
  name      = "jambonz";
  chart     = charts.general-intelligence-systems.jambonz.versions."10.0.0";
  namespace = cfg.namespace;
  values    = lib.recursiveUpdate defaults cfg.values;
}
