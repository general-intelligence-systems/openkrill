# Custom overrides for this module.
# This file is never overwritten by the generator.
#
# Adds the shared-cluster pattern: a single CNPG Cluster ("postgres" by
# default) plus a ClusterSecretStore + RBAC so app modules (authelia,
# lldap, lago, …) can read CNPG-generated credentials via ExternalSecrets.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps.cloudnative-pg;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };

  # ── ClusterSecretStore + RBAC for CNPG-generated secrets ──────────
  # App modules (lldap, authelia, …) need credentials from the
  # postgres-app secret that CNPG generates in cfg.namespace.
  # A dedicated ClusterSecretStore + SA/RBAC lets ExternalSecrets in
  # any namespace read those credentials.
  cnpgStoreServiceAccount = "cnpg-secret-store-reader";
  cnpgStoreName = "cnpg-credentials";

  cnpgStoreRBAC = helpers.mkClusterRBAC {
    name = cnpgStoreServiceAccount;
    namespace = cfg.namespace;
    rules = [
      {
        apiGroups = [ "" ];
        resources = [ "secrets" ];
        verbs = [ "get" "list" "watch" ];
      }
      {
        apiGroups = [ "" ];
        resources = [ "namespaces" ];
        verbs = [ "get" "list" "watch" ];
      }
    ];
  };

in
{
  options.openkrill.apps.cloudnative-pg = {
    clusterName = mkOption {
      type = types.str;
      default = "postgres";
      description = "Name of the shared CNPG Cluster resource.";
    };

    clusterSecretStoreName = mkOption {
      type = types.str;
      default = cnpgStoreName;
      readOnly = true;
      description = ''
        Name of the ClusterSecretStore that exposes CNPG-generated
        secrets.  App modules reference this when creating
        ExternalSecrets for database credentials.
      '';
    };
  };

  config = mkIf cfg.enable {
    # ── ClusterSecretStore for CNPG-generated secrets ──────────────────
    # App modules (lldap, authelia, …) use this store to read database
    # credentials from the CNPG-generated app secret.
    openkrill.apps.external-secrets.clustersecretstores.${cnpgStoreName} = {
      namespace = cfg.namespace;
      provider.kubernetes = {
        remoteNamespace = cfg.namespace;
        server.caProvider = {
          type = "ConfigMap";
          name = "kube-root-ca.crt";
          namespace = cfg.namespace;
          key = "ca.crt";
        };
        auth.serviceAccount = {
          name = cnpgStoreServiceAccount;
          namespace = cfg.namespace;
        };
      };
    };

    # ── Shared CNPG Cluster ───────────────────────────────────────────
    # Single PostgreSQL instance for the platform.  App modules add
    # Database CRDs that create additional databases inside this cluster.
    openkrill.apps.cloudnative-pg.clusters.${cfg.clusterName} = {
      namespace = cfg.namespace;
      instances = 1;
      storage.size = "5Gi";
      imageName = "ghcr.io/general-intelligence-systems/postgresql:17-custom";
    };

    # ── VictoriaMetrics scrape + alerts (when VM is enabled) ──────────
    openkrill.apps.victoriametrics.vmservicescrapes.cnpg =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        selector.matchLabels."cnpg.io/cluster" = cfg.clusterName;
        namespaceSelector.matchNames = [ cfg.namespace ];
        endpoints = [{
          port = "metrics";
          path = "/metrics";
        }];
      };

    openkrill.apps.victoriametrics.vmrules.cnpg-alerts =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        groups = [{
          name = "cnpg";
          rules = [
            {
              alert = "CNPGClusterNotHealthy";
              expr = ''cnpg_collector_up == 0'';
              "for" = "5m";
              labels.severity = "critical";
              annotations = {
                summary = "CNPG cluster {{ $labels.cluster }} is not healthy";
                description = "CNPG metrics collector has been down for 5 minutes.";
              };
            }
            {
              alert = "CNPGHighReplicationLag";
              expr = ''cnpg_pg_replication_lag > 30'';
              "for" = "5m";
              labels.severity = "warning";
              annotations = {
                summary = "CNPG replication lag on {{ $labels.cluster }}";
                description = "Replication lag exceeds 30 seconds for 5 minutes.";
              };
            }
          ];
        }];
      };

    # ── RBAC manifests for the ClusterSecretStore ─────────────────────
    openkrill.manifests.cloudnative-pg.content = cnpgStoreRBAC;
  };
}
