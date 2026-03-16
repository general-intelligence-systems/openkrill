# apps/unstable/wavefront-hpa-adapter — Bitnami wavefront-hpa-adapter
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
  cfg = config.openkrill.apps.wavefront-hpa-adapter;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  imports = [ ./custom.nix ];

  options.openkrill.apps.wavefront-hpa-adapter = {
    enable = mkEnableOption "Bitnami wavefront-hpa-adapter";

    namespace = mkOption {
      type = types.str;
      default = "wavefront-hpa-adapter";
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
    # openkrill.ingress.routes.wavefront-hpa-adapter = {
    #   subdomain = "wavefront-hpa-adapter";
    #   namespace = cfg.namespace;
    #   service = "wavefront-hpa-adapter";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.wavefront-hpa-adapter = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "wavefront-hpa-adapter.yaml";
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
    openkrill.manifests.wavefront-hpa-adapter.content = [
      (k8s.mkNamespace cfg.namespace)
    ]
    ++ kubelib.fromHelm {
      name = "wavefront-hpa-adapter";
      chart = charts.bitnami.wavefront-hpa-adapter.latest;
      namespace = cfg.namespace;
      values = cfg.values;
    };
  };
}
