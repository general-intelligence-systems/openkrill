# apps/radicale -- Radicale CalDAV/CardDAV server
#
# Deploys tomsquest/docker-radicale via the bjw-s app-template chart.
# The module exposes Radicale over HTTPS ingress and persists collections
# data on a PVC mounted at /data.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.radicale;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  appTemplate = import ../../../modules/lib/app-template.nix { inherit lib; };

  authSecretName = "radicale-auth";
  rightsKey = "rights";

  radicaleConfig = ''
    [server]
    hosts = 0.0.0.0:5232

    [auth]
    type = http_remote_user

    [rights]
    type = from_file
    file = /config/${rightsKey}

    [web]
    type = none

    [storage]
    filesystem_folder = /data/collections
  '';

  rightsConfig = ''
    [root]
    user: .+
    collection:
    permissions: R

    [principal]
    user: .+
    collection: {user}
    permissions: RW

    [calendars]
    user: .+
    collection: {user}/[^/]+
    permissions: rw
  '';

  # appTemplate.valuesType fills unset options with null defaults.
  # recursiveUpdate treats null as a leaf, so cfg.values.global = null
  # would stomp defaults.global. Strip nulls before merging.
  removeNulls = attrs:
    filterAttrs (_: v: v != null) (mapAttrs (_: v:
      if isAttrs v then removeNulls v else v
    ) attrs);

  defaults = {
    global.nameOverride = "radicale";

    controllers.main = {
      strategy = "Recreate";

      containers.main = {
        image = {
          repository = cfg.image.repository;
          tag = cfg.image.tag;
        };

        env = {
          TZ = cfg.timezone;
          TAKE_FILE_OWNERSHIP = if cfg.takeFileOwnership then "true" else "false";
        };

        probes = {
          liveness = {
            enabled = true;
            custom = true;
            spec = {
              tcpSocket.port = 5232;
              initialDelaySeconds = 15;
              periodSeconds = 15;
              failureThreshold = 3;
            };
          };
          readiness = {
            enabled = true;
            custom = true;
            spec = {
              tcpSocket.port = 5232;
              initialDelaySeconds = 8;
              periodSeconds = 10;
            };
          };
          startup = {
            enabled = true;
            custom = true;
            spec = {
              tcpSocket.port = 5232;
              initialDelaySeconds = 5;
              periodSeconds = 5;
              failureThreshold = 20;
            };
          };
        };

        resources = {
          requests = { cpu = "25m"; memory = "64Mi"; };
          limits = { memory = "256Mi"; };
        };
      };
    };

    persistence.data = {
      type = "persistentVolumeClaim";
      storageClass = "local-path";
      accessMode = "ReadWriteOnce";
      size = cfg.storageSize;
      advancedMounts.main.main = [
        { path = "/data"; }
      ];
    };

    persistence.config = {
      type = "secret";
      name = authSecretName;
      items = [
        { key = "config"; path = "config"; }
        { key = rightsKey; path = rightsKey; }
      ];
      advancedMounts.main.main = [
        { path = "/config"; readOnly = true; }
      ];
    };

    service.main = {
      controller = "main";
      ports.http = {
        port = 5232;
        protocol = "HTTP";
      };
    };
  };
in
{
  options.openkrill.apps.radicale = {
    enable = mkEnableOption "Radicale CalDAV/CardDAV server";

    namespace = mkOption {
      type = types.str;
      default = "radicale";
      description = "Kubernetes namespace for Radicale.";
    };

    subdomain = mkOption {
      type = types.str;
      default = "cal";
      description = "Ingress subdomain for Radicale (e.g. cal.<domain>).";
    };

    storageSize = mkOption {
      type = types.str;
      default = "5Gi";
      description = "Size of the PersistentVolumeClaim mounted at /data.";
    };

    timezone = mkOption {
      type = types.str;
      default = "UTC";
      description = "Timezone passed to the container via TZ.";
    };

    takeFileOwnership = mkOption {
      type = types.bool;
      default = true;
      description = "Whether the container should chown /data on startup (TAKE_FILE_OWNERSHIP).";
    };

    image = {
      repository = mkOption {
        type = types.str;
        default = "tomsquest/docker-radicale";
        description = "Radicale image repository.";
      };

      tag = mkOption {
        type = types.str;
        default = "latest";
        description = "Radicale image tag.";
      };
    };

    values = mkOption {
      type = appTemplate.valuesType;
      default = {};
      description = "app-template Helm chart values (typed), deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    openkrill.manifests.radicale.content =
      [
        (k8s.mkNamespace cfg.namespace)
        {
          apiVersion = "v1";
          kind = "Secret";
          metadata = {
            name = authSecretName;
            namespace = cfg.namespace;
          };
          type = "Opaque";
          stringData = {
            config = radicaleConfig;
            "${rightsKey}" = rightsConfig;
          };
        }
      ]
      ++ kubelib.fromHelm {
        name = "radicale";
        chart = charts.bjw-s-labs.app-template.versions."4.6.2";
        namespace = cfg.namespace;
        values = recursiveUpdate defaults (removeNulls cfg.values);
        extraOpts = [ "--skip-schema-validation" ];
      };

    # Route uses basic-auth ForwardAuth — DAV clients get a 401
    # challenge (not a redirect) so they can send credentials.
    # Authelia validates against LLDAP and sets Remote-User.
    openkrill.ingress.routes.radicale = {
      subdomain = cfg.subdomain;
      namespace = cfg.namespace;
      service = "radicale";
      port = 5232;
      auth = "basic";
    };

    openkrill.apps.argo-cd.applications.radicale = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "radicale.yaml";
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

  };
}
