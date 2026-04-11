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
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkCluster =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ExtensionModule = types.submodule {
    options = {
      "ensure" = mkOption {
        description = "Specifies whether an extension/schema should be present or absent in\nthe database. If set to `present`, the extension/schema will be\ncreated if it does not exist. If set to `absent`, the\nextension/schema will be removed if it exists.";
        type = (
          types.nullOr (
            types.enum [
              "present"
              "absent"
            ]
          )
        );
        default = "present";
      };
      "name" = mkOption {
        description = "Name of the extension/schema";
        type = types.str;
      };
      "schema" = mkOption {
        description = "The name of the schema in which to install the extension's objects,\nin case the extension allows its contents to be relocated. If not\nspecified (default), and the extension's control file does not\nspecify a schema either, the current default object creation schema\nis used.";
        type = (types.nullOr types.str);
        default = null;
      };
      "version" = mkOption {
        description = "The version of the extension to install. If empty, the operator will\ninstall the default version (whatever is specified in the\nextension's control file)";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkExtension =
    res:
    {
    }
    // optionalAttrs (res."ensure" != null) { inherit (res) "ensure"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."schema" != null) { inherit (res) "schema"; }
    // {
    }
    // optionalAttrs (res."version" != null) { inherit (res) "version"; }
    // {
    };
  SchemaModule = types.submodule {
    options = {
      "ensure" = mkOption {
        description = "Specifies whether an extension/schema should be present or absent in\nthe database. If set to `present`, the extension/schema will be\ncreated if it does not exist. If set to `absent`, the\nextension/schema will be removed if it exists.";
        type = (
          types.nullOr (
            types.enum [
              "present"
              "absent"
            ]
          )
        );
        default = "present";
      };
      "name" = mkOption {
        description = "Name of the extension/schema";
        type = types.str;
      };
      "owner" = mkOption {
        description = "The role name of the user who owns the schema inside PostgreSQL.\nIt maps to the `AUTHORIZATION` parameter of `CREATE SCHEMA` and the\n`OWNER TO` command of `ALTER SCHEMA`.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSchema =
    res:
    {
    }
    // optionalAttrs (res."ensure" != null) { inherit (res) "ensure"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."owner" != null) { inherit (res) "owner"; }
    // {
    };
  DatabasesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this Database resource.";
        };
        "allowConnections" = mkOption {
          description = "Maps to the `ALLOW_CONNECTIONS` parameter of `CREATE DATABASE` and\n`ALTER DATABASE`. If false then no one can connect to this database.";
          type = types.bool;
          default = false;
        };
        "builtinLocale" = mkOption {
          description = "Maps to the `BUILTIN_LOCALE` parameter of `CREATE DATABASE`. This\nsetting cannot be changed. Specifies the locale name when the\nbuiltin provider is used. This option requires `localeProvider` to\nbe set to `builtin`. Available from PostgreSQL 17.";
          type = (types.nullOr types.str);
          default = null;
        };
        "cluster" = mkOption {
          description = "The name of the PostgreSQL cluster hosting the database.";
          type = ClusterModule;
        };
        "collationVersion" = mkOption {
          description = "Maps to the `COLLATION_VERSION` parameter of `CREATE DATABASE`. This\nsetting cannot be changed.";
          type = (types.nullOr types.str);
          default = null;
        };
        "connectionLimit" = mkOption {
          description = "Maps to the `CONNECTION LIMIT` clause of `CREATE DATABASE` and\n`ALTER DATABASE`. How many concurrent connections can be made to\nthis database. -1 (the default) means no limit.";
          type = (types.nullOr types.int);
          default = null;
        };
        "databaseReclaimPolicy" = mkOption {
          description = "The policy for end-of-life maintenance of this database.";
          type = (
            types.nullOr (
              types.enum [
                "delete"
                "retain"
              ]
            )
          );
          default = "retain";
        };
        "encoding" = mkOption {
          description = "Maps to the `ENCODING` parameter of `CREATE DATABASE`. This setting\ncannot be changed. Character set encoding to use in the database.";
          type = (types.nullOr types.str);
          default = null;
        };
        "ensure" = mkOption {
          description = "Ensure the PostgreSQL database is `present` or `absent` - defaults to \"present\".";
          type = (
            types.nullOr (
              types.enum [
                "present"
                "absent"
              ]
            )
          );
          default = "present";
        };
        "extensions" = mkOption {
          description = "The list of extensions to be managed in the database";
          type = (types.listOf ExtensionModule);
          default = [ ];
        };
        "icuLocale" = mkOption {
          description = "Maps to the `ICU_LOCALE` parameter of `CREATE DATABASE`. This\nsetting cannot be changed. Specifies the ICU locale when the ICU\nprovider is used. This option requires `localeProvider` to be set to\n`icu`. Available from PostgreSQL 15.";
          type = (types.nullOr types.str);
          default = null;
        };
        "icuRules" = mkOption {
          description = "Maps to the `ICU_RULES` parameter of `CREATE DATABASE`. This setting\ncannot be changed. Specifies additional collation rules to customize\nthe behavior of the default collation. This option requires\n`localeProvider` to be set to `icu`. Available from PostgreSQL 16.";
          type = (types.nullOr types.str);
          default = null;
        };
        "isTemplate" = mkOption {
          description = "Maps to the `IS_TEMPLATE` parameter of `CREATE DATABASE` and `ALTER\nDATABASE`. If true, this database is considered a template and can\nbe cloned by any user with `CREATEDB` privileges.";
          type = types.bool;
          default = false;
        };
        "locale" = mkOption {
          description = "Maps to the `LOCALE` parameter of `CREATE DATABASE`. This setting\ncannot be changed. Sets the default collation order and character\nclassification in the new database.";
          type = (types.nullOr types.str);
          default = null;
        };
        "localeCType" = mkOption {
          description = "Maps to the `LC_CTYPE` parameter of `CREATE DATABASE`. This setting\ncannot be changed.";
          type = (types.nullOr types.str);
          default = null;
        };
        "localeCollate" = mkOption {
          description = "Maps to the `LC_COLLATE` parameter of `CREATE DATABASE`. This\nsetting cannot be changed.";
          type = (types.nullOr types.str);
          default = null;
        };
        "localeProvider" = mkOption {
          description = "Maps to the `LOCALE_PROVIDER` parameter of `CREATE DATABASE`. This\nsetting cannot be changed. This option sets the locale provider for\ndatabases created in the new cluster. Available from PostgreSQL 16.";
          type = (types.nullOr types.str);
          default = null;
        };
        "name" = mkOption {
          description = "The name of the database to create inside PostgreSQL. This setting cannot be changed.";
          type = types.str;
        };
        "owner" = mkOption {
          description = "Maps to the `OWNER` parameter of `CREATE DATABASE`.\nMaps to the `OWNER TO` command of `ALTER DATABASE`.\nThe role name of the user who owns the database inside PostgreSQL.";
          type = types.str;
        };
        "schemas" = mkOption {
          description = "The list of schemas to be managed in the database";
          type = (types.listOf SchemaModule);
          default = [ ];
        };
        "tablespace" = mkOption {
          description = "Maps to the `TABLESPACE` parameter of `CREATE DATABASE`.\nMaps to the `SET TABLESPACE` command of `ALTER DATABASE`.\nThe name of the tablespace (in PostgreSQL) that will be associated\nwith the new database. This tablespace will be the default\ntablespace used for objects created in this database.";
          type = (types.nullOr types.str);
          default = null;
        };
        "template" = mkOption {
          description = "Maps to the `TEMPLATE` parameter of `CREATE DATABASE`. This setting\ncannot be changed. The name of the template from which to create\nthis database.";
          type = (types.nullOr types.str);
          default = null;
        };
        "postInitSQL" = mkOption {
          description = "List of SQL queries to execute after the database has been created.\nThese are collected and forwarded to the CNPG cluster's\nbootstrap.initdb.postInitApplicationSQL.";
          type = (types.listOf types.str);
          default = [ ];
        };
      };
    }
  );
  mkDatabase = name: res: {
    apiVersion = "postgresql.cnpg.io/v1";
    kind = "Database";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs res."allowConnections" { inherit (res) "allowConnections"; }
    // {
    }
    // optionalAttrs (res."builtinLocale" != null) { inherit (res) "builtinLocale"; }
    // {
      "cluster" = mkCluster res."cluster";
    }
    // optionalAttrs (res."collationVersion" != null) { inherit (res) "collationVersion"; }
    // {
    }
    // optionalAttrs (res."connectionLimit" != null) { inherit (res) "connectionLimit"; }
    // {
    }
    // optionalAttrs (res."databaseReclaimPolicy" != null) { inherit (res) "databaseReclaimPolicy"; }
    // {
    }
    // optionalAttrs (res."encoding" != null) { inherit (res) "encoding"; }
    // {
    }
    // optionalAttrs (res."ensure" != null) { inherit (res) "ensure"; }
    // {
    }
    // optionalAttrs (res."extensions" != [ ]) { "extensions" = map mkExtension res."extensions"; }
    // {
    }
    // optionalAttrs (res."icuLocale" != null) { inherit (res) "icuLocale"; }
    // {
    }
    // optionalAttrs (res."icuRules" != null) { inherit (res) "icuRules"; }
    // {
    }
    // optionalAttrs res."isTemplate" { inherit (res) "isTemplate"; }
    // {
    }
    // optionalAttrs (res."locale" != null) { inherit (res) "locale"; }
    // {
    }
    // optionalAttrs (res."localeCType" != null) { inherit (res) "localeCType"; }
    // {
    }
    // optionalAttrs (res."localeCollate" != null) { inherit (res) "localeCollate"; }
    // {
    }
    // optionalAttrs (res."localeProvider" != null) { inherit (res) "localeProvider"; }
    // {
      inherit (res) "name";
      inherit (res) "owner";
    }
    // optionalAttrs (res."schemas" != [ ]) { "schemas" = map mkSchema res."schemas"; }
    // {
    }
    // optionalAttrs (res."tablespace" != null) { inherit (res) "tablespace"; }
    // {
    }
    // optionalAttrs (res."template" != null) { inherit (res) "template"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkDatabase cfg."databases");
in
{
  options.openkrill.apps."cloudnative-pg" = {
    "databases" = mkOption {
      type = types.attrsOf DatabasesModule;
      default = { };
      description = "Database CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."cloudnative-pg".content = allResources;
  };
}
