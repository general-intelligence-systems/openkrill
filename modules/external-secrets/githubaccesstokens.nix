# Auto-generated openkrill module fragment for external-secrets
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."external-secrets";
  compact = filterAttrs (_: v: v != null);
  AuthModule = types.submodule {
    options = {
      "privateKey" = mkOption {
        description = "GithubSecretRef references a secret containing GitHub credentials.";
        type = AuthPrivateKeyModule;
      };
    };
  };
  mkAuth = res: {
    "privateKey" = mkAuthPrivateKey res."privateKey";
  };
  AuthPrivateKeyModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = AuthPrivateKeySecretRefModule;
      };
    };
  };
  mkAuthPrivateKey = res: {
    "secretRef" = mkAuthPrivateKeySecretRef res."secretRef";
  };
  AuthPrivateKeySecretRefModule = types.submodule {
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
  mkAuthPrivateKeySecretRef =
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
  GithubaccesstokensModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this GithubAccessToken resource.";
        };
        "appID" = mkOption {
          type = types.str;
        };
        "auth" = mkOption {
          description = "Auth configures how ESO authenticates with a Github instance.";
          type = AuthModule;
        };
        "installID" = mkOption {
          type = types.str;
        };
        "permissions" = mkOption {
          description = "Map of permissions the token will have. If omitted, defaults to all permissions the GitHub App has.";
          type = (types.attrsOf types.str);
          default = { };
        };
        "repositories" = mkOption {
          description = "List of repositories the token will have access to. If omitted, defaults to all repositories the GitHub App\nis installed to.";
          type = (types.listOf types.str);
          default = [ ];
        };
        "url" = mkOption {
          description = "URL configures the GitHub instance URL. Defaults to https://github.com/.";
          type = (types.nullOr types.str);
          default = null;
        };
      };
    }
  );
  mkGithubAccessToken = name: res: {
    apiVersion = "generators.external-secrets.io/v1alpha1";
    kind = "GithubAccessToken";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
      inherit (res) "appID";
      "auth" = mkAuth res."auth";
      inherit (res) "installID";
    }
    // optionalAttrs (res."permissions" != { }) { inherit (res) "permissions"; }
    // {
    }
    // optionalAttrs (res."repositories" != [ ]) { inherit (res) "repositories"; }
    // {
    }
    // optionalAttrs (res."url" != null) { inherit (res) "url"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkGithubAccessToken cfg."githubaccesstokens");
in
{
  options.openkrill.apps."external-secrets" = {
    "githubaccesstokens" = mkOption {
      type = types.attrsOf GithubaccesstokensModule;
      default = { };
      description = "GithubAccessToken CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."external-secrets".content = allResources;
  };
}
