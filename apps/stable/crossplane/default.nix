# apps/stable/crossplane — Crossplane universal control plane
#
# Crossplane extends Kubernetes to manage infrastructure and services
# via custom resources. Uses the official crossplane Helm chart from nixhelm2.
# No ingress route — Crossplane is a cluster-level operator with no web UI.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.crossplane;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };

  clusterScopedKinds = [
    "ClusterRole"
    "ClusterRoleBinding"
    "MutatingWebhookConfiguration"
    "ValidatingWebhookConfiguration"
    "CustomResourceDefinition"
  ];
in
{
  imports = [ ./provider-opentofu.nix ];

  options.openkrill.apps.crossplane = {
    enable = mkEnableOption "Crossplane universal control plane";

    namespace = mkOption {
      type = types.str;
      default = "crossplane-system";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    providers = mkOption {
      type = types.attrsOf (types.submodule {
        options = {
          package = mkOption {
            type = types.str;
            description = "OCI package reference for the Crossplane provider.";
            example = "xpkg.upbound.io/upbound/provider-opentofu:v1.1.1";
          };
          config = mkOption {
            type = types.listOf types.attrs;
            default = [];
            description = "Additional raw K8s resources to deploy alongside the Provider (e.g. ProviderConfig).";
          };
        };
      });
      default = {};
      description = "Crossplane providers to install.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.crossplane = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "crossplane.yaml";
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
    openkrill.manifests.crossplane.content =
      let
        raw = kubelib.fromHelm {
          name = "crossplane";
          chart = charts.crossplane.crossplane.versions."2.2.0";
          namespace = cfg.namespace;
          values = cfg.values;
        };
        ensureNs = res:
          if builtins.elem (res.kind or "") clusterScopedKinds
          then res
          else res // { metadata = (res.metadata or {}) // { namespace = cfg.namespace; }; };

        # Generate a Provider CR for each entry in cfg.providers
        providerCRs = mapAttrsToList (name: prov: {
          apiVersion = "pkg.crossplane.io/v1";
          kind = "Provider";
          metadata = { inherit name; };
          spec = { inherit (prov) package; };
        }) cfg.providers;

        # Collect all raw config resources across providers
        providerConfigs = concatMap (prov: prov.config) (attrValues cfg.providers);
      in
      [ (k8s.mkNamespace cfg.namespace) ] ++ map ensureNs raw ++ providerCRs ++ providerConfigs;
  };
}
