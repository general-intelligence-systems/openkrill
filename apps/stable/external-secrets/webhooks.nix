# Auto-generated openkrill module fragment for external-secrets
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."external-secrets";
  compact = filterAttrs (_: v: v != null);
  AuthModule = types.submodule {
    options = {
      "ntlm" = mkOption {
        description = "NTLMProtocol configures the store to use NTLM for auth";
        type = (types.nullOr AuthNtlmModule);
        default = null;
      };
    };
  };
  mkAuth =
    res:
    {
    }
    // optionalAttrs (res."ntlm" != null) { "ntlm" = mkAuthNtlm res."ntlm"; }
    // {
    };
  AuthNtlmModule = types.submodule {
    options = {
      "passwordSecret" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = AuthNtlmPasswordSecretModule;
      };
      "usernameSecret" = mkOption {
        description = "SecretKeySelector is a reference to a specific 'key' within a Secret resource.\nIn some instances, `key` is a required field.";
        type = AuthNtlmUsernameSecretModule;
      };
    };
  };
  mkAuthNtlm = res: {
    "passwordSecret" = mkAuthNtlmPasswordSecret res."passwordSecret";
    "usernameSecret" = mkAuthNtlmUsernameSecret res."usernameSecret";
  };
  AuthNtlmPasswordSecretModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "A key in the referenced Secret.\nSome instances of this field may be defaulted, in others it may be required.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "The name of the Secret resource being referred to.";
        type = (types.nullOr types.str);
        default = null;
      };
      "namespace" = mkOption {
        description = "The namespace of the Secret resource being referred to.\nIgnored if referent is not cluster-scoped, otherwise defaults to the namespace of the referent.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkAuthNtlmPasswordSecret =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  AuthNtlmUsernameSecretModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "A key in the referenced Secret.\nSome instances of this field may be defaulted, in others it may be required.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "The name of the Secret resource being referred to.";
        type = (types.nullOr types.str);
        default = null;
      };
      "namespace" = mkOption {
        description = "The namespace of the Secret resource being referred to.\nIgnored if referent is not cluster-scoped, otherwise defaults to the namespace of the referent.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkAuthNtlmUsernameSecret =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  CaProviderModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key where the CA certificate can be found in the Secret or ConfigMap.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "The name of the object located at the provider type.";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "The namespace the Provider type is in.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "The type of provider to use such as \"Secret\", or \"ConfigMap\".";
        type = (
          types.enum [
            "Secret"
            "ConfigMap"
          ]
        );
      };
    };
  };
  mkCaProvider =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
      inherit (res) "type";
    };
  ResultModule = types.submodule {
    options = {
      "jsonPath" = mkOption {
        description = "Json path of return value";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkResult =
    res:
    {
    }
    // optionalAttrs (res."jsonPath" != null) { inherit (res) "jsonPath"; }
    // {
    };
  SecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of this secret in templates";
        type = types.str;
      };
      "secretRef" = mkOption {
        description = "Secret ref to fill in credentials";
        type = SecretSecretRefModule;
      };
    };
  };
  mkSecret = res: {
    inherit (res) "name";
    "secretRef" = mkSecretSecretRef res."secretRef";
  };
  SecretSecretRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key where the token is found.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "The name of the Secret resource being referred to.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSecretSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  WebhooksModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this Webhook resource.";
        };
        "auth" = mkOption {
          description = "Auth specifies a authorization protocol. Only one protocol may be set.";
          type = (types.nullOr AuthModule);
          default = null;
        };
        "body" = mkOption {
          description = "Body";
          type = (types.nullOr types.str);
          default = null;
        };
        "caBundle" = mkOption {
          description = "PEM encoded CA bundle used to validate webhook server certificate. Only used\nif the Server URL is using HTTPS protocol. This parameter is ignored for\nplain HTTP protocol connection. If not set the system root certificates\nare used to validate the TLS connection.";
          type = (types.nullOr types.str);
          default = null;
        };
        "caProvider" = mkOption {
          description = "The provider for the CA bundle to use to validate webhook server certificate.";
          type = (types.nullOr CaProviderModule);
          default = null;
        };
        "headers" = mkOption {
          description = "Headers";
          type = (types.attrsOf types.str);
          default = { };
        };
        "method" = mkOption {
          description = "Webhook Method";
          type = (types.nullOr types.str);
          default = null;
        };
        "result" = mkOption {
          description = "Result formatting";
          type = ResultModule;
        };
        "secrets" = mkOption {
          description = "Secrets to fill in templates\nThese secrets will be passed to the templating function as key value pairs under the given name";
          type = (types.listOf SecretModule);
          default = [ ];
        };
        "timeout" = mkOption {
          description = "Timeout";
          type = (types.nullOr types.str);
          default = null;
        };
        "url" = mkOption {
          description = "Webhook url to call";
          type = types.str;
        };
      };
    }
  );
  mkWebhook = name: res: {
    apiVersion = "generators.external-secrets.io/v1alpha1";
    kind = "Webhook";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."auth" != null) { "auth" = mkAuth res."auth"; }
    // {
    }
    // optionalAttrs (res."body" != null) { inherit (res) "body"; }
    // {
    }
    // optionalAttrs (res."caBundle" != null) { inherit (res) "caBundle"; }
    // {
    }
    // optionalAttrs (res."caProvider" != null) { "caProvider" = mkCaProvider res."caProvider"; }
    // {
    }
    // optionalAttrs (res."headers" != { }) { inherit (res) "headers"; }
    // {
    }
    // optionalAttrs (res."method" != null) { inherit (res) "method"; }
    // {
      "result" = mkResult res."result";
    }
    // optionalAttrs (res."secrets" != [ ]) { "secrets" = map mkSecret res."secrets"; }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
      inherit (res) "url";
    };
  };
  allResources = (mapAttrsToList mkWebhook cfg."webhooks");
in
{
  options.openkrill.apps."external-secrets" = {
    "webhooks" = mkOption {
      type = types.attrsOf WebhooksModule;
      default = { };
      description = "Webhook CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."external-secrets".content = allResources;
  };
}
