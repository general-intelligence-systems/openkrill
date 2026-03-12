# apps/cloudnative-pg — CloudNativePG operator + CRD instances
# Deploys the CNPG operator Helm chart and a single shared PostgreSQL
# Cluster ("postgres" by default).  App modules declare Database CRDs
# against this shared cluster and use the "cnpg-credentials"
# ClusterSecretStore to mirror connection details into their own
# namespaces.
#
# CRD-typed submodules (clusters, databases, backups, etc.) are
# provided by the imported fragments.
{ config, lib, charts, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.cloudnative-pg;
  helpers          = import ../../modules/lib/helpers.nix { inherit lib; };
  networkPolicyLib = import ../../modules/lib/network-policy.nix { inherit lib; };

  defaults = { };

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
  imports = [
    ./backups.nix
    ./clusterimagecatalogs.nix
    ./clusters.nix
    ./databases.nix
    ./imagecatalogs.nix
    ./poolers.nix
    ./publications.nix
    ./scheduledbackups.nix
    ./subscriptions.nix
  ];

  options.openkrill.apps.cloudnative-pg = {
    enable = mkEnableOption "CloudNativePG operator and database instances";

    namespace = mkOption {
      type = types.str;
      default = "cnpg-system";
      description = "Namespace for the CNPG operator and the shared PostgreSQL cluster.";
    };

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

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    networkPolicy = networkPolicyLib.mkNetworkPolicyOption;
    extraManifests = helpers.mkExtraManifestsOption;
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

    openkrill.apps.cloudnative-pg.networkPolicy = {
      ingress = [
        { from = "authelia"; ports = [{ port = 5432; }]; }
        { from = "lldap"; ports = [{ port = 5432; }]; }
        { from = "forgejo"; ports = [{ port = 5432; }]; }
        { from = "opencloud"; ports = [{ port = 5432; }]; }
        { from = "lago"; ports = [{ port = 5432; }]; }
        { from = "victoriametrics"; ports = [{ port = 5432; }]; }
      ];
      egress = [
        { to = "dns"; }
      ];
    };
    # ── Shared CNPG Cluster ───────────────────────────────────────────
    # Single PostgreSQL instance for the platform.  App modules add
    # Database CRDs that create additional databases inside this cluster.
    openkrill.apps.cloudnative-pg.clusters.${cfg.clusterName} = {
      namespace = cfg.namespace;
      instances = 1;
      storage.size = "5Gi";
    };

    # ── ArgoCD Application CR ─────────────────────────────────────────
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

    # ── Manifests ─────────────────────────────────────────────────────
    openkrill.manifests.cloudnative-pg.content =
      (kubelib.fromHelm {
        name = "cloudnative-pg";
        chart = charts.cloudnative-pg.cloudnative-pg;
        namespace = cfg.namespace;
        values = recursiveUpdate defaults cfg.values;
      })
      ++ cnpgStoreRBAC;
  };
}
