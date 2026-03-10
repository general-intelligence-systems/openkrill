# Auto-generated openkrill module fragment for external-secrets
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."external-secrets";
  compact = filterAttrs (_: v: v != null);
  AuthJwtModule = types.submodule {
    options = {
      "serviceAccountRef" = mkOption {
        description = "ServiceAccountSelector is a reference to a ServiceAccount resource.";
        type = (types.nullOr AuthJwtServiceAccountRefModule);
        default = null;
      };
    };
  };
  mkAuthJwt =
    res:
    {
    }
    // optionalAttrs (res."serviceAccountRef" != null) {
      "serviceAccountRef" = mkAuthJwtServiceAccountRef res."serviceAccountRef";
    }
    // {
    };
  AuthJwtServiceAccountRefModule = types.submodule {
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
  mkAuthJwtServiceAccountRef =
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
  AuthModule = types.submodule {
    options = {
      "jwt" = mkOption {
        description = "AWSJWTAuth provides configuration to authenticate against AWS using service account tokens.";
        type = (types.nullOr AuthJwtModule);
        default = null;
      };
      "secretRef" = mkOption {
        description = "AWSAuthSecretRef holds secret references for AWS credentials\nboth AccessKeyID and SecretAccessKey must be defined in order to properly authenticate.";
        type = (types.nullOr AuthSecretRefModule);
        default = null;
      };
    };
  };
  mkAuth =
    res:
    {
    }
    // optionalAttrs (res."jwt" != null) { "jwt" = mkAuthJwt res."jwt"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) { "secretRef" = mkAuthSecretRef res."secretRef"; }
    // {
    };
  AuthSecretRefAccessKeyIDSecretRefModule = types.submodule {
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
  mkAuthSecretRefAccessKeyIDSecretRef =
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
  AuthSecretRefModule = types.submodule {
    options = {
      "accessKeyIDSecretRef" = mkOption {
        description = "The AccessKeyID is used for authentication";
        type = (types.nullOr AuthSecretRefAccessKeyIDSecretRefModule);
        default = null;
      };
      "secretAccessKeySecretRef" = mkOption {
        description = "The SecretAccessKey is used for authentication";
        type = (types.nullOr AuthSecretRefSecretAccessKeySecretRefModule);
        default = null;
      };
      "sessionTokenSecretRef" = mkOption {
        description = "The SessionToken used for authentication\nThis must be defined if AccessKeyID and SecretAccessKey are temporary credentials\nsee: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_use-resources.html";
        type = (types.nullOr AuthSecretRefSessionTokenSecretRefModule);
        default = null;
      };
    };
  };
  mkAuthSecretRef =
    res:
    {
    }
    // optionalAttrs (res."accessKeyIDSecretRef" != null) {
      "accessKeyIDSecretRef" = mkAuthSecretRefAccessKeyIDSecretRef res."accessKeyIDSecretRef";
    }
    // {
    }
    // optionalAttrs (res."secretAccessKeySecretRef" != null) {
      "secretAccessKeySecretRef" = mkAuthSecretRefSecretAccessKeySecretRef res."secretAccessKeySecretRef";
    }
    // {
    }
    // optionalAttrs (res."sessionTokenSecretRef" != null) {
      "sessionTokenSecretRef" = mkAuthSecretRefSessionTokenSecretRef res."sessionTokenSecretRef";
    }
    // {
    };
  AuthSecretRefSecretAccessKeySecretRefModule = types.submodule {
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
  mkAuthSecretRefSecretAccessKeySecretRef =
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
  AuthSecretRefSessionTokenSecretRefModule = types.submodule {
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
  mkAuthSecretRefSessionTokenSecretRef =
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
  EcrauthorizationtokensModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this ECRAuthorizationToken resource.";
        };
        "auth" = mkOption {
          description = "Auth defines how to authenticate with AWS";
          type = (types.nullOr AuthModule);
          default = null;
        };
        "region" = mkOption {
          description = "Region specifies the region to operate in.";
          type = types.str;
        };
        "role" = mkOption {
          description = "You can assume a role before making calls to the\ndesired AWS service.";
          type = (types.nullOr types.str);
          default = null;
        };
        "scope" = mkOption {
          description = "Scope specifies the ECR service scope.\nValid options are private and public.";
          type = (types.nullOr types.str);
          default = null;
        };
      };
    }
  );
  mkECRAuthorizationToken = name: res: {
    apiVersion = "generators.external-secrets.io/v1alpha1";
    kind = "ECRAuthorizationToken";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."auth" != null) { "auth" = mkAuth res."auth"; }
    // {
      inherit (res) "region";
    }
    // optionalAttrs (res."role" != null) { inherit (res) "role"; }
    // {
    }
    // optionalAttrs (res."scope" != null) { inherit (res) "scope"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkECRAuthorizationToken cfg."ecrauthorizationtokens");
in
{
  options.openkrill.apps."external-secrets" = {
    "ecrauthorizationtokens" = mkOption {
      type = types.attrsOf EcrauthorizationtokensModule;
      default = { };
      description = "ECRAuthorizationToken CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."external-secrets".content = allResources;
  };
}
