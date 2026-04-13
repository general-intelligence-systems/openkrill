# Custom overrides for this module.
# This file is never overwritten by the generator.
#
# Deploys the cert-manager controller, webhook, and CRDs.
# When selfSignedCA is enabled (the default), also creates a self-signed
# CA chain:
#   ClusterIssuer/openkrill-origin-authority   (self-signed bootstrap)
#   Certificate/openkrill-internal-certificate  (isCA=true)
#   ClusterIssuer/openkrill-signing-authority   (signs service certs)
#
# The CA keypair is stored in Secret/openkrill-authority-secret, which
# trust-manager auto-wires as the source for cluster-wide CA distribution.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps.cert-manager;

  # Self-signed CA chain: bootstrap issuer → CA certificate → CA issuer
  caResources = [
    # 1. Bootstrap self-signed ClusterIssuer — only used to sign the CA cert.
    {
      apiVersion = "cert-manager.io/v1";
      kind = "ClusterIssuer";
      metadata.name = "openkrill-origin-authority";
      spec.selfSigned = {};
    }
    # 2. The CA certificate itself (isCA=true).  cert-manager stores the
    #    keypair in Secret/openkrill-authority-secret.
    {
      apiVersion = "cert-manager.io/v1";
      kind = "Certificate";
      metadata = {
        name = cfg.selfSignedCA.commonName;
        namespace = cfg.namespace;
      };
      spec = {
        isCA = true;
        commonName = cfg.selfSignedCA.commonName;
        secretName = cfg.selfSignedCA.secretName;
        duration = cfg.selfSignedCA.duration;
        privateKey = { algorithm = "ECDSA"; size = 256; };
        issuerRef = { name = "openkrill-origin-authority"; kind = "ClusterIssuer"; };
      };
    }
    # 3. CA ClusterIssuer — services request certs signed by this CA.
    {
      apiVersion = "cert-manager.io/v1";
      kind = "ClusterIssuer";
      metadata.name = "openkrill-signing-authority";
      spec.ca.secretName = cfg.selfSignedCA.secretName;
    }
  ];
in
{
  options.openkrill.apps.cert-manager = {
    selfSignedCA = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Create an in-cluster self-signed CA chain.  When true, cert-manager
          mints a CA keypair via a self-signed bootstrap issuer and exposes it
          as ClusterIssuer/openkrill-signing-authority for service certificates.
          trust-manager auto-wires to the resulting Secret.
        '';
      };

      secretName = mkOption {
        type = types.str;
        default = "openkrill-authority-secret";
        description = "Name of the Secret cert-manager creates to store the CA keypair.";
      };

      commonName = mkOption {
        type = types.str;
        default = "openkrill-internal-certificate";
        description = "Common name and Certificate resource name for the CA.";
      };

      duration = mkOption {
        type = types.str;
        default = "87600h";
        description = "CA certificate lifetime (default: 10 years).";
      };
    };
  };

  config = mkIf cfg.enable {
    # ── Default Helm values ──────────────────────────────────────────
    openkrill.apps.cert-manager.values = {
      installCRDs = mkDefault true;
    };

    # ── VictoriaMetrics scrape + alerts ────────────────────────────────
    openkrill.apps.victoriametrics.vmservicescrapes.cert-manager =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        selector.matchLabels."app.kubernetes.io/name" = "cert-manager";
        namespaceSelector.matchNames = [ cfg.namespace ];
        endpoints = [{ port = "http-metrics"; }];
      };

    openkrill.apps.victoriametrics.vmrules.cert-manager-alerts =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        groups = [{
          name = "cert-manager";
          rules = [
            {
              alert = "CertManagerCertExpiringSoon";
              expr = ''(certmanager_certificate_expiration_timestamp_seconds - time()) < 604800'';
              "for" = "1h";
              labels.severity = "warning";
              annotations = {
                summary = "Certificate {{ $labels.name }} expires in less than 7 days";
                description = "Certificate {{ $labels.name }} in namespace {{ $labels.namespace }} expires in less than 7 days.";
              };
            }
            {
              alert = "CertManagerCertNotReady";
              expr = ''certmanager_certificate_ready_status{condition="False"} == 1'';
              "for" = "15m";
              labels.severity = "critical";
              annotations = {
                summary = "Certificate {{ $labels.name }} is not ready";
                description = "Certificate {{ $labels.name }} in namespace {{ $labels.namespace }} has been not ready for 15 minutes.";
              };
            }
          ];
        }];
      };

    # ── SigNoz scrape target ─────────────────────────────────────────
    openkrill.apps.signoz.scrapeTargets.cert-manager =
      mkIf config.openkrill.apps.signoz.enable {
        job_name = "cert-manager";
        kubernetes_sd_configs = [{
          role = "endpoints";
          namespaces.names = [ cfg.namespace ];
        }];
        relabel_configs = [
          {
            source_labels = [ "__meta_kubernetes_service_label_app_kubernetes_io_name" ];
            action = "keep";
            regex = "cert-manager";
          }
          {
            source_labels = [ "__meta_kubernetes_endpoint_port_name" ];
            action = "keep";
            regex = "http-metrics";
          }
        ];
      };

    # ── Let's Encrypt ClusterIssuer (DNS-01 via Cloudflare) ─────────
    # Requires a Secret "cloudflare-api-token" in the cert-manager
    # namespace with key "api-token" containing a Cloudflare API token
    # that has Zone:DNS:Edit permissions.
    #
    #   kubectl -n cert-manager create secret generic cloudflare-api-token \
    #     --from-literal=api-token=<YOUR_CF_API_TOKEN>
    openkrill.apps.cert-manager.clusterissuers.letsencrypt = {
      namespace = cfg.namespace;
      acme = {
        server = "https://acme-v02.api.letsencrypt.org/directory";
        email  = "don-vito@kremlin.email";
        privateKeySecretRef.name = "letsencrypt-account-key";
        solvers = [{
          dns01.cloudflare = {
            apiTokenSecretRef = {
              name = "cloudflare-api-token";
              key  = "api-token";
            };
          };
        }];
      };
    };

    # ── Self-signed CA chain ─────────────────────────────────────────
    openkrill.manifests.cert-manager.content =
      mkIf cfg.selfSignedCA.enable caResources;
  };
}
