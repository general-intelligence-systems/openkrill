# Auto-generated openkrill module fragment for envoy-gateway
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."envoy-gateway";
  compact = filterAttrs (_: v: v != null);
  CredentialInjectionCredentialModule = types.submodule {
    options = {
      "valueRef" = mkOption {
        description = "ValueRef is a reference to the secret containing the credentials to be injected.\nThis is an Opaque secret. The credential should be stored in the key\n\"credential\", and the value should be the credential to be injected.\nFor example, for basic authentication, the value should be \"Basic <base64 encoded username:password>\".\nfor bearer token, the value should be \"Bearer <token>\".\nNote: The secret must be in the same namespace as the HTTPRouteFilter.";
        type = CredentialInjectionCredentialValueRefModule;
      };
    };
  };
  mkCredentialInjectionCredential = res: {
    "valueRef" = mkCredentialInjectionCredentialValueRef res."valueRef";
  };
  CredentialInjectionCredentialValueRefModule = types.submodule {
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
  mkCredentialInjectionCredentialValueRef =
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
  CredentialInjectionModule = types.submodule {
    options = {
      "credential" = mkOption {
        description = "Credential is the credential to be injected.";
        type = CredentialInjectionCredentialModule;
      };
      "header" = mkOption {
        description = "Header is the name of the header where the credentials are injected.\nIf not specified, the credentials are injected into the Authorization header.";
        type = (types.nullOr types.str);
        default = null;
      };
      "overwrite" = mkOption {
        description = "Whether to overwrite the value or not if the injected headers already exist.\nIf not specified, the default value is false.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkCredentialInjection =
    res:
    {
      "credential" = mkCredentialInjectionCredential res."credential";
    }
    // optionalAttrs (res."header" != null) { inherit (res) "header"; }
    // {
    }
    // optionalAttrs res."overwrite" { inherit (res) "overwrite"; }
    // {
    };
  DirectResponseBodyModule = types.submodule {
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
        type = (types.nullOr DirectResponseBodyValueRefModule);
        default = null;
      };
    };
  };
  mkDirectResponseBody =
    res:
    {
    }
    // optionalAttrs (res."inline" != null) { inherit (res) "inline"; }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."valueRef" != null) {
      "valueRef" = mkDirectResponseBodyValueRef res."valueRef";
    }
    // {
    };
  DirectResponseBodyValueRefModule = types.submodule {
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
  mkDirectResponseBodyValueRef = res: {
    inherit (res) "group";
    inherit (res) "kind";
    inherit (res) "name";
  };
  DirectResponseModule = types.submodule {
    options = {
      "body" = mkOption {
        description = "Body of the Response";
        type = (types.nullOr DirectResponseBodyModule);
        default = null;
      };
      "contentType" = mkOption {
        description = "Content Type of the response. This will be set in the Content-Type header.";
        type = (types.nullOr types.str);
        default = null;
      };
      "statusCode" = mkOption {
        description = "Status Code of the HTTP response\nIf unset, defaults to 200.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkDirectResponse =
    res:
    {
    }
    // optionalAttrs (res."body" != null) { "body" = mkDirectResponseBody res."body"; }
    // {
    }
    // optionalAttrs (res."contentType" != null) { inherit (res) "contentType"; }
    // {
    }
    // optionalAttrs (res."statusCode" != null) { inherit (res) "statusCode"; }
    // {
    };
  UrlRewriteHostnameModule = types.submodule {
    options = {
      "header" = mkOption {
        description = "Header is the name of the header whose value would be used to rewrite the Host header";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "HTTPPathModifierType defines the type of Hostname rewrite.";
        type = (
          types.enum [
            "Header"
            "Backend"
          ]
        );
      };
    };
  };
  mkUrlRewriteHostname =
    res:
    {
    }
    // optionalAttrs (res."header" != null) { inherit (res) "header"; }
    // {
      inherit (res) "type";
    };
  UrlRewriteModule = types.submodule {
    options = {
      "hostname" = mkOption {
        description = "Hostname is the value to be used to replace the Host header value during\nforwarding.";
        type = (types.nullOr UrlRewriteHostnameModule);
        default = null;
      };
      "path" = mkOption {
        description = "Path defines a path rewrite.";
        type = (types.nullOr UrlRewritePathModule);
        default = null;
      };
    };
  };
  mkUrlRewrite =
    res:
    {
    }
    // optionalAttrs (res."hostname" != null) { "hostname" = mkUrlRewriteHostname res."hostname"; }
    // {
    }
    // optionalAttrs (res."path" != null) { "path" = mkUrlRewritePath res."path"; }
    // {
    };
  UrlRewritePathModule = types.submodule {
    options = {
      "replaceRegexMatch" = mkOption {
        description = "ReplaceRegexMatch defines a path regex rewrite. The path portions matched by the regex pattern are replaced by the defined substitution.\nhttps://www.envoyproxy.io/docs/envoy/latest/api-v3/config/route/v3/route_components.proto#envoy-v3-api-field-config-route-v3-routeaction-regex-rewrite\nSome examples:\n(1) replaceRegexMatch:\n      pattern: ^/service/([^/]+)(/.*)$\n      substitution: \\2/instance/\\1\n    Would transform /service/foo/v1/api into /v1/api/instance/foo.\n(2) replaceRegexMatch:\n      pattern: one\n      substitution: two\n    Would transform /xxx/one/yyy/one/zzz into /xxx/two/yyy/two/zzz.\n(3) replaceRegexMatch:\n      pattern: ^(.*?)one(.*)$\n      substitution: \\1two\\2\n    Would transform /xxx/one/yyy/one/zzz into /xxx/two/yyy/one/zzz.\n(3) replaceRegexMatch:\n      pattern: (?i)/xxx/\n      substitution: /yyy/\n    Would transform path /aaa/XxX/bbb into /aaa/yyy/bbb (case-insensitive).";
        type = (types.nullOr UrlRewritePathReplaceRegexMatchModule);
        default = null;
      };
      "type" = mkOption {
        description = "HTTPPathModifierType defines the type of path redirect or rewrite.";
        type = (types.enum [ "ReplaceRegexMatch" ]);
      };
    };
  };
  mkUrlRewritePath =
    res:
    {
    }
    // optionalAttrs (res."replaceRegexMatch" != null) {
      "replaceRegexMatch" = mkUrlRewritePathReplaceRegexMatch res."replaceRegexMatch";
    }
    // {
      inherit (res) "type";
    };
  UrlRewritePathReplaceRegexMatchModule = types.submodule {
    options = {
      "pattern" = mkOption {
        description = "Pattern matches a regular expression against the value of the HTTP Path.The regex string must\nadhere to the syntax documented in https://github.com/google/re2/wiki/Syntax.";
        type = types.str;
      };
      "substitution" = mkOption {
        description = "Substitution is an expression that replaces the matched portion.The expression may include numbered\ncapture groups that adhere to syntax documented in https://github.com/google/re2/wiki/Syntax.";
        type = types.str;
      };
    };
  };
  mkUrlRewritePathReplaceRegexMatch = res: {
    inherit (res) "pattern";
    inherit (res) "substitution";
  };
  HttproutefiltersModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this HTTPRouteFilter resource.";
        };
        "credentialInjection" = mkOption {
          description = "HTTPCredentialInjectionFilter defines the configuration to inject credentials into the request.\nThis is useful when the backend service requires credentials in the request, and the original\nrequest does not contain them. The filter can inject credentials into the request before forwarding\nit to the backend service.";
          type = (types.nullOr CredentialInjectionModule);
          default = null;
        };
        "directResponse" = mkOption {
          description = "HTTPDirectResponseFilter defines the configuration to return a fixed response.";
          type = (types.nullOr DirectResponseModule);
          default = null;
        };
        "urlRewrite" = mkOption {
          description = "HTTPURLRewriteFilter define rewrites of HTTP URL components such as path and host";
          type = (types.nullOr UrlRewriteModule);
          default = null;
        };
      };
    }
  );
  mkHTTPRouteFilter = name: res: {
    apiVersion = "gateway.envoyproxy.io/v1alpha1";
    kind = "HTTPRouteFilter";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."credentialInjection" != null) {
      "credentialInjection" = mkCredentialInjection res."credentialInjection";
    }
    // {
    }
    // optionalAttrs (res."directResponse" != null) {
      "directResponse" = mkDirectResponse res."directResponse";
    }
    // {
    }
    // optionalAttrs (res."urlRewrite" != null) { "urlRewrite" = mkUrlRewrite res."urlRewrite"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkHTTPRouteFilter cfg."httproutefilters");
in
{
  options.openkrill.apps."envoy-gateway" = {
    "httproutefilters" = mkOption {
      type = types.attrsOf HttproutefiltersModule;
      default = { };
      description = "HTTPRouteFilter CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."envoy-gateway".content = allResources;
  };
}
