# Auto-generated openkrill module fragment for victoriametrics
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."victoriametrics";
  compact = filterAttrs (_: v: v != null);
  GroupModule = types.submodule {
    options = {
      "concurrency" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "eval_alignment" = mkOption {
        type = types.bool;
        default = false;
      };
      "eval_delay" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "eval_offset" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "headers" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "interval" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "labels" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "limit" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "name" = mkOption {
        type = types.str;
      };
      "notifier_headers" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "params" = mkOption {
        type = (types.attrsOf (types.listOf types.str));
        default = { };
      };
      "rules" = mkOption {
        type = (types.listOf GroupRuleModule);
      };
      "tenant" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkGroup =
    res:
    {
    }
    // optionalAttrs (res."concurrency" != null) { inherit (res) "concurrency"; }
    // {
    }
    // optionalAttrs res."eval_alignment" { inherit (res) "eval_alignment"; }
    // {
    }
    // optionalAttrs (res."eval_delay" != null) { inherit (res) "eval_delay"; }
    // {
    }
    // optionalAttrs (res."eval_offset" != null) { inherit (res) "eval_offset"; }
    // {
    }
    // optionalAttrs (res."headers" != [ ]) { inherit (res) "headers"; }
    // {
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
    // optionalAttrs (res."notifier_headers" != [ ]) { inherit (res) "notifier_headers"; }
    // {
    }
    // optionalAttrs (res."params" != { }) { inherit (res) "params"; }
    // {
      "rules" = map mkGroupRule res."rules";
    }
    // optionalAttrs (res."tenant" != null) { inherit (res) "tenant"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  GroupRuleModule = types.submodule {
    options = {
      "alert" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "annotations" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "debug" = mkOption {
        type = types.bool;
        default = false;
      };
      "expr" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "for" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "keep_firing_for" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "labels" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "record" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "update_entries_limit" = mkOption {
        type = (types.nullOr types.int);
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
    }
    // optionalAttrs res."debug" { inherit (res) "debug"; }
    // {
    }
    // optionalAttrs (res."expr" != null) { inherit (res) "expr"; }
    // {
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
    }
    // optionalAttrs (res."update_entries_limit" != null) { inherit (res) "update_entries_limit"; }
    // {
    };
  VmrulesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this VMRule resource.";
        };
        "groups" = mkOption {
          type = (types.listOf GroupModule);
        };
      };
    }
  );
  mkVMRule = name: res: {
    apiVersion = "operator.victoriametrics.com/v1beta1";
    kind = "VMRule";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
      "groups" = map mkGroup res."groups";
    };
  };
  allResources = (mapAttrsToList mkVMRule cfg."vmrules");
in
{
  options.openkrill.apps."victoriametrics" = {
    "vmrules" = mkOption {
      type = types.attrsOf VmrulesModule;
      default = { };
      description = "VMRule CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."victoriametrics".content = allResources;
  };
}
