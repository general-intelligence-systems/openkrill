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
  TargetModule = types.submodule {
    options = {
      "allTables" = mkOption {
        description = "Marks the publication as one that replicates changes for all tables\nin the database, including tables created in the future.\nCorresponding to `FOR ALL TABLES` in PostgreSQL.";
        type = types.bool;
        default = false;
      };
      "objects" = mkOption {
        description = "Just the following schema objects";
        type = (types.listOf TargetObjectModule);
        default = [ ];
      };
    };
  };
  mkTarget =
    res:
    {
    }
    // optionalAttrs res."allTables" { inherit (res) "allTables"; }
    // {
    }
    // optionalAttrs (res."objects" != [ ]) { "objects" = map mkTargetObject res."objects"; }
    // {
    };
  TargetObjectModule = types.submodule {
    options = {
      "table" = mkOption {
        description = "Specifies a list of tables to add to the publication. Corresponding\nto `FOR TABLE` in PostgreSQL.";
        type = (types.nullOr TargetObjectTableModule);
        default = null;
      };
      "tablesInSchema" = mkOption {
        description = "Marks the publication as one that replicates changes for all tables\nin the specified list of schemas, including tables created in the\nfuture. Corresponding to `FOR TABLES IN SCHEMA` in PostgreSQL.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTargetObject =
    res:
    {
    }
    // optionalAttrs (res."table" != null) { "table" = mkTargetObjectTable res."table"; }
    // {
    }
    // optionalAttrs (res."tablesInSchema" != null) { inherit (res) "tablesInSchema"; }
    // {
    };
  TargetObjectTableModule = types.submodule {
    options = {
      "columns" = mkOption {
        description = "The columns to publish";
        type = (types.listOf types.str);
        default = [ ];
      };
      "name" = mkOption {
        description = "The table name";
        type = types.str;
      };
      "only" = mkOption {
        description = "Whether to limit to the table only or include all its descendants";
        type = types.bool;
        default = false;
      };
      "schema" = mkOption {
        description = "The schema name";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTargetObjectTable =
    res:
    {
    }
    // optionalAttrs (res."columns" != [ ]) { inherit (res) "columns"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs res."only" { inherit (res) "only"; }
    // {
    }
    // optionalAttrs (res."schema" != null) { inherit (res) "schema"; }
    // {
    };
  PublicationsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this Publication resource.";
        };
        "cluster" = mkOption {
          description = "The name of the PostgreSQL cluster that identifies the \"publisher\"";
          type = ClusterModule;
        };
        "dbname" = mkOption {
          description = "The name of the database where the publication will be installed in\nthe \"publisher\" cluster";
          type = types.str;
        };
        "name" = mkOption {
          description = "The name of the publication inside PostgreSQL";
          type = types.str;
        };
        "parameters" = mkOption {
          description = "Publication parameters part of the `WITH` clause as expected by\nPostgreSQL `CREATE PUBLICATION` command";
          type = (types.attrsOf types.str);
          default = { };
        };
        "publicationReclaimPolicy" = mkOption {
          description = "The policy for end-of-life maintenance of this publication";
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
        "target" = mkOption {
          description = "Target of the publication as expected by PostgreSQL `CREATE PUBLICATION` command";
          type = TargetModule;
        };
      };
    }
  );
  mkPublication = name: res: {
    apiVersion = "postgresql.cnpg.io/v1";
    kind = "Publication";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
      "cluster" = mkCluster res."cluster";
      inherit (res) "dbname";
      inherit (res) "name";
    }
    // optionalAttrs (res."parameters" != { }) { inherit (res) "parameters"; }
    // {
    }
    // optionalAttrs (res."publicationReclaimPolicy" != null) {
      inherit (res) "publicationReclaimPolicy";
    }
    // {
      "target" = mkTarget res."target";
    };
  };
  allResources = (mapAttrsToList mkPublication cfg."publications");
in
{
  options.openkrill.apps."cloudnative-pg" = {
    "publications" = mkOption {
      type = types.attrsOf PublicationsModule;
      default = { };
      description = "Publication CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."cloudnative-pg".content = allResources;
  };
}
