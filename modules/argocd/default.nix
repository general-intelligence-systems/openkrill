# modules/argocd — ArgoCD GitOps controller
# OIDC: uses Authelia as the identity provider.
{ config, lib, charts, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.argocd;
  helpers = import ../lib/helpers.nix { inherit lib; };

  caCert = builtins.readFile cfg.caCertFile;
  indentedCaCert = builtins.replaceStrings [ "\n" ] [ "\n  " ] caCert;

  # Build TLS certificates attrset from trustedDomains
  tlsCerts = builtins.listToAttrs (map (d: {
    name = d;
    value = caCert;
  }) cfg.trustedDomains);

  defaults = {
    fullnameOverride = "argocd";
    configs = {
      params = {
        "server.insecure" = "true";
      };
      tls = {
        certificates = tlsCerts;
      };
      cm = {
        url = "https://${cfg.domain}";
        "oidc.config" = ''
          name: Authelia
          issuer: ${cfg.oidc.issuer}
          clientID: argocd
          clientSecret: $argocd-oidc-secret:oidc.authelia.clientSecret
          clientAuthMethod: client_secret_basic
          rootCA: |
            ${indentedCaCert}
          requestedScopes:
            - openid
            - email
            - groups
            - profile
          enableUserInfoGroups: true
          userInfoPath: /api/oidc/userinfo
          userIDKey: email
        '';
      };
      rbac = {
        "policy.csv" = ''
          g, nathankidd@hey.com, role:admin
          p, role:admin, applications, *, */*, allow
          p, role:admin, clusters, *, *, allow
          p, role:admin, repositories, *, *, allow
          p, role:admin, projects, *, *, allow
          p, deploy-bot, applications, sync, */*, allow
          p, deploy-bot, applications, get, */*, allow
        '';
        "policy.default" = "role:readonly";
        scopes = "[email, groups]";
      };
    };
  };
in
{
  options.openkrill.apps.argocd = {
    enable = mkEnableOption "ArgoCD GitOps controller";

    namespace = mkOption {
      type = types.str;
      default = "argocd";
    };

    domain = mkOption {
      type = types.str;
      description = "FQDN for ArgoCD (e.g. argocd.cia.net).";
    };

    caCertFile = mkOption {
      type = types.path;
      description = "Path to the CA cert file for internal TLS trust.";
    };

    trustedDomains = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "Domains whose TLS should be trusted via the CA cert.";
    };

    oidc.issuer = mkOption {
      type = types.str;
      description = "OIDC issuer URL (e.g. https://auth.cia.net).";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    openkrill.argocd.argocd.serverSideApply = true;

    openkrill.manifests = mkMerge [
      {
        argocd.content = kubelib.fromHelm {
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
