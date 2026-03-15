# modules/secret-generators.nix — Decentralized secret generation
#
# App modules declare openkrill.secrets.generators.<name> entries,
# each producing a systemd oneshot that creates K8s secrets in the
# secret-store namespace at boot time (before pods start).
#
# The preamble provides:
#   - $NS           -> "secret-store"
#   - $DOMAIN       -> openkrill.domain
#   - create_secret -> idempotent helper (skips if secret exists)
#   - kubectl on $PATH (always included)
#
# Generators run after k3s.service and honour `after` ordering
# for cross-referenced secrets (e.g. authelia reads lldap's password).
#
# Usage in an app module:
#
#   openkrill.secrets.generators.my-app = {
#     packages = with pkgs; [ openssl ];
#     script = ''
#       create_secret my-app \
#         --from-literal=api-key="$(openssl rand -hex 32)"
#     '';
#   };
{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.openkrill.secrets;
  domain = config.openkrill.domain;

  preamble = ''
    set -euo pipefail
    export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

    # Wait for k3s API server to become ready
    echo "Waiting for Kubernetes API..."
    until kubectl get ns >/dev/null 2>&1; do sleep 2; done

    # Ensure source namespace exists
    kubectl create ns secret-store --dry-run=client -o yaml | kubectl apply -f -

    NS=secret-store
    DOMAIN=${domain}

    # Idempotent secret creation helper.
    # Usage: create_secret <name> <--from-literal=key=val ...>
    create_secret() {
      name="$1"; shift
      if kubectl -n "$NS" get secret "$name" >/dev/null 2>&1; then
        echo "  skip $name (exists)"
        return
      fi
      kubectl -n "$NS" create secret generic "$name" "$@"
      echo "  created $name"
    }
  '';

  mkService = name: gen: {
    description = "Generate ${name} secrets in secret-store namespace";
    after = [ "k3s.service" ]
      ++ map (dep: "openkrill-generate-${dep}.service") gen.after;
    requires = [ "k3s.service" ]
      ++ map (dep: "openkrill-generate-${dep}.service") gen.after;
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    path = [ pkgs.kubectl ] ++ gen.packages;
    script = preamble + "\n" + gen.script;
  };

in
{
  options.openkrill.secrets = {
    enable = mkEnableOption "openkrill secret generation";

    generators = mkOption {
      type = types.attrsOf (types.submodule {
        options = {
          script = mkOption {
            type = types.lines;
            description = ''
              Shell script fragment that generates secrets.
              Runs after a preamble that provides the create_secret
              helper, $NS (secret-store), $DOMAIN, and kubectl on PATH.
            '';
          };

          after = mkOption {
            type = types.listOf types.str;
            default = [];
            description = ''
              Names of other generators that must run before this one.
              Creates a systemd After= dependency.
              Use for cross-referenced secrets (e.g. authelia after lldap).
            '';
          };

          packages = mkOption {
            type = types.listOf types.package;
            default = [];
            description = ''
              Extra packages to add to this generator's PATH.
              kubectl is always included automatically.
            '';
          };
        };
      });
      default = {};
      description = ''
        Secret generator definitions. Each entry becomes a systemd
        oneshot service named openkrill-generate-<name>.service.
      '';
    };
  };

  config = mkIf (cfg.enable && cfg.generators != {}) {
    systemd.services = mapAttrs'
      (name: gen: nameValuePair "openkrill-generate-${name}" (mkService name gen))
      cfg.generators;
  };
}
