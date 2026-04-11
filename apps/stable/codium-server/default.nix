# apps/codium-server — VSCodium in the browser
#
# Browser-based VSCodium IDE via `codium serve-web`.
# Simple Deployment + Service with hostPath mounts. No Helm chart.
#
# Dev-ports feature: when devPorts is non-empty, each port N gets:
#   - An ingress route at N.<domain> forwarding to codium-server-port-N:N
#   - A K8s Service "codium-server-port-N" selecting the codium-server pod
# This lets you access dev servers (e.g. vite on 5173) from the browser.
{ config, lib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.codium-server;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  domain  = config.openkrill.domain;

  labels = {
    "app.kubernetes.io/name" = "codium-server";
  };

  # ── Host aliases — derived from config.networking.extraHosts ─────
  # Group hostnames by IP to avoid duplicate hostAliases entries (K8s rejects them).
  lines = filter (l: l != "") (splitString "\n" config.networking.extraHosts);
  parseLine = line: let
    parts = filter (p: p != "") (splitString " " line);
  in {
    ip        = head parts;
    hostnames = tail parts;
  };
  parsed = map parseLine lines;
  grouped = foldl' (acc: entry:
    acc // {
      ${entry.ip} = {
        ip = entry.ip;
        hostnames = (acc.${entry.ip}.hostnames or []) ++ entry.hostnames;
      };
    }
  ) {} parsed;
  hostAliases = attrValues grouped;

  # ── Volumes & mounts ────────────────────────────────────────────────
  volumes = [
    {
      name = "home";
      hostPath = { path = cfg.persistence.hostPath; type = "DirectoryOrCreate"; };
    }
  ]
  ++ optionals cfg.nixStore.enable [
    {
      name = "nix";
      hostPath = { path = cfg.nixStore.hostPath; type = "DirectoryOrCreate"; };
    }
  ]
  ++ optionals (cfg.docker.mode == "host") [
    {
      name = "docker-sock";
      hostPath = { path = "/var/run/docker.sock"; type = "Socket"; };
    }
  ];

  volumeMounts = [
    { name = "home"; mountPath = "/home/coder"; }
  ]
  ++ optionals cfg.nixStore.enable [
    { name = "nix"; mountPath = "/nix"; }
  ]
  ++ optionals (cfg.docker.mode == "host") [
    { name = "docker-sock"; mountPath = "/var/run/docker.sock"; }
  ];

  # ── Environment variables ───────────────────────────────────────────
  env = optionals (cfg.docker.mode == "dind") [
    { name = "DOCKER_HOST"; value = "tcp://localhost:2376"; }
  ];

  # ── DinD sidecar container ─────────────────────────────────────────
  dindContainers = optionals (cfg.docker.mode == "dind") [
    {
      name = "docker-dind";
      image = cfg.docker.dind.image;
      imagePullPolicy = "IfNotPresent";
      securityContext.privileged = true;
      env = [
        { name = "DOCKER_TLS_CERTDIR"; value = ""; }
      ];
      command = [
        "dockerd"
        "--host=unix:///var/run/docker.sock"
        "--host=tcp://0.0.0.0:2376"
      ];
    }
  ];

  # ── Security context ────────────────────────────────────────────────
  podSecurityContext = optionalAttrs (cfg.docker.mode == "host") {
    supplementalGroups = [ cfg.docker.hostGroupID ];
  };

  # ── Core resources ──────────────────────────────────────────────────
  deployment = {
    apiVersion = "apps/v1";
    kind = "Deployment";
    metadata = {
      name = "codium-server";
      namespace = cfg.namespace;
      inherit labels;
    };
    spec = {
      replicas = 1;
      strategy.type = "Recreate";
      selector.matchLabels = labels;
      template = {
        metadata = { inherit labels; };
        spec = {
          inherit volumes hostAliases;
          securityContext = { fsGroup = 1000; } // podSecurityContext;
          initContainers = optionals cfg.nixStore.enable [
            {
              name = "nix-store-init";
              image = "${cfg.image.repository}:${cfg.image.tag}";
              imagePullPolicy = cfg.image.pullPolicy;
              securityContext.runAsUser = 0;
              command = [ "/bin/sh" "-c" "if [ ! -d /nix-host/store ] || [ -z \"$(ls -A /nix-host/store 2>/dev/null)\" ]; then echo 'Initialising /nix store...'; cp -a /nix/. /nix-host/; fi; if [ ! -d /nix-host/var/nix/db ]; then echo 'Initialising /nix database...'; mkdir -p /nix-host/var/nix/db /nix-host/var/nix/gcroots /nix-host/var/nix/profiles /nix-host/var/nix/temproots /nix-host/var/nix/userpool; nix-store --store /nix-host --init; fi; chown -R 1000:1000 /nix-host; echo 'Done.'" ];
              volumeMounts = [
                { name = "nix"; mountPath = "/nix-host"; }
              ];
            }
          ];
          containers = [
            {
              name = "codium-server";
              image = "${cfg.image.repository}:${cfg.image.tag}";
              imagePullPolicy = cfg.image.pullPolicy;
              inherit env volumeMounts;
              ports = [{ containerPort = 8080; name = "http"; protocol = "TCP"; }];
              # CAP_SYS_ADMIN is required so that bubblewrap (used by Nix's
              # buildFHSEnv to give codium an FHS filesystem) can create a
              # proper mount namespace.  Without it, bwrap's tmpfs/bind mounts
              # on the glibc store path leak into the container's root mount
              # namespace, making the path read-only and preventing Nix from
              # substituting or repairing it — which corrupts the store.
              securityContext = {
                allowPrivilegeEscalation = true;
                capabilities.add = [ "SYS_ADMIN" "SYS_PTRACE" ];
              };
            }
          ] ++ dindContainers;
        };
      };
    };
  };

  service = {
    apiVersion = "v1";
    kind = "Service";
    metadata = {
      name = "codium-server";
      namespace = cfg.namespace;
      inherit labels;
    };
    spec = {
      selector = labels;
      ports = [{
        name = "http";
        port = 8080;
        targetPort = 8080;
        protocol = "TCP";
      }];
    };
  };

  # ── Dev-ports helpers ────────────────────────────────────────────
  mkDevPortService = port: {
    apiVersion = "v1";
    kind = "Service";
    metadata = {
      name = "codium-server-port-${toString port}";
      namespace = cfg.namespace;
      labels = labels // { "app.kubernetes.io/component" = "dev-port"; };
    };
    spec = {
      selector = labels;
      ports = [{
        name = "dev-${toString port}";
        port = port;
        targetPort = port;
        protocol = "TCP";
      }];
    };
  };

  devPortServices = map mkDevPortService cfg.devPorts;

  devPortRoutes = listToAttrs (map (port: {
    name = "codium-server-dev-${toString port}";
    value = {
      subdomain = toString port;
      namespace = cfg.namespace;
      service   = "codium-server-port-${toString port}";
      inherit port;
      auth = "forward";
    };
  }) cfg.devPorts);
