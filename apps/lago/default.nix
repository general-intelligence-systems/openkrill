# apps/lago — Lago open-source billing and metering platform
# Deploys the Lago API, frontend, Sidekiq workers, and supporting services.
{ config, lib, charts, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.lago;
  helpers = import ../../modules/lib/helpers.nix { inherit lib; };
  domain = config.openkrill.domain;
  authFilters = if config.openkrill.apps.authelia.enable && config.openkrill.apps.traefik.enable
    then [{ type = "ExtensionRef"; extensionRef = { group = "traefik.io"; kind = "Middleware"; name = "forwardauth-authelia"; }; }]
    else [];

  defaults = { };
in
{
  options.openkrill.apps.lago = {
    enable = mkEnableOption "Lago open-source billing and metering platform";

    namespace = mkOption {
      type = types.str;
      default = "lago";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    openkrill.apps."gateway-api".httproutes.lago = helpers.mkHTTPRoute {
      subdomain = "lago";
      namespace = cfg.namespace;
      service = "lago-front";
      port = 80;
      filters = authFilters;
      inherit domain;
    };

    openkrill.apps.argocd.applications.lago = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "lago.yaml";
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

    openkrill.manifests = mkMerge [
      {
        lago.content = kubelib.fromHelm {
          name = "lago";
          chart = charts.getlago.lago;
          namespace = cfg.namespace;
          values = recursiveUpdate defaults cfg.values;
        };
      }
      (helpers.mkExtraManifestsConfig "lago" cfg.extraManifests)
    ];
  };
}
