# apps/element-web — Element Web Matrix client
#
# Deploys Element Web, a static single-page application for the Matrix
# protocol.  No secrets, no database, no PVC — just a ConfigMap with
# config.json, a Deployment serving it via Nginx, and a Service.
#
# When conduwuit is enabled, homeserverUrl and serverName are auto-wired
# from openkrill.domain so zero extra config is needed.
{ config, lib, k8s, ... }:
with lib;
let
  cfg          = config.openkrill.apps.element-web;
  conduwuitCfg = config.openkrill.apps.conduwuit;
  helpers      = import ../../../modules/lib/helpers.nix { inherit lib; };
  domain       = config.openkrill.domain;

  conduwuitEnabled = conduwuitCfg.enable;
in
{
  options.openkrill.apps.element-web = {
    enable = mkEnableOption "Element Web Matrix client";

    namespace = mkOption {
      type = types.str;
      default = "element-web";
      description = "Kubernetes namespace for Element Web.";
    };

    image = {
      repository = mkOption {
        type = types.str;
        default = "vectorim/element-web";
        description = "Element Web container image repository.";
      };
      tag = mkOption {
        type = types.str;
        default = "v1.11.96";
        description = "Element Web container image tag.";
      };
    };

    homeserverUrl = mkOption {
      type = types.str;
      default = if conduwuitEnabled then "https://matrix.${domain}" else "";
      description = ''
        Base URL of the Matrix homeserver that Element Web connects to.
        Auto-derived from openkrill.domain when conduwuit is enabled.
      '';
      example = "https://matrix.example.com";
    };

    serverName = mkOption {
      type = types.str;
      default = if conduwuitEnabled then conduwuitCfg.serverName else domain;
      description = ''
        Matrix server name displayed in the UI.  Auto-derived from
        conduwuit.serverName when conduwuit is enabled, otherwise
        falls back to openkrill.domain.
      '';
      example = "example.com";
    };

    defaultTheme = mkOption {
      type = types.enum [ "light" "dark" ];
      default = "dark";
      description = "Default UI theme.";
    };

    extraConfig = mkOption {
      type = types.attrs;
      default = {};
      description = ''
        Additional config.json keys, deep-merged on top of module
        defaults.  See https://element-hq.github.io/element-web/config
      '';
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Route ──────────────────────────────────────────────────────────
    openkrill.ingress.routes.element-web = {
      subdomain = "element";
      namespace = cfg.namespace;
      service = "element-web";
      port = 80;
    };

    # ── ArgoCD Application CR ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.element-web = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "element-web.yaml";
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

    # ── Manifests ──────────────────────────────────────────────────────
    openkrill.manifests.element-web.content = import ./resources.nix {
      inherit lib cfg;
    };
  };
}
