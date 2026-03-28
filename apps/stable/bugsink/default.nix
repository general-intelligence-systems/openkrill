{ config, lib, pkgs, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.bugsink;
  cnpgCfg = config.openkrill.apps.cloudnative-pg;
  lldapCfg = config.openkrill.apps.lldap;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  domain = config.openkrill.domain;
  cnpgAppSecret = "${cnpgCfg.clusterName}-app";
  dbSecretName = "bugsink-db";
  authSecretName = "bugsink-auth";
  chartSecretName = "bugsink";
  chartSyncExternalSecretName = "bugsink-chart-secret";
  sourceSecretName = "openkrill-bugsink";

  defaults = {
    baseUrl = "https://${cfg.domain}";
    extraEnv.configs = {
      # Bugsink runs behind the cluster ingress TLS terminator.
      BEHIND_HTTPS_PROXY = "True";
    };
    ingress.enabled = false;
    postgresql.enabled = false;
    admin = {
      existingSecret = authSecretName;
      existingSecretKey = "auth";
    };
    secretKey = {
      existingSecret = authSecretName;
      existingSecretKey = "secret-key";
    };
    externalDatabase = {
      existingSecret = dbSecretName;
      existingSecretKey = "url";
    };
  };
in
{
  options.openkrill.apps.bugsink = {
    enable = mkEnableOption "Bugsink error tracking";

    namespace = mkOption {
      type = types.str;
      default = "bugsink";
    };

    domain = mkOption {
      type = types.str;
      default = "bugsink.${domain}";
      description = "FQDN for the Bugsink instance.";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Secret generator: Bugsink bootstrap credentials ─────────────
    # Reuse the LLDAP admin password so platform admin credentials
    # stay aligned across apps.
    openkrill.secrets.generators.bugsink = {
      packages = with pkgs; [ openssl ];
      after = [ "lldap" ];
      script = ''
        LLDAP_PASS=""
        if kubectl -n "$NS" get secret openkrill-lldap >/dev/null 2>&1; then
          LLDAP_PASS=$(kubectl -n "$NS" get secret openkrill-lldap \
            -o jsonpath='{.data.LLDAP_LDAP_USER_PASS}' | base64 -d)
        fi

        create_secret ${sourceSecretName} \
          --from-literal=auth="${lldapCfg.adminUser}:''${LLDAP_PASS:-$(openssl rand -hex 16)}" \
          --from-literal=secret-key="$(openssl rand -hex 32)"
      '';
    };

    # ── ExternalSecret: Bugsink bootstrap secret ────────────────────
    openkrill.apps.external-secrets.secrets.${authSecretName} = {
      namespace = cfg.namespace;
      remoteSecretName = sourceSecretName;
      keys = [ "auth" "secret-key" ];
    };

    # ── ExternalSecret: keep chart-managed secret aligned ──────────────
    # The Helm chart emits a `bugsink` Secret (envFrom). Populate
    # CREATE_SUPERUSER/SECRET_KEY from the same source to avoid drift.
    openkrill.apps.external-secrets.externalsecrets.${chartSyncExternalSecretName} = {
      namespace = cfg.namespace;
      secretStoreRef = {
        name = config.openkrill.apps.external-secrets.clusterSecretStoreName;
        kind = "ClusterSecretStore";
      };
      refreshInterval = "1h";
      target = {
        name = chartSecretName;
        creationPolicy = "Merge";
        deletionPolicy = "Retain";
      };
      data = [
        {
          secretKey = "CREATE_SUPERUSER";
          remoteRef = {
            key = sourceSecretName;
            property = "auth";
          };
        }
        {
          secretKey = "SECRET_KEY";
          remoteRef = {
            key = sourceSecretName;
            property = "secret-key";
          };
        }
      ];
    };

    # ── CNPG Database (inside the shared cluster) ──────────────────
    openkrill.apps.cloudnative-pg.databases.bugsink = {
      namespace = cnpgCfg.namespace;
      name = "bugsink";
      owner = "app";
      cluster.name = cnpgCfg.clusterName;
    };

    # ── ExternalSecret: database connection URI ─────────────────────
    # Feed Bugsink's externalDatabase.existingSecret with a URL
    # built from the shared CNPG app credentials.
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
          url = "postgresql://{{ .username }}:{{ .password }}@${cnpgCfg.clusterName}-rw.${cnpgCfg.namespace}.svc.cluster.local:5432/bugsink";
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

    openkrill.ingress.routes.bugsink = {
      subdomain = "bugsink";
      namespace = cfg.namespace;
      service = "bugsink";
      port = 8000;
    };

    openkrill.apps.argo-cd.applications.bugsink = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "bugsink.yaml";
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

    openkrill.manifests.bugsink.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name = chartSecretName;
        chart = charts.contrib.bugsink.bugsink.versions."0.1.2";
        namespace = cfg.namespace;
        values = recursiveUpdate defaults cfg.values;
      };
  };
}
