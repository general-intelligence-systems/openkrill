# apps/unstable/nginx-ingress-controller — Bitnami nginx-ingress-controller
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.nginx-ingress-controller;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  options.openkrill.apps.nginx-ingress-controller = {
    enable = mkEnableOption "Bitnami nginx-ingress-controller";

    namespace = mkOption {
      type = types.str;
      default = "nginx-ingress-controller";
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
    # openkrill.ingress.routes.nginx-ingress-controller = {
    #   subdomain = "nginx-ingress-controller";
    #   namespace = cfg.namespace;
    #   service = "nginx-ingress-controller";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argocd.applications.nginx-ingress-controller = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "nginx-ingress-controller.yaml";
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
    openkrill.manifests.nginx-ingress-controller.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name = "nginx-ingress-controller";
        chart = charts.bitnami.nginx-ingress-controller.latest;
        namespace = cfg.namespace;
        values = cfg.values;
      };
  };
}
