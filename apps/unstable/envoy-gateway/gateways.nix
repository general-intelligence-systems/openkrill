# Auto-generated openkrill module fragment for envoy-gateway
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."envoy-gateway";
  compact = filterAttrs (_: v: v != null);
  AddresseModule = types.submodule {
    options = {
      "type" = mkOption {
        description = "Type of the address.";
        type = (types.nullOr types.str);
        default = "IPAddress";
      };
      "value" = mkOption {
        description = "When a value is unspecified, an implementation SHOULD automatically\nassign an address matching the requested type if possible.\n\nIf an implementation does not support an empty value, they MUST set the\n\"Programmed\" condition in status to False with a reason of \"AddressNotAssigned\".\n\nExamples: `1.2.3.4`, `128::1`, `my-ip-address`.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkAddresse =
    res:
    {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  AllowedListenersModule = types.submodule {
    options = {
      "namespaces" = mkOption {
        description = "Namespaces defines which namespaces ListenerSets can be attached to this Gateway.\nWhile this feature is experimental, the default value is to allow no ListenerSets.";
        type = (types.nullOr AllowedListenersNamespacesModule);
        default = {
          "from" = "None";
        };
      };
    };
  };
  mkAllowedListeners =
    res:
    {
    }
    // optionalAttrs (res."namespaces" != null) {
      "namespaces" = mkAllowedListenersNamespaces res."namespaces";
    }
    // {
    };
  AllowedListenersNamespacesModule = types.submodule {
    options = {
      "from" = mkOption {
        description = "From indicates where ListenerSets can attach to this Gateway. Possible\nvalues are:\n\n* Same: Only ListenerSets in the same namespace may be attached to this Gateway.\n* Selector: ListenerSets in namespaces selected by the selector may be attached to this Gateway.\n* All: ListenerSets in all namespaces may be attached to this Gateway.\n* None: Only listeners defined in the Gateway's spec are allowed\n\nWhile this feature is experimental, the default value None";
        type = (
          types.nullOr (
            types.enum [
              "All"
              "Selector"
              "Same"
              "None"
            ]
          )
        );
        default = "None";
      };
      "selector" = mkOption {
        description = "Selector must be specified when From is set to \"Selector\". In that case,\nonly ListenerSets in Namespaces matching this Selector will be selected by this\nGateway. This field is ignored for other values of \"From\".";
        type = (types.nullOr AllowedListenersNamespacesSelectorModule);
        default = null;
      };
    };
  };
  mkAllowedListenersNamespaces =
    res:
    {
    }
    // optionalAttrs (res."from" != null) { inherit (res) "from"; }
    // {
    }
    // optionalAttrs (res."selector" != null) {
      "selector" = mkAllowedListenersNamespacesSelector res."selector";
    }
    // {
    };
  AllowedListenersNamespacesSelectorMatchExpressionModule = types.submodule {
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
  mkAllowedListenersNamespacesSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AllowedListenersNamespacesSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf AllowedListenersNamespacesSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkAllowedListenersNamespacesSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkAllowedListenersNamespacesSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
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
      "clientCertificateRef" = mkOption {
        description = "ClientCertificateRef is a reference to an object that contains a Client\nCertificate and the associated private key.\n\nReferences to a resource in different namespace are invalid UNLESS there\nis a ReferenceGrant in the target namespace that allows the certificate\nto be attached. If a ReferenceGrant does not allow this reference, the\n\"ResolvedRefs\" condition MUST be set to False for this listener with the\n\"RefNotPermitted\" reason.\n\nClientCertificateRef can reference to standard Kubernetes resources, i.e.\nSecret, or implementation-specific custom resources.\n\nThis setting can be overridden on the service level by use of BackendTLSPolicy.\n\nSupport: Core";
        type = (types.nullOr BackendTLSClientCertificateRefModule);
        default = null;
      };
    };
  };
  mkBackendTLS =
    res:
    {
    }
    // optionalAttrs (res."clientCertificateRef" != null) {
      "clientCertificateRef" = mkBackendTLSClientCertificateRef res."clientCertificateRef";
    }
    // {
    };
  InfrastructureModule = types.submodule {
    options = {
      "annotations" = mkOption {
        description = "Annotations that SHOULD be applied to any resources created in response to this Gateway.\n\nFor implementations creating other Kubernetes objects, this should be the `metadata.annotations` field on resources.\nFor other implementations, this refers to any relevant (implementation specific) \"annotations\" concepts.\n\nAn implementation may chose to add additional implementation-specific annotations as they see fit.\n\nSupport: Extended";
        type = (types.attrsOf types.str);
        default = { };
      };
      "labels" = mkOption {
        description = "Labels that SHOULD be applied to any resources created in response to this Gateway.\n\nFor implementations creating other Kubernetes objects, this should be the `metadata.labels` field on resources.\nFor other implementations, this refers to any relevant (implementation specific) \"labels\" concepts.\n\nAn implementation may chose to add additional implementation-specific labels as they see fit.\n\nIf an implementation maps these labels to Pods, or any other resource that would need to be recreated when labels\nchange, it SHOULD clearly warn about this behavior in documentation.\n\nSupport: Extended";
        type = (types.attrsOf types.str);
        default = { };
      };
      "parametersRef" = mkOption {
        description = "ParametersRef is a reference to a resource that contains the configuration\nparameters corresponding to the Gateway. This is optional if the\ncontroller does not require any additional configuration.\n\nThis follows the same semantics as GatewayClass's `parametersRef`, but on a per-Gateway basis\n\nThe Gateway's GatewayClass may provide its own `parametersRef`. When both are specified,\nthe merging behavior is implementation specific.\nIt is generally recommended that GatewayClass provides defaults that can be overridden by a Gateway.\n\nIf the referent cannot be found, refers to an unsupported kind, or when\nthe data within that resource is malformed, the Gateway SHOULD be\nrejected with the \"Accepted\" status condition set to \"False\" and an\n\"InvalidParameters\" reason.\n\nSupport: Implementation-specific";
        type = (types.nullOr InfrastructureParametersRefModule);
        default = null;
      };
    };
  };
  mkInfrastructure =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."parametersRef" != null) {
      "parametersRef" = mkInfrastructureParametersRef res."parametersRef";
    }
    // {
    };
  InfrastructureParametersRefModule = types.submodule {
    options = {
      "group" = mkOption {
        description = "Group is the group of the referent.";
        type = types.str;
      };
      "kind" = mkOption {
        description = "Kind is kind of the referent.";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name is the name of the referent.";
        type = types.str;
      };
    };
  };
  mkInfrastructureParametersRef = res: {
    inherit (res) "group";
    inherit (res) "kind";
    inherit (res) "name";
  };
  ListenerAllowedRoutesKindModule = types.submodule {
    options = {
      "group" = mkOption {
        description = "Group is the group of the Route.";
        type = (types.nullOr types.str);
        default = "gateway.networking.k8s.io";
      };
      "kind" = mkOption {
        description = "Kind is the kind of the Route.";
        type = types.str;
      };
    };
  };
  mkListenerAllowedRoutesKind =
    res:
    {
    }
    // optionalAttrs (res."group" != null) { inherit (res) "group"; }
    // {
      inherit (res) "kind";
    };
  ListenerAllowedRoutesModule = types.submodule {
    options = {
      "kinds" = mkOption {
        description = "Kinds specifies the groups and kinds of Routes that are allowed to bind\nto this Gateway Listener. When unspecified or empty, the kinds of Routes\nselected are determined using the Listener protocol.\n\nA RouteGroupKind MUST correspond to kinds of Routes that are compatible\nwith the application protocol specified in the Listener's Protocol field.\nIf an implementation does not support or recognize this resource type, it\nMUST set the \"ResolvedRefs\" condition to False for this Listener with the\n\"InvalidRouteKinds\" reason.\n\nSupport: Core";
        type = (types.listOf ListenerAllowedRoutesKindModule);
        default = [ ];
      };
      "namespaces" = mkOption {
        description = "Namespaces indicates namespaces from which Routes may be attached to this\nListener. This is restricted to the namespace of this Gateway by default.\n\nSupport: Core";
        type = (types.nullOr ListenerAllowedRoutesNamespacesModule);
        default = {
          "from" = "Same";
        };
      };
    };
  };
  mkListenerAllowedRoutes =
    res:
    {
    }
    // optionalAttrs (res."kinds" != [ ]) { "kinds" = map mkListenerAllowedRoutesKind res."kinds"; }
    // {
    }
    // optionalAttrs (res."namespaces" != null) {
      "namespaces" = mkListenerAllowedRoutesNamespaces res."namespaces";
    }
    // {
    };
  ListenerAllowedRoutesNamespacesModule = types.submodule {
    options = {
      "from" = mkOption {
        description = "From indicates where Routes will be selected for this Gateway. Possible\nvalues are:\n\n* All: Routes in all namespaces may be used by this Gateway.\n* Selector: Routes in namespaces selected by the selector may be used by\n  this Gateway.\n* Same: Only Routes in the same namespace may be used by this Gateway.\n\nSupport: Core";
        type = (
          types.nullOr (
            types.enum [
              "All"
              "Selector"
              "Same"
            ]
          )
        );
        default = "Same";
      };
      "selector" = mkOption {
        description = "Selector must be specified when From is set to \"Selector\". In that case,\nonly Routes in Namespaces matching this Selector will be selected by this\nGateway. This field is ignored for other values of \"From\".\n\nSupport: Core";
        type = (types.nullOr ListenerAllowedRoutesNamespacesSelectorModule);
        default = null;
      };
    };
  };
  mkListenerAllowedRoutesNamespaces =
    res:
    {
    }
    // optionalAttrs (res."from" != null) { inherit (res) "from"; }
    // {
    }
    // optionalAttrs (res."selector" != null) {
      "selector" = mkListenerAllowedRoutesNamespacesSelector res."selector";
    }
    // {
    };
  ListenerAllowedRoutesNamespacesSelectorMatchExpressionModule = types.submodule {
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
  mkListenerAllowedRoutesNamespacesSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ListenerAllowedRoutesNamespacesSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf ListenerAllowedRoutesNamespacesSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkListenerAllowedRoutesNamespacesSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkListenerAllowedRoutesNamespacesSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ListenerModule = types.submodule {
    options = {
      "allowedRoutes" = mkOption {
        description = "AllowedRoutes defines the types of routes that MAY be attached to a\nListener and the trusted namespaces where those Route resources MAY be\npresent.\n\nAlthough a client request may match multiple route rules, only one rule\nmay ultimately receive the request. Matching precedence MUST be\ndetermined in order of the following criteria:\n\n* The most specific match as defined by the Route type.\n* The oldest Route based on creation timestamp. For example, a Route with\n  a creation timestamp of \"2020-09-08 01:02:03\" is given precedence over\n  a Route with a creation timestamp of \"2020-09-08 01:02:04\".\n* If everything else is equivalent, the Route appearing first in\n  alphabetical order (namespace/name) should be given precedence. For\n  example, foo/bar is given precedence over foo/baz.\n\nAll valid rules within a Route attached to this Listener should be\nimplemented. Invalid Route rules can be ignored (sometimes that will mean\nthe full Route). If a Route rule transitions from valid to invalid,\nsupport for that Route rule should be dropped to ensure consistency. For\nexample, even if a filter specified by a Route rule is invalid, the rest\nof the rules within that Route should still be supported.\n\nSupport: Core";
        type = (types.nullOr ListenerAllowedRoutesModule);
        default = {
          "namespaces" = {
            "from" = "Same";
          };
        };
      };
      "hostname" = mkOption {
        description = "Hostname specifies the virtual hostname to match for protocol types that\ndefine this concept. When unspecified, all hostnames are matched. This\nfield is ignored for protocols that don't require hostname based\nmatching.\n\nImplementations MUST apply Hostname matching appropriately for each of\nthe following protocols:\n\n* TLS: The Listener Hostname MUST match the SNI.\n* HTTP: The Listener Hostname MUST match the Host header of the request.\n* HTTPS: The Listener Hostname SHOULD match both the SNI and Host header.\n  Note that this does not require the SNI and Host header to be the same.\n  The semantics of this are described in more detail below.\n\nTo ensure security, Section 11.1 of RFC-6066 emphasizes that server\nimplementations that rely on SNI hostname matching MUST also verify\nhostnames within the application protocol.\n\nSection 9.1.2 of RFC-7540 provides a mechanism for servers to reject the\nreuse of a connection by responding with the HTTP 421 Misdirected Request\nstatus code. This indicates that the origin server has rejected the\nrequest because it appears to have been misdirected.\n\nTo detect misdirected requests, Gateways SHOULD match the authority of\nthe requests with all the SNI hostname(s) configured across all the\nGateway Listeners on the same port and protocol:\n\n* If another Listener has an exact match or more specific wildcard entry,\n  the Gateway SHOULD return a 421.\n* If the current Listener (selected by SNI matching during ClientHello)\n  does not match the Host:\n    * If another Listener does match the Host the Gateway SHOULD return a\n      421.\n    * If no other Listener matches the Host, the Gateway MUST return a\n      404.\n\nFor HTTPRoute and TLSRoute resources, there is an interaction with the\n`spec.hostnames` array. When both listener and route specify hostnames,\nthere MUST be an intersection between the values for a Route to be\naccepted. For more information, refer to the Route specific Hostnames\ndocumentation.\n\nHostnames that are prefixed with a wildcard label (`*.`) are interpreted\nas a suffix match. That means that a match for `*.example.com` would match\nboth `test.example.com`, and `foo.test.example.com`, but not `example.com`.\n\nSupport: Core";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "Name is the name of the Listener. This name MUST be unique within a\nGateway.\n\nSupport: Core";
        type = types.str;
      };
      "port" = mkOption {
        description = "Port is the network port. Multiple listeners may use the\nsame port, subject to the Listener compatibility rules.\n\nSupport: Core";
        type = types.int;
      };
      "protocol" = mkOption {
        description = "Protocol specifies the network protocol this listener expects to receive.\n\nSupport: Core";
        type = types.str;
      };
      "tls" = mkOption {
        description = "TLS is the TLS configuration for the Listener. This field is required if\nthe Protocol field is \"HTTPS\" or \"TLS\". It is invalid to set this field\nif the Protocol field is \"HTTP\", \"TCP\", or \"UDP\".\n\nThe association of SNIs to Certificate defined in GatewayTLSConfig is\ndefined based on the Hostname field for this listener.\n\nThe GatewayClass MUST use the longest matching SNI out of all\navailable certificates for any TLS handshake.\n\nSupport: Core";
        type = (types.nullOr ListenerTlsModule);
        default = null;
      };
    };
  };
  mkListener =
    res:
    {
    }
    // optionalAttrs (res."allowedRoutes" != null) {
      "allowedRoutes" = mkListenerAllowedRoutes res."allowedRoutes";
    }
    // {
    }
    // optionalAttrs (res."hostname" != null) { inherit (res) "hostname"; }
    // {
      inherit (res) "name";
      inherit (res) "port";
      inherit (res) "protocol";
    }
    // optionalAttrs (res."tls" != null) { "tls" = mkListenerTls res."tls"; }
    // {
    };
  ListenerTlsCertificateRefModule = types.submodule {
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
  mkListenerTlsCertificateRef =
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
  ListenerTlsFrontendValidationCaCertificateRefModule = types.submodule {
    options = {
      "group" = mkOption {
        description = "Group is the group of the referent. For example, \"gateway.networking.k8s.io\".\nWhen set to the empty string, core API group is inferred.";
        type = types.str;
      };
      "kind" = mkOption {
        description = "Kind is kind of the referent. For example \"ConfigMap\" or \"Service\".";
        type = types.str;
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
  mkListenerTlsFrontendValidationCaCertificateRef =
    res:
    {
      inherit (res) "group";
      inherit (res) "kind";
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  ListenerTlsFrontendValidationModule = types.submodule {
    options = {
      "caCertificateRefs" = mkOption {
        description = "CACertificateRefs contains one or more references to\nKubernetes objects that contain TLS certificates of\nthe Certificate Authorities that can be used\nas a trust anchor to validate the certificates presented by the client.\n\nA single CA certificate reference to a Kubernetes ConfigMap\nhas \"Core\" support.\nImplementations MAY choose to support attaching multiple CA certificates to\na Listener, but this behavior is implementation-specific.\n\nSupport: Core - A single reference to a Kubernetes ConfigMap\nwith the CA certificate in a key named `ca.crt`.\n\nSupport: Implementation-specific (More than one reference, or other kinds\nof resources).\n\nReferences to a resource in a different namespace are invalid UNLESS there\nis a ReferenceGrant in the target namespace that allows the certificate\nto be attached. If a ReferenceGrant does not allow this reference, the\n\"ResolvedRefs\" condition MUST be set to False for this listener with the\n\"RefNotPermitted\" reason.";
        type = (types.listOf ListenerTlsFrontendValidationCaCertificateRefModule);
        default = [ ];
      };
    };
  };
  mkListenerTlsFrontendValidation =
    res:
    {
    }
    // optionalAttrs (res."caCertificateRefs" != [ ]) {
      "caCertificateRefs" = map mkListenerTlsFrontendValidationCaCertificateRef res."caCertificateRefs";
    }
    // {
    };
  ListenerTlsModule = types.submodule {
    options = {
      "certificateRefs" = mkOption {
        description = "CertificateRefs contains a series of references to Kubernetes objects that\ncontains TLS certificates and private keys. These certificates are used to\nestablish a TLS handshake for requests that match the hostname of the\nassociated listener.\n\nA single CertificateRef to a Kubernetes Secret has \"Core\" support.\nImplementations MAY choose to support attaching multiple certificates to\na Listener, but this behavior is implementation-specific.\n\nReferences to a resource in different namespace are invalid UNLESS there\nis a ReferenceGrant in the target namespace that allows the certificate\nto be attached. If a ReferenceGrant does not allow this reference, the\n\"ResolvedRefs\" condition MUST be set to False for this listener with the\n\"RefNotPermitted\" reason.\n\nThis field is required to have at least one element when the mode is set\nto \"Terminate\" (default) and is optional otherwise.\n\nCertificateRefs can reference to standard Kubernetes resources, i.e.\nSecret, or implementation-specific custom resources.\n\nSupport: Core - A single reference to a Kubernetes Secret of type kubernetes.io/tls\n\nSupport: Implementation-specific (More than one reference or other resource types)";
        type = (types.listOf ListenerTlsCertificateRefModule);
        default = [ ];
      };
      "frontendValidation" = mkOption {
        description = "FrontendValidation holds configuration information for validating the frontend (client).\nSetting this field will require clients to send a client certificate\nrequired for validation during the TLS handshake. In browsers this may result in a dialog appearing\nthat requests a user to specify the client certificate.\nThe maximum depth of a certificate chain accepted in verification is Implementation specific.\n\nSupport: Extended";
        type = (types.nullOr ListenerTlsFrontendValidationModule);
        default = null;
      };
      "mode" = mkOption {
        description = "Mode defines the TLS behavior for the TLS session initiated by the client.\nThere are two possible modes:\n\n- Terminate: The TLS session between the downstream client and the\n  Gateway is terminated at the Gateway. This mode requires certificates\n  to be specified in some way, such as populating the certificateRefs\n  field.\n- Passthrough: The TLS session is NOT terminated by the Gateway. This\n  implies that the Gateway can't decipher the TLS stream except for\n  the ClientHello message of the TLS protocol. The certificateRefs field\n  is ignored in this mode.\n\nSupport: Core";
        type = (
          types.nullOr (
            types.enum [
              "Terminate"
              "Passthrough"
            ]
          )
        );
        default = "Terminate";
      };
      "options" = mkOption {
        description = "Options are a list of key/value pairs to enable extended TLS\nconfiguration for each implementation. For example, configuring the\nminimum TLS version or supported cipher suites.\n\nA set of common keys MAY be defined by the API in the future. To avoid\nany ambiguity, implementation-specific definitions MUST use\ndomain-prefixed names, such as `example.com/my-custom-option`.\nUn-prefixed names are reserved for key names defined by Gateway API.\n\nSupport: Implementation-specific";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkListenerTls =
    res:
    {
    }
    // optionalAttrs (res."certificateRefs" != [ ]) {
      "certificateRefs" = map mkListenerTlsCertificateRef res."certificateRefs";
    }
    // {
    }
    // optionalAttrs (res."frontendValidation" != null) {
      "frontendValidation" = mkListenerTlsFrontendValidation res."frontendValidation";
    }
    // {
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
    }
    // optionalAttrs (res."options" != { }) { inherit (res) "options"; }
    // {
    };
  GatewaysModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this Gateway resource.";
        };
        "addresses" = mkOption {
          description = "Addresses requested for this Gateway. This is optional and behavior can\ndepend on the implementation. If a value is set in the spec and the\nrequested address is invalid or unavailable, the implementation MUST\nindicate this in the associated entry in GatewayStatus.Addresses.\n\nThe Addresses field represents a request for the address(es) on the\n\"outside of the Gateway\", that traffic bound for this Gateway will use.\nThis could be the IP address or hostname of an external load balancer or\nother networking infrastructure, or some other address that traffic will\nbe sent to.\n\nIf no Addresses are specified, the implementation MAY schedule the\nGateway in an implementation-specific manner, assigning an appropriate\nset of Addresses.\n\nThe implementation MUST bind all Listeners to every GatewayAddress that\nit assigns to the Gateway and add a corresponding entry in\nGatewayStatus.Addresses.\n\nSupport: Extended";
          type = (types.listOf AddresseModule);
          default = [ ];
        };
        "allowedListeners" = mkOption {
          description = "AllowedListeners defines which ListenerSets can be attached to this Gateway.\nWhile this feature is experimental, the default value is to allow no ListenerSets.";
          type = (types.nullOr AllowedListenersModule);
          default = null;
        };
        "backendTLS" = mkOption {
          description = "BackendTLS configures TLS settings for when this Gateway is connecting to\nbackends with TLS.\n\nSupport: Core";
          type = (types.nullOr BackendTLSModule);
          default = null;
        };
        "gatewayClassName" = mkOption {
          description = "GatewayClassName used for this Gateway. This is the name of a\nGatewayClass resource.";
          type = types.str;
        };
        "infrastructure" = mkOption {
          description = "Infrastructure defines infrastructure level attributes about this Gateway instance.\n\nSupport: Extended";
          type = (types.nullOr InfrastructureModule);
          default = null;
        };
        "listeners" = mkOption {
          description = "Listeners associated with this Gateway. Listeners define\nlogical endpoints that are bound on this Gateway's addresses.\nAt least one Listener MUST be specified.\n\n## Distinct Listeners\n\nEach Listener in a set of Listeners (for example, in a single Gateway)\nMUST be _distinct_, in that a traffic flow MUST be able to be assigned to\nexactly one listener. (This section uses \"set of Listeners\" rather than\n\"Listeners in a single Gateway\" because implementations MAY merge configuration\nfrom multiple Gateways onto a single data plane, and these rules _also_\napply in that case).\n\nPractically, this means that each listener in a set MUST have a unique\ncombination of Port, Protocol, and, if supported by the protocol, Hostname.\n\nSome combinations of port, protocol, and TLS settings are considered\nCore support and MUST be supported by implementations based on the objects\nthey support:\n\nHTTPRoute\n\n1. HTTPRoute, Port: 80, Protocol: HTTP\n2. HTTPRoute, Port: 443, Protocol: HTTPS, TLS Mode: Terminate, TLS keypair provided\n\nTLSRoute\n\n1. TLSRoute, Port: 443, Protocol: TLS, TLS Mode: Passthrough\n\n\"Distinct\" Listeners have the following property:\n\n**The implementation can match inbound requests to a single distinct\nListener**.\n\nWhen multiple Listeners share values for fields (for\nexample, two Listeners with the same Port value), the implementation\ncan match requests to only one of the Listeners using other\nListener fields.\n\nWhen multiple listeners have the same value for the Protocol field, then\neach of the Listeners with matching Protocol values MUST have different\nvalues for other fields.\n\nThe set of fields that MUST be different for a Listener differs per protocol.\nThe following rules define the rules for what fields MUST be considered for\nListeners to be distinct with each protocol currently defined in the\nGateway API spec.\n\nThe set of listeners that all share a protocol value MUST have _different_\nvalues for _at least one_ of these fields to be distinct:\n\n* **HTTP, HTTPS, TLS**: Port, Hostname\n* **TCP, UDP**: Port\n\nOne **very** important rule to call out involves what happens when an\nimplementation:\n\n* Supports TCP protocol Listeners, as well as HTTP, HTTPS, or TLS protocol\n  Listeners, and\n* sees HTTP, HTTPS, or TLS protocols with the same `port` as one with TCP\n  Protocol.\n\nIn this case all the Listeners that share a port with the\nTCP Listener are not distinct and so MUST NOT be accepted.\n\nIf an implementation does not support TCP Protocol Listeners, then the\nprevious rule does not apply, and the TCP Listeners SHOULD NOT be\naccepted.\n\nNote that the `tls` field is not used for determining if a listener is distinct, because\nListeners that _only_ differ on TLS config will still conflict in all cases.\n\n### Listeners that are distinct only by Hostname\n\nWhen the Listeners are distinct based only on Hostname, inbound request\nhostnames MUST match from the most specific to least specific Hostname\nvalues to choose the correct Listener and its associated set of Routes.\n\nExact matches MUST be processed before wildcard matches, and wildcard\nmatches MUST be processed before fallback (empty Hostname value)\nmatches. For example, `\"foo.example.com\"` takes precedence over\n`\"*.example.com\"`, and `\"*.example.com\"` takes precedence over `\"\"`.\n\nAdditionally, if there are multiple wildcard entries, more specific\nwildcard entries must be processed before less specific wildcard entries.\nFor example, `\"*.foo.example.com\"` takes precedence over `\"*.example.com\"`.\n\nThe precise definition here is that the higher the number of dots in the\nhostname to the right of the wildcard character, the higher the precedence.\n\nThe wildcard character will match any number of characters _and dots_ to\nthe left, however, so `\"*.example.com\"` will match both\n`\"foo.bar.example.com\"` _and_ `\"bar.example.com\"`.\n\n## Handling indistinct Listeners\n\nIf a set of Listeners contains Listeners that are not distinct, then those\nListeners are _Conflicted_, and the implementation MUST set the \"Conflicted\"\ncondition in the Listener Status to \"True\".\n\nThe words \"indistinct\" and \"conflicted\" are considered equivalent for the\npurpose of this documentation.\n\nImplementations MAY choose to accept a Gateway with some Conflicted\nListeners only if they only accept the partial Listener set that contains\nno Conflicted Listeners.\n\nSpecifically, an implementation MAY accept a partial Listener set subject to\nthe following rules:\n\n* The implementation MUST NOT pick one conflicting Listener as the winner.\n  ALL indistinct Listeners must not be accepted for processing.\n* At least one distinct Listener MUST be present, or else the Gateway effectively\n  contains _no_ Listeners, and must be rejected from processing as a whole.\n\nThe implementation MUST set a \"ListenersNotValid\" condition on the\nGateway Status when the Gateway contains Conflicted Listeners whether or\nnot they accept the Gateway. That Condition SHOULD clearly\nindicate in the Message which Listeners are conflicted, and which are\nAccepted. Additionally, the Listener status for those listeners SHOULD\nindicate which Listeners are conflicted and not Accepted.\n\n## General Listener behavior\n\nNote that, for all distinct Listeners, requests SHOULD match at most one Listener.\nFor example, if Listeners are defined for \"foo.example.com\" and \"*.example.com\", a\nrequest to \"foo.example.com\" SHOULD only be routed using routes attached\nto the \"foo.example.com\" Listener (and not the \"*.example.com\" Listener).\n\nThis concept is known as \"Listener Isolation\", and it is an Extended feature\nof Gateway API. Implementations that do not support Listener Isolation MUST\nclearly document this, and MUST NOT claim support for the\n`GatewayHTTPListenerIsolation` feature.\n\nImplementations that _do_ support Listener Isolation SHOULD claim support\nfor the Extended `GatewayHTTPListenerIsolation` feature and pass the associated\nconformance tests.\n\n## Compatible Listeners\n\nA Gateway's Listeners are considered _compatible_ if:\n\n1. They are distinct.\n2. The implementation can serve them in compliance with the Addresses\n   requirement that all Listeners are available on all assigned\n   addresses.\n\nCompatible combinations in Extended support are expected to vary across\nimplementations. A combination that is compatible for one implementation\nmay not be compatible for another.\n\nFor example, an implementation that cannot serve both TCP and UDP listeners\non the same address, or cannot mix HTTPS and generic TLS listens on the same port\nwould not consider those cases compatible, even though they are distinct.\n\nImplementations MAY merge separate Gateways onto a single set of\nAddresses if all Listeners across all Gateways are compatible.\n\nIn a future release the MinItems=1 requirement MAY be dropped.\n\nSupport: Core";
          type = (types.listOf ListenerModule);
        };
      };
    }
  );
  mkGateway = name: res: {
    apiVersion = "gateway.networking.k8s.io/v1";
    kind = "Gateway";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."addresses" != [ ]) { "addresses" = map mkAddresse res."addresses"; }
    // {
    }
    // optionalAttrs (res."allowedListeners" != null) {
      "allowedListeners" = mkAllowedListeners res."allowedListeners";
    }
    // {
    }
    // optionalAttrs (res."backendTLS" != null) { "backendTLS" = mkBackendTLS res."backendTLS"; }
    // {
      inherit (res) "gatewayClassName";
    }
    // optionalAttrs (res."infrastructure" != null) {
      "infrastructure" = mkInfrastructure res."infrastructure";
    }
    // {
      "listeners" = map mkListener res."listeners";
    };
  };
  allResources = (mapAttrsToList mkGateway cfg."gateways");
in
{
  options.openkrill.apps."envoy-gateway" = {
    "gateways" = mkOption {
      type = types.attrsOf GatewaysModule;
      default = { };
      description = "Gateway CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."envoy-gateway".content = allResources;
  };
}
