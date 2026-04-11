# apps/node-red — Node-RED low-code event-driven programming
#
# Deploys Node-RED as a single-replica Deployment with a PVC for
# persistent flow storage (/data).  Uses the bjw-s app-template Helm
# chart (Pattern 6) since Node-RED has no official Helm chart.
#
# No database required — Node-RED stores flows as JSON files on disk.
#
# Authentication: the ingress route defaults to ForwardAuth (Authelia),
# so only authenticated users can reach the editor.  Node-RED itself
# runs without adminAuth — Authelia gates all access at the ingress
# layer.  The credential secret for flow encryption is generated once
# and stored via the secrets pipeline so encrypted flow credentials
# survive pod restarts.
#
# Bootstrap workflow:
#   1. openkrill-generate-node-red (after: lldap) creates
#      openkrill-node-red in secret-store with CREDENTIAL_SECRET
#      and ADMIN_PASSWORD.
#   2. ESO syncs into the node-red namespace as "node-red-auth".
#   3. The container reads NODE_RED_CREDENTIAL_SECRET from the secret.
#   4. Navigate to https://node-red.<domain>
{ config, lib, pkgs, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.node-red;
  lldapCfg = config.openkrill.apps.lldap;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  appTemplate = import ../../../modules/lib/app-template.nix { inherit lib; };
  domain = config.openkrill.domain;

  sourceSecretName = "openkrill-node-red";
  targetSecretName = "node-red-auth";

  # appTemplate.valuesType fills unset options with null defaults.
  # recursiveUpdate treats null as a leaf, so cfg.values.global = null
  # would stomp defaults.global.  Strip nulls before merging.
  removeNulls = attrs:
    filterAttrs (_: v: v != null) (mapAttrs (_: v:
      if isAttrs v then removeNulls v else v
    ) attrs);

  defaults = {
    global.nameOverride = "node-red";

    controllers.main = {
      strategy = "Recreate";

      containers.main = {
        image = {
          repository = cfg.image.repository;
          tag = cfg.image.tag;
        };

        env = {
          TZ = "UTC";
          NODE_RED_ENABLE_PROJECTS = "true";
        };

        envFrom = [
          { secretRef.name = targetSecretName; }
        ];

        securityContext = {
          runAsUser = 1000;
          runAsGroup = 1000;
        };

        probes = {
          liveness = {
            enabled = true;
            custom = true;
            spec = {
              httpGet = { path = "/"; port = 1880; };
              initialDelaySeconds = 30;
              periodSeconds = 30;
              failureThreshold = 3;
            };
          };
          readiness = {
            enabled = true;
            custom = true;
            spec = {
              httpGet = { path = "/"; port = 1880; };
              initialDelaySeconds = 10;
              periodSeconds = 10;
            };
          };
          startup = {
            enabled = true;
            custom = true;
            spec = {
              httpGet = { path = "/"; port = 1880; };
              initialDelaySeconds = 10;
              periodSeconds = 5;
              failureThreshold = 20;
            };
          };
        };

        resources = {
          requests = { cpu = "100m"; memory = "256Mi"; };
          limits   = { memory = "512Mi"; };
        };
      };
    };

    service.main = {
      controller = "main";
      ports.http = {
        port = 1880;
        protocol = "HTTP";
      };
    };

    persistence.data = {
      type = "persistentVolumeClaim";
      accessMode = "ReadWriteOnce";
      size = cfg.persistence.size;
      globalMounts = [{ path = "/data"; }];
    };
  };
in
{
  options.openkrill.apps.node-red = {
    enable = mkEnableOption "Node-RED low-code automation platform";

    namespace = mkOption {
      type = types.str;
      default = "node-red";
    };

    image = {
      repository = mkOption {
        type = types.str;
        default = "nodered/node-red";
        description = "Node-RED container image repository.";
      };
      tag = mkOption {
        type = types.str;
        default = "4.0.9";
        description = "Node-RED container image tag.";
      };
    };

    persistence = {
      size = mkOption {
        type = types.str;
        default = "5Gi";
        description = "PVC size for Node-RED /data volume.";
      };
      storageClass = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Storage class for the PVC (null = cluster default).";
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
    # ── Secret generator: credential secret for flow encryption ─────
    # Also stores the LLDAP admin password for potential adminAuth use.
    openkrill.secrets.generators.node-red = {
      packages = with pkgs; [ openssl ];
      after = [ "lldap" ];
      script = ''
        LLDAP_PASS=""
        if kubectl -n "$NS" get secret openkrill-lldap >/dev/null 2>&1; then
          LLDAP_PASS=$(kubectl -n "$NS" get secret openkrill-lldap \
            -o jsonpath='{.data.LLDAP_LDAP_USER_PASS}' | base64 -d)
        fi

        create_secret ${sourceSecretName} \
          --from-literal=CREDENTIAL_SECRET="$(openssl rand -hex 32)" \
          --from-literal=ADMIN_PASSWORD="''${LLDAP_PASS:-$(openssl rand -hex 16)}"
      '';
    };

    # ── ExternalSecret: sync into node-red namespace ─────────────────
    openkrill.apps.external-secrets.secrets.${targetSecretName} = {
      namespace = cfg.namespace;
      remoteSecretName = sourceSecretName;
      keys = [
        "CREDENTIAL_SECRET"
        "ADMIN_PASSWORD"
      ];
    };

    # ── Ingress route ────────────────────────────────────────────────
    # Default auth = "forward" (Authelia ForwardAuth).
    # Node-RED runs without adminAuth — Authelia gates access.
    openkrill.ingress.routes.node-red = {
      subdomain = "node-red";
      namespace = cfg.namespace;
      service = "node-red";
      port = 1880;
    };

    # ── ArgoCD Application ───────────────────────────────────────────
    openkrill.apps.argo-cd.applications.node-red = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "node-red.yaml";
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

    # ── Manifests ────────────────────────────────────────────────────
    openkrill.manifests.node-red.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name = "node-red";
        chart = charts.bjw-s-labs.app-template.versions."4.6.2";
        namespace = cfg.namespace;
        values = recursiveUpdate
          (recursiveUpdate defaults
            (optionalAttrs (cfg.persistence.storageClass != null) {
              persistence.data.storageClass = cfg.persistence.storageClass;
            }))
          (removeNulls cfg.values);
        extraOpts = [ "--skip-schema-validation" ];
      };
  };
}
