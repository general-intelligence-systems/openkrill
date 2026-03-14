# apps/unstable/wavefront-prometheus-storage-adapter — Bitnami wavefront-prometheus-storage-adapter
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.wavefront-prometheus-storage-adapter;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  options.openkrill.apps.wavefront-prometheus-storage-adapter = {
    enable = mkEnableOption "Bitnami wavefront-prometheus-storage-adapter";

    namespace = mkOption {
      type = types.str;
      default = "wavefront-prometheus-storage-adapter";
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
    # openkrill.ingress.routes.wavefront-prometheus-storage-adapter = {
    #   subdomain = "wavefront-prometheus-storage-adapter";
    #   namespace = cfg.namespace;
    #   service = "wavefront-prometheus-storage-adapter";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argocd.applications.wavefront-prometheus-storage-adapter = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "wavefront-prometheus-storage-adapter.yaml";
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
    openkrill.manifests.wavefront-prometheus-storage-adapter.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name = "wavefront-prometheus-storage-adapter";
        chart = charts.bitnami.wavefront-prometheus-storage-adapter.latest;
        namespace = cfg.namespace;
        values = cfg.values;
      };
  };
}
