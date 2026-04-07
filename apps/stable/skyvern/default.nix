# apps/stable/skyvern — Skyvern browser automation platform
#
# AI-powered browser automation that uses LLMs to interact with
# websites.  Consists of a Python backend (API + browser automation)
# and a React frontend (UI).
#
# Deployment uses the bjw-s app-template Helm chart with two
# controllers: "backend" and "frontend".  The backend talks to a
# PostgreSQL database in the shared CloudNativePG cluster.
#
# Database: a CNPG Database CRD creates the "skyvern" database inside
# the shared cluster.  An ExternalSecret mirrors credentials into the
# skyvern namespace as a templated DATABASE_STRING.
#
# Bootstrap workflow:
#   1. Source secret (openkrill-skyvern) is auto-created by the
#      openkrill-generate-skyvern systemd oneshot at boot.
#   2. ESO syncs it into the skyvern namespace as "skyvern".
#   3. The backend reads DATABASE_STRING, SKYVERN_API_KEY, and
#      LLM provider keys from the mounted secrets.
#   4. Navigate to https://skyvern.<domain>
{ config, lib, pkgs, charts, kubelib, k8s, ... }:
with lib;
let
  cfg      = config.openkrill.apps.skyvern;
  cnpgCfg  = config.openkrill.apps.cloudnative-pg;
  helpers  = import ../../../modules/lib/helpers.nix { inherit lib; };
  appTemplate = import ../../../modules/lib/app-template.nix { inherit lib; };
  domain   = config.openkrill.domain;

  # CNPG shared cluster details
  cnpgAppSecret = "${cnpgCfg.clusterName}-app";
  dbSecretName  = "skyvern-db";
  dbHost        = "${cnpgCfg.clusterName}-rw.${cnpgCfg.namespace}.svc.cluster.local";

  # Source secret created by the systemd generator.
  sourceSecretName = "openkrill-skyvern";

  # In-namespace secret name (synced by ESO).
  targetSecretName = "skyvern";

  # Strip nulls before merging (same pattern as mathesar).
  removeNulls = attrs:
    filterAttrs (_: v: v != null) (mapAttrs (_: v:
      if isAttrs v then removeNulls v else v
    ) attrs);

  defaults = {
    global.nameOverride = "skyvern";

    # ── Backend controller ──────────────────────────────────────
    controllers.backend = {
      containers.main = {
        image = {
          repository = cfg.backend.image.repository;
          tag = cfg.backend.image.tag;
        };
        env = {
          ENV = "local";
          BROWSER_TYPE = "chromium-headless";
          MAX_SCRAPING_RETRIES = "0";
          VIDEO_PATH = "./videos";
          BROWSER_ACTION_TIMEOUT_MS = "5000";
          MAX_STEPS_PER_RUN = "50";
          LOG_LEVEL = "INFO";
          LITELLM_LOG = "CRITICAL";
          PORT = "8000";
          ENABLE_LOG_ARTIFACTS = "false";
        };
        envFrom = [
          { secretRef.name = targetSecretName; }
          { secretRef.name = dbSecretName; }
        ];
        probes = {
          liveness = {
            enabled = true;
            custom = true;
            spec = {
              httpGet = {
                path = "/api/v1/heartbeat";
                port = 8000;
              };
              initialDelaySeconds = 30;
              periodSeconds = 15;
              failureThreshold = 5;
            };
          };
          readiness = {
            enabled = true;
            custom = true;
            spec = {
              httpGet = {
                path = "/api/v1/heartbeat";
                port = 8000;
              };
              initialDelaySeconds = 15;
              periodSeconds = 10;
            };
          };
          startup = {
            enabled = true;
            custom = true;
            spec = {
              httpGet = {
                path = "/api/v1/heartbeat";
                port = 8000;
              };
              initialDelaySeconds = 10;
              periodSeconds = 5;
              failureThreshold = 30;
            };
          };
        };
        resources = {
          requests = { cpu = "200m"; memory = "512Mi"; };
          limits   = { memory = "2Gi"; };
        };
      };
    };

    # ── Frontend controller ─────────────────────────────────────
    controllers.frontend = {
      containers.main = {
        image = {
          repository = cfg.frontend.image.repository;
          tag = cfg.frontend.image.tag;
        };
        env = {
          VITE_WSS_BASE_URL = "wss://skyvern.${domain}/api/v1";
          VITE_API_BASE_URL = "https://skyvern.${domain}/api/v1";
          VITE_ARTIFACT_API_BASE_URL = "https://skyvern.${domain}/artifacts";
          VITE_ENABLE_LOG_ARTIFACTS = "false";
          VITE_ENABLE_CODE_BLOCK = "true";
        };
        envFrom = [
          { secretRef.name = targetSecretName; }
        ];
        probes = {
          liveness = {
            enabled = true;
            custom = true;
            spec = {
              httpGet = {
                path = "/";
                port = 8080;
              };
              initialDelaySeconds = 10;
              periodSeconds = 15;
            };
          };
          readiness = {
            enabled = true;
            custom = true;
            spec = {
              httpGet = {
                path = "/";
                port = 8080;
              };
              initialDelaySeconds = 5;
              periodSeconds = 10;
            };
          };
        };
        resources = {
          requests = { cpu = "50m"; memory = "64Mi"; };
          limits   = { memory = "256Mi"; };
        };
      };
    };

    # ── Services ────────────────────────────────────────────────
    service.backend = {
      controller = "backend";
      ports = {
        http = {
          port = 8000;
          protocol = "HTTP";
        };
      };
    };

    service.frontend = {
      controller = "frontend";
      ports = {
        http = {
          port = 8080;
          protocol = "HTTP";
        };
        artifact = {
          port = 9090;
          protocol = "HTTP";
        };
      };
    };
  };
