# apps/stable/vibekanban — Vibe Kanban Cloud (self-hosted)
#
# AI-powered project management and issue tracking with real-time sync.
# Uses the BloopAI/vibe-kanban Docker image (Rust server + embedded
# frontend) with PostgreSQL and ElectricSQL for real-time sync.
#
# Deployment uses the bjw-s app-template Helm chart (Pattern 6) since
# Vibe Kanban has no official Helm chart.  The module deploys two
# controllers:
#   - main: the remote-server (API + UI on port 8081)
#   - electric: ElectricSQL real-time sync engine (port 3000)
#
# Database: the shared CloudNativePG cluster provides the "vibekanban"
# database.  ExternalSecrets template CNPG credentials into connection
# strings for both remote-server and ElectricSQL.
#
# Authentication: Vibe Kanban supports GitHub/Google OAuth and a
# bootstrap local auth mode.  The module registers an Authelia OIDC
# client when SSO is desired, but the default local auth mode works
# out of the box.
#
# Bootstrap workflow:
#   1. openkrill-generate-vibekanban systemd oneshot creates
#      openkrill-vibekanban in the secret-store namespace with
#      JWT_SECRET and optionally OAuth credentials.
#   2. ESO syncs openkrill-vibekanban into the vibekanban namespace
#      as "vibekanban".
#   3. An ExternalSecret templates CNPG credentials into DATABASE_URL
#      secrets for both the server and ElectricSQL.
#   4. The app-template deployments mount the secrets as env vars.
#   5. Navigate to https://vibekanban.<domain>
{ config, lib, pkgs, charts, kubelib, k8s, ... }:
with lib;
let
  cfg      = config.openkrill.apps.vibekanban;
  cnpgCfg  = config.openkrill.apps.cloudnative-pg;
  helpers     = import ../../../modules/lib/helpers.nix { inherit lib; };
  appTemplate = import ../../../modules/lib/app-template.nix { inherit lib; };
  domain   = config.openkrill.domain;

  # CNPG shared cluster details
  cnpgAppSecret = "${cnpgCfg.clusterName}-app";
  dbSecretName  = "vibekanban-db";
  dbHost        = "${cnpgCfg.clusterName}-rw.${cnpgCfg.namespace}.svc.cluster.local";

  # ElectricSQL needs a separate role with replication privileges.
  # The CNPG app user is used for the server; electric gets its own
  # ExternalSecret that templates the connection string with the
  # electric_sync role (created via postInitSQL).
  electricDbSecretName = "vibekanban-electric-db";

  # Source secret created by the systemd generator.
  sourceSecretName = "openkrill-vibekanban";

  # In-namespace secret name (synced by ESO).
  targetSecretName = "vibekanban";

  # Strip nulls before merging (same pattern as lobehub/skyvern).
  removeNulls = attrs:
    filterAttrs (_: v: v != null) (mapAttrs (_: v:
      if isAttrs v then removeNulls v else v
    ) attrs);

  defaults = {
    global.nameOverride = "vibekanban";

    controllers = {
      # ── Main server ────────────────────────────────────────────
      main = {
        containers.main = {
          image = {
            repository = cfg.image.repository;
            tag = cfg.image.tag;
          };
          env = {
            RUST_LOG = "info,remote=info";
            SERVER_LISTEN_ADDR = "0.0.0.0:8081";
            ELECTRIC_URL = "http://vibekanban-electric:3000";
            SERVER_PUBLIC_BASE_URL = "https://${cfg.domain}";
            SELF_HOST_LOCAL_AUTH_EMAIL = cfg.localAuth.email;
            SELF_HOST_LOCAL_AUTH_PASSWORD = cfg.localAuth.password;
          };
          envFrom = [
            { secretRef.name = targetSecretName; }
            { secretRef.name = dbSecretName; }
          ];
          probes = {
            liveness = {
              enabled = true;
              custom  = true;
              spec = {
                httpGet = {
                  path = "/v1/health";
                  port = 8081;
                };
                initialDelaySeconds = 30;
                periodSeconds       = 15;
                failureThreshold    = 5;
              };
            };
            readiness = {
              enabled = true;
              custom  = true;
              spec = {
                httpGet = {
                  path = "/v1/health";
                  port = 8081;
                };
                initialDelaySeconds = 15;
                periodSeconds       = 10;
              };
            };
            startup = {
              enabled = true;
              custom  = true;
              spec = {
                httpGet = {
                  path = "/v1/health";
                  port = 8081;
                };
                initialDelaySeconds = 10;
                periodSeconds       = 5;
                failureThreshold    = 30;
              };
            };
          };
          resources = {
            requests = { cpu = "100m"; memory = "256Mi"; };
            limits   = { memory = "1Gi"; };
          };
        };
      };

      # ── ElectricSQL ────────────────────────────────────────────
      electric = {
        containers.main = {
          image = {
            repository = "electricsql/electric";
            tag = cfg.electric.image.tag;
          };
          env = {
            PG_PROXY_PORT = "65432";
            LOGICAL_PUBLISHER_HOST = "electric";
            AUTH_MODE = "insecure";
            ELECTRIC_INSECURE = "true";
            ELECTRIC_MANUAL_TABLE_PUBLISHING = "true";
            ELECTRIC_USAGE_REPORTING = "false";
            ELECTRIC_FEATURE_FLAGS = "allow_subqueries,tagged_subqueries";
          };
          envFrom = [
            { secretRef.name = electricDbSecretName; }
          ];
          probes = {
            liveness = {
              enabled = true;
              custom  = true;
              spec = {
                httpGet = {
                  path = "/api/status";
                  port = 3000;
                };
                initialDelaySeconds = 15;
                periodSeconds       = 10;
                failureThreshold    = 5;
              };
            };
            readiness = {
              enabled = true;
              custom  = true;
              spec = {
                httpGet = {
                  path = "/api/status";
                  port = 3000;
                };
                initialDelaySeconds = 10;
                periodSeconds       = 5;
              };
            };
            startup = {
              enabled = true;
              custom  = true;
              spec = {
                httpGet = {
                  path = "/api/status";
                  port = 3000;
                };
                initialDelaySeconds = 5;
                periodSeconds       = 5;
                failureThreshold    = 30;
              };
            };
          };
          resources = {
            requests = { cpu = "50m"; memory = "128Mi"; };
            limits   = { memory = "512Mi"; };
          };
        };
      };
    };

    # ── Services ──────────────────────────────────────────────────
    service = {
      main = {
        controller = "main";
        ports.http = {
          port     = 8081;
          protocol = "HTTP";
        };
      };
      electric = {
        controller = "electric";
        ports.http = {
          port     = 3000;
          protocol = "HTTP";
        };
      };
    };

    # ── Persistence ───────────────────────────────────────────────
    # ElectricSQL persistent state
    persistence.electric-data = {
      type        = "persistentVolumeClaim";
      accessMode  = "ReadWriteOnce";
      size        = "5Gi";
      advancedMounts.electric.main = [
        { path = "/app/persistent"; }
      ];
    };
  };
