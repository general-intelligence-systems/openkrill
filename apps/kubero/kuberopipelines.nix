# Auto-generated openkrill module fragment for kubero
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."kubero";
  compact = filterAttrs (_: v: v != null);
  KuberopipelinesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this KuberoPipeline resource.";
        };
      };
    }
  );
  mkKuberoPipeline = name: res: {
    apiVersion = "application.kubero.dev/v1alpha1";
    kind = "KuberoPipeline";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    };
  };
  allResources = (mapAttrsToList mkKuberoPipeline cfg."kuberopipelines");
in
{
  options.openkrill.apps."kubero" = {
    "kuberopipelines" = mkOption {
      type = types.attrsOf KuberopipelinesModule;
      default = { };
      description = "KuberoPipeline CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."kubero".content = allResources;
  };
}
