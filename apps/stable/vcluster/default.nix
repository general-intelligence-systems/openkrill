# apps/stable/vcluster — Virtual Kubernetes clusters
#
# Deploys Loft's vcluster to create lightweight, virtual Kubernetes
# clusters inside a single namespace. Useful for multi-tenancy,
# development environments, and CI/CD testing.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.vcluster;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  options.openkrill.apps.vcluster = {
    enable = mkEnableOption "Virtual Kubernetes clusters (vcluster)";

    namespace = mkOption {
      type = types.str;
      default = "vcluster";
      description = "Kubernetes namespace for vcluster resources.";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.vcluster = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "vcluster.yaml";
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

    # ── Manifests ───────────────────────────────────────────────────
    openkrill.manifests.vcluster.content = [
      (k8s.mkNamespace cfg.namespace)
    ]
    ++ kubelib.fromHelm {
      name = "vcluster";
      chart = charts.loft.vcluster.versions."0.33.1";
      namespace = cfg.namespace;
      values = cfg.values;
    };
  };
}
