# apps/unstable/spring-cloud-dataflow — Bitnami spring-cloud-dataflow
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
  cfg = config.openkrill.apps.spring-cloud-dataflow;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  imports = [ ./custom.nix ];

  options.openkrill.apps.spring-cloud-dataflow = {
    enable = mkEnableOption "Bitnami spring-cloud-dataflow";

    namespace = mkOption {
      type = types.str;
      default = "spring-cloud-dataflow";
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
    # openkrill.ingress.routes.spring-cloud-dataflow = {
    #   subdomain = "spring-cloud-dataflow";
    #   namespace = cfg.namespace;
    #   service = "spring-cloud-dataflow";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.spring-cloud-dataflow = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "spring-cloud-dataflow.yaml";
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
    openkrill.manifests.spring-cloud-dataflow.content = [
      (k8s.mkNamespace cfg.namespace)
    ]
    ++ kubelib.fromHelm {
      name = "spring-cloud-dataflow";
      chart = charts.bitnami.spring-cloud-dataflow.latest;
      namespace = cfg.namespace;
      values = cfg.values;
    };
  };
}
