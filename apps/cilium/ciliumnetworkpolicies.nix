# Auto-generated openkrill module fragment for cilium
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."cilium";
  compact = filterAttrs (_: v: v != null);
  EgresAuthenticationModule = types.submodule {
    options = {
      "mode" = mkOption {
        description = "Mode is the required authentication mode for the allowed traffic, if any.";
        type = (
          types.enum [
            "disabled"
            "required"
            "test-always-fail"
          ]
        );
      };
    };
  };
  mkEgresAuthentication = res: {
    inherit (res) "mode";
  };
  EgresIcmpFieldModule = types.submodule {
    options = {
      "family" = mkOption {
        description = "Family is a IP address version.\nCurrently, we support `IPv4` and `IPv6`.\n`IPv4` is set as default.";
        type = (
          types.nullOr (
            types.enum [
              "IPv4"
              "IPv6"
            ]
          )
        );
        default = "IPv4";
      };
      "type" = mkOption {
        description = "Type is a ICMP-type.\nIt should be an 8bit code (0-255), or it's CamelCase name (for example, \"EchoReply\").\nAllowed ICMP types are:\n    Ipv4: EchoReply | DestinationUnreachable | Redirect | Echo | EchoRequest |\n\t\t     RouterAdvertisement | RouterSelection | TimeExceeded | ParameterProblem |\n\t\t\t Timestamp | TimestampReply | Photuris | ExtendedEcho Request | ExtendedEcho Reply\n    Ipv6: DestinationUnreachable | PacketTooBig | TimeExceeded | ParameterProblem |\n\t\t\t EchoRequest | EchoReply | MulticastListenerQuery| MulticastListenerReport |\n\t\t\t MulticastListenerDone | RouterSolicitation | RouterAdvertisement | NeighborSolicitation |\n\t\t\t NeighborAdvertisement | RedirectMessage | RouterRenumbering | ICMPNodeInformationQuery |\n\t\t\t ICMPNodeInformationResponse | InverseNeighborDiscoverySolicitation | InverseNeighborDiscoveryAdvertisement |\n\t\t\t HomeAgentAddressDiscoveryRequest | HomeAgentAddressDiscoveryReply | MobilePrefixSolicitation |\n\t\t\t MobilePrefixAdvertisement | DuplicateAddressRequestCodeSuffix | DuplicateAddressConfirmationCodeSuffix |\n\t\t\t ExtendedEchoRequest | ExtendedEchoReply";
        type = types.anything;
      };
    };
  };
  mkEgresIcmpField =
    res:
    {
    }
    // optionalAttrs (res."family" != null) { inherit (res) "family"; }
    // {
      inherit (res) "type";
    };
  EgresIcmpModule = types.submodule {
    options = {
      "fields" = mkOption {
        description = "Fields is a list of ICMP fields.";
        type = (types.listOf EgresIcmpFieldModule);
        default = [ ];
      };
    };
  };
  mkEgresIcmp =
    res:
    {
    }
    // optionalAttrs (res."fields" != [ ]) { "fields" = map mkEgresIcmpField res."fields"; }
    // {
    };
  EgresModule = types.submodule {
    options = {
      "authentication" = mkOption {
        description = "Authentication is the required authentication type for the allowed traffic, if any.";
        type = (types.nullOr EgresAuthenticationModule);
        default = null;
      };
      "icmps" = mkOption {
        description = "ICMPs is a list of ICMP rule identified by type number\nwhich the endpoint subject to the rule is allowed to connect to.\n\nExample:\nAny endpoint with the label \"app=httpd\" is allowed to initiate\ntype 8 ICMP connections.";
        type = (types.listOf EgresIcmpModule);
        default = [ ];
      };
      "toCIDR" = mkOption {
        description = "ToCIDR is a list of IP blocks which the endpoint subject to the rule\nis allowed to initiate connections. Only connections destined for\noutside of the cluster and not targeting the host will be subject\nto CIDR rules.  This will match on the destination IP address of\noutgoing connections. Adding a prefix into ToCIDR or into ToCIDRSet\nwith no ExcludeCIDRs is equivalent. Overlaps are allowed between\nToCIDR and ToCIDRSet.\n\nExample:\nAny endpoint with the label \"app=database-proxy\" is allowed to\ninitiate connections to 10.2.3.0/24";
        type = (types.listOf types.str);
        default = [ ];
      };
      "toCIDRSet" = mkOption {
        description = "ToCIDRSet is a list of IP blocks which the endpoint subject to the rule\nis allowed to initiate connections to in addition to connections\nwhich are allowed via ToEndpoints, along with a list of subnets contained\nwithin their corresponding IP block to which traffic should not be\nallowed. This will match on the destination IP address of outgoing\nconnections. Adding a prefix into ToCIDR or into ToCIDRSet with no\nExcludeCIDRs is equivalent. Overlaps are allowed between ToCIDR and\nToCIDRSet.\n\nExample:\nAny endpoint with the label \"app=database-proxy\" is allowed to\ninitiate connections to 10.2.3.0/24 except from IPs in subnet 10.2.3.0/28.";
        type = (types.listOf EgresToCIDRSetModule);
        default = [ ];
      };
      "toEndpoints" = mkOption {
        description = "ToEndpoints is a list of endpoints identified by an EndpointSelector to\nwhich the endpoints subject to the rule are allowed to communicate.\n\nExample:\nAny endpoint with the label \"role=frontend\" can communicate with any\nendpoint carrying the label \"role=backend\".\n\nNote that while an empty non-nil ToEndpoints does not select anything,\nnil ToEndpoints is implicitly treated as a wildcard selector if ToPorts\nare also specified.\nTo select everything, use one EndpointSelector without any match requirements.";
        type = (types.listOf EgresToEndpointModule);
        default = [ ];
      };
      "toEntities" = mkOption {
        description = "ToEntities is a list of special entities to which the endpoint subject\nto the rule is allowed to initiate connections. Supported entities are\n`world`, `cluster`, `host`, `remote-node`, `kube-apiserver`, `ingress`, `init`,\n`health`, `unmanaged`, `none` and `all`.";
        type = (
          types.listOf (
            types.enum [
              "all"
              "world"
              "cluster"
              "host"
              "init"
              "ingress"
              "unmanaged"
              "remote-node"
              "health"
              "none"
              "kube-apiserver"
            ]
          )
        );
        default = [ ];
      };
      "toFQDNs" = mkOption {
        description = "ToFQDN allows whitelisting DNS names in place of IPs. The IPs that result\nfrom DNS resolution of `ToFQDN.MatchName`s are added to the same\nEgressRule object as ToCIDRSet entries, and behave accordingly. Any L4 and\nL7 rules within this EgressRule will also apply to these IPs.\nThe DNS -> IP mapping is re-resolved periodically from within the\ncilium-agent, and the IPs in the DNS response are effected in the policy\nfor selected pods as-is (i.e. the list of IPs is not modified in any way).\nNote: An explicit rule to allow for DNS traffic is needed for the pods, as\nToFQDN counts as an egress rule and will enforce egress policy when\nPolicyEnforcment=default.\nNote: If the resolved IPs are IPs within the kubernetes cluster, the\nToFQDN rule will not apply to that IP.\nNote: ToFQDN cannot occur in the same policy as other To* rules.";
        type = (types.listOf EgresToFQDNModule);
        default = [ ];
      };
      "toGroups" = mkOption {
        description = "ToGroups is a directive that allows the integration with multiple outside\nproviders. Currently, only AWS is supported, and the rule can select by\nmultiple sub directives:\n\nExample:\ntoGroups:\n- aws:\n    securityGroupsIds:\n    - 'sg-XXXXXXXXXXXXX'";
        type = (types.listOf EgresToGroupModule);
        default = [ ];
      };
      "toNodes" = mkOption {
        description = "ToNodes is a list of nodes identified by an\nEndpointSelector to which endpoints subject to the rule is allowed to communicate.";
        type = (types.listOf EgresToNodeModule);
        default = [ ];
      };
      "toPorts" = mkOption {
        description = "ToPorts is a list of destination ports identified by port number and\nprotocol which the endpoint subject to the rule is allowed to\nconnect to.\n\nExample:\nAny endpoint with the label \"role=frontend\" is allowed to initiate\nconnections to destination port 8080/tcp";
        type = (types.listOf EgresToPortModule);
        default = [ ];
      };
      "toRequires" = mkOption {
        description = "Deprecated.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "toServices" = mkOption {
        description = "ToServices is a list of services to which the endpoint subject\nto the rule is allowed to initiate connections.\nCurrently Cilium only supports toServices for K8s services.";
        type = (types.listOf EgresToServiceModule);
        default = [ ];
      };
    };
  };
  mkEgres =
    res:
    {
    }
    // optionalAttrs (res."authentication" != null) {
      "authentication" = mkEgresAuthentication res."authentication";
    }
    // {
    }
    // optionalAttrs (res."icmps" != [ ]) { "icmps" = map mkEgresIcmp res."icmps"; }
    // {
    }
    // optionalAttrs (res."toCIDR" != [ ]) { inherit (res) "toCIDR"; }
    // {
    }
    // optionalAttrs (res."toCIDRSet" != [ ]) { "toCIDRSet" = map mkEgresToCIDRSet res."toCIDRSet"; }
    // {
    }
    // optionalAttrs (res."toEndpoints" != [ ]) {
      "toEndpoints" = map mkEgresToEndpoint res."toEndpoints";
    }
    // {
    }
    // optionalAttrs (res."toEntities" != [ ]) { inherit (res) "toEntities"; }
    // {
    }
    // optionalAttrs (res."toFQDNs" != [ ]) { "toFQDNs" = map mkEgresToFQDN res."toFQDNs"; }
    // {
    }
    // optionalAttrs (res."toGroups" != [ ]) { "toGroups" = map mkEgresToGroup res."toGroups"; }
    // {
    }
    // optionalAttrs (res."toNodes" != [ ]) { "toNodes" = map mkEgresToNode res."toNodes"; }
    // {
    }
    // optionalAttrs (res."toPorts" != [ ]) { "toPorts" = map mkEgresToPort res."toPorts"; }
    // {
    }
    // optionalAttrs (res."toRequires" != [ ]) { inherit (res) "toRequires"; }
    // {
    }
    // optionalAttrs (res."toServices" != [ ]) { "toServices" = map mkEgresToService res."toServices"; }
    // {
    };
  EgresToCIDRSetCidrGroupSelectorMatchExpressionModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the label key that the selector applies to.";
        type = types.str;
      };
      "operator" = mkOption {
        description = "operator represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists and DoesNotExist.";
        type = (
          types.enum [
            "In"
            "NotIn"
            "Exists"
            "DoesNotExist"
          ]
        );
      };
      "values" = mkOption {
        description = "values is an array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. This array is replaced during a strategic\nmerge patch.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkEgresToCIDRSetCidrGroupSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  EgresToCIDRSetCidrGroupSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf EgresToCIDRSetCidrGroupSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkEgresToCIDRSetCidrGroupSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkEgresToCIDRSetCidrGroupSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  EgresToCIDRSetModule = types.submodule {
    options = {
      "cidr" = mkOption {
        description = "CIDR is a CIDR prefix / IP Block.";
        type = (types.nullOr types.str);
        default = null;
      };
      "cidrGroupRef" = mkOption {
        description = "CIDRGroupRef is a reference to a CiliumCIDRGroup object.\nA CiliumCIDRGroup contains a list of CIDRs that the endpoint, subject to\nthe rule, can (Ingress/Egress) or cannot (IngressDeny/EgressDeny) receive\nconnections from.";
        type = (types.nullOr types.str);
        default = null;
      };
      "cidrGroupSelector" = mkOption {
        description = "CIDRGroupSelector selects CiliumCIDRGroups by their labels,\nrather than by name.";
        type = (types.nullOr EgresToCIDRSetCidrGroupSelectorModule);
        default = null;
      };
      "except" = mkOption {
        description = "ExceptCIDRs is a list of IP blocks which the endpoint subject to the rule\nis not allowed to initiate connections to. These CIDR prefixes should be\ncontained within Cidr, using ExceptCIDRs together with CIDRGroupRef is not\nsupported yet.\nThese exceptions are only applied to the Cidr in this CIDRRule, and do not\napply to any other CIDR prefixes in any other CIDRRules.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkEgresToCIDRSet =
    res:
    {
    }
    // optionalAttrs (res."cidr" != null) { inherit (res) "cidr"; }
    // {
    }
    // optionalAttrs (res."cidrGroupRef" != null) { inherit (res) "cidrGroupRef"; }
    // {
    }
    // optionalAttrs (res."cidrGroupSelector" != null) {
      "cidrGroupSelector" = mkEgresToCIDRSetCidrGroupSelector res."cidrGroupSelector";
    }
    // {
    }
    // optionalAttrs (res."except" != [ ]) { inherit (res) "except"; }
    // {
    };
  EgresToEndpointMatchExpressionModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the label key that the selector applies to.";
        type = types.str;
      };
      "operator" = mkOption {
        description = "operator represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists and DoesNotExist.";
        type = (
          types.enum [
            "In"
            "NotIn"
            "Exists"
            "DoesNotExist"
          ]
        );
      };
      "values" = mkOption {
        description = "values is an array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. This array is replaced during a strategic\nmerge patch.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkEgresToEndpointMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  EgresToEndpointModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf EgresToEndpointMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkEgresToEndpoint =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkEgresToEndpointMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  EgresToFQDNModule = types.submodule {
    options = {
      "matchName" = mkOption {
        description = "MatchName matches literal DNS names. A trailing \".\" is automatically added\nwhen missing.";
        type = (types.nullOr types.str);
        default = null;
      };
      "matchPattern" = mkOption {
        description = "MatchPattern allows using wildcards to match DNS names. All wildcards are\ncase insensitive. The wildcards are:\n- \"*\" matches 0 or more DNS valid characters, and may occur anywhere in\nthe pattern. As a special case a \"*\" as the leftmost character, without a\nfollowing \".\" matches all subdomains as well as the name to the right.\nA trailing \".\" is automatically added when missing.\n- \"**.\" is a special prefix which matches all multilevel subdomains in the prefix.\n\nExamples:\n1. `*.cilium.io` matches subdomains of cilium at that level\n  www.cilium.io and blog.cilium.io match, cilium.io and google.com do not\n2. `*cilium.io` matches cilium.io and all subdomains ends with \"cilium.io\"\n  except those containing \".\" separator, subcilium.io and sub-cilium.io match,\n  www.cilium.io and blog.cilium.io does not\n3. `sub*.cilium.io` matches subdomains of cilium where the subdomain component\n  begins with \"sub\". sub.cilium.io and subdomain.cilium.io match while www.cilium.io,\n  blog.cilium.io, cilium.io and google.com do not\n4. `**.cilium.io` matches all multilevel subdomains of cilium.io.\n  \"app.cilium.io\" and \"test.app.cilium.io\" match but not \"cilium.io\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkEgresToFQDN =
    res:
    {
    }
    // optionalAttrs (res."matchName" != null) { inherit (res) "matchName"; }
    // {
    }
    // optionalAttrs (res."matchPattern" != null) { inherit (res) "matchPattern"; }
    // {
    };
  EgresToGroupAwsModule = types.submodule {
    options = {
      "labels" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "region" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "securityGroupsIds" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "securityGroupsNames" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkEgresToGroupAws =
    res:
    {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."region" != null) { inherit (res) "region"; }
    // {
    }
    // optionalAttrs (res."securityGroupsIds" != [ ]) { inherit (res) "securityGroupsIds"; }
    // {
    }
    // optionalAttrs (res."securityGroupsNames" != [ ]) { inherit (res) "securityGroupsNames"; }
    // {
    };
  EgresToGroupModule = types.submodule {
    options = {
      "aws" = mkOption {
        description = "AWSGroup is an structure that can be used to whitelisting information from AWS integration";
        type = (types.nullOr EgresToGroupAwsModule);
        default = null;
      };
    };
  };
  mkEgresToGroup =
    res:
    {
    }
    // optionalAttrs (res."aws" != null) { "aws" = mkEgresToGroupAws res."aws"; }
    // {
    };
  EgresToNodeMatchExpressionModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the label key that the selector applies to.";
        type = types.str;
      };
      "operator" = mkOption {
        description = "operator represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists and DoesNotExist.";
        type = (
          types.enum [
            "In"
            "NotIn"
            "Exists"
            "DoesNotExist"
          ]
        );
      };
      "values" = mkOption {
        description = "values is an array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. This array is replaced during a strategic\nmerge patch.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkEgresToNodeMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  EgresToNodeModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf EgresToNodeMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkEgresToNode =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkEgresToNodeMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  EgresToPortListenerEnvoyConfigModule = types.submodule {
    options = {
      "kind" = mkOption {
        description = "Kind is the resource type being referred to. Defaults to CiliumEnvoyConfig or\nCiliumClusterwideEnvoyConfig for CiliumNetworkPolicy and CiliumClusterwideNetworkPolicy,\nrespectively. The only case this is currently explicitly needed is when referring to a\nCiliumClusterwideEnvoyConfig from CiliumNetworkPolicy, as using a namespaced listener\nfrom a cluster scoped policy is not allowed.";
        type = (
          types.nullOr (
            types.enum [
              "CiliumEnvoyConfig"
              "CiliumClusterwideEnvoyConfig"
            ]
          )
        );
        default = null;
      };
      "name" = mkOption {
        description = "Name is the resource name of the CiliumEnvoyConfig or CiliumClusterwideEnvoyConfig where\nthe listener is defined in.";
        type = types.str;
      };
    };
  };
  mkEgresToPortListenerEnvoyConfig =
    res:
    {
    }
    // optionalAttrs (res."kind" != null) { inherit (res) "kind"; }
    // {
      inherit (res) "name";
    };
  EgresToPortListenerModule = types.submodule {
    options = {
      "envoyConfig" = mkOption {
        description = "EnvoyConfig is a reference to the CEC or CCEC resource in which\nthe listener is defined.";
        type = EgresToPortListenerEnvoyConfigModule;
      };
      "name" = mkOption {
        description = "Name is the name of the listener.";
        type = types.str;
      };
      "priority" = mkOption {
        description = "Priority for this Listener that is used when multiple rules would apply different\nlisteners to a policy map entry. Behavior of this is implementation dependent.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkEgresToPortListener =
    res:
    {
      "envoyConfig" = mkEgresToPortListenerEnvoyConfig res."envoyConfig";
      inherit (res) "name";
    }
    // optionalAttrs (res."priority" != null) { inherit (res) "priority"; }
    // {
    };
  EgresToPortModule = types.submodule {
    options = {
      "listener" = mkOption {
        description = "listener specifies the name of a custom Envoy listener to which this traffic should be\nredirected to.";
        type = (types.nullOr EgresToPortListenerModule);
        default = null;
      };
      "originatingTLS" = mkOption {
        description = "OriginatingTLS is the TLS context for the connections originated by\nthe L7 proxy.  For egress policy this specifies the client-side TLS\nparameters for the upstream connection originating from the L7 proxy\nto the remote destination. For ingress policy this specifies the\nclient-side TLS parameters for the connection from the L7 proxy to\nthe local endpoint.";
        type = (types.nullOr EgresToPortOriginatingTLSModule);
        default = null;
      };
      "ports" = mkOption {
        description = "Ports is a list of L4 port/protocol";
        type = (types.listOf EgresToPortPortModule);
        default = [ ];
      };
      "rules" = mkOption {
        description = "Rules is a list of additional port level rules which must be met in\norder for the PortRule to allow the traffic. If omitted or empty,\nno layer 7 rules are enforced.";
        type = (types.nullOr EgresToPortRulesModule);
        default = null;
      };
      "serverNames" = mkOption {
        description = "ServerNames is a list of allowed TLS SNI values. If not empty, then\nTLS must be present and one of the provided SNIs must be indicated in the\nTLS handshake.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "terminatingTLS" = mkOption {
        description = "TerminatingTLS is the TLS context for the connection terminated by\nthe L7 proxy.  For egress policy this specifies the server-side TLS\nparameters to be applied on the connections originated from the local\nendpoint and terminated by the L7 proxy. For ingress policy this specifies\nthe server-side TLS parameters to be applied on the connections\noriginated from a remote source and terminated by the L7 proxy.";
        type = (types.nullOr EgresToPortTerminatingTLSModule);
        default = null;
      };
    };
  };
  mkEgresToPort =
    res:
    {
    }
    // optionalAttrs (res."listener" != null) { "listener" = mkEgresToPortListener res."listener"; }
    // {
    }
    // optionalAttrs (res."originatingTLS" != null) {
      "originatingTLS" = mkEgresToPortOriginatingTLS res."originatingTLS";
    }
    // {
    }
    // optionalAttrs (res."ports" != [ ]) { "ports" = map mkEgresToPortPort res."ports"; }
    // {
    }
    // optionalAttrs (res."rules" != null) { "rules" = mkEgresToPortRules res."rules"; }
    // {
    }
    // optionalAttrs (res."serverNames" != [ ]) { inherit (res) "serverNames"; }
    // {
    }
    // optionalAttrs (res."terminatingTLS" != null) {
      "terminatingTLS" = mkEgresToPortTerminatingTLS res."terminatingTLS";
    }
    // {
    };
  EgresToPortOriginatingTLSModule = types.submodule {
    options = {
      "certificate" = mkOption {
        description = "Certificate is the file name or k8s secret item name for the certificate\nchain. If omitted, 'tls.crt' is assumed, if it exists. If given, the\nitem must exist.";
        type = (types.nullOr types.str);
        default = null;
      };
      "privateKey" = mkOption {
        description = "PrivateKey is the file name or k8s secret item name for the private key\nmatching the certificate chain. If omitted, 'tls.key' is assumed, if it\nexists. If given, the item must exist.";
        type = (types.nullOr types.str);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret is the secret that contains the certificates and private key for\nthe TLS context.\nBy default, Cilium will search in this secret for the following items:\n - 'ca.crt'  - Which represents the trusted CA to verify remote source.\n - 'tls.crt' - Which represents the public key certificate.\n - 'tls.key' - Which represents the private key matching the public key\n               certificate.";
        type = EgresToPortOriginatingTLSSecretModule;
      };
      "trustedCA" = mkOption {
        description = "TrustedCA is the file name or k8s secret item name for the trusted CA.\nIf omitted, 'ca.crt' is assumed, if it exists. If given, the item must\nexist.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkEgresToPortOriginatingTLS =
    res:
    {
    }
    // optionalAttrs (res."certificate" != null) { inherit (res) "certificate"; }
    // {
    }
    // optionalAttrs (res."privateKey" != null) { inherit (res) "privateKey"; }
    // {
      "secret" = mkEgresToPortOriginatingTLSSecret res."secret";
    }
    // optionalAttrs (res."trustedCA" != null) { inherit (res) "trustedCA"; }
    // {
    };
  EgresToPortOriginatingTLSSecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the name of the secret.";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "Namespace is the namespace in which the secret exists. Context of use\ndetermines the default value if left out (e.g., \"default\").";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkEgresToPortOriginatingTLSSecret =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  EgresToPortPortModule = types.submodule {
    options = {
      "endPort" = mkOption {
        description = "EndPort can only be an L4 port number.";
        type = (types.nullOr types.int);
        default = null;
      };
      "port" = mkOption {
        description = "Port can be an L4 port number, or a name in the form of \"http\"\nor \"http-8080\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "protocol" = mkOption {
        description = "Protocol is the L4 protocol. If \"ANY\", omitted or empty, any protocols\nwith transport ports (TCP, UDP, SCTP) match.\n\nAccepted values: \"TCP\", \"UDP\", \"SCTP\", \"VRRP\", \"IGMP\", \"ANY\"\n\nMatching on ICMP is not supported.\n\nNamed port specified for a container may narrow this down, but may not\ncontradict this.";
        type = (
          types.nullOr (
            types.enum [
              "TCP"
              "UDP"
              "SCTP"
              "VRRP"
              "IGMP"
              "ANY"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkEgresToPortPort =
    res:
    {
    }
    // optionalAttrs (res."endPort" != null) { inherit (res) "endPort"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
    }
    // optionalAttrs (res."protocol" != null) { inherit (res) "protocol"; }
    // {
    };
  EgresToPortRulesDnModule = types.submodule {
    options = {
      "matchName" = mkOption {
        description = "MatchName matches literal DNS names. A trailing \".\" is automatically added\nwhen missing.";
        type = (types.nullOr types.str);
        default = null;
      };
      "matchPattern" = mkOption {
        description = "MatchPattern allows using wildcards to match DNS names. All wildcards are\ncase insensitive. The wildcards are:\n- \"*\" matches 0 or more DNS valid characters, and may occur anywhere in\nthe pattern. As a special case a \"*\" as the leftmost character, without a\nfollowing \".\" matches all subdomains as well as the name to the right.\nA trailing \".\" is automatically added when missing.\n- \"**.\" is a special prefix which matches all multilevel subdomains in the prefix.\n\nExamples:\n1. `*.cilium.io` matches subdomains of cilium at that level\n  www.cilium.io and blog.cilium.io match, cilium.io and google.com do not\n2. `*cilium.io` matches cilium.io and all subdomains ends with \"cilium.io\"\n  except those containing \".\" separator, subcilium.io and sub-cilium.io match,\n  www.cilium.io and blog.cilium.io does not\n3. `sub*.cilium.io` matches subdomains of cilium where the subdomain component\n  begins with \"sub\". sub.cilium.io and subdomain.cilium.io match while www.cilium.io,\n  blog.cilium.io, cilium.io and google.com do not\n4. `**.cilium.io` matches all multilevel subdomains of cilium.io.\n  \"app.cilium.io\" and \"test.app.cilium.io\" match but not \"cilium.io\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkEgresToPortRulesDn =
    res:
    {
    }
    // optionalAttrs (res."matchName" != null) { inherit (res) "matchName"; }
    // {
    }
    // optionalAttrs (res."matchPattern" != null) { inherit (res) "matchPattern"; }
    // {
    };
  EgresToPortRulesHttpHeaderMatcheModule = types.submodule {
    options = {
      "mismatch" = mkOption {
        description = "Mismatch identifies what to do in case there is no match. The default is\nto drop the request. Otherwise the overall rule is still considered as\nmatching, but the mismatches are logged in the access log.";
        type = (
          types.nullOr (
            types.enum [
              "LOG"
              "ADD"
              "DELETE"
              "REPLACE"
            ]
          )
        );
        default = null;
      };
      "name" = mkOption {
        description = "Name identifies the header.";
        type = types.str;
      };
      "secret" = mkOption {
        description = "Secret refers to a secret that contains the value to be matched against.\nThe secret must only contain one entry. If the referred secret does not\nexist, and there is no \"Value\" specified, the match will fail.";
        type = (types.nullOr EgresToPortRulesHttpHeaderMatcheSecretModule);
        default = null;
      };
      "value" = mkOption {
        description = "Value matches the exact value of the header. Can be specified either\nalone or together with \"Secret\"; will be used as the header value if the\nsecret can not be found in the latter case.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkEgresToPortRulesHttpHeaderMatche =
    res:
    {
    }
    // optionalAttrs (res."mismatch" != null) { inherit (res) "mismatch"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkEgresToPortRulesHttpHeaderMatcheSecret res."secret";
    }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  EgresToPortRulesHttpHeaderMatcheSecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the name of the secret.";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "Namespace is the namespace in which the secret exists. Context of use\ndetermines the default value if left out (e.g., \"default\").";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkEgresToPortRulesHttpHeaderMatcheSecret =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  EgresToPortRulesHttpModule = types.submodule {
    options = {
      "headerMatches" = mkOption {
        description = "HeaderMatches is a list of HTTP headers which must be\npresent and match against the given values. Mismatch field can be used\nto specify what to do when there is no match.";
        type = (types.listOf EgresToPortRulesHttpHeaderMatcheModule);
        default = [ ];
      };
      "headers" = mkOption {
        description = "Headers is a list of HTTP headers which must be present in the\nrequest. If omitted or empty, requests are allowed regardless of\nheaders present.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "host" = mkOption {
        description = "Host is an extended POSIX regex matched against the host header of a\nrequest. Examples:\n\n- foo.bar.com will match the host fooXbar.com or foo-bar.com\n- foo\\.bar\\.com will only match the host foo.bar.com\n\nIf omitted or empty, the value of the host header is ignored.";
        type = (types.nullOr types.str);
        default = null;
      };
      "method" = mkOption {
        description = "Method is an extended POSIX regex matched against the method of a\nrequest, e.g. \"GET\", \"POST\", \"PUT\", \"PATCH\", \"DELETE\", ...\n\nIf omitted or empty, all methods are allowed.";
        type = (types.nullOr types.str);
        default = null;
      };
      "path" = mkOption {
        description = "Path is an extended POSIX regex matched against the path of a\nrequest. Currently it can contain characters disallowed from the\nconventional \"path\" part of a URL as defined by RFC 3986.\n\nIf omitted or empty, all paths are all allowed.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkEgresToPortRulesHttp =
    res:
    {
    }
    // optionalAttrs (res."headerMatches" != [ ]) {
      "headerMatches" = map mkEgresToPortRulesHttpHeaderMatche res."headerMatches";
    }
    // {
    }
    // optionalAttrs (res."headers" != [ ]) { inherit (res) "headers"; }
    // {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."method" != null) { inherit (res) "method"; }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    };
  EgresToPortRulesKafkaModule = types.submodule {
    options = {
      "apiKey" = mkOption {
        description = "APIKey is a case-insensitive string matched against the key of a\nrequest, e.g. \"produce\", \"fetch\", \"createtopic\", \"deletetopic\", et al\nReference: https://kafka.apache.org/protocol#protocol_api_keys\n\nIf omitted or empty, and if Role is not specified, then all keys are allowed.";
        type = (types.nullOr types.str);
        default = null;
      };
      "apiVersion" = mkOption {
        description = "APIVersion is the version matched against the api version of the\nKafka message. If set, it has to be a string representing a positive\ninteger.\n\nIf omitted or empty, all versions are allowed.";
        type = (types.nullOr types.str);
        default = null;
      };
      "clientID" = mkOption {
        description = "ClientID is the client identifier as provided in the request.\n\nFrom Kafka protocol documentation:\nThis is a user supplied identifier for the client application. The\nuser can use any identifier they like and it will be used when\nlogging errors, monitoring aggregates, etc. For example, one might\nwant to monitor not just the requests per second overall, but the\nnumber coming from each client application (each of which could\nreside on multiple servers). This id acts as a logical grouping\nacross all requests from a particular client.\n\nIf omitted or empty, all client identifiers are allowed.";
        type = (types.nullOr types.str);
        default = null;
      };
      "role" = mkOption {
        description = "Role is a case-insensitive string and describes a group of API keys\nnecessary to perform certain higher-level Kafka operations such as \"produce\"\nor \"consume\". A Role automatically expands into all APIKeys required\nto perform the specified higher-level operation.\n\nThe following values are supported:\n - \"produce\": Allow producing to the topics specified in the rule\n - \"consume\": Allow consuming from the topics specified in the rule\n\nThis field is incompatible with the APIKey field, i.e APIKey and Role\ncannot both be specified in the same rule.\n\nIf omitted or empty, and if APIKey is not specified, then all keys are\nallowed.";
        type = (
          types.nullOr (
            types.enum [
              "produce"
              "consume"
            ]
          )
        );
        default = null;
      };
      "topic" = mkOption {
        description = "Topic is the topic name contained in the message. If a Kafka request\ncontains multiple topics, then all topics must be allowed or the\nmessage will be rejected.\n\nThis constraint is ignored if the matched request message type\ndoesn't contain any topic. Maximum size of Topic can be 249\ncharacters as per recent Kafka spec and allowed characters are\na-z, A-Z, 0-9, -, . and _.\n\nOlder Kafka versions had longer topic lengths of 255, but in Kafka 0.10\nversion the length was changed from 255 to 249. For compatibility\nreasons we are using 255.\n\nIf omitted or empty, all topics are allowed.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkEgresToPortRulesKafka =
    res:
    {
    }
    // optionalAttrs (res."apiKey" != null) { inherit (res) "apiKey"; }
    // {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
    }
    // optionalAttrs (res."clientID" != null) { inherit (res) "clientID"; }
    // {
    }
    // optionalAttrs (res."role" != null) { inherit (res) "role"; }
    // {
    }
    // optionalAttrs (res."topic" != null) { inherit (res) "topic"; }
    // {
    };
  EgresToPortRulesModule = types.submodule {
    options = {
      "dns" = mkOption {
        description = "DNS-specific rules.";
        type = (types.listOf EgresToPortRulesDnModule);
        default = [ ];
      };
      "http" = mkOption {
        description = "HTTP specific rules.";
        type = (types.listOf EgresToPortRulesHttpModule);
        default = [ ];
      };
      "kafka" = mkOption {
        description = "Kafka-specific rules.\nDeprecated: This beta feature is deprecated and will be removed in a future release.";
        type = (types.listOf EgresToPortRulesKafkaModule);
        default = [ ];
      };
      "l7" = mkOption {
        description = "Key-value pair rules.";
        type = (types.listOf (types.attrsOf types.str));
        default = [ ];
      };
      "l7proto" = mkOption {
        description = "Name of the L7 protocol for which the Key-value pair rules apply.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkEgresToPortRules =
    res:
    {
    }
    // optionalAttrs (res."dns" != [ ]) { "dns" = map mkEgresToPortRulesDn res."dns"; }
    // {
    }
    // optionalAttrs (res."http" != [ ]) { "http" = map mkEgresToPortRulesHttp res."http"; }
    // {
    }
    // optionalAttrs (res."kafka" != [ ]) { "kafka" = map mkEgresToPortRulesKafka res."kafka"; }
    // {
    }
    // optionalAttrs (res."l7" != [ ]) { inherit (res) "l7"; }
    // {
    }
    // optionalAttrs (res."l7proto" != null) { inherit (res) "l7proto"; }
    // {
    };
  EgresToPortTerminatingTLSModule = types.submodule {
    options = {
      "certificate" = mkOption {
        description = "Certificate is the file name or k8s secret item name for the certificate\nchain. If omitted, 'tls.crt' is assumed, if it exists. If given, the\nitem must exist.";
        type = (types.nullOr types.str);
        default = null;
      };
      "privateKey" = mkOption {
        description = "PrivateKey is the file name or k8s secret item name for the private key\nmatching the certificate chain. If omitted, 'tls.key' is assumed, if it\nexists. If given, the item must exist.";
        type = (types.nullOr types.str);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret is the secret that contains the certificates and private key for\nthe TLS context.\nBy default, Cilium will search in this secret for the following items:\n - 'ca.crt'  - Which represents the trusted CA to verify remote source.\n - 'tls.crt' - Which represents the public key certificate.\n - 'tls.key' - Which represents the private key matching the public key\n               certificate.";
        type = EgresToPortTerminatingTLSSecretModule;
      };
      "trustedCA" = mkOption {
        description = "TrustedCA is the file name or k8s secret item name for the trusted CA.\nIf omitted, 'ca.crt' is assumed, if it exists. If given, the item must\nexist.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkEgresToPortTerminatingTLS =
    res:
    {
    }
    // optionalAttrs (res."certificate" != null) { inherit (res) "certificate"; }
    // {
    }
    // optionalAttrs (res."privateKey" != null) { inherit (res) "privateKey"; }
    // {
      "secret" = mkEgresToPortTerminatingTLSSecret res."secret";
    }
    // optionalAttrs (res."trustedCA" != null) { inherit (res) "trustedCA"; }
    // {
    };
  EgresToPortTerminatingTLSSecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the name of the secret.";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "Namespace is the namespace in which the secret exists. Context of use\ndetermines the default value if left out (e.g., \"default\").";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkEgresToPortTerminatingTLSSecret =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  EgresToServiceK8sServiceModule = types.submodule {
    options = {
      "namespace" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "serviceName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkEgresToServiceK8sService =
    res:
    {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    }
    // optionalAttrs (res."serviceName" != null) { inherit (res) "serviceName"; }
    // {
    };
  EgresToServiceK8sServiceSelectorModule = types.submodule {
    options = {
      "namespace" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "selector" = mkOption {
        description = "ServiceSelector is a label selector for k8s services";
        type = EgresToServiceK8sServiceSelectorSelectorModule;
      };
    };
  };
  mkEgresToServiceK8sServiceSelector =
    res:
    {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
      "selector" = mkEgresToServiceK8sServiceSelectorSelector res."selector";
    };
  EgresToServiceK8sServiceSelectorSelectorMatchExpressionModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the label key that the selector applies to.";
        type = types.str;
      };
      "operator" = mkOption {
        description = "operator represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists and DoesNotExist.";
        type = (
          types.enum [
            "In"
            "NotIn"
            "Exists"
            "DoesNotExist"
          ]
        );
      };
      "values" = mkOption {
        description = "values is an array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. This array is replaced during a strategic\nmerge patch.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkEgresToServiceK8sServiceSelectorSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  EgresToServiceK8sServiceSelectorSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf EgresToServiceK8sServiceSelectorSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkEgresToServiceK8sServiceSelectorSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkEgresToServiceK8sServiceSelectorSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  EgresToServiceModule = types.submodule {
    options = {
      "k8sService" = mkOption {
        description = "K8sService selects service by name and namespace pair";
        type = (types.nullOr EgresToServiceK8sServiceModule);
        default = null;
      };
      "k8sServiceSelector" = mkOption {
        description = "K8sServiceSelector selects services by k8s labels and namespace";
        type = (types.nullOr EgresToServiceK8sServiceSelectorModule);
        default = null;
      };
    };
  };
  mkEgresToService =
    res:
    {
    }
    // optionalAttrs (res."k8sService" != null) {
      "k8sService" = mkEgresToServiceK8sService res."k8sService";
    }
    // {
    }
    // optionalAttrs (res."k8sServiceSelector" != null) {
      "k8sServiceSelector" = mkEgresToServiceK8sServiceSelector res."k8sServiceSelector";
    }
    // {
    };
  EgressDenyIcmpFieldModule = types.submodule {
    options = {
      "family" = mkOption {
        description = "Family is a IP address version.\nCurrently, we support `IPv4` and `IPv6`.\n`IPv4` is set as default.";
        type = (
          types.nullOr (
            types.enum [
              "IPv4"
              "IPv6"
            ]
          )
        );
        default = "IPv4";
      };
      "type" = mkOption {
        description = "Type is a ICMP-type.\nIt should be an 8bit code (0-255), or it's CamelCase name (for example, \"EchoReply\").\nAllowed ICMP types are:\n    Ipv4: EchoReply | DestinationUnreachable | Redirect | Echo | EchoRequest |\n\t\t     RouterAdvertisement | RouterSelection | TimeExceeded | ParameterProblem |\n\t\t\t Timestamp | TimestampReply | Photuris | ExtendedEcho Request | ExtendedEcho Reply\n    Ipv6: DestinationUnreachable | PacketTooBig | TimeExceeded | ParameterProblem |\n\t\t\t EchoRequest | EchoReply | MulticastListenerQuery| MulticastListenerReport |\n\t\t\t MulticastListenerDone | RouterSolicitation | RouterAdvertisement | NeighborSolicitation |\n\t\t\t NeighborAdvertisement | RedirectMessage | RouterRenumbering | ICMPNodeInformationQuery |\n\t\t\t ICMPNodeInformationResponse | InverseNeighborDiscoverySolicitation | InverseNeighborDiscoveryAdvertisement |\n\t\t\t HomeAgentAddressDiscoveryRequest | HomeAgentAddressDiscoveryReply | MobilePrefixSolicitation |\n\t\t\t MobilePrefixAdvertisement | DuplicateAddressRequestCodeSuffix | DuplicateAddressConfirmationCodeSuffix |\n\t\t\t ExtendedEchoRequest | ExtendedEchoReply";
        type = types.anything;
      };
    };
  };
  mkEgressDenyIcmpField =
    res:
    {
    }
    // optionalAttrs (res."family" != null) { inherit (res) "family"; }
    // {
      inherit (res) "type";
    };
  EgressDenyIcmpModule = types.submodule {
    options = {
      "fields" = mkOption {
        description = "Fields is a list of ICMP fields.";
        type = (types.listOf EgressDenyIcmpFieldModule);
        default = [ ];
      };
    };
  };
  mkEgressDenyIcmp =
    res:
    {
    }
    // optionalAttrs (res."fields" != [ ]) { "fields" = map mkEgressDenyIcmpField res."fields"; }
    // {
    };
  EgressDenyModule = types.submodule {
    options = {
      "icmps" = mkOption {
        description = "ICMPs is a list of ICMP rule identified by type number\nwhich the endpoint subject to the rule is not allowed to connect to.\n\nExample:\nAny endpoint with the label \"app=httpd\" is not allowed to initiate\ntype 8 ICMP connections.";
        type = (types.listOf EgressDenyIcmpModule);
        default = [ ];
      };
      "toCIDR" = mkOption {
        description = "ToCIDR is a list of IP blocks which the endpoint subject to the rule\nis allowed to initiate connections. Only connections destined for\noutside of the cluster and not targeting the host will be subject\nto CIDR rules.  This will match on the destination IP address of\noutgoing connections. Adding a prefix into ToCIDR or into ToCIDRSet\nwith no ExcludeCIDRs is equivalent. Overlaps are allowed between\nToCIDR and ToCIDRSet.\n\nExample:\nAny endpoint with the label \"app=database-proxy\" is allowed to\ninitiate connections to 10.2.3.0/24";
        type = (types.listOf types.str);
        default = [ ];
      };
      "toCIDRSet" = mkOption {
        description = "ToCIDRSet is a list of IP blocks which the endpoint subject to the rule\nis allowed to initiate connections to in addition to connections\nwhich are allowed via ToEndpoints, along with a list of subnets contained\nwithin their corresponding IP block to which traffic should not be\nallowed. This will match on the destination IP address of outgoing\nconnections. Adding a prefix into ToCIDR or into ToCIDRSet with no\nExcludeCIDRs is equivalent. Overlaps are allowed between ToCIDR and\nToCIDRSet.\n\nExample:\nAny endpoint with the label \"app=database-proxy\" is allowed to\ninitiate connections to 10.2.3.0/24 except from IPs in subnet 10.2.3.0/28.";
        type = (types.listOf EgressDenyToCIDRSetModule);
        default = [ ];
      };
      "toEndpoints" = mkOption {
        description = "ToEndpoints is a list of endpoints identified by an EndpointSelector to\nwhich the endpoints subject to the rule are allowed to communicate.\n\nExample:\nAny endpoint with the label \"role=frontend\" can communicate with any\nendpoint carrying the label \"role=backend\".\n\nNote that while an empty non-nil ToEndpoints does not select anything,\nnil ToEndpoints is implicitly treated as a wildcard selector if ToPorts\nare also specified.\nTo select everything, use one EndpointSelector without any match requirements.";
        type = (types.listOf EgressDenyToEndpointModule);
        default = [ ];
      };
      "toEntities" = mkOption {
        description = "ToEntities is a list of special entities to which the endpoint subject\nto the rule is allowed to initiate connections. Supported entities are\n`world`, `cluster`, `host`, `remote-node`, `kube-apiserver`, `ingress`, `init`,\n`health`, `unmanaged`, `none` and `all`.";
        type = (
          types.listOf (
            types.enum [
              "all"
              "world"
              "cluster"
              "host"
              "init"
              "ingress"
              "unmanaged"
              "remote-node"
              "health"
              "none"
              "kube-apiserver"
            ]
          )
        );
        default = [ ];
      };
      "toGroups" = mkOption {
        description = "ToGroups is a directive that allows the integration with multiple outside\nproviders. Currently, only AWS is supported, and the rule can select by\nmultiple sub directives:\n\nExample:\ntoGroups:\n- aws:\n    securityGroupsIds:\n    - 'sg-XXXXXXXXXXXXX'";
        type = (types.listOf EgressDenyToGroupModule);
        default = [ ];
      };
      "toNodes" = mkOption {
        description = "ToNodes is a list of nodes identified by an\nEndpointSelector to which endpoints subject to the rule is allowed to communicate.";
        type = (types.listOf EgressDenyToNodeModule);
        default = [ ];
      };
      "toPorts" = mkOption {
        description = "ToPorts is a list of destination ports identified by port number and\nprotocol which the endpoint subject to the rule is not allowed to connect\nto.\n\nExample:\nAny endpoint with the label \"role=frontend\" is not allowed to initiate\nconnections to destination port 8080/tcp";
        type = (types.listOf EgressDenyToPortModule);
        default = [ ];
      };
      "toRequires" = mkOption {
        description = "Deprecated.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "toServices" = mkOption {
        description = "ToServices is a list of services to which the endpoint subject\nto the rule is allowed to initiate connections.\nCurrently Cilium only supports toServices for K8s services.";
        type = (types.listOf EgressDenyToServiceModule);
        default = [ ];
      };
    };
  };
  mkEgressDeny =
    res:
    {
    }
    // optionalAttrs (res."icmps" != [ ]) { "icmps" = map mkEgressDenyIcmp res."icmps"; }
    // {
    }
    // optionalAttrs (res."toCIDR" != [ ]) { inherit (res) "toCIDR"; }
    // {
    }
    // optionalAttrs (res."toCIDRSet" != [ ]) {
      "toCIDRSet" = map mkEgressDenyToCIDRSet res."toCIDRSet";
    }
    // {
    }
    // optionalAttrs (res."toEndpoints" != [ ]) {
      "toEndpoints" = map mkEgressDenyToEndpoint res."toEndpoints";
    }
    // {
    }
    // optionalAttrs (res."toEntities" != [ ]) { inherit (res) "toEntities"; }
    // {
    }
    // optionalAttrs (res."toGroups" != [ ]) { "toGroups" = map mkEgressDenyToGroup res."toGroups"; }
    // {
    }
    // optionalAttrs (res."toNodes" != [ ]) { "toNodes" = map mkEgressDenyToNode res."toNodes"; }
    // {
    }
    // optionalAttrs (res."toPorts" != [ ]) { "toPorts" = map mkEgressDenyToPort res."toPorts"; }
    // {
    }
    // optionalAttrs (res."toRequires" != [ ]) { inherit (res) "toRequires"; }
    // {
    }
    // optionalAttrs (res."toServices" != [ ]) {
      "toServices" = map mkEgressDenyToService res."toServices";
    }
    // {
    };
  EgressDenyToCIDRSetCidrGroupSelectorMatchExpressionModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the label key that the selector applies to.";
        type = types.str;
      };
      "operator" = mkOption {
        description = "operator represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists and DoesNotExist.";
        type = (
          types.enum [
            "In"
            "NotIn"
            "Exists"
            "DoesNotExist"
          ]
        );
      };
      "values" = mkOption {
        description = "values is an array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. This array is replaced during a strategic\nmerge patch.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkEgressDenyToCIDRSetCidrGroupSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  EgressDenyToCIDRSetCidrGroupSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf EgressDenyToCIDRSetCidrGroupSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkEgressDenyToCIDRSetCidrGroupSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkEgressDenyToCIDRSetCidrGroupSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  EgressDenyToCIDRSetModule = types.submodule {
    options = {
      "cidr" = mkOption {
        description = "CIDR is a CIDR prefix / IP Block.";
        type = (types.nullOr types.str);
        default = null;
      };
      "cidrGroupRef" = mkOption {
        description = "CIDRGroupRef is a reference to a CiliumCIDRGroup object.\nA CiliumCIDRGroup contains a list of CIDRs that the endpoint, subject to\nthe rule, can (Ingress/Egress) or cannot (IngressDeny/EgressDeny) receive\nconnections from.";
        type = (types.nullOr types.str);
        default = null;
      };
      "cidrGroupSelector" = mkOption {
        description = "CIDRGroupSelector selects CiliumCIDRGroups by their labels,\nrather than by name.";
        type = (types.nullOr EgressDenyToCIDRSetCidrGroupSelectorModule);
        default = null;
      };
      "except" = mkOption {
        description = "ExceptCIDRs is a list of IP blocks which the endpoint subject to the rule\nis not allowed to initiate connections to. These CIDR prefixes should be\ncontained within Cidr, using ExceptCIDRs together with CIDRGroupRef is not\nsupported yet.\nThese exceptions are only applied to the Cidr in this CIDRRule, and do not\napply to any other CIDR prefixes in any other CIDRRules.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkEgressDenyToCIDRSet =
    res:
    {
    }
    // optionalAttrs (res."cidr" != null) { inherit (res) "cidr"; }
    // {
    }
    // optionalAttrs (res."cidrGroupRef" != null) { inherit (res) "cidrGroupRef"; }
    // {
    }
    // optionalAttrs (res."cidrGroupSelector" != null) {
      "cidrGroupSelector" = mkEgressDenyToCIDRSetCidrGroupSelector res."cidrGroupSelector";
    }
    // {
    }
    // optionalAttrs (res."except" != [ ]) { inherit (res) "except"; }
    // {
    };
  EgressDenyToEndpointMatchExpressionModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the label key that the selector applies to.";
        type = types.str;
      };
      "operator" = mkOption {
        description = "operator represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists and DoesNotExist.";
        type = (
          types.enum [
            "In"
            "NotIn"
            "Exists"
            "DoesNotExist"
          ]
        );
      };
      "values" = mkOption {
        description = "values is an array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. This array is replaced during a strategic\nmerge patch.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkEgressDenyToEndpointMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  EgressDenyToEndpointModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf EgressDenyToEndpointMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkEgressDenyToEndpoint =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkEgressDenyToEndpointMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  EgressDenyToGroupAwsModule = types.submodule {
    options = {
      "labels" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "region" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "securityGroupsIds" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "securityGroupsNames" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkEgressDenyToGroupAws =
    res:
    {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."region" != null) { inherit (res) "region"; }
    // {
    }
    // optionalAttrs (res."securityGroupsIds" != [ ]) { inherit (res) "securityGroupsIds"; }
    // {
    }
    // optionalAttrs (res."securityGroupsNames" != [ ]) { inherit (res) "securityGroupsNames"; }
    // {
    };
  EgressDenyToGroupModule = types.submodule {
    options = {
      "aws" = mkOption {
        description = "AWSGroup is an structure that can be used to whitelisting information from AWS integration";
        type = (types.nullOr EgressDenyToGroupAwsModule);
        default = null;
      };
    };
  };
  mkEgressDenyToGroup =
    res:
    {
    }
    // optionalAttrs (res."aws" != null) { "aws" = mkEgressDenyToGroupAws res."aws"; }
    // {
    };
  EgressDenyToNodeMatchExpressionModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the label key that the selector applies to.";
        type = types.str;
      };
      "operator" = mkOption {
        description = "operator represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists and DoesNotExist.";
        type = (
          types.enum [
            "In"
            "NotIn"
            "Exists"
            "DoesNotExist"
          ]
        );
      };
      "values" = mkOption {
        description = "values is an array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. This array is replaced during a strategic\nmerge patch.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkEgressDenyToNodeMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  EgressDenyToNodeModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf EgressDenyToNodeMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkEgressDenyToNode =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkEgressDenyToNodeMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  EgressDenyToPortModule = types.submodule {
    options = {
      "ports" = mkOption {
        description = "Ports is a list of L4 port/protocol";
        type = (types.listOf EgressDenyToPortPortModule);
        default = [ ];
      };
    };
  };
  mkEgressDenyToPort =
    res:
    {
    }
    // optionalAttrs (res."ports" != [ ]) { "ports" = map mkEgressDenyToPortPort res."ports"; }
    // {
    };
  EgressDenyToPortPortModule = types.submodule {
    options = {
      "endPort" = mkOption {
        description = "EndPort can only be an L4 port number.";
        type = (types.nullOr types.int);
        default = null;
      };
      "port" = mkOption {
        description = "Port can be an L4 port number, or a name in the form of \"http\"\nor \"http-8080\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "protocol" = mkOption {
        description = "Protocol is the L4 protocol. If \"ANY\", omitted or empty, any protocols\nwith transport ports (TCP, UDP, SCTP) match.\n\nAccepted values: \"TCP\", \"UDP\", \"SCTP\", \"VRRP\", \"IGMP\", \"ANY\"\n\nMatching on ICMP is not supported.\n\nNamed port specified for a container may narrow this down, but may not\ncontradict this.";
        type = (
          types.nullOr (
            types.enum [
              "TCP"
              "UDP"
              "SCTP"
              "VRRP"
              "IGMP"
              "ANY"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkEgressDenyToPortPort =
    res:
    {
    }
    // optionalAttrs (res."endPort" != null) { inherit (res) "endPort"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
    }
    // optionalAttrs (res."protocol" != null) { inherit (res) "protocol"; }
    // {
    };
  EgressDenyToServiceK8sServiceModule = types.submodule {
    options = {
      "namespace" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "serviceName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkEgressDenyToServiceK8sService =
    res:
    {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    }
    // optionalAttrs (res."serviceName" != null) { inherit (res) "serviceName"; }
    // {
    };
  EgressDenyToServiceK8sServiceSelectorModule = types.submodule {
    options = {
      "namespace" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "selector" = mkOption {
        description = "ServiceSelector is a label selector for k8s services";
        type = EgressDenyToServiceK8sServiceSelectorSelectorModule;
      };
    };
  };
  mkEgressDenyToServiceK8sServiceSelector =
    res:
    {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
      "selector" = mkEgressDenyToServiceK8sServiceSelectorSelector res."selector";
    };
  EgressDenyToServiceK8sServiceSelectorSelectorMatchExpressionModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the label key that the selector applies to.";
        type = types.str;
      };
      "operator" = mkOption {
        description = "operator represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists and DoesNotExist.";
        type = (
          types.enum [
            "In"
            "NotIn"
            "Exists"
            "DoesNotExist"
          ]
        );
      };
      "values" = mkOption {
        description = "values is an array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. This array is replaced during a strategic\nmerge patch.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkEgressDenyToServiceK8sServiceSelectorSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  EgressDenyToServiceK8sServiceSelectorSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf EgressDenyToServiceK8sServiceSelectorSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkEgressDenyToServiceK8sServiceSelectorSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkEgressDenyToServiceK8sServiceSelectorSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  EgressDenyToServiceModule = types.submodule {
    options = {
      "k8sService" = mkOption {
        description = "K8sService selects service by name and namespace pair";
        type = (types.nullOr EgressDenyToServiceK8sServiceModule);
        default = null;
      };
      "k8sServiceSelector" = mkOption {
        description = "K8sServiceSelector selects services by k8s labels and namespace";
        type = (types.nullOr EgressDenyToServiceK8sServiceSelectorModule);
        default = null;
      };
    };
  };
  mkEgressDenyToService =
    res:
    {
    }
    // optionalAttrs (res."k8sService" != null) {
      "k8sService" = mkEgressDenyToServiceK8sService res."k8sService";
    }
    // {
    }
    // optionalAttrs (res."k8sServiceSelector" != null) {
      "k8sServiceSelector" = mkEgressDenyToServiceK8sServiceSelector res."k8sServiceSelector";
    }
    // {
    };
  EnableDefaultDenyModule = types.submodule {
    options = {
      "egress" = mkOption {
        description = "Whether or not the endpoint should have a default-deny rule applied\nto egress traffic.";
        type = types.bool;
        default = false;
      };
      "ingress" = mkOption {
        description = "Whether or not the endpoint should have a default-deny rule applied\nto ingress traffic.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkEnableDefaultDeny =
    res:
    {
    }
    // optionalAttrs res."egress" { inherit (res) "egress"; }
    // {
    }
    // optionalAttrs res."ingress" { inherit (res) "ingress"; }
    // {
    };
  EndpointSelectorMatchExpressionModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the label key that the selector applies to.";
        type = types.str;
      };
      "operator" = mkOption {
        description = "operator represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists and DoesNotExist.";
        type = (
          types.enum [
            "In"
            "NotIn"
            "Exists"
            "DoesNotExist"
          ]
        );
      };
      "values" = mkOption {
        description = "values is an array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. This array is replaced during a strategic\nmerge patch.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkEndpointSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  EndpointSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf EndpointSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkEndpointSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkEndpointSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  IngresAuthenticationModule = types.submodule {
    options = {
      "mode" = mkOption {
        description = "Mode is the required authentication mode for the allowed traffic, if any.";
        type = (
          types.enum [
            "disabled"
            "required"
            "test-always-fail"
          ]
        );
      };
    };
  };
  mkIngresAuthentication = res: {
    inherit (res) "mode";
  };
  IngresFromCIDRSetCidrGroupSelectorMatchExpressionModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the label key that the selector applies to.";
        type = types.str;
      };
      "operator" = mkOption {
        description = "operator represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists and DoesNotExist.";
        type = (
          types.enum [
            "In"
            "NotIn"
            "Exists"
            "DoesNotExist"
          ]
        );
      };
      "values" = mkOption {
        description = "values is an array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. This array is replaced during a strategic\nmerge patch.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkIngresFromCIDRSetCidrGroupSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  IngresFromCIDRSetCidrGroupSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf IngresFromCIDRSetCidrGroupSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkIngresFromCIDRSetCidrGroupSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkIngresFromCIDRSetCidrGroupSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  IngresFromCIDRSetModule = types.submodule {
    options = {
      "cidr" = mkOption {
        description = "CIDR is a CIDR prefix / IP Block.";
        type = (types.nullOr types.str);
        default = null;
      };
      "cidrGroupRef" = mkOption {
        description = "CIDRGroupRef is a reference to a CiliumCIDRGroup object.\nA CiliumCIDRGroup contains a list of CIDRs that the endpoint, subject to\nthe rule, can (Ingress/Egress) or cannot (IngressDeny/EgressDeny) receive\nconnections from.";
        type = (types.nullOr types.str);
        default = null;
      };
      "cidrGroupSelector" = mkOption {
        description = "CIDRGroupSelector selects CiliumCIDRGroups by their labels,\nrather than by name.";
        type = (types.nullOr IngresFromCIDRSetCidrGroupSelectorModule);
        default = null;
      };
      "except" = mkOption {
        description = "ExceptCIDRs is a list of IP blocks which the endpoint subject to the rule\nis not allowed to initiate connections to. These CIDR prefixes should be\ncontained within Cidr, using ExceptCIDRs together with CIDRGroupRef is not\nsupported yet.\nThese exceptions are only applied to the Cidr in this CIDRRule, and do not\napply to any other CIDR prefixes in any other CIDRRules.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkIngresFromCIDRSet =
    res:
    {
    }
    // optionalAttrs (res."cidr" != null) { inherit (res) "cidr"; }
    // {
    }
    // optionalAttrs (res."cidrGroupRef" != null) { inherit (res) "cidrGroupRef"; }
    // {
    }
    // optionalAttrs (res."cidrGroupSelector" != null) {
      "cidrGroupSelector" = mkIngresFromCIDRSetCidrGroupSelector res."cidrGroupSelector";
    }
    // {
    }
    // optionalAttrs (res."except" != [ ]) { inherit (res) "except"; }
    // {
    };
  IngresFromEndpointMatchExpressionModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the label key that the selector applies to.";
        type = types.str;
      };
      "operator" = mkOption {
        description = "operator represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists and DoesNotExist.";
        type = (
          types.enum [
            "In"
            "NotIn"
            "Exists"
            "DoesNotExist"
          ]
        );
      };
      "values" = mkOption {
        description = "values is an array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. This array is replaced during a strategic\nmerge patch.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkIngresFromEndpointMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  IngresFromEndpointModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf IngresFromEndpointMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkIngresFromEndpoint =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkIngresFromEndpointMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  IngresFromGroupAwsModule = types.submodule {
    options = {
      "labels" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "region" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "securityGroupsIds" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "securityGroupsNames" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkIngresFromGroupAws =
    res:
    {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."region" != null) { inherit (res) "region"; }
    // {
    }
    // optionalAttrs (res."securityGroupsIds" != [ ]) { inherit (res) "securityGroupsIds"; }
    // {
    }
    // optionalAttrs (res."securityGroupsNames" != [ ]) { inherit (res) "securityGroupsNames"; }
    // {
    };
  IngresFromGroupModule = types.submodule {
    options = {
      "aws" = mkOption {
        description = "AWSGroup is an structure that can be used to whitelisting information from AWS integration";
        type = (types.nullOr IngresFromGroupAwsModule);
        default = null;
      };
    };
  };
  mkIngresFromGroup =
    res:
    {
    }
    // optionalAttrs (res."aws" != null) { "aws" = mkIngresFromGroupAws res."aws"; }
    // {
    };
  IngresFromNodeMatchExpressionModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the label key that the selector applies to.";
        type = types.str;
      };
      "operator" = mkOption {
        description = "operator represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists and DoesNotExist.";
        type = (
          types.enum [
            "In"
            "NotIn"
            "Exists"
            "DoesNotExist"
          ]
        );
      };
      "values" = mkOption {
        description = "values is an array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. This array is replaced during a strategic\nmerge patch.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkIngresFromNodeMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  IngresFromNodeModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf IngresFromNodeMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkIngresFromNode =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkIngresFromNodeMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  IngresIcmpFieldModule = types.submodule {
    options = {
      "family" = mkOption {
        description = "Family is a IP address version.\nCurrently, we support `IPv4` and `IPv6`.\n`IPv4` is set as default.";
        type = (
          types.nullOr (
            types.enum [
              "IPv4"
              "IPv6"
            ]
          )
        );
        default = "IPv4";
      };
      "type" = mkOption {
        description = "Type is a ICMP-type.\nIt should be an 8bit code (0-255), or it's CamelCase name (for example, \"EchoReply\").\nAllowed ICMP types are:\n    Ipv4: EchoReply | DestinationUnreachable | Redirect | Echo | EchoRequest |\n\t\t     RouterAdvertisement | RouterSelection | TimeExceeded | ParameterProblem |\n\t\t\t Timestamp | TimestampReply | Photuris | ExtendedEcho Request | ExtendedEcho Reply\n    Ipv6: DestinationUnreachable | PacketTooBig | TimeExceeded | ParameterProblem |\n\t\t\t EchoRequest | EchoReply | MulticastListenerQuery| MulticastListenerReport |\n\t\t\t MulticastListenerDone | RouterSolicitation | RouterAdvertisement | NeighborSolicitation |\n\t\t\t NeighborAdvertisement | RedirectMessage | RouterRenumbering | ICMPNodeInformationQuery |\n\t\t\t ICMPNodeInformationResponse | InverseNeighborDiscoverySolicitation | InverseNeighborDiscoveryAdvertisement |\n\t\t\t HomeAgentAddressDiscoveryRequest | HomeAgentAddressDiscoveryReply | MobilePrefixSolicitation |\n\t\t\t MobilePrefixAdvertisement | DuplicateAddressRequestCodeSuffix | DuplicateAddressConfirmationCodeSuffix |\n\t\t\t ExtendedEchoRequest | ExtendedEchoReply";
        type = types.anything;
      };
    };
  };
  mkIngresIcmpField =
    res:
    {
    }
    // optionalAttrs (res."family" != null) { inherit (res) "family"; }
    // {
      inherit (res) "type";
    };
  IngresIcmpModule = types.submodule {
    options = {
      "fields" = mkOption {
        description = "Fields is a list of ICMP fields.";
        type = (types.listOf IngresIcmpFieldModule);
        default = [ ];
      };
    };
  };
  mkIngresIcmp =
    res:
    {
    }
    // optionalAttrs (res."fields" != [ ]) { "fields" = map mkIngresIcmpField res."fields"; }
    // {
    };
  IngresModule = types.submodule {
    options = {
      "authentication" = mkOption {
        description = "Authentication is the required authentication type for the allowed traffic, if any.";
        type = (types.nullOr IngresAuthenticationModule);
        default = null;
      };
      "fromCIDR" = mkOption {
        description = "FromCIDR is a list of IP blocks which the endpoint subject to the\nrule is allowed to receive connections from. Only connections which\ndo *not* originate from the cluster or from the local host are subject\nto CIDR rules. In order to allow in-cluster connectivity, use the\nFromEndpoints field.  This will match on the source IP address of\nincoming connections. Adding  a prefix into FromCIDR or into\nFromCIDRSet with no ExcludeCIDRs is  equivalent.  Overlaps are\nallowed between FromCIDR and FromCIDRSet.\n\nExample:\nAny endpoint with the label \"app=my-legacy-pet\" is allowed to receive\nconnections from 10.3.9.1";
        type = (types.listOf types.str);
        default = [ ];
      };
      "fromCIDRSet" = mkOption {
        description = "FromCIDRSet is a list of IP blocks which the endpoint subject to the\nrule is allowed to receive connections from in addition to FromEndpoints,\nalong with a list of subnets contained within their corresponding IP block\nfrom which traffic should not be allowed.\nThis will match on the source IP address of incoming connections. Adding\na prefix into FromCIDR or into FromCIDRSet with no ExcludeCIDRs is\nequivalent. Overlaps are allowed between FromCIDR and FromCIDRSet.\n\nExample:\nAny endpoint with the label \"app=my-legacy-pet\" is allowed to receive\nconnections from 10.0.0.0/8 except from IPs in subnet 10.96.0.0/12.";
        type = (types.listOf IngresFromCIDRSetModule);
        default = [ ];
      };
      "fromEndpoints" = mkOption {
        description = "FromEndpoints is a list of endpoints identified by an\nEndpointSelector which are allowed to communicate with the endpoint\nsubject to the rule.\n\nExample:\nAny endpoint with the label \"role=backend\" can be consumed by any\nendpoint carrying the label \"role=frontend\".\n\nNote that while an empty non-nil FromEndpoints does not select anything,\nnil FromEndpoints is implicitly treated as a wildcard selector if ToPorts\nare also specified.\nTo select everything, use one EndpointSelector without any match requirements.";
        type = (types.listOf IngresFromEndpointModule);
        default = [ ];
      };
      "fromEntities" = mkOption {
        description = "FromEntities is a list of special entities which the endpoint subject\nto the rule is allowed to receive connections from. Supported entities are\n`world`, `cluster`, `host`, `remote-node`, `kube-apiserver`, `ingress`, `init`,\n`health`, `unmanaged`, `none` and `all`.";
        type = (
          types.listOf (
            types.enum [
              "all"
              "world"
              "cluster"
              "host"
              "init"
              "ingress"
              "unmanaged"
              "remote-node"
              "health"
              "none"
              "kube-apiserver"
            ]
          )
        );
        default = [ ];
      };
      "fromGroups" = mkOption {
        description = "FromGroups is a directive that allows the integration with multiple outside\nproviders. Currently, only AWS is supported, and the rule can select by\nmultiple sub directives:\n\nExample:\nFromGroups:\n- aws:\n    securityGroupsIds:\n    - 'sg-XXXXXXXXXXXXX'";
        type = (types.listOf IngresFromGroupModule);
        default = [ ];
      };
      "fromNodes" = mkOption {
        description = "FromNodes is a list of nodes identified by an\nEndpointSelector which are allowed to communicate with the endpoint\nsubject to the rule.";
        type = (types.listOf IngresFromNodeModule);
        default = [ ];
      };
      "fromRequires" = mkOption {
        description = "Deprecated.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "icmps" = mkOption {
        description = "ICMPs is a list of ICMP rule identified by type number\nwhich the endpoint subject to the rule is allowed to\nreceive connections on.\n\nExample:\nAny endpoint with the label \"app=httpd\" can only accept incoming\ntype 8 ICMP connections.";
        type = (types.listOf IngresIcmpModule);
        default = [ ];
      };
      "toPorts" = mkOption {
        description = "ToPorts is a list of destination ports identified by port number and\nprotocol which the endpoint subject to the rule is allowed to\nreceive connections on.\n\nExample:\nAny endpoint with the label \"app=httpd\" can only accept incoming\nconnections on port 80/tcp.";
        type = (types.listOf IngresToPortModule);
        default = [ ];
      };
    };
  };
  mkIngres =
    res:
    {
    }
    // optionalAttrs (res."authentication" != null) {
      "authentication" = mkIngresAuthentication res."authentication";
    }
    // {
    }
    // optionalAttrs (res."fromCIDR" != [ ]) { inherit (res) "fromCIDR"; }
    // {
    }
    // optionalAttrs (res."fromCIDRSet" != [ ]) {
      "fromCIDRSet" = map mkIngresFromCIDRSet res."fromCIDRSet";
    }
    // {
    }
    // optionalAttrs (res."fromEndpoints" != [ ]) {
      "fromEndpoints" = map mkIngresFromEndpoint res."fromEndpoints";
    }
    // {
    }
    // optionalAttrs (res."fromEntities" != [ ]) { inherit (res) "fromEntities"; }
    // {
    }
    // optionalAttrs (res."fromGroups" != [ ]) {
      "fromGroups" = map mkIngresFromGroup res."fromGroups";
    }
    // {
    }
    // optionalAttrs (res."fromNodes" != [ ]) { "fromNodes" = map mkIngresFromNode res."fromNodes"; }
    // {
    }
    // optionalAttrs (res."fromRequires" != [ ]) { inherit (res) "fromRequires"; }
    // {
    }
    // optionalAttrs (res."icmps" != [ ]) { "icmps" = map mkIngresIcmp res."icmps"; }
    // {
    }
    // optionalAttrs (res."toPorts" != [ ]) { "toPorts" = map mkIngresToPort res."toPorts"; }
    // {
    };
  IngresToPortListenerEnvoyConfigModule = types.submodule {
    options = {
      "kind" = mkOption {
        description = "Kind is the resource type being referred to. Defaults to CiliumEnvoyConfig or\nCiliumClusterwideEnvoyConfig for CiliumNetworkPolicy and CiliumClusterwideNetworkPolicy,\nrespectively. The only case this is currently explicitly needed is when referring to a\nCiliumClusterwideEnvoyConfig from CiliumNetworkPolicy, as using a namespaced listener\nfrom a cluster scoped policy is not allowed.";
        type = (
          types.nullOr (
            types.enum [
              "CiliumEnvoyConfig"
              "CiliumClusterwideEnvoyConfig"
            ]
          )
        );
        default = null;
      };
      "name" = mkOption {
        description = "Name is the resource name of the CiliumEnvoyConfig or CiliumClusterwideEnvoyConfig where\nthe listener is defined in.";
        type = types.str;
      };
    };
  };
  mkIngresToPortListenerEnvoyConfig =
    res:
    {
    }
    // optionalAttrs (res."kind" != null) { inherit (res) "kind"; }
    // {
      inherit (res) "name";
    };
  IngresToPortListenerModule = types.submodule {
    options = {
      "envoyConfig" = mkOption {
        description = "EnvoyConfig is a reference to the CEC or CCEC resource in which\nthe listener is defined.";
        type = IngresToPortListenerEnvoyConfigModule;
      };
      "name" = mkOption {
        description = "Name is the name of the listener.";
        type = types.str;
      };
      "priority" = mkOption {
        description = "Priority for this Listener that is used when multiple rules would apply different\nlisteners to a policy map entry. Behavior of this is implementation dependent.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkIngresToPortListener =
    res:
    {
      "envoyConfig" = mkIngresToPortListenerEnvoyConfig res."envoyConfig";
      inherit (res) "name";
    }
    // optionalAttrs (res."priority" != null) { inherit (res) "priority"; }
    // {
    };
  IngresToPortModule = types.submodule {
    options = {
      "listener" = mkOption {
        description = "listener specifies the name of a custom Envoy listener to which this traffic should be\nredirected to.";
        type = (types.nullOr IngresToPortListenerModule);
        default = null;
      };
      "originatingTLS" = mkOption {
        description = "OriginatingTLS is the TLS context for the connections originated by\nthe L7 proxy.  For egress policy this specifies the client-side TLS\nparameters for the upstream connection originating from the L7 proxy\nto the remote destination. For ingress policy this specifies the\nclient-side TLS parameters for the connection from the L7 proxy to\nthe local endpoint.";
        type = (types.nullOr IngresToPortOriginatingTLSModule);
        default = null;
      };
      "ports" = mkOption {
        description = "Ports is a list of L4 port/protocol";
        type = (types.listOf IngresToPortPortModule);
        default = [ ];
      };
      "rules" = mkOption {
        description = "Rules is a list of additional port level rules which must be met in\norder for the PortRule to allow the traffic. If omitted or empty,\nno layer 7 rules are enforced.";
        type = (types.nullOr IngresToPortRulesModule);
        default = null;
      };
      "serverNames" = mkOption {
        description = "ServerNames is a list of allowed TLS SNI values. If not empty, then\nTLS must be present and one of the provided SNIs must be indicated in the\nTLS handshake.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "terminatingTLS" = mkOption {
        description = "TerminatingTLS is the TLS context for the connection terminated by\nthe L7 proxy.  For egress policy this specifies the server-side TLS\nparameters to be applied on the connections originated from the local\nendpoint and terminated by the L7 proxy. For ingress policy this specifies\nthe server-side TLS parameters to be applied on the connections\noriginated from a remote source and terminated by the L7 proxy.";
        type = (types.nullOr IngresToPortTerminatingTLSModule);
        default = null;
      };
    };
  };
  mkIngresToPort =
    res:
    {
    }
    // optionalAttrs (res."listener" != null) { "listener" = mkIngresToPortListener res."listener"; }
    // {
    }
    // optionalAttrs (res."originatingTLS" != null) {
      "originatingTLS" = mkIngresToPortOriginatingTLS res."originatingTLS";
    }
    // {
    }
    // optionalAttrs (res."ports" != [ ]) { "ports" = map mkIngresToPortPort res."ports"; }
    // {
    }
    // optionalAttrs (res."rules" != null) { "rules" = mkIngresToPortRules res."rules"; }
    // {
    }
    // optionalAttrs (res."serverNames" != [ ]) { inherit (res) "serverNames"; }
    // {
    }
    // optionalAttrs (res."terminatingTLS" != null) {
      "terminatingTLS" = mkIngresToPortTerminatingTLS res."terminatingTLS";
    }
    // {
    };
  IngresToPortOriginatingTLSModule = types.submodule {
    options = {
      "certificate" = mkOption {
        description = "Certificate is the file name or k8s secret item name for the certificate\nchain. If omitted, 'tls.crt' is assumed, if it exists. If given, the\nitem must exist.";
        type = (types.nullOr types.str);
        default = null;
      };
      "privateKey" = mkOption {
        description = "PrivateKey is the file name or k8s secret item name for the private key\nmatching the certificate chain. If omitted, 'tls.key' is assumed, if it\nexists. If given, the item must exist.";
        type = (types.nullOr types.str);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret is the secret that contains the certificates and private key for\nthe TLS context.\nBy default, Cilium will search in this secret for the following items:\n - 'ca.crt'  - Which represents the trusted CA to verify remote source.\n - 'tls.crt' - Which represents the public key certificate.\n - 'tls.key' - Which represents the private key matching the public key\n               certificate.";
        type = IngresToPortOriginatingTLSSecretModule;
      };
      "trustedCA" = mkOption {
        description = "TrustedCA is the file name or k8s secret item name for the trusted CA.\nIf omitted, 'ca.crt' is assumed, if it exists. If given, the item must\nexist.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkIngresToPortOriginatingTLS =
    res:
    {
    }
    // optionalAttrs (res."certificate" != null) { inherit (res) "certificate"; }
    // {
    }
    // optionalAttrs (res."privateKey" != null) { inherit (res) "privateKey"; }
    // {
      "secret" = mkIngresToPortOriginatingTLSSecret res."secret";
    }
    // optionalAttrs (res."trustedCA" != null) { inherit (res) "trustedCA"; }
    // {
    };
  IngresToPortOriginatingTLSSecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the name of the secret.";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "Namespace is the namespace in which the secret exists. Context of use\ndetermines the default value if left out (e.g., \"default\").";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkIngresToPortOriginatingTLSSecret =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  IngresToPortPortModule = types.submodule {
    options = {
      "endPort" = mkOption {
        description = "EndPort can only be an L4 port number.";
        type = (types.nullOr types.int);
        default = null;
      };
      "port" = mkOption {
        description = "Port can be an L4 port number, or a name in the form of \"http\"\nor \"http-8080\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "protocol" = mkOption {
        description = "Protocol is the L4 protocol. If \"ANY\", omitted or empty, any protocols\nwith transport ports (TCP, UDP, SCTP) match.\n\nAccepted values: \"TCP\", \"UDP\", \"SCTP\", \"VRRP\", \"IGMP\", \"ANY\"\n\nMatching on ICMP is not supported.\n\nNamed port specified for a container may narrow this down, but may not\ncontradict this.";
        type = (
          types.nullOr (
            types.enum [
              "TCP"
              "UDP"
              "SCTP"
              "VRRP"
              "IGMP"
              "ANY"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkIngresToPortPort =
    res:
    {
    }
    // optionalAttrs (res."endPort" != null) { inherit (res) "endPort"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
    }
    // optionalAttrs (res."protocol" != null) { inherit (res) "protocol"; }
    // {
    };
  IngresToPortRulesDnModule = types.submodule {
    options = {
      "matchName" = mkOption {
        description = "MatchName matches literal DNS names. A trailing \".\" is automatically added\nwhen missing.";
        type = (types.nullOr types.str);
        default = null;
      };
      "matchPattern" = mkOption {
        description = "MatchPattern allows using wildcards to match DNS names. All wildcards are\ncase insensitive. The wildcards are:\n- \"*\" matches 0 or more DNS valid characters, and may occur anywhere in\nthe pattern. As a special case a \"*\" as the leftmost character, without a\nfollowing \".\" matches all subdomains as well as the name to the right.\nA trailing \".\" is automatically added when missing.\n- \"**.\" is a special prefix which matches all multilevel subdomains in the prefix.\n\nExamples:\n1. `*.cilium.io` matches subdomains of cilium at that level\n  www.cilium.io and blog.cilium.io match, cilium.io and google.com do not\n2. `*cilium.io` matches cilium.io and all subdomains ends with \"cilium.io\"\n  except those containing \".\" separator, subcilium.io and sub-cilium.io match,\n  www.cilium.io and blog.cilium.io does not\n3. `sub*.cilium.io` matches subdomains of cilium where the subdomain component\n  begins with \"sub\". sub.cilium.io and subdomain.cilium.io match while www.cilium.io,\n  blog.cilium.io, cilium.io and google.com do not\n4. `**.cilium.io` matches all multilevel subdomains of cilium.io.\n  \"app.cilium.io\" and \"test.app.cilium.io\" match but not \"cilium.io\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkIngresToPortRulesDn =
    res:
    {
    }
    // optionalAttrs (res."matchName" != null) { inherit (res) "matchName"; }
    // {
    }
    // optionalAttrs (res."matchPattern" != null) { inherit (res) "matchPattern"; }
    // {
    };
  IngresToPortRulesHttpHeaderMatcheModule = types.submodule {
    options = {
      "mismatch" = mkOption {
        description = "Mismatch identifies what to do in case there is no match. The default is\nto drop the request. Otherwise the overall rule is still considered as\nmatching, but the mismatches are logged in the access log.";
        type = (
          types.nullOr (
            types.enum [
              "LOG"
              "ADD"
              "DELETE"
              "REPLACE"
            ]
          )
        );
        default = null;
      };
      "name" = mkOption {
        description = "Name identifies the header.";
        type = types.str;
      };
      "secret" = mkOption {
        description = "Secret refers to a secret that contains the value to be matched against.\nThe secret must only contain one entry. If the referred secret does not\nexist, and there is no \"Value\" specified, the match will fail.";
        type = (types.nullOr IngresToPortRulesHttpHeaderMatcheSecretModule);
        default = null;
      };
      "value" = mkOption {
        description = "Value matches the exact value of the header. Can be specified either\nalone or together with \"Secret\"; will be used as the header value if the\nsecret can not be found in the latter case.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkIngresToPortRulesHttpHeaderMatche =
    res:
    {
    }
    // optionalAttrs (res."mismatch" != null) { inherit (res) "mismatch"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkIngresToPortRulesHttpHeaderMatcheSecret res."secret";
    }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  IngresToPortRulesHttpHeaderMatcheSecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the name of the secret.";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "Namespace is the namespace in which the secret exists. Context of use\ndetermines the default value if left out (e.g., \"default\").";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkIngresToPortRulesHttpHeaderMatcheSecret =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  IngresToPortRulesHttpModule = types.submodule {
    options = {
      "headerMatches" = mkOption {
        description = "HeaderMatches is a list of HTTP headers which must be\npresent and match against the given values. Mismatch field can be used\nto specify what to do when there is no match.";
        type = (types.listOf IngresToPortRulesHttpHeaderMatcheModule);
        default = [ ];
      };
      "headers" = mkOption {
        description = "Headers is a list of HTTP headers which must be present in the\nrequest. If omitted or empty, requests are allowed regardless of\nheaders present.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "host" = mkOption {
        description = "Host is an extended POSIX regex matched against the host header of a\nrequest. Examples:\n\n- foo.bar.com will match the host fooXbar.com or foo-bar.com\n- foo\\.bar\\.com will only match the host foo.bar.com\n\nIf omitted or empty, the value of the host header is ignored.";
        type = (types.nullOr types.str);
        default = null;
      };
      "method" = mkOption {
        description = "Method is an extended POSIX regex matched against the method of a\nrequest, e.g. \"GET\", \"POST\", \"PUT\", \"PATCH\", \"DELETE\", ...\n\nIf omitted or empty, all methods are allowed.";
        type = (types.nullOr types.str);
        default = null;
      };
      "path" = mkOption {
        description = "Path is an extended POSIX regex matched against the path of a\nrequest. Currently it can contain characters disallowed from the\nconventional \"path\" part of a URL as defined by RFC 3986.\n\nIf omitted or empty, all paths are all allowed.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkIngresToPortRulesHttp =
    res:
    {
    }
    // optionalAttrs (res."headerMatches" != [ ]) {
      "headerMatches" = map mkIngresToPortRulesHttpHeaderMatche res."headerMatches";
    }
    // {
    }
    // optionalAttrs (res."headers" != [ ]) { inherit (res) "headers"; }
    // {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."method" != null) { inherit (res) "method"; }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    };
  IngresToPortRulesKafkaModule = types.submodule {
    options = {
      "apiKey" = mkOption {
        description = "APIKey is a case-insensitive string matched against the key of a\nrequest, e.g. \"produce\", \"fetch\", \"createtopic\", \"deletetopic\", et al\nReference: https://kafka.apache.org/protocol#protocol_api_keys\n\nIf omitted or empty, and if Role is not specified, then all keys are allowed.";
        type = (types.nullOr types.str);
        default = null;
      };
      "apiVersion" = mkOption {
        description = "APIVersion is the version matched against the api version of the\nKafka message. If set, it has to be a string representing a positive\ninteger.\n\nIf omitted or empty, all versions are allowed.";
        type = (types.nullOr types.str);
        default = null;
      };
      "clientID" = mkOption {
        description = "ClientID is the client identifier as provided in the request.\n\nFrom Kafka protocol documentation:\nThis is a user supplied identifier for the client application. The\nuser can use any identifier they like and it will be used when\nlogging errors, monitoring aggregates, etc. For example, one might\nwant to monitor not just the requests per second overall, but the\nnumber coming from each client application (each of which could\nreside on multiple servers). This id acts as a logical grouping\nacross all requests from a particular client.\n\nIf omitted or empty, all client identifiers are allowed.";
        type = (types.nullOr types.str);
        default = null;
      };
      "role" = mkOption {
        description = "Role is a case-insensitive string and describes a group of API keys\nnecessary to perform certain higher-level Kafka operations such as \"produce\"\nor \"consume\". A Role automatically expands into all APIKeys required\nto perform the specified higher-level operation.\n\nThe following values are supported:\n - \"produce\": Allow producing to the topics specified in the rule\n - \"consume\": Allow consuming from the topics specified in the rule\n\nThis field is incompatible with the APIKey field, i.e APIKey and Role\ncannot both be specified in the same rule.\n\nIf omitted or empty, and if APIKey is not specified, then all keys are\nallowed.";
        type = (
          types.nullOr (
            types.enum [
              "produce"
              "consume"
            ]
          )
        );
        default = null;
      };
      "topic" = mkOption {
        description = "Topic is the topic name contained in the message. If a Kafka request\ncontains multiple topics, then all topics must be allowed or the\nmessage will be rejected.\n\nThis constraint is ignored if the matched request message type\ndoesn't contain any topic. Maximum size of Topic can be 249\ncharacters as per recent Kafka spec and allowed characters are\na-z, A-Z, 0-9, -, . and _.\n\nOlder Kafka versions had longer topic lengths of 255, but in Kafka 0.10\nversion the length was changed from 255 to 249. For compatibility\nreasons we are using 255.\n\nIf omitted or empty, all topics are allowed.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkIngresToPortRulesKafka =
    res:
    {
    }
    // optionalAttrs (res."apiKey" != null) { inherit (res) "apiKey"; }
    // {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
    }
    // optionalAttrs (res."clientID" != null) { inherit (res) "clientID"; }
    // {
    }
    // optionalAttrs (res."role" != null) { inherit (res) "role"; }
    // {
    }
    // optionalAttrs (res."topic" != null) { inherit (res) "topic"; }
    // {
    };
  IngresToPortRulesModule = types.submodule {
    options = {
      "dns" = mkOption {
        description = "DNS-specific rules.";
        type = (types.listOf IngresToPortRulesDnModule);
        default = [ ];
      };
      "http" = mkOption {
        description = "HTTP specific rules.";
        type = (types.listOf IngresToPortRulesHttpModule);
        default = [ ];
      };
      "kafka" = mkOption {
        description = "Kafka-specific rules.\nDeprecated: This beta feature is deprecated and will be removed in a future release.";
        type = (types.listOf IngresToPortRulesKafkaModule);
        default = [ ];
      };
      "l7" = mkOption {
        description = "Key-value pair rules.";
        type = (types.listOf (types.attrsOf types.str));
        default = [ ];
      };
      "l7proto" = mkOption {
        description = "Name of the L7 protocol for which the Key-value pair rules apply.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkIngresToPortRules =
    res:
    {
    }
    // optionalAttrs (res."dns" != [ ]) { "dns" = map mkIngresToPortRulesDn res."dns"; }
    // {
    }
    // optionalAttrs (res."http" != [ ]) { "http" = map mkIngresToPortRulesHttp res."http"; }
    // {
    }
    // optionalAttrs (res."kafka" != [ ]) { "kafka" = map mkIngresToPortRulesKafka res."kafka"; }
    // {
    }
    // optionalAttrs (res."l7" != [ ]) { inherit (res) "l7"; }
    // {
    }
    // optionalAttrs (res."l7proto" != null) { inherit (res) "l7proto"; }
    // {
    };
  IngresToPortTerminatingTLSModule = types.submodule {
    options = {
      "certificate" = mkOption {
        description = "Certificate is the file name or k8s secret item name for the certificate\nchain. If omitted, 'tls.crt' is assumed, if it exists. If given, the\nitem must exist.";
        type = (types.nullOr types.str);
        default = null;
      };
      "privateKey" = mkOption {
        description = "PrivateKey is the file name or k8s secret item name for the private key\nmatching the certificate chain. If omitted, 'tls.key' is assumed, if it\nexists. If given, the item must exist.";
        type = (types.nullOr types.str);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret is the secret that contains the certificates and private key for\nthe TLS context.\nBy default, Cilium will search in this secret for the following items:\n - 'ca.crt'  - Which represents the trusted CA to verify remote source.\n - 'tls.crt' - Which represents the public key certificate.\n - 'tls.key' - Which represents the private key matching the public key\n               certificate.";
        type = IngresToPortTerminatingTLSSecretModule;
      };
      "trustedCA" = mkOption {
        description = "TrustedCA is the file name or k8s secret item name for the trusted CA.\nIf omitted, 'ca.crt' is assumed, if it exists. If given, the item must\nexist.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkIngresToPortTerminatingTLS =
    res:
    {
    }
    // optionalAttrs (res."certificate" != null) { inherit (res) "certificate"; }
    // {
    }
    // optionalAttrs (res."privateKey" != null) { inherit (res) "privateKey"; }
    // {
      "secret" = mkIngresToPortTerminatingTLSSecret res."secret";
    }
    // optionalAttrs (res."trustedCA" != null) { inherit (res) "trustedCA"; }
    // {
    };
  IngresToPortTerminatingTLSSecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the name of the secret.";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "Namespace is the namespace in which the secret exists. Context of use\ndetermines the default value if left out (e.g., \"default\").";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkIngresToPortTerminatingTLSSecret =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  IngressDenyFromCIDRSetCidrGroupSelectorMatchExpressionModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the label key that the selector applies to.";
        type = types.str;
      };
      "operator" = mkOption {
        description = "operator represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists and DoesNotExist.";
        type = (
          types.enum [
            "In"
            "NotIn"
            "Exists"
            "DoesNotExist"
          ]
        );
      };
      "values" = mkOption {
        description = "values is an array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. This array is replaced during a strategic\nmerge patch.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkIngressDenyFromCIDRSetCidrGroupSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  IngressDenyFromCIDRSetCidrGroupSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf IngressDenyFromCIDRSetCidrGroupSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkIngressDenyFromCIDRSetCidrGroupSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkIngressDenyFromCIDRSetCidrGroupSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  IngressDenyFromCIDRSetModule = types.submodule {
    options = {
      "cidr" = mkOption {
        description = "CIDR is a CIDR prefix / IP Block.";
        type = (types.nullOr types.str);
        default = null;
      };
      "cidrGroupRef" = mkOption {
        description = "CIDRGroupRef is a reference to a CiliumCIDRGroup object.\nA CiliumCIDRGroup contains a list of CIDRs that the endpoint, subject to\nthe rule, can (Ingress/Egress) or cannot (IngressDeny/EgressDeny) receive\nconnections from.";
        type = (types.nullOr types.str);
        default = null;
      };
      "cidrGroupSelector" = mkOption {
        description = "CIDRGroupSelector selects CiliumCIDRGroups by their labels,\nrather than by name.";
        type = (types.nullOr IngressDenyFromCIDRSetCidrGroupSelectorModule);
        default = null;
      };
      "except" = mkOption {
        description = "ExceptCIDRs is a list of IP blocks which the endpoint subject to the rule\nis not allowed to initiate connections to. These CIDR prefixes should be\ncontained within Cidr, using ExceptCIDRs together with CIDRGroupRef is not\nsupported yet.\nThese exceptions are only applied to the Cidr in this CIDRRule, and do not\napply to any other CIDR prefixes in any other CIDRRules.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkIngressDenyFromCIDRSet =
    res:
    {
    }
    // optionalAttrs (res."cidr" != null) { inherit (res) "cidr"; }
    // {
    }
    // optionalAttrs (res."cidrGroupRef" != null) { inherit (res) "cidrGroupRef"; }
    // {
    }
    // optionalAttrs (res."cidrGroupSelector" != null) {
      "cidrGroupSelector" = mkIngressDenyFromCIDRSetCidrGroupSelector res."cidrGroupSelector";
    }
    // {
    }
    // optionalAttrs (res."except" != [ ]) { inherit (res) "except"; }
    // {
    };
  IngressDenyFromEndpointMatchExpressionModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the label key that the selector applies to.";
        type = types.str;
      };
      "operator" = mkOption {
        description = "operator represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists and DoesNotExist.";
        type = (
          types.enum [
            "In"
            "NotIn"
            "Exists"
            "DoesNotExist"
          ]
        );
      };
      "values" = mkOption {
        description = "values is an array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. This array is replaced during a strategic\nmerge patch.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkIngressDenyFromEndpointMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  IngressDenyFromEndpointModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf IngressDenyFromEndpointMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkIngressDenyFromEndpoint =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkIngressDenyFromEndpointMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  IngressDenyFromGroupAwsModule = types.submodule {
    options = {
      "labels" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "region" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "securityGroupsIds" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "securityGroupsNames" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkIngressDenyFromGroupAws =
    res:
    {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."region" != null) { inherit (res) "region"; }
    // {
    }
    // optionalAttrs (res."securityGroupsIds" != [ ]) { inherit (res) "securityGroupsIds"; }
    // {
    }
    // optionalAttrs (res."securityGroupsNames" != [ ]) { inherit (res) "securityGroupsNames"; }
    // {
    };
  IngressDenyFromGroupModule = types.submodule {
    options = {
      "aws" = mkOption {
        description = "AWSGroup is an structure that can be used to whitelisting information from AWS integration";
        type = (types.nullOr IngressDenyFromGroupAwsModule);
        default = null;
      };
    };
  };
  mkIngressDenyFromGroup =
    res:
    {
    }
    // optionalAttrs (res."aws" != null) { "aws" = mkIngressDenyFromGroupAws res."aws"; }
    // {
    };
  IngressDenyFromNodeMatchExpressionModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the label key that the selector applies to.";
        type = types.str;
      };
      "operator" = mkOption {
        description = "operator represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists and DoesNotExist.";
        type = (
          types.enum [
            "In"
            "NotIn"
            "Exists"
            "DoesNotExist"
          ]
        );
      };
      "values" = mkOption {
        description = "values is an array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. This array is replaced during a strategic\nmerge patch.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkIngressDenyFromNodeMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  IngressDenyFromNodeModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf IngressDenyFromNodeMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkIngressDenyFromNode =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkIngressDenyFromNodeMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  IngressDenyIcmpFieldModule = types.submodule {
    options = {
      "family" = mkOption {
        description = "Family is a IP address version.\nCurrently, we support `IPv4` and `IPv6`.\n`IPv4` is set as default.";
        type = (
          types.nullOr (
            types.enum [
              "IPv4"
              "IPv6"
            ]
          )
        );
        default = "IPv4";
      };
      "type" = mkOption {
        description = "Type is a ICMP-type.\nIt should be an 8bit code (0-255), or it's CamelCase name (for example, \"EchoReply\").\nAllowed ICMP types are:\n    Ipv4: EchoReply | DestinationUnreachable | Redirect | Echo | EchoRequest |\n\t\t     RouterAdvertisement | RouterSelection | TimeExceeded | ParameterProblem |\n\t\t\t Timestamp | TimestampReply | Photuris | ExtendedEcho Request | ExtendedEcho Reply\n    Ipv6: DestinationUnreachable | PacketTooBig | TimeExceeded | ParameterProblem |\n\t\t\t EchoRequest | EchoReply | MulticastListenerQuery| MulticastListenerReport |\n\t\t\t MulticastListenerDone | RouterSolicitation | RouterAdvertisement | NeighborSolicitation |\n\t\t\t NeighborAdvertisement | RedirectMessage | RouterRenumbering | ICMPNodeInformationQuery |\n\t\t\t ICMPNodeInformationResponse | InverseNeighborDiscoverySolicitation | InverseNeighborDiscoveryAdvertisement |\n\t\t\t HomeAgentAddressDiscoveryRequest | HomeAgentAddressDiscoveryReply | MobilePrefixSolicitation |\n\t\t\t MobilePrefixAdvertisement | DuplicateAddressRequestCodeSuffix | DuplicateAddressConfirmationCodeSuffix |\n\t\t\t ExtendedEchoRequest | ExtendedEchoReply";
        type = types.anything;
      };
    };
  };
  mkIngressDenyIcmpField =
    res:
    {
    }
    // optionalAttrs (res."family" != null) { inherit (res) "family"; }
    // {
      inherit (res) "type";
    };
  IngressDenyIcmpModule = types.submodule {
    options = {
      "fields" = mkOption {
        description = "Fields is a list of ICMP fields.";
        type = (types.listOf IngressDenyIcmpFieldModule);
        default = [ ];
      };
    };
  };
  mkIngressDenyIcmp =
    res:
    {
    }
    // optionalAttrs (res."fields" != [ ]) { "fields" = map mkIngressDenyIcmpField res."fields"; }
    // {
    };
  IngressDenyModule = types.submodule {
    options = {
      "fromCIDR" = mkOption {
        description = "FromCIDR is a list of IP blocks which the endpoint subject to the\nrule is allowed to receive connections from. Only connections which\ndo *not* originate from the cluster or from the local host are subject\nto CIDR rules. In order to allow in-cluster connectivity, use the\nFromEndpoints field.  This will match on the source IP address of\nincoming connections. Adding  a prefix into FromCIDR or into\nFromCIDRSet with no ExcludeCIDRs is  equivalent.  Overlaps are\nallowed between FromCIDR and FromCIDRSet.\n\nExample:\nAny endpoint with the label \"app=my-legacy-pet\" is allowed to receive\nconnections from 10.3.9.1";
        type = (types.listOf types.str);
        default = [ ];
      };
      "fromCIDRSet" = mkOption {
        description = "FromCIDRSet is a list of IP blocks which the endpoint subject to the\nrule is allowed to receive connections from in addition to FromEndpoints,\nalong with a list of subnets contained within their corresponding IP block\nfrom which traffic should not be allowed.\nThis will match on the source IP address of incoming connections. Adding\na prefix into FromCIDR or into FromCIDRSet with no ExcludeCIDRs is\nequivalent. Overlaps are allowed between FromCIDR and FromCIDRSet.\n\nExample:\nAny endpoint with the label \"app=my-legacy-pet\" is allowed to receive\nconnections from 10.0.0.0/8 except from IPs in subnet 10.96.0.0/12.";
        type = (types.listOf IngressDenyFromCIDRSetModule);
        default = [ ];
      };
      "fromEndpoints" = mkOption {
        description = "FromEndpoints is a list of endpoints identified by an\nEndpointSelector which are allowed to communicate with the endpoint\nsubject to the rule.\n\nExample:\nAny endpoint with the label \"role=backend\" can be consumed by any\nendpoint carrying the label \"role=frontend\".\n\nNote that while an empty non-nil FromEndpoints does not select anything,\nnil FromEndpoints is implicitly treated as a wildcard selector if ToPorts\nare also specified.\nTo select everything, use one EndpointSelector without any match requirements.";
        type = (types.listOf IngressDenyFromEndpointModule);
        default = [ ];
      };
      "fromEntities" = mkOption {
        description = "FromEntities is a list of special entities which the endpoint subject\nto the rule is allowed to receive connections from. Supported entities are\n`world`, `cluster`, `host`, `remote-node`, `kube-apiserver`, `ingress`, `init`,\n`health`, `unmanaged`, `none` and `all`.";
        type = (
          types.listOf (
            types.enum [
              "all"
              "world"
              "cluster"
              "host"
              "init"
              "ingress"
              "unmanaged"
              "remote-node"
              "health"
              "none"
              "kube-apiserver"
            ]
          )
        );
        default = [ ];
      };
      "fromGroups" = mkOption {
        description = "FromGroups is a directive that allows the integration with multiple outside\nproviders. Currently, only AWS is supported, and the rule can select by\nmultiple sub directives:\n\nExample:\nFromGroups:\n- aws:\n    securityGroupsIds:\n    - 'sg-XXXXXXXXXXXXX'";
        type = (types.listOf IngressDenyFromGroupModule);
        default = [ ];
      };
      "fromNodes" = mkOption {
        description = "FromNodes is a list of nodes identified by an\nEndpointSelector which are allowed to communicate with the endpoint\nsubject to the rule.";
        type = (types.listOf IngressDenyFromNodeModule);
        default = [ ];
      };
      "fromRequires" = mkOption {
        description = "Deprecated.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "icmps" = mkOption {
        description = "ICMPs is a list of ICMP rule identified by type number\nwhich the endpoint subject to the rule is not allowed to\nreceive connections on.\n\nExample:\nAny endpoint with the label \"app=httpd\" can not accept incoming\ntype 8 ICMP connections.";
        type = (types.listOf IngressDenyIcmpModule);
        default = [ ];
      };
      "toPorts" = mkOption {
        description = "ToPorts is a list of destination ports identified by port number and\nprotocol which the endpoint subject to the rule is not allowed to\nreceive connections on.\n\nExample:\nAny endpoint with the label \"app=httpd\" can not accept incoming\nconnections on port 80/tcp.";
        type = (types.listOf IngressDenyToPortModule);
        default = [ ];
      };
    };
  };
  mkIngressDeny =
    res:
    {
    }
    // optionalAttrs (res."fromCIDR" != [ ]) { inherit (res) "fromCIDR"; }
    // {
    }
    // optionalAttrs (res."fromCIDRSet" != [ ]) {
      "fromCIDRSet" = map mkIngressDenyFromCIDRSet res."fromCIDRSet";
    }
    // {
    }
    // optionalAttrs (res."fromEndpoints" != [ ]) {
      "fromEndpoints" = map mkIngressDenyFromEndpoint res."fromEndpoints";
    }
    // {
    }
    // optionalAttrs (res."fromEntities" != [ ]) { inherit (res) "fromEntities"; }
    // {
    }
    // optionalAttrs (res."fromGroups" != [ ]) {
      "fromGroups" = map mkIngressDenyFromGroup res."fromGroups";
    }
    // {
    }
    // optionalAttrs (res."fromNodes" != [ ]) {
      "fromNodes" = map mkIngressDenyFromNode res."fromNodes";
    }
    // {
    }
    // optionalAttrs (res."fromRequires" != [ ]) { inherit (res) "fromRequires"; }
    // {
    }
    // optionalAttrs (res."icmps" != [ ]) { "icmps" = map mkIngressDenyIcmp res."icmps"; }
    // {
    }
    // optionalAttrs (res."toPorts" != [ ]) { "toPorts" = map mkIngressDenyToPort res."toPorts"; }
    // {
    };
  IngressDenyToPortModule = types.submodule {
    options = {
      "ports" = mkOption {
        description = "Ports is a list of L4 port/protocol";
        type = (types.listOf IngressDenyToPortPortModule);
        default = [ ];
      };
    };
  };
  mkIngressDenyToPort =
    res:
    {
    }
    // optionalAttrs (res."ports" != [ ]) { "ports" = map mkIngressDenyToPortPort res."ports"; }
    // {
    };
  IngressDenyToPortPortModule = types.submodule {
    options = {
      "endPort" = mkOption {
        description = "EndPort can only be an L4 port number.";
        type = (types.nullOr types.int);
        default = null;
      };
      "port" = mkOption {
        description = "Port can be an L4 port number, or a name in the form of \"http\"\nor \"http-8080\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "protocol" = mkOption {
        description = "Protocol is the L4 protocol. If \"ANY\", omitted or empty, any protocols\nwith transport ports (TCP, UDP, SCTP) match.\n\nAccepted values: \"TCP\", \"UDP\", \"SCTP\", \"VRRP\", \"IGMP\", \"ANY\"\n\nMatching on ICMP is not supported.\n\nNamed port specified for a container may narrow this down, but may not\ncontradict this.";
        type = (
          types.nullOr (
            types.enum [
              "TCP"
              "UDP"
              "SCTP"
              "VRRP"
              "IGMP"
              "ANY"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkIngressDenyToPortPort =
    res:
    {
    }
    // optionalAttrs (res."endPort" != null) { inherit (res) "endPort"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
    }
    // optionalAttrs (res."protocol" != null) { inherit (res) "protocol"; }
    // {
    };
  LabelModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "source" = mkOption {
        description = "Source can be one of the above values (e.g.: LabelSourceContainer).";
        type = (types.nullOr types.str);
        default = null;
      };
      "value" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkLabel =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."source" != null) { inherit (res) "source"; }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  LogModule = types.submodule {
    options = {
      "value" = mkOption {
        description = "Value is a free-form string that is included in Hubble flows\nthat match this policy. The string is limited to 32 printable characters.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkLog =
    res:
    {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  NodeSelectorMatchExpressionModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the label key that the selector applies to.";
        type = types.str;
      };
      "operator" = mkOption {
        description = "operator represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists and DoesNotExist.";
        type = (
          types.enum [
            "In"
            "NotIn"
            "Exists"
            "DoesNotExist"
          ]
        );
      };
      "values" = mkOption {
        description = "values is an array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. This array is replaced during a strategic\nmerge patch.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkNodeSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  NodeSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf NodeSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkNodeSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkNodeSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  CiliumnetworkpoliciesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this CiliumNetworkPolicy resource.";
        };
        "description" = mkOption {
          description = "Description is a free form string, it can be used by the creator of\nthe rule to store human readable explanation of the purpose of this\nrule. Rules cannot be identified by comment.";
          type = (types.nullOr types.str);
          default = null;
        };
        "egress" = mkOption {
          description = "Egress is a list of EgressRule which are enforced at egress.\nIf omitted or empty, this rule does not apply at egress.";
          type = (types.listOf EgresModule);
          default = [ ];
        };
        "egressDeny" = mkOption {
          description = "EgressDeny is a list of EgressDenyRule which are enforced at egress.\nAny rule inserted here will be denied regardless of the allowed egress\nrules in the 'egress' field.\nIf omitted or empty, this rule does not apply at egress.";
          type = (types.listOf EgressDenyModule);
          default = [ ];
        };
        "enableDefaultDeny" = mkOption {
          description = "EnableDefaultDeny determines whether this policy configures the\nsubject endpoint(s) to have a default deny mode. If enabled,\nthis causes all traffic not explicitly allowed by a network policy\nto be dropped.\n\nIf not specified, the default is true for each traffic direction\nthat has rules, and false otherwise. For example, if a policy\nonly has Ingress or IngressDeny rules, then the default for\ningress is true and egress is false.\n\nIf multiple policies apply to an endpoint, that endpoint's default deny\nwill be enabled if any policy requests it.\n\nThis is useful for creating broad-based network policies that will not\ncause endpoints to enter default-deny mode.";
          type = (types.nullOr EnableDefaultDenyModule);
          default = null;
        };
        "endpointSelector" = mkOption {
          description = "EndpointSelector selects all endpoints which should be subject to\nthis rule. EndpointSelector and NodeSelector cannot be both empty and\nare mutually exclusive.";
          type = (types.nullOr EndpointSelectorModule);
          default = null;
        };
        "ingress" = mkOption {
          description = "Ingress is a list of IngressRule which are enforced at ingress.\nIf omitted or empty, this rule does not apply at ingress.";
          type = (types.listOf IngresModule);
          default = [ ];
        };
        "ingressDeny" = mkOption {
          description = "IngressDeny is a list of IngressDenyRule which are enforced at ingress.\nAny rule inserted here will be denied regardless of the allowed ingress\nrules in the 'ingress' field.\nIf omitted or empty, this rule does not apply at ingress.";
          type = (types.listOf IngressDenyModule);
          default = [ ];
        };
        "labels" = mkOption {
          description = "Labels is a list of optional strings which can be used to\nre-identify the rule or to store metadata. It is possible to lookup\nor delete strings based on labels. Labels are not required to be\nunique, multiple rules can have overlapping or identical labels.";
          type = (types.listOf LabelModule);
          default = [ ];
        };
        "log" = mkOption {
          description = "Log specifies custom policy-specific Hubble logging configuration.";
          type = (types.nullOr LogModule);
          default = null;
        };
        "nodeSelector" = mkOption {
          description = "NodeSelector selects all nodes which should be subject to this rule.\nEndpointSelector and NodeSelector cannot be both empty and are mutually\nexclusive. Can only be used in CiliumClusterwideNetworkPolicies.";
          type = (types.nullOr NodeSelectorModule);
          default = null;
        };
      };
    }
  );
  mkCiliumNetworkPolicy = name: res: {
    apiVersion = "cilium.io/v2";
    kind = "CiliumNetworkPolicy";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."description" != null) { inherit (res) "description"; }
    // {
    }
    // optionalAttrs (res."egress" != [ ]) { "egress" = map mkEgres res."egress"; }
    // {
    }
    // optionalAttrs (res."egressDeny" != [ ]) { "egressDeny" = map mkEgressDeny res."egressDeny"; }
    // {
    }
    // optionalAttrs (res."enableDefaultDeny" != null) {
      "enableDefaultDeny" = mkEnableDefaultDeny res."enableDefaultDeny";
    }
    // {
    }
    // optionalAttrs (res."endpointSelector" != null) {
      "endpointSelector" = mkEndpointSelector res."endpointSelector";
    }
    // {
    }
    // optionalAttrs (res."ingress" != [ ]) { "ingress" = map mkIngres res."ingress"; }
    // {
    }
    // optionalAttrs (res."ingressDeny" != [ ]) { "ingressDeny" = map mkIngressDeny res."ingressDeny"; }
    // {
    }
    // optionalAttrs (res."labels" != [ ]) { "labels" = map mkLabel res."labels"; }
    // {
    }
    // optionalAttrs (res."log" != null) { "log" = mkLog res."log"; }
    // {
    }
    // optionalAttrs (res."nodeSelector" != null) {
      "nodeSelector" = mkNodeSelector res."nodeSelector";
    }
    // {
    };
  };
  allResources = (mapAttrsToList mkCiliumNetworkPolicy cfg."ciliumnetworkpolicies");
in
{
  options.openkrill.apps."cilium" = {
    "ciliumnetworkpolicies" = mkOption {
      type = types.attrsOf CiliumnetworkpoliciesModule;
      default = { };
      description = "CiliumNetworkPolicy CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."cilium".content = allResources;
  };
}
