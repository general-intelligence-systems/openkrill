# apps/unstable/envoy-gateway — Bitnami envoy-gateway
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
  cfg = config.openkrill.apps.envoy-gateway;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  imports = [
    ./crds.nix
    ./custom.nix
  ];

  options.openkrill.apps.envoy-gateway = {
    enable = mkEnableOption "Bitnami envoy-gateway";

    namespace = mkOption {
      type = types.str;
      default = "envoy-gateway";
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
    # openkrill.ingress.routes.envoy-gateway = {
    #   subdomain = "envoy-gateway";
    #   namespace = cfg.namespace;
    #   service = "envoy-gateway";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.envoy-gateway = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "envoy-gateway.yaml";
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
    openkrill.manifests.envoy-gateway.content = [
      (k8s.mkNamespace cfg.namespace)
    ]
    ++ kubelib.fromHelm {
      name = "envoy-gateway";
      chart = charts.bitnami.envoy-gateway.latest;
      namespace = cfg.namespace;
      values = cfg.values;
    };
  };
}
