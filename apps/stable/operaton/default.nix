# apps/operaton — Operaton BPMN process engine
#
# BPMN workflow automation engine (Camunda 7 fork).  Defaults to an
# embedded H2 database; set database.* values to use external PostgreSQL.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.operaton;
  helpers          = import ../../../modules/lib/helpers.nix { inherit lib; };
  defaults = {
    ingress.enabled = false;
  };
in
{
  options.openkrill.apps.operaton = {
    enable = mkEnableOption "Operaton BPMN process engine";

    namespace = mkOption {
      type = types.str;
      default = "operaton";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Route ──────────────────────────────────────────────────────
    openkrill.ingress.routes.operaton = {
      subdomain = "operaton";
      namespace = cfg.namespace;
      service = "operaton";
      port = 8080;
    };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.operaton = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "operaton.yaml";
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
    openkrill.manifests.operaton.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name = "operaton";
        chart = charts.operaton.operaton.versions."1.0.5";
        namespace = cfg.namespace;
        values = recursiveUpdate defaults cfg.values;
      };
  };
}
