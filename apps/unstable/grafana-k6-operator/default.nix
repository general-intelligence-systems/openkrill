# apps/unstable/grafana-k6-operator — Bitnami grafana-k6-operator
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
  cfg = config.openkrill.apps.grafana-k6-operator;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  imports = [ ./custom.nix ];

  options.openkrill.apps.grafana-k6-operator = {
    enable = mkEnableOption "Bitnami grafana-k6-operator";

    namespace = mkOption {
      type = types.str;
      default = "grafana-k6-operator";
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
    # openkrill.ingress.routes.grafana-k6-operator = {
    #   subdomain = "grafana-k6-operator";
    #   namespace = cfg.namespace;
    #   service = "grafana-k6-operator";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.grafana-k6-operator = {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "grafana-k6-operator.yaml";
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
    openkrill.manifests.grafana-k6-operator.content = [
      (k8s.mkNamespace cfg.namespace)
    ]
    ++ kubelib.fromHelm {
      name = "grafana-k6-operator";
      chart = charts.bitnami.grafana-k6-operator.latest;
      namespace = cfg.namespace;
      values = cfg.values;
    };
  };
}
