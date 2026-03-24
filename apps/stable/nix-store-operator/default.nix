# apps/nix-store-operator — Shared /nix/store volume operator
#
# Deploys a DaemonSet that lazily populates /nix/store on each node
# from a binary cache.  App pods mount the shared store via hostPath
# and run nix-built binaries from a minimal container (e.g. busybox).
#
# ConfigMaps labeled nix-store-operator.ghcr.io/mount=true contain
# the list of store paths each app needs.  The daemon watches these
# and fetches any missing paths using `nix copy`.
#
# Usage in your machine config:
#
#   openkrill.apps.nix-store-operator = {
#     enable = true;
#     config-maps.my-app.store-paths =
#       inputs.my-app.packages.x86_64-linux.store-paths;
#   };
#
{ config, lib, k8s, kubelib, charts, ... }:
with lib;
let
  cfg     = config.openkrill.apps.nix-store-operator;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };

  label = "nix-store-operator.ghcr.io/mount";
in
{
  options.openkrill.apps.nix-store-operator = {
    enable = mkEnableOption "Nix store operator (shared /nix/store DaemonSet)";

    namespace = mkOption {
      type = types.str;
      default = "nix-system";
      description = "Kubernetes namespace for the nix-store-operator.";
    };

    cacheUrl = mkOption {
      type = types.str;
      default = "https://cache.nixos.org";
      description = "Nix binary cache URL the daemon fetches store paths from.";
    };

    hostStorePath = mkOption {
      type = types.str;
      default = "/var/lib/nixfs/store";
      description = "Host path where /nix/store is materialized.";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart values to override, deep-merged with defaults.";
    };

    config-maps = mkOption {
      type = types.attrsOf (types.submodule {
        options.store-paths = mkOption {
          type = types.path;
          description = ''
            Path to a file containing newline-delimited /nix/store paths.
            Typically produced by nix-store-operator's lib.mkStorePaths.
          '';
        };
      });
      default = {};
      description = ''
        ConfigMaps to generate for the nix-store-operator.
        Each key becomes the ConfigMap name.  The store-paths value
        is a path to a file (usually a flake output) listing the
        /nix/store paths the app requires.
      '';
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── ArgoCD Application CR ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.nix-store-operator = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project   = "default";
      source = {
        repoURL          = config.openkrill.gitops.repoURL;
        targetRevision   = "rendered-manifests";
        path             = ".";
        directory.include = "nix-store-operator.yaml";
      };
      destination = {
        server    = "https://kubernetes.default.svc";
        namespace = cfg.namespace;
      };
      syncPolicy = {
        automated   = { prune = true; selfHeal = true; };
        syncOptions = [ "CreateNamespace=true" ];
      };
    };

    # ── Extra manifests ────────────────────────────────────────────────
    openkrill.manifests = helpers.mkExtraManifestsConfig "nix-store-operator" cfg.extraManifests;

    # ── Manifests ──────────────────────────────────────────────────────
    openkrill.manifests.nix-store-operator.content =
      let
        defaults = {
          storeRoot     = "/nix/store";
          hostStorePath = cfg.hostStorePath;
          cacheUrl      = cfg.cacheUrl;
        };
      in
      [ (k8s.mkNamespace cfg.namespace) ]

      # Deploy the operator DaemonSet via its helm chart
      ++ kubelib.fromHelm {
        name      = "nix-store-operator";
        chart     = charts.general-intelligence-systems.nix-store-operator.latest;
        namespace = cfg.namespace;
        values    = recursiveUpdate defaults cfg.values;
      }

      # Generate a labeled ConfigMap for each config-maps entry
      ++ mapAttrsToList (name: cm: {
        apiVersion = "v1";
        kind = "ConfigMap";
        metadata = {
          inherit name;
          namespace = cfg.namespace;
          labels.${label} = "true";
        };
        data.paths = builtins.readFile cm.store-paths;
      }) cfg.config-maps;
  };
}
