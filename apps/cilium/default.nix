# apps/cilium — Cilium CNI
#
# Deploys Cilium as the cluster CNI, replacing k3s's bundled Flannel.
# Provides BPF-based networking, CiliumNetworkPolicy CRDs, L7-aware
# enforcement, FQDN-based egress rules, and Hubble observability.
#
# When enabled, k3s is configured with --flannel-backend=none and
# --disable-network-policy so Cilium takes full ownership of CNI
# and network policy enforcement.
#
# Policy enforcement mode defaults to "always" (default-deny posture).
# Pods with a CiliumNetworkPolicy receive only explicitly allowed
# traffic.  The network-policies module generates these policies
# from per-app declarations.
{ config, lib, charts, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.cilium;
  helpers = import ../../modules/lib/helpers.nix { inherit lib; };

  defaults = {
    # -- k3s integration --
    k8sServiceHost = "localhost";
    k8sServicePort = 6443;

    # -- CNI --
    kubeProxyReplacement = true;
    ipam.mode = "kubernetes";
    bpf.masquerade = true;

    # -- Policy enforcement --
    # "always" = default-deny: pods with a CiliumNetworkPolicy get
    # only explicitly allowed traffic.
    policyEnforcementMode = "always";

    # -- Observability --
    hubble = {
      enabled = true;
      relay.enabled = true;
    };

    # -- Operator --
    operator.replicas = 1;
  };

  helmResources = kubelib.fromHelm {
    name = "cilium";
    chart = charts.cilium.cilium;
    namespace = cfg.namespace;
    values = recursiveUpdate defaults cfg.values;
  };
in
{
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
    openkrill.apps.argocd.applications.cilium = {
      namespace = "argocd";
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

    openkrill.manifests = mkMerge [
      {
        cilium.content = helmResources;
      }
      (helpers.mkExtraManifestsConfig "cilium" cfg.extraManifests)
    ];
  };
}
