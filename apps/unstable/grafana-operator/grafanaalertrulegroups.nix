# Auto-generated openkrill module fragment for grafana-operator
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."grafana-operator";
  compact = filterAttrs (_: v: v != null);
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
  RuleDataModule = types.submodule {
    options = {
      "datasourceUid" = mkOption {
        description = "Grafana data source unique identifier; it should be '__expr__' for a Server Side Expression operation.";
        type = (types.nullOr types.str);
        default = null;
      };
      "model" = mkOption {
        description = "JSON is the raw JSON query and includes the above properties as well as custom properties.";
        type = (types.nullOr types.anything);
        default = null;
      };
      "queryType" = mkOption {
        description = "QueryType is an optional identifier for the type of query.\nIt can be used to distinguish different types of queries.";
        type = (types.nullOr types.str);
        default = null;
      };
      "refId" = mkOption {
        description = "RefID is the unique identifier of the query, set by the frontend call.";
        type = (types.nullOr types.str);
        default = null;
      };
      "relativeTimeRange" = mkOption {
        description = "relative time range";
        type = (types.nullOr RuleDataRelativeTimeRangeModule);
        default = null;
      };
    };
  };
  mkRuleData =
    res:
    {
    }
    // optionalAttrs (res."datasourceUid" != null) { inherit (res) "datasourceUid"; }
    // {
    }
    // optionalAttrs (res."model" != null) { inherit (res) "model"; }
    // {
    }
    // optionalAttrs (res."queryType" != null) { inherit (res) "queryType"; }
    // {
    }
    // optionalAttrs (res."refId" != null) { inherit (res) "refId"; }
    // {
    }
    // optionalAttrs (res."relativeTimeRange" != null) {
      "relativeTimeRange" = mkRuleDataRelativeTimeRange res."relativeTimeRange";
    }
    // {
    };
  RuleDataRelativeTimeRangeModule = types.submodule {
    options = {
      "from" = mkOption {
        description = "from";
        type = (types.nullOr types.int);
        default = null;
      };
      "to" = mkOption {
        description = "to";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkRuleDataRelativeTimeRange =
    res:
    {
    }
    // optionalAttrs (res."from" != null) { inherit (res) "from"; }
    // {
    }
    // optionalAttrs (res."to" != null) { inherit (res) "to"; }
    // {
    };
  RuleModule = types.submodule {
    options = {
      "annotations" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "condition" = mkOption {
        type = types.str;
      };
      "data" = mkOption {
        type = (types.listOf RuleDataModule);
      };
      "execErrState" = mkOption {
        type = (
          types.enum [
            "OK"
            "Alerting"
            "Error"
            "KeepLast"
          ]
        );
      };
      "for" = mkOption {
        type = types.str;
      };
      "isPaused" = mkOption {
        type = types.bool;
        default = false;
      };
      "keepFiringFor" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "labels" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "missingSeriesEvalsToResolve" = mkOption {
        description = "The number of missing series evaluations that must occur before the rule is considered to be resolved.";
        type = (types.nullOr types.int);
        default = null;
      };
      "noDataState" = mkOption {
        type = (
          types.enum [
            "Alerting"
            "NoData"
            "OK"
            "KeepLast"
          ]
        );
      };
      "notificationSettings" = mkOption {
        type = (types.nullOr RuleNotificationSettingsModule);
        default = null;
      };
      "record" = mkOption {
        type = (types.nullOr RuleRecordModule);
        default = null;
      };
      "title" = mkOption {
        type = types.str;
      };
      "uid" = mkOption {
        description = "UID of the alert rule. Can be any string consisting of alphanumeric characters, - and _ with a maximum length of 40";
        type = types.str;
      };
    };
  };
  mkRule =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
      inherit (res) "condition";
      "data" = map mkRuleData res."data";
      inherit (res) "execErrState";
      inherit (res) "for";
    }
    // optionalAttrs res."isPaused" { inherit (res) "isPaused"; }
    // {
    }
    // optionalAttrs (res."keepFiringFor" != null) { inherit (res) "keepFiringFor"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."missingSeriesEvalsToResolve" != null) {
      inherit (res) "missingSeriesEvalsToResolve";
    }
    // {
      inherit (res) "noDataState";
    }
    // optionalAttrs (res."notificationSettings" != null) {
      "notificationSettings" = mkRuleNotificationSettings res."notificationSettings";
    }
    // {
    }
    // optionalAttrs (res."record" != null) { "record" = mkRuleRecord res."record"; }
    // {
      inherit (res) "title";
      inherit (res) "uid";
    };
  RuleNotificationSettingsModule = types.submodule {
    options = {
      "group_by" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "group_interval" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "group_wait" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "mute_time_intervals" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "receiver" = mkOption {
        type = types.str;
      };
      "repeat_interval" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkRuleNotificationSettings =
    res:
    {
    }
    // optionalAttrs (res."group_by" != [ ]) { inherit (res) "group_by"; }
    // {
    }
    // optionalAttrs (res."group_interval" != null) { inherit (res) "group_interval"; }
    // {
    }
    // optionalAttrs (res."group_wait" != null) { inherit (res) "group_wait"; }
    // {
    }
    // optionalAttrs (res."mute_time_intervals" != [ ]) { inherit (res) "mute_time_intervals"; }
    // {
      inherit (res) "receiver";
    }
    // optionalAttrs (res."repeat_interval" != null) { inherit (res) "repeat_interval"; }
    // {
    };
  RuleRecordModule = types.submodule {
    options = {
      "from" = mkOption {
        type = types.str;
      };
      "metric" = mkOption {
        type = types.str;
      };
    };
  };
  mkRuleRecord = res: {
    inherit (res) "from";
    inherit (res) "metric";
  };
  GrafanaalertrulegroupsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this GrafanaAlertRuleGroup resource.";
        };
        "allowCrossNamespaceImport" = mkOption {
          description = "Allow the Operator to match this resource with Grafanas outside the current namespace";
          type = types.bool;
          default = false;
        };
        "editable" = mkOption {
          description = "Whether to enable or disable editing of the alert rule group in Grafana UI";
          type = types.bool;
          default = false;
        };
        "folderRef" = mkOption {
          description = "Match GrafanaFolders CRs to infer the uid";
          type = (types.nullOr types.str);
          default = null;
        };
        "folderUID" = mkOption {
          description = "UID of the folder containing this rule group\nOverrides the FolderSelector";
          type = (types.nullOr types.str);
          default = null;
        };
        "instanceSelector" = mkOption {
          description = "Selects Grafana instances for import";
          type = InstanceSelectorModule;
        };
        "interval" = mkOption {
          type = types.str;
        };
        "name" = mkOption {
          description = "Name of the alert rule group. If not specified, the resource name will be used.";
          type = (types.nullOr types.str);
          default = null;
        };
        "resyncPeriod" = mkOption {
          description = "How often the resource is synced, defaults to 10m0s if not set";
          type = (types.nullOr types.str);
          default = "10m0s";
        };
        "rules" = mkOption {
          type = (types.listOf RuleModule);
        };
        "suspend" = mkOption {
          description = "Suspend pauses synchronizing attempts and tells the operator to ignore changes";
          type = types.bool;
          default = false;
        };
      };
    }
  );
  mkGrafanaAlertRuleGroup = name: res: {
    apiVersion = "grafana.integreatly.org/v1beta1";
    kind = "GrafanaAlertRuleGroup";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs res."allowCrossNamespaceImport" { inherit (res) "allowCrossNamespaceImport"; }
    // {
    }
    // optionalAttrs res."editable" { inherit (res) "editable"; }
    // {
    }
    // optionalAttrs (res."folderRef" != null) { inherit (res) "folderRef"; }
    // {
    }
    // optionalAttrs (res."folderUID" != null) { inherit (res) "folderUID"; }
    // {
      "instanceSelector" = mkInstanceSelector res."instanceSelector";
      inherit (res) "interval";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."resyncPeriod" != null) { inherit (res) "resyncPeriod"; }
    // {
      "rules" = map mkRule res."rules";
    }
    // optionalAttrs res."suspend" { inherit (res) "suspend"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkGrafanaAlertRuleGroup cfg."grafanaalertrulegroups");
in
{
  options.openkrill.apps."grafana-operator" = {
    "grafanaalertrulegroups" = mkOption {
      type = types.attrsOf GrafanaalertrulegroupsModule;
      default = { };
      description = "GrafanaAlertRuleGroup CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."grafana-operator".content = allResources;
  };
}
