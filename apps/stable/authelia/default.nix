# apps/authelia — Authelia SSO portal + OIDC provider
# Acts as OpenID Connect 1.0 provider for ArgoCD, Windmill, Harbor, etc.
# Uses LLDAP as the LDAP authentication backend (always required).
#
# Database: uses the shared CNPG PostgreSQL cluster.  A Database CRD
# creates the "authelia" database and an ExternalSecret mirrors
# connection credentials into the authelia namespace.
{ config, lib, pkgs, charts, kubelib, ... }:
with lib;
let
  cfg          = config.openkrill.apps.authelia;
  lldapCfg     = config.openkrill.apps.lldap;
  cnpgCfg      = config.openkrill.apps.cloudnative-pg;
  domain       = config.openkrill.domain;
  helpers          = import ../../../modules/lib/helpers.nix { inherit lib; };


  # CNPG shared cluster details
  cnpgAppSecret = "${cnpgCfg.clusterName}-app";
  dbSecretName  = "authelia-db";

  # Derive client_id from display name: lowercase and remove spaces.
  #   "Argo CD" → "argocd"
  mkClientId = name:
    replaceStrings [ " " ] [ "" ] (toLower name);

  oidcClientModule = types.submodule ({ config, ... }: {
    options = {
      name = mkOption {
        type = types.str;
        description = "Display name for this OIDC client (also used to derive client_id).";
      };

      client_id = mkOption {
        type = types.str;
        default = mkClientId config.name;
        description = "OIDC client identifier. Defaults to lowercased name with spaces removed.";
      };

      redirect_uris = mkOption {
        type = types.listOf types.str;
        description = "Allowed redirect URIs for this client.";
      };

      client_secret = mkOption {
        type = types.str;
        default = "$plaintext$" + config.client_id + "-oidc-client-secret-" + domain;
        description = "Client secret. Defaults to a deterministic plaintext secret.";
      };

      public = mkOption {
        type = types.bool;
        default = false;
        description = "Whether this is a public (no secret) client.";
      };

      authorization_policy = mkOption {
        type = types.str;
        default = "one_factor";
        description = "Authelia authorization policy for this client.";
      };

      scopes = mkOption {
        type = types.listOf types.str;
        default = [ "openid" "profile" "email" "groups" ];
        description = "Allowed OIDC scopes.";
      };

      response_types = mkOption {
        type = types.listOf types.str;
        default = [ "code" ];
        description = "Allowed response types.";
      };

      grant_types = mkOption {
        type = types.listOf types.str;
        default = [ "authorization_code" ];
        description = "Allowed grant types.";
      };

      access_token_signed_response_alg = mkOption {
        type = types.str;
        default = "none";
        description = "Algorithm for signing access token responses.";
      };

      userinfo_signed_response_alg = mkOption {
        type = types.str;
        default = "none";
        description = "Algorithm for signing userinfo responses.";
      };

      token_endpoint_auth_method = mkOption {
        type = types.str;
        default = "client_secret_basic";
        description = "Token endpoint authentication method.";
      };

      claims_policy = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Claims policy name. Omitted from config when null.";
      };

      require_pkce = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = "Whether to require PKCE. Omitted from config when null.";
      };

      extraConfig = mkOption {
        type = types.attrs;
        default = {};
        description = "Additional attributes merged into the client config.";
      };
    };
  });

  defaults = {
    pod = {
      kind = "Deployment";
      replicas = 1;
    };

    configMap.telemetry.metrics.enabled = true;

    secret = {
      existingSecret = "authelia";
      additionalSecrets = {
        authelia = {
          items = [
            {
              key = "identity_providers.oidc.jwks.0.key";
              path = "identity_providers.oidc.jwks.0.key";
            }
          ];
        };
        ${dbSecretName} = {
          items = [
            {
              key = "password";
              path = "password";
            }
          ];
        };
      };
    };

    configMap = {
      authentication_backend = {
        ldap = {
          enabled = true;
          implementation = "lldap";
          address = "ldap://lldap.${lldapCfg.namespace}.svc.cluster.local:3890";
          base_dn = lldapCfg.baseDn;
          user = "UID=${lldapCfg.adminUser},OU=people,${lldapCfg.baseDn}";
        };
        password_reset.disable = false;
      };

      session = {
        cookies = cfg.sessionCookies;
      };

      storage = {
        local.enabled = false;
        postgres = {
          enabled = true;
          address = "tcp://${cnpgCfg.clusterName}-rw.${cnpgCfg.namespace}.svc.cluster.local:5432";
          database = "authelia";
          schema = "public";
          username = "app";
          password = {
            disabled = false;
            secret_name = dbSecretName;
            path = "password";
          };
        };
      };

      notifier = {
        filesystem = {
          enabled = true;
          filename = "/config/notification.txt";
        };
      };

      access_control = {
        default_policy = "one_factor";
      } // (if cfg.accessControlRules != [] then {
        rules = cfg.accessControlRules;
      } else {});

      identity_providers = optionalAttrs (cfg.oidcClients != []) {
        oidc = {
          enabled = true;

          hmac_secret = {
            path = "identity_providers.oidc.hmac_secret";
          };

          jwks = [
            {
              key = {
                path = "/secrets/authelia/identity_providers.oidc.jwks.0.key";
              };
            }
          ];

          cors = {
            endpoints = [
              "authorization"
              "token"
              "revocation"
              "introspection"
              "userinfo"
            ];
            allowed_origins_from_client_redirect_uris = true;
          };

          clients = map (c:
            filterAttrs (_: v: v != null) {
              client_id = c.client_id;
              client_name = c.name;
              client_secret = c.client_secret;
              inherit (c) public authorization_policy redirect_uris
                scopes response_types grant_types
                access_token_signed_response_alg
                userinfo_signed_response_alg
                token_endpoint_auth_method
                claims_policy require_pkce;
            } // c.extraConfig
          ) cfg.oidcClients;
        } // (if cfg.claimsPolicies != {} then {
          claims_policies = cfg.claimsPolicies;
        } else {});
      };
    };
  };
