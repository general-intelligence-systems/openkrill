# Auto-generated openkrill module fragment for metacontroller
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."metacontroller";
  compact = filterAttrs (_: v: v != null);
  AttachmentModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        type = types.str;
      };
      "resource" = mkOption {
        type = types.str;
      };
      "updateStrategy" = mkOption {
        type = (types.nullOr AttachmentUpdateStrategyModule);
        default = null;
      };
    };
  };
  mkAttachment =
    res:
    {
      inherit (res) "apiVersion";
      inherit (res) "resource";
    }
    // optionalAttrs (res."updateStrategy" != null) {
      "updateStrategy" = mkAttachmentUpdateStrategy res."updateStrategy";
    }
    // {
    };
  AttachmentUpdateStrategyModule = types.submodule {
    options = {
      "method" = mkOption {
        type = (
          types.nullOr (
            types.enum [
              "OnDelete"
              "Recreate"
              "InPlace"
              "RollingRecreate"
              "RollingInPlace"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkAttachmentUpdateStrategy =
    res:
    {
    }
    // optionalAttrs (res."method" != null) { inherit (res) "method"; }
    // {
    };
  HooksCustomizeModule = types.submodule {
    options = {
      "version" = mkOption {
        type = (
          types.nullOr (
            types.enum [
              "v1"
              "v2"
            ]
          )
        );
        default = "v1";
      };
      "webhook" = mkOption {
        type = (types.nullOr HooksCustomizeWebhookModule);
        default = null;
      };
    };
  };
  mkHooksCustomize =
    res:
    {
    }
    // optionalAttrs (res."version" != null) { inherit (res) "version"; }
    // {
    }
    // optionalAttrs (res."webhook" != null) { "webhook" = mkHooksCustomizeWebhook res."webhook"; }
    // {
    };
  HooksCustomizeWebhookEtagModule = types.submodule {
    options = {
      "cacheCleanupSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "cacheTimeoutSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "enabled" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkHooksCustomizeWebhookEtag =
    res:
    {
    }
    // optionalAttrs (res."cacheCleanupSeconds" != null) { inherit (res) "cacheCleanupSeconds"; }
    // {
    }
    // optionalAttrs (res."cacheTimeoutSeconds" != null) { inherit (res) "cacheTimeoutSeconds"; }
    // {
    }
    // optionalAttrs res."enabled" { inherit (res) "enabled"; }
    // {
    };
  HooksCustomizeWebhookModule = types.submodule {
    options = {
      "etag" = mkOption {
        type = (types.nullOr HooksCustomizeWebhookEtagModule);
        default = null;
      };
      "path" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "responseUnMarshallMode" = mkOption {
        description = "Sets the json unmarshall mode. One of the 'loose' or 'strict'. In 'strict'\nmode additional checks are performed to detect unknown and duplicated fields.";
        type = (
          types.nullOr (
            types.enum [
              "loose"
              "strict"
            ]
          )
        );
        default = null;
      };
      "service" = mkOption {
        type = (types.nullOr HooksCustomizeWebhookServiceModule);
        default = null;
      };
      "timeout" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkHooksCustomizeWebhook =
    res:
    {
    }
    // optionalAttrs (res."etag" != null) { "etag" = mkHooksCustomizeWebhookEtag res."etag"; }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs (res."responseUnMarshallMode" != null) { inherit (res) "responseUnMarshallMode"; }
    // {
    }
    // optionalAttrs (res."service" != null) {
      "service" = mkHooksCustomizeWebhookService res."service";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    }
    // optionalAttrs (res."url" != null) { inherit (res) "url"; }
    // {
    };
  HooksCustomizeWebhookServiceModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "namespace" = mkOption {
        type = types.str;
      };
      "port" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "protocol" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkHooksCustomizeWebhookService =
    res:
    {
      inherit (res) "name";
      inherit (res) "namespace";
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
    }
    // optionalAttrs (res."protocol" != null) { inherit (res) "protocol"; }
    // {
    };
  HooksFinalizeModule = types.submodule {
    options = {
      "version" = mkOption {
        type = (
          types.nullOr (
            types.enum [
              "v1"
              "v2"
            ]
          )
        );
        default = "v1";
      };
      "webhook" = mkOption {
        type = (types.nullOr HooksFinalizeWebhookModule);
        default = null;
      };
    };
  };
  mkHooksFinalize =
    res:
    {
    }
    // optionalAttrs (res."version" != null) { inherit (res) "version"; }
    // {
    }
    // optionalAttrs (res."webhook" != null) { "webhook" = mkHooksFinalizeWebhook res."webhook"; }
    // {
    };
  HooksFinalizeWebhookEtagModule = types.submodule {
    options = {
      "cacheCleanupSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "cacheTimeoutSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "enabled" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkHooksFinalizeWebhookEtag =
    res:
    {
    }
    // optionalAttrs (res."cacheCleanupSeconds" != null) { inherit (res) "cacheCleanupSeconds"; }
    // {
    }
    // optionalAttrs (res."cacheTimeoutSeconds" != null) { inherit (res) "cacheTimeoutSeconds"; }
    // {
    }
    // optionalAttrs res."enabled" { inherit (res) "enabled"; }
    // {
    };
  HooksFinalizeWebhookModule = types.submodule {
    options = {
      "etag" = mkOption {
        type = (types.nullOr HooksFinalizeWebhookEtagModule);
        default = null;
      };
      "path" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "responseUnMarshallMode" = mkOption {
        description = "Sets the json unmarshall mode. One of the 'loose' or 'strict'. In 'strict'\nmode additional checks are performed to detect unknown and duplicated fields.";
        type = (
          types.nullOr (
            types.enum [
              "loose"
              "strict"
            ]
          )
        );
        default = null;
      };
      "service" = mkOption {
        type = (types.nullOr HooksFinalizeWebhookServiceModule);
        default = null;
      };
      "timeout" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkHooksFinalizeWebhook =
    res:
    {
    }
    // optionalAttrs (res."etag" != null) { "etag" = mkHooksFinalizeWebhookEtag res."etag"; }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs (res."responseUnMarshallMode" != null) { inherit (res) "responseUnMarshallMode"; }
    // {
    }
    // optionalAttrs (res."service" != null) {
      "service" = mkHooksFinalizeWebhookService res."service";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    }
    // optionalAttrs (res."url" != null) { inherit (res) "url"; }
    // {
    };
  HooksFinalizeWebhookServiceModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "namespace" = mkOption {
        type = types.str;
      };
      "port" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "protocol" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkHooksFinalizeWebhookService =
    res:
    {
      inherit (res) "name";
      inherit (res) "namespace";
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
    }
    // optionalAttrs (res."protocol" != null) { inherit (res) "protocol"; }
    // {
    };
  HooksModule = types.submodule {
    options = {
      "customize" = mkOption {
        type = (types.nullOr HooksCustomizeModule);
        default = null;
      };
      "finalize" = mkOption {
        type = (types.nullOr HooksFinalizeModule);
        default = null;
      };
      "sync" = mkOption {
        type = (types.nullOr HooksSyncModule);
        default = null;
      };
    };
  };
  mkHooks =
    res:
    {
    }
    // optionalAttrs (res."customize" != null) { "customize" = mkHooksCustomize res."customize"; }
    // {
    }
    // optionalAttrs (res."finalize" != null) { "finalize" = mkHooksFinalize res."finalize"; }
    // {
    }
    // optionalAttrs (res."sync" != null) { "sync" = mkHooksSync res."sync"; }
    // {
    };
  HooksSyncModule = types.submodule {
    options = {
      "version" = mkOption {
        type = (
          types.nullOr (
            types.enum [
              "v1"
              "v2"
            ]
          )
        );
        default = "v1";
      };
      "webhook" = mkOption {
        type = (types.nullOr HooksSyncWebhookModule);
        default = null;
      };
    };
  };
  mkHooksSync =
    res:
    {
    }
    // optionalAttrs (res."version" != null) { inherit (res) "version"; }
    // {
    }
    // optionalAttrs (res."webhook" != null) { "webhook" = mkHooksSyncWebhook res."webhook"; }
    // {
    };
  HooksSyncWebhookEtagModule = types.submodule {
    options = {
      "cacheCleanupSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "cacheTimeoutSeconds" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "enabled" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkHooksSyncWebhookEtag =
    res:
    {
    }
    // optionalAttrs (res."cacheCleanupSeconds" != null) { inherit (res) "cacheCleanupSeconds"; }
    // {
    }
    // optionalAttrs (res."cacheTimeoutSeconds" != null) { inherit (res) "cacheTimeoutSeconds"; }
    // {
    }
    // optionalAttrs res."enabled" { inherit (res) "enabled"; }
    // {
    };
  HooksSyncWebhookModule = types.submodule {
    options = {
      "etag" = mkOption {
        type = (types.nullOr HooksSyncWebhookEtagModule);
        default = null;
      };
      "path" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "responseUnMarshallMode" = mkOption {
        description = "Sets the json unmarshall mode. One of the 'loose' or 'strict'. In 'strict'\nmode additional checks are performed to detect unknown and duplicated fields.";
        type = (
          types.nullOr (
            types.enum [
              "loose"
              "strict"
            ]
          )
        );
        default = null;
      };
      "service" = mkOption {
        type = (types.nullOr HooksSyncWebhookServiceModule);
        default = null;
      };
      "timeout" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkHooksSyncWebhook =
    res:
    {
    }
    // optionalAttrs (res."etag" != null) { "etag" = mkHooksSyncWebhookEtag res."etag"; }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs (res."responseUnMarshallMode" != null) { inherit (res) "responseUnMarshallMode"; }
    // {
    }
    // optionalAttrs (res."service" != null) { "service" = mkHooksSyncWebhookService res."service"; }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    }
    // optionalAttrs (res."url" != null) { inherit (res) "url"; }
    // {
    };
  HooksSyncWebhookServiceModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "namespace" = mkOption {
        type = types.str;
      };
      "port" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "protocol" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkHooksSyncWebhookService =
    res:
    {
      inherit (res) "name";
      inherit (res) "namespace";
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
    }
    // optionalAttrs (res."protocol" != null) { inherit (res) "protocol"; }
    // {
    };
  ResourceAnnotationSelectorMatchExpressionModule = types.submodule {
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
  mkResourceAnnotationSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ResourceAnnotationSelectorModule = types.submodule {
    options = {
      "matchAnnotations" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "matchExpressions" = mkOption {
        type = (types.listOf ResourceAnnotationSelectorMatchExpressionModule);
        default = [ ];
      };
    };
  };
  mkResourceAnnotationSelector =
    res:
    {
    }
    // optionalAttrs (res."matchAnnotations" != { }) { inherit (res) "matchAnnotations"; }
    // {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkResourceAnnotationSelectorMatchExpression res."matchExpressions";
    }
    // {
    };
  ResourceLabelSelectorMatchExpressionModule = types.submodule {
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
  mkResourceLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ResourceLabelSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf ResourceLabelSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkResourceLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkResourceLabelSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ResourceModule = types.submodule {
    options = {
      "annotationSelector" = mkOption {
        type = (types.nullOr ResourceAnnotationSelectorModule);
        default = null;
      };
      "apiVersion" = mkOption {
        type = types.str;
      };
      "ignoreStatusChanges" = mkOption {
        type = types.bool;
        default = false;
      };
      "labelSelector" = mkOption {
        description = "A label selector is a label query over a set of resources. The result of matchLabels and\nmatchExpressions are ANDed. An empty label selector matches all objects. A null\nlabel selector matches no objects.";
        type = (types.nullOr ResourceLabelSelectorModule);
        default = null;
      };
      "resource" = mkOption {
        type = types.str;
      };
    };
  };
  mkResource =
    res:
    {
    }
    // optionalAttrs (res."annotationSelector" != null) {
      "annotationSelector" = mkResourceAnnotationSelector res."annotationSelector";
    }
    // {
      inherit (res) "apiVersion";
    }
    // optionalAttrs res."ignoreStatusChanges" { inherit (res) "ignoreStatusChanges"; }
    // {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" = mkResourceLabelSelector res."labelSelector";
    }
    // {
      inherit (res) "resource";
    };
  DecoratorcontrollersModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this DecoratorController resource.";
        };
        "attachments" = mkOption {
          type = (types.listOf AttachmentModule);
          default = [ ];
        };
        "hooks" = mkOption {
          type = (types.nullOr HooksModule);
          default = null;
        };
        "resources" = mkOption {
          type = (types.listOf ResourceModule);
        };
        "resyncPeriodSeconds" = mkOption {
          type = (types.nullOr types.int);
          default = null;
        };
      };
    }
  );
  mkDecoratorController = name: res: {
    apiVersion = "metacontroller.k8s.io/v1alpha1";
    kind = "DecoratorController";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."attachments" != [ ]) { "attachments" = map mkAttachment res."attachments"; }
    // {
    }
    // optionalAttrs (res."hooks" != null) { "hooks" = mkHooks res."hooks"; }
    // {
      "resources" = map mkResource res."resources";
    }
    // optionalAttrs (res."resyncPeriodSeconds" != null) { inherit (res) "resyncPeriodSeconds"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkDecoratorController cfg."decoratorcontrollers");
in
{
  options.openkrill.apps."metacontroller" = {
    "decoratorcontrollers" = mkOption {
      type = types.attrsOf DecoratorcontrollersModule;
      default = { };
      description = "DecoratorController CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."metacontroller".content = allResources;
  };
}
