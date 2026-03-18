# Element Web K8s resources — pure nix, no helm
# Returns a flat list of K8s resource attrsets.
{ lib, cfg }:
let
  ns = cfg.namespace;

  image = "${cfg.image.repository}:${cfg.image.tag}";

  labels = {
    "app.kubernetes.io/name" = "element-web";
    "app.kubernetes.io/instance" = "element-web";
    "app.kubernetes.io/version" = cfg.image.tag;
    "app.kubernetes.io/managed-by" = "nix";
  };

  selectorLabels = {
    "app.kubernetes.io/name" = "element-web";
    "app.kubernetes.io/instance" = "element-web";
  };

  # ── config.json ──────────────────────────────────────────────────────
  # Sensible defaults: privacy-respecting (no vector.im integrations,
  # no rageshake), pointed at the auto-wired homeserver.
  configDefaults = {
    default_server_config = {
      "m.homeserver" = {
        base_url = cfg.homeserverUrl;
        server_name = cfg.serverName;
      };
    };

    # Disable third-party integrations and telemetry by default.
    # Consumers can re-enable via extraConfig.
    disable_custom_urls = false;
    disable_guests = true;
    disable_login_language_selector = false;
    disable_3pid_login = false;

    brand = "Element";
    default_theme = cfg.defaultTheme;
    default_federate = false;

    show_labs_settings = false;
    features = {};

    room_directory.servers = [];

    setting_defaults = {
      breadcrumbs = true;
    };
  };

  configJson = builtins.toJSON (lib.recursiveUpdate configDefaults cfg.extraConfig);

in
[
  # ── ConfigMap ──────────────────────────────────────────────────────
  {
    apiVersion = "v1";
    kind = "ConfigMap";
    metadata = {
      name = "element-config";
      namespace = ns;
      inherit labels;
    };
    data."config.json" = configJson;
  }

  # ── Deployment ─────────────────────────────────────────────────────
  {
    apiVersion = "apps/v1";
    kind = "Deployment";
    metadata = {
      name = "element-web";
      namespace = ns;
      inherit labels;
    };
    spec = {
      replicas = 1;
      selector.matchLabels = selectorLabels;
      template = {
        metadata.labels = labels;
        spec = {
          containers = [{
            name = "element-web";
            inherit image;
            ports = [{
              name = "http";
              containerPort = 80;
              protocol = "TCP";
            }];
            volumeMounts = [{
              name = "config";
              mountPath = "/app/config.json";
              subPath = "config.json";
            }];
            readinessProbe = {
              httpGet = { path = "/"; port = "http"; };
              initialDelaySeconds = 2;
              periodSeconds = 3;
            };
            livenessProbe = {
              httpGet = { path = "/"; port = "http"; };
              initialDelaySeconds = 10;
              periodSeconds = 10;
            };
            resources = {
              requests = { cpu = "50m"; memory = "32Mi"; };
              limits   = { cpu = "200m"; memory = "64Mi"; };
            };
          }];
          volumes = [{
            name = "config";
            configMap.name = "element-config";
          }];
        };
      };
    };
  }

  # ── Service ────────────────────────────────────────────────────────
  {
    apiVersion = "v1";
    kind = "Service";
    metadata = {
      name = "element-web";
      namespace = ns;
      inherit labels;
    };
    spec = {
      selector = selectorLabels;
      ports = [{
        name = "http";
        protocol = "TCP";
        port = 80;
        targetPort = 80;
      }];
    };
  }
]
