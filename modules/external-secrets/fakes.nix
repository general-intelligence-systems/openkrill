# Auto-generated openkrill module fragment for external-secrets
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."external-secrets";
  compact = filterAttrs (_: v: v != null);
  FakesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this Fake resource.";
        };
        "controller" = mkOption {
          description = "Used to select the correct ESO controller (think: ingress.ingressClassName)\nThe ESO controller is instantiated with a specific controller name and filters VDS based on this property";
          type = (types.nullOr types.str);
          default = null;
        };
        "data" = mkOption {
          description = "Data defines the static data returned\nby this generator.";
          type = (types.attrsOf types.str);
          default = { };
        };
      };
    }
  );
  mkFake = name: res: {
    apiVersion = "generators.external-secrets.io/v1alpha1";
    kind = "Fake";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."controller" != null) { inherit (res) "controller"; }
    // {
    }
    // optionalAttrs (res."data" != { }) { inherit (res) "data"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkFake cfg."fakes");
in
{
  options.openkrill.apps."external-secrets" = {
    "fakes" = mkOption {
      type = types.attrsOf FakesModule;
      default = { };
      description = "Fake CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."external-secrets".content = allResources;
  };
}
