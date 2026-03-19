# apps/filestash — Filestash web file manager
#
# Filestash is a self-hosted web client for managing files across
# storage backends (SFTP, S3, FTP, SMB, WebDAV, etc.).  The custom
# image (built from images/filestash/) adds reverse-proxy auth:
# when Authelia sets Remote-User / Remote-Email / Remote-Groups
# headers, Filestash creates the session directly from headers +
# attribute mapping — no login form is ever rendered.
#
# A local filesystem backend is pre-configured out of the box.
# Each authenticated user gets their own directory under /data/<user>.
# The attribute mapping resolves the proxy auth Remote-User header
# to the local backend path.  Additional backends can be added
# via the admin UI at https://<subdomain>.<domain>/admin
# (password = LLDAP admin password).
#
# TLS: The custom image uses plg_starter_httpsfs which reads a signed
# cert + key from /app/data/state/certs/.  A cert-manager Certificate
# is provisioned in the filestash namespace and mounted into the pod.
#
# Bootstrap workflow:
#   1. openkrill-generate-filestash systemd oneshot (after lldap)
#      creates openkrill-filestash secret with admin password
#      (bcrypt hash of the LLDAP admin password) and config secrets.
#   2. ESO syncs the secret into the filestash namespace.
#   3. Init container writes config.json on first boot if absent,
#      pre-seeding proxy auth + local backend + attribute mapping.
#   4. Filestash reads ADMIN_PASSWORD + CONFIG_SECRET from env,
#      encrypts middleware params on first save.
{ config, lib, pkgs, charts, kubelib, k8s, ... }:
with lib;
let
  cfg     = config.openkrill.apps.filestash;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  appTemplate = import ../../../modules/lib/app-template.nix { inherit lib; };
  domain  = config.openkrill.domain;

  secretName = "filestash";
  tlsSecretName = "filestash-server-tls";

  removeNulls = attrs:
    filterAttrs (_: v: v != null) (mapAttrs (_: v:
      if isAttrs v then removeNulls v else v
    ) attrs);

  # Shell script for the init container: writes config.json if absent.
  # Pre-seeds proxy auth (identity_provider type "proxy"), a local
  # filesystem backend connection, and attribute mapping that resolves
  # the Remote-User header to /data/<user>.
  configSeedScript = ''
    CONFIG=/app/data/state/config/config.json
    if [ -f "$CONFIG" ]; then
      echo "config.json exists, skipping seed"
      exit 0
    fi
    mkdir -p /app/data/state/config
    cat > "$CONFIG" <<'SEED'
    {
      "general": {},
      "middleware": {
        "identity_provider": {
          "type": "proxy",
          "params": "{}"
        },
        "attribute_mapping": {
          "related_backend": "local",
          "params": "{\"local\":{\"type\":\"local\",\"path\":\"/data/{{.user}}\"}}"
        }
      },
      "connections": [
        {
          "type": "local",
          "path": "/data/"
        }
      ]
    }
    SEED
    echo "seeded config.json with local backend"
  '';

  defaults = {
    global.nameOverride = "filestash";

    controllers.main = {
      strategy = "Recreate";

      initContainers.config-seed = {
        image = {
          repository = "busybox";
          tag = "stable";
        };
        command = [ "sh" "-c" configSeedScript ];
        securityContext.runAsUser = 1000;
      };

      containers.main = {
        image = {
          repository = cfg.image.repository;
          tag = cfg.image.tag;
          pullPolicy = "Always";
        };

        env = {
          APPLICATION_URL = "https://${cfg.subdomain}.${domain}";
        };

        envFrom = [
          { secretRef.name = secretName; }
        ];

        probes = {
          liveness = {
            enabled = true;
            custom = true;
            spec = {
              httpGet = { path = "/healthz"; port = 8334; scheme = "HTTPS"; };
              initialDelaySeconds = 15;
              periodSeconds = 15;
              failureThreshold = 3;
            };
          };
          readiness = {
            enabled = true;
            custom = true;
            spec = {
              httpGet = { path = "/healthz"; port = 8334; scheme = "HTTPS"; };
              initialDelaySeconds = 10;
              periodSeconds = 10;
            };
          };
          startup = {
            enabled = true;
            custom = true;
            spec = {
              httpGet = { path = "/healthz"; port = 8334; scheme = "HTTPS"; };
              initialDelaySeconds = 5;
              periodSeconds = 5;
              failureThreshold = 20;
            };
          };
        };

        resources = {
          requests = { cpu = "50m"; memory = "128Mi"; };
          limits   = { memory = "512Mi"; };
        };
      };
    };

    persistence.data = {
      type = "persistentVolumeClaim";
      storageClass = "local-path";
      accessMode = "ReadWriteOnce";
      size = "5Gi";
      advancedMounts.main = {
        config-seed = [{ path = "/app/data/state"; }];
        main        = [{ path = "/app/data/state"; }];
      };
    };

    persistence.files = {
      type = "persistentVolumeClaim";
      storageClass = "local-path";
      accessMode = "ReadWriteOnce";
      size = cfg.filesSize;
      advancedMounts.main = {
        main = [{ path = "/data"; }];
      };
    };

    # Mount cert-manager TLS secret as cert.pem / key.pem for
    # plg_starter_httpsfs.  The secret keys (tls.crt, tls.key) are
    # remapped to the filenames Filestash expects.
    persistence.tls = {
      type = "secret";
      name = tlsSecretName;
      items = [
        { key = "tls.crt"; path = "cert.pem"; }
        { key = "tls.key"; path = "key.pem"; }
      ];
      advancedMounts.main = {
        main = [{ path = "/app/data/state/certs"; readOnly = true; }];
      };
    };

    service.main = {
      controller = "main";
      ports.https = {
        port = 8334;
        appProtocol = "https";
      };
    };
  };
