# Auto-generated openkrill module fragment for kube-prometheus
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."kube-prometheus";
  compact = filterAttrs (_: v: v != null);
  AdditionalArgModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the argument, e.g. \"scrape.discovery-reload-interval\".";
        type = types.str;
      };
      "value" = mkOption {
        description = "Argument value, e.g. 30s. Can be empty for name-only arguments (e.g. --storage.tsdb.no-lockfile)";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkAdditionalArg =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  AdditionalScrapeConfigsModule = types.submodule {
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
  mkAdditionalScrapeConfigs =
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
  AffinityModule = types.submodule {
    options = {
      "nodeAffinity" = mkOption {
        description = "Describes node affinity scheduling rules for the pod.";
        type = (types.nullOr AffinityNodeAffinityModule);
        default = null;
      };
      "podAffinity" = mkOption {
        description = "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s)).";
        type = (types.nullOr AffinityPodAffinityModule);
        default = null;
      };
      "podAntiAffinity" = mkOption {
        description = "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s)).";
        type = (types.nullOr AffinityPodAntiAffinityModule);
        default = null;
      };
    };
  };
  mkAffinity =
    res:
    {
    }
    // optionalAttrs (res."nodeAffinity" != null) {
      "nodeAffinity" = mkAffinityNodeAffinity res."nodeAffinity";
    }
    // {
    }
    // optionalAttrs (res."podAffinity" != null) {
      "podAffinity" = mkAffinityPodAffinity res."podAffinity";
    }
    // {
    }
    // optionalAttrs (res."podAntiAffinity" != null) {
      "podAntiAffinity" = mkAffinityPodAntiAffinity res."podAntiAffinity";
    }
    // {
    };
  AffinityNodeAffinityModule = types.submodule {
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy\nthe affinity expressions specified by this field, but it may choose\na node that violates one or more of the expressions. The node that is\nmost preferred is the one with the greatest sum of weights, i.e.\nfor each node that meets all of the scheduling requirements (resource\nrequest, requiredDuringScheduling affinity expressions, etc.),\ncompute a sum by iterating through the elements of this field and adding\n\"weight\" to the sum if the node matches the corresponding matchExpressions; the\nnode(s) with the highest sum are the most preferred.";
        type = (types.listOf AffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule);
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the affinity requirements specified by this field are not met at\nscheduling time, the pod will not be scheduled onto the node.\nIf the affinity requirements specified by this field cease to be met\nat some point during pod execution (e.g. due to an update), the system\nmay or may not try to eventually evict the pod from its node.";
        type = (types.nullOr AffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule);
        default = null;
      };
    };
  };
  mkAffinityNodeAffinity =
    res:
    {
    }
    // optionalAttrs (res."preferredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "preferredDuringSchedulingIgnoredDuringExecution" =
        map mkAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecution
          res."preferredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    }
    // optionalAttrs (res."requiredDuringSchedulingIgnoredDuringExecution" != null) {
      "requiredDuringSchedulingIgnoredDuringExecution" =
        mkAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecution
          res."requiredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    };
  AffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule = types.submodule {
    options = {
      "preference" = mkOption {
        description = "A node selector term, associated with the corresponding weight.";
        type = AffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceModule;
      };
      "weight" = mkOption {
        description = "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100.";
        type = types.int;
      };
    };
  };
  mkAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecution = res: {
    "preference" =
      mkAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreference
        res."preference";
    inherit (res) "weight";
  };
  AffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            description = "The label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "Represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.";
            type = types.str;
          };
          "values" = mkOption {
            description = "An array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. If the operator is Gt or Lt, the values\narray must have a single element, which will be interpreted as an integer.\nThis array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchFieldModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            description = "The label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "Represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.";
            type = types.str;
          };
          "values" = mkOption {
            description = "An array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. If the operator is Gt or Lt, the values\narray must have a single element, which will be interpreted as an integer.\nThis array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchField =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "A list of node selector requirements by node's labels.";
            type = (
              types.listOf AffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpressionModule
            );
            default = [ ];
          };
          "matchFields" = mkOption {
            description = "A list of node selector requirements by node's fields.";
            type = (
              types.listOf AffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchFieldModule
            );
            default = [ ];
          };
        };
      };
  mkAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreference =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchFields" != [ ]) {
      "matchFields" =
        map mkAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchField
          res."matchFields";
    }
    // {
    };
  AffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule = types.submodule {
    options = {
      "nodeSelectorTerms" = mkOption {
        description = "Required. A list of node selector terms. The terms are ORed.";
        type = (
          types.listOf AffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermModule
        );
      };
    };
  };
  mkAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecution = res: {
    "nodeSelectorTerms" =
      map mkAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTerm
        res."nodeSelectorTerms";
  };
  AffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            description = "The label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "Represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.";
            type = types.str;
          };
          "values" = mkOption {
            description = "An array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. If the operator is Gt or Lt, the values\narray must have a single element, which will be interpreted as an integer.\nThis array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchFieldModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            description = "The label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "Represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.";
            type = types.str;
          };
          "values" = mkOption {
            description = "An array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. If the operator is Gt or Lt, the values\narray must have a single element, which will be interpreted as an integer.\nThis array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchField =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "A list of node selector requirements by node's labels.";
            type = (
              types.listOf AffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpressionModule
            );
            default = [ ];
          };
          "matchFields" = mkOption {
            description = "A list of node selector requirements by node's fields.";
            type = (
              types.listOf AffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchFieldModule
            );
            default = [ ];
          };
        };
      };
  mkAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTerm =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchFields" != [ ]) {
      "matchFields" =
        map mkAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchField
          res."matchFields";
    }
    // {
    };
  AffinityPodAffinityModule = types.submodule {
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy\nthe affinity expressions specified by this field, but it may choose\na node that violates one or more of the expressions. The node that is\nmost preferred is the one with the greatest sum of weights, i.e.\nfor each node that meets all of the scheduling requirements (resource\nrequest, requiredDuringScheduling affinity expressions, etc.),\ncompute a sum by iterating through the elements of this field and adding\n\"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the\nnode(s) with the highest sum are the most preferred.";
        type = (types.listOf AffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule);
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the affinity requirements specified by this field are not met at\nscheduling time, the pod will not be scheduled onto the node.\nIf the affinity requirements specified by this field cease to be met\nat some point during pod execution (e.g. due to a pod label update), the\nsystem may or may not try to eventually evict the pod from its node.\nWhen there are multiple elements, the lists of nodes corresponding to each\npodAffinityTerm are intersected, i.e. all terms must be satisfied.";
        type = (types.listOf AffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule);
        default = [ ];
      };
    };
  };
  mkAffinityPodAffinity =
    res:
    {
    }
    // optionalAttrs (res."preferredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "preferredDuringSchedulingIgnoredDuringExecution" =
        map mkAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecution
          res."preferredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    }
    // optionalAttrs (res."requiredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "requiredDuringSchedulingIgnoredDuringExecution" =
        map mkAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecution
          res."requiredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    };
  AffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule = types.submodule {
    options = {
      "podAffinityTerm" = mkOption {
        description = "Required. A pod affinity term, associated with the corresponding weight.";
        type = AffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule;
      };
      "weight" = mkOption {
        description = "weight associated with matching the corresponding podAffinityTerm,\nin the range 1-100.";
        type = types.int;
      };
    };
  };
  mkAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecution = res: {
    "podAffinityTerm" =
      mkAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm
        res."podAffinityTerm";
    inherit (res) "weight";
  };
  AffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf AffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  AffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.\nIf it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr AffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule
            );
            default = null;
          };
          "matchLabelKeys" = mkOption {
            description = "MatchLabelKeys is a set of pod label keys to select which pods will\nbe taken into consideration. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are merged with `labelSelector` as `key in (value)`\nto select the group of existing pods which pods will be taken into consideration\nfor the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming\npod labels will be ignored. The default value is empty.\nThe same key is forbidden to exist in both matchLabelKeys and labelSelector.\nAlso, matchLabelKeys cannot be set when labelSelector isn't set.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "mismatchLabelKeys" = mkOption {
            description = "MismatchLabelKeys is a set of pod label keys to select which pods will\nbe taken into consideration. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are merged with `labelSelector` as `key notin (value)`\nto select the group of existing pods which pods will be taken into consideration\nfor the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming\npod labels will be ignored. The default value is empty.\nThe same key is forbidden to exist in both mismatchLabelKeys and labelSelector.\nAlso, mismatchLabelKeys cannot be set when labelSelector isn't set.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to.\nThe term is applied to the union of the namespaces selected by this field\nand the ones listed in the namespaces field.\nnull selector and null or empty namespaces list means \"this pod's namespace\".\nAn empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr AffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule
            );
            default = null;
          };
          "namespaces" = mkOption {
            description = "namespaces specifies a static list of namespace names that the term applies to.\nThe term is applied to the union of the namespaces listed in this field\nand the ones selected by namespaceSelector.\nnull or empty namespaces list and null namespaceSelector means \"this pod's namespace\".";
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            description = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching\nthe labelSelector in the specified namespaces, where co-located is defined as running on a node\nwhose value of the label with key topologyKey matches that of any node on which any of the\nselected pods is running.\nEmpty topologyKey is not allowed.";
            type = types.str;
          };
        };
      };
  mkAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector
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
        mkAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  AffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf AffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  AffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf AffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  AffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule = types.submodule {
    options = {
      "labelSelector" = mkOption {
        description = "A label query over a set of resources, in this case pods.\nIf it's null, this PodAffinityTerm matches with no Pods.";
        type = (
          types.nullOr AffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule
        );
        default = null;
      };
      "matchLabelKeys" = mkOption {
        description = "MatchLabelKeys is a set of pod label keys to select which pods will\nbe taken into consideration. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are merged with `labelSelector` as `key in (value)`\nto select the group of existing pods which pods will be taken into consideration\nfor the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming\npod labels will be ignored. The default value is empty.\nThe same key is forbidden to exist in both matchLabelKeys and labelSelector.\nAlso, matchLabelKeys cannot be set when labelSelector isn't set.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "mismatchLabelKeys" = mkOption {
        description = "MismatchLabelKeys is a set of pod label keys to select which pods will\nbe taken into consideration. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are merged with `labelSelector` as `key notin (value)`\nto select the group of existing pods which pods will be taken into consideration\nfor the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming\npod labels will be ignored. The default value is empty.\nThe same key is forbidden to exist in both mismatchLabelKeys and labelSelector.\nAlso, mismatchLabelKeys cannot be set when labelSelector isn't set.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "namespaceSelector" = mkOption {
        description = "A label query over the set of namespaces that the term applies to.\nThe term is applied to the union of the namespaces selected by this field\nand the ones listed in the namespaces field.\nnull selector and null or empty namespaces list means \"this pod's namespace\".\nAn empty selector ({}) matches all namespaces.";
        type = (
          types.nullOr AffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule
        );
        default = null;
      };
      "namespaces" = mkOption {
        description = "namespaces specifies a static list of namespace names that the term applies to.\nThe term is applied to the union of the namespaces listed in this field\nand the ones selected by namespaceSelector.\nnull or empty namespaces list and null namespaceSelector means \"this pod's namespace\".";
        type = (types.listOf types.str);
        default = [ ];
      };
      "topologyKey" = mkOption {
        description = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching\nthe labelSelector in the specified namespaces, where co-located is defined as running on a node\nwhose value of the label with key topologyKey matches that of any node on which any of the\nselected pods is running.\nEmpty topologyKey is not allowed.";
        type = types.str;
      };
    };
  };
  mkAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecution =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector
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
        mkAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  AffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf AffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  AffinityPodAntiAffinityModule = types.submodule {
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy\nthe anti-affinity expressions specified by this field, but it may choose\na node that violates one or more of the expressions. The node that is\nmost preferred is the one with the greatest sum of weights, i.e.\nfor each node that meets all of the scheduling requirements (resource\nrequest, requiredDuringScheduling anti-affinity expressions, etc.),\ncompute a sum by iterating through the elements of this field and adding\n\"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the\nnode(s) with the highest sum are the most preferred.";
        type = (types.listOf AffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule);
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the anti-affinity requirements specified by this field are not met at\nscheduling time, the pod will not be scheduled onto the node.\nIf the anti-affinity requirements specified by this field cease to be met\nat some point during pod execution (e.g. due to a pod label update), the\nsystem may or may not try to eventually evict the pod from its node.\nWhen there are multiple elements, the lists of nodes corresponding to each\npodAffinityTerm are intersected, i.e. all terms must be satisfied.";
        type = (types.listOf AffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule);
        default = [ ];
      };
    };
  };
  mkAffinityPodAntiAffinity =
    res:
    {
    }
    // optionalAttrs (res."preferredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "preferredDuringSchedulingIgnoredDuringExecution" =
        map mkAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecution
          res."preferredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    }
    // optionalAttrs (res."requiredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "requiredDuringSchedulingIgnoredDuringExecution" =
        map mkAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecution
          res."requiredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    };
  AffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule = types.submodule {
    options = {
      "podAffinityTerm" = mkOption {
        description = "Required. A pod affinity term, associated with the corresponding weight.";
        type = AffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule;
      };
      "weight" = mkOption {
        description = "weight associated with matching the corresponding podAffinityTerm,\nin the range 1-100.";
        type = types.int;
      };
    };
  };
  mkAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecution = res: {
    "podAffinityTerm" =
      mkAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm
        res."podAffinityTerm";
    inherit (res) "weight";
  };
  AffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf AffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  AffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.\nIf it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr AffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule
            );
            default = null;
          };
          "matchLabelKeys" = mkOption {
            description = "MatchLabelKeys is a set of pod label keys to select which pods will\nbe taken into consideration. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are merged with `labelSelector` as `key in (value)`\nto select the group of existing pods which pods will be taken into consideration\nfor the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming\npod labels will be ignored. The default value is empty.\nThe same key is forbidden to exist in both matchLabelKeys and labelSelector.\nAlso, matchLabelKeys cannot be set when labelSelector isn't set.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "mismatchLabelKeys" = mkOption {
            description = "MismatchLabelKeys is a set of pod label keys to select which pods will\nbe taken into consideration. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are merged with `labelSelector` as `key notin (value)`\nto select the group of existing pods which pods will be taken into consideration\nfor the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming\npod labels will be ignored. The default value is empty.\nThe same key is forbidden to exist in both mismatchLabelKeys and labelSelector.\nAlso, mismatchLabelKeys cannot be set when labelSelector isn't set.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to.\nThe term is applied to the union of the namespaces selected by this field\nand the ones listed in the namespaces field.\nnull selector and null or empty namespaces list means \"this pod's namespace\".\nAn empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr AffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule
            );
            default = null;
          };
          "namespaces" = mkOption {
            description = "namespaces specifies a static list of namespace names that the term applies to.\nThe term is applied to the union of the namespaces listed in this field\nand the ones selected by namespaceSelector.\nnull or empty namespaces list and null namespaceSelector means \"this pod's namespace\".";
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            description = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching\nthe labelSelector in the specified namespaces, where co-located is defined as running on a node\nwhose value of the label with key topologyKey matches that of any node on which any of the\nselected pods is running.\nEmpty topologyKey is not allowed.";
            type = types.str;
          };
        };
      };
  mkAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector
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
        mkAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  AffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf AffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  AffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf AffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  AffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule = types.submodule {
    options = {
      "labelSelector" = mkOption {
        description = "A label query over a set of resources, in this case pods.\nIf it's null, this PodAffinityTerm matches with no Pods.";
        type = (
          types.nullOr AffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule
        );
        default = null;
      };
      "matchLabelKeys" = mkOption {
        description = "MatchLabelKeys is a set of pod label keys to select which pods will\nbe taken into consideration. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are merged with `labelSelector` as `key in (value)`\nto select the group of existing pods which pods will be taken into consideration\nfor the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming\npod labels will be ignored. The default value is empty.\nThe same key is forbidden to exist in both matchLabelKeys and labelSelector.\nAlso, matchLabelKeys cannot be set when labelSelector isn't set.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "mismatchLabelKeys" = mkOption {
        description = "MismatchLabelKeys is a set of pod label keys to select which pods will\nbe taken into consideration. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are merged with `labelSelector` as `key notin (value)`\nto select the group of existing pods which pods will be taken into consideration\nfor the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming\npod labels will be ignored. The default value is empty.\nThe same key is forbidden to exist in both mismatchLabelKeys and labelSelector.\nAlso, mismatchLabelKeys cannot be set when labelSelector isn't set.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "namespaceSelector" = mkOption {
        description = "A label query over the set of namespaces that the term applies to.\nThe term is applied to the union of the namespaces selected by this field\nand the ones listed in the namespaces field.\nnull selector and null or empty namespaces list means \"this pod's namespace\".\nAn empty selector ({}) matches all namespaces.";
        type = (
          types.nullOr AffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule
        );
        default = null;
      };
      "namespaces" = mkOption {
        description = "namespaces specifies a static list of namespace names that the term applies to.\nThe term is applied to the union of the namespaces listed in this field\nand the ones selected by namespaceSelector.\nnull or empty namespaces list and null namespaceSelector means \"this pod's namespace\".";
        type = (types.listOf types.str);
        default = [ ];
      };
      "topologyKey" = mkOption {
        description = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching\nthe labelSelector in the specified namespaces, where co-located is defined as running on a node\nwhose value of the label with key topologyKey matches that of any node on which any of the\nselected pods is running.\nEmpty topologyKey is not allowed.";
        type = types.str;
      };
    };
  };
  mkAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecution =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector
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
        mkAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  AffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf AffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ApiserverConfigAuthorizationCredentialsModule = types.submodule {
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
  mkApiserverConfigAuthorizationCredentials =
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
  ApiserverConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr ApiserverConfigAuthorizationCredentialsModule);
        default = null;
      };
      "credentialsFile" = mkOption {
        description = "File to read a secret from, mutually exclusive with `credentials`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkApiserverConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkApiserverConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."credentialsFile" != null) { inherit (res) "credentialsFile"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ApiserverConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr ApiserverConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr ApiserverConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkApiserverConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkApiserverConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkApiserverConfigBasicAuthUsername res."username";
    }
    // {
    };
  ApiserverConfigBasicAuthPasswordModule = types.submodule {
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
  mkApiserverConfigBasicAuthPassword =
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
  ApiserverConfigBasicAuthUsernameModule = types.submodule {
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
  mkApiserverConfigBasicAuthUsername =
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
  ApiserverConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization section for the API server.\n\nCannot be set at the same time as `basicAuth`, `bearerToken`, or\n`bearerTokenFile`.";
        type = (types.nullOr ApiserverConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "BasicAuth configuration for the API server.\n\nCannot be set at the same time as `authorization`, `bearerToken`, or\n`bearerTokenFile`.";
        type = (types.nullOr ApiserverConfigBasicAuthModule);
        default = null;
      };
      "bearerToken" = mkOption {
        description = "*Warning: this field shouldn't be used because the token value appears\nin clear-text. Prefer using `authorization`.*\n\nDeprecated: this will be removed in a future release.";
        type = (types.nullOr types.str);
        default = null;
      };
      "bearerTokenFile" = mkOption {
        description = "File to read bearer token for accessing apiserver.\n\nCannot be set at the same time as `basicAuth`, `authorization`, or `bearerToken`.\n\nDeprecated: this will be removed in a future release. Prefer using `authorization`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "host" = mkOption {
        description = "Kubernetes API address consisting of a hostname or IP address followed\nby an optional port number.";
        type = types.str;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "proxyConnectHeader" = mkOption {
        description = "ProxyConnectHeader optionally specifies headers to send to\nproxies during CONNECT requests.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.attrsOf (types.listOf (types.attrsOf types.anything)));
        default = { };
      };
      "proxyFromEnvironment" = mkOption {
        description = "Whether to use the proxy configuration defined by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY).\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = types.bool;
        default = false;
      };
      "proxyUrl" = mkOption {
        description = "`proxyURL` defines the HTTP proxy server to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS Config to use for the API server.";
        type = (types.nullOr ApiserverConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkApiserverConfig =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkApiserverConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkApiserverConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs (res."bearerToken" != null) { inherit (res) "bearerToken"; }
    // {
    }
    // optionalAttrs (res."bearerTokenFile" != null) { inherit (res) "bearerTokenFile"; }
    // {
      inherit (res) "host";
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."proxyConnectHeader" != { }) { inherit (res) "proxyConnectHeader"; }
    // {
    }
    // optionalAttrs res."proxyFromEnvironment" { inherit (res) "proxyFromEnvironment"; }
    // {
    }
    // optionalAttrs (res."proxyUrl" != null) { inherit (res) "proxyUrl"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkApiserverConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  ApiserverConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkApiserverConfigTlsConfigCaConfigMap =
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
  ApiserverConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ApiserverConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ApiserverConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkApiserverConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkApiserverConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkApiserverConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  ApiserverConfigTlsConfigCaSecretModule = types.submodule {
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
  mkApiserverConfigTlsConfigCaSecret =
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
  ApiserverConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkApiserverConfigTlsConfigCertConfigMap =
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
  ApiserverConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ApiserverConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ApiserverConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkApiserverConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkApiserverConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkApiserverConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  ApiserverConfigTlsConfigCertSecretModule = types.submodule {
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
  mkApiserverConfigTlsConfigCertSecret =
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
  ApiserverConfigTlsConfigKeySecretModule = types.submodule {
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
  mkApiserverConfigTlsConfigKeySecret =
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
  ApiserverConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ApiserverConfigTlsConfigCaModule);
        default = null;
      };
      "caFile" = mkOption {
        description = "Path to the CA cert in the Prometheus container to use for the targets.";
        type = (types.nullOr types.str);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ApiserverConfigTlsConfigCertModule);
        default = null;
      };
      "certFile" = mkOption {
        description = "Path to the client cert file in the Prometheus container for the targets.";
        type = (types.nullOr types.str);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keyFile" = mkOption {
        description = "Path to the client key file in the Prometheus container for the targets.";
        type = (types.nullOr types.str);
        default = null;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ApiserverConfigTlsConfigKeySecretModule);
        default = null;
      };
      "maxVersion" = mkOption {
        description = "Maximum acceptable TLS version.\n\nIt requires Prometheus >= v2.41.0 or Thanos >= v0.31.0.";
        type = (
          types.nullOr (
            types.enum [
              "TLS10"
              "TLS11"
              "TLS12"
              "TLS13"
            ]
          )
        );
        default = null;
      };
      "minVersion" = mkOption {
        description = "Minimum acceptable TLS version.\n\nIt requires Prometheus >= v2.35.0 or Thanos >= v0.28.0.";
        type = (
          types.nullOr (
            types.enum [
              "TLS10"
              "TLS11"
              "TLS12"
              "TLS13"
            ]
          )
        );
        default = null;
      };
      "serverName" = mkOption {
        description = "Used to verify the hostname for the targets.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkApiserverConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkApiserverConfigTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."caFile" != null) { inherit (res) "caFile"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkApiserverConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs (res."certFile" != null) { inherit (res) "certFile"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keyFile" != null) { inherit (res) "keyFile"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkApiserverConfigTlsConfigKeySecret res."keySecret";
    }
    // {
    }
    // optionalAttrs (res."maxVersion" != null) { inherit (res) "maxVersion"; }
    // {
    }
    // optionalAttrs (res."minVersion" != null) { inherit (res) "minVersion"; }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    };
  ArbitraryFSAccessThroughSMsModule = types.submodule {
    options = {
      "deny" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkArbitraryFSAccessThroughSMs =
    res:
    {
    }
    // optionalAttrs res."deny" { inherit (res) "deny"; }
    // {
    };
  ContainerEnvFromConfigMapRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "Specify whether the ConfigMap must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkContainerEnvFromConfigMapRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ContainerEnvFromModule = types.submodule {
    options = {
      "configMapRef" = mkOption {
        description = "The ConfigMap to select from";
        type = (types.nullOr ContainerEnvFromConfigMapRefModule);
        default = null;
      };
      "prefix" = mkOption {
        description = "Optional text to prepend to the name of each environment variable. Must be a C_IDENTIFIER.";
        type = (types.nullOr types.str);
        default = null;
      };
      "secretRef" = mkOption {
        description = "The Secret to select from";
        type = (types.nullOr ContainerEnvFromSecretRefModule);
        default = null;
      };
    };
  };
  mkContainerEnvFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapRef" != null) {
      "configMapRef" = mkContainerEnvFromConfigMapRef res."configMapRef";
    }
    // {
    }
    // optionalAttrs (res."prefix" != null) { inherit (res) "prefix"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkContainerEnvFromSecretRef res."secretRef";
    }
    // {
    };
  ContainerEnvFromSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "Specify whether the Secret must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkContainerEnvFromSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ContainerEnvModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the environment variable. Must be a C_IDENTIFIER.";
        type = types.str;
      };
      "value" = mkOption {
        description = "Variable references $(VAR_NAME) are expanded\nusing the previously defined environment variables in the container and\nany service environment variables. If a variable cannot be resolved,\nthe reference in the input string will be unchanged. Double $$ are reduced\nto a single $, which allows for escaping the $(VAR_NAME) syntax: i.e.\n\"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\".\nEscaped references will never be expanded, regardless of whether the variable\nexists or not.\nDefaults to \"\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "valueFrom" = mkOption {
        description = "Source for the environment variable's value. Cannot be used if value is not empty.";
        type = (types.nullOr ContainerEnvValueFromModule);
        default = null;
      };
    };
  };
  mkContainerEnv =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    }
    // optionalAttrs (res."valueFrom" != null) {
      "valueFrom" = mkContainerEnvValueFrom res."valueFrom";
    }
    // {
    };
  ContainerEnvValueFromConfigMapKeyRefModule = types.submodule {
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
  mkContainerEnvValueFromConfigMapKeyRef =
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
  ContainerEnvValueFromFieldRefModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        description = "Version of the schema the FieldPath is written in terms of, defaults to \"v1\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "fieldPath" = mkOption {
        description = "Path of the field to select in the specified API version.";
        type = types.str;
      };
    };
  };
  mkContainerEnvValueFromFieldRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "fieldPath";
    };
  ContainerEnvValueFromModule = types.submodule {
    options = {
      "configMapKeyRef" = mkOption {
        description = "Selects a key of a ConfigMap.";
        type = (types.nullOr ContainerEnvValueFromConfigMapKeyRefModule);
        default = null;
      };
      "fieldRef" = mkOption {
        description = "Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`,\nspec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs.";
        type = (types.nullOr ContainerEnvValueFromFieldRefModule);
        default = null;
      };
      "resourceFieldRef" = mkOption {
        description = "Selects a resource of the container: only resources limits and requests\n(limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported.";
        type = (types.nullOr ContainerEnvValueFromResourceFieldRefModule);
        default = null;
      };
      "secretKeyRef" = mkOption {
        description = "Selects a key of a secret in the pod's namespace";
        type = (types.nullOr ContainerEnvValueFromSecretKeyRefModule);
        default = null;
      };
    };
  };
  mkContainerEnvValueFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapKeyRef" != null) {
      "configMapKeyRef" = mkContainerEnvValueFromConfigMapKeyRef res."configMapKeyRef";
    }
    // {
    }
    // optionalAttrs (res."fieldRef" != null) {
      "fieldRef" = mkContainerEnvValueFromFieldRef res."fieldRef";
    }
    // {
    }
    // optionalAttrs (res."resourceFieldRef" != null) {
      "resourceFieldRef" = mkContainerEnvValueFromResourceFieldRef res."resourceFieldRef";
    }
    // {
    }
    // optionalAttrs (res."secretKeyRef" != null) {
      "secretKeyRef" = mkContainerEnvValueFromSecretKeyRef res."secretKeyRef";
    }
    // {
    };
  ContainerEnvValueFromResourceFieldRefModule = types.submodule {
    options = {
      "containerName" = mkOption {
        description = "Container name: required for volumes, optional for env vars";
        type = (types.nullOr types.str);
        default = null;
      };
      "divisor" = mkOption {
        description = "Specifies the output format of the exposed resources, defaults to \"1\"";
        type = types.anything;
        default = { };
      };
      "resource" = mkOption {
        description = "Required: resource to select";
        type = types.str;
      };
    };
  };
  mkContainerEnvValueFromResourceFieldRef =
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
  ContainerEnvValueFromSecretKeyRefModule = types.submodule {
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
  mkContainerEnvValueFromSecretKeyRef =
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
  ContainerLifecycleModule = types.submodule {
    options = {
      "postStart" = mkOption {
        description = "PostStart is called immediately after a container is created. If the handler fails,\nthe container is terminated and restarted according to its restart policy.\nOther management of the container blocks until the hook completes.\nMore info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks";
        type = (types.nullOr ContainerLifecyclePostStartModule);
        default = null;
      };
      "preStop" = mkOption {
        description = "PreStop is called immediately before a container is terminated due to an\nAPI request or management event such as liveness/startup probe failure,\npreemption, resource contention, etc. The handler is not called if the\ncontainer crashes or exits. The Pod's termination grace period countdown begins before the\nPreStop hook is executed. Regardless of the outcome of the handler, the\ncontainer will eventually terminate within the Pod's termination grace\nperiod (unless delayed by finalizers). Other management of the container blocks until the hook completes\nor until the termination grace period is reached.\nMore info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks";
        type = (types.nullOr ContainerLifecyclePreStopModule);
        default = null;
      };
      "stopSignal" = mkOption {
        description = "StopSignal defines which signal will be sent to a container when it is being stopped.\nIf not specified, the default is defined by the container runtime in use.\nStopSignal can only be set for Pods with a non-empty .spec.os.name";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkContainerLifecycle =
    res:
    {
    }
    // optionalAttrs (res."postStart" != null) {
      "postStart" = mkContainerLifecyclePostStart res."postStart";
    }
    // {
    }
    // optionalAttrs (res."preStop" != null) { "preStop" = mkContainerLifecyclePreStop res."preStop"; }
    // {
    }
    // optionalAttrs (res."stopSignal" != null) { inherit (res) "stopSignal"; }
    // {
    };
  ContainerLifecyclePostStartExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkContainerLifecyclePostStartExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  ContainerLifecyclePostStartHttpGetHttpHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "The header field name.\nThis will be canonicalized upon output, so case-variant names will be understood as the same header.";
        type = types.str;
      };
      "value" = mkOption {
        description = "The header field value";
        type = types.str;
      };
    };
  };
  mkContainerLifecyclePostStartHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  ContainerLifecyclePostStartHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf ContainerLifecyclePostStartHttpGetHttpHeaderModule);
        default = [ ];
      };
      "path" = mkOption {
        description = "Path to access on the HTTP server.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Name or number of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
      "scheme" = mkOption {
        description = "Scheme to use for connecting to the host.\nDefaults to HTTP.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkContainerLifecyclePostStartHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" = map mkContainerLifecyclePostStartHttpGetHttpHeader res."httpHeaders";
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
  ContainerLifecyclePostStartModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr ContainerLifecyclePostStartExecModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr ContainerLifecyclePostStartHttpGetModule);
        default = null;
      };
      "sleep" = mkOption {
        description = "Sleep represents a duration that the container should sleep.";
        type = (types.nullOr ContainerLifecyclePostStartSleepModule);
        default = null;
      };
      "tcpSocket" = mkOption {
        description = "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept\nfor backward compatibility. There is no validation of this field and\nlifecycle hooks will fail at runtime when it is specified.";
        type = (types.nullOr ContainerLifecyclePostStartTcpSocketModule);
        default = null;
      };
    };
  };
  mkContainerLifecyclePostStart =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) { "exec" = mkContainerLifecyclePostStartExec res."exec"; }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkContainerLifecyclePostStartHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."sleep" != null) { "sleep" = mkContainerLifecyclePostStartSleep res."sleep"; }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" = mkContainerLifecyclePostStartTcpSocket res."tcpSocket";
    }
    // {
    };
  ContainerLifecyclePostStartSleepModule = types.submodule {
    options = {
      "seconds" = mkOption {
        description = "Seconds is the number of seconds to sleep.";
        type = types.int;
      };
    };
  };
  mkContainerLifecyclePostStartSleep = res: {
    inherit (res) "seconds";
  };
  ContainerLifecyclePostStartTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Optional: Host name to connect to, defaults to the pod IP.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Number or name of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
    };
  };
  mkContainerLifecyclePostStartTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  ContainerLifecyclePreStopExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkContainerLifecyclePreStopExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  ContainerLifecyclePreStopHttpGetHttpHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "The header field name.\nThis will be canonicalized upon output, so case-variant names will be understood as the same header.";
        type = types.str;
      };
      "value" = mkOption {
        description = "The header field value";
        type = types.str;
      };
    };
  };
  mkContainerLifecyclePreStopHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  ContainerLifecyclePreStopHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf ContainerLifecyclePreStopHttpGetHttpHeaderModule);
        default = [ ];
      };
      "path" = mkOption {
        description = "Path to access on the HTTP server.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Name or number of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
      "scheme" = mkOption {
        description = "Scheme to use for connecting to the host.\nDefaults to HTTP.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkContainerLifecyclePreStopHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" = map mkContainerLifecyclePreStopHttpGetHttpHeader res."httpHeaders";
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
  ContainerLifecyclePreStopModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr ContainerLifecyclePreStopExecModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr ContainerLifecyclePreStopHttpGetModule);
        default = null;
      };
      "sleep" = mkOption {
        description = "Sleep represents a duration that the container should sleep.";
        type = (types.nullOr ContainerLifecyclePreStopSleepModule);
        default = null;
      };
      "tcpSocket" = mkOption {
        description = "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept\nfor backward compatibility. There is no validation of this field and\nlifecycle hooks will fail at runtime when it is specified.";
        type = (types.nullOr ContainerLifecyclePreStopTcpSocketModule);
        default = null;
      };
    };
  };
  mkContainerLifecyclePreStop =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) { "exec" = mkContainerLifecyclePreStopExec res."exec"; }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkContainerLifecyclePreStopHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."sleep" != null) { "sleep" = mkContainerLifecyclePreStopSleep res."sleep"; }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" = mkContainerLifecyclePreStopTcpSocket res."tcpSocket";
    }
    // {
    };
  ContainerLifecyclePreStopSleepModule = types.submodule {
    options = {
      "seconds" = mkOption {
        description = "Seconds is the number of seconds to sleep.";
        type = types.int;
      };
    };
  };
  mkContainerLifecyclePreStopSleep = res: {
    inherit (res) "seconds";
  };
  ContainerLifecyclePreStopTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Optional: Host name to connect to, defaults to the pod IP.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Number or name of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
    };
  };
  mkContainerLifecyclePreStopTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  ContainerLivenessProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkContainerLivenessProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  ContainerLivenessProbeGrpcModule = types.submodule {
    options = {
      "port" = mkOption {
        description = "Port number of the gRPC service. Number must be in the range 1 to 65535.";
        type = types.int;
      };
      "service" = mkOption {
        description = "Service is the name of the service to place in the gRPC HealthCheckRequest\n(see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).\n\nIf this is not specified, the default behavior is defined by gRPC.";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkContainerLivenessProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  ContainerLivenessProbeHttpGetHttpHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "The header field name.\nThis will be canonicalized upon output, so case-variant names will be understood as the same header.";
        type = types.str;
      };
      "value" = mkOption {
        description = "The header field value";
        type = types.str;
      };
    };
  };
  mkContainerLivenessProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  ContainerLivenessProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf ContainerLivenessProbeHttpGetHttpHeaderModule);
        default = [ ];
      };
      "path" = mkOption {
        description = "Path to access on the HTTP server.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Name or number of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
      "scheme" = mkOption {
        description = "Scheme to use for connecting to the host.\nDefaults to HTTP.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkContainerLivenessProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" = map mkContainerLivenessProbeHttpGetHttpHeader res."httpHeaders";
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
  ContainerLivenessProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr ContainerLivenessProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        description = "Minimum consecutive failures for the probe to be considered failed after having succeeded.\nDefaults to 3. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        description = "GRPC specifies a GRPC HealthCheckRequest.";
        type = (types.nullOr ContainerLivenessProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr ContainerLivenessProbeHttpGetModule);
        default = null;
      };
      "initialDelaySeconds" = mkOption {
        description = "Number of seconds after the container has started before liveness probes are initiated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr types.int);
        default = null;
      };
      "periodSeconds" = mkOption {
        description = "How often (in seconds) to perform the probe.\nDefault to 10 seconds. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "successThreshold" = mkOption {
        description = "Minimum consecutive successes for the probe to be considered successful after having failed.\nDefaults to 1. Must be 1 for liveness and startup. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "tcpSocket" = mkOption {
        description = "TCPSocket specifies a connection to a TCP port.";
        type = (types.nullOr ContainerLivenessProbeTcpSocketModule);
        default = null;
      };
      "terminationGracePeriodSeconds" = mkOption {
        description = "Optional duration in seconds the pod needs to terminate gracefully upon probe failure.\nThe grace period is the duration in seconds after the processes running in the pod are sent\na termination signal and the time when the processes are forcibly halted with a kill signal.\nSet this value longer than the expected cleanup time for your process.\nIf this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this\nvalue overrides the value provided by the pod spec.\nValue must be non-negative integer. The value zero indicates stop immediately via\nthe kill signal (no opportunity to shut down).\nThis is a beta field and requires enabling ProbeTerminationGracePeriod feature gate.\nMinimum value is 1. spec.terminationGracePeriodSeconds is used if unset.";
        type = (types.nullOr types.int);
        default = null;
      };
      "timeoutSeconds" = mkOption {
        description = "Number of seconds after which the probe times out.\nDefaults to 1 second. Minimum value is 1.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkContainerLivenessProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) { "exec" = mkContainerLivenessProbeExec res."exec"; }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) { "grpc" = mkContainerLivenessProbeGrpc res."grpc"; }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkContainerLivenessProbeHttpGet res."httpGet";
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
      "tcpSocket" = mkContainerLivenessProbeTcpSocket res."tcpSocket";
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
  ContainerLivenessProbeTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Optional: Host name to connect to, defaults to the pod IP.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Number or name of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
    };
  };
  mkContainerLivenessProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  ContainerModule = types.submodule {
    options = {
      "args" = mkOption {
        description = "Arguments to the entrypoint.\nThe container image's CMD is used if this is not provided.\nVariable references $(VAR_NAME) are expanded using the container's environment. If a variable\ncannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced\nto a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will\nproduce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless\nof whether the variable exists or not. Cannot be updated.\nMore info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell";
        type = (types.listOf types.str);
        default = [ ];
      };
      "command" = mkOption {
        description = "Entrypoint array. Not executed within a shell.\nThe container image's ENTRYPOINT is used if this is not provided.\nVariable references $(VAR_NAME) are expanded using the container's environment. If a variable\ncannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced\nto a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will\nproduce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless\nof whether the variable exists or not. Cannot be updated.\nMore info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell";
        type = (types.listOf types.str);
        default = [ ];
      };
      "env" = mkOption {
        description = "List of environment variables to set in the container.\nCannot be updated.";
        type = (types.listOf ContainerEnvModule);
        default = [ ];
      };
      "envFrom" = mkOption {
        description = "List of sources to populate environment variables in the container.\nThe keys defined within a source must be a C_IDENTIFIER. All invalid keys\nwill be reported as an event when the container is starting. When a key exists in multiple\nsources, the value associated with the last source will take precedence.\nValues defined by an Env with a duplicate key will take precedence.\nCannot be updated.";
        type = (types.listOf ContainerEnvFromModule);
        default = [ ];
      };
      "image" = mkOption {
        description = "Container image name.\nMore info: https://kubernetes.io/docs/concepts/containers/images\nThis field is optional to allow higher level config management to default or override\ncontainer images in workload controllers like Deployments and StatefulSets.";
        type = (types.nullOr types.str);
        default = null;
      };
      "imagePullPolicy" = mkOption {
        description = "Image pull policy.\nOne of Always, Never, IfNotPresent.\nDefaults to Always if :latest tag is specified, or IfNotPresent otherwise.\nCannot be updated.\nMore info: https://kubernetes.io/docs/concepts/containers/images#updating-images";
        type = (types.nullOr types.str);
        default = null;
      };
      "lifecycle" = mkOption {
        description = "Actions that the management system should take in response to container lifecycle events.\nCannot be updated.";
        type = (types.nullOr ContainerLifecycleModule);
        default = null;
      };
      "livenessProbe" = mkOption {
        description = "Periodic probe of container liveness.\nContainer will be restarted if the probe fails.\nCannot be updated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr ContainerLivenessProbeModule);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the container specified as a DNS_LABEL.\nEach container in a pod must have a unique name (DNS_LABEL).\nCannot be updated.";
        type = types.str;
      };
      "ports" = mkOption {
        description = "List of ports to expose from the container. Not specifying a port here\nDOES NOT prevent that port from being exposed. Any port which is\nlistening on the default \"0.0.0.0\" address inside a container will be\naccessible from the network.\nModifying this array with strategic merge patch may corrupt the data.\nFor more information See https://github.com/kubernetes/kubernetes/issues/108255.\nCannot be updated.";
        type = (types.listOf ContainerPortModule);
        default = [ ];
      };
      "readinessProbe" = mkOption {
        description = "Periodic probe of container service readiness.\nContainer will be removed from service endpoints if the probe fails.\nCannot be updated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr ContainerReadinessProbeModule);
        default = null;
      };
      "resizePolicy" = mkOption {
        description = "Resources resize policy for the container.";
        type = (types.listOf ContainerResizePolicyModule);
        default = [ ];
      };
      "resources" = mkOption {
        description = "Compute Resources required by this container.\nCannot be updated.\nMore info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.nullOr ContainerResourcesModule);
        default = null;
      };
      "restartPolicy" = mkOption {
        description = "RestartPolicy defines the restart behavior of individual containers in a pod.\nThis field may only be set for init containers, and the only allowed value is \"Always\".\nFor non-init containers or when this field is not specified,\nthe restart behavior is defined by the Pod's restart policy and the container type.\nSetting the RestartPolicy as \"Always\" for the init container will have the following effect:\nthis init container will be continually restarted on\nexit until all regular containers have terminated. Once all regular\ncontainers have completed, all init containers with restartPolicy \"Always\"\nwill be shut down. This lifecycle differs from normal init containers and\nis often referred to as a \"sidecar\" container. Although this init\ncontainer still starts in the init container sequence, it does not wait\nfor the container to complete before proceeding to the next init\ncontainer. Instead, the next init container starts immediately after this\ninit container is started, or after any startupProbe has successfully\ncompleted.";
        type = (types.nullOr types.str);
        default = null;
      };
      "securityContext" = mkOption {
        description = "SecurityContext defines the security options the container should be run with.\nIf set, the fields of SecurityContext override the equivalent fields of PodSecurityContext.\nMore info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/";
        type = (types.nullOr ContainerSecurityContextModule);
        default = null;
      };
      "startupProbe" = mkOption {
        description = "StartupProbe indicates that the Pod has successfully initialized.\nIf specified, no other probes are executed until this completes successfully.\nIf this probe fails, the Pod will be restarted, just as if the livenessProbe failed.\nThis can be used to provide different probe parameters at the beginning of a Pod's lifecycle,\nwhen it might take a long time to load data or warm a cache, than during steady-state operation.\nThis cannot be updated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr ContainerStartupProbeModule);
        default = null;
      };
      "stdin" = mkOption {
        description = "Whether this container should allocate a buffer for stdin in the container runtime. If this\nis not set, reads from stdin in the container will always result in EOF.\nDefault is false.";
        type = types.bool;
        default = false;
      };
      "stdinOnce" = mkOption {
        description = "Whether the container runtime should close the stdin channel after it has been opened by\na single attach. When stdin is true the stdin stream will remain open across multiple attach\nsessions. If stdinOnce is set to true, stdin is opened on container start, is empty until the\nfirst client attaches to stdin, and then remains open and accepts data until the client disconnects,\nat which time stdin is closed and remains closed until the container is restarted. If this\nflag is false, a container processes that reads from stdin will never receive an EOF.\nDefault is false";
        type = types.bool;
        default = false;
      };
      "terminationMessagePath" = mkOption {
        description = "Optional: Path at which the file to which the container's termination message\nwill be written is mounted into the container's filesystem.\nMessage written is intended to be brief final status, such as an assertion failure message.\nWill be truncated by the node if greater than 4096 bytes. The total message length across\nall containers will be limited to 12kb.\nDefaults to /dev/termination-log.\nCannot be updated.";
        type = (types.nullOr types.str);
        default = null;
      };
      "terminationMessagePolicy" = mkOption {
        description = "Indicate how the termination message should be populated. File will use the contents of\nterminationMessagePath to populate the container status message on both success and failure.\nFallbackToLogsOnError will use the last chunk of container log output if the termination\nmessage file is empty and the container exited with an error.\nThe log output is limited to 2048 bytes or 80 lines, whichever is smaller.\nDefaults to File.\nCannot be updated.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tty" = mkOption {
        description = "Whether this container should allocate a TTY for itself, also requires 'stdin' to be true.\nDefault is false.";
        type = types.bool;
        default = false;
      };
      "volumeDevices" = mkOption {
        description = "volumeDevices is the list of block devices to be used by the container.";
        type = (types.listOf ContainerVolumeDeviceModule);
        default = [ ];
      };
      "volumeMounts" = mkOption {
        description = "Pod volumes to mount into the container's filesystem.\nCannot be updated.";
        type = (types.listOf ContainerVolumeMountModule);
        default = [ ];
      };
      "workingDir" = mkOption {
        description = "Container's working directory.\nIf not specified, the container runtime's default will be used, which\nmight be configured in the container image.\nCannot be updated.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkContainer =
    res:
    {
    }
    // optionalAttrs (res."args" != [ ]) { inherit (res) "args"; }
    // {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    }
    // optionalAttrs (res."env" != [ ]) { "env" = map mkContainerEnv res."env"; }
    // {
    }
    // optionalAttrs (res."envFrom" != [ ]) { "envFrom" = map mkContainerEnvFrom res."envFrom"; }
    // {
    }
    // optionalAttrs (res."image" != null) { inherit (res) "image"; }
    // {
    }
    // optionalAttrs (res."imagePullPolicy" != null) { inherit (res) "imagePullPolicy"; }
    // {
    }
    // optionalAttrs (res."lifecycle" != null) { "lifecycle" = mkContainerLifecycle res."lifecycle"; }
    // {
    }
    // optionalAttrs (res."livenessProbe" != null) {
      "livenessProbe" = mkContainerLivenessProbe res."livenessProbe";
    }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."ports" != [ ]) { "ports" = map mkContainerPort res."ports"; }
    // {
    }
    // optionalAttrs (res."readinessProbe" != null) {
      "readinessProbe" = mkContainerReadinessProbe res."readinessProbe";
    }
    // {
    }
    // optionalAttrs (res."resizePolicy" != [ ]) {
      "resizePolicy" = map mkContainerResizePolicy res."resizePolicy";
    }
    // {
    }
    // optionalAttrs (res."resources" != null) { "resources" = mkContainerResources res."resources"; }
    // {
    }
    // optionalAttrs (res."restartPolicy" != null) { inherit (res) "restartPolicy"; }
    // {
    }
    // optionalAttrs (res."securityContext" != null) {
      "securityContext" = mkContainerSecurityContext res."securityContext";
    }
    // {
    }
    // optionalAttrs (res."startupProbe" != null) {
      "startupProbe" = mkContainerStartupProbe res."startupProbe";
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
      "volumeDevices" = map mkContainerVolumeDevice res."volumeDevices";
    }
    // {
    }
    // optionalAttrs (res."volumeMounts" != [ ]) {
      "volumeMounts" = map mkContainerVolumeMount res."volumeMounts";
    }
    // {
    }
    // optionalAttrs (res."workingDir" != null) { inherit (res) "workingDir"; }
    // {
    };
  ContainerPortModule = types.submodule {
    options = {
      "containerPort" = mkOption {
        description = "Number of port to expose on the pod's IP address.\nThis must be a valid port number, 0 < x < 65536.";
        type = types.int;
      };
      "hostIP" = mkOption {
        description = "What host IP to bind the external port to.";
        type = (types.nullOr types.str);
        default = null;
      };
      "hostPort" = mkOption {
        description = "Number of port to expose on the host.\nIf specified, this must be a valid port number, 0 < x < 65536.\nIf HostNetwork is specified, this must match ContainerPort.\nMost containers do not need this.";
        type = (types.nullOr types.int);
        default = null;
      };
      "name" = mkOption {
        description = "If specified, this must be an IANA_SVC_NAME and unique within the pod. Each\nnamed port in a pod must have a unique name. Name for the port that can be\nreferred to by services.";
        type = (types.nullOr types.str);
        default = null;
      };
      "protocol" = mkOption {
        description = "Protocol for port. Must be UDP, TCP, or SCTP.\nDefaults to \"TCP\".";
        type = (types.nullOr types.str);
        default = "TCP";
      };
    };
  };
  mkContainerPort =
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
  ContainerReadinessProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkContainerReadinessProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  ContainerReadinessProbeGrpcModule = types.submodule {
    options = {
      "port" = mkOption {
        description = "Port number of the gRPC service. Number must be in the range 1 to 65535.";
        type = types.int;
      };
      "service" = mkOption {
        description = "Service is the name of the service to place in the gRPC HealthCheckRequest\n(see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).\n\nIf this is not specified, the default behavior is defined by gRPC.";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkContainerReadinessProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  ContainerReadinessProbeHttpGetHttpHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "The header field name.\nThis will be canonicalized upon output, so case-variant names will be understood as the same header.";
        type = types.str;
      };
      "value" = mkOption {
        description = "The header field value";
        type = types.str;
      };
    };
  };
  mkContainerReadinessProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  ContainerReadinessProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf ContainerReadinessProbeHttpGetHttpHeaderModule);
        default = [ ];
      };
      "path" = mkOption {
        description = "Path to access on the HTTP server.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Name or number of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
      "scheme" = mkOption {
        description = "Scheme to use for connecting to the host.\nDefaults to HTTP.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkContainerReadinessProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" = map mkContainerReadinessProbeHttpGetHttpHeader res."httpHeaders";
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
  ContainerReadinessProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr ContainerReadinessProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        description = "Minimum consecutive failures for the probe to be considered failed after having succeeded.\nDefaults to 3. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        description = "GRPC specifies a GRPC HealthCheckRequest.";
        type = (types.nullOr ContainerReadinessProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr ContainerReadinessProbeHttpGetModule);
        default = null;
      };
      "initialDelaySeconds" = mkOption {
        description = "Number of seconds after the container has started before liveness probes are initiated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr types.int);
        default = null;
      };
      "periodSeconds" = mkOption {
        description = "How often (in seconds) to perform the probe.\nDefault to 10 seconds. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "successThreshold" = mkOption {
        description = "Minimum consecutive successes for the probe to be considered successful after having failed.\nDefaults to 1. Must be 1 for liveness and startup. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "tcpSocket" = mkOption {
        description = "TCPSocket specifies a connection to a TCP port.";
        type = (types.nullOr ContainerReadinessProbeTcpSocketModule);
        default = null;
      };
      "terminationGracePeriodSeconds" = mkOption {
        description = "Optional duration in seconds the pod needs to terminate gracefully upon probe failure.\nThe grace period is the duration in seconds after the processes running in the pod are sent\na termination signal and the time when the processes are forcibly halted with a kill signal.\nSet this value longer than the expected cleanup time for your process.\nIf this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this\nvalue overrides the value provided by the pod spec.\nValue must be non-negative integer. The value zero indicates stop immediately via\nthe kill signal (no opportunity to shut down).\nThis is a beta field and requires enabling ProbeTerminationGracePeriod feature gate.\nMinimum value is 1. spec.terminationGracePeriodSeconds is used if unset.";
        type = (types.nullOr types.int);
        default = null;
      };
      "timeoutSeconds" = mkOption {
        description = "Number of seconds after which the probe times out.\nDefaults to 1 second. Minimum value is 1.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkContainerReadinessProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) { "exec" = mkContainerReadinessProbeExec res."exec"; }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) { "grpc" = mkContainerReadinessProbeGrpc res."grpc"; }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkContainerReadinessProbeHttpGet res."httpGet";
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
      "tcpSocket" = mkContainerReadinessProbeTcpSocket res."tcpSocket";
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
  ContainerReadinessProbeTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Optional: Host name to connect to, defaults to the pod IP.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Number or name of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
    };
  };
  mkContainerReadinessProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  ContainerResizePolicyModule = types.submodule {
    options = {
      "resourceName" = mkOption {
        description = "Name of the resource to which this resource resize policy applies.\nSupported values: cpu, memory.";
        type = types.str;
      };
      "restartPolicy" = mkOption {
        description = "Restart policy to apply when specified resource is resized.\nIf not specified, it defaults to NotRequired.";
        type = types.str;
      };
    };
  };
  mkContainerResizePolicy = res: {
    inherit (res) "resourceName";
    inherit (res) "restartPolicy";
  };
  ContainerResourcesClaimModule = types.submodule {
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
  mkContainerResourcesClaim =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."request" != null) { inherit (res) "request"; }
    // {
    };
  ContainerResourcesModule = types.submodule {
    options = {
      "claims" = mkOption {
        description = "Claims lists the names of resources, defined in spec.resourceClaims,\nthat are used by this container.\n\nThis is an alpha field and requires enabling the\nDynamicResourceAllocation feature gate.\n\nThis field is immutable. It can only be set for containers.";
        type = (types.listOf ContainerResourcesClaimModule);
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
  mkContainerResources =
    res:
    {
    }
    // optionalAttrs (res."claims" != [ ]) { "claims" = map mkContainerResourcesClaim res."claims"; }
    // {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  ContainerSecurityContextAppArmorProfileModule = types.submodule {
    options = {
      "localhostProfile" = mkOption {
        description = "localhostProfile indicates a profile loaded on the node that should be used.\nThe profile must be preconfigured on the node to work.\nMust match the loaded name of the profile.\nMust be set if and only if type is \"Localhost\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "type indicates which kind of AppArmor profile will be applied.\nValid options are:\n  Localhost - a profile pre-loaded on the node.\n  RuntimeDefault - the container runtime's default profile.\n  Unconfined - no AppArmor enforcement.";
        type = types.str;
      };
    };
  };
  mkContainerSecurityContextAppArmorProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  ContainerSecurityContextCapabilitiesModule = types.submodule {
    options = {
      "add" = mkOption {
        description = "Added capabilities";
        type = (types.listOf types.str);
        default = [ ];
      };
      "drop" = mkOption {
        description = "Removed capabilities";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkContainerSecurityContextCapabilities =
    res:
    {
    }
    // optionalAttrs (res."add" != [ ]) { inherit (res) "add"; }
    // {
    }
    // optionalAttrs (res."drop" != [ ]) { inherit (res) "drop"; }
    // {
    };
  ContainerSecurityContextModule = types.submodule {
    options = {
      "allowPrivilegeEscalation" = mkOption {
        description = "AllowPrivilegeEscalation controls whether a process can gain more\nprivileges than its parent process. This bool directly controls if\nthe no_new_privs flag will be set on the container process.\nAllowPrivilegeEscalation is true always when the container is:\n1) run as Privileged\n2) has CAP_SYS_ADMIN\nNote that this field cannot be set when spec.os.name is windows.";
        type = types.bool;
        default = false;
      };
      "appArmorProfile" = mkOption {
        description = "appArmorProfile is the AppArmor options to use by this container. If set, this profile\noverrides the pod's appArmorProfile.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr ContainerSecurityContextAppArmorProfileModule);
        default = null;
      };
      "capabilities" = mkOption {
        description = "The capabilities to add/drop when running containers.\nDefaults to the default set of capabilities granted by the container runtime.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr ContainerSecurityContextCapabilitiesModule);
        default = null;
      };
      "privileged" = mkOption {
        description = "Run container in privileged mode.\nProcesses in privileged containers are essentially equivalent to root on the host.\nDefaults to false.\nNote that this field cannot be set when spec.os.name is windows.";
        type = types.bool;
        default = false;
      };
      "procMount" = mkOption {
        description = "procMount denotes the type of proc mount to use for the containers.\nThe default value is Default which uses the container runtime defaults for\nreadonly paths and masked paths.\nThis requires the ProcMountType feature flag to be enabled.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnlyRootFilesystem" = mkOption {
        description = "Whether this container has a read-only root filesystem.\nDefault is false.\nNote that this field cannot be set when spec.os.name is windows.";
        type = types.bool;
        default = false;
      };
      "runAsGroup" = mkOption {
        description = "The GID to run the entrypoint of the container process.\nUses runtime default if unset.\nMay also be set in PodSecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.int);
        default = null;
      };
      "runAsNonRoot" = mkOption {
        description = "Indicates that the container must run as a non-root user.\nIf true, the Kubelet will validate the image at runtime to ensure that it\ndoes not run as UID 0 (root) and fail to start the container if it does.\nIf unset or false, no such validation will be performed.\nMay also be set in PodSecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.";
        type = types.bool;
        default = false;
      };
      "runAsUser" = mkOption {
        description = "The UID to run the entrypoint of the container process.\nDefaults to user specified in image metadata if unspecified.\nMay also be set in PodSecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.int);
        default = null;
      };
      "seLinuxOptions" = mkOption {
        description = "The SELinux context to be applied to the container.\nIf unspecified, the container runtime will allocate a random SELinux context for each\ncontainer.  May also be set in PodSecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr ContainerSecurityContextSeLinuxOptionsModule);
        default = null;
      };
      "seccompProfile" = mkOption {
        description = "The seccomp options to use by this container. If seccomp options are\nprovided at both the pod & container level, the container options\noverride the pod options.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr ContainerSecurityContextSeccompProfileModule);
        default = null;
      };
      "windowsOptions" = mkOption {
        description = "The Windows specific settings applied to all containers.\nIf unspecified, the options from the PodSecurityContext will be used.\nIf set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is linux.";
        type = (types.nullOr ContainerSecurityContextWindowsOptionsModule);
        default = null;
      };
    };
  };
  mkContainerSecurityContext =
    res:
    {
    }
    // optionalAttrs res."allowPrivilegeEscalation" { inherit (res) "allowPrivilegeEscalation"; }
    // {
    }
    // optionalAttrs (res."appArmorProfile" != null) {
      "appArmorProfile" = mkContainerSecurityContextAppArmorProfile res."appArmorProfile";
    }
    // {
    }
    // optionalAttrs (res."capabilities" != null) {
      "capabilities" = mkContainerSecurityContextCapabilities res."capabilities";
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
      "seLinuxOptions" = mkContainerSecurityContextSeLinuxOptions res."seLinuxOptions";
    }
    // {
    }
    // optionalAttrs (res."seccompProfile" != null) {
      "seccompProfile" = mkContainerSecurityContextSeccompProfile res."seccompProfile";
    }
    // {
    }
    // optionalAttrs (res."windowsOptions" != null) {
      "windowsOptions" = mkContainerSecurityContextWindowsOptions res."windowsOptions";
    }
    // {
    };
  ContainerSecurityContextSeLinuxOptionsModule = types.submodule {
    options = {
      "level" = mkOption {
        description = "Level is SELinux level label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
      "role" = mkOption {
        description = "Role is a SELinux role label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Type is a SELinux type label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
      "user" = mkOption {
        description = "User is a SELinux user label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkContainerSecurityContextSeLinuxOptions =
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
  ContainerSecurityContextSeccompProfileModule = types.submodule {
    options = {
      "localhostProfile" = mkOption {
        description = "localhostProfile indicates a profile defined in a file on the node should be used.\nThe profile must be preconfigured on the node to work.\nMust be a descending path, relative to the kubelet's configured seccomp profile location.\nMust be set if type is \"Localhost\". Must NOT be set for any other type.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "type indicates which kind of seccomp profile will be applied.\nValid options are:\n\nLocalhost - a profile defined in a file on the node should be used.\nRuntimeDefault - the container runtime default profile should be used.\nUnconfined - no profile should be applied.";
        type = types.str;
      };
    };
  };
  mkContainerSecurityContextSeccompProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  ContainerSecurityContextWindowsOptionsModule = types.submodule {
    options = {
      "gmsaCredentialSpec" = mkOption {
        description = "GMSACredentialSpec is where the GMSA admission webhook\n(https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the\nGMSA credential spec named by the GMSACredentialSpecName field.";
        type = (types.nullOr types.str);
        default = null;
      };
      "gmsaCredentialSpecName" = mkOption {
        description = "GMSACredentialSpecName is the name of the GMSA credential spec to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "hostProcess" = mkOption {
        description = "HostProcess determines if a container should be run as a 'Host Process' container.\nAll of a Pod's containers must have the same effective HostProcess value\n(it is not allowed to have a mix of HostProcess containers and non-HostProcess containers).\nIn addition, if HostProcess is true then HostNetwork must also be set to true.";
        type = types.bool;
        default = false;
      };
      "runAsUserName" = mkOption {
        description = "The UserName in Windows to run the entrypoint of the container process.\nDefaults to the user specified in image metadata if unspecified.\nMay also be set in PodSecurityContext. If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkContainerSecurityContextWindowsOptions =
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
  ContainerStartupProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkContainerStartupProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  ContainerStartupProbeGrpcModule = types.submodule {
    options = {
      "port" = mkOption {
        description = "Port number of the gRPC service. Number must be in the range 1 to 65535.";
        type = types.int;
      };
      "service" = mkOption {
        description = "Service is the name of the service to place in the gRPC HealthCheckRequest\n(see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).\n\nIf this is not specified, the default behavior is defined by gRPC.";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkContainerStartupProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  ContainerStartupProbeHttpGetHttpHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "The header field name.\nThis will be canonicalized upon output, so case-variant names will be understood as the same header.";
        type = types.str;
      };
      "value" = mkOption {
        description = "The header field value";
        type = types.str;
      };
    };
  };
  mkContainerStartupProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  ContainerStartupProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf ContainerStartupProbeHttpGetHttpHeaderModule);
        default = [ ];
      };
      "path" = mkOption {
        description = "Path to access on the HTTP server.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Name or number of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
      "scheme" = mkOption {
        description = "Scheme to use for connecting to the host.\nDefaults to HTTP.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkContainerStartupProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" = map mkContainerStartupProbeHttpGetHttpHeader res."httpHeaders";
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
  ContainerStartupProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr ContainerStartupProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        description = "Minimum consecutive failures for the probe to be considered failed after having succeeded.\nDefaults to 3. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        description = "GRPC specifies a GRPC HealthCheckRequest.";
        type = (types.nullOr ContainerStartupProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr ContainerStartupProbeHttpGetModule);
        default = null;
      };
      "initialDelaySeconds" = mkOption {
        description = "Number of seconds after the container has started before liveness probes are initiated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr types.int);
        default = null;
      };
      "periodSeconds" = mkOption {
        description = "How often (in seconds) to perform the probe.\nDefault to 10 seconds. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "successThreshold" = mkOption {
        description = "Minimum consecutive successes for the probe to be considered successful after having failed.\nDefaults to 1. Must be 1 for liveness and startup. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "tcpSocket" = mkOption {
        description = "TCPSocket specifies a connection to a TCP port.";
        type = (types.nullOr ContainerStartupProbeTcpSocketModule);
        default = null;
      };
      "terminationGracePeriodSeconds" = mkOption {
        description = "Optional duration in seconds the pod needs to terminate gracefully upon probe failure.\nThe grace period is the duration in seconds after the processes running in the pod are sent\na termination signal and the time when the processes are forcibly halted with a kill signal.\nSet this value longer than the expected cleanup time for your process.\nIf this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this\nvalue overrides the value provided by the pod spec.\nValue must be non-negative integer. The value zero indicates stop immediately via\nthe kill signal (no opportunity to shut down).\nThis is a beta field and requires enabling ProbeTerminationGracePeriod feature gate.\nMinimum value is 1. spec.terminationGracePeriodSeconds is used if unset.";
        type = (types.nullOr types.int);
        default = null;
      };
      "timeoutSeconds" = mkOption {
        description = "Number of seconds after which the probe times out.\nDefaults to 1 second. Minimum value is 1.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkContainerStartupProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) { "exec" = mkContainerStartupProbeExec res."exec"; }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) { "grpc" = mkContainerStartupProbeGrpc res."grpc"; }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkContainerStartupProbeHttpGet res."httpGet";
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
      "tcpSocket" = mkContainerStartupProbeTcpSocket res."tcpSocket";
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
  ContainerStartupProbeTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Optional: Host name to connect to, defaults to the pod IP.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Number or name of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
    };
  };
  mkContainerStartupProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  ContainerVolumeDeviceModule = types.submodule {
    options = {
      "devicePath" = mkOption {
        description = "devicePath is the path inside of the container that the device will be mapped to.";
        type = types.str;
      };
      "name" = mkOption {
        description = "name must match the name of a persistentVolumeClaim in the pod";
        type = types.str;
      };
    };
  };
  mkContainerVolumeDevice = res: {
    inherit (res) "devicePath";
    inherit (res) "name";
  };
  ContainerVolumeMountModule = types.submodule {
    options = {
      "mountPath" = mkOption {
        description = "Path within the container at which the volume should be mounted.  Must\nnot contain ':'.";
        type = types.str;
      };
      "mountPropagation" = mkOption {
        description = "mountPropagation determines how mounts are propagated from the host\nto container and the other way around.\nWhen not set, MountPropagationNone is used.\nThis field is beta in 1.10.\nWhen RecursiveReadOnly is set to IfPossible or to Enabled, MountPropagation must be None or unspecified\n(which defaults to None).";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "This must match the Name of a Volume.";
        type = types.str;
      };
      "readOnly" = mkOption {
        description = "Mounted read-only if true, read-write otherwise (false or unspecified).\nDefaults to false.";
        type = types.bool;
        default = false;
      };
      "recursiveReadOnly" = mkOption {
        description = "RecursiveReadOnly specifies whether read-only mounts should be handled\nrecursively.\n\nIf ReadOnly is false, this field has no meaning and must be unspecified.\n\nIf ReadOnly is true, and this field is set to Disabled, the mount is not made\nrecursively read-only.  If this field is set to IfPossible, the mount is made\nrecursively read-only, if it is supported by the container runtime.  If this\nfield is set to Enabled, the mount is made recursively read-only if it is\nsupported by the container runtime, otherwise the pod will not be started and\nan error will be generated to indicate the reason.\n\nIf this field is set to IfPossible or Enabled, MountPropagation must be set to\nNone (or be unspecified, which defaults to None).\n\nIf this field is not specified, it is treated as an equivalent of Disabled.";
        type = (types.nullOr types.str);
        default = null;
      };
      "subPath" = mkOption {
        description = "Path within the volume from which the container's volume should be mounted.\nDefaults to \"\" (volume's root).";
        type = (types.nullOr types.str);
        default = null;
      };
      "subPathExpr" = mkOption {
        description = "Expanded path within the volume from which the container's volume should be mounted.\nBehaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment.\nDefaults to \"\" (volume's root).\nSubPathExpr and SubPath are mutually exclusive.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkContainerVolumeMount =
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
  DnsConfigModule = types.submodule {
    options = {
      "nameservers" = mkOption {
        description = "A list of DNS name server IP addresses.\nThis will be appended to the base nameservers generated from DNSPolicy.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "options" = mkOption {
        description = "A list of DNS resolver options.\nThis will be merged with the base options generated from DNSPolicy.\nResolution options given in Options\nwill override those that appear in the base DNSPolicy.";
        type = (types.listOf DnsConfigOptionModule);
        default = [ ];
      };
      "searches" = mkOption {
        description = "A list of DNS search domains for host-name lookup.\nThis will be appended to the base search paths generated from DNSPolicy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkDnsConfig =
    res:
    {
    }
    // optionalAttrs (res."nameservers" != [ ]) { inherit (res) "nameservers"; }
    // {
    }
    // optionalAttrs (res."options" != [ ]) { "options" = map mkDnsConfigOption res."options"; }
    // {
    }
    // optionalAttrs (res."searches" != [ ]) { inherit (res) "searches"; }
    // {
    };
  DnsConfigOptionModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is required and must be unique.";
        type = types.str;
      };
      "value" = mkOption {
        description = "Value is optional.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDnsConfigOption =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  ExcludedFromEnforcementModule = types.submodule {
    options = {
      "group" = mkOption {
        description = "Group of the referent. When not specified, it defaults to `monitoring.coreos.com`";
        type = (types.nullOr (types.enum [ "monitoring.coreos.com" ]));
        default = "monitoring.coreos.com";
      };
      "name" = mkOption {
        description = "Name of the referent. When not set, all resources in the namespace are matched.";
        type = (types.nullOr types.str);
        default = null;
      };
      "namespace" = mkOption {
        description = "Namespace of the referent.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/";
        type = types.str;
      };
      "resource" = mkOption {
        description = "Resource of the referent.";
        type = (
          types.enum [
            "prometheusrules"
            "servicemonitors"
            "podmonitors"
            "probes"
            "scrapeconfigs"
          ]
        );
      };
    };
  };
  mkExcludedFromEnforcement =
    res:
    {
    }
    // optionalAttrs (res."group" != null) { inherit (res) "group"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
      inherit (res) "namespace";
      inherit (res) "resource";
    };
  HostAliaseModule = types.submodule {
    options = {
      "hostnames" = mkOption {
        description = "Hostnames for the above IP address.";
        type = (types.listOf types.str);
      };
      "ip" = mkOption {
        description = "IP address of the host file entry.";
        type = types.str;
      };
    };
  };
  mkHostAliase = res: {
    inherit (res) "hostnames";
    inherit (res) "ip";
  };
  ImagePullSecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkImagePullSecret =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  InitContainerEnvFromConfigMapRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "Specify whether the ConfigMap must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkInitContainerEnvFromConfigMapRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  InitContainerEnvFromModule = types.submodule {
    options = {
      "configMapRef" = mkOption {
        description = "The ConfigMap to select from";
        type = (types.nullOr InitContainerEnvFromConfigMapRefModule);
        default = null;
      };
      "prefix" = mkOption {
        description = "Optional text to prepend to the name of each environment variable. Must be a C_IDENTIFIER.";
        type = (types.nullOr types.str);
        default = null;
      };
      "secretRef" = mkOption {
        description = "The Secret to select from";
        type = (types.nullOr InitContainerEnvFromSecretRefModule);
        default = null;
      };
    };
  };
  mkInitContainerEnvFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapRef" != null) {
      "configMapRef" = mkInitContainerEnvFromConfigMapRef res."configMapRef";
    }
    // {
    }
    // optionalAttrs (res."prefix" != null) { inherit (res) "prefix"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkInitContainerEnvFromSecretRef res."secretRef";
    }
    // {
    };
  InitContainerEnvFromSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "Specify whether the Secret must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkInitContainerEnvFromSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  InitContainerEnvModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the environment variable. Must be a C_IDENTIFIER.";
        type = types.str;
      };
      "value" = mkOption {
        description = "Variable references $(VAR_NAME) are expanded\nusing the previously defined environment variables in the container and\nany service environment variables. If a variable cannot be resolved,\nthe reference in the input string will be unchanged. Double $$ are reduced\nto a single $, which allows for escaping the $(VAR_NAME) syntax: i.e.\n\"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\".\nEscaped references will never be expanded, regardless of whether the variable\nexists or not.\nDefaults to \"\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "valueFrom" = mkOption {
        description = "Source for the environment variable's value. Cannot be used if value is not empty.";
        type = (types.nullOr InitContainerEnvValueFromModule);
        default = null;
      };
    };
  };
  mkInitContainerEnv =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    }
    // optionalAttrs (res."valueFrom" != null) {
      "valueFrom" = mkInitContainerEnvValueFrom res."valueFrom";
    }
    // {
    };
  InitContainerEnvValueFromConfigMapKeyRefModule = types.submodule {
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
  mkInitContainerEnvValueFromConfigMapKeyRef =
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
  InitContainerEnvValueFromFieldRefModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        description = "Version of the schema the FieldPath is written in terms of, defaults to \"v1\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "fieldPath" = mkOption {
        description = "Path of the field to select in the specified API version.";
        type = types.str;
      };
    };
  };
  mkInitContainerEnvValueFromFieldRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "fieldPath";
    };
  InitContainerEnvValueFromModule = types.submodule {
    options = {
      "configMapKeyRef" = mkOption {
        description = "Selects a key of a ConfigMap.";
        type = (types.nullOr InitContainerEnvValueFromConfigMapKeyRefModule);
        default = null;
      };
      "fieldRef" = mkOption {
        description = "Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`,\nspec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs.";
        type = (types.nullOr InitContainerEnvValueFromFieldRefModule);
        default = null;
      };
      "resourceFieldRef" = mkOption {
        description = "Selects a resource of the container: only resources limits and requests\n(limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported.";
        type = (types.nullOr InitContainerEnvValueFromResourceFieldRefModule);
        default = null;
      };
      "secretKeyRef" = mkOption {
        description = "Selects a key of a secret in the pod's namespace";
        type = (types.nullOr InitContainerEnvValueFromSecretKeyRefModule);
        default = null;
      };
    };
  };
  mkInitContainerEnvValueFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapKeyRef" != null) {
      "configMapKeyRef" = mkInitContainerEnvValueFromConfigMapKeyRef res."configMapKeyRef";
    }
    // {
    }
    // optionalAttrs (res."fieldRef" != null) {
      "fieldRef" = mkInitContainerEnvValueFromFieldRef res."fieldRef";
    }
    // {
    }
    // optionalAttrs (res."resourceFieldRef" != null) {
      "resourceFieldRef" = mkInitContainerEnvValueFromResourceFieldRef res."resourceFieldRef";
    }
    // {
    }
    // optionalAttrs (res."secretKeyRef" != null) {
      "secretKeyRef" = mkInitContainerEnvValueFromSecretKeyRef res."secretKeyRef";
    }
    // {
    };
  InitContainerEnvValueFromResourceFieldRefModule = types.submodule {
    options = {
      "containerName" = mkOption {
        description = "Container name: required for volumes, optional for env vars";
        type = (types.nullOr types.str);
        default = null;
      };
      "divisor" = mkOption {
        description = "Specifies the output format of the exposed resources, defaults to \"1\"";
        type = types.anything;
        default = { };
      };
      "resource" = mkOption {
        description = "Required: resource to select";
        type = types.str;
      };
    };
  };
  mkInitContainerEnvValueFromResourceFieldRef =
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
  InitContainerEnvValueFromSecretKeyRefModule = types.submodule {
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
  mkInitContainerEnvValueFromSecretKeyRef =
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
  InitContainerLifecycleModule = types.submodule {
    options = {
      "postStart" = mkOption {
        description = "PostStart is called immediately after a container is created. If the handler fails,\nthe container is terminated and restarted according to its restart policy.\nOther management of the container blocks until the hook completes.\nMore info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks";
        type = (types.nullOr InitContainerLifecyclePostStartModule);
        default = null;
      };
      "preStop" = mkOption {
        description = "PreStop is called immediately before a container is terminated due to an\nAPI request or management event such as liveness/startup probe failure,\npreemption, resource contention, etc. The handler is not called if the\ncontainer crashes or exits. The Pod's termination grace period countdown begins before the\nPreStop hook is executed. Regardless of the outcome of the handler, the\ncontainer will eventually terminate within the Pod's termination grace\nperiod (unless delayed by finalizers). Other management of the container blocks until the hook completes\nor until the termination grace period is reached.\nMore info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks";
        type = (types.nullOr InitContainerLifecyclePreStopModule);
        default = null;
      };
      "stopSignal" = mkOption {
        description = "StopSignal defines which signal will be sent to a container when it is being stopped.\nIf not specified, the default is defined by the container runtime in use.\nStopSignal can only be set for Pods with a non-empty .spec.os.name";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkInitContainerLifecycle =
    res:
    {
    }
    // optionalAttrs (res."postStart" != null) {
      "postStart" = mkInitContainerLifecyclePostStart res."postStart";
    }
    // {
    }
    // optionalAttrs (res."preStop" != null) {
      "preStop" = mkInitContainerLifecyclePreStop res."preStop";
    }
    // {
    }
    // optionalAttrs (res."stopSignal" != null) { inherit (res) "stopSignal"; }
    // {
    };
  InitContainerLifecyclePostStartExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkInitContainerLifecyclePostStartExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  InitContainerLifecyclePostStartHttpGetHttpHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "The header field name.\nThis will be canonicalized upon output, so case-variant names will be understood as the same header.";
        type = types.str;
      };
      "value" = mkOption {
        description = "The header field value";
        type = types.str;
      };
    };
  };
  mkInitContainerLifecyclePostStartHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  InitContainerLifecyclePostStartHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf InitContainerLifecyclePostStartHttpGetHttpHeaderModule);
        default = [ ];
      };
      "path" = mkOption {
        description = "Path to access on the HTTP server.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Name or number of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
      "scheme" = mkOption {
        description = "Scheme to use for connecting to the host.\nDefaults to HTTP.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkInitContainerLifecyclePostStartHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" = map mkInitContainerLifecyclePostStartHttpGetHttpHeader res."httpHeaders";
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
  InitContainerLifecyclePostStartModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr InitContainerLifecyclePostStartExecModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr InitContainerLifecyclePostStartHttpGetModule);
        default = null;
      };
      "sleep" = mkOption {
        description = "Sleep represents a duration that the container should sleep.";
        type = (types.nullOr InitContainerLifecyclePostStartSleepModule);
        default = null;
      };
      "tcpSocket" = mkOption {
        description = "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept\nfor backward compatibility. There is no validation of this field and\nlifecycle hooks will fail at runtime when it is specified.";
        type = (types.nullOr InitContainerLifecyclePostStartTcpSocketModule);
        default = null;
      };
    };
  };
  mkInitContainerLifecyclePostStart =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) { "exec" = mkInitContainerLifecyclePostStartExec res."exec"; }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkInitContainerLifecyclePostStartHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."sleep" != null) {
      "sleep" = mkInitContainerLifecyclePostStartSleep res."sleep";
    }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" = mkInitContainerLifecyclePostStartTcpSocket res."tcpSocket";
    }
    // {
    };
  InitContainerLifecyclePostStartSleepModule = types.submodule {
    options = {
      "seconds" = mkOption {
        description = "Seconds is the number of seconds to sleep.";
        type = types.int;
      };
    };
  };
  mkInitContainerLifecyclePostStartSleep = res: {
    inherit (res) "seconds";
  };
  InitContainerLifecyclePostStartTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Optional: Host name to connect to, defaults to the pod IP.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Number or name of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
    };
  };
  mkInitContainerLifecyclePostStartTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  InitContainerLifecyclePreStopExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkInitContainerLifecyclePreStopExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  InitContainerLifecyclePreStopHttpGetHttpHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "The header field name.\nThis will be canonicalized upon output, so case-variant names will be understood as the same header.";
        type = types.str;
      };
      "value" = mkOption {
        description = "The header field value";
        type = types.str;
      };
    };
  };
  mkInitContainerLifecyclePreStopHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  InitContainerLifecyclePreStopHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf InitContainerLifecyclePreStopHttpGetHttpHeaderModule);
        default = [ ];
      };
      "path" = mkOption {
        description = "Path to access on the HTTP server.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Name or number of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
      "scheme" = mkOption {
        description = "Scheme to use for connecting to the host.\nDefaults to HTTP.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkInitContainerLifecyclePreStopHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" = map mkInitContainerLifecyclePreStopHttpGetHttpHeader res."httpHeaders";
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
  InitContainerLifecyclePreStopModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr InitContainerLifecyclePreStopExecModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr InitContainerLifecyclePreStopHttpGetModule);
        default = null;
      };
      "sleep" = mkOption {
        description = "Sleep represents a duration that the container should sleep.";
        type = (types.nullOr InitContainerLifecyclePreStopSleepModule);
        default = null;
      };
      "tcpSocket" = mkOption {
        description = "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept\nfor backward compatibility. There is no validation of this field and\nlifecycle hooks will fail at runtime when it is specified.";
        type = (types.nullOr InitContainerLifecyclePreStopTcpSocketModule);
        default = null;
      };
    };
  };
  mkInitContainerLifecyclePreStop =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) { "exec" = mkInitContainerLifecyclePreStopExec res."exec"; }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkInitContainerLifecyclePreStopHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."sleep" != null) {
      "sleep" = mkInitContainerLifecyclePreStopSleep res."sleep";
    }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" = mkInitContainerLifecyclePreStopTcpSocket res."tcpSocket";
    }
    // {
    };
  InitContainerLifecyclePreStopSleepModule = types.submodule {
    options = {
      "seconds" = mkOption {
        description = "Seconds is the number of seconds to sleep.";
        type = types.int;
      };
    };
  };
  mkInitContainerLifecyclePreStopSleep = res: {
    inherit (res) "seconds";
  };
  InitContainerLifecyclePreStopTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Optional: Host name to connect to, defaults to the pod IP.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Number or name of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
    };
  };
  mkInitContainerLifecyclePreStopTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  InitContainerLivenessProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkInitContainerLivenessProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  InitContainerLivenessProbeGrpcModule = types.submodule {
    options = {
      "port" = mkOption {
        description = "Port number of the gRPC service. Number must be in the range 1 to 65535.";
        type = types.int;
      };
      "service" = mkOption {
        description = "Service is the name of the service to place in the gRPC HealthCheckRequest\n(see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).\n\nIf this is not specified, the default behavior is defined by gRPC.";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkInitContainerLivenessProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  InitContainerLivenessProbeHttpGetHttpHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "The header field name.\nThis will be canonicalized upon output, so case-variant names will be understood as the same header.";
        type = types.str;
      };
      "value" = mkOption {
        description = "The header field value";
        type = types.str;
      };
    };
  };
  mkInitContainerLivenessProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  InitContainerLivenessProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf InitContainerLivenessProbeHttpGetHttpHeaderModule);
        default = [ ];
      };
      "path" = mkOption {
        description = "Path to access on the HTTP server.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Name or number of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
      "scheme" = mkOption {
        description = "Scheme to use for connecting to the host.\nDefaults to HTTP.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkInitContainerLivenessProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" = map mkInitContainerLivenessProbeHttpGetHttpHeader res."httpHeaders";
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
  InitContainerLivenessProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr InitContainerLivenessProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        description = "Minimum consecutive failures for the probe to be considered failed after having succeeded.\nDefaults to 3. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        description = "GRPC specifies a GRPC HealthCheckRequest.";
        type = (types.nullOr InitContainerLivenessProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr InitContainerLivenessProbeHttpGetModule);
        default = null;
      };
      "initialDelaySeconds" = mkOption {
        description = "Number of seconds after the container has started before liveness probes are initiated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr types.int);
        default = null;
      };
      "periodSeconds" = mkOption {
        description = "How often (in seconds) to perform the probe.\nDefault to 10 seconds. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "successThreshold" = mkOption {
        description = "Minimum consecutive successes for the probe to be considered successful after having failed.\nDefaults to 1. Must be 1 for liveness and startup. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "tcpSocket" = mkOption {
        description = "TCPSocket specifies a connection to a TCP port.";
        type = (types.nullOr InitContainerLivenessProbeTcpSocketModule);
        default = null;
      };
      "terminationGracePeriodSeconds" = mkOption {
        description = "Optional duration in seconds the pod needs to terminate gracefully upon probe failure.\nThe grace period is the duration in seconds after the processes running in the pod are sent\na termination signal and the time when the processes are forcibly halted with a kill signal.\nSet this value longer than the expected cleanup time for your process.\nIf this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this\nvalue overrides the value provided by the pod spec.\nValue must be non-negative integer. The value zero indicates stop immediately via\nthe kill signal (no opportunity to shut down).\nThis is a beta field and requires enabling ProbeTerminationGracePeriod feature gate.\nMinimum value is 1. spec.terminationGracePeriodSeconds is used if unset.";
        type = (types.nullOr types.int);
        default = null;
      };
      "timeoutSeconds" = mkOption {
        description = "Number of seconds after which the probe times out.\nDefaults to 1 second. Minimum value is 1.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkInitContainerLivenessProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) { "exec" = mkInitContainerLivenessProbeExec res."exec"; }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) { "grpc" = mkInitContainerLivenessProbeGrpc res."grpc"; }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkInitContainerLivenessProbeHttpGet res."httpGet";
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
      "tcpSocket" = mkInitContainerLivenessProbeTcpSocket res."tcpSocket";
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
  InitContainerLivenessProbeTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Optional: Host name to connect to, defaults to the pod IP.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Number or name of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
    };
  };
  mkInitContainerLivenessProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  InitContainerModule = types.submodule {
    options = {
      "args" = mkOption {
        description = "Arguments to the entrypoint.\nThe container image's CMD is used if this is not provided.\nVariable references $(VAR_NAME) are expanded using the container's environment. If a variable\ncannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced\nto a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will\nproduce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless\nof whether the variable exists or not. Cannot be updated.\nMore info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell";
        type = (types.listOf types.str);
        default = [ ];
      };
      "command" = mkOption {
        description = "Entrypoint array. Not executed within a shell.\nThe container image's ENTRYPOINT is used if this is not provided.\nVariable references $(VAR_NAME) are expanded using the container's environment. If a variable\ncannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced\nto a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will\nproduce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless\nof whether the variable exists or not. Cannot be updated.\nMore info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell";
        type = (types.listOf types.str);
        default = [ ];
      };
      "env" = mkOption {
        description = "List of environment variables to set in the container.\nCannot be updated.";
        type = (types.listOf InitContainerEnvModule);
        default = [ ];
      };
      "envFrom" = mkOption {
        description = "List of sources to populate environment variables in the container.\nThe keys defined within a source must be a C_IDENTIFIER. All invalid keys\nwill be reported as an event when the container is starting. When a key exists in multiple\nsources, the value associated with the last source will take precedence.\nValues defined by an Env with a duplicate key will take precedence.\nCannot be updated.";
        type = (types.listOf InitContainerEnvFromModule);
        default = [ ];
      };
      "image" = mkOption {
        description = "Container image name.\nMore info: https://kubernetes.io/docs/concepts/containers/images\nThis field is optional to allow higher level config management to default or override\ncontainer images in workload controllers like Deployments and StatefulSets.";
        type = (types.nullOr types.str);
        default = null;
      };
      "imagePullPolicy" = mkOption {
        description = "Image pull policy.\nOne of Always, Never, IfNotPresent.\nDefaults to Always if :latest tag is specified, or IfNotPresent otherwise.\nCannot be updated.\nMore info: https://kubernetes.io/docs/concepts/containers/images#updating-images";
        type = (types.nullOr types.str);
        default = null;
      };
      "lifecycle" = mkOption {
        description = "Actions that the management system should take in response to container lifecycle events.\nCannot be updated.";
        type = (types.nullOr InitContainerLifecycleModule);
        default = null;
      };
      "livenessProbe" = mkOption {
        description = "Periodic probe of container liveness.\nContainer will be restarted if the probe fails.\nCannot be updated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr InitContainerLivenessProbeModule);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the container specified as a DNS_LABEL.\nEach container in a pod must have a unique name (DNS_LABEL).\nCannot be updated.";
        type = types.str;
      };
      "ports" = mkOption {
        description = "List of ports to expose from the container. Not specifying a port here\nDOES NOT prevent that port from being exposed. Any port which is\nlistening on the default \"0.0.0.0\" address inside a container will be\naccessible from the network.\nModifying this array with strategic merge patch may corrupt the data.\nFor more information See https://github.com/kubernetes/kubernetes/issues/108255.\nCannot be updated.";
        type = (types.listOf InitContainerPortModule);
        default = [ ];
      };
      "readinessProbe" = mkOption {
        description = "Periodic probe of container service readiness.\nContainer will be removed from service endpoints if the probe fails.\nCannot be updated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr InitContainerReadinessProbeModule);
        default = null;
      };
      "resizePolicy" = mkOption {
        description = "Resources resize policy for the container.";
        type = (types.listOf InitContainerResizePolicyModule);
        default = [ ];
      };
      "resources" = mkOption {
        description = "Compute Resources required by this container.\nCannot be updated.\nMore info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.nullOr InitContainerResourcesModule);
        default = null;
      };
      "restartPolicy" = mkOption {
        description = "RestartPolicy defines the restart behavior of individual containers in a pod.\nThis field may only be set for init containers, and the only allowed value is \"Always\".\nFor non-init containers or when this field is not specified,\nthe restart behavior is defined by the Pod's restart policy and the container type.\nSetting the RestartPolicy as \"Always\" for the init container will have the following effect:\nthis init container will be continually restarted on\nexit until all regular containers have terminated. Once all regular\ncontainers have completed, all init containers with restartPolicy \"Always\"\nwill be shut down. This lifecycle differs from normal init containers and\nis often referred to as a \"sidecar\" container. Although this init\ncontainer still starts in the init container sequence, it does not wait\nfor the container to complete before proceeding to the next init\ncontainer. Instead, the next init container starts immediately after this\ninit container is started, or after any startupProbe has successfully\ncompleted.";
        type = (types.nullOr types.str);
        default = null;
      };
      "securityContext" = mkOption {
        description = "SecurityContext defines the security options the container should be run with.\nIf set, the fields of SecurityContext override the equivalent fields of PodSecurityContext.\nMore info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/";
        type = (types.nullOr InitContainerSecurityContextModule);
        default = null;
      };
      "startupProbe" = mkOption {
        description = "StartupProbe indicates that the Pod has successfully initialized.\nIf specified, no other probes are executed until this completes successfully.\nIf this probe fails, the Pod will be restarted, just as if the livenessProbe failed.\nThis can be used to provide different probe parameters at the beginning of a Pod's lifecycle,\nwhen it might take a long time to load data or warm a cache, than during steady-state operation.\nThis cannot be updated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr InitContainerStartupProbeModule);
        default = null;
      };
      "stdin" = mkOption {
        description = "Whether this container should allocate a buffer for stdin in the container runtime. If this\nis not set, reads from stdin in the container will always result in EOF.\nDefault is false.";
        type = types.bool;
        default = false;
      };
      "stdinOnce" = mkOption {
        description = "Whether the container runtime should close the stdin channel after it has been opened by\na single attach. When stdin is true the stdin stream will remain open across multiple attach\nsessions. If stdinOnce is set to true, stdin is opened on container start, is empty until the\nfirst client attaches to stdin, and then remains open and accepts data until the client disconnects,\nat which time stdin is closed and remains closed until the container is restarted. If this\nflag is false, a container processes that reads from stdin will never receive an EOF.\nDefault is false";
        type = types.bool;
        default = false;
      };
      "terminationMessagePath" = mkOption {
        description = "Optional: Path at which the file to which the container's termination message\nwill be written is mounted into the container's filesystem.\nMessage written is intended to be brief final status, such as an assertion failure message.\nWill be truncated by the node if greater than 4096 bytes. The total message length across\nall containers will be limited to 12kb.\nDefaults to /dev/termination-log.\nCannot be updated.";
        type = (types.nullOr types.str);
        default = null;
      };
      "terminationMessagePolicy" = mkOption {
        description = "Indicate how the termination message should be populated. File will use the contents of\nterminationMessagePath to populate the container status message on both success and failure.\nFallbackToLogsOnError will use the last chunk of container log output if the termination\nmessage file is empty and the container exited with an error.\nThe log output is limited to 2048 bytes or 80 lines, whichever is smaller.\nDefaults to File.\nCannot be updated.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tty" = mkOption {
        description = "Whether this container should allocate a TTY for itself, also requires 'stdin' to be true.\nDefault is false.";
        type = types.bool;
        default = false;
      };
      "volumeDevices" = mkOption {
        description = "volumeDevices is the list of block devices to be used by the container.";
        type = (types.listOf InitContainerVolumeDeviceModule);
        default = [ ];
      };
      "volumeMounts" = mkOption {
        description = "Pod volumes to mount into the container's filesystem.\nCannot be updated.";
        type = (types.listOf InitContainerVolumeMountModule);
        default = [ ];
      };
      "workingDir" = mkOption {
        description = "Container's working directory.\nIf not specified, the container runtime's default will be used, which\nmight be configured in the container image.\nCannot be updated.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkInitContainer =
    res:
    {
    }
    // optionalAttrs (res."args" != [ ]) { inherit (res) "args"; }
    // {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    }
    // optionalAttrs (res."env" != [ ]) { "env" = map mkInitContainerEnv res."env"; }
    // {
    }
    // optionalAttrs (res."envFrom" != [ ]) { "envFrom" = map mkInitContainerEnvFrom res."envFrom"; }
    // {
    }
    // optionalAttrs (res."image" != null) { inherit (res) "image"; }
    // {
    }
    // optionalAttrs (res."imagePullPolicy" != null) { inherit (res) "imagePullPolicy"; }
    // {
    }
    // optionalAttrs (res."lifecycle" != null) {
      "lifecycle" = mkInitContainerLifecycle res."lifecycle";
    }
    // {
    }
    // optionalAttrs (res."livenessProbe" != null) {
      "livenessProbe" = mkInitContainerLivenessProbe res."livenessProbe";
    }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."ports" != [ ]) { "ports" = map mkInitContainerPort res."ports"; }
    // {
    }
    // optionalAttrs (res."readinessProbe" != null) {
      "readinessProbe" = mkInitContainerReadinessProbe res."readinessProbe";
    }
    // {
    }
    // optionalAttrs (res."resizePolicy" != [ ]) {
      "resizePolicy" = map mkInitContainerResizePolicy res."resizePolicy";
    }
    // {
    }
    // optionalAttrs (res."resources" != null) {
      "resources" = mkInitContainerResources res."resources";
    }
    // {
    }
    // optionalAttrs (res."restartPolicy" != null) { inherit (res) "restartPolicy"; }
    // {
    }
    // optionalAttrs (res."securityContext" != null) {
      "securityContext" = mkInitContainerSecurityContext res."securityContext";
    }
    // {
    }
    // optionalAttrs (res."startupProbe" != null) {
      "startupProbe" = mkInitContainerStartupProbe res."startupProbe";
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
      "volumeDevices" = map mkInitContainerVolumeDevice res."volumeDevices";
    }
    // {
    }
    // optionalAttrs (res."volumeMounts" != [ ]) {
      "volumeMounts" = map mkInitContainerVolumeMount res."volumeMounts";
    }
    // {
    }
    // optionalAttrs (res."workingDir" != null) { inherit (res) "workingDir"; }
    // {
    };
  InitContainerPortModule = types.submodule {
    options = {
      "containerPort" = mkOption {
        description = "Number of port to expose on the pod's IP address.\nThis must be a valid port number, 0 < x < 65536.";
        type = types.int;
      };
      "hostIP" = mkOption {
        description = "What host IP to bind the external port to.";
        type = (types.nullOr types.str);
        default = null;
      };
      "hostPort" = mkOption {
        description = "Number of port to expose on the host.\nIf specified, this must be a valid port number, 0 < x < 65536.\nIf HostNetwork is specified, this must match ContainerPort.\nMost containers do not need this.";
        type = (types.nullOr types.int);
        default = null;
      };
      "name" = mkOption {
        description = "If specified, this must be an IANA_SVC_NAME and unique within the pod. Each\nnamed port in a pod must have a unique name. Name for the port that can be\nreferred to by services.";
        type = (types.nullOr types.str);
        default = null;
      };
      "protocol" = mkOption {
        description = "Protocol for port. Must be UDP, TCP, or SCTP.\nDefaults to \"TCP\".";
        type = (types.nullOr types.str);
        default = "TCP";
      };
    };
  };
  mkInitContainerPort =
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
  InitContainerReadinessProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkInitContainerReadinessProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  InitContainerReadinessProbeGrpcModule = types.submodule {
    options = {
      "port" = mkOption {
        description = "Port number of the gRPC service. Number must be in the range 1 to 65535.";
        type = types.int;
      };
      "service" = mkOption {
        description = "Service is the name of the service to place in the gRPC HealthCheckRequest\n(see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).\n\nIf this is not specified, the default behavior is defined by gRPC.";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkInitContainerReadinessProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  InitContainerReadinessProbeHttpGetHttpHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "The header field name.\nThis will be canonicalized upon output, so case-variant names will be understood as the same header.";
        type = types.str;
      };
      "value" = mkOption {
        description = "The header field value";
        type = types.str;
      };
    };
  };
  mkInitContainerReadinessProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  InitContainerReadinessProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf InitContainerReadinessProbeHttpGetHttpHeaderModule);
        default = [ ];
      };
      "path" = mkOption {
        description = "Path to access on the HTTP server.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Name or number of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
      "scheme" = mkOption {
        description = "Scheme to use for connecting to the host.\nDefaults to HTTP.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkInitContainerReadinessProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" = map mkInitContainerReadinessProbeHttpGetHttpHeader res."httpHeaders";
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
  InitContainerReadinessProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr InitContainerReadinessProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        description = "Minimum consecutive failures for the probe to be considered failed after having succeeded.\nDefaults to 3. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        description = "GRPC specifies a GRPC HealthCheckRequest.";
        type = (types.nullOr InitContainerReadinessProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr InitContainerReadinessProbeHttpGetModule);
        default = null;
      };
      "initialDelaySeconds" = mkOption {
        description = "Number of seconds after the container has started before liveness probes are initiated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr types.int);
        default = null;
      };
      "periodSeconds" = mkOption {
        description = "How often (in seconds) to perform the probe.\nDefault to 10 seconds. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "successThreshold" = mkOption {
        description = "Minimum consecutive successes for the probe to be considered successful after having failed.\nDefaults to 1. Must be 1 for liveness and startup. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "tcpSocket" = mkOption {
        description = "TCPSocket specifies a connection to a TCP port.";
        type = (types.nullOr InitContainerReadinessProbeTcpSocketModule);
        default = null;
      };
      "terminationGracePeriodSeconds" = mkOption {
        description = "Optional duration in seconds the pod needs to terminate gracefully upon probe failure.\nThe grace period is the duration in seconds after the processes running in the pod are sent\na termination signal and the time when the processes are forcibly halted with a kill signal.\nSet this value longer than the expected cleanup time for your process.\nIf this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this\nvalue overrides the value provided by the pod spec.\nValue must be non-negative integer. The value zero indicates stop immediately via\nthe kill signal (no opportunity to shut down).\nThis is a beta field and requires enabling ProbeTerminationGracePeriod feature gate.\nMinimum value is 1. spec.terminationGracePeriodSeconds is used if unset.";
        type = (types.nullOr types.int);
        default = null;
      };
      "timeoutSeconds" = mkOption {
        description = "Number of seconds after which the probe times out.\nDefaults to 1 second. Minimum value is 1.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkInitContainerReadinessProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) { "exec" = mkInitContainerReadinessProbeExec res."exec"; }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) { "grpc" = mkInitContainerReadinessProbeGrpc res."grpc"; }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkInitContainerReadinessProbeHttpGet res."httpGet";
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
      "tcpSocket" = mkInitContainerReadinessProbeTcpSocket res."tcpSocket";
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
  InitContainerReadinessProbeTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Optional: Host name to connect to, defaults to the pod IP.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Number or name of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
    };
  };
  mkInitContainerReadinessProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  InitContainerResizePolicyModule = types.submodule {
    options = {
      "resourceName" = mkOption {
        description = "Name of the resource to which this resource resize policy applies.\nSupported values: cpu, memory.";
        type = types.str;
      };
      "restartPolicy" = mkOption {
        description = "Restart policy to apply when specified resource is resized.\nIf not specified, it defaults to NotRequired.";
        type = types.str;
      };
    };
  };
  mkInitContainerResizePolicy = res: {
    inherit (res) "resourceName";
    inherit (res) "restartPolicy";
  };
  InitContainerResourcesClaimModule = types.submodule {
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
  mkInitContainerResourcesClaim =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."request" != null) { inherit (res) "request"; }
    // {
    };
  InitContainerResourcesModule = types.submodule {
    options = {
      "claims" = mkOption {
        description = "Claims lists the names of resources, defined in spec.resourceClaims,\nthat are used by this container.\n\nThis is an alpha field and requires enabling the\nDynamicResourceAllocation feature gate.\n\nThis field is immutable. It can only be set for containers.";
        type = (types.listOf InitContainerResourcesClaimModule);
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
  mkInitContainerResources =
    res:
    {
    }
    // optionalAttrs (res."claims" != [ ]) {
      "claims" = map mkInitContainerResourcesClaim res."claims";
    }
    // {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  InitContainerSecurityContextAppArmorProfileModule = types.submodule {
    options = {
      "localhostProfile" = mkOption {
        description = "localhostProfile indicates a profile loaded on the node that should be used.\nThe profile must be preconfigured on the node to work.\nMust match the loaded name of the profile.\nMust be set if and only if type is \"Localhost\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "type indicates which kind of AppArmor profile will be applied.\nValid options are:\n  Localhost - a profile pre-loaded on the node.\n  RuntimeDefault - the container runtime's default profile.\n  Unconfined - no AppArmor enforcement.";
        type = types.str;
      };
    };
  };
  mkInitContainerSecurityContextAppArmorProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  InitContainerSecurityContextCapabilitiesModule = types.submodule {
    options = {
      "add" = mkOption {
        description = "Added capabilities";
        type = (types.listOf types.str);
        default = [ ];
      };
      "drop" = mkOption {
        description = "Removed capabilities";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkInitContainerSecurityContextCapabilities =
    res:
    {
    }
    // optionalAttrs (res."add" != [ ]) { inherit (res) "add"; }
    // {
    }
    // optionalAttrs (res."drop" != [ ]) { inherit (res) "drop"; }
    // {
    };
  InitContainerSecurityContextModule = types.submodule {
    options = {
      "allowPrivilegeEscalation" = mkOption {
        description = "AllowPrivilegeEscalation controls whether a process can gain more\nprivileges than its parent process. This bool directly controls if\nthe no_new_privs flag will be set on the container process.\nAllowPrivilegeEscalation is true always when the container is:\n1) run as Privileged\n2) has CAP_SYS_ADMIN\nNote that this field cannot be set when spec.os.name is windows.";
        type = types.bool;
        default = false;
      };
      "appArmorProfile" = mkOption {
        description = "appArmorProfile is the AppArmor options to use by this container. If set, this profile\noverrides the pod's appArmorProfile.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr InitContainerSecurityContextAppArmorProfileModule);
        default = null;
      };
      "capabilities" = mkOption {
        description = "The capabilities to add/drop when running containers.\nDefaults to the default set of capabilities granted by the container runtime.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr InitContainerSecurityContextCapabilitiesModule);
        default = null;
      };
      "privileged" = mkOption {
        description = "Run container in privileged mode.\nProcesses in privileged containers are essentially equivalent to root on the host.\nDefaults to false.\nNote that this field cannot be set when spec.os.name is windows.";
        type = types.bool;
        default = false;
      };
      "procMount" = mkOption {
        description = "procMount denotes the type of proc mount to use for the containers.\nThe default value is Default which uses the container runtime defaults for\nreadonly paths and masked paths.\nThis requires the ProcMountType feature flag to be enabled.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnlyRootFilesystem" = mkOption {
        description = "Whether this container has a read-only root filesystem.\nDefault is false.\nNote that this field cannot be set when spec.os.name is windows.";
        type = types.bool;
        default = false;
      };
      "runAsGroup" = mkOption {
        description = "The GID to run the entrypoint of the container process.\nUses runtime default if unset.\nMay also be set in PodSecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.int);
        default = null;
      };
      "runAsNonRoot" = mkOption {
        description = "Indicates that the container must run as a non-root user.\nIf true, the Kubelet will validate the image at runtime to ensure that it\ndoes not run as UID 0 (root) and fail to start the container if it does.\nIf unset or false, no such validation will be performed.\nMay also be set in PodSecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.";
        type = types.bool;
        default = false;
      };
      "runAsUser" = mkOption {
        description = "The UID to run the entrypoint of the container process.\nDefaults to user specified in image metadata if unspecified.\nMay also be set in PodSecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.int);
        default = null;
      };
      "seLinuxOptions" = mkOption {
        description = "The SELinux context to be applied to the container.\nIf unspecified, the container runtime will allocate a random SELinux context for each\ncontainer.  May also be set in PodSecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr InitContainerSecurityContextSeLinuxOptionsModule);
        default = null;
      };
      "seccompProfile" = mkOption {
        description = "The seccomp options to use by this container. If seccomp options are\nprovided at both the pod & container level, the container options\noverride the pod options.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr InitContainerSecurityContextSeccompProfileModule);
        default = null;
      };
      "windowsOptions" = mkOption {
        description = "The Windows specific settings applied to all containers.\nIf unspecified, the options from the PodSecurityContext will be used.\nIf set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is linux.";
        type = (types.nullOr InitContainerSecurityContextWindowsOptionsModule);
        default = null;
      };
    };
  };
  mkInitContainerSecurityContext =
    res:
    {
    }
    // optionalAttrs res."allowPrivilegeEscalation" { inherit (res) "allowPrivilegeEscalation"; }
    // {
    }
    // optionalAttrs (res."appArmorProfile" != null) {
      "appArmorProfile" = mkInitContainerSecurityContextAppArmorProfile res."appArmorProfile";
    }
    // {
    }
    // optionalAttrs (res."capabilities" != null) {
      "capabilities" = mkInitContainerSecurityContextCapabilities res."capabilities";
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
      "seLinuxOptions" = mkInitContainerSecurityContextSeLinuxOptions res."seLinuxOptions";
    }
    // {
    }
    // optionalAttrs (res."seccompProfile" != null) {
      "seccompProfile" = mkInitContainerSecurityContextSeccompProfile res."seccompProfile";
    }
    // {
    }
    // optionalAttrs (res."windowsOptions" != null) {
      "windowsOptions" = mkInitContainerSecurityContextWindowsOptions res."windowsOptions";
    }
    // {
    };
  InitContainerSecurityContextSeLinuxOptionsModule = types.submodule {
    options = {
      "level" = mkOption {
        description = "Level is SELinux level label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
      "role" = mkOption {
        description = "Role is a SELinux role label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Type is a SELinux type label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
      "user" = mkOption {
        description = "User is a SELinux user label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkInitContainerSecurityContextSeLinuxOptions =
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
  InitContainerSecurityContextSeccompProfileModule = types.submodule {
    options = {
      "localhostProfile" = mkOption {
        description = "localhostProfile indicates a profile defined in a file on the node should be used.\nThe profile must be preconfigured on the node to work.\nMust be a descending path, relative to the kubelet's configured seccomp profile location.\nMust be set if type is \"Localhost\". Must NOT be set for any other type.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "type indicates which kind of seccomp profile will be applied.\nValid options are:\n\nLocalhost - a profile defined in a file on the node should be used.\nRuntimeDefault - the container runtime default profile should be used.\nUnconfined - no profile should be applied.";
        type = types.str;
      };
    };
  };
  mkInitContainerSecurityContextSeccompProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  InitContainerSecurityContextWindowsOptionsModule = types.submodule {
    options = {
      "gmsaCredentialSpec" = mkOption {
        description = "GMSACredentialSpec is where the GMSA admission webhook\n(https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the\nGMSA credential spec named by the GMSACredentialSpecName field.";
        type = (types.nullOr types.str);
        default = null;
      };
      "gmsaCredentialSpecName" = mkOption {
        description = "GMSACredentialSpecName is the name of the GMSA credential spec to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "hostProcess" = mkOption {
        description = "HostProcess determines if a container should be run as a 'Host Process' container.\nAll of a Pod's containers must have the same effective HostProcess value\n(it is not allowed to have a mix of HostProcess containers and non-HostProcess containers).\nIn addition, if HostProcess is true then HostNetwork must also be set to true.";
        type = types.bool;
        default = false;
      };
      "runAsUserName" = mkOption {
        description = "The UserName in Windows to run the entrypoint of the container process.\nDefaults to the user specified in image metadata if unspecified.\nMay also be set in PodSecurityContext. If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkInitContainerSecurityContextWindowsOptions =
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
  InitContainerStartupProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkInitContainerStartupProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  InitContainerStartupProbeGrpcModule = types.submodule {
    options = {
      "port" = mkOption {
        description = "Port number of the gRPC service. Number must be in the range 1 to 65535.";
        type = types.int;
      };
      "service" = mkOption {
        description = "Service is the name of the service to place in the gRPC HealthCheckRequest\n(see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).\n\nIf this is not specified, the default behavior is defined by gRPC.";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkInitContainerStartupProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  InitContainerStartupProbeHttpGetHttpHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "The header field name.\nThis will be canonicalized upon output, so case-variant names will be understood as the same header.";
        type = types.str;
      };
      "value" = mkOption {
        description = "The header field value";
        type = types.str;
      };
    };
  };
  mkInitContainerStartupProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  InitContainerStartupProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf InitContainerStartupProbeHttpGetHttpHeaderModule);
        default = [ ];
      };
      "path" = mkOption {
        description = "Path to access on the HTTP server.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Name or number of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
      "scheme" = mkOption {
        description = "Scheme to use for connecting to the host.\nDefaults to HTTP.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkInitContainerStartupProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" = map mkInitContainerStartupProbeHttpGetHttpHeader res."httpHeaders";
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
  InitContainerStartupProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr InitContainerStartupProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        description = "Minimum consecutive failures for the probe to be considered failed after having succeeded.\nDefaults to 3. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        description = "GRPC specifies a GRPC HealthCheckRequest.";
        type = (types.nullOr InitContainerStartupProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr InitContainerStartupProbeHttpGetModule);
        default = null;
      };
      "initialDelaySeconds" = mkOption {
        description = "Number of seconds after the container has started before liveness probes are initiated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr types.int);
        default = null;
      };
      "periodSeconds" = mkOption {
        description = "How often (in seconds) to perform the probe.\nDefault to 10 seconds. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "successThreshold" = mkOption {
        description = "Minimum consecutive successes for the probe to be considered successful after having failed.\nDefaults to 1. Must be 1 for liveness and startup. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "tcpSocket" = mkOption {
        description = "TCPSocket specifies a connection to a TCP port.";
        type = (types.nullOr InitContainerStartupProbeTcpSocketModule);
        default = null;
      };
      "terminationGracePeriodSeconds" = mkOption {
        description = "Optional duration in seconds the pod needs to terminate gracefully upon probe failure.\nThe grace period is the duration in seconds after the processes running in the pod are sent\na termination signal and the time when the processes are forcibly halted with a kill signal.\nSet this value longer than the expected cleanup time for your process.\nIf this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this\nvalue overrides the value provided by the pod spec.\nValue must be non-negative integer. The value zero indicates stop immediately via\nthe kill signal (no opportunity to shut down).\nThis is a beta field and requires enabling ProbeTerminationGracePeriod feature gate.\nMinimum value is 1. spec.terminationGracePeriodSeconds is used if unset.";
        type = (types.nullOr types.int);
        default = null;
      };
      "timeoutSeconds" = mkOption {
        description = "Number of seconds after which the probe times out.\nDefaults to 1 second. Minimum value is 1.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkInitContainerStartupProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) { "exec" = mkInitContainerStartupProbeExec res."exec"; }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) { "grpc" = mkInitContainerStartupProbeGrpc res."grpc"; }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkInitContainerStartupProbeHttpGet res."httpGet";
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
      "tcpSocket" = mkInitContainerStartupProbeTcpSocket res."tcpSocket";
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
  InitContainerStartupProbeTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Optional: Host name to connect to, defaults to the pod IP.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Number or name of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
    };
  };
  mkInitContainerStartupProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  InitContainerVolumeDeviceModule = types.submodule {
    options = {
      "devicePath" = mkOption {
        description = "devicePath is the path inside of the container that the device will be mapped to.";
        type = types.str;
      };
      "name" = mkOption {
        description = "name must match the name of a persistentVolumeClaim in the pod";
        type = types.str;
      };
    };
  };
  mkInitContainerVolumeDevice = res: {
    inherit (res) "devicePath";
    inherit (res) "name";
  };
  InitContainerVolumeMountModule = types.submodule {
    options = {
      "mountPath" = mkOption {
        description = "Path within the container at which the volume should be mounted.  Must\nnot contain ':'.";
        type = types.str;
      };
      "mountPropagation" = mkOption {
        description = "mountPropagation determines how mounts are propagated from the host\nto container and the other way around.\nWhen not set, MountPropagationNone is used.\nThis field is beta in 1.10.\nWhen RecursiveReadOnly is set to IfPossible or to Enabled, MountPropagation must be None or unspecified\n(which defaults to None).";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "This must match the Name of a Volume.";
        type = types.str;
      };
      "readOnly" = mkOption {
        description = "Mounted read-only if true, read-write otherwise (false or unspecified).\nDefaults to false.";
        type = types.bool;
        default = false;
      };
      "recursiveReadOnly" = mkOption {
        description = "RecursiveReadOnly specifies whether read-only mounts should be handled\nrecursively.\n\nIf ReadOnly is false, this field has no meaning and must be unspecified.\n\nIf ReadOnly is true, and this field is set to Disabled, the mount is not made\nrecursively read-only.  If this field is set to IfPossible, the mount is made\nrecursively read-only, if it is supported by the container runtime.  If this\nfield is set to Enabled, the mount is made recursively read-only if it is\nsupported by the container runtime, otherwise the pod will not be started and\nan error will be generated to indicate the reason.\n\nIf this field is set to IfPossible or Enabled, MountPropagation must be set to\nNone (or be unspecified, which defaults to None).\n\nIf this field is not specified, it is treated as an equivalent of Disabled.";
        type = (types.nullOr types.str);
        default = null;
      };
      "subPath" = mkOption {
        description = "Path within the volume from which the container's volume should be mounted.\nDefaults to \"\" (volume's root).";
        type = (types.nullOr types.str);
        default = null;
      };
      "subPathExpr" = mkOption {
        description = "Expanded path within the volume from which the container's volume should be mounted.\nBehaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment.\nDefaults to \"\" (volume's root).\nSubPathExpr and SubPath are mutually exclusive.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkInitContainerVolumeMount =
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
  OtlpModule = types.submodule {
    options = {
      "convertHistogramsToNHCB" = mkOption {
        description = "Configures optional translation of OTLP explicit bucket histograms into native histograms with custom buckets.\nIt requires Prometheus >= v3.4.0.";
        type = types.bool;
        default = false;
      };
      "ignoreResourceAttributes" = mkOption {
        description = "List of OpenTelemetry resource attributes to ignore when `promoteAllResourceAttributes` is true.\n\nIt requires `promoteAllResourceAttributes` to be true.\nIt requires Prometheus >= v3.5.0.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "keepIdentifyingResourceAttributes" = mkOption {
        description = "Enables adding `service.name`, `service.namespace` and `service.instance.id`\nresource attributes to the `target_info` metric, on top of converting them into the `instance` and `job` labels.\n\nIt requires Prometheus >= v3.1.0.";
        type = types.bool;
        default = false;
      };
      "promoteAllResourceAttributes" = mkOption {
        description = "Promote all resource attributes to metric labels except the ones defined in `ignoreResourceAttributes`.\n\nCannot be true when `promoteResourceAttributes` is defined.\nIt requires Prometheus >= v3.5.0.";
        type = types.bool;
        default = false;
      };
      "promoteResourceAttributes" = mkOption {
        description = "List of OpenTelemetry Attributes that should be promoted to metric labels, defaults to none.\nCannot be defined when `promoteAllResourceAttributes` is true.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "translationStrategy" = mkOption {
        description = "Configures how the OTLP receiver endpoint translates the incoming metrics.\n\nIt requires Prometheus >= v3.0.0.";
        type = (
          types.nullOr (
            types.enum [
              "NoUTF8EscapingWithSuffixes"
              "UnderscoreEscapingWithSuffixes"
              "NoTranslation"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkOtlp =
    res:
    {
    }
    // optionalAttrs res."convertHistogramsToNHCB" { inherit (res) "convertHistogramsToNHCB"; }
    // {
    }
    // optionalAttrs (res."ignoreResourceAttributes" != [ ]) {
      inherit (res) "ignoreResourceAttributes";
    }
    // {
    }
    // optionalAttrs res."keepIdentifyingResourceAttributes" {
      inherit (res) "keepIdentifyingResourceAttributes";
    }
    // {
    }
    // optionalAttrs res."promoteAllResourceAttributes" {
      inherit (res) "promoteAllResourceAttributes";
    }
    // {
    }
    // optionalAttrs (res."promoteResourceAttributes" != [ ]) {
      inherit (res) "promoteResourceAttributes";
    }
    // {
    }
    // optionalAttrs (res."translationStrategy" != null) { inherit (res) "translationStrategy"; }
    // {
    };
  PersistentVolumeClaimRetentionPolicyModule = types.submodule {
    options = {
      "whenDeleted" = mkOption {
        description = "WhenDeleted specifies what happens to PVCs created from StatefulSet\nVolumeClaimTemplates when the StatefulSet is deleted. The default policy\nof `Retain` causes PVCs to not be affected by StatefulSet deletion. The\n`Delete` policy causes those PVCs to be deleted.";
        type = (types.nullOr types.str);
        default = null;
      };
      "whenScaled" = mkOption {
        description = "WhenScaled specifies what happens to PVCs created from StatefulSet\nVolumeClaimTemplates when the StatefulSet is scaled down. The default\npolicy of `Retain` causes PVCs to not be affected by a scaledown. The\n`Delete` policy causes the associated PVCs for any excess pods above\nthe replica count to be deleted.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkPersistentVolumeClaimRetentionPolicy =
    res:
    {
    }
    // optionalAttrs (res."whenDeleted" != null) { inherit (res) "whenDeleted"; }
    // {
    }
    // optionalAttrs (res."whenScaled" != null) { inherit (res) "whenScaled"; }
    // {
    };
  PodMetadataModule = types.submodule {
    options = {
      "annotations" = mkOption {
        description = "Annotations is an unstructured key value map stored with a resource that may be\nset by external tools to store and retrieve arbitrary metadata. They are not\nqueryable and should be preserved when modifying objects.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/";
        type = (types.attrsOf types.str);
        default = { };
      };
      "labels" = mkOption {
        description = "Map of string keys and values that can be used to organize and categorize\n(scope and select) objects. May match selectors of replication controllers\nand services.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/";
        type = (types.attrsOf types.str);
        default = { };
      };
      "name" = mkOption {
        description = "Name must be unique within a namespace. Is required when creating resources, although\nsome resources may allow a client to request the generation of an appropriate name\nautomatically. Name is primarily intended for creation idempotence and configuration\ndefinition.\nCannot be updated.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkPodMetadata =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  PodMonitorNamespaceSelectorMatchExpressionModule = types.submodule {
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
  mkPodMonitorNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  PodMonitorNamespaceSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf PodMonitorNamespaceSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkPodMonitorNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkPodMonitorNamespaceSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  PodMonitorSelectorMatchExpressionModule = types.submodule {
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
  mkPodMonitorSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  PodMonitorSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf PodMonitorSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkPodMonitorSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkPodMonitorSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProbeNamespaceSelectorMatchExpressionModule = types.submodule {
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
  mkProbeNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProbeNamespaceSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf ProbeNamespaceSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkProbeNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkProbeNamespaceSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProbeSelectorMatchExpressionModule = types.submodule {
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
  mkProbeSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProbeSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf ProbeSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkProbeSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkProbeSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  RemoteWriteAuthorizationCredentialsModule = types.submodule {
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
  mkRemoteWriteAuthorizationCredentials =
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
  RemoteWriteAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr RemoteWriteAuthorizationCredentialsModule);
        default = null;
      };
      "credentialsFile" = mkOption {
        description = "File to read a secret from, mutually exclusive with `credentials`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkRemoteWriteAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkRemoteWriteAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."credentialsFile" != null) { inherit (res) "credentialsFile"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  RemoteWriteAzureAdManagedIdentityModule = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "The client id";
        type = types.str;
      };
    };
  };
  mkRemoteWriteAzureAdManagedIdentity = res: {
    inherit (res) "clientId";
  };
  RemoteWriteAzureAdModule = types.submodule {
    options = {
      "cloud" = mkOption {
        description = "The Azure Cloud. Options are 'AzurePublic', 'AzureChina', or 'AzureGovernment'.";
        type = (
          types.nullOr (
            types.enum [
              "AzureChina"
              "AzureGovernment"
              "AzurePublic"
            ]
          )
        );
        default = null;
      };
      "managedIdentity" = mkOption {
        description = "ManagedIdentity defines the Azure User-assigned Managed identity.\nCannot be set at the same time as `oauth` or `sdk`.";
        type = (types.nullOr RemoteWriteAzureAdManagedIdentityModule);
        default = null;
      };
      "oauth" = mkOption {
        description = "OAuth defines the oauth config that is being used to authenticate.\nCannot be set at the same time as `managedIdentity` or `sdk`.\n\nIt requires Prometheus >= v2.48.0 or Thanos >= v0.31.0.";
        type = (types.nullOr RemoteWriteAzureAdOauthModule);
        default = null;
      };
      "sdk" = mkOption {
        description = "SDK defines the Azure SDK config that is being used to authenticate.\nSee https://learn.microsoft.com/en-us/azure/developer/go/azure-sdk-authentication\nCannot be set at the same time as `oauth` or `managedIdentity`.\n\nIt requires Prometheus >= v2.52.0 or Thanos >= v0.36.0.";
        type = (types.nullOr RemoteWriteAzureAdSdkModule);
        default = null;
      };
    };
  };
  mkRemoteWriteAzureAd =
    res:
    {
    }
    // optionalAttrs (res."cloud" != null) { inherit (res) "cloud"; }
    // {
    }
    // optionalAttrs (res."managedIdentity" != null) {
      "managedIdentity" = mkRemoteWriteAzureAdManagedIdentity res."managedIdentity";
    }
    // {
    }
    // optionalAttrs (res."oauth" != null) { "oauth" = mkRemoteWriteAzureAdOauth res."oauth"; }
    // {
    }
    // optionalAttrs (res."sdk" != null) { "sdk" = mkRemoteWriteAzureAdSdk res."sdk"; }
    // {
    };
  RemoteWriteAzureAdOauthClientSecretModule = types.submodule {
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
  mkRemoteWriteAzureAdOauthClientSecret =
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
  RemoteWriteAzureAdOauthModule = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientID` is the clientId of the Azure Active Directory application that is being used to authenticate.";
        type = types.str;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the client secret of the Azure Active Directory application that is being used to authenticate.";
        type = RemoteWriteAzureAdOauthClientSecretModule;
      };
      "tenantId" = mkOption {
        description = "`tenantId` is the tenant ID of the Azure Active Directory application that is being used to authenticate.";
        type = types.str;
      };
    };
  };
  mkRemoteWriteAzureAdOauth = res: {
    inherit (res) "clientId";
    "clientSecret" = mkRemoteWriteAzureAdOauthClientSecret res."clientSecret";
    inherit (res) "tenantId";
  };
  RemoteWriteAzureAdSdkModule = types.submodule {
    options = {
      "tenantId" = mkOption {
        description = "`tenantId` is the tenant ID of the azure active directory application that is being used to authenticate.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkRemoteWriteAzureAdSdk =
    res:
    {
    }
    // optionalAttrs (res."tenantId" != null) { inherit (res) "tenantId"; }
    // {
    };
  RemoteWriteBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr RemoteWriteBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr RemoteWriteBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkRemoteWriteBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkRemoteWriteBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkRemoteWriteBasicAuthUsername res."username";
    }
    // {
    };
  RemoteWriteBasicAuthPasswordModule = types.submodule {
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
  mkRemoteWriteBasicAuthPassword =
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
  RemoteWriteBasicAuthUsernameModule = types.submodule {
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
  mkRemoteWriteBasicAuthUsername =
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
  RemoteWriteMetadataConfigModule = types.submodule {
    options = {
      "maxSamplesPerSend" = mkOption {
        description = "MaxSamplesPerSend is the maximum number of metadata samples per send.\n\nIt requires Prometheus >= v2.29.0.";
        type = (types.nullOr types.int);
        default = null;
      };
      "send" = mkOption {
        description = "Defines whether metric metadata is sent to the remote storage or not.";
        type = types.bool;
        default = false;
      };
      "sendInterval" = mkOption {
        description = "Defines how frequently metric metadata is sent to the remote storage.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkRemoteWriteMetadataConfig =
    res:
    {
    }
    // optionalAttrs (res."maxSamplesPerSend" != null) { inherit (res) "maxSamplesPerSend"; }
    // {
    }
    // optionalAttrs res."send" { inherit (res) "send"; }
    // {
    }
    // optionalAttrs (res."sendInterval" != null) { inherit (res) "sendInterval"; }
    // {
    };
  RemoteWriteModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization section for the URL.\n\nIt requires Prometheus >= v2.26.0 or Thanos >= v0.24.0.\n\nCannot be set at the same time as `sigv4`, `basicAuth`, `oauth2`, or `azureAd`.";
        type = (types.nullOr RemoteWriteAuthorizationModule);
        default = null;
      };
      "azureAd" = mkOption {
        description = "AzureAD for the URL.\n\nIt requires Prometheus >= v2.45.0 or Thanos >= v0.31.0.\n\nCannot be set at the same time as `authorization`, `basicAuth`, `oauth2`, or `sigv4`.";
        type = (types.nullOr RemoteWriteAzureAdModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "BasicAuth configuration for the URL.\n\nCannot be set at the same time as `sigv4`, `authorization`, `oauth2`, or `azureAd`.";
        type = (types.nullOr RemoteWriteBasicAuthModule);
        default = null;
      };
      "bearerToken" = mkOption {
        description = "*Warning: this field shouldn't be used because the token value appears\nin clear-text. Prefer using `authorization`.*\n\nDeprecated: this will be removed in a future release.";
        type = (types.nullOr types.str);
        default = null;
      };
      "bearerTokenFile" = mkOption {
        description = "File from which to read bearer token for the URL.\n\nDeprecated: this will be removed in a future release. Prefer using `authorization`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "enableHTTP2" = mkOption {
        description = "Whether to enable HTTP2.";
        type = types.bool;
        default = false;
      };
      "followRedirects" = mkOption {
        description = "Configure whether HTTP requests follow HTTP 3xx redirects.\n\nIt requires Prometheus >= v2.26.0 or Thanos >= v0.24.0.";
        type = types.bool;
        default = false;
      };
      "headers" = mkOption {
        description = "Custom HTTP headers to be sent along with each remote write request.\nBe aware that headers that are set by Prometheus itself can't be overwritten.\n\nIt requires Prometheus >= v2.25.0 or Thanos >= v0.24.0.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "messageVersion" = mkOption {
        description = "The Remote Write message's version to use when writing to the endpoint.\n\n`Version1.0` corresponds to the `prometheus.WriteRequest` protobuf message introduced in Remote Write 1.0.\n`Version2.0` corresponds to the `io.prometheus.write.v2.Request` protobuf message introduced in Remote Write 2.0.\n\nWhen `Version2.0` is selected, Prometheus will automatically be\nconfigured to append the metadata of scraped metrics to the WAL.\n\nBefore setting this field, consult with your remote storage provider\nwhat message version it supports.\n\nIt requires Prometheus >= v2.54.0 or Thanos >= v0.37.0.";
        type = (
          types.nullOr (
            types.enum [
              "V1.0"
              "V2.0"
            ]
          )
        );
        default = null;
      };
      "metadataConfig" = mkOption {
        description = "MetadataConfig configures the sending of series metadata to the remote storage.";
        type = (types.nullOr RemoteWriteMetadataConfigModule);
        default = null;
      };
      "name" = mkOption {
        description = "The name of the remote write queue, it must be unique if specified. The\nname is used in metrics and logging in order to differentiate queues.\n\nIt requires Prometheus >= v2.15.0 or Thanos >= 0.24.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "OAuth2 configuration for the URL.\n\nIt requires Prometheus >= v2.27.0 or Thanos >= v0.24.0.\n\nCannot be set at the same time as `sigv4`, `authorization`, `basicAuth`, or `azureAd`.";
        type = (types.nullOr RemoteWriteOauth2Module);
        default = null;
      };
      "proxyConnectHeader" = mkOption {
        description = "ProxyConnectHeader optionally specifies headers to send to\nproxies during CONNECT requests.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.attrsOf (types.listOf (types.attrsOf types.anything)));
        default = { };
      };
      "proxyFromEnvironment" = mkOption {
        description = "Whether to use the proxy configuration defined by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY).\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = types.bool;
        default = false;
      };
      "proxyUrl" = mkOption {
        description = "`proxyURL` defines the HTTP proxy server to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "queueConfig" = mkOption {
        description = "QueueConfig allows tuning of the remote write queue parameters.";
        type = (types.nullOr RemoteWriteQueueConfigModule);
        default = null;
      };
      "remoteTimeout" = mkOption {
        description = "Timeout for requests to the remote write endpoint.";
        type = (types.nullOr types.str);
        default = null;
      };
      "roundRobinDNS" = mkOption {
        description = "When enabled:\n    - The remote-write mechanism will resolve the hostname via DNS.\n    - It will randomly select one of the resolved IP addresses and connect to it.\n\nWhen disabled (default behavior):\n    - The Go standard library will handle hostname resolution.\n    - It will attempt connections to each resolved IP address sequentially.\n\nNote: The connection timeout applies to the entire resolution and connection process.\n      If disabled, the timeout is distributed across all connection attempts.\n\nIt requires Prometheus >= v3.1.0 or Thanos >= v0.38.0.";
        type = types.bool;
        default = false;
      };
      "sendExemplars" = mkOption {
        description = "Enables sending of exemplars over remote write. Note that\nexemplar-storage itself must be enabled using the `spec.enableFeatures`\noption for exemplars to be scraped in the first place.\n\nIt requires Prometheus >= v2.27.0 or Thanos >= v0.24.0.";
        type = types.bool;
        default = false;
      };
      "sendNativeHistograms" = mkOption {
        description = "Enables sending of native histograms, also known as sparse histograms\nover remote write.\n\nIt requires Prometheus >= v2.40.0 or Thanos >= v0.30.0.";
        type = types.bool;
        default = false;
      };
      "sigv4" = mkOption {
        description = "Sigv4 allows to configures AWS's Signature Verification 4 for the URL.\n\nIt requires Prometheus >= v2.26.0 or Thanos >= v0.24.0.\n\nCannot be set at the same time as `authorization`, `basicAuth`, `oauth2`, or `azureAd`.";
        type = (types.nullOr RemoteWriteSigv4Module);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS Config to use for the URL.";
        type = (types.nullOr RemoteWriteTlsConfigModule);
        default = null;
      };
      "url" = mkOption {
        description = "The URL of the endpoint to send samples to.";
        type = types.str;
      };
      "writeRelabelConfigs" = mkOption {
        description = "The list of remote write relabel configurations.";
        type = (types.listOf RemoteWriteWriteRelabelConfigModule);
        default = [ ];
      };
    };
  };
  mkRemoteWrite =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkRemoteWriteAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."azureAd" != null) { "azureAd" = mkRemoteWriteAzureAd res."azureAd"; }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) { "basicAuth" = mkRemoteWriteBasicAuth res."basicAuth"; }
    // {
    }
    // optionalAttrs (res."bearerToken" != null) { inherit (res) "bearerToken"; }
    // {
    }
    // optionalAttrs (res."bearerTokenFile" != null) { inherit (res) "bearerTokenFile"; }
    // {
    }
    // optionalAttrs res."enableHTTP2" { inherit (res) "enableHTTP2"; }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."headers" != { }) { inherit (res) "headers"; }
    // {
    }
    // optionalAttrs (res."messageVersion" != null) { inherit (res) "messageVersion"; }
    // {
    }
    // optionalAttrs (res."metadataConfig" != null) {
      "metadataConfig" = mkRemoteWriteMetadataConfig res."metadataConfig";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) { "oauth2" = mkRemoteWriteOauth2 res."oauth2"; }
    // {
    }
    // optionalAttrs (res."proxyConnectHeader" != { }) { inherit (res) "proxyConnectHeader"; }
    // {
    }
    // optionalAttrs res."proxyFromEnvironment" { inherit (res) "proxyFromEnvironment"; }
    // {
    }
    // optionalAttrs (res."proxyUrl" != null) { inherit (res) "proxyUrl"; }
    // {
    }
    // optionalAttrs (res."queueConfig" != null) {
      "queueConfig" = mkRemoteWriteQueueConfig res."queueConfig";
    }
    // {
    }
    // optionalAttrs (res."remoteTimeout" != null) { inherit (res) "remoteTimeout"; }
    // {
    }
    // optionalAttrs res."roundRobinDNS" { inherit (res) "roundRobinDNS"; }
    // {
    }
    // optionalAttrs res."sendExemplars" { inherit (res) "sendExemplars"; }
    // {
    }
    // optionalAttrs res."sendNativeHistograms" { inherit (res) "sendNativeHistograms"; }
    // {
    }
    // optionalAttrs (res."sigv4" != null) { "sigv4" = mkRemoteWriteSigv4 res."sigv4"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) { "tlsConfig" = mkRemoteWriteTlsConfig res."tlsConfig"; }
    // {
      inherit (res) "url";
    }
    // optionalAttrs (res."writeRelabelConfigs" != [ ]) {
      "writeRelabelConfigs" = map mkRemoteWriteWriteRelabelConfig res."writeRelabelConfigs";
    }
    // {
    };
  RemoteWriteOauth2ClientIdConfigMapModule = types.submodule {
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
  mkRemoteWriteOauth2ClientIdConfigMap =
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
  RemoteWriteOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr RemoteWriteOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr RemoteWriteOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkRemoteWriteOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkRemoteWriteOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkRemoteWriteOauth2ClientIdSecret res."secret";
    }
    // {
    };
  RemoteWriteOauth2ClientIdSecretModule = types.submodule {
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
  mkRemoteWriteOauth2ClientIdSecret =
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
  RemoteWriteOauth2ClientSecretModule = types.submodule {
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
  mkRemoteWriteOauth2ClientSecret =
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
  RemoteWriteOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = RemoteWriteOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = RemoteWriteOauth2ClientSecretModule;
      };
      "endpointParams" = mkOption {
        description = "`endpointParams` configures the HTTP parameters to append to the token\nURL.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "proxyConnectHeader" = mkOption {
        description = "ProxyConnectHeader optionally specifies headers to send to\nproxies during CONNECT requests.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.attrsOf (types.listOf (types.attrsOf types.anything)));
        default = { };
      };
      "proxyFromEnvironment" = mkOption {
        description = "Whether to use the proxy configuration defined by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY).\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = types.bool;
        default = false;
      };
      "proxyUrl" = mkOption {
        description = "`proxyURL` defines the HTTP proxy server to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "scopes" = mkOption {
        description = "`scopes` defines the OAuth2 scopes used for the token request.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration to use when connecting to the OAuth2 server.\nIt requires Prometheus >= v2.43.0.";
        type = (types.nullOr RemoteWriteOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkRemoteWriteOauth2 =
    res:
    {
      "clientId" = mkRemoteWriteOauth2ClientId res."clientId";
      "clientSecret" = mkRemoteWriteOauth2ClientSecret res."clientSecret";
    }
    // optionalAttrs (res."endpointParams" != { }) { inherit (res) "endpointParams"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."proxyConnectHeader" != { }) { inherit (res) "proxyConnectHeader"; }
    // {
    }
    // optionalAttrs res."proxyFromEnvironment" { inherit (res) "proxyFromEnvironment"; }
    // {
    }
    // optionalAttrs (res."proxyUrl" != null) { inherit (res) "proxyUrl"; }
    // {
    }
    // optionalAttrs (res."scopes" != [ ]) { inherit (res) "scopes"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkRemoteWriteOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  RemoteWriteOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkRemoteWriteOauth2TlsConfigCaConfigMap =
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
  RemoteWriteOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr RemoteWriteOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr RemoteWriteOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkRemoteWriteOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkRemoteWriteOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkRemoteWriteOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  RemoteWriteOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkRemoteWriteOauth2TlsConfigCaSecret =
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
  RemoteWriteOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkRemoteWriteOauth2TlsConfigCertConfigMap =
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
  RemoteWriteOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr RemoteWriteOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr RemoteWriteOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkRemoteWriteOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkRemoteWriteOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkRemoteWriteOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  RemoteWriteOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkRemoteWriteOauth2TlsConfigCertSecret =
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
  RemoteWriteOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkRemoteWriteOauth2TlsConfigKeySecret =
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
  RemoteWriteOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr RemoteWriteOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr RemoteWriteOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr RemoteWriteOauth2TlsConfigKeySecretModule);
        default = null;
      };
      "maxVersion" = mkOption {
        description = "Maximum acceptable TLS version.\n\nIt requires Prometheus >= v2.41.0 or Thanos >= v0.31.0.";
        type = (
          types.nullOr (
            types.enum [
              "TLS10"
              "TLS11"
              "TLS12"
              "TLS13"
            ]
          )
        );
        default = null;
      };
      "minVersion" = mkOption {
        description = "Minimum acceptable TLS version.\n\nIt requires Prometheus >= v2.35.0 or Thanos >= v0.28.0.";
        type = (
          types.nullOr (
            types.enum [
              "TLS10"
              "TLS11"
              "TLS12"
              "TLS13"
            ]
          )
        );
        default = null;
      };
      "serverName" = mkOption {
        description = "Used to verify the hostname for the targets.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkRemoteWriteOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkRemoteWriteOauth2TlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkRemoteWriteOauth2TlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkRemoteWriteOauth2TlsConfigKeySecret res."keySecret";
    }
    // {
    }
    // optionalAttrs (res."maxVersion" != null) { inherit (res) "maxVersion"; }
    // {
    }
    // optionalAttrs (res."minVersion" != null) { inherit (res) "minVersion"; }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    };
  RemoteWriteQueueConfigModule = types.submodule {
    options = {
      "batchSendDeadline" = mkOption {
        description = "BatchSendDeadline is the maximum time a sample will wait in buffer.";
        type = (types.nullOr types.str);
        default = null;
      };
      "capacity" = mkOption {
        description = "Capacity is the number of samples to buffer per shard before we start\ndropping them.";
        type = (types.nullOr types.int);
        default = null;
      };
      "maxBackoff" = mkOption {
        description = "MaxBackoff is the maximum retry delay.";
        type = (types.nullOr types.str);
        default = null;
      };
      "maxRetries" = mkOption {
        description = "MaxRetries is the maximum number of times to retry a batch on recoverable errors.";
        type = (types.nullOr types.int);
        default = null;
      };
      "maxSamplesPerSend" = mkOption {
        description = "MaxSamplesPerSend is the maximum number of samples per send.";
        type = (types.nullOr types.int);
        default = null;
      };
      "maxShards" = mkOption {
        description = "MaxShards is the maximum number of shards, i.e. amount of concurrency.";
        type = (types.nullOr types.int);
        default = null;
      };
      "minBackoff" = mkOption {
        description = "MinBackoff is the initial retry delay. Gets doubled for every retry.";
        type = (types.nullOr types.str);
        default = null;
      };
      "minShards" = mkOption {
        description = "MinShards is the minimum number of shards, i.e. amount of concurrency.";
        type = (types.nullOr types.int);
        default = null;
      };
      "retryOnRateLimit" = mkOption {
        description = "Retry upon receiving a 429 status code from the remote-write storage.\n\nThis is an *experimental feature*, it may change in any upcoming release\nin a breaking way.";
        type = types.bool;
        default = false;
      };
      "sampleAgeLimit" = mkOption {
        description = "SampleAgeLimit drops samples older than the limit.\nIt requires Prometheus >= v2.50.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkRemoteWriteQueueConfig =
    res:
    {
    }
    // optionalAttrs (res."batchSendDeadline" != null) { inherit (res) "batchSendDeadline"; }
    // {
    }
    // optionalAttrs (res."capacity" != null) { inherit (res) "capacity"; }
    // {
    }
    // optionalAttrs (res."maxBackoff" != null) { inherit (res) "maxBackoff"; }
    // {
    }
    // optionalAttrs (res."maxRetries" != null) { inherit (res) "maxRetries"; }
    // {
    }
    // optionalAttrs (res."maxSamplesPerSend" != null) { inherit (res) "maxSamplesPerSend"; }
    // {
    }
    // optionalAttrs (res."maxShards" != null) { inherit (res) "maxShards"; }
    // {
    }
    // optionalAttrs (res."minBackoff" != null) { inherit (res) "minBackoff"; }
    // {
    }
    // optionalAttrs (res."minShards" != null) { inherit (res) "minShards"; }
    // {
    }
    // optionalAttrs res."retryOnRateLimit" { inherit (res) "retryOnRateLimit"; }
    // {
    }
    // optionalAttrs (res."sampleAgeLimit" != null) { inherit (res) "sampleAgeLimit"; }
    // {
    };
  RemoteWriteSigv4AccessKeyModule = types.submodule {
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
  mkRemoteWriteSigv4AccessKey =
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
  RemoteWriteSigv4Module = types.submodule {
    options = {
      "accessKey" = mkOption {
        description = "AccessKey is the AWS API key. If not specified, the environment variable\n`AWS_ACCESS_KEY_ID` is used.";
        type = (types.nullOr RemoteWriteSigv4AccessKeyModule);
        default = null;
      };
      "profile" = mkOption {
        description = "Profile is the named AWS profile used to authenticate.";
        type = (types.nullOr types.str);
        default = null;
      };
      "region" = mkOption {
        description = "Region is the AWS region. If blank, the region from the default credentials chain used.";
        type = (types.nullOr types.str);
        default = null;
      };
      "roleArn" = mkOption {
        description = "RoleArn is the named AWS profile used to authenticate.";
        type = (types.nullOr types.str);
        default = null;
      };
      "secretKey" = mkOption {
        description = "SecretKey is the AWS API secret. If not specified, the environment\nvariable `AWS_SECRET_ACCESS_KEY` is used.";
        type = (types.nullOr RemoteWriteSigv4SecretKeyModule);
        default = null;
      };
    };
  };
  mkRemoteWriteSigv4 =
    res:
    {
    }
    // optionalAttrs (res."accessKey" != null) {
      "accessKey" = mkRemoteWriteSigv4AccessKey res."accessKey";
    }
    // {
    }
    // optionalAttrs (res."profile" != null) { inherit (res) "profile"; }
    // {
    }
    // optionalAttrs (res."region" != null) { inherit (res) "region"; }
    // {
    }
    // optionalAttrs (res."roleArn" != null) { inherit (res) "roleArn"; }
    // {
    }
    // optionalAttrs (res."secretKey" != null) {
      "secretKey" = mkRemoteWriteSigv4SecretKey res."secretKey";
    }
    // {
    };
  RemoteWriteSigv4SecretKeyModule = types.submodule {
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
  mkRemoteWriteSigv4SecretKey =
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
  RemoteWriteTlsConfigCaConfigMapModule = types.submodule {
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
  mkRemoteWriteTlsConfigCaConfigMap =
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
  RemoteWriteTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr RemoteWriteTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr RemoteWriteTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkRemoteWriteTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkRemoteWriteTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkRemoteWriteTlsConfigCaSecret res."secret"; }
    // {
    };
  RemoteWriteTlsConfigCaSecretModule = types.submodule {
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
  mkRemoteWriteTlsConfigCaSecret =
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
  RemoteWriteTlsConfigCertConfigMapModule = types.submodule {
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
  mkRemoteWriteTlsConfigCertConfigMap =
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
  RemoteWriteTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr RemoteWriteTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr RemoteWriteTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkRemoteWriteTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkRemoteWriteTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkRemoteWriteTlsConfigCertSecret res."secret";
    }
    // {
    };
  RemoteWriteTlsConfigCertSecretModule = types.submodule {
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
  mkRemoteWriteTlsConfigCertSecret =
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
  RemoteWriteTlsConfigKeySecretModule = types.submodule {
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
  mkRemoteWriteTlsConfigKeySecret =
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
  RemoteWriteTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr RemoteWriteTlsConfigCaModule);
        default = null;
      };
      "caFile" = mkOption {
        description = "Path to the CA cert in the Prometheus container to use for the targets.";
        type = (types.nullOr types.str);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr RemoteWriteTlsConfigCertModule);
        default = null;
      };
      "certFile" = mkOption {
        description = "Path to the client cert file in the Prometheus container for the targets.";
        type = (types.nullOr types.str);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keyFile" = mkOption {
        description = "Path to the client key file in the Prometheus container for the targets.";
        type = (types.nullOr types.str);
        default = null;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr RemoteWriteTlsConfigKeySecretModule);
        default = null;
      };
      "maxVersion" = mkOption {
        description = "Maximum acceptable TLS version.\n\nIt requires Prometheus >= v2.41.0 or Thanos >= v0.31.0.";
        type = (
          types.nullOr (
            types.enum [
              "TLS10"
              "TLS11"
              "TLS12"
              "TLS13"
            ]
          )
        );
        default = null;
      };
      "minVersion" = mkOption {
        description = "Minimum acceptable TLS version.\n\nIt requires Prometheus >= v2.35.0 or Thanos >= v0.28.0.";
        type = (
          types.nullOr (
            types.enum [
              "TLS10"
              "TLS11"
              "TLS12"
              "TLS13"
            ]
          )
        );
        default = null;
      };
      "serverName" = mkOption {
        description = "Used to verify the hostname for the targets.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkRemoteWriteTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkRemoteWriteTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."caFile" != null) { inherit (res) "caFile"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkRemoteWriteTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs (res."certFile" != null) { inherit (res) "certFile"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keyFile" != null) { inherit (res) "keyFile"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkRemoteWriteTlsConfigKeySecret res."keySecret";
    }
    // {
    }
    // optionalAttrs (res."maxVersion" != null) { inherit (res) "maxVersion"; }
    // {
    }
    // optionalAttrs (res."minVersion" != null) { inherit (res) "minVersion"; }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    };
  RemoteWriteWriteRelabelConfigModule = types.submodule {
    options = {
      "action" = mkOption {
        description = "Action to perform based on the regex matching.\n\n`Uppercase` and `Lowercase` actions require Prometheus >= v2.36.0.\n`DropEqual` and `KeepEqual` actions require Prometheus >= v2.41.0.\n\nDefault: \"Replace\"";
        type = (
          types.nullOr (
            types.enum [
              "replace"
              "Replace"
              "keep"
              "Keep"
              "drop"
              "Drop"
              "hashmod"
              "HashMod"
              "labelmap"
              "LabelMap"
              "labeldrop"
              "LabelDrop"
              "labelkeep"
              "LabelKeep"
              "lowercase"
              "Lowercase"
              "uppercase"
              "Uppercase"
              "keepequal"
              "KeepEqual"
              "dropequal"
              "DropEqual"
            ]
          )
        );
        default = "replace";
      };
      "modulus" = mkOption {
        description = "Modulus to take of the hash of the source label values.\n\nOnly applicable when the action is `HashMod`.";
        type = (types.nullOr types.int);
        default = null;
      };
      "regex" = mkOption {
        description = "Regular expression against which the extracted value is matched.";
        type = (types.nullOr types.str);
        default = null;
      };
      "replacement" = mkOption {
        description = "Replacement value against which a Replace action is performed if the\nregular expression matches.\n\nRegex capture groups are available.";
        type = (types.nullOr types.str);
        default = null;
      };
      "separator" = mkOption {
        description = "Separator is the string between concatenated SourceLabels.";
        type = (types.nullOr types.str);
        default = null;
      };
      "sourceLabels" = mkOption {
        description = "The source labels select values from existing labels. Their content is\nconcatenated using the configured Separator and matched against the\nconfigured regular expression.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "targetLabel" = mkOption {
        description = "Label to which the resulting string is written in a replacement.\n\nIt is mandatory for `Replace`, `HashMod`, `Lowercase`, `Uppercase`,\n`KeepEqual` and `DropEqual` actions.\n\nRegex capture groups are available.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkRemoteWriteWriteRelabelConfig =
    res:
    {
    }
    // optionalAttrs (res."action" != null) { inherit (res) "action"; }
    // {
    }
    // optionalAttrs (res."modulus" != null) { inherit (res) "modulus"; }
    // {
    }
    // optionalAttrs (res."regex" != null) { inherit (res) "regex"; }
    // {
    }
    // optionalAttrs (res."replacement" != null) { inherit (res) "replacement"; }
    // {
    }
    // optionalAttrs (res."separator" != null) { inherit (res) "separator"; }
    // {
    }
    // optionalAttrs (res."sourceLabels" != [ ]) { inherit (res) "sourceLabels"; }
    // {
    }
    // optionalAttrs (res."targetLabel" != null) { inherit (res) "targetLabel"; }
    // {
    };
  ResourcesClaimModule = types.submodule {
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
  mkResourcesClaim =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."request" != null) { inherit (res) "request"; }
    // {
    };
  ResourcesModule = types.submodule {
    options = {
      "claims" = mkOption {
        description = "Claims lists the names of resources, defined in spec.resourceClaims,\nthat are used by this container.\n\nThis is an alpha field and requires enabling the\nDynamicResourceAllocation feature gate.\n\nThis field is immutable. It can only be set for containers.";
        type = (types.listOf ResourcesClaimModule);
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
  mkResources =
    res:
    {
    }
    // optionalAttrs (res."claims" != [ ]) { "claims" = map mkResourcesClaim res."claims"; }
    // {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  RuntimeModule = types.submodule {
    options = {
      "goGC" = mkOption {
        description = "The Go garbage collection target percentage. Lowering this number may increase the CPU usage.\nSee: https://tip.golang.org/doc/gc-guide#GOGC";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkRuntime =
    res:
    {
    }
    // optionalAttrs (res."goGC" != null) { inherit (res) "goGC"; }
    // {
    };
  ScrapeClasseAttachMetadataModule = types.submodule {
    options = {
      "node" = mkOption {
        description = "When set to true, Prometheus attaches node metadata to the discovered\ntargets.\n\nThe Prometheus service account must have the `list` and `watch`\npermissions on the `Nodes` objects.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkScrapeClasseAttachMetadata =
    res:
    {
    }
    // optionalAttrs res."node" { inherit (res) "node"; }
    // {
    };
  ScrapeClasseAuthorizationCredentialsModule = types.submodule {
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
  mkScrapeClasseAuthorizationCredentials =
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
  ScrapeClasseAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr ScrapeClasseAuthorizationCredentialsModule);
        default = null;
      };
      "credentialsFile" = mkOption {
        description = "File to read a secret from, mutually exclusive with `credentials`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkScrapeClasseAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkScrapeClasseAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."credentialsFile" != null) { inherit (res) "credentialsFile"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ScrapeClasseMetricRelabelingModule = types.submodule {
    options = {
      "action" = mkOption {
        description = "Action to perform based on the regex matching.\n\n`Uppercase` and `Lowercase` actions require Prometheus >= v2.36.0.\n`DropEqual` and `KeepEqual` actions require Prometheus >= v2.41.0.\n\nDefault: \"Replace\"";
        type = (
          types.nullOr (
            types.enum [
              "replace"
              "Replace"
              "keep"
              "Keep"
              "drop"
              "Drop"
              "hashmod"
              "HashMod"
              "labelmap"
              "LabelMap"
              "labeldrop"
              "LabelDrop"
              "labelkeep"
              "LabelKeep"
              "lowercase"
              "Lowercase"
              "uppercase"
              "Uppercase"
              "keepequal"
              "KeepEqual"
              "dropequal"
              "DropEqual"
            ]
          )
        );
        default = "replace";
      };
      "modulus" = mkOption {
        description = "Modulus to take of the hash of the source label values.\n\nOnly applicable when the action is `HashMod`.";
        type = (types.nullOr types.int);
        default = null;
      };
      "regex" = mkOption {
        description = "Regular expression against which the extracted value is matched.";
        type = (types.nullOr types.str);
        default = null;
      };
      "replacement" = mkOption {
        description = "Replacement value against which a Replace action is performed if the\nregular expression matches.\n\nRegex capture groups are available.";
        type = (types.nullOr types.str);
        default = null;
      };
      "separator" = mkOption {
        description = "Separator is the string between concatenated SourceLabels.";
        type = (types.nullOr types.str);
        default = null;
      };
      "sourceLabels" = mkOption {
        description = "The source labels select values from existing labels. Their content is\nconcatenated using the configured Separator and matched against the\nconfigured regular expression.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "targetLabel" = mkOption {
        description = "Label to which the resulting string is written in a replacement.\n\nIt is mandatory for `Replace`, `HashMod`, `Lowercase`, `Uppercase`,\n`KeepEqual` and `DropEqual` actions.\n\nRegex capture groups are available.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkScrapeClasseMetricRelabeling =
    res:
    {
    }
    // optionalAttrs (res."action" != null) { inherit (res) "action"; }
    // {
    }
    // optionalAttrs (res."modulus" != null) { inherit (res) "modulus"; }
    // {
    }
    // optionalAttrs (res."regex" != null) { inherit (res) "regex"; }
    // {
    }
    // optionalAttrs (res."replacement" != null) { inherit (res) "replacement"; }
    // {
    }
    // optionalAttrs (res."separator" != null) { inherit (res) "separator"; }
    // {
    }
    // optionalAttrs (res."sourceLabels" != [ ]) { inherit (res) "sourceLabels"; }
    // {
    }
    // optionalAttrs (res."targetLabel" != null) { inherit (res) "targetLabel"; }
    // {
    };
  ScrapeClasseModule = types.submodule {
    options = {
      "attachMetadata" = mkOption {
        description = "AttachMetadata configures additional metadata to the discovered targets.\nWhen the scrape object defines its own configuration, it takes\nprecedence over the scrape class configuration.";
        type = (types.nullOr ScrapeClasseAttachMetadataModule);
        default = null;
      };
      "authorization" = mkOption {
        description = "Authorization section for the ScrapeClass.\nIt will only apply if the scrape resource doesn't specify any Authorization.";
        type = (types.nullOr ScrapeClasseAuthorizationModule);
        default = null;
      };
      "default" = mkOption {
        description = "Default indicates that the scrape applies to all scrape objects that\ndon't configure an explicit scrape class name.\n\nOnly one scrape class can be set as the default.";
        type = types.bool;
        default = false;
      };
      "fallbackScrapeProtocol" = mkOption {
        description = "The protocol to use if a scrape returns blank, unparseable, or otherwise invalid Content-Type.\nIt will only apply if the scrape resource doesn't specify any FallbackScrapeProtocol\n\nIt requires Prometheus >= v3.0.0.";
        type = (
          types.nullOr (
            types.enum [
              "PrometheusProto"
              "OpenMetricsText0.0.1"
              "OpenMetricsText1.0.0"
              "PrometheusText0.0.4"
              "PrometheusText1.0.0"
            ]
          )
        );
        default = null;
      };
      "metricRelabelings" = mkOption {
        description = "MetricRelabelings configures the relabeling rules to apply to all samples before ingestion.\n\nThe Operator adds the scrape class metric relabelings defined here.\nThen the Operator adds the target-specific metric relabelings defined in ServiceMonitors, PodMonitors, Probes and ScrapeConfigs.\nThen the Operator adds namespace enforcement relabeling rule, specified in '.spec.enforcedNamespaceLabel'.\n\nMore info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs";
        type = (types.listOf ScrapeClasseMetricRelabelingModule);
        default = [ ];
      };
      "name" = mkOption {
        description = "Name of the scrape class.";
        type = types.str;
      };
      "relabelings" = mkOption {
        description = "Relabelings configures the relabeling rules to apply to all scrape targets.\n\nThe Operator automatically adds relabelings for a few standard Kubernetes fields\nlike `__meta_kubernetes_namespace` and `__meta_kubernetes_service_name`.\nThen the Operator adds the scrape class relabelings defined here.\nThen the Operator adds the target-specific relabelings defined in the scrape object.\n\nMore info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config";
        type = (types.listOf ScrapeClasseRelabelingModule);
        default = [ ];
      };
      "tlsConfig" = mkOption {
        description = "TLSConfig defines the TLS settings to use for the scrape. When the\nscrape objects define their own CA, certificate and/or key, they take\nprecedence over the corresponding scrape class fields.\n\nFor now only the `caFile`, `certFile` and `keyFile` fields are supported.";
        type = (types.nullOr ScrapeClasseTlsConfigModule);
        default = null;
      };
    };
  };
  mkScrapeClasse =
    res:
    {
    }
    // optionalAttrs (res."attachMetadata" != null) {
      "attachMetadata" = mkScrapeClasseAttachMetadata res."attachMetadata";
    }
    // {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkScrapeClasseAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs res."default" { inherit (res) "default"; }
    // {
    }
    // optionalAttrs (res."fallbackScrapeProtocol" != null) { inherit (res) "fallbackScrapeProtocol"; }
    // {
    }
    // optionalAttrs (res."metricRelabelings" != [ ]) {
      "metricRelabelings" = map mkScrapeClasseMetricRelabeling res."metricRelabelings";
    }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."relabelings" != [ ]) {
      "relabelings" = map mkScrapeClasseRelabeling res."relabelings";
    }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkScrapeClasseTlsConfig res."tlsConfig";
    }
    // {
    };
  ScrapeClasseRelabelingModule = types.submodule {
    options = {
      "action" = mkOption {
        description = "Action to perform based on the regex matching.\n\n`Uppercase` and `Lowercase` actions require Prometheus >= v2.36.0.\n`DropEqual` and `KeepEqual` actions require Prometheus >= v2.41.0.\n\nDefault: \"Replace\"";
        type = (
          types.nullOr (
            types.enum [
              "replace"
              "Replace"
              "keep"
              "Keep"
              "drop"
              "Drop"
              "hashmod"
              "HashMod"
              "labelmap"
              "LabelMap"
              "labeldrop"
              "LabelDrop"
              "labelkeep"
              "LabelKeep"
              "lowercase"
              "Lowercase"
              "uppercase"
              "Uppercase"
              "keepequal"
              "KeepEqual"
              "dropequal"
              "DropEqual"
            ]
          )
        );
        default = "replace";
      };
      "modulus" = mkOption {
        description = "Modulus to take of the hash of the source label values.\n\nOnly applicable when the action is `HashMod`.";
        type = (types.nullOr types.int);
        default = null;
      };
      "regex" = mkOption {
        description = "Regular expression against which the extracted value is matched.";
        type = (types.nullOr types.str);
        default = null;
      };
      "replacement" = mkOption {
        description = "Replacement value against which a Replace action is performed if the\nregular expression matches.\n\nRegex capture groups are available.";
        type = (types.nullOr types.str);
        default = null;
      };
      "separator" = mkOption {
        description = "Separator is the string between concatenated SourceLabels.";
        type = (types.nullOr types.str);
        default = null;
      };
      "sourceLabels" = mkOption {
        description = "The source labels select values from existing labels. Their content is\nconcatenated using the configured Separator and matched against the\nconfigured regular expression.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "targetLabel" = mkOption {
        description = "Label to which the resulting string is written in a replacement.\n\nIt is mandatory for `Replace`, `HashMod`, `Lowercase`, `Uppercase`,\n`KeepEqual` and `DropEqual` actions.\n\nRegex capture groups are available.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkScrapeClasseRelabeling =
    res:
    {
    }
    // optionalAttrs (res."action" != null) { inherit (res) "action"; }
    // {
    }
    // optionalAttrs (res."modulus" != null) { inherit (res) "modulus"; }
    // {
    }
    // optionalAttrs (res."regex" != null) { inherit (res) "regex"; }
    // {
    }
    // optionalAttrs (res."replacement" != null) { inherit (res) "replacement"; }
    // {
    }
    // optionalAttrs (res."separator" != null) { inherit (res) "separator"; }
    // {
    }
    // optionalAttrs (res."sourceLabels" != [ ]) { inherit (res) "sourceLabels"; }
    // {
    }
    // optionalAttrs (res."targetLabel" != null) { inherit (res) "targetLabel"; }
    // {
    };
  ScrapeClasseTlsConfigCaConfigMapModule = types.submodule {
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
  mkScrapeClasseTlsConfigCaConfigMap =
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
  ScrapeClasseTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ScrapeClasseTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ScrapeClasseTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkScrapeClasseTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkScrapeClasseTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkScrapeClasseTlsConfigCaSecret res."secret"; }
    // {
    };
  ScrapeClasseTlsConfigCaSecretModule = types.submodule {
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
  mkScrapeClasseTlsConfigCaSecret =
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
  ScrapeClasseTlsConfigCertConfigMapModule = types.submodule {
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
  mkScrapeClasseTlsConfigCertConfigMap =
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
  ScrapeClasseTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ScrapeClasseTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ScrapeClasseTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkScrapeClasseTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkScrapeClasseTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkScrapeClasseTlsConfigCertSecret res."secret";
    }
    // {
    };
  ScrapeClasseTlsConfigCertSecretModule = types.submodule {
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
  mkScrapeClasseTlsConfigCertSecret =
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
  ScrapeClasseTlsConfigKeySecretModule = types.submodule {
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
  mkScrapeClasseTlsConfigKeySecret =
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
  ScrapeClasseTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ScrapeClasseTlsConfigCaModule);
        default = null;
      };
      "caFile" = mkOption {
        description = "Path to the CA cert in the Prometheus container to use for the targets.";
        type = (types.nullOr types.str);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ScrapeClasseTlsConfigCertModule);
        default = null;
      };
      "certFile" = mkOption {
        description = "Path to the client cert file in the Prometheus container for the targets.";
        type = (types.nullOr types.str);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keyFile" = mkOption {
        description = "Path to the client key file in the Prometheus container for the targets.";
        type = (types.nullOr types.str);
        default = null;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ScrapeClasseTlsConfigKeySecretModule);
        default = null;
      };
      "maxVersion" = mkOption {
        description = "Maximum acceptable TLS version.\n\nIt requires Prometheus >= v2.41.0 or Thanos >= v0.31.0.";
        type = (
          types.nullOr (
            types.enum [
              "TLS10"
              "TLS11"
              "TLS12"
              "TLS13"
            ]
          )
        );
        default = null;
      };
      "minVersion" = mkOption {
        description = "Minimum acceptable TLS version.\n\nIt requires Prometheus >= v2.35.0 or Thanos >= v0.28.0.";
        type = (
          types.nullOr (
            types.enum [
              "TLS10"
              "TLS11"
              "TLS12"
              "TLS13"
            ]
          )
        );
        default = null;
      };
      "serverName" = mkOption {
        description = "Used to verify the hostname for the targets.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkScrapeClasseTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkScrapeClasseTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."caFile" != null) { inherit (res) "caFile"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkScrapeClasseTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs (res."certFile" != null) { inherit (res) "certFile"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keyFile" != null) { inherit (res) "keyFile"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkScrapeClasseTlsConfigKeySecret res."keySecret";
    }
    // {
    }
    // optionalAttrs (res."maxVersion" != null) { inherit (res) "maxVersion"; }
    // {
    }
    // optionalAttrs (res."minVersion" != null) { inherit (res) "minVersion"; }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    };
  ScrapeConfigNamespaceSelectorMatchExpressionModule = types.submodule {
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
  mkScrapeConfigNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ScrapeConfigNamespaceSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf ScrapeConfigNamespaceSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkScrapeConfigNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkScrapeConfigNamespaceSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ScrapeConfigSelectorMatchExpressionModule = types.submodule {
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
  mkScrapeConfigSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ScrapeConfigSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf ScrapeConfigSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkScrapeConfigSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkScrapeConfigSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  SecurityContextAppArmorProfileModule = types.submodule {
    options = {
      "localhostProfile" = mkOption {
        description = "localhostProfile indicates a profile loaded on the node that should be used.\nThe profile must be preconfigured on the node to work.\nMust match the loaded name of the profile.\nMust be set if and only if type is \"Localhost\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "type indicates which kind of AppArmor profile will be applied.\nValid options are:\n  Localhost - a profile pre-loaded on the node.\n  RuntimeDefault - the container runtime's default profile.\n  Unconfined - no AppArmor enforcement.";
        type = types.str;
      };
    };
  };
  mkSecurityContextAppArmorProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  SecurityContextModule = types.submodule {
    options = {
      "appArmorProfile" = mkOption {
        description = "appArmorProfile is the AppArmor options to use by the containers in this pod.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr SecurityContextAppArmorProfileModule);
        default = null;
      };
      "fsGroup" = mkOption {
        description = "A special supplemental group that applies to all containers in a pod.\nSome volume types allow the Kubelet to change the ownership of that volume\nto be owned by the pod:\n\n1. The owning GID will be the FSGroup\n2. The setgid bit is set (new files created in the volume will be owned by FSGroup)\n3. The permission bits are OR'd with rw-rw----\n\nIf unset, the Kubelet will not modify the ownership and permissions of any volume.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.int);
        default = null;
      };
      "fsGroupChangePolicy" = mkOption {
        description = "fsGroupChangePolicy defines behavior of changing ownership and permission of the volume\nbefore being exposed inside Pod. This field will only apply to\nvolume types which support fsGroup based ownership(and permissions).\nIt will have no effect on ephemeral volume types such as: secret, configmaps\nand emptydir.\nValid values are \"OnRootMismatch\" and \"Always\". If not specified, \"Always\" is used.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.str);
        default = null;
      };
      "runAsGroup" = mkOption {
        description = "The GID to run the entrypoint of the container process.\nUses runtime default if unset.\nMay also be set in SecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence\nfor that container.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.int);
        default = null;
      };
      "runAsNonRoot" = mkOption {
        description = "Indicates that the container must run as a non-root user.\nIf true, the Kubelet will validate the image at runtime to ensure that it\ndoes not run as UID 0 (root) and fail to start the container if it does.\nIf unset or false, no such validation will be performed.\nMay also be set in SecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.";
        type = types.bool;
        default = false;
      };
      "runAsUser" = mkOption {
        description = "The UID to run the entrypoint of the container process.\nDefaults to user specified in image metadata if unspecified.\nMay also be set in SecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence\nfor that container.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.int);
        default = null;
      };
      "seLinuxChangePolicy" = mkOption {
        description = "seLinuxChangePolicy defines how the container's SELinux label is applied to all volumes used by the Pod.\nIt has no effect on nodes that do not support SELinux or to volumes does not support SELinux.\nValid values are \"MountOption\" and \"Recursive\".\n\n\"Recursive\" means relabeling of all files on all Pod volumes by the container runtime.\nThis may be slow for large volumes, but allows mixing privileged and unprivileged Pods sharing the same volume on the same node.\n\n\"MountOption\" mounts all eligible Pod volumes with `-o context` mount option.\nThis requires all Pods that share the same volume to use the same SELinux label.\nIt is not possible to share the same volume among privileged and unprivileged Pods.\nEligible volumes are in-tree FibreChannel and iSCSI volumes, and all CSI volumes\nwhose CSI driver announces SELinux support by setting spec.seLinuxMount: true in their\nCSIDriver instance. Other volumes are always re-labelled recursively.\n\"MountOption\" value is allowed only when SELinuxMount feature gate is enabled.\n\nIf not specified and SELinuxMount feature gate is enabled, \"MountOption\" is used.\nIf not specified and SELinuxMount feature gate is disabled, \"MountOption\" is used for ReadWriteOncePod volumes\nand \"Recursive\" for all other volumes.\n\nThis field affects only Pods that have SELinux label set, either in PodSecurityContext or in SecurityContext of all containers.\n\nAll Pods that use the same volume should use the same seLinuxChangePolicy, otherwise some pods can get stuck in ContainerCreating state.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.str);
        default = null;
      };
      "seLinuxOptions" = mkOption {
        description = "The SELinux context to be applied to all containers.\nIf unspecified, the container runtime will allocate a random SELinux context for each\ncontainer.  May also be set in SecurityContext.  If set in\nboth SecurityContext and PodSecurityContext, the value specified in SecurityContext\ntakes precedence for that container.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr SecurityContextSeLinuxOptionsModule);
        default = null;
      };
      "seccompProfile" = mkOption {
        description = "The seccomp options to use by the containers in this pod.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr SecurityContextSeccompProfileModule);
        default = null;
      };
      "supplementalGroups" = mkOption {
        description = "A list of groups applied to the first process run in each container, in\naddition to the container's primary GID and fsGroup (if specified).  If\nthe SupplementalGroupsPolicy feature is enabled, the\nsupplementalGroupsPolicy field determines whether these are in addition\nto or instead of any group memberships defined in the container image.\nIf unspecified, no additional groups are added, though group memberships\ndefined in the container image may still be used, depending on the\nsupplementalGroupsPolicy field.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.listOf types.int);
        default = [ ];
      };
      "supplementalGroupsPolicy" = mkOption {
        description = "Defines how supplemental groups of the first container processes are calculated.\nValid values are \"Merge\" and \"Strict\". If not specified, \"Merge\" is used.\n(Alpha) Using the field requires the SupplementalGroupsPolicy feature gate to be enabled\nand the container runtime must implement support for this feature.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.str);
        default = null;
      };
      "sysctls" = mkOption {
        description = "Sysctls hold a list of namespaced sysctls used for the pod. Pods with unsupported\nsysctls (by the container runtime) might fail to launch.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.listOf SecurityContextSysctlModule);
        default = [ ];
      };
      "windowsOptions" = mkOption {
        description = "The Windows specific settings applied to all containers.\nIf unspecified, the options within a container's SecurityContext will be used.\nIf set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is linux.";
        type = (types.nullOr SecurityContextWindowsOptionsModule);
        default = null;
      };
    };
  };
  mkSecurityContext =
    res:
    {
    }
    // optionalAttrs (res."appArmorProfile" != null) {
      "appArmorProfile" = mkSecurityContextAppArmorProfile res."appArmorProfile";
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
      "seLinuxOptions" = mkSecurityContextSeLinuxOptions res."seLinuxOptions";
    }
    // {
    }
    // optionalAttrs (res."seccompProfile" != null) {
      "seccompProfile" = mkSecurityContextSeccompProfile res."seccompProfile";
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
    // optionalAttrs (res."sysctls" != [ ]) { "sysctls" = map mkSecurityContextSysctl res."sysctls"; }
    // {
    }
    // optionalAttrs (res."windowsOptions" != null) {
      "windowsOptions" = mkSecurityContextWindowsOptions res."windowsOptions";
    }
    // {
    };
  SecurityContextSeLinuxOptionsModule = types.submodule {
    options = {
      "level" = mkOption {
        description = "Level is SELinux level label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
      "role" = mkOption {
        description = "Role is a SELinux role label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Type is a SELinux type label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
      "user" = mkOption {
        description = "User is a SELinux user label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSecurityContextSeLinuxOptions =
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
  SecurityContextSeccompProfileModule = types.submodule {
    options = {
      "localhostProfile" = mkOption {
        description = "localhostProfile indicates a profile defined in a file on the node should be used.\nThe profile must be preconfigured on the node to work.\nMust be a descending path, relative to the kubelet's configured seccomp profile location.\nMust be set if type is \"Localhost\". Must NOT be set for any other type.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "type indicates which kind of seccomp profile will be applied.\nValid options are:\n\nLocalhost - a profile defined in a file on the node should be used.\nRuntimeDefault - the container runtime default profile should be used.\nUnconfined - no profile should be applied.";
        type = types.str;
      };
    };
  };
  mkSecurityContextSeccompProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  SecurityContextSysctlModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of a property to set";
        type = types.str;
      };
      "value" = mkOption {
        description = "Value of a property to set";
        type = types.str;
      };
    };
  };
  mkSecurityContextSysctl = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  SecurityContextWindowsOptionsModule = types.submodule {
    options = {
      "gmsaCredentialSpec" = mkOption {
        description = "GMSACredentialSpec is where the GMSA admission webhook\n(https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the\nGMSA credential spec named by the GMSACredentialSpecName field.";
        type = (types.nullOr types.str);
        default = null;
      };
      "gmsaCredentialSpecName" = mkOption {
        description = "GMSACredentialSpecName is the name of the GMSA credential spec to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "hostProcess" = mkOption {
        description = "HostProcess determines if a container should be run as a 'Host Process' container.\nAll of a Pod's containers must have the same effective HostProcess value\n(it is not allowed to have a mix of HostProcess containers and non-HostProcess containers).\nIn addition, if HostProcess is true then HostNetwork must also be set to true.";
        type = types.bool;
        default = false;
      };
      "runAsUserName" = mkOption {
        description = "The UserName in Windows to run the entrypoint of the container process.\nDefaults to the user specified in image metadata if unspecified.\nMay also be set in PodSecurityContext. If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSecurityContextWindowsOptions =
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
  ServiceMonitorNamespaceSelectorMatchExpressionModule = types.submodule {
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
  mkServiceMonitorNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ServiceMonitorNamespaceSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf ServiceMonitorNamespaceSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkServiceMonitorNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkServiceMonitorNamespaceSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ServiceMonitorSelectorMatchExpressionModule = types.submodule {
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
  mkServiceMonitorSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ServiceMonitorSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf ServiceMonitorSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkServiceMonitorSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkServiceMonitorSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  StorageEmptyDirModule = types.submodule {
    options = {
      "medium" = mkOption {
        description = "medium represents what type of storage medium should back this directory.\nThe default is \"\" which means to use the node's default medium.\nMust be an empty string (default) or Memory.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir";
        type = (types.nullOr types.str);
        default = null;
      };
      "sizeLimit" = mkOption {
        description = "sizeLimit is the total amount of local storage required for this EmptyDir volume.\nThe size limit is also applicable for memory medium.\nThe maximum usage on memory medium EmptyDir would be the minimum value between\nthe SizeLimit specified here and the sum of memory limits of all containers in a pod.\nThe default is nil which means that the limit is undefined.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir";
        type = types.anything;
        default = { };
      };
    };
  };
  mkStorageEmptyDir =
    res:
    {
    }
    // optionalAttrs (res."medium" != null) { inherit (res) "medium"; }
    // {
    }
    // optionalAttrs (res."sizeLimit" != null) { inherit (res) "sizeLimit"; }
    // {
    };
  StorageEphemeralModule = types.submodule {
    options = {
      "volumeClaimTemplate" = mkOption {
        description = "Will be used to create a stand-alone PVC to provision the volume.\nThe pod in which this EphemeralVolumeSource is embedded will be the\nowner of the PVC, i.e. the PVC will be deleted together with the\npod.  The name of the PVC will be `<pod name>-<volume name>` where\n`<volume name>` is the name from the `PodSpec.Volumes` array\nentry. Pod validation will reject the pod if the concatenated name\nis not valid for a PVC (for example, too long).\n\nAn existing PVC with that name that is not owned by the pod\nwill *not* be used for the pod to avoid using an unrelated\nvolume by mistake. Starting the pod is then blocked until\nthe unrelated PVC is removed. If such a pre-created PVC is\nmeant to be used by the pod, the PVC has to updated with an\nowner reference to the pod once the pod exists. Normally\nthis should not be necessary, but it may be useful when\nmanually reconstructing a broken cluster.\n\nThis field is read-only and no changes will be made by Kubernetes\nto the PVC after it has been created.\n\nRequired, must not be nil.";
        type = (types.nullOr StorageEphemeralVolumeClaimTemplateModule);
        default = null;
      };
    };
  };
  mkStorageEphemeral =
    res:
    {
    }
    // optionalAttrs (res."volumeClaimTemplate" != null) {
      "volumeClaimTemplate" = mkStorageEphemeralVolumeClaimTemplate res."volumeClaimTemplate";
    }
    // {
    };
  StorageEphemeralVolumeClaimTemplateModule = types.submodule {
    options = {
      "metadata" = mkOption {
        description = "May contain labels and annotations that will be copied into the PVC\nwhen creating it. No other fields are allowed and will be rejected during\nvalidation.";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "spec" = mkOption {
        description = "The specification for the PersistentVolumeClaim. The entire content is\ncopied unchanged into the PVC that gets created from this\ntemplate. The same fields as in a PersistentVolumeClaim\nare also valid here.";
        type = StorageEphemeralVolumeClaimTemplateSpecModule;
      };
    };
  };
  mkStorageEphemeralVolumeClaimTemplate =
    res:
    {
    }
    // optionalAttrs (res."metadata" != { }) { inherit (res) "metadata"; }
    // {
      "spec" = mkStorageEphemeralVolumeClaimTemplateSpec res."spec";
    };
  StorageEphemeralVolumeClaimTemplateSpecDataSourceModule = types.submodule {
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
  mkStorageEphemeralVolumeClaimTemplateSpecDataSource =
    res:
    {
    }
    // optionalAttrs (res."apiGroup" != null) { inherit (res) "apiGroup"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    };
  StorageEphemeralVolumeClaimTemplateSpecDataSourceRefModule = types.submodule {
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
      "namespace" = mkOption {
        description = "Namespace is the namespace of resource being referenced\nNote that when a namespace is specified, a gateway.networking.k8s.io/ReferenceGrant object is required in the referent namespace to allow that namespace's owner to accept the reference. See the ReferenceGrant documentation for details.\n(Alpha) This field requires the CrossNamespaceVolumeDataSource feature gate to be enabled.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkStorageEphemeralVolumeClaimTemplateSpecDataSourceRef =
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
  StorageEphemeralVolumeClaimTemplateSpecModule = types.submodule {
    options = {
      "accessModes" = mkOption {
        description = "accessModes contains the desired access modes the volume should have.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1";
        type = (types.listOf types.str);
        default = [ ];
      };
      "dataSource" = mkOption {
        description = "dataSource field can be used to specify either:\n* An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot)\n* An existing PVC (PersistentVolumeClaim)\nIf the provisioner or an external controller can support the specified data source,\nit will create a new volume based on the contents of the specified data source.\nWhen the AnyVolumeDataSource feature gate is enabled, dataSource contents will be copied to dataSourceRef,\nand dataSourceRef contents will be copied to dataSource when dataSourceRef.namespace is not specified.\nIf the namespace is specified, then dataSourceRef will not be copied to dataSource.";
        type = (types.nullOr StorageEphemeralVolumeClaimTemplateSpecDataSourceModule);
        default = null;
      };
      "dataSourceRef" = mkOption {
        description = "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty\nvolume is desired. This may be any object from a non-empty API group (non\ncore object) or a PersistentVolumeClaim object.\nWhen this field is specified, volume binding will only succeed if the type of\nthe specified object matches some installed volume populator or dynamic\nprovisioner.\nThis field will replace the functionality of the dataSource field and as such\nif both fields are non-empty, they must have the same value. For backwards\ncompatibility, when namespace isn't specified in dataSourceRef,\nboth fields (dataSource and dataSourceRef) will be set to the same\nvalue automatically if one of them is empty and the other is non-empty.\nWhen namespace is specified in dataSourceRef,\ndataSource isn't set to the same value and must be empty.\nThere are three important differences between dataSource and dataSourceRef:\n* While dataSource only allows two specific types of objects, dataSourceRef\n  allows any non-core object, as well as PersistentVolumeClaim objects.\n* While dataSource ignores disallowed values (dropping them), dataSourceRef\n  preserves all values, and generates an error if a disallowed value is\n  specified.\n* While dataSource only allows local objects, dataSourceRef allows objects\n  in any namespaces.\n(Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled.\n(Alpha) Using the namespace field of dataSourceRef requires the CrossNamespaceVolumeDataSource feature gate to be enabled.";
        type = (types.nullOr StorageEphemeralVolumeClaimTemplateSpecDataSourceRefModule);
        default = null;
      };
      "resources" = mkOption {
        description = "resources represents the minimum resources the volume should have.\nIf RecoverVolumeExpansionFailure feature is enabled users are allowed to specify resource requirements\nthat are lower than previous value but must still be higher than capacity recorded in the\nstatus field of the claim.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources";
        type = (types.nullOr StorageEphemeralVolumeClaimTemplateSpecResourcesModule);
        default = null;
      };
      "selector" = mkOption {
        description = "selector is a label query over volumes to consider for binding.";
        type = (types.nullOr StorageEphemeralVolumeClaimTemplateSpecSelectorModule);
        default = null;
      };
      "storageClassName" = mkOption {
        description = "storageClassName is the name of the StorageClass required by the claim.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeAttributesClassName" = mkOption {
        description = "volumeAttributesClassName may be used to set the VolumeAttributesClass used by this claim.\nIf specified, the CSI driver will create or update the volume with the attributes defined\nin the corresponding VolumeAttributesClass. This has a different purpose than storageClassName,\nit can be changed after the claim is created. An empty string value means that no VolumeAttributesClass\nwill be applied to the claim but it's not allowed to reset this field to empty string once it is set.\nIf unspecified and the PersistentVolumeClaim is unbound, the default VolumeAttributesClass\nwill be set by the persistentvolume controller if it exists.\nIf the resource referred to by volumeAttributesClass does not exist, this PersistentVolumeClaim will be\nset to a Pending state, as reflected by the modifyVolumeStatus field, until such as a resource\nexists.\nMore info: https://kubernetes.io/docs/concepts/storage/volume-attributes-classes/\n(Beta) Using this field requires the VolumeAttributesClass feature gate to be enabled (off by default).";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeMode" = mkOption {
        description = "volumeMode defines what type of volume is required by the claim.\nValue of Filesystem is implied when not included in claim spec.";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeName" = mkOption {
        description = "volumeName is the binding reference to the PersistentVolume backing this claim.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkStorageEphemeralVolumeClaimTemplateSpec =
    res:
    {
    }
    // optionalAttrs (res."accessModes" != [ ]) { inherit (res) "accessModes"; }
    // {
    }
    // optionalAttrs (res."dataSource" != null) {
      "dataSource" = mkStorageEphemeralVolumeClaimTemplateSpecDataSource res."dataSource";
    }
    // {
    }
    // optionalAttrs (res."dataSourceRef" != null) {
      "dataSourceRef" = mkStorageEphemeralVolumeClaimTemplateSpecDataSourceRef res."dataSourceRef";
    }
    // {
    }
    // optionalAttrs (res."resources" != null) {
      "resources" = mkStorageEphemeralVolumeClaimTemplateSpecResources res."resources";
    }
    // {
    }
    // optionalAttrs (res."selector" != null) {
      "selector" = mkStorageEphemeralVolumeClaimTemplateSpecSelector res."selector";
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
  StorageEphemeralVolumeClaimTemplateSpecResourcesModule = types.submodule {
    options = {
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
  mkStorageEphemeralVolumeClaimTemplateSpecResources =
    res:
    {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  StorageEphemeralVolumeClaimTemplateSpecSelectorMatchExpressionModule = types.submodule {
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
  mkStorageEphemeralVolumeClaimTemplateSpecSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  StorageEphemeralVolumeClaimTemplateSpecSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf StorageEphemeralVolumeClaimTemplateSpecSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkStorageEphemeralVolumeClaimTemplateSpecSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkStorageEphemeralVolumeClaimTemplateSpecSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  StorageModule = types.submodule {
    options = {
      "disableMountSubPath" = mkOption {
        description = "Deprecated: subPath usage will be removed in a future release.";
        type = types.bool;
        default = false;
      };
      "emptyDir" = mkOption {
        description = "EmptyDirVolumeSource to be used by the StatefulSet.\nIf specified, it takes precedence over `ephemeral` and `volumeClaimTemplate`.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes/#emptydir";
        type = (types.nullOr StorageEmptyDirModule);
        default = null;
      };
      "ephemeral" = mkOption {
        description = "EphemeralVolumeSource to be used by the StatefulSet.\nThis is a beta field in k8s 1.21 and GA in 1.15.\nFor lower versions, starting with k8s 1.19, it requires enabling the GenericEphemeralVolume feature gate.\nMore info: https://kubernetes.io/docs/concepts/storage/ephemeral-volumes/#generic-ephemeral-volumes";
        type = (types.nullOr StorageEphemeralModule);
        default = null;
      };
      "volumeClaimTemplate" = mkOption {
        description = "Defines the PVC spec to be used by the Prometheus StatefulSets.\nThe easiest way to use a volume that cannot be automatically provisioned\nis to use a label selector alongside manually created PersistentVolumes.";
        type = (types.nullOr StorageVolumeClaimTemplateModule);
        default = null;
      };
    };
  };
  mkStorage =
    res:
    {
    }
    // optionalAttrs res."disableMountSubPath" { inherit (res) "disableMountSubPath"; }
    // {
    }
    // optionalAttrs (res."emptyDir" != null) { "emptyDir" = mkStorageEmptyDir res."emptyDir"; }
    // {
    }
    // optionalAttrs (res."ephemeral" != null) { "ephemeral" = mkStorageEphemeral res."ephemeral"; }
    // {
    }
    // optionalAttrs (res."volumeClaimTemplate" != null) {
      "volumeClaimTemplate" = mkStorageVolumeClaimTemplate res."volumeClaimTemplate";
    }
    // {
    };
  StorageVolumeClaimTemplateMetadataModule = types.submodule {
    options = {
      "annotations" = mkOption {
        description = "Annotations is an unstructured key value map stored with a resource that may be\nset by external tools to store and retrieve arbitrary metadata. They are not\nqueryable and should be preserved when modifying objects.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/";
        type = (types.attrsOf types.str);
        default = { };
      };
      "labels" = mkOption {
        description = "Map of string keys and values that can be used to organize and categorize\n(scope and select) objects. May match selectors of replication controllers\nand services.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/";
        type = (types.attrsOf types.str);
        default = { };
      };
      "name" = mkOption {
        description = "Name must be unique within a namespace. Is required when creating resources, although\nsome resources may allow a client to request the generation of an appropriate name\nautomatically. Name is primarily intended for creation idempotence and configuration\ndefinition.\nCannot be updated.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkStorageVolumeClaimTemplateMetadata =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  StorageVolumeClaimTemplateModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        description = "APIVersion defines the versioned schema of this representation of an object.\nServers should convert recognized schemas to the latest internal value, and\nmay reject unrecognized values.\nMore info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources";
        type = (types.nullOr types.str);
        default = null;
      };
      "kind" = mkOption {
        description = "Kind is a string value representing the REST resource this object represents.\nServers may infer this from the endpoint the client submits requests to.\nCannot be updated.\nIn CamelCase.\nMore info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds";
        type = (types.nullOr types.str);
        default = null;
      };
      "metadata" = mkOption {
        description = "EmbeddedMetadata contains metadata relevant to an EmbeddedResource.";
        type = (types.nullOr StorageVolumeClaimTemplateMetadataModule);
        default = null;
      };
      "spec" = mkOption {
        description = "Defines the desired characteristics of a volume requested by a pod author.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims";
        type = (types.nullOr StorageVolumeClaimTemplateSpecModule);
        default = null;
      };
      "status" = mkOption {
        description = "Deprecated: this field is never set.";
        type = (types.nullOr StorageVolumeClaimTemplateStatusModule);
        default = null;
      };
    };
  };
  mkStorageVolumeClaimTemplate =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
    }
    // optionalAttrs (res."kind" != null) { inherit (res) "kind"; }
    // {
    }
    // optionalAttrs (res."metadata" != null) {
      "metadata" = mkStorageVolumeClaimTemplateMetadata res."metadata";
    }
    // {
    }
    // optionalAttrs (res."spec" != null) { "spec" = mkStorageVolumeClaimTemplateSpec res."spec"; }
    // {
    }
    // optionalAttrs (res."status" != null) {
      "status" = mkStorageVolumeClaimTemplateStatus res."status";
    }
    // {
    };
  StorageVolumeClaimTemplateSpecDataSourceModule = types.submodule {
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
  mkStorageVolumeClaimTemplateSpecDataSource =
    res:
    {
    }
    // optionalAttrs (res."apiGroup" != null) { inherit (res) "apiGroup"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    };
  StorageVolumeClaimTemplateSpecDataSourceRefModule = types.submodule {
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
      "namespace" = mkOption {
        description = "Namespace is the namespace of resource being referenced\nNote that when a namespace is specified, a gateway.networking.k8s.io/ReferenceGrant object is required in the referent namespace to allow that namespace's owner to accept the reference. See the ReferenceGrant documentation for details.\n(Alpha) This field requires the CrossNamespaceVolumeDataSource feature gate to be enabled.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkStorageVolumeClaimTemplateSpecDataSourceRef =
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
  StorageVolumeClaimTemplateSpecModule = types.submodule {
    options = {
      "accessModes" = mkOption {
        description = "accessModes contains the desired access modes the volume should have.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1";
        type = (types.listOf types.str);
        default = [ ];
      };
      "dataSource" = mkOption {
        description = "dataSource field can be used to specify either:\n* An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot)\n* An existing PVC (PersistentVolumeClaim)\nIf the provisioner or an external controller can support the specified data source,\nit will create a new volume based on the contents of the specified data source.\nWhen the AnyVolumeDataSource feature gate is enabled, dataSource contents will be copied to dataSourceRef,\nand dataSourceRef contents will be copied to dataSource when dataSourceRef.namespace is not specified.\nIf the namespace is specified, then dataSourceRef will not be copied to dataSource.";
        type = (types.nullOr StorageVolumeClaimTemplateSpecDataSourceModule);
        default = null;
      };
      "dataSourceRef" = mkOption {
        description = "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty\nvolume is desired. This may be any object from a non-empty API group (non\ncore object) or a PersistentVolumeClaim object.\nWhen this field is specified, volume binding will only succeed if the type of\nthe specified object matches some installed volume populator or dynamic\nprovisioner.\nThis field will replace the functionality of the dataSource field and as such\nif both fields are non-empty, they must have the same value. For backwards\ncompatibility, when namespace isn't specified in dataSourceRef,\nboth fields (dataSource and dataSourceRef) will be set to the same\nvalue automatically if one of them is empty and the other is non-empty.\nWhen namespace is specified in dataSourceRef,\ndataSource isn't set to the same value and must be empty.\nThere are three important differences between dataSource and dataSourceRef:\n* While dataSource only allows two specific types of objects, dataSourceRef\n  allows any non-core object, as well as PersistentVolumeClaim objects.\n* While dataSource ignores disallowed values (dropping them), dataSourceRef\n  preserves all values, and generates an error if a disallowed value is\n  specified.\n* While dataSource only allows local objects, dataSourceRef allows objects\n  in any namespaces.\n(Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled.\n(Alpha) Using the namespace field of dataSourceRef requires the CrossNamespaceVolumeDataSource feature gate to be enabled.";
        type = (types.nullOr StorageVolumeClaimTemplateSpecDataSourceRefModule);
        default = null;
      };
      "resources" = mkOption {
        description = "resources represents the minimum resources the volume should have.\nIf RecoverVolumeExpansionFailure feature is enabled users are allowed to specify resource requirements\nthat are lower than previous value but must still be higher than capacity recorded in the\nstatus field of the claim.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources";
        type = (types.nullOr StorageVolumeClaimTemplateSpecResourcesModule);
        default = null;
      };
      "selector" = mkOption {
        description = "selector is a label query over volumes to consider for binding.";
        type = (types.nullOr StorageVolumeClaimTemplateSpecSelectorModule);
        default = null;
      };
      "storageClassName" = mkOption {
        description = "storageClassName is the name of the StorageClass required by the claim.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeAttributesClassName" = mkOption {
        description = "volumeAttributesClassName may be used to set the VolumeAttributesClass used by this claim.\nIf specified, the CSI driver will create or update the volume with the attributes defined\nin the corresponding VolumeAttributesClass. This has a different purpose than storageClassName,\nit can be changed after the claim is created. An empty string value means that no VolumeAttributesClass\nwill be applied to the claim but it's not allowed to reset this field to empty string once it is set.\nIf unspecified and the PersistentVolumeClaim is unbound, the default VolumeAttributesClass\nwill be set by the persistentvolume controller if it exists.\nIf the resource referred to by volumeAttributesClass does not exist, this PersistentVolumeClaim will be\nset to a Pending state, as reflected by the modifyVolumeStatus field, until such as a resource\nexists.\nMore info: https://kubernetes.io/docs/concepts/storage/volume-attributes-classes/\n(Beta) Using this field requires the VolumeAttributesClass feature gate to be enabled (off by default).";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeMode" = mkOption {
        description = "volumeMode defines what type of volume is required by the claim.\nValue of Filesystem is implied when not included in claim spec.";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeName" = mkOption {
        description = "volumeName is the binding reference to the PersistentVolume backing this claim.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkStorageVolumeClaimTemplateSpec =
    res:
    {
    }
    // optionalAttrs (res."accessModes" != [ ]) { inherit (res) "accessModes"; }
    // {
    }
    // optionalAttrs (res."dataSource" != null) {
      "dataSource" = mkStorageVolumeClaimTemplateSpecDataSource res."dataSource";
    }
    // {
    }
    // optionalAttrs (res."dataSourceRef" != null) {
      "dataSourceRef" = mkStorageVolumeClaimTemplateSpecDataSourceRef res."dataSourceRef";
    }
    // {
    }
    // optionalAttrs (res."resources" != null) {
      "resources" = mkStorageVolumeClaimTemplateSpecResources res."resources";
    }
    // {
    }
    // optionalAttrs (res."selector" != null) {
      "selector" = mkStorageVolumeClaimTemplateSpecSelector res."selector";
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
  StorageVolumeClaimTemplateSpecResourcesModule = types.submodule {
    options = {
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
  mkStorageVolumeClaimTemplateSpecResources =
    res:
    {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  StorageVolumeClaimTemplateSpecSelectorMatchExpressionModule = types.submodule {
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
  mkStorageVolumeClaimTemplateSpecSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  StorageVolumeClaimTemplateSpecSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf StorageVolumeClaimTemplateSpecSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkStorageVolumeClaimTemplateSpecSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkStorageVolumeClaimTemplateSpecSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  StorageVolumeClaimTemplateStatusConditionModule = types.submodule {
    options = {
      "lastProbeTime" = mkOption {
        description = "lastProbeTime is the time we probed the condition.";
        type = (types.nullOr types.str);
        default = null;
      };
      "lastTransitionTime" = mkOption {
        description = "lastTransitionTime is the time the condition transitioned from one status to another.";
        type = (types.nullOr types.str);
        default = null;
      };
      "message" = mkOption {
        description = "message is the human-readable message indicating details about last transition.";
        type = (types.nullOr types.str);
        default = null;
      };
      "reason" = mkOption {
        description = "reason is a unique, this should be a short, machine understandable string that gives the reason\nfor condition's last transition. If it reports \"Resizing\" that means the underlying\npersistent volume is being resized.";
        type = (types.nullOr types.str);
        default = null;
      };
      "status" = mkOption {
        description = "Status is the status of the condition.\nCan be True, False, Unknown.\nMore info: https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/#:~:text=state%20of%20pvc-,conditions.status,-(string)%2C%20required";
        type = types.str;
      };
      "type" = mkOption {
        description = "Type is the type of the condition.\nMore info: https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/#:~:text=set%20to%20%27ResizeStarted%27.-,PersistentVolumeClaimCondition,-contains%20details%20about";
        type = types.str;
      };
    };
  };
  mkStorageVolumeClaimTemplateStatusCondition =
    res:
    {
    }
    // optionalAttrs (res."lastProbeTime" != null) { inherit (res) "lastProbeTime"; }
    // {
    }
    // optionalAttrs (res."lastTransitionTime" != null) { inherit (res) "lastTransitionTime"; }
    // {
    }
    // optionalAttrs (res."message" != null) { inherit (res) "message"; }
    // {
    }
    // optionalAttrs (res."reason" != null) { inherit (res) "reason"; }
    // {
      inherit (res) "status";
      inherit (res) "type";
    };
  StorageVolumeClaimTemplateStatusModifyVolumeStatusModule = types.submodule {
    options = {
      "status" = mkOption {
        description = "status is the status of the ControllerModifyVolume operation. It can be in any of following states:\n - Pending\n   Pending indicates that the PersistentVolumeClaim cannot be modified due to unmet requirements, such as\n   the specified VolumeAttributesClass not existing.\n - InProgress\n   InProgress indicates that the volume is being modified.\n - Infeasible\n  Infeasible indicates that the request has been rejected as invalid by the CSI driver. To\n\t  resolve the error, a valid VolumeAttributesClass needs to be specified.\nNote: New statuses can be added in the future. Consumers should check for unknown statuses and fail appropriately.";
        type = types.str;
      };
      "targetVolumeAttributesClassName" = mkOption {
        description = "targetVolumeAttributesClassName is the name of the VolumeAttributesClass the PVC currently being reconciled";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkStorageVolumeClaimTemplateStatusModifyVolumeStatus =
    res:
    {
      inherit (res) "status";
    }
    // optionalAttrs (res."targetVolumeAttributesClassName" != null) {
      inherit (res) "targetVolumeAttributesClassName";
    }
    // {
    };
  StorageVolumeClaimTemplateStatusModule = types.submodule {
    options = {
      "accessModes" = mkOption {
        description = "accessModes contains the actual access modes the volume backing the PVC has.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1";
        type = (types.listOf types.str);
        default = [ ];
      };
      "allocatedResourceStatuses" = mkOption {
        description = "allocatedResourceStatuses stores status of resource being resized for the given PVC.\nKey names follow standard Kubernetes label syntax. Valid values are either:\n\t* Un-prefixed keys:\n\t\t- storage - the capacity of the volume.\n\t* Custom resources must use implementation-defined prefixed names such as \"example.com/my-custom-resource\"\nApart from above values - keys that are unprefixed or have kubernetes.io prefix are considered\nreserved and hence may not be used.\n\nClaimResourceStatus can be in any of following states:\n\t- ControllerResizeInProgress:\n\t\tState set when resize controller starts resizing the volume in control-plane.\n\t- ControllerResizeFailed:\n\t\tState set when resize has failed in resize controller with a terminal error.\n\t- NodeResizePending:\n\t\tState set when resize controller has finished resizing the volume but further resizing of\n\t\tvolume is needed on the node.\n\t- NodeResizeInProgress:\n\t\tState set when kubelet starts resizing the volume.\n\t- NodeResizeFailed:\n\t\tState set when resizing has failed in kubelet with a terminal error. Transient errors don't set\n\t\tNodeResizeFailed.\nFor example: if expanding a PVC for more capacity - this field can be one of the following states:\n\t- pvc.status.allocatedResourceStatus['storage'] = \"ControllerResizeInProgress\"\n     - pvc.status.allocatedResourceStatus['storage'] = \"ControllerResizeFailed\"\n     - pvc.status.allocatedResourceStatus['storage'] = \"NodeResizePending\"\n     - pvc.status.allocatedResourceStatus['storage'] = \"NodeResizeInProgress\"\n     - pvc.status.allocatedResourceStatus['storage'] = \"NodeResizeFailed\"\nWhen this field is not set, it means that no resize operation is in progress for the given PVC.\n\nA controller that receives PVC update with previously unknown resourceName or ClaimResourceStatus\nshould ignore the update for the purpose it was designed. For example - a controller that\nonly is responsible for resizing capacity of the volume, should ignore PVC updates that change other valid\nresources associated with PVC.\n\nThis is an alpha field and requires enabling RecoverVolumeExpansionFailure feature.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "allocatedResources" = mkOption {
        description = "allocatedResources tracks the resources allocated to a PVC including its capacity.\nKey names follow standard Kubernetes label syntax. Valid values are either:\n\t* Un-prefixed keys:\n\t\t- storage - the capacity of the volume.\n\t* Custom resources must use implementation-defined prefixed names such as \"example.com/my-custom-resource\"\nApart from above values - keys that are unprefixed or have kubernetes.io prefix are considered\nreserved and hence may not be used.\n\nCapacity reported here may be larger than the actual capacity when a volume expansion operation\nis requested.\nFor storage quota, the larger value from allocatedResources and PVC.spec.resources is used.\nIf allocatedResources is not set, PVC.spec.resources alone is used for quota calculation.\nIf a volume expansion capacity request is lowered, allocatedResources is only\nlowered if there are no expansion operations in progress and if the actual volume capacity\nis equal or lower than the requested capacity.\n\nA controller that receives PVC update with previously unknown resourceName\nshould ignore the update for the purpose it was designed. For example - a controller that\nonly is responsible for resizing capacity of the volume, should ignore PVC updates that change other valid\nresources associated with PVC.\n\nThis is an alpha field and requires enabling RecoverVolumeExpansionFailure feature.";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "capacity" = mkOption {
        description = "capacity represents the actual resources of the underlying volume.";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "conditions" = mkOption {
        description = "conditions is the current Condition of persistent volume claim. If underlying persistent volume is being\nresized then the Condition will be set to 'Resizing'.";
        type = (types.listOf StorageVolumeClaimTemplateStatusConditionModule);
        default = [ ];
      };
      "currentVolumeAttributesClassName" = mkOption {
        description = "currentVolumeAttributesClassName is the current name of the VolumeAttributesClass the PVC is using.\nWhen unset, there is no VolumeAttributeClass applied to this PersistentVolumeClaim\nThis is a beta field and requires enabling VolumeAttributesClass feature (off by default).";
        type = (types.nullOr types.str);
        default = null;
      };
      "modifyVolumeStatus" = mkOption {
        description = "ModifyVolumeStatus represents the status object of ControllerModifyVolume operation.\nWhen this is unset, there is no ModifyVolume operation being attempted.\nThis is a beta field and requires enabling VolumeAttributesClass feature (off by default).";
        type = (types.nullOr StorageVolumeClaimTemplateStatusModifyVolumeStatusModule);
        default = null;
      };
      "phase" = mkOption {
        description = "phase represents the current phase of PersistentVolumeClaim.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkStorageVolumeClaimTemplateStatus =
    res:
    {
    }
    // optionalAttrs (res."accessModes" != [ ]) { inherit (res) "accessModes"; }
    // {
    }
    // optionalAttrs (res."allocatedResourceStatuses" != { }) {
      inherit (res) "allocatedResourceStatuses";
    }
    // {
    }
    // optionalAttrs (res."allocatedResources" != { }) { inherit (res) "allocatedResources"; }
    // {
    }
    // optionalAttrs (res."capacity" != { }) { inherit (res) "capacity"; }
    // {
    }
    // optionalAttrs (res."conditions" != [ ]) {
      "conditions" = map mkStorageVolumeClaimTemplateStatusCondition res."conditions";
    }
    // {
    }
    // optionalAttrs (res."currentVolumeAttributesClassName" != null) {
      inherit (res) "currentVolumeAttributesClassName";
    }
    // {
    }
    // optionalAttrs (res."modifyVolumeStatus" != null) {
      "modifyVolumeStatus" =
        mkStorageVolumeClaimTemplateStatusModifyVolumeStatus
          res."modifyVolumeStatus";
    }
    // {
    }
    // optionalAttrs (res."phase" != null) { inherit (res) "phase"; }
    // {
    };
  TolerationModule = types.submodule {
    options = {
      "effect" = mkOption {
        description = "Effect indicates the taint effect to match. Empty means match all taint effects.\nWhen specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute.";
        type = (types.nullOr types.str);
        default = null;
      };
      "key" = mkOption {
        description = "Key is the taint key that the toleration applies to. Empty means match all taint keys.\nIf the key is empty, operator must be Exists; this combination means to match all values and all keys.";
        type = (types.nullOr types.str);
        default = null;
      };
      "operator" = mkOption {
        description = "Operator represents a key's relationship to the value.\nValid operators are Exists and Equal. Defaults to Equal.\nExists is equivalent to wildcard for value, so that a pod can\ntolerate all taints of a particular category.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tolerationSeconds" = mkOption {
        description = "TolerationSeconds represents the period of time the toleration (which must be\nof effect NoExecute, otherwise this field is ignored) tolerates the taint. By default,\nit is not set, which means tolerate the taint forever (do not evict). Zero and\nnegative values will be treated as 0 (evict immediately) by the system.";
        type = (types.nullOr types.int);
        default = null;
      };
      "value" = mkOption {
        description = "Value is the taint value the toleration matches to.\nIf the operator is Exists, the value should be empty, otherwise just a regular string.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkToleration =
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
  TopologySpreadConstraintLabelSelectorMatchExpressionModule = types.submodule {
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
  mkTopologySpreadConstraintLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  TopologySpreadConstraintLabelSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf TopologySpreadConstraintLabelSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkTopologySpreadConstraintLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkTopologySpreadConstraintLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  TopologySpreadConstraintModule = types.submodule {
    options = {
      "additionalLabelSelectors" = mkOption {
        description = "Defines what Prometheus Operator managed labels should be added to labelSelector on the topologySpreadConstraint.";
        type = (
          types.nullOr (
            types.enum [
              "OnResource"
              "OnShard"
            ]
          )
        );
        default = null;
      };
      "labelSelector" = mkOption {
        description = "LabelSelector is used to find matching pods.\nPods that match this label selector are counted to determine the number of pods\nin their corresponding topology domain.";
        type = (types.nullOr TopologySpreadConstraintLabelSelectorModule);
        default = null;
      };
      "matchLabelKeys" = mkOption {
        description = "MatchLabelKeys is a set of pod label keys to select the pods over which\nspreading will be calculated. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are ANDed with labelSelector\nto select the group of existing pods over which spreading will be calculated\nfor the incoming pod. The same key is forbidden to exist in both MatchLabelKeys and LabelSelector.\nMatchLabelKeys cannot be set when LabelSelector isn't set.\nKeys that don't exist in the incoming pod labels will\nbe ignored. A null or empty list means only match against labelSelector.\n\nThis is a beta field and requires the MatchLabelKeysInPodTopologySpread feature gate to be enabled (enabled by default).";
        type = (types.listOf types.str);
        default = [ ];
      };
      "maxSkew" = mkOption {
        description = "MaxSkew describes the degree to which pods may be unevenly distributed.\nWhen `whenUnsatisfiable=DoNotSchedule`, it is the maximum permitted difference\nbetween the number of matching pods in the target topology and the global minimum.\nThe global minimum is the minimum number of matching pods in an eligible domain\nor zero if the number of eligible domains is less than MinDomains.\nFor example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same\nlabelSelector spread as 2/2/1:\nIn this case, the global minimum is 1.\n| zone1 | zone2 | zone3 |\n|  P P  |  P P  |   P   |\n- if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 2/2/2;\nscheduling it onto zone1(zone2) would make the ActualSkew(3-1) on zone1(zone2)\nviolate MaxSkew(1).\n- if MaxSkew is 2, incoming pod can be scheduled onto any zone.\nWhen `whenUnsatisfiable=ScheduleAnyway`, it is used to give higher precedence\nto topologies that satisfy it.\nIt's a required field. Default value is 1 and 0 is not allowed.";
        type = types.int;
      };
      "minDomains" = mkOption {
        description = "MinDomains indicates a minimum number of eligible domains.\nWhen the number of eligible domains with matching topology keys is less than minDomains,\nPod Topology Spread treats \"global minimum\" as 0, and then the calculation of Skew is performed.\nAnd when the number of eligible domains with matching topology keys equals or greater than minDomains,\nthis value has no effect on scheduling.\nAs a result, when the number of eligible domains is less than minDomains,\nscheduler won't schedule more than maxSkew Pods to those domains.\nIf value is nil, the constraint behaves as if MinDomains is equal to 1.\nValid values are integers greater than 0.\nWhen value is not nil, WhenUnsatisfiable must be DoNotSchedule.\n\nFor example, in a 3-zone cluster, MaxSkew is set to 2, MinDomains is set to 5 and pods with the same\nlabelSelector spread as 2/2/2:\n| zone1 | zone2 | zone3 |\n|  P P  |  P P  |  P P  |\nThe number of domains is less than 5(MinDomains), so \"global minimum\" is treated as 0.\nIn this situation, new pod with the same labelSelector cannot be scheduled,\nbecause computed skew will be 3(3 - 0) if new Pod is scheduled to any of the three zones,\nit will violate MaxSkew.";
        type = (types.nullOr types.int);
        default = null;
      };
      "nodeAffinityPolicy" = mkOption {
        description = "NodeAffinityPolicy indicates how we will treat Pod's nodeAffinity/nodeSelector\nwhen calculating pod topology spread skew. Options are:\n- Honor: only nodes matching nodeAffinity/nodeSelector are included in the calculations.\n- Ignore: nodeAffinity/nodeSelector are ignored. All nodes are included in the calculations.\n\nIf this value is nil, the behavior is equivalent to the Honor policy.";
        type = (types.nullOr types.str);
        default = null;
      };
      "nodeTaintsPolicy" = mkOption {
        description = "NodeTaintsPolicy indicates how we will treat node taints when calculating\npod topology spread skew. Options are:\n- Honor: nodes without taints, along with tainted nodes for which the incoming pod\nhas a toleration, are included.\n- Ignore: node taints are ignored. All nodes are included.\n\nIf this value is nil, the behavior is equivalent to the Ignore policy.";
        type = (types.nullOr types.str);
        default = null;
      };
      "topologyKey" = mkOption {
        description = "TopologyKey is the key of node labels. Nodes that have a label with this key\nand identical values are considered to be in the same topology.\nWe consider each <key, value> as a \"bucket\", and try to put balanced number\nof pods into each bucket.\nWe define a domain as a particular instance of a topology.\nAlso, we define an eligible domain as a domain whose nodes meet the requirements of\nnodeAffinityPolicy and nodeTaintsPolicy.\ne.g. If TopologyKey is \"kubernetes.io/hostname\", each Node is a domain of that topology.\nAnd, if TopologyKey is \"topology.kubernetes.io/zone\", each zone is a domain of that topology.\nIt's a required field.";
        type = types.str;
      };
      "whenUnsatisfiable" = mkOption {
        description = "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy\nthe spread constraint.\n- DoNotSchedule (default) tells the scheduler not to schedule it.\n- ScheduleAnyway tells the scheduler to schedule the pod in any location,\n  but giving higher precedence to topologies that would help reduce the\n  skew.\nA constraint is considered \"Unsatisfiable\" for an incoming pod\nif and only if every possible node assignment for that pod would violate\n\"MaxSkew\" on some topology.\nFor example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same\nlabelSelector spread as 3/1/1:\n| zone1 | zone2 | zone3 |\n| P P P |   P   |   P   |\nIf WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled\nto zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies\nMaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler\nwon't make it *more* imbalanced.\nIt's a required field.";
        type = types.str;
      };
    };
  };
  mkTopologySpreadConstraint =
    res:
    {
    }
    // optionalAttrs (res."additionalLabelSelectors" != null) {
      inherit (res) "additionalLabelSelectors";
    }
    // {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" = mkTopologySpreadConstraintLabelSelector res."labelSelector";
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
  TracingConfigModule = types.submodule {
    options = {
      "clientType" = mkOption {
        description = "Client used to export the traces. Supported values are `http` or `grpc`.";
        type = (
          types.nullOr (
            types.enum [
              "http"
              "grpc"
            ]
          )
        );
        default = null;
      };
      "compression" = mkOption {
        description = "Compression key for supported compression types. The only supported value is `gzip`.";
        type = (types.nullOr (types.enum [ "gzip" ]));
        default = null;
      };
      "endpoint" = mkOption {
        description = "Endpoint to send the traces to. Should be provided in format <host>:<port>.";
        type = types.str;
      };
      "headers" = mkOption {
        description = "Key-value pairs to be used as headers associated with gRPC or HTTP requests.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "insecure" = mkOption {
        description = "If disabled, the client will use a secure connection.";
        type = types.bool;
        default = false;
      };
      "samplingFraction" = mkOption {
        description = "Sets the probability a given trace will be sampled. Must be a float from 0 through 1.";
        type = types.anything;
        default = { };
      };
      "timeout" = mkOption {
        description = "Maximum time the exporter will wait for each batch export.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS Config to use when sending traces.";
        type = (types.nullOr TracingConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkTracingConfig =
    res:
    {
    }
    // optionalAttrs (res."clientType" != null) { inherit (res) "clientType"; }
    // {
    }
    // optionalAttrs (res."compression" != null) { inherit (res) "compression"; }
    // {
      inherit (res) "endpoint";
    }
    // optionalAttrs (res."headers" != { }) { inherit (res) "headers"; }
    // {
    }
    // optionalAttrs res."insecure" { inherit (res) "insecure"; }
    // {
    }
    // optionalAttrs (res."samplingFraction" != null) { inherit (res) "samplingFraction"; }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkTracingConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  TracingConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkTracingConfigTlsConfigCaConfigMap =
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
  TracingConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr TracingConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr TracingConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkTracingConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkTracingConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkTracingConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  TracingConfigTlsConfigCaSecretModule = types.submodule {
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
  mkTracingConfigTlsConfigCaSecret =
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
  TracingConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkTracingConfigTlsConfigCertConfigMap =
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
  TracingConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr TracingConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr TracingConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkTracingConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkTracingConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkTracingConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  TracingConfigTlsConfigCertSecretModule = types.submodule {
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
  mkTracingConfigTlsConfigCertSecret =
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
  TracingConfigTlsConfigKeySecretModule = types.submodule {
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
  mkTracingConfigTlsConfigKeySecret =
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
  TracingConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr TracingConfigTlsConfigCaModule);
        default = null;
      };
      "caFile" = mkOption {
        description = "Path to the CA cert in the Prometheus container to use for the targets.";
        type = (types.nullOr types.str);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr TracingConfigTlsConfigCertModule);
        default = null;
      };
      "certFile" = mkOption {
        description = "Path to the client cert file in the Prometheus container for the targets.";
        type = (types.nullOr types.str);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keyFile" = mkOption {
        description = "Path to the client key file in the Prometheus container for the targets.";
        type = (types.nullOr types.str);
        default = null;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr TracingConfigTlsConfigKeySecretModule);
        default = null;
      };
      "maxVersion" = mkOption {
        description = "Maximum acceptable TLS version.\n\nIt requires Prometheus >= v2.41.0 or Thanos >= v0.31.0.";
        type = (
          types.nullOr (
            types.enum [
              "TLS10"
              "TLS11"
              "TLS12"
              "TLS13"
            ]
          )
        );
        default = null;
      };
      "minVersion" = mkOption {
        description = "Minimum acceptable TLS version.\n\nIt requires Prometheus >= v2.35.0 or Thanos >= v0.28.0.";
        type = (
          types.nullOr (
            types.enum [
              "TLS10"
              "TLS11"
              "TLS12"
              "TLS13"
            ]
          )
        );
        default = null;
      };
      "serverName" = mkOption {
        description = "Used to verify the hostname for the targets.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTracingConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkTracingConfigTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."caFile" != null) { inherit (res) "caFile"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkTracingConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs (res."certFile" != null) { inherit (res) "certFile"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keyFile" != null) { inherit (res) "keyFile"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkTracingConfigTlsConfigKeySecret res."keySecret";
    }
    // {
    }
    // optionalAttrs (res."maxVersion" != null) { inherit (res) "maxVersion"; }
    // {
    }
    // optionalAttrs (res."minVersion" != null) { inherit (res) "minVersion"; }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    };
  TsdbModule = types.submodule {
    options = {
      "outOfOrderTimeWindow" = mkOption {
        description = "Configures how old an out-of-order/out-of-bounds sample can be with\nrespect to the TSDB max time.\n\nAn out-of-order/out-of-bounds sample is ingested into the TSDB as long as\nthe timestamp of the sample is >= (TSDB.MaxTime - outOfOrderTimeWindow).\n\nThis is an *experimental feature*, it may change in any upcoming release\nin a breaking way.\n\nIt requires Prometheus >= v2.39.0 or PrometheusAgent >= v2.54.0.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTsdb =
    res:
    {
    }
    // optionalAttrs (res."outOfOrderTimeWindow" != null) { inherit (res) "outOfOrderTimeWindow"; }
    // {
    };
  VolumeAwsElasticBlockStoreModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is the filesystem type of the volume that you want to mount.\nTip: Ensure that the filesystem type is supported by the host operating system.\nExamples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore";
        type = (types.nullOr types.str);
        default = null;
      };
      "partition" = mkOption {
        description = "partition is the partition in the volume that you want to mount.\nIf omitted, the default is to mount by volume name.\nExamples: For volume /dev/sda1, you specify the partition as \"1\".\nSimilarly, the volume partition for /dev/sda is \"0\" (or you can leave the property empty).";
        type = (types.nullOr types.int);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly value true will force the readOnly setting in VolumeMounts.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore";
        type = types.bool;
        default = false;
      };
      "volumeID" = mkOption {
        description = "volumeID is unique ID of the persistent disk resource in AWS (Amazon EBS volume).\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore";
        type = types.str;
      };
    };
  };
  mkVolumeAwsElasticBlockStore =
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
  VolumeAzureDiskModule = types.submodule {
    options = {
      "cachingMode" = mkOption {
        description = "cachingMode is the Host Caching mode: None, Read Only, Read Write.";
        type = (types.nullOr types.str);
        default = null;
      };
      "diskName" = mkOption {
        description = "diskName is the Name of the data disk in the blob storage";
        type = types.str;
      };
      "diskURI" = mkOption {
        description = "diskURI is the URI of data disk in the blob storage";
        type = types.str;
      };
      "fsType" = mkOption {
        description = "fsType is Filesystem type to mount.\nMust be a filesystem type supported by the host operating system.\nEx. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.";
        type = (types.nullOr types.str);
        default = "ext4";
      };
      "kind" = mkOption {
        description = "kind expected values are Shared: multiple blob disks per storage account  Dedicated: single blob disk per storage account  Managed: azure managed data disk (only in managed availability set). defaults to shared";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly Defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkVolumeAzureDisk =
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
  VolumeAzureFileModule = types.submodule {
    options = {
      "readOnly" = mkOption {
        description = "readOnly defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.";
        type = types.bool;
        default = false;
      };
      "secretName" = mkOption {
        description = "secretName is the  name of secret that contains Azure Storage Account Name and Key";
        type = types.str;
      };
      "shareName" = mkOption {
        description = "shareName is the azure share Name";
        type = types.str;
      };
    };
  };
  mkVolumeAzureFile =
    res:
    {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
      inherit (res) "secretName";
      inherit (res) "shareName";
    };
  VolumeCephfsModule = types.submodule {
    options = {
      "monitors" = mkOption {
        description = "monitors is Required: Monitors is a collection of Ceph monitors\nMore info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it";
        type = (types.listOf types.str);
      };
      "path" = mkOption {
        description = "path is Optional: Used as the mounted root, rather than the full Ceph tree, default is /";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly is Optional: Defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.\nMore info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it";
        type = types.bool;
        default = false;
      };
      "secretFile" = mkOption {
        description = "secretFile is Optional: SecretFile is the path to key ring for User, default is /etc/ceph/user.secret\nMore info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it";
        type = (types.nullOr types.str);
        default = null;
      };
      "secretRef" = mkOption {
        description = "secretRef is Optional: SecretRef is reference to the authentication secret for User, default is empty.\nMore info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it";
        type = (types.nullOr VolumeCephfsSecretRefModule);
        default = null;
      };
      "user" = mkOption {
        description = "user is optional: User is the rados user name, default is admin\nMore info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkVolumeCephfs =
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
      "secretRef" = mkVolumeCephfsSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."user" != null) { inherit (res) "user"; }
    // {
    };
  VolumeCephfsSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkVolumeCephfsSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  VolumeCinderModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is the filesystem type to mount.\nMust be a filesystem type supported by the host operating system.\nExamples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.\nMore info: https://examples.k8s.io/mysql-cinder-pd/README.md";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.\nMore info: https://examples.k8s.io/mysql-cinder-pd/README.md";
        type = types.bool;
        default = false;
      };
      "secretRef" = mkOption {
        description = "secretRef is optional: points to a secret object containing parameters used to connect\nto OpenStack.";
        type = (types.nullOr VolumeCinderSecretRefModule);
        default = null;
      };
      "volumeID" = mkOption {
        description = "volumeID used to identify the volume in cinder.\nMore info: https://examples.k8s.io/mysql-cinder-pd/README.md";
        type = types.str;
      };
    };
  };
  mkVolumeCinder =
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
      "secretRef" = mkVolumeCinderSecretRef res."secretRef";
    }
    // {
      inherit (res) "volumeID";
    };
  VolumeCinderSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkVolumeCinderSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  VolumeConfigMapItemModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the key to project.";
        type = types.str;
      };
      "mode" = mkOption {
        description = "mode is Optional: mode bits used to set permissions on this file.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nIf not specified, the volume defaultMode will be used.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        description = "path is the relative path of the file to map the key to.\nMay not be an absolute path.\nMay not contain the path element '..'.\nMay not start with the string '..'.";
        type = types.str;
      };
    };
  };
  mkVolumeConfigMapItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    };
  VolumeConfigMapModule = types.submodule {
    options = {
      "defaultMode" = mkOption {
        description = "defaultMode is optional: mode bits used to set permissions on created files by default.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nDefaults to 0644.\nDirectories within the path are not affected by this setting.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "items" = mkOption {
        description = "items if unspecified, each key-value pair in the Data field of the referenced\nConfigMap will be projected into the volume as a file whose name is the\nkey and content is the value. If specified, the listed keys will be\nprojected into the specified paths, and unlisted keys will not be\npresent. If a key is specified which is not present in the ConfigMap,\nthe volume setup will error unless it is marked optional. Paths must be\nrelative and may not contain the '..' path or start with '..'.";
        type = (types.listOf VolumeConfigMapItemModule);
        default = [ ];
      };
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "optional specify whether the ConfigMap or its keys must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkVolumeConfigMap =
    res:
    {
    }
    // optionalAttrs (res."defaultMode" != null) { inherit (res) "defaultMode"; }
    // {
    }
    // optionalAttrs (res."items" != [ ]) { "items" = map mkVolumeConfigMapItem res."items"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  VolumeCsiModule = types.submodule {
    options = {
      "driver" = mkOption {
        description = "driver is the name of the CSI driver that handles this volume.\nConsult with your admin for the correct name as registered in the cluster.";
        type = types.str;
      };
      "fsType" = mkOption {
        description = "fsType to mount. Ex. \"ext4\", \"xfs\", \"ntfs\".\nIf not provided, the empty value is passed to the associated CSI driver\nwhich will determine the default filesystem to apply.";
        type = (types.nullOr types.str);
        default = null;
      };
      "nodePublishSecretRef" = mkOption {
        description = "nodePublishSecretRef is a reference to the secret object containing\nsensitive information to pass to the CSI driver to complete the CSI\nNodePublishVolume and NodeUnpublishVolume calls.\nThis field is optional, and  may be empty if no secret is required. If the\nsecret object contains more than one secret, all secret references are passed.";
        type = (types.nullOr VolumeCsiNodePublishSecretRefModule);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly specifies a read-only configuration for the volume.\nDefaults to false (read/write).";
        type = types.bool;
        default = false;
      };
      "volumeAttributes" = mkOption {
        description = "volumeAttributes stores driver-specific properties that are passed to the CSI\ndriver. Consult your driver's documentation for supported values.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkVolumeCsi =
    res:
    {
      inherit (res) "driver";
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."nodePublishSecretRef" != null) {
      "nodePublishSecretRef" = mkVolumeCsiNodePublishSecretRef res."nodePublishSecretRef";
    }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."volumeAttributes" != { }) { inherit (res) "volumeAttributes"; }
    // {
    };
  VolumeCsiNodePublishSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkVolumeCsiNodePublishSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  VolumeDownwardAPIItemFieldRefModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        description = "Version of the schema the FieldPath is written in terms of, defaults to \"v1\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "fieldPath" = mkOption {
        description = "Path of the field to select in the specified API version.";
        type = types.str;
      };
    };
  };
  mkVolumeDownwardAPIItemFieldRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "fieldPath";
    };
  VolumeDownwardAPIItemModule = types.submodule {
    options = {
      "fieldRef" = mkOption {
        description = "Required: Selects a field of the pod: only annotations, labels, name, namespace and uid are supported.";
        type = (types.nullOr VolumeDownwardAPIItemFieldRefModule);
        default = null;
      };
      "mode" = mkOption {
        description = "Optional: mode bits used to set permissions on this file, must be an octal value\nbetween 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nIf not specified, the volume defaultMode will be used.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        description = "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'";
        type = types.str;
      };
      "resourceFieldRef" = mkOption {
        description = "Selects a resource of the container: only resources limits and requests\n(limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported.";
        type = (types.nullOr VolumeDownwardAPIItemResourceFieldRefModule);
        default = null;
      };
    };
  };
  mkVolumeDownwardAPIItem =
    res:
    {
    }
    // optionalAttrs (res."fieldRef" != null) {
      "fieldRef" = mkVolumeDownwardAPIItemFieldRef res."fieldRef";
    }
    // {
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    }
    // optionalAttrs (res."resourceFieldRef" != null) {
      "resourceFieldRef" = mkVolumeDownwardAPIItemResourceFieldRef res."resourceFieldRef";
    }
    // {
    };
  VolumeDownwardAPIItemResourceFieldRefModule = types.submodule {
    options = {
      "containerName" = mkOption {
        description = "Container name: required for volumes, optional for env vars";
        type = (types.nullOr types.str);
        default = null;
      };
      "divisor" = mkOption {
        description = "Specifies the output format of the exposed resources, defaults to \"1\"";
        type = types.anything;
        default = { };
      };
      "resource" = mkOption {
        description = "Required: resource to select";
        type = types.str;
      };
    };
  };
  mkVolumeDownwardAPIItemResourceFieldRef =
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
  VolumeDownwardAPIModule = types.submodule {
    options = {
      "defaultMode" = mkOption {
        description = "Optional: mode bits to use on created files by default. Must be a\nOptional: mode bits used to set permissions on created files by default.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nDefaults to 0644.\nDirectories within the path are not affected by this setting.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "items" = mkOption {
        description = "Items is a list of downward API volume file";
        type = (types.listOf VolumeDownwardAPIItemModule);
        default = [ ];
      };
    };
  };
  mkVolumeDownwardAPI =
    res:
    {
    }
    // optionalAttrs (res."defaultMode" != null) { inherit (res) "defaultMode"; }
    // {
    }
    // optionalAttrs (res."items" != [ ]) { "items" = map mkVolumeDownwardAPIItem res."items"; }
    // {
    };
  VolumeEmptyDirModule = types.submodule {
    options = {
      "medium" = mkOption {
        description = "medium represents what type of storage medium should back this directory.\nThe default is \"\" which means to use the node's default medium.\nMust be an empty string (default) or Memory.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir";
        type = (types.nullOr types.str);
        default = null;
      };
      "sizeLimit" = mkOption {
        description = "sizeLimit is the total amount of local storage required for this EmptyDir volume.\nThe size limit is also applicable for memory medium.\nThe maximum usage on memory medium EmptyDir would be the minimum value between\nthe SizeLimit specified here and the sum of memory limits of all containers in a pod.\nThe default is nil which means that the limit is undefined.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir";
        type = types.anything;
        default = { };
      };
    };
  };
  mkVolumeEmptyDir =
    res:
    {
    }
    // optionalAttrs (res."medium" != null) { inherit (res) "medium"; }
    // {
    }
    // optionalAttrs (res."sizeLimit" != null) { inherit (res) "sizeLimit"; }
    // {
    };
  VolumeEphemeralModule = types.submodule {
    options = {
      "volumeClaimTemplate" = mkOption {
        description = "Will be used to create a stand-alone PVC to provision the volume.\nThe pod in which this EphemeralVolumeSource is embedded will be the\nowner of the PVC, i.e. the PVC will be deleted together with the\npod.  The name of the PVC will be `<pod name>-<volume name>` where\n`<volume name>` is the name from the `PodSpec.Volumes` array\nentry. Pod validation will reject the pod if the concatenated name\nis not valid for a PVC (for example, too long).\n\nAn existing PVC with that name that is not owned by the pod\nwill *not* be used for the pod to avoid using an unrelated\nvolume by mistake. Starting the pod is then blocked until\nthe unrelated PVC is removed. If such a pre-created PVC is\nmeant to be used by the pod, the PVC has to updated with an\nowner reference to the pod once the pod exists. Normally\nthis should not be necessary, but it may be useful when\nmanually reconstructing a broken cluster.\n\nThis field is read-only and no changes will be made by Kubernetes\nto the PVC after it has been created.\n\nRequired, must not be nil.";
        type = (types.nullOr VolumeEphemeralVolumeClaimTemplateModule);
        default = null;
      };
    };
  };
  mkVolumeEphemeral =
    res:
    {
    }
    // optionalAttrs (res."volumeClaimTemplate" != null) {
      "volumeClaimTemplate" = mkVolumeEphemeralVolumeClaimTemplate res."volumeClaimTemplate";
    }
    // {
    };
  VolumeEphemeralVolumeClaimTemplateModule = types.submodule {
    options = {
      "metadata" = mkOption {
        description = "May contain labels and annotations that will be copied into the PVC\nwhen creating it. No other fields are allowed and will be rejected during\nvalidation.";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "spec" = mkOption {
        description = "The specification for the PersistentVolumeClaim. The entire content is\ncopied unchanged into the PVC that gets created from this\ntemplate. The same fields as in a PersistentVolumeClaim\nare also valid here.";
        type = VolumeEphemeralVolumeClaimTemplateSpecModule;
      };
    };
  };
  mkVolumeEphemeralVolumeClaimTemplate =
    res:
    {
    }
    // optionalAttrs (res."metadata" != { }) { inherit (res) "metadata"; }
    // {
      "spec" = mkVolumeEphemeralVolumeClaimTemplateSpec res."spec";
    };
  VolumeEphemeralVolumeClaimTemplateSpecDataSourceModule = types.submodule {
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
  mkVolumeEphemeralVolumeClaimTemplateSpecDataSource =
    res:
    {
    }
    // optionalAttrs (res."apiGroup" != null) { inherit (res) "apiGroup"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    };
  VolumeEphemeralVolumeClaimTemplateSpecDataSourceRefModule = types.submodule {
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
      "namespace" = mkOption {
        description = "Namespace is the namespace of resource being referenced\nNote that when a namespace is specified, a gateway.networking.k8s.io/ReferenceGrant object is required in the referent namespace to allow that namespace's owner to accept the reference. See the ReferenceGrant documentation for details.\n(Alpha) This field requires the CrossNamespaceVolumeDataSource feature gate to be enabled.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkVolumeEphemeralVolumeClaimTemplateSpecDataSourceRef =
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
  VolumeEphemeralVolumeClaimTemplateSpecModule = types.submodule {
    options = {
      "accessModes" = mkOption {
        description = "accessModes contains the desired access modes the volume should have.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1";
        type = (types.listOf types.str);
        default = [ ];
      };
      "dataSource" = mkOption {
        description = "dataSource field can be used to specify either:\n* An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot)\n* An existing PVC (PersistentVolumeClaim)\nIf the provisioner or an external controller can support the specified data source,\nit will create a new volume based on the contents of the specified data source.\nWhen the AnyVolumeDataSource feature gate is enabled, dataSource contents will be copied to dataSourceRef,\nand dataSourceRef contents will be copied to dataSource when dataSourceRef.namespace is not specified.\nIf the namespace is specified, then dataSourceRef will not be copied to dataSource.";
        type = (types.nullOr VolumeEphemeralVolumeClaimTemplateSpecDataSourceModule);
        default = null;
      };
      "dataSourceRef" = mkOption {
        description = "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty\nvolume is desired. This may be any object from a non-empty API group (non\ncore object) or a PersistentVolumeClaim object.\nWhen this field is specified, volume binding will only succeed if the type of\nthe specified object matches some installed volume populator or dynamic\nprovisioner.\nThis field will replace the functionality of the dataSource field and as such\nif both fields are non-empty, they must have the same value. For backwards\ncompatibility, when namespace isn't specified in dataSourceRef,\nboth fields (dataSource and dataSourceRef) will be set to the same\nvalue automatically if one of them is empty and the other is non-empty.\nWhen namespace is specified in dataSourceRef,\ndataSource isn't set to the same value and must be empty.\nThere are three important differences between dataSource and dataSourceRef:\n* While dataSource only allows two specific types of objects, dataSourceRef\n  allows any non-core object, as well as PersistentVolumeClaim objects.\n* While dataSource ignores disallowed values (dropping them), dataSourceRef\n  preserves all values, and generates an error if a disallowed value is\n  specified.\n* While dataSource only allows local objects, dataSourceRef allows objects\n  in any namespaces.\n(Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled.\n(Alpha) Using the namespace field of dataSourceRef requires the CrossNamespaceVolumeDataSource feature gate to be enabled.";
        type = (types.nullOr VolumeEphemeralVolumeClaimTemplateSpecDataSourceRefModule);
        default = null;
      };
      "resources" = mkOption {
        description = "resources represents the minimum resources the volume should have.\nIf RecoverVolumeExpansionFailure feature is enabled users are allowed to specify resource requirements\nthat are lower than previous value but must still be higher than capacity recorded in the\nstatus field of the claim.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources";
        type = (types.nullOr VolumeEphemeralVolumeClaimTemplateSpecResourcesModule);
        default = null;
      };
      "selector" = mkOption {
        description = "selector is a label query over volumes to consider for binding.";
        type = (types.nullOr VolumeEphemeralVolumeClaimTemplateSpecSelectorModule);
        default = null;
      };
      "storageClassName" = mkOption {
        description = "storageClassName is the name of the StorageClass required by the claim.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeAttributesClassName" = mkOption {
        description = "volumeAttributesClassName may be used to set the VolumeAttributesClass used by this claim.\nIf specified, the CSI driver will create or update the volume with the attributes defined\nin the corresponding VolumeAttributesClass. This has a different purpose than storageClassName,\nit can be changed after the claim is created. An empty string value means that no VolumeAttributesClass\nwill be applied to the claim but it's not allowed to reset this field to empty string once it is set.\nIf unspecified and the PersistentVolumeClaim is unbound, the default VolumeAttributesClass\nwill be set by the persistentvolume controller if it exists.\nIf the resource referred to by volumeAttributesClass does not exist, this PersistentVolumeClaim will be\nset to a Pending state, as reflected by the modifyVolumeStatus field, until such as a resource\nexists.\nMore info: https://kubernetes.io/docs/concepts/storage/volume-attributes-classes/\n(Beta) Using this field requires the VolumeAttributesClass feature gate to be enabled (off by default).";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeMode" = mkOption {
        description = "volumeMode defines what type of volume is required by the claim.\nValue of Filesystem is implied when not included in claim spec.";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeName" = mkOption {
        description = "volumeName is the binding reference to the PersistentVolume backing this claim.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkVolumeEphemeralVolumeClaimTemplateSpec =
    res:
    {
    }
    // optionalAttrs (res."accessModes" != [ ]) { inherit (res) "accessModes"; }
    // {
    }
    // optionalAttrs (res."dataSource" != null) {
      "dataSource" = mkVolumeEphemeralVolumeClaimTemplateSpecDataSource res."dataSource";
    }
    // {
    }
    // optionalAttrs (res."dataSourceRef" != null) {
      "dataSourceRef" = mkVolumeEphemeralVolumeClaimTemplateSpecDataSourceRef res."dataSourceRef";
    }
    // {
    }
    // optionalAttrs (res."resources" != null) {
      "resources" = mkVolumeEphemeralVolumeClaimTemplateSpecResources res."resources";
    }
    // {
    }
    // optionalAttrs (res."selector" != null) {
      "selector" = mkVolumeEphemeralVolumeClaimTemplateSpecSelector res."selector";
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
  VolumeEphemeralVolumeClaimTemplateSpecResourcesModule = types.submodule {
    options = {
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
  mkVolumeEphemeralVolumeClaimTemplateSpecResources =
    res:
    {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  VolumeEphemeralVolumeClaimTemplateSpecSelectorMatchExpressionModule = types.submodule {
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
  mkVolumeEphemeralVolumeClaimTemplateSpecSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  VolumeEphemeralVolumeClaimTemplateSpecSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf VolumeEphemeralVolumeClaimTemplateSpecSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkVolumeEphemeralVolumeClaimTemplateSpecSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkVolumeEphemeralVolumeClaimTemplateSpecSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  VolumeFcModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is the filesystem type to mount.\nMust be a filesystem type supported by the host operating system.\nEx. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.";
        type = (types.nullOr types.str);
        default = null;
      };
      "lun" = mkOption {
        description = "lun is Optional: FC target lun number";
        type = (types.nullOr types.int);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly is Optional: Defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.";
        type = types.bool;
        default = false;
      };
      "targetWWNs" = mkOption {
        description = "targetWWNs is Optional: FC target worldwide names (WWNs)";
        type = (types.listOf types.str);
        default = [ ];
      };
      "wwids" = mkOption {
        description = "wwids Optional: FC volume world wide identifiers (wwids)\nEither wwids or combination of targetWWNs and lun must be set, but not both simultaneously.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkVolumeFc =
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
  VolumeFlexVolumeModule = types.submodule {
    options = {
      "driver" = mkOption {
        description = "driver is the name of the driver to use for this volume.";
        type = types.str;
      };
      "fsType" = mkOption {
        description = "fsType is the filesystem type to mount.\nMust be a filesystem type supported by the host operating system.\nEx. \"ext4\", \"xfs\", \"ntfs\". The default filesystem depends on FlexVolume script.";
        type = (types.nullOr types.str);
        default = null;
      };
      "options" = mkOption {
        description = "options is Optional: this field holds extra command options if any.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "readOnly" = mkOption {
        description = "readOnly is Optional: defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.";
        type = types.bool;
        default = false;
      };
      "secretRef" = mkOption {
        description = "secretRef is Optional: secretRef is reference to the secret object containing\nsensitive information to pass to the plugin scripts. This may be\nempty if no secret object is specified. If the secret object\ncontains more than one secret, all secrets are passed to the plugin\nscripts.";
        type = (types.nullOr VolumeFlexVolumeSecretRefModule);
        default = null;
      };
    };
  };
  mkVolumeFlexVolume =
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
      "secretRef" = mkVolumeFlexVolumeSecretRef res."secretRef";
    }
    // {
    };
  VolumeFlexVolumeSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkVolumeFlexVolumeSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  VolumeFlockerModule = types.submodule {
    options = {
      "datasetName" = mkOption {
        description = "datasetName is Name of the dataset stored as metadata -> name on the dataset for Flocker\nshould be considered as deprecated";
        type = (types.nullOr types.str);
        default = null;
      };
      "datasetUUID" = mkOption {
        description = "datasetUUID is the UUID of the dataset. This is unique identifier of a Flocker dataset";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkVolumeFlocker =
    res:
    {
    }
    // optionalAttrs (res."datasetName" != null) { inherit (res) "datasetName"; }
    // {
    }
    // optionalAttrs (res."datasetUUID" != null) { inherit (res) "datasetUUID"; }
    // {
    };
  VolumeGcePersistentDiskModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is filesystem type of the volume that you want to mount.\nTip: Ensure that the filesystem type is supported by the host operating system.\nExamples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk";
        type = (types.nullOr types.str);
        default = null;
      };
      "partition" = mkOption {
        description = "partition is the partition in the volume that you want to mount.\nIf omitted, the default is to mount by volume name.\nExamples: For volume /dev/sda1, you specify the partition as \"1\".\nSimilarly, the volume partition for /dev/sda is \"0\" (or you can leave the property empty).\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk";
        type = (types.nullOr types.int);
        default = null;
      };
      "pdName" = mkOption {
        description = "pdName is unique name of the PD resource in GCE. Used to identify the disk in GCE.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk";
        type = types.str;
      };
      "readOnly" = mkOption {
        description = "readOnly here will force the ReadOnly setting in VolumeMounts.\nDefaults to false.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk";
        type = types.bool;
        default = false;
      };
    };
  };
  mkVolumeGcePersistentDisk =
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
  VolumeGitRepoModule = types.submodule {
    options = {
      "directory" = mkOption {
        description = "directory is the target directory name.\nMust not contain or start with '..'.  If '.' is supplied, the volume directory will be the\ngit repository.  Otherwise, if specified, the volume will contain the git repository in\nthe subdirectory with the given name.";
        type = (types.nullOr types.str);
        default = null;
      };
      "repository" = mkOption {
        description = "repository is the URL";
        type = types.str;
      };
      "revision" = mkOption {
        description = "revision is the commit hash for the specified revision.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkVolumeGitRepo =
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
  VolumeGlusterfsModule = types.submodule {
    options = {
      "endpoints" = mkOption {
        description = "endpoints is the endpoint name that details Glusterfs topology.\nMore info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod";
        type = types.str;
      };
      "path" = mkOption {
        description = "path is the Glusterfs volume path.\nMore info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod";
        type = types.str;
      };
      "readOnly" = mkOption {
        description = "readOnly here will force the Glusterfs volume to be mounted with read-only permissions.\nDefaults to false.\nMore info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod";
        type = types.bool;
        default = false;
      };
    };
  };
  mkVolumeGlusterfs =
    res:
    {
      inherit (res) "endpoints";
      inherit (res) "path";
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    };
  VolumeHostPathModule = types.submodule {
    options = {
      "path" = mkOption {
        description = "path of the directory on the host.\nIf the path is a symlink, it will follow the link to the real path.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath";
        type = types.str;
      };
      "type" = mkOption {
        description = "type for HostPath Volume\nDefaults to \"\"\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkVolumeHostPath =
    res:
    {
      inherit (res) "path";
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  VolumeImageModule = types.submodule {
    options = {
      "pullPolicy" = mkOption {
        description = "Policy for pulling OCI objects. Possible values are:\nAlways: the kubelet always attempts to pull the reference. Container creation will fail If the pull fails.\nNever: the kubelet never pulls the reference and only uses a local image or artifact. Container creation will fail if the reference isn't present.\nIfNotPresent: the kubelet pulls if the reference isn't already present on disk. Container creation will fail if the reference isn't present and the pull fails.\nDefaults to Always if :latest tag is specified, or IfNotPresent otherwise.";
        type = (types.nullOr types.str);
        default = null;
      };
      "reference" = mkOption {
        description = "Required: Image or artifact reference to be used.\nBehaves in the same way as pod.spec.containers[*].image.\nPull secrets will be assembled in the same way as for the container image by looking up node credentials, SA image pull secrets, and pod spec image pull secrets.\nMore info: https://kubernetes.io/docs/concepts/containers/images\nThis field is optional to allow higher level config management to default or override\ncontainer images in workload controllers like Deployments and StatefulSets.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkVolumeImage =
    res:
    {
    }
    // optionalAttrs (res."pullPolicy" != null) { inherit (res) "pullPolicy"; }
    // {
    }
    // optionalAttrs (res."reference" != null) { inherit (res) "reference"; }
    // {
    };
  VolumeIscsiModule = types.submodule {
    options = {
      "chapAuthDiscovery" = mkOption {
        description = "chapAuthDiscovery defines whether support iSCSI Discovery CHAP authentication";
        type = types.bool;
        default = false;
      };
      "chapAuthSession" = mkOption {
        description = "chapAuthSession defines whether support iSCSI Session CHAP authentication";
        type = types.bool;
        default = false;
      };
      "fsType" = mkOption {
        description = "fsType is the filesystem type of the volume that you want to mount.\nTip: Ensure that the filesystem type is supported by the host operating system.\nExamples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#iscsi";
        type = (types.nullOr types.str);
        default = null;
      };
      "initiatorName" = mkOption {
        description = "initiatorName is the custom iSCSI Initiator Name.\nIf initiatorName is specified with iscsiInterface simultaneously, new iSCSI interface\n<target portal>:<volume name> will be created for the connection.";
        type = (types.nullOr types.str);
        default = null;
      };
      "iqn" = mkOption {
        description = "iqn is the target iSCSI Qualified Name.";
        type = types.str;
      };
      "iscsiInterface" = mkOption {
        description = "iscsiInterface is the interface Name that uses an iSCSI transport.\nDefaults to 'default' (tcp).";
        type = (types.nullOr types.str);
        default = "default";
      };
      "lun" = mkOption {
        description = "lun represents iSCSI Target Lun number.";
        type = types.int;
      };
      "portals" = mkOption {
        description = "portals is the iSCSI Target Portal List. The portal is either an IP or ip_addr:port if the port\nis other than default (typically TCP ports 860 and 3260).";
        type = (types.listOf types.str);
        default = [ ];
      };
      "readOnly" = mkOption {
        description = "readOnly here will force the ReadOnly setting in VolumeMounts.\nDefaults to false.";
        type = types.bool;
        default = false;
      };
      "secretRef" = mkOption {
        description = "secretRef is the CHAP Secret for iSCSI target and initiator authentication";
        type = (types.nullOr VolumeIscsiSecretRefModule);
        default = null;
      };
      "targetPortal" = mkOption {
        description = "targetPortal is iSCSI Target Portal. The Portal is either an IP or ip_addr:port if the port\nis other than default (typically TCP ports 860 and 3260).";
        type = types.str;
      };
    };
  };
  mkVolumeIscsi =
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
    // optionalAttrs (res."secretRef" != null) { "secretRef" = mkVolumeIscsiSecretRef res."secretRef"; }
    // {
      inherit (res) "targetPortal";
    };
  VolumeIscsiSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkVolumeIscsiSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  VolumeModule = types.submodule {
    options = {
      "awsElasticBlockStore" = mkOption {
        description = "awsElasticBlockStore represents an AWS Disk resource that is attached to a\nkubelet's host machine and then exposed to the pod.\nDeprecated: AWSElasticBlockStore is deprecated. All operations for the in-tree\nawsElasticBlockStore type are redirected to the ebs.csi.aws.com CSI driver.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore";
        type = (types.nullOr VolumeAwsElasticBlockStoreModule);
        default = null;
      };
      "azureDisk" = mkOption {
        description = "azureDisk represents an Azure Data Disk mount on the host and bind mount to the pod.\nDeprecated: AzureDisk is deprecated. All operations for the in-tree azureDisk type\nare redirected to the disk.csi.azure.com CSI driver.";
        type = (types.nullOr VolumeAzureDiskModule);
        default = null;
      };
      "azureFile" = mkOption {
        description = "azureFile represents an Azure File Service mount on the host and bind mount to the pod.\nDeprecated: AzureFile is deprecated. All operations for the in-tree azureFile type\nare redirected to the file.csi.azure.com CSI driver.";
        type = (types.nullOr VolumeAzureFileModule);
        default = null;
      };
      "cephfs" = mkOption {
        description = "cephFS represents a Ceph FS mount on the host that shares a pod's lifetime.\nDeprecated: CephFS is deprecated and the in-tree cephfs type is no longer supported.";
        type = (types.nullOr VolumeCephfsModule);
        default = null;
      };
      "cinder" = mkOption {
        description = "cinder represents a cinder volume attached and mounted on kubelets host machine.\nDeprecated: Cinder is deprecated. All operations for the in-tree cinder type\nare redirected to the cinder.csi.openstack.org CSI driver.\nMore info: https://examples.k8s.io/mysql-cinder-pd/README.md";
        type = (types.nullOr VolumeCinderModule);
        default = null;
      };
      "configMap" = mkOption {
        description = "configMap represents a configMap that should populate this volume";
        type = (types.nullOr VolumeConfigMapModule);
        default = null;
      };
      "csi" = mkOption {
        description = "csi (Container Storage Interface) represents ephemeral storage that is handled by certain external CSI drivers.";
        type = (types.nullOr VolumeCsiModule);
        default = null;
      };
      "downwardAPI" = mkOption {
        description = "downwardAPI represents downward API about the pod that should populate this volume";
        type = (types.nullOr VolumeDownwardAPIModule);
        default = null;
      };
      "emptyDir" = mkOption {
        description = "emptyDir represents a temporary directory that shares a pod's lifetime.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir";
        type = (types.nullOr VolumeEmptyDirModule);
        default = null;
      };
      "ephemeral" = mkOption {
        description = "ephemeral represents a volume that is handled by a cluster storage driver.\nThe volume's lifecycle is tied to the pod that defines it - it will be created before the pod starts,\nand deleted when the pod is removed.\n\nUse this if:\na) the volume is only needed while the pod runs,\nb) features of normal volumes like restoring from snapshot or capacity\n   tracking are needed,\nc) the storage driver is specified through a storage class, and\nd) the storage driver supports dynamic volume provisioning through\n   a PersistentVolumeClaim (see EphemeralVolumeSource for more\n   information on the connection between this volume type\n   and PersistentVolumeClaim).\n\nUse PersistentVolumeClaim or one of the vendor-specific\nAPIs for volumes that persist for longer than the lifecycle\nof an individual pod.\n\nUse CSI for light-weight local ephemeral volumes if the CSI driver is meant to\nbe used that way - see the documentation of the driver for\nmore information.\n\nA pod can use both types of ephemeral volumes and\npersistent volumes at the same time.";
        type = (types.nullOr VolumeEphemeralModule);
        default = null;
      };
      "fc" = mkOption {
        description = "fc represents a Fibre Channel resource that is attached to a kubelet's host machine and then exposed to the pod.";
        type = (types.nullOr VolumeFcModule);
        default = null;
      };
      "flexVolume" = mkOption {
        description = "flexVolume represents a generic volume resource that is\nprovisioned/attached using an exec based plugin.\nDeprecated: FlexVolume is deprecated. Consider using a CSIDriver instead.";
        type = (types.nullOr VolumeFlexVolumeModule);
        default = null;
      };
      "flocker" = mkOption {
        description = "flocker represents a Flocker volume attached to a kubelet's host machine. This depends on the Flocker control service being running.\nDeprecated: Flocker is deprecated and the in-tree flocker type is no longer supported.";
        type = (types.nullOr VolumeFlockerModule);
        default = null;
      };
      "gcePersistentDisk" = mkOption {
        description = "gcePersistentDisk represents a GCE Disk resource that is attached to a\nkubelet's host machine and then exposed to the pod.\nDeprecated: GCEPersistentDisk is deprecated. All operations for the in-tree\ngcePersistentDisk type are redirected to the pd.csi.storage.gke.io CSI driver.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk";
        type = (types.nullOr VolumeGcePersistentDiskModule);
        default = null;
      };
      "gitRepo" = mkOption {
        description = "gitRepo represents a git repository at a particular revision.\nDeprecated: GitRepo is deprecated. To provision a container with a git repo, mount an\nEmptyDir into an InitContainer that clones the repo using git, then mount the EmptyDir\ninto the Pod's container.";
        type = (types.nullOr VolumeGitRepoModule);
        default = null;
      };
      "glusterfs" = mkOption {
        description = "glusterfs represents a Glusterfs mount on the host that shares a pod's lifetime.\nDeprecated: Glusterfs is deprecated and the in-tree glusterfs type is no longer supported.\nMore info: https://examples.k8s.io/volumes/glusterfs/README.md";
        type = (types.nullOr VolumeGlusterfsModule);
        default = null;
      };
      "hostPath" = mkOption {
        description = "hostPath represents a pre-existing file or directory on the host\nmachine that is directly exposed to the container. This is generally\nused for system agents or other privileged things that are allowed\nto see the host machine. Most containers will NOT need this.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath";
        type = (types.nullOr VolumeHostPathModule);
        default = null;
      };
      "image" = mkOption {
        description = "image represents an OCI object (a container image or artifact) pulled and mounted on the kubelet's host machine.\nThe volume is resolved at pod startup depending on which PullPolicy value is provided:\n\n- Always: the kubelet always attempts to pull the reference. Container creation will fail If the pull fails.\n- Never: the kubelet never pulls the reference and only uses a local image or artifact. Container creation will fail if the reference isn't present.\n- IfNotPresent: the kubelet pulls if the reference isn't already present on disk. Container creation will fail if the reference isn't present and the pull fails.\n\nThe volume gets re-resolved if the pod gets deleted and recreated, which means that new remote content will become available on pod recreation.\nA failure to resolve or pull the image during pod startup will block containers from starting and may add significant latency. Failures will be retried using normal volume backoff and will be reported on the pod reason and message.\nThe types of objects that may be mounted by this volume are defined by the container runtime implementation on a host machine and at minimum must include all valid types supported by the container image field.\nThe OCI object gets mounted in a single directory (spec.containers[*].volumeMounts.mountPath) by merging the manifest layers in the same way as for container images.\nThe volume will be mounted read-only (ro) and non-executable files (noexec).\nSub path mounts for containers are not supported (spec.containers[*].volumeMounts.subpath) before 1.33.\nThe field spec.securityContext.fsGroupChangePolicy has no effect on this volume type.";
        type = (types.nullOr VolumeImageModule);
        default = null;
      };
      "iscsi" = mkOption {
        description = "iscsi represents an ISCSI Disk resource that is attached to a\nkubelet's host machine and then exposed to the pod.\nMore info: https://examples.k8s.io/volumes/iscsi/README.md";
        type = (types.nullOr VolumeIscsiModule);
        default = null;
      };
      "name" = mkOption {
        description = "name of the volume.\nMust be a DNS_LABEL and unique within the pod.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = types.str;
      };
      "nfs" = mkOption {
        description = "nfs represents an NFS mount on the host that shares a pod's lifetime\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#nfs";
        type = (types.nullOr VolumeNfsModule);
        default = null;
      };
      "persistentVolumeClaim" = mkOption {
        description = "persistentVolumeClaimVolumeSource represents a reference to a\nPersistentVolumeClaim in the same namespace.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims";
        type = (types.nullOr VolumePersistentVolumeClaimModule);
        default = null;
      };
      "photonPersistentDisk" = mkOption {
        description = "photonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine.\nDeprecated: PhotonPersistentDisk is deprecated and the in-tree photonPersistentDisk type is no longer supported.";
        type = (types.nullOr VolumePhotonPersistentDiskModule);
        default = null;
      };
      "portworxVolume" = mkOption {
        description = "portworxVolume represents a portworx volume attached and mounted on kubelets host machine.\nDeprecated: PortworxVolume is deprecated. All operations for the in-tree portworxVolume type\nare redirected to the pxd.portworx.com CSI driver when the CSIMigrationPortworx feature-gate\nis on.";
        type = (types.nullOr VolumePortworxVolumeModule);
        default = null;
      };
      "projected" = mkOption {
        description = "projected items for all in one resources secrets, configmaps, and downward API";
        type = (types.nullOr VolumeProjectedModule);
        default = null;
      };
      "quobyte" = mkOption {
        description = "quobyte represents a Quobyte mount on the host that shares a pod's lifetime.\nDeprecated: Quobyte is deprecated and the in-tree quobyte type is no longer supported.";
        type = (types.nullOr VolumeQuobyteModule);
        default = null;
      };
      "rbd" = mkOption {
        description = "rbd represents a Rados Block Device mount on the host that shares a pod's lifetime.\nDeprecated: RBD is deprecated and the in-tree rbd type is no longer supported.\nMore info: https://examples.k8s.io/volumes/rbd/README.md";
        type = (types.nullOr VolumeRbdModule);
        default = null;
      };
      "scaleIO" = mkOption {
        description = "scaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes.\nDeprecated: ScaleIO is deprecated and the in-tree scaleIO type is no longer supported.";
        type = (types.nullOr VolumeScaleIOModule);
        default = null;
      };
      "secret" = mkOption {
        description = "secret represents a secret that should populate this volume.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#secret";
        type = (types.nullOr VolumeSecretModule);
        default = null;
      };
      "storageos" = mkOption {
        description = "storageOS represents a StorageOS volume attached and mounted on Kubernetes nodes.\nDeprecated: StorageOS is deprecated and the in-tree storageos type is no longer supported.";
        type = (types.nullOr VolumeStorageosModule);
        default = null;
      };
      "vsphereVolume" = mkOption {
        description = "vsphereVolume represents a vSphere volume attached and mounted on kubelets host machine.\nDeprecated: VsphereVolume is deprecated. All operations for the in-tree vsphereVolume type\nare redirected to the csi.vsphere.vmware.com CSI driver.";
        type = (types.nullOr VolumeVsphereVolumeModule);
        default = null;
      };
    };
  };
  mkVolume =
    res:
    {
    }
    // optionalAttrs (res."awsElasticBlockStore" != null) {
      "awsElasticBlockStore" = mkVolumeAwsElasticBlockStore res."awsElasticBlockStore";
    }
    // {
    }
    // optionalAttrs (res."azureDisk" != null) { "azureDisk" = mkVolumeAzureDisk res."azureDisk"; }
    // {
    }
    // optionalAttrs (res."azureFile" != null) { "azureFile" = mkVolumeAzureFile res."azureFile"; }
    // {
    }
    // optionalAttrs (res."cephfs" != null) { "cephfs" = mkVolumeCephfs res."cephfs"; }
    // {
    }
    // optionalAttrs (res."cinder" != null) { "cinder" = mkVolumeCinder res."cinder"; }
    // {
    }
    // optionalAttrs (res."configMap" != null) { "configMap" = mkVolumeConfigMap res."configMap"; }
    // {
    }
    // optionalAttrs (res."csi" != null) { "csi" = mkVolumeCsi res."csi"; }
    // {
    }
    // optionalAttrs (res."downwardAPI" != null) {
      "downwardAPI" = mkVolumeDownwardAPI res."downwardAPI";
    }
    // {
    }
    // optionalAttrs (res."emptyDir" != null) { "emptyDir" = mkVolumeEmptyDir res."emptyDir"; }
    // {
    }
    // optionalAttrs (res."ephemeral" != null) { "ephemeral" = mkVolumeEphemeral res."ephemeral"; }
    // {
    }
    // optionalAttrs (res."fc" != null) { "fc" = mkVolumeFc res."fc"; }
    // {
    }
    // optionalAttrs (res."flexVolume" != null) { "flexVolume" = mkVolumeFlexVolume res."flexVolume"; }
    // {
    }
    // optionalAttrs (res."flocker" != null) { "flocker" = mkVolumeFlocker res."flocker"; }
    // {
    }
    // optionalAttrs (res."gcePersistentDisk" != null) {
      "gcePersistentDisk" = mkVolumeGcePersistentDisk res."gcePersistentDisk";
    }
    // {
    }
    // optionalAttrs (res."gitRepo" != null) { "gitRepo" = mkVolumeGitRepo res."gitRepo"; }
    // {
    }
    // optionalAttrs (res."glusterfs" != null) { "glusterfs" = mkVolumeGlusterfs res."glusterfs"; }
    // {
    }
    // optionalAttrs (res."hostPath" != null) { "hostPath" = mkVolumeHostPath res."hostPath"; }
    // {
    }
    // optionalAttrs (res."image" != null) { "image" = mkVolumeImage res."image"; }
    // {
    }
    // optionalAttrs (res."iscsi" != null) { "iscsi" = mkVolumeIscsi res."iscsi"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."nfs" != null) { "nfs" = mkVolumeNfs res."nfs"; }
    // {
    }
    // optionalAttrs (res."persistentVolumeClaim" != null) {
      "persistentVolumeClaim" = mkVolumePersistentVolumeClaim res."persistentVolumeClaim";
    }
    // {
    }
    // optionalAttrs (res."photonPersistentDisk" != null) {
      "photonPersistentDisk" = mkVolumePhotonPersistentDisk res."photonPersistentDisk";
    }
    // {
    }
    // optionalAttrs (res."portworxVolume" != null) {
      "portworxVolume" = mkVolumePortworxVolume res."portworxVolume";
    }
    // {
    }
    // optionalAttrs (res."projected" != null) { "projected" = mkVolumeProjected res."projected"; }
    // {
    }
    // optionalAttrs (res."quobyte" != null) { "quobyte" = mkVolumeQuobyte res."quobyte"; }
    // {
    }
    // optionalAttrs (res."rbd" != null) { "rbd" = mkVolumeRbd res."rbd"; }
    // {
    }
    // optionalAttrs (res."scaleIO" != null) { "scaleIO" = mkVolumeScaleIO res."scaleIO"; }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkVolumeSecret res."secret"; }
    // {
    }
    // optionalAttrs (res."storageos" != null) { "storageos" = mkVolumeStorageos res."storageos"; }
    // {
    }
    // optionalAttrs (res."vsphereVolume" != null) {
      "vsphereVolume" = mkVolumeVsphereVolume res."vsphereVolume";
    }
    // {
    };
  VolumeMountModule = types.submodule {
    options = {
      "mountPath" = mkOption {
        description = "Path within the container at which the volume should be mounted.  Must\nnot contain ':'.";
        type = types.str;
      };
      "mountPropagation" = mkOption {
        description = "mountPropagation determines how mounts are propagated from the host\nto container and the other way around.\nWhen not set, MountPropagationNone is used.\nThis field is beta in 1.10.\nWhen RecursiveReadOnly is set to IfPossible or to Enabled, MountPropagation must be None or unspecified\n(which defaults to None).";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "This must match the Name of a Volume.";
        type = types.str;
      };
      "readOnly" = mkOption {
        description = "Mounted read-only if true, read-write otherwise (false or unspecified).\nDefaults to false.";
        type = types.bool;
        default = false;
      };
      "recursiveReadOnly" = mkOption {
        description = "RecursiveReadOnly specifies whether read-only mounts should be handled\nrecursively.\n\nIf ReadOnly is false, this field has no meaning and must be unspecified.\n\nIf ReadOnly is true, and this field is set to Disabled, the mount is not made\nrecursively read-only.  If this field is set to IfPossible, the mount is made\nrecursively read-only, if it is supported by the container runtime.  If this\nfield is set to Enabled, the mount is made recursively read-only if it is\nsupported by the container runtime, otherwise the pod will not be started and\nan error will be generated to indicate the reason.\n\nIf this field is set to IfPossible or Enabled, MountPropagation must be set to\nNone (or be unspecified, which defaults to None).\n\nIf this field is not specified, it is treated as an equivalent of Disabled.";
        type = (types.nullOr types.str);
        default = null;
      };
      "subPath" = mkOption {
        description = "Path within the volume from which the container's volume should be mounted.\nDefaults to \"\" (volume's root).";
        type = (types.nullOr types.str);
        default = null;
      };
      "subPathExpr" = mkOption {
        description = "Expanded path within the volume from which the container's volume should be mounted.\nBehaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment.\nDefaults to \"\" (volume's root).\nSubPathExpr and SubPath are mutually exclusive.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkVolumeMount =
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
  VolumeNfsModule = types.submodule {
    options = {
      "path" = mkOption {
        description = "path that is exported by the NFS server.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#nfs";
        type = types.str;
      };
      "readOnly" = mkOption {
        description = "readOnly here will force the NFS export to be mounted with read-only permissions.\nDefaults to false.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#nfs";
        type = types.bool;
        default = false;
      };
      "server" = mkOption {
        description = "server is the hostname or IP address of the NFS server.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#nfs";
        type = types.str;
      };
    };
  };
  mkVolumeNfs =
    res:
    {
      inherit (res) "path";
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
      inherit (res) "server";
    };
  VolumePersistentVolumeClaimModule = types.submodule {
    options = {
      "claimName" = mkOption {
        description = "claimName is the name of a PersistentVolumeClaim in the same namespace as the pod using this volume.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims";
        type = types.str;
      };
      "readOnly" = mkOption {
        description = "readOnly Will force the ReadOnly setting in VolumeMounts.\nDefault false.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkVolumePersistentVolumeClaim =
    res:
    {
      inherit (res) "claimName";
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    };
  VolumePhotonPersistentDiskModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is the filesystem type to mount.\nMust be a filesystem type supported by the host operating system.\nEx. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.";
        type = (types.nullOr types.str);
        default = null;
      };
      "pdID" = mkOption {
        description = "pdID is the ID that identifies Photon Controller persistent disk";
        type = types.str;
      };
    };
  };
  mkVolumePhotonPersistentDisk =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
      inherit (res) "pdID";
    };
  VolumePortworxVolumeModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fSType represents the filesystem type to mount\nMust be a filesystem type supported by the host operating system.\nEx. \"ext4\", \"xfs\". Implicitly inferred to be \"ext4\" if unspecified.";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.";
        type = types.bool;
        default = false;
      };
      "volumeID" = mkOption {
        description = "volumeID uniquely identifies a Portworx volume";
        type = types.str;
      };
    };
  };
  mkVolumePortworxVolume =
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
  VolumeProjectedModule = types.submodule {
    options = {
      "defaultMode" = mkOption {
        description = "defaultMode are the mode bits used to set permissions on created files by default.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nDirectories within the path are not affected by this setting.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "sources" = mkOption {
        description = "sources is the list of volume projections. Each entry in this list\nhandles one source.";
        type = (types.listOf VolumeProjectedSourceModule);
        default = [ ];
      };
    };
  };
  mkVolumeProjected =
    res:
    {
    }
    // optionalAttrs (res."defaultMode" != null) { inherit (res) "defaultMode"; }
    // {
    }
    // optionalAttrs (res."sources" != [ ]) { "sources" = map mkVolumeProjectedSource res."sources"; }
    // {
    };
  VolumeProjectedSourceClusterTrustBundleLabelSelectorMatchExpressionModule = types.submodule {
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
  mkVolumeProjectedSourceClusterTrustBundleLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  VolumeProjectedSourceClusterTrustBundleLabelSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf VolumeProjectedSourceClusterTrustBundleLabelSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkVolumeProjectedSourceClusterTrustBundleLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkVolumeProjectedSourceClusterTrustBundleLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  VolumeProjectedSourceClusterTrustBundleModule = types.submodule {
    options = {
      "labelSelector" = mkOption {
        description = "Select all ClusterTrustBundles that match this label selector.  Only has\neffect if signerName is set.  Mutually-exclusive with name.  If unset,\ninterpreted as \"match nothing\".  If set but empty, interpreted as \"match\neverything\".";
        type = (types.nullOr VolumeProjectedSourceClusterTrustBundleLabelSelectorModule);
        default = null;
      };
      "name" = mkOption {
        description = "Select a single ClusterTrustBundle by object name.  Mutually-exclusive\nwith signerName and labelSelector.";
        type = (types.nullOr types.str);
        default = null;
      };
      "optional" = mkOption {
        description = "If true, don't block pod startup if the referenced ClusterTrustBundle(s)\naren't available.  If using name, then the named ClusterTrustBundle is\nallowed not to exist.  If using signerName, then the combination of\nsignerName and labelSelector is allowed to match zero\nClusterTrustBundles.";
        type = types.bool;
        default = false;
      };
      "path" = mkOption {
        description = "Relative path from the volume root to write the bundle.";
        type = types.str;
      };
      "signerName" = mkOption {
        description = "Select all ClusterTrustBundles that match this signer name.\nMutually-exclusive with name.  The contents of all selected\nClusterTrustBundles will be unified and deduplicated.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkVolumeProjectedSourceClusterTrustBundle =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" = mkVolumeProjectedSourceClusterTrustBundleLabelSelector res."labelSelector";
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
  VolumeProjectedSourceConfigMapItemModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the key to project.";
        type = types.str;
      };
      "mode" = mkOption {
        description = "mode is Optional: mode bits used to set permissions on this file.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nIf not specified, the volume defaultMode will be used.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        description = "path is the relative path of the file to map the key to.\nMay not be an absolute path.\nMay not contain the path element '..'.\nMay not start with the string '..'.";
        type = types.str;
      };
    };
  };
  mkVolumeProjectedSourceConfigMapItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    };
  VolumeProjectedSourceConfigMapModule = types.submodule {
    options = {
      "items" = mkOption {
        description = "items if unspecified, each key-value pair in the Data field of the referenced\nConfigMap will be projected into the volume as a file whose name is the\nkey and content is the value. If specified, the listed keys will be\nprojected into the specified paths, and unlisted keys will not be\npresent. If a key is specified which is not present in the ConfigMap,\nthe volume setup will error unless it is marked optional. Paths must be\nrelative and may not contain the '..' path or start with '..'.";
        type = (types.listOf VolumeProjectedSourceConfigMapItemModule);
        default = [ ];
      };
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "optional specify whether the ConfigMap or its keys must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkVolumeProjectedSourceConfigMap =
    res:
    {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkVolumeProjectedSourceConfigMapItem res."items";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  VolumeProjectedSourceDownwardAPIItemFieldRefModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        description = "Version of the schema the FieldPath is written in terms of, defaults to \"v1\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "fieldPath" = mkOption {
        description = "Path of the field to select in the specified API version.";
        type = types.str;
      };
    };
  };
  mkVolumeProjectedSourceDownwardAPIItemFieldRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "fieldPath";
    };
  VolumeProjectedSourceDownwardAPIItemModule = types.submodule {
    options = {
      "fieldRef" = mkOption {
        description = "Required: Selects a field of the pod: only annotations, labels, name, namespace and uid are supported.";
        type = (types.nullOr VolumeProjectedSourceDownwardAPIItemFieldRefModule);
        default = null;
      };
      "mode" = mkOption {
        description = "Optional: mode bits used to set permissions on this file, must be an octal value\nbetween 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nIf not specified, the volume defaultMode will be used.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        description = "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'";
        type = types.str;
      };
      "resourceFieldRef" = mkOption {
        description = "Selects a resource of the container: only resources limits and requests\n(limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported.";
        type = (types.nullOr VolumeProjectedSourceDownwardAPIItemResourceFieldRefModule);
        default = null;
      };
    };
  };
  mkVolumeProjectedSourceDownwardAPIItem =
    res:
    {
    }
    // optionalAttrs (res."fieldRef" != null) {
      "fieldRef" = mkVolumeProjectedSourceDownwardAPIItemFieldRef res."fieldRef";
    }
    // {
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    }
    // optionalAttrs (res."resourceFieldRef" != null) {
      "resourceFieldRef" = mkVolumeProjectedSourceDownwardAPIItemResourceFieldRef res."resourceFieldRef";
    }
    // {
    };
  VolumeProjectedSourceDownwardAPIItemResourceFieldRefModule = types.submodule {
    options = {
      "containerName" = mkOption {
        description = "Container name: required for volumes, optional for env vars";
        type = (types.nullOr types.str);
        default = null;
      };
      "divisor" = mkOption {
        description = "Specifies the output format of the exposed resources, defaults to \"1\"";
        type = types.anything;
        default = { };
      };
      "resource" = mkOption {
        description = "Required: resource to select";
        type = types.str;
      };
    };
  };
  mkVolumeProjectedSourceDownwardAPIItemResourceFieldRef =
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
  VolumeProjectedSourceDownwardAPIModule = types.submodule {
    options = {
      "items" = mkOption {
        description = "Items is a list of DownwardAPIVolume file";
        type = (types.listOf VolumeProjectedSourceDownwardAPIItemModule);
        default = [ ];
      };
    };
  };
  mkVolumeProjectedSourceDownwardAPI =
    res:
    {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkVolumeProjectedSourceDownwardAPIItem res."items";
    }
    // {
    };
  VolumeProjectedSourceModule = types.submodule {
    options = {
      "clusterTrustBundle" = mkOption {
        description = "ClusterTrustBundle allows a pod to access the `.spec.trustBundle` field\nof ClusterTrustBundle objects in an auto-updating file.\n\nAlpha, gated by the ClusterTrustBundleProjection feature gate.\n\nClusterTrustBundle objects can either be selected by name, or by the\ncombination of signer name and a label selector.\n\nKubelet performs aggressive normalization of the PEM contents written\ninto the pod filesystem.  Esoteric PEM features such as inter-block\ncomments and block headers are stripped.  Certificates are deduplicated.\nThe ordering of certificates within the file is arbitrary, and Kubelet\nmay change the order over time.";
        type = (types.nullOr VolumeProjectedSourceClusterTrustBundleModule);
        default = null;
      };
      "configMap" = mkOption {
        description = "configMap information about the configMap data to project";
        type = (types.nullOr VolumeProjectedSourceConfigMapModule);
        default = null;
      };
      "downwardAPI" = mkOption {
        description = "downwardAPI information about the downwardAPI data to project";
        type = (types.nullOr VolumeProjectedSourceDownwardAPIModule);
        default = null;
      };
      "secret" = mkOption {
        description = "secret information about the secret data to project";
        type = (types.nullOr VolumeProjectedSourceSecretModule);
        default = null;
      };
      "serviceAccountToken" = mkOption {
        description = "serviceAccountToken is information about the serviceAccountToken data to project";
        type = (types.nullOr VolumeProjectedSourceServiceAccountTokenModule);
        default = null;
      };
    };
  };
  mkVolumeProjectedSource =
    res:
    {
    }
    // optionalAttrs (res."clusterTrustBundle" != null) {
      "clusterTrustBundle" = mkVolumeProjectedSourceClusterTrustBundle res."clusterTrustBundle";
    }
    // {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkVolumeProjectedSourceConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."downwardAPI" != null) {
      "downwardAPI" = mkVolumeProjectedSourceDownwardAPI res."downwardAPI";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkVolumeProjectedSourceSecret res."secret"; }
    // {
    }
    // optionalAttrs (res."serviceAccountToken" != null) {
      "serviceAccountToken" = mkVolumeProjectedSourceServiceAccountToken res."serviceAccountToken";
    }
    // {
    };
  VolumeProjectedSourceSecretItemModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the key to project.";
        type = types.str;
      };
      "mode" = mkOption {
        description = "mode is Optional: mode bits used to set permissions on this file.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nIf not specified, the volume defaultMode will be used.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        description = "path is the relative path of the file to map the key to.\nMay not be an absolute path.\nMay not contain the path element '..'.\nMay not start with the string '..'.";
        type = types.str;
      };
    };
  };
  mkVolumeProjectedSourceSecretItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    };
  VolumeProjectedSourceSecretModule = types.submodule {
    options = {
      "items" = mkOption {
        description = "items if unspecified, each key-value pair in the Data field of the referenced\nSecret will be projected into the volume as a file whose name is the\nkey and content is the value. If specified, the listed keys will be\nprojected into the specified paths, and unlisted keys will not be\npresent. If a key is specified which is not present in the Secret,\nthe volume setup will error unless it is marked optional. Paths must be\nrelative and may not contain the '..' path or start with '..'.";
        type = (types.listOf VolumeProjectedSourceSecretItemModule);
        default = [ ];
      };
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "optional field specify whether the Secret or its key must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkVolumeProjectedSourceSecret =
    res:
    {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkVolumeProjectedSourceSecretItem res."items";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  VolumeProjectedSourceServiceAccountTokenModule = types.submodule {
    options = {
      "audience" = mkOption {
        description = "audience is the intended audience of the token. A recipient of a token\nmust identify itself with an identifier specified in the audience of the\ntoken, and otherwise should reject the token. The audience defaults to the\nidentifier of the apiserver.";
        type = (types.nullOr types.str);
        default = null;
      };
      "expirationSeconds" = mkOption {
        description = "expirationSeconds is the requested duration of validity of the service\naccount token. As the token approaches expiration, the kubelet volume\nplugin will proactively rotate the service account token. The kubelet will\nstart trying to rotate the token if the token is older than 80 percent of\nits time to live or if the token is older than 24 hours.Defaults to 1 hour\nand must be at least 10 minutes.";
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        description = "path is the path relative to the mount point of the file to project the\ntoken into.";
        type = types.str;
      };
    };
  };
  mkVolumeProjectedSourceServiceAccountToken =
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
  VolumeQuobyteModule = types.submodule {
    options = {
      "group" = mkOption {
        description = "group to map volume access to\nDefault is no group";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly here will force the Quobyte volume to be mounted with read-only permissions.\nDefaults to false.";
        type = types.bool;
        default = false;
      };
      "registry" = mkOption {
        description = "registry represents a single or multiple Quobyte Registry services\nspecified as a string as host:port pair (multiple entries are separated with commas)\nwhich acts as the central registry for volumes";
        type = types.str;
      };
      "tenant" = mkOption {
        description = "tenant owning the given Quobyte volume in the Backend\nUsed with dynamically provisioned Quobyte volumes, value is set by the plugin";
        type = (types.nullOr types.str);
        default = null;
      };
      "user" = mkOption {
        description = "user to map volume access to\nDefaults to serivceaccount user";
        type = (types.nullOr types.str);
        default = null;
      };
      "volume" = mkOption {
        description = "volume is a string that references an already created Quobyte volume by name.";
        type = types.str;
      };
    };
  };
  mkVolumeQuobyte =
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
  VolumeRbdModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is the filesystem type of the volume that you want to mount.\nTip: Ensure that the filesystem type is supported by the host operating system.\nExamples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#rbd";
        type = (types.nullOr types.str);
        default = null;
      };
      "image" = mkOption {
        description = "image is the rados image name.\nMore info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it";
        type = types.str;
      };
      "keyring" = mkOption {
        description = "keyring is the path to key ring for RBDUser.\nDefault is /etc/ceph/keyring.\nMore info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it";
        type = (types.nullOr types.str);
        default = "/etc/ceph/keyring";
      };
      "monitors" = mkOption {
        description = "monitors is a collection of Ceph monitors.\nMore info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it";
        type = (types.listOf types.str);
      };
      "pool" = mkOption {
        description = "pool is the rados pool name.\nDefault is rbd.\nMore info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it";
        type = (types.nullOr types.str);
        default = "rbd";
      };
      "readOnly" = mkOption {
        description = "readOnly here will force the ReadOnly setting in VolumeMounts.\nDefaults to false.\nMore info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it";
        type = types.bool;
        default = false;
      };
      "secretRef" = mkOption {
        description = "secretRef is name of the authentication secret for RBDUser. If provided\noverrides keyring.\nDefault is nil.\nMore info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it";
        type = (types.nullOr VolumeRbdSecretRefModule);
        default = null;
      };
      "user" = mkOption {
        description = "user is the rados user name.\nDefault is admin.\nMore info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it";
        type = (types.nullOr types.str);
        default = "admin";
      };
    };
  };
  mkVolumeRbd =
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
    // optionalAttrs (res."secretRef" != null) { "secretRef" = mkVolumeRbdSecretRef res."secretRef"; }
    // {
    }
    // optionalAttrs (res."user" != null) { inherit (res) "user"; }
    // {
    };
  VolumeRbdSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkVolumeRbdSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  VolumeScaleIOModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is the filesystem type to mount.\nMust be a filesystem type supported by the host operating system.\nEx. \"ext4\", \"xfs\", \"ntfs\".\nDefault is \"xfs\".";
        type = (types.nullOr types.str);
        default = "xfs";
      };
      "gateway" = mkOption {
        description = "gateway is the host address of the ScaleIO API Gateway.";
        type = types.str;
      };
      "protectionDomain" = mkOption {
        description = "protectionDomain is the name of the ScaleIO Protection Domain for the configured storage.";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly Defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.";
        type = types.bool;
        default = false;
      };
      "secretRef" = mkOption {
        description = "secretRef references to the secret for ScaleIO user and other\nsensitive information. If this is not provided, Login operation will fail.";
        type = VolumeScaleIOSecretRefModule;
      };
      "sslEnabled" = mkOption {
        description = "sslEnabled Flag enable/disable SSL communication with Gateway, default false";
        type = types.bool;
        default = false;
      };
      "storageMode" = mkOption {
        description = "storageMode indicates whether the storage for a volume should be ThickProvisioned or ThinProvisioned.\nDefault is ThinProvisioned.";
        type = (types.nullOr types.str);
        default = "ThinProvisioned";
      };
      "storagePool" = mkOption {
        description = "storagePool is the ScaleIO Storage Pool associated with the protection domain.";
        type = (types.nullOr types.str);
        default = null;
      };
      "system" = mkOption {
        description = "system is the name of the storage system as configured in ScaleIO.";
        type = types.str;
      };
      "volumeName" = mkOption {
        description = "volumeName is the name of a volume already created in the ScaleIO system\nthat is associated with this volume source.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkVolumeScaleIO =
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
      "secretRef" = mkVolumeScaleIOSecretRef res."secretRef";
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
  VolumeScaleIOSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkVolumeScaleIOSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  VolumeSecretItemModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the key to project.";
        type = types.str;
      };
      "mode" = mkOption {
        description = "mode is Optional: mode bits used to set permissions on this file.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nIf not specified, the volume defaultMode will be used.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        description = "path is the relative path of the file to map the key to.\nMay not be an absolute path.\nMay not contain the path element '..'.\nMay not start with the string '..'.";
        type = types.str;
      };
    };
  };
  mkVolumeSecretItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    };
  VolumeSecretModule = types.submodule {
    options = {
      "defaultMode" = mkOption {
        description = "defaultMode is Optional: mode bits used to set permissions on created files by default.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values\nfor mode bits. Defaults to 0644.\nDirectories within the path are not affected by this setting.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "items" = mkOption {
        description = "items If unspecified, each key-value pair in the Data field of the referenced\nSecret will be projected into the volume as a file whose name is the\nkey and content is the value. If specified, the listed keys will be\nprojected into the specified paths, and unlisted keys will not be\npresent. If a key is specified which is not present in the Secret,\nthe volume setup will error unless it is marked optional. Paths must be\nrelative and may not contain the '..' path or start with '..'.";
        type = (types.listOf VolumeSecretItemModule);
        default = [ ];
      };
      "optional" = mkOption {
        description = "optional field specify whether the Secret or its keys must be defined";
        type = types.bool;
        default = false;
      };
      "secretName" = mkOption {
        description = "secretName is the name of the secret in the pod's namespace to use.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#secret";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkVolumeSecret =
    res:
    {
    }
    // optionalAttrs (res."defaultMode" != null) { inherit (res) "defaultMode"; }
    // {
    }
    // optionalAttrs (res."items" != [ ]) { "items" = map mkVolumeSecretItem res."items"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    }
    // optionalAttrs (res."secretName" != null) { inherit (res) "secretName"; }
    // {
    };
  VolumeStorageosModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is the filesystem type to mount.\nMust be a filesystem type supported by the host operating system.\nEx. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.";
        type = types.bool;
        default = false;
      };
      "secretRef" = mkOption {
        description = "secretRef specifies the secret to use for obtaining the StorageOS API\ncredentials.  If not specified, default values will be attempted.";
        type = (types.nullOr VolumeStorageosSecretRefModule);
        default = null;
      };
      "volumeName" = mkOption {
        description = "volumeName is the human-readable name of the StorageOS volume.  Volume\nnames are only unique within a namespace.";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeNamespace" = mkOption {
        description = "volumeNamespace specifies the scope of the volume within StorageOS.  If no\nnamespace is specified then the Pod's namespace will be used.  This allows the\nKubernetes name scoping to be mirrored within StorageOS for tighter integration.\nSet VolumeName to any name to override the default behaviour.\nSet to \"default\" if you are not using namespaces within StorageOS.\nNamespaces that do not pre-exist within StorageOS will be created.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkVolumeStorageos =
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
      "secretRef" = mkVolumeStorageosSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."volumeName" != null) { inherit (res) "volumeName"; }
    // {
    }
    // optionalAttrs (res."volumeNamespace" != null) { inherit (res) "volumeNamespace"; }
    // {
    };
  VolumeStorageosSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkVolumeStorageosSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  VolumeVsphereVolumeModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is filesystem type to mount.\nMust be a filesystem type supported by the host operating system.\nEx. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.";
        type = (types.nullOr types.str);
        default = null;
      };
      "storagePolicyID" = mkOption {
        description = "storagePolicyID is the storage Policy Based Management (SPBM) profile ID associated with the StoragePolicyName.";
        type = (types.nullOr types.str);
        default = null;
      };
      "storagePolicyName" = mkOption {
        description = "storagePolicyName is the storage Policy Based Management (SPBM) profile name.";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumePath" = mkOption {
        description = "volumePath is the path that identifies vSphere volume vmdk";
        type = types.str;
      };
    };
  };
  mkVolumeVsphereVolume =
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
  WebHttpConfigHeadersModule = types.submodule {
    options = {
      "contentSecurityPolicy" = mkOption {
        description = "Set the Content-Security-Policy header to HTTP responses.\nUnset if blank.";
        type = (types.nullOr types.str);
        default = null;
      };
      "strictTransportSecurity" = mkOption {
        description = "Set the Strict-Transport-Security header to HTTP responses.\nUnset if blank.\nPlease make sure that you use this with care as this header might force\nbrowsers to load Prometheus and the other applications hosted on the same\ndomain and subdomains over HTTPS.\nhttps://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Strict-Transport-Security";
        type = (types.nullOr types.str);
        default = null;
      };
      "xContentTypeOptions" = mkOption {
        description = "Set the X-Content-Type-Options header to HTTP responses.\nUnset if blank. Accepted value is nosniff.\nhttps://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Content-Type-Options";
        type = (
          types.nullOr (
            types.enum [
              ""
              "NoSniff"
            ]
          )
        );
        default = null;
      };
      "xFrameOptions" = mkOption {
        description = "Set the X-Frame-Options header to HTTP responses.\nUnset if blank. Accepted values are deny and sameorigin.\nhttps://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options";
        type = (
          types.nullOr (
            types.enum [
              ""
              "Deny"
              "SameOrigin"
            ]
          )
        );
        default = null;
      };
      "xXSSProtection" = mkOption {
        description = "Set the X-XSS-Protection header to all responses.\nUnset if blank.\nhttps://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-XSS-Protection";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkWebHttpConfigHeaders =
    res:
    {
    }
    // optionalAttrs (res."contentSecurityPolicy" != null) { inherit (res) "contentSecurityPolicy"; }
    // {
    }
    // optionalAttrs (res."strictTransportSecurity" != null) {
      inherit (res) "strictTransportSecurity";
    }
    // {
    }
    // optionalAttrs (res."xContentTypeOptions" != null) { inherit (res) "xContentTypeOptions"; }
    // {
    }
    // optionalAttrs (res."xFrameOptions" != null) { inherit (res) "xFrameOptions"; }
    // {
    }
    // optionalAttrs (res."xXSSProtection" != null) { inherit (res) "xXSSProtection"; }
    // {
    };
  WebHttpConfigModule = types.submodule {
    options = {
      "headers" = mkOption {
        description = "List of headers that can be added to HTTP responses.";
        type = (types.nullOr WebHttpConfigHeadersModule);
        default = null;
      };
      "http2" = mkOption {
        description = "Enable HTTP/2 support. Note that HTTP/2 is only supported with TLS.\nWhen TLSConfig is not configured, HTTP/2 will be disabled.\nWhenever the value of the field changes, a rolling update will be triggered.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkWebHttpConfig =
    res:
    {
    }
    // optionalAttrs (res."headers" != null) { "headers" = mkWebHttpConfigHeaders res."headers"; }
    // {
    }
    // optionalAttrs res."http2" { inherit (res) "http2"; }
    // {
    };
  WebModule = types.submodule {
    options = {
      "httpConfig" = mkOption {
        description = "Defines HTTP parameters for web server.";
        type = (types.nullOr WebHttpConfigModule);
        default = null;
      };
      "maxConnections" = mkOption {
        description = "Defines the maximum number of simultaneous connections\nA zero value means that Prometheus doesn't accept any incoming connection.";
        type = (types.nullOr types.int);
        default = null;
      };
      "pageTitle" = mkOption {
        description = "The prometheus web page title.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "Defines the TLS parameters for HTTPS.";
        type = (types.nullOr WebTlsConfigModule);
        default = null;
      };
    };
  };
  mkWeb =
    res:
    {
    }
    // optionalAttrs (res."httpConfig" != null) { "httpConfig" = mkWebHttpConfig res."httpConfig"; }
    // {
    }
    // optionalAttrs (res."maxConnections" != null) { inherit (res) "maxConnections"; }
    // {
    }
    // optionalAttrs (res."pageTitle" != null) { inherit (res) "pageTitle"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) { "tlsConfig" = mkWebTlsConfig res."tlsConfig"; }
    // {
    };
  WebTlsConfigCertConfigMapModule = types.submodule {
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
  mkWebTlsConfigCertConfigMap =
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
  WebTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr WebTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr WebTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkWebTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkWebTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkWebTlsConfigCertSecret res."secret"; }
    // {
    };
  WebTlsConfigCertSecretModule = types.submodule {
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
  mkWebTlsConfigCertSecret =
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
  WebTlsConfigClient_caConfigMapModule = types.submodule {
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
  mkWebTlsConfigClient_caConfigMap =
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
  WebTlsConfigClient_caModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr WebTlsConfigClient_caConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr WebTlsConfigClient_caSecretModule);
        default = null;
      };
    };
  };
  mkWebTlsConfigClient_ca =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkWebTlsConfigClient_caConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkWebTlsConfigClient_caSecret res."secret"; }
    // {
    };
  WebTlsConfigClient_caSecretModule = types.submodule {
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
  mkWebTlsConfigClient_caSecret =
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
  WebTlsConfigKeySecretModule = types.submodule {
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
  mkWebTlsConfigKeySecret =
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
  WebTlsConfigModule = types.submodule {
    options = {
      "cert" = mkOption {
        description = "Secret or ConfigMap containing the TLS certificate for the web server.\n\nEither `keySecret` or `keyFile` must be defined.\n\nIt is mutually exclusive with `certFile`.";
        type = (types.nullOr WebTlsConfigCertModule);
        default = null;
      };
      "certFile" = mkOption {
        description = "Path to the TLS certificate file in the container for the web server.\n\nEither `keySecret` or `keyFile` must be defined.\n\nIt is mutually exclusive with `cert`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "cipherSuites" = mkOption {
        description = "List of supported cipher suites for TLS versions up to TLS 1.2.\n\nIf not defined, the Go default cipher suites are used.\nAvailable cipher suites are documented in the Go documentation:\nhttps://golang.org/pkg/crypto/tls/#pkg-constants";
        type = (types.listOf types.str);
        default = [ ];
      };
      "clientAuthType" = mkOption {
        description = "The server policy for client TLS authentication.\n\nFor more detail on clientAuth options:\nhttps://golang.org/pkg/crypto/tls/#ClientAuthType";
        type = (types.nullOr types.str);
        default = null;
      };
      "clientCAFile" = mkOption {
        description = "Path to the CA certificate file for client certificate authentication to\nthe server.\n\nIt is mutually exclusive with `client_ca`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "client_ca" = mkOption {
        description = "Secret or ConfigMap containing the CA certificate for client certificate\nauthentication to the server.\n\nIt is mutually exclusive with `clientCAFile`.";
        type = (types.nullOr WebTlsConfigClient_caModule);
        default = null;
      };
      "curvePreferences" = mkOption {
        description = "Elliptic curves that will be used in an ECDHE handshake, in preference\norder.\n\nAvailable curves are documented in the Go documentation:\nhttps://golang.org/pkg/crypto/tls/#CurveID";
        type = (types.listOf types.str);
        default = [ ];
      };
      "keyFile" = mkOption {
        description = "Path to the TLS private key file in the container for the web server.\n\nIf defined, either `cert` or `certFile` must be defined.\n\nIt is mutually exclusive with `keySecret`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "keySecret" = mkOption {
        description = "Secret containing the TLS private key for the web server.\n\nEither `cert` or `certFile` must be defined.\n\nIt is mutually exclusive with `keyFile`.";
        type = (types.nullOr WebTlsConfigKeySecretModule);
        default = null;
      };
      "maxVersion" = mkOption {
        description = "Maximum TLS version that is acceptable.";
        type = (types.nullOr types.str);
        default = null;
      };
      "minVersion" = mkOption {
        description = "Minimum TLS version that is acceptable.";
        type = (types.nullOr types.str);
        default = null;
      };
      "preferServerCipherSuites" = mkOption {
        description = "Controls whether the server selects the client's most preferred cipher\nsuite, or the server's most preferred cipher suite.\n\nIf true then the server's preference, as expressed in\nthe order of elements in cipherSuites, is used.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkWebTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkWebTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs (res."certFile" != null) { inherit (res) "certFile"; }
    // {
    }
    // optionalAttrs (res."cipherSuites" != [ ]) { inherit (res) "cipherSuites"; }
    // {
    }
    // optionalAttrs (res."clientAuthType" != null) { inherit (res) "clientAuthType"; }
    // {
    }
    // optionalAttrs (res."clientCAFile" != null) { inherit (res) "clientCAFile"; }
    // {
    }
    // optionalAttrs (res."client_ca" != null) {
      "client_ca" = mkWebTlsConfigClient_ca res."client_ca";
    }
    // {
    }
    // optionalAttrs (res."curvePreferences" != [ ]) { inherit (res) "curvePreferences"; }
    // {
    }
    // optionalAttrs (res."keyFile" != null) { inherit (res) "keyFile"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkWebTlsConfigKeySecret res."keySecret";
    }
    // {
    }
    // optionalAttrs (res."maxVersion" != null) { inherit (res) "maxVersion"; }
    // {
    }
    // optionalAttrs (res."minVersion" != null) { inherit (res) "minVersion"; }
    // {
    }
    // optionalAttrs res."preferServerCipherSuites" { inherit (res) "preferServerCipherSuites"; }
    // {
    };
  PrometheusagentsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this PrometheusAgent resource.";
        };
        "additionalArgs" = mkOption {
          description = "AdditionalArgs allows setting additional arguments for the 'prometheus' container.\n\nIt is intended for e.g. activating hidden flags which are not supported by\nthe dedicated configuration options yet. The arguments are passed as-is to the\nPrometheus container which may cause issues if they are invalid or not supported\nby the given Prometheus version.\n\nIn case of an argument conflict (e.g. an argument which is already set by the\noperator itself) or when providing an invalid argument, the reconciliation will\nfail and an error will be logged.";
          type = (types.listOf AdditionalArgModule);
          default = [ ];
        };
        "additionalScrapeConfigs" = mkOption {
          description = "AdditionalScrapeConfigs allows specifying a key of a Secret containing\nadditional Prometheus scrape configurations. Scrape configurations\nspecified are appended to the configurations generated by the Prometheus\nOperator. Job configurations specified must have the form as specified\nin the official Prometheus documentation:\nhttps://prometheus.io/docs/prometheus/latest/configuration/configuration/#scrape_config.\nAs scrape configs are appended, the user is responsible to make sure it\nis valid. Note that using this feature may expose the possibility to\nbreak upgrades of Prometheus. It is advised to review Prometheus release\nnotes to ensure that no incompatible scrape configs are going to break\nPrometheus after the upgrade.";
          type = (types.nullOr AdditionalScrapeConfigsModule);
          default = null;
        };
        "affinity" = mkOption {
          description = "Defines the Pods' affinity scheduling rules if specified.";
          type = (types.nullOr AffinityModule);
          default = null;
        };
        "apiserverConfig" = mkOption {
          description = "APIServerConfig allows specifying a host and auth methods to access the\nKuberntees API server.\nIf null, Prometheus is assumed to run inside of the cluster: it will\ndiscover the API servers automatically and use the Pod's CA certificate\nand bearer token file at /var/run/secrets/kubernetes.io/serviceaccount/.";
          type = (types.nullOr ApiserverConfigModule);
          default = null;
        };
        "arbitraryFSAccessThroughSMs" = mkOption {
          description = "When true, ServiceMonitor, PodMonitor and Probe object are forbidden to\nreference arbitrary files on the file system of the 'prometheus'\ncontainer.\nWhen a ServiceMonitor's endpoint specifies a `bearerTokenFile` value\n(e.g.  '/var/run/secrets/kubernetes.io/serviceaccount/token'), a\nmalicious target can get access to the Prometheus service account's\ntoken in the Prometheus' scrape request. Setting\n`spec.arbitraryFSAccessThroughSM` to 'true' would prevent the attack.\nUsers should instead provide the credentials using the\n`spec.bearerTokenSecret` field.";
          type = (types.nullOr ArbitraryFSAccessThroughSMsModule);
          default = null;
        };
        "automountServiceAccountToken" = mkOption {
          description = "AutomountServiceAccountToken indicates whether a service account token should be automatically mounted in the pod.\nIf the field isn't set, the operator mounts the service account token by default.\n\n**Warning:** be aware that by default, Prometheus requires the service account token for Kubernetes service discovery.\nIt is possible to use strategic merge patch to project the service account token into the 'prometheus' container.";
          type = types.bool;
          default = false;
        };
        "bodySizeLimit" = mkOption {
          description = "BodySizeLimit defines per-scrape on response body size.\nOnly valid in Prometheus versions 2.45.0 and newer.\n\nNote that the global limit only applies to scrape objects that don't specify an explicit limit value.\nIf you want to enforce a maximum limit for all scrape objects, refer to enforcedBodySizeLimit.";
          type = (types.nullOr types.str);
          default = null;
        };
        "configMaps" = mkOption {
          description = "ConfigMaps is a list of ConfigMaps in the same namespace as the Prometheus\nobject, which shall be mounted into the Prometheus Pods.\nEach ConfigMap is added to the StatefulSet definition as a volume named `configmap-<configmap-name>`.\nThe ConfigMaps are mounted into /etc/prometheus/configmaps/<configmap-name> in the 'prometheus' container.";
          type = (types.listOf types.str);
          default = [ ];
        };
        "containers" = mkOption {
          description = "Containers allows injecting additional containers or modifying operator\ngenerated containers. This can be used to allow adding an authentication\nproxy to the Pods or to change the behavior of an operator generated\ncontainer. Containers described here modify an operator generated\ncontainer if they share the same name and modifications are done via a\nstrategic merge patch.\n\nThe names of containers managed by the operator are:\n* `prometheus`\n* `config-reloader`\n* `thanos-sidecar`\n\nOverriding containers is entirely outside the scope of what the\nmaintainers will support and by doing so, you accept that this behaviour\nmay break at any time without notice.";
          type = (types.listOf ContainerModule);
          default = [ ];
        };
        "convertClassicHistogramsToNHCB" = mkOption {
          description = "Whether to convert all scraped classic histograms into a native\nhistogram with custom buckets.\n\nIt requires Prometheus >= v3.4.0.";
          type = types.bool;
          default = false;
        };
        "dnsConfig" = mkOption {
          description = "Defines the DNS configuration for the pods.";
          type = (types.nullOr DnsConfigModule);
          default = null;
        };
        "dnsPolicy" = mkOption {
          description = "Defines the DNS policy for the pods.";
          type = (
            types.nullOr (
              types.enum [
                "ClusterFirstWithHostNet"
                "ClusterFirst"
                "Default"
                "None"
              ]
            )
          );
          default = null;
        };
        "enableFeatures" = mkOption {
          description = "Enable access to Prometheus feature flags. By default, no features are enabled.\n\nEnabling features which are disabled by default is entirely outside the\nscope of what the maintainers will support and by doing so, you accept\nthat this behaviour may break at any time without notice.\n\nFor more information see https://prometheus.io/docs/prometheus/latest/feature_flags/";
          type = (types.listOf types.str);
          default = [ ];
        };
        "enableOTLPReceiver" = mkOption {
          description = "Enable Prometheus to be used as a receiver for the OTLP Metrics protocol.\n\nNote that the OTLP receiver endpoint is automatically enabled if `.spec.otlpConfig` is defined.\n\nIt requires Prometheus >= v2.47.0.";
          type = types.bool;
          default = false;
        };
        "enableRemoteWriteReceiver" = mkOption {
          description = "Enable Prometheus to be used as a receiver for the Prometheus remote\nwrite protocol.\n\nWARNING: This is not considered an efficient way of ingesting samples.\nUse it with caution for specific low-volume use cases.\nIt is not suitable for replacing the ingestion via scraping and turning\nPrometheus into a push-based metrics collection system.\nFor more information see https://prometheus.io/docs/prometheus/latest/querying/api/#remote-write-receiver\n\nIt requires Prometheus >= v2.33.0.";
          type = types.bool;
          default = false;
        };
        "enableServiceLinks" = mkOption {
          description = "Indicates whether information about services should be injected into pod's environment variables";
          type = types.bool;
          default = false;
        };
        "enforcedBodySizeLimit" = mkOption {
          description = "When defined, enforcedBodySizeLimit specifies a global limit on the size\nof uncompressed response body that will be accepted by Prometheus.\nTargets responding with a body larger than this many bytes will cause\nthe scrape to fail.\n\nIt requires Prometheus >= v2.28.0.\n\nWhen both `enforcedBodySizeLimit` and `bodySizeLimit` are defined and greater than zero, the following rules apply:\n* Scrape objects without a defined bodySizeLimit value will inherit the global bodySizeLimit value (Prometheus >= 2.45.0) or the enforcedBodySizeLimit value (Prometheus < v2.45.0).\n  If Prometheus version is >= 2.45.0 and the `enforcedBodySizeLimit` is greater than the `bodySizeLimit`, the `bodySizeLimit` will be set to `enforcedBodySizeLimit`.\n* Scrape objects with a bodySizeLimit value less than or equal to enforcedBodySizeLimit keep their specific value.\n* Scrape objects with a bodySizeLimit value greater than enforcedBodySizeLimit are set to enforcedBodySizeLimit.";
          type = (types.nullOr types.str);
          default = null;
        };
        "enforcedKeepDroppedTargets" = mkOption {
          description = "When defined, enforcedKeepDroppedTargets specifies a global limit on the number of targets\ndropped by relabeling that will be kept in memory. The value overrides\nany `spec.keepDroppedTargets` set by\nServiceMonitor, PodMonitor, Probe objects unless `spec.keepDroppedTargets` is\ngreater than zero and less than `spec.enforcedKeepDroppedTargets`.\n\nIt requires Prometheus >= v2.47.0.\n\nWhen both `enforcedKeepDroppedTargets` and `keepDroppedTargets` are defined and greater than zero, the following rules apply:\n* Scrape objects without a defined keepDroppedTargets value will inherit the global keepDroppedTargets value (Prometheus >= 2.45.0) or the enforcedKeepDroppedTargets value (Prometheus < v2.45.0).\n  If Prometheus version is >= 2.45.0 and the `enforcedKeepDroppedTargets` is greater than the `keepDroppedTargets`, the `keepDroppedTargets` will be set to `enforcedKeepDroppedTargets`.\n* Scrape objects with a keepDroppedTargets value less than or equal to enforcedKeepDroppedTargets keep their specific value.\n* Scrape objects with a keepDroppedTargets value greater than enforcedKeepDroppedTargets are set to enforcedKeepDroppedTargets.";
          type = (types.nullOr types.int);
          default = null;
        };
        "enforcedLabelLimit" = mkOption {
          description = "When defined, enforcedLabelLimit specifies a global limit on the number\nof labels per sample. The value overrides any `spec.labelLimit` set by\nServiceMonitor, PodMonitor, Probe objects unless `spec.labelLimit` is\ngreater than zero and less than `spec.enforcedLabelLimit`.\n\nIt requires Prometheus >= v2.27.0.\n\nWhen both `enforcedLabelLimit` and `labelLimit` are defined and greater than zero, the following rules apply:\n* Scrape objects without a defined labelLimit value will inherit the global labelLimit value (Prometheus >= 2.45.0) or the enforcedLabelLimit value (Prometheus < v2.45.0).\n  If Prometheus version is >= 2.45.0 and the `enforcedLabelLimit` is greater than the `labelLimit`, the `labelLimit` will be set to `enforcedLabelLimit`.\n* Scrape objects with a labelLimit value less than or equal to enforcedLabelLimit keep their specific value.\n* Scrape objects with a labelLimit value greater than enforcedLabelLimit are set to enforcedLabelLimit.";
          type = (types.nullOr types.int);
          default = null;
        };
        "enforcedLabelNameLengthLimit" = mkOption {
          description = "When defined, enforcedLabelNameLengthLimit specifies a global limit on the length\nof labels name per sample. The value overrides any `spec.labelNameLengthLimit` set by\nServiceMonitor, PodMonitor, Probe objects unless `spec.labelNameLengthLimit` is\ngreater than zero and less than `spec.enforcedLabelNameLengthLimit`.\n\nIt requires Prometheus >= v2.27.0.\n\nWhen both `enforcedLabelNameLengthLimit` and `labelNameLengthLimit` are defined and greater than zero, the following rules apply:\n* Scrape objects without a defined labelNameLengthLimit value will inherit the global labelNameLengthLimit value (Prometheus >= 2.45.0) or the enforcedLabelNameLengthLimit value (Prometheus < v2.45.0).\n  If Prometheus version is >= 2.45.0 and the `enforcedLabelNameLengthLimit` is greater than the `labelNameLengthLimit`, the `labelNameLengthLimit` will be set to `enforcedLabelNameLengthLimit`.\n* Scrape objects with a labelNameLengthLimit value less than or equal to enforcedLabelNameLengthLimit keep their specific value.\n* Scrape objects with a labelNameLengthLimit value greater than enforcedLabelNameLengthLimit are set to enforcedLabelNameLengthLimit.";
          type = (types.nullOr types.int);
          default = null;
        };
        "enforcedLabelValueLengthLimit" = mkOption {
          description = "When not null, enforcedLabelValueLengthLimit defines a global limit on the length\nof labels value per sample. The value overrides any `spec.labelValueLengthLimit` set by\nServiceMonitor, PodMonitor, Probe objects unless `spec.labelValueLengthLimit` is\ngreater than zero and less than `spec.enforcedLabelValueLengthLimit`.\n\nIt requires Prometheus >= v2.27.0.\n\nWhen both `enforcedLabelValueLengthLimit` and `labelValueLengthLimit` are defined and greater than zero, the following rules apply:\n* Scrape objects without a defined labelValueLengthLimit value will inherit the global labelValueLengthLimit value (Prometheus >= 2.45.0) or the enforcedLabelValueLengthLimit value (Prometheus < v2.45.0).\n  If Prometheus version is >= 2.45.0 and the `enforcedLabelValueLengthLimit` is greater than the `labelValueLengthLimit`, the `labelValueLengthLimit` will be set to `enforcedLabelValueLengthLimit`.\n* Scrape objects with a labelValueLengthLimit value less than or equal to enforcedLabelValueLengthLimit keep their specific value.\n* Scrape objects with a labelValueLengthLimit value greater than enforcedLabelValueLengthLimit are set to enforcedLabelValueLengthLimit.";
          type = (types.nullOr types.int);
          default = null;
        };
        "enforcedNamespaceLabel" = mkOption {
          description = "When not empty, a label will be added to:\n\n1. All metrics scraped from `ServiceMonitor`, `PodMonitor`, `Probe` and `ScrapeConfig` objects.\n2. All metrics generated from recording rules defined in `PrometheusRule` objects.\n3. All alerts generated from alerting rules defined in `PrometheusRule` objects.\n4. All vector selectors of PromQL expressions defined in `PrometheusRule` objects.\n\nThe label will not added for objects referenced in `spec.excludedFromEnforcement`.\n\nThe label's name is this field's value.\nThe label's value is the namespace of the `ServiceMonitor`,\n`PodMonitor`, `Probe`, `PrometheusRule` or `ScrapeConfig` object.";
          type = (types.nullOr types.str);
          default = null;
        };
        "enforcedSampleLimit" = mkOption {
          description = "When defined, enforcedSampleLimit specifies a global limit on the number\nof scraped samples that will be accepted. This overrides any\n`spec.sampleLimit` set by ServiceMonitor, PodMonitor, Probe objects\nunless `spec.sampleLimit` is greater than zero and less than\n`spec.enforcedSampleLimit`.\n\nIt is meant to be used by admins to keep the overall number of\nsamples/series under a desired limit.\n\nWhen both `enforcedSampleLimit` and `sampleLimit` are defined and greater than zero, the following rules apply:\n* Scrape objects without a defined sampleLimit value will inherit the global sampleLimit value (Prometheus >= 2.45.0) or the enforcedSampleLimit value (Prometheus < v2.45.0).\n  If Prometheus version is >= 2.45.0 and the `enforcedSampleLimit` is greater than the `sampleLimit`, the `sampleLimit` will be set to `enforcedSampleLimit`.\n* Scrape objects with a sampleLimit value less than or equal to enforcedSampleLimit keep their specific value.\n* Scrape objects with a sampleLimit value greater than enforcedSampleLimit are set to enforcedSampleLimit.";
          type = (types.nullOr types.int);
          default = null;
        };
        "enforcedTargetLimit" = mkOption {
          description = "When defined, enforcedTargetLimit specifies a global limit on the number\nof scraped targets. The value overrides any `spec.targetLimit` set by\nServiceMonitor, PodMonitor, Probe objects unless `spec.targetLimit` is\ngreater than zero and less than `spec.enforcedTargetLimit`.\n\nIt is meant to be used by admins to to keep the overall number of\ntargets under a desired limit.\n\nWhen both `enforcedTargetLimit` and `targetLimit` are defined and greater than zero, the following rules apply:\n* Scrape objects without a defined targetLimit value will inherit the global targetLimit value (Prometheus >= 2.45.0) or the enforcedTargetLimit value (Prometheus < v2.45.0).\n  If Prometheus version is >= 2.45.0 and the `enforcedTargetLimit` is greater than the `targetLimit`, the `targetLimit` will be set to `enforcedTargetLimit`.\n* Scrape objects with a targetLimit value less than or equal to enforcedTargetLimit keep their specific value.\n* Scrape objects with a targetLimit value greater than enforcedTargetLimit are set to enforcedTargetLimit.";
          type = (types.nullOr types.int);
          default = null;
        };
        "excludedFromEnforcement" = mkOption {
          description = "List of references to PodMonitor, ServiceMonitor, Probe and PrometheusRule objects\nto be excluded from enforcing a namespace label of origin.\n\nIt is only applicable if `spec.enforcedNamespaceLabel` set to true.";
          type = (types.listOf ExcludedFromEnforcementModule);
          default = [ ];
        };
        "externalLabels" = mkOption {
          description = "The labels to add to any time series or alerts when communicating with\nexternal systems (federation, remote storage, Alertmanager).\nLabels defined by `spec.replicaExternalLabelName` and\n`spec.prometheusExternalLabelName` take precedence over this list.";
          type = (types.attrsOf types.str);
          default = { };
        };
        "externalUrl" = mkOption {
          description = "The external URL under which the Prometheus service is externally\navailable. This is necessary to generate correct URLs (for instance if\nPrometheus is accessible behind an Ingress resource).";
          type = (types.nullOr types.str);
          default = null;
        };
        "hostAliases" = mkOption {
          description = "Optional list of hosts and IPs that will be injected into the Pod's\nhosts file if specified.";
          type = (types.listOf HostAliaseModule);
          default = [ ];
        };
        "hostNetwork" = mkOption {
          description = "Use the host's network namespace if true.\n\nMake sure to understand the security implications if you want to enable\nit (https://kubernetes.io/docs/concepts/configuration/overview/ ).\n\nWhen hostNetwork is enabled, this will set the DNS policy to\n`ClusterFirstWithHostNet` automatically (unless `.spec.DNSPolicy` is set\nto a different value).";
          type = types.bool;
          default = false;
        };
        "hostUsers" = mkOption {
          description = "HostUsers supports the user space in Kubernetes.\n\nMore info: https://kubernetes.io/docs/tasks/configure-pod-container/user-namespaces/\n\nThe feature requires at least Kubernetes 1.28 with the `UserNamespacesSupport` feature gate enabled.\nStarting Kubernetes 1.33, the feature is enabled by default.";
          type = types.bool;
          default = false;
        };
        "ignoreNamespaceSelectors" = mkOption {
          description = "When true, `spec.namespaceSelector` from all PodMonitor, ServiceMonitor\nand Probe objects will be ignored. They will only discover targets\nwithin the namespace of the PodMonitor, ServiceMonitor and Probe\nobject.";
          type = types.bool;
          default = false;
        };
        "image" = mkOption {
          description = "Container image name for Prometheus. If specified, it takes precedence\nover the `spec.baseImage`, `spec.tag` and `spec.sha` fields.\n\nSpecifying `spec.version` is still necessary to ensure the Prometheus\nOperator knows which version of Prometheus is being configured.\n\nIf neither `spec.image` nor `spec.baseImage` are defined, the operator\nwill use the latest upstream version of Prometheus available at the time\nwhen the operator was released.";
          type = (types.nullOr types.str);
          default = null;
        };
        "imagePullPolicy" = mkOption {
          description = "Image pull policy for the 'prometheus', 'init-config-reloader' and 'config-reloader' containers.\nSee https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy for more details.";
          type = (
            types.nullOr (
              types.enum [
                ""
                "Always"
                "Never"
                "IfNotPresent"
              ]
            )
          );
          default = null;
        };
        "imagePullSecrets" = mkOption {
          description = "An optional list of references to Secrets in the same namespace\nto use for pulling images from registries.\nSee http://kubernetes.io/docs/user-guide/images#specifying-imagepullsecrets-on-a-pod";
          type = (types.listOf ImagePullSecretModule);
          default = [ ];
        };
        "initContainers" = mkOption {
          description = "InitContainers allows injecting initContainers to the Pod definition. Those\ncan be used to e.g.  fetch secrets for injection into the Prometheus\nconfiguration from external sources. Any errors during the execution of\nan initContainer will lead to a restart of the Pod. More info:\nhttps://kubernetes.io/docs/concepts/workloads/pods/init-containers/\nInitContainers described here modify an operator generated init\ncontainers if they share the same name and modifications are done via a\nstrategic merge patch.\n\nThe names of init container name managed by the operator are:\n* `init-config-reloader`.\n\nOverriding init containers is entirely outside the scope of what the\nmaintainers will support and by doing so, you accept that this behaviour\nmay break at any time without notice.";
          type = (types.listOf InitContainerModule);
          default = [ ];
        };
        "keepDroppedTargets" = mkOption {
          description = "Per-scrape limit on the number of targets dropped by relabeling\nthat will be kept in memory. 0 means no limit.\n\nIt requires Prometheus >= v2.47.0.\n\nNote that the global limit only applies to scrape objects that don't specify an explicit limit value.\nIf you want to enforce a maximum limit for all scrape objects, refer to enforcedKeepDroppedTargets.";
          type = (types.nullOr types.int);
          default = null;
        };
        "labelLimit" = mkOption {
          description = "Per-scrape limit on number of labels that will be accepted for a sample.\nOnly valid in Prometheus versions 2.45.0 and newer.\n\nNote that the global limit only applies to scrape objects that don't specify an explicit limit value.\nIf you want to enforce a maximum limit for all scrape objects, refer to enforcedLabelLimit.";
          type = (types.nullOr types.int);
          default = null;
        };
        "labelNameLengthLimit" = mkOption {
          description = "Per-scrape limit on length of labels name that will be accepted for a sample.\nOnly valid in Prometheus versions 2.45.0 and newer.\n\nNote that the global limit only applies to scrape objects that don't specify an explicit limit value.\nIf you want to enforce a maximum limit for all scrape objects, refer to enforcedLabelNameLengthLimit.";
          type = (types.nullOr types.int);
          default = null;
        };
        "labelValueLengthLimit" = mkOption {
          description = "Per-scrape limit on length of labels value that will be accepted for a sample.\nOnly valid in Prometheus versions 2.45.0 and newer.\n\nNote that the global limit only applies to scrape objects that don't specify an explicit limit value.\nIf you want to enforce a maximum limit for all scrape objects, refer to enforcedLabelValueLengthLimit.";
          type = (types.nullOr types.int);
          default = null;
        };
        "listenLocal" = mkOption {
          description = "When true, the Prometheus server listens on the loopback address\ninstead of the Pod IP's address.";
          type = types.bool;
          default = false;
        };
        "logFormat" = mkOption {
          description = "Log format for Log level for Prometheus and the config-reloader sidecar.";
          type = (
            types.nullOr (
              types.enum [
                ""
                "logfmt"
                "json"
              ]
            )
          );
          default = null;
        };
        "logLevel" = mkOption {
          description = "Log level for Prometheus and the config-reloader sidecar.";
          type = (
            types.nullOr (
              types.enum [
                ""
                "debug"
                "info"
                "warn"
                "error"
              ]
            )
          );
          default = null;
        };
        "maximumStartupDurationSeconds" = mkOption {
          description = "Defines the maximum time that the `prometheus` container's startup probe will wait before being considered failed. The startup probe will return success after the WAL replay is complete.\nIf set, the value should be greater than 60 (seconds). Otherwise it will be equal to 600 seconds (15 minutes).";
          type = (types.nullOr types.int);
          default = null;
        };
        "minReadySeconds" = mkOption {
          description = "Minimum number of seconds for which a newly created Pod should be ready\nwithout any of its container crashing for it to be considered available.\n\nIf unset, pods will be considered available as soon as they are ready.";
          type = (types.nullOr types.int);
          default = null;
        };
        "mode" = mkOption {
          description = "Mode defines how the Prometheus operator deploys the PrometheusAgent pod(s).\n\n(Alpha) Using this field requires the `PrometheusAgentDaemonSet` feature gate to be enabled.";
          type = (
            types.nullOr (
              types.enum [
                "StatefulSet"
                "DaemonSet"
              ]
            )
          );
          default = null;
        };
        "nameEscapingScheme" = mkOption {
          description = "Specifies the character escaping scheme that will be requested when scraping\nfor metric and label names that do not conform to the legacy Prometheus\ncharacter set.\n\nIt requires Prometheus >= v3.4.0.";
          type = (
            types.nullOr (
              types.enum [
                "AllowUTF8"
                "Underscores"
                "Dots"
                "Values"
              ]
            )
          );
          default = null;
        };
        "nameValidationScheme" = mkOption {
          description = "Specifies the validation scheme for metric and label names.\n\nIt requires Prometheus >= v2.55.0.";
          type = (
            types.nullOr (
              types.enum [
                "UTF8"
                "Legacy"
              ]
            )
          );
          default = null;
        };
        "nodeSelector" = mkOption {
          description = "Defines on which Nodes the Pods are scheduled.";
          type = (types.attrsOf types.str);
          default = { };
        };
        "otlp" = mkOption {
          description = "Settings related to the OTLP receiver feature.\nIt requires Prometheus >= v2.55.0.";
          type = (types.nullOr OtlpModule);
          default = null;
        };
        "overrideHonorLabels" = mkOption {
          description = "When true, Prometheus resolves label conflicts by renaming the labels in the scraped data\n to “exported_” for all targets created from ServiceMonitor, PodMonitor and\nScrapeConfig objects. Otherwise the HonorLabels field of the service or pod monitor applies.\nIn practice,`overrideHonorLaels:true` enforces `honorLabels:false`\nfor all ServiceMonitor, PodMonitor and ScrapeConfig objects.";
          type = types.bool;
          default = false;
        };
        "overrideHonorTimestamps" = mkOption {
          description = "When true, Prometheus ignores the timestamps for all the targets created\nfrom service and pod monitors.\nOtherwise the HonorTimestamps field of the service or pod monitor applies.";
          type = types.bool;
          default = false;
        };
        "paused" = mkOption {
          description = "When a Prometheus deployment is paused, no actions except for deletion\nwill be performed on the underlying objects.";
          type = types.bool;
          default = false;
        };
        "persistentVolumeClaimRetentionPolicy" = mkOption {
          description = "The field controls if and how PVCs are deleted during the lifecycle of a StatefulSet.\nThe default behavior is all PVCs are retained.\nThis is an alpha field from kubernetes 1.23 until 1.26 and a beta field from 1.26.\nIt requires enabling the StatefulSetAutoDeletePVC feature gate.";
          type = (types.nullOr PersistentVolumeClaimRetentionPolicyModule);
          default = null;
        };
        "podMetadata" = mkOption {
          description = "PodMetadata configures labels and annotations which are propagated to the Prometheus pods.\n\nThe following items are reserved and cannot be overridden:\n* \"prometheus\" label, set to the name of the Prometheus object.\n* \"app.kubernetes.io/instance\" label, set to the name of the Prometheus object.\n* \"app.kubernetes.io/managed-by\" label, set to \"prometheus-operator\".\n* \"app.kubernetes.io/name\" label, set to \"prometheus\".\n* \"app.kubernetes.io/version\" label, set to the Prometheus version.\n* \"operator.prometheus.io/name\" label, set to the name of the Prometheus object.\n* \"operator.prometheus.io/shard\" label, set to the shard number of the Prometheus object.\n* \"kubectl.kubernetes.io/default-container\" annotation, set to \"prometheus\".";
          type = (types.nullOr PodMetadataModule);
          default = null;
        };
        "podMonitorNamespaceSelector" = mkOption {
          description = "Namespaces to match for PodMonitors discovery. An empty label selector\nmatches all namespaces. A null label selector (default value) matches the current\nnamespace only.";
          type = (types.nullOr PodMonitorNamespaceSelectorModule);
          default = null;
        };
        "podMonitorSelector" = mkOption {
          description = "PodMonitors to be selected for target discovery. An empty label selector\nmatches all objects. A null label selector matches no objects.\n\nIf `spec.serviceMonitorSelector`, `spec.podMonitorSelector`, `spec.probeSelector`\nand `spec.scrapeConfigSelector` are null, the Prometheus configuration is unmanaged.\nThe Prometheus operator will ensure that the Prometheus configuration's\nSecret exists, but it is the responsibility of the user to provide the raw\ngzipped Prometheus configuration under the `prometheus.yaml.gz` key.\nThis behavior is *deprecated* and will be removed in the next major version\nof the custom resource definition. It is recommended to use\n`spec.additionalScrapeConfigs` instead.";
          type = (types.nullOr PodMonitorSelectorModule);
          default = null;
        };
        "podTargetLabels" = mkOption {
          description = "PodTargetLabels are appended to the `spec.podTargetLabels` field of all\nPodMonitor and ServiceMonitor objects.";
          type = (types.listOf types.str);
          default = [ ];
        };
        "portName" = mkOption {
          description = "Port name used for the pods and governing service.\nDefault: \"web\"";
          type = (types.nullOr types.str);
          default = "web";
        };
        "priorityClassName" = mkOption {
          description = "Priority class assigned to the Pods.";
          type = (types.nullOr types.str);
          default = null;
        };
        "probeNamespaceSelector" = mkOption {
          description = "Namespaces to match for Probe discovery. An empty label\nselector matches all namespaces. A null label selector matches the\ncurrent namespace only.";
          type = (types.nullOr ProbeNamespaceSelectorModule);
          default = null;
        };
        "probeSelector" = mkOption {
          description = "Probes to be selected for target discovery. An empty label selector\nmatches all objects. A null label selector matches no objects.\n\nIf `spec.serviceMonitorSelector`, `spec.podMonitorSelector`, `spec.probeSelector`\nand `spec.scrapeConfigSelector` are null, the Prometheus configuration is unmanaged.\nThe Prometheus operator will ensure that the Prometheus configuration's\nSecret exists, but it is the responsibility of the user to provide the raw\ngzipped Prometheus configuration under the `prometheus.yaml.gz` key.\nThis behavior is *deprecated* and will be removed in the next major version\nof the custom resource definition. It is recommended to use\n`spec.additionalScrapeConfigs` instead.";
          type = (types.nullOr ProbeSelectorModule);
          default = null;
        };
        "prometheusExternalLabelName" = mkOption {
          description = "Name of Prometheus external label used to denote the Prometheus instance\nname. The external label will _not_ be added when the field is set to\nthe empty string (`\"\"`).\n\nDefault: \"prometheus\"";
          type = (types.nullOr types.str);
          default = null;
        };
        "reloadStrategy" = mkOption {
          description = "Defines the strategy used to reload the Prometheus configuration.\nIf not specified, the configuration is reloaded using the /-/reload HTTP endpoint.";
          type = (
            types.nullOr (
              types.enum [
                "HTTP"
                "ProcessSignal"
              ]
            )
          );
          default = null;
        };
        "remoteWrite" = mkOption {
          description = "Defines the list of remote write configurations.";
          type = (types.listOf RemoteWriteModule);
          default = [ ];
        };
        "remoteWriteReceiverMessageVersions" = mkOption {
          description = "List of the protobuf message versions to accept when receiving the\nremote writes.\n\nIt requires Prometheus >= v2.54.0.";
          type = (
            types.listOf (
              types.enum [
                "V1.0"
                "V2.0"
              ]
            )
          );
          default = [ ];
        };
        "replicaExternalLabelName" = mkOption {
          description = "Name of Prometheus external label used to denote the replica name.\nThe external label will _not_ be added when the field is set to the\nempty string (`\"\"`).\n\nDefault: \"prometheus_replica\"";
          type = (types.nullOr types.str);
          default = null;
        };
        "replicas" = mkOption {
          description = "Number of replicas of each shard to deploy for a Prometheus deployment.\n`spec.replicas` multiplied by `spec.shards` is the total number of Pods\ncreated.\n\nDefault: 1";
          type = (types.nullOr types.int);
          default = null;
        };
        "resources" = mkOption {
          description = "Defines the resources requests and limits of the 'prometheus' container.";
          type = (types.nullOr ResourcesModule);
          default = null;
        };
        "routePrefix" = mkOption {
          description = "The route prefix Prometheus registers HTTP handlers for.\n\nThis is useful when using `spec.externalURL`, and a proxy is rewriting\nHTTP routes of a request, and the actual ExternalURL is still true, but\nthe server serves requests under a different route prefix. For example\nfor use with `kubectl proxy`.";
          type = (types.nullOr types.str);
          default = null;
        };
        "runtime" = mkOption {
          description = "RuntimeConfig configures the values for the Prometheus process behavior";
          type = (types.nullOr RuntimeModule);
          default = null;
        };
        "sampleLimit" = mkOption {
          description = "SampleLimit defines per-scrape limit on number of scraped samples that will be accepted.\nOnly valid in Prometheus versions 2.45.0 and newer.\n\nNote that the global limit only applies to scrape objects that don't specify an explicit limit value.\nIf you want to enforce a maximum limit for all scrape objects, refer to enforcedSampleLimit.";
          type = (types.nullOr types.int);
          default = null;
        };
        "scrapeClasses" = mkOption {
          description = "List of scrape classes to expose to scraping objects such as\nPodMonitors, ServiceMonitors, Probes and ScrapeConfigs.\n\nThis is an *experimental feature*, it may change in any upcoming release\nin a breaking way.";
          type = (types.listOf ScrapeClasseModule);
          default = [ ];
        };
        "scrapeClassicHistograms" = mkOption {
          description = "Whether to scrape a classic histogram that is also exposed as a native histogram.\n\nNotice: `scrapeClassicHistograms` corresponds to the `always_scrape_classic_histograms` field in the Prometheus configuration.\n\nIt requires Prometheus >= v3.5.0.";
          type = types.bool;
          default = false;
        };
        "scrapeConfigNamespaceSelector" = mkOption {
          description = "Namespaces to match for ScrapeConfig discovery. An empty label selector\nmatches all namespaces. A null label selector matches the current\nnamespace only.\n\nNote that the ScrapeConfig custom resource definition is currently at Alpha level.";
          type = (types.nullOr ScrapeConfigNamespaceSelectorModule);
          default = null;
        };
        "scrapeConfigSelector" = mkOption {
          description = "ScrapeConfigs to be selected for target discovery. An empty label\nselector matches all objects. A null label selector matches no objects.\n\nIf `spec.serviceMonitorSelector`, `spec.podMonitorSelector`, `spec.probeSelector`\nand `spec.scrapeConfigSelector` are null, the Prometheus configuration is unmanaged.\nThe Prometheus operator will ensure that the Prometheus configuration's\nSecret exists, but it is the responsibility of the user to provide the raw\ngzipped Prometheus configuration under the `prometheus.yaml.gz` key.\nThis behavior is *deprecated* and will be removed in the next major version\nof the custom resource definition. It is recommended to use\n`spec.additionalScrapeConfigs` instead.\n\nNote that the ScrapeConfig custom resource definition is currently at Alpha level.";
          type = (types.nullOr ScrapeConfigSelectorModule);
          default = null;
        };
        "scrapeFailureLogFile" = mkOption {
          description = "File to which scrape failures are logged.\nReloading the configuration will reopen the file.\n\nIf the filename has an empty path, e.g. 'file.log', The Prometheus Pods\nwill mount the file into an emptyDir volume at `/var/log/prometheus`.\nIf a full path is provided, e.g. '/var/log/prometheus/file.log', you\nmust mount a volume in the specified directory and it must be writable.\nIt requires Prometheus >= v2.55.0.";
          type = (types.nullOr types.str);
          default = null;
        };
        "scrapeInterval" = mkOption {
          description = "Interval between consecutive scrapes.\n\nDefault: \"30s\"";
          type = (types.nullOr types.str);
          default = "30s";
        };
        "scrapeProtocols" = mkOption {
          description = "The protocols to negotiate during a scrape. It tells clients the\nprotocols supported by Prometheus in order of preference (from most to least preferred).\n\nIf unset, Prometheus uses its default value.\n\nIt requires Prometheus >= v2.49.0.\n\n`PrometheusText1.0.0` requires Prometheus >= v3.0.0.";
          type = (
            types.listOf (
              types.enum [
                "PrometheusProto"
                "OpenMetricsText0.0.1"
                "OpenMetricsText1.0.0"
                "PrometheusText0.0.4"
                "PrometheusText1.0.0"
              ]
            )
          );
          default = [ ];
        };
        "scrapeTimeout" = mkOption {
          description = "Number of seconds to wait until a scrape request times out.\nThe value cannot be greater than the scrape interval otherwise the operator will reject the resource.";
          type = (types.nullOr types.str);
          default = null;
        };
        "secrets" = mkOption {
          description = "Secrets is a list of Secrets in the same namespace as the Prometheus\nobject, which shall be mounted into the Prometheus Pods.\nEach Secret is added to the StatefulSet definition as a volume named `secret-<secret-name>`.\nThe Secrets are mounted into /etc/prometheus/secrets/<secret-name> in the 'prometheus' container.";
          type = (types.listOf types.str);
          default = [ ];
        };
        "securityContext" = mkOption {
          description = "SecurityContext holds pod-level security attributes and common container settings.\nThis defaults to the default PodSecurityContext.";
          type = (types.nullOr SecurityContextModule);
          default = null;
        };
        "serviceAccountName" = mkOption {
          description = "ServiceAccountName is the name of the ServiceAccount to use to run the\nPrometheus Pods.";
          type = (types.nullOr types.str);
          default = null;
        };
        "serviceDiscoveryRole" = mkOption {
          description = "Defines the service discovery role used to discover targets from\n`ServiceMonitor` objects and Alertmanager endpoints.\n\nIf set, the value should be either \"Endpoints\" or \"EndpointSlice\".\nIf unset, the operator assumes the \"Endpoints\" role.";
          type = (
            types.nullOr (
              types.enum [
                "Endpoints"
                "EndpointSlice"
              ]
            )
          );
          default = null;
        };
        "serviceMonitorNamespaceSelector" = mkOption {
          description = "Namespaces to match for ServicedMonitors discovery. An empty label selector\nmatches all namespaces. A null label selector (default value) matches the current\nnamespace only.";
          type = (types.nullOr ServiceMonitorNamespaceSelectorModule);
          default = null;
        };
        "serviceMonitorSelector" = mkOption {
          description = "ServiceMonitors to be selected for target discovery. An empty label\nselector matches all objects. A null label selector matches no objects.\n\nIf `spec.serviceMonitorSelector`, `spec.podMonitorSelector`, `spec.probeSelector`\nand `spec.scrapeConfigSelector` are null, the Prometheus configuration is unmanaged.\nThe Prometheus operator will ensure that the Prometheus configuration's\nSecret exists, but it is the responsibility of the user to provide the raw\ngzipped Prometheus configuration under the `prometheus.yaml.gz` key.\nThis behavior is *deprecated* and will be removed in the next major version\nof the custom resource definition. It is recommended to use\n`spec.additionalScrapeConfigs` instead.";
          type = (types.nullOr ServiceMonitorSelectorModule);
          default = null;
        };
        "serviceName" = mkOption {
          description = "The name of the service name used by the underlying StatefulSet(s) as the governing service.\nIf defined, the Service  must be created before the Prometheus/PrometheusAgent resource in the same namespace and it must define a selector that matches the pod labels.\nIf empty, the operator will create and manage a headless service named `prometheus-operated` for Prometheus resources,\nor `prometheus-agent-operated` for PrometheusAgent resources.\nWhen deploying multiple Prometheus/PrometheusAgent resources in the same namespace, it is recommended to specify a different value for each.\nSee https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#stable-network-id for more details.";
          type = (types.nullOr types.str);
          default = null;
        };
        "shards" = mkOption {
          description = "Number of shards to distribute the scraped targets onto.\n\n`spec.replicas` multiplied by `spec.shards` is the total number of Pods\nbeing created.\n\nWhen not defined, the operator assumes only one shard.\n\nNote that scaling down shards will not reshard data onto the remaining\ninstances, it must be manually moved. Increasing shards will not reshard\ndata either but it will continue to be available from the same\ninstances. To query globally, use either\n* Thanos sidecar + querier for query federation and Thanos Ruler for rules.\n* Remote-write to send metrics to a central location.\n\nBy default, the sharding of targets is performed on:\n* The `__address__` target's metadata label for PodMonitor,\nServiceMonitor and ScrapeConfig resources.\n* The `__param_target__` label for Probe resources.\n\nUsers can define their own sharding implementation by setting the\n`__tmp_hash` label during the target discovery with relabeling\nconfiguration (either in the monitoring resources or via scrape class).\n\nYou can also disable sharding on a specific target by setting the\n`__tmp_disable_sharding` label with relabeling configuration. When\nthe label value isn't empty, all Prometheus shards will scrape the target.";
          type = (types.nullOr types.int);
          default = null;
        };
        "storage" = mkOption {
          description = "Storage defines the storage used by Prometheus.";
          type = (types.nullOr StorageModule);
          default = null;
        };
        "targetLimit" = mkOption {
          description = "TargetLimit defines a limit on the number of scraped targets that will be accepted.\nOnly valid in Prometheus versions 2.45.0 and newer.\n\nNote that the global limit only applies to scrape objects that don't specify an explicit limit value.\nIf you want to enforce a maximum limit for all scrape objects, refer to enforcedTargetLimit.";
          type = (types.nullOr types.int);
          default = null;
        };
        "terminationGracePeriodSeconds" = mkOption {
          description = "Optional duration in seconds the pod needs to terminate gracefully.\nValue must be non-negative integer. The value zero indicates stop immediately via\nthe kill signal (no opportunity to shut down) which may lead to data corruption.\n\nDefaults to 600 seconds.";
          type = (types.nullOr types.int);
          default = null;
        };
        "tolerations" = mkOption {
          description = "Defines the Pods' tolerations if specified.";
          type = (types.listOf TolerationModule);
          default = [ ];
        };
        "topologySpreadConstraints" = mkOption {
          description = "Defines the pod's topology spread constraints if specified.";
          type = (types.listOf TopologySpreadConstraintModule);
          default = [ ];
        };
        "tracingConfig" = mkOption {
          description = "TracingConfig configures tracing in Prometheus.\n\nThis is an *experimental feature*, it may change in any upcoming release\nin a breaking way.";
          type = (types.nullOr TracingConfigModule);
          default = null;
        };
        "tsdb" = mkOption {
          description = "Defines the runtime reloadable configuration of the timeseries database(TSDB).\nIt requires Prometheus >= v2.39.0 or PrometheusAgent >= v2.54.0.";
          type = (types.nullOr TsdbModule);
          default = null;
        };
        "version" = mkOption {
          description = "Version of Prometheus being deployed. The operator uses this information\nto generate the Prometheus StatefulSet + configuration files.\n\nIf not specified, the operator assumes the latest upstream version of\nPrometheus available at the time when the version of the operator was\nreleased.";
          type = (types.nullOr types.str);
          default = null;
        };
        "volumeMounts" = mkOption {
          description = "VolumeMounts allows the configuration of additional VolumeMounts.\n\nVolumeMounts will be appended to other VolumeMounts in the 'prometheus'\ncontainer, that are generated as a result of StorageSpec objects.";
          type = (types.listOf VolumeMountModule);
          default = [ ];
        };
        "volumes" = mkOption {
          description = "Volumes allows the configuration of additional volumes on the output\nStatefulSet definition. Volumes specified will be appended to other\nvolumes that are generated as a result of StorageSpec objects.";
          type = (types.listOf VolumeModule);
          default = [ ];
        };
        "walCompression" = mkOption {
          description = "Configures compression of the write-ahead log (WAL) using Snappy.\n\nWAL compression is enabled by default for Prometheus >= 2.20.0\n\nRequires Prometheus v2.11.0 and above.";
          type = types.bool;
          default = false;
        };
        "web" = mkOption {
          description = "Defines the configuration of the Prometheus web server.";
          type = (types.nullOr WebModule);
          default = null;
        };
      };
    }
  );
  mkPrometheusAgent = name: res: {
    apiVersion = "monitoring.coreos.com/v1alpha1";
    kind = "PrometheusAgent";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."additionalArgs" != [ ]) {
      "additionalArgs" = map mkAdditionalArg res."additionalArgs";
    }
    // {
    }
    // optionalAttrs (res."additionalScrapeConfigs" != null) {
      "additionalScrapeConfigs" = mkAdditionalScrapeConfigs res."additionalScrapeConfigs";
    }
    // {
    }
    // optionalAttrs (res."affinity" != null) { "affinity" = mkAffinity res."affinity"; }
    // {
    }
    // optionalAttrs (res."apiserverConfig" != null) {
      "apiserverConfig" = mkApiserverConfig res."apiserverConfig";
    }
    // {
    }
    // optionalAttrs (res."arbitraryFSAccessThroughSMs" != null) {
      "arbitraryFSAccessThroughSMs" = mkArbitraryFSAccessThroughSMs res."arbitraryFSAccessThroughSMs";
    }
    // {
    }
    // optionalAttrs res."automountServiceAccountToken" {
      inherit (res) "automountServiceAccountToken";
    }
    // {
    }
    // optionalAttrs (res."bodySizeLimit" != null) { inherit (res) "bodySizeLimit"; }
    // {
    }
    // optionalAttrs (res."configMaps" != [ ]) { inherit (res) "configMaps"; }
    // {
    }
    // optionalAttrs (res."containers" != [ ]) { "containers" = map mkContainer res."containers"; }
    // {
    }
    // optionalAttrs res."convertClassicHistogramsToNHCB" {
      inherit (res) "convertClassicHistogramsToNHCB";
    }
    // {
    }
    // optionalAttrs (res."dnsConfig" != null) { "dnsConfig" = mkDnsConfig res."dnsConfig"; }
    // {
    }
    // optionalAttrs (res."dnsPolicy" != null) { inherit (res) "dnsPolicy"; }
    // {
    }
    // optionalAttrs (res."enableFeatures" != [ ]) { inherit (res) "enableFeatures"; }
    // {
    }
    // optionalAttrs res."enableOTLPReceiver" { inherit (res) "enableOTLPReceiver"; }
    // {
    }
    // optionalAttrs res."enableRemoteWriteReceiver" { inherit (res) "enableRemoteWriteReceiver"; }
    // {
    }
    // optionalAttrs res."enableServiceLinks" { inherit (res) "enableServiceLinks"; }
    // {
    }
    // optionalAttrs (res."enforcedBodySizeLimit" != null) { inherit (res) "enforcedBodySizeLimit"; }
    // {
    }
    // optionalAttrs (res."enforcedKeepDroppedTargets" != null) {
      inherit (res) "enforcedKeepDroppedTargets";
    }
    // {
    }
    // optionalAttrs (res."enforcedLabelLimit" != null) { inherit (res) "enforcedLabelLimit"; }
    // {
    }
    // optionalAttrs (res."enforcedLabelNameLengthLimit" != null) {
      inherit (res) "enforcedLabelNameLengthLimit";
    }
    // {
    }
    // optionalAttrs (res."enforcedLabelValueLengthLimit" != null) {
      inherit (res) "enforcedLabelValueLengthLimit";
    }
    // {
    }
    // optionalAttrs (res."enforcedNamespaceLabel" != null) { inherit (res) "enforcedNamespaceLabel"; }
    // {
    }
    // optionalAttrs (res."enforcedSampleLimit" != null) { inherit (res) "enforcedSampleLimit"; }
    // {
    }
    // optionalAttrs (res."enforcedTargetLimit" != null) { inherit (res) "enforcedTargetLimit"; }
    // {
    }
    // optionalAttrs (res."excludedFromEnforcement" != [ ]) {
      "excludedFromEnforcement" = map mkExcludedFromEnforcement res."excludedFromEnforcement";
    }
    // {
    }
    // optionalAttrs (res."externalLabels" != { }) { inherit (res) "externalLabels"; }
    // {
    }
    // optionalAttrs (res."externalUrl" != null) { inherit (res) "externalUrl"; }
    // {
    }
    // optionalAttrs (res."hostAliases" != [ ]) { "hostAliases" = map mkHostAliase res."hostAliases"; }
    // {
    }
    // optionalAttrs res."hostNetwork" { inherit (res) "hostNetwork"; }
    // {
    }
    // optionalAttrs res."hostUsers" { inherit (res) "hostUsers"; }
    // {
    }
    // optionalAttrs res."ignoreNamespaceSelectors" { inherit (res) "ignoreNamespaceSelectors"; }
    // {
    }
    // optionalAttrs (res."image" != null) { inherit (res) "image"; }
    // {
    }
    // optionalAttrs (res."imagePullPolicy" != null) { inherit (res) "imagePullPolicy"; }
    // {
    }
    // optionalAttrs (res."imagePullSecrets" != [ ]) {
      "imagePullSecrets" = map mkImagePullSecret res."imagePullSecrets";
    }
    // {
    }
    // optionalAttrs (res."initContainers" != [ ]) {
      "initContainers" = map mkInitContainer res."initContainers";
    }
    // {
    }
    // optionalAttrs (res."keepDroppedTargets" != null) { inherit (res) "keepDroppedTargets"; }
    // {
    }
    // optionalAttrs (res."labelLimit" != null) { inherit (res) "labelLimit"; }
    // {
    }
    // optionalAttrs (res."labelNameLengthLimit" != null) { inherit (res) "labelNameLengthLimit"; }
    // {
    }
    // optionalAttrs (res."labelValueLengthLimit" != null) { inherit (res) "labelValueLengthLimit"; }
    // {
    }
    // optionalAttrs res."listenLocal" { inherit (res) "listenLocal"; }
    // {
    }
    // optionalAttrs (res."logFormat" != null) { inherit (res) "logFormat"; }
    // {
    }
    // optionalAttrs (res."logLevel" != null) { inherit (res) "logLevel"; }
    // {
    }
    // optionalAttrs (res."maximumStartupDurationSeconds" != null) {
      inherit (res) "maximumStartupDurationSeconds";
    }
    // {
    }
    // optionalAttrs (res."minReadySeconds" != null) { inherit (res) "minReadySeconds"; }
    // {
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
    }
    // optionalAttrs (res."nameEscapingScheme" != null) { inherit (res) "nameEscapingScheme"; }
    // {
    }
    // optionalAttrs (res."nameValidationScheme" != null) { inherit (res) "nameValidationScheme"; }
    // {
    }
    // optionalAttrs (res."nodeSelector" != { }) { inherit (res) "nodeSelector"; }
    // {
    }
    // optionalAttrs (res."otlp" != null) { "otlp" = mkOtlp res."otlp"; }
    // {
    }
    // optionalAttrs res."overrideHonorLabels" { inherit (res) "overrideHonorLabels"; }
    // {
    }
    // optionalAttrs res."overrideHonorTimestamps" { inherit (res) "overrideHonorTimestamps"; }
    // {
    }
    // optionalAttrs res."paused" { inherit (res) "paused"; }
    // {
    }
    // optionalAttrs (res."persistentVolumeClaimRetentionPolicy" != null) {
      "persistentVolumeClaimRetentionPolicy" =
        mkPersistentVolumeClaimRetentionPolicy
          res."persistentVolumeClaimRetentionPolicy";
    }
    // {
    }
    // optionalAttrs (res."podMetadata" != null) { "podMetadata" = mkPodMetadata res."podMetadata"; }
    // {
    }
    // optionalAttrs (res."podMonitorNamespaceSelector" != null) {
      "podMonitorNamespaceSelector" = mkPodMonitorNamespaceSelector res."podMonitorNamespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."podMonitorSelector" != null) {
      "podMonitorSelector" = mkPodMonitorSelector res."podMonitorSelector";
    }
    // {
    }
    // optionalAttrs (res."podTargetLabels" != [ ]) { inherit (res) "podTargetLabels"; }
    // {
    }
    // optionalAttrs (res."portName" != null) { inherit (res) "portName"; }
    // {
    }
    // optionalAttrs (res."priorityClassName" != null) { inherit (res) "priorityClassName"; }
    // {
    }
    // optionalAttrs (res."probeNamespaceSelector" != null) {
      "probeNamespaceSelector" = mkProbeNamespaceSelector res."probeNamespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."probeSelector" != null) {
      "probeSelector" = mkProbeSelector res."probeSelector";
    }
    // {
    }
    // optionalAttrs (res."prometheusExternalLabelName" != null) {
      inherit (res) "prometheusExternalLabelName";
    }
    // {
    }
    // optionalAttrs (res."reloadStrategy" != null) { inherit (res) "reloadStrategy"; }
    // {
    }
    // optionalAttrs (res."remoteWrite" != [ ]) { "remoteWrite" = map mkRemoteWrite res."remoteWrite"; }
    // {
    }
    // optionalAttrs (res."remoteWriteReceiverMessageVersions" != [ ]) {
      inherit (res) "remoteWriteReceiverMessageVersions";
    }
    // {
    }
    // optionalAttrs (res."replicaExternalLabelName" != null) {
      inherit (res) "replicaExternalLabelName";
    }
    // {
    }
    // optionalAttrs (res."replicas" != null) { inherit (res) "replicas"; }
    // {
    }
    // optionalAttrs (res."resources" != null) { "resources" = mkResources res."resources"; }
    // {
    }
    // optionalAttrs (res."routePrefix" != null) { inherit (res) "routePrefix"; }
    // {
    }
    // optionalAttrs (res."runtime" != null) { "runtime" = mkRuntime res."runtime"; }
    // {
    }
    // optionalAttrs (res."sampleLimit" != null) { inherit (res) "sampleLimit"; }
    // {
    }
    // optionalAttrs (res."scrapeClasses" != [ ]) {
      "scrapeClasses" = map mkScrapeClasse res."scrapeClasses";
    }
    // {
    }
    // optionalAttrs res."scrapeClassicHistograms" { inherit (res) "scrapeClassicHistograms"; }
    // {
    }
    // optionalAttrs (res."scrapeConfigNamespaceSelector" != null) {
      "scrapeConfigNamespaceSelector" =
        mkScrapeConfigNamespaceSelector
          res."scrapeConfigNamespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."scrapeConfigSelector" != null) {
      "scrapeConfigSelector" = mkScrapeConfigSelector res."scrapeConfigSelector";
    }
    // {
    }
    // optionalAttrs (res."scrapeFailureLogFile" != null) { inherit (res) "scrapeFailureLogFile"; }
    // {
    }
    // optionalAttrs (res."scrapeInterval" != null) { inherit (res) "scrapeInterval"; }
    // {
    }
    // optionalAttrs (res."scrapeProtocols" != [ ]) { inherit (res) "scrapeProtocols"; }
    // {
    }
    // optionalAttrs (res."scrapeTimeout" != null) { inherit (res) "scrapeTimeout"; }
    // {
    }
    // optionalAttrs (res."secrets" != [ ]) { inherit (res) "secrets"; }
    // {
    }
    // optionalAttrs (res."securityContext" != null) {
      "securityContext" = mkSecurityContext res."securityContext";
    }
    // {
    }
    // optionalAttrs (res."serviceAccountName" != null) { inherit (res) "serviceAccountName"; }
    // {
    }
    // optionalAttrs (res."serviceDiscoveryRole" != null) { inherit (res) "serviceDiscoveryRole"; }
    // {
    }
    // optionalAttrs (res."serviceMonitorNamespaceSelector" != null) {
      "serviceMonitorNamespaceSelector" =
        mkServiceMonitorNamespaceSelector
          res."serviceMonitorNamespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."serviceMonitorSelector" != null) {
      "serviceMonitorSelector" = mkServiceMonitorSelector res."serviceMonitorSelector";
    }
    // {
    }
    // optionalAttrs (res."serviceName" != null) { inherit (res) "serviceName"; }
    // {
    }
    // optionalAttrs (res."shards" != null) { inherit (res) "shards"; }
    // {
    }
    // optionalAttrs (res."storage" != null) { "storage" = mkStorage res."storage"; }
    // {
    }
    // optionalAttrs (res."targetLimit" != null) { inherit (res) "targetLimit"; }
    // {
    }
    // optionalAttrs (res."terminationGracePeriodSeconds" != null) {
      inherit (res) "terminationGracePeriodSeconds";
    }
    // {
    }
    // optionalAttrs (res."tolerations" != [ ]) { "tolerations" = map mkToleration res."tolerations"; }
    // {
    }
    // optionalAttrs (res."topologySpreadConstraints" != [ ]) {
      "topologySpreadConstraints" = map mkTopologySpreadConstraint res."topologySpreadConstraints";
    }
    // {
    }
    // optionalAttrs (res."tracingConfig" != null) {
      "tracingConfig" = mkTracingConfig res."tracingConfig";
    }
    // {
    }
    // optionalAttrs (res."tsdb" != null) { "tsdb" = mkTsdb res."tsdb"; }
    // {
    }
    // optionalAttrs (res."version" != null) { inherit (res) "version"; }
    // {
    }
    // optionalAttrs (res."volumeMounts" != [ ]) {
      "volumeMounts" = map mkVolumeMount res."volumeMounts";
    }
    // {
    }
    // optionalAttrs (res."volumes" != [ ]) { "volumes" = map mkVolume res."volumes"; }
    // {
    }
    // optionalAttrs res."walCompression" { inherit (res) "walCompression"; }
    // {
    }
    // optionalAttrs (res."web" != null) { "web" = mkWeb res."web"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkPrometheusAgent cfg."prometheusagents");
in
{
  options.openkrill.apps."kube-prometheus" = {
    "prometheusagents" = mkOption {
      type = types.attrsOf PrometheusagentsModule;
      default = { };
      description = "PrometheusAgent CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."kube-prometheus".content = allResources;
  };
}
