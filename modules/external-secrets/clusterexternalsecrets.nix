# Auto-generated openkrill module fragment for external-secrets
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."external-secrets";
  compact = filterAttrs (_: v: v != null);
  ExternalSecretMetadataModule = types.submodule {
    options = {
      "annotations" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "labels" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkExternalSecretMetadata =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    };
  ExternalSecretSpecDataFromExtractModule = types.submodule {
    options = {
      "conversionStrategy" = mkOption {
        description = "Used to define a conversion Strategy";
        type = (
          types.nullOr (
            types.enum [
              "Default"
              "Unicode"
            ]
          )
        );
        default = "Default";
      };
      "decodingStrategy" = mkOption {
        description = "Used to define a decoding Strategy";
        type = (
          types.nullOr (
            types.enum [
              "Auto"
              "Base64"
              "Base64URL"
              "None"
            ]
          )
        );
        default = "None";
      };
      "key" = mkOption {
        description = "Key is the key used in the Provider, mandatory";
        type = types.str;
      };
      "metadataPolicy" = mkOption {
        description = "Policy for fetching tags/labels from provider secrets, possible options are Fetch, None. Defaults to None";
        type = (
          types.nullOr (
            types.enum [
              "None"
              "Fetch"
            ]
          )
        );
        default = "None";
      };
      "property" = mkOption {
        description = "Used to select a specific property of the Provider value (if a map), if supported";
        type = (types.nullOr types.str);
        default = null;
      };
      "version" = mkOption {
        description = "Used to select a specific version of the Provider value, if supported";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkExternalSecretSpecDataFromExtract =
    res:
    {
    }
    // optionalAttrs (res."conversionStrategy" != null) { inherit (res) "conversionStrategy"; }
    // {
    }
    // optionalAttrs (res."decodingStrategy" != null) { inherit (res) "decodingStrategy"; }
    // {
      inherit (res) "key";
    }
    // optionalAttrs (res."metadataPolicy" != null) { inherit (res) "metadataPolicy"; }
    // {
    }
    // optionalAttrs (res."property" != null) { inherit (res) "property"; }
    // {
    }
    // optionalAttrs (res."version" != null) { inherit (res) "version"; }
    // {
    };
  ExternalSecretSpecDataFromFindModule = types.submodule {
    options = {
      "conversionStrategy" = mkOption {
        description = "Used to define a conversion Strategy";
        type = (
          types.nullOr (
            types.enum [
              "Default"
              "Unicode"
            ]
          )
        );
        default = "Default";
      };
      "decodingStrategy" = mkOption {
        description = "Used to define a decoding Strategy";
        type = (
          types.nullOr (
            types.enum [
              "Auto"
              "Base64"
              "Base64URL"
              "None"
            ]
          )
        );
        default = "None";
      };
      "name" = mkOption {
        description = "Finds secrets based on the name.";
        type = (types.nullOr ExternalSecretSpecDataFromFindNameModule);
        default = null;
      };
      "path" = mkOption {
        description = "A root path to start the find operations.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tags" = mkOption {
        description = "Find secrets based on tags.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkExternalSecretSpecDataFromFind =
    res:
    {
    }
    // optionalAttrs (res."conversionStrategy" != null) { inherit (res) "conversionStrategy"; }
    // {
    }
    // optionalAttrs (res."decodingStrategy" != null) { inherit (res) "decodingStrategy"; }
    // {
    }
    // optionalAttrs (res."name" != null) { "name" = mkExternalSecretSpecDataFromFindName res."name"; }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs (res."tags" != { }) { inherit (res) "tags"; }
    // {
    };
  ExternalSecretSpecDataFromFindNameModule = types.submodule {
    options = {
      "regexp" = mkOption {
        description = "Finds secrets base";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkExternalSecretSpecDataFromFindName =
    res:
    {
    }
    // optionalAttrs (res."regexp" != null) { inherit (res) "regexp"; }
    // {
    };
  ExternalSecretSpecDataFromModule = types.submodule {
    options = {
      "extract" = mkOption {
        description = "Used to extract multiple key/value pairs from one secret\nNote: Extract does not support sourceRef.Generator or sourceRef.GeneratorRef.";
        type = (types.nullOr ExternalSecretSpecDataFromExtractModule);
        default = null;
      };
      "find" = mkOption {
        description = "Used to find secrets based on tags or regular expressions\nNote: Find does not support sourceRef.Generator or sourceRef.GeneratorRef.";
        type = (types.nullOr ExternalSecretSpecDataFromFindModule);
        default = null;
      };
      "rewrite" = mkOption {
        description = "Used to rewrite secret Keys after getting them from the secret Provider\nMultiple Rewrite operations can be provided. They are applied in a layered order (first to last)";
        type = (types.listOf ExternalSecretSpecDataFromRewriteModule);
        default = [ ];
      };
      "sourceRef" = mkOption {
        description = "SourceRef points to a store or generator\nwhich contains secret values ready to use.\nUse this in combination with Extract or Find pull values out of\na specific SecretStore.\nWhen sourceRef points to a generator Extract or Find is not supported.\nThe generator returns a static map of values";
        type = (types.nullOr ExternalSecretSpecDataFromSourceRefModule);
        default = null;
      };
    };
  };
  mkExternalSecretSpecDataFrom =
    res:
    {
    }
    // optionalAttrs (res."extract" != null) {
      "extract" = mkExternalSecretSpecDataFromExtract res."extract";
    }
    // {
    }
    // optionalAttrs (res."find" != null) { "find" = mkExternalSecretSpecDataFromFind res."find"; }
    // {
    }
    // optionalAttrs (res."rewrite" != [ ]) {
      "rewrite" = map mkExternalSecretSpecDataFromRewrite res."rewrite";
    }
    // {
    }
    // optionalAttrs (res."sourceRef" != null) {
      "sourceRef" = mkExternalSecretSpecDataFromSourceRef res."sourceRef";
    }
    // {
    };
  ExternalSecretSpecDataFromRewriteMergeModule = types.submodule {
    options = {
      "conflictPolicy" = mkOption {
        description = "Used to define the policy to use in conflict resolution.";
        type = (
          types.nullOr (
            types.enum [
              "Ignore"
              "Error"
            ]
          )
        );
        default = "Error";
      };
      "into" = mkOption {
        description = "Used to define the target key of the merge operation.\nRequired if strategy is JSON. Ignored otherwise.";
        type = (types.nullOr types.str);
        default = "";
      };
      "priority" = mkOption {
        description = "Used to define key priority in conflict resolution.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "priorityPolicy" = mkOption {
        description = "Used to define the policy when a key in the priority list does not exist in the input.";
        type = (
          types.nullOr (
            types.enum [
              "IgnoreNotFound"
              "Strict"
            ]
          )
        );
        default = "Strict";
      };
      "strategy" = mkOption {
        description = "Used to define the strategy to use in the merge operation.";
        type = (
          types.nullOr (
            types.enum [
              "Extract"
              "JSON"
            ]
          )
        );
        default = "Extract";
      };
    };
  };
  mkExternalSecretSpecDataFromRewriteMerge =
    res:
    {
    }
    // optionalAttrs (res."conflictPolicy" != null) { inherit (res) "conflictPolicy"; }
    // {
    }
    // optionalAttrs (res."into" != null) { inherit (res) "into"; }
    // {
    }
    // optionalAttrs (res."priority" != [ ]) { inherit (res) "priority"; }
    // {
    }
    // optionalAttrs (res."priorityPolicy" != null) { inherit (res) "priorityPolicy"; }
    // {
    }
    // optionalAttrs (res."strategy" != null) { inherit (res) "strategy"; }
    // {
    };
  ExternalSecretSpecDataFromRewriteModule = types.submodule {
    options = {
      "merge" = mkOption {
        description = "Used to merge key/values in one single Secret\nThe resulting key will contain all values from the specified secrets";
        type = (types.nullOr ExternalSecretSpecDataFromRewriteMergeModule);
        default = null;
      };
      "regexp" = mkOption {
        description = "Used to rewrite with regular expressions.\nThe resulting key will be the output of a regexp.ReplaceAll operation.";
        type = (types.nullOr ExternalSecretSpecDataFromRewriteRegexpModule);
        default = null;
      };
      "transform" = mkOption {
        description = "Used to apply string transformation on the secrets.\nThe resulting key will be the output of the template applied by the operation.";
        type = (types.nullOr ExternalSecretSpecDataFromRewriteTransformModule);
        default = null;
      };
    };
  };
  mkExternalSecretSpecDataFromRewrite =
    res:
    {
    }
    // optionalAttrs (res."merge" != null) {
      "merge" = mkExternalSecretSpecDataFromRewriteMerge res."merge";
    }
    // {
    }
    // optionalAttrs (res."regexp" != null) {
      "regexp" = mkExternalSecretSpecDataFromRewriteRegexp res."regexp";
    }
    // {
    }
    // optionalAttrs (res."transform" != null) {
      "transform" = mkExternalSecretSpecDataFromRewriteTransform res."transform";
    }
    // {
    };
  ExternalSecretSpecDataFromRewriteRegexpModule = types.submodule {
    options = {
      "source" = mkOption {
        description = "Used to define the regular expression of a re.Compiler.";
        type = types.str;
      };
      "target" = mkOption {
        description = "Used to define the target pattern of a ReplaceAll operation.";
        type = types.str;
      };
    };
  };
  mkExternalSecretSpecDataFromRewriteRegexp = res: {
    inherit (res) "source";
    inherit (res) "target";
  };
  ExternalSecretSpecDataFromRewriteTransformModule = types.submodule {
    options = {
      "template" = mkOption {
        description = "Used to define the template to apply on the secret name.\n`.value ` will specify the secret name in the template.";
        type = types.str;
      };
    };
  };
  mkExternalSecretSpecDataFromRewriteTransform = res: {
    inherit (res) "template";
  };
  ExternalSecretSpecDataFromSourceRefGeneratorRefModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        description = "Specify the apiVersion of the generator resource";
        type = (types.nullOr types.str);
        default = "generators.external-secrets.io/v1alpha1";
      };
      "kind" = mkOption {
        description = "Specify the Kind of the generator resource";
        type = (
          types.enum [
            "ACRAccessToken"
            "ClusterGenerator"
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
            "MFA"
          ]
        );
      };
      "name" = mkOption {
        description = "Specify the name of the generator resource";
        type = types.str;
      };
    };
  };
  mkExternalSecretSpecDataFromSourceRefGeneratorRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    };
  ExternalSecretSpecDataFromSourceRefModule = types.submodule {
    options = {
      "generatorRef" = mkOption {
        description = "GeneratorRef points to a generator custom resource.";
        type = (types.nullOr ExternalSecretSpecDataFromSourceRefGeneratorRefModule);
        default = null;
      };
      "storeRef" = mkOption {
        description = "SecretStoreRef defines which SecretStore to fetch the ExternalSecret data.";
        type = (types.nullOr ExternalSecretSpecDataFromSourceRefStoreRefModule);
        default = null;
      };
    };
  };
  mkExternalSecretSpecDataFromSourceRef =
    res:
    {
    }
    // optionalAttrs (res."generatorRef" != null) {
      "generatorRef" = mkExternalSecretSpecDataFromSourceRefGeneratorRef res."generatorRef";
    }
    // {
    }
    // optionalAttrs (res."storeRef" != null) {
      "storeRef" = mkExternalSecretSpecDataFromSourceRefStoreRef res."storeRef";
    }
    // {
    };
  ExternalSecretSpecDataFromSourceRefStoreRefModule = types.submodule {
    options = {
      "kind" = mkOption {
        description = "Kind of the SecretStore resource (SecretStore or ClusterSecretStore)\nDefaults to `SecretStore`";
        type = (
          types.nullOr (
            types.enum [
              "SecretStore"
              "ClusterSecretStore"
            ]
          )
        );
        default = null;
      };
      "name" = mkOption {
        description = "Name of the SecretStore resource";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkExternalSecretSpecDataFromSourceRefStoreRef =
    res:
    {
    }
    // optionalAttrs (res."kind" != null) { inherit (res) "kind"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ExternalSecretSpecDataModule = types.submodule {
    options = {
      "remoteRef" = mkOption {
        description = "RemoteRef points to the remote secret and defines\nwhich secret (version/property/..) to fetch.";
        type = ExternalSecretSpecDataRemoteRefModule;
      };
      "secretKey" = mkOption {
        description = "The key in the Kubernetes Secret to store the value.";
        type = types.str;
      };
      "sourceRef" = mkOption {
        description = "SourceRef allows you to override the source\nfrom which the value will be pulled.";
        type = (types.nullOr ExternalSecretSpecDataSourceRefModule);
        default = null;
      };
    };
  };
  mkExternalSecretSpecData =
    res:
    {
      "remoteRef" = mkExternalSecretSpecDataRemoteRef res."remoteRef";
      inherit (res) "secretKey";
    }
    // optionalAttrs (res."sourceRef" != null) {
      "sourceRef" = mkExternalSecretSpecDataSourceRef res."sourceRef";
    }
    // {
    };
  ExternalSecretSpecDataRemoteRefModule = types.submodule {
    options = {
      "conversionStrategy" = mkOption {
        description = "Used to define a conversion Strategy";
        type = (
          types.nullOr (
            types.enum [
              "Default"
              "Unicode"
            ]
          )
        );
        default = "Default";
      };
      "decodingStrategy" = mkOption {
        description = "Used to define a decoding Strategy";
        type = (
          types.nullOr (
            types.enum [
              "Auto"
              "Base64"
              "Base64URL"
              "None"
            ]
          )
        );
        default = "None";
      };
      "key" = mkOption {
        description = "Key is the key used in the Provider, mandatory";
        type = types.str;
      };
      "metadataPolicy" = mkOption {
        description = "Policy for fetching tags/labels from provider secrets, possible options are Fetch, None. Defaults to None";
        type = (
          types.nullOr (
            types.enum [
              "None"
              "Fetch"
            ]
          )
        );
        default = "None";
      };
      "property" = mkOption {
        description = "Used to select a specific property of the Provider value (if a map), if supported";
        type = (types.nullOr types.str);
        default = null;
      };
      "version" = mkOption {
        description = "Used to select a specific version of the Provider value, if supported";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkExternalSecretSpecDataRemoteRef =
    res:
    {
    }
    // optionalAttrs (res."conversionStrategy" != null) { inherit (res) "conversionStrategy"; }
    // {
    }
    // optionalAttrs (res."decodingStrategy" != null) { inherit (res) "decodingStrategy"; }
    // {
      inherit (res) "key";
    }
    // optionalAttrs (res."metadataPolicy" != null) { inherit (res) "metadataPolicy"; }
    // {
    }
    // optionalAttrs (res."property" != null) { inherit (res) "property"; }
    // {
    }
    // optionalAttrs (res."version" != null) { inherit (res) "version"; }
    // {
    };
  ExternalSecretSpecDataSourceRefGeneratorRefModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        description = "Specify the apiVersion of the generator resource";
        type = (types.nullOr types.str);
        default = "generators.external-secrets.io/v1alpha1";
      };
      "kind" = mkOption {
        description = "Specify the Kind of the generator resource";
        type = (
          types.enum [
            "ACRAccessToken"
            "ClusterGenerator"
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
            "MFA"
          ]
        );
      };
      "name" = mkOption {
        description = "Specify the name of the generator resource";
        type = types.str;
      };
    };
  };
  mkExternalSecretSpecDataSourceRefGeneratorRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    };
  ExternalSecretSpecDataSourceRefModule = types.submodule {
    options = {
      "generatorRef" = mkOption {
        description = "GeneratorRef points to a generator custom resource.\n\nDeprecated: The generatorRef is not implemented in .data[].\nthis will be removed with v1.";
        type = (types.nullOr ExternalSecretSpecDataSourceRefGeneratorRefModule);
        default = null;
      };
      "storeRef" = mkOption {
        description = "SecretStoreRef defines which SecretStore to fetch the ExternalSecret data.";
        type = (types.nullOr ExternalSecretSpecDataSourceRefStoreRefModule);
        default = null;
      };
    };
  };
  mkExternalSecretSpecDataSourceRef =
    res:
    {
    }
    // optionalAttrs (res."generatorRef" != null) {
      "generatorRef" = mkExternalSecretSpecDataSourceRefGeneratorRef res."generatorRef";
    }
    // {
    }
    // optionalAttrs (res."storeRef" != null) {
      "storeRef" = mkExternalSecretSpecDataSourceRefStoreRef res."storeRef";
    }
    // {
    };
  ExternalSecretSpecDataSourceRefStoreRefModule = types.submodule {
    options = {
      "kind" = mkOption {
        description = "Kind of the SecretStore resource (SecretStore or ClusterSecretStore)\nDefaults to `SecretStore`";
        type = (
          types.nullOr (
            types.enum [
              "SecretStore"
              "ClusterSecretStore"
            ]
          )
        );
        default = null;
      };
      "name" = mkOption {
        description = "Name of the SecretStore resource";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkExternalSecretSpecDataSourceRefStoreRef =
    res:
    {
    }
    // optionalAttrs (res."kind" != null) { inherit (res) "kind"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ExternalSecretSpecModule = types.submodule {
    options = {
      "data" = mkOption {
        description = "Data defines the connection between the Kubernetes Secret keys and the Provider data";
        type = (types.listOf ExternalSecretSpecDataModule);
        default = [ ];
      };
      "dataFrom" = mkOption {
        description = "DataFrom is used to fetch all properties from a specific Provider data\nIf multiple entries are specified, the Secret keys are merged in the specified order";
        type = (types.listOf ExternalSecretSpecDataFromModule);
        default = [ ];
      };
      "refreshInterval" = mkOption {
        description = "RefreshInterval is the amount of time before the values are read again from the SecretStore provider,\nspecified as Golang Duration strings.\nValid time units are \"ns\", \"us\" (or \"µs\"), \"ms\", \"s\", \"m\", \"h\"\nExample values: \"1h0m0s\", \"2h30m0s\", \"10m0s\"\nMay be set to \"0s\" to fetch and create it once. Defaults to 1h0m0s.";
        type = (types.nullOr types.str);
        default = "1h0m0s";
      };
      "refreshPolicy" = mkOption {
        description = "RefreshPolicy determines how the ExternalSecret should be refreshed:\n- CreatedOnce: Creates the Secret only if it does not exist and does not update it thereafter\n- Periodic: Synchronizes the Secret from the external source at regular intervals specified by refreshInterval.\n  No periodic updates occur if refreshInterval is 0.\n- OnChange: Only synchronizes the Secret when the ExternalSecret's metadata or specification changes";
        type = (
          types.nullOr (
            types.enum [
              "CreatedOnce"
              "Periodic"
              "OnChange"
            ]
          )
        );
        default = null;
      };
      "secretStoreRef" = mkOption {
        description = "SecretStoreRef defines which SecretStore to fetch the ExternalSecret data.";
        type = (types.nullOr ExternalSecretSpecSecretStoreRefModule);
        default = null;
      };
      "target" = mkOption {
        description = "ExternalSecretTarget defines the Kubernetes Secret to be created,\nthere can be only one target per ExternalSecret.";
        type = (types.nullOr ExternalSecretSpecTargetModule);
        default = {
          "creationPolicy" = "Owner";
          "deletionPolicy" = "Retain";
        };
      };
    };
  };
  mkExternalSecretSpec =
    res:
    {
    }
    // optionalAttrs (res."data" != [ ]) { "data" = map mkExternalSecretSpecData res."data"; }
    // {
    }
    // optionalAttrs (res."dataFrom" != [ ]) {
      "dataFrom" = map mkExternalSecretSpecDataFrom res."dataFrom";
    }
    // {
    }
    // optionalAttrs (res."refreshInterval" != null) { inherit (res) "refreshInterval"; }
    // {
    }
    // optionalAttrs (res."refreshPolicy" != null) { inherit (res) "refreshPolicy"; }
    // {
    }
    // optionalAttrs (res."secretStoreRef" != null) {
      "secretStoreRef" = mkExternalSecretSpecSecretStoreRef res."secretStoreRef";
    }
    // {
    }
    // optionalAttrs (res."target" != null) { "target" = mkExternalSecretSpecTarget res."target"; }
    // {
    };
  ExternalSecretSpecSecretStoreRefModule = types.submodule {
    options = {
      "kind" = mkOption {
        description = "Kind of the SecretStore resource (SecretStore or ClusterSecretStore)\nDefaults to `SecretStore`";
        type = (
          types.nullOr (
            types.enum [
              "SecretStore"
              "ClusterSecretStore"
            ]
          )
        );
        default = null;
      };
      "name" = mkOption {
        description = "Name of the SecretStore resource";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkExternalSecretSpecSecretStoreRef =
    res:
    {
    }
    // optionalAttrs (res."kind" != null) { inherit (res) "kind"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ExternalSecretSpecTargetManifestModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        description = "APIVersion of the target resource (e.g., \"v1\" for ConfigMap, \"argoproj.io/v1alpha1\" for ArgoCD Application)";
        type = types.str;
      };
      "kind" = mkOption {
        description = "Kind of the target resource (e.g., \"ConfigMap\", \"Application\")";
        type = types.str;
      };
    };
  };
  mkExternalSecretSpecTargetManifest = res: {
    inherit (res) "apiVersion";
    inherit (res) "kind";
  };
  ExternalSecretSpecTargetModule = types.submodule {
    options = {
      "creationPolicy" = mkOption {
        description = "CreationPolicy defines rules on how to create the resulting Secret.\nDefaults to \"Owner\"";
        type = (
          types.nullOr (
            types.enum [
              "Owner"
              "Orphan"
              "Merge"
              "None"
            ]
          )
        );
        default = "Owner";
      };
      "deletionPolicy" = mkOption {
        description = "DeletionPolicy defines rules on how to delete the resulting Secret.\nDefaults to \"Retain\"";
        type = (
          types.nullOr (
            types.enum [
              "Delete"
              "Merge"
              "Retain"
            ]
          )
        );
        default = "Retain";
      };
      "immutable" = mkOption {
        description = "Immutable defines if the final secret will be immutable";
        type = types.bool;
        default = false;
      };
      "manifest" = mkOption {
        description = "Manifest defines a custom Kubernetes resource to create instead of a Secret.\nWhen specified, ExternalSecret will create the resource type defined here\n(e.g., ConfigMap, Custom Resource) instead of a Secret.\nWarning: Using Generic target. Make sure access policies and encryption are properly configured.";
        type = (types.nullOr ExternalSecretSpecTargetManifestModule);
        default = null;
      };
      "name" = mkOption {
        description = "The name of the Secret resource to be managed.\nDefaults to the .metadata.name of the ExternalSecret resource";
        type = (types.nullOr types.str);
        default = null;
      };
      "template" = mkOption {
        description = "Template defines a blueprint for the created Secret resource.";
        type = (types.nullOr ExternalSecretSpecTargetTemplateModule);
        default = null;
      };
    };
  };
  mkExternalSecretSpecTarget =
    res:
    {
    }
    // optionalAttrs (res."creationPolicy" != null) { inherit (res) "creationPolicy"; }
    // {
    }
    // optionalAttrs (res."deletionPolicy" != null) { inherit (res) "deletionPolicy"; }
    // {
    }
    // optionalAttrs res."immutable" { inherit (res) "immutable"; }
    // {
    }
    // optionalAttrs (res."manifest" != null) {
      "manifest" = mkExternalSecretSpecTargetManifest res."manifest";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."template" != null) {
      "template" = mkExternalSecretSpecTargetTemplate res."template";
    }
    // {
    };
  ExternalSecretSpecTargetTemplateMetadataModule = types.submodule {
    options = {
      "annotations" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "finalizers" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "labels" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkExternalSecretSpecTargetTemplateMetadata =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."finalizers" != [ ]) { inherit (res) "finalizers"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    };
  ExternalSecretSpecTargetTemplateModule = types.submodule {
    options = {
      "data" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "engineVersion" = mkOption {
        description = "EngineVersion specifies the template engine version\nthat should be used to compile/execute the\ntemplate specified in .data and .templateFrom[].";
        type = (types.nullOr (types.enum [ "v2" ]));
        default = "v2";
      };
      "mergePolicy" = mkOption {
        description = "TemplateMergePolicy defines how the rendered template should be merged with the existing Secret data.";
        type = (
          types.nullOr (
            types.enum [
              "Replace"
              "Merge"
            ]
          )
        );
        default = "Replace";
      };
      "metadata" = mkOption {
        description = "ExternalSecretTemplateMetadata defines metadata fields for the Secret blueprint.";
        type = (types.nullOr ExternalSecretSpecTargetTemplateMetadataModule);
        default = null;
      };
      "templateFrom" = mkOption {
        type = (types.listOf ExternalSecretSpecTargetTemplateTemplateFromModule);
        default = [ ];
      };
      "type" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkExternalSecretSpecTargetTemplate =
    res:
    {
    }
    // optionalAttrs (res."data" != { }) { inherit (res) "data"; }
    // {
    }
    // optionalAttrs (res."engineVersion" != null) { inherit (res) "engineVersion"; }
    // {
    }
    // optionalAttrs (res."mergePolicy" != null) { inherit (res) "mergePolicy"; }
    // {
    }
    // optionalAttrs (res."metadata" != null) {
      "metadata" = mkExternalSecretSpecTargetTemplateMetadata res."metadata";
    }
    // {
    }
    // optionalAttrs (res."templateFrom" != [ ]) {
      "templateFrom" = map mkExternalSecretSpecTargetTemplateTemplateFrom res."templateFrom";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ExternalSecretSpecTargetTemplateTemplateFromConfigMapItemModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "A key in the ConfigMap/Secret";
        type = types.str;
      };
      "templateAs" = mkOption {
        description = "TemplateScope specifies how the template keys should be interpreted.";
        type = (
          types.nullOr (
            types.enum [
              "Values"
              "KeysAndValues"
            ]
          )
        );
        default = "Values";
      };
    };
  };
  mkExternalSecretSpecTargetTemplateTemplateFromConfigMapItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."templateAs" != null) { inherit (res) "templateAs"; }
    // {
    };
  ExternalSecretSpecTargetTemplateTemplateFromConfigMapModule = types.submodule {
    options = {
      "items" = mkOption {
        description = "A list of keys in the ConfigMap/Secret to use as templates for Secret data";
        type = (types.listOf ExternalSecretSpecTargetTemplateTemplateFromConfigMapItemModule);
      };
      "name" = mkOption {
        description = "The name of the ConfigMap/Secret resource";
        type = types.str;
      };
    };
  };
  mkExternalSecretSpecTargetTemplateTemplateFromConfigMap = res: {
    "items" = map mkExternalSecretSpecTargetTemplateTemplateFromConfigMapItem res."items";
    inherit (res) "name";
  };
  ExternalSecretSpecTargetTemplateTemplateFromModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "TemplateRef specifies a reference to either a ConfigMap or a Secret resource.";
        type = (types.nullOr ExternalSecretSpecTargetTemplateTemplateFromConfigMapModule);
        default = null;
      };
      "literal" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "secret" = mkOption {
        description = "TemplateRef specifies a reference to either a ConfigMap or a Secret resource.";
        type = (types.nullOr ExternalSecretSpecTargetTemplateTemplateFromSecretModule);
        default = null;
      };
      "target" = mkOption {
        description = "Target specifies where to place the template result.\nFor Secret resources, common values are: \"Data\", \"Annotations\", \"Labels\".\nFor custom resources (when spec.target.manifest is set), this supports\nnested paths like \"spec.database.config\" or \"data\".";
        type = (types.nullOr types.str);
        default = "Data";
      };
    };
  };
  mkExternalSecretSpecTargetTemplateTemplateFrom =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkExternalSecretSpecTargetTemplateTemplateFromConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."literal" != null) { inherit (res) "literal"; }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkExternalSecretSpecTargetTemplateTemplateFromSecret res."secret";
    }
    // {
    }
    // optionalAttrs (res."target" != null) { inherit (res) "target"; }
    // {
    };
  ExternalSecretSpecTargetTemplateTemplateFromSecretItemModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "A key in the ConfigMap/Secret";
        type = types.str;
      };
      "templateAs" = mkOption {
        description = "TemplateScope specifies how the template keys should be interpreted.";
        type = (
          types.nullOr (
            types.enum [
              "Values"
              "KeysAndValues"
            ]
          )
        );
        default = "Values";
      };
    };
  };
  mkExternalSecretSpecTargetTemplateTemplateFromSecretItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."templateAs" != null) { inherit (res) "templateAs"; }
    // {
    };
  ExternalSecretSpecTargetTemplateTemplateFromSecretModule = types.submodule {
    options = {
      "items" = mkOption {
        description = "A list of keys in the ConfigMap/Secret to use as templates for Secret data";
        type = (types.listOf ExternalSecretSpecTargetTemplateTemplateFromSecretItemModule);
      };
      "name" = mkOption {
        description = "The name of the ConfigMap/Secret resource";
        type = types.str;
      };
    };
  };
  mkExternalSecretSpecTargetTemplateTemplateFromSecret = res: {
    "items" = map mkExternalSecretSpecTargetTemplateTemplateFromSecretItem res."items";
    inherit (res) "name";
  };
  NamespaceSelectorMatchExpressionModule = types.submodule {
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
  mkNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  NamespaceSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf NamespaceSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkNamespaceSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ClusterexternalsecretsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this ClusterExternalSecret resource.";
        };
        "externalSecretMetadata" = mkOption {
          description = "The metadata of the external secrets to be created";
          type = (types.nullOr ExternalSecretMetadataModule);
          default = null;
        };
        "externalSecretName" = mkOption {
          description = "The name of the external secrets to be created.\nDefaults to the name of the ClusterExternalSecret";
          type = (types.nullOr types.str);
          default = null;
        };
        "externalSecretSpec" = mkOption {
          description = "The spec for the ExternalSecrets to be created";
          type = ExternalSecretSpecModule;
        };
        "namespaceSelector" = mkOption {
          description = "The labels to select by to find the Namespaces to create the ExternalSecrets in.\nDeprecated: Use NamespaceSelectors instead.";
          type = (types.nullOr NamespaceSelectorModule);
          default = null;
        };
        "namespaceSelectors" = mkOption {
          description = "A list of labels to select by to find the Namespaces to create the ExternalSecrets in. The selectors are ORed.";
          type = (types.listOf NamespaceSelectorModule);
          default = [ ];
        };
        "namespaces" = mkOption {
          description = "Choose namespaces by name. This field is ORed with anything that NamespaceSelectors ends up choosing.\nDeprecated: Use NamespaceSelectors instead.";
          type = (types.listOf types.str);
          default = [ ];
        };
        "refreshTime" = mkOption {
          description = "The time in which the controller should reconcile its objects and recheck namespaces for labels.";
          type = (types.nullOr types.str);
          default = null;
        };
      };
    }
  );
  mkClusterExternalSecret = name: res: {
    apiVersion = "external-secrets.io/v1";
    kind = "ClusterExternalSecret";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."externalSecretMetadata" != null) {
      "externalSecretMetadata" = mkExternalSecretMetadata res."externalSecretMetadata";
    }
    // {
    }
    // optionalAttrs (res."externalSecretName" != null) { inherit (res) "externalSecretName"; }
    // {
      "externalSecretSpec" = mkExternalSecretSpec res."externalSecretSpec";
    }
    // optionalAttrs (res."namespaceSelector" != null) {
      "namespaceSelector" = mkNamespaceSelector res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaceSelectors" != [ ]) {
      "namespaceSelectors" = map mkNamespaceSelector res."namespaceSelectors";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
    }
    // optionalAttrs (res."refreshTime" != null) { inherit (res) "refreshTime"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkClusterExternalSecret cfg."clusterexternalsecrets");
in
{
  options.openkrill.apps."external-secrets" = {
    "clusterexternalsecrets" = mkOption {
      type = types.attrsOf ClusterexternalsecretsModule;
      default = { };
      description = "ClusterExternalSecret CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."external-secrets".content = allResources;
  };
}
