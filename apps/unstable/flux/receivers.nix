# Auto-generated openkrill module fragment for flux
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."flux";
  compact = filterAttrs (_: v: v != null);
  ResourceModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        description = "API version of the referent";
        type = (types.nullOr types.str);
        default = null;
      };
      "kind" = mkOption {
        description = "Kind of the referent";
        type = (
          types.enum [
            "Bucket"
            "GitRepository"
            "Kustomization"
            "HelmRelease"
            "HelmChart"
            "HelmRepository"
            "ImageRepository"
            "ImagePolicy"
            "ImageUpdateAutomation"
            "OCIRepository"
          ]
        );
      };
      "matchLabels" = mkOption {
        description = "MatchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.\nMatchLabels requires the name to be set to `*`.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "name" = mkOption {
        description = "Name of the referent\nIf multiple resources are targeted `*` may be set.";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "Namespace of the referent";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkResource =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "kind";
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  SecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkSecretRef = res: {
    inherit (res) "name";
  };
  ReceiversModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this Receiver resource.";
        };
        "events" = mkOption {
          description = "Events specifies the list of event types to handle,\ne.g. 'push' for GitHub or 'Push Hook' for GitLab.";
          type = (types.listOf types.str);
          default = [ ];
        };
        "interval" = mkOption {
          description = "Interval at which to reconcile the Receiver with its Secret references.";
          type = (types.nullOr types.str);
          default = "10m";
        };
        "resourceFilter" = mkOption {
          description = "ResourceFilter is a CEL expression expected to return a boolean that is\nevaluated for each resource referenced in the Resources field when a\nwebhook is received. If the expression returns false then the controller\nwill not request a reconciliation for the resource.\nWhen the expression is specified the controller will parse it and mark\nthe object as terminally failed if the expression is invalid or does not\nreturn a boolean.";
          type = (types.nullOr types.str);
          default = null;
        };
        "resources" = mkOption {
          description = "A list of resources to be notified about changes.";
          type = (types.listOf ResourceModule);
        };
        "secretRef" = mkOption {
          description = "SecretRef specifies the Secret containing the token used\nto validate the payload authenticity.";
          type = SecretRefModule;
        };
        "suspend" = mkOption {
          description = "Suspend tells the controller to suspend subsequent\nevents handling for this receiver.";
          type = types.bool;
          default = false;
        };
        "type" = mkOption {
          description = "Type of webhook sender, used to determine\nthe validation procedure and payload deserialization.";
          type = (
            types.enum [
              "generic"
              "generic-hmac"
              "github"
              "gitlab"
              "bitbucket"
              "harbor"
              "dockerhub"
              "quay"
              "gcr"
              "nexus"
              "acr"
              "cdevents"
            ]
          );
        };
      };
    }
  );
  mkReceiver = name: res: {
    apiVersion = "notification.toolkit.fluxcd.io/v1";
    kind = "Receiver";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."events" != [ ]) { inherit (res) "events"; }
    // {
    }
    // optionalAttrs (res."interval" != null) { inherit (res) "interval"; }
    // {
    }
    // optionalAttrs (res."resourceFilter" != null) { inherit (res) "resourceFilter"; }
    // {
      "resources" = map mkResource res."resources";
      "secretRef" = mkSecretRef res."secretRef";
    }
    // optionalAttrs res."suspend" { inherit (res) "suspend"; }
    // {
      inherit (res) "type";
    };
  };
  allResources = (mapAttrsToList mkReceiver cfg."receivers");
in
{
  options.openkrill.apps."flux" = {
    "receivers" = mkOption {
      type = types.attrsOf ReceiversModule;
      default = { };
      description = "Receiver CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."flux".content = allResources;
  };
}
