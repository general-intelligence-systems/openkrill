# Auto-generated openkrill module fragment for envoy-gateway
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."envoy-gateway";
  compact = filterAttrs (_: v: v != null);
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
        description = "AllowedRoutes defines the types of routes that MAY be attached to a\nListener and the trusted namespaces where those Route resources MAY be\npresent.\n\nAlthough a client request may match multiple route rules, only one rule\nmay ultimately receive the request. Matching precedence MUST be\ndetermined in order of the following criteria:\n\n* The most specific match as defined by the Route type.\n* The oldest Route based on creation timestamp. For example, a Route with\n  a creation timestamp of \"2020-09-08 01:02:03\" is given precedence over\n  a Route with a creation timestamp of \"2020-09-08 01:02:04\".\n* If everything else is equivalent, the Route appearing first in\n  alphabetical order (namespace/name) should be given precedence. For\n  example, foo/bar is given precedence over foo/baz.\n\nAll valid rules within a Route attached to this Listener should be\nimplemented. Invalid Route rules can be ignored (sometimes that will mean\nthe full Route). If a Route rule transitions from valid to invalid,\nsupport for that Route rule should be dropped to ensure consistency. For\nexample, even if a filter specified by a Route rule is invalid, the rest\nof the rules within that Route should still be supported.";
        type = (types.nullOr ListenerAllowedRoutesModule);
        default = {
          "namespaces" = {
            "from" = "Same";
          };
        };
      };
      "hostname" = mkOption {
        description = "Hostname specifies the virtual hostname to match for protocol types that\ndefine this concept. When unspecified, all hostnames are matched. This\nfield is ignored for protocols that don't require hostname based\nmatching.\n\nImplementations MUST apply Hostname matching appropriately for each of\nthe following protocols:\n\n* TLS: The Listener Hostname MUST match the SNI.\n* HTTP: The Listener Hostname MUST match the Host header of the request.\n* HTTPS: The Listener Hostname SHOULD match at both the TLS and HTTP\n  protocol layers as described above. If an implementation does not\n  ensure that both the SNI and Host header match the Listener hostname,\n  it MUST clearly document that.\n\nFor HTTPRoute and TLSRoute resources, there is an interaction with the\n`spec.hostnames` array. When both listener and route specify hostnames,\nthere MUST be an intersection between the values for a Route to be\naccepted. For more information, refer to the Route specific Hostnames\ndocumentation.\n\nHostnames that are prefixed with a wildcard label (`*.`) are interpreted\nas a suffix match. That means that a match for `*.example.com` would match\nboth `test.example.com`, and `foo.test.example.com`, but not `example.com`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "Name is the name of the Listener. This name MUST be unique within a\nListenerSet.\n\nName is not required to be unique across a Gateway and ListenerSets.\nRoutes can attach to a Listener by having a ListenerSet as a parentRef\nand setting the SectionName";
        type = types.str;
      };
      "port" = mkOption {
        description = "Port is the network port. Multiple listeners may use the\nsame port, subject to the Listener compatibility rules.";
        type = types.int;
      };
      "protocol" = mkOption {
        description = "Protocol specifies the network protocol this listener expects to receive.";
        type = types.str;
      };
      "tls" = mkOption {
        description = "TLS is the TLS configuration for the Listener. This field is required if\nthe Protocol field is \"HTTPS\" or \"TLS\". It is invalid to set this field\nif the Protocol field is \"HTTP\", \"TCP\", or \"UDP\".\n\nThe association of SNIs to Certificate defined in GatewayTLSConfig is\ndefined based on the Hostname field for this listener.\n\nThe GatewayClass MUST use the longest matching SNI out of all\navailable certificates for any TLS handshake.";
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
  ParentRefModule = types.submodule {
    options = {
      "group" = mkOption {
        description = "Group is the group of the referent.";
        type = (types.nullOr types.str);
        default = "gateway.networking.k8s.io";
      };
      "kind" = mkOption {
        description = "Kind is kind of the referent. For example \"Gateway\".";
        type = (types.nullOr types.str);
        default = "Gateway";
      };
      "name" = mkOption {
        description = "Name is the name of the referent.";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "Namespace is the namespace of the referent.  If not present,\nthe namespace of the referent is assumed to be the same as\nthe namespace of the referring object.";
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
    };
  XlistenersetsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this XListenerSet resource.";
        };
        "listeners" = mkOption {
          description = "Listeners associated with this ListenerSet. Listeners define\nlogical endpoints that are bound on this referenced parent Gateway's addresses.\n\nListeners in a `Gateway` and their attached `ListenerSets` are concatenated\nas a list when programming the underlying infrastructure. Each listener\nname does not need to be unique across the Gateway and ListenerSets.\nSee ListenerEntry.Name for more details.\n\nImplementations MUST treat the parent Gateway as having the merged\nlist of all listeners from itself and attached ListenerSets using\nthe following precedence:\n\n1. \"parent\" Gateway\n2. ListenerSet ordered by creation time (oldest first)\n3. ListenerSet ordered alphabetically by “{namespace}/{name}”.\n\nAn implementation MAY reject listeners by setting the ListenerEntryStatus\n`Accepted`` condition to False with the Reason `TooManyListeners`\n\nIf a listener has a conflict, this will be reported in the\nStatus.ListenerEntryStatus setting the `Conflicted` condition to True.\n\nImplementations SHOULD be cautious about what information from the\nparent or siblings are reported to avoid accidentally leaking\nsensitive information that the child would not otherwise have access\nto. This can include contents of secrets etc.";
          type = (types.listOf ListenerModule);
        };
        "parentRef" = mkOption {
          description = "ParentRef references the Gateway that the listeners are attached to.";
          type = ParentRefModule;
        };
      };
    }
  );
  mkXListenerSet = name: res: {
    apiVersion = "gateway.networking.x-k8s.io/v1alpha1";
    kind = "XListenerSet";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
      "listeners" = map mkListener res."listeners";
      "parentRef" = mkParentRef res."parentRef";
    };
  };
  allResources = (mapAttrsToList mkXListenerSet cfg."xlistenersets");
in
{
  options.openkrill.apps."envoy-gateway" = {
    "xlistenersets" = mkOption {
      type = types.attrsOf XlistenersetsModule;
      default = { };
      description = "XListenerSet CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."envoy-gateway".content = allResources;
  };
}
