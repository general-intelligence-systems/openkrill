# Auto-generated openkrill module fragment for kubero
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."kubero";
  compact = filterAttrs (_: v: v != null);
  KuberomongodbsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this KuberoMongoDB resource.";
        };
      };
    }
  );
  mkKuberoMongoDB = name: res: {
    apiVersion = "application.kubero.dev/v1alpha1";
    kind = "KuberoMongoDB";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    };
  };
  allResources = (mapAttrsToList mkKuberoMongoDB cfg."kuberomongodbs");
in
{
  options.openkrill.apps."kubero" = {
    "kuberomongodbs" = mkOption {
      type = types.attrsOf KuberomongodbsModule;
      default = { };
      description = "KuberoMongoDB CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."kubero".content = allResources;
  };
}
