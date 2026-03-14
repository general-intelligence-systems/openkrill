# Auto-generated from Bitnami values.schema.json
# Do not edit — regenerate with bin/create-module-bitnami
{ lib, ... }:
with lib;
let
  AuthModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "createDatabase" = mkOption {
        type = types.bool;
        default = false;
      };
      "database" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "password" = mkOption {
        type = types.str;
      };
      "replicationPassword" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "replicationUser" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "rootPassword" = mkOption {
        description = "Defaults to a random 10-character alphanumeric string if not set";
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
        type = types.str;
      };
    };
  };
  PrimaryContainerSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        type = types.bool;
        default = false;
      };
      "runAsUser" = mkOption {
        type = (types.nullOr types.int);
        default = 1001;
      };
    };
  };
  PrimaryModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "containerSecurityContext" = mkOption {
        type = PrimaryContainerSecurityContextModule;
        default = { };
      };
      "persistence" = mkOption {
        type = PrimaryPersistenceModule;
        default = { };
      };
      "podSecurityContext" = mkOption {
        type = PrimaryPodSecurityContextModule;
        default = { };
      };
    };
  };
  PrimaryPersistenceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        type = types.bool;
        default = true;
      };
      "size" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  PrimaryPodSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        type = types.bool;
        default = false;
      };
      "fsGroup" = mkOption {
        type = (types.nullOr types.int);
        default = 1001;
      };
    };
  };
  SecondaryContainerSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        type = types.bool;
        default = false;
      };
      "runAsUser" = mkOption {
        type = (types.nullOr types.int);
        default = 1001;
      };
    };
  };
  SecondaryModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "containerSecurityContext" = mkOption {
        type = SecondaryContainerSecurityContextModule;
        default = { };
      };
      "persistence" = mkOption {
        type = SecondaryPersistenceModule;
        default = { };
      };
      "podSecurityContext" = mkOption {
        type = SecondaryPodSecurityContextModule;
        default = { };
      };
    };
  };
  SecondaryPersistenceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        type = types.bool;
        default = true;
      };
      "size" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  SecondaryPodSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        type = types.bool;
        default = false;
      };
      "fsGroup" = mkOption {
        type = (types.nullOr types.int);
        default = 1001;
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
    "primary" = mkOption {
      type = PrimaryModule;
      default = { };
    };
    "secondary" = mkOption {
      type = SecondaryModule;
      default = { };
    };
  };
}
