# CRD fragment: SandboxTemplate (extensions.agents.x-k8s.io/v1alpha1)
# Provides typed options for declaring SandboxTemplate instances.
# Templates define reusable sandbox configurations (pod spec + network policy).
#
# Usage from any module:
#   openkrill.apps.agent-sandbox.sandboxtemplates.my-template = {
#     namespace = "my-ns";
#     podTemplate.spec.containers = [{ name = "agent"; image = "my-agent:v1"; }];
#     networkPolicyManagement = "Managed";
#     networkPolicy.egress = [{ to = [{ ipBlock.cidr = "0.0.0.0/0"; }]; }];
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

  NetworkPolicyModule = types.submodule {
    options = {
      egress = mkOption {
        description = "Egress rules — standard Kubernetes NetworkPolicy egress rules. Passed through as-is.";
        type = types.listOf (types.attrsOf types.anything);
        default = [ ];
      };
      ingress = mkOption {
        description = "Ingress rules — standard Kubernetes NetworkPolicy ingress rules. Passed through as-is.";
        type = types.listOf (types.attrsOf types.anything);
        default = [ ];
      };
    };
  };

  mkNetworkPolicy = res:
    { }
    // optionalAttrs (res.egress != [ ]) { inherit (res) egress; }
    // optionalAttrs (res.ingress != [ ]) { inherit (res) ingress; };

  SandboxtemplatesModule = types.submodule ({ name, ... }: {
    options = {
      namespace = mkOption {
        type = types.str;
        description = "Namespace for this SandboxTemplate resource.";
      };
      podTemplate = mkOption {
        description = "Pod template for sandboxes created from this template.";
        type = PodTemplateModule;
        default = { };
      };
      networkPolicyManagement = mkOption {
        description = "Whether network policy is managed by the controller. 'Managed' creates a NetworkPolicy alongside the sandbox pod; 'Unmanaged' skips it.";
        type = types.enum [ "Managed" "Unmanaged" ];
        default = "Managed";
      };
      networkPolicy = mkOption {
        description = "Network policy rules applied to sandboxes created from this template.";
        type = types.nullOr NetworkPolicyModule;
        default = null;
      };
    };
  });

  mkSandboxTemplate = name: res: {
    apiVersion = "extensions.agents.x-k8s.io/v1alpha1";
    kind = "SandboxTemplate";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec =
      { }
      // optionalAttrs (res.podTemplate.metadata != null || res.podTemplate.spec != { }) {
        podTemplate = mkPodTemplate res.podTemplate;
      }
      // optionalAttrs (res.networkPolicyManagement != "Managed") {
        inherit (res) networkPolicyManagement;
      }
      // optionalAttrs (res.networkPolicy != null) {
        networkPolicy = mkNetworkPolicy res.networkPolicy;
      };
  };

  allResources = mapAttrsToList mkSandboxTemplate cfg.sandboxtemplates;
in
{
  options.openkrill.apps.agent-sandbox = {
    sandboxtemplates = mkOption {
      type = types.attrsOf SandboxtemplatesModule;
      default = { };
      description = "SandboxTemplate CRD instances (extensions.agents.x-k8s.io/v1alpha1).";
    };
  };

  config = mkIf cfg.enable {
    openkrill.manifests.agent-sandbox.content = allResources;
  };
}
