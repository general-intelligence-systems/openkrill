# Auto-generated openkrill module fragment for kube-prometheus
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."kube-prometheus";
  compact = filterAttrs (_: v: v != null);
  GroupModule = types.submodule {
    options = {
      "interval" = mkOption {
        description = "Interval determines how often rules in the group are evaluated.";
        type = (types.nullOr types.str);
        default = null;
      };
      "labels" = mkOption {
        description = "Labels to add or overwrite before storing the result for its rules.\nThe labels defined at the rule level take precedence.\n\nIt requires Prometheus >= 3.0.0.\nThe field is ignored for Thanos Ruler.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "limit" = mkOption {
        description = "Limit the number of alerts an alerting rule and series a recording\nrule can produce.\nLimit is supported starting with Prometheus >= 2.31 and Thanos Ruler >= 0.24.";
        type = (types.nullOr types.int);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the rule group.";
        type = types.str;
      };
      "partial_response_strategy" = mkOption {
        description = "PartialResponseStrategy is only used by ThanosRuler and will\nbe ignored by Prometheus instances.\nMore info: https://github.com/thanos-io/thanos/blob/main/docs/components/rule.md#partial-response";
        type = (types.nullOr types.str);
        default = null;
      };
      "query_offset" = mkOption {
        description = "Defines the offset the rule evaluation timestamp of this particular group by the specified duration into the past.\n\nIt requires Prometheus >= v2.53.0.\nIt is not supported for ThanosRuler.";
        type = (types.nullOr types.str);
        default = null;
      };
      "rules" = mkOption {
        description = "List of alerting and recording rules.";
        type = (types.listOf GroupRuleModule);
        default = [ ];
      };
    };
  };
  mkGroup =
    res:
    {
    }
    // optionalAttrs (res."interval" != null) { inherit (res) "interval"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."limit" != null) { inherit (res) "limit"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."partial_response_strategy" != null) {
      inherit (res) "partial_response_strategy";
    }
    // {
    }
    // optionalAttrs (res."query_offset" != null) { inherit (res) "query_offset"; }
    // {
    }
    // optionalAttrs (res."rules" != [ ]) { "rules" = map mkGroupRule res."rules"; }
    // {
    };
  GroupRuleModule = types.submodule {
    options = {
      "alert" = mkOption {
        description = "Name of the alert. Must be a valid label value.\nOnly one of `record` and `alert` must be set.";
        type = (types.nullOr types.str);
        default = null;
      };
      "annotations" = mkOption {
        description = "Annotations to add to each alert.\nOnly valid for alerting rules.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "expr" = mkOption {
        description = "PromQL expression to evaluate.";
        type = types.anything;
      };
      "for" = mkOption {
        description = "Alerts are considered firing once they have been returned for this long.";
        type = (types.nullOr types.str);
        default = null;
      };
      "keep_firing_for" = mkOption {
        description = "KeepFiringFor defines how long an alert will continue firing after the condition that triggered it has cleared.";
        type = (types.nullOr types.str);
        default = null;
      };
      "labels" = mkOption {
        description = "Labels to add or overwrite.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "record" = mkOption {
        description = "Name of the time series to output to. Must be a valid metric name.\nOnly one of `record` and `alert` must be set.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkGroupRule =
    res:
    {
    }
    // optionalAttrs (res."alert" != null) { inherit (res) "alert"; }
    // {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
      inherit (res) "expr";
    }
    // optionalAttrs (res."for" != null) { inherit (res) "for"; }
    // {
    }
    // optionalAttrs (res."keep_firing_for" != null) { inherit (res) "keep_firing_for"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."record" != null) { inherit (res) "record"; }
    // {
    };
  PrometheusrulesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this PrometheusRule resource.";
        };
        "groups" = mkOption {
          description = "Content of Prometheus rule file";
          type = (types.listOf GroupModule);
          default = [ ];
        };
      };
    }
  );
  mkPrometheusRule = name: res: {
    apiVersion = "monitoring.coreos.com/v1";
    kind = "PrometheusRule";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."groups" != [ ]) { "groups" = map mkGroup res."groups"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkPrometheusRule cfg."prometheusrules");
in
{
  options.openkrill.apps."kube-prometheus" = {
    "prometheusrules" = mkOption {
      type = types.attrsOf PrometheusrulesModule;
      default = { };
      description = "PrometheusRule CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."kube-prometheus".content = allResources;
  };
}
