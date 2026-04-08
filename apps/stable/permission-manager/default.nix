# apps/stable/permission-manager — Kubernetes RBAC management UI
#
# Permission Manager provides a web interface to manage RBAC permissions
# for Kubernetes users and groups. Uses the official sighupio Helm chart
# from nixhelm2.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.permission-manager;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  domain = config.openkrill.domain;
in
{
  options.openkrill.apps.permission-manager = {
    enable = mkEnableOption "Permission Manager Kubernetes RBAC UI";

    namespace = mkOption {
      type = types.str;
      default = "permission-manager";
    };

    domain = mkOption {
      type = types.str;
      default = "permission-manager.${domain}";
      description = "FQDN for the Permission Manager web UI.";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Ingress route ──────────────────────────────────────────────
    openkrill.ingress.routes.permission-manager = {
      subdomain = "permission-manager";
      namespace = cfg.namespace;
      service = "permission-manager";
      port = 3000;
    };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.permission-manager = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "permission-manager.yaml";
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
    openkrill.manifests.permission-manager.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name = "permission-manager";
        chart = charts.permission-manager.permission-manager.versions."0.1.1";
        namespace = cfg.namespace;
        values = recursiveUpdate {
          image.tag = "v1.9.0";
        } cfg.values;
      };
  };
}
