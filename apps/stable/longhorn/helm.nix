{ lib, charts, kubelib, cfg }:
let
  defaults = {
    # Disable the default Longhorn UI ingress — ingress is managed
    # externally via the openkrill routing layer.
    ingress.enabled = false;

    # Default replica count.  On single-node clusters this must be 1;
    # Longhorn cannot schedule more replicas than there are nodes and
    # volumes will be stuck "attaching" / "faulted" otherwise.
    defaultSettings.defaultReplicaCount = 1;

    # The StorageClass `numberOfReplicas` parameter is set independently
    # of the default-replica-count setting above.  Without this, the
    # chart-generated StorageClass defaults to 3 replicas, which cannot
    # be scheduled on a single-node cluster.
    persistence.defaultClassReplicaCount = 1;
  };
in
kubelib.fromHelm {
  name = "longhorn";
  chart = charts.longhorn.longhorn.latest;
  namespace = cfg.namespace;
  values = lib.recursiveUpdate defaults cfg.values;
}
