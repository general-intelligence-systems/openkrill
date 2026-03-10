# Auto-generated openkrill module fragment for external-secrets
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."external-secrets";
  compact = filterAttrs (_: v: v != null);
  GeneratorAcrAccessTokenSpecAuthManagedIdentityModule = types.submodule {
    options = {
      "identityId" = mkOption {
        description = "If multiple Managed Identity is assigned to the pod, you can select the one to be used";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkGeneratorAcrAccessTokenSpecAuthManagedIdentity =
    res:
    {
    }
    // optionalAttrs (res."identityId" != null) { inherit (res) "identityId"; }
    // {
    };
  GeneratorAcrAccessTokenSpecAuthModule = types.submodule {
    options = {
      "managedIdentity" = mkOption {
        description = "ManagedIdentity uses Azure Managed Identity to authenticate with Azure.";
        type = (types.nullOr GeneratorAcrAccessTokenSpecAuthManagedIdentityModule);
        default = null;
      };
      "servicePrincipal" = mkOption {
        description = "ServicePrincipal uses Azure Service Principal credentials to authenticate with Azure.";
        type = (types.nullOr GeneratorAcrAccessTokenSpecAuthServicePrincipalModule);
        default = null;
      };
      "workloadIdentity" = mkOption {
        description = "WorkloadIdentity uses Azure Workload Identity to authenticate with Azure.";
        type = (types.nullOr GeneratorAcrAccessTokenSpecAuthWorkloadIdentityModule);
        default = null;
      };
    };
  };
  mkGeneratorAcrAccessTokenSpecAuth =
    res:
    {
    }
    // optionalAttrs (res."managedIdentity" != null) {
      "managedIdentity" = mkGeneratorAcrAccessTokenSpecAuthManagedIdentity res."managedIdentity";
    }
    // {
    }
    // optionalAttrs (res."servicePrincipal" != null) {
      "servicePrincipal" = mkGeneratorAcrAccessTokenSpecAuthServicePrincipal res."servicePrincipal";
    }
    // {
    }
    // optionalAttrs (res."workloadIdentity" != null) {
      "workloadIdentity" = mkGeneratorAcrAccessTokenSpecAuthWorkloadIdentity res."workloadIdentity";
    }
    // {
    };
  GeneratorAcrAccessTokenSpecAuthServicePrincipalModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "AzureACRServicePrincipalAuthSecretRef defines the secret references for Azure Service Principal authentication.\nIt uses static credentials stored in a Kind=Secret.";
        type = GeneratorAcrAccessTokenSpecAuthServicePrincipalSecretRefModule;
      };
    };
  };
  mkGeneratorAcrAccessTokenSpecAuthServicePrincipal = res: {
    "secretRef" = mkGeneratorAcrAccessTokenSpecAuthServicePrincipalSecretRef res."secretRef";
  };
  GeneratorAcrAccessTokenSpecAuthServicePrincipalSecretRefClientIdModule = types.submodule {
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
  mkGeneratorAcrAccessTokenSpecAuthServicePrincipalSecretRefClientId =
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
  GeneratorAcrAccessTokenSpecAuthServicePrincipalSecretRefClientSecretModule = types.submodule {
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
  mkGeneratorAcrAccessTokenSpecAuthServicePrincipalSecretRefClientSecret =
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
  GeneratorAcrAccessTokenSpecAuthServicePrincipalSecretRefModule = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "The Azure clientId of the service principle used for authentication.";
        type = (types.nullOr GeneratorAcrAccessTokenSpecAuthServicePrincipalSecretRefClientIdModule);
        default = null;
      };
      "clientSecret" = mkOption {
        description = "The Azure ClientSecret of the service principle used for authentication.";
        type = (types.nullOr GeneratorAcrAccessTokenSpecAuthServicePrincipalSecretRefClientSecretModule);
        default = null;
      };
    };
  };
  mkGeneratorAcrAccessTokenSpecAuthServicePrincipalSecretRef =
    res:
    {
    }
    // optionalAttrs (res."clientId" != null) {
      "clientId" = mkGeneratorAcrAccessTokenSpecAuthServicePrincipalSecretRefClientId res."clientId";
    }
    // {
    }
    // optionalAttrs (res."clientSecret" != null) {
      "clientSecret" =
        mkGeneratorAcrAccessTokenSpecAuthServicePrincipalSecretRefClientSecret
          res."clientSecret";
    }
    // {
    };
  GeneratorAcrAccessTokenSpecAuthWorkloadIdentityModule = types.submodule {
    options = {
      "serviceAccountRef" = mkOption {
        description = "ServiceAccountRef specified the service account\nthat should be used when authenticating with WorkloadIdentity.";
        type = (types.nullOr GeneratorAcrAccessTokenSpecAuthWorkloadIdentityServiceAccountRefModule);
        default = null;
      };
    };
  };
  mkGeneratorAcrAccessTokenSpecAuthWorkloadIdentity =
    res:
    {
    }
    // optionalAttrs (res."serviceAccountRef" != null) {
      "serviceAccountRef" =
        mkGeneratorAcrAccessTokenSpecAuthWorkloadIdentityServiceAccountRef
          res."serviceAccountRef";
    }
    // {
    };
  GeneratorAcrAccessTokenSpecAuthWorkloadIdentityServiceAccountRefModule = types.submodule {
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
  mkGeneratorAcrAccessTokenSpecAuthWorkloadIdentityServiceAccountRef =
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
  GeneratorAcrAccessTokenSpecModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "ACRAuth defines the authentication methods for Azure Container Registry.";
        type = GeneratorAcrAccessTokenSpecAuthModule;
      };
      "environmentType" = mkOption {
        description = "EnvironmentType specifies the Azure cloud environment endpoints to use for\nconnecting and authenticating with Azure. By default, it points to the public cloud AAD endpoint.\nThe following endpoints are available, also see here: https://github.com/Azure/go-autorest/blob/main/autorest/azure/environments.go#L152\nPublicCloud, USGovernmentCloud, ChinaCloud, GermanCloud";
        type = (
          types.nullOr (
            types.enum [
              "PublicCloud"
              "USGovernmentCloud"
              "ChinaCloud"
              "GermanCloud"
              "AzureStackCloud"
            ]
          )
        );
        default = "PublicCloud";
      };
      "registry" = mkOption {
        description = "the domain name of the ACR registry\ne.g. foobarexample.azurecr.io";
        type = types.str;
      };
      "scope" = mkOption {
        description = "Define the scope for the access token, e.g. pull/push access for a repository.\nif not provided it will return a refresh token that has full scope.\nNote: you need to pin it down to the repository level, there is no wildcard available.\n\nexamples:\nrepository:my-repository:pull,push\nrepository:my-repository:pull\n\nsee docs for details: https://docs.docker.com/registry/spec/auth/scope/";
        type = (types.nullOr types.str);
        default = null;
      };
      "tenantId" = mkOption {
        description = "TenantID configures the Azure Tenant to send requests to. Required for ServicePrincipal auth type.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkGeneratorAcrAccessTokenSpec =
    res:
    {
      "auth" = mkGeneratorAcrAccessTokenSpecAuth res."auth";
    }
    // optionalAttrs (res."environmentType" != null) { inherit (res) "environmentType"; }
    // {
      inherit (res) "registry";
    }
    // optionalAttrs (res."scope" != null) { inherit (res) "scope"; }
    // {
    }
    // optionalAttrs (res."tenantId" != null) { inherit (res) "tenantId"; }
    // {
    };
  GeneratorCloudsmithAccessTokenSpecModule = types.submodule {
    options = {
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
        type = GeneratorCloudsmithAccessTokenSpecServiceAccountRefModule;
      };
      "serviceSlug" = mkOption {
        description = "ServiceSlug is the service slug in Cloudsmith for OIDC authentication";
        type = types.str;
      };
    };
  };
  mkGeneratorCloudsmithAccessTokenSpec =
    res:
    {
    }
    // optionalAttrs (res."apiUrl" != null) { inherit (res) "apiUrl"; }
    // {
      inherit (res) "orgSlug";
      "serviceAccountRef" = mkGeneratorCloudsmithAccessTokenSpecServiceAccountRef res."serviceAccountRef";
      inherit (res) "serviceSlug";
    };
  GeneratorCloudsmithAccessTokenSpecServiceAccountRefModule = types.submodule {
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
  mkGeneratorCloudsmithAccessTokenSpecServiceAccountRef =
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
  GeneratorEcrAuthorizationTokenSpecAuthJwtModule = types.submodule {
    options = {
      "serviceAccountRef" = mkOption {
        description = "ServiceAccountSelector is a reference to a ServiceAccount resource.";
        type = (types.nullOr GeneratorEcrAuthorizationTokenSpecAuthJwtServiceAccountRefModule);
        default = null;
      };
    };
  };
  mkGeneratorEcrAuthorizationTokenSpecAuthJwt =
    res:
    {
    }
    // optionalAttrs (res."serviceAccountRef" != null) {
      "serviceAccountRef" =
        mkGeneratorEcrAuthorizationTokenSpecAuthJwtServiceAccountRef
          res."serviceAccountRef";
    }
    // {
    };
  GeneratorEcrAuthorizationTokenSpecAuthJwtServiceAccountRefModule = types.submodule {
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
  mkGeneratorEcrAuthorizationTokenSpecAuthJwtServiceAccountRef =
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
  GeneratorEcrAuthorizationTokenSpecAuthModule = types.submodule {
    options = {
      "jwt" = mkOption {
        description = "AWSJWTAuth provides configuration to authenticate against AWS using service account tokens.";
        type = (types.nullOr GeneratorEcrAuthorizationTokenSpecAuthJwtModule);
        default = null;
      };
      "secretRef" = mkOption {
        description = "AWSAuthSecretRef holds secret references for AWS credentials\nboth AccessKeyID and SecretAccessKey must be defined in order to properly authenticate.";
        type = (types.nullOr GeneratorEcrAuthorizationTokenSpecAuthSecretRefModule);
        default = null;
      };
    };
  };
  mkGeneratorEcrAuthorizationTokenSpecAuth =
    res:
    {
    }
    // optionalAttrs (res."jwt" != null) {
      "jwt" = mkGeneratorEcrAuthorizationTokenSpecAuthJwt res."jwt";
    }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkGeneratorEcrAuthorizationTokenSpecAuthSecretRef res."secretRef";
    }
    // {
    };
  GeneratorEcrAuthorizationTokenSpecAuthSecretRefAccessKeyIDSecretRefModule = types.submodule {
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
  mkGeneratorEcrAuthorizationTokenSpecAuthSecretRefAccessKeyIDSecretRef =
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
  GeneratorEcrAuthorizationTokenSpecAuthSecretRefModule = types.submodule {
    options = {
      "accessKeyIDSecretRef" = mkOption {
        description = "The AccessKeyID is used for authentication";
        type = (types.nullOr GeneratorEcrAuthorizationTokenSpecAuthSecretRefAccessKeyIDSecretRefModule);
        default = null;
      };
      "secretAccessKeySecretRef" = mkOption {
        description = "The SecretAccessKey is used for authentication";
        type = (types.nullOr GeneratorEcrAuthorizationTokenSpecAuthSecretRefSecretAccessKeySecretRefModule);
        default = null;
      };
      "sessionTokenSecretRef" = mkOption {
        description = "The SessionToken used for authentication\nThis must be defined if AccessKeyID and SecretAccessKey are temporary credentials\nsee: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_use-resources.html";
        type = (types.nullOr GeneratorEcrAuthorizationTokenSpecAuthSecretRefSessionTokenSecretRefModule);
        default = null;
      };
    };
  };
  mkGeneratorEcrAuthorizationTokenSpecAuthSecretRef =
    res:
    {
    }
    // optionalAttrs (res."accessKeyIDSecretRef" != null) {
      "accessKeyIDSecretRef" =
        mkGeneratorEcrAuthorizationTokenSpecAuthSecretRefAccessKeyIDSecretRef
          res."accessKeyIDSecretRef";
    }
    // {
    }
    // optionalAttrs (res."secretAccessKeySecretRef" != null) {
      "secretAccessKeySecretRef" =
        mkGeneratorEcrAuthorizationTokenSpecAuthSecretRefSecretAccessKeySecretRef
          res."secretAccessKeySecretRef";
    }
    // {
    }
    // optionalAttrs (res."sessionTokenSecretRef" != null) {
      "sessionTokenSecretRef" =
        mkGeneratorEcrAuthorizationTokenSpecAuthSecretRefSessionTokenSecretRef
          res."sessionTokenSecretRef";
    }
    // {
    };
  GeneratorEcrAuthorizationTokenSpecAuthSecretRefSecretAccessKeySecretRefModule = types.submodule {
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
  mkGeneratorEcrAuthorizationTokenSpecAuthSecretRefSecretAccessKeySecretRef =
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
  GeneratorEcrAuthorizationTokenSpecAuthSecretRefSessionTokenSecretRefModule = types.submodule {
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
  mkGeneratorEcrAuthorizationTokenSpecAuthSecretRefSessionTokenSecretRef =
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
  GeneratorEcrAuthorizationTokenSpecModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth defines how to authenticate with AWS";
        type = (types.nullOr GeneratorEcrAuthorizationTokenSpecAuthModule);
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
  };
  mkGeneratorEcrAuthorizationTokenSpec =
    res:
    {
    }
    // optionalAttrs (res."auth" != null) {
      "auth" = mkGeneratorEcrAuthorizationTokenSpecAuth res."auth";
    }
    // {
      inherit (res) "region";
    }
    // optionalAttrs (res."role" != null) { inherit (res) "role"; }
    // {
    }
    // optionalAttrs (res."scope" != null) { inherit (res) "scope"; }
    // {
    };
  GeneratorFakeSpecModule = types.submodule {
    options = {
      "controller" = mkOption {
        description = "Used to select the correct ESO controller (think: ingress.ingressClassName)\nThe ESO controller is instantiated with a specific controller name and filters VDS based on this property";
        type = (types.nullOr types.str);
        default = null;
      };
      "data" = mkOption {
        description = "Data defines the static data returned\nby this generator.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkGeneratorFakeSpec =
    res:
    {
    }
    // optionalAttrs (res."controller" != null) { inherit (res) "controller"; }
    // {
    }
    // optionalAttrs (res."data" != { }) { inherit (res) "data"; }
    // {
    };
  GeneratorGcrAccessTokenSpecAuthModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "GCPSMAuthSecretRef defines the reference to a secret containing Google Cloud Platform credentials.";
        type = (types.nullOr GeneratorGcrAccessTokenSpecAuthSecretRefModule);
        default = null;
      };
      "workloadIdentity" = mkOption {
        description = "GCPWorkloadIdentity defines the configuration for using GCP Workload Identity authentication.";
        type = (types.nullOr GeneratorGcrAccessTokenSpecAuthWorkloadIdentityModule);
        default = null;
      };
      "workloadIdentityFederation" = mkOption {
        description = "GCPWorkloadIdentityFederation holds the configurations required for generating federated access tokens.";
        type = (types.nullOr GeneratorGcrAccessTokenSpecAuthWorkloadIdentityFederationModule);
        default = null;
      };
    };
  };
  mkGeneratorGcrAccessTokenSpecAuth =
    res:
    {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkGeneratorGcrAccessTokenSpecAuthSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."workloadIdentity" != null) {
      "workloadIdentity" = mkGeneratorGcrAccessTokenSpecAuthWorkloadIdentity res."workloadIdentity";
    }
    // {
    }
    // optionalAttrs (res."workloadIdentityFederation" != null) {
      "workloadIdentityFederation" =
        mkGeneratorGcrAccessTokenSpecAuthWorkloadIdentityFederation
          res."workloadIdentityFederation";
    }
    // {
    };
  GeneratorGcrAccessTokenSpecAuthSecretRefModule = types.submodule {
    options = {
      "secretAccessKeySecretRef" = mkOption {
        description = "The SecretAccessKey is used for authentication";
        type = (types.nullOr GeneratorGcrAccessTokenSpecAuthSecretRefSecretAccessKeySecretRefModule);
        default = null;
      };
    };
  };
  mkGeneratorGcrAccessTokenSpecAuthSecretRef =
    res:
    {
    }
    // optionalAttrs (res."secretAccessKeySecretRef" != null) {
      "secretAccessKeySecretRef" =
        mkGeneratorGcrAccessTokenSpecAuthSecretRefSecretAccessKeySecretRef
          res."secretAccessKeySecretRef";
    }
    // {
    };
  GeneratorGcrAccessTokenSpecAuthSecretRefSecretAccessKeySecretRefModule = types.submodule {
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
  mkGeneratorGcrAccessTokenSpecAuthSecretRefSecretAccessKeySecretRef =
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
  GeneratorGcrAccessTokenSpecAuthWorkloadIdentityFederationAwsSecurityCredentialsAwsCredentialsSecretRefModule =
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
  mkGeneratorGcrAccessTokenSpecAuthWorkloadIdentityFederationAwsSecurityCredentialsAwsCredentialsSecretRef =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  GeneratorGcrAccessTokenSpecAuthWorkloadIdentityFederationAwsSecurityCredentialsModule =
    types.submodule
      {
        options = {
          "awsCredentialsSecretRef" = mkOption {
            description = "awsCredentialsSecretRef is the reference to the secret which holds the AWS credentials.\nSecret should be created with below names for keys\n- aws_access_key_id: Access Key ID, which is the unique identifier for the AWS account or the IAM user.\n- aws_secret_access_key: Secret Access Key, which is used to authenticate requests made to AWS services.\n- aws_session_token: Session Token, is the short-lived token to authenticate requests made to AWS services.";
            type =
              GeneratorGcrAccessTokenSpecAuthWorkloadIdentityFederationAwsSecurityCredentialsAwsCredentialsSecretRefModule;
          };
          "region" = mkOption {
            description = "region is for configuring the AWS region to be used.";
            type = types.str;
          };
        };
      };
  mkGeneratorGcrAccessTokenSpecAuthWorkloadIdentityFederationAwsSecurityCredentials = res: {
    "awsCredentialsSecretRef" =
      mkGeneratorGcrAccessTokenSpecAuthWorkloadIdentityFederationAwsSecurityCredentialsAwsCredentialsSecretRef
        res."awsCredentialsSecretRef";
    inherit (res) "region";
  };
  GeneratorGcrAccessTokenSpecAuthWorkloadIdentityFederationCredConfigModule = types.submodule {
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
  mkGeneratorGcrAccessTokenSpecAuthWorkloadIdentityFederationCredConfig =
    res:
    {
      inherit (res) "key";
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  GeneratorGcrAccessTokenSpecAuthWorkloadIdentityFederationModule = types.submodule {
    options = {
      "audience" = mkOption {
        description = "audience is the Secure Token Service (STS) audience which contains the resource name for the workload identity pool and the provider identifier in that pool.\nIf specified, Audience found in the external account credential config will be overridden with the configured value.\naudience must be provided when serviceAccountRef or awsSecurityCredentials is configured.";
        type = (types.nullOr types.str);
        default = null;
      };
      "awsSecurityCredentials" = mkOption {
        description = "awsSecurityCredentials is for configuring AWS region and credentials to use for obtaining the access token,\nwhen using the AWS metadata server is not an option.";
        type = (
          types.nullOr GeneratorGcrAccessTokenSpecAuthWorkloadIdentityFederationAwsSecurityCredentialsModule
        );
        default = null;
      };
      "credConfig" = mkOption {
        description = "credConfig holds the configmap reference containing the GCP external account credential configuration in JSON format and the key name containing the json data.\nFor using Kubernetes cluster as the identity provider, use serviceAccountRef instead. Operators mounted serviceaccount token cannot be used as the token source, instead\nserviceAccountRef must be used by providing operators service account details.";
        type = (types.nullOr GeneratorGcrAccessTokenSpecAuthWorkloadIdentityFederationCredConfigModule);
        default = null;
      };
      "externalTokenEndpoint" = mkOption {
        description = "externalTokenEndpoint is the endpoint explicitly set up to provide tokens, which will be matched against the\ncredential_source.url in the provided credConfig. This field is merely to double-check the external token source\nURL is having the expected value.";
        type = (types.nullOr types.str);
        default = null;
      };
      "serviceAccountRef" = mkOption {
        description = "serviceAccountRef is the reference to the kubernetes ServiceAccount to be used for obtaining the tokens,\nwhen Kubernetes is configured as provider in workload identity pool.";
        type = (
          types.nullOr GeneratorGcrAccessTokenSpecAuthWorkloadIdentityFederationServiceAccountRefModule
        );
        default = null;
      };
    };
  };
  mkGeneratorGcrAccessTokenSpecAuthWorkloadIdentityFederation =
    res:
    {
    }
    // optionalAttrs (res."audience" != null) { inherit (res) "audience"; }
    // {
    }
    // optionalAttrs (res."awsSecurityCredentials" != null) {
      "awsSecurityCredentials" =
        mkGeneratorGcrAccessTokenSpecAuthWorkloadIdentityFederationAwsSecurityCredentials
          res."awsSecurityCredentials";
    }
    // {
    }
    // optionalAttrs (res."credConfig" != null) {
      "credConfig" =
        mkGeneratorGcrAccessTokenSpecAuthWorkloadIdentityFederationCredConfig
          res."credConfig";
    }
    // {
    }
    // optionalAttrs (res."externalTokenEndpoint" != null) { inherit (res) "externalTokenEndpoint"; }
    // {
    }
    // optionalAttrs (res."serviceAccountRef" != null) {
      "serviceAccountRef" =
        mkGeneratorGcrAccessTokenSpecAuthWorkloadIdentityFederationServiceAccountRef
          res."serviceAccountRef";
    }
    // {
    };
  GeneratorGcrAccessTokenSpecAuthWorkloadIdentityFederationServiceAccountRefModule = types.submodule {
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
  mkGeneratorGcrAccessTokenSpecAuthWorkloadIdentityFederationServiceAccountRef =
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
  GeneratorGcrAccessTokenSpecAuthWorkloadIdentityModule = types.submodule {
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
        type = GeneratorGcrAccessTokenSpecAuthWorkloadIdentityServiceAccountRefModule;
      };
    };
  };
  mkGeneratorGcrAccessTokenSpecAuthWorkloadIdentity =
    res:
    {
      inherit (res) "clusterLocation";
      inherit (res) "clusterName";
    }
    // optionalAttrs (res."clusterProjectID" != null) { inherit (res) "clusterProjectID"; }
    // {
      "serviceAccountRef" =
        mkGeneratorGcrAccessTokenSpecAuthWorkloadIdentityServiceAccountRef
          res."serviceAccountRef";
    };
  GeneratorGcrAccessTokenSpecAuthWorkloadIdentityServiceAccountRefModule = types.submodule {
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
  mkGeneratorGcrAccessTokenSpecAuthWorkloadIdentityServiceAccountRef =
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
  GeneratorGcrAccessTokenSpecModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth defines the means for authenticating with GCP";
        type = GeneratorGcrAccessTokenSpecAuthModule;
      };
      "projectID" = mkOption {
        description = "ProjectID defines which project to use to authenticate with";
        type = types.str;
      };
    };
  };
  mkGeneratorGcrAccessTokenSpec = res: {
    "auth" = mkGeneratorGcrAccessTokenSpecAuth res."auth";
    inherit (res) "projectID";
  };
  GeneratorGithubAccessTokenSpecAuthModule = types.submodule {
    options = {
      "privateKey" = mkOption {
        description = "GithubSecretRef references a secret containing GitHub credentials.";
        type = GeneratorGithubAccessTokenSpecAuthPrivateKeyModule;
      };
    };
  };
  mkGeneratorGithubAccessTokenSpecAuth = res: {
    "privateKey" = mkGeneratorGithubAccessTokenSpecAuthPrivateKey res."privateKey";
  };
  GeneratorGithubAccessTokenSpecAuthPrivateKeyModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = GeneratorGithubAccessTokenSpecAuthPrivateKeySecretRefModule;
      };
    };
  };
  mkGeneratorGithubAccessTokenSpecAuthPrivateKey = res: {
    "secretRef" = mkGeneratorGithubAccessTokenSpecAuthPrivateKeySecretRef res."secretRef";
  };
  GeneratorGithubAccessTokenSpecAuthPrivateKeySecretRefModule = types.submodule {
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
  mkGeneratorGithubAccessTokenSpecAuthPrivateKeySecretRef =
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
  GeneratorGithubAccessTokenSpecModule = types.submodule {
    options = {
      "appID" = mkOption {
        type = types.str;
      };
      "auth" = mkOption {
        description = "Auth configures how ESO authenticates with a Github instance.";
        type = GeneratorGithubAccessTokenSpecAuthModule;
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
  };
  mkGeneratorGithubAccessTokenSpec =
    res:
    {
      inherit (res) "appID";
      "auth" = mkGeneratorGithubAccessTokenSpecAuth res."auth";
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
  GeneratorGrafanaSpecAuthBasicModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "A basic auth password used to authenticate against the Grafana instance.";
        type = GeneratorGrafanaSpecAuthBasicPasswordModule;
      };
      "username" = mkOption {
        description = "A basic auth username used to authenticate against the Grafana instance.";
        type = types.str;
      };
    };
  };
  mkGeneratorGrafanaSpecAuthBasic = res: {
    "password" = mkGeneratorGrafanaSpecAuthBasicPassword res."password";
    inherit (res) "username";
  };
  GeneratorGrafanaSpecAuthBasicPasswordModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key where the token is found.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "The name of the Secret resource being referred to.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkGeneratorGrafanaSpecAuthBasicPassword =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  GeneratorGrafanaSpecAuthModule = types.submodule {
    options = {
      "basic" = mkOption {
        description = "Basic auth credentials used to authenticate against the Grafana instance.\nNote: you need a token which has elevated permissions to create service accounts.\nSee here for the documentation on basic roles offered by Grafana:\nhttps://grafana.com/docs/grafana/latest/administration/roles-and-permissions/access-control/rbac-fixed-basic-role-definitions/";
        type = (types.nullOr GeneratorGrafanaSpecAuthBasicModule);
        default = null;
      };
      "token" = mkOption {
        description = "A service account token used to authenticate against the Grafana instance.\nNote: you need a token which has elevated permissions to create service accounts.\nSee here for the documentation on basic roles offered by Grafana:\nhttps://grafana.com/docs/grafana/latest/administration/roles-and-permissions/access-control/rbac-fixed-basic-role-definitions/";
        type = (types.nullOr GeneratorGrafanaSpecAuthTokenModule);
        default = null;
      };
    };
  };
  mkGeneratorGrafanaSpecAuth =
    res:
    {
    }
    // optionalAttrs (res."basic" != null) { "basic" = mkGeneratorGrafanaSpecAuthBasic res."basic"; }
    // {
    }
    // optionalAttrs (res."token" != null) { "token" = mkGeneratorGrafanaSpecAuthToken res."token"; }
    // {
    };
  GeneratorGrafanaSpecAuthTokenModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key where the token is found.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "The name of the Secret resource being referred to.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkGeneratorGrafanaSpecAuthToken =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  GeneratorGrafanaSpecModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth is the authentication configuration to authenticate\nagainst the Grafana instance.";
        type = GeneratorGrafanaSpecAuthModule;
      };
      "serviceAccount" = mkOption {
        description = "ServiceAccount is the configuration for the service account that\nis supposed to be generated by the generator.";
        type = GeneratorGrafanaSpecServiceAccountModule;
      };
      "url" = mkOption {
        description = "URL is the URL of the Grafana instance.";
        type = types.str;
      };
    };
  };
  mkGeneratorGrafanaSpec = res: {
    "auth" = mkGeneratorGrafanaSpecAuth res."auth";
    "serviceAccount" = mkGeneratorGrafanaSpecServiceAccount res."serviceAccount";
    inherit (res) "url";
  };
  GeneratorGrafanaSpecServiceAccountModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the name of the service account that will be created by ESO.";
        type = types.str;
      };
      "role" = mkOption {
        description = "Role is the role of the service account.\nSee here for the documentation on basic roles offered by Grafana:\nhttps://grafana.com/docs/grafana/latest/administration/roles-and-permissions/access-control/rbac-fixed-basic-role-definitions/";
        type = types.str;
      };
    };
  };
  mkGeneratorGrafanaSpecServiceAccount = res: {
    inherit (res) "name";
    inherit (res) "role";
  };
  GeneratorMfaSpecModule = types.submodule {
    options = {
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
        type = GeneratorMfaSpecSecretModule;
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
  };
  mkGeneratorMfaSpec =
    res:
    {
    }
    // optionalAttrs (res."algorithm" != null) { inherit (res) "algorithm"; }
    // {
    }
    // optionalAttrs (res."length" != null) { inherit (res) "length"; }
    // {
      "secret" = mkGeneratorMfaSpecSecret res."secret";
    }
    // optionalAttrs (res."timePeriod" != null) { inherit (res) "timePeriod"; }
    // {
    }
    // optionalAttrs (res."when" != null) { inherit (res) "when"; }
    // {
    };
  GeneratorMfaSpecSecretModule = types.submodule {
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
  mkGeneratorMfaSpecSecret =
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
  GeneratorModule = types.submodule {
    options = {
      "acrAccessTokenSpec" = mkOption {
        description = "ACRAccessTokenSpec defines how to generate the access token\ne.g. how to authenticate and which registry to use.\nsee: https://github.com/Azure/acr/blob/main/docs/AAD-OAuth.md#overview";
        type = (types.nullOr GeneratorAcrAccessTokenSpecModule);
        default = null;
      };
      "cloudsmithAccessTokenSpec" = mkOption {
        description = "CloudsmithAccessTokenSpec defines the configuration for generating a Cloudsmith access token using OIDC authentication.";
        type = (types.nullOr GeneratorCloudsmithAccessTokenSpecModule);
        default = null;
      };
      "ecrAuthorizationTokenSpec" = mkOption {
        description = "ECRAuthorizationTokenSpec defines the desired state to generate an AWS ECR authorization token.";
        type = (types.nullOr GeneratorEcrAuthorizationTokenSpecModule);
        default = null;
      };
      "fakeSpec" = mkOption {
        description = "FakeSpec contains the static data.";
        type = (types.nullOr GeneratorFakeSpecModule);
        default = null;
      };
      "gcrAccessTokenSpec" = mkOption {
        description = "GCRAccessTokenSpec defines the desired state to generate a Google Container Registry access token.";
        type = (types.nullOr GeneratorGcrAccessTokenSpecModule);
        default = null;
      };
      "githubAccessTokenSpec" = mkOption {
        description = "GithubAccessTokenSpec defines the desired state to generate a GitHub access token.";
        type = (types.nullOr GeneratorGithubAccessTokenSpecModule);
        default = null;
      };
      "grafanaSpec" = mkOption {
        description = "GrafanaSpec controls the behavior of the grafana generator.";
        type = (types.nullOr GeneratorGrafanaSpecModule);
        default = null;
      };
      "mfaSpec" = mkOption {
        description = "MFASpec controls the behavior of the mfa generator.";
        type = (types.nullOr GeneratorMfaSpecModule);
        default = null;
      };
      "passwordSpec" = mkOption {
        description = "PasswordSpec controls the behavior of the password generator.";
        type = (types.nullOr GeneratorPasswordSpecModule);
        default = null;
      };
      "quayAccessTokenSpec" = mkOption {
        description = "QuayAccessTokenSpec defines the desired state to generate a Quay access token.";
        type = (types.nullOr GeneratorQuayAccessTokenSpecModule);
        default = null;
      };
      "sshKeySpec" = mkOption {
        description = "SSHKeySpec controls the behavior of the ssh key generator.";
        type = (types.nullOr GeneratorSshKeySpecModule);
        default = null;
      };
      "stsSessionTokenSpec" = mkOption {
        description = "STSSessionTokenSpec defines the desired state to generate an AWS STS session token.";
        type = (types.nullOr GeneratorStsSessionTokenSpecModule);
        default = null;
      };
      "uuidSpec" = mkOption {
        description = "UUIDSpec controls the behavior of the uuid generator.";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "vaultDynamicSecretSpec" = mkOption {
        description = "VaultDynamicSecretSpec defines the desired spec of VaultDynamicSecret.";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecModule);
        default = null;
      };
      "webhookSpec" = mkOption {
        description = "WebhookSpec controls the behavior of the external generator. Any body parameters should be passed to the server through the parameters field.";
        type = (types.nullOr GeneratorWebhookSpecModule);
        default = null;
      };
    };
  };
  mkGenerator =
    res:
    {
    }
    // optionalAttrs (res."acrAccessTokenSpec" != null) {
      "acrAccessTokenSpec" = mkGeneratorAcrAccessTokenSpec res."acrAccessTokenSpec";
    }
    // {
    }
    // optionalAttrs (res."cloudsmithAccessTokenSpec" != null) {
      "cloudsmithAccessTokenSpec" = mkGeneratorCloudsmithAccessTokenSpec res."cloudsmithAccessTokenSpec";
    }
    // {
    }
    // optionalAttrs (res."ecrAuthorizationTokenSpec" != null) {
      "ecrAuthorizationTokenSpec" = mkGeneratorEcrAuthorizationTokenSpec res."ecrAuthorizationTokenSpec";
    }
    // {
    }
    // optionalAttrs (res."fakeSpec" != null) { "fakeSpec" = mkGeneratorFakeSpec res."fakeSpec"; }
    // {
    }
    // optionalAttrs (res."gcrAccessTokenSpec" != null) {
      "gcrAccessTokenSpec" = mkGeneratorGcrAccessTokenSpec res."gcrAccessTokenSpec";
    }
    // {
    }
    // optionalAttrs (res."githubAccessTokenSpec" != null) {
      "githubAccessTokenSpec" = mkGeneratorGithubAccessTokenSpec res."githubAccessTokenSpec";
    }
    // {
    }
    // optionalAttrs (res."grafanaSpec" != null) {
      "grafanaSpec" = mkGeneratorGrafanaSpec res."grafanaSpec";
    }
    // {
    }
    // optionalAttrs (res."mfaSpec" != null) { "mfaSpec" = mkGeneratorMfaSpec res."mfaSpec"; }
    // {
    }
    // optionalAttrs (res."passwordSpec" != null) {
      "passwordSpec" = mkGeneratorPasswordSpec res."passwordSpec";
    }
    // {
    }
    // optionalAttrs (res."quayAccessTokenSpec" != null) {
      "quayAccessTokenSpec" = mkGeneratorQuayAccessTokenSpec res."quayAccessTokenSpec";
    }
    // {
    }
    // optionalAttrs (res."sshKeySpec" != null) {
      "sshKeySpec" = mkGeneratorSshKeySpec res."sshKeySpec";
    }
    // {
    }
    // optionalAttrs (res."stsSessionTokenSpec" != null) {
      "stsSessionTokenSpec" = mkGeneratorStsSessionTokenSpec res."stsSessionTokenSpec";
    }
    // {
    }
    // optionalAttrs (res."uuidSpec" != { }) { inherit (res) "uuidSpec"; }
    // {
    }
    // optionalAttrs (res."vaultDynamicSecretSpec" != null) {
      "vaultDynamicSecretSpec" = mkGeneratorVaultDynamicSecretSpec res."vaultDynamicSecretSpec";
    }
    // {
    }
    // optionalAttrs (res."webhookSpec" != null) {
      "webhookSpec" = mkGeneratorWebhookSpec res."webhookSpec";
    }
    // {
    };
  GeneratorPasswordSpecModule = types.submodule {
    options = {
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
  };
  mkGeneratorPasswordSpec =
    res:
    {
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
  GeneratorQuayAccessTokenSpecModule = types.submodule {
    options = {
      "robotAccount" = mkOption {
        description = "Name of the robot account you are federating with";
        type = types.str;
      };
      "serviceAccountRef" = mkOption {
        description = "Name of the service account you are federating with";
        type = GeneratorQuayAccessTokenSpecServiceAccountRefModule;
      };
      "url" = mkOption {
        description = "URL configures the Quay instance URL. Defaults to quay.io.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkGeneratorQuayAccessTokenSpec =
    res:
    {
      inherit (res) "robotAccount";
      "serviceAccountRef" = mkGeneratorQuayAccessTokenSpecServiceAccountRef res."serviceAccountRef";
    }
    // optionalAttrs (res."url" != null) { inherit (res) "url"; }
    // {
    };
  GeneratorQuayAccessTokenSpecServiceAccountRefModule = types.submodule {
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
  mkGeneratorQuayAccessTokenSpecServiceAccountRef =
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
  GeneratorSshKeySpecModule = types.submodule {
    options = {
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
  };
  mkGeneratorSshKeySpec =
    res:
    {
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
  GeneratorStsSessionTokenSpecAuthJwtModule = types.submodule {
    options = {
      "serviceAccountRef" = mkOption {
        description = "ServiceAccountSelector is a reference to a ServiceAccount resource.";
        type = (types.nullOr GeneratorStsSessionTokenSpecAuthJwtServiceAccountRefModule);
        default = null;
      };
    };
  };
  mkGeneratorStsSessionTokenSpecAuthJwt =
    res:
    {
    }
    // optionalAttrs (res."serviceAccountRef" != null) {
      "serviceAccountRef" =
        mkGeneratorStsSessionTokenSpecAuthJwtServiceAccountRef
          res."serviceAccountRef";
    }
    // {
    };
  GeneratorStsSessionTokenSpecAuthJwtServiceAccountRefModule = types.submodule {
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
  mkGeneratorStsSessionTokenSpecAuthJwtServiceAccountRef =
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
  GeneratorStsSessionTokenSpecAuthModule = types.submodule {
    options = {
      "jwt" = mkOption {
        description = "AWSJWTAuth provides configuration to authenticate against AWS using service account tokens.";
        type = (types.nullOr GeneratorStsSessionTokenSpecAuthJwtModule);
        default = null;
      };
      "secretRef" = mkOption {
        description = "AWSAuthSecretRef holds secret references for AWS credentials\nboth AccessKeyID and SecretAccessKey must be defined in order to properly authenticate.";
        type = (types.nullOr GeneratorStsSessionTokenSpecAuthSecretRefModule);
        default = null;
      };
    };
  };
  mkGeneratorStsSessionTokenSpecAuth =
    res:
    {
    }
    // optionalAttrs (res."jwt" != null) { "jwt" = mkGeneratorStsSessionTokenSpecAuthJwt res."jwt"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkGeneratorStsSessionTokenSpecAuthSecretRef res."secretRef";
    }
    // {
    };
  GeneratorStsSessionTokenSpecAuthSecretRefAccessKeyIDSecretRefModule = types.submodule {
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
  mkGeneratorStsSessionTokenSpecAuthSecretRefAccessKeyIDSecretRef =
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
  GeneratorStsSessionTokenSpecAuthSecretRefModule = types.submodule {
    options = {
      "accessKeyIDSecretRef" = mkOption {
        description = "The AccessKeyID is used for authentication";
        type = (types.nullOr GeneratorStsSessionTokenSpecAuthSecretRefAccessKeyIDSecretRefModule);
        default = null;
      };
      "secretAccessKeySecretRef" = mkOption {
        description = "The SecretAccessKey is used for authentication";
        type = (types.nullOr GeneratorStsSessionTokenSpecAuthSecretRefSecretAccessKeySecretRefModule);
        default = null;
      };
      "sessionTokenSecretRef" = mkOption {
        description = "The SessionToken used for authentication\nThis must be defined if AccessKeyID and SecretAccessKey are temporary credentials\nsee: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_use-resources.html";
        type = (types.nullOr GeneratorStsSessionTokenSpecAuthSecretRefSessionTokenSecretRefModule);
        default = null;
      };
    };
  };
  mkGeneratorStsSessionTokenSpecAuthSecretRef =
    res:
    {
    }
    // optionalAttrs (res."accessKeyIDSecretRef" != null) {
      "accessKeyIDSecretRef" =
        mkGeneratorStsSessionTokenSpecAuthSecretRefAccessKeyIDSecretRef
          res."accessKeyIDSecretRef";
    }
    // {
    }
    // optionalAttrs (res."secretAccessKeySecretRef" != null) {
      "secretAccessKeySecretRef" =
        mkGeneratorStsSessionTokenSpecAuthSecretRefSecretAccessKeySecretRef
          res."secretAccessKeySecretRef";
    }
    // {
    }
    // optionalAttrs (res."sessionTokenSecretRef" != null) {
      "sessionTokenSecretRef" =
        mkGeneratorStsSessionTokenSpecAuthSecretRefSessionTokenSecretRef
          res."sessionTokenSecretRef";
    }
    // {
    };
  GeneratorStsSessionTokenSpecAuthSecretRefSecretAccessKeySecretRefModule = types.submodule {
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
  mkGeneratorStsSessionTokenSpecAuthSecretRefSecretAccessKeySecretRef =
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
  GeneratorStsSessionTokenSpecAuthSecretRefSessionTokenSecretRefModule = types.submodule {
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
  mkGeneratorStsSessionTokenSpecAuthSecretRefSessionTokenSecretRef =
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
  GeneratorStsSessionTokenSpecModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth defines how to authenticate with AWS";
        type = (types.nullOr GeneratorStsSessionTokenSpecAuthModule);
        default = null;
      };
      "region" = mkOption {
        description = "Region specifies the region to operate in.";
        type = types.str;
      };
      "requestParameters" = mkOption {
        description = "RequestParameters contains parameters that can be passed to the STS service.";
        type = (types.nullOr GeneratorStsSessionTokenSpecRequestParametersModule);
        default = null;
      };
      "role" = mkOption {
        description = "You can assume a role before making calls to the\ndesired AWS service.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkGeneratorStsSessionTokenSpec =
    res:
    {
    }
    // optionalAttrs (res."auth" != null) { "auth" = mkGeneratorStsSessionTokenSpecAuth res."auth"; }
    // {
      inherit (res) "region";
    }
    // optionalAttrs (res."requestParameters" != null) {
      "requestParameters" = mkGeneratorStsSessionTokenSpecRequestParameters res."requestParameters";
    }
    // {
    }
    // optionalAttrs (res."role" != null) { inherit (res) "role"; }
    // {
    };
  GeneratorStsSessionTokenSpecRequestParametersModule = types.submodule {
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
  mkGeneratorStsSessionTokenSpecRequestParameters =
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
  GeneratorVaultDynamicSecretSpecModule = types.submodule {
    options = {
      "allowEmptyResponse" = mkOption {
        description = "Do not fail if no secrets are found. Useful for requests where no data is expected.";
        type = types.bool;
        default = false;
      };
      "controller" = mkOption {
        description = "Used to select the correct ESO controller (think: ingress.ingressClassName)\nThe ESO controller is instantiated with a specific controller name and filters VDS based on this property";
        type = (types.nullOr types.str);
        default = null;
      };
      "method" = mkOption {
        description = "Vault API method to use (GET/POST/other)";
        type = (types.nullOr types.str);
        default = null;
      };
      "parameters" = mkOption {
        description = "Parameters to pass to Vault write (for non-GET methods)";
        type = (types.nullOr types.anything);
        default = null;
      };
      "path" = mkOption {
        description = "Vault path to obtain the dynamic secret from";
        type = types.str;
      };
      "provider" = mkOption {
        description = "Vault provider common spec";
        type = GeneratorVaultDynamicSecretSpecProviderModule;
      };
      "resultType" = mkOption {
        description = "Result type defines which data is returned from the generator.\nBy default, it is the \"data\" section of the Vault API response.\nWhen using e.g. /auth/token/create the \"data\" section is empty but\nthe \"auth\" section contains the generated token.\nPlease refer to the vault docs regarding the result data structure.\nAdditionally, accessing the raw response is possibly by using \"Raw\" result type.";
        type = (
          types.nullOr (
            types.enum [
              "Data"
              "Auth"
              "Raw"
            ]
          )
        );
        default = "Data";
      };
      "retrySettings" = mkOption {
        description = "Used to configure http retries if failed";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecRetrySettingsModule);
        default = null;
      };
    };
  };
  mkGeneratorVaultDynamicSecretSpec =
    res:
    {
    }
    // optionalAttrs res."allowEmptyResponse" { inherit (res) "allowEmptyResponse"; }
    // {
    }
    // optionalAttrs (res."controller" != null) { inherit (res) "controller"; }
    // {
    }
    // optionalAttrs (res."method" != null) { inherit (res) "method"; }
    // {
    }
    // optionalAttrs (res."parameters" != null) { inherit (res) "parameters"; }
    // {
      inherit (res) "path";
      "provider" = mkGeneratorVaultDynamicSecretSpecProvider res."provider";
    }
    // optionalAttrs (res."resultType" != null) { inherit (res) "resultType"; }
    // {
    }
    // optionalAttrs (res."retrySettings" != null) {
      "retrySettings" = mkGeneratorVaultDynamicSecretSpecRetrySettings res."retrySettings";
    }
    // {
    };
  GeneratorVaultDynamicSecretSpecProviderAuthAppRoleModule = types.submodule {
    options = {
      "path" = mkOption {
        description = "Path where the App Role authentication backend is mounted\nin Vault, e.g: \"approle\"";
        type = types.str;
      };
      "roleId" = mkOption {
        description = "RoleID configured in the App Role authentication backend when setting\nup the authentication backend in Vault.";
        type = (types.nullOr types.str);
        default = null;
      };
      "roleRef" = mkOption {
        description = "Reference to a key in a Secret that contains the App Role ID used\nto authenticate with Vault.\nThe `key` field must be specified and denotes which entry within the Secret\nresource is used as the app role id.";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthAppRoleRoleRefModule);
        default = null;
      };
      "secretRef" = mkOption {
        description = "Reference to a key in a Secret that contains the App Role secret used\nto authenticate with Vault.\nThe `key` field must be specified and denotes which entry within the Secret\nresource is used as the app role secret.";
        type = GeneratorVaultDynamicSecretSpecProviderAuthAppRoleSecretRefModule;
      };
    };
  };
  mkGeneratorVaultDynamicSecretSpecProviderAuthAppRole =
    res:
    {
      inherit (res) "path";
    }
    // optionalAttrs (res."roleId" != null) { inherit (res) "roleId"; }
    // {
    }
    // optionalAttrs (res."roleRef" != null) {
      "roleRef" = mkGeneratorVaultDynamicSecretSpecProviderAuthAppRoleRoleRef res."roleRef";
    }
    // {
      "secretRef" = mkGeneratorVaultDynamicSecretSpecProviderAuthAppRoleSecretRef res."secretRef";
    };
  GeneratorVaultDynamicSecretSpecProviderAuthAppRoleRoleRefModule = types.submodule {
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
  mkGeneratorVaultDynamicSecretSpecProviderAuthAppRoleRoleRef =
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
  GeneratorVaultDynamicSecretSpecProviderAuthAppRoleSecretRefModule = types.submodule {
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
  mkGeneratorVaultDynamicSecretSpecProviderAuthAppRoleSecretRef =
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
  GeneratorVaultDynamicSecretSpecProviderAuthCertClientCertModule = types.submodule {
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
  mkGeneratorVaultDynamicSecretSpecProviderAuthCertClientCert =
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
  GeneratorVaultDynamicSecretSpecProviderAuthCertModule = types.submodule {
    options = {
      "clientCert" = mkOption {
        description = "ClientCert is a certificate to authenticate using the Cert Vault\nauthentication method";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthCertClientCertModule);
        default = null;
      };
      "path" = mkOption {
        description = "Path where the Certificate authentication backend is mounted\nin Vault, e.g: \"cert\"";
        type = (types.nullOr types.str);
        default = "cert";
      };
      "secretRef" = mkOption {
        description = "SecretRef to a key in a Secret resource containing client private key to\nauthenticate with Vault using the Cert authentication method";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthCertSecretRefModule);
        default = null;
      };
    };
  };
  mkGeneratorVaultDynamicSecretSpecProviderAuthCert =
    res:
    {
    }
    // optionalAttrs (res."clientCert" != null) {
      "clientCert" = mkGeneratorVaultDynamicSecretSpecProviderAuthCertClientCert res."clientCert";
    }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkGeneratorVaultDynamicSecretSpecProviderAuthCertSecretRef res."secretRef";
    }
    // {
    };
  GeneratorVaultDynamicSecretSpecProviderAuthCertSecretRefModule = types.submodule {
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
  mkGeneratorVaultDynamicSecretSpecProviderAuthCertSecretRef =
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
  GeneratorVaultDynamicSecretSpecProviderAuthGcpModule = types.submodule {
    options = {
      "location" = mkOption {
        description = "Location optionally defines a location/region for the secret";
        type = (types.nullOr types.str);
        default = null;
      };
      "path" = mkOption {
        description = "Path where the GCP auth method is enabled in Vault, e.g: \"gcp\"";
        type = (types.nullOr types.str);
        default = "gcp";
      };
      "projectID" = mkOption {
        description = "Project ID of the Google Cloud Platform project";
        type = (types.nullOr types.str);
        default = null;
      };
      "role" = mkOption {
        description = "Vault Role. In Vault, a role describes an identity with a set of permissions, groups, or policies you want to attach to a user of the secrets engine.";
        type = types.str;
      };
      "secretRef" = mkOption {
        description = "Specify credentials in a Secret object";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthGcpSecretRefModule);
        default = null;
      };
      "serviceAccountRef" = mkOption {
        description = "ServiceAccountRef to a service account for impersonation";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthGcpServiceAccountRefModule);
        default = null;
      };
      "workloadIdentity" = mkOption {
        description = "Specify a service account with Workload Identity";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthGcpWorkloadIdentityModule);
        default = null;
      };
    };
  };
  mkGeneratorVaultDynamicSecretSpecProviderAuthGcp =
    res:
    {
    }
    // optionalAttrs (res."location" != null) { inherit (res) "location"; }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs (res."projectID" != null) { inherit (res) "projectID"; }
    // {
      inherit (res) "role";
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkGeneratorVaultDynamicSecretSpecProviderAuthGcpSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."serviceAccountRef" != null) {
      "serviceAccountRef" =
        mkGeneratorVaultDynamicSecretSpecProviderAuthGcpServiceAccountRef
          res."serviceAccountRef";
    }
    // {
    }
    // optionalAttrs (res."workloadIdentity" != null) {
      "workloadIdentity" =
        mkGeneratorVaultDynamicSecretSpecProviderAuthGcpWorkloadIdentity
          res."workloadIdentity";
    }
    // {
    };
  GeneratorVaultDynamicSecretSpecProviderAuthGcpSecretRefModule = types.submodule {
    options = {
      "secretAccessKeySecretRef" = mkOption {
        description = "The SecretAccessKey is used for authentication";
        type = (
          types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthGcpSecretRefSecretAccessKeySecretRefModule
        );
        default = null;
      };
    };
  };
  mkGeneratorVaultDynamicSecretSpecProviderAuthGcpSecretRef =
    res:
    {
    }
    // optionalAttrs (res."secretAccessKeySecretRef" != null) {
      "secretAccessKeySecretRef" =
        mkGeneratorVaultDynamicSecretSpecProviderAuthGcpSecretRefSecretAccessKeySecretRef
          res."secretAccessKeySecretRef";
    }
    // {
    };
  GeneratorVaultDynamicSecretSpecProviderAuthGcpSecretRefSecretAccessKeySecretRefModule =
    types.submodule
      {
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
  mkGeneratorVaultDynamicSecretSpecProviderAuthGcpSecretRefSecretAccessKeySecretRef =
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
  GeneratorVaultDynamicSecretSpecProviderAuthGcpServiceAccountRefModule = types.submodule {
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
  mkGeneratorVaultDynamicSecretSpecProviderAuthGcpServiceAccountRef =
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
  GeneratorVaultDynamicSecretSpecProviderAuthGcpWorkloadIdentityModule = types.submodule {
    options = {
      "clusterLocation" = mkOption {
        description = "ClusterLocation is the location of the cluster\nIf not specified, it fetches information from the metadata server";
        type = (types.nullOr types.str);
        default = null;
      };
      "clusterName" = mkOption {
        description = "ClusterName is the name of the cluster\nIf not specified, it fetches information from the metadata server";
        type = (types.nullOr types.str);
        default = null;
      };
      "clusterProjectID" = mkOption {
        description = "ClusterProjectID is the project ID of the cluster\nIf not specified, it fetches information from the metadata server";
        type = (types.nullOr types.str);
        default = null;
      };
      "serviceAccountRef" = mkOption {
        description = "ServiceAccountSelector is a reference to a ServiceAccount resource.";
        type = GeneratorVaultDynamicSecretSpecProviderAuthGcpWorkloadIdentityServiceAccountRefModule;
      };
    };
  };
  mkGeneratorVaultDynamicSecretSpecProviderAuthGcpWorkloadIdentity =
    res:
    {
    }
    // optionalAttrs (res."clusterLocation" != null) { inherit (res) "clusterLocation"; }
    // {
    }
    // optionalAttrs (res."clusterName" != null) { inherit (res) "clusterName"; }
    // {
    }
    // optionalAttrs (res."clusterProjectID" != null) { inherit (res) "clusterProjectID"; }
    // {
      "serviceAccountRef" =
        mkGeneratorVaultDynamicSecretSpecProviderAuthGcpWorkloadIdentityServiceAccountRef
          res."serviceAccountRef";
    };
  GeneratorVaultDynamicSecretSpecProviderAuthGcpWorkloadIdentityServiceAccountRefModule =
    types.submodule
      {
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
  mkGeneratorVaultDynamicSecretSpecProviderAuthGcpWorkloadIdentityServiceAccountRef =
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
  GeneratorVaultDynamicSecretSpecProviderAuthIamJwtModule = types.submodule {
    options = {
      "serviceAccountRef" = mkOption {
        description = "ServiceAccountSelector is a reference to a ServiceAccount resource.";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthIamJwtServiceAccountRefModule);
        default = null;
      };
    };
  };
  mkGeneratorVaultDynamicSecretSpecProviderAuthIamJwt =
    res:
    {
    }
    // optionalAttrs (res."serviceAccountRef" != null) {
      "serviceAccountRef" =
        mkGeneratorVaultDynamicSecretSpecProviderAuthIamJwtServiceAccountRef
          res."serviceAccountRef";
    }
    // {
    };
  GeneratorVaultDynamicSecretSpecProviderAuthIamJwtServiceAccountRefModule = types.submodule {
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
  mkGeneratorVaultDynamicSecretSpecProviderAuthIamJwtServiceAccountRef =
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
  GeneratorVaultDynamicSecretSpecProviderAuthIamModule = types.submodule {
    options = {
      "externalID" = mkOption {
        description = "AWS External ID set on assumed IAM roles";
        type = (types.nullOr types.str);
        default = null;
      };
      "jwt" = mkOption {
        description = "Specify a service account with IRSA enabled";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthIamJwtModule);
        default = null;
      };
      "path" = mkOption {
        description = "Path where the AWS auth method is enabled in Vault, e.g: \"aws\"";
        type = (types.nullOr types.str);
        default = null;
      };
      "region" = mkOption {
        description = "AWS region";
        type = (types.nullOr types.str);
        default = null;
      };
      "role" = mkOption {
        description = "This is the AWS role to be assumed before talking to vault";
        type = (types.nullOr types.str);
        default = null;
      };
      "secretRef" = mkOption {
        description = "Specify credentials in a Secret object";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthIamSecretRefModule);
        default = null;
      };
      "vaultAwsIamServerID" = mkOption {
        description = "X-Vault-AWS-IAM-Server-ID is an additional header used by Vault IAM auth method to mitigate against different types of replay attacks. More details here: https://developer.hashicorp.com/vault/docs/auth/aws";
        type = (types.nullOr types.str);
        default = null;
      };
      "vaultRole" = mkOption {
        description = "Vault Role. In vault, a role describes an identity with a set of permissions, groups, or policies you want to attach a user of the secrets engine";
        type = types.str;
      };
    };
  };
  mkGeneratorVaultDynamicSecretSpecProviderAuthIam =
    res:
    {
    }
    // optionalAttrs (res."externalID" != null) { inherit (res) "externalID"; }
    // {
    }
    // optionalAttrs (res."jwt" != null) {
      "jwt" = mkGeneratorVaultDynamicSecretSpecProviderAuthIamJwt res."jwt";
    }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs (res."region" != null) { inherit (res) "region"; }
    // {
    }
    // optionalAttrs (res."role" != null) { inherit (res) "role"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkGeneratorVaultDynamicSecretSpecProviderAuthIamSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."vaultAwsIamServerID" != null) { inherit (res) "vaultAwsIamServerID"; }
    // {
      inherit (res) "vaultRole";
    };
  GeneratorVaultDynamicSecretSpecProviderAuthIamSecretRefAccessKeyIDSecretRefModule =
    types.submodule
      {
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
  mkGeneratorVaultDynamicSecretSpecProviderAuthIamSecretRefAccessKeyIDSecretRef =
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
  GeneratorVaultDynamicSecretSpecProviderAuthIamSecretRefModule = types.submodule {
    options = {
      "accessKeyIDSecretRef" = mkOption {
        description = "The AccessKeyID is used for authentication";
        type = (
          types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthIamSecretRefAccessKeyIDSecretRefModule
        );
        default = null;
      };
      "secretAccessKeySecretRef" = mkOption {
        description = "The SecretAccessKey is used for authentication";
        type = (
          types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthIamSecretRefSecretAccessKeySecretRefModule
        );
        default = null;
      };
      "sessionTokenSecretRef" = mkOption {
        description = "The SessionToken used for authentication\nThis must be defined if AccessKeyID and SecretAccessKey are temporary credentials\nsee: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_use-resources.html";
        type = (
          types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthIamSecretRefSessionTokenSecretRefModule
        );
        default = null;
      };
    };
  };
  mkGeneratorVaultDynamicSecretSpecProviderAuthIamSecretRef =
    res:
    {
    }
    // optionalAttrs (res."accessKeyIDSecretRef" != null) {
      "accessKeyIDSecretRef" =
        mkGeneratorVaultDynamicSecretSpecProviderAuthIamSecretRefAccessKeyIDSecretRef
          res."accessKeyIDSecretRef";
    }
    // {
    }
    // optionalAttrs (res."secretAccessKeySecretRef" != null) {
      "secretAccessKeySecretRef" =
        mkGeneratorVaultDynamicSecretSpecProviderAuthIamSecretRefSecretAccessKeySecretRef
          res."secretAccessKeySecretRef";
    }
    // {
    }
    // optionalAttrs (res."sessionTokenSecretRef" != null) {
      "sessionTokenSecretRef" =
        mkGeneratorVaultDynamicSecretSpecProviderAuthIamSecretRefSessionTokenSecretRef
          res."sessionTokenSecretRef";
    }
    // {
    };
  GeneratorVaultDynamicSecretSpecProviderAuthIamSecretRefSecretAccessKeySecretRefModule =
    types.submodule
      {
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
  mkGeneratorVaultDynamicSecretSpecProviderAuthIamSecretRefSecretAccessKeySecretRef =
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
  GeneratorVaultDynamicSecretSpecProviderAuthIamSecretRefSessionTokenSecretRefModule =
    types.submodule
      {
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
  mkGeneratorVaultDynamicSecretSpecProviderAuthIamSecretRefSessionTokenSecretRef =
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
  GeneratorVaultDynamicSecretSpecProviderAuthJwtKubernetesServiceAccountTokenModule =
    types.submodule
      {
        options = {
          "audiences" = mkOption {
            description = "Optional audiences field that will be used to request a temporary Kubernetes service\naccount token for the service account referenced by `serviceAccountRef`.\nDefaults to a single audience `vault` it not specified.\nDeprecated: use serviceAccountRef.Audiences instead";
            type = (types.listOf types.str);
            default = [ ];
          };
          "expirationSeconds" = mkOption {
            description = "Optional expiration time in seconds that will be used to request a temporary\nKubernetes service account token for the service account referenced by\n`serviceAccountRef`.\nDeprecated: this will be removed in the future.\nDefaults to 10 minutes.";
            type = (types.nullOr types.int);
            default = null;
          };
          "serviceAccountRef" = mkOption {
            description = "Service account field containing the name of a kubernetes ServiceAccount.";
            type =
              GeneratorVaultDynamicSecretSpecProviderAuthJwtKubernetesServiceAccountTokenServiceAccountRefModule;
          };
        };
      };
  mkGeneratorVaultDynamicSecretSpecProviderAuthJwtKubernetesServiceAccountToken =
    res:
    {
    }
    // optionalAttrs (res."audiences" != [ ]) { inherit (res) "audiences"; }
    // {
    }
    // optionalAttrs (res."expirationSeconds" != null) { inherit (res) "expirationSeconds"; }
    // {
      "serviceAccountRef" =
        mkGeneratorVaultDynamicSecretSpecProviderAuthJwtKubernetesServiceAccountTokenServiceAccountRef
          res."serviceAccountRef";
    };
  GeneratorVaultDynamicSecretSpecProviderAuthJwtKubernetesServiceAccountTokenServiceAccountRefModule =
    types.submodule
      {
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
  mkGeneratorVaultDynamicSecretSpecProviderAuthJwtKubernetesServiceAccountTokenServiceAccountRef =
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
  GeneratorVaultDynamicSecretSpecProviderAuthJwtModule = types.submodule {
    options = {
      "kubernetesServiceAccountToken" = mkOption {
        description = "Optional ServiceAccountToken specifies the Kubernetes service account for which to request\na token for with the `TokenRequest` API.";
        type = (
          types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthJwtKubernetesServiceAccountTokenModule
        );
        default = null;
      };
      "path" = mkOption {
        description = "Path where the JWT authentication backend is mounted\nin Vault, e.g: \"jwt\"";
        type = types.str;
      };
      "role" = mkOption {
        description = "Role is a JWT role to authenticate using the JWT/OIDC Vault\nauthentication method";
        type = (types.nullOr types.str);
        default = null;
      };
      "secretRef" = mkOption {
        description = "Optional SecretRef that refers to a key in a Secret resource containing JWT token to\nauthenticate with Vault using the JWT/OIDC authentication method.";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthJwtSecretRefModule);
        default = null;
      };
    };
  };
  mkGeneratorVaultDynamicSecretSpecProviderAuthJwt =
    res:
    {
    }
    // optionalAttrs (res."kubernetesServiceAccountToken" != null) {
      "kubernetesServiceAccountToken" =
        mkGeneratorVaultDynamicSecretSpecProviderAuthJwtKubernetesServiceAccountToken
          res."kubernetesServiceAccountToken";
    }
    // {
      inherit (res) "path";
    }
    // optionalAttrs (res."role" != null) { inherit (res) "role"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkGeneratorVaultDynamicSecretSpecProviderAuthJwtSecretRef res."secretRef";
    }
    // {
    };
  GeneratorVaultDynamicSecretSpecProviderAuthJwtSecretRefModule = types.submodule {
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
  mkGeneratorVaultDynamicSecretSpecProviderAuthJwtSecretRef =
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
  GeneratorVaultDynamicSecretSpecProviderAuthKubernetesModule = types.submodule {
    options = {
      "mountPath" = mkOption {
        description = "Path where the Kubernetes authentication backend is mounted in Vault, e.g:\n\"kubernetes\"";
        type = types.str;
      };
      "role" = mkOption {
        description = "A required field containing the Vault Role to assume. A Role binds a\nKubernetes ServiceAccount with a set of Vault policies.";
        type = types.str;
      };
      "secretRef" = mkOption {
        description = "Optional secret field containing a Kubernetes ServiceAccount JWT used\nfor authenticating with Vault. If a name is specified without a key,\n`token` is the default. If one is not specified, the one bound to\nthe controller will be used.";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthKubernetesSecretRefModule);
        default = null;
      };
      "serviceAccountRef" = mkOption {
        description = "Optional service account field containing the name of a kubernetes ServiceAccount.\nIf the service account is specified, the service account secret token JWT will be used\nfor authenticating with Vault. If the service account selector is not supplied,\nthe secretRef will be used instead.";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthKubernetesServiceAccountRefModule);
        default = null;
      };
    };
  };
  mkGeneratorVaultDynamicSecretSpecProviderAuthKubernetes =
    res:
    {
      inherit (res) "mountPath";
      inherit (res) "role";
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkGeneratorVaultDynamicSecretSpecProviderAuthKubernetesSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."serviceAccountRef" != null) {
      "serviceAccountRef" =
        mkGeneratorVaultDynamicSecretSpecProviderAuthKubernetesServiceAccountRef
          res."serviceAccountRef";
    }
    // {
    };
  GeneratorVaultDynamicSecretSpecProviderAuthKubernetesSecretRefModule = types.submodule {
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
  mkGeneratorVaultDynamicSecretSpecProviderAuthKubernetesSecretRef =
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
  GeneratorVaultDynamicSecretSpecProviderAuthKubernetesServiceAccountRefModule = types.submodule {
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
  mkGeneratorVaultDynamicSecretSpecProviderAuthKubernetesServiceAccountRef =
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
  GeneratorVaultDynamicSecretSpecProviderAuthLdapModule = types.submodule {
    options = {
      "path" = mkOption {
        description = "Path where the LDAP authentication backend is mounted\nin Vault, e.g: \"ldap\"";
        type = types.str;
      };
      "secretRef" = mkOption {
        description = "SecretRef to a key in a Secret resource containing password for the LDAP\nuser used to authenticate with Vault using the LDAP authentication\nmethod";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthLdapSecretRefModule);
        default = null;
      };
      "username" = mkOption {
        description = "Username is an LDAP username used to authenticate using the LDAP Vault\nauthentication method";
        type = types.str;
      };
    };
  };
  mkGeneratorVaultDynamicSecretSpecProviderAuthLdap =
    res:
    {
      inherit (res) "path";
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkGeneratorVaultDynamicSecretSpecProviderAuthLdapSecretRef res."secretRef";
    }
    // {
      inherit (res) "username";
    };
  GeneratorVaultDynamicSecretSpecProviderAuthLdapSecretRefModule = types.submodule {
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
  mkGeneratorVaultDynamicSecretSpecProviderAuthLdapSecretRef =
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
  GeneratorVaultDynamicSecretSpecProviderAuthModule = types.submodule {
    options = {
      "appRole" = mkOption {
        description = "AppRole authenticates with Vault using the App Role auth mechanism,\nwith the role and secret stored in a Kubernetes Secret resource.";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthAppRoleModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Cert authenticates with TLS Certificates by passing client certificate, private key and ca certificate\nCert authentication method";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthCertModule);
        default = null;
      };
      "gcp" = mkOption {
        description = "Gcp authenticates with Vault using Google Cloud Platform authentication method\nGCP authentication method";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthGcpModule);
        default = null;
      };
      "iam" = mkOption {
        description = "Iam authenticates with vault by passing a special AWS request signed with AWS IAM credentials\nAWS IAM authentication method";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthIamModule);
        default = null;
      };
      "jwt" = mkOption {
        description = "Jwt authenticates with Vault by passing role and JWT token using the\nJWT/OIDC authentication method";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthJwtModule);
        default = null;
      };
      "kubernetes" = mkOption {
        description = "Kubernetes authenticates with Vault by passing the ServiceAccount\ntoken stored in the named Secret resource to the Vault server.";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthKubernetesModule);
        default = null;
      };
      "ldap" = mkOption {
        description = "Ldap authenticates with Vault by passing username/password pair using\nthe LDAP authentication method";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthLdapModule);
        default = null;
      };
      "namespace" = mkOption {
        description = "Name of the vault namespace to authenticate to. This can be different than the namespace your secret is in.\nNamespaces is a set of features within Vault Enterprise that allows\nVault environments to support Secure Multi-tenancy. e.g: \"ns1\".\nMore about namespaces can be found here https://www.vaultproject.io/docs/enterprise/namespaces\nThis will default to Vault.Namespace field if set, or empty otherwise";
        type = (types.nullOr types.str);
        default = null;
      };
      "tokenSecretRef" = mkOption {
        description = "TokenSecretRef authenticates with Vault by presenting a token.";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthTokenSecretRefModule);
        default = null;
      };
      "userPass" = mkOption {
        description = "UserPass authenticates with Vault by passing username/password pair";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthUserPassModule);
        default = null;
      };
    };
  };
  mkGeneratorVaultDynamicSecretSpecProviderAuth =
    res:
    {
    }
    // optionalAttrs (res."appRole" != null) {
      "appRole" = mkGeneratorVaultDynamicSecretSpecProviderAuthAppRole res."appRole";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkGeneratorVaultDynamicSecretSpecProviderAuthCert res."cert";
    }
    // {
    }
    // optionalAttrs (res."gcp" != null) {
      "gcp" = mkGeneratorVaultDynamicSecretSpecProviderAuthGcp res."gcp";
    }
    // {
    }
    // optionalAttrs (res."iam" != null) {
      "iam" = mkGeneratorVaultDynamicSecretSpecProviderAuthIam res."iam";
    }
    // {
    }
    // optionalAttrs (res."jwt" != null) {
      "jwt" = mkGeneratorVaultDynamicSecretSpecProviderAuthJwt res."jwt";
    }
    // {
    }
    // optionalAttrs (res."kubernetes" != null) {
      "kubernetes" = mkGeneratorVaultDynamicSecretSpecProviderAuthKubernetes res."kubernetes";
    }
    // {
    }
    // optionalAttrs (res."ldap" != null) {
      "ldap" = mkGeneratorVaultDynamicSecretSpecProviderAuthLdap res."ldap";
    }
    // {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    }
    // optionalAttrs (res."tokenSecretRef" != null) {
      "tokenSecretRef" = mkGeneratorVaultDynamicSecretSpecProviderAuthTokenSecretRef res."tokenSecretRef";
    }
    // {
    }
    // optionalAttrs (res."userPass" != null) {
      "userPass" = mkGeneratorVaultDynamicSecretSpecProviderAuthUserPass res."userPass";
    }
    // {
    };
  GeneratorVaultDynamicSecretSpecProviderAuthTokenSecretRefModule = types.submodule {
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
  mkGeneratorVaultDynamicSecretSpecProviderAuthTokenSecretRef =
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
  GeneratorVaultDynamicSecretSpecProviderAuthUserPassModule = types.submodule {
    options = {
      "path" = mkOption {
        description = "Path where the UserPassword authentication backend is mounted\nin Vault, e.g: \"userpass\"";
        type = types.str;
      };
      "secretRef" = mkOption {
        description = "SecretRef to a key in a Secret resource containing password for the\nuser used to authenticate with Vault using the UserPass authentication\nmethod";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthUserPassSecretRefModule);
        default = null;
      };
      "username" = mkOption {
        description = "Username is a username used to authenticate using the UserPass Vault\nauthentication method";
        type = types.str;
      };
    };
  };
  mkGeneratorVaultDynamicSecretSpecProviderAuthUserPass =
    res:
    {
      inherit (res) "path";
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkGeneratorVaultDynamicSecretSpecProviderAuthUserPassSecretRef res."secretRef";
    }
    // {
      inherit (res) "username";
    };
  GeneratorVaultDynamicSecretSpecProviderAuthUserPassSecretRefModule = types.submodule {
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
  mkGeneratorVaultDynamicSecretSpecProviderAuthUserPassSecretRef =
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
  GeneratorVaultDynamicSecretSpecProviderCaProviderModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key where the CA certificate can be found in the Secret or ConfigMap.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "The name of the object located at the provider type.";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "The namespace the Provider type is in.\nCan only be defined when used in a ClusterSecretStore.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "The type of provider to use such as \"Secret\", or \"ConfigMap\".";
        type = (
          types.enum [
            "Secret"
            "ConfigMap"
          ]
        );
      };
    };
  };
  mkGeneratorVaultDynamicSecretSpecProviderCaProvider =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
      inherit (res) "type";
    };
  GeneratorVaultDynamicSecretSpecProviderCheckAndSetModule = types.submodule {
    options = {
      "required" = mkOption {
        description = "Required when true, all write operations must include a check-and-set parameter.\nThis helps prevent unintentional overwrites of secrets.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkGeneratorVaultDynamicSecretSpecProviderCheckAndSet =
    res:
    {
    }
    // optionalAttrs res."required" { inherit (res) "required"; }
    // {
    };
  GeneratorVaultDynamicSecretSpecProviderModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth configures how secret-manager authenticates with the Vault server.";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderAuthModule);
        default = null;
      };
      "caBundle" = mkOption {
        description = "PEM encoded CA bundle used to validate Vault server certificate. Only used\nif the Server URL is using HTTPS protocol. This parameter is ignored for\nplain HTTP protocol connection. If not set the system root certificates\nare used to validate the TLS connection.";
        type = (types.nullOr types.str);
        default = null;
      };
      "caProvider" = mkOption {
        description = "The provider for the CA bundle to use to validate Vault server certificate.";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderCaProviderModule);
        default = null;
      };
      "checkAndSet" = mkOption {
        description = "CheckAndSet defines the Check-And-Set (CAS) settings for PushSecret operations.\nOnly applies to Vault KV v2 stores. When enabled, write operations must include\nthe current version of the secret to prevent unintentional overwrites.";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderCheckAndSetModule);
        default = null;
      };
      "forwardInconsistent" = mkOption {
        description = "ForwardInconsistent tells Vault to forward read-after-write requests to the Vault\nleader instead of simply retrying within a loop. This can increase performance if\nthe option is enabled serverside.\nhttps://www.vaultproject.io/docs/configuration/replication#allow_forwarding_via_header";
        type = types.bool;
        default = false;
      };
      "headers" = mkOption {
        description = "Headers to be added in Vault request";
        type = (types.attrsOf types.str);
        default = { };
      };
      "namespace" = mkOption {
        description = "Name of the vault namespace. Namespaces is a set of features within Vault Enterprise that allows\nVault environments to support Secure Multi-tenancy. e.g: \"ns1\".\nMore about namespaces can be found here https://www.vaultproject.io/docs/enterprise/namespaces";
        type = (types.nullOr types.str);
        default = null;
      };
      "path" = mkOption {
        description = "Path is the mount path of the Vault KV backend endpoint, e.g:\n\"secret\". The v2 KV secret engine version specific \"/data\" path suffix\nfor fetching secrets from Vault is optional and will be appended\nif not present in specified path.";
        type = (types.nullOr types.str);
        default = null;
      };
      "readYourWrites" = mkOption {
        description = "ReadYourWrites ensures isolated read-after-write semantics by\nproviding discovered cluster replication states in each request.\nMore information about eventual consistency in Vault can be found here\nhttps://www.vaultproject.io/docs/enterprise/consistency";
        type = types.bool;
        default = false;
      };
      "server" = mkOption {
        description = "Server is the connection address for the Vault server, e.g: \"https://vault.example.com:8200\".";
        type = types.str;
      };
      "tls" = mkOption {
        description = "The configuration used for client side related TLS communication, when the Vault server\nrequires mutual authentication. Only used if the Server URL is using HTTPS protocol.\nThis parameter is ignored for plain HTTP protocol connection.\nIt's worth noting this configuration is different from the \"TLS certificates auth method\",\nwhich is available under the `auth.cert` section.";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderTlsModule);
        default = null;
      };
      "version" = mkOption {
        description = "Version is the Vault KV secret engine version. This can be either \"v1\" or\n\"v2\". Version defaults to \"v2\".";
        type = (
          types.nullOr (
            types.enum [
              "v1"
              "v2"
            ]
          )
        );
        default = "v2";
      };
    };
  };
  mkGeneratorVaultDynamicSecretSpecProvider =
    res:
    {
    }
    // optionalAttrs (res."auth" != null) {
      "auth" = mkGeneratorVaultDynamicSecretSpecProviderAuth res."auth";
    }
    // {
    }
    // optionalAttrs (res."caBundle" != null) { inherit (res) "caBundle"; }
    // {
    }
    // optionalAttrs (res."caProvider" != null) {
      "caProvider" = mkGeneratorVaultDynamicSecretSpecProviderCaProvider res."caProvider";
    }
    // {
    }
    // optionalAttrs (res."checkAndSet" != null) {
      "checkAndSet" = mkGeneratorVaultDynamicSecretSpecProviderCheckAndSet res."checkAndSet";
    }
    // {
    }
    // optionalAttrs res."forwardInconsistent" { inherit (res) "forwardInconsistent"; }
    // {
    }
    // optionalAttrs (res."headers" != { }) { inherit (res) "headers"; }
    // {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs res."readYourWrites" { inherit (res) "readYourWrites"; }
    // {
      inherit (res) "server";
    }
    // optionalAttrs (res."tls" != null) {
      "tls" = mkGeneratorVaultDynamicSecretSpecProviderTls res."tls";
    }
    // {
    }
    // optionalAttrs (res."version" != null) { inherit (res) "version"; }
    // {
    };
  GeneratorVaultDynamicSecretSpecProviderTlsCertSecretRefModule = types.submodule {
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
  mkGeneratorVaultDynamicSecretSpecProviderTlsCertSecretRef =
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
  GeneratorVaultDynamicSecretSpecProviderTlsKeySecretRefModule = types.submodule {
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
  mkGeneratorVaultDynamicSecretSpecProviderTlsKeySecretRef =
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
  GeneratorVaultDynamicSecretSpecProviderTlsModule = types.submodule {
    options = {
      "certSecretRef" = mkOption {
        description = "CertSecretRef is a certificate added to the transport layer\nwhen communicating with the Vault server.\nIf no key for the Secret is specified, external-secret will default to 'tls.crt'.";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderTlsCertSecretRefModule);
        default = null;
      };
      "keySecretRef" = mkOption {
        description = "KeySecretRef to a key in a Secret resource containing client private key\nadded to the transport layer when communicating with the Vault server.\nIf no key for the Secret is specified, external-secret will default to 'tls.key'.";
        type = (types.nullOr GeneratorVaultDynamicSecretSpecProviderTlsKeySecretRefModule);
        default = null;
      };
    };
  };
  mkGeneratorVaultDynamicSecretSpecProviderTls =
    res:
    {
    }
    // optionalAttrs (res."certSecretRef" != null) {
      "certSecretRef" = mkGeneratorVaultDynamicSecretSpecProviderTlsCertSecretRef res."certSecretRef";
    }
    // {
    }
    // optionalAttrs (res."keySecretRef" != null) {
      "keySecretRef" = mkGeneratorVaultDynamicSecretSpecProviderTlsKeySecretRef res."keySecretRef";
    }
    // {
    };
  GeneratorVaultDynamicSecretSpecRetrySettingsModule = types.submodule {
    options = {
      "maxRetries" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "retryInterval" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkGeneratorVaultDynamicSecretSpecRetrySettings =
    res:
    {
    }
    // optionalAttrs (res."maxRetries" != null) { inherit (res) "maxRetries"; }
    // {
    }
    // optionalAttrs (res."retryInterval" != null) { inherit (res) "retryInterval"; }
    // {
    };
  GeneratorWebhookSpecAuthModule = types.submodule {
    options = {
      "ntlm" = mkOption {
        description = "NTLMProtocol configures the store to use NTLM for auth";
        type = (types.nullOr GeneratorWebhookSpecAuthNtlmModule);
        default = null;
      };
    };
  };
  mkGeneratorWebhookSpecAuth =
    res:
    {
    }
    // optionalAttrs (res."ntlm" != null) { "ntlm" = mkGeneratorWebhookSpecAuthNtlm res."ntlm"; }
    // {
    };
  GeneratorWebhookSpecAuthNtlmModule = types.submodule {
    options = {
      "passwordSecret" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = GeneratorWebhookSpecAuthNtlmPasswordSecretModule;
      };
      "usernameSecret" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = GeneratorWebhookSpecAuthNtlmUsernameSecretModule;
      };
    };
  };
  mkGeneratorWebhookSpecAuthNtlm = res: {
    "passwordSecret" = mkGeneratorWebhookSpecAuthNtlmPasswordSecret res."passwordSecret";
    "usernameSecret" = mkGeneratorWebhookSpecAuthNtlmUsernameSecret res."usernameSecret";
  };
  GeneratorWebhookSpecAuthNtlmPasswordSecretModule = types.submodule {
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
  mkGeneratorWebhookSpecAuthNtlmPasswordSecret =
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
  GeneratorWebhookSpecAuthNtlmUsernameSecretModule = types.submodule {
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
  mkGeneratorWebhookSpecAuthNtlmUsernameSecret =
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
  GeneratorWebhookSpecCaProviderModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key where the CA certificate can be found in the Secret or ConfigMap.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "The name of the object located at the provider type.";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "The namespace the Provider type is in.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "The type of provider to use such as \"Secret\", or \"ConfigMap\".";
        type = (
          types.enum [
            "Secret"
            "ConfigMap"
          ]
        );
      };
    };
  };
  mkGeneratorWebhookSpecCaProvider =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
      inherit (res) "type";
    };
  GeneratorWebhookSpecModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth specifies a authorization protocol. Only one protocol may be set.";
        type = (types.nullOr GeneratorWebhookSpecAuthModule);
        default = null;
      };
      "body" = mkOption {
        description = "Body";
        type = (types.nullOr types.str);
        default = null;
      };
      "caBundle" = mkOption {
        description = "PEM encoded CA bundle used to validate webhook server certificate. Only used\nif the Server URL is using HTTPS protocol. This parameter is ignored for\nplain HTTP protocol connection. If not set the system root certificates\nare used to validate the TLS connection.";
        type = (types.nullOr types.str);
        default = null;
      };
      "caProvider" = mkOption {
        description = "The provider for the CA bundle to use to validate webhook server certificate.";
        type = (types.nullOr GeneratorWebhookSpecCaProviderModule);
        default = null;
      };
      "headers" = mkOption {
        description = "Headers";
        type = (types.attrsOf types.str);
        default = { };
      };
      "method" = mkOption {
        description = "Webhook Method";
        type = (types.nullOr types.str);
        default = null;
      };
      "result" = mkOption {
        description = "Result formatting";
        type = GeneratorWebhookSpecResultModule;
      };
      "secrets" = mkOption {
        description = "Secrets to fill in templates\nThese secrets will be passed to the templating function as key value pairs under the given name";
        type = (types.listOf GeneratorWebhookSpecSecretModule);
        default = [ ];
      };
      "timeout" = mkOption {
        description = "Timeout";
        type = (types.nullOr types.str);
        default = null;
      };
      "url" = mkOption {
        description = "Webhook url to call";
        type = types.str;
      };
    };
  };
  mkGeneratorWebhookSpec =
    res:
    {
    }
    // optionalAttrs (res."auth" != null) { "auth" = mkGeneratorWebhookSpecAuth res."auth"; }
    // {
    }
    // optionalAttrs (res."body" != null) { inherit (res) "body"; }
    // {
    }
    // optionalAttrs (res."caBundle" != null) { inherit (res) "caBundle"; }
    // {
    }
    // optionalAttrs (res."caProvider" != null) {
      "caProvider" = mkGeneratorWebhookSpecCaProvider res."caProvider";
    }
    // {
    }
    // optionalAttrs (res."headers" != { }) { inherit (res) "headers"; }
    // {
    }
    // optionalAttrs (res."method" != null) { inherit (res) "method"; }
    // {
      "result" = mkGeneratorWebhookSpecResult res."result";
    }
    // optionalAttrs (res."secrets" != [ ]) {
      "secrets" = map mkGeneratorWebhookSpecSecret res."secrets";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
      inherit (res) "url";
    };
  GeneratorWebhookSpecResultModule = types.submodule {
    options = {
      "jsonPath" = mkOption {
        description = "Json path of return value";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkGeneratorWebhookSpecResult =
    res:
    {
    }
    // optionalAttrs (res."jsonPath" != null) { inherit (res) "jsonPath"; }
    // {
    };
  GeneratorWebhookSpecSecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of this secret in templates";
        type = types.str;
      };
      "secretRef" = mkOption {
        description = "Secret ref to fill in credentials";
        type = GeneratorWebhookSpecSecretSecretRefModule;
      };
    };
  };
  mkGeneratorWebhookSpecSecret = res: {
    inherit (res) "name";
    "secretRef" = mkGeneratorWebhookSpecSecretSecretRef res."secretRef";
  };
  GeneratorWebhookSpecSecretSecretRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key where the token is found.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "The name of the Secret resource being referred to.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkGeneratorWebhookSpecSecretSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ClustergeneratorsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this ClusterGenerator resource.";
        };
        "generator" = mkOption {
          description = "Generator the spec for this generator, must match the kind.";
          type = GeneratorModule;
        };
        "kind" = mkOption {
          description = "Kind the kind of this generator.";
          type = (
            types.enum [
              "ACRAccessToken"
              "CloudsmithAccessToken"
              "ECRAuthorizationToken"
              "Fake"
              "GCRAccessToken"
              "GithubAccessToken"
              "QuayAccessToken"
              "Password"
              "SSHKey"
              "STSSessionToken"
              "UUID"
              "VaultDynamicSecret"
              "Webhook"
              "Grafana"
            ]
          );
        };
      };
    }
  );
  mkClusterGenerator = name: res: {
    apiVersion = "generators.external-secrets.io/v1alpha1";
    kind = "ClusterGenerator";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
      "generator" = mkGenerator res."generator";
      inherit (res) "kind";
    };
  };
  allResources = (mapAttrsToList mkClusterGenerator cfg."clustergenerators");
in
{
  options.openkrill.apps."external-secrets" = {
    "clustergenerators" = mkOption {
      type = types.attrsOf ClustergeneratorsModule;
      default = { };
      description = "ClusterGenerator CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."external-secrets".content = allResources;
  };
}
