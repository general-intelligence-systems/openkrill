# Core agent-sandbox chart: Sandbox CRD, controller deployment, RBAC, and service.
{ lib, charts, kubelib, cfg }:
let
  defaults = { };
in
kubelib.fromHelm {
  name = "agent-sandbox";
  chart = charts.general-intelligence-systems.agent-sandbox.latest;
  namespace = cfg.namespace;
  values = lib.recursiveUpdate defaults cfg.values;
}
