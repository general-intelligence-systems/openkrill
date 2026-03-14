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
  RuleBackendRefFilterCorsModule = types.submodule {
    options = {
      "allowCredentials" = mkOption {
        description = "AllowCredentials indicates whether the actual cross-origin request allows\nto include credentials.\n\nThe only valid value for the `Access-Control-Allow-Credentials` response\nheader is true (case-sensitive).\n\nIf the credentials are not allowed in cross-origin requests, the gateway\nwill omit the header `Access-Control-Allow-Credentials` entirely rather\nthan setting its value to false.\n\nSupport: Extended";
        type = (types.enum [ true ]);
        default = false;
      };
      "allowHeaders" = mkOption {
        description = "AllowHeaders indicates which HTTP request headers are supported for\naccessing the requested resource.\n\nHeader names are not case sensitive.\n\nMultiple header names in the value of the `Access-Control-Allow-Headers`\nresponse header are separated by a comma (\",\").\n\nWhen the `AllowHeaders` field is configured with one or more headers, the\ngateway must return the `Access-Control-Allow-Headers` response header\nwhich value is present in the `AllowHeaders` field.\n\nIf any header name in the `Access-Control-Request-Headers` request header\nis not included in the list of header names specified by the response\nheader `Access-Control-Allow-Headers`, it will present an error on the\nclient side.\n\nIf any header name in the `Access-Control-Allow-Headers` response header\ndoes not recognize by the client, it will also occur an error on the\nclient side.\n\nA wildcard indicates that the requests with all HTTP headers are allowed.\nThe `Access-Control-Allow-Headers` response header can only use `*`\nwildcard as value when the `AllowCredentials` field is unspecified.\n\nWhen the `AllowCredentials` field is specified and `AllowHeaders` field\nspecified with the `*` wildcard, the gateway must specify one or more\nHTTP headers in the value of the `Access-Control-Allow-Headers` response\nheader. The value of the header `Access-Control-Allow-Headers` is same as\nthe `Access-Control-Request-Headers` header provided by the client. If\nthe header `Access-Control-Request-Headers` is not included in the\nrequest, the gateway will omit the `Access-Control-Allow-Headers`\nresponse header, instead of specifying the `*` wildcard. A Gateway\nimplementation may choose to add implementation-specific default headers.\n\nSupport: Extended";
        type = (types.listOf types.str);
        default = [ ];
      };
      "allowMethods" = mkOption {
        description = "AllowMethods indicates which HTTP methods are supported for accessing the\nrequested resource.\n\nValid values are any method defined by RFC9110, along with the special\nvalue `*`, which represents all HTTP methods are allowed.\n\nMethod names are case sensitive, so these values are also case-sensitive.\n(See https://www.rfc-editor.org/rfc/rfc2616#section-5.1.1)\n\nMultiple method names in the value of the `Access-Control-Allow-Methods`\nresponse header are separated by a comma (\",\").\n\nA CORS-safelisted method is a method that is `GET`, `HEAD`, or `POST`.\n(See https://fetch.spec.whatwg.org/#cors-safelisted-method) The\nCORS-safelisted methods are always allowed, regardless of whether they\nare specified in the `AllowMethods` field.\n\nWhen the `AllowMethods` field is configured with one or more methods, the\ngateway must return the `Access-Control-Allow-Methods` response header\nwhich value is present in the `AllowMethods` field.\n\nIf the HTTP method of the `Access-Control-Request-Method` request header\nis not included in the list of methods specified by the response header\n`Access-Control-Allow-Methods`, it will present an error on the client\nside.\n\nThe `Access-Control-Allow-Methods` response header can only use `*`\nwildcard as value when the `AllowCredentials` field is unspecified.\n\nWhen the `AllowCredentials` field is specified and `AllowMethods` field\nspecified with the `*` wildcard, the gateway must specify one HTTP method\nin the value of the Access-Control-Allow-Methods response header. The\nvalue of the header `Access-Control-Allow-Methods` is same as the\n`Access-Control-Request-Method` header provided by the client. If the\nheader `Access-Control-Request-Method` is not included in the request,\nthe gateway will omit the `Access-Control-Allow-Methods` response header,\ninstead of specifying the `*` wildcard. A Gateway implementation may\nchoose to add implementation-specific default methods.\n\nSupport: Extended";
        type = (
          types.listOf (
            types.enum [
              "GET"
              "HEAD"
              "POST"
              "PUT"
              "DELETE"
              "CONNECT"
              "OPTIONS"
              "TRACE"
              "PATCH"
              "*"
            ]
          )
        );
        default = [ ];
      };
      "allowOrigins" = mkOption {
        description = "AllowOrigins indicates whether the response can be shared with requested\nresource from the given `Origin`.\n\nThe `Origin` consists of a scheme and a host, with an optional port, and\ntakes the form `<scheme>://<host>(:<port>)`.\n\nValid values for scheme are: `http` and `https`.\n\nValid values for port are any integer between 1 and 65535 (the list of\navailable TCP/UDP ports). Note that, if not included, port `80` is\nassumed for `http` scheme origins, and port `443` is assumed for `https`\norigins. This may affect origin matching.\n\nThe host part of the origin may contain the wildcard character `*`. These\nwildcard characters behave as follows:\n\n* `*` is a greedy match to the _left_, including any number of\n  DNS labels to the left of its position. This also means that\n  `*` will include any number of period `.` characters to the\n  left of its position.\n* A wildcard by itself matches all hosts.\n\nAn origin value that includes _only_ the `*` character indicates requests\nfrom all `Origin`s are allowed.\n\nWhen the `AllowOrigins` field is configured with multiple origins, it\nmeans the server supports clients from multiple origins. If the request\n`Origin` matches the configured allowed origins, the gateway must return\nthe given `Origin` and sets value of the header\n`Access-Control-Allow-Origin` same as the `Origin` header provided by the\nclient.\n\nThe status code of a successful response to a \"preflight\" request is\nalways an OK status (i.e., 204 or 200).\n\nIf the request `Origin` does not match the configured allowed origins,\nthe gateway returns 204/200 response but doesn't set the relevant\ncross-origin response headers. Alternatively, the gateway responds with\n403 status to the \"preflight\" request is denied, coupled with omitting\nthe CORS headers. The cross-origin request fails on the client side.\nTherefore, the client doesn't attempt the actual cross-origin request.\n\nThe `Access-Control-Allow-Origin` response header can only use `*`\nwildcard as value when the `AllowCredentials` field is unspecified.\n\nWhen the `AllowCredentials` field is specified and `AllowOrigins` field\nspecified with the `*` wildcard, the gateway must return a single origin\nin the value of the `Access-Control-Allow-Origin` response header,\ninstead of specifying the `*` wildcard. The value of the header\n`Access-Control-Allow-Origin` is same as the `Origin` header provided by\nthe client.\n\nSupport: Extended";
        type = (types.listOf types.str);
        default = [ ];
      };
      "exposeHeaders" = mkOption {
        description = "ExposeHeaders indicates which HTTP response headers can be exposed\nto client-side scripts in response to a cross-origin request.\n\nA CORS-safelisted response header is an HTTP header in a CORS response\nthat it is considered safe to expose to the client scripts.\nThe CORS-safelisted response headers include the following headers:\n`Cache-Control`\n`Content-Language`\n`Content-Length`\n`Content-Type`\n`Expires`\n`Last-Modified`\n`Pragma`\n(See https://fetch.spec.whatwg.org/#cors-safelisted-response-header-name)\nThe CORS-safelisted response headers are exposed to client by default.\n\nWhen an HTTP header name is specified using the `ExposeHeaders` field,\nthis additional header will be exposed as part of the response to the\nclient.\n\nHeader names are not case sensitive.\n\nMultiple header names in the value of the `Access-Control-Expose-Headers`\nresponse header are separated by a comma (\",\").\n\nA wildcard indicates that the responses with all HTTP headers are exposed\nto clients. The `Access-Control-Expose-Headers` response header can only\nuse `*` wildcard as value when the `AllowCredentials` field is\nunspecified.\n\nSupport: Extended";
        type = (types.listOf types.str);
        default = [ ];
      };
      "maxAge" = mkOption {
        description = "MaxAge indicates the duration (in seconds) for the client to cache the\nresults of a \"preflight\" request.\n\nThe information provided by the `Access-Control-Allow-Methods` and\n`Access-Control-Allow-Headers` response headers can be cached by the\nclient until the time specified by `Access-Control-Max-Age` elapses.\n\nThe default value of `Access-Control-Max-Age` response header is 5\n(seconds).";
        type = (types.nullOr types.int);
        default = 5;
      };
    };
  };
  mkRuleBackendRefFilterCors =
    res:
    {
    }
    // optionalAttrs res."allowCredentials" { inherit (res) "allowCredentials"; }
    // {
    }
    // optionalAttrs (res."allowHeaders" != [ ]) { inherit (res) "allowHeaders"; }
    // {
    }
    // optionalAttrs (res."allowMethods" != [ ]) { inherit (res) "allowMethods"; }
    // {
    }
    // optionalAttrs (res."allowOrigins" != [ ]) { inherit (res) "allowOrigins"; }
    // {
    }
    // optionalAttrs (res."exposeHeaders" != [ ]) { inherit (res) "exposeHeaders"; }
    // {
    }
    // optionalAttrs (res."maxAge" != null) { inherit (res) "maxAge"; }
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
      "cors" = mkOption {
        description = "CORS defines a schema for a filter that responds to the\ncross-origin request based on HTTP response header.\n\nSupport: Extended";
        type = (types.nullOr RuleBackendRefFilterCorsModule);
        default = null;
      };
      "extensionRef" = mkOption {
        description = "ExtensionRef is an optional, implementation-specific extension to the\n\"filter\" behavior.  For example, resource \"myroutefilter\" in group\n\"networking.example.net\"). ExtensionRef MUST NOT be used for core and\nextended filters.\n\nThis filter can be used multiple times within the same rule.\n\nSupport: Implementation-specific";
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
      "requestRedirect" = mkOption {
        description = "RequestRedirect defines a schema for a filter that responds to the\nrequest with an HTTP redirection.\n\nSupport: Core";
        type = (types.nullOr RuleBackendRefFilterRequestRedirectModule);
        default = null;
      };
      "responseHeaderModifier" = mkOption {
        description = "ResponseHeaderModifier defines a schema for a filter that modifies response\nheaders.\n\nSupport: Extended";
        type = (types.nullOr RuleBackendRefFilterResponseHeaderModifierModule);
        default = null;
      };
      "type" = mkOption {
        description = "Type identifies the type of filter to apply. As with other API fields,\ntypes are classified into three conformance levels:\n\n- Core: Filter types and their corresponding configuration defined by\n  \"Support: Core\" in this package, e.g. \"RequestHeaderModifier\". All\n  implementations must support core filters.\n\n- Extended: Filter types and their corresponding configuration defined by\n  \"Support: Extended\" in this package, e.g. \"RequestMirror\". Implementers\n  are encouraged to support extended filters.\n\n- Implementation-specific: Filters that are defined and supported by\n  specific vendors.\n  In the future, filters showing convergence in behavior across multiple\n  implementations will be considered for inclusion in extended or core\n  conformance levels. Filter-specific configuration for such filters\n  is specified using the ExtensionRef field. `Type` should be set to\n  \"ExtensionRef\" for custom filters.\n\nImplementers are encouraged to define custom implementation types to\nextend the core API with implementation-specific behavior.\n\nIf a reference to a custom filter type cannot be resolved, the filter\nMUST NOT be skipped. Instead, requests that would have been processed by\nthat filter MUST receive a HTTP error response.\n\nNote that values may be added to this enum, implementations\nmust ensure that unknown values will not cause a crash.\n\nUnknown values here must result in the implementation setting the\nAccepted Condition for the Route to `status: False`, with a\nReason of `UnsupportedValue`.";
        type = (
          types.enum [
            "RequestHeaderModifier"
            "ResponseHeaderModifier"
            "RequestMirror"
            "RequestRedirect"
            "URLRewrite"
            "ExtensionRef"
            "CORS"
          ]
        );
      };
      "urlRewrite" = mkOption {
        description = "URLRewrite defines a schema for a filter that modifies a request during forwarding.\n\nSupport: Extended";
        type = (types.nullOr RuleBackendRefFilterUrlRewriteModule);
        default = null;
      };
    };
  };
  mkRuleBackendRefFilter =
    res:
    {
    }
    // optionalAttrs (res."cors" != null) { "cors" = mkRuleBackendRefFilterCors res."cors"; }
    // {
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
    // optionalAttrs (res."requestRedirect" != null) {
      "requestRedirect" = mkRuleBackendRefFilterRequestRedirect res."requestRedirect";
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
    }
    // optionalAttrs (res."urlRewrite" != null) {
      "urlRewrite" = mkRuleBackendRefFilterUrlRewrite res."urlRewrite";
    }
    // {
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
  RuleBackendRefFilterRequestRedirectModule = types.submodule {
    options = {
      "hostname" = mkOption {
        description = "Hostname is the hostname to be used in the value of the `Location`\nheader in the response.\nWhen empty, the hostname in the `Host` header of the request is used.\n\nSupport: Core";
        type = (types.nullOr types.str);
        default = null;
      };
      "path" = mkOption {
        description = "Path defines parameters used to modify the path of the incoming request.\nThe modified path is then used to construct the `Location` header. When\nempty, the request path is used as-is.\n\nSupport: Extended";
        type = (types.nullOr RuleBackendRefFilterRequestRedirectPathModule);
        default = null;
      };
      "port" = mkOption {
        description = "Port is the port to be used in the value of the `Location`\nheader in the response.\n\nIf no port is specified, the redirect port MUST be derived using the\nfollowing rules:\n\n* If redirect scheme is not-empty, the redirect port MUST be the well-known\n  port associated with the redirect scheme. Specifically \"http\" to port 80\n  and \"https\" to port 443. If the redirect scheme does not have a\n  well-known port, the listener port of the Gateway SHOULD be used.\n* If redirect scheme is empty, the redirect port MUST be the Gateway\n  Listener port.\n\nImplementations SHOULD NOT add the port number in the 'Location'\nheader in the following cases:\n\n* A Location header that will use HTTP (whether that is determined via\n  the Listener protocol or the Scheme field) _and_ use port 80.\n* A Location header that will use HTTPS (whether that is determined via\n  the Listener protocol or the Scheme field) _and_ use port 443.\n\nSupport: Extended";
        type = (types.nullOr types.int);
        default = null;
      };
      "scheme" = mkOption {
        description = "Scheme is the scheme to be used in the value of the `Location` header in\nthe response. When empty, the scheme of the request is used.\n\nScheme redirects can affect the port of the redirect, for more information,\nrefer to the documentation for the port field of this filter.\n\nNote that values may be added to this enum, implementations\nmust ensure that unknown values will not cause a crash.\n\nUnknown values here must result in the implementation setting the\nAccepted Condition for the Route to `status: False`, with a\nReason of `UnsupportedValue`.\n\nSupport: Extended";
        type = (
          types.nullOr (
            types.enum [
              "http"
              "https"
            ]
          )
        );
        default = null;
      };
      "statusCode" = mkOption {
        description = "StatusCode is the HTTP status code to be used in response.\n\nNote that values may be added to this enum, implementations\nmust ensure that unknown values will not cause a crash.\n\nUnknown values here must result in the implementation setting the\nAccepted Condition for the Route to `status: False`, with a\nReason of `UnsupportedValue`.\n\nSupport: Core";
        type = (
          types.nullOr (
            types.enum [
              301
              302
            ]
          )
        );
        default = 302;
      };
    };
  };
  mkRuleBackendRefFilterRequestRedirect =
    res:
    {
    }
    // optionalAttrs (res."hostname" != null) { inherit (res) "hostname"; }
    // {
    }
    // optionalAttrs (res."path" != null) {
      "path" = mkRuleBackendRefFilterRequestRedirectPath res."path";
    }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    }
    // optionalAttrs (res."statusCode" != null) { inherit (res) "statusCode"; }
    // {
    };
  RuleBackendRefFilterRequestRedirectPathModule = types.submodule {
    options = {
      "replaceFullPath" = mkOption {
        description = "ReplaceFullPath specifies the value with which to replace the full path\nof a request during a rewrite or redirect.";
        type = (types.nullOr types.str);
        default = null;
      };
      "replacePrefixMatch" = mkOption {
        description = "ReplacePrefixMatch specifies the value with which to replace the prefix\nmatch of a request during a rewrite or redirect. For example, a request\nto \"/foo/bar\" with a prefix match of \"/foo\" and a ReplacePrefixMatch\nof \"/xyz\" would be modified to \"/xyz/bar\".\n\nNote that this matches the behavior of the PathPrefix match type. This\nmatches full path elements. A path element refers to the list of labels\nin the path split by the `/` separator. When specified, a trailing `/` is\nignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all\nmatch the prefix `/abc`, but the path `/abcd` would not.\n\nReplacePrefixMatch is only compatible with a `PathPrefix` HTTPRouteMatch.\nUsing any other HTTPRouteMatch type on the same HTTPRouteRule will result in\nthe implementation setting the Accepted Condition for the Route to `status: False`.\n\nRequest Path | Prefix Match | Replace Prefix | Modified Path";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Type defines the type of path modifier. Additional types may be\nadded in a future release of the API.\n\nNote that values may be added to this enum, implementations\nmust ensure that unknown values will not cause a crash.\n\nUnknown values here must result in the implementation setting the\nAccepted Condition for the Route to `status: False`, with a\nReason of `UnsupportedValue`.";
        type = (
          types.enum [
            "ReplaceFullPath"
            "ReplacePrefixMatch"
          ]
        );
      };
    };
  };
  mkRuleBackendRefFilterRequestRedirectPath =
    res:
    {
    }
    // optionalAttrs (res."replaceFullPath" != null) { inherit (res) "replaceFullPath"; }
    // {
    }
    // optionalAttrs (res."replacePrefixMatch" != null) { inherit (res) "replacePrefixMatch"; }
    // {
      inherit (res) "type";
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
  RuleBackendRefFilterUrlRewriteModule = types.submodule {
    options = {
      "hostname" = mkOption {
        description = "Hostname is the value to be used to replace the Host header value during\nforwarding.\n\nSupport: Extended";
        type = (types.nullOr types.str);
        default = null;
      };
      "path" = mkOption {
        description = "Path defines a path rewrite.\n\nSupport: Extended";
        type = (types.nullOr RuleBackendRefFilterUrlRewritePathModule);
        default = null;
      };
    };
  };
  mkRuleBackendRefFilterUrlRewrite =
    res:
    {
    }
    // optionalAttrs (res."hostname" != null) { inherit (res) "hostname"; }
    // {
    }
    // optionalAttrs (res."path" != null) { "path" = mkRuleBackendRefFilterUrlRewritePath res."path"; }
    // {
    };
  RuleBackendRefFilterUrlRewritePathModule = types.submodule {
    options = {
      "replaceFullPath" = mkOption {
        description = "ReplaceFullPath specifies the value with which to replace the full path\nof a request during a rewrite or redirect.";
        type = (types.nullOr types.str);
        default = null;
      };
      "replacePrefixMatch" = mkOption {
        description = "ReplacePrefixMatch specifies the value with which to replace the prefix\nmatch of a request during a rewrite or redirect. For example, a request\nto \"/foo/bar\" with a prefix match of \"/foo\" and a ReplacePrefixMatch\nof \"/xyz\" would be modified to \"/xyz/bar\".\n\nNote that this matches the behavior of the PathPrefix match type. This\nmatches full path elements. A path element refers to the list of labels\nin the path split by the `/` separator. When specified, a trailing `/` is\nignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all\nmatch the prefix `/abc`, but the path `/abcd` would not.\n\nReplacePrefixMatch is only compatible with a `PathPrefix` HTTPRouteMatch.\nUsing any other HTTPRouteMatch type on the same HTTPRouteRule will result in\nthe implementation setting the Accepted Condition for the Route to `status: False`.\n\nRequest Path | Prefix Match | Replace Prefix | Modified Path";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Type defines the type of path modifier. Additional types may be\nadded in a future release of the API.\n\nNote that values may be added to this enum, implementations\nmust ensure that unknown values will not cause a crash.\n\nUnknown values here must result in the implementation setting the\nAccepted Condition for the Route to `status: False`, with a\nReason of `UnsupportedValue`.";
        type = (
          types.enum [
            "ReplaceFullPath"
            "ReplacePrefixMatch"
          ]
        );
      };
    };
  };
  mkRuleBackendRefFilterUrlRewritePath =
    res:
    {
    }
    // optionalAttrs (res."replaceFullPath" != null) { inherit (res) "replaceFullPath"; }
    // {
    }
    // optionalAttrs (res."replacePrefixMatch" != null) { inherit (res) "replacePrefixMatch"; }
    // {
      inherit (res) "type";
    };
  RuleBackendRefModule = types.submodule {
    options = {
      "filters" = mkOption {
        description = "Filters defined at this level should be executed if and only if the\nrequest is being forwarded to the backend defined here.\n\nSupport: Implementation-specific (For broader support of filters, use the\nFilters field in HTTPRouteRule.)";
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
  RuleFilterCorsModule = types.submodule {
    options = {
      "allowCredentials" = mkOption {
        description = "AllowCredentials indicates whether the actual cross-origin request allows\nto include credentials.\n\nThe only valid value for the `Access-Control-Allow-Credentials` response\nheader is true (case-sensitive).\n\nIf the credentials are not allowed in cross-origin requests, the gateway\nwill omit the header `Access-Control-Allow-Credentials` entirely rather\nthan setting its value to false.\n\nSupport: Extended";
        type = (types.enum [ true ]);
        default = false;
      };
      "allowHeaders" = mkOption {
        description = "AllowHeaders indicates which HTTP request headers are supported for\naccessing the requested resource.\n\nHeader names are not case sensitive.\n\nMultiple header names in the value of the `Access-Control-Allow-Headers`\nresponse header are separated by a comma (\",\").\n\nWhen the `AllowHeaders` field is configured with one or more headers, the\ngateway must return the `Access-Control-Allow-Headers` response header\nwhich value is present in the `AllowHeaders` field.\n\nIf any header name in the `Access-Control-Request-Headers` request header\nis not included in the list of header names specified by the response\nheader `Access-Control-Allow-Headers`, it will present an error on the\nclient side.\n\nIf any header name in the `Access-Control-Allow-Headers` response header\ndoes not recognize by the client, it will also occur an error on the\nclient side.\n\nA wildcard indicates that the requests with all HTTP headers are allowed.\nThe `Access-Control-Allow-Headers` response header can only use `*`\nwildcard as value when the `AllowCredentials` field is unspecified.\n\nWhen the `AllowCredentials` field is specified and `AllowHeaders` field\nspecified with the `*` wildcard, the gateway must specify one or more\nHTTP headers in the value of the `Access-Control-Allow-Headers` response\nheader. The value of the header `Access-Control-Allow-Headers` is same as\nthe `Access-Control-Request-Headers` header provided by the client. If\nthe header `Access-Control-Request-Headers` is not included in the\nrequest, the gateway will omit the `Access-Control-Allow-Headers`\nresponse header, instead of specifying the `*` wildcard. A Gateway\nimplementation may choose to add implementation-specific default headers.\n\nSupport: Extended";
        type = (types.listOf types.str);
        default = [ ];
      };
      "allowMethods" = mkOption {
        description = "AllowMethods indicates which HTTP methods are supported for accessing the\nrequested resource.\n\nValid values are any method defined by RFC9110, along with the special\nvalue `*`, which represents all HTTP methods are allowed.\n\nMethod names are case sensitive, so these values are also case-sensitive.\n(See https://www.rfc-editor.org/rfc/rfc2616#section-5.1.1)\n\nMultiple method names in the value of the `Access-Control-Allow-Methods`\nresponse header are separated by a comma (\",\").\n\nA CORS-safelisted method is a method that is `GET`, `HEAD`, or `POST`.\n(See https://fetch.spec.whatwg.org/#cors-safelisted-method) The\nCORS-safelisted methods are always allowed, regardless of whether they\nare specified in the `AllowMethods` field.\n\nWhen the `AllowMethods` field is configured with one or more methods, the\ngateway must return the `Access-Control-Allow-Methods` response header\nwhich value is present in the `AllowMethods` field.\n\nIf the HTTP method of the `Access-Control-Request-Method` request header\nis not included in the list of methods specified by the response header\n`Access-Control-Allow-Methods`, it will present an error on the client\nside.\n\nThe `Access-Control-Allow-Methods` response header can only use `*`\nwildcard as value when the `AllowCredentials` field is unspecified.\n\nWhen the `AllowCredentials` field is specified and `AllowMethods` field\nspecified with the `*` wildcard, the gateway must specify one HTTP method\nin the value of the Access-Control-Allow-Methods response header. The\nvalue of the header `Access-Control-Allow-Methods` is same as the\n`Access-Control-Request-Method` header provided by the client. If the\nheader `Access-Control-Request-Method` is not included in the request,\nthe gateway will omit the `Access-Control-Allow-Methods` response header,\ninstead of specifying the `*` wildcard. A Gateway implementation may\nchoose to add implementation-specific default methods.\n\nSupport: Extended";
        type = (
          types.listOf (
            types.enum [
              "GET"
              "HEAD"
              "POST"
              "PUT"
              "DELETE"
              "CONNECT"
              "OPTIONS"
              "TRACE"
              "PATCH"
              "*"
            ]
          )
        );
        default = [ ];
      };
      "allowOrigins" = mkOption {
        description = "AllowOrigins indicates whether the response can be shared with requested\nresource from the given `Origin`.\n\nThe `Origin` consists of a scheme and a host, with an optional port, and\ntakes the form `<scheme>://<host>(:<port>)`.\n\nValid values for scheme are: `http` and `https`.\n\nValid values for port are any integer between 1 and 65535 (the list of\navailable TCP/UDP ports). Note that, if not included, port `80` is\nassumed for `http` scheme origins, and port `443` is assumed for `https`\norigins. This may affect origin matching.\n\nThe host part of the origin may contain the wildcard character `*`. These\nwildcard characters behave as follows:\n\n* `*` is a greedy match to the _left_, including any number of\n  DNS labels to the left of its position. This also means that\n  `*` will include any number of period `.` characters to the\n  left of its position.\n* A wildcard by itself matches all hosts.\n\nAn origin value that includes _only_ the `*` character indicates requests\nfrom all `Origin`s are allowed.\n\nWhen the `AllowOrigins` field is configured with multiple origins, it\nmeans the server supports clients from multiple origins. If the request\n`Origin` matches the configured allowed origins, the gateway must return\nthe given `Origin` and sets value of the header\n`Access-Control-Allow-Origin` same as the `Origin` header provided by the\nclient.\n\nThe status code of a successful response to a \"preflight\" request is\nalways an OK status (i.e., 204 or 200).\n\nIf the request `Origin` does not match the configured allowed origins,\nthe gateway returns 204/200 response but doesn't set the relevant\ncross-origin response headers. Alternatively, the gateway responds with\n403 status to the \"preflight\" request is denied, coupled with omitting\nthe CORS headers. The cross-origin request fails on the client side.\nTherefore, the client doesn't attempt the actual cross-origin request.\n\nThe `Access-Control-Allow-Origin` response header can only use `*`\nwildcard as value when the `AllowCredentials` field is unspecified.\n\nWhen the `AllowCredentials` field is specified and `AllowOrigins` field\nspecified with the `*` wildcard, the gateway must return a single origin\nin the value of the `Access-Control-Allow-Origin` response header,\ninstead of specifying the `*` wildcard. The value of the header\n`Access-Control-Allow-Origin` is same as the `Origin` header provided by\nthe client.\n\nSupport: Extended";
        type = (types.listOf types.str);
        default = [ ];
      };
      "exposeHeaders" = mkOption {
        description = "ExposeHeaders indicates which HTTP response headers can be exposed\nto client-side scripts in response to a cross-origin request.\n\nA CORS-safelisted response header is an HTTP header in a CORS response\nthat it is considered safe to expose to the client scripts.\nThe CORS-safelisted response headers include the following headers:\n`Cache-Control`\n`Content-Language`\n`Content-Length`\n`Content-Type`\n`Expires`\n`Last-Modified`\n`Pragma`\n(See https://fetch.spec.whatwg.org/#cors-safelisted-response-header-name)\nThe CORS-safelisted response headers are exposed to client by default.\n\nWhen an HTTP header name is specified using the `ExposeHeaders` field,\nthis additional header will be exposed as part of the response to the\nclient.\n\nHeader names are not case sensitive.\n\nMultiple header names in the value of the `Access-Control-Expose-Headers`\nresponse header are separated by a comma (\",\").\n\nA wildcard indicates that the responses with all HTTP headers are exposed\nto clients. The `Access-Control-Expose-Headers` response header can only\nuse `*` wildcard as value when the `AllowCredentials` field is\nunspecified.\n\nSupport: Extended";
        type = (types.listOf types.str);
        default = [ ];
      };
      "maxAge" = mkOption {
        description = "MaxAge indicates the duration (in seconds) for the client to cache the\nresults of a \"preflight\" request.\n\nThe information provided by the `Access-Control-Allow-Methods` and\n`Access-Control-Allow-Headers` response headers can be cached by the\nclient until the time specified by `Access-Control-Max-Age` elapses.\n\nThe default value of `Access-Control-Max-Age` response header is 5\n(seconds).";
        type = (types.nullOr types.int);
        default = 5;
      };
    };
  };
  mkRuleFilterCors =
    res:
    {
    }
    // optionalAttrs res."allowCredentials" { inherit (res) "allowCredentials"; }
    // {
    }
    // optionalAttrs (res."allowHeaders" != [ ]) { inherit (res) "allowHeaders"; }
    // {
    }
    // optionalAttrs (res."allowMethods" != [ ]) { inherit (res) "allowMethods"; }
    // {
    }
    // optionalAttrs (res."allowOrigins" != [ ]) { inherit (res) "allowOrigins"; }
    // {
    }
    // optionalAttrs (res."exposeHeaders" != [ ]) { inherit (res) "exposeHeaders"; }
    // {
    }
    // optionalAttrs (res."maxAge" != null) { inherit (res) "maxAge"; }
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
      "cors" = mkOption {
        description = "CORS defines a schema for a filter that responds to the\ncross-origin request based on HTTP response header.\n\nSupport: Extended";
        type = (types.nullOr RuleFilterCorsModule);
        default = null;
      };
      "extensionRef" = mkOption {
        description = "ExtensionRef is an optional, implementation-specific extension to the\n\"filter\" behavior.  For example, resource \"myroutefilter\" in group\n\"networking.example.net\"). ExtensionRef MUST NOT be used for core and\nextended filters.\n\nThis filter can be used multiple times within the same rule.\n\nSupport: Implementation-specific";
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
      "requestRedirect" = mkOption {
        description = "RequestRedirect defines a schema for a filter that responds to the\nrequest with an HTTP redirection.\n\nSupport: Core";
        type = (types.nullOr RuleFilterRequestRedirectModule);
        default = null;
      };
      "responseHeaderModifier" = mkOption {
        description = "ResponseHeaderModifier defines a schema for a filter that modifies response\nheaders.\n\nSupport: Extended";
        type = (types.nullOr RuleFilterResponseHeaderModifierModule);
        default = null;
      };
      "type" = mkOption {
        description = "Type identifies the type of filter to apply. As with other API fields,\ntypes are classified into three conformance levels:\n\n- Core: Filter types and their corresponding configuration defined by\n  \"Support: Core\" in this package, e.g. \"RequestHeaderModifier\". All\n  implementations must support core filters.\n\n- Extended: Filter types and their corresponding configuration defined by\n  \"Support: Extended\" in this package, e.g. \"RequestMirror\". Implementers\n  are encouraged to support extended filters.\n\n- Implementation-specific: Filters that are defined and supported by\n  specific vendors.\n  In the future, filters showing convergence in behavior across multiple\n  implementations will be considered for inclusion in extended or core\n  conformance levels. Filter-specific configuration for such filters\n  is specified using the ExtensionRef field. `Type` should be set to\n  \"ExtensionRef\" for custom filters.\n\nImplementers are encouraged to define custom implementation types to\nextend the core API with implementation-specific behavior.\n\nIf a reference to a custom filter type cannot be resolved, the filter\nMUST NOT be skipped. Instead, requests that would have been processed by\nthat filter MUST receive a HTTP error response.\n\nNote that values may be added to this enum, implementations\nmust ensure that unknown values will not cause a crash.\n\nUnknown values here must result in the implementation setting the\nAccepted Condition for the Route to `status: False`, with a\nReason of `UnsupportedValue`.";
        type = (
          types.enum [
            "RequestHeaderModifier"
            "ResponseHeaderModifier"
            "RequestMirror"
            "RequestRedirect"
            "URLRewrite"
            "ExtensionRef"
            "CORS"
          ]
        );
      };
      "urlRewrite" = mkOption {
        description = "URLRewrite defines a schema for a filter that modifies a request during forwarding.\n\nSupport: Extended";
        type = (types.nullOr RuleFilterUrlRewriteModule);
        default = null;
      };
    };
  };
  mkRuleFilter =
    res:
    {
    }
    // optionalAttrs (res."cors" != null) { "cors" = mkRuleFilterCors res."cors"; }
    // {
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
    // optionalAttrs (res."requestRedirect" != null) {
      "requestRedirect" = mkRuleFilterRequestRedirect res."requestRedirect";
    }
    // {
    }
    // optionalAttrs (res."responseHeaderModifier" != null) {
      "responseHeaderModifier" = mkRuleFilterResponseHeaderModifier res."responseHeaderModifier";
    }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."urlRewrite" != null) {
      "urlRewrite" = mkRuleFilterUrlRewrite res."urlRewrite";
    }
    // {
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
  RuleFilterRequestRedirectModule = types.submodule {
    options = {
      "hostname" = mkOption {
        description = "Hostname is the hostname to be used in the value of the `Location`\nheader in the response.\nWhen empty, the hostname in the `Host` header of the request is used.\n\nSupport: Core";
        type = (types.nullOr types.str);
        default = null;
      };
      "path" = mkOption {
        description = "Path defines parameters used to modify the path of the incoming request.\nThe modified path is then used to construct the `Location` header. When\nempty, the request path is used as-is.\n\nSupport: Extended";
        type = (types.nullOr RuleFilterRequestRedirectPathModule);
        default = null;
      };
      "port" = mkOption {
        description = "Port is the port to be used in the value of the `Location`\nheader in the response.\n\nIf no port is specified, the redirect port MUST be derived using the\nfollowing rules:\n\n* If redirect scheme is not-empty, the redirect port MUST be the well-known\n  port associated with the redirect scheme. Specifically \"http\" to port 80\n  and \"https\" to port 443. If the redirect scheme does not have a\n  well-known port, the listener port of the Gateway SHOULD be used.\n* If redirect scheme is empty, the redirect port MUST be the Gateway\n  Listener port.\n\nImplementations SHOULD NOT add the port number in the 'Location'\nheader in the following cases:\n\n* A Location header that will use HTTP (whether that is determined via\n  the Listener protocol or the Scheme field) _and_ use port 80.\n* A Location header that will use HTTPS (whether that is determined via\n  the Listener protocol or the Scheme field) _and_ use port 443.\n\nSupport: Extended";
        type = (types.nullOr types.int);
        default = null;
      };
      "scheme" = mkOption {
        description = "Scheme is the scheme to be used in the value of the `Location` header in\nthe response. When empty, the scheme of the request is used.\n\nScheme redirects can affect the port of the redirect, for more information,\nrefer to the documentation for the port field of this filter.\n\nNote that values may be added to this enum, implementations\nmust ensure that unknown values will not cause a crash.\n\nUnknown values here must result in the implementation setting the\nAccepted Condition for the Route to `status: False`, with a\nReason of `UnsupportedValue`.\n\nSupport: Extended";
        type = (
          types.nullOr (
            types.enum [
              "http"
              "https"
            ]
          )
        );
        default = null;
      };
      "statusCode" = mkOption {
        description = "StatusCode is the HTTP status code to be used in response.\n\nNote that values may be added to this enum, implementations\nmust ensure that unknown values will not cause a crash.\n\nUnknown values here must result in the implementation setting the\nAccepted Condition for the Route to `status: False`, with a\nReason of `UnsupportedValue`.\n\nSupport: Core";
        type = (
          types.nullOr (
            types.enum [
              301
              302
            ]
          )
        );
        default = 302;
      };
    };
  };
  mkRuleFilterRequestRedirect =
    res:
    {
    }
    // optionalAttrs (res."hostname" != null) { inherit (res) "hostname"; }
    // {
    }
    // optionalAttrs (res."path" != null) { "path" = mkRuleFilterRequestRedirectPath res."path"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    }
    // optionalAttrs (res."statusCode" != null) { inherit (res) "statusCode"; }
    // {
    };
  RuleFilterRequestRedirectPathModule = types.submodule {
    options = {
      "replaceFullPath" = mkOption {
        description = "ReplaceFullPath specifies the value with which to replace the full path\nof a request during a rewrite or redirect.";
        type = (types.nullOr types.str);
        default = null;
      };
      "replacePrefixMatch" = mkOption {
        description = "ReplacePrefixMatch specifies the value with which to replace the prefix\nmatch of a request during a rewrite or redirect. For example, a request\nto \"/foo/bar\" with a prefix match of \"/foo\" and a ReplacePrefixMatch\nof \"/xyz\" would be modified to \"/xyz/bar\".\n\nNote that this matches the behavior of the PathPrefix match type. This\nmatches full path elements. A path element refers to the list of labels\nin the path split by the `/` separator. When specified, a trailing `/` is\nignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all\nmatch the prefix `/abc`, but the path `/abcd` would not.\n\nReplacePrefixMatch is only compatible with a `PathPrefix` HTTPRouteMatch.\nUsing any other HTTPRouteMatch type on the same HTTPRouteRule will result in\nthe implementation setting the Accepted Condition for the Route to `status: False`.\n\nRequest Path | Prefix Match | Replace Prefix | Modified Path";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Type defines the type of path modifier. Additional types may be\nadded in a future release of the API.\n\nNote that values may be added to this enum, implementations\nmust ensure that unknown values will not cause a crash.\n\nUnknown values here must result in the implementation setting the\nAccepted Condition for the Route to `status: False`, with a\nReason of `UnsupportedValue`.";
        type = (
          types.enum [
            "ReplaceFullPath"
            "ReplacePrefixMatch"
          ]
        );
      };
    };
  };
  mkRuleFilterRequestRedirectPath =
    res:
    {
    }
    // optionalAttrs (res."replaceFullPath" != null) { inherit (res) "replaceFullPath"; }
    // {
    }
    // optionalAttrs (res."replacePrefixMatch" != null) { inherit (res) "replacePrefixMatch"; }
    // {
      inherit (res) "type";
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
  RuleFilterUrlRewriteModule = types.submodule {
    options = {
      "hostname" = mkOption {
        description = "Hostname is the value to be used to replace the Host header value during\nforwarding.\n\nSupport: Extended";
        type = (types.nullOr types.str);
        default = null;
      };
      "path" = mkOption {
        description = "Path defines a path rewrite.\n\nSupport: Extended";
        type = (types.nullOr RuleFilterUrlRewritePathModule);
        default = null;
      };
    };
  };
  mkRuleFilterUrlRewrite =
    res:
    {
    }
    // optionalAttrs (res."hostname" != null) { inherit (res) "hostname"; }
    // {
    }
    // optionalAttrs (res."path" != null) { "path" = mkRuleFilterUrlRewritePath res."path"; }
    // {
    };
  RuleFilterUrlRewritePathModule = types.submodule {
    options = {
      "replaceFullPath" = mkOption {
        description = "ReplaceFullPath specifies the value with which to replace the full path\nof a request during a rewrite or redirect.";
        type = (types.nullOr types.str);
        default = null;
      };
      "replacePrefixMatch" = mkOption {
        description = "ReplacePrefixMatch specifies the value with which to replace the prefix\nmatch of a request during a rewrite or redirect. For example, a request\nto \"/foo/bar\" with a prefix match of \"/foo\" and a ReplacePrefixMatch\nof \"/xyz\" would be modified to \"/xyz/bar\".\n\nNote that this matches the behavior of the PathPrefix match type. This\nmatches full path elements. A path element refers to the list of labels\nin the path split by the `/` separator. When specified, a trailing `/` is\nignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all\nmatch the prefix `/abc`, but the path `/abcd` would not.\n\nReplacePrefixMatch is only compatible with a `PathPrefix` HTTPRouteMatch.\nUsing any other HTTPRouteMatch type on the same HTTPRouteRule will result in\nthe implementation setting the Accepted Condition for the Route to `status: False`.\n\nRequest Path | Prefix Match | Replace Prefix | Modified Path";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Type defines the type of path modifier. Additional types may be\nadded in a future release of the API.\n\nNote that values may be added to this enum, implementations\nmust ensure that unknown values will not cause a crash.\n\nUnknown values here must result in the implementation setting the\nAccepted Condition for the Route to `status: False`, with a\nReason of `UnsupportedValue`.";
        type = (
          types.enum [
            "ReplaceFullPath"
            "ReplacePrefixMatch"
          ]
        );
      };
    };
  };
  mkRuleFilterUrlRewritePath =
    res:
    {
    }
    // optionalAttrs (res."replaceFullPath" != null) { inherit (res) "replaceFullPath"; }
    // {
    }
    // optionalAttrs (res."replacePrefixMatch" != null) { inherit (res) "replacePrefixMatch"; }
    // {
      inherit (res) "type";
    };
  RuleMatcheHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the name of the HTTP Header to be matched. Name matching MUST be\ncase-insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).\n\nIf multiple entries specify equivalent header names, only the first\nentry with an equivalent name MUST be considered for a match. Subsequent\nentries with an equivalent header name MUST be ignored. Due to the\ncase-insensitivity of header names, \"foo\" and \"Foo\" are considered\nequivalent.\n\nWhen a header is repeated in an HTTP request, it is\nimplementation-specific behavior as to how this is represented.\nGenerally, proxies should follow the guidance from the RFC:\nhttps://www.rfc-editor.org/rfc/rfc7230.html#section-3.2.2 regarding\nprocessing a repeated header, with special handling for \"Set-Cookie\".";
        type = types.str;
      };
      "type" = mkOption {
        description = "Type specifies how to match against the value of the header.\n\nSupport: Core (Exact)\n\nSupport: Implementation-specific (RegularExpression)\n\nSince RegularExpression HeaderMatchType has implementation-specific\nconformance, implementations can support POSIX, PCRE or any other dialects\nof regular expressions. Please read the implementation's documentation to\ndetermine the supported dialect.";
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
        description = "Value is the value of HTTP Header to be matched.";
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
  RuleMatcheModule = types.submodule {
    options = {
      "headers" = mkOption {
        description = "Headers specifies HTTP request header matchers. Multiple match values are\nANDed together, meaning, a request must match all the specified headers\nto select the route.";
        type = (types.listOf RuleMatcheHeaderModule);
        default = [ ];
      };
      "method" = mkOption {
        description = "Method specifies HTTP method matcher.\nWhen specified, this route will be matched only if the request has the\nspecified method.\n\nSupport: Extended";
        type = (
          types.nullOr (
            types.enum [
              "GET"
              "HEAD"
              "POST"
              "PUT"
              "DELETE"
              "CONNECT"
              "OPTIONS"
              "TRACE"
              "PATCH"
            ]
          )
        );
        default = null;
      };
      "path" = mkOption {
        description = "Path specifies a HTTP request path matcher. If this field is not\nspecified, a default prefix match on the \"/\" path is provided.";
        type = (types.nullOr RuleMatchePathModule);
        default = {
          "type" = "PathPrefix";
          "value" = "/";
        };
      };
      "queryParams" = mkOption {
        description = "QueryParams specifies HTTP query parameter matchers. Multiple match\nvalues are ANDed together, meaning, a request must match all the\nspecified query parameters to select the route.\n\nSupport: Extended";
        type = (types.listOf RuleMatcheQueryParamModule);
        default = [ ];
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
    // optionalAttrs (res."method" != null) { inherit (res) "method"; }
    // {
    }
    // optionalAttrs (res."path" != null) { "path" = mkRuleMatchePath res."path"; }
    // {
    }
    // optionalAttrs (res."queryParams" != [ ]) {
      "queryParams" = map mkRuleMatcheQueryParam res."queryParams";
    }
    // {
    };
  RuleMatchePathModule = types.submodule {
    options = {
      "type" = mkOption {
        description = "Type specifies how to match against the path Value.\n\nSupport: Core (Exact, PathPrefix)\n\nSupport: Implementation-specific (RegularExpression)";
        type = (
          types.nullOr (
            types.enum [
              "Exact"
              "PathPrefix"
              "RegularExpression"
            ]
          )
        );
        default = "PathPrefix";
      };
      "value" = mkOption {
        description = "Value of the HTTP path to match against.";
        type = (types.nullOr types.str);
        default = "/";
      };
    };
  };
  mkRuleMatchePath =
    res:
    {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  RuleMatcheQueryParamModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the name of the HTTP query param to be matched. This must be an\nexact string match. (See\nhttps://tools.ietf.org/html/rfc7230#section-2.7.3).\n\nIf multiple entries specify equivalent query param names, only the first\nentry with an equivalent name MUST be considered for a match. Subsequent\nentries with an equivalent query param name MUST be ignored.\n\nIf a query param is repeated in an HTTP request, the behavior is\npurposely left undefined, since different data planes have different\ncapabilities. However, it is *recommended* that implementations should\nmatch against the first value of the param if the data plane supports it,\nas this behavior is expected in other load balancing contexts outside of\nthe Gateway API.\n\nUsers SHOULD NOT route traffic based on repeated query params to guard\nthemselves against potential differences in the implementations.";
        type = types.str;
      };
      "type" = mkOption {
        description = "Type specifies how to match against the value of the query parameter.\n\nSupport: Extended (Exact)\n\nSupport: Implementation-specific (RegularExpression)\n\nSince RegularExpression QueryParamMatchType has Implementation-specific\nconformance, implementations can support POSIX, PCRE or any other\ndialects of regular expressions. Please read the implementation's\ndocumentation to determine the supported dialect.";
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
        description = "Value is the value of HTTP query param to be matched.";
        type = types.str;
      };
    };
  };
  mkRuleMatcheQueryParam =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
      inherit (res) "value";
    };
  RuleModule = types.submodule {
    options = {
      "backendRefs" = mkOption {
        description = "BackendRefs defines the backend(s) where matching requests should be\nsent.\n\nFailure behavior here depends on how many BackendRefs are specified and\nhow many are invalid.\n\nIf *all* entries in BackendRefs are invalid, and there are also no filters\nspecified in this route rule, *all* traffic which matches this rule MUST\nreceive a 500 status code.\n\nSee the HTTPBackendRef definition for the rules about what makes a single\nHTTPBackendRef invalid.\n\nWhen a HTTPBackendRef is invalid, 500 status codes MUST be returned for\nrequests that would have otherwise been routed to an invalid backend. If\nmultiple backends are specified, and some are invalid, the proportion of\nrequests that would otherwise have been routed to an invalid backend\nMUST receive a 500 status code.\n\nFor example, if two backends are specified with equal weights, and one is\ninvalid, 50 percent of traffic must receive a 500. Implementations may\nchoose how that 50 percent is determined.\n\nWhen a HTTPBackendRef refers to a Service that has no ready endpoints,\nimplementations SHOULD return a 503 for requests to that backend instead.\nIf an implementation chooses to do this, all of the above rules for 500 responses\nMUST also apply for responses that return a 503.\n\nSupport: Core for Kubernetes Service\n\nSupport: Extended for Kubernetes ServiceImport\n\nSupport: Implementation-specific for any other resource\n\nSupport for weight: Core";
        type = (types.listOf RuleBackendRefModule);
        default = [ ];
      };
      "filters" = mkOption {
        description = "Filters define the filters that are applied to requests that match\nthis rule.\n\nWherever possible, implementations SHOULD implement filters in the order\nthey are specified.\n\nImplementations MAY choose to implement this ordering strictly, rejecting\nany combination or order of filters that cannot be supported. If implementations\nchoose a strict interpretation of filter ordering, they MUST clearly document\nthat behavior.\n\nTo reject an invalid combination or order of filters, implementations SHOULD\nconsider the Route Rules with this configuration invalid. If all Route Rules\nin a Route are invalid, the entire Route would be considered invalid. If only\na portion of Route Rules are invalid, implementations MUST set the\n\"PartiallyInvalid\" condition for the Route.\n\nConformance-levels at this level are defined based on the type of filter:\n\n- ALL core filters MUST be supported by all implementations.\n- Implementers are encouraged to support extended filters.\n- Implementation-specific custom filters have no API guarantees across\n  implementations.\n\nSpecifying the same filter multiple times is not supported unless explicitly\nindicated in the filter.\n\nAll filters are expected to be compatible with each other except for the\nURLRewrite and RequestRedirect filters, which may not be combined. If an\nimplementation cannot support other combinations of filters, they must clearly\ndocument that limitation. In cases where incompatible or unsupported\nfilters are specified and cause the `Accepted` condition to be set to status\n`False`, implementations may use the `IncompatibleFilters` reason to specify\nthis configuration error.\n\nSupport: Core";
        type = (types.listOf RuleFilterModule);
        default = [ ];
      };
      "matches" = mkOption {
        description = "Matches define conditions used for matching the rule against incoming\nHTTP requests. Each match is independent, i.e. this rule will be matched\nif **any** one of the matches is satisfied.\n\nFor example, take the following matches configuration:\n\n```\nmatches:\n- path:\n    value: \"/foo\"\n  headers:\n  - name: \"version\"\n    value: \"v2\"\n- path:\n    value: \"/v2/foo\"\n```\n\nFor a request to match against this rule, a request must satisfy\nEITHER of the two conditions:\n\n- path prefixed with `/foo` AND contains the header `version: v2`\n- path prefix of `/v2/foo`\n\nSee the documentation for HTTPRouteMatch on how to specify multiple\nmatch conditions that should be ANDed together.\n\nIf no matches are specified, the default is a prefix\npath match on \"/\", which has the effect of matching every\nHTTP request.\n\nProxy or Load Balancer routing configuration generated from HTTPRoutes\nMUST prioritize matches based on the following criteria, continuing on\nties. Across all rules specified on applicable Routes, precedence must be\ngiven to the match having:\n\n* \"Exact\" path match.\n* \"Prefix\" path match with largest number of characters.\n* Method match.\n* Largest number of header matches.\n* Largest number of query param matches.\n\nNote: The precedence of RegularExpression path matches are implementation-specific.\n\nIf ties still exist across multiple Routes, matching precedence MUST be\ndetermined in order of the following criteria, continuing on ties:\n\n* The oldest Route based on creation timestamp.\n* The Route appearing first in alphabetical order by\n  \"{namespace}/{name}\".\n\nIf ties still exist within an HTTPRoute, matching precedence MUST be granted\nto the FIRST matching rule (in list order) with a match meeting the above\ncriteria.\n\nWhen no rules matching a request have been successfully attached to the\nparent a request is coming from, a HTTP 404 status code MUST be returned.";
        type = (types.listOf RuleMatcheModule);
        default = [
          {
            "path" = {
              "type" = "PathPrefix";
              "value" = "/";
            };
          }
        ];
      };
      "name" = mkOption {
        description = "Name is the name of the route rule. This name MUST be unique within a Route if it is set.\n\nSupport: Extended";
        type = (types.nullOr types.str);
        default = null;
      };
      "retry" = mkOption {
        description = "Retry defines the configuration for when to retry an HTTP request.\n\nSupport: Extended";
        type = (types.nullOr RuleRetryModule);
        default = null;
      };
      "sessionPersistence" = mkOption {
        description = "SessionPersistence defines and configures session persistence\nfor the route rule.\n\nSupport: Extended";
        type = (types.nullOr RuleSessionPersistenceModule);
        default = null;
      };
      "timeouts" = mkOption {
        description = "Timeouts defines the timeouts that can be configured for an HTTP request.\n\nSupport: Extended";
        type = (types.nullOr RuleTimeoutsModule);
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
    // optionalAttrs (res."retry" != null) { "retry" = mkRuleRetry res."retry"; }
    // {
    }
    // optionalAttrs (res."sessionPersistence" != null) {
      "sessionPersistence" = mkRuleSessionPersistence res."sessionPersistence";
    }
    // {
    }
    // optionalAttrs (res."timeouts" != null) { "timeouts" = mkRuleTimeouts res."timeouts"; }
    // {
    };
  RuleRetryModule = types.submodule {
    options = {
      "attempts" = mkOption {
        description = "Attempts specifies the maximum number of times an individual request\nfrom the gateway to a backend should be retried.\n\nIf the maximum number of retries has been attempted without a successful\nresponse from the backend, the Gateway MUST return an error.\n\nWhen this field is unspecified, the number of times to attempt to retry\na backend request is implementation-specific.\n\nSupport: Extended";
        type = (types.nullOr types.int);
        default = null;
      };
      "backoff" = mkOption {
        description = "Backoff specifies the minimum duration a Gateway should wait between\nretry attempts and is represented in Gateway API Duration formatting.\n\nFor example, setting the `rules[].retry.backoff` field to the value\n`100ms` will cause a backend request to first be retried approximately\n100 milliseconds after timing out or receiving a response code configured\nto be retryable.\n\nAn implementation MAY use an exponential or alternative backoff strategy\nfor subsequent retry attempts, MAY cap the maximum backoff duration to\nsome amount greater than the specified minimum, and MAY add arbitrary\njitter to stagger requests, as long as unsuccessful backend requests are\nnot retried before the configured minimum duration.\n\nIf a Request timeout (`rules[].timeouts.request`) is configured on the\nroute, the entire duration of the initial request and any retry attempts\nMUST not exceed the Request timeout duration. If any retry attempts are\nstill in progress when the Request timeout duration has been reached,\nthese SHOULD be canceled if possible and the Gateway MUST immediately\nreturn a timeout error.\n\nIf a BackendRequest timeout (`rules[].timeouts.backendRequest`) is\nconfigured on the route, any retry attempts which reach the configured\nBackendRequest timeout duration without a response SHOULD be canceled if\npossible and the Gateway should wait for at least the specified backoff\nduration before attempting to retry the backend request again.\n\nIf a BackendRequest timeout is _not_ configured on the route, retry\nattempts MAY time out after an implementation default duration, or MAY\nremain pending until a configured Request timeout or implementation\ndefault duration for total request time is reached.\n\nWhen this field is unspecified, the time to wait between retry attempts\nis implementation-specific.\n\nSupport: Extended";
        type = (types.nullOr types.str);
        default = null;
      };
      "codes" = mkOption {
        description = "Codes defines the HTTP response status codes for which a backend request\nshould be retried.\n\nSupport: Extended";
        type = (types.listOf types.int);
        default = [ ];
      };
    };
  };
  mkRuleRetry =
    res:
    {
    }
    // optionalAttrs (res."attempts" != null) { inherit (res) "attempts"; }
    // {
    }
    // optionalAttrs (res."backoff" != null) { inherit (res) "backoff"; }
    // {
    }
    // optionalAttrs (res."codes" != [ ]) { inherit (res) "codes"; }
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
  RuleTimeoutsModule = types.submodule {
    options = {
      "backendRequest" = mkOption {
        description = "BackendRequest specifies a timeout for an individual request from the gateway\nto a backend. This covers the time from when the request first starts being\nsent from the gateway to when the full response has been received from the backend.\n\nSetting a timeout to the zero duration (e.g. \"0s\") SHOULD disable the timeout\ncompletely. Implementations that cannot completely disable the timeout MUST\ninstead interpret the zero duration as the longest possible value to which\nthe timeout can be set.\n\nAn entire client HTTP transaction with a gateway, covered by the Request timeout,\nmay result in more than one call from the gateway to the destination backend,\nfor example, if automatic retries are supported.\n\nThe value of BackendRequest must be a Gateway API Duration string as defined by\nGEP-2257.  When this field is unspecified, its behavior is implementation-specific;\nwhen specified, the value of BackendRequest must be no more than the value of the\nRequest timeout (since the Request timeout encompasses the BackendRequest timeout).\n\nSupport: Extended";
        type = (types.nullOr types.str);
        default = null;
      };
      "request" = mkOption {
        description = "Request specifies the maximum duration for a gateway to respond to an HTTP request.\nIf the gateway has not been able to respond before this deadline is met, the gateway\nMUST return a timeout error.\n\nFor example, setting the `rules.timeouts.request` field to the value `10s` in an\n`HTTPRoute` will cause a timeout if a client request is taking longer than 10 seconds\nto complete.\n\nSetting a timeout to the zero duration (e.g. \"0s\") SHOULD disable the timeout\ncompletely. Implementations that cannot completely disable the timeout MUST\ninstead interpret the zero duration as the longest possible value to which\nthe timeout can be set.\n\nThis timeout is intended to cover as close to the whole request-response transaction\nas possible although an implementation MAY choose to start the timeout after the entire\nrequest stream has been received instead of immediately after the transaction is\ninitiated by the client.\n\nThe value of Request is a Gateway API Duration string as defined by GEP-2257. When this\nfield is unspecified, request timeout behavior is implementation-specific.\n\nSupport: Extended";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkRuleTimeouts =
    res:
    {
    }
    // optionalAttrs (res."backendRequest" != null) { inherit (res) "backendRequest"; }
    // {
    }
    // optionalAttrs (res."request" != null) { inherit (res) "request"; }
    // {
    };
  HttproutesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this HTTPRoute resource.";
        };
        "hostnames" = mkOption {
          description = "Hostnames defines a set of hostnames that should match against the HTTP Host\nheader to select a HTTPRoute used to process the request. Implementations\nMUST ignore any port value specified in the HTTP Host header while\nperforming a match and (absent of any applicable header modification\nconfiguration) MUST forward this header unmodified to the backend.\n\nValid values for Hostnames are determined by RFC 1123 definition of a\nhostname with 2 notable exceptions:\n\n1. IPs are not allowed.\n2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard\n   label must appear by itself as the first label.\n\nIf a hostname is specified by both the Listener and HTTPRoute, there\nmust be at least one intersecting hostname for the HTTPRoute to be\nattached to the Listener. For example:\n\n* A Listener with `test.example.com` as the hostname matches HTTPRoutes\n  that have either not specified any hostnames, or have specified at\n  least one of `test.example.com` or `*.example.com`.\n* A Listener with `*.example.com` as the hostname matches HTTPRoutes\n  that have either not specified any hostnames or have specified at least\n  one hostname that matches the Listener hostname. For example,\n  `*.example.com`, `test.example.com`, and `foo.test.example.com` would\n  all match. On the other hand, `example.com` and `test.example.net` would\n  not match.\n\nHostnames that are prefixed with a wildcard label (`*.`) are interpreted\nas a suffix match. That means that a match for `*.example.com` would match\nboth `test.example.com`, and `foo.test.example.com`, but not `example.com`.\n\nIf both the Listener and HTTPRoute have specified hostnames, any\nHTTPRoute hostnames that do not match the Listener hostname MUST be\nignored. For example, if a Listener specified `*.example.com`, and the\nHTTPRoute specified `test.example.com` and `test.example.net`,\n`test.example.net` must not be considered for a match.\n\nIf both the Listener and HTTPRoute have specified hostnames, and none\nmatch with the criteria above, then the HTTPRoute is not accepted. The\nimplementation must raise an 'Accepted' Condition with a status of\n`False` in the corresponding RouteParentStatus.\n\nIn the event that multiple HTTPRoutes specify intersecting hostnames (e.g.\noverlapping wildcard matching and exact matching hostnames), precedence must\nbe given to rules from the HTTPRoute with the largest number of:\n\n* Characters in a matching non-wildcard hostname.\n* Characters in a matching hostname.\n\nIf ties exist across multiple Routes, the matching precedence rules for\nHTTPRouteMatches takes over.\n\nSupport: Core";
          type = (types.listOf types.str);
          default = [ ];
        };
        "parentRefs" = mkOption {
          description = "ParentRefs references the resources (usually Gateways) that a Route wants\nto be attached to. Note that the referenced parent resource needs to\nallow this for the attachment to be complete. For Gateways, that means\nthe Gateway needs to allow attachment from Routes of this kind and\nnamespace. For Services, that means the Service must either be in the same\nnamespace for a \"producer\" route, or the mesh implementation must support\nand allow \"consumer\" routes for the referenced Service. ReferenceGrant is\nnot applicable for governing ParentRefs to Services - it is not possible to\ncreate a \"producer\" route for a Service in a different namespace from the\nRoute.\n\nThere are two kinds of parent resources with \"Core\" support:\n\n* Gateway (Gateway conformance profile)\n* Service (Mesh conformance profile, ClusterIP Services only)\n\nThis API may be extended in the future to support additional kinds of parent\nresources.\n\nParentRefs must be _distinct_. This means either that:\n\n* They select different objects.  If this is the case, then parentRef\n  entries are distinct. In terms of fields, this means that the\n  multi-part key defined by `group`, `kind`, `namespace`, and `name` must\n  be unique across all parentRef entries in the Route.\n* They do not select different objects, but for each optional field used,\n  each ParentRef that selects the same object must set the same set of\n  optional fields to different values. If one ParentRef sets a\n  combination of optional fields, all must set the same combination.\n\nSome examples:\n\n* If one ParentRef sets `sectionName`, all ParentRefs referencing the\n  same object must also set `sectionName`.\n* If one ParentRef sets `port`, all ParentRefs referencing the same\n  object must also set `port`.\n* If one ParentRef sets `sectionName` and `port`, all ParentRefs\n  referencing the same object must also set `sectionName` and `port`.\n\nIt is possible to separately reference multiple distinct objects that may\nbe collapsed by an implementation. For example, some implementations may\nchoose to merge compatible Gateway Listeners together. If that is the\ncase, the list of routes attached to those resources should also be\nmerged.\n\nNote that for ParentRefs that cross namespace boundaries, there are specific\nrules. Cross-namespace references are only valid if they are explicitly\nallowed by something in the namespace they are referring to. For example,\nGateway has the AllowedRoutes field, and ReferenceGrant provides a\ngeneric way to enable other kinds of cross-namespace reference.\n\n\nParentRefs from a Route to a Service in the same namespace are \"producer\"\nroutes, which apply default routing rules to inbound connections from\nany namespace to the Service.\n\nParentRefs from a Route to a Service in a different namespace are\n\"consumer\" routes, and these routing rules are only applied to outbound\nconnections originating from the same namespace as the Route, for which\nthe intended destination of the connections are a Service targeted as a\nParentRef of the Route.";
          type = (types.listOf ParentRefModule);
          default = [ ];
        };
        "rules" = mkOption {
          description = "Rules are a list of HTTP matchers, filters and actions.";
          type = (types.listOf RuleModule);
          default = [
            {
              "matches" = [
                {
                  "path" = {
                    "type" = "PathPrefix";
                    "value" = "/";
                  };
                }
              ];
            }
          ];
        };
      };
    }
  );
  mkHTTPRoute = name: res: {
    apiVersion = "gateway.networking.k8s.io/v1";
    kind = "HTTPRoute";
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
  allResources = (mapAttrsToList mkHTTPRoute cfg."httproutes");
in
{
  options.openkrill.apps."envoy-gateway" = {
    "httproutes" = mkOption {
      type = types.attrsOf HttproutesModule;
      default = { };
      description = "HTTPRoute CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."envoy-gateway".content = allResources;
  };
}
