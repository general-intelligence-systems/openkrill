# apps/containerized-data-importer — CDI for KubeVirt
#
# Deploys the Containerized Data Importer via two Helm charts from the
# nixhelm2 catalog:
#   1. cdi-operator  — the operator (CRDs, controllers)
#   2. cdi-cr        — the CDI custom resource that activates it
#
# CDI provides a declarative way to build VM disks on PVCs for KubeVirt.
# It is auto-enabled when KubeVirt is enabled.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.containerized-data-importer;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };

  operatorResources = kubelib.fromHelm {
    name = "cdi-operator";
    chart = charts.general-intelligence-systems.cdi-operator.versions."1.65.0";
    namespace = cfg.namespace;
    values = cfg.operatorValues;
  };

  crResources = kubelib.fromHelm {
    name = "cdi-cr";
    chart = charts.general-intelligence-systems.cdi-cr.versions."1.65.0";
    namespace = cfg.namespace;
    values = cfg.crValues;
  };
in
{
  options.openkrill.apps.containerized-data-importer = {
    enable = mkEnableOption "Containerized Data Importer (CDI) for KubeVirt";

    namespace = mkOption {
      type = types.str;
      default = "cdi";
      description = "Namespace for CDI operator and CR.";
    };

    operatorValues = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides for cdi-operator.";
    };

    crValues = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides for cdi-cr.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    openkrill.apps.argo-cd.applications.containerized-data-importer = {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "containerized-data-importer.yaml";
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

    openkrill.manifests.containerized-data-importer.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ operatorResources
      ++ crResources;
  };
}
