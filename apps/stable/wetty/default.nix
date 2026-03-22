# apps/wetty — Web-based terminal over HTTP/HTTPS
#
# Deploys Wetty, a web-based terminal emulator, using the bjw-s
# app-template Helm chart (Pattern 6).
#
# Wetty exposes an SSH terminal session in the browser over
# WebSockets.  It listens on port 3000 by default.
{ config, lib, pkgs, charts, kubelib, k8s, ... }:
with lib;
let
  cfg     = config.openkrill.apps.wetty;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  appTemplate = import ../../../modules/lib/app-template.nix { inherit lib; };

  # appTemplate.valuesType fills unset options with null defaults.
  # recursiveUpdate treats null as a leaf, so cfg.values.global = null
  # would stomp defaults.global.  Strip nulls before merging.
  removeNulls = attrs:
    filterAttrs (_: v: v != null) (mapAttrs (_: v:
      if isAttrs v then removeNulls v else v
    ) attrs);

  defaults = {
    global.nameOverride = "wetty";

    controllers.main = {
      strategy = "Recreate";

      containers.main = {
        image = {
          repository = "ghcr.io/butlerx/wetty";
          tag = "sha-d9fb163";
        };

        probes = {
          liveness = {
            enabled = true;
            custom = true;
            spec = {
              httpGet = { path = "/wetty/"; port = 3000; };
              initialDelaySeconds = 10;
              periodSeconds = 15;
              failureThreshold = 3;
            };
          };
          readiness = {
            enabled = true;
            custom = true;
            spec = {
              httpGet = { path = "/wetty/"; port = 3000; };
              initialDelaySeconds = 5;
              periodSeconds = 10;
            };
          };
          startup = {
            enabled = true;
            custom = true;
            spec = {
              httpGet = { path = "/wetty/"; port = 3000; };
              initialDelaySeconds = 5;
              periodSeconds = 5;
              failureThreshold = 10;
            };
          };
        };

        resources = {
          requests = { cpu = "50m"; memory = "64Mi"; };
          limits   = { memory = "256Mi"; };
        };
      };
    };

    service.main = {
      controller = "main";
      ports.http = {
        port = 3000;
        protocol = "HTTP";
      };
    };
  };
in
{
  options.openkrill.apps.wetty = {
    enable = mkEnableOption "Wetty web-based terminal";

    namespace = mkOption {
      type = types.str;
      default = "wetty";
      description = "Kubernetes namespace for Wetty.";
    };

    values = mkOption {
      type = appTemplate.valuesType;
      default = {};
      description = "app-template Helm chart values (typed), deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # -- Route ---------------------------------------------------------------
    openkrill.ingress.routes.wetty = {
      subdomain = "wetty";
      namespace = cfg.namespace;
      service   = "wetty";
      port      = 3000;
    };

    # -- ArgoCD Application CR -----------------------------------------------
    openkrill.apps.argo-cd.applications.wetty = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project   = "default";
      source = {
        repoURL          = config.openkrill.gitops.repoURL;
        targetRevision   = "rendered-manifests";
        path             = ".";
        directory.include = "wetty.yaml";
      };
      destination = {
        server    = "https://kubernetes.default.svc";
        namespace = cfg.namespace;
      };
      syncPolicy = {
        automated   = { prune = true; selfHeal = true; };
        syncOptions = [ "CreateNamespace=true" ];
      };
    };

    # -- Manifests -----------------------------------------------------------
    openkrill.manifests.wetty.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name      = "wetty";
        chart     = charts.bjw-s-labs.app-template.versions."4.6.2";
        namespace = cfg.namespace;
        values    = recursiveUpdate defaults (removeNulls cfg.values);
        extraOpts = [ "--skip-schema-validation" ];
      };
  };
}
