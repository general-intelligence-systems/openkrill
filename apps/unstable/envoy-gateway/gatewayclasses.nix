# Auto-generated openkrill module fragment for envoy-gateway
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."envoy-gateway";
  compact = filterAttrs (_: v: v != null);
  ParametersRefModule = types.submodule {
    options = {
      "group" = mkOption {
        description = "Group is the group of the referent.";
        type = types.str;
      };
      "kind" = mkOption {
        description = "Kind is kind of the referent.";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name is the name of the referent.";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "Namespace is the namespace of the referent.\nThis field is required when referring to a Namespace-scoped resource and\nMUST be unset when referring to a Cluster-scoped resource.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkParametersRef =
    res:
    {
      inherit (res) "group";
      inherit (res) "kind";
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  GatewayclassesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this GatewayClass resource.";
        };
        "controllerName" = mkOption {
          description = "ControllerName is the name of the controller that is managing Gateways of\nthis class. The value of this field MUST be a domain prefixed path.\n\nExample: \"example.net/gateway-controller\".\n\nThis field is not mutable and cannot be empty.\n\nSupport: Core";
          type = types.str;
        };
        "description" = mkOption {
          description = "Description helps describe a GatewayClass with more details.";
          type = (types.nullOr types.str);
          default = null;
        };
        "parametersRef" = mkOption {
          description = "ParametersRef is a reference to a resource that contains the configuration\nparameters corresponding to the GatewayClass. This is optional if the\ncontroller does not require any additional configuration.\n\nParametersRef can reference a standard Kubernetes resource, i.e. ConfigMap,\nor an implementation-specific custom resource. The resource can be\ncluster-scoped or namespace-scoped.\n\nIf the referent cannot be found, refers to an unsupported kind, or when\nthe data within that resource is malformed, the GatewayClass SHOULD be\nrejected with the \"Accepted\" status condition set to \"False\" and an\n\"InvalidParameters\" reason.\n\nA Gateway for this GatewayClass may provide its own `parametersRef`. When both are specified,\nthe merging behavior is implementation specific.\nIt is generally recommended that GatewayClass provides defaults that can be overridden by a Gateway.\n\nSupport: Implementation-specific";
          type = (types.nullOr ParametersRefModule);
          default = null;
        };
      };
    }
  );
  mkGatewayClass = name: res: {
    apiVersion = "gateway.networking.k8s.io/v1";
    kind = "GatewayClass";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
      inherit (res) "controllerName";
    }
    // optionalAttrs (res."description" != null) { inherit (res) "description"; }
    // {
    }
    // optionalAttrs (res."parametersRef" != null) {
      "parametersRef" = mkParametersRef res."parametersRef";
    }
    // {
    };
  };
  allResources = (mapAttrsToList mkGatewayClass cfg."gatewayclasses");
in
{
  options.openkrill.apps."envoy-gateway" = {
    "gatewayclasses" = mkOption {
      type = types.attrsOf GatewayclassesModule;
      default = { };
      description = "GatewayClass CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."envoy-gateway".content = allResources;
  };
}
