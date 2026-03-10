# Auto-generated openkrill module fragment for external-secrets
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."external-secrets";
  compact = filterAttrs (_: v: v != null);
  AuthManagedIdentityModule = types.submodule {
    options = {
      "identityId" = mkOption {
        description = "If multiple Managed Identity is assigned to the pod, you can select the one to be used";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkAuthManagedIdentity =
    res:
    {
    }
    // optionalAttrs (res."identityId" != null) { inherit (res) "identityId"; }
    // {
    };
  AuthModule = types.submodule {
    options = {
      "managedIdentity" = mkOption {
        description = "ManagedIdentity uses Azure Managed Identity to authenticate with Azure.";
        type = (types.nullOr AuthManagedIdentityModule);
        default = null;
      };
      "servicePrincipal" = mkOption {
        description = "ServicePrincipal uses Azure Service Principal credentials to authenticate with Azure.";
        type = (types.nullOr AuthServicePrincipalModule);
        default = null;
      };
      "workloadIdentity" = mkOption {
        description = "WorkloadIdentity uses Azure Workload Identity to authenticate with Azure.";
        type = (types.nullOr AuthWorkloadIdentityModule);
        default = null;
      };
    };
  };
  mkAuth =
    res:
    {
    }
    // optionalAttrs (res."managedIdentity" != null) {
      "managedIdentity" = mkAuthManagedIdentity res."managedIdentity";
    }
    // {
    }
    // optionalAttrs (res."servicePrincipal" != null) {
      "servicePrincipal" = mkAuthServicePrincipal res."servicePrincipal";
    }
    // {
    }
    // optionalAttrs (res."workloadIdentity" != null) {
      "workloadIdentity" = mkAuthWorkloadIdentity res."workloadIdentity";
    }
    // {
    };
  AuthServicePrincipalModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "AzureACRServicePrincipalAuthSecretRef defines the secret references for Azure Service Principal authentication.\nIt uses static credentials stored in a Kind=Secret.";
        type = AuthServicePrincipalSecretRefModule;
      };
    };
  };
  mkAuthServicePrincipal = res: {
    "secretRef" = mkAuthServicePrincipalSecretRef res."secretRef";
  };
  AuthServicePrincipalSecretRefClientIdModule = types.submodule {
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
  mkAuthServicePrincipalSecretRefClientId =
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
  AuthServicePrincipalSecretRefClientSecretModule = types.submodule {
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
  mkAuthServicePrincipalSecretRefClientSecret =
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
  AuthServicePrincipalSecretRefModule = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "The Azure clientId of the service principle used for authentication.";
        type = (types.nullOr AuthServicePrincipalSecretRefClientIdModule);
        default = null;
      };
      "clientSecret" = mkOption {
        description = "The Azure ClientSecret of the service principle used for authentication.";
        type = (types.nullOr AuthServicePrincipalSecretRefClientSecretModule);
        default = null;
      };
    };
  };
  mkAuthServicePrincipalSecretRef =
    res:
    {
    }
    // optionalAttrs (res."clientId" != null) {
      "clientId" = mkAuthServicePrincipalSecretRefClientId res."clientId";
    }
    // {
    }
    // optionalAttrs (res."clientSecret" != null) {
      "clientSecret" = mkAuthServicePrincipalSecretRefClientSecret res."clientSecret";
    }
    // {
    };
  AuthWorkloadIdentityModule = types.submodule {
    options = {
      "serviceAccountRef" = mkOption {
        description = "ServiceAccountRef specified the service account\nthat should be used when authenticating with WorkloadIdentity.";
        type = (types.nullOr AuthWorkloadIdentityServiceAccountRefModule);
        default = null;
      };
    };
  };
  mkAuthWorkloadIdentity =
    res:
    {
    }
    // optionalAttrs (res."serviceAccountRef" != null) {
      "serviceAccountRef" = mkAuthWorkloadIdentityServiceAccountRef res."serviceAccountRef";
    }
    // {
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
  AcraccesstokensModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this ACRAccessToken resource.";
        };
        "auth" = mkOption {
          description = "ACRAuth defines the authentication methods for Azure Container Registry.";
          type = AuthModule;
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
    }
  );
  mkACRAccessToken = name: res: {
    apiVersion = "generators.external-secrets.io/v1alpha1";
    kind = "ACRAccessToken";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
      "auth" = mkAuth res."auth";
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
  };
  allResources = (mapAttrsToList mkACRAccessToken cfg."acraccesstokens");
in
{
  options.openkrill.apps."external-secrets" = {
    "acraccesstokens" = mkOption {
      type = types.attrsOf AcraccesstokensModule;
      default = { };
      description = "ACRAccessToken CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."external-secrets".content = allResources;
  };
}
