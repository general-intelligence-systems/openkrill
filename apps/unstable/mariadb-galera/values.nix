# Auto-generated from Bitnami values.schema.json
# Do not edit — regenerate with bin/create-module-bitnami
{ lib, ... }:
with lib;
let
  DbModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "name" = mkOption {
        description = "Name of the custom database to be created during the 1st initialization of MariaDB";
        type = (types.nullOr types.str);
        default = null;
      };
      "password" = mkOption {
        description = "Defaults to a random 10-character alphanumeric string if not set";
        type = (types.nullOr types.str);
        default = null;
      };
      "user" = mkOption {
        description = "Name of the custom user to be created during the 1st initialization of MariaDB. This user only has permissions on the MariaDB custom database";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  GaleraMariabackupModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "password" = mkOption {
        description = "Defaults to a random 10-character alphanumeric string if not set";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  GaleraModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "mariabackup" = mkOption {
        type = GaleraMariabackupModule;
        default = { };
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  LdapModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "base" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "binddn" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "bindpw" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "enabled" = mkOption {
        description = "Enable authentication using LDAP";
        type = types.bool;
        default = false;
      };
      "uri" = mkOption {
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
  RbacModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "create" = mkOption {
        description = "Specify whether RBAC resources should be created and used";
        type = types.bool;
        default = false;
      };
    };
  };
  RootUserModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "password" = mkOption {
        description = "Defaults to a random 10-character alphanumeric string if not set";
        type = (types.nullOr types.str);
        default = null;
      };
      "user" = mkOption {
        description = "Name of the admin user to be created during the 1st initialization of MariaDB.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  ServiceAccountModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "create" = mkOption {
        description = "Specify whether a ServiceAcccount for MariaDB Galera pods should be created";
        type = types.bool;
        default = false;
      };
      "name" = mkOption {
        description = "ServiceAcccount name to use. Auto-generated if not specified";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
in
{
  freeformType = types.attrsOf types.anything;
  options = {
    "db" = mkOption {
      type = DbModule;
      default = { };
    };
    "galera" = mkOption {
      type = GaleraModule;
      default = { };
    };
    "ldap" = mkOption {
      type = LdapModule;
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
    "rbac" = mkOption {
      type = RbacModule;
      default = { };
    };
    "replicaCount" = mkOption {
      type = (types.nullOr types.int);
      default = null;
    };
    "rootUser" = mkOption {
      type = RootUserModule;
      default = { };
    };
    "serviceAccount" = mkOption {
      type = ServiceAccountModule;
      default = { };
    };
  };
}
