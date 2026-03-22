# apps/matrix-appservice-irc — Matrix Appservice IRC
#
# Deploys the matrix-appservice-irc bridge via the cyclika94 Helm
# chart.  This is the full-featured Matrix.org IRC bridge that
# supports connection pooling, ident integration, advanced IRC
# features, and a NeDB/Postgres-backed state store.
#
# Usage:
#   openkrill.apps.matrix-appservice-irc.enable = true;
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg          = config.openkrill.apps.matrix-appservice-irc;
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
  options.openkrill.apps.matrix-appservice-irc = {
    enable = mkEnableOption "Matrix Appservice IRC bridge";

    namespace = mkOption {
      type = types.str;
      default = "matrix-appservice-irc";
      description = "Kubernetes namespace for the Matrix Appservice IRC bridge.";
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
    openkrill.apps.argo-cd.applications.matrix-appservice-irc = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "matrix-appservice-irc.yaml";
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
    openkrill.manifests.matrix-appservice-irc.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name      = "matrix-appservice-irc";
        chart     = charts.cyclika94.matrix-appservice-irc.versions."1.0.0";
        namespace = cfg.namespace;
        values    = recursiveUpdate defaults cfg.values;
      };
  };
}
