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
# CNPG credentials at boot and writes the POSTGRES_* connection vars
# and SECRET_KEY into openkrill-mathesar.
#
# Bootstrap workflow:
#   1. openkrill-generate-mathesar systemd oneshot creates
#      openkrill-mathesar in the secret-store namespace with POSTGRES_*
#      vars, SECRET_KEY, and MATHESAR_DATABASES.
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

  dbHost = "${cnpgCfg.clusterName}-rw.${cnpgCfg.namespace}.svc.cluster.local";

  # appTemplate.valuesType fills unset options with null defaults.
  # recursiveUpdate treats null as a leaf, so cfg.values.global = null
  # would stomp defaults.global.  Strip nulls before merging.
  removeNulls = attrs:
    filterAttrs (_: v: v != null) (mapAttrs (_: v:
      if isAttrs v then removeNulls v else v
    ) attrs);

  defaults = {
    global.nameOverride = "mathesar";
    controllers.main = {
      containers.main = {
        image = {
          repository = "mathesar/mathesar";
          tag = "0.9.0";
        };
        env = {
          DOMAIN_NAME = "https://mathesar.${domain}";
          ALLOWED_HOSTS = "mathesar.${domain}";
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
                httpHeaders = [{ name = "Host"; value = "mathesar.${domain}"; }];
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
                httpHeaders = [{ name = "Host"; value = "mathesar.${domain}"; }];
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
                httpHeaders = [{ name = "Host"; value = "mathesar.${domain}"; }];
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
        "POSTGRES_DB"
        "POSTGRES_USER"
        "POSTGRES_PASSWORD"
        "POSTGRES_HOST"
        "POSTGRES_PORT"
        "MATHESAR_DATABASES"
        "OIDC_CONFIG_DICT"
      ];
    };

    # ── Secret generator ──────────────────────────────────────────
    # Reads CNPG credentials at boot and writes POSTGRES_* vars,
    # SECRET_KEY, and MATHESAR_DATABASES into the source secret.
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

        # Build OIDC_CONFIG_DICT for Mathesar SSO with Authelia.
        # The client secret is deterministic (matches Authelia's oidcClientModule default).
        OIDC_SECRET="mathesar-oidc-client-secret-$DOMAIN"
        OIDC_CONFIG_DICT=$(cat <<'EOJSON'
        {"version":1,"oidc_providers":{"provider1":{"provider_name":"authelia","server_url":"https://auth.DOMAIN_PLACEHOLDER/.well-known/openid-configuration","client_id":"mathesar","secret":"SECRET_PLACEHOLDER"}}}
        EOJSON
        )
        OIDC_CONFIG_DICT=$(echo "$OIDC_CONFIG_DICT" | sed "s/DOMAIN_PLACEHOLDER/$DOMAIN/g; s/SECRET_PLACEHOLDER/$OIDC_SECRET/g" | tr -d ' \n')

        create_secret ${sourceSecretName} \
          --from-literal=SECRET_KEY="$(openssl rand -hex 32)" \
          --from-literal=POSTGRES_DB="mathesar_django" \
          --from-literal=POSTGRES_USER="''${DB_USER}" \
          --from-literal=POSTGRES_PASSWORD="''${DB_PASS}" \
          --from-literal=POSTGRES_HOST="${dbHost}" \
          --from-literal=POSTGRES_PORT="5432" \
          --from-literal=MATHESAR_DATABASES="(mathesar_tables|postgresql://''${DB_USER}:''${DB_PASS}@${dbHost}:5432/mathesar_tables)" \
          --from-literal=OIDC_CONFIG_DICT="''${OIDC_CONFIG_DICT}"
      '';
    };

    # ── Route ─────────────────────────────────────────────────────
    openkrill.ingress.routes.mathesar = {
      subdomain = "mathesar";
      namespace = cfg.namespace;
      service   = "mathesar";
      port      = 8000;
    };

    # ── Authelia OIDC client ─────────────────────────────────────
    # Registers Mathesar as an OIDC Relying Party in Authelia.
    # Mathesar uses django-allauth's "authelia" provider; the
    # callback path is /auth/oidc/authelia/login/callback/.
    openkrill.apps.authelia.oidcClients = mkIf config.openkrill.apps.authelia.enable [{
      name = "Mathesar";
      redirect_uris = [
        "https://mathesar.${domain}/auth/oidc/authelia/login/callback/"
      ];
    }];

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
        values    = recursiveUpdate defaults (removeNulls cfg.values);
        extraOpts = [ "--skip-schema-validation" ];
      };
  };
}
