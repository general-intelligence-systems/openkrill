# Auto-generated openkrill module fragment for argo-workflows
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."argo-workflows";
  compact = filterAttrs (_: v: v != null);
  WorkflowtaskresultsModule = types.submodule (
    { name, ... }:
    {
      freeformType = types.attrsOf types.anything;
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this WorkflowTaskResult resource.";
        };
        "spec" = mkOption {
          type = types.attrsOf types.anything;
          default = { };
          description = "WorkflowTaskResult spec (freeform).";
        };
      };
    }
  );
  mkWorkflowTaskResult = name: res: {
    apiVersion = "argoproj.io/v1alpha1";
    kind = "WorkflowTaskResult";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    inherit (res) spec;
  };
  allResources = (mapAttrsToList mkWorkflowTaskResult cfg."workflowtaskresults");
in
{
  options.openkrill.apps."argo-workflows" = {
    "workflowtaskresults" = mkOption {
      type = types.attrsOf WorkflowtaskresultsModule;
      default = { };
      description = "WorkflowTaskResult CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."argo-workflows".content = allResources;
  };
}
