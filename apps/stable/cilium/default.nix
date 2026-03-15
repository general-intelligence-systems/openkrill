# apps/cilium — Cilium CNI
#
# Deploys Cilium as the cluster CNI, replacing k3s's bundled Flannel.
# Provides BPF-based networking, Hubble observability, and
# CiliumNetworkPolicy CRDs (policy enforcement is disabled).
#
# When enabled, k3s is configured with --flannel-backend=none and
# --disable-network-policy so Cilium takes full ownership of CNI.
{ config, lib, charts, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.cilium;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };

  # ── Helm chart defaults ──────────────────────────────────────────────
  defaults = {
    # -- k3s integration --
    k8sServiceHost = "127.0.0.1";
    k8sServicePort = 6443;

    # -- kube-proxy replacement (eBPF service routing) --
    kubeProxyReplacement = true;
    bpf.masquerade = true;

    # -- CNI --
    ipam.mode = "kubernetes";

    # -- Policy enforcement --
    policyEnforcementMode = "never";

    # -- Observability --
    hubble = {
      enabled = true;
      relay.enabled = true;
      ui.enabled = true;
      tls.auto = {
        enabled = true;
        method = "cronJob";
      };
    };

    # -- Metrics --
    prometheus.enabled = true;
    operator.prometheus.enabled = true;

    # -- Operator --
    operator.replicas = 1;
  };

  helmResources = kubelib.fromHelm {
    name = "cilium";
    chart = charts.cilium.cilium.latest;
    namespace = cfg.namespace;
    values = recursiveUpdate defaults cfg.values;
  };
in
{
  imports = [
    ./ciliumnetworkpolicies.nix
    ./ciliumclusterwidenetworkpolicies.nix
  ];

  options.openkrill.apps.cilium = {
    enable = mkEnableOption "Cilium CNI";

    namespace = mkOption {
      type = types.str;
      default = "kube-system";
      description = "Namespace for Cilium.  Defaults to kube-system.";
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
    openkrill.apps.victoriametrics.vmservicescrapes.cilium-agent =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        selector.matchLabels."k8s-app" = "cilium";
        namespaceSelector.matchNames = [ cfg.namespace ];
        endpoints = [{ port = "prometheus"; path = "/metrics"; }];
      };

    openkrill.apps.victoriametrics.vmservicescrapes.cilium-operator =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        selector.matchLabels."io.cilium/app" = "operator";
        namespaceSelector.matchNames = [ cfg.namespace ];
        endpoints = [{ port = "prometheus"; path = "/metrics"; }];
      };

    openkrill.apps.victoriametrics.vmrules.cilium-alerts =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        groups = [{
          name = "cilium";
          rules = [
            {
              alert = "CiliumAgentUnhealthy";
              expr = ''cilium_unreachable_nodes > 0'';
              "for" = "10m";
              labels.severity = "warning";
              annotations = {
                summary = "Cilium agent has unreachable nodes";
                description = "Cilium agent on {{ $labels.instance }} reports unreachable nodes for 10 minutes.";
              };
            }
            {
              alert = "CiliumEndpointNotReady";
              expr = ''sum(cilium_endpoint_state{endpoint_state!="ready"}) > 0'';
              "for" = "15m";
              labels.severity = "warning";
              annotations = {
                summary = "Cilium endpoints not ready";
                description = "Some Cilium endpoints have been in a non-ready state for 15 minutes.";
              };
            }
          ];
        }];
      };

    openkrill.apps.argo-cd.applications.cilium = {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "cilium.yaml";
      };
      destination = {
        server = "https://kubernetes.default.svc";
        namespace = cfg.namespace;
      };
      syncPolicy = {
        automated = { prune = true; selfHeal = true; };
        syncOptions = [ "ServerSideApply=true" ];
      };
    };

    openkrill.manifests.cilium.content = helmResources;
  };
}
