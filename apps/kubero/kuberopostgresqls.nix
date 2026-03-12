# Auto-generated openkrill module fragment for kubero
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."kubero";
  compact = filterAttrs (_: v: v != null);
  KuberopostgresqlsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this KuberoPostgresql resource.";
        };
      };
    }
  );
  mkKuberoPostgresql = name: res: {
    apiVersion = "application.kubero.dev/v1alpha1";
    kind = "KuberoPostgresql";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    };
  };
  allResources = (mapAttrsToList mkKuberoPostgresql cfg."kuberopostgresqls");
in
{
  options.openkrill.apps."kubero" = {
    "kuberopostgresqls" = mkOption {
      type = types.attrsOf KuberopostgresqlsModule;
      default = { };
      description = "KuberoPostgresql CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."kubero".content = allResources;
  };
}
