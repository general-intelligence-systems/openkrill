# apps/code-server — VS Code in the browser
#
# Browser-based VS Code IDE backed by code-server.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.code-server;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  domain  = config.openkrill.domain;

  clusterScopedKinds = [
    "ClusterRole" "ClusterRoleBinding" "Namespace"
    "CustomResourceDefinition" "PersistentVolume"
    "StorageClass" "IngressClass" "PriorityClass"
  ];

  defaults = {
    image = {
      repository = "ghcr.io/general-intelligence-systems/code-server-nix";
      tag        = "latest";
      pullPolicy = "Always";
    };
    ingress.enabled = false;
    persistence = {
      enabled      = true;
      size         = cfg.persistence.size;
      storageClass = cfg.persistence.storageClass;
    };
  };

  raw = kubelib.fromHelm {
    name      = "code-server";
    chart     = charts.general-intelligence-systems.code-server.latest;
    namespace = cfg.namespace;
    values    = recursiveUpdate defaults cfg.values;
  };

  ensureNs = res:
    if builtins.elem (res.kind or "") clusterScopedKinds then res
    else if (res.metadata.namespace or null) != null then res
    else res // { metadata = res.metadata // { namespace = cfg.namespace; }; };
in
{
  options.openkrill.apps.code-server = {
    enable = mkEnableOption "code-server (VS Code in the browser)";

    namespace = mkOption {
      type = types.str;
      default = "code-server";
    };

    domain = mkOption {
      type = types.str;
      default = "code.${domain}";
      description = "FQDN for the code-server instance.";
    };

    persistence.size = mkOption {
      type = types.str;
      default = "10Gi";
    };

    persistence.storageClass = mkOption {
      type = types.str;
      default = "local-path";
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
    openkrill.ingress.routes.code-server = {
      subdomain = "code";
      namespace = cfg.namespace;
      service   = "code-server";
      port      = 8080;
    };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.code-server = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project   = "default";
      source = {
        repoURL        = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path           = ".";
        directory.include = "code-server.yaml";
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
    openkrill.manifests.code-server.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ map ensureNs raw;
  };
}