in
{
  options.openkrill.apps.filestash = {
    enable = mkEnableOption "Filestash web file manager";

    namespace = mkOption {
      type = types.str;
      default = "filestash";
      description = "Kubernetes namespace for Filestash.";
    };

    subdomain = mkOption {
      type = types.str;
      default = "files";
      description = "Subdomain for the Filestash web UI (e.g. files.<domain>).";
    };

    image = {
      repository = mkOption {
        type = types.str;
        default = "ghcr.io/general-intelligence-systems/filestash";
        description = "Filestash container image repository (custom build with proxy auth from images/filestash/).";
      };
      tag = mkOption {
        type = types.str;
        default = "latest";
        description = "Filestash container image tag.";
      };
    };

    storageSize = mkOption {
      type = types.str;
      default = "5Gi";
      description = "Size of the PersistentVolumeClaim for Filestash state.";
    };

    filesSize = mkOption {
      type = types.str;
      default = "50Gi";
      description = "Size of the PersistentVolumeClaim for user file storage (/data).";
    };

    values = mkOption {
      type = appTemplate.valuesType;
      default = {};
      description = "app-template Helm chart values (typed), deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Secret generator (after lldap) ────────────────────────────
    openkrill.secrets.generators.filestash = {
      packages = with pkgs; [ openssl apacheHttpd ];
      after = [ "lldap" ];
      script = ''
        # Read LLDAP admin password for the Filestash admin panel.
        LLDAP_PASS=""
        if kubectl -n "$NS" get secret openkrill-lldap >/dev/null 2>&1; then
          LLDAP_PASS=$(kubectl -n "$NS" get secret openkrill-lldap \
            -o jsonpath='{.data.LLDAP_LDAP_USER_PASS}' | base64 -d)
        fi

        # Bcrypt hash for Filestash's ADMIN_PASSWORD env var.
        ADMIN_HASH=""
        if [ -n "$LLDAP_PASS" ]; then
          ADMIN_HASH=$(htpasswd -nbBC 10 "" "$LLDAP_PASS" | cut -d: -f2)
        else
          ADMIN_HASH=$(htpasswd -nbBC 10 "" "$(openssl rand -hex 16)" | cut -d: -f2)
        fi

        create_secret openkrill-filestash \
          --from-literal=ADMIN_PASSWORD="$ADMIN_HASH" \
          --from-literal=CONFIG_SECRET="$(openssl rand -hex 16)"
      '';
    };

    # ── ESO: sync secrets into filestash namespace ────────────────
    openkrill.apps.external-secrets.secrets.${secretName} = {
      namespace = cfg.namespace;
      remoteSecretName = "openkrill-filestash";
      keys = [
        "ADMIN_PASSWORD"
        "CONFIG_SECRET"
      ];
    };

    # ── Route (default forward auth via Authelia) ─────────────────
    openkrill.ingress.routes.filestash = {
      subdomain = cfg.subdomain;
      namespace = cfg.namespace;
      service   = "filestash";
      port      = 8334;
    };

    # ── BackendTLSPolicy for filestash server ────────────────────
    # Traefik connects to filestash on port 8334 (HTTPS).  Without
    # this policy Traefik uses the pod IP for TLS verification, which
    # fails because the cert has DNS SANs but no IP SANs.  The policy
    # tells Traefik to use the service FQDN as the SNI hostname and to
    # trust the system CAs (the openkrill trust bundle is already
    # mounted at /etc/ssl/certs in the Traefik pod).
    openkrill.apps."gateway-api".backendtlspolicies.filestash = {
      namespace = cfg.namespace;
      targetRefs = [{
        group = "";
        kind = "Service";
        name = "filestash";
      }];
      validation = {
        hostname = "filestash.${cfg.namespace}.svc";
        wellKnownCACertificates = "System";
      };
    };

    # ── ArgoCD Application CR ─────────────────────────────────────
    openkrill.apps.argo-cd.applications.filestash = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project   = "default";
      source = {
        repoURL          = config.openkrill.gitops.repoURL;
        targetRevision   = "rendered-manifests";
        path             = ".";
        directory.include = "filestash.yaml";
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
    openkrill.manifests.filestash.content =
      let
        effectiveDefaults = recursiveUpdate defaults {
          persistence.data.size = cfg.storageSize;
        };
      in
      [ (k8s.mkNamespace cfg.namespace) ]
      # Certificate: internal TLS cert for plg_starter_httpsfs,
      # signed by the cluster CA (openkrill-signing-authority).
      ++ [{
        apiVersion = "cert-manager.io/v1";
        kind = "Certificate";
        metadata = {
          name = tlsSecretName;
          namespace = cfg.namespace;
        };
        spec = {
          secretName = tlsSecretName;
          dnsNames = [
            "filestash"
            "filestash.${cfg.namespace}"
            "filestash.${cfg.namespace}.svc"
            "filestash.${cfg.namespace}.svc.cluster.local"
          ];
          issuerRef = {
            name = "openkrill-signing-authority";
            kind = "ClusterIssuer";
          };
        };
      }]
      ++ kubelib.fromHelm {
        name      = "filestash";
        chart     = charts.bjw-s-labs.app-template.latest;
        namespace = cfg.namespace;
        values    = recursiveUpdate effectiveDefaults (removeNulls cfg.values);
        extraOpts = [ "--skip-schema-validation" ];
      };
  };
}
