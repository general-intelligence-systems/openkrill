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
  SubscriptionsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this Subscription resource.";
        };
        "cluster" = mkOption {
          description = "The name of the PostgreSQL cluster that identifies the \"subscriber\"";
          type = ClusterModule;
        };
        "dbname" = mkOption {
          description = "The name of the database where the publication will be installed in\nthe \"subscriber\" cluster";
          type = types.str;
        };
        "externalClusterName" = mkOption {
          description = "The name of the external cluster with the publication (\"publisher\")";
          type = types.str;
        };
        "name" = mkOption {
          description = "The name of the subscription inside PostgreSQL";
          type = types.str;
        };
        "parameters" = mkOption {
          description = "Subscription parameters included in the `WITH` clause of the PostgreSQL\n`CREATE SUBSCRIPTION` command. Most parameters cannot be changed\nafter the subscription is created and will be ignored if modified\nlater, except for a limited set documented at:\nhttps://www.postgresql.org/docs/current/sql-altersubscription.html#SQL-ALTERSUBSCRIPTION-PARAMS-SET";
          type = (types.attrsOf types.str);
          default = { };
        };
        "publicationDBName" = mkOption {
          description = "The name of the database containing the publication on the external\ncluster. Defaults to the one in the external cluster definition.";
          type = (types.nullOr types.str);
          default = null;
        };
        "publicationName" = mkOption {
          description = "The name of the publication inside the PostgreSQL database in the\n\"publisher\"";
          type = types.str;
        };
        "subscriptionReclaimPolicy" = mkOption {
          description = "The policy for end-of-life maintenance of this subscription";
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
      };
    }
  );
  mkSubscription = name: res: {
    apiVersion = "postgresql.cnpg.io/v1";
    kind = "Subscription";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
      "cluster" = mkCluster res."cluster";
      inherit (res) "dbname";
      inherit (res) "externalClusterName";
      inherit (res) "name";
    }
    // optionalAttrs (res."parameters" != { }) { inherit (res) "parameters"; }
    // {
    }
    // optionalAttrs (res."publicationDBName" != null) { inherit (res) "publicationDBName"; }
    // {
      inherit (res) "publicationName";
    }
    // optionalAttrs (res."subscriptionReclaimPolicy" != null) {
      inherit (res) "subscriptionReclaimPolicy";
    }
    // {
    };
  };
  allResources = (mapAttrsToList mkSubscription cfg."subscriptions");
in
{
  options.openkrill.apps."cloudnative-pg" = {
    "subscriptions" = mkOption {
      type = types.attrsOf SubscriptionsModule;
      default = { };
      description = "Subscription CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."cloudnative-pg".content = allResources;
  };
}
