# Auto-generated openkrill module fragment for gateway-api
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."gateway-api";
  compact = filterAttrs (_: v: v != null);
  ParentRefModule = types.submodule {
    options = {
      "group" = mkOption {
        description = "Group is the group of the referent.\nWhen unspecified, \"gateway.networking.k8s.io\" is inferred.\nTo set the core API group (such as for a \"Service\" kind referent),\nGroup must be explicitly set to \"\" (empty string).\n\nSupport: Core";
        type = (types.nullOr types.str);
        default = "gateway.networking.k8s.io";
      };
      "kind" = mkOption {
        description = "Kind is kind of the referent.\n\nThere are two kinds of parent resources with \"Core\" support:\n\n* Gateway (Gateway conformance profile)\n* Service (Mesh conformance profile, ClusterIP Services only)\n\nSupport for other resources is Implementation-Specific.";
        type = (types.nullOr types.str);
        default = "Gateway";
      };
      "name" = mkOption {
        description = "Name is the name of the referent.\n\nSupport: Core";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "Namespace is the namespace of the referent. When unspecified, this refers\nto the local namespace of the Route.\n\nNote that there are specific rules for ParentRefs which cross namespace\nboundaries. Cross-namespace references are only valid if they are explicitly\nallowed by something in the namespace they are referring to. For example:\nGateway has the AllowedRoutes field, and ReferenceGrant provides a\ngeneric way to enable any other kind of cross-namespace reference.\n\nSupport: Core";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Port is the network port this Route targets. It can be interpreted\ndifferently based on the type of parent resource.\n\nWhen the parent resource is a Gateway, this targets all listeners\nlistening on the specified port that also support this kind of Route(and\nselect this Route). It's not recommended to set `Port` unless the\nnetworking behaviors specified in a Route must apply to a specific port\nas opposed to a listener(s) whose port(s) may be changed. When both Port\nand SectionName are specified, the name and port of the selected listener\nmust match both specified values.\n\nImplementations MAY choose to support other parent resources.\nImplementations supporting other types of parent resources MUST clearly\ndocument how/if Port is interpreted.\n\nFor the purpose of status, an attachment is considered successful as\nlong as the parent resource accepts it partially. For example, Gateway\nlisteners can restrict which Routes can attach to them by Route kind,\nnamespace, or hostname. If 1 of 2 Gateway listeners accept attachment\nfrom the referencing Route, the Route MUST be considered successfully\nattached. If no Gateway listeners accept attachment from this Route,\nthe Route MUST be considered detached from the Gateway.\n\nSupport: Extended";
        type = (types.nullOr types.int);
        default = null;
      };
      "sectionName" = mkOption {
        description = "SectionName is the name of a section within the target resource. In the\nfollowing resources, SectionName is interpreted as the following:\n\n* Gateway: Listener name. When both Port (experimental) and SectionName\nare specified, the name and port of the selected listener must match\nboth specified values.\n* Service: Port name. When both Port (experimental) and SectionName\nare specified, the name and port of the selected listener must match\nboth specified values.\n\nImplementations MAY choose to support attaching Routes to other resources.\nIf that is the case, they MUST clearly document how SectionName is\ninterpreted.\n\nWhen unspecified (empty string), this will reference the entire resource.\nFor the purpose of status, an attachment is considered successful if at\nleast one section in the parent resource accepts it. For example, Gateway\nlisteners can restrict which Routes can attach to them by Route kind,\nnamespace, or hostname. If 1 of 2 Gateway listeners accept attachment from\nthe referencing Route, the Route MUST be considered successfully\nattached. If no Gateway listeners accept attachment from this Route, the\nRoute MUST be considered detached from the Gateway.\n\nSupport: Core";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkParentRef =
    res:
    {
    }
    // optionalAttrs (res."group" != null) { inherit (res) "group"; }
    // {
    }
    // optionalAttrs (res."kind" != null) { inherit (res) "kind"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
    }
    // optionalAttrs (res."sectionName" != null) { inherit (res) "sectionName"; }
    // {
    };
  RuleBackendRefModule = types.submodule {
    options = {
      "group" = mkOption {
        description = "Group is the group of the referent. For example, \"gateway.networking.k8s.io\".\nWhen unspecified or empty string, core API group is inferred.";
        type = (types.nullOr types.str);
        default = "";
      };
      "kind" = mkOption {
        description = "Kind is the Kubernetes resource kind of the referent. For example\n\"Service\".\n\nDefaults to \"Service\" when not specified.\n\nExternalName services can refer to CNAME DNS records that may live\noutside of the cluster and as such are difficult to reason about in\nterms of conformance. They also may not be safe to forward to (see\nCVE-2021-25740 for more information). Implementations SHOULD NOT\nsupport ExternalName Services.\n\nSupport: Core (Services with a type other than ExternalName)\n\nSupport: Implementation-specific (Services with type ExternalName)";
        type = (types.nullOr types.str);
        default = "Service";
      };
      "name" = mkOption {
        description = "Name is the name of the referent.";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "Namespace is the namespace of the backend. When unspecified, the local\nnamespace is inferred.\n\nNote that when a namespace different than the local namespace is specified,\na ReferenceGrant object is required in the referent namespace to allow that\nnamespace's owner to accept the reference. See the ReferenceGrant\ndocumentation for details.\n\nSupport: Core";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Port specifies the destination port number to use for this resource.\nPort is required when the referent is a Kubernetes Service. In this\ncase, the port number is the service port number, not the target port.\nFor other resources, destination port might be derived from the referent\nresource or this field.";
        type = (types.nullOr types.int);
        default = null;
      };
      "weight" = mkOption {
        description = "Weight specifies the proportion of requests forwarded to the referenced\nbackend. This is computed as weight/(sum of all weights in this\nBackendRefs list). For non-zero values, there may be some epsilon from\nthe exact proportion defined here depending on the precision an\nimplementation supports. Weight is not a percentage and the sum of\nweights does not need to equal 100.\n\nIf only one backend is specified and it has a weight greater than 0, 100%\nof the traffic is forwarded to that backend. If weight is set to 0, no\ntraffic should be forwarded for this entry. If unspecified, weight\ndefaults to 1.\n\nSupport for this field varies based on the context where used.";
        type = (types.nullOr types.int);
        default = 1;
      };
    };
  };
  mkRuleBackendRef =
    res:
    {
    }
    // optionalAttrs (res."group" != null) { inherit (res) "group"; }
    // {
    }
    // optionalAttrs (res."kind" != null) { inherit (res) "kind"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
    }
    // optionalAttrs (res."weight" != null) { inherit (res) "weight"; }
    // {
    };
  RuleModule = types.submodule {
    options = {
      "backendRefs" = mkOption {
        description = "BackendRefs defines the backend(s) where matching requests should be\nsent. If unspecified or invalid (refers to a nonexistent resource or\na Service with no endpoints), the rule performs no forwarding; if no\nfilters are specified that would result in a response being sent, the\nunderlying implementation must actively reject request attempts to this\nbackend, by rejecting the connection. Request rejections must respect\nweight; if an invalid backend is requested to have 80% of requests, then\n80% of requests must be rejected instead.\n\nSupport: Core for Kubernetes Service\n\nSupport: Extended for Kubernetes ServiceImport\n\nSupport: Implementation-specific for any other resource\n\nSupport for weight: Extended";
        type = (types.listOf RuleBackendRefModule);
      };
      "name" = mkOption {
        description = "Name is the name of the route rule. This name MUST be unique within a Route if it is set.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkRule =
    res:
    {
      "backendRefs" = map mkRuleBackendRef res."backendRefs";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  TlsroutesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this TLSRoute resource.";
        };
        "hostnames" = mkOption {
          description = "Hostnames defines a set of SNI hostnames that should match against the\nSNI attribute of TLS ClientHello message in TLS handshake. This matches\nthe RFC 1123 definition of a hostname with 2 notable exceptions:\n\n1. IPs are not allowed in SNI hostnames per RFC 6066.\n2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard\n   label must appear by itself as the first label.";
          type = (types.listOf types.str);
        };
        "parentRefs" = mkOption {
          description = "ParentRefs references the resources (usually Gateways) that a Route wants\nto be attached to. Note that the referenced parent resource needs to\nallow this for the attachment to be complete. For Gateways, that means\nthe Gateway needs to allow attachment from Routes of this kind and\nnamespace. For Services, that means the Service must either be in the same\nnamespace for a \"producer\" route, or the mesh implementation must support\nand allow \"consumer\" routes for the referenced Service. ReferenceGrant is\nnot applicable for governing ParentRefs to Services - it is not possible to\ncreate a \"producer\" route for a Service in a different namespace from the\nRoute.\n\nThere are two kinds of parent resources with \"Core\" support:\n\n* Gateway (Gateway conformance profile)\n* Service (Mesh conformance profile, ClusterIP Services only)\n\nThis API may be extended in the future to support additional kinds of parent\nresources.\n\nParentRefs must be _distinct_. This means either that:\n\n* They select different objects.  If this is the case, then parentRef\n  entries are distinct. In terms of fields, this means that the\n  multi-part key defined by `group`, `kind`, `namespace`, and `name` must\n  be unique across all parentRef entries in the Route.\n* They do not select different objects, but for each optional field used,\n  each ParentRef that selects the same object must set the same set of\n  optional fields to different values. If one ParentRef sets a\n  combination of optional fields, all must set the same combination.\n\nSome examples:\n\n* If one ParentRef sets `sectionName`, all ParentRefs referencing the\n  same object must also set `sectionName`.\n* If one ParentRef sets `port`, all ParentRefs referencing the same\n  object must also set `port`.\n* If one ParentRef sets `sectionName` and `port`, all ParentRefs\n  referencing the same object must also set `sectionName` and `port`.\n\nIt is possible to separately reference multiple distinct objects that may\nbe collapsed by an implementation. For example, some implementations may\nchoose to merge compatible Gateway Listeners together. If that is the\ncase, the list of routes attached to those resources should also be\nmerged.\n\nNote that for ParentRefs that cross namespace boundaries, there are specific\nrules. Cross-namespace references are only valid if they are explicitly\nallowed by something in the namespace they are referring to. For example,\nGateway has the AllowedRoutes field, and ReferenceGrant provides a\ngeneric way to enable other kinds of cross-namespace reference.";
          type = (types.listOf ParentRefModule);
          default = [ ];
        };
        "rules" = mkOption {
          description = "Rules are a list of actions.";
          type = (types.listOf RuleModule);
        };
      };
    }
  );
  mkTLSRoute = name: res: {
    apiVersion = "gateway.networking.k8s.io/v1";
    kind = "TLSRoute";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
      inherit (res) "hostnames";
    }
    // optionalAttrs (res."parentRefs" != [ ]) { "parentRefs" = map mkParentRef res."parentRefs"; }
    // {
      "rules" = map mkRule res."rules";
    };
  };
  allResources = (mapAttrsToList mkTLSRoute cfg."tlsroutes");
in
{
  options.openkrill.apps."gateway-api" = {
    "tlsroutes" = mkOption {
      type = types.attrsOf TlsroutesModule;
      default = { };
      description = "TLSRoute CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."gateway-api".content = allResources;
  };
}
