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
  ProxySecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkProxySecretRef = res: {
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
  StsCertSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkStsCertSecretRef = res: {
    inherit (res) "name";
  };
  StsModule = types.submodule {
    options = {
      "certSecretRef" = mkOption {
        description = "CertSecretRef can be given the name of a Secret containing\neither or both of\n\n- a PEM-encoded client certificate (`tls.crt`) and private\nkey (`tls.key`);\n- a PEM-encoded CA certificate (`ca.crt`)\n\nand whichever are supplied, will be used for connecting to the\nSTS endpoint. The client cert and key are useful if you are\nauthenticating with a certificate; the CA cert is useful if\nyou are using a self-signed server certificate. The Secret must\nbe of type `Opaque` or `kubernetes.io/tls`.\n\nThis field is only supported for the `ldap` provider.";
        type = (types.nullOr StsCertSecretRefModule);
        default = null;
      };
      "endpoint" = mkOption {
        description = "Endpoint is the HTTP/S endpoint of the Security Token Service from\nwhere temporary credentials will be fetched.";
        type = types.str;
      };
      "provider" = mkOption {
        description = "Provider of the Security Token Service.";
        type = (
          types.enum [
            "aws"
            "ldap"
          ]
        );
      };
      "secretRef" = mkOption {
        description = "SecretRef specifies the Secret containing authentication credentials\nfor the STS endpoint. This Secret must contain the fields `username`\nand `password` and is supported only for the `ldap` provider.";
        type = (types.nullOr StsSecretRefModule);
        default = null;
      };
    };
  };
  mkSts =
    res:
    {
    }
    // optionalAttrs (res."certSecretRef" != null) {
      "certSecretRef" = mkStsCertSecretRef res."certSecretRef";
    }
    // {
      inherit (res) "endpoint";
      inherit (res) "provider";
    }
    // optionalAttrs (res."secretRef" != null) { "secretRef" = mkStsSecretRef res."secretRef"; }
    // {
    };
  StsSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkStsSecretRef = res: {
    inherit (res) "name";
  };
  BucketsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this Bucket resource.";
        };
        "bucketName" = mkOption {
          description = "BucketName is the name of the object storage bucket.";
          type = types.str;
        };
        "certSecretRef" = mkOption {
          description = "CertSecretRef can be given the name of a Secret containing\neither or both of\n\n- a PEM-encoded client certificate (`tls.crt`) and private\nkey (`tls.key`);\n- a PEM-encoded CA certificate (`ca.crt`)\n\nand whichever are supplied, will be used for connecting to the\nbucket. The client cert and key are useful if you are\nauthenticating with a certificate; the CA cert is useful if\nyou are using a self-signed server certificate. The Secret must\nbe of type `Opaque` or `kubernetes.io/tls`.\n\nThis field is only supported for the `generic` provider.";
          type = (types.nullOr CertSecretRefModule);
          default = null;
        };
        "endpoint" = mkOption {
          description = "Endpoint is the object storage address the BucketName is located at.";
          type = types.str;
        };
        "ignore" = mkOption {
          description = "Ignore overrides the set of excluded patterns in the .sourceignore format\n(which is the same as .gitignore). If not provided, a default will be used,\nconsult the documentation for your version to find out what those are.";
          type = (types.nullOr types.str);
          default = null;
        };
        "insecure" = mkOption {
          description = "Insecure allows connecting to a non-TLS HTTP Endpoint.";
          type = types.bool;
          default = false;
        };
        "interval" = mkOption {
          description = "Interval at which the Bucket Endpoint is checked for updates.\nThis interval is approximate and may be subject to jitter to ensure\nefficient use of resources.";
          type = types.str;
        };
        "prefix" = mkOption {
          description = "Prefix to use for server-side filtering of files in the Bucket.";
          type = (types.nullOr types.str);
          default = null;
        };
        "provider" = mkOption {
          description = "Provider of the object storage bucket.\nDefaults to 'generic', which expects an S3 (API) compatible object\nstorage.";
          type = (
            types.nullOr (
              types.enum [
                "generic"
                "aws"
                "gcp"
                "azure"
              ]
            )
          );
          default = "generic";
        };
        "proxySecretRef" = mkOption {
          description = "ProxySecretRef specifies the Secret containing the proxy configuration\nto use while communicating with the Bucket server.";
          type = (types.nullOr ProxySecretRefModule);
          default = null;
        };
        "region" = mkOption {
          description = "Region of the Endpoint where the BucketName is located in.";
          type = (types.nullOr types.str);
          default = null;
        };
        "secretRef" = mkOption {
          description = "SecretRef specifies the Secret containing authentication credentials\nfor the Bucket.";
          type = (types.nullOr SecretRefModule);
          default = null;
        };
        "sts" = mkOption {
          description = "STS specifies the required configuration to use a Security Token\nService for fetching temporary credentials to authenticate in a\nBucket provider.\n\nThis field is only supported for the `aws` and `generic` providers.";
          type = (types.nullOr StsModule);
          default = null;
        };
        "suspend" = mkOption {
          description = "Suspend tells the controller to suspend the reconciliation of this\nBucket.";
          type = types.bool;
          default = false;
        };
        "timeout" = mkOption {
          description = "Timeout for fetch operations, defaults to 60s.";
          type = (types.nullOr types.str);
          default = "60s";
        };
      };
    }
  );
  mkBucket = name: res: {
    apiVersion = "source.toolkit.fluxcd.io/v1";
    kind = "Bucket";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
      inherit (res) "bucketName";
    }
    // optionalAttrs (res."certSecretRef" != null) {
      "certSecretRef" = mkCertSecretRef res."certSecretRef";
    }
    // {
      inherit (res) "endpoint";
    }
    // optionalAttrs (res."ignore" != null) { inherit (res) "ignore"; }
    // {
    }
    // optionalAttrs res."insecure" { inherit (res) "insecure"; }
    // {
      inherit (res) "interval";
    }
    // optionalAttrs (res."prefix" != null) { inherit (res) "prefix"; }
    // {
    }
    // optionalAttrs (res."provider" != null) { inherit (res) "provider"; }
    // {
    }
    // optionalAttrs (res."proxySecretRef" != null) {
      "proxySecretRef" = mkProxySecretRef res."proxySecretRef";
    }
    // {
    }
    // optionalAttrs (res."region" != null) { inherit (res) "region"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) { "secretRef" = mkSecretRef res."secretRef"; }
    // {
    }
    // optionalAttrs (res."sts" != null) { "sts" = mkSts res."sts"; }
    // {
    }
    // optionalAttrs res."suspend" { inherit (res) "suspend"; }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkBucket cfg."buckets");
in
{
  options.openkrill.apps."flux" = {
    "buckets" = mkOption {
      type = types.attrsOf BucketsModule;
      default = { };
      description = "Bucket CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."flux".content = allResources;
  };
}
