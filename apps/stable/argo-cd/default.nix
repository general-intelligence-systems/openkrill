# apps/stable/argo-cd — Bitnami argo-cd
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
  cfg = config.openkrill.apps.argo-cd;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  imports = [
    ./crds.nix
    ./custom.nix
  ];

  options.openkrill.apps.argo-cd = {
    enable = mkEnableOption "Bitnami argo-cd";

    namespace = mkOption {
      type = types.str;
      default = "argo-cd";
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
    # openkrill.ingress.routes.argo-cd = {
    #   subdomain = "argo-cd";
    #   namespace = cfg.namespace;
    #   service = "argo-cd";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.argo-cd = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "argo-cd.yaml";
      };
      destination = {
        server = "https://kubernetes.default.svc";
        namespace = cfg.namespace;
      };
      ignoreDifferences = [
        {
          group = "apps";
          kind = "StatefulSet";
          jsonPointers = [
            "/spec/volumeClaimTemplates/0/status"
            "/spec/persistentVolumeClaimRetentionPolicy"
          ];
        }
      ];
      syncPolicy = {
        automated = {
          prune = true;
          selfHeal = true;
        };
        syncOptions = [ "CreateNamespace=true" "ServerSideApply=true" ];
      };
    };

    # ── Manifests ───────────────────────────────────────────────────
    openkrill.manifests.argo-cd.content = [
      (k8s.mkNamespace cfg.namespace)
    ]
    ++ kubelib.fromHelm {
      name = "argo-cd";
      chart = charts.bitnami.argo-cd.latest;
      namespace = cfg.namespace;
      values = cfg.values;
    };
  };
}