in
{
  options.openkrill.apps.vibekanban = {
    enable = mkEnableOption "Vibe Kanban Cloud — AI-powered project management";

    namespace = mkOption {
      type    = types.str;
      default = "vibekanban";
    };

    domain = mkOption {
      type        = types.str;
      default     = "vibekanban.${domain}";
      description = "FQDN for the Vibe Kanban instance.";
    };

    image = {
      repository = mkOption {
        type        = types.str;
        default     = "ghcr.io/general-intelligence-systems/vibe-kanban";
        description = "Remote server container image repository.";
      };
      tag = mkOption {
        type        = types.str;
        default     = "latest";
        description = "Remote server container image tag.";
      };
    };

    electric.image.tag = mkOption {
      type        = types.str;
      default     = "1.4.13";
      description = "ElectricSQL container image tag.";
    };

    localAuth = {
      email = mkOption {
        type        = types.str;
        default     = "";
        description = "Bootstrap local auth email (single admin user). Leave empty to disable.";
      };
      password = mkOption {
        type        = types.str;
        default     = "";
        description = "Bootstrap local auth password. Leave empty to disable.";
      };
    };

    values = mkOption {
      type        = appTemplate.valuesType;
      default     = {};
      description = "app-template Helm chart values (typed), deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── CNPG Database (inside the shared cluster) ─────────────────
    openkrill.apps.cloudnative-pg.databases.vibekanban = {
      namespace    = cnpgCfg.namespace;
      name         = "vibekanban";
      owner        = "app";
      cluster.name = cnpgCfg.clusterName;
      postInitSQL  = [
        # ElectricSQL requires a role with replication + wal_level=logical.
        # wal_level=logical is set on the CNPG cluster; here we create the
        # electric_sync role and grant it access to the vibekanban database.
        "CREATE ROLE electric_sync WITH LOGIN PASSWORD 'electric_sync_password' REPLICATION"
        "GRANT ALL PRIVILEGES ON DATABASE vibekanban TO electric_sync"
        "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO electric_sync"
        "ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO electric_sync"
      ];
    };

    # ── ExternalSecret: server database credentials ───────────────
    # Templates a postgres:// DATABASE_URL for the remote-server.
    openkrill.apps.external-secrets.externalsecrets.${dbSecretName} = {
      namespace = cfg.namespace;
      secretStoreRef = {
        name = cnpgCfg.clusterSecretStoreName;
        kind = "ClusterSecretStore";
      };
      refreshInterval = "1h";
      target = {
        name           = dbSecretName;
        creationPolicy = "Owner";
        template.data = {
          SERVER_DATABASE_URL = "postgres://{{ .username }}:{{ .password }}@${dbHost}:5432/vibekanban";
        };
      };
      data = [
        {
          secretKey = "username";
          remoteRef = {
            key      = cnpgAppSecret;
            property = "username";
          };
        }
        {
          secretKey = "password";
          remoteRef = {
            key      = cnpgAppSecret;
            property = "password";
          };
        }
      ];
    };

    # ── ExternalSecret: ElectricSQL database credentials ──────────
    # ElectricSQL needs its own DATABASE_URL with the electric_sync role.
    openkrill.apps.external-secrets.externalsecrets.${electricDbSecretName} = {
      namespace = cfg.namespace;
      secretStoreRef = {
        name = cnpgCfg.clusterSecretStoreName;
        kind = "ClusterSecretStore";
      };
      refreshInterval = "1h";
      target = {
        name           = electricDbSecretName;
        creationPolicy = "Owner";
        template.data = {
          DATABASE_URL = "postgresql://electric_sync:{{ .electric_password }}@${dbHost}:5432/vibekanban?sslmode=disable";
        };
      };
      data = [
        {
          secretKey = "electric_password";
          remoteRef = {
            key      = sourceSecretName;
            property = "ELECTRIC_ROLE_PASSWORD";
          };
        }
      ];
    };

    # ── ExternalSecret: Vibe Kanban secrets ───────────────────────
    # Syncs the source secret into the vibekanban namespace.
    openkrill.apps.external-secrets.secrets.${targetSecretName} = {
      namespace        = cfg.namespace;
      remoteSecretName = sourceSecretName;
      keys = [
        "VIBEKANBAN_REMOTE_JWT_SECRET"
        "ELECTRIC_ROLE_PASSWORD"
      ];
    };

    # ── Secret generator ──────────────────────────────────────────
    # Generates JWT_SECRET and ELECTRIC_ROLE_PASSWORD on first boot.
    openkrill.secrets.generators.vibekanban = {
      packages = with pkgs; [ openssl ];
      script = ''
        create_secret ${sourceSecretName} \
          --from-literal=VIBEKANBAN_REMOTE_JWT_SECRET="$(openssl rand -base64 48)" \
          --from-literal=ELECTRIC_ROLE_PASSWORD="$(openssl rand -base64 24)"
      '';
    };

    # ── Route ─────────────────────────────────────────────────────
    # Vibe Kanban handles its own auth — no ForwardAuth needed.
    openkrill.ingress.routes.vibekanban = {
      subdomain = "vibekanban";
      namespace = cfg.namespace;
      service   = "vibekanban";
      port      = 8081;
      auth      = "none";
    };

    # ── ArgoCD Application CR ─────────────────────────────────────
    openkrill.apps.argo-cd.applications.vibekanban = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project   = "default";
      source = {
        repoURL        = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path           = ".";
        directory.include = "vibekanban.yaml";
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

    # ── Manifests ─────────────────────────────────────────────────
    openkrill.manifests.vibekanban.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name      = "vibekanban";
        chart     = charts.bjw-s-labs.app-template.versions."4.6.2";
        namespace = cfg.namespace;
        values    = recursiveUpdate defaults (removeNulls cfg.values);
        extraOpts = [ "--skip-schema-validation" ];
      };
  };
}
