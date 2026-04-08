# apps/stable/postgrest — PostgREST automatic REST API
#
# Serves a RESTful API from any PostgreSQL database, automatically
# deriving endpoints from the schema.  Uses the official
# postgrest/postgrest Docker image.
#
# Deployment uses the bjw-s app-template Helm chart (Pattern 6) since
# PostgREST has no official Helm chart.
#
# Database: the shared CloudNativePG cluster provides the "postgrest"
# database.  An ExternalSecret templates CNPG credentials into
# PGRST_DB_URI.
#
# Authentication: PostgREST delegates auth to JWT tokens.  The module
# generates a PGRST_JWT_SECRET and syncs it via ExternalSecrets.
#
# Bootstrap workflow:
#   1. openkrill-generate-postgrest systemd oneshot creates
#      openkrill-postgrest in the secret-store namespace with
#      PGRST_JWT_SECRET.
#   2. ESO syncs openkrill-postgrest into the postgrest namespace as
#      "postgrest".
#   3. An ExternalSecret templates CNPG credentials into a
#      PGRST_DB_URI in the postgrest-db secret.
#   4. The app-template deployment mounts both secrets as env vars.
#   5. Navigate to https://postgrest.<domain>
{ config, lib, pkgs, charts, kubelib, k8s, ... }:
with lib;
let
  cfg      = config.openkrill.apps.postgrest;
  cnpgCfg  = config.openkrill.apps.cloudnative-pg;
  helpers     = import ../../../modules/lib/helpers.nix { inherit lib; };
  appTemplate = import ../../../modules/lib/app-template.nix { inherit lib; };
  domain   = config.openkrill.domain;

  # CNPG shared cluster details
  cnpgAppSecret = "${cnpgCfg.clusterName}-app";
  dbSecretName  = "postgrest-db";
  dbHost        = "${cnpgCfg.clusterName}-rw.${cnpgCfg.namespace}.svc.cluster.local";

  # Source secret created by the systemd generator.
  sourceSecretName = "openkrill-postgrest";

  # In-namespace secret name (synced by ESO).
  targetSecretName = "postgrest";

  # Strip nulls before merging (same pattern as lobehub/mathesar/skyvern).
  removeNulls = attrs:
    filterAttrs (_: v: v != null) (mapAttrs (_: v:
      if isAttrs v then removeNulls v else v
    ) attrs);

  defaults = {
    global.nameOverride = "postgrest";

    controllers.main = {
      containers.main = {
        image = {
          repository = "postgrest/postgrest";
          tag = cfg.image.tag;
        };
        env = {
          # Schema to expose via the REST API.
          PGRST_DB_SCHEMAS = cfg.dbSchemas;

          # The role used for anonymous (unauthenticated) requests.
          PGRST_DB_ANON_ROLE = cfg.dbAnonRole;

          # Listen on all interfaces inside the container.
          PGRST_SERVER_HOST = "0.0.0.0";

          # Port (matches service definition below).
          PGRST_SERVER_PORT = "3000";
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
                path = "/";
                port = 3000;
              };
              initialDelaySeconds = 10;
              periodSeconds       = 15;
              failureThreshold    = 5;
            };
          };
          readiness = {
            enabled = true;
            custom  = true;
            spec = {
              httpGet = {
                path = "/";
                port = 3000;
              };
              initialDelaySeconds = 5;
              periodSeconds       = 10;
            };
          };
          startup = {
            enabled = true;
            custom  = true;
            spec = {
              httpGet = {
                path = "/";
                port = 3000;
              };
              initialDelaySeconds = 5;
              periodSeconds       = 5;
              failureThreshold    = 15;
            };
          };
        };
        resources = {
          requests = { cpu = "50m"; memory = "64Mi"; };
          limits   = { memory = "256Mi"; };
        };
      };
    };

    service.main = {
      controller = "main";
      ports.http = {
        port     = 3000;
        protocol = "HTTP";
      };
    };
  };
in
{
  options.openkrill.apps.postgrest = {
    enable = mkEnableOption "PostgREST automatic REST API";

    namespace = mkOption {
      type    = types.str;
      default = "postgrest";
    };

    domain = mkOption {
      type        = types.str;
      default     = "postgrest.${domain}";
      description = "FQDN for the PostgREST instance.";
    };

    image.tag = mkOption {
      type        = types.str;
      default     = "v12.2.3";
      description = "PostgREST container image tag.";
    };

    dbSchemas = mkOption {
      type        = types.str;
      default     = "public";
      description = "Comma-separated list of database schemas to expose.";
    };

    dbAnonRole = mkOption {
      type        = types.str;
      default     = "anon";
      description = "PostgreSQL role for anonymous (unauthenticated) requests.";
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
    openkrill.apps.cloudnative-pg.databases.postgrest = {
      namespace    = cnpgCfg.namespace;
      name         = "postgrest";
      owner        = "app";
      cluster.name = cnpgCfg.clusterName;
    };

    # ── ExternalSecret: database credentials ─────────────────────
    # Reads username + password from the CNPG-generated app secret
    # and templates a postgres:// PGRST_DB_URI for PostgREST.
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
          PGRST_DB_URI = "postgresql://{{ .username }}:{{ .password }}@${dbHost}:5432/postgrest";
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

    # ── ExternalSecret: PostgREST secrets ────────────────────────
    # Syncs the source secret into the postgrest namespace.
    openkrill.apps.external-secrets.secrets.${targetSecretName} = {
      namespace        = cfg.namespace;
      remoteSecretName = sourceSecretName;
      keys = [
        "PGRST_JWT_SECRET"
      ];
    };

    # ── Secret generator ─────────────────────────────────────────
    # Generates the JWT secret used to verify API tokens.
    openkrill.secrets.generators.postgrest = {
      packages = with pkgs; [ openssl ];
      script = ''
        create_secret ${sourceSecretName} \
          --from-literal=PGRST_JWT_SECRET="$(openssl rand -base64 32)"
      '';
    };

    # ── Route ──────────────────────────────────────────────────────
    openkrill.ingress.routes.postgrest = {
      subdomain = "postgrest";
      namespace = cfg.namespace;
      service   = "postgrest";
      port      = 3000;
    };

    # ── ArgoCD Application CR ────────────────────────────────────
    openkrill.apps.argo-cd.applications.postgrest = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project   = "default";
      source = {
        repoURL        = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path           = ".";
        directory.include = "postgrest.yaml";
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
    openkrill.manifests.postgrest.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name      = "postgrest";
        chart     = charts.bjw-s-labs.app-template.versions."4.6.2";
        namespace = cfg.namespace;
        values    = recursiveUpdate defaults (removeNulls cfg.values);
        extraOpts = [ "--skip-schema-validation" ];
      };
  };
}
