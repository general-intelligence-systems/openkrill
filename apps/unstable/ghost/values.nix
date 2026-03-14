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
"ssl" = mkOption {
  type = types.bool;
  default = false;
};
"sslCaFile" = mkOption {
  type = (types.nullOr types.str);
  default = null;
};
"user" = mkOption {
  type = (types.nullOr types.str);
  default = null;
};
  };
};
MysqlModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Whether to deploy a mysql server to satisfy the applications database requirements. To use an external database switch this off and configure the external database parameters";
  type = types.bool;
  default = false;
};
"primary" = mkOption {
  type = MysqlPrimaryModule;
  default = {  };
};
  };
};
MysqlPrimaryModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "persistence" = mkOption {
  type = MysqlPrimaryPersistenceModule;
  default = {  };
};
  };
};
MysqlPrimaryPersistenceModule = types.submodule {
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
    "size" = mkOption {
  type = (types.nullOr types.str);
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
SecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "When disabled, an initContainer will be used to set required folder permissions";
  type = types.bool;
  default = false;
};
  };
};
ServiceAccountModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "name" = mkOption {
  description = "Service Account Name to use";
  type = (types.nullOr types.str);
  default = null;
};
  };
};
in
{
  freeformType = types.attrsOf types.anything;
  options = {
    "externalDatabase" = mkOption {
  description = "If MySQL is disabled. Use this section to specify the external database details";
  type = ExternalDatabaseModule;
  default = {  };
};
"ghostBlogTitle" = mkOption {
  type = (types.nullOr types.str);
  default = null;
};
"ghostEmail" = mkOption {
  type = (types.nullOr types.str);
  default = null;
};
"ghostHost" = mkOption {
  description = "Hostname used to generate application URLs";
  type = (types.nullOr types.str);
  default = null;
};
"ghostPassword" = mkOption {
  description = "Defaults to a random 10-character alphanumeric string if not set";
  type = (types.nullOr types.str);
  default = null;
};
"ghostUsername" = mkOption {
  type = (types.nullOr types.str);
  default = null;
};
"mysql" = mkOption {
  type = MysqlModule;
  default = {  };
};
"persistence" = mkOption {
  type = PersistenceModule;
  default = {  };
};
"resources" = mkOption {
  description = "Configure resource requests";
  type = ResourcesModule;
  default = {  };
};
"securityContext" = mkOption {
  type = SecurityContextModule;
  default = {  };
};
"serviceAccount" = mkOption {
  type = ServiceAccountModule;
  default = {  };
};
  };
}
