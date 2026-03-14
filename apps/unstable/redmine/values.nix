# Auto-generated from Bitnami values.schema.json
# Do not edit — regenerate with bin/create-module-bitnami
{ lib, ... }:
with lib;
let
  IngressModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable the ingress resource that allows you to access the Redmine installation.";
        type = types.bool;
        default = false;
      };
      "hostname" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "tls" = mkOption {
        type = types.bool;
        default = false;
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
  PostgresqlModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Whether to deploy a postgresql server to satisfy the applications database requirements. To use an external database switch this off and configure the external database details";
        type = types.bool;
        default = false;
      };
      "persistence" = mkOption {
        type = PostgresqlPersistenceModule;
        default = { };
      };
    };
  };
  PostgresqlPersistenceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "size" = mkOption {
        type = (types.nullOr types.str);
        default = null;
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
    "databaseType" = mkOption {
      description = "Allowed values: \"mariadb\" and \"postgresql\"";
      type = (
        types.nullOr (
          types.enum [
            "mariadb"
            "postgresql"
          ]
        )
      );
      default = null;
    };
    "ingress" = mkOption {
      type = IngressModule;
      default = { };
    };
    "mariadb" = mkOption {
      type = MariadbModule;
      default = { };
    };
    "persistence" = mkOption {
      type = PersistenceModule;
      default = { };
    };
    "postgresql" = mkOption {
      type = PostgresqlModule;
      default = { };
    };
    "redmineEmail" = mkOption {
      type = (types.nullOr types.str);
      default = null;
    };
    "redminePassword" = mkOption {
      description = "Defaults to a random 10-character alphanumeric string if not set";
      type = (types.nullOr types.str);
      default = null;
    };
    "redmineUsername" = mkOption {
      type = (types.nullOr types.str);
      default = null;
    };
    "service" = mkOption {
      type = ServiceModule;
      default = { };
    };
  };
}
