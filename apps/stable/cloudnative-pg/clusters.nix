# Auto-generated openkrill module fragment for cloudnative-pg
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."cloudnative-pg";
  compact = filterAttrs (_: v: v != null);
  AffinityAdditionalPodAffinityModule = types.submodule {
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy\nthe affinity expressions specified by this field, but it may choose\na node that violates one or more of the expressions. The node that is\nmost preferred is the one with the greatest sum of weights, i.e.\nfor each node that meets all of the scheduling requirements (resource\nrequest, requiredDuringScheduling affinity expressions, etc.),\ncompute a sum by iterating through the elements of this field and adding\n\"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the\nnode(s) with the highest sum are the most preferred.";
        type = (
          types.listOf AffinityAdditionalPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the affinity requirements specified by this field are not met at\nscheduling time, the pod will not be scheduled onto the node.\nIf the affinity requirements specified by this field cease to be met\nat some point during pod execution (e.g. due to a pod label update), the\nsystem may or may not try to eventually evict the pod from its node.\nWhen there are multiple elements, the lists of nodes corresponding to each\npodAffinityTerm are intersected, i.e. all terms must be satisfied.";
        type = (
          types.listOf AffinityAdditionalPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
    };
  };
  mkAffinityAdditionalPodAffinity =
    res:
    {
    }
    // optionalAttrs (res."preferredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "preferredDuringSchedulingIgnoredDuringExecution" =
        map mkAffinityAdditionalPodAffinityPreferredDuringSchedulingIgnoredDuringExecution
          res."preferredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    }
    // optionalAttrs (res."requiredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "requiredDuringSchedulingIgnoredDuringExecution" =
        map mkAffinityAdditionalPodAffinityRequiredDuringSchedulingIgnoredDuringExecution
          res."requiredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    };
  AffinityAdditionalPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "podAffinityTerm" = mkOption {
            description = "Required. A pod affinity term, associated with the corresponding weight.";
            type =
              AffinityAdditionalPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule;
          };
          "weight" = mkOption {
            description = "weight associated with matching the corresponding podAffinityTerm,\nin the range 1-100.";
            type = types.int;
          };
        };
      };
  mkAffinityAdditionalPodAffinityPreferredDuringSchedulingIgnoredDuringExecution = res: {
    "podAffinityTerm" =
      mkAffinityAdditionalPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm
        res."podAffinityTerm";
    inherit (res) "weight";
  };
  AffinityAdditionalPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule =
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
  mkAffinityAdditionalPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AffinityAdditionalPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf AffinityAdditionalPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule
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
  mkAffinityAdditionalPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAffinityAdditionalPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  AffinityAdditionalPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.\nIf it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr AffinityAdditionalPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule
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
              types.nullOr AffinityAdditionalPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule
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
  mkAffinityAdditionalPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkAffinityAdditionalPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector
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
        mkAffinityAdditionalPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  AffinityAdditionalPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule =
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
  mkAffinityAdditionalPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AffinityAdditionalPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf AffinityAdditionalPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule
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
  mkAffinityAdditionalPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAffinityAdditionalPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  AffinityAdditionalPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule =
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
  mkAffinityAdditionalPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AffinityAdditionalPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf AffinityAdditionalPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule
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
  mkAffinityAdditionalPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAffinityAdditionalPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  AffinityAdditionalPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.\nIf it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr AffinityAdditionalPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule
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
              types.nullOr AffinityAdditionalPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule
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
  mkAffinityAdditionalPodAffinityRequiredDuringSchedulingIgnoredDuringExecution =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkAffinityAdditionalPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector
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
        mkAffinityAdditionalPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  AffinityAdditionalPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule =
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
  mkAffinityAdditionalPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AffinityAdditionalPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf AffinityAdditionalPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule
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
  mkAffinityAdditionalPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAffinityAdditionalPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  AffinityAdditionalPodAntiAffinityModule = types.submodule {
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy\nthe anti-affinity expressions specified by this field, but it may choose\na node that violates one or more of the expressions. The node that is\nmost preferred is the one with the greatest sum of weights, i.e.\nfor each node that meets all of the scheduling requirements (resource\nrequest, requiredDuringScheduling anti-affinity expressions, etc.),\ncompute a sum by iterating through the elements of this field and adding\n\"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the\nnode(s) with the highest sum are the most preferred.";
        type = (
          types.listOf AffinityAdditionalPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the anti-affinity requirements specified by this field are not met at\nscheduling time, the pod will not be scheduled onto the node.\nIf the anti-affinity requirements specified by this field cease to be met\nat some point during pod execution (e.g. due to a pod label update), the\nsystem may or may not try to eventually evict the pod from its node.\nWhen there are multiple elements, the lists of nodes corresponding to each\npodAffinityTerm are intersected, i.e. all terms must be satisfied.";
        type = (
          types.listOf AffinityAdditionalPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
    };
  };
  mkAffinityAdditionalPodAntiAffinity =
    res:
    {
    }
    // optionalAttrs (res."preferredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "preferredDuringSchedulingIgnoredDuringExecution" =
        map mkAffinityAdditionalPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecution
          res."preferredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    }
    // optionalAttrs (res."requiredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "requiredDuringSchedulingIgnoredDuringExecution" =
        map mkAffinityAdditionalPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecution
          res."requiredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    };
  AffinityAdditionalPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "podAffinityTerm" = mkOption {
            description = "Required. A pod affinity term, associated with the corresponding weight.";
            type =
              AffinityAdditionalPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule;
          };
          "weight" = mkOption {
            description = "weight associated with matching the corresponding podAffinityTerm,\nin the range 1-100.";
            type = types.int;
          };
        };
      };
  mkAffinityAdditionalPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecution = res: {
    "podAffinityTerm" =
      mkAffinityAdditionalPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm
        res."podAffinityTerm";
    inherit (res) "weight";
  };
  AffinityAdditionalPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule =
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
  mkAffinityAdditionalPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AffinityAdditionalPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf AffinityAdditionalPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule
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
  mkAffinityAdditionalPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAffinityAdditionalPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  AffinityAdditionalPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.\nIf it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr AffinityAdditionalPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule
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
              types.nullOr AffinityAdditionalPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule
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
  mkAffinityAdditionalPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkAffinityAdditionalPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector
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
        mkAffinityAdditionalPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  AffinityAdditionalPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule =
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
  mkAffinityAdditionalPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AffinityAdditionalPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf AffinityAdditionalPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule
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
  mkAffinityAdditionalPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAffinityAdditionalPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  AffinityAdditionalPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule =
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
  mkAffinityAdditionalPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AffinityAdditionalPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf AffinityAdditionalPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule
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
  mkAffinityAdditionalPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAffinityAdditionalPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  AffinityAdditionalPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.\nIf it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr AffinityAdditionalPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule
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
              types.nullOr AffinityAdditionalPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule
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
  mkAffinityAdditionalPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecution =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkAffinityAdditionalPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector
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
        mkAffinityAdditionalPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  AffinityAdditionalPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule =
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
  mkAffinityAdditionalPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AffinityAdditionalPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf AffinityAdditionalPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule
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
  mkAffinityAdditionalPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAffinityAdditionalPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  AffinityModule = types.submodule {
    options = {
      "additionalPodAffinity" = mkOption {
        description = "AdditionalPodAffinity allows to specify pod affinity terms to be passed to all the cluster's pods.";
        type = (types.nullOr AffinityAdditionalPodAffinityModule);
        default = null;
      };
      "additionalPodAntiAffinity" = mkOption {
        description = "AdditionalPodAntiAffinity allows to specify pod anti-affinity terms to be added to the ones generated\nby the operator if EnablePodAntiAffinity is set to true (default) or to be used exclusively if set to false.";
        type = (types.nullOr AffinityAdditionalPodAntiAffinityModule);
        default = null;
      };
      "enablePodAntiAffinity" = mkOption {
        description = "Activates anti-affinity for the pods. The operator will define pods\nanti-affinity unless this field is explicitly set to false";
        type = types.bool;
        default = false;
      };
      "nodeAffinity" = mkOption {
        description = "NodeAffinity describes node affinity scheduling rules for the pod.\nMore info: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#node-affinity";
        type = (types.nullOr AffinityNodeAffinityModule);
        default = null;
      };
      "nodeSelector" = mkOption {
        description = "NodeSelector is map of key-value pairs used to define the nodes on which\nthe pods can run.\nMore info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/";
        type = (types.attrsOf types.str);
        default = { };
      };
      "podAntiAffinityType" = mkOption {
        description = "PodAntiAffinityType allows the user to decide whether pod anti-affinity between cluster instance has to be\nconsidered a strong requirement during scheduling or not. Allowed values are: \"preferred\" (default if empty) or\n\"required\". Setting it to \"required\", could lead to instances remaining pending until new kubernetes nodes are\nadded if all the existing nodes don't match the required pod anti-affinity rule.\nMore info:\nhttps://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#inter-pod-affinity-and-anti-affinity";
        type = (types.nullOr types.str);
        default = null;
      };
      "tolerations" = mkOption {
        description = "Tolerations is a list of Tolerations that should be set for all the pods, in order to allow them to run\non tainted nodes.\nMore info: https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/";
        type = (types.listOf AffinityTolerationModule);
        default = [ ];
      };
      "topologyKey" = mkOption {
        description = "TopologyKey to use for anti-affinity configuration. See k8s documentation\nfor more info on that";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkAffinity =
    res:
    {
    }
    // optionalAttrs (res."additionalPodAffinity" != null) {
      "additionalPodAffinity" = mkAffinityAdditionalPodAffinity res."additionalPodAffinity";
    }
    // {
    }
    // optionalAttrs (res."additionalPodAntiAffinity" != null) {
      "additionalPodAntiAffinity" = mkAffinityAdditionalPodAntiAffinity res."additionalPodAntiAffinity";
    }
    // {
    }
    // optionalAttrs res."enablePodAntiAffinity" { inherit (res) "enablePodAntiAffinity"; }
    // {
    }
    // optionalAttrs (res."nodeAffinity" != null) {
      "nodeAffinity" = mkAffinityNodeAffinity res."nodeAffinity";
    }
    // {
    }
    // optionalAttrs (res."nodeSelector" != { }) { inherit (res) "nodeSelector"; }
    // {
    }
    // optionalAttrs (res."podAntiAffinityType" != null) { inherit (res) "podAntiAffinityType"; }
    // {
    }
    // optionalAttrs (res."tolerations" != [ ]) {
      "tolerations" = map mkAffinityToleration res."tolerations";
    }
    // {
    }
    // optionalAttrs (res."topologyKey" != null) { inherit (res) "topologyKey"; }
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
  AffinityTolerationModule = types.submodule {
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
  mkAffinityToleration =
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
  BackupBarmanObjectStoreAzureCredentialsConnectionStringModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkBackupBarmanObjectStoreAzureCredentialsConnectionString = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  BackupBarmanObjectStoreAzureCredentialsModule = types.submodule {
    options = {
      "connectionString" = mkOption {
        description = "The connection string to be used";
        type = (types.nullOr BackupBarmanObjectStoreAzureCredentialsConnectionStringModule);
        default = null;
      };
      "inheritFromAzureAD" = mkOption {
        description = "Use the Azure AD based authentication without providing explicitly the keys.";
        type = types.bool;
        default = false;
      };
      "storageAccount" = mkOption {
        description = "The storage account where to upload data";
        type = (types.nullOr BackupBarmanObjectStoreAzureCredentialsStorageAccountModule);
        default = null;
      };
      "storageKey" = mkOption {
        description = "The storage account key to be used in conjunction\nwith the storage account name";
        type = (types.nullOr BackupBarmanObjectStoreAzureCredentialsStorageKeyModule);
        default = null;
      };
      "storageSasToken" = mkOption {
        description = "A shared-access-signature to be used in conjunction with\nthe storage account name";
        type = (types.nullOr BackupBarmanObjectStoreAzureCredentialsStorageSasTokenModule);
        default = null;
      };
    };
  };
  mkBackupBarmanObjectStoreAzureCredentials =
    res:
    {
    }
    // optionalAttrs (res."connectionString" != null) {
      "connectionString" =
        mkBackupBarmanObjectStoreAzureCredentialsConnectionString
          res."connectionString";
    }
    // {
    }
    // optionalAttrs res."inheritFromAzureAD" { inherit (res) "inheritFromAzureAD"; }
    // {
    }
    // optionalAttrs (res."storageAccount" != null) {
      "storageAccount" = mkBackupBarmanObjectStoreAzureCredentialsStorageAccount res."storageAccount";
    }
    // {
    }
    // optionalAttrs (res."storageKey" != null) {
      "storageKey" = mkBackupBarmanObjectStoreAzureCredentialsStorageKey res."storageKey";
    }
    // {
    }
    // optionalAttrs (res."storageSasToken" != null) {
      "storageSasToken" = mkBackupBarmanObjectStoreAzureCredentialsStorageSasToken res."storageSasToken";
    }
    // {
    };
  BackupBarmanObjectStoreAzureCredentialsStorageAccountModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkBackupBarmanObjectStoreAzureCredentialsStorageAccount = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  BackupBarmanObjectStoreAzureCredentialsStorageKeyModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkBackupBarmanObjectStoreAzureCredentialsStorageKey = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  BackupBarmanObjectStoreAzureCredentialsStorageSasTokenModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkBackupBarmanObjectStoreAzureCredentialsStorageSasToken = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  BackupBarmanObjectStoreDataModule = types.submodule {
    options = {
      "additionalCommandArgs" = mkOption {
        description = "AdditionalCommandArgs represents additional arguments that can be appended\nto the 'barman-cloud-backup' command-line invocation. These arguments\nprovide flexibility to customize the backup process further according to\nspecific requirements or configurations.\n\nExample:\nIn a scenario where specialized backup options are required, such as setting\na specific timeout or defining custom behavior, users can use this field\nto specify additional command arguments.\n\nNote:\nIt's essential to ensure that the provided arguments are valid and supported\nby the 'barman-cloud-backup' command, to avoid potential errors or unintended\nbehavior during execution.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "compression" = mkOption {
        description = "Compress a backup file (a tar file per tablespace) while streaming it\nto the object store. Available options are empty string (no\ncompression, default), `gzip`, `bzip2`, and `snappy`.";
        type = (
          types.nullOr (
            types.enum [
              "bzip2"
              "gzip"
              "snappy"
            ]
          )
        );
        default = null;
      };
      "encryption" = mkOption {
        description = "Whenever to force the encryption of files (if the bucket is\nnot already configured for that).\nAllowed options are empty string (use the bucket policy, default),\n`AES256` and `aws:kms`";
        type = (
          types.nullOr (
            types.enum [
              "AES256"
              "aws:kms"
            ]
          )
        );
        default = null;
      };
      "immediateCheckpoint" = mkOption {
        description = "Control whether the I/O workload for the backup initial checkpoint will\nbe limited, according to the `checkpoint_completion_target` setting on\nthe PostgreSQL server. If set to true, an immediate checkpoint will be\nused, meaning PostgreSQL will complete the checkpoint as soon as\npossible. `false` by default.";
        type = types.bool;
        default = false;
      };
      "jobs" = mkOption {
        description = "The number of parallel jobs to be used to upload the backup, defaults\nto 2";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkBackupBarmanObjectStoreData =
    res:
    {
    }
    // optionalAttrs (res."additionalCommandArgs" != [ ]) { inherit (res) "additionalCommandArgs"; }
    // {
    }
    // optionalAttrs (res."compression" != null) { inherit (res) "compression"; }
    // {
    }
    // optionalAttrs (res."encryption" != null) { inherit (res) "encryption"; }
    // {
    }
    // optionalAttrs res."immediateCheckpoint" { inherit (res) "immediateCheckpoint"; }
    // {
    }
    // optionalAttrs (res."jobs" != null) { inherit (res) "jobs"; }
    // {
    };
  BackupBarmanObjectStoreEndpointCAModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkBackupBarmanObjectStoreEndpointCA = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  BackupBarmanObjectStoreGoogleCredentialsApplicationCredentialsModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkBackupBarmanObjectStoreGoogleCredentialsApplicationCredentials = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  BackupBarmanObjectStoreGoogleCredentialsModule = types.submodule {
    options = {
      "applicationCredentials" = mkOption {
        description = "The secret containing the Google Cloud Storage JSON file with the credentials";
        type = (types.nullOr BackupBarmanObjectStoreGoogleCredentialsApplicationCredentialsModule);
        default = null;
      };
      "gkeEnvironment" = mkOption {
        description = "If set to true, will presume that it's running inside a GKE environment,\ndefault to false.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkBackupBarmanObjectStoreGoogleCredentials =
    res:
    {
    }
    // optionalAttrs (res."applicationCredentials" != null) {
      "applicationCredentials" =
        mkBackupBarmanObjectStoreGoogleCredentialsApplicationCredentials
          res."applicationCredentials";
    }
    // {
    }
    // optionalAttrs res."gkeEnvironment" { inherit (res) "gkeEnvironment"; }
    // {
    };
  BackupBarmanObjectStoreModule = types.submodule {
    options = {
      "azureCredentials" = mkOption {
        description = "The credentials to use to upload data to Azure Blob Storage";
        type = (types.nullOr BackupBarmanObjectStoreAzureCredentialsModule);
        default = null;
      };
      "data" = mkOption {
        description = "The configuration to be used to backup the data files\nWhen not defined, base backups files will be stored uncompressed and may\nbe unencrypted in the object store, according to the bucket default\npolicy.";
        type = (types.nullOr BackupBarmanObjectStoreDataModule);
        default = null;
      };
      "destinationPath" = mkOption {
        description = "The path where to store the backup (i.e. s3://bucket/path/to/folder)\nthis path, with different destination folders, will be used for WALs\nand for data";
        type = types.str;
      };
      "endpointCA" = mkOption {
        description = "EndpointCA store the CA bundle of the barman endpoint.\nUseful when using self-signed certificates to avoid\nerrors with certificate issuer and barman-cloud-wal-archive";
        type = (types.nullOr BackupBarmanObjectStoreEndpointCAModule);
        default = null;
      };
      "endpointURL" = mkOption {
        description = "Endpoint to be used to upload data to the cloud,\noverriding the automatic endpoint discovery";
        type = (types.nullOr types.str);
        default = null;
      };
      "googleCredentials" = mkOption {
        description = "The credentials to use to upload data to Google Cloud Storage";
        type = (types.nullOr BackupBarmanObjectStoreGoogleCredentialsModule);
        default = null;
      };
      "historyTags" = mkOption {
        description = "HistoryTags is a list of key value pairs that will be passed to the\nBarman --history-tags option.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "s3Credentials" = mkOption {
        description = "The credentials to use to upload data to S3";
        type = (types.nullOr BackupBarmanObjectStoreS3CredentialsModule);
        default = null;
      };
      "serverName" = mkOption {
        description = "The server name on S3, the cluster name is used if this\nparameter is omitted";
        type = (types.nullOr types.str);
        default = null;
      };
      "tags" = mkOption {
        description = "Tags is a list of key value pairs that will be passed to the\nBarman --tags option.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "wal" = mkOption {
        description = "The configuration for the backup of the WAL stream.\nWhen not defined, WAL files will be stored uncompressed and may be\nunencrypted in the object store, according to the bucket default policy.";
        type = (types.nullOr BackupBarmanObjectStoreWalModule);
        default = null;
      };
    };
  };
  mkBackupBarmanObjectStore =
    res:
    {
    }
    // optionalAttrs (res."azureCredentials" != null) {
      "azureCredentials" = mkBackupBarmanObjectStoreAzureCredentials res."azureCredentials";
    }
    // {
    }
    // optionalAttrs (res."data" != null) { "data" = mkBackupBarmanObjectStoreData res."data"; }
    // {
      inherit (res) "destinationPath";
    }
    // optionalAttrs (res."endpointCA" != null) {
      "endpointCA" = mkBackupBarmanObjectStoreEndpointCA res."endpointCA";
    }
    // {
    }
    // optionalAttrs (res."endpointURL" != null) { inherit (res) "endpointURL"; }
    // {
    }
    // optionalAttrs (res."googleCredentials" != null) {
      "googleCredentials" = mkBackupBarmanObjectStoreGoogleCredentials res."googleCredentials";
    }
    // {
    }
    // optionalAttrs (res."historyTags" != { }) { inherit (res) "historyTags"; }
    // {
    }
    // optionalAttrs (res."s3Credentials" != null) {
      "s3Credentials" = mkBackupBarmanObjectStoreS3Credentials res."s3Credentials";
    }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    }
    // optionalAttrs (res."tags" != { }) { inherit (res) "tags"; }
    // {
    }
    // optionalAttrs (res."wal" != null) { "wal" = mkBackupBarmanObjectStoreWal res."wal"; }
    // {
    };
  BackupBarmanObjectStoreS3CredentialsAccessKeyIdModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkBackupBarmanObjectStoreS3CredentialsAccessKeyId = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  BackupBarmanObjectStoreS3CredentialsModule = types.submodule {
    options = {
      "accessKeyId" = mkOption {
        description = "The reference to the access key id";
        type = (types.nullOr BackupBarmanObjectStoreS3CredentialsAccessKeyIdModule);
        default = null;
      };
      "inheritFromIAMRole" = mkOption {
        description = "Use the role based authentication without providing explicitly the keys.";
        type = types.bool;
        default = false;
      };
      "region" = mkOption {
        description = "The reference to the secret containing the region name";
        type = (types.nullOr BackupBarmanObjectStoreS3CredentialsRegionModule);
        default = null;
      };
      "secretAccessKey" = mkOption {
        description = "The reference to the secret access key";
        type = (types.nullOr BackupBarmanObjectStoreS3CredentialsSecretAccessKeyModule);
        default = null;
      };
      "sessionToken" = mkOption {
        description = "The references to the session key";
        type = (types.nullOr BackupBarmanObjectStoreS3CredentialsSessionTokenModule);
        default = null;
      };
    };
  };
  mkBackupBarmanObjectStoreS3Credentials =
    res:
    {
    }
    // optionalAttrs (res."accessKeyId" != null) {
      "accessKeyId" = mkBackupBarmanObjectStoreS3CredentialsAccessKeyId res."accessKeyId";
    }
    // {
    }
    // optionalAttrs res."inheritFromIAMRole" { inherit (res) "inheritFromIAMRole"; }
    // {
    }
    // optionalAttrs (res."region" != null) {
      "region" = mkBackupBarmanObjectStoreS3CredentialsRegion res."region";
    }
    // {
    }
    // optionalAttrs (res."secretAccessKey" != null) {
      "secretAccessKey" = mkBackupBarmanObjectStoreS3CredentialsSecretAccessKey res."secretAccessKey";
    }
    // {
    }
    // optionalAttrs (res."sessionToken" != null) {
      "sessionToken" = mkBackupBarmanObjectStoreS3CredentialsSessionToken res."sessionToken";
    }
    // {
    };
  BackupBarmanObjectStoreS3CredentialsRegionModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkBackupBarmanObjectStoreS3CredentialsRegion = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  BackupBarmanObjectStoreS3CredentialsSecretAccessKeyModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkBackupBarmanObjectStoreS3CredentialsSecretAccessKey = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  BackupBarmanObjectStoreS3CredentialsSessionTokenModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkBackupBarmanObjectStoreS3CredentialsSessionToken = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  BackupBarmanObjectStoreWalModule = types.submodule {
    options = {
      "archiveAdditionalCommandArgs" = mkOption {
        description = "Additional arguments that can be appended to the 'barman-cloud-wal-archive'\ncommand-line invocation. These arguments provide flexibility to customize\nthe WAL archive process further, according to specific requirements or configurations.\n\nExample:\nIn a scenario where specialized backup options are required, such as setting\na specific timeout or defining custom behavior, users can use this field\nto specify additional command arguments.\n\nNote:\nIt's essential to ensure that the provided arguments are valid and supported\nby the 'barman-cloud-wal-archive' command, to avoid potential errors or unintended\nbehavior during execution.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "compression" = mkOption {
        description = "Compress a WAL file before sending it to the object store. Available\noptions are empty string (no compression, default), `gzip`, `bzip2`,\n`lz4`, `snappy`, `xz`, and `zstd`.";
        type = (
          types.nullOr (
            types.enum [
              "bzip2"
              "gzip"
              "lz4"
              "snappy"
              "xz"
              "zstd"
            ]
          )
        );
        default = null;
      };
      "encryption" = mkOption {
        description = "Whenever to force the encryption of files (if the bucket is\nnot already configured for that).\nAllowed options are empty string (use the bucket policy, default),\n`AES256` and `aws:kms`";
        type = (
          types.nullOr (
            types.enum [
              "AES256"
              "aws:kms"
            ]
          )
        );
        default = null;
      };
      "maxParallel" = mkOption {
        description = "Number of WAL files to be either archived in parallel (when the\nPostgreSQL instance is archiving to a backup object store) or\nrestored in parallel (when a PostgreSQL standby is fetching WAL\nfiles from a recovery object store). If not specified, WAL files\nwill be processed one at a time. It accepts a positive integer as a\nvalue - with 1 being the minimum accepted value.";
        type = (types.nullOr types.int);
        default = null;
      };
      "restoreAdditionalCommandArgs" = mkOption {
        description = "Additional arguments that can be appended to the 'barman-cloud-wal-restore'\ncommand-line invocation. These arguments provide flexibility to customize\nthe WAL restore process further, according to specific requirements or configurations.\n\nExample:\nIn a scenario where specialized backup options are required, such as setting\na specific timeout or defining custom behavior, users can use this field\nto specify additional command arguments.\n\nNote:\nIt's essential to ensure that the provided arguments are valid and supported\nby the 'barman-cloud-wal-restore' command, to avoid potential errors or unintended\nbehavior during execution.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkBackupBarmanObjectStoreWal =
    res:
    {
    }
    // optionalAttrs (res."archiveAdditionalCommandArgs" != [ ]) {
      inherit (res) "archiveAdditionalCommandArgs";
    }
    // {
    }
    // optionalAttrs (res."compression" != null) { inherit (res) "compression"; }
    // {
    }
    // optionalAttrs (res."encryption" != null) { inherit (res) "encryption"; }
    // {
    }
    // optionalAttrs (res."maxParallel" != null) { inherit (res) "maxParallel"; }
    // {
    }
    // optionalAttrs (res."restoreAdditionalCommandArgs" != [ ]) {
      inherit (res) "restoreAdditionalCommandArgs";
    }
    // {
    };
  BackupModule = types.submodule {
    options = {
      "barmanObjectStore" = mkOption {
        description = "The configuration for the barman-cloud tool suite";
        type = (types.nullOr BackupBarmanObjectStoreModule);
        default = null;
      };
      "retentionPolicy" = mkOption {
        description = "RetentionPolicy is the retention policy to be used for backups\nand WALs (i.e. '60d'). The retention policy is expressed in the form\nof `XXu` where `XX` is a positive integer and `u` is in `[dwm]` -\ndays, weeks, months.\nIt's currently only applicable when using the BarmanObjectStore method.";
        type = (types.nullOr types.str);
        default = null;
      };
      "target" = mkOption {
        description = "The policy to decide which instance should perform backups. Available\noptions are empty string, which will default to `prefer-standby` policy,\n`primary` to have backups run always on primary instances, `prefer-standby`\nto have backups run preferably on the most updated standby, if available.";
        type = (
          types.nullOr (
            types.enum [
              "primary"
              "prefer-standby"
            ]
          )
        );
        default = "prefer-standby";
      };
      "volumeSnapshot" = mkOption {
        description = "VolumeSnapshot provides the configuration for the execution of volume snapshot backups.";
        type = (types.nullOr BackupVolumeSnapshotModule);
        default = null;
      };
    };
  };
  mkBackup =
    res:
    {
    }
    // optionalAttrs (res."barmanObjectStore" != null) {
      "barmanObjectStore" = mkBackupBarmanObjectStore res."barmanObjectStore";
    }
    // {
    }
    // optionalAttrs (res."retentionPolicy" != null) { inherit (res) "retentionPolicy"; }
    // {
    }
    // optionalAttrs (res."target" != null) { inherit (res) "target"; }
    // {
    }
    // optionalAttrs (res."volumeSnapshot" != null) {
      "volumeSnapshot" = mkBackupVolumeSnapshot res."volumeSnapshot";
    }
    // {
    };
  BackupVolumeSnapshotModule = types.submodule {
    options = {
      "annotations" = mkOption {
        description = "Annotations key-value pairs that will be added to .metadata.annotations snapshot resources.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "className" = mkOption {
        description = "ClassName specifies the Snapshot Class to be used for PG_DATA PersistentVolumeClaim.\nIt is the default class for the other types if no specific class is present";
        type = (types.nullOr types.str);
        default = null;
      };
      "labels" = mkOption {
        description = "Labels are key-value pairs that will be added to .metadata.labels snapshot resources.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "online" = mkOption {
        description = "Whether the default type of backup with volume snapshots is\nonline/hot (`true`, default) or offline/cold (`false`)";
        type = types.bool;
        default = true;
      };
      "onlineConfiguration" = mkOption {
        description = "Configuration parameters to control the online/hot backup with volume snapshots";
        type = (types.nullOr BackupVolumeSnapshotOnlineConfigurationModule);
        default = {
          "immediateCheckpoint" = false;
          "waitForArchive" = true;
        };
      };
      "snapshotOwnerReference" = mkOption {
        description = "SnapshotOwnerReference indicates the type of owner reference the snapshot should have";
        type = (
          types.nullOr (
            types.enum [
              "none"
              "cluster"
              "backup"
            ]
          )
        );
        default = "none";
      };
      "tablespaceClassName" = mkOption {
        description = "TablespaceClassName specifies the Snapshot Class to be used for the tablespaces.\ndefaults to the PGDATA Snapshot Class, if set";
        type = (types.attrsOf types.str);
        default = { };
      };
      "walClassName" = mkOption {
        description = "WalClassName specifies the Snapshot Class to be used for the PG_WAL PersistentVolumeClaim.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkBackupVolumeSnapshot =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."className" != null) { inherit (res) "className"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."online" != null) { inherit (res) "online"; }
    // {
    }
    // optionalAttrs (res."onlineConfiguration" != null) {
      "onlineConfiguration" = mkBackupVolumeSnapshotOnlineConfiguration res."onlineConfiguration";
    }
    // {
    }
    // optionalAttrs (res."snapshotOwnerReference" != null) { inherit (res) "snapshotOwnerReference"; }
    // {
    }
    // optionalAttrs (res."tablespaceClassName" != { }) { inherit (res) "tablespaceClassName"; }
    // {
    }
    // optionalAttrs (res."walClassName" != null) { inherit (res) "walClassName"; }
    // {
    };
  BackupVolumeSnapshotOnlineConfigurationModule = types.submodule {
    options = {
      "immediateCheckpoint" = mkOption {
        description = "Control whether the I/O workload for the backup initial checkpoint will\nbe limited, according to the `checkpoint_completion_target` setting on\nthe PostgreSQL server. If set to true, an immediate checkpoint will be\nused, meaning PostgreSQL will complete the checkpoint as soon as\npossible. `false` by default.";
        type = types.bool;
        default = false;
      };
      "waitForArchive" = mkOption {
        description = "If false, the function will return immediately after the backup is completed,\nwithout waiting for WAL to be archived.\nThis behavior is only useful with backup software that independently monitors WAL archiving.\nOtherwise, WAL required to make the backup consistent might be missing and make the backup useless.\nBy default, or when this parameter is true, pg_backup_stop will wait for WAL to be archived when archiving is\nenabled.\nOn a standby, this means that it will wait only when archive_mode = always.\nIf write activity on the primary is low, it may be useful to run pg_switch_wal on the primary in order to trigger\nan immediate segment switch.";
        type = types.bool;
        default = true;
      };
    };
  };
  mkBackupVolumeSnapshotOnlineConfiguration =
    res:
    {
    }
    // optionalAttrs res."immediateCheckpoint" { inherit (res) "immediateCheckpoint"; }
    // {
    }
    // optionalAttrs (res."waitForArchive" != null) { inherit (res) "waitForArchive"; }
    // {
    };
  BootstrapInitdbImportModule = types.submodule {
    options = {
      "databases" = mkOption {
        description = "The databases to import";
        type = (types.listOf types.str);
      };
      "pgDumpExtraOptions" = mkOption {
        description = "List of custom options to pass to the `pg_dump` command. IMPORTANT:\nUse these options with caution and at your own risk, as the operator\ndoes not validate their content. Be aware that certain options may\nconflict with the operator's intended functionality or design.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "pgRestoreExtraOptions" = mkOption {
        description = "List of custom options to pass to the `pg_restore` command. IMPORTANT:\nUse these options with caution and at your own risk, as the operator\ndoes not validate their content. Be aware that certain options may\nconflict with the operator's intended functionality or design.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "postImportApplicationSQL" = mkOption {
        description = "List of SQL queries to be executed as a superuser in the application\ndatabase right after is imported - to be used with extreme care\n(by default empty). Only available in microservice type.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "roles" = mkOption {
        description = "The roles to import";
        type = (types.listOf types.str);
        default = [ ];
      };
      "schemaOnly" = mkOption {
        description = "When set to true, only the `pre-data` and `post-data` sections of\n`pg_restore` are invoked, avoiding data import. Default: `false`.";
        type = types.bool;
        default = false;
      };
      "source" = mkOption {
        description = "The source of the import";
        type = BootstrapInitdbImportSourceModule;
      };
      "type" = mkOption {
        description = "The import type. Can be `microservice` or `monolith`.";
        type = (
          types.enum [
            "microservice"
            "monolith"
          ]
        );
      };
    };
  };
  mkBootstrapInitdbImport =
    res:
    {
      inherit (res) "databases";
    }
    // optionalAttrs (res."pgDumpExtraOptions" != [ ]) { inherit (res) "pgDumpExtraOptions"; }
    // {
    }
    // optionalAttrs (res."pgRestoreExtraOptions" != [ ]) { inherit (res) "pgRestoreExtraOptions"; }
    // {
    }
    // optionalAttrs (res."postImportApplicationSQL" != [ ]) {
      inherit (res) "postImportApplicationSQL";
    }
    // {
    }
    // optionalAttrs (res."roles" != [ ]) { inherit (res) "roles"; }
    // {
    }
    // optionalAttrs res."schemaOnly" { inherit (res) "schemaOnly"; }
    // {
      "source" = mkBootstrapInitdbImportSource res."source";
      inherit (res) "type";
    };
  BootstrapInitdbImportSourceModule = types.submodule {
    options = {
      "externalCluster" = mkOption {
        description = "The name of the externalCluster used for import";
        type = types.str;
      };
    };
  };
  mkBootstrapInitdbImportSource = res: {
    inherit (res) "externalCluster";
  };
  BootstrapInitdbModule = types.submodule {
    options = {
      "builtinLocale" = mkOption {
        description = "Specifies the locale name when the builtin provider is used.\nThis option requires `localeProvider` to be set to `builtin`.\nAvailable from PostgreSQL 17.";
        type = (types.nullOr types.str);
        default = null;
      };
      "dataChecksums" = mkOption {
        description = "Whether the `-k` option should be passed to initdb,\nenabling checksums on data pages (default: `false`)";
        type = types.bool;
        default = false;
      };
      "database" = mkOption {
        description = "Name of the database used by the application. Default: `app`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "encoding" = mkOption {
        description = "The value to be passed as option `--encoding` for initdb (default:`UTF8`)";
        type = (types.nullOr types.str);
        default = null;
      };
      "icuLocale" = mkOption {
        description = "Specifies the ICU locale when the ICU provider is used.\nThis option requires `localeProvider` to be set to `icu`.\nAvailable from PostgreSQL 15.";
        type = (types.nullOr types.str);
        default = null;
      };
      "icuRules" = mkOption {
        description = "Specifies additional collation rules to customize the behavior of the default collation.\nThis option requires `localeProvider` to be set to `icu`.\nAvailable from PostgreSQL 16.";
        type = (types.nullOr types.str);
        default = null;
      };
      "import" = mkOption {
        description = "Bootstraps the new cluster by importing data from an existing PostgreSQL\ninstance using logical backup (`pg_dump` and `pg_restore`)";
        type = (types.nullOr BootstrapInitdbImportModule);
        default = null;
      };
      "locale" = mkOption {
        description = "Sets the default collation order and character classification in the new database.";
        type = (types.nullOr types.str);
        default = null;
      };
      "localeCType" = mkOption {
        description = "The value to be passed as option `--lc-ctype` for initdb (default:`C`)";
        type = (types.nullOr types.str);
        default = null;
      };
      "localeCollate" = mkOption {
        description = "The value to be passed as option `--lc-collate` for initdb (default:`C`)";
        type = (types.nullOr types.str);
        default = null;
      };
      "localeProvider" = mkOption {
        description = "This option sets the locale provider for databases created in the new cluster.\nAvailable from PostgreSQL 16.";
        type = (types.nullOr types.str);
        default = null;
      };
      "options" = mkOption {
        description = "The list of options that must be passed to initdb when creating the cluster.\nDeprecated: This could lead to inconsistent configurations,\nplease use the explicit provided parameters instead.\nIf defined, explicit values will be ignored.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "owner" = mkOption {
        description = "Name of the owner of the database in the instance to be used\nby applications. Defaults to the value of the `database` key.";
        type = (types.nullOr types.str);
        default = null;
      };
      "postInitApplicationSQL" = mkOption {
        description = "List of SQL queries to be executed as a superuser in the application\ndatabase right after the cluster has been created - to be used with extreme care\n(by default empty)";
        type = (types.listOf types.str);
        default = [ ];
      };
      "postInitApplicationSQLRefs" = mkOption {
        description = "List of references to ConfigMaps or Secrets containing SQL files\nto be executed as a superuser in the application database right after\nthe cluster has been created. The references are processed in a specific order:\nfirst, all Secrets are processed, followed by all ConfigMaps.\nWithin each group, the processing order follows the sequence specified\nin their respective arrays.\n(by default empty)";
        type = (types.nullOr BootstrapInitdbPostInitApplicationSQLRefsModule);
        default = null;
      };
      "postInitSQL" = mkOption {
        description = "List of SQL queries to be executed as a superuser in the `postgres`\ndatabase right after the cluster has been created - to be used with extreme care\n(by default empty)";
        type = (types.listOf types.str);
        default = [ ];
      };
      "postInitSQLRefs" = mkOption {
        description = "List of references to ConfigMaps or Secrets containing SQL files\nto be executed as a superuser in the `postgres` database right after\nthe cluster has been created. The references are processed in a specific order:\nfirst, all Secrets are processed, followed by all ConfigMaps.\nWithin each group, the processing order follows the sequence specified\nin their respective arrays.\n(by default empty)";
        type = (types.nullOr BootstrapInitdbPostInitSQLRefsModule);
        default = null;
      };
      "postInitTemplateSQL" = mkOption {
        description = "List of SQL queries to be executed as a superuser in the `template1`\ndatabase right after the cluster has been created - to be used with extreme care\n(by default empty)";
        type = (types.listOf types.str);
        default = [ ];
      };
      "postInitTemplateSQLRefs" = mkOption {
        description = "List of references to ConfigMaps or Secrets containing SQL files\nto be executed as a superuser in the `template1` database right after\nthe cluster has been created. The references are processed in a specific order:\nfirst, all Secrets are processed, followed by all ConfigMaps.\nWithin each group, the processing order follows the sequence specified\nin their respective arrays.\n(by default empty)";
        type = (types.nullOr BootstrapInitdbPostInitTemplateSQLRefsModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Name of the secret containing the initial credentials for the\nowner of the user database. If empty a new secret will be\ncreated from scratch";
        type = (types.nullOr BootstrapInitdbSecretModule);
        default = null;
      };
      "walSegmentSize" = mkOption {
        description = "The value in megabytes (1 to 1024) to be passed to the `--wal-segsize`\noption for initdb (default: empty, resulting in PostgreSQL default: 16MB)";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkBootstrapInitdb =
    res:
    {
    }
    // optionalAttrs (res."builtinLocale" != null) { inherit (res) "builtinLocale"; }
    // {
    }
    // optionalAttrs res."dataChecksums" { inherit (res) "dataChecksums"; }
    // {
    }
    // optionalAttrs (res."database" != null) { inherit (res) "database"; }
    // {
    }
    // optionalAttrs (res."encoding" != null) { inherit (res) "encoding"; }
    // {
    }
    // optionalAttrs (res."icuLocale" != null) { inherit (res) "icuLocale"; }
    // {
    }
    // optionalAttrs (res."icuRules" != null) { inherit (res) "icuRules"; }
    // {
    }
    // optionalAttrs (res."import" != null) { "import" = mkBootstrapInitdbImport res."import"; }
    // {
    }
    // optionalAttrs (res."locale" != null) { inherit (res) "locale"; }
    // {
    }
    // optionalAttrs (res."localeCType" != null) { inherit (res) "localeCType"; }
    // {
    }
    // optionalAttrs (res."localeCollate" != null) { inherit (res) "localeCollate"; }
    // {
    }
    // optionalAttrs (res."localeProvider" != null) { inherit (res) "localeProvider"; }
    // {
    }
    // optionalAttrs (res."options" != [ ]) { inherit (res) "options"; }
    // {
    }
    // optionalAttrs (res."owner" != null) { inherit (res) "owner"; }
    // {
    }
    // optionalAttrs (res."postInitApplicationSQL" != [ ]) { inherit (res) "postInitApplicationSQL"; }
    // {
    }
    // optionalAttrs (res."postInitApplicationSQLRefs" != null) {
      "postInitApplicationSQLRefs" =
        mkBootstrapInitdbPostInitApplicationSQLRefs
          res."postInitApplicationSQLRefs";
    }
    // {
    }
    // optionalAttrs (res."postInitSQL" != [ ]) { inherit (res) "postInitSQL"; }
    // {
    }
    // optionalAttrs (res."postInitSQLRefs" != null) {
      "postInitSQLRefs" = mkBootstrapInitdbPostInitSQLRefs res."postInitSQLRefs";
    }
    // {
    }
    // optionalAttrs (res."postInitTemplateSQL" != [ ]) { inherit (res) "postInitTemplateSQL"; }
    // {
    }
    // optionalAttrs (res."postInitTemplateSQLRefs" != null) {
      "postInitTemplateSQLRefs" = mkBootstrapInitdbPostInitTemplateSQLRefs res."postInitTemplateSQLRefs";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkBootstrapInitdbSecret res."secret"; }
    // {
    }
    // optionalAttrs (res."walSegmentSize" != null) { inherit (res) "walSegmentSize"; }
    // {
    };
  BootstrapInitdbPostInitApplicationSQLRefsConfigMapRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkBootstrapInitdbPostInitApplicationSQLRefsConfigMapRef = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  BootstrapInitdbPostInitApplicationSQLRefsModule = types.submodule {
    options = {
      "configMapRefs" = mkOption {
        description = "ConfigMapRefs holds a list of references to ConfigMaps";
        type = (types.listOf BootstrapInitdbPostInitApplicationSQLRefsConfigMapRefModule);
        default = [ ];
      };
      "secretRefs" = mkOption {
        description = "SecretRefs holds a list of references to Secrets";
        type = (types.listOf BootstrapInitdbPostInitApplicationSQLRefsSecretRefModule);
        default = [ ];
      };
    };
  };
  mkBootstrapInitdbPostInitApplicationSQLRefs =
    res:
    {
    }
    // optionalAttrs (res."configMapRefs" != [ ]) {
      "configMapRefs" = map mkBootstrapInitdbPostInitApplicationSQLRefsConfigMapRef res."configMapRefs";
    }
    // {
    }
    // optionalAttrs (res."secretRefs" != [ ]) {
      "secretRefs" = map mkBootstrapInitdbPostInitApplicationSQLRefsSecretRef res."secretRefs";
    }
    // {
    };
  BootstrapInitdbPostInitApplicationSQLRefsSecretRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkBootstrapInitdbPostInitApplicationSQLRefsSecretRef = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  BootstrapInitdbPostInitSQLRefsConfigMapRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkBootstrapInitdbPostInitSQLRefsConfigMapRef = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  BootstrapInitdbPostInitSQLRefsModule = types.submodule {
    options = {
      "configMapRefs" = mkOption {
        description = "ConfigMapRefs holds a list of references to ConfigMaps";
        type = (types.listOf BootstrapInitdbPostInitSQLRefsConfigMapRefModule);
        default = [ ];
      };
      "secretRefs" = mkOption {
        description = "SecretRefs holds a list of references to Secrets";
        type = (types.listOf BootstrapInitdbPostInitSQLRefsSecretRefModule);
        default = [ ];
      };
    };
  };
  mkBootstrapInitdbPostInitSQLRefs =
    res:
    {
    }
    // optionalAttrs (res."configMapRefs" != [ ]) {
      "configMapRefs" = map mkBootstrapInitdbPostInitSQLRefsConfigMapRef res."configMapRefs";
    }
    // {
    }
    // optionalAttrs (res."secretRefs" != [ ]) {
      "secretRefs" = map mkBootstrapInitdbPostInitSQLRefsSecretRef res."secretRefs";
    }
    // {
    };
  BootstrapInitdbPostInitSQLRefsSecretRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkBootstrapInitdbPostInitSQLRefsSecretRef = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  BootstrapInitdbPostInitTemplateSQLRefsConfigMapRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkBootstrapInitdbPostInitTemplateSQLRefsConfigMapRef = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  BootstrapInitdbPostInitTemplateSQLRefsModule = types.submodule {
    options = {
      "configMapRefs" = mkOption {
        description = "ConfigMapRefs holds a list of references to ConfigMaps";
        type = (types.listOf BootstrapInitdbPostInitTemplateSQLRefsConfigMapRefModule);
        default = [ ];
      };
      "secretRefs" = mkOption {
        description = "SecretRefs holds a list of references to Secrets";
        type = (types.listOf BootstrapInitdbPostInitTemplateSQLRefsSecretRefModule);
        default = [ ];
      };
    };
  };
  mkBootstrapInitdbPostInitTemplateSQLRefs =
    res:
    {
    }
    // optionalAttrs (res."configMapRefs" != [ ]) {
      "configMapRefs" = map mkBootstrapInitdbPostInitTemplateSQLRefsConfigMapRef res."configMapRefs";
    }
    // {
    }
    // optionalAttrs (res."secretRefs" != [ ]) {
      "secretRefs" = map mkBootstrapInitdbPostInitTemplateSQLRefsSecretRef res."secretRefs";
    }
    // {
    };
  BootstrapInitdbPostInitTemplateSQLRefsSecretRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkBootstrapInitdbPostInitTemplateSQLRefsSecretRef = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  BootstrapInitdbSecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkBootstrapInitdbSecret = res: {
    inherit (res) "name";
  };
  BootstrapModule = types.submodule {
    options = {
      "initdb" = mkOption {
        description = "Bootstrap the cluster via initdb";
        type = (types.nullOr BootstrapInitdbModule);
        default = null;
      };
      "pg_basebackup" = mkOption {
        description = "Bootstrap the cluster taking a physical backup of another compatible\nPostgreSQL instance";
        type = (types.nullOr BootstrapPg_basebackupModule);
        default = null;
      };
      "recovery" = mkOption {
        description = "Bootstrap the cluster from a backup";
        type = (types.nullOr BootstrapRecoveryModule);
        default = null;
      };
    };
  };
  mkBootstrap =
    res:
    {
    }
    // optionalAttrs (res."initdb" != null) { "initdb" = mkBootstrapInitdb res."initdb"; }
    // {
    }
    // optionalAttrs (res."pg_basebackup" != null) {
      "pg_basebackup" = mkBootstrapPg_basebackup res."pg_basebackup";
    }
    // {
    }
    // optionalAttrs (res."recovery" != null) { "recovery" = mkBootstrapRecovery res."recovery"; }
    // {
    };
  BootstrapPg_basebackupModule = types.submodule {
    options = {
      "database" = mkOption {
        description = "Name of the database used by the application. Default: `app`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "owner" = mkOption {
        description = "Name of the owner of the database in the instance to be used\nby applications. Defaults to the value of the `database` key.";
        type = (types.nullOr types.str);
        default = null;
      };
      "secret" = mkOption {
        description = "Name of the secret containing the initial credentials for the\nowner of the user database. If empty a new secret will be\ncreated from scratch";
        type = (types.nullOr BootstrapPg_basebackupSecretModule);
        default = null;
      };
      "source" = mkOption {
        description = "The name of the server of which we need to take a physical backup";
        type = types.str;
      };
    };
  };
  mkBootstrapPg_basebackup =
    res:
    {
    }
    // optionalAttrs (res."database" != null) { inherit (res) "database"; }
    // {
    }
    // optionalAttrs (res."owner" != null) { inherit (res) "owner"; }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkBootstrapPg_basebackupSecret res."secret"; }
    // {
      inherit (res) "source";
    };
  BootstrapPg_basebackupSecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkBootstrapPg_basebackupSecret = res: {
    inherit (res) "name";
  };
  BootstrapRecoveryBackupEndpointCAModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkBootstrapRecoveryBackupEndpointCA = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  BootstrapRecoveryBackupModule = types.submodule {
    options = {
      "endpointCA" = mkOption {
        description = "EndpointCA store the CA bundle of the barman endpoint.\nUseful when using self-signed certificates to avoid\nerrors with certificate issuer and barman-cloud-wal-archive.";
        type = (types.nullOr BootstrapRecoveryBackupEndpointCAModule);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkBootstrapRecoveryBackup =
    res:
    {
    }
    // optionalAttrs (res."endpointCA" != null) {
      "endpointCA" = mkBootstrapRecoveryBackupEndpointCA res."endpointCA";
    }
    // {
      inherit (res) "name";
    };
  BootstrapRecoveryModule = types.submodule {
    options = {
      "backup" = mkOption {
        description = "The backup object containing the physical base backup from which to\ninitiate the recovery procedure.\nMutually exclusive with `source` and `volumeSnapshots`.";
        type = (types.nullOr BootstrapRecoveryBackupModule);
        default = null;
      };
      "database" = mkOption {
        description = "Name of the database used by the application. Default: `app`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "owner" = mkOption {
        description = "Name of the owner of the database in the instance to be used\nby applications. Defaults to the value of the `database` key.";
        type = (types.nullOr types.str);
        default = null;
      };
      "recoveryTarget" = mkOption {
        description = "By default, the recovery process applies all the available\nWAL files in the archive (full recovery). However, you can also\nend the recovery as soon as a consistent state is reached or\nrecover to a point-in-time (PITR) by specifying a `RecoveryTarget` object,\nas expected by PostgreSQL (i.e., timestamp, transaction Id, LSN, ...).\nMore info: https://www.postgresql.org/docs/current/runtime-config-wal.html#RUNTIME-CONFIG-WAL-RECOVERY-TARGET";
        type = (types.nullOr BootstrapRecoveryRecoveryTargetModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Name of the secret containing the initial credentials for the\nowner of the user database. If empty a new secret will be\ncreated from scratch";
        type = (types.nullOr BootstrapRecoverySecretModule);
        default = null;
      };
      "source" = mkOption {
        description = "The external cluster whose backup we will restore. This is also\nused as the name of the folder under which the backup is stored,\nso it must be set to the name of the source cluster\nMutually exclusive with `backup`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeSnapshots" = mkOption {
        description = "The static PVC data source(s) from which to initiate the\nrecovery procedure. Currently supporting `VolumeSnapshot`\nand `PersistentVolumeClaim` resources that map an existing\nPVC group, compatible with CloudNativePG, and taken with\na cold backup copy on a fenced Postgres instance (limitation\nwhich will be removed in the future when online backup\nwill be implemented).\nMutually exclusive with `backup`.";
        type = (types.nullOr BootstrapRecoveryVolumeSnapshotsModule);
        default = null;
      };
    };
  };
  mkBootstrapRecovery =
    res:
    {
    }
    // optionalAttrs (res."backup" != null) { "backup" = mkBootstrapRecoveryBackup res."backup"; }
    // {
    }
    // optionalAttrs (res."database" != null) { inherit (res) "database"; }
    // {
    }
    // optionalAttrs (res."owner" != null) { inherit (res) "owner"; }
    // {
    }
    // optionalAttrs (res."recoveryTarget" != null) {
      "recoveryTarget" = mkBootstrapRecoveryRecoveryTarget res."recoveryTarget";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkBootstrapRecoverySecret res."secret"; }
    // {
    }
    // optionalAttrs (res."source" != null) { inherit (res) "source"; }
    // {
    }
    // optionalAttrs (res."volumeSnapshots" != null) {
      "volumeSnapshots" = mkBootstrapRecoveryVolumeSnapshots res."volumeSnapshots";
    }
    // {
    };
  BootstrapRecoveryRecoveryTargetModule = types.submodule {
    options = {
      "backupID" = mkOption {
        description = "The ID of the backup from which to start the recovery process.\nIf empty (default) the operator will automatically detect the backup\nbased on targetTime or targetLSN if specified. Otherwise use the\nlatest available backup in chronological order.";
        type = (types.nullOr types.str);
        default = null;
      };
      "exclusive" = mkOption {
        description = "Set the target to be exclusive. If omitted, defaults to false, so that\nin Postgres, `recovery_target_inclusive` will be true";
        type = types.bool;
        default = false;
      };
      "targetImmediate" = mkOption {
        description = "End recovery as soon as a consistent state is reached";
        type = types.bool;
        default = false;
      };
      "targetLSN" = mkOption {
        description = "The target LSN (Log Sequence Number)";
        type = (types.nullOr types.str);
        default = null;
      };
      "targetName" = mkOption {
        description = "The target name (to be previously created\nwith `pg_create_restore_point`)";
        type = (types.nullOr types.str);
        default = null;
      };
      "targetTLI" = mkOption {
        description = "The target timeline (\"latest\" or a positive integer)";
        type = (types.nullOr types.str);
        default = null;
      };
      "targetTime" = mkOption {
        description = "The target time as a timestamp in the RFC3339 standard";
        type = (types.nullOr types.str);
        default = null;
      };
      "targetXID" = mkOption {
        description = "The target transaction ID";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkBootstrapRecoveryRecoveryTarget =
    res:
    {
    }
    // optionalAttrs (res."backupID" != null) { inherit (res) "backupID"; }
    // {
    }
    // optionalAttrs res."exclusive" { inherit (res) "exclusive"; }
    // {
    }
    // optionalAttrs res."targetImmediate" { inherit (res) "targetImmediate"; }
    // {
    }
    // optionalAttrs (res."targetLSN" != null) { inherit (res) "targetLSN"; }
    // {
    }
    // optionalAttrs (res."targetName" != null) { inherit (res) "targetName"; }
    // {
    }
    // optionalAttrs (res."targetTLI" != null) { inherit (res) "targetTLI"; }
    // {
    }
    // optionalAttrs (res."targetTime" != null) { inherit (res) "targetTime"; }
    // {
    }
    // optionalAttrs (res."targetXID" != null) { inherit (res) "targetXID"; }
    // {
    };
  BootstrapRecoverySecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkBootstrapRecoverySecret = res: {
    inherit (res) "name";
  };
  BootstrapRecoveryVolumeSnapshotsModule = types.submodule {
    options = {
      "storage" = mkOption {
        description = "Configuration of the storage of the instances";
        type = BootstrapRecoveryVolumeSnapshotsStorageModule;
      };
      "tablespaceStorage" = mkOption {
        description = "Configuration of the storage for PostgreSQL tablespaces";
        type = (types.attrsOf (types.attrsOf types.anything));
        default = { };
      };
      "walStorage" = mkOption {
        description = "Configuration of the storage for PostgreSQL WAL (Write-Ahead Log)";
        type = (types.nullOr BootstrapRecoveryVolumeSnapshotsWalStorageModule);
        default = null;
      };
    };
  };
  mkBootstrapRecoveryVolumeSnapshots =
    res:
    {
      "storage" = mkBootstrapRecoveryVolumeSnapshotsStorage res."storage";
    }
    // optionalAttrs (res."tablespaceStorage" != { }) { inherit (res) "tablespaceStorage"; }
    // {
    }
    // optionalAttrs (res."walStorage" != null) {
      "walStorage" = mkBootstrapRecoveryVolumeSnapshotsWalStorage res."walStorage";
    }
    // {
    };
  BootstrapRecoveryVolumeSnapshotsStorageModule = types.submodule {
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
  mkBootstrapRecoveryVolumeSnapshotsStorage =
    res:
    {
    }
    // optionalAttrs (res."apiGroup" != null) { inherit (res) "apiGroup"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    };
  BootstrapRecoveryVolumeSnapshotsWalStorageModule = types.submodule {
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
  mkBootstrapRecoveryVolumeSnapshotsWalStorage =
    res:
    {
    }
    // optionalAttrs (res."apiGroup" != null) { inherit (res) "apiGroup"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    };
  CertificatesModule = types.submodule {
    options = {
      "clientCASecret" = mkOption {
        description = "The secret containing the Client CA certificate. If not defined, a new secret will be created\nwith a self-signed CA and will be used to generate all the client certificates.<br />\n<br />\nContains:<br />\n<br />\n- `ca.crt`: CA that should be used to validate the client certificates,\nused as `ssl_ca_file` of all the instances.<br />\n- `ca.key`: key used to generate client certificates, if ReplicationTLSSecret is provided,\nthis can be omitted.<br />";
        type = (types.nullOr types.str);
        default = null;
      };
      "replicationTLSSecret" = mkOption {
        description = "The secret of type kubernetes.io/tls containing the client certificate to authenticate as\nthe `streaming_replica` user.\nIf not defined, ClientCASecret must provide also `ca.key`, and a new secret will be\ncreated using the provided CA.";
        type = (types.nullOr types.str);
        default = null;
      };
      "serverAltDNSNames" = mkOption {
        description = "The list of the server alternative DNS names to be added to the generated server TLS certificates, when required.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "serverCASecret" = mkOption {
        description = "The secret containing the Server CA certificate. If not defined, a new secret will be created\nwith a self-signed CA and will be used to generate the TLS certificate ServerTLSSecret.<br />\n<br />\nContains:<br />\n<br />\n- `ca.crt`: CA that should be used to validate the server certificate,\nused as `sslrootcert` in client connection strings.<br />\n- `ca.key`: key used to generate Server SSL certs, if ServerTLSSecret is provided,\nthis can be omitted.<br />";
        type = (types.nullOr types.str);
        default = null;
      };
      "serverTLSSecret" = mkOption {
        description = "The secret of type kubernetes.io/tls containing the server TLS certificate and key that will be set as\n`ssl_cert_file` and `ssl_key_file` so that clients can connect to postgres securely.\nIf not defined, ServerCASecret must provide also `ca.key` and a new secret will be\ncreated using the provided CA.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkCertificates =
    res:
    {
    }
    // optionalAttrs (res."clientCASecret" != null) { inherit (res) "clientCASecret"; }
    // {
    }
    // optionalAttrs (res."replicationTLSSecret" != null) { inherit (res) "replicationTLSSecret"; }
    // {
    }
    // optionalAttrs (res."serverAltDNSNames" != [ ]) { inherit (res) "serverAltDNSNames"; }
    // {
    }
    // optionalAttrs (res."serverCASecret" != null) { inherit (res) "serverCASecret"; }
    // {
    }
    // optionalAttrs (res."serverTLSSecret" != null) { inherit (res) "serverTLSSecret"; }
    // {
    };
  EnvFromConfigMapRefModule = types.submodule {
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
  mkEnvFromConfigMapRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EnvFromModule = types.submodule {
    options = {
      "configMapRef" = mkOption {
        description = "The ConfigMap to select from";
        type = (types.nullOr EnvFromConfigMapRefModule);
        default = null;
      };
      "prefix" = mkOption {
        description = "Optional text to prepend to the name of each environment variable. Must be a C_IDENTIFIER.";
        type = (types.nullOr types.str);
        default = null;
      };
      "secretRef" = mkOption {
        description = "The Secret to select from";
        type = (types.nullOr EnvFromSecretRefModule);
        default = null;
      };
    };
  };
  mkEnvFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapRef" != null) {
      "configMapRef" = mkEnvFromConfigMapRef res."configMapRef";
    }
    // {
    }
    // optionalAttrs (res."prefix" != null) { inherit (res) "prefix"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) { "secretRef" = mkEnvFromSecretRef res."secretRef"; }
    // {
    };
  EnvFromSecretRefModule = types.submodule {
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
  mkEnvFromSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EnvModule = types.submodule {
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
        type = (types.nullOr EnvValueFromModule);
        default = null;
      };
    };
  };
  mkEnv =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    }
    // optionalAttrs (res."valueFrom" != null) { "valueFrom" = mkEnvValueFrom res."valueFrom"; }
    // {
    };
  EnvValueFromConfigMapKeyRefModule = types.submodule {
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
  mkEnvValueFromConfigMapKeyRef =
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
  EnvValueFromFieldRefModule = types.submodule {
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
  mkEnvValueFromFieldRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "fieldPath";
    };
  EnvValueFromModule = types.submodule {
    options = {
      "configMapKeyRef" = mkOption {
        description = "Selects a key of a ConfigMap.";
        type = (types.nullOr EnvValueFromConfigMapKeyRefModule);
        default = null;
      };
      "fieldRef" = mkOption {
        description = "Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`,\nspec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs.";
        type = (types.nullOr EnvValueFromFieldRefModule);
        default = null;
      };
      "resourceFieldRef" = mkOption {
        description = "Selects a resource of the container: only resources limits and requests\n(limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported.";
        type = (types.nullOr EnvValueFromResourceFieldRefModule);
        default = null;
      };
      "secretKeyRef" = mkOption {
        description = "Selects a key of a secret in the pod's namespace";
        type = (types.nullOr EnvValueFromSecretKeyRefModule);
        default = null;
      };
    };
  };
  mkEnvValueFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapKeyRef" != null) {
      "configMapKeyRef" = mkEnvValueFromConfigMapKeyRef res."configMapKeyRef";
    }
    // {
    }
    // optionalAttrs (res."fieldRef" != null) { "fieldRef" = mkEnvValueFromFieldRef res."fieldRef"; }
    // {
    }
    // optionalAttrs (res."resourceFieldRef" != null) {
      "resourceFieldRef" = mkEnvValueFromResourceFieldRef res."resourceFieldRef";
    }
    // {
    }
    // optionalAttrs (res."secretKeyRef" != null) {
      "secretKeyRef" = mkEnvValueFromSecretKeyRef res."secretKeyRef";
    }
    // {
    };
  EnvValueFromResourceFieldRefModule = types.submodule {
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
  mkEnvValueFromResourceFieldRef =
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
  EnvValueFromSecretKeyRefModule = types.submodule {
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
  mkEnvValueFromSecretKeyRef =
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
  EphemeralVolumeSourceModule = types.submodule {
    options = {
      "volumeClaimTemplate" = mkOption {
        description = "Will be used to create a stand-alone PVC to provision the volume.\nThe pod in which this EphemeralVolumeSource is embedded will be the\nowner of the PVC, i.e. the PVC will be deleted together with the\npod.  The name of the PVC will be `<pod name>-<volume name>` where\n`<volume name>` is the name from the `PodSpec.Volumes` array\nentry. Pod validation will reject the pod if the concatenated name\nis not valid for a PVC (for example, too long).\n\nAn existing PVC with that name that is not owned by the pod\nwill *not* be used for the pod to avoid using an unrelated\nvolume by mistake. Starting the pod is then blocked until\nthe unrelated PVC is removed. If such a pre-created PVC is\nmeant to be used by the pod, the PVC has to updated with an\nowner reference to the pod once the pod exists. Normally\nthis should not be necessary, but it may be useful when\nmanually reconstructing a broken cluster.\n\nThis field is read-only and no changes will be made by Kubernetes\nto the PVC after it has been created.\n\nRequired, must not be nil.";
        type = (types.nullOr EphemeralVolumeSourceVolumeClaimTemplateModule);
        default = null;
      };
    };
  };
  mkEphemeralVolumeSource =
    res:
    {
    }
    // optionalAttrs (res."volumeClaimTemplate" != null) {
      "volumeClaimTemplate" = mkEphemeralVolumeSourceVolumeClaimTemplate res."volumeClaimTemplate";
    }
    // {
    };
  EphemeralVolumeSourceVolumeClaimTemplateModule = types.submodule {
    options = {
      "metadata" = mkOption {
        description = "May contain labels and annotations that will be copied into the PVC\nwhen creating it. No other fields are allowed and will be rejected during\nvalidation.";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "spec" = mkOption {
        description = "The specification for the PersistentVolumeClaim. The entire content is\ncopied unchanged into the PVC that gets created from this\ntemplate. The same fields as in a PersistentVolumeClaim\nare also valid here.";
        type = EphemeralVolumeSourceVolumeClaimTemplateSpecModule;
      };
    };
  };
  mkEphemeralVolumeSourceVolumeClaimTemplate =
    res:
    {
    }
    // optionalAttrs (res."metadata" != { }) { inherit (res) "metadata"; }
    // {
      "spec" = mkEphemeralVolumeSourceVolumeClaimTemplateSpec res."spec";
    };
  EphemeralVolumeSourceVolumeClaimTemplateSpecDataSourceModule = types.submodule {
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
  mkEphemeralVolumeSourceVolumeClaimTemplateSpecDataSource =
    res:
    {
    }
    // optionalAttrs (res."apiGroup" != null) { inherit (res) "apiGroup"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    };
  EphemeralVolumeSourceVolumeClaimTemplateSpecDataSourceRefModule = types.submodule {
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
  mkEphemeralVolumeSourceVolumeClaimTemplateSpecDataSourceRef =
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
  EphemeralVolumeSourceVolumeClaimTemplateSpecModule = types.submodule {
    options = {
      "accessModes" = mkOption {
        description = "accessModes contains the desired access modes the volume should have.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1";
        type = (types.listOf types.str);
        default = [ ];
      };
      "dataSource" = mkOption {
        description = "dataSource field can be used to specify either:\n* An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot)\n* An existing PVC (PersistentVolumeClaim)\nIf the provisioner or an external controller can support the specified data source,\nit will create a new volume based on the contents of the specified data source.\nWhen the AnyVolumeDataSource feature gate is enabled, dataSource contents will be copied to dataSourceRef,\nand dataSourceRef contents will be copied to dataSource when dataSourceRef.namespace is not specified.\nIf the namespace is specified, then dataSourceRef will not be copied to dataSource.";
        type = (types.nullOr EphemeralVolumeSourceVolumeClaimTemplateSpecDataSourceModule);
        default = null;
      };
      "dataSourceRef" = mkOption {
        description = "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty\nvolume is desired. This may be any object from a non-empty API group (non\ncore object) or a PersistentVolumeClaim object.\nWhen this field is specified, volume binding will only succeed if the type of\nthe specified object matches some installed volume populator or dynamic\nprovisioner.\nThis field will replace the functionality of the dataSource field and as such\nif both fields are non-empty, they must have the same value. For backwards\ncompatibility, when namespace isn't specified in dataSourceRef,\nboth fields (dataSource and dataSourceRef) will be set to the same\nvalue automatically if one of them is empty and the other is non-empty.\nWhen namespace is specified in dataSourceRef,\ndataSource isn't set to the same value and must be empty.\nThere are three important differences between dataSource and dataSourceRef:\n* While dataSource only allows two specific types of objects, dataSourceRef\n  allows any non-core object, as well as PersistentVolumeClaim objects.\n* While dataSource ignores disallowed values (dropping them), dataSourceRef\n  preserves all values, and generates an error if a disallowed value is\n  specified.\n* While dataSource only allows local objects, dataSourceRef allows objects\n  in any namespaces.\n(Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled.\n(Alpha) Using the namespace field of dataSourceRef requires the CrossNamespaceVolumeDataSource feature gate to be enabled.";
        type = (types.nullOr EphemeralVolumeSourceVolumeClaimTemplateSpecDataSourceRefModule);
        default = null;
      };
      "resources" = mkOption {
        description = "resources represents the minimum resources the volume should have.\nIf RecoverVolumeExpansionFailure feature is enabled users are allowed to specify resource requirements\nthat are lower than previous value but must still be higher than capacity recorded in the\nstatus field of the claim.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources";
        type = (types.nullOr EphemeralVolumeSourceVolumeClaimTemplateSpecResourcesModule);
        default = null;
      };
      "selector" = mkOption {
        description = "selector is a label query over volumes to consider for binding.";
        type = (types.nullOr EphemeralVolumeSourceVolumeClaimTemplateSpecSelectorModule);
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
  mkEphemeralVolumeSourceVolumeClaimTemplateSpec =
    res:
    {
    }
    // optionalAttrs (res."accessModes" != [ ]) { inherit (res) "accessModes"; }
    // {
    }
    // optionalAttrs (res."dataSource" != null) {
      "dataSource" = mkEphemeralVolumeSourceVolumeClaimTemplateSpecDataSource res."dataSource";
    }
    // {
    }
    // optionalAttrs (res."dataSourceRef" != null) {
      "dataSourceRef" = mkEphemeralVolumeSourceVolumeClaimTemplateSpecDataSourceRef res."dataSourceRef";
    }
    // {
    }
    // optionalAttrs (res."resources" != null) {
      "resources" = mkEphemeralVolumeSourceVolumeClaimTemplateSpecResources res."resources";
    }
    // {
    }
    // optionalAttrs (res."selector" != null) {
      "selector" = mkEphemeralVolumeSourceVolumeClaimTemplateSpecSelector res."selector";
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
  EphemeralVolumeSourceVolumeClaimTemplateSpecResourcesModule = types.submodule {
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
  mkEphemeralVolumeSourceVolumeClaimTemplateSpecResources =
    res:
    {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  EphemeralVolumeSourceVolumeClaimTemplateSpecSelectorMatchExpressionModule = types.submodule {
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
  mkEphemeralVolumeSourceVolumeClaimTemplateSpecSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  EphemeralVolumeSourceVolumeClaimTemplateSpecSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf EphemeralVolumeSourceVolumeClaimTemplateSpecSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkEphemeralVolumeSourceVolumeClaimTemplateSpecSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkEphemeralVolumeSourceVolumeClaimTemplateSpecSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  EphemeralVolumesSizeLimitModule = types.submodule {
    options = {
      "shm" = mkOption {
        description = "Shm is the size limit of the shared memory volume";
        type = types.anything;
        default = { };
      };
      "temporaryData" = mkOption {
        description = "TemporaryData is the size limit of the temporary data volume";
        type = types.anything;
        default = { };
      };
    };
  };
  mkEphemeralVolumesSizeLimit =
    res:
    {
    }
    // optionalAttrs (res."shm" != null) { inherit (res) "shm"; }
    // {
    }
    // optionalAttrs (res."temporaryData" != null) { inherit (res) "temporaryData"; }
    // {
    };
  ExternalClusterBarmanObjectStoreAzureCredentialsConnectionStringModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkExternalClusterBarmanObjectStoreAzureCredentialsConnectionString = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  ExternalClusterBarmanObjectStoreAzureCredentialsModule = types.submodule {
    options = {
      "connectionString" = mkOption {
        description = "The connection string to be used";
        type = (types.nullOr ExternalClusterBarmanObjectStoreAzureCredentialsConnectionStringModule);
        default = null;
      };
      "inheritFromAzureAD" = mkOption {
        description = "Use the Azure AD based authentication without providing explicitly the keys.";
        type = types.bool;
        default = false;
      };
      "storageAccount" = mkOption {
        description = "The storage account where to upload data";
        type = (types.nullOr ExternalClusterBarmanObjectStoreAzureCredentialsStorageAccountModule);
        default = null;
      };
      "storageKey" = mkOption {
        description = "The storage account key to be used in conjunction\nwith the storage account name";
        type = (types.nullOr ExternalClusterBarmanObjectStoreAzureCredentialsStorageKeyModule);
        default = null;
      };
      "storageSasToken" = mkOption {
        description = "A shared-access-signature to be used in conjunction with\nthe storage account name";
        type = (types.nullOr ExternalClusterBarmanObjectStoreAzureCredentialsStorageSasTokenModule);
        default = null;
      };
    };
  };
  mkExternalClusterBarmanObjectStoreAzureCredentials =
    res:
    {
    }
    // optionalAttrs (res."connectionString" != null) {
      "connectionString" =
        mkExternalClusterBarmanObjectStoreAzureCredentialsConnectionString
          res."connectionString";
    }
    // {
    }
    // optionalAttrs res."inheritFromAzureAD" { inherit (res) "inheritFromAzureAD"; }
    // {
    }
    // optionalAttrs (res."storageAccount" != null) {
      "storageAccount" =
        mkExternalClusterBarmanObjectStoreAzureCredentialsStorageAccount
          res."storageAccount";
    }
    // {
    }
    // optionalAttrs (res."storageKey" != null) {
      "storageKey" = mkExternalClusterBarmanObjectStoreAzureCredentialsStorageKey res."storageKey";
    }
    // {
    }
    // optionalAttrs (res."storageSasToken" != null) {
      "storageSasToken" =
        mkExternalClusterBarmanObjectStoreAzureCredentialsStorageSasToken
          res."storageSasToken";
    }
    // {
    };
  ExternalClusterBarmanObjectStoreAzureCredentialsStorageAccountModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkExternalClusterBarmanObjectStoreAzureCredentialsStorageAccount = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  ExternalClusterBarmanObjectStoreAzureCredentialsStorageKeyModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkExternalClusterBarmanObjectStoreAzureCredentialsStorageKey = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  ExternalClusterBarmanObjectStoreAzureCredentialsStorageSasTokenModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkExternalClusterBarmanObjectStoreAzureCredentialsStorageSasToken = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  ExternalClusterBarmanObjectStoreDataModule = types.submodule {
    options = {
      "additionalCommandArgs" = mkOption {
        description = "AdditionalCommandArgs represents additional arguments that can be appended\nto the 'barman-cloud-backup' command-line invocation. These arguments\nprovide flexibility to customize the backup process further according to\nspecific requirements or configurations.\n\nExample:\nIn a scenario where specialized backup options are required, such as setting\na specific timeout or defining custom behavior, users can use this field\nto specify additional command arguments.\n\nNote:\nIt's essential to ensure that the provided arguments are valid and supported\nby the 'barman-cloud-backup' command, to avoid potential errors or unintended\nbehavior during execution.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "compression" = mkOption {
        description = "Compress a backup file (a tar file per tablespace) while streaming it\nto the object store. Available options are empty string (no\ncompression, default), `gzip`, `bzip2`, and `snappy`.";
        type = (
          types.nullOr (
            types.enum [
              "bzip2"
              "gzip"
              "snappy"
            ]
          )
        );
        default = null;
      };
      "encryption" = mkOption {
        description = "Whenever to force the encryption of files (if the bucket is\nnot already configured for that).\nAllowed options are empty string (use the bucket policy, default),\n`AES256` and `aws:kms`";
        type = (
          types.nullOr (
            types.enum [
              "AES256"
              "aws:kms"
            ]
          )
        );
        default = null;
      };
      "immediateCheckpoint" = mkOption {
        description = "Control whether the I/O workload for the backup initial checkpoint will\nbe limited, according to the `checkpoint_completion_target` setting on\nthe PostgreSQL server. If set to true, an immediate checkpoint will be\nused, meaning PostgreSQL will complete the checkpoint as soon as\npossible. `false` by default.";
        type = types.bool;
        default = false;
      };
      "jobs" = mkOption {
        description = "The number of parallel jobs to be used to upload the backup, defaults\nto 2";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkExternalClusterBarmanObjectStoreData =
    res:
    {
    }
    // optionalAttrs (res."additionalCommandArgs" != [ ]) { inherit (res) "additionalCommandArgs"; }
    // {
    }
    // optionalAttrs (res."compression" != null) { inherit (res) "compression"; }
    // {
    }
    // optionalAttrs (res."encryption" != null) { inherit (res) "encryption"; }
    // {
    }
    // optionalAttrs res."immediateCheckpoint" { inherit (res) "immediateCheckpoint"; }
    // {
    }
    // optionalAttrs (res."jobs" != null) { inherit (res) "jobs"; }
    // {
    };
  ExternalClusterBarmanObjectStoreEndpointCAModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkExternalClusterBarmanObjectStoreEndpointCA = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  ExternalClusterBarmanObjectStoreGoogleCredentialsApplicationCredentialsModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkExternalClusterBarmanObjectStoreGoogleCredentialsApplicationCredentials = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  ExternalClusterBarmanObjectStoreGoogleCredentialsModule = types.submodule {
    options = {
      "applicationCredentials" = mkOption {
        description = "The secret containing the Google Cloud Storage JSON file with the credentials";
        type = (types.nullOr ExternalClusterBarmanObjectStoreGoogleCredentialsApplicationCredentialsModule);
        default = null;
      };
      "gkeEnvironment" = mkOption {
        description = "If set to true, will presume that it's running inside a GKE environment,\ndefault to false.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkExternalClusterBarmanObjectStoreGoogleCredentials =
    res:
    {
    }
    // optionalAttrs (res."applicationCredentials" != null) {
      "applicationCredentials" =
        mkExternalClusterBarmanObjectStoreGoogleCredentialsApplicationCredentials
          res."applicationCredentials";
    }
    // {
    }
    // optionalAttrs res."gkeEnvironment" { inherit (res) "gkeEnvironment"; }
    // {
    };
  ExternalClusterBarmanObjectStoreModule = types.submodule {
    options = {
      "azureCredentials" = mkOption {
        description = "The credentials to use to upload data to Azure Blob Storage";
        type = (types.nullOr ExternalClusterBarmanObjectStoreAzureCredentialsModule);
        default = null;
      };
      "data" = mkOption {
        description = "The configuration to be used to backup the data files\nWhen not defined, base backups files will be stored uncompressed and may\nbe unencrypted in the object store, according to the bucket default\npolicy.";
        type = (types.nullOr ExternalClusterBarmanObjectStoreDataModule);
        default = null;
      };
      "destinationPath" = mkOption {
        description = "The path where to store the backup (i.e. s3://bucket/path/to/folder)\nthis path, with different destination folders, will be used for WALs\nand for data";
        type = types.str;
      };
      "endpointCA" = mkOption {
        description = "EndpointCA store the CA bundle of the barman endpoint.\nUseful when using self-signed certificates to avoid\nerrors with certificate issuer and barman-cloud-wal-archive";
        type = (types.nullOr ExternalClusterBarmanObjectStoreEndpointCAModule);
        default = null;
      };
      "endpointURL" = mkOption {
        description = "Endpoint to be used to upload data to the cloud,\noverriding the automatic endpoint discovery";
        type = (types.nullOr types.str);
        default = null;
      };
      "googleCredentials" = mkOption {
        description = "The credentials to use to upload data to Google Cloud Storage";
        type = (types.nullOr ExternalClusterBarmanObjectStoreGoogleCredentialsModule);
        default = null;
      };
      "historyTags" = mkOption {
        description = "HistoryTags is a list of key value pairs that will be passed to the\nBarman --history-tags option.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "s3Credentials" = mkOption {
        description = "The credentials to use to upload data to S3";
        type = (types.nullOr ExternalClusterBarmanObjectStoreS3CredentialsModule);
        default = null;
      };
      "serverName" = mkOption {
        description = "The server name on S3, the cluster name is used if this\nparameter is omitted";
        type = (types.nullOr types.str);
        default = null;
      };
      "tags" = mkOption {
        description = "Tags is a list of key value pairs that will be passed to the\nBarman --tags option.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "wal" = mkOption {
        description = "The configuration for the backup of the WAL stream.\nWhen not defined, WAL files will be stored uncompressed and may be\nunencrypted in the object store, according to the bucket default policy.";
        type = (types.nullOr ExternalClusterBarmanObjectStoreWalModule);
        default = null;
      };
    };
  };
  mkExternalClusterBarmanObjectStore =
    res:
    {
    }
    // optionalAttrs (res."azureCredentials" != null) {
      "azureCredentials" = mkExternalClusterBarmanObjectStoreAzureCredentials res."azureCredentials";
    }
    // {
    }
    // optionalAttrs (res."data" != null) {
      "data" = mkExternalClusterBarmanObjectStoreData res."data";
    }
    // {
      inherit (res) "destinationPath";
    }
    // optionalAttrs (res."endpointCA" != null) {
      "endpointCA" = mkExternalClusterBarmanObjectStoreEndpointCA res."endpointCA";
    }
    // {
    }
    // optionalAttrs (res."endpointURL" != null) { inherit (res) "endpointURL"; }
    // {
    }
    // optionalAttrs (res."googleCredentials" != null) {
      "googleCredentials" = mkExternalClusterBarmanObjectStoreGoogleCredentials res."googleCredentials";
    }
    // {
    }
    // optionalAttrs (res."historyTags" != { }) { inherit (res) "historyTags"; }
    // {
    }
    // optionalAttrs (res."s3Credentials" != null) {
      "s3Credentials" = mkExternalClusterBarmanObjectStoreS3Credentials res."s3Credentials";
    }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    }
    // optionalAttrs (res."tags" != { }) { inherit (res) "tags"; }
    // {
    }
    // optionalAttrs (res."wal" != null) { "wal" = mkExternalClusterBarmanObjectStoreWal res."wal"; }
    // {
    };
  ExternalClusterBarmanObjectStoreS3CredentialsAccessKeyIdModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkExternalClusterBarmanObjectStoreS3CredentialsAccessKeyId = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  ExternalClusterBarmanObjectStoreS3CredentialsModule = types.submodule {
    options = {
      "accessKeyId" = mkOption {
        description = "The reference to the access key id";
        type = (types.nullOr ExternalClusterBarmanObjectStoreS3CredentialsAccessKeyIdModule);
        default = null;
      };
      "inheritFromIAMRole" = mkOption {
        description = "Use the role based authentication without providing explicitly the keys.";
        type = types.bool;
        default = false;
      };
      "region" = mkOption {
        description = "The reference to the secret containing the region name";
        type = (types.nullOr ExternalClusterBarmanObjectStoreS3CredentialsRegionModule);
        default = null;
      };
      "secretAccessKey" = mkOption {
        description = "The reference to the secret access key";
        type = (types.nullOr ExternalClusterBarmanObjectStoreS3CredentialsSecretAccessKeyModule);
        default = null;
      };
      "sessionToken" = mkOption {
        description = "The references to the session key";
        type = (types.nullOr ExternalClusterBarmanObjectStoreS3CredentialsSessionTokenModule);
        default = null;
      };
    };
  };
  mkExternalClusterBarmanObjectStoreS3Credentials =
    res:
    {
    }
    // optionalAttrs (res."accessKeyId" != null) {
      "accessKeyId" = mkExternalClusterBarmanObjectStoreS3CredentialsAccessKeyId res."accessKeyId";
    }
    // {
    }
    // optionalAttrs res."inheritFromIAMRole" { inherit (res) "inheritFromIAMRole"; }
    // {
    }
    // optionalAttrs (res."region" != null) {
      "region" = mkExternalClusterBarmanObjectStoreS3CredentialsRegion res."region";
    }
    // {
    }
    // optionalAttrs (res."secretAccessKey" != null) {
      "secretAccessKey" =
        mkExternalClusterBarmanObjectStoreS3CredentialsSecretAccessKey
          res."secretAccessKey";
    }
    // {
    }
    // optionalAttrs (res."sessionToken" != null) {
      "sessionToken" = mkExternalClusterBarmanObjectStoreS3CredentialsSessionToken res."sessionToken";
    }
    // {
    };
  ExternalClusterBarmanObjectStoreS3CredentialsRegionModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkExternalClusterBarmanObjectStoreS3CredentialsRegion = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  ExternalClusterBarmanObjectStoreS3CredentialsSecretAccessKeyModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkExternalClusterBarmanObjectStoreS3CredentialsSecretAccessKey = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  ExternalClusterBarmanObjectStoreS3CredentialsSessionTokenModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkExternalClusterBarmanObjectStoreS3CredentialsSessionToken = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  ExternalClusterBarmanObjectStoreWalModule = types.submodule {
    options = {
      "archiveAdditionalCommandArgs" = mkOption {
        description = "Additional arguments that can be appended to the 'barman-cloud-wal-archive'\ncommand-line invocation. These arguments provide flexibility to customize\nthe WAL archive process further, according to specific requirements or configurations.\n\nExample:\nIn a scenario where specialized backup options are required, such as setting\na specific timeout or defining custom behavior, users can use this field\nto specify additional command arguments.\n\nNote:\nIt's essential to ensure that the provided arguments are valid and supported\nby the 'barman-cloud-wal-archive' command, to avoid potential errors or unintended\nbehavior during execution.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "compression" = mkOption {
        description = "Compress a WAL file before sending it to the object store. Available\noptions are empty string (no compression, default), `gzip`, `bzip2`,\n`lz4`, `snappy`, `xz`, and `zstd`.";
        type = (
          types.nullOr (
            types.enum [
              "bzip2"
              "gzip"
              "lz4"
              "snappy"
              "xz"
              "zstd"
            ]
          )
        );
        default = null;
      };
      "encryption" = mkOption {
        description = "Whenever to force the encryption of files (if the bucket is\nnot already configured for that).\nAllowed options are empty string (use the bucket policy, default),\n`AES256` and `aws:kms`";
        type = (
          types.nullOr (
            types.enum [
              "AES256"
              "aws:kms"
            ]
          )
        );
        default = null;
      };
      "maxParallel" = mkOption {
        description = "Number of WAL files to be either archived in parallel (when the\nPostgreSQL instance is archiving to a backup object store) or\nrestored in parallel (when a PostgreSQL standby is fetching WAL\nfiles from a recovery object store). If not specified, WAL files\nwill be processed one at a time. It accepts a positive integer as a\nvalue - with 1 being the minimum accepted value.";
        type = (types.nullOr types.int);
        default = null;
      };
      "restoreAdditionalCommandArgs" = mkOption {
        description = "Additional arguments that can be appended to the 'barman-cloud-wal-restore'\ncommand-line invocation. These arguments provide flexibility to customize\nthe WAL restore process further, according to specific requirements or configurations.\n\nExample:\nIn a scenario where specialized backup options are required, such as setting\na specific timeout or defining custom behavior, users can use this field\nto specify additional command arguments.\n\nNote:\nIt's essential to ensure that the provided arguments are valid and supported\nby the 'barman-cloud-wal-restore' command, to avoid potential errors or unintended\nbehavior during execution.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkExternalClusterBarmanObjectStoreWal =
    res:
    {
    }
    // optionalAttrs (res."archiveAdditionalCommandArgs" != [ ]) {
      inherit (res) "archiveAdditionalCommandArgs";
    }
    // {
    }
    // optionalAttrs (res."compression" != null) { inherit (res) "compression"; }
    // {
    }
    // optionalAttrs (res."encryption" != null) { inherit (res) "encryption"; }
    // {
    }
    // optionalAttrs (res."maxParallel" != null) { inherit (res) "maxParallel"; }
    // {
    }
    // optionalAttrs (res."restoreAdditionalCommandArgs" != [ ]) {
      inherit (res) "restoreAdditionalCommandArgs";
    }
    // {
    };
  ExternalClusterModule = types.submodule {
    options = {
      "barmanObjectStore" = mkOption {
        description = "The configuration for the barman-cloud tool suite";
        type = (types.nullOr ExternalClusterBarmanObjectStoreModule);
        default = null;
      };
      "connectionParameters" = mkOption {
        description = "The list of connection parameters, such as dbname, host, username, etc";
        type = (types.attrsOf types.str);
        default = { };
      };
      "name" = mkOption {
        description = "The server name, required";
        type = types.str;
      };
      "password" = mkOption {
        description = "The reference to the password to be used to connect to the server.\nIf a password is provided, CloudNativePG creates a PostgreSQL\npassfile at `/controller/external/NAME/pass` (where \"NAME\" is the\ncluster's name). This passfile is automatically referenced in the\nconnection string when establishing a connection to the remote\nPostgreSQL server from the current PostgreSQL `Cluster`. This ensures\nsecure and efficient password management for external clusters.";
        type = (types.nullOr ExternalClusterPasswordModule);
        default = null;
      };
      "plugin" = mkOption {
        description = "The configuration of the plugin that is taking care\nof WAL archiving and backups for this external cluster";
        type = (types.nullOr ExternalClusterPluginModule);
        default = null;
      };
      "sslCert" = mkOption {
        description = "The reference to an SSL certificate to be used to connect to this\ninstance";
        type = (types.nullOr ExternalClusterSslCertModule);
        default = null;
      };
      "sslKey" = mkOption {
        description = "The reference to an SSL private key to be used to connect to this\ninstance";
        type = (types.nullOr ExternalClusterSslKeyModule);
        default = null;
      };
      "sslRootCert" = mkOption {
        description = "The reference to an SSL CA public key to be used to connect to this\ninstance";
        type = (types.nullOr ExternalClusterSslRootCertModule);
        default = null;
      };
    };
  };
  mkExternalCluster =
    res:
    {
    }
    // optionalAttrs (res."barmanObjectStore" != null) {
      "barmanObjectStore" = mkExternalClusterBarmanObjectStore res."barmanObjectStore";
    }
    // {
    }
    // optionalAttrs (res."connectionParameters" != { }) { inherit (res) "connectionParameters"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."password" != null) { "password" = mkExternalClusterPassword res."password"; }
    // {
    }
    // optionalAttrs (res."plugin" != null) { "plugin" = mkExternalClusterPlugin res."plugin"; }
    // {
    }
    // optionalAttrs (res."sslCert" != null) { "sslCert" = mkExternalClusterSslCert res."sslCert"; }
    // {
    }
    // optionalAttrs (res."sslKey" != null) { "sslKey" = mkExternalClusterSslKey res."sslKey"; }
    // {
    }
    // optionalAttrs (res."sslRootCert" != null) {
      "sslRootCert" = mkExternalClusterSslRootCert res."sslRootCert";
    }
    // {
    };
  ExternalClusterPasswordModule = types.submodule {
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
  mkExternalClusterPassword =
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
  ExternalClusterPluginModule = types.submodule {
    options = {
      "enabled" = mkOption {
        description = "Enabled is true if this plugin will be used";
        type = types.bool;
        default = true;
      };
      "isWALArchiver" = mkOption {
        description = "Only one plugin can be declared as WALArchiver.\nCannot be active if \".spec.backup.barmanObjectStore\" configuration is present.";
        type = types.bool;
        default = false;
      };
      "name" = mkOption {
        description = "Name is the plugin name";
        type = types.str;
      };
      "parameters" = mkOption {
        description = "Parameters is the configuration of the plugin";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkExternalClusterPlugin =
    res:
    {
    }
    // optionalAttrs (res."enabled" != null) { inherit (res) "enabled"; }
    // {
    }
    // optionalAttrs res."isWALArchiver" { inherit (res) "isWALArchiver"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."parameters" != { }) { inherit (res) "parameters"; }
    // {
    };
  ExternalClusterSslCertModule = types.submodule {
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
  mkExternalClusterSslCert =
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
  ExternalClusterSslKeyModule = types.submodule {
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
  mkExternalClusterSslKey =
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
  ExternalClusterSslRootCertModule = types.submodule {
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
  mkExternalClusterSslRootCert =
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
  ImageCatalogRefModule = types.submodule {
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
      "major" = mkOption {
        description = "The major version of PostgreSQL we want to use from the ImageCatalog";
        type = types.int;
      };
      "name" = mkOption {
        description = "Name is the name of resource being referenced";
        type = types.str;
      };
    };
  };
  mkImageCatalogRef =
    res:
    {
    }
    // optionalAttrs (res."apiGroup" != null) { inherit (res) "apiGroup"; }
    // {
      inherit (res) "kind";
      inherit (res) "major";
      inherit (res) "name";
    };
  ImagePullSecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkImagePullSecret = res: {
    inherit (res) "name";
  };
  InheritedMetadataModule = types.submodule {
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
  mkInheritedMetadata =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    };
  ManagedModule = types.submodule {
    options = {
      "roles" = mkOption {
        description = "Database roles managed by the `Cluster`";
        type = (types.listOf ManagedRoleModule);
        default = [ ];
      };
      "services" = mkOption {
        description = "Services roles managed by the `Cluster`";
        type = (types.nullOr ManagedServicesModule);
        default = null;
      };
    };
  };
  mkManaged =
    res:
    {
    }
    // optionalAttrs (res."roles" != [ ]) { "roles" = map mkManagedRole res."roles"; }
    // {
    }
    // optionalAttrs (res."services" != null) { "services" = mkManagedServices res."services"; }
    // {
    };
  ManagedRoleModule = types.submodule {
    options = {
      "bypassrls" = mkOption {
        description = "Whether a role bypasses every row-level security (RLS) policy.\nDefault is `false`.";
        type = types.bool;
        default = false;
      };
      "comment" = mkOption {
        description = "Description of the role";
        type = (types.nullOr types.str);
        default = null;
      };
      "connectionLimit" = mkOption {
        description = "If the role can log in, this specifies how many concurrent\nconnections the role can make. `-1` (the default) means no limit.";
        type = (types.nullOr types.int);
        default = -1;
      };
      "createdb" = mkOption {
        description = "When set to `true`, the role being defined will be allowed to create\nnew databases. Specifying `false` (default) will deny a role the\nability to create databases.";
        type = types.bool;
        default = false;
      };
      "createrole" = mkOption {
        description = "Whether the role will be permitted to create, alter, drop, comment\non, change the security label for, and grant or revoke membership in\nother roles. Default is `false`.";
        type = types.bool;
        default = false;
      };
      "disablePassword" = mkOption {
        description = "DisablePassword indicates that a role's password should be set to NULL in Postgres";
        type = types.bool;
        default = false;
      };
      "ensure" = mkOption {
        description = "Ensure the role is `present` or `absent` - defaults to \"present\"";
        type = (
          types.nullOr (
            types.enum [
              "present"
              "absent"
            ]
          )
        );
        default = "present";
      };
      "inRoles" = mkOption {
        description = "List of one or more existing roles to which this role will be\nimmediately added as a new member. Default empty.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "inherit" = mkOption {
        description = "Whether a role \"inherits\" the privileges of roles it is a member of.\nDefaults is `true`.";
        type = types.bool;
        default = true;
      };
      "login" = mkOption {
        description = "Whether the role is allowed to log in. A role having the `login`\nattribute can be thought of as a user. Roles without this attribute\nare useful for managing database privileges, but are not users in\nthe usual sense of the word. Default is `false`.";
        type = types.bool;
        default = false;
      };
      "name" = mkOption {
        description = "Name of the role";
        type = types.str;
      };
      "passwordSecret" = mkOption {
        description = "Secret containing the password of the role (if present)\nIf null, the password will be ignored unless DisablePassword is set";
        type = (types.nullOr ManagedRolePasswordSecretModule);
        default = null;
      };
      "replication" = mkOption {
        description = "Whether a role is a replication role. A role must have this\nattribute (or be a superuser) in order to be able to connect to the\nserver in replication mode (physical or logical replication) and in\norder to be able to create or drop replication slots. A role having\nthe `replication` attribute is a very highly privileged role, and\nshould only be used on roles actually used for replication. Default\nis `false`.";
        type = types.bool;
        default = false;
      };
      "superuser" = mkOption {
        description = "Whether the role is a `superuser` who can override all access\nrestrictions within the database - superuser status is dangerous and\nshould be used only when really needed. You must yourself be a\nsuperuser to create a new superuser. Defaults is `false`.";
        type = types.bool;
        default = false;
      };
      "validUntil" = mkOption {
        description = "Date and time after which the role's password is no longer valid.\nWhen omitted, the password will never expire (default).";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkManagedRole =
    res:
    {
    }
    // optionalAttrs res."bypassrls" { inherit (res) "bypassrls"; }
    // {
    }
    // optionalAttrs (res."comment" != null) { inherit (res) "comment"; }
    // {
    }
    // optionalAttrs (res."connectionLimit" != null) { inherit (res) "connectionLimit"; }
    // {
    }
    // optionalAttrs res."createdb" { inherit (res) "createdb"; }
    // {
    }
    // optionalAttrs res."createrole" { inherit (res) "createrole"; }
    // {
    }
    // optionalAttrs res."disablePassword" { inherit (res) "disablePassword"; }
    // {
    }
    // optionalAttrs (res."ensure" != null) { inherit (res) "ensure"; }
    // {
    }
    // optionalAttrs (res."inRoles" != [ ]) { inherit (res) "inRoles"; }
    // {
    }
    // optionalAttrs (res."inherit" != null) { inherit (res) "inherit"; }
    // {
    }
    // optionalAttrs res."login" { inherit (res) "login"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."passwordSecret" != null) {
      "passwordSecret" = mkManagedRolePasswordSecret res."passwordSecret";
    }
    // {
    }
    // optionalAttrs res."replication" { inherit (res) "replication"; }
    // {
    }
    // optionalAttrs res."superuser" { inherit (res) "superuser"; }
    // {
    }
    // optionalAttrs (res."validUntil" != null) { inherit (res) "validUntil"; }
    // {
    };
  ManagedRolePasswordSecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkManagedRolePasswordSecret = res: {
    inherit (res) "name";
  };
  ManagedServicesAdditionalModule = types.submodule {
    options = {
      "selectorType" = mkOption {
        description = "SelectorType specifies the type of selectors that the service will have.\nValid values are \"rw\", \"r\", and \"ro\", representing read-write, read, and read-only services.";
        type = (
          types.enum [
            "rw"
            "r"
            "ro"
          ]
        );
      };
      "serviceTemplate" = mkOption {
        description = "ServiceTemplate is the template specification for the service.";
        type = ManagedServicesAdditionalServiceTemplateModule;
      };
      "updateStrategy" = mkOption {
        description = "UpdateStrategy describes how the service differences should be reconciled";
        type = (
          types.nullOr (
            types.enum [
              "patch"
              "replace"
            ]
          )
        );
        default = "patch";
      };
    };
  };
  mkManagedServicesAdditional =
    res:
    {
      inherit (res) "selectorType";
      "serviceTemplate" = mkManagedServicesAdditionalServiceTemplate res."serviceTemplate";
    }
    // optionalAttrs (res."updateStrategy" != null) { inherit (res) "updateStrategy"; }
    // {
    };
  ManagedServicesAdditionalServiceTemplateMetadataModule = types.submodule {
    options = {
      "annotations" = mkOption {
        description = "Annotations is an unstructured key value map stored with a resource that may be\nset by external tools to store and retrieve arbitrary metadata. They are not\nqueryable and should be preserved when modifying objects.\nMore info: http://kubernetes.io/docs/user-guide/annotations";
        type = (types.attrsOf types.str);
        default = { };
      };
      "labels" = mkOption {
        description = "Map of string keys and values that can be used to organize and categorize\n(scope and select) objects. May match selectors of replication controllers\nand services.\nMore info: http://kubernetes.io/docs/user-guide/labels";
        type = (types.attrsOf types.str);
        default = { };
      };
      "name" = mkOption {
        description = "The name of the resource. Only supported for certain types";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkManagedServicesAdditionalServiceTemplateMetadata =
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
  ManagedServicesAdditionalServiceTemplateModule = types.submodule {
    options = {
      "metadata" = mkOption {
        description = "Standard object's metadata.\nMore info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata";
        type = (types.nullOr ManagedServicesAdditionalServiceTemplateMetadataModule);
        default = null;
      };
      "spec" = mkOption {
        description = "Specification of the desired behavior of the service.\nMore info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status";
        type = (types.nullOr ManagedServicesAdditionalServiceTemplateSpecModule);
        default = null;
      };
    };
  };
  mkManagedServicesAdditionalServiceTemplate =
    res:
    {
    }
    // optionalAttrs (res."metadata" != null) {
      "metadata" = mkManagedServicesAdditionalServiceTemplateMetadata res."metadata";
    }
    // {
    }
    // optionalAttrs (res."spec" != null) {
      "spec" = mkManagedServicesAdditionalServiceTemplateSpec res."spec";
    }
    // {
    };
  ManagedServicesAdditionalServiceTemplateSpecModule = types.submodule {
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
        type = (types.listOf ManagedServicesAdditionalServiceTemplateSpecPortModule);
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
        type = (types.nullOr ManagedServicesAdditionalServiceTemplateSpecSessionAffinityConfigModule);
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
  mkManagedServicesAdditionalServiceTemplateSpec =
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
    // optionalAttrs (res."ports" != [ ]) {
      "ports" = map mkManagedServicesAdditionalServiceTemplateSpecPort res."ports";
    }
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
      "sessionAffinityConfig" =
        mkManagedServicesAdditionalServiceTemplateSpecSessionAffinityConfig
          res."sessionAffinityConfig";
    }
    // {
    }
    // optionalAttrs (res."trafficDistribution" != null) { inherit (res) "trafficDistribution"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ManagedServicesAdditionalServiceTemplateSpecPortModule = types.submodule {
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
  mkManagedServicesAdditionalServiceTemplateSpecPort =
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
  ManagedServicesAdditionalServiceTemplateSpecSessionAffinityConfigClientIPModule = types.submodule {
    options = {
      "timeoutSeconds" = mkOption {
        description = "timeoutSeconds specifies the seconds of ClientIP type session sticky time.\nThe value must be >0 && <=86400(for 1 day) if ServiceAffinity == \"ClientIP\".\nDefault value is 10800(for 3 hours).";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkManagedServicesAdditionalServiceTemplateSpecSessionAffinityConfigClientIP =
    res:
    {
    }
    // optionalAttrs (res."timeoutSeconds" != null) { inherit (res) "timeoutSeconds"; }
    // {
    };
  ManagedServicesAdditionalServiceTemplateSpecSessionAffinityConfigModule = types.submodule {
    options = {
      "clientIP" = mkOption {
        description = "clientIP contains the configurations of Client IP based session affinity.";
        type = (
          types.nullOr ManagedServicesAdditionalServiceTemplateSpecSessionAffinityConfigClientIPModule
        );
        default = null;
      };
    };
  };
  mkManagedServicesAdditionalServiceTemplateSpecSessionAffinityConfig =
    res:
    {
    }
    // optionalAttrs (res."clientIP" != null) {
      "clientIP" =
        mkManagedServicesAdditionalServiceTemplateSpecSessionAffinityConfigClientIP
          res."clientIP";
    }
    // {
    };
  ManagedServicesModule = types.submodule {
    options = {
      "additional" = mkOption {
        description = "Additional is a list of additional managed services specified by the user.";
        type = (types.listOf ManagedServicesAdditionalModule);
        default = [ ];
      };
      "disabledDefaultServices" = mkOption {
        description = "DisabledDefaultServices is a list of service types that are disabled by default.\nValid values are \"r\", and \"ro\", representing read, and read-only services.";
        type = (
          types.listOf (
            types.enum [
              "rw"
              "r"
              "ro"
            ]
          )
        );
        default = [ ];
      };
    };
  };
  mkManagedServices =
    res:
    {
    }
    // optionalAttrs (res."additional" != [ ]) {
      "additional" = map mkManagedServicesAdditional res."additional";
    }
    // {
    }
    // optionalAttrs (res."disabledDefaultServices" != [ ]) { inherit (res) "disabledDefaultServices"; }
    // {
    };
  MonitoringCustomQueriesConfigMapModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkMonitoringCustomQueriesConfigMap = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  MonitoringCustomQueriesSecretModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkMonitoringCustomQueriesSecret = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  MonitoringModule = types.submodule {
    options = {
      "customQueriesConfigMap" = mkOption {
        description = "The list of config maps containing the custom queries";
        type = (types.listOf MonitoringCustomQueriesConfigMapModule);
        default = [ ];
      };
      "customQueriesSecret" = mkOption {
        description = "The list of secrets containing the custom queries";
        type = (types.listOf MonitoringCustomQueriesSecretModule);
        default = [ ];
      };
      "disableDefaultQueries" = mkOption {
        description = "Whether the default queries should be injected.\nSet it to `true` if you don't want to inject default queries into the cluster.\nDefault: false.";
        type = types.bool;
        default = false;
      };
      "enablePodMonitor" = mkOption {
        description = "Enable or disable the `PodMonitor`";
        type = types.bool;
        default = false;
      };
      "podMonitorMetricRelabelings" = mkOption {
        description = "The list of metric relabelings for the `PodMonitor`. Applied to samples before ingestion.";
        type = (types.listOf MonitoringPodMonitorMetricRelabelingModule);
        default = [ ];
      };
      "podMonitorRelabelings" = mkOption {
        description = "The list of relabelings for the `PodMonitor`. Applied to samples before scraping.";
        type = (types.listOf MonitoringPodMonitorRelabelingModule);
        default = [ ];
      };
      "tls" = mkOption {
        description = "Configure TLS communication for the metrics endpoint.\nChanging tls.enabled option will force a rollout of all instances.";
        type = (types.nullOr MonitoringTlsModule);
        default = null;
      };
    };
  };
  mkMonitoring =
    res:
    {
    }
    // optionalAttrs (res."customQueriesConfigMap" != [ ]) {
      "customQueriesConfigMap" = map mkMonitoringCustomQueriesConfigMap res."customQueriesConfigMap";
    }
    // {
    }
    // optionalAttrs (res."customQueriesSecret" != [ ]) {
      "customQueriesSecret" = map mkMonitoringCustomQueriesSecret res."customQueriesSecret";
    }
    // {
    }
    // optionalAttrs res."disableDefaultQueries" { inherit (res) "disableDefaultQueries"; }
    // {
    }
    // optionalAttrs res."enablePodMonitor" { inherit (res) "enablePodMonitor"; }
    // {
    }
    // optionalAttrs (res."podMonitorMetricRelabelings" != [ ]) {
      "podMonitorMetricRelabelings" =
        map mkMonitoringPodMonitorMetricRelabeling
          res."podMonitorMetricRelabelings";
    }
    // {
    }
    // optionalAttrs (res."podMonitorRelabelings" != [ ]) {
      "podMonitorRelabelings" = map mkMonitoringPodMonitorRelabeling res."podMonitorRelabelings";
    }
    // {
    }
    // optionalAttrs (res."tls" != null) { "tls" = mkMonitoringTls res."tls"; }
    // {
    };
  MonitoringPodMonitorMetricRelabelingModule = types.submodule {
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
  mkMonitoringPodMonitorMetricRelabeling =
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
  MonitoringPodMonitorRelabelingModule = types.submodule {
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
  mkMonitoringPodMonitorRelabeling =
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
  MonitoringTlsModule = types.submodule {
    options = {
      "enabled" = mkOption {
        description = "Enable TLS for the monitoring endpoint.\nChanging this option will force a rollout of all instances.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkMonitoringTls =
    res:
    {
    }
    // optionalAttrs res."enabled" { inherit (res) "enabled"; }
    // {
    };
  NodeMaintenanceWindowModule = types.submodule {
    options = {
      "inProgress" = mkOption {
        description = "Is there a node maintenance activity in progress?";
        type = types.bool;
        default = false;
      };
      "reusePVC" = mkOption {
        description = "Reuse the existing PVC (wait for the node to come\nup again) or not (recreate it elsewhere - when `instances` >1)";
        type = types.bool;
        default = true;
      };
    };
  };
  mkNodeMaintenanceWindow =
    res:
    {
    }
    // optionalAttrs res."inProgress" { inherit (res) "inProgress"; }
    // {
    }
    // optionalAttrs (res."reusePVC" != null) { inherit (res) "reusePVC"; }
    // {
    };
  PluginModule = types.submodule {
    options = {
      "enabled" = mkOption {
        description = "Enabled is true if this plugin will be used";
        type = types.bool;
        default = true;
      };
      "isWALArchiver" = mkOption {
        description = "Only one plugin can be declared as WALArchiver.\nCannot be active if \".spec.backup.barmanObjectStore\" configuration is present.";
        type = types.bool;
        default = false;
      };
      "name" = mkOption {
        description = "Name is the plugin name";
        type = types.str;
      };
      "parameters" = mkOption {
        description = "Parameters is the configuration of the plugin";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkPlugin =
    res:
    {
    }
    // optionalAttrs (res."enabled" != null) { inherit (res) "enabled"; }
    // {
    }
    // optionalAttrs res."isWALArchiver" { inherit (res) "isWALArchiver"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."parameters" != { }) { inherit (res) "parameters"; }
    // {
    };
  PostgresqlExtensionImageModule = types.submodule {
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
  mkPostgresqlExtensionImage =
    res:
    {
    }
    // optionalAttrs (res."pullPolicy" != null) { inherit (res) "pullPolicy"; }
    // {
    }
    // optionalAttrs (res."reference" != null) { inherit (res) "reference"; }
    // {
    };
  PostgresqlExtensionModule = types.submodule {
    options = {
      "dynamic_library_path" = mkOption {
        description = "The list of directories inside the image which should be added to dynamic_library_path.\nIf not defined, defaults to \"/lib\".";
        type = (types.listOf types.str);
        default = [ ];
      };
      "extension_control_path" = mkOption {
        description = "The list of directories inside the image which should be added to extension_control_path.\nIf not defined, defaults to \"/share\".";
        type = (types.listOf types.str);
        default = [ ];
      };
      "image" = mkOption {
        description = "The image containing the extension, required";
        type = PostgresqlExtensionImageModule;
      };
      "ld_library_path" = mkOption {
        description = "The list of directories inside the image which should be added to ld_library_path.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "name" = mkOption {
        description = "The name of the extension, required";
        type = types.str;
      };
    };
  };
  mkPostgresqlExtension =
    res:
    {
    }
    // optionalAttrs (res."dynamic_library_path" != [ ]) { inherit (res) "dynamic_library_path"; }
    // {
    }
    // optionalAttrs (res."extension_control_path" != [ ]) { inherit (res) "extension_control_path"; }
    // {
      "image" = mkPostgresqlExtensionImage res."image";
    }
    // optionalAttrs (res."ld_library_path" != [ ]) { inherit (res) "ld_library_path"; }
    // {
      inherit (res) "name";
    };
  PostgresqlLdapBindAsAuthModule = types.submodule {
    options = {
      "prefix" = mkOption {
        description = "Prefix for the bind authentication option";
        type = (types.nullOr types.str);
        default = null;
      };
      "suffix" = mkOption {
        description = "Suffix for the bind authentication option";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkPostgresqlLdapBindAsAuth =
    res:
    {
    }
    // optionalAttrs (res."prefix" != null) { inherit (res) "prefix"; }
    // {
    }
    // optionalAttrs (res."suffix" != null) { inherit (res) "suffix"; }
    // {
    };
  PostgresqlLdapBindSearchAuthBindPasswordModule = types.submodule {
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
  mkPostgresqlLdapBindSearchAuthBindPassword =
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
  PostgresqlLdapBindSearchAuthModule = types.submodule {
    options = {
      "baseDN" = mkOption {
        description = "Root DN to begin the user search";
        type = (types.nullOr types.str);
        default = null;
      };
      "bindDN" = mkOption {
        description = "DN of the user to bind to the directory";
        type = (types.nullOr types.str);
        default = null;
      };
      "bindPassword" = mkOption {
        description = "Secret with the password for the user to bind to the directory";
        type = (types.nullOr PostgresqlLdapBindSearchAuthBindPasswordModule);
        default = null;
      };
      "searchAttribute" = mkOption {
        description = "Attribute to match against the username";
        type = (types.nullOr types.str);
        default = null;
      };
      "searchFilter" = mkOption {
        description = "Search filter to use when doing the search+bind authentication";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkPostgresqlLdapBindSearchAuth =
    res:
    {
    }
    // optionalAttrs (res."baseDN" != null) { inherit (res) "baseDN"; }
    // {
    }
    // optionalAttrs (res."bindDN" != null) { inherit (res) "bindDN"; }
    // {
    }
    // optionalAttrs (res."bindPassword" != null) {
      "bindPassword" = mkPostgresqlLdapBindSearchAuthBindPassword res."bindPassword";
    }
    // {
    }
    // optionalAttrs (res."searchAttribute" != null) { inherit (res) "searchAttribute"; }
    // {
    }
    // optionalAttrs (res."searchFilter" != null) { inherit (res) "searchFilter"; }
    // {
    };
  PostgresqlLdapModule = types.submodule {
    options = {
      "bindAsAuth" = mkOption {
        description = "Bind as authentication configuration";
        type = (types.nullOr PostgresqlLdapBindAsAuthModule);
        default = null;
      };
      "bindSearchAuth" = mkOption {
        description = "Bind+Search authentication configuration";
        type = (types.nullOr PostgresqlLdapBindSearchAuthModule);
        default = null;
      };
      "port" = mkOption {
        description = "LDAP server port";
        type = (types.nullOr types.int);
        default = null;
      };
      "scheme" = mkOption {
        description = "LDAP schema to be used, possible options are `ldap` and `ldaps`";
        type = (
          types.nullOr (
            types.enum [
              "ldap"
              "ldaps"
            ]
          )
        );
        default = null;
      };
      "server" = mkOption {
        description = "LDAP hostname or IP address";
        type = (types.nullOr types.str);
        default = null;
      };
      "tls" = mkOption {
        description = "Set to 'true' to enable LDAP over TLS. 'false' is default";
        type = types.bool;
        default = false;
      };
    };
  };
  mkPostgresqlLdap =
    res:
    {
    }
    // optionalAttrs (res."bindAsAuth" != null) {
      "bindAsAuth" = mkPostgresqlLdapBindAsAuth res."bindAsAuth";
    }
    // {
    }
    // optionalAttrs (res."bindSearchAuth" != null) {
      "bindSearchAuth" = mkPostgresqlLdapBindSearchAuth res."bindSearchAuth";
    }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    }
    // optionalAttrs (res."server" != null) { inherit (res) "server"; }
    // {
    }
    // optionalAttrs res."tls" { inherit (res) "tls"; }
    // {
    };
  PostgresqlModule = types.submodule {
    options = {
      "enableAlterSystem" = mkOption {
        description = "If this parameter is true, the user will be able to invoke `ALTER SYSTEM`\non this CloudNativePG Cluster.\nThis should only be used for debugging and troubleshooting.\nDefaults to false.";
        type = types.bool;
        default = false;
      };
      "extensions" = mkOption {
        description = "The configuration of the extensions to be added";
        type = (types.listOf PostgresqlExtensionModule);
        default = [ ];
      };
      "ldap" = mkOption {
        description = "Options to specify LDAP configuration";
        type = (types.nullOr PostgresqlLdapModule);
        default = null;
      };
      "parameters" = mkOption {
        description = "PostgreSQL configuration options (postgresql.conf)";
        type = (types.attrsOf types.str);
        default = { };
      };
      "pg_hba" = mkOption {
        description = "PostgreSQL Host Based Authentication rules (lines to be appended\nto the pg_hba.conf file)";
        type = (types.listOf types.str);
        default = [ ];
      };
      "pg_ident" = mkOption {
        description = "PostgreSQL User Name Maps rules (lines to be appended\nto the pg_ident.conf file)";
        type = (types.listOf types.str);
        default = [ ];
      };
      "promotionTimeout" = mkOption {
        description = "Specifies the maximum number of seconds to wait when promoting an instance to primary.\nDefault value is 40000000, greater than one year in seconds,\nbig enough to simulate an infinite timeout";
        type = (types.nullOr types.int);
        default = null;
      };
      "shared_preload_libraries" = mkOption {
        description = "Lists of shared preload libraries to add to the default ones";
        type = (types.listOf types.str);
        default = [ ];
      };
      "syncReplicaElectionConstraint" = mkOption {
        description = "Requirements to be met by sync replicas. This will affect how the \"synchronous_standby_names\" parameter will be\nset up.";
        type = (types.nullOr PostgresqlSyncReplicaElectionConstraintModule);
        default = null;
      };
      "synchronous" = mkOption {
        description = "Configuration of the PostgreSQL synchronous replication feature";
        type = (types.nullOr PostgresqlSynchronousModule);
        default = null;
      };
    };
  };
  mkPostgresql =
    res:
    {
    }
    // optionalAttrs res."enableAlterSystem" { inherit (res) "enableAlterSystem"; }
    // {
    }
    // optionalAttrs (res."extensions" != [ ]) {
      "extensions" = map mkPostgresqlExtension res."extensions";
    }
    // {
    }
    // optionalAttrs (res."ldap" != null) { "ldap" = mkPostgresqlLdap res."ldap"; }
    // {
    }
    // optionalAttrs (res."parameters" != { }) { inherit (res) "parameters"; }
    // {
    }
    // optionalAttrs (res."pg_hba" != [ ]) { inherit (res) "pg_hba"; }
    // {
    }
    // optionalAttrs (res."pg_ident" != [ ]) { inherit (res) "pg_ident"; }
    // {
    }
    // optionalAttrs (res."promotionTimeout" != null) { inherit (res) "promotionTimeout"; }
    // {
    }
    // optionalAttrs (res."shared_preload_libraries" != [ ]) {
      inherit (res) "shared_preload_libraries";
    }
    // {
    }
    // optionalAttrs (res."syncReplicaElectionConstraint" != null) {
      "syncReplicaElectionConstraint" =
        mkPostgresqlSyncReplicaElectionConstraint
          res."syncReplicaElectionConstraint";
    }
    // {
    }
    // optionalAttrs (res."synchronous" != null) {
      "synchronous" = mkPostgresqlSynchronous res."synchronous";
    }
    // {
    };
  PostgresqlSyncReplicaElectionConstraintModule = types.submodule {
    options = {
      "enabled" = mkOption {
        description = "This flag enables the constraints for sync replicas";
        type = types.bool;
      };
      "nodeLabelsAntiAffinity" = mkOption {
        description = "A list of node labels values to extract and compare to evaluate if the pods reside in the same topology or not";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkPostgresqlSyncReplicaElectionConstraint =
    res:
    {
      inherit (res) "enabled";
    }
    // optionalAttrs (res."nodeLabelsAntiAffinity" != [ ]) { inherit (res) "nodeLabelsAntiAffinity"; }
    // {
    };
  PostgresqlSynchronousModule = types.submodule {
    options = {
      "dataDurability" = mkOption {
        description = "If set to \"required\", data durability is strictly enforced. Write operations\nwith synchronous commit settings (`on`, `remote_write`, or `remote_apply`) will\nblock if there are insufficient healthy replicas, ensuring data persistence.\nIf set to \"preferred\", data durability is maintained when healthy replicas\nare available, but the required number of instances will adjust dynamically\nif replicas become unavailable. This setting relaxes strict durability enforcement\nto allow for operational continuity. This setting is only applicable if both\n`standbyNamesPre` and `standbyNamesPost` are unset (empty).";
        type = (
          types.nullOr (
            types.enum [
              "required"
              "preferred"
            ]
          )
        );
        default = null;
      };
      "maxStandbyNamesFromCluster" = mkOption {
        description = "Specifies the maximum number of local cluster pods that can be\nautomatically included in the `synchronous_standby_names` option in\nPostgreSQL.";
        type = (types.nullOr types.int);
        default = null;
      };
      "method" = mkOption {
        description = "Method to select synchronous replication standbys from the listed\nservers, accepting 'any' (quorum-based synchronous replication) or\n'first' (priority-based synchronous replication) as values.";
        type = (
          types.enum [
            "any"
            "first"
          ]
        );
      };
      "number" = mkOption {
        description = "Specifies the number of synchronous standby servers that\ntransactions must wait for responses from.";
        type = types.int;
      };
      "standbyNamesPost" = mkOption {
        description = "A user-defined list of application names to be added to\n`synchronous_standby_names` after local cluster pods (the order is\nonly useful for priority-based synchronous replication).";
        type = (types.listOf types.str);
        default = [ ];
      };
      "standbyNamesPre" = mkOption {
        description = "A user-defined list of application names to be added to\n`synchronous_standby_names` before local cluster pods (the order is\nonly useful for priority-based synchronous replication).";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkPostgresqlSynchronous =
    res:
    {
    }
    // optionalAttrs (res."dataDurability" != null) { inherit (res) "dataDurability"; }
    // {
    }
    // optionalAttrs (res."maxStandbyNamesFromCluster" != null) {
      inherit (res) "maxStandbyNamesFromCluster";
    }
    // {
      inherit (res) "method";
      inherit (res) "number";
    }
    // optionalAttrs (res."standbyNamesPost" != [ ]) { inherit (res) "standbyNamesPost"; }
    // {
    }
    // optionalAttrs (res."standbyNamesPre" != [ ]) { inherit (res) "standbyNamesPre"; }
    // {
    };
  ProbesLivenessIsolationCheckModule = types.submodule {
    options = {
      "connectionTimeout" = mkOption {
        description = "Timeout in milliseconds for connections during the primary isolation check";
        type = (types.nullOr types.int);
        default = 1000;
      };
      "enabled" = mkOption {
        description = "Whether primary isolation checking is enabled for the liveness probe";
        type = types.bool;
        default = true;
      };
      "requestTimeout" = mkOption {
        description = "Timeout in milliseconds for requests during the primary isolation check";
        type = (types.nullOr types.int);
        default = 1000;
      };
    };
  };
  mkProbesLivenessIsolationCheck =
    res:
    {
    }
    // optionalAttrs (res."connectionTimeout" != null) { inherit (res) "connectionTimeout"; }
    // {
    }
    // optionalAttrs (res."enabled" != null) { inherit (res) "enabled"; }
    // {
    }
    // optionalAttrs (res."requestTimeout" != null) { inherit (res) "requestTimeout"; }
    // {
    };
  ProbesLivenessModule = types.submodule {
    options = {
      "failureThreshold" = mkOption {
        description = "Minimum consecutive failures for the probe to be considered failed after having succeeded.\nDefaults to 3. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "initialDelaySeconds" = mkOption {
        description = "Number of seconds after the container has started before liveness probes are initiated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr types.int);
        default = null;
      };
      "isolationCheck" = mkOption {
        description = "Configure the feature that extends the liveness probe for a primary\ninstance. In addition to the basic checks, this verifies whether the\nprimary is isolated from the Kubernetes API server and from its\nreplicas, ensuring that it can be safely shut down if network\npartition or API unavailability is detected. Enabled by default.";
        type = (types.nullOr ProbesLivenessIsolationCheckModule);
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
  mkProbesLiveness =
    res:
    {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."initialDelaySeconds" != null) { inherit (res) "initialDelaySeconds"; }
    // {
    }
    // optionalAttrs (res."isolationCheck" != null) {
      "isolationCheck" = mkProbesLivenessIsolationCheck res."isolationCheck";
    }
    // {
    }
    // optionalAttrs (res."periodSeconds" != null) { inherit (res) "periodSeconds"; }
    // {
    }
    // optionalAttrs (res."successThreshold" != null) { inherit (res) "successThreshold"; }
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
  ProbesModule = types.submodule {
    options = {
      "liveness" = mkOption {
        description = "The liveness probe configuration";
        type = (types.nullOr ProbesLivenessModule);
        default = null;
      };
      "readiness" = mkOption {
        description = "The readiness probe configuration";
        type = (types.nullOr ProbesReadinessModule);
        default = null;
      };
      "startup" = mkOption {
        description = "The startup probe configuration";
        type = (types.nullOr ProbesStartupModule);
        default = null;
      };
    };
  };
  mkProbes =
    res:
    {
    }
    // optionalAttrs (res."liveness" != null) { "liveness" = mkProbesLiveness res."liveness"; }
    // {
    }
    // optionalAttrs (res."readiness" != null) { "readiness" = mkProbesReadiness res."readiness"; }
    // {
    }
    // optionalAttrs (res."startup" != null) { "startup" = mkProbesStartup res."startup"; }
    // {
    };
  ProbesReadinessModule = types.submodule {
    options = {
      "failureThreshold" = mkOption {
        description = "Minimum consecutive failures for the probe to be considered failed after having succeeded.\nDefaults to 3. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "initialDelaySeconds" = mkOption {
        description = "Number of seconds after the container has started before liveness probes are initiated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr types.int);
        default = null;
      };
      "maximumLag" = mkOption {
        description = "Lag limit. Used only for `streaming` strategy";
        type = types.anything;
        default = { };
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
      "type" = mkOption {
        description = "The probe strategy";
        type = (
          types.nullOr (
            types.enum [
              "pg_isready"
              "streaming"
              "query"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkProbesReadiness =
    res:
    {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."initialDelaySeconds" != null) { inherit (res) "initialDelaySeconds"; }
    // {
    }
    // optionalAttrs (res."maximumLag" != null) { inherit (res) "maximumLag"; }
    // {
    }
    // optionalAttrs (res."periodSeconds" != null) { inherit (res) "periodSeconds"; }
    // {
    }
    // optionalAttrs (res."successThreshold" != null) { inherit (res) "successThreshold"; }
    // {
    }
    // optionalAttrs (res."terminationGracePeriodSeconds" != null) {
      inherit (res) "terminationGracePeriodSeconds";
    }
    // {
    }
    // optionalAttrs (res."timeoutSeconds" != null) { inherit (res) "timeoutSeconds"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ProbesStartupModule = types.submodule {
    options = {
      "failureThreshold" = mkOption {
        description = "Minimum consecutive failures for the probe to be considered failed after having succeeded.\nDefaults to 3. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "initialDelaySeconds" = mkOption {
        description = "Number of seconds after the container has started before liveness probes are initiated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr types.int);
        default = null;
      };
      "maximumLag" = mkOption {
        description = "Lag limit. Used only for `streaming` strategy";
        type = types.anything;
        default = { };
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
      "type" = mkOption {
        description = "The probe strategy";
        type = (
          types.nullOr (
            types.enum [
              "pg_isready"
              "streaming"
              "query"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkProbesStartup =
    res:
    {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."initialDelaySeconds" != null) { inherit (res) "initialDelaySeconds"; }
    // {
    }
    // optionalAttrs (res."maximumLag" != null) { inherit (res) "maximumLag"; }
    // {
    }
    // optionalAttrs (res."periodSeconds" != null) { inherit (res) "periodSeconds"; }
    // {
    }
    // optionalAttrs (res."successThreshold" != null) { inherit (res) "successThreshold"; }
    // {
    }
    // optionalAttrs (res."terminationGracePeriodSeconds" != null) {
      inherit (res) "terminationGracePeriodSeconds";
    }
    // {
    }
    // optionalAttrs (res."timeoutSeconds" != null) { inherit (res) "timeoutSeconds"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ProjectedVolumeTemplateModule = types.submodule {
    options = {
      "defaultMode" = mkOption {
        description = "defaultMode are the mode bits used to set permissions on created files by default.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nDirectories within the path are not affected by this setting.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "sources" = mkOption {
        description = "sources is the list of volume projections. Each entry in this list\nhandles one source.";
        type = (types.listOf ProjectedVolumeTemplateSourceModule);
        default = [ ];
      };
    };
  };
  mkProjectedVolumeTemplate =
    res:
    {
    }
    // optionalAttrs (res."defaultMode" != null) { inherit (res) "defaultMode"; }
    // {
    }
    // optionalAttrs (res."sources" != [ ]) {
      "sources" = map mkProjectedVolumeTemplateSource res."sources";
    }
    // {
    };
  ProjectedVolumeTemplateSourceClusterTrustBundleLabelSelectorMatchExpressionModule =
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
  mkProjectedVolumeTemplateSourceClusterTrustBundleLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProjectedVolumeTemplateSourceClusterTrustBundleLabelSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (
          types.listOf ProjectedVolumeTemplateSourceClusterTrustBundleLabelSelectorMatchExpressionModule
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
  mkProjectedVolumeTemplateSourceClusterTrustBundleLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkProjectedVolumeTemplateSourceClusterTrustBundleLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProjectedVolumeTemplateSourceClusterTrustBundleModule = types.submodule {
    options = {
      "labelSelector" = mkOption {
        description = "Select all ClusterTrustBundles that match this label selector.  Only has\neffect if signerName is set.  Mutually-exclusive with name.  If unset,\ninterpreted as \"match nothing\".  If set but empty, interpreted as \"match\neverything\".";
        type = (types.nullOr ProjectedVolumeTemplateSourceClusterTrustBundleLabelSelectorModule);
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
  mkProjectedVolumeTemplateSourceClusterTrustBundle =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkProjectedVolumeTemplateSourceClusterTrustBundleLabelSelector
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
  ProjectedVolumeTemplateSourceConfigMapItemModule = types.submodule {
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
  mkProjectedVolumeTemplateSourceConfigMapItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    };
  ProjectedVolumeTemplateSourceConfigMapModule = types.submodule {
    options = {
      "items" = mkOption {
        description = "items if unspecified, each key-value pair in the Data field of the referenced\nConfigMap will be projected into the volume as a file whose name is the\nkey and content is the value. If specified, the listed keys will be\nprojected into the specified paths, and unlisted keys will not be\npresent. If a key is specified which is not present in the ConfigMap,\nthe volume setup will error unless it is marked optional. Paths must be\nrelative and may not contain the '..' path or start with '..'.";
        type = (types.listOf ProjectedVolumeTemplateSourceConfigMapItemModule);
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
  mkProjectedVolumeTemplateSourceConfigMap =
    res:
    {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkProjectedVolumeTemplateSourceConfigMapItem res."items";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ProjectedVolumeTemplateSourceDownwardAPIItemFieldRefModule = types.submodule {
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
  mkProjectedVolumeTemplateSourceDownwardAPIItemFieldRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "fieldPath";
    };
  ProjectedVolumeTemplateSourceDownwardAPIItemModule = types.submodule {
    options = {
      "fieldRef" = mkOption {
        description = "Required: Selects a field of the pod: only annotations, labels, name, namespace and uid are supported.";
        type = (types.nullOr ProjectedVolumeTemplateSourceDownwardAPIItemFieldRefModule);
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
        type = (types.nullOr ProjectedVolumeTemplateSourceDownwardAPIItemResourceFieldRefModule);
        default = null;
      };
    };
  };
  mkProjectedVolumeTemplateSourceDownwardAPIItem =
    res:
    {
    }
    // optionalAttrs (res."fieldRef" != null) {
      "fieldRef" = mkProjectedVolumeTemplateSourceDownwardAPIItemFieldRef res."fieldRef";
    }
    // {
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    }
    // optionalAttrs (res."resourceFieldRef" != null) {
      "resourceFieldRef" =
        mkProjectedVolumeTemplateSourceDownwardAPIItemResourceFieldRef
          res."resourceFieldRef";
    }
    // {
    };
  ProjectedVolumeTemplateSourceDownwardAPIItemResourceFieldRefModule = types.submodule {
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
  mkProjectedVolumeTemplateSourceDownwardAPIItemResourceFieldRef =
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
  ProjectedVolumeTemplateSourceDownwardAPIModule = types.submodule {
    options = {
      "items" = mkOption {
        description = "Items is a list of DownwardAPIVolume file";
        type = (types.listOf ProjectedVolumeTemplateSourceDownwardAPIItemModule);
        default = [ ];
      };
    };
  };
  mkProjectedVolumeTemplateSourceDownwardAPI =
    res:
    {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkProjectedVolumeTemplateSourceDownwardAPIItem res."items";
    }
    // {
    };
  ProjectedVolumeTemplateSourceModule = types.submodule {
    options = {
      "clusterTrustBundle" = mkOption {
        description = "ClusterTrustBundle allows a pod to access the `.spec.trustBundle` field\nof ClusterTrustBundle objects in an auto-updating file.\n\nAlpha, gated by the ClusterTrustBundleProjection feature gate.\n\nClusterTrustBundle objects can either be selected by name, or by the\ncombination of signer name and a label selector.\n\nKubelet performs aggressive normalization of the PEM contents written\ninto the pod filesystem.  Esoteric PEM features such as inter-block\ncomments and block headers are stripped.  Certificates are deduplicated.\nThe ordering of certificates within the file is arbitrary, and Kubelet\nmay change the order over time.";
        type = (types.nullOr ProjectedVolumeTemplateSourceClusterTrustBundleModule);
        default = null;
      };
      "configMap" = mkOption {
        description = "configMap information about the configMap data to project";
        type = (types.nullOr ProjectedVolumeTemplateSourceConfigMapModule);
        default = null;
      };
      "downwardAPI" = mkOption {
        description = "downwardAPI information about the downwardAPI data to project";
        type = (types.nullOr ProjectedVolumeTemplateSourceDownwardAPIModule);
        default = null;
      };
      "secret" = mkOption {
        description = "secret information about the secret data to project";
        type = (types.nullOr ProjectedVolumeTemplateSourceSecretModule);
        default = null;
      };
      "serviceAccountToken" = mkOption {
        description = "serviceAccountToken is information about the serviceAccountToken data to project";
        type = (types.nullOr ProjectedVolumeTemplateSourceServiceAccountTokenModule);
        default = null;
      };
    };
  };
  mkProjectedVolumeTemplateSource =
    res:
    {
    }
    // optionalAttrs (res."clusterTrustBundle" != null) {
      "clusterTrustBundle" = mkProjectedVolumeTemplateSourceClusterTrustBundle res."clusterTrustBundle";
    }
    // {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkProjectedVolumeTemplateSourceConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."downwardAPI" != null) {
      "downwardAPI" = mkProjectedVolumeTemplateSourceDownwardAPI res."downwardAPI";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkProjectedVolumeTemplateSourceSecret res."secret";
    }
    // {
    }
    // optionalAttrs (res."serviceAccountToken" != null) {
      "serviceAccountToken" =
        mkProjectedVolumeTemplateSourceServiceAccountToken
          res."serviceAccountToken";
    }
    // {
    };
  ProjectedVolumeTemplateSourceSecretItemModule = types.submodule {
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
  mkProjectedVolumeTemplateSourceSecretItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    };
  ProjectedVolumeTemplateSourceSecretModule = types.submodule {
    options = {
      "items" = mkOption {
        description = "items if unspecified, each key-value pair in the Data field of the referenced\nSecret will be projected into the volume as a file whose name is the\nkey and content is the value. If specified, the listed keys will be\nprojected into the specified paths, and unlisted keys will not be\npresent. If a key is specified which is not present in the Secret,\nthe volume setup will error unless it is marked optional. Paths must be\nrelative and may not contain the '..' path or start with '..'.";
        type = (types.listOf ProjectedVolumeTemplateSourceSecretItemModule);
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
  mkProjectedVolumeTemplateSourceSecret =
    res:
    {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkProjectedVolumeTemplateSourceSecretItem res."items";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ProjectedVolumeTemplateSourceServiceAccountTokenModule = types.submodule {
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
  mkProjectedVolumeTemplateSourceServiceAccountToken =
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
  ReplicaModule = types.submodule {
    options = {
      "enabled" = mkOption {
        description = "If replica mode is enabled, this cluster will be a replica of an\nexisting cluster. Replica cluster can be created from a recovery\nobject store or via streaming through pg_basebackup.\nRefer to the Replica clusters page of the documentation for more information.";
        type = types.bool;
        default = false;
      };
      "minApplyDelay" = mkOption {
        description = "When replica mode is enabled, this parameter allows you to replay\ntransactions only when the system time is at least the configured\ntime past the commit time. This provides an opportunity to correct\ndata loss errors. Note that when this parameter is set, a promotion\ntoken cannot be used.";
        type = (types.nullOr types.str);
        default = null;
      };
      "primary" = mkOption {
        description = "Primary defines which Cluster is defined to be the primary in the distributed PostgreSQL cluster, based on the\ntopology specified in externalClusters";
        type = (types.nullOr types.str);
        default = null;
      };
      "promotionToken" = mkOption {
        description = "A demotion token generated by an external cluster used to\ncheck if the promotion requirements are met.";
        type = (types.nullOr types.str);
        default = null;
      };
      "self" = mkOption {
        description = "Self defines the name of this cluster. It is used to determine if this is a primary\nor a replica cluster, comparing it with `primary`";
        type = (types.nullOr types.str);
        default = null;
      };
      "source" = mkOption {
        description = "The name of the external cluster which is the replication origin";
        type = types.str;
      };
    };
  };
  mkReplica =
    res:
    {
    }
    // optionalAttrs res."enabled" { inherit (res) "enabled"; }
    // {
    }
    // optionalAttrs (res."minApplyDelay" != null) { inherit (res) "minApplyDelay"; }
    // {
    }
    // optionalAttrs (res."primary" != null) { inherit (res) "primary"; }
    // {
    }
    // optionalAttrs (res."promotionToken" != null) { inherit (res) "promotionToken"; }
    // {
    }
    // optionalAttrs (res."self" != null) { inherit (res) "self"; }
    // {
      inherit (res) "source";
    };
  ReplicationSlotsHighAvailabilityModule = types.submodule {
    options = {
      "enabled" = mkOption {
        description = "If enabled (default), the operator will automatically manage replication slots\non the primary instance and use them in streaming replication\nconnections with all the standby instances that are part of the HA\ncluster. If disabled, the operator will not take advantage\nof replication slots in streaming connections with the replicas.\nThis feature also controls replication slots in replica cluster,\nfrom the designated primary to its cascading replicas.";
        type = types.bool;
        default = true;
      };
      "slotPrefix" = mkOption {
        description = "Prefix for replication slots managed by the operator for HA.\nIt may only contain lower case letters, numbers, and the underscore character.\nThis can only be set at creation time. By default set to `_cnpg_`.";
        type = (types.nullOr types.str);
        default = "_cnpg_";
      };
      "synchronizeLogicalDecoding" = mkOption {
        description = "When enabled, the operator automatically manages synchronization of logical\ndecoding (replication) slots across high-availability clusters.\n\nRequires one of the following conditions:\n- PostgreSQL version 17 or later\n- PostgreSQL version < 17 with pg_failover_slots extension enabled";
        type = types.bool;
        default = false;
      };
    };
  };
  mkReplicationSlotsHighAvailability =
    res:
    {
    }
    // optionalAttrs (res."enabled" != null) { inherit (res) "enabled"; }
    // {
    }
    // optionalAttrs (res."slotPrefix" != null) { inherit (res) "slotPrefix"; }
    // {
    }
    // optionalAttrs res."synchronizeLogicalDecoding" { inherit (res) "synchronizeLogicalDecoding"; }
    // {
    };
  ReplicationSlotsModule = types.submodule {
    options = {
      "highAvailability" = mkOption {
        description = "Replication slots for high availability configuration";
        type = (types.nullOr ReplicationSlotsHighAvailabilityModule);
        default = {
          "enabled" = true;
        };
      };
      "synchronizeReplicas" = mkOption {
        description = "Configures the synchronization of the user defined physical replication slots";
        type = (types.nullOr ReplicationSlotsSynchronizeReplicasModule);
        default = null;
      };
      "updateInterval" = mkOption {
        description = "Standby will update the status of the local replication slots\nevery `updateInterval` seconds (default 30).";
        type = (types.nullOr types.int);
        default = 30;
      };
    };
  };
  mkReplicationSlots =
    res:
    {
    }
    // optionalAttrs (res."highAvailability" != null) {
      "highAvailability" = mkReplicationSlotsHighAvailability res."highAvailability";
    }
    // {
    }
    // optionalAttrs (res."synchronizeReplicas" != null) {
      "synchronizeReplicas" = mkReplicationSlotsSynchronizeReplicas res."synchronizeReplicas";
    }
    // {
    }
    // optionalAttrs (res."updateInterval" != null) { inherit (res) "updateInterval"; }
    // {
    };
  ReplicationSlotsSynchronizeReplicasModule = types.submodule {
    options = {
      "enabled" = mkOption {
        description = "When set to true, every replication slot that is on the primary is synchronized on each standby";
        type = types.bool;
      };
      "excludePatterns" = mkOption {
        description = "List of regular expression patterns to match the names of replication slots to be excluded (by default empty)";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkReplicationSlotsSynchronizeReplicas =
    res:
    {
      inherit (res) "enabled";
    }
    // optionalAttrs (res."excludePatterns" != [ ]) { inherit (res) "excludePatterns"; }
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
  SeccompProfileModule = types.submodule {
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
  mkSeccompProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  ServiceAccountTemplateMetadataModule = types.submodule {
    options = {
      "annotations" = mkOption {
        description = "Annotations is an unstructured key value map stored with a resource that may be\nset by external tools to store and retrieve arbitrary metadata. They are not\nqueryable and should be preserved when modifying objects.\nMore info: http://kubernetes.io/docs/user-guide/annotations";
        type = (types.attrsOf types.str);
        default = { };
      };
      "labels" = mkOption {
        description = "Map of string keys and values that can be used to organize and categorize\n(scope and select) objects. May match selectors of replication controllers\nand services.\nMore info: http://kubernetes.io/docs/user-guide/labels";
        type = (types.attrsOf types.str);
        default = { };
      };
      "name" = mkOption {
        description = "The name of the resource. Only supported for certain types";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkServiceAccountTemplateMetadata =
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
  ServiceAccountTemplateModule = types.submodule {
    options = {
      "metadata" = mkOption {
        description = "Metadata are the metadata to be used for the generated\nservice account";
        type = ServiceAccountTemplateMetadataModule;
      };
    };
  };
  mkServiceAccountTemplate = res: {
    "metadata" = mkServiceAccountTemplateMetadata res."metadata";
  };
  StorageModule = types.submodule {
    options = {
      "pvcTemplate" = mkOption {
        description = "Template to be used to generate the Persistent Volume Claim";
        type = (types.nullOr StoragePvcTemplateModule);
        default = null;
      };
      "resizeInUseVolumes" = mkOption {
        description = "Resize existent PVCs, defaults to true";
        type = types.bool;
        default = true;
      };
      "size" = mkOption {
        description = "Size of the storage. Required if not already specified in the PVC template.\nChanges to this field are automatically reapplied to the created PVCs.\nSize cannot be decreased.";
        type = (types.nullOr types.str);
        default = null;
      };
      "storageClass" = mkOption {
        description = "StorageClass to use for PVCs. Applied after\nevaluating the PVC template, if available.\nIf not specified, the generated PVCs will use the\ndefault storage class";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkStorage =
    res:
    {
    }
    // optionalAttrs (res."pvcTemplate" != null) {
      "pvcTemplate" = mkStoragePvcTemplate res."pvcTemplate";
    }
    // {
    }
    // optionalAttrs (res."resizeInUseVolumes" != null) { inherit (res) "resizeInUseVolumes"; }
    // {
    }
    // optionalAttrs (res."size" != null) { inherit (res) "size"; }
    // {
    }
    // optionalAttrs (res."storageClass" != null) { inherit (res) "storageClass"; }
    // {
    };
  StoragePvcTemplateDataSourceModule = types.submodule {
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
  mkStoragePvcTemplateDataSource =
    res:
    {
    }
    // optionalAttrs (res."apiGroup" != null) { inherit (res) "apiGroup"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    };
  StoragePvcTemplateDataSourceRefModule = types.submodule {
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
  mkStoragePvcTemplateDataSourceRef =
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
  StoragePvcTemplateModule = types.submodule {
    options = {
      "accessModes" = mkOption {
        description = "accessModes contains the desired access modes the volume should have.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1";
        type = (types.listOf types.str);
        default = [ ];
      };
      "dataSource" = mkOption {
        description = "dataSource field can be used to specify either:\n* An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot)\n* An existing PVC (PersistentVolumeClaim)\nIf the provisioner or an external controller can support the specified data source,\nit will create a new volume based on the contents of the specified data source.\nWhen the AnyVolumeDataSource feature gate is enabled, dataSource contents will be copied to dataSourceRef,\nand dataSourceRef contents will be copied to dataSource when dataSourceRef.namespace is not specified.\nIf the namespace is specified, then dataSourceRef will not be copied to dataSource.";
        type = (types.nullOr StoragePvcTemplateDataSourceModule);
        default = null;
      };
      "dataSourceRef" = mkOption {
        description = "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty\nvolume is desired. This may be any object from a non-empty API group (non\ncore object) or a PersistentVolumeClaim object.\nWhen this field is specified, volume binding will only succeed if the type of\nthe specified object matches some installed volume populator or dynamic\nprovisioner.\nThis field will replace the functionality of the dataSource field and as such\nif both fields are non-empty, they must have the same value. For backwards\ncompatibility, when namespace isn't specified in dataSourceRef,\nboth fields (dataSource and dataSourceRef) will be set to the same\nvalue automatically if one of them is empty and the other is non-empty.\nWhen namespace is specified in dataSourceRef,\ndataSource isn't set to the same value and must be empty.\nThere are three important differences between dataSource and dataSourceRef:\n* While dataSource only allows two specific types of objects, dataSourceRef\n  allows any non-core object, as well as PersistentVolumeClaim objects.\n* While dataSource ignores disallowed values (dropping them), dataSourceRef\n  preserves all values, and generates an error if a disallowed value is\n  specified.\n* While dataSource only allows local objects, dataSourceRef allows objects\n  in any namespaces.\n(Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled.\n(Alpha) Using the namespace field of dataSourceRef requires the CrossNamespaceVolumeDataSource feature gate to be enabled.";
        type = (types.nullOr StoragePvcTemplateDataSourceRefModule);
        default = null;
      };
      "resources" = mkOption {
        description = "resources represents the minimum resources the volume should have.\nIf RecoverVolumeExpansionFailure feature is enabled users are allowed to specify resource requirements\nthat are lower than previous value but must still be higher than capacity recorded in the\nstatus field of the claim.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources";
        type = (types.nullOr StoragePvcTemplateResourcesModule);
        default = null;
      };
      "selector" = mkOption {
        description = "selector is a label query over volumes to consider for binding.";
        type = (types.nullOr StoragePvcTemplateSelectorModule);
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
  mkStoragePvcTemplate =
    res:
    {
    }
    // optionalAttrs (res."accessModes" != [ ]) { inherit (res) "accessModes"; }
    // {
    }
    // optionalAttrs (res."dataSource" != null) {
      "dataSource" = mkStoragePvcTemplateDataSource res."dataSource";
    }
    // {
    }
    // optionalAttrs (res."dataSourceRef" != null) {
      "dataSourceRef" = mkStoragePvcTemplateDataSourceRef res."dataSourceRef";
    }
    // {
    }
    // optionalAttrs (res."resources" != null) {
      "resources" = mkStoragePvcTemplateResources res."resources";
    }
    // {
    }
    // optionalAttrs (res."selector" != null) {
      "selector" = mkStoragePvcTemplateSelector res."selector";
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
  StoragePvcTemplateResourcesModule = types.submodule {
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
  mkStoragePvcTemplateResources =
    res:
    {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  StoragePvcTemplateSelectorMatchExpressionModule = types.submodule {
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
  mkStoragePvcTemplateSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  StoragePvcTemplateSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf StoragePvcTemplateSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkStoragePvcTemplateSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkStoragePvcTemplateSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  SuperuserSecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkSuperuserSecret = res: {
    inherit (res) "name";
  };
  TablespaceModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "The name of the tablespace";
        type = types.str;
      };
      "owner" = mkOption {
        description = "Owner is the PostgreSQL user owning the tablespace";
        type = (types.nullOr TablespaceOwnerModule);
        default = null;
      };
      "storage" = mkOption {
        description = "The storage configuration for the tablespace";
        type = TablespaceStorageModule;
      };
      "temporary" = mkOption {
        description = "When set to true, the tablespace will be added as a `temp_tablespaces`\nentry in PostgreSQL, and will be available to automatically house temp\ndatabase objects, or other temporary files. Please refer to PostgreSQL\ndocumentation for more information on the `temp_tablespaces` GUC.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkTablespace =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."owner" != null) { "owner" = mkTablespaceOwner res."owner"; }
    // {
      "storage" = mkTablespaceStorage res."storage";
    }
    // optionalAttrs res."temporary" { inherit (res) "temporary"; }
    // {
    };
  TablespaceOwnerModule = types.submodule {
    options = {
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTablespaceOwner =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  TablespaceStorageModule = types.submodule {
    options = {
      "pvcTemplate" = mkOption {
        description = "Template to be used to generate the Persistent Volume Claim";
        type = (types.nullOr TablespaceStoragePvcTemplateModule);
        default = null;
      };
      "resizeInUseVolumes" = mkOption {
        description = "Resize existent PVCs, defaults to true";
        type = types.bool;
        default = true;
      };
      "size" = mkOption {
        description = "Size of the storage. Required if not already specified in the PVC template.\nChanges to this field are automatically reapplied to the created PVCs.\nSize cannot be decreased.";
        type = (types.nullOr types.str);
        default = null;
      };
      "storageClass" = mkOption {
        description = "StorageClass to use for PVCs. Applied after\nevaluating the PVC template, if available.\nIf not specified, the generated PVCs will use the\ndefault storage class";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTablespaceStorage =
    res:
    {
    }
    // optionalAttrs (res."pvcTemplate" != null) {
      "pvcTemplate" = mkTablespaceStoragePvcTemplate res."pvcTemplate";
    }
    // {
    }
    // optionalAttrs (res."resizeInUseVolumes" != null) { inherit (res) "resizeInUseVolumes"; }
    // {
    }
    // optionalAttrs (res."size" != null) { inherit (res) "size"; }
    // {
    }
    // optionalAttrs (res."storageClass" != null) { inherit (res) "storageClass"; }
    // {
    };
  TablespaceStoragePvcTemplateDataSourceModule = types.submodule {
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
  mkTablespaceStoragePvcTemplateDataSource =
    res:
    {
    }
    // optionalAttrs (res."apiGroup" != null) { inherit (res) "apiGroup"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    };
  TablespaceStoragePvcTemplateDataSourceRefModule = types.submodule {
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
  mkTablespaceStoragePvcTemplateDataSourceRef =
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
  TablespaceStoragePvcTemplateModule = types.submodule {
    options = {
      "accessModes" = mkOption {
        description = "accessModes contains the desired access modes the volume should have.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1";
        type = (types.listOf types.str);
        default = [ ];
      };
      "dataSource" = mkOption {
        description = "dataSource field can be used to specify either:\n* An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot)\n* An existing PVC (PersistentVolumeClaim)\nIf the provisioner or an external controller can support the specified data source,\nit will create a new volume based on the contents of the specified data source.\nWhen the AnyVolumeDataSource feature gate is enabled, dataSource contents will be copied to dataSourceRef,\nand dataSourceRef contents will be copied to dataSource when dataSourceRef.namespace is not specified.\nIf the namespace is specified, then dataSourceRef will not be copied to dataSource.";
        type = (types.nullOr TablespaceStoragePvcTemplateDataSourceModule);
        default = null;
      };
      "dataSourceRef" = mkOption {
        description = "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty\nvolume is desired. This may be any object from a non-empty API group (non\ncore object) or a PersistentVolumeClaim object.\nWhen this field is specified, volume binding will only succeed if the type of\nthe specified object matches some installed volume populator or dynamic\nprovisioner.\nThis field will replace the functionality of the dataSource field and as such\nif both fields are non-empty, they must have the same value. For backwards\ncompatibility, when namespace isn't specified in dataSourceRef,\nboth fields (dataSource and dataSourceRef) will be set to the same\nvalue automatically if one of them is empty and the other is non-empty.\nWhen namespace is specified in dataSourceRef,\ndataSource isn't set to the same value and must be empty.\nThere are three important differences between dataSource and dataSourceRef:\n* While dataSource only allows two specific types of objects, dataSourceRef\n  allows any non-core object, as well as PersistentVolumeClaim objects.\n* While dataSource ignores disallowed values (dropping them), dataSourceRef\n  preserves all values, and generates an error if a disallowed value is\n  specified.\n* While dataSource only allows local objects, dataSourceRef allows objects\n  in any namespaces.\n(Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled.\n(Alpha) Using the namespace field of dataSourceRef requires the CrossNamespaceVolumeDataSource feature gate to be enabled.";
        type = (types.nullOr TablespaceStoragePvcTemplateDataSourceRefModule);
        default = null;
      };
      "resources" = mkOption {
        description = "resources represents the minimum resources the volume should have.\nIf RecoverVolumeExpansionFailure feature is enabled users are allowed to specify resource requirements\nthat are lower than previous value but must still be higher than capacity recorded in the\nstatus field of the claim.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources";
        type = (types.nullOr TablespaceStoragePvcTemplateResourcesModule);
        default = null;
      };
      "selector" = mkOption {
        description = "selector is a label query over volumes to consider for binding.";
        type = (types.nullOr TablespaceStoragePvcTemplateSelectorModule);
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
  mkTablespaceStoragePvcTemplate =
    res:
    {
    }
    // optionalAttrs (res."accessModes" != [ ]) { inherit (res) "accessModes"; }
    // {
    }
    // optionalAttrs (res."dataSource" != null) {
      "dataSource" = mkTablespaceStoragePvcTemplateDataSource res."dataSource";
    }
    // {
    }
    // optionalAttrs (res."dataSourceRef" != null) {
      "dataSourceRef" = mkTablespaceStoragePvcTemplateDataSourceRef res."dataSourceRef";
    }
    // {
    }
    // optionalAttrs (res."resources" != null) {
      "resources" = mkTablespaceStoragePvcTemplateResources res."resources";
    }
    // {
    }
    // optionalAttrs (res."selector" != null) {
      "selector" = mkTablespaceStoragePvcTemplateSelector res."selector";
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
  TablespaceStoragePvcTemplateResourcesModule = types.submodule {
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
  mkTablespaceStoragePvcTemplateResources =
    res:
    {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  TablespaceStoragePvcTemplateSelectorMatchExpressionModule = types.submodule {
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
  mkTablespaceStoragePvcTemplateSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  TablespaceStoragePvcTemplateSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf TablespaceStoragePvcTemplateSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkTablespaceStoragePvcTemplateSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkTablespaceStoragePvcTemplateSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
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
  WalStorageModule = types.submodule {
    options = {
      "pvcTemplate" = mkOption {
        description = "Template to be used to generate the Persistent Volume Claim";
        type = (types.nullOr WalStoragePvcTemplateModule);
        default = null;
      };
      "resizeInUseVolumes" = mkOption {
        description = "Resize existent PVCs, defaults to true";
        type = types.bool;
        default = true;
      };
      "size" = mkOption {
        description = "Size of the storage. Required if not already specified in the PVC template.\nChanges to this field are automatically reapplied to the created PVCs.\nSize cannot be decreased.";
        type = (types.nullOr types.str);
        default = null;
      };
      "storageClass" = mkOption {
        description = "StorageClass to use for PVCs. Applied after\nevaluating the PVC template, if available.\nIf not specified, the generated PVCs will use the\ndefault storage class";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkWalStorage =
    res:
    {
    }
    // optionalAttrs (res."pvcTemplate" != null) {
      "pvcTemplate" = mkWalStoragePvcTemplate res."pvcTemplate";
    }
    // {
    }
    // optionalAttrs (res."resizeInUseVolumes" != null) { inherit (res) "resizeInUseVolumes"; }
    // {
    }
    // optionalAttrs (res."size" != null) { inherit (res) "size"; }
    // {
    }
    // optionalAttrs (res."storageClass" != null) { inherit (res) "storageClass"; }
    // {
    };
  WalStoragePvcTemplateDataSourceModule = types.submodule {
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
  mkWalStoragePvcTemplateDataSource =
    res:
    {
    }
    // optionalAttrs (res."apiGroup" != null) { inherit (res) "apiGroup"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    };
  WalStoragePvcTemplateDataSourceRefModule = types.submodule {
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
  mkWalStoragePvcTemplateDataSourceRef =
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
  WalStoragePvcTemplateModule = types.submodule {
    options = {
      "accessModes" = mkOption {
        description = "accessModes contains the desired access modes the volume should have.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1";
        type = (types.listOf types.str);
        default = [ ];
      };
      "dataSource" = mkOption {
        description = "dataSource field can be used to specify either:\n* An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot)\n* An existing PVC (PersistentVolumeClaim)\nIf the provisioner or an external controller can support the specified data source,\nit will create a new volume based on the contents of the specified data source.\nWhen the AnyVolumeDataSource feature gate is enabled, dataSource contents will be copied to dataSourceRef,\nand dataSourceRef contents will be copied to dataSource when dataSourceRef.namespace is not specified.\nIf the namespace is specified, then dataSourceRef will not be copied to dataSource.";
        type = (types.nullOr WalStoragePvcTemplateDataSourceModule);
        default = null;
      };
      "dataSourceRef" = mkOption {
        description = "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty\nvolume is desired. This may be any object from a non-empty API group (non\ncore object) or a PersistentVolumeClaim object.\nWhen this field is specified, volume binding will only succeed if the type of\nthe specified object matches some installed volume populator or dynamic\nprovisioner.\nThis field will replace the functionality of the dataSource field and as such\nif both fields are non-empty, they must have the same value. For backwards\ncompatibility, when namespace isn't specified in dataSourceRef,\nboth fields (dataSource and dataSourceRef) will be set to the same\nvalue automatically if one of them is empty and the other is non-empty.\nWhen namespace is specified in dataSourceRef,\ndataSource isn't set to the same value and must be empty.\nThere are three important differences between dataSource and dataSourceRef:\n* While dataSource only allows two specific types of objects, dataSourceRef\n  allows any non-core object, as well as PersistentVolumeClaim objects.\n* While dataSource ignores disallowed values (dropping them), dataSourceRef\n  preserves all values, and generates an error if a disallowed value is\n  specified.\n* While dataSource only allows local objects, dataSourceRef allows objects\n  in any namespaces.\n(Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled.\n(Alpha) Using the namespace field of dataSourceRef requires the CrossNamespaceVolumeDataSource feature gate to be enabled.";
        type = (types.nullOr WalStoragePvcTemplateDataSourceRefModule);
        default = null;
      };
      "resources" = mkOption {
        description = "resources represents the minimum resources the volume should have.\nIf RecoverVolumeExpansionFailure feature is enabled users are allowed to specify resource requirements\nthat are lower than previous value but must still be higher than capacity recorded in the\nstatus field of the claim.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources";
        type = (types.nullOr WalStoragePvcTemplateResourcesModule);
        default = null;
      };
      "selector" = mkOption {
        description = "selector is a label query over volumes to consider for binding.";
        type = (types.nullOr WalStoragePvcTemplateSelectorModule);
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
  mkWalStoragePvcTemplate =
    res:
    {
    }
    // optionalAttrs (res."accessModes" != [ ]) { inherit (res) "accessModes"; }
    // {
    }
    // optionalAttrs (res."dataSource" != null) {
      "dataSource" = mkWalStoragePvcTemplateDataSource res."dataSource";
    }
    // {
    }
    // optionalAttrs (res."dataSourceRef" != null) {
      "dataSourceRef" = mkWalStoragePvcTemplateDataSourceRef res."dataSourceRef";
    }
    // {
    }
    // optionalAttrs (res."resources" != null) {
      "resources" = mkWalStoragePvcTemplateResources res."resources";
    }
    // {
    }
    // optionalAttrs (res."selector" != null) {
      "selector" = mkWalStoragePvcTemplateSelector res."selector";
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
  WalStoragePvcTemplateResourcesModule = types.submodule {
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
  mkWalStoragePvcTemplateResources =
    res:
    {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  WalStoragePvcTemplateSelectorMatchExpressionModule = types.submodule {
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
  mkWalStoragePvcTemplateSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  WalStoragePvcTemplateSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf WalStoragePvcTemplateSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkWalStoragePvcTemplateSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkWalStoragePvcTemplateSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ClustersModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this Cluster resource.";
        };
        "affinity" = mkOption {
          description = "Affinity/Anti-affinity rules for Pods";
          type = (types.nullOr AffinityModule);
          default = null;
        };
        "backup" = mkOption {
          description = "The configuration to be used for backups";
          type = (types.nullOr BackupModule);
          default = null;
        };
        "bootstrap" = mkOption {
          description = "Instructions to bootstrap this cluster";
          type = (types.nullOr BootstrapModule);
          default = null;
        };
        "certificates" = mkOption {
          description = "The configuration for the CA and related certificates";
          type = (types.nullOr CertificatesModule);
          default = null;
        };
        "description" = mkOption {
          description = "Description of this PostgreSQL cluster";
          type = (types.nullOr types.str);
          default = null;
        };
        "enablePDB" = mkOption {
          description = "Manage the `PodDisruptionBudget` resources within the cluster. When\nconfigured as `true` (default setting), the pod disruption budgets\nwill safeguard the primary node from being terminated. Conversely,\nsetting it to `false` will result in the absence of any\n`PodDisruptionBudget` resource, permitting the shutdown of all nodes\nhosting the PostgreSQL cluster. This latter configuration is\nadvisable for any PostgreSQL cluster employed for\ndevelopment/staging purposes.";
          type = types.bool;
          default = true;
        };
        "enableSuperuserAccess" = mkOption {
          description = "When this option is enabled, the operator will use the `SuperuserSecret`\nto update the `postgres` user password (if the secret is\nnot present, the operator will automatically create one). When this\noption is disabled, the operator will ignore the `SuperuserSecret` content, delete\nit when automatically created, and then blank the password of the `postgres`\nuser by setting it to `NULL`. Disabled by default.";
          type = types.bool;
          default = false;
        };
        "env" = mkOption {
          description = "Env follows the Env format to pass environment variables\nto the pods created in the cluster";
          type = (types.listOf EnvModule);
          default = [ ];
        };
        "envFrom" = mkOption {
          description = "EnvFrom follows the EnvFrom format to pass environment variables\nsources to the pods to be used by Env";
          type = (types.listOf EnvFromModule);
          default = [ ];
        };
        "ephemeralVolumeSource" = mkOption {
          description = "EphemeralVolumeSource allows the user to configure the source of ephemeral volumes.";
          type = (types.nullOr EphemeralVolumeSourceModule);
          default = null;
        };
        "ephemeralVolumesSizeLimit" = mkOption {
          description = "EphemeralVolumesSizeLimit allows the user to set the limits for the ephemeral\nvolumes";
          type = (types.nullOr EphemeralVolumesSizeLimitModule);
          default = null;
        };
        "externalClusters" = mkOption {
          description = "The list of external clusters which are used in the configuration";
          type = (types.listOf ExternalClusterModule);
          default = [ ];
        };
        "failoverDelay" = mkOption {
          description = "The amount of time (in seconds) to wait before triggering a failover\nafter the primary PostgreSQL instance in the cluster was detected\nto be unhealthy";
          type = (types.nullOr types.int);
          default = 0;
        };
        "imageCatalogRef" = mkOption {
          description = "Defines the major PostgreSQL version we want to use within an ImageCatalog";
          type = (types.nullOr ImageCatalogRefModule);
          default = null;
        };
        "imageName" = mkOption {
          description = "Name of the container image, supporting both tags (`<image>:<tag>`)\nand digests for deterministic and repeatable deployments\n(`<image>:<tag>@sha256:<digestValue>`)";
          type = (types.nullOr types.str);
          default = null;
        };
        "imagePullPolicy" = mkOption {
          description = "Image pull policy.\nOne of `Always`, `Never` or `IfNotPresent`.\nIf not defined, it defaults to `IfNotPresent`.\nCannot be updated.\nMore info: https://kubernetes.io/docs/concepts/containers/images#updating-images";
          type = (types.nullOr types.str);
          default = null;
        };
        "imagePullSecrets" = mkOption {
          description = "The list of pull secrets to be used to pull the images";
          type = (types.listOf ImagePullSecretModule);
          default = [ ];
        };
        "inheritedMetadata" = mkOption {
          description = "Metadata that will be inherited by all objects related to the Cluster";
          type = (types.nullOr InheritedMetadataModule);
          default = null;
        };
        "instances" = mkOption {
          description = "Number of instances required in the cluster";
          type = types.int;
        };
        "livenessProbeTimeout" = mkOption {
          description = "LivenessProbeTimeout is the time (in seconds) that is allowed for a PostgreSQL instance\nto successfully respond to the liveness probe (default 30).\nThe Liveness probe failure threshold is derived from this value using the formula:\nceiling(livenessProbe / 10).";
          type = (types.nullOr types.int);
          default = null;
        };
        "logLevel" = mkOption {
          description = "The instances' log level, one of the following values: error, warning, info (default), debug, trace";
          type = (
            types.nullOr (
              types.enum [
                "error"
                "warning"
                "info"
                "debug"
                "trace"
              ]
            )
          );
          default = "info";
        };
        "managed" = mkOption {
          description = "The configuration that is used by the portions of PostgreSQL that are managed by the instance manager";
          type = (types.nullOr ManagedModule);
          default = null;
        };
        "maxSyncReplicas" = mkOption {
          description = "The target value for the synchronous replication quorum, that can be\ndecreased if the number of ready standbys is lower than this.\nUndefined or 0 disable synchronous replication.";
          type = (types.nullOr types.int);
          default = 0;
        };
        "minSyncReplicas" = mkOption {
          description = "Minimum number of instances required in synchronous replication with the\nprimary. Undefined or 0 allow writes to complete when no standby is\navailable.";
          type = (types.nullOr types.int);
          default = 0;
        };
        "monitoring" = mkOption {
          description = "The configuration of the monitoring infrastructure of this cluster";
          type = (types.nullOr MonitoringModule);
          default = null;
        };
        "nodeMaintenanceWindow" = mkOption {
          description = "Define a maintenance window for the Kubernetes nodes";
          type = (types.nullOr NodeMaintenanceWindowModule);
          default = null;
        };
        "plugins" = mkOption {
          description = "The plugins configuration, containing\nany plugin to be loaded with the corresponding configuration";
          type = (types.listOf PluginModule);
          default = [ ];
        };
        "postgresGID" = mkOption {
          description = "The GID of the `postgres` user inside the image, defaults to `26`";
          type = (types.nullOr types.int);
          default = 26;
        };
        "postgresUID" = mkOption {
          description = "The UID of the `postgres` user inside the image, defaults to `26`";
          type = (types.nullOr types.int);
          default = 26;
        };
        "postgresql" = mkOption {
          description = "Configuration of the PostgreSQL server";
          type = (types.nullOr PostgresqlModule);
          default = null;
        };
        "primaryUpdateMethod" = mkOption {
          description = "Method to follow to upgrade the primary server during a rolling\nupdate procedure, after all replicas have been successfully updated:\nit can be with a switchover (`switchover`) or in-place (`restart` - default)";
          type = (
            types.nullOr (
              types.enum [
                "switchover"
                "restart"
              ]
            )
          );
          default = "restart";
        };
        "primaryUpdateStrategy" = mkOption {
          description = "Deployment strategy to follow to upgrade the primary server during a rolling\nupdate procedure, after all replicas have been successfully updated:\nit can be automated (`unsupervised` - default) or manual (`supervised`)";
          type = (
            types.nullOr (
              types.enum [
                "unsupervised"
                "supervised"
              ]
            )
          );
          default = "unsupervised";
        };
        "priorityClassName" = mkOption {
          description = "Name of the priority class which will be used in every generated Pod, if the PriorityClass\nspecified does not exist, the pod will not be able to schedule.  Please refer to\nhttps://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/#priorityclass\nfor more information";
          type = (types.nullOr types.str);
          default = null;
        };
        "probes" = mkOption {
          description = "The configuration of the probes to be injected\nin the PostgreSQL Pods.";
          type = (types.nullOr ProbesModule);
          default = null;
        };
        "projectedVolumeTemplate" = mkOption {
          description = "Template to be used to define projected volumes, projected volumes will be mounted\nunder `/projected` base folder";
          type = (types.nullOr ProjectedVolumeTemplateModule);
          default = null;
        };
        "replica" = mkOption {
          description = "Replica cluster configuration";
          type = (types.nullOr ReplicaModule);
          default = null;
        };
        "replicationSlots" = mkOption {
          description = "Replication slots management configuration";
          type = (types.nullOr ReplicationSlotsModule);
          default = {
            "highAvailability" = {
              "enabled" = true;
            };
          };
        };
        "resources" = mkOption {
          description = "Resources requirements of every generated Pod. Please refer to\nhttps://kubernetes.io/docs/concepts/configuration/manage-resources-containers/\nfor more information.";
          type = (types.nullOr ResourcesModule);
          default = null;
        };
        "schedulerName" = mkOption {
          description = "If specified, the pod will be dispatched by specified Kubernetes\nscheduler. If not specified, the pod will be dispatched by the default\nscheduler. More info:\nhttps://kubernetes.io/docs/concepts/scheduling-eviction/kube-scheduler/";
          type = (types.nullOr types.str);
          default = null;
        };
        "seccompProfile" = mkOption {
          description = "The SeccompProfile applied to every Pod and Container.\nDefaults to: `RuntimeDefault`";
          type = (types.nullOr SeccompProfileModule);
          default = null;
        };
        "serviceAccountTemplate" = mkOption {
          description = "Configure the generation of the service account";
          type = (types.nullOr ServiceAccountTemplateModule);
          default = null;
        };
        "smartShutdownTimeout" = mkOption {
          description = "The time in seconds that controls the window of time reserved for the smart shutdown of Postgres to complete.\nMake sure you reserve enough time for the operator to request a fast shutdown of Postgres\n(that is: `stopDelay` - `smartShutdownTimeout`).";
          type = (types.nullOr types.int);
          default = 180;
        };
        "startDelay" = mkOption {
          description = "The time in seconds that is allowed for a PostgreSQL instance to\nsuccessfully start up (default 3600).\nThe startup probe failure threshold is derived from this value using the formula:\nceiling(startDelay / 10).";
          type = (types.nullOr types.int);
          default = 3600;
        };
        "stopDelay" = mkOption {
          description = "The time in seconds that is allowed for a PostgreSQL instance to\ngracefully shutdown (default 1800)";
          type = (types.nullOr types.int);
          default = 1800;
        };
        "storage" = mkOption {
          description = "Configuration of the storage of the instances";
          type = (types.nullOr StorageModule);
          default = null;
        };
        "superuserSecret" = mkOption {
          description = "The secret containing the superuser password. If not defined a new\nsecret will be created with a randomly generated password";
          type = (types.nullOr SuperuserSecretModule);
          default = null;
        };
        "switchoverDelay" = mkOption {
          description = "The time in seconds that is allowed for a primary PostgreSQL instance\nto gracefully shutdown during a switchover.\nDefault value is 3600 seconds (1 hour).";
          type = (types.nullOr types.int);
          default = 3600;
        };
        "tablespaces" = mkOption {
          description = "The tablespaces configuration";
          type = (types.listOf TablespaceModule);
          default = [ ];
        };
        "topologySpreadConstraints" = mkOption {
          description = "TopologySpreadConstraints specifies how to spread matching pods among the given topology.\nMore info:\nhttps://kubernetes.io/docs/concepts/scheduling-eviction/topology-spread-constraints/";
          type = (types.listOf TopologySpreadConstraintModule);
          default = [ ];
        };
        "walStorage" = mkOption {
          description = "Configuration of the storage for PostgreSQL WAL (Write-Ahead Log)";
          type = (types.nullOr WalStorageModule);
          default = null;
        };
      };
    }
  );
  mkCluster = name: res: {
    apiVersion = "postgresql.cnpg.io/v1";
    kind = "Cluster";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."affinity" != null) { "affinity" = mkAffinity res."affinity"; }
    // {
    }
    // optionalAttrs (res."backup" != null) { "backup" = mkBackup res."backup"; }
    // {
    }
    // optionalAttrs (res."bootstrap" != null) { "bootstrap" = mkBootstrap res."bootstrap"; }
    // {
    }
    // optionalAttrs (res."certificates" != null) {
      "certificates" = mkCertificates res."certificates";
    }
    // {
    }
    // optionalAttrs (res."description" != null) { inherit (res) "description"; }
    // {
    }
    // optionalAttrs (res."enablePDB" != null) { inherit (res) "enablePDB"; }
    // {
    }
    // optionalAttrs res."enableSuperuserAccess" { inherit (res) "enableSuperuserAccess"; }
    // {
    }
    // optionalAttrs (res."env" != [ ]) { "env" = map mkEnv res."env"; }
    // {
    }
    // optionalAttrs (res."envFrom" != [ ]) { "envFrom" = map mkEnvFrom res."envFrom"; }
    // {
    }
    // optionalAttrs (res."ephemeralVolumeSource" != null) {
      "ephemeralVolumeSource" = mkEphemeralVolumeSource res."ephemeralVolumeSource";
    }
    // {
    }
    // optionalAttrs (res."ephemeralVolumesSizeLimit" != null) {
      "ephemeralVolumesSizeLimit" = mkEphemeralVolumesSizeLimit res."ephemeralVolumesSizeLimit";
    }
    // {
    }
    // optionalAttrs (res."externalClusters" != [ ]) {
      "externalClusters" = map mkExternalCluster res."externalClusters";
    }
    // {
    }
    // optionalAttrs (res."failoverDelay" != null) { inherit (res) "failoverDelay"; }
    // {
    }
    // optionalAttrs (res."imageCatalogRef" != null) {
      "imageCatalogRef" = mkImageCatalogRef res."imageCatalogRef";
    }
    // {
    }
    // optionalAttrs (res."imageName" != null) { inherit (res) "imageName"; }
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
    // optionalAttrs (res."inheritedMetadata" != null) {
      "inheritedMetadata" = mkInheritedMetadata res."inheritedMetadata";
    }
    // {
      inherit (res) "instances";
    }
    // optionalAttrs (res."livenessProbeTimeout" != null) { inherit (res) "livenessProbeTimeout"; }
    // {
    }
    // optionalAttrs (res."logLevel" != null) { inherit (res) "logLevel"; }
    // {
    }
    // optionalAttrs (res."managed" != null) { "managed" = mkManaged res."managed"; }
    // {
    }
    // optionalAttrs (res."maxSyncReplicas" != null) { inherit (res) "maxSyncReplicas"; }
    // {
    }
    // optionalAttrs (res."minSyncReplicas" != null) { inherit (res) "minSyncReplicas"; }
    // {
    }
    // optionalAttrs (res."monitoring" != null) { "monitoring" = mkMonitoring res."monitoring"; }
    // {
    }
    // optionalAttrs (res."nodeMaintenanceWindow" != null) {
      "nodeMaintenanceWindow" = mkNodeMaintenanceWindow res."nodeMaintenanceWindow";
    }
    // {
    }
    // optionalAttrs (res."plugins" != [ ]) { "plugins" = map mkPlugin res."plugins"; }
    // {
    }
    // optionalAttrs (res."postgresGID" != null) { inherit (res) "postgresGID"; }
    // {
    }
    // optionalAttrs (res."postgresUID" != null) { inherit (res) "postgresUID"; }
    // {
    }
    // optionalAttrs (res."postgresql" != null) { "postgresql" = mkPostgresql res."postgresql"; }
    // {
    }
    // optionalAttrs (res."primaryUpdateMethod" != null) { inherit (res) "primaryUpdateMethod"; }
    // {
    }
    // optionalAttrs (res."primaryUpdateStrategy" != null) { inherit (res) "primaryUpdateStrategy"; }
    // {
    }
    // optionalAttrs (res."priorityClassName" != null) { inherit (res) "priorityClassName"; }
    // {
    }
    // optionalAttrs (res."probes" != null) { "probes" = mkProbes res."probes"; }
    // {
    }
    // optionalAttrs (res."projectedVolumeTemplate" != null) {
      "projectedVolumeTemplate" = mkProjectedVolumeTemplate res."projectedVolumeTemplate";
    }
    // {
    }
    // optionalAttrs (res."replica" != null) { "replica" = mkReplica res."replica"; }
    // {
    }
    // optionalAttrs (res."replicationSlots" != null) {
      "replicationSlots" = mkReplicationSlots res."replicationSlots";
    }
    // {
    }
    // optionalAttrs (res."resources" != null) { "resources" = mkResources res."resources"; }
    // {
    }
    // optionalAttrs (res."schedulerName" != null) { inherit (res) "schedulerName"; }
    // {
    }
    // optionalAttrs (res."seccompProfile" != null) {
      "seccompProfile" = mkSeccompProfile res."seccompProfile";
    }
    // {
    }
    // optionalAttrs (res."serviceAccountTemplate" != null) {
      "serviceAccountTemplate" = mkServiceAccountTemplate res."serviceAccountTemplate";
    }
    // {
    }
    // optionalAttrs (res."smartShutdownTimeout" != null) { inherit (res) "smartShutdownTimeout"; }
    // {
    }
    // optionalAttrs (res."startDelay" != null) { inherit (res) "startDelay"; }
    // {
    }
    // optionalAttrs (res."stopDelay" != null) { inherit (res) "stopDelay"; }
    // {
    }
    // optionalAttrs (res."storage" != null) { "storage" = mkStorage res."storage"; }
    // {
    }
    // optionalAttrs (res."superuserSecret" != null) {
      "superuserSecret" = mkSuperuserSecret res."superuserSecret";
    }
    // {
    }
    // optionalAttrs (res."switchoverDelay" != null) { inherit (res) "switchoverDelay"; }
    // {
    }
    // optionalAttrs (res."tablespaces" != [ ]) { "tablespaces" = map mkTablespace res."tablespaces"; }
    // {
    }
    // optionalAttrs (res."topologySpreadConstraints" != [ ]) {
      "topologySpreadConstraints" = map mkTopologySpreadConstraint res."topologySpreadConstraints";
    }
    // {
    }
    // optionalAttrs (res."walStorage" != null) { "walStorage" = mkWalStorage res."walStorage"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkCluster cfg."clusters");
in
{
  options.openkrill.apps."cloudnative-pg" = {
    "clusters" = mkOption {
      type = types.attrsOf ClustersModule;
      default = { };
      description = "Cluster CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."cloudnative-pg".content = allResources;
  };
}