in
{
  options.openkrill.apps.codium-server = {
    enable = mkEnableOption "codium-server (VSCodium in the browser)";

    namespace = mkOption {
      type = types.str;
      default = "codium-server";
    };

    domain = mkOption {
      type = types.str;
      default = "codium.${domain}";
      description = "FQDN for the codium-server instance.";
    };

    image.repository = mkOption {
      type = types.str;
      default = "ghcr.io/general-intelligence-systems/codium-server";
    };

    image.tag = mkOption {
      type = types.str;
      default = "latest";
    };

    image.pullPolicy = mkOption {
      type = types.str;
      default = "Always";
    };

    persistence.hostPath = mkOption {
      type = types.str;
      default = "/var/lib/rancher/k3s/storage/codium-server";
      description = "Host directory to mount at /home/coder inside the container.";
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
      default = "/var/lib/rancher/k3s/storage/codium-server-nix";
      description = "Host directory to mount at /nix inside the container.";
    };

    devPorts = mkOption {
      type = with types; listOf port;
      default = import ./dev-ports.nix;
      description = ''
        List of TCP ports to expose as dev-port subdomains.
        Each port N gets a route at N.<domain> that forwards to
        the codium-server pod on port N.
      '';
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Route ──────────────────────────────────────────────────────
    openkrill.ingress.routes = {
      codium-server = {
        subdomain = "codium";
        namespace = cfg.namespace;
        service   = "codium-server";
        port      = 8080;
      };
    } // devPortRoutes;

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.codium-server = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project   = "default";
      source = {
        repoURL        = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path           = ".";
        directory.include = "codium-server.yaml";
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
    openkrill.manifests.codium-server.content =
      [ (k8s.mkNamespace cfg.namespace) deployment service ]
      ++ devPortServices;
  };
}
