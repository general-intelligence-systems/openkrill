# apps/theia-ide — Theia IDE
# Deploys Eclipse Theia IDE from GHCR via bjw-s app-template.
{ config, lib, charts, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.theia-ide;
  helpers          = import ../../../modules/lib/helpers.nix { inherit lib; };
  appTemplate      = import ../../../modules/lib/app-template.nix { inherit lib; };

  chart = charts.bjw-s.app-template.latest;

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
      type = appTemplate.valuesType;
      default = {};
      description = "app-template Helm chart values (typed).";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    openkrill.ingress.routes.theia-ide = {
      subdomain = "theia";
      namespace = cfg.namespace;
      service = "theia-ide";
      port = 3000;
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

    openkrill.manifests.theia-ide.content = kubelib.fromHelm {
      name = "theia-ide";
      inherit chart;
      namespace = cfg.namespace;
      values = recursiveUpdate defaults cfg.values;
    };
  };
}
