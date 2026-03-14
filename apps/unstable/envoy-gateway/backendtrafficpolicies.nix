# Auto-generated openkrill module fragment for envoy-gateway
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."envoy-gateway";
  compact = filterAttrs (_: v: v != null);
  CircuitBreakerModule = types.submodule {
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
        type = (types.nullOr CircuitBreakerPerEndpointModule);
        default = null;
      };
    };
  };
  mkCircuitBreaker =
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
      "perEndpoint" = mkCircuitBreakerPerEndpoint res."perEndpoint";
    }
    // {
    };
  CircuitBreakerPerEndpointModule = types.submodule {
    options = {
      "maxConnections" = mkOption {
        description = "MaxConnections configures the maximum number of connections that Envoy will establish per-endpoint to the referenced backend defined within a xRoute rule.";
        type = (types.nullOr types.int);
        default = 1024;
      };
    };
  };
  mkCircuitBreakerPerEndpoint =
    res:
    {
    }
    // optionalAttrs (res."maxConnections" != null) { inherit (res) "maxConnections"; }
    // {
    };
  CompressionModule = types.submodule {
    options = {
      "brotli" = mkOption {
        description = "The configuration for Brotli compressor.";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "gzip" = mkOption {
        description = "The configuration for GZIP compressor.";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "type" = mkOption {
        description = "CompressorType defines the compressor type to use for compression.";
        type = (
          types.enum [
            "Gzip"
            "Brotli"
          ]
        );
      };
    };
  };
  mkCompression =
    res:
    {
    }
    // optionalAttrs (res."brotli" != { }) { inherit (res) "brotli"; }
    // {
    }
    // optionalAttrs (res."gzip" != { }) { inherit (res) "gzip"; }
    // {
      inherit (res) "type";
    };
  ConnectionModule = types.submodule {
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
  mkConnection =
    res:
    {
    }
    // optionalAttrs (res."bufferLimit" != null) { inherit (res) "bufferLimit"; }
    // {
    }
    // optionalAttrs (res."socketBufferLimit" != null) { inherit (res) "socketBufferLimit"; }
    // {
    };
  DnsModule = types.submodule {
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
  mkDns =
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
  FaultInjectionAbortModule = types.submodule {
    options = {
      "grpcStatus" = mkOption {
        description = "GrpcStatus specifies the GRPC status code to be returned";
        type = (types.nullOr types.int);
        default = null;
      };
      "httpStatus" = mkOption {
        description = "StatusCode specifies the HTTP status code to be returned";
        type = (types.nullOr types.int);
        default = null;
      };
      "percentage" = mkOption {
        description = "Percentage specifies the percentage of requests to be aborted. Default 100%, if set 0, no requests will be aborted. Accuracy to 0.0001%.";
        type = (types.nullOr types.int);
        default = 100;
      };
    };
  };
  mkFaultInjectionAbort =
    res:
    {
    }
    // optionalAttrs (res."grpcStatus" != null) { inherit (res) "grpcStatus"; }
    // {
    }
    // optionalAttrs (res."httpStatus" != null) { inherit (res) "httpStatus"; }
    // {
    }
    // optionalAttrs (res."percentage" != null) { inherit (res) "percentage"; }
    // {
    };
  FaultInjectionDelayModule = types.submodule {
    options = {
      "fixedDelay" = mkOption {
        description = "FixedDelay specifies the fixed delay duration";
        type = types.str;
      };
      "percentage" = mkOption {
        description = "Percentage specifies the percentage of requests to be delayed. Default 100%, if set 0, no requests will be delayed. Accuracy to 0.0001%.";
        type = (types.nullOr types.int);
        default = 100;
      };
    };
  };
  mkFaultInjectionDelay =
    res:
    {
      inherit (res) "fixedDelay";
    }
    // optionalAttrs (res."percentage" != null) { inherit (res) "percentage"; }
    // {
    };
  FaultInjectionModule = types.submodule {
    options = {
      "abort" = mkOption {
        description = "If specified, the request will be aborted if it meets the configuration criteria.";
        type = (types.nullOr FaultInjectionAbortModule);
        default = null;
      };
      "delay" = mkOption {
        description = "If specified, a delay will be injected into the request.";
        type = (types.nullOr FaultInjectionDelayModule);
        default = null;
      };
    };
  };
  mkFaultInjection =
    res:
    {
    }
    // optionalAttrs (res."abort" != null) { "abort" = mkFaultInjectionAbort res."abort"; }
    // {
    }
    // optionalAttrs (res."delay" != null) { "delay" = mkFaultInjectionDelay res."delay"; }
    // {
    };
  HealthCheckActiveGrpcModule = types.submodule {
    options = {
      "service" = mkOption {
        description = "Service to send in the health check request.\nIf this is not specified, then the health check request applies to the entire\nserver and not to a specific service.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkHealthCheckActiveGrpc =
    res:
    {
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  HealthCheckActiveHttpExpectedResponseModule = types.submodule {
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
  mkHealthCheckActiveHttpExpectedResponse =
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
  HealthCheckActiveHttpModule = types.submodule {
    options = {
      "expectedResponse" = mkOption {
        description = "ExpectedResponse defines a list of HTTP expected responses to match.";
        type = (types.nullOr HealthCheckActiveHttpExpectedResponseModule);
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
  mkHealthCheckActiveHttp =
    res:
    {
    }
    // optionalAttrs (res."expectedResponse" != null) {
      "expectedResponse" = mkHealthCheckActiveHttpExpectedResponse res."expectedResponse";
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
  HealthCheckActiveModule = types.submodule {
    options = {
      "grpc" = mkOption {
        description = "GRPC defines the configuration of the GRPC health checker.\nIt's optional, and can only be used if the specified type is GRPC.";
        type = (types.nullOr HealthCheckActiveGrpcModule);
        default = null;
      };
      "healthyThreshold" = mkOption {
        description = "HealthyThreshold defines the number of healthy health checks required before a backend host is marked healthy.";
        type = (types.nullOr types.int);
        default = 1;
      };
      "http" = mkOption {
        description = "HTTP defines the configuration of http health checker.\nIt's required while the health checker type is HTTP.";
        type = (types.nullOr HealthCheckActiveHttpModule);
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
        type = (types.nullOr HealthCheckActiveTcpModule);
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
  mkHealthCheckActive =
    res:
    {
    }
    // optionalAttrs (res."grpc" != null) { "grpc" = mkHealthCheckActiveGrpc res."grpc"; }
    // {
    }
    // optionalAttrs (res."healthyThreshold" != null) { inherit (res) "healthyThreshold"; }
    // {
    }
    // optionalAttrs (res."http" != null) { "http" = mkHealthCheckActiveHttp res."http"; }
    // {
    }
    // optionalAttrs (res."initialJitter" != null) { inherit (res) "initialJitter"; }
    // {
    }
    // optionalAttrs (res."interval" != null) { inherit (res) "interval"; }
    // {
    }
    // optionalAttrs (res."tcp" != null) { "tcp" = mkHealthCheckActiveTcp res."tcp"; }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."unhealthyThreshold" != null) { inherit (res) "unhealthyThreshold"; }
    // {
    };
  HealthCheckActiveTcpModule = types.submodule {
    options = {
      "receive" = mkOption {
        description = "Receive defines the expected response payload.";
        type = (types.nullOr HealthCheckActiveTcpReceiveModule);
        default = null;
      };
      "send" = mkOption {
        description = "Send defines the request payload.";
        type = (types.nullOr HealthCheckActiveTcpSendModule);
        default = null;
      };
    };
  };
  mkHealthCheckActiveTcp =
    res:
    {
    }
    // optionalAttrs (res."receive" != null) {
      "receive" = mkHealthCheckActiveTcpReceive res."receive";
    }
    // {
    }
    // optionalAttrs (res."send" != null) { "send" = mkHealthCheckActiveTcpSend res."send"; }
    // {
    };
  HealthCheckActiveTcpReceiveModule = types.submodule {
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
  mkHealthCheckActiveTcpReceive =
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
  HealthCheckActiveTcpSendModule = types.submodule {
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
  mkHealthCheckActiveTcpSend =
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
  HealthCheckModule = types.submodule {
    options = {
      "active" = mkOption {
        description = "Active health check configuration";
        type = (types.nullOr HealthCheckActiveModule);
        default = null;
      };
      "panicThreshold" = mkOption {
        description = "When number of unhealthy endpoints for a backend reaches this threshold\nEnvoy will disregard health status and balance across all endpoints.\nIt's designed to prevent a situation in which host failures cascade throughout the cluster\nas load increases. If not set, the default value is 50%. To disable panic mode, set value to `0`.";
        type = (types.nullOr types.int);
        default = null;
      };
      "passive" = mkOption {
        description = "Passive passive check configuration";
        type = (types.nullOr HealthCheckPassiveModule);
        default = null;
      };
    };
  };
  mkHealthCheck =
    res:
    {
    }
    // optionalAttrs (res."active" != null) { "active" = mkHealthCheckActive res."active"; }
    // {
    }
    // optionalAttrs (res."panicThreshold" != null) { inherit (res) "panicThreshold"; }
    // {
    }
    // optionalAttrs (res."passive" != null) { "passive" = mkHealthCheckPassive res."passive"; }
    // {
    };
  HealthCheckPassiveModule = types.submodule {
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
  mkHealthCheckPassive =
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
  HttpUpgradeConnectModule = types.submodule {
    options = {
      "terminate" = mkOption {
        description = "Terminate the CONNECT request, and forwards the payload as raw TCP data.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkHttpUpgradeConnect =
    res:
    {
    }
    // optionalAttrs res."terminate" { inherit (res) "terminate"; }
    // {
    };
  HttpUpgradeModule = types.submodule {
    options = {
      "connect" = mkOption {
        description = "Connect specifies the configuration for the CONNECT config.\nThis is allowed only when type is CONNECT.";
        type = (types.nullOr HttpUpgradeConnectModule);
        default = null;
      };
      "type" = mkOption {
        description = "Type is the case-insensitive type of protocol upgrade.\ne.g. `websocket`, `CONNECT`, `spdy/3.1` etc.";
        type = types.str;
      };
    };
  };
  mkHttpUpgrade =
    res:
    {
    }
    // optionalAttrs (res."connect" != null) { "connect" = mkHttpUpgradeConnect res."connect"; }
    // {
      inherit (res) "type";
    };
  LoadBalancerConsistentHashCookieModule = types.submodule {
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
  mkLoadBalancerConsistentHashCookie =
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
  LoadBalancerConsistentHashHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the header to hash.";
        type = types.str;
      };
    };
  };
  mkLoadBalancerConsistentHashHeader = res: {
    inherit (res) "name";
  };
  LoadBalancerConsistentHashModule = types.submodule {
    options = {
      "cookie" = mkOption {
        description = "Cookie configures the cookie hash policy when the consistent hash type is set to Cookie.";
        type = (types.nullOr LoadBalancerConsistentHashCookieModule);
        default = null;
      };
      "header" = mkOption {
        description = "Header configures the header hash policy when the consistent hash type is set to Header.";
        type = (types.nullOr LoadBalancerConsistentHashHeaderModule);
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
  mkLoadBalancerConsistentHash =
    res:
    {
    }
    // optionalAttrs (res."cookie" != null) {
      "cookie" = mkLoadBalancerConsistentHashCookie res."cookie";
    }
    // {
    }
    // optionalAttrs (res."header" != null) {
      "header" = mkLoadBalancerConsistentHashHeader res."header";
    }
    // {
    }
    // optionalAttrs (res."tableSize" != null) { inherit (res) "tableSize"; }
    // {
      inherit (res) "type";
    };
  LoadBalancerEndpointOverrideExtractFromModule = types.submodule {
    options = {
      "header" = mkOption {
        description = "Header defines the header to get the override endpoint addresses.\nThe header value must specify at least one endpoint in `IP:Port` format or multiple endpoints in `IP:Port,IP:Port,...` format.\nFor example `10.0.0.5:8080` or `[2600:4040:5204::1574:24ae]:80`.\nThe IPv6 address is enclosed in square brackets.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkLoadBalancerEndpointOverrideExtractFrom =
    res:
    {
    }
    // optionalAttrs (res."header" != null) { inherit (res) "header"; }
    // {
    };
  LoadBalancerEndpointOverrideModule = types.submodule {
    options = {
      "extractFrom" = mkOption {
        description = "ExtractFrom defines the sources to extract endpoint override information from.";
        type = (types.listOf LoadBalancerEndpointOverrideExtractFromModule);
      };
    };
  };
  mkLoadBalancerEndpointOverride = res: {
    "extractFrom" = map mkLoadBalancerEndpointOverrideExtractFrom res."extractFrom";
  };
  LoadBalancerModule = types.submodule {
    options = {
      "consistentHash" = mkOption {
        description = "ConsistentHash defines the configuration when the load balancer type is\nset to ConsistentHash";
        type = (types.nullOr LoadBalancerConsistentHashModule);
        default = null;
      };
      "endpointOverride" = mkOption {
        description = "EndpointOverride defines the configuration for endpoint override.\nWhen specified, the load balancer will attempt to route requests to endpoints\nbased on the override information extracted from request headers or metadata.\n If the override endpoints are not available, the configured load balancer policy will be used as fallback.";
        type = (types.nullOr LoadBalancerEndpointOverrideModule);
        default = null;
      };
      "slowStart" = mkOption {
        description = "SlowStart defines the configuration related to the slow start load balancer policy.\nIf set, during slow start window, traffic sent to the newly added hosts will gradually increase.\nCurrently this is only supported for RoundRobin and LeastRequest load balancers";
        type = (types.nullOr LoadBalancerSlowStartModule);
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
        type = (types.nullOr LoadBalancerZoneAwareModule);
        default = null;
      };
    };
  };
  mkLoadBalancer =
    res:
    {
    }
    // optionalAttrs (res."consistentHash" != null) {
      "consistentHash" = mkLoadBalancerConsistentHash res."consistentHash";
    }
    // {
    }
    // optionalAttrs (res."endpointOverride" != null) {
      "endpointOverride" = mkLoadBalancerEndpointOverride res."endpointOverride";
    }
    // {
    }
    // optionalAttrs (res."slowStart" != null) {
      "slowStart" = mkLoadBalancerSlowStart res."slowStart";
    }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."zoneAware" != null) {
      "zoneAware" = mkLoadBalancerZoneAware res."zoneAware";
    }
    // {
    };
  LoadBalancerSlowStartModule = types.submodule {
    options = {
      "window" = mkOption {
        description = "Window defines the duration of the warm up period for newly added host.\nDuring slow start window, traffic sent to the newly added hosts will gradually increase.\nCurrently only supports linear growth of traffic. For additional details,\nsee https://www.envoyproxy.io/docs/envoy/latest/api-v3/config/cluster/v3/cluster.proto#config-cluster-v3-cluster-slowstartconfig";
        type = types.str;
      };
    };
  };
  mkLoadBalancerSlowStart = res: {
    inherit (res) "window";
  };
  LoadBalancerZoneAwareModule = types.submodule {
    options = {
      "preferLocal" = mkOption {
        description = "PreferLocalZone configures zone-aware routing to prefer sending traffic to the local locality zone.";
        type = (types.nullOr LoadBalancerZoneAwarePreferLocalModule);
        default = null;
      };
    };
  };
  mkLoadBalancerZoneAware =
    res:
    {
    }
    // optionalAttrs (res."preferLocal" != null) {
      "preferLocal" = mkLoadBalancerZoneAwarePreferLocal res."preferLocal";
    }
    // {
    };
  LoadBalancerZoneAwarePreferLocalForceModule = types.submodule {
    options = {
      "minEndpointsInZoneThreshold" = mkOption {
        description = "MinEndpointsInZoneThreshold is the minimum number of upstream endpoints in the local zone required to honor the forceLocalZone\noverride. This is useful for protecting zones with fewer endpoints.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkLoadBalancerZoneAwarePreferLocalForce =
    res:
    {
    }
    // optionalAttrs (res."minEndpointsInZoneThreshold" != null) {
      inherit (res) "minEndpointsInZoneThreshold";
    }
    // {
    };
  LoadBalancerZoneAwarePreferLocalModule = types.submodule {
    options = {
      "force" = mkOption {
        description = "ForceLocalZone defines override configuration for forcing all traffic to stay within the local zone instead of the default behavior\nwhich maintains equal distribution among upstream endpoints while sending as much traffic as possible locally.";
        type = (types.nullOr LoadBalancerZoneAwarePreferLocalForceModule);
        default = null;
      };
      "minEndpointsThreshold" = mkOption {
        description = "MinEndpointsThreshold is the minimum number of total upstream endpoints across all zones required to enable zone-aware routing.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkLoadBalancerZoneAwarePreferLocal =
    res:
    {
    }
    // optionalAttrs (res."force" != null) {
      "force" = mkLoadBalancerZoneAwarePreferLocalForce res."force";
    }
    // {
    }
    // optionalAttrs (res."minEndpointsThreshold" != null) { inherit (res) "minEndpointsThreshold"; }
    // {
    };
  ProxyProtocolModule = types.submodule {
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
  mkProxyProtocol = res: {
    inherit (res) "version";
  };
  RateLimitGlobalModule = types.submodule {
    options = {
      "rules" = mkOption {
        description = "Rules are a list of RateLimit selectors and limits. Each rule and its\nassociated limit is applied in a mutually exclusive way. If a request\nmatches multiple rules, each of their associated limits get applied, so a\nsingle request might increase the rate limit counters for multiple rules\nif selected. The rate limit service will return a logical OR of the individual\nrate limit decisions of all matching rules. For example, if a request\nmatches two rules, one rate limited and one not, the final decision will be\nto rate limit the request.";
        type = (types.listOf RateLimitGlobalRuleModule);
      };
    };
  };
  mkRateLimitGlobal = res: {
    "rules" = map mkRateLimitGlobalRule res."rules";
  };
  RateLimitGlobalRuleClientSelectorHeaderModule = types.submodule {
    options = {
      "invert" = mkOption {
        description = "Invert specifies whether the value match result will be inverted.\nDo not set this field when Type=\"Distinct\", implying matching on any/all unique\nvalues within the header.";
        type = types.bool;
        default = false;
      };
      "name" = mkOption {
        description = "Name of the HTTP header.\nThe header name is case-insensitive unless PreserveHeaderCase is set to true.\nFor example, \"Foo\" and \"foo\" are considered the same header.";
        type = types.str;
      };
      "type" = mkOption {
        description = "Type specifies how to match against the value of the header.";
        type = (
          types.nullOr (
            types.enum [
              "Exact"
              "RegularExpression"
              "Distinct"
            ]
          )
        );
        default = "Exact";
      };
      "value" = mkOption {
        description = "Value within the HTTP header.\nDo not set this field when Type=\"Distinct\", implying matching on any/all unique\nvalues within the header.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkRateLimitGlobalRuleClientSelectorHeader =
    res:
    {
    }
    // optionalAttrs res."invert" { inherit (res) "invert"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  RateLimitGlobalRuleClientSelectorModule = types.submodule {
    options = {
      "headers" = mkOption {
        description = "Headers is a list of request headers to match. Multiple header values are ANDed together,\nmeaning, a request MUST match all the specified headers.\nAt least one of headers or sourceCIDR condition must be specified.";
        type = (types.listOf RateLimitGlobalRuleClientSelectorHeaderModule);
        default = [ ];
      };
      "sourceCIDR" = mkOption {
        description = "SourceCIDR is the client IP Address range to match on.\nAt least one of headers or sourceCIDR condition must be specified.";
        type = (types.nullOr RateLimitGlobalRuleClientSelectorSourceCIDRModule);
        default = null;
      };
    };
  };
  mkRateLimitGlobalRuleClientSelector =
    res:
    {
    }
    // optionalAttrs (res."headers" != [ ]) {
      "headers" = map mkRateLimitGlobalRuleClientSelectorHeader res."headers";
    }
    // {
    }
    // optionalAttrs (res."sourceCIDR" != null) {
      "sourceCIDR" = mkRateLimitGlobalRuleClientSelectorSourceCIDR res."sourceCIDR";
    }
    // {
    };
  RateLimitGlobalRuleClientSelectorSourceCIDRModule = types.submodule {
    options = {
      "type" = mkOption {
        type = (
          types.nullOr (
            types.enum [
              "Exact"
              "Distinct"
            ]
          )
        );
        default = "Exact";
      };
      "value" = mkOption {
        description = "Value is the IP CIDR that represents the range of Source IP Addresses of the client.\nThese could also be the intermediate addresses through which the request has flown through and is part of the  `X-Forwarded-For` header.\nFor example, `192.168.0.1/32`, `192.168.0.0/24`, `001:db8::/64`.";
        type = types.str;
      };
    };
  };
  mkRateLimitGlobalRuleClientSelectorSourceCIDR =
    res:
    {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
      inherit (res) "value";
    };
  RateLimitGlobalRuleCostModule = types.submodule {
    options = {
      "request" = mkOption {
        description = "Request specifies the number to reduce the rate limit counters\non the request path. If this is not specified, the default behavior\nis to reduce the rate limit counters by 1.\n\nWhen Envoy receives a request that matches the rule, it tries to reduce the\nrate limit counters by the specified number. If the counter doesn't have\nenough capacity, the request is rate limited.";
        type = (types.nullOr RateLimitGlobalRuleCostRequestModule);
        default = null;
      };
      "response" = mkOption {
        description = "Response specifies the number to reduce the rate limit counters\nafter the response is sent back to the client or the request stream is closed.\n\nThe cost is used to reduce the rate limit counters for the matching requests.\nSince the reduction happens after the request stream is complete, the rate limit\nwon't be enforced for the current request, but for the subsequent matching requests.\n\nThis is optional and if not specified, the rate limit counters are not reduced\non the response path.\n\nCurrently, this is only supported for HTTP Global Rate Limits.";
        type = (types.nullOr RateLimitGlobalRuleCostResponseModule);
        default = null;
      };
    };
  };
  mkRateLimitGlobalRuleCost =
    res:
    {
    }
    // optionalAttrs (res."request" != null) {
      "request" = mkRateLimitGlobalRuleCostRequest res."request";
    }
    // {
    }
    // optionalAttrs (res."response" != null) {
      "response" = mkRateLimitGlobalRuleCostResponse res."response";
    }
    // {
    };
  RateLimitGlobalRuleCostRequestMetadataModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "Key is the key to retrieve the usage number from the filter metadata.";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "Namespace is the namespace of the dynamic metadata.";
        type = types.str;
      };
    };
  };
  mkRateLimitGlobalRuleCostRequestMetadata = res: {
    inherit (res) "key";
    inherit (res) "namespace";
  };
  RateLimitGlobalRuleCostRequestModule = types.submodule {
    options = {
      "from" = mkOption {
        description = "From specifies where to get the rate limit cost. Currently, only \"Number\" and \"Metadata\" are supported.";
        type = (
          types.enum [
            "Number"
            "Metadata"
          ]
        );
      };
      "metadata" = mkOption {
        description = "Metadata specifies the per-request metadata to retrieve the usage number from.";
        type = (types.nullOr RateLimitGlobalRuleCostRequestMetadataModule);
        default = null;
      };
      "number" = mkOption {
        description = "Number specifies the fixed usage number to reduce the rate limit counters.\nUsing zero can be used to only check the rate limit counters without reducing them.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkRateLimitGlobalRuleCostRequest =
    res:
    {
      inherit (res) "from";
    }
    // optionalAttrs (res."metadata" != null) {
      "metadata" = mkRateLimitGlobalRuleCostRequestMetadata res."metadata";
    }
    // {
    }
    // optionalAttrs (res."number" != null) { inherit (res) "number"; }
    // {
    };
  RateLimitGlobalRuleCostResponseMetadataModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "Key is the key to retrieve the usage number from the filter metadata.";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "Namespace is the namespace of the dynamic metadata.";
        type = types.str;
      };
    };
  };
  mkRateLimitGlobalRuleCostResponseMetadata = res: {
    inherit (res) "key";
    inherit (res) "namespace";
  };
  RateLimitGlobalRuleCostResponseModule = types.submodule {
    options = {
      "from" = mkOption {
        description = "From specifies where to get the rate limit cost. Currently, only \"Number\" and \"Metadata\" are supported.";
        type = (
          types.enum [
            "Number"
            "Metadata"
          ]
        );
      };
      "metadata" = mkOption {
        description = "Metadata specifies the per-request metadata to retrieve the usage number from.";
        type = (types.nullOr RateLimitGlobalRuleCostResponseMetadataModule);
        default = null;
      };
      "number" = mkOption {
        description = "Number specifies the fixed usage number to reduce the rate limit counters.\nUsing zero can be used to only check the rate limit counters without reducing them.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkRateLimitGlobalRuleCostResponse =
    res:
    {
      inherit (res) "from";
    }
    // optionalAttrs (res."metadata" != null) {
      "metadata" = mkRateLimitGlobalRuleCostResponseMetadata res."metadata";
    }
    // {
    }
    // optionalAttrs (res."number" != null) { inherit (res) "number"; }
    // {
    };
  RateLimitGlobalRuleLimitModule = types.submodule {
    options = {
      "requests" = mkOption {
        type = types.int;
      };
      "unit" = mkOption {
        description = "RateLimitUnit specifies the intervals for setting rate limits.\nValid RateLimitUnit values are \"Second\", \"Minute\", \"Hour\", \"Day\", \"Month\" and \"Year\".";
        type = (
          types.enum [
            "Second"
            "Minute"
            "Hour"
            "Day"
            "Month"
            "Year"
          ]
        );
      };
    };
  };
  mkRateLimitGlobalRuleLimit = res: {
    inherit (res) "requests";
    inherit (res) "unit";
  };
  RateLimitGlobalRuleModule = types.submodule {
    options = {
      "clientSelectors" = mkOption {
        description = "ClientSelectors holds the list of select conditions to select\nspecific clients using attributes from the traffic flow.\nAll individual select conditions must hold True for this rule\nand its limit to be applied.\n\nIf no client selectors are specified, the rule applies to all traffic of\nthe targeted Route.\n\nIf the policy targets a Gateway, the rule applies to each Route of the Gateway.\nPlease note that each Route has its own rate limit counters. For example,\nif a Gateway has two Routes, and the policy has a rule with limit 10rps,\neach Route will have its own 10rps limit.";
        type = (types.listOf RateLimitGlobalRuleClientSelectorModule);
        default = [ ];
      };
      "cost" = mkOption {
        description = "Cost specifies the cost of requests and responses for the rule.\n\nThis is optional and if not specified, the default behavior is to reduce the rate limit counters by 1 on\nthe request path and do not reduce the rate limit counters on the response path.";
        type = (types.nullOr RateLimitGlobalRuleCostModule);
        default = null;
      };
      "limit" = mkOption {
        description = "Limit holds the rate limit values.\nThis limit is applied for traffic flows when the selectors\ncompute to True, causing the request to be counted towards the limit.\nThe limit is enforced and the request is ratelimited, i.e. a response with\n429 HTTP status code is sent back to the client when\nthe selected requests have reached the limit.";
        type = RateLimitGlobalRuleLimitModule;
      };
      "shared" = mkOption {
        description = "Shared determines whether this rate limit rule applies across all the policy targets.\nIf set to true, the rule is treated as a common bucket and is shared across all policy targets (xRoutes).\nDefault: false.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkRateLimitGlobalRule =
    res:
    {
    }
    // optionalAttrs (res."clientSelectors" != [ ]) {
      "clientSelectors" = map mkRateLimitGlobalRuleClientSelector res."clientSelectors";
    }
    // {
    }
    // optionalAttrs (res."cost" != null) { "cost" = mkRateLimitGlobalRuleCost res."cost"; }
    // {
      "limit" = mkRateLimitGlobalRuleLimit res."limit";
    }
    // optionalAttrs res."shared" { inherit (res) "shared"; }
    // {
    };
  RateLimitLocalModule = types.submodule {
    options = {
      "rules" = mkOption {
        description = "Rules are a list of RateLimit selectors and limits. If a request matches\nmultiple rules, the strictest limit is applied. For example, if a request\nmatches two rules, one with 10rps and one with 20rps, the final limit will\nbe based on the rule with 10rps.";
        type = (types.listOf RateLimitLocalRuleModule);
        default = [ ];
      };
    };
  };
  mkRateLimitLocal =
    res:
    {
    }
    // optionalAttrs (res."rules" != [ ]) { "rules" = map mkRateLimitLocalRule res."rules"; }
    // {
    };
  RateLimitLocalRuleClientSelectorHeaderModule = types.submodule {
    options = {
      "invert" = mkOption {
        description = "Invert specifies whether the value match result will be inverted.\nDo not set this field when Type=\"Distinct\", implying matching on any/all unique\nvalues within the header.";
        type = types.bool;
        default = false;
      };
      "name" = mkOption {
        description = "Name of the HTTP header.\nThe header name is case-insensitive unless PreserveHeaderCase is set to true.\nFor example, \"Foo\" and \"foo\" are considered the same header.";
        type = types.str;
      };
      "type" = mkOption {
        description = "Type specifies how to match against the value of the header.";
        type = (
          types.nullOr (
            types.enum [
              "Exact"
              "RegularExpression"
              "Distinct"
            ]
          )
        );
        default = "Exact";
      };
      "value" = mkOption {
        description = "Value within the HTTP header.\nDo not set this field when Type=\"Distinct\", implying matching on any/all unique\nvalues within the header.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkRateLimitLocalRuleClientSelectorHeader =
    res:
    {
    }
    // optionalAttrs res."invert" { inherit (res) "invert"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  RateLimitLocalRuleClientSelectorModule = types.submodule {
    options = {
      "headers" = mkOption {
        description = "Headers is a list of request headers to match. Multiple header values are ANDed together,\nmeaning, a request MUST match all the specified headers.\nAt least one of headers or sourceCIDR condition must be specified.";
        type = (types.listOf RateLimitLocalRuleClientSelectorHeaderModule);
        default = [ ];
      };
      "sourceCIDR" = mkOption {
        description = "SourceCIDR is the client IP Address range to match on.\nAt least one of headers or sourceCIDR condition must be specified.";
        type = (types.nullOr RateLimitLocalRuleClientSelectorSourceCIDRModule);
        default = null;
      };
    };
  };
  mkRateLimitLocalRuleClientSelector =
    res:
    {
    }
    // optionalAttrs (res."headers" != [ ]) {
      "headers" = map mkRateLimitLocalRuleClientSelectorHeader res."headers";
    }
    // {
    }
    // optionalAttrs (res."sourceCIDR" != null) {
      "sourceCIDR" = mkRateLimitLocalRuleClientSelectorSourceCIDR res."sourceCIDR";
    }
    // {
    };
  RateLimitLocalRuleClientSelectorSourceCIDRModule = types.submodule {
    options = {
      "type" = mkOption {
        type = (
          types.nullOr (
            types.enum [
              "Exact"
              "Distinct"
            ]
          )
        );
        default = "Exact";
      };
      "value" = mkOption {
        description = "Value is the IP CIDR that represents the range of Source IP Addresses of the client.\nThese could also be the intermediate addresses through which the request has flown through and is part of the  `X-Forwarded-For` header.\nFor example, `192.168.0.1/32`, `192.168.0.0/24`, `001:db8::/64`.";
        type = types.str;
      };
    };
  };
  mkRateLimitLocalRuleClientSelectorSourceCIDR =
    res:
    {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
      inherit (res) "value";
    };
  RateLimitLocalRuleCostModule = types.submodule {
    options = {
      "request" = mkOption {
        description = "Request specifies the number to reduce the rate limit counters\non the request path. If this is not specified, the default behavior\nis to reduce the rate limit counters by 1.\n\nWhen Envoy receives a request that matches the rule, it tries to reduce the\nrate limit counters by the specified number. If the counter doesn't have\nenough capacity, the request is rate limited.";
        type = (types.nullOr RateLimitLocalRuleCostRequestModule);
        default = null;
      };
      "response" = mkOption {
        description = "Response specifies the number to reduce the rate limit counters\nafter the response is sent back to the client or the request stream is closed.\n\nThe cost is used to reduce the rate limit counters for the matching requests.\nSince the reduction happens after the request stream is complete, the rate limit\nwon't be enforced for the current request, but for the subsequent matching requests.\n\nThis is optional and if not specified, the rate limit counters are not reduced\non the response path.\n\nCurrently, this is only supported for HTTP Global Rate Limits.";
        type = (types.nullOr RateLimitLocalRuleCostResponseModule);
        default = null;
      };
    };
  };
  mkRateLimitLocalRuleCost =
    res:
    {
    }
    // optionalAttrs (res."request" != null) {
      "request" = mkRateLimitLocalRuleCostRequest res."request";
    }
    // {
    }
    // optionalAttrs (res."response" != null) {
      "response" = mkRateLimitLocalRuleCostResponse res."response";
    }
    // {
    };
  RateLimitLocalRuleCostRequestMetadataModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "Key is the key to retrieve the usage number from the filter metadata.";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "Namespace is the namespace of the dynamic metadata.";
        type = types.str;
      };
    };
  };
  mkRateLimitLocalRuleCostRequestMetadata = res: {
    inherit (res) "key";
    inherit (res) "namespace";
  };
  RateLimitLocalRuleCostRequestModule = types.submodule {
    options = {
      "from" = mkOption {
        description = "From specifies where to get the rate limit cost. Currently, only \"Number\" and \"Metadata\" are supported.";
        type = (
          types.enum [
            "Number"
            "Metadata"
          ]
        );
      };
      "metadata" = mkOption {
        description = "Metadata specifies the per-request metadata to retrieve the usage number from.";
        type = (types.nullOr RateLimitLocalRuleCostRequestMetadataModule);
        default = null;
      };
      "number" = mkOption {
        description = "Number specifies the fixed usage number to reduce the rate limit counters.\nUsing zero can be used to only check the rate limit counters without reducing them.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkRateLimitLocalRuleCostRequest =
    res:
    {
      inherit (res) "from";
    }
    // optionalAttrs (res."metadata" != null) {
      "metadata" = mkRateLimitLocalRuleCostRequestMetadata res."metadata";
    }
    // {
    }
    // optionalAttrs (res."number" != null) { inherit (res) "number"; }
    // {
    };
  RateLimitLocalRuleCostResponseMetadataModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "Key is the key to retrieve the usage number from the filter metadata.";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "Namespace is the namespace of the dynamic metadata.";
        type = types.str;
      };
    };
  };
  mkRateLimitLocalRuleCostResponseMetadata = res: {
    inherit (res) "key";
    inherit (res) "namespace";
  };
  RateLimitLocalRuleCostResponseModule = types.submodule {
    options = {
      "from" = mkOption {
        description = "From specifies where to get the rate limit cost. Currently, only \"Number\" and \"Metadata\" are supported.";
        type = (
          types.enum [
            "Number"
            "Metadata"
          ]
        );
      };
      "metadata" = mkOption {
        description = "Metadata specifies the per-request metadata to retrieve the usage number from.";
        type = (types.nullOr RateLimitLocalRuleCostResponseMetadataModule);
        default = null;
      };
      "number" = mkOption {
        description = "Number specifies the fixed usage number to reduce the rate limit counters.\nUsing zero can be used to only check the rate limit counters without reducing them.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkRateLimitLocalRuleCostResponse =
    res:
    {
      inherit (res) "from";
    }
    // optionalAttrs (res."metadata" != null) {
      "metadata" = mkRateLimitLocalRuleCostResponseMetadata res."metadata";
    }
    // {
    }
    // optionalAttrs (res."number" != null) { inherit (res) "number"; }
    // {
    };
  RateLimitLocalRuleLimitModule = types.submodule {
    options = {
      "requests" = mkOption {
        type = types.int;
      };
      "unit" = mkOption {
        description = "RateLimitUnit specifies the intervals for setting rate limits.\nValid RateLimitUnit values are \"Second\", \"Minute\", \"Hour\", \"Day\", \"Month\" and \"Year\".";
        type = (
          types.enum [
            "Second"
            "Minute"
            "Hour"
            "Day"
            "Month"
            "Year"
          ]
        );
      };
    };
  };
  mkRateLimitLocalRuleLimit = res: {
    inherit (res) "requests";
    inherit (res) "unit";
  };
  RateLimitLocalRuleModule = types.submodule {
    options = {
      "clientSelectors" = mkOption {
        description = "ClientSelectors holds the list of select conditions to select\nspecific clients using attributes from the traffic flow.\nAll individual select conditions must hold True for this rule\nand its limit to be applied.\n\nIf no client selectors are specified, the rule applies to all traffic of\nthe targeted Route.\n\nIf the policy targets a Gateway, the rule applies to each Route of the Gateway.\nPlease note that each Route has its own rate limit counters. For example,\nif a Gateway has two Routes, and the policy has a rule with limit 10rps,\neach Route will have its own 10rps limit.";
        type = (types.listOf RateLimitLocalRuleClientSelectorModule);
        default = [ ];
      };
      "cost" = mkOption {
        description = "Cost specifies the cost of requests and responses for the rule.\n\nThis is optional and if not specified, the default behavior is to reduce the rate limit counters by 1 on\nthe request path and do not reduce the rate limit counters on the response path.";
        type = (types.nullOr RateLimitLocalRuleCostModule);
        default = null;
      };
      "limit" = mkOption {
        description = "Limit holds the rate limit values.\nThis limit is applied for traffic flows when the selectors\ncompute to True, causing the request to be counted towards the limit.\nThe limit is enforced and the request is ratelimited, i.e. a response with\n429 HTTP status code is sent back to the client when\nthe selected requests have reached the limit.";
        type = RateLimitLocalRuleLimitModule;
      };
      "shared" = mkOption {
        description = "Shared determines whether this rate limit rule applies across all the policy targets.\nIf set to true, the rule is treated as a common bucket and is shared across all policy targets (xRoutes).\nDefault: false.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkRateLimitLocalRule =
    res:
    {
    }
    // optionalAttrs (res."clientSelectors" != [ ]) {
      "clientSelectors" = map mkRateLimitLocalRuleClientSelector res."clientSelectors";
    }
    // {
    }
    // optionalAttrs (res."cost" != null) { "cost" = mkRateLimitLocalRuleCost res."cost"; }
    // {
      "limit" = mkRateLimitLocalRuleLimit res."limit";
    }
    // optionalAttrs res."shared" { inherit (res) "shared"; }
    // {
    };
  RateLimitModule = types.submodule {
    options = {
      "global" = mkOption {
        description = "Global defines global rate limit configuration.";
        type = (types.nullOr RateLimitGlobalModule);
        default = null;
      };
      "local" = mkOption {
        description = "Local defines local rate limit configuration.";
        type = (types.nullOr RateLimitLocalModule);
        default = null;
      };
      "type" = mkOption {
        description = "Type decides the scope for the RateLimits.\nValid RateLimitType values are \"Global\" or \"Local\".";
        type = (
          types.enum [
            "Global"
            "Local"
          ]
        );
      };
    };
  };
  mkRateLimit =
    res:
    {
    }
    // optionalAttrs (res."global" != null) { "global" = mkRateLimitGlobal res."global"; }
    // {
    }
    // optionalAttrs (res."local" != null) { "local" = mkRateLimitLocal res."local"; }
    // {
      inherit (res) "type";
    };
  RequestBufferModule = types.submodule {
    options = {
      "limit" = mkOption {
        description = "Limit specifies the maximum allowed size in bytes for each incoming request buffer.\nIf exceeded, the request will be rejected with HTTP 413 Content Too Large.\n\nAccepts values in resource.Quantity format (e.g., \"10Mi\", \"500Ki\").";
        type = types.anything;
        default = { };
      };
    };
  };
  mkRequestBuffer =
    res:
    {
    }
    // optionalAttrs (res."limit" != null) { inherit (res) "limit"; }
    // {
    };
  ResponseOverrideMatchModule = types.submodule {
    options = {
      "statusCodes" = mkOption {
        description = "Status code to match on. The match evaluates to true if any of the matches are successful.";
        type = (types.listOf ResponseOverrideMatchStatusCodeModule);
      };
    };
  };
  mkResponseOverrideMatch = res: {
    "statusCodes" = map mkResponseOverrideMatchStatusCode res."statusCodes";
  };
  ResponseOverrideMatchStatusCodeModule = types.submodule {
    options = {
      "range" = mkOption {
        description = "Range contains the range of status codes.";
        type = (types.nullOr ResponseOverrideMatchStatusCodeRangeModule);
        default = null;
      };
      "type" = mkOption {
        description = "Type is the type of value.\nValid values are Value and Range, default is Value.";
        type = types.str;
      };
      "value" = mkOption {
        description = "Value contains the value of the status code.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkResponseOverrideMatchStatusCode =
    res:
    {
    }
    // optionalAttrs (res."range" != null) {
      "range" = mkResponseOverrideMatchStatusCodeRange res."range";
    }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  ResponseOverrideMatchStatusCodeRangeModule = types.submodule {
    options = {
      "end" = mkOption {
        description = "End of the range, including the end value.";
        type = types.int;
      };
      "start" = mkOption {
        description = "Start of the range, including the start value.";
        type = types.int;
      };
    };
  };
  mkResponseOverrideMatchStatusCodeRange = res: {
    inherit (res) "end";
    inherit (res) "start";
  };
  ResponseOverrideModule = types.submodule {
    options = {
      "match" = mkOption {
        description = "Match configuration.";
        type = ResponseOverrideMatchModule;
      };
      "redirect" = mkOption {
        description = "Redirect configuration";
        type = (types.nullOr ResponseOverrideRedirectModule);
        default = null;
      };
      "response" = mkOption {
        description = "Response configuration.";
        type = (types.nullOr ResponseOverrideResponseModule);
        default = null;
      };
    };
  };
  mkResponseOverride =
    res:
    {
      "match" = mkResponseOverrideMatch res."match";
    }
    // optionalAttrs (res."redirect" != null) {
      "redirect" = mkResponseOverrideRedirect res."redirect";
    }
    // {
    }
    // optionalAttrs (res."response" != null) {
      "response" = mkResponseOverrideResponse res."response";
    }
    // {
    };
  ResponseOverrideRedirectModule = types.submodule {
    options = {
      "hostname" = mkOption {
        description = "Hostname is the hostname to be used in the value of the `Location`\nheader in the response.\nWhen empty, the hostname in the `Host` header of the request is used.";
        type = (types.nullOr types.str);
        default = null;
      };
      "path" = mkOption {
        description = "Path defines parameters used to modify the path of the incoming request.\nThe modified path is then used to construct the `Location` header. When\nempty, the request path is used as-is.\nOnly ReplaceFullPath path modifier is supported currently.";
        type = (types.nullOr ResponseOverrideRedirectPathModule);
        default = null;
      };
      "port" = mkOption {
        description = "Port is the port to be used in the value of the `Location`\nheader in the response.\n\nIf redirect scheme is not-empty, the well-known port associated with the redirect scheme will be used.\nSpecifically \"http\" to port 80 and \"https\" to port 443. If the redirect scheme does not have a\nwell-known port or redirect scheme is empty, the listener port of the Gateway will be used.\n\nPort will not be added in the 'Location' header if scheme is HTTP and port is 80\nor scheme is HTTPS and port is 443.";
        type = (types.nullOr types.int);
        default = null;
      };
      "scheme" = mkOption {
        description = "Scheme is the scheme to be used in the value of the `Location` header in\nthe response. When empty, the scheme of the request is used.";
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
        description = "StatusCode is the HTTP status code to be used in response.";
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
  mkResponseOverrideRedirect =
    res:
    {
    }
    // optionalAttrs (res."hostname" != null) { inherit (res) "hostname"; }
    // {
    }
    // optionalAttrs (res."path" != null) { "path" = mkResponseOverrideRedirectPath res."path"; }
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
  ResponseOverrideRedirectPathModule = types.submodule {
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
  mkResponseOverrideRedirectPath =
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
  ResponseOverrideResponseBodyModule = types.submodule {
    options = {
      "inline" = mkOption {
        description = "Inline contains the value as an inline string.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Type is the type of method to use to read the body value.\nValid values are Inline and ValueRef, default is Inline.";
        type = types.str;
      };
      "valueRef" = mkOption {
        description = "ValueRef contains the contents of the body\nspecified as a local object reference.\nOnly a reference to ConfigMap is supported.\n\nThe value of key `response.body` in the ConfigMap will be used as the response body.\nIf the key is not found, the first value in the ConfigMap will be used.";
        type = (types.nullOr ResponseOverrideResponseBodyValueRefModule);
        default = null;
      };
    };
  };
  mkResponseOverrideResponseBody =
    res:
    {
    }
    // optionalAttrs (res."inline" != null) { inherit (res) "inline"; }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."valueRef" != null) {
      "valueRef" = mkResponseOverrideResponseBodyValueRef res."valueRef";
    }
    // {
    };
  ResponseOverrideResponseBodyValueRefModule = types.submodule {
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
  mkResponseOverrideResponseBodyValueRef = res: {
    inherit (res) "group";
    inherit (res) "kind";
    inherit (res) "name";
  };
  ResponseOverrideResponseModule = types.submodule {
    options = {
      "body" = mkOption {
        description = "Body of the Custom Response\nSupports Envoy command operators for dynamic content (see https://www.envoyproxy.io/docs/envoy/latest/configuration/observability/access_log/usage#command-operators).";
        type = (types.nullOr ResponseOverrideResponseBodyModule);
        default = null;
      };
      "contentType" = mkOption {
        description = "Content Type of the response. This will be set in the Content-Type header.";
        type = (types.nullOr types.str);
        default = null;
      };
      "statusCode" = mkOption {
        description = "Status Code of the Custom Response\nIf unset, does not override the status of response.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkResponseOverrideResponse =
    res:
    {
    }
    // optionalAttrs (res."body" != null) { "body" = mkResponseOverrideResponseBody res."body"; }
    // {
    }
    // optionalAttrs (res."contentType" != null) { inherit (res) "contentType"; }
    // {
    }
    // optionalAttrs (res."statusCode" != null) { inherit (res) "statusCode"; }
    // {
    };
  RetryModule = types.submodule {
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
        type = (types.nullOr RetryPerRetryModule);
        default = null;
      };
      "retryOn" = mkOption {
        description = "RetryOn specifies the retry trigger condition.\n\nIf not specified, the default is to retry on connect-failure,refused-stream,unavailable,cancelled,retriable-status-codes(503).";
        type = (types.nullOr RetryRetryOnModule);
        default = null;
      };
    };
  };
  mkRetry =
    res:
    {
    }
    // optionalAttrs (res."numAttemptsPerPriority" != null) { inherit (res) "numAttemptsPerPriority"; }
    // {
    }
    // optionalAttrs (res."numRetries" != null) { inherit (res) "numRetries"; }
    // {
    }
    // optionalAttrs (res."perRetry" != null) { "perRetry" = mkRetryPerRetry res."perRetry"; }
    // {
    }
    // optionalAttrs (res."retryOn" != null) { "retryOn" = mkRetryRetryOn res."retryOn"; }
    // {
    };
  RetryPerRetryBackOffModule = types.submodule {
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
  mkRetryPerRetryBackOff =
    res:
    {
    }
    // optionalAttrs (res."baseInterval" != null) { inherit (res) "baseInterval"; }
    // {
    }
    // optionalAttrs (res."maxInterval" != null) { inherit (res) "maxInterval"; }
    // {
    };
  RetryPerRetryModule = types.submodule {
    options = {
      "backOff" = mkOption {
        description = "Backoff is the backoff policy to be applied per retry attempt. gateway uses a fully jittered exponential\nback-off algorithm for retries. For additional details,\nsee https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/router_filter#config-http-filters-router-x-envoy-max-retries";
        type = (types.nullOr RetryPerRetryBackOffModule);
        default = null;
      };
      "timeout" = mkOption {
        description = "Timeout is the timeout per retry attempt.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkRetryPerRetry =
    res:
    {
    }
    // optionalAttrs (res."backOff" != null) { "backOff" = mkRetryPerRetryBackOff res."backOff"; }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    };
  RetryRetryOnModule = types.submodule {
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
  mkRetryRetryOn =
    res:
    {
    }
    // optionalAttrs (res."httpStatusCodes" != [ ]) { inherit (res) "httpStatusCodes"; }
    // {
    }
    // optionalAttrs (res."triggers" != [ ]) { inherit (res) "triggers"; }
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
  TelemetryModule = types.submodule {
    options = {
      "tracing" = mkOption {
        description = "Tracing configures the tracing settings for the backend or HTTPRoute.";
        type = (types.nullOr TelemetryTracingModule);
        default = null;
      };
    };
  };
  mkTelemetry =
    res:
    {
    }
    // optionalAttrs (res."tracing" != null) { "tracing" = mkTelemetryTracing res."tracing"; }
    // {
    };
  TelemetryTracingModule = types.submodule {
    options = {
      "customTags" = mkOption {
        description = "CustomTags defines the custom tags to add to each span.\nIf provider is kubernetes, pod name and namespace are added by default.";
        type = (types.attrsOf (types.attrsOf types.anything));
        default = { };
      };
      "samplingFraction" = mkOption {
        description = "SamplingFraction represents the fraction of requests that should be\nselected for tracing if no prior sampling decision has been made.\n\nThis will take precedence over sampling fraction on EnvoyProxy if set.";
        type = (types.nullOr TelemetryTracingSamplingFractionModule);
        default = null;
      };
    };
  };
  mkTelemetryTracing =
    res:
    {
    }
    // optionalAttrs (res."customTags" != { }) { inherit (res) "customTags"; }
    // {
    }
    // optionalAttrs (res."samplingFraction" != null) {
      "samplingFraction" = mkTelemetryTracingSamplingFraction res."samplingFraction";
    }
    // {
    };
  TelemetryTracingSamplingFractionModule = types.submodule {
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
  mkTelemetryTracingSamplingFraction =
    res:
    {
    }
    // optionalAttrs (res."denominator" != null) { inherit (res) "denominator"; }
    // {
      inherit (res) "numerator";
    };
  TimeoutHttpModule = types.submodule {
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
  mkTimeoutHttp =
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
      "connectTimeout" = mkOption {
        description = "The timeout for network connection establishment, including TCP and TLS handshakes.\nDefault: 10 seconds.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTimeoutTcp =
    res:
    {
    }
    // optionalAttrs (res."connectTimeout" != null) { inherit (res) "connectTimeout"; }
    // {
    };
  BackendtrafficpoliciesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this BackendTrafficPolicy resource.";
        };
        "circuitBreaker" = mkOption {
          description = "Circuit Breaker settings for the upstream connections and requests.\nIf not set, circuit breakers will be enabled with the default thresholds";
          type = (types.nullOr CircuitBreakerModule);
          default = null;
        };
        "compression" = mkOption {
          description = "The compression config for the http streams.";
          type = (types.listOf CompressionModule);
          default = [ ];
        };
        "connection" = mkOption {
          description = "Connection includes backend connection settings.";
          type = (types.nullOr ConnectionModule);
          default = null;
        };
        "dns" = mkOption {
          description = "DNS includes dns resolution settings.";
          type = (types.nullOr DnsModule);
          default = null;
        };
        "faultInjection" = mkOption {
          description = "FaultInjection defines the fault injection policy to be applied. This configuration can be used to\ninject delays and abort requests to mimic failure scenarios such as service failures and overloads";
          type = (types.nullOr FaultInjectionModule);
          default = null;
        };
        "healthCheck" = mkOption {
          description = "HealthCheck allows gateway to perform active health checking on backends.";
          type = (types.nullOr HealthCheckModule);
          default = null;
        };
        "http2" = mkOption {
          description = "HTTP2 provides HTTP/2 configuration for backend connections.";
          type = (types.nullOr Http2Module);
          default = null;
        };
        "httpUpgrade" = mkOption {
          description = "HTTPUpgrade defines the configuration for HTTP protocol upgrades.\nIf not specified, the default upgrade configuration(websocket) will be used.";
          type = (types.listOf HttpUpgradeModule);
          default = [ ];
        };
        "loadBalancer" = mkOption {
          description = "LoadBalancer policy to apply when routing traffic from the gateway to\nthe backend endpoints. Defaults to `LeastRequest`.";
          type = (types.nullOr LoadBalancerModule);
          default = null;
        };
        "mergeType" = mkOption {
          description = "MergeType determines how this configuration is merged with existing BackendTrafficPolicy\nconfigurations targeting a parent resource. When set, this configuration will be merged\ninto a parent BackendTrafficPolicy (i.e. the one targeting a Gateway or Listener).\nThis field cannot be set when targeting a parent resource (Gateway).\nIf unset, no merging occurs, and only the most specific configuration takes effect.";
          type = (types.nullOr types.str);
          default = null;
        };
        "proxyProtocol" = mkOption {
          description = "ProxyProtocol enables the Proxy Protocol when communicating with the backend.";
          type = (types.nullOr ProxyProtocolModule);
          default = null;
        };
        "rateLimit" = mkOption {
          description = "RateLimit allows the user to limit the number of incoming requests\nto a predefined value based on attributes within the traffic flow.";
          type = (types.nullOr RateLimitModule);
          default = null;
        };
        "requestBuffer" = mkOption {
          description = "RequestBuffer allows the gateway to buffer and fully receive each request from a client before continuing to send the request\nupstream to the backends. This can be helpful to shield your backend servers from slow clients, and also to enforce a maximum size per request\nas any requests larger than the buffer size will be rejected.\n\nThis can have a negative performance impact so should only be enabled when necessary.\n\nWhen enabling this option, you should also configure your connection buffer size to account for these request buffers. There will also be an\nincrease in memory usage for Envoy that should be accounted for in your deployment settings.";
          type = (types.nullOr RequestBufferModule);
          default = null;
        };
        "responseOverride" = mkOption {
          description = "ResponseOverride defines the configuration to override specific responses with a custom one.\nIf multiple configurations are specified, the first one to match wins.";
          type = (types.listOf ResponseOverrideModule);
          default = [ ];
        };
        "retry" = mkOption {
          description = "Retry provides more advanced usage, allowing users to customize the number of retries, retry fallback strategy, and retry triggering conditions.\nIf not set, retry will be disabled.";
          type = (types.nullOr RetryModule);
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
          description = "TcpKeepalive settings associated with the upstream client connection.\nDisabled by default.";
          type = (types.nullOr TcpKeepaliveModule);
          default = null;
        };
        "telemetry" = mkOption {
          description = "Telemetry configures the telemetry settings for the policy target (Gateway or xRoute).\nThis will override the telemetry settings in the EnvoyProxy resource.";
          type = (types.nullOr TelemetryModule);
          default = null;
        };
        "timeout" = mkOption {
          description = "Timeout settings for the backend connections.";
          type = (types.nullOr TimeoutModule);
          default = null;
        };
        "useClientProtocol" = mkOption {
          description = "UseClientProtocol configures Envoy to prefer sending requests to backends using\nthe same HTTP protocol that the incoming request used. Defaults to false, which means\nthat Envoy will use the protocol indicated by the attached BackendRef.";
          type = types.bool;
          default = false;
        };
      };
    }
  );
  mkBackendTrafficPolicy = name: res: {
    apiVersion = "gateway.envoyproxy.io/v1alpha1";
    kind = "BackendTrafficPolicy";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."circuitBreaker" != null) {
      "circuitBreaker" = mkCircuitBreaker res."circuitBreaker";
    }
    // {
    }
    // optionalAttrs (res."compression" != [ ]) { "compression" = map mkCompression res."compression"; }
    // {
    }
    // optionalAttrs (res."connection" != null) { "connection" = mkConnection res."connection"; }
    // {
    }
    // optionalAttrs (res."dns" != null) { "dns" = mkDns res."dns"; }
    // {
    }
    // optionalAttrs (res."faultInjection" != null) {
      "faultInjection" = mkFaultInjection res."faultInjection";
    }
    // {
    }
    // optionalAttrs (res."healthCheck" != null) { "healthCheck" = mkHealthCheck res."healthCheck"; }
    // {
    }
    // optionalAttrs (res."http2" != null) { "http2" = mkHttp2 res."http2"; }
    // {
    }
    // optionalAttrs (res."httpUpgrade" != [ ]) { "httpUpgrade" = map mkHttpUpgrade res."httpUpgrade"; }
    // {
    }
    // optionalAttrs (res."loadBalancer" != null) {
      "loadBalancer" = mkLoadBalancer res."loadBalancer";
    }
    // {
    }
    // optionalAttrs (res."mergeType" != null) { inherit (res) "mergeType"; }
    // {
    }
    // optionalAttrs (res."proxyProtocol" != null) {
      "proxyProtocol" = mkProxyProtocol res."proxyProtocol";
    }
    // {
    }
    // optionalAttrs (res."rateLimit" != null) { "rateLimit" = mkRateLimit res."rateLimit"; }
    // {
    }
    // optionalAttrs (res."requestBuffer" != null) {
      "requestBuffer" = mkRequestBuffer res."requestBuffer";
    }
    // {
    }
    // optionalAttrs (res."responseOverride" != [ ]) {
      "responseOverride" = map mkResponseOverride res."responseOverride";
    }
    // {
    }
    // optionalAttrs (res."retry" != null) { "retry" = mkRetry res."retry"; }
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
    // optionalAttrs (res."telemetry" != null) { "telemetry" = mkTelemetry res."telemetry"; }
    // {
    }
    // optionalAttrs (res."timeout" != null) { "timeout" = mkTimeout res."timeout"; }
    // {
    }
    // optionalAttrs res."useClientProtocol" { inherit (res) "useClientProtocol"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkBackendTrafficPolicy cfg."backendtrafficpolicies");
in
{
  options.openkrill.apps."envoy-gateway" = {
    "backendtrafficpolicies" = mkOption {
      type = types.attrsOf BackendtrafficpoliciesModule;
      default = { };
      description = "BackendTrafficPolicy CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."envoy-gateway".content = allResources;
  };
}
