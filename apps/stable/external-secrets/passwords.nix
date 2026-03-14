# Auto-generated openkrill module fragment for external-secrets
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."external-secrets";
  compact = filterAttrs (_: v: v != null);
  PasswordsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this Password resource.";
        };
        "allowRepeat" = mkOption {
          description = "set AllowRepeat to true to allow repeating characters.";
          type = types.bool;
        };
        "digits" = mkOption {
          description = "Digits specifies the number of digits in the generated\npassword. If omitted it defaults to 25% of the length of the password";
          type = (types.nullOr types.int);
          default = null;
        };
        "encoding" = mkOption {
          description = "Encoding specifies the encoding of the generated password.\nValid values are:\n- \"raw\" (default): no encoding\n- \"base64\": standard base64 encoding\n- \"base64url\": base64url encoding\n- \"base32\": base32 encoding\n- \"hex\": hexadecimal encoding";
          type = (
            types.nullOr (
              types.enum [
                "base64"
                "base64url"
                "base32"
                "hex"
                "raw"
              ]
            )
          );
          default = "raw";
        };
        "length" = mkOption {
          description = "Length of the password to be generated.\nDefaults to 24";
          type = types.int;
        };
        "noUpper" = mkOption {
          description = "Set NoUpper to disable uppercase characters";
          type = types.bool;
        };
        "secretKeys" = mkOption {
          description = "SecretKeys defines the keys that will be populated with generated passwords.\nDefaults to \"password\" when not set.";
          type = (types.listOf types.str);
          default = [ ];
        };
        "symbolCharacters" = mkOption {
          description = "SymbolCharacters specifies the special characters that should be used\nin the generated password.";
          type = (types.nullOr types.str);
          default = null;
        };
        "symbols" = mkOption {
          description = "Symbols specifies the number of symbol characters in the generated\npassword. If omitted it defaults to 25% of the length of the password";
          type = (types.nullOr types.int);
          default = null;
        };
      };
    }
  );
  mkPassword = name: res: {
    apiVersion = "generators.external-secrets.io/v1alpha1";
    kind = "Password";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
      inherit (res) "allowRepeat";
    }
    // optionalAttrs (res."digits" != null) { inherit (res) "digits"; }
    // {
    }
    // optionalAttrs (res."encoding" != null) { inherit (res) "encoding"; }
    // {
      inherit (res) "length";
      inherit (res) "noUpper";
    }
    // optionalAttrs (res."secretKeys" != [ ]) { inherit (res) "secretKeys"; }
    // {
    }
    // optionalAttrs (res."symbolCharacters" != null) { inherit (res) "symbolCharacters"; }
    // {
    }
    // optionalAttrs (res."symbols" != null) { inherit (res) "symbols"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkPassword cfg."passwords");
in
{
  options.openkrill.apps."external-secrets" = {
    "passwords" = mkOption {
      type = types.attrsOf PasswordsModule;
      default = { };
      description = "Password CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."external-secrets".content = allResources;
  };
}
