# apps/metrics-server — Kubernetes Metrics Server (hostNetwork mode)
#
# k3s ships metrics-server as a built-in HelmChart.  By default its pods
# use the pod network, which cannot reach kubelets on WireGuard node-IPs
# through Cilium's VXLAN datapath.  This module applies a HelmChartConfig
# override to enable hostNetwork so metrics-server connects directly.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps.metrics-server;
in
{
  options.openkrill.apps.metrics-server = {
    enable = mkEnableOption "Kubernetes Metrics Server (hostNetwork mode)";
  };

  config = mkIf cfg.enable {
    openkrill.apps.helm.enable = mkDefault true;

    openkrill.apps.helm.chartConfigs.metrics-server = {
      valuesContent = ''
        hostNetwork:
          enabled: true
        containerPort: 4443
        args:
          - --kubelet-insecure-tls
      '';
    };
  };
}
