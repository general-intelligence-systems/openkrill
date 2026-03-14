# apps/unstable/kube-state-metrics — Bitnami kube-state-metrics
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.kube-state-metrics;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  options.openkrill.apps.kube-state-metrics = {
    enable = mkEnableOption "Bitnami kube-state-metrics";

    namespace = mkOption {
      type = types.str;
      default = "kube-state-metrics";
    };

    values = mkOption {
      type = types.submodule (import ./values.nix);
      default = {};
      description = "Helm chart values. Schema-derived defaults are set automatically.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Route ──────────────────────────────────────────────────────
    # openkrill.ingress.routes.kube-state-metrics = {
    #   subdomain = "kube-state-metrics";
    #   namespace = cfg.namespace;
    #   service = "kube-state-metrics";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argocd.applications.kube-state-metrics = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "kube-state-metrics.yaml";
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
    openkrill.manifests.kube-state-metrics.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name = "kube-state-metrics";
        chart = charts.bitnami.kube-state-metrics.latest;
        namespace = cfg.namespace;
        values = cfg.values;
      };
  };
}
