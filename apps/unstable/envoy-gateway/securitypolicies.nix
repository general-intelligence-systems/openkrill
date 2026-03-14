# Auto-generated openkrill module fragment for envoy-gateway
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."envoy-gateway";
  compact = filterAttrs (_: v: v != null);
  ApiKeyAuthCredentialRefModule = types.submodule {
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
  mkApiKeyAuthCredentialRef =
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
  ApiKeyAuthExtractFromModule = types.submodule {
    options = {
      "cookies" = mkOption {
        description = "Cookies is the names of the cookie to fetch the key from.\nIf multiple cookies are specified, envoy will look for the api key in the order of the list.\nThis field is optional, but only one of headers, params or cookies is supposed to be specified.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "headers" = mkOption {
        description = "Headers is the names of the header to fetch the key from.\nIf multiple headers are specified, envoy will look for the api key in the order of the list.\nThis field is optional, but only one of headers, params or cookies is supposed to be specified.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "params" = mkOption {
        description = "Params is the names of the query parameter to fetch the key from.\nIf multiple params are specified, envoy will look for the api key in the order of the list.\nThis field is optional, but only one of headers, params or cookies is supposed to be specified.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkApiKeyAuthExtractFrom =
    res:
    {
    }
    // optionalAttrs (res."cookies" != [ ]) { inherit (res) "cookies"; }
    // {
    }
    // optionalAttrs (res."headers" != [ ]) { inherit (res) "headers"; }
    // {
    }
    // optionalAttrs (res."params" != [ ]) { inherit (res) "params"; }
    // {
    };
  ApiKeyAuthModule = types.submodule {
    options = {
      "credentialRefs" = mkOption {
        description = "CredentialRefs is the Kubernetes secret which contains the API keys.\nThis is an Opaque secret.\nEach API key is stored in the key representing the client id.\nIf the secrets have a key for a duplicated client, the first one will be used.";
        type = (types.listOf ApiKeyAuthCredentialRefModule);
      };
      "extractFrom" = mkOption {
        description = "ExtractFrom is where to fetch the key from the coming request.\nThe value from the first source that has a key will be used.";
        type = (types.listOf ApiKeyAuthExtractFromModule);
      };
      "forwardClientIDHeader" = mkOption {
        description = "ForwardClientIDHeader is the name of the header to forward the client identity to the backend\nservice. The header will be added to the request with the client id as the value.";
        type = (types.nullOr types.str);
        default = null;
      };
      "sanitize" = mkOption {
        description = "Sanitize indicates whether to remove the API key from the request before forwarding it to the backend service.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkApiKeyAuth =
    res:
    {
      "credentialRefs" = map mkApiKeyAuthCredentialRef res."credentialRefs";
      "extractFrom" = map mkApiKeyAuthExtractFrom res."extractFrom";
    }
    // optionalAttrs (res."forwardClientIDHeader" != null) { inherit (res) "forwardClientIDHeader"; }
    // {
    }
    // optionalAttrs res."sanitize" { inherit (res) "sanitize"; }
    // {
    };
  AuthorizationModule = types.submodule {
    options = {
      "defaultAction" = mkOption {
        description = "DefaultAction defines the default action to be taken if no rules match.\nIf not specified, the default action is Deny.";
        type = (
          types.nullOr (
            types.enum [
              "Allow"
              "Deny"
            ]
          )
        );
        default = null;
      };
      "rules" = mkOption {
        description = "Rules defines a list of authorization rules.\nThese rules are evaluated in order, the first matching rule will be applied,\nand the rest will be skipped.\n\nFor example, if there are two rules: the first rule allows the request\nand the second rule denies it, when a request matches both rules, it will be allowed.";
        type = (types.listOf AuthorizationRuleModule);
        default = [ ];
      };
    };
  };
  mkAuthorization =
    res:
    {
    }
    // optionalAttrs (res."defaultAction" != null) { inherit (res) "defaultAction"; }
    // {
    }
    // optionalAttrs (res."rules" != [ ]) { "rules" = map mkAuthorizationRule res."rules"; }
    // {
    };
  AuthorizationRuleModule = types.submodule {
    options = {
      "action" = mkOption {
        description = "Action defines the action to be taken if the rule matches.";
        type = (
          types.enum [
            "Allow"
            "Deny"
          ]
        );
      };
      "name" = mkOption {
        description = "Name is a user-friendly name for the rule.\nIf not specified, Envoy Gateway will generate a unique name for the rule.";
        type = (types.nullOr types.str);
        default = null;
      };
      "operation" = mkOption {
        description = "Operation specifies the operation of a request, such as HTTP methods.\nIf not specified, all operations are matched on.";
        type = (types.nullOr AuthorizationRuleOperationModule);
        default = null;
      };
      "principal" = mkOption {
        description = "Principal specifies the client identity of a request.\nIf there are multiple principal types, all principals must match for the rule to match.\nFor example, if there are two principals: one for client IP and one for JWT claim,\nthe rule will match only if both the client IP and the JWT claim match.";
        type = AuthorizationRulePrincipalModule;
      };
    };
  };
  mkAuthorizationRule =
    res:
    {
      inherit (res) "action";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."operation" != null) {
      "operation" = mkAuthorizationRuleOperation res."operation";
    }
    // {
      "principal" = mkAuthorizationRulePrincipal res."principal";
    };
  AuthorizationRuleOperationModule = types.submodule {
    options = {
      "methods" = mkOption {
        description = "Methods are the HTTP methods of the request.\nIf multiple methods are specified, all specified methods are allowed or denied, based on the action of the rule.";
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
            ]
          )
        );
      };
    };
  };
  mkAuthorizationRuleOperation = res: {
    inherit (res) "methods";
  };
  AuthorizationRulePrincipalHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the HTTP header.\nThe header name is case-insensitive unless PreserveHeaderCase is set to true.\nFor example, \"Foo\" and \"foo\" are considered the same header.";
        type = types.str;
      };
      "values" = mkOption {
        description = "Values are the values that the header must match.\nIf multiple values are specified, the rule will match if any of the values match.";
        type = (types.listOf types.str);
      };
    };
  };
  mkAuthorizationRulePrincipalHeader = res: {
    inherit (res) "name";
    inherit (res) "values";
  };
  AuthorizationRulePrincipalJwtClaimModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the name of the claim.\nIf it is a nested claim, use a dot (.) separated string as the name to\nrepresent the full path to the claim.\nFor example, if the claim is in the \"department\" field in the \"organization\" field,\nthe name should be \"organization.department\".";
        type = types.str;
      };
      "valueType" = mkOption {
        description = "ValueType is the type of the claim value.\nOnly String and StringArray types are supported for now.";
        type = (
          types.nullOr (
            types.enum [
              "String"
              "StringArray"
            ]
          )
        );
        default = "String";
      };
      "values" = mkOption {
        description = "Values are the values that the claim must match.\nIf the claim is a string type, the specified value must match exactly.\nIf the claim is a string array type, the specified value must match one of the values in the array.\nIf multiple values are specified, one of the values must match for the rule to match.";
        type = (types.listOf types.str);
      };
    };
  };
  mkAuthorizationRulePrincipalJwtClaim =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."valueType" != null) { inherit (res) "valueType"; }
    // {
      inherit (res) "values";
    };
  AuthorizationRulePrincipalJwtModule = types.submodule {
    options = {
      "claims" = mkOption {
        description = "Claims are the claims in a JWT token.\n\nIf multiple claims are specified, all claims must match for the rule to match.\nFor example, if there are two claims: one for the audience and one for the issuer,\nthe rule will match only if both the audience and the issuer match.";
        type = (types.listOf AuthorizationRulePrincipalJwtClaimModule);
        default = [ ];
      };
      "provider" = mkOption {
        description = "Provider is the name of the JWT provider that used to verify the JWT token.\nIn order to use JWT claims for authorization, you must configure the JWT\nauthentication with the same provider in the same `SecurityPolicy`.";
        type = types.str;
      };
      "scopes" = mkOption {
        description = "Scopes are a special type of claim in a JWT token that represents the permissions of the client.\n\nThe value of the scopes field should be a space delimited string that is expected in the scope parameter,\nas defined in RFC 6749: https://datatracker.ietf.org/doc/html/rfc6749#page-23.\n\nIf multiple scopes are specified, all scopes must match for the rule to match.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkAuthorizationRulePrincipalJwt =
    res:
    {
    }
    // optionalAttrs (res."claims" != [ ]) {
      "claims" = map mkAuthorizationRulePrincipalJwtClaim res."claims";
    }
    // {
      inherit (res) "provider";
    }
    // optionalAttrs (res."scopes" != [ ]) { inherit (res) "scopes"; }
    // {
    };
  AuthorizationRulePrincipalModule = types.submodule {
    options = {
      "clientCIDRs" = mkOption {
        description = "ClientCIDRs are the IP CIDR ranges of the client.\nValid examples are \"192.168.1.0/24\" or \"2001:db8::/64\"\n\nIf multiple CIDR ranges are specified, one of the CIDR ranges must match\nthe client IP for the rule to match.\n\nThe client IP is inferred from the X-Forwarded-For header, a custom header,\nor the proxy protocol.\nYou can use the `ClientIPDetection` or the `ProxyProtocol` field in\nthe `ClientTrafficPolicy` to configure how the client IP is detected.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "headers" = mkOption {
        description = "Headers authorize the request based on user identity extracted from custom headers.\nIf multiple headers are specified, all headers must match for the rule to match.";
        type = (types.listOf AuthorizationRulePrincipalHeaderModule);
        default = [ ];
      };
      "jwt" = mkOption {
        description = "JWT authorize the request based on the JWT claims and scopes.\nNote: in order to use JWT claims for authorization, you must configure the\nJWT authentication in the same `SecurityPolicy`.";
        type = (types.nullOr AuthorizationRulePrincipalJwtModule);
        default = null;
      };
    };
  };
  mkAuthorizationRulePrincipal =
    res:
    {
    }
    // optionalAttrs (res."clientCIDRs" != [ ]) { inherit (res) "clientCIDRs"; }
    // {
    }
    // optionalAttrs (res."headers" != [ ]) {
      "headers" = map mkAuthorizationRulePrincipalHeader res."headers";
    }
    // {
    }
    // optionalAttrs (res."jwt" != null) { "jwt" = mkAuthorizationRulePrincipalJwt res."jwt"; }
    // {
    };
  BasicAuthModule = types.submodule {
    options = {
      "forwardUsernameHeader" = mkOption {
        description = "This field specifies the header name to forward a successfully authenticated user to\nthe backend. The header will be added to the request with the username as the value.\n\nIf it is not specified, the username will not be forwarded.";
        type = (types.nullOr types.str);
        default = null;
      };
      "users" = mkOption {
        description = "The Kubernetes secret which contains the username-password pairs in\nhtpasswd format, used to verify user credentials in the \"Authorization\"\nheader.\n\nThis is an Opaque secret. The username-password pairs should be stored in\nthe key \".htpasswd\". As the key name indicates, the value needs to be the\nhtpasswd format, for example: \"user1:{SHA}hashed_user1_password\".\nRight now, only SHA hash algorithm is supported.\nReference to https://httpd.apache.org/docs/2.4/programs/htpasswd.html\nfor more details.\n\nNote: The secret must be in the same namespace as the SecurityPolicy.";
        type = BasicAuthUsersModule;
      };
    };
  };
  mkBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."forwardUsernameHeader" != null) { inherit (res) "forwardUsernameHeader"; }
    // {
      "users" = mkBasicAuthUsers res."users";
    };
  BasicAuthUsersModule = types.submodule {
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
  mkBasicAuthUsers =
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
  CorsModule = types.submodule {
    options = {
      "allowCredentials" = mkOption {
        description = "AllowCredentials indicates whether a request can include user credentials\nlike cookies, authentication headers, or TLS client certificates.\nIt specifies the value in the Access-Control-Allow-Credentials CORS response header.";
        type = types.bool;
        default = false;
      };
      "allowHeaders" = mkOption {
        description = "AllowHeaders defines the headers that are allowed to be sent with requests.\nIt specifies the allowed headers in the Access-Control-Allow-Headers CORS response header..\nThe value \"*\" allows any header to be sent.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "allowMethods" = mkOption {
        description = "AllowMethods defines the methods that are allowed to make requests.\nIt specifies the allowed methods in the Access-Control-Allow-Methods CORS response header..\nThe value \"*\" allows any method to be used.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "allowOrigins" = mkOption {
        description = "AllowOrigins defines the origins that are allowed to make requests.\nIt specifies the allowed origins in the Access-Control-Allow-Origin CORS response header.\nThe value \"*\" allows any origin to make requests.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "exposeHeaders" = mkOption {
        description = "ExposeHeaders defines which response headers should be made accessible to\nscripts running in the browser.\nIt specifies the headers in the Access-Control-Expose-Headers CORS response header..\nThe value \"*\" allows any header to be exposed.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "maxAge" = mkOption {
        description = "MaxAge defines how long the results of a preflight request can be cached.\nIt specifies the value in the Access-Control-Max-Age CORS response header..";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkCors =
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
  ExtAuthBodyToExtAuthModule = types.submodule {
    options = {
      "maxRequestBytes" = mkOption {
        description = "MaxRequestBytes is the maximum size of a message body that the filter will hold in memory.\nEnvoy will return HTTP 413 and will not initiate the authorization process when buffer\nreaches the number set in this field.\nNote that this setting will have precedence over failOpen mode.";
        type = types.int;
      };
    };
  };
  mkExtAuthBodyToExtAuth = res: {
    inherit (res) "maxRequestBytes";
  };
  ExtAuthGrpcBackendRefModule = types.submodule {
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
  mkExtAuthGrpcBackendRef =
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
  ExtAuthGrpcBackendSettingsCircuitBreakerModule = types.submodule {
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
        type = (types.nullOr ExtAuthGrpcBackendSettingsCircuitBreakerPerEndpointModule);
        default = null;
      };
    };
  };
  mkExtAuthGrpcBackendSettingsCircuitBreaker =
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
      "perEndpoint" = mkExtAuthGrpcBackendSettingsCircuitBreakerPerEndpoint res."perEndpoint";
    }
    // {
    };
  ExtAuthGrpcBackendSettingsCircuitBreakerPerEndpointModule = types.submodule {
    options = {
      "maxConnections" = mkOption {
        description = "MaxConnections configures the maximum number of connections that Envoy will establish per-endpoint to the referenced backend defined within a xRoute rule.";
        type = (types.nullOr types.int);
        default = 1024;
      };
    };
  };
  mkExtAuthGrpcBackendSettingsCircuitBreakerPerEndpoint =
    res:
    {
    }
    // optionalAttrs (res."maxConnections" != null) { inherit (res) "maxConnections"; }
    // {
    };
  ExtAuthGrpcBackendSettingsConnectionModule = types.submodule {
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
  mkExtAuthGrpcBackendSettingsConnection =
    res:
    {
    }
    // optionalAttrs (res."bufferLimit" != null) { inherit (res) "bufferLimit"; }
    // {
    }
    // optionalAttrs (res."socketBufferLimit" != null) { inherit (res) "socketBufferLimit"; }
    // {
    };
  ExtAuthGrpcBackendSettingsDnsModule = types.submodule {
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
  mkExtAuthGrpcBackendSettingsDns =
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
  ExtAuthGrpcBackendSettingsHealthCheckActiveGrpcModule = types.submodule {
    options = {
      "service" = mkOption {
        description = "Service to send in the health check request.\nIf this is not specified, then the health check request applies to the entire\nserver and not to a specific service.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkExtAuthGrpcBackendSettingsHealthCheckActiveGrpc =
    res:
    {
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  ExtAuthGrpcBackendSettingsHealthCheckActiveHttpExpectedResponseModule = types.submodule {
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
  mkExtAuthGrpcBackendSettingsHealthCheckActiveHttpExpectedResponse =
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
  ExtAuthGrpcBackendSettingsHealthCheckActiveHttpModule = types.submodule {
    options = {
      "expectedResponse" = mkOption {
        description = "ExpectedResponse defines a list of HTTP expected responses to match.";
        type = (types.nullOr ExtAuthGrpcBackendSettingsHealthCheckActiveHttpExpectedResponseModule);
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
  mkExtAuthGrpcBackendSettingsHealthCheckActiveHttp =
    res:
    {
    }
    // optionalAttrs (res."expectedResponse" != null) {
      "expectedResponse" =
        mkExtAuthGrpcBackendSettingsHealthCheckActiveHttpExpectedResponse
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
  ExtAuthGrpcBackendSettingsHealthCheckActiveModule = types.submodule {
    options = {
      "grpc" = mkOption {
        description = "GRPC defines the configuration of the GRPC health checker.\nIt's optional, and can only be used if the specified type is GRPC.";
        type = (types.nullOr ExtAuthGrpcBackendSettingsHealthCheckActiveGrpcModule);
        default = null;
      };
      "healthyThreshold" = mkOption {
        description = "HealthyThreshold defines the number of healthy health checks required before a backend host is marked healthy.";
        type = (types.nullOr types.int);
        default = 1;
      };
      "http" = mkOption {
        description = "HTTP defines the configuration of http health checker.\nIt's required while the health checker type is HTTP.";
        type = (types.nullOr ExtAuthGrpcBackendSettingsHealthCheckActiveHttpModule);
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
        type = (types.nullOr ExtAuthGrpcBackendSettingsHealthCheckActiveTcpModule);
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
  mkExtAuthGrpcBackendSettingsHealthCheckActive =
    res:
    {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkExtAuthGrpcBackendSettingsHealthCheckActiveGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."healthyThreshold" != null) { inherit (res) "healthyThreshold"; }
    // {
    }
    // optionalAttrs (res."http" != null) {
      "http" = mkExtAuthGrpcBackendSettingsHealthCheckActiveHttp res."http";
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
      "tcp" = mkExtAuthGrpcBackendSettingsHealthCheckActiveTcp res."tcp";
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
  ExtAuthGrpcBackendSettingsHealthCheckActiveTcpModule = types.submodule {
    options = {
      "receive" = mkOption {
        description = "Receive defines the expected response payload.";
        type = (types.nullOr ExtAuthGrpcBackendSettingsHealthCheckActiveTcpReceiveModule);
        default = null;
      };
      "send" = mkOption {
        description = "Send defines the request payload.";
        type = (types.nullOr ExtAuthGrpcBackendSettingsHealthCheckActiveTcpSendModule);
        default = null;
      };
    };
  };
  mkExtAuthGrpcBackendSettingsHealthCheckActiveTcp =
    res:
    {
    }
    // optionalAttrs (res."receive" != null) {
      "receive" = mkExtAuthGrpcBackendSettingsHealthCheckActiveTcpReceive res."receive";
    }
    // {
    }
    // optionalAttrs (res."send" != null) {
      "send" = mkExtAuthGrpcBackendSettingsHealthCheckActiveTcpSend res."send";
    }
    // {
    };
  ExtAuthGrpcBackendSettingsHealthCheckActiveTcpReceiveModule = types.submodule {
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
  mkExtAuthGrpcBackendSettingsHealthCheckActiveTcpReceive =
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
  ExtAuthGrpcBackendSettingsHealthCheckActiveTcpSendModule = types.submodule {
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
  mkExtAuthGrpcBackendSettingsHealthCheckActiveTcpSend =
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
  ExtAuthGrpcBackendSettingsHealthCheckModule = types.submodule {
    options = {
      "active" = mkOption {
        description = "Active health check configuration";
        type = (types.nullOr ExtAuthGrpcBackendSettingsHealthCheckActiveModule);
        default = null;
      };
      "panicThreshold" = mkOption {
        description = "When number of unhealthy endpoints for a backend reaches this threshold\nEnvoy will disregard health status and balance across all endpoints.\nIt's designed to prevent a situation in which host failures cascade throughout the cluster\nas load increases. If not set, the default value is 50%. To disable panic mode, set value to `0`.";
        type = (types.nullOr types.int);
        default = null;
      };
      "passive" = mkOption {
        description = "Passive passive check configuration";
        type = (types.nullOr ExtAuthGrpcBackendSettingsHealthCheckPassiveModule);
        default = null;
      };
    };
  };
  mkExtAuthGrpcBackendSettingsHealthCheck =
    res:
    {
    }
    // optionalAttrs (res."active" != null) {
      "active" = mkExtAuthGrpcBackendSettingsHealthCheckActive res."active";
    }
    // {
    }
    // optionalAttrs (res."panicThreshold" != null) { inherit (res) "panicThreshold"; }
    // {
    }
    // optionalAttrs (res."passive" != null) {
      "passive" = mkExtAuthGrpcBackendSettingsHealthCheckPassive res."passive";
    }
    // {
    };
  ExtAuthGrpcBackendSettingsHealthCheckPassiveModule = types.submodule {
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
  mkExtAuthGrpcBackendSettingsHealthCheckPassive =
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
  ExtAuthGrpcBackendSettingsHttp2Module = types.submodule {
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
  mkExtAuthGrpcBackendSettingsHttp2 =
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
  ExtAuthGrpcBackendSettingsLoadBalancerConsistentHashCookieModule = types.submodule {
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
  mkExtAuthGrpcBackendSettingsLoadBalancerConsistentHashCookie =
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
  ExtAuthGrpcBackendSettingsLoadBalancerConsistentHashHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the header to hash.";
        type = types.str;
      };
    };
  };
  mkExtAuthGrpcBackendSettingsLoadBalancerConsistentHashHeader = res: {
    inherit (res) "name";
  };
  ExtAuthGrpcBackendSettingsLoadBalancerConsistentHashModule = types.submodule {
    options = {
      "cookie" = mkOption {
        description = "Cookie configures the cookie hash policy when the consistent hash type is set to Cookie.";
        type = (types.nullOr ExtAuthGrpcBackendSettingsLoadBalancerConsistentHashCookieModule);
        default = null;
      };
      "header" = mkOption {
        description = "Header configures the header hash policy when the consistent hash type is set to Header.";
        type = (types.nullOr ExtAuthGrpcBackendSettingsLoadBalancerConsistentHashHeaderModule);
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
  mkExtAuthGrpcBackendSettingsLoadBalancerConsistentHash =
    res:
    {
    }
    // optionalAttrs (res."cookie" != null) {
      "cookie" = mkExtAuthGrpcBackendSettingsLoadBalancerConsistentHashCookie res."cookie";
    }
    // {
    }
    // optionalAttrs (res."header" != null) {
      "header" = mkExtAuthGrpcBackendSettingsLoadBalancerConsistentHashHeader res."header";
    }
    // {
    }
    // optionalAttrs (res."tableSize" != null) { inherit (res) "tableSize"; }
    // {
      inherit (res) "type";
    };
  ExtAuthGrpcBackendSettingsLoadBalancerEndpointOverrideExtractFromModule = types.submodule {
    options = {
      "header" = mkOption {
        description = "Header defines the header to get the override endpoint addresses.\nThe header value must specify at least one endpoint in `IP:Port` format or multiple endpoints in `IP:Port,IP:Port,...` format.\nFor example `10.0.0.5:8080` or `[2600:4040:5204::1574:24ae]:80`.\nThe IPv6 address is enclosed in square brackets.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkExtAuthGrpcBackendSettingsLoadBalancerEndpointOverrideExtractFrom =
    res:
    {
    }
    // optionalAttrs (res."header" != null) { inherit (res) "header"; }
    // {
    };
  ExtAuthGrpcBackendSettingsLoadBalancerEndpointOverrideModule = types.submodule {
    options = {
      "extractFrom" = mkOption {
        description = "ExtractFrom defines the sources to extract endpoint override information from.";
        type = (types.listOf ExtAuthGrpcBackendSettingsLoadBalancerEndpointOverrideExtractFromModule);
      };
    };
  };
  mkExtAuthGrpcBackendSettingsLoadBalancerEndpointOverride = res: {
    "extractFrom" =
      map mkExtAuthGrpcBackendSettingsLoadBalancerEndpointOverrideExtractFrom
        res."extractFrom";
  };
  ExtAuthGrpcBackendSettingsLoadBalancerModule = types.submodule {
    options = {
      "consistentHash" = mkOption {
        description = "ConsistentHash defines the configuration when the load balancer type is\nset to ConsistentHash";
        type = (types.nullOr ExtAuthGrpcBackendSettingsLoadBalancerConsistentHashModule);
        default = null;
      };
      "endpointOverride" = mkOption {
        description = "EndpointOverride defines the configuration for endpoint override.\nWhen specified, the load balancer will attempt to route requests to endpoints\nbased on the override information extracted from request headers or metadata.\n If the override endpoints are not available, the configured load balancer policy will be used as fallback.";
        type = (types.nullOr ExtAuthGrpcBackendSettingsLoadBalancerEndpointOverrideModule);
        default = null;
      };
      "slowStart" = mkOption {
        description = "SlowStart defines the configuration related to the slow start load balancer policy.\nIf set, during slow start window, traffic sent to the newly added hosts will gradually increase.\nCurrently this is only supported for RoundRobin and LeastRequest load balancers";
        type = (types.nullOr ExtAuthGrpcBackendSettingsLoadBalancerSlowStartModule);
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
        type = (types.nullOr ExtAuthGrpcBackendSettingsLoadBalancerZoneAwareModule);
        default = null;
      };
    };
  };
  mkExtAuthGrpcBackendSettingsLoadBalancer =
    res:
    {
    }
    // optionalAttrs (res."consistentHash" != null) {
      "consistentHash" = mkExtAuthGrpcBackendSettingsLoadBalancerConsistentHash res."consistentHash";
    }
    // {
    }
    // optionalAttrs (res."endpointOverride" != null) {
      "endpointOverride" =
        mkExtAuthGrpcBackendSettingsLoadBalancerEndpointOverride
          res."endpointOverride";
    }
    // {
    }
    // optionalAttrs (res."slowStart" != null) {
      "slowStart" = mkExtAuthGrpcBackendSettingsLoadBalancerSlowStart res."slowStart";
    }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."zoneAware" != null) {
      "zoneAware" = mkExtAuthGrpcBackendSettingsLoadBalancerZoneAware res."zoneAware";
    }
    // {
    };
  ExtAuthGrpcBackendSettingsLoadBalancerSlowStartModule = types.submodule {
    options = {
      "window" = mkOption {
        description = "Window defines the duration of the warm up period for newly added host.\nDuring slow start window, traffic sent to the newly added hosts will gradually increase.\nCurrently only supports linear growth of traffic. For additional details,\nsee https://www.envoyproxy.io/docs/envoy/latest/api-v3/config/cluster/v3/cluster.proto#config-cluster-v3-cluster-slowstartconfig";
        type = types.str;
      };
    };
  };
  mkExtAuthGrpcBackendSettingsLoadBalancerSlowStart = res: {
    inherit (res) "window";
  };
  ExtAuthGrpcBackendSettingsLoadBalancerZoneAwareModule = types.submodule {
    options = {
      "preferLocal" = mkOption {
        description = "PreferLocalZone configures zone-aware routing to prefer sending traffic to the local locality zone.";
        type = (types.nullOr ExtAuthGrpcBackendSettingsLoadBalancerZoneAwarePreferLocalModule);
        default = null;
      };
    };
  };
  mkExtAuthGrpcBackendSettingsLoadBalancerZoneAware =
    res:
    {
    }
    // optionalAttrs (res."preferLocal" != null) {
      "preferLocal" = mkExtAuthGrpcBackendSettingsLoadBalancerZoneAwarePreferLocal res."preferLocal";
    }
    // {
    };
  ExtAuthGrpcBackendSettingsLoadBalancerZoneAwarePreferLocalForceModule = types.submodule {
    options = {
      "minEndpointsInZoneThreshold" = mkOption {
        description = "MinEndpointsInZoneThreshold is the minimum number of upstream endpoints in the local zone required to honor the forceLocalZone\noverride. This is useful for protecting zones with fewer endpoints.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkExtAuthGrpcBackendSettingsLoadBalancerZoneAwarePreferLocalForce =
    res:
    {
    }
    // optionalAttrs (res."minEndpointsInZoneThreshold" != null) {
      inherit (res) "minEndpointsInZoneThreshold";
    }
    // {
    };
  ExtAuthGrpcBackendSettingsLoadBalancerZoneAwarePreferLocalModule = types.submodule {
    options = {
      "force" = mkOption {
        description = "ForceLocalZone defines override configuration for forcing all traffic to stay within the local zone instead of the default behavior\nwhich maintains equal distribution among upstream endpoints while sending as much traffic as possible locally.";
        type = (types.nullOr ExtAuthGrpcBackendSettingsLoadBalancerZoneAwarePreferLocalForceModule);
        default = null;
      };
      "minEndpointsThreshold" = mkOption {
        description = "MinEndpointsThreshold is the minimum number of total upstream endpoints across all zones required to enable zone-aware routing.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkExtAuthGrpcBackendSettingsLoadBalancerZoneAwarePreferLocal =
    res:
    {
    }
    // optionalAttrs (res."force" != null) {
      "force" = mkExtAuthGrpcBackendSettingsLoadBalancerZoneAwarePreferLocalForce res."force";
    }
    // {
    }
    // optionalAttrs (res."minEndpointsThreshold" != null) { inherit (res) "minEndpointsThreshold"; }
    // {
    };
  ExtAuthGrpcBackendSettingsModule = types.submodule {
    options = {
      "circuitBreaker" = mkOption {
        description = "Circuit Breaker settings for the upstream connections and requests.\nIf not set, circuit breakers will be enabled with the default thresholds";
        type = (types.nullOr ExtAuthGrpcBackendSettingsCircuitBreakerModule);
        default = null;
      };
      "connection" = mkOption {
        description = "Connection includes backend connection settings.";
        type = (types.nullOr ExtAuthGrpcBackendSettingsConnectionModule);
        default = null;
      };
      "dns" = mkOption {
        description = "DNS includes dns resolution settings.";
        type = (types.nullOr ExtAuthGrpcBackendSettingsDnsModule);
        default = null;
      };
      "healthCheck" = mkOption {
        description = "HealthCheck allows gateway to perform active health checking on backends.";
        type = (types.nullOr ExtAuthGrpcBackendSettingsHealthCheckModule);
        default = null;
      };
      "http2" = mkOption {
        description = "HTTP2 provides HTTP/2 configuration for backend connections.";
        type = (types.nullOr ExtAuthGrpcBackendSettingsHttp2Module);
        default = null;
      };
      "loadBalancer" = mkOption {
        description = "LoadBalancer policy to apply when routing traffic from the gateway to\nthe backend endpoints. Defaults to `LeastRequest`.";
        type = (types.nullOr ExtAuthGrpcBackendSettingsLoadBalancerModule);
        default = null;
      };
      "proxyProtocol" = mkOption {
        description = "ProxyProtocol enables the Proxy Protocol when communicating with the backend.";
        type = (types.nullOr ExtAuthGrpcBackendSettingsProxyProtocolModule);
        default = null;
      };
      "retry" = mkOption {
        description = "Retry provides more advanced usage, allowing users to customize the number of retries, retry fallback strategy, and retry triggering conditions.\nIf not set, retry will be disabled.";
        type = (types.nullOr ExtAuthGrpcBackendSettingsRetryModule);
        default = null;
      };
      "tcpKeepalive" = mkOption {
        description = "TcpKeepalive settings associated with the upstream client connection.\nDisabled by default.";
        type = (types.nullOr ExtAuthGrpcBackendSettingsTcpKeepaliveModule);
        default = null;
      };
      "timeout" = mkOption {
        description = "Timeout settings for the backend connections.";
        type = (types.nullOr ExtAuthGrpcBackendSettingsTimeoutModule);
        default = null;
      };
    };
  };
  mkExtAuthGrpcBackendSettings =
    res:
    {
    }
    // optionalAttrs (res."circuitBreaker" != null) {
      "circuitBreaker" = mkExtAuthGrpcBackendSettingsCircuitBreaker res."circuitBreaker";
    }
    // {
    }
    // optionalAttrs (res."connection" != null) {
      "connection" = mkExtAuthGrpcBackendSettingsConnection res."connection";
    }
    // {
    }
    // optionalAttrs (res."dns" != null) { "dns" = mkExtAuthGrpcBackendSettingsDns res."dns"; }
    // {
    }
    // optionalAttrs (res."healthCheck" != null) {
      "healthCheck" = mkExtAuthGrpcBackendSettingsHealthCheck res."healthCheck";
    }
    // {
    }
    // optionalAttrs (res."http2" != null) { "http2" = mkExtAuthGrpcBackendSettingsHttp2 res."http2"; }
    // {
    }
    // optionalAttrs (res."loadBalancer" != null) {
      "loadBalancer" = mkExtAuthGrpcBackendSettingsLoadBalancer res."loadBalancer";
    }
    // {
    }
    // optionalAttrs (res."proxyProtocol" != null) {
      "proxyProtocol" = mkExtAuthGrpcBackendSettingsProxyProtocol res."proxyProtocol";
    }
    // {
    }
    // optionalAttrs (res."retry" != null) { "retry" = mkExtAuthGrpcBackendSettingsRetry res."retry"; }
    // {
    }
    // optionalAttrs (res."tcpKeepalive" != null) {
      "tcpKeepalive" = mkExtAuthGrpcBackendSettingsTcpKeepalive res."tcpKeepalive";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) {
      "timeout" = mkExtAuthGrpcBackendSettingsTimeout res."timeout";
    }
    // {
    };
  ExtAuthGrpcBackendSettingsProxyProtocolModule = types.submodule {
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
  mkExtAuthGrpcBackendSettingsProxyProtocol = res: {
    inherit (res) "version";
  };
  ExtAuthGrpcBackendSettingsRetryModule = types.submodule {
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
        type = (types.nullOr ExtAuthGrpcBackendSettingsRetryPerRetryModule);
        default = null;
      };
      "retryOn" = mkOption {
        description = "RetryOn specifies the retry trigger condition.\n\nIf not specified, the default is to retry on connect-failure,refused-stream,unavailable,cancelled,retriable-status-codes(503).";
        type = (types.nullOr ExtAuthGrpcBackendSettingsRetryRetryOnModule);
        default = null;
      };
    };
  };
  mkExtAuthGrpcBackendSettingsRetry =
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
      "perRetry" = mkExtAuthGrpcBackendSettingsRetryPerRetry res."perRetry";
    }
    // {
    }
    // optionalAttrs (res."retryOn" != null) {
      "retryOn" = mkExtAuthGrpcBackendSettingsRetryRetryOn res."retryOn";
    }
    // {
    };
  ExtAuthGrpcBackendSettingsRetryPerRetryBackOffModule = types.submodule {
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
  mkExtAuthGrpcBackendSettingsRetryPerRetryBackOff =
    res:
    {
    }
    // optionalAttrs (res."baseInterval" != null) { inherit (res) "baseInterval"; }
    // {
    }
    // optionalAttrs (res."maxInterval" != null) { inherit (res) "maxInterval"; }
    // {
    };
  ExtAuthGrpcBackendSettingsRetryPerRetryModule = types.submodule {
    options = {
      "backOff" = mkOption {
        description = "Backoff is the backoff policy to be applied per retry attempt. gateway uses a fully jittered exponential\nback-off algorithm for retries. For additional details,\nsee https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/router_filter#config-http-filters-router-x-envoy-max-retries";
        type = (types.nullOr ExtAuthGrpcBackendSettingsRetryPerRetryBackOffModule);
        default = null;
      };
      "timeout" = mkOption {
        description = "Timeout is the timeout per retry attempt.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkExtAuthGrpcBackendSettingsRetryPerRetry =
    res:
    {
    }
    // optionalAttrs (res."backOff" != null) {
      "backOff" = mkExtAuthGrpcBackendSettingsRetryPerRetryBackOff res."backOff";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    };
  ExtAuthGrpcBackendSettingsRetryRetryOnModule = types.submodule {
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
  mkExtAuthGrpcBackendSettingsRetryRetryOn =
    res:
    {
    }
    // optionalAttrs (res."httpStatusCodes" != [ ]) { inherit (res) "httpStatusCodes"; }
    // {
    }
    // optionalAttrs (res."triggers" != [ ]) { inherit (res) "triggers"; }
    // {
    };
  ExtAuthGrpcBackendSettingsTcpKeepaliveModule = types.submodule {
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
  mkExtAuthGrpcBackendSettingsTcpKeepalive =
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
  ExtAuthGrpcBackendSettingsTimeoutHttpModule = types.submodule {
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
  mkExtAuthGrpcBackendSettingsTimeoutHttp =
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
  ExtAuthGrpcBackendSettingsTimeoutModule = types.submodule {
    options = {
      "http" = mkOption {
        description = "Timeout settings for HTTP.";
        type = (types.nullOr ExtAuthGrpcBackendSettingsTimeoutHttpModule);
        default = null;
      };
      "tcp" = mkOption {
        description = "Timeout settings for TCP.";
        type = (types.nullOr ExtAuthGrpcBackendSettingsTimeoutTcpModule);
        default = null;
      };
    };
  };
  mkExtAuthGrpcBackendSettingsTimeout =
    res:
    {
    }
    // optionalAttrs (res."http" != null) {
      "http" = mkExtAuthGrpcBackendSettingsTimeoutHttp res."http";
    }
    // {
    }
    // optionalAttrs (res."tcp" != null) { "tcp" = mkExtAuthGrpcBackendSettingsTimeoutTcp res."tcp"; }
    // {
    };
  ExtAuthGrpcBackendSettingsTimeoutTcpModule = types.submodule {
    options = {
      "connectTimeout" = mkOption {
        description = "The timeout for network connection establishment, including TCP and TLS handshakes.\nDefault: 10 seconds.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkExtAuthGrpcBackendSettingsTimeoutTcp =
    res:
    {
    }
    // optionalAttrs (res."connectTimeout" != null) { inherit (res) "connectTimeout"; }
    // {
    };
  ExtAuthGrpcModule = types.submodule {
    options = {
      "backendRef" = mkOption {
        description = "BackendRef references a Kubernetes object that represents the\nbackend server to which the authorization request will be sent.\n\nDeprecated: Use BackendRefs instead.";
        type = (types.nullOr ExtAuthGrpcBackendRefModule);
        default = null;
      };
      "backendRefs" = mkOption {
        description = "BackendRefs references a Kubernetes object that represents the\nbackend server to which the authorization request will be sent.";
        type = (types.listOf ExtAuthGrpcBackendRefModule);
        default = [ ];
      };
      "backendSettings" = mkOption {
        description = "BackendSettings holds configuration for managing the connection\nto the backend.";
        type = (types.nullOr ExtAuthGrpcBackendSettingsModule);
        default = null;
      };
    };
  };
  mkExtAuthGrpc =
    res:
    {
    }
    // optionalAttrs (res."backendRef" != null) {
      "backendRef" = mkExtAuthGrpcBackendRef res."backendRef";
    }
    // {
    }
    // optionalAttrs (res."backendRefs" != [ ]) {
      "backendRefs" = map mkExtAuthGrpcBackendRef res."backendRefs";
    }
    // {
    }
    // optionalAttrs (res."backendSettings" != null) {
      "backendSettings" = mkExtAuthGrpcBackendSettings res."backendSettings";
    }
    // {
    };
  ExtAuthHttpBackendRefModule = types.submodule {
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
  mkExtAuthHttpBackendRef =
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
  ExtAuthHttpBackendSettingsCircuitBreakerModule = types.submodule {
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
        type = (types.nullOr ExtAuthHttpBackendSettingsCircuitBreakerPerEndpointModule);
        default = null;
      };
    };
  };
  mkExtAuthHttpBackendSettingsCircuitBreaker =
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
      "perEndpoint" = mkExtAuthHttpBackendSettingsCircuitBreakerPerEndpoint res."perEndpoint";
    }
    // {
    };
  ExtAuthHttpBackendSettingsCircuitBreakerPerEndpointModule = types.submodule {
    options = {
      "maxConnections" = mkOption {
        description = "MaxConnections configures the maximum number of connections that Envoy will establish per-endpoint to the referenced backend defined within a xRoute rule.";
        type = (types.nullOr types.int);
        default = 1024;
      };
    };
  };
  mkExtAuthHttpBackendSettingsCircuitBreakerPerEndpoint =
    res:
    {
    }
    // optionalAttrs (res."maxConnections" != null) { inherit (res) "maxConnections"; }
    // {
    };
  ExtAuthHttpBackendSettingsConnectionModule = types.submodule {
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
  mkExtAuthHttpBackendSettingsConnection =
    res:
    {
    }
    // optionalAttrs (res."bufferLimit" != null) { inherit (res) "bufferLimit"; }
    // {
    }
    // optionalAttrs (res."socketBufferLimit" != null) { inherit (res) "socketBufferLimit"; }
    // {
    };
  ExtAuthHttpBackendSettingsDnsModule = types.submodule {
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
  mkExtAuthHttpBackendSettingsDns =
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
  ExtAuthHttpBackendSettingsHealthCheckActiveGrpcModule = types.submodule {
    options = {
      "service" = mkOption {
        description = "Service to send in the health check request.\nIf this is not specified, then the health check request applies to the entire\nserver and not to a specific service.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkExtAuthHttpBackendSettingsHealthCheckActiveGrpc =
    res:
    {
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  ExtAuthHttpBackendSettingsHealthCheckActiveHttpExpectedResponseModule = types.submodule {
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
  mkExtAuthHttpBackendSettingsHealthCheckActiveHttpExpectedResponse =
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
  ExtAuthHttpBackendSettingsHealthCheckActiveHttpModule = types.submodule {
    options = {
      "expectedResponse" = mkOption {
        description = "ExpectedResponse defines a list of HTTP expected responses to match.";
        type = (types.nullOr ExtAuthHttpBackendSettingsHealthCheckActiveHttpExpectedResponseModule);
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
  mkExtAuthHttpBackendSettingsHealthCheckActiveHttp =
    res:
    {
    }
    // optionalAttrs (res."expectedResponse" != null) {
      "expectedResponse" =
        mkExtAuthHttpBackendSettingsHealthCheckActiveHttpExpectedResponse
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
  ExtAuthHttpBackendSettingsHealthCheckActiveModule = types.submodule {
    options = {
      "grpc" = mkOption {
        description = "GRPC defines the configuration of the GRPC health checker.\nIt's optional, and can only be used if the specified type is GRPC.";
        type = (types.nullOr ExtAuthHttpBackendSettingsHealthCheckActiveGrpcModule);
        default = null;
      };
      "healthyThreshold" = mkOption {
        description = "HealthyThreshold defines the number of healthy health checks required before a backend host is marked healthy.";
        type = (types.nullOr types.int);
        default = 1;
      };
      "http" = mkOption {
        description = "HTTP defines the configuration of http health checker.\nIt's required while the health checker type is HTTP.";
        type = (types.nullOr ExtAuthHttpBackendSettingsHealthCheckActiveHttpModule);
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
        type = (types.nullOr ExtAuthHttpBackendSettingsHealthCheckActiveTcpModule);
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
  mkExtAuthHttpBackendSettingsHealthCheckActive =
    res:
    {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkExtAuthHttpBackendSettingsHealthCheckActiveGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."healthyThreshold" != null) { inherit (res) "healthyThreshold"; }
    // {
    }
    // optionalAttrs (res."http" != null) {
      "http" = mkExtAuthHttpBackendSettingsHealthCheckActiveHttp res."http";
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
      "tcp" = mkExtAuthHttpBackendSettingsHealthCheckActiveTcp res."tcp";
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
  ExtAuthHttpBackendSettingsHealthCheckActiveTcpModule = types.submodule {
    options = {
      "receive" = mkOption {
        description = "Receive defines the expected response payload.";
        type = (types.nullOr ExtAuthHttpBackendSettingsHealthCheckActiveTcpReceiveModule);
        default = null;
      };
      "send" = mkOption {
        description = "Send defines the request payload.";
        type = (types.nullOr ExtAuthHttpBackendSettingsHealthCheckActiveTcpSendModule);
        default = null;
      };
    };
  };
  mkExtAuthHttpBackendSettingsHealthCheckActiveTcp =
    res:
    {
    }
    // optionalAttrs (res."receive" != null) {
      "receive" = mkExtAuthHttpBackendSettingsHealthCheckActiveTcpReceive res."receive";
    }
    // {
    }
    // optionalAttrs (res."send" != null) {
      "send" = mkExtAuthHttpBackendSettingsHealthCheckActiveTcpSend res."send";
    }
    // {
    };
  ExtAuthHttpBackendSettingsHealthCheckActiveTcpReceiveModule = types.submodule {
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
  mkExtAuthHttpBackendSettingsHealthCheckActiveTcpReceive =
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
  ExtAuthHttpBackendSettingsHealthCheckActiveTcpSendModule = types.submodule {
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
  mkExtAuthHttpBackendSettingsHealthCheckActiveTcpSend =
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
  ExtAuthHttpBackendSettingsHealthCheckModule = types.submodule {
    options = {
      "active" = mkOption {
        description = "Active health check configuration";
        type = (types.nullOr ExtAuthHttpBackendSettingsHealthCheckActiveModule);
        default = null;
      };
      "panicThreshold" = mkOption {
        description = "When number of unhealthy endpoints for a backend reaches this threshold\nEnvoy will disregard health status and balance across all endpoints.\nIt's designed to prevent a situation in which host failures cascade throughout the cluster\nas load increases. If not set, the default value is 50%. To disable panic mode, set value to `0`.";
        type = (types.nullOr types.int);
        default = null;
      };
      "passive" = mkOption {
        description = "Passive passive check configuration";
        type = (types.nullOr ExtAuthHttpBackendSettingsHealthCheckPassiveModule);
        default = null;
      };
    };
  };
  mkExtAuthHttpBackendSettingsHealthCheck =
    res:
    {
    }
    // optionalAttrs (res."active" != null) {
      "active" = mkExtAuthHttpBackendSettingsHealthCheckActive res."active";
    }
    // {
    }
    // optionalAttrs (res."panicThreshold" != null) { inherit (res) "panicThreshold"; }
    // {
    }
    // optionalAttrs (res."passive" != null) {
      "passive" = mkExtAuthHttpBackendSettingsHealthCheckPassive res."passive";
    }
    // {
    };
  ExtAuthHttpBackendSettingsHealthCheckPassiveModule = types.submodule {
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
  mkExtAuthHttpBackendSettingsHealthCheckPassive =
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
  ExtAuthHttpBackendSettingsHttp2Module = types.submodule {
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
  mkExtAuthHttpBackendSettingsHttp2 =
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
  ExtAuthHttpBackendSettingsLoadBalancerConsistentHashCookieModule = types.submodule {
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
  mkExtAuthHttpBackendSettingsLoadBalancerConsistentHashCookie =
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
  ExtAuthHttpBackendSettingsLoadBalancerConsistentHashHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the header to hash.";
        type = types.str;
      };
    };
  };
  mkExtAuthHttpBackendSettingsLoadBalancerConsistentHashHeader = res: {
    inherit (res) "name";
  };
  ExtAuthHttpBackendSettingsLoadBalancerConsistentHashModule = types.submodule {
    options = {
      "cookie" = mkOption {
        description = "Cookie configures the cookie hash policy when the consistent hash type is set to Cookie.";
        type = (types.nullOr ExtAuthHttpBackendSettingsLoadBalancerConsistentHashCookieModule);
        default = null;
      };
      "header" = mkOption {
        description = "Header configures the header hash policy when the consistent hash type is set to Header.";
        type = (types.nullOr ExtAuthHttpBackendSettingsLoadBalancerConsistentHashHeaderModule);
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
  mkExtAuthHttpBackendSettingsLoadBalancerConsistentHash =
    res:
    {
    }
    // optionalAttrs (res."cookie" != null) {
      "cookie" = mkExtAuthHttpBackendSettingsLoadBalancerConsistentHashCookie res."cookie";
    }
    // {
    }
    // optionalAttrs (res."header" != null) {
      "header" = mkExtAuthHttpBackendSettingsLoadBalancerConsistentHashHeader res."header";
    }
    // {
    }
    // optionalAttrs (res."tableSize" != null) { inherit (res) "tableSize"; }
    // {
      inherit (res) "type";
    };
  ExtAuthHttpBackendSettingsLoadBalancerEndpointOverrideExtractFromModule = types.submodule {
    options = {
      "header" = mkOption {
        description = "Header defines the header to get the override endpoint addresses.\nThe header value must specify at least one endpoint in `IP:Port` format or multiple endpoints in `IP:Port,IP:Port,...` format.\nFor example `10.0.0.5:8080` or `[2600:4040:5204::1574:24ae]:80`.\nThe IPv6 address is enclosed in square brackets.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkExtAuthHttpBackendSettingsLoadBalancerEndpointOverrideExtractFrom =
    res:
    {
    }
    // optionalAttrs (res."header" != null) { inherit (res) "header"; }
    // {
    };
  ExtAuthHttpBackendSettingsLoadBalancerEndpointOverrideModule = types.submodule {
    options = {
      "extractFrom" = mkOption {
        description = "ExtractFrom defines the sources to extract endpoint override information from.";
        type = (types.listOf ExtAuthHttpBackendSettingsLoadBalancerEndpointOverrideExtractFromModule);
      };
    };
  };
  mkExtAuthHttpBackendSettingsLoadBalancerEndpointOverride = res: {
    "extractFrom" =
      map mkExtAuthHttpBackendSettingsLoadBalancerEndpointOverrideExtractFrom
        res."extractFrom";
  };
  ExtAuthHttpBackendSettingsLoadBalancerModule = types.submodule {
    options = {
      "consistentHash" = mkOption {
        description = "ConsistentHash defines the configuration when the load balancer type is\nset to ConsistentHash";
        type = (types.nullOr ExtAuthHttpBackendSettingsLoadBalancerConsistentHashModule);
        default = null;
      };
      "endpointOverride" = mkOption {
        description = "EndpointOverride defines the configuration for endpoint override.\nWhen specified, the load balancer will attempt to route requests to endpoints\nbased on the override information extracted from request headers or metadata.\n If the override endpoints are not available, the configured load balancer policy will be used as fallback.";
        type = (types.nullOr ExtAuthHttpBackendSettingsLoadBalancerEndpointOverrideModule);
        default = null;
      };
      "slowStart" = mkOption {
        description = "SlowStart defines the configuration related to the slow start load balancer policy.\nIf set, during slow start window, traffic sent to the newly added hosts will gradually increase.\nCurrently this is only supported for RoundRobin and LeastRequest load balancers";
        type = (types.nullOr ExtAuthHttpBackendSettingsLoadBalancerSlowStartModule);
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
        type = (types.nullOr ExtAuthHttpBackendSettingsLoadBalancerZoneAwareModule);
        default = null;
      };
    };
  };
  mkExtAuthHttpBackendSettingsLoadBalancer =
    res:
    {
    }
    // optionalAttrs (res."consistentHash" != null) {
      "consistentHash" = mkExtAuthHttpBackendSettingsLoadBalancerConsistentHash res."consistentHash";
    }
    // {
    }
    // optionalAttrs (res."endpointOverride" != null) {
      "endpointOverride" =
        mkExtAuthHttpBackendSettingsLoadBalancerEndpointOverride
          res."endpointOverride";
    }
    // {
    }
    // optionalAttrs (res."slowStart" != null) {
      "slowStart" = mkExtAuthHttpBackendSettingsLoadBalancerSlowStart res."slowStart";
    }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."zoneAware" != null) {
      "zoneAware" = mkExtAuthHttpBackendSettingsLoadBalancerZoneAware res."zoneAware";
    }
    // {
    };
  ExtAuthHttpBackendSettingsLoadBalancerSlowStartModule = types.submodule {
    options = {
      "window" = mkOption {
        description = "Window defines the duration of the warm up period for newly added host.\nDuring slow start window, traffic sent to the newly added hosts will gradually increase.\nCurrently only supports linear growth of traffic. For additional details,\nsee https://www.envoyproxy.io/docs/envoy/latest/api-v3/config/cluster/v3/cluster.proto#config-cluster-v3-cluster-slowstartconfig";
        type = types.str;
      };
    };
  };
  mkExtAuthHttpBackendSettingsLoadBalancerSlowStart = res: {
    inherit (res) "window";
  };
  ExtAuthHttpBackendSettingsLoadBalancerZoneAwareModule = types.submodule {
    options = {
      "preferLocal" = mkOption {
        description = "PreferLocalZone configures zone-aware routing to prefer sending traffic to the local locality zone.";
        type = (types.nullOr ExtAuthHttpBackendSettingsLoadBalancerZoneAwarePreferLocalModule);
        default = null;
      };
    };
  };
  mkExtAuthHttpBackendSettingsLoadBalancerZoneAware =
    res:
    {
    }
    // optionalAttrs (res."preferLocal" != null) {
      "preferLocal" = mkExtAuthHttpBackendSettingsLoadBalancerZoneAwarePreferLocal res."preferLocal";
    }
    // {
    };
  ExtAuthHttpBackendSettingsLoadBalancerZoneAwarePreferLocalForceModule = types.submodule {
    options = {
      "minEndpointsInZoneThreshold" = mkOption {
        description = "MinEndpointsInZoneThreshold is the minimum number of upstream endpoints in the local zone required to honor the forceLocalZone\noverride. This is useful for protecting zones with fewer endpoints.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkExtAuthHttpBackendSettingsLoadBalancerZoneAwarePreferLocalForce =
    res:
    {
    }
    // optionalAttrs (res."minEndpointsInZoneThreshold" != null) {
      inherit (res) "minEndpointsInZoneThreshold";
    }
    // {
    };
  ExtAuthHttpBackendSettingsLoadBalancerZoneAwarePreferLocalModule = types.submodule {
    options = {
      "force" = mkOption {
        description = "ForceLocalZone defines override configuration for forcing all traffic to stay within the local zone instead of the default behavior\nwhich maintains equal distribution among upstream endpoints while sending as much traffic as possible locally.";
        type = (types.nullOr ExtAuthHttpBackendSettingsLoadBalancerZoneAwarePreferLocalForceModule);
        default = null;
      };
      "minEndpointsThreshold" = mkOption {
        description = "MinEndpointsThreshold is the minimum number of total upstream endpoints across all zones required to enable zone-aware routing.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkExtAuthHttpBackendSettingsLoadBalancerZoneAwarePreferLocal =
    res:
    {
    }
    // optionalAttrs (res."force" != null) {
      "force" = mkExtAuthHttpBackendSettingsLoadBalancerZoneAwarePreferLocalForce res."force";
    }
    // {
    }
    // optionalAttrs (res."minEndpointsThreshold" != null) { inherit (res) "minEndpointsThreshold"; }
    // {
    };
  ExtAuthHttpBackendSettingsModule = types.submodule {
    options = {
      "circuitBreaker" = mkOption {
        description = "Circuit Breaker settings for the upstream connections and requests.\nIf not set, circuit breakers will be enabled with the default thresholds";
        type = (types.nullOr ExtAuthHttpBackendSettingsCircuitBreakerModule);
        default = null;
      };
      "connection" = mkOption {
        description = "Connection includes backend connection settings.";
        type = (types.nullOr ExtAuthHttpBackendSettingsConnectionModule);
        default = null;
      };
      "dns" = mkOption {
        description = "DNS includes dns resolution settings.";
        type = (types.nullOr ExtAuthHttpBackendSettingsDnsModule);
        default = null;
      };
      "healthCheck" = mkOption {
        description = "HealthCheck allows gateway to perform active health checking on backends.";
        type = (types.nullOr ExtAuthHttpBackendSettingsHealthCheckModule);
        default = null;
      };
      "http2" = mkOption {
        description = "HTTP2 provides HTTP/2 configuration for backend connections.";
        type = (types.nullOr ExtAuthHttpBackendSettingsHttp2Module);
        default = null;
      };
      "loadBalancer" = mkOption {
        description = "LoadBalancer policy to apply when routing traffic from the gateway to\nthe backend endpoints. Defaults to `LeastRequest`.";
        type = (types.nullOr ExtAuthHttpBackendSettingsLoadBalancerModule);
        default = null;
      };
      "proxyProtocol" = mkOption {
        description = "ProxyProtocol enables the Proxy Protocol when communicating with the backend.";
        type = (types.nullOr ExtAuthHttpBackendSettingsProxyProtocolModule);
        default = null;
      };
      "retry" = mkOption {
        description = "Retry provides more advanced usage, allowing users to customize the number of retries, retry fallback strategy, and retry triggering conditions.\nIf not set, retry will be disabled.";
        type = (types.nullOr ExtAuthHttpBackendSettingsRetryModule);
        default = null;
      };
      "tcpKeepalive" = mkOption {
        description = "TcpKeepalive settings associated with the upstream client connection.\nDisabled by default.";
        type = (types.nullOr ExtAuthHttpBackendSettingsTcpKeepaliveModule);
        default = null;
      };
      "timeout" = mkOption {
        description = "Timeout settings for the backend connections.";
        type = (types.nullOr ExtAuthHttpBackendSettingsTimeoutModule);
        default = null;
      };
    };
  };
  mkExtAuthHttpBackendSettings =
    res:
    {
    }
    // optionalAttrs (res."circuitBreaker" != null) {
      "circuitBreaker" = mkExtAuthHttpBackendSettingsCircuitBreaker res."circuitBreaker";
    }
    // {
    }
    // optionalAttrs (res."connection" != null) {
      "connection" = mkExtAuthHttpBackendSettingsConnection res."connection";
    }
    // {
    }
    // optionalAttrs (res."dns" != null) { "dns" = mkExtAuthHttpBackendSettingsDns res."dns"; }
    // {
    }
    // optionalAttrs (res."healthCheck" != null) {
      "healthCheck" = mkExtAuthHttpBackendSettingsHealthCheck res."healthCheck";
    }
    // {
    }
    // optionalAttrs (res."http2" != null) { "http2" = mkExtAuthHttpBackendSettingsHttp2 res."http2"; }
    // {
    }
    // optionalAttrs (res."loadBalancer" != null) {
      "loadBalancer" = mkExtAuthHttpBackendSettingsLoadBalancer res."loadBalancer";
    }
    // {
    }
    // optionalAttrs (res."proxyProtocol" != null) {
      "proxyProtocol" = mkExtAuthHttpBackendSettingsProxyProtocol res."proxyProtocol";
    }
    // {
    }
    // optionalAttrs (res."retry" != null) { "retry" = mkExtAuthHttpBackendSettingsRetry res."retry"; }
    // {
    }
    // optionalAttrs (res."tcpKeepalive" != null) {
      "tcpKeepalive" = mkExtAuthHttpBackendSettingsTcpKeepalive res."tcpKeepalive";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) {
      "timeout" = mkExtAuthHttpBackendSettingsTimeout res."timeout";
    }
    // {
    };
  ExtAuthHttpBackendSettingsProxyProtocolModule = types.submodule {
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
  mkExtAuthHttpBackendSettingsProxyProtocol = res: {
    inherit (res) "version";
  };
  ExtAuthHttpBackendSettingsRetryModule = types.submodule {
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
        type = (types.nullOr ExtAuthHttpBackendSettingsRetryPerRetryModule);
        default = null;
      };
      "retryOn" = mkOption {
        description = "RetryOn specifies the retry trigger condition.\n\nIf not specified, the default is to retry on connect-failure,refused-stream,unavailable,cancelled,retriable-status-codes(503).";
        type = (types.nullOr ExtAuthHttpBackendSettingsRetryRetryOnModule);
        default = null;
      };
    };
  };
  mkExtAuthHttpBackendSettingsRetry =
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
      "perRetry" = mkExtAuthHttpBackendSettingsRetryPerRetry res."perRetry";
    }
    // {
    }
    // optionalAttrs (res."retryOn" != null) {
      "retryOn" = mkExtAuthHttpBackendSettingsRetryRetryOn res."retryOn";
    }
    // {
    };
  ExtAuthHttpBackendSettingsRetryPerRetryBackOffModule = types.submodule {
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
  mkExtAuthHttpBackendSettingsRetryPerRetryBackOff =
    res:
    {
    }
    // optionalAttrs (res."baseInterval" != null) { inherit (res) "baseInterval"; }
    // {
    }
    // optionalAttrs (res."maxInterval" != null) { inherit (res) "maxInterval"; }
    // {
    };
  ExtAuthHttpBackendSettingsRetryPerRetryModule = types.submodule {
    options = {
      "backOff" = mkOption {
        description = "Backoff is the backoff policy to be applied per retry attempt. gateway uses a fully jittered exponential\nback-off algorithm for retries. For additional details,\nsee https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/router_filter#config-http-filters-router-x-envoy-max-retries";
        type = (types.nullOr ExtAuthHttpBackendSettingsRetryPerRetryBackOffModule);
        default = null;
      };
      "timeout" = mkOption {
        description = "Timeout is the timeout per retry attempt.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkExtAuthHttpBackendSettingsRetryPerRetry =
    res:
    {
    }
    // optionalAttrs (res."backOff" != null) {
      "backOff" = mkExtAuthHttpBackendSettingsRetryPerRetryBackOff res."backOff";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    };
  ExtAuthHttpBackendSettingsRetryRetryOnModule = types.submodule {
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
  mkExtAuthHttpBackendSettingsRetryRetryOn =
    res:
    {
    }
    // optionalAttrs (res."httpStatusCodes" != [ ]) { inherit (res) "httpStatusCodes"; }
    // {
    }
    // optionalAttrs (res."triggers" != [ ]) { inherit (res) "triggers"; }
    // {
    };
  ExtAuthHttpBackendSettingsTcpKeepaliveModule = types.submodule {
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
  mkExtAuthHttpBackendSettingsTcpKeepalive =
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
  ExtAuthHttpBackendSettingsTimeoutHttpModule = types.submodule {
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
  mkExtAuthHttpBackendSettingsTimeoutHttp =
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
  ExtAuthHttpBackendSettingsTimeoutModule = types.submodule {
    options = {
      "http" = mkOption {
        description = "Timeout settings for HTTP.";
        type = (types.nullOr ExtAuthHttpBackendSettingsTimeoutHttpModule);
        default = null;
      };
      "tcp" = mkOption {
        description = "Timeout settings for TCP.";
        type = (types.nullOr ExtAuthHttpBackendSettingsTimeoutTcpModule);
        default = null;
      };
    };
  };
  mkExtAuthHttpBackendSettingsTimeout =
    res:
    {
    }
    // optionalAttrs (res."http" != null) {
      "http" = mkExtAuthHttpBackendSettingsTimeoutHttp res."http";
    }
    // {
    }
    // optionalAttrs (res."tcp" != null) { "tcp" = mkExtAuthHttpBackendSettingsTimeoutTcp res."tcp"; }
    // {
    };
  ExtAuthHttpBackendSettingsTimeoutTcpModule = types.submodule {
    options = {
      "connectTimeout" = mkOption {
        description = "The timeout for network connection establishment, including TCP and TLS handshakes.\nDefault: 10 seconds.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkExtAuthHttpBackendSettingsTimeoutTcp =
    res:
    {
    }
    // optionalAttrs (res."connectTimeout" != null) { inherit (res) "connectTimeout"; }
    // {
    };
  ExtAuthHttpModule = types.submodule {
    options = {
      "backendRef" = mkOption {
        description = "BackendRef references a Kubernetes object that represents the\nbackend server to which the authorization request will be sent.\n\nDeprecated: Use BackendRefs instead.";
        type = (types.nullOr ExtAuthHttpBackendRefModule);
        default = null;
      };
      "backendRefs" = mkOption {
        description = "BackendRefs references a Kubernetes object that represents the\nbackend server to which the authorization request will be sent.";
        type = (types.listOf ExtAuthHttpBackendRefModule);
        default = [ ];
      };
      "backendSettings" = mkOption {
        description = "BackendSettings holds configuration for managing the connection\nto the backend.";
        type = (types.nullOr ExtAuthHttpBackendSettingsModule);
        default = null;
      };
      "headersToBackend" = mkOption {
        description = "HeadersToBackend are the authorization response headers that will be added\nto the original client request before sending it to the backend server.\nNote that coexisting headers will be overridden.\nIf not specified, no authorization response headers will be added to the\noriginal client request.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "path" = mkOption {
        description = "Path is the path of the HTTP External Authorization service.\nIf path is specified, the authorization request will be sent to that path,\nor else the authorization request will use the path of the original request.\n\nPlease note that the original request path will be appended to the path specified here.\nFor example, if the original request path is \"/hello\", and the path specified here is \"/auth\",\nthen the path of the authorization request will be \"/auth/hello\". If the path is not specified,\nthe path of the authorization request will be \"/hello\".";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkExtAuthHttp =
    res:
    {
    }
    // optionalAttrs (res."backendRef" != null) {
      "backendRef" = mkExtAuthHttpBackendRef res."backendRef";
    }
    // {
    }
    // optionalAttrs (res."backendRefs" != [ ]) {
      "backendRefs" = map mkExtAuthHttpBackendRef res."backendRefs";
    }
    // {
    }
    // optionalAttrs (res."backendSettings" != null) {
      "backendSettings" = mkExtAuthHttpBackendSettings res."backendSettings";
    }
    // {
    }
    // optionalAttrs (res."headersToBackend" != [ ]) { inherit (res) "headersToBackend"; }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    };
  ExtAuthModule = types.submodule {
    options = {
      "bodyToExtAuth" = mkOption {
        description = "BodyToExtAuth defines the Body to Ext Auth configuration.";
        type = (types.nullOr ExtAuthBodyToExtAuthModule);
        default = null;
      };
      "failOpen" = mkOption {
        description = "FailOpen is a switch used to control the behavior when a response from the External Authorization service cannot be obtained.\nIf FailOpen is set to true, the system allows the traffic to pass through.\nOtherwise, if it is set to false or not set (defaulting to false),\nthe system blocks the traffic and returns a HTTP 5xx error, reflecting a fail-closed approach.\nThis setting determines whether to prioritize accessibility over strict security in case of authorization service failure.\n\nIf set to true, the External Authorization will also be bypassed if its configuration is invalid.";
        type = types.bool;
        default = false;
      };
      "grpc" = mkOption {
        description = "GRPC defines the gRPC External Authorization service.\nEither GRPCService or HTTPService must be specified,\nand only one of them can be provided.";
        type = (types.nullOr ExtAuthGrpcModule);
        default = null;
      };
      "headersToExtAuth" = mkOption {
        description = "HeadersToExtAuth defines the client request headers that will be included\nin the request to the external authorization service.\nNote: If not specified, the default behavior for gRPC and HTTP external\nauthorization services is different due to backward compatibility reasons.\nAll headers will be included in the check request to a gRPC authorization server.\nOnly the following headers will be included in the check request to an HTTP\nauthorization server: Host, Method, Path, Content-Length, and Authorization.\nAnd these headers will always be included to the check request to an HTTP\nauthorization server by default, no matter whether they are specified\nin HeadersToExtAuth or not.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "http" = mkOption {
        description = "HTTP defines the HTTP External Authorization service.\nEither GRPCService or HTTPService must be specified,\nand only one of them can be provided.";
        type = (types.nullOr ExtAuthHttpModule);
        default = null;
      };
      "recomputeRoute" = mkOption {
        description = "RecomputeRoute clears the route cache and recalculates the routing decision.\nThis field must be enabled if the headers added or modified by the ExtAuth are used for\nroute matching decisions. If the recomputation selects a new route, features targeting\nthe new matched route will be applied.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkExtAuth =
    res:
    {
    }
    // optionalAttrs (res."bodyToExtAuth" != null) {
      "bodyToExtAuth" = mkExtAuthBodyToExtAuth res."bodyToExtAuth";
    }
    // {
    }
    // optionalAttrs res."failOpen" { inherit (res) "failOpen"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) { "grpc" = mkExtAuthGrpc res."grpc"; }
    // {
    }
    // optionalAttrs (res."headersToExtAuth" != [ ]) { inherit (res) "headersToExtAuth"; }
    // {
    }
    // optionalAttrs (res."http" != null) { "http" = mkExtAuthHttp res."http"; }
    // {
    }
    // optionalAttrs res."recomputeRoute" { inherit (res) "recomputeRoute"; }
    // {
    };
  JwtModule = types.submodule {
    options = {
      "optional" = mkOption {
        description = "Optional determines whether a missing JWT is acceptable, defaulting to false if not specified.\nNote: Even if optional is set to true, JWT authentication will still fail if an invalid JWT is presented.";
        type = types.bool;
        default = false;
      };
      "providers" = mkOption {
        description = "Providers defines the JSON Web Token (JWT) authentication provider type.\nWhen multiple JWT providers are specified, the JWT is considered valid if\nany of the providers successfully validate the JWT. For additional details,\nsee https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/jwt_authn_filter.html.";
        type = (types.listOf JwtProviderModule);
      };
    };
  };
  mkJwt =
    res:
    {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
      "providers" = map mkJwtProvider res."providers";
    };
  JwtProviderClaimToHeaderModule = types.submodule {
    options = {
      "claim" = mkOption {
        description = "Claim is the JWT Claim that should be saved into the header : it can be a nested claim of type\n(eg. \"claim.nested.key\", \"sub\"). The nested claim name must use dot \".\"\nto separate the JSON name path.";
        type = types.str;
      };
      "header" = mkOption {
        description = "Header defines the name of the HTTP request header that the JWT Claim will be saved into.";
        type = types.str;
      };
    };
  };
  mkJwtProviderClaimToHeader = res: {
    inherit (res) "claim";
    inherit (res) "header";
  };
  JwtProviderExtractFromHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the HTTP header name to retrieve the token";
        type = types.str;
      };
      "valuePrefix" = mkOption {
        description = "ValuePrefix is the prefix that should be stripped before extracting the token.\nThe format would be used by Envoy like \"{ValuePrefix}<TOKEN>\".\nFor example, \"Authorization: Bearer <TOKEN>\", then the ValuePrefix=\"Bearer \" with a space at the end.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkJwtProviderExtractFromHeader =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."valuePrefix" != null) { inherit (res) "valuePrefix"; }
    // {
    };
  JwtProviderExtractFromModule = types.submodule {
    options = {
      "cookies" = mkOption {
        description = "Cookies represents a list of cookie names to extract the JWT token from.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "headers" = mkOption {
        description = "Headers represents a list of HTTP request headers to extract the JWT token from.";
        type = (types.listOf JwtProviderExtractFromHeaderModule);
        default = [ ];
      };
      "params" = mkOption {
        description = "Params represents a list of query parameters to extract the JWT token from.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkJwtProviderExtractFrom =
    res:
    {
    }
    // optionalAttrs (res."cookies" != [ ]) { inherit (res) "cookies"; }
    // {
    }
    // optionalAttrs (res."headers" != [ ]) {
      "headers" = map mkJwtProviderExtractFromHeader res."headers";
    }
    // {
    }
    // optionalAttrs (res."params" != [ ]) { inherit (res) "params"; }
    // {
    };
  JwtProviderLocalJWKSModule = types.submodule {
    options = {
      "inline" = mkOption {
        description = "Inline contains the value as an inline string.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Type is the type of method to use to read the body value.\nValid values are Inline and ValueRef, default is Inline.";
        type = (
          types.enum [
            "Inline"
            "ValueRef"
          ]
        );
      };
      "valueRef" = mkOption {
        description = "ValueRef is a reference to a local ConfigMap that contains the JSON Web Key Sets (JWKS).\n\nThe value of key `jwks` in the ConfigMap will be used.\nIf the key is not found, the first value in the ConfigMap will be used.";
        type = (types.nullOr JwtProviderLocalJWKSValueRefModule);
        default = null;
      };
    };
  };
  mkJwtProviderLocalJWKS =
    res:
    {
    }
    // optionalAttrs (res."inline" != null) { inherit (res) "inline"; }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."valueRef" != null) {
      "valueRef" = mkJwtProviderLocalJWKSValueRef res."valueRef";
    }
    // {
    };
  JwtProviderLocalJWKSValueRefModule = types.submodule {
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
  mkJwtProviderLocalJWKSValueRef = res: {
    inherit (res) "group";
    inherit (res) "kind";
    inherit (res) "name";
  };
  JwtProviderModule = types.submodule {
    options = {
      "audiences" = mkOption {
        description = "Audiences is a list of JWT audiences allowed access. For additional details, see\nhttps://tools.ietf.org/html/rfc7519#section-4.1.3. If not provided, JWT audiences\nare not checked.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "claimToHeaders" = mkOption {
        description = "ClaimToHeaders is a list of JWT claims that must be extracted into HTTP request headers\nFor examples, following config:\nThe claim must be of type; string, int, double, bool. Array type claims are not supported";
        type = (types.listOf JwtProviderClaimToHeaderModule);
        default = [ ];
      };
      "extractFrom" = mkOption {
        description = "ExtractFrom defines different ways to extract the JWT token from HTTP request.\nIf empty, it defaults to extract JWT token from the Authorization HTTP request header using Bearer schema\nor access_token from query parameters.";
        type = (types.nullOr JwtProviderExtractFromModule);
        default = null;
      };
      "issuer" = mkOption {
        description = "Issuer is the principal that issued the JWT and takes the form of a URL or email address.\nFor additional details, see https://tools.ietf.org/html/rfc7519#section-4.1.1 for\nURL format and https://rfc-editor.org/rfc/rfc5322.html for email format. If not provided,\nthe JWT issuer is not checked.";
        type = (types.nullOr types.str);
        default = null;
      };
      "localJWKS" = mkOption {
        description = "LocalJWKS defines how to get the JSON Web Key Sets (JWKS) from a local source.";
        type = (types.nullOr JwtProviderLocalJWKSModule);
        default = null;
      };
      "name" = mkOption {
        description = "Name defines a unique name for the JWT provider. A name can have a variety of forms,\nincluding RFC1123 subdomains, RFC 1123 labels, or RFC 1035 labels.";
        type = types.str;
      };
      "recomputeRoute" = mkOption {
        description = "RecomputeRoute clears the route cache and recalculates the routing decision.\nThis field must be enabled if the headers generated from the claim are used for\nroute matching decisions. If the recomputation selects a new route, features targeting\nthe new matched route will be applied.";
        type = types.bool;
        default = false;
      };
      "remoteJWKS" = mkOption {
        description = "RemoteJWKS defines how to fetch and cache JSON Web Key Sets (JWKS) from a remote\nHTTP/HTTPS endpoint.";
        type = (types.nullOr JwtProviderRemoteJWKSModule);
        default = null;
      };
    };
  };
  mkJwtProvider =
    res:
    {
    }
    // optionalAttrs (res."audiences" != [ ]) { inherit (res) "audiences"; }
    // {
    }
    // optionalAttrs (res."claimToHeaders" != [ ]) {
      "claimToHeaders" = map mkJwtProviderClaimToHeader res."claimToHeaders";
    }
    // {
    }
    // optionalAttrs (res."extractFrom" != null) {
      "extractFrom" = mkJwtProviderExtractFrom res."extractFrom";
    }
    // {
    }
    // optionalAttrs (res."issuer" != null) { inherit (res) "issuer"; }
    // {
    }
    // optionalAttrs (res."localJWKS" != null) { "localJWKS" = mkJwtProviderLocalJWKS res."localJWKS"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs res."recomputeRoute" { inherit (res) "recomputeRoute"; }
    // {
    }
    // optionalAttrs (res."remoteJWKS" != null) {
      "remoteJWKS" = mkJwtProviderRemoteJWKS res."remoteJWKS";
    }
    // {
    };
  JwtProviderRemoteJWKSBackendRefModule = types.submodule {
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
  mkJwtProviderRemoteJWKSBackendRef =
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
  JwtProviderRemoteJWKSBackendSettingsCircuitBreakerModule = types.submodule {
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
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsCircuitBreakerPerEndpointModule);
        default = null;
      };
    };
  };
  mkJwtProviderRemoteJWKSBackendSettingsCircuitBreaker =
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
      "perEndpoint" = mkJwtProviderRemoteJWKSBackendSettingsCircuitBreakerPerEndpoint res."perEndpoint";
    }
    // {
    };
  JwtProviderRemoteJWKSBackendSettingsCircuitBreakerPerEndpointModule = types.submodule {
    options = {
      "maxConnections" = mkOption {
        description = "MaxConnections configures the maximum number of connections that Envoy will establish per-endpoint to the referenced backend defined within a xRoute rule.";
        type = (types.nullOr types.int);
        default = 1024;
      };
    };
  };
  mkJwtProviderRemoteJWKSBackendSettingsCircuitBreakerPerEndpoint =
    res:
    {
    }
    // optionalAttrs (res."maxConnections" != null) { inherit (res) "maxConnections"; }
    // {
    };
  JwtProviderRemoteJWKSBackendSettingsConnectionModule = types.submodule {
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
  mkJwtProviderRemoteJWKSBackendSettingsConnection =
    res:
    {
    }
    // optionalAttrs (res."bufferLimit" != null) { inherit (res) "bufferLimit"; }
    // {
    }
    // optionalAttrs (res."socketBufferLimit" != null) { inherit (res) "socketBufferLimit"; }
    // {
    };
  JwtProviderRemoteJWKSBackendSettingsDnsModule = types.submodule {
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
  mkJwtProviderRemoteJWKSBackendSettingsDns =
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
  JwtProviderRemoteJWKSBackendSettingsHealthCheckActiveGrpcModule = types.submodule {
    options = {
      "service" = mkOption {
        description = "Service to send in the health check request.\nIf this is not specified, then the health check request applies to the entire\nserver and not to a specific service.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkJwtProviderRemoteJWKSBackendSettingsHealthCheckActiveGrpc =
    res:
    {
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  JwtProviderRemoteJWKSBackendSettingsHealthCheckActiveHttpExpectedResponseModule = types.submodule {
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
  mkJwtProviderRemoteJWKSBackendSettingsHealthCheckActiveHttpExpectedResponse =
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
  JwtProviderRemoteJWKSBackendSettingsHealthCheckActiveHttpModule = types.submodule {
    options = {
      "expectedResponse" = mkOption {
        description = "ExpectedResponse defines a list of HTTP expected responses to match.";
        type = (
          types.nullOr JwtProviderRemoteJWKSBackendSettingsHealthCheckActiveHttpExpectedResponseModule
        );
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
  mkJwtProviderRemoteJWKSBackendSettingsHealthCheckActiveHttp =
    res:
    {
    }
    // optionalAttrs (res."expectedResponse" != null) {
      "expectedResponse" =
        mkJwtProviderRemoteJWKSBackendSettingsHealthCheckActiveHttpExpectedResponse
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
  JwtProviderRemoteJWKSBackendSettingsHealthCheckActiveModule = types.submodule {
    options = {
      "grpc" = mkOption {
        description = "GRPC defines the configuration of the GRPC health checker.\nIt's optional, and can only be used if the specified type is GRPC.";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsHealthCheckActiveGrpcModule);
        default = null;
      };
      "healthyThreshold" = mkOption {
        description = "HealthyThreshold defines the number of healthy health checks required before a backend host is marked healthy.";
        type = (types.nullOr types.int);
        default = 1;
      };
      "http" = mkOption {
        description = "HTTP defines the configuration of http health checker.\nIt's required while the health checker type is HTTP.";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsHealthCheckActiveHttpModule);
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
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsHealthCheckActiveTcpModule);
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
  mkJwtProviderRemoteJWKSBackendSettingsHealthCheckActive =
    res:
    {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkJwtProviderRemoteJWKSBackendSettingsHealthCheckActiveGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."healthyThreshold" != null) { inherit (res) "healthyThreshold"; }
    // {
    }
    // optionalAttrs (res."http" != null) {
      "http" = mkJwtProviderRemoteJWKSBackendSettingsHealthCheckActiveHttp res."http";
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
      "tcp" = mkJwtProviderRemoteJWKSBackendSettingsHealthCheckActiveTcp res."tcp";
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
  JwtProviderRemoteJWKSBackendSettingsHealthCheckActiveTcpModule = types.submodule {
    options = {
      "receive" = mkOption {
        description = "Receive defines the expected response payload.";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsHealthCheckActiveTcpReceiveModule);
        default = null;
      };
      "send" = mkOption {
        description = "Send defines the request payload.";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsHealthCheckActiveTcpSendModule);
        default = null;
      };
    };
  };
  mkJwtProviderRemoteJWKSBackendSettingsHealthCheckActiveTcp =
    res:
    {
    }
    // optionalAttrs (res."receive" != null) {
      "receive" = mkJwtProviderRemoteJWKSBackendSettingsHealthCheckActiveTcpReceive res."receive";
    }
    // {
    }
    // optionalAttrs (res."send" != null) {
      "send" = mkJwtProviderRemoteJWKSBackendSettingsHealthCheckActiveTcpSend res."send";
    }
    // {
    };
  JwtProviderRemoteJWKSBackendSettingsHealthCheckActiveTcpReceiveModule = types.submodule {
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
  mkJwtProviderRemoteJWKSBackendSettingsHealthCheckActiveTcpReceive =
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
  JwtProviderRemoteJWKSBackendSettingsHealthCheckActiveTcpSendModule = types.submodule {
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
  mkJwtProviderRemoteJWKSBackendSettingsHealthCheckActiveTcpSend =
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
  JwtProviderRemoteJWKSBackendSettingsHealthCheckModule = types.submodule {
    options = {
      "active" = mkOption {
        description = "Active health check configuration";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsHealthCheckActiveModule);
        default = null;
      };
      "panicThreshold" = mkOption {
        description = "When number of unhealthy endpoints for a backend reaches this threshold\nEnvoy will disregard health status and balance across all endpoints.\nIt's designed to prevent a situation in which host failures cascade throughout the cluster\nas load increases. If not set, the default value is 50%. To disable panic mode, set value to `0`.";
        type = (types.nullOr types.int);
        default = null;
      };
      "passive" = mkOption {
        description = "Passive passive check configuration";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsHealthCheckPassiveModule);
        default = null;
      };
    };
  };
  mkJwtProviderRemoteJWKSBackendSettingsHealthCheck =
    res:
    {
    }
    // optionalAttrs (res."active" != null) {
      "active" = mkJwtProviderRemoteJWKSBackendSettingsHealthCheckActive res."active";
    }
    // {
    }
    // optionalAttrs (res."panicThreshold" != null) { inherit (res) "panicThreshold"; }
    // {
    }
    // optionalAttrs (res."passive" != null) {
      "passive" = mkJwtProviderRemoteJWKSBackendSettingsHealthCheckPassive res."passive";
    }
    // {
    };
  JwtProviderRemoteJWKSBackendSettingsHealthCheckPassiveModule = types.submodule {
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
  mkJwtProviderRemoteJWKSBackendSettingsHealthCheckPassive =
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
  JwtProviderRemoteJWKSBackendSettingsHttp2Module = types.submodule {
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
  mkJwtProviderRemoteJWKSBackendSettingsHttp2 =
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
  JwtProviderRemoteJWKSBackendSettingsLoadBalancerConsistentHashCookieModule = types.submodule {
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
  mkJwtProviderRemoteJWKSBackendSettingsLoadBalancerConsistentHashCookie =
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
  JwtProviderRemoteJWKSBackendSettingsLoadBalancerConsistentHashHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the header to hash.";
        type = types.str;
      };
    };
  };
  mkJwtProviderRemoteJWKSBackendSettingsLoadBalancerConsistentHashHeader = res: {
    inherit (res) "name";
  };
  JwtProviderRemoteJWKSBackendSettingsLoadBalancerConsistentHashModule = types.submodule {
    options = {
      "cookie" = mkOption {
        description = "Cookie configures the cookie hash policy when the consistent hash type is set to Cookie.";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsLoadBalancerConsistentHashCookieModule);
        default = null;
      };
      "header" = mkOption {
        description = "Header configures the header hash policy when the consistent hash type is set to Header.";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsLoadBalancerConsistentHashHeaderModule);
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
  mkJwtProviderRemoteJWKSBackendSettingsLoadBalancerConsistentHash =
    res:
    {
    }
    // optionalAttrs (res."cookie" != null) {
      "cookie" = mkJwtProviderRemoteJWKSBackendSettingsLoadBalancerConsistentHashCookie res."cookie";
    }
    // {
    }
    // optionalAttrs (res."header" != null) {
      "header" = mkJwtProviderRemoteJWKSBackendSettingsLoadBalancerConsistentHashHeader res."header";
    }
    // {
    }
    // optionalAttrs (res."tableSize" != null) { inherit (res) "tableSize"; }
    // {
      inherit (res) "type";
    };
  JwtProviderRemoteJWKSBackendSettingsLoadBalancerEndpointOverrideExtractFromModule =
    types.submodule
      {
        options = {
          "header" = mkOption {
            description = "Header defines the header to get the override endpoint addresses.\nThe header value must specify at least one endpoint in `IP:Port` format or multiple endpoints in `IP:Port,IP:Port,...` format.\nFor example `10.0.0.5:8080` or `[2600:4040:5204::1574:24ae]:80`.\nThe IPv6 address is enclosed in square brackets.";
            type = (types.nullOr types.str);
            default = null;
          };
        };
      };
  mkJwtProviderRemoteJWKSBackendSettingsLoadBalancerEndpointOverrideExtractFrom =
    res:
    {
    }
    // optionalAttrs (res."header" != null) { inherit (res) "header"; }
    // {
    };
  JwtProviderRemoteJWKSBackendSettingsLoadBalancerEndpointOverrideModule = types.submodule {
    options = {
      "extractFrom" = mkOption {
        description = "ExtractFrom defines the sources to extract endpoint override information from.";
        type = (
          types.listOf JwtProviderRemoteJWKSBackendSettingsLoadBalancerEndpointOverrideExtractFromModule
        );
      };
    };
  };
  mkJwtProviderRemoteJWKSBackendSettingsLoadBalancerEndpointOverride = res: {
    "extractFrom" =
      map mkJwtProviderRemoteJWKSBackendSettingsLoadBalancerEndpointOverrideExtractFrom
        res."extractFrom";
  };
  JwtProviderRemoteJWKSBackendSettingsLoadBalancerModule = types.submodule {
    options = {
      "consistentHash" = mkOption {
        description = "ConsistentHash defines the configuration when the load balancer type is\nset to ConsistentHash";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsLoadBalancerConsistentHashModule);
        default = null;
      };
      "endpointOverride" = mkOption {
        description = "EndpointOverride defines the configuration for endpoint override.\nWhen specified, the load balancer will attempt to route requests to endpoints\nbased on the override information extracted from request headers or metadata.\n If the override endpoints are not available, the configured load balancer policy will be used as fallback.";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsLoadBalancerEndpointOverrideModule);
        default = null;
      };
      "slowStart" = mkOption {
        description = "SlowStart defines the configuration related to the slow start load balancer policy.\nIf set, during slow start window, traffic sent to the newly added hosts will gradually increase.\nCurrently this is only supported for RoundRobin and LeastRequest load balancers";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsLoadBalancerSlowStartModule);
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
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsLoadBalancerZoneAwareModule);
        default = null;
      };
    };
  };
  mkJwtProviderRemoteJWKSBackendSettingsLoadBalancer =
    res:
    {
    }
    // optionalAttrs (res."consistentHash" != null) {
      "consistentHash" =
        mkJwtProviderRemoteJWKSBackendSettingsLoadBalancerConsistentHash
          res."consistentHash";
    }
    // {
    }
    // optionalAttrs (res."endpointOverride" != null) {
      "endpointOverride" =
        mkJwtProviderRemoteJWKSBackendSettingsLoadBalancerEndpointOverride
          res."endpointOverride";
    }
    // {
    }
    // optionalAttrs (res."slowStart" != null) {
      "slowStart" = mkJwtProviderRemoteJWKSBackendSettingsLoadBalancerSlowStart res."slowStart";
    }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."zoneAware" != null) {
      "zoneAware" = mkJwtProviderRemoteJWKSBackendSettingsLoadBalancerZoneAware res."zoneAware";
    }
    // {
    };
  JwtProviderRemoteJWKSBackendSettingsLoadBalancerSlowStartModule = types.submodule {
    options = {
      "window" = mkOption {
        description = "Window defines the duration of the warm up period for newly added host.\nDuring slow start window, traffic sent to the newly added hosts will gradually increase.\nCurrently only supports linear growth of traffic. For additional details,\nsee https://www.envoyproxy.io/docs/envoy/latest/api-v3/config/cluster/v3/cluster.proto#config-cluster-v3-cluster-slowstartconfig";
        type = types.str;
      };
    };
  };
  mkJwtProviderRemoteJWKSBackendSettingsLoadBalancerSlowStart = res: {
    inherit (res) "window";
  };
  JwtProviderRemoteJWKSBackendSettingsLoadBalancerZoneAwareModule = types.submodule {
    options = {
      "preferLocal" = mkOption {
        description = "PreferLocalZone configures zone-aware routing to prefer sending traffic to the local locality zone.";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsLoadBalancerZoneAwarePreferLocalModule);
        default = null;
      };
    };
  };
  mkJwtProviderRemoteJWKSBackendSettingsLoadBalancerZoneAware =
    res:
    {
    }
    // optionalAttrs (res."preferLocal" != null) {
      "preferLocal" =
        mkJwtProviderRemoteJWKSBackendSettingsLoadBalancerZoneAwarePreferLocal
          res."preferLocal";
    }
    // {
    };
  JwtProviderRemoteJWKSBackendSettingsLoadBalancerZoneAwarePreferLocalForceModule = types.submodule {
    options = {
      "minEndpointsInZoneThreshold" = mkOption {
        description = "MinEndpointsInZoneThreshold is the minimum number of upstream endpoints in the local zone required to honor the forceLocalZone\noverride. This is useful for protecting zones with fewer endpoints.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkJwtProviderRemoteJWKSBackendSettingsLoadBalancerZoneAwarePreferLocalForce =
    res:
    {
    }
    // optionalAttrs (res."minEndpointsInZoneThreshold" != null) {
      inherit (res) "minEndpointsInZoneThreshold";
    }
    // {
    };
  JwtProviderRemoteJWKSBackendSettingsLoadBalancerZoneAwarePreferLocalModule = types.submodule {
    options = {
      "force" = mkOption {
        description = "ForceLocalZone defines override configuration for forcing all traffic to stay within the local zone instead of the default behavior\nwhich maintains equal distribution among upstream endpoints while sending as much traffic as possible locally.";
        type = (
          types.nullOr JwtProviderRemoteJWKSBackendSettingsLoadBalancerZoneAwarePreferLocalForceModule
        );
        default = null;
      };
      "minEndpointsThreshold" = mkOption {
        description = "MinEndpointsThreshold is the minimum number of total upstream endpoints across all zones required to enable zone-aware routing.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkJwtProviderRemoteJWKSBackendSettingsLoadBalancerZoneAwarePreferLocal =
    res:
    {
    }
    // optionalAttrs (res."force" != null) {
      "force" = mkJwtProviderRemoteJWKSBackendSettingsLoadBalancerZoneAwarePreferLocalForce res."force";
    }
    // {
    }
    // optionalAttrs (res."minEndpointsThreshold" != null) { inherit (res) "minEndpointsThreshold"; }
    // {
    };
  JwtProviderRemoteJWKSBackendSettingsModule = types.submodule {
    options = {
      "circuitBreaker" = mkOption {
        description = "Circuit Breaker settings for the upstream connections and requests.\nIf not set, circuit breakers will be enabled with the default thresholds";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsCircuitBreakerModule);
        default = null;
      };
      "connection" = mkOption {
        description = "Connection includes backend connection settings.";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsConnectionModule);
        default = null;
      };
      "dns" = mkOption {
        description = "DNS includes dns resolution settings.";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsDnsModule);
        default = null;
      };
      "healthCheck" = mkOption {
        description = "HealthCheck allows gateway to perform active health checking on backends.";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsHealthCheckModule);
        default = null;
      };
      "http2" = mkOption {
        description = "HTTP2 provides HTTP/2 configuration for backend connections.";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsHttp2Module);
        default = null;
      };
      "loadBalancer" = mkOption {
        description = "LoadBalancer policy to apply when routing traffic from the gateway to\nthe backend endpoints. Defaults to `LeastRequest`.";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsLoadBalancerModule);
        default = null;
      };
      "proxyProtocol" = mkOption {
        description = "ProxyProtocol enables the Proxy Protocol when communicating with the backend.";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsProxyProtocolModule);
        default = null;
      };
      "retry" = mkOption {
        description = "Retry provides more advanced usage, allowing users to customize the number of retries, retry fallback strategy, and retry triggering conditions.\nIf not set, retry will be disabled.";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsRetryModule);
        default = null;
      };
      "tcpKeepalive" = mkOption {
        description = "TcpKeepalive settings associated with the upstream client connection.\nDisabled by default.";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsTcpKeepaliveModule);
        default = null;
      };
      "timeout" = mkOption {
        description = "Timeout settings for the backend connections.";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsTimeoutModule);
        default = null;
      };
    };
  };
  mkJwtProviderRemoteJWKSBackendSettings =
    res:
    {
    }
    // optionalAttrs (res."circuitBreaker" != null) {
      "circuitBreaker" = mkJwtProviderRemoteJWKSBackendSettingsCircuitBreaker res."circuitBreaker";
    }
    // {
    }
    // optionalAttrs (res."connection" != null) {
      "connection" = mkJwtProviderRemoteJWKSBackendSettingsConnection res."connection";
    }
    // {
    }
    // optionalAttrs (res."dns" != null) {
      "dns" = mkJwtProviderRemoteJWKSBackendSettingsDns res."dns";
    }
    // {
    }
    // optionalAttrs (res."healthCheck" != null) {
      "healthCheck" = mkJwtProviderRemoteJWKSBackendSettingsHealthCheck res."healthCheck";
    }
    // {
    }
    // optionalAttrs (res."http2" != null) {
      "http2" = mkJwtProviderRemoteJWKSBackendSettingsHttp2 res."http2";
    }
    // {
    }
    // optionalAttrs (res."loadBalancer" != null) {
      "loadBalancer" = mkJwtProviderRemoteJWKSBackendSettingsLoadBalancer res."loadBalancer";
    }
    // {
    }
    // optionalAttrs (res."proxyProtocol" != null) {
      "proxyProtocol" = mkJwtProviderRemoteJWKSBackendSettingsProxyProtocol res."proxyProtocol";
    }
    // {
    }
    // optionalAttrs (res."retry" != null) {
      "retry" = mkJwtProviderRemoteJWKSBackendSettingsRetry res."retry";
    }
    // {
    }
    // optionalAttrs (res."tcpKeepalive" != null) {
      "tcpKeepalive" = mkJwtProviderRemoteJWKSBackendSettingsTcpKeepalive res."tcpKeepalive";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) {
      "timeout" = mkJwtProviderRemoteJWKSBackendSettingsTimeout res."timeout";
    }
    // {
    };
  JwtProviderRemoteJWKSBackendSettingsProxyProtocolModule = types.submodule {
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
  mkJwtProviderRemoteJWKSBackendSettingsProxyProtocol = res: {
    inherit (res) "version";
  };
  JwtProviderRemoteJWKSBackendSettingsRetryModule = types.submodule {
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
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsRetryPerRetryModule);
        default = null;
      };
      "retryOn" = mkOption {
        description = "RetryOn specifies the retry trigger condition.\n\nIf not specified, the default is to retry on connect-failure,refused-stream,unavailable,cancelled,retriable-status-codes(503).";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsRetryRetryOnModule);
        default = null;
      };
    };
  };
  mkJwtProviderRemoteJWKSBackendSettingsRetry =
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
      "perRetry" = mkJwtProviderRemoteJWKSBackendSettingsRetryPerRetry res."perRetry";
    }
    // {
    }
    // optionalAttrs (res."retryOn" != null) {
      "retryOn" = mkJwtProviderRemoteJWKSBackendSettingsRetryRetryOn res."retryOn";
    }
    // {
    };
  JwtProviderRemoteJWKSBackendSettingsRetryPerRetryBackOffModule = types.submodule {
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
  mkJwtProviderRemoteJWKSBackendSettingsRetryPerRetryBackOff =
    res:
    {
    }
    // optionalAttrs (res."baseInterval" != null) { inherit (res) "baseInterval"; }
    // {
    }
    // optionalAttrs (res."maxInterval" != null) { inherit (res) "maxInterval"; }
    // {
    };
  JwtProviderRemoteJWKSBackendSettingsRetryPerRetryModule = types.submodule {
    options = {
      "backOff" = mkOption {
        description = "Backoff is the backoff policy to be applied per retry attempt. gateway uses a fully jittered exponential\nback-off algorithm for retries. For additional details,\nsee https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/router_filter#config-http-filters-router-x-envoy-max-retries";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsRetryPerRetryBackOffModule);
        default = null;
      };
      "timeout" = mkOption {
        description = "Timeout is the timeout per retry attempt.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkJwtProviderRemoteJWKSBackendSettingsRetryPerRetry =
    res:
    {
    }
    // optionalAttrs (res."backOff" != null) {
      "backOff" = mkJwtProviderRemoteJWKSBackendSettingsRetryPerRetryBackOff res."backOff";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    };
  JwtProviderRemoteJWKSBackendSettingsRetryRetryOnModule = types.submodule {
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
  mkJwtProviderRemoteJWKSBackendSettingsRetryRetryOn =
    res:
    {
    }
    // optionalAttrs (res."httpStatusCodes" != [ ]) { inherit (res) "httpStatusCodes"; }
    // {
    }
    // optionalAttrs (res."triggers" != [ ]) { inherit (res) "triggers"; }
    // {
    };
  JwtProviderRemoteJWKSBackendSettingsTcpKeepaliveModule = types.submodule {
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
  mkJwtProviderRemoteJWKSBackendSettingsTcpKeepalive =
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
  JwtProviderRemoteJWKSBackendSettingsTimeoutHttpModule = types.submodule {
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
  mkJwtProviderRemoteJWKSBackendSettingsTimeoutHttp =
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
  JwtProviderRemoteJWKSBackendSettingsTimeoutModule = types.submodule {
    options = {
      "http" = mkOption {
        description = "Timeout settings for HTTP.";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsTimeoutHttpModule);
        default = null;
      };
      "tcp" = mkOption {
        description = "Timeout settings for TCP.";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsTimeoutTcpModule);
        default = null;
      };
    };
  };
  mkJwtProviderRemoteJWKSBackendSettingsTimeout =
    res:
    {
    }
    // optionalAttrs (res."http" != null) {
      "http" = mkJwtProviderRemoteJWKSBackendSettingsTimeoutHttp res."http";
    }
    // {
    }
    // optionalAttrs (res."tcp" != null) {
      "tcp" = mkJwtProviderRemoteJWKSBackendSettingsTimeoutTcp res."tcp";
    }
    // {
    };
  JwtProviderRemoteJWKSBackendSettingsTimeoutTcpModule = types.submodule {
    options = {
      "connectTimeout" = mkOption {
        description = "The timeout for network connection establishment, including TCP and TLS handshakes.\nDefault: 10 seconds.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkJwtProviderRemoteJWKSBackendSettingsTimeoutTcp =
    res:
    {
    }
    // optionalAttrs (res."connectTimeout" != null) { inherit (res) "connectTimeout"; }
    // {
    };
  JwtProviderRemoteJWKSModule = types.submodule {
    options = {
      "backendRef" = mkOption {
        description = "BackendRef references a Kubernetes object that represents the\nbackend server to which the authorization request will be sent.\n\nDeprecated: Use BackendRefs instead.";
        type = (types.nullOr JwtProviderRemoteJWKSBackendRefModule);
        default = null;
      };
      "backendRefs" = mkOption {
        description = "BackendRefs references a Kubernetes object that represents the\nbackend server to which the authorization request will be sent.";
        type = (types.listOf JwtProviderRemoteJWKSBackendRefModule);
        default = [ ];
      };
      "backendSettings" = mkOption {
        description = "BackendSettings holds configuration for managing the connection\nto the backend.";
        type = (types.nullOr JwtProviderRemoteJWKSBackendSettingsModule);
        default = null;
      };
      "uri" = mkOption {
        description = "URI is the HTTPS URI to fetch the JWKS. Envoy's system trust bundle is used to validate the server certificate.\nIf a custom trust bundle is needed, it can be specified in a BackendTLSConfig resource and target the BackendRefs.";
        type = types.str;
      };
    };
  };
  mkJwtProviderRemoteJWKS =
    res:
    {
    }
    // optionalAttrs (res."backendRef" != null) {
      "backendRef" = mkJwtProviderRemoteJWKSBackendRef res."backendRef";
    }
    // {
    }
    // optionalAttrs (res."backendRefs" != [ ]) {
      "backendRefs" = map mkJwtProviderRemoteJWKSBackendRef res."backendRefs";
    }
    // {
    }
    // optionalAttrs (res."backendSettings" != null) {
      "backendSettings" = mkJwtProviderRemoteJWKSBackendSettings res."backendSettings";
    }
    // {
      inherit (res) "uri";
    };
  OidcClientIDRefModule = types.submodule {
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
  mkOidcClientIDRef =
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
  OidcClientSecretModule = types.submodule {
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
  mkOidcClientSecret =
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
  OidcCookieConfigModule = types.submodule {
    options = {
      "sameSite" = mkOption {
        type = (
          types.nullOr (
            types.enum [
              "Lax"
              "Strict"
              "None"
            ]
          )
        );
        default = "Strict";
      };
    };
  };
  mkOidcCookieConfig =
    res:
    {
    }
    // optionalAttrs (res."sameSite" != null) { inherit (res) "sameSite"; }
    // {
    };
  OidcCookieNamesModule = types.submodule {
    options = {
      "accessToken" = mkOption {
        description = "The name of the cookie used to store the AccessToken in the\n[Authentication Request](https://openid.net/specs/openid-connect-core-1_0.html#AuthRequest).\nIf not specified, defaults to \"AccessToken-(randomly generated uid)\"";
        type = (types.nullOr types.str);
        default = null;
      };
      "idToken" = mkOption {
        description = "The name of the cookie used to store the IdToken in the\n[Authentication Request](https://openid.net/specs/openid-connect-core-1_0.html#AuthRequest).\nIf not specified, defaults to \"IdToken-(randomly generated uid)\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkOidcCookieNames =
    res:
    {
    }
    // optionalAttrs (res."accessToken" != null) { inherit (res) "accessToken"; }
    // {
    }
    // optionalAttrs (res."idToken" != null) { inherit (res) "idToken"; }
    // {
    };
  OidcDenyRedirectHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Specifies the name of the header in the request.";
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
  mkOidcDenyRedirectHeader =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
      inherit (res) "value";
    };
  OidcDenyRedirectModule = types.submodule {
    options = {
      "headers" = mkOption {
        description = "Defines the headers to match against the request to deny redirect to the OIDC Provider.";
        type = (types.listOf OidcDenyRedirectHeaderModule);
      };
    };
  };
  mkOidcDenyRedirect = res: {
    "headers" = map mkOidcDenyRedirectHeader res."headers";
  };
  OidcModule = types.submodule {
    options = {
      "clientID" = mkOption {
        description = "The client ID to be used in the OIDC\n[Authentication Request](https://openid.net/specs/openid-connect-core-1_0.html#AuthRequest).\n\nOnly one of clientID or clientIDRef must be set.";
        type = (types.nullOr types.str);
        default = null;
      };
      "clientIDRef" = mkOption {
        description = "The Kubernetes secret which contains the client ID to be used in the\n[Authentication Request](https://openid.net/specs/openid-connect-core-1_0.html#AuthRequest).\nExactly one of clientID or clientIDRef must be set.\nThis is an Opaque secret. The client ID should be stored in the key \"client-id\".\n\nOnly one of clientID or clientIDRef must be set.";
        type = (types.nullOr OidcClientIDRefModule);
        default = null;
      };
      "clientSecret" = mkOption {
        description = "The Kubernetes secret which contains the OIDC client secret to be used in the\n[Authentication Request](https://openid.net/specs/openid-connect-core-1_0.html#AuthRequest).\n\nThis is an Opaque secret. The client secret should be stored in the key\n\"client-secret\".";
        type = OidcClientSecretModule;
      };
      "cookieConfig" = mkOption {
        description = "CookieConfigs allows setting the SameSite attribute for OIDC cookies.\nBy default, its unset.";
        type = (types.nullOr OidcCookieConfigModule);
        default = null;
      };
      "cookieDomain" = mkOption {
        description = "The optional domain to set the access and ID token cookies on.\nIf not set, the cookies will default to the host of the request, not including the subdomains.\nIf set, the cookies will be set on the specified domain and all subdomains.\nThis means that requests to any subdomain will not require reauthentication after users log in to the parent domain.";
        type = (types.nullOr types.str);
        default = null;
      };
      "cookieNames" = mkOption {
        description = "The optional cookie name overrides to be used for Bearer and IdToken cookies in the\n[Authentication Request](https://openid.net/specs/openid-connect-core-1_0.html#AuthRequest).\nIf not specified, uses a randomly generated suffix";
        type = (types.nullOr OidcCookieNamesModule);
        default = null;
      };
      "defaultRefreshTokenTTL" = mkOption {
        description = "DefaultRefreshTokenTTL is the default lifetime of the refresh token.\nThis field is only used when the exp (expiration time) claim is omitted in\nthe refresh token or the refresh token is not JWT.\n\nIf not specified, defaults to 604800s (one week).\nNote: this field is only applicable when the \"refreshToken\" field is set to true.";
        type = (types.nullOr types.str);
        default = null;
      };
      "defaultTokenTTL" = mkOption {
        description = "DefaultTokenTTL is the default lifetime of the id token and access token.\nPlease note that Envoy will always use the expiry time from the response\nof the authorization server if it is provided. This field is only used when\nthe expiry time is not provided by the authorization.\n\nIf not specified, defaults to 0. In this case, the \"expires_in\" field in\nthe authorization response must be set by the authorization server, or the\nOAuth flow will fail.";
        type = (types.nullOr types.str);
        default = null;
      };
      "denyRedirect" = mkOption {
        description = "Any request that matches any of the provided matchers (with either tokens that are expired or missing tokens) will not be redirected to the OIDC Provider.\nThis behavior can be useful for AJAX or machine requests.";
        type = (types.nullOr OidcDenyRedirectModule);
        default = null;
      };
      "forwardAccessToken" = mkOption {
        description = "ForwardAccessToken indicates whether the Envoy should forward the access token\nvia the Authorization header Bearer scheme to the upstream.\nIf not specified, defaults to false.";
        type = types.bool;
        default = false;
      };
      "logoutPath" = mkOption {
        description = "The path to log a user out, clearing their credential cookies.\n\nIf not specified, uses a default logout path \"/logout\"";
        type = (types.nullOr types.str);
        default = null;
      };
      "passThroughAuthHeader" = mkOption {
        description = "Skips OIDC authentication when the request contains a header that will be extracted by the JWT filter. Unless\nexplicitly stated otherwise in the extractFrom field, this will be the \"Authorization: Bearer ...\" header.\n\nThe passThroughAuthHeader option is typically used for non-browser clients that may not be able to handle OIDC\nredirects and wish to directly supply a token instead.\n\nIf not specified, defaults to false.";
        type = types.bool;
        default = false;
      };
      "provider" = mkOption {
        description = "The OIDC Provider configuration.";
        type = OidcProviderModule;
      };
      "redirectURL" = mkOption {
        description = "The redirect URL to be used in the OIDC\n[Authentication Request](https://openid.net/specs/openid-connect-core-1_0.html#AuthRequest).\nIf not specified, uses the default redirect URI \"%REQ(x-forwarded-proto)%://%REQ(:authority)%/oauth2/callback\"";
        type = (types.nullOr types.str);
        default = null;
      };
      "refreshToken" = mkOption {
        description = "RefreshToken indicates whether the Envoy should automatically refresh the\nid token and access token when they expire.\nWhen set to true, the Envoy will use the refresh token to get a new id token\nand access token when they expire.\n\nIf not specified, defaults to false.";
        type = types.bool;
        default = false;
      };
      "resources" = mkOption {
        description = "The OIDC resources to be used in the\n[Authentication Request](https://openid.net/specs/openid-connect-core-1_0.html#AuthRequest).";
        type = (types.listOf types.str);
        default = [ ];
      };
      "scopes" = mkOption {
        description = "The OIDC scopes to be used in the\n[Authentication Request](https://openid.net/specs/openid-connect-core-1_0.html#AuthRequest).\nThe \"openid\" scope is always added to the list of scopes if not already\nspecified.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkOidc =
    res:
    {
    }
    // optionalAttrs (res."clientID" != null) { inherit (res) "clientID"; }
    // {
    }
    // optionalAttrs (res."clientIDRef" != null) {
      "clientIDRef" = mkOidcClientIDRef res."clientIDRef";
    }
    // {
      "clientSecret" = mkOidcClientSecret res."clientSecret";
    }
    // optionalAttrs (res."cookieConfig" != null) {
      "cookieConfig" = mkOidcCookieConfig res."cookieConfig";
    }
    // {
    }
    // optionalAttrs (res."cookieDomain" != null) { inherit (res) "cookieDomain"; }
    // {
    }
    // optionalAttrs (res."cookieNames" != null) {
      "cookieNames" = mkOidcCookieNames res."cookieNames";
    }
    // {
    }
    // optionalAttrs (res."defaultRefreshTokenTTL" != null) { inherit (res) "defaultRefreshTokenTTL"; }
    // {
    }
    // optionalAttrs (res."defaultTokenTTL" != null) { inherit (res) "defaultTokenTTL"; }
    // {
    }
    // optionalAttrs (res."denyRedirect" != null) {
      "denyRedirect" = mkOidcDenyRedirect res."denyRedirect";
    }
    // {
    }
    // optionalAttrs res."forwardAccessToken" { inherit (res) "forwardAccessToken"; }
    // {
    }
    // optionalAttrs (res."logoutPath" != null) { inherit (res) "logoutPath"; }
    // {
    }
    // optionalAttrs res."passThroughAuthHeader" { inherit (res) "passThroughAuthHeader"; }
    // {
      "provider" = mkOidcProvider res."provider";
    }
    // optionalAttrs (res."redirectURL" != null) { inherit (res) "redirectURL"; }
    // {
    }
    // optionalAttrs res."refreshToken" { inherit (res) "refreshToken"; }
    // {
    }
    // optionalAttrs (res."resources" != [ ]) { inherit (res) "resources"; }
    // {
    }
    // optionalAttrs (res."scopes" != [ ]) { inherit (res) "scopes"; }
    // {
    };
  OidcProviderBackendRefModule = types.submodule {
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
  mkOidcProviderBackendRef =
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
  OidcProviderBackendSettingsCircuitBreakerModule = types.submodule {
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
        type = (types.nullOr OidcProviderBackendSettingsCircuitBreakerPerEndpointModule);
        default = null;
      };
    };
  };
  mkOidcProviderBackendSettingsCircuitBreaker =
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
      "perEndpoint" = mkOidcProviderBackendSettingsCircuitBreakerPerEndpoint res."perEndpoint";
    }
    // {
    };
  OidcProviderBackendSettingsCircuitBreakerPerEndpointModule = types.submodule {
    options = {
      "maxConnections" = mkOption {
        description = "MaxConnections configures the maximum number of connections that Envoy will establish per-endpoint to the referenced backend defined within a xRoute rule.";
        type = (types.nullOr types.int);
        default = 1024;
      };
    };
  };
  mkOidcProviderBackendSettingsCircuitBreakerPerEndpoint =
    res:
    {
    }
    // optionalAttrs (res."maxConnections" != null) { inherit (res) "maxConnections"; }
    // {
    };
  OidcProviderBackendSettingsConnectionModule = types.submodule {
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
  mkOidcProviderBackendSettingsConnection =
    res:
    {
    }
    // optionalAttrs (res."bufferLimit" != null) { inherit (res) "bufferLimit"; }
    // {
    }
    // optionalAttrs (res."socketBufferLimit" != null) { inherit (res) "socketBufferLimit"; }
    // {
    };
  OidcProviderBackendSettingsDnsModule = types.submodule {
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
  mkOidcProviderBackendSettingsDns =
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
  OidcProviderBackendSettingsHealthCheckActiveGrpcModule = types.submodule {
    options = {
      "service" = mkOption {
        description = "Service to send in the health check request.\nIf this is not specified, then the health check request applies to the entire\nserver and not to a specific service.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkOidcProviderBackendSettingsHealthCheckActiveGrpc =
    res:
    {
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  OidcProviderBackendSettingsHealthCheckActiveHttpExpectedResponseModule = types.submodule {
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
  mkOidcProviderBackendSettingsHealthCheckActiveHttpExpectedResponse =
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
  OidcProviderBackendSettingsHealthCheckActiveHttpModule = types.submodule {
    options = {
      "expectedResponse" = mkOption {
        description = "ExpectedResponse defines a list of HTTP expected responses to match.";
        type = (types.nullOr OidcProviderBackendSettingsHealthCheckActiveHttpExpectedResponseModule);
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
  mkOidcProviderBackendSettingsHealthCheckActiveHttp =
    res:
    {
    }
    // optionalAttrs (res."expectedResponse" != null) {
      "expectedResponse" =
        mkOidcProviderBackendSettingsHealthCheckActiveHttpExpectedResponse
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
  OidcProviderBackendSettingsHealthCheckActiveModule = types.submodule {
    options = {
      "grpc" = mkOption {
        description = "GRPC defines the configuration of the GRPC health checker.\nIt's optional, and can only be used if the specified type is GRPC.";
        type = (types.nullOr OidcProviderBackendSettingsHealthCheckActiveGrpcModule);
        default = null;
      };
      "healthyThreshold" = mkOption {
        description = "HealthyThreshold defines the number of healthy health checks required before a backend host is marked healthy.";
        type = (types.nullOr types.int);
        default = 1;
      };
      "http" = mkOption {
        description = "HTTP defines the configuration of http health checker.\nIt's required while the health checker type is HTTP.";
        type = (types.nullOr OidcProviderBackendSettingsHealthCheckActiveHttpModule);
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
        type = (types.nullOr OidcProviderBackendSettingsHealthCheckActiveTcpModule);
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
  mkOidcProviderBackendSettingsHealthCheckActive =
    res:
    {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkOidcProviderBackendSettingsHealthCheckActiveGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."healthyThreshold" != null) { inherit (res) "healthyThreshold"; }
    // {
    }
    // optionalAttrs (res."http" != null) {
      "http" = mkOidcProviderBackendSettingsHealthCheckActiveHttp res."http";
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
      "tcp" = mkOidcProviderBackendSettingsHealthCheckActiveTcp res."tcp";
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
  OidcProviderBackendSettingsHealthCheckActiveTcpModule = types.submodule {
    options = {
      "receive" = mkOption {
        description = "Receive defines the expected response payload.";
        type = (types.nullOr OidcProviderBackendSettingsHealthCheckActiveTcpReceiveModule);
        default = null;
      };
      "send" = mkOption {
        description = "Send defines the request payload.";
        type = (types.nullOr OidcProviderBackendSettingsHealthCheckActiveTcpSendModule);
        default = null;
      };
    };
  };
  mkOidcProviderBackendSettingsHealthCheckActiveTcp =
    res:
    {
    }
    // optionalAttrs (res."receive" != null) {
      "receive" = mkOidcProviderBackendSettingsHealthCheckActiveTcpReceive res."receive";
    }
    // {
    }
    // optionalAttrs (res."send" != null) {
      "send" = mkOidcProviderBackendSettingsHealthCheckActiveTcpSend res."send";
    }
    // {
    };
  OidcProviderBackendSettingsHealthCheckActiveTcpReceiveModule = types.submodule {
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
  mkOidcProviderBackendSettingsHealthCheckActiveTcpReceive =
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
  OidcProviderBackendSettingsHealthCheckActiveTcpSendModule = types.submodule {
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
  mkOidcProviderBackendSettingsHealthCheckActiveTcpSend =
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
  OidcProviderBackendSettingsHealthCheckModule = types.submodule {
    options = {
      "active" = mkOption {
        description = "Active health check configuration";
        type = (types.nullOr OidcProviderBackendSettingsHealthCheckActiveModule);
        default = null;
      };
      "panicThreshold" = mkOption {
        description = "When number of unhealthy endpoints for a backend reaches this threshold\nEnvoy will disregard health status and balance across all endpoints.\nIt's designed to prevent a situation in which host failures cascade throughout the cluster\nas load increases. If not set, the default value is 50%. To disable panic mode, set value to `0`.";
        type = (types.nullOr types.int);
        default = null;
      };
      "passive" = mkOption {
        description = "Passive passive check configuration";
        type = (types.nullOr OidcProviderBackendSettingsHealthCheckPassiveModule);
        default = null;
      };
    };
  };
  mkOidcProviderBackendSettingsHealthCheck =
    res:
    {
    }
    // optionalAttrs (res."active" != null) {
      "active" = mkOidcProviderBackendSettingsHealthCheckActive res."active";
    }
    // {
    }
    // optionalAttrs (res."panicThreshold" != null) { inherit (res) "panicThreshold"; }
    // {
    }
    // optionalAttrs (res."passive" != null) {
      "passive" = mkOidcProviderBackendSettingsHealthCheckPassive res."passive";
    }
    // {
    };
  OidcProviderBackendSettingsHealthCheckPassiveModule = types.submodule {
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
  mkOidcProviderBackendSettingsHealthCheckPassive =
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
  OidcProviderBackendSettingsHttp2Module = types.submodule {
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
  mkOidcProviderBackendSettingsHttp2 =
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
  OidcProviderBackendSettingsLoadBalancerConsistentHashCookieModule = types.submodule {
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
  mkOidcProviderBackendSettingsLoadBalancerConsistentHashCookie =
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
  OidcProviderBackendSettingsLoadBalancerConsistentHashHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the header to hash.";
        type = types.str;
      };
    };
  };
  mkOidcProviderBackendSettingsLoadBalancerConsistentHashHeader = res: {
    inherit (res) "name";
  };
  OidcProviderBackendSettingsLoadBalancerConsistentHashModule = types.submodule {
    options = {
      "cookie" = mkOption {
        description = "Cookie configures the cookie hash policy when the consistent hash type is set to Cookie.";
        type = (types.nullOr OidcProviderBackendSettingsLoadBalancerConsistentHashCookieModule);
        default = null;
      };
      "header" = mkOption {
        description = "Header configures the header hash policy when the consistent hash type is set to Header.";
        type = (types.nullOr OidcProviderBackendSettingsLoadBalancerConsistentHashHeaderModule);
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
  mkOidcProviderBackendSettingsLoadBalancerConsistentHash =
    res:
    {
    }
    // optionalAttrs (res."cookie" != null) {
      "cookie" = mkOidcProviderBackendSettingsLoadBalancerConsistentHashCookie res."cookie";
    }
    // {
    }
    // optionalAttrs (res."header" != null) {
      "header" = mkOidcProviderBackendSettingsLoadBalancerConsistentHashHeader res."header";
    }
    // {
    }
    // optionalAttrs (res."tableSize" != null) { inherit (res) "tableSize"; }
    // {
      inherit (res) "type";
    };
  OidcProviderBackendSettingsLoadBalancerEndpointOverrideExtractFromModule = types.submodule {
    options = {
      "header" = mkOption {
        description = "Header defines the header to get the override endpoint addresses.\nThe header value must specify at least one endpoint in `IP:Port` format or multiple endpoints in `IP:Port,IP:Port,...` format.\nFor example `10.0.0.5:8080` or `[2600:4040:5204::1574:24ae]:80`.\nThe IPv6 address is enclosed in square brackets.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkOidcProviderBackendSettingsLoadBalancerEndpointOverrideExtractFrom =
    res:
    {
    }
    // optionalAttrs (res."header" != null) { inherit (res) "header"; }
    // {
    };
  OidcProviderBackendSettingsLoadBalancerEndpointOverrideModule = types.submodule {
    options = {
      "extractFrom" = mkOption {
        description = "ExtractFrom defines the sources to extract endpoint override information from.";
        type = (types.listOf OidcProviderBackendSettingsLoadBalancerEndpointOverrideExtractFromModule);
      };
    };
  };
  mkOidcProviderBackendSettingsLoadBalancerEndpointOverride = res: {
    "extractFrom" =
      map mkOidcProviderBackendSettingsLoadBalancerEndpointOverrideExtractFrom
        res."extractFrom";
  };
  OidcProviderBackendSettingsLoadBalancerModule = types.submodule {
    options = {
      "consistentHash" = mkOption {
        description = "ConsistentHash defines the configuration when the load balancer type is\nset to ConsistentHash";
        type = (types.nullOr OidcProviderBackendSettingsLoadBalancerConsistentHashModule);
        default = null;
      };
      "endpointOverride" = mkOption {
        description = "EndpointOverride defines the configuration for endpoint override.\nWhen specified, the load balancer will attempt to route requests to endpoints\nbased on the override information extracted from request headers or metadata.\n If the override endpoints are not available, the configured load balancer policy will be used as fallback.";
        type = (types.nullOr OidcProviderBackendSettingsLoadBalancerEndpointOverrideModule);
        default = null;
      };
      "slowStart" = mkOption {
        description = "SlowStart defines the configuration related to the slow start load balancer policy.\nIf set, during slow start window, traffic sent to the newly added hosts will gradually increase.\nCurrently this is only supported for RoundRobin and LeastRequest load balancers";
        type = (types.nullOr OidcProviderBackendSettingsLoadBalancerSlowStartModule);
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
        type = (types.nullOr OidcProviderBackendSettingsLoadBalancerZoneAwareModule);
        default = null;
      };
    };
  };
  mkOidcProviderBackendSettingsLoadBalancer =
    res:
    {
    }
    // optionalAttrs (res."consistentHash" != null) {
      "consistentHash" = mkOidcProviderBackendSettingsLoadBalancerConsistentHash res."consistentHash";
    }
    // {
    }
    // optionalAttrs (res."endpointOverride" != null) {
      "endpointOverride" =
        mkOidcProviderBackendSettingsLoadBalancerEndpointOverride
          res."endpointOverride";
    }
    // {
    }
    // optionalAttrs (res."slowStart" != null) {
      "slowStart" = mkOidcProviderBackendSettingsLoadBalancerSlowStart res."slowStart";
    }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."zoneAware" != null) {
      "zoneAware" = mkOidcProviderBackendSettingsLoadBalancerZoneAware res."zoneAware";
    }
    // {
    };
  OidcProviderBackendSettingsLoadBalancerSlowStartModule = types.submodule {
    options = {
      "window" = mkOption {
        description = "Window defines the duration of the warm up period for newly added host.\nDuring slow start window, traffic sent to the newly added hosts will gradually increase.\nCurrently only supports linear growth of traffic. For additional details,\nsee https://www.envoyproxy.io/docs/envoy/latest/api-v3/config/cluster/v3/cluster.proto#config-cluster-v3-cluster-slowstartconfig";
        type = types.str;
      };
    };
  };
  mkOidcProviderBackendSettingsLoadBalancerSlowStart = res: {
    inherit (res) "window";
  };
  OidcProviderBackendSettingsLoadBalancerZoneAwareModule = types.submodule {
    options = {
      "preferLocal" = mkOption {
        description = "PreferLocalZone configures zone-aware routing to prefer sending traffic to the local locality zone.";
        type = (types.nullOr OidcProviderBackendSettingsLoadBalancerZoneAwarePreferLocalModule);
        default = null;
      };
    };
  };
  mkOidcProviderBackendSettingsLoadBalancerZoneAware =
    res:
    {
    }
    // optionalAttrs (res."preferLocal" != null) {
      "preferLocal" = mkOidcProviderBackendSettingsLoadBalancerZoneAwarePreferLocal res."preferLocal";
    }
    // {
    };
  OidcProviderBackendSettingsLoadBalancerZoneAwarePreferLocalForceModule = types.submodule {
    options = {
      "minEndpointsInZoneThreshold" = mkOption {
        description = "MinEndpointsInZoneThreshold is the minimum number of upstream endpoints in the local zone required to honor the forceLocalZone\noverride. This is useful for protecting zones with fewer endpoints.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkOidcProviderBackendSettingsLoadBalancerZoneAwarePreferLocalForce =
    res:
    {
    }
    // optionalAttrs (res."minEndpointsInZoneThreshold" != null) {
      inherit (res) "minEndpointsInZoneThreshold";
    }
    // {
    };
  OidcProviderBackendSettingsLoadBalancerZoneAwarePreferLocalModule = types.submodule {
    options = {
      "force" = mkOption {
        description = "ForceLocalZone defines override configuration for forcing all traffic to stay within the local zone instead of the default behavior\nwhich maintains equal distribution among upstream endpoints while sending as much traffic as possible locally.";
        type = (types.nullOr OidcProviderBackendSettingsLoadBalancerZoneAwarePreferLocalForceModule);
        default = null;
      };
      "minEndpointsThreshold" = mkOption {
        description = "MinEndpointsThreshold is the minimum number of total upstream endpoints across all zones required to enable zone-aware routing.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkOidcProviderBackendSettingsLoadBalancerZoneAwarePreferLocal =
    res:
    {
    }
    // optionalAttrs (res."force" != null) {
      "force" = mkOidcProviderBackendSettingsLoadBalancerZoneAwarePreferLocalForce res."force";
    }
    // {
    }
    // optionalAttrs (res."minEndpointsThreshold" != null) { inherit (res) "minEndpointsThreshold"; }
    // {
    };
  OidcProviderBackendSettingsModule = types.submodule {
    options = {
      "circuitBreaker" = mkOption {
        description = "Circuit Breaker settings for the upstream connections and requests.\nIf not set, circuit breakers will be enabled with the default thresholds";
        type = (types.nullOr OidcProviderBackendSettingsCircuitBreakerModule);
        default = null;
      };
      "connection" = mkOption {
        description = "Connection includes backend connection settings.";
        type = (types.nullOr OidcProviderBackendSettingsConnectionModule);
        default = null;
      };
      "dns" = mkOption {
        description = "DNS includes dns resolution settings.";
        type = (types.nullOr OidcProviderBackendSettingsDnsModule);
        default = null;
      };
      "healthCheck" = mkOption {
        description = "HealthCheck allows gateway to perform active health checking on backends.";
        type = (types.nullOr OidcProviderBackendSettingsHealthCheckModule);
        default = null;
      };
      "http2" = mkOption {
        description = "HTTP2 provides HTTP/2 configuration for backend connections.";
        type = (types.nullOr OidcProviderBackendSettingsHttp2Module);
        default = null;
      };
      "loadBalancer" = mkOption {
        description = "LoadBalancer policy to apply when routing traffic from the gateway to\nthe backend endpoints. Defaults to `LeastRequest`.";
        type = (types.nullOr OidcProviderBackendSettingsLoadBalancerModule);
        default = null;
      };
      "proxyProtocol" = mkOption {
        description = "ProxyProtocol enables the Proxy Protocol when communicating with the backend.";
        type = (types.nullOr OidcProviderBackendSettingsProxyProtocolModule);
        default = null;
      };
      "retry" = mkOption {
        description = "Retry provides more advanced usage, allowing users to customize the number of retries, retry fallback strategy, and retry triggering conditions.\nIf not set, retry will be disabled.";
        type = (types.nullOr OidcProviderBackendSettingsRetryModule);
        default = null;
      };
      "tcpKeepalive" = mkOption {
        description = "TcpKeepalive settings associated with the upstream client connection.\nDisabled by default.";
        type = (types.nullOr OidcProviderBackendSettingsTcpKeepaliveModule);
        default = null;
      };
      "timeout" = mkOption {
        description = "Timeout settings for the backend connections.";
        type = (types.nullOr OidcProviderBackendSettingsTimeoutModule);
        default = null;
      };
    };
  };
  mkOidcProviderBackendSettings =
    res:
    {
    }
    // optionalAttrs (res."circuitBreaker" != null) {
      "circuitBreaker" = mkOidcProviderBackendSettingsCircuitBreaker res."circuitBreaker";
    }
    // {
    }
    // optionalAttrs (res."connection" != null) {
      "connection" = mkOidcProviderBackendSettingsConnection res."connection";
    }
    // {
    }
    // optionalAttrs (res."dns" != null) { "dns" = mkOidcProviderBackendSettingsDns res."dns"; }
    // {
    }
    // optionalAttrs (res."healthCheck" != null) {
      "healthCheck" = mkOidcProviderBackendSettingsHealthCheck res."healthCheck";
    }
    // {
    }
    // optionalAttrs (res."http2" != null) { "http2" = mkOidcProviderBackendSettingsHttp2 res."http2"; }
    // {
    }
    // optionalAttrs (res."loadBalancer" != null) {
      "loadBalancer" = mkOidcProviderBackendSettingsLoadBalancer res."loadBalancer";
    }
    // {
    }
    // optionalAttrs (res."proxyProtocol" != null) {
      "proxyProtocol" = mkOidcProviderBackendSettingsProxyProtocol res."proxyProtocol";
    }
    // {
    }
    // optionalAttrs (res."retry" != null) { "retry" = mkOidcProviderBackendSettingsRetry res."retry"; }
    // {
    }
    // optionalAttrs (res."tcpKeepalive" != null) {
      "tcpKeepalive" = mkOidcProviderBackendSettingsTcpKeepalive res."tcpKeepalive";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) {
      "timeout" = mkOidcProviderBackendSettingsTimeout res."timeout";
    }
    // {
    };
  OidcProviderBackendSettingsProxyProtocolModule = types.submodule {
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
  mkOidcProviderBackendSettingsProxyProtocol = res: {
    inherit (res) "version";
  };
  OidcProviderBackendSettingsRetryModule = types.submodule {
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
        type = (types.nullOr OidcProviderBackendSettingsRetryPerRetryModule);
        default = null;
      };
      "retryOn" = mkOption {
        description = "RetryOn specifies the retry trigger condition.\n\nIf not specified, the default is to retry on connect-failure,refused-stream,unavailable,cancelled,retriable-status-codes(503).";
        type = (types.nullOr OidcProviderBackendSettingsRetryRetryOnModule);
        default = null;
      };
    };
  };
  mkOidcProviderBackendSettingsRetry =
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
      "perRetry" = mkOidcProviderBackendSettingsRetryPerRetry res."perRetry";
    }
    // {
    }
    // optionalAttrs (res."retryOn" != null) {
      "retryOn" = mkOidcProviderBackendSettingsRetryRetryOn res."retryOn";
    }
    // {
    };
  OidcProviderBackendSettingsRetryPerRetryBackOffModule = types.submodule {
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
  mkOidcProviderBackendSettingsRetryPerRetryBackOff =
    res:
    {
    }
    // optionalAttrs (res."baseInterval" != null) { inherit (res) "baseInterval"; }
    // {
    }
    // optionalAttrs (res."maxInterval" != null) { inherit (res) "maxInterval"; }
    // {
    };
  OidcProviderBackendSettingsRetryPerRetryModule = types.submodule {
    options = {
      "backOff" = mkOption {
        description = "Backoff is the backoff policy to be applied per retry attempt. gateway uses a fully jittered exponential\nback-off algorithm for retries. For additional details,\nsee https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/router_filter#config-http-filters-router-x-envoy-max-retries";
        type = (types.nullOr OidcProviderBackendSettingsRetryPerRetryBackOffModule);
        default = null;
      };
      "timeout" = mkOption {
        description = "Timeout is the timeout per retry attempt.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkOidcProviderBackendSettingsRetryPerRetry =
    res:
    {
    }
    // optionalAttrs (res."backOff" != null) {
      "backOff" = mkOidcProviderBackendSettingsRetryPerRetryBackOff res."backOff";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    };
  OidcProviderBackendSettingsRetryRetryOnModule = types.submodule {
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
  mkOidcProviderBackendSettingsRetryRetryOn =
    res:
    {
    }
    // optionalAttrs (res."httpStatusCodes" != [ ]) { inherit (res) "httpStatusCodes"; }
    // {
    }
    // optionalAttrs (res."triggers" != [ ]) { inherit (res) "triggers"; }
    // {
    };
  OidcProviderBackendSettingsTcpKeepaliveModule = types.submodule {
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
  mkOidcProviderBackendSettingsTcpKeepalive =
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
  OidcProviderBackendSettingsTimeoutHttpModule = types.submodule {
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
  mkOidcProviderBackendSettingsTimeoutHttp =
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
  OidcProviderBackendSettingsTimeoutModule = types.submodule {
    options = {
      "http" = mkOption {
        description = "Timeout settings for HTTP.";
        type = (types.nullOr OidcProviderBackendSettingsTimeoutHttpModule);
        default = null;
      };
      "tcp" = mkOption {
        description = "Timeout settings for TCP.";
        type = (types.nullOr OidcProviderBackendSettingsTimeoutTcpModule);
        default = null;
      };
    };
  };
  mkOidcProviderBackendSettingsTimeout =
    res:
    {
    }
    // optionalAttrs (res."http" != null) {
      "http" = mkOidcProviderBackendSettingsTimeoutHttp res."http";
    }
    // {
    }
    // optionalAttrs (res."tcp" != null) { "tcp" = mkOidcProviderBackendSettingsTimeoutTcp res."tcp"; }
    // {
    };
  OidcProviderBackendSettingsTimeoutTcpModule = types.submodule {
    options = {
      "connectTimeout" = mkOption {
        description = "The timeout for network connection establishment, including TCP and TLS handshakes.\nDefault: 10 seconds.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkOidcProviderBackendSettingsTimeoutTcp =
    res:
    {
    }
    // optionalAttrs (res."connectTimeout" != null) { inherit (res) "connectTimeout"; }
    // {
    };
  OidcProviderModule = types.submodule {
    options = {
      "authorizationEndpoint" = mkOption {
        description = "The OIDC Provider's [authorization endpoint](https://openid.net/specs/openid-connect-core-1_0.html#AuthorizationEndpoint).\nIf not provided, EG will try to discover it from the provider's [Well-Known Configuration Endpoint](https://openid.net/specs/openid-connect-discovery-1_0.html#ProviderConfigurationResponse).";
        type = (types.nullOr types.str);
        default = null;
      };
      "backendRef" = mkOption {
        description = "BackendRef references a Kubernetes object that represents the\nbackend server to which the authorization request will be sent.\n\nDeprecated: Use BackendRefs instead.";
        type = (types.nullOr OidcProviderBackendRefModule);
        default = null;
      };
      "backendRefs" = mkOption {
        description = "BackendRefs references a Kubernetes object that represents the\nbackend server to which the authorization request will be sent.";
        type = (types.listOf OidcProviderBackendRefModule);
        default = [ ];
      };
      "backendSettings" = mkOption {
        description = "BackendSettings holds configuration for managing the connection\nto the backend.";
        type = (types.nullOr OidcProviderBackendSettingsModule);
        default = null;
      };
      "endSessionEndpoint" = mkOption {
        description = "The OIDC Provider's [end session endpoint](https://openid.net/specs/openid-connect-core-1_0.html#RPLogout).\n\nIf the end session endpoint is provided, EG will use it to log out the user from the OIDC Provider when the user accesses the logout path.\nEG will also try to discover the end session endpoint from the provider's [Well-Known Configuration Endpoint](https://openid.net/specs/openid-connect-discovery-1_0.html#ProviderConfigurationResponse) when authorizationEndpoint or tokenEndpoint is not provided.";
        type = (types.nullOr types.str);
        default = null;
      };
      "issuer" = mkOption {
        description = "The OIDC Provider's [issuer identifier](https://openid.net/specs/openid-connect-discovery-1_0.html#IssuerDiscovery).\nIssuer MUST be a URI RFC 3986 [RFC3986] with a scheme component that MUST\nbe https, a host component, and optionally, port and path components and\nno query or fragment components.";
        type = types.str;
      };
      "tokenEndpoint" = mkOption {
        description = "The OIDC Provider's [token endpoint](https://openid.net/specs/openid-connect-core-1_0.html#TokenEndpoint).\nIf not provided, EG will try to discover it from the provider's [Well-Known Configuration Endpoint](https://openid.net/specs/openid-connect-discovery-1_0.html#ProviderConfigurationResponse).";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkOidcProvider =
    res:
    {
    }
    // optionalAttrs (res."authorizationEndpoint" != null) { inherit (res) "authorizationEndpoint"; }
    // {
    }
    // optionalAttrs (res."backendRef" != null) {
      "backendRef" = mkOidcProviderBackendRef res."backendRef";
    }
    // {
    }
    // optionalAttrs (res."backendRefs" != [ ]) {
      "backendRefs" = map mkOidcProviderBackendRef res."backendRefs";
    }
    // {
    }
    // optionalAttrs (res."backendSettings" != null) {
      "backendSettings" = mkOidcProviderBackendSettings res."backendSettings";
    }
    // {
    }
    // optionalAttrs (res."endSessionEndpoint" != null) { inherit (res) "endSessionEndpoint"; }
    // {
      inherit (res) "issuer";
    }
    // optionalAttrs (res."tokenEndpoint" != null) { inherit (res) "tokenEndpoint"; }
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
  SecuritypoliciesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this SecurityPolicy resource.";
        };
        "apiKeyAuth" = mkOption {
          description = "APIKeyAuth defines the configuration for the API Key Authentication.";
          type = (types.nullOr ApiKeyAuthModule);
          default = null;
        };
        "authorization" = mkOption {
          description = "Authorization defines the authorization configuration.";
          type = (types.nullOr AuthorizationModule);
          default = null;
        };
        "basicAuth" = mkOption {
          description = "BasicAuth defines the configuration for the HTTP Basic Authentication.";
          type = (types.nullOr BasicAuthModule);
          default = null;
        };
        "cors" = mkOption {
          description = "CORS defines the configuration for Cross-Origin Resource Sharing (CORS).";
          type = (types.nullOr CorsModule);
          default = null;
        };
        "extAuth" = mkOption {
          description = "ExtAuth defines the configuration for External Authorization.";
          type = (types.nullOr ExtAuthModule);
          default = null;
        };
        "jwt" = mkOption {
          description = "JWT defines the configuration for JSON Web Token (JWT) authentication.";
          type = (types.nullOr JwtModule);
          default = null;
        };
        "oidc" = mkOption {
          description = "OIDC defines the configuration for the OpenID Connect (OIDC) authentication.";
          type = (types.nullOr OidcModule);
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
      };
    }
  );
  mkSecurityPolicy = name: res: {
    apiVersion = "gateway.envoyproxy.io/v1alpha1";
    kind = "SecurityPolicy";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."apiKeyAuth" != null) { "apiKeyAuth" = mkApiKeyAuth res."apiKeyAuth"; }
    // {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) { "basicAuth" = mkBasicAuth res."basicAuth"; }
    // {
    }
    // optionalAttrs (res."cors" != null) { "cors" = mkCors res."cors"; }
    // {
    }
    // optionalAttrs (res."extAuth" != null) { "extAuth" = mkExtAuth res."extAuth"; }
    // {
    }
    // optionalAttrs (res."jwt" != null) { "jwt" = mkJwt res."jwt"; }
    // {
    }
    // optionalAttrs (res."oidc" != null) { "oidc" = mkOidc res."oidc"; }
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
    };
  };
  allResources = (mapAttrsToList mkSecurityPolicy cfg."securitypolicies");
in
{
  options.openkrill.apps."envoy-gateway" = {
    "securitypolicies" = mkOption {
      type = types.attrsOf SecuritypoliciesModule;
      default = { };
      description = "SecurityPolicy CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."envoy-gateway".content = allResources;
  };
}
