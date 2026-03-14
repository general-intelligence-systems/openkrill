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
  RouteMatcherModule = types.submodule {
    options = {
      "isEqual" = mkOption {
        description = "is equal";
        type = types.bool;
        default = false;
      };
      "isRegex" = mkOption {
        description = "is regex";
        type = types.bool;
      };
      "name" = mkOption {
        description = "name";
        type = (types.nullOr types.str);
        default = null;
      };
      "value" = mkOption {
        description = "value";
        type = types.str;
      };
    };
  };
  mkRouteMatcher =
    res:
    {
    }
    // optionalAttrs res."isEqual" { inherit (res) "isEqual"; }
    // {
      inherit (res) "isRegex";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
      inherit (res) "value";
    };
  RouteModule = types.submodule {
    options = {
      "continue" = mkOption {
        description = "continue";
        type = types.bool;
        default = false;
      };
      "group_by" = mkOption {
        description = "group by";
        type = (types.listOf types.str);
        default = [ ];
      };
      "group_interval" = mkOption {
        description = "group interval";
        type = (types.nullOr types.str);
        default = null;
      };
      "group_wait" = mkOption {
        description = "group wait";
        type = (types.nullOr types.str);
        default = null;
      };
      "match_re" = mkOption {
        description = "match re";
        type = (types.attrsOf types.str);
        default = { };
      };
      "matchers" = mkOption {
        description = "matchers";
        type = (types.listOf RouteMatcherModule);
        default = [ ];
      };
      "mute_time_intervals" = mkOption {
        description = "mute time intervals";
        type = (types.listOf types.str);
        default = [ ];
      };
      "object_matchers" = mkOption {
        description = "object matchers";
        type = (types.listOf (types.listOf types.str));
        default = [ ];
      };
      "provenance" = mkOption {
        description = "provenance";
        type = (types.nullOr types.str);
        default = null;
      };
      "receiver" = mkOption {
        description = "receiver";
        type = types.str;
      };
      "repeat_interval" = mkOption {
        description = "repeat interval";
        type = (types.nullOr types.str);
        default = null;
      };
      "routeSelector" = mkOption {
        description = "selects GrafanaNotificationPolicyRoutes to merge in when specified\nmutually exclusive with Routes";
        type = (types.nullOr RouteRouteSelectorModule);
        default = null;
      };
      "routes" = mkOption {
        description = "routes, mutually exclusive with RouteSelector";
        type = (types.nullOr types.anything);
        default = null;
      };
    };
  };
  mkRoute =
    res:
    {
    }
    // optionalAttrs res."continue" { inherit (res) "continue"; }
    // {
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
    // optionalAttrs (res."match_re" != { }) { inherit (res) "match_re"; }
    // {
    }
    // optionalAttrs (res."matchers" != [ ]) { "matchers" = map mkRouteMatcher res."matchers"; }
    // {
    }
    // optionalAttrs (res."mute_time_intervals" != [ ]) { inherit (res) "mute_time_intervals"; }
    // {
    }
    // optionalAttrs (res."object_matchers" != [ ]) { inherit (res) "object_matchers"; }
    // {
    }
    // optionalAttrs (res."provenance" != null) { inherit (res) "provenance"; }
    // {
      inherit (res) "receiver";
    }
    // optionalAttrs (res."repeat_interval" != null) { inherit (res) "repeat_interval"; }
    // {
    }
    // optionalAttrs (res."routeSelector" != null) {
      "routeSelector" = mkRouteRouteSelector res."routeSelector";
    }
    // {
    }
    // optionalAttrs (res."routes" != null) { inherit (res) "routes"; }
    // {
    };
  RouteRouteSelectorMatchExpressionModule = types.submodule {
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
  mkRouteRouteSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  RouteRouteSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf RouteRouteSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkRouteRouteSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkRouteRouteSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  GrafananotificationpoliciesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this GrafanaNotificationPolicy resource.";
        };
        "allowCrossNamespaceImport" = mkOption {
          description = "Allow the Operator to match this resource with Grafanas outside the current namespace";
          type = types.bool;
          default = false;
        };
        "editable" = mkOption {
          description = "Whether to enable or disable editing of the notification policy in Grafana UI";
          type = types.bool;
          default = false;
        };
        "instanceSelector" = mkOption {
          description = "Selects Grafana instances for import";
          type = InstanceSelectorModule;
        };
        "resyncPeriod" = mkOption {
          description = "How often the resource is synced, defaults to 10m0s if not set";
          type = (types.nullOr types.str);
          default = "10m0s";
        };
        "route" = mkOption {
          description = "Routes for alerts to match against";
          type = RouteModule;
        };
        "suspend" = mkOption {
          description = "Suspend pauses synchronizing attempts and tells the operator to ignore changes";
          type = types.bool;
          default = false;
        };
      };
    }
  );
  mkGrafanaNotificationPolicy = name: res: {
    apiVersion = "grafana.integreatly.org/v1beta1";
    kind = "GrafanaNotificationPolicy";
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
      "instanceSelector" = mkInstanceSelector res."instanceSelector";
    }
    // optionalAttrs (res."resyncPeriod" != null) { inherit (res) "resyncPeriod"; }
    // {
      "route" = mkRoute res."route";
    }
    // optionalAttrs res."suspend" { inherit (res) "suspend"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkGrafanaNotificationPolicy cfg."grafananotificationpolicies");
in
{
  options.openkrill.apps."grafana-operator" = {
    "grafananotificationpolicies" = mkOption {
      type = types.attrsOf GrafananotificationpoliciesModule;
      default = { };
      description = "GrafanaNotificationPolicy CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."grafana-operator".content = allResources;
  };
}
