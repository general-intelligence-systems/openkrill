# Auto-generated openkrill module fragment for envoy-gateway
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."envoy-gateway";
  compact = filterAttrs (_: v: v != null);
  ClientIPDetectionCustomHeaderModule = types.submodule {
    options = {
      "failClosed" = mkOption {
        description = "FailClosed is a switch used to control the flow of traffic when client IP detection\nfails. If set to true, the listener will respond with 403 Forbidden when the client\nIP address cannot be determined.";
        type = types.bool;
        default = false;
      };
      "name" = mkOption {
        description = "Name of the header containing the original downstream remote address, if present.";
        type = types.str;
      };
    };
  };
  mkClientIPDetectionCustomHeader =
    res:
    {
    }
    // optionalAttrs res."failClosed" { inherit (res) "failClosed"; }
    // {
      inherit (res) "name";
    };
  ClientIPDetectionModule = types.submodule {
    options = {
      "customHeader" = mkOption {
        description = "CustomHeader provides configuration for determining the client IP address for a request based on\na trusted custom HTTP header. This uses the custom_header original IP detection extension.\nRefer to https://www.envoyproxy.io/docs/envoy/latest/api-v3/extensions/http/original_ip_detection/custom_header/v3/custom_header.proto\nfor more details.";
        type = (types.nullOr ClientIPDetectionCustomHeaderModule);
        default = null;
      };
      "xForwardedFor" = mkOption {
        description = "XForwardedForSettings provides configuration for using X-Forwarded-For headers for determining the client IP address.";
        type = (types.nullOr ClientIPDetectionXForwardedForModule);
        default = null;
      };
    };
  };
  mkClientIPDetection =
    res:
    {
    }
    // optionalAttrs (res."customHeader" != null) {
      "customHeader" = mkClientIPDetectionCustomHeader res."customHeader";
    }
    // {
    }
    // optionalAttrs (res."xForwardedFor" != null) {
      "xForwardedFor" = mkClientIPDetectionXForwardedFor res."xForwardedFor";
    }
    // {
    };
  ClientIPDetectionXForwardedForModule = types.submodule {
    options = {
      "numTrustedHops" = mkOption {
        description = "NumTrustedHops controls the number of additional ingress proxy hops from the right side of XFF HTTP\nheaders to trust when determining the origin client's IP address.\nOnly one of NumTrustedHops and TrustedCIDRs must be set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "trustedCIDRs" = mkOption {
        description = "TrustedCIDRs is a list of CIDR ranges to trust when evaluating\nthe remote IP address to determine the original client’s IP address.\nWhen the remote IP address matches a trusted CIDR and the x-forwarded-for header was sent,\neach entry in the x-forwarded-for header is evaluated from right to left\nand the first public non-trusted address is used as the original client address.\nIf all addresses in x-forwarded-for are within the trusted list, the first (leftmost) entry is used.\nOnly one of NumTrustedHops and TrustedCIDRs must be set.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkClientIPDetectionXForwardedFor =
    res:
    {
    }
    // optionalAttrs (res."numTrustedHops" != null) { inherit (res) "numTrustedHops"; }
    // {
    }
    // optionalAttrs (res."trustedCIDRs" != [ ]) { inherit (res) "trustedCIDRs"; }
    // {
    };
  ConnectionConnectionLimitModule = types.submodule {
    options = {
      "closeDelay" = mkOption {
        description = "CloseDelay defines the delay to use before closing connections that are rejected\nonce the limit value is reached.\nDefault: none.";
        type = (types.nullOr types.str);
        default = null;
      };
      "value" = mkOption {
        description = "Value of the maximum concurrent connections limit.\nWhen the limit is reached, incoming connections will be closed after the CloseDelay duration.";
        type = types.int;
      };
    };
  };
  mkConnectionConnectionLimit =
    res:
    {
    }
    // optionalAttrs (res."closeDelay" != null) { inherit (res) "closeDelay"; }
    // {
      inherit (res) "value";
    };
  ConnectionModule = types.submodule {
    options = {
      "bufferLimit" = mkOption {
        description = "BufferLimit provides configuration for the maximum buffer size in bytes for each incoming connection.\nBufferLimit applies to connection streaming (maybe non-streaming) channel between processes, it's in user space.\nFor example, 20Mi, 1Gi, 256Ki etc.\nNote that when the suffix is not provided, the value is interpreted as bytes.\nDefault: 32768 bytes.";
        type = types.anything;
        default = { };
      };
      "connectionLimit" = mkOption {
        description = "ConnectionLimit defines limits related to connections";
        type = (types.nullOr ConnectionConnectionLimitModule);
        default = null;
      };
      "maxAcceptPerSocketEvent" = mkOption {
        description = "MaxAcceptPerSocketEvent provides configuration for the maximum number of connections to accept from the kernel\nper socket event. If there are more than MaxAcceptPerSocketEvent connections pending accept, connections over\nthis threshold will be accepted in later event loop iterations.\nDefaults to 1 and can be disabled by setting to 0 for allowing unlimited accepted connections.";
        type = (types.nullOr types.int);
        default = 1;
      };
      "socketBufferLimit" = mkOption {
        description = "SocketBufferLimit provides configuration for the maximum buffer size in bytes for each incoming socket.\nSocketBufferLimit applies to socket streaming channel between TCP/IP stacks, it's in kernel space.\nFor example, 20Mi, 1Gi, 256Ki etc.\nNote that when the suffix is not provided, the value is interpreted as bytes.";
        type = types.anything;
        default = { };
      };
    };
  };
  mkConnection =
    res:
    {
    }
    // optionalAttrs (res."bufferLimit" != null) { inherit (res) "bufferLimit"; }
    // {
    }
    // optionalAttrs (res."connectionLimit" != null) {
      "connectionLimit" = mkConnectionConnectionLimit res."connectionLimit";
    }
    // {
    }
    // optionalAttrs (res."maxAcceptPerSocketEvent" != null) {
      inherit (res) "maxAcceptPerSocketEvent";
    }
    // {
    }
    // optionalAttrs (res."socketBufferLimit" != null) { inherit (res) "socketBufferLimit"; }
    // {
    };
  HeadersEarlyRequestHeadersAddModule = types.submodule {
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
  mkHeadersEarlyRequestHeadersAdd = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  HeadersEarlyRequestHeadersModule = types.submodule {
    options = {
      "add" = mkOption {
        description = "Add adds the given header(s) (name, value) to the request\nbefore the action. It appends to any existing values associated\nwith the header name.\n\nInput:\n  GET /foo HTTP/1.1\n  my-header: foo\n\nConfig:\n  add:\n  - name: \"my-header\"\n    value: \"bar,baz\"\n\nOutput:\n  GET /foo HTTP/1.1\n  my-header: foo,bar,baz";
        type = (types.listOf HeadersEarlyRequestHeadersAddModule);
        default = [ ];
      };
      "remove" = mkOption {
        description = "Remove the given header(s) from the HTTP request before the action. The\nvalue of Remove is a list of HTTP header names. Note that the header\nnames are case-insensitive (see\nhttps://datatracker.ietf.org/doc/html/rfc2616#section-4.2).\n\nInput:\n  GET /foo HTTP/1.1\n  my-header1: foo\n  my-header2: bar\n  my-header3: baz\n\nConfig:\n  remove: [\"my-header1\", \"my-header3\"]\n\nOutput:\n  GET /foo HTTP/1.1\n  my-header2: bar";
        type = (types.listOf types.str);
        default = [ ];
      };
      "set" = mkOption {
        description = "Set overwrites the request with the given header (name, value)\nbefore the action.\n\nInput:\n  GET /foo HTTP/1.1\n  my-header: foo\n\nConfig:\n  set:\n  - name: \"my-header\"\n    value: \"bar\"\n\nOutput:\n  GET /foo HTTP/1.1\n  my-header: bar";
        type = (types.listOf HeadersEarlyRequestHeadersSetModule);
        default = [ ];
      };
    };
  };
  mkHeadersEarlyRequestHeaders =
    res:
    {
    }
    // optionalAttrs (res."add" != [ ]) { "add" = map mkHeadersEarlyRequestHeadersAdd res."add"; }
    // {
    }
    // optionalAttrs (res."remove" != [ ]) { inherit (res) "remove"; }
    // {
    }
    // optionalAttrs (res."set" != [ ]) { "set" = map mkHeadersEarlyRequestHeadersSet res."set"; }
    // {
    };
  HeadersEarlyRequestHeadersSetModule = types.submodule {
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
  mkHeadersEarlyRequestHeadersSet = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  HeadersModule = types.submodule {
    options = {
      "disableRateLimitHeaders" = mkOption {
        description = "DisableRateLimitHeaders configures Envoy Proxy to omit the \"X-RateLimit-\" response headers\nwhen rate limiting is enabled.";
        type = types.bool;
        default = false;
      };
      "earlyRequestHeaders" = mkOption {
        description = "EarlyRequestHeaders defines settings for early request header modification, before envoy performs\nrouting, tracing and built-in header manipulation.";
        type = (types.nullOr HeadersEarlyRequestHeadersModule);
        default = null;
      };
      "enableEnvoyHeaders" = mkOption {
        description = "EnableEnvoyHeaders configures Envoy Proxy to add the \"X-Envoy-\" headers to requests\nand responses.";
        type = types.bool;
        default = false;
      };
      "preserveXRequestID" = mkOption {
        description = "PreserveXRequestID configures Envoy to keep the X-Request-ID header if passed for a request that is edge\n(Edge request is the request from external clients to front Envoy) and not reset it, which is the current Envoy behaviour.\nDefaults to false and cannot be combined with RequestID.\nDeprecated: use RequestID=Preserve instead";
        type = types.bool;
        default = false;
      };
      "requestID" = mkOption {
        description = "RequestID configures Envoy's behavior for handling the `X-Request-ID` header.\nDefaults to `Generate` and builds the `X-Request-ID` for every request and ignores pre-existing values from the edge.\n(An \"edge request\" refers to a request from an external client to the Envoy entrypoint.)";
        type = (
          types.nullOr (
            types.enum [
              "PreserveOrGenerate"
              "Preserve"
              "Generate"
              "Disable"
            ]
          )
        );
        default = null;
      };
      "withUnderscoresAction" = mkOption {
        description = "WithUnderscoresAction configures the action to take when an HTTP header with underscores\nis encountered. The default action is to reject the request.";
        type = (
          types.nullOr (
            types.enum [
              "Allow"
              "RejectRequest"
              "DropHeader"
            ]
          )
        );
        default = null;
      };
      "xForwardedClientCert" = mkOption {
        description = "XForwardedClientCert configures how Envoy Proxy handle the x-forwarded-client-cert (XFCC) HTTP header.\n\nx-forwarded-client-cert (XFCC) is an HTTP header used to forward the certificate\ninformation of part or all of the clients or proxies that a request has flowed through,\non its way from the client to the server.\n\nEnvoy proxy may choose to sanitize/append/forward the XFCC header before proxying the request.\n\nIf not set, the default behavior is sanitizing the XFCC header.";
        type = (types.nullOr HeadersXForwardedClientCertModule);
        default = null;
      };
    };
  };
  mkHeaders =
    res:
    {
    }
    // optionalAttrs res."disableRateLimitHeaders" { inherit (res) "disableRateLimitHeaders"; }
    // {
    }
    // optionalAttrs (res."earlyRequestHeaders" != null) {
      "earlyRequestHeaders" = mkHeadersEarlyRequestHeaders res."earlyRequestHeaders";
    }
    // {
    }
    // optionalAttrs res."enableEnvoyHeaders" { inherit (res) "enableEnvoyHeaders"; }
    // {
    }
    // optionalAttrs res."preserveXRequestID" { inherit (res) "preserveXRequestID"; }
    // {
    }
    // optionalAttrs (res."requestID" != null) { inherit (res) "requestID"; }
    // {
    }
    // optionalAttrs (res."withUnderscoresAction" != null) { inherit (res) "withUnderscoresAction"; }
    // {
    }
    // optionalAttrs (res."xForwardedClientCert" != null) {
      "xForwardedClientCert" = mkHeadersXForwardedClientCert res."xForwardedClientCert";
    }
    // {
    };
  HeadersXForwardedClientCertModule = types.submodule {
    options = {
      "certDetailsToAdd" = mkOption {
        description = "CertDetailsToAdd specifies the fields in the client certificate to be forwarded in the XFCC header.\n\nHash(the SHA 256 digest of the current client certificate) and By(the Subject Alternative Name)\nare always included if the client certificate is forwarded.\n\nThis field is only applicable when the mode is set to `AppendForward` or\n`SanitizeSet` and the client connection is mTLS.";
        type = (
          types.listOf (
            types.enum [
              "Subject"
              "Cert"
              "Chain"
              "DNS"
              "URI"
            ]
          )
        );
        default = [ ];
      };
      "mode" = mkOption {
        description = "Mode defines how XFCC header is handled by Envoy Proxy.\nIf not set, the default mode is `Sanitize`.";
        type = (
          types.nullOr (
            types.enum [
              "Sanitize"
              "ForwardOnly"
              "AppendForward"
              "SanitizeSet"
              "AlwaysForwardOnly"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkHeadersXForwardedClientCert =
    res:
    {
    }
    // optionalAttrs (res."certDetailsToAdd" != [ ]) { inherit (res) "certDetailsToAdd"; }
    // {
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
    };
  HealthCheckModule = types.submodule {
    options = {
      "path" = mkOption {
        description = "Path specifies the HTTP path to match on for health check requests.";
        type = types.str;
      };
    };
  };
  mkHealthCheck = res: {
    inherit (res) "path";
  };
  Http1Http10Module = types.submodule {
    options = {
      "useDefaultHost" = mkOption {
        description = "UseDefaultHost defines if the HTTP/1.0 request is missing the Host header,\nthen the hostname associated with the listener should be injected into the\nrequest.\nIf this is not set and an HTTP/1.0 request arrives without a host, then\nit will be rejected.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkHttp1Http10 =
    res:
    {
    }
    // optionalAttrs res."useDefaultHost" { inherit (res) "useDefaultHost"; }
    // {
    };
  Http1Module = types.submodule {
    options = {
      "enableTrailers" = mkOption {
        description = "EnableTrailers defines if HTTP/1 trailers should be proxied by Envoy.";
        type = types.bool;
        default = false;
      };
      "http10" = mkOption {
        description = "HTTP10 turns on support for HTTP/1.0 and HTTP/0.9 requests.";
        type = (types.nullOr Http1Http10Module);
        default = null;
      };
      "preserveHeaderCase" = mkOption {
        description = "PreserveHeaderCase defines if Envoy should preserve the letter case of headers.\nBy default, Envoy will lowercase all the headers.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkHttp1 =
    res:
    {
    }
    // optionalAttrs res."enableTrailers" { inherit (res) "enableTrailers"; }
    // {
    }
    // optionalAttrs (res."http10" != null) { "http10" = mkHttp1Http10 res."http10"; }
    // {
    }
    // optionalAttrs res."preserveHeaderCase" { inherit (res) "preserveHeaderCase"; }
    // {
    };
  Http2Module = types.submodule {
    options = {
      "initialConnectionWindowSize" = mkOption {
        description = "InitialConnectionWindowSize sets the initial window size for HTTP/2 connections.\nIf not set, the default value is 1 MiB.";
        type = types.anything;
        default = { };
      };
      "initialStreamWindowSize" = mkOption {
        description = "InitialStreamWindowSize sets the initial window size for HTTP/2 streams.\nIf not set, the default value is 64 KiB(64*1024).";
        type = types.anything;
        default = { };
      };
      "maxConcurrentStreams" = mkOption {
        description = "MaxConcurrentStreams sets the maximum number of concurrent streams allowed per connection.\nIf not set, the default value is 100.";
        type = (types.nullOr types.int);
        default = null;
      };
      "onInvalidMessage" = mkOption {
        description = "OnInvalidMessage determines if Envoy will terminate the connection or just the offending stream in the event of HTTP messaging error\nIt's recommended for L2 Envoy deployments to set this value to TerminateStream.\nhttps://www.envoyproxy.io/docs/envoy/latest/configuration/best_practices/level_two\nDefault: TerminateConnection";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkHttp2 =
    res:
    {
    }
    // optionalAttrs (res."initialConnectionWindowSize" != null) {
      inherit (res) "initialConnectionWindowSize";
    }
    // {
    }
    // optionalAttrs (res."initialStreamWindowSize" != null) {
      inherit (res) "initialStreamWindowSize";
    }
    // {
    }
    // optionalAttrs (res."maxConcurrentStreams" != null) { inherit (res) "maxConcurrentStreams"; }
    // {
    }
    // optionalAttrs (res."onInvalidMessage" != null) { inherit (res) "onInvalidMessage"; }
    // {
    };
  PathModule = types.submodule {
    options = {
      "disableMergeSlashes" = mkOption {
        description = "DisableMergeSlashes allows disabling the default configuration of merging adjacent\nslashes in the path.\nNote that slash merging is not part of the HTTP spec and is provided for convenience.";
        type = types.bool;
        default = false;
      };
      "escapedSlashesAction" = mkOption {
        description = "EscapedSlashesAction determines how %2f, %2F, %5c, or %5C sequences in the path URI\nshould be handled.\nThe default is UnescapeAndRedirect.";
        type = (
          types.nullOr (
            types.enum [
              "KeepUnchanged"
              "RejectRequest"
              "UnescapeAndForward"
              "UnescapeAndRedirect"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkPath =
    res:
    {
    }
    // optionalAttrs res."disableMergeSlashes" { inherit (res) "disableMergeSlashes"; }
    // {
    }
    // optionalAttrs (res."escapedSlashesAction" != null) { inherit (res) "escapedSlashesAction"; }
    // {
    };
  ProxyProtocolModule = types.submodule {
    options = {
      "optional" = mkOption {
        description = "Optional allows requests without a Proxy Protocol header to be proxied.\nIf set to true, the listener will accept requests without a Proxy Protocol header.\nIf set to false, the listener will reject requests without a Proxy Protocol header.\nIf not set, the default behavior is to reject requests without a Proxy Protocol header.\nWarning: Optional breaks conformance with the specification. Only enable if ALL traffic to the listener comes from a trusted source.\nFor more information on security implications, see haproxy.org/download/2.1/doc/proxy-protocol.txt";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProxyProtocol =
    res:
    {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
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
  TargetSelectorMatchExpressionModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the label key that the selector applies to.";
        type = types.str;
      };
      "operator" = mkOption {
        description = "operator represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists and DoesNotExist.";
        type = types.str;
      };
      "values" = mkOption {
        description = "values is an array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. This array is replaced during a strategic\nmerge patch.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkTargetSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  TargetSelectorModule = types.submodule {
    options = {
      "group" = mkOption {
        description = "Group is the group that this selector targets. Defaults to gateway.networking.k8s.io";
        type = (types.nullOr types.str);
        default = "gateway.networking.k8s.io";
      };
      "kind" = mkOption {
        description = "Kind is the resource kind that this selector targets.";
        type = types.str;
      };
      "matchExpressions" = mkOption {
        description = "MatchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf TargetSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "MatchLabels are the set of label selectors for identifying the targeted resource";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkTargetSelector =
    res:
    {
    }
    // optionalAttrs (res."group" != null) { inherit (res) "group"; }
    // {
      inherit (res) "kind";
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkTargetSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  TcpKeepaliveModule = types.submodule {
    options = {
      "idleTime" = mkOption {
        description = "The duration a connection needs to be idle before keep-alive\nprobes start being sent.\nThe duration format is\nDefaults to `7200s`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "interval" = mkOption {
        description = "The duration between keep-alive probes.\nDefaults to `75s`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "probes" = mkOption {
        description = "The total number of unacknowledged probes to send before deciding\nthe connection is dead.\nDefaults to 9.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkTcpKeepalive =
    res:
    {
    }
    // optionalAttrs (res."idleTime" != null) { inherit (res) "idleTime"; }
    // {
    }
    // optionalAttrs (res."interval" != null) { inherit (res) "interval"; }
    // {
    }
    // optionalAttrs (res."probes" != null) { inherit (res) "probes"; }
    // {
    };
  TimeoutHttpModule = types.submodule {
    options = {
      "idleTimeout" = mkOption {
        description = "IdleTimeout for an HTTP connection. Idle time is defined as a period in which there are no active requests in the connection.\nDefault: 1 hour.";
        type = (types.nullOr types.str);
        default = null;
      };
      "requestReceivedTimeout" = mkOption {
        description = "RequestReceivedTimeout is the duration envoy waits for the complete request reception. This timer starts upon request\ninitiation and stops when either the last byte of the request is sent upstream or when the response begins.";
        type = (types.nullOr types.str);
        default = null;
      };
      "streamIdleTimeout" = mkOption {
        description = " The stream idle timeout defines the amount of time a stream can exist without any upstream or downstream activity.\n Default: 5 minutes.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTimeoutHttp =
    res:
    {
    }
    // optionalAttrs (res."idleTimeout" != null) { inherit (res) "idleTimeout"; }
    // {
    }
    // optionalAttrs (res."requestReceivedTimeout" != null) { inherit (res) "requestReceivedTimeout"; }
    // {
    }
    // optionalAttrs (res."streamIdleTimeout" != null) { inherit (res) "streamIdleTimeout"; }
    // {
    };
  TimeoutModule = types.submodule {
    options = {
      "http" = mkOption {
        description = "Timeout settings for HTTP.";
        type = (types.nullOr TimeoutHttpModule);
        default = null;
      };
      "tcp" = mkOption {
        description = "Timeout settings for TCP.";
        type = (types.nullOr TimeoutTcpModule);
        default = null;
      };
    };
  };
  mkTimeout =
    res:
    {
    }
    // optionalAttrs (res."http" != null) { "http" = mkTimeoutHttp res."http"; }
    // {
    }
    // optionalAttrs (res."tcp" != null) { "tcp" = mkTimeoutTcp res."tcp"; }
    // {
    };
  TimeoutTcpModule = types.submodule {
    options = {
      "idleTimeout" = mkOption {
        description = "IdleTimeout for a TCP connection. Idle time is defined as a period in which there are no\nbytes sent or received on either the upstream or downstream connection.\nDefault: 1 hour.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTimeoutTcp =
    res:
    {
    }
    // optionalAttrs (res."idleTimeout" != null) { inherit (res) "idleTimeout"; }
    // {
    };
  TlsClientValidationCaCertificateRefModule = types.submodule {
    options = {
      "group" = mkOption {
        description = "Group is the group of the referent. For example, \"gateway.networking.k8s.io\".\nWhen unspecified or empty string, core API group is inferred.";
        type = (types.nullOr types.str);
        default = "";
      };
      "kind" = mkOption {
        description = "Kind is kind of the referent. For example \"Secret\".";
        type = (types.nullOr types.str);
        default = "Secret";
      };
      "name" = mkOption {
        description = "Name is the name of the referent.";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "Namespace is the namespace of the referenced object. When unspecified, the local\nnamespace is inferred.\n\nNote that when a namespace different than the local namespace is specified,\na ReferenceGrant object is required in the referent namespace to allow that\nnamespace's owner to accept the reference. See the ReferenceGrant\ndocumentation for details.\n\nSupport: Core";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTlsClientValidationCaCertificateRef =
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
    };
  TlsClientValidationModule = types.submodule {
    options = {
      "caCertificateRefs" = mkOption {
        description = "CACertificateRefs contains one or more references to\nKubernetes objects that contain TLS certificates of\nthe Certificate Authorities that can be used\nas a trust anchor to validate the certificates presented by the client.\n\nA single reference to a Kubernetes ConfigMap or a Kubernetes Secret,\nwith the CA certificate in a key named `ca.crt` is currently supported.\n\nReferences to a resource in different namespace are invalid UNLESS there\nis a ReferenceGrant in the target namespace that allows the certificate\nto be attached.";
        type = (types.listOf TlsClientValidationCaCertificateRefModule);
        default = [ ];
      };
      "certificateHashes" = mkOption {
        description = "An optional list of hex-encoded SHA-256 hashes. If specified, Envoy will\nverify that the SHA-256 of the DER-encoded presented certificate matches\none of the specified values.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "optional" = mkOption {
        description = "Optional set to true accepts connections even when a client doesn't present a certificate.\nDefaults to false, which rejects connections without a valid client certificate.";
        type = types.bool;
        default = false;
      };
      "spkiHashes" = mkOption {
        description = "An optional list of base64-encoded SHA-256 hashes. If specified, Envoy will\nverify that the SHA-256 of the DER-encoded Subject Public Key Information\n(SPKI) of the presented certificate matches one of the specified values.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "subjectAltNames" = mkOption {
        description = "An optional list of Subject Alternative name matchers. If specified, Envoy\nwill verify that the Subject Alternative Name of the presented certificate\nmatches one of the specified matchers";
        type = (types.nullOr TlsClientValidationSubjectAltNamesModule);
        default = null;
      };
    };
  };
  mkTlsClientValidation =
    res:
    {
    }
    // optionalAttrs (res."caCertificateRefs" != [ ]) {
      "caCertificateRefs" = map mkTlsClientValidationCaCertificateRef res."caCertificateRefs";
    }
    // {
    }
    // optionalAttrs (res."certificateHashes" != [ ]) { inherit (res) "certificateHashes"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    }
    // optionalAttrs (res."spkiHashes" != [ ]) { inherit (res) "spkiHashes"; }
    // {
    }
    // optionalAttrs (res."subjectAltNames" != null) {
      "subjectAltNames" = mkTlsClientValidationSubjectAltNames res."subjectAltNames";
    }
    // {
    };
  TlsClientValidationSubjectAltNamesDnsNameModule = types.submodule {
    options = {
      "type" = mkOption {
        description = "Type specifies how to match against a string.";
        type = (
          types.nullOr (
            types.enum [
              "Exact"
              "Prefix"
              "Suffix"
              "RegularExpression"
            ]
          )
        );
        default = "Exact";
      };
      "value" = mkOption {
        description = "Value specifies the string value that the match must have.";
        type = types.str;
      };
    };
  };
  mkTlsClientValidationSubjectAltNamesDnsName =
    res:
    {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
      inherit (res) "value";
    };
  TlsClientValidationSubjectAltNamesEmailAddresseModule = types.submodule {
    options = {
      "type" = mkOption {
        description = "Type specifies how to match against a string.";
        type = (
          types.nullOr (
            types.enum [
              "Exact"
              "Prefix"
              "Suffix"
              "RegularExpression"
            ]
          )
        );
        default = "Exact";
      };
      "value" = mkOption {
        description = "Value specifies the string value that the match must have.";
        type = types.str;
      };
    };
  };
  mkTlsClientValidationSubjectAltNamesEmailAddresse =
    res:
    {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
      inherit (res) "value";
    };
  TlsClientValidationSubjectAltNamesIpAddresseModule = types.submodule {
    options = {
      "type" = mkOption {
        description = "Type specifies how to match against a string.";
        type = (
          types.nullOr (
            types.enum [
              "Exact"
              "Prefix"
              "Suffix"
              "RegularExpression"
            ]
          )
        );
        default = "Exact";
      };
      "value" = mkOption {
        description = "Value specifies the string value that the match must have.";
        type = types.str;
      };
    };
  };
  mkTlsClientValidationSubjectAltNamesIpAddresse =
    res:
    {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
      inherit (res) "value";
    };
  TlsClientValidationSubjectAltNamesModule = types.submodule {
    options = {
      "dnsNames" = mkOption {
        description = "DNS names matchers";
        type = (types.listOf TlsClientValidationSubjectAltNamesDnsNameModule);
        default = [ ];
      };
      "emailAddresses" = mkOption {
        description = "Email addresses matchers";
        type = (types.listOf TlsClientValidationSubjectAltNamesEmailAddresseModule);
        default = [ ];
      };
      "ipAddresses" = mkOption {
        description = "IP addresses matchers";
        type = (types.listOf TlsClientValidationSubjectAltNamesIpAddresseModule);
        default = [ ];
      };
      "otherNames" = mkOption {
        description = "Other names matchers";
        type = (types.listOf TlsClientValidationSubjectAltNamesOtherNameModule);
        default = [ ];
      };
      "uris" = mkOption {
        description = "URIs matchers";
        type = (types.listOf TlsClientValidationSubjectAltNamesUriModule);
        default = [ ];
      };
    };
  };
  mkTlsClientValidationSubjectAltNames =
    res:
    {
    }
    // optionalAttrs (res."dnsNames" != [ ]) {
      "dnsNames" = map mkTlsClientValidationSubjectAltNamesDnsName res."dnsNames";
    }
    // {
    }
    // optionalAttrs (res."emailAddresses" != [ ]) {
      "emailAddresses" = map mkTlsClientValidationSubjectAltNamesEmailAddresse res."emailAddresses";
    }
    // {
    }
    // optionalAttrs (res."ipAddresses" != [ ]) {
      "ipAddresses" = map mkTlsClientValidationSubjectAltNamesIpAddresse res."ipAddresses";
    }
    // {
    }
    // optionalAttrs (res."otherNames" != [ ]) {
      "otherNames" = map mkTlsClientValidationSubjectAltNamesOtherName res."otherNames";
    }
    // {
    }
    // optionalAttrs (res."uris" != [ ]) {
      "uris" = map mkTlsClientValidationSubjectAltNamesUri res."uris";
    }
    // {
    };
  TlsClientValidationSubjectAltNamesOtherNameModule = types.submodule {
    options = {
      "oid" = mkOption {
        description = "OID Value";
        type = types.str;
      };
      "type" = mkOption {
        description = "Type specifies how to match against a string.";
        type = (
          types.nullOr (
            types.enum [
              "Exact"
              "Prefix"
              "Suffix"
              "RegularExpression"
            ]
          )
        );
        default = "Exact";
      };
      "value" = mkOption {
        description = "Value specifies the string value that the match must have.";
        type = types.str;
      };
    };
  };
  mkTlsClientValidationSubjectAltNamesOtherName =
    res:
    {
      inherit (res) "oid";
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
      inherit (res) "value";
    };
  TlsClientValidationSubjectAltNamesUriModule = types.submodule {
    options = {
      "type" = mkOption {
        description = "Type specifies how to match against a string.";
        type = (
          types.nullOr (
            types.enum [
              "Exact"
              "Prefix"
              "Suffix"
              "RegularExpression"
            ]
          )
        );
        default = "Exact";
      };
      "value" = mkOption {
        description = "Value specifies the string value that the match must have.";
        type = types.str;
      };
    };
  };
  mkTlsClientValidationSubjectAltNamesUri =
    res:
    {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
      inherit (res) "value";
    };
  TlsModule = types.submodule {
    options = {
      "alpnProtocols" = mkOption {
        description = "ALPNProtocols supplies the list of ALPN protocols that should be\nexposed by the listener or used by the proxy to connect to the backend.\nDefaults:\n1. HTTPS Routes: h2 and http/1.1 are enabled in listener context.\n2. Other Routes: ALPN is disabled.\n3. Backends: proxy uses the appropriate ALPN options for the backend protocol.\nWhen an empty list is provided, the ALPN TLS extension is disabled.\nSupported values are:\n- http/1.0\n- http/1.1\n- h2";
        type = (
          types.listOf (
            types.enum [
              "http/1.0"
              "http/1.1"
              "h2"
            ]
          )
        );
        default = [ ];
      };
      "ciphers" = mkOption {
        description = "Ciphers specifies the set of cipher suites supported when\nnegotiating TLS 1.0 - 1.2. This setting has no effect for TLS 1.3.\nIn non-FIPS Envoy Proxy builds the default cipher list is:\n- [ECDHE-ECDSA-AES128-GCM-SHA256|ECDHE-ECDSA-CHACHA20-POLY1305]\n- [ECDHE-RSA-AES128-GCM-SHA256|ECDHE-RSA-CHACHA20-POLY1305]\n- ECDHE-ECDSA-AES256-GCM-SHA384\n- ECDHE-RSA-AES256-GCM-SHA384\nIn builds using BoringSSL FIPS the default cipher list is:\n- ECDHE-ECDSA-AES128-GCM-SHA256\n- ECDHE-RSA-AES128-GCM-SHA256\n- ECDHE-ECDSA-AES256-GCM-SHA384\n- ECDHE-RSA-AES256-GCM-SHA384";
        type = (types.listOf types.str);
        default = [ ];
      };
      "clientValidation" = mkOption {
        description = "ClientValidation specifies the configuration to validate the client\ninitiating the TLS connection to the Gateway listener.";
        type = (types.nullOr TlsClientValidationModule);
        default = null;
      };
      "ecdhCurves" = mkOption {
        description = "ECDHCurves specifies the set of supported ECDH curves.\nIn non-FIPS Envoy Proxy builds the default curves are:\n- X25519\n- P-256\nIn builds using BoringSSL FIPS the default curve is:\n- P-256";
        type = (types.listOf types.str);
        default = [ ];
      };
      "maxVersion" = mkOption {
        description = "Max specifies the maximal TLS protocol version to allow\nThe default is TLS 1.3 if this is not specified.";
        type = (
          types.nullOr (
            types.enum [
              "Auto"
              "1.0"
              "1.1"
              "1.2"
              "1.3"
            ]
          )
        );
        default = null;
      };
      "minVersion" = mkOption {
        description = "Min specifies the minimal TLS protocol version to allow.\nThe default is TLS 1.2 if this is not specified.";
        type = (
          types.nullOr (
            types.enum [
              "Auto"
              "1.0"
              "1.1"
              "1.2"
              "1.3"
            ]
          )
        );
        default = null;
      };
      "session" = mkOption {
        description = "Session defines settings related to TLS session management.";
        type = (types.nullOr TlsSessionModule);
        default = null;
      };
      "signatureAlgorithms" = mkOption {
        description = "SignatureAlgorithms specifies which signature algorithms the listener should\nsupport.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkTls =
    res:
    {
    }
    // optionalAttrs (res."alpnProtocols" != [ ]) { inherit (res) "alpnProtocols"; }
    // {
    }
    // optionalAttrs (res."ciphers" != [ ]) { inherit (res) "ciphers"; }
    // {
    }
    // optionalAttrs (res."clientValidation" != null) {
      "clientValidation" = mkTlsClientValidation res."clientValidation";
    }
    // {
    }
    // optionalAttrs (res."ecdhCurves" != [ ]) { inherit (res) "ecdhCurves"; }
    // {
    }
    // optionalAttrs (res."maxVersion" != null) { inherit (res) "maxVersion"; }
    // {
    }
    // optionalAttrs (res."minVersion" != null) { inherit (res) "minVersion"; }
    // {
    }
    // optionalAttrs (res."session" != null) { "session" = mkTlsSession res."session"; }
    // {
    }
    // optionalAttrs (res."signatureAlgorithms" != [ ]) { inherit (res) "signatureAlgorithms"; }
    // {
    };
  TlsSessionModule = types.submodule {
    options = {
      "resumption" = mkOption {
        description = "Resumption determines the proxy's supported TLS session resumption option.\nBy default, Envoy Gateway does not enable session resumption. Use sessionResumption to\nenable stateful and stateless session resumption. Users should consider security impacts\nof different resumption methods. Performance gains from resumption are diminished when\nEnvoy proxy is deployed with more than one replica.";
        type = (types.nullOr TlsSessionResumptionModule);
        default = null;
      };
    };
  };
  mkTlsSession =
    res:
    {
    }
    // optionalAttrs (res."resumption" != null) {
      "resumption" = mkTlsSessionResumption res."resumption";
    }
    // {
    };
  TlsSessionResumptionModule = types.submodule {
    options = {
      "stateful" = mkOption {
        description = "Stateful defines setting for stateful (session-id based) session resumption";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "stateless" = mkOption {
        description = "Stateless defines setting for stateless (session-ticket based) session resumption";
        type = (types.attrsOf types.anything);
        default = { };
      };
    };
  };
  mkTlsSessionResumption =
    res:
    {
    }
    // optionalAttrs (res."stateful" != { }) { inherit (res) "stateful"; }
    // {
    }
    // optionalAttrs (res."stateless" != { }) { inherit (res) "stateless"; }
    // {
    };
  ClienttrafficpoliciesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this ClientTrafficPolicy resource.";
        };
        "clientIPDetection" = mkOption {
          description = "ClientIPDetectionSettings provides configuration for determining the original client IP address for requests.";
          type = (types.nullOr ClientIPDetectionModule);
          default = null;
        };
        "connection" = mkOption {
          description = "Connection includes client connection settings.";
          type = (types.nullOr ConnectionModule);
          default = null;
        };
        "enableProxyProtocol" = mkOption {
          description = "EnableProxyProtocol interprets the ProxyProtocol header and adds the\nClient Address into the X-Forwarded-For header.\nNote Proxy Protocol must be present when this field is set, else the connection\nis closed.\n\nDeprecated: Use ProxyProtocol instead.";
          type = types.bool;
          default = false;
        };
        "headers" = mkOption {
          description = "HeaderSettings provides configuration for header management.";
          type = (types.nullOr HeadersModule);
          default = null;
        };
        "healthCheck" = mkOption {
          description = "HealthCheck provides configuration for determining whether the HTTP/HTTPS listener is healthy.";
          type = (types.nullOr HealthCheckModule);
          default = null;
        };
        "http1" = mkOption {
          description = "HTTP1 provides HTTP/1 configuration on the listener.";
          type = (types.nullOr Http1Module);
          default = null;
        };
        "http2" = mkOption {
          description = "HTTP2 provides HTTP/2 configuration on the listener.";
          type = (types.nullOr Http2Module);
          default = null;
        };
        "http3" = mkOption {
          description = "HTTP3 provides HTTP/3 configuration on the listener.";
          type = (types.attrsOf types.anything);
          default = { };
        };
        "path" = mkOption {
          description = "Path enables managing how the incoming path set by clients can be normalized.";
          type = (types.nullOr PathModule);
          default = null;
        };
        "proxyProtocol" = mkOption {
          description = "ProxyProtocol configures the Proxy Protocol settings. When configured,\nthe Proxy Protocol header will be interpreted and the Client Address\nwill be added into the X-Forwarded-For header.\nIf both EnableProxyProtocol and ProxyProtocol are set, ProxyProtocol takes precedence.";
          type = (types.nullOr ProxyProtocolModule);
          default = null;
        };
        "targetRef" = mkOption {
          description = "TargetRef is the name of the resource this policy is being attached to.\nThis policy and the TargetRef MUST be in the same namespace for this\nPolicy to have effect\n\nDeprecated: use targetRefs/targetSelectors instead";
          type = (types.nullOr TargetRefModule);
          default = null;
        };
        "targetRefs" = mkOption {
          description = "TargetRefs are the names of the Gateway resources this policy\nis being attached to.";
          type = (types.listOf TargetRefModule);
          default = [ ];
        };
        "targetSelectors" = mkOption {
          description = "TargetSelectors allow targeting resources for this policy based on labels";
          type = (types.listOf TargetSelectorModule);
          default = [ ];
        };
        "tcpKeepalive" = mkOption {
          description = "TcpKeepalive settings associated with the downstream client connection.\nIf defined, sets SO_KEEPALIVE on the listener socket to enable TCP Keepalives.\nDisabled by default.";
          type = (types.nullOr TcpKeepaliveModule);
          default = null;
        };
        "timeout" = mkOption {
          description = "Timeout settings for the client connections.";
          type = (types.nullOr TimeoutModule);
          default = null;
        };
        "tls" = mkOption {
          description = "TLS settings configure TLS termination settings with the downstream client.";
          type = (types.nullOr TlsModule);
          default = null;
        };
      };
    }
  );
  mkClientTrafficPolicy = name: res: {
    apiVersion = "gateway.envoyproxy.io/v1alpha1";
    kind = "ClientTrafficPolicy";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."clientIPDetection" != null) {
      "clientIPDetection" = mkClientIPDetection res."clientIPDetection";
    }
    // {
    }
    // optionalAttrs (res."connection" != null) { "connection" = mkConnection res."connection"; }
    // {
    }
    // optionalAttrs res."enableProxyProtocol" { inherit (res) "enableProxyProtocol"; }
    // {
    }
    // optionalAttrs (res."headers" != null) { "headers" = mkHeaders res."headers"; }
    // {
    }
    // optionalAttrs (res."healthCheck" != null) { "healthCheck" = mkHealthCheck res."healthCheck"; }
    // {
    }
    // optionalAttrs (res."http1" != null) { "http1" = mkHttp1 res."http1"; }
    // {
    }
    // optionalAttrs (res."http2" != null) { "http2" = mkHttp2 res."http2"; }
    // {
    }
    // optionalAttrs (res."http3" != { }) { inherit (res) "http3"; }
    // {
    }
    // optionalAttrs (res."path" != null) { "path" = mkPath res."path"; }
    // {
    }
    // optionalAttrs (res."proxyProtocol" != null) {
      "proxyProtocol" = mkProxyProtocol res."proxyProtocol";
    }
    // {
    }
    // optionalAttrs (res."targetRef" != null) { "targetRef" = mkTargetRef res."targetRef"; }
    // {
    }
    // optionalAttrs (res."targetRefs" != [ ]) { "targetRefs" = map mkTargetRef res."targetRefs"; }
    // {
    }
    // optionalAttrs (res."targetSelectors" != [ ]) {
      "targetSelectors" = map mkTargetSelector res."targetSelectors";
    }
    // {
    }
    // optionalAttrs (res."tcpKeepalive" != null) {
      "tcpKeepalive" = mkTcpKeepalive res."tcpKeepalive";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) { "timeout" = mkTimeout res."timeout"; }
    // {
    }
    // optionalAttrs (res."tls" != null) { "tls" = mkTls res."tls"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkClientTrafficPolicy cfg."clienttrafficpolicies");
in
{
  options.openkrill.apps."envoy-gateway" = {
    "clienttrafficpolicies" = mkOption {
      type = types.attrsOf ClienttrafficpoliciesModule;
      default = { };
      description = "ClientTrafficPolicy CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."envoy-gateway".content = allResources;
  };
}
