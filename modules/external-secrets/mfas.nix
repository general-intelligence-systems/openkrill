# Auto-generated openkrill module fragment for external-secrets
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."external-secrets";
  compact = filterAttrs (_: v: v != null);
  SecretModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "A key in the referenced Secret.\nSome instances of this field may be defaulted, in others it may be required.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "The name of the Secret resource being referred to.";
        type = (types.nullOr types.str);
        default = null;
      };
      "namespace" = mkOption {
        description = "The namespace of the Secret resource being referred to.\nIgnored if referent is not cluster-scoped, otherwise defaults to the namespace of the referent.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSecret =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  MfasModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this MFA resource.";
        };
        "algorithm" = mkOption {
          description = "Algorithm to use for encoding. Defaults to SHA1 as per the RFC.";
          type = (types.nullOr types.str);
          default = null;
        };
        "length" = mkOption {
          description = "Length defines the token length. Defaults to 6 characters.";
          type = (types.nullOr types.int);
          default = null;
        };
        "secret" = mkOption {
          description = "Secret is a secret selector to a secret containing the seed secret to generate the TOTP value from.";
          type = SecretModule;
        };
        "timePeriod" = mkOption {
          description = "TimePeriod defines how long the token can be active. Defaults to 30 seconds.";
          type = (types.nullOr types.int);
          default = null;
        };
        "when" = mkOption {
          description = "When defines a time parameter that can be used to pin the origin time of the generated token.";
          type = (types.nullOr types.str);
          default = null;
        };
      };
    }
  );
  mkMFA = name: res: {
    apiVersion = "generators.external-secrets.io/v1alpha1";
    kind = "MFA";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."algorithm" != null) { inherit (res) "algorithm"; }
    // {
    }
    // optionalAttrs (res."length" != null) { inherit (res) "length"; }
    // {
      "secret" = mkSecret res."secret";
    }
    // optionalAttrs (res."timePeriod" != null) { inherit (res) "timePeriod"; }
    // {
    }
    // optionalAttrs (res."when" != null) { inherit (res) "when"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkMFA cfg."mfas");
in
{
  options.openkrill.apps."external-secrets" = {
    "mfas" = mkOption {
      type = types.attrsOf MfasModule;
      default = { };
      description = "MFA CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."external-secrets".content = allResources;
  };
}
