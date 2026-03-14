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
  AlertmanagerConfigMatcherStrategyModule = types.submodule {
    options = {
      "type" = mkOption {
        description = "AlertmanagerConfigMatcherStrategyType defines the strategy used by\nAlertmanagerConfig objects to match alerts in the routes and inhibition\nrules.\n\nThe default value is `OnNamespace`.";
        type = (
          types.nullOr (
            types.enum [
              "OnNamespace"
              "OnNamespaceExceptForAlertmanagerNamespace"
              "None"
            ]
          )
        );
        default = "OnNamespace";
      };
    };
  };
  mkAlertmanagerConfigMatcherStrategy =
    res:
    {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  AlertmanagerConfigNamespaceSelectorMatchExpressionModule = types.submodule {
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
  mkAlertmanagerConfigNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AlertmanagerConfigNamespaceSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf AlertmanagerConfigNamespaceSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkAlertmanagerConfigNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkAlertmanagerConfigNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  AlertmanagerConfigSelectorMatchExpressionModule = types.submodule {
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
  mkAlertmanagerConfigSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AlertmanagerConfigSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf AlertmanagerConfigSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkAlertmanagerConfigSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkAlertmanagerConfigSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  AlertmanagerConfigurationGlobalHttpConfigAuthorizationCredentialsModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalHttpConfigAuthorizationCredentials =
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
  AlertmanagerConfigurationGlobalHttpConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkAlertmanagerConfigurationGlobalHttpConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" =
        mkAlertmanagerConfigurationGlobalHttpConfigAuthorizationCredentials
          res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  AlertmanagerConfigurationGlobalHttpConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkAlertmanagerConfigurationGlobalHttpConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkAlertmanagerConfigurationGlobalHttpConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkAlertmanagerConfigurationGlobalHttpConfigBasicAuthUsername res."username";
    }
    // {
    };
  AlertmanagerConfigurationGlobalHttpConfigBasicAuthPasswordModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalHttpConfigBasicAuthPassword =
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
  AlertmanagerConfigurationGlobalHttpConfigBasicAuthUsernameModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalHttpConfigBasicAuthUsername =
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
  AlertmanagerConfigurationGlobalHttpConfigBearerTokenSecretModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalHttpConfigBearerTokenSecret =
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
  AlertmanagerConfigurationGlobalHttpConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization header configuration for the client.\nThis is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+.";
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "BasicAuth for the client.\nThis is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence.";
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigBasicAuthModule);
        default = null;
      };
      "bearerTokenSecret" = mkOption {
        description = "The secret's key that contains the bearer token to be used by the client\nfor authentication.\nThe secret needs to be in the same namespace as the Alertmanager\nobject and accessible by the Prometheus Operator.";
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigBearerTokenSecretModule);
        default = null;
      };
      "followRedirects" = mkOption {
        description = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "OAuth2 client credentials used to fetch a token for the targets.";
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigOauth2Module);
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
        description = "TLS configuration for the client.";
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkAlertmanagerConfigurationGlobalHttpConfig =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkAlertmanagerConfigurationGlobalHttpConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkAlertmanagerConfigurationGlobalHttpConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs (res."bearerTokenSecret" != null) {
      "bearerTokenSecret" =
        mkAlertmanagerConfigurationGlobalHttpConfigBearerTokenSecret
          res."bearerTokenSecret";
    }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) {
      "oauth2" = mkAlertmanagerConfigurationGlobalHttpConfigOauth2 res."oauth2";
    }
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
      "tlsConfig" = mkAlertmanagerConfigurationGlobalHttpConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  AlertmanagerConfigurationGlobalHttpConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalHttpConfigOauth2ClientIdConfigMap =
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
  AlertmanagerConfigurationGlobalHttpConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkAlertmanagerConfigurationGlobalHttpConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkAlertmanagerConfigurationGlobalHttpConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkAlertmanagerConfigurationGlobalHttpConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  AlertmanagerConfigurationGlobalHttpConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalHttpConfigOauth2ClientIdSecret =
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
  AlertmanagerConfigurationGlobalHttpConfigOauth2ClientSecretModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalHttpConfigOauth2ClientSecret =
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
  AlertmanagerConfigurationGlobalHttpConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = AlertmanagerConfigurationGlobalHttpConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = AlertmanagerConfigurationGlobalHttpConfigOauth2ClientSecretModule;
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
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkAlertmanagerConfigurationGlobalHttpConfigOauth2 =
    res:
    {
      "clientId" = mkAlertmanagerConfigurationGlobalHttpConfigOauth2ClientId res."clientId";
      "clientSecret" = mkAlertmanagerConfigurationGlobalHttpConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkAlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  AlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigCaConfigMap =
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
  AlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkAlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkAlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkAlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  AlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigCaSecret =
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
  AlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigCertConfigMap =
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
  AlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkAlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" =
        mkAlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigCertConfigMap
          res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkAlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  AlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigCertSecret =
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
  AlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigKeySecret =
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
  AlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigKeySecretModule);
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
  mkAlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkAlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkAlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkAlertmanagerConfigurationGlobalHttpConfigOauth2TlsConfigKeySecret res."keySecret";
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
  AlertmanagerConfigurationGlobalHttpConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalHttpConfigTlsConfigCaConfigMap =
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
  AlertmanagerConfigurationGlobalHttpConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkAlertmanagerConfigurationGlobalHttpConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkAlertmanagerConfigurationGlobalHttpConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkAlertmanagerConfigurationGlobalHttpConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  AlertmanagerConfigurationGlobalHttpConfigTlsConfigCaSecretModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalHttpConfigTlsConfigCaSecret =
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
  AlertmanagerConfigurationGlobalHttpConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalHttpConfigTlsConfigCertConfigMap =
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
  AlertmanagerConfigurationGlobalHttpConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkAlertmanagerConfigurationGlobalHttpConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkAlertmanagerConfigurationGlobalHttpConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkAlertmanagerConfigurationGlobalHttpConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  AlertmanagerConfigurationGlobalHttpConfigTlsConfigCertSecretModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalHttpConfigTlsConfigCertSecret =
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
  AlertmanagerConfigurationGlobalHttpConfigTlsConfigKeySecretModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalHttpConfigTlsConfigKeySecret =
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
  AlertmanagerConfigurationGlobalHttpConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigTlsConfigKeySecretModule);
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
  mkAlertmanagerConfigurationGlobalHttpConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkAlertmanagerConfigurationGlobalHttpConfigTlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkAlertmanagerConfigurationGlobalHttpConfigTlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkAlertmanagerConfigurationGlobalHttpConfigTlsConfigKeySecret res."keySecret";
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
  AlertmanagerConfigurationGlobalJiraModule = types.submodule {
    options = {
      "apiURL" = mkOption {
        description = "The default Jira API URL.\n\nIt requires Alertmanager >= v0.28.0.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkAlertmanagerConfigurationGlobalJira =
    res:
    {
    }
    // optionalAttrs (res."apiURL" != null) { inherit (res) "apiURL"; }
    // {
    };
  AlertmanagerConfigurationGlobalModule = types.submodule {
    options = {
      "httpConfig" = mkOption {
        description = "HTTP client configuration.";
        type = (types.nullOr AlertmanagerConfigurationGlobalHttpConfigModule);
        default = null;
      };
      "jira" = mkOption {
        description = "The default configuration for Jira.";
        type = (types.nullOr AlertmanagerConfigurationGlobalJiraModule);
        default = null;
      };
      "opsGenieApiKey" = mkOption {
        description = "The default OpsGenie API Key.";
        type = (types.nullOr AlertmanagerConfigurationGlobalOpsGenieApiKeyModule);
        default = null;
      };
      "opsGenieApiUrl" = mkOption {
        description = "The default OpsGenie API URL.";
        type = (types.nullOr AlertmanagerConfigurationGlobalOpsGenieApiUrlModule);
        default = null;
      };
      "pagerdutyUrl" = mkOption {
        description = "The default Pagerduty URL.";
        type = (types.nullOr types.str);
        default = null;
      };
      "resolveTimeout" = mkOption {
        description = "ResolveTimeout is the default value used by alertmanager if the alert does\nnot include EndsAt, after this time passes it can declare the alert as resolved if it has not been updated.\nThis has no impact on alerts from Prometheus, as they always include EndsAt.";
        type = (types.nullOr types.str);
        default = null;
      };
      "rocketChat" = mkOption {
        description = "The default configuration for Rocket Chat.";
        type = (types.nullOr AlertmanagerConfigurationGlobalRocketChatModule);
        default = null;
      };
      "slackApiUrl" = mkOption {
        description = "The default Slack API URL.";
        type = (types.nullOr AlertmanagerConfigurationGlobalSlackApiUrlModule);
        default = null;
      };
      "smtp" = mkOption {
        description = "Configures global SMTP parameters.";
        type = (types.nullOr AlertmanagerConfigurationGlobalSmtpModule);
        default = null;
      };
      "telegram" = mkOption {
        description = "The default Telegram config";
        type = (types.nullOr AlertmanagerConfigurationGlobalTelegramModule);
        default = null;
      };
      "victorops" = mkOption {
        description = "The default configuration for VictorOps.";
        type = (types.nullOr AlertmanagerConfigurationGlobalVictoropsModule);
        default = null;
      };
      "webex" = mkOption {
        description = "The default configuration for Jira.";
        type = (types.nullOr AlertmanagerConfigurationGlobalWebexModule);
        default = null;
      };
      "wechat" = mkOption {
        description = "The default WeChat Config";
        type = (types.nullOr AlertmanagerConfigurationGlobalWechatModule);
        default = null;
      };
    };
  };
  mkAlertmanagerConfigurationGlobal =
    res:
    {
    }
    // optionalAttrs (res."httpConfig" != null) {
      "httpConfig" = mkAlertmanagerConfigurationGlobalHttpConfig res."httpConfig";
    }
    // {
    }
    // optionalAttrs (res."jira" != null) { "jira" = mkAlertmanagerConfigurationGlobalJira res."jira"; }
    // {
    }
    // optionalAttrs (res."opsGenieApiKey" != null) {
      "opsGenieApiKey" = mkAlertmanagerConfigurationGlobalOpsGenieApiKey res."opsGenieApiKey";
    }
    // {
    }
    // optionalAttrs (res."opsGenieApiUrl" != null) {
      "opsGenieApiUrl" = mkAlertmanagerConfigurationGlobalOpsGenieApiUrl res."opsGenieApiUrl";
    }
    // {
    }
    // optionalAttrs (res."pagerdutyUrl" != null) { inherit (res) "pagerdutyUrl"; }
    // {
    }
    // optionalAttrs (res."resolveTimeout" != null) { inherit (res) "resolveTimeout"; }
    // {
    }
    // optionalAttrs (res."rocketChat" != null) {
      "rocketChat" = mkAlertmanagerConfigurationGlobalRocketChat res."rocketChat";
    }
    // {
    }
    // optionalAttrs (res."slackApiUrl" != null) {
      "slackApiUrl" = mkAlertmanagerConfigurationGlobalSlackApiUrl res."slackApiUrl";
    }
    // {
    }
    // optionalAttrs (res."smtp" != null) { "smtp" = mkAlertmanagerConfigurationGlobalSmtp res."smtp"; }
    // {
    }
    // optionalAttrs (res."telegram" != null) {
      "telegram" = mkAlertmanagerConfigurationGlobalTelegram res."telegram";
    }
    // {
    }
    // optionalAttrs (res."victorops" != null) {
      "victorops" = mkAlertmanagerConfigurationGlobalVictorops res."victorops";
    }
    // {
    }
    // optionalAttrs (res."webex" != null) {
      "webex" = mkAlertmanagerConfigurationGlobalWebex res."webex";
    }
    // {
    }
    // optionalAttrs (res."wechat" != null) {
      "wechat" = mkAlertmanagerConfigurationGlobalWechat res."wechat";
    }
    // {
    };
  AlertmanagerConfigurationGlobalOpsGenieApiKeyModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalOpsGenieApiKey =
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
  AlertmanagerConfigurationGlobalOpsGenieApiUrlModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalOpsGenieApiUrl =
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
  AlertmanagerConfigurationGlobalRocketChatModule = types.submodule {
    options = {
      "apiURL" = mkOption {
        description = "The default Rocket Chat API URL.\n\nIt requires Alertmanager >= v0.28.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "token" = mkOption {
        description = "The default Rocket Chat token.\n\nIt requires Alertmanager >= v0.28.0.";
        type = (types.nullOr AlertmanagerConfigurationGlobalRocketChatTokenModule);
        default = null;
      };
      "tokenID" = mkOption {
        description = "The default Rocket Chat Token ID.\n\nIt requires Alertmanager >= v0.28.0.";
        type = (types.nullOr AlertmanagerConfigurationGlobalRocketChatTokenIDModule);
        default = null;
      };
    };
  };
  mkAlertmanagerConfigurationGlobalRocketChat =
    res:
    {
    }
    // optionalAttrs (res."apiURL" != null) { inherit (res) "apiURL"; }
    // {
    }
    // optionalAttrs (res."token" != null) {
      "token" = mkAlertmanagerConfigurationGlobalRocketChatToken res."token";
    }
    // {
    }
    // optionalAttrs (res."tokenID" != null) {
      "tokenID" = mkAlertmanagerConfigurationGlobalRocketChatTokenID res."tokenID";
    }
    // {
    };
  AlertmanagerConfigurationGlobalRocketChatTokenIDModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalRocketChatTokenID =
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
  AlertmanagerConfigurationGlobalRocketChatTokenModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalRocketChatToken =
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
  AlertmanagerConfigurationGlobalSlackApiUrlModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalSlackApiUrl =
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
  AlertmanagerConfigurationGlobalSmtpAuthPasswordModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalSmtpAuthPassword =
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
  AlertmanagerConfigurationGlobalSmtpAuthSecretModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalSmtpAuthSecret =
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
  AlertmanagerConfigurationGlobalSmtpModule = types.submodule {
    options = {
      "authIdentity" = mkOption {
        description = "SMTP Auth using PLAIN";
        type = (types.nullOr types.str);
        default = null;
      };
      "authPassword" = mkOption {
        description = "SMTP Auth using LOGIN and PLAIN.";
        type = (types.nullOr AlertmanagerConfigurationGlobalSmtpAuthPasswordModule);
        default = null;
      };
      "authSecret" = mkOption {
        description = "SMTP Auth using CRAM-MD5.";
        type = (types.nullOr AlertmanagerConfigurationGlobalSmtpAuthSecretModule);
        default = null;
      };
      "authUsername" = mkOption {
        description = "SMTP Auth using CRAM-MD5, LOGIN and PLAIN. If empty, Alertmanager doesn't authenticate to the SMTP server.";
        type = (types.nullOr types.str);
        default = null;
      };
      "from" = mkOption {
        description = "The default SMTP From header field.";
        type = (types.nullOr types.str);
        default = null;
      };
      "hello" = mkOption {
        description = "The default hostname to identify to the SMTP server.";
        type = (types.nullOr types.str);
        default = null;
      };
      "requireTLS" = mkOption {
        description = "The default SMTP TLS requirement.\nNote that Go does not support unencrypted connections to remote SMTP endpoints.";
        type = types.bool;
        default = false;
      };
      "smartHost" = mkOption {
        description = "The default SMTP smarthost used for sending emails.";
        type = (types.nullOr AlertmanagerConfigurationGlobalSmtpSmartHostModule);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "The default TLS configuration for SMTP receivers";
        type = (types.nullOr AlertmanagerConfigurationGlobalSmtpTlsConfigModule);
        default = null;
      };
    };
  };
  mkAlertmanagerConfigurationGlobalSmtp =
    res:
    {
    }
    // optionalAttrs (res."authIdentity" != null) { inherit (res) "authIdentity"; }
    // {
    }
    // optionalAttrs (res."authPassword" != null) {
      "authPassword" = mkAlertmanagerConfigurationGlobalSmtpAuthPassword res."authPassword";
    }
    // {
    }
    // optionalAttrs (res."authSecret" != null) {
      "authSecret" = mkAlertmanagerConfigurationGlobalSmtpAuthSecret res."authSecret";
    }
    // {
    }
    // optionalAttrs (res."authUsername" != null) { inherit (res) "authUsername"; }
    // {
    }
    // optionalAttrs (res."from" != null) { inherit (res) "from"; }
    // {
    }
    // optionalAttrs (res."hello" != null) { inherit (res) "hello"; }
    // {
    }
    // optionalAttrs res."requireTLS" { inherit (res) "requireTLS"; }
    // {
    }
    // optionalAttrs (res."smartHost" != null) {
      "smartHost" = mkAlertmanagerConfigurationGlobalSmtpSmartHost res."smartHost";
    }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkAlertmanagerConfigurationGlobalSmtpTlsConfig res."tlsConfig";
    }
    // {
    };
  AlertmanagerConfigurationGlobalSmtpSmartHostModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Defines the host's address, it can be a DNS name or a literal IP address.";
        type = types.str;
      };
      "port" = mkOption {
        description = "Defines the host's port, it can be a literal port number or a port name.";
        type = types.str;
      };
    };
  };
  mkAlertmanagerConfigurationGlobalSmtpSmartHost = res: {
    inherit (res) "host";
    inherit (res) "port";
  };
  AlertmanagerConfigurationGlobalSmtpTlsConfigCaConfigMapModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalSmtpTlsConfigCaConfigMap =
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
  AlertmanagerConfigurationGlobalSmtpTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr AlertmanagerConfigurationGlobalSmtpTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr AlertmanagerConfigurationGlobalSmtpTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkAlertmanagerConfigurationGlobalSmtpTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkAlertmanagerConfigurationGlobalSmtpTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkAlertmanagerConfigurationGlobalSmtpTlsConfigCaSecret res."secret";
    }
    // {
    };
  AlertmanagerConfigurationGlobalSmtpTlsConfigCaSecretModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalSmtpTlsConfigCaSecret =
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
  AlertmanagerConfigurationGlobalSmtpTlsConfigCertConfigMapModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalSmtpTlsConfigCertConfigMap =
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
  AlertmanagerConfigurationGlobalSmtpTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr AlertmanagerConfigurationGlobalSmtpTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr AlertmanagerConfigurationGlobalSmtpTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkAlertmanagerConfigurationGlobalSmtpTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkAlertmanagerConfigurationGlobalSmtpTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkAlertmanagerConfigurationGlobalSmtpTlsConfigCertSecret res."secret";
    }
    // {
    };
  AlertmanagerConfigurationGlobalSmtpTlsConfigCertSecretModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalSmtpTlsConfigCertSecret =
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
  AlertmanagerConfigurationGlobalSmtpTlsConfigKeySecretModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalSmtpTlsConfigKeySecret =
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
  AlertmanagerConfigurationGlobalSmtpTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr AlertmanagerConfigurationGlobalSmtpTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr AlertmanagerConfigurationGlobalSmtpTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr AlertmanagerConfigurationGlobalSmtpTlsConfigKeySecretModule);
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
  mkAlertmanagerConfigurationGlobalSmtpTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkAlertmanagerConfigurationGlobalSmtpTlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkAlertmanagerConfigurationGlobalSmtpTlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkAlertmanagerConfigurationGlobalSmtpTlsConfigKeySecret res."keySecret";
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
  AlertmanagerConfigurationGlobalTelegramModule = types.submodule {
    options = {
      "apiURL" = mkOption {
        description = "The default Telegram API URL.\n\nIt requires Alertmanager >= v0.24.0.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkAlertmanagerConfigurationGlobalTelegram =
    res:
    {
    }
    // optionalAttrs (res."apiURL" != null) { inherit (res) "apiURL"; }
    // {
    };
  AlertmanagerConfigurationGlobalVictoropsApiKeyModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalVictoropsApiKey =
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
  AlertmanagerConfigurationGlobalVictoropsModule = types.submodule {
    options = {
      "apiKey" = mkOption {
        description = "The default VictorOps API Key.";
        type = (types.nullOr AlertmanagerConfigurationGlobalVictoropsApiKeyModule);
        default = null;
      };
      "apiURL" = mkOption {
        description = "The default VictorOps API URL.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkAlertmanagerConfigurationGlobalVictorops =
    res:
    {
    }
    // optionalAttrs (res."apiKey" != null) {
      "apiKey" = mkAlertmanagerConfigurationGlobalVictoropsApiKey res."apiKey";
    }
    // {
    }
    // optionalAttrs (res."apiURL" != null) { inherit (res) "apiURL"; }
    // {
    };
  AlertmanagerConfigurationGlobalWebexModule = types.submodule {
    options = {
      "apiURL" = mkOption {
        description = "The default Webex API URL.\n\nIt requires Alertmanager >= v0.25.0.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkAlertmanagerConfigurationGlobalWebex =
    res:
    {
    }
    // optionalAttrs (res."apiURL" != null) { inherit (res) "apiURL"; }
    // {
    };
  AlertmanagerConfigurationGlobalWechatApiSecretModule = types.submodule {
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
  mkAlertmanagerConfigurationGlobalWechatApiSecret =
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
  AlertmanagerConfigurationGlobalWechatModule = types.submodule {
    options = {
      "apiCorpID" = mkOption {
        description = "The default WeChat API Corporate ID.";
        type = (types.nullOr types.str);
        default = null;
      };
      "apiSecret" = mkOption {
        description = "The default WeChat API Secret.";
        type = (types.nullOr AlertmanagerConfigurationGlobalWechatApiSecretModule);
        default = null;
      };
      "apiURL" = mkOption {
        description = "The default WeChat API URL.\nThe default value is \"https://qyapi.weixin.qq.com/cgi-bin/\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkAlertmanagerConfigurationGlobalWechat =
    res:
    {
    }
    // optionalAttrs (res."apiCorpID" != null) { inherit (res) "apiCorpID"; }
    // {
    }
    // optionalAttrs (res."apiSecret" != null) {
      "apiSecret" = mkAlertmanagerConfigurationGlobalWechatApiSecret res."apiSecret";
    }
    // {
    }
    // optionalAttrs (res."apiURL" != null) { inherit (res) "apiURL"; }
    // {
    };
  AlertmanagerConfigurationModule = types.submodule {
    options = {
      "global" = mkOption {
        description = "Defines the global parameters of the Alertmanager configuration.";
        type = (types.nullOr AlertmanagerConfigurationGlobalModule);
        default = null;
      };
      "name" = mkOption {
        description = "The name of the AlertmanagerConfig resource which is used to generate the Alertmanager configuration.\nIt must be defined in the same namespace as the Alertmanager object.\nThe operator will not enforce a `namespace` label for routes and inhibition rules.";
        type = (types.nullOr types.str);
        default = null;
      };
      "templates" = mkOption {
        description = "Custom notification templates.";
        type = (types.listOf AlertmanagerConfigurationTemplateModule);
        default = [ ];
      };
    };
  };
  mkAlertmanagerConfiguration =
    res:
    {
    }
    // optionalAttrs (res."global" != null) {
      "global" = mkAlertmanagerConfigurationGlobal res."global";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."templates" != [ ]) {
      "templates" = map mkAlertmanagerConfigurationTemplate res."templates";
    }
    // {
    };
  AlertmanagerConfigurationTemplateConfigMapModule = types.submodule {
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
  mkAlertmanagerConfigurationTemplateConfigMap =
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
  AlertmanagerConfigurationTemplateModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr AlertmanagerConfigurationTemplateConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr AlertmanagerConfigurationTemplateSecretModule);
        default = null;
      };
    };
  };
  mkAlertmanagerConfigurationTemplate =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkAlertmanagerConfigurationTemplateConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkAlertmanagerConfigurationTemplateSecret res."secret";
    }
    // {
    };
  AlertmanagerConfigurationTemplateSecretModule = types.submodule {
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
  mkAlertmanagerConfigurationTemplateSecret =
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
  ClusterTLSClientCaConfigMapModule = types.submodule {
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
  mkClusterTLSClientCaConfigMap =
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
  ClusterTLSClientCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ClusterTLSClientCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ClusterTLSClientCaSecretModule);
        default = null;
      };
    };
  };
  mkClusterTLSClientCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkClusterTLSClientCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkClusterTLSClientCaSecret res."secret"; }
    // {
    };
  ClusterTLSClientCaSecretModule = types.submodule {
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
  mkClusterTLSClientCaSecret =
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
  ClusterTLSClientCertConfigMapModule = types.submodule {
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
  mkClusterTLSClientCertConfigMap =
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
  ClusterTLSClientCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ClusterTLSClientCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ClusterTLSClientCertSecretModule);
        default = null;
      };
    };
  };
  mkClusterTLSClientCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkClusterTLSClientCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkClusterTLSClientCertSecret res."secret"; }
    // {
    };
  ClusterTLSClientCertSecretModule = types.submodule {
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
  mkClusterTLSClientCertSecret =
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
  ClusterTLSClientKeySecretModule = types.submodule {
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
  mkClusterTLSClientKeySecret =
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
  ClusterTLSClientModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ClusterTLSClientCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ClusterTLSClientCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ClusterTLSClientKeySecretModule);
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
  mkClusterTLSClient =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkClusterTLSClientCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkClusterTLSClientCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkClusterTLSClientKeySecret res."keySecret";
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
  ClusterTLSModule = types.submodule {
    options = {
      "client" = mkOption {
        description = "Client-side configuration for mutual TLS.";
        type = ClusterTLSClientModule;
      };
      "server" = mkOption {
        description = "Server-side configuration for mutual TLS.";
        type = ClusterTLSServerModule;
      };
    };
  };
  mkClusterTLS = res: {
    "client" = mkClusterTLSClient res."client";
    "server" = mkClusterTLSServer res."server";
  };
  ClusterTLSServerCertConfigMapModule = types.submodule {
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
  mkClusterTLSServerCertConfigMap =
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
  ClusterTLSServerCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ClusterTLSServerCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ClusterTLSServerCertSecretModule);
        default = null;
      };
    };
  };
  mkClusterTLSServerCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkClusterTLSServerCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkClusterTLSServerCertSecret res."secret"; }
    // {
    };
  ClusterTLSServerCertSecretModule = types.submodule {
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
  mkClusterTLSServerCertSecret =
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
  ClusterTLSServerClient_caConfigMapModule = types.submodule {
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
  mkClusterTLSServerClient_caConfigMap =
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
  ClusterTLSServerClient_caModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ClusterTLSServerClient_caConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ClusterTLSServerClient_caSecretModule);
        default = null;
      };
    };
  };
  mkClusterTLSServerClient_ca =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkClusterTLSServerClient_caConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkClusterTLSServerClient_caSecret res."secret";
    }
    // {
    };
  ClusterTLSServerClient_caSecretModule = types.submodule {
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
  mkClusterTLSServerClient_caSecret =
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
  ClusterTLSServerKeySecretModule = types.submodule {
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
  mkClusterTLSServerKeySecret =
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
  ClusterTLSServerModule = types.submodule {
    options = {
      "cert" = mkOption {
        description = "Secret or ConfigMap containing the TLS certificate for the web server.\n\nEither `keySecret` or `keyFile` must be defined.\n\nIt is mutually exclusive with `certFile`.";
        type = (types.nullOr ClusterTLSServerCertModule);
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
        type = (types.nullOr ClusterTLSServerClient_caModule);
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
        type = (types.nullOr ClusterTLSServerKeySecretModule);
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
  mkClusterTLSServer =
    res:
    {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkClusterTLSServerCert res."cert"; }
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
      "client_ca" = mkClusterTLSServerClient_ca res."client_ca";
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
      "keySecret" = mkClusterTLSServerKeySecret res."keySecret";
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
  LimitsModule = types.submodule {
    options = {
      "maxPerSilenceBytes" = mkOption {
        description = "The maximum size of an individual silence as stored on disk. This corresponds to the Alertmanager's\n`--silences.max-per-silence-bytes` flag.\nIt requires Alertmanager >= v0.28.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "maxSilences" = mkOption {
        description = "The maximum number active and pending silences. This corresponds to the\nAlertmanager's `--silences.max-silences` flag.\nIt requires Alertmanager >= v0.28.0.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkLimits =
    res:
    {
    }
    // optionalAttrs (res."maxPerSilenceBytes" != null) { inherit (res) "maxPerSilenceBytes"; }
    // {
    }
    // optionalAttrs (res."maxSilences" != null) { inherit (res) "maxSilences"; }
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
      "getConcurrency" = mkOption {
        description = "Maximum number of GET requests processed concurrently. This corresponds to the\nAlertmanager's `--web.get-concurrency` flag.";
        type = (types.nullOr types.int);
        default = null;
      };
      "httpConfig" = mkOption {
        description = "Defines HTTP parameters for web server.";
        type = (types.nullOr WebHttpConfigModule);
        default = null;
      };
      "timeout" = mkOption {
        description = "Timeout for HTTP requests. This corresponds to the Alertmanager's\n`--web.timeout` flag.";
        type = (types.nullOr types.int);
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
    // optionalAttrs (res."getConcurrency" != null) { inherit (res) "getConcurrency"; }
    // {
    }
    // optionalAttrs (res."httpConfig" != null) { "httpConfig" = mkWebHttpConfig res."httpConfig"; }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
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
  AlertmanagersModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this Alertmanager resource.";
        };
        "additionalArgs" = mkOption {
          description = "AdditionalArgs allows setting additional arguments for the 'Alertmanager' container.\nIt is intended for e.g. activating hidden flags which are not supported by\nthe dedicated configuration options yet. The arguments are passed as-is to the\nAlertmanager container which may cause issues if they are invalid or not supported\nby the given Alertmanager version.";
          type = (types.listOf AdditionalArgModule);
          default = [ ];
        };
        "additionalPeers" = mkOption {
          description = "AdditionalPeers allows injecting a set of additional Alertmanagers to peer with to form a highly available cluster.";
          type = (types.listOf types.str);
          default = [ ];
        };
        "affinity" = mkOption {
          description = "If specified, the pod's scheduling constraints.";
          type = (types.nullOr AffinityModule);
          default = null;
        };
        "alertmanagerConfigMatcherStrategy" = mkOption {
          description = "AlertmanagerConfigMatcherStrategy defines how AlertmanagerConfig objects\nprocess incoming alerts.";
          type = (types.nullOr AlertmanagerConfigMatcherStrategyModule);
          default = null;
        };
        "alertmanagerConfigNamespaceSelector" = mkOption {
          description = "Namespaces to be selected for AlertmanagerConfig discovery. If nil, only\ncheck own namespace.";
          type = (types.nullOr AlertmanagerConfigNamespaceSelectorModule);
          default = null;
        };
        "alertmanagerConfigSelector" = mkOption {
          description = "AlertmanagerConfigs to be selected for to merge and configure Alertmanager with.";
          type = (types.nullOr AlertmanagerConfigSelectorModule);
          default = null;
        };
        "alertmanagerConfiguration" = mkOption {
          description = "alertmanagerConfiguration specifies the configuration of Alertmanager.\n\nIf defined, it takes precedence over the `configSecret` field.\n\nThis is an *experimental feature*, it may change in any upcoming release\nin a breaking way.";
          type = (types.nullOr AlertmanagerConfigurationModule);
          default = null;
        };
        "automountServiceAccountToken" = mkOption {
          description = "AutomountServiceAccountToken indicates whether a service account token should be automatically mounted in the pod.\nIf the service account has `automountServiceAccountToken: true`, set the field to `false` to opt out of automounting API credentials.";
          type = types.bool;
          default = false;
        };
        "baseImage" = mkOption {
          description = "Base image that is used to deploy pods, without tag.\nDeprecated: use 'image' instead.";
          type = (types.nullOr types.str);
          default = null;
        };
        "clusterAdvertiseAddress" = mkOption {
          description = "ClusterAdvertiseAddress is the explicit address to advertise in cluster.\nNeeds to be provided for non RFC1918 [1] (public) addresses.\n[1] RFC1918: https://tools.ietf.org/html/rfc1918";
          type = (types.nullOr types.str);
          default = null;
        };
        "clusterGossipInterval" = mkOption {
          description = "Interval between gossip attempts.";
          type = (types.nullOr types.str);
          default = null;
        };
        "clusterLabel" = mkOption {
          description = "Defines the identifier that uniquely identifies the Alertmanager cluster.\nYou should only set it when the Alertmanager cluster includes Alertmanager instances which are external to this Alertmanager resource. In practice, the addresses of the external instances are provided via the `.spec.additionalPeers` field.";
          type = (types.nullOr types.str);
          default = null;
        };
        "clusterPeerTimeout" = mkOption {
          description = "Timeout for cluster peering.";
          type = (types.nullOr types.str);
          default = null;
        };
        "clusterPushpullInterval" = mkOption {
          description = "Interval between pushpull attempts.";
          type = (types.nullOr types.str);
          default = null;
        };
        "clusterTLS" = mkOption {
          description = "Configures the mutual TLS configuration for the Alertmanager cluster's gossip protocol.\n\nIt requires Alertmanager >= 0.24.0.";
          type = (types.nullOr ClusterTLSModule);
          default = null;
        };
        "configMaps" = mkOption {
          description = "ConfigMaps is a list of ConfigMaps in the same namespace as the Alertmanager\nobject, which shall be mounted into the Alertmanager Pods.\nEach ConfigMap is added to the StatefulSet definition as a volume named `configmap-<configmap-name>`.\nThe ConfigMaps are mounted into `/etc/alertmanager/configmaps/<configmap-name>` in the 'alertmanager' container.";
          type = (types.listOf types.str);
          default = [ ];
        };
        "configSecret" = mkOption {
          description = "ConfigSecret is the name of a Kubernetes Secret in the same namespace as the\nAlertmanager object, which contains the configuration for this Alertmanager\ninstance. If empty, it defaults to `alertmanager-<alertmanager-name>`.\n\nThe Alertmanager configuration should be available under the\n`alertmanager.yaml` key. Additional keys from the original secret are\ncopied to the generated secret and mounted into the\n`/etc/alertmanager/config` directory in the `alertmanager` container.\n\nIf either the secret or the `alertmanager.yaml` key is missing, the\noperator provisions a minimal Alertmanager configuration with one empty\nreceiver (effectively dropping alert notifications).";
          type = (types.nullOr types.str);
          default = null;
        };
        "containers" = mkOption {
          description = "Containers allows injecting additional containers. This is meant to\nallow adding an authentication proxy to an Alertmanager pod.\nContainers described here modify an operator generated container if they\nshare the same name and modifications are done via a strategic merge\npatch. The current container names are: `alertmanager` and\n`config-reloader`. Overriding containers is entirely outside the scope\nof what the maintainers will support and by doing so, you accept that\nthis behaviour may break at any time without notice.";
          type = (types.listOf ContainerModule);
          default = [ ];
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
          description = "Enable access to Alertmanager feature flags. By default, no features are enabled.\nEnabling features which are disabled by default is entirely outside the\nscope of what the maintainers will support and by doing so, you accept\nthat this behaviour may break at any time without notice.\n\nIt requires Alertmanager >= 0.27.0.";
          type = (types.listOf types.str);
          default = [ ];
        };
        "enableServiceLinks" = mkOption {
          description = "Indicates whether information about services should be injected into pod's environment variables";
          type = types.bool;
          default = false;
        };
        "externalUrl" = mkOption {
          description = "The external URL the Alertmanager instances will be available under. This is\nnecessary to generate correct URLs. This is necessary if Alertmanager is not\nserved from root of a DNS name.";
          type = (types.nullOr types.str);
          default = null;
        };
        "forceEnableClusterMode" = mkOption {
          description = "ForceEnableClusterMode ensures Alertmanager does not deactivate the cluster mode when running with a single replica.\nUse case is e.g. spanning an Alertmanager cluster across Kubernetes clusters with a single replica in each.";
          type = types.bool;
          default = false;
        };
        "hostAliases" = mkOption {
          description = "Pods' hostAliases configuration";
          type = (types.listOf HostAliaseModule);
          default = [ ];
        };
        "hostUsers" = mkOption {
          description = "HostUsers supports the user space in Kubernetes.\n\nMore info: https://kubernetes.io/docs/tasks/configure-pod-container/user-namespaces/\n\nThe feature requires at least Kubernetes 1.28 with the `UserNamespacesSupport` feature gate enabled.\nStarting Kubernetes 1.33, the feature is enabled by default.";
          type = types.bool;
          default = false;
        };
        "image" = mkOption {
          description = "Image if specified has precedence over baseImage, tag and sha\ncombinations. Specifying the version is still necessary to ensure the\nPrometheus Operator knows what version of Alertmanager is being\nconfigured.";
          type = (types.nullOr types.str);
          default = null;
        };
        "imagePullPolicy" = mkOption {
          description = "Image pull policy for the 'alertmanager', 'init-config-reloader' and 'config-reloader' containers.\nSee https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy for more details.";
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
          description = "An optional list of references to secrets in the same namespace\nto use for pulling prometheus and alertmanager images from registries\nsee https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/";
          type = (types.listOf ImagePullSecretModule);
          default = [ ];
        };
        "initContainers" = mkOption {
          description = "InitContainers allows adding initContainers to the pod definition. Those can be used to e.g.\nfetch secrets for injection into the Alertmanager configuration from external sources. Any\nerrors during the execution of an initContainer will lead to a restart of the Pod. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/\nInitContainers described here modify an operator\ngenerated init containers if they share the same name and modifications are\ndone via a strategic merge patch. The current init container name is:\n`init-config-reloader`. Overriding init containers is entirely outside the\nscope of what the maintainers will support and by doing so, you accept that\nthis behaviour may break at any time without notice.";
          type = (types.listOf InitContainerModule);
          default = [ ];
        };
        "limits" = mkOption {
          description = "Defines the limits command line flags when starting Alertmanager.";
          type = (types.nullOr LimitsModule);
          default = null;
        };
        "listenLocal" = mkOption {
          description = "ListenLocal makes the Alertmanager server listen on loopback, so that it\ndoes not bind against the Pod IP. Note this is only for the Alertmanager\nUI, not the gossip communication.";
          type = types.bool;
          default = false;
        };
        "logFormat" = mkOption {
          description = "Log format for Alertmanager to be configured with.";
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
          description = "Log level for Alertmanager to be configured with.";
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
        "minReadySeconds" = mkOption {
          description = "Minimum number of seconds for which a newly created pod should be ready\nwithout any of its container crashing for it to be considered available.\n\nIf unset, pods will be considered available as soon as they are ready.";
          type = (types.nullOr types.int);
          default = null;
        };
        "nodeSelector" = mkOption {
          description = "Define which Nodes the Pods are scheduled on.";
          type = (types.attrsOf types.str);
          default = { };
        };
        "paused" = mkOption {
          description = "If set to true all actions on the underlying managed objects are not\ngoing to be performed, except for delete actions.";
          type = types.bool;
          default = false;
        };
        "persistentVolumeClaimRetentionPolicy" = mkOption {
          description = "The field controls if and how PVCs are deleted during the lifecycle of a StatefulSet.\nThe default behavior is all PVCs are retained.\nThis is an alpha field from kubernetes 1.23 until 1.26 and a beta field from 1.26.\nIt requires enabling the StatefulSetAutoDeletePVC feature gate.";
          type = (types.nullOr PersistentVolumeClaimRetentionPolicyModule);
          default = null;
        };
        "podMetadata" = mkOption {
          description = "PodMetadata configures labels and annotations which are propagated to the Alertmanager pods.\n\nThe following items are reserved and cannot be overridden:\n* \"alertmanager\" label, set to the name of the Alertmanager instance.\n* \"app.kubernetes.io/instance\" label, set to the name of the Alertmanager instance.\n* \"app.kubernetes.io/managed-by\" label, set to \"prometheus-operator\".\n* \"app.kubernetes.io/name\" label, set to \"alertmanager\".\n* \"app.kubernetes.io/version\" label, set to the Alertmanager version.\n* \"kubectl.kubernetes.io/default-container\" annotation, set to \"alertmanager\".";
          type = (types.nullOr PodMetadataModule);
          default = null;
        };
        "portName" = mkOption {
          description = "Port name used for the pods and governing service.\nDefaults to `web`.";
          type = (types.nullOr types.str);
          default = "web";
        };
        "priorityClassName" = mkOption {
          description = "Priority class assigned to the Pods";
          type = (types.nullOr types.str);
          default = null;
        };
        "replicas" = mkOption {
          description = "Size is the expected size of the alertmanager cluster. The controller will\neventually make the size of the running cluster equal to the expected\nsize.";
          type = (types.nullOr types.int);
          default = null;
        };
        "resources" = mkOption {
          description = "Define resources requests and limits for single Pods.";
          type = (types.nullOr ResourcesModule);
          default = null;
        };
        "retention" = mkOption {
          description = "Time duration Alertmanager shall retain data for. Default is '120h',\nand must match the regular expression `[0-9]+(ms|s|m|h)` (milliseconds seconds minutes hours).";
          type = (types.nullOr types.str);
          default = "120h";
        };
        "routePrefix" = mkOption {
          description = "The route prefix Alertmanager registers HTTP handlers for. This is useful,\nif using ExternalURL and a proxy is rewriting HTTP routes of a request,\nand the actual ExternalURL is still true, but the server serves requests\nunder a different route prefix. For example for use with `kubectl proxy`.";
          type = (types.nullOr types.str);
          default = null;
        };
        "secrets" = mkOption {
          description = "Secrets is a list of Secrets in the same namespace as the Alertmanager\nobject, which shall be mounted into the Alertmanager Pods.\nEach Secret is added to the StatefulSet definition as a volume named `secret-<secret-name>`.\nThe Secrets are mounted into `/etc/alertmanager/secrets/<secret-name>` in the 'alertmanager' container.";
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
        "serviceName" = mkOption {
          description = "The name of the service name used by the underlying StatefulSet(s) as the governing service.\nIf defined, the Service  must be created before the Alertmanager resource in the same namespace and it must define a selector that matches the pod labels.\nIf empty, the operator will create and manage a headless service named `alertmanager-operated` for Alermanager resources.\nWhen deploying multiple Alertmanager resources in the same namespace, it is recommended to specify a different value for each.\nSee https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#stable-network-id for more details.";
          type = (types.nullOr types.str);
          default = null;
        };
        "sha" = mkOption {
          description = "SHA of Alertmanager container image to be deployed. Defaults to the value of `version`.\nSimilar to a tag, but the SHA explicitly deploys an immutable container image.\nVersion and Tag are ignored if SHA is set.\nDeprecated: use 'image' instead. The image digest can be specified as part of the image URL.";
          type = (types.nullOr types.str);
          default = null;
        };
        "storage" = mkOption {
          description = "Storage is the definition of how storage will be used by the Alertmanager\ninstances.";
          type = (types.nullOr StorageModule);
          default = null;
        };
        "tag" = mkOption {
          description = "Tag of Alertmanager container image to be deployed. Defaults to the value of `version`.\nVersion is ignored if Tag is set.\nDeprecated: use 'image' instead. The image tag can be specified as part of the image URL.";
          type = (types.nullOr types.str);
          default = null;
        };
        "terminationGracePeriodSeconds" = mkOption {
          description = "Optional duration in seconds the pod needs to terminate gracefully.\nValue must be non-negative integer. The value zero indicates stop immediately via\nthe kill signal (no opportunity to shut down) which may lead to data corruption.\n\nDefaults to 120 seconds.";
          type = (types.nullOr types.int);
          default = null;
        };
        "tolerations" = mkOption {
          description = "If specified, the pod's tolerations.";
          type = (types.listOf TolerationModule);
          default = [ ];
        };
        "topologySpreadConstraints" = mkOption {
          description = "If specified, the pod's topology spread constraints.";
          type = (types.listOf TopologySpreadConstraintModule);
          default = [ ];
        };
        "version" = mkOption {
          description = "Version the cluster should be on.";
          type = (types.nullOr types.str);
          default = null;
        };
        "volumeMounts" = mkOption {
          description = "VolumeMounts allows configuration of additional VolumeMounts on the output StatefulSet definition.\nVolumeMounts specified will be appended to other VolumeMounts in the alertmanager container,\nthat are generated as a result of StorageSpec objects.";
          type = (types.listOf VolumeMountModule);
          default = [ ];
        };
        "volumes" = mkOption {
          description = "Volumes allows configuration of additional volumes on the output StatefulSet definition.\nVolumes specified will be appended to other volumes that are generated as a result of\nStorageSpec objects.";
          type = (types.listOf VolumeModule);
          default = [ ];
        };
        "web" = mkOption {
          description = "Defines the web command line flags when starting Alertmanager.";
          type = (types.nullOr WebModule);
          default = null;
        };
      };
    }
  );
  mkAlertmanager = name: res: {
    apiVersion = "monitoring.coreos.com/v1";
    kind = "Alertmanager";
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
    // optionalAttrs (res."additionalPeers" != [ ]) { inherit (res) "additionalPeers"; }
    // {
    }
    // optionalAttrs (res."affinity" != null) { "affinity" = mkAffinity res."affinity"; }
    // {
    }
    // optionalAttrs (res."alertmanagerConfigMatcherStrategy" != null) {
      "alertmanagerConfigMatcherStrategy" =
        mkAlertmanagerConfigMatcherStrategy
          res."alertmanagerConfigMatcherStrategy";
    }
    // {
    }
    // optionalAttrs (res."alertmanagerConfigNamespaceSelector" != null) {
      "alertmanagerConfigNamespaceSelector" =
        mkAlertmanagerConfigNamespaceSelector
          res."alertmanagerConfigNamespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."alertmanagerConfigSelector" != null) {
      "alertmanagerConfigSelector" = mkAlertmanagerConfigSelector res."alertmanagerConfigSelector";
    }
    // {
    }
    // optionalAttrs (res."alertmanagerConfiguration" != null) {
      "alertmanagerConfiguration" = mkAlertmanagerConfiguration res."alertmanagerConfiguration";
    }
    // {
    }
    // optionalAttrs res."automountServiceAccountToken" {
      inherit (res) "automountServiceAccountToken";
    }
    // {
    }
    // optionalAttrs (res."baseImage" != null) { inherit (res) "baseImage"; }
    // {
    }
    // optionalAttrs (res."clusterAdvertiseAddress" != null) {
      inherit (res) "clusterAdvertiseAddress";
    }
    // {
    }
    // optionalAttrs (res."clusterGossipInterval" != null) { inherit (res) "clusterGossipInterval"; }
    // {
    }
    // optionalAttrs (res."clusterLabel" != null) { inherit (res) "clusterLabel"; }
    // {
    }
    // optionalAttrs (res."clusterPeerTimeout" != null) { inherit (res) "clusterPeerTimeout"; }
    // {
    }
    // optionalAttrs (res."clusterPushpullInterval" != null) {
      inherit (res) "clusterPushpullInterval";
    }
    // {
    }
    // optionalAttrs (res."clusterTLS" != null) { "clusterTLS" = mkClusterTLS res."clusterTLS"; }
    // {
    }
    // optionalAttrs (res."configMaps" != [ ]) { inherit (res) "configMaps"; }
    // {
    }
    // optionalAttrs (res."configSecret" != null) { inherit (res) "configSecret"; }
    // {
    }
    // optionalAttrs (res."containers" != [ ]) { "containers" = map mkContainer res."containers"; }
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
    // optionalAttrs res."enableServiceLinks" { inherit (res) "enableServiceLinks"; }
    // {
    }
    // optionalAttrs (res."externalUrl" != null) { inherit (res) "externalUrl"; }
    // {
    }
    // optionalAttrs res."forceEnableClusterMode" { inherit (res) "forceEnableClusterMode"; }
    // {
    }
    // optionalAttrs (res."hostAliases" != [ ]) { "hostAliases" = map mkHostAliase res."hostAliases"; }
    // {
    }
    // optionalAttrs res."hostUsers" { inherit (res) "hostUsers"; }
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
    // optionalAttrs (res."limits" != null) { "limits" = mkLimits res."limits"; }
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
    // optionalAttrs (res."minReadySeconds" != null) { inherit (res) "minReadySeconds"; }
    // {
    }
    // optionalAttrs (res."nodeSelector" != { }) { inherit (res) "nodeSelector"; }
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
    // optionalAttrs (res."portName" != null) { inherit (res) "portName"; }
    // {
    }
    // optionalAttrs (res."priorityClassName" != null) { inherit (res) "priorityClassName"; }
    // {
    }
    // optionalAttrs (res."replicas" != null) { inherit (res) "replicas"; }
    // {
    }
    // optionalAttrs (res."resources" != null) { "resources" = mkResources res."resources"; }
    // {
    }
    // optionalAttrs (res."retention" != null) { inherit (res) "retention"; }
    // {
    }
    // optionalAttrs (res."routePrefix" != null) { inherit (res) "routePrefix"; }
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
    // optionalAttrs (res."serviceName" != null) { inherit (res) "serviceName"; }
    // {
    }
    // optionalAttrs (res."sha" != null) { inherit (res) "sha"; }
    // {
    }
    // optionalAttrs (res."storage" != null) { "storage" = mkStorage res."storage"; }
    // {
    }
    // optionalAttrs (res."tag" != null) { inherit (res) "tag"; }
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
    // optionalAttrs (res."web" != null) { "web" = mkWeb res."web"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkAlertmanager cfg."alertmanagers");
in
{
  options.openkrill.apps."kube-prometheus" = {
    "alertmanagers" = mkOption {
      type = types.attrsOf AlertmanagersModule;
      default = { };
      description = "Alertmanager CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."kube-prometheus".content = allResources;
  };
}
