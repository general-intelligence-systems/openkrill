# apps/metacontroller — Metacontroller for webhook-based K8s controllers
#
# Deploys Metacontroller via the official Helm chart from nixhelm2
# (oci://ghcr.io/metacontroller/metacontroller-helm).  Also provides
# typed CRD helpers for CompositeController and DecoratorController
# resources via openkrill.apps.metacontroller.compositecontrollers.*
# and openkrill.apps.metacontroller.decoratorcontrollers.*.
#
# Usage:
#   openkrill.apps.metacontroller.enable = true;
#
#   openkrill.apps.metacontroller.compositecontrollers.my-ctrl = {
#     namespace = "metacontroller";
#     generateSelector = true;
#     parentResource = { apiVersion = "cia.net/v1"; resource = "foos"; };
#     childResources = [
#       { apiVersion = "v1"; resource = "configmaps"; updateStrategy.method = "InPlace"; }
#     ];
#     hooks.sync.webhook.url = "http://my-svc.my-ns.svc.cluster.local:9292/foos";
#   };
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg     = config.openkrill.apps.metacontroller;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };

  defaults = {
    # Wire the image option into the chart values
    image.tag = cfg.image.tag;
  };
in
{
  imports = [ ./crds.nix ];

  options.openkrill.apps.metacontroller = {
    enable = mkEnableOption "Metacontroller";

    namespace = mkOption {
      type = types.str;
      default = "metacontroller";
    };

    image = {
      repository = mkOption {
        type = types.str;
        default = "metacontrollerio/metacontroller";
        description = "Metacontroller container image repository.";
      };
      tag = mkOption {
        type = types.str;
        default = "v4.15.0";
        description = "Metacontroller container image tag.";
      };
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
    openkrill.apps.victoriametrics.vmservicescrapes.metacontroller =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        selector.matchLabels."app.kubernetes.io/name" = "metacontroller";
        namespaceSelector.matchNames = [ cfg.namespace ];
        endpoints = [{ port = "9999"; path = "/metrics"; }];
      };

    openkrill.apps.victoriametrics.vmrules.metacontroller-alerts =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        groups = [{
          name = "metacontroller";
          rules = [{
            alert = "MetacontrollerDown";
            expr = ''up{job=~".*metacontroller.*"} == 0'';
            "for" = "5m";
            labels.severity = "critical";
            annotations = {
              summary = "Metacontroller is down";
              description = "Metacontroller has been unreachable for 5 minutes.";
            };
          }];
        }];
      };

    # ── SigNoz scrape target ─────────────────────────────────────────
    openkrill.apps.signoz.scrapeTargets.metacontroller =
      mkIf config.openkrill.apps.signoz.enable {
        job_name = "metacontroller";
        metrics_path = "/metrics";
        kubernetes_sd_configs = [{
          role = "endpoints";
          namespaces.names = [ cfg.namespace ];
        }];
        relabel_configs = [
          {
            source_labels = [ "__meta_kubernetes_service_label_app_kubernetes_io_name" ];
            action = "keep";
            regex = "metacontroller";
          }
          {
            source_labels = [ "__meta_kubernetes_endpoint_port_name" ];
            action = "keep";
            regex = "9999";
          }
        ];
      };

    # ── ArgoCD Application ────────────────────────────────────────────
    openkrill.apps.argo-cd.applications.metacontroller = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "metacontroller.yaml";
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

    # ── Manifests ─────────────────────────────────────────────────────
    openkrill.manifests.metacontroller.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name      = "metacontroller";
        chart     = charts.contrib.metacontroller.metacontroller-helm.versions."4.15.0";
        namespace = cfg.namespace;
        values    = recursiveUpdate defaults cfg.values;
      };
  };
}
