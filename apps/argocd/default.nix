# apps/argocd — ArgoCD GitOps controller
#
# Thin wrapper around the Helm chart with Authelia OIDC and RBAC defaults.
# When trust-manager is enabled, automatically mounts the cluster trust
# bundle into all ArgoCD components for outbound CA trust (OIDC, git
# repos over HTTPS, webhooks, etc.).
{ config, lib, pkgs, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.argocd;
  helpers          = import ../../modules/lib/helpers.nix { inherit lib; };
  networkPolicyLib = import ../../modules/lib/network-policy.nix { inherit lib; };
  domain = config.openkrill.domain;
  trustCfg = config.openkrill.apps.trust-manager;

  defaults = {
    fullnameOverride = "argocd";
    controller.metrics.enabled = true;
    server.metrics.enabled = true;
    repoServer.metrics.enabled = true;
    applicationSet.metrics.enabled = true;
    notifications.metrics.enabled = true;
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
        clientID: 'openkrill'
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

    networkPolicy = networkPolicyLib.mkNetworkPolicyOption;
    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Register ArgoCD redirect URI on the shared OIDC client ──────
    openkrill.apps.authelia.sharedClient.redirectUris =
      mkIf config.openkrill.apps.authelia.enable
        [ "https://${cfg.domain}/auth/callback" ];

    openkrill.apps.argocd.networkPolicy = {
      ingress = [
        { from = "traefik"; ports = [{ port = 80; }]; }
        { from = "victoriametrics"; ports = [{ port = 8082; } { port = 8083; } { port = 8084; }]; }
      ];
      egress = [
        { to = "core-dns"; ports = [{ port = 9418; }]; }
        { to = "kubernetes-api"; }
        { to = "dns"; }
      ];
    };

    # ── VictoriaMetrics scrape + alerts ────────────────────────────────
    openkrill.apps.victoriametrics.vmservicescrapes.argocd =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        selector.matchLabels."app.kubernetes.io/part-of" = "argocd";
        namespaceSelector.matchNames = [ cfg.namespace ];
        endpoints = [{ port = "metrics"; }];
      };

    openkrill.apps.victoriametrics.vmrules.argocd-alerts =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        groups = [{
          name = "argocd";
          rules = [
            {
              alert = "ArgoAppOutOfSync";
              expr = ''sum(argocd_app_info{sync_status!="Synced"}) > 0'';
              "for" = "15m";
              labels.severity = "warning";
              annotations = {
                summary = "ArgoCD applications out of sync";
                description = "One or more ArgoCD applications have been out of sync for 15 minutes.";
              };
            }
            {
              alert = "ArgoAppDegraded";
              expr = ''sum(argocd_app_info{health_status!~"Healthy|Progressing"}) > 0'';
              "for" = "15m";
              labels.severity = "warning";
              annotations = {
                summary = "ArgoCD applications degraded";
                description = "One or more ArgoCD applications are in a degraded health state.";
              };
            }
          ];
        }];
      };
    # ── Secret generator ─────────────────────────────────────────────
    # The OIDC client secret is deterministic — it must match the value
    # in Authelia's oidcClients config (which defaults to
    # "$plaintext$<client_id>-oidc-client-secret-<domain>").
    # ArgoCD's Helm chart reads it from a K8s Secret referenced in
    # configs.cm."oidc.config" as $argocd-oidc-secret:oidc.authelia.clientSecret.
    openkrill.secrets.generators.argocd = {
      packages = [];
      script = ''
        create_secret openkrill-argocd-oidc-secret \
          --from-literal=oidc.authelia.clientSecret="openkrill-oidc-client-secret-$DOMAIN"
      '';
    };

    # ── ExternalSecret for the OIDC client secret ────────────────────
    openkrill.apps.external-secrets.secrets.argocd-oidc-secret = {
      namespace = cfg.namespace;
      remoteSecretName = "openkrill-argocd-oidc-secret";
      keys = [ "oidc.authelia.clientSecret" ];
    };

    openkrill.ingress.routes.argocd = {
      subdomain = "argocd";
      namespace = cfg.namespace;
      service = "argocd-server";
      port = 443;
    };

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

    openkrill.manifests.argocd.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name = "argo-cd";
        chart = charts.argoproj.argo-cd;
        namespace = cfg.namespace;
        values = recursiveUpdate defaults cfg.values;
      };
  };
}
