# modules/lib/network-policy.nix
#
# Shared option types for per-app network policy declarations.
#
# Each app module imports this and adds `networkPolicy` to its options:
#
#   networkPolicy = networkPolicyLib.mkNetworkPolicyOption;
#
# Then sets defaults in config:
#
#   openkrill.apps.<name>.networkPolicy = {
#     ingress = [
#       { from = "traefik"; ports = [{ port = 80; }]; }
#     ];
#     egress = [
#       { to = "cloudnative-pg"; ports = [{ port = 5432; }]; }
#       { to = "dns"; }
#     ];
#   };
#
# The network-policies module reads these declarations and generates
# CiliumNetworkPolicy resources.  See specs/network-policies.md.

{ lib }:
with lib;
rec {
  # Port specification: { port, protocol }
  portModule = types.submodule {
    options = {
      port = mkOption {
        type = types.port;
        description = "Port number.";
      };
      protocol = mkOption {
        type = types.enum [ "TCP" "UDP" ];
        default = "TCP";
        description = "Protocol (TCP or UDP).";
      };
    };
  };

  # Ingress rule: { from, ports }
  ingressRuleModule = types.submodule {
    options = {
      from = mkOption {
        type = types.str;
        description = ''
          Source identifier.  One of:
          - An app name (e.g. "authelia") -- resolved to namespace selector
          - "traefik" -- the ingress controller in kube-system
          - "dns" -- CoreDNS pods in kube-system
          - "world" -- any external source
          - "cluster" -- any cluster-internal source
        '';
      };
      ports = mkOption {
        type = types.listOf portModule;
        default = [];
        description = "Ports to allow.  Empty means all ports from this source.";
      };
    };
  };

  # Egress rule: { to, ports }
  egressRuleModule = types.submodule {
    options = {
      to = mkOption {
        type = types.str;
        description = ''
          Destination identifier.  One of:
          - An app name (e.g. "cloudnative-pg") -- resolved to namespace selector
          - "dns" -- CoreDNS (UDP/TCP 53), automatically added unless excluded
          - "kubernetes-api" -- the Kubernetes API server
          - "world" -- any external destination
          - "cluster" -- any cluster-internal destination
          - An FQDN (e.g. "api.example.com") -- Cilium FQDN-based egress
        '';
      };
      ports = mkOption {
        type = types.listOf portModule;
        default = [];
        description = "Ports to allow.  Empty means all ports to this destination.";
      };
    };
  };

  # The network policy option set that each app module uses.
  # Returns null when not configured, signalling the network-policies
  # module to skip this app.
  mkNetworkPolicyOption = mkOption {
    type = types.nullOr (types.submodule {
      options = {
        podSelector = mkOption {
          type = types.attrs;
          default = {};
          description = ''
            Label selector for pods this policy applies to.
            Defaults to all pods in the app's namespace ({}).
          '';
        };
        ingress = mkOption {
          type = types.listOf ingressRuleModule;
          default = [];
          description = "Allowed inbound traffic rules.";
        };
        egress = mkOption {
          type = types.listOf egressRuleModule;
          default = [];
          description = "Allowed outbound traffic rules.";
        };
      };
    });
    default = null;
    description = ''
      Network policy declaration for this app.  When non-null, the
      network-policies module generates a CiliumNetworkPolicy in the
      app's namespace allowing the declared traffic.
    '';
  };
}
