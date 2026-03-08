# modules/trust-manager — cert-manager trust-manager
# Deploys trust-manager + a Bundle that distributes the cluster's internal
# CA (plus public CAs) into every namespace labelled trust-bundle=true.
# Apps mount the resulting `cluster-trust-bundle` ConfigMap instead of
# managing per-app CA ConfigMaps.
{ config, lib, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.trust-manager;
  helpers = import ../lib/helpers.nix { inherit lib; };

  chart = kubelib.downloadHelmChart {
    repo = "https://charts.jetstack.io/";
    chart = "trust-manager";
    version = "v0.16.0";
    chartHash = "sha256-fbvGdEiLj0Y4iDDU2XF9+mXMwEY23BtwLZxB13WWwus=";
  };

  defaults = {
    crds.enabled = true;
  };

  helmResources = kubelib.fromHelm {
    name = "trust-manager";
    inherit chart;
    namespace = cfg.namespace;
    values = recursiveUpdate defaults cfg.values;
  };

  # Bundle: merge public CAs + internal cluster CA, sync to labelled namespaces
  bundle = {
    apiVersion = "trust.cert-manager.io/v1alpha1";
    kind = "Bundle";
    metadata.name = cfg.bundleConfigMapName;
    spec = {
      sources = [
        { useDefaultCAs = true; }
        {
          secret = {
            name = cfg.caSecretName;
            key = cfg.caSecretKey;
          };
        }
      ];
      target = {
        configMap.key = cfg.bundleKey;
        namespaceSelector.matchLabels."trust-bundle" = "true";
      };
    };
  };
in
{
  options.openkrill.apps.trust-manager = {
    enable = mkEnableOption "trust-manager CA bundle distribution";

    namespace = mkOption {
      type = types.str;
      default = "cert-manager";
    };

    caSecretName = mkOption {
      type = types.str;
      description = "Name of the cert-manager CA Secret (in the cert-manager namespace) to include in the bundle.";
    };

    caSecretKey = mkOption {
      type = types.str;
      default = "ca.crt";
      description = "Key within the CA secret containing the PEM certificate.";
    };

    bundleConfigMapName = mkOption {
      type = types.str;
      default = "cluster-trust-bundle";
      description = "Name of the ConfigMap trust-manager syncs into target namespaces.";
    };

    bundleKey = mkOption {
      type = types.str;
      default = "bundle.pem";
      description = "Key within the synced ConfigMap containing the PEM bundle.";
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
        trust-manager.content = helmResources ++ [ bundle ];
      }
      (helpers.mkExtraManifestsConfig "trust-manager" cfg.extraManifests)
    ];
  };
}
