{ lib, charts, kubelib, cfg }:
let
  defaults = {
    # Disable the default Longhorn UI ingress — ingress is managed
    # externally via the openkrill routing layer.
    ingress.enabled = false;
  };
in
kubelib.fromHelm {
  name = "longhorn";
  chart = charts.longhorn.longhorn.latest;
  namespace = cfg.namespace;
  values = lib.recursiveUpdate defaults cfg.values;
}
