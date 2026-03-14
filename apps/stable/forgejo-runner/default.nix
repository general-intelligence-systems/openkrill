# apps/forgejo-runner — Forgejo Actions runners
# Deploys one or more Forgejo Actions runners, each with a DinD sidecar.
# Secrets are expected to exist already (e.g. via external-secrets).
{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.openkrill.apps.forgejo-runner;
  helpers          = import ../../../modules/lib/helpers.nix { inherit lib; };
  runnerModule = types.submodule {
    options = {
      labels = mkOption {
        type = types.listOf types.str;
        default = [ "docker:docker://node:20-bookworm" ];
        description = "Runner capability labels.";
      };

      secretName = mkOption {
        type = types.str;
        description = "Name of the K8s Secret containing the runner registration secret.";
      };
    };
  };

  # ── mkRunner ────────────────────────────────────────────────────────────
  # Produces [ConfigMap, Deployment] for a single runner.
  mkRunner = name: runner:
    let
      configMapName = "${name}-config";
      labelLines = builtins.concatStringsSep "\n" (map (l: "    - \"${l}\"") runner.labels);
      configYaml = builtins.concatStringsSep "\n" [
        "runner:"
        "  labels:"
        labelLines
        "  envs:"
        "    DOCKER_HOST: tcp://localhost:2375"
        "container:"
        "  network: \"host\""
        "  docker_host: \"tcp://localhost:2375\""
        "  valid_volumes:"
        "    - \"**\""
        ""
      ];
    in
    [
      {
        apiVersion = "v1";
        kind = "ConfigMap";
        metadata = {
          name = configMapName;
          namespace = cfg.namespace;
        };
        data."config.yaml" = configYaml;
      }
      {
        apiVersion = "apps/v1";
        kind = "Deployment";
        metadata = {
          inherit name;
          namespace = cfg.namespace;
        };
        spec = {
          replicas = 1;
          selector.matchLabels.app = name;
          template = {
            metadata.labels.app = name;
            spec = {
              containers = [
                {
                  name = "dind";
                  image = "docker:dind";
                  securityContext.privileged = true;
                  command = [ "dockerd" "-H" "tcp://0.0.0.0:2375" "--tls=false" ];
                }
                {
                  name = "runner";
                  image = cfg.runnerImage;
                  command = [ "/bin/sh" "-c" ];
                  args = [
                    ''
                      sleep 5
                      forgejo-runner create-runner-file \
                        --instance "''${FORGEJO_URL}" \
                        --name "${name}" \
                        --secret "''${RUNNER_SECRET}"
                      forgejo-runner daemon --config /etc/runner/config.yaml
                    ''
                  ];
                  env = [
                    { name = "FORGEJO_URL"; value = cfg.forgejoURL; }
                    {
                      name = "RUNNER_SECRET";
                      valueFrom.secretKeyRef = {
                        name = runner.secretName;
                        key = "secret";
                      };
                    }
                    { name = "DOCKER_HOST"; value = "tcp://localhost:2375"; }
                  ];
                  volumeMounts = [
                    { name = "config"; mountPath = "/etc/runner/config.yaml"; subPath = "config.yaml"; }
                  ];
                }
              ];
              volumes = [
                { name = "config"; configMap.name = configMapName; }
              ];
            };
          };
        };
      }
    ];

  allResources = concatLists (mapAttrsToList mkRunner cfg.runners);
in
{
  options.openkrill.apps.forgejo-runner = {
    enable = mkEnableOption "Forgejo Actions runners";

    namespace = mkOption {
      type = types.str;
      default = "forgejo-runners";
    };

    forgejoURL = mkOption {
      type = types.str;
      default = "http://forgejo-http.forgejo.svc.cluster.local:3000";
      description = "Internal Forgejo HTTP URL.";
    };

    runnerImage = mkOption {
      type = types.str;
      default = "code.forgejo.org/forgejo/runner:12.6";
      description = "Forgejo runner container image.";
    };

    runners = mkOption {
      type = types.attrsOf runnerModule;
      default = {};
      description = "Runner instances to deploy. Each key becomes the runner/deployment name.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Secret generators (one per runner) ─────────────────────────────
    openkrill.secrets.generators = mapAttrs (_name: runner: {
      packages = with pkgs; [ openssl ];
      script = ''
        create_secret openkrill-${runner.secretName} \
          --from-literal=secret="$(openssl rand -hex 20)"
      '';
    }) cfg.runners;

    # ── ExternalSecrets (one per runner, keyed by secretName) ──────────
    openkrill.apps.external-secrets.secrets = listToAttrs (mapAttrsToList (_name: runner:
      nameValuePair runner.secretName {
        namespace = cfg.namespace;
        remoteSecretName = "openkrill-${runner.secretName}";
        keys = [ "secret" ];
      }
    ) cfg.runners);

    openkrill.apps.argocd.applications.forgejo-runner = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "forgejo-runner.yaml";
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

    openkrill.manifests.forgejo-runner.content = allResources;
  };
}
