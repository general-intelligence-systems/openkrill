{ lib, charts, kubelib, cfg }:
let
  defaults = {
    # Disable the default ingress — managed externally via openkrill routing.
    ingress.enabled = false;
  };
in
kubelib.fromHelm {
  name = "kubecost";
  chart = charts.kubecost.kubecost.latest;
  namespace = cfg.namespace;
  values = lib.recursiveUpdate defaults cfg.values;
}
