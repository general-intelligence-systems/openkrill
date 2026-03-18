# apps/litellm — LiteLLM proxy
#
# Unified OpenAI-compatible proxy for multiple LLM providers.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.litellm;
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

  raw = kubelib.fromHelm {
    name      = "litellm";
    chart     = charts.berriai.litellm-helm.latest;
    namespace = cfg.namespace;
    values    = recursiveUpdate defaults cfg.values;
  };

  ensureNs = res:
    if builtins.elem (res.kind or "") clusterScopedKinds then res
    else if (res.metadata.namespace or null) != null then res
    else res // { metadata = res.metadata // { namespace = cfg.namespace; }; };
in
{
  options.openkrill.apps.litellm = {
    enable = mkEnableOption "LiteLLM proxy";

    namespace = mkOption {
      type = types.str;
      default = "litellm";
    };

    domain = mkOption {
      type = types.str;
      default = "litellm.${domain}";
      description = "FQDN for the LiteLLM instance.";
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
    openkrill.ingress.routes.litellm = {
      subdomain = "litellm";
      namespace = cfg.namespace;
      service   = "litellm-helm";
      port      = 4000;
    };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.litellm = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project   = "default";
      source = {
        repoURL        = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path           = ".";
        directory.include = "litellm.yaml";
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
    openkrill.manifests.litellm.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ map ensureNs raw;
  };
}
