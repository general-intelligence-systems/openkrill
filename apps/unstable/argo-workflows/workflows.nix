# Auto-generated openkrill module fragment for argo-workflows
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."argo-workflows";
  compact = filterAttrs (_: v: v != null);
  WorkflowsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this Workflow resource.";
        };
      };
    }
  );
  mkWorkflow = name: res: {
    apiVersion = "argoproj.io/v1alpha1";
    kind = "Workflow";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    };
  };
  allResources = (mapAttrsToList mkWorkflow cfg."workflows");
in
{
  options.openkrill.apps."argo-workflows" = {
    "workflows" = mkOption {
      type = types.attrsOf WorkflowsModule;
      default = { };
      description = "Workflow CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."argo-workflows".content = allResources;
  };
}
