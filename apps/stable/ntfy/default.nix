# apps/ntfy — Push notification service
#
# Deploys ntfy via the cyclika94 Helm chart.  ntfy is a simple
# HTTP-based pub-sub notification service for sending push
# notifications to phones and desktops.
#
# Usage:
#   openkrill.apps.ntfy.enable = true;
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg     = config.openkrill.apps.ntfy;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  domain  = config.openkrill.domain;

  defaults = {
    # Sensible chart defaults; override via cfg.values
  };
in
{
  options.openkrill.apps.ntfy = {
    enable = mkEnableOption "ntfy push notification service";

    namespace = mkOption {
      type = types.str;
      default = "ntfy";
      description = "Kubernetes namespace for ntfy.";
    };

    domain = mkOption {
      type = types.str;
      default = "ntfy.${domain}";
      description = "Domain name for the ntfy web UI.";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Ingress route ──────────────────────────────────────────────
    openkrill.ingress.routes.ntfy = {
      subdomain = "ntfy";
      namespace = cfg.namespace;
      service = "ntfy";
      port = 80;
      auth = "none";
    };

    # ── ArgoCD Application CR ──────────────────────────────────────
    openkrill.apps.argo-cd.applications.ntfy = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "ntfy.yaml";
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

    # ── Manifests ──────────────────────────────────────────────────
    openkrill.manifests.ntfy.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name      = "ntfy";
        chart     = charts.cyclika94.ntfy.versions."1.0.0";
        namespace = cfg.namespace;
        values    = recursiveUpdate defaults cfg.values;
      };
  };
}
