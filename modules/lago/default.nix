# modules/lago — Lago open-source billing and metering platform
# Deploys the Lago API, frontend, Sidekiq workers, and supporting services.
{ config, lib, charts, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.lago;
  helpers = import ../lib/helpers.nix { inherit lib; };

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
