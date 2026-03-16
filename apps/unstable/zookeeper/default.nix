# apps/unstable/zookeeper — Bitnami zookeeper
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
  cfg = config.openkrill.apps.zookeeper;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  imports = [ ./custom.nix ];

  options.openkrill.apps.zookeeper = {
    enable = mkEnableOption "Bitnami zookeeper";

    namespace = mkOption {
      type = types.str;
      default = "zookeeper";
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
    # openkrill.ingress.routes.zookeeper = {
    #   subdomain = "zookeeper";
    #   namespace = cfg.namespace;
    #   service = "zookeeper";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.zookeeper = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "zookeeper.yaml";
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
    openkrill.manifests.zookeeper.content = [
      (k8s.mkNamespace cfg.namespace)
    ]
    ++ kubelib.fromHelm {
      name = "zookeeper";
      chart = charts.bitnami.zookeeper.latest;
      namespace = cfg.namespace;
      values = cfg.values;
    };
  };
}
