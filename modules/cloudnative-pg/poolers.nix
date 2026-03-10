# Auto-generated openkrill module fragment for cloudnative-pg
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."cloudnative-pg";
  compact = filterAttrs (_: v: v != null);
  ClusterModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkCluster = res: {
    inherit (res) "name";
  };
  DeploymentStrategyModule = types.submodule {
    options = {
      "rollingUpdate" = mkOption {
        description = "Rolling update config params. Present only if DeploymentStrategyType =\nRollingUpdate.";
        type = (types.nullOr DeploymentStrategyRollingUpdateModule);
        default = null;
      };
      "type" = mkOption {
        description = "Type of deployment. Can be \"Recreate\" or \"RollingUpdate\". Default is RollingUpdate.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDeploymentStrategy =
    res:
    {
    }
    // optionalAttrs (res."rollingUpdate" != null) {
      "rollingUpdate" = mkDeploymentStrategyRollingUpdate res."rollingUpdate";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  DeploymentStrategyRollingUpdateModule = types.submodule {
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
  mkDeploymentStrategyRollingUpdate =
    res:
    {
    }
    // optionalAttrs (res."maxSurge" != null) { inherit (res) "maxSurge"; }
    // {
    }
    // optionalAttrs (res."maxUnavailable" != null) { inherit (res) "maxUnavailable"; }
    // {
    };
  MonitoringModule = types.submodule {
    options = {
      "enablePodMonitor" = mkOption {
        description = "Enable or disable the `PodMonitor`";
        type = types.bool;
        default = false;
      };
      "podMonitorMetricRelabelings" = mkOption {
        description = "The list of metric relabelings for the `PodMonitor`. Applied to samples before ingestion.";
        type = (types.listOf MonitoringPodMonitorMetricRelabelingModule);
        default = [ ];
      };
      "podMonitorRelabelings" = mkOption {
        description = "The list of relabelings for the `PodMonitor`. Applied to samples before scraping.";
        type = (types.listOf MonitoringPodMonitorRelabelingModule);
        default = [ ];
      };
    };
  };
  mkMonitoring =
    res:
    {
    }
    // optionalAttrs res."enablePodMonitor" { inherit (res) "enablePodMonitor"; }
    // {
    }
    // optionalAttrs (res."podMonitorMetricRelabelings" != [ ]) {
      "podMonitorMetricRelabelings" =
        map mkMonitoringPodMonitorMetricRelabeling
          res."podMonitorMetricRelabelings";
    }
    // {
    }
    // optionalAttrs (res."podMonitorRelabelings" != [ ]) {
      "podMonitorRelabelings" = map mkMonitoringPodMonitorRelabeling res."podMonitorRelabelings";
    }
    // {
    };
  MonitoringPodMonitorMetricRelabelingModule = types.submodule {
    options = {
      "action" = mkOption {
        description = "action to perform based on the regex matching.\n\n`Uppercase` and `Lowercase` actions require Prometheus >= v2.36.0.\n`DropEqual` and `KeepEqual` actions require Prometheus >= v2.41.0.\n\nDefault: \"Replace\"";
        type = (
          types.nullOr (
            types.enum [
              "replace"
              "Replace"
              "keep"
              "Keep"
              "drop"
              "Drop"
              "hashmod"
              "HashMod"
              "labelmap"
              "LabelMap"
              "labeldrop"
              "LabelDrop"
              "labelkeep"
              "LabelKeep"
              "lowercase"
              "Lowercase"
              "uppercase"
              "Uppercase"
              "keepequal"
              "KeepEqual"
              "dropequal"
              "DropEqual"
            ]
          )
        );
        default = "replace";
      };
      "modulus" = mkOption {
        description = "modulus to take of the hash of the source label values.\n\nOnly applicable when the action is `HashMod`.";
        type = (types.nullOr types.int);
        default = null;
      };
      "regex" = mkOption {
        description = "regex defines the regular expression against which the extracted value is matched.";
        type = (types.nullOr types.str);
        default = null;
      };
      "replacement" = mkOption {
        description = "replacement value against which a Replace action is performed if the\nregular expression matches.\n\nRegex capture groups are available.";
        type = (types.nullOr types.str);
        default = null;
      };
      "separator" = mkOption {
        description = "separator defines the string between concatenated SourceLabels.";
        type = (types.nullOr types.str);
        default = null;
      };
      "sourceLabels" = mkOption {
        description = "sourceLabels defines the source labels select values from existing labels. Their content is\nconcatenated using the configured Separator and matched against the\nconfigured regular expression.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "targetLabel" = mkOption {
        description = "targetLabel defines the label to which the resulting string is written in a replacement.\n\nIt is mandatory for `Replace`, `HashMod`, `Lowercase`, `Uppercase`,\n`KeepEqual` and `DropEqual` actions.\n\nRegex capture groups are available.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkMonitoringPodMonitorMetricRelabeling =
    res:
    {
    }
    // optionalAttrs (res."action" != null) { inherit (res) "action"; }
    // {
    }
    // optionalAttrs (res."modulus" != null) { inherit (res) "modulus"; }
    // {
    }
    // optionalAttrs (res."regex" != null) { inherit (res) "regex"; }
    // {
    }
    // optionalAttrs (res."replacement" != null) { inherit (res) "replacement"; }
    // {
    }
    // optionalAttrs (res."separator" != null) { inherit (res) "separator"; }
    // {
    }
    // optionalAttrs (res."sourceLabels" != [ ]) { inherit (res) "sourceLabels"; }
    // {
    }
    // optionalAttrs (res."targetLabel" != null) { inherit (res) "targetLabel"; }
    // {
    };
  MonitoringPodMonitorRelabelingModule = types.submodule {
    options = {
      "action" = mkOption {
        description = "action to perform based on the regex matching.\n\n`Uppercase` and `Lowercase` actions require Prometheus >= v2.36.0.\n`DropEqual` and `KeepEqual` actions require Prometheus >= v2.41.0.\n\nDefault: \"Replace\"";
        type = (
          types.nullOr (
            types.enum [
              "replace"
              "Replace"
              "keep"
              "Keep"
              "drop"
              "Drop"
              "hashmod"
              "HashMod"
              "labelmap"
              "LabelMap"
              "labeldrop"
              "LabelDrop"
              "labelkeep"
              "LabelKeep"
              "lowercase"
              "Lowercase"
              "uppercase"
              "Uppercase"
              "keepequal"
              "KeepEqual"
              "dropequal"
              "DropEqual"
            ]
          )
        );
        default = "replace";
      };
      "modulus" = mkOption {
        description = "modulus to take of the hash of the source label values.\n\nOnly applicable when the action is `HashMod`.";
        type = (types.nullOr types.int);
        default = null;
      };
      "regex" = mkOption {
        description = "regex defines the regular expression against which the extracted value is matched.";
        type = (types.nullOr types.str);
        default = null;
      };
      "replacement" = mkOption {
        description = "replacement value against which a Replace action is performed if the\nregular expression matches.\n\nRegex capture groups are available.";
        type = (types.nullOr types.str);
        default = null;
      };
      "separator" = mkOption {
        description = "separator defines the string between concatenated SourceLabels.";
        type = (types.nullOr types.str);
        default = null;
      };
      "sourceLabels" = mkOption {
        description = "sourceLabels defines the source labels select values from existing labels. Their content is\nconcatenated using the configured Separator and matched against the\nconfigured regular expression.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "targetLabel" = mkOption {
        description = "targetLabel defines the label to which the resulting string is written in a replacement.\n\nIt is mandatory for `Replace`, `HashMod`, `Lowercase`, `Uppercase`,\n`KeepEqual` and `DropEqual` actions.\n\nRegex capture groups are available.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkMonitoringPodMonitorRelabeling =
    res:
    {
    }
    // optionalAttrs (res."action" != null) { inherit (res) "action"; }
    // {
    }
    // optionalAttrs (res."modulus" != null) { inherit (res) "modulus"; }
    // {
    }
    // optionalAttrs (res."regex" != null) { inherit (res) "regex"; }
    // {
    }
    // optionalAttrs (res."replacement" != null) { inherit (res) "replacement"; }
    // {
    }
    // optionalAttrs (res."separator" != null) { inherit (res) "separator"; }
    // {
    }
    // optionalAttrs (res."sourceLabels" != [ ]) { inherit (res) "sourceLabels"; }
    // {
    }
    // optionalAttrs (res."targetLabel" != null) { inherit (res) "targetLabel"; }
    // {
    };
  PgbouncerAuthQuerySecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkPgbouncerAuthQuerySecret = res: {
    inherit (res) "name";
  };
  PgbouncerClientCASecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkPgbouncerClientCASecret = res: {
    inherit (res) "name";
  };
  PgbouncerClientTLSSecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkPgbouncerClientTLSSecret = res: {
    inherit (res) "name";
  };
  PgbouncerModule = types.submodule {
    options = {
      "authQuery" = mkOption {
        description = "The query that will be used to download the hash of the password\nof a certain user. Default: \"SELECT usename, passwd FROM public.user_search($1)\".\nIn case it is specified, also an AuthQuerySecret has to be specified and\nno automatic CNPG Cluster integration will be triggered.";
        type = (types.nullOr types.str);
        default = null;
      };
      "authQuerySecret" = mkOption {
        description = "The credentials of the user that need to be used for the authentication\nquery. In case it is specified, also an AuthQuery\n(e.g. \"SELECT usename, passwd FROM pg_catalog.pg_shadow WHERE usename=$1\")\nhas to be specified and no automatic CNPG Cluster integration will be triggered.\n\nDeprecated.";
        type = (types.nullOr PgbouncerAuthQuerySecretModule);
        default = null;
      };
      "clientCASecret" = mkOption {
        description = "ClientCASecret provides PgBouncer’s client_tls_ca_file, the root\nCA for validating client certificates";
        type = (types.nullOr PgbouncerClientCASecretModule);
        default = null;
      };
      "clientTLSSecret" = mkOption {
        description = "ClientTLSSecret provides PgBouncer’s client_tls_key_file (private key)\nand client_tls_cert_file (certificate) used to accept client connections";
        type = (types.nullOr PgbouncerClientTLSSecretModule);
        default = null;
      };
      "parameters" = mkOption {
        description = "Additional parameters to be passed to PgBouncer - please check\nthe CNPG documentation for a list of options you can configure";
        type = (types.attrsOf types.str);
        default = { };
      };
      "paused" = mkOption {
        description = "When set to `true`, PgBouncer will disconnect from the PostgreSQL\nserver, first waiting for all queries to complete, and pause all new\nclient connections until this value is set to `false` (default). Internally,\nthe operator calls PgBouncer's `PAUSE` and `RESUME` commands.";
        type = types.bool;
        default = false;
      };
      "pg_hba" = mkOption {
        description = "PostgreSQL Host Based Authentication rules (lines to be appended\nto the pg_hba.conf file)";
        type = (types.listOf types.str);
        default = [ ];
      };
      "poolMode" = mkOption {
        description = "The pool mode. Default: `session`.";
        type = (
          types.nullOr (
            types.enum [
              "session"
              "transaction"
            ]
          )
        );
        default = "session";
      };
      "serverCASecret" = mkOption {
        description = "ServerCASecret provides PgBouncer’s server_tls_ca_file, the root\nCA for validating PostgreSQL certificates";
        type = (types.nullOr PgbouncerServerCASecretModule);
        default = null;
      };
      "serverTLSSecret" = mkOption {
        description = "ServerTLSSecret, when pointing to a TLS secret, provides pgbouncer's\n`server_tls_key_file` and `server_tls_cert_file`, used when\nauthenticating against PostgreSQL.";
        type = (types.nullOr PgbouncerServerTLSSecretModule);
        default = null;
      };
    };
  };
  mkPgbouncer =
    res:
    {
    }
    // optionalAttrs (res."authQuery" != null) { inherit (res) "authQuery"; }
    // {
    }
    // optionalAttrs (res."authQuerySecret" != null) {
      "authQuerySecret" = mkPgbouncerAuthQuerySecret res."authQuerySecret";
    }
    // {
    }
    // optionalAttrs (res."clientCASecret" != null) {
      "clientCASecret" = mkPgbouncerClientCASecret res."clientCASecret";
    }
    // {
    }
    // optionalAttrs (res."clientTLSSecret" != null) {
      "clientTLSSecret" = mkPgbouncerClientTLSSecret res."clientTLSSecret";
    }
    // {
    }
    // optionalAttrs (res."parameters" != { }) { inherit (res) "parameters"; }
    // {
    }
    // optionalAttrs res."paused" { inherit (res) "paused"; }
    // {
    }
    // optionalAttrs (res."pg_hba" != [ ]) { inherit (res) "pg_hba"; }
    // {
    }
    // optionalAttrs (res."poolMode" != null) { inherit (res) "poolMode"; }
    // {
    }
    // optionalAttrs (res."serverCASecret" != null) {
      "serverCASecret" = mkPgbouncerServerCASecret res."serverCASecret";
    }
    // {
    }
    // optionalAttrs (res."serverTLSSecret" != null) {
      "serverTLSSecret" = mkPgbouncerServerTLSSecret res."serverTLSSecret";
    }
    // {
    };
  PgbouncerServerCASecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkPgbouncerServerCASecret = res: {
    inherit (res) "name";
  };
  PgbouncerServerTLSSecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkPgbouncerServerTLSSecret = res: {
    inherit (res) "name";
  };
  ServiceTemplateMetadataModule = types.submodule {
    options = {
      "annotations" = mkOption {
        description = "Annotations is an unstructured key value map stored with a resource that may be\nset by external tools to store and retrieve arbitrary metadata. They are not\nqueryable and should be preserved when modifying objects.\nMore info: http://kubernetes.io/docs/user-guide/annotations";
        type = (types.attrsOf types.str);
        default = { };
      };
      "labels" = mkOption {
        description = "Map of string keys and values that can be used to organize and categorize\n(scope and select) objects. May match selectors of replication controllers\nand services.\nMore info: http://kubernetes.io/docs/user-guide/labels";
        type = (types.attrsOf types.str);
        default = { };
      };
      "name" = mkOption {
        description = "The name of the resource. Only supported for certain types";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkServiceTemplateMetadata =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ServiceTemplateModule = types.submodule {
    options = {
      "metadata" = mkOption {
        description = "Standard object's metadata.\nMore info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata";
        type = (types.nullOr ServiceTemplateMetadataModule);
        default = null;
      };
      "spec" = mkOption {
        description = "Specification of the desired behavior of the service.\nMore info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status";
        type = (types.nullOr ServiceTemplateSpecModule);
        default = null;
      };
    };
  };
  mkServiceTemplate =
    res:
    {
    }
    // optionalAttrs (res."metadata" != null) { "metadata" = mkServiceTemplateMetadata res."metadata"; }
    // {
    }
    // optionalAttrs (res."spec" != null) { "spec" = mkServiceTemplateSpec res."spec"; }
    // {
    };
  ServiceTemplateSpecModule = types.submodule {
    options = {
      "allocateLoadBalancerNodePorts" = mkOption {
        description = "allocateLoadBalancerNodePorts defines if NodePorts will be automatically\nallocated for services with type LoadBalancer.  Default is \"true\". It\nmay be set to \"false\" if the cluster load-balancer does not rely on\nNodePorts.  If the caller requests specific NodePorts (by specifying a\nvalue), those requests will be respected, regardless of this field.\nThis field may only be set for services with type LoadBalancer and will\nbe cleared if the type is changed to any other type.";
        type = types.bool;
        default = false;
      };
      "clusterIP" = mkOption {
        description = "clusterIP is the IP address of the service and is usually assigned\nrandomly. If an address is specified manually, is in-range (as per\nsystem configuration), and is not in use, it will be allocated to the\nservice; otherwise creation of the service will fail. This field may not\nbe changed through updates unless the type field is also being changed\nto ExternalName (which requires this field to be blank) or the type\nfield is being changed from ExternalName (in which case this field may\noptionally be specified, as describe above).  Valid values are \"None\",\nempty string (\"\"), or a valid IP address. Setting this to \"None\" makes a\n\"headless service\" (no virtual IP), which is useful when direct endpoint\nconnections are preferred and proxying is not required.  Only applies to\ntypes ClusterIP, NodePort, and LoadBalancer. If this field is specified\nwhen creating a Service of type ExternalName, creation will fail. This\nfield will be wiped when updating a Service to type ExternalName.\nMore info: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies";
        type = (types.nullOr types.str);
        default = null;
      };
      "clusterIPs" = mkOption {
        description = "ClusterIPs is a list of IP addresses assigned to this service, and are\nusually assigned randomly.  If an address is specified manually, is\nin-range (as per system configuration), and is not in use, it will be\nallocated to the service; otherwise creation of the service will fail.\nThis field may not be changed through updates unless the type field is\nalso being changed to ExternalName (which requires this field to be\nempty) or the type field is being changed from ExternalName (in which\ncase this field may optionally be specified, as describe above).  Valid\nvalues are \"None\", empty string (\"\"), or a valid IP address.  Setting\nthis to \"None\" makes a \"headless service\" (no virtual IP), which is\nuseful when direct endpoint connections are preferred and proxying is\nnot required.  Only applies to types ClusterIP, NodePort, and\nLoadBalancer. If this field is specified when creating a Service of type\nExternalName, creation will fail. This field will be wiped when updating\na Service to type ExternalName.  If this field is not specified, it will\nbe initialized from the clusterIP field.  If this field is specified,\nclients must ensure that clusterIPs[0] and clusterIP have the same\nvalue.\n\nThis field may hold a maximum of two entries (dual-stack IPs, in either order).\nThese IPs must correspond to the values of the ipFamilies field. Both\nclusterIPs and ipFamilies are governed by the ipFamilyPolicy field.\nMore info: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies";
        type = (types.listOf types.str);
        default = [ ];
      };
      "externalIPs" = mkOption {
        description = "externalIPs is a list of IP addresses for which nodes in the cluster\nwill also accept traffic for this service.  These IPs are not managed by\nKubernetes.  The user is responsible for ensuring that traffic arrives\nat a node with this IP.  A common example is external load-balancers\nthat are not part of the Kubernetes system.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "externalName" = mkOption {
        description = "externalName is the external reference that discovery mechanisms will\nreturn as an alias for this service (e.g. a DNS CNAME record). No\nproxying will be involved.  Must be a lowercase RFC-1123 hostname\n(https://tools.ietf.org/html/rfc1123) and requires `type` to be \"ExternalName\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "externalTrafficPolicy" = mkOption {
        description = "externalTrafficPolicy describes how nodes distribute service traffic they\nreceive on one of the Service's \"externally-facing\" addresses (NodePorts,\nExternalIPs, and LoadBalancer IPs). If set to \"Local\", the proxy will configure\nthe service in a way that assumes that external load balancers will take care\nof balancing the service traffic between nodes, and so each node will deliver\ntraffic only to the node-local endpoints of the service, without masquerading\nthe client source IP. (Traffic mistakenly sent to a node with no endpoints will\nbe dropped.) The default value, \"Cluster\", uses the standard behavior of\nrouting to all endpoints evenly (possibly modified by topology and other\nfeatures). Note that traffic sent to an External IP or LoadBalancer IP from\nwithin the cluster will always get \"Cluster\" semantics, but clients sending to\na NodePort from within the cluster may need to take traffic policy into account\nwhen picking a node.";
        type = (types.nullOr types.str);
        default = null;
      };
      "healthCheckNodePort" = mkOption {
        description = "healthCheckNodePort specifies the healthcheck nodePort for the service.\nThis only applies when type is set to LoadBalancer and\nexternalTrafficPolicy is set to Local. If a value is specified, is\nin-range, and is not in use, it will be used.  If not specified, a value\nwill be automatically allocated.  External systems (e.g. load-balancers)\ncan use this port to determine if a given node holds endpoints for this\nservice or not.  If this field is specified when creating a Service\nwhich does not need it, creation will fail. This field will be wiped\nwhen updating a Service to no longer need it (e.g. changing type).\nThis field cannot be updated once set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "internalTrafficPolicy" = mkOption {
        description = "InternalTrafficPolicy describes how nodes distribute service traffic they\nreceive on the ClusterIP. If set to \"Local\", the proxy will assume that pods\nonly want to talk to endpoints of the service on the same node as the pod,\ndropping the traffic if there are no local endpoints. The default value,\n\"Cluster\", uses the standard behavior of routing to all endpoints evenly\n(possibly modified by topology and other features).";
        type = (types.nullOr types.str);
        default = null;
      };
      "ipFamilies" = mkOption {
        description = "IPFamilies is a list of IP families (e.g. IPv4, IPv6) assigned to this\nservice. This field is usually assigned automatically based on cluster\nconfiguration and the ipFamilyPolicy field. If this field is specified\nmanually, the requested family is available in the cluster,\nand ipFamilyPolicy allows it, it will be used; otherwise creation of\nthe service will fail. This field is conditionally mutable: it allows\nfor adding or removing a secondary IP family, but it does not allow\nchanging the primary IP family of the Service. Valid values are \"IPv4\"\nand \"IPv6\".  This field only applies to Services of types ClusterIP,\nNodePort, and LoadBalancer, and does apply to \"headless\" services.\nThis field will be wiped when updating a Service to type ExternalName.\n\nThis field may hold a maximum of two entries (dual-stack families, in\neither order).  These families must correspond to the values of the\nclusterIPs field, if specified. Both clusterIPs and ipFamilies are\ngoverned by the ipFamilyPolicy field.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "ipFamilyPolicy" = mkOption {
        description = "IPFamilyPolicy represents the dual-stack-ness requested or required by\nthis Service. If there is no value provided, then this field will be set\nto SingleStack. Services can be \"SingleStack\" (a single IP family),\n\"PreferDualStack\" (two IP families on dual-stack configured clusters or\na single IP family on single-stack clusters), or \"RequireDualStack\"\n(two IP families on dual-stack configured clusters, otherwise fail). The\nipFamilies and clusterIPs fields depend on the value of this field. This\nfield will be wiped when updating a service to type ExternalName.";
        type = (types.nullOr types.str);
        default = null;
      };
      "loadBalancerClass" = mkOption {
        description = "loadBalancerClass is the class of the load balancer implementation this Service belongs to.\nIf specified, the value of this field must be a label-style identifier, with an optional prefix,\ne.g. \"internal-vip\" or \"example.com/internal-vip\". Unprefixed names are reserved for end-users.\nThis field can only be set when the Service type is 'LoadBalancer'. If not set, the default load\nbalancer implementation is used, today this is typically done through the cloud provider integration,\nbut should apply for any default implementation. If set, it is assumed that a load balancer\nimplementation is watching for Services with a matching class. Any default load balancer\nimplementation (e.g. cloud providers) should ignore Services that set this field.\nThis field can only be set when creating or updating a Service to type 'LoadBalancer'.\nOnce set, it can not be changed. This field will be wiped when a service is updated to a non 'LoadBalancer' type.";
        type = (types.nullOr types.str);
        default = null;
      };
      "loadBalancerIP" = mkOption {
        description = "Only applies to Service Type: LoadBalancer.\nThis feature depends on whether the underlying cloud-provider supports specifying\nthe loadBalancerIP when a load balancer is created.\nThis field will be ignored if the cloud-provider does not support the feature.\nDeprecated: This field was under-specified and its meaning varies across implementations.\nUsing it is non-portable and it may not support dual-stack.\nUsers are encouraged to use implementation-specific annotations when available.";
        type = (types.nullOr types.str);
        default = null;
      };
      "loadBalancerSourceRanges" = mkOption {
        description = "If specified and supported by the platform, this will restrict traffic through the cloud-provider\nload-balancer will be restricted to the specified client IPs. This field will be ignored if the\ncloud-provider does not support the feature.\"\nMore info: https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/";
        type = (types.listOf types.str);
        default = [ ];
      };
      "ports" = mkOption {
        description = "The list of ports that are exposed by this service.\nMore info: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies";
        type = (types.listOf ServiceTemplateSpecPortModule);
        default = [ ];
      };
      "publishNotReadyAddresses" = mkOption {
        description = "publishNotReadyAddresses indicates that any agent which deals with endpoints for this\nService should disregard any indications of ready/not-ready.\nThe primary use case for setting this field is for a StatefulSet's Headless Service to\npropagate SRV DNS records for its Pods for the purpose of peer discovery.\nThe Kubernetes controllers that generate Endpoints and EndpointSlice resources for\nServices interpret this to mean that all endpoints are considered \"ready\" even if the\nPods themselves are not. Agents which consume only Kubernetes generated endpoints\nthrough the Endpoints or EndpointSlice resources can safely assume this behavior.";
        type = types.bool;
        default = false;
      };
      "selector" = mkOption {
        description = "Route service traffic to pods with label keys and values matching this\nselector. If empty or not present, the service is assumed to have an\nexternal process managing its endpoints, which Kubernetes will not\nmodify. Only applies to types ClusterIP, NodePort, and LoadBalancer.\nIgnored if type is ExternalName.\nMore info: https://kubernetes.io/docs/concepts/services-networking/service/";
        type = (types.attrsOf types.str);
        default = { };
      };
      "sessionAffinity" = mkOption {
        description = "Supports \"ClientIP\" and \"None\". Used to maintain session affinity.\nEnable client IP based session affinity.\nMust be ClientIP or None.\nDefaults to None.\nMore info: https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies";
        type = (types.nullOr types.str);
        default = null;
      };
      "sessionAffinityConfig" = mkOption {
        description = "sessionAffinityConfig contains the configurations of session affinity.";
        type = (types.nullOr ServiceTemplateSpecSessionAffinityConfigModule);
        default = null;
      };
      "trafficDistribution" = mkOption {
        description = "TrafficDistribution offers a way to express preferences for how traffic\nis distributed to Service endpoints. Implementations can use this field\nas a hint, but are not required to guarantee strict adherence. If the\nfield is not set, the implementation will apply its default routing\nstrategy. If set to \"PreferClose\", implementations should prioritize\nendpoints that are in the same zone.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "type determines how the Service is exposed. Defaults to ClusterIP. Valid\noptions are ExternalName, ClusterIP, NodePort, and LoadBalancer.\n\"ClusterIP\" allocates a cluster-internal IP address for load-balancing\nto endpoints. Endpoints are determined by the selector or if that is not\nspecified, by manual construction of an Endpoints object or\nEndpointSlice objects. If clusterIP is \"None\", no virtual IP is\nallocated and the endpoints are published as a set of endpoints rather\nthan a virtual IP.\n\"NodePort\" builds on ClusterIP and allocates a port on every node which\nroutes to the same endpoints as the clusterIP.\n\"LoadBalancer\" builds on NodePort and creates an external load-balancer\n(if supported in the current cloud) which routes to the same endpoints\nas the clusterIP.\n\"ExternalName\" aliases this service to the specified externalName.\nSeveral other fields do not apply to ExternalName services.\nMore info: https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkServiceTemplateSpec =
    res:
    {
    }
    // optionalAttrs res."allocateLoadBalancerNodePorts" {
      inherit (res) "allocateLoadBalancerNodePorts";
    }
    // {
    }
    // optionalAttrs (res."clusterIP" != null) { inherit (res) "clusterIP"; }
    // {
    }
    // optionalAttrs (res."clusterIPs" != [ ]) { inherit (res) "clusterIPs"; }
    // {
    }
    // optionalAttrs (res."externalIPs" != [ ]) { inherit (res) "externalIPs"; }
    // {
    }
    // optionalAttrs (res."externalName" != null) { inherit (res) "externalName"; }
    // {
    }
    // optionalAttrs (res."externalTrafficPolicy" != null) { inherit (res) "externalTrafficPolicy"; }
    // {
    }
    // optionalAttrs (res."healthCheckNodePort" != null) { inherit (res) "healthCheckNodePort"; }
    // {
    }
    // optionalAttrs (res."internalTrafficPolicy" != null) { inherit (res) "internalTrafficPolicy"; }
    // {
    }
    // optionalAttrs (res."ipFamilies" != [ ]) { inherit (res) "ipFamilies"; }
    // {
    }
    // optionalAttrs (res."ipFamilyPolicy" != null) { inherit (res) "ipFamilyPolicy"; }
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
    // optionalAttrs (res."ports" != [ ]) { "ports" = map mkServiceTemplateSpecPort res."ports"; }
    // {
    }
    // optionalAttrs res."publishNotReadyAddresses" { inherit (res) "publishNotReadyAddresses"; }
    // {
    }
    // optionalAttrs (res."selector" != { }) { inherit (res) "selector"; }
    // {
    }
    // optionalAttrs (res."sessionAffinity" != null) { inherit (res) "sessionAffinity"; }
    // {
    }
    // optionalAttrs (res."sessionAffinityConfig" != null) {
      "sessionAffinityConfig" = mkServiceTemplateSpecSessionAffinityConfig res."sessionAffinityConfig";
    }
    // {
    }
    // optionalAttrs (res."trafficDistribution" != null) { inherit (res) "trafficDistribution"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ServiceTemplateSpecPortModule = types.submodule {
    options = {
      "appProtocol" = mkOption {
        description = "The application protocol for this port.\nThis is used as a hint for implementations to offer richer behavior for protocols that they understand.\nThis field follows standard Kubernetes label syntax.\nValid values are either:\n\n* Un-prefixed protocol names - reserved for IANA standard service names (as per\nRFC-6335 and https://www.iana.org/assignments/service-names).\n\n* Kubernetes-defined prefixed names:\n  * 'kubernetes.io/h2c' - HTTP/2 prior knowledge over cleartext as described in https://www.rfc-editor.org/rfc/rfc9113.html#name-starting-http-2-with-prior-\n  * 'kubernetes.io/ws'  - WebSocket over cleartext as described in https://www.rfc-editor.org/rfc/rfc6455\n  * 'kubernetes.io/wss' - WebSocket over TLS as described in https://www.rfc-editor.org/rfc/rfc6455\n\n* Other protocols should use implementation-defined prefixed names such as\nmycompany.com/my-custom-protocol.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "The name of this port within the service. This must be a DNS_LABEL.\nAll ports within a ServiceSpec must have unique names. When considering\nthe endpoints for a Service, this must match the 'name' field in the\nEndpointPort.\nOptional if only one ServicePort is defined on this service.";
        type = (types.nullOr types.str);
        default = null;
      };
      "nodePort" = mkOption {
        description = "The port on each node on which this service is exposed when type is\nNodePort or LoadBalancer.  Usually assigned by the system. If a value is\nspecified, in-range, and not in use it will be used, otherwise the\noperation will fail.  If not specified, a port will be allocated if this\nService requires one.  If this field is specified when creating a\nService which does not need it, creation will fail. This field will be\nwiped when updating a Service to no longer need it (e.g. changing type\nfrom NodePort to ClusterIP).\nMore info: https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport";
        type = (types.nullOr types.int);
        default = null;
      };
      "port" = mkOption {
        description = "The port that will be exposed by this service.";
        type = types.int;
      };
      "protocol" = mkOption {
        description = "The IP protocol for this port. Supports \"TCP\", \"UDP\", and \"SCTP\".\nDefault is TCP.";
        type = (types.nullOr types.str);
        default = "TCP";
      };
      "targetPort" = mkOption {
        description = "Number or name of the port to access on the pods targeted by the service.\nNumber must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.\nIf this is a string, it will be looked up as a named port in the\ntarget Pod's container ports. If this is not specified, the value\nof the 'port' field is used (an identity map).\nThis field is ignored for services with clusterIP=None, and should be\nomitted or set equal to the 'port' field.\nMore info: https://kubernetes.io/docs/concepts/services-networking/service/#defining-a-service";
        type = types.anything;
        default = { };
      };
    };
  };
  mkServiceTemplateSpecPort =
    res:
    {
    }
    // optionalAttrs (res."appProtocol" != null) { inherit (res) "appProtocol"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."nodePort" != null) { inherit (res) "nodePort"; }
    // {
      inherit (res) "port";
    }
    // optionalAttrs (res."protocol" != null) { inherit (res) "protocol"; }
    // {
    }
    // optionalAttrs (res."targetPort" != null) { inherit (res) "targetPort"; }
    // {
    };
  ServiceTemplateSpecSessionAffinityConfigClientIPModule = types.submodule {
    options = {
      "timeoutSeconds" = mkOption {
        description = "timeoutSeconds specifies the seconds of ClientIP type session sticky time.\nThe value must be >0 && <=86400(for 1 day) if ServiceAffinity == \"ClientIP\".\nDefault value is 10800(for 3 hours).";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkServiceTemplateSpecSessionAffinityConfigClientIP =
    res:
    {
    }
    // optionalAttrs (res."timeoutSeconds" != null) { inherit (res) "timeoutSeconds"; }
    // {
    };
  ServiceTemplateSpecSessionAffinityConfigModule = types.submodule {
    options = {
      "clientIP" = mkOption {
        description = "clientIP contains the configurations of Client IP based session affinity.";
        type = (types.nullOr ServiceTemplateSpecSessionAffinityConfigClientIPModule);
        default = null;
      };
    };
  };
  mkServiceTemplateSpecSessionAffinityConfig =
    res:
    {
    }
    // optionalAttrs (res."clientIP" != null) {
      "clientIP" = mkServiceTemplateSpecSessionAffinityConfigClientIP res."clientIP";
    }
    // {
    };
  TemplateMetadataModule = types.submodule {
    options = {
      "annotations" = mkOption {
        description = "Annotations is an unstructured key value map stored with a resource that may be\nset by external tools to store and retrieve arbitrary metadata. They are not\nqueryable and should be preserved when modifying objects.\nMore info: http://kubernetes.io/docs/user-guide/annotations";
        type = (types.attrsOf types.str);
        default = { };
      };
      "labels" = mkOption {
        description = "Map of string keys and values that can be used to organize and categorize\n(scope and select) objects. May match selectors of replication controllers\nand services.\nMore info: http://kubernetes.io/docs/user-guide/labels";
        type = (types.attrsOf types.str);
        default = { };
      };
      "name" = mkOption {
        description = "The name of the resource. Only supported for certain types";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTemplateMetadata =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  TemplateModule = types.submodule {
    options = {
      "metadata" = mkOption {
        description = "Standard object's metadata.\nMore info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata";
        type = (types.nullOr TemplateMetadataModule);
        default = null;
      };
      "spec" = mkOption {
        description = "Specification of the desired behavior of the pod.\nMore info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status";
        type = (types.nullOr TemplateSpecModule);
        default = null;
      };
    };
  };
  mkTemplate =
    res:
    {
    }
    // optionalAttrs (res."metadata" != null) { "metadata" = mkTemplateMetadata res."metadata"; }
    // {
    }
    // optionalAttrs (res."spec" != null) { "spec" = mkTemplateSpec res."spec"; }
    // {
    };
  TemplateSpecAffinityModule = types.submodule {
    options = {
      "nodeAffinity" = mkOption {
        description = "Describes node affinity scheduling rules for the pod.";
        type = (types.nullOr TemplateSpecAffinityNodeAffinityModule);
        default = null;
      };
      "podAffinity" = mkOption {
        description = "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s)).";
        type = (types.nullOr TemplateSpecAffinityPodAffinityModule);
        default = null;
      };
      "podAntiAffinity" = mkOption {
        description = "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s)).";
        type = (types.nullOr TemplateSpecAffinityPodAntiAffinityModule);
        default = null;
      };
    };
  };
  mkTemplateSpecAffinity =
    res:
    {
    }
    // optionalAttrs (res."nodeAffinity" != null) {
      "nodeAffinity" = mkTemplateSpecAffinityNodeAffinity res."nodeAffinity";
    }
    // {
    }
    // optionalAttrs (res."podAffinity" != null) {
      "podAffinity" = mkTemplateSpecAffinityPodAffinity res."podAffinity";
    }
    // {
    }
    // optionalAttrs (res."podAntiAffinity" != null) {
      "podAntiAffinity" = mkTemplateSpecAffinityPodAntiAffinity res."podAntiAffinity";
    }
    // {
    };
  TemplateSpecAffinityNodeAffinityModule = types.submodule {
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy\nthe affinity expressions specified by this field, but it may choose\na node that violates one or more of the expressions. The node that is\nmost preferred is the one with the greatest sum of weights, i.e.\nfor each node that meets all of the scheduling requirements (resource\nrequest, requiredDuringScheduling affinity expressions, etc.),\ncompute a sum by iterating through the elements of this field and adding\n\"weight\" to the sum if the node matches the corresponding matchExpressions; the\nnode(s) with the highest sum are the most preferred.";
        type = (
          types.listOf TemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the affinity requirements specified by this field are not met at\nscheduling time, the pod will not be scheduled onto the node.\nIf the affinity requirements specified by this field cease to be met\nat some point during pod execution (e.g. due to an update), the system\nmay or may not try to eventually evict the pod from its node.";
        type = (
          types.nullOr TemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = null;
      };
    };
  };
  mkTemplateSpecAffinityNodeAffinity =
    res:
    {
    }
    // optionalAttrs (res."preferredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "preferredDuringSchedulingIgnoredDuringExecution" =
        map mkTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecution
          res."preferredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    }
    // optionalAttrs (res."requiredDuringSchedulingIgnoredDuringExecution" != null) {
      "requiredDuringSchedulingIgnoredDuringExecution" =
        mkTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecution
          res."requiredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    };
  TemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "preference" = mkOption {
            description = "A node selector term, associated with the corresponding weight.";
            type =
              TemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceModule;
          };
          "weight" = mkOption {
            description = "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100.";
            type = types.int;
          };
        };
      };
  mkTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecution = res: {
    "preference" =
      mkTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreference
        res."preference";
    inherit (res) "weight";
  };
  TemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpressionModule =
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
  mkTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  TemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchFieldModule =
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
  mkTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchField =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  TemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "A list of node selector requirements by node's labels.";
            type = (
              types.listOf TemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpressionModule
            );
            default = [ ];
          };
          "matchFields" = mkOption {
            description = "A list of node selector requirements by node's fields.";
            type = (
              types.listOf TemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchFieldModule
            );
            default = [ ];
          };
        };
      };
  mkTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreference =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchFields" != [ ]) {
      "matchFields" =
        map
          mkTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchField
          res."matchFields";
    }
    // {
    };
  TemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "nodeSelectorTerms" = mkOption {
            description = "Required. A list of node selector terms. The terms are ORed.";
            type = (
              types.listOf TemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermModule
            );
          };
        };
      };
  mkTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecution = res: {
    "nodeSelectorTerms" =
      map mkTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTerm
        res."nodeSelectorTerms";
  };
  TemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpressionModule =
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
  mkTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  TemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchFieldModule =
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
  mkTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchField =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  TemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "A list of node selector requirements by node's labels.";
            type = (
              types.listOf TemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpressionModule
            );
            default = [ ];
          };
          "matchFields" = mkOption {
            description = "A list of node selector requirements by node's fields.";
            type = (
              types.listOf TemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchFieldModule
            );
            default = [ ];
          };
        };
      };
  mkTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTerm =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchFields" != [ ]) {
      "matchFields" =
        map
          mkTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchField
          res."matchFields";
    }
    // {
    };
  TemplateSpecAffinityPodAffinityModule = types.submodule {
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy\nthe affinity expressions specified by this field, but it may choose\na node that violates one or more of the expressions. The node that is\nmost preferred is the one with the greatest sum of weights, i.e.\nfor each node that meets all of the scheduling requirements (resource\nrequest, requiredDuringScheduling affinity expressions, etc.),\ncompute a sum by iterating through the elements of this field and adding\n\"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the\nnode(s) with the highest sum are the most preferred.";
        type = (
          types.listOf TemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the affinity requirements specified by this field are not met at\nscheduling time, the pod will not be scheduled onto the node.\nIf the affinity requirements specified by this field cease to be met\nat some point during pod execution (e.g. due to a pod label update), the\nsystem may or may not try to eventually evict the pod from its node.\nWhen there are multiple elements, the lists of nodes corresponding to each\npodAffinityTerm are intersected, i.e. all terms must be satisfied.";
        type = (
          types.listOf TemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
    };
  };
  mkTemplateSpecAffinityPodAffinity =
    res:
    {
    }
    // optionalAttrs (res."preferredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "preferredDuringSchedulingIgnoredDuringExecution" =
        map mkTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecution
          res."preferredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    }
    // optionalAttrs (res."requiredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "requiredDuringSchedulingIgnoredDuringExecution" =
        map mkTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecution
          res."requiredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    };
  TemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "podAffinityTerm" = mkOption {
            description = "Required. A pod affinity term, associated with the corresponding weight.";
            type =
              TemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule;
          };
          "weight" = mkOption {
            description = "weight associated with matching the corresponding podAffinityTerm,\nin the range 1-100.";
            type = types.int;
          };
        };
      };
  mkTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecution = res: {
    "podAffinityTerm" =
      mkTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm
        res."podAffinityTerm";
    inherit (res) "weight";
  };
  TemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule =
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
  mkTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  TemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf TemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule
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
  mkTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  TemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.\nIf it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr TemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule
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
              types.nullOr TemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule
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
  mkTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector
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
        mkTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  TemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule =
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
  mkTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  TemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf TemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule
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
  mkTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  TemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule =
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
  mkTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  TemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf TemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule
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
  mkTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  TemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.\nIf it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr TemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule
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
              types.nullOr TemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule
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
  mkTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecution =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector
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
        mkTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  TemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule =
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
  mkTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  TemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf TemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule
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
  mkTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  TemplateSpecAffinityPodAntiAffinityModule = types.submodule {
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy\nthe anti-affinity expressions specified by this field, but it may choose\na node that violates one or more of the expressions. The node that is\nmost preferred is the one with the greatest sum of weights, i.e.\nfor each node that meets all of the scheduling requirements (resource\nrequest, requiredDuringScheduling anti-affinity expressions, etc.),\ncompute a sum by iterating through the elements of this field and subtracting\n\"weight\" from the sum if the node has pods which matches the corresponding podAffinityTerm; the\nnode(s) with the highest sum are the most preferred.";
        type = (
          types.listOf TemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the anti-affinity requirements specified by this field are not met at\nscheduling time, the pod will not be scheduled onto the node.\nIf the anti-affinity requirements specified by this field cease to be met\nat some point during pod execution (e.g. due to a pod label update), the\nsystem may or may not try to eventually evict the pod from its node.\nWhen there are multiple elements, the lists of nodes corresponding to each\npodAffinityTerm are intersected, i.e. all terms must be satisfied.";
        type = (
          types.listOf TemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
    };
  };
  mkTemplateSpecAffinityPodAntiAffinity =
    res:
    {
    }
    // optionalAttrs (res."preferredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "preferredDuringSchedulingIgnoredDuringExecution" =
        map mkTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecution
          res."preferredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    }
    // optionalAttrs (res."requiredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "requiredDuringSchedulingIgnoredDuringExecution" =
        map mkTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecution
          res."requiredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    };
  TemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "podAffinityTerm" = mkOption {
            description = "Required. A pod affinity term, associated with the corresponding weight.";
            type =
              TemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule;
          };
          "weight" = mkOption {
            description = "weight associated with matching the corresponding podAffinityTerm,\nin the range 1-100.";
            type = types.int;
          };
        };
      };
  mkTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecution = res: {
    "podAffinityTerm" =
      mkTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm
        res."podAffinityTerm";
    inherit (res) "weight";
  };
  TemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule =
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
  mkTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  TemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf TemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule
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
  mkTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  TemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.\nIf it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr TemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule
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
              types.nullOr TemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule
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
  mkTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector
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
        mkTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  TemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule =
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
  mkTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  TemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf TemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule
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
  mkTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  TemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule =
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
  mkTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  TemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf TemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule
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
  mkTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  TemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.\nIf it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr TemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule
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
              types.nullOr TemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule
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
  mkTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecution =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector
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
        mkTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  TemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule =
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
  mkTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  TemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf TemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule
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
  mkTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  TemplateSpecContainerEnvFromConfigMapRefModule = types.submodule {
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
  mkTemplateSpecContainerEnvFromConfigMapRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TemplateSpecContainerEnvFromModule = types.submodule {
    options = {
      "configMapRef" = mkOption {
        description = "The ConfigMap to select from";
        type = (types.nullOr TemplateSpecContainerEnvFromConfigMapRefModule);
        default = null;
      };
      "prefix" = mkOption {
        description = "Optional text to prepend to the name of each environment variable.\nMay consist of any printable ASCII characters except '='.";
        type = (types.nullOr types.str);
        default = null;
      };
      "secretRef" = mkOption {
        description = "The Secret to select from";
        type = (types.nullOr TemplateSpecContainerEnvFromSecretRefModule);
        default = null;
      };
    };
  };
  mkTemplateSpecContainerEnvFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapRef" != null) {
      "configMapRef" = mkTemplateSpecContainerEnvFromConfigMapRef res."configMapRef";
    }
    // {
    }
    // optionalAttrs (res."prefix" != null) { inherit (res) "prefix"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkTemplateSpecContainerEnvFromSecretRef res."secretRef";
    }
    // {
    };
  TemplateSpecContainerEnvFromSecretRefModule = types.submodule {
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
  mkTemplateSpecContainerEnvFromSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TemplateSpecContainerEnvModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the environment variable.\nMay consist of any printable ASCII characters except '='.";
        type = types.str;
      };
      "value" = mkOption {
        description = "Variable references $(VAR_NAME) are expanded\nusing the previously defined environment variables in the container and\nany service environment variables. If a variable cannot be resolved,\nthe reference in the input string will be unchanged. Double $$ are reduced\nto a single $, which allows for escaping the $(VAR_NAME) syntax: i.e.\n\"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\".\nEscaped references will never be expanded, regardless of whether the variable\nexists or not.\nDefaults to \"\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "valueFrom" = mkOption {
        description = "Source for the environment variable's value. Cannot be used if value is not empty.";
        type = (types.nullOr TemplateSpecContainerEnvValueFromModule);
        default = null;
      };
    };
  };
  mkTemplateSpecContainerEnv =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    }
    // optionalAttrs (res."valueFrom" != null) {
      "valueFrom" = mkTemplateSpecContainerEnvValueFrom res."valueFrom";
    }
    // {
    };
  TemplateSpecContainerEnvValueFromConfigMapKeyRefModule = types.submodule {
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
  mkTemplateSpecContainerEnvValueFromConfigMapKeyRef =
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
  TemplateSpecContainerEnvValueFromFieldRefModule = types.submodule {
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
  mkTemplateSpecContainerEnvValueFromFieldRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "fieldPath";
    };
  TemplateSpecContainerEnvValueFromFileKeyRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key within the env file. An invalid key will prevent the pod from starting.\nThe keys defined within a source may consist of any printable ASCII characters except '='.\nDuring Alpha stage of the EnvFiles feature gate, the key size is limited to 128 characters.";
        type = types.str;
      };
      "optional" = mkOption {
        description = "Specify whether the file or its key must be defined. If the file or key\ndoes not exist, then the env var is not published.\nIf optional is set to true and the specified key does not exist,\nthe environment variable will not be set in the Pod's containers.\n\nIf optional is set to false and the specified key does not exist,\nan error will be returned during Pod creation.";
        type = types.bool;
        default = false;
      };
      "path" = mkOption {
        description = "The path within the volume from which to select the file.\nMust be relative and may not contain the '..' path or start with '..'.";
        type = types.str;
      };
      "volumeName" = mkOption {
        description = "The name of the volume mount containing the env file.";
        type = types.str;
      };
    };
  };
  mkTemplateSpecContainerEnvValueFromFileKeyRef =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
      inherit (res) "path";
      inherit (res) "volumeName";
    };
  TemplateSpecContainerEnvValueFromModule = types.submodule {
    options = {
      "configMapKeyRef" = mkOption {
        description = "Selects a key of a ConfigMap.";
        type = (types.nullOr TemplateSpecContainerEnvValueFromConfigMapKeyRefModule);
        default = null;
      };
      "fieldRef" = mkOption {
        description = "Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`,\nspec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs.";
        type = (types.nullOr TemplateSpecContainerEnvValueFromFieldRefModule);
        default = null;
      };
      "fileKeyRef" = mkOption {
        description = "FileKeyRef selects a key of the env file.\nRequires the EnvFiles feature gate to be enabled.";
        type = (types.nullOr TemplateSpecContainerEnvValueFromFileKeyRefModule);
        default = null;
      };
      "resourceFieldRef" = mkOption {
        description = "Selects a resource of the container: only resources limits and requests\n(limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported.";
        type = (types.nullOr TemplateSpecContainerEnvValueFromResourceFieldRefModule);
        default = null;
      };
      "secretKeyRef" = mkOption {
        description = "Selects a key of a secret in the pod's namespace";
        type = (types.nullOr TemplateSpecContainerEnvValueFromSecretKeyRefModule);
        default = null;
      };
    };
  };
  mkTemplateSpecContainerEnvValueFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapKeyRef" != null) {
      "configMapKeyRef" = mkTemplateSpecContainerEnvValueFromConfigMapKeyRef res."configMapKeyRef";
    }
    // {
    }
    // optionalAttrs (res."fieldRef" != null) {
      "fieldRef" = mkTemplateSpecContainerEnvValueFromFieldRef res."fieldRef";
    }
    // {
    }
    // optionalAttrs (res."fileKeyRef" != null) {
      "fileKeyRef" = mkTemplateSpecContainerEnvValueFromFileKeyRef res."fileKeyRef";
    }
    // {
    }
    // optionalAttrs (res."resourceFieldRef" != null) {
      "resourceFieldRef" = mkTemplateSpecContainerEnvValueFromResourceFieldRef res."resourceFieldRef";
    }
    // {
    }
    // optionalAttrs (res."secretKeyRef" != null) {
      "secretKeyRef" = mkTemplateSpecContainerEnvValueFromSecretKeyRef res."secretKeyRef";
    }
    // {
    };
  TemplateSpecContainerEnvValueFromResourceFieldRefModule = types.submodule {
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
  mkTemplateSpecContainerEnvValueFromResourceFieldRef =
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
  TemplateSpecContainerEnvValueFromSecretKeyRefModule = types.submodule {
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
  mkTemplateSpecContainerEnvValueFromSecretKeyRef =
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
  TemplateSpecContainerLifecycleModule = types.submodule {
    options = {
      "postStart" = mkOption {
        description = "PostStart is called immediately after a container is created. If the handler fails,\nthe container is terminated and restarted according to its restart policy.\nOther management of the container blocks until the hook completes.\nMore info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks";
        type = (types.nullOr TemplateSpecContainerLifecyclePostStartModule);
        default = null;
      };
      "preStop" = mkOption {
        description = "PreStop is called immediately before a container is terminated due to an\nAPI request or management event such as liveness/startup probe failure,\npreemption, resource contention, etc. The handler is not called if the\ncontainer crashes or exits. The Pod's termination grace period countdown begins before the\nPreStop hook is executed. Regardless of the outcome of the handler, the\ncontainer will eventually terminate within the Pod's termination grace\nperiod (unless delayed by finalizers). Other management of the container blocks until the hook completes\nor until the termination grace period is reached.\nMore info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks";
        type = (types.nullOr TemplateSpecContainerLifecyclePreStopModule);
        default = null;
      };
      "stopSignal" = mkOption {
        description = "StopSignal defines which signal will be sent to a container when it is being stopped.\nIf not specified, the default is defined by the container runtime in use.\nStopSignal can only be set for Pods with a non-empty .spec.os.name";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTemplateSpecContainerLifecycle =
    res:
    {
    }
    // optionalAttrs (res."postStart" != null) {
      "postStart" = mkTemplateSpecContainerLifecyclePostStart res."postStart";
    }
    // {
    }
    // optionalAttrs (res."preStop" != null) {
      "preStop" = mkTemplateSpecContainerLifecyclePreStop res."preStop";
    }
    // {
    }
    // optionalAttrs (res."stopSignal" != null) { inherit (res) "stopSignal"; }
    // {
    };
  TemplateSpecContainerLifecyclePostStartExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkTemplateSpecContainerLifecyclePostStartExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  TemplateSpecContainerLifecyclePostStartHttpGetHttpHeaderModule = types.submodule {
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
  mkTemplateSpecContainerLifecyclePostStartHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  TemplateSpecContainerLifecyclePostStartHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf TemplateSpecContainerLifecyclePostStartHttpGetHttpHeaderModule);
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
  mkTemplateSpecContainerLifecyclePostStartHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" = map mkTemplateSpecContainerLifecyclePostStartHttpGetHttpHeader res."httpHeaders";
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
  TemplateSpecContainerLifecyclePostStartModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr TemplateSpecContainerLifecyclePostStartExecModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr TemplateSpecContainerLifecyclePostStartHttpGetModule);
        default = null;
      };
      "sleep" = mkOption {
        description = "Sleep represents a duration that the container should sleep.";
        type = (types.nullOr TemplateSpecContainerLifecyclePostStartSleepModule);
        default = null;
      };
      "tcpSocket" = mkOption {
        description = "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept\nfor backward compatibility. There is no validation of this field and\nlifecycle hooks will fail at runtime when it is specified.";
        type = (types.nullOr TemplateSpecContainerLifecyclePostStartTcpSocketModule);
        default = null;
      };
    };
  };
  mkTemplateSpecContainerLifecyclePostStart =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkTemplateSpecContainerLifecyclePostStartExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkTemplateSpecContainerLifecyclePostStartHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."sleep" != null) {
      "sleep" = mkTemplateSpecContainerLifecyclePostStartSleep res."sleep";
    }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" = mkTemplateSpecContainerLifecyclePostStartTcpSocket res."tcpSocket";
    }
    // {
    };
  TemplateSpecContainerLifecyclePostStartSleepModule = types.submodule {
    options = {
      "seconds" = mkOption {
        description = "Seconds is the number of seconds to sleep.";
        type = types.int;
      };
    };
  };
  mkTemplateSpecContainerLifecyclePostStartSleep = res: {
    inherit (res) "seconds";
  };
  TemplateSpecContainerLifecyclePostStartTcpSocketModule = types.submodule {
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
  mkTemplateSpecContainerLifecyclePostStartTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  TemplateSpecContainerLifecyclePreStopExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkTemplateSpecContainerLifecyclePreStopExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  TemplateSpecContainerLifecyclePreStopHttpGetHttpHeaderModule = types.submodule {
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
  mkTemplateSpecContainerLifecyclePreStopHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  TemplateSpecContainerLifecyclePreStopHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf TemplateSpecContainerLifecyclePreStopHttpGetHttpHeaderModule);
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
  mkTemplateSpecContainerLifecyclePreStopHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" = map mkTemplateSpecContainerLifecyclePreStopHttpGetHttpHeader res."httpHeaders";
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
  TemplateSpecContainerLifecyclePreStopModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr TemplateSpecContainerLifecyclePreStopExecModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr TemplateSpecContainerLifecyclePreStopHttpGetModule);
        default = null;
      };
      "sleep" = mkOption {
        description = "Sleep represents a duration that the container should sleep.";
        type = (types.nullOr TemplateSpecContainerLifecyclePreStopSleepModule);
        default = null;
      };
      "tcpSocket" = mkOption {
        description = "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept\nfor backward compatibility. There is no validation of this field and\nlifecycle hooks will fail at runtime when it is specified.";
        type = (types.nullOr TemplateSpecContainerLifecyclePreStopTcpSocketModule);
        default = null;
      };
    };
  };
  mkTemplateSpecContainerLifecyclePreStop =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkTemplateSpecContainerLifecyclePreStopExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkTemplateSpecContainerLifecyclePreStopHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."sleep" != null) {
      "sleep" = mkTemplateSpecContainerLifecyclePreStopSleep res."sleep";
    }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" = mkTemplateSpecContainerLifecyclePreStopTcpSocket res."tcpSocket";
    }
    // {
    };
  TemplateSpecContainerLifecyclePreStopSleepModule = types.submodule {
    options = {
      "seconds" = mkOption {
        description = "Seconds is the number of seconds to sleep.";
        type = types.int;
      };
    };
  };
  mkTemplateSpecContainerLifecyclePreStopSleep = res: {
    inherit (res) "seconds";
  };
  TemplateSpecContainerLifecyclePreStopTcpSocketModule = types.submodule {
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
  mkTemplateSpecContainerLifecyclePreStopTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  TemplateSpecContainerLivenessProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkTemplateSpecContainerLivenessProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  TemplateSpecContainerLivenessProbeGrpcModule = types.submodule {
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
  mkTemplateSpecContainerLivenessProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  TemplateSpecContainerLivenessProbeHttpGetHttpHeaderModule = types.submodule {
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
  mkTemplateSpecContainerLivenessProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  TemplateSpecContainerLivenessProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf TemplateSpecContainerLivenessProbeHttpGetHttpHeaderModule);
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
  mkTemplateSpecContainerLivenessProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" = map mkTemplateSpecContainerLivenessProbeHttpGetHttpHeader res."httpHeaders";
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
  TemplateSpecContainerLivenessProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr TemplateSpecContainerLivenessProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        description = "Minimum consecutive failures for the probe to be considered failed after having succeeded.\nDefaults to 3. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        description = "GRPC specifies a GRPC HealthCheckRequest.";
        type = (types.nullOr TemplateSpecContainerLivenessProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr TemplateSpecContainerLivenessProbeHttpGetModule);
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
        type = (types.nullOr TemplateSpecContainerLivenessProbeTcpSocketModule);
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
  mkTemplateSpecContainerLivenessProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkTemplateSpecContainerLivenessProbeExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkTemplateSpecContainerLivenessProbeGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkTemplateSpecContainerLivenessProbeHttpGet res."httpGet";
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
      "tcpSocket" = mkTemplateSpecContainerLivenessProbeTcpSocket res."tcpSocket";
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
  TemplateSpecContainerLivenessProbeTcpSocketModule = types.submodule {
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
  mkTemplateSpecContainerLivenessProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  TemplateSpecContainerModule = types.submodule {
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
        type = (types.listOf TemplateSpecContainerEnvModule);
        default = [ ];
      };
      "envFrom" = mkOption {
        description = "List of sources to populate environment variables in the container.\nThe keys defined within a source may consist of any printable ASCII characters except '='.\nWhen a key exists in multiple\nsources, the value associated with the last source will take precedence.\nValues defined by an Env with a duplicate key will take precedence.\nCannot be updated.";
        type = (types.listOf TemplateSpecContainerEnvFromModule);
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
        type = (types.nullOr TemplateSpecContainerLifecycleModule);
        default = null;
      };
      "livenessProbe" = mkOption {
        description = "Periodic probe of container liveness.\nContainer will be restarted if the probe fails.\nCannot be updated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr TemplateSpecContainerLivenessProbeModule);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the container specified as a DNS_LABEL.\nEach container in a pod must have a unique name (DNS_LABEL).\nCannot be updated.";
        type = types.str;
      };
      "ports" = mkOption {
        description = "List of ports to expose from the container. Not specifying a port here\nDOES NOT prevent that port from being exposed. Any port which is\nlistening on the default \"0.0.0.0\" address inside a container will be\naccessible from the network.\nModifying this array with strategic merge patch may corrupt the data.\nFor more information See https://github.com/kubernetes/kubernetes/issues/108255.\nCannot be updated.";
        type = (types.listOf TemplateSpecContainerPortModule);
        default = [ ];
      };
      "readinessProbe" = mkOption {
        description = "Periodic probe of container service readiness.\nContainer will be removed from service endpoints if the probe fails.\nCannot be updated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr TemplateSpecContainerReadinessProbeModule);
        default = null;
      };
      "resizePolicy" = mkOption {
        description = "Resources resize policy for the container.\nThis field cannot be set on ephemeral containers.";
        type = (types.listOf TemplateSpecContainerResizePolicyModule);
        default = [ ];
      };
      "resources" = mkOption {
        description = "Compute Resources required by this container.\nCannot be updated.\nMore info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.nullOr TemplateSpecContainerResourcesModule);
        default = null;
      };
      "restartPolicy" = mkOption {
        description = "RestartPolicy defines the restart behavior of individual containers in a pod.\nThis overrides the pod-level restart policy. When this field is not specified,\nthe restart behavior is defined by the Pod's restart policy and the container type.\nAdditionally, setting the RestartPolicy as \"Always\" for the init container will\nhave the following effect:\nthis init container will be continually restarted on\nexit until all regular containers have terminated. Once all regular\ncontainers have completed, all init containers with restartPolicy \"Always\"\nwill be shut down. This lifecycle differs from normal init containers and\nis often referred to as a \"sidecar\" container. Although this init\ncontainer still starts in the init container sequence, it does not wait\nfor the container to complete before proceeding to the next init\ncontainer. Instead, the next init container starts immediately after this\ninit container is started, or after any startupProbe has successfully\ncompleted.";
        type = (types.nullOr types.str);
        default = null;
      };
      "restartPolicyRules" = mkOption {
        description = "Represents a list of rules to be checked to determine if the\ncontainer should be restarted on exit. The rules are evaluated in\norder. Once a rule matches a container exit condition, the remaining\nrules are ignored. If no rule matches the container exit condition,\nthe Container-level restart policy determines the whether the container\nis restarted or not. Constraints on the rules:\n- At most 20 rules are allowed.\n- Rules can have the same action.\n- Identical rules are not forbidden in validations.\nWhen rules are specified, container MUST set RestartPolicy explicitly\neven it if matches the Pod's RestartPolicy.";
        type = (types.listOf TemplateSpecContainerRestartPolicyRuleModule);
        default = [ ];
      };
      "securityContext" = mkOption {
        description = "SecurityContext defines the security options the container should be run with.\nIf set, the fields of SecurityContext override the equivalent fields of PodSecurityContext.\nMore info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/";
        type = (types.nullOr TemplateSpecContainerSecurityContextModule);
        default = null;
      };
      "startupProbe" = mkOption {
        description = "StartupProbe indicates that the Pod has successfully initialized.\nIf specified, no other probes are executed until this completes successfully.\nIf this probe fails, the Pod will be restarted, just as if the livenessProbe failed.\nThis can be used to provide different probe parameters at the beginning of a Pod's lifecycle,\nwhen it might take a long time to load data or warm a cache, than during steady-state operation.\nThis cannot be updated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr TemplateSpecContainerStartupProbeModule);
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
        type = (types.listOf TemplateSpecContainerVolumeDeviceModule);
        default = [ ];
      };
      "volumeMounts" = mkOption {
        description = "Pod volumes to mount into the container's filesystem.\nCannot be updated.";
        type = (types.listOf TemplateSpecContainerVolumeMountModule);
        default = [ ];
      };
      "workingDir" = mkOption {
        description = "Container's working directory.\nIf not specified, the container runtime's default will be used, which\nmight be configured in the container image.\nCannot be updated.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTemplateSpecContainer =
    res:
    {
    }
    // optionalAttrs (res."args" != [ ]) { inherit (res) "args"; }
    // {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    }
    // optionalAttrs (res."env" != [ ]) { "env" = map mkTemplateSpecContainerEnv res."env"; }
    // {
    }
    // optionalAttrs (res."envFrom" != [ ]) {
      "envFrom" = map mkTemplateSpecContainerEnvFrom res."envFrom";
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
      "lifecycle" = mkTemplateSpecContainerLifecycle res."lifecycle";
    }
    // {
    }
    // optionalAttrs (res."livenessProbe" != null) {
      "livenessProbe" = mkTemplateSpecContainerLivenessProbe res."livenessProbe";
    }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."ports" != [ ]) { "ports" = map mkTemplateSpecContainerPort res."ports"; }
    // {
    }
    // optionalAttrs (res."readinessProbe" != null) {
      "readinessProbe" = mkTemplateSpecContainerReadinessProbe res."readinessProbe";
    }
    // {
    }
    // optionalAttrs (res."resizePolicy" != [ ]) {
      "resizePolicy" = map mkTemplateSpecContainerResizePolicy res."resizePolicy";
    }
    // {
    }
    // optionalAttrs (res."resources" != null) {
      "resources" = mkTemplateSpecContainerResources res."resources";
    }
    // {
    }
    // optionalAttrs (res."restartPolicy" != null) { inherit (res) "restartPolicy"; }
    // {
    }
    // optionalAttrs (res."restartPolicyRules" != [ ]) {
      "restartPolicyRules" = map mkTemplateSpecContainerRestartPolicyRule res."restartPolicyRules";
    }
    // {
    }
    // optionalAttrs (res."securityContext" != null) {
      "securityContext" = mkTemplateSpecContainerSecurityContext res."securityContext";
    }
    // {
    }
    // optionalAttrs (res."startupProbe" != null) {
      "startupProbe" = mkTemplateSpecContainerStartupProbe res."startupProbe";
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
      "volumeDevices" = map mkTemplateSpecContainerVolumeDevice res."volumeDevices";
    }
    // {
    }
    // optionalAttrs (res."volumeMounts" != [ ]) {
      "volumeMounts" = map mkTemplateSpecContainerVolumeMount res."volumeMounts";
    }
    // {
    }
    // optionalAttrs (res."workingDir" != null) { inherit (res) "workingDir"; }
    // {
    };
  TemplateSpecContainerPortModule = types.submodule {
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
  mkTemplateSpecContainerPort =
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
  TemplateSpecContainerReadinessProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkTemplateSpecContainerReadinessProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  TemplateSpecContainerReadinessProbeGrpcModule = types.submodule {
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
  mkTemplateSpecContainerReadinessProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  TemplateSpecContainerReadinessProbeHttpGetHttpHeaderModule = types.submodule {
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
  mkTemplateSpecContainerReadinessProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  TemplateSpecContainerReadinessProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf TemplateSpecContainerReadinessProbeHttpGetHttpHeaderModule);
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
  mkTemplateSpecContainerReadinessProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" = map mkTemplateSpecContainerReadinessProbeHttpGetHttpHeader res."httpHeaders";
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
  TemplateSpecContainerReadinessProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr TemplateSpecContainerReadinessProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        description = "Minimum consecutive failures for the probe to be considered failed after having succeeded.\nDefaults to 3. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        description = "GRPC specifies a GRPC HealthCheckRequest.";
        type = (types.nullOr TemplateSpecContainerReadinessProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr TemplateSpecContainerReadinessProbeHttpGetModule);
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
        type = (types.nullOr TemplateSpecContainerReadinessProbeTcpSocketModule);
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
  mkTemplateSpecContainerReadinessProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkTemplateSpecContainerReadinessProbeExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkTemplateSpecContainerReadinessProbeGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkTemplateSpecContainerReadinessProbeHttpGet res."httpGet";
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
      "tcpSocket" = mkTemplateSpecContainerReadinessProbeTcpSocket res."tcpSocket";
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
  TemplateSpecContainerReadinessProbeTcpSocketModule = types.submodule {
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
  mkTemplateSpecContainerReadinessProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  TemplateSpecContainerResizePolicyModule = types.submodule {
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
  mkTemplateSpecContainerResizePolicy = res: {
    inherit (res) "resourceName";
    inherit (res) "restartPolicy";
  };
  TemplateSpecContainerResourcesClaimModule = types.submodule {
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
  mkTemplateSpecContainerResourcesClaim =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."request" != null) { inherit (res) "request"; }
    // {
    };
  TemplateSpecContainerResourcesModule = types.submodule {
    options = {
      "claims" = mkOption {
        description = "Claims lists the names of resources, defined in spec.resourceClaims,\nthat are used by this container.\n\nThis field depends on the\nDynamicResourceAllocation feature gate.\n\nThis field is immutable. It can only be set for containers.";
        type = (types.listOf TemplateSpecContainerResourcesClaimModule);
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
  mkTemplateSpecContainerResources =
    res:
    {
    }
    // optionalAttrs (res."claims" != [ ]) {
      "claims" = map mkTemplateSpecContainerResourcesClaim res."claims";
    }
    // {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  TemplateSpecContainerRestartPolicyRuleExitCodesModule = types.submodule {
    options = {
      "operator" = mkOption {
        description = "Represents the relationship between the container exit code(s) and the\nspecified values. Possible values are:\n- In: the requirement is satisfied if the container exit code is in the\n  set of specified values.\n- NotIn: the requirement is satisfied if the container exit code is\n  not in the set of specified values.";
        type = types.str;
      };
      "values" = mkOption {
        description = "Specifies the set of values to check for container exit codes.\nAt most 255 elements are allowed.";
        type = (types.listOf types.int);
        default = [ ];
      };
    };
  };
  mkTemplateSpecContainerRestartPolicyRuleExitCodes =
    res:
    {
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  TemplateSpecContainerRestartPolicyRuleModule = types.submodule {
    options = {
      "action" = mkOption {
        description = "Specifies the action taken on a container exit if the requirements\nare satisfied. The only possible value is \"Restart\" to restart the\ncontainer.";
        type = types.str;
      };
      "exitCodes" = mkOption {
        description = "Represents the exit codes to check on container exits.";
        type = (types.nullOr TemplateSpecContainerRestartPolicyRuleExitCodesModule);
        default = null;
      };
    };
  };
  mkTemplateSpecContainerRestartPolicyRule =
    res:
    {
      inherit (res) "action";
    }
    // optionalAttrs (res."exitCodes" != null) {
      "exitCodes" = mkTemplateSpecContainerRestartPolicyRuleExitCodes res."exitCodes";
    }
    // {
    };
  TemplateSpecContainerSecurityContextAppArmorProfileModule = types.submodule {
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
  mkTemplateSpecContainerSecurityContextAppArmorProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  TemplateSpecContainerSecurityContextCapabilitiesModule = types.submodule {
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
  mkTemplateSpecContainerSecurityContextCapabilities =
    res:
    {
    }
    // optionalAttrs (res."add" != [ ]) { inherit (res) "add"; }
    // {
    }
    // optionalAttrs (res."drop" != [ ]) { inherit (res) "drop"; }
    // {
    };
  TemplateSpecContainerSecurityContextModule = types.submodule {
    options = {
      "allowPrivilegeEscalation" = mkOption {
        description = "AllowPrivilegeEscalation controls whether a process can gain more\nprivileges than its parent process. This bool directly controls if\nthe no_new_privs flag will be set on the container process.\nAllowPrivilegeEscalation is true always when the container is:\n1) run as Privileged\n2) has CAP_SYS_ADMIN\nNote that this field cannot be set when spec.os.name is windows.";
        type = types.bool;
        default = false;
      };
      "appArmorProfile" = mkOption {
        description = "appArmorProfile is the AppArmor options to use by this container. If set, this profile\noverrides the pod's appArmorProfile.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr TemplateSpecContainerSecurityContextAppArmorProfileModule);
        default = null;
      };
      "capabilities" = mkOption {
        description = "The capabilities to add/drop when running containers.\nDefaults to the default set of capabilities granted by the container runtime.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr TemplateSpecContainerSecurityContextCapabilitiesModule);
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
        type = (types.nullOr TemplateSpecContainerSecurityContextSeLinuxOptionsModule);
        default = null;
      };
      "seccompProfile" = mkOption {
        description = "The seccomp options to use by this container. If seccomp options are\nprovided at both the pod & container level, the container options\noverride the pod options.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr TemplateSpecContainerSecurityContextSeccompProfileModule);
        default = null;
      };
      "windowsOptions" = mkOption {
        description = "The Windows specific settings applied to all containers.\nIf unspecified, the options from the PodSecurityContext will be used.\nIf set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is linux.";
        type = (types.nullOr TemplateSpecContainerSecurityContextWindowsOptionsModule);
        default = null;
      };
    };
  };
  mkTemplateSpecContainerSecurityContext =
    res:
    {
    }
    // optionalAttrs res."allowPrivilegeEscalation" { inherit (res) "allowPrivilegeEscalation"; }
    // {
    }
    // optionalAttrs (res."appArmorProfile" != null) {
      "appArmorProfile" = mkTemplateSpecContainerSecurityContextAppArmorProfile res."appArmorProfile";
    }
    // {
    }
    // optionalAttrs (res."capabilities" != null) {
      "capabilities" = mkTemplateSpecContainerSecurityContextCapabilities res."capabilities";
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
      "seLinuxOptions" = mkTemplateSpecContainerSecurityContextSeLinuxOptions res."seLinuxOptions";
    }
    // {
    }
    // optionalAttrs (res."seccompProfile" != null) {
      "seccompProfile" = mkTemplateSpecContainerSecurityContextSeccompProfile res."seccompProfile";
    }
    // {
    }
    // optionalAttrs (res."windowsOptions" != null) {
      "windowsOptions" = mkTemplateSpecContainerSecurityContextWindowsOptions res."windowsOptions";
    }
    // {
    };
  TemplateSpecContainerSecurityContextSeLinuxOptionsModule = types.submodule {
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
  mkTemplateSpecContainerSecurityContextSeLinuxOptions =
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
  TemplateSpecContainerSecurityContextSeccompProfileModule = types.submodule {
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
  mkTemplateSpecContainerSecurityContextSeccompProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  TemplateSpecContainerSecurityContextWindowsOptionsModule = types.submodule {
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
  mkTemplateSpecContainerSecurityContextWindowsOptions =
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
  TemplateSpecContainerStartupProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkTemplateSpecContainerStartupProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  TemplateSpecContainerStartupProbeGrpcModule = types.submodule {
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
  mkTemplateSpecContainerStartupProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  TemplateSpecContainerStartupProbeHttpGetHttpHeaderModule = types.submodule {
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
  mkTemplateSpecContainerStartupProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  TemplateSpecContainerStartupProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf TemplateSpecContainerStartupProbeHttpGetHttpHeaderModule);
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
  mkTemplateSpecContainerStartupProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" = map mkTemplateSpecContainerStartupProbeHttpGetHttpHeader res."httpHeaders";
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
  TemplateSpecContainerStartupProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr TemplateSpecContainerStartupProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        description = "Minimum consecutive failures for the probe to be considered failed after having succeeded.\nDefaults to 3. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        description = "GRPC specifies a GRPC HealthCheckRequest.";
        type = (types.nullOr TemplateSpecContainerStartupProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr TemplateSpecContainerStartupProbeHttpGetModule);
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
        type = (types.nullOr TemplateSpecContainerStartupProbeTcpSocketModule);
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
  mkTemplateSpecContainerStartupProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkTemplateSpecContainerStartupProbeExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkTemplateSpecContainerStartupProbeGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkTemplateSpecContainerStartupProbeHttpGet res."httpGet";
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
      "tcpSocket" = mkTemplateSpecContainerStartupProbeTcpSocket res."tcpSocket";
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
  TemplateSpecContainerStartupProbeTcpSocketModule = types.submodule {
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
  mkTemplateSpecContainerStartupProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  TemplateSpecContainerVolumeDeviceModule = types.submodule {
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
  mkTemplateSpecContainerVolumeDevice = res: {
    inherit (res) "devicePath";
    inherit (res) "name";
  };
  TemplateSpecContainerVolumeMountModule = types.submodule {
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
  mkTemplateSpecContainerVolumeMount =
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
  TemplateSpecDnsConfigModule = types.submodule {
    options = {
      "nameservers" = mkOption {
        description = "A list of DNS name server IP addresses.\nThis will be appended to the base nameservers generated from DNSPolicy.\nDuplicated nameservers will be removed.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "options" = mkOption {
        description = "A list of DNS resolver options.\nThis will be merged with the base options generated from DNSPolicy.\nDuplicated entries will be removed. Resolution options given in Options\nwill override those that appear in the base DNSPolicy.";
        type = (types.listOf TemplateSpecDnsConfigOptionModule);
        default = [ ];
      };
      "searches" = mkOption {
        description = "A list of DNS search domains for host-name lookup.\nThis will be appended to the base search paths generated from DNSPolicy.\nDuplicated search paths will be removed.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkTemplateSpecDnsConfig =
    res:
    {
    }
    // optionalAttrs (res."nameservers" != [ ]) { inherit (res) "nameservers"; }
    // {
    }
    // optionalAttrs (res."options" != [ ]) {
      "options" = map mkTemplateSpecDnsConfigOption res."options";
    }
    // {
    }
    // optionalAttrs (res."searches" != [ ]) { inherit (res) "searches"; }
    // {
    };
  TemplateSpecDnsConfigOptionModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is this DNS resolver option's name.\nRequired.";
        type = (types.nullOr types.str);
        default = null;
      };
      "value" = mkOption {
        description = "Value is this DNS resolver option's value.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTemplateSpecDnsConfigOption =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  TemplateSpecEphemeralContainerEnvFromConfigMapRefModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerEnvFromConfigMapRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TemplateSpecEphemeralContainerEnvFromModule = types.submodule {
    options = {
      "configMapRef" = mkOption {
        description = "The ConfigMap to select from";
        type = (types.nullOr TemplateSpecEphemeralContainerEnvFromConfigMapRefModule);
        default = null;
      };
      "prefix" = mkOption {
        description = "Optional text to prepend to the name of each environment variable.\nMay consist of any printable ASCII characters except '='.";
        type = (types.nullOr types.str);
        default = null;
      };
      "secretRef" = mkOption {
        description = "The Secret to select from";
        type = (types.nullOr TemplateSpecEphemeralContainerEnvFromSecretRefModule);
        default = null;
      };
    };
  };
  mkTemplateSpecEphemeralContainerEnvFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapRef" != null) {
      "configMapRef" = mkTemplateSpecEphemeralContainerEnvFromConfigMapRef res."configMapRef";
    }
    // {
    }
    // optionalAttrs (res."prefix" != null) { inherit (res) "prefix"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkTemplateSpecEphemeralContainerEnvFromSecretRef res."secretRef";
    }
    // {
    };
  TemplateSpecEphemeralContainerEnvFromSecretRefModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerEnvFromSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TemplateSpecEphemeralContainerEnvModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the environment variable.\nMay consist of any printable ASCII characters except '='.";
        type = types.str;
      };
      "value" = mkOption {
        description = "Variable references $(VAR_NAME) are expanded\nusing the previously defined environment variables in the container and\nany service environment variables. If a variable cannot be resolved,\nthe reference in the input string will be unchanged. Double $$ are reduced\nto a single $, which allows for escaping the $(VAR_NAME) syntax: i.e.\n\"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\".\nEscaped references will never be expanded, regardless of whether the variable\nexists or not.\nDefaults to \"\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "valueFrom" = mkOption {
        description = "Source for the environment variable's value. Cannot be used if value is not empty.";
        type = (types.nullOr TemplateSpecEphemeralContainerEnvValueFromModule);
        default = null;
      };
    };
  };
  mkTemplateSpecEphemeralContainerEnv =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    }
    // optionalAttrs (res."valueFrom" != null) {
      "valueFrom" = mkTemplateSpecEphemeralContainerEnvValueFrom res."valueFrom";
    }
    // {
    };
  TemplateSpecEphemeralContainerEnvValueFromConfigMapKeyRefModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerEnvValueFromConfigMapKeyRef =
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
  TemplateSpecEphemeralContainerEnvValueFromFieldRefModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerEnvValueFromFieldRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "fieldPath";
    };
  TemplateSpecEphemeralContainerEnvValueFromFileKeyRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key within the env file. An invalid key will prevent the pod from starting.\nThe keys defined within a source may consist of any printable ASCII characters except '='.\nDuring Alpha stage of the EnvFiles feature gate, the key size is limited to 128 characters.";
        type = types.str;
      };
      "optional" = mkOption {
        description = "Specify whether the file or its key must be defined. If the file or key\ndoes not exist, then the env var is not published.\nIf optional is set to true and the specified key does not exist,\nthe environment variable will not be set in the Pod's containers.\n\nIf optional is set to false and the specified key does not exist,\nan error will be returned during Pod creation.";
        type = types.bool;
        default = false;
      };
      "path" = mkOption {
        description = "The path within the volume from which to select the file.\nMust be relative and may not contain the '..' path or start with '..'.";
        type = types.str;
      };
      "volumeName" = mkOption {
        description = "The name of the volume mount containing the env file.";
        type = types.str;
      };
    };
  };
  mkTemplateSpecEphemeralContainerEnvValueFromFileKeyRef =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
      inherit (res) "path";
      inherit (res) "volumeName";
    };
  TemplateSpecEphemeralContainerEnvValueFromModule = types.submodule {
    options = {
      "configMapKeyRef" = mkOption {
        description = "Selects a key of a ConfigMap.";
        type = (types.nullOr TemplateSpecEphemeralContainerEnvValueFromConfigMapKeyRefModule);
        default = null;
      };
      "fieldRef" = mkOption {
        description = "Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`,\nspec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs.";
        type = (types.nullOr TemplateSpecEphemeralContainerEnvValueFromFieldRefModule);
        default = null;
      };
      "fileKeyRef" = mkOption {
        description = "FileKeyRef selects a key of the env file.\nRequires the EnvFiles feature gate to be enabled.";
        type = (types.nullOr TemplateSpecEphemeralContainerEnvValueFromFileKeyRefModule);
        default = null;
      };
      "resourceFieldRef" = mkOption {
        description = "Selects a resource of the container: only resources limits and requests\n(limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported.";
        type = (types.nullOr TemplateSpecEphemeralContainerEnvValueFromResourceFieldRefModule);
        default = null;
      };
      "secretKeyRef" = mkOption {
        description = "Selects a key of a secret in the pod's namespace";
        type = (types.nullOr TemplateSpecEphemeralContainerEnvValueFromSecretKeyRefModule);
        default = null;
      };
    };
  };
  mkTemplateSpecEphemeralContainerEnvValueFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapKeyRef" != null) {
      "configMapKeyRef" =
        mkTemplateSpecEphemeralContainerEnvValueFromConfigMapKeyRef
          res."configMapKeyRef";
    }
    // {
    }
    // optionalAttrs (res."fieldRef" != null) {
      "fieldRef" = mkTemplateSpecEphemeralContainerEnvValueFromFieldRef res."fieldRef";
    }
    // {
    }
    // optionalAttrs (res."fileKeyRef" != null) {
      "fileKeyRef" = mkTemplateSpecEphemeralContainerEnvValueFromFileKeyRef res."fileKeyRef";
    }
    // {
    }
    // optionalAttrs (res."resourceFieldRef" != null) {
      "resourceFieldRef" =
        mkTemplateSpecEphemeralContainerEnvValueFromResourceFieldRef
          res."resourceFieldRef";
    }
    // {
    }
    // optionalAttrs (res."secretKeyRef" != null) {
      "secretKeyRef" = mkTemplateSpecEphemeralContainerEnvValueFromSecretKeyRef res."secretKeyRef";
    }
    // {
    };
  TemplateSpecEphemeralContainerEnvValueFromResourceFieldRefModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerEnvValueFromResourceFieldRef =
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
  TemplateSpecEphemeralContainerEnvValueFromSecretKeyRefModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerEnvValueFromSecretKeyRef =
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
  TemplateSpecEphemeralContainerLifecycleModule = types.submodule {
    options = {
      "postStart" = mkOption {
        description = "PostStart is called immediately after a container is created. If the handler fails,\nthe container is terminated and restarted according to its restart policy.\nOther management of the container blocks until the hook completes.\nMore info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks";
        type = (types.nullOr TemplateSpecEphemeralContainerLifecyclePostStartModule);
        default = null;
      };
      "preStop" = mkOption {
        description = "PreStop is called immediately before a container is terminated due to an\nAPI request or management event such as liveness/startup probe failure,\npreemption, resource contention, etc. The handler is not called if the\ncontainer crashes or exits. The Pod's termination grace period countdown begins before the\nPreStop hook is executed. Regardless of the outcome of the handler, the\ncontainer will eventually terminate within the Pod's termination grace\nperiod (unless delayed by finalizers). Other management of the container blocks until the hook completes\nor until the termination grace period is reached.\nMore info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks";
        type = (types.nullOr TemplateSpecEphemeralContainerLifecyclePreStopModule);
        default = null;
      };
      "stopSignal" = mkOption {
        description = "StopSignal defines which signal will be sent to a container when it is being stopped.\nIf not specified, the default is defined by the container runtime in use.\nStopSignal can only be set for Pods with a non-empty .spec.os.name";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTemplateSpecEphemeralContainerLifecycle =
    res:
    {
    }
    // optionalAttrs (res."postStart" != null) {
      "postStart" = mkTemplateSpecEphemeralContainerLifecyclePostStart res."postStart";
    }
    // {
    }
    // optionalAttrs (res."preStop" != null) {
      "preStop" = mkTemplateSpecEphemeralContainerLifecyclePreStop res."preStop";
    }
    // {
    }
    // optionalAttrs (res."stopSignal" != null) { inherit (res) "stopSignal"; }
    // {
    };
  TemplateSpecEphemeralContainerLifecyclePostStartExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkTemplateSpecEphemeralContainerLifecyclePostStartExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  TemplateSpecEphemeralContainerLifecyclePostStartHttpGetHttpHeaderModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerLifecyclePostStartHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  TemplateSpecEphemeralContainerLifecyclePostStartHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf TemplateSpecEphemeralContainerLifecyclePostStartHttpGetHttpHeaderModule);
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
  mkTemplateSpecEphemeralContainerLifecyclePostStartHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" =
        map mkTemplateSpecEphemeralContainerLifecyclePostStartHttpGetHttpHeader
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
  TemplateSpecEphemeralContainerLifecyclePostStartModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr TemplateSpecEphemeralContainerLifecyclePostStartExecModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr TemplateSpecEphemeralContainerLifecyclePostStartHttpGetModule);
        default = null;
      };
      "sleep" = mkOption {
        description = "Sleep represents a duration that the container should sleep.";
        type = (types.nullOr TemplateSpecEphemeralContainerLifecyclePostStartSleepModule);
        default = null;
      };
      "tcpSocket" = mkOption {
        description = "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept\nfor backward compatibility. There is no validation of this field and\nlifecycle hooks will fail at runtime when it is specified.";
        type = (types.nullOr TemplateSpecEphemeralContainerLifecyclePostStartTcpSocketModule);
        default = null;
      };
    };
  };
  mkTemplateSpecEphemeralContainerLifecyclePostStart =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkTemplateSpecEphemeralContainerLifecyclePostStartExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkTemplateSpecEphemeralContainerLifecyclePostStartHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."sleep" != null) {
      "sleep" = mkTemplateSpecEphemeralContainerLifecyclePostStartSleep res."sleep";
    }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" = mkTemplateSpecEphemeralContainerLifecyclePostStartTcpSocket res."tcpSocket";
    }
    // {
    };
  TemplateSpecEphemeralContainerLifecyclePostStartSleepModule = types.submodule {
    options = {
      "seconds" = mkOption {
        description = "Seconds is the number of seconds to sleep.";
        type = types.int;
      };
    };
  };
  mkTemplateSpecEphemeralContainerLifecyclePostStartSleep = res: {
    inherit (res) "seconds";
  };
  TemplateSpecEphemeralContainerLifecyclePostStartTcpSocketModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerLifecyclePostStartTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  TemplateSpecEphemeralContainerLifecyclePreStopExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkTemplateSpecEphemeralContainerLifecyclePreStopExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  TemplateSpecEphemeralContainerLifecyclePreStopHttpGetHttpHeaderModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerLifecyclePreStopHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  TemplateSpecEphemeralContainerLifecyclePreStopHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf TemplateSpecEphemeralContainerLifecyclePreStopHttpGetHttpHeaderModule);
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
  mkTemplateSpecEphemeralContainerLifecyclePreStopHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" =
        map mkTemplateSpecEphemeralContainerLifecyclePreStopHttpGetHttpHeader
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
  TemplateSpecEphemeralContainerLifecyclePreStopModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr TemplateSpecEphemeralContainerLifecyclePreStopExecModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr TemplateSpecEphemeralContainerLifecyclePreStopHttpGetModule);
        default = null;
      };
      "sleep" = mkOption {
        description = "Sleep represents a duration that the container should sleep.";
        type = (types.nullOr TemplateSpecEphemeralContainerLifecyclePreStopSleepModule);
        default = null;
      };
      "tcpSocket" = mkOption {
        description = "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept\nfor backward compatibility. There is no validation of this field and\nlifecycle hooks will fail at runtime when it is specified.";
        type = (types.nullOr TemplateSpecEphemeralContainerLifecyclePreStopTcpSocketModule);
        default = null;
      };
    };
  };
  mkTemplateSpecEphemeralContainerLifecyclePreStop =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkTemplateSpecEphemeralContainerLifecyclePreStopExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkTemplateSpecEphemeralContainerLifecyclePreStopHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."sleep" != null) {
      "sleep" = mkTemplateSpecEphemeralContainerLifecyclePreStopSleep res."sleep";
    }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" = mkTemplateSpecEphemeralContainerLifecyclePreStopTcpSocket res."tcpSocket";
    }
    // {
    };
  TemplateSpecEphemeralContainerLifecyclePreStopSleepModule = types.submodule {
    options = {
      "seconds" = mkOption {
        description = "Seconds is the number of seconds to sleep.";
        type = types.int;
      };
    };
  };
  mkTemplateSpecEphemeralContainerLifecyclePreStopSleep = res: {
    inherit (res) "seconds";
  };
  TemplateSpecEphemeralContainerLifecyclePreStopTcpSocketModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerLifecyclePreStopTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  TemplateSpecEphemeralContainerLivenessProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkTemplateSpecEphemeralContainerLivenessProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  TemplateSpecEphemeralContainerLivenessProbeGrpcModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerLivenessProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  TemplateSpecEphemeralContainerLivenessProbeHttpGetHttpHeaderModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerLivenessProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  TemplateSpecEphemeralContainerLivenessProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf TemplateSpecEphemeralContainerLivenessProbeHttpGetHttpHeaderModule);
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
  mkTemplateSpecEphemeralContainerLivenessProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" =
        map mkTemplateSpecEphemeralContainerLivenessProbeHttpGetHttpHeader
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
  TemplateSpecEphemeralContainerLivenessProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr TemplateSpecEphemeralContainerLivenessProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        description = "Minimum consecutive failures for the probe to be considered failed after having succeeded.\nDefaults to 3. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        description = "GRPC specifies a GRPC HealthCheckRequest.";
        type = (types.nullOr TemplateSpecEphemeralContainerLivenessProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr TemplateSpecEphemeralContainerLivenessProbeHttpGetModule);
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
        type = (types.nullOr TemplateSpecEphemeralContainerLivenessProbeTcpSocketModule);
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
  mkTemplateSpecEphemeralContainerLivenessProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkTemplateSpecEphemeralContainerLivenessProbeExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkTemplateSpecEphemeralContainerLivenessProbeGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkTemplateSpecEphemeralContainerLivenessProbeHttpGet res."httpGet";
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
      "tcpSocket" = mkTemplateSpecEphemeralContainerLivenessProbeTcpSocket res."tcpSocket";
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
  TemplateSpecEphemeralContainerLivenessProbeTcpSocketModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerLivenessProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  TemplateSpecEphemeralContainerModule = types.submodule {
    options = {
      "args" = mkOption {
        description = "Arguments to the entrypoint.\nThe image's CMD is used if this is not provided.\nVariable references $(VAR_NAME) are expanded using the container's environment. If a variable\ncannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced\nto a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will\nproduce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless\nof whether the variable exists or not. Cannot be updated.\nMore info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell";
        type = (types.listOf types.str);
        default = [ ];
      };
      "command" = mkOption {
        description = "Entrypoint array. Not executed within a shell.\nThe image's ENTRYPOINT is used if this is not provided.\nVariable references $(VAR_NAME) are expanded using the container's environment. If a variable\ncannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced\nto a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will\nproduce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless\nof whether the variable exists or not. Cannot be updated.\nMore info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell";
        type = (types.listOf types.str);
        default = [ ];
      };
      "env" = mkOption {
        description = "List of environment variables to set in the container.\nCannot be updated.";
        type = (types.listOf TemplateSpecEphemeralContainerEnvModule);
        default = [ ];
      };
      "envFrom" = mkOption {
        description = "List of sources to populate environment variables in the container.\nThe keys defined within a source may consist of any printable ASCII characters except '='.\nWhen a key exists in multiple\nsources, the value associated with the last source will take precedence.\nValues defined by an Env with a duplicate key will take precedence.\nCannot be updated.";
        type = (types.listOf TemplateSpecEphemeralContainerEnvFromModule);
        default = [ ];
      };
      "image" = mkOption {
        description = "Container image name.\nMore info: https://kubernetes.io/docs/concepts/containers/images";
        type = (types.nullOr types.str);
        default = null;
      };
      "imagePullPolicy" = mkOption {
        description = "Image pull policy.\nOne of Always, Never, IfNotPresent.\nDefaults to Always if :latest tag is specified, or IfNotPresent otherwise.\nCannot be updated.\nMore info: https://kubernetes.io/docs/concepts/containers/images#updating-images";
        type = (types.nullOr types.str);
        default = null;
      };
      "lifecycle" = mkOption {
        description = "Lifecycle is not allowed for ephemeral containers.";
        type = (types.nullOr TemplateSpecEphemeralContainerLifecycleModule);
        default = null;
      };
      "livenessProbe" = mkOption {
        description = "Probes are not allowed for ephemeral containers.";
        type = (types.nullOr TemplateSpecEphemeralContainerLivenessProbeModule);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the ephemeral container specified as a DNS_LABEL.\nThis name must be unique among all containers, init containers and ephemeral containers.";
        type = types.str;
      };
      "ports" = mkOption {
        description = "Ports are not allowed for ephemeral containers.";
        type = (types.listOf TemplateSpecEphemeralContainerPortModule);
        default = [ ];
      };
      "readinessProbe" = mkOption {
        description = "Probes are not allowed for ephemeral containers.";
        type = (types.nullOr TemplateSpecEphemeralContainerReadinessProbeModule);
        default = null;
      };
      "resizePolicy" = mkOption {
        description = "Resources resize policy for the container.";
        type = (types.listOf TemplateSpecEphemeralContainerResizePolicyModule);
        default = [ ];
      };
      "resources" = mkOption {
        description = "Resources are not allowed for ephemeral containers. Ephemeral containers use spare resources\nalready allocated to the pod.";
        type = (types.nullOr TemplateSpecEphemeralContainerResourcesModule);
        default = null;
      };
      "restartPolicy" = mkOption {
        description = "Restart policy for the container to manage the restart behavior of each\ncontainer within a pod.\nYou cannot set this field on ephemeral containers.";
        type = (types.nullOr types.str);
        default = null;
      };
      "restartPolicyRules" = mkOption {
        description = "Represents a list of rules to be checked to determine if the\ncontainer should be restarted on exit. You cannot set this field on\nephemeral containers.";
        type = (types.listOf TemplateSpecEphemeralContainerRestartPolicyRuleModule);
        default = [ ];
      };
      "securityContext" = mkOption {
        description = "Optional: SecurityContext defines the security options the ephemeral container should be run with.\nIf set, the fields of SecurityContext override the equivalent fields of PodSecurityContext.";
        type = (types.nullOr TemplateSpecEphemeralContainerSecurityContextModule);
        default = null;
      };
      "startupProbe" = mkOption {
        description = "Probes are not allowed for ephemeral containers.";
        type = (types.nullOr TemplateSpecEphemeralContainerStartupProbeModule);
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
      "targetContainerName" = mkOption {
        description = "If set, the name of the container from PodSpec that this ephemeral container targets.\nThe ephemeral container will be run in the namespaces (IPC, PID, etc) of this container.\nIf not set then the ephemeral container uses the namespaces configured in the Pod spec.\n\nThe container runtime must implement support for this feature. If the runtime does not\nsupport namespace targeting then the result of setting this field is undefined.";
        type = (types.nullOr types.str);
        default = null;
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
        type = (types.listOf TemplateSpecEphemeralContainerVolumeDeviceModule);
        default = [ ];
      };
      "volumeMounts" = mkOption {
        description = "Pod volumes to mount into the container's filesystem. Subpath mounts are not allowed for ephemeral containers.\nCannot be updated.";
        type = (types.listOf TemplateSpecEphemeralContainerVolumeMountModule);
        default = [ ];
      };
      "workingDir" = mkOption {
        description = "Container's working directory.\nIf not specified, the container runtime's default will be used, which\nmight be configured in the container image.\nCannot be updated.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTemplateSpecEphemeralContainer =
    res:
    {
    }
    // optionalAttrs (res."args" != [ ]) { inherit (res) "args"; }
    // {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    }
    // optionalAttrs (res."env" != [ ]) { "env" = map mkTemplateSpecEphemeralContainerEnv res."env"; }
    // {
    }
    // optionalAttrs (res."envFrom" != [ ]) {
      "envFrom" = map mkTemplateSpecEphemeralContainerEnvFrom res."envFrom";
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
      "lifecycle" = mkTemplateSpecEphemeralContainerLifecycle res."lifecycle";
    }
    // {
    }
    // optionalAttrs (res."livenessProbe" != null) {
      "livenessProbe" = mkTemplateSpecEphemeralContainerLivenessProbe res."livenessProbe";
    }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."ports" != [ ]) {
      "ports" = map mkTemplateSpecEphemeralContainerPort res."ports";
    }
    // {
    }
    // optionalAttrs (res."readinessProbe" != null) {
      "readinessProbe" = mkTemplateSpecEphemeralContainerReadinessProbe res."readinessProbe";
    }
    // {
    }
    // optionalAttrs (res."resizePolicy" != [ ]) {
      "resizePolicy" = map mkTemplateSpecEphemeralContainerResizePolicy res."resizePolicy";
    }
    // {
    }
    // optionalAttrs (res."resources" != null) {
      "resources" = mkTemplateSpecEphemeralContainerResources res."resources";
    }
    // {
    }
    // optionalAttrs (res."restartPolicy" != null) { inherit (res) "restartPolicy"; }
    // {
    }
    // optionalAttrs (res."restartPolicyRules" != [ ]) {
      "restartPolicyRules" =
        map mkTemplateSpecEphemeralContainerRestartPolicyRule
          res."restartPolicyRules";
    }
    // {
    }
    // optionalAttrs (res."securityContext" != null) {
      "securityContext" = mkTemplateSpecEphemeralContainerSecurityContext res."securityContext";
    }
    // {
    }
    // optionalAttrs (res."startupProbe" != null) {
      "startupProbe" = mkTemplateSpecEphemeralContainerStartupProbe res."startupProbe";
    }
    // {
    }
    // optionalAttrs res."stdin" { inherit (res) "stdin"; }
    // {
    }
    // optionalAttrs res."stdinOnce" { inherit (res) "stdinOnce"; }
    // {
    }
    // optionalAttrs (res."targetContainerName" != null) { inherit (res) "targetContainerName"; }
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
      "volumeDevices" = map mkTemplateSpecEphemeralContainerVolumeDevice res."volumeDevices";
    }
    // {
    }
    // optionalAttrs (res."volumeMounts" != [ ]) {
      "volumeMounts" = map mkTemplateSpecEphemeralContainerVolumeMount res."volumeMounts";
    }
    // {
    }
    // optionalAttrs (res."workingDir" != null) { inherit (res) "workingDir"; }
    // {
    };
  TemplateSpecEphemeralContainerPortModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerPort =
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
  TemplateSpecEphemeralContainerReadinessProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkTemplateSpecEphemeralContainerReadinessProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  TemplateSpecEphemeralContainerReadinessProbeGrpcModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerReadinessProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  TemplateSpecEphemeralContainerReadinessProbeHttpGetHttpHeaderModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerReadinessProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  TemplateSpecEphemeralContainerReadinessProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf TemplateSpecEphemeralContainerReadinessProbeHttpGetHttpHeaderModule);
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
  mkTemplateSpecEphemeralContainerReadinessProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" =
        map mkTemplateSpecEphemeralContainerReadinessProbeHttpGetHttpHeader
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
  TemplateSpecEphemeralContainerReadinessProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr TemplateSpecEphemeralContainerReadinessProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        description = "Minimum consecutive failures for the probe to be considered failed after having succeeded.\nDefaults to 3. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        description = "GRPC specifies a GRPC HealthCheckRequest.";
        type = (types.nullOr TemplateSpecEphemeralContainerReadinessProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr TemplateSpecEphemeralContainerReadinessProbeHttpGetModule);
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
        type = (types.nullOr TemplateSpecEphemeralContainerReadinessProbeTcpSocketModule);
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
  mkTemplateSpecEphemeralContainerReadinessProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkTemplateSpecEphemeralContainerReadinessProbeExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkTemplateSpecEphemeralContainerReadinessProbeGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkTemplateSpecEphemeralContainerReadinessProbeHttpGet res."httpGet";
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
      "tcpSocket" = mkTemplateSpecEphemeralContainerReadinessProbeTcpSocket res."tcpSocket";
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
  TemplateSpecEphemeralContainerReadinessProbeTcpSocketModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerReadinessProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  TemplateSpecEphemeralContainerResizePolicyModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerResizePolicy = res: {
    inherit (res) "resourceName";
    inherit (res) "restartPolicy";
  };
  TemplateSpecEphemeralContainerResourcesClaimModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerResourcesClaim =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."request" != null) { inherit (res) "request"; }
    // {
    };
  TemplateSpecEphemeralContainerResourcesModule = types.submodule {
    options = {
      "claims" = mkOption {
        description = "Claims lists the names of resources, defined in spec.resourceClaims,\nthat are used by this container.\n\nThis field depends on the\nDynamicResourceAllocation feature gate.\n\nThis field is immutable. It can only be set for containers.";
        type = (types.listOf TemplateSpecEphemeralContainerResourcesClaimModule);
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
  mkTemplateSpecEphemeralContainerResources =
    res:
    {
    }
    // optionalAttrs (res."claims" != [ ]) {
      "claims" = map mkTemplateSpecEphemeralContainerResourcesClaim res."claims";
    }
    // {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  TemplateSpecEphemeralContainerRestartPolicyRuleExitCodesModule = types.submodule {
    options = {
      "operator" = mkOption {
        description = "Represents the relationship between the container exit code(s) and the\nspecified values. Possible values are:\n- In: the requirement is satisfied if the container exit code is in the\n  set of specified values.\n- NotIn: the requirement is satisfied if the container exit code is\n  not in the set of specified values.";
        type = types.str;
      };
      "values" = mkOption {
        description = "Specifies the set of values to check for container exit codes.\nAt most 255 elements are allowed.";
        type = (types.listOf types.int);
        default = [ ];
      };
    };
  };
  mkTemplateSpecEphemeralContainerRestartPolicyRuleExitCodes =
    res:
    {
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  TemplateSpecEphemeralContainerRestartPolicyRuleModule = types.submodule {
    options = {
      "action" = mkOption {
        description = "Specifies the action taken on a container exit if the requirements\nare satisfied. The only possible value is \"Restart\" to restart the\ncontainer.";
        type = types.str;
      };
      "exitCodes" = mkOption {
        description = "Represents the exit codes to check on container exits.";
        type = (types.nullOr TemplateSpecEphemeralContainerRestartPolicyRuleExitCodesModule);
        default = null;
      };
    };
  };
  mkTemplateSpecEphemeralContainerRestartPolicyRule =
    res:
    {
      inherit (res) "action";
    }
    // optionalAttrs (res."exitCodes" != null) {
      "exitCodes" = mkTemplateSpecEphemeralContainerRestartPolicyRuleExitCodes res."exitCodes";
    }
    // {
    };
  TemplateSpecEphemeralContainerSecurityContextAppArmorProfileModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerSecurityContextAppArmorProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  TemplateSpecEphemeralContainerSecurityContextCapabilitiesModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerSecurityContextCapabilities =
    res:
    {
    }
    // optionalAttrs (res."add" != [ ]) { inherit (res) "add"; }
    // {
    }
    // optionalAttrs (res."drop" != [ ]) { inherit (res) "drop"; }
    // {
    };
  TemplateSpecEphemeralContainerSecurityContextModule = types.submodule {
    options = {
      "allowPrivilegeEscalation" = mkOption {
        description = "AllowPrivilegeEscalation controls whether a process can gain more\nprivileges than its parent process. This bool directly controls if\nthe no_new_privs flag will be set on the container process.\nAllowPrivilegeEscalation is true always when the container is:\n1) run as Privileged\n2) has CAP_SYS_ADMIN\nNote that this field cannot be set when spec.os.name is windows.";
        type = types.bool;
        default = false;
      };
      "appArmorProfile" = mkOption {
        description = "appArmorProfile is the AppArmor options to use by this container. If set, this profile\noverrides the pod's appArmorProfile.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr TemplateSpecEphemeralContainerSecurityContextAppArmorProfileModule);
        default = null;
      };
      "capabilities" = mkOption {
        description = "The capabilities to add/drop when running containers.\nDefaults to the default set of capabilities granted by the container runtime.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr TemplateSpecEphemeralContainerSecurityContextCapabilitiesModule);
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
        type = (types.nullOr TemplateSpecEphemeralContainerSecurityContextSeLinuxOptionsModule);
        default = null;
      };
      "seccompProfile" = mkOption {
        description = "The seccomp options to use by this container. If seccomp options are\nprovided at both the pod & container level, the container options\noverride the pod options.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr TemplateSpecEphemeralContainerSecurityContextSeccompProfileModule);
        default = null;
      };
      "windowsOptions" = mkOption {
        description = "The Windows specific settings applied to all containers.\nIf unspecified, the options from the PodSecurityContext will be used.\nIf set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is linux.";
        type = (types.nullOr TemplateSpecEphemeralContainerSecurityContextWindowsOptionsModule);
        default = null;
      };
    };
  };
  mkTemplateSpecEphemeralContainerSecurityContext =
    res:
    {
    }
    // optionalAttrs res."allowPrivilegeEscalation" { inherit (res) "allowPrivilegeEscalation"; }
    // {
    }
    // optionalAttrs (res."appArmorProfile" != null) {
      "appArmorProfile" =
        mkTemplateSpecEphemeralContainerSecurityContextAppArmorProfile
          res."appArmorProfile";
    }
    // {
    }
    // optionalAttrs (res."capabilities" != null) {
      "capabilities" = mkTemplateSpecEphemeralContainerSecurityContextCapabilities res."capabilities";
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
        mkTemplateSpecEphemeralContainerSecurityContextSeLinuxOptions
          res."seLinuxOptions";
    }
    // {
    }
    // optionalAttrs (res."seccompProfile" != null) {
      "seccompProfile" =
        mkTemplateSpecEphemeralContainerSecurityContextSeccompProfile
          res."seccompProfile";
    }
    // {
    }
    // optionalAttrs (res."windowsOptions" != null) {
      "windowsOptions" =
        mkTemplateSpecEphemeralContainerSecurityContextWindowsOptions
          res."windowsOptions";
    }
    // {
    };
  TemplateSpecEphemeralContainerSecurityContextSeLinuxOptionsModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerSecurityContextSeLinuxOptions =
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
  TemplateSpecEphemeralContainerSecurityContextSeccompProfileModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerSecurityContextSeccompProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  TemplateSpecEphemeralContainerSecurityContextWindowsOptionsModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerSecurityContextWindowsOptions =
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
  TemplateSpecEphemeralContainerStartupProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkTemplateSpecEphemeralContainerStartupProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  TemplateSpecEphemeralContainerStartupProbeGrpcModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerStartupProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  TemplateSpecEphemeralContainerStartupProbeHttpGetHttpHeaderModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerStartupProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  TemplateSpecEphemeralContainerStartupProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf TemplateSpecEphemeralContainerStartupProbeHttpGetHttpHeaderModule);
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
  mkTemplateSpecEphemeralContainerStartupProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" = map mkTemplateSpecEphemeralContainerStartupProbeHttpGetHttpHeader res."httpHeaders";
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
  TemplateSpecEphemeralContainerStartupProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr TemplateSpecEphemeralContainerStartupProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        description = "Minimum consecutive failures for the probe to be considered failed after having succeeded.\nDefaults to 3. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        description = "GRPC specifies a GRPC HealthCheckRequest.";
        type = (types.nullOr TemplateSpecEphemeralContainerStartupProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr TemplateSpecEphemeralContainerStartupProbeHttpGetModule);
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
        type = (types.nullOr TemplateSpecEphemeralContainerStartupProbeTcpSocketModule);
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
  mkTemplateSpecEphemeralContainerStartupProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkTemplateSpecEphemeralContainerStartupProbeExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkTemplateSpecEphemeralContainerStartupProbeGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkTemplateSpecEphemeralContainerStartupProbeHttpGet res."httpGet";
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
      "tcpSocket" = mkTemplateSpecEphemeralContainerStartupProbeTcpSocket res."tcpSocket";
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
  TemplateSpecEphemeralContainerStartupProbeTcpSocketModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerStartupProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  TemplateSpecEphemeralContainerVolumeDeviceModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerVolumeDevice = res: {
    inherit (res) "devicePath";
    inherit (res) "name";
  };
  TemplateSpecEphemeralContainerVolumeMountModule = types.submodule {
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
  mkTemplateSpecEphemeralContainerVolumeMount =
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
  TemplateSpecHostAliaseModule = types.submodule {
    options = {
      "hostnames" = mkOption {
        description = "Hostnames for the above IP address.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "ip" = mkOption {
        description = "IP address of the host file entry.";
        type = types.str;
      };
    };
  };
  mkTemplateSpecHostAliase =
    res:
    {
    }
    // optionalAttrs (res."hostnames" != [ ]) { inherit (res) "hostnames"; }
    // {
      inherit (res) "ip";
    };
  TemplateSpecImagePullSecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkTemplateSpecImagePullSecret =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  TemplateSpecInitContainerEnvFromConfigMapRefModule = types.submodule {
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
  mkTemplateSpecInitContainerEnvFromConfigMapRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TemplateSpecInitContainerEnvFromModule = types.submodule {
    options = {
      "configMapRef" = mkOption {
        description = "The ConfigMap to select from";
        type = (types.nullOr TemplateSpecInitContainerEnvFromConfigMapRefModule);
        default = null;
      };
      "prefix" = mkOption {
        description = "Optional text to prepend to the name of each environment variable.\nMay consist of any printable ASCII characters except '='.";
        type = (types.nullOr types.str);
        default = null;
      };
      "secretRef" = mkOption {
        description = "The Secret to select from";
        type = (types.nullOr TemplateSpecInitContainerEnvFromSecretRefModule);
        default = null;
      };
    };
  };
  mkTemplateSpecInitContainerEnvFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapRef" != null) {
      "configMapRef" = mkTemplateSpecInitContainerEnvFromConfigMapRef res."configMapRef";
    }
    // {
    }
    // optionalAttrs (res."prefix" != null) { inherit (res) "prefix"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkTemplateSpecInitContainerEnvFromSecretRef res."secretRef";
    }
    // {
    };
  TemplateSpecInitContainerEnvFromSecretRefModule = types.submodule {
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
  mkTemplateSpecInitContainerEnvFromSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TemplateSpecInitContainerEnvModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the environment variable.\nMay consist of any printable ASCII characters except '='.";
        type = types.str;
      };
      "value" = mkOption {
        description = "Variable references $(VAR_NAME) are expanded\nusing the previously defined environment variables in the container and\nany service environment variables. If a variable cannot be resolved,\nthe reference in the input string will be unchanged. Double $$ are reduced\nto a single $, which allows for escaping the $(VAR_NAME) syntax: i.e.\n\"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\".\nEscaped references will never be expanded, regardless of whether the variable\nexists or not.\nDefaults to \"\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "valueFrom" = mkOption {
        description = "Source for the environment variable's value. Cannot be used if value is not empty.";
        type = (types.nullOr TemplateSpecInitContainerEnvValueFromModule);
        default = null;
      };
    };
  };
  mkTemplateSpecInitContainerEnv =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    }
    // optionalAttrs (res."valueFrom" != null) {
      "valueFrom" = mkTemplateSpecInitContainerEnvValueFrom res."valueFrom";
    }
    // {
    };
  TemplateSpecInitContainerEnvValueFromConfigMapKeyRefModule = types.submodule {
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
  mkTemplateSpecInitContainerEnvValueFromConfigMapKeyRef =
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
  TemplateSpecInitContainerEnvValueFromFieldRefModule = types.submodule {
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
  mkTemplateSpecInitContainerEnvValueFromFieldRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "fieldPath";
    };
  TemplateSpecInitContainerEnvValueFromFileKeyRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key within the env file. An invalid key will prevent the pod from starting.\nThe keys defined within a source may consist of any printable ASCII characters except '='.\nDuring Alpha stage of the EnvFiles feature gate, the key size is limited to 128 characters.";
        type = types.str;
      };
      "optional" = mkOption {
        description = "Specify whether the file or its key must be defined. If the file or key\ndoes not exist, then the env var is not published.\nIf optional is set to true and the specified key does not exist,\nthe environment variable will not be set in the Pod's containers.\n\nIf optional is set to false and the specified key does not exist,\nan error will be returned during Pod creation.";
        type = types.bool;
        default = false;
      };
      "path" = mkOption {
        description = "The path within the volume from which to select the file.\nMust be relative and may not contain the '..' path or start with '..'.";
        type = types.str;
      };
      "volumeName" = mkOption {
        description = "The name of the volume mount containing the env file.";
        type = types.str;
      };
    };
  };
  mkTemplateSpecInitContainerEnvValueFromFileKeyRef =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
      inherit (res) "path";
      inherit (res) "volumeName";
    };
  TemplateSpecInitContainerEnvValueFromModule = types.submodule {
    options = {
      "configMapKeyRef" = mkOption {
        description = "Selects a key of a ConfigMap.";
        type = (types.nullOr TemplateSpecInitContainerEnvValueFromConfigMapKeyRefModule);
        default = null;
      };
      "fieldRef" = mkOption {
        description = "Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`,\nspec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs.";
        type = (types.nullOr TemplateSpecInitContainerEnvValueFromFieldRefModule);
        default = null;
      };
      "fileKeyRef" = mkOption {
        description = "FileKeyRef selects a key of the env file.\nRequires the EnvFiles feature gate to be enabled.";
        type = (types.nullOr TemplateSpecInitContainerEnvValueFromFileKeyRefModule);
        default = null;
      };
      "resourceFieldRef" = mkOption {
        description = "Selects a resource of the container: only resources limits and requests\n(limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported.";
        type = (types.nullOr TemplateSpecInitContainerEnvValueFromResourceFieldRefModule);
        default = null;
      };
      "secretKeyRef" = mkOption {
        description = "Selects a key of a secret in the pod's namespace";
        type = (types.nullOr TemplateSpecInitContainerEnvValueFromSecretKeyRefModule);
        default = null;
      };
    };
  };
  mkTemplateSpecInitContainerEnvValueFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapKeyRef" != null) {
      "configMapKeyRef" = mkTemplateSpecInitContainerEnvValueFromConfigMapKeyRef res."configMapKeyRef";
    }
    // {
    }
    // optionalAttrs (res."fieldRef" != null) {
      "fieldRef" = mkTemplateSpecInitContainerEnvValueFromFieldRef res."fieldRef";
    }
    // {
    }
    // optionalAttrs (res."fileKeyRef" != null) {
      "fileKeyRef" = mkTemplateSpecInitContainerEnvValueFromFileKeyRef res."fileKeyRef";
    }
    // {
    }
    // optionalAttrs (res."resourceFieldRef" != null) {
      "resourceFieldRef" = mkTemplateSpecInitContainerEnvValueFromResourceFieldRef res."resourceFieldRef";
    }
    // {
    }
    // optionalAttrs (res."secretKeyRef" != null) {
      "secretKeyRef" = mkTemplateSpecInitContainerEnvValueFromSecretKeyRef res."secretKeyRef";
    }
    // {
    };
  TemplateSpecInitContainerEnvValueFromResourceFieldRefModule = types.submodule {
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
  mkTemplateSpecInitContainerEnvValueFromResourceFieldRef =
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
  TemplateSpecInitContainerEnvValueFromSecretKeyRefModule = types.submodule {
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
  mkTemplateSpecInitContainerEnvValueFromSecretKeyRef =
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
  TemplateSpecInitContainerLifecycleModule = types.submodule {
    options = {
      "postStart" = mkOption {
        description = "PostStart is called immediately after a container is created. If the handler fails,\nthe container is terminated and restarted according to its restart policy.\nOther management of the container blocks until the hook completes.\nMore info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks";
        type = (types.nullOr TemplateSpecInitContainerLifecyclePostStartModule);
        default = null;
      };
      "preStop" = mkOption {
        description = "PreStop is called immediately before a container is terminated due to an\nAPI request or management event such as liveness/startup probe failure,\npreemption, resource contention, etc. The handler is not called if the\ncontainer crashes or exits. The Pod's termination grace period countdown begins before the\nPreStop hook is executed. Regardless of the outcome of the handler, the\ncontainer will eventually terminate within the Pod's termination grace\nperiod (unless delayed by finalizers). Other management of the container blocks until the hook completes\nor until the termination grace period is reached.\nMore info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks";
        type = (types.nullOr TemplateSpecInitContainerLifecyclePreStopModule);
        default = null;
      };
      "stopSignal" = mkOption {
        description = "StopSignal defines which signal will be sent to a container when it is being stopped.\nIf not specified, the default is defined by the container runtime in use.\nStopSignal can only be set for Pods with a non-empty .spec.os.name";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTemplateSpecInitContainerLifecycle =
    res:
    {
    }
    // optionalAttrs (res."postStart" != null) {
      "postStart" = mkTemplateSpecInitContainerLifecyclePostStart res."postStart";
    }
    // {
    }
    // optionalAttrs (res."preStop" != null) {
      "preStop" = mkTemplateSpecInitContainerLifecyclePreStop res."preStop";
    }
    // {
    }
    // optionalAttrs (res."stopSignal" != null) { inherit (res) "stopSignal"; }
    // {
    };
  TemplateSpecInitContainerLifecyclePostStartExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkTemplateSpecInitContainerLifecyclePostStartExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  TemplateSpecInitContainerLifecyclePostStartHttpGetHttpHeaderModule = types.submodule {
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
  mkTemplateSpecInitContainerLifecyclePostStartHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  TemplateSpecInitContainerLifecyclePostStartHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf TemplateSpecInitContainerLifecyclePostStartHttpGetHttpHeaderModule);
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
  mkTemplateSpecInitContainerLifecyclePostStartHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" =
        map mkTemplateSpecInitContainerLifecyclePostStartHttpGetHttpHeader
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
  TemplateSpecInitContainerLifecyclePostStartModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr TemplateSpecInitContainerLifecyclePostStartExecModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr TemplateSpecInitContainerLifecyclePostStartHttpGetModule);
        default = null;
      };
      "sleep" = mkOption {
        description = "Sleep represents a duration that the container should sleep.";
        type = (types.nullOr TemplateSpecInitContainerLifecyclePostStartSleepModule);
        default = null;
      };
      "tcpSocket" = mkOption {
        description = "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept\nfor backward compatibility. There is no validation of this field and\nlifecycle hooks will fail at runtime when it is specified.";
        type = (types.nullOr TemplateSpecInitContainerLifecyclePostStartTcpSocketModule);
        default = null;
      };
    };
  };
  mkTemplateSpecInitContainerLifecyclePostStart =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkTemplateSpecInitContainerLifecyclePostStartExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkTemplateSpecInitContainerLifecyclePostStartHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."sleep" != null) {
      "sleep" = mkTemplateSpecInitContainerLifecyclePostStartSleep res."sleep";
    }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" = mkTemplateSpecInitContainerLifecyclePostStartTcpSocket res."tcpSocket";
    }
    // {
    };
  TemplateSpecInitContainerLifecyclePostStartSleepModule = types.submodule {
    options = {
      "seconds" = mkOption {
        description = "Seconds is the number of seconds to sleep.";
        type = types.int;
      };
    };
  };
  mkTemplateSpecInitContainerLifecyclePostStartSleep = res: {
    inherit (res) "seconds";
  };
  TemplateSpecInitContainerLifecyclePostStartTcpSocketModule = types.submodule {
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
  mkTemplateSpecInitContainerLifecyclePostStartTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  TemplateSpecInitContainerLifecyclePreStopExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkTemplateSpecInitContainerLifecyclePreStopExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  TemplateSpecInitContainerLifecyclePreStopHttpGetHttpHeaderModule = types.submodule {
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
  mkTemplateSpecInitContainerLifecyclePreStopHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  TemplateSpecInitContainerLifecyclePreStopHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf TemplateSpecInitContainerLifecyclePreStopHttpGetHttpHeaderModule);
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
  mkTemplateSpecInitContainerLifecyclePreStopHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" = map mkTemplateSpecInitContainerLifecyclePreStopHttpGetHttpHeader res."httpHeaders";
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
  TemplateSpecInitContainerLifecyclePreStopModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr TemplateSpecInitContainerLifecyclePreStopExecModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr TemplateSpecInitContainerLifecyclePreStopHttpGetModule);
        default = null;
      };
      "sleep" = mkOption {
        description = "Sleep represents a duration that the container should sleep.";
        type = (types.nullOr TemplateSpecInitContainerLifecyclePreStopSleepModule);
        default = null;
      };
      "tcpSocket" = mkOption {
        description = "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept\nfor backward compatibility. There is no validation of this field and\nlifecycle hooks will fail at runtime when it is specified.";
        type = (types.nullOr TemplateSpecInitContainerLifecyclePreStopTcpSocketModule);
        default = null;
      };
    };
  };
  mkTemplateSpecInitContainerLifecyclePreStop =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkTemplateSpecInitContainerLifecyclePreStopExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkTemplateSpecInitContainerLifecyclePreStopHttpGet res."httpGet";
    }
    // {
    }
    // optionalAttrs (res."sleep" != null) {
      "sleep" = mkTemplateSpecInitContainerLifecyclePreStopSleep res."sleep";
    }
    // {
    }
    // optionalAttrs (res."tcpSocket" != null) {
      "tcpSocket" = mkTemplateSpecInitContainerLifecyclePreStopTcpSocket res."tcpSocket";
    }
    // {
    };
  TemplateSpecInitContainerLifecyclePreStopSleepModule = types.submodule {
    options = {
      "seconds" = mkOption {
        description = "Seconds is the number of seconds to sleep.";
        type = types.int;
      };
    };
  };
  mkTemplateSpecInitContainerLifecyclePreStopSleep = res: {
    inherit (res) "seconds";
  };
  TemplateSpecInitContainerLifecyclePreStopTcpSocketModule = types.submodule {
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
  mkTemplateSpecInitContainerLifecyclePreStopTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  TemplateSpecInitContainerLivenessProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkTemplateSpecInitContainerLivenessProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  TemplateSpecInitContainerLivenessProbeGrpcModule = types.submodule {
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
  mkTemplateSpecInitContainerLivenessProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  TemplateSpecInitContainerLivenessProbeHttpGetHttpHeaderModule = types.submodule {
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
  mkTemplateSpecInitContainerLivenessProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  TemplateSpecInitContainerLivenessProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf TemplateSpecInitContainerLivenessProbeHttpGetHttpHeaderModule);
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
  mkTemplateSpecInitContainerLivenessProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" = map mkTemplateSpecInitContainerLivenessProbeHttpGetHttpHeader res."httpHeaders";
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
  TemplateSpecInitContainerLivenessProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr TemplateSpecInitContainerLivenessProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        description = "Minimum consecutive failures for the probe to be considered failed after having succeeded.\nDefaults to 3. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        description = "GRPC specifies a GRPC HealthCheckRequest.";
        type = (types.nullOr TemplateSpecInitContainerLivenessProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr TemplateSpecInitContainerLivenessProbeHttpGetModule);
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
        type = (types.nullOr TemplateSpecInitContainerLivenessProbeTcpSocketModule);
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
  mkTemplateSpecInitContainerLivenessProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkTemplateSpecInitContainerLivenessProbeExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkTemplateSpecInitContainerLivenessProbeGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkTemplateSpecInitContainerLivenessProbeHttpGet res."httpGet";
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
      "tcpSocket" = mkTemplateSpecInitContainerLivenessProbeTcpSocket res."tcpSocket";
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
  TemplateSpecInitContainerLivenessProbeTcpSocketModule = types.submodule {
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
  mkTemplateSpecInitContainerLivenessProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  TemplateSpecInitContainerModule = types.submodule {
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
        type = (types.listOf TemplateSpecInitContainerEnvModule);
        default = [ ];
      };
      "envFrom" = mkOption {
        description = "List of sources to populate environment variables in the container.\nThe keys defined within a source may consist of any printable ASCII characters except '='.\nWhen a key exists in multiple\nsources, the value associated with the last source will take precedence.\nValues defined by an Env with a duplicate key will take precedence.\nCannot be updated.";
        type = (types.listOf TemplateSpecInitContainerEnvFromModule);
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
        type = (types.nullOr TemplateSpecInitContainerLifecycleModule);
        default = null;
      };
      "livenessProbe" = mkOption {
        description = "Periodic probe of container liveness.\nContainer will be restarted if the probe fails.\nCannot be updated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr TemplateSpecInitContainerLivenessProbeModule);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the container specified as a DNS_LABEL.\nEach container in a pod must have a unique name (DNS_LABEL).\nCannot be updated.";
        type = types.str;
      };
      "ports" = mkOption {
        description = "List of ports to expose from the container. Not specifying a port here\nDOES NOT prevent that port from being exposed. Any port which is\nlistening on the default \"0.0.0.0\" address inside a container will be\naccessible from the network.\nModifying this array with strategic merge patch may corrupt the data.\nFor more information See https://github.com/kubernetes/kubernetes/issues/108255.\nCannot be updated.";
        type = (types.listOf TemplateSpecInitContainerPortModule);
        default = [ ];
      };
      "readinessProbe" = mkOption {
        description = "Periodic probe of container service readiness.\nContainer will be removed from service endpoints if the probe fails.\nCannot be updated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr TemplateSpecInitContainerReadinessProbeModule);
        default = null;
      };
      "resizePolicy" = mkOption {
        description = "Resources resize policy for the container.\nThis field cannot be set on ephemeral containers.";
        type = (types.listOf TemplateSpecInitContainerResizePolicyModule);
        default = [ ];
      };
      "resources" = mkOption {
        description = "Compute Resources required by this container.\nCannot be updated.\nMore info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.nullOr TemplateSpecInitContainerResourcesModule);
        default = null;
      };
      "restartPolicy" = mkOption {
        description = "RestartPolicy defines the restart behavior of individual containers in a pod.\nThis overrides the pod-level restart policy. When this field is not specified,\nthe restart behavior is defined by the Pod's restart policy and the container type.\nAdditionally, setting the RestartPolicy as \"Always\" for the init container will\nhave the following effect:\nthis init container will be continually restarted on\nexit until all regular containers have terminated. Once all regular\ncontainers have completed, all init containers with restartPolicy \"Always\"\nwill be shut down. This lifecycle differs from normal init containers and\nis often referred to as a \"sidecar\" container. Although this init\ncontainer still starts in the init container sequence, it does not wait\nfor the container to complete before proceeding to the next init\ncontainer. Instead, the next init container starts immediately after this\ninit container is started, or after any startupProbe has successfully\ncompleted.";
        type = (types.nullOr types.str);
        default = null;
      };
      "restartPolicyRules" = mkOption {
        description = "Represents a list of rules to be checked to determine if the\ncontainer should be restarted on exit. The rules are evaluated in\norder. Once a rule matches a container exit condition, the remaining\nrules are ignored. If no rule matches the container exit condition,\nthe Container-level restart policy determines the whether the container\nis restarted or not. Constraints on the rules:\n- At most 20 rules are allowed.\n- Rules can have the same action.\n- Identical rules are not forbidden in validations.\nWhen rules are specified, container MUST set RestartPolicy explicitly\neven it if matches the Pod's RestartPolicy.";
        type = (types.listOf TemplateSpecInitContainerRestartPolicyRuleModule);
        default = [ ];
      };
      "securityContext" = mkOption {
        description = "SecurityContext defines the security options the container should be run with.\nIf set, the fields of SecurityContext override the equivalent fields of PodSecurityContext.\nMore info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/";
        type = (types.nullOr TemplateSpecInitContainerSecurityContextModule);
        default = null;
      };
      "startupProbe" = mkOption {
        description = "StartupProbe indicates that the Pod has successfully initialized.\nIf specified, no other probes are executed until this completes successfully.\nIf this probe fails, the Pod will be restarted, just as if the livenessProbe failed.\nThis can be used to provide different probe parameters at the beginning of a Pod's lifecycle,\nwhen it might take a long time to load data or warm a cache, than during steady-state operation.\nThis cannot be updated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes";
        type = (types.nullOr TemplateSpecInitContainerStartupProbeModule);
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
        type = (types.listOf TemplateSpecInitContainerVolumeDeviceModule);
        default = [ ];
      };
      "volumeMounts" = mkOption {
        description = "Pod volumes to mount into the container's filesystem.\nCannot be updated.";
        type = (types.listOf TemplateSpecInitContainerVolumeMountModule);
        default = [ ];
      };
      "workingDir" = mkOption {
        description = "Container's working directory.\nIf not specified, the container runtime's default will be used, which\nmight be configured in the container image.\nCannot be updated.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTemplateSpecInitContainer =
    res:
    {
    }
    // optionalAttrs (res."args" != [ ]) { inherit (res) "args"; }
    // {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    }
    // optionalAttrs (res."env" != [ ]) { "env" = map mkTemplateSpecInitContainerEnv res."env"; }
    // {
    }
    // optionalAttrs (res."envFrom" != [ ]) {
      "envFrom" = map mkTemplateSpecInitContainerEnvFrom res."envFrom";
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
      "lifecycle" = mkTemplateSpecInitContainerLifecycle res."lifecycle";
    }
    // {
    }
    // optionalAttrs (res."livenessProbe" != null) {
      "livenessProbe" = mkTemplateSpecInitContainerLivenessProbe res."livenessProbe";
    }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."ports" != [ ]) { "ports" = map mkTemplateSpecInitContainerPort res."ports"; }
    // {
    }
    // optionalAttrs (res."readinessProbe" != null) {
      "readinessProbe" = mkTemplateSpecInitContainerReadinessProbe res."readinessProbe";
    }
    // {
    }
    // optionalAttrs (res."resizePolicy" != [ ]) {
      "resizePolicy" = map mkTemplateSpecInitContainerResizePolicy res."resizePolicy";
    }
    // {
    }
    // optionalAttrs (res."resources" != null) {
      "resources" = mkTemplateSpecInitContainerResources res."resources";
    }
    // {
    }
    // optionalAttrs (res."restartPolicy" != null) { inherit (res) "restartPolicy"; }
    // {
    }
    // optionalAttrs (res."restartPolicyRules" != [ ]) {
      "restartPolicyRules" = map mkTemplateSpecInitContainerRestartPolicyRule res."restartPolicyRules";
    }
    // {
    }
    // optionalAttrs (res."securityContext" != null) {
      "securityContext" = mkTemplateSpecInitContainerSecurityContext res."securityContext";
    }
    // {
    }
    // optionalAttrs (res."startupProbe" != null) {
      "startupProbe" = mkTemplateSpecInitContainerStartupProbe res."startupProbe";
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
      "volumeDevices" = map mkTemplateSpecInitContainerVolumeDevice res."volumeDevices";
    }
    // {
    }
    // optionalAttrs (res."volumeMounts" != [ ]) {
      "volumeMounts" = map mkTemplateSpecInitContainerVolumeMount res."volumeMounts";
    }
    // {
    }
    // optionalAttrs (res."workingDir" != null) { inherit (res) "workingDir"; }
    // {
    };
  TemplateSpecInitContainerPortModule = types.submodule {
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
  mkTemplateSpecInitContainerPort =
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
  TemplateSpecInitContainerReadinessProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkTemplateSpecInitContainerReadinessProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  TemplateSpecInitContainerReadinessProbeGrpcModule = types.submodule {
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
  mkTemplateSpecInitContainerReadinessProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  TemplateSpecInitContainerReadinessProbeHttpGetHttpHeaderModule = types.submodule {
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
  mkTemplateSpecInitContainerReadinessProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  TemplateSpecInitContainerReadinessProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf TemplateSpecInitContainerReadinessProbeHttpGetHttpHeaderModule);
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
  mkTemplateSpecInitContainerReadinessProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" = map mkTemplateSpecInitContainerReadinessProbeHttpGetHttpHeader res."httpHeaders";
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
  TemplateSpecInitContainerReadinessProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr TemplateSpecInitContainerReadinessProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        description = "Minimum consecutive failures for the probe to be considered failed after having succeeded.\nDefaults to 3. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        description = "GRPC specifies a GRPC HealthCheckRequest.";
        type = (types.nullOr TemplateSpecInitContainerReadinessProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr TemplateSpecInitContainerReadinessProbeHttpGetModule);
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
        type = (types.nullOr TemplateSpecInitContainerReadinessProbeTcpSocketModule);
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
  mkTemplateSpecInitContainerReadinessProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkTemplateSpecInitContainerReadinessProbeExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkTemplateSpecInitContainerReadinessProbeGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkTemplateSpecInitContainerReadinessProbeHttpGet res."httpGet";
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
      "tcpSocket" = mkTemplateSpecInitContainerReadinessProbeTcpSocket res."tcpSocket";
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
  TemplateSpecInitContainerReadinessProbeTcpSocketModule = types.submodule {
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
  mkTemplateSpecInitContainerReadinessProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  TemplateSpecInitContainerResizePolicyModule = types.submodule {
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
  mkTemplateSpecInitContainerResizePolicy = res: {
    inherit (res) "resourceName";
    inherit (res) "restartPolicy";
  };
  TemplateSpecInitContainerResourcesClaimModule = types.submodule {
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
  mkTemplateSpecInitContainerResourcesClaim =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."request" != null) { inherit (res) "request"; }
    // {
    };
  TemplateSpecInitContainerResourcesModule = types.submodule {
    options = {
      "claims" = mkOption {
        description = "Claims lists the names of resources, defined in spec.resourceClaims,\nthat are used by this container.\n\nThis field depends on the\nDynamicResourceAllocation feature gate.\n\nThis field is immutable. It can only be set for containers.";
        type = (types.listOf TemplateSpecInitContainerResourcesClaimModule);
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
  mkTemplateSpecInitContainerResources =
    res:
    {
    }
    // optionalAttrs (res."claims" != [ ]) {
      "claims" = map mkTemplateSpecInitContainerResourcesClaim res."claims";
    }
    // {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  TemplateSpecInitContainerRestartPolicyRuleExitCodesModule = types.submodule {
    options = {
      "operator" = mkOption {
        description = "Represents the relationship between the container exit code(s) and the\nspecified values. Possible values are:\n- In: the requirement is satisfied if the container exit code is in the\n  set of specified values.\n- NotIn: the requirement is satisfied if the container exit code is\n  not in the set of specified values.";
        type = types.str;
      };
      "values" = mkOption {
        description = "Specifies the set of values to check for container exit codes.\nAt most 255 elements are allowed.";
        type = (types.listOf types.int);
        default = [ ];
      };
    };
  };
  mkTemplateSpecInitContainerRestartPolicyRuleExitCodes =
    res:
    {
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  TemplateSpecInitContainerRestartPolicyRuleModule = types.submodule {
    options = {
      "action" = mkOption {
        description = "Specifies the action taken on a container exit if the requirements\nare satisfied. The only possible value is \"Restart\" to restart the\ncontainer.";
        type = types.str;
      };
      "exitCodes" = mkOption {
        description = "Represents the exit codes to check on container exits.";
        type = (types.nullOr TemplateSpecInitContainerRestartPolicyRuleExitCodesModule);
        default = null;
      };
    };
  };
  mkTemplateSpecInitContainerRestartPolicyRule =
    res:
    {
      inherit (res) "action";
    }
    // optionalAttrs (res."exitCodes" != null) {
      "exitCodes" = mkTemplateSpecInitContainerRestartPolicyRuleExitCodes res."exitCodes";
    }
    // {
    };
  TemplateSpecInitContainerSecurityContextAppArmorProfileModule = types.submodule {
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
  mkTemplateSpecInitContainerSecurityContextAppArmorProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  TemplateSpecInitContainerSecurityContextCapabilitiesModule = types.submodule {
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
  mkTemplateSpecInitContainerSecurityContextCapabilities =
    res:
    {
    }
    // optionalAttrs (res."add" != [ ]) { inherit (res) "add"; }
    // {
    }
    // optionalAttrs (res."drop" != [ ]) { inherit (res) "drop"; }
    // {
    };
  TemplateSpecInitContainerSecurityContextModule = types.submodule {
    options = {
      "allowPrivilegeEscalation" = mkOption {
        description = "AllowPrivilegeEscalation controls whether a process can gain more\nprivileges than its parent process. This bool directly controls if\nthe no_new_privs flag will be set on the container process.\nAllowPrivilegeEscalation is true always when the container is:\n1) run as Privileged\n2) has CAP_SYS_ADMIN\nNote that this field cannot be set when spec.os.name is windows.";
        type = types.bool;
        default = false;
      };
      "appArmorProfile" = mkOption {
        description = "appArmorProfile is the AppArmor options to use by this container. If set, this profile\noverrides the pod's appArmorProfile.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr TemplateSpecInitContainerSecurityContextAppArmorProfileModule);
        default = null;
      };
      "capabilities" = mkOption {
        description = "The capabilities to add/drop when running containers.\nDefaults to the default set of capabilities granted by the container runtime.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr TemplateSpecInitContainerSecurityContextCapabilitiesModule);
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
        type = (types.nullOr TemplateSpecInitContainerSecurityContextSeLinuxOptionsModule);
        default = null;
      };
      "seccompProfile" = mkOption {
        description = "The seccomp options to use by this container. If seccomp options are\nprovided at both the pod & container level, the container options\noverride the pod options.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr TemplateSpecInitContainerSecurityContextSeccompProfileModule);
        default = null;
      };
      "windowsOptions" = mkOption {
        description = "The Windows specific settings applied to all containers.\nIf unspecified, the options from the PodSecurityContext will be used.\nIf set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is linux.";
        type = (types.nullOr TemplateSpecInitContainerSecurityContextWindowsOptionsModule);
        default = null;
      };
    };
  };
  mkTemplateSpecInitContainerSecurityContext =
    res:
    {
    }
    // optionalAttrs res."allowPrivilegeEscalation" { inherit (res) "allowPrivilegeEscalation"; }
    // {
    }
    // optionalAttrs (res."appArmorProfile" != null) {
      "appArmorProfile" = mkTemplateSpecInitContainerSecurityContextAppArmorProfile res."appArmorProfile";
    }
    // {
    }
    // optionalAttrs (res."capabilities" != null) {
      "capabilities" = mkTemplateSpecInitContainerSecurityContextCapabilities res."capabilities";
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
      "seLinuxOptions" = mkTemplateSpecInitContainerSecurityContextSeLinuxOptions res."seLinuxOptions";
    }
    // {
    }
    // optionalAttrs (res."seccompProfile" != null) {
      "seccompProfile" = mkTemplateSpecInitContainerSecurityContextSeccompProfile res."seccompProfile";
    }
    // {
    }
    // optionalAttrs (res."windowsOptions" != null) {
      "windowsOptions" = mkTemplateSpecInitContainerSecurityContextWindowsOptions res."windowsOptions";
    }
    // {
    };
  TemplateSpecInitContainerSecurityContextSeLinuxOptionsModule = types.submodule {
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
  mkTemplateSpecInitContainerSecurityContextSeLinuxOptions =
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
  TemplateSpecInitContainerSecurityContextSeccompProfileModule = types.submodule {
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
  mkTemplateSpecInitContainerSecurityContextSeccompProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  TemplateSpecInitContainerSecurityContextWindowsOptionsModule = types.submodule {
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
  mkTemplateSpecInitContainerSecurityContextWindowsOptions =
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
  TemplateSpecInitContainerStartupProbeExecModule = types.submodule {
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the\ncommand  is root ('/') in the container's filesystem. The command is simply exec'd, it is\nnot run inside a shell, so traditional shell instructions ('|', etc) won't work. To use\na shell, you need to explicitly call out to that shell.\nExit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkTemplateSpecInitContainerStartupProbeExec =
    res:
    {
    }
    // optionalAttrs (res."command" != [ ]) { inherit (res) "command"; }
    // {
    };
  TemplateSpecInitContainerStartupProbeGrpcModule = types.submodule {
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
  mkTemplateSpecInitContainerStartupProbeGrpc =
    res:
    {
      inherit (res) "port";
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    };
  TemplateSpecInitContainerStartupProbeHttpGetHttpHeaderModule = types.submodule {
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
  mkTemplateSpecInitContainerStartupProbeHttpGetHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  TemplateSpecInitContainerStartupProbeHttpGetModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set\n\"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf TemplateSpecInitContainerStartupProbeHttpGetHttpHeaderModule);
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
  mkTemplateSpecInitContainerStartupProbeHttpGet =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."httpHeaders" != [ ]) {
      "httpHeaders" = map mkTemplateSpecInitContainerStartupProbeHttpGetHttpHeader res."httpHeaders";
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
  TemplateSpecInitContainerStartupProbeModule = types.submodule {
    options = {
      "exec" = mkOption {
        description = "Exec specifies a command to execute in the container.";
        type = (types.nullOr TemplateSpecInitContainerStartupProbeExecModule);
        default = null;
      };
      "failureThreshold" = mkOption {
        description = "Minimum consecutive failures for the probe to be considered failed after having succeeded.\nDefaults to 3. Minimum value is 1.";
        type = (types.nullOr types.int);
        default = null;
      };
      "grpc" = mkOption {
        description = "GRPC specifies a GRPC HealthCheckRequest.";
        type = (types.nullOr TemplateSpecInitContainerStartupProbeGrpcModule);
        default = null;
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies an HTTP GET request to perform.";
        type = (types.nullOr TemplateSpecInitContainerStartupProbeHttpGetModule);
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
        type = (types.nullOr TemplateSpecInitContainerStartupProbeTcpSocketModule);
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
  mkTemplateSpecInitContainerStartupProbe =
    res:
    {
    }
    // optionalAttrs (res."exec" != null) {
      "exec" = mkTemplateSpecInitContainerStartupProbeExec res."exec";
    }
    // {
    }
    // optionalAttrs (res."failureThreshold" != null) { inherit (res) "failureThreshold"; }
    // {
    }
    // optionalAttrs (res."grpc" != null) {
      "grpc" = mkTemplateSpecInitContainerStartupProbeGrpc res."grpc";
    }
    // {
    }
    // optionalAttrs (res."httpGet" != null) {
      "httpGet" = mkTemplateSpecInitContainerStartupProbeHttpGet res."httpGet";
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
      "tcpSocket" = mkTemplateSpecInitContainerStartupProbeTcpSocket res."tcpSocket";
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
  TemplateSpecInitContainerStartupProbeTcpSocketModule = types.submodule {
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
  mkTemplateSpecInitContainerStartupProbeTcpSocket =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
      inherit (res) "port";
    };
  TemplateSpecInitContainerVolumeDeviceModule = types.submodule {
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
  mkTemplateSpecInitContainerVolumeDevice = res: {
    inherit (res) "devicePath";
    inherit (res) "name";
  };
  TemplateSpecInitContainerVolumeMountModule = types.submodule {
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
  mkTemplateSpecInitContainerVolumeMount =
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
  TemplateSpecModule = types.submodule {
    options = {
      "activeDeadlineSeconds" = mkOption {
        description = "Optional duration in seconds the pod may be active on the node relative to\nStartTime before the system will actively try to mark it failed and kill associated containers.\nValue must be a positive integer.";
        type = (types.nullOr types.int);
        default = null;
      };
      "affinity" = mkOption {
        description = "If specified, the pod's scheduling constraints";
        type = (types.nullOr TemplateSpecAffinityModule);
        default = null;
      };
      "automountServiceAccountToken" = mkOption {
        description = "AutomountServiceAccountToken indicates whether a service account token should be automatically mounted.";
        type = types.bool;
        default = false;
      };
      "containers" = mkOption {
        description = "List of containers belonging to the pod.\nContainers cannot currently be added or removed.\nThere must be at least one container in a Pod.\nCannot be updated.";
        type = (types.listOf TemplateSpecContainerModule);
      };
      "dnsConfig" = mkOption {
        description = "Specifies the DNS parameters of a pod.\nParameters specified here will be merged to the generated DNS\nconfiguration based on DNSPolicy.";
        type = (types.nullOr TemplateSpecDnsConfigModule);
        default = null;
      };
      "dnsPolicy" = mkOption {
        description = "Set DNS policy for the pod.\nDefaults to \"ClusterFirst\".\nValid values are 'ClusterFirstWithHostNet', 'ClusterFirst', 'Default' or 'None'.\nDNS parameters given in DNSConfig will be merged with the policy selected with DNSPolicy.\nTo have DNS options set along with hostNetwork, you have to specify DNS policy\nexplicitly to 'ClusterFirstWithHostNet'.";
        type = (types.nullOr types.str);
        default = null;
      };
      "enableServiceLinks" = mkOption {
        description = "EnableServiceLinks indicates whether information about services should be injected into pod's\nenvironment variables, matching the syntax of Docker links.\nOptional: Defaults to true.";
        type = types.bool;
        default = false;
      };
      "ephemeralContainers" = mkOption {
        description = "List of ephemeral containers run in this pod. Ephemeral containers may be run in an existing\npod to perform user-initiated actions such as debugging. This list cannot be specified when\ncreating a pod, and it cannot be modified by updating the pod spec. In order to add an\nephemeral container to an existing pod, use the pod's ephemeralcontainers subresource.";
        type = (types.listOf TemplateSpecEphemeralContainerModule);
        default = [ ];
      };
      "hostAliases" = mkOption {
        description = "HostAliases is an optional list of hosts and IPs that will be injected into the pod's hosts\nfile if specified.";
        type = (types.listOf TemplateSpecHostAliaseModule);
        default = [ ];
      };
      "hostIPC" = mkOption {
        description = "Use the host's ipc namespace.\nOptional: Default to false.";
        type = types.bool;
        default = false;
      };
      "hostNetwork" = mkOption {
        description = "Host networking requested for this pod. Use the host's network namespace.\nWhen using HostNetwork you should specify ports so the scheduler is aware.\nWhen `hostNetwork` is true, specified `hostPort` fields in port definitions must match `containerPort`,\nand unspecified `hostPort` fields in port definitions are defaulted to match `containerPort`.\nDefault to false.";
        type = types.bool;
        default = false;
      };
      "hostPID" = mkOption {
        description = "Use the host's pid namespace.\nOptional: Default to false.";
        type = types.bool;
        default = false;
      };
      "hostUsers" = mkOption {
        description = "Use the host's user namespace.\nOptional: Default to true.\nIf set to true or not present, the pod will be run in the host user namespace, useful\nfor when the pod needs a feature only available to the host user namespace, such as\nloading a kernel module with CAP_SYS_MODULE.\nWhen set to false, a new userns is created for the pod. Setting false is useful for\nmitigating container breakout vulnerabilities even allowing users to run their\ncontainers as root without actually having root privileges on the host.\nThis field is alpha-level and is only honored by servers that enable the UserNamespacesSupport feature.";
        type = types.bool;
        default = false;
      };
      "hostname" = mkOption {
        description = "Specifies the hostname of the Pod\nIf not specified, the pod's hostname will be set to a system-defined value.";
        type = (types.nullOr types.str);
        default = null;
      };
      "hostnameOverride" = mkOption {
        description = "HostnameOverride specifies an explicit override for the pod's hostname as perceived by the pod.\nThis field only specifies the pod's hostname and does not affect its DNS records.\nWhen this field is set to a non-empty string:\n- It takes precedence over the values set in `hostname` and `subdomain`.\n- The Pod's hostname will be set to this value.\n- `setHostnameAsFQDN` must be nil or set to false.\n- `hostNetwork` must be set to false.\n\nThis field must be a valid DNS subdomain as defined in RFC 1123 and contain at most 64 characters.\nRequires the HostnameOverride feature gate to be enabled.";
        type = (types.nullOr types.str);
        default = null;
      };
      "imagePullSecrets" = mkOption {
        description = "ImagePullSecrets is an optional list of references to secrets in the same namespace to use for pulling any of the images used by this PodSpec.\nIf specified, these secrets will be passed to individual puller implementations for them to use.\nMore info: https://kubernetes.io/docs/concepts/containers/images#specifying-imagepullsecrets-on-a-pod";
        type = (types.listOf TemplateSpecImagePullSecretModule);
        default = [ ];
      };
      "initContainers" = mkOption {
        description = "List of initialization containers belonging to the pod.\nInit containers are executed in order prior to containers being started. If any\ninit container fails, the pod is considered to have failed and is handled according\nto its restartPolicy. The name for an init container or normal container must be\nunique among all containers.\nInit containers may not have Lifecycle actions, Readiness probes, Liveness probes, or Startup probes.\nThe resourceRequirements of an init container are taken into account during scheduling\nby finding the highest request/limit for each resource type, and then using the max of\nthat value or the sum of the normal containers. Limits are applied to init containers\nin a similar fashion.\nInit containers cannot currently be added or removed.\nCannot be updated.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/";
        type = (types.listOf TemplateSpecInitContainerModule);
        default = [ ];
      };
      "nodeName" = mkOption {
        description = "NodeName indicates in which node this pod is scheduled.\nIf empty, this pod is a candidate for scheduling by the scheduler defined in schedulerName.\nOnce this field is set, the kubelet for this node becomes responsible for the lifecycle of this pod.\nThis field should not be used to express a desire for the pod to be scheduled on a specific node.\nhttps://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodename";
        type = (types.nullOr types.str);
        default = null;
      };
      "nodeSelector" = mkOption {
        description = "NodeSelector is a selector which must be true for the pod to fit on a node.\nSelector which must match a node's labels for the pod to be scheduled on that node.\nMore info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/";
        type = (types.attrsOf types.str);
        default = { };
      };
      "os" = mkOption {
        description = "Specifies the OS of the containers in the pod.\nSome pod and container fields are restricted if this is set.\n\nIf the OS field is set to linux, the following fields must be unset:\n-securityContext.windowsOptions\n\nIf the OS field is set to windows, following fields must be unset:\n- spec.hostPID\n- spec.hostIPC\n- spec.hostUsers\n- spec.resources\n- spec.securityContext.appArmorProfile\n- spec.securityContext.seLinuxOptions\n- spec.securityContext.seccompProfile\n- spec.securityContext.fsGroup\n- spec.securityContext.fsGroupChangePolicy\n- spec.securityContext.sysctls\n- spec.shareProcessNamespace\n- spec.securityContext.runAsUser\n- spec.securityContext.runAsGroup\n- spec.securityContext.supplementalGroups\n- spec.securityContext.supplementalGroupsPolicy\n- spec.containers[*].securityContext.appArmorProfile\n- spec.containers[*].securityContext.seLinuxOptions\n- spec.containers[*].securityContext.seccompProfile\n- spec.containers[*].securityContext.capabilities\n- spec.containers[*].securityContext.readOnlyRootFilesystem\n- spec.containers[*].securityContext.privileged\n- spec.containers[*].securityContext.allowPrivilegeEscalation\n- spec.containers[*].securityContext.procMount\n- spec.containers[*].securityContext.runAsUser\n- spec.containers[*].securityContext.runAsGroup";
        type = (types.nullOr TemplateSpecOsModule);
        default = null;
      };
      "overhead" = mkOption {
        description = "Overhead represents the resource overhead associated with running a pod for a given RuntimeClass.\nThis field will be autopopulated at admission time by the RuntimeClass admission controller. If\nthe RuntimeClass admission controller is enabled, overhead must not be set in Pod create requests.\nThe RuntimeClass admission controller will reject Pod create requests which have the overhead already\nset. If RuntimeClass is configured and selected in the PodSpec, Overhead will be set to the value\ndefined in the corresponding RuntimeClass, otherwise it will remain unset and treated as zero.\nMore info: https://git.k8s.io/enhancements/keps/sig-node/688-pod-overhead/README.md";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "preemptionPolicy" = mkOption {
        description = "PreemptionPolicy is the Policy for preempting pods with lower priority.\nOne of Never, PreemptLowerPriority.\nDefaults to PreemptLowerPriority if unset.";
        type = (types.nullOr types.str);
        default = null;
      };
      "priority" = mkOption {
        description = "The priority value. Various system components use this field to find the\npriority of the pod. When Priority Admission Controller is enabled, it\nprevents users from setting this field. The admission controller populates\nthis field from PriorityClassName.\nThe higher the value, the higher the priority.";
        type = (types.nullOr types.int);
        default = null;
      };
      "priorityClassName" = mkOption {
        description = "If specified, indicates the pod's priority. \"system-node-critical\" and\n\"system-cluster-critical\" are two special keywords which indicate the\nhighest priorities with the former being the highest priority. Any other\nname must be defined by creating a PriorityClass object with that name.\nIf not specified, the pod priority will be default or zero if there is no\ndefault.";
        type = (types.nullOr types.str);
        default = null;
      };
      "readinessGates" = mkOption {
        description = "If specified, all readiness gates will be evaluated for pod readiness.\nA pod is ready when all its containers are ready AND\nall conditions specified in the readiness gates have status equal to \"True\"\nMore info: https://git.k8s.io/enhancements/keps/sig-network/580-pod-readiness-gates";
        type = (types.listOf TemplateSpecReadinessGateModule);
        default = [ ];
      };
      "resourceClaims" = mkOption {
        description = "ResourceClaims defines which ResourceClaims must be allocated\nand reserved before the Pod is allowed to start. The resources\nwill be made available to those containers which consume them\nby name.\n\nThis is a stable field but requires that the\nDynamicResourceAllocation feature gate is enabled.\n\nThis field is immutable.";
        type = (types.listOf TemplateSpecResourceClaimModule);
        default = [ ];
      };
      "resources" = mkOption {
        description = "Resources is the total amount of CPU and Memory resources required by all\ncontainers in the pod. It supports specifying Requests and Limits for\n\"cpu\", \"memory\" and \"hugepages-\" resource names only. ResourceClaims are not supported.\n\nThis field enables fine-grained control over resource allocation for the\nentire pod, allowing resource sharing among containers in a pod.\n\nThis is an alpha field and requires enabling the PodLevelResources feature\ngate.";
        type = (types.nullOr TemplateSpecResourcesModule);
        default = null;
      };
      "restartPolicy" = mkOption {
        description = "Restart policy for all containers within the pod.\nOne of Always, OnFailure, Never. In some contexts, only a subset of those values may be permitted.\nDefault to Always.\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#restart-policy";
        type = (types.nullOr types.str);
        default = null;
      };
      "runtimeClassName" = mkOption {
        description = "RuntimeClassName refers to a RuntimeClass object in the node.k8s.io group, which should be used\nto run this pod.  If no RuntimeClass resource matches the named class, the pod will not be run.\nIf unset or empty, the \"legacy\" RuntimeClass will be used, which is an implicit class with an\nempty definition that uses the default runtime handler.\nMore info: https://git.k8s.io/enhancements/keps/sig-node/585-runtime-class";
        type = (types.nullOr types.str);
        default = null;
      };
      "schedulerName" = mkOption {
        description = "If specified, the pod will be dispatched by specified scheduler.\nIf not specified, the pod will be dispatched by default scheduler.";
        type = (types.nullOr types.str);
        default = null;
      };
      "schedulingGates" = mkOption {
        description = "SchedulingGates is an opaque list of values that if specified will block scheduling the pod.\nIf schedulingGates is not empty, the pod will stay in the SchedulingGated state and the\nscheduler will not attempt to schedule the pod.\n\nSchedulingGates can only be set at pod creation time, and be removed only afterwards.";
        type = (types.listOf TemplateSpecSchedulingGateModule);
        default = [ ];
      };
      "securityContext" = mkOption {
        description = "SecurityContext holds pod-level security attributes and common container settings.\nOptional: Defaults to empty.  See type description for default values of each field.";
        type = (types.nullOr TemplateSpecSecurityContextModule);
        default = null;
      };
      "serviceAccount" = mkOption {
        description = "DeprecatedServiceAccount is a deprecated alias for ServiceAccountName.\nDeprecated: Use serviceAccountName instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "serviceAccountName" = mkOption {
        description = "ServiceAccountName is the name of the ServiceAccount to use to run this pod.\nMore info: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/";
        type = (types.nullOr types.str);
        default = null;
      };
      "setHostnameAsFQDN" = mkOption {
        description = "If true the pod's hostname will be configured as the pod's FQDN, rather than the leaf name (the default).\nIn Linux containers, this means setting the FQDN in the hostname field of the kernel (the nodename field of struct utsname).\nIn Windows containers, this means setting the registry value of hostname for the registry key HKEY_LOCAL_MACHINE\\\\SYSTEM\\\\CurrentControlSet\\\\Services\\\\Tcpip\\\\Parameters to FQDN.\nIf a pod does not have FQDN, this has no effect.\nDefault to false.";
        type = types.bool;
        default = false;
      };
      "shareProcessNamespace" = mkOption {
        description = "Share a single process namespace between all of the containers in a pod.\nWhen this is set containers will be able to view and signal processes from other containers\nin the same pod, and the first process in each container will not be assigned PID 1.\nHostPID and ShareProcessNamespace cannot both be set.\nOptional: Default to false.";
        type = types.bool;
        default = false;
      };
      "subdomain" = mkOption {
        description = "If specified, the fully qualified Pod hostname will be \"<hostname>.<subdomain>.<pod namespace>.svc.<cluster domain>\".\nIf not specified, the pod will not have a domainname at all.";
        type = (types.nullOr types.str);
        default = null;
      };
      "terminationGracePeriodSeconds" = mkOption {
        description = "Optional duration in seconds the pod needs to terminate gracefully. May be decreased in delete request.\nValue must be non-negative integer. The value zero indicates stop immediately via\nthe kill signal (no opportunity to shut down).\nIf this value is nil, the default grace period will be used instead.\nThe grace period is the duration in seconds after the processes running in the pod are sent\na termination signal and the time when the processes are forcibly halted with a kill signal.\nSet this value longer than the expected cleanup time for your process.\nDefaults to 30 seconds.";
        type = (types.nullOr types.int);
        default = null;
      };
      "tolerations" = mkOption {
        description = "If specified, the pod's tolerations.";
        type = (types.listOf TemplateSpecTolerationModule);
        default = [ ];
      };
      "topologySpreadConstraints" = mkOption {
        description = "TopologySpreadConstraints describes how a group of pods ought to spread across topology\ndomains. Scheduler will schedule pods in a way which abides by the constraints.\nAll topologySpreadConstraints are ANDed.";
        type = (types.listOf TemplateSpecTopologySpreadConstraintModule);
        default = [ ];
      };
      "volumes" = mkOption {
        description = "List of volumes that can be mounted by containers belonging to the pod.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes";
        type = (types.listOf TemplateSpecVolumeModule);
        default = [ ];
      };
      "workloadRef" = mkOption {
        description = "WorkloadRef provides a reference to the Workload object that this Pod belongs to.\nThis field is used by the scheduler to identify the PodGroup and apply the\ncorrect group scheduling policies. The Workload object referenced\nby this field may not exist at the time the Pod is created.\nThis field is immutable, but a Workload object with the same name\nmay be recreated with different policies. Doing this during pod scheduling\nmay result in the placement not conforming to the expected policies.";
        type = (types.nullOr TemplateSpecWorkloadRefModule);
        default = null;
      };
    };
  };
  mkTemplateSpec =
    res:
    {
    }
    // optionalAttrs (res."activeDeadlineSeconds" != null) { inherit (res) "activeDeadlineSeconds"; }
    // {
    }
    // optionalAttrs (res."affinity" != null) { "affinity" = mkTemplateSpecAffinity res."affinity"; }
    // {
    }
    // optionalAttrs res."automountServiceAccountToken" {
      inherit (res) "automountServiceAccountToken";
    }
    // {
      "containers" = map mkTemplateSpecContainer res."containers";
    }
    // optionalAttrs (res."dnsConfig" != null) {
      "dnsConfig" = mkTemplateSpecDnsConfig res."dnsConfig";
    }
    // {
    }
    // optionalAttrs (res."dnsPolicy" != null) { inherit (res) "dnsPolicy"; }
    // {
    }
    // optionalAttrs res."enableServiceLinks" { inherit (res) "enableServiceLinks"; }
    // {
    }
    // optionalAttrs (res."ephemeralContainers" != [ ]) {
      "ephemeralContainers" = map mkTemplateSpecEphemeralContainer res."ephemeralContainers";
    }
    // {
    }
    // optionalAttrs (res."hostAliases" != [ ]) {
      "hostAliases" = map mkTemplateSpecHostAliase res."hostAliases";
    }
    // {
    }
    // optionalAttrs res."hostIPC" { inherit (res) "hostIPC"; }
    // {
    }
    // optionalAttrs res."hostNetwork" { inherit (res) "hostNetwork"; }
    // {
    }
    // optionalAttrs res."hostPID" { inherit (res) "hostPID"; }
    // {
    }
    // optionalAttrs res."hostUsers" { inherit (res) "hostUsers"; }
    // {
    }
    // optionalAttrs (res."hostname" != null) { inherit (res) "hostname"; }
    // {
    }
    // optionalAttrs (res."hostnameOverride" != null) { inherit (res) "hostnameOverride"; }
    // {
    }
    // optionalAttrs (res."imagePullSecrets" != [ ]) {
      "imagePullSecrets" = map mkTemplateSpecImagePullSecret res."imagePullSecrets";
    }
    // {
    }
    // optionalAttrs (res."initContainers" != [ ]) {
      "initContainers" = map mkTemplateSpecInitContainer res."initContainers";
    }
    // {
    }
    // optionalAttrs (res."nodeName" != null) { inherit (res) "nodeName"; }
    // {
    }
    // optionalAttrs (res."nodeSelector" != { }) { inherit (res) "nodeSelector"; }
    // {
    }
    // optionalAttrs (res."os" != null) { "os" = mkTemplateSpecOs res."os"; }
    // {
    }
    // optionalAttrs (res."overhead" != { }) { inherit (res) "overhead"; }
    // {
    }
    // optionalAttrs (res."preemptionPolicy" != null) { inherit (res) "preemptionPolicy"; }
    // {
    }
    // optionalAttrs (res."priority" != null) { inherit (res) "priority"; }
    // {
    }
    // optionalAttrs (res."priorityClassName" != null) { inherit (res) "priorityClassName"; }
    // {
    }
    // optionalAttrs (res."readinessGates" != [ ]) {
      "readinessGates" = map mkTemplateSpecReadinessGate res."readinessGates";
    }
    // {
    }
    // optionalAttrs (res."resourceClaims" != [ ]) {
      "resourceClaims" = map mkTemplateSpecResourceClaim res."resourceClaims";
    }
    // {
    }
    // optionalAttrs (res."resources" != null) {
      "resources" = mkTemplateSpecResources res."resources";
    }
    // {
    }
    // optionalAttrs (res."restartPolicy" != null) { inherit (res) "restartPolicy"; }
    // {
    }
    // optionalAttrs (res."runtimeClassName" != null) { inherit (res) "runtimeClassName"; }
    // {
    }
    // optionalAttrs (res."schedulerName" != null) { inherit (res) "schedulerName"; }
    // {
    }
    // optionalAttrs (res."schedulingGates" != [ ]) {
      "schedulingGates" = map mkTemplateSpecSchedulingGate res."schedulingGates";
    }
    // {
    }
    // optionalAttrs (res."securityContext" != null) {
      "securityContext" = mkTemplateSpecSecurityContext res."securityContext";
    }
    // {
    }
    // optionalAttrs (res."serviceAccount" != null) { inherit (res) "serviceAccount"; }
    // {
    }
    // optionalAttrs (res."serviceAccountName" != null) { inherit (res) "serviceAccountName"; }
    // {
    }
    // optionalAttrs res."setHostnameAsFQDN" { inherit (res) "setHostnameAsFQDN"; }
    // {
    }
    // optionalAttrs res."shareProcessNamespace" { inherit (res) "shareProcessNamespace"; }
    // {
    }
    // optionalAttrs (res."subdomain" != null) { inherit (res) "subdomain"; }
    // {
    }
    // optionalAttrs (res."terminationGracePeriodSeconds" != null) {
      inherit (res) "terminationGracePeriodSeconds";
    }
    // {
    }
    // optionalAttrs (res."tolerations" != [ ]) {
      "tolerations" = map mkTemplateSpecToleration res."tolerations";
    }
    // {
    }
    // optionalAttrs (res."topologySpreadConstraints" != [ ]) {
      "topologySpreadConstraints" =
        map mkTemplateSpecTopologySpreadConstraint
          res."topologySpreadConstraints";
    }
    // {
    }
    // optionalAttrs (res."volumes" != [ ]) { "volumes" = map mkTemplateSpecVolume res."volumes"; }
    // {
    }
    // optionalAttrs (res."workloadRef" != null) {
      "workloadRef" = mkTemplateSpecWorkloadRef res."workloadRef";
    }
    // {
    };
  TemplateSpecOsModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the name of the operating system. The currently supported values are linux and windows.\nAdditional value may be defined in future and can be one of:\nhttps://github.com/opencontainers/runtime-spec/blob/master/config.md#platform-specific-configuration\nClients should expect to handle additional values and treat unrecognized values in this field as os: null";
        type = types.str;
      };
    };
  };
  mkTemplateSpecOs = res: {
    inherit (res) "name";
  };
  TemplateSpecReadinessGateModule = types.submodule {
    options = {
      "conditionType" = mkOption {
        description = "ConditionType refers to a condition in the pod's condition list with matching type.";
        type = types.str;
      };
    };
  };
  mkTemplateSpecReadinessGate = res: {
    inherit (res) "conditionType";
  };
  TemplateSpecResourceClaimModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name uniquely identifies this resource claim inside the pod.\nThis must be a DNS_LABEL.";
        type = types.str;
      };
      "resourceClaimName" = mkOption {
        description = "ResourceClaimName is the name of a ResourceClaim object in the same\nnamespace as this pod.\n\nExactly one of ResourceClaimName and ResourceClaimTemplateName must\nbe set.";
        type = (types.nullOr types.str);
        default = null;
      };
      "resourceClaimTemplateName" = mkOption {
        description = "ResourceClaimTemplateName is the name of a ResourceClaimTemplate\nobject in the same namespace as this pod.\n\nThe template will be used to create a new ResourceClaim, which will\nbe bound to this pod. When this pod is deleted, the ResourceClaim\nwill also be deleted. The pod name and resource name, along with a\ngenerated component, will be used to form a unique name for the\nResourceClaim, which will be recorded in pod.status.resourceClaimStatuses.\n\nThis field is immutable and no changes will be made to the\ncorresponding ResourceClaim by the control plane after creating the\nResourceClaim.\n\nExactly one of ResourceClaimName and ResourceClaimTemplateName must\nbe set.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTemplateSpecResourceClaim =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."resourceClaimName" != null) { inherit (res) "resourceClaimName"; }
    // {
    }
    // optionalAttrs (res."resourceClaimTemplateName" != null) {
      inherit (res) "resourceClaimTemplateName";
    }
    // {
    };
  TemplateSpecResourcesClaimModule = types.submodule {
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
  mkTemplateSpecResourcesClaim =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."request" != null) { inherit (res) "request"; }
    // {
    };
  TemplateSpecResourcesModule = types.submodule {
    options = {
      "claims" = mkOption {
        description = "Claims lists the names of resources, defined in spec.resourceClaims,\nthat are used by this container.\n\nThis field depends on the\nDynamicResourceAllocation feature gate.\n\nThis field is immutable. It can only be set for containers.";
        type = (types.listOf TemplateSpecResourcesClaimModule);
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
  mkTemplateSpecResources =
    res:
    {
    }
    // optionalAttrs (res."claims" != [ ]) { "claims" = map mkTemplateSpecResourcesClaim res."claims"; }
    // {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  TemplateSpecSchedulingGateModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the scheduling gate.\nEach scheduling gate must have a unique name field.";
        type = types.str;
      };
    };
  };
  mkTemplateSpecSchedulingGate = res: {
    inherit (res) "name";
  };
  TemplateSpecSecurityContextAppArmorProfileModule = types.submodule {
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
  mkTemplateSpecSecurityContextAppArmorProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  TemplateSpecSecurityContextModule = types.submodule {
    options = {
      "appArmorProfile" = mkOption {
        description = "appArmorProfile is the AppArmor options to use by the containers in this pod.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr TemplateSpecSecurityContextAppArmorProfileModule);
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
        type = (types.nullOr TemplateSpecSecurityContextSeLinuxOptionsModule);
        default = null;
      };
      "seccompProfile" = mkOption {
        description = "The seccomp options to use by the containers in this pod.\nNote that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr TemplateSpecSecurityContextSeccompProfileModule);
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
        type = (types.listOf TemplateSpecSecurityContextSysctlModule);
        default = [ ];
      };
      "windowsOptions" = mkOption {
        description = "The Windows specific settings applied to all containers.\nIf unspecified, the options within a container's SecurityContext will be used.\nIf set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.\nNote that this field cannot be set when spec.os.name is linux.";
        type = (types.nullOr TemplateSpecSecurityContextWindowsOptionsModule);
        default = null;
      };
    };
  };
  mkTemplateSpecSecurityContext =
    res:
    {
    }
    // optionalAttrs (res."appArmorProfile" != null) {
      "appArmorProfile" = mkTemplateSpecSecurityContextAppArmorProfile res."appArmorProfile";
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
      "seLinuxOptions" = mkTemplateSpecSecurityContextSeLinuxOptions res."seLinuxOptions";
    }
    // {
    }
    // optionalAttrs (res."seccompProfile" != null) {
      "seccompProfile" = mkTemplateSpecSecurityContextSeccompProfile res."seccompProfile";
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
      "sysctls" = map mkTemplateSpecSecurityContextSysctl res."sysctls";
    }
    // {
    }
    // optionalAttrs (res."windowsOptions" != null) {
      "windowsOptions" = mkTemplateSpecSecurityContextWindowsOptions res."windowsOptions";
    }
    // {
    };
  TemplateSpecSecurityContextSeLinuxOptionsModule = types.submodule {
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
  mkTemplateSpecSecurityContextSeLinuxOptions =
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
  TemplateSpecSecurityContextSeccompProfileModule = types.submodule {
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
  mkTemplateSpecSecurityContextSeccompProfile =
    res:
    {
    }
    // optionalAttrs (res."localhostProfile" != null) { inherit (res) "localhostProfile"; }
    // {
      inherit (res) "type";
    };
  TemplateSpecSecurityContextSysctlModule = types.submodule {
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
  mkTemplateSpecSecurityContextSysctl = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  TemplateSpecSecurityContextWindowsOptionsModule = types.submodule {
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
  mkTemplateSpecSecurityContextWindowsOptions =
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
  TemplateSpecTolerationModule = types.submodule {
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
        description = "Operator represents a key's relationship to the value.\nValid operators are Exists, Equal, Lt, and Gt. Defaults to Equal.\nExists is equivalent to wildcard for value, so that a pod can\ntolerate all taints of a particular category.\nLt and Gt perform numeric comparisons (requires feature gate TaintTolerationComparisonOperators).";
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
  mkTemplateSpecToleration =
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
  TemplateSpecTopologySpreadConstraintLabelSelectorMatchExpressionModule = types.submodule {
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
  mkTemplateSpecTopologySpreadConstraintLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  TemplateSpecTopologySpreadConstraintLabelSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf TemplateSpecTopologySpreadConstraintLabelSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkTemplateSpecTopologySpreadConstraintLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkTemplateSpecTopologySpreadConstraintLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  TemplateSpecTopologySpreadConstraintModule = types.submodule {
    options = {
      "labelSelector" = mkOption {
        description = "LabelSelector is used to find matching pods.\nPods that match this label selector are counted to determine the number of pods\nin their corresponding topology domain.";
        type = (types.nullOr TemplateSpecTopologySpreadConstraintLabelSelectorModule);
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
  mkTemplateSpecTopologySpreadConstraint =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" = mkTemplateSpecTopologySpreadConstraintLabelSelector res."labelSelector";
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
  TemplateSpecVolumeAwsElasticBlockStoreModule = types.submodule {
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
  mkTemplateSpecVolumeAwsElasticBlockStore =
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
  TemplateSpecVolumeAzureDiskModule = types.submodule {
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
  mkTemplateSpecVolumeAzureDisk =
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
  TemplateSpecVolumeAzureFileModule = types.submodule {
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
  mkTemplateSpecVolumeAzureFile =
    res:
    {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
      inherit (res) "secretName";
      inherit (res) "shareName";
    };
  TemplateSpecVolumeCephfsModule = types.submodule {
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
        type = (types.nullOr TemplateSpecVolumeCephfsSecretRefModule);
        default = null;
      };
      "user" = mkOption {
        description = "user is optional: User is the rados user name, default is admin\nMore info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTemplateSpecVolumeCephfs =
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
      "secretRef" = mkTemplateSpecVolumeCephfsSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."user" != null) { inherit (res) "user"; }
    // {
    };
  TemplateSpecVolumeCephfsSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkTemplateSpecVolumeCephfsSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  TemplateSpecVolumeCinderModule = types.submodule {
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
        type = (types.nullOr TemplateSpecVolumeCinderSecretRefModule);
        default = null;
      };
      "volumeID" = mkOption {
        description = "volumeID used to identify the volume in cinder.\nMore info: https://examples.k8s.io/mysql-cinder-pd/README.md";
        type = types.str;
      };
    };
  };
  mkTemplateSpecVolumeCinder =
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
      "secretRef" = mkTemplateSpecVolumeCinderSecretRef res."secretRef";
    }
    // {
      inherit (res) "volumeID";
    };
  TemplateSpecVolumeCinderSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkTemplateSpecVolumeCinderSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  TemplateSpecVolumeConfigMapItemModule = types.submodule {
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
  mkTemplateSpecVolumeConfigMapItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    };
  TemplateSpecVolumeConfigMapModule = types.submodule {
    options = {
      "defaultMode" = mkOption {
        description = "defaultMode is optional: mode bits used to set permissions on created files by default.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nDefaults to 0644.\nDirectories within the path are not affected by this setting.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "items" = mkOption {
        description = "items if unspecified, each key-value pair in the Data field of the referenced\nConfigMap will be projected into the volume as a file whose name is the\nkey and content is the value. If specified, the listed keys will be\nprojected into the specified paths, and unlisted keys will not be\npresent. If a key is specified which is not present in the ConfigMap,\nthe volume setup will error unless it is marked optional. Paths must be\nrelative and may not contain the '..' path or start with '..'.";
        type = (types.listOf TemplateSpecVolumeConfigMapItemModule);
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
  mkTemplateSpecVolumeConfigMap =
    res:
    {
    }
    // optionalAttrs (res."defaultMode" != null) { inherit (res) "defaultMode"; }
    // {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkTemplateSpecVolumeConfigMapItem res."items";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TemplateSpecVolumeCsiModule = types.submodule {
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
        type = (types.nullOr TemplateSpecVolumeCsiNodePublishSecretRefModule);
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
  mkTemplateSpecVolumeCsi =
    res:
    {
      inherit (res) "driver";
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
    }
    // optionalAttrs (res."nodePublishSecretRef" != null) {
      "nodePublishSecretRef" = mkTemplateSpecVolumeCsiNodePublishSecretRef res."nodePublishSecretRef";
    }
    // {
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    }
    // optionalAttrs (res."volumeAttributes" != { }) { inherit (res) "volumeAttributes"; }
    // {
    };
  TemplateSpecVolumeCsiNodePublishSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkTemplateSpecVolumeCsiNodePublishSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  TemplateSpecVolumeDownwardAPIItemFieldRefModule = types.submodule {
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
  mkTemplateSpecVolumeDownwardAPIItemFieldRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "fieldPath";
    };
  TemplateSpecVolumeDownwardAPIItemModule = types.submodule {
    options = {
      "fieldRef" = mkOption {
        description = "Required: Selects a field of the pod: only annotations, labels, name, namespace and uid are supported.";
        type = (types.nullOr TemplateSpecVolumeDownwardAPIItemFieldRefModule);
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
        type = (types.nullOr TemplateSpecVolumeDownwardAPIItemResourceFieldRefModule);
        default = null;
      };
    };
  };
  mkTemplateSpecVolumeDownwardAPIItem =
    res:
    {
    }
    // optionalAttrs (res."fieldRef" != null) {
      "fieldRef" = mkTemplateSpecVolumeDownwardAPIItemFieldRef res."fieldRef";
    }
    // {
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    }
    // optionalAttrs (res."resourceFieldRef" != null) {
      "resourceFieldRef" = mkTemplateSpecVolumeDownwardAPIItemResourceFieldRef res."resourceFieldRef";
    }
    // {
    };
  TemplateSpecVolumeDownwardAPIItemResourceFieldRefModule = types.submodule {
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
  mkTemplateSpecVolumeDownwardAPIItemResourceFieldRef =
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
  TemplateSpecVolumeDownwardAPIModule = types.submodule {
    options = {
      "defaultMode" = mkOption {
        description = "Optional: mode bits to use on created files by default. Must be a\nOptional: mode bits used to set permissions on created files by default.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nDefaults to 0644.\nDirectories within the path are not affected by this setting.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "items" = mkOption {
        description = "Items is a list of downward API volume file";
        type = (types.listOf TemplateSpecVolumeDownwardAPIItemModule);
        default = [ ];
      };
    };
  };
  mkTemplateSpecVolumeDownwardAPI =
    res:
    {
    }
    // optionalAttrs (res."defaultMode" != null) { inherit (res) "defaultMode"; }
    // {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkTemplateSpecVolumeDownwardAPIItem res."items";
    }
    // {
    };
  TemplateSpecVolumeEmptyDirModule = types.submodule {
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
  mkTemplateSpecVolumeEmptyDir =
    res:
    {
    }
    // optionalAttrs (res."medium" != null) { inherit (res) "medium"; }
    // {
    }
    // optionalAttrs (res."sizeLimit" != null) { inherit (res) "sizeLimit"; }
    // {
    };
  TemplateSpecVolumeEphemeralModule = types.submodule {
    options = {
      "volumeClaimTemplate" = mkOption {
        description = "Will be used to create a stand-alone PVC to provision the volume.\nThe pod in which this EphemeralVolumeSource is embedded will be the\nowner of the PVC, i.e. the PVC will be deleted together with the\npod.  The name of the PVC will be `<pod name>-<volume name>` where\n`<volume name>` is the name from the `PodSpec.Volumes` array\nentry. Pod validation will reject the pod if the concatenated name\nis not valid for a PVC (for example, too long).\n\nAn existing PVC with that name that is not owned by the pod\nwill *not* be used for the pod to avoid using an unrelated\nvolume by mistake. Starting the pod is then blocked until\nthe unrelated PVC is removed. If such a pre-created PVC is\nmeant to be used by the pod, the PVC has to updated with an\nowner reference to the pod once the pod exists. Normally\nthis should not be necessary, but it may be useful when\nmanually reconstructing a broken cluster.\n\nThis field is read-only and no changes will be made by Kubernetes\nto the PVC after it has been created.\n\nRequired, must not be nil.";
        type = (types.nullOr TemplateSpecVolumeEphemeralVolumeClaimTemplateModule);
        default = null;
      };
    };
  };
  mkTemplateSpecVolumeEphemeral =
    res:
    {
    }
    // optionalAttrs (res."volumeClaimTemplate" != null) {
      "volumeClaimTemplate" = mkTemplateSpecVolumeEphemeralVolumeClaimTemplate res."volumeClaimTemplate";
    }
    // {
    };
  TemplateSpecVolumeEphemeralVolumeClaimTemplateModule = types.submodule {
    options = {
      "metadata" = mkOption {
        description = "May contain labels and annotations that will be copied into the PVC\nwhen creating it. No other fields are allowed and will be rejected during\nvalidation.";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "spec" = mkOption {
        description = "The specification for the PersistentVolumeClaim. The entire content is\ncopied unchanged into the PVC that gets created from this\ntemplate. The same fields as in a PersistentVolumeClaim\nare also valid here.";
        type = TemplateSpecVolumeEphemeralVolumeClaimTemplateSpecModule;
      };
    };
  };
  mkTemplateSpecVolumeEphemeralVolumeClaimTemplate =
    res:
    {
    }
    // optionalAttrs (res."metadata" != { }) { inherit (res) "metadata"; }
    // {
      "spec" = mkTemplateSpecVolumeEphemeralVolumeClaimTemplateSpec res."spec";
    };
  TemplateSpecVolumeEphemeralVolumeClaimTemplateSpecDataSourceModule = types.submodule {
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
  mkTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecDataSource =
    res:
    {
    }
    // optionalAttrs (res."apiGroup" != null) { inherit (res) "apiGroup"; }
    // {
      inherit (res) "kind";
      inherit (res) "name";
    };
  TemplateSpecVolumeEphemeralVolumeClaimTemplateSpecDataSourceRefModule = types.submodule {
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
  mkTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecDataSourceRef =
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
  TemplateSpecVolumeEphemeralVolumeClaimTemplateSpecModule = types.submodule {
    options = {
      "accessModes" = mkOption {
        description = "accessModes contains the desired access modes the volume should have.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1";
        type = (types.listOf types.str);
        default = [ ];
      };
      "dataSource" = mkOption {
        description = "dataSource field can be used to specify either:\n* An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot)\n* An existing PVC (PersistentVolumeClaim)\nIf the provisioner or an external controller can support the specified data source,\nit will create a new volume based on the contents of the specified data source.\nWhen the AnyVolumeDataSource feature gate is enabled, dataSource contents will be copied to dataSourceRef,\nand dataSourceRef contents will be copied to dataSource when dataSourceRef.namespace is not specified.\nIf the namespace is specified, then dataSourceRef will not be copied to dataSource.";
        type = (types.nullOr TemplateSpecVolumeEphemeralVolumeClaimTemplateSpecDataSourceModule);
        default = null;
      };
      "dataSourceRef" = mkOption {
        description = "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty\nvolume is desired. This may be any object from a non-empty API group (non\ncore object) or a PersistentVolumeClaim object.\nWhen this field is specified, volume binding will only succeed if the type of\nthe specified object matches some installed volume populator or dynamic\nprovisioner.\nThis field will replace the functionality of the dataSource field and as such\nif both fields are non-empty, they must have the same value. For backwards\ncompatibility, when namespace isn't specified in dataSourceRef,\nboth fields (dataSource and dataSourceRef) will be set to the same\nvalue automatically if one of them is empty and the other is non-empty.\nWhen namespace is specified in dataSourceRef,\ndataSource isn't set to the same value and must be empty.\nThere are three important differences between dataSource and dataSourceRef:\n* While dataSource only allows two specific types of objects, dataSourceRef\n  allows any non-core object, as well as PersistentVolumeClaim objects.\n* While dataSource ignores disallowed values (dropping them), dataSourceRef\n  preserves all values, and generates an error if a disallowed value is\n  specified.\n* While dataSource only allows local objects, dataSourceRef allows objects\n  in any namespaces.\n(Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled.\n(Alpha) Using the namespace field of dataSourceRef requires the CrossNamespaceVolumeDataSource feature gate to be enabled.";
        type = (types.nullOr TemplateSpecVolumeEphemeralVolumeClaimTemplateSpecDataSourceRefModule);
        default = null;
      };
      "resources" = mkOption {
        description = "resources represents the minimum resources the volume should have.\nUsers are allowed to specify resource requirements\nthat are lower than previous value but must still be higher than capacity recorded in the\nstatus field of the claim.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources";
        type = (types.nullOr TemplateSpecVolumeEphemeralVolumeClaimTemplateSpecResourcesModule);
        default = null;
      };
      "selector" = mkOption {
        description = "selector is a label query over volumes to consider for binding.";
        type = (types.nullOr TemplateSpecVolumeEphemeralVolumeClaimTemplateSpecSelectorModule);
        default = null;
      };
      "storageClassName" = mkOption {
        description = "storageClassName is the name of the StorageClass required by the claim.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeAttributesClassName" = mkOption {
        description = "volumeAttributesClassName may be used to set the VolumeAttributesClass used by this claim.\nIf specified, the CSI driver will create or update the volume with the attributes defined\nin the corresponding VolumeAttributesClass. This has a different purpose than storageClassName,\nit can be changed after the claim is created. An empty string or nil value indicates that no\nVolumeAttributesClass will be applied to the claim. If the claim enters an Infeasible error state,\nthis field can be reset to its previous value (including nil) to cancel the modification.\nIf the resource referred to by volumeAttributesClass does not exist, this PersistentVolumeClaim will be\nset to a Pending state, as reflected by the modifyVolumeStatus field, until such as a resource\nexists.\nMore info: https://kubernetes.io/docs/concepts/storage/volume-attributes-classes/";
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
  mkTemplateSpecVolumeEphemeralVolumeClaimTemplateSpec =
    res:
    {
    }
    // optionalAttrs (res."accessModes" != [ ]) { inherit (res) "accessModes"; }
    // {
    }
    // optionalAttrs (res."dataSource" != null) {
      "dataSource" = mkTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecDataSource res."dataSource";
    }
    // {
    }
    // optionalAttrs (res."dataSourceRef" != null) {
      "dataSourceRef" =
        mkTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecDataSourceRef
          res."dataSourceRef";
    }
    // {
    }
    // optionalAttrs (res."resources" != null) {
      "resources" = mkTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecResources res."resources";
    }
    // {
    }
    // optionalAttrs (res."selector" != null) {
      "selector" = mkTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecSelector res."selector";
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
  TemplateSpecVolumeEphemeralVolumeClaimTemplateSpecResourcesModule = types.submodule {
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
  mkTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecResources =
    res:
    {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  TemplateSpecVolumeEphemeralVolumeClaimTemplateSpecSelectorMatchExpressionModule = types.submodule {
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
  mkTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  TemplateSpecVolumeEphemeralVolumeClaimTemplateSpecSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (
          types.listOf TemplateSpecVolumeEphemeralVolumeClaimTemplateSpecSelectorMatchExpressionModule
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
  mkTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkTemplateSpecVolumeEphemeralVolumeClaimTemplateSpecSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  TemplateSpecVolumeFcModule = types.submodule {
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
  mkTemplateSpecVolumeFc =
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
  TemplateSpecVolumeFlexVolumeModule = types.submodule {
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
        type = (types.nullOr TemplateSpecVolumeFlexVolumeSecretRefModule);
        default = null;
      };
    };
  };
  mkTemplateSpecVolumeFlexVolume =
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
      "secretRef" = mkTemplateSpecVolumeFlexVolumeSecretRef res."secretRef";
    }
    // {
    };
  TemplateSpecVolumeFlexVolumeSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkTemplateSpecVolumeFlexVolumeSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  TemplateSpecVolumeFlockerModule = types.submodule {
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
  mkTemplateSpecVolumeFlocker =
    res:
    {
    }
    // optionalAttrs (res."datasetName" != null) { inherit (res) "datasetName"; }
    // {
    }
    // optionalAttrs (res."datasetUUID" != null) { inherit (res) "datasetUUID"; }
    // {
    };
  TemplateSpecVolumeGcePersistentDiskModule = types.submodule {
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
  mkTemplateSpecVolumeGcePersistentDisk =
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
  TemplateSpecVolumeGitRepoModule = types.submodule {
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
  mkTemplateSpecVolumeGitRepo =
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
  TemplateSpecVolumeGlusterfsModule = types.submodule {
    options = {
      "endpoints" = mkOption {
        description = "endpoints is the endpoint name that details Glusterfs topology.";
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
  mkTemplateSpecVolumeGlusterfs =
    res:
    {
      inherit (res) "endpoints";
      inherit (res) "path";
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    };
  TemplateSpecVolumeHostPathModule = types.submodule {
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
  mkTemplateSpecVolumeHostPath =
    res:
    {
      inherit (res) "path";
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  TemplateSpecVolumeImageModule = types.submodule {
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
  mkTemplateSpecVolumeImage =
    res:
    {
    }
    // optionalAttrs (res."pullPolicy" != null) { inherit (res) "pullPolicy"; }
    // {
    }
    // optionalAttrs (res."reference" != null) { inherit (res) "reference"; }
    // {
    };
  TemplateSpecVolumeIscsiModule = types.submodule {
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
        type = (types.nullOr TemplateSpecVolumeIscsiSecretRefModule);
        default = null;
      };
      "targetPortal" = mkOption {
        description = "targetPortal is iSCSI Target Portal. The Portal is either an IP or ip_addr:port if the port\nis other than default (typically TCP ports 860 and 3260).";
        type = types.str;
      };
    };
  };
  mkTemplateSpecVolumeIscsi =
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
      "secretRef" = mkTemplateSpecVolumeIscsiSecretRef res."secretRef";
    }
    // {
      inherit (res) "targetPortal";
    };
  TemplateSpecVolumeIscsiSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkTemplateSpecVolumeIscsiSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  TemplateSpecVolumeModule = types.submodule {
    options = {
      "awsElasticBlockStore" = mkOption {
        description = "awsElasticBlockStore represents an AWS Disk resource that is attached to a\nkubelet's host machine and then exposed to the pod.\nDeprecated: AWSElasticBlockStore is deprecated. All operations for the in-tree\nawsElasticBlockStore type are redirected to the ebs.csi.aws.com CSI driver.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore";
        type = (types.nullOr TemplateSpecVolumeAwsElasticBlockStoreModule);
        default = null;
      };
      "azureDisk" = mkOption {
        description = "azureDisk represents an Azure Data Disk mount on the host and bind mount to the pod.\nDeprecated: AzureDisk is deprecated. All operations for the in-tree azureDisk type\nare redirected to the disk.csi.azure.com CSI driver.";
        type = (types.nullOr TemplateSpecVolumeAzureDiskModule);
        default = null;
      };
      "azureFile" = mkOption {
        description = "azureFile represents an Azure File Service mount on the host and bind mount to the pod.\nDeprecated: AzureFile is deprecated. All operations for the in-tree azureFile type\nare redirected to the file.csi.azure.com CSI driver.";
        type = (types.nullOr TemplateSpecVolumeAzureFileModule);
        default = null;
      };
      "cephfs" = mkOption {
        description = "cephFS represents a Ceph FS mount on the host that shares a pod's lifetime.\nDeprecated: CephFS is deprecated and the in-tree cephfs type is no longer supported.";
        type = (types.nullOr TemplateSpecVolumeCephfsModule);
        default = null;
      };
      "cinder" = mkOption {
        description = "cinder represents a cinder volume attached and mounted on kubelets host machine.\nDeprecated: Cinder is deprecated. All operations for the in-tree cinder type\nare redirected to the cinder.csi.openstack.org CSI driver.\nMore info: https://examples.k8s.io/mysql-cinder-pd/README.md";
        type = (types.nullOr TemplateSpecVolumeCinderModule);
        default = null;
      };
      "configMap" = mkOption {
        description = "configMap represents a configMap that should populate this volume";
        type = (types.nullOr TemplateSpecVolumeConfigMapModule);
        default = null;
      };
      "csi" = mkOption {
        description = "csi (Container Storage Interface) represents ephemeral storage that is handled by certain external CSI drivers.";
        type = (types.nullOr TemplateSpecVolumeCsiModule);
        default = null;
      };
      "downwardAPI" = mkOption {
        description = "downwardAPI represents downward API about the pod that should populate this volume";
        type = (types.nullOr TemplateSpecVolumeDownwardAPIModule);
        default = null;
      };
      "emptyDir" = mkOption {
        description = "emptyDir represents a temporary directory that shares a pod's lifetime.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir";
        type = (types.nullOr TemplateSpecVolumeEmptyDirModule);
        default = null;
      };
      "ephemeral" = mkOption {
        description = "ephemeral represents a volume that is handled by a cluster storage driver.\nThe volume's lifecycle is tied to the pod that defines it - it will be created before the pod starts,\nand deleted when the pod is removed.\n\nUse this if:\na) the volume is only needed while the pod runs,\nb) features of normal volumes like restoring from snapshot or capacity\n   tracking are needed,\nc) the storage driver is specified through a storage class, and\nd) the storage driver supports dynamic volume provisioning through\n   a PersistentVolumeClaim (see EphemeralVolumeSource for more\n   information on the connection between this volume type\n   and PersistentVolumeClaim).\n\nUse PersistentVolumeClaim or one of the vendor-specific\nAPIs for volumes that persist for longer than the lifecycle\nof an individual pod.\n\nUse CSI for light-weight local ephemeral volumes if the CSI driver is meant to\nbe used that way - see the documentation of the driver for\nmore information.\n\nA pod can use both types of ephemeral volumes and\npersistent volumes at the same time.";
        type = (types.nullOr TemplateSpecVolumeEphemeralModule);
        default = null;
      };
      "fc" = mkOption {
        description = "fc represents a Fibre Channel resource that is attached to a kubelet's host machine and then exposed to the pod.";
        type = (types.nullOr TemplateSpecVolumeFcModule);
        default = null;
      };
      "flexVolume" = mkOption {
        description = "flexVolume represents a generic volume resource that is\nprovisioned/attached using an exec based plugin.\nDeprecated: FlexVolume is deprecated. Consider using a CSIDriver instead.";
        type = (types.nullOr TemplateSpecVolumeFlexVolumeModule);
        default = null;
      };
      "flocker" = mkOption {
        description = "flocker represents a Flocker volume attached to a kubelet's host machine. This depends on the Flocker control service being running.\nDeprecated: Flocker is deprecated and the in-tree flocker type is no longer supported.";
        type = (types.nullOr TemplateSpecVolumeFlockerModule);
        default = null;
      };
      "gcePersistentDisk" = mkOption {
        description = "gcePersistentDisk represents a GCE Disk resource that is attached to a\nkubelet's host machine and then exposed to the pod.\nDeprecated: GCEPersistentDisk is deprecated. All operations for the in-tree\ngcePersistentDisk type are redirected to the pd.csi.storage.gke.io CSI driver.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk";
        type = (types.nullOr TemplateSpecVolumeGcePersistentDiskModule);
        default = null;
      };
      "gitRepo" = mkOption {
        description = "gitRepo represents a git repository at a particular revision.\nDeprecated: GitRepo is deprecated. To provision a container with a git repo, mount an\nEmptyDir into an InitContainer that clones the repo using git, then mount the EmptyDir\ninto the Pod's container.";
        type = (types.nullOr TemplateSpecVolumeGitRepoModule);
        default = null;
      };
      "glusterfs" = mkOption {
        description = "glusterfs represents a Glusterfs mount on the host that shares a pod's lifetime.\nDeprecated: Glusterfs is deprecated and the in-tree glusterfs type is no longer supported.";
        type = (types.nullOr TemplateSpecVolumeGlusterfsModule);
        default = null;
      };
      "hostPath" = mkOption {
        description = "hostPath represents a pre-existing file or directory on the host\nmachine that is directly exposed to the container. This is generally\nused for system agents or other privileged things that are allowed\nto see the host machine. Most containers will NOT need this.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath";
        type = (types.nullOr TemplateSpecVolumeHostPathModule);
        default = null;
      };
      "image" = mkOption {
        description = "image represents an OCI object (a container image or artifact) pulled and mounted on the kubelet's host machine.\nThe volume is resolved at pod startup depending on which PullPolicy value is provided:\n\n- Always: the kubelet always attempts to pull the reference. Container creation will fail If the pull fails.\n- Never: the kubelet never pulls the reference and only uses a local image or artifact. Container creation will fail if the reference isn't present.\n- IfNotPresent: the kubelet pulls if the reference isn't already present on disk. Container creation will fail if the reference isn't present and the pull fails.\n\nThe volume gets re-resolved if the pod gets deleted and recreated, which means that new remote content will become available on pod recreation.\nA failure to resolve or pull the image during pod startup will block containers from starting and may add significant latency. Failures will be retried using normal volume backoff and will be reported on the pod reason and message.\nThe types of objects that may be mounted by this volume are defined by the container runtime implementation on a host machine and at minimum must include all valid types supported by the container image field.\nThe OCI object gets mounted in a single directory (spec.containers[*].volumeMounts.mountPath) by merging the manifest layers in the same way as for container images.\nThe volume will be mounted read-only (ro) and non-executable files (noexec).\nSub path mounts for containers are not supported (spec.containers[*].volumeMounts.subpath) before 1.33.\nThe field spec.securityContext.fsGroupChangePolicy has no effect on this volume type.";
        type = (types.nullOr TemplateSpecVolumeImageModule);
        default = null;
      };
      "iscsi" = mkOption {
        description = "iscsi represents an ISCSI Disk resource that is attached to a\nkubelet's host machine and then exposed to the pod.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes/#iscsi";
        type = (types.nullOr TemplateSpecVolumeIscsiModule);
        default = null;
      };
      "name" = mkOption {
        description = "name of the volume.\nMust be a DNS_LABEL and unique within the pod.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = types.str;
      };
      "nfs" = mkOption {
        description = "nfs represents an NFS mount on the host that shares a pod's lifetime\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#nfs";
        type = (types.nullOr TemplateSpecVolumeNfsModule);
        default = null;
      };
      "persistentVolumeClaim" = mkOption {
        description = "persistentVolumeClaimVolumeSource represents a reference to a\nPersistentVolumeClaim in the same namespace.\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims";
        type = (types.nullOr TemplateSpecVolumePersistentVolumeClaimModule);
        default = null;
      };
      "photonPersistentDisk" = mkOption {
        description = "photonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine.\nDeprecated: PhotonPersistentDisk is deprecated and the in-tree photonPersistentDisk type is no longer supported.";
        type = (types.nullOr TemplateSpecVolumePhotonPersistentDiskModule);
        default = null;
      };
      "portworxVolume" = mkOption {
        description = "portworxVolume represents a portworx volume attached and mounted on kubelets host machine.\nDeprecated: PortworxVolume is deprecated. All operations for the in-tree portworxVolume type\nare redirected to the pxd.portworx.com CSI driver when the CSIMigrationPortworx feature-gate\nis on.";
        type = (types.nullOr TemplateSpecVolumePortworxVolumeModule);
        default = null;
      };
      "projected" = mkOption {
        description = "projected items for all in one resources secrets, configmaps, and downward API";
        type = (types.nullOr TemplateSpecVolumeProjectedModule);
        default = null;
      };
      "quobyte" = mkOption {
        description = "quobyte represents a Quobyte mount on the host that shares a pod's lifetime.\nDeprecated: Quobyte is deprecated and the in-tree quobyte type is no longer supported.";
        type = (types.nullOr TemplateSpecVolumeQuobyteModule);
        default = null;
      };
      "rbd" = mkOption {
        description = "rbd represents a Rados Block Device mount on the host that shares a pod's lifetime.\nDeprecated: RBD is deprecated and the in-tree rbd type is no longer supported.";
        type = (types.nullOr TemplateSpecVolumeRbdModule);
        default = null;
      };
      "scaleIO" = mkOption {
        description = "scaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes.\nDeprecated: ScaleIO is deprecated and the in-tree scaleIO type is no longer supported.";
        type = (types.nullOr TemplateSpecVolumeScaleIOModule);
        default = null;
      };
      "secret" = mkOption {
        description = "secret represents a secret that should populate this volume.\nMore info: https://kubernetes.io/docs/concepts/storage/volumes#secret";
        type = (types.nullOr TemplateSpecVolumeSecretModule);
        default = null;
      };
      "storageos" = mkOption {
        description = "storageOS represents a StorageOS volume attached and mounted on Kubernetes nodes.\nDeprecated: StorageOS is deprecated and the in-tree storageos type is no longer supported.";
        type = (types.nullOr TemplateSpecVolumeStorageosModule);
        default = null;
      };
      "vsphereVolume" = mkOption {
        description = "vsphereVolume represents a vSphere volume attached and mounted on kubelets host machine.\nDeprecated: VsphereVolume is deprecated. All operations for the in-tree vsphereVolume type\nare redirected to the csi.vsphere.vmware.com CSI driver.";
        type = (types.nullOr TemplateSpecVolumeVsphereVolumeModule);
        default = null;
      };
    };
  };
  mkTemplateSpecVolume =
    res:
    {
    }
    // optionalAttrs (res."awsElasticBlockStore" != null) {
      "awsElasticBlockStore" = mkTemplateSpecVolumeAwsElasticBlockStore res."awsElasticBlockStore";
    }
    // {
    }
    // optionalAttrs (res."azureDisk" != null) {
      "azureDisk" = mkTemplateSpecVolumeAzureDisk res."azureDisk";
    }
    // {
    }
    // optionalAttrs (res."azureFile" != null) {
      "azureFile" = mkTemplateSpecVolumeAzureFile res."azureFile";
    }
    // {
    }
    // optionalAttrs (res."cephfs" != null) { "cephfs" = mkTemplateSpecVolumeCephfs res."cephfs"; }
    // {
    }
    // optionalAttrs (res."cinder" != null) { "cinder" = mkTemplateSpecVolumeCinder res."cinder"; }
    // {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkTemplateSpecVolumeConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."csi" != null) { "csi" = mkTemplateSpecVolumeCsi res."csi"; }
    // {
    }
    // optionalAttrs (res."downwardAPI" != null) {
      "downwardAPI" = mkTemplateSpecVolumeDownwardAPI res."downwardAPI";
    }
    // {
    }
    // optionalAttrs (res."emptyDir" != null) {
      "emptyDir" = mkTemplateSpecVolumeEmptyDir res."emptyDir";
    }
    // {
    }
    // optionalAttrs (res."ephemeral" != null) {
      "ephemeral" = mkTemplateSpecVolumeEphemeral res."ephemeral";
    }
    // {
    }
    // optionalAttrs (res."fc" != null) { "fc" = mkTemplateSpecVolumeFc res."fc"; }
    // {
    }
    // optionalAttrs (res."flexVolume" != null) {
      "flexVolume" = mkTemplateSpecVolumeFlexVolume res."flexVolume";
    }
    // {
    }
    // optionalAttrs (res."flocker" != null) { "flocker" = mkTemplateSpecVolumeFlocker res."flocker"; }
    // {
    }
    // optionalAttrs (res."gcePersistentDisk" != null) {
      "gcePersistentDisk" = mkTemplateSpecVolumeGcePersistentDisk res."gcePersistentDisk";
    }
    // {
    }
    // optionalAttrs (res."gitRepo" != null) { "gitRepo" = mkTemplateSpecVolumeGitRepo res."gitRepo"; }
    // {
    }
    // optionalAttrs (res."glusterfs" != null) {
      "glusterfs" = mkTemplateSpecVolumeGlusterfs res."glusterfs";
    }
    // {
    }
    // optionalAttrs (res."hostPath" != null) {
      "hostPath" = mkTemplateSpecVolumeHostPath res."hostPath";
    }
    // {
    }
    // optionalAttrs (res."image" != null) { "image" = mkTemplateSpecVolumeImage res."image"; }
    // {
    }
    // optionalAttrs (res."iscsi" != null) { "iscsi" = mkTemplateSpecVolumeIscsi res."iscsi"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."nfs" != null) { "nfs" = mkTemplateSpecVolumeNfs res."nfs"; }
    // {
    }
    // optionalAttrs (res."persistentVolumeClaim" != null) {
      "persistentVolumeClaim" = mkTemplateSpecVolumePersistentVolumeClaim res."persistentVolumeClaim";
    }
    // {
    }
    // optionalAttrs (res."photonPersistentDisk" != null) {
      "photonPersistentDisk" = mkTemplateSpecVolumePhotonPersistentDisk res."photonPersistentDisk";
    }
    // {
    }
    // optionalAttrs (res."portworxVolume" != null) {
      "portworxVolume" = mkTemplateSpecVolumePortworxVolume res."portworxVolume";
    }
    // {
    }
    // optionalAttrs (res."projected" != null) {
      "projected" = mkTemplateSpecVolumeProjected res."projected";
    }
    // {
    }
    // optionalAttrs (res."quobyte" != null) { "quobyte" = mkTemplateSpecVolumeQuobyte res."quobyte"; }
    // {
    }
    // optionalAttrs (res."rbd" != null) { "rbd" = mkTemplateSpecVolumeRbd res."rbd"; }
    // {
    }
    // optionalAttrs (res."scaleIO" != null) { "scaleIO" = mkTemplateSpecVolumeScaleIO res."scaleIO"; }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkTemplateSpecVolumeSecret res."secret"; }
    // {
    }
    // optionalAttrs (res."storageos" != null) {
      "storageos" = mkTemplateSpecVolumeStorageos res."storageos";
    }
    // {
    }
    // optionalAttrs (res."vsphereVolume" != null) {
      "vsphereVolume" = mkTemplateSpecVolumeVsphereVolume res."vsphereVolume";
    }
    // {
    };
  TemplateSpecVolumeNfsModule = types.submodule {
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
  mkTemplateSpecVolumeNfs =
    res:
    {
      inherit (res) "path";
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
      inherit (res) "server";
    };
  TemplateSpecVolumePersistentVolumeClaimModule = types.submodule {
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
  mkTemplateSpecVolumePersistentVolumeClaim =
    res:
    {
      inherit (res) "claimName";
    }
    // optionalAttrs res."readOnly" { inherit (res) "readOnly"; }
    // {
    };
  TemplateSpecVolumePhotonPersistentDiskModule = types.submodule {
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
  mkTemplateSpecVolumePhotonPersistentDisk =
    res:
    {
    }
    // optionalAttrs (res."fsType" != null) { inherit (res) "fsType"; }
    // {
      inherit (res) "pdID";
    };
  TemplateSpecVolumePortworxVolumeModule = types.submodule {
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
  mkTemplateSpecVolumePortworxVolume =
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
  TemplateSpecVolumeProjectedModule = types.submodule {
    options = {
      "defaultMode" = mkOption {
        description = "defaultMode are the mode bits used to set permissions on created files by default.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values for mode bits.\nDirectories within the path are not affected by this setting.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "sources" = mkOption {
        description = "sources is the list of volume projections. Each entry in this list\nhandles one source.";
        type = (types.listOf TemplateSpecVolumeProjectedSourceModule);
        default = [ ];
      };
    };
  };
  mkTemplateSpecVolumeProjected =
    res:
    {
    }
    // optionalAttrs (res."defaultMode" != null) { inherit (res) "defaultMode"; }
    // {
    }
    // optionalAttrs (res."sources" != [ ]) {
      "sources" = map mkTemplateSpecVolumeProjectedSource res."sources";
    }
    // {
    };
  TemplateSpecVolumeProjectedSourceClusterTrustBundleLabelSelectorMatchExpressionModule =
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
  mkTemplateSpecVolumeProjectedSourceClusterTrustBundleLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  TemplateSpecVolumeProjectedSourceClusterTrustBundleLabelSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (
          types.listOf TemplateSpecVolumeProjectedSourceClusterTrustBundleLabelSelectorMatchExpressionModule
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
  mkTemplateSpecVolumeProjectedSourceClusterTrustBundleLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map mkTemplateSpecVolumeProjectedSourceClusterTrustBundleLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  TemplateSpecVolumeProjectedSourceClusterTrustBundleModule = types.submodule {
    options = {
      "labelSelector" = mkOption {
        description = "Select all ClusterTrustBundles that match this label selector.  Only has\neffect if signerName is set.  Mutually-exclusive with name.  If unset,\ninterpreted as \"match nothing\".  If set but empty, interpreted as \"match\neverything\".";
        type = (types.nullOr TemplateSpecVolumeProjectedSourceClusterTrustBundleLabelSelectorModule);
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
  mkTemplateSpecVolumeProjectedSourceClusterTrustBundle =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkTemplateSpecVolumeProjectedSourceClusterTrustBundleLabelSelector
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
  TemplateSpecVolumeProjectedSourceConfigMapItemModule = types.submodule {
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
  mkTemplateSpecVolumeProjectedSourceConfigMapItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    };
  TemplateSpecVolumeProjectedSourceConfigMapModule = types.submodule {
    options = {
      "items" = mkOption {
        description = "items if unspecified, each key-value pair in the Data field of the referenced\nConfigMap will be projected into the volume as a file whose name is the\nkey and content is the value. If specified, the listed keys will be\nprojected into the specified paths, and unlisted keys will not be\npresent. If a key is specified which is not present in the ConfigMap,\nthe volume setup will error unless it is marked optional. Paths must be\nrelative and may not contain the '..' path or start with '..'.";
        type = (types.listOf TemplateSpecVolumeProjectedSourceConfigMapItemModule);
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
  mkTemplateSpecVolumeProjectedSourceConfigMap =
    res:
    {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkTemplateSpecVolumeProjectedSourceConfigMapItem res."items";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TemplateSpecVolumeProjectedSourceDownwardAPIItemFieldRefModule = types.submodule {
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
  mkTemplateSpecVolumeProjectedSourceDownwardAPIItemFieldRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "fieldPath";
    };
  TemplateSpecVolumeProjectedSourceDownwardAPIItemModule = types.submodule {
    options = {
      "fieldRef" = mkOption {
        description = "Required: Selects a field of the pod: only annotations, labels, name, namespace and uid are supported.";
        type = (types.nullOr TemplateSpecVolumeProjectedSourceDownwardAPIItemFieldRefModule);
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
        type = (types.nullOr TemplateSpecVolumeProjectedSourceDownwardAPIItemResourceFieldRefModule);
        default = null;
      };
    };
  };
  mkTemplateSpecVolumeProjectedSourceDownwardAPIItem =
    res:
    {
    }
    // optionalAttrs (res."fieldRef" != null) {
      "fieldRef" = mkTemplateSpecVolumeProjectedSourceDownwardAPIItemFieldRef res."fieldRef";
    }
    // {
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    }
    // optionalAttrs (res."resourceFieldRef" != null) {
      "resourceFieldRef" =
        mkTemplateSpecVolumeProjectedSourceDownwardAPIItemResourceFieldRef
          res."resourceFieldRef";
    }
    // {
    };
  TemplateSpecVolumeProjectedSourceDownwardAPIItemResourceFieldRefModule = types.submodule {
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
  mkTemplateSpecVolumeProjectedSourceDownwardAPIItemResourceFieldRef =
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
  TemplateSpecVolumeProjectedSourceDownwardAPIModule = types.submodule {
    options = {
      "items" = mkOption {
        description = "Items is a list of DownwardAPIVolume file";
        type = (types.listOf TemplateSpecVolumeProjectedSourceDownwardAPIItemModule);
        default = [ ];
      };
    };
  };
  mkTemplateSpecVolumeProjectedSourceDownwardAPI =
    res:
    {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkTemplateSpecVolumeProjectedSourceDownwardAPIItem res."items";
    }
    // {
    };
  TemplateSpecVolumeProjectedSourceModule = types.submodule {
    options = {
      "clusterTrustBundle" = mkOption {
        description = "ClusterTrustBundle allows a pod to access the `.spec.trustBundle` field\nof ClusterTrustBundle objects in an auto-updating file.\n\nAlpha, gated by the ClusterTrustBundleProjection feature gate.\n\nClusterTrustBundle objects can either be selected by name, or by the\ncombination of signer name and a label selector.\n\nKubelet performs aggressive normalization of the PEM contents written\ninto the pod filesystem.  Esoteric PEM features such as inter-block\ncomments and block headers are stripped.  Certificates are deduplicated.\nThe ordering of certificates within the file is arbitrary, and Kubelet\nmay change the order over time.";
        type = (types.nullOr TemplateSpecVolumeProjectedSourceClusterTrustBundleModule);
        default = null;
      };
      "configMap" = mkOption {
        description = "configMap information about the configMap data to project";
        type = (types.nullOr TemplateSpecVolumeProjectedSourceConfigMapModule);
        default = null;
      };
      "downwardAPI" = mkOption {
        description = "downwardAPI information about the downwardAPI data to project";
        type = (types.nullOr TemplateSpecVolumeProjectedSourceDownwardAPIModule);
        default = null;
      };
      "podCertificate" = mkOption {
        description = "Projects an auto-rotating credential bundle (private key and certificate\nchain) that the pod can use either as a TLS client or server.\n\nKubelet generates a private key and uses it to send a\nPodCertificateRequest to the named signer.  Once the signer approves the\nrequest and issues a certificate chain, Kubelet writes the key and\ncertificate chain to the pod filesystem.  The pod does not start until\ncertificates have been issued for each podCertificate projected volume\nsource in its spec.\n\nKubelet will begin trying to rotate the certificate at the time indicated\nby the signer using the PodCertificateRequest.Status.BeginRefreshAt\ntimestamp.\n\nKubelet can write a single file, indicated by the credentialBundlePath\nfield, or separate files, indicated by the keyPath and\ncertificateChainPath fields.\n\nThe credential bundle is a single file in PEM format.  The first PEM\nentry is the private key (in PKCS#8 format), and the remaining PEM\nentries are the certificate chain issued by the signer (typically,\nsigners will return their certificate chain in leaf-to-root order).\n\nPrefer using the credential bundle format, since your application code\ncan read it atomically.  If you use keyPath and certificateChainPath,\nyour application must make two separate file reads. If these coincide\nwith a certificate rotation, it is possible that the private key and leaf\ncertificate you read may not correspond to each other.  Your application\nwill need to check for this condition, and re-read until they are\nconsistent.\n\nThe named signer controls chooses the format of the certificate it\nissues; consult the signer implementation's documentation to learn how to\nuse the certificates it issues.";
        type = (types.nullOr TemplateSpecVolumeProjectedSourcePodCertificateModule);
        default = null;
      };
      "secret" = mkOption {
        description = "secret information about the secret data to project";
        type = (types.nullOr TemplateSpecVolumeProjectedSourceSecretModule);
        default = null;
      };
      "serviceAccountToken" = mkOption {
        description = "serviceAccountToken is information about the serviceAccountToken data to project";
        type = (types.nullOr TemplateSpecVolumeProjectedSourceServiceAccountTokenModule);
        default = null;
      };
    };
  };
  mkTemplateSpecVolumeProjectedSource =
    res:
    {
    }
    // optionalAttrs (res."clusterTrustBundle" != null) {
      "clusterTrustBundle" =
        mkTemplateSpecVolumeProjectedSourceClusterTrustBundle
          res."clusterTrustBundle";
    }
    // {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkTemplateSpecVolumeProjectedSourceConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."downwardAPI" != null) {
      "downwardAPI" = mkTemplateSpecVolumeProjectedSourceDownwardAPI res."downwardAPI";
    }
    // {
    }
    // optionalAttrs (res."podCertificate" != null) {
      "podCertificate" = mkTemplateSpecVolumeProjectedSourcePodCertificate res."podCertificate";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkTemplateSpecVolumeProjectedSourceSecret res."secret";
    }
    // {
    }
    // optionalAttrs (res."serviceAccountToken" != null) {
      "serviceAccountToken" =
        mkTemplateSpecVolumeProjectedSourceServiceAccountToken
          res."serviceAccountToken";
    }
    // {
    };
  TemplateSpecVolumeProjectedSourcePodCertificateModule = types.submodule {
    options = {
      "certificateChainPath" = mkOption {
        description = "Write the certificate chain at this path in the projected volume.\n\nMost applications should use credentialBundlePath.  When using keyPath\nand certificateChainPath, your application needs to check that the key\nand leaf certificate are consistent, because it is possible to read the\nfiles mid-rotation.";
        type = (types.nullOr types.str);
        default = null;
      };
      "credentialBundlePath" = mkOption {
        description = "Write the credential bundle at this path in the projected volume.\n\nThe credential bundle is a single file that contains multiple PEM blocks.\nThe first PEM block is a PRIVATE KEY block, containing a PKCS#8 private\nkey.\n\nThe remaining blocks are CERTIFICATE blocks, containing the issued\ncertificate chain from the signer (leaf and any intermediates).\n\nUsing credentialBundlePath lets your Pod's application code make a single\natomic read that retrieves a consistent key and certificate chain.  If you\nproject them to separate files, your application code will need to\nadditionally check that the leaf certificate was issued to the key.";
        type = (types.nullOr types.str);
        default = null;
      };
      "keyPath" = mkOption {
        description = "Write the key at this path in the projected volume.\n\nMost applications should use credentialBundlePath.  When using keyPath\nand certificateChainPath, your application needs to check that the key\nand leaf certificate are consistent, because it is possible to read the\nfiles mid-rotation.";
        type = (types.nullOr types.str);
        default = null;
      };
      "keyType" = mkOption {
        description = "The type of keypair Kubelet will generate for the pod.\n\nValid values are \"RSA3072\", \"RSA4096\", \"ECDSAP256\", \"ECDSAP384\",\n\"ECDSAP521\", and \"ED25519\".";
        type = types.str;
      };
      "maxExpirationSeconds" = mkOption {
        description = "maxExpirationSeconds is the maximum lifetime permitted for the\ncertificate.\n\nKubelet copies this value verbatim into the PodCertificateRequests it\ngenerates for this projection.\n\nIf omitted, kube-apiserver will set it to 86400(24 hours). kube-apiserver\nwill reject values shorter than 3600 (1 hour).  The maximum allowable\nvalue is 7862400 (91 days).\n\nThe signer implementation is then free to issue a certificate with any\nlifetime *shorter* than MaxExpirationSeconds, but no shorter than 3600\nseconds (1 hour).  This constraint is enforced by kube-apiserver.\n`kubernetes.io` signers will never issue certificates with a lifetime\nlonger than 24 hours.";
        type = (types.nullOr types.int);
        default = null;
      };
      "signerName" = mkOption {
        description = "Kubelet's generated CSRs will be addressed to this signer.";
        type = types.str;
      };
      "userAnnotations" = mkOption {
        description = "userAnnotations allow pod authors to pass additional information to\nthe signer implementation.  Kubernetes does not restrict or validate this\nmetadata in any way.\n\nThese values are copied verbatim into the `spec.unverifiedUserAnnotations` field of\nthe PodCertificateRequest objects that Kubelet creates.\n\nEntries are subject to the same validation as object metadata annotations,\nwith the addition that all keys must be domain-prefixed. No restrictions\nare placed on values, except an overall size limitation on the entire field.\n\nSigners should document the keys and values they support. Signers should\ndeny requests that contain keys they do not recognize.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkTemplateSpecVolumeProjectedSourcePodCertificate =
    res:
    {
    }
    // optionalAttrs (res."certificateChainPath" != null) { inherit (res) "certificateChainPath"; }
    // {
    }
    // optionalAttrs (res."credentialBundlePath" != null) { inherit (res) "credentialBundlePath"; }
    // {
    }
    // optionalAttrs (res."keyPath" != null) { inherit (res) "keyPath"; }
    // {
      inherit (res) "keyType";
    }
    // optionalAttrs (res."maxExpirationSeconds" != null) { inherit (res) "maxExpirationSeconds"; }
    // {
      inherit (res) "signerName";
    }
    // optionalAttrs (res."userAnnotations" != { }) { inherit (res) "userAnnotations"; }
    // {
    };
  TemplateSpecVolumeProjectedSourceSecretItemModule = types.submodule {
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
  mkTemplateSpecVolumeProjectedSourceSecretItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    };
  TemplateSpecVolumeProjectedSourceSecretModule = types.submodule {
    options = {
      "items" = mkOption {
        description = "items if unspecified, each key-value pair in the Data field of the referenced\nSecret will be projected into the volume as a file whose name is the\nkey and content is the value. If specified, the listed keys will be\nprojected into the specified paths, and unlisted keys will not be\npresent. If a key is specified which is not present in the Secret,\nthe volume setup will error unless it is marked optional. Paths must be\nrelative and may not contain the '..' path or start with '..'.";
        type = (types.listOf TemplateSpecVolumeProjectedSourceSecretItemModule);
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
  mkTemplateSpecVolumeProjectedSourceSecret =
    res:
    {
    }
    // optionalAttrs (res."items" != [ ]) {
      "items" = map mkTemplateSpecVolumeProjectedSourceSecretItem res."items";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TemplateSpecVolumeProjectedSourceServiceAccountTokenModule = types.submodule {
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
  mkTemplateSpecVolumeProjectedSourceServiceAccountToken =
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
  TemplateSpecVolumeQuobyteModule = types.submodule {
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
  mkTemplateSpecVolumeQuobyte =
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
  TemplateSpecVolumeRbdModule = types.submodule {
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
        type = (types.nullOr TemplateSpecVolumeRbdSecretRefModule);
        default = null;
      };
      "user" = mkOption {
        description = "user is the rados user name.\nDefault is admin.\nMore info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it";
        type = (types.nullOr types.str);
        default = "admin";
      };
    };
  };
  mkTemplateSpecVolumeRbd =
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
      "secretRef" = mkTemplateSpecVolumeRbdSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."user" != null) { inherit (res) "user"; }
    // {
    };
  TemplateSpecVolumeRbdSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkTemplateSpecVolumeRbdSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  TemplateSpecVolumeScaleIOModule = types.submodule {
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
        type = TemplateSpecVolumeScaleIOSecretRefModule;
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
  mkTemplateSpecVolumeScaleIO =
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
      "secretRef" = mkTemplateSpecVolumeScaleIOSecretRef res."secretRef";
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
  TemplateSpecVolumeScaleIOSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkTemplateSpecVolumeScaleIOSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  TemplateSpecVolumeSecretItemModule = types.submodule {
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
  mkTemplateSpecVolumeSecretItem =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "path";
    };
  TemplateSpecVolumeSecretModule = types.submodule {
    options = {
      "defaultMode" = mkOption {
        description = "defaultMode is Optional: mode bits used to set permissions on created files by default.\nMust be an octal value between 0000 and 0777 or a decimal value between 0 and 511.\nYAML accepts both octal and decimal values, JSON requires decimal values\nfor mode bits. Defaults to 0644.\nDirectories within the path are not affected by this setting.\nThis might be in conflict with other options that affect the file\nmode, like fsGroup, and the result can be other mode bits set.";
        type = (types.nullOr types.int);
        default = null;
      };
      "items" = mkOption {
        description = "items If unspecified, each key-value pair in the Data field of the referenced\nSecret will be projected into the volume as a file whose name is the\nkey and content is the value. If specified, the listed keys will be\nprojected into the specified paths, and unlisted keys will not be\npresent. If a key is specified which is not present in the Secret,\nthe volume setup will error unless it is marked optional. Paths must be\nrelative and may not contain the '..' path or start with '..'.";
        type = (types.listOf TemplateSpecVolumeSecretItemModule);
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
  mkTemplateSpecVolumeSecret =
    res:
    {
    }
    // optionalAttrs (res."defaultMode" != null) { inherit (res) "defaultMode"; }
    // {
    }
    // optionalAttrs (res."items" != [ ]) { "items" = map mkTemplateSpecVolumeSecretItem res."items"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    }
    // optionalAttrs (res."secretName" != null) { inherit (res) "secretName"; }
    // {
    };
  TemplateSpecVolumeStorageosModule = types.submodule {
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
        type = (types.nullOr TemplateSpecVolumeStorageosSecretRefModule);
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
  mkTemplateSpecVolumeStorageos =
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
      "secretRef" = mkTemplateSpecVolumeStorageosSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."volumeName" != null) { inherit (res) "volumeName"; }
    // {
    }
    // optionalAttrs (res."volumeNamespace" != null) { inherit (res) "volumeNamespace"; }
    // {
    };
  TemplateSpecVolumeStorageosSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  mkTemplateSpecVolumeStorageosSecretRef =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  TemplateSpecVolumeVsphereVolumeModule = types.submodule {
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
  mkTemplateSpecVolumeVsphereVolume =
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
  TemplateSpecWorkloadRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name defines the name of the Workload object this Pod belongs to.\nWorkload must be in the same namespace as the Pod.\nIf it doesn't match any existing Workload, the Pod will remain unschedulable\nuntil a Workload object is created and observed by the kube-scheduler.\nIt must be a DNS subdomain.";
        type = types.str;
      };
      "podGroup" = mkOption {
        description = "PodGroup is the name of the PodGroup within the Workload that this Pod\nbelongs to. If it doesn't match any existing PodGroup within the Workload,\nthe Pod will remain unschedulable until the Workload object is recreated\nand observed by the kube-scheduler. It must be a DNS label.";
        type = types.str;
      };
      "podGroupReplicaKey" = mkOption {
        description = "PodGroupReplicaKey specifies the replica key of the PodGroup to which this\nPod belongs. It is used to distinguish pods belonging to different replicas\nof the same pod group. The pod group policy is applied separately to each replica.\nWhen set, it must be a DNS label.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTemplateSpecWorkloadRef =
    res:
    {
      inherit (res) "name";
      inherit (res) "podGroup";
    }
    // optionalAttrs (res."podGroupReplicaKey" != null) { inherit (res) "podGroupReplicaKey"; }
    // {
    };
  PoolersModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this Pooler resource.";
        };
        "cluster" = mkOption {
          description = "This is the cluster reference on which the Pooler will work.\nPooler name should never match with any cluster name within the same namespace.";
          type = ClusterModule;
        };
        "deploymentStrategy" = mkOption {
          description = "The deployment strategy to use for pgbouncer to replace existing pods with new ones";
          type = (types.nullOr DeploymentStrategyModule);
          default = null;
        };
        "instances" = mkOption {
          description = "The number of replicas we want. Default: 1.";
          type = (types.nullOr types.int);
          default = 1;
        };
        "monitoring" = mkOption {
          description = "The configuration of the monitoring infrastructure of this pooler.\n\nDeprecated: This feature will be removed in an upcoming release. If\nyou need this functionality, you can create a PodMonitor manually.";
          type = (types.nullOr MonitoringModule);
          default = null;
        };
        "pgbouncer" = mkOption {
          description = "The PgBouncer configuration";
          type = PgbouncerModule;
        };
        "serviceTemplate" = mkOption {
          description = "Template for the Service to be created";
          type = (types.nullOr ServiceTemplateModule);
          default = null;
        };
        "template" = mkOption {
          description = "The template of the Pod to be created";
          type = (types.nullOr TemplateModule);
          default = null;
        };
        "type" = mkOption {
          description = "Type of service to forward traffic to. Default: `rw`.";
          type = (
            types.nullOr (
              types.enum [
                "rw"
                "ro"
                "r"
              ]
            )
          );
          default = "rw";
        };
      };
    }
  );
  mkPooler = name: res: {
    apiVersion = "postgresql.cnpg.io/v1";
    kind = "Pooler";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
      "cluster" = mkCluster res."cluster";
    }
    // optionalAttrs (res."deploymentStrategy" != null) {
      "deploymentStrategy" = mkDeploymentStrategy res."deploymentStrategy";
    }
    // {
    }
    // optionalAttrs (res."instances" != null) { inherit (res) "instances"; }
    // {
    }
    // optionalAttrs (res."monitoring" != null) { "monitoring" = mkMonitoring res."monitoring"; }
    // {
      "pgbouncer" = mkPgbouncer res."pgbouncer";
    }
    // optionalAttrs (res."serviceTemplate" != null) {
      "serviceTemplate" = mkServiceTemplate res."serviceTemplate";
    }
    // {
    }
    // optionalAttrs (res."template" != null) { "template" = mkTemplate res."template"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkPooler cfg."poolers");
in
{
  options.openkrill.apps."cloudnative-pg" = {
    "poolers" = mkOption {
      type = types.attrsOf PoolersModule;
      default = { };
      description = "Pooler CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."cloudnative-pg".content = allResources;
  };
}
