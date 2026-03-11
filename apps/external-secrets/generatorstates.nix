# Auto-generated openkrill module fragment for external-secrets
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."external-secrets";
  compact = filterAttrs (_: v: v != null);
  GeneratorstatesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this GeneratorState resource.";
        };
        "garbageCollectionDeadline" = mkOption {
          description = "GarbageCollectionDeadline is the time after which the generator state\nwill be deleted.\nIt is set by the controller which creates the generator state and\ncan be set configured by the user.\nIf the garbage collection deadline is not set the generator state will not be deleted.";
          type = (types.nullOr types.str);
          default = null;
        };
        "resource" = mkOption {
          description = "Resource is the generator manifest that produced the state.\nIt is a snapshot of the generator manifest at the time the state was produced.\nThis manifest will be used to delete the resource. Any configuration that is referenced\nin the manifest should be available at the time of garbage collection. If that is not the case deletion will\nbe blocked by a finalizer.";
          type = types.anything;
        };
        "state" = mkOption {
          description = "State is the state that was produced by the generator implementation.";
          type = types.anything;
        };
      };
    }
  );
  mkGeneratorState = name: res: {
    apiVersion = "generators.external-secrets.io/v1alpha1";
    kind = "GeneratorState";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."garbageCollectionDeadline" != null) {
      inherit (res) "garbageCollectionDeadline";
    }
    // {
      inherit (res) "resource";
      inherit (res) "state";
    };
  };
  allResources = (mapAttrsToList mkGeneratorState cfg."generatorstates");
in
{
  options.openkrill.apps."external-secrets" = {
    "generatorstates" = mkOption {
      type = types.attrsOf GeneratorstatesModule;
      default = { };
      description = "GeneratorState CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."external-secrets".content = allResources;
  };
}
