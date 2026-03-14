# Auto-generated openkrill module fragment for cert-manager
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."cert-manager";
  compact = filterAttrs (_: v: v != null);
  IssuerRefModule = types.submodule {
    options = {
      "group" = mkOption {
        description = "Group of the resource being referred to.";
        type = (types.nullOr types.str);
        default = null;
      };
      "kind" = mkOption {
        description = "Kind of the resource being referred to.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the resource being referred to.";
        type = types.str;
      };
    };
  };
  mkIssuerRef =
    res:
    {
    }
    // optionalAttrs (res."group" != null) { inherit (res) "group"; }
    // {
    }
    // optionalAttrs (res."kind" != null) { inherit (res) "kind"; }
    // {
      inherit (res) "name";
    };
  CertificaterequestsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this CertificateRequest resource.";
        };
        "duration" = mkOption {
          description = "The requested 'duration' (i.e. lifetime) of the Certificate. This option may be ignored/overridden by some issuer types.";
          type = (types.nullOr types.str);
          default = null;
        };
        "extra" = mkOption {
          description = "Extra contains extra attributes of the user that created the CertificateRequest. Populated by the cert-manager webhook on creation and immutable.";
          type = (types.attrsOf (types.listOf types.str));
          default = { };
        };
        "groups" = mkOption {
          description = "Groups contains group membership of the user that created the CertificateRequest. Populated by the cert-manager webhook on creation and immutable.";
          type = (types.listOf types.str);
          default = [ ];
        };
        "isCA" = mkOption {
          description = "IsCA will request to mark the certificate as valid for certificate signing when submitting to the issuer. This will automatically add the `cert sign` usage to the list of `usages`.";
          type = types.bool;
          default = false;
        };
        "issuerRef" = mkOption {
          description = "IssuerRef is a reference to the issuer for this CertificateRequest.  If the `kind` field is not set, or set to `Issuer`, an Issuer resource with the given name in the same namespace as the CertificateRequest will be used.  If the `kind` field is set to `ClusterIssuer`, a ClusterIssuer with the provided name will be used. The `name` field in this stanza is required at all times. The group field refers to the API group of the issuer which defaults to `cert-manager.io` if empty.";
          type = IssuerRefModule;
        };
        "request" = mkOption {
          description = "The PEM-encoded x509 certificate signing request to be submitted to the CA for signing.";
          type = types.str;
        };
        "uid" = mkOption {
          description = "UID contains the uid of the user that created the CertificateRequest. Populated by the cert-manager webhook on creation and immutable.";
          type = (types.nullOr types.str);
          default = null;
        };
        "usages" = mkOption {
          description = "Usages is the set of x509 usages that are requested for the certificate. If usages are set they SHOULD be encoded inside the CSR spec Defaults to `digital signature` and `key encipherment` if not specified.";
          type = (
            types.listOf (
              types.enum [
                "signing"
                "digital signature"
                "content commitment"
                "key encipherment"
                "key agreement"
                "data encipherment"
                "cert sign"
                "crl sign"
                "encipher only"
                "decipher only"
                "any"
                "server auth"
                "client auth"
                "code signing"
                "email protection"
                "s/mime"
                "ipsec end system"
                "ipsec tunnel"
                "ipsec user"
                "timestamping"
                "ocsp signing"
                "microsoft sgc"
                "netscape sgc"
              ]
            )
          );
          default = [ ];
        };
        "username" = mkOption {
          description = "Username contains the name of the user that created the CertificateRequest. Populated by the cert-manager webhook on creation and immutable.";
          type = (types.nullOr types.str);
          default = null;
        };
      };
    }
  );
  mkCertificateRequest = name: res: {
    apiVersion = "cert-manager.io/v1";
    kind = "CertificateRequest";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."duration" != null) { inherit (res) "duration"; }
    // {
    }
    // optionalAttrs (res."extra" != { }) { inherit (res) "extra"; }
    // {
    }
    // optionalAttrs (res."groups" != [ ]) { inherit (res) "groups"; }
    // {
    }
    // optionalAttrs res."isCA" { inherit (res) "isCA"; }
    // {
      "issuerRef" = mkIssuerRef res."issuerRef";
      inherit (res) "request";
    }
    // optionalAttrs (res."uid" != null) { inherit (res) "uid"; }
    // {
    }
    // optionalAttrs (res."usages" != [ ]) { inherit (res) "usages"; }
    // {
    }
    // optionalAttrs (res."username" != null) { inherit (res) "username"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkCertificateRequest cfg."certificaterequests");
in
{
  options.openkrill.apps."cert-manager" = {
    "certificaterequests" = mkOption {
      type = types.attrsOf CertificaterequestsModule;
      default = { };
      description = "CertificateRequest CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."cert-manager".content = allResources;
  };
}
