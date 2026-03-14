# apps/unstable/kafka — Bitnami kafka
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.kafka;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  options.openkrill.apps.kafka = {
    enable = mkEnableOption "Bitnami kafka";

    namespace = mkOption {
      type = types.str;
      default = "kafka";
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
    # openkrill.ingress.routes.kafka = {
    #   subdomain = "kafka";
    #   namespace = cfg.namespace;
    #   service = "kafka";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argocd.applications.kafka = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "kafka.yaml";
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
    openkrill.manifests.kafka.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name = "kafka";
        chart = charts.bitnami.kafka.latest;
        namespace = cfg.namespace;
        values = cfg.values;
      };
  };
}
