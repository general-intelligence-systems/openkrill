# apps/code-server — VS Code in the browser
#
# Browser-based VS Code IDE backed by code-server.
#
# Dev-ports feature: when devPorts is non-empty, each port N gets:
#   - An ingress route at N.<domain> forwarding to code-server-port-N:N
#   - A K8s Service "code-server-port-N" selecting the code-server pod
# This lets you access dev servers (e.g. vite on 5173) from the browser.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.code-server;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  domain  = config.openkrill.domain;

  clusterScopedKinds = [
    "ClusterRole" "ClusterRoleBinding" "Namespace"
    "CustomResourceDefinition" "PersistentVolume"
    "StorageClass" "IngressClass" "PriorityClass"
  ];

  # ── Host mounts (docker socket, nix store) ────────────────────────────
  extraMounts =
    (optionals (cfg.docker.mode == "host") [{
      name      = "docker-sock";
      mountPath = "/var/run/docker.sock";
      readOnly  = false;
      hostPath  = "/var/run/docker.sock";
    }])
    ++ (optionals cfg.nixStore.enable [{
      name      = "nix";
      mountPath = "/nix";
      readOnly  = false;
      hostPath  = cfg.nixStore.hostPath;
    }]);

  hostMountValues = optionalAttrs (extraMounts != []) {
    extraVolumeMounts = extraMounts;
  };

  # ── DinD sidecar ─────────────────────────────────────────────────────
  dindValues = optionalAttrs (cfg.docker.mode == "dind") {
    extraContainers = builtins.toJSON [
      {
        name  = "docker-dind";
        image = cfg.docker.dind.image;
        imagePullPolicy = "IfNotPresent";
        securityContext.privileged = true;
        env = [{ name = "DOCKER_TLS_CERTDIR"; value = ""; }];
        command = [
          "dockerd"
          "--host=unix:///var/run/docker.sock"
          "--host=tcp://0.0.0.0:2376"
        ];
      }
    ];
    extraVars = [
      { name = "DOCKER_HOST"; value = "tcp://localhost:2376"; }
    ];
  };

  # ── Post-process: inject supplementalGroups for host docker GID ──────
  patchPodSpec = res:
    if cfg.docker.mode == "host" && (res.kind or "") == "Deployment" then
      recursiveUpdate res {
        spec.template.spec.securityContext.supplementalGroups = [ cfg.docker.hostGroupID ];
      }
    else res;

  # ── Host aliases — derived from config.networking.extraHosts ─────
  lines = filter (l: l != "") (splitString "\n" config.networking.extraHosts);
  parseLine = line: let
    parts = filter (p: p != "") (splitString " " line);
  in {
    ip        = head parts;
    hostnames = tail parts;
  };
  hostAliases = map parseLine lines;

  defaults = {
    image = {
      repository = "ghcr.io/general-intelligence-systems/code-server-nix";
      tag        = "latest";
      pullPolicy = "Always";
    };
    ingress.enabled = false;
    extraArgs = [ "--auth" "none" ];
    hostAliases = hostAliases;
    persistence = {
      enabled      = true;
      size         = cfg.persistence.size;
      storageClass = cfg.persistence.storageClass;
    };
  };

  raw = kubelib.fromHelm {
    name      = "code-server";
    chart     = charts.general-intelligence-systems.code-server.latest;
    namespace = cfg.namespace;
    values    = foldl' recursiveUpdate defaults [ hostMountValues dindValues cfg.values ];
  };

  # ── Fix hostPath type for docker-sock volume ───────────────────────
  # The upstream chart hardcodes `type: Directory` for all extraVolumeMounts
  # hostPath volumes, but docker.sock is a Unix socket and needs `type: Socket`.
  fixDockerSockVolume = vol:
    if vol.name or "" == "docker-sock" && vol ? hostPath then
      vol // { hostPath = vol.hostPath // { type = "Socket"; }; }
    else
      vol;

  fixVolumes = res:
    if (res.kind or "") == "Deployment"
       && (res.spec.template.spec.volumes or null) != null then
      res // {
        spec = res.spec // {
          template = res.spec.template // {
            spec = res.spec.template.spec // {
              volumes = map fixDockerSockVolume res.spec.template.spec.volumes;
            };
          };
        };
      }
    else res;

  ensureNs = res:
    if builtins.elem (res.kind or "") clusterScopedKinds then res
    else if (res.metadata.namespace or null) != null then res
    else res // { metadata = res.metadata // { namespace = cfg.namespace; }; };

  # ── Dev-ports helpers ────────────────────────────────────────────
  # Build a K8s Service for a single dev port, selecting the code-server pod.
  mkDevPortService = port: {
    apiVersion = "v1";
    kind = "Service";
    metadata = {
      name = "code-server-port-${toString port}";
      namespace = cfg.namespace;
      labels = {
        "app.kubernetes.io/name" = "code-server";
        "app.kubernetes.io/component" = "dev-port";
      };
    };
    spec = {
      selector = {
        "app.kubernetes.io/name" = "code-server";
      };
      ports = [{
        name = "dev-${toString port}";
        port = port;
        targetPort = port;
        protocol = "TCP";
      }];
    };
  };

  devPortServices = map mkDevPortService cfg.devPorts;

  # Build ingress route attrs for all dev ports.
  # Each port N becomes route "code-server-dev-N" with subdomain "N".
  devPortRoutes = listToAttrs (map (port: {
    name = "code-server-dev-${toString port}";
    value = {
      subdomain = toString port;
      namespace = cfg.namespace;
      service   = "code-server-port-${toString port}";
      inherit port;
      auth = "forward";
    };
  }) cfg.devPorts);
