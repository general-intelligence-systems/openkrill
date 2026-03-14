# apps/metacontroller — Metacontroller for webhook-based K8s controllers
# Deploys Metacontroller from upstream manifests fetched directly from GitHub.
{ config, lib, pkgs, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.metacontroller;
  helpers          = import ../../../modules/lib/helpers.nix { inherit lib; };
  version = "4.12.11";

  # Fetch upstream manifests directly from GitHub
  baseUrl = "https://raw.githubusercontent.com/metacontroller/metacontroller/v${version}/manifests/production";

  fetchManifest = name: builtins.readFile (pkgs.fetchurl {
    url = "${baseUrl}/${name}";
    hash = cfg.manifestHashes.${name};
  });

  parseManifests = name: kubelib.fromYAML (fetchManifest name);
in
{
  options.openkrill.apps.metacontroller = {
    enable = mkEnableOption "Metacontroller";

    namespace = mkOption {
      type = types.str;
      default = "metacontroller";
    };

    image = mkOption {
      type = types.str;
      default = "metacontrollerio/metacontroller:v${version}";
      description = "Metacontroller container image.";
    };

    manifestHashes = mkOption {
      type = types.attrsOf types.str;
      description = "SHA256 hashes for upstream manifest files.";
      default = {
        "metacontroller-namespace.yaml" = "sha256-ihDjMNCGpJWLScg21WtTOcaSACnSkh4OLUYhQiunwqo=";
        "metacontroller-rbac.yaml" = "sha256-HbZmW8Mny/zs49FtBgSqRoy9UI7hrHWVAM2ihfkl8ZY=";
        "metacontroller-crds-v1.yaml" = "sha256-nYfKuElsYnlkDvOTyAEyiA2dvzOnNHhRQqgmJkTzQ2Y=";
        "metacontroller.yaml" = "sha256-WV3QZxSTdE97meT0HtkopwqdhQ8UyoefTctLqhewdQQ=";
      };
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── VictoriaMetrics scrape + alerts ────────────────────────────────
    openkrill.apps.victoriametrics.vmservicescrapes.metacontroller =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        selector.matchLabels."app.kubernetes.io/name" = "metacontroller";
        namespaceSelector.matchNames = [ cfg.namespace ];
        endpoints = [{ port = "9999"; path = "/metrics"; }];
      };

    openkrill.apps.victoriametrics.vmrules.metacontroller-alerts =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        groups = [{
          name = "metacontroller";
          rules = [{
            alert = "MetacontrollerDown";
            expr = ''up{job=~".*metacontroller.*"} == 0'';
            "for" = "5m";
            labels.severity = "critical";
            annotations = {
              summary = "Metacontroller is down";
              description = "Metacontroller has been unreachable for 5 minutes.";
            };
          }];
        }];
      };

    openkrill.apps.argocd.applications.metacontroller = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "metacontroller.yaml";
      };
      destination = {
        server = "https://kubernetes.default.svc";
        namespace = cfg.namespace;
      };
      syncPolicy = {
        automated = { prune = true; selfHeal = true; };
        syncOptions = [ "CreateNamespace=true" "ServerSideApply=true" ];
      };
    };

    openkrill.manifests.metacontroller.content =
      (parseManifests "metacontroller-namespace.yaml")
      ++ (parseManifests "metacontroller-rbac.yaml")
      ++ (parseManifests "metacontroller-crds-v1.yaml")
      ++ (parseManifests "metacontroller.yaml");
  };
}
