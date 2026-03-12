# apps/kubero — Kubero PaaS UI
#
# Self-hosted Platform-as-a-Service (Heroku alternative) running on
# Kubernetes.  Deploys the Kubero UI and its operator-managed resources.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.kubero;
  helpers          = import ../../modules/lib/helpers.nix { inherit lib; };
  networkPolicyLib = import ../../modules/lib/network-policy.nix { inherit lib; };
in
{
  options.openkrill.apps.kubero = {
    enable = mkEnableOption "Kubero PaaS";

    namespace = mkOption {
      type = types.str;
      default = "kubero";
    };

    networkPolicy = networkPolicyLib.mkNetworkPolicyOption;
    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    openkrill.apps.kubero.networkPolicy = {
      ingress = [
        { from = "traefik"; ports = [{ port = 2000; }]; }
      ];
      egress = [
        { to = "kubernetes-api"; }
        { to = "world"; ports = [{ port = 443; }]; }
        { to = "dns"; }
      ];
    };

    # ── Route ──────────────────────────────────────────────────────
    openkrill.ingress.routes.kubero = {
      subdomain = "kubero";
      namespace = cfg.namespace;
      service = "kubero";
      port = 2000;
    };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argocd.applications.kubero = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "kubero.yaml";
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
    openkrill.manifests.kubero.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name = "kubero";
        chart = charts.general-intelligence-systems.kubero;
        namespace = cfg.namespace;
        values = {};
      };
  };
}
