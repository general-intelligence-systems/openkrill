# apps/lago — Lago open-source billing and metering platform
# Deploys the Lago API, frontend, Sidekiq workers, and supporting services.
#
# Database: a CNPG Database CRD creates the "lago" database inside the
# shared CloudNativePG cluster.  The secret generator reads CNPG
# credentials at boot and writes a fully-templated PostgreSQL URI
# into openkrill-lago alongside the encryption + signing keys.
#
# Redis: a minimal single-instance Redis Deployment is created in the
# lago namespace via the chart's extraObjects.
#
# Bootstrap workflow:
#   1. openkrill-generate-lago systemd oneshot creates openkrill-lago
#      in the secret-store namespace with database URI, encryption keys,
#      and signing keys.
#   2. ESO syncs openkrill-lago into "lago" in the lago namespace.
#   3. The chart mounts the "lago" secret for all configuration.
{ config, lib, pkgs, charts, kubelib, ... }:
with lib;
let
  cfg     = config.openkrill.apps.lago;
  cnpgCfg = config.openkrill.apps.cloudnative-pg;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  domain  = config.openkrill.domain;

  # Source secret created by the systemd generator.
  sourceSecretName = "openkrill-lago";

  # In-namespace Redis endpoint.
  redisUri = "redis://lago-redis.${cfg.namespace}.svc.cluster.local:6379";
