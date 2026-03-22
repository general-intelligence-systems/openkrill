# apps/docker-registry — In-cluster Docker Distribution (registry:2)
#
# Deploys a private container registry inside the cluster using the
# Docker Distribution v2 image.  Uses the bjw-s app-template Helm
# chart (Pattern 6) since there is no official Helm chart.
#
# The registry listens on port 5000 and stores images in a persistent
# volume.  It is intended for cluster-internal use — workloads pull
# images via the in-cluster Service address:
#
#   registry.docker-registry.svc.cluster.local:5000
#
# No TLS or authentication is configured by default; the registry
# runs plain HTTP on the pod network, which is acceptable for an
# in-cluster-only registry.  Consumers that need TLS should layer it
# via ingress or set registry environment variables through `values`.
{ config, lib, pkgs, charts, kubelib, k8s, ... }:
with lib;
let
  cfg     = config.openkrill.apps.docker-registry;
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
    global.nameOverride = "docker-registry";

    controllers.main = {
      strategy = "Recreate";

      containers.main = {
        image = {
          repository = "registry";
          tag = "2";
        };

        env = {
          # Store images under /var/lib/registry (the PV mount point).
          REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY = "/var/lib/registry";
        };

        probes = {
          liveness = {
            enabled = true;
            custom = true;
            spec = {
              httpGet = { path = "/v2/"; port = 5000; };
              initialDelaySeconds = 10;
              periodSeconds = 15;
              failureThreshold = 3;
            };
          };
          readiness = {
            enabled = true;
            custom = true;
            spec = {
              httpGet = { path = "/v2/"; port = 5000; };
              initialDelaySeconds = 5;
              periodSeconds = 10;
            };
          };
          startup = {
            enabled = true;
            custom = true;
            spec = {
              httpGet = { path = "/v2/"; port = 5000; };
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

    persistence.data = {
      type = "persistentVolumeClaim";
      storageClass = "local-path";
      accessMode = "ReadWriteOnce";
      size = "20Gi";
      advancedMounts.main.main = [
        { path = "/var/lib/registry"; }
      ];
    };

    service.main = {
      controller = "main";
      ports.http = {
        port = 5000;
        protocol = "HTTP";
      };
    };
  };
in
{
  options.openkrill.apps.docker-registry = {
    enable = mkEnableOption "In-cluster Docker registry (registry:2)";

    namespace = mkOption {
      type = types.str;
      default = "docker-registry";
      description = "Kubernetes namespace for the registry.";
    };

    storageSize = mkOption {
      type = types.str;
      default = "20Gi";
      description = "Size of the PersistentVolumeClaim for image storage.";
    };

    values = mkOption {
      type = appTemplate.valuesType;
      default = {};
      description = "app-template Helm chart values (typed), deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Route ─────────────────────────────────────────────────────
    openkrill.ingress.routes.docker-registry = {
      subdomain = "registry";
      namespace = cfg.namespace;
      service   = "docker-registry";
      port      = 5000;
      auth      = "none";  # containerd pulls with TLS — no ForwardAuth
    };

    # ── ArgoCD Application CR ─────────────────────────────────────
    openkrill.apps.argo-cd.applications.docker-registry = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project   = "default";
      source = {
        repoURL          = config.openkrill.gitops.repoURL;
        targetRevision   = "rendered-manifests";
        path             = ".";
        directory.include = "docker-registry.yaml";
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

    # ── Manifests ─────────────────────────────────────────────────
    openkrill.manifests.docker-registry.content =
      let
        # Apply storageSize override to defaults before merging.
        effectiveDefaults = recursiveUpdate defaults {
          persistence.data.size = cfg.storageSize;
        };
      in
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name      = "docker-registry";
        chart     = charts.bjw-s-labs.app-template.versions."4.6.2";
        namespace = cfg.namespace;
        values    = recursiveUpdate effectiveDefaults (removeNulls cfg.values);
        extraOpts = [ "--skip-schema-validation" ];
      };
  };
}
