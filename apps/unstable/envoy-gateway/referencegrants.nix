# Auto-generated openkrill module fragment for envoy-gateway
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."envoy-gateway";
  compact = filterAttrs (_: v: v != null);
  FromModule = types.submodule {
    options = {
      "group" = mkOption {
        description = "Group is the group of the referent.\nWhen empty, the Kubernetes core API group is inferred.\n\nSupport: Core";
        type = types.str;
      };
      "kind" = mkOption {
        description = "Kind is the kind of the referent. Although implementations may support\nadditional resources, the following types are part of the \"Core\"\nsupport level for this field.\n\nWhen used to permit a SecretObjectReference:\n\n* Gateway\n\nWhen used to permit a BackendObjectReference:\n\n* GRPCRoute\n* HTTPRoute\n* TCPRoute\n* TLSRoute\n* UDPRoute";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "Namespace is the namespace of the referent.\n\nSupport: Core";
        type = types.str;
      };
    };
  };
  mkFrom = res: {
    inherit (res) "group";
    inherit (res) "kind";
    inherit (res) "namespace";
  };
  ToModule = types.submodule {
    options = {
      "group" = mkOption {
        description = "Group is the group of the referent.\nWhen empty, the Kubernetes core API group is inferred.\n\nSupport: Core";
        type = types.str;
      };
      "kind" = mkOption {
        description = "Kind is the kind of the referent. Although implementations may support\nadditional resources, the following types are part of the \"Core\"\nsupport level for this field:\n\n* Secret when used to permit a SecretObjectReference\n* Service when used to permit a BackendObjectReference";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name is the name of the referent. When unspecified, this policy\nrefers to all resources of the specified Group and Kind in the local\nnamespace.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTo =
    res:
    {
      inherit (res) "group";
      inherit (res) "kind";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ReferencegrantsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this ReferenceGrant resource.";
        };
        "from" = mkOption {
          description = "From describes the trusted namespaces and kinds that can reference the\nresources described in \"To\". Each entry in this list MUST be considered\nto be an additional place that references can be valid from, or to put\nthis another way, entries MUST be combined using OR.\n\nSupport: Core";
          type = (types.listOf FromModule);
        };
        "to" = mkOption {
          description = "To describes the resources that may be referenced by the resources\ndescribed in \"From\". Each entry in this list MUST be considered to be an\nadditional place that references can be valid to, or to put this another\nway, entries MUST be combined using OR.\n\nSupport: Core";
          type = (types.listOf ToModule);
        };
      };
    }
  );
  mkReferenceGrant = name: res: {
    apiVersion = "gateway.networking.k8s.io/v1beta1";
    kind = "ReferenceGrant";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
      "from" = map mkFrom res."from";
      "to" = map mkTo res."to";
    };
  };
  allResources = (mapAttrsToList mkReferenceGrant cfg."referencegrants");
in
{
  options.openkrill.apps."envoy-gateway" = {
    "referencegrants" = mkOption {
      type = types.attrsOf ReferencegrantsModule;
      default = { };
      description = "ReferenceGrant CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."envoy-gateway".content = allResources;
  };
}
