# apps/unstable/kubernetes-event-exporter — Bitnami kubernetes-event-exporter
{
  config,
  lib,
  charts,
  kubelib,
  k8s,
  ...
}:
with lib;
let
  cfg = config.openkrill.apps.kubernetes-event-exporter;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  imports = [ ./custom.nix ];

  options.openkrill.apps.kubernetes-event-exporter = {
    enable = mkEnableOption "Bitnami kubernetes-event-exporter";

    namespace = mkOption {
      type = types.str;
      default = "kubernetes-event-exporter";
    };

    values = mkOption {
      type = types.submodule (import ./values.nix);
      default = { };
      description = "Helm chart values. Schema-derived defaults are set automatically.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Route ──────────────────────────────────────────────────────
    # openkrill.ingress.routes.kubernetes-event-exporter = {
    #   subdomain = "kubernetes-event-exporter";
    #   namespace = cfg.namespace;
    #   service = "kubernetes-event-exporter";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.kubernetes-event-exporter = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "kubernetes-event-exporter.yaml";
      };
      destination = {
        server = "https://kubernetes.default.svc";
        namespace = cfg.namespace;
      };
      syncPolicy = {
        automated = {
          prune = true;
          selfHeal = true;
        };
        syncOptions = [ "CreateNamespace=true" ];
      };
    };

    # ── Manifests ───────────────────────────────────────────────────
    openkrill.manifests.kubernetes-event-exporter.content = [
      (k8s.mkNamespace cfg.namespace)
    ]
    ++ kubelib.fromHelm {
      name = "kubernetes-event-exporter";
      chart = charts.bitnami.kubernetes-event-exporter.latest;
      namespace = cfg.namespace;
      values = cfg.values;
    };
  };
}
