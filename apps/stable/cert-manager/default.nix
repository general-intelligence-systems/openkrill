# apps/stable/cert-manager — Bitnami cert-manager
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
  cfg = config.openkrill.apps.cert-manager;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  imports = [
    ./crds.nix
    ./custom.nix
  ];

  options.openkrill.apps.cert-manager = {
    enable = mkEnableOption "Bitnami cert-manager";

    namespace = mkOption {
      type = types.str;
      default = "cert-manager";
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
    # openkrill.ingress.routes.cert-manager = {
    #   subdomain = "cert-manager";
    #   namespace = cfg.namespace;
    #   service = "cert-manager";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.cert-manager = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "cert-manager.yaml";
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
    openkrill.manifests.cert-manager.content = [
      (k8s.mkNamespace cfg.namespace)
    ]
    ++ kubelib.fromHelm {
      name = "cert-manager";
      chart = charts.bitnami.cert-manager.latest;
      namespace = cfg.namespace;
      values = cfg.values;
    };
  };
}
