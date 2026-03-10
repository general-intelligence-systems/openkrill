# Auto-generated openkrill module fragment for external-secrets
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."external-secrets";
  compact = filterAttrs (_: v: v != null);
  ProviderAuthAppRoleModule = types.submodule {
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
        type = (types.nullOr ProviderAuthAppRoleRoleRefModule);
        default = null;
      };
      "secretRef" = mkOption {
        description = "Reference to a key in a Secret that contains the App Role secret used\nto authenticate with Vault.\nThe `key` field must be specified and denotes which entry within the Secret\nresource is used as the app role secret.";
        type = ProviderAuthAppRoleSecretRefModule;
      };
    };
  };
  mkProviderAuthAppRole =
    res:
    {
      inherit (res) "path";
    }
    // optionalAttrs (res."roleId" != null) { inherit (res) "roleId"; }
    // {
    }
    // optionalAttrs (res."roleRef" != null) { "roleRef" = mkProviderAuthAppRoleRoleRef res."roleRef"; }
    // {
      "secretRef" = mkProviderAuthAppRoleSecretRef res."secretRef";
    };
  ProviderAuthAppRoleRoleRefModule = types.submodule {
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
  mkProviderAuthAppRoleRoleRef =
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
  ProviderAuthAppRoleSecretRefModule = types.submodule {
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
  mkProviderAuthAppRoleSecretRef =
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
  ProviderAuthCertClientCertModule = types.submodule {
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
  mkProviderAuthCertClientCert =
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
  ProviderAuthCertModule = types.submodule {
    options = {
      "clientCert" = mkOption {
        description = "ClientCert is a certificate to authenticate using the Cert Vault\nauthentication method";
        type = (types.nullOr ProviderAuthCertClientCertModule);
        default = null;
      };
      "path" = mkOption {
        description = "Path where the Certificate authentication backend is mounted\nin Vault, e.g: \"cert\"";
        type = (types.nullOr types.str);
        default = "cert";
      };
      "secretRef" = mkOption {
        description = "SecretRef to a key in a Secret resource containing client private key to\nauthenticate with Vault using the Cert authentication method";
        type = (types.nullOr ProviderAuthCertSecretRefModule);
        default = null;
      };
    };
  };
  mkProviderAuthCert =
    res:
    {
    }
    // optionalAttrs (res."clientCert" != null) {
      "clientCert" = mkProviderAuthCertClientCert res."clientCert";
    }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderAuthCertSecretRef res."secretRef";
    }
    // {
    };
  ProviderAuthCertSecretRefModule = types.submodule {
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
  mkProviderAuthCertSecretRef =
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
  ProviderAuthGcpModule = types.submodule {
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
        type = (types.nullOr ProviderAuthGcpSecretRefModule);
        default = null;
      };
      "serviceAccountRef" = mkOption {
        description = "ServiceAccountRef to a service account for impersonation";
        type = (types.nullOr ProviderAuthGcpServiceAccountRefModule);
        default = null;
      };
      "workloadIdentity" = mkOption {
        description = "Specify a service account with Workload Identity";
        type = (types.nullOr ProviderAuthGcpWorkloadIdentityModule);
        default = null;
      };
    };
  };
  mkProviderAuthGcp =
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
      "secretRef" = mkProviderAuthGcpSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."serviceAccountRef" != null) {
      "serviceAccountRef" = mkProviderAuthGcpServiceAccountRef res."serviceAccountRef";
    }
    // {
    }
    // optionalAttrs (res."workloadIdentity" != null) {
      "workloadIdentity" = mkProviderAuthGcpWorkloadIdentity res."workloadIdentity";
    }
    // {
    };
  ProviderAuthGcpSecretRefModule = types.submodule {
    options = {
      "secretAccessKeySecretRef" = mkOption {
        description = "The SecretAccessKey is used for authentication";
        type = (types.nullOr ProviderAuthGcpSecretRefSecretAccessKeySecretRefModule);
        default = null;
      };
    };
  };
  mkProviderAuthGcpSecretRef =
    res:
    {
    }
    // optionalAttrs (res."secretAccessKeySecretRef" != null) {
      "secretAccessKeySecretRef" =
        mkProviderAuthGcpSecretRefSecretAccessKeySecretRef
          res."secretAccessKeySecretRef";
    }
    // {
    };
  ProviderAuthGcpSecretRefSecretAccessKeySecretRefModule = types.submodule {
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
  mkProviderAuthGcpSecretRefSecretAccessKeySecretRef =
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
  ProviderAuthGcpServiceAccountRefModule = types.submodule {
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
  mkProviderAuthGcpServiceAccountRef =
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
  ProviderAuthGcpWorkloadIdentityModule = types.submodule {
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
        type = ProviderAuthGcpWorkloadIdentityServiceAccountRefModule;
      };
    };
  };
  mkProviderAuthGcpWorkloadIdentity =
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
      "serviceAccountRef" = mkProviderAuthGcpWorkloadIdentityServiceAccountRef res."serviceAccountRef";
    };
  ProviderAuthGcpWorkloadIdentityServiceAccountRefModule = types.submodule {
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
  mkProviderAuthGcpWorkloadIdentityServiceAccountRef =
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
  ProviderAuthIamJwtModule = types.submodule {
    options = {
      "serviceAccountRef" = mkOption {
        description = "ServiceAccountSelector is a reference to a ServiceAccount resource.";
        type = (types.nullOr ProviderAuthIamJwtServiceAccountRefModule);
        default = null;
      };
    };
  };
  mkProviderAuthIamJwt =
    res:
    {
    }
    // optionalAttrs (res."serviceAccountRef" != null) {
      "serviceAccountRef" = mkProviderAuthIamJwtServiceAccountRef res."serviceAccountRef";
    }
    // {
    };
  ProviderAuthIamJwtServiceAccountRefModule = types.submodule {
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
  mkProviderAuthIamJwtServiceAccountRef =
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
  ProviderAuthIamModule = types.submodule {
    options = {
      "externalID" = mkOption {
        description = "AWS External ID set on assumed IAM roles";
        type = (types.nullOr types.str);
        default = null;
      };
      "jwt" = mkOption {
        description = "Specify a service account with IRSA enabled";
        type = (types.nullOr ProviderAuthIamJwtModule);
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
        type = (types.nullOr ProviderAuthIamSecretRefModule);
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
  mkProviderAuthIam =
    res:
    {
    }
    // optionalAttrs (res."externalID" != null) { inherit (res) "externalID"; }
    // {
    }
    // optionalAttrs (res."jwt" != null) { "jwt" = mkProviderAuthIamJwt res."jwt"; }
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
      "secretRef" = mkProviderAuthIamSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."vaultAwsIamServerID" != null) { inherit (res) "vaultAwsIamServerID"; }
    // {
      inherit (res) "vaultRole";
    };
  ProviderAuthIamSecretRefAccessKeyIDSecretRefModule = types.submodule {
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
  mkProviderAuthIamSecretRefAccessKeyIDSecretRef =
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
  ProviderAuthIamSecretRefModule = types.submodule {
    options = {
      "accessKeyIDSecretRef" = mkOption {
        description = "The AccessKeyID is used for authentication";
        type = (types.nullOr ProviderAuthIamSecretRefAccessKeyIDSecretRefModule);
        default = null;
      };
      "secretAccessKeySecretRef" = mkOption {
        description = "The SecretAccessKey is used for authentication";
        type = (types.nullOr ProviderAuthIamSecretRefSecretAccessKeySecretRefModule);
        default = null;
      };
      "sessionTokenSecretRef" = mkOption {
        description = "The SessionToken used for authentication\nThis must be defined if AccessKeyID and SecretAccessKey are temporary credentials\nsee: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_use-resources.html";
        type = (types.nullOr ProviderAuthIamSecretRefSessionTokenSecretRefModule);
        default = null;
      };
    };
  };
  mkProviderAuthIamSecretRef =
    res:
    {
    }
    // optionalAttrs (res."accessKeyIDSecretRef" != null) {
      "accessKeyIDSecretRef" = mkProviderAuthIamSecretRefAccessKeyIDSecretRef res."accessKeyIDSecretRef";
    }
    // {
    }
    // optionalAttrs (res."secretAccessKeySecretRef" != null) {
      "secretAccessKeySecretRef" =
        mkProviderAuthIamSecretRefSecretAccessKeySecretRef
          res."secretAccessKeySecretRef";
    }
    // {
    }
    // optionalAttrs (res."sessionTokenSecretRef" != null) {
      "sessionTokenSecretRef" =
        mkProviderAuthIamSecretRefSessionTokenSecretRef
          res."sessionTokenSecretRef";
    }
    // {
    };
  ProviderAuthIamSecretRefSecretAccessKeySecretRefModule = types.submodule {
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
  mkProviderAuthIamSecretRefSecretAccessKeySecretRef =
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
  ProviderAuthIamSecretRefSessionTokenSecretRefModule = types.submodule {
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
  mkProviderAuthIamSecretRefSessionTokenSecretRef =
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
  ProviderAuthJwtKubernetesServiceAccountTokenModule = types.submodule {
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
        type = ProviderAuthJwtKubernetesServiceAccountTokenServiceAccountRefModule;
      };
    };
  };
  mkProviderAuthJwtKubernetesServiceAccountToken =
    res:
    {
    }
    // optionalAttrs (res."audiences" != [ ]) { inherit (res) "audiences"; }
    // {
    }
    // optionalAttrs (res."expirationSeconds" != null) { inherit (res) "expirationSeconds"; }
    // {
      "serviceAccountRef" =
        mkProviderAuthJwtKubernetesServiceAccountTokenServiceAccountRef
          res."serviceAccountRef";
    };
  ProviderAuthJwtKubernetesServiceAccountTokenServiceAccountRefModule = types.submodule {
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
  mkProviderAuthJwtKubernetesServiceAccountTokenServiceAccountRef =
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
  ProviderAuthJwtModule = types.submodule {
    options = {
      "kubernetesServiceAccountToken" = mkOption {
        description = "Optional ServiceAccountToken specifies the Kubernetes service account for which to request\na token for with the `TokenRequest` API.";
        type = (types.nullOr ProviderAuthJwtKubernetesServiceAccountTokenModule);
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
        type = (types.nullOr ProviderAuthJwtSecretRefModule);
        default = null;
      };
    };
  };
  mkProviderAuthJwt =
    res:
    {
    }
    // optionalAttrs (res."kubernetesServiceAccountToken" != null) {
      "kubernetesServiceAccountToken" =
        mkProviderAuthJwtKubernetesServiceAccountToken
          res."kubernetesServiceAccountToken";
    }
    // {
      inherit (res) "path";
    }
    // optionalAttrs (res."role" != null) { inherit (res) "role"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderAuthJwtSecretRef res."secretRef";
    }
    // {
    };
  ProviderAuthJwtSecretRefModule = types.submodule {
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
  mkProviderAuthJwtSecretRef =
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
  ProviderAuthKubernetesModule = types.submodule {
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
        type = (types.nullOr ProviderAuthKubernetesSecretRefModule);
        default = null;
      };
      "serviceAccountRef" = mkOption {
        description = "Optional service account field containing the name of a kubernetes ServiceAccount.\nIf the service account is specified, the service account secret token JWT will be used\nfor authenticating with Vault. If the service account selector is not supplied,\nthe secretRef will be used instead.";
        type = (types.nullOr ProviderAuthKubernetesServiceAccountRefModule);
        default = null;
      };
    };
  };
  mkProviderAuthKubernetes =
    res:
    {
      inherit (res) "mountPath";
      inherit (res) "role";
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderAuthKubernetesSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."serviceAccountRef" != null) {
      "serviceAccountRef" = mkProviderAuthKubernetesServiceAccountRef res."serviceAccountRef";
    }
    // {
    };
  ProviderAuthKubernetesSecretRefModule = types.submodule {
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
  mkProviderAuthKubernetesSecretRef =
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
  ProviderAuthKubernetesServiceAccountRefModule = types.submodule {
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
  mkProviderAuthKubernetesServiceAccountRef =
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
  ProviderAuthLdapModule = types.submodule {
    options = {
      "path" = mkOption {
        description = "Path where the LDAP authentication backend is mounted\nin Vault, e.g: \"ldap\"";
        type = types.str;
      };
      "secretRef" = mkOption {
        description = "SecretRef to a key in a Secret resource containing password for the LDAP\nuser used to authenticate with Vault using the LDAP authentication\nmethod";
        type = (types.nullOr ProviderAuthLdapSecretRefModule);
        default = null;
      };
      "username" = mkOption {
        description = "Username is an LDAP username used to authenticate using the LDAP Vault\nauthentication method";
        type = types.str;
      };
    };
  };
  mkProviderAuthLdap =
    res:
    {
      inherit (res) "path";
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderAuthLdapSecretRef res."secretRef";
    }
    // {
      inherit (res) "username";
    };
  ProviderAuthLdapSecretRefModule = types.submodule {
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
  mkProviderAuthLdapSecretRef =
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
  ProviderAuthModule = types.submodule {
    options = {
      "appRole" = mkOption {
        description = "AppRole authenticates with Vault using the App Role auth mechanism,\nwith the role and secret stored in a Kubernetes Secret resource.";
        type = (types.nullOr ProviderAuthAppRoleModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Cert authenticates with TLS Certificates by passing client certificate, private key and ca certificate\nCert authentication method";
        type = (types.nullOr ProviderAuthCertModule);
        default = null;
      };
      "gcp" = mkOption {
        description = "Gcp authenticates with Vault using Google Cloud Platform authentication method\nGCP authentication method";
        type = (types.nullOr ProviderAuthGcpModule);
        default = null;
      };
      "iam" = mkOption {
        description = "Iam authenticates with vault by passing a special AWS request signed with AWS IAM credentials\nAWS IAM authentication method";
        type = (types.nullOr ProviderAuthIamModule);
        default = null;
      };
      "jwt" = mkOption {
        description = "Jwt authenticates with Vault by passing role and JWT token using the\nJWT/OIDC authentication method";
        type = (types.nullOr ProviderAuthJwtModule);
        default = null;
      };
      "kubernetes" = mkOption {
        description = "Kubernetes authenticates with Vault by passing the ServiceAccount\ntoken stored in the named Secret resource to the Vault server.";
        type = (types.nullOr ProviderAuthKubernetesModule);
        default = null;
      };
      "ldap" = mkOption {
        description = "Ldap authenticates with Vault by passing username/password pair using\nthe LDAP authentication method";
        type = (types.nullOr ProviderAuthLdapModule);
        default = null;
      };
      "namespace" = mkOption {
        description = "Name of the vault namespace to authenticate to. This can be different than the namespace your secret is in.\nNamespaces is a set of features within Vault Enterprise that allows\nVault environments to support Secure Multi-tenancy. e.g: \"ns1\".\nMore about namespaces can be found here https://www.vaultproject.io/docs/enterprise/namespaces\nThis will default to Vault.Namespace field if set, or empty otherwise";
        type = (types.nullOr types.str);
        default = null;
      };
      "tokenSecretRef" = mkOption {
        description = "TokenSecretRef authenticates with Vault by presenting a token.";
        type = (types.nullOr ProviderAuthTokenSecretRefModule);
        default = null;
      };
      "userPass" = mkOption {
        description = "UserPass authenticates with Vault by passing username/password pair";
        type = (types.nullOr ProviderAuthUserPassModule);
        default = null;
      };
    };
  };
  mkProviderAuth =
    res:
    {
    }
    // optionalAttrs (res."appRole" != null) { "appRole" = mkProviderAuthAppRole res."appRole"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkProviderAuthCert res."cert"; }
    // {
    }
    // optionalAttrs (res."gcp" != null) { "gcp" = mkProviderAuthGcp res."gcp"; }
    // {
    }
    // optionalAttrs (res."iam" != null) { "iam" = mkProviderAuthIam res."iam"; }
    // {
    }
    // optionalAttrs (res."jwt" != null) { "jwt" = mkProviderAuthJwt res."jwt"; }
    // {
    }
    // optionalAttrs (res."kubernetes" != null) {
      "kubernetes" = mkProviderAuthKubernetes res."kubernetes";
    }
    // {
    }
    // optionalAttrs (res."ldap" != null) { "ldap" = mkProviderAuthLdap res."ldap"; }
    // {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    }
    // optionalAttrs (res."tokenSecretRef" != null) {
      "tokenSecretRef" = mkProviderAuthTokenSecretRef res."tokenSecretRef";
    }
    // {
    }
    // optionalAttrs (res."userPass" != null) { "userPass" = mkProviderAuthUserPass res."userPass"; }
    // {
    };
  ProviderAuthTokenSecretRefModule = types.submodule {
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
  mkProviderAuthTokenSecretRef =
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
  ProviderAuthUserPassModule = types.submodule {
    options = {
      "path" = mkOption {
        description = "Path where the UserPassword authentication backend is mounted\nin Vault, e.g: \"userpass\"";
        type = types.str;
      };
      "secretRef" = mkOption {
        description = "SecretRef to a key in a Secret resource containing password for the\nuser used to authenticate with Vault using the UserPass authentication\nmethod";
        type = (types.nullOr ProviderAuthUserPassSecretRefModule);
        default = null;
      };
      "username" = mkOption {
        description = "Username is a username used to authenticate using the UserPass Vault\nauthentication method";
        type = types.str;
      };
    };
  };
  mkProviderAuthUserPass =
    res:
    {
      inherit (res) "path";
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderAuthUserPassSecretRef res."secretRef";
    }
    // {
      inherit (res) "username";
    };
  ProviderAuthUserPassSecretRefModule = types.submodule {
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
  mkProviderAuthUserPassSecretRef =
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
  ProviderCaProviderModule = types.submodule {
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
  mkProviderCaProvider =
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
  ProviderCheckAndSetModule = types.submodule {
    options = {
      "required" = mkOption {
        description = "Required when true, all write operations must include a check-and-set parameter.\nThis helps prevent unintentional overwrites of secrets.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProviderCheckAndSet =
    res:
    {
    }
    // optionalAttrs res."required" { inherit (res) "required"; }
    // {
    };
  ProviderModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth configures how secret-manager authenticates with the Vault server.";
        type = (types.nullOr ProviderAuthModule);
        default = null;
      };
      "caBundle" = mkOption {
        description = "PEM encoded CA bundle used to validate Vault server certificate. Only used\nif the Server URL is using HTTPS protocol. This parameter is ignored for\nplain HTTP protocol connection. If not set the system root certificates\nare used to validate the TLS connection.";
        type = (types.nullOr types.str);
        default = null;
      };
      "caProvider" = mkOption {
        description = "The provider for the CA bundle to use to validate Vault server certificate.";
        type = (types.nullOr ProviderCaProviderModule);
        default = null;
      };
      "checkAndSet" = mkOption {
        description = "CheckAndSet defines the Check-And-Set (CAS) settings for PushSecret operations.\nOnly applies to Vault KV v2 stores. When enabled, write operations must include\nthe current version of the secret to prevent unintentional overwrites.";
        type = (types.nullOr ProviderCheckAndSetModule);
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
        type = (types.nullOr ProviderTlsModule);
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
  mkProvider =
    res:
    {
    }
    // optionalAttrs (res."auth" != null) { "auth" = mkProviderAuth res."auth"; }
    // {
    }
    // optionalAttrs (res."caBundle" != null) { inherit (res) "caBundle"; }
    // {
    }
    // optionalAttrs (res."caProvider" != null) {
      "caProvider" = mkProviderCaProvider res."caProvider";
    }
    // {
    }
    // optionalAttrs (res."checkAndSet" != null) {
      "checkAndSet" = mkProviderCheckAndSet res."checkAndSet";
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
    // optionalAttrs (res."tls" != null) { "tls" = mkProviderTls res."tls"; }
    // {
    }
    // optionalAttrs (res."version" != null) { inherit (res) "version"; }
    // {
    };
  ProviderTlsCertSecretRefModule = types.submodule {
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
  mkProviderTlsCertSecretRef =
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
  ProviderTlsKeySecretRefModule = types.submodule {
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
  mkProviderTlsKeySecretRef =
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
  ProviderTlsModule = types.submodule {
    options = {
      "certSecretRef" = mkOption {
        description = "CertSecretRef is a certificate added to the transport layer\nwhen communicating with the Vault server.\nIf no key for the Secret is specified, external-secret will default to 'tls.crt'.";
        type = (types.nullOr ProviderTlsCertSecretRefModule);
        default = null;
      };
      "keySecretRef" = mkOption {
        description = "KeySecretRef to a key in a Secret resource containing client private key\nadded to the transport layer when communicating with the Vault server.\nIf no key for the Secret is specified, external-secret will default to 'tls.key'.";
        type = (types.nullOr ProviderTlsKeySecretRefModule);
        default = null;
      };
    };
  };
  mkProviderTls =
    res:
    {
    }
    // optionalAttrs (res."certSecretRef" != null) {
      "certSecretRef" = mkProviderTlsCertSecretRef res."certSecretRef";
    }
    // {
    }
    // optionalAttrs (res."keySecretRef" != null) {
      "keySecretRef" = mkProviderTlsKeySecretRef res."keySecretRef";
    }
    // {
    };
  RetrySettingsModule = types.submodule {
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
  mkRetrySettings =
    res:
    {
    }
    // optionalAttrs (res."maxRetries" != null) { inherit (res) "maxRetries"; }
    // {
    }
    // optionalAttrs (res."retryInterval" != null) { inherit (res) "retryInterval"; }
    // {
    };
  VaultdynamicsecretsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this VaultDynamicSecret resource.";
        };
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
          type = ProviderModule;
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
          type = (types.nullOr RetrySettingsModule);
          default = null;
        };
      };
    }
  );
  mkVaultDynamicSecret = name: res: {
    apiVersion = "generators.external-secrets.io/v1alpha1";
    kind = "VaultDynamicSecret";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
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
      "provider" = mkProvider res."provider";
    }
    // optionalAttrs (res."resultType" != null) { inherit (res) "resultType"; }
    // {
    }
    // optionalAttrs (res."retrySettings" != null) {
      "retrySettings" = mkRetrySettings res."retrySettings";
    }
    // {
    };
  };
  allResources = (mapAttrsToList mkVaultDynamicSecret cfg."vaultdynamicsecrets");
in
{
  options.openkrill.apps."external-secrets" = {
    "vaultdynamicsecrets" = mkOption {
      type = types.attrsOf VaultdynamicsecretsModule;
      default = { };
      description = "VaultDynamicSecret CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."external-secrets".content = allResources;
  };
}
