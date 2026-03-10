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
      "secretRef" = mkOption {
        description = "GCPSMAuthSecretRef defines the reference to a secret containing Google Cloud Platform credentials.";
        type = (types.nullOr AuthSecretRefModule);
        default = null;
      };
      "workloadIdentity" = mkOption {
        description = "GCPWorkloadIdentity defines the configuration for using GCP Workload Identity authentication.";
        type = (types.nullOr AuthWorkloadIdentityModule);
        default = null;
      };
      "workloadIdentityFederation" = mkOption {
        description = "GCPWorkloadIdentityFederation holds the configurations required for generating federated access tokens.";
        type = (types.nullOr AuthWorkloadIdentityFederationModule);
        default = null;
      };
    };
  };
  mkAuth =
    res:
    {
    }
    // optionalAttrs (res."secretRef" != null) { "secretRef" = mkAuthSecretRef res."secretRef"; }
    // {
    }
    // optionalAttrs (res."workloadIdentity" != null) {
      "workloadIdentity" = mkAuthWorkloadIdentity res."workloadIdentity";
    }
    // {
    }
    // optionalAttrs (res."workloadIdentityFederation" != null) {
      "workloadIdentityFederation" = mkAuthWorkloadIdentityFederation res."workloadIdentityFederation";
    }
    // {
    };
  AuthSecretRefModule = types.submodule {
    options = {
      "secretAccessKeySecretRef" = mkOption {
        description = "The SecretAccessKey is used for authentication";
        type = (types.nullOr AuthSecretRefSecretAccessKeySecretRefModule);
        default = null;
      };
    };
  };
  mkAuthSecretRef =
    res:
    {
    }
    // optionalAttrs (res."secretAccessKeySecretRef" != null) {
      "secretAccessKeySecretRef" = mkAuthSecretRefSecretAccessKeySecretRef res."secretAccessKeySecretRef";
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
  AuthWorkloadIdentityFederationAwsSecurityCredentialsAwsCredentialsSecretRefModule =
    types.submodule
      {
        options = {
          "name" = mkOption {
            description = "name of the secret.";
            type = types.str;
          };
          "namespace" = mkOption {
            description = "namespace in which the secret exists. If empty, secret will looked up in local namespace.";
            type = (types.nullOr types.str);
            default = null;
          };
        };
      };
  mkAuthWorkloadIdentityFederationAwsSecurityCredentialsAwsCredentialsSecretRef =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  AuthWorkloadIdentityFederationAwsSecurityCredentialsModule = types.submodule {
    options = {
      "awsCredentialsSecretRef" = mkOption {
        description = "awsCredentialsSecretRef is the reference to the secret which holds the AWS credentials.\nSecret should be created with below names for keys\n- aws_access_key_id: Access Key ID, which is the unique identifier for the AWS account or the IAM user.\n- aws_secret_access_key: Secret Access Key, which is used to authenticate requests made to AWS services.\n- aws_session_token: Session Token, is the short-lived token to authenticate requests made to AWS services.";
        type = AuthWorkloadIdentityFederationAwsSecurityCredentialsAwsCredentialsSecretRefModule;
      };
      "region" = mkOption {
        description = "region is for configuring the AWS region to be used.";
        type = types.str;
      };
    };
  };
  mkAuthWorkloadIdentityFederationAwsSecurityCredentials = res: {
    "awsCredentialsSecretRef" =
      mkAuthWorkloadIdentityFederationAwsSecurityCredentialsAwsCredentialsSecretRef
        res."awsCredentialsSecretRef";
    inherit (res) "region";
  };
  AuthWorkloadIdentityFederationCredConfigModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key name holding the external account credential config.";
        type = types.str;
      };
      "name" = mkOption {
        description = "name of the configmap.";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "namespace in which the configmap exists. If empty, configmap will looked up in local namespace.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkAuthWorkloadIdentityFederationCredConfig =
    res:
    {
      inherit (res) "key";
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  AuthWorkloadIdentityFederationModule = types.submodule {
    options = {
      "audience" = mkOption {
        description = "audience is the Secure Token Service (STS) audience which contains the resource name for the workload identity pool and the provider identifier in that pool.\nIf specified, Audience found in the external account credential config will be overridden with the configured value.\naudience must be provided when serviceAccountRef or awsSecurityCredentials is configured.";
        type = (types.nullOr types.str);
        default = null;
      };
      "awsSecurityCredentials" = mkOption {
        description = "awsSecurityCredentials is for configuring AWS region and credentials to use for obtaining the access token,\nwhen using the AWS metadata server is not an option.";
        type = (types.nullOr AuthWorkloadIdentityFederationAwsSecurityCredentialsModule);
        default = null;
      };
      "credConfig" = mkOption {
        description = "credConfig holds the configmap reference containing the GCP external account credential configuration in JSON format and the key name containing the json data.\nFor using Kubernetes cluster as the identity provider, use serviceAccountRef instead. Operators mounted serviceaccount token cannot be used as the token source, instead\nserviceAccountRef must be used by providing operators service account details.";
        type = (types.nullOr AuthWorkloadIdentityFederationCredConfigModule);
        default = null;
      };
      "externalTokenEndpoint" = mkOption {
        description = "externalTokenEndpoint is the endpoint explicitly set up to provide tokens, which will be matched against the\ncredential_source.url in the provided credConfig. This field is merely to double-check the external token source\nURL is having the expected value.";
        type = (types.nullOr types.str);
        default = null;
      };
      "serviceAccountRef" = mkOption {
        description = "serviceAccountRef is the reference to the kubernetes ServiceAccount to be used for obtaining the tokens,\nwhen Kubernetes is configured as provider in workload identity pool.";
        type = (types.nullOr AuthWorkloadIdentityFederationServiceAccountRefModule);
        default = null;
      };
    };
  };
  mkAuthWorkloadIdentityFederation =
    res:
    {
    }
    // optionalAttrs (res."audience" != null) { inherit (res) "audience"; }
    // {
    }
    // optionalAttrs (res."awsSecurityCredentials" != null) {
      "awsSecurityCredentials" =
        mkAuthWorkloadIdentityFederationAwsSecurityCredentials
          res."awsSecurityCredentials";
    }
    // {
    }
    // optionalAttrs (res."credConfig" != null) {
      "credConfig" = mkAuthWorkloadIdentityFederationCredConfig res."credConfig";
    }
    // {
    }
    // optionalAttrs (res."externalTokenEndpoint" != null) { inherit (res) "externalTokenEndpoint"; }
    // {
    }
    // optionalAttrs (res."serviceAccountRef" != null) {
      "serviceAccountRef" = mkAuthWorkloadIdentityFederationServiceAccountRef res."serviceAccountRef";
    }
    // {
    };
  AuthWorkloadIdentityFederationServiceAccountRefModule = types.submodule {
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
  mkAuthWorkloadIdentityFederationServiceAccountRef =
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
  AuthWorkloadIdentityModule = types.submodule {
    options = {
      "clusterLocation" = mkOption {
        type = types.str;
      };
      "clusterName" = mkOption {
        type = types.str;
      };
      "clusterProjectID" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "serviceAccountRef" = mkOption {
        description = "ServiceAccountSelector is a reference to a ServiceAccount resource.";
        type = AuthWorkloadIdentityServiceAccountRefModule;
      };
    };
  };
  mkAuthWorkloadIdentity =
    res:
    {
      inherit (res) "clusterLocation";
      inherit (res) "clusterName";
    }
    // optionalAttrs (res."clusterProjectID" != null) { inherit (res) "clusterProjectID"; }
    // {
      "serviceAccountRef" = mkAuthWorkloadIdentityServiceAccountRef res."serviceAccountRef";
    };
  AuthWorkloadIdentityServiceAccountRefModule = types.submodule {
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
  mkAuthWorkloadIdentityServiceAccountRef =
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
  GcraccesstokensModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this GCRAccessToken resource.";
        };
        "auth" = mkOption {
          description = "Auth defines the means for authenticating with GCP";
          type = AuthModule;
        };
        "projectID" = mkOption {
          description = "ProjectID defines which project to use to authenticate with";
          type = types.str;
        };
      };
    }
  );
  mkGCRAccessToken = name: res: {
    apiVersion = "generators.external-secrets.io/v1alpha1";
    kind = "GCRAccessToken";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
      "auth" = mkAuth res."auth";
      inherit (res) "projectID";
    };
  };
  allResources = (mapAttrsToList mkGCRAccessToken cfg."gcraccesstokens");
in
{
  options.openkrill.apps."external-secrets" = {
    "gcraccesstokens" = mkOption {
      type = types.attrsOf GcraccesstokensModule;
      default = { };
      description = "GCRAccessToken CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."external-secrets".content = allResources;
  };
}
