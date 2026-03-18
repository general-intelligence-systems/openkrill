# apps/longhorn — Longhorn distributed block storage
# Deploys the Longhorn storage system via Helm, providing replicated
# persistent volumes for Kubernetes workloads.
{ config, lib, charts, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.longhorn;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  options.openkrill.apps.longhorn = {
    enable = mkEnableOption "Longhorn distributed block storage";

    namespace = mkOption {
      type = types.str;
      default = "longhorn-system";
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
    openkrill.apps.victoriametrics.vmservicescrapes.longhorn =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        selector.matchLabels.app = "longhorn-manager";
        namespaceSelector.matchNames = [ cfg.namespace ];
        endpoints = [{ port = "manager"; }];
      };

    openkrill.apps.victoriametrics.vmrules.longhorn-alerts =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        groups = [{
          name = "longhorn";
          rules = [
            {
              alert = "LonghornVolumeActualSpaceUsedWarning";
              expr = ''(longhorn_volume_actual_size_bytes / longhorn_volume_capacity_bytes) * 100 > 90'';
              "for" = "5m";
              labels.severity = "warning";
              annotations = {
                summary = "Longhorn volume {{ $labels.volume }} usage above 90%";
                description = "Volume {{ $labels.volume }} on node {{ $labels.node }} is using {{ $value }}% of its capacity.";
              };
            }
            {
              alert = "LonghornNodeDown";
              expr = ''longhorn_node_status{condition="ready"} != 1'';
              "for" = "5m";
              labels.severity = "critical";
              annotations = {
                summary = "Longhorn node {{ $labels.node }} is not ready";
                description = "Longhorn node {{ $labels.node }} has been in a not-ready state for 5 minutes.";
              };
            }
            {
              alert = "LonghornVolumeDegraded";
              expr = ''longhorn_volume_robustness == 2'';
              "for" = "5m";
              labels.severity = "warning";
              annotations = {
                summary = "Longhorn volume {{ $labels.volume }} is degraded";
                description = "Volume {{ $labels.volume }} has been in a degraded state for 5 minutes.";
              };
            }
          ];
        }];
      };

    # ── ArgoCD Application ────────────────────────────────────────────
    openkrill.apps.argo-cd.applications.longhorn = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "{longhorn.yaml,longhorn/*.yaml}";
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
    openkrill.manifests.longhorn.content = import ./helm.nix {
      inherit lib charts kubelib cfg;
    };
  };
}
