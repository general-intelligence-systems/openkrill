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
  Time_intervalModule = types.submodule {
    options = {
      "days_of_month" = mkOption {
        description = "The date 1-31 of a month. Negative values can also be used to represent days that begin at the end of the month.\nFor example: -1 for the last day of the month.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "location" = mkOption {
        description = "Depending on the location, the time range is displayed in local time.";
        type = (types.nullOr types.str);
        default = null;
      };
      "months" = mkOption {
        description = "The months of the year in either numerical or the full calendar month.\nFor example: 1, may.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "times" = mkOption {
        description = "The time inclusive of the start and exclusive of the end time (in UTC if no location has been selected, otherwise local time).";
        type = (types.listOf Time_intervalTimeModule);
        default = [ ];
      };
      "weekdays" = mkOption {
        description = "The day or range of days of the week.\nFor example: monday, thursday";
        type = (types.listOf types.str);
        default = [ ];
      };
      "years" = mkOption {
        description = "The year or years for the interval.\nFor example: 2021";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkTime_interval =
    res:
    {
    }
    // optionalAttrs (res."days_of_month" != [ ]) { inherit (res) "days_of_month"; }
    // {
    }
    // optionalAttrs (res."location" != null) { inherit (res) "location"; }
    // {
    }
    // optionalAttrs (res."months" != [ ]) { inherit (res) "months"; }
    // {
    }
    // optionalAttrs (res."times" != [ ]) { "times" = map mkTime_intervalTime res."times"; }
    // {
    }
    // optionalAttrs (res."weekdays" != [ ]) { inherit (res) "weekdays"; }
    // {
    }
    // optionalAttrs (res."years" != [ ]) { inherit (res) "years"; }
    // {
    };
  Time_intervalTimeModule = types.submodule {
    options = {
      "end_time" = mkOption {
        description = "end time";
        type = types.str;
      };
      "start_time" = mkOption {
        description = "start time";
        type = types.str;
      };
    };
  };
  mkTime_intervalTime = res: {
    inherit (res) "end_time";
    inherit (res) "start_time";
  };
  GrafanamutetimingsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this GrafanaMuteTiming resource.";
        };
        "allowCrossNamespaceImport" = mkOption {
          description = "Allow the Operator to match this resource with Grafanas outside the current namespace";
          type = types.bool;
          default = false;
        };
        "editable" = mkOption {
          description = "Whether to enable or disable editing of the mute timing in Grafana UI";
          type = types.bool;
          default = true;
        };
        "instanceSelector" = mkOption {
          description = "Selects Grafana instances for import";
          type = InstanceSelectorModule;
        };
        "name" = mkOption {
          description = "A unique name for the mute timing";
          type = types.str;
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
        "time_intervals" = mkOption {
          description = "Time intervals for muting";
          type = (types.listOf Time_intervalModule);
        };
      };
    }
  );
  mkGrafanaMuteTiming = name: res: {
    apiVersion = "grafana.integreatly.org/v1beta1";
    kind = "GrafanaMuteTiming";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs res."allowCrossNamespaceImport" { inherit (res) "allowCrossNamespaceImport"; }
    // {
    }
    // optionalAttrs (res."editable" != null) { inherit (res) "editable"; }
    // {
      "instanceSelector" = mkInstanceSelector res."instanceSelector";
      inherit (res) "name";
    }
    // optionalAttrs (res."resyncPeriod" != null) { inherit (res) "resyncPeriod"; }
    // {
    }
    // optionalAttrs res."suspend" { inherit (res) "suspend"; }
    // {
      "time_intervals" = map mkTime_interval res."time_intervals";
    };
  };
  allResources = (mapAttrsToList mkGrafanaMuteTiming cfg."grafanamutetimings");
in
{
  options.openkrill.apps."grafana-operator" = {
    "grafanamutetimings" = mkOption {
      type = types.attrsOf GrafanamutetimingsModule;
      default = { };
      description = "GrafanaMuteTiming CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."grafana-operator".content = allResources;
  };
}
