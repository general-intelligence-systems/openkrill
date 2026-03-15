# modules/manifests.nix
#
# Defines the openkrill.manifests option type and produces
# openkrill.renderedManifestRepo — a bare git repo derivation
# containing every manifest as a YAML file on the
# `rendered-manifests` branch.
#
# App modules write to openkrill.manifests.${name}.content.
# This module collects them all, serializes to YAML, and
# commits into a bare git repo suitable for git-daemon.
#
# extraManifests fan-out is handled centrally: for every
# openkrill.apps.<app> that has an extraManifests attrset,
# this module fans them into openkrill.manifests."<app>/<key>"
# so individual app modules don't need to.
#
# openkrill.gitops controls how the repo is served. When
# method is "gitDaemon", services.gitDaemon is force-enabled
# and the repo is symlinked into its base path.

{ config, lib, pkgs, ... }:
with lib;
let
  helpers = import ./lib/helpers.nix { inherit lib; };

  cfg = config.openkrill;
  gitopsCfg = cfg.gitops;

  manifestFormat = pkgs.formats.yaml { };

  # Wrap a list of resources as a k8s List, pass single objects through
  mkManifestFile = name: manifest:
    let
      content =
        if builtins.isList manifest.content then {
          apiVersion = "v1";
          kind = "List";
          items = manifest.content;
        } else
          manifest.content;
    in
    manifestFormat.generate "${name}.yaml" content;

  # Build script that copies each manifest into the work tree
  copyCommands = concatStringsSep "\n" (mapAttrsToList (name: manifest:
    let file = mkManifestFile name manifest;
    in "mkdir -p \"$work/$(dirname '${name}')\" && cp ${file} \"$work/${name}.yaml\""
  ) cfg.manifests);

  useGitDaemon = gitopsCfg.enable && gitopsCfg.method == "gitDaemon";

  # Centralized extraManifests fan-out: for every app that declares
  # extraManifests and is enabled, fan them into openkrill.manifests.
  appsWithExtra = filterAttrs (_: appCfg:
    appCfg ? extraManifests
    && appCfg ? enable
    && appCfg.enable
    && appCfg.extraManifests != { }
  ) (cfg.apps or { });

  extraManifestConfigs = mapAttrsToList (appName: appCfg:
    helpers.mkExtraManifestsConfig appName appCfg.extraManifests
  ) appsWithExtra;
in
{
  options.openkrill = {
    manifests = mkOption {
      default = { };
      type = types.attrsOf (types.submodule ({ name, ... }: {
        options = {
          content = mkOption {
            type = with types; either attrs (listOf attrs);
            description = ''
              Manifest content. A single attrset produces one YAML document.
              A list of attrsets produces a Kubernetes List wrapping them all.
            '';
          };
        };
      }));
    };

    renderedManifestRepo = mkOption {
      type = types.package;
      readOnly = true;
      description = ''
        A bare git repository containing every enabled manifest
        as a YAML file on the `rendered-manifests` branch.
        Suitable for serving via git-daemon.
      '';
    };

    gitops = {
      # mkEnableOption defaults to false, but openkrill.nix sets this to
      # mkDefault true so gitops serving is active whenever the module is imported.
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Whether to enable openkrill gitops serving.";
      };

      method = mkOption {
        type = types.enum [ "gitDaemon" ];
        default = "gitDaemon";
        description = ''
          How to serve the rendered manifest repo.

          `gitDaemon` — force-enables services.gitDaemon and
          symlinks the repo into its base path.
        '';
      };

      basePath = mkOption {
        type = types.str;
        default = "/srv/git";
        description = ''
          Base path for git-daemon. Only used when method is `gitDaemon`.
        '';
      };

      repoName = mkOption {
        type = types.str;
        default = "openkrill-manifests.git";
        description = ''
          Name of the bare repo directory under basePath.
          The repo will be accessible at git://<host>/<repoName>
          on branch `rendered-manifests`.
        '';
      };

      repoURL = mkOption {
        type = types.str;
        default = "git://host-gateway.kube-system.svc/${gitopsCfg.repoName}";
        description = ''
          Git URL for ArgoCD to fetch manifests from.
          Must be reachable from inside the cluster.
          Defaults to the host-gateway Service provided by the core-dns module.
        '';
      };
    };
  };

  config = {
    # Fan out extraManifests from all apps into openkrill.manifests
    openkrill.manifests = mkMerge extraManifestConfigs;

    openkrill.renderedManifestRepo = pkgs.runCommand "openkrill-manifests.git" {
      nativeBuildInputs = [ pkgs.git ];
      # Fixed identity and timestamps for reproducibility
      GIT_AUTHOR_NAME = "openkrill";
      GIT_AUTHOR_EMAIL = "openkrill@localhost";
      GIT_COMMITTER_NAME = "openkrill";
      GIT_COMMITTER_EMAIL = "openkrill@localhost";
      GIT_AUTHOR_DATE = "2024-01-01T00:00:00+00:00";
      GIT_COMMITTER_DATE = "2024-01-01T00:00:00+00:00";
    } ''
      work=$(mktemp -d)

      ${copyCommands}

      cd "$work"
      git init -b rendered-manifests
      git add .
      git commit -m "openkrill: rendered manifests" --allow-empty

      git clone --bare . "$out"
    '';

    # Enable the git-daemon module when gitops is configured to use it.
    # The git-daemon.nix module handles service config, tmpfiles, and
    # safe.directory — we just need to enable it and symlink the repo.
    openkrill.gitDaemon = mkIf useGitDaemon {
      enable = mkDefault true;
      basePath = mkDefault gitopsCfg.basePath;
      repoName = mkDefault gitopsCfg.repoName;
    };

    # Symlink the rendered manifest repo into the git-daemon base path.
    # This is the initial bootstrap state from the Nix store; at runtime
    # bin/push-manifests overwrites it on all nodes.
    systemd.tmpfiles.rules = mkIf useGitDaemon [
      "L+ ${gitopsCfg.basePath}/${gitopsCfg.repoName} - - - - ${cfg.renderedManifestRepo}"
    ];

    # Bootstrap every enabled module into the cluster via k3s auto-deploy
    # so the full stack is running before ArgoCD begins syncing.
    # Each module still has an ArgoCD Application CR for ongoing
    # self-management (same pattern ArgoCD itself uses).
    services.k3s.manifests = mapAttrs' (name: manifest:
      nameValuePair "openkrill-${name}" { content = manifest.content; }
    ) cfg.manifests;
  };
}
