# Auto-generated openkrill module fragment for external-secrets
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."external-secrets";
  compact = filterAttrs (_: v: v != null);
  DataFromExtractModule = types.submodule {
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
  mkDataFromExtract =
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
  DataFromFindModule = types.submodule {
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
        type = (types.nullOr DataFromFindNameModule);
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
  mkDataFromFind =
    res:
    {
    }
    // optionalAttrs (res."conversionStrategy" != null) { inherit (res) "conversionStrategy"; }
    // {
    }
    // optionalAttrs (res."decodingStrategy" != null) { inherit (res) "decodingStrategy"; }
    // {
    }
    // optionalAttrs (res."name" != null) { "name" = mkDataFromFindName res."name"; }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs (res."tags" != { }) { inherit (res) "tags"; }
    // {
    };
  DataFromFindNameModule = types.submodule {
    options = {
      "regexp" = mkOption {
        description = "Finds secrets base";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDataFromFindName =
    res:
    {
    }
    // optionalAttrs (res."regexp" != null) { inherit (res) "regexp"; }
    // {
    };
  DataFromModule = types.submodule {
    options = {
      "extract" = mkOption {
        description = "Used to extract multiple key/value pairs from one secret\nNote: Extract does not support sourceRef.Generator or sourceRef.GeneratorRef.";
        type = (types.nullOr DataFromExtractModule);
        default = null;
      };
      "find" = mkOption {
        description = "Used to find secrets based on tags or regular expressions\nNote: Find does not support sourceRef.Generator or sourceRef.GeneratorRef.";
        type = (types.nullOr DataFromFindModule);
        default = null;
      };
      "rewrite" = mkOption {
        description = "Used to rewrite secret Keys after getting them from the secret Provider\nMultiple Rewrite operations can be provided. They are applied in a layered order (first to last)";
        type = (types.listOf DataFromRewriteModule);
        default = [ ];
      };
      "sourceRef" = mkOption {
        description = "SourceRef points to a store or generator\nwhich contains secret values ready to use.\nUse this in combination with Extract or Find pull values out of\na specific SecretStore.\nWhen sourceRef points to a generator Extract or Find is not supported.\nThe generator returns a static map of values";
        type = (types.nullOr DataFromSourceRefModule);
        default = null;
      };
    };
  };
  mkDataFrom =
    res:
    {
    }
    // optionalAttrs (res."extract" != null) { "extract" = mkDataFromExtract res."extract"; }
    // {
    }
    // optionalAttrs (res."find" != null) { "find" = mkDataFromFind res."find"; }
    // {
    }
    // optionalAttrs (res."rewrite" != [ ]) { "rewrite" = map mkDataFromRewrite res."rewrite"; }
    // {
    }
    // optionalAttrs (res."sourceRef" != null) { "sourceRef" = mkDataFromSourceRef res."sourceRef"; }
    // {
    };
  DataFromRewriteMergeModule = types.submodule {
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
  mkDataFromRewriteMerge =
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
  DataFromRewriteModule = types.submodule {
    options = {
      "merge" = mkOption {
        description = "Used to merge key/values in one single Secret\nThe resulting key will contain all values from the specified secrets";
        type = (types.nullOr DataFromRewriteMergeModule);
        default = null;
      };
      "regexp" = mkOption {
        description = "Used to rewrite with regular expressions.\nThe resulting key will be the output of a regexp.ReplaceAll operation.";
        type = (types.nullOr DataFromRewriteRegexpModule);
        default = null;
      };
      "transform" = mkOption {
        description = "Used to apply string transformation on the secrets.\nThe resulting key will be the output of the template applied by the operation.";
        type = (types.nullOr DataFromRewriteTransformModule);
        default = null;
      };
    };
  };
  mkDataFromRewrite =
    res:
    {
    }
    // optionalAttrs (res."merge" != null) { "merge" = mkDataFromRewriteMerge res."merge"; }
    // {
    }
    // optionalAttrs (res."regexp" != null) { "regexp" = mkDataFromRewriteRegexp res."regexp"; }
    // {
    }
    // optionalAttrs (res."transform" != null) {
      "transform" = mkDataFromRewriteTransform res."transform";
    }
    // {
    };
  DataFromRewriteRegexpModule = types.submodule {
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
  mkDataFromRewriteRegexp = res: {
    inherit (res) "source";
    inherit (res) "target";
  };
  DataFromRewriteTransformModule = types.submodule {
    options = {
      "template" = mkOption {
        description = "Used to define the template to apply on the secret name.\n`.value ` will specify the secret name in the template.";
        type = types.str;
      };
    };
  };
  mkDataFromRewriteTransform = res: {
    inherit (res) "template";
  };
  DataFromSourceRefGeneratorRefModule = types.submodule {
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
  mkDataFromSourceRefGeneratorRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    };
  DataFromSourceRefModule = types.submodule {
    options = {
      "generatorRef" = mkOption {
        description = "GeneratorRef points to a generator custom resource.";
        type = (types.nullOr DataFromSourceRefGeneratorRefModule);
        default = null;
      };
      "storeRef" = mkOption {
        description = "SecretStoreRef defines which SecretStore to fetch the ExternalSecret data.";
        type = (types.nullOr DataFromSourceRefStoreRefModule);
        default = null;
      };
    };
  };
  mkDataFromSourceRef =
    res:
    {
    }
    // optionalAttrs (res."generatorRef" != null) {
      "generatorRef" = mkDataFromSourceRefGeneratorRef res."generatorRef";
    }
    // {
    }
    // optionalAttrs (res."storeRef" != null) {
      "storeRef" = mkDataFromSourceRefStoreRef res."storeRef";
    }
    // {
    };
  DataFromSourceRefStoreRefModule = types.submodule {
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
  mkDataFromSourceRefStoreRef =
    res:
    {
    }
    // optionalAttrs (res."kind" != null) { inherit (res) "kind"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  DataModule = types.submodule {
    options = {
      "remoteRef" = mkOption {
        description = "RemoteRef points to the remote secret and defines\nwhich secret (version/property/..) to fetch.";
        type = DataRemoteRefModule;
      };
      "secretKey" = mkOption {
        description = "The key in the Kubernetes Secret to store the value.";
        type = types.str;
      };
      "sourceRef" = mkOption {
        description = "SourceRef allows you to override the source\nfrom which the value will be pulled.";
        type = (types.nullOr DataSourceRefModule);
        default = null;
      };
    };
  };
  mkData =
    res:
    {
      "remoteRef" = mkDataRemoteRef res."remoteRef";
      inherit (res) "secretKey";
    }
    // optionalAttrs (res."sourceRef" != null) { "sourceRef" = mkDataSourceRef res."sourceRef"; }
    // {
    };
  DataRemoteRefModule = types.submodule {
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
  mkDataRemoteRef =
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
  DataSourceRefGeneratorRefModule = types.submodule {
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
  mkDataSourceRefGeneratorRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    };
  DataSourceRefModule = types.submodule {
    options = {
      "generatorRef" = mkOption {
        description = "GeneratorRef points to a generator custom resource.\n\nDeprecated: The generatorRef is not implemented in .data[].\nthis will be removed with v1.";
        type = (types.nullOr DataSourceRefGeneratorRefModule);
        default = null;
      };
      "storeRef" = mkOption {
        description = "SecretStoreRef defines which SecretStore to fetch the ExternalSecret data.";
        type = (types.nullOr DataSourceRefStoreRefModule);
        default = null;
      };
    };
  };
  mkDataSourceRef =
    res:
    {
    }
    // optionalAttrs (res."generatorRef" != null) {
      "generatorRef" = mkDataSourceRefGeneratorRef res."generatorRef";
    }
    // {
    }
    // optionalAttrs (res."storeRef" != null) { "storeRef" = mkDataSourceRefStoreRef res."storeRef"; }
    // {
    };
  DataSourceRefStoreRefModule = types.submodule {
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
  mkDataSourceRefStoreRef =
    res:
    {
    }
    // optionalAttrs (res."kind" != null) { inherit (res) "kind"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  SecretStoreRefModule = types.submodule {
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
  mkSecretStoreRef =
    res:
    {
    }
    // optionalAttrs (res."kind" != null) { inherit (res) "kind"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  TargetManifestModule = types.submodule {
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
  mkTargetManifest = res: {
    inherit (res) "apiVersion";
    inherit (res) "kind";
  };
  TargetModule = types.submodule {
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
        type = (types.nullOr TargetManifestModule);
        default = null;
      };
      "name" = mkOption {
        description = "The name of the Secret resource to be managed.\nDefaults to the .metadata.name of the ExternalSecret resource";
        type = (types.nullOr types.str);
        default = null;
      };
      "template" = mkOption {
        description = "Template defines a blueprint for the created Secret resource.";
        type = (types.nullOr TargetTemplateModule);
        default = null;
      };
    };
  };
  mkTarget =
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
    // optionalAttrs (res."manifest" != null) { "manifest" = mkTargetManifest res."manifest"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."template" != null) { "template" = mkTargetTemplate res."template"; }
    // {
    };
  TargetTemplateMetadataModule = types.submodule {
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
  mkTargetTemplateMetadata =
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
  TargetTemplateModule = types.submodule {
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
        type = (types.nullOr TargetTemplateMetadataModule);
        default = null;
      };
      "templateFrom" = mkOption {
        type = (types.listOf TargetTemplateTemplateFromModule);
        default = [ ];
      };
      "type" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTargetTemplate =
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
    // optionalAttrs (res."metadata" != null) { "metadata" = mkTargetTemplateMetadata res."metadata"; }
    // {
    }
    // optionalAttrs (res."templateFrom" != [ ]) {
      "templateFrom" = map mkTargetTemplateTemplateFrom res."templateFrom";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  TargetTemplateTemplateFromConfigMapItemModule = types.submodule {
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
  mkTargetTemplateTemplateFromConfigMapItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."templateAs" != null) { inherit (res) "templateAs"; }
    // {
    };
  TargetTemplateTemplateFromConfigMapModule = types.submodule {
    options = {
      "items" = mkOption {
        description = "A list of keys in the ConfigMap/Secret to use as templates for Secret data";
        type = (types.listOf TargetTemplateTemplateFromConfigMapItemModule);
      };
      "name" = mkOption {
        description = "The name of the ConfigMap/Secret resource";
        type = types.str;
      };
    };
  };
  mkTargetTemplateTemplateFromConfigMap = res: {
    "items" = map mkTargetTemplateTemplateFromConfigMapItem res."items";
    inherit (res) "name";
  };
  TargetTemplateTemplateFromModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "TemplateRef specifies a reference to either a ConfigMap or a Secret resource.";
        type = (types.nullOr TargetTemplateTemplateFromConfigMapModule);
        default = null;
      };
      "literal" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "secret" = mkOption {
        description = "TemplateRef specifies a reference to either a ConfigMap or a Secret resource.";
        type = (types.nullOr TargetTemplateTemplateFromSecretModule);
        default = null;
      };
      "target" = mkOption {
        description = "Target specifies where to place the template result.\nFor Secret resources, common values are: \"Data\", \"Annotations\", \"Labels\".\nFor custom resources (when spec.target.manifest is set), this supports\nnested paths like \"spec.database.config\" or \"data\".";
        type = (types.nullOr types.str);
        default = "Data";
      };
    };
  };
  mkTargetTemplateTemplateFrom =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkTargetTemplateTemplateFromConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."literal" != null) { inherit (res) "literal"; }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkTargetTemplateTemplateFromSecret res."secret";
    }
    // {
    }
    // optionalAttrs (res."target" != null) { inherit (res) "target"; }
    // {
    };
  TargetTemplateTemplateFromSecretItemModule = types.submodule {
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
  mkTargetTemplateTemplateFromSecretItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."templateAs" != null) { inherit (res) "templateAs"; }
    // {
    };
  TargetTemplateTemplateFromSecretModule = types.submodule {
    options = {
      "items" = mkOption {
        description = "A list of keys in the ConfigMap/Secret to use as templates for Secret data";
        type = (types.listOf TargetTemplateTemplateFromSecretItemModule);
      };
      "name" = mkOption {
        description = "The name of the ConfigMap/Secret resource";
        type = types.str;
      };
    };
  };
  mkTargetTemplateTemplateFromSecret = res: {
    "items" = map mkTargetTemplateTemplateFromSecretItem res."items";
    inherit (res) "name";
  };
  ExternalsecretsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this ExternalSecret resource.";
        };
        "data" = mkOption {
          description = "Data defines the connection between the Kubernetes Secret keys and the Provider data";
          type = (types.listOf DataModule);
          default = [ ];
        };
        "dataFrom" = mkOption {
          description = "DataFrom is used to fetch all properties from a specific Provider data\nIf multiple entries are specified, the Secret keys are merged in the specified order";
          type = (types.listOf DataFromModule);
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
          type = (types.nullOr SecretStoreRefModule);
          default = null;
        };
        "target" = mkOption {
          description = "ExternalSecretTarget defines the Kubernetes Secret to be created,\nthere can be only one target per ExternalSecret.";
          type = (types.nullOr TargetModule);
          default = {
            "creationPolicy" = "Owner";
            "deletionPolicy" = "Retain";
          };
        };
      };
    }
  );
  mkExternalSecret = name: res: {
    apiVersion = "external-secrets.io/v1";
    kind = "ExternalSecret";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."data" != [ ]) { "data" = map mkData res."data"; }
    // {
    }
    // optionalAttrs (res."dataFrom" != [ ]) { "dataFrom" = map mkDataFrom res."dataFrom"; }
    // {
    }
    // optionalAttrs (res."refreshInterval" != null) { inherit (res) "refreshInterval"; }
    // {
    }
    // optionalAttrs (res."refreshPolicy" != null) { inherit (res) "refreshPolicy"; }
    // {
    }
    // optionalAttrs (res."secretStoreRef" != null) {
      "secretStoreRef" = mkSecretStoreRef res."secretStoreRef";
    }
    // {
    }
    // optionalAttrs (res."target" != null) { "target" = mkTarget res."target"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkExternalSecret cfg."externalsecrets");
in
{
  options.openkrill.apps."external-secrets" = {
    "externalsecrets" = mkOption {
      type = types.attrsOf ExternalsecretsModule;
      default = { };
      description = "ExternalSecret CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."external-secrets".content = allResources;
  };
}
