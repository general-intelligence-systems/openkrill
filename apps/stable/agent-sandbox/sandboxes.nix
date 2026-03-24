# CRD fragment: Sandbox (agents.x-k8s.io/v1alpha1)
# Provides typed options for declaring Sandbox instances.
# The Sandbox CRD manages isolated, stateful, singleton workloads.
#
# Usage from any module:
#   openkrill.apps.agent-sandbox.sandboxes.my-sandbox = {
#     namespace = "my-ns";
#     podTemplate.spec.containers = [{ name = "main"; image = "my-image:latest"; }];
#   };
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps.agent-sandbox;

  PodTemplateMetadataModule = types.submodule {
    options = {
      annotations = mkOption {
        description = "Annotations to set on the sandbox pod.";
        type = types.attrsOf types.str;
        default = { };
      };
      labels = mkOption {
        description = "Labels to set on the sandbox pod.";
        type = types.attrsOf types.str;
        default = { };
      };
    };
  };

  mkPodTemplateMetadata = res:
    { }
    // optionalAttrs (res.annotations != { }) { inherit (res) annotations; }
    // optionalAttrs (res.labels != { }) { inherit (res) labels; };

  PodTemplateModule = types.submodule {
    options = {
      metadata = mkOption {
        description = "Pod metadata (labels, annotations).";
        type = types.nullOr PodTemplateMetadataModule;
        default = null;
      };
      spec = mkOption {
        description = "Pod spec — standard Kubernetes PodSpec (containers, volumes, etc.). Passed through as-is.";
        type = types.attrsOf types.anything;
        default = { };
      };
    };
  };

  mkPodTemplate = res:
    { }
    // optionalAttrs (res.metadata != null) { metadata = mkPodTemplateMetadata res.metadata; }
    // optionalAttrs (res.spec != { }) { inherit (res) spec; };

  SandboxesModule = types.submodule ({ name, ... }: {
    options = {
      namespace = mkOption {
        type = types.str;
        description = "Namespace for this Sandbox resource.";
      };
      podTemplate = mkOption {
        description = "Pod template for the sandbox workload. Contains metadata (labels/annotations) and a standard Kubernetes PodSpec.";
        type = PodTemplateModule;
        default = { };
      };
    };
  });

  mkSandbox = name: res: {
    apiVersion = "agents.x-k8s.io/v1alpha1";
    kind = "Sandbox";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec =
      { }
      // optionalAttrs (res.podTemplate.metadata != null || res.podTemplate.spec != { }) {
        podTemplate = mkPodTemplate res.podTemplate;
      };
  };

  allResources = mapAttrsToList mkSandbox cfg.sandboxes;
in
{
  options.openkrill.apps.agent-sandbox = {
    sandboxes = mkOption {
      type = types.attrsOf SandboxesModule;
      default = { };
      description = "Sandbox CRD instances (agents.x-k8s.io/v1alpha1).";
    };
  };

  config = mkIf cfg.enable {
    openkrill.manifests.agent-sandbox.content = allResources;
  };
}
