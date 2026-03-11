# apps/forgejo — Forgejo git hosting
#
# Self-hosted Git with reverse-proxy authentication via Authelia.
# Actions runners are a separate module (forgejo-runner).
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.forgejo;
  helpers = import ../../modules/lib/helpers.nix { inherit lib; };
  domain = config.openkrill.domain;

  defaults = {
    gitea.config = {
      server = {
        ROOT_URL = "https://${cfg.domain}/";
        DOMAIN = cfg.domain;
        SSH_DOMAIN = cfg.domain;
      };
      security = {
        INSTALL_LOCK = true;
        REVERSE_PROXY_AUTHENTICATION_USER = "Remote-User";
        REVERSE_PROXY_AUTHENTICATION_EMAIL = "Remote-Email";
      };
      service = {
        ENABLE_REVERSE_PROXY_AUTHENTICATION = true;
        ENABLE_REVERSE_PROXY_AUTO_REGISTRATION = true;
        ENABLE_REVERSE_PROXY_EMAIL = true;
        DISABLE_REGISTRATION = true;
        ALLOW_ONLY_EXTERNAL_REGISTRATION = true;
      };
      openid.ENABLE_OPENID_SIGNIN = false;
      oauth2.ENABLED = false;
      actions = {
        ENABLED = true;
        DEFAULT_ACTIONS_URL = "self";
      };
      migrations = {
        HTTP_CLIENT_TIMEOUT = 3600;
        MAX_ATTEMPTS = 5;
      };
      "git.timeout" = {
        CLONE = 3600;
        MIGRATE = 3600;
      };
      repository.MAX_CREATION_LIMIT = -1;
    };
    persistence = {
      enabled = true;
      size = cfg.persistence.size;
      storageClass = cfg.persistence.storageClass;
    };
  };
in
{
  options.openkrill.apps.forgejo = {
    enable = mkEnableOption "Forgejo git hosting";

    namespace = mkOption {
      type = types.str;
      default = "forgejo";
    };

    domain = mkOption {
      type = types.str;
      default = "git.${domain}";
      description = "FQDN for the Forgejo instance (e.g. git.example.com).";
    };

    persistence.size = mkOption {
      type = types.str;
      default = "10Gi";
    };

    persistence.storageClass = mkOption {
      type = types.str;
      default = "local-path";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Gateway API HTTPRoute ───────────────────────────────────────
    openkrill.apps."gateway-api".httproutes.forgejo = helpers.mkHTTPRoute {
      subdomain = "git";
      namespace = cfg.namespace;
      service = "forgejo-http";
      port = 3000;
      inherit domain;
    };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argocd.applications.forgejo = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "forgejo.yaml";
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

    # ── Manifests ───────────────────────────────────────────────────
    openkrill.manifests = mkMerge [
      {
        forgejo.content =
          [ (k8s.mkNamespace cfg.namespace) ]
          ++ kubelib.fromHelm {
            name = "forgejo";
            chart = charts.forgejo-helm.forgejo;
            namespace = cfg.namespace;
            values = recursiveUpdate defaults cfg.values;
          };
      }
      (helpers.mkExtraManifestsConfig "forgejo" cfg.extraManifests)
    ];
  };
}
