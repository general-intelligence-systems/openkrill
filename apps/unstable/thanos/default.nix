# apps/unstable/thanos — Bitnami thanos
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.thanos;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  options.openkrill.apps.thanos = {
    enable = mkEnableOption "Bitnami thanos";

    namespace = mkOption {
      type = types.str;
      default = "thanos";
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
    # openkrill.ingress.routes.thanos = {
    #   subdomain = "thanos";
    #   namespace = cfg.namespace;
    #   service = "thanos";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argocd.applications.thanos = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "thanos.yaml";
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
    openkrill.manifests.thanos.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name = "thanos";
        chart = charts.bitnami.thanos.latest;
        namespace = cfg.namespace;
        values = cfg.values;
      };
  };
}
