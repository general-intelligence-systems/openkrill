# CRD fragment: SandboxClaim (extensions.agents.x-k8s.io/v1alpha1)
# Provides typed options for declaring SandboxClaim instances.
# Claims request a sandbox from a SandboxTemplate, optionally with
# lifecycle controls (shutdown policy and time).
#
# Usage from any module:
#   openkrill.apps.agent-sandbox.sandboxclaims.my-claim = {
#     namespace = "my-ns";
#     sandboxTemplateRef = "my-template";
#     lifecycle.shutdownPolicy = "Delete";
#   };
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps.agent-sandbox;

  LifecycleModule = types.submodule {
    options = {
      shutdownPolicy = mkOption {
        description = "What happens when the claim is deleted. 'Delete' removes the sandbox; 'Retain' keeps it.";
        type = types.enum [ "Delete" "Retain" ];
        default = "Retain";
      };
      shutdownTime = mkOption {
        description = "ISO 8601 date-time after which the sandbox should be shut down.";
        type = types.nullOr types.str;
        default = null;
      };
    };
  };

  mkLifecycle = res:
    { }
    // optionalAttrs (res.shutdownPolicy != "Retain") { inherit (res) shutdownPolicy; }
    // optionalAttrs (res.shutdownTime != null) { inherit (res) shutdownTime; };

  SandboxclaimsModule = types.submodule ({ name, ... }: {
    options = {
      namespace = mkOption {
        type = types.str;
        description = "Namespace for this SandboxClaim resource.";
      };
      sandboxTemplateRef = mkOption {
        description = "Name of the SandboxTemplate to claim a sandbox from.";
        type = types.str;
      };
      lifecycle = mkOption {
        description = "Lifecycle controls for the claimed sandbox.";
        type = types.nullOr LifecycleModule;
        default = null;
      };
    };
  });

  mkSandboxClaim = name: res: {
    apiVersion = "extensions.agents.x-k8s.io/v1alpha1";
    kind = "SandboxClaim";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
      sandboxTemplateRef = { name = res.sandboxTemplateRef; };
    }
    // optionalAttrs (res.lifecycle != null) {
      lifecycle = mkLifecycle res.lifecycle;
    };
  };

  allResources = mapAttrsToList mkSandboxClaim cfg.sandboxclaims;
in
{
  options.openkrill.apps.agent-sandbox = {
    sandboxclaims = mkOption {
      type = types.attrsOf SandboxclaimsModule;
      default = { };
      description = "SandboxClaim CRD instances (extensions.agents.x-k8s.io/v1alpha1).";
    };
  };

  config = mkIf cfg.enable {
    openkrill.manifests.agent-sandbox.content = allResources;
  };
}
