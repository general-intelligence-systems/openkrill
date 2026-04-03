# apps/stable/velero — VMware Tanzu Velero backup tool
{
  config,
  lib,
  charts,
  kubelib,
  k8s,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.openkrill.apps.velero;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  
  # Fetch velero chart directly from vmware-tanzu helm repo since it's not in nixhelm2 yet
  veleroChart = kubelib.fetchChart {
    repo = "https://vmware-tanzu.github.io/helm-charts";
    chart = "velero";
    version = "12.0.0";
    chartHash = "sha256-pOCpfCjKiEXzMjQ3Pqj73gooF06Y5dk5CGwOw0cf1oQ=";
  };
in
{
  options.openkrill.apps.velero = {
    enable = mkEnableOption "VMware Tanzu Velero backup tool";

    namespace = mkOption {
      type = types.str;
      default = "velero";
    };

    values = mkOption {
      type = types.submodule (import ./values.nix);
      default = { };
      description = "Helm chart values. Schema-derived defaults are set automatically.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.velero = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "velero.yaml";
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
        syncOptions = [ "CreateNamespace=true" "ServerSideApply=true" ];
      };
    };

    # ── Manifests ───────────────────────────────────────────────────
    openkrill.manifests.velero.content = [
      (k8s.mkNamespace cfg.namespace)
    ]
    ++ kubelib.fromHelm {
      name = "velero";
      chart = veleroChart;
      namespace = cfg.namespace;
      values = cfg.values;
    };
  };
}
