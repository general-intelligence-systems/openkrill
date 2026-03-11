# Auto-generated openkrill module fragment for external-secrets
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."external-secrets";
  compact = filterAttrs (_: v: v != null);
  SshkeysModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this SSHKey resource.";
        };
        "comment" = mkOption {
          description = "Comment specifies an optional comment for the SSH key";
          type = (types.nullOr types.str);
          default = null;
        };
        "keySize" = mkOption {
          description = "KeySize specifies the key size for RSA keys (default: 2048) and ECDSA keys (default: 256).\nFor RSA keys: 2048, 3072, 4096\nFor ECDSA keys: 256, 384, 521\nIgnored for ed25519 keys";
          type = (types.nullOr types.int);
          default = null;
        };
        "keyType" = mkOption {
          description = "KeyType specifies the SSH key type (rsa, ecdsa, ed25519)";
          type = (
            types.nullOr (
              types.enum [
                "rsa"
                "ecdsa"
                "ed25519"
              ]
            )
          );
          default = "rsa";
        };
      };
    }
  );
  mkSSHKey = name: res: {
    apiVersion = "generators.external-secrets.io/v1alpha1";
    kind = "SSHKey";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."comment" != null) { inherit (res) "comment"; }
    // {
    }
    // optionalAttrs (res."keySize" != null) { inherit (res) "keySize"; }
    // {
    }
    // optionalAttrs (res."keyType" != null) { inherit (res) "keyType"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkSSHKey cfg."sshkeys");
in
{
  options.openkrill.apps."external-secrets" = {
    "sshkeys" = mkOption {
      type = types.attrsOf SshkeysModule;
      default = { };
      description = "SSHKey CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."external-secrets".content = allResources;
  };
}
