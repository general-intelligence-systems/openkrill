# apps/unstable/flux — Bitnami flux
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
  cfg = config.openkrill.apps.flux;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  imports = [
    ./crds.nix
    ./custom.nix
  ];

  options.openkrill.apps.flux = {
    enable = mkEnableOption "Bitnami flux";

    namespace = mkOption {
      type = types.str;
      default = "flux";
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
    # openkrill.ingress.routes.flux = {
    #   subdomain = "flux";
    #   namespace = cfg.namespace;
    #   service = "flux";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.flux = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "flux.yaml";
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
    openkrill.manifests.flux.content = [
      (k8s.mkNamespace cfg.namespace)
    ]
    ++ kubelib.fromHelm {
      name = "flux";
      chart = charts.bitnami.flux.latest;
      namespace = cfg.namespace;
      values = cfg.values;
    };
  };
}
