# Auto-generated openkrill module fragment for grafana-operator
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."grafana-operator";
  compact = filterAttrs (_: v: v != null);
  ConfigMapRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select.";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "Specify whether the ConfigMap or its key must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkConfigMapRef =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DatasourceModule = types.submodule {
    options = {
      "datasourceName" = mkOption {
        type = types.str;
      };
      "inputName" = mkOption {
        type = types.str;
      };
    };
  };
  mkDatasource = res: {
    inherit (res) "datasourceName";
    inherit (res) "inputName";
  };
  EnvFromConfigMapKeyRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select.";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "Specify whether the ConfigMap or its key must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkEnvFromConfigMapKeyRef =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EnvFromModule = types.submodule {
    options = {
      "configMapKeyRef" = mkOption {
        description = "Selects a key of a ConfigMap.";
        type = (types.nullOr EnvFromConfigMapKeyRefModule);
        default = null;
      };
      "secretKeyRef" = mkOption {
        description = "Selects a key of a Secret.";
        type = (types.nullOr EnvFromSecretKeyRefModule);
        default = null;
      };
    };
  };
  mkEnvFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapKeyRef" != null) {
      "configMapKeyRef" = mkEnvFromConfigMapKeyRef res."configMapKeyRef";
    }
    // {
    }
    // optionalAttrs (res."secretKeyRef" != null) {
      "secretKeyRef" = mkEnvFromSecretKeyRef res."secretKeyRef";
    }
    // {
    };
  EnvFromSecretKeyRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key of the secret to select from.  Must be a valid secret key.";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "Specify whether the Secret or its key must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkEnvFromSecretKeyRef =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EnvModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        description = "Inline env value";
        type = (types.nullOr types.str);
        default = null;
      };
      "valueFrom" = mkOption {
        description = "Reference on value source, might be the reference on a secret or config map";
        type = (types.nullOr EnvValueFromModule);
        default = null;
      };
    };
  };
  mkEnv =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    }
    // optionalAttrs (res."valueFrom" != null) { "valueFrom" = mkEnvValueFrom res."valueFrom"; }
    // {
    };
  EnvValueFromConfigMapKeyRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select.";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "Specify whether the ConfigMap or its key must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkEnvValueFromConfigMapKeyRef =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EnvValueFromModule = types.submodule {
    options = {
      "configMapKeyRef" = mkOption {
        description = "Selects a key of a ConfigMap.";
        type = (types.nullOr EnvValueFromConfigMapKeyRefModule);
        default = null;
      };
      "secretKeyRef" = mkOption {
        description = "Selects a key of a Secret.";
        type = (types.nullOr EnvValueFromSecretKeyRefModule);
        default = null;
      };
    };
  };
  mkEnvValueFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapKeyRef" != null) {
      "configMapKeyRef" = mkEnvValueFromConfigMapKeyRef res."configMapKeyRef";
    }
    // {
    }
    // optionalAttrs (res."secretKeyRef" != null) {
      "secretKeyRef" = mkEnvValueFromSecretKeyRef res."secretKeyRef";
    }
    // {
    };
  EnvValueFromSecretKeyRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key of the secret to select from.  Must be a valid secret key.";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "Specify whether the Secret or its key must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkEnvValueFromSecretKeyRef =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  GrafanaComModule = types.submodule {
    options = {
      "id" = mkOption {
        type = types.int;
      };
      "revision" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkGrafanaCom =
    res:
    {
      inherit (res) "id";
    }
    // optionalAttrs (res."revision" != null) { inherit (res) "revision"; }
    // {
    };
  InstanceSelectorMatchExpressionModule = types.submodule {
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
  mkInstanceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  InstanceSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf InstanceSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkInstanceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkInstanceSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  JsonnetLibModule = types.submodule {
    options = {
      "fileName" = mkOption {
        type = types.str;
      };
      "gzipJsonnetProject" = mkOption {
        type = types.str;
      };
      "jPath" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkJsonnetLib =
    res:
    {
      inherit (res) "fileName";
      inherit (res) "gzipJsonnetProject";
    }
    // optionalAttrs (res."jPath" != [ ]) { inherit (res) "jPath"; }
    // {
    };
  PluginModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "version" = mkOption {
        type = types.str;
      };
    };
  };
  mkPlugin = res: {
    inherit (res) "name";
    inherit (res) "version";
  };
  UrlAuthorizationBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "SecretKeySelector selects a key of a Secret.";
        type = (types.nullOr UrlAuthorizationBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "SecretKeySelector selects a key of a Secret.";
        type = (types.nullOr UrlAuthorizationBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkUrlAuthorizationBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkUrlAuthorizationBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkUrlAuthorizationBasicAuthUsername res."username";
    }
    // {
    };
  UrlAuthorizationBasicAuthPasswordModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key of the secret to select from.  Must be a valid secret key.";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "Specify whether the Secret or its key must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkUrlAuthorizationBasicAuthPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  UrlAuthorizationBasicAuthUsernameModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key of the secret to select from.  Must be a valid secret key.";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "Specify whether the Secret or its key must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkUrlAuthorizationBasicAuthUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  UrlAuthorizationModule = types.submodule {
    options = {
      "basicAuth" = mkOption {
        type = (types.nullOr UrlAuthorizationBasicAuthModule);
        default = null;
      };
    };
  };
  mkUrlAuthorization =
    res:
    {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkUrlAuthorizationBasicAuth res."basicAuth";
    }
    // {
    };
  GrafanalibrarypanelsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this GrafanaLibraryPanel resource.";
        };
        "allowCrossNamespaceImport" = mkOption {
          description = "Allow the Operator to match this resource with Grafanas outside the current namespace";
          type = types.bool;
          default = false;
        };
        "configMapRef" = mkOption {
          description = "model from configmap";
          type = (types.nullOr ConfigMapRefModule);
          default = null;
        };
        "contentCacheDuration" = mkOption {
          description = "Cache duration for models fetched from URLs";
          type = (types.nullOr types.str);
          default = null;
        };
        "datasources" = mkOption {
          description = "maps required data sources to existing ones";
          type = (types.listOf DatasourceModule);
          default = [ ];
        };
        "envFrom" = mkOption {
          description = "environments variables from secrets or config maps";
          type = (types.listOf EnvFromModule);
          default = [ ];
        };
        "envs" = mkOption {
          description = "environments variables as a map";
          type = (types.listOf EnvModule);
          default = [ ];
        };
        "folderRef" = mkOption {
          description = "Name of a `GrafanaFolder` resource in the same namespace";
          type = (types.nullOr types.str);
          default = null;
        };
        "folderUID" = mkOption {
          description = "UID of the target folder for this dashboard";
          type = (types.nullOr types.str);
          default = null;
        };
        "grafanaCom" = mkOption {
          description = "grafana.com/dashboards";
          type = (types.nullOr GrafanaComModule);
          default = null;
        };
        "gzipJson" = mkOption {
          description = "GzipJson the model's JSON compressed with Gzip. Base64-encoded when in YAML.";
          type = (types.nullOr types.str);
          default = null;
        };
        "instanceSelector" = mkOption {
          description = "Selects Grafana instances for import";
          type = InstanceSelectorModule;
        };
        "json" = mkOption {
          description = "model json";
          type = (types.nullOr types.str);
          default = null;
        };
        "jsonnet" = mkOption {
          description = "Jsonnet";
          type = (types.nullOr types.str);
          default = null;
        };
        "jsonnetLib" = mkOption {
          description = "Jsonnet project build";
          type = (types.nullOr JsonnetLibModule);
          default = null;
        };
        "plugins" = mkOption {
          description = "plugins";
          type = (types.listOf PluginModule);
          default = [ ];
        };
        "resyncPeriod" = mkOption {
          description = "How often the resource is synced, defaults to 10m0s if not set";
          type = (types.nullOr types.str);
          default = "10m0s";
        };
        "suspend" = mkOption {
          description = "Suspend pauses synchronizing attempts and tells the operator to ignore changes";
          type = types.bool;
          default = false;
        };
        "uid" = mkOption {
          description = "Manually specify the uid, overwrites uids already present in the json model.\nCan be any string consisting of alphanumeric characters, - and _ with a maximum length of 40.";
          type = (types.nullOr types.str);
          default = null;
        };
        "url" = mkOption {
          description = "model url";
          type = (types.nullOr types.str);
          default = null;
        };
        "urlAuthorization" = mkOption {
          description = "authorization options for model from url";
          type = (types.nullOr UrlAuthorizationModule);
          default = null;
        };
      };
    }
  );
  mkGrafanaLibraryPanel = name: res: {
    apiVersion = "grafana.integreatly.org/v1beta1";
    kind = "GrafanaLibraryPanel";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs res."allowCrossNamespaceImport" { inherit (res) "allowCrossNamespaceImport"; }
    // {
    }
    // optionalAttrs (res."configMapRef" != null) {
      "configMapRef" = mkConfigMapRef res."configMapRef";
    }
    // {
    }
    // optionalAttrs (res."contentCacheDuration" != null) { inherit (res) "contentCacheDuration"; }
    // {
    }
    // optionalAttrs (res."datasources" != [ ]) { "datasources" = map mkDatasource res."datasources"; }
    // {
    }
    // optionalAttrs (res."envFrom" != [ ]) { "envFrom" = map mkEnvFrom res."envFrom"; }
    // {
    }
    // optionalAttrs (res."envs" != [ ]) { "envs" = map mkEnv res."envs"; }
    // {
    }
    // optionalAttrs (res."folderRef" != null) { inherit (res) "folderRef"; }
    // {
    }
    // optionalAttrs (res."folderUID" != null) { inherit (res) "folderUID"; }
    // {
    }
    // optionalAttrs (res."grafanaCom" != null) { "grafanaCom" = mkGrafanaCom res."grafanaCom"; }
    // {
    }
    // optionalAttrs (res."gzipJson" != null) { inherit (res) "gzipJson"; }
    // {
      "instanceSelector" = mkInstanceSelector res."instanceSelector";
    }
    // optionalAttrs (res."json" != null) { inherit (res) "json"; }
    // {
    }
    // optionalAttrs (res."jsonnet" != null) { inherit (res) "jsonnet"; }
    // {
    }
    // optionalAttrs (res."jsonnetLib" != null) { "jsonnetLib" = mkJsonnetLib res."jsonnetLib"; }
    // {
    }
    // optionalAttrs (res."plugins" != [ ]) { "plugins" = map mkPlugin res."plugins"; }
    // {
    }
    // optionalAttrs (res."resyncPeriod" != null) { inherit (res) "resyncPeriod"; }
    // {
    }
    // optionalAttrs res."suspend" { inherit (res) "suspend"; }
    // {
    }
    // optionalAttrs (res."uid" != null) { inherit (res) "uid"; }
    // {
    }
    // optionalAttrs (res."url" != null) { inherit (res) "url"; }
    // {
    }
    // optionalAttrs (res."urlAuthorization" != null) {
      "urlAuthorization" = mkUrlAuthorization res."urlAuthorization";
    }
    // {
    };
  };
  allResources = (mapAttrsToList mkGrafanaLibraryPanel cfg."grafanalibrarypanels");
in
{
  options.openkrill.apps."grafana-operator" = {
    "grafanalibrarypanels" = mkOption {
      type = types.attrsOf GrafanalibrarypanelsModule;
      default = { };
      description = "GrafanaLibraryPanel CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."grafana-operator".content = allResources;
  };
}
