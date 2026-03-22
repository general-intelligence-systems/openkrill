# apps/kubevirt — KubeVirt virtualisation
#
# Deploys KubeVirt via two Helm charts from the nixhelm2 catalog:
#   1. kubevirt-operator  — the operator (CRDs, controllers, API server)
#   2. kubevirt-cr         — the KubeVirt custom resource that activates it
#
# Enabling this module gives the cluster the ability to run VMs as
# first-class Kubernetes workloads alongside containers.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.kubevirt;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };

  operatorResources = kubelib.fromHelm {
    name = "kubevirt-operator";
    chart = charts.general-intelligence-systems.kubevirt-operator.versions."1.8.0-rc.0";
    namespace = cfg.namespace;
    values = cfg.operatorValues;
  };

  crResources = kubelib.fromHelm {
    name = "kubevirt-cr";
    chart = charts.general-intelligence-systems.kubevirt-cr.versions."1.8.0-rc.0";
    namespace = cfg.namespace;
    values = cfg.crValues;
  };
in
{
  options.openkrill.apps.kubevirt = {
    enable = mkEnableOption "KubeVirt virtualisation";

    namespace = mkOption {
      type = types.str;
      default = "kubevirt";
      description = "Namespace for KubeVirt operator and CR.";
    };

    operatorValues = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides for kubevirt-operator.";
    };

    crValues = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides for kubevirt-cr.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    openkrill.apps.argo-cd.applications.kubevirt = {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "kubevirt.yaml";
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

    openkrill.manifests.kubevirt.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ operatorResources
      ++ crResources;
  };
}
