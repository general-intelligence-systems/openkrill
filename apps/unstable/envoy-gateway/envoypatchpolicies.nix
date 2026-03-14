# Auto-generated openkrill module fragment for envoy-gateway
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."envoy-gateway";
  compact = filterAttrs (_: v: v != null);
  JsonPatcheModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the name of the resource";
        type = types.str;
      };
      "operation" = mkOption {
        description = "Patch defines the JSON Patch Operation";
        type = JsonPatcheOperationModule;
      };
      "type" = mkOption {
        description = "Type is the typed URL of the Envoy xDS Resource";
        type = (
          types.enum [
            "type.googleapis.com/envoy.config.listener.v3.Listener"
            "type.googleapis.com/envoy.config.route.v3.RouteConfiguration"
            "type.googleapis.com/envoy.config.cluster.v3.Cluster"
            "type.googleapis.com/envoy.config.endpoint.v3.ClusterLoadAssignment"
            "type.googleapis.com/envoy.extensions.transport_sockets.tls.v3.Secret"
          ]
        );
      };
    };
  };
  mkJsonPatche = res: {
    inherit (res) "name";
    "operation" = mkJsonPatcheOperation res."operation";
    inherit (res) "type";
  };
  JsonPatcheOperationModule = types.submodule {
    options = {
      "from" = mkOption {
        description = "From is the source location of the value to be copied or moved. Only valid\nfor move or copy operations\nRefer to https://datatracker.ietf.org/doc/html/rfc6901 for more details.";
        type = (types.nullOr types.str);
        default = null;
      };
      "jsonPath" = mkOption {
        description = "JSONPath is a JSONPath expression. Refer to https://datatracker.ietf.org/doc/rfc9535/ for more details.\nIt produces one or more JSONPointer expressions based on the given JSON document.\nIf no JSONPointer is found, it will result in an error.\nIf the 'Path' property is also set, it will be appended to the resulting JSONPointer expressions from the JSONPath evaluation.\nThis is useful when creating a property that does not yet exist in the JSON document.\nThe final JSONPointer expressions specifies the locations in the target document/field where the operation will be applied.";
        type = (types.nullOr types.str);
        default = null;
      };
      "op" = mkOption {
        description = "Op is the type of operation to perform";
        type = (
          types.enum [
            "add"
            "remove"
            "replace"
            "move"
            "copy"
            "test"
          ]
        );
      };
      "path" = mkOption {
        description = "Path is a JSONPointer expression. Refer to https://datatracker.ietf.org/doc/html/rfc6901 for more details.\nIt specifies the location of the target document/field where the operation will be performed";
        type = (types.nullOr types.str);
        default = null;
      };
      "value" = mkOption {
        description = "Value is the new value of the path location. The value is only used by\nthe `add` and `replace` operations.";
        type = (types.nullOr types.anything);
        default = null;
      };
    };
  };
  mkJsonPatcheOperation =
    res:
    {
    }
    // optionalAttrs (res."from" != null) { inherit (res) "from"; }
    // {
    }
    // optionalAttrs (res."jsonPath" != null) { inherit (res) "jsonPath"; }
    // {
      inherit (res) "op";
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  TargetRefModule = types.submodule {
    options = {
      "group" = mkOption {
        description = "Group is the group of the target resource.";
        type = types.str;
      };
      "kind" = mkOption {
        description = "Kind is kind of the target resource.";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name is the name of the target resource.";
        type = types.str;
      };
    };
  };
  mkTargetRef = res: {
    inherit (res) "group";
    inherit (res) "kind";
    inherit (res) "name";
  };
  EnvoypatchpoliciesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this EnvoyPatchPolicy resource.";
        };
        "jsonPatches" = mkOption {
          description = "JSONPatch defines the JSONPatch configuration.";
          type = (types.listOf JsonPatcheModule);
          default = [ ];
        };
        "priority" = mkOption {
          description = "Priority of the EnvoyPatchPolicy.\nIf multiple EnvoyPatchPolicies are applied to the same\nTargetRef, they will be applied in the ascending order of\nthe priority i.e. int32.min has the highest priority and\nint32.max has the lowest priority.\nDefaults to 0.";
          type = (types.nullOr types.int);
          default = null;
        };
        "targetRef" = mkOption {
          description = "TargetRef is the name of the Gateway API resource this policy\nis being attached to.\nBy default, attaching to Gateway is supported and\nwhen mergeGateways is enabled it should attach to GatewayClass.\nThis Policy and the TargetRef MUST be in the same namespace\nfor this Policy to have effect and be applied to the Gateway\nTargetRef";
          type = TargetRefModule;
        };
        "type" = mkOption {
          description = "Type decides the type of patch.\nValid EnvoyPatchType values are \"JSONPatch\".";
          type = (types.enum [ "JSONPatch" ]);
        };
      };
    }
  );
  mkEnvoyPatchPolicy = name: res: {
    apiVersion = "gateway.envoyproxy.io/v1alpha1";
    kind = "EnvoyPatchPolicy";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."jsonPatches" != [ ]) { "jsonPatches" = map mkJsonPatche res."jsonPatches"; }
    // {
    }
    // optionalAttrs (res."priority" != null) { inherit (res) "priority"; }
    // {
      "targetRef" = mkTargetRef res."targetRef";
      inherit (res) "type";
    };
  };
  allResources = (mapAttrsToList mkEnvoyPatchPolicy cfg."envoypatchpolicies");
in
{
  options.openkrill.apps."envoy-gateway" = {
    "envoypatchpolicies" = mkOption {
      type = types.attrsOf EnvoypatchpoliciesModule;
      default = { };
      description = "EnvoyPatchPolicy CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."envoy-gateway".content = allResources;
  };
}
