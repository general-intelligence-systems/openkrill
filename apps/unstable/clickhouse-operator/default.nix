# apps/unstable/clickhouse-operator — Bitnami clickhouse-operator
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
  cfg = config.openkrill.apps.clickhouse-operator;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  imports = [
    ./crds.nix
    ./custom.nix
  ];

  options.openkrill.apps.clickhouse-operator = {
    enable = mkEnableOption "Bitnami clickhouse-operator";

    namespace = mkOption {
      type = types.str;
      default = "clickhouse-operator";
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
    # openkrill.ingress.routes.clickhouse-operator = {
    #   subdomain = "clickhouse-operator";
    #   namespace = cfg.namespace;
    #   service = "clickhouse-operator";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.clickhouse-operator = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "clickhouse-operator.yaml";
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
    openkrill.manifests.clickhouse-operator.content = [
      (k8s.mkNamespace cfg.namespace)
    ]
    ++ kubelib.fromHelm {
      name = "clickhouse-operator";
      chart = charts.bitnami.clickhouse-operator.latest;
      namespace = cfg.namespace;
      values = cfg.values;
    };
  };
}
