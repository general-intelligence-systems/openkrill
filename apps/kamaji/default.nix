# apps/kamaji — Kamaji multi-tenant Kubernetes control plane manager
# Deploys the Kamaji operator, CRDs, and optional bundled etcd datastore.
{ config, lib, charts, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.kamaji;
  helpers          = import ../../modules/lib/helpers.nix { inherit lib; };
  defaults = {
    # Enable telemetry for Prometheus metrics scraping
    telemetry.disabled = false;
  };
in
{
  options.openkrill.apps.kamaji = {
    enable = mkEnableOption "Kamaji multi-tenant Kubernetes control plane manager";

    namespace = mkOption {
      type = types.str;
      default = "kamaji-system";
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
    openkrill.apps.victoriametrics.vmservicescrapes.kamaji =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        selector.matchLabels."app.kubernetes.io/name" = "kamaji";
        namespaceSelector.matchNames = [ cfg.namespace ];
        endpoints = [{ port = "metrics"; }];
      };

    openkrill.apps.victoriametrics.vmrules.kamaji-alerts =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        groups = [{
          name = "kamaji";
          rules = [{
            alert = "KamajiDown";
            expr = ''up{job=~".*kamaji.*"} == 0'';
            "for" = "5m";
            labels.severity = "critical";
            annotations = {
              summary = "Kamaji operator is down";
              description = "Kamaji control plane manager has been unreachable for 5 minutes.";
            };
          }];
        }];
      };

    openkrill.apps.argocd.applications.kamaji = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "kamaji.yaml";
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

    openkrill.manifests.kamaji.content = kubelib.fromHelm {
      name = "kamaji";
      chart = charts.clastix.kamaji;
      namespace = cfg.namespace;
      values = recursiveUpdate defaults cfg.values;
    };
  };
}
