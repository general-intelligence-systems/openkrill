# Reusable NixOS module for openkrill k3s server.
#
# Import this into your own configuration.nix:
#
#   { inputs, ... }: {
#     imports = [ inputs.openkrill.nixosModules.default ];
#     services.openkrill.enable = true;
#   }
#
# This module configures the k3s service, related networking, and
# enables the default app stack.  It does NOT set system.stateVersion,
# boot loader, or user accounts -- those are the consumer's
# responsibility.
#
# When enabled, the following apps are activated by default (via
# mkDefault, so consumers can still opt out of individual apps):
#
#   openkrill.apps.core-dns.enable = false;  # to disable
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
      extraFlags = lib.mkIf (cfg.extraFlags != "") cfg.extraFlags;
    };

    # ── Default app stack ────────────────────────────────────────────
    # These are enabled by default when services.openkrill is enabled.
    # Consumers can opt out of any individual app:
    #   openkrill.apps.authelia.enable = false;
    openkrill.gitops.enable = lib.mkDefault true;

    openkrill.apps = {
      argocd.enable           = lib.mkDefault true;
      authelia.enable         = lib.mkDefault true;
      cert-manager.enable     = lib.mkDefault true;
      cloudnative-pg.enable   = lib.mkDefault true;
      core-dns.enable         = lib.mkDefault true;
      external-secrets.enable = lib.mkDefault true;
      gateway-api.enable      = lib.mkDefault true;
      helm.enable             = lib.mkDefault true;
      traefik.enable          = lib.mkDefault true;
    };
  };
}
