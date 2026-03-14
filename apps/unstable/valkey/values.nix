# Auto-generated from Bitnami values.schema.json
# Do not edit — regenerate with bin/create-module-bitnami
{ lib, ... }:
with lib;
let
  AuthModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        type = types.bool;
        default = false;
      };
      "password" = mkOption {
        description = "Defaults to a random 10-character alphanumeric string if not set";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  MetricsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Create a side-car container to expose Prometheus metrics";
        type = types.bool;
        default = false;
      };
      "serviceMonitor" = mkOption {
        type = MetricsServiceMonitorModule;
        default = { };
      };
    };
  };
  MetricsServiceMonitorModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Create a ServiceMonitor to track metrics using Prometheus Operator";
        type = types.bool;
        default = false;
      };
    };
  };
  PrimaryModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "kind" = mkOption {
        description = "Allowed values: `Deployment`, `StatefulSet` or `DaemonSet`";
        type = (
          types.nullOr (
            types.enum [
              "Deployment"
              "StatefulSet"
              "DaemonSet"
            ]
          )
        );
        default = null;
      };
      "persistence" = mkOption {
        type = PrimaryPersistenceModule;
        default = { };
      };
    };
  };
  PrimaryPersistenceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable persistence using Persistent Volume Claims";
        type = types.bool;
        default = false;
      };
      "size" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  ReplicaModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "kind" = mkOption {
        description = "Allowed values: `DaemonSet` or `StatefulSet`";
        type = (
          types.nullOr (
            types.enum [
              "DaemonSet"
              "StatefulSet"
            ]
          )
        );
        default = null;
      };
      "persistence" = mkOption {
        type = ReplicaPersistenceModule;
        default = { };
      };
      "replicaCount" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  ReplicaPersistenceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable persistence using Persistent Volume Claims";
        type = types.bool;
        default = false;
      };
      "size" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  VolumePermissionsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Use an init container to set required folder permissions on the data volume before mounting it in the final destination";
        type = types.bool;
        default = false;
      };
    };
  };
in
{
  freeformType = types.attrsOf types.anything;
  options = {
    "architecture" = mkOption {
      description = "Allowed values: `standalone` or `replication`";
      type = (
        types.nullOr (
          types.enum [
            "standalone"
            "replication"
          ]
        )
      );
      default = null;
    };
    "auth" = mkOption {
      type = AuthModule;
      default = { };
    };
    "metrics" = mkOption {
      type = MetricsModule;
      default = { };
    };
    "primary" = mkOption {
      type = PrimaryModule;
      default = { };
    };
    "replica" = mkOption {
      type = ReplicaModule;
      default = { };
    };
    "volumePermissions" = mkOption {
      type = VolumePermissionsModule;
      default = { };
    };
  };
}
