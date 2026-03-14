# Auto-generated openkrill module fragment for external-secrets
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."external-secrets";
  compact = filterAttrs (_: v: v != null);
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
  PushSecretMetadataModule = types.submodule {
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
  mkPushSecretMetadata =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    };
  PushSecretSpecDataMatchModule = types.submodule {
    options = {
      "remoteRef" = mkOption {
        description = "Remote Refs to push to providers.";
        type = PushSecretSpecDataMatchRemoteRefModule;
      };
      "secretKey" = mkOption {
        description = "Secret Key to be pushed";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkPushSecretSpecDataMatch =
    res:
    {
      "remoteRef" = mkPushSecretSpecDataMatchRemoteRef res."remoteRef";
    }
    // optionalAttrs (res."secretKey" != null) { inherit (res) "secretKey"; }
    // {
    };
  PushSecretSpecDataMatchRemoteRefModule = types.submodule {
    options = {
      "property" = mkOption {
        description = "Name of the property in the resulting secret";
        type = (types.nullOr types.str);
        default = null;
      };
      "remoteKey" = mkOption {
        description = "Name of the resulting provider secret.";
        type = types.str;
      };
    };
  };
  mkPushSecretSpecDataMatchRemoteRef =
    res:
    {
    }
    // optionalAttrs (res."property" != null) { inherit (res) "property"; }
    // {
      inherit (res) "remoteKey";
    };
  PushSecretSpecDataModule = types.submodule {
    options = {
      "conversionStrategy" = mkOption {
        description = "Used to define a conversion Strategy for the secret keys";
        type = (
          types.nullOr (
            types.enum [
              "None"
              "ReverseUnicode"
            ]
          )
        );
        default = "None";
      };
      "match" = mkOption {
        description = "Match a given Secret Key to be pushed to the provider.";
        type = PushSecretSpecDataMatchModule;
      };
      "metadata" = mkOption {
        description = "Metadata is metadata attached to the secret.\nThe structure of metadata is provider specific, please look it up in the provider documentation.";
        type = (types.nullOr types.anything);
        default = null;
      };
    };
  };
  mkPushSecretSpecData =
    res:
    {
    }
    // optionalAttrs (res."conversionStrategy" != null) { inherit (res) "conversionStrategy"; }
    // {
      "match" = mkPushSecretSpecDataMatch res."match";
    }
    // optionalAttrs (res."metadata" != null) { inherit (res) "metadata"; }
    // {
    };
  PushSecretSpecModule = types.submodule {
    options = {
      "data" = mkOption {
        description = "Secret Data that should be pushed to providers";
        type = (types.listOf PushSecretSpecDataModule);
        default = [ ];
      };
      "deletionPolicy" = mkOption {
        description = "Deletion Policy to handle Secrets in the provider.";
        type = (
          types.nullOr (
            types.enum [
              "Delete"
              "None"
            ]
          )
        );
        default = "None";
      };
      "refreshInterval" = mkOption {
        description = "The Interval to which External Secrets will try to push a secret definition";
        type = (types.nullOr types.str);
        default = "1h0m0s";
      };
      "secretStoreRefs" = mkOption {
        type = (types.listOf PushSecretSpecSecretStoreRefModule);
      };
      "selector" = mkOption {
        description = "The Secret Selector (k8s source) for the Push Secret";
        type = PushSecretSpecSelectorModule;
      };
      "template" = mkOption {
        description = "Template defines a blueprint for the created Secret resource.";
        type = (types.nullOr PushSecretSpecTemplateModule);
        default = null;
      };
      "updatePolicy" = mkOption {
        description = "UpdatePolicy to handle Secrets in the provider.";
        type = (
          types.nullOr (
            types.enum [
              "Replace"
              "IfNotExists"
            ]
          )
        );
        default = "Replace";
      };
    };
  };
  mkPushSecretSpec =
    res:
    {
    }
    // optionalAttrs (res."data" != [ ]) { "data" = map mkPushSecretSpecData res."data"; }
    // {
    }
    // optionalAttrs (res."deletionPolicy" != null) { inherit (res) "deletionPolicy"; }
    // {
    }
    // optionalAttrs (res."refreshInterval" != null) { inherit (res) "refreshInterval"; }
    // {
      "secretStoreRefs" = map mkPushSecretSpecSecretStoreRef res."secretStoreRefs";
      "selector" = mkPushSecretSpecSelector res."selector";
    }
    // optionalAttrs (res."template" != null) { "template" = mkPushSecretSpecTemplate res."template"; }
    // {
    }
    // optionalAttrs (res."updatePolicy" != null) { inherit (res) "updatePolicy"; }
    // {
    };
  PushSecretSpecSecretStoreRefLabelSelectorMatchExpressionModule = types.submodule {
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
  mkPushSecretSpecSecretStoreRefLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  PushSecretSpecSecretStoreRefLabelSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf PushSecretSpecSecretStoreRefLabelSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkPushSecretSpecSecretStoreRefLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkPushSecretSpecSecretStoreRefLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  PushSecretSpecSecretStoreRefModule = types.submodule {
    options = {
      "kind" = mkOption {
        description = "Kind of the SecretStore resource (SecretStore or ClusterSecretStore)";
        type = (
          types.nullOr (
            types.enum [
              "SecretStore"
              "ClusterSecretStore"
            ]
          )
        );
        default = "SecretStore";
      };
      "labelSelector" = mkOption {
        description = "Optionally, sync to secret stores with label selector";
        type = (types.nullOr PushSecretSpecSecretStoreRefLabelSelectorModule);
        default = null;
      };
      "name" = mkOption {
        description = "Optionally, sync to the SecretStore of the given name";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkPushSecretSpecSecretStoreRef =
    res:
    {
    }
    // optionalAttrs (res."kind" != null) { inherit (res) "kind"; }
    // {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" = mkPushSecretSpecSecretStoreRefLabelSelector res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  PushSecretSpecSelectorGeneratorRefModule = types.submodule {
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
  mkPushSecretSpecSelectorGeneratorRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    };
  PushSecretSpecSelectorModule = types.submodule {
    options = {
      "generatorRef" = mkOption {
        description = "Point to a generator to create a Secret.";
        type = (types.nullOr PushSecretSpecSelectorGeneratorRefModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Select a Secret to Push.";
        type = (types.nullOr PushSecretSpecSelectorSecretModule);
        default = null;
      };
    };
  };
  mkPushSecretSpecSelector =
    res:
    {
    }
    // optionalAttrs (res."generatorRef" != null) {
      "generatorRef" = mkPushSecretSpecSelectorGeneratorRef res."generatorRef";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkPushSecretSpecSelectorSecret res."secret"; }
    // {
    };
  PushSecretSpecSelectorSecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the Secret.\nThe Secret must exist in the same namespace as the PushSecret manifest.";
        type = (types.nullOr types.str);
        default = null;
      };
      "selector" = mkOption {
        description = "Selector chooses secrets using a labelSelector.";
        type = (types.nullOr PushSecretSpecSelectorSecretSelectorModule);
        default = null;
      };
    };
  };
  mkPushSecretSpecSelectorSecret =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."selector" != null) {
      "selector" = mkPushSecretSpecSelectorSecretSelector res."selector";
    }
    // {
    };
  PushSecretSpecSelectorSecretSelectorMatchExpressionModule = types.submodule {
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
  mkPushSecretSpecSelectorSecretSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  PushSecretSpecSelectorSecretSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf PushSecretSpecSelectorSecretSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkPushSecretSpecSelectorSecretSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkPushSecretSpecSelectorSecretSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  PushSecretSpecTemplateMetadataModule = types.submodule {
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
  mkPushSecretSpecTemplateMetadata =
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
  PushSecretSpecTemplateModule = types.submodule {
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
        type = (types.nullOr PushSecretSpecTemplateMetadataModule);
        default = null;
      };
      "templateFrom" = mkOption {
        type = (types.listOf PushSecretSpecTemplateTemplateFromModule);
        default = [ ];
      };
      "type" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkPushSecretSpecTemplate =
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
      "metadata" = mkPushSecretSpecTemplateMetadata res."metadata";
    }
    // {
    }
    // optionalAttrs (res."templateFrom" != [ ]) {
      "templateFrom" = map mkPushSecretSpecTemplateTemplateFrom res."templateFrom";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  PushSecretSpecTemplateTemplateFromConfigMapItemModule = types.submodule {
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
  mkPushSecretSpecTemplateTemplateFromConfigMapItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."templateAs" != null) { inherit (res) "templateAs"; }
    // {
    };
  PushSecretSpecTemplateTemplateFromConfigMapModule = types.submodule {
    options = {
      "items" = mkOption {
        description = "A list of keys in the ConfigMap/Secret to use as templates for Secret data";
        type = (types.listOf PushSecretSpecTemplateTemplateFromConfigMapItemModule);
      };
      "name" = mkOption {
        description = "The name of the ConfigMap/Secret resource";
        type = types.str;
      };
    };
  };
  mkPushSecretSpecTemplateTemplateFromConfigMap = res: {
    "items" = map mkPushSecretSpecTemplateTemplateFromConfigMapItem res."items";
    inherit (res) "name";
  };
  PushSecretSpecTemplateTemplateFromModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "TemplateRef specifies a reference to either a ConfigMap or a Secret resource.";
        type = (types.nullOr PushSecretSpecTemplateTemplateFromConfigMapModule);
        default = null;
      };
      "literal" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "secret" = mkOption {
        description = "TemplateRef specifies a reference to either a ConfigMap or a Secret resource.";
        type = (types.nullOr PushSecretSpecTemplateTemplateFromSecretModule);
        default = null;
      };
      "target" = mkOption {
        description = "Target specifies where to place the template result.\nFor Secret resources, common values are: \"Data\", \"Annotations\", \"Labels\".\nFor custom resources (when spec.target.manifest is set), this supports\nnested paths like \"spec.database.config\" or \"data\".";
        type = (types.nullOr types.str);
        default = "Data";
      };
    };
  };
  mkPushSecretSpecTemplateTemplateFrom =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkPushSecretSpecTemplateTemplateFromConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."literal" != null) { inherit (res) "literal"; }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkPushSecretSpecTemplateTemplateFromSecret res."secret";
    }
    // {
    }
    // optionalAttrs (res."target" != null) { inherit (res) "target"; }
    // {
    };
  PushSecretSpecTemplateTemplateFromSecretItemModule = types.submodule {
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
  mkPushSecretSpecTemplateTemplateFromSecretItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."templateAs" != null) { inherit (res) "templateAs"; }
    // {
    };
  PushSecretSpecTemplateTemplateFromSecretModule = types.submodule {
    options = {
      "items" = mkOption {
        description = "A list of keys in the ConfigMap/Secret to use as templates for Secret data";
        type = (types.listOf PushSecretSpecTemplateTemplateFromSecretItemModule);
      };
      "name" = mkOption {
        description = "The name of the ConfigMap/Secret resource";
        type = types.str;
      };
    };
  };
  mkPushSecretSpecTemplateTemplateFromSecret = res: {
    "items" = map mkPushSecretSpecTemplateTemplateFromSecretItem res."items";
    inherit (res) "name";
  };
  ClusterpushsecretsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this ClusterPushSecret resource.";
        };
        "namespaceSelectors" = mkOption {
          description = "A list of labels to select by to find the Namespaces to create the ExternalSecrets in. The selectors are ORed.";
          type = (types.listOf NamespaceSelectorModule);
          default = [ ];
        };
        "pushSecretMetadata" = mkOption {
          description = "The metadata of the external secrets to be created";
          type = (types.nullOr PushSecretMetadataModule);
          default = null;
        };
        "pushSecretName" = mkOption {
          description = "The name of the push secrets to be created.\nDefaults to the name of the ClusterPushSecret";
          type = (types.nullOr types.str);
          default = null;
        };
        "pushSecretSpec" = mkOption {
          description = "PushSecretSpec defines what to do with the secrets.";
          type = PushSecretSpecModule;
        };
        "refreshTime" = mkOption {
          description = "The time in which the controller should reconcile its objects and recheck namespaces for labels.";
          type = (types.nullOr types.str);
          default = null;
        };
      };
    }
  );
  mkClusterPushSecret = name: res: {
    apiVersion = "external-secrets.io/v1alpha1";
    kind = "ClusterPushSecret";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."namespaceSelectors" != [ ]) {
      "namespaceSelectors" = map mkNamespaceSelector res."namespaceSelectors";
    }
    // {
    }
    // optionalAttrs (res."pushSecretMetadata" != null) {
      "pushSecretMetadata" = mkPushSecretMetadata res."pushSecretMetadata";
    }
    // {
    }
    // optionalAttrs (res."pushSecretName" != null) { inherit (res) "pushSecretName"; }
    // {
      "pushSecretSpec" = mkPushSecretSpec res."pushSecretSpec";
    }
    // optionalAttrs (res."refreshTime" != null) { inherit (res) "refreshTime"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkClusterPushSecret cfg."clusterpushsecrets");
in
{
  options.openkrill.apps."external-secrets" = {
    "clusterpushsecrets" = mkOption {
      type = types.attrsOf ClusterpushsecretsModule;
      default = { };
      description = "ClusterPushSecret CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."external-secrets".content = allResources;
  };
}
