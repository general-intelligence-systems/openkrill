# Auto-generated openkrill module fragment for envoy-gateway
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."envoy-gateway";
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
        description = "Namespace is the namespace of the referent. When unspecified, this refers\nto the local namespace of the Route.\n\nNote that there are specific rules for ParentRefs which cross namespace\nboundaries. Cross-namespace references are only valid if they are explicitly\nallowed by something in the namespace they are referring to. For example:\nGateway has the AllowedRoutes field, and ReferenceGrant provides a\ngeneric way to enable any other kind of cross-namespace reference.\n\n\nParentRefs from a Route to a Service in the same namespace are \"producer\"\nroutes, which apply default routing rules to inbound connections from\nany namespace to the Service.\n\nParentRefs from a Route to a Service in a different namespace are\n\"consumer\" routes, and these routing rules are only applied to outbound\nconnections originating from the same namespace as the Route, for which\nthe intended destination of the connections are a Service targeted as a\nParentRef of the Route.\n\n\nSupport: Core";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Port is the network port this Route targets. It can be interpreted\ndifferently based on the type of parent resource.\n\nWhen the parent resource is a Gateway, this targets all listeners\nlistening on the specified port that also support this kind of Route(and\nselect this Route). It's not recommended to set `Port` unless the\nnetworking behaviors specified in a Route must apply to a specific port\nas opposed to a listener(s) whose port(s) may be changed. When both Port\nand SectionName are specified, the name and port of the selected listener\nmust match both specified values.\n\n\nWhen the parent resource is a Service, this targets a specific port in the\nService spec. When both Port (experimental) and SectionName are specified,\nthe name and port of the selected port must match both specified values.\n\n\nImplementations MAY choose to support other parent resources.\nImplementations supporting other types of parent resources MUST clearly\ndocument how/if Port is interpreted.\n\nFor the purpose of status, an attachment is considered successful as\nlong as the parent resource accepts it partially. For example, Gateway\nlisteners can restrict which Routes can attach to them by Route kind,\nnamespace, or hostname. If 1 of 2 Gateway listeners accept attachment\nfrom the referencing Route, the Route MUST be considered successfully\nattached. If no Gateway listeners accept attachment from this Route,\nthe Route MUST be considered detached from the Gateway.\n\nSupport: Extended";
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
  RuleBackendRefFilterExtensionRefModule = types.submodule {
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
  mkRuleBackendRefFilterExtensionRef = res: {
    inherit (res) "group";
    inherit (res) "kind";
    inherit (res) "name";
  };
  RuleBackendRefFilterModule = types.submodule {
    options = {
      "extensionRef" = mkOption {
        description = "ExtensionRef is an optional, implementation-specific extension to the\n\"filter\" behavior.  For example, resource \"myroutefilter\" in group\n\"networking.example.net\"). ExtensionRef MUST NOT be used for core and\nextended filters.\n\nSupport: Implementation-specific\n\nThis filter can be used multiple times within the same rule.";
        type = (types.nullOr RuleBackendRefFilterExtensionRefModule);
        default = null;
      };
      "requestHeaderModifier" = mkOption {
        description = "RequestHeaderModifier defines a schema for a filter that modifies request\nheaders.\n\nSupport: Core";
        type = (types.nullOr RuleBackendRefFilterRequestHeaderModifierModule);
        default = null;
      };
      "requestMirror" = mkOption {
        description = "RequestMirror defines a schema for a filter that mirrors requests.\nRequests are sent to the specified destination, but responses from\nthat destination are ignored.\n\nThis filter can be used multiple times within the same rule. Note that\nnot all implementations will be able to support mirroring to multiple\nbackends.\n\nSupport: Extended";
        type = (types.nullOr RuleBackendRefFilterRequestMirrorModule);
        default = null;
      };
      "responseHeaderModifier" = mkOption {
        description = "ResponseHeaderModifier defines a schema for a filter that modifies response\nheaders.\n\nSupport: Extended";
        type = (types.nullOr RuleBackendRefFilterResponseHeaderModifierModule);
        default = null;
      };
      "type" = mkOption {
        description = "Type identifies the type of filter to apply. As with other API fields,\ntypes are classified into three conformance levels:\n\n- Core: Filter types and their corresponding configuration defined by\n  \"Support: Core\" in this package, e.g. \"RequestHeaderModifier\". All\n  implementations supporting GRPCRoute MUST support core filters.\n\n- Extended: Filter types and their corresponding configuration defined by\n  \"Support: Extended\" in this package, e.g. \"RequestMirror\". Implementers\n  are encouraged to support extended filters.\n\n- Implementation-specific: Filters that are defined and supported by specific vendors.\n  In the future, filters showing convergence in behavior across multiple\n  implementations will be considered for inclusion in extended or core\n  conformance levels. Filter-specific configuration for such filters\n  is specified using the ExtensionRef field. `Type` MUST be set to\n  \"ExtensionRef\" for custom filters.\n\nImplementers are encouraged to define custom implementation types to\nextend the core API with implementation-specific behavior.\n\nIf a reference to a custom filter type cannot be resolved, the filter\nMUST NOT be skipped. Instead, requests that would have been processed by\nthat filter MUST receive a HTTP error response.";
        type = (
          types.enum [
            "ResponseHeaderModifier"
            "RequestHeaderModifier"
            "RequestMirror"
            "ExtensionRef"
          ]
        );
      };
    };
  };
  mkRuleBackendRefFilter =
    res:
    {
    }
    // optionalAttrs (res."extensionRef" != null) {
      "extensionRef" = mkRuleBackendRefFilterExtensionRef res."extensionRef";
    }
    // {
    }
    // optionalAttrs (res."requestHeaderModifier" != null) {
      "requestHeaderModifier" = mkRuleBackendRefFilterRequestHeaderModifier res."requestHeaderModifier";
    }
    // {
    }
    // optionalAttrs (res."requestMirror" != null) {
      "requestMirror" = mkRuleBackendRefFilterRequestMirror res."requestMirror";
    }
    // {
    }
    // optionalAttrs (res."responseHeaderModifier" != null) {
      "responseHeaderModifier" =
        mkRuleBackendRefFilterResponseHeaderModifier
          res."responseHeaderModifier";
    }
    // {
      inherit (res) "type";
    };
  RuleBackendRefFilterRequestHeaderModifierAddModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the name of the HTTP Header to be matched. Name matching MUST be\ncase-insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).\n\nIf multiple entries specify equivalent header names, the first entry with\nan equivalent name MUST be considered for a match. Subsequent entries\nwith an equivalent header name MUST be ignored. Due to the\ncase-insensitivity of header names, \"foo\" and \"Foo\" are considered\nequivalent.";
        type = types.str;
      };
      "value" = mkOption {
        description = "Value is the value of HTTP Header to be matched.";
        type = types.str;
      };
    };
  };
  mkRuleBackendRefFilterRequestHeaderModifierAdd = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  RuleBackendRefFilterRequestHeaderModifierModule = types.submodule {
    options = {
      "add" = mkOption {
        description = "Add adds the given header(s) (name, value) to the request\nbefore the action. It appends to any existing values associated\nwith the header name.\n\nInput:\n  GET /foo HTTP/1.1\n  my-header: foo\n\nConfig:\n  add:\n  - name: \"my-header\"\n    value: \"bar,baz\"\n\nOutput:\n  GET /foo HTTP/1.1\n  my-header: foo,bar,baz";
        type = (types.listOf RuleBackendRefFilterRequestHeaderModifierAddModule);
        default = [ ];
      };
      "remove" = mkOption {
        description = "Remove the given header(s) from the HTTP request before the action. The\nvalue of Remove is a list of HTTP header names. Note that the header\nnames are case-insensitive (see\nhttps://datatracker.ietf.org/doc/html/rfc2616#section-4.2).\n\nInput:\n  GET /foo HTTP/1.1\n  my-header1: foo\n  my-header2: bar\n  my-header3: baz\n\nConfig:\n  remove: [\"my-header1\", \"my-header3\"]\n\nOutput:\n  GET /foo HTTP/1.1\n  my-header2: bar";
        type = (types.listOf types.str);
        default = [ ];
      };
      "set" = mkOption {
        description = "Set overwrites the request with the given header (name, value)\nbefore the action.\n\nInput:\n  GET /foo HTTP/1.1\n  my-header: foo\n\nConfig:\n  set:\n  - name: \"my-header\"\n    value: \"bar\"\n\nOutput:\n  GET /foo HTTP/1.1\n  my-header: bar";
        type = (types.listOf RuleBackendRefFilterRequestHeaderModifierSetModule);
        default = [ ];
      };
    };
  };
  mkRuleBackendRefFilterRequestHeaderModifier =
    res:
    {
    }
    // optionalAttrs (res."add" != [ ]) {
      "add" = map mkRuleBackendRefFilterRequestHeaderModifierAdd res."add";
    }
    // {
    }
    // optionalAttrs (res."remove" != [ ]) { inherit (res) "remove"; }
    // {
    }
    // optionalAttrs (res."set" != [ ]) {
      "set" = map mkRuleBackendRefFilterRequestHeaderModifierSet res."set";
    }
    // {
    };
  RuleBackendRefFilterRequestHeaderModifierSetModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the name of the HTTP Header to be matched. Name matching MUST be\ncase-insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).\n\nIf multiple entries specify equivalent header names, the first entry with\nan equivalent name MUST be considered for a match. Subsequent entries\nwith an equivalent header name MUST be ignored. Due to the\ncase-insensitivity of header names, \"foo\" and \"Foo\" are considered\nequivalent.";
        type = types.str;
      };
      "value" = mkOption {
        description = "Value is the value of HTTP Header to be matched.";
        type = types.str;
      };
    };
  };
  mkRuleBackendRefFilterRequestHeaderModifierSet = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  RuleBackendRefFilterRequestMirrorBackendRefModule = types.submodule {
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
    };
  };
  mkRuleBackendRefFilterRequestMirrorBackendRef =
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
    };
  RuleBackendRefFilterRequestMirrorFractionModule = types.submodule {
    options = {
      "denominator" = mkOption {
        type = (types.nullOr types.int);
        default = 100;
      };
      "numerator" = mkOption {
        type = types.int;
      };
    };
  };
  mkRuleBackendRefFilterRequestMirrorFraction =
    res:
    {
    }
    // optionalAttrs (res."denominator" != null) { inherit (res) "denominator"; }
    // {
      inherit (res) "numerator";
    };
  RuleBackendRefFilterRequestMirrorModule = types.submodule {
    options = {
      "backendRef" = mkOption {
        description = "BackendRef references a resource where mirrored requests are sent.\n\nMirrored requests must be sent only to a single destination endpoint\nwithin this BackendRef, irrespective of how many endpoints are present\nwithin this BackendRef.\n\nIf the referent cannot be found, this BackendRef is invalid and must be\ndropped from the Gateway. The controller must ensure the \"ResolvedRefs\"\ncondition on the Route status is set to `status: False` and not configure\nthis backend in the underlying implementation.\n\nIf there is a cross-namespace reference to an *existing* object\nthat is not allowed by a ReferenceGrant, the controller must ensure the\n\"ResolvedRefs\"  condition on the Route is set to `status: False`,\nwith the \"RefNotPermitted\" reason and not configure this backend in the\nunderlying implementation.\n\nIn either error case, the Message of the `ResolvedRefs` Condition\nshould be used to provide more detail about the problem.\n\nSupport: Extended for Kubernetes Service\n\nSupport: Implementation-specific for any other resource";
        type = RuleBackendRefFilterRequestMirrorBackendRefModule;
      };
      "fraction" = mkOption {
        description = "Fraction represents the fraction of requests that should be\nmirrored to BackendRef.\n\nOnly one of Fraction or Percent may be specified. If neither field\nis specified, 100% of requests will be mirrored.";
        type = (types.nullOr RuleBackendRefFilterRequestMirrorFractionModule);
        default = null;
      };
      "percent" = mkOption {
        description = "Percent represents the percentage of requests that should be\nmirrored to BackendRef. Its minimum value is 0 (indicating 0% of\nrequests) and its maximum value is 100 (indicating 100% of requests).\n\nOnly one of Fraction or Percent may be specified. If neither field\nis specified, 100% of requests will be mirrored.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkRuleBackendRefFilterRequestMirror =
    res:
    {
      "backendRef" = mkRuleBackendRefFilterRequestMirrorBackendRef res."backendRef";
    }
    // optionalAttrs (res."fraction" != null) {
      "fraction" = mkRuleBackendRefFilterRequestMirrorFraction res."fraction";
    }
    // {
    }
    // optionalAttrs (res."percent" != null) { inherit (res) "percent"; }
    // {
    };
  RuleBackendRefFilterResponseHeaderModifierAddModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the name of the HTTP Header to be matched. Name matching MUST be\ncase-insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).\n\nIf multiple entries specify equivalent header names, the first entry with\nan equivalent name MUST be considered for a match. Subsequent entries\nwith an equivalent header name MUST be ignored. Due to the\ncase-insensitivity of header names, \"foo\" and \"Foo\" are considered\nequivalent.";
        type = types.str;
      };
      "value" = mkOption {
        description = "Value is the value of HTTP Header to be matched.";
        type = types.str;
      };
    };
  };
  mkRuleBackendRefFilterResponseHeaderModifierAdd = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  RuleBackendRefFilterResponseHeaderModifierModule = types.submodule {
    options = {
      "add" = mkOption {
        description = "Add adds the given header(s) (name, value) to the request\nbefore the action. It appends to any existing values associated\nwith the header name.\n\nInput:\n  GET /foo HTTP/1.1\n  my-header: foo\n\nConfig:\n  add:\n  - name: \"my-header\"\n    value: \"bar,baz\"\n\nOutput:\n  GET /foo HTTP/1.1\n  my-header: foo,bar,baz";
        type = (types.listOf RuleBackendRefFilterResponseHeaderModifierAddModule);
        default = [ ];
      };
      "remove" = mkOption {
        description = "Remove the given header(s) from the HTTP request before the action. The\nvalue of Remove is a list of HTTP header names. Note that the header\nnames are case-insensitive (see\nhttps://datatracker.ietf.org/doc/html/rfc2616#section-4.2).\n\nInput:\n  GET /foo HTTP/1.1\n  my-header1: foo\n  my-header2: bar\n  my-header3: baz\n\nConfig:\n  remove: [\"my-header1\", \"my-header3\"]\n\nOutput:\n  GET /foo HTTP/1.1\n  my-header2: bar";
        type = (types.listOf types.str);
        default = [ ];
      };
      "set" = mkOption {
        description = "Set overwrites the request with the given header (name, value)\nbefore the action.\n\nInput:\n  GET /foo HTTP/1.1\n  my-header: foo\n\nConfig:\n  set:\n  - name: \"my-header\"\n    value: \"bar\"\n\nOutput:\n  GET /foo HTTP/1.1\n  my-header: bar";
        type = (types.listOf RuleBackendRefFilterResponseHeaderModifierSetModule);
        default = [ ];
      };
    };
  };
  mkRuleBackendRefFilterResponseHeaderModifier =
    res:
    {
    }
    // optionalAttrs (res."add" != [ ]) {
      "add" = map mkRuleBackendRefFilterResponseHeaderModifierAdd res."add";
    }
    // {
    }
    // optionalAttrs (res."remove" != [ ]) { inherit (res) "remove"; }
    // {
    }
    // optionalAttrs (res."set" != [ ]) {
      "set" = map mkRuleBackendRefFilterResponseHeaderModifierSet res."set";
    }
    // {
    };
  RuleBackendRefFilterResponseHeaderModifierSetModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the name of the HTTP Header to be matched. Name matching MUST be\ncase-insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).\n\nIf multiple entries specify equivalent header names, the first entry with\nan equivalent name MUST be considered for a match. Subsequent entries\nwith an equivalent header name MUST be ignored. Due to the\ncase-insensitivity of header names, \"foo\" and \"Foo\" are considered\nequivalent.";
        type = types.str;
      };
      "value" = mkOption {
        description = "Value is the value of HTTP Header to be matched.";
        type = types.str;
      };
    };
  };
  mkRuleBackendRefFilterResponseHeaderModifierSet = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  RuleBackendRefModule = types.submodule {
    options = {
      "filters" = mkOption {
        description = "Filters defined at this level MUST be executed if and only if the\nrequest is being forwarded to the backend defined here.\n\nSupport: Implementation-specific (For broader support of filters, use the\nFilters field in GRPCRouteRule.)";
        type = (types.listOf RuleBackendRefFilterModule);
        default = [ ];
      };
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
    // optionalAttrs (res."filters" != [ ]) { "filters" = map mkRuleBackendRefFilter res."filters"; }
    // {
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
  RuleFilterExtensionRefModule = types.submodule {
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
  mkRuleFilterExtensionRef = res: {
    inherit (res) "group";
    inherit (res) "kind";
    inherit (res) "name";
  };
  RuleFilterModule = types.submodule {
    options = {
      "extensionRef" = mkOption {
        description = "ExtensionRef is an optional, implementation-specific extension to the\n\"filter\" behavior.  For example, resource \"myroutefilter\" in group\n\"networking.example.net\"). ExtensionRef MUST NOT be used for core and\nextended filters.\n\nSupport: Implementation-specific\n\nThis filter can be used multiple times within the same rule.";
        type = (types.nullOr RuleFilterExtensionRefModule);
        default = null;
      };
      "requestHeaderModifier" = mkOption {
        description = "RequestHeaderModifier defines a schema for a filter that modifies request\nheaders.\n\nSupport: Core";
        type = (types.nullOr RuleFilterRequestHeaderModifierModule);
        default = null;
      };
      "requestMirror" = mkOption {
        description = "RequestMirror defines a schema for a filter that mirrors requests.\nRequests are sent to the specified destination, but responses from\nthat destination are ignored.\n\nThis filter can be used multiple times within the same rule. Note that\nnot all implementations will be able to support mirroring to multiple\nbackends.\n\nSupport: Extended";
        type = (types.nullOr RuleFilterRequestMirrorModule);
        default = null;
      };
      "responseHeaderModifier" = mkOption {
        description = "ResponseHeaderModifier defines a schema for a filter that modifies response\nheaders.\n\nSupport: Extended";
        type = (types.nullOr RuleFilterResponseHeaderModifierModule);
        default = null;
      };
      "type" = mkOption {
        description = "Type identifies the type of filter to apply. As with other API fields,\ntypes are classified into three conformance levels:\n\n- Core: Filter types and their corresponding configuration defined by\n  \"Support: Core\" in this package, e.g. \"RequestHeaderModifier\". All\n  implementations supporting GRPCRoute MUST support core filters.\n\n- Extended: Filter types and their corresponding configuration defined by\n  \"Support: Extended\" in this package, e.g. \"RequestMirror\". Implementers\n  are encouraged to support extended filters.\n\n- Implementation-specific: Filters that are defined and supported by specific vendors.\n  In the future, filters showing convergence in behavior across multiple\n  implementations will be considered for inclusion in extended or core\n  conformance levels. Filter-specific configuration for such filters\n  is specified using the ExtensionRef field. `Type` MUST be set to\n  \"ExtensionRef\" for custom filters.\n\nImplementers are encouraged to define custom implementation types to\nextend the core API with implementation-specific behavior.\n\nIf a reference to a custom filter type cannot be resolved, the filter\nMUST NOT be skipped. Instead, requests that would have been processed by\nthat filter MUST receive a HTTP error response.";
        type = (
          types.enum [
            "ResponseHeaderModifier"
            "RequestHeaderModifier"
            "RequestMirror"
            "ExtensionRef"
          ]
        );
      };
    };
  };
  mkRuleFilter =
    res:
    {
    }
    // optionalAttrs (res."extensionRef" != null) {
      "extensionRef" = mkRuleFilterExtensionRef res."extensionRef";
    }
    // {
    }
    // optionalAttrs (res."requestHeaderModifier" != null) {
      "requestHeaderModifier" = mkRuleFilterRequestHeaderModifier res."requestHeaderModifier";
    }
    // {
    }
    // optionalAttrs (res."requestMirror" != null) {
      "requestMirror" = mkRuleFilterRequestMirror res."requestMirror";
    }
    // {
    }
    // optionalAttrs (res."responseHeaderModifier" != null) {
      "responseHeaderModifier" = mkRuleFilterResponseHeaderModifier res."responseHeaderModifier";
    }
    // {
      inherit (res) "type";
    };
  RuleFilterRequestHeaderModifierAddModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the name of the HTTP Header to be matched. Name matching MUST be\ncase-insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).\n\nIf multiple entries specify equivalent header names, the first entry with\nan equivalent name MUST be considered for a match. Subsequent entries\nwith an equivalent header name MUST be ignored. Due to the\ncase-insensitivity of header names, \"foo\" and \"Foo\" are considered\nequivalent.";
        type = types.str;
      };
      "value" = mkOption {
        description = "Value is the value of HTTP Header to be matched.";
        type = types.str;
      };
    };
  };
  mkRuleFilterRequestHeaderModifierAdd = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  RuleFilterRequestHeaderModifierModule = types.submodule {
    options = {
      "add" = mkOption {
        description = "Add adds the given header(s) (name, value) to the request\nbefore the action. It appends to any existing values associated\nwith the header name.\n\nInput:\n  GET /foo HTTP/1.1\n  my-header: foo\n\nConfig:\n  add:\n  - name: \"my-header\"\n    value: \"bar,baz\"\n\nOutput:\n  GET /foo HTTP/1.1\n  my-header: foo,bar,baz";
        type = (types.listOf RuleFilterRequestHeaderModifierAddModule);
        default = [ ];
      };
      "remove" = mkOption {
        description = "Remove the given header(s) from the HTTP request before the action. The\nvalue of Remove is a list of HTTP header names. Note that the header\nnames are case-insensitive (see\nhttps://datatracker.ietf.org/doc/html/rfc2616#section-4.2).\n\nInput:\n  GET /foo HTTP/1.1\n  my-header1: foo\n  my-header2: bar\n  my-header3: baz\n\nConfig:\n  remove: [\"my-header1\", \"my-header3\"]\n\nOutput:\n  GET /foo HTTP/1.1\n  my-header2: bar";
        type = (types.listOf types.str);
        default = [ ];
      };
      "set" = mkOption {
        description = "Set overwrites the request with the given header (name, value)\nbefore the action.\n\nInput:\n  GET /foo HTTP/1.1\n  my-header: foo\n\nConfig:\n  set:\n  - name: \"my-header\"\n    value: \"bar\"\n\nOutput:\n  GET /foo HTTP/1.1\n  my-header: bar";
        type = (types.listOf RuleFilterRequestHeaderModifierSetModule);
        default = [ ];
      };
    };
  };
  mkRuleFilterRequestHeaderModifier =
    res:
    {
    }
    // optionalAttrs (res."add" != [ ]) { "add" = map mkRuleFilterRequestHeaderModifierAdd res."add"; }
    // {
    }
    // optionalAttrs (res."remove" != [ ]) { inherit (res) "remove"; }
    // {
    }
    // optionalAttrs (res."set" != [ ]) { "set" = map mkRuleFilterRequestHeaderModifierSet res."set"; }
    // {
    };
  RuleFilterRequestHeaderModifierSetModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the name of the HTTP Header to be matched. Name matching MUST be\ncase-insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).\n\nIf multiple entries specify equivalent header names, the first entry with\nan equivalent name MUST be considered for a match. Subsequent entries\nwith an equivalent header name MUST be ignored. Due to the\ncase-insensitivity of header names, \"foo\" and \"Foo\" are considered\nequivalent.";
        type = types.str;
      };
      "value" = mkOption {
        description = "Value is the value of HTTP Header to be matched.";
        type = types.str;
      };
    };
  };
  mkRuleFilterRequestHeaderModifierSet = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  RuleFilterRequestMirrorBackendRefModule = types.submodule {
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
    };
  };
  mkRuleFilterRequestMirrorBackendRef =
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
    };
  RuleFilterRequestMirrorFractionModule = types.submodule {
    options = {
      "denominator" = mkOption {
        type = (types.nullOr types.int);
        default = 100;
      };
      "numerator" = mkOption {
        type = types.int;
      };
    };
  };
  mkRuleFilterRequestMirrorFraction =
    res:
    {
    }
    // optionalAttrs (res."denominator" != null) { inherit (res) "denominator"; }
    // {
      inherit (res) "numerator";
    };
  RuleFilterRequestMirrorModule = types.submodule {
    options = {
      "backendRef" = mkOption {
        description = "BackendRef references a resource where mirrored requests are sent.\n\nMirrored requests must be sent only to a single destination endpoint\nwithin this BackendRef, irrespective of how many endpoints are present\nwithin this BackendRef.\n\nIf the referent cannot be found, this BackendRef is invalid and must be\ndropped from the Gateway. The controller must ensure the \"ResolvedRefs\"\ncondition on the Route status is set to `status: False` and not configure\nthis backend in the underlying implementation.\n\nIf there is a cross-namespace reference to an *existing* object\nthat is not allowed by a ReferenceGrant, the controller must ensure the\n\"ResolvedRefs\"  condition on the Route is set to `status: False`,\nwith the \"RefNotPermitted\" reason and not configure this backend in the\nunderlying implementation.\n\nIn either error case, the Message of the `ResolvedRefs` Condition\nshould be used to provide more detail about the problem.\n\nSupport: Extended for Kubernetes Service\n\nSupport: Implementation-specific for any other resource";
        type = RuleFilterRequestMirrorBackendRefModule;
      };
      "fraction" = mkOption {
        description = "Fraction represents the fraction of requests that should be\nmirrored to BackendRef.\n\nOnly one of Fraction or Percent may be specified. If neither field\nis specified, 100% of requests will be mirrored.";
        type = (types.nullOr RuleFilterRequestMirrorFractionModule);
        default = null;
      };
      "percent" = mkOption {
        description = "Percent represents the percentage of requests that should be\nmirrored to BackendRef. Its minimum value is 0 (indicating 0% of\nrequests) and its maximum value is 100 (indicating 100% of requests).\n\nOnly one of Fraction or Percent may be specified. If neither field\nis specified, 100% of requests will be mirrored.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkRuleFilterRequestMirror =
    res:
    {
      "backendRef" = mkRuleFilterRequestMirrorBackendRef res."backendRef";
    }
    // optionalAttrs (res."fraction" != null) {
      "fraction" = mkRuleFilterRequestMirrorFraction res."fraction";
    }
    // {
    }
    // optionalAttrs (res."percent" != null) { inherit (res) "percent"; }
    // {
    };
  RuleFilterResponseHeaderModifierAddModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the name of the HTTP Header to be matched. Name matching MUST be\ncase-insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).\n\nIf multiple entries specify equivalent header names, the first entry with\nan equivalent name MUST be considered for a match. Subsequent entries\nwith an equivalent header name MUST be ignored. Due to the\ncase-insensitivity of header names, \"foo\" and \"Foo\" are considered\nequivalent.";
        type = types.str;
      };
      "value" = mkOption {
        description = "Value is the value of HTTP Header to be matched.";
        type = types.str;
      };
    };
  };
  mkRuleFilterResponseHeaderModifierAdd = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  RuleFilterResponseHeaderModifierModule = types.submodule {
    options = {
      "add" = mkOption {
        description = "Add adds the given header(s) (name, value) to the request\nbefore the action. It appends to any existing values associated\nwith the header name.\n\nInput:\n  GET /foo HTTP/1.1\n  my-header: foo\n\nConfig:\n  add:\n  - name: \"my-header\"\n    value: \"bar,baz\"\n\nOutput:\n  GET /foo HTTP/1.1\n  my-header: foo,bar,baz";
        type = (types.listOf RuleFilterResponseHeaderModifierAddModule);
        default = [ ];
      };
      "remove" = mkOption {
        description = "Remove the given header(s) from the HTTP request before the action. The\nvalue of Remove is a list of HTTP header names. Note that the header\nnames are case-insensitive (see\nhttps://datatracker.ietf.org/doc/html/rfc2616#section-4.2).\n\nInput:\n  GET /foo HTTP/1.1\n  my-header1: foo\n  my-header2: bar\n  my-header3: baz\n\nConfig:\n  remove: [\"my-header1\", \"my-header3\"]\n\nOutput:\n  GET /foo HTTP/1.1\n  my-header2: bar";
        type = (types.listOf types.str);
        default = [ ];
      };
      "set" = mkOption {
        description = "Set overwrites the request with the given header (name, value)\nbefore the action.\n\nInput:\n  GET /foo HTTP/1.1\n  my-header: foo\n\nConfig:\n  set:\n  - name: \"my-header\"\n    value: \"bar\"\n\nOutput:\n  GET /foo HTTP/1.1\n  my-header: bar";
        type = (types.listOf RuleFilterResponseHeaderModifierSetModule);
        default = [ ];
      };
    };
  };
  mkRuleFilterResponseHeaderModifier =
    res:
    {
    }
    // optionalAttrs (res."add" != [ ]) { "add" = map mkRuleFilterResponseHeaderModifierAdd res."add"; }
    // {
    }
    // optionalAttrs (res."remove" != [ ]) { inherit (res) "remove"; }
    // {
    }
    // optionalAttrs (res."set" != [ ]) { "set" = map mkRuleFilterResponseHeaderModifierSet res."set"; }
    // {
    };
  RuleFilterResponseHeaderModifierSetModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the name of the HTTP Header to be matched. Name matching MUST be\ncase-insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).\n\nIf multiple entries specify equivalent header names, the first entry with\nan equivalent name MUST be considered for a match. Subsequent entries\nwith an equivalent header name MUST be ignored. Due to the\ncase-insensitivity of header names, \"foo\" and \"Foo\" are considered\nequivalent.";
        type = types.str;
      };
      "value" = mkOption {
        description = "Value is the value of HTTP Header to be matched.";
        type = types.str;
      };
    };
  };
  mkRuleFilterResponseHeaderModifierSet = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  RuleMatcheHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the name of the gRPC Header to be matched.\n\nIf multiple entries specify equivalent header names, only the first\nentry with an equivalent name MUST be considered for a match. Subsequent\nentries with an equivalent header name MUST be ignored. Due to the\ncase-insensitivity of header names, \"foo\" and \"Foo\" are considered\nequivalent.";
        type = types.str;
      };
      "type" = mkOption {
        description = "Type specifies how to match against the value of the header.";
        type = (
          types.nullOr (
            types.enum [
              "Exact"
              "RegularExpression"
            ]
          )
        );
        default = "Exact";
      };
      "value" = mkOption {
        description = "Value is the value of the gRPC Header to be matched.";
        type = types.str;
      };
    };
  };
  mkRuleMatcheHeader =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
      inherit (res) "value";
    };
  RuleMatcheMethodModule = types.submodule {
    options = {
      "method" = mkOption {
        description = "Value of the method to match against. If left empty or omitted, will\nmatch all services.\n\nAt least one of Service and Method MUST be a non-empty string.";
        type = (types.nullOr types.str);
        default = null;
      };
      "service" = mkOption {
        description = "Value of the service to match against. If left empty or omitted, will\nmatch any service.\n\nAt least one of Service and Method MUST be a non-empty string.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Type specifies how to match against the service and/or method.\nSupport: Core (Exact with service and method specified)\n\nSupport: Implementation-specific (Exact with method specified but no service specified)\n\nSupport: Implementation-specific (RegularExpression)";
        type = (
          types.nullOr (
            types.enum [
              "Exact"
              "RegularExpression"
            ]
          )
        );
        default = "Exact";
      };
    };
  };
  mkRuleMatcheMethod =
    res:
    {
    }
    // optionalAttrs (res."method" != null) { inherit (res) "method"; }
    // {
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  RuleMatcheModule = types.submodule {
    options = {
      "headers" = mkOption {
        description = "Headers specifies gRPC request header matchers. Multiple match values are\nANDed together, meaning, a request MUST match all the specified headers\nto select the route.";
        type = (types.listOf RuleMatcheHeaderModule);
        default = [ ];
      };
      "method" = mkOption {
        description = "Method specifies a gRPC request service/method matcher. If this field is\nnot specified, all services and methods will match.";
        type = (types.nullOr RuleMatcheMethodModule);
        default = null;
      };
    };
  };
  mkRuleMatche =
    res:
    {
    }
    // optionalAttrs (res."headers" != [ ]) { "headers" = map mkRuleMatcheHeader res."headers"; }
    // {
    }
    // optionalAttrs (res."method" != null) { "method" = mkRuleMatcheMethod res."method"; }
    // {
    };
  RuleModule = types.submodule {
    options = {
      "backendRefs" = mkOption {
        description = "BackendRefs defines the backend(s) where matching requests should be\nsent.\n\nFailure behavior here depends on how many BackendRefs are specified and\nhow many are invalid.\n\nIf *all* entries in BackendRefs are invalid, and there are also no filters\nspecified in this route rule, *all* traffic which matches this rule MUST\nreceive an `UNAVAILABLE` status.\n\nSee the GRPCBackendRef definition for the rules about what makes a single\nGRPCBackendRef invalid.\n\nWhen a GRPCBackendRef is invalid, `UNAVAILABLE` statuses MUST be returned for\nrequests that would have otherwise been routed to an invalid backend. If\nmultiple backends are specified, and some are invalid, the proportion of\nrequests that would otherwise have been routed to an invalid backend\nMUST receive an `UNAVAILABLE` status.\n\nFor example, if two backends are specified with equal weights, and one is\ninvalid, 50 percent of traffic MUST receive an `UNAVAILABLE` status.\nImplementations may choose how that 50 percent is determined.\n\nSupport: Core for Kubernetes Service\n\nSupport: Implementation-specific for any other resource\n\nSupport for weight: Core";
        type = (types.listOf RuleBackendRefModule);
        default = [ ];
      };
      "filters" = mkOption {
        description = "Filters define the filters that are applied to requests that match\nthis rule.\n\nThe effects of ordering of multiple behaviors are currently unspecified.\nThis can change in the future based on feedback during the alpha stage.\n\nConformance-levels at this level are defined based on the type of filter:\n\n- ALL core filters MUST be supported by all implementations that support\n  GRPCRoute.\n- Implementers are encouraged to support extended filters.\n- Implementation-specific custom filters have no API guarantees across\n  implementations.\n\nSpecifying the same filter multiple times is not supported unless explicitly\nindicated in the filter.\n\nIf an implementation cannot support a combination of filters, it must clearly\ndocument that limitation. In cases where incompatible or unsupported\nfilters are specified and cause the `Accepted` condition to be set to status\n`False`, implementations may use the `IncompatibleFilters` reason to specify\nthis configuration error.\n\nSupport: Core";
        type = (types.listOf RuleFilterModule);
        default = [ ];
      };
      "matches" = mkOption {
        description = "Matches define conditions used for matching the rule against incoming\ngRPC requests. Each match is independent, i.e. this rule will be matched\nif **any** one of the matches is satisfied.\n\nFor example, take the following matches configuration:\n\n```\nmatches:\n- method:\n    service: foo.bar\n  headers:\n    values:\n      version: 2\n- method:\n    service: foo.bar.v2\n```\n\nFor a request to match against this rule, it MUST satisfy\nEITHER of the two conditions:\n\n- service of foo.bar AND contains the header `version: 2`\n- service of foo.bar.v2\n\nSee the documentation for GRPCRouteMatch on how to specify multiple\nmatch conditions to be ANDed together.\n\nIf no matches are specified, the implementation MUST match every gRPC request.\n\nProxy or Load Balancer routing configuration generated from GRPCRoutes\nMUST prioritize rules based on the following criteria, continuing on\nties. Merging MUST not be done between GRPCRoutes and HTTPRoutes.\nPrecedence MUST be given to the rule with the largest number of:\n\n* Characters in a matching non-wildcard hostname.\n* Characters in a matching hostname.\n* Characters in a matching service.\n* Characters in a matching method.\n* Header matches.\n\nIf ties still exist across multiple Routes, matching precedence MUST be\ndetermined in order of the following criteria, continuing on ties:\n\n* The oldest Route based on creation timestamp.\n* The Route appearing first in alphabetical order by\n  \"{namespace}/{name}\".\n\nIf ties still exist within the Route that has been given precedence,\nmatching precedence MUST be granted to the first matching rule meeting\nthe above criteria.";
        type = (types.listOf RuleMatcheModule);
        default = [ ];
      };
      "name" = mkOption {
        description = "Name is the name of the route rule. This name MUST be unique within a Route if it is set.\n\nSupport: Extended";
        type = (types.nullOr types.str);
        default = null;
      };
      "sessionPersistence" = mkOption {
        description = "SessionPersistence defines and configures session persistence\nfor the route rule.\n\nSupport: Extended";
        type = (types.nullOr RuleSessionPersistenceModule);
        default = null;
      };
    };
  };
  mkRule =
    res:
    {
    }
    // optionalAttrs (res."backendRefs" != [ ]) {
      "backendRefs" = map mkRuleBackendRef res."backendRefs";
    }
    // {
    }
    // optionalAttrs (res."filters" != [ ]) { "filters" = map mkRuleFilter res."filters"; }
    // {
    }
    // optionalAttrs (res."matches" != [ ]) { "matches" = map mkRuleMatche res."matches"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."sessionPersistence" != null) {
      "sessionPersistence" = mkRuleSessionPersistence res."sessionPersistence";
    }
    // {
    };
  RuleSessionPersistenceCookieConfigModule = types.submodule {
    options = {
      "lifetimeType" = mkOption {
        description = "LifetimeType specifies whether the cookie has a permanent or\nsession-based lifetime. A permanent cookie persists until its\nspecified expiry time, defined by the Expires or Max-Age cookie\nattributes, while a session cookie is deleted when the current\nsession ends.\n\nWhen set to \"Permanent\", AbsoluteTimeout indicates the\ncookie's lifetime via the Expires or Max-Age cookie attributes\nand is required.\n\nWhen set to \"Session\", AbsoluteTimeout indicates the\nabsolute lifetime of the cookie tracked by the gateway and\nis optional.\n\nDefaults to \"Session\".\n\nSupport: Core for \"Session\" type\n\nSupport: Extended for \"Permanent\" type";
        type = (
          types.nullOr (
            types.enum [
              "Permanent"
              "Session"
            ]
          )
        );
        default = "Session";
      };
    };
  };
  mkRuleSessionPersistenceCookieConfig =
    res:
    {
    }
    // optionalAttrs (res."lifetimeType" != null) { inherit (res) "lifetimeType"; }
    // {
    };
  RuleSessionPersistenceModule = types.submodule {
    options = {
      "absoluteTimeout" = mkOption {
        description = "AbsoluteTimeout defines the absolute timeout of the persistent\nsession. Once the AbsoluteTimeout duration has elapsed, the\nsession becomes invalid.\n\nSupport: Extended";
        type = (types.nullOr types.str);
        default = null;
      };
      "cookieConfig" = mkOption {
        description = "CookieConfig provides configuration settings that are specific\nto cookie-based session persistence.\n\nSupport: Core";
        type = (types.nullOr RuleSessionPersistenceCookieConfigModule);
        default = null;
      };
      "idleTimeout" = mkOption {
        description = "IdleTimeout defines the idle timeout of the persistent session.\nOnce the session has been idle for more than the specified\nIdleTimeout duration, the session becomes invalid.\n\nSupport: Extended";
        type = (types.nullOr types.str);
        default = null;
      };
      "sessionName" = mkOption {
        description = "SessionName defines the name of the persistent session token\nwhich may be reflected in the cookie or the header. Users\nshould avoid reusing session names to prevent unintended\nconsequences, such as rejection or unpredictable behavior.\n\nSupport: Implementation-specific";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Type defines the type of session persistence such as through\nthe use a header or cookie. Defaults to cookie based session\npersistence.\n\nSupport: Core for \"Cookie\" type\n\nSupport: Extended for \"Header\" type";
        type = (
          types.nullOr (
            types.enum [
              "Cookie"
              "Header"
            ]
          )
        );
        default = "Cookie";
      };
    };
  };
  mkRuleSessionPersistence =
    res:
    {
    }
    // optionalAttrs (res."absoluteTimeout" != null) { inherit (res) "absoluteTimeout"; }
    // {
    }
    // optionalAttrs (res."cookieConfig" != null) {
      "cookieConfig" = mkRuleSessionPersistenceCookieConfig res."cookieConfig";
    }
    // {
    }
    // optionalAttrs (res."idleTimeout" != null) { inherit (res) "idleTimeout"; }
    // {
    }
    // optionalAttrs (res."sessionName" != null) { inherit (res) "sessionName"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  GrpcroutesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this GRPCRoute resource.";
        };
        "hostnames" = mkOption {
          description = "Hostnames defines a set of hostnames to match against the GRPC\nHost header to select a GRPCRoute to process the request. This matches\nthe RFC 1123 definition of a hostname with 2 notable exceptions:\n\n1. IPs are not allowed.\n2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard\n   label MUST appear by itself as the first label.\n\nIf a hostname is specified by both the Listener and GRPCRoute, there\nMUST be at least one intersecting hostname for the GRPCRoute to be\nattached to the Listener. For example:\n\n* A Listener with `test.example.com` as the hostname matches GRPCRoutes\n  that have either not specified any hostnames, or have specified at\n  least one of `test.example.com` or `*.example.com`.\n* A Listener with `*.example.com` as the hostname matches GRPCRoutes\n  that have either not specified any hostnames or have specified at least\n  one hostname that matches the Listener hostname. For example,\n  `test.example.com` and `*.example.com` would both match. On the other\n  hand, `example.com` and `test.example.net` would not match.\n\nHostnames that are prefixed with a wildcard label (`*.`) are interpreted\nas a suffix match. That means that a match for `*.example.com` would match\nboth `test.example.com`, and `foo.test.example.com`, but not `example.com`.\n\nIf both the Listener and GRPCRoute have specified hostnames, any\nGRPCRoute hostnames that do not match the Listener hostname MUST be\nignored. For example, if a Listener specified `*.example.com`, and the\nGRPCRoute specified `test.example.com` and `test.example.net`,\n`test.example.net` MUST NOT be considered for a match.\n\nIf both the Listener and GRPCRoute have specified hostnames, and none\nmatch with the criteria above, then the GRPCRoute MUST NOT be accepted by\nthe implementation. The implementation MUST raise an 'Accepted' Condition\nwith a status of `False` in the corresponding RouteParentStatus.\n\nIf a Route (A) of type HTTPRoute or GRPCRoute is attached to a\nListener and that listener already has another Route (B) of the other\ntype attached and the intersection of the hostnames of A and B is\nnon-empty, then the implementation MUST accept exactly one of these two\nroutes, determined by the following criteria, in order:\n\n* The oldest Route based on creation timestamp.\n* The Route appearing first in alphabetical order by\n  \"{namespace}/{name}\".\n\nThe rejected Route MUST raise an 'Accepted' condition with a status of\n'False' in the corresponding RouteParentStatus.\n\nSupport: Core";
          type = (types.listOf types.str);
          default = [ ];
        };
        "parentRefs" = mkOption {
          description = "ParentRefs references the resources (usually Gateways) that a Route wants\nto be attached to. Note that the referenced parent resource needs to\nallow this for the attachment to be complete. For Gateways, that means\nthe Gateway needs to allow attachment from Routes of this kind and\nnamespace. For Services, that means the Service must either be in the same\nnamespace for a \"producer\" route, or the mesh implementation must support\nand allow \"consumer\" routes for the referenced Service. ReferenceGrant is\nnot applicable for governing ParentRefs to Services - it is not possible to\ncreate a \"producer\" route for a Service in a different namespace from the\nRoute.\n\nThere are two kinds of parent resources with \"Core\" support:\n\n* Gateway (Gateway conformance profile)\n* Service (Mesh conformance profile, ClusterIP Services only)\n\nThis API may be extended in the future to support additional kinds of parent\nresources.\n\nParentRefs must be _distinct_. This means either that:\n\n* They select different objects.  If this is the case, then parentRef\n  entries are distinct. In terms of fields, this means that the\n  multi-part key defined by `group`, `kind`, `namespace`, and `name` must\n  be unique across all parentRef entries in the Route.\n* They do not select different objects, but for each optional field used,\n  each ParentRef that selects the same object must set the same set of\n  optional fields to different values. If one ParentRef sets a\n  combination of optional fields, all must set the same combination.\n\nSome examples:\n\n* If one ParentRef sets `sectionName`, all ParentRefs referencing the\n  same object must also set `sectionName`.\n* If one ParentRef sets `port`, all ParentRefs referencing the same\n  object must also set `port`.\n* If one ParentRef sets `sectionName` and `port`, all ParentRefs\n  referencing the same object must also set `sectionName` and `port`.\n\nIt is possible to separately reference multiple distinct objects that may\nbe collapsed by an implementation. For example, some implementations may\nchoose to merge compatible Gateway Listeners together. If that is the\ncase, the list of routes attached to those resources should also be\nmerged.\n\nNote that for ParentRefs that cross namespace boundaries, there are specific\nrules. Cross-namespace references are only valid if they are explicitly\nallowed by something in the namespace they are referring to. For example,\nGateway has the AllowedRoutes field, and ReferenceGrant provides a\ngeneric way to enable other kinds of cross-namespace reference.\n\n\nParentRefs from a Route to a Service in the same namespace are \"producer\"\nroutes, which apply default routing rules to inbound connections from\nany namespace to the Service.\n\nParentRefs from a Route to a Service in a different namespace are\n\"consumer\" routes, and these routing rules are only applied to outbound\nconnections originating from the same namespace as the Route, for which\nthe intended destination of the connections are a Service targeted as a\nParentRef of the Route.";
          type = (types.listOf ParentRefModule);
          default = [ ];
        };
        "rules" = mkOption {
          description = "Rules are a list of GRPC matchers, filters and actions.";
          type = (types.listOf RuleModule);
          default = [ ];
        };
      };
    }
  );
  mkGRPCRoute = name: res: {
    apiVersion = "gateway.networking.k8s.io/v1";
    kind = "GRPCRoute";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."hostnames" != [ ]) { inherit (res) "hostnames"; }
    // {
    }
    // optionalAttrs (res."parentRefs" != [ ]) { "parentRefs" = map mkParentRef res."parentRefs"; }
    // {
    }
    // optionalAttrs (res."rules" != [ ]) { "rules" = map mkRule res."rules"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkGRPCRoute cfg."grpcroutes");
in
{
  options.openkrill.apps."envoy-gateway" = {
    "grpcroutes" = mkOption {
      type = types.attrsOf GrpcroutesModule;
      default = { };
      description = "GRPCRoute CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."envoy-gateway".content = allResources;
  };
}
