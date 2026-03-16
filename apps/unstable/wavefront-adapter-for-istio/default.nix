# apps/unstable/wavefront-adapter-for-istio — Bitnami wavefront-adapter-for-istio
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
  cfg = config.openkrill.apps.wavefront-adapter-for-istio;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  imports = [ ./custom.nix ];

  options.openkrill.apps.wavefront-adapter-for-istio = {
    enable = mkEnableOption "Bitnami wavefront-adapter-for-istio";

    namespace = mkOption {
      type = types.str;
      default = "wavefront-adapter-for-istio";
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
    # openkrill.ingress.routes.wavefront-adapter-for-istio = {
    #   subdomain = "wavefront-adapter-for-istio";
    #   namespace = cfg.namespace;
    #   service = "wavefront-adapter-for-istio";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.wavefront-adapter-for-istio = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "wavefront-adapter-for-istio.yaml";
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
    openkrill.manifests.wavefront-adapter-for-istio.content = [
      (k8s.mkNamespace cfg.namespace)
    ]
    ++ kubelib.fromHelm {
      name = "wavefront-adapter-for-istio";
      chart = charts.bitnami.wavefront-adapter-for-istio.latest;
      namespace = cfg.namespace;
      values = cfg.values;
    };
  };
}
