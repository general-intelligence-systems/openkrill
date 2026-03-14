# Auto-generated openkrill module fragment for kube-prometheus
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."kube-prometheus";
  compact = filterAttrs (_: v: v != null);
  AttachMetadataModule = types.submodule {
    options = {
      "node" = mkOption {
        description = "When set to true, Prometheus attaches node metadata to the discovered\ntargets.\n\nThe Prometheus service account must have the `list` and `watch`\npermissions on the `Nodes` objects.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkAttachMetadata =
    res:
    {
    }
    // optionalAttrs res."node" { inherit (res) "node"; }
    // {
    };
  NamespaceSelectorModule = types.submodule {
    options = {
      "any" = mkOption {
        description = "Boolean describing whether all namespaces are selected in contrast to a\nlist restricting them.";
        type = types.bool;
        default = false;
      };
      "matchNames" = mkOption {
        description = "List of namespace names to select from.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkNamespaceSelector =
    res:
    {
    }
    // optionalAttrs res."any" { inherit (res) "any"; }
    // {
    }
    // optionalAttrs (res."matchNames" != [ ]) { inherit (res) "matchNames"; }
    // {
    };
  PodMetricsEndpointAuthorizationCredentialsModule = types.submodule {
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
  mkPodMetricsEndpointAuthorizationCredentials =
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
  PodMetricsEndpointAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr PodMetricsEndpointAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkPodMetricsEndpointAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkPodMetricsEndpointAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  PodMetricsEndpointBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr PodMetricsEndpointBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr PodMetricsEndpointBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkPodMetricsEndpointBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkPodMetricsEndpointBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkPodMetricsEndpointBasicAuthUsername res."username";
    }
    // {
    };
  PodMetricsEndpointBasicAuthPasswordModule = types.submodule {
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
  mkPodMetricsEndpointBasicAuthPassword =
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
  PodMetricsEndpointBasicAuthUsernameModule = types.submodule {
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
  mkPodMetricsEndpointBasicAuthUsername =
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
  PodMetricsEndpointBearerTokenSecretModule = types.submodule {
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
  mkPodMetricsEndpointBearerTokenSecret =
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
  PodMetricsEndpointMetricRelabelingModule = types.submodule {
    options = {
      "action" = mkOption {
        description = "Action to perform based on the regex matching.\n\n`Uppercase` and `Lowercase` actions require Prometheus >= v2.36.0.\n`DropEqual` and `KeepEqual` actions require Prometheus >= v2.41.0.\n\nDefault: \"Replace\"";
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
        description = "Modulus to take of the hash of the source label values.\n\nOnly applicable when the action is `HashMod`.";
        type = (types.nullOr types.int);
        default = null;
      };
      "regex" = mkOption {
        description = "Regular expression against which the extracted value is matched.";
        type = (types.nullOr types.str);
        default = null;
      };
      "replacement" = mkOption {
        description = "Replacement value against which a Replace action is performed if the\nregular expression matches.\n\nRegex capture groups are available.";
        type = (types.nullOr types.str);
        default = null;
      };
      "separator" = mkOption {
        description = "Separator is the string between concatenated SourceLabels.";
        type = (types.nullOr types.str);
        default = null;
      };
      "sourceLabels" = mkOption {
        description = "The source labels select values from existing labels. Their content is\nconcatenated using the configured Separator and matched against the\nconfigured regular expression.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "targetLabel" = mkOption {
        description = "Label to which the resulting string is written in a replacement.\n\nIt is mandatory for `Replace`, `HashMod`, `Lowercase`, `Uppercase`,\n`KeepEqual` and `DropEqual` actions.\n\nRegex capture groups are available.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkPodMetricsEndpointMetricRelabeling =
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
  PodMetricsEndpointModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "`authorization` configures the Authorization header credentials to use when\nscraping the target.\n\nCannot be set at the same time as `basicAuth`, or `oauth2`.";
        type = (types.nullOr PodMetricsEndpointAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "`basicAuth` configures the Basic Authentication credentials to use when\nscraping the target.\n\nCannot be set at the same time as `authorization`, or `oauth2`.";
        type = (types.nullOr PodMetricsEndpointBasicAuthModule);
        default = null;
      };
      "bearerTokenSecret" = mkOption {
        description = "`bearerTokenSecret` specifies a key of a Secret containing the bearer\ntoken for scraping targets. The secret needs to be in the same namespace\nas the PodMonitor object and readable by the Prometheus Operator.\n\nDeprecated: use `authorization` instead.";
        type = (types.nullOr PodMetricsEndpointBearerTokenSecretModule);
        default = null;
      };
      "enableHttp2" = mkOption {
        description = "`enableHttp2` can be used to disable HTTP2 when scraping the target.";
        type = types.bool;
        default = false;
      };
      "filterRunning" = mkOption {
        description = "When true, the pods which are not running (e.g. either in Failed or\nSucceeded state) are dropped during the target discovery.\n\nIf unset, the filtering is enabled.\n\nMore info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-phase";
        type = types.bool;
        default = false;
      };
      "followRedirects" = mkOption {
        description = "`followRedirects` defines whether the scrape requests should follow HTTP\n3xx redirects.";
        type = types.bool;
        default = false;
      };
      "honorLabels" = mkOption {
        description = "When true, `honorLabels` preserves the metric's labels when they collide\nwith the target's labels.";
        type = types.bool;
        default = false;
      };
      "honorTimestamps" = mkOption {
        description = "`honorTimestamps` controls whether Prometheus preserves the timestamps\nwhen exposed by the target.";
        type = types.bool;
        default = false;
      };
      "interval" = mkOption {
        description = "Interval at which Prometheus scrapes the metrics from the target.\n\nIf empty, Prometheus uses the global scrape interval.";
        type = (types.nullOr types.str);
        default = null;
      };
      "metricRelabelings" = mkOption {
        description = "`metricRelabelings` configures the relabeling rules to apply to the\nsamples before ingestion.";
        type = (types.listOf PodMetricsEndpointMetricRelabelingModule);
        default = [ ];
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "`oauth2` configures the OAuth2 settings to use when scraping the target.\n\nIt requires Prometheus >= 2.27.0.\n\nCannot be set at the same time as `authorization`, or `basicAuth`.";
        type = (types.nullOr PodMetricsEndpointOauth2Module);
        default = null;
      };
      "params" = mkOption {
        description = "`params` define optional HTTP URL parameters.";
        type = (types.attrsOf (types.listOf types.str));
        default = { };
      };
      "path" = mkOption {
        description = "HTTP path from which to scrape for metrics.\n\nIf empty, Prometheus uses the default value (e.g. `/metrics`).";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "The `Pod` port name which exposes the endpoint.\n\nIt takes precedence over the `portNumber` and `targetPort` fields.";
        type = (types.nullOr types.str);
        default = null;
      };
      "portNumber" = mkOption {
        description = "The `Pod` port number which exposes the endpoint.";
        type = (types.nullOr types.int);
        default = null;
      };
      "proxyConnectHeader" = mkOption {
        description = "ProxyConnectHeader optionally specifies headers to send to\nproxies during CONNECT requests.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.attrsOf (types.listOf (types.attrsOf types.anything)));
        default = { };
      };
      "proxyFromEnvironment" = mkOption {
        description = "Whether to use the proxy configuration defined by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY).\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = types.bool;
        default = false;
      };
      "proxyUrl" = mkOption {
        description = "`proxyURL` defines the HTTP proxy server to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "relabelings" = mkOption {
        description = "`relabelings` configures the relabeling rules to apply the target's\nmetadata labels.\n\nThe Operator automatically adds relabelings for a few standard Kubernetes fields.\n\nThe original scrape job's name is available via the `__tmp_prometheus_job_name` label.\n\nMore info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config";
        type = (types.listOf PodMetricsEndpointRelabelingModule);
        default = [ ];
      };
      "scheme" = mkOption {
        description = "HTTP scheme to use for scraping.\n\n`http` and `https` are the expected values unless you rewrite the\n`__scheme__` label via relabeling.\n\nIf empty, Prometheus uses the default value `http`.";
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
      "scrapeTimeout" = mkOption {
        description = "Timeout after which Prometheus considers the scrape to be failed.\n\nIf empty, Prometheus uses the global scrape timeout unless it is less\nthan the target's scrape interval value in which the latter is used.\nThe value cannot be greater than the scrape interval otherwise the operator will reject the resource.";
        type = (types.nullOr types.str);
        default = null;
      };
      "targetPort" = mkOption {
        description = "Name or number of the target port of the `Pod` object behind the Service, the\nport must be specified with container port property.\n\nDeprecated: use 'port' or 'portNumber' instead.";
        type = types.anything;
        default = { };
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration to use when scraping the target.";
        type = (types.nullOr PodMetricsEndpointTlsConfigModule);
        default = null;
      };
      "trackTimestampsStaleness" = mkOption {
        description = "`trackTimestampsStaleness` defines whether Prometheus tracks staleness of\nthe metrics that have an explicit timestamp present in scraped data.\nHas no effect if `honorTimestamps` is false.\n\nIt requires Prometheus >= v2.48.0.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkPodMetricsEndpoint =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkPodMetricsEndpointAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkPodMetricsEndpointBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs (res."bearerTokenSecret" != null) {
      "bearerTokenSecret" = mkPodMetricsEndpointBearerTokenSecret res."bearerTokenSecret";
    }
    // {
    }
    // optionalAttrs res."enableHttp2" { inherit (res) "enableHttp2"; }
    // {
    }
    // optionalAttrs res."filterRunning" { inherit (res) "filterRunning"; }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs res."honorLabels" { inherit (res) "honorLabels"; }
    // {
    }
    // optionalAttrs res."honorTimestamps" { inherit (res) "honorTimestamps"; }
    // {
    }
    // optionalAttrs (res."interval" != null) { inherit (res) "interval"; }
    // {
    }
    // optionalAttrs (res."metricRelabelings" != [ ]) {
      "metricRelabelings" = map mkPodMetricsEndpointMetricRelabeling res."metricRelabelings";
    }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) { "oauth2" = mkPodMetricsEndpointOauth2 res."oauth2"; }
    // {
    }
    // optionalAttrs (res."params" != { }) { inherit (res) "params"; }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
    }
    // optionalAttrs (res."portNumber" != null) { inherit (res) "portNumber"; }
    // {
    }
    // optionalAttrs (res."proxyConnectHeader" != { }) { inherit (res) "proxyConnectHeader"; }
    // {
    }
    // optionalAttrs res."proxyFromEnvironment" { inherit (res) "proxyFromEnvironment"; }
    // {
    }
    // optionalAttrs (res."proxyUrl" != null) { inherit (res) "proxyUrl"; }
    // {
    }
    // optionalAttrs (res."relabelings" != [ ]) {
      "relabelings" = map mkPodMetricsEndpointRelabeling res."relabelings";
    }
    // {
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    }
    // optionalAttrs (res."scrapeTimeout" != null) { inherit (res) "scrapeTimeout"; }
    // {
    }
    // optionalAttrs (res."targetPort" != null) { inherit (res) "targetPort"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkPodMetricsEndpointTlsConfig res."tlsConfig";
    }
    // {
    }
    // optionalAttrs res."trackTimestampsStaleness" { inherit (res) "trackTimestampsStaleness"; }
    // {
    };
  PodMetricsEndpointOauth2ClientIdConfigMapModule = types.submodule {
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
  mkPodMetricsEndpointOauth2ClientIdConfigMap =
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
  PodMetricsEndpointOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr PodMetricsEndpointOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr PodMetricsEndpointOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkPodMetricsEndpointOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkPodMetricsEndpointOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkPodMetricsEndpointOauth2ClientIdSecret res."secret";
    }
    // {
    };
  PodMetricsEndpointOauth2ClientIdSecretModule = types.submodule {
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
  mkPodMetricsEndpointOauth2ClientIdSecret =
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
  PodMetricsEndpointOauth2ClientSecretModule = types.submodule {
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
  mkPodMetricsEndpointOauth2ClientSecret =
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
  PodMetricsEndpointOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = PodMetricsEndpointOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = PodMetricsEndpointOauth2ClientSecretModule;
      };
      "endpointParams" = mkOption {
        description = "`endpointParams` configures the HTTP parameters to append to the token\nURL.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "proxyConnectHeader" = mkOption {
        description = "ProxyConnectHeader optionally specifies headers to send to\nproxies during CONNECT requests.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.attrsOf (types.listOf (types.attrsOf types.anything)));
        default = { };
      };
      "proxyFromEnvironment" = mkOption {
        description = "Whether to use the proxy configuration defined by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY).\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = types.bool;
        default = false;
      };
      "proxyUrl" = mkOption {
        description = "`proxyURL` defines the HTTP proxy server to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "scopes" = mkOption {
        description = "`scopes` defines the OAuth2 scopes used for the token request.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration to use when connecting to the OAuth2 server.\nIt requires Prometheus >= v2.43.0.";
        type = (types.nullOr PodMetricsEndpointOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkPodMetricsEndpointOauth2 =
    res:
    {
      "clientId" = mkPodMetricsEndpointOauth2ClientId res."clientId";
      "clientSecret" = mkPodMetricsEndpointOauth2ClientSecret res."clientSecret";
    }
    // optionalAttrs (res."endpointParams" != { }) { inherit (res) "endpointParams"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."proxyConnectHeader" != { }) { inherit (res) "proxyConnectHeader"; }
    // {
    }
    // optionalAttrs res."proxyFromEnvironment" { inherit (res) "proxyFromEnvironment"; }
    // {
    }
    // optionalAttrs (res."proxyUrl" != null) { inherit (res) "proxyUrl"; }
    // {
    }
    // optionalAttrs (res."scopes" != [ ]) { inherit (res) "scopes"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkPodMetricsEndpointOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  PodMetricsEndpointOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkPodMetricsEndpointOauth2TlsConfigCaConfigMap =
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
  PodMetricsEndpointOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr PodMetricsEndpointOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr PodMetricsEndpointOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkPodMetricsEndpointOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkPodMetricsEndpointOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkPodMetricsEndpointOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  PodMetricsEndpointOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkPodMetricsEndpointOauth2TlsConfigCaSecret =
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
  PodMetricsEndpointOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkPodMetricsEndpointOauth2TlsConfigCertConfigMap =
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
  PodMetricsEndpointOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr PodMetricsEndpointOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr PodMetricsEndpointOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkPodMetricsEndpointOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkPodMetricsEndpointOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkPodMetricsEndpointOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  PodMetricsEndpointOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkPodMetricsEndpointOauth2TlsConfigCertSecret =
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
  PodMetricsEndpointOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkPodMetricsEndpointOauth2TlsConfigKeySecret =
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
  PodMetricsEndpointOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr PodMetricsEndpointOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr PodMetricsEndpointOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr PodMetricsEndpointOauth2TlsConfigKeySecretModule);
        default = null;
      };
      "maxVersion" = mkOption {
        description = "Maximum acceptable TLS version.\n\nIt requires Prometheus >= v2.41.0 or Thanos >= v0.31.0.";
        type = (
          types.nullOr (
            types.enum [
              "TLS10"
              "TLS11"
              "TLS12"
              "TLS13"
            ]
          )
        );
        default = null;
      };
      "minVersion" = mkOption {
        description = "Minimum acceptable TLS version.\n\nIt requires Prometheus >= v2.35.0 or Thanos >= v0.28.0.";
        type = (
          types.nullOr (
            types.enum [
              "TLS10"
              "TLS11"
              "TLS12"
              "TLS13"
            ]
          )
        );
        default = null;
      };
      "serverName" = mkOption {
        description = "Used to verify the hostname for the targets.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkPodMetricsEndpointOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkPodMetricsEndpointOauth2TlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkPodMetricsEndpointOauth2TlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkPodMetricsEndpointOauth2TlsConfigKeySecret res."keySecret";
    }
    // {
    }
    // optionalAttrs (res."maxVersion" != null) { inherit (res) "maxVersion"; }
    // {
    }
    // optionalAttrs (res."minVersion" != null) { inherit (res) "minVersion"; }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    };
  PodMetricsEndpointRelabelingModule = types.submodule {
    options = {
      "action" = mkOption {
        description = "Action to perform based on the regex matching.\n\n`Uppercase` and `Lowercase` actions require Prometheus >= v2.36.0.\n`DropEqual` and `KeepEqual` actions require Prometheus >= v2.41.0.\n\nDefault: \"Replace\"";
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
        description = "Modulus to take of the hash of the source label values.\n\nOnly applicable when the action is `HashMod`.";
        type = (types.nullOr types.int);
        default = null;
      };
      "regex" = mkOption {
        description = "Regular expression against which the extracted value is matched.";
        type = (types.nullOr types.str);
        default = null;
      };
      "replacement" = mkOption {
        description = "Replacement value against which a Replace action is performed if the\nregular expression matches.\n\nRegex capture groups are available.";
        type = (types.nullOr types.str);
        default = null;
      };
      "separator" = mkOption {
        description = "Separator is the string between concatenated SourceLabels.";
        type = (types.nullOr types.str);
        default = null;
      };
      "sourceLabels" = mkOption {
        description = "The source labels select values from existing labels. Their content is\nconcatenated using the configured Separator and matched against the\nconfigured regular expression.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "targetLabel" = mkOption {
        description = "Label to which the resulting string is written in a replacement.\n\nIt is mandatory for `Replace`, `HashMod`, `Lowercase`, `Uppercase`,\n`KeepEqual` and `DropEqual` actions.\n\nRegex capture groups are available.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkPodMetricsEndpointRelabeling =
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
  PodMetricsEndpointTlsConfigCaConfigMapModule = types.submodule {
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
  mkPodMetricsEndpointTlsConfigCaConfigMap =
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
  PodMetricsEndpointTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr PodMetricsEndpointTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr PodMetricsEndpointTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkPodMetricsEndpointTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkPodMetricsEndpointTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkPodMetricsEndpointTlsConfigCaSecret res."secret";
    }
    // {
    };
  PodMetricsEndpointTlsConfigCaSecretModule = types.submodule {
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
  mkPodMetricsEndpointTlsConfigCaSecret =
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
  PodMetricsEndpointTlsConfigCertConfigMapModule = types.submodule {
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
  mkPodMetricsEndpointTlsConfigCertConfigMap =
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
  PodMetricsEndpointTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr PodMetricsEndpointTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr PodMetricsEndpointTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkPodMetricsEndpointTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkPodMetricsEndpointTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkPodMetricsEndpointTlsConfigCertSecret res."secret";
    }
    // {
    };
  PodMetricsEndpointTlsConfigCertSecretModule = types.submodule {
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
  mkPodMetricsEndpointTlsConfigCertSecret =
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
  PodMetricsEndpointTlsConfigKeySecretModule = types.submodule {
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
  mkPodMetricsEndpointTlsConfigKeySecret =
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
  PodMetricsEndpointTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr PodMetricsEndpointTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr PodMetricsEndpointTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr PodMetricsEndpointTlsConfigKeySecretModule);
        default = null;
      };
      "maxVersion" = mkOption {
        description = "Maximum acceptable TLS version.\n\nIt requires Prometheus >= v2.41.0 or Thanos >= v0.31.0.";
        type = (
          types.nullOr (
            types.enum [
              "TLS10"
              "TLS11"
              "TLS12"
              "TLS13"
            ]
          )
        );
        default = null;
      };
      "minVersion" = mkOption {
        description = "Minimum acceptable TLS version.\n\nIt requires Prometheus >= v2.35.0 or Thanos >= v0.28.0.";
        type = (
          types.nullOr (
            types.enum [
              "TLS10"
              "TLS11"
              "TLS12"
              "TLS13"
            ]
          )
        );
        default = null;
      };
      "serverName" = mkOption {
        description = "Used to verify the hostname for the targets.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkPodMetricsEndpointTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkPodMetricsEndpointTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkPodMetricsEndpointTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkPodMetricsEndpointTlsConfigKeySecret res."keySecret";
    }
    // {
    }
    // optionalAttrs (res."maxVersion" != null) { inherit (res) "maxVersion"; }
    // {
    }
    // optionalAttrs (res."minVersion" != null) { inherit (res) "minVersion"; }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    };
  SelectorMatchExpressionModule = types.submodule {
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
  mkSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  SelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf SelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  PodmonitorsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this PodMonitor resource.";
        };
        "attachMetadata" = mkOption {
          description = "`attachMetadata` defines additional metadata which is added to the\ndiscovered targets.\n\nIt requires Prometheus >= v2.35.0.";
          type = (types.nullOr AttachMetadataModule);
          default = null;
        };
        "bodySizeLimit" = mkOption {
          description = "When defined, bodySizeLimit specifies a job level limit on the size\nof uncompressed response body that will be accepted by Prometheus.\n\nIt requires Prometheus >= v2.28.0.";
          type = (types.nullOr types.str);
          default = null;
        };
        "convertClassicHistogramsToNHCB" = mkOption {
          description = "Whether to convert all scraped classic histograms into a native histogram with custom buckets.\nIt requires Prometheus >= v3.0.0.";
          type = types.bool;
          default = false;
        };
        "fallbackScrapeProtocol" = mkOption {
          description = "The protocol to use if a scrape returns blank, unparseable, or otherwise invalid Content-Type.\n\nIt requires Prometheus >= v3.0.0.";
          type = (
            types.nullOr (
              types.enum [
                "PrometheusProto"
                "OpenMetricsText0.0.1"
                "OpenMetricsText1.0.0"
                "PrometheusText0.0.4"
                "PrometheusText1.0.0"
              ]
            )
          );
          default = null;
        };
        "jobLabel" = mkOption {
          description = "The label to use to retrieve the job name from.\n`jobLabel` selects the label from the associated Kubernetes `Pod`\nobject which will be used as the `job` label for all metrics.\n\nFor example if `jobLabel` is set to `foo` and the Kubernetes `Pod`\nobject is labeled with `foo: bar`, then Prometheus adds the `job=\"bar\"`\nlabel to all ingested metrics.\n\nIf the value of this field is empty, the `job` label of the metrics\ndefaults to the namespace and name of the PodMonitor object (e.g. `<namespace>/<name>`).";
          type = (types.nullOr types.str);
          default = null;
        };
        "keepDroppedTargets" = mkOption {
          description = "Per-scrape limit on the number of targets dropped by relabeling\nthat will be kept in memory. 0 means no limit.\n\nIt requires Prometheus >= v2.47.0.";
          type = (types.nullOr types.int);
          default = null;
        };
        "labelLimit" = mkOption {
          description = "Per-scrape limit on number of labels that will be accepted for a sample.\n\nIt requires Prometheus >= v2.27.0.";
          type = (types.nullOr types.int);
          default = null;
        };
        "labelNameLengthLimit" = mkOption {
          description = "Per-scrape limit on length of labels name that will be accepted for a sample.\n\nIt requires Prometheus >= v2.27.0.";
          type = (types.nullOr types.int);
          default = null;
        };
        "labelValueLengthLimit" = mkOption {
          description = "Per-scrape limit on length of labels value that will be accepted for a sample.\n\nIt requires Prometheus >= v2.27.0.";
          type = (types.nullOr types.int);
          default = null;
        };
        "namespaceSelector" = mkOption {
          description = "`namespaceSelector` defines in which namespace(s) Prometheus should discover the pods.\nBy default, the pods are discovered in the same namespace as the `PodMonitor` object but it is possible to select pods across different/all namespaces.";
          type = (types.nullOr NamespaceSelectorModule);
          default = null;
        };
        "nativeHistogramBucketLimit" = mkOption {
          description = "If there are more than this many buckets in a native histogram,\nbuckets will be merged to stay within the limit.\nIt requires Prometheus >= v2.45.0.";
          type = (types.nullOr types.int);
          default = null;
        };
        "nativeHistogramMinBucketFactor" = mkOption {
          description = "If the growth factor of one bucket to the next is smaller than this,\nbuckets will be merged to increase the factor sufficiently.\nIt requires Prometheus >= v2.50.0.";
          type = types.anything;
          default = { };
        };
        "podMetricsEndpoints" = mkOption {
          description = "Defines how to scrape metrics from the selected pods.";
          type = (types.listOf PodMetricsEndpointModule);
          default = [ ];
        };
        "podTargetLabels" = mkOption {
          description = "`podTargetLabels` defines the labels which are transferred from the\nassociated Kubernetes `Pod` object onto the ingested metrics.";
          type = (types.listOf types.str);
          default = [ ];
        };
        "sampleLimit" = mkOption {
          description = "`sampleLimit` defines a per-scrape limit on the number of scraped samples\nthat will be accepted.";
          type = (types.nullOr types.int);
          default = null;
        };
        "scrapeClass" = mkOption {
          description = "The scrape class to apply.";
          type = (types.nullOr types.str);
          default = null;
        };
        "scrapeClassicHistograms" = mkOption {
          description = "Whether to scrape a classic histogram that is also exposed as a native histogram.\nIt requires Prometheus >= v2.45.0.\n\nNotice: `scrapeClassicHistograms` corresponds to the `always_scrape_classic_histograms` field in the Prometheus configuration.";
          type = types.bool;
          default = false;
        };
        "scrapeProtocols" = mkOption {
          description = "`scrapeProtocols` defines the protocols to negotiate during a scrape. It tells clients the\nprotocols supported by Prometheus in order of preference (from most to least preferred).\n\nIf unset, Prometheus uses its default value.\n\nIt requires Prometheus >= v2.49.0.";
          type = (
            types.listOf (
              types.enum [
                "PrometheusProto"
                "OpenMetricsText0.0.1"
                "OpenMetricsText1.0.0"
                "PrometheusText0.0.4"
                "PrometheusText1.0.0"
              ]
            )
          );
          default = [ ];
        };
        "selector" = mkOption {
          description = "Label selector to select the Kubernetes `Pod` objects to scrape metrics from.";
          type = SelectorModule;
        };
        "selectorMechanism" = mkOption {
          description = "Mechanism used to select the endpoints to scrape.\nBy default, the selection process relies on relabel configurations to filter the discovered targets.\nAlternatively, you can opt in for role selectors, which may offer better efficiency in large clusters.\nWhich strategy is best for your use case needs to be carefully evaluated.\n\nIt requires Prometheus >= v2.17.0.";
          type = (
            types.nullOr (
              types.enum [
                "RelabelConfig"
                "RoleSelector"
              ]
            )
          );
          default = null;
        };
        "targetLimit" = mkOption {
          description = "`targetLimit` defines a limit on the number of scraped targets that will\nbe accepted.";
          type = (types.nullOr types.int);
          default = null;
        };
      };
    }
  );
  mkPodMonitor = name: res: {
    apiVersion = "monitoring.coreos.com/v1";
    kind = "PodMonitor";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."attachMetadata" != null) {
      "attachMetadata" = mkAttachMetadata res."attachMetadata";
    }
    // {
    }
    // optionalAttrs (res."bodySizeLimit" != null) { inherit (res) "bodySizeLimit"; }
    // {
    }
    // optionalAttrs res."convertClassicHistogramsToNHCB" {
      inherit (res) "convertClassicHistogramsToNHCB";
    }
    // {
    }
    // optionalAttrs (res."fallbackScrapeProtocol" != null) { inherit (res) "fallbackScrapeProtocol"; }
    // {
    }
    // optionalAttrs (res."jobLabel" != null) { inherit (res) "jobLabel"; }
    // {
    }
    // optionalAttrs (res."keepDroppedTargets" != null) { inherit (res) "keepDroppedTargets"; }
    // {
    }
    // optionalAttrs (res."labelLimit" != null) { inherit (res) "labelLimit"; }
    // {
    }
    // optionalAttrs (res."labelNameLengthLimit" != null) { inherit (res) "labelNameLengthLimit"; }
    // {
    }
    // optionalAttrs (res."labelValueLengthLimit" != null) { inherit (res) "labelValueLengthLimit"; }
    // {
    }
    // optionalAttrs (res."namespaceSelector" != null) {
      "namespaceSelector" = mkNamespaceSelector res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."nativeHistogramBucketLimit" != null) {
      inherit (res) "nativeHistogramBucketLimit";
    }
    // {
    }
    // optionalAttrs (res."nativeHistogramMinBucketFactor" != null) {
      inherit (res) "nativeHistogramMinBucketFactor";
    }
    // {
    }
    // optionalAttrs (res."podMetricsEndpoints" != [ ]) {
      "podMetricsEndpoints" = map mkPodMetricsEndpoint res."podMetricsEndpoints";
    }
    // {
    }
    // optionalAttrs (res."podTargetLabels" != [ ]) { inherit (res) "podTargetLabels"; }
    // {
    }
    // optionalAttrs (res."sampleLimit" != null) { inherit (res) "sampleLimit"; }
    // {
    }
    // optionalAttrs (res."scrapeClass" != null) { inherit (res) "scrapeClass"; }
    // {
    }
    // optionalAttrs res."scrapeClassicHistograms" { inherit (res) "scrapeClassicHistograms"; }
    // {
    }
    // optionalAttrs (res."scrapeProtocols" != [ ]) { inherit (res) "scrapeProtocols"; }
    // {
      "selector" = mkSelector res."selector";
    }
    // optionalAttrs (res."selectorMechanism" != null) { inherit (res) "selectorMechanism"; }
    // {
    }
    // optionalAttrs (res."targetLimit" != null) { inherit (res) "targetLimit"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkPodMonitor cfg."podmonitors");
in
{
  options.openkrill.apps."kube-prometheus" = {
    "podmonitors" = mkOption {
      type = types.attrsOf PodmonitorsModule;
      default = { };
      description = "PodMonitor CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."kube-prometheus".content = allResources;
  };
}
