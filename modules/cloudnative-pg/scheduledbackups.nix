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
  ScheduledbackupsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this ScheduledBackup resource.";
        };
        "backupOwnerReference" = mkOption {
          description = "Indicates which ownerReference should be put inside the created backup resources.<br />\n- none: no owner reference for created backup objects (same behavior as before the field was introduced)<br />\n- self: sets the Scheduled backup object as owner of the backup<br />\n- cluster: set the cluster as owner of the backup<br />";
          type = (
            types.nullOr (
              types.enum [
                "none"
                "self"
                "cluster"
              ]
            )
          );
          default = "none";
        };
        "cluster" = mkOption {
          description = "The cluster to backup";
          type = ClusterModule;
        };
        "immediate" = mkOption {
          description = "If the first backup has to be immediately start after creation or not";
          type = types.bool;
          default = false;
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
        "schedule" = mkOption {
          description = "The schedule does not follow the same format used in Kubernetes CronJobs\nas it includes an additional seconds specifier,\nsee https://pkg.go.dev/github.com/robfig/cron#hdr-CRON_Expression_Format";
          type = types.str;
        };
        "suspend" = mkOption {
          description = "If this backup is suspended or not";
          type = types.bool;
          default = false;
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
  mkScheduledBackup = name: res: {
    apiVersion = "postgresql.cnpg.io/v1";
    kind = "ScheduledBackup";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."backupOwnerReference" != null) { inherit (res) "backupOwnerReference"; }
    // {
      "cluster" = mkCluster res."cluster";
    }
    // optionalAttrs res."immediate" { inherit (res) "immediate"; }
    // {
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
      inherit (res) "schedule";
    }
    // optionalAttrs res."suspend" { inherit (res) "suspend"; }
    // {
    }
    // optionalAttrs (res."target" != null) { inherit (res) "target"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkScheduledBackup cfg."scheduledbackups");
in
{
  options.openkrill.apps."cloudnative-pg" = {
    "scheduledbackups" = mkOption {
      type = types.attrsOf ScheduledbackupsModule;
      default = { };
      description = "ScheduledBackup CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."cloudnative-pg".content = allResources;
  };
}
