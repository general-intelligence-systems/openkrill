# apps/stable/agent-sandbox — Agent Sandbox CRD and controller
# Deploys the Agent Sandbox operator for managing isolated, stateful,
# singleton workloads in Kubernetes (designed for AI agent runtimes).
# Optionally deploys the extensions chart (SandboxTemplate,
# SandboxClaim, SandboxWarmPool CRDs and controller).
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
  cfg = config.openkrill.apps.agent-sandbox;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  imports = [
    ./sandboxes.nix
    ./sandboxtemplates.nix
    ./sandboxclaims.nix
    ./sandboxwarmpools.nix
  ];

  options.openkrill.apps.agent-sandbox = {
    enable = mkEnableOption "Agent Sandbox CRD and controller";

    namespace = mkOption {
      type = types.str;
      default = "agent-sandbox";
    };

    values = mkOption {
      type = types.attrs;
      default = { };
      description = "Helm chart value overrides for the core agent-sandbox chart, deep-merged with module defaults.";
    };

    extensions = {
      enable = mkEnableOption "Agent Sandbox extensions (SandboxTemplate, SandboxClaim, SandboxWarmPool)";

      values = mkOption {
        type = types.attrs;
        default = { };
        description = "Helm chart value overrides for the agent-sandbox-extensions chart, deep-merged with module defaults.";
      };
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.agent-sandbox = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "{agent-sandbox.yaml,agent-sandbox/*.yaml}";
        directory.recurse = true;
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
    openkrill.manifests.agent-sandbox.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ (import ./helm.nix { inherit lib charts kubelib cfg; })
      ++ (optionals cfg.extensions.enable (
        import ./extensions-helm.nix { inherit lib charts kubelib cfg; }
      ));
  };
}
