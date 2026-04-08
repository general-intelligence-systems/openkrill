# apps/signoz — SigNoz observability platform
#
# Deploys SigNoz (APM, distributed tracing, metrics, and logs) with its
# bundled ClickHouse, OpenTelemetry collector, and query service.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg     = config.openkrill.apps.signoz;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  domain  = config.openkrill.domain;

  clusterScopedKinds = [
    "ClusterRole" "ClusterRoleBinding" "Namespace"
    "CustomResourceDefinition" "PersistentVolume"
    "StorageClass" "IngressClass" "PriorityClass"
  ];

  defaults = {
    # Disable built-in ingress; we use openkrill ingress routes.
    frontend.ingress.enabled = false;
  };

  raw = kubelib.fromHelm {
    name      = "signoz";
    chart     = charts.signoz.signoz.versions."0.117.1";
    namespace = cfg.namespace;
    values    = recursiveUpdate defaults cfg.values;
  };

  ensureNs = res:
    if builtins.elem (res.kind or "") clusterScopedKinds then res
    else if (res.metadata.namespace or null) != null then res
    else res // { metadata = res.metadata // { namespace = cfg.namespace; }; };
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
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Route ──────────────────────────────────────────────────────
    openkrill.ingress.routes.signoz = {
      subdomain = "signoz";
      namespace = cfg.namespace;
      service   = "signoz-frontend";
      port      = 3301;
    };

    # ── ArgoCD Application ──────────────────────────────────────────
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

    # ── Manifests ───────────────────────────────────────────────────
    openkrill.manifests.signoz.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ map ensureNs raw;
  };
}
