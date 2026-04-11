# apps/signoz — SigNoz observability platform
#
# Deploys SigNoz (APM, distributed tracing, metrics, and logs) with its
# bundled ClickHouse, OpenTelemetry collector, and query service.
#
# The optional k8sInfra sub-module deploys the SigNoz k8s-infra chart
# which runs OTel collectors as a DaemonSet (node agent) and Deployment
# (cluster metrics/events) to collect telemetry from the cluster and
# forward it to the SigNoz backend.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg     = config.openkrill.apps.signoz;
  infra   = cfg.k8sInfra;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  domain  = config.openkrill.domain;

  clusterScopedKinds = [
    "ClusterRole" "ClusterRoleBinding" "Namespace"
    "CustomResourceDefinition" "PersistentVolume"
    "StorageClass" "IngressClass" "PriorityClass"
  ];

  # ── SigNoz backend chart ──────────────────────────────────────────
  signozDefaults = {
    # Disable built-in ingress; we use openkrill ingress routes.
    frontend.ingress.enabled = false;
  };

  signozRaw = kubelib.fromHelm {
    name      = "signoz";
    chart     = charts.signoz.signoz.versions."0.117.1";
    namespace = cfg.namespace;
    values    = recursiveUpdate signozDefaults cfg.values;
  };

  # ── k8s-infra collection agents chart ─────────────────────────────
  infraDefaults = {
    global = {
      cloud = "others";
      clusterName = infra.clusterName;
      deploymentEnvironment = infra.deploymentEnvironment;
    };
    otelCollectorEndpoint = "signoz-otel-collector.${cfg.namespace}.svc.cluster.local:4317";
    otelInsecure = true;
    presets = {
      otlpExporter.enabled = true;
      loggingExporter.enabled = false;
    };
  };

  infraRaw = kubelib.fromHelm {
    name      = "signoz-k8s-infra";
    chart     = charts.signoz.k8s-infra.versions.${infra.chartVersion};
    namespace = infra.namespace;
    values    = recursiveUpdate infraDefaults infra.values;
  };

  # ── Shared helpers ────────────────────────────────────────────────
  ensureNs = ns: res:
    if builtins.elem (res.kind or "") clusterScopedKinds then res
    else if (res.metadata.namespace or null) != null then res
    else res // { metadata = res.metadata // { namespace = ns; }; };
in
{
  options.openkrill.apps.signoz = {
    enable = mkEnableOption "SigNoz observability platform";

    namespace = mkOption {
      type = types.str;
      default = "signoz";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides for the SigNoz backend, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;

    # ── k8s-infra sub-module ──────────────────────────────────────
    k8sInfra = {
      enable = mkEnableOption "SigNoz k8s-infra collection agents (OTel DaemonSet + Deployment)";

      namespace = mkOption {
        type = types.str;
        default = "signoz-k8s-infra";
        description = "Namespace for the k8s-infra collectors.";
      };

      chartVersion = mkOption {
        type = types.str;
        default = "0.15.0";
        description = "k8s-infra Helm chart version.";
      };

      clusterName = mkOption {
        type = types.str;
        default = "kremlin2";
        description = "Cluster identifier shown in SigNoz dashboards.";
      };

      deploymentEnvironment = mkOption {
        type = types.str;
        default = "production";
        description = "Environment label (e.g. production, staging).";
      };

      values = mkOption {
        type = types.attrs;
        default = {};
        description = "Helm chart value overrides for k8s-infra, deep-merged with module defaults.";
      };
    };
  };

  config = mkIf cfg.enable {
    # ── Route ──────────────────────────────────────────────────────
    openkrill.ingress.routes.signoz = {
      subdomain = "signoz";
      namespace = cfg.namespace;
      service   = "signoz";
      port      = 8080;
    };

    # ── ArgoCD Application (backend) ──────────────────────────────
    openkrill.apps.argo-cd.applications.signoz = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project   = "default";
      source = {
        repoURL        = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path           = ".";
        directory.include = "signoz.yaml";
      };
      destination = {
        server    = "https://kubernetes.default.svc";
        namespace = cfg.namespace;
      };
      syncPolicy = {
        automated   = { prune = true; selfHeal = true; };
        syncOptions = [ "CreateNamespace=true" ];
      };
    };

    # ── ArgoCD Application (k8s-infra) ────────────────────────────
    openkrill.apps.argo-cd.applications.signoz-k8s-infra = mkIf (infra.enable && config.openkrill.gitops.generateApplications) {
      namespace = "argo-cd";
      project   = "default";
      source = {
        repoURL        = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path           = ".";
        directory.include = "signoz/k8s-infra.yaml";
      };
      destination = {
        server    = "https://kubernetes.default.svc";
        namespace = infra.namespace;
      };
      syncPolicy = {
        automated   = { prune = true; selfHeal = true; };
        syncOptions = [ "CreateNamespace=true" ];
      };
    };

    # ── Manifests (backend) ───────────────────────────────────────
    openkrill.manifests.signoz.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ map (ensureNs cfg.namespace) signozRaw;

    # ── Manifests (k8s-infra) ─────────────────────────────────────
    openkrill.manifests."signoz/k8s-infra".content = mkIf infra.enable (
      [ (k8s.mkNamespace infra.namespace) ]
      ++ map (ensureNs infra.namespace) infraRaw
    );
  };
}
