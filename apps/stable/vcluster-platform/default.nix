# apps/stable/vcluster-platform — Loft vCluster Platform
#
# Deploys Loft's vCluster Platform for managing virtual Kubernetes
# clusters with multi-tenancy, sleep mode, and cost optimization features.
#
# Admin password is cross-referenced from the LLDAP secret so the admin
# account uses the same credentials as the LLDAP admin user.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.vcluster-platform;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  lldapCfg = config.openkrill.apps.lldap;
  domain = config.openkrill.domain;

  hostname = "${cfg.subdomain}.${domain}";

  # Name of the ESO-synced secret containing the LLDAP admin password.
  lldapSecretName = "lldap-admin";

  defaults = {
    # Disable the built-in ingress — we use the openkrill ingress module.
    ingress.enabled = false;

    admin.create = true;
    admin.username = lldapCfg.adminUser;
    # "$" prefix tells the chart to use ADMIN_PASSWORD_ENV (runtime env var)
    # instead of hashing the value at template time.
    admin.password = "$LLDAP_PASSWORD";

    # Inject the LLDAP password from the synced secret at runtime.
    envValueFrom.LLDAP_PASSWORD = {
      secretKeyRef = {
        name = lldapSecretName;
        key  = "LLDAP_LDAP_USER_PASS";
      };
    };

    config = {
      audit.enabled = true;
    };
  };
in
{
  options.openkrill.apps.vcluster-platform = {
    enable = mkEnableOption "vCluster Platform for managing virtual Kubernetes clusters";

    subdomain = mkOption {
      type = types.str;
      default = "vcluster";
      description = "Subdomain for the vCluster Platform UI (e.g., vcluster.cia.net).";
    };

    namespace = mkOption {
      type = types.str;
      default = "vcluster-platform";
      description = "Kubernetes namespace for vcluster-platform resources.";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Ingress Route ───────────────────────────────────────────────
    openkrill.ingress.routes.vcluster-platform = {
      subdomain = cfg.subdomain;
      namespace = cfg.namespace;
      service   = "loft";
      port      = 80;
    };

    # ── Authelia OIDC Client Registration ───────────────────────────
    openkrill.apps.authelia.oidcClients = [
      {
        name = "vCluster Platform";
        redirect_uris = [ "https://${hostname}/auth/oidc/callback" ];
        scopes = [ "openid" "profile" "email" "groups" ];
      }
    ];

    # ── ExternalSecret for LLDAP admin password ─────────────────────
    openkrill.apps.external-secrets.secrets.${lldapSecretName} = {
      namespace = cfg.namespace;
      remoteSecretName = "openkrill-lldap";
      keys = [ "LLDAP_LDAP_USER_PASS" ];
    };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.vcluster-platform = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "vcluster-platform.yaml";
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

    # ── Manifests ───────────────────────────────────────────────────
    openkrill.manifests.vcluster-platform.content = [
      (k8s.mkNamespace cfg.namespace)
    ]
    ++ kubelib.fromHelm {
      name = "vcluster-platform";
      chart = charts.loft.vcluster-platform.versions."4.8.1";
      namespace = cfg.namespace;
      values = recursiveUpdate defaults cfg.values;
    };
  };
}
