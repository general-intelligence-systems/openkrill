# modules/sandbox.nix — Declarative agent sandboxes
#
# Shortcut module for creating isolated, stateful sandbox workloads.
# Instead of manually wiring SandboxTemplate / SandboxWarmPool CRDs,
# modules declare `openkrill.sandbox.<name> = { image; pool; ... }`.
#
# Each entry creates:
#   - A SandboxTemplate (always)
#   - A SandboxWarmPool (when pool > 0)
#
# Sandboxes are network-isolated by default (deny-all egress).
# Set network.egress to open specific paths.
#
# Usage:
#
#   openkrill.sandbox.my-agent = {
#     image = "ghcr.io/my-org/agent:v1";
#     pool = 3;
#     network.egress = [
#       { to = [{ ipBlock.cidr = "10.0.0.0/8"; }]; }
#     ];
#   };
{ config, lib, ... }:
with lib;
let
  sandboxes = config.openkrill.sandbox;
  enabled = filterAttrs (_: s: s.enable) sandboxes;
  hasPool = any (s: s.pool > 0) (attrValues enabled);

  # Coerce a port entry: int -> { containerPort = int; }, attrs pass through.
  coercePort = p:
    if isInt p then { containerPort = p; }
    else p;

  # Build the single "main" container from shortcut options.
  mkContainer = cfg:
    { name = "main"; inherit (cfg) image; }
    // optionalAttrs (cfg.command != [ ]) { inherit (cfg) command; }
    // optionalAttrs (cfg.args != [ ]) { inherit (cfg) args; }
    // optionalAttrs (cfg.env != { }) {
      env = mapAttrsToList (k: v: { name = k; value = v; }) cfg.env;
    }
    // optionalAttrs (cfg.resources != { }) { inherit (cfg) resources; }
    // optionalAttrs (cfg.ports != [ ]) {
      ports = map coercePort cfg.ports;
    };

  # Build the SandboxTemplate spec from shortcut options.
  mkTemplateSpec = cfg:
    {
      podTemplate.spec = { containers = [ (mkContainer cfg) ]; } // cfg.extraPodOptions;
      networkPolicyManagement = "Managed";
    }
    // optionalAttrs (cfg.network.egress != [ ]) {
      networkPolicy.egress = cfg.network.egress;
    }
    // cfg.extraTemplateOptions;

  # Build SandboxTemplate CRD instances for the app module.
  templateDefs = mapAttrs (name: cfg: {
    namespace = cfg.namespace;
    podTemplate = (mkTemplateSpec cfg).podTemplate;
    networkPolicyManagement =
      (mkTemplateSpec cfg).networkPolicyManagement or "Managed";
  } // optionalAttrs ((mkTemplateSpec cfg) ? networkPolicy) {
    networkPolicy = (mkTemplateSpec cfg).networkPolicy;
  }) enabled;

  # Build SandboxWarmPool CRD instances for entries with pool > 0.
  poolDefs = mapAttrs (name: cfg: {
    namespace = cfg.namespace;
    replicas = cfg.pool;
    sandboxTemplateRef = name;
  }) (filterAttrs (_: cfg: cfg.pool > 0) enabled);

  sandboxSubmodule = types.submodule ({ name, ... }: {
    options = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Whether this sandbox is active.";
      };

      namespace = mkOption {
        type = types.str;
        default = "agent-sandbox";
        description = "Namespace for this sandbox's resources.";
      };

      image = mkOption {
        type = types.str;
        description = "Container image for the sandbox workload.";
      };

      command = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = "Entrypoint override (container command).";
      };

      args = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = "Arguments passed to the entrypoint.";
      };

      env = mkOption {
        type = types.attrsOf types.str;
        default = { };
        description = ''
          Environment variables as key-value pairs.
          For valueFrom references, use extraPodOptions instead.
        '';
      };

      resources = mkOption {
        type = types.attrsOf types.anything;
        default = { };
        description = "Container resource requests and limits.";
      };

      ports = mkOption {
        type = types.listOf (types.either types.int (types.attrsOf types.anything));
        default = [ ];
        description = ''
          Container ports. Integers are coerced to { containerPort = <int>; }.
          Full port attrs are passed through for named ports or protocol overrides.
        '';
      };

      pool = mkOption {
        type = types.int;
        default = 0;
        description = ''
          Number of pre-provisioned idle sandboxes to keep warm.
          Set to 0 (default) to skip creating a SandboxWarmPool.
        '';
      };

      network = {
        egress = mkOption {
          type = types.listOf (types.attrsOf types.anything);
          default = [ ];
          description = ''
            NetworkPolicy egress rules. When empty (default), the sandbox
            is fully isolated (deny-all). Set rules to allow specific
            egress paths.
          '';
        };
      };

      extraPodOptions = mkOption {
        type = types.attrsOf types.anything;
        default = { };
        description = ''
          Extra fields deep-merged into podTemplate.spec (e.g. volumes,
          nodeSelector, tolerations, serviceAccountName).
        '';
      };

      extraTemplateOptions = mkOption {
        type = types.attrsOf types.anything;
        default = { };
        description = ''
          Extra fields deep-merged into the SandboxTemplate spec.
          Use for future CRD fields or advanced network policy config.
        '';
      };
    };
  });

in
{
  options.openkrill.sandbox = mkOption {
    type = types.attrsOf sandboxSubmodule;
    default = { };
    description = ''
      Declarative agent sandbox definitions. Each entry creates a
      SandboxTemplate and optionally a SandboxWarmPool.
    '';
  };

  config = mkIf (enabled != { }) {
    # Auto-enable the agent-sandbox app and extensions (if pools exist).
    openkrill.apps.agent-sandbox.enable = true;
    openkrill.apps.agent-sandbox.extensions.enable = mkIf hasPool true;

    # Push CRD instances into the app module's typed options.
    openkrill.apps.agent-sandbox.sandboxtemplates = templateDefs;
    openkrill.apps.agent-sandbox.sandboxwarmpools = poolDefs;
  };
}
