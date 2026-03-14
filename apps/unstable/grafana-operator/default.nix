# apps/unstable/grafana-operator — Bitnami grafana-operator
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
  cfg = config.openkrill.apps.grafana-operator;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  imports = [
    ./crds.nix
    ./custom.nix
  ];

  options.openkrill.apps.grafana-operator = {
    enable = mkEnableOption "Bitnami grafana-operator";

    namespace = mkOption {
      type = types.str;
      default = "grafana-operator";
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
    # openkrill.ingress.routes.grafana-operator = {
    #   subdomain = "grafana-operator";
    #   namespace = cfg.namespace;
    #   service = "grafana-operator";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.grafana-operator = {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "grafana-operator.yaml";
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
        syncOptions = [
          "CreateNamespace=true"
          "ServerSideApply=true"
        ];
      };
    };

    # ── Manifests ───────────────────────────────────────────────────
    openkrill.manifests.grafana-operator.content = [
      (k8s.mkNamespace cfg.namespace)
    ]
    ++ kubelib.fromHelm {
      name = "grafana-operator";
      chart = charts.bitnami.grafana-operator.latest;
      namespace = cfg.namespace;
      values = cfg.values;
    };
  };
}
