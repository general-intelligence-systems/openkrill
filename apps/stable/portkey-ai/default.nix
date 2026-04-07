# apps/portkey-ai — Portkey AI gateway and platform
#
# Portkey provides an AI gateway proxy (OpenAI-compatible) and an optional
# full platform dashboard.  Two separate Helm charts from portkey-ai:
#   - gateway: open-source AI gateway proxy
#   - app: full Portkey platform with UI/dashboard
#
# Both are gated behind their own enable flags so consumers can deploy
# either or both independently.
{ config, lib, pkgs, charts, kubelib, k8s, ... }:
with lib;
let
  cfg     = config.openkrill.apps.portkey-ai;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  domain  = config.openkrill.domain;

  clusterScopedKinds = [
    "ClusterRole" "ClusterRoleBinding" "Namespace"
    "CustomResourceDefinition" "PersistentVolume"
    "StorageClass" "IngressClass" "PriorityClass"
  ];

  ensureNs = namespace: res:
    if builtins.elem (res.kind or "") clusterScopedKinds then res
    else if (res.metadata.namespace or null) != null then res
    else res // { metadata = res.metadata // { namespace = namespace; }; };

  # ── Gateway chart ────────────────────────────────────────────────
  gatewayDefaults = {
    ingress.enabled = false;
  };

  gatewayRaw = kubelib.fromHelm {
    name      = "portkey-gateway";
    chart     = charts.portkey-ai.gateway.latest;
    namespace = cfg.gateway.namespace;
    values    = recursiveUpdate gatewayDefaults cfg.gateway.values;
  };

  # ── App chart ────────────────────────────────────────────────────
  appDefaults = {
    ingress.enabled = false;
  };

  appRaw = kubelib.fromHelm {
    name      = "portkey-app";
    chart     = charts.portkey-ai.app.latest;
    namespace = cfg.app.namespace;
    values    = recursiveUpdate appDefaults cfg.app.values;
  };
in
{
  options.openkrill.apps.portkey-ai = {
    gateway = {
      enable = mkEnableOption "Portkey AI Gateway";

      namespace = mkOption {
        type = types.str;
        default = "portkey-ai";
        description = "Kubernetes namespace for the Portkey Gateway.";
      };

      domain = mkOption {
        type = types.str;
        default = "portkey-gw.${domain}";
        description = "FQDN for the Portkey Gateway.";
      };

      values = mkOption {
        type = types.attrs;
        default = {};
        description = "Helm chart value overrides for the gateway chart, deep-merged with module defaults.";
      };
    };

    app = {
      enable = mkEnableOption "Portkey AI Platform";

      namespace = mkOption {
        type = types.str;
        default = "portkey-ai";
        description = "Kubernetes namespace for the Portkey Platform.";
      };

      domain = mkOption {
        type = types.str;
        default = "portkey.${domain}";
        description = "FQDN for the Portkey Platform.";
      };

      values = mkOption {
        type = types.attrs;
        default = {};
        description = "Helm chart value overrides for the app chart, deep-merged with module defaults.";
      };
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkMerge [
    # ── Gateway ────────────────────────────────────────────────────
    (mkIf cfg.gateway.enable {
      openkrill.ingress.routes.portkey-gateway = {
        subdomain = "portkey-gw";
        namespace = cfg.gateway.namespace;
        service   = "portkey-gateway";
        port      = 8787;
        auth      = "none";
      };

      openkrill.apps.argo-cd.applications.portkey-gateway = mkIf config.openkrill.gitops.generateApplications {
        namespace = "argo-cd";
        project   = "default";
        source = {
          repoURL        = config.openkrill.gitops.repoURL;
          targetRevision = "rendered-manifests";
          path           = ".";
          directory.include = "portkey-gateway.yaml";
        };
        destination = {
          server    = "https://kubernetes.default.svc";
          namespace = cfg.gateway.namespace;
        };
        syncPolicy = {
          automated   = { prune = true; selfHeal = true; };
          syncOptions = [ "CreateNamespace=true" ];
        };
      };

      openkrill.manifests.portkey-gateway.content =
        [ (k8s.mkNamespace cfg.gateway.namespace) ]
        ++ map (ensureNs cfg.gateway.namespace) gatewayRaw;
    })

    # ── App ────────────────────────────────────────────────────────
    (mkIf cfg.app.enable {
      openkrill.ingress.routes.portkey-app = {
        subdomain = "portkey";
        namespace = cfg.app.namespace;
        service   = "portkey-app";
        port      = 8080;
      };

      openkrill.apps.argo-cd.applications.portkey-app = mkIf config.openkrill.gitops.generateApplications {
        namespace = "argo-cd";
        project   = "default";
        source = {
          repoURL        = config.openkrill.gitops.repoURL;
          targetRevision = "rendered-manifests";
          path           = ".";
          directory.include = "portkey-app.yaml";
        };
        destination = {
          server    = "https://kubernetes.default.svc";
          namespace = cfg.app.namespace;
        };
        syncPolicy = {
          automated   = { prune = true; selfHeal = true; };
          syncOptions = [ "CreateNamespace=true" ];
        };
      };

      openkrill.manifests.portkey-app.content =
        [ (k8s.mkNamespace cfg.app.namespace) ]
        ++ map (ensureNs cfg.app.namespace) appRaw;
    })
  ];
}
