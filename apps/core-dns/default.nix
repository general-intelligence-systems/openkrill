# apps/core-dns — CoreDNS customisation and host-gateway access
#
# Provides two features:
#
# 1. Host-gateway (enabled by default): a hostNetwork DaemonSet + Service
#    that gives pods a stable in-cluster DNS name for reaching host
#    services (git-daemon, registries, etc.).  No hardcoded IPs needed —
#    Kubernetes tracks node IPs automatically.
#
# 2. Custom DNS hosts (optional): a coredns-custom ConfigMap that adds
#    arbitrary hostname -> IP mappings to k3s's embedded CoreDNS.
#
# The gitops.repoURL option defaults to the host-gateway Service DNS
# name (git://host-gateway.kube-system.svc/...) so ArgoCD can reach
# git-daemon without a hardcoded node IP.

{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps.core-dns;
  helpers = import ../../modules/lib/helpers.nix { inherit lib; };

  portSubmodule = types.submodule {
    options = {
      name = mkOption {
        type = types.str;
        description = "Port name.";
      };
      port = mkOption {
        type = types.int;
        description = "Service port number.";
      };
      targetPort = mkOption {
        type = types.int;
        description = "Target port on the host.";
      };
      protocol = mkOption {
        type = types.str;
        default = "TCP";
        description = "Protocol (TCP or UDP).";
      };
    };
  };
in
{
  options.openkrill.apps.core-dns = {
    enable = mkEnableOption "CoreDNS customisation and host-gateway access";

    namespace = mkOption {
      type = types.str;
      default = "kube-system";
      description = "Namespace for host-gateway resources.";
    };

    hostGateway = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Deploy a hostNetwork DaemonSet + Service that exposes the node
          IP as a stable in-cluster service.  Pods can reach host services
          via host-gateway.<namespace>.svc.cluster.local.
        '';
      };

      image = mkOption {
        type = types.str;
        default = "registry.k8s.io/pause:3.9";
        description = "Container image for the host-gateway pause pod.";
      };

      ports = mkOption {
        type = types.listOf portSubmodule;
        default = [
          { name = "git"; port = 9418; targetPort = 9418; protocol = "TCP"; }
        ];
        description = ''
          Ports exposed by the host-gateway Service.  Defaults to
          git-daemon (9418).  Add entries for any other host service
          that pods need to reach.
        '';
      };
    };

    customHosts = mkOption {
      type = types.attrsOf types.str;
      default = {};
      example = literalExpression ''
        {
          "ingress.k3s.internal" = "10.42.0.1";
          "registry.k3s.internal" = "10.42.0.1";
        }
      '';
      description = ''
        Hostname to IP mappings injected into CoreDNS via the
        coredns-custom ConfigMap.  k3s's embedded CoreDNS auto-loads
        *.server entries from this ConfigMap.

        Each entry resolves the given hostname to the specified IP
        from within any pod in the cluster.
      '';
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    openkrill.apps.argocd.applications.core-dns = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "core-dns.yaml";
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

    openkrill.manifests.core-dns.content = import ./resources.nix {
      inherit lib cfg;
    };
  };
}
