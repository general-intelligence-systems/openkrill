# Auto-generated openkrill module fragment for flux
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."flux";
  compact = filterAttrs (_: v: v != null);
  CertSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkCertSecretRef = res: {
    inherit (res) "name";
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
  ProvidersModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this Provider resource.";
        };
        "address" = mkOption {
          description = "Address specifies the endpoint, in a generic sense, to where alerts are sent.\nWhat kind of endpoint depends on the specific Provider type being used.\nFor the generic Provider, for example, this is an HTTP/S address.\nFor other Provider types this could be a project ID or a namespace.";
          type = (types.nullOr types.str);
          default = null;
        };
        "certSecretRef" = mkOption {
          description = "CertSecretRef specifies the Secret containing\na PEM-encoded CA certificate (in the `ca.crt` key).\n\nNote: Support for the `caFile` key has\nbeen deprecated.";
          type = (types.nullOr CertSecretRefModule);
          default = null;
        };
        "channel" = mkOption {
          description = "Channel specifies the destination channel where events should be posted.";
          type = (types.nullOr types.str);
          default = null;
        };
        "commitStatusExpr" = mkOption {
          description = "CommitStatusExpr is a CEL expression that evaluates to a string value\nthat can be used to generate a custom commit status message for use\nwith eligible Provider types (github, gitlab, gitea, bitbucketserver,\nbitbucket, azuredevops). Supported variables are: event, provider,\nand alert.";
          type = (types.nullOr types.str);
          default = null;
        };
        "interval" = mkOption {
          description = "Interval at which to reconcile the Provider with its Secret references.\nDeprecated and not used in v1beta3.";
          type = (types.nullOr types.str);
          default = null;
        };
        "proxy" = mkOption {
          description = "Proxy the HTTP/S address of the proxy server.";
          type = (types.nullOr types.str);
          default = null;
        };
        "secretRef" = mkOption {
          description = "SecretRef specifies the Secret containing the authentication\ncredentials for this Provider.";
          type = (types.nullOr SecretRefModule);
          default = null;
        };
        "serviceAccountName" = mkOption {
          description = "ServiceAccountName is the name of the service account used to\nauthenticate with services from cloud providers. An error is thrown if a\nstatic credential is also defined inside the Secret referenced by the\nSecretRef.";
          type = (types.nullOr types.str);
          default = null;
        };
        "suspend" = mkOption {
          description = "Suspend tells the controller to suspend subsequent\nevents handling for this Provider.";
          type = types.bool;
          default = false;
        };
        "timeout" = mkOption {
          description = "Timeout for sending alerts to the Provider.";
          type = (types.nullOr types.str);
          default = null;
        };
        "type" = mkOption {
          description = "Type specifies which Provider implementation to use.";
          type = (
            types.enum [
              "slack"
              "discord"
              "msteams"
              "rocket"
              "generic"
              "generic-hmac"
              "github"
              "gitlab"
              "gitea"
              "bitbucketserver"
              "bitbucket"
              "azuredevops"
              "googlechat"
              "googlepubsub"
              "webex"
              "sentry"
              "azureeventhub"
              "telegram"
              "lark"
              "matrix"
              "opsgenie"
              "alertmanager"
              "grafana"
              "githubdispatch"
              "pagerduty"
              "datadog"
              "nats"
            ]
          );
        };
        "username" = mkOption {
          description = "Username specifies the name under which events are posted.";
          type = (types.nullOr types.str);
          default = null;
        };
      };
    }
  );
  mkProvider = name: res: {
    apiVersion = "notification.toolkit.fluxcd.io/v1beta3";
    kind = "Provider";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."address" != null) { inherit (res) "address"; }
    // {
    }
    // optionalAttrs (res."certSecretRef" != null) {
      "certSecretRef" = mkCertSecretRef res."certSecretRef";
    }
    // {
    }
    // optionalAttrs (res."channel" != null) { inherit (res) "channel"; }
    // {
    }
    // optionalAttrs (res."commitStatusExpr" != null) { inherit (res) "commitStatusExpr"; }
    // {
    }
    // optionalAttrs (res."interval" != null) { inherit (res) "interval"; }
    // {
    }
    // optionalAttrs (res."proxy" != null) { inherit (res) "proxy"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) { "secretRef" = mkSecretRef res."secretRef"; }
    // {
    }
    // optionalAttrs (res."serviceAccountName" != null) { inherit (res) "serviceAccountName"; }
    // {
    }
    // optionalAttrs res."suspend" { inherit (res) "suspend"; }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."username" != null) { inherit (res) "username"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkProvider cfg."providers");
in
{
  options.openkrill.apps."flux" = {
    "providers" = mkOption {
      type = types.attrsOf ProvidersModule;
      default = { };
      description = "Provider CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."flux".content = allResources;
  };
}
