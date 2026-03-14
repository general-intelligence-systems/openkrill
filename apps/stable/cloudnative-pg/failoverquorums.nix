# Auto-generated openkrill module fragment for cloudnative-pg
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."cloudnative-pg";
  compact = filterAttrs (_: v: v != null);
  FailoverquorumsModule = types.submodule (
    { name, ... }:
    {
      freeformType = types.attrsOf types.anything;
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this FailoverQuorum resource.";
        };
        "spec" = mkOption {
          type = types.attrsOf types.anything;
          default = { };
          description = "FailoverQuorum spec (freeform).";
        };
      };
    }
  );
  mkFailoverQuorum = name: res: {
    apiVersion = "postgresql.cnpg.io/v1";
    kind = "FailoverQuorum";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    inherit (res) spec;
  };
  allResources = (mapAttrsToList mkFailoverQuorum cfg."failoverquorums");
in
{
  options.openkrill.apps."cloudnative-pg" = {
    "failoverquorums" = mkOption {
      type = types.attrsOf FailoverquorumsModule;
      default = { };
      description = "FailoverQuorum CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."cloudnative-pg".content = allResources;
  };
}
