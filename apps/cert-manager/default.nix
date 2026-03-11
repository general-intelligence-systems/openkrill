# apps/cert-manager — cert-manager controller + CRDs
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
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.cert-manager;
  helpers          = import ../../modules/lib/helpers.nix { inherit lib; };
  networkPolicyLib = import ../../modules/lib/network-policy.nix { inherit lib; };

  defaults = {
    crds.enabled = true;
  };

  helmResources = kubelib.fromHelm {
    name = "cert-manager";
    chart = charts.jetstack.cert-manager;
    namespace = cfg.namespace;
    values = recursiveUpdate defaults cfg.values;
  };

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
    enable = mkEnableOption "cert-manager TLS certificate controller";

    namespace = mkOption {
      type = types.str;
      default = "cert-manager";
    };

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

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    networkPolicy = networkPolicyLib.mkNetworkPolicyOption;
    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    openkrill.apps.cert-manager.networkPolicy = {
      ingress = [
        { from = "victoriametrics"; ports = [{ port = 9402; }]; }
      ];
      egress = [
        { to = "kubernetes-api"; }
        { to = "world"; ports = [{ port = 443; }]; }
        { to = "dns"; }
      ];
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

    openkrill.apps.argocd.applications.cert-manager = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "cert-manager.yaml";
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

    openkrill.manifests = mkMerge [
      {
        cert-manager.content =
          [ (k8s.mkNamespace cfg.namespace) ]
          ++ helmResources
          ++ optionals cfg.selfSignedCA.enable caResources;
      }
      (helpers.mkExtraManifestsConfig "cert-manager" cfg.extraManifests)
    ];
  };
}
