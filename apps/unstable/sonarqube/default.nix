# apps/unstable/sonarqube — Bitnami sonarqube
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.sonarqube;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  options.openkrill.apps.sonarqube = {
    enable = mkEnableOption "Bitnami sonarqube";

    namespace = mkOption {
      type = types.str;
      default = "sonarqube";
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
    # openkrill.ingress.routes.sonarqube = {
    #   subdomain = "sonarqube";
    #   namespace = cfg.namespace;
    #   service = "sonarqube";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argocd.applications.sonarqube = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "sonarqube.yaml";
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
    openkrill.manifests.sonarqube.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name = "sonarqube";
        chart = charts.bitnami.sonarqube.latest;
        namespace = cfg.namespace;
        values = cfg.values;
      };
  };
}
