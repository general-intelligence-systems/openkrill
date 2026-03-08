# modules/cert-manager — cert-manager controller + CRDs
# Deploys the cert-manager controller, webhook, and CRDs.
# Required by self-signed-cert for ClusterIssuers and Certificates.
{ config, lib, charts, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.cert-manager;
  helpers = import ../lib/helpers.nix { inherit lib; };

  defaults = {
    crds.enabled = true;
  };
in
{
  options.openkrill.apps.cert-manager = {
    enable = mkEnableOption "cert-manager TLS certificate controller";

    namespace = mkOption {
      type = types.str;
      default = "cert-manager";
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
        cert-manager.content = kubelib.fromHelm {
          name = "cert-manager";
          chart = charts.jetstack.cert-manager;
          namespace = cfg.namespace;
          values = recursiveUpdate defaults cfg.values;
        };
      }
      (helpers.mkExtraManifestsConfig "cert-manager" cfg.extraManifests)
    ];
  };
}
