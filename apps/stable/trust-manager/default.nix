# apps/trust-manager — cert-manager trust-manager
#
# Deploys trust-manager + a Bundle that distributes CA certificates into
# every namespace as a ConfigMap (openkrill-ca-bundle).
#
# CA sources are built dynamically:
#   - Public CAs are always included (useDefaultCAs).
#   - When cert-manager's selfSignedCA is enabled (the default), the
#     in-cluster CA Secret is auto-wired as a source — zero config needed.
#   - Users can override caSecretName to point at a different Secret.
#   - Users can set caCertFile to embed an external CA cert inline.
#
# Apps mount the resulting ConfigMap instead of managing per-app CA trust.
{ config, lib, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.trust-manager;
  certManagerCfg = config.openkrill.apps.cert-manager;
  helpers          = import ../../../modules/lib/helpers.nix { inherit lib; };
  chart = kubelib.downloadHelmChart {
    repo = "https://charts.jetstack.io/";
    chart = "trust-manager";
    version = "v0.16.0";
    chartHash = "sha256-fbvGdEiLj0Y4iDDU2XF9+mXMwEY23BtwLZxB13WWwus=";
  };

  defaults = {
    crds.enabled = true;
  };

  helmResources = kubelib.fromHelm {
    name = "trust-manager";
    inherit chart;
    namespace = cfg.namespace;
    values = recursiveUpdate defaults cfg.values;
  };

  # Auto-wire: if the user didn't set caSecretName but cert-manager's
  # selfSignedCA is enabled, default to the cert-manager CA Secret.
  effectiveCaSecretName =
    if cfg.caSecretName != null then cfg.caSecretName
    else if certManagerCfg.enable && certManagerCfg.selfSignedCA.enable
    then certManagerCfg.selfSignedCA.secretName
    else null;

  # Bundle sources are built dynamically from what's available.
  bundleSources =
    [ { useDefaultCAs = true; } ]
    ++ optional (effectiveCaSecretName != null) {
      secret = {
        name = effectiveCaSecretName;
        key = cfg.caSecretKey;
      };
    }
    ++ optional (cfg.caCertFile != null) {
      inLine = builtins.readFile cfg.caCertFile;
    };

  bundle = {
    apiVersion = "trust.cert-manager.io/v1alpha1";
    kind = "Bundle";
    metadata.name = cfg.bundleConfigMapName;
    spec = {
      sources = bundleSources;
      target.configMap.key = cfg.bundleKey;
    };
  };
in
{
  options.openkrill.apps.trust-manager = {
    enable = mkEnableOption "trust-manager CA bundle distribution";

    namespace = mkOption {
      type = types.str;
      default = "cert-manager";
    };

    caSecretName = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = ''
        Name of a Secret (in the cert-manager namespace) containing a CA
        certificate to include in the trust bundle.  When null and
        cert-manager's selfSignedCA is enabled, automatically defaults to
        the cert-manager CA Secret (openkrill-authority-secret).
      '';
    };

    caSecretKey = mkOption {
      type = types.str;
      default = "ca.crt";
      description = "Key within the CA Secret containing the PEM certificate.";
    };

    caCertFile = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = ''
        Path to an external CA certificate file (PEM).  When set, the
        certificate is read at Nix evaluation time and embedded as an
        inline source in the trust-manager Bundle.
      '';
    };

    bundleConfigMapName = mkOption {
      type = types.str;
      default = "openkrill-ca-bundle";
      description = "Name of the Bundle resource and the ConfigMap trust-manager syncs into target namespaces.";
    };

    bundleKey = mkOption {
      type = types.str;
      default = "bundle.pem";
      description = "Key within the synced ConfigMap containing the PEM bundle.";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── VictoriaMetrics scrape ─────────────────────────────────────────
    openkrill.apps.victoriametrics.vmservicescrapes.trust-manager =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        selector.matchLabels."app.kubernetes.io/name" = "trust-manager";
        namespaceSelector.matchNames = [ cfg.namespace ];
        endpoints = [{ port = "http-metrics"; }];
      };

    openkrill.apps.argocd.applications.trust-manager = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "trust-manager.yaml";
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

    openkrill.manifests.trust-manager.content = [ (k8s.mkNamespace cfg.namespace) ] ++ helmResources ++ [ bundle ];
  };
}
