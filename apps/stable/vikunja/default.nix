# apps/vikunja — Vikunja task management
#
# Open-source, self-hosted to-do / project management application.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.vikunja;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  domain  = config.openkrill.domain;

  clusterScopedKinds = [
    "ClusterRole" "ClusterRoleBinding" "Namespace"
    "CustomResourceDefinition" "PersistentVolume"
    "StorageClass" "IngressClass" "PriorityClass"
  ];

  defaults = {
    ingress.main.enabled = false;
  };

  raw = kubelib.fromHelm {
    name      = "vikunja";
    chart     = charts.vikunja.vikunja.latest;
    namespace = cfg.namespace;
    values    = recursiveUpdate defaults cfg.values;
  };

  ensureNs = res:
    if builtins.elem (res.kind or "") clusterScopedKinds then res
    else if (res.metadata.namespace or null) != null then res
    else res // { metadata = res.metadata // { namespace = cfg.namespace; }; };
in
{
  options.openkrill.apps.vikunja = {
    enable = mkEnableOption "Vikunja task management";

    namespace = mkOption {
      type = types.str;
      default = "vikunja";
    };

    domain = mkOption {
      type = types.str;
      default = "tasks.${domain}";
      description = "FQDN for the Vikunja instance.";
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
    openkrill.ingress.routes.vikunja = {
      subdomain = "tasks";
      namespace = cfg.namespace;
      service   = "vikunja";
      port      = 3456;
    };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.vikunja = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project   = "default";
      source = {
        repoURL        = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path           = ".";
        directory.include = "vikunja.yaml";
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
    openkrill.manifests.vikunja.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ map ensureNs raw;
  };
}
