# apps/mautrix — mautrix bridge platform
#
# Single module for all mautrix Go bridges.  Each bridge is deployed
# via the bjw-s app-template Helm chart (same pattern as kremlin).
# Bridges share a namespace, the CNPG Postgres cluster, and a common
# secret generator.
#
# Usage:
#   openkrill.apps.mautrix.enable = true;
#   openkrill.apps.mautrix.bridges.whatsapp.enable = true;
#
# After deployment, run bin/mautrix-register-whatsapp and paste the
# output into the conduwuit #admins room.
{ config, lib, pkgs, charts, kubelib, k8s, ... }:
with lib;
let
  cfg          = config.openkrill.apps.mautrix;
  conduwuitCfg = config.openkrill.apps.conduwuit;
  helpers      = import ../../../modules/lib/helpers.nix { inherit lib; };

  mkBridgeValues = import ./resources.nix { inherit lib; };

  # ── Bridge definitions ──────────────────────────────────────────
  whatsappDefaults   = import ./bridges/whatsapp.nix;
  signalDefaults     = import ./bridges/signal.nix;
  telegramDefaults   = import ./bridges/telegram.nix;
  slackDefaults      = import ./bridges/slack.nix;
  metaDefaults       = import ./bridges/meta.nix;
  twitterDefaults    = import ./bridges/twitter.nix;
  googlechatDefaults = import ./bridges/googlechat.nix;
  blueskyDefaults    = import ./bridges/bluesky.nix;
  linkedinDefaults   = import ./bridges/linkedin.nix;
  gmessagesDefaults  = import ./bridges/gmessages.nix;
  gvoiceDefaults     = import ./bridges/gvoice.nix;
  zulipDefaults      = import ./bridges/zulip.nix;

  # Conduwuit auto-wiring
  conduwuitEnabled = conduwuitCfg.enable;
  conduwuitAddress =
    if conduwuitEnabled
    then "http://conduwuit.${conduwuitCfg.namespace}.svc.cluster.local:80"
    else "http://localhost:8008";
  conduwuitDomain =
    if conduwuitEnabled
    then conduwuitCfg.serverName
    else "example.com";

  # ── Helper: build option set for a single bridge ────────────────
  mkBridgeOptions = name: defaults: {
    enable = mkEnableOption "mautrix-${name} bridge";

    image = {
      repository = mkOption {
        type = types.str;
        default = defaults.image.repository;
        description = "Container image repository for mautrix-${name}.";
      };
      tag = mkOption {
        type = types.str;
        default = defaults.image.tag;
        description = "Container image tag for mautrix-${name}.";
      };
    };

    bot.username = mkOption {
      type = types.str;
      default = defaults.bot.username;
      description = "Matrix username for the ${name} bridge bot.";
    };

    appservice = {
      id = mkOption {
        type = types.str;
        default = defaults.appservice.id;
        description = "Appservice ID registered with the homeserver.";
      };
      port = mkOption {
        type = types.port;
        default = defaults.port;
        description = "Port the bridge listens on for appservice traffic.";
      };
    };

    permissions = mkOption {
      type = types.attrsOf types.str;
      default = { "*" = "relay"; };
      description = ''
        Bridge permission map.  Keys are Matrix user IDs or wildcards,
        values are permission levels: user, relay, admin.
      '';
      example = {
        "*" = "relay";
        "@admin:cia.net" = "admin";
      };
    };

    extraConfig = mkOption {
      type = types.attrs;
      default = {};
      description = "Extra config deep-merged into the bridge config.yaml.";
    };
  };

  # ── Collect enabled bridges ─────────────────────────────────────
  enabledBridges = filter (b: b.cfg.enable) [
    { name = "whatsapp";   cfg = cfg.bridges.whatsapp;   defaults = whatsappDefaults;   }
    { name = "signal";     cfg = cfg.bridges.signal;     defaults = signalDefaults;     }
    { name = "telegram";   cfg = cfg.bridges.telegram;   defaults = telegramDefaults;   }
    { name = "slack";      cfg = cfg.bridges.slack;      defaults = slackDefaults;      }
    { name = "meta";       cfg = cfg.bridges.meta;       defaults = metaDefaults;       }
    { name = "twitter";    cfg = cfg.bridges.twitter;    defaults = twitterDefaults;    }
    { name = "googlechat"; cfg = cfg.bridges.googlechat; defaults = googlechatDefaults; }
    { name = "bluesky";    cfg = cfg.bridges.bluesky;    defaults = blueskyDefaults;    }
    { name = "linkedin";   cfg = cfg.bridges.linkedin;   defaults = linkedinDefaults;   }
    { name = "gmessages";  cfg = cfg.bridges.gmessages;  defaults = gmessagesDefaults;  }
    { name = "gvoice";     cfg = cfg.bridges.gvoice;     defaults = gvoiceDefaults;     }
    { name = "zulip";      cfg = cfg.bridges.zulip;      defaults = zulipDefaults;      }
  ];

  # ── Secret key names per bridge ─────────────────────────────────
  bridgeSecretKeys = bridge: {
    asToken = "MAUTRIX_${toUpper bridge.name}_AS_TOKEN";
    hsToken = "MAUTRIX_${toUpper bridge.name}_HS_TOKEN";
  };

  # ── ESO keys for a bridge ───────────────────────────────────────
  bridgeEsoKeys = bridge:
    let keys = bridgeSecretKeys bridge;
    in [ keys.asToken keys.hsToken "POSTGRES_PASSWORD" ];

  # ── Render Helm manifests for a bridge ──────────────────────────
  bridgeManifests = bridge:
    let
      values = mkBridgeValues {
        name       = bridge.name;
        namespace  = cfg.namespace;
        image      = { inherit (bridge.cfg.image) repository tag; };
        port       = bridge.cfg.appservice.port;
        bot        = { inherit (bridge.cfg.bot) username; };
        appservice = { inherit (bridge.cfg.appservice) id; };
        homeserver = { address = conduwuitAddress; domain = conduwuitDomain; };
        database   = "mautrix_${bridge.name}";
        secretName = "mautrix-${bridge.name}";
        permissions = bridge.cfg.permissions;
        extraConfig = bridge.cfg.extraConfig;
      };
    in
    kubelib.fromHelm {
      name      = "mautrix-${bridge.name}";
      chart     = charts.bjw-s-labs.app-template.latest;
      namespace = cfg.namespace;
      inherit values;
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
    bridges.whatsapp   = mkBridgeOptions "whatsapp"   whatsappDefaults;
    bridges.signal     = mkBridgeOptions "signal"     signalDefaults;
    bridges.telegram   = mkBridgeOptions "telegram"   telegramDefaults;
    bridges.slack      = mkBridgeOptions "slack"      slackDefaults;
    bridges.meta       = mkBridgeOptions "meta"       metaDefaults;
    bridges.twitter    = mkBridgeOptions "twitter"    twitterDefaults;
    bridges.googlechat = mkBridgeOptions "googlechat" googlechatDefaults;
    bridges.bluesky    = mkBridgeOptions "bluesky"    blueskyDefaults;
    bridges.linkedin   = mkBridgeOptions "linkedin"   linkedinDefaults;
    bridges.gmessages  = mkBridgeOptions "gmessages"  gmessagesDefaults;
    bridges.gvoice     = mkBridgeOptions "gvoice"     gvoiceDefaults;
    bridges.zulip      = mkBridgeOptions "zulip"      zulipDefaults;
  };

  # ════════════════════════════════════════════════════════════════
  # Config
  # ════════════════════════════════════════════════════════════════
  config = mkIf (cfg.enable && enabledBridges != []) {
    # ── Secret generator ──────────────────────────────────────────
    openkrill.secrets.generators.mautrix = {
      packages = with pkgs; [ openssl ];
      script = let
        bridgeLiterals = concatMapStringsSep " \\\n        " (bridge:
          let keys = bridgeSecretKeys bridge; in
          ''--from-literal=${keys.asToken}="$(openssl rand -hex 32)" \
        --from-literal=${keys.hsToken}="$(openssl rand -hex 32)"''
        ) enabledBridges;
      in ''
        # Read Postgres password from CNPG-generated secret.
        PG_PASS=$(
          kubectl -n secret-store get secret openkrill-cloudnative-pg-app \
            -o jsonpath='{.data.password}' 2>/dev/null | base64 -d || \
          kubectl -n cloudnative-pg get secret postgres-app \
            -o jsonpath='{.data.password}' | base64 -d
        )

        create_secret openkrill-mautrix \
        ${bridgeLiterals} \
        --from-literal=POSTGRES_PASSWORD="''${PG_PASS}"
      '';
    };

    # ── ExternalSecrets — one per bridge ──────────────────────────
    openkrill.apps.external-secrets.secrets = listToAttrs (map (bridge: {
      name = "mautrix-${bridge.name}";
      value = {
        namespace = cfg.namespace;
        remoteSecretName = "openkrill-mautrix";
        keys = bridgeEsoKeys bridge;
      };
    }) enabledBridges);

    # ── CNPG Database CRDs — one per bridge ───────────────────────
    openkrill.apps.cloudnative-pg.databases = listToAttrs (map (bridge: {
      name = "mautrix-${bridge.name}";
      value = {
        namespace = config.openkrill.apps.cloudnative-pg.namespace or "cloudnative-pg";
        name = "mautrix_${bridge.name}";
        owner = "app";
        cluster.name = config.openkrill.apps.cloudnative-pg.clusterName or "postgres";
      };
    }) enabledBridges);

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
