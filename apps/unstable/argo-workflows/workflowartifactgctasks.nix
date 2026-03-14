# Auto-generated openkrill module fragment for argo-workflows
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."argo-workflows";
  compact = filterAttrs (_: v: v != null);
  WorkflowartifactgctasksModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this WorkflowArtifactGCTask resource.";
        };
        "artifactsByNode" = mkOption {
          type = (types.attrsOf (types.attrsOf types.anything));
          default = { };
        };
      };
    }
  );
  mkWorkflowArtifactGCTask = name: res: {
    apiVersion = "argoproj.io/v1alpha1";
    kind = "WorkflowArtifactGCTask";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."artifactsByNode" != { }) { inherit (res) "artifactsByNode"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkWorkflowArtifactGCTask cfg."workflowartifactgctasks");
in
{
  options.openkrill.apps."argo-workflows" = {
    "workflowartifactgctasks" = mkOption {
      type = types.attrsOf WorkflowartifactgctasksModule;
      default = { };
      description = "WorkflowArtifactGCTask CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."argo-workflows".content = allResources;
  };
}