in
{
  options.openkrill.apps.code-server = {
    enable = mkEnableOption "code-server (VS Code in the browser)";

    namespace = mkOption {
      type = types.str;
      default = "code-server";
    };

    domain = mkOption {
      type = types.str;
      default = "code.${domain}";
      description = "FQDN for the code-server instance.";
    };

    persistence.size = mkOption {
      type = types.str;
      default = "10Gi";
    };

    persistence.storageClass = mkOption {
      type = types.str;
      default = "local-path";
    };

    docker.mode = mkOption {
      type = types.enum [ "none" "host" "dind" ];
      default = "none";
      description = ''
        Docker integration mode:
        - "none" — no Docker access (default).
        - "host" — mount the host's Docker socket (/var/run/docker.sock).
        - "dind" — run a Docker-in-Docker sidecar container.
      '';
    };

    docker.hostGroupID = mkOption {
      type = types.int;
      default = 131;
      description = "GID of the docker group on the host (only used when docker.mode = \"host\").";
    };

    docker.dind.image = mkOption {
      type = types.str;
      default = "docker:dind";
      description = "Container image for the DinD sidecar (only used when docker.mode = \"dind\").";
    };

    nixStore.enable = mkEnableOption "persist /nix to a host directory";

    nixStore.hostPath = mkOption {
      type = types.str;
      default = "/var/lib/rancher/k3s/storage/code-server-nix";
      description = "Host directory to mount at /nix inside the container.";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    devPorts = mkOption {
      type = with types; listOf port;
      default = import ./dev-ports.nix;
      description = ''
        List of TCP ports to expose as dev-port subdomains.
        Each port N gets a route at N.<domain> that forwards to
        the code-server pod on port N.
      '';
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Route ──────────────────────────────────────────────────────
    openkrill.ingress.routes = {
      code-server = {
        subdomain = "code";
        namespace = cfg.namespace;
        service   = "code-server";
        port      = 8080;
      };
    } // devPortRoutes;

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.code-server = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project   = "default";
      source = {
        repoURL        = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path           = ".";
        directory.include = "code-server.yaml";
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

    # ── Manifests ───────────────────────────────────────────────────
    openkrill.manifests.code-server.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ map (res: patchPodSpec (fixVolumes (ensureNs res))) raw
      ++ devPortServices;
  };
}
