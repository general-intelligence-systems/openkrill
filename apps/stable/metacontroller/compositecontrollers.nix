# Auto-generated openkrill module fragment for metacontroller
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."metacontroller";
  compact = filterAttrs (_: v: v != null);
  ChildResourceModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        type = types.str;
      };
      "resource" = mkOption {
        type = types.str;
      };
      "updateStrategy" = mkOption {
        type = (types.nullOr ChildResourceUpdateStrategyModule);
        default = null;
      };
    };
  };
  mkChildResource =
    res:
    {
      inherit (res) "apiVersion";
      inherit (res) "resource";
    }
    // optionalAttrs (res."updateStrategy" != null) {
      "updateStrategy" = mkChildResourceUpdateStrategy res."updateStrategy";
    }
    // {
    };
  ChildResourceUpdateStrategyModule = types.submodule {
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
      "statusChecks" = mkOption {
        type = (types.nullOr ChildResourceUpdateStrategyStatusChecksModule);
        default = null;
      };
    };
  };
  mkChildResourceUpdateStrategy =
    res:
    {
    }
    // optionalAttrs (res."method" != null) { inherit (res) "method"; }
    // {
    }
    // optionalAttrs (res."statusChecks" != null) {
      "statusChecks" = mkChildResourceUpdateStrategyStatusChecks res."statusChecks";
    }
    // {
    };
  ChildResourceUpdateStrategyStatusChecksConditionModule = types.submodule {
    options = {
      "reason" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "status" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        type = types.str;
      };
    };
  };
  mkChildResourceUpdateStrategyStatusChecksCondition =
    res:
    {
    }
    // optionalAttrs (res."reason" != null) { inherit (res) "reason"; }
    // {
    }
    // optionalAttrs (res."status" != null) { inherit (res) "status"; }
    // {
      inherit (res) "type";
    };
  ChildResourceUpdateStrategyStatusChecksModule = types.submodule {
    options = {
      "conditions" = mkOption {
        type = (types.listOf ChildResourceUpdateStrategyStatusChecksConditionModule);
        default = [ ];
      };
    };
  };
  mkChildResourceUpdateStrategyStatusChecks =
    res:
    {
    }
    // optionalAttrs (res."conditions" != [ ]) {
      "conditions" = map mkChildResourceUpdateStrategyStatusChecksCondition res."conditions";
    }
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
      "postUpdateChild" = mkOption {
        type = (types.nullOr HooksPostUpdateChildModule);
        default = null;
      };
      "preUpdateChild" = mkOption {
        type = (types.nullOr HooksPreUpdateChildModule);
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
    // optionalAttrs (res."postUpdateChild" != null) {
      "postUpdateChild" = mkHooksPostUpdateChild res."postUpdateChild";
    }
    // {
    }
    // optionalAttrs (res."preUpdateChild" != null) {
      "preUpdateChild" = mkHooksPreUpdateChild res."preUpdateChild";
    }
    // {
    }
    // optionalAttrs (res."sync" != null) { "sync" = mkHooksSync res."sync"; }
    // {
    };
  HooksPostUpdateChildModule = types.submodule {
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
        type = (types.nullOr HooksPostUpdateChildWebhookModule);
        default = null;
      };
    };
  };
  mkHooksPostUpdateChild =
    res:
    {
    }
    // optionalAttrs (res."version" != null) { inherit (res) "version"; }
    // {
    }
    // optionalAttrs (res."webhook" != null) {
      "webhook" = mkHooksPostUpdateChildWebhook res."webhook";
    }
    // {
    };
  HooksPostUpdateChildWebhookEtagModule = types.submodule {
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
  mkHooksPostUpdateChildWebhookEtag =
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
  HooksPostUpdateChildWebhookModule = types.submodule {
    options = {
      "etag" = mkOption {
        type = (types.nullOr HooksPostUpdateChildWebhookEtagModule);
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
        type = (types.nullOr HooksPostUpdateChildWebhookServiceModule);
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
  mkHooksPostUpdateChildWebhook =
    res:
    {
    }
    // optionalAttrs (res."etag" != null) { "etag" = mkHooksPostUpdateChildWebhookEtag res."etag"; }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs (res."responseUnMarshallMode" != null) { inherit (res) "responseUnMarshallMode"; }
    // {
    }
    // optionalAttrs (res."service" != null) {
      "service" = mkHooksPostUpdateChildWebhookService res."service";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    }
    // optionalAttrs (res."url" != null) { inherit (res) "url"; }
    // {
    };
  HooksPostUpdateChildWebhookServiceModule = types.submodule {
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
  mkHooksPostUpdateChildWebhookService =
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
  HooksPreUpdateChildModule = types.submodule {
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
        type = (types.nullOr HooksPreUpdateChildWebhookModule);
        default = null;
      };
    };
  };
  mkHooksPreUpdateChild =
    res:
    {
    }
    // optionalAttrs (res."version" != null) { inherit (res) "version"; }
    // {
    }
    // optionalAttrs (res."webhook" != null) { "webhook" = mkHooksPreUpdateChildWebhook res."webhook"; }
    // {
    };
  HooksPreUpdateChildWebhookEtagModule = types.submodule {
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
  mkHooksPreUpdateChildWebhookEtag =
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
  HooksPreUpdateChildWebhookModule = types.submodule {
    options = {
      "etag" = mkOption {
        type = (types.nullOr HooksPreUpdateChildWebhookEtagModule);
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
        type = (types.nullOr HooksPreUpdateChildWebhookServiceModule);
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
  mkHooksPreUpdateChildWebhook =
    res:
    {
    }
    // optionalAttrs (res."etag" != null) { "etag" = mkHooksPreUpdateChildWebhookEtag res."etag"; }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs (res."responseUnMarshallMode" != null) { inherit (res) "responseUnMarshallMode"; }
    // {
    }
    // optionalAttrs (res."service" != null) {
      "service" = mkHooksPreUpdateChildWebhookService res."service";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    }
    // optionalAttrs (res."url" != null) { inherit (res) "url"; }
    // {
    };
  HooksPreUpdateChildWebhookServiceModule = types.submodule {
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
  mkHooksPreUpdateChildWebhookService =
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
  ParentResourceLabelSelectorMatchExpressionModule = types.submodule {
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
  mkParentResourceLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ParentResourceLabelSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf ParentResourceLabelSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkParentResourceLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkParentResourceLabelSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ParentResourceModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        type = types.str;
      };
      "ignoreStatusChanges" = mkOption {
        type = types.bool;
        default = false;
      };
      "labelSelector" = mkOption {
        description = "A label selector is a label query over a set of resources. The result of matchLabels and\nmatchExpressions are ANDed. An empty label selector matches all objects. A null\nlabel selector matches no objects.";
        type = (types.nullOr ParentResourceLabelSelectorModule);
        default = null;
      };
      "resource" = mkOption {
        type = types.str;
      };
      "revisionHistory" = mkOption {
        type = (types.nullOr ParentResourceRevisionHistoryModule);
        default = null;
      };
    };
  };
  mkParentResource =
    res:
    {
      inherit (res) "apiVersion";
    }
    // optionalAttrs res."ignoreStatusChanges" { inherit (res) "ignoreStatusChanges"; }
    // {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" = mkParentResourceLabelSelector res."labelSelector";
    }
    // {
      inherit (res) "resource";
    }
    // optionalAttrs (res."revisionHistory" != null) {
      "revisionHistory" = mkParentResourceRevisionHistory res."revisionHistory";
    }
    // {
    };
  ParentResourceRevisionHistoryModule = types.submodule {
    options = {
      "fieldPaths" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkParentResourceRevisionHistory =
    res:
    {
    }
    // optionalAttrs (res."fieldPaths" != [ ]) { inherit (res) "fieldPaths"; }
    // {
    };
  CompositecontrollersModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this CompositeController resource.";
        };
        "childResources" = mkOption {
          type = (types.listOf ChildResourceModule);
          default = [ ];
        };
        "generateSelector" = mkOption {
          type = types.bool;
          default = false;
        };
        "hooks" = mkOption {
          type = (types.nullOr HooksModule);
          default = null;
        };
        "parentResource" = mkOption {
          type = ParentResourceModule;
        };
        "resyncPeriodSeconds" = mkOption {
          type = (types.nullOr types.int);
          default = null;
        };
      };
    }
  );
  mkCompositeController = name: res: {
    apiVersion = "metacontroller.k8s.io/v1alpha1";
    kind = "CompositeController";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."childResources" != [ ]) {
      "childResources" = map mkChildResource res."childResources";
    }
    // {
    }
    // optionalAttrs res."generateSelector" { inherit (res) "generateSelector"; }
    // {
    }
    // optionalAttrs (res."hooks" != null) { "hooks" = mkHooks res."hooks"; }
    // {
      "parentResource" = mkParentResource res."parentResource";
    }
    // optionalAttrs (res."resyncPeriodSeconds" != null) { inherit (res) "resyncPeriodSeconds"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkCompositeController cfg."compositecontrollers");
in
{
  options.openkrill.apps."metacontroller" = {
    "compositecontrollers" = mkOption {
      type = types.attrsOf CompositecontrollersModule;
      default = { };
      description = "CompositeController CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."metacontroller".content = allResources;
  };
}
