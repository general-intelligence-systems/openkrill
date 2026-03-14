# apps/unstable/grafana-alloy — Bitnami grafana-alloy
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.grafana-alloy;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  options.openkrill.apps.grafana-alloy = {
    enable = mkEnableOption "Bitnami grafana-alloy";

    namespace = mkOption {
      type = types.str;
      default = "grafana-alloy";
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
    # openkrill.ingress.routes.grafana-alloy = {
    #   subdomain = "grafana-alloy";
    #   namespace = cfg.namespace;
    #   service = "grafana-alloy";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argocd.applications.grafana-alloy = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "grafana-alloy.yaml";
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
    openkrill.manifests.grafana-alloy.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name = "grafana-alloy";
        chart = charts.bitnami.grafana-alloy.latest;
        namespace = cfg.namespace;
        values = cfg.values;
      };
  };
}
