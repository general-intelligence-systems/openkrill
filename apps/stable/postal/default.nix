# apps/stable/postal — Postal mail delivery platform
#
# Self-hosted mail server for transactional and outbound email.
# Uses the official ghcr.io/postalserver/postal container image
# running three processes (web-server, smtp-server, worker) with
# MariaDB for storage.
#
# Deployment uses the bjw-s app-template Helm chart (Pattern 6)
# since Postal has no official Helm chart.  The module deploys
# four controllers:
#   - web:     Postal web interface + API + tracking (port 5000)
#   - smtp:    Postal SMTP server (port 25)
#   - worker:  Postal background worker
#   - mariadb: MariaDB 10.11 for mail storage
#
# Postal requires MariaDB (not PostgreSQL), so we deploy a dedicated
# MariaDB instance as a sidecar controller rather than using CNPG.
#
# Configuration: Postal supports full environment variable config
# (POSTAL_*, MAIN_DB_*, DNS_*, OIDC_*, etc.).  All settings are
# injected via env vars — no postal.yml ConfigMap is needed.  The
# only file mount is the RSA signing key at /config/signing.key.
#
# Authentication: Postal supports native OIDC.  The module registers
# an Authelia OIDC client and configures Postal's built-in OIDC
# settings via OIDC_* environment variables.
#
# Admin credentials: reuses the shared LLDAP admin password so
# platform admin credentials stay aligned across apps.  The
# bootstrap Job creates admin@<domain> with the LLDAP password.
#
# Bootstrap workflow:
#   1. openkrill-generate-lldap creates the LLDAP admin password.
#   2. openkrill-generate-postal (after: lldap) reads the LLDAP
#      password and creates openkrill-postal in secret-store with
#      SIGNING_KEY, RAILS_SECRET_KEY, DB credentials, and the
#      shared admin email + password.
#   3. ESO syncs secrets into the postal namespace.
#   4. The web controller's init container runs `postal initialize`
#      to create and migrate the MariaDB schema (idempotent).
#   5. The smtp and worker controllers use MIGRATION_WAITER to
#      block until the schema is ready.
#   6. A one-shot Job creates the initial admin user via
#      `rails runner` using the shared LLDAP credentials.
#   7. Navigate to https://postal.<domain>
{ config, lib, pkgs, charts, kubelib, k8s, ... }:
with lib;
let
  cfg      = config.openkrill.apps.postal;
  lldapCfg = config.openkrill.apps.lldap;
  helpers     = import ../../../modules/lib/helpers.nix { inherit lib; };
  appTemplate = import ../../../modules/lib/app-template.nix { inherit lib; };
  domain   = config.openkrill.domain;

  # Source secret created by the systemd generator.
  sourceSecretName = "openkrill-postal";

  # In-namespace secret names (synced by ESO).
  dbSecretName      = "postal-db";
  appSecretName     = "postal-secrets";
  signingKeySecret  = "postal-signing-key";

  # Authelia OIDC endpoints
  autheliaBase = "https://auth.${domain}";

  # Deterministic client secret (same pattern as other Authelia clients)
  clientId          = "postal";
  clientSecretPlain = "${clientId}-oidc-client-secret-${domain}";

  # Common env vars shared by all Postal containers (web, smtp, worker).
  postalEnv = {
    # ── Core ──────────────────────────────────────────────────
    POSTAL_WEB_HOSTNAME  = cfg.domain;
    POSTAL_WEB_PROTOCOL  = "https";
    POSTAL_SMTP_HOSTNAME = cfg.smtpHostname;
    POSTAL_SIGNING_KEY_PATH = "/config/signing.key";

    # ── Main DB ───────────────────────────────────────────────
    MAIN_DB_HOST     = "postal-mariadb";
    MAIN_DB_PORT     = "3306";
    MAIN_DB_USERNAME = "postal";
    MAIN_DB_DATABASE = "postal";

    # ── Message DB (needs root to create per-server databases) ─
    MESSAGE_DB_HOST     = "postal-mariadb";
    MESSAGE_DB_PORT     = "3306";
    MESSAGE_DB_USERNAME = "root";

    # ── Web server ────────────────────────────────────────────
    WEB_SERVER_DEFAULT_BIND_ADDRESS = "0.0.0.0";
    WEB_SERVER_DEFAULT_PORT         = "5000";

    # ── SMTP server ───────────────────────────────────────────
    SMTP_SERVER_DEFAULT_BIND_ADDRESS = "::";
    SMTP_SERVER_DEFAULT_PORT         = "25";

    # ── Health servers (bind to all interfaces for K8s probes) ─
    WORKER_DEFAULT_HEALTH_SERVER_BIND_ADDRESS      = "0.0.0.0";
    SMTP_SERVER_DEFAULT_HEALTH_SERVER_BIND_ADDRESS  = "0.0.0.0";

    # ── DNS ───────────────────────────────────────────────────
    DNS_MX_RECORDS         = builtins.toJSON cfg.dns.mxRecords;
    DNS_SPF_INCLUDE        = cfg.dns.spfInclude;
    DNS_RETURN_PATH_DOMAIN = cfg.dns.returnPathDomain;
    DNS_ROUTE_DOMAIN       = cfg.dns.routeDomain;
    DNS_TRACK_DOMAIN       = cfg.dns.trackDomain;

    # ── Wait for MariaDB ──────────────────────────────────────
    WAIT_FOR_TARGETS = "postal-mariadb:3306";
  }
  // optionalAttrs cfg.oidc.enable {
    # ── OIDC ──────────────────────────────────────────────────
    OIDC_ENABLED                    = "true";
    OIDC_LOCAL_AUTHENTICATION_ENABLED = "true";
    OIDC_NAME                       = "SSO";
    OIDC_ISSUER                     = autheliaBase;
    OIDC_IDENTIFIER                 = clientId;
    OIDC_SECRET                     = clientSecretPlain;
    OIDC_SCOPES                     = builtins.toJSON [ "openid" "email" "profile" ];
    OIDC_UID_FIELD                  = "sub";
    OIDC_EMAIL_ADDRESS_FIELD        = "email";
    OIDC_NAME_FIELD                 = "name";
    OIDC_DISCOVERY                  = "true";
  };

  # Common envFrom for all Postal containers.
  postalEnvFrom = [
    { secretRef.name = appSecretName; }
    { secretRef.name = dbSecretName; }
  ];

  # Strip nulls before merging (same pattern as lobehub/vibekanban).
  removeNulls = attrs:
    filterAttrs (_: v: v != null) (mapAttrs (_: v:
      if isAttrs v then removeNulls v else v
    ) attrs);

  defaults = {
    global.nameOverride = "postal";

    controllers = {
      # ── MariaDB ───────────────────────────────────────────────
      mariadb = {
        containers.main = {
          image = {
            repository = "mariadb";
            tag = cfg.mariadb.image.tag;
          };
          env = {
            MARIADB_DATABASE = "postal";
            MARIADB_USER     = "postal";
          };
          envFrom = [
            { secretRef.name = dbSecretName; }
          ];
          probes = {
            liveness = {
              enabled = true;
              custom  = true;
              spec = {
                exec.command = [ "healthcheck.sh" "--connect" "--innodb_initialized" ];
                initialDelaySeconds = 30;
                periodSeconds       = 10;
                failureThreshold    = 5;
              };
            };
            readiness = {
              enabled = true;
              custom  = true;
              spec = {
                exec.command = [ "healthcheck.sh" "--connect" "--innodb_initialized" ];
                initialDelaySeconds = 10;
                periodSeconds       = 5;
              };
            };
            startup = {
              enabled = true;
              custom  = true;
              spec = {
                exec.command = [ "healthcheck.sh" "--connect" "--innodb_initialized" ];
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

      # ── Web server ────────────────────────────────────────────
      web = {
        # Run `postal initialize` before the web server starts.
        # This creates/migrates the DB schema and is idempotent.
        initContainers.db-init = {
          image = {
            repository = "ghcr.io/postalserver/postal";
            tag = cfg.image.tag;
          };
          command = [ "postal" "initialize" ];
          env     = postalEnv;
          envFrom = postalEnvFrom;
        };

        containers.main = {
          image = {
            repository = "ghcr.io/postalserver/postal";
            tag = cfg.image.tag;
          };
          command = [ "postal" "web-server" ];
          env     = postalEnv;
          envFrom = postalEnvFrom;
          probes = {
            liveness = {
              enabled = true;
              custom  = true;
              spec = {
                httpGet = { path = "/"; port = 5000; };
                initialDelaySeconds = 30;
                periodSeconds       = 15;
                failureThreshold    = 5;
              };
            };
            readiness = {
              enabled = true;
              custom  = true;
              spec = {
                httpGet = { path = "/"; port = 5000; };
                initialDelaySeconds = 15;
                periodSeconds       = 10;
              };
            };
            startup = {
              enabled = true;
              custom  = true;
              spec = {
                httpGet = { path = "/"; port = 5000; };
                initialDelaySeconds = 15;
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

      # ── SMTP server ──────────────────────────────────────────
      smtp = {
        containers.main = {
          image = {
            repository = "ghcr.io/postalserver/postal";
            tag = cfg.image.tag;
          };
          command = [ "postal" "smtp-server" ];
          env     = postalEnv // {
            # Wait for the web init container to finish DB migration.
            MIGRATION_WAITER_ENABLED = "true";
          };
          envFrom = postalEnvFrom;
          securityContext = {
            capabilities.add = [ "NET_BIND_SERVICE" ];
          };
          probes = {
            liveness = {
              enabled = true;
              custom  = true;
              spec = {
                httpGet = { path = "/health"; port = 9091; };
                initialDelaySeconds = 30;
                periodSeconds       = 15;
                failureThreshold    = 5;
              };
            };
            readiness = {
              enabled = true;
              custom  = true;
              spec = {
                httpGet = { path = "/health"; port = 9091; };
                initialDelaySeconds = 15;
                periodSeconds       = 10;
              };
            };
            startup = {
              enabled = true;
              custom  = true;
              spec = {
                httpGet = { path = "/health"; port = 9091; };
                initialDelaySeconds = 10;
                periodSeconds       = 5;
                failureThreshold    = 30;
              };
            };
          };
          resources = {
            requests = { cpu = "100m"; memory = "256Mi"; };
            limits   = { memory = "512Mi"; };
          };
        };
      };

      # ── Worker ────────────────────────────────────────────────
      worker = {
        containers.main = {
          image = {
            repository = "ghcr.io/postalserver/postal";
            tag = cfg.image.tag;
          };
          command = [ "postal" "worker" ];
          env     = postalEnv // {
            # Wait for the web init container to finish DB migration.
            MIGRATION_WAITER_ENABLED = "true";
          };
          envFrom = postalEnvFrom;
          probes = {
            liveness = {
              enabled = true;
              custom  = true;
              spec = {
                httpGet = { path = "/health"; port = 9090; };
                initialDelaySeconds = 30;
                periodSeconds       = 15;
                failureThreshold    = 5;
              };
            };
            readiness = {
              enabled = true;
              custom  = true;
              spec = {
                httpGet = { path = "/health"; port = 9090; };
                initialDelaySeconds = 15;
                periodSeconds       = 10;
              };
            };
            startup = {
              enabled = true;
              custom  = true;
              spec = {
                httpGet = { path = "/health"; port = 9090; };
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
    };

    # ── Services ────────────────────────────────────────────────
    service = {
      mariadb = {
        controller = "mariadb";
        ports.mysql = {
          port     = 3306;
          protocol = "TCP";
        };
      };
      web = {
        controller = "web";
        ports.http = {
          port     = 5000;
          protocol = "HTTP";
        };
      };
      smtp = {
        controller = "smtp";
        ports = {
          smtp = {
            port     = 25;
            protocol = "TCP";
          };
          health = {
            port     = 9091;
            protocol = "HTTP";
          };
        };
      };
      worker = {
        controller = "worker";
        ports.health = {
          port     = 9090;
          protocol = "HTTP";
        };
      };
    };

    # ── Persistence ─────────────────────────────────────────────
    persistence = {
      # MariaDB data volume
      mariadb-data = {
        type        = "persistentVolumeClaim";
        accessMode  = "ReadWriteOnce";
        size        = cfg.mariadb.storageSize;
        advancedMounts.mariadb.main = [
          { path = "/var/lib/mysql"; }
        ];
      };

      # Signing key — mounted from secret into all Postal containers
      # (including the web init container that runs `postal initialize`)
      signing-key = {
        type = "secret";
        name = signingKeySecret;
        advancedMounts = {
          web.db-init = [{ path = "/config/signing.key"; subPath = "signing.key"; readOnly = true; }];
          web.main    = [{ path = "/config/signing.key"; subPath = "signing.key"; readOnly = true; }];
          smtp.main   = [{ path = "/config/signing.key"; subPath = "signing.key"; readOnly = true; }];
          worker.main = [{ path = "/config/signing.key"; subPath = "signing.key"; readOnly = true; }];
        };
      };

      # Cluster CA bundle for internal TLS (needed for OIDC discovery)
      ca-bundle = {
        type = "configMap";
        name = "openkrill-ca-bundle";
        advancedMounts = {
          web.main    = [{ path = "/etc/ssl/certs/openkrill-ca-bundle.pem"; subPath = "bundle.pem"; readOnly = true; }];
          smtp.main   = [{ path = "/etc/ssl/certs/openkrill-ca-bundle.pem"; subPath = "bundle.pem"; readOnly = true; }];
          worker.main = [{ path = "/etc/ssl/certs/openkrill-ca-bundle.pem"; subPath = "bundle.pem"; readOnly = true; }];
        };
      };
    };
  };
in
{
  options.openkrill.apps.postal = {
    enable = mkEnableOption "Postal — open source mail delivery platform";

    namespace = mkOption {
      type    = types.str;
      default = "postal";
    };

    domain = mkOption {
      type        = types.str;
      default     = "postal.${domain}";
      description = "FQDN for the Postal web interface.";
    };

    smtpHostname = mkOption {
      type        = types.str;
      default     = "postal.${domain}";
      description = "Hostname for the Postal SMTP server (used in HELO and config).";
    };

    image.tag = mkOption {
      type        = types.str;
      default     = "3.3.4";
      description = "Postal container image tag.";
    };

    mariadb = {
      image.tag = mkOption {
        type        = types.str;
        default     = "10.11";
        description = "MariaDB container image tag.";
      };
      storageSize = mkOption {
        type        = types.str;
        default     = "20Gi";
        description = "MariaDB PVC size.";
      };
    };

    dns = {
      mxRecords = mkOption {
        type        = types.listOf types.str;
        default     = [ "mx1.postal.${domain}" "mx2.postal.${domain}" ];
        description = "MX record hostnames for Postal DNS configuration.";
      };
      spfInclude = mkOption {
        type        = types.str;
        default     = "spf.postal.${domain}";
        description = "SPF include domain.";
      };
      returnPathDomain = mkOption {
        type        = types.str;
        default     = "rp.postal.${domain}";
        description = "Return path domain for bounce handling.";
      };
      routeDomain = mkOption {
        type        = types.str;
        default     = "routes.postal.${domain}";
        description = "Route domain for incoming email forwarding.";
      };
      trackDomain = mkOption {
        type        = types.str;
        default     = "track.postal.${domain}";
        description = "Click/open tracking domain.";
      };
    };

    oidc = {
      enable = mkOption {
        type        = types.bool;
        default     = true;
        description = "Enable Authelia OIDC integration for Postal.";
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
    # ── ExternalSecret: MariaDB credentials ─────────────────────
    # Syncs DB root + user passwords from the source secret.
    # MariaDB container reads MARIADB_ROOT_PASSWORD and MARIADB_PASSWORD
    # from this secret.  Postal containers read MAIN_DB_PASSWORD and
    # MESSAGE_DB_PASSWORD from the app secret below.
    openkrill.apps.external-secrets.secrets.${dbSecretName} = {
      namespace        = cfg.namespace;
      remoteSecretName = sourceSecretName;
      keys = [
        "MARIADB_ROOT_PASSWORD"
        "MARIADB_PASSWORD"
      ];
    };

    # ── ExternalSecret: Postal app secrets ──────────────────────
    # Contains RAILS_SECRET_KEY, MAIN_DB_PASSWORD, and
    # MESSAGE_DB_PASSWORD for Postal containers.
    openkrill.apps.external-secrets.externalsecrets.${appSecretName} = {
      namespace = cfg.namespace;
      secretStoreRef = {
        name = config.openkrill.apps.external-secrets.clusterSecretStoreName;
        kind = "ClusterSecretStore";
      };
      refreshInterval = "1h";
      target = {
        name           = appSecretName;
        creationPolicy = "Owner";
        template.data = {
          RAILS_SECRET_KEY    = "{{ .rails_secret }}";
          MAIN_DB_PASSWORD    = "{{ .db_password }}";
          MESSAGE_DB_PASSWORD = "{{ .db_root_password }}";
          ADMIN_EMAIL         = "{{ .admin_email }}";
          ADMIN_PASSWORD      = "{{ .admin_password }}";
        };
      };
      data = [
        {
          secretKey = "rails_secret";
          remoteRef = {
            key      = sourceSecretName;
            property = "RAILS_SECRET_KEY";
          };
        }
        {
          secretKey = "db_password";
          remoteRef = {
            key      = sourceSecretName;
            property = "MARIADB_PASSWORD";
          };
        }
        {
          secretKey = "db_root_password";
          remoteRef = {
            key      = sourceSecretName;
            property = "MARIADB_ROOT_PASSWORD";
          };
        }
        {
          secretKey = "admin_email";
          remoteRef = {
            key      = sourceSecretName;
            property = "ADMIN_EMAIL";
          };
        }
        {
          secretKey = "admin_password";
          remoteRef = {
            key      = sourceSecretName;
            property = "ADMIN_PASSWORD";
          };
        }
      ];
    };

    # ── ExternalSecret: Signing key ─────────────────────────────
    # Syncs the RSA signing key into a separate secret for volume mount.
    openkrill.apps.external-secrets.secrets.${signingKeySecret} = {
      namespace        = cfg.namespace;
      remoteSecretName = sourceSecretName;
      keys = [
        "signing.key"
      ];
    };

    # ── Secret generator ────────────────────────────────────────
    # Generates MariaDB passwords, Rails secret key, and RSA signing
    # key on first boot.  Reuses the LLDAP admin password so
    # platform admin credentials stay aligned across apps.
    openkrill.secrets.generators.postal = {
      packages = with pkgs; [ openssl ];
      after = [ "lldap" ];
      script = ''
        LLDAP_PASS=""
        if kubectl -n "$NS" get secret openkrill-lldap >/dev/null 2>&1; then
          LLDAP_PASS=$(kubectl -n "$NS" get secret openkrill-lldap \
            -o jsonpath='{.data.LLDAP_LDAP_USER_PASS}' | base64 -d)
        fi

        MARIADB_ROOT_PASS="$(openssl rand -base64 32)"
        MARIADB_USER_PASS="$(openssl rand -base64 32)"
        RAILS_SECRET="$(openssl rand -hex 64)"
        SIGNING_KEY="$(openssl genrsa 2048 2>/dev/null)"

        create_secret ${sourceSecretName} \
          --from-literal=MARIADB_ROOT_PASSWORD="$MARIADB_ROOT_PASS" \
          --from-literal=MARIADB_PASSWORD="$MARIADB_USER_PASS" \
          --from-literal=RAILS_SECRET_KEY="$RAILS_SECRET" \
          --from-literal=ADMIN_EMAIL="${lldapCfg.adminUser}@${domain}" \
          --from-literal=ADMIN_PASSWORD="''${LLDAP_PASS:-$(openssl rand -hex 16)}" \
          --from-literal=signing.key="$SIGNING_KEY"
      '';
    };

    # ── OIDC: register Postal as an Authelia client ──────────────
    openkrill.apps.authelia.oidcClients = mkIf cfg.oidc.enable [
      {
        name = "Postal";
        redirect_uris = [
          "https://${cfg.domain}/auth/oidc/callback"
        ];
        scopes = [ "openid" "profile" "email" ];
      }
    ];

    # ── Route ────────────────────────────────────────────────────
    # Postal handles its own authentication — no ForwardAuth needed.
    openkrill.ingress.routes.postal = {
      subdomain = "postal";
      namespace = cfg.namespace;
      service   = "postal-web";
      port      = 5000;
      auth      = "none";
    };

    # ── ArgoCD Application CR ────────────────────────────────────
    openkrill.apps.argo-cd.applications.postal = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project   = "default";
      source = {
        repoURL        = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path           = ".";
        directory.include = "postal.yaml";
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

    # ── Bootstrap Job: create initial admin user ─────────────────
    # Runs once after `postal initialize` has set up the schema.
    # Uses `rails runner` to create an admin user non-interactively
    # with the shared LLDAP admin credentials (admin@<domain> +
    # LLDAP admin password).
    # The Job is idempotent: if the user already exists it exits
    # cleanly (find_or_create pattern).
    openkrill.manifests."postal/bootstrap-job".content = {
      apiVersion = "batch/v1";
      kind       = "Job";
      metadata = {
        name      = "postal-bootstrap-admin";
        namespace = cfg.namespace;
        labels = {
          "app.kubernetes.io/name"       = "postal";
          "app.kubernetes.io/component"  = "bootstrap";
          "app.kubernetes.io/managed-by" = "openkrill";
        };
      };
      spec = {
        backoffLimit = 6;
        ttlSecondsAfterFinished = 3600;
        template = {
          metadata.labels = {
            "app.kubernetes.io/name"      = "postal";
            "app.kubernetes.io/component" = "bootstrap";
          };
          spec = {
            restartPolicy = "OnFailure";
            containers = [
              {
                name  = "bootstrap";
                image = "ghcr.io/postalserver/postal:${cfg.image.tag}";
                command = [ "bundle" "exec" "rails" "runner" ];
                args = [
                  (builtins.concatStringsSep "\n" [
                    "email = ENV['ADMIN_EMAIL']"
                    "password = ENV['ADMIN_PASSWORD']"
                    ""
                    "user = User.find_by(email_address: email)"
                    "if user"
                    "  puts \"Admin user #{email} already exists, skipping.\""
                    "else"
                    "  user = User.new("
                    "    email_address: email,"
                    "    first_name: 'Platform',"
                    "    last_name: 'Admin',"
                    "    password: password,"
                    "    admin: true,"
                    "    email_verified_at: Time.now"
                    "  )"
                    "  if user.save"
                    "    puts \"Created admin user #{email}\""
                    "  else"
                    "    STDERR.puts \"Failed to create admin user: #{user.errors.full_messages.join(', ')}\""
                    "    exit 1"
                    "  end"
                    "end"
                  ])
                ];
                env = (mapAttrsToList (name: value: { inherit name value; }) (postalEnv // {
                  WAIT_FOR_TARGETS         = "postal-web:5000";
                  MIGRATION_WAITER_ENABLED = "true";
                }));
                envFrom = [
                  { secretRef.name = appSecretName; }
                  { secretRef.name = dbSecretName; }
                ];
                volumeMounts = [
                  {
                    name      = "signing-key";
                    mountPath = "/config/signing.key";
                    subPath   = "signing.key";
                    readOnly  = true;
                  }
                ];
                resources = {
                  requests = { cpu = "50m"; memory = "128Mi"; };
                  limits   = { memory = "512Mi"; };
                };
              }
            ];
            volumes = [
              {
                name = "signing-key";
                secret.secretName = signingKeySecret;
              }
            ];
          };
        };
      };
    };

    # ── Manifests ────────────────────────────────────────────────
    openkrill.manifests.postal.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name      = "postal";
        chart     = charts.bjw-s-labs.app-template.versions."4.6.2";
        namespace = cfg.namespace;
        values    = recursiveUpdate defaults (removeNulls cfg.values);
        extraOpts = [ "--skip-schema-validation" ];
      };
  };
}
