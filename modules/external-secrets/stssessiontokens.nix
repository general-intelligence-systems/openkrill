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
  RequestParametersModule = types.submodule {
    options = {
      "serialNumber" = mkOption {
        description = "SerialNumber is the identification number of the MFA device that is associated with the IAM user who is making\nthe GetSessionToken call.\nPossible values: hardware device (such as GAHT12345678) or an Amazon Resource Name (ARN) for a virtual device\n(such as arn:aws:iam::123456789012:mfa/user)";
        type = (types.nullOr types.str);
        default = null;
      };
      "sessionDuration" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "tokenCode" = mkOption {
        description = "TokenCode is the value provided by the MFA device, if MFA is required.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkRequestParameters =
    res:
    {
    }
    // optionalAttrs (res."serialNumber" != null) { inherit (res) "serialNumber"; }
    // {
    }
    // optionalAttrs (res."sessionDuration" != null) { inherit (res) "sessionDuration"; }
    // {
    }
    // optionalAttrs (res."tokenCode" != null) { inherit (res) "tokenCode"; }
    // {
    };
  StssessiontokensModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this STSSessionToken resource.";
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
        "requestParameters" = mkOption {
          description = "RequestParameters contains parameters that can be passed to the STS service.";
          type = (types.nullOr RequestParametersModule);
          default = null;
        };
        "role" = mkOption {
          description = "You can assume a role before making calls to the\ndesired AWS service.";
          type = (types.nullOr types.str);
          default = null;
        };
      };
    }
  );
  mkSTSSessionToken = name: res: {
    apiVersion = "generators.external-secrets.io/v1alpha1";
    kind = "STSSessionToken";
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
    // optionalAttrs (res."requestParameters" != null) {
      "requestParameters" = mkRequestParameters res."requestParameters";
    }
    // {
    }
    // optionalAttrs (res."role" != null) { inherit (res) "role"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkSTSSessionToken cfg."stssessiontokens");
in
{
  options.openkrill.apps."external-secrets" = {
    "stssessiontokens" = mkOption {
      type = types.attrsOf StssessiontokensModule;
      default = { };
      description = "STSSessionToken CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."external-secrets".content = allResources;
  };
}
