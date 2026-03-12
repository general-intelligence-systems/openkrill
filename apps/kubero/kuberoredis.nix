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
        "spec" = mkOption {
          type = types.attrsOf types.anything;
          default = { };
          description = "Spec defines the desired state of this resource. Freeform: the CRD uses x-kubernetes-preserve-unknown-fields.";
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
    spec = res.spec;
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
