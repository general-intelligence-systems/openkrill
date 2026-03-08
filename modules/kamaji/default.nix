# modules/kamaji — Kamaji multi-tenant Kubernetes control plane manager
# Deploys the Kamaji operator, CRDs, and optional bundled etcd datastore.
{ config, lib, charts, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.kamaji;
  helpers = import ../lib/helpers.nix { inherit lib; };

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
    openkrill.argocd.kamaji.serverSideApply = true;

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
