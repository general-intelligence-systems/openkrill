# CRD fragment: SandboxWarmPool (extensions.agents.x-k8s.io/v1alpha1)
# Provides typed options for declaring SandboxWarmPool instances.
# Warm pools pre-provision idle sandboxes from a template so claims
# can be fulfilled instantly without waiting for pod startup.
#
# Usage from any module:
#   openkrill.apps.agent-sandbox.sandboxwarmpools.my-pool = {
#     namespace = "my-ns";
#     replicas = 3;
#     sandboxTemplateRef = "my-template";
#   };
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps.agent-sandbox;

  SandboxwarmpoolsModule = types.submodule ({ name, ... }: {
    options = {
      namespace = mkOption {
        type = types.str;
        description = "Namespace for this SandboxWarmPool resource.";
      };
      replicas = mkOption {
        description = "Number of pre-provisioned idle sandboxes to maintain in the pool.";
        type = types.int;
      };
      sandboxTemplateRef = mkOption {
        description = "Name of the SandboxTemplate to use for pool members.";
        type = types.str;
      };
    };
  });

  mkSandboxWarmPool = name: res: {
    apiVersion = "extensions.agents.x-k8s.io/v1alpha1";
    kind = "SandboxWarmPool";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
      inherit (res) replicas;
      sandboxTemplateRef = { name = res.sandboxTemplateRef; };
    };
  };

  allResources = mapAttrsToList mkSandboxWarmPool cfg.sandboxwarmpools;
in
{
  options.openkrill.apps.agent-sandbox = {
    sandboxwarmpools = mkOption {
      type = types.attrsOf SandboxwarmpoolsModule;
      default = { };
      description = "SandboxWarmPool CRD instances (extensions.agents.x-k8s.io/v1alpha1).";
    };
  };

  config = mkIf cfg.enable {
    openkrill.manifests.agent-sandbox.content = allResources;
  };
}
