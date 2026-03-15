# apps/kamaji-console — Kamaji Console web UI for multi-tenant control planes
{ config, lib, charts, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.kamaji-console;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  options.openkrill.apps.kamaji-console = {
    enable = mkEnableOption "Kamaji Console web UI";

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

    openkrill.manifests.kamaji-console.content = kubelib.fromHelm {
      name = "kamaji-console";
      chart = charts.clastix.kamaji-console.latest;
      namespace = cfg.namespace;
      values = cfg.values;
    };
  };
}
