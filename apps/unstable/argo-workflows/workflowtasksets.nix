# Auto-generated openkrill module fragment for argo-workflows
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."argo-workflows";
  compact = filterAttrs (_: v: v != null);
  WorkflowtasksetsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this WorkflowTaskSet resource.";
        };
      };
    }
  );
  mkWorkflowTaskSet = name: res: {
    apiVersion = "argoproj.io/v1alpha1";
    kind = "WorkflowTaskSet";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    };
  };
  allResources = (mapAttrsToList mkWorkflowTaskSet cfg."workflowtasksets");
in
{
  options.openkrill.apps."argo-workflows" = {
    "workflowtasksets" = mkOption {
      type = types.attrsOf WorkflowtasksetsModule;
      default = { };
      description = "WorkflowTaskSet CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."argo-workflows".content = allResources;
  };
}
