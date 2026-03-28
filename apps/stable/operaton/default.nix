# apps/operaton — Operaton BPMN process engine
#
# BPMN workflow automation engine (Camunda 7 fork).
# Uses the shared CloudNativePG cluster by default for rolling-safe
# PostgreSQL storage.
{ config, lib, pkgs, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.operaton;
  cnpgCfg = config.openkrill.apps.cloudnative-pg;
  lldapCfg    = config.openkrill.apps.lldap;
  helpers     = import ../../../modules/lib/helpers.nix { inherit lib; };
  cnpgAppSecret = "${cnpgCfg.clusterName}-app";
  dbSecretName = "operaton-db";
  sourceSecretName = "openkrill-operaton";
  targetSecretName = "operaton-auth";

  defaults = {
    ingress.enabled = false;

    database = {
      driver = "org.postgresql.Driver";
      url = "jdbc:postgresql://${cnpgCfg.clusterName}-rw.${cnpgCfg.namespace}.svc.cluster.local:5432/operaton";
      credentialsSecretEnabled = true;
      credentialsSecretName = dbSecretName;
      credentialsSecretKeys = {
        username = "DB_USERNAME";
        password = "DB_PASSWORD";
      };
    };

    # Seed Operaton webapp admin credentials from a synced secret.
    # Uses Spring Boot relaxed-binding env names for:
    #   operaton.bpm.admin-user.id/password
    extraEnvs = [
      {
        name = "OPERATON_BPM_ADMIN_USER_ID";
        valueFrom.secretKeyRef = {
          name = targetSecretName;
          key = "OPERATON_BPM_ADMIN_USER_ID";
        };
      }
      {
        name = "OPERATON_BPM_ADMIN_USER_PASSWORD";
        valueFrom.secretKeyRef = {
          name = targetSecretName;
          key = "OPERATON_BPM_ADMIN_USER_PASSWORD";
        };
      }
    ];
  };

in
{
  options.openkrill.apps.operaton = {
    enable = mkEnableOption "Operaton BPMN process engine";

    namespace = mkOption {
      type = types.str;
      default = "operaton";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
      # ── CNPG Database (inside the shared cluster) ──────────────────
      openkrill.apps.cloudnative-pg.databases.operaton = {
        namespace = cnpgCfg.namespace;
        name = "operaton";
        owner = "app";
        cluster.name = cnpgCfg.clusterName;
      };

      # ── ExternalSecret: database credentials ───────────────────────
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
        };
        data = [
          {
            secretKey = "DB_USERNAME";
            remoteRef = {
              key = cnpgAppSecret;
              property = "username";
            };
          }
          {
            secretKey = "DB_PASSWORD";
            remoteRef = {
              key = cnpgAppSecret;
              property = "password";
            };
          }
        ];
      };

      # ── ExternalSecret for Operaton webapp admin creds ───────────
      openkrill.apps.external-secrets.secrets.${targetSecretName} = {
        namespace = cfg.namespace;
        remoteSecretName = sourceSecretName;
        keys = [
          "OPERATON_BPM_ADMIN_USER_ID"
          "OPERATON_BPM_ADMIN_USER_PASSWORD"
        ];
      };

      # ── Secret generator (reads LLDAP admin password) ────────────
      openkrill.secrets.generators.operaton = {
        packages = with pkgs; [ openssl ];
        after = [ "lldap" ];
        script = ''
          LLDAP_PASS=""
          if kubectl -n "$NS" get secret openkrill-lldap >/dev/null 2>&1; then
            LLDAP_PASS=$(kubectl -n "$NS" get secret openkrill-lldap \
              -o jsonpath='{.data.LLDAP_LDAP_USER_PASS}' | base64 -d)
          fi

          create_secret ${sourceSecretName} \
            --from-literal=OPERATON_BPM_ADMIN_USER_ID="${lldapCfg.adminUser}" \
            --from-literal=OPERATON_BPM_ADMIN_USER_PASSWORD="''${LLDAP_PASS:-$(openssl rand -hex 16)}"
        '';
      };

      # ── Route ────────────────────────────────────────────────────
      openkrill.ingress.routes.operaton = {
        subdomain = "operaton";
        namespace = cfg.namespace;
        service = "operaton";
        port = 8080;
      };

      # ── ArgoCD Application ──────────────────────────────────────
      openkrill.apps.argo-cd.applications.operaton = mkIf config.openkrill.gitops.generateApplications {
        namespace = "argo-cd";
        project   = "default";
        source = {
          repoURL          = config.openkrill.gitops.repoURL;
          targetRevision   = "rendered-manifests";
          path             = ".";
          directory.include = "operaton.yaml";
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
      openkrill.manifests.operaton.content =
        [ (k8s.mkNamespace cfg.namespace) ]
        ++ kubelib.fromHelm {
          name      = "operaton";
          chart     = charts.operaton.operaton.versions."1.0.5";
          namespace = cfg.namespace;
          values    = recursiveUpdate defaults cfg.values;
        };
  };
}
