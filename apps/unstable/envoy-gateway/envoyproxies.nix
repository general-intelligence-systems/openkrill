# Auto-generated openkrill module fragment for envoy-gateway
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."envoy-gateway";
  compact = filterAttrs (_: v: v != null);
  BackendTLSClientCertificateRefModule = types.submodule {
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
  mkBackendTLSClientCertificateRef =
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
  BackendTLSModule = types.submodule {
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
      "clientCertificateRef" = mkOption {
        description = "ClientCertificateRef defines the reference to a Kubernetes Secret that contains\nthe client certificate and private key for Envoy to use when connecting to\nbackend services and external services, such as ExtAuth, ALS, OpenTelemetry, etc.\nThis secret should be located within the same namespace as the Envoy proxy resource that references it.";
        type = (types.nullOr BackendTLSClientCertificateRefModule);
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
      "signatureAlgorithms" = mkOption {
        description = "SignatureAlgorithms specifies which signature algorithms the listener should\nsupport.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkBackendTLS =
    res:
    {
    }
    // optionalAttrs (res."alpnProtocols" != [ ]) { inherit (res) "alpnProtocols"; }
    // {
    }
    // optionalAttrs (res."ciphers" != [ ]) { inherit (res) "ciphers"; }
    // {
    }
    // optionalAttrs (res."clientCertificateRef" != null) {
      "clientCertificateRef" = mkBackendTLSClientCertificateRef res."clientCertificateRef";
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
    // optionalAttrs (res."signatureAlgorithms" != [ ]) { inherit (res) "signatureAlgorithms"; }
    // {
    };
  BootstrapJsonPatcheModule = types.submodule {
    options = {
      "from" = mkOption {
        description = "From is the source location of the value to be copied or moved. Only valid\nfor move or copy operations\nRefer to https://datatracker.ietf.org/doc/html/rfc6901 for more details.";
        type = (types.nullOr types.str);
        default = null;
      };
      "jsonPath" = mkOption {
        description = "JSONPath is a JSONPath expression. Refer to https://datatracker.ietf.org/doc/rfc9535/ for more details.\nIt produces one or more JSONPointer expressions based on the given JSON document.\nIf no JSONPointer is found, it will result in an error.\nIf the 'Path' property is also set, it will be appended to the resulting JSONPointer expressions from the JSONPath evaluation.\nThis is useful when creating a property that does not yet exist in the JSON document.\nThe final JSONPointer expressions specifies the locations in the target document/field where the operation will be applied.";
        type = (types.nullOr types.str);
        default = null;
      };
      "op" = mkOption {
        description = "Op is the type of operation to perform";
        type = (
          types.enum [
            "add"
            "remove"
            "replace"
            "move"
            "copy"
            "test"
          ]
        );
      };
      "path" = mkOption {
        description = "Path is a JSONPointer expression. Refer to https://datatracker.ietf.org/doc/html/rfc6901 for more details.\nIt specifies the location of the target document/field where the operation will be performed";
        type = (types.nullOr types.str);
        default = null;
      };
      "value" = mkOption {
        description = "Value is the new value of the path location. The value is only used by\nthe `add` and `replace` operations.";
        type = (types.nullOr types.anything);
        default = null;
      };
    };
  };
  mkBootstrapJsonPatche =
    res:
    {
    }
    // optionalAttrs (res."from" != null) { inherit (res) "from"; }
    // {
    }
    // optionalAttrs (res."jsonPath" != null) { inherit (res) "jsonPath"; }
    // {
      inherit (res) "op";
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  BootstrapModule = types.submodule {
    options = {
      "jsonPatches" = mkOption {
        description = "JSONPatches is an array of JSONPatches to be applied to the default bootstrap. Patches are\napplied in the order in which they are defined.";
        type = (types.listOf BootstrapJsonPatcheModule);
        default = [ ];
      };
      "type" = mkOption {
        description = "Type is the type of the bootstrap configuration, it should be either **Replace**,  **Merge**, or **JSONPatch**.\nIf unspecified, it defaults to Replace.";
        type = (
          types.nullOr (
            types.enum [
              "Merge"
              "Replace"
              "JSONPatch"
            ]
          )
        );
        default = "Replace";
      };
      "value" = mkOption {
        description = "Value is a YAML string of the bootstrap.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkBootstrap =
    res:
    {
    }
    // optionalAttrs (res."jsonPatches" != [ ]) {
      "jsonPatches" = map mkBootstrapJsonPatche res."jsonPatches";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  FilterOrderModule = types.submodule {
    options = {
      "after" = mkOption {
        description = "After defines the filter that should come after the filter.\nOnly one of Before or After must be set.";
        type = (
          types.nullOr (
            types.enum [
              "envoy.filters.http.health_check"
              "envoy.filters.http.fault"
              "envoy.filters.http.cors"
              "envoy.filters.http.ext_authz"
              "envoy.filters.http.api_key_auth"
              "envoy.filters.http.basic_auth"
              "envoy.filters.http.oauth2"
              "envoy.filters.http.jwt_authn"
              "envoy.filters.http.stateful_session"
              "envoy.filters.http.lua"
              "envoy.filters.http.ext_proc"
              "envoy.filters.http.wasm"
              "envoy.filters.http.rbac"
              "envoy.filters.http.local_ratelimit"
              "envoy.filters.http.ratelimit"
              "envoy.filters.http.custom_response"
              "envoy.filters.http.compressor"
            ]
          )
        );
        default = null;
      };
      "before" = mkOption {
        description = "Before defines the filter that should come before the filter.\nOnly one of Before or After must be set.";
        type = (
          types.nullOr (
            types.enum [
              "envoy.filters.http.health_check"
              "envoy.filters.http.fault"
              "envoy.filters.http.cors"
              "envoy.filters.http.ext_authz"
              "envoy.filters.http.api_key_auth"
              "envoy.filters.http.basic_auth"
              "envoy.filters.http.oauth2"
              "envoy.filters.http.jwt_authn"
              "envoy.filters.http.stateful_session"
              "envoy.filters.http.lua"
              "envoy.filters.http.ext_proc"
              "envoy.filters.http.wasm"
              "envoy.filters.http.rbac"
              "envoy.filters.http.local_ratelimit"
              "envoy.filters.http.ratelimit"
              "envoy.filters.http.custom_response"
              "envoy.filters.http.compressor"
            ]
          )
        );
        default = null;
      };
      "name" = mkOption {
        description = "Name of the filter.";
        type = (
          types.enum [
            "envoy.filters.http.health_check"
            "envoy.filters.http.fault"
            "envoy.filters.http.cors"
            "envoy.filters.http.ext_authz"
            "envoy.filters.http.api_key_auth"
            "envoy.filters.http.basic_auth"
            "envoy.filters.http.oauth2"
            "envoy.filters.http.jwt_authn"
            "envoy.filters.http.stateful_session"
            "envoy.filters.http.lua"
            "envoy.filters.http.ext_proc"
            "envoy.filters.http.wasm"
            "envoy.filters.http.rbac"
            "envoy.filters.http.local_ratelimit"
            "envoy.filters.http.ratelimit"
            "envoy.filters.http.custom_response"
            "envoy.filters.http.compressor"
          ]
        );
      };
    };
  };
  mkFilterOrder =
    res:
    {
    }
    // optionalAttrs (res."after" != null) { inherit (res) "after"; }
    // {
    }
    // optionalAttrs (res."before" != null) { inherit (res) "before"; }
    // {
      inherit (res) "name";
    };
  LoggingModule = types.submodule {
    options = {
      "level" = mkOption {
        description = "Level is a map of logging level per component, where the component is the key\nand the log level is the value. If unspecified, defaults to \"default: warn\".";
        type = (
          types.attrsOf (
            types.enum [
              "trace"
              "debug"
              "info"
              "warn"
              "error"
            ]
          )
        );
        default = {
          "default" = "warn";
        };
      };
    };
  };
  mkLogging =
    res:
    {
    }
    // optionalAttrs (res."level" != { }) { inherit (res) "level"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetContainerEnvModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the environment variable. Must be a C_IDENTIFIER.";
        type = types.str;
      };
      "value" = mkOption {
        description = "Variable references $(VAR_NAME) are expanded\nusing the previously defined environment variables in the container and\nany service environment variables. If a variable cannot be resolved,\nthe reference in the input string will be unchanged. Double $$ are reduced\nto a single $, which allows for escaping the $(VAR_NAME) syntax: i.e.\n\"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\".\nEscaped references will never be expanded, regardless of whether the variable\nexists or not.\nDefaults to \"\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "valueFrom" = mkOption {
        description = "Source for the environment variable's value. Cannot be used if value is not empty.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetContainerEnvValueFromModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetContainerEnv =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    }
    // optionalAttrs (res."valueFrom" != null) {
      "valueFrom" = mkProviderKubernetesEnvoyDaemonSetContainerEnvValueFrom res."valueFrom";
    }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetContainerEnvValueFromConfigMapKeyRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select.";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "Specify whether the ConfigMap or its key must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetContainerEnvValueFromConfigMapKeyRef =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetContainerEnvValueFromFieldRefModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        description = "Version of the schema the FieldPath is written in terms of, defaults to \"v1\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "fieldPath" = mkOption {
        description = "Path of the field to select in the specified API version.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetContainerEnvValueFromFieldRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "fieldPath";
    };
  ProviderKubernetesEnvoyDaemonSetContainerEnvValueFromModule = types.submodule {
    options = {
      "configMapKeyRef" = mkOption {
        description = "Selects a key of a ConfigMap.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetContainerEnvValueFromConfigMapKeyRefModule);
        default = null;
      };
      "fieldRef" = mkOption {
        description = "Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`,\nspec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetContainerEnvValueFromFieldRefModule);
        default = null;
      };
      "resourceFieldRef" = mkOption {
        description = "Selects a resource of the container: only resources limits and requests\n(limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetContainerEnvValueFromResourceFieldRefModule);
        default = null;
      };
      "secretKeyRef" = mkOption {
        description = "Selects a key of a secret in the pod's namespace";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetContainerEnvValueFromSecretKeyRefModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetContainerEnvValueFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapKeyRef" != null) {
      "configMapKeyRef" =
        mkProviderKubernetesEnvoyDaemonSetContainerEnvValueFromConfigMapKeyRef
          res."configMapKeyRef";
    }
    // {
    }
    // optionalAttrs (res."fieldRef" != null) {
      "fieldRef" = mkProviderKubernetesEnvoyDaemonSetContainerEnvValueFromFieldRef res."fieldRef";
    }
    // {
    }
    // optionalAttrs (res."resourceFieldRef" != null) {
      "resourceFieldRef" =
        mkProviderKubernetesEnvoyDaemonSetContainerEnvValueFromResourceFieldRef
          res."resourceFieldRef";
    }
    // {
    }
    // optionalAttrs (res."secretKeyRef" != null) {
      "secretKeyRef" =
        mkProviderKubernetesEnvoyDaemonSetContainerEnvValueFromSecretKeyRef
          res."secretKeyRef";
    }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetContainerEnvValueFromResourceFieldRefModule = types.submodule {
    options = {
      "containerName" = mkOption {
        description = "Container name: required for volumes, optional for env vars";
        type = (types.nullOr types.str);
        default = null;
      };
      "divisor" = mkOption {
        description = "Specifies the output format of the exposed resources, defaults to \"1\"";
        type = types.anything;
        default = { };
      };
      "resource" = mkOption {
        description = "Required: resource to select";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetContainerEnvValueFromResourceFieldRef =
    res:
    {
    }
    // optionalAttrs (res."containerName" != null) { inherit (res) "containerName"; }
    // {
    }
    // optionalAttrs (res."divisor" != null) { inherit (res) "divisor"; }
    // {
      inherit (res) "resource";
    };
  ProviderKubernetesEnvoyDaemonSetContainerEnvValueFromSecretKeyRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key of the secret to select from.  Must be a valid secret key.";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "Specify whether the Secret or its key must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetContainerEnvValueFromSecretKeyRef =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetContainerModule = types.submodule {
    options = {
      "env" = mkOption {
        description = "List of environment variables to set in the container.";
        type = (types.listOf ProviderKubernetesEnvoyDaemonSetContainerEnvModule);
        default = [ ];
      };
      "image" = mkOption {
        description = "Image specifies the EnvoyProxy container image to be used including a tag, instead of the default image.\nThis field is mutually exclusive with ImageRepository.";
        type = (types.nullOr types.str);
        default = null;
      };
      "imageRepository" = mkOption {
        description = "ImageRepository specifies the container image repository to be used without specifying a tag.\nThe default tag will be used.\nThis field is mutually exclusive with Image.";
        type = (types.nullOr types.str);
        default = null;
      };
      "resources" = mkOption {
        description = "Resources required by this container.\nMore info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetContainerResourcesModule);
        default = null;
      };
      "securityContext" = mkOption {
        description = "SecurityContext defines the security options the container should be run with.\nIf set, the fields of SecurityContext override the equivalent fields of PodSecurityContext.\nMore info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetContainerSecurityContextModule);
        default = null;
      };
      "volumeMounts" = mkOption {
        description = "VolumeMounts are volumes to mount into the container's filesystem.\nCannot be updated.";
        type = (types.listOf ProviderKubernetesEnvoyDaemonSetContainerVolumeMountModule);
        default = [ ];
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetContainer =
    res:
    {
    }
    // optionalAttrs (res."env" != [ ]) {
      "env" = map mkProviderKubernetesEnvoyDaemonSetContainerEnv res."env";
    }
    // {
    }
    // optionalAttrs (res."image" != null) { inherit (res) "image"; }
    // {
    }
    // optionalAttrs (res."imageRepository" != null) { inherit (res) "imageRepository"; }
    // {
    }
    // optionalAttrs (res."resources" != null) {
      "resources" = mkProviderKubernetesEnvoyDaemonSetContainerResources res."resources";
    }
    // {
    }
    // optionalAttrs (res."securityContext" != null) {
      "securityContext" =
        mkProviderKubernetesEnvoyDaemonSetContainerSecurityContext
          res."securityContext";
    }
    // {
    }
    // optionalAttrs (res."volumeMounts" != [ ]) {
      "volumeMounts" = map mkProviderKubernetesEnvoyDaemonSetContainerVolumeMount res."volumeMounts";
    }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetContainerResourcesClaimModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name must match the name of one entry in pod.spec.resourceClaims of\nthe Pod where this field is used. It makes that resource available\ninside a container.";
        type = types.str;
      };
      "request" = mkOption {
        description = "Request is the name chosen for a request in the referenced claim.\nIf empty, everything from the claim is made available, otherwise\nonly the result of this request.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetContainerResourcesClaim =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."request" != null) { inherit (res) "request"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetContainerResourcesModule = types.submodule {
    options = {
      "claims" = mkOption {
        description = "Claims lists the names of resources, defined in spec.resourceClaims,\nthat are used by this container.\n\nThis is an alpha field and requires enabling the\nDynamicResourceAllocation feature gate.\n\nThis field is immutable. It can only be set for containers.";
        type = (types.listOf ProviderKubernetesEnvoyDaemonSetContainerResourcesClaimModule);
        default = [ ];
      };
      "limits" = mkOption {
        description = "Limits describes the maximum amount of compute resources allowed.\nMore info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "requests" = mkOption {
        description = "Requests describes the minimum amount of compute resources required.\nIf Requests is omitted for a container, it defaults to Limits if that is explicitly specified,\notherwise to an implementation-defined value. Requests cannot exceed Limits.\nMore info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.attrsOf types.anything);
        default = { };
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetContainerResources =
    res:
    {
    }
    // optionalAttrs (res."claims" != [ ]) {
      "claims" = map mkProviderKubernetesEnvoyDaemonSetContainerResourcesClaim res."claims";
    }
    // {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetContainerSecurityContextAppArmorProfileModule = types.submodule {
    options = {
      "localhostProfile" = mkOption {
        description = "localhostProfile indicates a profile loaded on the node that should be used.\nThe profile must be preconfigured on the node to work.\nMust match the loaded name of the profile.\nMust be set if and only if type is \"Localhost\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "type indicates which kind of AppArmor profile will be applied.\nValid options are:\n  Localhost - a profile pre-loaded on the node.\n  RuntimeDefault - the container runtime's default profile.\n  Unconfined - no AppArmor enforcement.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetContainerSecurityContextAppArmorProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  ProviderKubernetesEnvoyDaemonSetContainerSecurityContextCapabilitiesModule = types.submodule {
    options = {
      "add" = mkOption {
        description = "Added capabilities";
        type = (types.listOf types.str);
        default = [ ];
      };
      "drop" = mkOption {
        description = "Removed capabilities";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetContainerSecurityContextCapabilities =
    res:
    {
    }
    // optionalAttrs (res."add" != [ ]) { inherit (res) "add"; }
    // {
    }
    // optionalAttrs (res."drop" != [ ]) { inherit (res) "drop"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetContainerSecurityContextModule = types.submodule {
    options = {
      "allowPrivilegeEscalation" = mkOption {
        description = "AllowPrivilegeEscalation controls whether a process can gain more\nprivileges than its parent process. This bool directly controls if\nthe no_new_privs flag will be set on the container process.\nAllowPrivilegeEscalation is true always when the container is:\n1) run as Privileged\n2) has CAP_SYS_ADMIN\nNote that this field cannot be set when spec.os.name is windows.";
        type = types.bool;
        default = false;
      };
      "appArmorProfile" = mkOption {
        description = "appArmorProfile is the AppArmor options to use by this container. If set, this profile\noverrides the pod's appArmorProfile.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetContainerSecurityContextAppArmorProfileModule);
        default = null;
      };
      "capabilities" = mkOption {
        description = "The capabilities to add/drop when running containers.\nDefaults to the default set of capabilities granted by the container runtime.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetContainerSecurityContextCapabilitiesModule);
        default = null;
      };
      "privileged" = mkOption {
        description = "Run container in privileged mode.\nProcesses in privileged containers are essentially equivalent to root on the host.\nDefaults to false.\nNote that this field cannot be set when spec.os.name is windows.";
        type = types.bool;
        default = false;
      };
      "procMount" = mkOption {
        description = "procMount denotes the type of proc mount to use for the containers.\nThe default value is Default which uses the container runtime defaults for\nreadonly paths and masked paths.\nThis requires the ProcMountType feature flag to be enabled.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnlyRootFilesystem" = mkOption {
        description = "Whether this container has a read-only root filesystem.\nDefault is false.\nNote that this field cannot be set when spec.os.name is windows.";
        type = types.bool;
        default = false;
      };
      "runAsGroup" = mkOption {
        description = "The GID to run the entrypoint of the container process.\nUses runtime default if unset.\nMay also be set in PodSecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.int);
        default = null;
      };
      "runAsNonRoot" = mkOption {
        description = "Indicates that the container must run as a non-root user.\nIf true, the Kubelet will validate the image at runtime to ensure that it\ndoes not run as UID 0 (root) and fail to start the container if it does.\nIf unset or false, no such validation will be performed.\nMay also be set in PodSecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.";
        type = types.bool;
        default = false;
      };
      "runAsUser" = mkOption {
        description = "The UID to run the entrypoint of the container process.\nDefaults to user specified in image metadata if unspecified.\nMay also be set in PodSecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.int);
        default = null;
      };
      "seLinuxOptions" = mkOption {
        description = "The SELinux context to be applied to the container.\nIf unspecified, the container runtime will allocate a random SELinux context for each\ncontainer.  May also be set in PodSecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetContainerSecurityContextSeLinuxOptionsModule);
        default = null;
      };
      "seccompProfile" = mkOption {
        description = "The seccomp options to use by this container. If seccomp options are\nprovided at both the pod & container level, the container options\noverride the pod options.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetContainerSecurityContextSeccompProfileModule);
        default = null;
      };
      "windowsOptions" = mkOption {
        description = "The Windows specific settings applied to all containers.\nIf unspecified, the options from the PodSecurityContext will be used.\nIf set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is linux.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetContainerSecurityContextWindowsOptionsModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetContainerSecurityContext =
    res:
    {
    }
    // optionalAttrs res."allowPrivilegeEscalation" { inherit (res) "allowPrivilegeEscalation"; }
    // {
    }
    // optionalAttrs (res."appArmorProfile" != null) {
      "appArmorProfile" =
        mkProviderKubernetesEnvoyDaemonSetContainerSecurityContextAppArmorProfile
          res."appArmorProfile";
    }
    // {
    }
    // optionalAttrs (res."capabilities" != null) {
      "capabilities" =
        mkProviderKubernetesEnvoyDaemonSetContainerSecurityContextCapabilities
          res."capabilities";
    }
    // {
    }
    // optionalAttrs res."privileged" { inherit (res) "privileged"; }
    // {
    }
    // optionalAttrs (res."procMount" != null) { inherit (res) "procMount"; }
    // {
    }
    // optionalAttrs res."readOnlyRootFilesystem" { inherit (res) "readOnlyRootFilesystem"; }
    // {
    }
    // optionalAttrs (res."runAsGroup" != null) { inherit (res) "runAsGroup"; }
    // {
    }
    // optionalAttrs res."runAsNonRoot" { inherit (res) "runAsNonRoot"; }
    // {
    }
    // optionalAttrs (res."runAsUser" != null) { inherit (res) "runAsUser"; }
    // {
    }
    // optionalAttrs (res."seLinuxOptions" != null) {
      "seLinuxOptions" =
        mkProviderKubernetesEnvoyDaemonSetContainerSecurityContextSeLinuxOptions
          res."seLinuxOptions";
    }
    // {
    }
    // optionalAttrs (res."seccompProfile" != null) {
      "seccompProfile" =
        mkProviderKubernetesEnvoyDaemonSetContainerSecurityContextSeccompProfile
          res."seccompProfile";
    }
    // {
    }
    // optionalAttrs (res."windowsOptions" != null) {
      "windowsOptions" =
        mkProviderKubernetesEnvoyDaemonSetContainerSecurityContextWindowsOptions
          res."windowsOptions";
    }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetContainerSecurityContextSeLinuxOptionsModule = types.submodule {
    options = {
      "level" = mkOption {
        description = "Level is SELinux level label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
      "role" = mkOption {
        description = "Role is a SELinux role label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Type is a SELinux type label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
      "user" = mkOption {
        description = "User is a SELinux user label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetContainerSecurityContextSeLinuxOptions =
    res:
    {
    }
    // optionalAttrs (res."level" != null) { inherit (res) "level"; }
    // {
    }
    // optionalAttrs (res."role" != null) { inherit (res) "role"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    }
    // optionalAttrs (res."user" != null) { inherit (res) "user"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetContainerSecurityContextSeccompProfileModule = types.submodule {
    options = {
      "localhostProfile" = mkOption {
        description = "localhostProfile indicates a profile defined in a file on the node should be used.\nThe profile must be preconfigured on the node to work.\nMust be a descending path, relative to the kubelet's configured seccomp profile location.\nMust be set if type is \"Localhost\". Must NOT be set for any other type.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "type indicates which kind of seccomp profile will be applied.\nValid options are:\n\nLocalhost - a profile defined in a file on the node should be used.\nRuntimeDefault - the container runtime default profile should be used.\nUnconfined - no profile should be applied.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetContainerSecurityContextSeccompProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  ProviderKubernetesEnvoyDaemonSetContainerSecurityContextWindowsOptionsModule = types.submodule {
    options = {
      "gmsaCredentialSpec" = mkOption {
        description = "GMSACredentialSpec is where the GMSA admission webhook\n(https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the\nGMSA credential spec named by the GMSACredentialSpecName field.";
        type = (types.nullOr types.str);
        default = null;
      };
      "gmsaCredentialSpecName" = mkOption {
        description = "GMSACredentialSpecName is the name of the GMSA credential spec to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "hostProcess" = mkOption {
        description = "HostProcess determines if a container should be run as a 'Host Process' container.\nAll of a Pod's containers must have the same effective HostProcess value\n(it is not allowed to have a mix of HostProcess containers and non-HostProcess containers).\nIn addition, if HostProcess is true then HostNetwork must also be set to true.";
        type = types.bool;
        default = false;
      };
      "runAsUserName" = mkOption {
        description = "The UserName in Windows to run the entrypoint of the container process.\nDefaults to the user specified in image metadata if unspecified.\nMay also be set in PodSecurityContext. If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetContainerSecurityContextWindowsOptions =
    res:
    {
    }
    // optionalAttrs (res."gmsaCredentialSpec" != null) { inherit (res) "gmsaCredentialSpec"; }
    // {
    }
    // optionalAttrs (res."gmsaCredentialSpecName" != null) { inherit (res) "gmsaCredentialSpecName"; }
    // {
    }
    // optionalAttrs res."hostProcess" { inherit (res) "hostProcess"; }
    // {
    }
    // optionalAttrs (res."runAsUserName" != null) { inherit (res) "runAsUserName"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetContainerVolumeMountModule = types.submodule {
    options = {
      "mountPath" = mkOption {
        description = "Path within the container at which the volume should be mounted.  Must\nnot contain ':'.";
        type = types.str;
      };
      "mountPropagation" = mkOption {
        description = "mountPropagation determines how mounts are propagated from the host\nto container and the other way around.\nWhen not set, MountPropagationNone is used.\nThis field is beta in 1.10.\nWhen RecursiveReadOnly is set to IfPossible or to Enabled, MountPropagation must be None or unspecified\n(which defaults to None).";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "This must match the Name of a Volume.";
        type = types.str;
      };
      "readOnly" = mkOption {
        description = "Mounted read-only if true, read-write otherwise (false or unspecified).\nDefaults to false.";
        type = types.bool;
        default = false;
      };
      "recursiveReadOnly" = mkOption {
        description = "RecursiveReadOnly specifies whether read-only mounts should be handled\nrecursively.\n\nIf ReadOnly is false, this field has no meaning and must be unspecified.\n\nIf ReadOnly is true, and this field is set to Disabled, the mount is not made\nrecursively read-only.  If this field is set to IfPossible, the mount is made\nrecursively read-only, if it is supported by the container runtime.  If this\nfield is set to Enabled, the mount is made recursively read-only if it is\nsupported by the container runtime, otherwise the pod will not be started and\nan error will be generated to indicate the reason.\n\nIf this field is set to IfPossible or Enabled, MountPropagation must be set to\nNone (or be unspecified, which defaults to None).\n\nIf this field is not specified, it is treated as an equivalent of Disabled.";
        type = (types.nullOr types.str);
        default = null;
      };
      "subPath" = mkOption {
        description = "Path within the volume from which the container's volume should be mounted.\nDefaults to \"\" (volume's root).";
        type = (types.nullOr types.str);
        default = null;
      };
      "subPathExpr" = mkOption {
        description = "Expanded path within the volume from which the container's volume should be mounted.\nBehaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment.\nDefaults to \"\" (volume's root).\nSubPathExpr and SubPath are mutually exclusive.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetContainerVolumeMount =
    res:
    {
      inherit (res) "mountPath";
    }
    // optionalAttrs (res."mountPropagation" != null) { inherit (res) "mountPropagation"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."recursiveReadOnly" != null) { inherit (res) "recursiveReadOnly"; }
    // {
    }
    // optionalAttrs (res."subPath" != null) { inherit (res) "subPath"; }
    // {
    }
    // optionalAttrs (res."subPathExpr" != null) { inherit (res) "subPathExpr"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetModule = types.submodule {
    options = {
      "container" = mkOption {
        description = "Container defines the desired specification of main container.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetContainerModule);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the daemonSet.\nWhen unset, this defaults to an autogenerated name.";
        type = (types.nullOr types.str);
        default = null;
      };
      "patch" = mkOption {
        description = "Patch defines how to perform the patch operation to daemonset";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPatchModule);
        default = null;
      };
      "pod" = mkOption {
        description = "Pod defines the desired specification of pod.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodModule);
        default = null;
      };
      "strategy" = mkOption {
        description = "The daemonset strategy to use to replace existing pods with new ones.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetStrategyModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSet =
    res:
    {
    }
    // optionalAttrs (res."container" != null) {
      "container" = mkProviderKubernetesEnvoyDaemonSetContainer res."container";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."patch" != null) {
      "patch" = mkProviderKubernetesEnvoyDaemonSetPatch res."patch";
    }
    // {
    }
    // optionalAttrs (res."pod" != null) { "pod" = mkProviderKubernetesEnvoyDaemonSetPod res."pod"; }
    // {
    }
    // optionalAttrs (res."strategy" != null) {
      "strategy" = mkProviderKubernetesEnvoyDaemonSetStrategy res."strategy";
    }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPatchModule = types.submodule {
    options = {
      "type" = mkOption {
        description = "Type is the type of merge operation to perform\n\nBy default, StrategicMerge is used as the patch type.";
        type = (types.nullOr types.str);
        default = null;
      };
      "value" = mkOption {
        description = "Object contains the raw configuration for merged object";
        type = types.anything;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPatch =
    res:
    {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
      inherit (res) "value";
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityModule = types.submodule {
    options = {
      "nodeAffinity" = mkOption {
        description = "Describes node affinity scheduling rules for the pod.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityModule);
        default = null;
      };
      "podAffinity" = mkOption {
        description = "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s)).";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityModule);
        default = null;
      };
      "podAntiAffinity" = mkOption {
        description = "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s)).";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodAffinity =
    res:
    {
    }
    // optionalAttrs (res."nodeAffinity" != null) {
      "nodeAffinity" = mkProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinity res."nodeAffinity";
    }
    // {
    }
    // optionalAttrs (res."podAffinity" != null) {
      "podAffinity" = mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinity res."podAffinity";
    }
    // {
    }
    // optionalAttrs (res."podAntiAffinity" != null) {
      "podAntiAffinity" =
        mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinity
          res."podAntiAffinity";
    }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityModule = types.submodule {
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy\nthe affinity expressions specified by this field, but it may choose\na node that violates one or more of the expressions. The node that is\nmost preferred is the one with the greatest sum of weights, i.e.\nfor each node that meets all of the scheduling requirements (resource\nrequest, requiredDuringScheduling affinity expressions, etc.),\ncompute a sum by iterating through the elements of this field and adding\n\"weight\" to the sum if the node matches the corresponding matchExpressions; the\nnode(s) with the highest sum are the most preferred.";
        type = (
          types.listOf ProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the affinity requirements specified by this field are not met at\nscheduling time, the pod will not be scheduled onto the node.\nIf the affinity requirements specified by this field cease to be met\nat some point during pod execution (e.g. due to an update), the system\nmay or may not try to eventually evict the pod from its node.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinity =
    res:
    {
    }
    // optionalAttrs (res."preferredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "preferredDuringSchedulingIgnoredDuringExecution" =
        map
          mkProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecution
          res."preferredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    }
    // optionalAttrs (res."requiredDuringSchedulingIgnoredDuringExecution" != null) {
      "requiredDuringSchedulingIgnoredDuringExecution" =
        mkProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecution
          res."requiredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "preference" = mkOption {
            description = "A node selector term, associated with the corresponding weight.";
            type =
              ProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceModule;
          };
          "weight" = mkOption {
            description = "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100.";
            type = types.int;
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecution =
    res: {
      "preference" =
        mkProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreference
          res."preference";
      inherit (res) "weight";
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            description = "The label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "Represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.";
            type = types.str;
          };
          "values" = mkOption {
            description = "An array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. If the operator is Gt or Lt, the values\narray must have a single element, which will be interpreted as an integer.\nThis array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchFieldModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            description = "The label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "Represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.";
            type = types.str;
          };
          "values" = mkOption {
            description = "An array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. If the operator is Gt or Lt, the values\narray must have a single element, which will be interpreted as an integer.\nThis array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchField =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "A list of node selector requirements by node's labels.";
            type = (
              types.listOf ProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpressionModule
            );
            default = [ ];
          };
          "matchFields" = mkOption {
            description = "A list of node selector requirements by node's fields.";
            type = (
              types.listOf ProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchFieldModule
            );
            default = [ ];
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreference =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchFields" != [ ]) {
      "matchFields" =
        map
          mkProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchField
          res."matchFields";
    }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "nodeSelectorTerms" = mkOption {
            description = "Required. A list of node selector terms. The terms are ORed.";
            type = (
              types.listOf ProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermModule
            );
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecution =
    res: {
      "nodeSelectorTerms" =
        map
          mkProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTerm
          res."nodeSelectorTerms";
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            description = "The label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "Represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.";
            type = types.str;
          };
          "values" = mkOption {
            description = "An array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. If the operator is Gt or Lt, the values\narray must have a single element, which will be interpreted as an integer.\nThis array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchFieldModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            description = "The label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "Represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.";
            type = types.str;
          };
          "values" = mkOption {
            description = "An array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. If the operator is Gt or Lt, the values\narray must have a single element, which will be interpreted as an integer.\nThis array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchField =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "A list of node selector requirements by node's labels.";
            type = (
              types.listOf ProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpressionModule
            );
            default = [ ];
          };
          "matchFields" = mkOption {
            description = "A list of node selector requirements by node's fields.";
            type = (
              types.listOf ProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchFieldModule
            );
            default = [ ];
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTerm =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchFields" != [ ]) {
      "matchFields" =
        map
          mkProviderKubernetesEnvoyDaemonSetPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchField
          res."matchFields";
    }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityModule = types.submodule {
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy\nthe affinity expressions specified by this field, but it may choose\na node that violates one or more of the expressions. The node that is\nmost preferred is the one with the greatest sum of weights, i.e.\nfor each node that meets all of the scheduling requirements (resource\nrequest, requiredDuringScheduling affinity expressions, etc.),\ncompute a sum by iterating through the elements of this field and adding\n\"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the\nnode(s) with the highest sum are the most preferred.";
        type = (
          types.listOf ProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the affinity requirements specified by this field are not met at\nscheduling time, the pod will not be scheduled onto the node.\nIf the affinity requirements specified by this field cease to be met\nat some point during pod execution (e.g. due to a pod label update), the\nsystem may or may not try to eventually evict the pod from its node.\nWhen there are multiple elements, the lists of nodes corresponding to each\npodAffinityTerm are intersected, i.e. all terms must be satisfied.";
        type = (
          types.listOf ProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinity =
    res:
    {
    }
    // optionalAttrs (res."preferredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "preferredDuringSchedulingIgnoredDuringExecution" =
        map
          mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecution
          res."preferredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    }
    // optionalAttrs (res."requiredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "requiredDuringSchedulingIgnoredDuringExecution" =
        map
          mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecution
          res."requiredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "podAffinityTerm" = mkOption {
            description = "Required. A pod affinity term, associated with the corresponding weight.";
            type =
              ProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule;
          };
          "weight" = mkOption {
            description = "weight associated with matching the corresponding podAffinityTerm,\nin the range 1-100.";
            type = types.int;
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecution =
    res: {
      "podAffinityTerm" =
        mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm
          res."podAffinityTerm";
      inherit (res) "weight";
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.\nIf it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr ProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule
            );
            default = null;
          };
          "matchLabelKeys" = mkOption {
            description = "MatchLabelKeys is a set of pod label keys to select which pods will\nbe taken into consideration. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are merged with `labelSelector` as `key in (value)`\nto select the group of existing pods which pods will be taken into consideration\nfor the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming\npod labels will be ignored. The default value is empty.\nThe same key is forbidden to exist in both matchLabelKeys and labelSelector.\nAlso, matchLabelKeys cannot be set when labelSelector isn't set.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "mismatchLabelKeys" = mkOption {
            description = "MismatchLabelKeys is a set of pod label keys to select which pods will\nbe taken into consideration. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are merged with `labelSelector` as `key notin (value)`\nto select the group of existing pods which pods will be taken into consideration\nfor the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming\npod labels will be ignored. The default value is empty.\nThe same key is forbidden to exist in both mismatchLabelKeys and labelSelector.\nAlso, mismatchLabelKeys cannot be set when labelSelector isn't set.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to.\nThe term is applied to the union of the namespaces selected by this field\nand the ones listed in the namespaces field.\nnull selector and null or empty namespaces list means \"this pod's namespace\".\nAn empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr ProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule
            );
            default = null;
          };
          "namespaces" = mkOption {
            description = "namespaces specifies a static list of namespace names that the term applies to.\nThe term is applied to the union of the namespaces listed in this field\nand the ones selected by namespaceSelector.\nnull or empty namespaces list and null namespaceSelector means \"this pod's namespace\".";
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            description = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching\nthe labelSelector in the specified namespaces, where co-located is defined as running on a node\nwhose value of the label with key topologyKey matches that of any node on which any of the\nselected pods is running.\nEmpty topologyKey is not allowed.";
            type = types.str;
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."matchLabelKeys" != [ ]) { inherit (res) "matchLabelKeys"; }
    // {
    }
    // optionalAttrs (res."mismatchLabelKeys" != [ ]) { inherit (res) "mismatchLabelKeys"; }
    // {
    }
    // optionalAttrs (res."namespaceSelector" != null) {
      "namespaceSelector" =
        mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.\nIf it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr ProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule
            );
            default = null;
          };
          "matchLabelKeys" = mkOption {
            description = "MatchLabelKeys is a set of pod label keys to select which pods will\nbe taken into consideration. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are merged with `labelSelector` as `key in (value)`\nto select the group of existing pods which pods will be taken into consideration\nfor the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming\npod labels will be ignored. The default value is empty.\nThe same key is forbidden to exist in both matchLabelKeys and labelSelector.\nAlso, matchLabelKeys cannot be set when labelSelector isn't set.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "mismatchLabelKeys" = mkOption {
            description = "MismatchLabelKeys is a set of pod label keys to select which pods will\nbe taken into consideration. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are merged with `labelSelector` as `key notin (value)`\nto select the group of existing pods which pods will be taken into consideration\nfor the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming\npod labels will be ignored. The default value is empty.\nThe same key is forbidden to exist in both mismatchLabelKeys and labelSelector.\nAlso, mismatchLabelKeys cannot be set when labelSelector isn't set.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to.\nThe term is applied to the union of the namespaces selected by this field\nand the ones listed in the namespaces field.\nnull selector and null or empty namespaces list means \"this pod's namespace\".\nAn empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr ProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule
            );
            default = null;
          };
          "namespaces" = mkOption {
            description = "namespaces specifies a static list of namespace names that the term applies to.\nThe term is applied to the union of the namespaces listed in this field\nand the ones selected by namespaceSelector.\nnull or empty namespaces list and null namespaceSelector means \"this pod's namespace\".";
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            description = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching\nthe labelSelector in the specified namespaces, where co-located is defined as running on a node\nwhose value of the label with key topologyKey matches that of any node on which any of the\nselected pods is running.\nEmpty topologyKey is not allowed.";
            type = types.str;
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecution =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."matchLabelKeys" != [ ]) { inherit (res) "matchLabelKeys"; }
    // {
    }
    // optionalAttrs (res."mismatchLabelKeys" != [ ]) { inherit (res) "mismatchLabelKeys"; }
    // {
    }
    // optionalAttrs (res."namespaceSelector" != null) {
      "namespaceSelector" =
        mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityModule = types.submodule {
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy\nthe anti-affinity expressions specified by this field, but it may choose\na node that violates one or more of the expressions. The node that is\nmost preferred is the one with the greatest sum of weights, i.e.\nfor each node that meets all of the scheduling requirements (resource\nrequest, requiredDuringScheduling anti-affinity expressions, etc.),\ncompute a sum by iterating through the elements of this field and adding\n\"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the\nnode(s) with the highest sum are the most preferred.";
        type = (
          types.listOf ProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the anti-affinity requirements specified by this field are not met at\nscheduling time, the pod will not be scheduled onto the node.\nIf the anti-affinity requirements specified by this field cease to be met\nat some point during pod execution (e.g. due to a pod label update), the\nsystem may or may not try to eventually evict the pod from its node.\nWhen there are multiple elements, the lists of nodes corresponding to each\npodAffinityTerm are intersected, i.e. all terms must be satisfied.";
        type = (
          types.listOf ProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinity =
    res:
    {
    }
    // optionalAttrs (res."preferredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "preferredDuringSchedulingIgnoredDuringExecution" =
        map
          mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecution
          res."preferredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    }
    // optionalAttrs (res."requiredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "requiredDuringSchedulingIgnoredDuringExecution" =
        map
          mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecution
          res."requiredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "podAffinityTerm" = mkOption {
            description = "Required. A pod affinity term, associated with the corresponding weight.";
            type =
              ProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule;
          };
          "weight" = mkOption {
            description = "weight associated with matching the corresponding podAffinityTerm,\nin the range 1-100.";
            type = types.int;
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecution =
    res: {
      "podAffinityTerm" =
        mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm
          res."podAffinityTerm";
      inherit (res) "weight";
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.\nIf it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr ProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule
            );
            default = null;
          };
          "matchLabelKeys" = mkOption {
            description = "MatchLabelKeys is a set of pod label keys to select which pods will\nbe taken into consideration. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are merged with `labelSelector` as `key in (value)`\nto select the group of existing pods which pods will be taken into consideration\nfor the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming\npod labels will be ignored. The default value is empty.\nThe same key is forbidden to exist in both matchLabelKeys and labelSelector.\nAlso, matchLabelKeys cannot be set when labelSelector isn't set.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "mismatchLabelKeys" = mkOption {
            description = "MismatchLabelKeys is a set of pod label keys to select which pods will\nbe taken into consideration. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are merged with `labelSelector` as `key notin (value)`\nto select the group of existing pods which pods will be taken into consideration\nfor the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming\npod labels will be ignored. The default value is empty.\nThe same key is forbidden to exist in both mismatchLabelKeys and labelSelector.\nAlso, mismatchLabelKeys cannot be set when labelSelector isn't set.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to.\nThe term is applied to the union of the namespaces selected by this field\nand the ones listed in the namespaces field.\nnull selector and null or empty namespaces list means \"this pod's namespace\".\nAn empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr ProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule
            );
            default = null;
          };
          "namespaces" = mkOption {
            description = "namespaces specifies a static list of namespace names that the term applies to.\nThe term is applied to the union of the namespaces listed in this field\nand the ones selected by namespaceSelector.\nnull or empty namespaces list and null namespaceSelector means \"this pod's namespace\".";
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            description = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching\nthe labelSelector in the specified namespaces, where co-located is defined as running on a node\nwhose value of the label with key topologyKey matches that of any node on which any of the\nselected pods is running.\nEmpty topologyKey is not allowed.";
            type = types.str;
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."matchLabelKeys" != [ ]) { inherit (res) "matchLabelKeys"; }
    // {
    }
    // optionalAttrs (res."mismatchLabelKeys" != [ ]) { inherit (res) "mismatchLabelKeys"; }
    // {
    }
    // optionalAttrs (res."namespaceSelector" != null) {
      "namespaceSelector" =
        mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.\nIf it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr ProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule
            );
            default = null;
          };
          "matchLabelKeys" = mkOption {
            description = "MatchLabelKeys is a set of pod label keys to select which pods will\nbe taken into consideration. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are merged with `labelSelector` as `key in (value)`\nto select the group of existing pods which pods will be taken into consideration\nfor the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming\npod labels will be ignored. The default value is empty.\nThe same key is forbidden to exist in both matchLabelKeys and labelSelector.\nAlso, matchLabelKeys cannot be set when labelSelector isn't set.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "mismatchLabelKeys" = mkOption {
            description = "MismatchLabelKeys is a set of pod label keys to select which pods will\nbe taken into consideration. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are merged with `labelSelector` as `key notin (value)`\nto select the group of existing pods which pods will be taken into consideration\nfor the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming\npod labels will be ignored. The default value is empty.\nThe same key is forbidden to exist in both mismatchLabelKeys and labelSelector.\nAlso, mismatchLabelKeys cannot be set when labelSelector isn't set.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to.\nThe term is applied to the union of the namespaces selected by this field\nand the ones listed in the namespaces field.\nnull selector and null or empty namespaces list means \"this pod's namespace\".\nAn empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr ProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule
            );
            default = null;
          };
          "namespaces" = mkOption {
            description = "namespaces specifies a static list of namespace names that the term applies to.\nThe term is applied to the union of the namespaces listed in this field\nand the ones selected by namespaceSelector.\nnull or empty namespaces list and null namespaceSelector means \"this pod's namespace\".";
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            description = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching\nthe labelSelector in the specified namespaces, where co-located is defined as running on a node\nwhose value of the label with key topologyKey matches that of any node on which any of the\nselected pods is running.\nEmpty topologyKey is not allowed.";
            type = types.str;
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecution =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."matchLabelKeys" != [ ]) { inherit (res) "matchLabelKeys"; }
    // {
    }
    // optionalAttrs (res."mismatchLabelKeys" != [ ]) { inherit (res) "mismatchLabelKeys"; }
    // {
    }
    // optionalAttrs (res."namespaceSelector" != null) {
      "namespaceSelector" =
        mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkProviderKubernetesEnvoyDaemonSetPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodImagePullSecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodImagePullSecret =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodModule = types.submodule {
    options = {
      "affinity" = mkOption {
        description = "If specified, the pod's scheduling constraints.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodAffinityModule);
        default = null;
      };
      "annotations" = mkOption {
        description = "Annotations are the annotations that should be appended to the pods.\nBy default, no pod annotations are appended.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "imagePullSecrets" = mkOption {
        description = "ImagePullSecrets is an optional list of references to secrets\nin the same namespace to use for pulling any of the images used by this PodSpec.\nIf specified, these secrets will be passed to individual puller implementations for them to use.\nMore info: https://kubernetes.io/docs/concepts/containers/images#specifying-imagepullsecrets-on-a-pod";
        type = (types.listOf ProviderKubernetesEnvoyDaemonSetPodImagePullSecretModule);
        default = [ ];
      };
      "labels" = mkOption {
        description = "Labels are the additional labels that should be tagged to the pods.\nBy default, no additional pod labels are tagged.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "nodeSelector" = mkOption {
        description = "NodeSelector is a selector which must be true for the pod to fit on a node.\nSelector which must match a node's labels for the pod to be scheduled on that node.\nMore info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/";
        type = (types.attrsOf types.str);
        default = { };
      };
      "securityContext" = mkOption {
        description = "SecurityContext holds pod-level security attributes and common container settings.\nOptional: Defaults to empty.  See type description for default values of each field.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodSecurityContextModule);
        default = null;
      };
      "tolerations" = mkOption {
        description = "If specified, the pod's tolerations.";
        type = (types.listOf ProviderKubernetesEnvoyDaemonSetPodTolerationModule);
        default = [ ];
      };
      "topologySpreadConstraints" = mkOption {
        description = "TopologySpreadConstraints describes how a group of pods ought to spread across topology\ndomains. Scheduler will schedule pods in a way which abides by the constraints.\nAll topologySpreadConstraints are ANDed.";
        type = (types.listOf ProviderKubernetesEnvoyDaemonSetPodTopologySpreadConstraintModule);
        default = [ ];
      };
      "volumes" = mkOption {
        description = "Volumes that can be mounted by containers belonging to the pod.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes";
        type = (types.listOf ProviderKubernetesEnvoyDaemonSetPodVolumeModule);
        default = [ ];
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPod =
    res:
    {
    }
    // optionalAttrs (res."affinity" != null) {
      "affinity" = mkProviderKubernetesEnvoyDaemonSetPodAffinity res."affinity";
    }
    // {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."imagePullSecrets" != [ ]) {
      "imagePullSecrets" =
        map mkProviderKubernetesEnvoyDaemonSetPodImagePullSecret
          res."imagePullSecrets";
    }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."nodeSelector" != { }) { inherit (res) "nodeSelector"; }
    // {
    }
    // optionalAttrs (res."securityContext" != null) {
      "securityContext" = mkProviderKubernetesEnvoyDaemonSetPodSecurityContext res."securityContext";
    }
    // {
    }
    // optionalAttrs (res."tolerations" != [ ]) {
      "tolerations" = map mkProviderKubernetesEnvoyDaemonSetPodToleration res."tolerations";
    }
    // {
    }
    // optionalAttrs (res."topologySpreadConstraints" != [ ]) {
      "topologySpreadConstraints" =
        map mkProviderKubernetesEnvoyDaemonSetPodTopologySpreadConstraint
          res."topologySpreadConstraints";
    }
    // {
    }
    // optionalAttrs (res."volumes" != [ ]) {
      "volumes" = map mkProviderKubernetesEnvoyDaemonSetPodVolume res."volumes";
    }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodSecurityContextAppArmorProfileModule = types.submodule {
    options = {
      "localhostProfile" = mkOption {
        description = "localhostProfile indicates a profile loaded on the node that should be used.\nThe profile must be preconfigured on the node to work.\nMust match the loaded name of the profile.\nMust be set if and only if type is \"Localhost\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "type indicates which kind of AppArmor profile will be applied.\nValid options are:\n  Localhost - a profile pre-loaded on the node.\n  RuntimeDefault - the container runtime's default profile.\n  Unconfined - no AppArmor enforcement.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodSecurityContextAppArmorProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  ProviderKubernetesEnvoyDaemonSetPodSecurityContextModule = types.submodule {
    options = {
      "appArmorProfile" = mkOption {
        description = "appArmorProfile is the AppArmor options to use by the containers in this pod.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodSecurityContextAppArmorProfileModule);
        default = null;
      };
      "fsGroup" = mkOption {
        description = "A special supplemental group that applies to all containers in a pod.\nSome volume types allow the Kubelet to change the ownership of that volume\nto be owned by the pod:\n\n1. The owning GID will be the FSGroup\n2. The setgid bit is set (new files created in the volume will be owned by FSGroup)\n3. The permission bits are OR'd with rw-rw----\n\nIf unset, the Kubelet will not modify the ownership and permissions of any volume.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.int);
        default = null;
      };
      "fsGroupChangePolicy" = mkOption {
        description = "fsGroupChangePolicy defines behavior of changing ownership and permission of the volume\nbefore being exposed inside Pod. This field will only apply to\nvolume types which support fsGroup based ownership(and permissions).\nIt will have no effect on ephemeral volume types such as: secret, configmaps\nand emptydir.\nValid values are \"OnRootMismatch\" and \"Always\". If not specified, \"Always\" is used.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.str);
        default = null;
      };
      "runAsGroup" = mkOption {
        description = "The GID to run the entrypoint of the container process.\nUses runtime default if unset.\nMay also be set in SecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence\nfor that container.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.int);
        default = null;
      };
      "runAsNonRoot" = mkOption {
        description = "Indicates that the container must run as a non-root user.\nIf true, the Kubelet will validate the image at runtime to ensure that it\ndoes not run as UID 0 (root) and fail to start the container if it does.\nIf unset or false, no such validation will be performed.\nMay also be set in SecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.";
        type = types.bool;
        default = false;
      };
      "runAsUser" = mkOption {
        description = "The UID to run the entrypoint of the container process.\nDefaults to user specified in image metadata if unspecified.\nMay also be set in SecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence\nfor that container.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.int);
        default = null;
      };
      "seLinuxChangePolicy" = mkOption {
        description = "seLinuxChangePolicy defines how the container's SELinux label is applied to all volumes used by the Pod.\nIt has no effect on nodes that do not support SELinux or to volumes does not support SELinux.\nValid values are \"MountOption\" and \"Recursive\".\n\n\"Recursive\" means relabeling of all files on all Pod volumes by the container runtime.\nThis may be slow for large volumes, but allows mixing privileged and unprivileged Pods sharing the same volume on the same node.\n\n\"MountOption\" mounts all eligible Pod volumes with `-o context` mount option.\nThis requires all Pods that share the same volume to use the same SELinux label.\nIt is not possible to share the same volume among privileged and unprivileged Pods.\nEligible volumes are in-tree FibreChannel and iSCSI volumes, and all CSI volumes\nwhose CSI driver announces SELinux support by setting spec.seLinuxMount: true in their\nCSIDriver instance. Other volumes are always re-labelled recursively.\n\"MountOption\" value is allowed only when SELinuxMount feature gate is enabled.\n\nIf not specified and SELinuxMount feature gate is enabled, \"MountOption\" is used.\nIf not specified and SELinuxMount feature gate is disabled, \"MountOption\" is used for ReadWriteOncePod volumes\nand \"Recursive\" for all other volumes.\n\nThis field affects only Pods that have SELinux label set, either in PodSecurityContext or in SecurityContext of all containers.\n\nAll Pods that use the same volume should use the same seLinuxChangePolicy, otherwise some pods can get stuck in ContainerCreating state.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.str);
        default = null;
      };
      "seLinuxOptions" = mkOption {
        description = "The SELinux context to be applied to all containers.\nIf unspecified, the container runtime will allocate a random SELinux context for each\ncontainer.  May also be set in SecurityContext.  If set in\nboth SecurityContext and PodSecurityContext, the value specified in SecurityContext\ntakes precedence for that container.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodSecurityContextSeLinuxOptionsModule);
        default = null;
      };
      "seccompProfile" = mkOption {
        description = "The seccomp options to use by the containers in this pod.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodSecurityContextSeccompProfileModule);
        default = null;
      };
      "supplementalGroups" = mkOption {
        description = "A list of groups applied to the first process run in each container, in\naddition to the container's primary GID and fsGroup (if specified).  If\nthe SupplementalGroupsPolicy feature is enabled, the\nsupplementalGroupsPolicy field determines whether these are in addition\nto or instead of any group memberships defined in the container image.\nIf unspecified, no additional groups are added, though group memberships\ndefined in the container image may still be used, depending on the\nsupplementalGroupsPolicy field.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.listOf types.int);
        default = [ ];
      };
      "supplementalGroupsPolicy" = mkOption {
        description = "Defines how supplemental groups of the first container processes are calculated.\nValid values are \"Merge\" and \"Strict\". If not specified, \"Merge\" is used.\n(Alpha) Using the field requires the SupplementalGroupsPolicy feature gate to be enabled\nand the container runtime must implement support for this feature.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.str);
        default = null;
      };
      "sysctls" = mkOption {
        description = "Sysctls hold a list of namespaced sysctls used for the pod. Pods with unsupported\nsysctls (by the container runtime) might fail to launch.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.listOf ProviderKubernetesEnvoyDaemonSetPodSecurityContextSysctlModule);
        default = [ ];
      };
      "windowsOptions" = mkOption {
        description = "The Windows specific settings applied to all containers.\nIf unspecified, the options within a container's SecurityContext will be used.\nIf set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is linux.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodSecurityContextWindowsOptionsModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodSecurityContext =
    res:
    {
    }
    // optionalAttrs (res."appArmorProfile" != null) {
      "appArmorProfile" =
        mkProviderKubernetesEnvoyDaemonSetPodSecurityContextAppArmorProfile
          res."appArmorProfile";
    }
    // {
    }
    // optionalAttrs (res."fsGroup" != null) { inherit (res) "fsGroup"; }
    // {
    }
    // optionalAttrs (res."fsGroupChangePolicy" != null) { inherit (res) "fsGroupChangePolicy"; }
    // {
    }
    // optionalAttrs (res."runAsGroup" != null) { inherit (res) "runAsGroup"; }
    // {
    }
    // optionalAttrs res."runAsNonRoot" { inherit (res) "runAsNonRoot"; }
    // {
    }
    // optionalAttrs (res."runAsUser" != null) { inherit (res) "runAsUser"; }
    // {
    }
    // optionalAttrs (res."seLinuxChangePolicy" != null) { inherit (res) "seLinuxChangePolicy"; }
    // {
    }
    // optionalAttrs (res."seLinuxOptions" != null) {
      "seLinuxOptions" =
        mkProviderKubernetesEnvoyDaemonSetPodSecurityContextSeLinuxOptions
          res."seLinuxOptions";
    }
    // {
    }
    // optionalAttrs (res."seccompProfile" != null) {
      "seccompProfile" =
        mkProviderKubernetesEnvoyDaemonSetPodSecurityContextSeccompProfile
          res."seccompProfile";
    }
    // {
    }
    // optionalAttrs (res."supplementalGroups" != [ ]) { inherit (res) "supplementalGroups"; }
    // {
    }
    // optionalAttrs (res."supplementalGroupsPolicy" != null) {
      inherit (res) "supplementalGroupsPolicy";
    }
    // {
    }
    // optionalAttrs (res."sysctls" != [ ]) {
      "sysctls" = map mkProviderKubernetesEnvoyDaemonSetPodSecurityContextSysctl res."sysctls";
    }
    // {
    }
    // optionalAttrs (res."windowsOptions" != null) {
      "windowsOptions" =
        mkProviderKubernetesEnvoyDaemonSetPodSecurityContextWindowsOptions
          res."windowsOptions";
    }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodSecurityContextSeLinuxOptionsModule = types.submodule {
    options = {
      "level" = mkOption {
        description = "Level is SELinux level label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
      "role" = mkOption {
        description = "Role is a SELinux role label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Type is a SELinux type label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
      "user" = mkOption {
        description = "User is a SELinux user label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodSecurityContextSeLinuxOptions =
    res:
    {
    }
    // optionalAttrs (res."level" != null) { inherit (res) "level"; }
    // {
    }
    // optionalAttrs (res."role" != null) { inherit (res) "role"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    }
    // optionalAttrs (res."user" != null) { inherit (res) "user"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodSecurityContextSeccompProfileModule = types.submodule {
    options = {
      "localhostProfile" = mkOption {
        description = "localhostProfile indicates a profile defined in a file on the node should be used.\nThe profile must be preconfigured on the node to work.\nMust be a descending path, relative to the kubelet's configured seccomp profile location.\nMust be set if type is \"Localhost\". Must NOT be set for any other type.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "type indicates which kind of seccomp profile will be applied.\nValid options are:\n\nLocalhost - a profile defined in a file on the node should be used.\nRuntimeDefault - the container runtime default profile should be used.\nUnconfined - no profile should be applied.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodSecurityContextSeccompProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  ProviderKubernetesEnvoyDaemonSetPodSecurityContextSysctlModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of a property to set";
        type = types.str;
      };
      "value" = mkOption {
        description = "Value of a property to set";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodSecurityContextSysctl = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  ProviderKubernetesEnvoyDaemonSetPodSecurityContextWindowsOptionsModule = types.submodule {
    options = {
      "gmsaCredentialSpec" = mkOption {
        description = "GMSACredentialSpec is where the GMSA admission webhook\n(https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the\nGMSA credential spec named by the GMSACredentialSpecName field.";
        type = (types.nullOr types.str);
        default = null;
      };
      "gmsaCredentialSpecName" = mkOption {
        description = "GMSACredentialSpecName is the name of the GMSA credential spec to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "hostProcess" = mkOption {
        description = "HostProcess determines if a container should be run as a 'Host Process' container.\nAll of a Pod's containers must have the same effective HostProcess value\n(it is not allowed to have a mix of HostProcess containers and non-HostProcess containers).\nIn addition, if HostProcess is true then HostNetwork must also be set to true.";
        type = types.bool;
        default = false;
      };
      "runAsUserName" = mkOption {
        description = "The UserName in Windows to run the entrypoint of the container process.\nDefaults to the user specified in image metadata if unspecified.\nMay also be set in PodSecurityContext. If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodSecurityContextWindowsOptions =
    res:
    {
    }
    // optionalAttrs (res."gmsaCredentialSpec" != null) { inherit (res) "gmsaCredentialSpec"; }
    // {
    }
    // optionalAttrs (res."gmsaCredentialSpecName" != null) { inherit (res) "gmsaCredentialSpecName"; }
    // {
    }
    // optionalAttrs res."hostProcess" { inherit (res) "hostProcess"; }
    // {
    }
    // optionalAttrs (res."runAsUserName" != null) { inherit (res) "runAsUserName"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodTolerationModule = types.submodule {
    options = {
      "effect" = mkOption {
        description = "Effect indicates the taint effect to match. Empty means match all taint effects.\nWhen specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute.";
        type = (types.nullOr types.str);
        default = null;
      };
      "key" = mkOption {
        description = "Key is the taint key that the toleration applies to. Empty means match all taint keys.\nIf the key is empty, operator must be Exists; this combination means to match all values and all keys.";
        type = (types.nullOr types.str);
        default = null;
      };
      "operator" = mkOption {
        description = "Operator represents a key's relationship to the value.\nValid operators are Exists and Equal. Defaults to Equal.\nExists is equivalent to wildcard for value, so that a pod can\ntolerate all taints of a particular category.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tolerationSeconds" = mkOption {
        description = "TolerationSeconds represents the period of time the toleration (which must be\nof effect NoExecute, otherwise this field is ignored) tolerates the taint. By default,\nit is not set, which means tolerate the taint forever (do not evict). Zero and\nnegative values will be treated as 0 (evict immediately) by the system.";
        type = (types.nullOr types.int);
        default = null;
      };
      "value" = mkOption {
        description = "Value is the taint value the toleration matches to.\nIf the operator is Exists, the value should be empty, otherwise just a regular string.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodToleration =
    res:
    {
    }
    // optionalAttrs (res."effect" != null) { inherit (res) "effect"; }
    // {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
    }
    // optionalAttrs (res."operator" != null) { inherit (res) "operator"; }
    // {
    }
    // optionalAttrs (res."tolerationSeconds" != null) { inherit (res) "tolerationSeconds"; }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodTopologySpreadConstraintLabelSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkProviderKubernetesEnvoyDaemonSetPodTopologySpreadConstraintLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodTopologySpreadConstraintLabelSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (
          types.listOf ProviderKubernetesEnvoyDaemonSetPodTopologySpreadConstraintLabelSelectorMatchExpressionModule
        );
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodTopologySpreadConstraintLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkProviderKubernetesEnvoyDaemonSetPodTopologySpreadConstraintLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodTopologySpreadConstraintModule = types.submodule {
    options = {
      "labelSelector" = mkOption {
        description = "LabelSelector is used to find matching pods.\nPods that match this label selector are counted to determine the number of pods\nin their corresponding topology domain.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDaemonSetPodTopologySpreadConstraintLabelSelectorModule
        );
        default = null;
      };
      "matchLabelKeys" = mkOption {
        description = "MatchLabelKeys is a set of pod label keys to select the pods over which\nspreading will be calculated. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are ANDed with labelSelector\nto select the group of existing pods over which spreading will be calculated\nfor the incoming pod. The same key is forbidden to exist in both MatchLabelKeys and LabelSelector.\nMatchLabelKeys cannot be set when LabelSelector isn't set.\nKeys that don't exist in the incoming pod labels will\nbe ignored. A null or empty list means only match against labelSelector.\n\nThis is a beta field and requires the MatchLabelKeysInPodTopologySpread feature gate to be enabled (enabled by default).";
        type = (types.listOf types.str);
        default = [ ];
      };
      "maxSkew" = mkOption {
        description = "MaxSkew describes the degree to which pods may be unevenly distributed.\nWhen `whenUnsatisfiable=DoNotSchedule`, it is the maximum permitted difference\nbetween the number of matching pods in the target topology and the global minimum.\nThe global minimum is the minimum number of matching pods in an eligible domain\nor zero if the number of eligible domains is less than MinDomains.\nFor example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same\nlabelSelector spread as 2/2/1:\nIn this case, the global minimum is 1.\n| zone1 | zone2 | zone3 |\n|  P P  |  P P  |   P   |\n- if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 2/2/2;\nscheduling it onto zone1(zone2) would make the ActualSkew(3-1) on zone1(zone2)\nviolate MaxSkew(1).\n- if MaxSkew is 2, incoming pod can be scheduled onto any zone.\nWhen `whenUnsatisfiable=ScheduleAnyway`, it is used to give higher precedence\nto topologies that satisfy it.\nIt's a required field. Default value is 1 and 0 is not allowed.";
        type = types.int;
      };
      "minDomains" = mkOption {
        description = "MinDomains indicates a minimum number of eligible domains.\nWhen the number of eligible domains with matching topology keys is less than minDomains,\nPod Topology Spread treats \"global minimum\" as 0, and then the calculation of Skew is performed.\nAnd when the number of eligible domains with matching topology keys equals or greater than minDomains,\nthis value has no effect on scheduling.\nAs a result, when the number of eligible domains is less than minDomains,\nscheduler won't schedule more than maxSkew Pods to those domains.\nIf value is nil, the constraint behaves as if MinDomains is equal to 1.\nValid values are integers greater than 0.\nWhen value is not nil, WhenUnsatisfiable must be DoNotSchedule.\n\nFor example, in a 3-zone cluster, MaxSkew is set to 2, MinDomains is set to 5 and pods with the same\nlabelSelector spread as 2/2/2:\n| zone1 | zone2 | zone3 |\n|  P P  |  P P  |  P P  |\nThe number of domains is less than 5(MinDomains), so \"global minimum\" is treated as 0.\nIn this situation, new pod with the same labelSelector cannot be scheduled,\nbecause computed skew will be 3(3 - 0) if new Pod is scheduled to any of the three zones,\nit will violate MaxSkew.";
        type = (types.nullOr types.int);
        default = null;
      };
      "nodeAffinityPolicy" = mkOption {
        description = "NodeAffinityPolicy indicates how we will treat Pod's nodeAffinity/nodeSelector\nwhen calculating pod topology spread skew. Options are:\n- Honor: only nodes matching nodeAffinity/nodeSelector are included in the calculations.\n- Ignore: nodeAffinity/nodeSelector are ignored. All nodes are included in the calculations.\n\nIf this value is nil, the behavior is equivalent to the Honor policy.";
        type = (types.nullOr types.str);
        default = null;
      };
      "nodeTaintsPolicy" = mkOption {
        description = "NodeTaintsPolicy indicates how we will treat node taints when calculating\npod topology spread skew. Options are:\n- Honor: nodes without taints, along with tainted nodes for which the incoming pod\nhas a toleration, are included.\n- Ignore: node taints are ignored. All nodes are included.\n\nIf this value is nil, the behavior is equivalent to the Ignore policy.";
        type = (types.nullOr types.str);
        default = null;
      };
      "topologyKey" = mkOption {
        description = "TopologyKey is the key of node labels. Nodes that have a label with this key\nand identical values are considered to be in the same topology.\nWe consider each <key, value> as a \"bucket\", and try to put balanced number\nof pods into each bucket.\nWe define a domain as a particular instance of a topology.\nAlso, we define an eligible domain as a domain whose nodes meet the requirements of\nnodeAffinityPolicy and nodeTaintsPolicy.\ne.g. If TopologyKey is \"kubernetes.io/hostname\", each Node is a domain of that topology.\nAnd, if TopologyKey is \"topology.kubernetes.io/zone\", each zone is a domain of that topology.\nIt's a required field.";
        type = types.str;
      };
      "whenUnsatisfiable" = mkOption {
        description = "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy\nthe spread constraint.\n- DoNotSchedule (default) tells the scheduler not to schedule it.\n- ScheduleAnyway tells the scheduler to schedule the pod in any location,\n  but giving higher precedence to topologies that would help reduce the\n  skew.\nA constraint is considered \"Unsatisfiable\" for an incoming pod\nif and only if every possible node assignment for that pod would violate\n\"MaxSkew\" on some topology.\nFor example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same\nlabelSelector spread as 3/1/1:\n| zone1 | zone2 | zone3 |\n| P P P |   P   |   P   |\nIf WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled\nto zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies\nMaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler\nwon't make it *more* imbalanced.\nIt's a required field.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodTopologySpreadConstraint =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkProviderKubernetesEnvoyDaemonSetPodTopologySpreadConstraintLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."matchLabelKeys" != [ ]) { inherit (res) "matchLabelKeys"; }
    // {
      inherit (res) "maxSkew";
    }
    // optionalAttrs (res."minDomains" != null) { inherit (res) "minDomains"; }
    // {
    }
    // optionalAttrs (res."nodeAffinityPolicy" != null) { inherit (res) "nodeAffinityPolicy"; }
    // {
    }
    // optionalAttrs (res."nodeTaintsPolicy" != null) { inherit (res) "nodeTaintsPolicy"; }
    // {
      inherit (res) "topologyKey";
      inherit (res) "whenUnsatisfiable";
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeAwsElasticBlockStoreModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is the filesystem type of the volume that you want to mount.\nTip: Ensure that the filesystem type is supported by the host operating system.\nExamples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore";
        type = (types.nullOr types.str);
        default = null;
      };
      "partition" = mkOption {
        description = "partition is the partition in the volume that you want to mount.\nIf omitted, the default is to mount by volume name.\nExamples: For volume /dev/sda1, you specify the partition as \"1\".\nSimilarly, the volume partition for /dev/sda is \"0\" (or you can leave the property empty).";
        type = (types.nullOr types.int);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly value true will force the readOnly setting in VolumeMounts.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore";
        type = types.bool;
        default = false;
      };
      "volumeID" = mkOption {
        description = "volumeID is unique ID of the persistent disk resource in AWS (Amazon EBS volume).\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeAwsElasticBlockStore =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."partition" != null) { inherit (res) "partition"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
      inherit (res) "volumeID";
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeAzureDiskModule = types.submodule {
    options = {
      "cachingMode" = mkOption {
        description = "cachingMode is the Host Caching mode: None, Read Only, Read Write.";
        type = (types.nullOr types.str);
        default = null;
      };
      "diskName" = mkOption {
        description = "diskName is the Name of the data disk in the blob storage";
        type = types.str;
      };
      "diskURI" = mkOption {
        description = "diskURI is the URI of data disk in the blob storage";
        type = types.str;
      };
      "fsType" = mkOption {
        description = "fsType is Filesystem type to mount.\nMust be a filesystem type supported by the host operating system.\nEx. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.";
        type = (types.nullOr types.str);
        default = "ext4";
      };
      "kind" = mkOption {
        description = "kind expected values are Shared: multiple blob disks per storage account  Dedicated: single blob disk per storage account  Managed: azure managed data disk (only in managed availability set). defaults to shared";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly Defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeAzureDisk =
    res:
    {
    }
    // optionalAttrs (res."cachingMode" != null) { inherit (res) "cachingMode"; }
    // {
      inherit (res) "diskName";
      inherit (res) "diskURI";
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."kind" != null) { inherit (res) "kind"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeAzureFileModule = types.submodule {
    options = {
      "readOnly" = mkOption {
        description = "readOnly defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.";
        type = types.bool;
        default = false;
      };
      "secretName" = mkOption {
        description = "secretName is the  name of secret that contains Azure Storage Account Name and Key";
        type = types.str;
      };
      "shareName" = mkOption {
        description = "shareName is the azure share Name";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeAzureFile =
    res:
    {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
      inherit (res) "secretName";
      inherit (res) "shareName";
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeCephfsModule = types.submodule {
    options = {
      "monitors" = mkOption {
        description = "monitors is Required: Monitors is a collection of Ceph monitors\nMore info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it";
        type = (types.listOf types.str);
      };
      "path" = mkOption {
        description = "path is Optional: Used as the mounted root, rather than the full Ceph tree, default is /";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly is Optional: Defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.\nMore info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it";
        type = types.bool;
        default = false;
      };
      "secretFile" = mkOption {
        description = "secretFile is Optional: SecretFile is the path to key ring for User, default is /etc/ceph/user.secret\nMore info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it";
        type = (types.nullOr types.str);
        default = null;
      };
      "secretRef" = mkOption {
        description = "secretRef is Optional: SecretRef is reference to the authentication secret for User, default is empty.\nMore info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeCephfsSecretRefModule);
        default = null;
      };
      "user" = mkOption {
        description = "user is optional: User is the rados user name, default is admin\nMore info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeCephfs =
    res:
    {
      inherit (res) "monitors";
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."secretFile" != null) { inherit (res) "secretFile"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderKubernetesEnvoyDaemonSetPodVolumeCephfsSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."user" != null) { inherit (res) "user"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeCephfsSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeCephfsSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeCinderModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is the filesystem type to mount.\nMust be a filesystem type supported by the host operating system.\nExamples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.\nMore info: https://examples.k8s.io/mysql-cinder-pd/README.md";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.\nMore info: https://examples.k8s.io/mysql-cinder-pd/README.md";
        type = types.bool;
        default = false;
      };
      "secretRef" = mkOption {
        description = "secretRef is optional: points to a secret object containing parameters used to connect\nto OpenStack.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeCinderSecretRefModule);
        default = null;
      };
      "volumeID" = mkOption {
        description = "volumeID used to identify the volume in cinder.\nMore info: https://examples.k8s.io/mysql-cinder-pd/README.md";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeCinder =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderKubernetesEnvoyDaemonSetPodVolumeCinderSecretRef res."secretRef";
    }
    // {
      inherit (res) "volumeID";
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeCinderSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeCinderSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeConfigMapItemModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the key to project.";
        type = types.str;
      };
      "mode" = mkOption {
        description = "mode is Optional: mode bits used to set permissions on this file.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nIf not specified, the volume defaultMode will be used.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        description = "path is the relative path of the file to map the key to.\nMay not be an absolute path.\nMay not contain the path element '..'.\nMay not start with the string '..'.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeConfigMapItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeConfigMapModule = types.submodule {
    options = {
      "defaultMode" = mkOption {
        description = "defaultMode is optional: mode bits used to set permissions on created files by default.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nDefaults to 0644.\nDirectories within the path are not affected by this setting.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "items" = mkOption {
        description = "items if unspecified, each key-value pair in the Data field of the referenced\nConfigMap will be projected into the volume as a file whose name is the\nkey and content is the value. If specified, the listed keys will be\nprojected into the specified paths, and unlisted keys will not be\npresent. If a key is specified which is not present in the ConfigMap,\nthe volume setup will error unless it is marked optional. Paths must be\nrelative and may not contain the '..' path or start with '..'.";
        type = (types.listOf ProviderKubernetesEnvoyDaemonSetPodVolumeConfigMapItemModule);
        default = [ ];
      };
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "optional specify whether the ConfigMap or its keys must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeConfigMap =
    res:
    {
    }
    // optionalAttrs (res."defaultMode" != null) { inherit (res) "defaultMode"; }
    // {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkProviderKubernetesEnvoyDaemonSetPodVolumeConfigMapItem res."items";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeCsiModule = types.submodule {
    options = {
      "driver" = mkOption {
        description = "driver is the name of the CSI driver that handles this volume.\nConsult with your admin for the correct name as registered in the cluster.";
        type = types.str;
      };
      "fsType" = mkOption {
        description = "fsType to mount. Ex. \"ext4\", \"xfs\", \"ntfs\".\nIf not provided, the empty value is passed to the associated CSI driver\nwhich will determine the default filesystem to apply.";
        type = (types.nullOr types.str);
        default = null;
      };
      "nodePublishSecretRef" = mkOption {
        description = "nodePublishSecretRef is a reference to the secret object containing\nsensitive information to pass to the CSI driver to complete the CSI\nNodePublishVolume and NodeUnpublishVolume calls.\nThis field is optional, and  may be empty if no secret is required. If the\nsecret object contains more than one secret, all secret references are passed.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeCsiNodePublishSecretRefModule);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly specifies a read-only configuration for the volume.\nDefaults to false (read/write).";
        type = types.bool;
        default = false;
      };
      "volumeAttributes" = mkOption {
        description = "volumeAttributes stores driver-specific properties that are passed to the CSI\ndriver. Consult your driver's documentation for supported values.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeCsi =
    res:
    {
      inherit (res) "driver";
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."nodePublishSecretRef" != null) {
      "nodePublishSecretRef" =
        mkProviderKubernetesEnvoyDaemonSetPodVolumeCsiNodePublishSecretRef
          res."nodePublishSecretRef";
    }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."volumeAttributes" != { }) { inherit (res) "volumeAttributes"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeCsiNodePublishSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeCsiNodePublishSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeDownwardAPIItemFieldRefModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        description = "Version of the schema the FieldPath is written in terms of, defaults to \"v1\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "fieldPath" = mkOption {
        description = "Path of the field to select in the specified API version.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeDownwardAPIItemFieldRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "fieldPath";
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeDownwardAPIItemModule = types.submodule {
    options = {
      "fieldRef" = mkOption {
        description = "Required: Selects a field of the pod: only annotations, labels, name, namespace and uid are supported.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeDownwardAPIItemFieldRefModule);
        default = null;
      };
      "mode" = mkOption {
        description = "Optional: mode bits used to set permissions on this file, must be an octal value\nbetween 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nIf not specified, the volume defaultMode will be used.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        description = "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'";
        type = types.str;
      };
      "resourceFieldRef" = mkOption {
        description = "Selects a resource of the container: only resources limits and requests\n(limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeDownwardAPIItemResourceFieldRefModule
        );
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeDownwardAPIItem =
    res:
    {
    }
    // optionalAttrs (res."fieldRef" != null) {
      "fieldRef" = mkProviderKubernetesEnvoyDaemonSetPodVolumeDownwardAPIItemFieldRef res."fieldRef";
    }
    // {
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    }
    // optionalAttrs (res."resourceFieldRef" != null) {
      "resourceFieldRef" =
        mkProviderKubernetesEnvoyDaemonSetPodVolumeDownwardAPIItemResourceFieldRef
          res."resourceFieldRef";
    }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeDownwardAPIItemResourceFieldRefModule = types.submodule {
    options = {
      "containerName" = mkOption {
        description = "Container name: required for volumes, optional for env vars";
        type = (types.nullOr types.str);
        default = null;
      };
      "divisor" = mkOption {
        description = "Specifies the output format of the exposed resources, defaults to \"1\"";
        type = types.anything;
        default = { };
      };
      "resource" = mkOption {
        description = "Required: resource to select";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeDownwardAPIItemResourceFieldRef =
    res:
    {
    }
    // optionalAttrs (res."containerName" != null) { inherit (res) "containerName"; }
    // {
    }
    // optionalAttrs (res."divisor" != null) { inherit (res) "divisor"; }
    // {
      inherit (res) "resource";
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeDownwardAPIModule = types.submodule {
    options = {
      "defaultMode" = mkOption {
        description = "Optional: mode bits to use on created files by default. Must be a\nOptional: mode bits used to set permissions on created files by default.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nDefaults to 0644.\nDirectories within the path are not affected by this setting.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "items" = mkOption {
        description = "Items is a list of downward API volume file";
        type = (types.listOf ProviderKubernetesEnvoyDaemonSetPodVolumeDownwardAPIItemModule);
        default = [ ];
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeDownwardAPI =
    res:
    {
    }
    // optionalAttrs (res."defaultMode" != null) { inherit (res) "defaultMode"; }
    // {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkProviderKubernetesEnvoyDaemonSetPodVolumeDownwardAPIItem res."items";
    }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeEmptyDirModule = types.submodule {
    options = {
      "medium" = mkOption {
        description = "medium represents what type of storage medium should back this directory.\nThe default is \"\" which means to use the node's default medium.\nMust be an empty string (default) or Memory.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir";
        type = (types.nullOr types.str);
        default = null;
      };
      "sizeLimit" = mkOption {
        description = "sizeLimit is the total amount of local storage required for this EmptyDir volume.\nThe size limit is also applicable for memory medium.\nThe maximum usage on memory medium EmptyDir would be the minimum value between\nthe SizeLimit specified here and the sum of memory limits of all containers in a pod.\nThe default is nil which means that the limit is undefined.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir";
        type = types.anything;
        default = { };
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeEmptyDir =
    res:
    {
    }
    // optionalAttrs (res."medium" != null) { inherit (res) "medium"; }
    // {
    }
    // optionalAttrs (res."sizeLimit" != null) { inherit (res) "sizeLimit"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralModule = types.submodule {
    options = {
      "volumeClaimTemplate" = mkOption {
        description = "Will be used to create a stand-alone PVC to provision the volume.\nThe pod in which this EphemeralVolumeSource is embedded will be the\nowner of the PVC, i.e. the PVC will be deleted together with the\npod.  The name of the PVC will be `<pod name>-<volume name>` where\n`<volume name>` is the name from the `PodSpec.Volumes` array\nentry. Pod validation will reject the pod if the concatenated name\nis not valid for a PVC (for example, too long).\n\nAn existing PVC with that name that is not owned by the pod\nwill *not* be used for the pod to avoid using an unrelated\nvolume by mistake. Starting the pod is then blocked until\nthe unrelated PVC is removed. If such a pre-created PVC is\nmeant to be used by the pod, the PVC has to updated with an\nowner reference to the pod once the pod exists. Normally\nthis should not be necessary, but it may be useful when\nmanually reconstructing a broken cluster.\n\nThis field is read-only and no changes will be made by Kubernetes\nto the PVC after it has been created.\n\nRequired, must not be nil.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeEphemeral =
    res:
    {
    }
    // optionalAttrs (res."volumeClaimTemplate" != null) {
      "volumeClaimTemplate" =
        mkProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplate
          res."volumeClaimTemplate";
    }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateModule = types.submodule {
    options = {
      "metadata" = mkOption {
        description = "May contain labels and annotations that will be copied into the PVC\nwhen creating it. No other fields are allowed and will be rejected during\nvalidation.";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "spec" = mkOption {
        description = "The specification for the PersistentVolumeClaim. The entire content is\ncopied unchanged into the PVC that gets created from this\ntemplate. The same fields as in a PersistentVolumeClaim\nare also valid here.";
        type = ProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateSpecModule;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplate =
    res:
    {
    }
    // optionalAttrs (res."metadata" != { }) { inherit (res) "metadata"; }
    // {
      "spec" = mkProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateSpec res."spec";
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateSpecDataSourceModule =
    types.submodule
      {
        options = {
          "apiGroup" = mkOption {
            description = "APIGroup is the group for the resource being referenced.\nIf APIGroup is not specified, the specified Kind must be in the core API group.\nFor any other third-party types, APIGroup is required.";
            type = (types.nullOr types.str);
            default = null;
          };
          "kind" = mkOption {
            description = "Kind is the type of resource being referenced";
            type = types.str;
          };
          "name" = mkOption {
            description = "Name is the name of resource being referenced";
            type = types.str;
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateSpecDataSource =
    res:
    {
    }
    // optionalAttrs (res."apiGroup" != null) { inherit (res) "apiGroup"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateSpecDataSourceRefModule =
    types.submodule
      {
        options = {
          "apiGroup" = mkOption {
            description = "APIGroup is the group for the resource being referenced.\nIf APIGroup is not specified, the specified Kind must be in the core API group.\nFor any other third-party types, APIGroup is required.";
            type = (types.nullOr types.str);
            default = null;
          };
          "kind" = mkOption {
            description = "Kind is the type of resource being referenced";
            type = types.str;
          };
          "name" = mkOption {
            description = "Name is the name of resource being referenced";
            type = types.str;
          };
          "namespace" = mkOption {
            description = "Namespace is the namespace of resource being referenced\nNote that when a namespace is specified, a gateway.networking.k8s.io/ReferenceGrant object is required in the referent namespace to allow that namespace's owner to accept the reference. See the ReferenceGrant documentation for details.\n(Alpha) This field requires the CrossNamespaceVolumeDataSource feature gate to be enabled.";
            type = (types.nullOr types.str);
            default = null;
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateSpecDataSourceRef =
    res:
    {
    }
    // optionalAttrs (res."apiGroup" != null) { inherit (res) "apiGroup"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateSpecModule = types.submodule {
    options = {
      "accessModes" = mkOption {
        description = "accessModes contains the desired access modes the volume should have.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1";
        type = (types.listOf types.str);
        default = [ ];
      };
      "dataSource" = mkOption {
        description = "dataSource field can be used to specify either:\n* An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot)\n* An existing PVC (PersistentVolumeClaim)\nIf the provisioner or an external controller can support the specified data source,\nit will create a new volume based on the contents of the specified data source.\nWhen the AnyVolumeDataSource feature gate is enabled, dataSource contents will be copied to dataSourceRef,\nand dataSourceRef contents will be copied to dataSource when dataSourceRef.namespace is not specified.\nIf the namespace is specified, then dataSourceRef will not be copied to dataSource.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateSpecDataSourceModule
        );
        default = null;
      };
      "dataSourceRef" = mkOption {
        description = "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty\nvolume is desired. This may be any object from a non-empty API group (non\ncore object) or a PersistentVolumeClaim object.\nWhen this field is specified, volume binding will only succeed if the type of\nthe specified object matches some installed volume populator or dynamic\nprovisioner.\nThis field will replace the functionality of the dataSource field and as such\nif both fields are non-empty, they must have the same value. For backwards\ncompatibility, when namespace isn't specified in dataSourceRef,\nboth fields (dataSource and dataSourceRef) will be set to the same\nvalue automatically if one of them is empty and the other is non-empty.\nWhen namespace is specified in dataSourceRef,\ndataSource isn't set to the same value and must be empty.\nThere are three important differences between dataSource and dataSourceRef:\n* While dataSource only allows two specific types of objects, dataSourceRef\n  allows any non-core object, as well as PersistentVolumeClaim objects.\n* While dataSource ignores disallowed values (dropping them), dataSourceRef\n  preserves all values, and generates an error if a disallowed value is\n  specified.\n* While dataSource only allows local objects, dataSourceRef allows objects\n  in any namespaces.\n(Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled.\n(Alpha) Using the namespace field of dataSourceRef requires the CrossNamespaceVolumeDataSource feature gate to be enabled.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateSpecDataSourceRefModule
        );
        default = null;
      };
      "resources" = mkOption {
        description = "resources represents the minimum resources the volume should have.\nIf RecoverVolumeExpansionFailure feature is enabled users are allowed to specify resource requirements\nthat are lower than previous value but must still be higher than capacity recorded in the\nstatus field of the claim.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources";
        type = (
          types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateSpecResourcesModule
        );
        default = null;
      };
      "selector" = mkOption {
        description = "selector is a label query over volumes to consider for binding.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateSpecSelectorModule
        );
        default = null;
      };
      "storageClassName" = mkOption {
        description = "storageClassName is the name of the StorageClass required by the claim.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeAttributesClassName" = mkOption {
        description = "volumeAttributesClassName may be used to set the VolumeAttributesClass used by this claim.\nIf specified, the CSI driver will create or update the volume with the attributes defined\nin the corresponding VolumeAttributesClass. This has a different purpose than storageClassName,\nit can be changed after the claim is created. An empty string value means that no VolumeAttributesClass\nwill be applied to the claim but it's not allowed to reset this field to empty string once it is set.\nIf unspecified and the PersistentVolumeClaim is unbound, the default VolumeAttributesClass\nwill be set by the persistentvolume controller if it exists.\nIf the resource referred to by volumeAttributesClass does not exist, this PersistentVolumeClaim will be\nset to a Pending state, as reflected by the modifyVolumeStatus field, until such as a resource\nexists.\nMore info: https://kubernetes.io/docs/concepts/storage/volume-attributes-classes/\n(Beta) Using this field requires the VolumeAttributesClass feature gate to be enabled (off by default).";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeMode" = mkOption {
        description = "volumeMode defines what type of volume is required by the claim.\nValue of Filesystem is implied when not included in claim spec.";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeName" = mkOption {
        description = "volumeName is the binding reference to the PersistentVolume backing this claim.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateSpec =
    res:
    {
    }
    // optionalAttrs (res."accessModes" != [ ]) { inherit (res) "accessModes"; }
    // {
    }
    // optionalAttrs (res."dataSource" != null) {
      "dataSource" =
        mkProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateSpecDataSource
          res."dataSource";
    }
    // {
    }
    // optionalAttrs (res."dataSourceRef" != null) {
      "dataSourceRef" =
        mkProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateSpecDataSourceRef
          res."dataSourceRef";
    }
    // {
    }
    // optionalAttrs (res."resources" != null) {
      "resources" =
        mkProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateSpecResources
          res."resources";
    }
    // {
    }
    // optionalAttrs (res."selector" != null) {
      "selector" =
        mkProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateSpecSelector
          res."selector";
    }
    // {
    }
    // optionalAttrs (res."storageClassName" != null) { inherit (res) "storageClassName"; }
    // {
    }
    // optionalAttrs (res."volumeAttributesClassName" != null) {
      inherit (res) "volumeAttributesClassName";
    }
    // {
    }
    // optionalAttrs (res."volumeMode" != null) { inherit (res) "volumeMode"; }
    // {
    }
    // optionalAttrs (res."volumeName" != null) { inherit (res) "volumeName"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateSpecResourcesModule =
    types.submodule
      {
        options = {
          "limits" = mkOption {
            description = "Limits describes the maximum amount of compute resources allowed.\nMore info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
            type = (types.attrsOf types.anything);
            default = { };
          };
          "requests" = mkOption {
            description = "Requests describes the minimum amount of compute resources required.\nIf Requests is omitted for a container, it defaults to Limits if that is explicitly specified,\notherwise to an implementation-defined value. Requests cannot exceed Limits.\nMore info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
            type = (types.attrsOf types.anything);
            default = { };
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateSpecResources =
    res:
    {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateSpecSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateSpecSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateSpecSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateSpecSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateSpecSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralVolumeClaimTemplateSpecSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeFcModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is the filesystem type to mount.\nMust be a filesystem type supported by the host operating system.\nEx. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.";
        type = (types.nullOr types.str);
        default = null;
      };
      "lun" = mkOption {
        description = "lun is Optional: FC target lun number";
        type = (types.nullOr types.int);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly is Optional: Defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.";
        type = types.bool;
        default = false;
      };
      "targetWWNs" = mkOption {
        description = "targetWWNs is Optional: FC target worldwide names (WWNs)";
        type = (types.listOf types.str);
        default = [ ];
      };
      "wwids" = mkOption {
        description = "wwids Optional: FC volume world wide identifiers (wwids)\nEither wwids or combination of targetWWNs and lun must be set, but not both simultaneously.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeFc =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."lun" != null) { inherit (res) "lun"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."targetWWNs" != [ ]) { inherit (res) "targetWWNs"; }
    // {
    }
    // optionalAttrs (res."wwids" != [ ]) { inherit (res) "wwids"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeFlexVolumeModule = types.submodule {
    options = {
      "driver" = mkOption {
        description = "driver is the name of the driver to use for this volume.";
        type = types.str;
      };
      "fsType" = mkOption {
        description = "fsType is the filesystem type to mount.\nMust be a filesystem type supported by the host operating system.\nEx. \"ext4\", \"xfs\", \"ntfs\". The default filesystem depends on FlexVolume script.";
        type = (types.nullOr types.str);
        default = null;
      };
      "options" = mkOption {
        description = "options is Optional: this field holds extra command options if any.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "readOnly" = mkOption {
        description = "readOnly is Optional: defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.";
        type = types.bool;
        default = false;
      };
      "secretRef" = mkOption {
        description = "secretRef is Optional: secretRef is reference to the secret object containing\nsensitive information to pass to the plugin scripts. This may be\nempty if no secret object is specified. If the secret object\ncontains more than one secret, all secrets are passed to the plugin\nscripts.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeFlexVolumeSecretRefModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeFlexVolume =
    res:
    {
      inherit (res) "driver";
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."options" != { }) { inherit (res) "options"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderKubernetesEnvoyDaemonSetPodVolumeFlexVolumeSecretRef res."secretRef";
    }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeFlexVolumeSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeFlexVolumeSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeFlockerModule = types.submodule {
    options = {
      "datasetName" = mkOption {
        description = "datasetName is Name of the dataset stored as metadata -> name on the dataset for Flocker\nshould be considered as deprecated";
        type = (types.nullOr types.str);
        default = null;
      };
      "datasetUUID" = mkOption {
        description = "datasetUUID is the UUID of the dataset. This is unique identifier of a Flocker dataset";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeFlocker =
    res:
    {
    }
    // optionalAttrs (res."datasetName" != null) { inherit (res) "datasetName"; }
    // {
    }
    // optionalAttrs (res."datasetUUID" != null) { inherit (res) "datasetUUID"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeGcePersistentDiskModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is filesystem type of the volume that you want to mount.\nTip: Ensure that the filesystem type is supported by the host operating system.\nExamples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk";
        type = (types.nullOr types.str);
        default = null;
      };
      "partition" = mkOption {
        description = "partition is the partition in the volume that you want to mount.\nIf omitted, the default is to mount by volume name.\nExamples: For volume /dev/sda1, you specify the partition as \"1\".\nSimilarly, the volume partition for /dev/sda is \"0\" (or you can leave the property empty).\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk";
        type = (types.nullOr types.int);
        default = null;
      };
      "pdName" = mkOption {
        description = "pdName is unique name of the PD resource in GCE. Used to identify the disk in GCE.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk";
        type = types.str;
      };
      "readOnly" = mkOption {
        description = "readOnly here will force the ReadOnly setting in VolumeMounts.\nDefaults to false.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeGcePersistentDisk =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."partition" != null) { inherit (res) "partition"; }
    // {
      inherit (res) "pdName";
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeGitRepoModule = types.submodule {
    options = {
      "directory" = mkOption {
        description = "directory is the target directory name.\nMust not contain or start with '..'.  If '.' is supplied, the volume directory will be the\ngit repository.  Otherwise, if specified, the volume will contain the git repository in\nthe subdirectory with the given name.";
        type = (types.nullOr types.str);
        default = null;
      };
      "repository" = mkOption {
        description = "repository is the URL";
        type = types.str;
      };
      "revision" = mkOption {
        description = "revision is the commit hash for the specified revision.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeGitRepo =
    res:
    {
    }
    // optionalAttrs (res."directory" != null) { inherit (res) "directory"; }
    // {
      inherit (res) "repository";
    }
    // optionalAttrs (res."revision" != null) { inherit (res) "revision"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeGlusterfsModule = types.submodule {
    options = {
      "endpoints" = mkOption {
        description = "endpoints is the endpoint name that details Glusterfs topology.\nMore info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod";
        type = types.str;
      };
      "path" = mkOption {
        description = "path is the Glusterfs volume path.\nMore info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod";
        type = types.str;
      };
      "readOnly" = mkOption {
        description = "readOnly here will force the Glusterfs volume to be mounted with read-only permissions.\nDefaults to false.\nMore info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeGlusterfs =
    res:
    {
      inherit (res) "endpoints";
      inherit (res) "path";
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeHostPathModule = types.submodule {
    options = {
      "path" = mkOption {
        description = "path of the directory on the host.\nIf the path is a symlink, it will follow the link to the real path.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath";
        type = types.str;
      };
      "type" = mkOption {
        description = "type for HostPath Volume\nDefaults to \"\"\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeHostPath =
    res:
    {
      inherit (res) "path";
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeImageModule = types.submodule {
    options = {
      "pullPolicy" = mkOption {
        description = "Policy for pulling OCI objects. Possible values are:\nAlways: the kubelet always attempts to pull the reference. Container creation will fail If the pull fails.\nNever: the kubelet never pulls the reference and only uses a local image or artifact. Container creation will fail if the reference isn't present.\nIfNotPresent: the kubelet pulls if the reference isn't already present on disk. Container creation will fail if the reference isn't present and the pull fails.\nDefaults to Always if :latest tag is specified, or IfNotPresent otherwise.";
        type = (types.nullOr types.str);
        default = null;
      };
      "reference" = mkOption {
        description = "Required: Image or artifact reference to be used.\nBehaves in the same way as pod.spec.containers[*].image.\nPull secrets will be assembled in the same way as for the container image by looking up node credentials, SA image pull secrets, and pod spec image pull secrets.\nMore info: https://kubernetes.io/docs/concepts/containers/images\nThis field is optional to allow higher level config management to default or override\ncontainer images in workload controllers like Deployments and StatefulSets.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeImage =
    res:
    {
    }
    // optionalAttrs (res."pullPolicy" != null) { inherit (res) "pullPolicy"; }
    // {
    }
    // optionalAttrs (res."reference" != null) { inherit (res) "reference"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeIscsiModule = types.submodule {
    options = {
      "chapAuthDiscovery" = mkOption {
        description = "chapAuthDiscovery defines whether support iSCSI Discovery CHAP authentication";
        type = types.bool;
        default = false;
      };
      "chapAuthSession" = mkOption {
        description = "chapAuthSession defines whether support iSCSI Session CHAP authentication";
        type = types.bool;
        default = false;
      };
      "fsType" = mkOption {
        description = "fsType is the filesystem type of the volume that you want to mount.\nTip: Ensure that the filesystem type is supported by the host operating system.\nExamples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#iscsi";
        type = (types.nullOr types.str);
        default = null;
      };
      "initiatorName" = mkOption {
        description = "initiatorName is the custom iSCSI Initiator Name.\nIf initiatorName is specified with iscsiInterface simultaneously, new iSCSI interface\n<target portal>:<volume name> will be created for the connection.";
        type = (types.nullOr types.str);
        default = null;
      };
      "iqn" = mkOption {
        description = "iqn is the target iSCSI Qualified Name.";
        type = types.str;
      };
      "iscsiInterface" = mkOption {
        description = "iscsiInterface is the interface Name that uses an iSCSI transport.\nDefaults to 'default' (tcp).";
        type = (types.nullOr types.str);
        default = "default";
      };
      "lun" = mkOption {
        description = "lun represents iSCSI Target Lun number.";
        type = types.int;
      };
      "portals" = mkOption {
        description = "portals is the iSCSI Target Portal List. The portal is either an IP or ip_addr:port if the port\nis other than default (typically TCP ports 860 and 3260).";
        type = (types.listOf types.str);
        default = [ ];
      };
      "readOnly" = mkOption {
        description = "readOnly here will force the ReadOnly setting in VolumeMounts.\nDefaults to false.";
        type = types.bool;
        default = false;
      };
      "secretRef" = mkOption {
        description = "secretRef is the CHAP Secret for iSCSI target and initiator authentication";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeIscsiSecretRefModule);
        default = null;
      };
      "targetPortal" = mkOption {
        description = "targetPortal is iSCSI Target Portal. The Portal is either an IP or ip_addr:port if the port\nis other than default (typically TCP ports 860 and 3260).";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeIscsi =
    res:
    {
    }
    // optionalAttrs res."chapAuthDiscovery" { inherit (res) "chapAuthDiscovery"; }
    // {
    }
    // optionalAttrs res."chapAuthSession" { inherit (res) "chapAuthSession"; }
    // {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."initiatorName" != null) { inherit (res) "initiatorName"; }
    // {
      inherit (res) "iqn";
    }
    // optionalAttrs (res."iscsiInterface" != null) { inherit (res) "iscsiInterface"; }
    // {
      inherit (res) "lun";
    }
    // optionalAttrs (res."portals" != [ ]) { inherit (res) "portals"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderKubernetesEnvoyDaemonSetPodVolumeIscsiSecretRef res."secretRef";
    }
    // {
      inherit (res) "targetPortal";
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeIscsiSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeIscsiSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeModule = types.submodule {
    options = {
      "awsElasticBlockStore" = mkOption {
        description = "awsElasticBlockStore represents an AWS Disk resource that is attached to a\nkubelet's host machine and then exposed to the pod.\nDeprecated: AWSElasticBlockStore is deprecated. All operations for the in-tree\nawsElasticBlockStore type are redirected to the ebs.csi.aws.com CSI driver.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeAwsElasticBlockStoreModule);
        default = null;
      };
      "azureDisk" = mkOption {
        description = "azureDisk represents an Azure Data Disk mount on the host and bind mount to the pod.\nDeprecated: AzureDisk is deprecated. All operations for the in-tree azureDisk type\nare redirected to the disk.csi.azure.com CSI driver.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeAzureDiskModule);
        default = null;
      };
      "azureFile" = mkOption {
        description = "azureFile represents an Azure File Service mount on the host and bind mount to the pod.\nDeprecated: AzureFile is deprecated. All operations for the in-tree azureFile type\nare redirected to the file.csi.azure.com CSI driver.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeAzureFileModule);
        default = null;
      };
      "cephfs" = mkOption {
        description = "cephFS represents a Ceph FS mount on the host that shares a pod's lifetime.\nDeprecated: CephFS is deprecated and the in-tree cephfs type is no longer supported.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeCephfsModule);
        default = null;
      };
      "cinder" = mkOption {
        description = "cinder represents a cinder volume attached and mounted on kubelets host machine.\nDeprecated: Cinder is deprecated. All operations for the in-tree cinder type\nare redirected to the cinder.csi.openstack.org CSI driver.\nMore info: https://examples.k8s.io/mysql-cinder-pd/README.md";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeCinderModule);
        default = null;
      };
      "configMap" = mkOption {
        description = "configMap represents a configMap that should populate this volume";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeConfigMapModule);
        default = null;
      };
      "csi" = mkOption {
        description = "csi (Container Storage Interface) represents ephemeral storage that is handled by certain external CSI drivers.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeCsiModule);
        default = null;
      };
      "downwardAPI" = mkOption {
        description = "downwardAPI represents downward API about the pod that should populate this volume";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeDownwardAPIModule);
        default = null;
      };
      "emptyDir" = mkOption {
        description = "emptyDir represents a temporary directory that shares a pod's lifetime.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeEmptyDirModule);
        default = null;
      };
      "ephemeral" = mkOption {
        description = "ephemeral represents a volume that is handled by a cluster storage driver.\nThe volume's lifecycle is tied to the pod that defines it - it will be created before the pod starts,\nand deleted when the pod is removed.\n\nUse this if:\na) the volume is only needed while the pod runs,\nb) features of normal volumes like restoring from snapshot or capacity\n   tracking are needed,\nc) the storage driver is specified through a storage class, and\nd) the storage driver supports dynamic volume provisioning through\n   a PersistentVolumeClaim (see EphemeralVolumeSource for more\n   information on the connection between this volume type\n   and PersistentVolumeClaim).\n\nUse PersistentVolumeClaim or one of the vendor-specific\nAPIs for volumes that persist for longer than the lifecycle\nof an individual pod.\n\nUse CSI for light-weight local ephemeral volumes if the CSI driver is meant to\nbe used that way - see the documentation of the driver for\nmore information.\n\nA pod can use both types of ephemeral volumes and\npersistent volumes at the same time.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeEphemeralModule);
        default = null;
      };
      "fc" = mkOption {
        description = "fc represents a Fibre Channel resource that is attached to a kubelet's host machine and then exposed to the pod.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeFcModule);
        default = null;
      };
      "flexVolume" = mkOption {
        description = "flexVolume represents a generic volume resource that is\nprovisioned/attached using an exec based plugin.\nDeprecated: FlexVolume is deprecated. Consider using a CSIDriver instead.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeFlexVolumeModule);
        default = null;
      };
      "flocker" = mkOption {
        description = "flocker represents a Flocker volume attached to a kubelet's host machine. This depends on the Flocker control service being running.\nDeprecated: Flocker is deprecated and the in-tree flocker type is no longer supported.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeFlockerModule);
        default = null;
      };
      "gcePersistentDisk" = mkOption {
        description = "gcePersistentDisk represents a GCE Disk resource that is attached to a\nkubelet's host machine and then exposed to the pod.\nDeprecated: GCEPersistentDisk is deprecated. All operations for the in-tree\ngcePersistentDisk type are redirected to the pd.csi.storage.gke.io CSI driver.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeGcePersistentDiskModule);
        default = null;
      };
      "gitRepo" = mkOption {
        description = "gitRepo represents a git repository at a particular revision.\nDeprecated: GitRepo is deprecated. To provision a container with a git repo, mount an\nEmptyDir into an InitContainer that clones the repo using git, then mount the EmptyDir\ninto the Pod's container.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeGitRepoModule);
        default = null;
      };
      "glusterfs" = mkOption {
        description = "glusterfs represents a Glusterfs mount on the host that shares a pod's lifetime.\nDeprecated: Glusterfs is deprecated and the in-tree glusterfs type is no longer supported.\nMore info: https://examples.k8s.io/volumes/glusterfs/README.md";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeGlusterfsModule);
        default = null;
      };
      "hostPath" = mkOption {
        description = "hostPath represents a pre-existing file or directory on the host\nmachine that is directly exposed to the container. This is generally\nused for system agents or other privileged things that are allowed\nto see the host machine. Most containers will NOT need this.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeHostPathModule);
        default = null;
      };
      "image" = mkOption {
        description = "image represents an OCI object (a container image or artifact) pulled and mounted on the kubelet's host machine.\nThe volume is resolved at pod startup depending on which PullPolicy value is provided:\n\n- Always: the kubelet always attempts to pull the reference. Container creation will fail If the pull fails.\n- Never: the kubelet never pulls the reference and only uses a local image or artifact. Container creation will fail if the reference isn't present.\n- IfNotPresent: the kubelet pulls if the reference isn't already present on disk. Container creation will fail if the reference isn't present and the pull fails.\n\nThe volume gets re-resolved if the pod gets deleted and recreated, which means that new remote content will become available on pod recreation.\nA failure to resolve or pull the image during pod startup will block containers from starting and may add significant latency. Failures will be retried using normal volume backoff and will be reported on the pod reason and message.\nThe types of objects that may be mounted by this volume are defined by the container runtime implementation on a host machine and at minimum must include all valid types supported by the container image field.\nThe OCI object gets mounted in a single directory (spec.containers[*].volumeMounts.mountPath) by merging the manifest layers in the same way as for container images.\nThe volume will be mounted read-only (ro) and non-executable files (noexec).\nSub path mounts for containers are not supported (spec.containers[*].volumeMounts.subpath) before 1.33.\nThe field spec.securityContext.fsGroupChangePolicy has no effect on this volume type.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeImageModule);
        default = null;
      };
      "iscsi" = mkOption {
        description = "iscsi represents an ISCSI Disk resource that is attached to a\nkubelet's host machine and then exposed to the pod.\nMore info: https://examples.k8s.io/volumes/iscsi/README.md";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeIscsiModule);
        default = null;
      };
      "name" = mkOption {
        description = "name of the volume.\nMust be a DNS_LABEL and unique within the pod.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = types.str;
      };
      "nfs" = mkOption {
        description = "nfs represents an NFS mount on the host that shares a pod's lifetime\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#nfs";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeNfsModule);
        default = null;
      };
      "persistentVolumeClaim" = mkOption {
        description = "persistentVolumeClaimVolumeSource represents a reference to a\nPersistentVolumeClaim in the same namespace.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumePersistentVolumeClaimModule);
        default = null;
      };
      "photonPersistentDisk" = mkOption {
        description = "photonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine.\nDeprecated: PhotonPersistentDisk is deprecated and the in-tree photonPersistentDisk type is no longer supported.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumePhotonPersistentDiskModule);
        default = null;
      };
      "portworxVolume" = mkOption {
        description = "portworxVolume represents a portworx volume attached and mounted on kubelets host machine.\nDeprecated: PortworxVolume is deprecated. All operations for the in-tree portworxVolume type\nare redirected to the pxd.portworx.com CSI driver when the CSIMigrationPortworx feature-gate\nis on.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumePortworxVolumeModule);
        default = null;
      };
      "projected" = mkOption {
        description = "projected items for all in one resources secrets, configmaps, and downward API";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedModule);
        default = null;
      };
      "quobyte" = mkOption {
        description = "quobyte represents a Quobyte mount on the host that shares a pod's lifetime.\nDeprecated: Quobyte is deprecated and the in-tree quobyte type is no longer supported.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeQuobyteModule);
        default = null;
      };
      "rbd" = mkOption {
        description = "rbd represents a Rados Block Device mount on the host that shares a pod's lifetime.\nDeprecated: RBD is deprecated and the in-tree rbd type is no longer supported.\nMore info: https://examples.k8s.io/volumes/rbd/README.md";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeRbdModule);
        default = null;
      };
      "scaleIO" = mkOption {
        description = "scaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes.\nDeprecated: ScaleIO is deprecated and the in-tree scaleIO type is no longer supported.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeScaleIOModule);
        default = null;
      };
      "secret" = mkOption {
        description = "secret represents a secret that should populate this volume.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#secret";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeSecretModule);
        default = null;
      };
      "storageos" = mkOption {
        description = "storageOS represents a StorageOS volume attached and mounted on Kubernetes nodes.\nDeprecated: StorageOS is deprecated and the in-tree storageos type is no longer supported.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeStorageosModule);
        default = null;
      };
      "vsphereVolume" = mkOption {
        description = "vsphereVolume represents a vSphere volume attached and mounted on kubelets host machine.\nDeprecated: VsphereVolume is deprecated. All operations for the in-tree vsphereVolume type\nare redirected to the csi.vsphere.vmware.com CSI driver.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeVsphereVolumeModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolume =
    res:
    {
    }
    // optionalAttrs (res."awsElasticBlockStore" != null) {
      "awsElasticBlockStore" =
        mkProviderKubernetesEnvoyDaemonSetPodVolumeAwsElasticBlockStore
          res."awsElasticBlockStore";
    }
    // {
    }
    // optionalAttrs (res."azureDisk" != null) {
      "azureDisk" = mkProviderKubernetesEnvoyDaemonSetPodVolumeAzureDisk res."azureDisk";
    }
    // {
    }
    // optionalAttrs (res."azureFile" != null) {
      "azureFile" = mkProviderKubernetesEnvoyDaemonSetPodVolumeAzureFile res."azureFile";
    }
    // {
    }
    // optionalAttrs (res."cephfs" != null) {
      "cephfs" = mkProviderKubernetesEnvoyDaemonSetPodVolumeCephfs res."cephfs";
    }
    // {
    }
    // optionalAttrs (res."cinder" != null) {
      "cinder" = mkProviderKubernetesEnvoyDaemonSetPodVolumeCinder res."cinder";
    }
    // {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkProviderKubernetesEnvoyDaemonSetPodVolumeConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."csi" != null) {
      "csi" = mkProviderKubernetesEnvoyDaemonSetPodVolumeCsi res."csi";
    }
    // {
    }
    // optionalAttrs (res."downwardAPI" != null) {
      "downwardAPI" = mkProviderKubernetesEnvoyDaemonSetPodVolumeDownwardAPI res."downwardAPI";
    }
    // {
    }
    // optionalAttrs (res."emptyDir" != null) {
      "emptyDir" = mkProviderKubernetesEnvoyDaemonSetPodVolumeEmptyDir res."emptyDir";
    }
    // {
    }
    // optionalAttrs (res."ephemeral" != null) {
      "ephemeral" = mkProviderKubernetesEnvoyDaemonSetPodVolumeEphemeral res."ephemeral";
    }
    // {
    }
    // optionalAttrs (res."fc" != null) {
      "fc" = mkProviderKubernetesEnvoyDaemonSetPodVolumeFc res."fc";
    }
    // {
    }
    // optionalAttrs (res."flexVolume" != null) {
      "flexVolume" = mkProviderKubernetesEnvoyDaemonSetPodVolumeFlexVolume res."flexVolume";
    }
    // {
    }
    // optionalAttrs (res."flocker" != null) {
      "flocker" = mkProviderKubernetesEnvoyDaemonSetPodVolumeFlocker res."flocker";
    }
    // {
    }
    // optionalAttrs (res."gcePersistentDisk" != null) {
      "gcePersistentDisk" =
        mkProviderKubernetesEnvoyDaemonSetPodVolumeGcePersistentDisk
          res."gcePersistentDisk";
    }
    // {
    }
    // optionalAttrs (res."gitRepo" != null) {
      "gitRepo" = mkProviderKubernetesEnvoyDaemonSetPodVolumeGitRepo res."gitRepo";
    }
    // {
    }
    // optionalAttrs (res."glusterfs" != null) {
      "glusterfs" = mkProviderKubernetesEnvoyDaemonSetPodVolumeGlusterfs res."glusterfs";
    }
    // {
    }
    // optionalAttrs (res."hostPath" != null) {
      "hostPath" = mkProviderKubernetesEnvoyDaemonSetPodVolumeHostPath res."hostPath";
    }
    // {
    }
    // optionalAttrs (res."image" != null) {
      "image" = mkProviderKubernetesEnvoyDaemonSetPodVolumeImage res."image";
    }
    // {
    }
    // optionalAttrs (res."iscsi" != null) {
      "iscsi" = mkProviderKubernetesEnvoyDaemonSetPodVolumeIscsi res."iscsi";
    }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."nfs" != null) {
      "nfs" = mkProviderKubernetesEnvoyDaemonSetPodVolumeNfs res."nfs";
    }
    // {
    }
    // optionalAttrs (res."persistentVolumeClaim" != null) {
      "persistentVolumeClaim" =
        mkProviderKubernetesEnvoyDaemonSetPodVolumePersistentVolumeClaim
          res."persistentVolumeClaim";
    }
    // {
    }
    // optionalAttrs (res."photonPersistentDisk" != null) {
      "photonPersistentDisk" =
        mkProviderKubernetesEnvoyDaemonSetPodVolumePhotonPersistentDisk
          res."photonPersistentDisk";
    }
    // {
    }
    // optionalAttrs (res."portworxVolume" != null) {
      "portworxVolume" = mkProviderKubernetesEnvoyDaemonSetPodVolumePortworxVolume res."portworxVolume";
    }
    // {
    }
    // optionalAttrs (res."projected" != null) {
      "projected" = mkProviderKubernetesEnvoyDaemonSetPodVolumeProjected res."projected";
    }
    // {
    }
    // optionalAttrs (res."quobyte" != null) {
      "quobyte" = mkProviderKubernetesEnvoyDaemonSetPodVolumeQuobyte res."quobyte";
    }
    // {
    }
    // optionalAttrs (res."rbd" != null) {
      "rbd" = mkProviderKubernetesEnvoyDaemonSetPodVolumeRbd res."rbd";
    }
    // {
    }
    // optionalAttrs (res."scaleIO" != null) {
      "scaleIO" = mkProviderKubernetesEnvoyDaemonSetPodVolumeScaleIO res."scaleIO";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkProviderKubernetesEnvoyDaemonSetPodVolumeSecret res."secret";
    }
    // {
    }
    // optionalAttrs (res."storageos" != null) {
      "storageos" = mkProviderKubernetesEnvoyDaemonSetPodVolumeStorageos res."storageos";
    }
    // {
    }
    // optionalAttrs (res."vsphereVolume" != null) {
      "vsphereVolume" = mkProviderKubernetesEnvoyDaemonSetPodVolumeVsphereVolume res."vsphereVolume";
    }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeNfsModule = types.submodule {
    options = {
      "path" = mkOption {
        description = "path that is exported by the NFS server.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#nfs";
        type = types.str;
      };
      "readOnly" = mkOption {
        description = "readOnly here will force the NFS export to be mounted with read-only permissions.\nDefaults to false.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#nfs";
        type = types.bool;
        default = false;
      };
      "server" = mkOption {
        description = "server is the hostname or IP address of the NFS server.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#nfs";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeNfs =
    res:
    {
      inherit (res) "path";
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
      inherit (res) "server";
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumePersistentVolumeClaimModule = types.submodule {
    options = {
      "claimName" = mkOption {
        description = "claimName is the name of a PersistentVolumeClaim in the same namespace as the pod using this volume.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims";
        type = types.str;
      };
      "readOnly" = mkOption {
        description = "readOnly Will force the ReadOnly setting in VolumeMounts.\nDefault false.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumePersistentVolumeClaim =
    res:
    {
      inherit (res) "claimName";
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumePhotonPersistentDiskModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is the filesystem type to mount.\nMust be a filesystem type supported by the host operating system.\nEx. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.";
        type = (types.nullOr types.str);
        default = null;
      };
      "pdID" = mkOption {
        description = "pdID is the ID that identifies Photon Controller persistent disk";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumePhotonPersistentDisk =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
      inherit (res) "pdID";
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumePortworxVolumeModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fSType represents the filesystem type to mount\nMust be a filesystem type supported by the host operating system.\nEx. \"ext4\", \"xfs\". Implicitly inferred to be \"ext4\" if unspecified.";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.";
        type = types.bool;
        default = false;
      };
      "volumeID" = mkOption {
        description = "volumeID uniquely identifies a Portworx volume";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumePortworxVolume =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
      inherit (res) "volumeID";
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedModule = types.submodule {
    options = {
      "defaultMode" = mkOption {
        description = "defaultMode are the mode bits used to set permissions on created files by default.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nDirectories within the path are not affected by this setting.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "sources" = mkOption {
        description = "sources is the list of volume projections. Each entry in this list\nhandles one source.";
        type = (types.listOf ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceModule);
        default = [ ];
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeProjected =
    res:
    {
    }
    // optionalAttrs (res."defaultMode" != null) { inherit (res) "defaultMode"; }
    // {
    }
    // optionalAttrs (res."sources" != [ ]) {
      "sources" = map mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSource res."sources";
    }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceClusterTrustBundleLabelSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceClusterTrustBundleLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceClusterTrustBundleLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceClusterTrustBundleLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceClusterTrustBundleLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceClusterTrustBundleLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceClusterTrustBundleModule = types.submodule {
    options = {
      "labelSelector" = mkOption {
        description = "Select all ClusterTrustBundles that match this label selector.  Only has\neffect if signerName is set.  Mutually-exclusive with name.  If unset,\ninterpreted as \"match nothing\".  If set but empty, interpreted as \"match\neverything\".";
        type = (
          types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceClusterTrustBundleLabelSelectorModule
        );
        default = null;
      };
      "name" = mkOption {
        description = "Select a single ClusterTrustBundle by object name.  Mutually-exclusive\nwith signerName and labelSelector.";
        type = (types.nullOr types.str);
        default = null;
      };
      "optional" = mkOption {
        description = "If true, don't block pod startup if the referenced ClusterTrustBundle(s)\naren't available.  If using name, then the named ClusterTrustBundle is\nallowed not to exist.  If using signerName, then the combination of\nsignerName and labelSelector is allowed to match zero\nClusterTrustBundles.";
        type = types.bool;
        default = false;
      };
      "path" = mkOption {
        description = "Relative path from the volume root to write the bundle.";
        type = types.str;
      };
      "signerName" = mkOption {
        description = "Select all ClusterTrustBundles that match this signer name.\nMutually-exclusive with name.  The contents of all selected\nClusterTrustBundles will be unified and deduplicated.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceClusterTrustBundle =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceClusterTrustBundleLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
      inherit (res) "path";
    }
    // optionalAttrs (res."signerName" != null) { inherit (res) "signerName"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceConfigMapItemModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the key to project.";
        type = types.str;
      };
      "mode" = mkOption {
        description = "mode is Optional: mode bits used to set permissions on this file.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nIf not specified, the volume defaultMode will be used.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        description = "path is the relative path of the file to map the key to.\nMay not be an absolute path.\nMay not contain the path element '..'.\nMay not start with the string '..'.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceConfigMapItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceConfigMapModule = types.submodule {
    options = {
      "items" = mkOption {
        description = "items if unspecified, each key-value pair in the Data field of the referenced\nConfigMap will be projected into the volume as a file whose name is the\nkey and content is the value. If specified, the listed keys will be\nprojected into the specified paths, and unlisted keys will not be\npresent. If a key is specified which is not present in the ConfigMap,\nthe volume setup will error unless it is marked optional. Paths must be\nrelative and may not contain the '..' path or start with '..'.";
        type = (types.listOf ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceConfigMapItemModule);
        default = [ ];
      };
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "optional specify whether the ConfigMap or its keys must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceConfigMap =
    res:
    {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceConfigMapItem res."items";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceDownwardAPIItemFieldRefModule =
    types.submodule
      {
        options = {
          "apiVersion" = mkOption {
            description = "Version of the schema the FieldPath is written in terms of, defaults to \"v1\".";
            type = (types.nullOr types.str);
            default = null;
          };
          "fieldPath" = mkOption {
            description = "Path of the field to select in the specified API version.";
            type = types.str;
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceDownwardAPIItemFieldRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "fieldPath";
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceDownwardAPIItemModule = types.submodule {
    options = {
      "fieldRef" = mkOption {
        description = "Required: Selects a field of the pod: only annotations, labels, name, namespace and uid are supported.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceDownwardAPIItemFieldRefModule
        );
        default = null;
      };
      "mode" = mkOption {
        description = "Optional: mode bits used to set permissions on this file, must be an octal value\nbetween 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nIf not specified, the volume defaultMode will be used.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        description = "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'";
        type = types.str;
      };
      "resourceFieldRef" = mkOption {
        description = "Selects a resource of the container: only resources limits and requests\n(limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceDownwardAPIItemResourceFieldRefModule
        );
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceDownwardAPIItem =
    res:
    {
    }
    // optionalAttrs (res."fieldRef" != null) {
      "fieldRef" =
        mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceDownwardAPIItemFieldRef
          res."fieldRef";
    }
    // {
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    }
    // optionalAttrs (res."resourceFieldRef" != null) {
      "resourceFieldRef" =
        mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceDownwardAPIItemResourceFieldRef
          res."resourceFieldRef";
    }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceDownwardAPIItemResourceFieldRefModule =
    types.submodule
      {
        options = {
          "containerName" = mkOption {
            description = "Container name: required for volumes, optional for env vars";
            type = (types.nullOr types.str);
            default = null;
          };
          "divisor" = mkOption {
            description = "Specifies the output format of the exposed resources, defaults to \"1\"";
            type = types.anything;
            default = { };
          };
          "resource" = mkOption {
            description = "Required: resource to select";
            type = types.str;
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceDownwardAPIItemResourceFieldRef =
    res:
    {
    }
    // optionalAttrs (res."containerName" != null) { inherit (res) "containerName"; }
    // {
    }
    // optionalAttrs (res."divisor" != null) { inherit (res) "divisor"; }
    // {
      inherit (res) "resource";
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceDownwardAPIModule = types.submodule {
    options = {
      "items" = mkOption {
        description = "Items is a list of DownwardAPIVolume file";
        type = (types.listOf ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceDownwardAPIItemModule);
        default = [ ];
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceDownwardAPI =
    res:
    {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceDownwardAPIItem res."items";
    }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceModule = types.submodule {
    options = {
      "clusterTrustBundle" = mkOption {
        description = "ClusterTrustBundle allows a pod to access the `.spec.trustBundle` field\nof ClusterTrustBundle objects in an auto-updating file.\n\nAlpha, gated by the ClusterTrustBundleProjection feature gate.\n\nClusterTrustBundle objects can either be selected by name, or by the\ncombination of signer name and a label selector.\n\nKubelet performs aggressive normalization of the PEM contents written\ninto the pod filesystem.  Esoteric PEM features such as inter-block\ncomments and block headers are stripped.  Certificates are deduplicated.\nThe ordering of certificates within the file is arbitrary, and Kubelet\nmay change the order over time.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceClusterTrustBundleModule
        );
        default = null;
      };
      "configMap" = mkOption {
        description = "configMap information about the configMap data to project";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceConfigMapModule);
        default = null;
      };
      "downwardAPI" = mkOption {
        description = "downwardAPI information about the downwardAPI data to project";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceDownwardAPIModule);
        default = null;
      };
      "secret" = mkOption {
        description = "secret information about the secret data to project";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceSecretModule);
        default = null;
      };
      "serviceAccountToken" = mkOption {
        description = "serviceAccountToken is information about the serviceAccountToken data to project";
        type = (
          types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceServiceAccountTokenModule
        );
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSource =
    res:
    {
    }
    // optionalAttrs (res."clusterTrustBundle" != null) {
      "clusterTrustBundle" =
        mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceClusterTrustBundle
          res."clusterTrustBundle";
    }
    // {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."downwardAPI" != null) {
      "downwardAPI" =
        mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceDownwardAPI
          res."downwardAPI";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceSecret res."secret";
    }
    // {
    }
    // optionalAttrs (res."serviceAccountToken" != null) {
      "serviceAccountToken" =
        mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceServiceAccountToken
          res."serviceAccountToken";
    }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceSecretItemModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the key to project.";
        type = types.str;
      };
      "mode" = mkOption {
        description = "mode is Optional: mode bits used to set permissions on this file.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nIf not specified, the volume defaultMode will be used.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        description = "path is the relative path of the file to map the key to.\nMay not be an absolute path.\nMay not contain the path element '..'.\nMay not start with the string '..'.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceSecretItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceSecretModule = types.submodule {
    options = {
      "items" = mkOption {
        description = "items if unspecified, each key-value pair in the Data field of the referenced\nSecret will be projected into the volume as a file whose name is the\nkey and content is the value. If specified, the listed keys will be\nprojected into the specified paths, and unlisted keys will not be\npresent. If a key is specified which is not present in the Secret,\nthe volume setup will error unless it is marked optional. Paths must be\nrelative and may not contain the '..' path or start with '..'.";
        type = (types.listOf ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceSecretItemModule);
        default = [ ];
      };
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "optional field specify whether the Secret or its key must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceSecret =
    res:
    {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceSecretItem res."items";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceServiceAccountTokenModule =
    types.submodule
      {
        options = {
          "audience" = mkOption {
            description = "audience is the intended audience of the token. A recipient of a token\nmust identify itself with an identifier specified in the audience of the\ntoken, and otherwise should reject the token. The audience defaults to the\nidentifier of the apiserver.";
            type = (types.nullOr types.str);
            default = null;
          };
          "expirationSeconds" = mkOption {
            description = "expirationSeconds is the requested duration of validity of the service\naccount token. As the token approaches expiration, the kubelet volume\nplugin will proactively rotate the service account token. The kubelet will\nstart trying to rotate the token if the token is older than 80 percent of\nits time to live or if the token is older than 24 hours.Defaults to 1 hour\nand must be at least 10 minutes.";
            type = (types.nullOr types.int);
            default = null;
          };
          "path" = mkOption {
            description = "path is the path relative to the mount point of the file to project the\ntoken into.";
            type = types.str;
          };
        };
      };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeProjectedSourceServiceAccountToken =
    res:
    {
    }
    // optionalAttrs (res."audience" != null) { inherit (res) "audience"; }
    // {
    }
    // optionalAttrs (res."expirationSeconds" != null) { inherit (res) "expirationSeconds"; }
    // {
      inherit (res) "path";
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeQuobyteModule = types.submodule {
    options = {
      "group" = mkOption {
        description = "group to map volume access to\nDefault is no group";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly here will force the Quobyte volume to be mounted with read-only permissions.\nDefaults to false.";
        type = types.bool;
        default = false;
      };
      "registry" = mkOption {
        description = "registry represents a single or multiple Quobyte Registry services\nspecified as a string as host:port pair (multiple entries are separated with commas)\nwhich acts as the central registry for volumes";
        type = types.str;
      };
      "tenant" = mkOption {
        description = "tenant owning the given Quobyte volume in the Backend\nUsed with dynamically provisioned Quobyte volumes, value is set by the plugin";
        type = (types.nullOr types.str);
        default = null;
      };
      "user" = mkOption {
        description = "user to map volume access to\nDefaults to serivceaccount user";
        type = (types.nullOr types.str);
        default = null;
      };
      "volume" = mkOption {
        description = "volume is a string that references an already created Quobyte volume by name.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeQuobyte =
    res:
    {
    }
    // optionalAttrs (res."group" != null) { inherit (res) "group"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
      inherit (res) "registry";
    }
    // optionalAttrs (res."tenant" != null) { inherit (res) "tenant"; }
    // {
    }
    // optionalAttrs (res."user" != null) { inherit (res) "user"; }
    // {
      inherit (res) "volume";
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeRbdModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is the filesystem type of the volume that you want to mount.\nTip: Ensure that the filesystem type is supported by the host operating system.\nExamples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#rbd";
        type = (types.nullOr types.str);
        default = null;
      };
      "image" = mkOption {
        description = "image is the rados image name.\nMore info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it";
        type = types.str;
      };
      "keyring" = mkOption {
        description = "keyring is the path to key ring for RBDUser.\nDefault is /etc/ceph/keyring.\nMore info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it";
        type = (types.nullOr types.str);
        default = "/etc/ceph/keyring";
      };
      "monitors" = mkOption {
        description = "monitors is a collection of Ceph monitors.\nMore info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it";
        type = (types.listOf types.str);
      };
      "pool" = mkOption {
        description = "pool is the rados pool name.\nDefault is rbd.\nMore info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it";
        type = (types.nullOr types.str);
        default = "rbd";
      };
      "readOnly" = mkOption {
        description = "readOnly here will force the ReadOnly setting in VolumeMounts.\nDefaults to false.\nMore info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it";
        type = types.bool;
        default = false;
      };
      "secretRef" = mkOption {
        description = "secretRef is name of the authentication secret for RBDUser. If provided\noverrides keyring.\nDefault is nil.\nMore info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeRbdSecretRefModule);
        default = null;
      };
      "user" = mkOption {
        description = "user is the rados user name.\nDefault is admin.\nMore info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it";
        type = (types.nullOr types.str);
        default = "admin";
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeRbd =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
      inherit (res) "image";
    }
    // optionalAttrs (res."keyring" != null) { inherit (res) "keyring"; }
    // {
      inherit (res) "monitors";
    }
    // optionalAttrs (res."pool" != null) { inherit (res) "pool"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderKubernetesEnvoyDaemonSetPodVolumeRbdSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."user" != null) { inherit (res) "user"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeRbdSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeRbdSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeScaleIOModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is the filesystem type to mount.\nMust be a filesystem type supported by the host operating system.\nEx. \"ext4\", \"xfs\", \"ntfs\".\nDefault is \"xfs\".";
        type = (types.nullOr types.str);
        default = "xfs";
      };
      "gateway" = mkOption {
        description = "gateway is the host address of the ScaleIO API Gateway.";
        type = types.str;
      };
      "protectionDomain" = mkOption {
        description = "protectionDomain is the name of the ScaleIO Protection Domain for the configured storage.";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly Defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.";
        type = types.bool;
        default = false;
      };
      "secretRef" = mkOption {
        description = "secretRef references to the secret for ScaleIO user and other\nsensitive information. If this is not provided, Login operation will fail.";
        type = ProviderKubernetesEnvoyDaemonSetPodVolumeScaleIOSecretRefModule;
      };
      "sslEnabled" = mkOption {
        description = "sslEnabled Flag enable/disable SSL communication with Gateway, default false";
        type = types.bool;
        default = false;
      };
      "storageMode" = mkOption {
        description = "storageMode indicates whether the storage for a volume should be ThickProvisioned or ThinProvisioned.\nDefault is ThinProvisioned.";
        type = (types.nullOr types.str);
        default = "ThinProvisioned";
      };
      "storagePool" = mkOption {
        description = "storagePool is the ScaleIO Storage Pool associated with the protection domain.";
        type = (types.nullOr types.str);
        default = null;
      };
      "system" = mkOption {
        description = "system is the name of the storage system as configured in ScaleIO.";
        type = types.str;
      };
      "volumeName" = mkOption {
        description = "volumeName is the name of a volume already created in the ScaleIO system\nthat is associated with this volume source.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeScaleIO =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
      inherit (res) "gateway";
    }
    // optionalAttrs (res."protectionDomain" != null) { inherit (res) "protectionDomain"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
      "secretRef" = mkProviderKubernetesEnvoyDaemonSetPodVolumeScaleIOSecretRef res."secretRef";
    }
    // optionalAttrs res."sslEnabled" { inherit (res) "sslEnabled"; }
    // {
    }
    // optionalAttrs (res."storageMode" != null) { inherit (res) "storageMode"; }
    // {
    }
    // optionalAttrs (res."storagePool" != null) { inherit (res) "storagePool"; }
    // {
      inherit (res) "system";
    }
    // optionalAttrs (res."volumeName" != null) { inherit (res) "volumeName"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeScaleIOSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeScaleIOSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeSecretItemModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the key to project.";
        type = types.str;
      };
      "mode" = mkOption {
        description = "mode is Optional: mode bits used to set permissions on this file.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nIf not specified, the volume defaultMode will be used.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        description = "path is the relative path of the file to map the key to.\nMay not be an absolute path.\nMay not contain the path element '..'.\nMay not start with the string '..'.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeSecretItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeSecretModule = types.submodule {
    options = {
      "defaultMode" = mkOption {
        description = "defaultMode is Optional: mode bits used to set permissions on created files by default.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values\nfor mode bits. Defaults to 0644.\nDirectories within the path are not affected by this setting.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "items" = mkOption {
        description = "items If unspecified, each key-value pair in the Data field of the referenced\nSecret will be projected into the volume as a file whose name is the\nkey and content is the value. If specified, the listed keys will be\nprojected into the specified paths, and unlisted keys will not be\npresent. If a key is specified which is not present in the Secret,\nthe volume setup will error unless it is marked optional. Paths must be\nrelative and may not contain the '..' path or start with '..'.";
        type = (types.listOf ProviderKubernetesEnvoyDaemonSetPodVolumeSecretItemModule);
        default = [ ];
      };
      "optional" = mkOption {
        description = "optional field specify whether the Secret or its keys must be defined";
        type = types.bool;
        default = false;
      };
      "secretName" = mkOption {
        description = "secretName is the name of the secret in the pod's namespace to use.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#secret";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeSecret =
    res:
    {
    }
    // optionalAttrs (res."defaultMode" != null) { inherit (res) "defaultMode"; }
    // {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkProviderKubernetesEnvoyDaemonSetPodVolumeSecretItem res."items";
    }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    }
    // optionalAttrs (res."secretName" != null) { inherit (res) "secretName"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeStorageosModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is the filesystem type to mount.\nMust be a filesystem type supported by the host operating system.\nEx. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.";
        type = types.bool;
        default = false;
      };
      "secretRef" = mkOption {
        description = "secretRef specifies the secret to use for obtaining the StorageOS API\ncredentials.  If not specified, default values will be attempted.";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetPodVolumeStorageosSecretRefModule);
        default = null;
      };
      "volumeName" = mkOption {
        description = "volumeName is the human-readable name of the StorageOS volume.  Volume\nnames are only unique within a namespace.";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeNamespace" = mkOption {
        description = "volumeNamespace specifies the scope of the volume within StorageOS.  If no\nnamespace is specified then the Pod's namespace will be used.  This allows the\nKubernetes name scoping to be mirrored within StorageOS for tighter integration.\nSet VolumeName to any name to override the default behaviour.\nSet to \"default\" if you are not using namespaces within StorageOS.\nNamespaces that do not pre-exist within StorageOS will be created.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeStorageos =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderKubernetesEnvoyDaemonSetPodVolumeStorageosSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."volumeName" != null) { inherit (res) "volumeName"; }
    // {
    }
    // optionalAttrs (res."volumeNamespace" != null) { inherit (res) "volumeNamespace"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeStorageosSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeStorageosSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetPodVolumeVsphereVolumeModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is filesystem type to mount.\nMust be a filesystem type supported by the host operating system.\nEx. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.";
        type = (types.nullOr types.str);
        default = null;
      };
      "storagePolicyID" = mkOption {
        description = "storagePolicyID is the storage Policy Based Management (SPBM) profile ID associated with the StoragePolicyName.";
        type = (types.nullOr types.str);
        default = null;
      };
      "storagePolicyName" = mkOption {
        description = "storagePolicyName is the storage Policy Based Management (SPBM) profile name.";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumePath" = mkOption {
        description = "volumePath is the path that identifies vSphere volume vmdk";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetPodVolumeVsphereVolume =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."storagePolicyID" != null) { inherit (res) "storagePolicyID"; }
    // {
    }
    // optionalAttrs (res."storagePolicyName" != null) { inherit (res) "storagePolicyName"; }
    // {
      inherit (res) "volumePath";
    };
  ProviderKubernetesEnvoyDaemonSetStrategyModule = types.submodule {
    options = {
      "rollingUpdate" = mkOption {
        description = "Rolling update config params. Present only if type = \"RollingUpdate\".";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetStrategyRollingUpdateModule);
        default = null;
      };
      "type" = mkOption {
        description = "Type of daemon set update. Can be \"RollingUpdate\" or \"OnDelete\". Default is RollingUpdate.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetStrategy =
    res:
    {
    }
    // optionalAttrs (res."rollingUpdate" != null) {
      "rollingUpdate" = mkProviderKubernetesEnvoyDaemonSetStrategyRollingUpdate res."rollingUpdate";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ProviderKubernetesEnvoyDaemonSetStrategyRollingUpdateModule = types.submodule {
    options = {
      "maxSurge" = mkOption {
        description = "The maximum number of nodes with an existing available DaemonSet pod that\ncan have an updated DaemonSet pod during during an update.\nValue can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%).\nThis can not be 0 if MaxUnavailable is 0.\nAbsolute number is calculated from percentage by rounding up to a minimum of 1.\nDefault value is 0.\nExample: when this is set to 30%, at most 30% of the total number of nodes\nthat should be running the daemon pod (i.e. status.desiredNumberScheduled)\ncan have their a new pod created before the old pod is marked as deleted.\nThe update starts by launching new pods on 30% of nodes. Once an updated\npod is available (Ready for at least minReadySeconds) the old DaemonSet pod\non that node is marked deleted. If the old pod becomes unavailable for any\nreason (Ready transitions to false, is evicted, or is drained) an updated\npod is immediatedly created on that node without considering surge limits.\nAllowing surge implies the possibility that the resources consumed by the\ndaemonset on any given node can double if the readiness check fails, and\nso resource intensive daemonsets should take into account that they may\ncause evictions during disruption.";
        type = types.anything;
        default = { };
      };
      "maxUnavailable" = mkOption {
        description = "The maximum number of DaemonSet pods that can be unavailable during the\nupdate. Value can be an absolute number (ex: 5) or a percentage of total\nnumber of DaemonSet pods at the start of the update (ex: 10%). Absolute\nnumber is calculated from percentage by rounding up.\nThis cannot be 0 if MaxSurge is 0\nDefault value is 1.\nExample: when this is set to 30%, at most 30% of the total number of nodes\nthat should be running the daemon pod (i.e. status.desiredNumberScheduled)\ncan have their pods stopped for an update at any given time. The update\nstarts by stopping at most 30% of those DaemonSet pods and then brings\nup new DaemonSet pods in their place. Once the new pods are available,\nit then proceeds onto other DaemonSet pods, thus ensuring that at least\n70% of original number of DaemonSet pods are available at all times during\nthe update.";
        type = types.anything;
        default = { };
      };
    };
  };
  mkProviderKubernetesEnvoyDaemonSetStrategyRollingUpdate =
    res:
    {
    }
    // optionalAttrs (res."maxSurge" != null) { inherit (res) "maxSurge"; }
    // {
    }
    // optionalAttrs (res."maxUnavailable" != null) { inherit (res) "maxUnavailable"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentContainerEnvModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the environment variable. Must be a C_IDENTIFIER.";
        type = types.str;
      };
      "value" = mkOption {
        description = "Variable references $(VAR_NAME) are expanded\nusing the previously defined environment variables in the container and\nany service environment variables. If a variable cannot be resolved,\nthe reference in the input string will be unchanged. Double $$ are reduced\nto a single $, which allows for escaping the $(VAR_NAME) syntax: i.e.\n\"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\".\nEscaped references will never be expanded, regardless of whether the variable\nexists or not.\nDefaults to \"\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "valueFrom" = mkOption {
        description = "Source for the environment variable's value. Cannot be used if value is not empty.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentContainerEnvValueFromModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentContainerEnv =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    }
    // optionalAttrs (res."valueFrom" != null) {
      "valueFrom" = mkProviderKubernetesEnvoyDeploymentContainerEnvValueFrom res."valueFrom";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentContainerEnvValueFromConfigMapKeyRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select.";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "Specify whether the ConfigMap or its key must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentContainerEnvValueFromConfigMapKeyRef =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentContainerEnvValueFromFieldRefModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        description = "Version of the schema the FieldPath is written in terms of, defaults to \"v1\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "fieldPath" = mkOption {
        description = "Path of the field to select in the specified API version.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentContainerEnvValueFromFieldRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "fieldPath";
    };
  ProviderKubernetesEnvoyDeploymentContainerEnvValueFromModule = types.submodule {
    options = {
      "configMapKeyRef" = mkOption {
        description = "Selects a key of a ConfigMap.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentContainerEnvValueFromConfigMapKeyRefModule);
        default = null;
      };
      "fieldRef" = mkOption {
        description = "Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`,\nspec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentContainerEnvValueFromFieldRefModule);
        default = null;
      };
      "resourceFieldRef" = mkOption {
        description = "Selects a resource of the container: only resources limits and requests\n(limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentContainerEnvValueFromResourceFieldRefModule);
        default = null;
      };
      "secretKeyRef" = mkOption {
        description = "Selects a key of a secret in the pod's namespace";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentContainerEnvValueFromSecretKeyRefModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentContainerEnvValueFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapKeyRef" != null) {
      "configMapKeyRef" =
        mkProviderKubernetesEnvoyDeploymentContainerEnvValueFromConfigMapKeyRef
          res."configMapKeyRef";
    }
    // {
    }
    // optionalAttrs (res."fieldRef" != null) {
      "fieldRef" = mkProviderKubernetesEnvoyDeploymentContainerEnvValueFromFieldRef res."fieldRef";
    }
    // {
    }
    // optionalAttrs (res."resourceFieldRef" != null) {
      "resourceFieldRef" =
        mkProviderKubernetesEnvoyDeploymentContainerEnvValueFromResourceFieldRef
          res."resourceFieldRef";
    }
    // {
    }
    // optionalAttrs (res."secretKeyRef" != null) {
      "secretKeyRef" =
        mkProviderKubernetesEnvoyDeploymentContainerEnvValueFromSecretKeyRef
          res."secretKeyRef";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentContainerEnvValueFromResourceFieldRefModule = types.submodule {
    options = {
      "containerName" = mkOption {
        description = "Container name: required for volumes, optional for env vars";
        type = (types.nullOr types.str);
        default = null;
      };
      "divisor" = mkOption {
        description = "Specifies the output format of the exposed resources, defaults to \"1\"";
        type = types.anything;
        default = { };
      };
      "resource" = mkOption {
        description = "Required: resource to select";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentContainerEnvValueFromResourceFieldRef =
    res:
    {
    }
    // optionalAttrs (res."containerName" != null) { inherit (res) "containerName"; }
    // {
    }
    // optionalAttrs (res."divisor" != null) { inherit (res) "divisor"; }
    // {
      inherit (res) "resource";
    };
  ProviderKubernetesEnvoyDeploymentContainerEnvValueFromSecretKeyRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key of the secret to select from.  Must be a valid secret key.";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "Specify whether the Secret or its key must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentContainerEnvValueFromSecretKeyRef =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentContainerModule = types.submodule {
    options = {
      "env" = mkOption {
        description = "List of environment variables to set in the container.";
        type = (types.listOf ProviderKubernetesEnvoyDeploymentContainerEnvModule);
        default = [ ];
      };
      "image" = mkOption {
        description = "Image specifies the EnvoyProxy container image to be used including a tag, instead of the default image.\nThis field is mutually exclusive with ImageRepository.";
        type = (types.nullOr types.str);
        default = null;
      };
      "imageRepository" = mkOption {
        description = "ImageRepository specifies the container image repository to be used without specifying a tag.\nThe default tag will be used.\nThis field is mutually exclusive with Image.";
        type = (types.nullOr types.str);
        default = null;
      };
      "resources" = mkOption {
        description = "Resources required by this container.\nMore info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentContainerResourcesModule);
        default = null;
      };
      "securityContext" = mkOption {
        description = "SecurityContext defines the security options the container should be run with.\nIf set, the fields of SecurityContext override the equivalent fields of PodSecurityContext.\nMore info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentContainerSecurityContextModule);
        default = null;
      };
      "volumeMounts" = mkOption {
        description = "VolumeMounts are volumes to mount into the container's filesystem.\nCannot be updated.";
        type = (types.listOf ProviderKubernetesEnvoyDeploymentContainerVolumeMountModule);
        default = [ ];
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentContainer =
    res:
    {
    }
    // optionalAttrs (res."env" != [ ]) {
      "env" = map mkProviderKubernetesEnvoyDeploymentContainerEnv res."env";
    }
    // {
    }
    // optionalAttrs (res."image" != null) { inherit (res) "image"; }
    // {
    }
    // optionalAttrs (res."imageRepository" != null) { inherit (res) "imageRepository"; }
    // {
    }
    // optionalAttrs (res."resources" != null) {
      "resources" = mkProviderKubernetesEnvoyDeploymentContainerResources res."resources";
    }
    // {
    }
    // optionalAttrs (res."securityContext" != null) {
      "securityContext" =
        mkProviderKubernetesEnvoyDeploymentContainerSecurityContext
          res."securityContext";
    }
    // {
    }
    // optionalAttrs (res."volumeMounts" != [ ]) {
      "volumeMounts" = map mkProviderKubernetesEnvoyDeploymentContainerVolumeMount res."volumeMounts";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentContainerResourcesClaimModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name must match the name of one entry in pod.spec.resourceClaims of\nthe Pod where this field is used. It makes that resource available\ninside a container.";
        type = types.str;
      };
      "request" = mkOption {
        description = "Request is the name chosen for a request in the referenced claim.\nIf empty, everything from the claim is made available, otherwise\nonly the result of this request.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentContainerResourcesClaim =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."request" != null) { inherit (res) "request"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentContainerResourcesModule = types.submodule {
    options = {
      "claims" = mkOption {
        description = "Claims lists the names of resources, defined in spec.resourceClaims,\nthat are used by this container.\n\nThis is an alpha field and requires enabling the\nDynamicResourceAllocation feature gate.\n\nThis field is immutable. It can only be set for containers.";
        type = (types.listOf ProviderKubernetesEnvoyDeploymentContainerResourcesClaimModule);
        default = [ ];
      };
      "limits" = mkOption {
        description = "Limits describes the maximum amount of compute resources allowed.\nMore info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "requests" = mkOption {
        description = "Requests describes the minimum amount of compute resources required.\nIf Requests is omitted for a container, it defaults to Limits if that is explicitly specified,\notherwise to an implementation-defined value. Requests cannot exceed Limits.\nMore info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.attrsOf types.anything);
        default = { };
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentContainerResources =
    res:
    {
    }
    // optionalAttrs (res."claims" != [ ]) {
      "claims" = map mkProviderKubernetesEnvoyDeploymentContainerResourcesClaim res."claims";
    }
    // {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentContainerSecurityContextAppArmorProfileModule = types.submodule {
    options = {
      "localhostProfile" = mkOption {
        description = "localhostProfile indicates a profile loaded on the node that should be used.\nThe profile must be preconfigured on the node to work.\nMust match the loaded name of the profile.\nMust be set if and only if type is \"Localhost\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "type indicates which kind of AppArmor profile will be applied.\nValid options are:\n  Localhost - a profile pre-loaded on the node.\n  RuntimeDefault - the container runtime's default profile.\n  Unconfined - no AppArmor enforcement.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentContainerSecurityContextAppArmorProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  ProviderKubernetesEnvoyDeploymentContainerSecurityContextCapabilitiesModule = types.submodule {
    options = {
      "add" = mkOption {
        description = "Added capabilities";
        type = (types.listOf types.str);
        default = [ ];
      };
      "drop" = mkOption {
        description = "Removed capabilities";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentContainerSecurityContextCapabilities =
    res:
    {
    }
    // optionalAttrs (res."add" != [ ]) { inherit (res) "add"; }
    // {
    }
    // optionalAttrs (res."drop" != [ ]) { inherit (res) "drop"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentContainerSecurityContextModule = types.submodule {
    options = {
      "allowPrivilegeEscalation" = mkOption {
        description = "AllowPrivilegeEscalation controls whether a process can gain more\nprivileges than its parent process. This bool directly controls if\nthe no_new_privs flag will be set on the container process.\nAllowPrivilegeEscalation is true always when the container is:\n1) run as Privileged\n2) has CAP_SYS_ADMIN\nNote that this field cannot be set when spec.os.name is windows.";
        type = types.bool;
        default = false;
      };
      "appArmorProfile" = mkOption {
        description = "appArmorProfile is the AppArmor options to use by this container. If set, this profile\noverrides the pod's appArmorProfile.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDeploymentContainerSecurityContextAppArmorProfileModule
        );
        default = null;
      };
      "capabilities" = mkOption {
        description = "The capabilities to add/drop when running containers.\nDefaults to the default set of capabilities granted by the container runtime.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentContainerSecurityContextCapabilitiesModule);
        default = null;
      };
      "privileged" = mkOption {
        description = "Run container in privileged mode.\nProcesses in privileged containers are essentially equivalent to root on the host.\nDefaults to false.\nNote that this field cannot be set when spec.os.name is windows.";
        type = types.bool;
        default = false;
      };
      "procMount" = mkOption {
        description = "procMount denotes the type of proc mount to use for the containers.\nThe default value is Default which uses the container runtime defaults for\nreadonly paths and masked paths.\nThis requires the ProcMountType feature flag to be enabled.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnlyRootFilesystem" = mkOption {
        description = "Whether this container has a read-only root filesystem.\nDefault is false.\nNote that this field cannot be set when spec.os.name is windows.";
        type = types.bool;
        default = false;
      };
      "runAsGroup" = mkOption {
        description = "The GID to run the entrypoint of the container process.\nUses runtime default if unset.\nMay also be set in PodSecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.int);
        default = null;
      };
      "runAsNonRoot" = mkOption {
        description = "Indicates that the container must run as a non-root user.\nIf true, the Kubelet will validate the image at runtime to ensure that it\ndoes not run as UID 0 (root) and fail to start the container if it does.\nIf unset or false, no such validation will be performed.\nMay also be set in PodSecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.";
        type = types.bool;
        default = false;
      };
      "runAsUser" = mkOption {
        description = "The UID to run the entrypoint of the container process.\nDefaults to user specified in image metadata if unspecified.\nMay also be set in PodSecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.int);
        default = null;
      };
      "seLinuxOptions" = mkOption {
        description = "The SELinux context to be applied to the container.\nIf unspecified, the container runtime will allocate a random SELinux context for each\ncontainer.  May also be set in PodSecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentContainerSecurityContextSeLinuxOptionsModule);
        default = null;
      };
      "seccompProfile" = mkOption {
        description = "The seccomp options to use by this container. If seccomp options are\nprovided at both the pod & container level, the container options\noverride the pod options.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentContainerSecurityContextSeccompProfileModule);
        default = null;
      };
      "windowsOptions" = mkOption {
        description = "The Windows specific settings applied to all containers.\nIf unspecified, the options from the PodSecurityContext will be used.\nIf set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is linux.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentContainerSecurityContextWindowsOptionsModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentContainerSecurityContext =
    res:
    {
    }
    // optionalAttrs res."allowPrivilegeEscalation" { inherit (res) "allowPrivilegeEscalation"; }
    // {
    }
    // optionalAttrs (res."appArmorProfile" != null) {
      "appArmorProfile" =
        mkProviderKubernetesEnvoyDeploymentContainerSecurityContextAppArmorProfile
          res."appArmorProfile";
    }
    // {
    }
    // optionalAttrs (res."capabilities" != null) {
      "capabilities" =
        mkProviderKubernetesEnvoyDeploymentContainerSecurityContextCapabilities
          res."capabilities";
    }
    // {
    }
    // optionalAttrs res."privileged" { inherit (res) "privileged"; }
    // {
    }
    // optionalAttrs (res."procMount" != null) { inherit (res) "procMount"; }
    // {
    }
    // optionalAttrs res."readOnlyRootFilesystem" { inherit (res) "readOnlyRootFilesystem"; }
    // {
    }
    // optionalAttrs (res."runAsGroup" != null) { inherit (res) "runAsGroup"; }
    // {
    }
    // optionalAttrs res."runAsNonRoot" { inherit (res) "runAsNonRoot"; }
    // {
    }
    // optionalAttrs (res."runAsUser" != null) { inherit (res) "runAsUser"; }
    // {
    }
    // optionalAttrs (res."seLinuxOptions" != null) {
      "seLinuxOptions" =
        mkProviderKubernetesEnvoyDeploymentContainerSecurityContextSeLinuxOptions
          res."seLinuxOptions";
    }
    // {
    }
    // optionalAttrs (res."seccompProfile" != null) {
      "seccompProfile" =
        mkProviderKubernetesEnvoyDeploymentContainerSecurityContextSeccompProfile
          res."seccompProfile";
    }
    // {
    }
    // optionalAttrs (res."windowsOptions" != null) {
      "windowsOptions" =
        mkProviderKubernetesEnvoyDeploymentContainerSecurityContextWindowsOptions
          res."windowsOptions";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentContainerSecurityContextSeLinuxOptionsModule = types.submodule {
    options = {
      "level" = mkOption {
        description = "Level is SELinux level label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
      "role" = mkOption {
        description = "Role is a SELinux role label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Type is a SELinux type label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
      "user" = mkOption {
        description = "User is a SELinux user label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentContainerSecurityContextSeLinuxOptions =
    res:
    {
    }
    // optionalAttrs (res."level" != null) { inherit (res) "level"; }
    // {
    }
    // optionalAttrs (res."role" != null) { inherit (res) "role"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    }
    // optionalAttrs (res."user" != null) { inherit (res) "user"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentContainerSecurityContextSeccompProfileModule = types.submodule {
    options = {
      "localhostProfile" = mkOption {
        description = "localhostProfile indicates a profile defined in a file on the node should be used.\nThe profile must be preconfigured on the node to work.\nMust be a descending path, relative to the kubelet's configured seccomp profile location.\nMust be set if type is \"Localhost\". Must NOT be set for any other type.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "type indicates which kind of seccomp profile will be applied.\nValid options are:\n\nLocalhost - a profile defined in a file on the node should be used.\nRuntimeDefault - the container runtime default profile should be used.\nUnconfined - no profile should be applied.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentContainerSecurityContextSeccompProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  ProviderKubernetesEnvoyDeploymentContainerSecurityContextWindowsOptionsModule = types.submodule {
    options = {
      "gmsaCredentialSpec" = mkOption {
        description = "GMSACredentialSpec is where the GMSA admission webhook\n(https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the\nGMSA credential spec named by the GMSACredentialSpecName field.";
        type = (types.nullOr types.str);
        default = null;
      };
      "gmsaCredentialSpecName" = mkOption {
        description = "GMSACredentialSpecName is the name of the GMSA credential spec to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "hostProcess" = mkOption {
        description = "HostProcess determines if a container should be run as a 'Host Process' container.\nAll of a Pod's containers must have the same effective HostProcess value\n(it is not allowed to have a mix of HostProcess containers and non-HostProcess containers).\nIn addition, if HostProcess is true then HostNetwork must also be set to true.";
        type = types.bool;
        default = false;
      };
      "runAsUserName" = mkOption {
        description = "The UserName in Windows to run the entrypoint of the container process.\nDefaults to the user specified in image metadata if unspecified.\nMay also be set in PodSecurityContext. If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentContainerSecurityContextWindowsOptions =
    res:
    {
    }
    // optionalAttrs (res."gmsaCredentialSpec" != null) { inherit (res) "gmsaCredentialSpec"; }
    // {
    }
    // optionalAttrs (res."gmsaCredentialSpecName" != null) { inherit (res) "gmsaCredentialSpecName"; }
    // {
    }
    // optionalAttrs res."hostProcess" { inherit (res) "hostProcess"; }
    // {
    }
    // optionalAttrs (res."runAsUserName" != null) { inherit (res) "runAsUserName"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentContainerVolumeMountModule = types.submodule {
    options = {
      "mountPath" = mkOption {
        description = "Path within the container at which the volume should be mounted.  Must\nnot contain ':'.";
        type = types.str;
      };
      "mountPropagation" = mkOption {
        description = "mountPropagation determines how mounts are propagated from the host\nto container and the other way around.\nWhen not set, MountPropagationNone is used.\nThis field is beta in 1.10.\nWhen RecursiveReadOnly is set to IfPossible or to Enabled, MountPropagation must be None or unspecified\n(which defaults to None).";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "This must match the Name of a Volume.";
        type = types.str;
      };
      "readOnly" = mkOption {
        description = "Mounted read-only if true, read-write otherwise (false or unspecified).\nDefaults to false.";
        type = types.bool;
        default = false;
      };
      "recursiveReadOnly" = mkOption {
        description = "RecursiveReadOnly specifies whether read-only mounts should be handled\nrecursively.\n\nIf ReadOnly is false, this field has no meaning and must be unspecified.\n\nIf ReadOnly is true, and this field is set to Disabled, the mount is not made\nrecursively read-only.  If this field is set to IfPossible, the mount is made\nrecursively read-only, if it is supported by the container runtime.  If this\nfield is set to Enabled, the mount is made recursively read-only if it is\nsupported by the container runtime, otherwise the pod will not be started and\nan error will be generated to indicate the reason.\n\nIf this field is set to IfPossible or Enabled, MountPropagation must be set to\nNone (or be unspecified, which defaults to None).\n\nIf this field is not specified, it is treated as an equivalent of Disabled.";
        type = (types.nullOr types.str);
        default = null;
      };
      "subPath" = mkOption {
        description = "Path within the volume from which the container's volume should be mounted.\nDefaults to \"\" (volume's root).";
        type = (types.nullOr types.str);
        default = null;
      };
      "subPathExpr" = mkOption {
        description = "Expanded path within the volume from which the container's volume should be mounted.\nBehaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment.\nDefaults to \"\" (volume's root).\nSubPathExpr and SubPath are mutually exclusive.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentContainerVolumeMount =
    res:
    {
      inherit (res) "mountPath";
    }
    // optionalAttrs (res."mountPropagation" != null) { inherit (res) "mountPropagation"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."recursiveReadOnly" != null) { inherit (res) "recursiveReadOnly"; }
    // {
    }
    // optionalAttrs (res."subPath" != null) { inherit (res) "subPath"; }
    // {
    }
    // optionalAttrs (res."subPathExpr" != null) { inherit (res) "subPathExpr"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerEnvFromConfigMapRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "Specify whether the ConfigMap must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerEnvFromConfigMapRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerEnvFromModule = types.submodule {
    options = {
      "configMapRef" = mkOption {
        description = "The ConfigMap to select from";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerEnvFromConfigMapRefModule);
        default = null;
      };
      "prefix" = mkOption {
        description = "Optional text to prepend to the name of each environment variable. Must be a C_IDENTIFIER.";
        type = (types.nullOr types.str);
        default = null;
      };
      "secretRef" = mkOption {
        description = "The Secret to select from";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerEnvFromSecretRefModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerEnvFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapRef" != null) {
      "configMapRef" =
        mkProviderKubernetesEnvoyDeploymentInitContainerEnvFromConfigMapRef
          res."configMapRef";
    }
    // {
    }
    // optionalAttrs (res."prefix" != null) { inherit (res) "prefix"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderKubernetesEnvoyDeploymentInitContainerEnvFromSecretRef res."secretRef";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerEnvFromSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "Specify whether the Secret must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerEnvFromSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerEnvModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the environment variable. Must be a C_IDENTIFIER.";
        type = types.str;
      };
      "value" = mkOption {
        description = "Variable references $(VAR_NAME) are expanded\nusing the previously defined environment variables in the container and\nany service environment variables. If a variable cannot be resolved,\nthe reference in the input string will be unchanged. Double $$ are reduced\nto a single $, which allows for escaping the $(VAR_NAME) syntax: i.e.\n\"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\".\nEscaped references will never be expanded, regardless of whether the variable\nexists or not.\nDefaults to \"\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "valueFrom" = mkOption {
        description = "Source for the environment variable's value. Cannot be used if value is not empty.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerEnvValueFromModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerEnv =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    }
    // optionalAttrs (res."valueFrom" != null) {
      "valueFrom" = mkProviderKubernetesEnvoyDeploymentInitContainerEnvValueFrom res."valueFrom";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerEnvValueFromConfigMapKeyRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select.";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "Specify whether the ConfigMap or its key must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerEnvValueFromConfigMapKeyRef =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerEnvValueFromFieldRefModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        description = "Version of the schema the FieldPath is written in terms of, defaults to \"v1\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "fieldPath" = mkOption {
        description = "Path of the field to select in the specified API version.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerEnvValueFromFieldRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "fieldPath";
    };
  ProviderKubernetesEnvoyDeploymentInitContainerEnvValueFromModule = types.submodule {
    options = {
      "configMapKeyRef" = mkOption {
        description = "Selects a key of a ConfigMap.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerEnvValueFromConfigMapKeyRefModule
        );
        default = null;
      };
      "fieldRef" = mkOption {
        description = "Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`,\nspec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerEnvValueFromFieldRefModule);
        default = null;
      };
      "resourceFieldRef" = mkOption {
        description = "Selects a resource of the container: only resources limits and requests\n(limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerEnvValueFromResourceFieldRefModule
        );
        default = null;
      };
      "secretKeyRef" = mkOption {
        description = "Selects a key of a secret in the pod's namespace";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerEnvValueFromSecretKeyRefModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerEnvValueFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapKeyRef" != null) {
      "configMapKeyRef" =
        mkProviderKubernetesEnvoyDeploymentInitContainerEnvValueFromConfigMapKeyRef
          res."configMapKeyRef";
    }
    // {
    }
    // optionalAttrs (res."fieldRef" != null) {
      "fieldRef" = mkProviderKubernetesEnvoyDeploymentInitContainerEnvValueFromFieldRef res."fieldRef";
    }
    // {
    }
    // optionalAttrs (res."resourceFieldRef" != null) {
      "resourceFieldRef" =
        mkProviderKubernetesEnvoyDeploymentInitContainerEnvValueFromResourceFieldRef
          res."resourceFieldRef";
    }
    // {
    }
    // optionalAttrs (res."secretKeyRef" != null) {
      "secretKeyRef" =
        mkProviderKubernetesEnvoyDeploymentInitContainerEnvValueFromSecretKeyRef
          res."secretKeyRef";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerEnvValueFromResourceFieldRefModule = types.submodule {
    options = {
      "containerName" = mkOption {
        description = "Container name: required for volumes, optional for env vars";
        type = (types.nullOr types.str);
        default = null;
      };
      "divisor" = mkOption {
        description = "Specifies the output format of the exposed resources, defaults to \"1\"";
        type = types.anything;
        default = { };
      };
      "resource" = mkOption {
        description = "Required: resource to select";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerEnvValueFromResourceFieldRef =
    res:
    {
    }
    // optionalAttrs (res."containerName" != null) { inherit (res) "containerName"; }
    // {
    }
    // optionalAttrs (res."divisor" != null) { inherit (res) "divisor"; }
    // {
      inherit (res) "resource";
    };
  ProviderKubernetesEnvoyDeploymentInitContainerEnvValueFromSecretKeyRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key of the secret to select from.  Must be a valid secret key.";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "Specify whether the Secret or its key must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerEnvValueFromSecretKeyRef =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerLifecycleModule = types.submodule {
    options = {
      "postStart" = mkOption {
        description = "PostStart is called immediately after a container is created. If the handler fails,\nthe container is terminated and restarted according to its restart policy.\nOther management of the container blocks until the hook completes.\nMore info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerLifecyclePostStartModule);
        default = null;
      };
      "preStop" = mkOption {
        description = "PreStop is called immediately before a container is terminated due to an\nAPI request or management event such as liveness/startup probe failure,\npreemption, resource contention, etc. The handler is not called if the\ncontainer crashes or exits. The Pod's termination grace period countdown begins before the\nPreStop hook is executed. Regardless of the outcome of the handler, the\ncontainer will eventually terminate within the Pod's termination grace\nperiod (unless delayed by finalizers). Other management of the container blocks until the hook completes\nor until the termination grace period is reached.\nMore info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerLifecyclePreStopModule);
        default = null;
      };
      "stopSignal" = mkOption {
        description = "StopSignal defines which signal will be sent to a container when it is being stopped.\nIf not specified, the default is defined by the container runtime in use.\nStopSignal can only be set for Pods with a non-empty .spec.os.name";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerLifecycle =
    res:
    {
    }
    // optionalAttrs (res."postStart" != null) {
      "postStart" = mkProviderKubernetesEnvoyDeploymentInitContainerLifecyclePostStart res."postStart";
    }
    // {
    }
    // optionalAttrs (res."preStop" != null) {
      "preStop" = mkProviderKubernetesEnvoyDeploymentInitContainerLifecyclePreStop res."preStop";
    }
    // {
    }
    // optionalAttrs (res."stopSignal" != null) { inherit (res) "stopSignal"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerLifecyclePostStartExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerLifecyclePostStartExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerLifecyclePostStartHttpGetHttpHeaderModule =
    types.submodule
      {
        options = {
          "name" = mkOption {
            description = "The header field name.\nThis will be canonicalized upon output, so case-variant names will be understood as the same header.";
            type = types.str;
          };
          "value" = mkOption {
            description = "The header field value";
            type = types.str;
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentInitContainerLifecyclePostStartHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  ProviderKubernetesEnvoyDeploymentInitContainerLifecyclePostStartHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (
          types.listOf ProviderKubernetesEnvoyDeploymentInitContainerLifecyclePostStartHttpGetHttpHeaderModule
        );
        default = [ ];
      };
      "path" = mkOption {
        description = "Path to access on the HTTP server.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Name or number of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
      "scheme" = mkOption {
        description = "Scheme to use for connecting to the host.\nDefaults to HTTP.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerLifecyclePostStartHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" =
        map mkProviderKubernetesEnvoyDeploymentInitContainerLifecyclePostStartHttpGetHttpHeader
          res."httpHeaders";
    }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
      inherit (res) "port";
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerLifecyclePostStartModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerLifecyclePostStartExecModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerLifecyclePostStartHttpGetModule);
        default = null;
      };
      "sleep" = mkOption {
        description = "Sleep represents a duration that the container should sleep.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerLifecyclePostStartSleepModule);
        default = null;
      };
      "tcpSocket" = mkOption {
        description = "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept\nfor backward compatibility. There is no validation of this field and\nlifecycle hooks will fail at runtime when it is specified.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerLifecyclePostStartTcpSocketModule
        );
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerLifecyclePostStart =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkProviderKubernetesEnvoyDeploymentInitContainerLifecyclePostStartExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkProviderKubernetesEnvoyDeploymentInitContainerLifecyclePostStartHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."sleep" != null) {
      "sleep" = mkProviderKubernetesEnvoyDeploymentInitContainerLifecyclePostStartSleep res."sleep";
    }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" =
        mkProviderKubernetesEnvoyDeploymentInitContainerLifecyclePostStartTcpSocket
          res."tcpSocket";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerLifecyclePostStartSleepModule = types.submodule {
    options = {
      "seconds" = mkOption {
        description = "Seconds is the number of seconds to sleep.";
        type = types.int;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerLifecyclePostStartSleep = res: {
    inherit (res) "seconds";
  };
  ProviderKubernetesEnvoyDeploymentInitContainerLifecyclePostStartTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Optional: Host name to connect to, defaults to the pod IP.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Number or name of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerLifecyclePostStartTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  ProviderKubernetesEnvoyDeploymentInitContainerLifecyclePreStopExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerLifecyclePreStopExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerLifecyclePreStopHttpGetHttpHeaderModule =
    types.submodule
      {
        options = {
          "name" = mkOption {
            description = "The header field name.\nThis will be canonicalized upon output, so case-variant names will be understood as the same header.";
            type = types.str;
          };
          "value" = mkOption {
            description = "The header field value";
            type = types.str;
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentInitContainerLifecyclePreStopHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  ProviderKubernetesEnvoyDeploymentInitContainerLifecyclePreStopHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (
          types.listOf ProviderKubernetesEnvoyDeploymentInitContainerLifecyclePreStopHttpGetHttpHeaderModule
        );
        default = [ ];
      };
      "path" = mkOption {
        description = "Path to access on the HTTP server.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Name or number of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
      "scheme" = mkOption {
        description = "Scheme to use for connecting to the host.\nDefaults to HTTP.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerLifecyclePreStopHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" =
        map mkProviderKubernetesEnvoyDeploymentInitContainerLifecyclePreStopHttpGetHttpHeader
          res."httpHeaders";
    }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
      inherit (res) "port";
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerLifecyclePreStopModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerLifecyclePreStopExecModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerLifecyclePreStopHttpGetModule);
        default = null;
      };
      "sleep" = mkOption {
        description = "Sleep represents a duration that the container should sleep.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerLifecyclePreStopSleepModule);
        default = null;
      };
      "tcpSocket" = mkOption {
        description = "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept\nfor backward compatibility. There is no validation of this field and\nlifecycle hooks will fail at runtime when it is specified.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerLifecyclePreStopTcpSocketModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerLifecyclePreStop =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkProviderKubernetesEnvoyDeploymentInitContainerLifecyclePreStopExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkProviderKubernetesEnvoyDeploymentInitContainerLifecyclePreStopHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."sleep" != null) {
      "sleep" = mkProviderKubernetesEnvoyDeploymentInitContainerLifecyclePreStopSleep res."sleep";
    }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" =
        mkProviderKubernetesEnvoyDeploymentInitContainerLifecyclePreStopTcpSocket
          res."tcpSocket";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerLifecyclePreStopSleepModule = types.submodule {
    options = {
      "seconds" = mkOption {
        description = "Seconds is the number of seconds to sleep.";
        type = types.int;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerLifecyclePreStopSleep = res: {
    inherit (res) "seconds";
  };
  ProviderKubernetesEnvoyDeploymentInitContainerLifecyclePreStopTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Optional: Host name to connect to, defaults to the pod IP.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Number or name of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerLifecyclePreStopTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  ProviderKubernetesEnvoyDeploymentInitContainerLivenessProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerLivenessProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerLivenessProbeGrpcModule = types.submodule {
    options = {
      "port" = mkOption {
        description = "Port number of the gRPC service. Number must be in the range 1 to 65535.";
        type = types.int;
      };
      "service" = mkOption {
        description = "Service is the name of the service to place in the gRPC HealthCheckRequest\n(see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).\n\nIf this is not specified, the default behavior is defined by gRPC.";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerLivenessProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerLivenessProbeHttpGetHttpHeaderModule =
    types.submodule
      {
        options = {
          "name" = mkOption {
            description = "The header field name.\nThis will be canonicalized upon output, so case-variant names will be understood as the same header.";
            type = types.str;
          };
          "value" = mkOption {
            description = "The header field value";
            type = types.str;
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentInitContainerLivenessProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  ProviderKubernetesEnvoyDeploymentInitContainerLivenessProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (
          types.listOf ProviderKubernetesEnvoyDeploymentInitContainerLivenessProbeHttpGetHttpHeaderModule
        );
        default = [ ];
      };
      "path" = mkOption {
        description = "Path to access on the HTTP server.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Name or number of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
      "scheme" = mkOption {
        description = "Scheme to use for connecting to the host.\nDefaults to HTTP.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerLivenessProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" =
        map mkProviderKubernetesEnvoyDeploymentInitContainerLivenessProbeHttpGetHttpHeader
          res."httpHeaders";
    }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
      inherit (res) "port";
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerLivenessProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerLivenessProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        description = "Minimum consecutive failures for the probe to be considered failed after having succeeded.\nDefaults to 3. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        description = "GRPC specifies a GRPC HealthCheckRequest.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerLivenessProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerLivenessProbeHttpGetModule);
        default = null;
      };
      "initialDelaySeconds" = mkOption {
        description = "Number of seconds after the container has started before liveness probes are initiated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr types.int);
        default = null;
      };
      "periodSeconds" = mkOption {
        description = "How often (in seconds) to perform the probe.\nDefault to 10 seconds. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "successThreshold" = mkOption {
        description = "Minimum consecutive successes for the probe to be considered successful after having failed.\nDefaults to 1. Must be 1 for liveness and startup. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "tcpSocket" = mkOption {
        description = "TCPSocket specifies a connection to a TCP port.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerLivenessProbeTcpSocketModule);
        default = null;
      };
      "terminationGracePeriodSeconds" = mkOption {
        description = "Optional duration in seconds the pod needs to terminate gracefully upon probe failure.\nThe grace period is the duration in seconds after the processes running in the pod are sent\na termination signal and the time when the processes are forcibly halted with a kill signal.\nSet this value longer than the expected cleanup time for your process.\nIf this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this\nvalue overrides the value provided by the pod spec.\nValue must be non-negative integer. The value zero indicates stop immediately via\nthe kill signal (no opportunity to shut down).\nThis is a beta field and requires enabling ProbeTerminationGracePeriod feature gate.\nMinimum value is 1. spec.terminationGracePeriodSeconds is used if unset.";
        type = (types.nullOr types.int);
        default = null;
      };
      "timeoutSeconds" = mkOption {
        description = "Number of seconds after which the probe times out.\nDefaults to 1 second. Minimum value is 1.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerLivenessProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkProviderKubernetesEnvoyDeploymentInitContainerLivenessProbeExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkProviderKubernetesEnvoyDeploymentInitContainerLivenessProbeGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkProviderKubernetesEnvoyDeploymentInitContainerLivenessProbeHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."initialDelaySeconds" != null) { inherit (res) "initialDelaySeconds"; }
    // {
    }
    // optionalAttrs (res."periodSeconds" != null) { inherit (res) "periodSeconds"; }
    // {
    }
    // optionalAttrs (res."successThreshold" != null) { inherit (res) "successThreshold"; }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" =
        mkProviderKubernetesEnvoyDeploymentInitContainerLivenessProbeTcpSocket
          res."tcpSocket";
    }
    // {
    }
    // optionalAttrs (res."terminationGracePeriodSeconds" != null) {
      inherit (res) "terminationGracePeriodSeconds";
    }
    // {
    }
    // optionalAttrs (res."timeoutSeconds" != null) { inherit (res) "timeoutSeconds"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerLivenessProbeTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Optional: Host name to connect to, defaults to the pod IP.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Number or name of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerLivenessProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  ProviderKubernetesEnvoyDeploymentInitContainerModule = types.submodule {
    options = {
      "args" = mkOption {
        description = "Arguments to the entrypoint.\nThe container image's CMD is used if this is not provided.\nVariable references $(VAR_NAME) are expanded using the container's environment. If a variable\ncannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced\nto a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will\nproduce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless\nof whether the variable exists or not. Cannot be updated.\nMore info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell";
        type = (types.listOf types.str);
        default = [ ];
      };
      "command" = mkOption {
        description = "Entrypoint array. Not executed within a shell.\nThe container image's ENTRYPOINT is used if this is not provided.\nVariable references $(VAR_NAME) are expanded using the container's environment. If a variable\ncannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced\nto a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will\nproduce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless\nof whether the variable exists or not. Cannot be updated.\nMore info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell";
        type = (types.listOf types.str);
        default = [ ];
      };
      "env" = mkOption {
        description = "List of environment variables to set in the container.\nCannot be updated.";
        type = (types.listOf ProviderKubernetesEnvoyDeploymentInitContainerEnvModule);
        default = [ ];
      };
      "envFrom" = mkOption {
        description = "List of sources to populate environment variables in the container.\nThe keys defined within a source must be a C_IDENTIFIER. All invalid keys\nwill be reported as an event when the container is starting. When a key exists in multiple\nsources, the value associated with the last source will take precedence.\nValues defined by an Env with a duplicate key will take precedence.\nCannot be updated.";
        type = (types.listOf ProviderKubernetesEnvoyDeploymentInitContainerEnvFromModule);
        default = [ ];
      };
      "image" = mkOption {
        description = "Container image name.\nMore info: https://kubernetes.io/docs/concepts/containers/images\nThis field is optional to allow higher level config management to default or override\ncontainer images in workload controllers like Deployments and StatefulSets.";
        type = (types.nullOr types.str);
        default = null;
      };
      "imagePullPolicy" = mkOption {
        description = "Image pull policy.\nOne of Always, Never, IfNotPresent.\nDefaults to Always if :latest tag is specified, or IfNotPresent otherwise.\nCannot be updated.\nMore info: https://kubernetes.io/docs/concepts/containers/images#updating-images";
        type = (types.nullOr types.str);
        default = null;
      };
      "lifecycle" = mkOption {
        description = "Actions that the management system should take in response to container lifecycle events.\nCannot be updated.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerLifecycleModule);
        default = null;
      };
      "livenessProbe" = mkOption {
        description = "Periodic probe of container liveness.\nContainer will be restarted if the probe fails.\nCannot be updated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerLivenessProbeModule);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the container specified as a DNS_LABEL.\nEach container in a pod must have a unique name (DNS_LABEL).\nCannot be updated.";
        type = types.str;
      };
      "ports" = mkOption {
        description = "List of ports to expose from the container. Not specifying a port here\nDOES NOT prevent that port from being exposed. Any port which is\nlistening on the default \"0.0.0.0\" address inside a container will be\naccessible from the network.\nModifying this array with strategic merge patch may corrupt the data.\nFor more information See https://github.com/kubernetes/kubernetes/issues/108255.\nCannot be updated.";
        type = (types.listOf ProviderKubernetesEnvoyDeploymentInitContainerPortModule);
        default = [ ];
      };
      "readinessProbe" = mkOption {
        description = "Periodic probe of container service readiness.\nContainer will be removed from service endpoints if the probe fails.\nCannot be updated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerReadinessProbeModule);
        default = null;
      };
      "resizePolicy" = mkOption {
        description = "Resources resize policy for the container.";
        type = (types.listOf ProviderKubernetesEnvoyDeploymentInitContainerResizePolicyModule);
        default = [ ];
      };
      "resources" = mkOption {
        description = "Compute Resources required by this container.\nCannot be updated.\nMore info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerResourcesModule);
        default = null;
      };
      "restartPolicy" = mkOption {
        description = "RestartPolicy defines the restart behavior of individual containers in a pod.\nThis field may only be set for init containers, and the only allowed value is \"Always\".\nFor non-init containers or when this field is not specified,\nthe restart behavior is defined by the Pod's restart policy and the container type.\nSetting the RestartPolicy as \"Always\" for the init container will have the following effect:\nthis init container will be continually restarted on\nexit until all regular containers have terminated. Once all regular\ncontainers have completed, all init containers with restartPolicy \"Always\"\nwill be shut down. This lifecycle differs from normal init containers and\nis often referred to as a \"sidecar\" container. Although this init\ncontainer still starts in the init container sequence, it does not wait\nfor the container to complete before proceeding to the next init\ncontainer. Instead, the next init container starts immediately after this\ninit container is started, or after any startupProbe has successfully\ncompleted.";
        type = (types.nullOr types.str);
        default = null;
      };
      "securityContext" = mkOption {
        description = "SecurityContext defines the security options the container should be run with.\nIf set, the fields of SecurityContext override the equivalent fields of PodSecurityContext.\nMore info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerSecurityContextModule);
        default = null;
      };
      "startupProbe" = mkOption {
        description = "StartupProbe indicates that the Pod has successfully initialized.\nIf specified, no other probes are executed until this completes successfully.\nIf this probe fails, the Pod will be restarted, just as if the livenessProbe failed.\nThis can be used to provide different probe parameters at the beginning of a Pod's lifecycle,\nwhen it might take a long time to load data or warm a cache, than during steady-state operation.\nThis cannot be updated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerStartupProbeModule);
        default = null;
      };
      "stdin" = mkOption {
        description = "Whether this container should allocate a buffer for stdin in the container runtime. If this\nis not set, reads from stdin in the container will always result in EOF.\nDefault is false.";
        type = types.bool;
        default = false;
      };
      "stdinOnce" = mkOption {
        description = "Whether the container runtime should close the stdin channel after it has been opened by\na single attach. When stdin is true the stdin stream will remain open across multiple attach\nsessions. If stdinOnce is set to true, stdin is opened on container start, is empty until the\nfirst client attaches to stdin, and then remains open and accepts data until the client disconnects,\nat which time stdin is closed and remains closed until the container is restarted. If this\nflag is false, a container processes that reads from stdin will never receive an EOF.\nDefault is false";
        type = types.bool;
        default = false;
      };
      "terminationMessagePath" = mkOption {
        description = "Optional: Path at which the file to which the container's termination message\nwill be written is mounted into the container's filesystem.\nMessage written is intended to be brief final status, such as an assertion failure message.\nWill be truncated by the node if greater than 4096 bytes. The total message length across\nall containers will be limited to 12kb.\nDefaults to /dev/termination-log.\nCannot be updated.";
        type = (types.nullOr types.str);
        default = null;
      };
      "terminationMessagePolicy" = mkOption {
        description = "Indicate how the termination message should be populated. File will use the contents of\nterminationMessagePath to populate the container status message on both success and failure.\nFallbackToLogsOnError will use the last chunk of container log output if the termination\nmessage file is empty and the container exited with an error.\nThe log output is limited to 2048 bytes or 80 lines, whichever is smaller.\nDefaults to File.\nCannot be updated.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tty" = mkOption {
        description = "Whether this container should allocate a TTY for itself, also requires 'stdin' to be true.\nDefault is false.";
        type = types.bool;
        default = false;
      };
      "volumeDevices" = mkOption {
        description = "volumeDevices is the list of block devices to be used by the container.";
        type = (types.listOf ProviderKubernetesEnvoyDeploymentInitContainerVolumeDeviceModule);
        default = [ ];
      };
      "volumeMounts" = mkOption {
        description = "Pod volumes to mount into the container's filesystem.\nCannot be updated.";
        type = (types.listOf ProviderKubernetesEnvoyDeploymentInitContainerVolumeMountModule);
        default = [ ];
      };
      "workingDir" = mkOption {
        description = "Container's working directory.\nIf not specified, the container runtime's default will be used, which\nmight be configured in the container image.\nCannot be updated.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainer =
    res:
    {
    }
    // optionalAttrs (res."args" != [ ]) { inherit (res) "args"; }
    // {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    }
    // optionalAttrs (res."env" != [ ]) {
      "env" = map mkProviderKubernetesEnvoyDeploymentInitContainerEnv res."env";
    }
    // {
    }
    // optionalAttrs (res."envFrom" != [ ]) {
      "envFrom" = map mkProviderKubernetesEnvoyDeploymentInitContainerEnvFrom res."envFrom";
    }
    // {
    }
    // optionalAttrs (res."image" != null) { inherit (res) "image"; }
    // {
    }
    // optionalAttrs (res."imagePullPolicy" != null) { inherit (res) "imagePullPolicy"; }
    // {
    }
    // optionalAttrs (res."lifecycle" != null) {
      "lifecycle" = mkProviderKubernetesEnvoyDeploymentInitContainerLifecycle res."lifecycle";
    }
    // {
    }
    // optionalAttrs (res."livenessProbe" != null) {
      "livenessProbe" = mkProviderKubernetesEnvoyDeploymentInitContainerLivenessProbe res."livenessProbe";
    }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."ports" != [ ]) {
      "ports" = map mkProviderKubernetesEnvoyDeploymentInitContainerPort res."ports";
    }
    // {
    }
    // optionalAttrs (res."readinessProbe" != null) {
      "readinessProbe" =
        mkProviderKubernetesEnvoyDeploymentInitContainerReadinessProbe
          res."readinessProbe";
    }
    // {
    }
    // optionalAttrs (res."resizePolicy" != [ ]) {
      "resizePolicy" =
        map mkProviderKubernetesEnvoyDeploymentInitContainerResizePolicy
          res."resizePolicy";
    }
    // {
    }
    // optionalAttrs (res."resources" != null) {
      "resources" = mkProviderKubernetesEnvoyDeploymentInitContainerResources res."resources";
    }
    // {
    }
    // optionalAttrs (res."restartPolicy" != null) { inherit (res) "restartPolicy"; }
    // {
    }
    // optionalAttrs (res."securityContext" != null) {
      "securityContext" =
        mkProviderKubernetesEnvoyDeploymentInitContainerSecurityContext
          res."securityContext";
    }
    // {
    }
    // optionalAttrs (res."startupProbe" != null) {
      "startupProbe" = mkProviderKubernetesEnvoyDeploymentInitContainerStartupProbe res."startupProbe";
    }
    // {
    }
    // optionalAttrs res."stdin" { inherit (res) "stdin"; }
    // {
    }
    // optionalAttrs res."stdinOnce" { inherit (res) "stdinOnce"; }
    // {
    }
    // optionalAttrs (res."terminationMessagePath" != null) { inherit (res) "terminationMessagePath"; }
    // {
    }
    // optionalAttrs (res."terminationMessagePolicy" != null) {
      inherit (res) "terminationMessagePolicy";
    }
    // {
    }
    // optionalAttrs res."tty" { inherit (res) "tty"; }
    // {
    }
    // optionalAttrs (res."volumeDevices" != [ ]) {
      "volumeDevices" =
        map mkProviderKubernetesEnvoyDeploymentInitContainerVolumeDevice
          res."volumeDevices";
    }
    // {
    }
    // optionalAttrs (res."volumeMounts" != [ ]) {
      "volumeMounts" = map mkProviderKubernetesEnvoyDeploymentInitContainerVolumeMount res."volumeMounts";
    }
    // {
    }
    // optionalAttrs (res."workingDir" != null) { inherit (res) "workingDir"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerPortModule = types.submodule {
    options = {
      "containerPort" = mkOption {
        description = "Number of port to expose on the pod's IP address.\nThis must be a valid port number, 0 < x < 65536.";
        type = types.int;
      };
      "hostIP" = mkOption {
        description = "What host IP to bind the external port to.";
        type = (types.nullOr types.str);
        default = null;
      };
      "hostPort" = mkOption {
        description = "Number of port to expose on the host.\nIf specified, this must be a valid port number, 0 < x < 65536.\nIf HostNetwork is specified, this must match ContainerPort.\nMost containers do not need this.";
        type = (types.nullOr types.int);
        default = null;
      };
      "name" = mkOption {
        description = "If specified, this must be an IANA_SVC_NAME and unique within the pod. Each\nnamed port in a pod must have a unique name. Name for the port that can be\nreferred to by services.";
        type = (types.nullOr types.str);
        default = null;
      };
      "protocol" = mkOption {
        description = "Protocol for port. Must be UDP, TCP, or SCTP.\nDefaults to \"TCP\".";
        type = (types.nullOr types.str);
        default = "TCP";
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerPort =
    res:
    {
      inherit (res) "containerPort";
    }
    // optionalAttrs (res."hostIP" != null) { inherit (res) "hostIP"; }
    // {
    }
    // optionalAttrs (res."hostPort" != null) { inherit (res) "hostPort"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."protocol" != null) { inherit (res) "protocol"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerReadinessProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerReadinessProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerReadinessProbeGrpcModule = types.submodule {
    options = {
      "port" = mkOption {
        description = "Port number of the gRPC service. Number must be in the range 1 to 65535.";
        type = types.int;
      };
      "service" = mkOption {
        description = "Service is the name of the service to place in the gRPC HealthCheckRequest\n(see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).\n\nIf this is not specified, the default behavior is defined by gRPC.";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerReadinessProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerReadinessProbeHttpGetHttpHeaderModule =
    types.submodule
      {
        options = {
          "name" = mkOption {
            description = "The header field name.\nThis will be canonicalized upon output, so case-variant names will be understood as the same header.";
            type = types.str;
          };
          "value" = mkOption {
            description = "The header field value";
            type = types.str;
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentInitContainerReadinessProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  ProviderKubernetesEnvoyDeploymentInitContainerReadinessProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (
          types.listOf ProviderKubernetesEnvoyDeploymentInitContainerReadinessProbeHttpGetHttpHeaderModule
        );
        default = [ ];
      };
      "path" = mkOption {
        description = "Path to access on the HTTP server.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Name or number of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
      "scheme" = mkOption {
        description = "Scheme to use for connecting to the host.\nDefaults to HTTP.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerReadinessProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" =
        map mkProviderKubernetesEnvoyDeploymentInitContainerReadinessProbeHttpGetHttpHeader
          res."httpHeaders";
    }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
      inherit (res) "port";
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerReadinessProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerReadinessProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        description = "Minimum consecutive failures for the probe to be considered failed after having succeeded.\nDefaults to 3. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        description = "GRPC specifies a GRPC HealthCheckRequest.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerReadinessProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerReadinessProbeHttpGetModule);
        default = null;
      };
      "initialDelaySeconds" = mkOption {
        description = "Number of seconds after the container has started before liveness probes are initiated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr types.int);
        default = null;
      };
      "periodSeconds" = mkOption {
        description = "How often (in seconds) to perform the probe.\nDefault to 10 seconds. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "successThreshold" = mkOption {
        description = "Minimum consecutive successes for the probe to be considered successful after having failed.\nDefaults to 1. Must be 1 for liveness and startup. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "tcpSocket" = mkOption {
        description = "TCPSocket specifies a connection to a TCP port.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerReadinessProbeTcpSocketModule);
        default = null;
      };
      "terminationGracePeriodSeconds" = mkOption {
        description = "Optional duration in seconds the pod needs to terminate gracefully upon probe failure.\nThe grace period is the duration in seconds after the processes running in the pod are sent\na termination signal and the time when the processes are forcibly halted with a kill signal.\nSet this value longer than the expected cleanup time for your process.\nIf this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this\nvalue overrides the value provided by the pod spec.\nValue must be non-negative integer. The value zero indicates stop immediately via\nthe kill signal (no opportunity to shut down).\nThis is a beta field and requires enabling ProbeTerminationGracePeriod feature gate.\nMinimum value is 1. spec.terminationGracePeriodSeconds is used if unset.";
        type = (types.nullOr types.int);
        default = null;
      };
      "timeoutSeconds" = mkOption {
        description = "Number of seconds after which the probe times out.\nDefaults to 1 second. Minimum value is 1.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerReadinessProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkProviderKubernetesEnvoyDeploymentInitContainerReadinessProbeExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkProviderKubernetesEnvoyDeploymentInitContainerReadinessProbeGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkProviderKubernetesEnvoyDeploymentInitContainerReadinessProbeHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."initialDelaySeconds" != null) { inherit (res) "initialDelaySeconds"; }
    // {
    }
    // optionalAttrs (res."periodSeconds" != null) { inherit (res) "periodSeconds"; }
    // {
    }
    // optionalAttrs (res."successThreshold" != null) { inherit (res) "successThreshold"; }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" =
        mkProviderKubernetesEnvoyDeploymentInitContainerReadinessProbeTcpSocket
          res."tcpSocket";
    }
    // {
    }
    // optionalAttrs (res."terminationGracePeriodSeconds" != null) {
      inherit (res) "terminationGracePeriodSeconds";
    }
    // {
    }
    // optionalAttrs (res."timeoutSeconds" != null) { inherit (res) "timeoutSeconds"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerReadinessProbeTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Optional: Host name to connect to, defaults to the pod IP.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Number or name of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerReadinessProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  ProviderKubernetesEnvoyDeploymentInitContainerResizePolicyModule = types.submodule {
    options = {
      "resourceName" = mkOption {
        description = "Name of the resource to which this resource resize policy applies.\nSupported values: cpu, memory.";
        type = types.str;
      };
      "restartPolicy" = mkOption {
        description = "Restart policy to apply when specified resource is resized.\nIf not specified, it defaults to NotRequired.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerResizePolicy = res: {
    inherit (res) "resourceName";
    inherit (res) "restartPolicy";
  };
  ProviderKubernetesEnvoyDeploymentInitContainerResourcesClaimModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name must match the name of one entry in pod.spec.resourceClaims of\nthe Pod where this field is used. It makes that resource available\ninside a container.";
        type = types.str;
      };
      "request" = mkOption {
        description = "Request is the name chosen for a request in the referenced claim.\nIf empty, everything from the claim is made available, otherwise\nonly the result of this request.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerResourcesClaim =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."request" != null) { inherit (res) "request"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerResourcesModule = types.submodule {
    options = {
      "claims" = mkOption {
        description = "Claims lists the names of resources, defined in spec.resourceClaims,\nthat are used by this container.\n\nThis is an alpha field and requires enabling the\nDynamicResourceAllocation feature gate.\n\nThis field is immutable. It can only be set for containers.";
        type = (types.listOf ProviderKubernetesEnvoyDeploymentInitContainerResourcesClaimModule);
        default = [ ];
      };
      "limits" = mkOption {
        description = "Limits describes the maximum amount of compute resources allowed.\nMore info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "requests" = mkOption {
        description = "Requests describes the minimum amount of compute resources required.\nIf Requests is omitted for a container, it defaults to Limits if that is explicitly specified,\notherwise to an implementation-defined value. Requests cannot exceed Limits.\nMore info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.attrsOf types.anything);
        default = { };
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerResources =
    res:
    {
    }
    // optionalAttrs (res."claims" != [ ]) {
      "claims" = map mkProviderKubernetesEnvoyDeploymentInitContainerResourcesClaim res."claims";
    }
    // {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerSecurityContextAppArmorProfileModule =
    types.submodule
      {
        options = {
          "localhostProfile" = mkOption {
            description = "localhostProfile indicates a profile loaded on the node that should be used.\nThe profile must be preconfigured on the node to work.\nMust match the loaded name of the profile.\nMust be set if and only if type is \"Localhost\".";
            type = (types.nullOr types.str);
            default = null;
          };
          "type" = mkOption {
            description = "type indicates which kind of AppArmor profile will be applied.\nValid options are:\n  Localhost - a profile pre-loaded on the node.\n  RuntimeDefault - the container runtime's default profile.\n  Unconfined - no AppArmor enforcement.";
            type = types.str;
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentInitContainerSecurityContextAppArmorProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  ProviderKubernetesEnvoyDeploymentInitContainerSecurityContextCapabilitiesModule = types.submodule {
    options = {
      "add" = mkOption {
        description = "Added capabilities";
        type = (types.listOf types.str);
        default = [ ];
      };
      "drop" = mkOption {
        description = "Removed capabilities";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerSecurityContextCapabilities =
    res:
    {
    }
    // optionalAttrs (res."add" != [ ]) { inherit (res) "add"; }
    // {
    }
    // optionalAttrs (res."drop" != [ ]) { inherit (res) "drop"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerSecurityContextModule = types.submodule {
    options = {
      "allowPrivilegeEscalation" = mkOption {
        description = "AllowPrivilegeEscalation controls whether a process can gain more\nprivileges than its parent process. This bool directly controls if\nthe no_new_privs flag will be set on the container process.\nAllowPrivilegeEscalation is true always when the container is:\n1) run as Privileged\n2) has CAP_SYS_ADMIN\nNote that this field cannot be set when spec.os.name is windows.";
        type = types.bool;
        default = false;
      };
      "appArmorProfile" = mkOption {
        description = "appArmorProfile is the AppArmor options to use by this container. If set, this profile\noverrides the pod's appArmorProfile.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerSecurityContextAppArmorProfileModule
        );
        default = null;
      };
      "capabilities" = mkOption {
        description = "The capabilities to add/drop when running containers.\nDefaults to the default set of capabilities granted by the container runtime.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerSecurityContextCapabilitiesModule
        );
        default = null;
      };
      "privileged" = mkOption {
        description = "Run container in privileged mode.\nProcesses in privileged containers are essentially equivalent to root on the host.\nDefaults to false.\nNote that this field cannot be set when spec.os.name is windows.";
        type = types.bool;
        default = false;
      };
      "procMount" = mkOption {
        description = "procMount denotes the type of proc mount to use for the containers.\nThe default value is Default which uses the container runtime defaults for\nreadonly paths and masked paths.\nThis requires the ProcMountType feature flag to be enabled.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnlyRootFilesystem" = mkOption {
        description = "Whether this container has a read-only root filesystem.\nDefault is false.\nNote that this field cannot be set when spec.os.name is windows.";
        type = types.bool;
        default = false;
      };
      "runAsGroup" = mkOption {
        description = "The GID to run the entrypoint of the container process.\nUses runtime default if unset.\nMay also be set in PodSecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.int);
        default = null;
      };
      "runAsNonRoot" = mkOption {
        description = "Indicates that the container must run as a non-root user.\nIf true, the Kubelet will validate the image at runtime to ensure that it\ndoes not run as UID 0 (root) and fail to start the container if it does.\nIf unset or false, no such validation will be performed.\nMay also be set in PodSecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.";
        type = types.bool;
        default = false;
      };
      "runAsUser" = mkOption {
        description = "The UID to run the entrypoint of the container process.\nDefaults to user specified in image metadata if unspecified.\nMay also be set in PodSecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.int);
        default = null;
      };
      "seLinuxOptions" = mkOption {
        description = "The SELinux context to be applied to the container.\nIf unspecified, the container runtime will allocate a random SELinux context for each\ncontainer.  May also be set in PodSecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerSecurityContextSeLinuxOptionsModule
        );
        default = null;
      };
      "seccompProfile" = mkOption {
        description = "The seccomp options to use by this container. If seccomp options are\nprovided at both the pod & container level, the container options\noverride the pod options.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerSecurityContextSeccompProfileModule
        );
        default = null;
      };
      "windowsOptions" = mkOption {
        description = "The Windows specific settings applied to all containers.\nIf unspecified, the options from the PodSecurityContext will be used.\nIf set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is linux.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerSecurityContextWindowsOptionsModule
        );
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerSecurityContext =
    res:
    {
    }
    // optionalAttrs res."allowPrivilegeEscalation" { inherit (res) "allowPrivilegeEscalation"; }
    // {
    }
    // optionalAttrs (res."appArmorProfile" != null) {
      "appArmorProfile" =
        mkProviderKubernetesEnvoyDeploymentInitContainerSecurityContextAppArmorProfile
          res."appArmorProfile";
    }
    // {
    }
    // optionalAttrs (res."capabilities" != null) {
      "capabilities" =
        mkProviderKubernetesEnvoyDeploymentInitContainerSecurityContextCapabilities
          res."capabilities";
    }
    // {
    }
    // optionalAttrs res."privileged" { inherit (res) "privileged"; }
    // {
    }
    // optionalAttrs (res."procMount" != null) { inherit (res) "procMount"; }
    // {
    }
    // optionalAttrs res."readOnlyRootFilesystem" { inherit (res) "readOnlyRootFilesystem"; }
    // {
    }
    // optionalAttrs (res."runAsGroup" != null) { inherit (res) "runAsGroup"; }
    // {
    }
    // optionalAttrs res."runAsNonRoot" { inherit (res) "runAsNonRoot"; }
    // {
    }
    // optionalAttrs (res."runAsUser" != null) { inherit (res) "runAsUser"; }
    // {
    }
    // optionalAttrs (res."seLinuxOptions" != null) {
      "seLinuxOptions" =
        mkProviderKubernetesEnvoyDeploymentInitContainerSecurityContextSeLinuxOptions
          res."seLinuxOptions";
    }
    // {
    }
    // optionalAttrs (res."seccompProfile" != null) {
      "seccompProfile" =
        mkProviderKubernetesEnvoyDeploymentInitContainerSecurityContextSeccompProfile
          res."seccompProfile";
    }
    // {
    }
    // optionalAttrs (res."windowsOptions" != null) {
      "windowsOptions" =
        mkProviderKubernetesEnvoyDeploymentInitContainerSecurityContextWindowsOptions
          res."windowsOptions";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerSecurityContextSeLinuxOptionsModule =
    types.submodule
      {
        options = {
          "level" = mkOption {
            description = "Level is SELinux level label that applies to the container.";
            type = (types.nullOr types.str);
            default = null;
          };
          "role" = mkOption {
            description = "Role is a SELinux role label that applies to the container.";
            type = (types.nullOr types.str);
            default = null;
          };
          "type" = mkOption {
            description = "Type is a SELinux type label that applies to the container.";
            type = (types.nullOr types.str);
            default = null;
          };
          "user" = mkOption {
            description = "User is a SELinux user label that applies to the container.";
            type = (types.nullOr types.str);
            default = null;
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentInitContainerSecurityContextSeLinuxOptions =
    res:
    {
    }
    // optionalAttrs (res."level" != null) { inherit (res) "level"; }
    // {
    }
    // optionalAttrs (res."role" != null) { inherit (res) "role"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    }
    // optionalAttrs (res."user" != null) { inherit (res) "user"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerSecurityContextSeccompProfileModule =
    types.submodule
      {
        options = {
          "localhostProfile" = mkOption {
            description = "localhostProfile indicates a profile defined in a file on the node should be used.\nThe profile must be preconfigured on the node to work.\nMust be a descending path, relative to the kubelet's configured seccomp profile location.\nMust be set if type is \"Localhost\". Must NOT be set for any other type.";
            type = (types.nullOr types.str);
            default = null;
          };
          "type" = mkOption {
            description = "type indicates which kind of seccomp profile will be applied.\nValid options are:\n\nLocalhost - a profile defined in a file on the node should be used.\nRuntimeDefault - the container runtime default profile should be used.\nUnconfined - no profile should be applied.";
            type = types.str;
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentInitContainerSecurityContextSeccompProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  ProviderKubernetesEnvoyDeploymentInitContainerSecurityContextWindowsOptionsModule =
    types.submodule
      {
        options = {
          "gmsaCredentialSpec" = mkOption {
            description = "GMSACredentialSpec is where the GMSA admission webhook\n(https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the\nGMSA credential spec named by the GMSACredentialSpecName field.";
            type = (types.nullOr types.str);
            default = null;
          };
          "gmsaCredentialSpecName" = mkOption {
            description = "GMSACredentialSpecName is the name of the GMSA credential spec to use.";
            type = (types.nullOr types.str);
            default = null;
          };
          "hostProcess" = mkOption {
            description = "HostProcess determines if a container should be run as a 'Host Process' container.\nAll of a Pod's containers must have the same effective HostProcess value\n(it is not allowed to have a mix of HostProcess containers and non-HostProcess containers).\nIn addition, if HostProcess is true then HostNetwork must also be set to true.";
            type = types.bool;
            default = false;
          };
          "runAsUserName" = mkOption {
            description = "The UserName in Windows to run the entrypoint of the container process.\nDefaults to the user specified in image metadata if unspecified.\nMay also be set in PodSecurityContext. If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.";
            type = (types.nullOr types.str);
            default = null;
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentInitContainerSecurityContextWindowsOptions =
    res:
    {
    }
    // optionalAttrs (res."gmsaCredentialSpec" != null) { inherit (res) "gmsaCredentialSpec"; }
    // {
    }
    // optionalAttrs (res."gmsaCredentialSpecName" != null) { inherit (res) "gmsaCredentialSpecName"; }
    // {
    }
    // optionalAttrs res."hostProcess" { inherit (res) "hostProcess"; }
    // {
    }
    // optionalAttrs (res."runAsUserName" != null) { inherit (res) "runAsUserName"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerStartupProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerStartupProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerStartupProbeGrpcModule = types.submodule {
    options = {
      "port" = mkOption {
        description = "Port number of the gRPC service. Number must be in the range 1 to 65535.";
        type = types.int;
      };
      "service" = mkOption {
        description = "Service is the name of the service to place in the gRPC HealthCheckRequest\n(see https://github.com/grpc/grpc/blob/master/doc/health-checking.md).\n\nIf this is not specified, the default behavior is defined by gRPC.";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerStartupProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerStartupProbeHttpGetHttpHeaderModule =
    types.submodule
      {
        options = {
          "name" = mkOption {
            description = "The header field name.\nThis will be canonicalized upon output, so case-variant names will be understood as the same header.";
            type = types.str;
          };
          "value" = mkOption {
            description = "The header field value";
            type = types.str;
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentInitContainerStartupProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  ProviderKubernetesEnvoyDeploymentInitContainerStartupProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (
          types.listOf ProviderKubernetesEnvoyDeploymentInitContainerStartupProbeHttpGetHttpHeaderModule
        );
        default = [ ];
      };
      "path" = mkOption {
        description = "Path to access on the HTTP server.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Name or number of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
      "scheme" = mkOption {
        description = "Scheme to use for connecting to the host.\nDefaults to HTTP.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerStartupProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" =
        map mkProviderKubernetesEnvoyDeploymentInitContainerStartupProbeHttpGetHttpHeader
          res."httpHeaders";
    }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
      inherit (res) "port";
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerStartupProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerStartupProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        description = "Minimum consecutive failures for the probe to be considered failed after having succeeded.\nDefaults to 3. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        description = "GRPC specifies a GRPC HealthCheckRequest.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerStartupProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerStartupProbeHttpGetModule);
        default = null;
      };
      "initialDelaySeconds" = mkOption {
        description = "Number of seconds after the container has started before liveness probes are initiated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr types.int);
        default = null;
      };
      "periodSeconds" = mkOption {
        description = "How often (in seconds) to perform the probe.\nDefault to 10 seconds. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "successThreshold" = mkOption {
        description = "Minimum consecutive successes for the probe to be considered successful after having failed.\nDefaults to 1. Must be 1 for liveness and startup. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "tcpSocket" = mkOption {
        description = "TCPSocket specifies a connection to a TCP port.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentInitContainerStartupProbeTcpSocketModule);
        default = null;
      };
      "terminationGracePeriodSeconds" = mkOption {
        description = "Optional duration in seconds the pod needs to terminate gracefully upon probe failure.\nThe grace period is the duration in seconds after the processes running in the pod are sent\na termination signal and the time when the processes are forcibly halted with a kill signal.\nSet this value longer than the expected cleanup time for your process.\nIf this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this\nvalue overrides the value provided by the pod spec.\nValue must be non-negative integer. The value zero indicates stop immediately via\nthe kill signal (no opportunity to shut down).\nThis is a beta field and requires enabling ProbeTerminationGracePeriod feature gate.\nMinimum value is 1. spec.terminationGracePeriodSeconds is used if unset.";
        type = (types.nullOr types.int);
        default = null;
      };
      "timeoutSeconds" = mkOption {
        description = "Number of seconds after which the probe times out.\nDefaults to 1 second. Minimum value is 1.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerStartupProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkProviderKubernetesEnvoyDeploymentInitContainerStartupProbeExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkProviderKubernetesEnvoyDeploymentInitContainerStartupProbeGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkProviderKubernetesEnvoyDeploymentInitContainerStartupProbeHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."initialDelaySeconds" != null) { inherit (res) "initialDelaySeconds"; }
    // {
    }
    // optionalAttrs (res."periodSeconds" != null) { inherit (res) "periodSeconds"; }
    // {
    }
    // optionalAttrs (res."successThreshold" != null) { inherit (res) "successThreshold"; }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" = mkProviderKubernetesEnvoyDeploymentInitContainerStartupProbeTcpSocket res."tcpSocket";
    }
    // {
    }
    // optionalAttrs (res."terminationGracePeriodSeconds" != null) {
      inherit (res) "terminationGracePeriodSeconds";
    }
    // {
    }
    // optionalAttrs (res."timeoutSeconds" != null) { inherit (res) "timeoutSeconds"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentInitContainerStartupProbeTcpSocketModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Optional: Host name to connect to, defaults to the pod IP.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Number or name of the port to access on the container.\nNumber must be in the range 1 to 65535.\nName must be an IANA_SVC_NAME.";
        type = types.anything;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerStartupProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  ProviderKubernetesEnvoyDeploymentInitContainerVolumeDeviceModule = types.submodule {
    options = {
      "devicePath" = mkOption {
        description = "devicePath is the path inside of the container that the device will be mapped to.";
        type = types.str;
      };
      "name" = mkOption {
        description = "name must match the name of a persistentVolumeClaim in the pod";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerVolumeDevice = res: {
    inherit (res) "devicePath";
    inherit (res) "name";
  };
  ProviderKubernetesEnvoyDeploymentInitContainerVolumeMountModule = types.submodule {
    options = {
      "mountPath" = mkOption {
        description = "Path within the container at which the volume should be mounted.  Must\nnot contain ':'.";
        type = types.str;
      };
      "mountPropagation" = mkOption {
        description = "mountPropagation determines how mounts are propagated from the host\nto container and the other way around.\nWhen not set, MountPropagationNone is used.\nThis field is beta in 1.10.\nWhen RecursiveReadOnly is set to IfPossible or to Enabled, MountPropagation must be None or unspecified\n(which defaults to None).";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "This must match the Name of a Volume.";
        type = types.str;
      };
      "readOnly" = mkOption {
        description = "Mounted read-only if true, read-write otherwise (false or unspecified).\nDefaults to false.";
        type = types.bool;
        default = false;
      };
      "recursiveReadOnly" = mkOption {
        description = "RecursiveReadOnly specifies whether read-only mounts should be handled\nrecursively.\n\nIf ReadOnly is false, this field has no meaning and must be unspecified.\n\nIf ReadOnly is true, and this field is set to Disabled, the mount is not made\nrecursively read-only.  If this field is set to IfPossible, the mount is made\nrecursively read-only, if it is supported by the container runtime.  If this\nfield is set to Enabled, the mount is made recursively read-only if it is\nsupported by the container runtime, otherwise the pod will not be started and\nan error will be generated to indicate the reason.\n\nIf this field is set to IfPossible or Enabled, MountPropagation must be set to\nNone (or be unspecified, which defaults to None).\n\nIf this field is not specified, it is treated as an equivalent of Disabled.";
        type = (types.nullOr types.str);
        default = null;
      };
      "subPath" = mkOption {
        description = "Path within the volume from which the container's volume should be mounted.\nDefaults to \"\" (volume's root).";
        type = (types.nullOr types.str);
        default = null;
      };
      "subPathExpr" = mkOption {
        description = "Expanded path within the volume from which the container's volume should be mounted.\nBehaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment.\nDefaults to \"\" (volume's root).\nSubPathExpr and SubPath are mutually exclusive.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentInitContainerVolumeMount =
    res:
    {
      inherit (res) "mountPath";
    }
    // optionalAttrs (res."mountPropagation" != null) { inherit (res) "mountPropagation"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."recursiveReadOnly" != null) { inherit (res) "recursiveReadOnly"; }
    // {
    }
    // optionalAttrs (res."subPath" != null) { inherit (res) "subPath"; }
    // {
    }
    // optionalAttrs (res."subPathExpr" != null) { inherit (res) "subPathExpr"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentModule = types.submodule {
    options = {
      "container" = mkOption {
        description = "Container defines the desired specification of main container.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentContainerModule);
        default = null;
      };
      "initContainers" = mkOption {
        description = "List of initialization containers belonging to the pod.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/";
        type = (types.listOf ProviderKubernetesEnvoyDeploymentInitContainerModule);
        default = [ ];
      };
      "name" = mkOption {
        description = "Name of the deployment.\nWhen unset, this defaults to an autogenerated name.";
        type = (types.nullOr types.str);
        default = null;
      };
      "patch" = mkOption {
        description = "Patch defines how to perform the patch operation to deployment";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPatchModule);
        default = null;
      };
      "pod" = mkOption {
        description = "Pod defines the desired specification of pod.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodModule);
        default = null;
      };
      "replicas" = mkOption {
        description = "Replicas is the number of desired pods. Defaults to 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "strategy" = mkOption {
        description = "The deployment strategy to use to replace existing pods with new ones.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentStrategyModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeployment =
    res:
    {
    }
    // optionalAttrs (res."container" != null) {
      "container" = mkProviderKubernetesEnvoyDeploymentContainer res."container";
    }
    // {
    }
    // optionalAttrs (res."initContainers" != [ ]) {
      "initContainers" = map mkProviderKubernetesEnvoyDeploymentInitContainer res."initContainers";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."patch" != null) {
      "patch" = mkProviderKubernetesEnvoyDeploymentPatch res."patch";
    }
    // {
    }
    // optionalAttrs (res."pod" != null) { "pod" = mkProviderKubernetesEnvoyDeploymentPod res."pod"; }
    // {
    }
    // optionalAttrs (res."replicas" != null) { inherit (res) "replicas"; }
    // {
    }
    // optionalAttrs (res."strategy" != null) {
      "strategy" = mkProviderKubernetesEnvoyDeploymentStrategy res."strategy";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPatchModule = types.submodule {
    options = {
      "type" = mkOption {
        description = "Type is the type of merge operation to perform\n\nBy default, StrategicMerge is used as the patch type.";
        type = (types.nullOr types.str);
        default = null;
      };
      "value" = mkOption {
        description = "Object contains the raw configuration for merged object";
        type = types.anything;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPatch =
    res:
    {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
      inherit (res) "value";
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityModule = types.submodule {
    options = {
      "nodeAffinity" = mkOption {
        description = "Describes node affinity scheduling rules for the pod.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityModule);
        default = null;
      };
      "podAffinity" = mkOption {
        description = "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s)).";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityModule);
        default = null;
      };
      "podAntiAffinity" = mkOption {
        description = "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s)).";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodAffinity =
    res:
    {
    }
    // optionalAttrs (res."nodeAffinity" != null) {
      "nodeAffinity" = mkProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinity res."nodeAffinity";
    }
    // {
    }
    // optionalAttrs (res."podAffinity" != null) {
      "podAffinity" = mkProviderKubernetesEnvoyDeploymentPodAffinityPodAffinity res."podAffinity";
    }
    // {
    }
    // optionalAttrs (res."podAntiAffinity" != null) {
      "podAntiAffinity" =
        mkProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinity
          res."podAntiAffinity";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityModule = types.submodule {
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy\nthe affinity expressions specified by this field, but it may choose\na node that violates one or more of the expressions. The node that is\nmost preferred is the one with the greatest sum of weights, i.e.\nfor each node that meets all of the scheduling requirements (resource\nrequest, requiredDuringScheduling affinity expressions, etc.),\ncompute a sum by iterating through the elements of this field and adding\n\"weight\" to the sum if the node matches the corresponding matchExpressions; the\nnode(s) with the highest sum are the most preferred.";
        type = (
          types.listOf ProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the affinity requirements specified by this field are not met at\nscheduling time, the pod will not be scheduled onto the node.\nIf the affinity requirements specified by this field cease to be met\nat some point during pod execution (e.g. due to an update), the system\nmay or may not try to eventually evict the pod from its node.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinity =
    res:
    {
    }
    // optionalAttrs (res."preferredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "preferredDuringSchedulingIgnoredDuringExecution" =
        map
          mkProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecution
          res."preferredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    }
    // optionalAttrs (res."requiredDuringSchedulingIgnoredDuringExecution" != null) {
      "requiredDuringSchedulingIgnoredDuringExecution" =
        mkProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecution
          res."requiredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "preference" = mkOption {
            description = "A node selector term, associated with the corresponding weight.";
            type =
              ProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceModule;
          };
          "weight" = mkOption {
            description = "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100.";
            type = types.int;
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecution =
    res: {
      "preference" =
        mkProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreference
          res."preference";
      inherit (res) "weight";
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            description = "The label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "Represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.";
            type = types.str;
          };
          "values" = mkOption {
            description = "An array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. If the operator is Gt or Lt, the values\narray must have a single element, which will be interpreted as an integer.\nThis array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchFieldModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            description = "The label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "Represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.";
            type = types.str;
          };
          "values" = mkOption {
            description = "An array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. If the operator is Gt or Lt, the values\narray must have a single element, which will be interpreted as an integer.\nThis array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchField =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "A list of node selector requirements by node's labels.";
            type = (
              types.listOf ProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpressionModule
            );
            default = [ ];
          };
          "matchFields" = mkOption {
            description = "A list of node selector requirements by node's fields.";
            type = (
              types.listOf ProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchFieldModule
            );
            default = [ ];
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreference =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchFields" != [ ]) {
      "matchFields" =
        map
          mkProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchField
          res."matchFields";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "nodeSelectorTerms" = mkOption {
            description = "Required. A list of node selector terms. The terms are ORed.";
            type = (
              types.listOf ProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermModule
            );
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecution =
    res: {
      "nodeSelectorTerms" =
        map
          mkProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTerm
          res."nodeSelectorTerms";
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            description = "The label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "Represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.";
            type = types.str;
          };
          "values" = mkOption {
            description = "An array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. If the operator is Gt or Lt, the values\narray must have a single element, which will be interpreted as an integer.\nThis array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchFieldModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            description = "The label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "Represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.";
            type = types.str;
          };
          "values" = mkOption {
            description = "An array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. If the operator is Gt or Lt, the values\narray must have a single element, which will be interpreted as an integer.\nThis array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchField =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "A list of node selector requirements by node's labels.";
            type = (
              types.listOf ProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpressionModule
            );
            default = [ ];
          };
          "matchFields" = mkOption {
            description = "A list of node selector requirements by node's fields.";
            type = (
              types.listOf ProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchFieldModule
            );
            default = [ ];
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTerm =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchFields" != [ ]) {
      "matchFields" =
        map
          mkProviderKubernetesEnvoyDeploymentPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchField
          res."matchFields";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityModule = types.submodule {
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy\nthe affinity expressions specified by this field, but it may choose\na node that violates one or more of the expressions. The node that is\nmost preferred is the one with the greatest sum of weights, i.e.\nfor each node that meets all of the scheduling requirements (resource\nrequest, requiredDuringScheduling affinity expressions, etc.),\ncompute a sum by iterating through the elements of this field and adding\n\"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the\nnode(s) with the highest sum are the most preferred.";
        type = (
          types.listOf ProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the affinity requirements specified by this field are not met at\nscheduling time, the pod will not be scheduled onto the node.\nIf the affinity requirements specified by this field cease to be met\nat some point during pod execution (e.g. due to a pod label update), the\nsystem may or may not try to eventually evict the pod from its node.\nWhen there are multiple elements, the lists of nodes corresponding to each\npodAffinityTerm are intersected, i.e. all terms must be satisfied.";
        type = (
          types.listOf ProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodAffinityPodAffinity =
    res:
    {
    }
    // optionalAttrs (res."preferredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "preferredDuringSchedulingIgnoredDuringExecution" =
        map
          mkProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecution
          res."preferredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    }
    // optionalAttrs (res."requiredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "requiredDuringSchedulingIgnoredDuringExecution" =
        map
          mkProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecution
          res."requiredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "podAffinityTerm" = mkOption {
            description = "Required. A pod affinity term, associated with the corresponding weight.";
            type =
              ProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule;
          };
          "weight" = mkOption {
            description = "weight associated with matching the corresponding podAffinityTerm,\nin the range 1-100.";
            type = types.int;
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecution =
    res: {
      "podAffinityTerm" =
        mkProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm
          res."podAffinityTerm";
      inherit (res) "weight";
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.\nIf it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr ProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule
            );
            default = null;
          };
          "matchLabelKeys" = mkOption {
            description = "MatchLabelKeys is a set of pod label keys to select which pods will\nbe taken into consideration. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are merged with `labelSelector` as `key in (value)`\nto select the group of existing pods which pods will be taken into consideration\nfor the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming\npod labels will be ignored. The default value is empty.\nThe same key is forbidden to exist in both matchLabelKeys and labelSelector.\nAlso, matchLabelKeys cannot be set when labelSelector isn't set.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "mismatchLabelKeys" = mkOption {
            description = "MismatchLabelKeys is a set of pod label keys to select which pods will\nbe taken into consideration. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are merged with `labelSelector` as `key notin (value)`\nto select the group of existing pods which pods will be taken into consideration\nfor the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming\npod labels will be ignored. The default value is empty.\nThe same key is forbidden to exist in both mismatchLabelKeys and labelSelector.\nAlso, mismatchLabelKeys cannot be set when labelSelector isn't set.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to.\nThe term is applied to the union of the namespaces selected by this field\nand the ones listed in the namespaces field.\nnull selector and null or empty namespaces list means \"this pod's namespace\".\nAn empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr ProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule
            );
            default = null;
          };
          "namespaces" = mkOption {
            description = "namespaces specifies a static list of namespace names that the term applies to.\nThe term is applied to the union of the namespaces listed in this field\nand the ones selected by namespaceSelector.\nnull or empty namespaces list and null namespaceSelector means \"this pod's namespace\".";
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            description = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching\nthe labelSelector in the specified namespaces, where co-located is defined as running on a node\nwhose value of the label with key topologyKey matches that of any node on which any of the\nselected pods is running.\nEmpty topologyKey is not allowed.";
            type = types.str;
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."matchLabelKeys" != [ ]) { inherit (res) "matchLabelKeys"; }
    // {
    }
    // optionalAttrs (res."mismatchLabelKeys" != [ ]) { inherit (res) "mismatchLabelKeys"; }
    // {
    }
    // optionalAttrs (res."namespaceSelector" != null) {
      "namespaceSelector" =
        mkProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.\nIf it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr ProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule
            );
            default = null;
          };
          "matchLabelKeys" = mkOption {
            description = "MatchLabelKeys is a set of pod label keys to select which pods will\nbe taken into consideration. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are merged with `labelSelector` as `key in (value)`\nto select the group of existing pods which pods will be taken into consideration\nfor the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming\npod labels will be ignored. The default value is empty.\nThe same key is forbidden to exist in both matchLabelKeys and labelSelector.\nAlso, matchLabelKeys cannot be set when labelSelector isn't set.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "mismatchLabelKeys" = mkOption {
            description = "MismatchLabelKeys is a set of pod label keys to select which pods will\nbe taken into consideration. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are merged with `labelSelector` as `key notin (value)`\nto select the group of existing pods which pods will be taken into consideration\nfor the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming\npod labels will be ignored. The default value is empty.\nThe same key is forbidden to exist in both mismatchLabelKeys and labelSelector.\nAlso, mismatchLabelKeys cannot be set when labelSelector isn't set.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to.\nThe term is applied to the union of the namespaces selected by this field\nand the ones listed in the namespaces field.\nnull selector and null or empty namespaces list means \"this pod's namespace\".\nAn empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr ProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule
            );
            default = null;
          };
          "namespaces" = mkOption {
            description = "namespaces specifies a static list of namespace names that the term applies to.\nThe term is applied to the union of the namespaces listed in this field\nand the ones selected by namespaceSelector.\nnull or empty namespaces list and null namespaceSelector means \"this pod's namespace\".";
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            description = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching\nthe labelSelector in the specified namespaces, where co-located is defined as running on a node\nwhose value of the label with key topologyKey matches that of any node on which any of the\nselected pods is running.\nEmpty topologyKey is not allowed.";
            type = types.str;
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecution =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."matchLabelKeys" != [ ]) { inherit (res) "matchLabelKeys"; }
    // {
    }
    // optionalAttrs (res."mismatchLabelKeys" != [ ]) { inherit (res) "mismatchLabelKeys"; }
    // {
    }
    // optionalAttrs (res."namespaceSelector" != null) {
      "namespaceSelector" =
        mkProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkProviderKubernetesEnvoyDeploymentPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityModule = types.submodule {
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy\nthe anti-affinity expressions specified by this field, but it may choose\na node that violates one or more of the expressions. The node that is\nmost preferred is the one with the greatest sum of weights, i.e.\nfor each node that meets all of the scheduling requirements (resource\nrequest, requiredDuringScheduling anti-affinity expressions, etc.),\ncompute a sum by iterating through the elements of this field and adding\n\"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the\nnode(s) with the highest sum are the most preferred.";
        type = (
          types.listOf ProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the anti-affinity requirements specified by this field are not met at\nscheduling time, the pod will not be scheduled onto the node.\nIf the anti-affinity requirements specified by this field cease to be met\nat some point during pod execution (e.g. due to a pod label update), the\nsystem may or may not try to eventually evict the pod from its node.\nWhen there are multiple elements, the lists of nodes corresponding to each\npodAffinityTerm are intersected, i.e. all terms must be satisfied.";
        type = (
          types.listOf ProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinity =
    res:
    {
    }
    // optionalAttrs (res."preferredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "preferredDuringSchedulingIgnoredDuringExecution" =
        map
          mkProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecution
          res."preferredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    }
    // optionalAttrs (res."requiredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "requiredDuringSchedulingIgnoredDuringExecution" =
        map
          mkProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecution
          res."requiredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "podAffinityTerm" = mkOption {
            description = "Required. A pod affinity term, associated with the corresponding weight.";
            type =
              ProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule;
          };
          "weight" = mkOption {
            description = "weight associated with matching the corresponding podAffinityTerm,\nin the range 1-100.";
            type = types.int;
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecution =
    res: {
      "podAffinityTerm" =
        mkProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm
          res."podAffinityTerm";
      inherit (res) "weight";
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.\nIf it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr ProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule
            );
            default = null;
          };
          "matchLabelKeys" = mkOption {
            description = "MatchLabelKeys is a set of pod label keys to select which pods will\nbe taken into consideration. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are merged with `labelSelector` as `key in (value)`\nto select the group of existing pods which pods will be taken into consideration\nfor the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming\npod labels will be ignored. The default value is empty.\nThe same key is forbidden to exist in both matchLabelKeys and labelSelector.\nAlso, matchLabelKeys cannot be set when labelSelector isn't set.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "mismatchLabelKeys" = mkOption {
            description = "MismatchLabelKeys is a set of pod label keys to select which pods will\nbe taken into consideration. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are merged with `labelSelector` as `key notin (value)`\nto select the group of existing pods which pods will be taken into consideration\nfor the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming\npod labels will be ignored. The default value is empty.\nThe same key is forbidden to exist in both mismatchLabelKeys and labelSelector.\nAlso, mismatchLabelKeys cannot be set when labelSelector isn't set.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to.\nThe term is applied to the union of the namespaces selected by this field\nand the ones listed in the namespaces field.\nnull selector and null or empty namespaces list means \"this pod's namespace\".\nAn empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr ProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule
            );
            default = null;
          };
          "namespaces" = mkOption {
            description = "namespaces specifies a static list of namespace names that the term applies to.\nThe term is applied to the union of the namespaces listed in this field\nand the ones selected by namespaceSelector.\nnull or empty namespaces list and null namespaceSelector means \"this pod's namespace\".";
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            description = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching\nthe labelSelector in the specified namespaces, where co-located is defined as running on a node\nwhose value of the label with key topologyKey matches that of any node on which any of the\nselected pods is running.\nEmpty topologyKey is not allowed.";
            type = types.str;
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."matchLabelKeys" != [ ]) { inherit (res) "matchLabelKeys"; }
    // {
    }
    // optionalAttrs (res."mismatchLabelKeys" != [ ]) { inherit (res) "mismatchLabelKeys"; }
    // {
    }
    // optionalAttrs (res."namespaceSelector" != null) {
      "namespaceSelector" =
        mkProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.\nIf it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr ProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule
            );
            default = null;
          };
          "matchLabelKeys" = mkOption {
            description = "MatchLabelKeys is a set of pod label keys to select which pods will\nbe taken into consideration. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are merged with `labelSelector` as `key in (value)`\nto select the group of existing pods which pods will be taken into consideration\nfor the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming\npod labels will be ignored. The default value is empty.\nThe same key is forbidden to exist in both matchLabelKeys and labelSelector.\nAlso, matchLabelKeys cannot be set when labelSelector isn't set.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "mismatchLabelKeys" = mkOption {
            description = "MismatchLabelKeys is a set of pod label keys to select which pods will\nbe taken into consideration. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are merged with `labelSelector` as `key notin (value)`\nto select the group of existing pods which pods will be taken into consideration\nfor the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming\npod labels will be ignored. The default value is empty.\nThe same key is forbidden to exist in both mismatchLabelKeys and labelSelector.\nAlso, mismatchLabelKeys cannot be set when labelSelector isn't set.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to.\nThe term is applied to the union of the namespaces selected by this field\nand the ones listed in the namespaces field.\nnull selector and null or empty namespaces list means \"this pod's namespace\".\nAn empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr ProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule
            );
            default = null;
          };
          "namespaces" = mkOption {
            description = "namespaces specifies a static list of namespace names that the term applies to.\nThe term is applied to the union of the namespaces listed in this field\nand the ones selected by namespaceSelector.\nnull or empty namespaces list and null namespaceSelector means \"this pod's namespace\".";
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            description = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching\nthe labelSelector in the specified namespaces, where co-located is defined as running on a node\nwhose value of the label with key topologyKey matches that of any node on which any of the\nselected pods is running.\nEmpty topologyKey is not allowed.";
            type = types.str;
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecution =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."matchLabelKeys" != [ ]) { inherit (res) "matchLabelKeys"; }
    // {
    }
    // optionalAttrs (res."mismatchLabelKeys" != [ ]) { inherit (res) "mismatchLabelKeys"; }
    // {
    }
    // optionalAttrs (res."namespaceSelector" != null) {
      "namespaceSelector" =
        mkProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkProviderKubernetesEnvoyDeploymentPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodImagePullSecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodImagePullSecret =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodModule = types.submodule {
    options = {
      "affinity" = mkOption {
        description = "If specified, the pod's scheduling constraints.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodAffinityModule);
        default = null;
      };
      "annotations" = mkOption {
        description = "Annotations are the annotations that should be appended to the pods.\nBy default, no pod annotations are appended.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "imagePullSecrets" = mkOption {
        description = "ImagePullSecrets is an optional list of references to secrets\nin the same namespace to use for pulling any of the images used by this PodSpec.\nIf specified, these secrets will be passed to individual puller implementations for them to use.\nMore info: https://kubernetes.io/docs/concepts/containers/images#specifying-imagepullsecrets-on-a-pod";
        type = (types.listOf ProviderKubernetesEnvoyDeploymentPodImagePullSecretModule);
        default = [ ];
      };
      "labels" = mkOption {
        description = "Labels are the additional labels that should be tagged to the pods.\nBy default, no additional pod labels are tagged.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "nodeSelector" = mkOption {
        description = "NodeSelector is a selector which must be true for the pod to fit on a node.\nSelector which must match a node's labels for the pod to be scheduled on that node.\nMore info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/";
        type = (types.attrsOf types.str);
        default = { };
      };
      "securityContext" = mkOption {
        description = "SecurityContext holds pod-level security attributes and common container settings.\nOptional: Defaults to empty.  See type description for default values of each field.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodSecurityContextModule);
        default = null;
      };
      "tolerations" = mkOption {
        description = "If specified, the pod's tolerations.";
        type = (types.listOf ProviderKubernetesEnvoyDeploymentPodTolerationModule);
        default = [ ];
      };
      "topologySpreadConstraints" = mkOption {
        description = "TopologySpreadConstraints describes how a group of pods ought to spread across topology\ndomains. Scheduler will schedule pods in a way which abides by the constraints.\nAll topologySpreadConstraints are ANDed.";
        type = (types.listOf ProviderKubernetesEnvoyDeploymentPodTopologySpreadConstraintModule);
        default = [ ];
      };
      "volumes" = mkOption {
        description = "Volumes that can be mounted by containers belonging to the pod.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes";
        type = (types.listOf ProviderKubernetesEnvoyDeploymentPodVolumeModule);
        default = [ ];
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPod =
    res:
    {
    }
    // optionalAttrs (res."affinity" != null) {
      "affinity" = mkProviderKubernetesEnvoyDeploymentPodAffinity res."affinity";
    }
    // {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."imagePullSecrets" != [ ]) {
      "imagePullSecrets" =
        map mkProviderKubernetesEnvoyDeploymentPodImagePullSecret
          res."imagePullSecrets";
    }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."nodeSelector" != { }) { inherit (res) "nodeSelector"; }
    // {
    }
    // optionalAttrs (res."securityContext" != null) {
      "securityContext" = mkProviderKubernetesEnvoyDeploymentPodSecurityContext res."securityContext";
    }
    // {
    }
    // optionalAttrs (res."tolerations" != [ ]) {
      "tolerations" = map mkProviderKubernetesEnvoyDeploymentPodToleration res."tolerations";
    }
    // {
    }
    // optionalAttrs (res."topologySpreadConstraints" != [ ]) {
      "topologySpreadConstraints" =
        map mkProviderKubernetesEnvoyDeploymentPodTopologySpreadConstraint
          res."topologySpreadConstraints";
    }
    // {
    }
    // optionalAttrs (res."volumes" != [ ]) {
      "volumes" = map mkProviderKubernetesEnvoyDeploymentPodVolume res."volumes";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodSecurityContextAppArmorProfileModule = types.submodule {
    options = {
      "localhostProfile" = mkOption {
        description = "localhostProfile indicates a profile loaded on the node that should be used.\nThe profile must be preconfigured on the node to work.\nMust match the loaded name of the profile.\nMust be set if and only if type is \"Localhost\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "type indicates which kind of AppArmor profile will be applied.\nValid options are:\n  Localhost - a profile pre-loaded on the node.\n  RuntimeDefault - the container runtime's default profile.\n  Unconfined - no AppArmor enforcement.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodSecurityContextAppArmorProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  ProviderKubernetesEnvoyDeploymentPodSecurityContextModule = types.submodule {
    options = {
      "appArmorProfile" = mkOption {
        description = "appArmorProfile is the AppArmor options to use by the containers in this pod.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodSecurityContextAppArmorProfileModule);
        default = null;
      };
      "fsGroup" = mkOption {
        description = "A special supplemental group that applies to all containers in a pod.\nSome volume types allow the Kubelet to change the ownership of that volume\nto be owned by the pod:\n\n1. The owning GID will be the FSGroup\n2. The setgid bit is set (new files created in the volume will be owned by FSGroup)\n3. The permission bits are OR'd with rw-rw----\n\nIf unset, the Kubelet will not modify the ownership and permissions of any volume.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.int);
        default = null;
      };
      "fsGroupChangePolicy" = mkOption {
        description = "fsGroupChangePolicy defines behavior of changing ownership and permission of the volume\nbefore being exposed inside Pod. This field will only apply to\nvolume types which support fsGroup based ownership(and permissions).\nIt will have no effect on ephemeral volume types such as: secret, configmaps\nand emptydir.\nValid values are \"OnRootMismatch\" and \"Always\". If not specified, \"Always\" is used.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.str);
        default = null;
      };
      "runAsGroup" = mkOption {
        description = "The GID to run the entrypoint of the container process.\nUses runtime default if unset.\nMay also be set in SecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence\nfor that container.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.int);
        default = null;
      };
      "runAsNonRoot" = mkOption {
        description = "Indicates that the container must run as a non-root user.\nIf true, the Kubelet will validate the image at runtime to ensure that it\ndoes not run as UID 0 (root) and fail to start the container if it does.\nIf unset or false, no such validation will be performed.\nMay also be set in SecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.";
        type = types.bool;
        default = false;
      };
      "runAsUser" = mkOption {
        description = "The UID to run the entrypoint of the container process.\nDefaults to user specified in image metadata if unspecified.\nMay also be set in SecurityContext.  If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence\nfor that container.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.int);
        default = null;
      };
      "seLinuxChangePolicy" = mkOption {
        description = "seLinuxChangePolicy defines how the container's SELinux label is applied to all volumes used by the Pod.\nIt has no effect on nodes that do not support SELinux or to volumes does not support SELinux.\nValid values are \"MountOption\" and \"Recursive\".\n\n\"Recursive\" means relabeling of all files on all Pod volumes by the container runtime.\nThis may be slow for large volumes, but allows mixing privileged and unprivileged Pods sharing the same volume on the same node.\n\n\"MountOption\" mounts all eligible Pod volumes with `-o context` mount option.\nThis requires all Pods that share the same volume to use the same SELinux label.\nIt is not possible to share the same volume among privileged and unprivileged Pods.\nEligible volumes are in-tree FibreChannel and iSCSI volumes, and all CSI volumes\nwhose CSI driver announces SELinux support by setting spec.seLinuxMount: true in their\nCSIDriver instance. Other volumes are always re-labelled recursively.\n\"MountOption\" value is allowed only when SELinuxMount feature gate is enabled.\n\nIf not specified and SELinuxMount feature gate is enabled, \"MountOption\" is used.\nIf not specified and SELinuxMount feature gate is disabled, \"MountOption\" is used for ReadWriteOncePod volumes\nand \"Recursive\" for all other volumes.\n\nThis field affects only Pods that have SELinux label set, either in PodSecurityContext or in SecurityContext of all containers.\n\nAll Pods that use the same volume should use the same seLinuxChangePolicy, otherwise some pods can get stuck in ContainerCreating state.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.str);
        default = null;
      };
      "seLinuxOptions" = mkOption {
        description = "The SELinux context to be applied to all containers.\nIf unspecified, the container runtime will allocate a random SELinux context for each\ncontainer.  May also be set in SecurityContext.  If set in\nboth SecurityContext and PodSecurityContext, the value specified in SecurityContext\ntakes precedence for that container.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodSecurityContextSeLinuxOptionsModule);
        default = null;
      };
      "seccompProfile" = mkOption {
        description = "The seccomp options to use by the containers in this pod.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodSecurityContextSeccompProfileModule);
        default = null;
      };
      "supplementalGroups" = mkOption {
        description = "A list of groups applied to the first process run in each container, in\naddition to the container's primary GID and fsGroup (if specified).  If\nthe SupplementalGroupsPolicy feature is enabled, the\nsupplementalGroupsPolicy field determines whether these are in addition\nto or instead of any group memberships defined in the container image.\nIf unspecified, no additional groups are added, though group memberships\ndefined in the container image may still be used, depending on the\nsupplementalGroupsPolicy field.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.listOf types.int);
        default = [ ];
      };
      "supplementalGroupsPolicy" = mkOption {
        description = "Defines how supplemental groups of the first container processes are calculated.\nValid values are \"Merge\" and \"Strict\". If not specified, \"Merge\" is used.\n(Alpha) Using the field requires the SupplementalGroupsPolicy feature gate to be enabled\nand the container runtime must implement support for this feature.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr types.str);
        default = null;
      };
      "sysctls" = mkOption {
        description = "Sysctls hold a list of namespaced sysctls used for the pod. Pods with unsupported\nsysctls (by the container runtime) might fail to launch.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.listOf ProviderKubernetesEnvoyDeploymentPodSecurityContextSysctlModule);
        default = [ ];
      };
      "windowsOptions" = mkOption {
        description = "The Windows specific settings applied to all containers.\nIf unspecified, the options within a container's SecurityContext will be used.\nIf set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is linux.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodSecurityContextWindowsOptionsModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodSecurityContext =
    res:
    {
    }
    // optionalAttrs (res."appArmorProfile" != null) {
      "appArmorProfile" =
        mkProviderKubernetesEnvoyDeploymentPodSecurityContextAppArmorProfile
          res."appArmorProfile";
    }
    // {
    }
    // optionalAttrs (res."fsGroup" != null) { inherit (res) "fsGroup"; }
    // {
    }
    // optionalAttrs (res."fsGroupChangePolicy" != null) { inherit (res) "fsGroupChangePolicy"; }
    // {
    }
    // optionalAttrs (res."runAsGroup" != null) { inherit (res) "runAsGroup"; }
    // {
    }
    // optionalAttrs res."runAsNonRoot" { inherit (res) "runAsNonRoot"; }
    // {
    }
    // optionalAttrs (res."runAsUser" != null) { inherit (res) "runAsUser"; }
    // {
    }
    // optionalAttrs (res."seLinuxChangePolicy" != null) { inherit (res) "seLinuxChangePolicy"; }
    // {
    }
    // optionalAttrs (res."seLinuxOptions" != null) {
      "seLinuxOptions" =
        mkProviderKubernetesEnvoyDeploymentPodSecurityContextSeLinuxOptions
          res."seLinuxOptions";
    }
    // {
    }
    // optionalAttrs (res."seccompProfile" != null) {
      "seccompProfile" =
        mkProviderKubernetesEnvoyDeploymentPodSecurityContextSeccompProfile
          res."seccompProfile";
    }
    // {
    }
    // optionalAttrs (res."supplementalGroups" != [ ]) { inherit (res) "supplementalGroups"; }
    // {
    }
    // optionalAttrs (res."supplementalGroupsPolicy" != null) {
      inherit (res) "supplementalGroupsPolicy";
    }
    // {
    }
    // optionalAttrs (res."sysctls" != [ ]) {
      "sysctls" = map mkProviderKubernetesEnvoyDeploymentPodSecurityContextSysctl res."sysctls";
    }
    // {
    }
    // optionalAttrs (res."windowsOptions" != null) {
      "windowsOptions" =
        mkProviderKubernetesEnvoyDeploymentPodSecurityContextWindowsOptions
          res."windowsOptions";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodSecurityContextSeLinuxOptionsModule = types.submodule {
    options = {
      "level" = mkOption {
        description = "Level is SELinux level label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
      "role" = mkOption {
        description = "Role is a SELinux role label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Type is a SELinux type label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
      "user" = mkOption {
        description = "User is a SELinux user label that applies to the container.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodSecurityContextSeLinuxOptions =
    res:
    {
    }
    // optionalAttrs (res."level" != null) { inherit (res) "level"; }
    // {
    }
    // optionalAttrs (res."role" != null) { inherit (res) "role"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    }
    // optionalAttrs (res."user" != null) { inherit (res) "user"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodSecurityContextSeccompProfileModule = types.submodule {
    options = {
      "localhostProfile" = mkOption {
        description = "localhostProfile indicates a profile defined in a file on the node should be used.\nThe profile must be preconfigured on the node to work.\nMust be a descending path, relative to the kubelet's configured seccomp profile location.\nMust be set if type is \"Localhost\". Must NOT be set for any other type.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "type indicates which kind of seccomp profile will be applied.\nValid options are:\n\nLocalhost - a profile defined in a file on the node should be used.\nRuntimeDefault - the container runtime default profile should be used.\nUnconfined - no profile should be applied.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodSecurityContextSeccompProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  ProviderKubernetesEnvoyDeploymentPodSecurityContextSysctlModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of a property to set";
        type = types.str;
      };
      "value" = mkOption {
        description = "Value of a property to set";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodSecurityContextSysctl = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  ProviderKubernetesEnvoyDeploymentPodSecurityContextWindowsOptionsModule = types.submodule {
    options = {
      "gmsaCredentialSpec" = mkOption {
        description = "GMSACredentialSpec is where the GMSA admission webhook\n(https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the\nGMSA credential spec named by the GMSACredentialSpecName field.";
        type = (types.nullOr types.str);
        default = null;
      };
      "gmsaCredentialSpecName" = mkOption {
        description = "GMSACredentialSpecName is the name of the GMSA credential spec to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "hostProcess" = mkOption {
        description = "HostProcess determines if a container should be run as a 'Host Process' container.\nAll of a Pod's containers must have the same effective HostProcess value\n(it is not allowed to have a mix of HostProcess containers and non-HostProcess containers).\nIn addition, if HostProcess is true then HostNetwork must also be set to true.";
        type = types.bool;
        default = false;
      };
      "runAsUserName" = mkOption {
        description = "The UserName in Windows to run the entrypoint of the container process.\nDefaults to the user specified in image metadata if unspecified.\nMay also be set in PodSecurityContext. If set in both SecurityContext and\nPodSecurityContext, the value specified in SecurityContext takes precedence.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodSecurityContextWindowsOptions =
    res:
    {
    }
    // optionalAttrs (res."gmsaCredentialSpec" != null) { inherit (res) "gmsaCredentialSpec"; }
    // {
    }
    // optionalAttrs (res."gmsaCredentialSpecName" != null) { inherit (res) "gmsaCredentialSpecName"; }
    // {
    }
    // optionalAttrs res."hostProcess" { inherit (res) "hostProcess"; }
    // {
    }
    // optionalAttrs (res."runAsUserName" != null) { inherit (res) "runAsUserName"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodTolerationModule = types.submodule {
    options = {
      "effect" = mkOption {
        description = "Effect indicates the taint effect to match. Empty means match all taint effects.\nWhen specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute.";
        type = (types.nullOr types.str);
        default = null;
      };
      "key" = mkOption {
        description = "Key is the taint key that the toleration applies to. Empty means match all taint keys.\nIf the key is empty, operator must be Exists; this combination means to match all values and all keys.";
        type = (types.nullOr types.str);
        default = null;
      };
      "operator" = mkOption {
        description = "Operator represents a key's relationship to the value.\nValid operators are Exists and Equal. Defaults to Equal.\nExists is equivalent to wildcard for value, so that a pod can\ntolerate all taints of a particular category.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tolerationSeconds" = mkOption {
        description = "TolerationSeconds represents the period of time the toleration (which must be\nof effect NoExecute, otherwise this field is ignored) tolerates the taint. By default,\nit is not set, which means tolerate the taint forever (do not evict). Zero and\nnegative values will be treated as 0 (evict immediately) by the system.";
        type = (types.nullOr types.int);
        default = null;
      };
      "value" = mkOption {
        description = "Value is the taint value the toleration matches to.\nIf the operator is Exists, the value should be empty, otherwise just a regular string.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodToleration =
    res:
    {
    }
    // optionalAttrs (res."effect" != null) { inherit (res) "effect"; }
    // {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
    }
    // optionalAttrs (res."operator" != null) { inherit (res) "operator"; }
    // {
    }
    // optionalAttrs (res."tolerationSeconds" != null) { inherit (res) "tolerationSeconds"; }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodTopologySpreadConstraintLabelSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkProviderKubernetesEnvoyDeploymentPodTopologySpreadConstraintLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodTopologySpreadConstraintLabelSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (
          types.listOf ProviderKubernetesEnvoyDeploymentPodTopologySpreadConstraintLabelSelectorMatchExpressionModule
        );
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodTopologySpreadConstraintLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkProviderKubernetesEnvoyDeploymentPodTopologySpreadConstraintLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodTopologySpreadConstraintModule = types.submodule {
    options = {
      "labelSelector" = mkOption {
        description = "LabelSelector is used to find matching pods.\nPods that match this label selector are counted to determine the number of pods\nin their corresponding topology domain.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDeploymentPodTopologySpreadConstraintLabelSelectorModule
        );
        default = null;
      };
      "matchLabelKeys" = mkOption {
        description = "MatchLabelKeys is a set of pod label keys to select the pods over which\nspreading will be calculated. The keys are used to lookup values from the\nincoming pod labels, those key-value labels are ANDed with labelSelector\nto select the group of existing pods over which spreading will be calculated\nfor the incoming pod. The same key is forbidden to exist in both MatchLabelKeys and LabelSelector.\nMatchLabelKeys cannot be set when LabelSelector isn't set.\nKeys that don't exist in the incoming pod labels will\nbe ignored. A null or empty list means only match against labelSelector.\n\nThis is a beta field and requires the MatchLabelKeysInPodTopologySpread feature gate to be enabled (enabled by default).";
        type = (types.listOf types.str);
        default = [ ];
      };
      "maxSkew" = mkOption {
        description = "MaxSkew describes the degree to which pods may be unevenly distributed.\nWhen `whenUnsatisfiable=DoNotSchedule`, it is the maximum permitted difference\nbetween the number of matching pods in the target topology and the global minimum.\nThe global minimum is the minimum number of matching pods in an eligible domain\nor zero if the number of eligible domains is less than MinDomains.\nFor example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same\nlabelSelector spread as 2/2/1:\nIn this case, the global minimum is 1.\n| zone1 | zone2 | zone3 |\n|  P P  |  P P  |   P   |\n- if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 2/2/2;\nscheduling it onto zone1(zone2) would make the ActualSkew(3-1) on zone1(zone2)\nviolate MaxSkew(1).\n- if MaxSkew is 2, incoming pod can be scheduled onto any zone.\nWhen `whenUnsatisfiable=ScheduleAnyway`, it is used to give higher precedence\nto topologies that satisfy it.\nIt's a required field. Default value is 1 and 0 is not allowed.";
        type = types.int;
      };
      "minDomains" = mkOption {
        description = "MinDomains indicates a minimum number of eligible domains.\nWhen the number of eligible domains with matching topology keys is less than minDomains,\nPod Topology Spread treats \"global minimum\" as 0, and then the calculation of Skew is performed.\nAnd when the number of eligible domains with matching topology keys equals or greater than minDomains,\nthis value has no effect on scheduling.\nAs a result, when the number of eligible domains is less than minDomains,\nscheduler won't schedule more than maxSkew Pods to those domains.\nIf value is nil, the constraint behaves as if MinDomains is equal to 1.\nValid values are integers greater than 0.\nWhen value is not nil, WhenUnsatisfiable must be DoNotSchedule.\n\nFor example, in a 3-zone cluster, MaxSkew is set to 2, MinDomains is set to 5 and pods with the same\nlabelSelector spread as 2/2/2:\n| zone1 | zone2 | zone3 |\n|  P P  |  P P  |  P P  |\nThe number of domains is less than 5(MinDomains), so \"global minimum\" is treated as 0.\nIn this situation, new pod with the same labelSelector cannot be scheduled,\nbecause computed skew will be 3(3 - 0) if new Pod is scheduled to any of the three zones,\nit will violate MaxSkew.";
        type = (types.nullOr types.int);
        default = null;
      };
      "nodeAffinityPolicy" = mkOption {
        description = "NodeAffinityPolicy indicates how we will treat Pod's nodeAffinity/nodeSelector\nwhen calculating pod topology spread skew. Options are:\n- Honor: only nodes matching nodeAffinity/nodeSelector are included in the calculations.\n- Ignore: nodeAffinity/nodeSelector are ignored. All nodes are included in the calculations.\n\nIf this value is nil, the behavior is equivalent to the Honor policy.";
        type = (types.nullOr types.str);
        default = null;
      };
      "nodeTaintsPolicy" = mkOption {
        description = "NodeTaintsPolicy indicates how we will treat node taints when calculating\npod topology spread skew. Options are:\n- Honor: nodes without taints, along with tainted nodes for which the incoming pod\nhas a toleration, are included.\n- Ignore: node taints are ignored. All nodes are included.\n\nIf this value is nil, the behavior is equivalent to the Ignore policy.";
        type = (types.nullOr types.str);
        default = null;
      };
      "topologyKey" = mkOption {
        description = "TopologyKey is the key of node labels. Nodes that have a label with this key\nand identical values are considered to be in the same topology.\nWe consider each <key, value> as a \"bucket\", and try to put balanced number\nof pods into each bucket.\nWe define a domain as a particular instance of a topology.\nAlso, we define an eligible domain as a domain whose nodes meet the requirements of\nnodeAffinityPolicy and nodeTaintsPolicy.\ne.g. If TopologyKey is \"kubernetes.io/hostname\", each Node is a domain of that topology.\nAnd, if TopologyKey is \"topology.kubernetes.io/zone\", each zone is a domain of that topology.\nIt's a required field.";
        type = types.str;
      };
      "whenUnsatisfiable" = mkOption {
        description = "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy\nthe spread constraint.\n- DoNotSchedule (default) tells the scheduler not to schedule it.\n- ScheduleAnyway tells the scheduler to schedule the pod in any location,\n  but giving higher precedence to topologies that would help reduce the\n  skew.\nA constraint is considered \"Unsatisfiable\" for an incoming pod\nif and only if every possible node assignment for that pod would violate\n\"MaxSkew\" on some topology.\nFor example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same\nlabelSelector spread as 3/1/1:\n| zone1 | zone2 | zone3 |\n| P P P |   P   |   P   |\nIf WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled\nto zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies\nMaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler\nwon't make it *more* imbalanced.\nIt's a required field.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodTopologySpreadConstraint =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkProviderKubernetesEnvoyDeploymentPodTopologySpreadConstraintLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."matchLabelKeys" != [ ]) { inherit (res) "matchLabelKeys"; }
    // {
      inherit (res) "maxSkew";
    }
    // optionalAttrs (res."minDomains" != null) { inherit (res) "minDomains"; }
    // {
    }
    // optionalAttrs (res."nodeAffinityPolicy" != null) { inherit (res) "nodeAffinityPolicy"; }
    // {
    }
    // optionalAttrs (res."nodeTaintsPolicy" != null) { inherit (res) "nodeTaintsPolicy"; }
    // {
      inherit (res) "topologyKey";
      inherit (res) "whenUnsatisfiable";
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeAwsElasticBlockStoreModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is the filesystem type of the volume that you want to mount.\nTip: Ensure that the filesystem type is supported by the host operating system.\nExamples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore";
        type = (types.nullOr types.str);
        default = null;
      };
      "partition" = mkOption {
        description = "partition is the partition in the volume that you want to mount.\nIf omitted, the default is to mount by volume name.\nExamples: For volume /dev/sda1, you specify the partition as \"1\".\nSimilarly, the volume partition for /dev/sda is \"0\" (or you can leave the property empty).";
        type = (types.nullOr types.int);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly value true will force the readOnly setting in VolumeMounts.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore";
        type = types.bool;
        default = false;
      };
      "volumeID" = mkOption {
        description = "volumeID is unique ID of the persistent disk resource in AWS (Amazon EBS volume).\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeAwsElasticBlockStore =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."partition" != null) { inherit (res) "partition"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
      inherit (res) "volumeID";
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeAzureDiskModule = types.submodule {
    options = {
      "cachingMode" = mkOption {
        description = "cachingMode is the Host Caching mode: None, Read Only, Read Write.";
        type = (types.nullOr types.str);
        default = null;
      };
      "diskName" = mkOption {
        description = "diskName is the Name of the data disk in the blob storage";
        type = types.str;
      };
      "diskURI" = mkOption {
        description = "diskURI is the URI of data disk in the blob storage";
        type = types.str;
      };
      "fsType" = mkOption {
        description = "fsType is Filesystem type to mount.\nMust be a filesystem type supported by the host operating system.\nEx. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.";
        type = (types.nullOr types.str);
        default = "ext4";
      };
      "kind" = mkOption {
        description = "kind expected values are Shared: multiple blob disks per storage account  Dedicated: single blob disk per storage account  Managed: azure managed data disk (only in managed availability set). defaults to shared";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly Defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeAzureDisk =
    res:
    {
    }
    // optionalAttrs (res."cachingMode" != null) { inherit (res) "cachingMode"; }
    // {
      inherit (res) "diskName";
      inherit (res) "diskURI";
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."kind" != null) { inherit (res) "kind"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeAzureFileModule = types.submodule {
    options = {
      "readOnly" = mkOption {
        description = "readOnly defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.";
        type = types.bool;
        default = false;
      };
      "secretName" = mkOption {
        description = "secretName is the  name of secret that contains Azure Storage Account Name and Key";
        type = types.str;
      };
      "shareName" = mkOption {
        description = "shareName is the azure share Name";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeAzureFile =
    res:
    {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
      inherit (res) "secretName";
      inherit (res) "shareName";
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeCephfsModule = types.submodule {
    options = {
      "monitors" = mkOption {
        description = "monitors is Required: Monitors is a collection of Ceph monitors\nMore info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it";
        type = (types.listOf types.str);
      };
      "path" = mkOption {
        description = "path is Optional: Used as the mounted root, rather than the full Ceph tree, default is /";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly is Optional: Defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.\nMore info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it";
        type = types.bool;
        default = false;
      };
      "secretFile" = mkOption {
        description = "secretFile is Optional: SecretFile is the path to key ring for User, default is /etc/ceph/user.secret\nMore info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it";
        type = (types.nullOr types.str);
        default = null;
      };
      "secretRef" = mkOption {
        description = "secretRef is Optional: SecretRef is reference to the authentication secret for User, default is empty.\nMore info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeCephfsSecretRefModule);
        default = null;
      };
      "user" = mkOption {
        description = "user is optional: User is the rados user name, default is admin\nMore info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeCephfs =
    res:
    {
      inherit (res) "monitors";
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."secretFile" != null) { inherit (res) "secretFile"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderKubernetesEnvoyDeploymentPodVolumeCephfsSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."user" != null) { inherit (res) "user"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeCephfsSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeCephfsSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeCinderModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is the filesystem type to mount.\nMust be a filesystem type supported by the host operating system.\nExamples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.\nMore info: https://examples.k8s.io/mysql-cinder-pd/README.md";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.\nMore info: https://examples.k8s.io/mysql-cinder-pd/README.md";
        type = types.bool;
        default = false;
      };
      "secretRef" = mkOption {
        description = "secretRef is optional: points to a secret object containing parameters used to connect\nto OpenStack.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeCinderSecretRefModule);
        default = null;
      };
      "volumeID" = mkOption {
        description = "volumeID used to identify the volume in cinder.\nMore info: https://examples.k8s.io/mysql-cinder-pd/README.md";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeCinder =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderKubernetesEnvoyDeploymentPodVolumeCinderSecretRef res."secretRef";
    }
    // {
      inherit (res) "volumeID";
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeCinderSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeCinderSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeConfigMapItemModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the key to project.";
        type = types.str;
      };
      "mode" = mkOption {
        description = "mode is Optional: mode bits used to set permissions on this file.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nIf not specified, the volume defaultMode will be used.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        description = "path is the relative path of the file to map the key to.\nMay not be an absolute path.\nMay not contain the path element '..'.\nMay not start with the string '..'.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeConfigMapItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeConfigMapModule = types.submodule {
    options = {
      "defaultMode" = mkOption {
        description = "defaultMode is optional: mode bits used to set permissions on created files by default.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nDefaults to 0644.\nDirectories within the path are not affected by this setting.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "items" = mkOption {
        description = "items if unspecified, each key-value pair in the Data field of the referenced\nConfigMap will be projected into the volume as a file whose name is the\nkey and content is the value. If specified, the listed keys will be\nprojected into the specified paths, and unlisted keys will not be\npresent. If a key is specified which is not present in the ConfigMap,\nthe volume setup will error unless it is marked optional. Paths must be\nrelative and may not contain the '..' path or start with '..'.";
        type = (types.listOf ProviderKubernetesEnvoyDeploymentPodVolumeConfigMapItemModule);
        default = [ ];
      };
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "optional specify whether the ConfigMap or its keys must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeConfigMap =
    res:
    {
    }
    // optionalAttrs (res."defaultMode" != null) { inherit (res) "defaultMode"; }
    // {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkProviderKubernetesEnvoyDeploymentPodVolumeConfigMapItem res."items";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeCsiModule = types.submodule {
    options = {
      "driver" = mkOption {
        description = "driver is the name of the CSI driver that handles this volume.\nConsult with your admin for the correct name as registered in the cluster.";
        type = types.str;
      };
      "fsType" = mkOption {
        description = "fsType to mount. Ex. \"ext4\", \"xfs\", \"ntfs\".\nIf not provided, the empty value is passed to the associated CSI driver\nwhich will determine the default filesystem to apply.";
        type = (types.nullOr types.str);
        default = null;
      };
      "nodePublishSecretRef" = mkOption {
        description = "nodePublishSecretRef is a reference to the secret object containing\nsensitive information to pass to the CSI driver to complete the CSI\nNodePublishVolume and NodeUnpublishVolume calls.\nThis field is optional, and  may be empty if no secret is required. If the\nsecret object contains more than one secret, all secret references are passed.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeCsiNodePublishSecretRefModule);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly specifies a read-only configuration for the volume.\nDefaults to false (read/write).";
        type = types.bool;
        default = false;
      };
      "volumeAttributes" = mkOption {
        description = "volumeAttributes stores driver-specific properties that are passed to the CSI\ndriver. Consult your driver's documentation for supported values.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeCsi =
    res:
    {
      inherit (res) "driver";
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."nodePublishSecretRef" != null) {
      "nodePublishSecretRef" =
        mkProviderKubernetesEnvoyDeploymentPodVolumeCsiNodePublishSecretRef
          res."nodePublishSecretRef";
    }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."volumeAttributes" != { }) { inherit (res) "volumeAttributes"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeCsiNodePublishSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeCsiNodePublishSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeDownwardAPIItemFieldRefModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        description = "Version of the schema the FieldPath is written in terms of, defaults to \"v1\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "fieldPath" = mkOption {
        description = "Path of the field to select in the specified API version.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeDownwardAPIItemFieldRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "fieldPath";
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeDownwardAPIItemModule = types.submodule {
    options = {
      "fieldRef" = mkOption {
        description = "Required: Selects a field of the pod: only annotations, labels, name, namespace and uid are supported.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeDownwardAPIItemFieldRefModule);
        default = null;
      };
      "mode" = mkOption {
        description = "Optional: mode bits used to set permissions on this file, must be an octal value\nbetween 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nIf not specified, the volume defaultMode will be used.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        description = "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'";
        type = types.str;
      };
      "resourceFieldRef" = mkOption {
        description = "Selects a resource of the container: only resources limits and requests\n(limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeDownwardAPIItemResourceFieldRefModule
        );
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeDownwardAPIItem =
    res:
    {
    }
    // optionalAttrs (res."fieldRef" != null) {
      "fieldRef" = mkProviderKubernetesEnvoyDeploymentPodVolumeDownwardAPIItemFieldRef res."fieldRef";
    }
    // {
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    }
    // optionalAttrs (res."resourceFieldRef" != null) {
      "resourceFieldRef" =
        mkProviderKubernetesEnvoyDeploymentPodVolumeDownwardAPIItemResourceFieldRef
          res."resourceFieldRef";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeDownwardAPIItemResourceFieldRefModule = types.submodule {
    options = {
      "containerName" = mkOption {
        description = "Container name: required for volumes, optional for env vars";
        type = (types.nullOr types.str);
        default = null;
      };
      "divisor" = mkOption {
        description = "Specifies the output format of the exposed resources, defaults to \"1\"";
        type = types.anything;
        default = { };
      };
      "resource" = mkOption {
        description = "Required: resource to select";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeDownwardAPIItemResourceFieldRef =
    res:
    {
    }
    // optionalAttrs (res."containerName" != null) { inherit (res) "containerName"; }
    // {
    }
    // optionalAttrs (res."divisor" != null) { inherit (res) "divisor"; }
    // {
      inherit (res) "resource";
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeDownwardAPIModule = types.submodule {
    options = {
      "defaultMode" = mkOption {
        description = "Optional: mode bits to use on created files by default. Must be a\nOptional: mode bits used to set permissions on created files by default.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nDefaults to 0644.\nDirectories within the path are not affected by this setting.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "items" = mkOption {
        description = "Items is a list of downward API volume file";
        type = (types.listOf ProviderKubernetesEnvoyDeploymentPodVolumeDownwardAPIItemModule);
        default = [ ];
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeDownwardAPI =
    res:
    {
    }
    // optionalAttrs (res."defaultMode" != null) { inherit (res) "defaultMode"; }
    // {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkProviderKubernetesEnvoyDeploymentPodVolumeDownwardAPIItem res."items";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeEmptyDirModule = types.submodule {
    options = {
      "medium" = mkOption {
        description = "medium represents what type of storage medium should back this directory.\nThe default is \"\" which means to use the node's default medium.\nMust be an empty string (default) or Memory.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir";
        type = (types.nullOr types.str);
        default = null;
      };
      "sizeLimit" = mkOption {
        description = "sizeLimit is the total amount of local storage required for this EmptyDir volume.\nThe size limit is also applicable for memory medium.\nThe maximum usage on memory medium EmptyDir would be the minimum value between\nthe SizeLimit specified here and the sum of memory limits of all containers in a pod.\nThe default is nil which means that the limit is undefined.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir";
        type = types.anything;
        default = { };
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeEmptyDir =
    res:
    {
    }
    // optionalAttrs (res."medium" != null) { inherit (res) "medium"; }
    // {
    }
    // optionalAttrs (res."sizeLimit" != null) { inherit (res) "sizeLimit"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeEphemeralModule = types.submodule {
    options = {
      "volumeClaimTemplate" = mkOption {
        description = "Will be used to create a stand-alone PVC to provision the volume.\nThe pod in which this EphemeralVolumeSource is embedded will be the\nowner of the PVC, i.e. the PVC will be deleted together with the\npod.  The name of the PVC will be `<pod name>-<volume name>` where\n`<volume name>` is the name from the `PodSpec.Volumes` array\nentry. Pod validation will reject the pod if the concatenated name\nis not valid for a PVC (for example, too long).\n\nAn existing PVC with that name that is not owned by the pod\nwill *not* be used for the pod to avoid using an unrelated\nvolume by mistake. Starting the pod is then blocked until\nthe unrelated PVC is removed. If such a pre-created PVC is\nmeant to be used by the pod, the PVC has to updated with an\nowner reference to the pod once the pod exists. Normally\nthis should not be necessary, but it may be useful when\nmanually reconstructing a broken cluster.\n\nThis field is read-only and no changes will be made by Kubernetes\nto the PVC after it has been created.\n\nRequired, must not be nil.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeEphemeral =
    res:
    {
    }
    // optionalAttrs (res."volumeClaimTemplate" != null) {
      "volumeClaimTemplate" =
        mkProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplate
          res."volumeClaimTemplate";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateModule = types.submodule {
    options = {
      "metadata" = mkOption {
        description = "May contain labels and annotations that will be copied into the PVC\nwhen creating it. No other fields are allowed and will be rejected during\nvalidation.";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "spec" = mkOption {
        description = "The specification for the PersistentVolumeClaim. The entire content is\ncopied unchanged into the PVC that gets created from this\ntemplate. The same fields as in a PersistentVolumeClaim\nare also valid here.";
        type = ProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateSpecModule;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplate =
    res:
    {
    }
    // optionalAttrs (res."metadata" != { }) { inherit (res) "metadata"; }
    // {
      "spec" = mkProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateSpec res."spec";
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateSpecDataSourceModule =
    types.submodule
      {
        options = {
          "apiGroup" = mkOption {
            description = "APIGroup is the group for the resource being referenced.\nIf APIGroup is not specified, the specified Kind must be in the core API group.\nFor any other third-party types, APIGroup is required.";
            type = (types.nullOr types.str);
            default = null;
          };
          "kind" = mkOption {
            description = "Kind is the type of resource being referenced";
            type = types.str;
          };
          "name" = mkOption {
            description = "Name is the name of resource being referenced";
            type = types.str;
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateSpecDataSource =
    res:
    {
    }
    // optionalAttrs (res."apiGroup" != null) { inherit (res) "apiGroup"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateSpecDataSourceRefModule =
    types.submodule
      {
        options = {
          "apiGroup" = mkOption {
            description = "APIGroup is the group for the resource being referenced.\nIf APIGroup is not specified, the specified Kind must be in the core API group.\nFor any other third-party types, APIGroup is required.";
            type = (types.nullOr types.str);
            default = null;
          };
          "kind" = mkOption {
            description = "Kind is the type of resource being referenced";
            type = types.str;
          };
          "name" = mkOption {
            description = "Name is the name of resource being referenced";
            type = types.str;
          };
          "namespace" = mkOption {
            description = "Namespace is the namespace of resource being referenced\nNote that when a namespace is specified, a gateway.networking.k8s.io/ReferenceGrant object is required in the referent namespace to allow that namespace's owner to accept the reference. See the ReferenceGrant documentation for details.\n(Alpha) This field requires the CrossNamespaceVolumeDataSource feature gate to be enabled.";
            type = (types.nullOr types.str);
            default = null;
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateSpecDataSourceRef =
    res:
    {
    }
    // optionalAttrs (res."apiGroup" != null) { inherit (res) "apiGroup"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateSpecModule = types.submodule {
    options = {
      "accessModes" = mkOption {
        description = "accessModes contains the desired access modes the volume should have.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1";
        type = (types.listOf types.str);
        default = [ ];
      };
      "dataSource" = mkOption {
        description = "dataSource field can be used to specify either:\n* An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot)\n* An existing PVC (PersistentVolumeClaim)\nIf the provisioner or an external controller can support the specified data source,\nit will create a new volume based on the contents of the specified data source.\nWhen the AnyVolumeDataSource feature gate is enabled, dataSource contents will be copied to dataSourceRef,\nand dataSourceRef contents will be copied to dataSource when dataSourceRef.namespace is not specified.\nIf the namespace is specified, then dataSourceRef will not be copied to dataSource.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateSpecDataSourceModule
        );
        default = null;
      };
      "dataSourceRef" = mkOption {
        description = "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty\nvolume is desired. This may be any object from a non-empty API group (non\ncore object) or a PersistentVolumeClaim object.\nWhen this field is specified, volume binding will only succeed if the type of\nthe specified object matches some installed volume populator or dynamic\nprovisioner.\nThis field will replace the functionality of the dataSource field and as such\nif both fields are non-empty, they must have the same value. For backwards\ncompatibility, when namespace isn't specified in dataSourceRef,\nboth fields (dataSource and dataSourceRef) will be set to the same\nvalue automatically if one of them is empty and the other is non-empty.\nWhen namespace is specified in dataSourceRef,\ndataSource isn't set to the same value and must be empty.\nThere are three important differences between dataSource and dataSourceRef:\n* While dataSource only allows two specific types of objects, dataSourceRef\n  allows any non-core object, as well as PersistentVolumeClaim objects.\n* While dataSource ignores disallowed values (dropping them), dataSourceRef\n  preserves all values, and generates an error if a disallowed value is\n  specified.\n* While dataSource only allows local objects, dataSourceRef allows objects\n  in any namespaces.\n(Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled.\n(Alpha) Using the namespace field of dataSourceRef requires the CrossNamespaceVolumeDataSource feature gate to be enabled.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateSpecDataSourceRefModule
        );
        default = null;
      };
      "resources" = mkOption {
        description = "resources represents the minimum resources the volume should have.\nIf RecoverVolumeExpansionFailure feature is enabled users are allowed to specify resource requirements\nthat are lower than previous value but must still be higher than capacity recorded in the\nstatus field of the claim.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources";
        type = (
          types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateSpecResourcesModule
        );
        default = null;
      };
      "selector" = mkOption {
        description = "selector is a label query over volumes to consider for binding.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateSpecSelectorModule
        );
        default = null;
      };
      "storageClassName" = mkOption {
        description = "storageClassName is the name of the StorageClass required by the claim.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeAttributesClassName" = mkOption {
        description = "volumeAttributesClassName may be used to set the VolumeAttributesClass used by this claim.\nIf specified, the CSI driver will create or update the volume with the attributes defined\nin the corresponding VolumeAttributesClass. This has a different purpose than storageClassName,\nit can be changed after the claim is created. An empty string value means that no VolumeAttributesClass\nwill be applied to the claim but it's not allowed to reset this field to empty string once it is set.\nIf unspecified and the PersistentVolumeClaim is unbound, the default VolumeAttributesClass\nwill be set by the persistentvolume controller if it exists.\nIf the resource referred to by volumeAttributesClass does not exist, this PersistentVolumeClaim will be\nset to a Pending state, as reflected by the modifyVolumeStatus field, until such as a resource\nexists.\nMore info: https://kubernetes.io/docs/concepts/storage/volume-attributes-classes/\n(Beta) Using this field requires the VolumeAttributesClass feature gate to be enabled (off by default).";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeMode" = mkOption {
        description = "volumeMode defines what type of volume is required by the claim.\nValue of Filesystem is implied when not included in claim spec.";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeName" = mkOption {
        description = "volumeName is the binding reference to the PersistentVolume backing this claim.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateSpec =
    res:
    {
    }
    // optionalAttrs (res."accessModes" != [ ]) { inherit (res) "accessModes"; }
    // {
    }
    // optionalAttrs (res."dataSource" != null) {
      "dataSource" =
        mkProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateSpecDataSource
          res."dataSource";
    }
    // {
    }
    // optionalAttrs (res."dataSourceRef" != null) {
      "dataSourceRef" =
        mkProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateSpecDataSourceRef
          res."dataSourceRef";
    }
    // {
    }
    // optionalAttrs (res."resources" != null) {
      "resources" =
        mkProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateSpecResources
          res."resources";
    }
    // {
    }
    // optionalAttrs (res."selector" != null) {
      "selector" =
        mkProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateSpecSelector
          res."selector";
    }
    // {
    }
    // optionalAttrs (res."storageClassName" != null) { inherit (res) "storageClassName"; }
    // {
    }
    // optionalAttrs (res."volumeAttributesClassName" != null) {
      inherit (res) "volumeAttributesClassName";
    }
    // {
    }
    // optionalAttrs (res."volumeMode" != null) { inherit (res) "volumeMode"; }
    // {
    }
    // optionalAttrs (res."volumeName" != null) { inherit (res) "volumeName"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateSpecResourcesModule =
    types.submodule
      {
        options = {
          "limits" = mkOption {
            description = "Limits describes the maximum amount of compute resources allowed.\nMore info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
            type = (types.attrsOf types.anything);
            default = { };
          };
          "requests" = mkOption {
            description = "Requests describes the minimum amount of compute resources required.\nIf Requests is omitted for a container, it defaults to Limits if that is explicitly specified,\notherwise to an implementation-defined value. Requests cannot exceed Limits.\nMore info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
            type = (types.attrsOf types.anything);
            default = { };
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateSpecResources =
    res:
    {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateSpecSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateSpecSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateSpecSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateSpecSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateSpecSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkProviderKubernetesEnvoyDeploymentPodVolumeEphemeralVolumeClaimTemplateSpecSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeFcModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is the filesystem type to mount.\nMust be a filesystem type supported by the host operating system.\nEx. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.";
        type = (types.nullOr types.str);
        default = null;
      };
      "lun" = mkOption {
        description = "lun is Optional: FC target lun number";
        type = (types.nullOr types.int);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly is Optional: Defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.";
        type = types.bool;
        default = false;
      };
      "targetWWNs" = mkOption {
        description = "targetWWNs is Optional: FC target worldwide names (WWNs)";
        type = (types.listOf types.str);
        default = [ ];
      };
      "wwids" = mkOption {
        description = "wwids Optional: FC volume world wide identifiers (wwids)\nEither wwids or combination of targetWWNs and lun must be set, but not both simultaneously.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeFc =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."lun" != null) { inherit (res) "lun"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."targetWWNs" != [ ]) { inherit (res) "targetWWNs"; }
    // {
    }
    // optionalAttrs (res."wwids" != [ ]) { inherit (res) "wwids"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeFlexVolumeModule = types.submodule {
    options = {
      "driver" = mkOption {
        description = "driver is the name of the driver to use for this volume.";
        type = types.str;
      };
      "fsType" = mkOption {
        description = "fsType is the filesystem type to mount.\nMust be a filesystem type supported by the host operating system.\nEx. \"ext4\", \"xfs\", \"ntfs\". The default filesystem depends on FlexVolume script.";
        type = (types.nullOr types.str);
        default = null;
      };
      "options" = mkOption {
        description = "options is Optional: this field holds extra command options if any.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "readOnly" = mkOption {
        description = "readOnly is Optional: defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.";
        type = types.bool;
        default = false;
      };
      "secretRef" = mkOption {
        description = "secretRef is Optional: secretRef is reference to the secret object containing\nsensitive information to pass to the plugin scripts. This may be\nempty if no secret object is specified. If the secret object\ncontains more than one secret, all secrets are passed to the plugin\nscripts.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeFlexVolumeSecretRefModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeFlexVolume =
    res:
    {
      inherit (res) "driver";
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."options" != { }) { inherit (res) "options"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderKubernetesEnvoyDeploymentPodVolumeFlexVolumeSecretRef res."secretRef";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeFlexVolumeSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeFlexVolumeSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeFlockerModule = types.submodule {
    options = {
      "datasetName" = mkOption {
        description = "datasetName is Name of the dataset stored as metadata -> name on the dataset for Flocker\nshould be considered as deprecated";
        type = (types.nullOr types.str);
        default = null;
      };
      "datasetUUID" = mkOption {
        description = "datasetUUID is the UUID of the dataset. This is unique identifier of a Flocker dataset";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeFlocker =
    res:
    {
    }
    // optionalAttrs (res."datasetName" != null) { inherit (res) "datasetName"; }
    // {
    }
    // optionalAttrs (res."datasetUUID" != null) { inherit (res) "datasetUUID"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeGcePersistentDiskModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is filesystem type of the volume that you want to mount.\nTip: Ensure that the filesystem type is supported by the host operating system.\nExamples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk";
        type = (types.nullOr types.str);
        default = null;
      };
      "partition" = mkOption {
        description = "partition is the partition in the volume that you want to mount.\nIf omitted, the default is to mount by volume name.\nExamples: For volume /dev/sda1, you specify the partition as \"1\".\nSimilarly, the volume partition for /dev/sda is \"0\" (or you can leave the property empty).\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk";
        type = (types.nullOr types.int);
        default = null;
      };
      "pdName" = mkOption {
        description = "pdName is unique name of the PD resource in GCE. Used to identify the disk in GCE.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk";
        type = types.str;
      };
      "readOnly" = mkOption {
        description = "readOnly here will force the ReadOnly setting in VolumeMounts.\nDefaults to false.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeGcePersistentDisk =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."partition" != null) { inherit (res) "partition"; }
    // {
      inherit (res) "pdName";
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeGitRepoModule = types.submodule {
    options = {
      "directory" = mkOption {
        description = "directory is the target directory name.\nMust not contain or start with '..'.  If '.' is supplied, the volume directory will be the\ngit repository.  Otherwise, if specified, the volume will contain the git repository in\nthe subdirectory with the given name.";
        type = (types.nullOr types.str);
        default = null;
      };
      "repository" = mkOption {
        description = "repository is the URL";
        type = types.str;
      };
      "revision" = mkOption {
        description = "revision is the commit hash for the specified revision.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeGitRepo =
    res:
    {
    }
    // optionalAttrs (res."directory" != null) { inherit (res) "directory"; }
    // {
      inherit (res) "repository";
    }
    // optionalAttrs (res."revision" != null) { inherit (res) "revision"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeGlusterfsModule = types.submodule {
    options = {
      "endpoints" = mkOption {
        description = "endpoints is the endpoint name that details Glusterfs topology.\nMore info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod";
        type = types.str;
      };
      "path" = mkOption {
        description = "path is the Glusterfs volume path.\nMore info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod";
        type = types.str;
      };
      "readOnly" = mkOption {
        description = "readOnly here will force the Glusterfs volume to be mounted with read-only permissions.\nDefaults to false.\nMore info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeGlusterfs =
    res:
    {
      inherit (res) "endpoints";
      inherit (res) "path";
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeHostPathModule = types.submodule {
    options = {
      "path" = mkOption {
        description = "path of the directory on the host.\nIf the path is a symlink, it will follow the link to the real path.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath";
        type = types.str;
      };
      "type" = mkOption {
        description = "type for HostPath Volume\nDefaults to \"\"\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeHostPath =
    res:
    {
      inherit (res) "path";
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeImageModule = types.submodule {
    options = {
      "pullPolicy" = mkOption {
        description = "Policy for pulling OCI objects. Possible values are:\nAlways: the kubelet always attempts to pull the reference. Container creation will fail If the pull fails.\nNever: the kubelet never pulls the reference and only uses a local image or artifact. Container creation will fail if the reference isn't present.\nIfNotPresent: the kubelet pulls if the reference isn't already present on disk. Container creation will fail if the reference isn't present and the pull fails.\nDefaults to Always if :latest tag is specified, or IfNotPresent otherwise.";
        type = (types.nullOr types.str);
        default = null;
      };
      "reference" = mkOption {
        description = "Required: Image or artifact reference to be used.\nBehaves in the same way as pod.spec.containers[*].image.\nPull secrets will be assembled in the same way as for the container image by looking up node credentials, SA image pull secrets, and pod spec image pull secrets.\nMore info: https://kubernetes.io/docs/concepts/containers/images\nThis field is optional to allow higher level config management to default or override\ncontainer images in workload controllers like Deployments and StatefulSets.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeImage =
    res:
    {
    }
    // optionalAttrs (res."pullPolicy" != null) { inherit (res) "pullPolicy"; }
    // {
    }
    // optionalAttrs (res."reference" != null) { inherit (res) "reference"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeIscsiModule = types.submodule {
    options = {
      "chapAuthDiscovery" = mkOption {
        description = "chapAuthDiscovery defines whether support iSCSI Discovery CHAP authentication";
        type = types.bool;
        default = false;
      };
      "chapAuthSession" = mkOption {
        description = "chapAuthSession defines whether support iSCSI Session CHAP authentication";
        type = types.bool;
        default = false;
      };
      "fsType" = mkOption {
        description = "fsType is the filesystem type of the volume that you want to mount.\nTip: Ensure that the filesystem type is supported by the host operating system.\nExamples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#iscsi";
        type = (types.nullOr types.str);
        default = null;
      };
      "initiatorName" = mkOption {
        description = "initiatorName is the custom iSCSI Initiator Name.\nIf initiatorName is specified with iscsiInterface simultaneously, new iSCSI interface\n<target portal>:<volume name> will be created for the connection.";
        type = (types.nullOr types.str);
        default = null;
      };
      "iqn" = mkOption {
        description = "iqn is the target iSCSI Qualified Name.";
        type = types.str;
      };
      "iscsiInterface" = mkOption {
        description = "iscsiInterface is the interface Name that uses an iSCSI transport.\nDefaults to 'default' (tcp).";
        type = (types.nullOr types.str);
        default = "default";
      };
      "lun" = mkOption {
        description = "lun represents iSCSI Target Lun number.";
        type = types.int;
      };
      "portals" = mkOption {
        description = "portals is the iSCSI Target Portal List. The portal is either an IP or ip_addr:port if the port\nis other than default (typically TCP ports 860 and 3260).";
        type = (types.listOf types.str);
        default = [ ];
      };
      "readOnly" = mkOption {
        description = "readOnly here will force the ReadOnly setting in VolumeMounts.\nDefaults to false.";
        type = types.bool;
        default = false;
      };
      "secretRef" = mkOption {
        description = "secretRef is the CHAP Secret for iSCSI target and initiator authentication";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeIscsiSecretRefModule);
        default = null;
      };
      "targetPortal" = mkOption {
        description = "targetPortal is iSCSI Target Portal. The Portal is either an IP or ip_addr:port if the port\nis other than default (typically TCP ports 860 and 3260).";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeIscsi =
    res:
    {
    }
    // optionalAttrs res."chapAuthDiscovery" { inherit (res) "chapAuthDiscovery"; }
    // {
    }
    // optionalAttrs res."chapAuthSession" { inherit (res) "chapAuthSession"; }
    // {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."initiatorName" != null) { inherit (res) "initiatorName"; }
    // {
      inherit (res) "iqn";
    }
    // optionalAttrs (res."iscsiInterface" != null) { inherit (res) "iscsiInterface"; }
    // {
      inherit (res) "lun";
    }
    // optionalAttrs (res."portals" != [ ]) { inherit (res) "portals"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderKubernetesEnvoyDeploymentPodVolumeIscsiSecretRef res."secretRef";
    }
    // {
      inherit (res) "targetPortal";
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeIscsiSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeIscsiSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeModule = types.submodule {
    options = {
      "awsElasticBlockStore" = mkOption {
        description = "awsElasticBlockStore represents an AWS Disk resource that is attached to a\nkubelet's host machine and then exposed to the pod.\nDeprecated: AWSElasticBlockStore is deprecated. All operations for the in-tree\nawsElasticBlockStore type are redirected to the ebs.csi.aws.com CSI driver.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeAwsElasticBlockStoreModule);
        default = null;
      };
      "azureDisk" = mkOption {
        description = "azureDisk represents an Azure Data Disk mount on the host and bind mount to the pod.\nDeprecated: AzureDisk is deprecated. All operations for the in-tree azureDisk type\nare redirected to the disk.csi.azure.com CSI driver.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeAzureDiskModule);
        default = null;
      };
      "azureFile" = mkOption {
        description = "azureFile represents an Azure File Service mount on the host and bind mount to the pod.\nDeprecated: AzureFile is deprecated. All operations for the in-tree azureFile type\nare redirected to the file.csi.azure.com CSI driver.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeAzureFileModule);
        default = null;
      };
      "cephfs" = mkOption {
        description = "cephFS represents a Ceph FS mount on the host that shares a pod's lifetime.\nDeprecated: CephFS is deprecated and the in-tree cephfs type is no longer supported.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeCephfsModule);
        default = null;
      };
      "cinder" = mkOption {
        description = "cinder represents a cinder volume attached and mounted on kubelets host machine.\nDeprecated: Cinder is deprecated. All operations for the in-tree cinder type\nare redirected to the cinder.csi.openstack.org CSI driver.\nMore info: https://examples.k8s.io/mysql-cinder-pd/README.md";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeCinderModule);
        default = null;
      };
      "configMap" = mkOption {
        description = "configMap represents a configMap that should populate this volume";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeConfigMapModule);
        default = null;
      };
      "csi" = mkOption {
        description = "csi (Container Storage Interface) represents ephemeral storage that is handled by certain external CSI drivers.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeCsiModule);
        default = null;
      };
      "downwardAPI" = mkOption {
        description = "downwardAPI represents downward API about the pod that should populate this volume";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeDownwardAPIModule);
        default = null;
      };
      "emptyDir" = mkOption {
        description = "emptyDir represents a temporary directory that shares a pod's lifetime.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeEmptyDirModule);
        default = null;
      };
      "ephemeral" = mkOption {
        description = "ephemeral represents a volume that is handled by a cluster storage driver.\nThe volume's lifecycle is tied to the pod that defines it - it will be created before the pod starts,\nand deleted when the pod is removed.\n\nUse this if:\na) the volume is only needed while the pod runs,\nb) features of normal volumes like restoring from snapshot or capacity\n   tracking are needed,\nc) the storage driver is specified through a storage class, and\nd) the storage driver supports dynamic volume provisioning through\n   a PersistentVolumeClaim (see EphemeralVolumeSource for more\n   information on the connection between this volume type\n   and PersistentVolumeClaim).\n\nUse PersistentVolumeClaim or one of the vendor-specific\nAPIs for volumes that persist for longer than the lifecycle\nof an individual pod.\n\nUse CSI for light-weight local ephemeral volumes if the CSI driver is meant to\nbe used that way - see the documentation of the driver for\nmore information.\n\nA pod can use both types of ephemeral volumes and\npersistent volumes at the same time.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeEphemeralModule);
        default = null;
      };
      "fc" = mkOption {
        description = "fc represents a Fibre Channel resource that is attached to a kubelet's host machine and then exposed to the pod.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeFcModule);
        default = null;
      };
      "flexVolume" = mkOption {
        description = "flexVolume represents a generic volume resource that is\nprovisioned/attached using an exec based plugin.\nDeprecated: FlexVolume is deprecated. Consider using a CSIDriver instead.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeFlexVolumeModule);
        default = null;
      };
      "flocker" = mkOption {
        description = "flocker represents a Flocker volume attached to a kubelet's host machine. This depends on the Flocker control service being running.\nDeprecated: Flocker is deprecated and the in-tree flocker type is no longer supported.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeFlockerModule);
        default = null;
      };
      "gcePersistentDisk" = mkOption {
        description = "gcePersistentDisk represents a GCE Disk resource that is attached to a\nkubelet's host machine and then exposed to the pod.\nDeprecated: GCEPersistentDisk is deprecated. All operations for the in-tree\ngcePersistentDisk type are redirected to the pd.csi.storage.gke.io CSI driver.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeGcePersistentDiskModule);
        default = null;
      };
      "gitRepo" = mkOption {
        description = "gitRepo represents a git repository at a particular revision.\nDeprecated: GitRepo is deprecated. To provision a container with a git repo, mount an\nEmptyDir into an InitContainer that clones the repo using git, then mount the EmptyDir\ninto the Pod's container.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeGitRepoModule);
        default = null;
      };
      "glusterfs" = mkOption {
        description = "glusterfs represents a Glusterfs mount on the host that shares a pod's lifetime.\nDeprecated: Glusterfs is deprecated and the in-tree glusterfs type is no longer supported.\nMore info: https://examples.k8s.io/volumes/glusterfs/README.md";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeGlusterfsModule);
        default = null;
      };
      "hostPath" = mkOption {
        description = "hostPath represents a pre-existing file or directory on the host\nmachine that is directly exposed to the container. This is generally\nused for system agents or other privileged things that are allowed\nto see the host machine. Most containers will NOT need this.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeHostPathModule);
        default = null;
      };
      "image" = mkOption {
        description = "image represents an OCI object (a container image or artifact) pulled and mounted on the kubelet's host machine.\nThe volume is resolved at pod startup depending on which PullPolicy value is provided:\n\n- Always: the kubelet always attempts to pull the reference. Container creation will fail If the pull fails.\n- Never: the kubelet never pulls the reference and only uses a local image or artifact. Container creation will fail if the reference isn't present.\n- IfNotPresent: the kubelet pulls if the reference isn't already present on disk. Container creation will fail if the reference isn't present and the pull fails.\n\nThe volume gets re-resolved if the pod gets deleted and recreated, which means that new remote content will become available on pod recreation.\nA failure to resolve or pull the image during pod startup will block containers from starting and may add significant latency. Failures will be retried using normal volume backoff and will be reported on the pod reason and message.\nThe types of objects that may be mounted by this volume are defined by the container runtime implementation on a host machine and at minimum must include all valid types supported by the container image field.\nThe OCI object gets mounted in a single directory (spec.containers[*].volumeMounts.mountPath) by merging the manifest layers in the same way as for container images.\nThe volume will be mounted read-only (ro) and non-executable files (noexec).\nSub path mounts for containers are not supported (spec.containers[*].volumeMounts.subpath) before 1.33.\nThe field spec.securityContext.fsGroupChangePolicy has no effect on this volume type.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeImageModule);
        default = null;
      };
      "iscsi" = mkOption {
        description = "iscsi represents an ISCSI Disk resource that is attached to a\nkubelet's host machine and then exposed to the pod.\nMore info: https://examples.k8s.io/volumes/iscsi/README.md";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeIscsiModule);
        default = null;
      };
      "name" = mkOption {
        description = "name of the volume.\nMust be a DNS_LABEL and unique within the pod.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = types.str;
      };
      "nfs" = mkOption {
        description = "nfs represents an NFS mount on the host that shares a pod's lifetime\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#nfs";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeNfsModule);
        default = null;
      };
      "persistentVolumeClaim" = mkOption {
        description = "persistentVolumeClaimVolumeSource represents a reference to a\nPersistentVolumeClaim in the same namespace.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumePersistentVolumeClaimModule);
        default = null;
      };
      "photonPersistentDisk" = mkOption {
        description = "photonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine.\nDeprecated: PhotonPersistentDisk is deprecated and the in-tree photonPersistentDisk type is no longer supported.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumePhotonPersistentDiskModule);
        default = null;
      };
      "portworxVolume" = mkOption {
        description = "portworxVolume represents a portworx volume attached and mounted on kubelets host machine.\nDeprecated: PortworxVolume is deprecated. All operations for the in-tree portworxVolume type\nare redirected to the pxd.portworx.com CSI driver when the CSIMigrationPortworx feature-gate\nis on.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumePortworxVolumeModule);
        default = null;
      };
      "projected" = mkOption {
        description = "projected items for all in one resources secrets, configmaps, and downward API";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeProjectedModule);
        default = null;
      };
      "quobyte" = mkOption {
        description = "quobyte represents a Quobyte mount on the host that shares a pod's lifetime.\nDeprecated: Quobyte is deprecated and the in-tree quobyte type is no longer supported.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeQuobyteModule);
        default = null;
      };
      "rbd" = mkOption {
        description = "rbd represents a Rados Block Device mount on the host that shares a pod's lifetime.\nDeprecated: RBD is deprecated and the in-tree rbd type is no longer supported.\nMore info: https://examples.k8s.io/volumes/rbd/README.md";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeRbdModule);
        default = null;
      };
      "scaleIO" = mkOption {
        description = "scaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes.\nDeprecated: ScaleIO is deprecated and the in-tree scaleIO type is no longer supported.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeScaleIOModule);
        default = null;
      };
      "secret" = mkOption {
        description = "secret represents a secret that should populate this volume.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#secret";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeSecretModule);
        default = null;
      };
      "storageos" = mkOption {
        description = "storageOS represents a StorageOS volume attached and mounted on Kubernetes nodes.\nDeprecated: StorageOS is deprecated and the in-tree storageos type is no longer supported.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeStorageosModule);
        default = null;
      };
      "vsphereVolume" = mkOption {
        description = "vsphereVolume represents a vSphere volume attached and mounted on kubelets host machine.\nDeprecated: VsphereVolume is deprecated. All operations for the in-tree vsphereVolume type\nare redirected to the csi.vsphere.vmware.com CSI driver.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeVsphereVolumeModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolume =
    res:
    {
    }
    // optionalAttrs (res."awsElasticBlockStore" != null) {
      "awsElasticBlockStore" =
        mkProviderKubernetesEnvoyDeploymentPodVolumeAwsElasticBlockStore
          res."awsElasticBlockStore";
    }
    // {
    }
    // optionalAttrs (res."azureDisk" != null) {
      "azureDisk" = mkProviderKubernetesEnvoyDeploymentPodVolumeAzureDisk res."azureDisk";
    }
    // {
    }
    // optionalAttrs (res."azureFile" != null) {
      "azureFile" = mkProviderKubernetesEnvoyDeploymentPodVolumeAzureFile res."azureFile";
    }
    // {
    }
    // optionalAttrs (res."cephfs" != null) {
      "cephfs" = mkProviderKubernetesEnvoyDeploymentPodVolumeCephfs res."cephfs";
    }
    // {
    }
    // optionalAttrs (res."cinder" != null) {
      "cinder" = mkProviderKubernetesEnvoyDeploymentPodVolumeCinder res."cinder";
    }
    // {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkProviderKubernetesEnvoyDeploymentPodVolumeConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."csi" != null) {
      "csi" = mkProviderKubernetesEnvoyDeploymentPodVolumeCsi res."csi";
    }
    // {
    }
    // optionalAttrs (res."downwardAPI" != null) {
      "downwardAPI" = mkProviderKubernetesEnvoyDeploymentPodVolumeDownwardAPI res."downwardAPI";
    }
    // {
    }
    // optionalAttrs (res."emptyDir" != null) {
      "emptyDir" = mkProviderKubernetesEnvoyDeploymentPodVolumeEmptyDir res."emptyDir";
    }
    // {
    }
    // optionalAttrs (res."ephemeral" != null) {
      "ephemeral" = mkProviderKubernetesEnvoyDeploymentPodVolumeEphemeral res."ephemeral";
    }
    // {
    }
    // optionalAttrs (res."fc" != null) {
      "fc" = mkProviderKubernetesEnvoyDeploymentPodVolumeFc res."fc";
    }
    // {
    }
    // optionalAttrs (res."flexVolume" != null) {
      "flexVolume" = mkProviderKubernetesEnvoyDeploymentPodVolumeFlexVolume res."flexVolume";
    }
    // {
    }
    // optionalAttrs (res."flocker" != null) {
      "flocker" = mkProviderKubernetesEnvoyDeploymentPodVolumeFlocker res."flocker";
    }
    // {
    }
    // optionalAttrs (res."gcePersistentDisk" != null) {
      "gcePersistentDisk" =
        mkProviderKubernetesEnvoyDeploymentPodVolumeGcePersistentDisk
          res."gcePersistentDisk";
    }
    // {
    }
    // optionalAttrs (res."gitRepo" != null) {
      "gitRepo" = mkProviderKubernetesEnvoyDeploymentPodVolumeGitRepo res."gitRepo";
    }
    // {
    }
    // optionalAttrs (res."glusterfs" != null) {
      "glusterfs" = mkProviderKubernetesEnvoyDeploymentPodVolumeGlusterfs res."glusterfs";
    }
    // {
    }
    // optionalAttrs (res."hostPath" != null) {
      "hostPath" = mkProviderKubernetesEnvoyDeploymentPodVolumeHostPath res."hostPath";
    }
    // {
    }
    // optionalAttrs (res."image" != null) {
      "image" = mkProviderKubernetesEnvoyDeploymentPodVolumeImage res."image";
    }
    // {
    }
    // optionalAttrs (res."iscsi" != null) {
      "iscsi" = mkProviderKubernetesEnvoyDeploymentPodVolumeIscsi res."iscsi";
    }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."nfs" != null) {
      "nfs" = mkProviderKubernetesEnvoyDeploymentPodVolumeNfs res."nfs";
    }
    // {
    }
    // optionalAttrs (res."persistentVolumeClaim" != null) {
      "persistentVolumeClaim" =
        mkProviderKubernetesEnvoyDeploymentPodVolumePersistentVolumeClaim
          res."persistentVolumeClaim";
    }
    // {
    }
    // optionalAttrs (res."photonPersistentDisk" != null) {
      "photonPersistentDisk" =
        mkProviderKubernetesEnvoyDeploymentPodVolumePhotonPersistentDisk
          res."photonPersistentDisk";
    }
    // {
    }
    // optionalAttrs (res."portworxVolume" != null) {
      "portworxVolume" = mkProviderKubernetesEnvoyDeploymentPodVolumePortworxVolume res."portworxVolume";
    }
    // {
    }
    // optionalAttrs (res."projected" != null) {
      "projected" = mkProviderKubernetesEnvoyDeploymentPodVolumeProjected res."projected";
    }
    // {
    }
    // optionalAttrs (res."quobyte" != null) {
      "quobyte" = mkProviderKubernetesEnvoyDeploymentPodVolumeQuobyte res."quobyte";
    }
    // {
    }
    // optionalAttrs (res."rbd" != null) {
      "rbd" = mkProviderKubernetesEnvoyDeploymentPodVolumeRbd res."rbd";
    }
    // {
    }
    // optionalAttrs (res."scaleIO" != null) {
      "scaleIO" = mkProviderKubernetesEnvoyDeploymentPodVolumeScaleIO res."scaleIO";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkProviderKubernetesEnvoyDeploymentPodVolumeSecret res."secret";
    }
    // {
    }
    // optionalAttrs (res."storageos" != null) {
      "storageos" = mkProviderKubernetesEnvoyDeploymentPodVolumeStorageos res."storageos";
    }
    // {
    }
    // optionalAttrs (res."vsphereVolume" != null) {
      "vsphereVolume" = mkProviderKubernetesEnvoyDeploymentPodVolumeVsphereVolume res."vsphereVolume";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeNfsModule = types.submodule {
    options = {
      "path" = mkOption {
        description = "path that is exported by the NFS server.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#nfs";
        type = types.str;
      };
      "readOnly" = mkOption {
        description = "readOnly here will force the NFS export to be mounted with read-only permissions.\nDefaults to false.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#nfs";
        type = types.bool;
        default = false;
      };
      "server" = mkOption {
        description = "server is the hostname or IP address of the NFS server.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#nfs";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeNfs =
    res:
    {
      inherit (res) "path";
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
      inherit (res) "server";
    };
  ProviderKubernetesEnvoyDeploymentPodVolumePersistentVolumeClaimModule = types.submodule {
    options = {
      "claimName" = mkOption {
        description = "claimName is the name of a PersistentVolumeClaim in the same namespace as the pod using this volume.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims";
        type = types.str;
      };
      "readOnly" = mkOption {
        description = "readOnly Will force the ReadOnly setting in VolumeMounts.\nDefault false.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumePersistentVolumeClaim =
    res:
    {
      inherit (res) "claimName";
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumePhotonPersistentDiskModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is the filesystem type to mount.\nMust be a filesystem type supported by the host operating system.\nEx. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.";
        type = (types.nullOr types.str);
        default = null;
      };
      "pdID" = mkOption {
        description = "pdID is the ID that identifies Photon Controller persistent disk";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumePhotonPersistentDisk =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
      inherit (res) "pdID";
    };
  ProviderKubernetesEnvoyDeploymentPodVolumePortworxVolumeModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fSType represents the filesystem type to mount\nMust be a filesystem type supported by the host operating system.\nEx. \"ext4\", \"xfs\". Implicitly inferred to be \"ext4\" if unspecified.";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.";
        type = types.bool;
        default = false;
      };
      "volumeID" = mkOption {
        description = "volumeID uniquely identifies a Portworx volume";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumePortworxVolume =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
      inherit (res) "volumeID";
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeProjectedModule = types.submodule {
    options = {
      "defaultMode" = mkOption {
        description = "defaultMode are the mode bits used to set permissions on created files by default.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nDirectories within the path are not affected by this setting.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "sources" = mkOption {
        description = "sources is the list of volume projections. Each entry in this list\nhandles one source.";
        type = (types.listOf ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceModule);
        default = [ ];
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeProjected =
    res:
    {
    }
    // optionalAttrs (res."defaultMode" != null) { inherit (res) "defaultMode"; }
    // {
    }
    // optionalAttrs (res."sources" != [ ]) {
      "sources" = map mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSource res."sources";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceClusterTrustBundleLabelSelectorMatchExpressionModule =
    types.submodule
      {
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
  mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceClusterTrustBundleLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceClusterTrustBundleLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceClusterTrustBundleLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceClusterTrustBundleLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceClusterTrustBundleLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceClusterTrustBundleModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "Select all ClusterTrustBundles that match this label selector.  Only has\neffect if signerName is set.  Mutually-exclusive with name.  If unset,\ninterpreted as \"match nothing\".  If set but empty, interpreted as \"match\neverything\".";
            type = (
              types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceClusterTrustBundleLabelSelectorModule
            );
            default = null;
          };
          "name" = mkOption {
            description = "Select a single ClusterTrustBundle by object name.  Mutually-exclusive\nwith signerName and labelSelector.";
            type = (types.nullOr types.str);
            default = null;
          };
          "optional" = mkOption {
            description = "If true, don't block pod startup if the referenced ClusterTrustBundle(s)\naren't available.  If using name, then the named ClusterTrustBundle is\nallowed not to exist.  If using signerName, then the combination of\nsignerName and labelSelector is allowed to match zero\nClusterTrustBundles.";
            type = types.bool;
            default = false;
          };
          "path" = mkOption {
            description = "Relative path from the volume root to write the bundle.";
            type = types.str;
          };
          "signerName" = mkOption {
            description = "Select all ClusterTrustBundles that match this signer name.\nMutually-exclusive with name.  The contents of all selected\nClusterTrustBundles will be unified and deduplicated.";
            type = (types.nullOr types.str);
            default = null;
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceClusterTrustBundle =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceClusterTrustBundleLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
      inherit (res) "path";
    }
    // optionalAttrs (res."signerName" != null) { inherit (res) "signerName"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceConfigMapItemModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the key to project.";
        type = types.str;
      };
      "mode" = mkOption {
        description = "mode is Optional: mode bits used to set permissions on this file.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nIf not specified, the volume defaultMode will be used.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        description = "path is the relative path of the file to map the key to.\nMay not be an absolute path.\nMay not contain the path element '..'.\nMay not start with the string '..'.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceConfigMapItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceConfigMapModule = types.submodule {
    options = {
      "items" = mkOption {
        description = "items if unspecified, each key-value pair in the Data field of the referenced\nConfigMap will be projected into the volume as a file whose name is the\nkey and content is the value. If specified, the listed keys will be\nprojected into the specified paths, and unlisted keys will not be\npresent. If a key is specified which is not present in the ConfigMap,\nthe volume setup will error unless it is marked optional. Paths must be\nrelative and may not contain the '..' path or start with '..'.";
        type = (types.listOf ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceConfigMapItemModule);
        default = [ ];
      };
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "optional specify whether the ConfigMap or its keys must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceConfigMap =
    res:
    {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceConfigMapItem res."items";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceDownwardAPIItemFieldRefModule =
    types.submodule
      {
        options = {
          "apiVersion" = mkOption {
            description = "Version of the schema the FieldPath is written in terms of, defaults to \"v1\".";
            type = (types.nullOr types.str);
            default = null;
          };
          "fieldPath" = mkOption {
            description = "Path of the field to select in the specified API version.";
            type = types.str;
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceDownwardAPIItemFieldRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "fieldPath";
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceDownwardAPIItemModule = types.submodule {
    options = {
      "fieldRef" = mkOption {
        description = "Required: Selects a field of the pod: only annotations, labels, name, namespace and uid are supported.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceDownwardAPIItemFieldRefModule
        );
        default = null;
      };
      "mode" = mkOption {
        description = "Optional: mode bits used to set permissions on this file, must be an octal value\nbetween 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nIf not specified, the volume defaultMode will be used.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        description = "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'";
        type = types.str;
      };
      "resourceFieldRef" = mkOption {
        description = "Selects a resource of the container: only resources limits and requests\n(limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceDownwardAPIItemResourceFieldRefModule
        );
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceDownwardAPIItem =
    res:
    {
    }
    // optionalAttrs (res."fieldRef" != null) {
      "fieldRef" =
        mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceDownwardAPIItemFieldRef
          res."fieldRef";
    }
    // {
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    }
    // optionalAttrs (res."resourceFieldRef" != null) {
      "resourceFieldRef" =
        mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceDownwardAPIItemResourceFieldRef
          res."resourceFieldRef";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceDownwardAPIItemResourceFieldRefModule =
    types.submodule
      {
        options = {
          "containerName" = mkOption {
            description = "Container name: required for volumes, optional for env vars";
            type = (types.nullOr types.str);
            default = null;
          };
          "divisor" = mkOption {
            description = "Specifies the output format of the exposed resources, defaults to \"1\"";
            type = types.anything;
            default = { };
          };
          "resource" = mkOption {
            description = "Required: resource to select";
            type = types.str;
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceDownwardAPIItemResourceFieldRef =
    res:
    {
    }
    // optionalAttrs (res."containerName" != null) { inherit (res) "containerName"; }
    // {
    }
    // optionalAttrs (res."divisor" != null) { inherit (res) "divisor"; }
    // {
      inherit (res) "resource";
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceDownwardAPIModule = types.submodule {
    options = {
      "items" = mkOption {
        description = "Items is a list of DownwardAPIVolume file";
        type = (
          types.listOf ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceDownwardAPIItemModule
        );
        default = [ ];
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceDownwardAPI =
    res:
    {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" =
        map mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceDownwardAPIItem
          res."items";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceModule = types.submodule {
    options = {
      "clusterTrustBundle" = mkOption {
        description = "ClusterTrustBundle allows a pod to access the `.spec.trustBundle` field\nof ClusterTrustBundle objects in an auto-updating file.\n\nAlpha, gated by the ClusterTrustBundleProjection feature gate.\n\nClusterTrustBundle objects can either be selected by name, or by the\ncombination of signer name and a label selector.\n\nKubelet performs aggressive normalization of the PEM contents written\ninto the pod filesystem.  Esoteric PEM features such as inter-block\ncomments and block headers are stripped.  Certificates are deduplicated.\nThe ordering of certificates within the file is arbitrary, and Kubelet\nmay change the order over time.";
        type = (
          types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceClusterTrustBundleModule
        );
        default = null;
      };
      "configMap" = mkOption {
        description = "configMap information about the configMap data to project";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceConfigMapModule);
        default = null;
      };
      "downwardAPI" = mkOption {
        description = "downwardAPI information about the downwardAPI data to project";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceDownwardAPIModule);
        default = null;
      };
      "secret" = mkOption {
        description = "secret information about the secret data to project";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceSecretModule);
        default = null;
      };
      "serviceAccountToken" = mkOption {
        description = "serviceAccountToken is information about the serviceAccountToken data to project";
        type = (
          types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceServiceAccountTokenModule
        );
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSource =
    res:
    {
    }
    // optionalAttrs (res."clusterTrustBundle" != null) {
      "clusterTrustBundle" =
        mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceClusterTrustBundle
          res."clusterTrustBundle";
    }
    // {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."downwardAPI" != null) {
      "downwardAPI" =
        mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceDownwardAPI
          res."downwardAPI";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceSecret res."secret";
    }
    // {
    }
    // optionalAttrs (res."serviceAccountToken" != null) {
      "serviceAccountToken" =
        mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceServiceAccountToken
          res."serviceAccountToken";
    }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceSecretItemModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the key to project.";
        type = types.str;
      };
      "mode" = mkOption {
        description = "mode is Optional: mode bits used to set permissions on this file.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nIf not specified, the volume defaultMode will be used.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        description = "path is the relative path of the file to map the key to.\nMay not be an absolute path.\nMay not contain the path element '..'.\nMay not start with the string '..'.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceSecretItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceSecretModule = types.submodule {
    options = {
      "items" = mkOption {
        description = "items if unspecified, each key-value pair in the Data field of the referenced\nSecret will be projected into the volume as a file whose name is the\nkey and content is the value. If specified, the listed keys will be\nprojected into the specified paths, and unlisted keys will not be\npresent. If a key is specified which is not present in the Secret,\nthe volume setup will error unless it is marked optional. Paths must be\nrelative and may not contain the '..' path or start with '..'.";
        type = (types.listOf ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceSecretItemModule);
        default = [ ];
      };
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "optional field specify whether the Secret or its key must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceSecret =
    res:
    {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceSecretItem res."items";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceServiceAccountTokenModule =
    types.submodule
      {
        options = {
          "audience" = mkOption {
            description = "audience is the intended audience of the token. A recipient of a token\nmust identify itself with an identifier specified in the audience of the\ntoken, and otherwise should reject the token. The audience defaults to the\nidentifier of the apiserver.";
            type = (types.nullOr types.str);
            default = null;
          };
          "expirationSeconds" = mkOption {
            description = "expirationSeconds is the requested duration of validity of the service\naccount token. As the token approaches expiration, the kubelet volume\nplugin will proactively rotate the service account token. The kubelet will\nstart trying to rotate the token if the token is older than 80 percent of\nits time to live or if the token is older than 24 hours.Defaults to 1 hour\nand must be at least 10 minutes.";
            type = (types.nullOr types.int);
            default = null;
          };
          "path" = mkOption {
            description = "path is the path relative to the mount point of the file to project the\ntoken into.";
            type = types.str;
          };
        };
      };
  mkProviderKubernetesEnvoyDeploymentPodVolumeProjectedSourceServiceAccountToken =
    res:
    {
    }
    // optionalAttrs (res."audience" != null) { inherit (res) "audience"; }
    // {
    }
    // optionalAttrs (res."expirationSeconds" != null) { inherit (res) "expirationSeconds"; }
    // {
      inherit (res) "path";
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeQuobyteModule = types.submodule {
    options = {
      "group" = mkOption {
        description = "group to map volume access to\nDefault is no group";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly here will force the Quobyte volume to be mounted with read-only permissions.\nDefaults to false.";
        type = types.bool;
        default = false;
      };
      "registry" = mkOption {
        description = "registry represents a single or multiple Quobyte Registry services\nspecified as a string as host:port pair (multiple entries are separated with commas)\nwhich acts as the central registry for volumes";
        type = types.str;
      };
      "tenant" = mkOption {
        description = "tenant owning the given Quobyte volume in the Backend\nUsed with dynamically provisioned Quobyte volumes, value is set by the plugin";
        type = (types.nullOr types.str);
        default = null;
      };
      "user" = mkOption {
        description = "user to map volume access to\nDefaults to serivceaccount user";
        type = (types.nullOr types.str);
        default = null;
      };
      "volume" = mkOption {
        description = "volume is a string that references an already created Quobyte volume by name.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeQuobyte =
    res:
    {
    }
    // optionalAttrs (res."group" != null) { inherit (res) "group"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
      inherit (res) "registry";
    }
    // optionalAttrs (res."tenant" != null) { inherit (res) "tenant"; }
    // {
    }
    // optionalAttrs (res."user" != null) { inherit (res) "user"; }
    // {
      inherit (res) "volume";
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeRbdModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is the filesystem type of the volume that you want to mount.\nTip: Ensure that the filesystem type is supported by the host operating system.\nExamples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#rbd";
        type = (types.nullOr types.str);
        default = null;
      };
      "image" = mkOption {
        description = "image is the rados image name.\nMore info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it";
        type = types.str;
      };
      "keyring" = mkOption {
        description = "keyring is the path to key ring for RBDUser.\nDefault is /etc/ceph/keyring.\nMore info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it";
        type = (types.nullOr types.str);
        default = "/etc/ceph/keyring";
      };
      "monitors" = mkOption {
        description = "monitors is a collection of Ceph monitors.\nMore info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it";
        type = (types.listOf types.str);
      };
      "pool" = mkOption {
        description = "pool is the rados pool name.\nDefault is rbd.\nMore info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it";
        type = (types.nullOr types.str);
        default = "rbd";
      };
      "readOnly" = mkOption {
        description = "readOnly here will force the ReadOnly setting in VolumeMounts.\nDefaults to false.\nMore info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it";
        type = types.bool;
        default = false;
      };
      "secretRef" = mkOption {
        description = "secretRef is name of the authentication secret for RBDUser. If provided\noverrides keyring.\nDefault is nil.\nMore info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeRbdSecretRefModule);
        default = null;
      };
      "user" = mkOption {
        description = "user is the rados user name.\nDefault is admin.\nMore info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it";
        type = (types.nullOr types.str);
        default = "admin";
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeRbd =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
      inherit (res) "image";
    }
    // optionalAttrs (res."keyring" != null) { inherit (res) "keyring"; }
    // {
      inherit (res) "monitors";
    }
    // optionalAttrs (res."pool" != null) { inherit (res) "pool"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderKubernetesEnvoyDeploymentPodVolumeRbdSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."user" != null) { inherit (res) "user"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeRbdSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeRbdSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeScaleIOModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is the filesystem type to mount.\nMust be a filesystem type supported by the host operating system.\nEx. \"ext4\", \"xfs\", \"ntfs\".\nDefault is \"xfs\".";
        type = (types.nullOr types.str);
        default = "xfs";
      };
      "gateway" = mkOption {
        description = "gateway is the host address of the ScaleIO API Gateway.";
        type = types.str;
      };
      "protectionDomain" = mkOption {
        description = "protectionDomain is the name of the ScaleIO Protection Domain for the configured storage.";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly Defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.";
        type = types.bool;
        default = false;
      };
      "secretRef" = mkOption {
        description = "secretRef references to the secret for ScaleIO user and other\nsensitive information. If this is not provided, Login operation will fail.";
        type = ProviderKubernetesEnvoyDeploymentPodVolumeScaleIOSecretRefModule;
      };
      "sslEnabled" = mkOption {
        description = "sslEnabled Flag enable/disable SSL communication with Gateway, default false";
        type = types.bool;
        default = false;
      };
      "storageMode" = mkOption {
        description = "storageMode indicates whether the storage for a volume should be ThickProvisioned or ThinProvisioned.\nDefault is ThinProvisioned.";
        type = (types.nullOr types.str);
        default = "ThinProvisioned";
      };
      "storagePool" = mkOption {
        description = "storagePool is the ScaleIO Storage Pool associated with the protection domain.";
        type = (types.nullOr types.str);
        default = null;
      };
      "system" = mkOption {
        description = "system is the name of the storage system as configured in ScaleIO.";
        type = types.str;
      };
      "volumeName" = mkOption {
        description = "volumeName is the name of a volume already created in the ScaleIO system\nthat is associated with this volume source.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeScaleIO =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
      inherit (res) "gateway";
    }
    // optionalAttrs (res."protectionDomain" != null) { inherit (res) "protectionDomain"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
      "secretRef" = mkProviderKubernetesEnvoyDeploymentPodVolumeScaleIOSecretRef res."secretRef";
    }
    // optionalAttrs res."sslEnabled" { inherit (res) "sslEnabled"; }
    // {
    }
    // optionalAttrs (res."storageMode" != null) { inherit (res) "storageMode"; }
    // {
    }
    // optionalAttrs (res."storagePool" != null) { inherit (res) "storagePool"; }
    // {
      inherit (res) "system";
    }
    // optionalAttrs (res."volumeName" != null) { inherit (res) "volumeName"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeScaleIOSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeScaleIOSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeSecretItemModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the key to project.";
        type = types.str;
      };
      "mode" = mkOption {
        description = "mode is Optional: mode bits used to set permissions on this file.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nIf not specified, the volume defaultMode will be used.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "path" = mkOption {
        description = "path is the relative path of the file to map the key to.\nMay not be an absolute path.\nMay not contain the path element '..'.\nMay not start with the string '..'.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeSecretItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeSecretModule = types.submodule {
    options = {
      "defaultMode" = mkOption {
        description = "defaultMode is Optional: mode bits used to set permissions on created files by default.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values\nfor mode bits. Defaults to 0644.\nDirectories within the path are not affected by this setting.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "items" = mkOption {
        description = "items If unspecified, each key-value pair in the Data field of the referenced\nSecret will be projected into the volume as a file whose name is the\nkey and content is the value. If specified, the listed keys will be\nprojected into the specified paths, and unlisted keys will not be\npresent. If a key is specified which is not present in the Secret,\nthe volume setup will error unless it is marked optional. Paths must be\nrelative and may not contain the '..' path or start with '..'.";
        type = (types.listOf ProviderKubernetesEnvoyDeploymentPodVolumeSecretItemModule);
        default = [ ];
      };
      "optional" = mkOption {
        description = "optional field specify whether the Secret or its keys must be defined";
        type = types.bool;
        default = false;
      };
      "secretName" = mkOption {
        description = "secretName is the name of the secret in the pod's namespace to use.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#secret";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeSecret =
    res:
    {
    }
    // optionalAttrs (res."defaultMode" != null) { inherit (res) "defaultMode"; }
    // {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkProviderKubernetesEnvoyDeploymentPodVolumeSecretItem res."items";
    }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    }
    // optionalAttrs (res."secretName" != null) { inherit (res) "secretName"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeStorageosModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is the filesystem type to mount.\nMust be a filesystem type supported by the host operating system.\nEx. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.";
        type = (types.nullOr types.str);
        default = null;
      };
      "readOnly" = mkOption {
        description = "readOnly defaults to false (read/write). ReadOnly here will force\nthe ReadOnly setting in VolumeMounts.";
        type = types.bool;
        default = false;
      };
      "secretRef" = mkOption {
        description = "secretRef specifies the secret to use for obtaining the StorageOS API\ncredentials.  If not specified, default values will be attempted.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentPodVolumeStorageosSecretRefModule);
        default = null;
      };
      "volumeName" = mkOption {
        description = "volumeName is the human-readable name of the StorageOS volume.  Volume\nnames are only unique within a namespace.";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeNamespace" = mkOption {
        description = "volumeNamespace specifies the scope of the volume within StorageOS.  If no\nnamespace is specified then the Pod's namespace will be used.  This allows the\nKubernetes name scoping to be mirrored within StorageOS for tighter integration.\nSet VolumeName to any name to override the default behaviour.\nSet to \"default\" if you are not using namespaces within StorageOS.\nNamespaces that do not pre-exist within StorageOS will be created.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeStorageos =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkProviderKubernetesEnvoyDeploymentPodVolumeStorageosSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."volumeName" != null) { inherit (res) "volumeName"; }
    // {
    }
    // optionalAttrs (res."volumeNamespace" != null) { inherit (res) "volumeNamespace"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeStorageosSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeStorageosSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentPodVolumeVsphereVolumeModule = types.submodule {
    options = {
      "fsType" = mkOption {
        description = "fsType is filesystem type to mount.\nMust be a filesystem type supported by the host operating system.\nEx. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified.";
        type = (types.nullOr types.str);
        default = null;
      };
      "storagePolicyID" = mkOption {
        description = "storagePolicyID is the storage Policy Based Management (SPBM) profile ID associated with the StoragePolicyName.";
        type = (types.nullOr types.str);
        default = null;
      };
      "storagePolicyName" = mkOption {
        description = "storagePolicyName is the storage Policy Based Management (SPBM) profile name.";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumePath" = mkOption {
        description = "volumePath is the path that identifies vSphere volume vmdk";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentPodVolumeVsphereVolume =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."storagePolicyID" != null) { inherit (res) "storagePolicyID"; }
    // {
    }
    // optionalAttrs (res."storagePolicyName" != null) { inherit (res) "storagePolicyName"; }
    // {
      inherit (res) "volumePath";
    };
  ProviderKubernetesEnvoyDeploymentStrategyModule = types.submodule {
    options = {
      "rollingUpdate" = mkOption {
        description = "Rolling update config params. Present only if DeploymentStrategyType =\nRollingUpdate.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentStrategyRollingUpdateModule);
        default = null;
      };
      "type" = mkOption {
        description = "Type of deployment. Can be \"Recreate\" or \"RollingUpdate\". Default is RollingUpdate.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentStrategy =
    res:
    {
    }
    // optionalAttrs (res."rollingUpdate" != null) {
      "rollingUpdate" = mkProviderKubernetesEnvoyDeploymentStrategyRollingUpdate res."rollingUpdate";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ProviderKubernetesEnvoyDeploymentStrategyRollingUpdateModule = types.submodule {
    options = {
      "maxSurge" = mkOption {
        description = "The maximum number of pods that can be scheduled above the desired number of\npods.\nValue can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%).\nThis can not be 0 if MaxUnavailable is 0.\nAbsolute number is calculated from percentage by rounding up.\nDefaults to 25%.\nExample: when this is set to 30%, the new ReplicaSet can be scaled up immediately when\nthe rolling update starts, such that the total number of old and new pods do not exceed\n130% of desired pods. Once old pods have been killed,\nnew ReplicaSet can be scaled up further, ensuring that total number of pods running\nat any time during the update is at most 130% of desired pods.";
        type = types.anything;
        default = { };
      };
      "maxUnavailable" = mkOption {
        description = "The maximum number of pods that can be unavailable during the update.\nValue can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%).\nAbsolute number is calculated from percentage by rounding down.\nThis can not be 0 if MaxSurge is 0.\nDefaults to 25%.\nExample: when this is set to 30%, the old ReplicaSet can be scaled down to 70% of desired pods\nimmediately when the rolling update starts. Once new pods are ready, old ReplicaSet\ncan be scaled down further, followed by scaling up the new ReplicaSet, ensuring\nthat the total number of pods available at all times during the update is at\nleast 70% of desired pods.";
        type = types.anything;
        default = { };
      };
    };
  };
  mkProviderKubernetesEnvoyDeploymentStrategyRollingUpdate =
    res:
    {
    }
    // optionalAttrs (res."maxSurge" != null) { inherit (res) "maxSurge"; }
    // {
    }
    // optionalAttrs (res."maxUnavailable" != null) { inherit (res) "maxUnavailable"; }
    // {
    };
  ProviderKubernetesEnvoyHpaBehaviorModule = types.submodule {
    options = {
      "scaleDown" = mkOption {
        description = "scaleDown is scaling policy for scaling Down.\nIf not set, the default value is to allow to scale down to minReplicas pods, with a\n300 second stabilization window (i.e., the highest recommendation for\nthe last 300sec is used).";
        type = (types.nullOr ProviderKubernetesEnvoyHpaBehaviorScaleDownModule);
        default = null;
      };
      "scaleUp" = mkOption {
        description = "scaleUp is scaling policy for scaling Up.\nIf not set, the default value is the higher of:\n  * increase no more than 4 pods per 60 seconds\n  * double the number of pods per 60 seconds\nNo stabilization is used.";
        type = (types.nullOr ProviderKubernetesEnvoyHpaBehaviorScaleUpModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyHpaBehavior =
    res:
    {
    }
    // optionalAttrs (res."scaleDown" != null) {
      "scaleDown" = mkProviderKubernetesEnvoyHpaBehaviorScaleDown res."scaleDown";
    }
    // {
    }
    // optionalAttrs (res."scaleUp" != null) {
      "scaleUp" = mkProviderKubernetesEnvoyHpaBehaviorScaleUp res."scaleUp";
    }
    // {
    };
  ProviderKubernetesEnvoyHpaBehaviorScaleDownModule = types.submodule {
    options = {
      "policies" = mkOption {
        description = "policies is a list of potential scaling polices which can be used during scaling.\nIf not set, use the default values:\n- For scale up: allow doubling the number of pods, or an absolute change of 4 pods in a 15s window.\n- For scale down: allow all pods to be removed in a 15s window.";
        type = (types.listOf ProviderKubernetesEnvoyHpaBehaviorScaleDownPolicieModule);
        default = [ ];
      };
      "selectPolicy" = mkOption {
        description = "selectPolicy is used to specify which policy should be used.\nIf not set, the default value Max is used.";
        type = (types.nullOr types.str);
        default = null;
      };
      "stabilizationWindowSeconds" = mkOption {
        description = "stabilizationWindowSeconds is the number of seconds for which past recommendations should be\nconsidered while scaling up or scaling down.\nStabilizationWindowSeconds must be greater than or equal to zero and less than or equal to 3600 (one hour).\nIf not set, use the default values:\n- For scale up: 0 (i.e. no stabilization is done).\n- For scale down: 300 (i.e. the stabilization window is 300 seconds long).";
        type = (types.nullOr types.int);
        default = null;
      };
      "tolerance" = mkOption {
        description = "tolerance is the tolerance on the ratio between the current and desired\nmetric value under which no updates are made to the desired number of\nreplicas (e.g. 0.01 for 1%). Must be greater than or equal to zero. If not\nset, the default cluster-wide tolerance is applied (by default 10%).\n\nFor example, if autoscaling is configured with a memory consumption target of 100Mi,\nand scale-down and scale-up tolerances of 5% and 1% respectively, scaling will be\ntriggered when the actual consumption falls below 95Mi or exceeds 101Mi.\n\nThis is an alpha field and requires enabling the HPAConfigurableTolerance\nfeature gate.";
        type = types.anything;
        default = { };
      };
    };
  };
  mkProviderKubernetesEnvoyHpaBehaviorScaleDown =
    res:
    {
    }
    // optionalAttrs (res."policies" != [ ]) {
      "policies" = map mkProviderKubernetesEnvoyHpaBehaviorScaleDownPolicie res."policies";
    }
    // {
    }
    // optionalAttrs (res."selectPolicy" != null) { inherit (res) "selectPolicy"; }
    // {
    }
    // optionalAttrs (res."stabilizationWindowSeconds" != null) {
      inherit (res) "stabilizationWindowSeconds";
    }
    // {
    }
    // optionalAttrs (res."tolerance" != null) { inherit (res) "tolerance"; }
    // {
    };
  ProviderKubernetesEnvoyHpaBehaviorScaleDownPolicieModule = types.submodule {
    options = {
      "periodSeconds" = mkOption {
        description = "periodSeconds specifies the window of time for which the policy should hold true.\nPeriodSeconds must be greater than zero and less than or equal to 1800 (30 min).";
        type = types.int;
      };
      "type" = mkOption {
        description = "type is used to specify the scaling policy.";
        type = types.str;
      };
      "value" = mkOption {
        description = "value contains the amount of change which is permitted by the policy.\nIt must be greater than zero";
        type = types.int;
      };
    };
  };
  mkProviderKubernetesEnvoyHpaBehaviorScaleDownPolicie = res: {
    inherit (res) "periodSeconds";
    inherit (res) "type";
    inherit (res) "value";
  };
  ProviderKubernetesEnvoyHpaBehaviorScaleUpModule = types.submodule {
    options = {
      "policies" = mkOption {
        description = "policies is a list of potential scaling polices which can be used during scaling.\nIf not set, use the default values:\n- For scale up: allow doubling the number of pods, or an absolute change of 4 pods in a 15s window.\n- For scale down: allow all pods to be removed in a 15s window.";
        type = (types.listOf ProviderKubernetesEnvoyHpaBehaviorScaleUpPolicieModule);
        default = [ ];
      };
      "selectPolicy" = mkOption {
        description = "selectPolicy is used to specify which policy should be used.\nIf not set, the default value Max is used.";
        type = (types.nullOr types.str);
        default = null;
      };
      "stabilizationWindowSeconds" = mkOption {
        description = "stabilizationWindowSeconds is the number of seconds for which past recommendations should be\nconsidered while scaling up or scaling down.\nStabilizationWindowSeconds must be greater than or equal to zero and less than or equal to 3600 (one hour).\nIf not set, use the default values:\n- For scale up: 0 (i.e. no stabilization is done).\n- For scale down: 300 (i.e. the stabilization window is 300 seconds long).";
        type = (types.nullOr types.int);
        default = null;
      };
      "tolerance" = mkOption {
        description = "tolerance is the tolerance on the ratio between the current and desired\nmetric value under which no updates are made to the desired number of\nreplicas (e.g. 0.01 for 1%). Must be greater than or equal to zero. If not\nset, the default cluster-wide tolerance is applied (by default 10%).\n\nFor example, if autoscaling is configured with a memory consumption target of 100Mi,\nand scale-down and scale-up tolerances of 5% and 1% respectively, scaling will be\ntriggered when the actual consumption falls below 95Mi or exceeds 101Mi.\n\nThis is an alpha field and requires enabling the HPAConfigurableTolerance\nfeature gate.";
        type = types.anything;
        default = { };
      };
    };
  };
  mkProviderKubernetesEnvoyHpaBehaviorScaleUp =
    res:
    {
    }
    // optionalAttrs (res."policies" != [ ]) {
      "policies" = map mkProviderKubernetesEnvoyHpaBehaviorScaleUpPolicie res."policies";
    }
    // {
    }
    // optionalAttrs (res."selectPolicy" != null) { inherit (res) "selectPolicy"; }
    // {
    }
    // optionalAttrs (res."stabilizationWindowSeconds" != null) {
      inherit (res) "stabilizationWindowSeconds";
    }
    // {
    }
    // optionalAttrs (res."tolerance" != null) { inherit (res) "tolerance"; }
    // {
    };
  ProviderKubernetesEnvoyHpaBehaviorScaleUpPolicieModule = types.submodule {
    options = {
      "periodSeconds" = mkOption {
        description = "periodSeconds specifies the window of time for which the policy should hold true.\nPeriodSeconds must be greater than zero and less than or equal to 1800 (30 min).";
        type = types.int;
      };
      "type" = mkOption {
        description = "type is used to specify the scaling policy.";
        type = types.str;
      };
      "value" = mkOption {
        description = "value contains the amount of change which is permitted by the policy.\nIt must be greater than zero";
        type = types.int;
      };
    };
  };
  mkProviderKubernetesEnvoyHpaBehaviorScaleUpPolicie = res: {
    inherit (res) "periodSeconds";
    inherit (res) "type";
    inherit (res) "value";
  };
  ProviderKubernetesEnvoyHpaMetricContainerResourceModule = types.submodule {
    options = {
      "container" = mkOption {
        description = "container is the name of the container in the pods of the scaling target";
        type = types.str;
      };
      "name" = mkOption {
        description = "name is the name of the resource in question.";
        type = types.str;
      };
      "target" = mkOption {
        description = "target specifies the target value for the given metric";
        type = ProviderKubernetesEnvoyHpaMetricContainerResourceTargetModule;
      };
    };
  };
  mkProviderKubernetesEnvoyHpaMetricContainerResource = res: {
    inherit (res) "container";
    inherit (res) "name";
    "target" = mkProviderKubernetesEnvoyHpaMetricContainerResourceTarget res."target";
  };
  ProviderKubernetesEnvoyHpaMetricContainerResourceTargetModule = types.submodule {
    options = {
      "averageUtilization" = mkOption {
        description = "averageUtilization is the target value of the average of the\nresource metric across all relevant pods, represented as a percentage of\nthe requested value of the resource for the pods.\nCurrently only valid for Resource metric source type";
        type = (types.nullOr types.int);
        default = null;
      };
      "averageValue" = mkOption {
        description = "averageValue is the target value of the average of the\nmetric across all relevant pods (as a quantity)";
        type = types.anything;
        default = { };
      };
      "type" = mkOption {
        description = "type represents whether the metric type is Utilization, Value, or AverageValue";
        type = types.str;
      };
      "value" = mkOption {
        description = "value is the target value of the metric (as a quantity).";
        type = types.anything;
        default = { };
      };
    };
  };
  mkProviderKubernetesEnvoyHpaMetricContainerResourceTarget =
    res:
    {
    }
    // optionalAttrs (res."averageUtilization" != null) { inherit (res) "averageUtilization"; }
    // {
    }
    // optionalAttrs (res."averageValue" != null) { inherit (res) "averageValue"; }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  ProviderKubernetesEnvoyHpaMetricExternalMetricModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "name is the name of the given metric";
        type = types.str;
      };
      "selector" = mkOption {
        description = "selector is the string-encoded form of a standard kubernetes label selector for the given metric\nWhen set, it is passed as an additional parameter to the metrics server for more specific metrics scoping.\nWhen unset, just the metricName will be used to gather metrics.";
        type = (types.nullOr ProviderKubernetesEnvoyHpaMetricExternalMetricSelectorModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyHpaMetricExternalMetric =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."selector" != null) {
      "selector" = mkProviderKubernetesEnvoyHpaMetricExternalMetricSelector res."selector";
    }
    // {
    };
  ProviderKubernetesEnvoyHpaMetricExternalMetricSelectorMatchExpressionModule = types.submodule {
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
  mkProviderKubernetesEnvoyHpaMetricExternalMetricSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyHpaMetricExternalMetricSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf ProviderKubernetesEnvoyHpaMetricExternalMetricSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkProviderKubernetesEnvoyHpaMetricExternalMetricSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkProviderKubernetesEnvoyHpaMetricExternalMetricSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderKubernetesEnvoyHpaMetricExternalModule = types.submodule {
    options = {
      "metric" = mkOption {
        description = "metric identifies the target metric by name and selector";
        type = ProviderKubernetesEnvoyHpaMetricExternalMetricModule;
      };
      "target" = mkOption {
        description = "target specifies the target value for the given metric";
        type = ProviderKubernetesEnvoyHpaMetricExternalTargetModule;
      };
    };
  };
  mkProviderKubernetesEnvoyHpaMetricExternal = res: {
    "metric" = mkProviderKubernetesEnvoyHpaMetricExternalMetric res."metric";
    "target" = mkProviderKubernetesEnvoyHpaMetricExternalTarget res."target";
  };
  ProviderKubernetesEnvoyHpaMetricExternalTargetModule = types.submodule {
    options = {
      "averageUtilization" = mkOption {
        description = "averageUtilization is the target value of the average of the\nresource metric across all relevant pods, represented as a percentage of\nthe requested value of the resource for the pods.\nCurrently only valid for Resource metric source type";
        type = (types.nullOr types.int);
        default = null;
      };
      "averageValue" = mkOption {
        description = "averageValue is the target value of the average of the\nmetric across all relevant pods (as a quantity)";
        type = types.anything;
        default = { };
      };
      "type" = mkOption {
        description = "type represents whether the metric type is Utilization, Value, or AverageValue";
        type = types.str;
      };
      "value" = mkOption {
        description = "value is the target value of the metric (as a quantity).";
        type = types.anything;
        default = { };
      };
    };
  };
  mkProviderKubernetesEnvoyHpaMetricExternalTarget =
    res:
    {
    }
    // optionalAttrs (res."averageUtilization" != null) { inherit (res) "averageUtilization"; }
    // {
    }
    // optionalAttrs (res."averageValue" != null) { inherit (res) "averageValue"; }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  ProviderKubernetesEnvoyHpaMetricModule = types.submodule {
    options = {
      "containerResource" = mkOption {
        description = "containerResource refers to a resource metric (such as those specified in\nrequests and limits) known to Kubernetes describing a single container in\neach pod of the current scale target (e.g. CPU or memory). Such metrics are\nbuilt in to Kubernetes, and have special scaling options on top of those\navailable to normal per-pod metrics using the \"pods\" source.";
        type = (types.nullOr ProviderKubernetesEnvoyHpaMetricContainerResourceModule);
        default = null;
      };
      "external" = mkOption {
        description = "external refers to a global metric that is not associated\nwith any Kubernetes object. It allows autoscaling based on information\ncoming from components running outside of cluster\n(for example length of queue in cloud messaging service, or\nQPS from loadbalancer running outside of cluster).";
        type = (types.nullOr ProviderKubernetesEnvoyHpaMetricExternalModule);
        default = null;
      };
      "object" = mkOption {
        description = "object refers to a metric describing a single kubernetes object\n(for example, hits-per-second on an Ingress object).";
        type = (types.nullOr ProviderKubernetesEnvoyHpaMetricObjectModule);
        default = null;
      };
      "pods" = mkOption {
        description = "pods refers to a metric describing each pod in the current scale target\n(for example, transactions-processed-per-second).  The values will be\naveraged together before being compared to the target value.";
        type = (types.nullOr ProviderKubernetesEnvoyHpaMetricPodsModule);
        default = null;
      };
      "resource" = mkOption {
        description = "resource refers to a resource metric (such as those specified in\nrequests and limits) known to Kubernetes describing each pod in the\ncurrent scale target (e.g. CPU or memory). Such metrics are built in to\nKubernetes, and have special scaling options on top of those available\nto normal per-pod metrics using the \"pods\" source.";
        type = (types.nullOr ProviderKubernetesEnvoyHpaMetricResourceModule);
        default = null;
      };
      "type" = mkOption {
        description = "type is the type of metric source.  It should be one of \"ContainerResource\", \"External\",\n\"Object\", \"Pods\" or \"Resource\", each mapping to a matching field in the object.";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyHpaMetric =
    res:
    {
    }
    // optionalAttrs (res."containerResource" != null) {
      "containerResource" = mkProviderKubernetesEnvoyHpaMetricContainerResource res."containerResource";
    }
    // {
    }
    // optionalAttrs (res."external" != null) {
      "external" = mkProviderKubernetesEnvoyHpaMetricExternal res."external";
    }
    // {
    }
    // optionalAttrs (res."object" != null) {
      "object" = mkProviderKubernetesEnvoyHpaMetricObject res."object";
    }
    // {
    }
    // optionalAttrs (res."pods" != null) {
      "pods" = mkProviderKubernetesEnvoyHpaMetricPods res."pods";
    }
    // {
    }
    // optionalAttrs (res."resource" != null) {
      "resource" = mkProviderKubernetesEnvoyHpaMetricResource res."resource";
    }
    // {
      inherit (res) "type";
    };
  ProviderKubernetesEnvoyHpaMetricObjectDescribedObjectModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        description = "apiVersion is the API version of the referent";
        type = (types.nullOr types.str);
        default = null;
      };
      "kind" = mkOption {
        description = "kind is the kind of the referent; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds";
        type = types.str;
      };
      "name" = mkOption {
        description = "name is the name of the referent; More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = types.str;
      };
    };
  };
  mkProviderKubernetesEnvoyHpaMetricObjectDescribedObject =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    };
  ProviderKubernetesEnvoyHpaMetricObjectMetricModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "name is the name of the given metric";
        type = types.str;
      };
      "selector" = mkOption {
        description = "selector is the string-encoded form of a standard kubernetes label selector for the given metric\nWhen set, it is passed as an additional parameter to the metrics server for more specific metrics scoping.\nWhen unset, just the metricName will be used to gather metrics.";
        type = (types.nullOr ProviderKubernetesEnvoyHpaMetricObjectMetricSelectorModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyHpaMetricObjectMetric =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."selector" != null) {
      "selector" = mkProviderKubernetesEnvoyHpaMetricObjectMetricSelector res."selector";
    }
    // {
    };
  ProviderKubernetesEnvoyHpaMetricObjectMetricSelectorMatchExpressionModule = types.submodule {
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
  mkProviderKubernetesEnvoyHpaMetricObjectMetricSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyHpaMetricObjectMetricSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf ProviderKubernetesEnvoyHpaMetricObjectMetricSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkProviderKubernetesEnvoyHpaMetricObjectMetricSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkProviderKubernetesEnvoyHpaMetricObjectMetricSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderKubernetesEnvoyHpaMetricObjectModule = types.submodule {
    options = {
      "describedObject" = mkOption {
        description = "describedObject specifies the descriptions of a object,such as kind,name apiVersion";
        type = ProviderKubernetesEnvoyHpaMetricObjectDescribedObjectModule;
      };
      "metric" = mkOption {
        description = "metric identifies the target metric by name and selector";
        type = ProviderKubernetesEnvoyHpaMetricObjectMetricModule;
      };
      "target" = mkOption {
        description = "target specifies the target value for the given metric";
        type = ProviderKubernetesEnvoyHpaMetricObjectTargetModule;
      };
    };
  };
  mkProviderKubernetesEnvoyHpaMetricObject = res: {
    "describedObject" = mkProviderKubernetesEnvoyHpaMetricObjectDescribedObject res."describedObject";
    "metric" = mkProviderKubernetesEnvoyHpaMetricObjectMetric res."metric";
    "target" = mkProviderKubernetesEnvoyHpaMetricObjectTarget res."target";
  };
  ProviderKubernetesEnvoyHpaMetricObjectTargetModule = types.submodule {
    options = {
      "averageUtilization" = mkOption {
        description = "averageUtilization is the target value of the average of the\nresource metric across all relevant pods, represented as a percentage of\nthe requested value of the resource for the pods.\nCurrently only valid for Resource metric source type";
        type = (types.nullOr types.int);
        default = null;
      };
      "averageValue" = mkOption {
        description = "averageValue is the target value of the average of the\nmetric across all relevant pods (as a quantity)";
        type = types.anything;
        default = { };
      };
      "type" = mkOption {
        description = "type represents whether the metric type is Utilization, Value, or AverageValue";
        type = types.str;
      };
      "value" = mkOption {
        description = "value is the target value of the metric (as a quantity).";
        type = types.anything;
        default = { };
      };
    };
  };
  mkProviderKubernetesEnvoyHpaMetricObjectTarget =
    res:
    {
    }
    // optionalAttrs (res."averageUtilization" != null) { inherit (res) "averageUtilization"; }
    // {
    }
    // optionalAttrs (res."averageValue" != null) { inherit (res) "averageValue"; }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  ProviderKubernetesEnvoyHpaMetricPodsMetricModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "name is the name of the given metric";
        type = types.str;
      };
      "selector" = mkOption {
        description = "selector is the string-encoded form of a standard kubernetes label selector for the given metric\nWhen set, it is passed as an additional parameter to the metrics server for more specific metrics scoping.\nWhen unset, just the metricName will be used to gather metrics.";
        type = (types.nullOr ProviderKubernetesEnvoyHpaMetricPodsMetricSelectorModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyHpaMetricPodsMetric =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."selector" != null) {
      "selector" = mkProviderKubernetesEnvoyHpaMetricPodsMetricSelector res."selector";
    }
    // {
    };
  ProviderKubernetesEnvoyHpaMetricPodsMetricSelectorMatchExpressionModule = types.submodule {
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
  mkProviderKubernetesEnvoyHpaMetricPodsMetricSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProviderKubernetesEnvoyHpaMetricPodsMetricSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf ProviderKubernetesEnvoyHpaMetricPodsMetricSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkProviderKubernetesEnvoyHpaMetricPodsMetricSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkProviderKubernetesEnvoyHpaMetricPodsMetricSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ProviderKubernetesEnvoyHpaMetricPodsModule = types.submodule {
    options = {
      "metric" = mkOption {
        description = "metric identifies the target metric by name and selector";
        type = ProviderKubernetesEnvoyHpaMetricPodsMetricModule;
      };
      "target" = mkOption {
        description = "target specifies the target value for the given metric";
        type = ProviderKubernetesEnvoyHpaMetricPodsTargetModule;
      };
    };
  };
  mkProviderKubernetesEnvoyHpaMetricPods = res: {
    "metric" = mkProviderKubernetesEnvoyHpaMetricPodsMetric res."metric";
    "target" = mkProviderKubernetesEnvoyHpaMetricPodsTarget res."target";
  };
  ProviderKubernetesEnvoyHpaMetricPodsTargetModule = types.submodule {
    options = {
      "averageUtilization" = mkOption {
        description = "averageUtilization is the target value of the average of the\nresource metric across all relevant pods, represented as a percentage of\nthe requested value of the resource for the pods.\nCurrently only valid for Resource metric source type";
        type = (types.nullOr types.int);
        default = null;
      };
      "averageValue" = mkOption {
        description = "averageValue is the target value of the average of the\nmetric across all relevant pods (as a quantity)";
        type = types.anything;
        default = { };
      };
      "type" = mkOption {
        description = "type represents whether the metric type is Utilization, Value, or AverageValue";
        type = types.str;
      };
      "value" = mkOption {
        description = "value is the target value of the metric (as a quantity).";
        type = types.anything;
        default = { };
      };
    };
  };
  mkProviderKubernetesEnvoyHpaMetricPodsTarget =
    res:
    {
    }
    // optionalAttrs (res."averageUtilization" != null) { inherit (res) "averageUtilization"; }
    // {
    }
    // optionalAttrs (res."averageValue" != null) { inherit (res) "averageValue"; }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  ProviderKubernetesEnvoyHpaMetricResourceModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "name is the name of the resource in question.";
        type = types.str;
      };
      "target" = mkOption {
        description = "target specifies the target value for the given metric";
        type = ProviderKubernetesEnvoyHpaMetricResourceTargetModule;
      };
    };
  };
  mkProviderKubernetesEnvoyHpaMetricResource = res: {
    inherit (res) "name";
    "target" = mkProviderKubernetesEnvoyHpaMetricResourceTarget res."target";
  };
  ProviderKubernetesEnvoyHpaMetricResourceTargetModule = types.submodule {
    options = {
      "averageUtilization" = mkOption {
        description = "averageUtilization is the target value of the average of the\nresource metric across all relevant pods, represented as a percentage of\nthe requested value of the resource for the pods.\nCurrently only valid for Resource metric source type";
        type = (types.nullOr types.int);
        default = null;
      };
      "averageValue" = mkOption {
        description = "averageValue is the target value of the average of the\nmetric across all relevant pods (as a quantity)";
        type = types.anything;
        default = { };
      };
      "type" = mkOption {
        description = "type represents whether the metric type is Utilization, Value, or AverageValue";
        type = types.str;
      };
      "value" = mkOption {
        description = "value is the target value of the metric (as a quantity).";
        type = types.anything;
        default = { };
      };
    };
  };
  mkProviderKubernetesEnvoyHpaMetricResourceTarget =
    res:
    {
    }
    // optionalAttrs (res."averageUtilization" != null) { inherit (res) "averageUtilization"; }
    // {
    }
    // optionalAttrs (res."averageValue" != null) { inherit (res) "averageValue"; }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  ProviderKubernetesEnvoyHpaModule = types.submodule {
    options = {
      "behavior" = mkOption {
        description = "behavior configures the scaling behavior of the target\nin both Up and Down directions (scaleUp and scaleDown fields respectively).\nIf not set, the default HPAScalingRules for scale up and scale down are used.\nSee k8s.io.autoscaling.v2.HorizontalPodAutoScalerBehavior.";
        type = (types.nullOr ProviderKubernetesEnvoyHpaBehaviorModule);
        default = null;
      };
      "maxReplicas" = mkOption {
        description = "maxReplicas is the upper limit for the number of replicas to which the autoscaler can scale up.\nIt cannot be less that minReplicas.";
        type = types.int;
      };
      "metrics" = mkOption {
        description = "metrics contains the specifications for which to use to calculate the\ndesired replica count (the maximum replica count across all metrics will\nbe used).\nIf left empty, it defaults to being based on CPU utilization with average on 80% usage.";
        type = (types.listOf ProviderKubernetesEnvoyHpaMetricModule);
        default = [ ];
      };
      "minReplicas" = mkOption {
        description = "minReplicas is the lower limit for the number of replicas to which the autoscaler\ncan scale down. It defaults to 1 replica.";
        type = (types.nullOr types.int);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the horizontalPodAutoScaler.\nWhen unset, this defaults to an autogenerated name.";
        type = (types.nullOr types.str);
        default = null;
      };
      "patch" = mkOption {
        description = "Patch defines how to perform the patch operation to the HorizontalPodAutoscaler";
        type = (types.nullOr ProviderKubernetesEnvoyHpaPatchModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyHpa =
    res:
    {
    }
    // optionalAttrs (res."behavior" != null) {
      "behavior" = mkProviderKubernetesEnvoyHpaBehavior res."behavior";
    }
    // {
      inherit (res) "maxReplicas";
    }
    // optionalAttrs (res."metrics" != [ ]) {
      "metrics" = map mkProviderKubernetesEnvoyHpaMetric res."metrics";
    }
    // {
    }
    // optionalAttrs (res."minReplicas" != null) { inherit (res) "minReplicas"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."patch" != null) { "patch" = mkProviderKubernetesEnvoyHpaPatch res."patch"; }
    // {
    };
  ProviderKubernetesEnvoyHpaPatchModule = types.submodule {
    options = {
      "type" = mkOption {
        description = "Type is the type of merge operation to perform\n\nBy default, StrategicMerge is used as the patch type.";
        type = (types.nullOr types.str);
        default = null;
      };
      "value" = mkOption {
        description = "Object contains the raw configuration for merged object";
        type = types.anything;
      };
    };
  };
  mkProviderKubernetesEnvoyHpaPatch =
    res:
    {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
      inherit (res) "value";
    };
  ProviderKubernetesEnvoyPDBModule = types.submodule {
    options = {
      "maxUnavailable" = mkOption {
        description = "MaxUnavailable specifies the maximum amount of pods (can be expressed as integers or as a percentage) that can be unavailable at all times during voluntary disruptions,\nsuch as node drains or updates. This setting ensures that your envoy proxy maintains a certain level of availability\nand resilience during maintenance operations. Cannot be combined with minAvailable.";
        type = types.anything;
        default = { };
      };
      "minAvailable" = mkOption {
        description = "MinAvailable specifies the minimum amount of pods (can be expressed as integers or as a percentage) that must be available at all times during voluntary disruptions,\nsuch as node drains or updates. This setting ensures that your envoy proxy maintains a certain level of availability\nand resilience during maintenance operations. Cannot be combined with maxUnavailable.";
        type = types.anything;
        default = { };
      };
      "name" = mkOption {
        description = "Name of the podDisruptionBudget.\nWhen unset, this defaults to an autogenerated name.";
        type = (types.nullOr types.str);
        default = null;
      };
      "patch" = mkOption {
        description = "Patch defines how to perform the patch operation to the PodDisruptionBudget";
        type = (types.nullOr ProviderKubernetesEnvoyPDBPatchModule);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyPDB =
    res:
    {
    }
    // optionalAttrs (res."maxUnavailable" != null) { inherit (res) "maxUnavailable"; }
    // {
    }
    // optionalAttrs (res."minAvailable" != null) { inherit (res) "minAvailable"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."patch" != null) { "patch" = mkProviderKubernetesEnvoyPDBPatch res."patch"; }
    // {
    };
  ProviderKubernetesEnvoyPDBPatchModule = types.submodule {
    options = {
      "type" = mkOption {
        description = "Type is the type of merge operation to perform\n\nBy default, StrategicMerge is used as the patch type.";
        type = (types.nullOr types.str);
        default = null;
      };
      "value" = mkOption {
        description = "Object contains the raw configuration for merged object";
        type = types.anything;
      };
    };
  };
  mkProviderKubernetesEnvoyPDBPatch =
    res:
    {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
      inherit (res) "value";
    };
  ProviderKubernetesEnvoyServiceAccountModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the Service Account.\nWhen unset, this defaults to an autogenerated name.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkProviderKubernetesEnvoyServiceAccount =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ProviderKubernetesEnvoyServiceModule = types.submodule {
    options = {
      "allocateLoadBalancerNodePorts" = mkOption {
        description = "AllocateLoadBalancerNodePorts defines if NodePorts will be automatically allocated for\nservices with type LoadBalancer. Default is \"true\". It may be set to \"false\" if the cluster\nload-balancer does not rely on NodePorts. If the caller requests specific NodePorts (by specifying a\nvalue), those requests will be respected, regardless of this field. This field may only be set for\nservices with type LoadBalancer and will be cleared if the type is changed to any other type.";
        type = types.bool;
        default = false;
      };
      "annotations" = mkOption {
        description = "Annotations that should be appended to the service.\nBy default, no annotations are appended.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "externalTrafficPolicy" = mkOption {
        description = "ExternalTrafficPolicy determines the externalTrafficPolicy for the Envoy Service. Valid options\nare Local and Cluster. Default is \"Local\". \"Local\" means traffic will only go to pods on the node\nreceiving the traffic. \"Cluster\" means connections are loadbalanced to all pods in the cluster.";
        type = (
          types.nullOr (
            types.enum [
              "Local"
              "Cluster"
            ]
          )
        );
        default = "Local";
      };
      "labels" = mkOption {
        description = "Labels that should be appended to the service.\nBy default, no labels are appended.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "loadBalancerClass" = mkOption {
        description = "LoadBalancerClass, when specified, allows for choosing the LoadBalancer provider\nimplementation if more than one are available or is otherwise expected to be specified";
        type = (types.nullOr types.str);
        default = null;
      };
      "loadBalancerIP" = mkOption {
        description = "LoadBalancerIP defines the IP Address of the underlying load balancer service. This field\nmay be ignored if the load balancer provider does not support this feature.\nThis field has been deprecated in Kubernetes, but it is still used for setting the IP Address in some cloud\nproviders such as GCP.";
        type = (types.nullOr types.str);
        default = null;
      };
      "loadBalancerSourceRanges" = mkOption {
        description = "LoadBalancerSourceRanges defines a list of allowed IP addresses which will be configured as\nfirewall rules on the platform providers load balancer. This is not guaranteed to be working as\nit happens outside of kubernetes and has to be supported and handled by the platform provider.\nThis field may only be set for services with type LoadBalancer and will be cleared if the type\nis changed to any other type.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "name" = mkOption {
        description = "Name of the service.\nWhen unset, this defaults to an autogenerated name.";
        type = (types.nullOr types.str);
        default = null;
      };
      "patch" = mkOption {
        description = "Patch defines how to perform the patch operation to the service";
        type = (types.nullOr ProviderKubernetesEnvoyServicePatchModule);
        default = null;
      };
      "type" = mkOption {
        description = "Type determines how the Service is exposed. Defaults to LoadBalancer.\nValid options are ClusterIP, LoadBalancer and NodePort.\n\"LoadBalancer\" means a service will be exposed via an external load balancer (if the cloud provider supports it).\n\"ClusterIP\" means a service will only be accessible inside the cluster, via the cluster IP.\n\"NodePort\" means a service will be exposed on a static Port on all Nodes of the cluster.";
        type = (
          types.nullOr (
            types.enum [
              "ClusterIP"
              "LoadBalancer"
              "NodePort"
            ]
          )
        );
        default = "LoadBalancer";
      };
    };
  };
  mkProviderKubernetesEnvoyService =
    res:
    {
    }
    // optionalAttrs res."allocateLoadBalancerNodePorts" {
      inherit (res) "allocateLoadBalancerNodePorts";
    }
    // {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."externalTrafficPolicy" != null) { inherit (res) "externalTrafficPolicy"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."loadBalancerClass" != null) { inherit (res) "loadBalancerClass"; }
    // {
    }
    // optionalAttrs (res."loadBalancerIP" != null) { inherit (res) "loadBalancerIP"; }
    // {
    }
    // optionalAttrs (res."loadBalancerSourceRanges" != [ ]) {
      inherit (res) "loadBalancerSourceRanges";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."patch" != null) {
      "patch" = mkProviderKubernetesEnvoyServicePatch res."patch";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ProviderKubernetesEnvoyServicePatchModule = types.submodule {
    options = {
      "type" = mkOption {
        description = "Type is the type of merge operation to perform\n\nBy default, StrategicMerge is used as the patch type.";
        type = (types.nullOr types.str);
        default = null;
      };
      "value" = mkOption {
        description = "Object contains the raw configuration for merged object";
        type = types.anything;
      };
    };
  };
  mkProviderKubernetesEnvoyServicePatch =
    res:
    {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
      inherit (res) "value";
    };
  ProviderKubernetesModule = types.submodule {
    options = {
      "envoyDaemonSet" = mkOption {
        description = "EnvoyDaemonSet defines the desired state of the Envoy daemonset resource.\nDisabled by default, a deployment resource is used instead to provision the Envoy Proxy fleet";
        type = (types.nullOr ProviderKubernetesEnvoyDaemonSetModule);
        default = null;
      };
      "envoyDeployment" = mkOption {
        description = "EnvoyDeployment defines the desired state of the Envoy deployment resource.\nIf unspecified, default settings for the managed Envoy deployment resource\nare applied.";
        type = (types.nullOr ProviderKubernetesEnvoyDeploymentModule);
        default = null;
      };
      "envoyHpa" = mkOption {
        description = "EnvoyHpa defines the Horizontal Pod Autoscaler settings for Envoy Proxy Deployment.";
        type = (types.nullOr ProviderKubernetesEnvoyHpaModule);
        default = null;
      };
      "envoyPDB" = mkOption {
        description = "EnvoyPDB allows to control the pod disruption budget of an Envoy Proxy.";
        type = (types.nullOr ProviderKubernetesEnvoyPDBModule);
        default = null;
      };
      "envoyService" = mkOption {
        description = "EnvoyService defines the desired state of the Envoy service resource.\nIf unspecified, default settings for the managed Envoy service resource\nare applied.";
        type = (types.nullOr ProviderKubernetesEnvoyServiceModule);
        default = null;
      };
      "envoyServiceAccount" = mkOption {
        description = "EnvoyServiceAccount defines the desired state of the Envoy service account resource.";
        type = (types.nullOr ProviderKubernetesEnvoyServiceAccountModule);
        default = null;
      };
      "useListenerPortAsContainerPort" = mkOption {
        description = "UseListenerPortAsContainerPort disables the port shifting feature in the Envoy Proxy.\nWhen set to false (default value), if the service port is a privileged port (1-1023), add a constant to the value converting it into an ephemeral port.\nThis allows the container to bind to the port without needing a CAP_NET_BIND_SERVICE capability.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkProviderKubernetes =
    res:
    {
    }
    // optionalAttrs (res."envoyDaemonSet" != null) {
      "envoyDaemonSet" = mkProviderKubernetesEnvoyDaemonSet res."envoyDaemonSet";
    }
    // {
    }
    // optionalAttrs (res."envoyDeployment" != null) {
      "envoyDeployment" = mkProviderKubernetesEnvoyDeployment res."envoyDeployment";
    }
    // {
    }
    // optionalAttrs (res."envoyHpa" != null) {
      "envoyHpa" = mkProviderKubernetesEnvoyHpa res."envoyHpa";
    }
    // {
    }
    // optionalAttrs (res."envoyPDB" != null) {
      "envoyPDB" = mkProviderKubernetesEnvoyPDB res."envoyPDB";
    }
    // {
    }
    // optionalAttrs (res."envoyService" != null) {
      "envoyService" = mkProviderKubernetesEnvoyService res."envoyService";
    }
    // {
    }
    // optionalAttrs (res."envoyServiceAccount" != null) {
      "envoyServiceAccount" = mkProviderKubernetesEnvoyServiceAccount res."envoyServiceAccount";
    }
    // {
    }
    // optionalAttrs res."useListenerPortAsContainerPort" {
      inherit (res) "useListenerPortAsContainerPort";
    }
    // {
    };
  ProviderModule = types.submodule {
    options = {
      "kubernetes" = mkOption {
        description = "Kubernetes defines the desired state of the Kubernetes resource provider.\nKubernetes provides infrastructure resources for running the data plane,\ne.g. Envoy proxy. If unspecified and type is \"Kubernetes\", default settings\nfor managed Kubernetes resources are applied.";
        type = (types.nullOr ProviderKubernetesModule);
        default = null;
      };
      "type" = mkOption {
        description = "Type is the type of resource provider to use. A resource provider provides\ninfrastructure resources for running the data plane, e.g. Envoy proxy, and\noptional auxiliary control planes. Supported types are \"Kubernetes\".";
        type = (
          types.enum [
            "Kubernetes"
            "Custom"
          ]
        );
      };
    };
  };
  mkProvider =
    res:
    {
    }
    // optionalAttrs (res."kubernetes" != null) {
      "kubernetes" = mkProviderKubernetes res."kubernetes";
    }
    // {
      inherit (res) "type";
    };
  ShutdownModule = types.submodule {
    options = {
      "drainTimeout" = mkOption {
        description = "DrainTimeout defines the graceful drain timeout. This should be less than the pod's terminationGracePeriodSeconds.\nIf unspecified, defaults to 60 seconds.";
        type = (types.nullOr types.str);
        default = null;
      };
      "minDrainDuration" = mkOption {
        description = "MinDrainDuration defines the minimum drain duration allowing time for endpoint deprogramming to complete.\nIf unspecified, defaults to 10 seconds.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkShutdown =
    res:
    {
    }
    // optionalAttrs (res."drainTimeout" != null) { inherit (res) "drainTimeout"; }
    // {
    }
    // optionalAttrs (res."minDrainDuration" != null) { inherit (res) "minDrainDuration"; }
    // {
    };
  TelemetryAccessLogModule = types.submodule {
    options = {
      "disable" = mkOption {
        description = "Disable disables access logging for managed proxies if set to true.";
        type = types.bool;
        default = false;
      };
      "settings" = mkOption {
        description = "Settings defines accesslog settings for managed proxies.\nIf unspecified, will send default format to stdout.";
        type = (types.listOf TelemetryAccessLogSettingModule);
        default = [ ];
      };
    };
  };
  mkTelemetryAccessLog =
    res:
    {
    }
    // optionalAttrs res."disable" { inherit (res) "disable"; }
    // {
    }
    // optionalAttrs (res."settings" != [ ]) {
      "settings" = map mkTelemetryAccessLogSetting res."settings";
    }
    // {
    };
  TelemetryAccessLogSettingFormatModule = types.submodule {
    options = {
      "json" = mkOption {
        description = "JSON is additional attributes that describe the specific event occurrence.\nStructured format for the envoy access logs. Envoy [command operators](https://www.envoyproxy.io/docs/envoy/latest/configuration/observability/access_log/usage#command-operators)\ncan be used as values for fields within the Struct.\nIt's required when the format type is \"JSON\".";
        type = (types.attrsOf types.str);
        default = { };
      };
      "text" = mkOption {
        description = "Text defines the text accesslog format, following Envoy accesslog formatting,\nIt's required when the format type is \"Text\".\nEnvoy [command operators](https://www.envoyproxy.io/docs/envoy/latest/configuration/observability/access_log/usage#command-operators) may be used in the format.\nThe [format string documentation](https://www.envoyproxy.io/docs/envoy/latest/configuration/observability/access_log/usage#config-access-log-format-strings) provides more information.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Type defines the type of accesslog format.";
        type = (
          types.nullOr (
            types.enum [
              "Text"
              "JSON"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkTelemetryAccessLogSettingFormat =
    res:
    {
    }
    // optionalAttrs (res."json" != { }) { inherit (res) "json"; }
    // {
    }
    // optionalAttrs (res."text" != null) { inherit (res) "text"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  TelemetryAccessLogSettingModule = types.submodule {
    options = {
      "format" = mkOption {
        description = "Format defines the format of accesslog.\nThis will be ignored if sink type is ALS.";
        type = (types.nullOr TelemetryAccessLogSettingFormatModule);
        default = null;
      };
      "matches" = mkOption {
        description = "Matches defines the match conditions for accesslog in CEL expression.\nAn accesslog will be emitted only when one or more match conditions are evaluated to true.\nInvalid [CEL](https://www.envoyproxy.io/docs/envoy/latest/xds/type/v3/cel.proto.html#common-expression-language-cel-proto) expressions will be ignored.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "sinks" = mkOption {
        description = "Sinks defines the sinks of accesslog.";
        type = (types.listOf TelemetryAccessLogSettingSinkModule);
      };
      "type" = mkOption {
        description = "Type defines the component emitting the accesslog, such as Listener and Route.\nIf type not defined, the setting would apply to:\n(1) All Routes.\n(2) Listeners if and only if Envoy does not find a matching route for a request.\nIf type is defined, the accesslog settings would apply to the relevant component (as-is).";
        type = (
          types.nullOr (
            types.enum [
              "Listener"
              "Route"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkTelemetryAccessLogSetting =
    res:
    {
    }
    // optionalAttrs (res."format" != null) {
      "format" = mkTelemetryAccessLogSettingFormat res."format";
    }
    // {
    }
    // optionalAttrs (res."matches" != [ ]) { inherit (res) "matches"; }
    // {
      "sinks" = map mkTelemetryAccessLogSettingSink res."sinks";
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  TelemetryAccessLogSettingSinkAlsBackendRefModule = types.submodule {
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
  mkTelemetryAccessLogSettingSinkAlsBackendRef =
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
  TelemetryAccessLogSettingSinkAlsBackendSettingsCircuitBreakerModule = types.submodule {
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
        type = (
          types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsCircuitBreakerPerEndpointModule
        );
        default = null;
      };
    };
  };
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsCircuitBreaker =
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
      "perEndpoint" =
        mkTelemetryAccessLogSettingSinkAlsBackendSettingsCircuitBreakerPerEndpoint
          res."perEndpoint";
    }
    // {
    };
  TelemetryAccessLogSettingSinkAlsBackendSettingsCircuitBreakerPerEndpointModule = types.submodule {
    options = {
      "maxConnections" = mkOption {
        description = "MaxConnections configures the maximum number of connections that Envoy will establish per-endpoint to the referenced backend defined within a xRoute rule.";
        type = (types.nullOr types.int);
        default = 1024;
      };
    };
  };
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsCircuitBreakerPerEndpoint =
    res:
    {
    }
    // optionalAttrs (res."maxConnections" != null) { inherit (res) "maxConnections"; }
    // {
    };
  TelemetryAccessLogSettingSinkAlsBackendSettingsConnectionModule = types.submodule {
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
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsConnection =
    res:
    {
    }
    // optionalAttrs (res."bufferLimit" != null) { inherit (res) "bufferLimit"; }
    // {
    }
    // optionalAttrs (res."socketBufferLimit" != null) { inherit (res) "socketBufferLimit"; }
    // {
    };
  TelemetryAccessLogSettingSinkAlsBackendSettingsDnsModule = types.submodule {
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
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsDns =
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
  TelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveGrpcModule = types.submodule {
    options = {
      "service" = mkOption {
        description = "Service to send in the health check request.\nIf this is not specified, then the health check request applies to the entire\nserver and not to a specific service.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveGrpc =
    res:
    {
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  TelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveHttpExpectedResponseModule =
    types.submodule
      {
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
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveHttpExpectedResponse =
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
  TelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveHttpModule = types.submodule {
    options = {
      "expectedResponse" = mkOption {
        description = "ExpectedResponse defines a list of HTTP expected responses to match.";
        type = (
          types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveHttpExpectedResponseModule
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
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveHttp =
    res:
    {
    }
    // optionalAttrs (res."expectedResponse" != null) {
      "expectedResponse" =
        mkTelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveHttpExpectedResponse
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
  TelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveModule = types.submodule {
    options = {
      "grpc" = mkOption {
        description = "GRPC defines the configuration of the GRPC health checker.\nIt's optional, and can only be used if the specified type is GRPC.";
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveGrpcModule);
        default = null;
      };
      "healthyThreshold" = mkOption {
        description = "HealthyThreshold defines the number of healthy health checks required before a backend host is marked healthy.";
        type = (types.nullOr types.int);
        default = 1;
      };
      "http" = mkOption {
        description = "HTTP defines the configuration of http health checker.\nIt's required while the health checker type is HTTP.";
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveHttpModule);
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
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveTcpModule);
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
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActive =
    res:
    {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkTelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."healthyThreshold" != null) { inherit (res) "healthyThreshold"; }
    // {
    }
    // optionalAttrs (res."http" != null) {
      "http" = mkTelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveHttp res."http";
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
      "tcp" = mkTelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveTcp res."tcp";
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
  TelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveTcpModule = types.submodule {
    options = {
      "receive" = mkOption {
        description = "Receive defines the expected response payload.";
        type = (
          types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveTcpReceiveModule
        );
        default = null;
      };
      "send" = mkOption {
        description = "Send defines the request payload.";
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveTcpSendModule);
        default = null;
      };
    };
  };
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveTcp =
    res:
    {
    }
    // optionalAttrs (res."receive" != null) {
      "receive" =
        mkTelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveTcpReceive
          res."receive";
    }
    // {
    }
    // optionalAttrs (res."send" != null) {
      "send" = mkTelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveTcpSend res."send";
    }
    // {
    };
  TelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveTcpReceiveModule = types.submodule {
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
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveTcpReceive =
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
  TelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveTcpSendModule = types.submodule {
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
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveTcpSend =
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
  TelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckModule = types.submodule {
    options = {
      "active" = mkOption {
        description = "Active health check configuration";
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActiveModule);
        default = null;
      };
      "panicThreshold" = mkOption {
        description = "When number of unhealthy endpoints for a backend reaches this threshold\nEnvoy will disregard health status and balance across all endpoints.\nIt's designed to prevent a situation in which host failures cascade throughout the cluster\nas load increases. If not set, the default value is 50%. To disable panic mode, set value to `0`.";
        type = (types.nullOr types.int);
        default = null;
      };
      "passive" = mkOption {
        description = "Passive passive check configuration";
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckPassiveModule);
        default = null;
      };
    };
  };
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheck =
    res:
    {
    }
    // optionalAttrs (res."active" != null) {
      "active" = mkTelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckActive res."active";
    }
    // {
    }
    // optionalAttrs (res."panicThreshold" != null) { inherit (res) "panicThreshold"; }
    // {
    }
    // optionalAttrs (res."passive" != null) {
      "passive" = mkTelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckPassive res."passive";
    }
    // {
    };
  TelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckPassiveModule = types.submodule {
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
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckPassive =
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
  TelemetryAccessLogSettingSinkAlsBackendSettingsHttp2Module = types.submodule {
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
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsHttp2 =
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
  TelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerConsistentHashCookieModule =
    types.submodule
      {
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
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerConsistentHashCookie =
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
  TelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerConsistentHashHeaderModule =
    types.submodule
      {
        options = {
          "name" = mkOption {
            description = "Name of the header to hash.";
            type = types.str;
          };
        };
      };
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerConsistentHashHeader = res: {
    inherit (res) "name";
  };
  TelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerConsistentHashModule = types.submodule {
    options = {
      "cookie" = mkOption {
        description = "Cookie configures the cookie hash policy when the consistent hash type is set to Cookie.";
        type = (
          types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerConsistentHashCookieModule
        );
        default = null;
      };
      "header" = mkOption {
        description = "Header configures the header hash policy when the consistent hash type is set to Header.";
        type = (
          types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerConsistentHashHeaderModule
        );
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
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerConsistentHash =
    res:
    {
    }
    // optionalAttrs (res."cookie" != null) {
      "cookie" =
        mkTelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerConsistentHashCookie
          res."cookie";
    }
    // {
    }
    // optionalAttrs (res."header" != null) {
      "header" =
        mkTelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerConsistentHashHeader
          res."header";
    }
    // {
    }
    // optionalAttrs (res."tableSize" != null) { inherit (res) "tableSize"; }
    // {
      inherit (res) "type";
    };
  TelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerEndpointOverrideExtractFromModule =
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
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerEndpointOverrideExtractFrom =
    res:
    {
    }
    // optionalAttrs (res."header" != null) { inherit (res) "header"; }
    // {
    };
  TelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerEndpointOverrideModule =
    types.submodule
      {
        options = {
          "extractFrom" = mkOption {
            description = "ExtractFrom defines the sources to extract endpoint override information from.";
            type = (
              types.listOf TelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerEndpointOverrideExtractFromModule
            );
          };
        };
      };
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerEndpointOverride = res: {
    "extractFrom" =
      map mkTelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerEndpointOverrideExtractFrom
        res."extractFrom";
  };
  TelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerModule = types.submodule {
    options = {
      "consistentHash" = mkOption {
        description = "ConsistentHash defines the configuration when the load balancer type is\nset to ConsistentHash";
        type = (
          types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerConsistentHashModule
        );
        default = null;
      };
      "endpointOverride" = mkOption {
        description = "EndpointOverride defines the configuration for endpoint override.\nWhen specified, the load balancer will attempt to route requests to endpoints\nbased on the override information extracted from request headers or metadata.\n If the override endpoints are not available, the configured load balancer policy will be used as fallback.";
        type = (
          types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerEndpointOverrideModule
        );
        default = null;
      };
      "slowStart" = mkOption {
        description = "SlowStart defines the configuration related to the slow start load balancer policy.\nIf set, during slow start window, traffic sent to the newly added hosts will gradually increase.\nCurrently this is only supported for RoundRobin and LeastRequest load balancers";
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerSlowStartModule);
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
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerZoneAwareModule);
        default = null;
      };
    };
  };
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancer =
    res:
    {
    }
    // optionalAttrs (res."consistentHash" != null) {
      "consistentHash" =
        mkTelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerConsistentHash
          res."consistentHash";
    }
    // {
    }
    // optionalAttrs (res."endpointOverride" != null) {
      "endpointOverride" =
        mkTelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerEndpointOverride
          res."endpointOverride";
    }
    // {
    }
    // optionalAttrs (res."slowStart" != null) {
      "slowStart" =
        mkTelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerSlowStart
          res."slowStart";
    }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."zoneAware" != null) {
      "zoneAware" =
        mkTelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerZoneAware
          res."zoneAware";
    }
    // {
    };
  TelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerSlowStartModule = types.submodule {
    options = {
      "window" = mkOption {
        description = "Window defines the duration of the warm up period for newly added host.\nDuring slow start window, traffic sent to the newly added hosts will gradually increase.\nCurrently only supports linear growth of traffic. For additional details,\nsee https://www.envoyproxy.io/docs/envoy/latest/api-v3/config/cluster/v3/cluster.proto#config-cluster-v3-cluster-slowstartconfig";
        type = types.str;
      };
    };
  };
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerSlowStart = res: {
    inherit (res) "window";
  };
  TelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerZoneAwareModule = types.submodule {
    options = {
      "preferLocal" = mkOption {
        description = "PreferLocalZone configures zone-aware routing to prefer sending traffic to the local locality zone.";
        type = (
          types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerZoneAwarePreferLocalModule
        );
        default = null;
      };
    };
  };
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerZoneAware =
    res:
    {
    }
    // optionalAttrs (res."preferLocal" != null) {
      "preferLocal" =
        mkTelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerZoneAwarePreferLocal
          res."preferLocal";
    }
    // {
    };
  TelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerZoneAwarePreferLocalForceModule =
    types.submodule
      {
        options = {
          "minEndpointsInZoneThreshold" = mkOption {
            description = "MinEndpointsInZoneThreshold is the minimum number of upstream endpoints in the local zone required to honor the forceLocalZone\noverride. This is useful for protecting zones with fewer endpoints.";
            type = (types.nullOr types.int);
            default = null;
          };
        };
      };
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerZoneAwarePreferLocalForce =
    res:
    {
    }
    // optionalAttrs (res."minEndpointsInZoneThreshold" != null) {
      inherit (res) "minEndpointsInZoneThreshold";
    }
    // {
    };
  TelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerZoneAwarePreferLocalModule =
    types.submodule
      {
        options = {
          "force" = mkOption {
            description = "ForceLocalZone defines override configuration for forcing all traffic to stay within the local zone instead of the default behavior\nwhich maintains equal distribution among upstream endpoints while sending as much traffic as possible locally.";
            type = (
              types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerZoneAwarePreferLocalForceModule
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
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerZoneAwarePreferLocal =
    res:
    {
    }
    // optionalAttrs (res."force" != null) {
      "force" =
        mkTelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerZoneAwarePreferLocalForce
          res."force";
    }
    // {
    }
    // optionalAttrs (res."minEndpointsThreshold" != null) { inherit (res) "minEndpointsThreshold"; }
    // {
    };
  TelemetryAccessLogSettingSinkAlsBackendSettingsModule = types.submodule {
    options = {
      "circuitBreaker" = mkOption {
        description = "Circuit Breaker settings for the upstream connections and requests.\nIf not set, circuit breakers will be enabled with the default thresholds";
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsCircuitBreakerModule);
        default = null;
      };
      "connection" = mkOption {
        description = "Connection includes backend connection settings.";
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsConnectionModule);
        default = null;
      };
      "dns" = mkOption {
        description = "DNS includes dns resolution settings.";
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsDnsModule);
        default = null;
      };
      "healthCheck" = mkOption {
        description = "HealthCheck allows gateway to perform active health checking on backends.";
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheckModule);
        default = null;
      };
      "http2" = mkOption {
        description = "HTTP2 provides HTTP/2 configuration for backend connections.";
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsHttp2Module);
        default = null;
      };
      "loadBalancer" = mkOption {
        description = "LoadBalancer policy to apply when routing traffic from the gateway to\nthe backend endpoints. Defaults to `LeastRequest`.";
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancerModule);
        default = null;
      };
      "proxyProtocol" = mkOption {
        description = "ProxyProtocol enables the Proxy Protocol when communicating with the backend.";
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsProxyProtocolModule);
        default = null;
      };
      "retry" = mkOption {
        description = "Retry provides more advanced usage, allowing users to customize the number of retries, retry fallback strategy, and retry triggering conditions.\nIf not set, retry will be disabled.";
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsRetryModule);
        default = null;
      };
      "tcpKeepalive" = mkOption {
        description = "TcpKeepalive settings associated with the upstream client connection.\nDisabled by default.";
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsTcpKeepaliveModule);
        default = null;
      };
      "timeout" = mkOption {
        description = "Timeout settings for the backend connections.";
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsTimeoutModule);
        default = null;
      };
    };
  };
  mkTelemetryAccessLogSettingSinkAlsBackendSettings =
    res:
    {
    }
    // optionalAttrs (res."circuitBreaker" != null) {
      "circuitBreaker" =
        mkTelemetryAccessLogSettingSinkAlsBackendSettingsCircuitBreaker
          res."circuitBreaker";
    }
    // {
    }
    // optionalAttrs (res."connection" != null) {
      "connection" = mkTelemetryAccessLogSettingSinkAlsBackendSettingsConnection res."connection";
    }
    // {
    }
    // optionalAttrs (res."dns" != null) {
      "dns" = mkTelemetryAccessLogSettingSinkAlsBackendSettingsDns res."dns";
    }
    // {
    }
    // optionalAttrs (res."healthCheck" != null) {
      "healthCheck" = mkTelemetryAccessLogSettingSinkAlsBackendSettingsHealthCheck res."healthCheck";
    }
    // {
    }
    // optionalAttrs (res."http2" != null) {
      "http2" = mkTelemetryAccessLogSettingSinkAlsBackendSettingsHttp2 res."http2";
    }
    // {
    }
    // optionalAttrs (res."loadBalancer" != null) {
      "loadBalancer" = mkTelemetryAccessLogSettingSinkAlsBackendSettingsLoadBalancer res."loadBalancer";
    }
    // {
    }
    // optionalAttrs (res."proxyProtocol" != null) {
      "proxyProtocol" =
        mkTelemetryAccessLogSettingSinkAlsBackendSettingsProxyProtocol
          res."proxyProtocol";
    }
    // {
    }
    // optionalAttrs (res."retry" != null) {
      "retry" = mkTelemetryAccessLogSettingSinkAlsBackendSettingsRetry res."retry";
    }
    // {
    }
    // optionalAttrs (res."tcpKeepalive" != null) {
      "tcpKeepalive" = mkTelemetryAccessLogSettingSinkAlsBackendSettingsTcpKeepalive res."tcpKeepalive";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) {
      "timeout" = mkTelemetryAccessLogSettingSinkAlsBackendSettingsTimeout res."timeout";
    }
    // {
    };
  TelemetryAccessLogSettingSinkAlsBackendSettingsProxyProtocolModule = types.submodule {
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
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsProxyProtocol = res: {
    inherit (res) "version";
  };
  TelemetryAccessLogSettingSinkAlsBackendSettingsRetryModule = types.submodule {
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
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsRetryPerRetryModule);
        default = null;
      };
      "retryOn" = mkOption {
        description = "RetryOn specifies the retry trigger condition.\n\nIf not specified, the default is to retry on connect-failure,refused-stream,unavailable,cancelled,retriable-status-codes(503).";
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsRetryRetryOnModule);
        default = null;
      };
    };
  };
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsRetry =
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
      "perRetry" = mkTelemetryAccessLogSettingSinkAlsBackendSettingsRetryPerRetry res."perRetry";
    }
    // {
    }
    // optionalAttrs (res."retryOn" != null) {
      "retryOn" = mkTelemetryAccessLogSettingSinkAlsBackendSettingsRetryRetryOn res."retryOn";
    }
    // {
    };
  TelemetryAccessLogSettingSinkAlsBackendSettingsRetryPerRetryBackOffModule = types.submodule {
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
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsRetryPerRetryBackOff =
    res:
    {
    }
    // optionalAttrs (res."baseInterval" != null) { inherit (res) "baseInterval"; }
    // {
    }
    // optionalAttrs (res."maxInterval" != null) { inherit (res) "maxInterval"; }
    // {
    };
  TelemetryAccessLogSettingSinkAlsBackendSettingsRetryPerRetryModule = types.submodule {
    options = {
      "backOff" = mkOption {
        description = "Backoff is the backoff policy to be applied per retry attempt. gateway uses a fully jittered exponential\nback-off algorithm for retries. For additional details,\nsee https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/router_filter#config-http-filters-router-x-envoy-max-retries";
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsRetryPerRetryBackOffModule);
        default = null;
      };
      "timeout" = mkOption {
        description = "Timeout is the timeout per retry attempt.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsRetryPerRetry =
    res:
    {
    }
    // optionalAttrs (res."backOff" != null) {
      "backOff" = mkTelemetryAccessLogSettingSinkAlsBackendSettingsRetryPerRetryBackOff res."backOff";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    };
  TelemetryAccessLogSettingSinkAlsBackendSettingsRetryRetryOnModule = types.submodule {
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
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsRetryRetryOn =
    res:
    {
    }
    // optionalAttrs (res."httpStatusCodes" != [ ]) { inherit (res) "httpStatusCodes"; }
    // {
    }
    // optionalAttrs (res."triggers" != [ ]) { inherit (res) "triggers"; }
    // {
    };
  TelemetryAccessLogSettingSinkAlsBackendSettingsTcpKeepaliveModule = types.submodule {
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
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsTcpKeepalive =
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
  TelemetryAccessLogSettingSinkAlsBackendSettingsTimeoutHttpModule = types.submodule {
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
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsTimeoutHttp =
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
  TelemetryAccessLogSettingSinkAlsBackendSettingsTimeoutModule = types.submodule {
    options = {
      "http" = mkOption {
        description = "Timeout settings for HTTP.";
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsTimeoutHttpModule);
        default = null;
      };
      "tcp" = mkOption {
        description = "Timeout settings for TCP.";
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsTimeoutTcpModule);
        default = null;
      };
    };
  };
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsTimeout =
    res:
    {
    }
    // optionalAttrs (res."http" != null) {
      "http" = mkTelemetryAccessLogSettingSinkAlsBackendSettingsTimeoutHttp res."http";
    }
    // {
    }
    // optionalAttrs (res."tcp" != null) {
      "tcp" = mkTelemetryAccessLogSettingSinkAlsBackendSettingsTimeoutTcp res."tcp";
    }
    // {
    };
  TelemetryAccessLogSettingSinkAlsBackendSettingsTimeoutTcpModule = types.submodule {
    options = {
      "connectTimeout" = mkOption {
        description = "The timeout for network connection establishment, including TCP and TLS handshakes.\nDefault: 10 seconds.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTelemetryAccessLogSettingSinkAlsBackendSettingsTimeoutTcp =
    res:
    {
    }
    // optionalAttrs (res."connectTimeout" != null) { inherit (res) "connectTimeout"; }
    // {
    };
  TelemetryAccessLogSettingSinkAlsHttpModule = types.submodule {
    options = {
      "requestHeaders" = mkOption {
        description = "RequestHeaders defines request headers to include in log entries sent to the access log service.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "responseHeaders" = mkOption {
        description = "ResponseHeaders defines response headers to include in log entries sent to the access log service.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "responseTrailers" = mkOption {
        description = "ResponseTrailers defines response trailers to include in log entries sent to the access log service.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkTelemetryAccessLogSettingSinkAlsHttp =
    res:
    {
    }
    // optionalAttrs (res."requestHeaders" != [ ]) { inherit (res) "requestHeaders"; }
    // {
    }
    // optionalAttrs (res."responseHeaders" != [ ]) { inherit (res) "responseHeaders"; }
    // {
    }
    // optionalAttrs (res."responseTrailers" != [ ]) { inherit (res) "responseTrailers"; }
    // {
    };
  TelemetryAccessLogSettingSinkAlsModule = types.submodule {
    options = {
      "backendRef" = mkOption {
        description = "BackendRef references a Kubernetes object that represents the\nbackend server to which the authorization request will be sent.\n\nDeprecated: Use BackendRefs instead.";
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsBackendRefModule);
        default = null;
      };
      "backendRefs" = mkOption {
        description = "BackendRefs references a Kubernetes object that represents the\nbackend server to which the authorization request will be sent.";
        type = (types.listOf TelemetryAccessLogSettingSinkAlsBackendRefModule);
        default = [ ];
      };
      "backendSettings" = mkOption {
        description = "BackendSettings holds configuration for managing the connection\nto the backend.";
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsBackendSettingsModule);
        default = null;
      };
      "http" = mkOption {
        description = "HTTP defines additional configuration specific to HTTP access logs.";
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsHttpModule);
        default = null;
      };
      "logName" = mkOption {
        description = "LogName defines the friendly name of the access log to be returned in\nStreamAccessLogsMessage.Identifier. This allows the access log server\nto differentiate between different access logs coming from the same Envoy.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Type defines the type of accesslog. Supported types are \"HTTP\" and \"TCP\".";
        type = (
          types.enum [
            "HTTP"
            "TCP"
          ]
        );
      };
    };
  };
  mkTelemetryAccessLogSettingSinkAls =
    res:
    {
    }
    // optionalAttrs (res."backendRef" != null) {
      "backendRef" = mkTelemetryAccessLogSettingSinkAlsBackendRef res."backendRef";
    }
    // {
    }
    // optionalAttrs (res."backendRefs" != [ ]) {
      "backendRefs" = map mkTelemetryAccessLogSettingSinkAlsBackendRef res."backendRefs";
    }
    // {
    }
    // optionalAttrs (res."backendSettings" != null) {
      "backendSettings" = mkTelemetryAccessLogSettingSinkAlsBackendSettings res."backendSettings";
    }
    // {
    }
    // optionalAttrs (res."http" != null) {
      "http" = mkTelemetryAccessLogSettingSinkAlsHttp res."http";
    }
    // {
    }
    // optionalAttrs (res."logName" != null) { inherit (res) "logName"; }
    // {
      inherit (res) "type";
    };
  TelemetryAccessLogSettingSinkFileModule = types.submodule {
    options = {
      "path" = mkOption {
        description = "Path defines the file path used to expose envoy access log(e.g. /dev/stdout).";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTelemetryAccessLogSettingSinkFile =
    res:
    {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    };
  TelemetryAccessLogSettingSinkModule = types.submodule {
    options = {
      "als" = mkOption {
        description = "ALS defines the gRPC Access Log Service (ALS) sink.";
        type = (types.nullOr TelemetryAccessLogSettingSinkAlsModule);
        default = null;
      };
      "file" = mkOption {
        description = "File defines the file accesslog sink.";
        type = (types.nullOr TelemetryAccessLogSettingSinkFileModule);
        default = null;
      };
      "openTelemetry" = mkOption {
        description = "OpenTelemetry defines the OpenTelemetry accesslog sink.";
        type = (types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryModule);
        default = null;
      };
      "type" = mkOption {
        description = "Type defines the type of accesslog sink.";
        type = (
          types.nullOr (
            types.enum [
              "ALS"
              "File"
              "OpenTelemetry"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkTelemetryAccessLogSettingSink =
    res:
    {
    }
    // optionalAttrs (res."als" != null) { "als" = mkTelemetryAccessLogSettingSinkAls res."als"; }
    // {
    }
    // optionalAttrs (res."file" != null) { "file" = mkTelemetryAccessLogSettingSinkFile res."file"; }
    // {
    }
    // optionalAttrs (res."openTelemetry" != null) {
      "openTelemetry" = mkTelemetryAccessLogSettingSinkOpenTelemetry res."openTelemetry";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  TelemetryAccessLogSettingSinkOpenTelemetryBackendRefModule = types.submodule {
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
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendRef =
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
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsCircuitBreakerModule = types.submodule {
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
        type = (
          types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsCircuitBreakerPerEndpointModule
        );
        default = null;
      };
    };
  };
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsCircuitBreaker =
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
      "perEndpoint" =
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsCircuitBreakerPerEndpoint
          res."perEndpoint";
    }
    // {
    };
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsCircuitBreakerPerEndpointModule =
    types.submodule
      {
        options = {
          "maxConnections" = mkOption {
            description = "MaxConnections configures the maximum number of connections that Envoy will establish per-endpoint to the referenced backend defined within a xRoute rule.";
            type = (types.nullOr types.int);
            default = 1024;
          };
        };
      };
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsCircuitBreakerPerEndpoint =
    res:
    {
    }
    // optionalAttrs (res."maxConnections" != null) { inherit (res) "maxConnections"; }
    // {
    };
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsConnectionModule = types.submodule {
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
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsConnection =
    res:
    {
    }
    // optionalAttrs (res."bufferLimit" != null) { inherit (res) "bufferLimit"; }
    // {
    }
    // optionalAttrs (res."socketBufferLimit" != null) { inherit (res) "socketBufferLimit"; }
    // {
    };
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsDnsModule = types.submodule {
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
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsDns =
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
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveGrpcModule =
    types.submodule
      {
        options = {
          "service" = mkOption {
            description = "Service to send in the health check request.\nIf this is not specified, then the health check request applies to the entire\nserver and not to a specific service.";
            type = (types.nullOr types.str);
            default = null;
          };
        };
      };
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveGrpc =
    res:
    {
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveHttpExpectedResponseModule =
    types.submodule
      {
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
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveHttpExpectedResponse =
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
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveHttpModule =
    types.submodule
      {
        options = {
          "expectedResponse" = mkOption {
            description = "ExpectedResponse defines a list of HTTP expected responses to match.";
            type = (
              types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveHttpExpectedResponseModule
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
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveHttp =
    res:
    {
    }
    // optionalAttrs (res."expectedResponse" != null) {
      "expectedResponse" =
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveHttpExpectedResponse
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
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveModule = types.submodule {
    options = {
      "grpc" = mkOption {
        description = "GRPC defines the configuration of the GRPC health checker.\nIt's optional, and can only be used if the specified type is GRPC.";
        type = (
          types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveGrpcModule
        );
        default = null;
      };
      "healthyThreshold" = mkOption {
        description = "HealthyThreshold defines the number of healthy health checks required before a backend host is marked healthy.";
        type = (types.nullOr types.int);
        default = 1;
      };
      "http" = mkOption {
        description = "HTTP defines the configuration of http health checker.\nIt's required while the health checker type is HTTP.";
        type = (
          types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveHttpModule
        );
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
        type = (
          types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveTcpModule
        );
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
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActive =
    res:
    {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" =
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveGrpc
          res."grpc";
    }
    // {
    }
    // optionalAttrs (res."healthyThreshold" != null) { inherit (res) "healthyThreshold"; }
    // {
    }
    // optionalAttrs (res."http" != null) {
      "http" =
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveHttp
          res."http";
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
      "tcp" = mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveTcp res."tcp";
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
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveTcpModule =
    types.submodule
      {
        options = {
          "receive" = mkOption {
            description = "Receive defines the expected response payload.";
            type = (
              types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveTcpReceiveModule
            );
            default = null;
          };
          "send" = mkOption {
            description = "Send defines the request payload.";
            type = (
              types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveTcpSendModule
            );
            default = null;
          };
        };
      };
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveTcp =
    res:
    {
    }
    // optionalAttrs (res."receive" != null) {
      "receive" =
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveTcpReceive
          res."receive";
    }
    // {
    }
    // optionalAttrs (res."send" != null) {
      "send" =
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveTcpSend
          res."send";
    }
    // {
    };
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveTcpReceiveModule =
    types.submodule
      {
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
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveTcpReceive =
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
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveTcpSendModule =
    types.submodule
      {
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
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveTcpSend =
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
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckModule = types.submodule {
    options = {
      "active" = mkOption {
        description = "Active health check configuration";
        type = (
          types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActiveModule
        );
        default = null;
      };
      "panicThreshold" = mkOption {
        description = "When number of unhealthy endpoints for a backend reaches this threshold\nEnvoy will disregard health status and balance across all endpoints.\nIt's designed to prevent a situation in which host failures cascade throughout the cluster\nas load increases. If not set, the default value is 50%. To disable panic mode, set value to `0`.";
        type = (types.nullOr types.int);
        default = null;
      };
      "passive" = mkOption {
        description = "Passive passive check configuration";
        type = (
          types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckPassiveModule
        );
        default = null;
      };
    };
  };
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheck =
    res:
    {
    }
    // optionalAttrs (res."active" != null) {
      "active" =
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckActive
          res."active";
    }
    // {
    }
    // optionalAttrs (res."panicThreshold" != null) { inherit (res) "panicThreshold"; }
    // {
    }
    // optionalAttrs (res."passive" != null) {
      "passive" =
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckPassive
          res."passive";
    }
    // {
    };
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckPassiveModule =
    types.submodule
      {
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
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckPassive =
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
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHttp2Module = types.submodule {
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
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHttp2 =
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
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerConsistentHashCookieModule =
    types.submodule
      {
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
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerConsistentHashCookie =
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
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerConsistentHashHeaderModule =
    types.submodule
      {
        options = {
          "name" = mkOption {
            description = "Name of the header to hash.";
            type = types.str;
          };
        };
      };
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerConsistentHashHeader = res: {
    inherit (res) "name";
  };
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerConsistentHashModule =
    types.submodule
      {
        options = {
          "cookie" = mkOption {
            description = "Cookie configures the cookie hash policy when the consistent hash type is set to Cookie.";
            type = (
              types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerConsistentHashCookieModule
            );
            default = null;
          };
          "header" = mkOption {
            description = "Header configures the header hash policy when the consistent hash type is set to Header.";
            type = (
              types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerConsistentHashHeaderModule
            );
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
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerConsistentHash =
    res:
    {
    }
    // optionalAttrs (res."cookie" != null) {
      "cookie" =
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerConsistentHashCookie
          res."cookie";
    }
    // {
    }
    // optionalAttrs (res."header" != null) {
      "header" =
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerConsistentHashHeader
          res."header";
    }
    // {
    }
    // optionalAttrs (res."tableSize" != null) { inherit (res) "tableSize"; }
    // {
      inherit (res) "type";
    };
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerEndpointOverrideExtractFromModule =
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
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerEndpointOverrideExtractFrom =
    res:
    {
    }
    // optionalAttrs (res."header" != null) { inherit (res) "header"; }
    // {
    };
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerEndpointOverrideModule =
    types.submodule
      {
        options = {
          "extractFrom" = mkOption {
            description = "ExtractFrom defines the sources to extract endpoint override information from.";
            type = (
              types.listOf TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerEndpointOverrideExtractFromModule
            );
          };
        };
      };
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerEndpointOverride = res: {
    "extractFrom" =
      map
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerEndpointOverrideExtractFrom
        res."extractFrom";
  };
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerModule = types.submodule {
    options = {
      "consistentHash" = mkOption {
        description = "ConsistentHash defines the configuration when the load balancer type is\nset to ConsistentHash";
        type = (
          types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerConsistentHashModule
        );
        default = null;
      };
      "endpointOverride" = mkOption {
        description = "EndpointOverride defines the configuration for endpoint override.\nWhen specified, the load balancer will attempt to route requests to endpoints\nbased on the override information extracted from request headers or metadata.\n If the override endpoints are not available, the configured load balancer policy will be used as fallback.";
        type = (
          types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerEndpointOverrideModule
        );
        default = null;
      };
      "slowStart" = mkOption {
        description = "SlowStart defines the configuration related to the slow start load balancer policy.\nIf set, during slow start window, traffic sent to the newly added hosts will gradually increase.\nCurrently this is only supported for RoundRobin and LeastRequest load balancers";
        type = (
          types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerSlowStartModule
        );
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
        type = (
          types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerZoneAwareModule
        );
        default = null;
      };
    };
  };
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancer =
    res:
    {
    }
    // optionalAttrs (res."consistentHash" != null) {
      "consistentHash" =
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerConsistentHash
          res."consistentHash";
    }
    // {
    }
    // optionalAttrs (res."endpointOverride" != null) {
      "endpointOverride" =
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerEndpointOverride
          res."endpointOverride";
    }
    // {
    }
    // optionalAttrs (res."slowStart" != null) {
      "slowStart" =
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerSlowStart
          res."slowStart";
    }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."zoneAware" != null) {
      "zoneAware" =
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerZoneAware
          res."zoneAware";
    }
    // {
    };
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerSlowStartModule =
    types.submodule
      {
        options = {
          "window" = mkOption {
            description = "Window defines the duration of the warm up period for newly added host.\nDuring slow start window, traffic sent to the newly added hosts will gradually increase.\nCurrently only supports linear growth of traffic. For additional details,\nsee https://www.envoyproxy.io/docs/envoy/latest/api-v3/config/cluster/v3/cluster.proto#config-cluster-v3-cluster-slowstartconfig";
            type = types.str;
          };
        };
      };
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerSlowStart = res: {
    inherit (res) "window";
  };
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerZoneAwareModule =
    types.submodule
      {
        options = {
          "preferLocal" = mkOption {
            description = "PreferLocalZone configures zone-aware routing to prefer sending traffic to the local locality zone.";
            type = (
              types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerZoneAwarePreferLocalModule
            );
            default = null;
          };
        };
      };
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerZoneAware =
    res:
    {
    }
    // optionalAttrs (res."preferLocal" != null) {
      "preferLocal" =
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerZoneAwarePreferLocal
          res."preferLocal";
    }
    // {
    };
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerZoneAwarePreferLocalForceModule =
    types.submodule
      {
        options = {
          "minEndpointsInZoneThreshold" = mkOption {
            description = "MinEndpointsInZoneThreshold is the minimum number of upstream endpoints in the local zone required to honor the forceLocalZone\noverride. This is useful for protecting zones with fewer endpoints.";
            type = (types.nullOr types.int);
            default = null;
          };
        };
      };
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerZoneAwarePreferLocalForce =
    res:
    {
    }
    // optionalAttrs (res."minEndpointsInZoneThreshold" != null) {
      inherit (res) "minEndpointsInZoneThreshold";
    }
    // {
    };
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerZoneAwarePreferLocalModule =
    types.submodule
      {
        options = {
          "force" = mkOption {
            description = "ForceLocalZone defines override configuration for forcing all traffic to stay within the local zone instead of the default behavior\nwhich maintains equal distribution among upstream endpoints while sending as much traffic as possible locally.";
            type = (
              types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerZoneAwarePreferLocalForceModule
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
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerZoneAwarePreferLocal =
    res:
    {
    }
    // optionalAttrs (res."force" != null) {
      "force" =
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerZoneAwarePreferLocalForce
          res."force";
    }
    // {
    }
    // optionalAttrs (res."minEndpointsThreshold" != null) { inherit (res) "minEndpointsThreshold"; }
    // {
    };
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsModule = types.submodule {
    options = {
      "circuitBreaker" = mkOption {
        description = "Circuit Breaker settings for the upstream connections and requests.\nIf not set, circuit breakers will be enabled with the default thresholds";
        type = (types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsCircuitBreakerModule);
        default = null;
      };
      "connection" = mkOption {
        description = "Connection includes backend connection settings.";
        type = (types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsConnectionModule);
        default = null;
      };
      "dns" = mkOption {
        description = "DNS includes dns resolution settings.";
        type = (types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsDnsModule);
        default = null;
      };
      "healthCheck" = mkOption {
        description = "HealthCheck allows gateway to perform active health checking on backends.";
        type = (types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheckModule);
        default = null;
      };
      "http2" = mkOption {
        description = "HTTP2 provides HTTP/2 configuration for backend connections.";
        type = (types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHttp2Module);
        default = null;
      };
      "loadBalancer" = mkOption {
        description = "LoadBalancer policy to apply when routing traffic from the gateway to\nthe backend endpoints. Defaults to `LeastRequest`.";
        type = (types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancerModule);
        default = null;
      };
      "proxyProtocol" = mkOption {
        description = "ProxyProtocol enables the Proxy Protocol when communicating with the backend.";
        type = (types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsProxyProtocolModule);
        default = null;
      };
      "retry" = mkOption {
        description = "Retry provides more advanced usage, allowing users to customize the number of retries, retry fallback strategy, and retry triggering conditions.\nIf not set, retry will be disabled.";
        type = (types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsRetryModule);
        default = null;
      };
      "tcpKeepalive" = mkOption {
        description = "TcpKeepalive settings associated with the upstream client connection.\nDisabled by default.";
        type = (types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsTcpKeepaliveModule);
        default = null;
      };
      "timeout" = mkOption {
        description = "Timeout settings for the backend connections.";
        type = (types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsTimeoutModule);
        default = null;
      };
    };
  };
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettings =
    res:
    {
    }
    // optionalAttrs (res."circuitBreaker" != null) {
      "circuitBreaker" =
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsCircuitBreaker
          res."circuitBreaker";
    }
    // {
    }
    // optionalAttrs (res."connection" != null) {
      "connection" =
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsConnection
          res."connection";
    }
    // {
    }
    // optionalAttrs (res."dns" != null) {
      "dns" = mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsDns res."dns";
    }
    // {
    }
    // optionalAttrs (res."healthCheck" != null) {
      "healthCheck" =
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHealthCheck
          res."healthCheck";
    }
    // {
    }
    // optionalAttrs (res."http2" != null) {
      "http2" = mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsHttp2 res."http2";
    }
    // {
    }
    // optionalAttrs (res."loadBalancer" != null) {
      "loadBalancer" =
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsLoadBalancer
          res."loadBalancer";
    }
    // {
    }
    // optionalAttrs (res."proxyProtocol" != null) {
      "proxyProtocol" =
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsProxyProtocol
          res."proxyProtocol";
    }
    // {
    }
    // optionalAttrs (res."retry" != null) {
      "retry" = mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsRetry res."retry";
    }
    // {
    }
    // optionalAttrs (res."tcpKeepalive" != null) {
      "tcpKeepalive" =
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsTcpKeepalive
          res."tcpKeepalive";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) {
      "timeout" = mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsTimeout res."timeout";
    }
    // {
    };
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsProxyProtocolModule = types.submodule {
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
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsProxyProtocol = res: {
    inherit (res) "version";
  };
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsRetryModule = types.submodule {
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
        type = (types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsRetryPerRetryModule);
        default = null;
      };
      "retryOn" = mkOption {
        description = "RetryOn specifies the retry trigger condition.\n\nIf not specified, the default is to retry on connect-failure,refused-stream,unavailable,cancelled,retriable-status-codes(503).";
        type = (types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsRetryRetryOnModule);
        default = null;
      };
    };
  };
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsRetry =
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
      "perRetry" =
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsRetryPerRetry
          res."perRetry";
    }
    // {
    }
    // optionalAttrs (res."retryOn" != null) {
      "retryOn" = mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsRetryRetryOn res."retryOn";
    }
    // {
    };
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsRetryPerRetryBackOffModule =
    types.submodule
      {
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
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsRetryPerRetryBackOff =
    res:
    {
    }
    // optionalAttrs (res."baseInterval" != null) { inherit (res) "baseInterval"; }
    // {
    }
    // optionalAttrs (res."maxInterval" != null) { inherit (res) "maxInterval"; }
    // {
    };
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsRetryPerRetryModule = types.submodule {
    options = {
      "backOff" = mkOption {
        description = "Backoff is the backoff policy to be applied per retry attempt. gateway uses a fully jittered exponential\nback-off algorithm for retries. For additional details,\nsee https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/router_filter#config-http-filters-router-x-envoy-max-retries";
        type = (
          types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsRetryPerRetryBackOffModule
        );
        default = null;
      };
      "timeout" = mkOption {
        description = "Timeout is the timeout per retry attempt.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsRetryPerRetry =
    res:
    {
    }
    // optionalAttrs (res."backOff" != null) {
      "backOff" =
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsRetryPerRetryBackOff
          res."backOff";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    };
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsRetryRetryOnModule = types.submodule {
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
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsRetryRetryOn =
    res:
    {
    }
    // optionalAttrs (res."httpStatusCodes" != [ ]) { inherit (res) "httpStatusCodes"; }
    // {
    }
    // optionalAttrs (res."triggers" != [ ]) { inherit (res) "triggers"; }
    // {
    };
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsTcpKeepaliveModule = types.submodule {
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
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsTcpKeepalive =
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
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsTimeoutHttpModule = types.submodule {
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
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsTimeoutHttp =
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
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsTimeoutModule = types.submodule {
    options = {
      "http" = mkOption {
        description = "Timeout settings for HTTP.";
        type = (types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsTimeoutHttpModule);
        default = null;
      };
      "tcp" = mkOption {
        description = "Timeout settings for TCP.";
        type = (types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsTimeoutTcpModule);
        default = null;
      };
    };
  };
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsTimeout =
    res:
    {
    }
    // optionalAttrs (res."http" != null) {
      "http" = mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsTimeoutHttp res."http";
    }
    // {
    }
    // optionalAttrs (res."tcp" != null) {
      "tcp" = mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsTimeoutTcp res."tcp";
    }
    // {
    };
  TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsTimeoutTcpModule = types.submodule {
    options = {
      "connectTimeout" = mkOption {
        description = "The timeout for network connection establishment, including TCP and TLS handshakes.\nDefault: 10 seconds.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsTimeoutTcp =
    res:
    {
    }
    // optionalAttrs (res."connectTimeout" != null) { inherit (res) "connectTimeout"; }
    // {
    };
  TelemetryAccessLogSettingSinkOpenTelemetryModule = types.submodule {
    options = {
      "backendRef" = mkOption {
        description = "BackendRef references a Kubernetes object that represents the\nbackend server to which the authorization request will be sent.\n\nDeprecated: Use BackendRefs instead.";
        type = (types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendRefModule);
        default = null;
      };
      "backendRefs" = mkOption {
        description = "BackendRefs references a Kubernetes object that represents the\nbackend server to which the authorization request will be sent.";
        type = (types.listOf TelemetryAccessLogSettingSinkOpenTelemetryBackendRefModule);
        default = [ ];
      };
      "backendSettings" = mkOption {
        description = "BackendSettings holds configuration for managing the connection\nto the backend.";
        type = (types.nullOr TelemetryAccessLogSettingSinkOpenTelemetryBackendSettingsModule);
        default = null;
      };
      "host" = mkOption {
        description = "Host define the extension service hostname.\nDeprecated: Use BackendRefs instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Port defines the port the extension service is exposed on.\nDeprecated: Use BackendRefs instead.";
        type = (types.nullOr types.int);
        default = 4317;
      };
      "resources" = mkOption {
        description = "Resources is a set of labels that describe the source of a log entry, including envoy node info.\nIt's recommended to follow [semantic conventions](https://opentelemetry.io/docs/reference/specification/resource/semantic_conventions/).";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkTelemetryAccessLogSettingSinkOpenTelemetry =
    res:
    {
    }
    // optionalAttrs (res."backendRef" != null) {
      "backendRef" = mkTelemetryAccessLogSettingSinkOpenTelemetryBackendRef res."backendRef";
    }
    // {
    }
    // optionalAttrs (res."backendRefs" != [ ]) {
      "backendRefs" = map mkTelemetryAccessLogSettingSinkOpenTelemetryBackendRef res."backendRefs";
    }
    // {
    }
    // optionalAttrs (res."backendSettings" != null) {
      "backendSettings" =
        mkTelemetryAccessLogSettingSinkOpenTelemetryBackendSettings
          res."backendSettings";
    }
    // {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
    }
    // optionalAttrs (res."resources" != { }) { inherit (res) "resources"; }
    // {
    };
  TelemetryMetricsMatcheModule = types.submodule {
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
  mkTelemetryMetricsMatche =
    res:
    {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
      inherit (res) "value";
    };
  TelemetryMetricsModule = types.submodule {
    options = {
      "clusterStatName" = mkOption {
        description = "ClusterStatName defines the value of cluster alt_stat_name, determining how cluster stats are named.\nFor more details, see envoy docs: https://www.envoyproxy.io/docs/envoy/latest/api-v3/config/cluster/v3/cluster.proto.html\nThe supported operators for this pattern are:\n%ROUTE_NAME%: name of Gateway API xRoute resource\n%ROUTE_NAMESPACE%: namespace of Gateway API xRoute resource\n%ROUTE_KIND%: kind of Gateway API xRoute resource\n%ROUTE_RULE_NAME%: name of the Gateway API xRoute section\n%ROUTE_RULE_NUMBER%: name of the Gateway API xRoute section\n%BACKEND_REFS%: names of all backends referenced in <NAMESPACE>/<NAME>|<NAMESPACE>/<NAME>|... format\nOnly xDS Clusters created for HTTPRoute and GRPCRoute are currently supported.\nDefault: %ROUTE_KIND%/%ROUTE_NAMESPACE%/%ROUTE_NAME%/rule/%ROUTE_RULE_NUMBER%\nExample: httproute/my-ns/my-route/rule/0";
        type = (types.nullOr types.str);
        default = null;
      };
      "enablePerEndpointStats" = mkOption {
        description = "EnablePerEndpointStats enables per endpoint envoy stats metrics.\nPlease use with caution.";
        type = types.bool;
        default = false;
      };
      "enableRequestResponseSizesStats" = mkOption {
        description = "EnableRequestResponseSizesStats enables publishing of histograms tracking header and body sizes of requests and responses.";
        type = types.bool;
        default = false;
      };
      "enableVirtualHostStats" = mkOption {
        description = "EnableVirtualHostStats enables envoy stat metrics for virtual hosts.";
        type = types.bool;
        default = false;
      };
      "matches" = mkOption {
        description = "Matches defines configuration for selecting specific metrics instead of generating all metrics stats\nthat are enabled by default. This helps reduce CPU and memory overhead in Envoy, but eliminating some stats\nmay after critical functionality. Here are the stats that we strongly recommend not disabling:\n`cluster_manager.warming_clusters`, `cluster.<cluster_name>.membership_total`,`cluster.<cluster_name>.membership_healthy`,\n`cluster.<cluster_name>.membership_degraded`，reference  https://github.com/envoyproxy/envoy/issues/9856,\nhttps://github.com/envoyproxy/envoy/issues/14610";
        type = (types.listOf TelemetryMetricsMatcheModule);
        default = [ ];
      };
      "prometheus" = mkOption {
        description = "Prometheus defines the configuration for Admin endpoint `/stats/prometheus`.";
        type = (types.nullOr TelemetryMetricsPrometheusModule);
        default = null;
      };
      "sinks" = mkOption {
        description = "Sinks defines the metric sinks where metrics are sent to.";
        type = (types.listOf TelemetryMetricsSinkModule);
        default = [ ];
      };
    };
  };
  mkTelemetryMetrics =
    res:
    {
    }
    // optionalAttrs (res."clusterStatName" != null) { inherit (res) "clusterStatName"; }
    // {
    }
    // optionalAttrs res."enablePerEndpointStats" { inherit (res) "enablePerEndpointStats"; }
    // {
    }
    // optionalAttrs res."enableRequestResponseSizesStats" {
      inherit (res) "enableRequestResponseSizesStats";
    }
    // {
    }
    // optionalAttrs res."enableVirtualHostStats" { inherit (res) "enableVirtualHostStats"; }
    // {
    }
    // optionalAttrs (res."matches" != [ ]) { "matches" = map mkTelemetryMetricsMatche res."matches"; }
    // {
    }
    // optionalAttrs (res."prometheus" != null) {
      "prometheus" = mkTelemetryMetricsPrometheus res."prometheus";
    }
    // {
    }
    // optionalAttrs (res."sinks" != [ ]) { "sinks" = map mkTelemetryMetricsSink res."sinks"; }
    // {
    };
  TelemetryMetricsPrometheusCompressionModule = types.submodule {
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
  mkTelemetryMetricsPrometheusCompression =
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
  TelemetryMetricsPrometheusModule = types.submodule {
    options = {
      "compression" = mkOption {
        description = "Configure the compression on Prometheus endpoint. Compression is useful in situations when bandwidth is scarce and large payloads can be effectively compressed at the expense of higher CPU load.";
        type = (types.nullOr TelemetryMetricsPrometheusCompressionModule);
        default = null;
      };
      "disable" = mkOption {
        description = "Disable the Prometheus endpoint.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkTelemetryMetricsPrometheus =
    res:
    {
    }
    // optionalAttrs (res."compression" != null) {
      "compression" = mkTelemetryMetricsPrometheusCompression res."compression";
    }
    // {
    }
    // optionalAttrs res."disable" { inherit (res) "disable"; }
    // {
    };
  TelemetryMetricsSinkModule = types.submodule {
    options = {
      "openTelemetry" = mkOption {
        description = "OpenTelemetry defines the configuration for OpenTelemetry sink.\nIt's required if the sink type is OpenTelemetry.";
        type = (types.nullOr TelemetryMetricsSinkOpenTelemetryModule);
        default = null;
      };
      "type" = mkOption {
        description = "Type defines the metric sink type.\nEG currently only supports OpenTelemetry.";
        type = (types.enum [ "OpenTelemetry" ]);
      };
    };
  };
  mkTelemetryMetricsSink =
    res:
    {
    }
    // optionalAttrs (res."openTelemetry" != null) {
      "openTelemetry" = mkTelemetryMetricsSinkOpenTelemetry res."openTelemetry";
    }
    // {
      inherit (res) "type";
    };
  TelemetryMetricsSinkOpenTelemetryBackendRefModule = types.submodule {
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
  mkTelemetryMetricsSinkOpenTelemetryBackendRef =
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
  TelemetryMetricsSinkOpenTelemetryBackendSettingsCircuitBreakerModule = types.submodule {
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
        type = (
          types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsCircuitBreakerPerEndpointModule
        );
        default = null;
      };
    };
  };
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsCircuitBreaker =
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
      "perEndpoint" =
        mkTelemetryMetricsSinkOpenTelemetryBackendSettingsCircuitBreakerPerEndpoint
          res."perEndpoint";
    }
    // {
    };
  TelemetryMetricsSinkOpenTelemetryBackendSettingsCircuitBreakerPerEndpointModule = types.submodule {
    options = {
      "maxConnections" = mkOption {
        description = "MaxConnections configures the maximum number of connections that Envoy will establish per-endpoint to the referenced backend defined within a xRoute rule.";
        type = (types.nullOr types.int);
        default = 1024;
      };
    };
  };
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsCircuitBreakerPerEndpoint =
    res:
    {
    }
    // optionalAttrs (res."maxConnections" != null) { inherit (res) "maxConnections"; }
    // {
    };
  TelemetryMetricsSinkOpenTelemetryBackendSettingsConnectionModule = types.submodule {
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
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsConnection =
    res:
    {
    }
    // optionalAttrs (res."bufferLimit" != null) { inherit (res) "bufferLimit"; }
    // {
    }
    // optionalAttrs (res."socketBufferLimit" != null) { inherit (res) "socketBufferLimit"; }
    // {
    };
  TelemetryMetricsSinkOpenTelemetryBackendSettingsDnsModule = types.submodule {
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
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsDns =
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
  TelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveGrpcModule = types.submodule {
    options = {
      "service" = mkOption {
        description = "Service to send in the health check request.\nIf this is not specified, then the health check request applies to the entire\nserver and not to a specific service.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveGrpc =
    res:
    {
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  TelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveHttpExpectedResponseModule =
    types.submodule
      {
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
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveHttpExpectedResponse =
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
  TelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveHttpModule = types.submodule {
    options = {
      "expectedResponse" = mkOption {
        description = "ExpectedResponse defines a list of HTTP expected responses to match.";
        type = (
          types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveHttpExpectedResponseModule
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
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveHttp =
    res:
    {
    }
    // optionalAttrs (res."expectedResponse" != null) {
      "expectedResponse" =
        mkTelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveHttpExpectedResponse
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
  TelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveModule = types.submodule {
    options = {
      "grpc" = mkOption {
        description = "GRPC defines the configuration of the GRPC health checker.\nIt's optional, and can only be used if the specified type is GRPC.";
        type = (types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveGrpcModule);
        default = null;
      };
      "healthyThreshold" = mkOption {
        description = "HealthyThreshold defines the number of healthy health checks required before a backend host is marked healthy.";
        type = (types.nullOr types.int);
        default = 1;
      };
      "http" = mkOption {
        description = "HTTP defines the configuration of http health checker.\nIt's required while the health checker type is HTTP.";
        type = (types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveHttpModule);
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
        type = (types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveTcpModule);
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
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActive =
    res:
    {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkTelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."healthyThreshold" != null) { inherit (res) "healthyThreshold"; }
    // {
    }
    // optionalAttrs (res."http" != null) {
      "http" = mkTelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveHttp res."http";
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
      "tcp" = mkTelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveTcp res."tcp";
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
  TelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveTcpModule = types.submodule {
    options = {
      "receive" = mkOption {
        description = "Receive defines the expected response payload.";
        type = (
          types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveTcpReceiveModule
        );
        default = null;
      };
      "send" = mkOption {
        description = "Send defines the request payload.";
        type = (
          types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveTcpSendModule
        );
        default = null;
      };
    };
  };
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveTcp =
    res:
    {
    }
    // optionalAttrs (res."receive" != null) {
      "receive" =
        mkTelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveTcpReceive
          res."receive";
    }
    // {
    }
    // optionalAttrs (res."send" != null) {
      "send" = mkTelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveTcpSend res."send";
    }
    // {
    };
  TelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveTcpReceiveModule =
    types.submodule
      {
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
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveTcpReceive =
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
  TelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveTcpSendModule = types.submodule {
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
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveTcpSend =
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
  TelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckModule = types.submodule {
    options = {
      "active" = mkOption {
        description = "Active health check configuration";
        type = (types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActiveModule);
        default = null;
      };
      "panicThreshold" = mkOption {
        description = "When number of unhealthy endpoints for a backend reaches this threshold\nEnvoy will disregard health status and balance across all endpoints.\nIt's designed to prevent a situation in which host failures cascade throughout the cluster\nas load increases. If not set, the default value is 50%. To disable panic mode, set value to `0`.";
        type = (types.nullOr types.int);
        default = null;
      };
      "passive" = mkOption {
        description = "Passive passive check configuration";
        type = (types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckPassiveModule);
        default = null;
      };
    };
  };
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheck =
    res:
    {
    }
    // optionalAttrs (res."active" != null) {
      "active" = mkTelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckActive res."active";
    }
    // {
    }
    // optionalAttrs (res."panicThreshold" != null) { inherit (res) "panicThreshold"; }
    // {
    }
    // optionalAttrs (res."passive" != null) {
      "passive" = mkTelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckPassive res."passive";
    }
    // {
    };
  TelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckPassiveModule = types.submodule {
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
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckPassive =
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
  TelemetryMetricsSinkOpenTelemetryBackendSettingsHttp2Module = types.submodule {
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
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsHttp2 =
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
  TelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerConsistentHashCookieModule =
    types.submodule
      {
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
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerConsistentHashCookie =
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
  TelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerConsistentHashHeaderModule =
    types.submodule
      {
        options = {
          "name" = mkOption {
            description = "Name of the header to hash.";
            type = types.str;
          };
        };
      };
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerConsistentHashHeader = res: {
    inherit (res) "name";
  };
  TelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerConsistentHashModule = types.submodule {
    options = {
      "cookie" = mkOption {
        description = "Cookie configures the cookie hash policy when the consistent hash type is set to Cookie.";
        type = (
          types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerConsistentHashCookieModule
        );
        default = null;
      };
      "header" = mkOption {
        description = "Header configures the header hash policy when the consistent hash type is set to Header.";
        type = (
          types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerConsistentHashHeaderModule
        );
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
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerConsistentHash =
    res:
    {
    }
    // optionalAttrs (res."cookie" != null) {
      "cookie" =
        mkTelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerConsistentHashCookie
          res."cookie";
    }
    // {
    }
    // optionalAttrs (res."header" != null) {
      "header" =
        mkTelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerConsistentHashHeader
          res."header";
    }
    // {
    }
    // optionalAttrs (res."tableSize" != null) { inherit (res) "tableSize"; }
    // {
      inherit (res) "type";
    };
  TelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerEndpointOverrideExtractFromModule =
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
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerEndpointOverrideExtractFrom =
    res:
    {
    }
    // optionalAttrs (res."header" != null) { inherit (res) "header"; }
    // {
    };
  TelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerEndpointOverrideModule =
    types.submodule
      {
        options = {
          "extractFrom" = mkOption {
            description = "ExtractFrom defines the sources to extract endpoint override information from.";
            type = (
              types.listOf TelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerEndpointOverrideExtractFromModule
            );
          };
        };
      };
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerEndpointOverride = res: {
    "extractFrom" =
      map mkTelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerEndpointOverrideExtractFrom
        res."extractFrom";
  };
  TelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerModule = types.submodule {
    options = {
      "consistentHash" = mkOption {
        description = "ConsistentHash defines the configuration when the load balancer type is\nset to ConsistentHash";
        type = (
          types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerConsistentHashModule
        );
        default = null;
      };
      "endpointOverride" = mkOption {
        description = "EndpointOverride defines the configuration for endpoint override.\nWhen specified, the load balancer will attempt to route requests to endpoints\nbased on the override information extracted from request headers or metadata.\n If the override endpoints are not available, the configured load balancer policy will be used as fallback.";
        type = (
          types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerEndpointOverrideModule
        );
        default = null;
      };
      "slowStart" = mkOption {
        description = "SlowStart defines the configuration related to the slow start load balancer policy.\nIf set, during slow start window, traffic sent to the newly added hosts will gradually increase.\nCurrently this is only supported for RoundRobin and LeastRequest load balancers";
        type = (types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerSlowStartModule);
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
        type = (types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerZoneAwareModule);
        default = null;
      };
    };
  };
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancer =
    res:
    {
    }
    // optionalAttrs (res."consistentHash" != null) {
      "consistentHash" =
        mkTelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerConsistentHash
          res."consistentHash";
    }
    // {
    }
    // optionalAttrs (res."endpointOverride" != null) {
      "endpointOverride" =
        mkTelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerEndpointOverride
          res."endpointOverride";
    }
    // {
    }
    // optionalAttrs (res."slowStart" != null) {
      "slowStart" =
        mkTelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerSlowStart
          res."slowStart";
    }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."zoneAware" != null) {
      "zoneAware" =
        mkTelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerZoneAware
          res."zoneAware";
    }
    // {
    };
  TelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerSlowStartModule = types.submodule {
    options = {
      "window" = mkOption {
        description = "Window defines the duration of the warm up period for newly added host.\nDuring slow start window, traffic sent to the newly added hosts will gradually increase.\nCurrently only supports linear growth of traffic. For additional details,\nsee https://www.envoyproxy.io/docs/envoy/latest/api-v3/config/cluster/v3/cluster.proto#config-cluster-v3-cluster-slowstartconfig";
        type = types.str;
      };
    };
  };
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerSlowStart = res: {
    inherit (res) "window";
  };
  TelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerZoneAwareModule = types.submodule {
    options = {
      "preferLocal" = mkOption {
        description = "PreferLocalZone configures zone-aware routing to prefer sending traffic to the local locality zone.";
        type = (
          types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerZoneAwarePreferLocalModule
        );
        default = null;
      };
    };
  };
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerZoneAware =
    res:
    {
    }
    // optionalAttrs (res."preferLocal" != null) {
      "preferLocal" =
        mkTelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerZoneAwarePreferLocal
          res."preferLocal";
    }
    // {
    };
  TelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerZoneAwarePreferLocalForceModule =
    types.submodule
      {
        options = {
          "minEndpointsInZoneThreshold" = mkOption {
            description = "MinEndpointsInZoneThreshold is the minimum number of upstream endpoints in the local zone required to honor the forceLocalZone\noverride. This is useful for protecting zones with fewer endpoints.";
            type = (types.nullOr types.int);
            default = null;
          };
        };
      };
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerZoneAwarePreferLocalForce =
    res:
    {
    }
    // optionalAttrs (res."minEndpointsInZoneThreshold" != null) {
      inherit (res) "minEndpointsInZoneThreshold";
    }
    // {
    };
  TelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerZoneAwarePreferLocalModule =
    types.submodule
      {
        options = {
          "force" = mkOption {
            description = "ForceLocalZone defines override configuration for forcing all traffic to stay within the local zone instead of the default behavior\nwhich maintains equal distribution among upstream endpoints while sending as much traffic as possible locally.";
            type = (
              types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerZoneAwarePreferLocalForceModule
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
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerZoneAwarePreferLocal =
    res:
    {
    }
    // optionalAttrs (res."force" != null) {
      "force" =
        mkTelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerZoneAwarePreferLocalForce
          res."force";
    }
    // {
    }
    // optionalAttrs (res."minEndpointsThreshold" != null) { inherit (res) "minEndpointsThreshold"; }
    // {
    };
  TelemetryMetricsSinkOpenTelemetryBackendSettingsModule = types.submodule {
    options = {
      "circuitBreaker" = mkOption {
        description = "Circuit Breaker settings for the upstream connections and requests.\nIf not set, circuit breakers will be enabled with the default thresholds";
        type = (types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsCircuitBreakerModule);
        default = null;
      };
      "connection" = mkOption {
        description = "Connection includes backend connection settings.";
        type = (types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsConnectionModule);
        default = null;
      };
      "dns" = mkOption {
        description = "DNS includes dns resolution settings.";
        type = (types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsDnsModule);
        default = null;
      };
      "healthCheck" = mkOption {
        description = "HealthCheck allows gateway to perform active health checking on backends.";
        type = (types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheckModule);
        default = null;
      };
      "http2" = mkOption {
        description = "HTTP2 provides HTTP/2 configuration for backend connections.";
        type = (types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsHttp2Module);
        default = null;
      };
      "loadBalancer" = mkOption {
        description = "LoadBalancer policy to apply when routing traffic from the gateway to\nthe backend endpoints. Defaults to `LeastRequest`.";
        type = (types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancerModule);
        default = null;
      };
      "proxyProtocol" = mkOption {
        description = "ProxyProtocol enables the Proxy Protocol when communicating with the backend.";
        type = (types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsProxyProtocolModule);
        default = null;
      };
      "retry" = mkOption {
        description = "Retry provides more advanced usage, allowing users to customize the number of retries, retry fallback strategy, and retry triggering conditions.\nIf not set, retry will be disabled.";
        type = (types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsRetryModule);
        default = null;
      };
      "tcpKeepalive" = mkOption {
        description = "TcpKeepalive settings associated with the upstream client connection.\nDisabled by default.";
        type = (types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsTcpKeepaliveModule);
        default = null;
      };
      "timeout" = mkOption {
        description = "Timeout settings for the backend connections.";
        type = (types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsTimeoutModule);
        default = null;
      };
    };
  };
  mkTelemetryMetricsSinkOpenTelemetryBackendSettings =
    res:
    {
    }
    // optionalAttrs (res."circuitBreaker" != null) {
      "circuitBreaker" =
        mkTelemetryMetricsSinkOpenTelemetryBackendSettingsCircuitBreaker
          res."circuitBreaker";
    }
    // {
    }
    // optionalAttrs (res."connection" != null) {
      "connection" = mkTelemetryMetricsSinkOpenTelemetryBackendSettingsConnection res."connection";
    }
    // {
    }
    // optionalAttrs (res."dns" != null) {
      "dns" = mkTelemetryMetricsSinkOpenTelemetryBackendSettingsDns res."dns";
    }
    // {
    }
    // optionalAttrs (res."healthCheck" != null) {
      "healthCheck" = mkTelemetryMetricsSinkOpenTelemetryBackendSettingsHealthCheck res."healthCheck";
    }
    // {
    }
    // optionalAttrs (res."http2" != null) {
      "http2" = mkTelemetryMetricsSinkOpenTelemetryBackendSettingsHttp2 res."http2";
    }
    // {
    }
    // optionalAttrs (res."loadBalancer" != null) {
      "loadBalancer" = mkTelemetryMetricsSinkOpenTelemetryBackendSettingsLoadBalancer res."loadBalancer";
    }
    // {
    }
    // optionalAttrs (res."proxyProtocol" != null) {
      "proxyProtocol" =
        mkTelemetryMetricsSinkOpenTelemetryBackendSettingsProxyProtocol
          res."proxyProtocol";
    }
    // {
    }
    // optionalAttrs (res."retry" != null) {
      "retry" = mkTelemetryMetricsSinkOpenTelemetryBackendSettingsRetry res."retry";
    }
    // {
    }
    // optionalAttrs (res."tcpKeepalive" != null) {
      "tcpKeepalive" = mkTelemetryMetricsSinkOpenTelemetryBackendSettingsTcpKeepalive res."tcpKeepalive";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) {
      "timeout" = mkTelemetryMetricsSinkOpenTelemetryBackendSettingsTimeout res."timeout";
    }
    // {
    };
  TelemetryMetricsSinkOpenTelemetryBackendSettingsProxyProtocolModule = types.submodule {
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
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsProxyProtocol = res: {
    inherit (res) "version";
  };
  TelemetryMetricsSinkOpenTelemetryBackendSettingsRetryModule = types.submodule {
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
        type = (types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsRetryPerRetryModule);
        default = null;
      };
      "retryOn" = mkOption {
        description = "RetryOn specifies the retry trigger condition.\n\nIf not specified, the default is to retry on connect-failure,refused-stream,unavailable,cancelled,retriable-status-codes(503).";
        type = (types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsRetryRetryOnModule);
        default = null;
      };
    };
  };
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsRetry =
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
      "perRetry" = mkTelemetryMetricsSinkOpenTelemetryBackendSettingsRetryPerRetry res."perRetry";
    }
    // {
    }
    // optionalAttrs (res."retryOn" != null) {
      "retryOn" = mkTelemetryMetricsSinkOpenTelemetryBackendSettingsRetryRetryOn res."retryOn";
    }
    // {
    };
  TelemetryMetricsSinkOpenTelemetryBackendSettingsRetryPerRetryBackOffModule = types.submodule {
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
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsRetryPerRetryBackOff =
    res:
    {
    }
    // optionalAttrs (res."baseInterval" != null) { inherit (res) "baseInterval"; }
    // {
    }
    // optionalAttrs (res."maxInterval" != null) { inherit (res) "maxInterval"; }
    // {
    };
  TelemetryMetricsSinkOpenTelemetryBackendSettingsRetryPerRetryModule = types.submodule {
    options = {
      "backOff" = mkOption {
        description = "Backoff is the backoff policy to be applied per retry attempt. gateway uses a fully jittered exponential\nback-off algorithm for retries. For additional details,\nsee https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/router_filter#config-http-filters-router-x-envoy-max-retries";
        type = (types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsRetryPerRetryBackOffModule);
        default = null;
      };
      "timeout" = mkOption {
        description = "Timeout is the timeout per retry attempt.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsRetryPerRetry =
    res:
    {
    }
    // optionalAttrs (res."backOff" != null) {
      "backOff" = mkTelemetryMetricsSinkOpenTelemetryBackendSettingsRetryPerRetryBackOff res."backOff";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    };
  TelemetryMetricsSinkOpenTelemetryBackendSettingsRetryRetryOnModule = types.submodule {
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
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsRetryRetryOn =
    res:
    {
    }
    // optionalAttrs (res."httpStatusCodes" != [ ]) { inherit (res) "httpStatusCodes"; }
    // {
    }
    // optionalAttrs (res."triggers" != [ ]) { inherit (res) "triggers"; }
    // {
    };
  TelemetryMetricsSinkOpenTelemetryBackendSettingsTcpKeepaliveModule = types.submodule {
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
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsTcpKeepalive =
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
  TelemetryMetricsSinkOpenTelemetryBackendSettingsTimeoutHttpModule = types.submodule {
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
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsTimeoutHttp =
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
  TelemetryMetricsSinkOpenTelemetryBackendSettingsTimeoutModule = types.submodule {
    options = {
      "http" = mkOption {
        description = "Timeout settings for HTTP.";
        type = (types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsTimeoutHttpModule);
        default = null;
      };
      "tcp" = mkOption {
        description = "Timeout settings for TCP.";
        type = (types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsTimeoutTcpModule);
        default = null;
      };
    };
  };
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsTimeout =
    res:
    {
    }
    // optionalAttrs (res."http" != null) {
      "http" = mkTelemetryMetricsSinkOpenTelemetryBackendSettingsTimeoutHttp res."http";
    }
    // {
    }
    // optionalAttrs (res."tcp" != null) {
      "tcp" = mkTelemetryMetricsSinkOpenTelemetryBackendSettingsTimeoutTcp res."tcp";
    }
    // {
    };
  TelemetryMetricsSinkOpenTelemetryBackendSettingsTimeoutTcpModule = types.submodule {
    options = {
      "connectTimeout" = mkOption {
        description = "The timeout for network connection establishment, including TCP and TLS handshakes.\nDefault: 10 seconds.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTelemetryMetricsSinkOpenTelemetryBackendSettingsTimeoutTcp =
    res:
    {
    }
    // optionalAttrs (res."connectTimeout" != null) { inherit (res) "connectTimeout"; }
    // {
    };
  TelemetryMetricsSinkOpenTelemetryModule = types.submodule {
    options = {
      "backendRef" = mkOption {
        description = "BackendRef references a Kubernetes object that represents the\nbackend server to which the authorization request will be sent.\n\nDeprecated: Use BackendRefs instead.";
        type = (types.nullOr TelemetryMetricsSinkOpenTelemetryBackendRefModule);
        default = null;
      };
      "backendRefs" = mkOption {
        description = "BackendRefs references a Kubernetes object that represents the\nbackend server to which the authorization request will be sent.";
        type = (types.listOf TelemetryMetricsSinkOpenTelemetryBackendRefModule);
        default = [ ];
      };
      "backendSettings" = mkOption {
        description = "BackendSettings holds configuration for managing the connection\nto the backend.";
        type = (types.nullOr TelemetryMetricsSinkOpenTelemetryBackendSettingsModule);
        default = null;
      };
      "host" = mkOption {
        description = "Host define the service hostname.\nDeprecated: Use BackendRefs instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Port defines the port the service is exposed on.\nDeprecated: Use BackendRefs instead.";
        type = (types.nullOr types.int);
        default = 4317;
      };
    };
  };
  mkTelemetryMetricsSinkOpenTelemetry =
    res:
    {
    }
    // optionalAttrs (res."backendRef" != null) {
      "backendRef" = mkTelemetryMetricsSinkOpenTelemetryBackendRef res."backendRef";
    }
    // {
    }
    // optionalAttrs (res."backendRefs" != [ ]) {
      "backendRefs" = map mkTelemetryMetricsSinkOpenTelemetryBackendRef res."backendRefs";
    }
    // {
    }
    // optionalAttrs (res."backendSettings" != null) {
      "backendSettings" = mkTelemetryMetricsSinkOpenTelemetryBackendSettings res."backendSettings";
    }
    // {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
    };
  TelemetryModule = types.submodule {
    options = {
      "accessLog" = mkOption {
        description = "AccessLogs defines accesslog parameters for managed proxies.\nIf unspecified, will send default format to stdout.";
        type = (types.nullOr TelemetryAccessLogModule);
        default = null;
      };
      "metrics" = mkOption {
        description = "Metrics defines metrics configuration for managed proxies.";
        type = (types.nullOr TelemetryMetricsModule);
        default = null;
      };
      "tracing" = mkOption {
        description = "Tracing defines tracing configuration for managed proxies.\nIf unspecified, will not send tracing data.";
        type = (types.nullOr TelemetryTracingModule);
        default = null;
      };
    };
  };
  mkTelemetry =
    res:
    {
    }
    // optionalAttrs (res."accessLog" != null) { "accessLog" = mkTelemetryAccessLog res."accessLog"; }
    // {
    }
    // optionalAttrs (res."metrics" != null) { "metrics" = mkTelemetryMetrics res."metrics"; }
    // {
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
      "provider" = mkOption {
        description = "Provider defines the tracing provider.";
        type = TelemetryTracingProviderModule;
      };
      "samplingFraction" = mkOption {
        description = "SamplingFraction represents the fraction of requests that should be\nselected for tracing if no prior sampling decision has been made.\n\nOnly one of SamplingRate or SamplingFraction may be specified.\nIf neither field is specified, all requests will be sampled.";
        type = (types.nullOr TelemetryTracingSamplingFractionModule);
        default = null;
      };
      "samplingRate" = mkOption {
        description = "SamplingRate controls the rate at which traffic will be\nselected for tracing if no prior sampling decision has been made.\nDefaults to 100, valid values [0-100]. 100 indicates 100% sampling.\n\nOnly one of SamplingRate or SamplingFraction may be specified.\nIf neither field is specified, all requests will be sampled.";
        type = (types.nullOr types.int);
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
      "provider" = mkTelemetryTracingProvider res."provider";
    }
    // optionalAttrs (res."samplingFraction" != null) {
      "samplingFraction" = mkTelemetryTracingSamplingFraction res."samplingFraction";
    }
    // {
    }
    // optionalAttrs (res."samplingRate" != null) { inherit (res) "samplingRate"; }
    // {
    };
  TelemetryTracingProviderBackendRefModule = types.submodule {
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
  mkTelemetryTracingProviderBackendRef =
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
  TelemetryTracingProviderBackendSettingsCircuitBreakerModule = types.submodule {
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
        type = (types.nullOr TelemetryTracingProviderBackendSettingsCircuitBreakerPerEndpointModule);
        default = null;
      };
    };
  };
  mkTelemetryTracingProviderBackendSettingsCircuitBreaker =
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
      "perEndpoint" =
        mkTelemetryTracingProviderBackendSettingsCircuitBreakerPerEndpoint
          res."perEndpoint";
    }
    // {
    };
  TelemetryTracingProviderBackendSettingsCircuitBreakerPerEndpointModule = types.submodule {
    options = {
      "maxConnections" = mkOption {
        description = "MaxConnections configures the maximum number of connections that Envoy will establish per-endpoint to the referenced backend defined within a xRoute rule.";
        type = (types.nullOr types.int);
        default = 1024;
      };
    };
  };
  mkTelemetryTracingProviderBackendSettingsCircuitBreakerPerEndpoint =
    res:
    {
    }
    // optionalAttrs (res."maxConnections" != null) { inherit (res) "maxConnections"; }
    // {
    };
  TelemetryTracingProviderBackendSettingsConnectionModule = types.submodule {
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
  mkTelemetryTracingProviderBackendSettingsConnection =
    res:
    {
    }
    // optionalAttrs (res."bufferLimit" != null) { inherit (res) "bufferLimit"; }
    // {
    }
    // optionalAttrs (res."socketBufferLimit" != null) { inherit (res) "socketBufferLimit"; }
    // {
    };
  TelemetryTracingProviderBackendSettingsDnsModule = types.submodule {
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
  mkTelemetryTracingProviderBackendSettingsDns =
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
  TelemetryTracingProviderBackendSettingsHealthCheckActiveGrpcModule = types.submodule {
    options = {
      "service" = mkOption {
        description = "Service to send in the health check request.\nIf this is not specified, then the health check request applies to the entire\nserver and not to a specific service.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTelemetryTracingProviderBackendSettingsHealthCheckActiveGrpc =
    res:
    {
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  TelemetryTracingProviderBackendSettingsHealthCheckActiveHttpExpectedResponseModule =
    types.submodule
      {
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
  mkTelemetryTracingProviderBackendSettingsHealthCheckActiveHttpExpectedResponse =
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
  TelemetryTracingProviderBackendSettingsHealthCheckActiveHttpModule = types.submodule {
    options = {
      "expectedResponse" = mkOption {
        description = "ExpectedResponse defines a list of HTTP expected responses to match.";
        type = (
          types.nullOr TelemetryTracingProviderBackendSettingsHealthCheckActiveHttpExpectedResponseModule
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
  mkTelemetryTracingProviderBackendSettingsHealthCheckActiveHttp =
    res:
    {
    }
    // optionalAttrs (res."expectedResponse" != null) {
      "expectedResponse" =
        mkTelemetryTracingProviderBackendSettingsHealthCheckActiveHttpExpectedResponse
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
  TelemetryTracingProviderBackendSettingsHealthCheckActiveModule = types.submodule {
    options = {
      "grpc" = mkOption {
        description = "GRPC defines the configuration of the GRPC health checker.\nIt's optional, and can only be used if the specified type is GRPC.";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsHealthCheckActiveGrpcModule);
        default = null;
      };
      "healthyThreshold" = mkOption {
        description = "HealthyThreshold defines the number of healthy health checks required before a backend host is marked healthy.";
        type = (types.nullOr types.int);
        default = 1;
      };
      "http" = mkOption {
        description = "HTTP defines the configuration of http health checker.\nIt's required while the health checker type is HTTP.";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsHealthCheckActiveHttpModule);
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
        type = (types.nullOr TelemetryTracingProviderBackendSettingsHealthCheckActiveTcpModule);
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
  mkTelemetryTracingProviderBackendSettingsHealthCheckActive =
    res:
    {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkTelemetryTracingProviderBackendSettingsHealthCheckActiveGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."healthyThreshold" != null) { inherit (res) "healthyThreshold"; }
    // {
    }
    // optionalAttrs (res."http" != null) {
      "http" = mkTelemetryTracingProviderBackendSettingsHealthCheckActiveHttp res."http";
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
      "tcp" = mkTelemetryTracingProviderBackendSettingsHealthCheckActiveTcp res."tcp";
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
  TelemetryTracingProviderBackendSettingsHealthCheckActiveTcpModule = types.submodule {
    options = {
      "receive" = mkOption {
        description = "Receive defines the expected response payload.";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsHealthCheckActiveTcpReceiveModule);
        default = null;
      };
      "send" = mkOption {
        description = "Send defines the request payload.";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsHealthCheckActiveTcpSendModule);
        default = null;
      };
    };
  };
  mkTelemetryTracingProviderBackendSettingsHealthCheckActiveTcp =
    res:
    {
    }
    // optionalAttrs (res."receive" != null) {
      "receive" = mkTelemetryTracingProviderBackendSettingsHealthCheckActiveTcpReceive res."receive";
    }
    // {
    }
    // optionalAttrs (res."send" != null) {
      "send" = mkTelemetryTracingProviderBackendSettingsHealthCheckActiveTcpSend res."send";
    }
    // {
    };
  TelemetryTracingProviderBackendSettingsHealthCheckActiveTcpReceiveModule = types.submodule {
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
  mkTelemetryTracingProviderBackendSettingsHealthCheckActiveTcpReceive =
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
  TelemetryTracingProviderBackendSettingsHealthCheckActiveTcpSendModule = types.submodule {
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
  mkTelemetryTracingProviderBackendSettingsHealthCheckActiveTcpSend =
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
  TelemetryTracingProviderBackendSettingsHealthCheckModule = types.submodule {
    options = {
      "active" = mkOption {
        description = "Active health check configuration";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsHealthCheckActiveModule);
        default = null;
      };
      "panicThreshold" = mkOption {
        description = "When number of unhealthy endpoints for a backend reaches this threshold\nEnvoy will disregard health status and balance across all endpoints.\nIt's designed to prevent a situation in which host failures cascade throughout the cluster\nas load increases. If not set, the default value is 50%. To disable panic mode, set value to `0`.";
        type = (types.nullOr types.int);
        default = null;
      };
      "passive" = mkOption {
        description = "Passive passive check configuration";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsHealthCheckPassiveModule);
        default = null;
      };
    };
  };
  mkTelemetryTracingProviderBackendSettingsHealthCheck =
    res:
    {
    }
    // optionalAttrs (res."active" != null) {
      "active" = mkTelemetryTracingProviderBackendSettingsHealthCheckActive res."active";
    }
    // {
    }
    // optionalAttrs (res."panicThreshold" != null) { inherit (res) "panicThreshold"; }
    // {
    }
    // optionalAttrs (res."passive" != null) {
      "passive" = mkTelemetryTracingProviderBackendSettingsHealthCheckPassive res."passive";
    }
    // {
    };
  TelemetryTracingProviderBackendSettingsHealthCheckPassiveModule = types.submodule {
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
  mkTelemetryTracingProviderBackendSettingsHealthCheckPassive =
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
  TelemetryTracingProviderBackendSettingsHttp2Module = types.submodule {
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
  mkTelemetryTracingProviderBackendSettingsHttp2 =
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
  TelemetryTracingProviderBackendSettingsLoadBalancerConsistentHashCookieModule = types.submodule {
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
  mkTelemetryTracingProviderBackendSettingsLoadBalancerConsistentHashCookie =
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
  TelemetryTracingProviderBackendSettingsLoadBalancerConsistentHashHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the header to hash.";
        type = types.str;
      };
    };
  };
  mkTelemetryTracingProviderBackendSettingsLoadBalancerConsistentHashHeader = res: {
    inherit (res) "name";
  };
  TelemetryTracingProviderBackendSettingsLoadBalancerConsistentHashModule = types.submodule {
    options = {
      "cookie" = mkOption {
        description = "Cookie configures the cookie hash policy when the consistent hash type is set to Cookie.";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsLoadBalancerConsistentHashCookieModule);
        default = null;
      };
      "header" = mkOption {
        description = "Header configures the header hash policy when the consistent hash type is set to Header.";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsLoadBalancerConsistentHashHeaderModule);
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
  mkTelemetryTracingProviderBackendSettingsLoadBalancerConsistentHash =
    res:
    {
    }
    // optionalAttrs (res."cookie" != null) {
      "cookie" = mkTelemetryTracingProviderBackendSettingsLoadBalancerConsistentHashCookie res."cookie";
    }
    // {
    }
    // optionalAttrs (res."header" != null) {
      "header" = mkTelemetryTracingProviderBackendSettingsLoadBalancerConsistentHashHeader res."header";
    }
    // {
    }
    // optionalAttrs (res."tableSize" != null) { inherit (res) "tableSize"; }
    // {
      inherit (res) "type";
    };
  TelemetryTracingProviderBackendSettingsLoadBalancerEndpointOverrideExtractFromModule =
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
  mkTelemetryTracingProviderBackendSettingsLoadBalancerEndpointOverrideExtractFrom =
    res:
    {
    }
    // optionalAttrs (res."header" != null) { inherit (res) "header"; }
    // {
    };
  TelemetryTracingProviderBackendSettingsLoadBalancerEndpointOverrideModule = types.submodule {
    options = {
      "extractFrom" = mkOption {
        description = "ExtractFrom defines the sources to extract endpoint override information from.";
        type = (
          types.listOf TelemetryTracingProviderBackendSettingsLoadBalancerEndpointOverrideExtractFromModule
        );
      };
    };
  };
  mkTelemetryTracingProviderBackendSettingsLoadBalancerEndpointOverride = res: {
    "extractFrom" =
      map mkTelemetryTracingProviderBackendSettingsLoadBalancerEndpointOverrideExtractFrom
        res."extractFrom";
  };
  TelemetryTracingProviderBackendSettingsLoadBalancerModule = types.submodule {
    options = {
      "consistentHash" = mkOption {
        description = "ConsistentHash defines the configuration when the load balancer type is\nset to ConsistentHash";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsLoadBalancerConsistentHashModule);
        default = null;
      };
      "endpointOverride" = mkOption {
        description = "EndpointOverride defines the configuration for endpoint override.\nWhen specified, the load balancer will attempt to route requests to endpoints\nbased on the override information extracted from request headers or metadata.\n If the override endpoints are not available, the configured load balancer policy will be used as fallback.";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsLoadBalancerEndpointOverrideModule);
        default = null;
      };
      "slowStart" = mkOption {
        description = "SlowStart defines the configuration related to the slow start load balancer policy.\nIf set, during slow start window, traffic sent to the newly added hosts will gradually increase.\nCurrently this is only supported for RoundRobin and LeastRequest load balancers";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsLoadBalancerSlowStartModule);
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
        type = (types.nullOr TelemetryTracingProviderBackendSettingsLoadBalancerZoneAwareModule);
        default = null;
      };
    };
  };
  mkTelemetryTracingProviderBackendSettingsLoadBalancer =
    res:
    {
    }
    // optionalAttrs (res."consistentHash" != null) {
      "consistentHash" =
        mkTelemetryTracingProviderBackendSettingsLoadBalancerConsistentHash
          res."consistentHash";
    }
    // {
    }
    // optionalAttrs (res."endpointOverride" != null) {
      "endpointOverride" =
        mkTelemetryTracingProviderBackendSettingsLoadBalancerEndpointOverride
          res."endpointOverride";
    }
    // {
    }
    // optionalAttrs (res."slowStart" != null) {
      "slowStart" = mkTelemetryTracingProviderBackendSettingsLoadBalancerSlowStart res."slowStart";
    }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."zoneAware" != null) {
      "zoneAware" = mkTelemetryTracingProviderBackendSettingsLoadBalancerZoneAware res."zoneAware";
    }
    // {
    };
  TelemetryTracingProviderBackendSettingsLoadBalancerSlowStartModule = types.submodule {
    options = {
      "window" = mkOption {
        description = "Window defines the duration of the warm up period for newly added host.\nDuring slow start window, traffic sent to the newly added hosts will gradually increase.\nCurrently only supports linear growth of traffic. For additional details,\nsee https://www.envoyproxy.io/docs/envoy/latest/api-v3/config/cluster/v3/cluster.proto#config-cluster-v3-cluster-slowstartconfig";
        type = types.str;
      };
    };
  };
  mkTelemetryTracingProviderBackendSettingsLoadBalancerSlowStart = res: {
    inherit (res) "window";
  };
  TelemetryTracingProviderBackendSettingsLoadBalancerZoneAwareModule = types.submodule {
    options = {
      "preferLocal" = mkOption {
        description = "PreferLocalZone configures zone-aware routing to prefer sending traffic to the local locality zone.";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsLoadBalancerZoneAwarePreferLocalModule);
        default = null;
      };
    };
  };
  mkTelemetryTracingProviderBackendSettingsLoadBalancerZoneAware =
    res:
    {
    }
    // optionalAttrs (res."preferLocal" != null) {
      "preferLocal" =
        mkTelemetryTracingProviderBackendSettingsLoadBalancerZoneAwarePreferLocal
          res."preferLocal";
    }
    // {
    };
  TelemetryTracingProviderBackendSettingsLoadBalancerZoneAwarePreferLocalForceModule =
    types.submodule
      {
        options = {
          "minEndpointsInZoneThreshold" = mkOption {
            description = "MinEndpointsInZoneThreshold is the minimum number of upstream endpoints in the local zone required to honor the forceLocalZone\noverride. This is useful for protecting zones with fewer endpoints.";
            type = (types.nullOr types.int);
            default = null;
          };
        };
      };
  mkTelemetryTracingProviderBackendSettingsLoadBalancerZoneAwarePreferLocalForce =
    res:
    {
    }
    // optionalAttrs (res."minEndpointsInZoneThreshold" != null) {
      inherit (res) "minEndpointsInZoneThreshold";
    }
    // {
    };
  TelemetryTracingProviderBackendSettingsLoadBalancerZoneAwarePreferLocalModule = types.submodule {
    options = {
      "force" = mkOption {
        description = "ForceLocalZone defines override configuration for forcing all traffic to stay within the local zone instead of the default behavior\nwhich maintains equal distribution among upstream endpoints while sending as much traffic as possible locally.";
        type = (
          types.nullOr TelemetryTracingProviderBackendSettingsLoadBalancerZoneAwarePreferLocalForceModule
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
  mkTelemetryTracingProviderBackendSettingsLoadBalancerZoneAwarePreferLocal =
    res:
    {
    }
    // optionalAttrs (res."force" != null) {
      "force" =
        mkTelemetryTracingProviderBackendSettingsLoadBalancerZoneAwarePreferLocalForce
          res."force";
    }
    // {
    }
    // optionalAttrs (res."minEndpointsThreshold" != null) { inherit (res) "minEndpointsThreshold"; }
    // {
    };
  TelemetryTracingProviderBackendSettingsModule = types.submodule {
    options = {
      "circuitBreaker" = mkOption {
        description = "Circuit Breaker settings for the upstream connections and requests.\nIf not set, circuit breakers will be enabled with the default thresholds";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsCircuitBreakerModule);
        default = null;
      };
      "connection" = mkOption {
        description = "Connection includes backend connection settings.";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsConnectionModule);
        default = null;
      };
      "dns" = mkOption {
        description = "DNS includes dns resolution settings.";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsDnsModule);
        default = null;
      };
      "healthCheck" = mkOption {
        description = "HealthCheck allows gateway to perform active health checking on backends.";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsHealthCheckModule);
        default = null;
      };
      "http2" = mkOption {
        description = "HTTP2 provides HTTP/2 configuration for backend connections.";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsHttp2Module);
        default = null;
      };
      "loadBalancer" = mkOption {
        description = "LoadBalancer policy to apply when routing traffic from the gateway to\nthe backend endpoints. Defaults to `LeastRequest`.";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsLoadBalancerModule);
        default = null;
      };
      "proxyProtocol" = mkOption {
        description = "ProxyProtocol enables the Proxy Protocol when communicating with the backend.";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsProxyProtocolModule);
        default = null;
      };
      "retry" = mkOption {
        description = "Retry provides more advanced usage, allowing users to customize the number of retries, retry fallback strategy, and retry triggering conditions.\nIf not set, retry will be disabled.";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsRetryModule);
        default = null;
      };
      "tcpKeepalive" = mkOption {
        description = "TcpKeepalive settings associated with the upstream client connection.\nDisabled by default.";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsTcpKeepaliveModule);
        default = null;
      };
      "timeout" = mkOption {
        description = "Timeout settings for the backend connections.";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsTimeoutModule);
        default = null;
      };
    };
  };
  mkTelemetryTracingProviderBackendSettings =
    res:
    {
    }
    // optionalAttrs (res."circuitBreaker" != null) {
      "circuitBreaker" = mkTelemetryTracingProviderBackendSettingsCircuitBreaker res."circuitBreaker";
    }
    // {
    }
    // optionalAttrs (res."connection" != null) {
      "connection" = mkTelemetryTracingProviderBackendSettingsConnection res."connection";
    }
    // {
    }
    // optionalAttrs (res."dns" != null) {
      "dns" = mkTelemetryTracingProviderBackendSettingsDns res."dns";
    }
    // {
    }
    // optionalAttrs (res."healthCheck" != null) {
      "healthCheck" = mkTelemetryTracingProviderBackendSettingsHealthCheck res."healthCheck";
    }
    // {
    }
    // optionalAttrs (res."http2" != null) {
      "http2" = mkTelemetryTracingProviderBackendSettingsHttp2 res."http2";
    }
    // {
    }
    // optionalAttrs (res."loadBalancer" != null) {
      "loadBalancer" = mkTelemetryTracingProviderBackendSettingsLoadBalancer res."loadBalancer";
    }
    // {
    }
    // optionalAttrs (res."proxyProtocol" != null) {
      "proxyProtocol" = mkTelemetryTracingProviderBackendSettingsProxyProtocol res."proxyProtocol";
    }
    // {
    }
    // optionalAttrs (res."retry" != null) {
      "retry" = mkTelemetryTracingProviderBackendSettingsRetry res."retry";
    }
    // {
    }
    // optionalAttrs (res."tcpKeepalive" != null) {
      "tcpKeepalive" = mkTelemetryTracingProviderBackendSettingsTcpKeepalive res."tcpKeepalive";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) {
      "timeout" = mkTelemetryTracingProviderBackendSettingsTimeout res."timeout";
    }
    // {
    };
  TelemetryTracingProviderBackendSettingsProxyProtocolModule = types.submodule {
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
  mkTelemetryTracingProviderBackendSettingsProxyProtocol = res: {
    inherit (res) "version";
  };
  TelemetryTracingProviderBackendSettingsRetryModule = types.submodule {
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
        type = (types.nullOr TelemetryTracingProviderBackendSettingsRetryPerRetryModule);
        default = null;
      };
      "retryOn" = mkOption {
        description = "RetryOn specifies the retry trigger condition.\n\nIf not specified, the default is to retry on connect-failure,refused-stream,unavailable,cancelled,retriable-status-codes(503).";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsRetryRetryOnModule);
        default = null;
      };
    };
  };
  mkTelemetryTracingProviderBackendSettingsRetry =
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
      "perRetry" = mkTelemetryTracingProviderBackendSettingsRetryPerRetry res."perRetry";
    }
    // {
    }
    // optionalAttrs (res."retryOn" != null) {
      "retryOn" = mkTelemetryTracingProviderBackendSettingsRetryRetryOn res."retryOn";
    }
    // {
    };
  TelemetryTracingProviderBackendSettingsRetryPerRetryBackOffModule = types.submodule {
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
  mkTelemetryTracingProviderBackendSettingsRetryPerRetryBackOff =
    res:
    {
    }
    // optionalAttrs (res."baseInterval" != null) { inherit (res) "baseInterval"; }
    // {
    }
    // optionalAttrs (res."maxInterval" != null) { inherit (res) "maxInterval"; }
    // {
    };
  TelemetryTracingProviderBackendSettingsRetryPerRetryModule = types.submodule {
    options = {
      "backOff" = mkOption {
        description = "Backoff is the backoff policy to be applied per retry attempt. gateway uses a fully jittered exponential\nback-off algorithm for retries. For additional details,\nsee https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/router_filter#config-http-filters-router-x-envoy-max-retries";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsRetryPerRetryBackOffModule);
        default = null;
      };
      "timeout" = mkOption {
        description = "Timeout is the timeout per retry attempt.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTelemetryTracingProviderBackendSettingsRetryPerRetry =
    res:
    {
    }
    // optionalAttrs (res."backOff" != null) {
      "backOff" = mkTelemetryTracingProviderBackendSettingsRetryPerRetryBackOff res."backOff";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    };
  TelemetryTracingProviderBackendSettingsRetryRetryOnModule = types.submodule {
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
  mkTelemetryTracingProviderBackendSettingsRetryRetryOn =
    res:
    {
    }
    // optionalAttrs (res."httpStatusCodes" != [ ]) { inherit (res) "httpStatusCodes"; }
    // {
    }
    // optionalAttrs (res."triggers" != [ ]) { inherit (res) "triggers"; }
    // {
    };
  TelemetryTracingProviderBackendSettingsTcpKeepaliveModule = types.submodule {
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
  mkTelemetryTracingProviderBackendSettingsTcpKeepalive =
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
  TelemetryTracingProviderBackendSettingsTimeoutHttpModule = types.submodule {
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
  mkTelemetryTracingProviderBackendSettingsTimeoutHttp =
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
  TelemetryTracingProviderBackendSettingsTimeoutModule = types.submodule {
    options = {
      "http" = mkOption {
        description = "Timeout settings for HTTP.";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsTimeoutHttpModule);
        default = null;
      };
      "tcp" = mkOption {
        description = "Timeout settings for TCP.";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsTimeoutTcpModule);
        default = null;
      };
    };
  };
  mkTelemetryTracingProviderBackendSettingsTimeout =
    res:
    {
    }
    // optionalAttrs (res."http" != null) {
      "http" = mkTelemetryTracingProviderBackendSettingsTimeoutHttp res."http";
    }
    // {
    }
    // optionalAttrs (res."tcp" != null) {
      "tcp" = mkTelemetryTracingProviderBackendSettingsTimeoutTcp res."tcp";
    }
    // {
    };
  TelemetryTracingProviderBackendSettingsTimeoutTcpModule = types.submodule {
    options = {
      "connectTimeout" = mkOption {
        description = "The timeout for network connection establishment, including TCP and TLS handshakes.\nDefault: 10 seconds.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTelemetryTracingProviderBackendSettingsTimeoutTcp =
    res:
    {
    }
    // optionalAttrs (res."connectTimeout" != null) { inherit (res) "connectTimeout"; }
    // {
    };
  TelemetryTracingProviderModule = types.submodule {
    options = {
      "backendRef" = mkOption {
        description = "BackendRef references a Kubernetes object that represents the\nbackend server to which the authorization request will be sent.\n\nDeprecated: Use BackendRefs instead.";
        type = (types.nullOr TelemetryTracingProviderBackendRefModule);
        default = null;
      };
      "backendRefs" = mkOption {
        description = "BackendRefs references a Kubernetes object that represents the\nbackend server to which the authorization request will be sent.";
        type = (types.listOf TelemetryTracingProviderBackendRefModule);
        default = [ ];
      };
      "backendSettings" = mkOption {
        description = "BackendSettings holds configuration for managing the connection\nto the backend.";
        type = (types.nullOr TelemetryTracingProviderBackendSettingsModule);
        default = null;
      };
      "host" = mkOption {
        description = "Host define the provider service hostname.\nDeprecated: Use BackendRefs instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Port defines the port the provider service is exposed on.\nDeprecated: Use BackendRefs instead.";
        type = (types.nullOr types.int);
        default = 4317;
      };
      "serviceName" = mkOption {
        description = "ServiceName defines the service name to use in tracing configuration.\nIf not set, Envoy Gateway will use a default service name set as\n\"name.namespace\" (e.g., \"my-gateway.default\").\nNote: This field is only supported for OpenTelemetry and Datadog tracing providers.\nFor Zipkin, the service name in traces is always derived from the Envoy --service-cluster flag\n(typically \"namespace/name\" format). Setting this field has no effect for Zipkin.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Type defines the tracing provider type.";
        type = (
          types.enum [
            "OpenTelemetry"
            "Zipkin"
            "Datadog"
          ]
        );
      };
      "zipkin" = mkOption {
        description = "Zipkin defines the Zipkin tracing provider configuration";
        type = (types.nullOr TelemetryTracingProviderZipkinModule);
        default = null;
      };
    };
  };
  mkTelemetryTracingProvider =
    res:
    {
    }
    // optionalAttrs (res."backendRef" != null) {
      "backendRef" = mkTelemetryTracingProviderBackendRef res."backendRef";
    }
    // {
    }
    // optionalAttrs (res."backendRefs" != [ ]) {
      "backendRefs" = map mkTelemetryTracingProviderBackendRef res."backendRefs";
    }
    // {
    }
    // optionalAttrs (res."backendSettings" != null) {
      "backendSettings" = mkTelemetryTracingProviderBackendSettings res."backendSettings";
    }
    // {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
    }
    // optionalAttrs (res."serviceName" != null) { inherit (res) "serviceName"; }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."zipkin" != null) {
      "zipkin" = mkTelemetryTracingProviderZipkin res."zipkin";
    }
    // {
    };
  TelemetryTracingProviderZipkinModule = types.submodule {
    options = {
      "disableSharedSpanContext" = mkOption {
        description = "DisableSharedSpanContext determines whether the default Envoy behaviour of\nclient and server spans sharing the same span context should be disabled.";
        type = types.bool;
        default = false;
      };
      "enable128BitTraceId" = mkOption {
        description = "Enable128BitTraceID determines whether a 128bit trace id will be used\nwhen creating a new trace instance. If set to false, a 64bit trace\nid will be used.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkTelemetryTracingProviderZipkin =
    res:
    {
    }
    // optionalAttrs res."disableSharedSpanContext" { inherit (res) "disableSharedSpanContext"; }
    // {
    }
    // optionalAttrs res."enable128BitTraceId" { inherit (res) "enable128BitTraceId"; }
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
  EnvoyproxiesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this EnvoyProxy resource.";
        };
        "backendTLS" = mkOption {
          description = "BackendTLS is the TLS configuration for the Envoy proxy to use when connecting to backends.\nThese settings are applied on backends for which TLS policies are specified.";
          type = (types.nullOr BackendTLSModule);
          default = null;
        };
        "bootstrap" = mkOption {
          description = "Bootstrap defines the Envoy Bootstrap as a YAML string.\nVisit https://www.envoyproxy.io/docs/envoy/latest/api-v3/config/bootstrap/v3/bootstrap.proto#envoy-v3-api-msg-config-bootstrap-v3-bootstrap\nto learn more about the syntax.\nIf set, this is the Bootstrap configuration used for the managed Envoy Proxy fleet instead of the default Bootstrap configuration\nset by Envoy Gateway.\nSome fields within the Bootstrap that are required to communicate with the xDS Server (Envoy Gateway) and receive xDS resources\nfrom it are not configurable and will result in the `EnvoyProxy` resource being rejected.\nBackward compatibility across minor versions is not guaranteed.\nWe strongly recommend using `egctl x translate` to generate a `EnvoyProxy` resource with the `Bootstrap` field set to the default\nBootstrap configuration used. You can edit this configuration, and rerun `egctl x translate` to ensure there are no validation errors.";
          type = (types.nullOr BootstrapModule);
          default = null;
        };
        "concurrency" = mkOption {
          description = "Concurrency defines the number of worker threads to run. If unset, it defaults to\nthe number of cpuset threads on the platform.";
          type = (types.nullOr types.int);
          default = null;
        };
        "extraArgs" = mkOption {
          description = "ExtraArgs defines additional command line options that are provided to Envoy.\nMore info: https://www.envoyproxy.io/docs/envoy/latest/operations/cli#command-line-options\nNote: some command line options are used internally(e.g. --log-level) so they cannot be provided here.";
          type = (types.listOf types.str);
          default = [ ];
        };
        "filterOrder" = mkOption {
          description = "FilterOrder defines the order of filters in the Envoy proxy's HTTP filter chain.\nThe FilterPosition in the list will be applied in the order they are defined.\nIf unspecified, the default filter order is applied.\nDefault filter order is:\n\n- envoy.filters.http.health_check\n\n- envoy.filters.http.fault\n\n- envoy.filters.http.cors\n\n- envoy.filters.http.ext_authz\n\n- envoy.filters.http.basic_auth\n\n- envoy.filters.http.oauth2\n\n- envoy.filters.http.jwt_authn\n\n- envoy.filters.http.stateful_session\n\n- envoy.filters.http.lua\n\n- envoy.filters.http.ext_proc\n\n- envoy.filters.http.wasm\n\n- envoy.filters.http.rbac\n\n- envoy.filters.http.local_ratelimit\n\n- envoy.filters.http.ratelimit\n\n- envoy.filters.http.custom_response\n\n- envoy.filters.http.router\n\nNote: \"envoy.filters.http.router\" cannot be reordered, it's always the last filter in the chain.";
          type = (types.listOf FilterOrderModule);
          default = [ ];
        };
        "ipFamily" = mkOption {
          description = "IPFamily specifies the IP family for the EnvoyProxy fleet.\nThis setting only affects the Gateway listener port and does not impact\nother aspects of the Envoy proxy configuration.\nIf not specified, the system will operate as follows:\n- It defaults to IPv4 only.\n- IPv6 and dual-stack environments are not supported in this default configuration.\nNote: To enable IPv6 or dual-stack functionality, explicit configuration is required.";
          type = (
            types.nullOr (
              types.enum [
                "IPv4"
                "IPv6"
                "DualStack"
              ]
            )
          );
          default = null;
        };
        "logging" = mkOption {
          description = "Logging defines logging parameters for managed proxies.";
          type = (types.nullOr LoggingModule);
          default = {
            "level" = {
              "default" = "warn";
            };
          };
        };
        "luaValidation" = mkOption {
          description = "LuaValidation determines strictness of the Lua script validation for Lua EnvoyExtensionPolicies\nDefault: Strict";
          type = (
            types.nullOr (
              types.enum [
                "Strict"
                "Disabled"
              ]
            )
          );
          default = null;
        };
        "mergeGateways" = mkOption {
          description = "MergeGateways defines if Gateway resources should be merged onto the same Envoy Proxy Infrastructure.\nSetting this field to true would merge all Gateway Listeners under the parent Gateway Class.\nThis means that the port, protocol and hostname tuple must be unique for every listener.\nIf a duplicate listener is detected, the newer listener (based on timestamp) will be rejected and its status will be updated with a \"Accepted=False\" condition.";
          type = types.bool;
          default = false;
        };
        "preserveRouteOrder" = mkOption {
          description = "PreserveRouteOrder determines if the order of matching for HTTPRoutes is determined by Gateway-API\nspecification (https://gateway-api.sigs.k8s.io/reference/spec/#gateway.networking.k8s.io/v1.HTTPRouteRule)\nor preserves the order defined by users in the HTTPRoute's HTTPRouteRule list.\nDefault: False";
          type = types.bool;
          default = false;
        };
        "provider" = mkOption {
          description = "Provider defines the desired resource provider and provider-specific configuration.\nIf unspecified, the \"Kubernetes\" resource provider is used with default configuration\nparameters.";
          type = (types.nullOr ProviderModule);
          default = null;
        };
        "routingType" = mkOption {
          description = "RoutingType can be set to \"Service\" to use the Service Cluster IP for routing to the backend,\nor it can be set to \"Endpoint\" to use Endpoint routing. The default is \"Endpoint\".";
          type = (types.nullOr types.str);
          default = null;
        };
        "shutdown" = mkOption {
          description = "Shutdown defines configuration for graceful envoy shutdown process.";
          type = (types.nullOr ShutdownModule);
          default = null;
        };
        "telemetry" = mkOption {
          description = "Telemetry defines telemetry parameters for managed proxies.";
          type = (types.nullOr TelemetryModule);
          default = null;
        };
      };
    }
  );
  mkEnvoyProxy = name: res: {
    apiVersion = "gateway.envoyproxy.io/v1alpha1";
    kind = "EnvoyProxy";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."backendTLS" != null) { "backendTLS" = mkBackendTLS res."backendTLS"; }
    // {
    }
    // optionalAttrs (res."bootstrap" != null) { "bootstrap" = mkBootstrap res."bootstrap"; }
    // {
    }
    // optionalAttrs (res."concurrency" != null) { inherit (res) "concurrency"; }
    // {
    }
    // optionalAttrs (res."extraArgs" != [ ]) { inherit (res) "extraArgs"; }
    // {
    }
    // optionalAttrs (res."filterOrder" != [ ]) { "filterOrder" = map mkFilterOrder res."filterOrder"; }
    // {
    }
    // optionalAttrs (res."ipFamily" != null) { inherit (res) "ipFamily"; }
    // {
    }
    // optionalAttrs (res."logging" != null) { "logging" = mkLogging res."logging"; }
    // {
    }
    // optionalAttrs (res."luaValidation" != null) { inherit (res) "luaValidation"; }
    // {
    }
    // optionalAttrs res."mergeGateways" { inherit (res) "mergeGateways"; }
    // {
    }
    // optionalAttrs res."preserveRouteOrder" { inherit (res) "preserveRouteOrder"; }
    // {
    }
    // optionalAttrs (res."provider" != null) { "provider" = mkProvider res."provider"; }
    // {
    }
    // optionalAttrs (res."routingType" != null) { inherit (res) "routingType"; }
    // {
    }
    // optionalAttrs (res."shutdown" != null) { "shutdown" = mkShutdown res."shutdown"; }
    // {
    }
    // optionalAttrs (res."telemetry" != null) { "telemetry" = mkTelemetry res."telemetry"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkEnvoyProxy cfg."envoyproxies");
in
{
  options.openkrill.apps."envoy-gateway" = {
    "envoyproxies" = mkOption {
      type = types.attrsOf EnvoyproxiesModule;
      default = { };
      description = "EnvoyProxy CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."envoy-gateway".content = allResources;
  };
}
