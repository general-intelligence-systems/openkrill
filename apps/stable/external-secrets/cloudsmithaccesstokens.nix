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
  CloudsmithaccesstokensModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this CloudsmithAccessToken resource.";
        };
        "apiUrl" = mkOption {
          description = "APIURL configures the Cloudsmith API URL. Defaults to https://api.cloudsmith.io.";
          type = (types.nullOr types.str);
          default = null;
        };
        "orgSlug" = mkOption {
          description = "OrgSlug is the organization slug in Cloudsmith";
          type = types.str;
        };
        "serviceAccountRef" = mkOption {
          description = "Name of the service account you are federating with";
          type = ServiceAccountRefModule;
        };
        "serviceSlug" = mkOption {
          description = "ServiceSlug is the service slug in Cloudsmith for OIDC authentication";
          type = types.str;
        };
      };
    }
  );
  mkCloudsmithAccessToken = name: res: {
    apiVersion = "generators.external-secrets.io/v1alpha1";
    kind = "CloudsmithAccessToken";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."apiUrl" != null) { inherit (res) "apiUrl"; }
    // {
      inherit (res) "orgSlug";
      "serviceAccountRef" = mkServiceAccountRef res."serviceAccountRef";
      inherit (res) "serviceSlug";
    };
  };
  allResources = (mapAttrsToList mkCloudsmithAccessToken cfg."cloudsmithaccesstokens");
in
{
  options.openkrill.apps."external-secrets" = {
    "cloudsmithaccesstokens" = mkOption {
      type = types.attrsOf CloudsmithaccesstokensModule;
      default = { };
      description = "CloudsmithAccessToken CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."external-secrets".content = allResources;
  };
}
