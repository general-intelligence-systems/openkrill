# apps/openkrill-operator — AI agent operator (Metacontroller webhook)
#
# Deploys the openkrill-operator (agent-controller) Helm chart and renders
# custom resources declared via Nix options: Heartbeats, LlmProviders,
# MCPs, Skills, Tools, Agents, and LlmApiKeys.
#
# The operator runs as a Metacontroller webhook that watches these CRDs
# and produces child resources (CronJobs, Secrets, ConfigMaps,
# CiliumNetworkPolicies) to run scheduled AI agents.
#
# Usage:
#
#   openkrill.apps.openkrill-operator = {
#     enable = true;
#
#     llmProviders.opencode = {
#       name = "opencode";
#       image = "ghcr.io/example/opencode-runner:latest";
#       apiEndpoint = "api.anthropic.com";
#       mounts.skills = "/home/user/.opencode/skills";
#     };
#
#     mcps.forgejo-mcp = {
#       config.command = "git-mcp";
#       description = "Forgejo git server";
#       networkAccess = [
#         { endpoint = "forgejo.forgejo.svc.cluster.local"; port = 3000; protocol = "TCP"; }
#       ];
#     };
#
#     heartbeats.standup-bot = {
#       provider = "opencode";
#       schedule = "every weekday at 9am";
#       prompt = "Run standup";
#       mcps = [ "forgejo-mcp" ];
#     };
#   };
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.openkrill-operator;
  helpers          = import ../../modules/lib/helpers.nix { inherit lib; };
  # ── CR helper ────────────────────────────────────────────────────────
  # Wraps user-provided spec attrs into a full custom resource, filling
  # in apiVersion, kind, and metadata so users only write spec fields.
  mkCR = kind: name: spec: {
    apiVersion = "openkrill.ai/v1alpha1";
    inherit kind;
    metadata = { inherit name; namespace = cfg.namespace; };
    inherit spec;
  };

  # ── Render all declared CRs ─────────────────────────────────────────
  allCRs =
       mapAttrsToList (name: spec: mkCR "Heartbeat"   name spec) cfg.heartbeats
    ++ mapAttrsToList (name: spec: mkCR "LlmProvider" name spec) cfg.llmProviders
    ++ mapAttrsToList (name: spec: mkCR "LlmApiKey"   name spec) cfg.llmApiKeys
    ++ mapAttrsToList (name: spec: mkCR "MCP"         name spec) cfg.mcps
    ++ mapAttrsToList (name: spec: mkCR "Skill"       name spec) cfg.skills
    ++ mapAttrsToList (name: spec: mkCR "Tool"        name spec) cfg.tools
    ++ mapAttrsToList (name: spec: mkCR "Agent"       name spec) cfg.agents;
in
{
  options.openkrill.apps.openkrill-operator = {
    enable = mkEnableOption "OpenKrill Operator (AI agent controller)";

    namespace = mkOption {
      type = types.str;
      default = "agents";
      description = "Namespace for operator resources and agent CRs.";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides for the agent-controller chart.";
    };

    # ── CR declarations (freeform) ─────────────────────────────────────
    # Each option is an attrset mapping resource names to spec fields.
    # The module wraps each into a full CR with apiVersion/kind/metadata.

    heartbeats = mkOption {
      type = types.attrsOf types.attrs;
      default = {};
      description = ''
        Heartbeat custom resources — scheduled AI agent invocations.
        Keys are resource names, values are spec fields.
      '';
      example = {
        standup-bot = {
          provider = "opencode";
          schedule = "every weekday at 9am";
          prompt = "Review open PRs and post a summary";
          mcps = [ "forgejo-mcp" ];
        };
      };
    };

    llmProviders = mkOption {
      type = types.attrsOf types.attrs;
      default = {};
      description = ''
        LlmProvider custom resources — define agent runtime templates.
        Keys are resource names, values are spec fields.
      '';
      example = {
        opencode = {
          name = "opencode";
          image = "ghcr.io/example/opencode-runner:latest";
          apiEndpoint = "api.anthropic.com";
          mounts.skills = "/home/user/.opencode/skills";
        };
      };
    };

    llmApiKeys = mkOption {
      type = types.attrsOf types.attrs;
      default = {};
      description = ''
        LlmApiKey custom resources — API keys for LLM providers.
        Keys are resource names, values are spec fields.
      '';
    };

    mcps = mkOption {
      type = types.attrsOf types.attrs;
      default = {};
      description = ''
        MCP (Model Context Protocol) custom resources — MCP server configs
        for agent consumption. Supports networkAccess for network policy
        generation.
      '';
      example = {
        forgejo-mcp = {
          config.command = "git-mcp";
          description = "Forgejo git server";
          networkAccess = [
            { endpoint = "forgejo.forgejo.svc.cluster.local"; port = 3000; protocol = "TCP"; }
          ];
        };
      };
    };

    skills = mkOption {
      type = types.attrsOf types.attrs;
      default = {};
      description = ''
        Skill custom resources — skill definitions for agent consumption.
        Supports networkAccess for network policy generation.
      '';
    };

    tools = mkOption {
      type = types.attrsOf types.attrs;
      default = {};
      description = ''
        Tool custom resources — tool definitions for agent consumption.
        Supports networkAccess for network policy generation.
      '';
    };

    agents = mkOption {
      type = types.attrsOf types.attrs;
      default = {};
      description = ''
        Agent custom resources — multi-file agent definitions.
        Keys are resource names, values are spec fields.
      '';
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── ArgoCD Application ─────────────────────────────────────────────
    openkrill.apps.argocd.applications.openkrill-operator = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "openkrill-operator.yaml";
      };
      destination = {
        server = "https://kubernetes.default.svc";
        namespace = cfg.namespace;
      };
      syncPolicy = {
        automated = { prune = true; selfHeal = true; };
        syncOptions = [ "CreateNamespace=true" "ServerSideApply=true" ];
      };
    };

    # ── Manifests ──────────────────────────────────────────────────────
    openkrill.manifests.openkrill-operator.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ kubelib.fromHelm {
        name = "agent-controller";
        chart = charts.openkrill.agent-controller.latest;
        namespace = cfg.namespace;
        values = cfg.values;
      }
      ++ allCRs;
  };
}
