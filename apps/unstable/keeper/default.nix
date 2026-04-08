# apps/unstable/keeper — Keeper calendar sync tool
#
# Keeper is a self-hosted calendar syncing tool that aggregates events
# from remote iCal/ICS/CalDAV sources and pushes them to destination
# calendars (Google, Outlook, CalDAV, etc.).  The custom API image
# (built from images/keeper/) adds reverse-proxy auth: when Authelia
# sets Remote-User / Remote-Email headers, the API auto-provisions
# accounts and creates sessions — no login form is rendered.
#
# Deployment uses the bjw-s app-template Helm chart (Pattern 6) with
# separate controllers for each Keeper service, matching the upstream
# multi-container architecture:
#
#   web    — Vite SSR frontend (port 3000), proxies /api → api:3001
#            and /mcp → mcp:3002.  Only externally-exposed service.
#   api    — Bun API (port 3001), custom image with proxy auth overlay.
#   cron   — Enqueues calendar sync jobs to the BullMQ worker queue.
#   worker — Processes calendar sync jobs from the queue.
#   mcp    — Optional MCP server (port 3002) for AI agent calendar
#            access.
#   redis  — Valkey sidecar for job queues, sessions, and pub/sub.
#
# Database: the shared CloudNativePG cluster provides the "keeper"
# database.  An ExternalSecret templates CNPG credentials into a
# DATABASE_URL connection string.
#
# Bootstrap workflow:
#   1. openkrill-generate-keeper systemd oneshot creates
#      openkrill-keeper in the secret-store namespace with
#      BETTER_AUTH_SECRET and ENCRYPTION_KEY.
#   2. ESO syncs openkrill-keeper into the keeper namespace as
#      "keeper".
#   3. An ExternalSecret templates CNPG credentials into a
#      DATABASE_URL in the keeper-db secret.
#   4. The app-template deployments mount both secrets as env vars.
#   5. Navigate to https://<subdomain>.<domain>
{ config, lib, pkgs, charts, kubelib, k8s, ... }:
with lib;
let
  cfg     = config.openkrill.apps.keeper;
  cnpgCfg = config.openkrill.apps.cloudnative-pg;
  helpers    = import ../../../modules/lib/helpers.nix { inherit lib; };
  appTemplate = import ../../../modules/lib/app-template.nix { inherit lib; };
  domain  = config.openkrill.domain;

  # CNPG shared cluster details
  cnpgAppSecret = "${cnpgCfg.clusterName}-app";
  dbSecretName  = "keeper-db";
  dbHost        = "${cnpgCfg.clusterName}-rw.${cnpgCfg.namespace}.svc.cluster.local";

  # Source secret created by the systemd generator.
  sourceSecretName = "openkrill-keeper";

  # In-namespace secret name (synced by ESO).
  targetSecretName = "keeper";

  # External FQDN for Keeper.
  fqdn = "${cfg.subdomain}.${domain}";

  # Strip nulls before merging (same pattern as filestash/lobehub).
  removeNulls = attrs:
    filterAttrs (_: v: v != null) (mapAttrs (_: v:
      if isAttrs v then removeNulls v else v
    ) attrs);

  # Shared envFrom for services that need app secrets + DB credentials.
  secretEnvFrom = [
    { secretRef.name = targetSecretName; }
    { secretRef.name = dbSecretName; }
  ];

  defaults = {
    global.nameOverride = "keeper";

    controllers = {
      # ── Web: Vite SSR frontend ────────────────────────────────
      # The only externally-exposed service.  Proxies /api to the
      # API service and /mcp to the MCP service internally.
      web = {
        containers.main = {
          image = {
            repository = "ghcr.io/ridafkih/keeper-web";
            tag = cfg.image.tag;
          };
          env = {
            VITE_API_URL = "http://keeper-api:3001";
            VITE_MCP_URL = "http://keeper-mcp:3002";
            PORT = "3000";
            ENV = "production";
          };
          probes = {
            liveness = {
              enabled = true;
              custom  = true;
              spec = {
                httpGet = { path = "/"; port = 3000; };
                initialDelaySeconds = 15;
                periodSeconds       = 15;
                failureThreshold    = 5;
              };
            };
            readiness = {
              enabled = true;
              custom  = true;
              spec = {
                httpGet = { path = "/"; port = 3000; };
                initialDelaySeconds = 10;
                periodSeconds       = 10;
              };
            };
            startup = {
              enabled = true;
              custom  = true;
              spec = {
                httpGet = { path = "/"; port = 3000; };
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

      # ── API: Bun API service (custom image with proxy auth) ───
      api = {
        containers.main = {
          image = {
            repository = cfg.image.repository;
            tag = cfg.image.tag;
            pullPolicy = "Always";
          };
          env = {
            API_PORT = "3001";
            BETTER_AUTH_URL = "https://${fqdn}";
            REDIS_URL = "redis://keeper-redis:6379";
            PROXY_AUTH_ENABLED = "true";
            TRUSTED_ORIGINS = "https://${fqdn}";
            BLOCK_PRIVATE_RESOLUTION = "true";
            ENV = "production";
            NODE_EXTRA_CA_CERTS = "/etc/ssl/certs/openkrill-ca-bundle.pem";
          };
          envFrom = secretEnvFrom;
          probes = {
            liveness = {
              enabled = true;
              custom  = true;
              spec = {
                tcpSocket.port = 3001;
                initialDelaySeconds = 20;
                periodSeconds       = 15;
                failureThreshold    = 5;
              };
            };
            readiness = {
              enabled = true;
              custom  = true;
              spec = {
                tcpSocket.port = 3001;
                initialDelaySeconds = 15;
                periodSeconds       = 10;
              };
            };
            startup = {
              enabled = true;
              custom  = true;
              spec = {
                tcpSocket.port = 3001;
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

      # ── Cron: enqueues calendar sync jobs ─────────────────────
      cron = {
        containers.main = {
          image = {
            repository = "ghcr.io/ridafkih/keeper-cron";
            tag = cfg.image.tag;
          };
          env = {
            REDIS_URL = "redis://keeper-redis:6379";
            WORKER_JOB_QUEUE_ENABLED = "true";
            BLOCK_PRIVATE_RESOLUTION = "true";
            ENV = "production";
            NODE_EXTRA_CA_CERTS = "/etc/ssl/certs/openkrill-ca-bundle.pem";
          };
          envFrom = secretEnvFrom;
          resources = {
            requests = { cpu = "25m"; memory = "128Mi"; };
            limits   = { memory = "512Mi"; };
          };
        };
      };

      # ── Worker: processes calendar sync jobs from queue ────────
      worker = {
        containers.main = {
          image = {
            repository = "ghcr.io/ridafkih/keeper-worker";
            tag = cfg.image.tag;
          };
          env = {
            REDIS_URL = "redis://keeper-redis:6379";
            ENV = "production";
            NODE_EXTRA_CA_CERTS = "/etc/ssl/certs/openkrill-ca-bundle.pem";
          };
          envFrom = secretEnvFrom;
          resources = {
            requests = { cpu = "50m"; memory = "128Mi"; };
            limits   = { memory = "512Mi"; };
          };
        };
      };

      # ── MCP: Model Context Protocol server for AI agents ──────
      mcp = {
        containers.main = {
          image = {
            repository = "ghcr.io/ridafkih/keeper-mcp";
            tag = cfg.image.tag;
          };
          env = {
            MCP_PORT = "3002";
            MCP_PUBLIC_URL = "https://${fqdn}/mcp";
            BETTER_AUTH_URL = "https://${fqdn}";
            ENV = "production";
            NODE_EXTRA_CA_CERTS = "/etc/ssl/certs/openkrill-ca-bundle.pem";
          };
          envFrom = secretEnvFrom;
          probes = {
            liveness = {
              enabled = true;
              custom  = true;
              spec = {
                tcpSocket.port = 3002;
                initialDelaySeconds = 15;
                periodSeconds       = 15;
                failureThreshold    = 5;
              };
            };
            readiness = {
              enabled = true;
              custom  = true;
              spec = {
                tcpSocket.port = 3002;
                initialDelaySeconds = 10;
                periodSeconds       = 10;
              };
            };
            startup = {
              enabled = true;
              custom  = true;
              spec = {
                tcpSocket.port = 3002;
                initialDelaySeconds = 5;
                periodSeconds       = 5;
                failureThreshold    = 20;
              };
            };
          };
          resources = {
            requests = { cpu = "25m"; memory = "128Mi"; };
            limits   = { memory = "512Mi"; };
          };
        };
      };

      # ── Redis (Valkey): job queues, sessions, pub/sub ─────────
      redis = {
        containers.main = {
          image = {
            repository = "valkey/valkey";
            tag = "8-alpine";
          };
          probes = {
            liveness = {
              enabled = true;
              custom  = true;
              spec = {
                exec.command = [ "valkey-cli" "ping" ];
                initialDelaySeconds = 10;
                periodSeconds       = 10;
              };
            };
            readiness = {
              enabled = true;
              custom  = true;
              spec = {
                exec.command = [ "valkey-cli" "ping" ];
                initialDelaySeconds = 5;
                periodSeconds       = 5;
              };
            };
          };
          resources = {
            requests = { cpu = "25m"; memory = "64Mi"; };
            limits   = { memory = "256Mi"; };
          };
        };
      };
    };

    # ── Persistence ─────────────────────────────────────────────
    # Mount the cluster CA bundle so backend services trust internal
    # TLS certs (needed for CNPG, inter-service calls, etc.).
    persistence.ca-bundle = {
      type = "configMap";
      name = "openkrill-ca-bundle";
      advancedMounts = {
        api.main    = [{ path = "/etc/ssl/certs/openkrill-ca-bundle.pem"; subPath = "bundle.pem"; readOnly = true; }];
        cron.main   = [{ path = "/etc/ssl/certs/openkrill-ca-bundle.pem"; subPath = "bundle.pem"; readOnly = true; }];
        worker.main = [{ path = "/etc/ssl/certs/openkrill-ca-bundle.pem"; subPath = "bundle.pem"; readOnly = true; }];
        mcp.main    = [{ path = "/etc/ssl/certs/openkrill-ca-bundle.pem"; subPath = "bundle.pem"; readOnly = true; }];
      };
    };

    persistence.redis-data = {
      type = "emptyDir";
      advancedMounts.redis.main = [{ path = "/data"; }];
    };

    # ── Services ────────────────────────────────────────────────
    # "main" is the web service — only one exposed via ingress.
    # Internal services are named keeper-api, keeper-mcp, keeper-redis
    # by the app-template (nameOverride + service key).
    service = {
      main = {
        controller = "web";
        ports.http = {
          port     = 3000;
          protocol = "HTTP";
        };
      };
      api = {
        controller = "api";
        ports.http = {
          port     = 3001;
          protocol = "HTTP";
        };
      };
      mcp = {
        controller = "mcp";
        ports.http = {
          port     = 3002;
          protocol = "HTTP";
        };
      };
      redis = {
        controller = "redis";
        ports.redis = {
          port     = 6379;
          protocol = "TCP";
        };
      };
    };
  };
in
{
  options.openkrill.apps.keeper = {
    enable = mkEnableOption "Keeper calendar sync tool";

    namespace = mkOption {
      type    = types.str;
      default = "keeper";
      description = "Kubernetes namespace for Keeper.";
    };

    subdomain = mkOption {
      type    = types.str;
      default = "keeper";
      description = "Subdomain for the Keeper web UI (e.g. keeper.<domain>).";
    };

    image = {
      repository = mkOption {
        type    = types.str;
        default = "ghcr.io/general-intelligence-systems/keeper-api";
        description = "Custom keeper-api image repository (build with proxy auth from images/keeper/).";
      };
      tag = mkOption {
        type    = types.str;
        default = "latest";
        description = "Image tag shared across all Keeper service images.";
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
    openkrill.apps.cloudnative-pg.databases.keeper = {
      namespace    = cnpgCfg.namespace;
      name         = "keeper";
      owner        = "app";
      cluster.name = cnpgCfg.clusterName;
    };

    # ── ExternalSecret: database credentials ─────────────────────
    # Reads username + password from the CNPG-generated app secret
    # and templates a postgres:// DATABASE_URL for Keeper.
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
          DATABASE_URL = "postgresql://{{ .username }}:{{ .password }}@${dbHost}:5432/keeper";
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

    # ── ExternalSecret: Keeper secrets ────────────────────────────
    # Syncs the source secret into the keeper namespace.
    openkrill.apps.external-secrets.secrets.${targetSecretName} = {
      namespace        = cfg.namespace;
      remoteSecretName = sourceSecretName;
      keys = [
        "BETTER_AUTH_SECRET"
        "ENCRYPTION_KEY"
      ];
    };

    # ── Secret generator ──────────────────────────────────────────
    # Generates BETTER_AUTH_SECRET and ENCRYPTION_KEY on first boot.
    openkrill.secrets.generators.keeper = {
      packages = with pkgs; [ openssl ];
      script = ''
        create_secret ${sourceSecretName} \
          --from-literal=BETTER_AUTH_SECRET="$(openssl rand -base64 32)" \
          --from-literal=ENCRYPTION_KEY="$(openssl rand -base64 32)"
      '';
    };

    # ── Route (forward auth via Authelia) ─────────────────────────
    # Authelia sets Remote-User / Remote-Email headers which the
    # custom API image uses for automatic session creation.
    openkrill.ingress.routes.keeper = {
      subdomain = cfg.subdomain;
      namespace = cfg.namespace;
      service   = "keeper";
      port      = 3000;
    };

    # ── ArgoCD Application CR ─────────────────────────────────────
    openkrill.apps.argo-cd.applications.keeper = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project   = "default";
      source = {
        repoURL        = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path           = ".";
        directory.include = "keeper.yaml";
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
    openkrill.manifests.keeper.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name      = "keeper";
        chart     = charts.bjw-s-labs.app-template.versions."4.6.2";
        namespace = cfg.namespace;
        values    = recursiveUpdate defaults (removeNulls cfg.values);
        extraOpts = [ "--skip-schema-validation" ];
      };
  };
}
