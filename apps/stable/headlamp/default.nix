# apps/stable/headlamp — Headlamp Kubernetes web UI
#
# Headlamp is a Kubernetes dashboard from the kubernetes-sigs project.
# Uses the official kubernetes-sigs/headlamp Helm chart from nixhelm2.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.headlamp;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  domain = config.openkrill.domain;

  defaults = {
    # Disable built-in ingress — we use openkrill ingress routes
    ingress.enabled = false;
  };
in
{
  options.openkrill.apps.headlamp = {
    enable = mkEnableOption "Headlamp Kubernetes web UI";

    namespace = mkOption {
      type = types.str;
      default = "headlamp";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Route ───────────────────────────────────────────────────────
    openkrill.ingress.routes.headlamp = {
      subdomain = "headlamp";
      namespace = cfg.namespace;
      service = "headlamp";
      port = 80;
    };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.headlamp = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "headlamp.yaml";
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
    openkrill.manifests.headlamp.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name = "headlamp";
        chart = charts.kubernetes-sigs.headlamp.versions."0.41.0";
        namespace = cfg.namespace;
        values = recursiveUpdate defaults cfg.values;
      };
  };
}
