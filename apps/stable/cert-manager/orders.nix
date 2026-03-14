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
  OrdersModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this Order resource.";
        };
        "commonName" = mkOption {
          description = "CommonName is the common name as specified on the DER encoded CSR. If specified, this value must also be present in `dnsNames` or `ipAddresses`. This field must match the corresponding field on the DER encoded CSR.";
          type = (types.nullOr types.str);
          default = null;
        };
        "dnsNames" = mkOption {
          description = "DNSNames is a list of DNS names that should be included as part of the Order validation process. This field must match the corresponding field on the DER encoded CSR.";
          type = (types.listOf types.str);
          default = [ ];
        };
        "duration" = mkOption {
          description = "Duration is the duration for the not after date for the requested certificate. this is set on order creation as pe the ACME spec.";
          type = (types.nullOr types.str);
          default = null;
        };
        "ipAddresses" = mkOption {
          description = "IPAddresses is a list of IP addresses that should be included as part of the Order validation process. This field must match the corresponding field on the DER encoded CSR.";
          type = (types.listOf types.str);
          default = [ ];
        };
        "issuerRef" = mkOption {
          description = "IssuerRef references a properly configured ACME-type Issuer which should be used to create this Order. If the Issuer does not exist, processing will be retried. If the Issuer is not an 'ACME' Issuer, an error will be returned and the Order will be marked as failed.";
          type = IssuerRefModule;
        };
        "request" = mkOption {
          description = "Certificate signing request bytes in DER encoding. This will be used when finalizing the order. This field must be set on the order.";
          type = types.str;
        };
      };
    }
  );
  mkOrder = name: res: {
    apiVersion = "acme.cert-manager.io/v1";
    kind = "Order";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."commonName" != null) { inherit (res) "commonName"; }
    // {
    }
    // optionalAttrs (res."dnsNames" != [ ]) { inherit (res) "dnsNames"; }
    // {
    }
    // optionalAttrs (res."duration" != null) { inherit (res) "duration"; }
    // {
    }
    // optionalAttrs (res."ipAddresses" != [ ]) { inherit (res) "ipAddresses"; }
    // {
      "issuerRef" = mkIssuerRef res."issuerRef";
      inherit (res) "request";
    };
  };
  allResources = (mapAttrsToList mkOrder cfg."orders");
in
{
  options.openkrill.apps."cert-manager" = {
    "orders" = mkOption {
      type = types.attrsOf OrdersModule;
      default = { };
      description = "Order CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."cert-manager".content = allResources;
  };
}
