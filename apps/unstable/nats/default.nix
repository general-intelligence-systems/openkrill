# apps/unstable/nats — Bitnami nats
{
  config,
  lib,
  charts,
  kubelib,
  k8s,
  ...
}:
with lib;
let
  cfg = config.openkrill.apps.nats;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  imports = [ ./custom.nix ];

  options.openkrill.apps.nats = {
    enable = mkEnableOption "Bitnami nats";

    namespace = mkOption {
      type = types.str;
      default = "nats";
    };

    values = mkOption {
      type = types.submodule (import ./values.nix);
      default = { };
      description = "Helm chart values. Schema-derived defaults are set automatically.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Route ──────────────────────────────────────────────────────
    # openkrill.ingress.routes.nats = {
    #   subdomain = "nats";
    #   namespace = cfg.namespace;
    #   service = "nats";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.nats = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "nats.yaml";
      };
      destination = {
        server = "https://kubernetes.default.svc";
        namespace = cfg.namespace;
      };
      syncPolicy = {
        automated = {
          prune = true;
          selfHeal = true;
        };
        syncOptions = [ "CreateNamespace=true" ];
      };
    };

    # ── Manifests ───────────────────────────────────────────────────
    openkrill.manifests.nats.content = [
      (k8s.mkNamespace cfg.namespace)
    ]
    ++ kubelib.fromHelm {
      name = "nats";
      chart = charts.bitnami.nats.latest;
      namespace = cfg.namespace;
      values = cfg.values;
    };
  };
}
