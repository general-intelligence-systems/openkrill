# apps/theia-ide — Theia IDE
# Deploys Eclipse Theia IDE from GHCR via bjw-s app-template.
{ config, lib, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.theia-ide;
  helpers          = import ../../modules/lib/helpers.nix { inherit lib; };
  networkPolicyLib = import ../../modules/lib/network-policy.nix { inherit lib; };
  domain = config.openkrill.domain;
  authFilters = if config.openkrill.apps.authelia.enable && config.openkrill.apps.traefik.enable
    then [{ type = "ExtensionRef"; extensionRef = { group = "traefik.io"; kind = "Middleware"; name = "forwardauth-authelia"; }; }]
    else [];

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

    networkPolicy = networkPolicyLib.mkNetworkPolicyOption;
    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    openkrill.apps.theia-ide.networkPolicy = {
      ingress = [
        { from = "traefik"; ports = [{ port = 3000; }]; }
      ];
      egress = [
        { to = "dns"; }
      ];
    };
    openkrill.apps."gateway-api".httproutes.theia-ide = helpers.mkHTTPRoute {
      subdomain = "theia";
      namespace = cfg.namespace;
      service = "theia-ide";
      port = 3000;
      filters = authFilters;
      inherit domain;
    };

    openkrill.apps.argocd.applications.theia-ide = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "theia-ide.yaml";
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