in
{
  options.openkrill.apps.skyvern = {
    enable = mkEnableOption "Skyvern browser automation platform";

    namespace = mkOption {
      type = types.str;
      default = "skyvern";
    };

    backend.image = {
      repository = mkOption {
        type = types.str;
        default = "public.ecr.aws/skyvern/skyvern";
        description = "Skyvern backend container image repository.";
      };
      tag = mkOption {
        type = types.str;
        default = "latest";
        description = "Skyvern backend container image tag.";
      };
    };

    frontend.image = {
      repository = mkOption {
        type = types.str;
        default = "public.ecr.aws/skyvern/skyvern-ui";
        description = "Skyvern frontend container image repository.";
      };
      tag = mkOption {
        type = types.str;
        default = "latest";
        description = "Skyvern frontend container image tag.";
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
    # ── CNPG Database (inside the shared cluster) ─────────────────
    openkrill.apps.cloudnative-pg.databases.skyvern = {
      namespace = cnpgCfg.namespace;
      name      = "skyvern";
      owner     = "app";
      cluster.name = cnpgCfg.clusterName;
    };

    # ── ExternalSecret: database credentials ─────────────────────
    # Reads username + password from the CNPG-generated app secret
    # and templates a postgresql+psycopg:// URI with the skyvern
    # database name.
    openkrill.apps.external-secrets.externalsecrets.${dbSecretName} = {
      namespace = cfg.namespace;
      secretStoreRef = {
        name = cnpgCfg.clusterSecretStoreName;
        kind = "ClusterSecretStore";
      };
      refreshInterval = "1h";
      target = {
        name = dbSecretName;
        creationPolicy = "Owner";
        template.data = {
          DATABASE_STRING = "postgresql+psycopg://{{ .username }}:{{ .password }}@${dbHost}:5432/skyvern";
        };
      };
      data = [
        {
          secretKey = "username";
          remoteRef = {
            key = cnpgAppSecret;
            property = "username";
          };
        }
        {
          secretKey = "password";
          remoteRef = {
            key = cnpgAppSecret;
            property = "password";
          };
        }
      ];
    };

    # ── ExternalSecret: Skyvern secrets ──────────────────────────
    # Syncs the source secret into the skyvern namespace.
    openkrill.apps.external-secrets.secrets.${targetSecretName} = {
      namespace = cfg.namespace;
      remoteSecretName = sourceSecretName;
      keys = [
        "SKYVERN_API_KEY"
        "OPENAI_API_KEY"
        "ANTHROPIC_API_KEY"
        "VITE_SKYVERN_API_KEY"
      ];
    };

    # ── Secret generator ─────────────────────────────────────────
    # Generates a random API key on first boot.  LLM provider keys
    # default to empty strings — override them in the source secret
    # after initial deploy, or set them via openkrill.secrets overrides.
    openkrill.secrets.generators.skyvern = {
      packages = with pkgs; [ openssl ];
      script = ''
        API_KEY="sk-$(openssl rand -hex 24)"

        create_secret ${sourceSecretName} \
          --from-literal=SKYVERN_API_KEY="$API_KEY" \
          --from-literal=VITE_SKYVERN_API_KEY="$API_KEY" \
          --from-literal=OPENAI_API_KEY="" \
          --from-literal=ANTHROPIC_API_KEY=""
      '';
    };

    # ── Route (frontend serves /, backend serves /api and /v1) ───
    # A single route with per-path overrides for backend services.
    openkrill.ingress.routes.skyvern = {
      subdomain = "skyvern";
      namespace = cfg.namespace;
      service   = "skyvern-frontend";
      port      = 8080;
      paths = {
        "/api" = {
          service = "skyvern-backend";
          port    = 8000;
        };
        "/v1" = {
          service = "skyvern-backend";
          port    = 8000;
        };
        "/artifacts" = {
          port = 9090;
        };
      };
    };

    # ── ArgoCD Application CR ────────────────────────────────────
    openkrill.apps.argo-cd.applications.skyvern = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project   = "default";
      source = {
        repoURL        = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path           = ".";
        directory.include = "skyvern.yaml";
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

    # ── Manifests ────────────────────────────────────────────────
    openkrill.manifests.skyvern.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name      = "skyvern";
        chart     = charts.bjw-s-labs.app-template.versions."4.6.2";
        namespace = cfg.namespace;
        values    = recursiveUpdate defaults (removeNulls cfg.values);
        extraOpts = [ "--skip-schema-validation" ];
      };
  };
}
