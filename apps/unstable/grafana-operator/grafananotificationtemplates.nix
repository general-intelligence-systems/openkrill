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
  GrafananotificationtemplatesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this GrafanaNotificationTemplate resource.";
        };
        "allowCrossNamespaceImport" = mkOption {
          description = "Allow the Operator to match this resource with Grafanas outside the current namespace";
          type = types.bool;
          default = false;
        };
        "editable" = mkOption {
          description = "Whether to enable or disable editing of the notification template in Grafana UI";
          type = types.bool;
          default = false;
        };
        "instanceSelector" = mkOption {
          description = "Selects Grafana instances for import";
          type = InstanceSelectorModule;
        };
        "name" = mkOption {
          description = "Template name";
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
        "template" = mkOption {
          description = "Template content";
          type = (types.nullOr types.str);
          default = null;
        };
      };
    }
  );
  mkGrafanaNotificationTemplate = name: res: {
    apiVersion = "grafana.integreatly.org/v1beta1";
    kind = "GrafanaNotificationTemplate";
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
      inherit (res) "name";
    }
    // optionalAttrs (res."resyncPeriod" != null) { inherit (res) "resyncPeriod"; }
    // {
    }
    // optionalAttrs res."suspend" { inherit (res) "suspend"; }
    // {
    }
    // optionalAttrs (res."template" != null) { inherit (res) "template"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkGrafanaNotificationTemplate cfg."grafananotificationtemplates");
in
{
  options.openkrill.apps."grafana-operator" = {
    "grafananotificationtemplates" = mkOption {
      type = types.attrsOf GrafananotificationtemplatesModule;
      default = { };
      description = "GrafanaNotificationTemplate CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."grafana-operator".content = allResources;
  };
}
