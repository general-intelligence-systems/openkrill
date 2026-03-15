# apps/kamaji-console — Kamaji Console web UI for multi-tenant control planes
{ config, lib, charts, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.kamaji-console;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  defaults = {
    credentialsSecret.nextAuthUrl = "https://${cfg.domain}/";
  };
in
{
  options.openkrill.apps.kamaji-console = {
    enable = mkEnableOption "Kamaji Console web UI";

    namespace = mkOption {
      type = types.str;
      default = "kamaji-system";
    };

    domain = mkOption {
      type = types.str;
      default = "kamaji.${config.openkrill.domain}";
      description = "FQDN for the Kamaji Console (e.g. kamaji.example.com).";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    openkrill.ingress.routes.kamaji-console = {
      subdomain = "kamaji";
      namespace = cfg.namespace;
      service = "kamaji-console";
      port = 80;
    };

    openkrill.apps.argo-cd.applications.kamaji-console = {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "{kamaji-console.yaml,kamaji-console/*.yaml}";
      };
      destination = {
        server = "https://kubernetes.default.svc";
        namespace = cfg.namespace;
      };
      syncPolicy = {
        automated = { prune = true; selfHeal = true; };
        syncOptions = [ "CreateNamespace=true" ];
      };
    };

    openkrill.manifests.kamaji-console.content = let
      clusterScopedKinds = [
        "ClusterRole" "ClusterRoleBinding" "Namespace"
        "CustomResourceDefinition" "PersistentVolume"
        "StorageClass" "IngressClass" "PriorityClass"
      ];
      raw = kubelib.fromHelm {
        name = "kamaji-console";
        chart = charts.clastix.kamaji-console.latest;
        namespace = cfg.namespace;
        values = recursiveUpdate defaults cfg.values;
      };
      # The kamaji-console chart omits metadata.namespace on all
      # namespace-scoped resources, so helm template output lacks it.
      # Without explicit namespaces the k3s auto-deploy bootstrap puts
      # everything into `default`.  Inject cfg.namespace on all
      # namespace-scoped resources to ensure they land in the right place.
      ensureNs = res:
        if builtins.elem (res.kind or "") clusterScopedKinds then res
        else if (res.metadata.namespace or null) != null then res
        else res // { metadata = res.metadata // { namespace = cfg.namespace; }; };
    in map ensureNs raw;
  };
}
