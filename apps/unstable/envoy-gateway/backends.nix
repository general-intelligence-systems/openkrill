# Auto-generated openkrill module fragment for envoy-gateway
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."envoy-gateway";
  compact = filterAttrs (_: v: v != null);
  EndpointFqdnModule = types.submodule {
    options = {
      "hostname" = mkOption {
        description = "Hostname defines the FQDN hostname of the backend endpoint.";
        type = types.str;
      };
      "port" = mkOption {
        description = "Port defines the port of the backend endpoint.";
        type = types.int;
      };
    };
  };
  mkEndpointFqdn = res: {
    inherit (res) "hostname";
    inherit (res) "port";
  };
  EndpointIpModule = types.submodule {
    options = {
      "address" = mkOption {
        description = "Address defines the IP address of the backend endpoint.\nSupports both IPv4 and IPv6 addresses.";
        type = types.str;
      };
      "port" = mkOption {
        description = "Port defines the port of the backend endpoint.";
        type = types.int;
      };
    };
  };
  mkEndpointIp = res: {
    inherit (res) "address";
    inherit (res) "port";
  };
  EndpointModule = types.submodule {
    options = {
      "fqdn" = mkOption {
        description = "FQDN defines a FQDN endpoint";
        type = (types.nullOr EndpointFqdnModule);
        default = null;
      };
      "hostname" = mkOption {
        description = "Hostname defines an optional hostname for the backend endpoint.";
        type = (types.nullOr types.str);
        default = null;
      };
      "ip" = mkOption {
        description = "IP defines an IP endpoint. Supports both IPv4 and IPv6 addresses.";
        type = (types.nullOr EndpointIpModule);
        default = null;
      };
      "unix" = mkOption {
        description = "Unix defines the unix domain socket endpoint";
        type = (types.nullOr EndpointUnixModule);
        default = null;
      };
      "zone" = mkOption {
        description = "Zone defines the service zone of the backend endpoint.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkEndpoint =
    res:
    {
    }
    // optionalAttrs (res."fqdn" != null) { "fqdn" = mkEndpointFqdn res."fqdn"; }
    // {
    }
    // optionalAttrs (res."hostname" != null) { inherit (res) "hostname"; }
    // {
    }
    // optionalAttrs (res."ip" != null) { "ip" = mkEndpointIp res."ip"; }
    // {
    }
    // optionalAttrs (res."unix" != null) { "unix" = mkEndpointUnix res."unix"; }
    // {
    }
    // optionalAttrs (res."zone" != null) { inherit (res) "zone"; }
    // {
    };
  EndpointUnixModule = types.submodule {
    options = {
      "path" = mkOption {
        description = "Path defines the unix domain socket path of the backend endpoint.\nThe path length must not exceed 108 characters.";
        type = types.str;
      };
    };
  };
  mkEndpointUnix = res: {
    inherit (res) "path";
  };
  TlsCaCertificateRefModule = types.submodule {
    options = {
      "group" = mkOption {
        description = "Group is the group of the referent. For example, \"gateway.networking.k8s.io\".\nWhen unspecified or empty string, core API group is inferred.";
        type = types.str;
      };
      "kind" = mkOption {
        description = "Kind is kind of the referent. For example \"HTTPRoute\" or \"Service\".";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name is the name of the referent.";
        type = types.str;
      };
    };
  };
  mkTlsCaCertificateRef = res: {
    inherit (res) "group";
    inherit (res) "kind";
    inherit (res) "name";
  };
  TlsModule = types.submodule {
    options = {
      "caCertificateRefs" = mkOption {
        description = "CACertificateRefs contains one or more references to Kubernetes objects that\ncontain TLS certificates of the Certificate Authorities that can be used\nas a trust anchor to validate the certificates presented by the backend.\n\nA single reference to a Kubernetes ConfigMap or a Kubernetes Secret,\nwith the CA certificate in a key named `ca.crt` is currently supported.\n\nIf CACertificateRefs is empty or unspecified, then WellKnownCACertificates must be\nspecified. Only one of CACertificateRefs or WellKnownCACertificates may be specified,\nnot both.";
        type = (types.listOf TlsCaCertificateRefModule);
        default = [ ];
      };
      "insecureSkipVerify" = mkOption {
        description = "InsecureSkipVerify indicates whether the upstream's certificate verification\nshould be skipped. Defaults to \"false\".";
        type = types.bool;
        default = false;
      };
      "wellKnownCACertificates" = mkOption {
        description = "WellKnownCACertificates specifies whether system CA certificates may be used in\nthe TLS handshake between the gateway and backend pod.\n\nIf WellKnownCACertificates is unspecified or empty (\"\"), then CACertificateRefs\nmust be specified with at least one entry for a valid configuration. Only one of\nCACertificateRefs or WellKnownCACertificates may be specified, not both.";
        type = (types.nullOr (types.enum [ "System" ]));
        default = null;
      };
    };
  };
  mkTls =
    res:
    {
    }
    // optionalAttrs (res."caCertificateRefs" != [ ]) {
      "caCertificateRefs" = map mkTlsCaCertificateRef res."caCertificateRefs";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."wellKnownCACertificates" != null) {
      inherit (res) "wellKnownCACertificates";
    }
    // {
    };
  BackendsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this Backend resource.";
        };
        "appProtocols" = mkOption {
          description = "AppProtocols defines the application protocols to be supported when connecting to the backend.";
          type = (
            types.listOf (
              types.enum [
                "gateway.envoyproxy.io/h2c"
                "gateway.envoyproxy.io/ws"
                "gateway.envoyproxy.io/wss"
              ]
            )
          );
          default = [ ];
        };
        "endpoints" = mkOption {
          description = "Endpoints defines the endpoints to be used when connecting to the backend.";
          type = (types.listOf EndpointModule);
          default = [ ];
        };
        "fallback" = mkOption {
          description = "Fallback indicates whether the backend is designated as a fallback.\nIt is highly recommended to configure active or passive health checks to ensure that failover can be detected\nwhen the active backends become unhealthy and to automatically readjust once the primary backends are healthy again.\nThe overprovisioning factor is set to 1.4, meaning the fallback backends will only start receiving traffic when\nthe health of the active backends falls below 72%.";
          type = types.bool;
          default = false;
        };
        "tls" = mkOption {
          description = "TLS defines the TLS settings for the backend.\nIf TLS is specified here and a BackendTLSPolicy is also configured for the backend, the final TLS settings will\nbe a merge of both configurations. In case of overlapping fields, the values defined in the BackendTLSPolicy will\ntake precedence.";
          type = (types.nullOr TlsModule);
          default = null;
        };
        "type" = mkOption {
          description = "Type defines the type of the backend. Defaults to \"Endpoints\"";
          type = (
            types.nullOr (
              types.enum [
                "Endpoints"
                "DynamicResolver"
              ]
            )
          );
          default = "Endpoints";
        };
      };
    }
  );
  mkBackend = name: res: {
    apiVersion = "gateway.envoyproxy.io/v1alpha1";
    kind = "Backend";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."appProtocols" != [ ]) { inherit (res) "appProtocols"; }
    // {
    }
    // optionalAttrs (res."endpoints" != [ ]) { "endpoints" = map mkEndpoint res."endpoints"; }
    // {
    }
    // optionalAttrs res."fallback" { inherit (res) "fallback"; }
    // {
    }
    // optionalAttrs (res."tls" != null) { "tls" = mkTls res."tls"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkBackend cfg."backends");
in
{
  options.openkrill.apps."envoy-gateway" = {
    "backends" = mkOption {
      type = types.attrsOf BackendsModule;
      default = { };
      description = "Backend CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."envoy-gateway".content = allResources;
  };
}
