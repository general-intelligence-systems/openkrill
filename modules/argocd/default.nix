# modules/argocd — ArgoCD GitOps controller
#
# Thin wrapper around the Helm chart with Authelia OIDC and RBAC defaults.
# When trust-manager is enabled, automatically mounts the cluster trust
# bundle into all ArgoCD components for outbound CA trust (OIDC, git
# repos over HTTPS, webhooks, etc.).
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.argocd;
  helpers = import ../lib/helpers.nix { inherit lib; };
  domain = config.openkrill.domain;
  trustCfg = config.openkrill.apps.trust-manager;

  defaults = {
    fullnameOverride = "argocd";
    global = {
      domain = cfg.domain;
    }
    # When trust-manager is enabled, mount the cluster trust bundle into
    # every ArgoCD component (server, repo-server, controller, dex).
    # This is required because trust-manager outputs a single ConfigMap
    # with concatenated CAs, which is structurally incompatible with
    # ArgoCD's native argocd-tls-certs-cm (hostname-keyed).  Volume
    # mounts to /etc/ssl/certs cover all outbound TLS: OIDC, git over
    # HTTPS, webhooks, etc.
    // optionalAttrs trustCfg.enable {
      extraVolumes = [{
        name = "trust-bundle";
        configMap = {
          name = trustCfg.bundleConfigMapName;
          items = [{
            key = trustCfg.bundleKey;
            path = "ca-certificates.crt";
          }];
        };
      }];
      extraVolumeMounts = [{
        name = "trust-bundle";
        mountPath = "/etc/ssl/certs";
        readOnly = true;
      }];
    };
    configs = {
      cm."oidc.config" = ''
        name: 'Authelia'
        issuer: '${cfg.oidc.issuer}'
        clientID: 'argocd'
        clientSecret: '$argocd-oidc-secret:oidc.authelia.clientSecret'
        cliClientID: 'argocd-cli'
        requestedScopes:
          - 'openid'
          - 'email'
          - 'groups'
        enableUserInfoGroups: true
        userInfoPath: '/api/oidc/userinfo'
      '';
      rbac = {
        "policy.csv" = "g, argocd-admins, role:admin";
        "policy.default" = "role:readonly";
        scopes = "[email, groups]";
      };
    };
  };
in
{
  imports = [
    ./applications.nix
    ./applicationsets.nix
    ./appprojects.nix
  ];

  options.openkrill.apps.argocd = {
    enable = mkEnableOption "ArgoCD GitOps controller";

    namespace = mkOption {
      type = types.str;
      default = "argocd";
    };

    domain = mkOption {
      type = types.str;
      default = "argocd.${domain}";
      description = "FQDN for the ArgoCD web UI (e.g. argocd.example.com).";
    };

    oidc.issuer = mkOption {
      type = types.str;
      default = "https://auth.${domain}";
      description = "OIDC issuer URL for Authelia (e.g. https://auth.example.com).";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    openkrill.apps.argocd.applications.argocd = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "argocd.yaml";
      };
      destination = {
        server = "https://kubernetes.default.svc";
        namespace = cfg.namespace;
      };
      syncPolicy = {
        automated = { prune = true; selfHeal = true; };
        syncOptions = [ "CreateNamespace=true" "ServerSideApply=true" ];
      };
    };

    openkrill.manifests = mkMerge [
      {
        argocd.content = [ (k8s.mkNamespace cfg.namespace) ] ++ kubelib.fromHelm {
          name = "argo-cd";
          chart = charts.argoproj.argo-cd;
          namespace = cfg.namespace;
          values = recursiveUpdate defaults cfg.values;
        };
      }
      (helpers.mkExtraManifestsConfig "argocd" cfg.extraManifests)
    ];
  };
}
