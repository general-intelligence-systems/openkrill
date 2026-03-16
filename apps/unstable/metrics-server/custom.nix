# Custom overrides for this module.
# This file is never overwritten by the generator.
#
# When k3s kubelets listen on WireGuard node-IPs and Cilium provides
# the CNI in VXLAN mode, pods cannot reach kubelets directly: Cilium's
# eBPF datapath rejects the non-overlay egress before the packet
# reaches the host routing stack.  Running metrics-server with
# hostNetwork bypasses the overlay entirely.
#
# Requires `--disable=metrics-server` in k3s extraFlags so the built-in
# addon does not conflict with this Helm-managed deployment.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps.metrics-server;
in
{
  config = mkIf cfg.enable {
    openkrill.apps.metrics-server.values = {
      # Run on the host network so the metrics-server can reach kubelets
      # on WireGuard node-IPs without traversing Cilium's VXLAN overlay.
      hostNetwork = true;
      dnsPolicy = "ClusterFirstWithHostNet";

      # Port 4443 avoids conflicting with the kubelet on port 10250.
      containerPorts.https = 4443;

      # k3s uses self-signed kubelet certs.
      extraArgs = [ "--kubelet-insecure-tls" ];

      # Register the v1beta1.metrics.k8s.io APIService so kubectl top works.
      apiService.create = true;
    };
  };
}
