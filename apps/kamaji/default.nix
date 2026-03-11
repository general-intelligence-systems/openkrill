# apps/kamaji — Kamaji multi-tenant Kubernetes control plane manager
# Deploys the Kamaji operator, CRDs, and optional bundled etcd datastore.
{ config, lib, charts, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.kamaji;
  helpers = import ../../modules/lib/helpers.nix { inherit lib; };

  defaults = {
    # Disable analytics traces by default
    telemetry.disabled = true;
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

    openkrill.manifests = mkMerge [
      {
        kamaji.content = kubelib.fromHelm {
          name = "kamaji";
          chart = charts.clastix.kamaji;
          namespace = cfg.namespace;
          values = recursiveUpdate defaults cfg.values;
        };
      }
      (helpers.mkExtraManifestsConfig "kamaji" cfg.extraManifests)
    ];
  };
}
