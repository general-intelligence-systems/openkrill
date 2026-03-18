# apps/perses — Perses observability dashboards
#
# Open-source dashboard tool for Prometheus/Thanos metrics visualization.
# Optionally deploys the Perses operator for CRD-based dashboard management.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.perses;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  domain  = config.openkrill.domain;

  clusterScopedKinds = [
    "ClusterRole" "ClusterRoleBinding" "Namespace"
    "CustomResourceDefinition" "PersistentVolume"
    "StorageClass" "IngressClass" "PriorityClass"
  ];

  defaults = {
    ingress.enabled = false;
  };

  persesChart = kubelib.extractChart (kubelib.fetchChart {
    repo = "https://perses.github.io/helm-charts";
    chart = "perses";
    version = "0.20.0";
    chartHash = "sha256-OtAg/MrnfGEyX/aTwYjGgV5A4NZ5D9nV7A0bcBcT0Ag=";
  });

  raw = kubelib.fromHelm {
    name      = "perses";
    chart     = persesChart;
    namespace = cfg.namespace;
    values    = recursiveUpdate defaults cfg.values;
  };

  operatorChart = kubelib.extractChart (kubelib.fetchChart {
    repo = "https://perses.github.io/helm-charts";
    chart = "perses-operator";
    version = "0.2.1";
    chartHash = "sha256-weO6GN7xafyJN21j0TVS7giOsl4e+IpUbk6bbiPlVjc=";
  });

  rawOperator = kubelib.fromHelm {
    name      = "perses-operator";
    chart     = operatorChart;
    namespace = cfg.namespace;
    values    = recursiveUpdate {} cfg.operator.values;
  };

  ensureNs = res:
    if builtins.elem (res.kind or "") clusterScopedKinds then res
    else if (res.metadata.namespace or null) != null then res
    else res // { metadata = res.metadata // { namespace = cfg.namespace; }; };
in
{
  options.openkrill.apps.perses = {
    enable = mkEnableOption "Perses observability dashboards";

    namespace = mkOption {
      type = types.str;
      default = "perses";
    };

    domain = mkOption {
      type = types.str;
      default = "perses.${domain}";
      description = "FQDN for the Perses instance.";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides for Perses, deep-merged with module defaults.";
    };

    operator.enable = mkEnableOption "Perses Kubernetes operator";

    operator.values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides for the Perses operator.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Route ──────────────────────────────────────────────────────
    openkrill.ingress.routes.perses = {
      subdomain = "perses";
      namespace = cfg.namespace;
      service   = "perses";
      port      = 8080;
    };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.perses = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project   = "default";
      source = {
        repoURL        = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path           = ".";
        directory.include = "perses.yaml";
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

    openkrill.apps.argo-cd.applications.perses-operator = mkIf (cfg.operator.enable && config.openkrill.gitops.generateApplications) {
      namespace = "argo-cd";
      project   = "default";
      source = {
        repoURL        = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path           = ".";
        directory.include = "perses-operator.yaml";
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

    # ── Manifests ───────────────────────────────────────────────────
    openkrill.manifests.perses.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ map ensureNs raw;

    openkrill.manifests.perses-operator = mkIf cfg.operator.enable {
      content = map ensureNs rawOperator;
    };
  };
}
