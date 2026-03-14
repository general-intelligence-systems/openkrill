# apps/kubero — Kubero PaaS UI
#
# Self-hosted Platform-as-a-Service (Heroku alternative) running on
# Kubernetes.  Deploys the Kubero UI and its operator-managed resources.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.kubero;
  helpers          = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  imports = [
    ./kuberoaddonmemcacheds.nix
    ./kuberoaddonmongodbs.nix
    ./kuberoaddonmysqls.nix
    ./kuberoaddonpostgres.nix
    ./kuberoaddonrabbitmqs.nix
    ./kuberoaddonredis.nix
    ./kuberoapps.nix
    ./kuberobuilds.nix
    ./kuberocouchdbs.nix
    ./kuberoelasticsearches.nix
    ./kuberoes.nix
    ./kuberokafkas.nix
    ./kuberomails.nix
    ./kuberomemcacheds.nix
    ./kuberomongodbs.nix
    ./kuberomysqls.nix
    ./kuberopipelines.nix
    ./kuberopostgresqls.nix
    ./kuberoprometheuses.nix
    ./kuberorabbitmqs.nix
    ./kuberoredis.nix
  ];

  options.openkrill.apps.kubero = {
    enable = mkEnableOption "Kubero PaaS";

    namespace = mkOption {
      type = types.str;
      default = "kubero";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Route ──────────────────────────────────────────────────────
    openkrill.ingress.routes.kubero = {
      subdomain = "kubero";
      namespace = cfg.namespace;
      service = "kubero";
      port = 2000;
    };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.kubero = {
      namespace = "argo-cd";
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
        syncOptions = [ "CreateNamespace=true" "ServerSideApply=true" ];
      };
    };

    # ── Manifests ───────────────────────────────────────────────────
    openkrill.manifests.kubero.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name = "kubero";
        chart = charts.general-intelligence-systems.kubero.latest;
        namespace = cfg.namespace;
        values = {};
      };
  };
}
