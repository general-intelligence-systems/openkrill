# apps/stable/librechat — LibreChat AI chat platform
#
# Multi-model AI chat interface with support for OpenAI, Anthropic,
# Google, and other LLM providers.  Uses the official LibreChat Helm
# chart from ghcr.io/danny-avila/librechat-chart.
{ config, lib, pkgs, charts, kubelib, k8s, ... }:
with lib;
let
  cfg     = config.openkrill.apps.librechat;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  domain  = config.openkrill.domain;

  secretName = "librechat-credentials-env";

  clusterScopedKinds = [
    "ClusterRole" "ClusterRoleBinding" "Namespace"
    "CustomResourceDefinition" "PersistentVolume"
    "StorageClass" "IngressClass" "PriorityClass"
  ];

  chart = kubelib.extractChart (kubelib.fetchChart {
    repo      = "oci://ghcr.io/danny-avila/librechat-chart";
    chart     = "librechat";
    version   = "2.0.0";
    chartHash = "sha256-TpteKnDV1AC/8vs7kMoNuKOPsOXs/egK5EDhkLfKt+w=";
  });

  defaults = {
    ingress.enabled = false;

    # All PVCs must use local-path on this cluster.
    meilisearch.persistence.storageClass        = "local-path";
    mongodb.persistence.storageClass             = "local-path";
    librechat.imageVolume.storageClassName        = "local-path";

    # Use our fork of the Bitnami MongoDB image (upstream tags get deleted).
    global.security.allowInsecureImages = true;
    mongodb.image = {
      registry   = "ghcr.io";
      repository = "general-intelligence-systems/mongodb";
    };

    # Tell Node.js to trust the cluster CA bundle and use c-ares for
    # DNS resolution (musl getaddrinfo can't follow CoreDNS CNAMEs).
    librechat.configEnv.NODE_EXTRA_CA_CERTS = "/etc/ssl/certs/openkrill-ca-bundle.pem";
    librechat.configEnv.NODE_OPTIONS = "-r /opt/dns-patch/dns-patch.js";

    # Init container writes a Node.js preload script that patches
    # dns.lookup to fall back to c-ares resolve when getaddrinfo fails.
    # Needed because musl libc getaddrinfo can't follow CoreDNS CNAMEs.
    initContainers.dns-patch = {
      image = "busybox";
      command = [ "sh" "-c" ''
        cat > /opt/dns-patch/dns-patch.js << 'SCRIPT'
        const dns = require('dns');
        const origLookup = dns.lookup;
        dns.lookup = function(hostname, opts, cb) {
          if (typeof opts === 'function') { cb = opts; opts = {}; }
          origLookup.call(dns, hostname, opts, function(err, address, family) {
            if (!err) return cb(null, address, family);
            dns.resolve4(hostname, function(err2, addrs) {
              if (err2 || !addrs || !addrs.length) return cb(err);
              if (opts && opts.all) {
                cb(null, addrs.map(function(a) { return {address: a, family: 4}; }));
              } else {
                cb(null, addrs[0], 4);
              }
            });
          });
        };
        SCRIPT
      '' ];
      volumeMounts = [{
        name = "dns-patch";
        mountPath = "/opt/dns-patch";
      }];
    };

    # LibreChat YAML config — connect to LiteLLM as the AI backend.
    librechat.configYamlContent = ''
      version: 1.2.1
      cache: true
      endpoints:
        custom:
          - name: "LiteLLM"
            apiKey: "''${LITELLM_API_KEY}"
            baseURL: "http://litellm.litellm.svc.cluster.local:4000/v1"
            models:
              default: ["gpt-4o", "gpt-4o-mini", "claude-sonnet-4-20250514", "claude-3-5-haiku-20241022"]
              fetch: true
            titleConvo: true
            titleModel: "gpt-4o-mini"
            summarize: false
            forcePrompt: false
            modelDisplayLabel: "LiteLLM"
    '';

    # OIDC via Authelia
    librechat.configEnv = {
      DOMAIN_CLIENT = "https://${cfg.domain}";
      DOMAIN_SERVER = "https://${cfg.domain}";
      ALLOW_SOCIAL_LOGIN = "true";
      ALLOW_EMAIL_LOGIN = "false";
      ALLOW_REGISTRATION = "false";
      OPENID_BUTTON_LABEL = "Log in with Authelia";
      OPENID_ISSUER = "https://auth.${domain}/.well-known/openid-configuration";
      OPENID_CLIENT_ID = "librechat";
      OPENID_CLIENT_SECRET = "librechat-oidc-client-secret-${domain}";
      OPENID_CALLBACK_URL = "/oauth/openid/callback";
      OPENID_SCOPE = "openid profile email";
      OPENID_GENERATE_NONCE = "true";
      DEBUG_OPENID_REQUESTS = "true";
      DEBUG_LOGGING = "true";
    };

    # Mount the cluster CA bundle so LibreChat trusts internal TLS certs.
    volumes = [
      { name = "ca-bundle"; configMap.name = "openkrill-ca-bundle"; }
      { name = "dns-patch"; emptyDir = {}; }
    ];
    volumeMounts = [
      { name = "ca-bundle"; mountPath = "/etc/ssl/certs/openkrill-ca-bundle.pem"; subPath = "bundle.pem"; readOnly = true; }
      { name = "dns-patch"; mountPath = "/opt/dns-patch"; readOnly = true; }
    ];
  };

  raw = kubelib.fromHelm {
    name      = "librechat";
    inherit chart;
    namespace = cfg.namespace;
    values    = recursiveUpdate defaults cfg.values;
  };

  ensureNs = res:
    if builtins.elem (res.kind or "") clusterScopedKinds then res
    else if (res.metadata.namespace or null) != null then res
    else res // { metadata = res.metadata // { namespace = cfg.namespace; }; };
