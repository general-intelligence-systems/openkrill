# Auto-generated openkrill module fragment for envoy-gateway
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."envoy-gateway";
  compact = filterAttrs (_: v: v != null);
  ExtProcBackendRefModule = types.submodule {
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
  mkExtProcBackendRef =
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
  ExtProcBackendSettingsCircuitBreakerModule = types.submodule {
    options = {
      "maxConnections" = mkOption {
        description = "The maximum number of connections that Envoy will establish to the referenced backend defined within a xRoute rule.";
        type = (types.nullOr types.int);
        default = 1024;
      };
      "maxParallelRequests" = mkOption {
        description = "The maximum number of parallel requests that Envoy will make to the referenced backend defined within a xRoute rule.";
        type = (types.nullOr types.int);
        default = 1024;
      };
      "maxParallelRetries" = mkOption {
        description = "The maximum number of parallel retries that Envoy will make to the referenced backend defined within a xRoute rule.";
        type = (types.nullOr types.int);
        default = 1024;
      };
      "maxPendingRequests" = mkOption {
        description = "The maximum number of pending requests that Envoy will queue to the referenced backend defined within a xRoute rule.";
        type = (types.nullOr types.int);
        default = 1024;
      };
      "maxRequestsPerConnection" = mkOption {
        description = "The maximum number of requests that Envoy will make over a single connection to the referenced backend defined within a xRoute rule.\nDefault: unlimited.";
        type = (types.nullOr types.int);
        default = null;
      };
      "perEndpoint" = mkOption {
        description = "PerEndpoint defines Circuit Breakers that will apply per-endpoint for an upstream cluster";
        type = (types.nullOr ExtProcBackendSettingsCircuitBreakerPerEndpointModule);
        default = null;
      };
    };
  };
  mkExtProcBackendSettingsCircuitBreaker =
    res:
    {
    }
    // optionalAttrs (res."maxConnections" != null) { inherit (res) "maxConnections"; }
    // {
    }
    // optionalAttrs (res."maxParallelRequests" != null) { inherit (res) "maxParallelRequests"; }
    // {
    }
    // optionalAttrs (res."maxParallelRetries" != null) { inherit (res) "maxParallelRetries"; }
    // {
    }
    // optionalAttrs (res."maxPendingRequests" != null) { inherit (res) "maxPendingRequests"; }
    // {
    }
    // optionalAttrs (res."maxRequestsPerConnection" != null) {
      inherit (res) "maxRequestsPerConnection";
    }
    // {
    }
    // optionalAttrs (res."perEndpoint" != null) {
      "perEndpoint" = mkExtProcBackendSettingsCircuitBreakerPerEndpoint res."perEndpoint";
    }
    // {
    };
  ExtProcBackendSettingsCircuitBreakerPerEndpointModule = types.submodule {
    options = {
      "maxConnections" = mkOption {
        description = "MaxConnections configures the maximum number of connections that Envoy will establish per-endpoint to the referenced backend defined within a xRoute rule.";
        type = (types.nullOr types.int);
        default = 1024;
      };
    };
  };
  mkExtProcBackendSettingsCircuitBreakerPerEndpoint =
    res:
    {
    }
    // optionalAttrs (res."maxConnections" != null) { inherit (res) "maxConnections"; }
    // {
    };
  ExtProcBackendSettingsConnectionModule = types.submodule {
    options = {
      "bufferLimit" = mkOption {
        description = "BufferLimit Soft limit on size of the cluster’s connections read and write buffers.\nBufferLimit applies to connection streaming (maybe non-streaming) channel between processes, it's in user space.\nIf unspecified, an implementation defined default is applied (32768 bytes).\nFor example, 20Mi, 1Gi, 256Ki etc.\nNote: that when the suffix is not provided, the value is interpreted as bytes.";
        type = types.anything;
        default = { };
      };
      "socketBufferLimit" = mkOption {
        description = "SocketBufferLimit provides configuration for the maximum buffer size in bytes for each socket\nto backend.\nSocketBufferLimit applies to socket streaming channel between TCP/IP stacks, it's in kernel space.\nFor example, 20Mi, 1Gi, 256Ki etc.\nNote that when the suffix is not provided, the value is interpreted as bytes.";
        type = types.anything;
        default = { };
      };
    };
  };
  mkExtProcBackendSettingsConnection =
    res:
    {
    }
    // optionalAttrs (res."bufferLimit" != null) { inherit (res) "bufferLimit"; }
    // {
    }
    // optionalAttrs (res."socketBufferLimit" != null) { inherit (res) "socketBufferLimit"; }
    // {
    };
  ExtProcBackendSettingsDnsModule = types.submodule {
    options = {
      "dnsRefreshRate" = mkOption {
        description = "DNSRefreshRate specifies the rate at which DNS records should be refreshed.\nDefaults to 30 seconds.";
        type = (types.nullOr types.str);
        default = null;
      };
      "lookupFamily" = mkOption {
        description = "LookupFamily determines how Envoy would resolve DNS for Routes where the backend is specified as a fully qualified domain name (FQDN).\nIf set, this configuration overrides other defaults.";
        type = (
          types.nullOr (
            types.enum [
              "IPv4"
              "IPv6"
              "IPv4Preferred"
              "IPv6Preferred"
              "IPv4AndIPv6"
            ]
          )
        );
        default = null;
      };
      "respectDnsTtl" = mkOption {
        description = "RespectDNSTTL indicates whether the DNS Time-To-Live (TTL) should be respected.\nIf the value is set to true, the DNS refresh rate will be set to the resource record’s TTL.\nDefaults to true.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkExtProcBackendSettingsDns =
    res:
    {
    }
    // optionalAttrs (res."dnsRefreshRate" != null) { inherit (res) "dnsRefreshRate"; }
    // {
    }
    // optionalAttrs (res."lookupFamily" != null) { inherit (res) "lookupFamily"; }
    // {
    }
    // optionalAttrs res."respectDnsTtl" { inherit (res) "respectDnsTtl"; }
    // {
    };
  ExtProcBackendSettingsHealthCheckActiveGrpcModule = types.submodule {
    options = {
      "service" = mkOption {
        description = "Service to send in the health check request.\nIf this is not specified, then the health check request applies to the entire\nserver and not to a specific service.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkExtProcBackendSettingsHealthCheckActiveGrpc =
    res:
    {
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  ExtProcBackendSettingsHealthCheckActiveHttpExpectedResponseModule = types.submodule {
    options = {
      "binary" = mkOption {
        description = "Binary payload base64 encoded.";
        type = (types.nullOr types.str);
        default = null;
      };
      "text" = mkOption {
        description = "Text payload in plain text.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Type defines the type of the payload.";
        type = types.str;
      };
    };
  };
  mkExtProcBackendSettingsHealthCheckActiveHttpExpectedResponse =
    res:
    {
    }
    // optionalAttrs (res."binary" != null) { inherit (res) "binary"; }
    // {
    }
    // optionalAttrs (res."text" != null) { inherit (res) "text"; }
    // {
      inherit (res) "type";
    };
  ExtProcBackendSettingsHealthCheckActiveHttpModule = types.submodule {
    options = {
      "expectedResponse" = mkOption {
        description = "ExpectedResponse defines a list of HTTP expected responses to match.";
        type = (types.nullOr ExtProcBackendSettingsHealthCheckActiveHttpExpectedResponseModule);
        default = null;
      };
      "expectedStatuses" = mkOption {
        description = "ExpectedStatuses defines a list of HTTP response statuses considered healthy.\nDefaults to 200 only";
        type = (types.listOf types.int);
        default = [ ];
      };
      "hostname" = mkOption {
        description = "Hostname defines the HTTP host that will be requested during health checking.\nDefault: HTTPRoute or GRPCRoute hostname.";
        type = (types.nullOr types.str);
        default = null;
      };
      "method" = mkOption {
        description = "Method defines the HTTP method used for health checking.\nDefaults to GET";
        type = (types.nullOr types.str);
        default = null;
      };
      "path" = mkOption {
        description = "Path defines the HTTP path that will be requested during health checking.";
        type = types.str;
      };
    };
  };
  mkExtProcBackendSettingsHealthCheckActiveHttp =
    res:
    {
    }
    // optionalAttrs (res."expectedResponse" != null) {
      "expectedResponse" =
        mkExtProcBackendSettingsHealthCheckActiveHttpExpectedResponse
          res."expectedResponse";
    }
    // {
    }
    // optionalAttrs (res."expectedStatuses" != [ ]) { inherit (res) "expectedStatuses"; }
    // {
    }
    // optionalAttrs (res."hostname" != null) { inherit (res) "hostname"; }
    // {
    }
    // optionalAttrs (res."method" != null) { inherit (res) "method"; }
    // {
      inherit (res) "path";
    };
  ExtProcBackendSettingsHealthCheckActiveModule = types.submodule {
    options = {
      "grpc" = mkOption {
        description = "GRPC defines the configuration of the GRPC health checker.\nIt's optional, and can only be used if the specified type is GRPC.";
        type = (types.nullOr ExtProcBackendSettingsHealthCheckActiveGrpcModule);
        default = null;
      };
      "healthyThreshold" = mkOption {
        description = "HealthyThreshold defines the number of healthy health checks required before a backend host is marked healthy.";
        type = (types.nullOr types.int);
        default = 1;
      };
      "http" = mkOption {
        description = "HTTP defines the configuration of http health checker.\nIt's required while the health checker type is HTTP.";
        type = (types.nullOr ExtProcBackendSettingsHealthCheckActiveHttpModule);
        default = null;
      };
      "initialJitter" = mkOption {
        description = "InitialJitter defines the maximum time Envoy will wait before the first health check.\nEnvoy will randomly select a value between 0 and the initial jitter value.";
        type = (types.nullOr types.str);
        default = null;
      };
      "interval" = mkOption {
        description = "Interval defines the time between active health checks.";
        type = (types.nullOr types.str);
        default = "3s";
      };
      "tcp" = mkOption {
        description = "TCP defines the configuration of tcp health checker.\nIt's required while the health checker type is TCP.";
        type = (types.nullOr ExtProcBackendSettingsHealthCheckActiveTcpModule);
        default = null;
      };
      "timeout" = mkOption {
        description = "Timeout defines the time to wait for a health check response.";
        type = (types.nullOr types.str);
        default = "1s";
      };
      "type" = mkOption {
        description = "Type defines the type of health checker.";
        type = types.str;
      };
      "unhealthyThreshold" = mkOption {
        description = "UnhealthyThreshold defines the number of unhealthy health checks required before a backend host is marked unhealthy.";
        type = (types.nullOr types.int);
        default = 3;
      };
    };
  };
  mkExtProcBackendSettingsHealthCheckActive =
    res:
    {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkExtProcBackendSettingsHealthCheckActiveGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."healthyThreshold" != null) { inherit (res) "healthyThreshold"; }
    // {
    }
    // optionalAttrs (res."http" != null) {
      "http" = mkExtProcBackendSettingsHealthCheckActiveHttp res."http";
    }
    // {
    }
    // optionalAttrs (res."initialJitter" != null) { inherit (res) "initialJitter"; }
    // {
    }
    // optionalAttrs (res."interval" != null) { inherit (res) "interval"; }
    // {
    }
    // optionalAttrs (res."tcp" != null) {
      "tcp" = mkExtProcBackendSettingsHealthCheckActiveTcp res."tcp";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."unhealthyThreshold" != null) { inherit (res) "unhealthyThreshold"; }
    // {
    };
  ExtProcBackendSettingsHealthCheckActiveTcpModule = types.submodule {
    options = {
      "receive" = mkOption {
        description = "Receive defines the expected response payload.";
        type = (types.nullOr ExtProcBackendSettingsHealthCheckActiveTcpReceiveModule);
        default = null;
      };
      "send" = mkOption {
        description = "Send defines the request payload.";
        type = (types.nullOr ExtProcBackendSettingsHealthCheckActiveTcpSendModule);
        default = null;
      };
    };
  };
  mkExtProcBackendSettingsHealthCheckActiveTcp =
    res:
    {
    }
    // optionalAttrs (res."receive" != null) {
      "receive" = mkExtProcBackendSettingsHealthCheckActiveTcpReceive res."receive";
    }
    // {
    }
    // optionalAttrs (res."send" != null) {
      "send" = mkExtProcBackendSettingsHealthCheckActiveTcpSend res."send";
    }
    // {
    };
  ExtProcBackendSettingsHealthCheckActiveTcpReceiveModule = types.submodule {
    options = {
      "binary" = mkOption {
        description = "Binary payload base64 encoded.";
        type = (types.nullOr types.str);
        default = null;
      };
      "text" = mkOption {
        description = "Text payload in plain text.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Type defines the type of the payload.";
        type = types.str;
      };
    };
  };
  mkExtProcBackendSettingsHealthCheckActiveTcpReceive =
    res:
    {
    }
    // optionalAttrs (res."binary" != null) { inherit (res) "binary"; }
    // {
    }
    // optionalAttrs (res."text" != null) { inherit (res) "text"; }
    // {
      inherit (res) "type";
    };
  ExtProcBackendSettingsHealthCheckActiveTcpSendModule = types.submodule {
    options = {
      "binary" = mkOption {
        description = "Binary payload base64 encoded.";
        type = (types.nullOr types.str);
        default = null;
      };
      "text" = mkOption {
        description = "Text payload in plain text.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Type defines the type of the payload.";
        type = types.str;
      };
    };
  };
  mkExtProcBackendSettingsHealthCheckActiveTcpSend =
    res:
    {
    }
    // optionalAttrs (res."binary" != null) { inherit (res) "binary"; }
    // {
    }
    // optionalAttrs (res."text" != null) { inherit (res) "text"; }
    // {
      inherit (res) "type";
    };
  ExtProcBackendSettingsHealthCheckModule = types.submodule {
    options = {
      "active" = mkOption {
        description = "Active health check configuration";
        type = (types.nullOr ExtProcBackendSettingsHealthCheckActiveModule);
        default = null;
      };
      "panicThreshold" = mkOption {
        description = "When number of unhealthy endpoints for a backend reaches this threshold\nEnvoy will disregard health status and balance across all endpoints.\nIt's designed to prevent a situation in which host failures cascade throughout the cluster\nas load increases. If not set, the default value is 50%. To disable panic mode, set value to `0`.";
        type = (types.nullOr types.int);
        default = null;
      };
      "passive" = mkOption {
        description = "Passive passive check configuration";
        type = (types.nullOr ExtProcBackendSettingsHealthCheckPassiveModule);
        default = null;
      };
    };
  };
  mkExtProcBackendSettingsHealthCheck =
    res:
    {
    }
    // optionalAttrs (res."active" != null) {
      "active" = mkExtProcBackendSettingsHealthCheckActive res."active";
    }
    // {
    }
    // optionalAttrs (res."panicThreshold" != null) { inherit (res) "panicThreshold"; }
    // {
    }
    // optionalAttrs (res."passive" != null) {
      "passive" = mkExtProcBackendSettingsHealthCheckPassive res."passive";
    }
    // {
    };
  ExtProcBackendSettingsHealthCheckPassiveModule = types.submodule {
    options = {
      "baseEjectionTime" = mkOption {
        description = "BaseEjectionTime defines the base duration for which a host will be ejected on consecutive failures.";
        type = (types.nullOr types.str);
        default = "30s";
      };
      "consecutive5XxErrors" = mkOption {
        description = "Consecutive5xxErrors sets the number of consecutive 5xx errors triggering ejection.";
        type = (types.nullOr types.int);
        default = 5;
      };
      "consecutiveGatewayErrors" = mkOption {
        description = "ConsecutiveGatewayErrors sets the number of consecutive gateway errors triggering ejection.";
        type = (types.nullOr types.int);
        default = 0;
      };
      "consecutiveLocalOriginFailures" = mkOption {
        description = "ConsecutiveLocalOriginFailures sets the number of consecutive local origin failures triggering ejection.\nParameter takes effect only when split_external_local_origin_errors is set to true.";
        type = (types.nullOr types.int);
        default = 5;
      };
      "interval" = mkOption {
        description = "Interval defines the time between passive health checks.";
        type = (types.nullOr types.str);
        default = "3s";
      };
      "maxEjectionPercent" = mkOption {
        description = "MaxEjectionPercent sets the maximum percentage of hosts in a cluster that can be ejected.";
        type = (types.nullOr types.int);
        default = 10;
      };
      "splitExternalLocalOriginErrors" = mkOption {
        description = "SplitExternalLocalOriginErrors enables splitting of errors between external and local origin.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkExtProcBackendSettingsHealthCheckPassive =
    res:
    {
    }
    // optionalAttrs (res."baseEjectionTime" != null) { inherit (res) "baseEjectionTime"; }
    // {
    }
    // optionalAttrs (res."consecutive5XxErrors" != null) { inherit (res) "consecutive5XxErrors"; }
    // {
    }
    // optionalAttrs (res."consecutiveGatewayErrors" != null) {
      inherit (res) "consecutiveGatewayErrors";
    }
    // {
    }
    // optionalAttrs (res."consecutiveLocalOriginFailures" != null) {
      inherit (res) "consecutiveLocalOriginFailures";
    }
    // {
    }
    // optionalAttrs (res."interval" != null) { inherit (res) "interval"; }
    // {
    }
    // optionalAttrs (res."maxEjectionPercent" != null) { inherit (res) "maxEjectionPercent"; }
    // {
    }
    // optionalAttrs res."splitExternalLocalOriginErrors" {
      inherit (res) "splitExternalLocalOriginErrors";
    }
    // {
    };
  ExtProcBackendSettingsHttp2Module = types.submodule {
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
  mkExtProcBackendSettingsHttp2 =
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
  ExtProcBackendSettingsLoadBalancerConsistentHashCookieModule = types.submodule {
    options = {
      "attributes" = mkOption {
        description = "Additional Attributes to set for the generated cookie.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "name" = mkOption {
        description = "Name of the cookie to hash.\nIf this cookie does not exist in the request, Envoy will generate a cookie and set\nthe TTL on the response back to the client based on Layer 4\nattributes of the backend endpoint, to ensure that these future requests\ngo to the same backend endpoint. Make sure to set the TTL field for this case.";
        type = types.str;
      };
      "ttl" = mkOption {
        description = "TTL of the generated cookie if the cookie is not present. This value sets the\nMax-Age attribute value.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkExtProcBackendSettingsLoadBalancerConsistentHashCookie =
    res:
    {
    }
    // optionalAttrs (res."attributes" != { }) { inherit (res) "attributes"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."ttl" != null) { inherit (res) "ttl"; }
    // {
    };
  ExtProcBackendSettingsLoadBalancerConsistentHashHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the header to hash.";
        type = types.str;
      };
    };
  };
  mkExtProcBackendSettingsLoadBalancerConsistentHashHeader = res: {
    inherit (res) "name";
  };
  ExtProcBackendSettingsLoadBalancerConsistentHashModule = types.submodule {
    options = {
      "cookie" = mkOption {
        description = "Cookie configures the cookie hash policy when the consistent hash type is set to Cookie.";
        type = (types.nullOr ExtProcBackendSettingsLoadBalancerConsistentHashCookieModule);
        default = null;
      };
      "header" = mkOption {
        description = "Header configures the header hash policy when the consistent hash type is set to Header.";
        type = (types.nullOr ExtProcBackendSettingsLoadBalancerConsistentHashHeaderModule);
        default = null;
      };
      "tableSize" = mkOption {
        description = "The table size for consistent hashing, must be prime number limited to 5000011.";
        type = (types.nullOr types.int);
        default = 65537;
      };
      "type" = mkOption {
        description = "ConsistentHashType defines the type of input to hash on. Valid Type values are\n\"SourceIP\",\n\"Header\",\n\"Cookie\".";
        type = (
          types.enum [
            "SourceIP"
            "Header"
            "Cookie"
          ]
        );
      };
    };
  };
  mkExtProcBackendSettingsLoadBalancerConsistentHash =
    res:
    {
    }
    // optionalAttrs (res."cookie" != null) {
      "cookie" = mkExtProcBackendSettingsLoadBalancerConsistentHashCookie res."cookie";
    }
    // {
    }
    // optionalAttrs (res."header" != null) {
      "header" = mkExtProcBackendSettingsLoadBalancerConsistentHashHeader res."header";
    }
    // {
    }
    // optionalAttrs (res."tableSize" != null) { inherit (res) "tableSize"; }
    // {
      inherit (res) "type";
    };
  ExtProcBackendSettingsLoadBalancerEndpointOverrideExtractFromModule = types.submodule {
    options = {
      "header" = mkOption {
        description = "Header defines the header to get the override endpoint addresses.\nThe header value must specify at least one endpoint in `IP:Port` format or multiple endpoints in `IP:Port,IP:Port,...` format.\nFor example `10.0.0.5:8080` or `[2600:4040:5204::1574:24ae]:80`.\nThe IPv6 address is enclosed in square brackets.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkExtProcBackendSettingsLoadBalancerEndpointOverrideExtractFrom =
    res:
    {
    }
    // optionalAttrs (res."header" != null) { inherit (res) "header"; }
    // {
    };
  ExtProcBackendSettingsLoadBalancerEndpointOverrideModule = types.submodule {
    options = {
      "extractFrom" = mkOption {
        description = "ExtractFrom defines the sources to extract endpoint override information from.";
        type = (types.listOf ExtProcBackendSettingsLoadBalancerEndpointOverrideExtractFromModule);
      };
    };
  };
  mkExtProcBackendSettingsLoadBalancerEndpointOverride = res: {
    "extractFrom" =
      map mkExtProcBackendSettingsLoadBalancerEndpointOverrideExtractFrom
        res."extractFrom";
  };
  ExtProcBackendSettingsLoadBalancerModule = types.submodule {
    options = {
      "consistentHash" = mkOption {
        description = "ConsistentHash defines the configuration when the load balancer type is\nset to ConsistentHash";
        type = (types.nullOr ExtProcBackendSettingsLoadBalancerConsistentHashModule);
        default = null;
      };
      "endpointOverride" = mkOption {
        description = "EndpointOverride defines the configuration for endpoint override.\nWhen specified, the load balancer will attempt to route requests to endpoints\nbased on the override information extracted from request headers or metadata.\n If the override endpoints are not available, the configured load balancer policy will be used as fallback.";
        type = (types.nullOr ExtProcBackendSettingsLoadBalancerEndpointOverrideModule);
        default = null;
      };
      "slowStart" = mkOption {
        description = "SlowStart defines the configuration related to the slow start load balancer policy.\nIf set, during slow start window, traffic sent to the newly added hosts will gradually increase.\nCurrently this is only supported for RoundRobin and LeastRequest load balancers";
        type = (types.nullOr ExtProcBackendSettingsLoadBalancerSlowStartModule);
        default = null;
      };
      "type" = mkOption {
        description = "Type decides the type of Load Balancer policy.\nValid LoadBalancerType values are\n\"ConsistentHash\",\n\"LeastRequest\",\n\"Random\",\n\"RoundRobin\".";
        type = (
          types.enum [
            "ConsistentHash"
            "LeastRequest"
            "Random"
            "RoundRobin"
          ]
        );
      };
      "zoneAware" = mkOption {
        description = "ZoneAware defines the configuration related to the distribution of requests between locality zones.";
        type = (types.nullOr ExtProcBackendSettingsLoadBalancerZoneAwareModule);
        default = null;
      };
    };
  };
  mkExtProcBackendSettingsLoadBalancer =
    res:
    {
    }
    // optionalAttrs (res."consistentHash" != null) {
      "consistentHash" = mkExtProcBackendSettingsLoadBalancerConsistentHash res."consistentHash";
    }
    // {
    }
    // optionalAttrs (res."endpointOverride" != null) {
      "endpointOverride" = mkExtProcBackendSettingsLoadBalancerEndpointOverride res."endpointOverride";
    }
    // {
    }
    // optionalAttrs (res."slowStart" != null) {
      "slowStart" = mkExtProcBackendSettingsLoadBalancerSlowStart res."slowStart";
    }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."zoneAware" != null) {
      "zoneAware" = mkExtProcBackendSettingsLoadBalancerZoneAware res."zoneAware";
    }
    // {
    };
  ExtProcBackendSettingsLoadBalancerSlowStartModule = types.submodule {
    options = {
      "window" = mkOption {
        description = "Window defines the duration of the warm up period for newly added host.\nDuring slow start window, traffic sent to the newly added hosts will gradually increase.\nCurrently only supports linear growth of traffic. For additional details,\nsee https://www.envoyproxy.io/docs/envoy/latest/api-v3/config/cluster/v3/cluster.proto#config-cluster-v3-cluster-slowstartconfig";
        type = types.str;
      };
    };
  };
  mkExtProcBackendSettingsLoadBalancerSlowStart = res: {
    inherit (res) "window";
  };
  ExtProcBackendSettingsLoadBalancerZoneAwareModule = types.submodule {
    options = {
      "preferLocal" = mkOption {
        description = "PreferLocalZone configures zone-aware routing to prefer sending traffic to the local locality zone.";
        type = (types.nullOr ExtProcBackendSettingsLoadBalancerZoneAwarePreferLocalModule);
        default = null;
      };
    };
  };
  mkExtProcBackendSettingsLoadBalancerZoneAware =
    res:
    {
    }
    // optionalAttrs (res."preferLocal" != null) {
      "preferLocal" = mkExtProcBackendSettingsLoadBalancerZoneAwarePreferLocal res."preferLocal";
    }
    // {
    };
  ExtProcBackendSettingsLoadBalancerZoneAwarePreferLocalForceModule = types.submodule {
    options = {
      "minEndpointsInZoneThreshold" = mkOption {
        description = "MinEndpointsInZoneThreshold is the minimum number of upstream endpoints in the local zone required to honor the forceLocalZone\noverride. This is useful for protecting zones with fewer endpoints.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkExtProcBackendSettingsLoadBalancerZoneAwarePreferLocalForce =
    res:
    {
    }
    // optionalAttrs (res."minEndpointsInZoneThreshold" != null) {
      inherit (res) "minEndpointsInZoneThreshold";
    }
    // {
    };
  ExtProcBackendSettingsLoadBalancerZoneAwarePreferLocalModule = types.submodule {
    options = {
      "force" = mkOption {
        description = "ForceLocalZone defines override configuration for forcing all traffic to stay within the local zone instead of the default behavior\nwhich maintains equal distribution among upstream endpoints while sending as much traffic as possible locally.";
        type = (types.nullOr ExtProcBackendSettingsLoadBalancerZoneAwarePreferLocalForceModule);
        default = null;
      };
      "minEndpointsThreshold" = mkOption {
        description = "MinEndpointsThreshold is the minimum number of total upstream endpoints across all zones required to enable zone-aware routing.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkExtProcBackendSettingsLoadBalancerZoneAwarePreferLocal =
    res:
    {
    }
    // optionalAttrs (res."force" != null) {
      "force" = mkExtProcBackendSettingsLoadBalancerZoneAwarePreferLocalForce res."force";
    }
    // {
    }
    // optionalAttrs (res."minEndpointsThreshold" != null) { inherit (res) "minEndpointsThreshold"; }
    // {
    };
  ExtProcBackendSettingsModule = types.submodule {
    options = {
      "circuitBreaker" = mkOption {
        description = "Circuit Breaker settings for the upstream connections and requests.\nIf not set, circuit breakers will be enabled with the default thresholds";
        type = (types.nullOr ExtProcBackendSettingsCircuitBreakerModule);
        default = null;
      };
      "connection" = mkOption {
        description = "Connection includes backend connection settings.";
        type = (types.nullOr ExtProcBackendSettingsConnectionModule);
        default = null;
      };
      "dns" = mkOption {
        description = "DNS includes dns resolution settings.";
        type = (types.nullOr ExtProcBackendSettingsDnsModule);
        default = null;
      };
      "healthCheck" = mkOption {
        description = "HealthCheck allows gateway to perform active health checking on backends.";
        type = (types.nullOr ExtProcBackendSettingsHealthCheckModule);
        default = null;
      };
      "http2" = mkOption {
        description = "HTTP2 provides HTTP/2 configuration for backend connections.";
        type = (types.nullOr ExtProcBackendSettingsHttp2Module);
        default = null;
      };
      "loadBalancer" = mkOption {
        description = "LoadBalancer policy to apply when routing traffic from the gateway to\nthe backend endpoints. Defaults to `LeastRequest`.";
        type = (types.nullOr ExtProcBackendSettingsLoadBalancerModule);
        default = null;
      };
      "proxyProtocol" = mkOption {
        description = "ProxyProtocol enables the Proxy Protocol when communicating with the backend.";
        type = (types.nullOr ExtProcBackendSettingsProxyProtocolModule);
        default = null;
      };
      "retry" = mkOption {
        description = "Retry provides more advanced usage, allowing users to customize the number of retries, retry fallback strategy, and retry triggering conditions.\nIf not set, retry will be disabled.";
        type = (types.nullOr ExtProcBackendSettingsRetryModule);
        default = null;
      };
      "tcpKeepalive" = mkOption {
        description = "TcpKeepalive settings associated with the upstream client connection.\nDisabled by default.";
        type = (types.nullOr ExtProcBackendSettingsTcpKeepaliveModule);
        default = null;
      };
      "timeout" = mkOption {
        description = "Timeout settings for the backend connections.";
        type = (types.nullOr ExtProcBackendSettingsTimeoutModule);
        default = null;
      };
    };
  };
  mkExtProcBackendSettings =
    res:
    {
    }
    // optionalAttrs (res."circuitBreaker" != null) {
      "circuitBreaker" = mkExtProcBackendSettingsCircuitBreaker res."circuitBreaker";
    }
    // {
    }
    // optionalAttrs (res."connection" != null) {
      "connection" = mkExtProcBackendSettingsConnection res."connection";
    }
    // {
    }
    // optionalAttrs (res."dns" != null) { "dns" = mkExtProcBackendSettingsDns res."dns"; }
    // {
    }
    // optionalAttrs (res."healthCheck" != null) {
      "healthCheck" = mkExtProcBackendSettingsHealthCheck res."healthCheck";
    }
    // {
    }
    // optionalAttrs (res."http2" != null) { "http2" = mkExtProcBackendSettingsHttp2 res."http2"; }
    // {
    }
    // optionalAttrs (res."loadBalancer" != null) {
      "loadBalancer" = mkExtProcBackendSettingsLoadBalancer res."loadBalancer";
    }
    // {
    }
    // optionalAttrs (res."proxyProtocol" != null) {
      "proxyProtocol" = mkExtProcBackendSettingsProxyProtocol res."proxyProtocol";
    }
    // {
    }
    // optionalAttrs (res."retry" != null) { "retry" = mkExtProcBackendSettingsRetry res."retry"; }
    // {
    }
    // optionalAttrs (res."tcpKeepalive" != null) {
      "tcpKeepalive" = mkExtProcBackendSettingsTcpKeepalive res."tcpKeepalive";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) {
      "timeout" = mkExtProcBackendSettingsTimeout res."timeout";
    }
    // {
    };
  ExtProcBackendSettingsProxyProtocolModule = types.submodule {
    options = {
      "version" = mkOption {
        description = "Version of ProxyProtol\nValid ProxyProtocolVersion values are\n\"V1\"\n\"V2\"";
        type = (
          types.enum [
            "V1"
            "V2"
          ]
        );
      };
    };
  };
  mkExtProcBackendSettingsProxyProtocol = res: {
    inherit (res) "version";
  };
  ExtProcBackendSettingsRetryModule = types.submodule {
    options = {
      "numAttemptsPerPriority" = mkOption {
        description = "NumAttemptsPerPriority defines the number of requests (initial attempt + retries)\nthat should be sent to the same priority before switching to a different one.\nIf not specified or set to 0, all requests are sent to the highest priority that is healthy.";
        type = (types.nullOr types.int);
        default = null;
      };
      "numRetries" = mkOption {
        description = "NumRetries is the number of retries to be attempted. Defaults to 2.";
        type = (types.nullOr types.int);
        default = 2;
      };
      "perRetry" = mkOption {
        description = "PerRetry is the retry policy to be applied per retry attempt.";
        type = (types.nullOr ExtProcBackendSettingsRetryPerRetryModule);
        default = null;
      };
      "retryOn" = mkOption {
        description = "RetryOn specifies the retry trigger condition.\n\nIf not specified, the default is to retry on connect-failure,refused-stream,unavailable,cancelled,retriable-status-codes(503).";
        type = (types.nullOr ExtProcBackendSettingsRetryRetryOnModule);
        default = null;
      };
    };
  };
  mkExtProcBackendSettingsRetry =
    res:
    {
    }
    // optionalAttrs (res."numAttemptsPerPriority" != null) { inherit (res) "numAttemptsPerPriority"; }
    // {
    }
    // optionalAttrs (res."numRetries" != null) { inherit (res) "numRetries"; }
    // {
    }
    // optionalAttrs (res."perRetry" != null) {
      "perRetry" = mkExtProcBackendSettingsRetryPerRetry res."perRetry";
    }
    // {
    }
    // optionalAttrs (res."retryOn" != null) {
      "retryOn" = mkExtProcBackendSettingsRetryRetryOn res."retryOn";
    }
    // {
    };
  ExtProcBackendSettingsRetryPerRetryBackOffModule = types.submodule {
    options = {
      "baseInterval" = mkOption {
        description = "BaseInterval is the base interval between retries.";
        type = (types.nullOr types.str);
        default = null;
      };
      "maxInterval" = mkOption {
        description = "MaxInterval is the maximum interval between retries. This parameter is optional, but must be greater than or equal to the base_interval if set.\nThe default is 10 times the base_interval";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkExtProcBackendSettingsRetryPerRetryBackOff =
    res:
    {
    }
    // optionalAttrs (res."baseInterval" != null) { inherit (res) "baseInterval"; }
    // {
    }
    // optionalAttrs (res."maxInterval" != null) { inherit (res) "maxInterval"; }
    // {
    };
  ExtProcBackendSettingsRetryPerRetryModule = types.submodule {
    options = {
      "backOff" = mkOption {
        description = "Backoff is the backoff policy to be applied per retry attempt. gateway uses a fully jittered exponential\nback-off algorithm for retries. For additional details,\nsee https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/router_filter#config-http-filters-router-x-envoy-max-retries";
        type = (types.nullOr ExtProcBackendSettingsRetryPerRetryBackOffModule);
        default = null;
      };
      "timeout" = mkOption {
        description = "Timeout is the timeout per retry attempt.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkExtProcBackendSettingsRetryPerRetry =
    res:
    {
    }
    // optionalAttrs (res."backOff" != null) {
      "backOff" = mkExtProcBackendSettingsRetryPerRetryBackOff res."backOff";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    };
  ExtProcBackendSettingsRetryRetryOnModule = types.submodule {
    options = {
      "httpStatusCodes" = mkOption {
        description = "HttpStatusCodes specifies the http status codes to be retried.\nThe retriable-status-codes trigger must also be configured for these status codes to trigger a retry.";
        type = (types.listOf types.int);
        default = [ ];
      };
      "triggers" = mkOption {
        description = "Triggers specifies the retry trigger condition(Http/Grpc).";
        type = (
          types.listOf (
            types.enum [
              "5xx"
              "gateway-error"
              "reset"
              "reset-before-request"
              "connect-failure"
              "retriable-4xx"
              "refused-stream"
              "retriable-status-codes"
              "cancelled"
              "deadline-exceeded"
              "internal"
              "resource-exhausted"
              "unavailable"
            ]
          )
        );
        default = [ ];
      };
    };
  };
  mkExtProcBackendSettingsRetryRetryOn =
    res:
    {
    }
    // optionalAttrs (res."httpStatusCodes" != [ ]) { inherit (res) "httpStatusCodes"; }
    // {
    }
    // optionalAttrs (res."triggers" != [ ]) { inherit (res) "triggers"; }
    // {
    };
  ExtProcBackendSettingsTcpKeepaliveModule = types.submodule {
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
  mkExtProcBackendSettingsTcpKeepalive =
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
  ExtProcBackendSettingsTimeoutHttpModule = types.submodule {
    options = {
      "connectionIdleTimeout" = mkOption {
        description = "The idle timeout for an HTTP connection. Idle time is defined as a period in which there are no active requests in the connection.\nDefault: 1 hour.";
        type = (types.nullOr types.str);
        default = null;
      };
      "maxConnectionDuration" = mkOption {
        description = "The maximum duration of an HTTP connection.\nDefault: unlimited.";
        type = (types.nullOr types.str);
        default = null;
      };
      "requestTimeout" = mkOption {
        description = "RequestTimeout is the time until which entire response is received from the upstream.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkExtProcBackendSettingsTimeoutHttp =
    res:
    {
    }
    // optionalAttrs (res."connectionIdleTimeout" != null) { inherit (res) "connectionIdleTimeout"; }
    // {
    }
    // optionalAttrs (res."maxConnectionDuration" != null) { inherit (res) "maxConnectionDuration"; }
    // {
    }
    // optionalAttrs (res."requestTimeout" != null) { inherit (res) "requestTimeout"; }
    // {
    };
  ExtProcBackendSettingsTimeoutModule = types.submodule {
    options = {
      "http" = mkOption {
        description = "Timeout settings for HTTP.";
        type = (types.nullOr ExtProcBackendSettingsTimeoutHttpModule);
        default = null;
      };
      "tcp" = mkOption {
        description = "Timeout settings for TCP.";
        type = (types.nullOr ExtProcBackendSettingsTimeoutTcpModule);
        default = null;
      };
    };
  };
  mkExtProcBackendSettingsTimeout =
    res:
    {
    }
    // optionalAttrs (res."http" != null) { "http" = mkExtProcBackendSettingsTimeoutHttp res."http"; }
    // {
    }
    // optionalAttrs (res."tcp" != null) { "tcp" = mkExtProcBackendSettingsTimeoutTcp res."tcp"; }
    // {
    };
  ExtProcBackendSettingsTimeoutTcpModule = types.submodule {
    options = {
      "connectTimeout" = mkOption {
        description = "The timeout for network connection establishment, including TCP and TLS handshakes.\nDefault: 10 seconds.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkExtProcBackendSettingsTimeoutTcp =
    res:
    {
    }
    // optionalAttrs (res."connectTimeout" != null) { inherit (res) "connectTimeout"; }
    // {
    };
  ExtProcMetadataModule = types.submodule {
    options = {
      "accessibleNamespaces" = mkOption {
        description = "AccessibleNamespaces are metadata namespaces that are sent to the external processor as context";
        type = (types.listOf types.str);
        default = [ ];
      };
      "writableNamespaces" = mkOption {
        description = "WritableNamespaces are metadata namespaces that the external processor can write to";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkExtProcMetadata =
    res:
    {
    }
    // optionalAttrs (res."accessibleNamespaces" != [ ]) { inherit (res) "accessibleNamespaces"; }
    // {
    }
    // optionalAttrs (res."writableNamespaces" != [ ]) { inherit (res) "writableNamespaces"; }
    // {
    };
  ExtProcModule = types.submodule {
    options = {
      "backendRef" = mkOption {
        description = "BackendRef references a Kubernetes object that represents the\nbackend server to which the authorization request will be sent.\n\nDeprecated: Use BackendRefs instead.";
        type = (types.nullOr ExtProcBackendRefModule);
        default = null;
      };
      "backendRefs" = mkOption {
        description = "BackendRefs references a Kubernetes object that represents the\nbackend server to which the authorization request will be sent.";
        type = (types.listOf ExtProcBackendRefModule);
        default = [ ];
      };
      "backendSettings" = mkOption {
        description = "BackendSettings holds configuration for managing the connection\nto the backend.";
        type = (types.nullOr ExtProcBackendSettingsModule);
        default = null;
      };
      "failOpen" = mkOption {
        description = "FailOpen is a switch used to control the behavior when failing to call the external processor.\n\nIf FailOpen is set to true, the system bypasses the ExtProc extension and\nallows the traffic to pass through. If it is set to false or\nnot set (defaulting to false), the system blocks the traffic and returns\nan HTTP 5xx error.\n\nIf set to true, the ExtProc extension will also be bypassed if the configuration is invalid.";
        type = types.bool;
        default = false;
      };
      "messageTimeout" = mkOption {
        description = "MessageTimeout is the timeout for a response to be returned from the external processor\nDefault: 200ms";
        type = (types.nullOr types.str);
        default = null;
      };
      "metadata" = mkOption {
        description = "Metadata defines options related to the sending and receiving of dynamic metadata.\nThese options define which metadata namespaces would be sent to the processor and which dynamic metadata\nnamespaces the processor would be permitted to emit metadata to.\nUsers can specify custom namespaces or well-known envoy metadata namespace (such as envoy.filters.http.ext_authz)\ndocumented here: https://www.envoyproxy.io/docs/envoy/latest/configuration/advanced/well_known_dynamic_metadata#well-known-dynamic-metadata\nDefault: no metadata context is sent or received from the external processor";
        type = (types.nullOr ExtProcMetadataModule);
        default = null;
      };
      "processingMode" = mkOption {
        description = "ProcessingMode defines how request and response body is processed\nDefault: header and body are not sent to the external processor";
        type = (types.nullOr ExtProcProcessingModeModule);
        default = null;
      };
    };
  };
  mkExtProc =
    res:
    {
    }
    // optionalAttrs (res."backendRef" != null) { "backendRef" = mkExtProcBackendRef res."backendRef"; }
    // {
    }
    // optionalAttrs (res."backendRefs" != [ ]) {
      "backendRefs" = map mkExtProcBackendRef res."backendRefs";
    }
    // {
    }
    // optionalAttrs (res."backendSettings" != null) {
      "backendSettings" = mkExtProcBackendSettings res."backendSettings";
    }
    // {
    }
    // optionalAttrs res."failOpen" { inherit (res) "failOpen"; }
    // {
    }
    // optionalAttrs (res."messageTimeout" != null) { inherit (res) "messageTimeout"; }
    // {
    }
    // optionalAttrs (res."metadata" != null) { "metadata" = mkExtProcMetadata res."metadata"; }
    // {
    }
    // optionalAttrs (res."processingMode" != null) {
      "processingMode" = mkExtProcProcessingMode res."processingMode";
    }
    // {
    };
  ExtProcProcessingModeModule = types.submodule {
    options = {
      "allowModeOverride" = mkOption {
        description = "AllowModeOverride allows the external processor to override the processing mode set via the\n`mode_override` field in the gRPC response message. This defaults to false.";
        type = types.bool;
        default = false;
      };
      "request" = mkOption {
        description = "Defines processing mode for requests. If present, request headers are sent. Request body is processed according\nto the specified mode.";
        type = (types.nullOr ExtProcProcessingModeRequestModule);
        default = null;
      };
      "response" = mkOption {
        description = "Defines processing mode for responses. If present, response headers are sent. Response body is processed according\nto the specified mode.";
        type = (types.nullOr ExtProcProcessingModeResponseModule);
        default = null;
      };
    };
  };
  mkExtProcProcessingMode =
    res:
    {
    }
    // optionalAttrs res."allowModeOverride" { inherit (res) "allowModeOverride"; }
    // {
    }
    // optionalAttrs (res."request" != null) {
      "request" = mkExtProcProcessingModeRequest res."request";
    }
    // {
    }
    // optionalAttrs (res."response" != null) {
      "response" = mkExtProcProcessingModeResponse res."response";
    }
    // {
    };
  ExtProcProcessingModeRequestModule = types.submodule {
    options = {
      "attributes" = mkOption {
        description = "Defines which attributes are sent to the external processor. Envoy Gateway currently\nsupports only the following attribute prefixes: connection, source, destination,\nrequest, response, upstream and xds.route.\nhttps://www.envoyproxy.io/docs/envoy/latest/intro/arch_overview/advanced/attributes";
        type = (types.listOf types.str);
        default = [ ];
      };
      "body" = mkOption {
        description = "Defines body processing mode";
        type = (
          types.nullOr (
            types.enum [
              "Streamed"
              "Buffered"
              "BufferedPartial"
              "FullDuplexStreamed"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkExtProcProcessingModeRequest =
    res:
    {
    }
    // optionalAttrs (res."attributes" != [ ]) { inherit (res) "attributes"; }
    // {
    }
    // optionalAttrs (res."body" != null) { inherit (res) "body"; }
    // {
    };
  ExtProcProcessingModeResponseModule = types.submodule {
    options = {
      "attributes" = mkOption {
        description = "Defines which attributes are sent to the external processor. Envoy Gateway currently\nsupports only the following attribute prefixes: connection, source, destination,\nrequest, response, upstream and xds.route.\nhttps://www.envoyproxy.io/docs/envoy/latest/intro/arch_overview/advanced/attributes";
        type = (types.listOf types.str);
        default = [ ];
      };
      "body" = mkOption {
        description = "Defines body processing mode";
        type = (
          types.nullOr (
            types.enum [
              "Streamed"
              "Buffered"
              "BufferedPartial"
              "FullDuplexStreamed"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkExtProcProcessingModeResponse =
    res:
    {
    }
    // optionalAttrs (res."attributes" != [ ]) { inherit (res) "attributes"; }
    // {
    }
    // optionalAttrs (res."body" != null) { inherit (res) "body"; }
    // {
    };
  LuaModule = types.submodule {
    options = {
      "inline" = mkOption {
        description = "Inline contains the source code as an inline string.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Type is the type of method to use to read the Lua value.\nValid values are Inline and ValueRef, default is Inline.";
        type = (
          types.enum [
            "Inline"
            "ValueRef"
          ]
        );
      };
      "valueRef" = mkOption {
        description = "ValueRef has the source code specified as a local object reference.\nOnly a reference to ConfigMap is supported.\nThe value of key `lua` in the ConfigMap will be used.\nIf the key is not found, the first value in the ConfigMap will be used.";
        type = (types.nullOr LuaValueRefModule);
        default = null;
      };
    };
  };
  mkLua =
    res:
    {
    }
    // optionalAttrs (res."inline" != null) { inherit (res) "inline"; }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."valueRef" != null) { "valueRef" = mkLuaValueRef res."valueRef"; }
    // {
    };
  LuaValueRefModule = types.submodule {
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
  mkLuaValueRef = res: {
    inherit (res) "group";
    inherit (res) "kind";
    inherit (res) "name";
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
  WasmCodeHttpModule = types.submodule {
    options = {
      "sha256" = mkOption {
        description = "SHA256 checksum that will be used to verify the Wasm code.\n\nIf not specified, Envoy Gateway will not verify the downloaded Wasm code.\nkubebuilder:validation:Pattern=`^[a-f0-9]{64}$`";
        type = (types.nullOr types.str);
        default = null;
      };
      "tls" = mkOption {
        description = "TLS configuration when connecting to the Wasm code source.";
        type = (types.nullOr WasmCodeHttpTlsModule);
        default = null;
      };
      "url" = mkOption {
        description = "URL is the URL containing the Wasm code.";
        type = types.str;
      };
    };
  };
  mkWasmCodeHttp =
    res:
    {
    }
    // optionalAttrs (res."sha256" != null) { inherit (res) "sha256"; }
    // {
    }
    // optionalAttrs (res."tls" != null) { "tls" = mkWasmCodeHttpTls res."tls"; }
    // {
      inherit (res) "url";
    };
  WasmCodeHttpTlsCaCertificateRefModule = types.submodule {
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
  mkWasmCodeHttpTlsCaCertificateRef =
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
  WasmCodeHttpTlsModule = types.submodule {
    options = {
      "caCertificateRef" = mkOption {
        description = "CACertificateRef contains a references to\nKubernetes objects that contain TLS certificates of\nthe Certificate Authorities that can be used\nas a trust anchor to validate the certificates presented by the Wasm code source.\n\nKubernetes ConfigMap and Kubernetes Secret are supported.\nNote: The ConfigMap or Secret must be in the same namespace as the EnvoyExtensionPolicy.";
        type = WasmCodeHttpTlsCaCertificateRefModule;
      };
    };
  };
  mkWasmCodeHttpTls = res: {
    "caCertificateRef" = mkWasmCodeHttpTlsCaCertificateRef res."caCertificateRef";
  };
  WasmCodeImageModule = types.submodule {
    options = {
      "pullSecretRef" = mkOption {
        description = "PullSecretRef is a reference to the secret containing the credentials to pull the image.\nOnly support Kubernetes Secret resource from the same namespace.";
        type = (types.nullOr WasmCodeImagePullSecretRefModule);
        default = null;
      };
      "sha256" = mkOption {
        description = "SHA256 checksum that will be used to verify the OCI image.\n\nIt must match the digest of the OCI image.\n\nIf not specified, Envoy Gateway will not verify the downloaded OCI image.\nkubebuilder:validation:Pattern=`^[a-f0-9]{64}$`";
        type = (types.nullOr types.str);
        default = null;
      };
      "tls" = mkOption {
        description = "TLS configuration when connecting to the Wasm code source.";
        type = (types.nullOr WasmCodeImageTlsModule);
        default = null;
      };
      "url" = mkOption {
        description = "URL is the URL of the OCI image.\nURL can be in the format of `registry/image:tag` or `registry/image@sha256:digest`.";
        type = types.str;
      };
    };
  };
  mkWasmCodeImage =
    res:
    {
    }
    // optionalAttrs (res."pullSecretRef" != null) {
      "pullSecretRef" = mkWasmCodeImagePullSecretRef res."pullSecretRef";
    }
    // {
    }
    // optionalAttrs (res."sha256" != null) { inherit (res) "sha256"; }
    // {
    }
    // optionalAttrs (res."tls" != null) { "tls" = mkWasmCodeImageTls res."tls"; }
    // {
      inherit (res) "url";
    };
  WasmCodeImagePullSecretRefModule = types.submodule {
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
  mkWasmCodeImagePullSecretRef =
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
  WasmCodeImageTlsCaCertificateRefModule = types.submodule {
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
  mkWasmCodeImageTlsCaCertificateRef =
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
  WasmCodeImageTlsModule = types.submodule {
    options = {
      "caCertificateRef" = mkOption {
        description = "CACertificateRef contains a references to\nKubernetes objects that contain TLS certificates of\nthe Certificate Authorities that can be used\nas a trust anchor to validate the certificates presented by the Wasm code source.\n\nKubernetes ConfigMap and Kubernetes Secret are supported.\nNote: The ConfigMap or Secret must be in the same namespace as the EnvoyExtensionPolicy.";
        type = WasmCodeImageTlsCaCertificateRefModule;
      };
    };
  };
  mkWasmCodeImageTls = res: {
    "caCertificateRef" = mkWasmCodeImageTlsCaCertificateRef res."caCertificateRef";
  };
  WasmCodeModule = types.submodule {
    options = {
      "http" = mkOption {
        description = "HTTP is the HTTP URL containing the Wasm code.\n\nNote that the HTTP server must be accessible from the Envoy proxy.";
        type = (types.nullOr WasmCodeHttpModule);
        default = null;
      };
      "image" = mkOption {
        description = "Image is the OCI image containing the Wasm code.\n\nNote that the image must be accessible from the Envoy Gateway.";
        type = (types.nullOr WasmCodeImageModule);
        default = null;
      };
      "pullPolicy" = mkOption {
        description = "PullPolicy is the policy to use when pulling the Wasm module by either the HTTP or Image source.\nThis field is only applicable when the SHA256 field is not set.\n\nIf not specified, the default policy is IfNotPresent except for OCI images whose tag is latest.\n\nNote: EG does not update the Wasm module every time an Envoy proxy requests\nthe Wasm module even if the pull policy is set to Always.\nIt only updates the Wasm module when the EnvoyExtension resource version changes.";
        type = (
          types.nullOr (
            types.enum [
              "IfNotPresent"
              "Always"
            ]
          )
        );
        default = null;
      };
      "type" = mkOption {
        description = "Type is the type of the source of the Wasm code.\nValid WasmCodeSourceType values are \"HTTP\" or \"Image\".";
        type = types.str;
      };
    };
  };
  mkWasmCode =
    res:
    {
    }
    // optionalAttrs (res."http" != null) { "http" = mkWasmCodeHttp res."http"; }
    // {
    }
    // optionalAttrs (res."image" != null) { "image" = mkWasmCodeImage res."image"; }
    // {
    }
    // optionalAttrs (res."pullPolicy" != null) { inherit (res) "pullPolicy"; }
    // {
      inherit (res) "type";
    };
  WasmEnvModule = types.submodule {
    options = {
      "hostKeys" = mkOption {
        description = "HostKeys is a list of keys for environment variables from the host envoy process\nthat should be passed into the Wasm VM. This is useful for passing secrets to to Wasm extensions.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkWasmEnv =
    res:
    {
    }
    // optionalAttrs (res."hostKeys" != [ ]) { inherit (res) "hostKeys"; }
    // {
    };
  WasmModule = types.submodule {
    options = {
      "code" = mkOption {
        description = "Code is the Wasm code for the extension.";
        type = WasmCodeModule;
      };
      "config" = mkOption {
        description = "Config is the configuration for the Wasm extension.\nThis configuration will be passed as a JSON string to the Wasm extension.";
        type = (types.nullOr types.anything);
        default = null;
      };
      "env" = mkOption {
        description = "Env configures the environment for the Wasm extension";
        type = (types.nullOr WasmEnvModule);
        default = null;
      };
      "failOpen" = mkOption {
        description = "FailOpen is a switch used to control the behavior when a fatal error occurs\nduring the initialization or the execution of the Wasm extension.\n\nIf FailOpen is set to true, the system bypasses the Wasm extension and\nallows the traffic to pass through. If it is set to false or\nnot set (defaulting to false), the system blocks the traffic and returns\nan HTTP 5xx error.\n\nIf set to true, the Wasm extension will also be bypassed if the configuration is invalid.";
        type = types.bool;
        default = false;
      };
      "name" = mkOption {
        description = "Name is a unique name for this Wasm extension. It is used to identify the\nWasm extension if multiple extensions are handled by the same vm_id and root_id.\nIt's also used for logging/debugging.\nIf not specified, EG will generate a unique name for the Wasm extension.";
        type = (types.nullOr types.str);
        default = null;
      };
      "rootID" = mkOption {
        description = "RootID is a unique ID for a set of extensions in a VM which will share a\nRootContext and Contexts if applicable (e.g., an Wasm HttpFilter and an Wasm AccessLog).\nIf left blank, all extensions with a blank root_id with the same vm_id will share Context(s).\n\nNote: RootID must match the root_id parameter used to register the Context in the Wasm code.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkWasm =
    res:
    {
      "code" = mkWasmCode res."code";
    }
    // optionalAttrs (res."config" != null) { inherit (res) "config"; }
    // {
    }
    // optionalAttrs (res."env" != null) { "env" = mkWasmEnv res."env"; }
    // {
    }
    // optionalAttrs res."failOpen" { inherit (res) "failOpen"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."rootID" != null) { inherit (res) "rootID"; }
    // {
    };
  EnvoyextensionpoliciesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this EnvoyExtensionPolicy resource.";
        };
        "extProc" = mkOption {
          description = "ExtProc is an ordered list of external processing filters\nthat should be added to the envoy filter chain";
          type = (types.listOf ExtProcModule);
          default = [ ];
        };
        "lua" = mkOption {
          description = "Lua is an ordered list of Lua filters\nthat should be added to the envoy filter chain";
          type = (types.listOf LuaModule);
          default = [ ];
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
        "wasm" = mkOption {
          description = "Wasm is a list of Wasm extensions to be loaded by the Gateway.\nOrder matters, as the extensions will be loaded in the order they are\ndefined in this list.";
          type = (types.listOf WasmModule);
          default = [ ];
        };
      };
    }
  );
  mkEnvoyExtensionPolicy = name: res: {
    apiVersion = "gateway.envoyproxy.io/v1alpha1";
    kind = "EnvoyExtensionPolicy";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."extProc" != [ ]) { "extProc" = map mkExtProc res."extProc"; }
    // {
    }
    // optionalAttrs (res."lua" != [ ]) { "lua" = map mkLua res."lua"; }
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
    // optionalAttrs (res."wasm" != [ ]) { "wasm" = map mkWasm res."wasm"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkEnvoyExtensionPolicy cfg."envoyextensionpolicies");
in
{
  options.openkrill.apps."envoy-gateway" = {
    "envoyextensionpolicies" = mkOption {
      type = types.attrsOf EnvoyextensionpoliciesModule;
      default = { };
      description = "EnvoyExtensionPolicy CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."envoy-gateway".content = allResources;
  };
}
