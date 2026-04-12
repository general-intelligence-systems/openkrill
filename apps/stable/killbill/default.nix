# apps/killbill — Kill Bill subscription billing platform
#
# Deploys Kill Bill (core API server) and Kaui (admin UI) with PostgreSQL
# storage via the shared CloudNativePG cluster.  Two CNPG databases are
# created: "killbill" for the core engine and "kaui" for the admin UI,
# matching the upstream recommended layout.
#
# Authentication is configured via a shiro.ini file mounted into the
# Kill Bill container.  The admin user is seeded from the shared LLDAP
# admin credentials so the platform admin password stays consistent
# across apps.
#
# Kaui is configured to connect to the Kill Bill API internally at
# http://killbill:8080 and uses the same LLDAP admin user as the
# root (super) user.
{ config, lib, pkgs, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.killbill;
  cnpgCfg = config.openkrill.apps.cloudnative-pg;
  lldapCfg = config.openkrill.apps.lldap;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  domain = config.openkrill.domain;

  cnpgAppSecret = "${cnpgCfg.clusterName}-app";

  # Secret names for database credentials (templated by ExternalSecrets)
  killbillDbSecretName = "killbill-db";
  kauiDbSecretName = "kaui-db";

  # Source secret created by the generator in secret-store namespace
  sourceSecretName = "openkrill-killbill";

  # Target secret synced into the killbill namespace by ESO
  authSecretName = "killbill-auth";

  # PostgreSQL host for JDBC connection strings
  dbHost = "${cnpgCfg.clusterName}-rw.${cnpgCfg.namespace}.svc.cluster.local";

in
{
  options.openkrill.apps.killbill = {
    enable = mkEnableOption "Kill Bill subscription billing platform";

    namespace = mkOption {
      type = types.str;
      default = "killbill";
    };

    killbill = {
      image = {
        repository = mkOption {
          type = types.str;
          default = "killbill/killbill";
          description = "Kill Bill core container image repository.";
        };
        tag = mkOption {
          type = types.str;
          default = "0.24.16";
          description = "Kill Bill core container image tag.";
        };
      };
    };

    kaui = {
      image = {
        repository = mkOption {
          type = types.str;
          default = "killbill/kaui";
          description = "Kaui admin UI container image repository.";
        };
        tag = mkOption {
          type = types.str;
          default = "4.0.12";
          description = "Kaui admin UI container image tag.";
        };
      };
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── CNPG Databases (inside the shared cluster) ──────────────────
    openkrill.apps.cloudnative-pg.databases.killbill = {
      namespace = cnpgCfg.namespace;
      name = "killbill";
      owner = "app";
      cluster.name = cnpgCfg.clusterName;
    };

    openkrill.apps.cloudnative-pg.databases.kaui = {
      namespace = cnpgCfg.namespace;
      name = "kaui";
      owner = "app";
      cluster.name = cnpgCfg.clusterName;
    };

    # ── ExternalSecret: Kill Bill database credentials ──────────────
    openkrill.apps.external-secrets.externalsecrets.${killbillDbSecretName} = {
      namespace = cfg.namespace;
      secretStoreRef = {
        name = cnpgCfg.clusterSecretStoreName;
        kind = "ClusterSecretStore";
      };
      refreshInterval = "1h";
      target = {
        name = killbillDbSecretName;
        creationPolicy = "Owner";
        template.data = {
          KILLBILL_DAO_URL = "jdbc:postgresql://${dbHost}:5432/killbill";
          KILLBILL_DAO_USER = "{{ .username }}";
          KILLBILL_DAO_PASSWORD = "{{ .password }}";
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

    # ── ExternalSecret: Kaui database credentials ───────────────────
    openkrill.apps.external-secrets.externalsecrets.${kauiDbSecretName} = {
      namespace = cfg.namespace;
      secretStoreRef = {
        name = cnpgCfg.clusterSecretStoreName;
        kind = "ClusterSecretStore";
      };
      refreshInterval = "1h";
      target = {
        name = kauiDbSecretName;
        creationPolicy = "Owner";
        template.data = {
          KAUI_CONFIG_DAO_URL = "jdbc:postgresql://${dbHost}:5432/kaui";
          KAUI_CONFIG_DAO_USER = "{{ .username }}";
          KAUI_CONFIG_DAO_PASSWORD = "{{ .password }}";
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

    # ── ExternalSecret: Kill Bill auth secret (shiro.ini) ───────────
    openkrill.apps.external-secrets.secrets.${authSecretName} = {
      namespace = cfg.namespace;
      remoteSecretName = sourceSecretName;
      keys = [
        "shiro.ini"
      ];
    };

    # ── Secret generator: shiro.ini with LLDAP admin credentials ────
    # Builds a shiro.ini file content with the LLDAP admin password
    # so Kill Bill's admin user matches the platform-wide admin creds.
    openkrill.secrets.generators.killbill = {
      packages = with pkgs; [ openssl ];
      after = [ "lldap" ];
      script = ''
        LLDAP_PASS=""
        if kubectl -n "$NS" get secret openkrill-lldap >/dev/null 2>&1; then
          LLDAP_PASS=$(kubectl -n "$NS" get secret openkrill-lldap \
            -o jsonpath='{.data.LLDAP_LDAP_USER_PASS}' | base64 -d)
        fi
        ADMIN_PASS="''${LLDAP_PASS:-$(openssl rand -hex 16)}"

        SHIRO_INI="[users]
        ${lldapCfg.adminUser} = $ADMIN_PASS, root

        [roles]
        root = *:*"

        create_secret ${sourceSecretName} \
          --from-literal=shiro.ini="$SHIRO_INI" \
          --from-literal=ADMIN_PASSWORD="$ADMIN_PASS"
      '';
    };

    # ── Ingress routes ──────────────────────────────────────────────
    openkrill.ingress.routes.killbill = {
      subdomain = "killbill";
      namespace = cfg.namespace;
      service = "killbill";
      port = 8080;
    };

    openkrill.ingress.routes.killbill-admin = {
      subdomain = "killbill-admin";
      namespace = cfg.namespace;
      service = "kaui";
      port = 9090;
    };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.killbill = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "killbill.yaml";
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
    openkrill.manifests.killbill.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ import ./resources.nix {
        inherit cfg dbHost;
        killbillDbSecretName = killbillDbSecretName;
        kauiDbSecretName = kauiDbSecretName;
        authSecretName = authSecretName;
        adminUser = lldapCfg.adminUser;
      };
  };
}
