# Auto-generated openkrill module fragment for argo-workflows
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."argo-workflows";
  compact = filterAttrs (_: v: v != null);
  SensorsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this Sensor resource.";
        };
      };
    }
  );
  mkSensor = name: res: {
    apiVersion = "argoproj.io/v1alpha1";
    kind = "Sensor";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    };
  };
  allResources = (mapAttrsToList mkSensor cfg."sensors");
in
{
  options.openkrill.apps."argo-workflows" = {
    "sensors" = mkOption {
      type = types.attrsOf SensorsModule;
      default = { };
      description = "Sensor CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."argo-workflows".content = allResources;
  };
}
