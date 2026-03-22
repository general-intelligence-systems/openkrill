# apps/litellm — LiteLLM proxy
#
# Unified OpenAI-compatible proxy for multiple LLM providers.
# Uses the shared CNPG PostgreSQL cluster and Authelia OIDC for SSO.
#
# SSO flow: LLDAP (user directory) → Authelia (OIDC provider) → LiteLLM
# LiteLLM uses Authelia's Generic SSO endpoints so users log into the
# LiteLLM Admin UI with their LLDAP credentials.
#
# Bootstrap workflow:
#   1. Source secret (openkrill-litellm) is auto-created by the
#      openkrill-generate-litellm systemd oneshot at boot.
#   2. ESO syncs it into the litellm namespace as "litellm".
#   3. LiteLLM reads PROXY_MASTER_KEY, GENERIC_CLIENT_ID, etc. from env.
#   4. Navigate to https://litellm.<domain>/ui and click SSO login.
{ config, lib, pkgs, charts, kubelib, k8s, ... }:
with lib;
let
  cfg      = config.openkrill.apps.litellm;
  cnpgCfg  = config.openkrill.apps.cloudnative-pg;
  helpers  = import ../../../modules/lib/helpers.nix { inherit lib; };
  domain   = config.openkrill.domain;

  # CNPG shared cluster details
  cnpgAppSecret = "${cnpgCfg.clusterName}-app";
  dbSecretName  = "litellm-db";

  # Authelia OIDC endpoints
  autheliaBase = "https://auth.${domain}";

  # Deterministic client secret (same pattern as other Authelia clients)
  clientId     = "litellm";
  clientSecret = "$plaintext$${clientId}-oidc-client-secret-${domain}";

  # The plaintext version for LiteLLM's env var (strip the $plaintext$ prefix)
  clientSecretPlain = "${clientId}-oidc-client-secret-${domain}";

  clusterScopedKinds = [
    "ClusterRole" "ClusterRoleBinding" "Namespace"
    "CustomResourceDefinition" "PersistentVolume"
    "StorageClass" "IngressClass" "PriorityClass"
  ];

  defaults = {
    ingress.enabled = false;

    # Disable the bundled standalone PostgreSQL — we use the shared CNPG cluster.
    db = {
      deployStandalone = false;
      useExisting = true;
      endpoint = "${cnpgCfg.clusterName}-rw.${cnpgCfg.namespace}.svc.cluster.local";
      database = "litellm";
      secret = {
        name = dbSecretName;
        usernameKey = "username";
        passwordKey = "password";
      };
    };

    # The master key is read from the litellm secret via environmentSecrets.
    proxy_config = {
      general_settings = {
        master_key = "os.environ/PROXY_MASTER_KEY";
      };
    };

    # Mount the litellm secret as env vars (PROXY_MASTER_KEY, SSO vars)
    environmentSecrets = [ "litellm" ];
  };

  raw = kubelib.fromHelm {
    name      = "litellm";
    chart     = charts.berriai.litellm-helm.versions."1.82.3";
    namespace = cfg.namespace;
    values    = recursiveUpdate defaults cfg.values;
  };

  ensureNs = res:
    if builtins.elem (res.kind or "") clusterScopedKinds then res
    else if (res.metadata.namespace or null) != null then res
    else res // { metadata = res.metadata // { namespace = cfg.namespace; }; };
in
{
  options.openkrill.apps.litellm = {
    enable = mkEnableOption "LiteLLM proxy";

    namespace = mkOption {
      type = types.str;
      default = "litellm";
    };

    domain = mkOption {
      type = types.str;
      default = "litellm.${domain}";
      description = "FQDN for the LiteLLM instance.";
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
    openkrill.apps.cloudnative-pg.databases.litellm = {
      namespace = cnpgCfg.namespace;
      name = "litellm";
      owner = "app";
      cluster.name = cnpgCfg.clusterName;
    };

    # ── ExternalSecret: database credentials ─────────────────────────
    # Reads username + password from the CNPG-generated app secret and
    # makes them available in the litellm namespace.
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

    # ── ExternalSecret: LiteLLM secrets (master key + SSO) ───────────
    openkrill.apps.external-secrets.secrets.litellm = {
      namespace = cfg.namespace;
      remoteSecretName = "openkrill-litellm";
      keys = [
        "PROXY_MASTER_KEY"
        "GENERIC_CLIENT_ID"
        "GENERIC_CLIENT_SECRET"
        "GENERIC_AUTHORIZATION_ENDPOINT"
        "GENERIC_TOKEN_ENDPOINT"
        "GENERIC_USERINFO_ENDPOINT"
        "GENERIC_SCOPE"
        "PROXY_BASE_URL"
      ];
    };

    # ── Secret generator ─────────────────────────────────────────────
    openkrill.secrets.generators.litellm = {
      packages = with pkgs; [ openssl ];
      script = ''
        create_secret openkrill-litellm \
          --from-literal=PROXY_MASTER_KEY="sk-$(openssl rand -hex 24)" \
          --from-literal=GENERIC_CLIENT_ID="${clientId}" \
          --from-literal=GENERIC_CLIENT_SECRET="${clientSecretPlain}" \
          --from-literal=GENERIC_AUTHORIZATION_ENDPOINT="${autheliaBase}/api/oidc/authorization" \
          --from-literal=GENERIC_TOKEN_ENDPOINT="${autheliaBase}/api/oidc/token" \
          --from-literal=GENERIC_USERINFO_ENDPOINT="${autheliaBase}/api/oidc/userinfo" \
          --from-literal=GENERIC_SCOPE="openid profile email groups" \
          --from-literal=PROXY_BASE_URL="https://${cfg.domain}"
      '';
    };

    # ── OIDC: register LiteLLM as an Authelia client ─────────────────
    openkrill.apps.authelia.oidcClients = [
      {
        name = "LiteLLM";
        redirect_uris = [
          "https://${cfg.domain}/sso/callback"
        ];
        scopes = [ "openid" "profile" "email" "groups" ];
      }
    ];

    # ── Route ──────────────────────────────────────────────────────
    openkrill.ingress.routes.litellm = {
      subdomain = "litellm";
      namespace = cfg.namespace;
      service   = "litellm-helm";
      port      = 4000;
      auth      = "none";  # LiteLLM handles its own SSO — no ForwardAuth
    };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.litellm = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project   = "default";
      source = {
        repoURL        = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path           = ".";
        directory.include = "litellm.yaml";
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

    # ── Manifests ───────────────────────────────────────────────────
    openkrill.manifests.litellm.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ map ensureNs raw;
  };
}
