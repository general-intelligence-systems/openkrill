# Auto-generated openkrill module fragment for sealed-secrets
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."sealed-secrets";
  compact = filterAttrs (_: v: v != null);
  TemplateMetadataModule = types.submodule {
    options = {
      "annotations" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "finalizers" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "labels" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "namespace" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTemplateMetadata =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."finalizers" != [ ]) { inherit (res) "finalizers"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  TemplateModule = types.submodule {
    options = {
      "data" = mkOption {
        description = "Keys that should be templated using decrypted data";
        type = (types.attrsOf types.str);
        default = { };
      };
      "metadata" = mkOption {
        description = "Standard object's metadata. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#metadata";
        type = (types.nullOr TemplateMetadataModule);
        default = null;
      };
      "type" = mkOption {
        description = "Used to facilitate programmatic handling of secret data.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTemplate =
    res:
    {
    }
    // optionalAttrs (res."data" != { }) { inherit (res) "data"; }
    // {
    }
    // optionalAttrs (res."metadata" != null) { "metadata" = mkTemplateMetadata res."metadata"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  SealedsecretsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this SealedSecret resource.";
        };
        "data" = mkOption {
          description = "Data is deprecated and will be removed eventually. Use per-value EncryptedData instead.";
          type = (types.nullOr types.str);
          default = null;
        };
        "encryptedData" = mkOption {
          type = (types.attrsOf types.str);
        };
        "template" = mkOption {
          description = "Template defines the structure of the Secret that will be created from this sealed secret.";
          type = (types.nullOr TemplateModule);
          default = null;
        };
      };
    }
  );
  mkSealedSecret = name: res: {
    apiVersion = "bitnami.com/v1alpha1";
    kind = "SealedSecret";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."data" != null) { inherit (res) "data"; }
    // {
      inherit (res) "encryptedData";
    }
    // optionalAttrs (res."template" != null) { "template" = mkTemplate res."template"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkSealedSecret cfg."sealedsecrets");
in
{
  options.openkrill.apps."sealed-secrets" = {
    "sealedsecrets" = mkOption {
      type = types.attrsOf SealedsecretsModule;
      default = { };
      description = "SealedSecret CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."sealed-secrets".content = allResources;
  };
}
