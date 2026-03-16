# apps/unstable/sealed-secrets — Bitnami sealed-secrets
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
  cfg = config.openkrill.apps.sealed-secrets;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  imports = [
    ./crds.nix
    ./custom.nix
  ];

  options.openkrill.apps.sealed-secrets = {
    enable = mkEnableOption "Bitnami sealed-secrets";

    namespace = mkOption {
      type = types.str;
      default = "sealed-secrets";
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
    # openkrill.ingress.routes.sealed-secrets = {
    #   subdomain = "sealed-secrets";
    #   namespace = cfg.namespace;
    #   service = "sealed-secrets";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.sealed-secrets = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "sealed-secrets.yaml";
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
    openkrill.manifests.sealed-secrets.content = [
      (k8s.mkNamespace cfg.namespace)
    ]
    ++ kubelib.fromHelm {
      name = "sealed-secrets";
      chart = charts.bitnami.sealed-secrets.latest;
      namespace = cfg.namespace;
      values = cfg.values;
    };
  };
}
