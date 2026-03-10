# Auto-generated openkrill module fragment for external-secrets
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."external-secrets";
  compact = filterAttrs (_: v: v != null);
  UuidsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this UUID resource.";
        };
      };
    }
  );
  mkUUID = name: res: {
    apiVersion = "generators.external-secrets.io/v1alpha1";
    kind = "UUID";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    };
  };
  allResources = (mapAttrsToList mkUUID cfg."uuids");
in
{
  options.openkrill.apps."external-secrets" = {
    "uuids" = mkOption {
      type = types.attrsOf UuidsModule;
      default = { };
      description = "UUID CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."external-secrets".content = allResources;
  };
}
