# apps/stable/lobehub — LobeHub AI chat platform (server database version)
#
# Multi-model AI chat interface with support for OpenAI, Anthropic,
# Google, and other LLM providers.  Uses the official lobehub/lobehub
# Docker image with PostgreSQL (server database mode).
#
# Deployment uses the bjw-s app-template Helm chart (Pattern 6) since
# LobeHub has no official Helm chart.
#
# Database: the shared CloudNativePG cluster provides the "lobehub"
# database.  An ExternalSecret templates CNPG credentials into a
# DATABASE_URL connection string.
#
# Authentication: LobeHub's Better Auth system integrates with Authelia
# via OIDC.  The module registers an Authelia OIDC client and passes
# the SSO environment variables to the container.
#
# Bootstrap workflow:
#   1. openkrill-generate-lobehub systemd oneshot creates
#      openkrill-lobehub in the secret-store namespace with
#      KEY_VAULTS_SECRET, AUTH_SECRET, and OIDC client credentials.
#   2. ESO syncs openkrill-lobehub into the lobehub namespace as
#      "lobehub".
#   3. An ExternalSecret templates CNPG credentials into a
#      DATABASE_URL in the lobehub-db secret.
#   4. The app-template deployment mounts both secrets as env vars.
#   5. Navigate to https://lobehub.<domain>
{ config, lib, pkgs, charts, kubelib, k8s, ... }:
with lib;
let
  cfg      = config.openkrill.apps.lobehub;
  cnpgCfg  = config.openkrill.apps.cloudnative-pg;
  helpers     = import ../../../modules/lib/helpers.nix { inherit lib; };
  appTemplate = import ../../../modules/lib/app-template.nix { inherit lib; };
  domain   = config.openkrill.domain;

  # CNPG shared cluster details
  cnpgAppSecret = "${cnpgCfg.clusterName}-app";
  dbSecretName  = "lobehub-db";
  dbHost        = "${cnpgCfg.clusterName}-rw.${cnpgCfg.namespace}.svc.cluster.local";

  # Source secret created by the systemd generator.
  sourceSecretName = "openkrill-lobehub";

  # In-namespace secret name (synced by ESO).
  targetSecretName = "lobehub";

  # Authelia OIDC endpoints
  autheliaBase = "https://auth.${domain}";

  # Deterministic client secret (same pattern as other Authelia clients)
  clientId          = "lobehub";
  clientSecret      = "$plaintext$${clientId}-oidc-client-secret-${domain}";
  clientSecretPlain = "${clientId}-oidc-client-secret-${domain}";

  # Strip nulls before merging (same pattern as mathesar/skyvern).
  removeNulls = attrs:
    filterAttrs (_: v: v != null) (mapAttrs (_: v:
      if isAttrs v then removeNulls v else v
    ) attrs);

  defaults = {
    global.nameOverride = "lobehub";

    controllers.main = {
      containers.main = {
        image = {
          repository = "lobehub/lobehub";
          tag = cfg.image.tag;
        };
        env = {
          # App URL for redirects and CORS
          APP_URL = "https://${cfg.domain}";

          # LobeHub uses Better Auth for authentication.
          # AUTH_SECRET is provided via the secret mount.
          NEXT_AUTH_SSO_PROVIDERS = "authelia";

          # Authelia OIDC configuration
          AUTH_SSO_PROVIDERS = "authelia";
          AUTH_AUTHELIA_ID = clientId;
          AUTH_AUTHELIA_SECRET = clientSecretPlain;
          AUTH_AUTHELIA_ISSUER = autheliaBase;

          # Tell Node.js to trust the cluster CA bundle.
          NODE_EXTRA_CA_CERTS = "/etc/ssl/certs/openkrill-ca-bundle.pem";
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
                path = "/api/health";
                port = 3210;
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
                path = "/api/health";
                port = 3210;
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
                path = "/api/health";
                port = 3210;
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

    # Mount the cluster CA bundle so LobeHub trusts internal TLS certs
    # (needed for Authelia OIDC discovery).
    persistence.ca-bundle = {
      type = "configMap";
      name = "openkrill-ca-bundle";
      advancedMounts.main.main = [
        {
          path     = "/etc/ssl/certs/openkrill-ca-bundle.pem";
          subPath  = "bundle.pem";
          readOnly = true;
        }
      ];
    };

    service.main = {
      controller = "main";
      ports.http = {
        port     = 3210;
        protocol = "HTTP";
      };
    };
  };
in
{
  options.openkrill.apps.lobehub = {
    enable = mkEnableOption "LobeHub AI chat platform";

    namespace = mkOption {
      type    = types.str;
      default = "lobehub";
    };

    domain = mkOption {
      type        = types.str;
      default     = "lobehub.${domain}";
      description = "FQDN for the LobeHub instance.";
    };

    image.tag = mkOption {
      type        = types.str;
      default     = "latest";
      description = "LobeHub container image tag.";
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
    openkrill.apps.cloudnative-pg.databases.lobehub = {
      namespace    = cnpgCfg.namespace;
      name         = "lobehub";
      owner        = "app";
      cluster.name = cnpgCfg.clusterName;
    };

    # ── ExternalSecret: database credentials ─────────────────────
    # Reads username + password from the CNPG-generated app secret
    # and templates a postgres:// DATABASE_URL for LobeHub.
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
          DATABASE_URL = "postgresql://{{ .username }}:{{ .password }}@${dbHost}:5432/lobehub";
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

    # ── ExternalSecret: LobeHub secrets ──────────────────────────
    # Syncs the source secret into the lobehub namespace.
    openkrill.apps.external-secrets.secrets.${targetSecretName} = {
      namespace        = cfg.namespace;
      remoteSecretName = sourceSecretName;
      keys = [
        "KEY_VAULTS_SECRET"
        "AUTH_SECRET"
      ];
    };

    # ── Secret generator ─────────────────────────────────────────
    # Generates KEY_VAULTS_SECRET and AUTH_SECRET on first boot.
    openkrill.secrets.generators.lobehub = {
      packages = with pkgs; [ openssl ];
      script = ''
        create_secret ${sourceSecretName} \
          --from-literal=KEY_VAULTS_SECRET="$(openssl rand -base64 32)" \
          --from-literal=AUTH_SECRET="$(openssl rand -base64 32)"
      '';
    };

    # ── OIDC: register LobeHub as an Authelia client ─────────────
    openkrill.apps.authelia.oidcClients = [
      {
        name = "LobeHub";
        redirect_uris = [
          "https://${cfg.domain}/api/auth/callback/authelia"
        ];
        scopes = [ "openid" "profile" "email" ];
      }
    ];

    # ── Route ──────────────────────────────────────────────────────
    # LobeHub handles its own SSO via Better Auth — no ForwardAuth.
    openkrill.ingress.routes.lobehub = {
      subdomain = "lobehub";
      namespace = cfg.namespace;
      service   = "lobehub";
      port      = 3210;
      auth      = "none";
    };

    # ── ArgoCD Application CR ────────────────────────────────────
    openkrill.apps.argo-cd.applications.lobehub = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project   = "default";
      source = {
        repoURL        = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path           = ".";
        directory.include = "lobehub.yaml";
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
    openkrill.manifests.lobehub.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name      = "lobehub";
        chart     = charts.bjw-s-labs.app-template.versions."4.6.2";
        namespace = cfg.namespace;
        values    = recursiveUpdate defaults (removeNulls cfg.values);
        extraOpts = [ "--skip-schema-validation" ];
      };
  };
}
