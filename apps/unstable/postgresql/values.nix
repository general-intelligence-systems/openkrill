# Auto-generated from Bitnami values.schema.json
# Do not edit — regenerate with bin/create-module-bitnami
{ lib, ... }:
with lib;
let
  AuthModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "database" = mkOption {
  description = "Name of the custom database to be created during the 1st initialization of PostgreSQL";
  type = (types.nullOr types.str);
  default = null;
};
"enablePostgresUser" = mkOption {
  description = "Assign a password to the \"postgres\" admin user. Otherwise, remote access will be blocked for this user";
  type = types.bool;
  default = false;
};
"password" = mkOption {
  description = "Defaults to a random 10-character alphanumeric string if not set";
  type = (types.nullOr types.str);
  default = null;
};
"postgresPassword" = mkOption {
  description = "Defaults to a random 10-character alphanumeric string if not set";
  type = (types.nullOr types.str);
  default = null;
};
"replicationPassword" = mkOption {
  description = "Defaults to a random 10-character alphanumeric string if not set";
  type = (types.nullOr types.str);
  default = null;
};
"replicationUsername" = mkOption {
  description = "Name of user used to manage replication.";
  type = (types.nullOr types.str);
  default = null;
};
"username" = mkOption {
  description = "Name of the custom user to be created during the 1st initialization of PostgreSQL. This user only has permissions on the PostgreSQL custom database";
  type = (types.nullOr types.str);
  default = null;
};
  };
};
MetricsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  type = types.bool;
  default = false;
};
  };
};
PersistenceModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "size" = mkOption {
  type = (types.nullOr types.str);
  default = null;
};
  };
};
ReplicationModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  type = types.bool;
  default = false;
};
"readReplicas" = mkOption {
  type = (types.nullOr types.int);
  default = null;
};
  };
};
ResourcesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "requests" = mkOption {
  type = ResourcesRequestsModule;
  default = {  };
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
VolumePermissionsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Change the owner of the persist volume mountpoint to RunAsUser:fsGroup";
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
  type = (types.nullOr types.str);
  default = null;
};
"auth" = mkOption {
  type = AuthModule;
  default = {  };
};
"metrics" = mkOption {
  type = MetricsModule;
  default = {  };
};
"persistence" = mkOption {
  type = PersistenceModule;
  default = {  };
};
"replication" = mkOption {
  type = ReplicationModule;
  default = {  };
};
"resources" = mkOption {
  description = "Configure resource requests";
  type = ResourcesModule;
  default = {  };
};
"volumePermissions" = mkOption {
  type = VolumePermissionsModule;
  default = {  };
};
  };
}
