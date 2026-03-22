# Helm values for the general-intelligence-systems/guacamole chart.
#
# Deploys paired guacamole + guacd containers with an internal PostgreSQL
# database.  The chart's built-in ingress and ingress-nginx sub-chart are
# disabled — openkrill manages routing via Gateway API / Traefik.
{ lib, charts, kubelib, cfg }:
let
  defaults = {
    # Disable the chart's built-in ingress and ingress-nginx sub-chart
    # — ingress is managed externally via openkrill routing.
    ingress.enabled = false;
    "ingress-nginx".enabled = false;

    # Enable internal PostgreSQL with local-path storage by default.
    postgres.enabled = true;
    postgres.pvc.storageClassName = "local-path";
  };
in
kubelib.fromHelm {
  name = "guacamole";
  chart = charts.general-intelligence-systems.guacamole.latest;
  namespace = cfg.namespace;
  values = lib.recursiveUpdate defaults cfg.values;
}
