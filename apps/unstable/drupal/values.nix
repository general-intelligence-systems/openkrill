# Auto-generated from Bitnami values.schema.json
# Do not edit — regenerate with bin/create-module-bitnami
{ lib, ... }:
with lib;
let
  ExternalDatabaseModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "database" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "host" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "password" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "user" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  IngressModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable the ingress resource that allows you to access the Drupal installation.";
        type = types.bool;
        default = false;
      };
      "hostname" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  MariadbModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Whether to deploy a mariadb server to satisfy the applications database requirements. To use an external database switch this off and configure the external database details";
        type = types.bool;
        default = false;
      };
      "primary" = mkOption {
        type = MariadbPrimaryModule;
        default = { };
      };
    };
  };
  MariadbPrimaryModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "persistence" = mkOption {
        type = MariadbPrimaryPersistenceModule;
        default = { };
      };
    };
  };
  MariadbPrimaryPersistenceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "size" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  MetricsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Prometheus Exporter / Metrics";
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
  PersistenceDrupalModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "size" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  PersistenceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "drupal" = mkOption {
        type = PersistenceDrupalModule;
        default = { };
      };
    };
  };
  ResourcesModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "requests" = mkOption {
        type = ResourcesRequestsModule;
        default = { };
      };
    };
  };
  ResourcesRequestsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "cpu" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "memory" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  ServiceAccountDrupalModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "automountServiceAccountToken" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "create" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  ServiceAccountModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "drupal" = mkOption {
        type = ServiceAccountDrupalModule;
        default = { };
      };
    };
  };
  ServiceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "type" = mkOption {
        description = "Allowed values: \"ClusterIP\", \"NodePort\" and \"LoadBalancer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
in
{
  freeformType = types.attrsOf types.anything;
  options = {
    "drupalEmail" = mkOption {
      type = (types.nullOr types.str);
      default = null;
    };
    "drupalPassword" = mkOption {
      description = "Defaults to a random 10-character alphanumeric string if not set";
      type = (types.nullOr types.str);
      default = null;
    };
    "drupalUsername" = mkOption {
      type = (types.nullOr types.str);
      default = null;
    };
    "externalDatabase" = mkOption {
      description = "If MariaDB is disabled. Use this section to specify the external database details";
      type = ExternalDatabaseModule;
      default = { };
    };
    "ingress" = mkOption {
      type = IngressModule;
      default = { };
    };
    "mariadb" = mkOption {
      type = MariadbModule;
      default = { };
    };
    "metrics" = mkOption {
      type = MetricsModule;
      default = { };
    };
    "persistence" = mkOption {
      type = PersistenceModule;
      default = { };
    };
    "resources" = mkOption {
      description = "Configure resource requests";
      type = ResourcesModule;
      default = { };
    };
    "service" = mkOption {
      type = ServiceModule;
      default = { };
    };
    "serviceAccount" = mkOption {
      type = ServiceAccountModule;
      default = { };
    };
  };
}
