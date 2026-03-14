# Auto-generated openkrill module fragment for flux
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."flux";
  compact = filterAttrs (_: v: v != null);
  AccessFromModule = types.submodule {
    options = {
      "namespaceSelectors" = mkOption {
        description = "NamespaceSelectors is the list of namespace selectors to which this ACL applies.\nItems in this list are evaluated using a logical OR operation.";
        type = (types.listOf AccessFromNamespaceSelectorModule);
      };
    };
  };
  mkAccessFrom = res: {
    "namespaceSelectors" = map mkAccessFromNamespaceSelector res."namespaceSelectors";
  };
  AccessFromNamespaceSelectorModule = types.submodule {
    options = {
      "matchLabels" = mkOption {
        description = "MatchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkAccessFromNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
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
  ImagerepositoriesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this ImageRepository resource.";
        };
        "accessFrom" = mkOption {
          description = "AccessFrom defines an ACL for allowing cross-namespace references\nto the ImageRepository object based on the caller's namespace labels.";
          type = (types.nullOr AccessFromModule);
          default = null;
        };
        "certSecretRef" = mkOption {
          description = "CertSecretRef can be given the name of a Secret containing\neither or both of\n\n- a PEM-encoded client certificate (`tls.crt`) and private\nkey (`tls.key`);\n- a PEM-encoded CA certificate (`ca.crt`)\n\nand whichever are supplied, will be used for connecting to the\nregistry. The client cert and key are useful if you are\nauthenticating with a certificate; the CA cert is useful if\nyou are using a self-signed server certificate. The Secret must\nbe of type `Opaque` or `kubernetes.io/tls`.\n\nNote: Support for the `caFile`, `certFile` and `keyFile` keys has\nbeen deprecated.";
          type = (types.nullOr CertSecretRefModule);
          default = null;
        };
        "exclusionList" = mkOption {
          description = "ExclusionList is a list of regex strings used to exclude certain tags\nfrom being stored in the database.";
          type = (types.listOf types.str);
          default = [ "^.*\.sig$" ];
        };
        "image" = mkOption {
          description = "Image is the name of the image repository";
          type = types.str;
        };
        "insecure" = mkOption {
          description = "Insecure allows connecting to a non-TLS HTTP container registry.";
          type = types.bool;
          default = false;
        };
        "interval" = mkOption {
          description = "Interval is the length of time to wait between\nscans of the image repository.";
          type = types.str;
        };
        "provider" = mkOption {
          description = "The provider used for authentication, can be 'aws', 'azure', 'gcp' or 'generic'.\nWhen not specified, defaults to 'generic'.";
          type = (
            types.nullOr (
              types.enum [
                "generic"
                "aws"
                "azure"
                "gcp"
              ]
            )
          );
          default = "generic";
        };
        "proxySecretRef" = mkOption {
          description = "ProxySecretRef specifies the Secret containing the proxy configuration\nto use while communicating with the container registry.";
          type = (types.nullOr ProxySecretRefModule);
          default = null;
        };
        "secretRef" = mkOption {
          description = "SecretRef can be given the name of a secret containing\ncredentials to use for the image registry. The secret should be\ncreated with `kubectl create secret docker-registry`, or the\nequivalent.";
          type = (types.nullOr SecretRefModule);
          default = null;
        };
        "serviceAccountName" = mkOption {
          description = "ServiceAccountName is the name of the Kubernetes ServiceAccount used to authenticate\nthe image pull if the service account has attached pull secrets.";
          type = (types.nullOr types.str);
          default = null;
        };
        "suspend" = mkOption {
          description = "This flag tells the controller to suspend subsequent image scans.\nIt does not apply to already started scans. Defaults to false.";
          type = types.bool;
          default = false;
        };
        "timeout" = mkOption {
          description = "Timeout for image scanning.\nDefaults to 'Interval' duration.";
          type = (types.nullOr types.str);
          default = null;
        };
      };
    }
  );
  mkImageRepository = name: res: {
    apiVersion = "image.toolkit.fluxcd.io/v1beta2";
    kind = "ImageRepository";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."accessFrom" != null) { "accessFrom" = mkAccessFrom res."accessFrom"; }
    // {
    }
    // optionalAttrs (res."certSecretRef" != null) {
      "certSecretRef" = mkCertSecretRef res."certSecretRef";
    }
    // {
    }
    // optionalAttrs (res."exclusionList" != [ ]) { inherit (res) "exclusionList"; }
    // {
      inherit (res) "image";
    }
    // optionalAttrs res."insecure" { inherit (res) "insecure"; }
    // {
      inherit (res) "interval";
    }
    // optionalAttrs (res."provider" != null) { inherit (res) "provider"; }
    // {
    }
    // optionalAttrs (res."proxySecretRef" != null) {
      "proxySecretRef" = mkProxySecretRef res."proxySecretRef";
    }
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
    };
  };
  allResources = (mapAttrsToList mkImageRepository cfg."imagerepositories");
in
{
  options.openkrill.apps."flux" = {
    "imagerepositories" = mkOption {
      type = types.attrsOf ImagerepositoriesModule;
      default = { };
      description = "ImageRepository CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."flux".content = allResources;
  };
}
