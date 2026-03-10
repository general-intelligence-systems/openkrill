# modules/authelia — Authelia SSO portal + OIDC provider
# Acts as OpenID Connect 1.0 provider for ArgoCD, Windmill, Harbor, etc.
# Uses file-based user database by default.
{ config, lib, charts, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.authelia;
  domain = config.openkrill.domain;
  helpers = import ../lib/helpers.nix { inherit lib; };

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
        default = "$plaintext$${config.client_id}-oidc-client-secret-${domain}";
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
      };
    };

    configMap = {
      authentication_backend = {
        file = {
          enabled = true;
          path = "/config/users.yml";
          watch = true;
        };
      };

      session = {
        cookies = cfg.sessionCookies;
      };

      storage = {
        local = {
          enabled = true;
          path = "/config/db.sqlite3";
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

      identity_providers = {
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
    # mkEnableOption defaults to false, but manifests.nix unconditionally
    # references enabledManifests.authelia for k3s bootstrap auto-deploy.
    # Must default to true so the manifest exists whenever the module is imported.
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable Authelia SSO portal + OIDC provider.";
    };

    namespace = mkOption {
      type = types.str;
      default = "authelia";
    };

    sessionCookies = mkOption {
      type = types.listOf types.attrs;
      default = [
        {
          domain = domain;
          authelia_url = "https://auth.${domain}";
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
    openkrill.apps."gateway-api".httproutes.authelia = helpers.mkHTTPRoute {
      subdomain = "auth";
      namespace = cfg.namespace;
      service = "authelia";
      port = 80;
      inherit domain;
    };

    openkrill.apps.argocd.applications.authelia = {
      namespace = "argocd";
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

    openkrill.manifests = mkMerge [
      {
        authelia.content = kubelib.fromHelm {
          name = "authelia";
          chart = charts.authelia.authelia;
          namespace = cfg.namespace;
          extraOpts = [ "--skip-schema-validation" ];
          values = recursiveUpdate defaults cfg.values;
        };
      }
      (helpers.mkExtraManifestsConfig "authelia" cfg.extraManifests)
    ];
  };
}
