# modules/helm — k3s HelmChart and HelmChartConfig CRDs
# Generates helm.cattle.io/v1 HelmChart and HelmChartConfig resources
# for the k3s helm-controller to manage Helm releases at runtime.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps.helm;
  helpers = import ../lib/helpers.nix { inherit lib; };

  # ── ValuesSecrets sub-submodule ──────────────────────────────────
  valuesSecretModule = types.submodule {
    options = {
      name = mkOption {
        type = types.str;
        description = "Name of the Secret. Must be in the same namespace as the HelmChart.";
      };

      keys = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "Keys to read values content from. If empty, the secret is not used.";
      };

      ignoreUpdates = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Ignore changes to the secret and mark it as optional.
          When true, changes to the secret will not trigger a chart upgrade.
        '';
      };
    };
  };

  # ── HelmChart submodule ──────────────────────────────────────────
  helmChartModule = types.submodule ({ name, ... }: {
    options = {
      namespace = mkOption {
        type = types.str;
        default = "kube-system";
        description = "Namespace where the HelmChart resource is created. k3s watches kube-system by default.";
      };

      targetNamespace = mkOption {
        type = types.str;
        description = "Namespace where the chart's resources are deployed.";
      };

      createNamespace = mkOption {
        type = types.bool;
        default = true;
        description = "Create the target namespace if it does not exist.";
      };

      chart = mkOption {
        type = types.str;
        description = "Helm chart name in repository, or complete HTTPS URL to chart archive (.tgz).";
      };

      version = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Chart version. Only used when installing from a repository.";
      };

      repo = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Helm chart repository URL.";
      };

      repoCA = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "PEM-encoded CA certificates for HTTPS-enabled chart repos.";
      };

      repoCAConfigMap = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Name of a ConfigMap containing CA certificates trusted by Helm.";
      };

      set = mkOption {
        type = types.attrsOf (types.either types.str types.int);
        default = {};
        description = "Simple chart value overrides (--set / --set-string).";
      };

      values = mkOption {
        type = types.attrsOf types.anything;
        default = {};
        description = "Structured chart values (--values). Serialized as inline JSON.";
      };

      valuesContent = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Inline YAML string for chart values.";
      };

      valuesSecrets = mkOption {
        type = types.listOf valuesSecretModule;
        default = [];
        description = "References to Secrets containing chart values.";
      };

      bootstrap = mkOption {
        type = types.bool;
        default = false;
        description = "Set to true if this chart is needed to bootstrap the cluster (CNI, CCM, etc.).";
      };

      takeOwnership = mkOption {
        type = types.bool;
        default = false;
        description = "Allow Helm to take ownership of existing resources on install/upgrade.";
      };

      chartContent = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Base64-encoded chart archive (.tgz). Overrides chart and version.";
      };

      jobImage = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Image to use for the Helm job pod.";
      };

      backOffLimit = mkOption {
        type = types.nullOr types.int;
        default = null;
        description = "Number of retries before considering the Helm job failed.";
      };

      timeout = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Timeout for Helm operations (e.g. '10m0s').";
      };

      failurePolicy = mkOption {
        type = types.enum [ "reinstall" "abort" ];
        default = "reinstall";
        description = ''
          How to handle failed chart installation or upgrades.
          - reinstall: clean uninstall and reinstall.
          - abort: leave the chart in a failed state for manual resolution.
        '';
      };

      authSecret = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Name of a kubernetes.io/basic-auth Secret for the chart repo.";
      };

      authPassCredentials = mkOption {
        type = types.bool;
        default = false;
        description = "Pass basic auth credentials to all domains.";
      };

      insecureSkipTLSVerify = mkOption {
        type = types.bool;
        default = false;
        description = "Skip TLS certificate checks for the chart download.";
      };

      plainHTTP = mkOption {
        type = types.bool;
        default = false;
        description = "Use insecure HTTP connections for the chart download.";
      };

      dockerRegistrySecret = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Name of a kubernetes.io/dockerconfigjson Secret for OCI-based registries.";
      };

      podSecurityContext = mkOption {
        type = types.nullOr (types.attrsOf types.anything);
        default = null;
        description = "Custom PodSecurityContext for the Helm job pod.";
      };

      securityContext = mkOption {
        type = types.nullOr (types.attrsOf types.anything);
        default = null;
        description = "Custom SecurityContext for the Helm job container.";
      };
    };
  });

  # ── HelmChartConfig submodule ────────────────────────────────────
  helmChartConfigModule = types.submodule ({ name, ... }: {
    options = {
      namespace = mkOption {
        type = types.str;
        default = "kube-system";
        description = "Namespace where the HelmChartConfig resource is created.";
      };

      values = mkOption {
        type = types.attrsOf types.anything;
        default = {};
        description = "Structured chart value overrides.";
      };

      valuesContent = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Inline YAML string for chart value overrides.";
      };

      valuesSecrets = mkOption {
        type = types.listOf valuesSecretModule;
        default = [];
        description = "References to Secrets containing chart value overrides.";
      };

      failurePolicy = mkOption {
        type = types.enum [ "reinstall" "abort" ];
        default = "reinstall";
        description = "How to handle failed chart installation or upgrades.";
      };
    };
  });

  # ── Resource builders ────────────────────────────────────────────

  mkValuesSecret = vs: {
    inherit (vs) name keys ignoreUpdates;
  };

  mkHelmChart = name: chart: {
    apiVersion = "helm.cattle.io/v1";
    kind = "HelmChart";
    metadata = {
      inherit name;
      namespace = chart.namespace;
    };
    spec = {
      inherit (chart) targetNamespace createNamespace chart failurePolicy;
    }
    // optionalAttrs (chart.version != null) { inherit (chart) version; }
    // optionalAttrs (chart.repo != null) { inherit (chart) repo; }
    // optionalAttrs (chart.repoCA != null) { inherit (chart) repoCA; }
    // optionalAttrs (chart.repoCAConfigMap != null) {
      repoCAConfigMap = { name = chart.repoCAConfigMap; };
    }
    // optionalAttrs (chart.set != {}) {
      set = mapAttrs (_: v:
        if isInt v then { toString = builtins.toString v; } // { value = v; }
        else v
      ) chart.set;
    }
    // optionalAttrs (chart.values != {}) { inherit (chart) values; }
    // optionalAttrs (chart.valuesContent != null) { inherit (chart) valuesContent; }
    // optionalAttrs (chart.valuesSecrets != []) {
      valuesSecrets = map mkValuesSecret chart.valuesSecrets;
    }
    // optionalAttrs chart.bootstrap { inherit (chart) bootstrap; }
    // optionalAttrs chart.takeOwnership { inherit (chart) takeOwnership; }
    // optionalAttrs (chart.chartContent != null) { inherit (chart) chartContent; }
    // optionalAttrs (chart.jobImage != null) { inherit (chart) jobImage; }
    // optionalAttrs (chart.backOffLimit != null) { inherit (chart) backOffLimit; }
    // optionalAttrs (chart.timeout != null) { inherit (chart) timeout; }
    // optionalAttrs (chart.authSecret != null) {
      authSecret = { name = chart.authSecret; };
    }
    // optionalAttrs chart.authPassCredentials { inherit (chart) authPassCredentials; }
    // optionalAttrs chart.insecureSkipTLSVerify { inherit (chart) insecureSkipTLSVerify; }
    // optionalAttrs chart.plainHTTP { inherit (chart) plainHTTP; }
    // optionalAttrs (chart.dockerRegistrySecret != null) {
      dockerRegistrySecret = { name = chart.dockerRegistrySecret; };
    }
    // optionalAttrs (chart.podSecurityContext != null) { inherit (chart) podSecurityContext; }
    // optionalAttrs (chart.securityContext != null) { inherit (chart) securityContext; };
  };

  mkHelmChartConfig = name: cc: {
    apiVersion = "helm.cattle.io/v1";
    kind = "HelmChartConfig";
    metadata = {
      inherit name;
      namespace = cc.namespace;
    };
    spec = {
      inherit (cc) failurePolicy;
    }
    // optionalAttrs (cc.values != {}) { inherit (cc) values; }
    // optionalAttrs (cc.valuesContent != null) { inherit (cc) valuesContent; }
    // optionalAttrs (cc.valuesSecrets != []) {
      valuesSecrets = map mkValuesSecret cc.valuesSecrets;
    };
  };

  helmCharts = mapAttrsToList mkHelmChart cfg.charts;
  helmChartConfigs = mapAttrsToList mkHelmChartConfig cfg.chartConfigs;
in
{
  options.openkrill.apps.helm = {
    enable = mkEnableOption "k3s HelmChart and HelmChartConfig CRD resources";

    charts = mkOption {
      type = types.attrsOf helmChartModule;
      default = {};
      description = "HelmChart CRD instances for k3s helm-controller.";
    };

    chartConfigs = mkOption {
      type = types.attrsOf helmChartConfigModule;
      default = {};
      description = "HelmChartConfig CRD instances to override values on existing HelmCharts.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    openkrill.apps.argocd.applications.helm = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "helm.yaml";
      };
      destination = {
        server = "https://kubernetes.default.svc";
        namespace = "kube-system";
      };
      syncPolicy = {
        automated = { prune = true; selfHeal = true; };
      };
    };

    openkrill.manifests = mkMerge [
      {
        helm.content = helmCharts ++ helmChartConfigs;
      }
      (helpers.mkExtraManifestsConfig "helm" cfg.extraManifests)
    ];
  };
}
