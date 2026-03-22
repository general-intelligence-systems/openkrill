# apps/guacamole — Apache Guacamole clientless remote desktop gateway
#
# Deploys Apache Guacamole via the general-intelligence-systems/guacamole
# Helm chart.  Supports VNC, RDP, and SSH with optional OIDC/SAML
# authentication.  Configure via the values option.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.guacamole;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  options.openkrill.apps.guacamole = {
    enable = mkEnableOption "Apache Guacamole remote desktop gateway";

    namespace = mkOption {
      type = types.str;
      default = "guacamole";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Route ──────────────────────────────────────────────────────
    openkrill.ingress.routes.guacamole = {
      subdomain = "guacamole";
      namespace = cfg.namespace;
      service   = "guacamole-guacamole";
      port      = 8080;
    };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.guacamole = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project   = "default";
      source = {
        repoURL        = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path           = ".";
        directory.include = "guacamole.yaml";
      };
      destination = {
        server    = "https://kubernetes.default.svc";
        namespace = cfg.namespace;
      };
      syncPolicy = {
        automated   = { prune = true; selfHeal = true; };
        syncOptions = [ "CreateNamespace=true" ];
      };
    };

    # ── Manifests ───────────────────────────────────────────────────
    openkrill.manifests.guacamole.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ import ./helm.nix { inherit lib charts kubelib cfg; };
  };
}
