# apps/kubecost — Kubecost cloud cost monitoring
# Deploys Kubecost via Helm for real-time Kubernetes cost visibility,
# allocation tracking, and optimization recommendations.
{ config, lib, charts, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.kubecost;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  options.openkrill.apps.kubecost = {
    enable = mkEnableOption "Kubecost cloud cost monitoring";

    namespace = mkOption {
      type = types.str;
      default = "kubecost";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── VictoriaMetrics scrape + alerts ────────────────────────────────
    openkrill.apps.victoriametrics.vmservicescrapes.kubecost =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        selector.matchLabels."app.kubernetes.io/name" = "cost-analyzer";
        namespaceSelector.matchNames = [ cfg.namespace ];
        endpoints = [{ port = "server"; }];
      };

    openkrill.apps.victoriametrics.vmrules.kubecost-alerts =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        groups = [{
          name = "kubecost";
          rules = [
            {
              alert = "KubecostDown";
              expr = ''up{job=~".*cost-analyzer.*"} == 0'';
              "for" = "5m";
              labels.severity = "critical";
              annotations = {
                summary = "Kubecost cost-analyzer is down";
                description = "Kubecost cost-analyzer has been unreachable for 5 minutes.";
              };
            }
          ];
        }];
      };

    # ── ArgoCD Application ────────────────────────────────────────────
    openkrill.apps.argo-cd.applications.kubecost = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "{kubecost.yaml,kubecost/*.yaml}";
        directory.recurse = true;
      };
      destination = {
        server = "https://kubernetes.default.svc";
        namespace = cfg.namespace;
      };
      syncPolicy = {
        automated = { prune = true; selfHeal = true; };
        syncOptions = [ "CreateNamespace=true" "ServerSideApply=true" ];
      };
    };

    # ── Helm manifests ────────────────────────────────────────────────
    openkrill.manifests.kubecost.content = import ./helm.nix {
      inherit lib charts kubelib cfg;
    };
  };
}
