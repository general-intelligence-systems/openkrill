# apps/unstable/argo-workflows — Bitnami argo-workflows
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
  cfg = config.openkrill.apps.argo-workflows;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  imports = [
    ./crds.nix
    ./custom.nix
  ];

  options.openkrill.apps.argo-workflows = {
    enable = mkEnableOption "Bitnami argo-workflows";

    namespace = mkOption {
      type = types.str;
      default = "argo-workflows";
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
    # openkrill.ingress.routes.argo-workflows = {
    #   subdomain = "argo-workflows";
    #   namespace = cfg.namespace;
    #   service = "argo-workflows";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.argo-workflows = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "argo-workflows.yaml";
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
    openkrill.manifests.argo-workflows.content = [
      (k8s.mkNamespace cfg.namespace)
    ]
    ++ kubelib.fromHelm {
      name = "argo-workflows";
      chart = charts.bitnami.argo-workflows.latest;
      namespace = cfg.namespace;
      values = cfg.values;
    };
  };
}
