# modules/core-dns/resources.nix
#
# Generates K8s resources for host-gateway access and custom CoreDNS entries.
#
# Host-gateway: a hostNetwork DaemonSet + Service that gives pods a stable
# DNS name (host-gateway.<namespace>.svc) for reaching host services like
# git-daemon.  Kubernetes automatically registers each node's IP as an
# endpoint — no hardcoded IPs, no ConfigMap templating.
#
# Custom hosts: a coredns-custom ConfigMap with hosts plugin entries.
# k3s's embedded CoreDNS auto-imports *.server files from this ConfigMap.

{ lib, cfg }:
let
  ns = cfg.namespace;
  gw = cfg.hostGateway;

  # -- Host-gateway DaemonSet + Service ----------------------------------
  #
  # Problem: pods need to reach host-level services (git-daemon, local
  # registries, etc.) but there is no stable, portable way to address the
  # host from inside a pod.  Hardcoding a node IP or the cni0 bridge
  # address is fragile — it changes across nodes, reboots, and CNI
  # configurations.
  #
  # Solution: a DaemonSet with `hostNetwork: true` running a no-op pause
  # container on every node.  Because the pod shares the host network
  # namespace, Kubernetes registers the node's real IP as the pod IP in
  # the Endpoints object.  A ClusterIP Service selecting these pods then
  # gives every pod in the cluster a single, stable DNS name
  # (host-gateway.<namespace>.svc.cluster.local) that round-robins
  # across all node IPs.
  #
  # Any host service listening on 0.0.0.0 (like git-daemon on port 9418)
  # becomes reachable at that DNS name without any IP templating,
  # ConfigMap hacks, or CNI assumptions.
  #
  # The pause container does nothing — it exists solely to keep the pod
  # alive so Kubernetes maintains the endpoint registration.  Resource
  # cost is negligible (~1m CPU, 4Mi RAM per node).

  hostGatewayResources = lib.optionals gw.enable [
    # DaemonSet: one pause pod per node, sharing the host network stack.
    # This is what causes Kubernetes to register each node's IP as an
    # endpoint for the Service below.
    {
      apiVersion = "apps/v1";
      kind = "DaemonSet";
      metadata = {
        name = "host-gateway";
        namespace = ns;
        labels.app = "host-gateway";
      };
      spec = {
        selector.matchLabels.app = "host-gateway";
        template = {
          metadata.labels.app = "host-gateway";
          spec = {
            hostNetwork = true;
            # Tolerate control-plane taints so the pod runs on every node
            # (including single-node clusters where the only node is the
            # control plane).
            tolerations = [
              {
                key = "node-role.kubernetes.io/control-plane";
                operator = "Exists";
                effect = "NoSchedule";
              }
              {
                key = "node-role.kubernetes.io/master";
                operator = "Exists";
                effect = "NoSchedule";
              }
            ];
            containers = [
              {
                name = "pause";
                image = gw.image;
                resources = {
                  requests = { cpu = "1m"; memory = "4Mi"; };
                  limits   = { cpu = "1m"; memory = "4Mi"; };
                };
              }
            ];
          };
        };
      };
    }
    # Service: provides the stable DNS name that pods use to reach host
    # services.  The selector matches the DaemonSet pods above, so the
    # Endpoints object automatically tracks every node's IP.
    #
    # Example: with the default port config, ArgoCD can fetch manifests
    # from git://host-gateway.kube-system.svc:9418/openkrill-manifests.git
    {
      apiVersion = "v1";
      kind = "Service";
      metadata = {
        name = "host-gateway";
        namespace = ns;
        labels.app = "host-gateway";
      };
      spec = {
        selector.app = "host-gateway";
        ports = gw.ports;
      };
    }
  ];

  # -- CoreDNS custom hosts ConfigMap ------------------------------------

  # Build the hosts block content from customHosts attrset
  # e.g. { "ingress.k3s.internal" = "10.42.0.1"; } ->
  #   "10.42.0.1 ingress.k3s.internal"
  hostsLines = lib.concatStringsSep "\n"
    (lib.mapAttrsToList (hostname: ip: "${ip} ${hostname}") cfg.customHosts);

  coreDnsServerBlock = ''
    k3s.internal {
      hosts {
        ${hostsLines}
        fallthrough
      }
    }
  '';

  customHostsResources = lib.optionals (cfg.customHosts != {}) [
    {
      apiVersion = "v1";
      kind = "ConfigMap";
      metadata = {
        name = "coredns-custom";
        namespace = "kube-system";
      };
      data = {
        "hosts.server" = coreDnsServerBlock;
      };
    }
  ];

in
  hostGatewayResources ++ customHostsResources
