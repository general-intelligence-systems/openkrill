# modules/argocd — ArgoCD GitOps controller
#
# Provides a thin wrapper around the Helm chart with CA cert distribution.
# All OIDC, RBAC, and other configuration belongs in the consumer's `values`.
{ config, lib, charts, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.argocd;
  helpers = import ../lib/helpers.nix { inherit lib; };
  domain = config.openkrill.domain;

  caCert = builtins.readFile cfg.caCertFile;

  # Build TLS certificates attrset from trustedDomains
  tlsCerts = builtins.listToAttrs (map (d: {
    name = d;
    value = caCert;
  }) cfg.trustedDomains);

  defaults = {
    fullnameOverride = "argocd";
    global.domain = "argocd.${domain}";
    configs = {
      tls.certificates = tlsCerts;
      cm."oidc.config" = ''
        name: 'Authelia'
        issuer: 'https://auth.${domain}'
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

    caCertFile = mkOption {
      type = types.path;
      description = "Path to the CA cert file for internal TLS trust.";
    };

    trustedDomains = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "Domains whose TLS should be trusted via the CA cert.";
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
