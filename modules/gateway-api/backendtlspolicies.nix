# Auto-generated openkrill module fragment for gateway-api
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."gateway-api";
  compact = filterAttrs (_: v: v != null);
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
      "sectionName" = mkOption {
        description = "SectionName is the name of a section within the target resource. When\nunspecified, this targetRef targets the entire resource. In the following\nresources, SectionName is interpreted as the following:\n\n* Gateway: Listener name\n* HTTPRoute: HTTPRouteRule name\n* Service: Port name\n\nIf a SectionName is specified, but does not exist on the targeted object,\nthe Policy must fail to attach, and the policy implementation should record\na `ResolvedRefs` or similar Condition in the Policy's status.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTargetRef =
    res:
    {
      inherit (res) "group";
      inherit (res) "kind";
      inherit (res) "name";
    }
    // optionalAttrs (res."sectionName" != null) { inherit (res) "sectionName"; }
    // {
    };
  ValidationCaCertificateRefModule = types.submodule {
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
  mkValidationCaCertificateRef = res: {
    inherit (res) "group";
    inherit (res) "kind";
    inherit (res) "name";
  };
  ValidationModule = types.submodule {
    options = {
      "caCertificateRefs" = mkOption {
        description = "CACertificateRefs contains one or more references to Kubernetes objects that\ncontain a PEM-encoded TLS CA certificate bundle, which is used to\nvalidate a TLS handshake between the Gateway and backend Pod.\n\nIf CACertificateRefs is empty or unspecified, then WellKnownCACertificates must be\nspecified. Only one of CACertificateRefs or WellKnownCACertificates may be specified,\nnot both. If CACertificateRefs is empty or unspecified, the configuration for\nWellKnownCACertificates MUST be honored instead if supported by the implementation.\n\nA CACertificateRef is invalid if:\n\n* It refers to a resource that cannot be resolved (e.g., the referenced resource\n  does not exist) or is misconfigured (e.g., a ConfigMap does not contain a key\n  named `ca.crt`). In this case, the Reason must be set to `InvalidCACertificateRef`\n  and the Message of the Condition must indicate which reference is invalid and why.\n\n* It refers to an unknown or unsupported kind of resource. In this case, the Reason\n  must be set to `InvalidKind` and the Message of the Condition must explain which\n  kind of resource is unknown or unsupported.\n\n* It refers to a resource in another namespace. This may change in future\n  spec updates.\n\nImplementations MAY choose to perform further validation of the certificate\ncontent (e.g., checking expiry or enforcing specific formats). In such cases,\nan implementation-specific Reason and Message must be set for the invalid reference.\n\nIn all cases, the implementation MUST ensure the `ResolvedRefs` Condition on\nthe BackendTLSPolicy is set to `status: False`, with a Reason and Message\nthat indicate the cause of the error. Connections using an invalid\nCACertificateRef MUST fail, and the client MUST receive an HTTP 5xx error\nresponse. If ALL CACertificateRefs are invalid, the implementation MUST also\nensure the `Accepted` Condition on the BackendTLSPolicy is set to\n`status: False`, with a Reason `NoValidCACertificate`.\n\nA single CACertificateRef to a Kubernetes ConfigMap kind has \"Core\" support.\nImplementations MAY choose to support attaching multiple certificates to\na backend, but this behavior is implementation-specific.\n\nSupport: Core - An optional single reference to a Kubernetes ConfigMap,\nwith the CA certificate in a key named `ca.crt`.\n\nSupport: Implementation-specific - More than one reference, other kinds\nof resources, or a single reference that includes multiple certificates.";
        type = (types.listOf ValidationCaCertificateRefModule);
        default = [ ];
      };
      "hostname" = mkOption {
        description = "Hostname is used for two purposes in the connection between Gateways and\nbackends:\n\n1. Hostname MUST be used as the SNI to connect to the backend (RFC 6066).\n2. Hostname MUST be used for authentication and MUST match the certificate\n   served by the matching backend, unless SubjectAltNames is specified.\n3. If SubjectAltNames are specified, Hostname can be used for certificate selection\n   but MUST NOT be used for authentication. If you want to use the value\n   of the Hostname field for authentication, you MUST add it to the SubjectAltNames list.\n\nSupport: Core";
        type = types.str;
      };
      "subjectAltNames" = mkOption {
        description = "SubjectAltNames contains one or more Subject Alternative Names.\nWhen specified the certificate served from the backend MUST\nhave at least one Subject Alternate Name matching one of the specified SubjectAltNames.\n\nSupport: Extended";
        type = (types.listOf ValidationSubjectAltNameModule);
        default = [ ];
      };
      "wellKnownCACertificates" = mkOption {
        description = "WellKnownCACertificates specifies whether a well-known set of CA certificates\nmay be used in the TLS handshake between the gateway and backend pod.\n\nIf WellKnownCACertificates is unspecified or empty (\"\"), then CACertificateRefs\nmust be specified with at least one entry for a valid configuration. Only one of\nCACertificateRefs or WellKnownCACertificates may be specified, not both.\nIf an implementation does not support the WellKnownCACertificates field, or\nthe supplied value is not recognized, the implementation MUST ensure the\n`Accepted` Condition on the BackendTLSPolicy is set to `status: False`, with\na Reason `Invalid`.\n\nValid values include:\n* \"System\" - indicates that well-known system CA certificates should be used.\n\nImplementations MAY define their own sets of CA certificates. Such definitions\nMUST use an implementation-specific, prefixed name, such as\n`mycompany.com/my-custom-ca-certificates`.\n\nSupport: Implementation-specific";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkValidation =
    res:
    {
    }
    // optionalAttrs (res."caCertificateRefs" != [ ]) {
      "caCertificateRefs" = map mkValidationCaCertificateRef res."caCertificateRefs";
    }
    // {
      inherit (res) "hostname";
    }
    // optionalAttrs (res."subjectAltNames" != [ ]) {
      "subjectAltNames" = map mkValidationSubjectAltName res."subjectAltNames";
    }
    // {
    }
    // optionalAttrs (res."wellKnownCACertificates" != null) {
      inherit (res) "wellKnownCACertificates";
    }
    // {
    };
  ValidationSubjectAltNameModule = types.submodule {
    options = {
      "hostname" = mkOption {
        description = "Hostname contains Subject Alternative Name specified in DNS name format.\nRequired when Type is set to Hostname, ignored otherwise.\n\nSupport: Core";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Type determines the format of the Subject Alternative Name. Always required.\n\nSupport: Core";
        type = (
          types.enum [
            "Hostname"
            "URI"
          ]
        );
      };
      "uri" = mkOption {
        description = "URI contains Subject Alternative Name specified in a full URI format.\nIt MUST include both a scheme (e.g., \"http\" or \"ftp\") and a scheme-specific-part.\nCommon values include SPIFFE IDs like \"spiffe://mycluster.example.com/ns/myns/sa/svc1sa\".\nRequired when Type is set to URI, ignored otherwise.\n\nSupport: Core";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkValidationSubjectAltName =
    res:
    {
    }
    // optionalAttrs (res."hostname" != null) { inherit (res) "hostname"; }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."uri" != null) { inherit (res) "uri"; }
    // {
    };
  BackendtlspoliciesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this BackendTLSPolicy resource.";
        };
        "options" = mkOption {
          description = "Options are a list of key/value pairs to enable extended TLS\nconfiguration for each implementation. For example, configuring the\nminimum TLS version or supported cipher suites.\n\nA set of common keys MAY be defined by the API in the future. To avoid\nany ambiguity, implementation-specific definitions MUST use\ndomain-prefixed names, such as `example.com/my-custom-option`.\nUn-prefixed names are reserved for key names defined by Gateway API.\n\nSupport: Implementation-specific";
          type = (types.attrsOf types.str);
          default = { };
        };
        "targetRefs" = mkOption {
          description = "TargetRefs identifies an API object to apply the policy to.\nNote that this config applies to the entire referenced resource\nby default, but this default may change in the future to provide\na more granular application of the policy.\n\nTargetRefs must be _distinct_. This means either that:\n\n* They select different targets. If this is the case, then targetRef\n  entries are distinct. In terms of fields, this means that the\n  multi-part key defined by `group`, `kind`, and `name` must\n  be unique across all targetRef entries in the BackendTLSPolicy.\n* They select different sectionNames in the same target.\n\nWhen more than one BackendTLSPolicy selects the same target and\nsectionName, implementations MUST determine precedence using the\nfollowing criteria, continuing on ties:\n\n* The older policy by creation timestamp takes precedence. For\n  example, a policy with a creation timestamp of \"2021-07-15\n  01:02:03\" MUST be given precedence over a policy with a\n  creation timestamp of \"2021-07-15 01:02:04\".\n* The policy appearing first in alphabetical order by {namespace}/{name}.\n  For example, a policy named `foo/bar` is given precedence over a\n  policy named `foo/baz`.\n\nFor any BackendTLSPolicy that does not take precedence, the\nimplementation MUST ensure the `Accepted` Condition is set to\n`status: False`, with Reason `Conflicted`.\n\nImplementations SHOULD NOT support more than one targetRef at this\ntime. Although the API technically allows for this, the current guidance\nfor conflict resolution and status handling is lacking. Until that can be\nclarified in a future release, the safest approach is to support a single\ntargetRef.\n\nSupport Levels:\n\n* Extended: Kubernetes Service referenced by HTTPRoute backendRefs.\n\n* Implementation-Specific: Services not connected via HTTPRoute, and any\n  other kind of backend. Implementations MAY use BackendTLSPolicy for:\n  - Services not referenced by any Route (e.g., infrastructure services)\n  - Gateway feature backends (e.g., ExternalAuth, rate-limiting services)\n  - Service mesh workload-to-service communication\n  - Other resource types beyond Service\n\nImplementations SHOULD aim to ensure that BackendTLSPolicy behavior is consistent,\neven outside of the extended HTTPRoute -(backendRef) -> Service path.\nThey SHOULD clearly document how BackendTLSPolicy is interpreted in these\nscenarios, including:\n  - Which resources beyond Service are supported\n  - How the policy is discovered and applied\n  - Any implementation-specific semantics or restrictions\n\nNote that this config applies to the entire referenced resource\nby default, but this default may change in the future to provide\na more granular application of the policy.";
          type = (types.listOf TargetRefModule);
        };
        "validation" = mkOption {
          description = "Validation contains backend TLS validation configuration.";
          type = ValidationModule;
        };
      };
    }
  );
  mkBackendTLSPolicy = name: res: {
    apiVersion = "gateway.networking.k8s.io/v1";
    kind = "BackendTLSPolicy";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."options" != { }) { inherit (res) "options"; }
    // {
      "targetRefs" = map mkTargetRef res."targetRefs";
      "validation" = mkValidation res."validation";
    };
  };
  allResources = (mapAttrsToList mkBackendTLSPolicy cfg."backendtlspolicies");
in
{
  options.openkrill.apps."gateway-api" = {
    "backendtlspolicies" = mkOption {
      type = types.attrsOf BackendtlspoliciesModule;
      default = { };
      description = "BackendTLSPolicy CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."gateway-api".content = allResources;
  };
}
