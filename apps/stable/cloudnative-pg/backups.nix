# Auto-generated openkrill module fragment for cloudnative-pg
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."cloudnative-pg";
  compact = filterAttrs (_: v: v != null);
  ClusterModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkCluster = res: {
    inherit (res) "name";
  };
  OnlineConfigurationModule = types.submodule {
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
  mkOnlineConfiguration =
    res:
    {
    }
    // optionalAttrs res."immediateCheckpoint" { inherit (res) "immediateCheckpoint"; }
    // {
    }
    // optionalAttrs (res."waitForArchive" != null) { inherit (res) "waitForArchive"; }
    // {
    };
  PluginConfigurationModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the name of the plugin managing this backup";
        type = types.str;
      };
      "parameters" = mkOption {
        description = "Parameters are the configuration parameters passed to the backup\nplugin for this backup";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkPluginConfiguration =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."parameters" != { }) { inherit (res) "parameters"; }
    // {
    };
  BackupsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this Backup resource.";
        };
        "cluster" = mkOption {
          description = "The cluster to backup";
          type = ClusterModule;
        };
        "method" = mkOption {
          description = "The backup method to be used, possible options are `barmanObjectStore`,\n`volumeSnapshot` or `plugin`. Defaults to: `barmanObjectStore`.";
          type = (
            types.nullOr (
              types.enum [
                "barmanObjectStore"
                "volumeSnapshot"
                "plugin"
              ]
            )
          );
          default = "barmanObjectStore";
        };
        "online" = mkOption {
          description = "Whether the default type of backup with volume snapshots is\nonline/hot (`true`, default) or offline/cold (`false`)\nOverrides the default setting specified in the cluster field '.spec.backup.volumeSnapshot.online'";
          type = types.bool;
          default = false;
        };
        "onlineConfiguration" = mkOption {
          description = "Configuration parameters to control the online/hot backup with volume snapshots\nOverrides the default settings specified in the cluster '.backup.volumeSnapshot.onlineConfiguration' stanza";
          type = (types.nullOr OnlineConfigurationModule);
          default = null;
        };
        "pluginConfiguration" = mkOption {
          description = "Configuration parameters passed to the plugin managing this backup";
          type = (types.nullOr PluginConfigurationModule);
          default = null;
        };
        "target" = mkOption {
          description = "The policy to decide which instance should perform this backup. If empty,\nit defaults to `cluster.spec.backup.target`.\nAvailable options are empty string, `primary` and `prefer-standby`.\n`primary` to have backups run always on primary instances,\n`prefer-standby` to have backups run preferably on the most updated\nstandby, if available.";
          type = (
            types.nullOr (
              types.enum [
                "primary"
                "prefer-standby"
              ]
            )
          );
          default = null;
        };
      };
    }
  );
  mkBackup = name: res: {
    apiVersion = "postgresql.cnpg.io/v1";
    kind = "Backup";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
      "cluster" = mkCluster res."cluster";
    }
    // optionalAttrs (res."method" != null) { inherit (res) "method"; }
    // {
    }
    // optionalAttrs res."online" { inherit (res) "online"; }
    // {
    }
    // optionalAttrs (res."onlineConfiguration" != null) {
      "onlineConfiguration" = mkOnlineConfiguration res."onlineConfiguration";
    }
    // {
    }
    // optionalAttrs (res."pluginConfiguration" != null) {
      "pluginConfiguration" = mkPluginConfiguration res."pluginConfiguration";
    }
    // {
    }
    // optionalAttrs (res."target" != null) { inherit (res) "target"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkBackup cfg."backups");
in
{
  options.openkrill.apps."cloudnative-pg" = {
    "backups" = mkOption {
      type = types.attrsOf BackupsModule;
      default = { };
      description = "Backup CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."cloudnative-pg".content = allResources;
  };
}
