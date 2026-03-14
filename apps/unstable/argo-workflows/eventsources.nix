# Auto-generated openkrill module fragment for argo-workflows
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."argo-workflows";
  compact = filterAttrs (_: v: v != null);
  EventsourcesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this EventSource resource.";
        };
      };
    }
  );
  mkEventSource = name: res: {
    apiVersion = "argoproj.io/v1alpha1";
    kind = "EventSource";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    };
  };
  allResources = (mapAttrsToList mkEventSource cfg."eventsources");
in
{
  options.openkrill.apps."argo-workflows" = {
    "eventsources" = mkOption {
      type = types.attrsOf EventsourcesModule;
      default = { };
      description = "EventSource CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."argo-workflows".content = allResources;
  };
}
