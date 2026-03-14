# apps/unstable/kuberay — Bitnami kuberay
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.kuberay;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  options.openkrill.apps.kuberay = {
    enable = mkEnableOption "Bitnami kuberay";

    namespace = mkOption {
      type = types.str;
      default = "kuberay";
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
    # openkrill.ingress.routes.kuberay = {
    #   subdomain = "kuberay";
    #   namespace = cfg.namespace;
    #   service = "kuberay";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argocd.applications.kuberay = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "kuberay.yaml";
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
    openkrill.manifests.kuberay.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name = "kuberay";
        chart = charts.bitnami.kuberay.latest;
        namespace = cfg.namespace;
        values = cfg.values;
      };
  };
}
