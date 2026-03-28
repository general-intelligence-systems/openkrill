# apps/radicale -- Radicale CalDAV/CardDAV server
#
# Deploys tomsquest/docker-radicale via the bjw-s app-template chart.
# The module exposes Radicale over HTTPS ingress and persists collections
# data on a PVC mounted at /data.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.radicale;
  lldapCfg = config.openkrill.apps.lldap;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  appTemplate = import ../../../modules/lib/app-template.nix { inherit lib; };

  authSecretName = "radicale-auth";
  ldapPasswordKey = "ldap-reader-password";

  radicaleConfig = ''
    [server]
    hosts = 0.0.0.0:5232

    [auth]
    type = ldap
    ldap_uri = ldap://lldap.${lldapCfg.namespace}.svc.cluster.local:3890
    ldap_base = ${lldapCfg.baseDn}
    ldap_reader_dn = UID=${lldapCfg.adminUser},OU=people,${lldapCfg.baseDn}
    ldap_secret_file = /config/${ldapPasswordKey}
    ldap_filter = (uid={0})
    ldap_user_attribute = uid

    [storage]
    filesystem_folder = /data/collections
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
        { key = ldapPasswordKey; path = ldapPasswordKey; }
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
    assertions = [
      {
        assertion = config.openkrill.apps.external-secrets.enable;
        message = "openkrill.apps.radicale requires openkrill.apps.external-secrets.enable = true";
      }
      {
        assertion = config.openkrill.apps.lldap.enable;
        message = "openkrill.apps.radicale requires openkrill.apps.lldap.enable = true";
      }
    ];

    openkrill.apps.external-secrets.secrets.${authSecretName} = {
      namespace = cfg.namespace;
      targetSecretName = authSecretName;
      remoteSecretName = "openkrill-lldap";
      keys = [
        { sourceKey = "LLDAP_LDAP_USER_PASS"; targetKey = ldapPasswordKey; }
      ];
      templateData = {
        config = radicaleConfig;
      };
    };

    # Keep auth disabled at ingress so DAV clients can use Radicale's
    # native auth methods (here: Radicale LDAP against LLDAP).
    openkrill.ingress.routes.radicale = {
      subdomain = cfg.subdomain;
      namespace = cfg.namespace;
      service = "radicale";
      port = 5232;
      auth = "none";
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

    openkrill.manifests.radicale.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name = "radicale";
        chart = charts.bjw-s-labs.app-template.versions."4.6.2";
        namespace = cfg.namespace;
        values = recursiveUpdate defaults (removeNulls cfg.values);
        extraOpts = [ "--skip-schema-validation" ];
      };
  };
}
