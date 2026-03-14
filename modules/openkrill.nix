# Reusable NixOS module for openkrill k3s server.
#
# Import this into your own configuration.nix:
#
#   { inputs, ... }: {
#     imports = [ inputs.openkrill.nixosModules.default ];
#     services.openkrill.enable = true;
#   }
#
# This module configures the k3s service and related networking.
# The default Gateway is managed by openkrill.apps.gateway-api
# (see apps/gateway-api/default.nix).  It does NOT set system.stateVersion, boot
# loader, or user accounts -- those are the consumer's responsibility.
#
# App modules are opt-in.  Enable the ones you need:
#
#   openkrill.apps.cert-manager.enable = true;
#   openkrill.apps.argo-cd.enable = true;
#   # etc.
#
# See examples/default-stack for a full-stack configuration.
{ config, lib, pkgs, ... }:

let
  cfg = config.services.openkrill;
in
{
  options.services.openkrill = {
    enable = lib.mkEnableOption "openkrill k3s server";

    hostName = lib.mkOption {
      type = lib.types.str;
      default = "openkrill";
      description = "Hostname for the k3s server node.";
    };

    role = lib.mkOption {
      type = lib.types.enum [ "server" "agent" ];
      default = "server";
      description = "k3s role: server (control plane) or agent (worker).";
    };

    extraFlags = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Extra flags to pass to k3s.";
      example = "--disable traefik";
    };

    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to open the Kubernetes API port (6443) in the firewall.";
    };

  };

  config = lib.mkIf cfg.enable {
    networking = {
      hostName = cfg.hostName;
      firewall.allowedTCPPorts = lib.mkIf cfg.openFirewall [ 6443 ];
    };

    services.k3s = {
      enable = true;
      role = cfg.role;
      extraFlags = lib.mkMerge [
        (lib.mkIf (cfg.extraFlags != "") cfg.extraFlags)
        (lib.mkIf config.openkrill.apps.cilium.enable
          (lib.mkAfter " --flannel-backend=none --disable-network-policy"))
      ];
    };
  };
}
