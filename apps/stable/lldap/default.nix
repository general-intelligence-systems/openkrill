# apps/lldap — Light LDAP user management server
# Deploys LLDAP with PostgreSQL storage (via the shared CloudNativePG
# cluster) and exposes a web UI for user/group management.  Authelia
# can use LLDAP as its LDAP authentication backend.
#
# Database: a CNPG Database CRD creates the "lldap" database inside
# the shared cluster.  An ExternalSecret mirrors credentials into
# the lldap namespace with the correct database name baked in.
#
# Bootstrap workflow:
#   1. Source secret (openkrill-lldap) is auto-created by the
#      openkrill-generate-lldap systemd oneshot at boot.
#   2. ESO syncs it into the lldap namespace as "lldap".
#   3. LLDAP creates admin user from LLDAP_LDAP_USER_PASS on first boot.
#   4. Log into the web UI at https://ldap.<domain>
#   5. Create user accounts and groups
#
# The admin password is only applied on first boot. Subsequent
# password changes via the web UI persist in the database.
{ config, lib, pkgs, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.lldap;
  cnpgCfg = config.openkrill.apps.cloudnative-pg;
  helpers          = import ../../../modules/lib/helpers.nix { inherit lib; };
  domain = config.openkrill.domain;

  # Name of the CNPG-generated app secret for the shared cluster.
  cnpgAppSecret = "${cnpgCfg.clusterName}-app";

  # Name of the secret we create in the lldap namespace with the
  # templated connection URI pointing at the "lldap" database.
  dbSecretName = "lldap-db";
in
{
  options.openkrill.apps.lldap = {
    enable = lib.mkEnableOption "LLDAP lightweight LDAP server";

    namespace = lib.mkOption {
      type = lib.types.str;
      default = "lldap";
      description = "Kubernetes namespace for LLDAP.";
    };

    baseDn = lib.mkOption {
      type = lib.types.str;
      default = builtins.concatStringsSep "," (map (part: "dc=${part}") (lib.splitString "." domain));
      description = ''
        LDAP base DN (e.g. "dc=example,dc=com").
        Defaults to openkrill.domain split into DC components.
      '';
      example = "dc=example,dc=com";
    };

    adminUser = lib.mkOption {
      type = lib.types.str;
      default = "admin";
      description = "LLDAP admin username.";
    };

    image = {
      repository = lib.mkOption {
        type = lib.types.str;
        default = "lldap/lldap";
        description = "LLDAP container image repository.";
      };
      tag = lib.mkOption {
        type = lib.types.str;
        default = "latest-alpine-rootless";
        description = "LLDAP container image tag. Rootless variant recommended.";
      };
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = lib.mkIf cfg.enable {
    # ── CNPG Database (inside the shared cluster) ─────────────────────
    openkrill.apps.cloudnative-pg.databases.lldap = {
      namespace = cnpgCfg.namespace;
      name = "lldap";
      owner = "app";
      cluster.name = cnpgCfg.clusterName;
    };

    # ── ExternalSecret: database credentials ─────────────────────────
    # Reads username + password from the CNPG-generated app secret and
    # templates a postgres:// URI with the lldap database name.
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
          uri = "postgresql://{{ .username }}:{{ .password }}@${cnpgCfg.clusterName}-rw.${cnpgCfg.namespace}.svc.cluster.local:5432/lldap";
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

    # ── ExternalSecret for LLDAP secrets ─────────────────────────────
    openkrill.apps.external-secrets.secrets.lldap = {
      namespace = cfg.namespace;
      remoteSecretName = "openkrill-lldap";
      keys = [
        "LLDAP_JWT_SECRET"
        "LLDAP_KEY_SEED"
        "LLDAP_LDAP_USER_PASS"
      ];
    };

    # ── Secret generator ─────────────────────────────────────────────
    openkrill.secrets.generators.lldap = {
      packages = with pkgs; [ openssl ];
      script = ''
        create_secret openkrill-lldap \
          --from-literal=LLDAP_JWT_SECRET="$(openssl rand -hex 32)" \
          --from-literal=LLDAP_KEY_SEED="$(openssl rand -hex 32)" \
          --from-literal=LLDAP_LDAP_USER_PASS="$(openssl rand -hex 24)"
      '';
    };

    # ── Route for the web UI ─────────────────────────────────────────
    openkrill.ingress.routes.lldap = {
      subdomain = "ldap";
      namespace = cfg.namespace;
      service = "lldap-http";
      port = 17170;
    };

    # ── ArgoCD Application CR ────────────────────────────────────────
    openkrill.apps.argocd.applications.lldap = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "lldap.yaml";
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
    openkrill.manifests.lldap.content = import ./resources.nix {
      inherit cfg domain dbSecretName;
    };
  };
}
