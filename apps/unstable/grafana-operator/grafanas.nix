# Auto-generated openkrill module fragment for grafana-operator
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."grafana-operator";
  compact = filterAttrs (_: v: v != null);
  ClientModule = types.submodule {
    options = {
      "headers" = mkOption {
        description = "Custom HTTP headers to use when interacting with this Grafana.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "preferIngress" = mkOption {
        description = "If the operator should send it's request through the grafana instances ingress object instead of through the service.";
        type = types.bool;
        default = false;
      };
      "timeout" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "tls" = mkOption {
        description = "TLS Configuration used to talk with the grafana instance.";
        type = (types.nullOr ClientTlsModule);
        default = null;
      };
    };
  };
  mkClient =
    res:
    {
    }
    // optionalAttrs (res."headers" != { }) { inherit (res) "headers"; }
    // {
    }
    // optionalAttrs res."preferIngress" { inherit (res) "preferIngress"; }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    }
    // optionalAttrs (res."tls" != null) { "tls" = mkClientTls res."tls"; }
    // {
    };
  ClientTlsCertSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "name is unique within a namespace to reference a secret resource.";
        type = (types.nullOr types.str);
        default = null;
      };
      "namespace" = mkOption {
        description = "namespace defines the space within which the secret name must be unique.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkClientTlsCertSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  ClientTlsModule = types.submodule {
    options = {
      "certSecretRef" = mkOption {
        description = "Use a secret as a reference to give TLS Certificate information";
        type = (types.nullOr ClientTlsCertSecretRefModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable the CA check of the server";
        type = types.bool;
        default = false;
      };
    };
  };
  mkClientTls =
    res:
    {
    }
    // optionalAttrs (res."certSecretRef" != null) {
      "certSecretRef" = mkClientTlsCertSecretRef res."certSecretRef";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    };
  DeploymentMetadataModule = types.submodule {
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
  mkDeploymentMetadata =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    };
  DeploymentModule = types.submodule {
    options = {
      "metadata" = mkOption {
        type = (types.nullOr DeploymentMetadataModule);
        default = null;
      };
      "spec" = mkOption {
        type = (types.nullOr DeploymentSpecModule);
        default = null;
      };
    };
  };
  mkDeployment =
    res:
    {
    }
    // optionalAttrs (res."metadata" != null) { "metadata" = mkDeploymentMetadata res."metadata"; }
    // {
    }
    // optionalAttrs (res."spec" != null) { "spec" = mkDeploymentSpec res."spec"; }
    // {
    };
  DeploymentSpecModule = types.submodule {
    options = {
      "minReadySeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "paused" = mkOption {
        type = types.bool;
        default = false;
      };
      "progressDeadlineSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "replicas" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "revisionHistoryLimit" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "selector" = mkOption {
        type = (types.nullOr DeploymentSpecSelectorModule);
        default = null;
      };
      "strategy" = mkOption {
        type = (types.nullOr DeploymentSpecStrategyModule);
        default = null;
      };
      "template" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateModule);
        default = null;
      };
    };
  };
  mkDeploymentSpec =
    res:
    {
    }
    // optionalAttrs (res."minReadySeconds" != null) { inherit (res) "minReadySeconds"; }
    // {
    }
    // optionalAttrs res."paused" { inherit (res) "paused"; }
    // {
    }
    // optionalAttrs (res."progressDeadlineSeconds" != null) {
      inherit (res) "progressDeadlineSeconds";
    }
    // {
    }
    // optionalAttrs (res."replicas" != null) { inherit (res) "replicas"; }
    // {
    }
    // optionalAttrs (res."revisionHistoryLimit" != null) { inherit (res) "revisionHistoryLimit"; }
    // {
    }
    // optionalAttrs (res."selector" != null) { "selector" = mkDeploymentSpecSelector res."selector"; }
    // {
    }
    // optionalAttrs (res."strategy" != null) { "strategy" = mkDeploymentSpecStrategy res."strategy"; }
    // {
    }
    // optionalAttrs (res."template" != null) { "template" = mkDeploymentSpecTemplate res."template"; }
    // {
    };
  DeploymentSpecSelectorMatchExpressionModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "operator" = mkOption {
        type = types.str;
      };
      "values" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkDeploymentSpecSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  DeploymentSpecSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        type = (types.listOf DeploymentSpecSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkDeploymentSpecSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkDeploymentSpecSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  DeploymentSpecStrategyModule = types.submodule {
    options = {
      "rollingUpdate" = mkOption {
        type = (types.nullOr DeploymentSpecStrategyRollingUpdateModule);
        default = null;
      };
      "type" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecStrategy =
    res:
    {
    }
    // optionalAttrs (res."rollingUpdate" != null) {
      "rollingUpdate" = mkDeploymentSpecStrategyRollingUpdate res."rollingUpdate";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  DeploymentSpecStrategyRollingUpdateModule = types.submodule {
    options = {
      "maxSurge" = mkOption {
        type = types.anything;
        default = { };
      };
      "maxUnavailable" = mkOption {
        type = types.anything;
        default = { };
      };
    };
  };
  mkDeploymentSpecStrategyRollingUpdate =
    res:
    {
    }
    // optionalAttrs (res."maxSurge" != null) { inherit (res) "maxSurge"; }
    // {
    }
    // optionalAttrs (res."maxUnavailable" != null) { inherit (res) "maxUnavailable"; }
    // {
    };
  DeploymentSpecTemplateMetadataModule = types.submodule {
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
  mkDeploymentSpecTemplateMetadata =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    };
  DeploymentSpecTemplateModule = types.submodule {
    options = {
      "metadata" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateMetadataModule);
        default = null;
      };
      "spec" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecModule);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplate =
    res:
    {
    }
    // optionalAttrs (res."metadata" != null) {
      "metadata" = mkDeploymentSpecTemplateMetadata res."metadata";
    }
    // {
    }
    // optionalAttrs (res."spec" != null) { "spec" = mkDeploymentSpecTemplateSpec res."spec"; }
    // {
    };
  DeploymentSpecTemplateSpecAffinityModule = types.submodule {
    options = {
      "nodeAffinity" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecAffinityNodeAffinityModule);
        default = null;
      };
      "podAffinity" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecAffinityPodAffinityModule);
        default = null;
      };
      "podAntiAffinity" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecAffinityPodAntiAffinityModule);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecAffinity =
    res:
    {
    }
    // optionalAttrs (res."nodeAffinity" != null) {
      "nodeAffinity" = mkDeploymentSpecTemplateSpecAffinityNodeAffinity res."nodeAffinity";
    }
    // {
    }
    // optionalAttrs (res."podAffinity" != null) {
      "podAffinity" = mkDeploymentSpecTemplateSpecAffinityPodAffinity res."podAffinity";
    }
    // {
    }
    // optionalAttrs (res."podAntiAffinity" != null) {
      "podAntiAffinity" = mkDeploymentSpecTemplateSpecAffinityPodAntiAffinity res."podAntiAffinity";
    }
    // {
    };
  DeploymentSpecTemplateSpecAffinityNodeAffinityModule = types.submodule {
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        type = (
          types.listOf DeploymentSpecTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        type = (
          types.nullOr DeploymentSpecTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecAffinityNodeAffinity =
    res:
    {
    }
    // optionalAttrs (res."preferredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "preferredDuringSchedulingIgnoredDuringExecution" =
        map mkDeploymentSpecTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecution
          res."preferredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    }
    // optionalAttrs (res."requiredDuringSchedulingIgnoredDuringExecution" != null) {
      "requiredDuringSchedulingIgnoredDuringExecution" =
        mkDeploymentSpecTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecution
          res."requiredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    };
  DeploymentSpecTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "preference" = mkOption {
            type =
              DeploymentSpecTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceModule;
          };
          "weight" = mkOption {
            type = types.int;
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecution =
    res: {
      "preference" =
        mkDeploymentSpecTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreference
          res."preference";
      inherit (res) "weight";
    };
  DeploymentSpecTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            type = types.str;
          };
          "operator" = mkOption {
            type = types.str;
          };
          "values" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  DeploymentSpecTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchFieldModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            type = types.str;
          };
          "operator" = mkOption {
            type = types.str;
          };
          "values" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchField =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  DeploymentSpecTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            type = (
              types.listOf DeploymentSpecTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpressionModule
            );
            default = [ ];
          };
          "matchFields" = mkOption {
            type = (
              types.listOf DeploymentSpecTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchFieldModule
            );
            default = [ ];
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreference =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkDeploymentSpecTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchFields" != [ ]) {
      "matchFields" =
        map
          mkDeploymentSpecTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchField
          res."matchFields";
    }
    // {
    };
  DeploymentSpecTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "nodeSelectorTerms" = mkOption {
            type = (
              types.listOf DeploymentSpecTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermModule
            );
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecution =
    res: {
      "nodeSelectorTerms" =
        map
          mkDeploymentSpecTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTerm
          res."nodeSelectorTerms";
    };
  DeploymentSpecTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            type = types.str;
          };
          "operator" = mkOption {
            type = types.str;
          };
          "values" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  DeploymentSpecTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchFieldModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            type = types.str;
          };
          "operator" = mkOption {
            type = types.str;
          };
          "values" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchField =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  DeploymentSpecTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            type = (
              types.listOf DeploymentSpecTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpressionModule
            );
            default = [ ];
          };
          "matchFields" = mkOption {
            type = (
              types.listOf DeploymentSpecTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchFieldModule
            );
            default = [ ];
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTerm =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkDeploymentSpecTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchFields" != [ ]) {
      "matchFields" =
        map
          mkDeploymentSpecTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchField
          res."matchFields";
    }
    // {
    };
  DeploymentSpecTemplateSpecAffinityPodAffinityModule = types.submodule {
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        type = (
          types.listOf DeploymentSpecTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        type = (
          types.listOf DeploymentSpecTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpecAffinityPodAffinity =
    res:
    {
    }
    // optionalAttrs (res."preferredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "preferredDuringSchedulingIgnoredDuringExecution" =
        map mkDeploymentSpecTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecution
          res."preferredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    }
    // optionalAttrs (res."requiredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "requiredDuringSchedulingIgnoredDuringExecution" =
        map mkDeploymentSpecTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecution
          res."requiredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    };
  DeploymentSpecTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "podAffinityTerm" = mkOption {
            type =
              DeploymentSpecTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule;
          };
          "weight" = mkOption {
            type = types.int;
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecution =
    res: {
      "podAffinityTerm" =
        mkDeploymentSpecTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm
          res."podAffinityTerm";
      inherit (res) "weight";
    };
  DeploymentSpecTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            type = types.str;
          };
          "operator" = mkOption {
            type = types.str;
          };
          "values" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  DeploymentSpecTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            type = (
              types.listOf DeploymentSpecTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkDeploymentSpecTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  DeploymentSpecTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            type = (
              types.nullOr DeploymentSpecTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule
            );
            default = null;
          };
          "matchLabelKeys" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
          "mismatchLabelKeys" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
          "namespaceSelector" = mkOption {
            type = (
              types.nullOr DeploymentSpecTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule
            );
            default = null;
          };
          "namespaces" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            type = types.str;
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkDeploymentSpecTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."matchLabelKeys" != [ ]) { inherit (res) "matchLabelKeys"; }
    // {
    }
    // optionalAttrs (res."mismatchLabelKeys" != [ ]) { inherit (res) "mismatchLabelKeys"; }
    // {
    }
    // optionalAttrs (res."namespaceSelector" != null) {
      "namespaceSelector" =
        mkDeploymentSpecTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  DeploymentSpecTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            type = types.str;
          };
          "operator" = mkOption {
            type = types.str;
          };
          "values" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  DeploymentSpecTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            type = (
              types.listOf DeploymentSpecTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkDeploymentSpecTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  DeploymentSpecTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            type = types.str;
          };
          "operator" = mkOption {
            type = types.str;
          };
          "values" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  DeploymentSpecTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            type = (
              types.listOf DeploymentSpecTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkDeploymentSpecTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  DeploymentSpecTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            type = (
              types.nullOr DeploymentSpecTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule
            );
            default = null;
          };
          "matchLabelKeys" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
          "mismatchLabelKeys" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
          "namespaceSelector" = mkOption {
            type = (
              types.nullOr DeploymentSpecTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule
            );
            default = null;
          };
          "namespaces" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            type = types.str;
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecution =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkDeploymentSpecTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."matchLabelKeys" != [ ]) { inherit (res) "matchLabelKeys"; }
    // {
    }
    // optionalAttrs (res."mismatchLabelKeys" != [ ]) { inherit (res) "mismatchLabelKeys"; }
    // {
    }
    // optionalAttrs (res."namespaceSelector" != null) {
      "namespaceSelector" =
        mkDeploymentSpecTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  DeploymentSpecTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            type = types.str;
          };
          "operator" = mkOption {
            type = types.str;
          };
          "values" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  DeploymentSpecTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            type = (
              types.listOf DeploymentSpecTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkDeploymentSpecTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  DeploymentSpecTemplateSpecAffinityPodAntiAffinityModule = types.submodule {
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        type = (
          types.listOf DeploymentSpecTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        type = (
          types.listOf DeploymentSpecTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpecAffinityPodAntiAffinity =
    res:
    {
    }
    // optionalAttrs (res."preferredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "preferredDuringSchedulingIgnoredDuringExecution" =
        map
          mkDeploymentSpecTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecution
          res."preferredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    }
    // optionalAttrs (res."requiredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "requiredDuringSchedulingIgnoredDuringExecution" =
        map
          mkDeploymentSpecTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecution
          res."requiredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    };
  DeploymentSpecTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "podAffinityTerm" = mkOption {
            type =
              DeploymentSpecTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule;
          };
          "weight" = mkOption {
            type = types.int;
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecution =
    res: {
      "podAffinityTerm" =
        mkDeploymentSpecTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm
          res."podAffinityTerm";
      inherit (res) "weight";
    };
  DeploymentSpecTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            type = types.str;
          };
          "operator" = mkOption {
            type = types.str;
          };
          "values" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  DeploymentSpecTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            type = (
              types.listOf DeploymentSpecTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkDeploymentSpecTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  DeploymentSpecTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            type = (
              types.nullOr DeploymentSpecTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule
            );
            default = null;
          };
          "matchLabelKeys" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
          "mismatchLabelKeys" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
          "namespaceSelector" = mkOption {
            type = (
              types.nullOr DeploymentSpecTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule
            );
            default = null;
          };
          "namespaces" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            type = types.str;
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkDeploymentSpecTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."matchLabelKeys" != [ ]) { inherit (res) "matchLabelKeys"; }
    // {
    }
    // optionalAttrs (res."mismatchLabelKeys" != [ ]) { inherit (res) "mismatchLabelKeys"; }
    // {
    }
    // optionalAttrs (res."namespaceSelector" != null) {
      "namespaceSelector" =
        mkDeploymentSpecTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  DeploymentSpecTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            type = types.str;
          };
          "operator" = mkOption {
            type = types.str;
          };
          "values" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  DeploymentSpecTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            type = (
              types.listOf DeploymentSpecTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkDeploymentSpecTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  DeploymentSpecTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            type = types.str;
          };
          "operator" = mkOption {
            type = types.str;
          };
          "values" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  DeploymentSpecTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            type = (
              types.listOf DeploymentSpecTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkDeploymentSpecTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  DeploymentSpecTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            type = (
              types.nullOr DeploymentSpecTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule
            );
            default = null;
          };
          "matchLabelKeys" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
          "mismatchLabelKeys" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
          "namespaceSelector" = mkOption {
            type = (
              types.nullOr DeploymentSpecTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule
            );
            default = null;
          };
          "namespaces" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            type = types.str;
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecution =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkDeploymentSpecTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."matchLabelKeys" != [ ]) { inherit (res) "matchLabelKeys"; }
    // {
    }
    // optionalAttrs (res."mismatchLabelKeys" != [ ]) { inherit (res) "mismatchLabelKeys"; }
    // {
    }
    // optionalAttrs (res."namespaceSelector" != null) {
      "namespaceSelector" =
        mkDeploymentSpecTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  DeploymentSpecTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            type = types.str;
          };
          "operator" = mkOption {
            type = types.str;
          };
          "values" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  DeploymentSpecTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            type = (
              types.listOf DeploymentSpecTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkDeploymentSpecTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkDeploymentSpecTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerEnvFromConfigMapRefModule = types.submodule {
    options = {
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerEnvFromConfigMapRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerEnvFromModule = types.submodule {
    options = {
      "configMapRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerEnvFromConfigMapRefModule);
        default = null;
      };
      "prefix" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "secretRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerEnvFromSecretRefModule);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerEnvFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapRef" != null) {
      "configMapRef" = mkDeploymentSpecTemplateSpecContainerEnvFromConfigMapRef res."configMapRef";
    }
    // {
    }
    // optionalAttrs (res."prefix" != null) { inherit (res) "prefix"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkDeploymentSpecTemplateSpecContainerEnvFromSecretRef res."secretRef";
    }
    // {
    };
  DeploymentSpecTemplateSpecContainerEnvFromSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerEnvFromSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerEnvModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "valueFrom" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerEnvValueFromModule);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerEnv =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    }
    // optionalAttrs (res."valueFrom" != null) {
      "valueFrom" = mkDeploymentSpecTemplateSpecContainerEnvValueFrom res."valueFrom";
    }
    // {
    };
  DeploymentSpecTemplateSpecContainerEnvValueFromConfigMapKeyRefModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerEnvValueFromConfigMapKeyRef =
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
  DeploymentSpecTemplateSpecContainerEnvValueFromFieldRefModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "fieldPath" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerEnvValueFromFieldRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "fieldPath";
    };
  DeploymentSpecTemplateSpecContainerEnvValueFromModule = types.submodule {
    options = {
      "configMapKeyRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerEnvValueFromConfigMapKeyRefModule);
        default = null;
      };
      "fieldRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerEnvValueFromFieldRefModule);
        default = null;
      };
      "resourceFieldRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerEnvValueFromResourceFieldRefModule);
        default = null;
      };
      "secretKeyRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerEnvValueFromSecretKeyRefModule);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerEnvValueFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapKeyRef" != null) {
      "configMapKeyRef" =
        mkDeploymentSpecTemplateSpecContainerEnvValueFromConfigMapKeyRef
          res."configMapKeyRef";
    }
    // {
    }
    // optionalAttrs (res."fieldRef" != null) {
      "fieldRef" = mkDeploymentSpecTemplateSpecContainerEnvValueFromFieldRef res."fieldRef";
    }
    // {
    }
    // optionalAttrs (res."resourceFieldRef" != null) {
      "resourceFieldRef" =
        mkDeploymentSpecTemplateSpecContainerEnvValueFromResourceFieldRef
          res."resourceFieldRef";
    }
    // {
    }
    // optionalAttrs (res."secretKeyRef" != null) {
      "secretKeyRef" = mkDeploymentSpecTemplateSpecContainerEnvValueFromSecretKeyRef res."secretKeyRef";
    }
    // {
    };
  DeploymentSpecTemplateSpecContainerEnvValueFromResourceFieldRefModule = types.submodule {
    options = {
      "containerName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "divisor" = mkOption {
        type = types.anything;
        default = { };
      };
      "resource" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerEnvValueFromResourceFieldRef =
    res:
    {
    }
    // optionalAttrs (res."containerName" != null) { inherit (res) "containerName"; }
    // {
    }
    // optionalAttrs (res."divisor" != null) { inherit (res) "divisor"; }
    // {
      inherit (res) "resource";
    };
  DeploymentSpecTemplateSpecContainerEnvValueFromSecretKeyRefModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerEnvValueFromSecretKeyRef =
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
  DeploymentSpecTemplateSpecContainerLifecycleModule = types.submodule {
    options = {
      "postStart" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerLifecyclePostStartModule);
        default = null;
      };
      "preStop" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerLifecyclePreStopModule);
        default = null;
      };
      "stopSignal" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerLifecycle =
    res:
    {
    }
    // optionalAttrs (res."postStart" != null) {
      "postStart" = mkDeploymentSpecTemplateSpecContainerLifecyclePostStart res."postStart";
    }
    // {
    }
    // optionalAttrs (res."preStop" != null) {
      "preStop" = mkDeploymentSpecTemplateSpecContainerLifecyclePreStop res."preStop";
    }
    // {
    }
    // optionalAttrs (res."stopSignal" != null) { inherit (res) "stopSignal"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerLifecyclePostStartExecModule = types.submodule {
    options = {
      "command" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerLifecyclePostStartExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerLifecyclePostStartHttpGetHttpHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerLifecyclePostStartHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  DeploymentSpecTemplateSpecContainerLifecyclePostStartHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecContainerLifecyclePostStartHttpGetHttpHeaderModule);
        default = [ ];
      };
      "path" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
      "scheme" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerLifecyclePostStartHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" =
        map mkDeploymentSpecTemplateSpecContainerLifecyclePostStartHttpGetHttpHeader
          res."httpHeaders";
    }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
      inherit (res) "port";
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerLifecyclePostStartModule = types.submodule {
    options = {
      "exec" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerLifecyclePostStartExecModule);
        default = null;
      };
      "httpGet" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerLifecyclePostStartHttpGetModule);
        default = null;
      };
      "sleep" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerLifecyclePostStartSleepModule);
        default = null;
      };
      "tcpSocket" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerLifecyclePostStartTcpSocketModule);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerLifecyclePostStart =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkDeploymentSpecTemplateSpecContainerLifecyclePostStartExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkDeploymentSpecTemplateSpecContainerLifecyclePostStartHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."sleep" != null) {
      "sleep" = mkDeploymentSpecTemplateSpecContainerLifecyclePostStartSleep res."sleep";
    }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" = mkDeploymentSpecTemplateSpecContainerLifecyclePostStartTcpSocket res."tcpSocket";
    }
    // {
    };
  DeploymentSpecTemplateSpecContainerLifecyclePostStartSleepModule = types.submodule {
    options = {
      "seconds" = mkOption {
        type = types.int;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerLifecyclePostStartSleep = res: {
    inherit (res) "seconds";
  };
  DeploymentSpecTemplateSpecContainerLifecyclePostStartTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerLifecyclePostStartTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  DeploymentSpecTemplateSpecContainerLifecyclePreStopExecModule = types.submodule {
    options = {
      "command" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerLifecyclePreStopExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerLifecyclePreStopHttpGetHttpHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerLifecyclePreStopHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  DeploymentSpecTemplateSpecContainerLifecyclePreStopHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecContainerLifecyclePreStopHttpGetHttpHeaderModule);
        default = [ ];
      };
      "path" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
      "scheme" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerLifecyclePreStopHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" =
        map mkDeploymentSpecTemplateSpecContainerLifecyclePreStopHttpGetHttpHeader
          res."httpHeaders";
    }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
      inherit (res) "port";
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerLifecyclePreStopModule = types.submodule {
    options = {
      "exec" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerLifecyclePreStopExecModule);
        default = null;
      };
      "httpGet" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerLifecyclePreStopHttpGetModule);
        default = null;
      };
      "sleep" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerLifecyclePreStopSleepModule);
        default = null;
      };
      "tcpSocket" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerLifecyclePreStopTcpSocketModule);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerLifecyclePreStop =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkDeploymentSpecTemplateSpecContainerLifecyclePreStopExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkDeploymentSpecTemplateSpecContainerLifecyclePreStopHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."sleep" != null) {
      "sleep" = mkDeploymentSpecTemplateSpecContainerLifecyclePreStopSleep res."sleep";
    }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" = mkDeploymentSpecTemplateSpecContainerLifecyclePreStopTcpSocket res."tcpSocket";
    }
    // {
    };
  DeploymentSpecTemplateSpecContainerLifecyclePreStopSleepModule = types.submodule {
    options = {
      "seconds" = mkOption {
        type = types.int;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerLifecyclePreStopSleep = res: {
    inherit (res) "seconds";
  };
  DeploymentSpecTemplateSpecContainerLifecyclePreStopTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerLifecyclePreStopTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  DeploymentSpecTemplateSpecContainerLivenessProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerLivenessProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerLivenessProbeGrpcModule = types.submodule {
    options = {
      "port" = mkOption {
        type = types.int;
      };
      "service" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerLivenessProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerLivenessProbeHttpGetHttpHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerLivenessProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  DeploymentSpecTemplateSpecContainerLivenessProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecContainerLivenessProbeHttpGetHttpHeaderModule);
        default = [ ];
      };
      "path" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
      "scheme" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerLivenessProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" =
        map mkDeploymentSpecTemplateSpecContainerLivenessProbeHttpGetHttpHeader
          res."httpHeaders";
    }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
      inherit (res) "port";
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerLivenessProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerLivenessProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerLivenessProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerLivenessProbeHttpGetModule);
        default = null;
      };
      "initialDelaySeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "periodSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "successThreshold" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "tcpSocket" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerLivenessProbeTcpSocketModule);
        default = null;
      };
      "terminationGracePeriodSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "timeoutSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerLivenessProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkDeploymentSpecTemplateSpecContainerLivenessProbeExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkDeploymentSpecTemplateSpecContainerLivenessProbeGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkDeploymentSpecTemplateSpecContainerLivenessProbeHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."initialDelaySeconds" != null) { inherit (res) "initialDelaySeconds"; }
    // {
    }
    // optionalAttrs (res."periodSeconds" != null) { inherit (res) "periodSeconds"; }
    // {
    }
    // optionalAttrs (res."successThreshold" != null) { inherit (res) "successThreshold"; }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" = mkDeploymentSpecTemplateSpecContainerLivenessProbeTcpSocket res."tcpSocket";
    }
    // {
    }
    // optionalAttrs (res."terminationGracePeriodSeconds" != null) {
      inherit (res) "terminationGracePeriodSeconds";
    }
    // {
    }
    // optionalAttrs (res."timeoutSeconds" != null) { inherit (res) "timeoutSeconds"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerLivenessProbeTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerLivenessProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  DeploymentSpecTemplateSpecContainerModule = types.submodule {
    options = {
      "args" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "command" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "env" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecContainerEnvModule);
        default = [ ];
      };
      "envFrom" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecContainerEnvFromModule);
        default = [ ];
      };
      "image" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "imagePullPolicy" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "lifecycle" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerLifecycleModule);
        default = null;
      };
      "livenessProbe" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerLivenessProbeModule);
        default = null;
      };
      "name" = mkOption {
        type = types.str;
      };
      "ports" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecContainerPortModule);
        default = [ ];
      };
      "readinessProbe" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerReadinessProbeModule);
        default = null;
      };
      "resizePolicy" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecContainerResizePolicyModule);
        default = [ ];
      };
      "resources" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerResourcesModule);
        default = null;
      };
      "restartPolicy" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "securityContext" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerSecurityContextModule);
        default = null;
      };
      "startupProbe" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerStartupProbeModule);
        default = null;
      };
      "stdin" = mkOption {
        type = types.bool;
        default = false;
      };
      "stdinOnce" = mkOption {
        type = types.bool;
        default = false;
      };
      "terminationMessagePath" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "terminationMessagePolicy" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "tty" = mkOption {
        type = types.bool;
        default = false;
      };
      "volumeDevices" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecContainerVolumeDeviceModule);
        default = [ ];
      };
      "volumeMounts" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecContainerVolumeMountModule);
        default = [ ];
      };
      "workingDir" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainer =
    res:
    {
    }
    // optionalAttrs (res."args" != [ ]) { inherit (res) "args"; }
    // {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    }
    // optionalAttrs (res."env" != [ ]) {
      "env" = map mkDeploymentSpecTemplateSpecContainerEnv res."env";
    }
    // {
    }
    // optionalAttrs (res."envFrom" != [ ]) {
      "envFrom" = map mkDeploymentSpecTemplateSpecContainerEnvFrom res."envFrom";
    }
    // {
    }
    // optionalAttrs (res."image" != null) { inherit (res) "image"; }
    // {
    }
    // optionalAttrs (res."imagePullPolicy" != null) { inherit (res) "imagePullPolicy"; }
    // {
    }
    // optionalAttrs (res."lifecycle" != null) {
      "lifecycle" = mkDeploymentSpecTemplateSpecContainerLifecycle res."lifecycle";
    }
    // {
    }
    // optionalAttrs (res."livenessProbe" != null) {
      "livenessProbe" = mkDeploymentSpecTemplateSpecContainerLivenessProbe res."livenessProbe";
    }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."ports" != [ ]) {
      "ports" = map mkDeploymentSpecTemplateSpecContainerPort res."ports";
    }
    // {
    }
    // optionalAttrs (res."readinessProbe" != null) {
      "readinessProbe" = mkDeploymentSpecTemplateSpecContainerReadinessProbe res."readinessProbe";
    }
    // {
    }
    // optionalAttrs (res."resizePolicy" != [ ]) {
      "resizePolicy" = map mkDeploymentSpecTemplateSpecContainerResizePolicy res."resizePolicy";
    }
    // {
    }
    // optionalAttrs (res."resources" != null) {
      "resources" = mkDeploymentSpecTemplateSpecContainerResources res."resources";
    }
    // {
    }
    // optionalAttrs (res."restartPolicy" != null) { inherit (res) "restartPolicy"; }
    // {
    }
    // optionalAttrs (res."securityContext" != null) {
      "securityContext" = mkDeploymentSpecTemplateSpecContainerSecurityContext res."securityContext";
    }
    // {
    }
    // optionalAttrs (res."startupProbe" != null) {
      "startupProbe" = mkDeploymentSpecTemplateSpecContainerStartupProbe res."startupProbe";
    }
    // {
    }
    // optionalAttrs res."stdin" { inherit (res) "stdin"; }
    // {
    }
    // optionalAttrs res."stdinOnce" { inherit (res) "stdinOnce"; }
    // {
    }
    // optionalAttrs (res."terminationMessagePath" != null) { inherit (res) "terminationMessagePath"; }
    // {
    }
    // optionalAttrs (res."terminationMessagePolicy" != null) {
      inherit (res) "terminationMessagePolicy";
    }
    // {
    }
    // optionalAttrs res."tty" { inherit (res) "tty"; }
    // {
    }
    // optionalAttrs (res."volumeDevices" != [ ]) {
      "volumeDevices" = map mkDeploymentSpecTemplateSpecContainerVolumeDevice res."volumeDevices";
    }
    // {
    }
    // optionalAttrs (res."volumeMounts" != [ ]) {
      "volumeMounts" = map mkDeploymentSpecTemplateSpecContainerVolumeMount res."volumeMounts";
    }
    // {
    }
    // optionalAttrs (res."workingDir" != null) { inherit (res) "workingDir"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerPortModule = types.submodule {
    options = {
      "containerPort" = mkOption {
        type = types.int;
      };
      "hostIP" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "hostPort" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "protocol" = mkOption {
        type = (types.nullOr types.str);
        default = "TCP";
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerPort =
    res:
    {
      inherit (res) "containerPort";
    }
    // optionalAttrs (res."hostIP" != null) { inherit (res) "hostIP"; }
    // {
    }
    // optionalAttrs (res."hostPort" != null) { inherit (res) "hostPort"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."protocol" != null) { inherit (res) "protocol"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerReadinessProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerReadinessProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerReadinessProbeGrpcModule = types.submodule {
    options = {
      "port" = mkOption {
        type = types.int;
      };
      "service" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerReadinessProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerReadinessProbeHttpGetHttpHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerReadinessProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  DeploymentSpecTemplateSpecContainerReadinessProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecContainerReadinessProbeHttpGetHttpHeaderModule);
        default = [ ];
      };
      "path" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
      "scheme" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerReadinessProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" =
        map mkDeploymentSpecTemplateSpecContainerReadinessProbeHttpGetHttpHeader
          res."httpHeaders";
    }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
      inherit (res) "port";
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerReadinessProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerReadinessProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerReadinessProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerReadinessProbeHttpGetModule);
        default = null;
      };
      "initialDelaySeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "periodSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "successThreshold" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "tcpSocket" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerReadinessProbeTcpSocketModule);
        default = null;
      };
      "terminationGracePeriodSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "timeoutSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerReadinessProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkDeploymentSpecTemplateSpecContainerReadinessProbeExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkDeploymentSpecTemplateSpecContainerReadinessProbeGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkDeploymentSpecTemplateSpecContainerReadinessProbeHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."initialDelaySeconds" != null) { inherit (res) "initialDelaySeconds"; }
    // {
    }
    // optionalAttrs (res."periodSeconds" != null) { inherit (res) "periodSeconds"; }
    // {
    }
    // optionalAttrs (res."successThreshold" != null) { inherit (res) "successThreshold"; }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" = mkDeploymentSpecTemplateSpecContainerReadinessProbeTcpSocket res."tcpSocket";
    }
    // {
    }
    // optionalAttrs (res."terminationGracePeriodSeconds" != null) {
      inherit (res) "terminationGracePeriodSeconds";
    }
    // {
    }
    // optionalAttrs (res."timeoutSeconds" != null) { inherit (res) "timeoutSeconds"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerReadinessProbeTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerReadinessProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  DeploymentSpecTemplateSpecContainerResizePolicyModule = types.submodule {
    options = {
      "resourceName" = mkOption {
        type = types.str;
      };
      "restartPolicy" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerResizePolicy = res: {
    inherit (res) "resourceName";
    inherit (res) "restartPolicy";
  };
  DeploymentSpecTemplateSpecContainerResourcesClaimModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "request" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerResourcesClaim =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."request" != null) { inherit (res) "request"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerResourcesModule = types.submodule {
    options = {
      "claims" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecContainerResourcesClaimModule);
        default = [ ];
      };
      "limits" = mkOption {
        type = (types.attrsOf types.anything);
        default = { };
      };
      "requests" = mkOption {
        type = (types.attrsOf types.anything);
        default = { };
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerResources =
    res:
    {
    }
    // optionalAttrs (res."claims" != [ ]) {
      "claims" = map mkDeploymentSpecTemplateSpecContainerResourcesClaim res."claims";
    }
    // {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerSecurityContextAppArmorProfileModule = types.submodule {
    options = {
      "localhostProfile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerSecurityContextAppArmorProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  DeploymentSpecTemplateSpecContainerSecurityContextCapabilitiesModule = types.submodule {
    options = {
      "add" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "drop" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerSecurityContextCapabilities =
    res:
    {
    }
    // optionalAttrs (res."add" != [ ]) { inherit (res) "add"; }
    // {
    }
    // optionalAttrs (res."drop" != [ ]) { inherit (res) "drop"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerSecurityContextModule = types.submodule {
    options = {
      "allowPrivilegeEscalation" = mkOption {
        type = types.bool;
        default = false;
      };
      "appArmorProfile" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerSecurityContextAppArmorProfileModule);
        default = null;
      };
      "capabilities" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerSecurityContextCapabilitiesModule);
        default = null;
      };
      "privileged" = mkOption {
        type = types.bool;
        default = false;
      };
      "procMount" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnlyRootFilesystem" = mkOption {
        type = types.bool;
        default = false;
      };
      "runAsGroup" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "runAsNonRoot" = mkOption {
        type = types.bool;
        default = false;
      };
      "runAsUser" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "seLinuxOptions" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerSecurityContextSeLinuxOptionsModule);
        default = null;
      };
      "seccompProfile" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerSecurityContextSeccompProfileModule);
        default = null;
      };
      "windowsOptions" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerSecurityContextWindowsOptionsModule);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerSecurityContext =
    res:
    {
    }
    // optionalAttrs res."allowPrivilegeEscalation" { inherit (res) "allowPrivilegeEscalation"; }
    // {
    }
    // optionalAttrs (res."appArmorProfile" != null) {
      "appArmorProfile" =
        mkDeploymentSpecTemplateSpecContainerSecurityContextAppArmorProfile
          res."appArmorProfile";
    }
    // {
    }
    // optionalAttrs (res."capabilities" != null) {
      "capabilities" =
        mkDeploymentSpecTemplateSpecContainerSecurityContextCapabilities
          res."capabilities";
    }
    // {
    }
    // optionalAttrs res."privileged" { inherit (res) "privileged"; }
    // {
    }
    // optionalAttrs (res."procMount" != null) { inherit (res) "procMount"; }
    // {
    }
    // optionalAttrs res."readOnlyRootFilesystem" { inherit (res) "readOnlyRootFilesystem"; }
    // {
    }
    // optionalAttrs (res."runAsGroup" != null) { inherit (res) "runAsGroup"; }
    // {
    }
    // optionalAttrs res."runAsNonRoot" { inherit (res) "runAsNonRoot"; }
    // {
    }
    // optionalAttrs (res."runAsUser" != null) { inherit (res) "runAsUser"; }
    // {
    }
    // optionalAttrs (res."seLinuxOptions" != null) {
      "seLinuxOptions" =
        mkDeploymentSpecTemplateSpecContainerSecurityContextSeLinuxOptions
          res."seLinuxOptions";
    }
    // {
    }
    // optionalAttrs (res."seccompProfile" != null) {
      "seccompProfile" =
        mkDeploymentSpecTemplateSpecContainerSecurityContextSeccompProfile
          res."seccompProfile";
    }
    // {
    }
    // optionalAttrs (res."windowsOptions" != null) {
      "windowsOptions" =
        mkDeploymentSpecTemplateSpecContainerSecurityContextWindowsOptions
          res."windowsOptions";
    }
    // {
    };
  DeploymentSpecTemplateSpecContainerSecurityContextSeLinuxOptionsModule = types.submodule {
    options = {
      "level" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "role" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "user" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerSecurityContextSeLinuxOptions =
    res:
    {
    }
    // optionalAttrs (res."level" != null) { inherit (res) "level"; }
    // {
    }
    // optionalAttrs (res."role" != null) { inherit (res) "role"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    }
    // optionalAttrs (res."user" != null) { inherit (res) "user"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerSecurityContextSeccompProfileModule = types.submodule {
    options = {
      "localhostProfile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerSecurityContextSeccompProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  DeploymentSpecTemplateSpecContainerSecurityContextWindowsOptionsModule = types.submodule {
    options = {
      "gmsaCredentialSpec" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "gmsaCredentialSpecName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "hostProcess" = mkOption {
        type = types.bool;
        default = false;
      };
      "runAsUserName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerSecurityContextWindowsOptions =
    res:
    {
    }
    // optionalAttrs (res."gmsaCredentialSpec" != null) { inherit (res) "gmsaCredentialSpec"; }
    // {
    }
    // optionalAttrs (res."gmsaCredentialSpecName" != null) { inherit (res) "gmsaCredentialSpecName"; }
    // {
    }
    // optionalAttrs res."hostProcess" { inherit (res) "hostProcess"; }
    // {
    }
    // optionalAttrs (res."runAsUserName" != null) { inherit (res) "runAsUserName"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerStartupProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerStartupProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerStartupProbeGrpcModule = types.submodule {
    options = {
      "port" = mkOption {
        type = types.int;
      };
      "service" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerStartupProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerStartupProbeHttpGetHttpHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerStartupProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  DeploymentSpecTemplateSpecContainerStartupProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecContainerStartupProbeHttpGetHttpHeaderModule);
        default = [ ];
      };
      "path" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
      "scheme" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerStartupProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" =
        map mkDeploymentSpecTemplateSpecContainerStartupProbeHttpGetHttpHeader
          res."httpHeaders";
    }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
      inherit (res) "port";
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerStartupProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerStartupProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerStartupProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerStartupProbeHttpGetModule);
        default = null;
      };
      "initialDelaySeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "periodSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "successThreshold" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "tcpSocket" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecContainerStartupProbeTcpSocketModule);
        default = null;
      };
      "terminationGracePeriodSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "timeoutSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerStartupProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkDeploymentSpecTemplateSpecContainerStartupProbeExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkDeploymentSpecTemplateSpecContainerStartupProbeGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkDeploymentSpecTemplateSpecContainerStartupProbeHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."initialDelaySeconds" != null) { inherit (res) "initialDelaySeconds"; }
    // {
    }
    // optionalAttrs (res."periodSeconds" != null) { inherit (res) "periodSeconds"; }
    // {
    }
    // optionalAttrs (res."successThreshold" != null) { inherit (res) "successThreshold"; }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" = mkDeploymentSpecTemplateSpecContainerStartupProbeTcpSocket res."tcpSocket";
    }
    // {
    }
    // optionalAttrs (res."terminationGracePeriodSeconds" != null) {
      inherit (res) "terminationGracePeriodSeconds";
    }
    // {
    }
    // optionalAttrs (res."timeoutSeconds" != null) { inherit (res) "timeoutSeconds"; }
    // {
    };
  DeploymentSpecTemplateSpecContainerStartupProbeTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerStartupProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  DeploymentSpecTemplateSpecContainerVolumeDeviceModule = types.submodule {
    options = {
      "devicePath" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerVolumeDevice = res: {
    inherit (res) "devicePath";
    inherit (res) "name";
  };
  DeploymentSpecTemplateSpecContainerVolumeMountModule = types.submodule {
    options = {
      "mountPath" = mkOption {
        type = types.str;
      };
      "mountPropagation" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        type = types.str;
      };
      "readOnly" = mkOption {
        type = types.bool;
        default = false;
      };
      "recursiveReadOnly" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "subPath" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "subPathExpr" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecContainerVolumeMount =
    res:
    {
      inherit (res) "mountPath";
    }
    // optionalAttrs (res."mountPropagation" != null) { inherit (res) "mountPropagation"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."recursiveReadOnly" != null) { inherit (res) "recursiveReadOnly"; }
    // {
    }
    // optionalAttrs (res."subPath" != null) { inherit (res) "subPath"; }
    // {
    }
    // optionalAttrs (res."subPathExpr" != null) { inherit (res) "subPathExpr"; }
    // {
    };
  DeploymentSpecTemplateSpecDnsConfigModule = types.submodule {
    options = {
      "nameservers" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "options" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecDnsConfigOptionModule);
        default = [ ];
      };
      "searches" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpecDnsConfig =
    res:
    {
    }
    // optionalAttrs (res."nameservers" != [ ]) { inherit (res) "nameservers"; }
    // {
    }
    // optionalAttrs (res."options" != [ ]) {
      "options" = map mkDeploymentSpecTemplateSpecDnsConfigOption res."options";
    }
    // {
    }
    // optionalAttrs (res."searches" != [ ]) { inherit (res) "searches"; }
    // {
    };
  DeploymentSpecTemplateSpecDnsConfigOptionModule = types.submodule {
    options = {
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "value" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecDnsConfigOption =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerEnvFromConfigMapRefModule = types.submodule {
    options = {
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerEnvFromConfigMapRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerEnvFromModule = types.submodule {
    options = {
      "configMapRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerEnvFromConfigMapRefModule);
        default = null;
      };
      "prefix" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "secretRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerEnvFromSecretRefModule);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerEnvFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapRef" != null) {
      "configMapRef" =
        mkDeploymentSpecTemplateSpecEphemeralContainerEnvFromConfigMapRef
          res."configMapRef";
    }
    // {
    }
    // optionalAttrs (res."prefix" != null) { inherit (res) "prefix"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkDeploymentSpecTemplateSpecEphemeralContainerEnvFromSecretRef res."secretRef";
    }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerEnvFromSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerEnvFromSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerEnvModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "valueFrom" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerEnvValueFromModule);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerEnv =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    }
    // optionalAttrs (res."valueFrom" != null) {
      "valueFrom" = mkDeploymentSpecTemplateSpecEphemeralContainerEnvValueFrom res."valueFrom";
    }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerEnvValueFromConfigMapKeyRefModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerEnvValueFromConfigMapKeyRef =
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
  DeploymentSpecTemplateSpecEphemeralContainerEnvValueFromFieldRefModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "fieldPath" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerEnvValueFromFieldRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "fieldPath";
    };
  DeploymentSpecTemplateSpecEphemeralContainerEnvValueFromModule = types.submodule {
    options = {
      "configMapKeyRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerEnvValueFromConfigMapKeyRefModule);
        default = null;
      };
      "fieldRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerEnvValueFromFieldRefModule);
        default = null;
      };
      "resourceFieldRef" = mkOption {
        type = (
          types.nullOr DeploymentSpecTemplateSpecEphemeralContainerEnvValueFromResourceFieldRefModule
        );
        default = null;
      };
      "secretKeyRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerEnvValueFromSecretKeyRefModule);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerEnvValueFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapKeyRef" != null) {
      "configMapKeyRef" =
        mkDeploymentSpecTemplateSpecEphemeralContainerEnvValueFromConfigMapKeyRef
          res."configMapKeyRef";
    }
    // {
    }
    // optionalAttrs (res."fieldRef" != null) {
      "fieldRef" = mkDeploymentSpecTemplateSpecEphemeralContainerEnvValueFromFieldRef res."fieldRef";
    }
    // {
    }
    // optionalAttrs (res."resourceFieldRef" != null) {
      "resourceFieldRef" =
        mkDeploymentSpecTemplateSpecEphemeralContainerEnvValueFromResourceFieldRef
          res."resourceFieldRef";
    }
    // {
    }
    // optionalAttrs (res."secretKeyRef" != null) {
      "secretKeyRef" =
        mkDeploymentSpecTemplateSpecEphemeralContainerEnvValueFromSecretKeyRef
          res."secretKeyRef";
    }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerEnvValueFromResourceFieldRefModule = types.submodule {
    options = {
      "containerName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "divisor" = mkOption {
        type = types.anything;
        default = { };
      };
      "resource" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerEnvValueFromResourceFieldRef =
    res:
    {
    }
    // optionalAttrs (res."containerName" != null) { inherit (res) "containerName"; }
    // {
    }
    // optionalAttrs (res."divisor" != null) { inherit (res) "divisor"; }
    // {
      inherit (res) "resource";
    };
  DeploymentSpecTemplateSpecEphemeralContainerEnvValueFromSecretKeyRefModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerEnvValueFromSecretKeyRef =
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
  DeploymentSpecTemplateSpecEphemeralContainerLifecycleModule = types.submodule {
    options = {
      "postStart" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerLifecyclePostStartModule);
        default = null;
      };
      "preStop" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerLifecyclePreStopModule);
        default = null;
      };
      "stopSignal" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerLifecycle =
    res:
    {
    }
    // optionalAttrs (res."postStart" != null) {
      "postStart" = mkDeploymentSpecTemplateSpecEphemeralContainerLifecyclePostStart res."postStart";
    }
    // {
    }
    // optionalAttrs (res."preStop" != null) {
      "preStop" = mkDeploymentSpecTemplateSpecEphemeralContainerLifecyclePreStop res."preStop";
    }
    // {
    }
    // optionalAttrs (res."stopSignal" != null) { inherit (res) "stopSignal"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerLifecyclePostStartExecModule = types.submodule {
    options = {
      "command" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerLifecyclePostStartExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerLifecyclePostStartHttpGetHttpHeaderModule =
    types.submodule
      {
        options = {
          "name" = mkOption {
            type = types.str;
          };
          "value" = mkOption {
            type = types.str;
          };
        };
      };
  mkDeploymentSpecTemplateSpecEphemeralContainerLifecyclePostStartHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  DeploymentSpecTemplateSpecEphemeralContainerLifecyclePostStartHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        type = (
          types.listOf DeploymentSpecTemplateSpecEphemeralContainerLifecyclePostStartHttpGetHttpHeaderModule
        );
        default = [ ];
      };
      "path" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
      "scheme" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerLifecyclePostStartHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" =
        map mkDeploymentSpecTemplateSpecEphemeralContainerLifecyclePostStartHttpGetHttpHeader
          res."httpHeaders";
    }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
      inherit (res) "port";
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerLifecyclePostStartModule = types.submodule {
    options = {
      "exec" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerLifecyclePostStartExecModule);
        default = null;
      };
      "httpGet" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerLifecyclePostStartHttpGetModule);
        default = null;
      };
      "sleep" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerLifecyclePostStartSleepModule);
        default = null;
      };
      "tcpSocket" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerLifecyclePostStartTcpSocketModule);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerLifecyclePostStart =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkDeploymentSpecTemplateSpecEphemeralContainerLifecyclePostStartExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkDeploymentSpecTemplateSpecEphemeralContainerLifecyclePostStartHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."sleep" != null) {
      "sleep" = mkDeploymentSpecTemplateSpecEphemeralContainerLifecyclePostStartSleep res."sleep";
    }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" =
        mkDeploymentSpecTemplateSpecEphemeralContainerLifecyclePostStartTcpSocket
          res."tcpSocket";
    }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerLifecyclePostStartSleepModule = types.submodule {
    options = {
      "seconds" = mkOption {
        type = types.int;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerLifecyclePostStartSleep = res: {
    inherit (res) "seconds";
  };
  DeploymentSpecTemplateSpecEphemeralContainerLifecyclePostStartTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerLifecyclePostStartTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  DeploymentSpecTemplateSpecEphemeralContainerLifecyclePreStopExecModule = types.submodule {
    options = {
      "command" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerLifecyclePreStopExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerLifecyclePreStopHttpGetHttpHeaderModule =
    types.submodule
      {
        options = {
          "name" = mkOption {
            type = types.str;
          };
          "value" = mkOption {
            type = types.str;
          };
        };
      };
  mkDeploymentSpecTemplateSpecEphemeralContainerLifecyclePreStopHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  DeploymentSpecTemplateSpecEphemeralContainerLifecyclePreStopHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        type = (
          types.listOf DeploymentSpecTemplateSpecEphemeralContainerLifecyclePreStopHttpGetHttpHeaderModule
        );
        default = [ ];
      };
      "path" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
      "scheme" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerLifecyclePreStopHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" =
        map mkDeploymentSpecTemplateSpecEphemeralContainerLifecyclePreStopHttpGetHttpHeader
          res."httpHeaders";
    }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
      inherit (res) "port";
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerLifecyclePreStopModule = types.submodule {
    options = {
      "exec" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerLifecyclePreStopExecModule);
        default = null;
      };
      "httpGet" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerLifecyclePreStopHttpGetModule);
        default = null;
      };
      "sleep" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerLifecyclePreStopSleepModule);
        default = null;
      };
      "tcpSocket" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerLifecyclePreStopTcpSocketModule);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerLifecyclePreStop =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkDeploymentSpecTemplateSpecEphemeralContainerLifecyclePreStopExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkDeploymentSpecTemplateSpecEphemeralContainerLifecyclePreStopHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."sleep" != null) {
      "sleep" = mkDeploymentSpecTemplateSpecEphemeralContainerLifecyclePreStopSleep res."sleep";
    }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" =
        mkDeploymentSpecTemplateSpecEphemeralContainerLifecyclePreStopTcpSocket
          res."tcpSocket";
    }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerLifecyclePreStopSleepModule = types.submodule {
    options = {
      "seconds" = mkOption {
        type = types.int;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerLifecyclePreStopSleep = res: {
    inherit (res) "seconds";
  };
  DeploymentSpecTemplateSpecEphemeralContainerLifecyclePreStopTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerLifecyclePreStopTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  DeploymentSpecTemplateSpecEphemeralContainerLivenessProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerLivenessProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerLivenessProbeGrpcModule = types.submodule {
    options = {
      "port" = mkOption {
        type = types.int;
      };
      "service" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerLivenessProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerLivenessProbeHttpGetHttpHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerLivenessProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  DeploymentSpecTemplateSpecEphemeralContainerLivenessProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        type = (
          types.listOf DeploymentSpecTemplateSpecEphemeralContainerLivenessProbeHttpGetHttpHeaderModule
        );
        default = [ ];
      };
      "path" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
      "scheme" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerLivenessProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" =
        map mkDeploymentSpecTemplateSpecEphemeralContainerLivenessProbeHttpGetHttpHeader
          res."httpHeaders";
    }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
      inherit (res) "port";
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerLivenessProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerLivenessProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerLivenessProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerLivenessProbeHttpGetModule);
        default = null;
      };
      "initialDelaySeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "periodSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "successThreshold" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "tcpSocket" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerLivenessProbeTcpSocketModule);
        default = null;
      };
      "terminationGracePeriodSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "timeoutSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerLivenessProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkDeploymentSpecTemplateSpecEphemeralContainerLivenessProbeExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkDeploymentSpecTemplateSpecEphemeralContainerLivenessProbeGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkDeploymentSpecTemplateSpecEphemeralContainerLivenessProbeHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."initialDelaySeconds" != null) { inherit (res) "initialDelaySeconds"; }
    // {
    }
    // optionalAttrs (res."periodSeconds" != null) { inherit (res) "periodSeconds"; }
    // {
    }
    // optionalAttrs (res."successThreshold" != null) { inherit (res) "successThreshold"; }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" = mkDeploymentSpecTemplateSpecEphemeralContainerLivenessProbeTcpSocket res."tcpSocket";
    }
    // {
    }
    // optionalAttrs (res."terminationGracePeriodSeconds" != null) {
      inherit (res) "terminationGracePeriodSeconds";
    }
    // {
    }
    // optionalAttrs (res."timeoutSeconds" != null) { inherit (res) "timeoutSeconds"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerLivenessProbeTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerLivenessProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  DeploymentSpecTemplateSpecEphemeralContainerModule = types.submodule {
    options = {
      "args" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "command" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "env" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecEphemeralContainerEnvModule);
        default = [ ];
      };
      "envFrom" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecEphemeralContainerEnvFromModule);
        default = [ ];
      };
      "image" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "imagePullPolicy" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "lifecycle" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerLifecycleModule);
        default = null;
      };
      "livenessProbe" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerLivenessProbeModule);
        default = null;
      };
      "name" = mkOption {
        type = types.str;
      };
      "ports" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecEphemeralContainerPortModule);
        default = [ ];
      };
      "readinessProbe" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerReadinessProbeModule);
        default = null;
      };
      "resizePolicy" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecEphemeralContainerResizePolicyModule);
        default = [ ];
      };
      "resources" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerResourcesModule);
        default = null;
      };
      "restartPolicy" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "securityContext" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerSecurityContextModule);
        default = null;
      };
      "startupProbe" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerStartupProbeModule);
        default = null;
      };
      "stdin" = mkOption {
        type = types.bool;
        default = false;
      };
      "stdinOnce" = mkOption {
        type = types.bool;
        default = false;
      };
      "targetContainerName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "terminationMessagePath" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "terminationMessagePolicy" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "tty" = mkOption {
        type = types.bool;
        default = false;
      };
      "volumeDevices" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecEphemeralContainerVolumeDeviceModule);
        default = [ ];
      };
      "volumeMounts" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecEphemeralContainerVolumeMountModule);
        default = [ ];
      };
      "workingDir" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainer =
    res:
    {
    }
    // optionalAttrs (res."args" != [ ]) { inherit (res) "args"; }
    // {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    }
    // optionalAttrs (res."env" != [ ]) {
      "env" = map mkDeploymentSpecTemplateSpecEphemeralContainerEnv res."env";
    }
    // {
    }
    // optionalAttrs (res."envFrom" != [ ]) {
      "envFrom" = map mkDeploymentSpecTemplateSpecEphemeralContainerEnvFrom res."envFrom";
    }
    // {
    }
    // optionalAttrs (res."image" != null) { inherit (res) "image"; }
    // {
    }
    // optionalAttrs (res."imagePullPolicy" != null) { inherit (res) "imagePullPolicy"; }
    // {
    }
    // optionalAttrs (res."lifecycle" != null) {
      "lifecycle" = mkDeploymentSpecTemplateSpecEphemeralContainerLifecycle res."lifecycle";
    }
    // {
    }
    // optionalAttrs (res."livenessProbe" != null) {
      "livenessProbe" = mkDeploymentSpecTemplateSpecEphemeralContainerLivenessProbe res."livenessProbe";
    }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."ports" != [ ]) {
      "ports" = map mkDeploymentSpecTemplateSpecEphemeralContainerPort res."ports";
    }
    // {
    }
    // optionalAttrs (res."readinessProbe" != null) {
      "readinessProbe" =
        mkDeploymentSpecTemplateSpecEphemeralContainerReadinessProbe
          res."readinessProbe";
    }
    // {
    }
    // optionalAttrs (res."resizePolicy" != [ ]) {
      "resizePolicy" = map mkDeploymentSpecTemplateSpecEphemeralContainerResizePolicy res."resizePolicy";
    }
    // {
    }
    // optionalAttrs (res."resources" != null) {
      "resources" = mkDeploymentSpecTemplateSpecEphemeralContainerResources res."resources";
    }
    // {
    }
    // optionalAttrs (res."restartPolicy" != null) { inherit (res) "restartPolicy"; }
    // {
    }
    // optionalAttrs (res."securityContext" != null) {
      "securityContext" =
        mkDeploymentSpecTemplateSpecEphemeralContainerSecurityContext
          res."securityContext";
    }
    // {
    }
    // optionalAttrs (res."startupProbe" != null) {
      "startupProbe" = mkDeploymentSpecTemplateSpecEphemeralContainerStartupProbe res."startupProbe";
    }
    // {
    }
    // optionalAttrs res."stdin" { inherit (res) "stdin"; }
    // {
    }
    // optionalAttrs res."stdinOnce" { inherit (res) "stdinOnce"; }
    // {
    }
    // optionalAttrs (res."targetContainerName" != null) { inherit (res) "targetContainerName"; }
    // {
    }
    // optionalAttrs (res."terminationMessagePath" != null) { inherit (res) "terminationMessagePath"; }
    // {
    }
    // optionalAttrs (res."terminationMessagePolicy" != null) {
      inherit (res) "terminationMessagePolicy";
    }
    // {
    }
    // optionalAttrs res."tty" { inherit (res) "tty"; }
    // {
    }
    // optionalAttrs (res."volumeDevices" != [ ]) {
      "volumeDevices" =
        map mkDeploymentSpecTemplateSpecEphemeralContainerVolumeDevice
          res."volumeDevices";
    }
    // {
    }
    // optionalAttrs (res."volumeMounts" != [ ]) {
      "volumeMounts" = map mkDeploymentSpecTemplateSpecEphemeralContainerVolumeMount res."volumeMounts";
    }
    // {
    }
    // optionalAttrs (res."workingDir" != null) { inherit (res) "workingDir"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerPortModule = types.submodule {
    options = {
      "containerPort" = mkOption {
        type = types.int;
      };
      "hostIP" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "hostPort" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "protocol" = mkOption {
        type = (types.nullOr types.str);
        default = "TCP";
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerPort =
    res:
    {
      inherit (res) "containerPort";
    }
    // optionalAttrs (res."hostIP" != null) { inherit (res) "hostIP"; }
    // {
    }
    // optionalAttrs (res."hostPort" != null) { inherit (res) "hostPort"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."protocol" != null) { inherit (res) "protocol"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerReadinessProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerReadinessProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerReadinessProbeGrpcModule = types.submodule {
    options = {
      "port" = mkOption {
        type = types.int;
      };
      "service" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerReadinessProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerReadinessProbeHttpGetHttpHeaderModule =
    types.submodule
      {
        options = {
          "name" = mkOption {
            type = types.str;
          };
          "value" = mkOption {
            type = types.str;
          };
        };
      };
  mkDeploymentSpecTemplateSpecEphemeralContainerReadinessProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  DeploymentSpecTemplateSpecEphemeralContainerReadinessProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        type = (
          types.listOf DeploymentSpecTemplateSpecEphemeralContainerReadinessProbeHttpGetHttpHeaderModule
        );
        default = [ ];
      };
      "path" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
      "scheme" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerReadinessProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" =
        map mkDeploymentSpecTemplateSpecEphemeralContainerReadinessProbeHttpGetHttpHeader
          res."httpHeaders";
    }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
      inherit (res) "port";
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerReadinessProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerReadinessProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerReadinessProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerReadinessProbeHttpGetModule);
        default = null;
      };
      "initialDelaySeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "periodSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "successThreshold" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "tcpSocket" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerReadinessProbeTcpSocketModule);
        default = null;
      };
      "terminationGracePeriodSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "timeoutSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerReadinessProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkDeploymentSpecTemplateSpecEphemeralContainerReadinessProbeExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkDeploymentSpecTemplateSpecEphemeralContainerReadinessProbeGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkDeploymentSpecTemplateSpecEphemeralContainerReadinessProbeHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."initialDelaySeconds" != null) { inherit (res) "initialDelaySeconds"; }
    // {
    }
    // optionalAttrs (res."periodSeconds" != null) { inherit (res) "periodSeconds"; }
    // {
    }
    // optionalAttrs (res."successThreshold" != null) { inherit (res) "successThreshold"; }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" = mkDeploymentSpecTemplateSpecEphemeralContainerReadinessProbeTcpSocket res."tcpSocket";
    }
    // {
    }
    // optionalAttrs (res."terminationGracePeriodSeconds" != null) {
      inherit (res) "terminationGracePeriodSeconds";
    }
    // {
    }
    // optionalAttrs (res."timeoutSeconds" != null) { inherit (res) "timeoutSeconds"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerReadinessProbeTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerReadinessProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  DeploymentSpecTemplateSpecEphemeralContainerResizePolicyModule = types.submodule {
    options = {
      "resourceName" = mkOption {
        type = types.str;
      };
      "restartPolicy" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerResizePolicy = res: {
    inherit (res) "resourceName";
    inherit (res) "restartPolicy";
  };
  DeploymentSpecTemplateSpecEphemeralContainerResourcesClaimModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "request" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerResourcesClaim =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."request" != null) { inherit (res) "request"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerResourcesModule = types.submodule {
    options = {
      "claims" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecEphemeralContainerResourcesClaimModule);
        default = [ ];
      };
      "limits" = mkOption {
        type = (types.attrsOf types.anything);
        default = { };
      };
      "requests" = mkOption {
        type = (types.attrsOf types.anything);
        default = { };
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerResources =
    res:
    {
    }
    // optionalAttrs (res."claims" != [ ]) {
      "claims" = map mkDeploymentSpecTemplateSpecEphemeralContainerResourcesClaim res."claims";
    }
    // {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerSecurityContextAppArmorProfileModule = types.submodule {
    options = {
      "localhostProfile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerSecurityContextAppArmorProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  DeploymentSpecTemplateSpecEphemeralContainerSecurityContextCapabilitiesModule = types.submodule {
    options = {
      "add" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "drop" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerSecurityContextCapabilities =
    res:
    {
    }
    // optionalAttrs (res."add" != [ ]) { inherit (res) "add"; }
    // {
    }
    // optionalAttrs (res."drop" != [ ]) { inherit (res) "drop"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerSecurityContextModule = types.submodule {
    options = {
      "allowPrivilegeEscalation" = mkOption {
        type = types.bool;
        default = false;
      };
      "appArmorProfile" = mkOption {
        type = (
          types.nullOr DeploymentSpecTemplateSpecEphemeralContainerSecurityContextAppArmorProfileModule
        );
        default = null;
      };
      "capabilities" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerSecurityContextCapabilitiesModule);
        default = null;
      };
      "privileged" = mkOption {
        type = types.bool;
        default = false;
      };
      "procMount" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnlyRootFilesystem" = mkOption {
        type = types.bool;
        default = false;
      };
      "runAsGroup" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "runAsNonRoot" = mkOption {
        type = types.bool;
        default = false;
      };
      "runAsUser" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "seLinuxOptions" = mkOption {
        type = (
          types.nullOr DeploymentSpecTemplateSpecEphemeralContainerSecurityContextSeLinuxOptionsModule
        );
        default = null;
      };
      "seccompProfile" = mkOption {
        type = (
          types.nullOr DeploymentSpecTemplateSpecEphemeralContainerSecurityContextSeccompProfileModule
        );
        default = null;
      };
      "windowsOptions" = mkOption {
        type = (
          types.nullOr DeploymentSpecTemplateSpecEphemeralContainerSecurityContextWindowsOptionsModule
        );
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerSecurityContext =
    res:
    {
    }
    // optionalAttrs res."allowPrivilegeEscalation" { inherit (res) "allowPrivilegeEscalation"; }
    // {
    }
    // optionalAttrs (res."appArmorProfile" != null) {
      "appArmorProfile" =
        mkDeploymentSpecTemplateSpecEphemeralContainerSecurityContextAppArmorProfile
          res."appArmorProfile";
    }
    // {
    }
    // optionalAttrs (res."capabilities" != null) {
      "capabilities" =
        mkDeploymentSpecTemplateSpecEphemeralContainerSecurityContextCapabilities
          res."capabilities";
    }
    // {
    }
    // optionalAttrs res."privileged" { inherit (res) "privileged"; }
    // {
    }
    // optionalAttrs (res."procMount" != null) { inherit (res) "procMount"; }
    // {
    }
    // optionalAttrs res."readOnlyRootFilesystem" { inherit (res) "readOnlyRootFilesystem"; }
    // {
    }
    // optionalAttrs (res."runAsGroup" != null) { inherit (res) "runAsGroup"; }
    // {
    }
    // optionalAttrs res."runAsNonRoot" { inherit (res) "runAsNonRoot"; }
    // {
    }
    // optionalAttrs (res."runAsUser" != null) { inherit (res) "runAsUser"; }
    // {
    }
    // optionalAttrs (res."seLinuxOptions" != null) {
      "seLinuxOptions" =
        mkDeploymentSpecTemplateSpecEphemeralContainerSecurityContextSeLinuxOptions
          res."seLinuxOptions";
    }
    // {
    }
    // optionalAttrs (res."seccompProfile" != null) {
      "seccompProfile" =
        mkDeploymentSpecTemplateSpecEphemeralContainerSecurityContextSeccompProfile
          res."seccompProfile";
    }
    // {
    }
    // optionalAttrs (res."windowsOptions" != null) {
      "windowsOptions" =
        mkDeploymentSpecTemplateSpecEphemeralContainerSecurityContextWindowsOptions
          res."windowsOptions";
    }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerSecurityContextSeLinuxOptionsModule = types.submodule {
    options = {
      "level" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "role" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "user" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerSecurityContextSeLinuxOptions =
    res:
    {
    }
    // optionalAttrs (res."level" != null) { inherit (res) "level"; }
    // {
    }
    // optionalAttrs (res."role" != null) { inherit (res) "role"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    }
    // optionalAttrs (res."user" != null) { inherit (res) "user"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerSecurityContextSeccompProfileModule = types.submodule {
    options = {
      "localhostProfile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerSecurityContextSeccompProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  DeploymentSpecTemplateSpecEphemeralContainerSecurityContextWindowsOptionsModule = types.submodule {
    options = {
      "gmsaCredentialSpec" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "gmsaCredentialSpecName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "hostProcess" = mkOption {
        type = types.bool;
        default = false;
      };
      "runAsUserName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerSecurityContextWindowsOptions =
    res:
    {
    }
    // optionalAttrs (res."gmsaCredentialSpec" != null) { inherit (res) "gmsaCredentialSpec"; }
    // {
    }
    // optionalAttrs (res."gmsaCredentialSpecName" != null) { inherit (res) "gmsaCredentialSpecName"; }
    // {
    }
    // optionalAttrs res."hostProcess" { inherit (res) "hostProcess"; }
    // {
    }
    // optionalAttrs (res."runAsUserName" != null) { inherit (res) "runAsUserName"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerStartupProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerStartupProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerStartupProbeGrpcModule = types.submodule {
    options = {
      "port" = mkOption {
        type = types.int;
      };
      "service" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerStartupProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerStartupProbeHttpGetHttpHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerStartupProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  DeploymentSpecTemplateSpecEphemeralContainerStartupProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        type = (
          types.listOf DeploymentSpecTemplateSpecEphemeralContainerStartupProbeHttpGetHttpHeaderModule
        );
        default = [ ];
      };
      "path" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
      "scheme" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerStartupProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" =
        map mkDeploymentSpecTemplateSpecEphemeralContainerStartupProbeHttpGetHttpHeader
          res."httpHeaders";
    }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
      inherit (res) "port";
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerStartupProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerStartupProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerStartupProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerStartupProbeHttpGetModule);
        default = null;
      };
      "initialDelaySeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "periodSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "successThreshold" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "tcpSocket" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecEphemeralContainerStartupProbeTcpSocketModule);
        default = null;
      };
      "terminationGracePeriodSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "timeoutSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerStartupProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkDeploymentSpecTemplateSpecEphemeralContainerStartupProbeExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkDeploymentSpecTemplateSpecEphemeralContainerStartupProbeGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkDeploymentSpecTemplateSpecEphemeralContainerStartupProbeHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."initialDelaySeconds" != null) { inherit (res) "initialDelaySeconds"; }
    // {
    }
    // optionalAttrs (res."periodSeconds" != null) { inherit (res) "periodSeconds"; }
    // {
    }
    // optionalAttrs (res."successThreshold" != null) { inherit (res) "successThreshold"; }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" = mkDeploymentSpecTemplateSpecEphemeralContainerStartupProbeTcpSocket res."tcpSocket";
    }
    // {
    }
    // optionalAttrs (res."terminationGracePeriodSeconds" != null) {
      inherit (res) "terminationGracePeriodSeconds";
    }
    // {
    }
    // optionalAttrs (res."timeoutSeconds" != null) { inherit (res) "timeoutSeconds"; }
    // {
    };
  DeploymentSpecTemplateSpecEphemeralContainerStartupProbeTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerStartupProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  DeploymentSpecTemplateSpecEphemeralContainerVolumeDeviceModule = types.submodule {
    options = {
      "devicePath" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerVolumeDevice = res: {
    inherit (res) "devicePath";
    inherit (res) "name";
  };
  DeploymentSpecTemplateSpecEphemeralContainerVolumeMountModule = types.submodule {
    options = {
      "mountPath" = mkOption {
        type = types.str;
      };
      "mountPropagation" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        type = types.str;
      };
      "readOnly" = mkOption {
        type = types.bool;
        default = false;
      };
      "recursiveReadOnly" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "subPath" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "subPathExpr" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecEphemeralContainerVolumeMount =
    res:
    {
      inherit (res) "mountPath";
    }
    // optionalAttrs (res."mountPropagation" != null) { inherit (res) "mountPropagation"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."recursiveReadOnly" != null) { inherit (res) "recursiveReadOnly"; }
    // {
    }
    // optionalAttrs (res."subPath" != null) { inherit (res) "subPath"; }
    // {
    }
    // optionalAttrs (res."subPathExpr" != null) { inherit (res) "subPathExpr"; }
    // {
    };
  DeploymentSpecTemplateSpecHostAliaseModule = types.submodule {
    options = {
      "hostnames" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "ip" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecHostAliase =
    res:
    {
    }
    // optionalAttrs (res."hostnames" != [ ]) { inherit (res) "hostnames"; }
    // {
      inherit (res) "ip";
    };
  DeploymentSpecTemplateSpecImagePullSecretModule = types.submodule {
    options = {
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkDeploymentSpecTemplateSpecImagePullSecret =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerEnvFromConfigMapRefModule = types.submodule {
    options = {
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerEnvFromConfigMapRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerEnvFromModule = types.submodule {
    options = {
      "configMapRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerEnvFromConfigMapRefModule);
        default = null;
      };
      "prefix" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "secretRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerEnvFromSecretRefModule);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerEnvFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapRef" != null) {
      "configMapRef" = mkDeploymentSpecTemplateSpecInitContainerEnvFromConfigMapRef res."configMapRef";
    }
    // {
    }
    // optionalAttrs (res."prefix" != null) { inherit (res) "prefix"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkDeploymentSpecTemplateSpecInitContainerEnvFromSecretRef res."secretRef";
    }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerEnvFromSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerEnvFromSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerEnvModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "valueFrom" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerEnvValueFromModule);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerEnv =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    }
    // optionalAttrs (res."valueFrom" != null) {
      "valueFrom" = mkDeploymentSpecTemplateSpecInitContainerEnvValueFrom res."valueFrom";
    }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerEnvValueFromConfigMapKeyRefModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerEnvValueFromConfigMapKeyRef =
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
  DeploymentSpecTemplateSpecInitContainerEnvValueFromFieldRefModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "fieldPath" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerEnvValueFromFieldRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "fieldPath";
    };
  DeploymentSpecTemplateSpecInitContainerEnvValueFromModule = types.submodule {
    options = {
      "configMapKeyRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerEnvValueFromConfigMapKeyRefModule);
        default = null;
      };
      "fieldRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerEnvValueFromFieldRefModule);
        default = null;
      };
      "resourceFieldRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerEnvValueFromResourceFieldRefModule);
        default = null;
      };
      "secretKeyRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerEnvValueFromSecretKeyRefModule);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerEnvValueFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapKeyRef" != null) {
      "configMapKeyRef" =
        mkDeploymentSpecTemplateSpecInitContainerEnvValueFromConfigMapKeyRef
          res."configMapKeyRef";
    }
    // {
    }
    // optionalAttrs (res."fieldRef" != null) {
      "fieldRef" = mkDeploymentSpecTemplateSpecInitContainerEnvValueFromFieldRef res."fieldRef";
    }
    // {
    }
    // optionalAttrs (res."resourceFieldRef" != null) {
      "resourceFieldRef" =
        mkDeploymentSpecTemplateSpecInitContainerEnvValueFromResourceFieldRef
          res."resourceFieldRef";
    }
    // {
    }
    // optionalAttrs (res."secretKeyRef" != null) {
      "secretKeyRef" =
        mkDeploymentSpecTemplateSpecInitContainerEnvValueFromSecretKeyRef
          res."secretKeyRef";
    }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerEnvValueFromResourceFieldRefModule = types.submodule {
    options = {
      "containerName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "divisor" = mkOption {
        type = types.anything;
        default = { };
      };
      "resource" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerEnvValueFromResourceFieldRef =
    res:
    {
    }
    // optionalAttrs (res."containerName" != null) { inherit (res) "containerName"; }
    // {
    }
    // optionalAttrs (res."divisor" != null) { inherit (res) "divisor"; }
    // {
      inherit (res) "resource";
    };
  DeploymentSpecTemplateSpecInitContainerEnvValueFromSecretKeyRefModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerEnvValueFromSecretKeyRef =
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
  DeploymentSpecTemplateSpecInitContainerLifecycleModule = types.submodule {
    options = {
      "postStart" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerLifecyclePostStartModule);
        default = null;
      };
      "preStop" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerLifecyclePreStopModule);
        default = null;
      };
      "stopSignal" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerLifecycle =
    res:
    {
    }
    // optionalAttrs (res."postStart" != null) {
      "postStart" = mkDeploymentSpecTemplateSpecInitContainerLifecyclePostStart res."postStart";
    }
    // {
    }
    // optionalAttrs (res."preStop" != null) {
      "preStop" = mkDeploymentSpecTemplateSpecInitContainerLifecyclePreStop res."preStop";
    }
    // {
    }
    // optionalAttrs (res."stopSignal" != null) { inherit (res) "stopSignal"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerLifecyclePostStartExecModule = types.submodule {
    options = {
      "command" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerLifecyclePostStartExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerLifecyclePostStartHttpGetHttpHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerLifecyclePostStartHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  DeploymentSpecTemplateSpecInitContainerLifecyclePostStartHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        type = (
          types.listOf DeploymentSpecTemplateSpecInitContainerLifecyclePostStartHttpGetHttpHeaderModule
        );
        default = [ ];
      };
      "path" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
      "scheme" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerLifecyclePostStartHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" =
        map mkDeploymentSpecTemplateSpecInitContainerLifecyclePostStartHttpGetHttpHeader
          res."httpHeaders";
    }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
      inherit (res) "port";
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerLifecyclePostStartModule = types.submodule {
    options = {
      "exec" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerLifecyclePostStartExecModule);
        default = null;
      };
      "httpGet" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerLifecyclePostStartHttpGetModule);
        default = null;
      };
      "sleep" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerLifecyclePostStartSleepModule);
        default = null;
      };
      "tcpSocket" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerLifecyclePostStartTcpSocketModule);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerLifecyclePostStart =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkDeploymentSpecTemplateSpecInitContainerLifecyclePostStartExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkDeploymentSpecTemplateSpecInitContainerLifecyclePostStartHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."sleep" != null) {
      "sleep" = mkDeploymentSpecTemplateSpecInitContainerLifecyclePostStartSleep res."sleep";
    }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" = mkDeploymentSpecTemplateSpecInitContainerLifecyclePostStartTcpSocket res."tcpSocket";
    }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerLifecyclePostStartSleepModule = types.submodule {
    options = {
      "seconds" = mkOption {
        type = types.int;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerLifecyclePostStartSleep = res: {
    inherit (res) "seconds";
  };
  DeploymentSpecTemplateSpecInitContainerLifecyclePostStartTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerLifecyclePostStartTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  DeploymentSpecTemplateSpecInitContainerLifecyclePreStopExecModule = types.submodule {
    options = {
      "command" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerLifecyclePreStopExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerLifecyclePreStopHttpGetHttpHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerLifecyclePreStopHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  DeploymentSpecTemplateSpecInitContainerLifecyclePreStopHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        type = (
          types.listOf DeploymentSpecTemplateSpecInitContainerLifecyclePreStopHttpGetHttpHeaderModule
        );
        default = [ ];
      };
      "path" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
      "scheme" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerLifecyclePreStopHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" =
        map mkDeploymentSpecTemplateSpecInitContainerLifecyclePreStopHttpGetHttpHeader
          res."httpHeaders";
    }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
      inherit (res) "port";
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerLifecyclePreStopModule = types.submodule {
    options = {
      "exec" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerLifecyclePreStopExecModule);
        default = null;
      };
      "httpGet" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerLifecyclePreStopHttpGetModule);
        default = null;
      };
      "sleep" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerLifecyclePreStopSleepModule);
        default = null;
      };
      "tcpSocket" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerLifecyclePreStopTcpSocketModule);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerLifecyclePreStop =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkDeploymentSpecTemplateSpecInitContainerLifecyclePreStopExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkDeploymentSpecTemplateSpecInitContainerLifecyclePreStopHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."sleep" != null) {
      "sleep" = mkDeploymentSpecTemplateSpecInitContainerLifecyclePreStopSleep res."sleep";
    }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" = mkDeploymentSpecTemplateSpecInitContainerLifecyclePreStopTcpSocket res."tcpSocket";
    }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerLifecyclePreStopSleepModule = types.submodule {
    options = {
      "seconds" = mkOption {
        type = types.int;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerLifecyclePreStopSleep = res: {
    inherit (res) "seconds";
  };
  DeploymentSpecTemplateSpecInitContainerLifecyclePreStopTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerLifecyclePreStopTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  DeploymentSpecTemplateSpecInitContainerLivenessProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerLivenessProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerLivenessProbeGrpcModule = types.submodule {
    options = {
      "port" = mkOption {
        type = types.int;
      };
      "service" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerLivenessProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerLivenessProbeHttpGetHttpHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerLivenessProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  DeploymentSpecTemplateSpecInitContainerLivenessProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecInitContainerLivenessProbeHttpGetHttpHeaderModule);
        default = [ ];
      };
      "path" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
      "scheme" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerLivenessProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" =
        map mkDeploymentSpecTemplateSpecInitContainerLivenessProbeHttpGetHttpHeader
          res."httpHeaders";
    }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
      inherit (res) "port";
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerLivenessProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerLivenessProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerLivenessProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerLivenessProbeHttpGetModule);
        default = null;
      };
      "initialDelaySeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "periodSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "successThreshold" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "tcpSocket" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerLivenessProbeTcpSocketModule);
        default = null;
      };
      "terminationGracePeriodSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "timeoutSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerLivenessProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkDeploymentSpecTemplateSpecInitContainerLivenessProbeExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkDeploymentSpecTemplateSpecInitContainerLivenessProbeGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkDeploymentSpecTemplateSpecInitContainerLivenessProbeHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."initialDelaySeconds" != null) { inherit (res) "initialDelaySeconds"; }
    // {
    }
    // optionalAttrs (res."periodSeconds" != null) { inherit (res) "periodSeconds"; }
    // {
    }
    // optionalAttrs (res."successThreshold" != null) { inherit (res) "successThreshold"; }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" = mkDeploymentSpecTemplateSpecInitContainerLivenessProbeTcpSocket res."tcpSocket";
    }
    // {
    }
    // optionalAttrs (res."terminationGracePeriodSeconds" != null) {
      inherit (res) "terminationGracePeriodSeconds";
    }
    // {
    }
    // optionalAttrs (res."timeoutSeconds" != null) { inherit (res) "timeoutSeconds"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerLivenessProbeTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerLivenessProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  DeploymentSpecTemplateSpecInitContainerModule = types.submodule {
    options = {
      "args" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "command" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "env" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecInitContainerEnvModule);
        default = [ ];
      };
      "envFrom" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecInitContainerEnvFromModule);
        default = [ ];
      };
      "image" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "imagePullPolicy" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "lifecycle" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerLifecycleModule);
        default = null;
      };
      "livenessProbe" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerLivenessProbeModule);
        default = null;
      };
      "name" = mkOption {
        type = types.str;
      };
      "ports" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecInitContainerPortModule);
        default = [ ];
      };
      "readinessProbe" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerReadinessProbeModule);
        default = null;
      };
      "resizePolicy" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecInitContainerResizePolicyModule);
        default = [ ];
      };
      "resources" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerResourcesModule);
        default = null;
      };
      "restartPolicy" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "securityContext" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerSecurityContextModule);
        default = null;
      };
      "startupProbe" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerStartupProbeModule);
        default = null;
      };
      "stdin" = mkOption {
        type = types.bool;
        default = false;
      };
      "stdinOnce" = mkOption {
        type = types.bool;
        default = false;
      };
      "terminationMessagePath" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "terminationMessagePolicy" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "tty" = mkOption {
        type = types.bool;
        default = false;
      };
      "volumeDevices" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecInitContainerVolumeDeviceModule);
        default = [ ];
      };
      "volumeMounts" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecInitContainerVolumeMountModule);
        default = [ ];
      };
      "workingDir" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainer =
    res:
    {
    }
    // optionalAttrs (res."args" != [ ]) { inherit (res) "args"; }
    // {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    }
    // optionalAttrs (res."env" != [ ]) {
      "env" = map mkDeploymentSpecTemplateSpecInitContainerEnv res."env";
    }
    // {
    }
    // optionalAttrs (res."envFrom" != [ ]) {
      "envFrom" = map mkDeploymentSpecTemplateSpecInitContainerEnvFrom res."envFrom";
    }
    // {
    }
    // optionalAttrs (res."image" != null) { inherit (res) "image"; }
    // {
    }
    // optionalAttrs (res."imagePullPolicy" != null) { inherit (res) "imagePullPolicy"; }
    // {
    }
    // optionalAttrs (res."lifecycle" != null) {
      "lifecycle" = mkDeploymentSpecTemplateSpecInitContainerLifecycle res."lifecycle";
    }
    // {
    }
    // optionalAttrs (res."livenessProbe" != null) {
      "livenessProbe" = mkDeploymentSpecTemplateSpecInitContainerLivenessProbe res."livenessProbe";
    }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."ports" != [ ]) {
      "ports" = map mkDeploymentSpecTemplateSpecInitContainerPort res."ports";
    }
    // {
    }
    // optionalAttrs (res."readinessProbe" != null) {
      "readinessProbe" = mkDeploymentSpecTemplateSpecInitContainerReadinessProbe res."readinessProbe";
    }
    // {
    }
    // optionalAttrs (res."resizePolicy" != [ ]) {
      "resizePolicy" = map mkDeploymentSpecTemplateSpecInitContainerResizePolicy res."resizePolicy";
    }
    // {
    }
    // optionalAttrs (res."resources" != null) {
      "resources" = mkDeploymentSpecTemplateSpecInitContainerResources res."resources";
    }
    // {
    }
    // optionalAttrs (res."restartPolicy" != null) { inherit (res) "restartPolicy"; }
    // {
    }
    // optionalAttrs (res."securityContext" != null) {
      "securityContext" = mkDeploymentSpecTemplateSpecInitContainerSecurityContext res."securityContext";
    }
    // {
    }
    // optionalAttrs (res."startupProbe" != null) {
      "startupProbe" = mkDeploymentSpecTemplateSpecInitContainerStartupProbe res."startupProbe";
    }
    // {
    }
    // optionalAttrs res."stdin" { inherit (res) "stdin"; }
    // {
    }
    // optionalAttrs res."stdinOnce" { inherit (res) "stdinOnce"; }
    // {
    }
    // optionalAttrs (res."terminationMessagePath" != null) { inherit (res) "terminationMessagePath"; }
    // {
    }
    // optionalAttrs (res."terminationMessagePolicy" != null) {
      inherit (res) "terminationMessagePolicy";
    }
    // {
    }
    // optionalAttrs res."tty" { inherit (res) "tty"; }
    // {
    }
    // optionalAttrs (res."volumeDevices" != [ ]) {
      "volumeDevices" = map mkDeploymentSpecTemplateSpecInitContainerVolumeDevice res."volumeDevices";
    }
    // {
    }
    // optionalAttrs (res."volumeMounts" != [ ]) {
      "volumeMounts" = map mkDeploymentSpecTemplateSpecInitContainerVolumeMount res."volumeMounts";
    }
    // {
    }
    // optionalAttrs (res."workingDir" != null) { inherit (res) "workingDir"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerPortModule = types.submodule {
    options = {
      "containerPort" = mkOption {
        type = types.int;
      };
      "hostIP" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "hostPort" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "protocol" = mkOption {
        type = (types.nullOr types.str);
        default = "TCP";
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerPort =
    res:
    {
      inherit (res) "containerPort";
    }
    // optionalAttrs (res."hostIP" != null) { inherit (res) "hostIP"; }
    // {
    }
    // optionalAttrs (res."hostPort" != null) { inherit (res) "hostPort"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."protocol" != null) { inherit (res) "protocol"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerReadinessProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerReadinessProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerReadinessProbeGrpcModule = types.submodule {
    options = {
      "port" = mkOption {
        type = types.int;
      };
      "service" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerReadinessProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerReadinessProbeHttpGetHttpHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerReadinessProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  DeploymentSpecTemplateSpecInitContainerReadinessProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecInitContainerReadinessProbeHttpGetHttpHeaderModule);
        default = [ ];
      };
      "path" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
      "scheme" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerReadinessProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" =
        map mkDeploymentSpecTemplateSpecInitContainerReadinessProbeHttpGetHttpHeader
          res."httpHeaders";
    }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
      inherit (res) "port";
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerReadinessProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerReadinessProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerReadinessProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerReadinessProbeHttpGetModule);
        default = null;
      };
      "initialDelaySeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "periodSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "successThreshold" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "tcpSocket" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerReadinessProbeTcpSocketModule);
        default = null;
      };
      "terminationGracePeriodSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "timeoutSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerReadinessProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkDeploymentSpecTemplateSpecInitContainerReadinessProbeExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkDeploymentSpecTemplateSpecInitContainerReadinessProbeGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkDeploymentSpecTemplateSpecInitContainerReadinessProbeHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."initialDelaySeconds" != null) { inherit (res) "initialDelaySeconds"; }
    // {
    }
    // optionalAttrs (res."periodSeconds" != null) { inherit (res) "periodSeconds"; }
    // {
    }
    // optionalAttrs (res."successThreshold" != null) { inherit (res) "successThreshold"; }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" = mkDeploymentSpecTemplateSpecInitContainerReadinessProbeTcpSocket res."tcpSocket";
    }
    // {
    }
    // optionalAttrs (res."terminationGracePeriodSeconds" != null) {
      inherit (res) "terminationGracePeriodSeconds";
    }
    // {
    }
    // optionalAttrs (res."timeoutSeconds" != null) { inherit (res) "timeoutSeconds"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerReadinessProbeTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerReadinessProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  DeploymentSpecTemplateSpecInitContainerResizePolicyModule = types.submodule {
    options = {
      "resourceName" = mkOption {
        type = types.str;
      };
      "restartPolicy" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerResizePolicy = res: {
    inherit (res) "resourceName";
    inherit (res) "restartPolicy";
  };
  DeploymentSpecTemplateSpecInitContainerResourcesClaimModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "request" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerResourcesClaim =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."request" != null) { inherit (res) "request"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerResourcesModule = types.submodule {
    options = {
      "claims" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecInitContainerResourcesClaimModule);
        default = [ ];
      };
      "limits" = mkOption {
        type = (types.attrsOf types.anything);
        default = { };
      };
      "requests" = mkOption {
        type = (types.attrsOf types.anything);
        default = { };
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerResources =
    res:
    {
    }
    // optionalAttrs (res."claims" != [ ]) {
      "claims" = map mkDeploymentSpecTemplateSpecInitContainerResourcesClaim res."claims";
    }
    // {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerSecurityContextAppArmorProfileModule = types.submodule {
    options = {
      "localhostProfile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerSecurityContextAppArmorProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  DeploymentSpecTemplateSpecInitContainerSecurityContextCapabilitiesModule = types.submodule {
    options = {
      "add" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "drop" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerSecurityContextCapabilities =
    res:
    {
    }
    // optionalAttrs (res."add" != [ ]) { inherit (res) "add"; }
    // {
    }
    // optionalAttrs (res."drop" != [ ]) { inherit (res) "drop"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerSecurityContextModule = types.submodule {
    options = {
      "allowPrivilegeEscalation" = mkOption {
        type = types.bool;
        default = false;
      };
      "appArmorProfile" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerSecurityContextAppArmorProfileModule);
        default = null;
      };
      "capabilities" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerSecurityContextCapabilitiesModule);
        default = null;
      };
      "privileged" = mkOption {
        type = types.bool;
        default = false;
      };
      "procMount" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnlyRootFilesystem" = mkOption {
        type = types.bool;
        default = false;
      };
      "runAsGroup" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "runAsNonRoot" = mkOption {
        type = types.bool;
        default = false;
      };
      "runAsUser" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "seLinuxOptions" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerSecurityContextSeLinuxOptionsModule);
        default = null;
      };
      "seccompProfile" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerSecurityContextSeccompProfileModule);
        default = null;
      };
      "windowsOptions" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerSecurityContextWindowsOptionsModule);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerSecurityContext =
    res:
    {
    }
    // optionalAttrs res."allowPrivilegeEscalation" { inherit (res) "allowPrivilegeEscalation"; }
    // {
    }
    // optionalAttrs (res."appArmorProfile" != null) {
      "appArmorProfile" =
        mkDeploymentSpecTemplateSpecInitContainerSecurityContextAppArmorProfile
          res."appArmorProfile";
    }
    // {
    }
    // optionalAttrs (res."capabilities" != null) {
      "capabilities" =
        mkDeploymentSpecTemplateSpecInitContainerSecurityContextCapabilities
          res."capabilities";
    }
    // {
    }
    // optionalAttrs res."privileged" { inherit (res) "privileged"; }
    // {
    }
    // optionalAttrs (res."procMount" != null) { inherit (res) "procMount"; }
    // {
    }
    // optionalAttrs res."readOnlyRootFilesystem" { inherit (res) "readOnlyRootFilesystem"; }
    // {
    }
    // optionalAttrs (res."runAsGroup" != null) { inherit (res) "runAsGroup"; }
    // {
    }
    // optionalAttrs res."runAsNonRoot" { inherit (res) "runAsNonRoot"; }
    // {
    }
    // optionalAttrs (res."runAsUser" != null) { inherit (res) "runAsUser"; }
    // {
    }
    // optionalAttrs (res."seLinuxOptions" != null) {
      "seLinuxOptions" =
        mkDeploymentSpecTemplateSpecInitContainerSecurityContextSeLinuxOptions
          res."seLinuxOptions";
    }
    // {
    }
    // optionalAttrs (res."seccompProfile" != null) {
      "seccompProfile" =
        mkDeploymentSpecTemplateSpecInitContainerSecurityContextSeccompProfile
          res."seccompProfile";
    }
    // {
    }
    // optionalAttrs (res."windowsOptions" != null) {
      "windowsOptions" =
        mkDeploymentSpecTemplateSpecInitContainerSecurityContextWindowsOptions
          res."windowsOptions";
    }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerSecurityContextSeLinuxOptionsModule = types.submodule {
    options = {
      "level" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "role" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "user" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerSecurityContextSeLinuxOptions =
    res:
    {
    }
    // optionalAttrs (res."level" != null) { inherit (res) "level"; }
    // {
    }
    // optionalAttrs (res."role" != null) { inherit (res) "role"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    }
    // optionalAttrs (res."user" != null) { inherit (res) "user"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerSecurityContextSeccompProfileModule = types.submodule {
    options = {
      "localhostProfile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerSecurityContextSeccompProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  DeploymentSpecTemplateSpecInitContainerSecurityContextWindowsOptionsModule = types.submodule {
    options = {
      "gmsaCredentialSpec" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "gmsaCredentialSpecName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "hostProcess" = mkOption {
        type = types.bool;
        default = false;
      };
      "runAsUserName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerSecurityContextWindowsOptions =
    res:
    {
    }
    // optionalAttrs (res."gmsaCredentialSpec" != null) { inherit (res) "gmsaCredentialSpec"; }
    // {
    }
    // optionalAttrs (res."gmsaCredentialSpecName" != null) { inherit (res) "gmsaCredentialSpecName"; }
    // {
    }
    // optionalAttrs res."hostProcess" { inherit (res) "hostProcess"; }
    // {
    }
    // optionalAttrs (res."runAsUserName" != null) { inherit (res) "runAsUserName"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerStartupProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerStartupProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerStartupProbeGrpcModule = types.submodule {
    options = {
      "port" = mkOption {
        type = types.int;
      };
      "service" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerStartupProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerStartupProbeHttpGetHttpHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerStartupProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  DeploymentSpecTemplateSpecInitContainerStartupProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecInitContainerStartupProbeHttpGetHttpHeaderModule);
        default = [ ];
      };
      "path" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
      "scheme" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerStartupProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" =
        map mkDeploymentSpecTemplateSpecInitContainerStartupProbeHttpGetHttpHeader
          res."httpHeaders";
    }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
      inherit (res) "port";
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerStartupProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerStartupProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerStartupProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerStartupProbeHttpGetModule);
        default = null;
      };
      "initialDelaySeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "periodSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "successThreshold" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "tcpSocket" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecInitContainerStartupProbeTcpSocketModule);
        default = null;
      };
      "terminationGracePeriodSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "timeoutSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerStartupProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkDeploymentSpecTemplateSpecInitContainerStartupProbeExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkDeploymentSpecTemplateSpecInitContainerStartupProbeGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkDeploymentSpecTemplateSpecInitContainerStartupProbeHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."initialDelaySeconds" != null) { inherit (res) "initialDelaySeconds"; }
    // {
    }
    // optionalAttrs (res."periodSeconds" != null) { inherit (res) "periodSeconds"; }
    // {
    }
    // optionalAttrs (res."successThreshold" != null) { inherit (res) "successThreshold"; }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" = mkDeploymentSpecTemplateSpecInitContainerStartupProbeTcpSocket res."tcpSocket";
    }
    // {
    }
    // optionalAttrs (res."terminationGracePeriodSeconds" != null) {
      inherit (res) "terminationGracePeriodSeconds";
    }
    // {
    }
    // optionalAttrs (res."timeoutSeconds" != null) { inherit (res) "timeoutSeconds"; }
    // {
    };
  DeploymentSpecTemplateSpecInitContainerStartupProbeTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerStartupProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  DeploymentSpecTemplateSpecInitContainerVolumeDeviceModule = types.submodule {
    options = {
      "devicePath" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerVolumeDevice = res: {
    inherit (res) "devicePath";
    inherit (res) "name";
  };
  DeploymentSpecTemplateSpecInitContainerVolumeMountModule = types.submodule {
    options = {
      "mountPath" = mkOption {
        type = types.str;
      };
      "mountPropagation" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        type = types.str;
      };
      "readOnly" = mkOption {
        type = types.bool;
        default = false;
      };
      "recursiveReadOnly" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "subPath" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "subPathExpr" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecInitContainerVolumeMount =
    res:
    {
      inherit (res) "mountPath";
    }
    // optionalAttrs (res."mountPropagation" != null) { inherit (res) "mountPropagation"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."recursiveReadOnly" != null) { inherit (res) "recursiveReadOnly"; }
    // {
    }
    // optionalAttrs (res."subPath" != null) { inherit (res) "subPath"; }
    // {
    }
    // optionalAttrs (res."subPathExpr" != null) { inherit (res) "subPathExpr"; }
    // {
    };
  DeploymentSpecTemplateSpecModule = types.submodule {
    options = {
      "activeDeadlineSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "affinity" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecAffinityModule);
        default = null;
      };
      "automountServiceAccountToken" = mkOption {
        type = types.bool;
        default = false;
      };
      "containers" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecContainerModule);
        default = [ ];
      };
      "dnsConfig" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecDnsConfigModule);
        default = null;
      };
      "dnsPolicy" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "enableServiceLinks" = mkOption {
        type = types.bool;
        default = false;
      };
      "ephemeralContainers" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecEphemeralContainerModule);
        default = [ ];
      };
      "hostAliases" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecHostAliaseModule);
        default = [ ];
      };
      "hostIPC" = mkOption {
        type = types.bool;
        default = false;
      };
      "hostNetwork" = mkOption {
        type = types.bool;
        default = false;
      };
      "hostPID" = mkOption {
        type = types.bool;
        default = false;
      };
      "hostUsers" = mkOption {
        type = types.bool;
        default = false;
      };
      "hostname" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "imagePullSecrets" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecImagePullSecretModule);
        default = [ ];
      };
      "initContainers" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecInitContainerModule);
        default = [ ];
      };
      "nodeName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "nodeSelector" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "os" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecOsModule);
        default = null;
      };
      "overhead" = mkOption {
        type = (types.attrsOf types.anything);
        default = { };
      };
      "preemptionPolicy" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "priority" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "priorityClassName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "readinessGates" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecReadinessGateModule);
        default = [ ];
      };
      "restartPolicy" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "runtimeClassName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "schedulerName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "securityContext" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecSecurityContextModule);
        default = null;
      };
      "serviceAccount" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "serviceAccountName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "setHostnameAsFQDN" = mkOption {
        type = types.bool;
        default = false;
      };
      "shareProcessNamespace" = mkOption {
        type = types.bool;
        default = false;
      };
      "subdomain" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "terminationGracePeriodSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "tolerations" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecTolerationModule);
        default = [ ];
      };
      "topologySpreadConstraints" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecTopologySpreadConstraintModule);
        default = [ ];
      };
      "volumes" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecVolumeModule);
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpec =
    res:
    {
    }
    // optionalAttrs (res."activeDeadlineSeconds" != null) { inherit (res) "activeDeadlineSeconds"; }
    // {
    }
    // optionalAttrs (res."affinity" != null) {
      "affinity" = mkDeploymentSpecTemplateSpecAffinity res."affinity";
    }
    // {
    }
    // optionalAttrs res."automountServiceAccountToken" {
      inherit (res) "automountServiceAccountToken";
    }
    // {
    }
    // optionalAttrs (res."containers" != [ ]) {
      "containers" = map mkDeploymentSpecTemplateSpecContainer res."containers";
    }
    // {
    }
    // optionalAttrs (res."dnsConfig" != null) {
      "dnsConfig" = mkDeploymentSpecTemplateSpecDnsConfig res."dnsConfig";
    }
    // {
    }
    // optionalAttrs (res."dnsPolicy" != null) { inherit (res) "dnsPolicy"; }
    // {
    }
    // optionalAttrs res."enableServiceLinks" { inherit (res) "enableServiceLinks"; }
    // {
    }
    // optionalAttrs (res."ephemeralContainers" != [ ]) {
      "ephemeralContainers" =
        map mkDeploymentSpecTemplateSpecEphemeralContainer
          res."ephemeralContainers";
    }
    // {
    }
    // optionalAttrs (res."hostAliases" != [ ]) {
      "hostAliases" = map mkDeploymentSpecTemplateSpecHostAliase res."hostAliases";
    }
    // {
    }
    // optionalAttrs res."hostIPC" { inherit (res) "hostIPC"; }
    // {
    }
    // optionalAttrs res."hostNetwork" { inherit (res) "hostNetwork"; }
    // {
    }
    // optionalAttrs res."hostPID" { inherit (res) "hostPID"; }
    // {
    }
    // optionalAttrs res."hostUsers" { inherit (res) "hostUsers"; }
    // {
    }
    // optionalAttrs (res."hostname" != null) { inherit (res) "hostname"; }
    // {
    }
    // optionalAttrs (res."imagePullSecrets" != [ ]) {
      "imagePullSecrets" = map mkDeploymentSpecTemplateSpecImagePullSecret res."imagePullSecrets";
    }
    // {
    }
    // optionalAttrs (res."initContainers" != [ ]) {
      "initContainers" = map mkDeploymentSpecTemplateSpecInitContainer res."initContainers";
    }
    // {
    }
    // optionalAttrs (res."nodeName" != null) { inherit (res) "nodeName"; }
    // {
    }
    // optionalAttrs (res."nodeSelector" != { }) { inherit (res) "nodeSelector"; }
    // {
    }
    // optionalAttrs (res."os" != null) { "os" = mkDeploymentSpecTemplateSpecOs res."os"; }
    // {
    }
    // optionalAttrs (res."overhead" != { }) { inherit (res) "overhead"; }
    // {
    }
    // optionalAttrs (res."preemptionPolicy" != null) { inherit (res) "preemptionPolicy"; }
    // {
    }
    // optionalAttrs (res."priority" != null) { inherit (res) "priority"; }
    // {
    }
    // optionalAttrs (res."priorityClassName" != null) { inherit (res) "priorityClassName"; }
    // {
    }
    // optionalAttrs (res."readinessGates" != [ ]) {
      "readinessGates" = map mkDeploymentSpecTemplateSpecReadinessGate res."readinessGates";
    }
    // {
    }
    // optionalAttrs (res."restartPolicy" != null) { inherit (res) "restartPolicy"; }
    // {
    }
    // optionalAttrs (res."runtimeClassName" != null) { inherit (res) "runtimeClassName"; }
    // {
    }
    // optionalAttrs (res."schedulerName" != null) { inherit (res) "schedulerName"; }
    // {
    }
    // optionalAttrs (res."securityContext" != null) {
      "securityContext" = mkDeploymentSpecTemplateSpecSecurityContext res."securityContext";
    }
    // {
    }
    // optionalAttrs (res."serviceAccount" != null) { inherit (res) "serviceAccount"; }
    // {
    }
    // optionalAttrs (res."serviceAccountName" != null) { inherit (res) "serviceAccountName"; }
    // {
    }
    // optionalAttrs res."setHostnameAsFQDN" { inherit (res) "setHostnameAsFQDN"; }
    // {
    }
    // optionalAttrs res."shareProcessNamespace" { inherit (res) "shareProcessNamespace"; }
    // {
    }
    // optionalAttrs (res."subdomain" != null) { inherit (res) "subdomain"; }
    // {
    }
    // optionalAttrs (res."terminationGracePeriodSeconds" != null) {
      inherit (res) "terminationGracePeriodSeconds";
    }
    // {
    }
    // optionalAttrs (res."tolerations" != [ ]) {
      "tolerations" = map mkDeploymentSpecTemplateSpecToleration res."tolerations";
    }
    // {
    }
    // optionalAttrs (res."topologySpreadConstraints" != [ ]) {
      "topologySpreadConstraints" =
        map mkDeploymentSpecTemplateSpecTopologySpreadConstraint
          res."topologySpreadConstraints";
    }
    // {
    }
    // optionalAttrs (res."volumes" != [ ]) {
      "volumes" = map mkDeploymentSpecTemplateSpecVolume res."volumes";
    }
    // {
    };
  DeploymentSpecTemplateSpecOsModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecOs = res: {
    inherit (res) "name";
  };
  DeploymentSpecTemplateSpecReadinessGateModule = types.submodule {
    options = {
      "conditionType" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecReadinessGate = res: {
    inherit (res) "conditionType";
  };
  DeploymentSpecTemplateSpecSecurityContextAppArmorProfileModule = types.submodule {
    options = {
      "localhostProfile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecSecurityContextAppArmorProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  DeploymentSpecTemplateSpecSecurityContextModule = types.submodule {
    options = {
      "appArmorProfile" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecSecurityContextAppArmorProfileModule);
        default = null;
      };
      "fsGroup" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "fsGroupChangePolicy" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "runAsGroup" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "runAsNonRoot" = mkOption {
        type = types.bool;
        default = false;
      };
      "runAsUser" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "seLinuxChangePolicy" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "seLinuxOptions" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecSecurityContextSeLinuxOptionsModule);
        default = null;
      };
      "seccompProfile" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecSecurityContextSeccompProfileModule);
        default = null;
      };
      "supplementalGroups" = mkOption {
        type = (types.listOf types.int);
        default = [ ];
      };
      "supplementalGroupsPolicy" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "sysctls" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecSecurityContextSysctlModule);
        default = [ ];
      };
      "windowsOptions" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecSecurityContextWindowsOptionsModule);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecSecurityContext =
    res:
    {
    }
    // optionalAttrs (res."appArmorProfile" != null) {
      "appArmorProfile" =
        mkDeploymentSpecTemplateSpecSecurityContextAppArmorProfile
          res."appArmorProfile";
    }
    // {
    }
    // optionalAttrs (res."fsGroup" != null) { inherit (res) "fsGroup"; }
    // {
    }
    // optionalAttrs (res."fsGroupChangePolicy" != null) { inherit (res) "fsGroupChangePolicy"; }
    // {
    }
    // optionalAttrs (res."runAsGroup" != null) { inherit (res) "runAsGroup"; }
    // {
    }
    // optionalAttrs res."runAsNonRoot" { inherit (res) "runAsNonRoot"; }
    // {
    }
    // optionalAttrs (res."runAsUser" != null) { inherit (res) "runAsUser"; }
    // {
    }
    // optionalAttrs (res."seLinuxChangePolicy" != null) { inherit (res) "seLinuxChangePolicy"; }
    // {
    }
    // optionalAttrs (res."seLinuxOptions" != null) {
      "seLinuxOptions" = mkDeploymentSpecTemplateSpecSecurityContextSeLinuxOptions res."seLinuxOptions";
    }
    // {
    }
    // optionalAttrs (res."seccompProfile" != null) {
      "seccompProfile" = mkDeploymentSpecTemplateSpecSecurityContextSeccompProfile res."seccompProfile";
    }
    // {
    }
    // optionalAttrs (res."supplementalGroups" != [ ]) { inherit (res) "supplementalGroups"; }
    // {
    }
    // optionalAttrs (res."supplementalGroupsPolicy" != null) {
      inherit (res) "supplementalGroupsPolicy";
    }
    // {
    }
    // optionalAttrs (res."sysctls" != [ ]) {
      "sysctls" = map mkDeploymentSpecTemplateSpecSecurityContextSysctl res."sysctls";
    }
    // {
    }
    // optionalAttrs (res."windowsOptions" != null) {
      "windowsOptions" = mkDeploymentSpecTemplateSpecSecurityContextWindowsOptions res."windowsOptions";
    }
    // {
    };
  DeploymentSpecTemplateSpecSecurityContextSeLinuxOptionsModule = types.submodule {
    options = {
      "level" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "role" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "user" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecSecurityContextSeLinuxOptions =
    res:
    {
    }
    // optionalAttrs (res."level" != null) { inherit (res) "level"; }
    // {
    }
    // optionalAttrs (res."role" != null) { inherit (res) "role"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    }
    // optionalAttrs (res."user" != null) { inherit (res) "user"; }
    // {
    };
  DeploymentSpecTemplateSpecSecurityContextSeccompProfileModule = types.submodule {
    options = {
      "localhostProfile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecSecurityContextSeccompProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  DeploymentSpecTemplateSpecSecurityContextSysctlModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecSecurityContextSysctl = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  DeploymentSpecTemplateSpecSecurityContextWindowsOptionsModule = types.submodule {
    options = {
      "gmsaCredentialSpec" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "gmsaCredentialSpecName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "hostProcess" = mkOption {
        type = types.bool;
        default = false;
      };
      "runAsUserName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecSecurityContextWindowsOptions =
    res:
    {
    }
    // optionalAttrs (res."gmsaCredentialSpec" != null) { inherit (res) "gmsaCredentialSpec"; }
    // {
    }
    // optionalAttrs (res."gmsaCredentialSpecName" != null) { inherit (res) "gmsaCredentialSpecName"; }
    // {
    }
    // optionalAttrs res."hostProcess" { inherit (res) "hostProcess"; }
    // {
    }
    // optionalAttrs (res."runAsUserName" != null) { inherit (res) "runAsUserName"; }
    // {
    };
  DeploymentSpecTemplateSpecTolerationModule = types.submodule {
    options = {
      "effect" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "key" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "operator" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "tolerationSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "value" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecToleration =
    res:
    {
    }
    // optionalAttrs (res."effect" != null) { inherit (res) "effect"; }
    // {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
    }
    // optionalAttrs (res."operator" != null) { inherit (res) "operator"; }
    // {
    }
    // optionalAttrs (res."tolerationSeconds" != null) { inherit (res) "tolerationSeconds"; }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  DeploymentSpecTemplateSpecTopologySpreadConstraintLabelSelectorMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            type = types.str;
          };
          "operator" = mkOption {
            type = types.str;
          };
          "values" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkDeploymentSpecTemplateSpecTopologySpreadConstraintLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  DeploymentSpecTemplateSpecTopologySpreadConstraintLabelSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        type = (
          types.listOf DeploymentSpecTemplateSpecTopologySpreadConstraintLabelSelectorMatchExpressionModule
        );
        default = [ ];
      };
      "matchLabels" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkDeploymentSpecTemplateSpecTopologySpreadConstraintLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkDeploymentSpecTemplateSpecTopologySpreadConstraintLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  DeploymentSpecTemplateSpecTopologySpreadConstraintModule = types.submodule {
    options = {
      "labelSelector" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecTopologySpreadConstraintLabelSelectorModule);
        default = null;
      };
      "matchLabelKeys" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "maxSkew" = mkOption {
        type = types.int;
      };
      "minDomains" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "nodeAffinityPolicy" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "nodeTaintsPolicy" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "topologyKey" = mkOption {
        type = types.str;
      };
      "whenUnsatisfiable" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecTopologySpreadConstraint =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkDeploymentSpecTemplateSpecTopologySpreadConstraintLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."matchLabelKeys" != [ ]) { inherit (res) "matchLabelKeys"; }
    // {
      inherit (res) "maxSkew";
    }
    // optionalAttrs (res."minDomains" != null) { inherit (res) "minDomains"; }
    // {
    }
    // optionalAttrs (res."nodeAffinityPolicy" != null) { inherit (res) "nodeAffinityPolicy"; }
    // {
    }
    // optionalAttrs (res."nodeTaintsPolicy" != null) { inherit (res) "nodeTaintsPolicy"; }
    // {
      inherit (res) "topologyKey";
      inherit (res) "whenUnsatisfiable";
    };
  DeploymentSpecTemplateSpecVolumeAwsElasticBlockStoreModule = types.submodule {
    options = {
      "fsType" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "partition" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "readOnly" = mkOption {
        type = types.bool;
        default = false;
      };
      "volumeID" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeAwsElasticBlockStore =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."partition" != null) { inherit (res) "partition"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
      inherit (res) "volumeID";
    };
  DeploymentSpecTemplateSpecVolumeAzureDiskModule = types.submodule {
    options = {
      "cachingMode" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "diskName" = mkOption {
        type = types.str;
      };
      "diskURI" = mkOption {
        type = types.str;
      };
      "fsType" = mkOption {
        type = (types.nullOr types.str);
        default = "ext4";
      };
      "kind" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeAzureDisk =
    res:
    {
    }
    // optionalAttrs (res."cachingMode" != null) { inherit (res) "cachingMode"; }
    // {
      inherit (res) "diskName";
      inherit (res) "diskURI";
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."kind" != null) { inherit (res) "kind"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeAzureFileModule = types.submodule {
    options = {
      "readOnly" = mkOption {
        type = types.bool;
        default = false;
      };
      "secretName" = mkOption {
        type = types.str;
      };
      "shareName" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeAzureFile =
    res:
    {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
      inherit (res) "secretName";
      inherit (res) "shareName";
    };
  DeploymentSpecTemplateSpecVolumeCephfsModule = types.submodule {
    options = {
      "monitors" = mkOption {
        type = (types.listOf types.str);
      };
      "path" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        type = types.bool;
        default = false;
      };
      "secretFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "secretRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeCephfsSecretRefModule);
        default = null;
      };
      "user" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeCephfs =
    res:
    {
      inherit (res) "monitors";
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."secretFile" != null) { inherit (res) "secretFile"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkDeploymentSpecTemplateSpecVolumeCephfsSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."user" != null) { inherit (res) "user"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeCephfsSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeCephfsSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeCinderModule = types.submodule {
    options = {
      "fsType" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        type = types.bool;
        default = false;
      };
      "secretRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeCinderSecretRefModule);
        default = null;
      };
      "volumeID" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeCinder =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkDeploymentSpecTemplateSpecVolumeCinderSecretRef res."secretRef";
    }
    // {
      inherit (res) "volumeID";
    };
  DeploymentSpecTemplateSpecVolumeCinderSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeCinderSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeConfigMapItemModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "mode" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeConfigMapItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    };
  DeploymentSpecTemplateSpecVolumeConfigMapModule = types.submodule {
    options = {
      "defaultMode" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "items" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecVolumeConfigMapItemModule);
        default = [ ];
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeConfigMap =
    res:
    {
    }
    // optionalAttrs (res."defaultMode" != null) { inherit (res) "defaultMode"; }
    // {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkDeploymentSpecTemplateSpecVolumeConfigMapItem res."items";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeCsiModule = types.submodule {
    options = {
      "driver" = mkOption {
        type = types.str;
      };
      "fsType" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "nodePublishSecretRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeCsiNodePublishSecretRefModule);
        default = null;
      };
      "readOnly" = mkOption {
        type = types.bool;
        default = false;
      };
      "volumeAttributes" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeCsi =
    res:
    {
      inherit (res) "driver";
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."nodePublishSecretRef" != null) {
      "nodePublishSecretRef" =
        mkDeploymentSpecTemplateSpecVolumeCsiNodePublishSecretRef
          res."nodePublishSecretRef";
    }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."volumeAttributes" != { }) { inherit (res) "volumeAttributes"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeCsiNodePublishSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeCsiNodePublishSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeDownwardAPIItemFieldRefModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "fieldPath" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeDownwardAPIItemFieldRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "fieldPath";
    };
  DeploymentSpecTemplateSpecVolumeDownwardAPIItemModule = types.submodule {
    options = {
      "fieldRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeDownwardAPIItemFieldRefModule);
        default = null;
      };
      "mode" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        type = types.str;
      };
      "resourceFieldRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeDownwardAPIItemResourceFieldRefModule);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeDownwardAPIItem =
    res:
    {
    }
    // optionalAttrs (res."fieldRef" != null) {
      "fieldRef" = mkDeploymentSpecTemplateSpecVolumeDownwardAPIItemFieldRef res."fieldRef";
    }
    // {
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    }
    // optionalAttrs (res."resourceFieldRef" != null) {
      "resourceFieldRef" =
        mkDeploymentSpecTemplateSpecVolumeDownwardAPIItemResourceFieldRef
          res."resourceFieldRef";
    }
    // {
    };
  DeploymentSpecTemplateSpecVolumeDownwardAPIItemResourceFieldRefModule = types.submodule {
    options = {
      "containerName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "divisor" = mkOption {
        type = types.anything;
        default = { };
      };
      "resource" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeDownwardAPIItemResourceFieldRef =
    res:
    {
    }
    // optionalAttrs (res."containerName" != null) { inherit (res) "containerName"; }
    // {
    }
    // optionalAttrs (res."divisor" != null) { inherit (res) "divisor"; }
    // {
      inherit (res) "resource";
    };
  DeploymentSpecTemplateSpecVolumeDownwardAPIModule = types.submodule {
    options = {
      "defaultMode" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "items" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecVolumeDownwardAPIItemModule);
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeDownwardAPI =
    res:
    {
    }
    // optionalAttrs (res."defaultMode" != null) { inherit (res) "defaultMode"; }
    // {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkDeploymentSpecTemplateSpecVolumeDownwardAPIItem res."items";
    }
    // {
    };
  DeploymentSpecTemplateSpecVolumeEmptyDirModule = types.submodule {
    options = {
      "medium" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "sizeLimit" = mkOption {
        type = types.anything;
        default = { };
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeEmptyDir =
    res:
    {
    }
    // optionalAttrs (res."medium" != null) { inherit (res) "medium"; }
    // {
    }
    // optionalAttrs (res."sizeLimit" != null) { inherit (res) "sizeLimit"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeEphemeralModule = types.submodule {
    options = {
      "volumeClaimTemplate" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateModule);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeEphemeral =
    res:
    {
    }
    // optionalAttrs (res."volumeClaimTemplate" != null) {
      "volumeClaimTemplate" =
        mkDeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplate
          res."volumeClaimTemplate";
    }
    // {
    };
  DeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateModule = types.submodule {
    options = {
      "metadata" = mkOption {
        type = (types.attrsOf types.anything);
        default = { };
      };
      "spec" = mkOption {
        type = DeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecModule;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplate =
    res:
    {
    }
    // optionalAttrs (res."metadata" != { }) { inherit (res) "metadata"; }
    // {
      "spec" = mkDeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateSpec res."spec";
    };
  DeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecDataSourceModule = types.submodule {
    options = {
      "apiGroup" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "kind" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecDataSource =
    res:
    {
    }
    // optionalAttrs (res."apiGroup" != null) { inherit (res) "apiGroup"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    };
  DeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecDataSourceRefModule =
    types.submodule
      {
        options = {
          "apiGroup" = mkOption {
            type = (types.nullOr types.str);
            default = null;
          };
          "kind" = mkOption {
            type = types.str;
          };
          "name" = mkOption {
            type = types.str;
          };
          "namespace" = mkOption {
            type = (types.nullOr types.str);
            default = null;
          };
        };
      };
  mkDeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecDataSourceRef =
    res:
    {
    }
    // optionalAttrs (res."apiGroup" != null) { inherit (res) "apiGroup"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecModule = types.submodule {
    options = {
      "accessModes" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "dataSource" = mkOption {
        type = (
          types.nullOr DeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecDataSourceModule
        );
        default = null;
      };
      "dataSourceRef" = mkOption {
        type = (
          types.nullOr DeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecDataSourceRefModule
        );
        default = null;
      };
      "resources" = mkOption {
        type = (
          types.nullOr DeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecResourcesModule
        );
        default = null;
      };
      "selector" = mkOption {
        type = (
          types.nullOr DeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecSelectorModule
        );
        default = null;
      };
      "storageClassName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeAttributesClassName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeMode" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateSpec =
    res:
    {
    }
    // optionalAttrs (res."accessModes" != [ ]) { inherit (res) "accessModes"; }
    // {
    }
    // optionalAttrs (res."dataSource" != null) {
      "dataSource" =
        mkDeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecDataSource
          res."dataSource";
    }
    // {
    }
    // optionalAttrs (res."dataSourceRef" != null) {
      "dataSourceRef" =
        mkDeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecDataSourceRef
          res."dataSourceRef";
    }
    // {
    }
    // optionalAttrs (res."resources" != null) {
      "resources" =
        mkDeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecResources
          res."resources";
    }
    // {
    }
    // optionalAttrs (res."selector" != null) {
      "selector" =
        mkDeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecSelector
          res."selector";
    }
    // {
    }
    // optionalAttrs (res."storageClassName" != null) { inherit (res) "storageClassName"; }
    // {
    }
    // optionalAttrs (res."volumeAttributesClassName" != null) {
      inherit (res) "volumeAttributesClassName";
    }
    // {
    }
    // optionalAttrs (res."volumeMode" != null) { inherit (res) "volumeMode"; }
    // {
    }
    // optionalAttrs (res."volumeName" != null) { inherit (res) "volumeName"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecResourcesModule = types.submodule {
    options = {
      "limits" = mkOption {
        type = (types.attrsOf types.anything);
        default = { };
      };
      "requests" = mkOption {
        type = (types.attrsOf types.anything);
        default = { };
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecResources =
    res:
    {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecSelectorMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            type = types.str;
          };
          "operator" = mkOption {
            type = types.str;
          };
          "values" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkDeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        type = (
          types.listOf DeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecSelectorMatchExpressionModule
        );
        default = [ ];
      };
      "matchLabels" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkDeploymentSpecTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeFcModule = types.submodule {
    options = {
      "fsType" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "lun" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "readOnly" = mkOption {
        type = types.bool;
        default = false;
      };
      "targetWWNs" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "wwids" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeFc =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."lun" != null) { inherit (res) "lun"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."targetWWNs" != [ ]) { inherit (res) "targetWWNs"; }
    // {
    }
    // optionalAttrs (res."wwids" != [ ]) { inherit (res) "wwids"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeFlexVolumeModule = types.submodule {
    options = {
      "driver" = mkOption {
        type = types.str;
      };
      "fsType" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "options" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "readOnly" = mkOption {
        type = types.bool;
        default = false;
      };
      "secretRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeFlexVolumeSecretRefModule);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeFlexVolume =
    res:
    {
      inherit (res) "driver";
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."options" != { }) { inherit (res) "options"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkDeploymentSpecTemplateSpecVolumeFlexVolumeSecretRef res."secretRef";
    }
    // {
    };
  DeploymentSpecTemplateSpecVolumeFlexVolumeSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeFlexVolumeSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeFlockerModule = types.submodule {
    options = {
      "datasetName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "datasetUUID" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeFlocker =
    res:
    {
    }
    // optionalAttrs (res."datasetName" != null) { inherit (res) "datasetName"; }
    // {
    }
    // optionalAttrs (res."datasetUUID" != null) { inherit (res) "datasetUUID"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeGcePersistentDiskModule = types.submodule {
    options = {
      "fsType" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "partition" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "pdName" = mkOption {
        type = types.str;
      };
      "readOnly" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeGcePersistentDisk =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."partition" != null) { inherit (res) "partition"; }
    // {
      inherit (res) "pdName";
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeGitRepoModule = types.submodule {
    options = {
      "directory" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "repository" = mkOption {
        type = types.str;
      };
      "revision" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeGitRepo =
    res:
    {
    }
    // optionalAttrs (res."directory" != null) { inherit (res) "directory"; }
    // {
      inherit (res) "repository";
    }
    // optionalAttrs (res."revision" != null) { inherit (res) "revision"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeGlusterfsModule = types.submodule {
    options = {
      "endpoints" = mkOption {
        type = types.str;
      };
      "path" = mkOption {
        type = types.str;
      };
      "readOnly" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeGlusterfs =
    res:
    {
      inherit (res) "endpoints";
      inherit (res) "path";
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeHostPathModule = types.submodule {
    options = {
      "path" = mkOption {
        type = types.str;
      };
      "type" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeHostPath =
    res:
    {
      inherit (res) "path";
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeImageModule = types.submodule {
    options = {
      "pullPolicy" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "reference" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeImage =
    res:
    {
    }
    // optionalAttrs (res."pullPolicy" != null) { inherit (res) "pullPolicy"; }
    // {
    }
    // optionalAttrs (res."reference" != null) { inherit (res) "reference"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeIscsiModule = types.submodule {
    options = {
      "chapAuthDiscovery" = mkOption {
        type = types.bool;
        default = false;
      };
      "chapAuthSession" = mkOption {
        type = types.bool;
        default = false;
      };
      "fsType" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "initiatorName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "iqn" = mkOption {
        type = types.str;
      };
      "iscsiInterface" = mkOption {
        type = (types.nullOr types.str);
        default = "default";
      };
      "lun" = mkOption {
        type = types.int;
      };
      "portals" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "readOnly" = mkOption {
        type = types.bool;
        default = false;
      };
      "secretRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeIscsiSecretRefModule);
        default = null;
      };
      "targetPortal" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeIscsi =
    res:
    {
    }
    // optionalAttrs res."chapAuthDiscovery" { inherit (res) "chapAuthDiscovery"; }
    // {
    }
    // optionalAttrs res."chapAuthSession" { inherit (res) "chapAuthSession"; }
    // {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."initiatorName" != null) { inherit (res) "initiatorName"; }
    // {
      inherit (res) "iqn";
    }
    // optionalAttrs (res."iscsiInterface" != null) { inherit (res) "iscsiInterface"; }
    // {
      inherit (res) "lun";
    }
    // optionalAttrs (res."portals" != [ ]) { inherit (res) "portals"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkDeploymentSpecTemplateSpecVolumeIscsiSecretRef res."secretRef";
    }
    // {
      inherit (res) "targetPortal";
    };
  DeploymentSpecTemplateSpecVolumeIscsiSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeIscsiSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeModule = types.submodule {
    options = {
      "awsElasticBlockStore" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeAwsElasticBlockStoreModule);
        default = null;
      };
      "azureDisk" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeAzureDiskModule);
        default = null;
      };
      "azureFile" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeAzureFileModule);
        default = null;
      };
      "cephfs" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeCephfsModule);
        default = null;
      };
      "cinder" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeCinderModule);
        default = null;
      };
      "configMap" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeConfigMapModule);
        default = null;
      };
      "csi" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeCsiModule);
        default = null;
      };
      "downwardAPI" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeDownwardAPIModule);
        default = null;
      };
      "emptyDir" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeEmptyDirModule);
        default = null;
      };
      "ephemeral" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeEphemeralModule);
        default = null;
      };
      "fc" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeFcModule);
        default = null;
      };
      "flexVolume" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeFlexVolumeModule);
        default = null;
      };
      "flocker" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeFlockerModule);
        default = null;
      };
      "gcePersistentDisk" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeGcePersistentDiskModule);
        default = null;
      };
      "gitRepo" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeGitRepoModule);
        default = null;
      };
      "glusterfs" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeGlusterfsModule);
        default = null;
      };
      "hostPath" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeHostPathModule);
        default = null;
      };
      "image" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeImageModule);
        default = null;
      };
      "iscsi" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeIscsiModule);
        default = null;
      };
      "name" = mkOption {
        type = types.str;
      };
      "nfs" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeNfsModule);
        default = null;
      };
      "persistentVolumeClaim" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumePersistentVolumeClaimModule);
        default = null;
      };
      "photonPersistentDisk" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumePhotonPersistentDiskModule);
        default = null;
      };
      "portworxVolume" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumePortworxVolumeModule);
        default = null;
      };
      "projected" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeProjectedModule);
        default = null;
      };
      "quobyte" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeQuobyteModule);
        default = null;
      };
      "rbd" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeRbdModule);
        default = null;
      };
      "scaleIO" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeScaleIOModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeSecretModule);
        default = null;
      };
      "storageos" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeStorageosModule);
        default = null;
      };
      "vsphereVolume" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeVsphereVolumeModule);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolume =
    res:
    {
    }
    // optionalAttrs (res."awsElasticBlockStore" != null) {
      "awsElasticBlockStore" =
        mkDeploymentSpecTemplateSpecVolumeAwsElasticBlockStore
          res."awsElasticBlockStore";
    }
    // {
    }
    // optionalAttrs (res."azureDisk" != null) {
      "azureDisk" = mkDeploymentSpecTemplateSpecVolumeAzureDisk res."azureDisk";
    }
    // {
    }
    // optionalAttrs (res."azureFile" != null) {
      "azureFile" = mkDeploymentSpecTemplateSpecVolumeAzureFile res."azureFile";
    }
    // {
    }
    // optionalAttrs (res."cephfs" != null) {
      "cephfs" = mkDeploymentSpecTemplateSpecVolumeCephfs res."cephfs";
    }
    // {
    }
    // optionalAttrs (res."cinder" != null) {
      "cinder" = mkDeploymentSpecTemplateSpecVolumeCinder res."cinder";
    }
    // {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkDeploymentSpecTemplateSpecVolumeConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."csi" != null) { "csi" = mkDeploymentSpecTemplateSpecVolumeCsi res."csi"; }
    // {
    }
    // optionalAttrs (res."downwardAPI" != null) {
      "downwardAPI" = mkDeploymentSpecTemplateSpecVolumeDownwardAPI res."downwardAPI";
    }
    // {
    }
    // optionalAttrs (res."emptyDir" != null) {
      "emptyDir" = mkDeploymentSpecTemplateSpecVolumeEmptyDir res."emptyDir";
    }
    // {
    }
    // optionalAttrs (res."ephemeral" != null) {
      "ephemeral" = mkDeploymentSpecTemplateSpecVolumeEphemeral res."ephemeral";
    }
    // {
    }
    // optionalAttrs (res."fc" != null) { "fc" = mkDeploymentSpecTemplateSpecVolumeFc res."fc"; }
    // {
    }
    // optionalAttrs (res."flexVolume" != null) {
      "flexVolume" = mkDeploymentSpecTemplateSpecVolumeFlexVolume res."flexVolume";
    }
    // {
    }
    // optionalAttrs (res."flocker" != null) {
      "flocker" = mkDeploymentSpecTemplateSpecVolumeFlocker res."flocker";
    }
    // {
    }
    // optionalAttrs (res."gcePersistentDisk" != null) {
      "gcePersistentDisk" = mkDeploymentSpecTemplateSpecVolumeGcePersistentDisk res."gcePersistentDisk";
    }
    // {
    }
    // optionalAttrs (res."gitRepo" != null) {
      "gitRepo" = mkDeploymentSpecTemplateSpecVolumeGitRepo res."gitRepo";
    }
    // {
    }
    // optionalAttrs (res."glusterfs" != null) {
      "glusterfs" = mkDeploymentSpecTemplateSpecVolumeGlusterfs res."glusterfs";
    }
    // {
    }
    // optionalAttrs (res."hostPath" != null) {
      "hostPath" = mkDeploymentSpecTemplateSpecVolumeHostPath res."hostPath";
    }
    // {
    }
    // optionalAttrs (res."image" != null) {
      "image" = mkDeploymentSpecTemplateSpecVolumeImage res."image";
    }
    // {
    }
    // optionalAttrs (res."iscsi" != null) {
      "iscsi" = mkDeploymentSpecTemplateSpecVolumeIscsi res."iscsi";
    }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."nfs" != null) { "nfs" = mkDeploymentSpecTemplateSpecVolumeNfs res."nfs"; }
    // {
    }
    // optionalAttrs (res."persistentVolumeClaim" != null) {
      "persistentVolumeClaim" =
        mkDeploymentSpecTemplateSpecVolumePersistentVolumeClaim
          res."persistentVolumeClaim";
    }
    // {
    }
    // optionalAttrs (res."photonPersistentDisk" != null) {
      "photonPersistentDisk" =
        mkDeploymentSpecTemplateSpecVolumePhotonPersistentDisk
          res."photonPersistentDisk";
    }
    // {
    }
    // optionalAttrs (res."portworxVolume" != null) {
      "portworxVolume" = mkDeploymentSpecTemplateSpecVolumePortworxVolume res."portworxVolume";
    }
    // {
    }
    // optionalAttrs (res."projected" != null) {
      "projected" = mkDeploymentSpecTemplateSpecVolumeProjected res."projected";
    }
    // {
    }
    // optionalAttrs (res."quobyte" != null) {
      "quobyte" = mkDeploymentSpecTemplateSpecVolumeQuobyte res."quobyte";
    }
    // {
    }
    // optionalAttrs (res."rbd" != null) { "rbd" = mkDeploymentSpecTemplateSpecVolumeRbd res."rbd"; }
    // {
    }
    // optionalAttrs (res."scaleIO" != null) {
      "scaleIO" = mkDeploymentSpecTemplateSpecVolumeScaleIO res."scaleIO";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkDeploymentSpecTemplateSpecVolumeSecret res."secret";
    }
    // {
    }
    // optionalAttrs (res."storageos" != null) {
      "storageos" = mkDeploymentSpecTemplateSpecVolumeStorageos res."storageos";
    }
    // {
    }
    // optionalAttrs (res."vsphereVolume" != null) {
      "vsphereVolume" = mkDeploymentSpecTemplateSpecVolumeVsphereVolume res."vsphereVolume";
    }
    // {
    };
  DeploymentSpecTemplateSpecVolumeNfsModule = types.submodule {
    options = {
      "path" = mkOption {
        type = types.str;
      };
      "readOnly" = mkOption {
        type = types.bool;
        default = false;
      };
      "server" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeNfs =
    res:
    {
      inherit (res) "path";
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
      inherit (res) "server";
    };
  DeploymentSpecTemplateSpecVolumePersistentVolumeClaimModule = types.submodule {
    options = {
      "claimName" = mkOption {
        type = types.str;
      };
      "readOnly" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumePersistentVolumeClaim =
    res:
    {
      inherit (res) "claimName";
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumePhotonPersistentDiskModule = types.submodule {
    options = {
      "fsType" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "pdID" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumePhotonPersistentDisk =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
      inherit (res) "pdID";
    };
  DeploymentSpecTemplateSpecVolumePortworxVolumeModule = types.submodule {
    options = {
      "fsType" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        type = types.bool;
        default = false;
      };
      "volumeID" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumePortworxVolume =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
      inherit (res) "volumeID";
    };
  DeploymentSpecTemplateSpecVolumeProjectedModule = types.submodule {
    options = {
      "defaultMode" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "sources" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecVolumeProjectedSourceModule);
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeProjected =
    res:
    {
    }
    // optionalAttrs (res."defaultMode" != null) { inherit (res) "defaultMode"; }
    // {
    }
    // optionalAttrs (res."sources" != [ ]) {
      "sources" = map mkDeploymentSpecTemplateSpecVolumeProjectedSource res."sources";
    }
    // {
    };
  DeploymentSpecTemplateSpecVolumeProjectedSourceClusterTrustBundleLabelSelectorMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            type = types.str;
          };
          "operator" = mkOption {
            type = types.str;
          };
          "values" = mkOption {
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkDeploymentSpecTemplateSpecVolumeProjectedSourceClusterTrustBundleLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeProjectedSourceClusterTrustBundleLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            type = (
              types.listOf DeploymentSpecTemplateSpecVolumeProjectedSourceClusterTrustBundleLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkDeploymentSpecTemplateSpecVolumeProjectedSourceClusterTrustBundleLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkDeploymentSpecTemplateSpecVolumeProjectedSourceClusterTrustBundleLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeProjectedSourceClusterTrustBundleModule = types.submodule {
    options = {
      "labelSelector" = mkOption {
        type = (
          types.nullOr DeploymentSpecTemplateSpecVolumeProjectedSourceClusterTrustBundleLabelSelectorModule
        );
        default = null;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
      "path" = mkOption {
        type = types.str;
      };
      "signerName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeProjectedSourceClusterTrustBundle =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkDeploymentSpecTemplateSpecVolumeProjectedSourceClusterTrustBundleLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
      inherit (res) "path";
    }
    // optionalAttrs (res."signerName" != null) { inherit (res) "signerName"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeProjectedSourceConfigMapItemModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "mode" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeProjectedSourceConfigMapItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    };
  DeploymentSpecTemplateSpecVolumeProjectedSourceConfigMapModule = types.submodule {
    options = {
      "items" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecVolumeProjectedSourceConfigMapItemModule);
        default = [ ];
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeProjectedSourceConfigMap =
    res:
    {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkDeploymentSpecTemplateSpecVolumeProjectedSourceConfigMapItem res."items";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeProjectedSourceDownwardAPIItemFieldRefModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "fieldPath" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeProjectedSourceDownwardAPIItemFieldRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "fieldPath";
    };
  DeploymentSpecTemplateSpecVolumeProjectedSourceDownwardAPIItemModule = types.submodule {
    options = {
      "fieldRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeProjectedSourceDownwardAPIItemFieldRefModule);
        default = null;
      };
      "mode" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        type = types.str;
      };
      "resourceFieldRef" = mkOption {
        type = (
          types.nullOr DeploymentSpecTemplateSpecVolumeProjectedSourceDownwardAPIItemResourceFieldRefModule
        );
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeProjectedSourceDownwardAPIItem =
    res:
    {
    }
    // optionalAttrs (res."fieldRef" != null) {
      "fieldRef" =
        mkDeploymentSpecTemplateSpecVolumeProjectedSourceDownwardAPIItemFieldRef
          res."fieldRef";
    }
    // {
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    }
    // optionalAttrs (res."resourceFieldRef" != null) {
      "resourceFieldRef" =
        mkDeploymentSpecTemplateSpecVolumeProjectedSourceDownwardAPIItemResourceFieldRef
          res."resourceFieldRef";
    }
    // {
    };
  DeploymentSpecTemplateSpecVolumeProjectedSourceDownwardAPIItemResourceFieldRefModule =
    types.submodule
      {
        options = {
          "containerName" = mkOption {
            type = (types.nullOr types.str);
            default = null;
          };
          "divisor" = mkOption {
            type = types.anything;
            default = { };
          };
          "resource" = mkOption {
            type = types.str;
          };
        };
      };
  mkDeploymentSpecTemplateSpecVolumeProjectedSourceDownwardAPIItemResourceFieldRef =
    res:
    {
    }
    // optionalAttrs (res."containerName" != null) { inherit (res) "containerName"; }
    // {
    }
    // optionalAttrs (res."divisor" != null) { inherit (res) "divisor"; }
    // {
      inherit (res) "resource";
    };
  DeploymentSpecTemplateSpecVolumeProjectedSourceDownwardAPIModule = types.submodule {
    options = {
      "items" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecVolumeProjectedSourceDownwardAPIItemModule);
        default = [ ];
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeProjectedSourceDownwardAPI =
    res:
    {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkDeploymentSpecTemplateSpecVolumeProjectedSourceDownwardAPIItem res."items";
    }
    // {
    };
  DeploymentSpecTemplateSpecVolumeProjectedSourceModule = types.submodule {
    options = {
      "clusterTrustBundle" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeProjectedSourceClusterTrustBundleModule);
        default = null;
      };
      "configMap" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeProjectedSourceConfigMapModule);
        default = null;
      };
      "downwardAPI" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeProjectedSourceDownwardAPIModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeProjectedSourceSecretModule);
        default = null;
      };
      "serviceAccountToken" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeProjectedSourceServiceAccountTokenModule);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeProjectedSource =
    res:
    {
    }
    // optionalAttrs (res."clusterTrustBundle" != null) {
      "clusterTrustBundle" =
        mkDeploymentSpecTemplateSpecVolumeProjectedSourceClusterTrustBundle
          res."clusterTrustBundle";
    }
    // {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkDeploymentSpecTemplateSpecVolumeProjectedSourceConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."downwardAPI" != null) {
      "downwardAPI" = mkDeploymentSpecTemplateSpecVolumeProjectedSourceDownwardAPI res."downwardAPI";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkDeploymentSpecTemplateSpecVolumeProjectedSourceSecret res."secret";
    }
    // {
    }
    // optionalAttrs (res."serviceAccountToken" != null) {
      "serviceAccountToken" =
        mkDeploymentSpecTemplateSpecVolumeProjectedSourceServiceAccountToken
          res."serviceAccountToken";
    }
    // {
    };
  DeploymentSpecTemplateSpecVolumeProjectedSourceSecretItemModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "mode" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeProjectedSourceSecretItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    };
  DeploymentSpecTemplateSpecVolumeProjectedSourceSecretModule = types.submodule {
    options = {
      "items" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecVolumeProjectedSourceSecretItemModule);
        default = [ ];
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeProjectedSourceSecret =
    res:
    {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkDeploymentSpecTemplateSpecVolumeProjectedSourceSecretItem res."items";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeProjectedSourceServiceAccountTokenModule = types.submodule {
    options = {
      "audience" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "expirationSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeProjectedSourceServiceAccountToken =
    res:
    {
    }
    // optionalAttrs (res."audience" != null) { inherit (res) "audience"; }
    // {
    }
    // optionalAttrs (res."expirationSeconds" != null) { inherit (res) "expirationSeconds"; }
    // {
      inherit (res) "path";
    };
  DeploymentSpecTemplateSpecVolumeQuobyteModule = types.submodule {
    options = {
      "group" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        type = types.bool;
        default = false;
      };
      "registry" = mkOption {
        type = types.str;
      };
      "tenant" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "user" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "volume" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeQuobyte =
    res:
    {
    }
    // optionalAttrs (res."group" != null) { inherit (res) "group"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
      inherit (res) "registry";
    }
    // optionalAttrs (res."tenant" != null) { inherit (res) "tenant"; }
    // {
    }
    // optionalAttrs (res."user" != null) { inherit (res) "user"; }
    // {
      inherit (res) "volume";
    };
  DeploymentSpecTemplateSpecVolumeRbdModule = types.submodule {
    options = {
      "fsType" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "image" = mkOption {
        type = types.str;
      };
      "keyring" = mkOption {
        type = (types.nullOr types.str);
        default = "/etc/ceph/keyring";
      };
      "monitors" = mkOption {
        type = (types.listOf types.str);
      };
      "pool" = mkOption {
        type = (types.nullOr types.str);
        default = "rbd";
      };
      "readOnly" = mkOption {
        type = types.bool;
        default = false;
      };
      "secretRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeRbdSecretRefModule);
        default = null;
      };
      "user" = mkOption {
        type = (types.nullOr types.str);
        default = "admin";
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeRbd =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
      inherit (res) "image";
    }
    // optionalAttrs (res."keyring" != null) { inherit (res) "keyring"; }
    // {
      inherit (res) "monitors";
    }
    // optionalAttrs (res."pool" != null) { inherit (res) "pool"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkDeploymentSpecTemplateSpecVolumeRbdSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."user" != null) { inherit (res) "user"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeRbdSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeRbdSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeScaleIOModule = types.submodule {
    options = {
      "fsType" = mkOption {
        type = (types.nullOr types.str);
        default = "xfs";
      };
      "gateway" = mkOption {
        type = types.str;
      };
      "protectionDomain" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        type = types.bool;
        default = false;
      };
      "secretRef" = mkOption {
        type = DeploymentSpecTemplateSpecVolumeScaleIOSecretRefModule;
      };
      "sslEnabled" = mkOption {
        type = types.bool;
        default = false;
      };
      "storageMode" = mkOption {
        type = (types.nullOr types.str);
        default = "ThinProvisioned";
      };
      "storagePool" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "system" = mkOption {
        type = types.str;
      };
      "volumeName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeScaleIO =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
      inherit (res) "gateway";
    }
    // optionalAttrs (res."protectionDomain" != null) { inherit (res) "protectionDomain"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
      "secretRef" = mkDeploymentSpecTemplateSpecVolumeScaleIOSecretRef res."secretRef";
    }
    // optionalAttrs res."sslEnabled" { inherit (res) "sslEnabled"; }
    // {
    }
    // optionalAttrs (res."storageMode" != null) { inherit (res) "storageMode"; }
    // {
    }
    // optionalAttrs (res."storagePool" != null) { inherit (res) "storagePool"; }
    // {
      inherit (res) "system";
    }
    // optionalAttrs (res."volumeName" != null) { inherit (res) "volumeName"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeScaleIOSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeScaleIOSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeSecretItemModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "mode" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeSecretItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    };
  DeploymentSpecTemplateSpecVolumeSecretModule = types.submodule {
    options = {
      "defaultMode" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "items" = mkOption {
        type = (types.listOf DeploymentSpecTemplateSpecVolumeSecretItemModule);
        default = [ ];
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
      "secretName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeSecret =
    res:
    {
    }
    // optionalAttrs (res."defaultMode" != null) { inherit (res) "defaultMode"; }
    // {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkDeploymentSpecTemplateSpecVolumeSecretItem res."items";
    }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    }
    // optionalAttrs (res."secretName" != null) { inherit (res) "secretName"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeStorageosModule = types.submodule {
    options = {
      "fsType" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        type = types.bool;
        default = false;
      };
      "secretRef" = mkOption {
        type = (types.nullOr DeploymentSpecTemplateSpecVolumeStorageosSecretRefModule);
        default = null;
      };
      "volumeName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeNamespace" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeStorageos =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkDeploymentSpecTemplateSpecVolumeStorageosSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."volumeName" != null) { inherit (res) "volumeName"; }
    // {
    }
    // optionalAttrs (res."volumeNamespace" != null) { inherit (res) "volumeNamespace"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeStorageosSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeStorageosSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  DeploymentSpecTemplateSpecVolumeVsphereVolumeModule = types.submodule {
    options = {
      "fsType" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "storagePolicyID" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "storagePolicyName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "volumePath" = mkOption {
        type = types.str;
      };
    };
  };
  mkDeploymentSpecTemplateSpecVolumeVsphereVolume =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."storagePolicyID" != null) { inherit (res) "storagePolicyID"; }
    // {
    }
    // optionalAttrs (res."storagePolicyName" != null) { inherit (res) "storagePolicyName"; }
    // {
      inherit (res) "volumePath";
    };
  ExternalAdminPasswordModule = types.submodule {
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
  mkExternalAdminPassword =
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
  ExternalAdminUserModule = types.submodule {
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
  mkExternalAdminUser =
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
  ExternalApiKeyModule = types.submodule {
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
  mkExternalApiKey =
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
  ExternalModule = types.submodule {
    options = {
      "adminPassword" = mkOption {
        description = "AdminPassword key to talk to the external grafana instance.";
        type = (types.nullOr ExternalAdminPasswordModule);
        default = null;
      };
      "adminUser" = mkOption {
        description = "AdminUser key to talk to the external grafana instance.";
        type = (types.nullOr ExternalAdminUserModule);
        default = null;
      };
      "apiKey" = mkOption {
        description = "The API key to talk to the external grafana instance, you need to define ether apiKey or adminUser/adminPassword.";
        type = (types.nullOr ExternalApiKeyModule);
        default = null;
      };
      "tls" = mkOption {
        description = "DEPRECATED, use top level `tls` instead.";
        type = (types.nullOr ExternalTlsModule);
        default = null;
      };
      "url" = mkOption {
        description = "URL of the external grafana instance you want to manage.";
        type = types.str;
      };
    };
  };
  mkExternal =
    res:
    {
    }
    // optionalAttrs (res."adminPassword" != null) {
      "adminPassword" = mkExternalAdminPassword res."adminPassword";
    }
    // {
    }
    // optionalAttrs (res."adminUser" != null) { "adminUser" = mkExternalAdminUser res."adminUser"; }
    // {
    }
    // optionalAttrs (res."apiKey" != null) { "apiKey" = mkExternalApiKey res."apiKey"; }
    // {
    }
    // optionalAttrs (res."tls" != null) { "tls" = mkExternalTls res."tls"; }
    // {
      inherit (res) "url";
    };
  ExternalTlsCertSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "name is unique within a namespace to reference a secret resource.";
        type = (types.nullOr types.str);
        default = null;
      };
      "namespace" = mkOption {
        description = "namespace defines the space within which the secret name must be unique.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkExternalTlsCertSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  ExternalTlsModule = types.submodule {
    options = {
      "certSecretRef" = mkOption {
        description = "Use a secret as a reference to give TLS Certificate information";
        type = (types.nullOr ExternalTlsCertSecretRefModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable the CA check of the server";
        type = types.bool;
        default = false;
      };
    };
  };
  mkExternalTls =
    res:
    {
    }
    // optionalAttrs (res."certSecretRef" != null) {
      "certSecretRef" = mkExternalTlsCertSecretRef res."certSecretRef";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    };
  IngressMetadataModule = types.submodule {
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
  mkIngressMetadata =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    };
  IngressModule = types.submodule {
    options = {
      "metadata" = mkOption {
        description = "ObjectMeta contains only a [subset of the fields included in k8s.io/apimachinery/pkg/apis/meta/v1.ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.27/#objectmeta-v1-meta).";
        type = (types.nullOr IngressMetadataModule);
        default = null;
      };
      "spec" = mkOption {
        description = "IngressSpec describes the Ingress the user wishes to exist.";
        type = (types.nullOr IngressSpecModule);
        default = null;
      };
    };
  };
  mkIngress =
    res:
    {
    }
    // optionalAttrs (res."metadata" != null) { "metadata" = mkIngressMetadata res."metadata"; }
    // {
    }
    // optionalAttrs (res."spec" != null) { "spec" = mkIngressSpec res."spec"; }
    // {
    };
  IngressSpecDefaultBackendModule = types.submodule {
    options = {
      "resource" = mkOption {
        description = "resource is an ObjectRef to another Kubernetes resource in the namespace\nof the Ingress object. If resource is specified, a service.Name and\nservice.Port must not be specified.\nThis is a mutually exclusive setting with \"Service\".";
        type = (types.nullOr IngressSpecDefaultBackendResourceModule);
        default = null;
      };
      "service" = mkOption {
        description = "service references a service as a backend.\nThis is a mutually exclusive setting with \"Resource\".";
        type = (types.nullOr IngressSpecDefaultBackendServiceModule);
        default = null;
      };
    };
  };
  mkIngressSpecDefaultBackend =
    res:
    {
    }
    // optionalAttrs (res."resource" != null) {
      "resource" = mkIngressSpecDefaultBackendResource res."resource";
    }
    // {
    }
    // optionalAttrs (res."service" != null) {
      "service" = mkIngressSpecDefaultBackendService res."service";
    }
    // {
    };
  IngressSpecDefaultBackendResourceModule = types.submodule {
    options = {
      "apiGroup" = mkOption {
        description = "APIGroup is the group for the resource being referenced.\nIf APIGroup is not specified, the specified Kind must be in the core API group.\nFor any other third-party types, APIGroup is required.";
        type = (types.nullOr types.str);
        default = null;
      };
      "kind" = mkOption {
        description = "Kind is the type of resource being referenced";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name is the name of resource being referenced";
        type = types.str;
      };
    };
  };
  mkIngressSpecDefaultBackendResource =
    res:
    {
    }
    // optionalAttrs (res."apiGroup" != null) { inherit (res) "apiGroup"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    };
  IngressSpecDefaultBackendServiceModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "name is the referenced service. The service must exist in\nthe same namespace as the Ingress object.";
        type = types.str;
      };
      "port" = mkOption {
        description = "port of the referenced service. A port name or port number\nis required for a IngressServiceBackend.";
        type = (types.nullOr IngressSpecDefaultBackendServicePortModule);
        default = null;
      };
    };
  };
  mkIngressSpecDefaultBackendService =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."port" != null) {
      "port" = mkIngressSpecDefaultBackendServicePort res."port";
    }
    // {
    };
  IngressSpecDefaultBackendServicePortModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "name is the name of the port on the Service.\nThis is a mutually exclusive setting with \"Number\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "number" = mkOption {
        description = "number is the numerical port number (e.g. 80) on the Service.\nThis is a mutually exclusive setting with \"Name\".";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkIngressSpecDefaultBackendServicePort =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."number" != null) { inherit (res) "number"; }
    // {
    };
  IngressSpecModule = types.submodule {
    options = {
      "defaultBackend" = mkOption {
        description = "defaultBackend is the backend that should handle requests that don't\nmatch any rule. If Rules are not specified, DefaultBackend must be specified.\nIf DefaultBackend is not set, the handling of requests that do not match any\nof the rules will be up to the Ingress controller.";
        type = (types.nullOr IngressSpecDefaultBackendModule);
        default = null;
      };
      "ingressClassName" = mkOption {
        description = "ingressClassName is the name of an IngressClass cluster resource. Ingress\ncontroller implementations use this field to know whether they should be\nserving this Ingress resource, by a transitive connection\n(controller -> IngressClass -> Ingress resource). Although the\n`kubernetes.io/ingress.class` annotation (simple constant name) was never\nformally defined, it was widely supported by Ingress controllers to create\na direct binding between Ingress controller and Ingress resources. Newly\ncreated Ingress resources should prefer using the field. However, even\nthough the annotation is officially deprecated, for backwards compatibility\nreasons, ingress controllers should still honor that annotation if present.";
        type = (types.nullOr types.str);
        default = null;
      };
      "rules" = mkOption {
        description = "rules is a list of host rules used to configure the Ingress. If unspecified,\nor no rule matches, all traffic is sent to the default backend.";
        type = (types.listOf IngressSpecRuleModule);
        default = [ ];
      };
      "tls" = mkOption {
        description = "tls represents the TLS configuration. Currently the Ingress only supports a\nsingle TLS port, 443. If multiple members of this list specify different hosts,\nthey will be multiplexed on the same port according to the hostname specified\nthrough the SNI TLS extension, if the ingress controller fulfilling the\ningress supports SNI.";
        type = (types.listOf IngressSpecTlModule);
        default = [ ];
      };
    };
  };
  mkIngressSpec =
    res:
    {
    }
    // optionalAttrs (res."defaultBackend" != null) {
      "defaultBackend" = mkIngressSpecDefaultBackend res."defaultBackend";
    }
    // {
    }
    // optionalAttrs (res."ingressClassName" != null) { inherit (res) "ingressClassName"; }
    // {
    }
    // optionalAttrs (res."rules" != [ ]) { "rules" = map mkIngressSpecRule res."rules"; }
    // {
    }
    // optionalAttrs (res."tls" != [ ]) { "tls" = map mkIngressSpecTl res."tls"; }
    // {
    };
  IngressSpecRuleHttpModule = types.submodule {
    options = {
      "paths" = mkOption {
        description = "paths is a collection of paths that map requests to backends.";
        type = (types.listOf IngressSpecRuleHttpPathModule);
      };
    };
  };
  mkIngressSpecRuleHttp = res: {
    "paths" = map mkIngressSpecRuleHttpPath res."paths";
  };
  IngressSpecRuleHttpPathBackendModule = types.submodule {
    options = {
      "resource" = mkOption {
        description = "resource is an ObjectRef to another Kubernetes resource in the namespace\nof the Ingress object. If resource is specified, a service.Name and\nservice.Port must not be specified.\nThis is a mutually exclusive setting with \"Service\".";
        type = (types.nullOr IngressSpecRuleHttpPathBackendResourceModule);
        default = null;
      };
      "service" = mkOption {
        description = "service references a service as a backend.\nThis is a mutually exclusive setting with \"Resource\".";
        type = (types.nullOr IngressSpecRuleHttpPathBackendServiceModule);
        default = null;
      };
    };
  };
  mkIngressSpecRuleHttpPathBackend =
    res:
    {
    }
    // optionalAttrs (res."resource" != null) {
      "resource" = mkIngressSpecRuleHttpPathBackendResource res."resource";
    }
    // {
    }
    // optionalAttrs (res."service" != null) {
      "service" = mkIngressSpecRuleHttpPathBackendService res."service";
    }
    // {
    };
  IngressSpecRuleHttpPathBackendResourceModule = types.submodule {
    options = {
      "apiGroup" = mkOption {
        description = "APIGroup is the group for the resource being referenced.\nIf APIGroup is not specified, the specified Kind must be in the core API group.\nFor any other third-party types, APIGroup is required.";
        type = (types.nullOr types.str);
        default = null;
      };
      "kind" = mkOption {
        description = "Kind is the type of resource being referenced";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name is the name of resource being referenced";
        type = types.str;
      };
    };
  };
  mkIngressSpecRuleHttpPathBackendResource =
    res:
    {
    }
    // optionalAttrs (res."apiGroup" != null) { inherit (res) "apiGroup"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    };
  IngressSpecRuleHttpPathBackendServiceModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "name is the referenced service. The service must exist in\nthe same namespace as the Ingress object.";
        type = types.str;
      };
      "port" = mkOption {
        description = "port of the referenced service. A port name or port number\nis required for a IngressServiceBackend.";
        type = (types.nullOr IngressSpecRuleHttpPathBackendServicePortModule);
        default = null;
      };
    };
  };
  mkIngressSpecRuleHttpPathBackendService =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."port" != null) {
      "port" = mkIngressSpecRuleHttpPathBackendServicePort res."port";
    }
    // {
    };
  IngressSpecRuleHttpPathBackendServicePortModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "name is the name of the port on the Service.\nThis is a mutually exclusive setting with \"Number\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "number" = mkOption {
        description = "number is the numerical port number (e.g. 80) on the Service.\nThis is a mutually exclusive setting with \"Name\".";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkIngressSpecRuleHttpPathBackendServicePort =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."number" != null) { inherit (res) "number"; }
    // {
    };
  IngressSpecRuleHttpPathModule = types.submodule {
    options = {
      "backend" = mkOption {
        description = "backend defines the referenced service endpoint to which the traffic\nwill be forwarded to.";
        type = IngressSpecRuleHttpPathBackendModule;
      };
      "path" = mkOption {
        description = "path is matched against the path of an incoming request. Currently it can\ncontain characters disallowed from the conventional \"path\" part of a URL\nas defined by RFC 3986. Paths must begin with a '/' and must be present\nwhen using PathType with value \"Exact\" or \"Prefix\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "pathType" = mkOption {
        description = "pathType determines the interpretation of the path matching. PathType can\nbe one of the following values:\n* Exact: Matches the URL path exactly.\n* Prefix: Matches based on a URL path prefix split by '/'. Matching is\n  done on a path element by element basis. A path element refers is the\n  list of labels in the path split by the '/' separator. A request is a\n  match for path p if every p is an element-wise prefix of p of the\n  request path. Note that if the last element of the path is a substring\n  of the last element in request path, it is not a match (e.g. /foo/bar\n  matches /foo/bar/baz, but does not match /foo/barbaz).\n* ImplementationSpecific: Interpretation of the Path matching is up to\n  the IngressClass. Implementations can treat this as a separate PathType\n  or treat it identically to Prefix or Exact path types.\nImplementations are required to support all path types.";
        type = types.str;
      };
    };
  };
  mkIngressSpecRuleHttpPath =
    res:
    {
      "backend" = mkIngressSpecRuleHttpPathBackend res."backend";
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
      inherit (res) "pathType";
    };
  IngressSpecRuleModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "host is the fully qualified domain name of a network host, as defined by RFC 3986.\nNote the following deviations from the \"host\" part of the\nURI as defined in RFC 3986:\n1. IPs are not allowed. Currently an IngressRuleValue can only apply to\n   the IP in the Spec of the parent Ingress.\n2. The `:` delimiter is not respected because ports are not allowed.\n\t  Currently the port of an Ingress is implicitly :80 for http and\n\t  :443 for https.\nBoth these may change in the future.\nIncoming requests are matched against the host before the\nIngressRuleValue. If the host is unspecified, the Ingress routes all\ntraffic based on the specified IngressRuleValue.\n\nhost can be \"precise\" which is a domain name without the terminating dot of\na network host (e.g. \"foo.bar.com\") or \"wildcard\", which is a domain name\nprefixed with a single wildcard label (e.g. \"*.foo.com\").\nThe wildcard character '*' must appear by itself as the first DNS label and\nmatches only a single label. You cannot have a wildcard label by itself (e.g. Host == \"*\").\nRequests will be matched against the Host field in the following way:\n1. If host is precise, the request matches this rule if the http host header is equal to Host.\n2. If host is a wildcard, then the request matches this rule if the http host header\nis to equal to the suffix (removing the first label) of the wildcard rule.";
        type = (types.nullOr types.str);
        default = null;
      };
      "http" = mkOption {
        description = "HTTPIngressRuleValue is a list of http selectors pointing to backends.\nIn the example: http://<host>/<path>?<searchpart> -> backend where\nwhere parts of the url correspond to RFC 3986, this resource will be used\nto match against everything after the last '/' and before the first '?'\nor '#'.";
        type = (types.nullOr IngressSpecRuleHttpModule);
        default = null;
      };
    };
  };
  mkIngressSpecRule =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."http" != null) { "http" = mkIngressSpecRuleHttp res."http"; }
    // {
    };
  IngressSpecTlModule = types.submodule {
    options = {
      "hosts" = mkOption {
        description = "hosts is a list of hosts included in the TLS certificate. The values in\nthis list must match the name/s used in the tlsSecret. Defaults to the\nwildcard host setting for the loadbalancer controller fulfilling this\nIngress, if left unspecified.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "secretName" = mkOption {
        description = "secretName is the name of the secret used to terminate TLS traffic on\nport 443. Field is left optional to allow TLS routing based on SNI\nhostname alone. If the SNI host in a listener conflicts with the \"Host\"\nheader field used by an IngressRule, the SNI host is used for termination\nand value of the \"Host\" header is used for routing.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkIngressSpecTl =
    res:
    {
    }
    // optionalAttrs (res."hosts" != [ ]) { inherit (res) "hosts"; }
    // {
    }
    // optionalAttrs (res."secretName" != null) { inherit (res) "secretName"; }
    // {
    };
  JsonnetLibraryLabelSelectorMatchExpressionModule = types.submodule {
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
  mkJsonnetLibraryLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  JsonnetLibraryLabelSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf JsonnetLibraryLabelSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkJsonnetLibraryLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkJsonnetLibraryLabelSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  JsonnetModule = types.submodule {
    options = {
      "libraryLabelSelector" = mkOption {
        description = "A label selector is a label query over a set of resources. The result of matchLabels and\nmatchExpressions are ANDed. An empty label selector matches all objects. A null\nlabel selector matches no objects.";
        type = (types.nullOr JsonnetLibraryLabelSelectorModule);
        default = null;
      };
    };
  };
  mkJsonnet =
    res:
    {
    }
    // optionalAttrs (res."libraryLabelSelector" != null) {
      "libraryLabelSelector" = mkJsonnetLibraryLabelSelector res."libraryLabelSelector";
    }
    // {
    };
  PersistentVolumeClaimMetadataModule = types.submodule {
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
  mkPersistentVolumeClaimMetadata =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    };
  PersistentVolumeClaimModule = types.submodule {
    options = {
      "metadata" = mkOption {
        description = "ObjectMeta contains only a [subset of the fields included in k8s.io/apimachinery/pkg/apis/meta/v1.ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.27/#objectmeta-v1-meta).";
        type = (types.nullOr PersistentVolumeClaimMetadataModule);
        default = null;
      };
      "spec" = mkOption {
        type = (types.nullOr PersistentVolumeClaimSpecModule);
        default = null;
      };
    };
  };
  mkPersistentVolumeClaim =
    res:
    {
    }
    // optionalAttrs (res."metadata" != null) {
      "metadata" = mkPersistentVolumeClaimMetadata res."metadata";
    }
    // {
    }
    // optionalAttrs (res."spec" != null) { "spec" = mkPersistentVolumeClaimSpec res."spec"; }
    // {
    };
  PersistentVolumeClaimSpecDataSourceModule = types.submodule {
    options = {
      "apiGroup" = mkOption {
        description = "APIGroup is the group for the resource being referenced.\nIf APIGroup is not specified, the specified Kind must be in the core API group.\nFor any other third-party types, APIGroup is required.";
        type = (types.nullOr types.str);
        default = null;
      };
      "kind" = mkOption {
        description = "Kind is the type of resource being referenced";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name is the name of resource being referenced";
        type = types.str;
      };
    };
  };
  mkPersistentVolumeClaimSpecDataSource =
    res:
    {
    }
    // optionalAttrs (res."apiGroup" != null) { inherit (res) "apiGroup"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    };
  PersistentVolumeClaimSpecDataSourceRefModule = types.submodule {
    options = {
      "apiGroup" = mkOption {
        description = "APIGroup is the group for the resource being referenced.\nIf APIGroup is not specified, the specified Kind must be in the core API group.\nFor any other third-party types, APIGroup is required.";
        type = (types.nullOr types.str);
        default = null;
      };
      "kind" = mkOption {
        description = "Kind is the type of resource being referenced";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name is the name of resource being referenced";
        type = types.str;
      };
    };
  };
  mkPersistentVolumeClaimSpecDataSourceRef =
    res:
    {
    }
    // optionalAttrs (res."apiGroup" != null) { inherit (res) "apiGroup"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    };
  PersistentVolumeClaimSpecModule = types.submodule {
    options = {
      "accessModes" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "dataSource" = mkOption {
        description = "TypedLocalObjectReference contains enough information to let you locate the\ntyped referenced object inside the same namespace.";
        type = (types.nullOr PersistentVolumeClaimSpecDataSourceModule);
        default = null;
      };
      "dataSourceRef" = mkOption {
        description = "TypedLocalObjectReference contains enough information to let you locate the\ntyped referenced object inside the same namespace.";
        type = (types.nullOr PersistentVolumeClaimSpecDataSourceRefModule);
        default = null;
      };
      "resources" = mkOption {
        description = "ResourceRequirements describes the compute resource requirements.";
        type = (types.nullOr PersistentVolumeClaimSpecResourcesModule);
        default = null;
      };
      "selector" = mkOption {
        description = "A label selector is a label query over a set of resources. The result of matchLabels and\nmatchExpressions are ANDed. An empty label selector matches all objects. A null\nlabel selector matches no objects.";
        type = (types.nullOr PersistentVolumeClaimSpecSelectorModule);
        default = null;
      };
      "storageClassName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeMode" = mkOption {
        description = "PersistentVolumeMode describes how a volume is intended to be consumed, either Block or Filesystem.";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeName" = mkOption {
        description = "VolumeName is the binding reference to the PersistentVolume backing this claim.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkPersistentVolumeClaimSpec =
    res:
    {
    }
    // optionalAttrs (res."accessModes" != [ ]) { inherit (res) "accessModes"; }
    // {
    }
    // optionalAttrs (res."dataSource" != null) {
      "dataSource" = mkPersistentVolumeClaimSpecDataSource res."dataSource";
    }
    // {
    }
    // optionalAttrs (res."dataSourceRef" != null) {
      "dataSourceRef" = mkPersistentVolumeClaimSpecDataSourceRef res."dataSourceRef";
    }
    // {
    }
    // optionalAttrs (res."resources" != null) {
      "resources" = mkPersistentVolumeClaimSpecResources res."resources";
    }
    // {
    }
    // optionalAttrs (res."selector" != null) {
      "selector" = mkPersistentVolumeClaimSpecSelector res."selector";
    }
    // {
    }
    // optionalAttrs (res."storageClassName" != null) { inherit (res) "storageClassName"; }
    // {
    }
    // optionalAttrs (res."volumeMode" != null) { inherit (res) "volumeMode"; }
    // {
    }
    // optionalAttrs (res."volumeName" != null) { inherit (res) "volumeName"; }
    // {
    };
  PersistentVolumeClaimSpecResourcesClaimModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name must match the name of one entry in pod.spec.resourceClaims of\nthe Pod where this field is used. It makes that resource available\ninside a container.";
        type = types.str;
      };
      "request" = mkOption {
        description = "Request is the name chosen for a request in the referenced claim.\nIf empty, everything from the claim is made available, otherwise\nonly the result of this request.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkPersistentVolumeClaimSpecResourcesClaim =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."request" != null) { inherit (res) "request"; }
    // {
    };
  PersistentVolumeClaimSpecResourcesModule = types.submodule {
    options = {
      "claims" = mkOption {
        description = "Claims lists the names of resources, defined in spec.resourceClaims,\nthat are used by this container.\n\nThis is an alpha field and requires enabling the\nDynamicResourceAllocation feature gate.\n\nThis field is immutable. It can only be set for containers.";
        type = (types.listOf PersistentVolumeClaimSpecResourcesClaimModule);
        default = [ ];
      };
      "limits" = mkOption {
        description = "Limits describes the maximum amount of compute resources allowed.\nMore info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "requests" = mkOption {
        description = "Requests describes the minimum amount of compute resources required.\nIf Requests is omitted for a container, it defaults to Limits if that is explicitly specified,\notherwise to an implementation-defined value. Requests cannot exceed Limits.\nMore info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.attrsOf types.anything);
        default = { };
      };
    };
  };
  mkPersistentVolumeClaimSpecResources =
    res:
    {
    }
    // optionalAttrs (res."claims" != [ ]) {
      "claims" = map mkPersistentVolumeClaimSpecResourcesClaim res."claims";
    }
    // {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  PersistentVolumeClaimSpecSelectorMatchExpressionModule = types.submodule {
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
  mkPersistentVolumeClaimSpecSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  PersistentVolumeClaimSpecSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf PersistentVolumeClaimSpecSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkPersistentVolumeClaimSpecSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkPersistentVolumeClaimSpecSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  PreferencesModule = types.submodule {
    options = {
      "homeDashboardUid" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkPreferences =
    res:
    {
    }
    // optionalAttrs (res."homeDashboardUid" != null) { inherit (res) "homeDashboardUid"; }
    // {
    };
  RouteMetadataModule = types.submodule {
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
  mkRouteMetadata =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    };
  RouteModule = types.submodule {
    options = {
      "metadata" = mkOption {
        description = "ObjectMeta contains only a [subset of the fields included in k8s.io/apimachinery/pkg/apis/meta/v1.ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.27/#objectmeta-v1-meta).";
        type = (types.nullOr RouteMetadataModule);
        default = null;
      };
      "spec" = mkOption {
        type = (types.nullOr RouteSpecModule);
        default = null;
      };
    };
  };
  mkRoute =
    res:
    {
    }
    // optionalAttrs (res."metadata" != null) { "metadata" = mkRouteMetadata res."metadata"; }
    // {
    }
    // optionalAttrs (res."spec" != null) { "spec" = mkRouteSpec res."spec"; }
    // {
    };
  RouteSpecAlternateBackendModule = types.submodule {
    options = {
      "kind" = mkOption {
        description = "The kind of target that the route is referring to. Currently, only 'Service' is allowed";
        type = (
          types.enum [
            "Service"
            ""
          ]
        );
      };
      "name" = mkOption {
        description = "name of the service/target that is being referred to. e.g. name of the service";
        type = types.str;
      };
      "weight" = mkOption {
        description = "weight as an integer between 0 and 256, default 100, that specifies the target's relative weight\nagainst other target reference objects. 0 suppresses requests to this backend.";
        type = (types.nullOr types.int);
        default = 100;
      };
    };
  };
  mkRouteSpecAlternateBackend =
    res:
    {
      inherit (res) "kind";
      inherit (res) "name";
    }
    // optionalAttrs (res."weight" != null) { inherit (res) "weight"; }
    // {
    };
  RouteSpecModule = types.submodule {
    options = {
      "alternateBackends" = mkOption {
        type = (types.listOf RouteSpecAlternateBackendModule);
        default = [ ];
      };
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "path" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "RoutePort defines a port mapping from a router to an endpoint in the service endpoints.";
        type = (types.nullOr RouteSpecPortModule);
        default = null;
      };
      "subdomain" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "tls" = mkOption {
        description = "TLSConfig defines config used to secure a route and provide termination";
        type = (types.nullOr RouteSpecTlsModule);
        default = null;
      };
      "to" = mkOption {
        description = "RouteTargetReference specifies the target that resolve into endpoints. Only the 'Service'\nkind is allowed. Use 'weight' field to emphasize one over others.";
        type = (types.nullOr RouteSpecToModule);
        default = null;
      };
      "wildcardPolicy" = mkOption {
        description = "WildcardPolicyType indicates the type of wildcard support needed by routes.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkRouteSpec =
    res:
    {
    }
    // optionalAttrs (res."alternateBackends" != [ ]) {
      "alternateBackends" = map mkRouteSpecAlternateBackend res."alternateBackends";
    }
    // {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs (res."port" != null) { "port" = mkRouteSpecPort res."port"; }
    // {
    }
    // optionalAttrs (res."subdomain" != null) { inherit (res) "subdomain"; }
    // {
    }
    // optionalAttrs (res."tls" != null) { "tls" = mkRouteSpecTls res."tls"; }
    // {
    }
    // optionalAttrs (res."to" != null) { "to" = mkRouteSpecTo res."to"; }
    // {
    }
    // optionalAttrs (res."wildcardPolicy" != null) { inherit (res) "wildcardPolicy"; }
    // {
    };
  RouteSpecPortModule = types.submodule {
    options = {
      "targetPort" = mkOption {
        description = "The target port on pods selected by the service this route points to.\nIf this is a string, it will be looked up as a named port in the target\nendpoints port list. Required";
        type = types.anything;
      };
    };
  };
  mkRouteSpecPort = res: {
    inherit (res) "targetPort";
  };
  RouteSpecTlsExternalCertificateModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "name of the referent.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkRouteSpecTlsExternalCertificate =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  RouteSpecTlsModule = types.submodule {
    options = {
      "caCertificate" = mkOption {
        description = "caCertificate provides the cert authority certificate contents";
        type = (types.nullOr types.str);
        default = null;
      };
      "certificate" = mkOption {
        description = "certificate provides certificate contents. This should be a single serving certificate, not a certificate\nchain. Do not include a CA certificate.";
        type = (types.nullOr types.str);
        default = null;
      };
      "destinationCACertificate" = mkOption {
        description = "destinationCACertificate provides the contents of the ca certificate of the final destination.  When using reencrypt\ntermination this file should be provided in order to have routers use it for health checks on the secure connection.\nIf this field is not specified, the router may provide its own destination CA and perform hostname validation using\nthe short service name (service.namespace.svc), which allows infrastructure generated certificates to automatically\nverify.";
        type = (types.nullOr types.str);
        default = null;
      };
      "externalCertificate" = mkOption {
        description = "externalCertificate provides certificate contents as a secret reference.\nThis should be a single serving certificate, not a certificate\nchain. Do not include a CA certificate. The secret referenced should\nbe present in the same namespace as that of the Route.\nForbidden when `certificate` is set.\nThe router service account needs to be granted with read-only access to this secret,\nplease refer to openshift docs for additional details.";
        type = (types.nullOr RouteSpecTlsExternalCertificateModule);
        default = null;
      };
      "insecureEdgeTerminationPolicy" = mkOption {
        description = "insecureEdgeTerminationPolicy indicates the desired behavior for insecure connections to a route. While\neach router may make its own decisions on which ports to expose, this is normally port 80.\n\nIf a route does not specify insecureEdgeTerminationPolicy, then the default behavior is \"None\".\n\n* Allow - traffic is sent to the server on the insecure port (edge/reencrypt terminations only).\n\n* None - no traffic is allowed on the insecure port (default).\n\n* Redirect - clients are redirected to the secure port.";
        type = (
          types.nullOr (
            types.enum [
              "Allow"
              "None"
              "Redirect"
              ""
            ]
          )
        );
        default = null;
      };
      "key" = mkOption {
        description = "key provides key file contents";
        type = (types.nullOr types.str);
        default = null;
      };
      "termination" = mkOption {
        description = "termination indicates termination type.\n\n* edge - TLS termination is done by the router and http is used to communicate with the backend (default)\n* passthrough - Traffic is sent straight to the destination without the router providing TLS termination\n* reencrypt - TLS termination is done by the router and https is used to communicate with the backend\n\nNote: passthrough termination is incompatible with httpHeader actions";
        type = (
          types.enum [
            "edge"
            "reencrypt"
            "passthrough"
          ]
        );
      };
    };
  };
  mkRouteSpecTls =
    res:
    {
    }
    // optionalAttrs (res."caCertificate" != null) { inherit (res) "caCertificate"; }
    // {
    }
    // optionalAttrs (res."certificate" != null) { inherit (res) "certificate"; }
    // {
    }
    // optionalAttrs (res."destinationCACertificate" != null) {
      inherit (res) "destinationCACertificate";
    }
    // {
    }
    // optionalAttrs (res."externalCertificate" != null) {
      "externalCertificate" = mkRouteSpecTlsExternalCertificate res."externalCertificate";
    }
    // {
    }
    // optionalAttrs (res."insecureEdgeTerminationPolicy" != null) {
      inherit (res) "insecureEdgeTerminationPolicy";
    }
    // {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "termination";
    };
  RouteSpecToModule = types.submodule {
    options = {
      "kind" = mkOption {
        description = "The kind of target that the route is referring to. Currently, only 'Service' is allowed";
        type = (
          types.enum [
            "Service"
            ""
          ]
        );
      };
      "name" = mkOption {
        description = "name of the service/target that is being referred to. e.g. name of the service";
        type = types.str;
      };
      "weight" = mkOption {
        description = "weight as an integer between 0 and 256, default 100, that specifies the target's relative weight\nagainst other target reference objects. 0 suppresses requests to this backend.";
        type = (types.nullOr types.int);
        default = 100;
      };
    };
  };
  mkRouteSpecTo =
    res:
    {
      inherit (res) "kind";
      inherit (res) "name";
    }
    // optionalAttrs (res."weight" != null) { inherit (res) "weight"; }
    // {
    };
  ServiceAccountImagePullSecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkServiceAccountImagePullSecret =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ServiceAccountMetadataModule = types.submodule {
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
  mkServiceAccountMetadata =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    };
  ServiceAccountModule = types.submodule {
    options = {
      "automountServiceAccountToken" = mkOption {
        type = types.bool;
        default = false;
      };
      "imagePullSecrets" = mkOption {
        type = (types.listOf ServiceAccountImagePullSecretModule);
        default = [ ];
      };
      "metadata" = mkOption {
        description = "ObjectMeta contains only a [subset of the fields included in k8s.io/apimachinery/pkg/apis/meta/v1.ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.27/#objectmeta-v1-meta).";
        type = (types.nullOr ServiceAccountMetadataModule);
        default = null;
      };
      "secrets" = mkOption {
        type = (types.listOf ServiceAccountSecretModule);
        default = [ ];
      };
    };
  };
  mkServiceAccount =
    res:
    {
    }
    // optionalAttrs res."automountServiceAccountToken" {
      inherit (res) "automountServiceAccountToken";
    }
    // {
    }
    // optionalAttrs (res."imagePullSecrets" != [ ]) {
      "imagePullSecrets" = map mkServiceAccountImagePullSecret res."imagePullSecrets";
    }
    // {
    }
    // optionalAttrs (res."metadata" != null) { "metadata" = mkServiceAccountMetadata res."metadata"; }
    // {
    }
    // optionalAttrs (res."secrets" != [ ]) { "secrets" = map mkServiceAccountSecret res."secrets"; }
    // {
    };
  ServiceAccountSecretModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        description = "API version of the referent.";
        type = (types.nullOr types.str);
        default = null;
      };
      "fieldPath" = mkOption {
        description = "If referring to a piece of an object instead of an entire object, this string\nshould contain a valid JSON/Go field access statement, such as desiredState.manifest.containers[2].\nFor example, if the object reference is to a container within a pod, this would take on a value like:\n\"spec.containers{name}\" (where \"name\" refers to the name of the container that triggered\nthe event) or if no container name is specified \"spec.containers[2]\" (container with\nindex 2 in this pod). This syntax is chosen only to have some well-defined way of\nreferencing a part of an object.";
        type = (types.nullOr types.str);
        default = null;
      };
      "kind" = mkOption {
        description = "Kind of the referent.\nMore info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the referent.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = null;
      };
      "namespace" = mkOption {
        description = "Namespace of the referent.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/";
        type = (types.nullOr types.str);
        default = null;
      };
      "resourceVersion" = mkOption {
        description = "Specific resourceVersion to which this reference is made, if any.\nMore info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#concurrency-control-and-consistency";
        type = (types.nullOr types.str);
        default = null;
      };
      "uid" = mkOption {
        description = "UID of the referent.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkServiceAccountSecret =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
    }
    // optionalAttrs (res."fieldPath" != null) { inherit (res) "fieldPath"; }
    // {
    }
    // optionalAttrs (res."kind" != null) { inherit (res) "kind"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    }
    // optionalAttrs (res."resourceVersion" != null) { inherit (res) "resourceVersion"; }
    // {
    }
    // optionalAttrs (res."uid" != null) { inherit (res) "uid"; }
    // {
    };
  ServiceMetadataModule = types.submodule {
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
  mkServiceMetadata =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    };
  ServiceModule = types.submodule {
    options = {
      "metadata" = mkOption {
        description = "ObjectMeta contains only a [subset of the fields included in k8s.io/apimachinery/pkg/apis/meta/v1.ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.27/#objectmeta-v1-meta).";
        type = (types.nullOr ServiceMetadataModule);
        default = null;
      };
      "spec" = mkOption {
        description = "ServiceSpec describes the attributes that a user creates on a service.";
        type = (types.nullOr ServiceSpecModule);
        default = null;
      };
    };
  };
  mkService =
    res:
    {
    }
    // optionalAttrs (res."metadata" != null) { "metadata" = mkServiceMetadata res."metadata"; }
    // {
    }
    // optionalAttrs (res."spec" != null) { "spec" = mkServiceSpec res."spec"; }
    // {
    };
  ServiceSpecModule = types.submodule {
    options = {
      "allocateLoadBalancerNodePorts" = mkOption {
        description = "allocateLoadBalancerNodePorts defines if NodePorts will be automatically\nallocated for services with type LoadBalancer.  Default is \"true\". It\nmay be set to \"false\" if the cluster load-balancer does not rely on\nNodePorts.  If the caller requests specific NodePorts (by specifying a\nvalue), those requests will be respected, regardless of this field.\nThis field may only be set for services with type LoadBalancer and will\nbe cleared if the type is changed to any other type.";
        type = types.bool;
        default = false;
      };
      "clusterIP" = mkOption {
        description = "clusterIP is the IP address of the service and is usually assigned\nrandomly. If an address is specified manually, is in-range (as per\nsystem configuration), and is not in use, it will be allocated to the\nservice; otherwise creation of the service will fail. This field may not\nbe changed through updates unless the type field is also being changed\nto ExternalName (which requires this field to be blank) or the type\nfield is being changed from ExternalName (in which case this field may\noptionally be specified, as describe above).  Valid values are \"None\",\nempty string (\"\"), or a valid IP address. Setting this to \"None\" makes a\n\"headless service\" (no virtual IP), which is useful when direct endpoint\nconnections are preferred and proxying is not required.  Only applies to\ntypes ClusterIP, NodePort, and LoadBalancer. If this field is specified\nwhen creating a Service of type ExternalName, creation will fail. This\nfield will be wiped when updating a Service to type ExternalName.\nMore info: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies";
        type = (types.nullOr types.str);
        default = null;
      };
      "clusterIPs" = mkOption {
        description = "ClusterIPs is a list of IP addresses assigned to this service, and are\nusually assigned randomly.  If an address is specified manually, is\nin-range (as per system configuration), and is not in use, it will be\nallocated to the service; otherwise creation of the service will fail.\nThis field may not be changed through updates unless the type field is\nalso being changed to ExternalName (which requires this field to be\nempty) or the type field is being changed from ExternalName (in which\ncase this field may optionally be specified, as describe above).  Valid\nvalues are \"None\", empty string (\"\"), or a valid IP address.  Setting\nthis to \"None\" makes a \"headless service\" (no virtual IP), which is\nuseful when direct endpoint connections are preferred and proxying is\nnot required.  Only applies to types ClusterIP, NodePort, and\nLoadBalancer. If this field is specified when creating a Service of type\nExternalName, creation will fail. This field will be wiped when updating\na Service to type ExternalName.  If this field is not specified, it will\nbe initialized from the clusterIP field.  If this field is specified,\nclients must ensure that clusterIPs[0] and clusterIP have the same\nvalue.\n\nThis field may hold a maximum of two entries (dual-stack IPs, in either order).\nThese IPs must correspond to the values of the ipFamilies field. Both\nclusterIPs and ipFamilies are governed by the ipFamilyPolicy field.\nMore info: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies";
        type = (types.listOf types.str);
        default = [ ];
      };
      "externalIPs" = mkOption {
        description = "externalIPs is a list of IP addresses for which nodes in the cluster\nwill also accept traffic for this service.  These IPs are not managed by\nKubernetes.  The user is responsible for ensuring that traffic arrives\nat a node with this IP.  A common example is external load-balancers\nthat are not part of the Kubernetes system.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "externalName" = mkOption {
        description = "externalName is the external reference that discovery mechanisms will\nreturn as an alias for this service (e.g. a DNS CNAME record). No\nproxying will be involved.  Must be a lowercase RFC-1123 hostname\n(https://tools.ietf.org/html/rfc1123) and requires `type` to be \"ExternalName\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "externalTrafficPolicy" = mkOption {
        description = "externalTrafficPolicy describes how nodes distribute service traffic they\nreceive on one of the Service's \"externally-facing\" addresses (NodePorts,\nExternalIPs, and LoadBalancer IPs). If set to \"Local\", the proxy will configure\nthe service in a way that assumes that external load balancers will take care\nof balancing the service traffic between nodes, and so each node will deliver\ntraffic only to the node-local endpoints of the service, without masquerading\nthe client source IP. (Traffic mistakenly sent to a node with no endpoints will\nbe dropped.) The default value, \"Cluster\", uses the standard behavior of\nrouting to all endpoints evenly (possibly modified by topology and other\nfeatures). Note that traffic sent to an External IP or LoadBalancer IP from\nwithin the cluster will always get \"Cluster\" semantics, but clients sending to\na NodePort from within the cluster may need to take traffic policy into account\nwhen picking a node.";
        type = (types.nullOr types.str);
        default = null;
      };
      "healthCheckNodePort" = mkOption {
        description = "healthCheckNodePort specifies the healthcheck nodePort for the service.\nThis only applies when type is set to LoadBalancer and\nexternalTrafficPolicy is set to Local. If a value is specified, is\nin-range, and is not in use, it will be used.  If not specified, a value\nwill be automatically allocated.  External systems (e.g. load-balancers)\ncan use this port to determine if a given node holds endpoints for this\nservice or not.  If this field is specified when creating a Service\nwhich does not need it, creation will fail. This field will be wiped\nwhen updating a Service to no longer need it (e.g. changing type).\nThis field cannot be updated once set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "internalTrafficPolicy" = mkOption {
        description = "InternalTrafficPolicy describes how nodes distribute service traffic they\nreceive on the ClusterIP. If set to \"Local\", the proxy will assume that pods\nonly want to talk to endpoints of the service on the same node as the pod,\ndropping the traffic if there are no local endpoints. The default value,\n\"Cluster\", uses the standard behavior of routing to all endpoints evenly\n(possibly modified by topology and other features).";
        type = (types.nullOr types.str);
        default = null;
      };
      "ipFamilies" = mkOption {
        description = "IPFamilies is a list of IP families (e.g. IPv4, IPv6) assigned to this\nservice. This field is usually assigned automatically based on cluster\nconfiguration and the ipFamilyPolicy field. If this field is specified\nmanually, the requested family is available in the cluster,\nand ipFamilyPolicy allows it, it will be used; otherwise creation of\nthe service will fail. This field is conditionally mutable: it allows\nfor adding or removing a secondary IP family, but it does not allow\nchanging the primary IP family of the Service. Valid values are \"IPv4\"\nand \"IPv6\".  This field only applies to Services of types ClusterIP,\nNodePort, and LoadBalancer, and does apply to \"headless\" services.\nThis field will be wiped when updating a Service to type ExternalName.\n\nThis field may hold a maximum of two entries (dual-stack families, in\neither order).  These families must correspond to the values of the\nclusterIPs field, if specified. Both clusterIPs and ipFamilies are\ngoverned by the ipFamilyPolicy field.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "ipFamilyPolicy" = mkOption {
        description = "IPFamilyPolicy represents the dual-stack-ness requested or required by\nthis Service. If there is no value provided, then this field will be set\nto SingleStack. Services can be \"SingleStack\" (a single IP family),\n\"PreferDualStack\" (two IP families on dual-stack configured clusters or\na single IP family on single-stack clusters), or \"RequireDualStack\"\n(two IP families on dual-stack configured clusters, otherwise fail). The\nipFamilies and clusterIPs fields depend on the value of this field. This\nfield will be wiped when updating a service to type ExternalName.";
        type = (types.nullOr types.str);
        default = null;
      };
      "loadBalancerClass" = mkOption {
        description = "loadBalancerClass is the class of the load balancer implementation this Service belongs to.\nIf specified, the value of this field must be a label-style identifier, with an optional prefix,\ne.g. \"internal-vip\" or \"example.com/internal-vip\". Unprefixed names are reserved for end-users.\nThis field can only be set when the Service type is 'LoadBalancer'. If not set, the default load\nbalancer implementation is used, today this is typically done through the cloud provider integration,\nbut should apply for any default implementation. If set, it is assumed that a load balancer\nimplementation is watching for Services with a matching class. Any default load balancer\nimplementation (e.g. cloud providers) should ignore Services that set this field.\nThis field can only be set when creating or updating a Service to type 'LoadBalancer'.\nOnce set, it can not be changed. This field will be wiped when a service is updated to a non 'LoadBalancer' type.";
        type = (types.nullOr types.str);
        default = null;
      };
      "loadBalancerIP" = mkOption {
        description = "Only applies to Service Type: LoadBalancer.\nThis feature depends on whether the underlying cloud-provider supports specifying\nthe loadBalancerIP when a load balancer is created.\nThis field will be ignored if the cloud-provider does not support the feature.\nDeprecated: This field was under-specified and its meaning varies across implementations.\nUsing it is non-portable and it may not support dual-stack.\nUsers are encouraged to use implementation-specific annotations when available.";
        type = (types.nullOr types.str);
        default = null;
      };
      "loadBalancerSourceRanges" = mkOption {
        description = "If specified and supported by the platform, this will restrict traffic through the cloud-provider\nload-balancer will be restricted to the specified client IPs. This field will be ignored if the\ncloud-provider does not support the feature.\"\nMore info: https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/";
        type = (types.listOf types.str);
        default = [ ];
      };
      "ports" = mkOption {
        description = "The list of ports that are exposed by this service.\nMore info: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies";
        type = (types.listOf ServiceSpecPortModule);
        default = [ ];
      };
      "publishNotReadyAddresses" = mkOption {
        description = "publishNotReadyAddresses indicates that any agent which deals with endpoints for this\nService should disregard any indications of ready/not-ready.\nThe primary use case for setting this field is for a StatefulSet's Headless Service to\npropagate SRV DNS records for its Pods for the purpose of peer discovery.\nThe Kubernetes controllers that generate Endpoints and EndpointSlice resources for\nServices interpret this to mean that all endpoints are considered \"ready\" even if the\nPods themselves are not. Agents which consume only Kubernetes generated endpoints\nthrough the Endpoints or EndpointSlice resources can safely assume this behavior.";
        type = types.bool;
        default = false;
      };
      "selector" = mkOption {
        description = "Route service traffic to pods with label keys and values matching this\nselector. If empty or not present, the service is assumed to have an\nexternal process managing its endpoints, which Kubernetes will not\nmodify. Only applies to types ClusterIP, NodePort, and LoadBalancer.\nIgnored if type is ExternalName.\nMore info: https://kubernetes.io/docs/concepts/services-networking/service/";
        type = (types.attrsOf types.str);
        default = { };
      };
      "sessionAffinity" = mkOption {
        description = "Supports \"ClientIP\" and \"None\". Used to maintain session affinity.\nEnable client IP based session affinity.\nMust be ClientIP or None.\nDefaults to None.\nMore info: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies";
        type = (types.nullOr types.str);
        default = null;
      };
      "sessionAffinityConfig" = mkOption {
        description = "sessionAffinityConfig contains the configurations of session affinity.";
        type = (types.nullOr ServiceSpecSessionAffinityConfigModule);
        default = null;
      };
      "trafficDistribution" = mkOption {
        description = "TrafficDistribution offers a way to express preferences for how traffic\nis distributed to Service endpoints. Implementations can use this field\nas a hint, but are not required to guarantee strict adherence. If the\nfield is not set, the implementation will apply its default routing\nstrategy. If set to \"PreferClose\", implementations should prioritize\nendpoints that are in the same zone.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "type determines how the Service is exposed. Defaults to ClusterIP. Valid\noptions are ExternalName, ClusterIP, NodePort, and LoadBalancer.\n\"ClusterIP\" allocates a cluster-internal IP address for load-balancing\nto endpoints. Endpoints are determined by the selector or if that is not\nspecified, by manual construction of an Endpoints object or\nEndpointSlice objects. If clusterIP is \"None\", no virtual IP is\nallocated and the endpoints are published as a set of endpoints rather\nthan a virtual IP.\n\"NodePort\" builds on ClusterIP and allocates a port on every node which\nroutes to the same endpoints as the clusterIP.\n\"LoadBalancer\" builds on NodePort and creates an external load-balancer\n(if supported in the current cloud) which routes to the same endpoints\nas the clusterIP.\n\"ExternalName\" aliases this service to the specified externalName.\nSeveral other fields do not apply to ExternalName services.\nMore info: https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkServiceSpec =
    res:
    {
    }
    // optionalAttrs res."allocateLoadBalancerNodePorts" {
      inherit (res) "allocateLoadBalancerNodePorts";
    }
    // {
    }
    // optionalAttrs (res."clusterIP" != null) { inherit (res) "clusterIP"; }
    // {
    }
    // optionalAttrs (res."clusterIPs" != [ ]) { inherit (res) "clusterIPs"; }
    // {
    }
    // optionalAttrs (res."externalIPs" != [ ]) { inherit (res) "externalIPs"; }
    // {
    }
    // optionalAttrs (res."externalName" != null) { inherit (res) "externalName"; }
    // {
    }
    // optionalAttrs (res."externalTrafficPolicy" != null) { inherit (res) "externalTrafficPolicy"; }
    // {
    }
    // optionalAttrs (res."healthCheckNodePort" != null) { inherit (res) "healthCheckNodePort"; }
    // {
    }
    // optionalAttrs (res."internalTrafficPolicy" != null) { inherit (res) "internalTrafficPolicy"; }
    // {
    }
    // optionalAttrs (res."ipFamilies" != [ ]) { inherit (res) "ipFamilies"; }
    // {
    }
    // optionalAttrs (res."ipFamilyPolicy" != null) { inherit (res) "ipFamilyPolicy"; }
    // {
    }
    // optionalAttrs (res."loadBalancerClass" != null) { inherit (res) "loadBalancerClass"; }
    // {
    }
    // optionalAttrs (res."loadBalancerIP" != null) { inherit (res) "loadBalancerIP"; }
    // {
    }
    // optionalAttrs (res."loadBalancerSourceRanges" != [ ]) {
      inherit (res) "loadBalancerSourceRanges";
    }
    // {
    }
    // optionalAttrs (res."ports" != [ ]) { "ports" = map mkServiceSpecPort res."ports"; }
    // {
    }
    // optionalAttrs res."publishNotReadyAddresses" { inherit (res) "publishNotReadyAddresses"; }
    // {
    }
    // optionalAttrs (res."selector" != { }) { inherit (res) "selector"; }
    // {
    }
    // optionalAttrs (res."sessionAffinity" != null) { inherit (res) "sessionAffinity"; }
    // {
    }
    // optionalAttrs (res."sessionAffinityConfig" != null) {
      "sessionAffinityConfig" = mkServiceSpecSessionAffinityConfig res."sessionAffinityConfig";
    }
    // {
    }
    // optionalAttrs (res."trafficDistribution" != null) { inherit (res) "trafficDistribution"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ServiceSpecPortModule = types.submodule {
    options = {
      "appProtocol" = mkOption {
        description = "The application protocol for this port.\nThis is used as a hint for implementations to offer richer behavior for protocols that they understand.\nThis field follows standard Kubernetes label syntax.\nValid values are either:\n\n* Un-prefixed protocol names - reserved for IANA standard service names (as per\nRFC-6335 and https://www.iana.org/assignments/service-names).\n\n* Kubernetes-defined prefixed names:\n  * 'kubernetes.io/h2c' - HTTP/2 prior knowledge over cleartext as described in https://www.rfc-editor.org/rfc/rfc9113.html#name-starting-http-2-with-prior-\n  * 'kubernetes.io/ws'  - WebSocket over cleartext as described in https://www.rfc-editor.org/rfc/rfc6455\n  * 'kubernetes.io/wss' - WebSocket over TLS as described in https://www.rfc-editor.org/rfc/rfc6455\n\n* Other protocols should use implementation-defined prefixed names such as\nmycompany.com/my-custom-protocol.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "The name of this port within the service. This must be a DNS_LABEL.\nAll ports within a ServiceSpec must have unique names. When considering\nthe endpoints for a Service, this must match the 'name' field in the\nEndpointPort.\nOptional if only one ServicePort is defined on this service.";
        type = (types.nullOr types.str);
        default = null;
      };
      "nodePort" = mkOption {
        description = "The port on each node on which this service is exposed when type is\nNodePort or LoadBalancer.  Usually assigned by the system. If a value is\nspecified, in-range, and not in use it will be used, otherwise the\noperation will fail.  If not specified, a port will be allocated if this\nService requires one.  If this field is specified when creating a\nService which does not need it, creation will fail. This field will be\nwiped when updating a Service to no longer need it (e.g. changing type\nfrom NodePort to ClusterIP).\nMore info: https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport";
        type = (types.nullOr types.int);
        default = null;
      };
      "port" = mkOption {
        description = "The port that will be exposed by this service.";
        type = types.int;
      };
      "protocol" = mkOption {
        description = "The IP protocol for this port. Supports \"TCP\", \"UDP\", and \"SCTP\".\nDefault is TCP.";
        type = (types.nullOr types.str);
        default = "TCP";
      };
      "targetPort" = mkOption {
        description = "Number or name of the port to access on the pods targeted by the service.\nNumber must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.\nIf this is a string, it will be looked up as a named port in the\ntarget Pod's container ports. If this is not specified, the value\nof the 'port' field is used (an identity map).\nThis field is ignored for services with clusterIP=None, and should be\nomitted or set equal to the 'port' field.\nMore info: https://kubernetes.io/docs/concepts/services-networking/service/#defining-a-service";
        type = types.anything;
        default = { };
      };
    };
  };
  mkServiceSpecPort =
    res:
    {
    }
    // optionalAttrs (res."appProtocol" != null) { inherit (res) "appProtocol"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."nodePort" != null) { inherit (res) "nodePort"; }
    // {
      inherit (res) "port";
    }
    // optionalAttrs (res."protocol" != null) { inherit (res) "protocol"; }
    // {
    }
    // optionalAttrs (res."targetPort" != null) { inherit (res) "targetPort"; }
    // {
    };
  ServiceSpecSessionAffinityConfigClientIPModule = types.submodule {
    options = {
      "timeoutSeconds" = mkOption {
        description = "timeoutSeconds specifies the seconds of ClientIP type session sticky time.\nThe value must be >0 && <=86400(for 1 day) if ServiceAffinity == \"ClientIP\".\nDefault value is 10800(for 3 hours).";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkServiceSpecSessionAffinityConfigClientIP =
    res:
    {
    }
    // optionalAttrs (res."timeoutSeconds" != null) { inherit (res) "timeoutSeconds"; }
    // {
    };
  ServiceSpecSessionAffinityConfigModule = types.submodule {
    options = {
      "clientIP" = mkOption {
        description = "clientIP contains the configurations of Client IP based session affinity.";
        type = (types.nullOr ServiceSpecSessionAffinityConfigClientIPModule);
        default = null;
      };
    };
  };
  mkServiceSpecSessionAffinityConfig =
    res:
    {
    }
    // optionalAttrs (res."clientIP" != null) {
      "clientIP" = mkServiceSpecSessionAffinityConfigClientIP res."clientIP";
    }
    // {
    };
  GrafanasModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this Grafana resource.";
        };
        "client" = mkOption {
          description = "Client defines how the grafana-operator talks to the grafana instance.";
          type = (types.nullOr ClientModule);
          default = null;
        };
        "config" = mkOption {
          description = "Config defines how your grafana ini file should looks like.";
          type = (types.attrsOf (types.attrsOf types.str));
          default = { };
        };
        "deployment" = mkOption {
          description = "Deployment sets how the deployment object should look like with your grafana instance, contains a number of defaults.";
          type = (types.nullOr DeploymentModule);
          default = null;
        };
        "disableDefaultAdminSecret" = mkOption {
          description = "DisableDefaultAdminSecret prevents operator from creating default admin-credentials secret";
          type = types.bool;
          default = false;
        };
        "disableDefaultSecurityContext" = mkOption {
          description = "DisableDefaultSecurityContext prevents the operator from populating securityContext on deployments";
          type = (
            types.nullOr (
              types.enum [
                "Pod"
                "Container"
                "All"
              ]
            )
          );
          default = null;
        };
        "external" = mkOption {
          description = "External enables you to configure external grafana instances that is not managed by the operator.";
          type = (types.nullOr ExternalModule);
          default = null;
        };
        "ingress" = mkOption {
          description = "Ingress sets how the ingress object should look like with your grafana instance.";
          type = (types.nullOr IngressModule);
          default = null;
        };
        "jsonnet" = mkOption {
          type = (types.nullOr JsonnetModule);
          default = null;
        };
        "persistentVolumeClaim" = mkOption {
          description = "PersistentVolumeClaim creates a PVC if you need to attach one to your grafana instance.";
          type = (types.nullOr PersistentVolumeClaimModule);
          default = null;
        };
        "preferences" = mkOption {
          description = "Preferences holds the Grafana Preferences settings";
          type = (types.nullOr PreferencesModule);
          default = null;
        };
        "route" = mkOption {
          description = "Route sets how the ingress object should look like with your grafana instance, this only works in Openshift.";
          type = (types.nullOr RouteModule);
          default = null;
        };
        "service" = mkOption {
          description = "Service sets how the service object should look like with your grafana instance, contains a number of defaults.";
          type = (types.nullOr ServiceModule);
          default = null;
        };
        "serviceAccount" = mkOption {
          description = "ServiceAccount sets how the ServiceAccount object should look like with your grafana instance, contains a number of defaults.";
          type = (types.nullOr ServiceAccountModule);
          default = null;
        };
        "suspend" = mkOption {
          description = "Suspend pauses reconciliation of owned resources like deployments, Services, Etc. upon changes";
          type = types.bool;
          default = false;
        };
        "version" = mkOption {
          description = "Version specifies the version of Grafana to use for this deployment. It follows the same format as the docker.io/grafana/grafana tags";
          type = (types.nullOr types.str);
          default = null;
        };
      };
    }
  );
  mkGrafana = name: res: {
    apiVersion = "grafana.integreatly.org/v1beta1";
    kind = "Grafana";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."client" != null) { "client" = mkClient res."client"; }
    // {
    }
    // optionalAttrs (res."config" != { }) { inherit (res) "config"; }
    // {
    }
    // optionalAttrs (res."deployment" != null) { "deployment" = mkDeployment res."deployment"; }
    // {
    }
    // optionalAttrs res."disableDefaultAdminSecret" { inherit (res) "disableDefaultAdminSecret"; }
    // {
    }
    // optionalAttrs (res."disableDefaultSecurityContext" != null) {
      inherit (res) "disableDefaultSecurityContext";
    }
    // {
    }
    // optionalAttrs (res."external" != null) { "external" = mkExternal res."external"; }
    // {
    }
    // optionalAttrs (res."ingress" != null) { "ingress" = mkIngress res."ingress"; }
    // {
    }
    // optionalAttrs (res."jsonnet" != null) { "jsonnet" = mkJsonnet res."jsonnet"; }
    // {
    }
    // optionalAttrs (res."persistentVolumeClaim" != null) {
      "persistentVolumeClaim" = mkPersistentVolumeClaim res."persistentVolumeClaim";
    }
    // {
    }
    // optionalAttrs (res."preferences" != null) { "preferences" = mkPreferences res."preferences"; }
    // {
    }
    // optionalAttrs (res."route" != null) { "route" = mkRoute res."route"; }
    // {
    }
    // optionalAttrs (res."service" != null) { "service" = mkService res."service"; }
    // {
    }
    // optionalAttrs (res."serviceAccount" != null) {
      "serviceAccount" = mkServiceAccount res."serviceAccount";
    }
    // {
    }
    // optionalAttrs res."suspend" { inherit (res) "suspend"; }
    // {
    }
    // optionalAttrs (res."version" != null) { inherit (res) "version"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkGrafana cfg."grafanas");
in
{
  options.openkrill.apps."grafana-operator" = {
    "grafanas" = mkOption {
      type = types.attrsOf GrafanasModule;
      default = { };
      description = "Grafana CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."grafana-operator".content = allResources;
  };
}
