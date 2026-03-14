# Auto-generated from Bitnami values.schema.json
# Do not edit — regenerate with bin/create-module-bitnami
{ lib, ... }:
with lib;
let
  AuthModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "password" = mkOption {
        description = "Defaults to a random 10-character alphanumeric string if not set";
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  MetricsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Install Prometheus plugin in the RabbitMQ container";
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
  PersistenceModule = types.submodule {
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
    "auth" = mkOption {
      type = AuthModule;
      default = { };
    };
    "extraConfiguration" = mkOption {
      description = "Extra configuration to be appended to RabbitMQ Configuration";
      type = (types.nullOr types.str);
      default = null;
    };
    "metrics" = mkOption {
      type = MetricsModule;
      default = { };
    };
    "persistence" = mkOption {
      type = PersistenceModule;
      default = { };
    };
    "replicaCount" = mkOption {
      description = "Number of replicas to deploy";
      type = (types.nullOr types.int);
      default = null;
    };
    "volumePermissions" = mkOption {
      type = VolumePermissionsModule;
      default = { };
    };
  };
}
