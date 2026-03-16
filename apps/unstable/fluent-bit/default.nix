# apps/unstable/fluent-bit — Bitnami fluent-bit
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
  cfg = config.openkrill.apps.fluent-bit;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  imports = [ ./custom.nix ];

  options.openkrill.apps.fluent-bit = {
    enable = mkEnableOption "Bitnami fluent-bit";

    namespace = mkOption {
      type = types.str;
      default = "fluent-bit";
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
    # openkrill.ingress.routes.fluent-bit = {
    #   subdomain = "fluent-bit";
    #   namespace = cfg.namespace;
    #   service = "fluent-bit";
    #   port = 8080;
    # };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.fluent-bit = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "fluent-bit.yaml";
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
    openkrill.manifests.fluent-bit.content = [
      (k8s.mkNamespace cfg.namespace)
    ]
    ++ kubelib.fromHelm {
      name = "fluent-bit";
      chart = charts.bitnami.fluent-bit.latest;
      namespace = cfg.namespace;
      values = cfg.values;
    };
  };
}