in
{
  options.openkrill.apps.authelia = {
    enable = mkEnableOption "Authelia SSO portal + OIDC provider";

    namespace = mkOption {
      type = types.str;
      default = "authelia";
    };

    sessionCookies = mkOption {
      type = types.listOf types.attrs;
      default = [
        {
          domain = domain;
          subdomain = "auth";
        }
      ];
      description = "Authelia session cookie configurations. Defaults to a single cookie using openkrill.domain.";
    };

    accessControlRules = mkOption {
      type = types.listOf types.attrs;
      default = [];
      description = "Authelia access control rules.";
    };

    claimsPolicies = mkOption {
      type = types.attrs;
      default = {};
      description = "Authelia claims policies for OIDC.";
    };

    sharedClient = {
      redirectUris = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "Redirect URIs for the shared 'openkrill' OIDC client. App modules append to this list automatically.";
      };
    };

    oidcClients = mkOption {
      type = types.listOf oidcClientModule;
      default = [];
      description = "OIDC client configurations. Only 'name' and 'redirect_uris' are required.";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Shared OIDC client ────────────────────────────────────────────
    # App modules append redirect URIs to sharedClient.redirectUris.
    # When any URIs are present, a single "openkrill" OIDC client is
    # registered so all apps share one session — logging out of one
    # logs out of all (wildcard cookie on .${domain}).
    openkrill.apps.authelia.oidcClients = mkIf (cfg.sharedClient.redirectUris != []) [
      {
        name = "OpenKrill";
        redirect_uris = cfg.sharedClient.redirectUris;
      }
    ];

    # ── VictoriaMetrics scrape + alerts ────────────────────────────────
    openkrill.apps.victoriametrics.vmservicescrapes.authelia =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        selector.matchLabels."app.kubernetes.io/name" = "authelia";
        namespaceSelector.matchNames = [ cfg.namespace ];
        endpoints = [{ port = "metrics"; }];
      };

    openkrill.apps.victoriametrics.vmrules.authelia-alerts =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        groups = [{
          name = "authelia";
          rules = [{
            alert = "AutheliaDown";
            expr = ''up{job=~".*authelia.*"} == 0'';
            "for" = "5m";
            labels.severity = "critical";
            annotations = {
              summary = "Authelia is down";
              description = "Authelia SSO portal has been unreachable for 5 minutes.";
            };
          }];
        }];
      };
    # ── CNPG Database (inside the shared cluster) ─────────────────────
    openkrill.apps.cloudnative-pg.databases.authelia = {
      namespace = cnpgCfg.namespace;
      name = "authelia";
      owner = "app";
      cluster.name = cnpgCfg.clusterName;
    };

    # ── ExternalSecret: database credentials ─────────────────────────
    # Reads password from the shared CNPG cluster's app secret and
    # creates a Secret the Authelia Helm chart can mount for the
    # PostgreSQL password file.
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
      data = [{
        secretKey = "password";
        remoteRef = {
          key = cnpgAppSecret;
          property = "password";
        };
      }];
    };

    # ── ExternalSecret for Authelia secrets ─────────────────────────
    openkrill.apps.external-secrets.secrets.authelia = {
      namespace = cfg.namespace;
      remoteSecretName = "openkrill-authelia";
      keys = [
        "identity_providers.oidc.hmac_secret"
        "identity_providers.oidc.jwks.0.key"
        "session.encryption.key"
        "storage.encryption.key"
        "authentication.ldap.password.txt"
        "identity_validation.reset_password.jwt.hmac.key"
      ];
    };

    # ── Secret generator ─────────────────────────────────────────────
    openkrill.secrets.generators.authelia = {
      packages = with pkgs; [ openssl ];
      after = [ "lldap" ];
      script = ''
        # Read the LLDAP admin password for cross-reference (LDAP bind password).
        # Falls back to a random value only if the lldap secret is missing.
        LLDAP_PASS=""
        if kubectl -n "$NS" get secret openkrill-lldap >/dev/null 2>&1; then
          LLDAP_PASS=$(kubectl -n "$NS" get secret openkrill-lldap \
            -o jsonpath='{.data.LLDAP_LDAP_USER_PASS}' | base64 -d)
        fi

        SESSION_KEY=$(openssl rand -hex 32)
        STORAGE_KEY=$(openssl rand -hex 32)
        OIDC_HMAC=$(openssl rand -hex 32)
        JWT_HMAC=$(openssl rand -hex 32)
        JWKS_RSA=$(openssl genrsa 2048 2>/dev/null)

        create_secret openkrill-authelia \
          --from-literal=authentication.ldap.password.txt="''${LLDAP_PASS:-$(openssl rand -hex 16)}" \
          --from-literal=session.encryption.key="$SESSION_KEY" \
          --from-literal=storage.encryption.key="$STORAGE_KEY" \
          --from-literal=identity_providers.oidc.hmac_secret="$OIDC_HMAC" \
          --from-literal=identity_providers.oidc.jwks.0.key="$JWKS_RSA" \
          --from-literal=identity_validation.reset_password.jwt.hmac.key="$JWT_HMAC"
      '';
    };

    openkrill.ingress.routes.authelia = {
      subdomain = "auth";
      namespace = cfg.namespace;
      service = "authelia";
      #port = 443;
      port = 80; # only exposes port 80 and metrics port.
      auth = false;  # Authelia itself must not go through ForwardAuth
    };

    openkrill.apps.argo-cd.applications.authelia = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "authelia.yaml";
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

    openkrill.manifests.authelia.content =
      kubelib.fromHelm {
        name = "authelia";
        chart = charts.authelia.authelia.latest;
        namespace = cfg.namespace;
        extraOpts = [ "--skip-schema-validation" ];
        values = recursiveUpdate defaults cfg.values;
      };
  };
}