in
{
  options.openkrill.apps.librechat = {
    enable = mkEnableOption "LibreChat AI chat platform";

    namespace = mkOption {
      type = types.str;
      default = "librechat";
    };

    domain = mkOption {
      type = types.str;
      default = "librechat.${domain}";
      description = "FQDN for the LibreChat instance.";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Secret generator ─────────────────────────────────────────────
    # Generates the source secret (openkrill-librechat) on the host.
    # ESO then syncs it into the librechat namespace as librechat-credentials-env.
    openkrill.secrets.generators.librechat = {
      packages = with pkgs; [ openssl ];
      after = [ "litellm" ];
      script = ''
        # Read the LiteLLM master key so LibreChat can call the proxy.
        LITELLM_KEY=""
        if kubectl -n "$NS" get secret openkrill-litellm >/dev/null 2>&1; then
          LITELLM_KEY=$(kubectl -n "$NS" get secret openkrill-litellm \
            -o jsonpath='{.data.PROXY_MASTER_KEY}' | base64 -d)
        fi

        create_secret openkrill-librechat \
          --from-literal=CREDS_KEY="$(openssl rand -hex 32)" \
          --from-literal=CREDS_IV="$(openssl rand -hex 16)" \
          --from-literal=JWT_SECRET="$(openssl rand -hex 32)" \
          --from-literal=JWT_REFRESH_SECRET="$(openssl rand -hex 32)" \
          --from-literal=MEILI_MASTER_KEY="$(openssl rand -hex 32)" \
          --from-literal=OPENID_SESSION_SECRET="$(openssl rand -hex 32)" \
          --from-literal=LITELLM_API_KEY="''${LITELLM_KEY:-changeme}"
      '';
    };

    # ── ExternalSecret: credentials ──────────────────────────────────
    openkrill.apps.external-secrets.secrets.${secretName} = {
      namespace        = cfg.namespace;
      remoteSecretName = "openkrill-librechat";
      keys = [
        "CREDS_KEY"
        "CREDS_IV"
        "JWT_SECRET"
        "JWT_REFRESH_SECRET"
        "MEILI_MASTER_KEY"
        "OPENID_SESSION_SECRET"
        "LITELLM_API_KEY"
      ];
    };

    # ── OIDC: register LibreChat as an Authelia client ──────────────
    openkrill.apps.authelia.oidcClients = [
      {
        name = "LibreChat";
        redirect_uris = [
          "https://${cfg.domain}/oauth/openid/callback"
        ];
        scopes = [ "openid" "profile" "email" ];
        userinfo_signed_response_alg = "none";
        token_endpoint_auth_method = "client_secret_post";
      }
    ];

    # ── Route ──────────────────────────────────────────────────────
    openkrill.ingress.routes.librechat = {
      subdomain = "librechat";
      namespace = cfg.namespace;
      service   = "librechat-librechat";
      port      = 3080;
      auth      = "forward";
    };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.librechat = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project   = "default";
      source = {
        repoURL        = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path           = ".";
        directory.include = "librechat.yaml";
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
    openkrill.manifests.librechat.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ map ensureNs raw;
  };
}
