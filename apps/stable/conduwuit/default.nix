# apps/conduwuit — Matrix homeserver (Conduwuit/Continuwuity/Tuwunel)
#
# Deploys a Conduwuit-family Matrix homeserver via the magikid/conduwuit
# Helm chart.  The server_name option is required — it determines the
# domain suffix on all Matrix user IDs (@user:server_name).
#
# Registration is disabled — all authentication goes through LDAP.
#
# LDAP: when lldap is enabled, the LDAP backend is auto-wired with
# ldap_only=true.  The LLDAP admin password is cross-referenced from
# the lldap generator and mounted as a file for bind_password_file.
{ config, lib, pkgs, charts, kubelib, k8s, ... }:
with lib;
let
  cfg      = config.openkrill.apps.conduwuit;
  lldapCfg = config.openkrill.apps.lldap;
  helpers  = import ../../../modules/lib/helpers.nix { inherit lib; };

  lldapEnabled = lldapCfg.enable;
in
{
  options.openkrill.apps.conduwuit = {
    enable = mkEnableOption "Conduwuit Matrix homeserver";

    namespace = mkOption {
      type = types.str;
      default = "conduwuit";
      description = "Kubernetes namespace for Conduwuit.";
    };

    serverName = mkOption {
      type = types.str;
      description = ''
        The Matrix server name.  This is the domain that appears in
        user IDs (@user:server_name).  Usually your apex domain.
      '';
      example = "example.com";
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
    # When lldap is enabled, cross-reference the LLDAP admin password
    # for the LDAP bind credential.  Registration is disabled so no
    # registration token is generated.
    openkrill.secrets.generators.conduwuit = mkIf lldapEnabled {
      packages = with pkgs; [ openssl ];
      after = [ "lldap" ];
      script = ''
        # Read LLDAP admin password for LDAP bind credential.
        LLDAP_PASS=""
        if kubectl -n "$NS" get secret openkrill-lldap >/dev/null 2>&1; then
          LLDAP_PASS=$(kubectl -n "$NS" get secret openkrill-lldap \
            -o jsonpath='{.data.LLDAP_LDAP_USER_PASS}' | base64 -d)
        fi

        create_secret openkrill-conduwuit \
          --from-literal=CONDUWUIT_LDAP_BIND_PASSWORD="''${LLDAP_PASS:-$(openssl rand -hex 16)}"
      '';
    };

    # ── ExternalSecret ───────────────────────────────────────────────
    openkrill.apps.external-secrets.secrets.conduwuit = mkIf lldapEnabled {
      namespace = cfg.namespace;
      remoteSecretName = "openkrill-conduwuit";
      keys = [ "CONDUWUIT_LDAP_BIND_PASSWORD" ];
    };

    # ── Route ────────────────────────────────────────────────────────────
    openkrill.ingress.routes.conduwuit = {
      subdomain = "matrix";
      namespace = cfg.namespace;
      service = "conduwuit";
      port = 80;
      # Matrix homeservers handle their own auth (access tokens,
      # registration tokens, etc.).  ForwardAuth (Authelia) would
      # intercept /_matrix API calls and redirect them to the SSO
      # login page, breaking all Matrix client connectivity.
      auth = "none";
    };

    # ── ArgoCD Application CR ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.conduwuit = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "conduwuit.yaml";
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

    # ── Manifests ──────────────────────────────────────────────────────
    openkrill.manifests.conduwuit.content = import ./helm.nix {
      inherit lib charts kubelib cfg lldapCfg lldapEnabled;
    };
  };
}
