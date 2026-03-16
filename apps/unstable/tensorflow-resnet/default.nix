# apps/unstable/tensorflow-resnet — Bitnami tensorflow-resnet
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
  cfg = config.openkrill.apps.tensorflow-resnet;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  imports = [ ./custom.nix ];

  options.openkrill.apps.tensorflow-resnet = {
    enable = mkEnableOption "Bitnami tensorflow-resnet";

    namespace = mkOption {
      type = types.str;
      default = "tensorflow-resnet";
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
    # openkrill.ingress.routes.tensorflow-resnet = {
    #   subdomain = "tensorflow-resnet";
    #   namespace = cfg.namespace;
    #   service = "tensorflow-resnet";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.tensorflow-resnet = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "tensorflow-resnet.yaml";
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
    openkrill.manifests.tensorflow-resnet.content = [
      (k8s.mkNamespace cfg.namespace)
    ]
    ++ kubelib.fromHelm {
      name = "tensorflow-resnet";
      chart = charts.bitnami.tensorflow-resnet.latest;
      namespace = cfg.namespace;
      values = cfg.values;
    };
  };
}
