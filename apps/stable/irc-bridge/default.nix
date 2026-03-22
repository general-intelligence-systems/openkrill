# apps/irc-bridge — Matrix IRC Bridge
#
# Deploys a Matrix-to-IRC bridge via the cyclika94 Helm chart.
# Bridges IRC channels to Matrix rooms, allowing Matrix users to
# participate in IRC conversations.
#
# Usage:
#   openkrill.apps.irc-bridge.enable = true;
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg          = config.openkrill.apps.irc-bridge;
  conduwuitCfg = config.openkrill.apps.conduwuit;
  helpers      = import ../../../modules/lib/helpers.nix { inherit lib; };

  conduwuitEnabled = conduwuitCfg.enable;
  conduwuitAddress =
    if conduwuitEnabled
    then "http://conduwuit.${conduwuitCfg.namespace}.svc.cluster.local:80"
    else "http://localhost:8008";
  conduwuitDomain =
    if conduwuitEnabled
    then conduwuitCfg.serverName
    else "example.com";

  defaults = {
    # Auto-wire homeserver connection when conduwuit is enabled
    homeserver = {
      address = conduwuitAddress;
      domain = conduwuitDomain;
    };
  };
in
{
  options.openkrill.apps.irc-bridge = {
    enable = mkEnableOption "Matrix IRC bridge";

    namespace = mkOption {
      type = types.str;
      default = "irc-bridge";
      description = "Kubernetes namespace for the IRC bridge.";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── ArgoCD Application CR ──────────────────────────────────────
    openkrill.apps.argo-cd.applications.irc-bridge = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "irc-bridge.yaml";
      };
      destination = {
        server = "https://kubernetes.default.svc";
        namespace = cfg.namespace;
      };
      syncPolicy = {
        automated = { prune = true; selfHeal = true; };
        syncOptions = [ "CreateNamespace=true" ];
      };
    };

    # ── Manifests ──────────────────────────────────────────────────
    openkrill.manifests.irc-bridge.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name      = "irc-bridge";
        chart     = charts.cyclika94.irc-bridge.versions."0.9.1";
        namespace = cfg.namespace;
        values    = recursiveUpdate defaults cfg.values;
      };
  };
}
