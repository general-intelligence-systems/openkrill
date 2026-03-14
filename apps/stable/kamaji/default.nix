# apps/kamaji — Kamaji multi-tenant Kubernetes control plane manager
# Deploys the Kamaji operator, CRDs, and optional bundled etcd datastore.
{ config, lib, charts, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.kamaji;
  helpers          = import ../../../modules/lib/helpers.nix { inherit lib; };
  defaults = {
    # Enable telemetry for Prometheus metrics scraping
    telemetry.disabled = false;
    # Disable the Helm hook-based DataStore creation; we manage it as a
    # standalone manifest so ArgoCD treats it as a regular resource rather
    # than a transient pre-install hook.
    datastore.enabled = false;
    datastore.nameOverride = "default";
  };
in
{
  options.openkrill.apps.kamaji = {
    enable = mkEnableOption "Kamaji multi-tenant Kubernetes control plane manager";

    namespace = mkOption {
      type = types.str;
      default = "kamaji-system";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── VictoriaMetrics scrape + alerts ────────────────────────────────
    openkrill.apps.victoriametrics.vmservicescrapes.kamaji =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        selector.matchLabels."app.kubernetes.io/name" = "kamaji";
        namespaceSelector.matchNames = [ cfg.namespace ];
        endpoints = [{ port = "metrics"; }];
      };

    openkrill.apps.victoriametrics.vmrules.kamaji-alerts =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        groups = [{
          name = "kamaji";
          rules = [{
            alert = "KamajiDown";
            expr = ''up{job=~".*kamaji.*"} == 0'';
            "for" = "5m";
            labels.severity = "critical";
            annotations = {
              summary = "Kamaji operator is down";
              description = "Kamaji control plane manager has been unreachable for 5 minutes.";
            };
          }];
        }];
      };

    openkrill.apps.argocd.applications.kamaji = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "{kamaji.yaml,kamaji/*.yaml}";
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

    openkrill.manifests.kamaji.content = kubelib.fromHelm {
      name = "kamaji";
      chart = charts.clastix.kamaji.latest;
      namespace = cfg.namespace;
      values = recursiveUpdate defaults cfg.values;
    };

    # ── DataStore CR ──────────────────────────────────────────────────
    # The upstream Helm chart creates this as a pre-install hook, which
    # is not reliably applied when rendering through kubelib.fromHelm +
    # ArgoCD.  We declare it as a regular manifest instead.
    openkrill.manifests."kamaji/datastore".content = {
      apiVersion = "kamaji.clastix.io/v1alpha1";
      kind = "DataStore";
      metadata = {
        name = "default";
        namespace = cfg.namespace;
        labels = {
          "kamaji.clastix.io/datastore" = "etcd";
          "app.kubernetes.io/name" = "kamaji";
          "app.kubernetes.io/instance" = "kamaji";
        };
      };
      spec = {
        driver = "etcd";
        endpoints = [
          "etcd-0.etcd.${cfg.namespace}.svc.cluster.local:2379"
          "etcd-1.etcd.${cfg.namespace}.svc.cluster.local:2379"
          "etcd-2.etcd.${cfg.namespace}.svc.cluster.local:2379"
        ];
        tlsConfig = {
          certificateAuthority = {
            certificate.secretReference = {
              name = "etcd-certs";
              namespace = cfg.namespace;
              keyPath = "ca.crt";
            };
            privateKey.secretReference = {
              name = "etcd-certs";
              namespace = cfg.namespace;
              keyPath = "ca.key";
            };
          };
          clientCertificate = {
            certificate.secretReference = {
              name = "root-client-certs";
              namespace = cfg.namespace;
              keyPath = "tls.crt";
            };
            privateKey.secretReference = {
              name = "root-client-certs";
              namespace = cfg.namespace;
              keyPath = "tls.key";
            };
          };
        };
      };
    };
  };
}
