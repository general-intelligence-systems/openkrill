# apps/mautrix — mautrix bridge platform
#
# Deploys mautrix bridges via the cyclika94 Helm charts from nixhelm2.
# Each bridge gets its own chart (StatefulSet, bundled Postgres,
# registration ConfigMap, double puppeting, runtime secret generation).
#
# The module follows the values.matrix.example.yaml pattern from
# https://github.com/cyclikal94/matrix-helm-charts/blob/main/INSTALLATION.md
#
# Usage:
#   openkrill.apps.mautrix.enable = true;
#   openkrill.apps.mautrix.bridges.whatsapp.enable = true;
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg            = config.openkrill.apps.mautrix;
  matrixStackCfg = config.openkrill.apps.matrix-stack;
  helpers        = import ../../../modules/lib/helpers.nix { inherit lib; };

  # ── Bridge definitions ──────────────────────────────────────────
  bridgeDefs = {
    whatsapp   = import ./bridges/whatsapp.nix;
    signal     = import ./bridges/signal.nix;
    telegram   = import ./bridges/telegram.nix;
    slack      = import ./bridges/slack.nix;
    meta       = import ./bridges/meta.nix;
    twitter    = import ./bridges/twitter.nix;
    googlechat = import ./bridges/googlechat.nix;
    bluesky    = import ./bridges/bluesky.nix;
    linkedin   = import ./bridges/linkedin.nix;
    gmessages  = import ./bridges/gmessages.nix;
    gvoice     = import ./bridges/gvoice.nix;
    zulip      = import ./bridges/zulip.nix;
  };

  # ── Homeserver auto-wiring (Synapse via matrix-stack) ───────────
  homeserverAddress =
    "http://matrix-stack-synapse.${matrixStackCfg.namespace}.svc.cluster.local:8008";
  homeserverDomain = matrixStackCfg.serverName;

  # ── Per-bridge NixOS options ────────────────────────────────────
  mkBridgeOptions = name: _def: {
    enable = mkEnableOption "mautrix-${name} bridge";

    values = mkOption {
      type = types.attrs;
      default = {};
      description = ''
        Helm chart value overrides for mautrix-${name},
        deep-merged with module defaults.
      '';
    };
  };

  # ── Collect enabled bridges ─────────────────────────────────────
  enabledBridges = filter (b: b.cfg.enable) (
    mapAttrsToList (name: def: {
      inherit name def;
      cfg = cfg.bridges.${name};
    }) bridgeDefs
  );

  # ── Default values per bridge ───────────────────────────────────
  # Mirrors the values.matrix.example.yaml from the chart docs.
  mkDefaultValues = bridge:
    let
      # Common values shared by all bridge types
      common = {
        homeserver = {
          address = homeserverAddress;
          domain  = homeserverDomain;
        };
        registration.synapseNamespace = matrixStackCfg.namespace;
      };

      # Go bridges (bridgev2): logging + config.baseExtra
      # doublePuppet is left at chart default (enabled) but we disable
      # the managed registration resources to avoid duplicate ConfigMaps
      # across bridges (all Go bridges share the same doublepuppet
      # registration via mautrix-go-base).
      goDefaults = common // {
        logging = "info";
        doublePuppet.enabled = false;
        config.baseExtra = ''
          bridge:
            permissions:
              "*": relay
              "${homeserverDomain}": user
        '';
      };

      # Python bridges: config.extra (no logging, no doublePuppet)
      pythonDefaults = common // {
        config.extra = ''
          bridge:
            permissions:
              "*": relaybot
        '';
      };

      # Telegram requires API credentials — provide placeholders so the
      # chart templates render.  Users MUST override via bridges.telegram.values.
      telegramDefaults = {
        telegram = {
          apiID = 1;
          apiHash = "placeholder";
        };
      };

      base = if bridge.def.type == "go" then goDefaults else pythonDefaults;
      extra = optionalAttrs (bridge.name == "telegram") telegramDefaults;
    in
    base // extra;

  # ── Render Helm manifests for a bridge ──────────────────────────
  bridgeManifests = bridge:
    let
      defaultValues = mkDefaultValues bridge;
    in
    kubelib.fromHelm {
      name      = "mautrix-${bridge.name}";
      chart     = charts.contrib.cyclika94.${bridge.def.chartName}.versions.${bridge.def.chartVersion};
      namespace = cfg.namespace;
      values    = recursiveUpdate defaultValues bridge.cfg.values;
      extraOpts = [ "--skip-schema-validation" ];
    };

in
{
  # ════════════════════════════════════════════════════════════════
  # Options
  # ════════════════════════════════════════════════════════════════
  options.openkrill.apps.mautrix = {
    enable = mkEnableOption "mautrix bridge platform";

    namespace = mkOption {
      type = types.str;
      default = "mautrix";
      description = "Shared Kubernetes namespace for all mautrix bridges.";
    };

    extraManifests = helpers.mkExtraManifestsOption;

    # ── Per-bridge options ──────────────────────────────────────────
    bridges = mapAttrs mkBridgeOptions bridgeDefs;
  };

  # ════════════════════════════════════════════════════════════════
  # Config
  # ════════════════════════════════════════════════════════════════
  config = mkIf (cfg.enable && enabledBridges != []) {
    # ── Synapse appservice registration wiring ────────────────────
    # The chart creates a registration ConfigMap in the Synapse
    # namespace (via registration.synapseNamespace), but Synapse
    # still needs to be told to load it.
    openkrill.apps.matrix-stack.values = {
      synapse.appservices = map (bridge: {
        configMap    = "mautrix-${bridge.name}-registration";
        configMapKey = bridge.def.registrationKey;
      }) enabledBridges;
    };

    # ── ArgoCD Application CR ─────────────────────────────────────
    openkrill.apps.argo-cd.applications.mautrix = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "mautrix.yaml";
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

    # ── Manifests ─────────────────────────────────────────────────
    openkrill.manifests.mautrix.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ concatMap bridgeManifests enabledBridges;
  };
}