in
{
  options.openkrill.apps.lago = {
    enable = mkEnableOption "Lago open-source billing and metering platform";

    namespace = mkOption {
      type = types.str;
      default = "lago";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── CNPG Database (inside the shared cluster) ─────────────────────
    openkrill.apps.cloudnative-pg.databases.lago = {
      namespace = cnpgCfg.namespace;
      name      = "lago";
      owner     = "app";
      cluster.name = cnpgCfg.clusterName;
    };

    # ── ExternalSecret: sync openkrill-lago → lago namespace ──────────
    # The generator writes all secrets (including the DB URI) into
    # openkrill-lago in the secret-store namespace.  ESO mirrors it
    # into the lago namespace as "lago".
    openkrill.apps.external-secrets.secrets.lago = {
      namespace = cfg.namespace;
      remoteSecretName = sourceSecretName;
      keys = [
        "database.uri"
        "encryption.key"
        "encryption.salt"
        "signing.hmac"
        "signing.rsa"
      ];
    };

    # ── Secret generator ──────────────────────────────────────────────
    # Reads CNPG credentials at boot and writes a complete source
    # secret with the database URI and all crypto keys.
    openkrill.secrets.generators.lago = {
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
        DB_URI="postgresql://''${DB_USER}:''${DB_PASS}@${cnpgCfg.clusterName}-rw.${cnpgCfg.namespace}.svc.cluster.local:5432/lago"

        RSA_KEY=$(openssl genrsa 2048 2>/dev/null | base64 -w0)

        create_secret ${sourceSecretName} \
          --from-literal=database.uri="$DB_URI" \
          --from-literal=encryption.key="$(openssl rand -hex 16)" \
          --from-literal=encryption.salt="$(openssl rand -hex 16)" \
          --from-literal=signing.hmac="$(openssl rand -hex 32)" \
          --from-literal=signing.rsa="$RSA_KEY"
      '';
    };

    # ── Route ─────────────────────────────────────────────────────────
    # The frontend SPA is the catch-all; Authelia gates browser access.
    openkrill.ingress.routes.lago = {
      subdomain = "lago";
      namespace = cfg.namespace;
      service   = "lago-front";
      port      = 80;
    };

    # The API backend handles /api and /health.  These paths must NOT
    # go through Authelia — the Lago API uses its own bearer-token auth.
    # We use the low-level httproutes option because the high-level
    # routes abstraction only supports a single backend per hostname.
    openkrill.apps."gateway-api".httproutes = let
      apiRule = {
        matches = [
          { path = { type = "PathPrefix"; value = "/api"; }; }
          { path = { type = "Exact";      value = "/health"; }; }
          { path = { type = "PathPrefix"; value = "/graphql"; }; }
        ];
        backendRefs = [{
          name      = "lago-api";
          namespace = cfg.namespace;
          port      = 80;
        }];
      };
    in {
      lago-api = {
        namespace  = "kube-system";
        hostnames  = [ "lago.${domain}" ];
        parentRefs = [{
          name          = "main";
          namespace     = "kube-system";
          sectionName   = "lago-https";
        }];
        rules = [ apiRule ];
      };
      lago-api-http = {
        namespace  = "kube-system";
        hostnames  = [ "lago.${domain}" ];
        parentRefs = [{
          name          = "main";
          namespace     = "kube-system";
          sectionName   = "lago-http";
        }];
        rules = [ apiRule ];
      };
    };

    # ── ArgoCD Application CR ─────────────────────────────────────────
    openkrill.apps.argo-cd.applications.lago = {
      namespace = "argocd";
      project   = "default";
      source = {
        repoURL          = config.openkrill.gitops.repoURL;
        targetRevision   = "rendered-manifests";
        path             = ".";
        directory.include = "lago.yaml";
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

    # ── Manifests ─────────────────────────────────────────────────────
    # The Lago chart templates omit metadata.namespace on most
    # resources, so helm template output lacks it.  Without explicit
    # namespaces the k3s auto-deploy bootstrap puts everything into
    # `default`.  Inject cfg.namespace on all namespace-scoped
    # resources to ensure they land in the right place.
    openkrill.manifests.lago.content = let
      clusterScopedKinds = [
        "ClusterRole" "ClusterRoleBinding" "Namespace"
        "CustomResourceDefinition" "PersistentVolume"
        "StorageClass" "IngressClass" "PriorityClass"
      ];
      raw = kubelib.fromHelm {
        name      = "lago";
        chart     = charts.lago.lago.latest;
        namespace = cfg.namespace;
        values    = recursiveUpdate {
        global = {
          # These values satisfy helm template's `required` checks.
          # The chart's secret creation is disabled below — at runtime
          # the "lago" secret (managed by ExternalSecret) is used.
          database.uri    = "placeholder://managed-by-external-secret";
          encryption.key  = "placeholder-managed-by-external-secret";
          encryption.salt = "placeholder-managed-by-external-secret";
          signing.hmac    = "placeholder-managed-by-external-secret";
          signing.rsa     = "placeholder-managed-by-external-secret";

          # Point the chart at our ExternalSecret-managed secret.
          config.secret = "lago";

          # Redis — in-namespace Redis deployment.
          redis.uri       = redisUri;
          redisCache.uri  = redisUri;
          redisStore.uri  = redisUri;

          urls = {
            api   = "https://lago.${domain}";
            front = "https://lago.${domain}";
          };
        };

        # Disable the chart's auto-generated secret — we provide
        # our own via ExternalSecret.
        config.secret.create = false;

        # ── In-namespace Redis ────────────────────────────────────────
        extraObjects = [
          {
            apiVersion = "apps/v1";
            kind       = "Deployment";
            metadata   = {
              name      = "lago-redis";
              namespace = cfg.namespace;
              labels."app.kubernetes.io/name" = "lago-redis";
            };
            spec = {
              replicas = 1;
              selector.matchLabels."app.kubernetes.io/name" = "lago-redis";
              template = {
                metadata.labels."app.kubernetes.io/name" = "lago-redis";
                spec.containers = [{
                  name  = "redis";
                  image = "redis:7-alpine";
                  ports = [{ containerPort = 6379; name = "redis"; }];
                  resources = {
                    requests = { cpu = "50m";  memory = "64Mi"; };
                    limits   = { memory = "128Mi"; };
                  };
                }];
              };
            };
          }
          {
            apiVersion = "v1";
            kind       = "Service";
            metadata   = {
              name      = "lago-redis";
              namespace = cfg.namespace;
            };
            spec = {
              selector."app.kubernetes.io/name" = "lago-redis";
              ports = [{ port = 6379; targetPort = 6379; name = "redis"; }];
            };
          }
        ];
      } cfg.values;
      };
      ensureNs = res:
        if builtins.elem (res.kind or "") clusterScopedKinds then res
        else if (res.metadata.namespace or null) != null then res
        else res // { metadata = res.metadata // { namespace = cfg.namespace; }; };
    in map ensureNs raw;
  };
}
