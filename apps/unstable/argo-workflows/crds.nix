# Auto-generated openkrill module fragment for argo-workflows
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."argo-workflows";
  compact = filterAttrs (_: v: v != null);
  ClusterworkflowtemplatesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this ClusterWorkflowTemplate resource.";
        };
      };
    }
  );
  mkClusterWorkflowTemplate = name: res: {
    apiVersion = "argoproj.io/v1alpha1";
    kind = "ClusterWorkflowTemplate";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    };
  };
  allResources = (mapAttrsToList mkClusterWorkflowTemplate cfg."clusterworkflowtemplates");
in
{
  options.openkrill.apps."argo-workflows" = {
    "clusterworkflowtemplates" = mkOption {
      type = types.attrsOf ClusterworkflowtemplatesModule;
      default = { };
      description = "ClusterWorkflowTemplate CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."argo-workflows".content = allResources;
  };
}
