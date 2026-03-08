# modules/theia-ide — Theia IDE
# Deploys Eclipse Theia IDE from GHCR via bjw-s app-template.
{ config, lib, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.theia-ide;
  helpers = import ../lib/helpers.nix { inherit lib; };

  chart = kubelib.downloadHelmChart {
    repo = "https://bjw-s-labs.github.io/helm-charts/";
    chart = "app-template";
    version = "4.6.2";
    chartHash = "sha256-+ClIestqvDytE459npFyVU4ET2Rsy1CC3XgKY/vnRrs=";
  };

  defaults = {
    controllers.main = {
      containers.main = {
        image = {
          repository = "ghcr.io/eclipse-theia/theia-ide/theia-ide";
          tag = "latest";
        };
      };
    };

    service.main = {
      controller = "main";
      ports.http = {
        port = 3000;
      };
    };

    persistence.data = {
      enabled = true;
      type = "persistentVolumeClaim";
      accessMode = "ReadWriteOnce";
      size = "10Gi";
      globalMounts = [
        { path = "/home/theia"; }
      ];
    };
  };
in
{
  options.openkrill.apps.theia-ide = {
    enable = mkEnableOption "Theia IDE";

    namespace = mkOption {
      type = types.str;
      default = "theia-ide";
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
        theia-ide.content = kubelib.fromHelm {
          name = "theia-ide";
          inherit chart;
          namespace = cfg.namespace;
          values = recursiveUpdate defaults cfg.values;
        };
      }
      (helpers.mkExtraManifestsConfig "theia-ide" cfg.extraManifests)
    ];
  };
}
