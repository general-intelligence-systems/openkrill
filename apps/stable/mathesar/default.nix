# apps/mathesar — Mathesar database UI for PostgreSQL
#
# Mathesar is a self-hosted web application providing a spreadsheet-like
# interface to PostgreSQL databases.  It uses Django on the backend with
# Gunicorn, and connects to a PostgreSQL database for internal state.
#
# Deployment uses the bjw-s app-template Helm chart (Pattern 6) since
# Mathesar has no official Helm chart.
#
# Database: a CNPG Database CRD creates the "mathesar_django" database
# inside the shared CloudNativePG cluster.  The secret generator reads
# CNPG credentials at boot and writes a SECRET_KEY + DATABASE_URL into
# openkrill-mathesar alongside other required env vars.
#
# Bootstrap workflow:
#   1. openkrill-generate-mathesar systemd oneshot creates
#      openkrill-mathesar in the secret-store namespace with DATABASE_URL
#      and SECRET_KEY.
#   2. ESO syncs openkrill-mathesar into "mathesar" in the mathesar
#      namespace.
#   3. The app-template deployment mounts the "mathesar" secret as env
#      vars for the Mathesar container.
{ config, lib, pkgs, charts, kubelib, k8s, ... }:
with lib;
let
  cfg     = config.openkrill.apps.mathesar;
  cnpgCfg = config.openkrill.apps.cloudnative-pg;
  helpers     = import ../../../modules/lib/helpers.nix { inherit lib; };
  appTemplate = import ../../../modules/lib/app-template.nix { inherit lib; };
  domain  = config.openkrill.domain;

  # Source secret created by the systemd generator.
  sourceSecretName = "openkrill-mathesar";

  # In-namespace secret name (synced by ESO).
  targetSecretName = "mathesar";

  defaults = {
    controllers.main = {
      containers.main = {
        image = {
          repository = "mathesar/mathesar-prod-db";
          tag = "0.9.0";
        };
        env = {
          ALLOWED_HOSTS = "*";
          MATHESAR_DATABASES = "(mathesar_tables|postgresql://${cnpgCfg.clusterName}-rw.${cnpgCfg.namespace}.svc.cluster.local:5432/mathesar_tables)";
          DJANGO_SUPERUSER_PASSWORD = "";
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
                path = "/";
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
                path = "/";
                port = 8000;
              };
              initialDelaySeconds = 10;
              periodSeconds = 5;
              failureThreshold = 30;
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
        port = 8000;
        protocol = "HTTP";
      };
    };
  };
in
{
  options.openkrill.apps.mathesar = {
    enable = mkEnableOption "Mathesar database UI for PostgreSQL";

    namespace = mkOption {
      type = types.str;
      default = "mathesar";
    };

    values = mkOption {
      type = appTemplate.valuesType;
      default = {};
      description = "app-template Helm chart values (typed), deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── CNPG Database (Mathesar's internal Django database) ───────
    openkrill.apps.cloudnative-pg.databases.mathesar-django = {
      namespace = cnpgCfg.namespace;
      name      = "mathesar_django";
      owner     = "app";
      cluster.name = cnpgCfg.clusterName;
    };

    # ── CNPG Database (user-facing database for Mathesar tables) ──
    openkrill.apps.cloudnative-pg.databases.mathesar-tables = {
      namespace = cnpgCfg.namespace;
      name      = "mathesar_tables";
      owner     = "app";
      cluster.name = cnpgCfg.clusterName;
    };

    # ── ExternalSecret: sync openkrill-mathesar → mathesar ns ─────
    openkrill.apps.external-secrets.secrets.mathesar = {
      namespace = cfg.namespace;
      remoteSecretName = sourceSecretName;
      keys = [
        "SECRET_KEY"
        "DATABASE_URL"
      ];
    };

    # ── Secret generator ──────────────────────────────────────────
    # Reads CNPG credentials at boot and writes DATABASE_URL +
    # SECRET_KEY into the source secret.
    openkrill.secrets.generators.mathesar = {
      packages = with pkgs; [ openssl ];
      script = ''
        # Wait for CNPG cluster secret to exist
        echo "Waiting for CNPG app secret..."
        until kubectl -n ${cnpgCfg.namespace} get secret ${cnpgCfg.clusterName}-app >/dev/null 2>&1; do
          sleep 5
        done

        DB_USER=$(kubectl -n ${cnpgCfg.namespace} get secret ${cnpgCfg.clusterName}-app \
          -o jsonpath='{.data.username}' | base64 -d)
        DB_PASS=$(kubectl -n ${cnpgCfg.namespace} get secret ${cnpgCfg.clusterName}-app \
          -o jsonpath='{.data.password}' | base64 -d)
        DATABASE_URL="postgresql://''${DB_USER}:''${DB_PASS}@${cnpgCfg.clusterName}-rw.${cnpgCfg.namespace}.svc.cluster.local:5432/mathesar_django"

        create_secret ${sourceSecretName} \
          --from-literal=SECRET_KEY="$(openssl rand -hex 32)" \
          --from-literal=DATABASE_URL="$DATABASE_URL"
      '';
    };

    # ── Route ─────────────────────────────────────────────────────
    openkrill.ingress.routes.mathesar = {
      subdomain = "mathesar";
      namespace = cfg.namespace;
      service   = "mathesar";
      port      = 8000;
    };

    # ── ArgoCD Application CR ─────────────────────────────────────
    openkrill.apps.argo-cd.applications.mathesar = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project   = "default";
      source = {
        repoURL          = config.openkrill.gitops.repoURL;
        targetRevision   = "rendered-manifests";
        path             = ".";
        directory.include = "mathesar.yaml";
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
    openkrill.manifests.mathesar.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name      = "mathesar";
        chart     = charts.bjw-s-labs.app-template.latest;
        namespace = cfg.namespace;
        values    = recursiveUpdate defaults cfg.values;
      };
  };
}
