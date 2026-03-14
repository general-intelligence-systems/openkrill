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
  GrafanafoldersModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this GrafanaFolder resource.";
        };
        "allowCrossNamespaceImport" = mkOption {
          description = "Allow the Operator to match this resource with Grafanas outside the current namespace";
          type = types.bool;
          default = false;
        };
        "instanceSelector" = mkOption {
          description = "Selects Grafana instances for import";
          type = InstanceSelectorModule;
        };
        "parentFolderRef" = mkOption {
          description = "Reference to an existing GrafanaFolder CR in the same namespace";
          type = (types.nullOr types.str);
          default = null;
        };
        "parentFolderUID" = mkOption {
          description = "UID of the folder in which the current folder should be created";
          type = (types.nullOr types.str);
          default = null;
        };
        "permissions" = mkOption {
          description = "Raw json with folder permissions, potentially exported from Grafana";
          type = (types.nullOr types.str);
          default = null;
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
        "title" = mkOption {
          description = "Display name of the folder in Grafana";
          type = (types.nullOr types.str);
          default = null;
        };
        "uid" = mkOption {
          description = "Manually specify the UID the Folder is created with. Can be any string consisting of alphanumeric characters, - and _ with a maximum length of 40";
          type = (types.nullOr types.str);
          default = null;
        };
      };
    }
  );
  mkGrafanaFolder = name: res: {
    apiVersion = "grafana.integreatly.org/v1beta1";
    kind = "GrafanaFolder";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs res."allowCrossNamespaceImport" { inherit (res) "allowCrossNamespaceImport"; }
    // {
      "instanceSelector" = mkInstanceSelector res."instanceSelector";
    }
    // optionalAttrs (res."parentFolderRef" != null) { inherit (res) "parentFolderRef"; }
    // {
    }
    // optionalAttrs (res."parentFolderUID" != null) { inherit (res) "parentFolderUID"; }
    // {
    }
    // optionalAttrs (res."permissions" != null) { inherit (res) "permissions"; }
    // {
    }
    // optionalAttrs (res."resyncPeriod" != null) { inherit (res) "resyncPeriod"; }
    // {
    }
    // optionalAttrs res."suspend" { inherit (res) "suspend"; }
    // {
    }
    // optionalAttrs (res."title" != null) { inherit (res) "title"; }
    // {
    }
    // optionalAttrs (res."uid" != null) { inherit (res) "uid"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkGrafanaFolder cfg."grafanafolders");
in
{
  options.openkrill.apps."grafana-operator" = {
    "grafanafolders" = mkOption {
      type = types.attrsOf GrafanafoldersModule;
      default = { };
      description = "GrafanaFolder CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."grafana-operator".content = allResources;
  };
}
