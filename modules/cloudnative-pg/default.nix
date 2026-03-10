# modules/cloudnative-pg — CloudNativePG operator + CRD instances
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
  helpers = import ../lib/helpers.nix { inherit lib; };

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

  cnpgClusterSecretStore = {
    apiVersion = "external-secrets.io/v1beta1";
    kind = "ClusterSecretStore";
    metadata.name = cnpgStoreName;
    spec.provider.kubernetes = {
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
    # mkEnableOption defaults to false, but manifests.nix unconditionally
    # references enabledManifests.cloudnative-pg for k3s bootstrap auto-deploy.
    # Must default to true so the manifest exists whenever the module is imported.
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable CloudNativePG operator and database instances.";
    };

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

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
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

    # ── Manifests ─────────────────────────────────────────────────────
    openkrill.manifests = mkMerge [
      {
        cloudnative-pg.content =
          (kubelib.fromHelm {
            name = "cloudnative-pg";
            chart = charts.cloudnative-pg.cloudnative-pg;
            namespace = cfg.namespace;
            values = recursiveUpdate defaults cfg.values;
          })
          ++ cnpgStoreRBAC
          ++ [ cnpgClusterSecretStore ];
      }
      (helpers.mkExtraManifestsConfig "cloudnative-pg" cfg.extraManifests)
    ];
  };
}
