# apps/kamaji-console — Kamaji Console web UI for multi-tenant control planes
{ config, lib, pkgs, charts, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.kamaji-console;
  lldapCfg = config.openkrill.apps.lldap;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  defaults = {
    credentialsSecret.nextAuthUrl = "https://${cfg.domain}/";
  };
in
{
  options.openkrill.apps.kamaji-console = {
    enable = mkEnableOption "Kamaji Console web UI";

    namespace = mkOption {
      type = types.str;
      default = "kamaji-system";
    };

    domain = mkOption {
      type = types.str;
      default = "kamaji.${config.openkrill.domain}";
      description = "FQDN for the Kamaji Console (e.g. kamaji.example.com).";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    openkrill.ingress.routes.kamaji-console = {
      subdomain = "kamaji";
      namespace = cfg.namespace;
      service = "kamaji-console";
      port = 80;
    };

    # ── Redirect / → /ui (Next.js base path) ────────────────────
    openkrill.apps."gateway-api".httproutes.kamaji-console-redirect = {
      namespace = "kube-system";
      hostnames = [ cfg.domain ];
      parentRefs = [{
        name = "main";
        namespace = "kube-system";
        sectionName = "kamaji-https";
      }];
      rules = [{
        matches = [{ path = { type = "Exact"; value = "/"; }; }];
        filters = [{
          type = "RequestRedirect";
          requestRedirect = {
            path = {
              type = "ReplaceFullPath";
              replaceFullPath = "/ui";
            };
            statusCode = 302;
          };
        }];
      }];
    };

    openkrill.apps.argo-cd.applications.kamaji-console = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "{kamaji-console.yaml,kamaji-console/*.yaml}";
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

    # ── ExternalSecret for Kamaji Console credentials ───────────────
    openkrill.apps.external-secrets.secrets.kamaji-console = {
      namespace = cfg.namespace;
      remoteSecretName = "openkrill-kamaji-console";
      keys = [
        "NEXTAUTH_URL"
        "JWT_SECRET"
        "ADMIN_EMAIL"
        "ADMIN_PASSWORD"
      ];
    };

    # ── Secret generator (reads LLDAP admin password) ─────────────
    openkrill.secrets.generators.kamaji-console = {
      packages = with pkgs; [ openssl ];
      after = [ "lldap" ];
      script = ''
        LLDAP_PASS=""
        if kubectl -n "$NS" get secret openkrill-lldap >/dev/null 2>&1; then
          LLDAP_PASS=$(kubectl -n "$NS" get secret openkrill-lldap \
            -o jsonpath='{.data.LLDAP_LDAP_USER_PASS}' | base64 -d)
        fi

        create_secret openkrill-kamaji-console \
          --from-literal=NEXTAUTH_URL="${defaults.credentialsSecret.nextAuthUrl}" \
          --from-literal=JWT_SECRET="$(openssl rand -hex 32)" \
          --from-literal=ADMIN_EMAIL="${lldapCfg.adminUser}@${config.openkrill.domain}" \
          --from-literal=ADMIN_PASSWORD="''${LLDAP_PASS:-$(openssl rand -hex 16)}"
      '';
    };

    openkrill.manifests.kamaji-console.content = let
      clusterScopedKinds = [
        "ClusterRole" "ClusterRoleBinding" "Namespace"
        "CustomResourceDefinition" "PersistentVolume"
        "StorageClass" "IngressClass" "PriorityClass"
      ];
      raw = kubelib.fromHelm {
        name = "kamaji-console";
        chart = charts.clastix.kamaji-console.latest;
        namespace = cfg.namespace;
        values = recursiveUpdate defaults cfg.values;
      };
      # The kamaji-console chart omits metadata.namespace on all
      # namespace-scoped resources, so helm template output lacks it.
      # Without explicit namespaces the k3s auto-deploy bootstrap puts
      # everything into `default`.  Inject cfg.namespace on all
      # namespace-scoped resources to ensure they land in the right place.
      ensureNs = res:
        if builtins.elem (res.kind or "") clusterScopedKinds then res
        else if (res.metadata.namespace or null) != null then res
        else res // { metadata = res.metadata // { namespace = cfg.namespace; }; };
    in map ensureNs raw;
  };
}
