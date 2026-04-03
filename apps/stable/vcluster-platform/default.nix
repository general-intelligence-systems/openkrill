# apps/stable/vcluster-platform — Loft vCluster Platform
#
# Deploys Loft's vCluster Platform for managing virtual Kubernetes
# clusters with multi-tenancy, sleep mode, and cost optimization features.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.vcluster-platform;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  options.openkrill.apps.vcluster-platform = {
    enable = mkEnableOption "vCluster Platform for managing virtual Kubernetes clusters";

    namespace = mkOption {
      type = types.str;
      default = "vcluster-platform";
      description = "Kubernetes namespace for vcluster-platform resources.";
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
    openkrill.apps.argo-cd.applications.vcluster-platform = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "vcluster-platform.yaml";
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
    openkrill.manifests.vcluster-platform.content = [
      (k8s.mkNamespace cfg.namespace)
    ]
    ++ kubelib.fromHelm {
      name = "vcluster-platform";
      chart = charts.loft.vcluster-platform.latest;
      namespace = cfg.namespace;
      values = cfg.values;
    };
  };
}
