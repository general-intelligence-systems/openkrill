# Gateway API module — composes per-CRD submodules and adds the
# optional ValidatingAdmissionPolicy for safe upgrades.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."gateway-api";
  helpers = import ../../modules/lib/helpers.nix { inherit lib; };
in
{
  imports = [
    ./backendtlspolicies.nix
    ./gatewayclasses.nix
    ./gateways.nix
    ./grpcroutes.nix
    ./httproutes.nix
    ./listenersets.nix
    ./referencegrants.nix
    ./tlsroutes.nix
  ];

  options.openkrill.apps."gateway-api" = {
    enable = mkEnableOption "gateway-api CRD resources";
    extraManifests = helpers.mkExtraManifestsOption;
    safeUpgrades = mkOption {
      type = types.bool;
      default = true;
      description = "Deploy the ValidatingAdmissionPolicy that prevents unsafe CRD channel or version downgrades.";
    };
  };

  config = mkIf cfg.enable {
    openkrill.apps.argocd.applications.gateway-api = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "gateway-api.yaml";
      };
      destination = {
        server = "https://kubernetes.default.svc";
      };
      syncPolicy = {
        automated = { prune = true; selfHeal = true; };
      };
    };

    openkrill.manifests = mkMerge [
      (mkIf cfg.safeUpgrades {
        "gateway-api".content = [
          {
            apiVersion = "admissionregistration.k8s.io/v1";
            kind = "ValidatingAdmissionPolicy";
            metadata = {
              name = "safe-upgrades.gateway.networking.k8s.io";
              annotations = {
                "gateway.networking.k8s.io/bundle-version" = "v1.5.0";
                "gateway.networking.k8s.io/channel" = "standard";
              };
            };
            spec = {
              failurePolicy = "Fail";
              matchConstraints.resourceRules = [
                {
                  apiGroups = [ "apiextensions.k8s.io" ];
                  apiVersions = [ "v1" ];
                  operations = [
                    "CREATE"
                    "UPDATE"
                  ];
                  resources = [ "*" ];
                }
              ];
              validations = [
                {
                  expression = ''
                    object.spec.group != 'gateway.networking.k8s.io' || oldObject == null || (
                      has(object.metadata.annotations) && object.metadata.annotations.exists(k, k == 'gateway.networking.k8s.io/channel') &&
                      object.metadata.annotations['gateway.networking.k8s.io/channel'] == 'standard' ) || (
                      oldObject != null && has(oldObject.metadata.annotations) && oldObject.metadata.annotations.exists(k, k == 'gateway.networking.k8s.io/channel') &&
                      oldObject.metadata.annotations['gateway.networking.k8s.io/channel'] == 'experimental' )'';
                  message = "Installing experimental CRDs on top of standard channel CRDs is prohibited by default. Uninstall ValidatingAdmissionPolicy safe-upgrades.gateway.networking.k8s.io to install experimental CRDs on top of standard channel CRDs.";
                  reason = "Invalid";
                }
                {
                  expression = ''
                    object.spec.group != 'gateway.networking.k8s.io' ||
                      (has(object.metadata.annotations) && object.metadata.annotations.exists(k, k == 'gateway.networking.k8s.io/bundle-version') &&
                      !matches(object.metadata.annotations['gateway.networking.k8s.io/bundle-version'], 'v1.[0-3].\\d+') &&
                      !matches(object.metadata.annotations['gateway.networking.k8s.io/bundle-version'], 'v0'))'';
                  message = "Installing CRDs with version before v1.5.0 is prohibited by default. Uninstall ValidatingAdmissionPolicy safe-upgrades.gateway.networking.k8s.io to install older versions.";
                  reason = "Invalid";
                }
              ];
            };
          }
          {
            apiVersion = "admissionregistration.k8s.io/v1";
            kind = "ValidatingAdmissionPolicyBinding";
            metadata = {
              name = "safe-upgrades.gateway.networking.k8s.io";
              annotations = {
                "gateway.networking.k8s.io/bundle-version" = "v1.5.0";
                "gateway.networking.k8s.io/channel" = "standard";
              };
            };
            spec = {
              policyName = "safe-upgrades.gateway.networking.k8s.io";
              validationActions = [ "Deny" ];
              matchResources.resourceRules = [
                {
                  apiGroups = [ "apiextensions.k8s.io" ];
                  apiVersions = [ "v1" ];
                  resources = [ "customresourcedefinitions" ];
                  operations = [
                    "CREATE"
                    "UPDATE"
                  ];
                }
              ];
            };
          }
        ];
      })
      (helpers.mkExtraManifestsConfig "gateway-api" cfg.extraManifests)
    ];
  };
}
