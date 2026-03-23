# Agent Sandbox extensions chart: SandboxTemplate, SandboxClaim,
# SandboxWarmPool CRDs and extensions controller.
{ lib, charts, kubelib, cfg }:
let
  defaults = { };
in
kubelib.fromHelm {
  name = "agent-sandbox-extensions";
  chart = charts.general-intelligence-systems.agent-sandbox-extensions.latest;
  namespace = cfg.namespace;
  values = lib.recursiveUpdate defaults cfg.extensions.values;
}
