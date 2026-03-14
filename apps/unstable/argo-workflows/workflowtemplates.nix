# Auto-generated openkrill module fragment for argo-workflows
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."argo-workflows";
  compact = filterAttrs (_: v: v != null);
  WorkflowtemplatesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this WorkflowTemplate resource.";
        };
      };
    }
  );
  mkWorkflowTemplate = name: res: {
    apiVersion = "argoproj.io/v1alpha1";
    kind = "WorkflowTemplate";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    };
  };
  allResources = (mapAttrsToList mkWorkflowTemplate cfg."workflowtemplates");
in
{
  options.openkrill.apps."argo-workflows" = {
    "workflowtemplates" = mkOption {
      type = types.attrsOf WorkflowtemplatesModule;
      default = { };
      description = "WorkflowTemplate CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."argo-workflows".content = allResources;
  };
}
