# Auto-generated openkrill module fragment for grafana-operator
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."grafana-operator";
  compact = filterAttrs (_: v: v != null);
  DatasourceModule = types.submodule {
    options = {
      "access" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "basicAuth" = mkOption {
        type = types.bool;
        default = false;
      };
      "basicAuthUser" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "database" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "editable" = mkOption {
        description = "Whether to enable/disable editing of the datasource in Grafana UI";
        type = types.bool;
        default = false;
      };
      "isDefault" = mkOption {
        type = types.bool;
        default = false;
      };
      "jsonData" = mkOption {
        type = (types.attrsOf types.anything);
        default = { };
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "orgId" = mkOption {
        description = "Deprecated field, it has no effect";
        type = (types.nullOr types.int);
        default = null;
      };
      "secureJsonData" = mkOption {
        type = (types.attrsOf types.anything);
        default = { };
      };
      "type" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "uid" = mkOption {
        description = "Deprecated field, use spec.uid instead";
        type = (types.nullOr types.str);
        default = null;
      };
      "url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "user" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDatasource =
    res:
    {
    }
    // optionalAttrs (res."access" != null) { inherit (res) "access"; }
    // {
    }
    // optionalAttrs res."basicAuth" { inherit (res) "basicAuth"; }
    // {
    }
    // optionalAttrs (res."basicAuthUser" != null) { inherit (res) "basicAuthUser"; }
    // {
    }
    // optionalAttrs (res."database" != null) { inherit (res) "database"; }
    // {
    }
    // optionalAttrs res."editable" { inherit (res) "editable"; }
    // {
    }
    // optionalAttrs res."isDefault" { inherit (res) "isDefault"; }
    // {
    }
    // optionalAttrs (res."jsonData" != { }) { inherit (res) "jsonData"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."orgId" != null) { inherit (res) "orgId"; }
    // {
    }
    // optionalAttrs (res."secureJsonData" != { }) { inherit (res) "secureJsonData"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    }
    // optionalAttrs (res."uid" != null) { inherit (res) "uid"; }
    // {
    }
    // optionalAttrs (res."url" != null) { inherit (res) "url"; }
    // {
    }
    // optionalAttrs (res."user" != null) { inherit (res) "user"; }
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
  ValuesFromModule = types.submodule {
    options = {
      "targetPath" = mkOption {
        type = types.str;
      };
      "valueFrom" = mkOption {
        type = ValuesFromValueFromModule;
      };
    };
  };
  mkValuesFrom = res: {
    inherit (res) "targetPath";
    "valueFrom" = mkValuesFromValueFrom res."valueFrom";
  };
  ValuesFromValueFromConfigMapKeyRefModule = types.submodule {
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
  mkValuesFromValueFromConfigMapKeyRef =
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
  ValuesFromValueFromModule = types.submodule {
    options = {
      "configMapKeyRef" = mkOption {
        description = "Selects a key of a ConfigMap.";
        type = (types.nullOr ValuesFromValueFromConfigMapKeyRefModule);
        default = null;
      };
      "secretKeyRef" = mkOption {
        description = "Selects a key of a Secret.";
        type = (types.nullOr ValuesFromValueFromSecretKeyRefModule);
        default = null;
      };
    };
  };
  mkValuesFromValueFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapKeyRef" != null) {
      "configMapKeyRef" = mkValuesFromValueFromConfigMapKeyRef res."configMapKeyRef";
    }
    // {
    }
    // optionalAttrs (res."secretKeyRef" != null) {
      "secretKeyRef" = mkValuesFromValueFromSecretKeyRef res."secretKeyRef";
    }
    // {
    };
  ValuesFromValueFromSecretKeyRefModule = types.submodule {
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
  mkValuesFromValueFromSecretKeyRef =
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
  GrafanadatasourcesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this GrafanaDatasource resource.";
        };
        "allowCrossNamespaceImport" = mkOption {
          description = "Allow the Operator to match this resource with Grafanas outside the current namespace";
          type = types.bool;
          default = false;
        };
        "datasource" = mkOption {
          type = DatasourceModule;
        };
        "instanceSelector" = mkOption {
          description = "Selects Grafana instances for import";
          type = InstanceSelectorModule;
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
          description = "The UID, for the datasource, fallback to the deprecated spec.datasource.uid\nand metadata.uid. Can be any string consisting of alphanumeric characters,\n- and _ with a maximum length of 40 +optional";
          type = (types.nullOr types.str);
          default = null;
        };
        "valuesFrom" = mkOption {
          description = "environments variables from secrets or config maps";
          type = (types.listOf ValuesFromModule);
          default = [ ];
        };
      };
    }
  );
  mkGrafanaDatasource = name: res: {
    apiVersion = "grafana.integreatly.org/v1beta1";
    kind = "GrafanaDatasource";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs res."allowCrossNamespaceImport" { inherit (res) "allowCrossNamespaceImport"; }
    // {
      "datasource" = mkDatasource res."datasource";
      "instanceSelector" = mkInstanceSelector res."instanceSelector";
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
    // optionalAttrs (res."valuesFrom" != [ ]) { "valuesFrom" = map mkValuesFrom res."valuesFrom"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkGrafanaDatasource cfg."grafanadatasources");
in
{
  options.openkrill.apps."grafana-operator" = {
    "grafanadatasources" = mkOption {
      type = types.attrsOf GrafanadatasourcesModule;
      default = { };
      description = "GrafanaDatasource CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."grafana-operator".content = allResources;
  };
}
