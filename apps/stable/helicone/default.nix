# apps/helicone — Helicone LLM observability platform
#
# Open-source LLM observability: logging, monitoring, and analytics
# for AI applications.  Deploys the Helicone Helm chart from the
# nixhelm2 contrib catalog.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg     = config.openkrill.apps.helicone;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  domain  = config.openkrill.domain;

  clusterScopedKinds = [
    "ClusterRole" "ClusterRoleBinding" "Namespace"
    "CustomResourceDefinition" "PersistentVolume"
    "StorageClass" "IngressClass" "PriorityClass"
  ];

  defaults = {
    # Disable built-in ingress; we use openkrill ingress routes.
    ingress.enabled = false;
  };

  raw = kubelib.fromHelm {
    name      = "helicone";
    chart     = charts.contrib.helicone.helicone.versions."0.1.42";
    namespace = cfg.namespace;
    values    = recursiveUpdate defaults cfg.values;
  };

  ensureNs = res:
    if builtins.elem (res.kind or "") clusterScopedKinds then res
    else if (res.metadata.namespace or null) != null then res
    else res // { metadata = res.metadata // { namespace = cfg.namespace; }; };
in
{
  options.openkrill.apps.helicone = {
    enable = mkEnableOption "Helicone LLM observability platform";

    namespace = mkOption {
      type = types.str;
      default = "helicone";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # -- Route ---------------------------------------------------------------
    openkrill.ingress.routes.helicone = {
      subdomain = "helicone";
      namespace = cfg.namespace;
      service   = "helicone";
      port      = 3000;
    };

    # -- ArgoCD Application --------------------------------------------------
    openkrill.apps.argo-cd.applications.helicone = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project   = "default";
      source = {
        repoURL        = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path           = ".";
        directory.include = "helicone.yaml";
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

    # -- Manifests -----------------------------------------------------------
    openkrill.manifests.helicone.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ map ensureNs raw;
  };
}
