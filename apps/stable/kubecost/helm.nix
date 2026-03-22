{ lib, charts, kubelib, cfg }:
let
  defaults = {
    # Disable the default ingress — managed externally via openkrill routing.
    ingress.enabled = false;
  };
in
kubelib.fromHelm {
  name = "kubecost";
  chart = charts.kubecost.kubecost.versions."3.1.5-rc.0";
  namespace = cfg.namespace;
  values = lib.recursiveUpdate defaults cfg.values;
}
