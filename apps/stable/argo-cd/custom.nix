# Custom overrides for this module.
# This file is never overwritten by the generator.
#
# Thin wrapper around the Bitnami Helm chart with Dex authproxy and RBAC
# defaults.  Authelia ForwardAuth authenticates users at the ingress
# layer and sets Remote-User / Remote-Groups headers.  Dex trusts these
# headers via the authproxy connector and maps them to ArgoCD identities.
#
# A cert-manager Certificate is created in the argo-cd namespace so the
# server has a proper TLS cert signed by the cluster CA.  When
# trust-manager is enabled, automatically mounts the cluster trust bundle
# into all ArgoCD components for outbound CA trust (git repos over HTTPS,
# webhooks, etc.).
{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.openkrill.apps.argo-cd;
  domain = config.openkrill.domain;
  trustCfg = config.openkrill.apps.trust-manager;

  trustBundle = {
    name = "trust-bundle";
    configMap = {
      name = trustCfg.bundleConfigMapName;
      items = [{
        key = trustCfg.bundleKey;
        path = "ca-certificates.crt";
      }];
    };
  };

  trustMount = {
    name = "trust-bundle";
    mountPath = "/etc/ssl/certs";
    readOnly = true;
  };
in
{
  options.openkrill.apps.argo-cd = {
    domain = mkOption {
      type = types.str;
      default = "argocd.${domain}";
      description = "FQDN for the ArgoCD web UI (e.g. argocd.example.com).";
    };
  };

  config = mkIf cfg.enable {
    # ── Default Helm values ──────────────────────────────────────────
    # NOTE: The Bitnami chart uses server.config for argocd-cm data,
    # NOT configs.cm.  server.url is a top-level value that the chart
    # templates into server.config.url via {{ .Values.server.url }}.
    openkrill.apps.argo-cd.values = mkMerge [
      {
        fullnameOverride = mkDefault "argocd";
        controller.resourcesPreset = mkDefault "large";
        controller.metrics.enabled = mkDefault true;
        server.url = mkDefault "https://${cfg.domain}";
        server.metrics.enabled = mkDefault true;
        # Dex authproxy connector — trusts Remote-User / Remote-Groups
        # headers set by Authelia ForwardAuth at the ingress layer.
        dex.enabled = mkDefault true;
        server.config = {
          "dex.config" = mkDefault ''
            connectors:
              - type: authproxy
                id: authelia
                name: Authelia
                config:
                  userHeader: Remote-User
                  groupHeader: Remote-Groups
          '';
        };
        repoServer.metrics.enabled = mkDefault true;
        applicationSet.metrics.enabled = mkDefault true;
        notifications.metrics.enabled = mkDefault true;
        global.domain = mkDefault cfg.domain;
        # Use an ExternalSecret-managed secret for Redis auth so the
        # password is generated once and never changes between renders.
        redis.auth.existingSecret = mkDefault "argocd-redis-secret";
        redis.auth.existingSecretPasswordKey = mkDefault "redis-password";
        config.rbac = {
            "policy.csv" = mkDefault "g, lldap_admin, role:admin";
          "policy.default" = mkDefault "role:readonly";
          scopes = mkDefault "[email, groups]";
        };
      }
      # When trust-manager is enabled, mount the cluster trust bundle into
      # every ArgoCD component (server, repo-server, controller).
      # The Bitnami chart has per-component extraVolumes/extraVolumeMounts
      # (no global.extraVolumes).  Mounts to /etc/ssl/certs cover all
      # outbound TLS: OIDC, git over HTTPS, webhooks, etc.
      (mkIf trustCfg.enable {
        server.extraVolumes = [ trustBundle ];
        server.extraVolumeMounts = [ trustMount ];
        controller.extraVolumes = [ trustBundle ];
        controller.extraVolumeMounts = [ trustMount ];
        repoServer.extraVolumes = [ trustBundle ];
        repoServer.extraVolumeMounts = [ trustMount ];
      })
    ];

    # ── cert-manager Certificate for ArgoCD server TLS ───────────────
    # ArgoCD server automatically picks up a secret named
    # "argocd-server-tls" in its namespace if it contains tls.crt and
    # tls.key.  This replaces the runtime self-signed cert.
    openkrill.apps.argo-cd.extraManifests.server-cert = {
      apiVersion = "cert-manager.io/v1";
      kind = "Certificate";
      metadata = {
        name = "argocd-server-tls";
        namespace = cfg.namespace;
      };
      spec = {
        secretName = "argocd-server-tls";
        issuerRef = {
          kind = "ClusterIssuer";
          name = "openkrill-signing-authority";
        };
        dnsNames = [
          cfg.domain
          "argocd-server"
          "argocd-server.${cfg.namespace}"
          "argocd-server.${cfg.namespace}.svc"
          "argocd-server.${cfg.namespace}.svc.cluster.local"
        ];
      };
    };

    # ── Cleanup k3s bootstrap manifests ─────────────────────────────
    # openkrill.manifests fans out into k3s auto-deploy files at
    # /var/lib/rancher/k3s/server/manifests/openkrill-*.  Once ArgoCD
    # is running, those files are redundant — and k3s re-applies them
    # on every restart, causing spurious drift.  This DaemonSet runs
    # on every server node and periodically removes them.
    openkrill.apps.argo-cd.extraManifests.cleanup-manifests = {
      apiVersion = "apps/v1";
      kind = "DaemonSet";
      metadata = {
        name = "cleanup-bootstrap-manifests";
        namespace = cfg.namespace;
      };
      spec = {
        selector.matchLabels.app = "cleanup-bootstrap-manifests";
        template = {
          metadata.labels.app = "cleanup-bootstrap-manifests";
          spec = {
            containers = [{
              name = "cleanup";
              image = "busybox:stable";
              command = [ "sh" "-c" "while true; do rm -rf /host-manifests/openkrill*; sleep 300; done" ];
              volumeMounts = [{
                name = "manifests";
                mountPath = "/host-manifests";
              }];
            }];
            volumes = [{
              name = "manifests";
              hostPath = {
                path = "/var/lib/rancher/k3s/server/manifests";
                type = "DirectoryOrCreate";
              };
            }];
          };
        };
      };
    };

    # ── VictoriaMetrics scrape + alerts ────────────────────────────────
    openkrill.apps.victoriametrics.vmservicescrapes.argo-cd =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        selector.matchLabels."app.kubernetes.io/part-of" = "argocd";
        namespaceSelector.matchNames = [ cfg.namespace ];
        endpoints = [{ port = "metrics"; }];
      };

    openkrill.apps.victoriametrics.vmrules.argo-cd-alerts =
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

    # ── Secret generator (Redis only) ────────────────────────────────
    openkrill.secrets.generators.argo-cd = {
      packages = with pkgs; [ openssl ];
      script = ''
        create_secret openkrill-argocd-redis \
          --from-literal=redis-password="$(openssl rand -hex 24)"
      '';
    };

    # ── ExternalSecret for Redis auth ────────────────────────────────
    # Generated once by the secret generator, synced into argo-cd
    # namespace.  The Bitnami chart reads it via redis.auth.existingSecret.
    openkrill.apps.external-secrets.secrets.argocd-redis-secret = {
      namespace = cfg.namespace;
      remoteSecretName = "openkrill-argocd-redis";
      keys = [ "redis-password" ];
    };

    # ── Ingress route ────────────────────────────────────────────────
    openkrill.ingress.routes.argo-cd = {
      subdomain = "argocd";
      namespace = cfg.namespace;
      service = "argocd-server";
      port = 443;
    };

    # ── BackendTLSPolicy for ArgoCD server ───────────────────────────
    # Traefik connects to argocd-server on port 443 (HTTPS).  Without
    # this policy Traefik uses the pod IP for TLS verification, which
    # fails because the cert has DNS SANs but no IP SANs.  The policy
    # tells Traefik to use the service FQDN as the SNI hostname and to
    # trust the system CAs (the openkrill trust bundle is already
    # mounted at /etc/ssl/certs in the Traefik pod).
    openkrill.apps."gateway-api".backendtlspolicies.argocd-server = {
      namespace = cfg.namespace;
      targetRefs = [{
        group = "";
        kind = "Service";
        name = "argocd-server";
      }];
      validation = {
        hostname = "argocd-server.${cfg.namespace}.svc";
        wellKnownCACertificates = "System";
      };
    };
  };
}
