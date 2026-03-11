# Auto-generated openkrill module fragment for external-secrets
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."external-secrets";
  compact = filterAttrs (_: v: v != null);
  ServiceAccountRefModule = types.submodule {
    options = {
      "audiences" = mkOption {
        description = "Audience specifies the `aud` claim for the service account token\nIf the service account uses a well-known annotation for e.g. IRSA or GCP Workload Identity\nthen this audiences will be appended to the list";
        type = (types.listOf types.str);
        default = [ ];
      };
      "name" = mkOption {
        description = "The name of the ServiceAccount resource being referred to.";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "Namespace of the resource being referred to.\nIgnored if referent is not cluster-scoped, otherwise defaults to the namespace of the referent.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkServiceAccountRef =
    res:
    {
    }
    // optionalAttrs (res."audiences" != [ ]) { inherit (res) "audiences"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  QuayaccesstokensModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this QuayAccessToken resource.";
        };
        "robotAccount" = mkOption {
          description = "Name of the robot account you are federating with";
          type = types.str;
        };
        "serviceAccountRef" = mkOption {
          description = "Name of the service account you are federating with";
          type = ServiceAccountRefModule;
        };
        "url" = mkOption {
          description = "URL configures the Quay instance URL. Defaults to quay.io.";
          type = (types.nullOr types.str);
          default = null;
        };
      };
    }
  );
  mkQuayAccessToken = name: res: {
    apiVersion = "generators.external-secrets.io/v1alpha1";
    kind = "QuayAccessToken";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
      inherit (res) "robotAccount";
      "serviceAccountRef" = mkServiceAccountRef res."serviceAccountRef";
    }
    // optionalAttrs (res."url" != null) { inherit (res) "url"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkQuayAccessToken cfg."quayaccesstokens");
in
{
  options.openkrill.apps."external-secrets" = {
    "quayaccesstokens" = mkOption {
      type = types.attrsOf QuayaccesstokensModule;
      default = { };
      description = "QuayAccessToken CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."external-secrets".content = allResources;
  };
}
