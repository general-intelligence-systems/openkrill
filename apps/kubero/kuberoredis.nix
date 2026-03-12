# Auto-generated openkrill module fragment for kubero
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."kubero";
  compact = filterAttrs (_: v: v != null);
  KuberoredisModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this KuberoRedis resource.";
        };
      };
    }
  );
  mkKuberoRedis = name: res: {
    apiVersion = "application.kubero.dev/v1alpha1";
    kind = "KuberoRedis";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    };
  };
  allResources = (mapAttrsToList mkKuberoRedis cfg."kuberoredis");
in
{
  options.openkrill.apps."kubero" = {
    "kuberoredis" = mkOption {
      type = types.attrsOf KuberoredisModule;
      default = { };
      description = "KuberoRedis CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."kubero".content = allResources;
  };
}
