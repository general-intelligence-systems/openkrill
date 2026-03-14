# Auto-generated openkrill module fragment for external-secrets
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."external-secrets";
  compact = filterAttrs (_: v: v != null);
  ConditionModule = types.submodule {
    options = {
      "namespaceRegexes" = mkOption {
        description = "Choose namespaces by using regex matching";
        type = (types.listOf types.str);
        default = [ ];
      };
      "namespaceSelector" = mkOption {
        description = "Choose namespace using a labelSelector";
        type = (types.nullOr ConditionNamespaceSelectorModule);
        default = null;
      };
      "namespaces" = mkOption {
        description = "Choose namespaces by name";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkCondition =
    res:
    {
    }
    // optionalAttrs (res."namespaceRegexes" != [ ]) { inherit (res) "namespaceRegexes"; }
    // {
    }
    // optionalAttrs (res."namespaceSelector" != null) {
      "namespaceSelector" = mkConditionNamespaceSelector res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
    };
  ConditionNamespaceSelectorMatchExpressionModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the label key that the selector applies to.";
        type = types.str;
      };
      "operator" = mkOption {
        description = "operator represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists and DoesNotExist.";
        type = types.str;
      };
      "values" = mkOption {
        description = "values is an array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. This array is replaced during a strategic\nmerge patch.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkConditionNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ConditionNamespaceSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf ConditionNamespaceSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkConditionNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkConditionNamespaceSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderAkeylessAuthSecretRefKubernetesAuthModule = types.submodule {
    options = {
      "accessID" = mkOption {
        description = "the Akeyless Kubernetes auth-method access-id";
        type = types.str;
      };
      "k8sConfName" = mkOption {
        description = "Kubernetes-auth configuration name in Akeyless-Gateway";
        type = types.str;
      };
      "secretRef" = mkOption {
        description = "Optional secret field containing a Kubernetes ServiceAccount JWT used\nfor authenticating with Akeyless. If a name is specified without a key,\n`token` is the default. If one is not specified, the one bound to\nthe controller will be used.";
        type = (types.nullOr ProviderAkeylessAuthSecretRefKubernetesAuthSecretRefModule);
        default = null;
      };
      "serviceAccountRef" = mkOption {
        description = "Optional service account field containing the name of a kubernetes ServiceAccount.\nIf the service account is specified, the service account secret token JWT will be used\nfor authenticating with Akeyless. If the service account selector is not supplied,\nthe secretRef will be used instead.";
        type = (types.nullOr ProviderAkeylessAuthSecretRefKubernetesAuthServiceAccountRefModule);
        default = null;
      };
    };
  };
  mkProviderAkeylessAuthSecretRefKubernetesAuth =
    res:
    {
      inherit (res) "accessID";
      inherit (res) "k8sConfName";
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderAkeylessAuthSecretRefKubernetesAuthSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."serviceAccountRef" != null) {
      "serviceAccountRef" =
        mkProviderAkeylessAuthSecretRefKubernetesAuthServiceAccountRef
          res."serviceAccountRef";
    }
    // {
    };
  ProviderAkeylessAuthSecretRefKubernetesAuthSecretRefModule = types.submodule {
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
  mkProviderAkeylessAuthSecretRefKubernetesAuthSecretRef =
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
  ProviderAkeylessAuthSecretRefKubernetesAuthServiceAccountRefModule = types.submodule {
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
  mkProviderAkeylessAuthSecretRefKubernetesAuthServiceAccountRef =
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
  ProviderAkeylessAuthSecretRefModule = types.submodule {
    options = {
      "kubernetesAuth" = mkOption {
        description = "Kubernetes authenticates with Akeyless by passing the ServiceAccount\ntoken stored in the named Secret resource.";
        type = (types.nullOr ProviderAkeylessAuthSecretRefKubernetesAuthModule);
        default = null;
      };
      "secretRef" = mkOption {
        description = "Reference to a Secret that contains the details\nto authenticate with Akeyless.";
        type = (types.nullOr ProviderAkeylessAuthSecretRefSecretRefModule);
        default = null;
      };
    };
  };
  mkProviderAkeylessAuthSecretRef =
    res:
    {
    }
    // optionalAttrs (res."kubernetesAuth" != null) {
      "kubernetesAuth" = mkProviderAkeylessAuthSecretRefKubernetesAuth res."kubernetesAuth";
    }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderAkeylessAuthSecretRefSecretRef res."secretRef";
    }
    // {
    };
  ProviderAkeylessAuthSecretRefSecretRefAccessIDModule = types.submodule {
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
  mkProviderAkeylessAuthSecretRefSecretRefAccessID =
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
  ProviderAkeylessAuthSecretRefSecretRefAccessTypeModule = types.submodule {
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
  mkProviderAkeylessAuthSecretRefSecretRefAccessType =
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
  ProviderAkeylessAuthSecretRefSecretRefAccessTypeParamModule = types.submodule {
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
  mkProviderAkeylessAuthSecretRefSecretRefAccessTypeParam =
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
  ProviderAkeylessAuthSecretRefSecretRefModule = types.submodule {
    options = {
      "accessID" = mkOption {
        description = "The SecretAccessID is used for authentication";
        type = (types.nullOr ProviderAkeylessAuthSecretRefSecretRefAccessIDModule);
        default = null;
      };
      "accessType" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = (types.nullOr ProviderAkeylessAuthSecretRefSecretRefAccessTypeModule);
        default = null;
      };
      "accessTypeParam" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = (types.nullOr ProviderAkeylessAuthSecretRefSecretRefAccessTypeParamModule);
        default = null;
      };
    };
  };
  mkProviderAkeylessAuthSecretRefSecretRef =
    res:
    {
    }
    // optionalAttrs (res."accessID" != null) {
      "accessID" = mkProviderAkeylessAuthSecretRefSecretRefAccessID res."accessID";
    }
    // {
    }
    // optionalAttrs (res."accessType" != null) {
      "accessType" = mkProviderAkeylessAuthSecretRefSecretRefAccessType res."accessType";
    }
    // {
    }
    // optionalAttrs (res."accessTypeParam" != null) {
      "accessTypeParam" = mkProviderAkeylessAuthSecretRefSecretRefAccessTypeParam res."accessTypeParam";
    }
    // {
    };
  ProviderAkeylessCaProviderModule = types.submodule {
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
  mkProviderAkeylessCaProvider =
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
  ProviderAkeylessModule = types.submodule {
    options = {
      "akeylessGWApiURL" = mkOption {
        description = "Akeyless GW API Url from which the secrets to be fetched from.";
        type = types.str;
      };
      "authSecretRef" = mkOption {
        description = "Auth configures how the operator authenticates with Akeyless.";
        type = ProviderAkeylessAuthSecretRefModule;
      };
      "caBundle" = mkOption {
        description = "PEM/base64 encoded CA bundle used to validate Akeyless Gateway certificate. Only used\nif the AkeylessGWApiURL URL is using HTTPS protocol. If not set the system root certificates\nare used to validate the TLS connection.";
        type = (types.nullOr types.str);
        default = null;
      };
      "caProvider" = mkOption {
        description = "The provider for the CA bundle to use to validate Akeyless Gateway certificate.";
        type = (types.nullOr ProviderAkeylessCaProviderModule);
        default = null;
      };
    };
  };
  mkProviderAkeyless =
    res:
    {
      inherit (res) "akeylessGWApiURL";
      "authSecretRef" = mkProviderAkeylessAuthSecretRef res."authSecretRef";
    }
    // optionalAttrs (res."caBundle" != null) { inherit (res) "caBundle"; }
    // {
    }
    // optionalAttrs (res."caProvider" != null) {
      "caProvider" = mkProviderAkeylessCaProvider res."caProvider";
    }
    // {
    };
  ProviderAwsAuthJwtModule = types.submodule {
    options = {
      "serviceAccountRef" = mkOption {
        description = "ServiceAccountSelector is a reference to a ServiceAccount resource.";
        type = (types.nullOr ProviderAwsAuthJwtServiceAccountRefModule);
        default = null;
      };
    };
  };
  mkProviderAwsAuthJwt =
    res:
    {
    }
    // optionalAttrs (res."serviceAccountRef" != null) {
      "serviceAccountRef" = mkProviderAwsAuthJwtServiceAccountRef res."serviceAccountRef";
    }
    // {
    };
  ProviderAwsAuthJwtServiceAccountRefModule = types.submodule {
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
  mkProviderAwsAuthJwtServiceAccountRef =
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
  ProviderAwsAuthModule = types.submodule {
    options = {
      "jwt" = mkOption {
        description = "AWSJWTAuth stores reference to Authenticate against AWS using service account tokens.";
        type = (types.nullOr ProviderAwsAuthJwtModule);
        default = null;
      };
      "secretRef" = mkOption {
        description = "AWSAuthSecretRef holds secret references for AWS credentials\nboth AccessKeyID and SecretAccessKey must be defined in order to properly authenticate.";
        type = (types.nullOr ProviderAwsAuthSecretRefModule);
        default = null;
      };
    };
  };
  mkProviderAwsAuth =
    res:
    {
    }
    // optionalAttrs (res."jwt" != null) { "jwt" = mkProviderAwsAuthJwt res."jwt"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderAwsAuthSecretRef res."secretRef";
    }
    // {
    };
  ProviderAwsAuthSecretRefAccessKeyIDSecretRefModule = types.submodule {
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
  mkProviderAwsAuthSecretRefAccessKeyIDSecretRef =
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
  ProviderAwsAuthSecretRefModule = types.submodule {
    options = {
      "accessKeyIDSecretRef" = mkOption {
        description = "The AccessKeyID is used for authentication";
        type = (types.nullOr ProviderAwsAuthSecretRefAccessKeyIDSecretRefModule);
        default = null;
      };
      "secretAccessKeySecretRef" = mkOption {
        description = "The SecretAccessKey is used for authentication";
        type = (types.nullOr ProviderAwsAuthSecretRefSecretAccessKeySecretRefModule);
        default = null;
      };
      "sessionTokenSecretRef" = mkOption {
        description = "The SessionToken used for authentication\nThis must be defined if AccessKeyID and SecretAccessKey are temporary credentials\nsee: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_use-resources.html";
        type = (types.nullOr ProviderAwsAuthSecretRefSessionTokenSecretRefModule);
        default = null;
      };
    };
  };
  mkProviderAwsAuthSecretRef =
    res:
    {
    }
    // optionalAttrs (res."accessKeyIDSecretRef" != null) {
      "accessKeyIDSecretRef" = mkProviderAwsAuthSecretRefAccessKeyIDSecretRef res."accessKeyIDSecretRef";
    }
    // {
    }
    // optionalAttrs (res."secretAccessKeySecretRef" != null) {
      "secretAccessKeySecretRef" =
        mkProviderAwsAuthSecretRefSecretAccessKeySecretRef
          res."secretAccessKeySecretRef";
    }
    // {
    }
    // optionalAttrs (res."sessionTokenSecretRef" != null) {
      "sessionTokenSecretRef" =
        mkProviderAwsAuthSecretRefSessionTokenSecretRef
          res."sessionTokenSecretRef";
    }
    // {
    };
  ProviderAwsAuthSecretRefSecretAccessKeySecretRefModule = types.submodule {
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
  mkProviderAwsAuthSecretRefSecretAccessKeySecretRef =
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
  ProviderAwsAuthSecretRefSessionTokenSecretRefModule = types.submodule {
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
  mkProviderAwsAuthSecretRefSessionTokenSecretRef =
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
  ProviderAwsModule = types.submodule {
    options = {
      "additionalRoles" = mkOption {
        description = "AdditionalRoles is a chained list of Role ARNs which the provider will sequentially assume before assuming the Role";
        type = (types.listOf types.str);
        default = [ ];
      };
      "auth" = mkOption {
        description = "Auth defines the information necessary to authenticate against AWS\nif not set aws sdk will infer credentials from your environment\nsee: https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials";
        type = (types.nullOr ProviderAwsAuthModule);
        default = null;
      };
      "externalID" = mkOption {
        description = "AWS External ID set on assumed IAM roles";
        type = (types.nullOr types.str);
        default = null;
      };
      "prefix" = mkOption {
        description = "Prefix adds a prefix to all retrieved values.";
        type = (types.nullOr types.str);
        default = null;
      };
      "region" = mkOption {
        description = "AWS Region to be used for the provider";
        type = types.str;
      };
      "role" = mkOption {
        description = "Role is a Role ARN which the provider will assume";
        type = (types.nullOr types.str);
        default = null;
      };
      "secretsManager" = mkOption {
        description = "SecretsManager defines how the provider behaves when interacting with AWS SecretsManager";
        type = (types.nullOr ProviderAwsSecretsManagerModule);
        default = null;
      };
      "service" = mkOption {
        description = "Service defines which service should be used to fetch the secrets";
        type = (
          types.enum [
            "SecretsManager"
            "ParameterStore"
          ]
        );
      };
      "sessionTags" = mkOption {
        description = "AWS STS assume role session tags";
        type = (types.listOf ProviderAwsSessionTagModule);
        default = [ ];
      };
      "transitiveTagKeys" = mkOption {
        description = "AWS STS assume role transitive session tags. Required when multiple rules are used with the provider";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkProviderAws =
    res:
    {
    }
    // optionalAttrs (res."additionalRoles" != [ ]) { inherit (res) "additionalRoles"; }
    // {
    }
    // optionalAttrs (res."auth" != null) { "auth" = mkProviderAwsAuth res."auth"; }
    // {
    }
    // optionalAttrs (res."externalID" != null) { inherit (res) "externalID"; }
    // {
    }
    // optionalAttrs (res."prefix" != null) { inherit (res) "prefix"; }
    // {
      inherit (res) "region";
    }
    // optionalAttrs (res."role" != null) { inherit (res) "role"; }
    // {
    }
    // optionalAttrs (res."secretsManager" != null) {
      "secretsManager" = mkProviderAwsSecretsManager res."secretsManager";
    }
    // {
      inherit (res) "service";
    }
    // optionalAttrs (res."sessionTags" != [ ]) {
      "sessionTags" = map mkProviderAwsSessionTag res."sessionTags";
    }
    // {
    }
    // optionalAttrs (res."transitiveTagKeys" != [ ]) { inherit (res) "transitiveTagKeys"; }
    // {
    };
  ProviderAwsSecretsManagerModule = types.submodule {
    options = {
      "forceDeleteWithoutRecovery" = mkOption {
        description = "Specifies whether to delete the secret without any recovery window. You\ncan't use both this parameter and RecoveryWindowInDays in the same call.\nIf you don't use either, then by default Secrets Manager uses a 30 day\nrecovery window.\nsee: https://docs.aws.amazon.com/secretsmanager/latest/apireference/API_DeleteSecret.html#SecretsManager-DeleteSecret-request-ForceDeleteWithoutRecovery";
        type = types.bool;
        default = false;
      };
      "recoveryWindowInDays" = mkOption {
        description = "The number of days from 7 to 30 that Secrets Manager waits before\npermanently deleting the secret. You can't use both this parameter and\nForceDeleteWithoutRecovery in the same call. If you don't use either,\nthen by default Secrets Manager uses a 30-day recovery window.\nsee: https://docs.aws.amazon.com/secretsmanager/latest/apireference/API_DeleteSecret.html#SecretsManager-DeleteSecret-request-RecoveryWindowInDays";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkProviderAwsSecretsManager =
    res:
    {
    }
    // optionalAttrs res."forceDeleteWithoutRecovery" { inherit (res) "forceDeleteWithoutRecovery"; }
    // {
    }
    // optionalAttrs (res."recoveryWindowInDays" != null) { inherit (res) "recoveryWindowInDays"; }
    // {
    };
  ProviderAwsSessionTagModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        type = types.str;
      };
    };
  };
  mkProviderAwsSessionTag = res: {
    inherit (res) "key";
    inherit (res) "value";
  };
  ProviderAzurekvAuthSecretRefClientCertificateModule = types.submodule {
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
  mkProviderAzurekvAuthSecretRefClientCertificate =
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
  ProviderAzurekvAuthSecretRefClientIdModule = types.submodule {
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
  mkProviderAzurekvAuthSecretRefClientId =
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
  ProviderAzurekvAuthSecretRefClientSecretModule = types.submodule {
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
  mkProviderAzurekvAuthSecretRefClientSecret =
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
  ProviderAzurekvAuthSecretRefModule = types.submodule {
    options = {
      "clientCertificate" = mkOption {
        description = "The Azure ClientCertificate of the service principle used for authentication.";
        type = (types.nullOr ProviderAzurekvAuthSecretRefClientCertificateModule);
        default = null;
      };
      "clientId" = mkOption {
        description = "The Azure clientId of the service principle or managed identity used for authentication.";
        type = (types.nullOr ProviderAzurekvAuthSecretRefClientIdModule);
        default = null;
      };
      "clientSecret" = mkOption {
        description = "The Azure ClientSecret of the service principle used for authentication.";
        type = (types.nullOr ProviderAzurekvAuthSecretRefClientSecretModule);
        default = null;
      };
      "tenantId" = mkOption {
        description = "The Azure tenantId of the managed identity used for authentication.";
        type = (types.nullOr ProviderAzurekvAuthSecretRefTenantIdModule);
        default = null;
      };
    };
  };
  mkProviderAzurekvAuthSecretRef =
    res:
    {
    }
    // optionalAttrs (res."clientCertificate" != null) {
      "clientCertificate" = mkProviderAzurekvAuthSecretRefClientCertificate res."clientCertificate";
    }
    // {
    }
    // optionalAttrs (res."clientId" != null) {
      "clientId" = mkProviderAzurekvAuthSecretRefClientId res."clientId";
    }
    // {
    }
    // optionalAttrs (res."clientSecret" != null) {
      "clientSecret" = mkProviderAzurekvAuthSecretRefClientSecret res."clientSecret";
    }
    // {
    }
    // optionalAttrs (res."tenantId" != null) {
      "tenantId" = mkProviderAzurekvAuthSecretRefTenantId res."tenantId";
    }
    // {
    };
  ProviderAzurekvAuthSecretRefTenantIdModule = types.submodule {
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
  mkProviderAzurekvAuthSecretRefTenantId =
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
  ProviderAzurekvCustomCloudConfigModule = types.submodule {
    options = {
      "activeDirectoryEndpoint" = mkOption {
        description = "ActiveDirectoryEndpoint is the AAD endpoint for authentication\nRequired when using custom cloud configuration";
        type = types.str;
      };
      "keyVaultDNSSuffix" = mkOption {
        description = "KeyVaultDNSSuffix is the DNS suffix for Key Vault URLs";
        type = (types.nullOr types.str);
        default = null;
      };
      "keyVaultEndpoint" = mkOption {
        description = "KeyVaultEndpoint is the Key Vault service endpoint";
        type = (types.nullOr types.str);
        default = null;
      };
      "resourceManagerEndpoint" = mkOption {
        description = "ResourceManagerEndpoint is the Azure Resource Manager endpoint";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderAzurekvCustomCloudConfig =
    res:
    {
      inherit (res) "activeDirectoryEndpoint";
    }
    // optionalAttrs (res."keyVaultDNSSuffix" != null) { inherit (res) "keyVaultDNSSuffix"; }
    // {
    }
    // optionalAttrs (res."keyVaultEndpoint" != null) { inherit (res) "keyVaultEndpoint"; }
    // {
    }
    // optionalAttrs (res."resourceManagerEndpoint" != null) {
      inherit (res) "resourceManagerEndpoint";
    }
    // {
    };
  ProviderAzurekvModule = types.submodule {
    options = {
      "authSecretRef" = mkOption {
        description = "Auth configures how the operator authenticates with Azure. Required for ServicePrincipal auth type. Optional for WorkloadIdentity.";
        type = (types.nullOr ProviderAzurekvAuthSecretRefModule);
        default = null;
      };
      "authType" = mkOption {
        description = "Auth type defines how to authenticate to the keyvault service.\nValid values are:\n- \"ServicePrincipal\" (default): Using a service principal (tenantId, clientId, clientSecret)\n- \"ManagedIdentity\": Using Managed Identity assigned to the pod (see aad-pod-identity)";
        type = (
          types.nullOr (
            types.enum [
              "ServicePrincipal"
              "ManagedIdentity"
              "WorkloadIdentity"
            ]
          )
        );
        default = "ServicePrincipal";
      };
      "customCloudConfig" = mkOption {
        description = "CustomCloudConfig defines custom Azure endpoints for non-standard clouds.\nRequired when EnvironmentType is AzureStackCloud.\nOptional for other environment types - useful for Azure China when using Workload Identity\nwith AKS, where the OIDC issuer (login.partner.microsoftonline.cn) differs from the\nstandard China Cloud endpoint (login.chinacloudapi.cn).\nIMPORTANT: This feature REQUIRES UseAzureSDK to be set to true. Custom cloud\nconfiguration is not supported with the legacy go-autorest SDK.";
        type = (types.nullOr ProviderAzurekvCustomCloudConfigModule);
        default = null;
      };
      "environmentType" = mkOption {
        description = "EnvironmentType specifies the Azure cloud environment endpoints to use for\nconnecting and authenticating with Azure. By default it points to the public cloud AAD endpoint.\nThe following endpoints are available, also see here: https://github.com/Azure/go-autorest/blob/main/autorest/azure/environments.go#L152\nPublicCloud, USGovernmentCloud, ChinaCloud, GermanCloud, AzureStackCloud\nUse AzureStackCloud when you need to configure custom Azure Stack Hub or Azure Stack Edge endpoints.";
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
      "identityId" = mkOption {
        description = "If multiple Managed Identity is assigned to the pod, you can select the one to be used";
        type = (types.nullOr types.str);
        default = null;
      };
      "serviceAccountRef" = mkOption {
        description = "ServiceAccountRef specified the service account\nthat should be used when authenticating with WorkloadIdentity.";
        type = (types.nullOr ProviderAzurekvServiceAccountRefModule);
        default = null;
      };
      "tenantId" = mkOption {
        description = "TenantID configures the Azure Tenant to send requests to. Required for ServicePrincipal auth type. Optional for WorkloadIdentity.";
        type = (types.nullOr types.str);
        default = null;
      };
      "useAzureSDK" = mkOption {
        description = "UseAzureSDK enables the use of the new Azure SDK for Go (azcore-based) instead of the legacy go-autorest SDK.\nThis is experimental and may have behavioral differences. Defaults to false (legacy SDK).";
        type = types.bool;
        default = false;
      };
      "vaultUrl" = mkOption {
        description = "Vault Url from which the secrets to be fetched from.";
        type = types.str;
      };
    };
  };
  mkProviderAzurekv =
    res:
    {
    }
    // optionalAttrs (res."authSecretRef" != null) {
      "authSecretRef" = mkProviderAzurekvAuthSecretRef res."authSecretRef";
    }
    // {
    }
    // optionalAttrs (res."authType" != null) { inherit (res) "authType"; }
    // {
    }
    // optionalAttrs (res."customCloudConfig" != null) {
      "customCloudConfig" = mkProviderAzurekvCustomCloudConfig res."customCloudConfig";
    }
    // {
    }
    // optionalAttrs (res."environmentType" != null) { inherit (res) "environmentType"; }
    // {
    }
    // optionalAttrs (res."identityId" != null) { inherit (res) "identityId"; }
    // {
    }
    // optionalAttrs (res."serviceAccountRef" != null) {
      "serviceAccountRef" = mkProviderAzurekvServiceAccountRef res."serviceAccountRef";
    }
    // {
    }
    // optionalAttrs (res."tenantId" != null) { inherit (res) "tenantId"; }
    // {
    }
    // optionalAttrs res."useAzureSDK" { inherit (res) "useAzureSDK"; }
    // {
      inherit (res) "vaultUrl";
    };
  ProviderAzurekvServiceAccountRefModule = types.submodule {
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
  mkProviderAzurekvServiceAccountRef =
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
  ProviderBarbicanAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "BarbicanProviderPasswordRef defines a reference to a secret containing password for the Barbican provider.";
        type = ProviderBarbicanAuthPasswordModule;
      };
      "username" = mkOption {
        description = "BarbicanProviderUsernameRef defines a reference to a secret containing username for the Barbican provider.";
        type = ProviderBarbicanAuthUsernameModule;
      };
    };
  };
  mkProviderBarbicanAuth = res: {
    "password" = mkProviderBarbicanAuthPassword res."password";
    "username" = mkProviderBarbicanAuthUsername res."username";
  };
  ProviderBarbicanAuthPasswordModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderBarbicanAuthPasswordSecretRefModule;
      };
    };
  };
  mkProviderBarbicanAuthPassword = res: {
    "secretRef" = mkProviderBarbicanAuthPasswordSecretRef res."secretRef";
  };
  ProviderBarbicanAuthPasswordSecretRefModule = types.submodule {
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
  mkProviderBarbicanAuthPasswordSecretRef =
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
  ProviderBarbicanAuthUsernameModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = (types.nullOr ProviderBarbicanAuthUsernameSecretRefModule);
        default = null;
      };
      "value" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderBarbicanAuthUsername =
    res:
    {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderBarbicanAuthUsernameSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  ProviderBarbicanAuthUsernameSecretRefModule = types.submodule {
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
  mkProviderBarbicanAuthUsernameSecretRef =
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
  ProviderBarbicanModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "BarbicanAuth contains the authentication information for Barbican.";
        type = ProviderBarbicanAuthModule;
      };
      "authURL" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "domainName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "region" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "tenantName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderBarbican =
    res:
    {
      "auth" = mkProviderBarbicanAuth res."auth";
    }
    // optionalAttrs (res."authURL" != null) { inherit (res) "authURL"; }
    // {
    }
    // optionalAttrs (res."domainName" != null) { inherit (res) "domainName"; }
    // {
    }
    // optionalAttrs (res."region" != null) { inherit (res) "region"; }
    // {
    }
    // optionalAttrs (res."tenantName" != null) { inherit (res) "tenantName"; }
    // {
    };
  ProviderBeyondtrustAuthApiKeyModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "SecretRef references a key in a secret that will be used as value.";
        type = (types.nullOr ProviderBeyondtrustAuthApiKeySecretRefModule);
        default = null;
      };
      "value" = mkOption {
        description = "Value can be specified directly to set a value without using a secret.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderBeyondtrustAuthApiKey =
    res:
    {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderBeyondtrustAuthApiKeySecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  ProviderBeyondtrustAuthApiKeySecretRefModule = types.submodule {
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
  mkProviderBeyondtrustAuthApiKeySecretRef =
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
  ProviderBeyondtrustAuthCertificateKeyModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "SecretRef references a key in a secret that will be used as value.";
        type = (types.nullOr ProviderBeyondtrustAuthCertificateKeySecretRefModule);
        default = null;
      };
      "value" = mkOption {
        description = "Value can be specified directly to set a value without using a secret.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderBeyondtrustAuthCertificateKey =
    res:
    {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderBeyondtrustAuthCertificateKeySecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  ProviderBeyondtrustAuthCertificateKeySecretRefModule = types.submodule {
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
  mkProviderBeyondtrustAuthCertificateKeySecretRef =
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
  ProviderBeyondtrustAuthCertificateModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "SecretRef references a key in a secret that will be used as value.";
        type = (types.nullOr ProviderBeyondtrustAuthCertificateSecretRefModule);
        default = null;
      };
      "value" = mkOption {
        description = "Value can be specified directly to set a value without using a secret.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderBeyondtrustAuthCertificate =
    res:
    {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderBeyondtrustAuthCertificateSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  ProviderBeyondtrustAuthCertificateSecretRefModule = types.submodule {
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
  mkProviderBeyondtrustAuthCertificateSecretRef =
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
  ProviderBeyondtrustAuthClientIdModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "SecretRef references a key in a secret that will be used as value.";
        type = (types.nullOr ProviderBeyondtrustAuthClientIdSecretRefModule);
        default = null;
      };
      "value" = mkOption {
        description = "Value can be specified directly to set a value without using a secret.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderBeyondtrustAuthClientId =
    res:
    {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderBeyondtrustAuthClientIdSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  ProviderBeyondtrustAuthClientIdSecretRefModule = types.submodule {
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
  mkProviderBeyondtrustAuthClientIdSecretRef =
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
  ProviderBeyondtrustAuthClientSecretModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "SecretRef references a key in a secret that will be used as value.";
        type = (types.nullOr ProviderBeyondtrustAuthClientSecretSecretRefModule);
        default = null;
      };
      "value" = mkOption {
        description = "Value can be specified directly to set a value without using a secret.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderBeyondtrustAuthClientSecret =
    res:
    {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderBeyondtrustAuthClientSecretSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  ProviderBeyondtrustAuthClientSecretSecretRefModule = types.submodule {
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
  mkProviderBeyondtrustAuthClientSecretSecretRef =
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
  ProviderBeyondtrustAuthModule = types.submodule {
    options = {
      "apiKey" = mkOption {
        description = "APIKey If not provided then ClientID/ClientSecret become required.";
        type = (types.nullOr ProviderBeyondtrustAuthApiKeyModule);
        default = null;
      };
      "certificate" = mkOption {
        description = "Certificate (cert.pem) for use when authenticating with an OAuth client Id using a Client Certificate.";
        type = (types.nullOr ProviderBeyondtrustAuthCertificateModule);
        default = null;
      };
      "certificateKey" = mkOption {
        description = "Certificate private key (key.pem). For use when authenticating with an OAuth client Id";
        type = (types.nullOr ProviderBeyondtrustAuthCertificateKeyModule);
        default = null;
      };
      "clientId" = mkOption {
        description = "ClientID is the API OAuth Client ID.";
        type = (types.nullOr ProviderBeyondtrustAuthClientIdModule);
        default = null;
      };
      "clientSecret" = mkOption {
        description = "ClientSecret is the API OAuth Client Secret.";
        type = (types.nullOr ProviderBeyondtrustAuthClientSecretModule);
        default = null;
      };
    };
  };
  mkProviderBeyondtrustAuth =
    res:
    {
    }
    // optionalAttrs (res."apiKey" != null) { "apiKey" = mkProviderBeyondtrustAuthApiKey res."apiKey"; }
    // {
    }
    // optionalAttrs (res."certificate" != null) {
      "certificate" = mkProviderBeyondtrustAuthCertificate res."certificate";
    }
    // {
    }
    // optionalAttrs (res."certificateKey" != null) {
      "certificateKey" = mkProviderBeyondtrustAuthCertificateKey res."certificateKey";
    }
    // {
    }
    // optionalAttrs (res."clientId" != null) {
      "clientId" = mkProviderBeyondtrustAuthClientId res."clientId";
    }
    // {
    }
    // optionalAttrs (res."clientSecret" != null) {
      "clientSecret" = mkProviderBeyondtrustAuthClientSecret res."clientSecret";
    }
    // {
    };
  ProviderBeyondtrustModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth configures how the operator authenticates with Beyondtrust.";
        type = ProviderBeyondtrustAuthModule;
      };
      "server" = mkOption {
        description = "Auth configures how API server works.";
        type = ProviderBeyondtrustServerModule;
      };
    };
  };
  mkProviderBeyondtrust = res: {
    "auth" = mkProviderBeyondtrustAuth res."auth";
    "server" = mkProviderBeyondtrustServer res."server";
  };
  ProviderBeyondtrustServerModule = types.submodule {
    options = {
      "apiUrl" = mkOption {
        type = types.str;
      };
      "apiVersion" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "clientTimeOutSeconds" = mkOption {
        description = "Timeout specifies a time limit for requests made by this Client. The timeout includes connection time, any redirects, and reading the response body. Defaults to 45 seconds.";
        type = (types.nullOr types.int);
        default = null;
      };
      "decrypt" = mkOption {
        description = "When true, the response includes the decrypted password. When false, the password field is omitted. This option only applies to the SECRET retrieval type. Default: true.";
        type = types.bool;
        default = true;
      };
      "retrievalType" = mkOption {
        description = "The secret retrieval type. SECRET = Secrets Safe (credential, text, file). MANAGED_ACCOUNT = Password Safe account associated with a system.";
        type = (types.nullOr types.str);
        default = null;
      };
      "separator" = mkOption {
        description = "A character that separates the folder names.";
        type = (types.nullOr types.str);
        default = null;
      };
      "verifyCA" = mkOption {
        type = types.bool;
      };
    };
  };
  mkProviderBeyondtrustServer =
    res:
    {
      inherit (res) "apiUrl";
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
    }
    // optionalAttrs (res."clientTimeOutSeconds" != null) { inherit (res) "clientTimeOutSeconds"; }
    // {
    }
    // optionalAttrs (res."decrypt" != null) { inherit (res) "decrypt"; }
    // {
    }
    // optionalAttrs (res."retrievalType" != null) { inherit (res) "retrievalType"; }
    // {
    }
    // optionalAttrs (res."separator" != null) { inherit (res) "separator"; }
    // {
      inherit (res) "verifyCA";
    };
  ProviderBitwardensecretsmanagerAuthModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "BitwardenSecretsManagerSecretRef contains the credential ref to the bitwarden instance.";
        type = ProviderBitwardensecretsmanagerAuthSecretRefModule;
      };
    };
  };
  mkProviderBitwardensecretsmanagerAuth = res: {
    "secretRef" = mkProviderBitwardensecretsmanagerAuthSecretRef res."secretRef";
  };
  ProviderBitwardensecretsmanagerAuthSecretRefCredentialsModule = types.submodule {
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
  mkProviderBitwardensecretsmanagerAuthSecretRefCredentials =
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
  ProviderBitwardensecretsmanagerAuthSecretRefModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "AccessToken used for the bitwarden instance.";
        type = ProviderBitwardensecretsmanagerAuthSecretRefCredentialsModule;
      };
    };
  };
  mkProviderBitwardensecretsmanagerAuthSecretRef = res: {
    "credentials" = mkProviderBitwardensecretsmanagerAuthSecretRefCredentials res."credentials";
  };
  ProviderBitwardensecretsmanagerCaProviderModule = types.submodule {
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
  mkProviderBitwardensecretsmanagerCaProvider =
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
  ProviderBitwardensecretsmanagerModule = types.submodule {
    options = {
      "apiURL" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "auth" = mkOption {
        description = "Auth configures how secret-manager authenticates with a bitwarden machine account instance.\nMake sure that the token being used has permissions on the given secret.";
        type = ProviderBitwardensecretsmanagerAuthModule;
      };
      "bitwardenServerSDKURL" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "caBundle" = mkOption {
        description = "Base64 encoded certificate for the bitwarden server sdk. The sdk MUST run with HTTPS to make sure no MITM attack\ncan be performed.";
        type = (types.nullOr types.str);
        default = null;
      };
      "caProvider" = mkOption {
        description = "see: https://external-secrets.io/latest/spec/#external-secrets.io/v1alpha1.CAProvider";
        type = (types.nullOr ProviderBitwardensecretsmanagerCaProviderModule);
        default = null;
      };
      "identityURL" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "organizationID" = mkOption {
        description = "OrganizationID determines which organization this secret store manages.";
        type = types.str;
      };
      "projectID" = mkOption {
        description = "ProjectID determines which project this secret store manages.";
        type = types.str;
      };
    };
  };
  mkProviderBitwardensecretsmanager =
    res:
    {
    }
    // optionalAttrs (res."apiURL" != null) { inherit (res) "apiURL"; }
    // {
      "auth" = mkProviderBitwardensecretsmanagerAuth res."auth";
    }
    // optionalAttrs (res."bitwardenServerSDKURL" != null) { inherit (res) "bitwardenServerSDKURL"; }
    // {
    }
    // optionalAttrs (res."caBundle" != null) { inherit (res) "caBundle"; }
    // {
    }
    // optionalAttrs (res."caProvider" != null) {
      "caProvider" = mkProviderBitwardensecretsmanagerCaProvider res."caProvider";
    }
    // {
    }
    // optionalAttrs (res."identityURL" != null) { inherit (res) "identityURL"; }
    // {
      inherit (res) "organizationID";
      inherit (res) "projectID";
    };
  ProviderChefAuthModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "ChefAuthSecretRef holds secret references for chef server login credentials.";
        type = ProviderChefAuthSecretRefModule;
      };
    };
  };
  mkProviderChefAuth = res: {
    "secretRef" = mkProviderChefAuthSecretRef res."secretRef";
  };
  ProviderChefAuthSecretRefModule = types.submodule {
    options = {
      "privateKeySecretRef" = mkOption {
        description = "SecretKey is the Signing Key in PEM format, used for authentication.";
        type = ProviderChefAuthSecretRefPrivateKeySecretRefModule;
      };
    };
  };
  mkProviderChefAuthSecretRef = res: {
    "privateKeySecretRef" = mkProviderChefAuthSecretRefPrivateKeySecretRef res."privateKeySecretRef";
  };
  ProviderChefAuthSecretRefPrivateKeySecretRefModule = types.submodule {
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
  mkProviderChefAuthSecretRefPrivateKeySecretRef =
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
  ProviderChefModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth defines the information necessary to authenticate against chef Server";
        type = ProviderChefAuthModule;
      };
      "serverUrl" = mkOption {
        description = "ServerURL is the chef server URL used to connect to. If using orgs you should include your org in the url and terminate the url with a \"/\"";
        type = types.str;
      };
      "username" = mkOption {
        description = "UserName should be the user ID on the chef server";
        type = types.str;
      };
    };
  };
  mkProviderChef = res: {
    "auth" = mkProviderChefAuth res."auth";
    inherit (res) "serverUrl";
    inherit (res) "username";
  };
  ProviderCloudrusmAuthModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "CSMAuthSecretRef holds secret references for Cloud.ru credentials.";
        type = (types.nullOr ProviderCloudrusmAuthSecretRefModule);
        default = null;
      };
    };
  };
  mkProviderCloudrusmAuth =
    res:
    {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderCloudrusmAuthSecretRef res."secretRef";
    }
    // {
    };
  ProviderCloudrusmAuthSecretRefAccessKeyIDSecretRefModule = types.submodule {
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
  mkProviderCloudrusmAuthSecretRefAccessKeyIDSecretRef =
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
  ProviderCloudrusmAuthSecretRefAccessKeySecretSecretRefModule = types.submodule {
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
  mkProviderCloudrusmAuthSecretRefAccessKeySecretSecretRef =
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
  ProviderCloudrusmAuthSecretRefModule = types.submodule {
    options = {
      "accessKeyIDSecretRef" = mkOption {
        description = "The AccessKeyID is used for authentication";
        type = ProviderCloudrusmAuthSecretRefAccessKeyIDSecretRefModule;
      };
      "accessKeySecretSecretRef" = mkOption {
        description = "The AccessKeySecret is used for authentication";
        type = ProviderCloudrusmAuthSecretRefAccessKeySecretSecretRefModule;
      };
    };
  };
  mkProviderCloudrusmAuthSecretRef = res: {
    "accessKeyIDSecretRef" =
      mkProviderCloudrusmAuthSecretRefAccessKeyIDSecretRef
        res."accessKeyIDSecretRef";
    "accessKeySecretSecretRef" =
      mkProviderCloudrusmAuthSecretRefAccessKeySecretSecretRef
        res."accessKeySecretSecretRef";
  };
  ProviderCloudrusmModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "CSMAuth contains a secretRef for credentials.";
        type = ProviderCloudrusmAuthModule;
      };
      "projectID" = mkOption {
        description = "ProjectID is the project, which the secrets are stored in.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderCloudrusm =
    res:
    {
      "auth" = mkProviderCloudrusmAuth res."auth";
    }
    // optionalAttrs (res."projectID" != null) { inherit (res) "projectID"; }
    // {
    };
  ProviderConjurAuthApikeyApiKeyRefModule = types.submodule {
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
  mkProviderConjurAuthApikeyApiKeyRef =
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
  ProviderConjurAuthApikeyModule = types.submodule {
    options = {
      "account" = mkOption {
        description = "Account is the Conjur organization account name.";
        type = types.str;
      };
      "apiKeyRef" = mkOption {
        description = "A reference to a specific 'key' containing the Conjur API key\nwithin a Secret resource. In some instances, `key` is a required field.";
        type = ProviderConjurAuthApikeyApiKeyRefModule;
      };
      "userRef" = mkOption {
        description = "A reference to a specific 'key' containing the Conjur username\nwithin a Secret resource. In some instances, `key` is a required field.";
        type = ProviderConjurAuthApikeyUserRefModule;
      };
    };
  };
  mkProviderConjurAuthApikey = res: {
    inherit (res) "account";
    "apiKeyRef" = mkProviderConjurAuthApikeyApiKeyRef res."apiKeyRef";
    "userRef" = mkProviderConjurAuthApikeyUserRef res."userRef";
  };
  ProviderConjurAuthApikeyUserRefModule = types.submodule {
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
  mkProviderConjurAuthApikeyUserRef =
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
  ProviderConjurAuthJwtModule = types.submodule {
    options = {
      "account" = mkOption {
        description = "Account is the Conjur organization account name.";
        type = types.str;
      };
      "hostId" = mkOption {
        description = "Optional HostID for JWT authentication. This may be used depending\non how the Conjur JWT authenticator policy is configured.";
        type = (types.nullOr types.str);
        default = null;
      };
      "secretRef" = mkOption {
        description = "Optional SecretRef that refers to a key in a Secret resource containing JWT token to\nauthenticate with Conjur using the JWT authentication method.";
        type = (types.nullOr ProviderConjurAuthJwtSecretRefModule);
        default = null;
      };
      "serviceAccountRef" = mkOption {
        description = "Optional ServiceAccountRef specifies the Kubernetes service account for which to request\na token for with the `TokenRequest` API.";
        type = (types.nullOr ProviderConjurAuthJwtServiceAccountRefModule);
        default = null;
      };
      "serviceID" = mkOption {
        description = "The conjur authn jwt webservice id";
        type = types.str;
      };
    };
  };
  mkProviderConjurAuthJwt =
    res:
    {
      inherit (res) "account";
    }
    // optionalAttrs (res."hostId" != null) { inherit (res) "hostId"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderConjurAuthJwtSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."serviceAccountRef" != null) {
      "serviceAccountRef" = mkProviderConjurAuthJwtServiceAccountRef res."serviceAccountRef";
    }
    // {
      inherit (res) "serviceID";
    };
  ProviderConjurAuthJwtSecretRefModule = types.submodule {
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
  mkProviderConjurAuthJwtSecretRef =
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
  ProviderConjurAuthJwtServiceAccountRefModule = types.submodule {
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
  mkProviderConjurAuthJwtServiceAccountRef =
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
  ProviderConjurAuthModule = types.submodule {
    options = {
      "apikey" = mkOption {
        description = "Authenticates with Conjur using an API key.";
        type = (types.nullOr ProviderConjurAuthApikeyModule);
        default = null;
      };
      "jwt" = mkOption {
        description = "Jwt enables JWT authentication using Kubernetes service account tokens.";
        type = (types.nullOr ProviderConjurAuthJwtModule);
        default = null;
      };
    };
  };
  mkProviderConjurAuth =
    res:
    {
    }
    // optionalAttrs (res."apikey" != null) { "apikey" = mkProviderConjurAuthApikey res."apikey"; }
    // {
    }
    // optionalAttrs (res."jwt" != null) { "jwt" = mkProviderConjurAuthJwt res."jwt"; }
    // {
    };
  ProviderConjurCaProviderModule = types.submodule {
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
  mkProviderConjurCaProvider =
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
  ProviderConjurModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Defines authentication settings for connecting to Conjur.";
        type = ProviderConjurAuthModule;
      };
      "caBundle" = mkOption {
        description = "CABundle is a PEM encoded CA bundle that will be used to validate the Conjur server certificate.";
        type = (types.nullOr types.str);
        default = null;
      };
      "caProvider" = mkOption {
        description = "Used to provide custom certificate authority (CA) certificates\nfor a secret store. The CAProvider points to a Secret or ConfigMap resource\nthat contains a PEM-encoded certificate.";
        type = (types.nullOr ProviderConjurCaProviderModule);
        default = null;
      };
      "url" = mkOption {
        description = "URL is the endpoint of the Conjur instance.";
        type = types.str;
      };
    };
  };
  mkProviderConjur =
    res:
    {
      "auth" = mkProviderConjurAuth res."auth";
    }
    // optionalAttrs (res."caBundle" != null) { inherit (res) "caBundle"; }
    // {
    }
    // optionalAttrs (res."caProvider" != null) {
      "caProvider" = mkProviderConjurCaProvider res."caProvider";
    }
    // {
      inherit (res) "url";
    };
  ProviderDelineaClientIdModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "SecretRef references a key in a secret that will be used as value.";
        type = (types.nullOr ProviderDelineaClientIdSecretRefModule);
        default = null;
      };
      "value" = mkOption {
        description = "Value can be specified directly to set a value without using a secret.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderDelineaClientId =
    res:
    {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderDelineaClientIdSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  ProviderDelineaClientIdSecretRefModule = types.submodule {
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
  mkProviderDelineaClientIdSecretRef =
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
  ProviderDelineaClientSecretModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "SecretRef references a key in a secret that will be used as value.";
        type = (types.nullOr ProviderDelineaClientSecretSecretRefModule);
        default = null;
      };
      "value" = mkOption {
        description = "Value can be specified directly to set a value without using a secret.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderDelineaClientSecret =
    res:
    {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderDelineaClientSecretSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  ProviderDelineaClientSecretSecretRefModule = types.submodule {
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
  mkProviderDelineaClientSecretSecretRef =
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
  ProviderDelineaModule = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "ClientID is the non-secret part of the credential.";
        type = ProviderDelineaClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "ClientSecret is the secret part of the credential.";
        type = ProviderDelineaClientSecretModule;
      };
      "tenant" = mkOption {
        description = "Tenant is the chosen hostname / site name.";
        type = types.str;
      };
      "tld" = mkOption {
        description = "TLD is based on the server location that was chosen during provisioning.\nIf unset, defaults to \"com\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "urlTemplate" = mkOption {
        description = "URLTemplate\nIf unset, defaults to \"https://%s.secretsvaultcloud.%s/v1/%s%s\".";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderDelinea =
    res:
    {
      "clientId" = mkProviderDelineaClientId res."clientId";
      "clientSecret" = mkProviderDelineaClientSecret res."clientSecret";
      inherit (res) "tenant";
    }
    // optionalAttrs (res."tld" != null) { inherit (res) "tld"; }
    // {
    }
    // optionalAttrs (res."urlTemplate" != null) { inherit (res) "urlTemplate"; }
    // {
    };
  ProviderDopplerAuthModule = types.submodule {
    options = {
      "oidcConfig" = mkOption {
        description = "OIDCConfig authenticates using Kubernetes ServiceAccount tokens via OIDC.";
        type = (types.nullOr ProviderDopplerAuthOidcConfigModule);
        default = null;
      };
      "secretRef" = mkOption {
        description = "SecretRef authenticates using a Doppler service token stored in a Kubernetes Secret.";
        type = (types.nullOr ProviderDopplerAuthSecretRefModule);
        default = null;
      };
    };
  };
  mkProviderDopplerAuth =
    res:
    {
    }
    // optionalAttrs (res."oidcConfig" != null) {
      "oidcConfig" = mkProviderDopplerAuthOidcConfig res."oidcConfig";
    }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderDopplerAuthSecretRef res."secretRef";
    }
    // {
    };
  ProviderDopplerAuthOidcConfigModule = types.submodule {
    options = {
      "expirationSeconds" = mkOption {
        description = "ExpirationSeconds sets the ServiceAccount token validity duration.\nDefaults to 10 minutes.";
        type = (types.nullOr types.int);
        default = 600;
      };
      "identity" = mkOption {
        description = "Identity is the Doppler Service Account Identity ID configured for OIDC authentication.";
        type = types.str;
      };
      "serviceAccountRef" = mkOption {
        description = "ServiceAccountRef specifies the Kubernetes ServiceAccount to use for authentication.";
        type = ProviderDopplerAuthOidcConfigServiceAccountRefModule;
      };
    };
  };
  mkProviderDopplerAuthOidcConfig =
    res:
    {
    }
    // optionalAttrs (res."expirationSeconds" != null) { inherit (res) "expirationSeconds"; }
    // {
      inherit (res) "identity";
      "serviceAccountRef" = mkProviderDopplerAuthOidcConfigServiceAccountRef res."serviceAccountRef";
    };
  ProviderDopplerAuthOidcConfigServiceAccountRefModule = types.submodule {
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
  mkProviderDopplerAuthOidcConfigServiceAccountRef =
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
  ProviderDopplerAuthSecretRefDopplerTokenModule = types.submodule {
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
  mkProviderDopplerAuthSecretRefDopplerToken =
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
  ProviderDopplerAuthSecretRefModule = types.submodule {
    options = {
      "dopplerToken" = mkOption {
        description = "The DopplerToken is used for authentication.\nSee https://docs.doppler.com/reference/api#authentication for auth token types.\nThe Key attribute defaults to dopplerToken if not specified.";
        type = ProviderDopplerAuthSecretRefDopplerTokenModule;
      };
    };
  };
  mkProviderDopplerAuthSecretRef = res: {
    "dopplerToken" = mkProviderDopplerAuthSecretRefDopplerToken res."dopplerToken";
  };
  ProviderDopplerModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth configures how the Operator authenticates with the Doppler API";
        type = ProviderDopplerAuthModule;
      };
      "config" = mkOption {
        description = "Doppler config (required if not using a Service Token)";
        type = (types.nullOr types.str);
        default = null;
      };
      "format" = mkOption {
        description = "Format enables the downloading of secrets as a file (string)";
        type = (
          types.nullOr (
            types.enum [
              "json"
              "dotnet-json"
              "env"
              "yaml"
              "docker"
            ]
          )
        );
        default = null;
      };
      "nameTransformer" = mkOption {
        description = "Environment variable compatible name transforms that change secret names to a different format";
        type = (
          types.nullOr (
            types.enum [
              "upper-camel"
              "camel"
              "lower-snake"
              "tf-var"
              "dotnet-env"
              "lower-kebab"
            ]
          )
        );
        default = null;
      };
      "project" = mkOption {
        description = "Doppler project (required if not using a Service Token)";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderDoppler =
    res:
    {
      "auth" = mkProviderDopplerAuth res."auth";
    }
    // optionalAttrs (res."config" != null) { inherit (res) "config"; }
    // {
    }
    // optionalAttrs (res."format" != null) { inherit (res) "format"; }
    // {
    }
    // optionalAttrs (res."nameTransformer" != null) { inherit (res) "nameTransformer"; }
    // {
    }
    // optionalAttrs (res."project" != null) { inherit (res) "project"; }
    // {
    };
  ProviderDvlsAuthModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "SecretRef contains the Application ID and Application Secret for authentication.";
        type = ProviderDvlsAuthSecretRefModule;
      };
    };
  };
  mkProviderDvlsAuth = res: {
    "secretRef" = mkProviderDvlsAuthSecretRef res."secretRef";
  };
  ProviderDvlsAuthSecretRefAppIdModule = types.submodule {
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
  mkProviderDvlsAuthSecretRefAppId =
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
  ProviderDvlsAuthSecretRefAppSecretModule = types.submodule {
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
  mkProviderDvlsAuthSecretRefAppSecret =
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
  ProviderDvlsAuthSecretRefModule = types.submodule {
    options = {
      "appId" = mkOption {
        description = "AppID is the reference to the secret containing the Application ID.";
        type = ProviderDvlsAuthSecretRefAppIdModule;
      };
      "appSecret" = mkOption {
        description = "AppSecret is the reference to the secret containing the Application Secret.";
        type = ProviderDvlsAuthSecretRefAppSecretModule;
      };
    };
  };
  mkProviderDvlsAuthSecretRef = res: {
    "appId" = mkProviderDvlsAuthSecretRefAppId res."appId";
    "appSecret" = mkProviderDvlsAuthSecretRefAppSecret res."appSecret";
  };
  ProviderDvlsModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth defines the authentication method to use.";
        type = ProviderDvlsAuthModule;
      };
      "insecure" = mkOption {
        description = "Insecure allows connecting to DVLS over plain HTTP.\nThis is NOT RECOMMENDED for production use.\nSet to true only if you understand the security implications.";
        type = types.bool;
        default = false;
      };
      "serverUrl" = mkOption {
        description = "ServerURL is the DVLS instance URL (e.g., https://dvls.example.com).";
        type = types.str;
      };
    };
  };
  mkProviderDvls =
    res:
    {
      "auth" = mkProviderDvlsAuth res."auth";
    }
    // optionalAttrs res."insecure" { inherit (res) "insecure"; }
    // {
      inherit (res) "serverUrl";
    };
  ProviderFakeDataModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        type = types.str;
      };
      "version" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderFakeData =
    res:
    {
      inherit (res) "key";
      inherit (res) "value";
    }
    // optionalAttrs (res."version" != null) { inherit (res) "version"; }
    // {
    };
  ProviderFakeModule = types.submodule {
    options = {
      "data" = mkOption {
        type = (types.listOf ProviderFakeDataModule);
      };
      "validationResult" = mkOption {
        description = "ValidationResult is defined type for the number of validation results.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkProviderFake =
    res:
    {
      "data" = map mkProviderFakeData res."data";
    }
    // optionalAttrs (res."validationResult" != null) { inherit (res) "validationResult"; }
    // {
    };
  ProviderFortanixApiKeyModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "SecretRef is a reference to a secret containing the SDKMS API Key.";
        type = (types.nullOr ProviderFortanixApiKeySecretRefModule);
        default = null;
      };
    };
  };
  mkProviderFortanixApiKey =
    res:
    {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderFortanixApiKeySecretRef res."secretRef";
    }
    // {
    };
  ProviderFortanixApiKeySecretRefModule = types.submodule {
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
  mkProviderFortanixApiKeySecretRef =
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
  ProviderFortanixModule = types.submodule {
    options = {
      "apiKey" = mkOption {
        description = "APIKey is the API token to access SDKMS Applications.";
        type = (types.nullOr ProviderFortanixApiKeyModule);
        default = null;
      };
      "apiUrl" = mkOption {
        description = "APIURL is the URL of SDKMS API. Defaults to `sdkms.fortanix.com`.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderFortanix =
    res:
    {
    }
    // optionalAttrs (res."apiKey" != null) { "apiKey" = mkProviderFortanixApiKey res."apiKey"; }
    // {
    }
    // optionalAttrs (res."apiUrl" != null) { inherit (res) "apiUrl"; }
    // {
    };
  ProviderGcpsmAuthModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "GCPSMAuthSecretRef contains the secret references for GCP Secret Manager authentication.";
        type = (types.nullOr ProviderGcpsmAuthSecretRefModule);
        default = null;
      };
      "workloadIdentity" = mkOption {
        description = "GCPWorkloadIdentity defines configuration for workload identity authentication to GCP.";
        type = (types.nullOr ProviderGcpsmAuthWorkloadIdentityModule);
        default = null;
      };
      "workloadIdentityFederation" = mkOption {
        description = "GCPWorkloadIdentityFederation holds the configurations required for generating federated access tokens.";
        type = (types.nullOr ProviderGcpsmAuthWorkloadIdentityFederationModule);
        default = null;
      };
    };
  };
  mkProviderGcpsmAuth =
    res:
    {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderGcpsmAuthSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."workloadIdentity" != null) {
      "workloadIdentity" = mkProviderGcpsmAuthWorkloadIdentity res."workloadIdentity";
    }
    // {
    }
    // optionalAttrs (res."workloadIdentityFederation" != null) {
      "workloadIdentityFederation" =
        mkProviderGcpsmAuthWorkloadIdentityFederation
          res."workloadIdentityFederation";
    }
    // {
    };
  ProviderGcpsmAuthSecretRefModule = types.submodule {
    options = {
      "secretAccessKeySecretRef" = mkOption {
        description = "The SecretAccessKey is used for authentication";
        type = (types.nullOr ProviderGcpsmAuthSecretRefSecretAccessKeySecretRefModule);
        default = null;
      };
    };
  };
  mkProviderGcpsmAuthSecretRef =
    res:
    {
    }
    // optionalAttrs (res."secretAccessKeySecretRef" != null) {
      "secretAccessKeySecretRef" =
        mkProviderGcpsmAuthSecretRefSecretAccessKeySecretRef
          res."secretAccessKeySecretRef";
    }
    // {
    };
  ProviderGcpsmAuthSecretRefSecretAccessKeySecretRefModule = types.submodule {
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
  mkProviderGcpsmAuthSecretRefSecretAccessKeySecretRef =
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
  ProviderGcpsmAuthWorkloadIdentityFederationAwsSecurityCredentialsAwsCredentialsSecretRefModule =
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
  mkProviderGcpsmAuthWorkloadIdentityFederationAwsSecurityCredentialsAwsCredentialsSecretRef =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  ProviderGcpsmAuthWorkloadIdentityFederationAwsSecurityCredentialsModule = types.submodule {
    options = {
      "awsCredentialsSecretRef" = mkOption {
        description = "awsCredentialsSecretRef is the reference to the secret which holds the AWS credentials.\nSecret should be created with below names for keys\n- aws_access_key_id: Access Key ID, which is the unique identifier for the AWS account or the IAM user.\n- aws_secret_access_key: Secret Access Key, which is used to authenticate requests made to AWS services.\n- aws_session_token: Session Token, is the short-lived token to authenticate requests made to AWS services.";
        type =
          ProviderGcpsmAuthWorkloadIdentityFederationAwsSecurityCredentialsAwsCredentialsSecretRefModule;
      };
      "region" = mkOption {
        description = "region is for configuring the AWS region to be used.";
        type = types.str;
      };
    };
  };
  mkProviderGcpsmAuthWorkloadIdentityFederationAwsSecurityCredentials = res: {
    "awsCredentialsSecretRef" =
      mkProviderGcpsmAuthWorkloadIdentityFederationAwsSecurityCredentialsAwsCredentialsSecretRef
        res."awsCredentialsSecretRef";
    inherit (res) "region";
  };
  ProviderGcpsmAuthWorkloadIdentityFederationCredConfigModule = types.submodule {
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
  mkProviderGcpsmAuthWorkloadIdentityFederationCredConfig =
    res:
    {
      inherit (res) "key";
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  ProviderGcpsmAuthWorkloadIdentityFederationModule = types.submodule {
    options = {
      "audience" = mkOption {
        description = "audience is the Secure Token Service (STS) audience which contains the resource name for the workload identity pool and the provider identifier in that pool.\nIf specified, Audience found in the external account credential config will be overridden with the configured value.\naudience must be provided when serviceAccountRef or awsSecurityCredentials is configured.";
        type = (types.nullOr types.str);
        default = null;
      };
      "awsSecurityCredentials" = mkOption {
        description = "awsSecurityCredentials is for configuring AWS region and credentials to use for obtaining the access token,\nwhen using the AWS metadata server is not an option.";
        type = (types.nullOr ProviderGcpsmAuthWorkloadIdentityFederationAwsSecurityCredentialsModule);
        default = null;
      };
      "credConfig" = mkOption {
        description = "credConfig holds the configmap reference containing the GCP external account credential configuration in JSON format and the key name containing the json data.\nFor using Kubernetes cluster as the identity provider, use serviceAccountRef instead. Operators mounted serviceaccount token cannot be used as the token source, instead\nserviceAccountRef must be used by providing operators service account details.";
        type = (types.nullOr ProviderGcpsmAuthWorkloadIdentityFederationCredConfigModule);
        default = null;
      };
      "externalTokenEndpoint" = mkOption {
        description = "externalTokenEndpoint is the endpoint explicitly set up to provide tokens, which will be matched against the\ncredential_source.url in the provided credConfig. This field is merely to double-check the external token source\nURL is having the expected value.";
        type = (types.nullOr types.str);
        default = null;
      };
      "serviceAccountRef" = mkOption {
        description = "serviceAccountRef is the reference to the kubernetes ServiceAccount to be used for obtaining the tokens,\nwhen Kubernetes is configured as provider in workload identity pool.";
        type = (types.nullOr ProviderGcpsmAuthWorkloadIdentityFederationServiceAccountRefModule);
        default = null;
      };
    };
  };
  mkProviderGcpsmAuthWorkloadIdentityFederation =
    res:
    {
    }
    // optionalAttrs (res."audience" != null) { inherit (res) "audience"; }
    // {
    }
    // optionalAttrs (res."awsSecurityCredentials" != null) {
      "awsSecurityCredentials" =
        mkProviderGcpsmAuthWorkloadIdentityFederationAwsSecurityCredentials
          res."awsSecurityCredentials";
    }
    // {
    }
    // optionalAttrs (res."credConfig" != null) {
      "credConfig" = mkProviderGcpsmAuthWorkloadIdentityFederationCredConfig res."credConfig";
    }
    // {
    }
    // optionalAttrs (res."externalTokenEndpoint" != null) { inherit (res) "externalTokenEndpoint"; }
    // {
    }
    // optionalAttrs (res."serviceAccountRef" != null) {
      "serviceAccountRef" =
        mkProviderGcpsmAuthWorkloadIdentityFederationServiceAccountRef
          res."serviceAccountRef";
    }
    // {
    };
  ProviderGcpsmAuthWorkloadIdentityFederationServiceAccountRefModule = types.submodule {
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
  mkProviderGcpsmAuthWorkloadIdentityFederationServiceAccountRef =
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
  ProviderGcpsmAuthWorkloadIdentityModule = types.submodule {
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
        type = ProviderGcpsmAuthWorkloadIdentityServiceAccountRefModule;
      };
    };
  };
  mkProviderGcpsmAuthWorkloadIdentity =
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
      "serviceAccountRef" = mkProviderGcpsmAuthWorkloadIdentityServiceAccountRef res."serviceAccountRef";
    };
  ProviderGcpsmAuthWorkloadIdentityServiceAccountRefModule = types.submodule {
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
  mkProviderGcpsmAuthWorkloadIdentityServiceAccountRef =
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
  ProviderGcpsmModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth defines the information necessary to authenticate against GCP";
        type = (types.nullOr ProviderGcpsmAuthModule);
        default = null;
      };
      "location" = mkOption {
        description = "Location optionally defines a location for a secret";
        type = (types.nullOr types.str);
        default = null;
      };
      "projectID" = mkOption {
        description = "ProjectID project where secret is located";
        type = (types.nullOr types.str);
        default = null;
      };
      "secretVersionSelectionPolicy" = mkOption {
        description = "SecretVersionSelectionPolicy specifies how the provider selects a secret version\nwhen \"latest\" is disabled or destroyed.\nPossible values are:\n- LatestOrFail: the provider always uses \"latest\", or fails if that version is disabled/destroyed.\n- LatestOrFetch: the provider falls back to fetching the latest version if the version is DESTROYED or DISABLED";
        type = (types.nullOr types.str);
        default = "LatestOrFail";
      };
    };
  };
  mkProviderGcpsm =
    res:
    {
    }
    // optionalAttrs (res."auth" != null) { "auth" = mkProviderGcpsmAuth res."auth"; }
    // {
    }
    // optionalAttrs (res."location" != null) { inherit (res) "location"; }
    // {
    }
    // optionalAttrs (res."projectID" != null) { inherit (res) "projectID"; }
    // {
    }
    // optionalAttrs (res."secretVersionSelectionPolicy" != null) {
      inherit (res) "secretVersionSelectionPolicy";
    }
    // {
    };
  ProviderGithubAuthModule = types.submodule {
    options = {
      "privateKey" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderGithubAuthPrivateKeyModule;
      };
    };
  };
  mkProviderGithubAuth = res: {
    "privateKey" = mkProviderGithubAuthPrivateKey res."privateKey";
  };
  ProviderGithubAuthPrivateKeyModule = types.submodule {
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
  mkProviderGithubAuthPrivateKey =
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
  ProviderGithubModule = types.submodule {
    options = {
      "appID" = mkOption {
        description = "appID specifies the Github APP that will be used to authenticate the client";
        type = types.int;
      };
      "auth" = mkOption {
        description = "auth configures how secret-manager authenticates with a Github instance.";
        type = ProviderGithubAuthModule;
      };
      "environment" = mkOption {
        description = "environment will be used to fetch secrets from a particular environment within a github repository";
        type = (types.nullOr types.str);
        default = null;
      };
      "installationID" = mkOption {
        description = "installationID specifies the Github APP installation that will be used to authenticate the client";
        type = types.int;
      };
      "organization" = mkOption {
        description = "organization will be used to fetch secrets from the Github organization";
        type = types.str;
      };
      "repository" = mkOption {
        description = "repository will be used to fetch secrets from the Github repository within an organization";
        type = (types.nullOr types.str);
        default = null;
      };
      "uploadURL" = mkOption {
        description = "Upload URL for enterprise instances. Default to URL.";
        type = (types.nullOr types.str);
        default = null;
      };
      "url" = mkOption {
        description = "URL configures the Github instance URL. Defaults to https://github.com/.";
        type = (types.nullOr types.str);
        default = "https://github.com/";
      };
    };
  };
  mkProviderGithub =
    res:
    {
      inherit (res) "appID";
      "auth" = mkProviderGithubAuth res."auth";
    }
    // optionalAttrs (res."environment" != null) { inherit (res) "environment"; }
    // {
      inherit (res) "installationID";
      inherit (res) "organization";
    }
    // optionalAttrs (res."repository" != null) { inherit (res) "repository"; }
    // {
    }
    // optionalAttrs (res."uploadURL" != null) { inherit (res) "uploadURL"; }
    // {
    }
    // optionalAttrs (res."url" != null) { inherit (res) "url"; }
    // {
    };
  ProviderGitlabAuthModule = types.submodule {
    options = {
      "SecretRef" = mkOption {
        description = "GitlabSecretRef contains the secret reference for GitLab authentication credentials.";
        type = ProviderGitlabAuthSecretRefModule;
      };
    };
  };
  mkProviderGitlabAuth = res: {
    "SecretRef" = mkProviderGitlabAuthSecretRef res."SecretRef";
  };
  ProviderGitlabAuthSecretRefAccessTokenModule = types.submodule {
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
  mkProviderGitlabAuthSecretRefAccessToken =
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
  ProviderGitlabAuthSecretRefModule = types.submodule {
    options = {
      "accessToken" = mkOption {
        description = "AccessToken is used for authentication.";
        type = (types.nullOr ProviderGitlabAuthSecretRefAccessTokenModule);
        default = null;
      };
    };
  };
  mkProviderGitlabAuthSecretRef =
    res:
    {
    }
    // optionalAttrs (res."accessToken" != null) {
      "accessToken" = mkProviderGitlabAuthSecretRefAccessToken res."accessToken";
    }
    // {
    };
  ProviderGitlabCaProviderModule = types.submodule {
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
  mkProviderGitlabCaProvider =
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
  ProviderGitlabModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth configures how secret-manager authenticates with a GitLab instance.";
        type = ProviderGitlabAuthModule;
      };
      "caBundle" = mkOption {
        description = "Base64 encoded certificate for the GitLab server sdk. The sdk MUST run with HTTPS to make sure no MITM attack\ncan be performed.";
        type = (types.nullOr types.str);
        default = null;
      };
      "caProvider" = mkOption {
        description = "see: https://external-secrets.io/latest/spec/#external-secrets.io/v1alpha1.CAProvider";
        type = (types.nullOr ProviderGitlabCaProviderModule);
        default = null;
      };
      "environment" = mkOption {
        description = "Environment environment_scope of gitlab CI/CD variables (Please see https://docs.gitlab.com/ee/ci/environments/#create-a-static-environment on how to create environments)";
        type = (types.nullOr types.str);
        default = null;
      };
      "groupIDs" = mkOption {
        description = "GroupIDs specify, which gitlab groups to pull secrets from. Group secrets are read from left to right followed by the project variables.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "inheritFromGroups" = mkOption {
        description = "InheritFromGroups specifies whether parent groups should be discovered and checked for secrets.";
        type = types.bool;
        default = false;
      };
      "projectID" = mkOption {
        description = "ProjectID specifies a project where secrets are located.";
        type = (types.nullOr types.str);
        default = null;
      };
      "url" = mkOption {
        description = "URL configures the GitLab instance URL. Defaults to https://gitlab.com/.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderGitlab =
    res:
    {
      "auth" = mkProviderGitlabAuth res."auth";
    }
    // optionalAttrs (res."caBundle" != null) { inherit (res) "caBundle"; }
    // {
    }
    // optionalAttrs (res."caProvider" != null) {
      "caProvider" = mkProviderGitlabCaProvider res."caProvider";
    }
    // {
    }
    // optionalAttrs (res."environment" != null) { inherit (res) "environment"; }
    // {
    }
    // optionalAttrs (res."groupIDs" != [ ]) { inherit (res) "groupIDs"; }
    // {
    }
    // optionalAttrs res."inheritFromGroups" { inherit (res) "inheritFromGroups"; }
    // {
    }
    // optionalAttrs (res."projectID" != null) { inherit (res) "projectID"; }
    // {
    }
    // optionalAttrs (res."url" != null) { inherit (res) "url"; }
    // {
    };
  ProviderIbmAuthContainerAuthModule = types.submodule {
    options = {
      "iamEndpoint" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "profile" = mkOption {
        description = "the IBM Trusted Profile";
        type = types.str;
      };
      "tokenLocation" = mkOption {
        description = "Location the token is mounted on the pod";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderIbmAuthContainerAuth =
    res:
    {
    }
    // optionalAttrs (res."iamEndpoint" != null) { inherit (res) "iamEndpoint"; }
    // {
      inherit (res) "profile";
    }
    // optionalAttrs (res."tokenLocation" != null) { inherit (res) "tokenLocation"; }
    // {
    };
  ProviderIbmAuthModule = types.submodule {
    options = {
      "containerAuth" = mkOption {
        description = "IBMAuthContainerAuth defines container-based authentication with IAM Trusted Profile.";
        type = (types.nullOr ProviderIbmAuthContainerAuthModule);
        default = null;
      };
      "secretRef" = mkOption {
        description = "IBMAuthSecretRef contains the secret reference for IBM Cloud API key authentication.";
        type = (types.nullOr ProviderIbmAuthSecretRefModule);
        default = null;
      };
    };
  };
  mkProviderIbmAuth =
    res:
    {
    }
    // optionalAttrs (res."containerAuth" != null) {
      "containerAuth" = mkProviderIbmAuthContainerAuth res."containerAuth";
    }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderIbmAuthSecretRef res."secretRef";
    }
    // {
    };
  ProviderIbmAuthSecretRefModule = types.submodule {
    options = {
      "iamEndpoint" = mkOption {
        description = "The IAM endpoint used to obain a token";
        type = (types.nullOr types.str);
        default = null;
      };
      "secretApiKeySecretRef" = mkOption {
        description = "The SecretAccessKey is used for authentication";
        type = (types.nullOr ProviderIbmAuthSecretRefSecretApiKeySecretRefModule);
        default = null;
      };
    };
  };
  mkProviderIbmAuthSecretRef =
    res:
    {
    }
    // optionalAttrs (res."iamEndpoint" != null) { inherit (res) "iamEndpoint"; }
    // {
    }
    // optionalAttrs (res."secretApiKeySecretRef" != null) {
      "secretApiKeySecretRef" =
        mkProviderIbmAuthSecretRefSecretApiKeySecretRef
          res."secretApiKeySecretRef";
    }
    // {
    };
  ProviderIbmAuthSecretRefSecretApiKeySecretRefModule = types.submodule {
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
  mkProviderIbmAuthSecretRefSecretApiKeySecretRef =
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
  ProviderIbmModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth configures how secret-manager authenticates with the IBM secrets manager.";
        type = ProviderIbmAuthModule;
      };
      "serviceUrl" = mkOption {
        description = "ServiceURL is the Endpoint URL that is specific to the Secrets Manager service instance";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderIbm =
    res:
    {
      "auth" = mkProviderIbmAuth res."auth";
    }
    // optionalAttrs (res."serviceUrl" != null) { inherit (res) "serviceUrl"; }
    // {
    };
  ProviderInfisicalAuthAwsAuthCredentialsIdentityIdModule = types.submodule {
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
  mkProviderInfisicalAuthAwsAuthCredentialsIdentityId =
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
  ProviderInfisicalAuthAwsAuthCredentialsModule = types.submodule {
    options = {
      "identityId" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderInfisicalAuthAwsAuthCredentialsIdentityIdModule;
      };
    };
  };
  mkProviderInfisicalAuthAwsAuthCredentials = res: {
    "identityId" = mkProviderInfisicalAuthAwsAuthCredentialsIdentityId res."identityId";
  };
  ProviderInfisicalAuthAzureAuthCredentialsIdentityIdModule = types.submodule {
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
  mkProviderInfisicalAuthAzureAuthCredentialsIdentityId =
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
  ProviderInfisicalAuthAzureAuthCredentialsModule = types.submodule {
    options = {
      "identityId" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderInfisicalAuthAzureAuthCredentialsIdentityIdModule;
      };
      "resource" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = (types.nullOr ProviderInfisicalAuthAzureAuthCredentialsResourceModule);
        default = null;
      };
    };
  };
  mkProviderInfisicalAuthAzureAuthCredentials =
    res:
    {
      "identityId" = mkProviderInfisicalAuthAzureAuthCredentialsIdentityId res."identityId";
    }
    // optionalAttrs (res."resource" != null) {
      "resource" = mkProviderInfisicalAuthAzureAuthCredentialsResource res."resource";
    }
    // {
    };
  ProviderInfisicalAuthAzureAuthCredentialsResourceModule = types.submodule {
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
  mkProviderInfisicalAuthAzureAuthCredentialsResource =
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
  ProviderInfisicalAuthGcpIamAuthCredentialsIdentityIdModule = types.submodule {
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
  mkProviderInfisicalAuthGcpIamAuthCredentialsIdentityId =
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
  ProviderInfisicalAuthGcpIamAuthCredentialsModule = types.submodule {
    options = {
      "identityId" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderInfisicalAuthGcpIamAuthCredentialsIdentityIdModule;
      };
      "serviceAccountKeyFilePath" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderInfisicalAuthGcpIamAuthCredentialsServiceAccountKeyFilePathModule;
      };
    };
  };
  mkProviderInfisicalAuthGcpIamAuthCredentials = res: {
    "identityId" = mkProviderInfisicalAuthGcpIamAuthCredentialsIdentityId res."identityId";
    "serviceAccountKeyFilePath" =
      mkProviderInfisicalAuthGcpIamAuthCredentialsServiceAccountKeyFilePath
        res."serviceAccountKeyFilePath";
  };
  ProviderInfisicalAuthGcpIamAuthCredentialsServiceAccountKeyFilePathModule = types.submodule {
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
  mkProviderInfisicalAuthGcpIamAuthCredentialsServiceAccountKeyFilePath =
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
  ProviderInfisicalAuthGcpIdTokenAuthCredentialsIdentityIdModule = types.submodule {
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
  mkProviderInfisicalAuthGcpIdTokenAuthCredentialsIdentityId =
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
  ProviderInfisicalAuthGcpIdTokenAuthCredentialsModule = types.submodule {
    options = {
      "identityId" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderInfisicalAuthGcpIdTokenAuthCredentialsIdentityIdModule;
      };
    };
  };
  mkProviderInfisicalAuthGcpIdTokenAuthCredentials = res: {
    "identityId" = mkProviderInfisicalAuthGcpIdTokenAuthCredentialsIdentityId res."identityId";
  };
  ProviderInfisicalAuthJwtAuthCredentialsIdentityIdModule = types.submodule {
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
  mkProviderInfisicalAuthJwtAuthCredentialsIdentityId =
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
  ProviderInfisicalAuthJwtAuthCredentialsJwtModule = types.submodule {
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
  mkProviderInfisicalAuthJwtAuthCredentialsJwt =
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
  ProviderInfisicalAuthJwtAuthCredentialsModule = types.submodule {
    options = {
      "identityId" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderInfisicalAuthJwtAuthCredentialsIdentityIdModule;
      };
      "jwt" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderInfisicalAuthJwtAuthCredentialsJwtModule;
      };
    };
  };
  mkProviderInfisicalAuthJwtAuthCredentials = res: {
    "identityId" = mkProviderInfisicalAuthJwtAuthCredentialsIdentityId res."identityId";
    "jwt" = mkProviderInfisicalAuthJwtAuthCredentialsJwt res."jwt";
  };
  ProviderInfisicalAuthKubernetesAuthCredentialsIdentityIdModule = types.submodule {
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
  mkProviderInfisicalAuthKubernetesAuthCredentialsIdentityId =
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
  ProviderInfisicalAuthKubernetesAuthCredentialsModule = types.submodule {
    options = {
      "identityId" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderInfisicalAuthKubernetesAuthCredentialsIdentityIdModule;
      };
      "serviceAccountTokenPath" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = (types.nullOr ProviderInfisicalAuthKubernetesAuthCredentialsServiceAccountTokenPathModule);
        default = null;
      };
    };
  };
  mkProviderInfisicalAuthKubernetesAuthCredentials =
    res:
    {
      "identityId" = mkProviderInfisicalAuthKubernetesAuthCredentialsIdentityId res."identityId";
    }
    // optionalAttrs (res."serviceAccountTokenPath" != null) {
      "serviceAccountTokenPath" =
        mkProviderInfisicalAuthKubernetesAuthCredentialsServiceAccountTokenPath
          res."serviceAccountTokenPath";
    }
    // {
    };
  ProviderInfisicalAuthKubernetesAuthCredentialsServiceAccountTokenPathModule = types.submodule {
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
  mkProviderInfisicalAuthKubernetesAuthCredentialsServiceAccountTokenPath =
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
  ProviderInfisicalAuthLdapAuthCredentialsIdentityIdModule = types.submodule {
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
  mkProviderInfisicalAuthLdapAuthCredentialsIdentityId =
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
  ProviderInfisicalAuthLdapAuthCredentialsLdapPasswordModule = types.submodule {
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
  mkProviderInfisicalAuthLdapAuthCredentialsLdapPassword =
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
  ProviderInfisicalAuthLdapAuthCredentialsLdapUsernameModule = types.submodule {
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
  mkProviderInfisicalAuthLdapAuthCredentialsLdapUsername =
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
  ProviderInfisicalAuthLdapAuthCredentialsModule = types.submodule {
    options = {
      "identityId" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderInfisicalAuthLdapAuthCredentialsIdentityIdModule;
      };
      "ldapPassword" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderInfisicalAuthLdapAuthCredentialsLdapPasswordModule;
      };
      "ldapUsername" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderInfisicalAuthLdapAuthCredentialsLdapUsernameModule;
      };
    };
  };
  mkProviderInfisicalAuthLdapAuthCredentials = res: {
    "identityId" = mkProviderInfisicalAuthLdapAuthCredentialsIdentityId res."identityId";
    "ldapPassword" = mkProviderInfisicalAuthLdapAuthCredentialsLdapPassword res."ldapPassword";
    "ldapUsername" = mkProviderInfisicalAuthLdapAuthCredentialsLdapUsername res."ldapUsername";
  };
  ProviderInfisicalAuthModule = types.submodule {
    options = {
      "awsAuthCredentials" = mkOption {
        description = "AwsAuthCredentials represents the credentials for AWS authentication.";
        type = (types.nullOr ProviderInfisicalAuthAwsAuthCredentialsModule);
        default = null;
      };
      "azureAuthCredentials" = mkOption {
        description = "AzureAuthCredentials represents the credentials for Azure authentication.";
        type = (types.nullOr ProviderInfisicalAuthAzureAuthCredentialsModule);
        default = null;
      };
      "gcpIamAuthCredentials" = mkOption {
        description = "GcpIamAuthCredentials represents the credentials for GCP IAM authentication.";
        type = (types.nullOr ProviderInfisicalAuthGcpIamAuthCredentialsModule);
        default = null;
      };
      "gcpIdTokenAuthCredentials" = mkOption {
        description = "GcpIDTokenAuthCredentials represents the credentials for GCP ID token authentication.";
        type = (types.nullOr ProviderInfisicalAuthGcpIdTokenAuthCredentialsModule);
        default = null;
      };
      "jwtAuthCredentials" = mkOption {
        description = "JwtAuthCredentials represents the credentials for JWT authentication.";
        type = (types.nullOr ProviderInfisicalAuthJwtAuthCredentialsModule);
        default = null;
      };
      "kubernetesAuthCredentials" = mkOption {
        description = "KubernetesAuthCredentials represents the credentials for Kubernetes authentication.";
        type = (types.nullOr ProviderInfisicalAuthKubernetesAuthCredentialsModule);
        default = null;
      };
      "ldapAuthCredentials" = mkOption {
        description = "LdapAuthCredentials represents the credentials for LDAP authentication.";
        type = (types.nullOr ProviderInfisicalAuthLdapAuthCredentialsModule);
        default = null;
      };
      "ociAuthCredentials" = mkOption {
        description = "OciAuthCredentials represents the credentials for OCI authentication.";
        type = (types.nullOr ProviderInfisicalAuthOciAuthCredentialsModule);
        default = null;
      };
      "tokenAuthCredentials" = mkOption {
        description = "TokenAuthCredentials represents the credentials for access token-based authentication.";
        type = (types.nullOr ProviderInfisicalAuthTokenAuthCredentialsModule);
        default = null;
      };
      "universalAuthCredentials" = mkOption {
        description = "UniversalAuthCredentials represents the client credentials for universal authentication.";
        type = (types.nullOr ProviderInfisicalAuthUniversalAuthCredentialsModule);
        default = null;
      };
    };
  };
  mkProviderInfisicalAuth =
    res:
    {
    }
    // optionalAttrs (res."awsAuthCredentials" != null) {
      "awsAuthCredentials" = mkProviderInfisicalAuthAwsAuthCredentials res."awsAuthCredentials";
    }
    // {
    }
    // optionalAttrs (res."azureAuthCredentials" != null) {
      "azureAuthCredentials" = mkProviderInfisicalAuthAzureAuthCredentials res."azureAuthCredentials";
    }
    // {
    }
    // optionalAttrs (res."gcpIamAuthCredentials" != null) {
      "gcpIamAuthCredentials" = mkProviderInfisicalAuthGcpIamAuthCredentials res."gcpIamAuthCredentials";
    }
    // {
    }
    // optionalAttrs (res."gcpIdTokenAuthCredentials" != null) {
      "gcpIdTokenAuthCredentials" =
        mkProviderInfisicalAuthGcpIdTokenAuthCredentials
          res."gcpIdTokenAuthCredentials";
    }
    // {
    }
    // optionalAttrs (res."jwtAuthCredentials" != null) {
      "jwtAuthCredentials" = mkProviderInfisicalAuthJwtAuthCredentials res."jwtAuthCredentials";
    }
    // {
    }
    // optionalAttrs (res."kubernetesAuthCredentials" != null) {
      "kubernetesAuthCredentials" =
        mkProviderInfisicalAuthKubernetesAuthCredentials
          res."kubernetesAuthCredentials";
    }
    // {
    }
    // optionalAttrs (res."ldapAuthCredentials" != null) {
      "ldapAuthCredentials" = mkProviderInfisicalAuthLdapAuthCredentials res."ldapAuthCredentials";
    }
    // {
    }
    // optionalAttrs (res."ociAuthCredentials" != null) {
      "ociAuthCredentials" = mkProviderInfisicalAuthOciAuthCredentials res."ociAuthCredentials";
    }
    // {
    }
    // optionalAttrs (res."tokenAuthCredentials" != null) {
      "tokenAuthCredentials" = mkProviderInfisicalAuthTokenAuthCredentials res."tokenAuthCredentials";
    }
    // {
    }
    // optionalAttrs (res."universalAuthCredentials" != null) {
      "universalAuthCredentials" =
        mkProviderInfisicalAuthUniversalAuthCredentials
          res."universalAuthCredentials";
    }
    // {
    };
  ProviderInfisicalAuthOciAuthCredentialsFingerprintModule = types.submodule {
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
  mkProviderInfisicalAuthOciAuthCredentialsFingerprint =
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
  ProviderInfisicalAuthOciAuthCredentialsIdentityIdModule = types.submodule {
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
  mkProviderInfisicalAuthOciAuthCredentialsIdentityId =
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
  ProviderInfisicalAuthOciAuthCredentialsModule = types.submodule {
    options = {
      "fingerprint" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderInfisicalAuthOciAuthCredentialsFingerprintModule;
      };
      "identityId" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderInfisicalAuthOciAuthCredentialsIdentityIdModule;
      };
      "privateKey" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderInfisicalAuthOciAuthCredentialsPrivateKeyModule;
      };
      "privateKeyPassphrase" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = (types.nullOr ProviderInfisicalAuthOciAuthCredentialsPrivateKeyPassphraseModule);
        default = null;
      };
      "region" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderInfisicalAuthOciAuthCredentialsRegionModule;
      };
      "tenancyId" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderInfisicalAuthOciAuthCredentialsTenancyIdModule;
      };
      "userId" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderInfisicalAuthOciAuthCredentialsUserIdModule;
      };
    };
  };
  mkProviderInfisicalAuthOciAuthCredentials =
    res:
    {
      "fingerprint" = mkProviderInfisicalAuthOciAuthCredentialsFingerprint res."fingerprint";
      "identityId" = mkProviderInfisicalAuthOciAuthCredentialsIdentityId res."identityId";
      "privateKey" = mkProviderInfisicalAuthOciAuthCredentialsPrivateKey res."privateKey";
    }
    // optionalAttrs (res."privateKeyPassphrase" != null) {
      "privateKeyPassphrase" =
        mkProviderInfisicalAuthOciAuthCredentialsPrivateKeyPassphrase
          res."privateKeyPassphrase";
    }
    // {
      "region" = mkProviderInfisicalAuthOciAuthCredentialsRegion res."region";
      "tenancyId" = mkProviderInfisicalAuthOciAuthCredentialsTenancyId res."tenancyId";
      "userId" = mkProviderInfisicalAuthOciAuthCredentialsUserId res."userId";
    };
  ProviderInfisicalAuthOciAuthCredentialsPrivateKeyModule = types.submodule {
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
  mkProviderInfisicalAuthOciAuthCredentialsPrivateKey =
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
  ProviderInfisicalAuthOciAuthCredentialsPrivateKeyPassphraseModule = types.submodule {
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
  mkProviderInfisicalAuthOciAuthCredentialsPrivateKeyPassphrase =
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
  ProviderInfisicalAuthOciAuthCredentialsRegionModule = types.submodule {
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
  mkProviderInfisicalAuthOciAuthCredentialsRegion =
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
  ProviderInfisicalAuthOciAuthCredentialsTenancyIdModule = types.submodule {
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
  mkProviderInfisicalAuthOciAuthCredentialsTenancyId =
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
  ProviderInfisicalAuthOciAuthCredentialsUserIdModule = types.submodule {
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
  mkProviderInfisicalAuthOciAuthCredentialsUserId =
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
  ProviderInfisicalAuthTokenAuthCredentialsAccessTokenModule = types.submodule {
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
  mkProviderInfisicalAuthTokenAuthCredentialsAccessToken =
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
  ProviderInfisicalAuthTokenAuthCredentialsModule = types.submodule {
    options = {
      "accessToken" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderInfisicalAuthTokenAuthCredentialsAccessTokenModule;
      };
    };
  };
  mkProviderInfisicalAuthTokenAuthCredentials = res: {
    "accessToken" = mkProviderInfisicalAuthTokenAuthCredentialsAccessToken res."accessToken";
  };
  ProviderInfisicalAuthUniversalAuthCredentialsClientIdModule = types.submodule {
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
  mkProviderInfisicalAuthUniversalAuthCredentialsClientId =
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
  ProviderInfisicalAuthUniversalAuthCredentialsClientSecretModule = types.submodule {
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
  mkProviderInfisicalAuthUniversalAuthCredentialsClientSecret =
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
  ProviderInfisicalAuthUniversalAuthCredentialsModule = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderInfisicalAuthUniversalAuthCredentialsClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderInfisicalAuthUniversalAuthCredentialsClientSecretModule;
      };
    };
  };
  mkProviderInfisicalAuthUniversalAuthCredentials = res: {
    "clientId" = mkProviderInfisicalAuthUniversalAuthCredentialsClientId res."clientId";
    "clientSecret" = mkProviderInfisicalAuthUniversalAuthCredentialsClientSecret res."clientSecret";
  };
  ProviderInfisicalCaProviderModule = types.submodule {
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
  mkProviderInfisicalCaProvider =
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
  ProviderInfisicalModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth configures how the Operator authenticates with the Infisical API";
        type = ProviderInfisicalAuthModule;
      };
      "caBundle" = mkOption {
        description = "CABundle is a PEM-encoded CA certificate bundle used to validate\nthe Infisical server's TLS certificate. Mutually exclusive with CAProvider.";
        type = (types.nullOr types.str);
        default = null;
      };
      "caProvider" = mkOption {
        description = "CAProvider is a reference to a Secret or ConfigMap that contains a CA certificate.\nThe certificate is used to validate the Infisical server's TLS certificate.\nMutually exclusive with CABundle.";
        type = (types.nullOr ProviderInfisicalCaProviderModule);
        default = null;
      };
      "hostAPI" = mkOption {
        description = "HostAPI specifies the base URL of the Infisical API. If not provided, it defaults to \"https://app.infisical.com/api\".";
        type = (types.nullOr types.str);
        default = "https://app.infisical.com/api";
      };
      "secretsScope" = mkOption {
        description = "SecretsScope defines the scope of the secrets within the workspace";
        type = ProviderInfisicalSecretsScopeModule;
      };
    };
  };
  mkProviderInfisical =
    res:
    {
      "auth" = mkProviderInfisicalAuth res."auth";
    }
    // optionalAttrs (res."caBundle" != null) { inherit (res) "caBundle"; }
    // {
    }
    // optionalAttrs (res."caProvider" != null) {
      "caProvider" = mkProviderInfisicalCaProvider res."caProvider";
    }
    // {
    }
    // optionalAttrs (res."hostAPI" != null) { inherit (res) "hostAPI"; }
    // {
      "secretsScope" = mkProviderInfisicalSecretsScope res."secretsScope";
    };
  ProviderInfisicalSecretsScopeModule = types.submodule {
    options = {
      "environmentSlug" = mkOption {
        description = "EnvironmentSlug is the required slug identifier for the environment.";
        type = types.str;
      };
      "expandSecretReferences" = mkOption {
        description = "ExpandSecretReferences indicates whether secret references should be expanded. Defaults to true if not provided.";
        type = types.bool;
        default = true;
      };
      "projectSlug" = mkOption {
        description = "ProjectSlug is the required slug identifier for the project.";
        type = types.str;
      };
      "recursive" = mkOption {
        description = "Recursive indicates whether the secrets should be fetched recursively. Defaults to false if not provided.";
        type = types.bool;
        default = false;
      };
      "secretsPath" = mkOption {
        description = "SecretsPath specifies the path to the secrets within the workspace. Defaults to \"/\" if not provided.";
        type = (types.nullOr types.str);
        default = "/";
      };
    };
  };
  mkProviderInfisicalSecretsScope =
    res:
    {
      inherit (res) "environmentSlug";
    }
    // optionalAttrs (res."expandSecretReferences" != null) { inherit (res) "expandSecretReferences"; }
    // {
      inherit (res) "projectSlug";
    }
    // optionalAttrs res."recursive" { inherit (res) "recursive"; }
    // {
    }
    // optionalAttrs (res."secretsPath" != null) { inherit (res) "secretsPath"; }
    // {
    };
  ProviderKeepersecurityAuthRefModule = types.submodule {
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
  mkProviderKeepersecurityAuthRef =
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
  ProviderKeepersecurityModule = types.submodule {
    options = {
      "authRef" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderKeepersecurityAuthRefModule;
      };
      "folderID" = mkOption {
        type = types.str;
      };
    };
  };
  mkProviderKeepersecurity = res: {
    "authRef" = mkProviderKeepersecurityAuthRef res."authRef";
    inherit (res) "folderID";
  };
  ProviderKubernetesAuthCertClientCertModule = types.submodule {
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
  mkProviderKubernetesAuthCertClientCert =
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
  ProviderKubernetesAuthCertClientKeyModule = types.submodule {
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
  mkProviderKubernetesAuthCertClientKey =
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
  ProviderKubernetesAuthCertModule = types.submodule {
    options = {
      "clientCert" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = (types.nullOr ProviderKubernetesAuthCertClientCertModule);
        default = null;
      };
      "clientKey" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = (types.nullOr ProviderKubernetesAuthCertClientKeyModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesAuthCert =
    res:
    {
    }
    // optionalAttrs (res."clientCert" != null) {
      "clientCert" = mkProviderKubernetesAuthCertClientCert res."clientCert";
    }
    // {
    }
    // optionalAttrs (res."clientKey" != null) {
      "clientKey" = mkProviderKubernetesAuthCertClientKey res."clientKey";
    }
    // {
    };
  ProviderKubernetesAuthModule = types.submodule {
    options = {
      "cert" = mkOption {
        description = "has both clientCert and clientKey as secretKeySelector";
        type = (types.nullOr ProviderKubernetesAuthCertModule);
        default = null;
      };
      "serviceAccount" = mkOption {
        description = "points to a service account that should be used for authentication";
        type = (types.nullOr ProviderKubernetesAuthServiceAccountModule);
        default = null;
      };
      "token" = mkOption {
        description = "use static token to authenticate with";
        type = (types.nullOr ProviderKubernetesAuthTokenModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesAuth =
    res:
    {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkProviderKubernetesAuthCert res."cert"; }
    // {
    }
    // optionalAttrs (res."serviceAccount" != null) {
      "serviceAccount" = mkProviderKubernetesAuthServiceAccount res."serviceAccount";
    }
    // {
    }
    // optionalAttrs (res."token" != null) { "token" = mkProviderKubernetesAuthToken res."token"; }
    // {
    };
  ProviderKubernetesAuthRefModule = types.submodule {
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
  mkProviderKubernetesAuthRef =
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
  ProviderKubernetesAuthServiceAccountModule = types.submodule {
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
  mkProviderKubernetesAuthServiceAccount =
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
  ProviderKubernetesAuthTokenBearerTokenModule = types.submodule {
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
  mkProviderKubernetesAuthTokenBearerToken =
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
  ProviderKubernetesAuthTokenModule = types.submodule {
    options = {
      "bearerToken" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = (types.nullOr ProviderKubernetesAuthTokenBearerTokenModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesAuthToken =
    res:
    {
    }
    // optionalAttrs (res."bearerToken" != null) {
      "bearerToken" = mkProviderKubernetesAuthTokenBearerToken res."bearerToken";
    }
    // {
    };
  ProviderKubernetesModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth configures how secret-manager authenticates with a Kubernetes instance.";
        type = (types.nullOr ProviderKubernetesAuthModule);
        default = null;
      };
      "authRef" = mkOption {
        description = "A reference to a secret that contains the auth information.";
        type = (types.nullOr ProviderKubernetesAuthRefModule);
        default = null;
      };
      "remoteNamespace" = mkOption {
        description = "Remote namespace to fetch the secrets from";
        type = (types.nullOr types.str);
        default = "default";
      };
      "server" = mkOption {
        description = "configures the Kubernetes server Address.";
        type = (types.nullOr ProviderKubernetesServerModule);
        default = null;
      };
    };
  };
  mkProviderKubernetes =
    res:
    {
    }
    // optionalAttrs (res."auth" != null) { "auth" = mkProviderKubernetesAuth res."auth"; }
    // {
    }
    // optionalAttrs (res."authRef" != null) { "authRef" = mkProviderKubernetesAuthRef res."authRef"; }
    // {
    }
    // optionalAttrs (res."remoteNamespace" != null) { inherit (res) "remoteNamespace"; }
    // {
    }
    // optionalAttrs (res."server" != null) { "server" = mkProviderKubernetesServer res."server"; }
    // {
    };
  ProviderKubernetesServerCaProviderModule = types.submodule {
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
  mkProviderKubernetesServerCaProvider =
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
  ProviderKubernetesServerModule = types.submodule {
    options = {
      "caBundle" = mkOption {
        description = "CABundle is a base64-encoded CA certificate";
        type = (types.nullOr types.str);
        default = null;
      };
      "caProvider" = mkOption {
        description = "see: https://external-secrets.io/v0.4.1/spec/#external-secrets.io/v1alpha1.CAProvider";
        type = (types.nullOr ProviderKubernetesServerCaProviderModule);
        default = null;
      };
      "url" = mkOption {
        description = "configures the Kubernetes server Address.";
        type = (types.nullOr types.str);
        default = "kubernetes.default";
      };
    };
  };
  mkProviderKubernetesServer =
    res:
    {
    }
    // optionalAttrs (res."caBundle" != null) { inherit (res) "caBundle"; }
    // {
    }
    // optionalAttrs (res."caProvider" != null) {
      "caProvider" = mkProviderKubernetesServerCaProvider res."caProvider";
    }
    // {
    }
    // optionalAttrs (res."url" != null) { inherit (res) "url"; }
    // {
    };
  ProviderModule = types.submodule {
    options = {
      "akeyless" = mkOption {
        description = "Akeyless configures this store to sync secrets using Akeyless Vault provider";
        type = (types.nullOr ProviderAkeylessModule);
        default = null;
      };
      "aws" = mkOption {
        description = "AWS configures this store to sync secrets using AWS Secret Manager provider";
        type = (types.nullOr ProviderAwsModule);
        default = null;
      };
      "azurekv" = mkOption {
        description = "AzureKV configures this store to sync secrets using Azure Key Vault provider";
        type = (types.nullOr ProviderAzurekvModule);
        default = null;
      };
      "barbican" = mkOption {
        description = "Barbican configures this store to sync secrets using the OpenStack Barbican provider";
        type = (types.nullOr ProviderBarbicanModule);
        default = null;
      };
      "beyondtrust" = mkOption {
        description = "Beyondtrust configures this store to sync secrets using Password Safe provider.";
        type = (types.nullOr ProviderBeyondtrustModule);
        default = null;
      };
      "bitwardensecretsmanager" = mkOption {
        description = "BitwardenSecretsManager configures this store to sync secrets using BitwardenSecretsManager provider";
        type = (types.nullOr ProviderBitwardensecretsmanagerModule);
        default = null;
      };
      "chef" = mkOption {
        description = "Chef configures this store to sync secrets with chef server";
        type = (types.nullOr ProviderChefModule);
        default = null;
      };
      "cloudrusm" = mkOption {
        description = "CloudruSM configures this store to sync secrets using the Cloud.ru Secret Manager provider";
        type = (types.nullOr ProviderCloudrusmModule);
        default = null;
      };
      "conjur" = mkOption {
        description = "Conjur configures this store to sync secrets using conjur provider";
        type = (types.nullOr ProviderConjurModule);
        default = null;
      };
      "delinea" = mkOption {
        description = "Delinea DevOps Secrets Vault\nhttps://docs.delinea.com/online-help/products/devops-secrets-vault/current";
        type = (types.nullOr ProviderDelineaModule);
        default = null;
      };
      "doppler" = mkOption {
        description = "Doppler configures this store to sync secrets using the Doppler provider";
        type = (types.nullOr ProviderDopplerModule);
        default = null;
      };
      "dvls" = mkOption {
        description = "DVLS configures this store to sync secrets using Devolutions Server provider";
        type = (types.nullOr ProviderDvlsModule);
        default = null;
      };
      "fake" = mkOption {
        description = "Fake configures a store with static key/value pairs";
        type = (types.nullOr ProviderFakeModule);
        default = null;
      };
      "fortanix" = mkOption {
        description = "Fortanix configures this store to sync secrets using the Fortanix provider";
        type = (types.nullOr ProviderFortanixModule);
        default = null;
      };
      "gcpsm" = mkOption {
        description = "GCPSM configures this store to sync secrets using Google Cloud Platform Secret Manager provider";
        type = (types.nullOr ProviderGcpsmModule);
        default = null;
      };
      "github" = mkOption {
        description = "Github configures this store to push GitHub Actions secrets using the GitHub API provider.\nNote: This provider only supports write operations (PushSecret) and cannot fetch secrets from GitHub";
        type = (types.nullOr ProviderGithubModule);
        default = null;
      };
      "gitlab" = mkOption {
        description = "GitLab configures this store to sync secrets using GitLab Variables provider";
        type = (types.nullOr ProviderGitlabModule);
        default = null;
      };
      "ibm" = mkOption {
        description = "IBM configures this store to sync secrets using IBM Cloud provider";
        type = (types.nullOr ProviderIbmModule);
        default = null;
      };
      "infisical" = mkOption {
        description = "Infisical configures this store to sync secrets using the Infisical provider";
        type = (types.nullOr ProviderInfisicalModule);
        default = null;
      };
      "keepersecurity" = mkOption {
        description = "KeeperSecurity configures this store to sync secrets using the KeeperSecurity provider";
        type = (types.nullOr ProviderKeepersecurityModule);
        default = null;
      };
      "kubernetes" = mkOption {
        description = "Kubernetes configures this store to sync secrets using a Kubernetes cluster provider";
        type = (types.nullOr ProviderKubernetesModule);
        default = null;
      };
      "nebiusmysterybox" = mkOption {
        description = "NebiusMysterybox configures this store to sync secrets using NebiusMysterybox provider";
        type = (types.nullOr ProviderNebiusmysteryboxModule);
        default = null;
      };
      "ngrok" = mkOption {
        description = "Ngrok configures this store to sync secrets using the ngrok provider.";
        type = (types.nullOr ProviderNgrokModule);
        default = null;
      };
      "onboardbase" = mkOption {
        description = "Onboardbase configures this store to sync secrets using the Onboardbase provider";
        type = (types.nullOr ProviderOnboardbaseModule);
        default = null;
      };
      "onepassword" = mkOption {
        description = "OnePassword configures this store to sync secrets using the 1Password Cloud provider";
        type = (types.nullOr ProviderOnepasswordModule);
        default = null;
      };
      "onepasswordSDK" = mkOption {
        description = "OnePasswordSDK configures this store to use 1Password's new Go SDK to sync secrets.";
        type = (types.nullOr ProviderOnepasswordSDKModule);
        default = null;
      };
      "oracle" = mkOption {
        description = "Oracle configures this store to sync secrets using Oracle Vault provider";
        type = (types.nullOr ProviderOracleModule);
        default = null;
      };
      "passbolt" = mkOption {
        description = "PassboltProvider provides access to Passbolt secrets manager.\nSee: https://www.passbolt.com.";
        type = (types.nullOr ProviderPassboltModule);
        default = null;
      };
      "passworddepot" = mkOption {
        description = "PasswordDepotProvider configures a store to sync secrets with a Password Depot instance.";
        type = (types.nullOr ProviderPassworddepotModule);
        default = null;
      };
      "previder" = mkOption {
        description = "Previder configures this store to sync secrets using the Previder provider";
        type = (types.nullOr ProviderPreviderModule);
        default = null;
      };
      "pulumi" = mkOption {
        description = "Pulumi configures this store to sync secrets using the Pulumi provider";
        type = (types.nullOr ProviderPulumiModule);
        default = null;
      };
      "scaleway" = mkOption {
        description = "Scaleway configures this store to sync secrets using the Scaleway provider.";
        type = (types.nullOr ProviderScalewayModule);
        default = null;
      };
      "secretserver" = mkOption {
        description = "SecretServer configures this store to sync secrets using SecretServer provider\nhttps://docs.delinea.com/online-help/secret-server/start.htm";
        type = (types.nullOr ProviderSecretserverModule);
        default = null;
      };
      "senhasegura" = mkOption {
        description = "Senhasegura configures this store to sync secrets using senhasegura provider";
        type = (types.nullOr ProviderSenhaseguraModule);
        default = null;
      };
      "vault" = mkOption {
        description = "Vault configures this store to sync secrets using the HashiCorp Vault provider.";
        type = (types.nullOr ProviderVaultModule);
        default = null;
      };
      "volcengine" = mkOption {
        description = "Volcengine configures this store to sync secrets using the Volcengine provider";
        type = (types.nullOr ProviderVolcengineModule);
        default = null;
      };
      "webhook" = mkOption {
        description = "Webhook configures this store to sync secrets using a generic templated webhook";
        type = (types.nullOr ProviderWebhookModule);
        default = null;
      };
      "yandexcertificatemanager" = mkOption {
        description = "YandexCertificateManager configures this store to sync secrets using Yandex Certificate Manager provider";
        type = (types.nullOr ProviderYandexcertificatemanagerModule);
        default = null;
      };
      "yandexlockbox" = mkOption {
        description = "YandexLockbox configures this store to sync secrets using Yandex Lockbox provider";
        type = (types.nullOr ProviderYandexlockboxModule);
        default = null;
      };
    };
  };
  mkProvider =
    res:
    {
    }
    // optionalAttrs (res."akeyless" != null) { "akeyless" = mkProviderAkeyless res."akeyless"; }
    // {
    }
    // optionalAttrs (res."aws" != null) { "aws" = mkProviderAws res."aws"; }
    // {
    }
    // optionalAttrs (res."azurekv" != null) { "azurekv" = mkProviderAzurekv res."azurekv"; }
    // {
    }
    // optionalAttrs (res."barbican" != null) { "barbican" = mkProviderBarbican res."barbican"; }
    // {
    }
    // optionalAttrs (res."beyondtrust" != null) {
      "beyondtrust" = mkProviderBeyondtrust res."beyondtrust";
    }
    // {
    }
    // optionalAttrs (res."bitwardensecretsmanager" != null) {
      "bitwardensecretsmanager" = mkProviderBitwardensecretsmanager res."bitwardensecretsmanager";
    }
    // {
    }
    // optionalAttrs (res."chef" != null) { "chef" = mkProviderChef res."chef"; }
    // {
    }
    // optionalAttrs (res."cloudrusm" != null) { "cloudrusm" = mkProviderCloudrusm res."cloudrusm"; }
    // {
    }
    // optionalAttrs (res."conjur" != null) { "conjur" = mkProviderConjur res."conjur"; }
    // {
    }
    // optionalAttrs (res."delinea" != null) { "delinea" = mkProviderDelinea res."delinea"; }
    // {
    }
    // optionalAttrs (res."doppler" != null) { "doppler" = mkProviderDoppler res."doppler"; }
    // {
    }
    // optionalAttrs (res."dvls" != null) { "dvls" = mkProviderDvls res."dvls"; }
    // {
    }
    // optionalAttrs (res."fake" != null) { "fake" = mkProviderFake res."fake"; }
    // {
    }
    // optionalAttrs (res."fortanix" != null) { "fortanix" = mkProviderFortanix res."fortanix"; }
    // {
    }
    // optionalAttrs (res."gcpsm" != null) { "gcpsm" = mkProviderGcpsm res."gcpsm"; }
    // {
    }
    // optionalAttrs (res."github" != null) { "github" = mkProviderGithub res."github"; }
    // {
    }
    // optionalAttrs (res."gitlab" != null) { "gitlab" = mkProviderGitlab res."gitlab"; }
    // {
    }
    // optionalAttrs (res."ibm" != null) { "ibm" = mkProviderIbm res."ibm"; }
    // {
    }
    // optionalAttrs (res."infisical" != null) { "infisical" = mkProviderInfisical res."infisical"; }
    // {
    }
    // optionalAttrs (res."keepersecurity" != null) {
      "keepersecurity" = mkProviderKeepersecurity res."keepersecurity";
    }
    // {
    }
    // optionalAttrs (res."kubernetes" != null) {
      "kubernetes" = mkProviderKubernetes res."kubernetes";
    }
    // {
    }
    // optionalAttrs (res."nebiusmysterybox" != null) {
      "nebiusmysterybox" = mkProviderNebiusmysterybox res."nebiusmysterybox";
    }
    // {
    }
    // optionalAttrs (res."ngrok" != null) { "ngrok" = mkProviderNgrok res."ngrok"; }
    // {
    }
    // optionalAttrs (res."onboardbase" != null) {
      "onboardbase" = mkProviderOnboardbase res."onboardbase";
    }
    // {
    }
    // optionalAttrs (res."onepassword" != null) {
      "onepassword" = mkProviderOnepassword res."onepassword";
    }
    // {
    }
    // optionalAttrs (res."onepasswordSDK" != null) {
      "onepasswordSDK" = mkProviderOnepasswordSDK res."onepasswordSDK";
    }
    // {
    }
    // optionalAttrs (res."oracle" != null) { "oracle" = mkProviderOracle res."oracle"; }
    // {
    }
    // optionalAttrs (res."passbolt" != null) { "passbolt" = mkProviderPassbolt res."passbolt"; }
    // {
    }
    // optionalAttrs (res."passworddepot" != null) {
      "passworddepot" = mkProviderPassworddepot res."passworddepot";
    }
    // {
    }
    // optionalAttrs (res."previder" != null) { "previder" = mkProviderPrevider res."previder"; }
    // {
    }
    // optionalAttrs (res."pulumi" != null) { "pulumi" = mkProviderPulumi res."pulumi"; }
    // {
    }
    // optionalAttrs (res."scaleway" != null) { "scaleway" = mkProviderScaleway res."scaleway"; }
    // {
    }
    // optionalAttrs (res."secretserver" != null) {
      "secretserver" = mkProviderSecretserver res."secretserver";
    }
    // {
    }
    // optionalAttrs (res."senhasegura" != null) {
      "senhasegura" = mkProviderSenhasegura res."senhasegura";
    }
    // {
    }
    // optionalAttrs (res."vault" != null) { "vault" = mkProviderVault res."vault"; }
    // {
    }
    // optionalAttrs (res."volcengine" != null) {
      "volcengine" = mkProviderVolcengine res."volcengine";
    }
    // {
    }
    // optionalAttrs (res."webhook" != null) { "webhook" = mkProviderWebhook res."webhook"; }
    // {
    }
    // optionalAttrs (res."yandexcertificatemanager" != null) {
      "yandexcertificatemanager" = mkProviderYandexcertificatemanager res."yandexcertificatemanager";
    }
    // {
    }
    // optionalAttrs (res."yandexlockbox" != null) {
      "yandexlockbox" = mkProviderYandexlockbox res."yandexlockbox";
    }
    // {
    };
  ProviderNebiusmysteryboxAuthModule = types.submodule {
    options = {
      "serviceAccountCredsSecretRef" = mkOption {
        description = "ServiceAccountCreds references a Kubernetes Secret key that contains a JSON\ndocument with service account credentials used to get an IAM token.\n\nExpected JSON structure:\n{\n  \"subject-credentials\": {\n    \"alg\": \"RS256\",\n    \"private-key\": \"-----BEGIN PRIVATE KEY-----\\n<private-key>\\n-----END PRIVATE KEY-----\\n\",\n    \"kid\": \"<public-key-id>\",\n    \"iss\": \"<issuer-service-account-id>\",\n    \"sub\": \"<subject-service-account-id>\"\n  }\n}";
        type = (types.nullOr ProviderNebiusmysteryboxAuthServiceAccountCredsSecretRefModule);
        default = null;
      };
      "tokenSecretRef" = mkOption {
        description = "Token authenticates with Nebius Mysterybox by presenting a token.";
        type = (types.nullOr ProviderNebiusmysteryboxAuthTokenSecretRefModule);
        default = null;
      };
    };
  };
  mkProviderNebiusmysteryboxAuth =
    res:
    {
    }
    // optionalAttrs (res."serviceAccountCredsSecretRef" != null) {
      "serviceAccountCredsSecretRef" =
        mkProviderNebiusmysteryboxAuthServiceAccountCredsSecretRef
          res."serviceAccountCredsSecretRef";
    }
    // {
    }
    // optionalAttrs (res."tokenSecretRef" != null) {
      "tokenSecretRef" = mkProviderNebiusmysteryboxAuthTokenSecretRef res."tokenSecretRef";
    }
    // {
    };
  ProviderNebiusmysteryboxAuthServiceAccountCredsSecretRefModule = types.submodule {
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
  mkProviderNebiusmysteryboxAuthServiceAccountCredsSecretRef =
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
  ProviderNebiusmysteryboxAuthTokenSecretRefModule = types.submodule {
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
  mkProviderNebiusmysteryboxAuthTokenSecretRef =
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
  ProviderNebiusmysteryboxCaProviderCertSecretRefModule = types.submodule {
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
  mkProviderNebiusmysteryboxCaProviderCertSecretRef =
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
  ProviderNebiusmysteryboxCaProviderModule = types.submodule {
    options = {
      "certSecretRef" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = (types.nullOr ProviderNebiusmysteryboxCaProviderCertSecretRefModule);
        default = null;
      };
    };
  };
  mkProviderNebiusmysteryboxCaProvider =
    res:
    {
    }
    // optionalAttrs (res."certSecretRef" != null) {
      "certSecretRef" = mkProviderNebiusmysteryboxCaProviderCertSecretRef res."certSecretRef";
    }
    // {
    };
  ProviderNebiusmysteryboxModule = types.submodule {
    options = {
      "apiDomain" = mkOption {
        description = "NebiusMysterybox API endpoint";
        type = types.str;
      };
      "auth" = mkOption {
        description = "Auth defines parameters to authenticate in MysteryBox";
        type = ProviderNebiusmysteryboxAuthModule;
      };
      "caProvider" = mkOption {
        description = "The provider for the CA bundle to use to validate NebiusMysterybox server certificate.";
        type = (types.nullOr ProviderNebiusmysteryboxCaProviderModule);
        default = null;
      };
    };
  };
  mkProviderNebiusmysterybox =
    res:
    {
      inherit (res) "apiDomain";
      "auth" = mkProviderNebiusmysteryboxAuth res."auth";
    }
    // optionalAttrs (res."caProvider" != null) {
      "caProvider" = mkProviderNebiusmysteryboxCaProvider res."caProvider";
    }
    // {
    };
  ProviderNgrokAuthApiKeyModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "SecretRef is a reference to a secret containing the ngrok API key.";
        type = (types.nullOr ProviderNgrokAuthApiKeySecretRefModule);
        default = null;
      };
    };
  };
  mkProviderNgrokAuthApiKey =
    res:
    {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderNgrokAuthApiKeySecretRef res."secretRef";
    }
    // {
    };
  ProviderNgrokAuthApiKeySecretRefModule = types.submodule {
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
  mkProviderNgrokAuthApiKeySecretRef =
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
  ProviderNgrokAuthModule = types.submodule {
    options = {
      "apiKey" = mkOption {
        description = "APIKey is the API Key used to authenticate with ngrok. See https://ngrok.com/docs/api/#authentication";
        type = (types.nullOr ProviderNgrokAuthApiKeyModule);
        default = null;
      };
    };
  };
  mkProviderNgrokAuth =
    res:
    {
    }
    // optionalAttrs (res."apiKey" != null) { "apiKey" = mkProviderNgrokAuthApiKey res."apiKey"; }
    // {
    };
  ProviderNgrokModule = types.submodule {
    options = {
      "apiUrl" = mkOption {
        description = "APIURL is the URL of the ngrok API.";
        type = (types.nullOr types.str);
        default = "https://api.ngrok.com";
      };
      "auth" = mkOption {
        description = "Auth configures how the ngrok provider authenticates with the ngrok API.";
        type = ProviderNgrokAuthModule;
      };
      "vault" = mkOption {
        description = "Vault configures the ngrok vault to sync secrets with.";
        type = ProviderNgrokVaultModule;
      };
    };
  };
  mkProviderNgrok =
    res:
    {
    }
    // optionalAttrs (res."apiUrl" != null) { inherit (res) "apiUrl"; }
    // {
      "auth" = mkProviderNgrokAuth res."auth";
      "vault" = mkProviderNgrokVault res."vault";
    };
  ProviderNgrokVaultModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the name of the ngrok vault to sync secrets with.";
        type = types.str;
      };
    };
  };
  mkProviderNgrokVault = res: {
    inherit (res) "name";
  };
  ProviderOnboardbaseAuthApiKeyRefModule = types.submodule {
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
  mkProviderOnboardbaseAuthApiKeyRef =
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
  ProviderOnboardbaseAuthModule = types.submodule {
    options = {
      "apiKeyRef" = mkOption {
        description = "OnboardbaseAPIKey is the APIKey generated by an admin account.\nIt is used to recognize and authorize access to a project and environment within onboardbase";
        type = ProviderOnboardbaseAuthApiKeyRefModule;
      };
      "passcodeRef" = mkOption {
        description = "OnboardbasePasscode is the passcode attached to the API Key";
        type = ProviderOnboardbaseAuthPasscodeRefModule;
      };
    };
  };
  mkProviderOnboardbaseAuth = res: {
    "apiKeyRef" = mkProviderOnboardbaseAuthApiKeyRef res."apiKeyRef";
    "passcodeRef" = mkProviderOnboardbaseAuthPasscodeRef res."passcodeRef";
  };
  ProviderOnboardbaseAuthPasscodeRefModule = types.submodule {
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
  mkProviderOnboardbaseAuthPasscodeRef =
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
  ProviderOnboardbaseModule = types.submodule {
    options = {
      "apiHost" = mkOption {
        description = "APIHost use this to configure the host url for the API for selfhosted installation, default is https://public.onboardbase.com/api/v1/";
        type = types.str;
      };
      "auth" = mkOption {
        description = "Auth configures how the Operator authenticates with the Onboardbase API";
        type = ProviderOnboardbaseAuthModule;
      };
      "environment" = mkOption {
        description = "Environment is the name of an environmnent within a project to pull the secrets from";
        type = types.str;
      };
      "project" = mkOption {
        description = "Project is an onboardbase project that the secrets should be pulled from";
        type = types.str;
      };
    };
  };
  mkProviderOnboardbase = res: {
    inherit (res) "apiHost";
    "auth" = mkProviderOnboardbaseAuth res."auth";
    inherit (res) "environment";
    inherit (res) "project";
  };
  ProviderOnepasswordAuthModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "OnePasswordAuthSecretRef holds secret references for 1Password credentials.";
        type = ProviderOnepasswordAuthSecretRefModule;
      };
    };
  };
  mkProviderOnepasswordAuth = res: {
    "secretRef" = mkProviderOnepasswordAuthSecretRef res."secretRef";
  };
  ProviderOnepasswordAuthSecretRefConnectTokenSecretRefModule = types.submodule {
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
  mkProviderOnepasswordAuthSecretRefConnectTokenSecretRef =
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
  ProviderOnepasswordAuthSecretRefModule = types.submodule {
    options = {
      "connectTokenSecretRef" = mkOption {
        description = "The ConnectToken is used for authentication to a 1Password Connect Server.";
        type = ProviderOnepasswordAuthSecretRefConnectTokenSecretRefModule;
      };
    };
  };
  mkProviderOnepasswordAuthSecretRef = res: {
    "connectTokenSecretRef" =
      mkProviderOnepasswordAuthSecretRefConnectTokenSecretRef
        res."connectTokenSecretRef";
  };
  ProviderOnepasswordModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth defines the information necessary to authenticate against OnePassword Connect Server";
        type = ProviderOnepasswordAuthModule;
      };
      "connectHost" = mkOption {
        description = "ConnectHost defines the OnePassword Connect Server to connect to";
        type = types.str;
      };
      "vaults" = mkOption {
        description = "Vaults defines which OnePassword vaults to search in which order";
        type = (types.attrsOf types.int);
      };
    };
  };
  mkProviderOnepassword = res: {
    "auth" = mkProviderOnepasswordAuth res."auth";
    inherit (res) "connectHost";
    inherit (res) "vaults";
  };
  ProviderOnepasswordSDKAuthModule = types.submodule {
    options = {
      "serviceAccountSecretRef" = mkOption {
        description = "ServiceAccountSecretRef points to the secret containing the token to access 1Password vault.";
        type = ProviderOnepasswordSDKAuthServiceAccountSecretRefModule;
      };
    };
  };
  mkProviderOnepasswordSDKAuth = res: {
    "serviceAccountSecretRef" =
      mkProviderOnepasswordSDKAuthServiceAccountSecretRef
        res."serviceAccountSecretRef";
  };
  ProviderOnepasswordSDKAuthServiceAccountSecretRefModule = types.submodule {
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
  mkProviderOnepasswordSDKAuthServiceAccountSecretRef =
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
  ProviderOnepasswordSDKCacheModule = types.submodule {
    options = {
      "maxSize" = mkOption {
        description = "MaxSize is the maximum number of secrets to cache.\nWhen the cache is full, least-recently-used entries are evicted.";
        type = (types.nullOr types.int);
        default = 100;
      };
      "ttl" = mkOption {
        description = "TTL is the time-to-live for cached secrets.\nFormat: duration string (e.g., \"5m\", \"1h\", \"30s\")";
        type = (types.nullOr types.str);
        default = "5m";
      };
    };
  };
  mkProviderOnepasswordSDKCache =
    res:
    {
    }
    // optionalAttrs (res."maxSize" != null) { inherit (res) "maxSize"; }
    // {
    }
    // optionalAttrs (res."ttl" != null) { inherit (res) "ttl"; }
    // {
    };
  ProviderOnepasswordSDKIntegrationInfoModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name defaults to \"1Password SDK\".";
        type = (types.nullOr types.str);
        default = "1Password SDK";
      };
      "version" = mkOption {
        description = "Version defaults to \"v1.0.0\".";
        type = (types.nullOr types.str);
        default = "v1.0.0";
      };
    };
  };
  mkProviderOnepasswordSDKIntegrationInfo =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."version" != null) { inherit (res) "version"; }
    // {
    };
  ProviderOnepasswordSDKModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth defines the information necessary to authenticate against OnePassword API.";
        type = ProviderOnepasswordSDKAuthModule;
      };
      "cache" = mkOption {
        description = "Cache configures client-side caching for read operations (GetSecret, GetSecretMap).\nWhen enabled, secrets are cached with the specified TTL.\nWrite operations (PushSecret, DeleteSecret) automatically invalidate relevant cache entries.\nIf omitted, caching is disabled (default).\ncache: {} is a valid option to set.";
        type = (types.nullOr ProviderOnepasswordSDKCacheModule);
        default = null;
      };
      "integrationInfo" = mkOption {
        description = "IntegrationInfo specifies the name and version of the integration built using the 1Password Go SDK.\nIf you don't know which name and version to use, use `DefaultIntegrationName` and `DefaultIntegrationVersion`, respectively.";
        type = (types.nullOr ProviderOnepasswordSDKIntegrationInfoModule);
        default = null;
      };
      "vault" = mkOption {
        description = "Vault defines the vault's name or uuid to access. Do NOT add op:// prefix. This will be done automatically.";
        type = types.str;
      };
    };
  };
  mkProviderOnepasswordSDK =
    res:
    {
      "auth" = mkProviderOnepasswordSDKAuth res."auth";
    }
    // optionalAttrs (res."cache" != null) { "cache" = mkProviderOnepasswordSDKCache res."cache"; }
    // {
    }
    // optionalAttrs (res."integrationInfo" != null) {
      "integrationInfo" = mkProviderOnepasswordSDKIntegrationInfo res."integrationInfo";
    }
    // {
      inherit (res) "vault";
    };
  ProviderOracleAuthModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "SecretRef to pass through sensitive information.";
        type = ProviderOracleAuthSecretRefModule;
      };
      "tenancy" = mkOption {
        description = "Tenancy is the tenancy OCID where user is located.";
        type = types.str;
      };
      "user" = mkOption {
        description = "User is an access OCID specific to the account.";
        type = types.str;
      };
    };
  };
  mkProviderOracleAuth = res: {
    "secretRef" = mkProviderOracleAuthSecretRef res."secretRef";
    inherit (res) "tenancy";
    inherit (res) "user";
  };
  ProviderOracleAuthSecretRefFingerprintModule = types.submodule {
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
  mkProviderOracleAuthSecretRefFingerprint =
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
  ProviderOracleAuthSecretRefModule = types.submodule {
    options = {
      "fingerprint" = mkOption {
        description = "Fingerprint is the fingerprint of the API private key.";
        type = ProviderOracleAuthSecretRefFingerprintModule;
      };
      "privatekey" = mkOption {
        description = "PrivateKey is the user's API Signing Key in PEM format, used for authentication.";
        type = ProviderOracleAuthSecretRefPrivatekeyModule;
      };
    };
  };
  mkProviderOracleAuthSecretRef = res: {
    "fingerprint" = mkProviderOracleAuthSecretRefFingerprint res."fingerprint";
    "privatekey" = mkProviderOracleAuthSecretRefPrivatekey res."privatekey";
  };
  ProviderOracleAuthSecretRefPrivatekeyModule = types.submodule {
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
  mkProviderOracleAuthSecretRefPrivatekey =
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
  ProviderOracleModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth configures how secret-manager authenticates with the Oracle Vault.\nIf empty, use the instance principal, otherwise the user credentials specified in Auth.";
        type = (types.nullOr ProviderOracleAuthModule);
        default = null;
      };
      "compartment" = mkOption {
        description = "Compartment is the vault compartment OCID.\nRequired for PushSecret";
        type = (types.nullOr types.str);
        default = null;
      };
      "encryptionKey" = mkOption {
        description = "EncryptionKey is the OCID of the encryption key within the vault.\nRequired for PushSecret";
        type = (types.nullOr types.str);
        default = null;
      };
      "principalType" = mkOption {
        description = "The type of principal to use for authentication. If left blank, the Auth struct will\ndetermine the principal type. This optional field must be specified if using\nworkload identity.";
        type = (
          types.nullOr (
            types.enum [
              ""
              "UserPrincipal"
              "InstancePrincipal"
              "Workload"
            ]
          )
        );
        default = null;
      };
      "region" = mkOption {
        description = "Region is the region where vault is located.";
        type = types.str;
      };
      "serviceAccountRef" = mkOption {
        description = "ServiceAccountRef specified the service account\nthat should be used when authenticating with WorkloadIdentity.";
        type = (types.nullOr ProviderOracleServiceAccountRefModule);
        default = null;
      };
      "vault" = mkOption {
        description = "Vault is the vault's OCID of the specific vault where secret is located.";
        type = types.str;
      };
    };
  };
  mkProviderOracle =
    res:
    {
    }
    // optionalAttrs (res."auth" != null) { "auth" = mkProviderOracleAuth res."auth"; }
    // {
    }
    // optionalAttrs (res."compartment" != null) { inherit (res) "compartment"; }
    // {
    }
    // optionalAttrs (res."encryptionKey" != null) { inherit (res) "encryptionKey"; }
    // {
    }
    // optionalAttrs (res."principalType" != null) { inherit (res) "principalType"; }
    // {
      inherit (res) "region";
    }
    // optionalAttrs (res."serviceAccountRef" != null) {
      "serviceAccountRef" = mkProviderOracleServiceAccountRef res."serviceAccountRef";
    }
    // {
      inherit (res) "vault";
    };
  ProviderOracleServiceAccountRefModule = types.submodule {
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
  mkProviderOracleServiceAccountRef =
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
  ProviderPassboltAuthModule = types.submodule {
    options = {
      "passwordSecretRef" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderPassboltAuthPasswordSecretRefModule;
      };
      "privateKeySecretRef" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderPassboltAuthPrivateKeySecretRefModule;
      };
    };
  };
  mkProviderPassboltAuth = res: {
    "passwordSecretRef" = mkProviderPassboltAuthPasswordSecretRef res."passwordSecretRef";
    "privateKeySecretRef" = mkProviderPassboltAuthPrivateKeySecretRef res."privateKeySecretRef";
  };
  ProviderPassboltAuthPasswordSecretRefModule = types.submodule {
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
  mkProviderPassboltAuthPasswordSecretRef =
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
  ProviderPassboltAuthPrivateKeySecretRefModule = types.submodule {
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
  mkProviderPassboltAuthPrivateKeySecretRef =
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
  ProviderPassboltModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth defines the information necessary to authenticate against Passbolt Server";
        type = ProviderPassboltAuthModule;
      };
      "host" = mkOption {
        description = "Host defines the Passbolt Server to connect to";
        type = types.str;
      };
    };
  };
  mkProviderPassbolt = res: {
    "auth" = mkProviderPassboltAuth res."auth";
    inherit (res) "host";
  };
  ProviderPassworddepotAuthModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "PasswordDepotSecretRef contains the secret reference for Password Depot authentication.";
        type = ProviderPassworddepotAuthSecretRefModule;
      };
    };
  };
  mkProviderPassworddepotAuth = res: {
    "secretRef" = mkProviderPassworddepotAuthSecretRef res."secretRef";
  };
  ProviderPassworddepotAuthSecretRefCredentialsModule = types.submodule {
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
  mkProviderPassworddepotAuthSecretRefCredentials =
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
  ProviderPassworddepotAuthSecretRefModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Username / Password is used for authentication.";
        type = (types.nullOr ProviderPassworddepotAuthSecretRefCredentialsModule);
        default = null;
      };
    };
  };
  mkProviderPassworddepotAuthSecretRef =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkProviderPassworddepotAuthSecretRefCredentials res."credentials";
    }
    // {
    };
  ProviderPassworddepotModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth configures how secret-manager authenticates with a Password Depot instance.";
        type = ProviderPassworddepotAuthModule;
      };
      "database" = mkOption {
        description = "Database to use as source";
        type = types.str;
      };
      "host" = mkOption {
        description = "URL configures the Password Depot instance URL.";
        type = types.str;
      };
    };
  };
  mkProviderPassworddepot = res: {
    "auth" = mkProviderPassworddepotAuth res."auth";
    inherit (res) "database";
    inherit (res) "host";
  };
  ProviderPreviderAuthModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "PreviderAuthSecretRef holds secret references for Previder Vault credentials.";
        type = (types.nullOr ProviderPreviderAuthSecretRefModule);
        default = null;
      };
    };
  };
  mkProviderPreviderAuth =
    res:
    {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderPreviderAuthSecretRef res."secretRef";
    }
    // {
    };
  ProviderPreviderAuthSecretRefAccessTokenModule = types.submodule {
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
  mkProviderPreviderAuthSecretRefAccessToken =
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
  ProviderPreviderAuthSecretRefModule = types.submodule {
    options = {
      "accessToken" = mkOption {
        description = "The AccessToken is used for authentication";
        type = ProviderPreviderAuthSecretRefAccessTokenModule;
      };
    };
  };
  mkProviderPreviderAuthSecretRef = res: {
    "accessToken" = mkProviderPreviderAuthSecretRefAccessToken res."accessToken";
  };
  ProviderPreviderModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "PreviderAuth contains a secretRef for credentials.";
        type = ProviderPreviderAuthModule;
      };
      "baseUri" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderPrevider =
    res:
    {
      "auth" = mkProviderPreviderAuth res."auth";
    }
    // optionalAttrs (res."baseUri" != null) { inherit (res) "baseUri"; }
    // {
    };
  ProviderPulumiAccessTokenModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "SecretRef is a reference to a secret containing the Pulumi API token.";
        type = (types.nullOr ProviderPulumiAccessTokenSecretRefModule);
        default = null;
      };
    };
  };
  mkProviderPulumiAccessToken =
    res:
    {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderPulumiAccessTokenSecretRef res."secretRef";
    }
    // {
    };
  ProviderPulumiAccessTokenSecretRefModule = types.submodule {
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
  mkProviderPulumiAccessTokenSecretRef =
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
  ProviderPulumiModule = types.submodule {
    options = {
      "accessToken" = mkOption {
        description = "AccessToken is the access tokens to sign in to the Pulumi Cloud Console.";
        type = ProviderPulumiAccessTokenModule;
      };
      "apiUrl" = mkOption {
        description = "APIURL is the URL of the Pulumi API.";
        type = (types.nullOr types.str);
        default = "https://api.pulumi.com/api/esc";
      };
      "environment" = mkOption {
        description = "Environment are YAML documents composed of static key-value pairs, programmatic expressions,\ndynamically retrieved values from supported providers including all major clouds,\nand other Pulumi ESC environments.\nTo create a new environment, visit https://www.pulumi.com/docs/esc/environments/ for more information.";
        type = types.str;
      };
      "organization" = mkOption {
        description = "Organization are a space to collaborate on shared projects and stacks.\nTo create a new organization, visit https://app.pulumi.com/ and click \"New Organization\".";
        type = types.str;
      };
      "project" = mkOption {
        description = "Project is the name of the Pulumi ESC project the environment belongs to.";
        type = types.str;
      };
    };
  };
  mkProviderPulumi =
    res:
    {
      "accessToken" = mkProviderPulumiAccessToken res."accessToken";
    }
    // optionalAttrs (res."apiUrl" != null) { inherit (res) "apiUrl"; }
    // {
      inherit (res) "environment";
      inherit (res) "organization";
      inherit (res) "project";
    };
  ProviderScalewayAccessKeyModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "SecretRef references a key in a secret that will be used as value.";
        type = (types.nullOr ProviderScalewayAccessKeySecretRefModule);
        default = null;
      };
      "value" = mkOption {
        description = "Value can be specified directly to set a value without using a secret.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderScalewayAccessKey =
    res:
    {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderScalewayAccessKeySecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  ProviderScalewayAccessKeySecretRefModule = types.submodule {
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
  mkProviderScalewayAccessKeySecretRef =
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
  ProviderScalewayModule = types.submodule {
    options = {
      "accessKey" = mkOption {
        description = "AccessKey is the non-secret part of the api key.";
        type = ProviderScalewayAccessKeyModule;
      };
      "apiUrl" = mkOption {
        description = "APIURL is the url of the api to use. Defaults to https://api.scaleway.com";
        type = (types.nullOr types.str);
        default = null;
      };
      "projectId" = mkOption {
        description = "ProjectID is the id of your project, which you can find in the console: https://console.scaleway.com/project/settings";
        type = types.str;
      };
      "region" = mkOption {
        description = "Region where your secrets are located: https://developers.scaleway.com/en/quickstart/#region-and-zone";
        type = types.str;
      };
      "secretKey" = mkOption {
        description = "SecretKey is the non-secret part of the api key.";
        type = ProviderScalewaySecretKeyModule;
      };
    };
  };
  mkProviderScaleway =
    res:
    {
      "accessKey" = mkProviderScalewayAccessKey res."accessKey";
    }
    // optionalAttrs (res."apiUrl" != null) { inherit (res) "apiUrl"; }
    // {
      inherit (res) "projectId";
      inherit (res) "region";
      "secretKey" = mkProviderScalewaySecretKey res."secretKey";
    };
  ProviderScalewaySecretKeyModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "SecretRef references a key in a secret that will be used as value.";
        type = (types.nullOr ProviderScalewaySecretKeySecretRefModule);
        default = null;
      };
      "value" = mkOption {
        description = "Value can be specified directly to set a value without using a secret.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderScalewaySecretKey =
    res:
    {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderScalewaySecretKeySecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  ProviderScalewaySecretKeySecretRefModule = types.submodule {
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
  mkProviderScalewaySecretKeySecretRef =
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
  ProviderSecretserverCaProviderModule = types.submodule {
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
  mkProviderSecretserverCaProvider =
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
  ProviderSecretserverModule = types.submodule {
    options = {
      "caBundle" = mkOption {
        description = "PEM/base64 encoded CA bundle used to validate Secret ServerURL. Only used\nif the ServerURL URL is using HTTPS protocol. If not set the system root certificates\nare used to validate the TLS connection.";
        type = (types.nullOr types.str);
        default = null;
      };
      "caProvider" = mkOption {
        description = "The provider for the CA bundle to use to validate Secret ServerURL certificate.";
        type = (types.nullOr ProviderSecretserverCaProviderModule);
        default = null;
      };
      "domain" = mkOption {
        description = "Domain is the secret server domain.";
        type = (types.nullOr types.str);
        default = null;
      };
      "password" = mkOption {
        description = "Password is the secret server account password.";
        type = ProviderSecretserverPasswordModule;
      };
      "serverURL" = mkOption {
        description = "ServerURL\nURL to your secret server installation";
        type = types.str;
      };
      "username" = mkOption {
        description = "Username is the secret server account username.";
        type = ProviderSecretserverUsernameModule;
      };
    };
  };
  mkProviderSecretserver =
    res:
    {
    }
    // optionalAttrs (res."caBundle" != null) { inherit (res) "caBundle"; }
    // {
    }
    // optionalAttrs (res."caProvider" != null) {
      "caProvider" = mkProviderSecretserverCaProvider res."caProvider";
    }
    // {
    }
    // optionalAttrs (res."domain" != null) { inherit (res) "domain"; }
    // {
      "password" = mkProviderSecretserverPassword res."password";
      inherit (res) "serverURL";
      "username" = mkProviderSecretserverUsername res."username";
    };
  ProviderSecretserverPasswordModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "SecretRef references a key in a secret that will be used as value.";
        type = (types.nullOr ProviderSecretserverPasswordSecretRefModule);
        default = null;
      };
      "value" = mkOption {
        description = "Value can be specified directly to set a value without using a secret.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderSecretserverPassword =
    res:
    {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderSecretserverPasswordSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  ProviderSecretserverPasswordSecretRefModule = types.submodule {
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
  mkProviderSecretserverPasswordSecretRef =
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
  ProviderSecretserverUsernameModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "SecretRef references a key in a secret that will be used as value.";
        type = (types.nullOr ProviderSecretserverUsernameSecretRefModule);
        default = null;
      };
      "value" = mkOption {
        description = "Value can be specified directly to set a value without using a secret.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderSecretserverUsername =
    res:
    {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderSecretserverUsernameSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  ProviderSecretserverUsernameSecretRefModule = types.submodule {
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
  mkProviderSecretserverUsernameSecretRef =
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
  ProviderSenhaseguraAuthClientSecretSecretRefModule = types.submodule {
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
  mkProviderSenhaseguraAuthClientSecretSecretRef =
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
  ProviderSenhaseguraAuthModule = types.submodule {
    options = {
      "clientId" = mkOption {
        type = types.str;
      };
      "clientSecretSecretRef" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderSenhaseguraAuthClientSecretSecretRefModule;
      };
    };
  };
  mkProviderSenhaseguraAuth = res: {
    inherit (res) "clientId";
    "clientSecretSecretRef" =
      mkProviderSenhaseguraAuthClientSecretSecretRef
        res."clientSecretSecretRef";
  };
  ProviderSenhaseguraModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth defines parameters to authenticate in senhasegura";
        type = ProviderSenhaseguraAuthModule;
      };
      "ignoreSslCertificate" = mkOption {
        description = "IgnoreSslCertificate defines if SSL certificate must be ignored";
        type = types.bool;
        default = false;
      };
      "module" = mkOption {
        description = "Module defines which senhasegura module should be used to get secrets";
        type = types.str;
      };
      "url" = mkOption {
        description = "URL of senhasegura";
        type = types.str;
      };
    };
  };
  mkProviderSenhasegura =
    res:
    {
      "auth" = mkProviderSenhaseguraAuth res."auth";
    }
    // optionalAttrs res."ignoreSslCertificate" { inherit (res) "ignoreSslCertificate"; }
    // {
      inherit (res) "module";
      inherit (res) "url";
    };
  ProviderVaultAuthAppRoleModule = types.submodule {
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
        type = (types.nullOr ProviderVaultAuthAppRoleRoleRefModule);
        default = null;
      };
      "secretRef" = mkOption {
        description = "Reference to a key in a Secret that contains the App Role secret used\nto authenticate with Vault.\nThe `key` field must be specified and denotes which entry within the Secret\nresource is used as the app role secret.";
        type = ProviderVaultAuthAppRoleSecretRefModule;
      };
    };
  };
  mkProviderVaultAuthAppRole =
    res:
    {
      inherit (res) "path";
    }
    // optionalAttrs (res."roleId" != null) { inherit (res) "roleId"; }
    // {
    }
    // optionalAttrs (res."roleRef" != null) {
      "roleRef" = mkProviderVaultAuthAppRoleRoleRef res."roleRef";
    }
    // {
      "secretRef" = mkProviderVaultAuthAppRoleSecretRef res."secretRef";
    };
  ProviderVaultAuthAppRoleRoleRefModule = types.submodule {
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
  mkProviderVaultAuthAppRoleRoleRef =
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
  ProviderVaultAuthAppRoleSecretRefModule = types.submodule {
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
  mkProviderVaultAuthAppRoleSecretRef =
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
  ProviderVaultAuthCertClientCertModule = types.submodule {
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
  mkProviderVaultAuthCertClientCert =
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
  ProviderVaultAuthCertModule = types.submodule {
    options = {
      "clientCert" = mkOption {
        description = "ClientCert is a certificate to authenticate using the Cert Vault\nauthentication method";
        type = (types.nullOr ProviderVaultAuthCertClientCertModule);
        default = null;
      };
      "path" = mkOption {
        description = "Path where the Certificate authentication backend is mounted\nin Vault, e.g: \"cert\"";
        type = (types.nullOr types.str);
        default = "cert";
      };
      "secretRef" = mkOption {
        description = "SecretRef to a key in a Secret resource containing client private key to\nauthenticate with Vault using the Cert authentication method";
        type = (types.nullOr ProviderVaultAuthCertSecretRefModule);
        default = null;
      };
    };
  };
  mkProviderVaultAuthCert =
    res:
    {
    }
    // optionalAttrs (res."clientCert" != null) {
      "clientCert" = mkProviderVaultAuthCertClientCert res."clientCert";
    }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderVaultAuthCertSecretRef res."secretRef";
    }
    // {
    };
  ProviderVaultAuthCertSecretRefModule = types.submodule {
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
  mkProviderVaultAuthCertSecretRef =
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
  ProviderVaultAuthGcpModule = types.submodule {
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
        type = (types.nullOr ProviderVaultAuthGcpSecretRefModule);
        default = null;
      };
      "serviceAccountRef" = mkOption {
        description = "ServiceAccountRef to a service account for impersonation";
        type = (types.nullOr ProviderVaultAuthGcpServiceAccountRefModule);
        default = null;
      };
      "workloadIdentity" = mkOption {
        description = "Specify a service account with Workload Identity";
        type = (types.nullOr ProviderVaultAuthGcpWorkloadIdentityModule);
        default = null;
      };
    };
  };
  mkProviderVaultAuthGcp =
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
      "secretRef" = mkProviderVaultAuthGcpSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."serviceAccountRef" != null) {
      "serviceAccountRef" = mkProviderVaultAuthGcpServiceAccountRef res."serviceAccountRef";
    }
    // {
    }
    // optionalAttrs (res."workloadIdentity" != null) {
      "workloadIdentity" = mkProviderVaultAuthGcpWorkloadIdentity res."workloadIdentity";
    }
    // {
    };
  ProviderVaultAuthGcpSecretRefModule = types.submodule {
    options = {
      "secretAccessKeySecretRef" = mkOption {
        description = "The SecretAccessKey is used for authentication";
        type = (types.nullOr ProviderVaultAuthGcpSecretRefSecretAccessKeySecretRefModule);
        default = null;
      };
    };
  };
  mkProviderVaultAuthGcpSecretRef =
    res:
    {
    }
    // optionalAttrs (res."secretAccessKeySecretRef" != null) {
      "secretAccessKeySecretRef" =
        mkProviderVaultAuthGcpSecretRefSecretAccessKeySecretRef
          res."secretAccessKeySecretRef";
    }
    // {
    };
  ProviderVaultAuthGcpSecretRefSecretAccessKeySecretRefModule = types.submodule {
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
  mkProviderVaultAuthGcpSecretRefSecretAccessKeySecretRef =
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
  ProviderVaultAuthGcpServiceAccountRefModule = types.submodule {
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
  mkProviderVaultAuthGcpServiceAccountRef =
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
  ProviderVaultAuthGcpWorkloadIdentityModule = types.submodule {
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
        type = ProviderVaultAuthGcpWorkloadIdentityServiceAccountRefModule;
      };
    };
  };
  mkProviderVaultAuthGcpWorkloadIdentity =
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
        mkProviderVaultAuthGcpWorkloadIdentityServiceAccountRef
          res."serviceAccountRef";
    };
  ProviderVaultAuthGcpWorkloadIdentityServiceAccountRefModule = types.submodule {
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
  mkProviderVaultAuthGcpWorkloadIdentityServiceAccountRef =
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
  ProviderVaultAuthIamJwtModule = types.submodule {
    options = {
      "serviceAccountRef" = mkOption {
        description = "ServiceAccountSelector is a reference to a ServiceAccount resource.";
        type = (types.nullOr ProviderVaultAuthIamJwtServiceAccountRefModule);
        default = null;
      };
    };
  };
  mkProviderVaultAuthIamJwt =
    res:
    {
    }
    // optionalAttrs (res."serviceAccountRef" != null) {
      "serviceAccountRef" = mkProviderVaultAuthIamJwtServiceAccountRef res."serviceAccountRef";
    }
    // {
    };
  ProviderVaultAuthIamJwtServiceAccountRefModule = types.submodule {
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
  mkProviderVaultAuthIamJwtServiceAccountRef =
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
  ProviderVaultAuthIamModule = types.submodule {
    options = {
      "externalID" = mkOption {
        description = "AWS External ID set on assumed IAM roles";
        type = (types.nullOr types.str);
        default = null;
      };
      "jwt" = mkOption {
        description = "Specify a service account with IRSA enabled";
        type = (types.nullOr ProviderVaultAuthIamJwtModule);
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
        type = (types.nullOr ProviderVaultAuthIamSecretRefModule);
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
  mkProviderVaultAuthIam =
    res:
    {
    }
    // optionalAttrs (res."externalID" != null) { inherit (res) "externalID"; }
    // {
    }
    // optionalAttrs (res."jwt" != null) { "jwt" = mkProviderVaultAuthIamJwt res."jwt"; }
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
      "secretRef" = mkProviderVaultAuthIamSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."vaultAwsIamServerID" != null) { inherit (res) "vaultAwsIamServerID"; }
    // {
      inherit (res) "vaultRole";
    };
  ProviderVaultAuthIamSecretRefAccessKeyIDSecretRefModule = types.submodule {
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
  mkProviderVaultAuthIamSecretRefAccessKeyIDSecretRef =
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
  ProviderVaultAuthIamSecretRefModule = types.submodule {
    options = {
      "accessKeyIDSecretRef" = mkOption {
        description = "The AccessKeyID is used for authentication";
        type = (types.nullOr ProviderVaultAuthIamSecretRefAccessKeyIDSecretRefModule);
        default = null;
      };
      "secretAccessKeySecretRef" = mkOption {
        description = "The SecretAccessKey is used for authentication";
        type = (types.nullOr ProviderVaultAuthIamSecretRefSecretAccessKeySecretRefModule);
        default = null;
      };
      "sessionTokenSecretRef" = mkOption {
        description = "The SessionToken used for authentication\nThis must be defined if AccessKeyID and SecretAccessKey are temporary credentials\nsee: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_use-resources.html";
        type = (types.nullOr ProviderVaultAuthIamSecretRefSessionTokenSecretRefModule);
        default = null;
      };
    };
  };
  mkProviderVaultAuthIamSecretRef =
    res:
    {
    }
    // optionalAttrs (res."accessKeyIDSecretRef" != null) {
      "accessKeyIDSecretRef" =
        mkProviderVaultAuthIamSecretRefAccessKeyIDSecretRef
          res."accessKeyIDSecretRef";
    }
    // {
    }
    // optionalAttrs (res."secretAccessKeySecretRef" != null) {
      "secretAccessKeySecretRef" =
        mkProviderVaultAuthIamSecretRefSecretAccessKeySecretRef
          res."secretAccessKeySecretRef";
    }
    // {
    }
    // optionalAttrs (res."sessionTokenSecretRef" != null) {
      "sessionTokenSecretRef" =
        mkProviderVaultAuthIamSecretRefSessionTokenSecretRef
          res."sessionTokenSecretRef";
    }
    // {
    };
  ProviderVaultAuthIamSecretRefSecretAccessKeySecretRefModule = types.submodule {
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
  mkProviderVaultAuthIamSecretRefSecretAccessKeySecretRef =
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
  ProviderVaultAuthIamSecretRefSessionTokenSecretRefModule = types.submodule {
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
  mkProviderVaultAuthIamSecretRefSessionTokenSecretRef =
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
  ProviderVaultAuthJwtKubernetesServiceAccountTokenModule = types.submodule {
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
        type = ProviderVaultAuthJwtKubernetesServiceAccountTokenServiceAccountRefModule;
      };
    };
  };
  mkProviderVaultAuthJwtKubernetesServiceAccountToken =
    res:
    {
    }
    // optionalAttrs (res."audiences" != [ ]) { inherit (res) "audiences"; }
    // {
    }
    // optionalAttrs (res."expirationSeconds" != null) { inherit (res) "expirationSeconds"; }
    // {
      "serviceAccountRef" =
        mkProviderVaultAuthJwtKubernetesServiceAccountTokenServiceAccountRef
          res."serviceAccountRef";
    };
  ProviderVaultAuthJwtKubernetesServiceAccountTokenServiceAccountRefModule = types.submodule {
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
  mkProviderVaultAuthJwtKubernetesServiceAccountTokenServiceAccountRef =
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
  ProviderVaultAuthJwtModule = types.submodule {
    options = {
      "kubernetesServiceAccountToken" = mkOption {
        description = "Optional ServiceAccountToken specifies the Kubernetes service account for which to request\na token for with the `TokenRequest` API.";
        type = (types.nullOr ProviderVaultAuthJwtKubernetesServiceAccountTokenModule);
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
        type = (types.nullOr ProviderVaultAuthJwtSecretRefModule);
        default = null;
      };
    };
  };
  mkProviderVaultAuthJwt =
    res:
    {
    }
    // optionalAttrs (res."kubernetesServiceAccountToken" != null) {
      "kubernetesServiceAccountToken" =
        mkProviderVaultAuthJwtKubernetesServiceAccountToken
          res."kubernetesServiceAccountToken";
    }
    // {
      inherit (res) "path";
    }
    // optionalAttrs (res."role" != null) { inherit (res) "role"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderVaultAuthJwtSecretRef res."secretRef";
    }
    // {
    };
  ProviderVaultAuthJwtSecretRefModule = types.submodule {
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
  mkProviderVaultAuthJwtSecretRef =
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
  ProviderVaultAuthKubernetesModule = types.submodule {
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
        type = (types.nullOr ProviderVaultAuthKubernetesSecretRefModule);
        default = null;
      };
      "serviceAccountRef" = mkOption {
        description = "Optional service account field containing the name of a kubernetes ServiceAccount.\nIf the service account is specified, the service account secret token JWT will be used\nfor authenticating with Vault. If the service account selector is not supplied,\nthe secretRef will be used instead.";
        type = (types.nullOr ProviderVaultAuthKubernetesServiceAccountRefModule);
        default = null;
      };
    };
  };
  mkProviderVaultAuthKubernetes =
    res:
    {
      inherit (res) "mountPath";
      inherit (res) "role";
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderVaultAuthKubernetesSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."serviceAccountRef" != null) {
      "serviceAccountRef" = mkProviderVaultAuthKubernetesServiceAccountRef res."serviceAccountRef";
    }
    // {
    };
  ProviderVaultAuthKubernetesSecretRefModule = types.submodule {
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
  mkProviderVaultAuthKubernetesSecretRef =
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
  ProviderVaultAuthKubernetesServiceAccountRefModule = types.submodule {
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
  mkProviderVaultAuthKubernetesServiceAccountRef =
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
  ProviderVaultAuthLdapModule = types.submodule {
    options = {
      "path" = mkOption {
        description = "Path where the LDAP authentication backend is mounted\nin Vault, e.g: \"ldap\"";
        type = types.str;
      };
      "secretRef" = mkOption {
        description = "SecretRef to a key in a Secret resource containing password for the LDAP\nuser used to authenticate with Vault using the LDAP authentication\nmethod";
        type = (types.nullOr ProviderVaultAuthLdapSecretRefModule);
        default = null;
      };
      "username" = mkOption {
        description = "Username is an LDAP username used to authenticate using the LDAP Vault\nauthentication method";
        type = types.str;
      };
    };
  };
  mkProviderVaultAuthLdap =
    res:
    {
      inherit (res) "path";
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderVaultAuthLdapSecretRef res."secretRef";
    }
    // {
      inherit (res) "username";
    };
  ProviderVaultAuthLdapSecretRefModule = types.submodule {
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
  mkProviderVaultAuthLdapSecretRef =
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
  ProviderVaultAuthModule = types.submodule {
    options = {
      "appRole" = mkOption {
        description = "AppRole authenticates with Vault using the App Role auth mechanism,\nwith the role and secret stored in a Kubernetes Secret resource.";
        type = (types.nullOr ProviderVaultAuthAppRoleModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Cert authenticates with TLS Certificates by passing client certificate, private key and ca certificate\nCert authentication method";
        type = (types.nullOr ProviderVaultAuthCertModule);
        default = null;
      };
      "gcp" = mkOption {
        description = "Gcp authenticates with Vault using Google Cloud Platform authentication method\nGCP authentication method";
        type = (types.nullOr ProviderVaultAuthGcpModule);
        default = null;
      };
      "iam" = mkOption {
        description = "Iam authenticates with vault by passing a special AWS request signed with AWS IAM credentials\nAWS IAM authentication method";
        type = (types.nullOr ProviderVaultAuthIamModule);
        default = null;
      };
      "jwt" = mkOption {
        description = "Jwt authenticates with Vault by passing role and JWT token using the\nJWT/OIDC authentication method";
        type = (types.nullOr ProviderVaultAuthJwtModule);
        default = null;
      };
      "kubernetes" = mkOption {
        description = "Kubernetes authenticates with Vault by passing the ServiceAccount\ntoken stored in the named Secret resource to the Vault server.";
        type = (types.nullOr ProviderVaultAuthKubernetesModule);
        default = null;
      };
      "ldap" = mkOption {
        description = "Ldap authenticates with Vault by passing username/password pair using\nthe LDAP authentication method";
        type = (types.nullOr ProviderVaultAuthLdapModule);
        default = null;
      };
      "namespace" = mkOption {
        description = "Name of the vault namespace to authenticate to. This can be different than the namespace your secret is in.\nNamespaces is a set of features within Vault Enterprise that allows\nVault environments to support Secure Multi-tenancy. e.g: \"ns1\".\nMore about namespaces can be found here https://www.vaultproject.io/docs/enterprise/namespaces\nThis will default to Vault.Namespace field if set, or empty otherwise";
        type = (types.nullOr types.str);
        default = null;
      };
      "tokenSecretRef" = mkOption {
        description = "TokenSecretRef authenticates with Vault by presenting a token.";
        type = (types.nullOr ProviderVaultAuthTokenSecretRefModule);
        default = null;
      };
      "userPass" = mkOption {
        description = "UserPass authenticates with Vault by passing username/password pair";
        type = (types.nullOr ProviderVaultAuthUserPassModule);
        default = null;
      };
    };
  };
  mkProviderVaultAuth =
    res:
    {
    }
    // optionalAttrs (res."appRole" != null) { "appRole" = mkProviderVaultAuthAppRole res."appRole"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkProviderVaultAuthCert res."cert"; }
    // {
    }
    // optionalAttrs (res."gcp" != null) { "gcp" = mkProviderVaultAuthGcp res."gcp"; }
    // {
    }
    // optionalAttrs (res."iam" != null) { "iam" = mkProviderVaultAuthIam res."iam"; }
    // {
    }
    // optionalAttrs (res."jwt" != null) { "jwt" = mkProviderVaultAuthJwt res."jwt"; }
    // {
    }
    // optionalAttrs (res."kubernetes" != null) {
      "kubernetes" = mkProviderVaultAuthKubernetes res."kubernetes";
    }
    // {
    }
    // optionalAttrs (res."ldap" != null) { "ldap" = mkProviderVaultAuthLdap res."ldap"; }
    // {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    }
    // optionalAttrs (res."tokenSecretRef" != null) {
      "tokenSecretRef" = mkProviderVaultAuthTokenSecretRef res."tokenSecretRef";
    }
    // {
    }
    // optionalAttrs (res."userPass" != null) {
      "userPass" = mkProviderVaultAuthUserPass res."userPass";
    }
    // {
    };
  ProviderVaultAuthTokenSecretRefModule = types.submodule {
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
  mkProviderVaultAuthTokenSecretRef =
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
  ProviderVaultAuthUserPassModule = types.submodule {
    options = {
      "path" = mkOption {
        description = "Path where the UserPassword authentication backend is mounted\nin Vault, e.g: \"userpass\"";
        type = types.str;
      };
      "secretRef" = mkOption {
        description = "SecretRef to a key in a Secret resource containing password for the\nuser used to authenticate with Vault using the UserPass authentication\nmethod";
        type = (types.nullOr ProviderVaultAuthUserPassSecretRefModule);
        default = null;
      };
      "username" = mkOption {
        description = "Username is a username used to authenticate using the UserPass Vault\nauthentication method";
        type = types.str;
      };
    };
  };
  mkProviderVaultAuthUserPass =
    res:
    {
      inherit (res) "path";
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderVaultAuthUserPassSecretRef res."secretRef";
    }
    // {
      inherit (res) "username";
    };
  ProviderVaultAuthUserPassSecretRefModule = types.submodule {
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
  mkProviderVaultAuthUserPassSecretRef =
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
  ProviderVaultCaProviderModule = types.submodule {
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
  mkProviderVaultCaProvider =
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
  ProviderVaultCheckAndSetModule = types.submodule {
    options = {
      "required" = mkOption {
        description = "Required when true, all write operations must include a check-and-set parameter.\nThis helps prevent unintentional overwrites of secrets.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProviderVaultCheckAndSet =
    res:
    {
    }
    // optionalAttrs res."required" { inherit (res) "required"; }
    // {
    };
  ProviderVaultModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth configures how secret-manager authenticates with the Vault server.";
        type = (types.nullOr ProviderVaultAuthModule);
        default = null;
      };
      "caBundle" = mkOption {
        description = "PEM encoded CA bundle used to validate Vault server certificate. Only used\nif the Server URL is using HTTPS protocol. This parameter is ignored for\nplain HTTP protocol connection. If not set the system root certificates\nare used to validate the TLS connection.";
        type = (types.nullOr types.str);
        default = null;
      };
      "caProvider" = mkOption {
        description = "The provider for the CA bundle to use to validate Vault server certificate.";
        type = (types.nullOr ProviderVaultCaProviderModule);
        default = null;
      };
      "checkAndSet" = mkOption {
        description = "CheckAndSet defines the Check-And-Set (CAS) settings for PushSecret operations.\nOnly applies to Vault KV v2 stores. When enabled, write operations must include\nthe current version of the secret to prevent unintentional overwrites.";
        type = (types.nullOr ProviderVaultCheckAndSetModule);
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
        type = (types.nullOr ProviderVaultTlsModule);
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
  mkProviderVault =
    res:
    {
    }
    // optionalAttrs (res."auth" != null) { "auth" = mkProviderVaultAuth res."auth"; }
    // {
    }
    // optionalAttrs (res."caBundle" != null) { inherit (res) "caBundle"; }
    // {
    }
    // optionalAttrs (res."caProvider" != null) {
      "caProvider" = mkProviderVaultCaProvider res."caProvider";
    }
    // {
    }
    // optionalAttrs (res."checkAndSet" != null) {
      "checkAndSet" = mkProviderVaultCheckAndSet res."checkAndSet";
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
    // optionalAttrs (res."tls" != null) { "tls" = mkProviderVaultTls res."tls"; }
    // {
    }
    // optionalAttrs (res."version" != null) { inherit (res) "version"; }
    // {
    };
  ProviderVaultTlsCertSecretRefModule = types.submodule {
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
  mkProviderVaultTlsCertSecretRef =
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
  ProviderVaultTlsKeySecretRefModule = types.submodule {
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
  mkProviderVaultTlsKeySecretRef =
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
  ProviderVaultTlsModule = types.submodule {
    options = {
      "certSecretRef" = mkOption {
        description = "CertSecretRef is a certificate added to the transport layer\nwhen communicating with the Vault server.\nIf no key for the Secret is specified, external-secret will default to 'tls.crt'.";
        type = (types.nullOr ProviderVaultTlsCertSecretRefModule);
        default = null;
      };
      "keySecretRef" = mkOption {
        description = "KeySecretRef to a key in a Secret resource containing client private key\nadded to the transport layer when communicating with the Vault server.\nIf no key for the Secret is specified, external-secret will default to 'tls.key'.";
        type = (types.nullOr ProviderVaultTlsKeySecretRefModule);
        default = null;
      };
    };
  };
  mkProviderVaultTls =
    res:
    {
    }
    // optionalAttrs (res."certSecretRef" != null) {
      "certSecretRef" = mkProviderVaultTlsCertSecretRef res."certSecretRef";
    }
    // {
    }
    // optionalAttrs (res."keySecretRef" != null) {
      "keySecretRef" = mkProviderVaultTlsKeySecretRef res."keySecretRef";
    }
    // {
    };
  ProviderVolcengineAuthModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "SecretRef defines the static credentials to use for authentication.\nIf not set, IRSA is used.";
        type = (types.nullOr ProviderVolcengineAuthSecretRefModule);
        default = null;
      };
    };
  };
  mkProviderVolcengineAuth =
    res:
    {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderVolcengineAuthSecretRef res."secretRef";
    }
    // {
    };
  ProviderVolcengineAuthSecretRefAccessKeyIDModule = types.submodule {
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
  mkProviderVolcengineAuthSecretRefAccessKeyID =
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
  ProviderVolcengineAuthSecretRefModule = types.submodule {
    options = {
      "accessKeyID" = mkOption {
        description = "AccessKeyID is the reference to the secret containing the Access Key ID.";
        type = ProviderVolcengineAuthSecretRefAccessKeyIDModule;
      };
      "secretAccessKey" = mkOption {
        description = "SecretAccessKey is the reference to the secret containing the Secret Access Key.";
        type = ProviderVolcengineAuthSecretRefSecretAccessKeyModule;
      };
      "token" = mkOption {
        description = "Token is the reference to the secret containing the STS(Security Token Service) Token.";
        type = (types.nullOr ProviderVolcengineAuthSecretRefTokenModule);
        default = null;
      };
    };
  };
  mkProviderVolcengineAuthSecretRef =
    res:
    {
      "accessKeyID" = mkProviderVolcengineAuthSecretRefAccessKeyID res."accessKeyID";
      "secretAccessKey" = mkProviderVolcengineAuthSecretRefSecretAccessKey res."secretAccessKey";
    }
    // optionalAttrs (res."token" != null) {
      "token" = mkProviderVolcengineAuthSecretRefToken res."token";
    }
    // {
    };
  ProviderVolcengineAuthSecretRefSecretAccessKeyModule = types.submodule {
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
  mkProviderVolcengineAuthSecretRefSecretAccessKey =
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
  ProviderVolcengineAuthSecretRefTokenModule = types.submodule {
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
  mkProviderVolcengineAuthSecretRefToken =
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
  ProviderVolcengineModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth defines the authentication method to use.\nIf not specified, the provider will try to use IRSA (IAM Role for Service Account).";
        type = (types.nullOr ProviderVolcengineAuthModule);
        default = null;
      };
      "region" = mkOption {
        description = "Region specifies the Volcengine region to connect to.";
        type = types.str;
      };
    };
  };
  mkProviderVolcengine =
    res:
    {
    }
    // optionalAttrs (res."auth" != null) { "auth" = mkProviderVolcengineAuth res."auth"; }
    // {
      inherit (res) "region";
    };
  ProviderWebhookAuthModule = types.submodule {
    options = {
      "ntlm" = mkOption {
        description = "NTLMProtocol configures the store to use NTLM for auth";
        type = (types.nullOr ProviderWebhookAuthNtlmModule);
        default = null;
      };
    };
  };
  mkProviderWebhookAuth =
    res:
    {
    }
    // optionalAttrs (res."ntlm" != null) { "ntlm" = mkProviderWebhookAuthNtlm res."ntlm"; }
    // {
    };
  ProviderWebhookAuthNtlmModule = types.submodule {
    options = {
      "passwordSecret" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderWebhookAuthNtlmPasswordSecretModule;
      };
      "usernameSecret" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = ProviderWebhookAuthNtlmUsernameSecretModule;
      };
    };
  };
  mkProviderWebhookAuthNtlm = res: {
    "passwordSecret" = mkProviderWebhookAuthNtlmPasswordSecret res."passwordSecret";
    "usernameSecret" = mkProviderWebhookAuthNtlmUsernameSecret res."usernameSecret";
  };
  ProviderWebhookAuthNtlmPasswordSecretModule = types.submodule {
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
  mkProviderWebhookAuthNtlmPasswordSecret =
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
  ProviderWebhookAuthNtlmUsernameSecretModule = types.submodule {
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
  mkProviderWebhookAuthNtlmUsernameSecret =
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
  ProviderWebhookCaProviderModule = types.submodule {
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
  mkProviderWebhookCaProvider =
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
  ProviderWebhookModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth specifies a authorization protocol. Only one protocol may be set.";
        type = (types.nullOr ProviderWebhookAuthModule);
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
        type = (types.nullOr ProviderWebhookCaProviderModule);
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
        type = (types.nullOr ProviderWebhookResultModule);
        default = null;
      };
      "secrets" = mkOption {
        description = "Secrets to fill in templates\nThese secrets will be passed to the templating function as key value pairs under the given name";
        type = (types.listOf ProviderWebhookSecretModule);
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
  mkProviderWebhook =
    res:
    {
    }
    // optionalAttrs (res."auth" != null) { "auth" = mkProviderWebhookAuth res."auth"; }
    // {
    }
    // optionalAttrs (res."body" != null) { inherit (res) "body"; }
    // {
    }
    // optionalAttrs (res."caBundle" != null) { inherit (res) "caBundle"; }
    // {
    }
    // optionalAttrs (res."caProvider" != null) {
      "caProvider" = mkProviderWebhookCaProvider res."caProvider";
    }
    // {
    }
    // optionalAttrs (res."headers" != { }) { inherit (res) "headers"; }
    // {
    }
    // optionalAttrs (res."method" != null) { inherit (res) "method"; }
    // {
    }
    // optionalAttrs (res."result" != null) { "result" = mkProviderWebhookResult res."result"; }
    // {
    }
    // optionalAttrs (res."secrets" != [ ]) { "secrets" = map mkProviderWebhookSecret res."secrets"; }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
      inherit (res) "url";
    };
  ProviderWebhookResultModule = types.submodule {
    options = {
      "jsonPath" = mkOption {
        description = "Json path of return value";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderWebhookResult =
    res:
    {
    }
    // optionalAttrs (res."jsonPath" != null) { inherit (res) "jsonPath"; }
    // {
    };
  ProviderWebhookSecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of this secret in templates";
        type = types.str;
      };
      "secretRef" = mkOption {
        description = "Secret ref to fill in credentials";
        type = ProviderWebhookSecretSecretRefModule;
      };
    };
  };
  mkProviderWebhookSecret = res: {
    inherit (res) "name";
    "secretRef" = mkProviderWebhookSecretSecretRef res."secretRef";
  };
  ProviderWebhookSecretSecretRefModule = types.submodule {
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
  mkProviderWebhookSecretSecretRef =
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
  ProviderYandexcertificatemanagerAuthAuthorizedKeySecretRefModule = types.submodule {
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
  mkProviderYandexcertificatemanagerAuthAuthorizedKeySecretRef =
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
  ProviderYandexcertificatemanagerAuthModule = types.submodule {
    options = {
      "authorizedKeySecretRef" = mkOption {
        description = "The authorized key used for authentication";
        type = (types.nullOr ProviderYandexcertificatemanagerAuthAuthorizedKeySecretRefModule);
        default = null;
      };
    };
  };
  mkProviderYandexcertificatemanagerAuth =
    res:
    {
    }
    // optionalAttrs (res."authorizedKeySecretRef" != null) {
      "authorizedKeySecretRef" =
        mkProviderYandexcertificatemanagerAuthAuthorizedKeySecretRef
          res."authorizedKeySecretRef";
    }
    // {
    };
  ProviderYandexcertificatemanagerCaProviderCertSecretRefModule = types.submodule {
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
  mkProviderYandexcertificatemanagerCaProviderCertSecretRef =
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
  ProviderYandexcertificatemanagerCaProviderModule = types.submodule {
    options = {
      "certSecretRef" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = (types.nullOr ProviderYandexcertificatemanagerCaProviderCertSecretRefModule);
        default = null;
      };
    };
  };
  mkProviderYandexcertificatemanagerCaProvider =
    res:
    {
    }
    // optionalAttrs (res."certSecretRef" != null) {
      "certSecretRef" = mkProviderYandexcertificatemanagerCaProviderCertSecretRef res."certSecretRef";
    }
    // {
    };
  ProviderYandexcertificatemanagerFetchingByNameModule = types.submodule {
    options = {
      "folderID" = mkOption {
        description = "The folder to fetch secrets from";
        type = types.str;
      };
    };
  };
  mkProviderYandexcertificatemanagerFetchingByName = res: {
    inherit (res) "folderID";
  };
  ProviderYandexcertificatemanagerFetchingModule = types.submodule {
    options = {
      "byID" = mkOption {
        description = "ByID configures the provider to interpret the `data.secretKey.remoteRef.key` field in ExternalSecret as secret ID.";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "byName" = mkOption {
        description = "ByName configures the provider to interpret the `data.secretKey.remoteRef.key` field in ExternalSecret as secret name.";
        type = (types.nullOr ProviderYandexcertificatemanagerFetchingByNameModule);
        default = null;
      };
    };
  };
  mkProviderYandexcertificatemanagerFetching =
    res:
    {
    }
    // optionalAttrs (res."byID" != { }) { inherit (res) "byID"; }
    // {
    }
    // optionalAttrs (res."byName" != null) {
      "byName" = mkProviderYandexcertificatemanagerFetchingByName res."byName";
    }
    // {
    };
  ProviderYandexcertificatemanagerModule = types.submodule {
    options = {
      "apiEndpoint" = mkOption {
        description = "Yandex.Cloud API endpoint (e.g. 'api.cloud.yandex.net:443')";
        type = (types.nullOr types.str);
        default = null;
      };
      "auth" = mkOption {
        description = "Auth defines the information necessary to authenticate against Yandex.Cloud";
        type = ProviderYandexcertificatemanagerAuthModule;
      };
      "caProvider" = mkOption {
        description = "The provider for the CA bundle to use to validate Yandex.Cloud server certificate.";
        type = (types.nullOr ProviderYandexcertificatemanagerCaProviderModule);
        default = null;
      };
      "fetching" = mkOption {
        description = "FetchingPolicy configures the provider to interpret the `data.secretKey.remoteRef.key` field in ExternalSecret as certificate ID or certificate name";
        type = (types.nullOr ProviderYandexcertificatemanagerFetchingModule);
        default = null;
      };
    };
  };
  mkProviderYandexcertificatemanager =
    res:
    {
    }
    // optionalAttrs (res."apiEndpoint" != null) { inherit (res) "apiEndpoint"; }
    // {
      "auth" = mkProviderYandexcertificatemanagerAuth res."auth";
    }
    // optionalAttrs (res."caProvider" != null) {
      "caProvider" = mkProviderYandexcertificatemanagerCaProvider res."caProvider";
    }
    // {
    }
    // optionalAttrs (res."fetching" != null) {
      "fetching" = mkProviderYandexcertificatemanagerFetching res."fetching";
    }
    // {
    };
  ProviderYandexlockboxAuthAuthorizedKeySecretRefModule = types.submodule {
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
  mkProviderYandexlockboxAuthAuthorizedKeySecretRef =
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
  ProviderYandexlockboxAuthModule = types.submodule {
    options = {
      "authorizedKeySecretRef" = mkOption {
        description = "The authorized key used for authentication";
        type = (types.nullOr ProviderYandexlockboxAuthAuthorizedKeySecretRefModule);
        default = null;
      };
    };
  };
  mkProviderYandexlockboxAuth =
    res:
    {
    }
    // optionalAttrs (res."authorizedKeySecretRef" != null) {
      "authorizedKeySecretRef" =
        mkProviderYandexlockboxAuthAuthorizedKeySecretRef
          res."authorizedKeySecretRef";
    }
    // {
    };
  ProviderYandexlockboxCaProviderCertSecretRefModule = types.submodule {
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
  mkProviderYandexlockboxCaProviderCertSecretRef =
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
  ProviderYandexlockboxCaProviderModule = types.submodule {
    options = {
      "certSecretRef" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = (types.nullOr ProviderYandexlockboxCaProviderCertSecretRefModule);
        default = null;
      };
    };
  };
  mkProviderYandexlockboxCaProvider =
    res:
    {
    }
    // optionalAttrs (res."certSecretRef" != null) {
      "certSecretRef" = mkProviderYandexlockboxCaProviderCertSecretRef res."certSecretRef";
    }
    // {
    };
  ProviderYandexlockboxFetchingByNameModule = types.submodule {
    options = {
      "folderID" = mkOption {
        description = "The folder to fetch secrets from";
        type = types.str;
      };
    };
  };
  mkProviderYandexlockboxFetchingByName = res: {
    inherit (res) "folderID";
  };
  ProviderYandexlockboxFetchingModule = types.submodule {
    options = {
      "byID" = mkOption {
        description = "ByID configures the provider to interpret the `data.secretKey.remoteRef.key` field in ExternalSecret as secret ID.";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "byName" = mkOption {
        description = "ByName configures the provider to interpret the `data.secretKey.remoteRef.key` field in ExternalSecret as secret name.";
        type = (types.nullOr ProviderYandexlockboxFetchingByNameModule);
        default = null;
      };
    };
  };
  mkProviderYandexlockboxFetching =
    res:
    {
    }
    // optionalAttrs (res."byID" != { }) { inherit (res) "byID"; }
    // {
    }
    // optionalAttrs (res."byName" != null) {
      "byName" = mkProviderYandexlockboxFetchingByName res."byName";
    }
    // {
    };
  ProviderYandexlockboxModule = types.submodule {
    options = {
      "apiEndpoint" = mkOption {
        description = "Yandex.Cloud API endpoint (e.g. 'api.cloud.yandex.net:443')";
        type = (types.nullOr types.str);
        default = null;
      };
      "auth" = mkOption {
        description = "Auth defines the information necessary to authenticate against Yandex.Cloud";
        type = ProviderYandexlockboxAuthModule;
      };
      "caProvider" = mkOption {
        description = "The provider for the CA bundle to use to validate Yandex.Cloud server certificate.";
        type = (types.nullOr ProviderYandexlockboxCaProviderModule);
        default = null;
      };
      "fetching" = mkOption {
        description = "FetchingPolicy configures the provider to interpret the `data.secretKey.remoteRef.key` field in ExternalSecret as secret ID or secret name";
        type = (types.nullOr ProviderYandexlockboxFetchingModule);
        default = null;
      };
    };
  };
  mkProviderYandexlockbox =
    res:
    {
    }
    // optionalAttrs (res."apiEndpoint" != null) { inherit (res) "apiEndpoint"; }
    // {
      "auth" = mkProviderYandexlockboxAuth res."auth";
    }
    // optionalAttrs (res."caProvider" != null) {
      "caProvider" = mkProviderYandexlockboxCaProvider res."caProvider";
    }
    // {
    }
    // optionalAttrs (res."fetching" != null) {
      "fetching" = mkProviderYandexlockboxFetching res."fetching";
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
  ClustersecretstoresModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this ClusterSecretStore resource.";
        };
        "conditions" = mkOption {
          description = "Used to constrain a ClusterSecretStore to specific namespaces. Relevant only to ClusterSecretStore.";
          type = (types.listOf ConditionModule);
          default = [ ];
        };
        "controller" = mkOption {
          description = "Used to select the correct ESO controller (think: ingress.ingressClassName)\nThe ESO controller is instantiated with a specific controller name and filters ES based on this property";
          type = (types.nullOr types.str);
          default = null;
        };
        "provider" = mkOption {
          description = "Used to configure the provider. Only one provider may be set";
          type = ProviderModule;
        };
        "refreshInterval" = mkOption {
          description = "Used to configure store refresh interval in seconds. Empty or 0 will default to the controller config.";
          type = (types.nullOr types.int);
          default = null;
        };
        "retrySettings" = mkOption {
          description = "Used to configure HTTP retries on failures.";
          type = (types.nullOr RetrySettingsModule);
          default = null;
        };
      };
    }
  );
  mkClusterSecretStore = name: res: {
    apiVersion = "external-secrets.io/v1";
    kind = "ClusterSecretStore";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."conditions" != [ ]) { "conditions" = map mkCondition res."conditions"; }
    // {
    }
    // optionalAttrs (res."controller" != null) { inherit (res) "controller"; }
    // {
      "provider" = mkProvider res."provider";
    }
    // optionalAttrs (res."refreshInterval" != null) { inherit (res) "refreshInterval"; }
    // {
    }
    // optionalAttrs (res."retrySettings" != null) {
      "retrySettings" = mkRetrySettings res."retrySettings";
    }
    // {
    };
  };
  allResources = (mapAttrsToList mkClusterSecretStore cfg."clustersecretstores");
in
{
  options.openkrill.apps."external-secrets" = {
    "clustersecretstores" = mkOption {
      type = types.attrsOf ClustersecretstoresModule;
      default = { };
      description = "ClusterSecretStore CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."external-secrets".content = allResources;
  };
}
