# modules/git-daemon.nix — git-daemon for serving openkrill manifests
#
# Enables the NixOS git-daemon service so the host can serve the
# rendered manifest repo to ArgoCD via the host-gateway Service.
#
# The actual repo symlink (/srv/git/openkrill-manifests.git) is
# managed by either:
#   - manifests.nix (on the control-plane node, from the Nix store path)
#   - bin/push-manifests (on all nodes, at runtime)
#
# Import this on every k3s server node so the host-gateway Service
# (which load-balances across all nodes) always finds a git-daemon.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.gitDaemon;
in
{
  options.openkrill.gitDaemon = {
    enable = mkEnableOption "git-daemon for serving openkrill manifests";

    basePath = mkOption {
      type = types.str;
      default = "/srv/git";
      description = "Base path for git-daemon to serve repositories from.";
    };

    repoName = mkOption {
      type = types.str;
      default = "openkrill-manifests.git";
      description = "Name of the bare repo directory under basePath.";
    };
  };

  config = mkIf cfg.enable {
    services.gitDaemon = {
      enable = true;
      basePath = cfg.basePath;
      exportAll = true;
    };

    # Ensure the base path exists before git-daemon starts
    systemd.tmpfiles.rules = [
      "d ${cfg.basePath} 0755 root root -"
    ];

    # The manifest repo is a symlink to a Nix store path owned by root,
    # but git-daemon runs as the `git` user.  Git >= 2.36 rejects this
    # ownership mismatch.  Scope the safe.directory override to just
    # the git-daemon service via environment variables.
    systemd.services.git-daemon.environment = {
      GIT_CONFIG_COUNT = "1";
      GIT_CONFIG_KEY_0 = "safe.directory";
      GIT_CONFIG_VALUE_0 = "${cfg.basePath}/${cfg.repoName}";
    };
  };
}
