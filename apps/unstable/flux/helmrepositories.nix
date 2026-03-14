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
  HelmrepositoriesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this HelmRepository resource.";
        };
        "accessFrom" = mkOption {
          description = "AccessFrom specifies an Access Control List for allowing cross-namespace\nreferences to this object.\nNOTE: Not implemented, provisional as of https://github.com/fluxcd/flux2/pull/2092";
          type = (types.nullOr AccessFromModule);
          default = null;
        };
        "certSecretRef" = mkOption {
          description = "CertSecretRef can be given the name of a Secret containing\neither or both of\n\n- a PEM-encoded client certificate (`tls.crt`) and private\nkey (`tls.key`);\n- a PEM-encoded CA certificate (`ca.crt`)\n\nand whichever are supplied, will be used for connecting to the\nregistry. The client cert and key are useful if you are\nauthenticating with a certificate; the CA cert is useful if\nyou are using a self-signed server certificate. The Secret must\nbe of type `Opaque` or `kubernetes.io/tls`.\n\nIt takes precedence over the values specified in the Secret referred\nto by `.spec.secretRef`.";
          type = (types.nullOr CertSecretRefModule);
          default = null;
        };
        "insecure" = mkOption {
          description = "Insecure allows connecting to a non-TLS HTTP container registry.\nThis field is only taken into account if the .spec.type field is set to 'oci'.";
          type = types.bool;
          default = false;
        };
        "interval" = mkOption {
          description = "Interval at which the HelmRepository URL is checked for updates.\nThis interval is approximate and may be subject to jitter to ensure\nefficient use of resources.";
          type = (types.nullOr types.str);
          default = null;
        };
        "passCredentials" = mkOption {
          description = "PassCredentials allows the credentials from the SecretRef to be passed\non to a host that does not match the host as defined in URL.\nThis may be required if the host of the advertised chart URLs in the\nindex differ from the defined URL.\nEnabling this should be done with caution, as it can potentially result\nin credentials getting stolen in a MITM-attack.";
          type = types.bool;
          default = false;
        };
        "provider" = mkOption {
          description = "Provider used for authentication, can be 'aws', 'azure', 'gcp' or 'generic'.\nThis field is optional, and only taken into account if the .spec.type field is set to 'oci'.\nWhen not specified, defaults to 'generic'.";
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
        "secretRef" = mkOption {
          description = "SecretRef specifies the Secret containing authentication credentials\nfor the HelmRepository.\nFor HTTP/S basic auth the secret must contain 'username' and 'password'\nfields.\nSupport for TLS auth using the 'certFile' and 'keyFile', and/or 'caFile'\nkeys is deprecated. Please use `.spec.certSecretRef` instead.";
          type = (types.nullOr SecretRefModule);
          default = null;
        };
        "suspend" = mkOption {
          description = "Suspend tells the controller to suspend the reconciliation of this\nHelmRepository.";
          type = types.bool;
          default = false;
        };
        "timeout" = mkOption {
          description = "Timeout is used for the index fetch operation for an HTTPS helm repository,\nand for remote OCI Repository operations like pulling for an OCI helm\nchart by the associated HelmChart.\nIts default value is 60s.";
          type = (types.nullOr types.str);
          default = null;
        };
        "type" = mkOption {
          description = "Type of the HelmRepository.\nWhen this field is set to  \"oci\", the URL field value must be prefixed with \"oci://\".";
          type = (
            types.nullOr (
              types.enum [
                "default"
                "oci"
              ]
            )
          );
          default = null;
        };
        "url" = mkOption {
          description = "URL of the Helm repository, a valid URL contains at least a protocol and\nhost.";
          type = types.str;
        };
      };
    }
  );
  mkHelmRepository = name: res: {
    apiVersion = "source.toolkit.fluxcd.io/v1";
    kind = "HelmRepository";
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
    // optionalAttrs res."insecure" { inherit (res) "insecure"; }
    // {
    }
    // optionalAttrs (res."interval" != null) { inherit (res) "interval"; }
    // {
    }
    // optionalAttrs res."passCredentials" { inherit (res) "passCredentials"; }
    // {
    }
    // optionalAttrs (res."provider" != null) { inherit (res) "provider"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) { "secretRef" = mkSecretRef res."secretRef"; }
    // {
    }
    // optionalAttrs res."suspend" { inherit (res) "suspend"; }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
      inherit (res) "url";
    };
  };
  allResources = (mapAttrsToList mkHelmRepository cfg."helmrepositories");
in
{
  options.openkrill.apps."flux" = {
    "helmrepositories" = mkOption {
      type = types.attrsOf HelmrepositoriesModule;
      default = { };
      description = "HelmRepository CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."flux".content = allResources;
  };
}
