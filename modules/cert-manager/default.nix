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
    openkrill.apps.argocd.applications.cert-manager = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "cert-manager.yaml";
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
