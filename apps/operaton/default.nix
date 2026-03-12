# apps/operaton — Operaton BPMN process engine
#
# BPMN workflow automation engine (Camunda 7 fork).  Defaults to an
# embedded H2 database; set database.* values to use external PostgreSQL.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.operaton;
  helpers          = import ../../modules/lib/helpers.nix { inherit lib; };
  networkPolicyLib = import ../../modules/lib/network-policy.nix { inherit lib; };
  domain = config.openkrill.domain;

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

    networkPolicy = networkPolicyLib.mkNetworkPolicyOption;
    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    openkrill.apps.operaton.networkPolicy = {
      ingress = [
        { from = "traefik"; ports = [{ port = 8080; }]; }
      ];
      egress = [
        { to = "kubernetes-api"; }
        { to = "world"; ports = [{ port = 443; }]; }
        { to = "dns"; }
      ];
    };

    # ── Gateway API HTTPRoute ───────────────────────────────────────
    openkrill.apps."gateway-api".httproutes.operaton = helpers.mkHTTPRoute {
      subdomain = "operaton";
      namespace = cfg.namespace;
      service = "operaton";
      port = 8080;
      inherit domain;
    };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argocd.applications.operaton = {
      namespace = "argocd";
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
        chart = charts.operaton.operaton;
        namespace = cfg.namespace;
        values = recursiveUpdate defaults cfg.values;
      };
  };
}
