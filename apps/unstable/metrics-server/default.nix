# apps/metrics-server — Kubernetes Metrics Server (Bitnami)
#
# Deploys metrics-server via the Bitnami Helm chart with hostNetwork
# enabled.  See custom.nix for the rationale behind hostNetwork.
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
  cfg = config.openkrill.apps.metrics-server;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  imports = [ ./custom.nix ];

  options.openkrill.apps.metrics-server = {
    enable = mkEnableOption "Bitnami metrics-server";

    namespace = mkOption {
      type = types.str;
      default = "kube-system";
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
    # openkrill.ingress.routes.metrics-server = {
    #   subdomain = "metrics-server";
    #   namespace = cfg.namespace;
    #   service = "metrics-server";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.metrics-server = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "metrics-server.yaml";
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
    openkrill.manifests.metrics-server.content =
    optionals (cfg.namespace != "kube-system") [ (k8s.mkNamespace cfg.namespace) ]
    ++ kubelib.fromHelm {
      name = "metrics-server";
      chart = charts.bitnami.metrics-server.latest;
      namespace = cfg.namespace;
      values = cfg.values;
    };
  };
}
