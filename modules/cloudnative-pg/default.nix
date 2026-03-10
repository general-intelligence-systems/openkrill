# modules/cloudnative-pg — CloudNativePG operator + database instances
# Deploys the CNPG operator and all declared PostgreSQL clusters.
# Individual app modules declare their databases here centrally.
{ config, lib, charts, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.cloudnative-pg;
  helpers = import ../lib/helpers.nix { inherit lib; };

  defaults = { };

  # Build a CNPG Cluster resource from a database submodule config
  mkPgCluster = _name: db: {
    apiVersion = "postgresql.cnpg.io/v1";
    kind = "Cluster";
    metadata = {
      name = db.name;
      namespace = db.namespace;
    };
    spec = {
      instances = db.instances;
      storage = {
        size = db.storageSize;
      };
      bootstrap = {
        initdb = {
          database = db.database;
          owner = db.owner;
        }
        // optionalAttrs (db.credentialSecretName != null) {
          secret.name = db.credentialSecretName;
        }
        // optionalAttrs (db.postInitSQL != []) {
          postInitSQL = db.postInitSQL;
        }
        // optionalAttrs (db.postInitApplicationSQL != []) {
          postInitApplicationSQL = db.postInitApplicationSQL;
        };
      };
    };
  };

  pgClusters = mapAttrsToList mkPgCluster cfg.databases;
in
{
  options.openkrill.apps.cloudnative-pg = {
    enable = mkEnableOption "CloudNativePG operator and database instances";

    namespace = mkOption {
      type = types.str;
      default = "cnpg-system";
      description = "Namespace for the CNPG operator.";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    databases = mkOption {
      type = types.attrsOf (types.submodule ({ name, ... }: {
        options = {
          name = mkOption {
            type = types.str;
            default = "${name}-pg";
            description = "CNPG Cluster resource name.";
          };

          namespace = mkOption {
            type = types.str;
            description = "Namespace for this database cluster.";
          };

          database = mkOption {
            type = types.str;
            default = name;
            description = "Database name to create.";
          };

          owner = mkOption {
            type = types.str;
            default = name;
            description = "Database owner role.";
          };

          instances = mkOption {
            type = types.int;
            default = 1;
            description = "Number of PostgreSQL instances.";
          };

          storageSize = mkOption {
            type = types.str;
            default = "5Gi";
            description = "PVC storage size for the database.";
          };

          credentialSecretName = mkOption {
            type = types.nullOr types.str;
            default = null;
            description = "K8s Secret with bootstrap credentials. If null, CNPG auto-generates.";
          };

          postInitSQL = mkOption {
            type = types.listOf types.str;
            default = [];
            description = "SQL statements to run after database creation (as superuser).";
          };

          postInitApplicationSQL = mkOption {
            type = types.listOf types.str;
            default = [];
            description = "SQL statements to run after database creation (as the owner role).";
          };
        };
      }));
      default = {};
      description = "PostgreSQL database instances managed by CNPG.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    openkrill.apps.argocd.applications.cloudnative-pg = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "cloudnative-pg.yaml";
      };
      destination = {
        server = "https://kubernetes.default.svc";
        namespace = cfg.namespace;
      };
      syncPolicy = {
        automated = { prune = true; selfHeal = true; };
        syncOptions = [ "CreateNamespace=true" ];
      };
    };

    openkrill.manifests = mkMerge [
      {
        cloudnative-pg.content =
          (kubelib.fromHelm {
            name = "cloudnative-pg";
            chart = charts.cloudnative-pg.cloudnative-pg;
            namespace = cfg.namespace;
            values = recursiveUpdate defaults cfg.values;
          })
          ++ pgClusters;
      }
      (helpers.mkExtraManifestsConfig "cloudnative-pg" cfg.extraManifests)
    ];
  };
}
