# apps/stable/velero/values.nix — Helm values schema for Velero
{ lib, ... }:
with lib;
{
  freeformType = with types; attrsOf anything;

  options = {
    image = {
      repository = mkOption {
        type = types.str;
        default = "docker.io/velero/velero";
      };
      tag = mkOption {
        type = types.str;
        default = "v1.18.0";
      };
      pullPolicy = mkOption {
        type = types.str;
        default = "IfNotPresent";
      };
    };

    resources = mkOption {
      type = types.attrsOf types.anything;
      default = {};
    };

    initContainers = mkOption {
      type = types.listOf (types.attrsOf types.anything);
      default = [];
    };

    configuration = {
      backupStorageLocation = mkOption {
        type = types.listOf (types.attrsOf types.anything);
        default = [];
      };
      volumeSnapshotLocation = mkOption {
        type = types.listOf (types.attrsOf types.anything);
        default = [];
      };
    };

    credentials = {
      useSecret = mkOption {
        type = types.bool;
        default = true;
      };
      secretContents = mkOption {
        type = types.attrsOf types.str;
        default = {};
      };
    };

    deployNodeAgent = mkOption {
      type = types.bool;
      default = false;
    };

    nodeAgent = {
      resources = mkOption {
        type = types.attrsOf types.anything;
        default = {};
      };
    };

    snapshotsEnabled = mkOption {
      type = types.bool;
      default = true;
    };

    backupsEnabled = mkOption {
      type = types.bool;
      default = true;
    };
  };
}
