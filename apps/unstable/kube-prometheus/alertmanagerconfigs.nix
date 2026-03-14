# Auto-generated openkrill module fragment for kube-prometheus
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."kube-prometheus";
  compact = filterAttrs (_: v: v != null);
  InhibitRuleModule = types.submodule {
    options = {
      "equal" = mkOption {
        description = "Labels that must have an equal value in the source and target alert for\nthe inhibition to take effect.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "sourceMatch" = mkOption {
        description = "Matchers for which one or more alerts have to exist for the inhibition\nto take effect. The operator enforces that the alert matches the\nresource's namespace.";
        type = (types.listOf InhibitRuleSourceMatchModule);
        default = [ ];
      };
      "targetMatch" = mkOption {
        description = "Matchers that have to be fulfilled in the alerts to be muted. The\noperator enforces that the alert matches the resource's namespace.";
        type = (types.listOf InhibitRuleTargetMatchModule);
        default = [ ];
      };
    };
  };
  mkInhibitRule =
    res:
    {
    }
    // optionalAttrs (res."equal" != [ ]) { inherit (res) "equal"; }
    // {
    }
    // optionalAttrs (res."sourceMatch" != [ ]) {
      "sourceMatch" = map mkInhibitRuleSourceMatch res."sourceMatch";
    }
    // {
    }
    // optionalAttrs (res."targetMatch" != [ ]) {
      "targetMatch" = map mkInhibitRuleTargetMatch res."targetMatch";
    }
    // {
    };
  InhibitRuleSourceMatchModule = types.submodule {
    options = {
      "matchType" = mkOption {
        description = "Match operation available with AlertManager >= v0.22.0 and\ntakes precedence over Regex (deprecated) if non-empty.";
        type = (
          types.nullOr (
            types.enum [
              "!="
              "="
              "=~"
              "!~"
            ]
          )
        );
        default = null;
      };
      "name" = mkOption {
        description = "Label to match.";
        type = types.str;
      };
      "regex" = mkOption {
        description = "Whether to match on equality (false) or regular-expression (true).\nDeprecated: for AlertManager >= v0.22.0, `matchType` should be used instead.";
        type = types.bool;
        default = false;
      };
      "value" = mkOption {
        description = "Label value to match.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkInhibitRuleSourceMatch =
    res:
    {
    }
    // optionalAttrs (res."matchType" != null) { inherit (res) "matchType"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs res."regex" { inherit (res) "regex"; }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  InhibitRuleTargetMatchModule = types.submodule {
    options = {
      "matchType" = mkOption {
        description = "Match operation available with AlertManager >= v0.22.0 and\ntakes precedence over Regex (deprecated) if non-empty.";
        type = (
          types.nullOr (
            types.enum [
              "!="
              "="
              "=~"
              "!~"
            ]
          )
        );
        default = null;
      };
      "name" = mkOption {
        description = "Label to match.";
        type = types.str;
      };
      "regex" = mkOption {
        description = "Whether to match on equality (false) or regular-expression (true).\nDeprecated: for AlertManager >= v0.22.0, `matchType` should be used instead.";
        type = types.bool;
        default = false;
      };
      "value" = mkOption {
        description = "Label value to match.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkInhibitRuleTargetMatch =
    res:
    {
    }
    // optionalAttrs (res."matchType" != null) { inherit (res) "matchType"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs res."regex" { inherit (res) "regex"; }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  MuteTimeIntervalModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the time interval";
        type = types.str;
      };
      "timeIntervals" = mkOption {
        description = "TimeIntervals is a list of TimeInterval";
        type = (types.listOf MuteTimeIntervalTimeIntervalModule);
        default = [ ];
      };
    };
  };
  mkMuteTimeInterval =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."timeIntervals" != [ ]) {
      "timeIntervals" = map mkMuteTimeIntervalTimeInterval res."timeIntervals";
    }
    // {
    };
  MuteTimeIntervalTimeIntervalDaysOfMonthModule = types.submodule {
    options = {
      "end" = mkOption {
        description = "End of the inclusive range";
        type = (types.nullOr types.int);
        default = null;
      };
      "start" = mkOption {
        description = "Start of the inclusive range";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkMuteTimeIntervalTimeIntervalDaysOfMonth =
    res:
    {
    }
    // optionalAttrs (res."end" != null) { inherit (res) "end"; }
    // {
    }
    // optionalAttrs (res."start" != null) { inherit (res) "start"; }
    // {
    };
  MuteTimeIntervalTimeIntervalModule = types.submodule {
    options = {
      "daysOfMonth" = mkOption {
        description = "DaysOfMonth is a list of DayOfMonthRange";
        type = (types.listOf MuteTimeIntervalTimeIntervalDaysOfMonthModule);
        default = [ ];
      };
      "months" = mkOption {
        description = "Months is a list of MonthRange";
        type = (types.listOf types.str);
        default = [ ];
      };
      "times" = mkOption {
        description = "Times is a list of TimeRange";
        type = (types.listOf MuteTimeIntervalTimeIntervalTimeModule);
        default = [ ];
      };
      "weekdays" = mkOption {
        description = "Weekdays is a list of WeekdayRange";
        type = (types.listOf types.str);
        default = [ ];
      };
      "years" = mkOption {
        description = "Years is a list of YearRange";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkMuteTimeIntervalTimeInterval =
    res:
    {
    }
    // optionalAttrs (res."daysOfMonth" != [ ]) {
      "daysOfMonth" = map mkMuteTimeIntervalTimeIntervalDaysOfMonth res."daysOfMonth";
    }
    // {
    }
    // optionalAttrs (res."months" != [ ]) { inherit (res) "months"; }
    // {
    }
    // optionalAttrs (res."times" != [ ]) {
      "times" = map mkMuteTimeIntervalTimeIntervalTime res."times";
    }
    // {
    }
    // optionalAttrs (res."weekdays" != [ ]) { inherit (res) "weekdays"; }
    // {
    }
    // optionalAttrs (res."years" != [ ]) { inherit (res) "years"; }
    // {
    };
  MuteTimeIntervalTimeIntervalTimeModule = types.submodule {
    options = {
      "endTime" = mkOption {
        description = "EndTime is the end time in 24hr format.";
        type = (types.nullOr types.str);
        default = null;
      };
      "startTime" = mkOption {
        description = "StartTime is the start time in 24hr format.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkMuteTimeIntervalTimeIntervalTime =
    res:
    {
    }
    // optionalAttrs (res."endTime" != null) { inherit (res) "endTime"; }
    // {
    }
    // optionalAttrs (res."startTime" != null) { inherit (res) "startTime"; }
    // {
    };
  ReceiverDiscordConfigApiURLModule = types.submodule {
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
  mkReceiverDiscordConfigApiURL =
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
  ReceiverDiscordConfigHttpConfigAuthorizationCredentialsModule = types.submodule {
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
  mkReceiverDiscordConfigHttpConfigAuthorizationCredentials =
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
  ReceiverDiscordConfigHttpConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr ReceiverDiscordConfigHttpConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverDiscordConfigHttpConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkReceiverDiscordConfigHttpConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ReceiverDiscordConfigHttpConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr ReceiverDiscordConfigHttpConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr ReceiverDiscordConfigHttpConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkReceiverDiscordConfigHttpConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkReceiverDiscordConfigHttpConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkReceiverDiscordConfigHttpConfigBasicAuthUsername res."username";
    }
    // {
    };
  ReceiverDiscordConfigHttpConfigBasicAuthPasswordModule = types.submodule {
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
  mkReceiverDiscordConfigHttpConfigBasicAuthPassword =
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
  ReceiverDiscordConfigHttpConfigBasicAuthUsernameModule = types.submodule {
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
  mkReceiverDiscordConfigHttpConfigBasicAuthUsername =
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
  ReceiverDiscordConfigHttpConfigBearerTokenSecretModule = types.submodule {
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
  mkReceiverDiscordConfigHttpConfigBearerTokenSecret =
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
  ReceiverDiscordConfigHttpConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization header configuration for the client.\nThis is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+.";
        type = (types.nullOr ReceiverDiscordConfigHttpConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "BasicAuth for the client.\nThis is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence.";
        type = (types.nullOr ReceiverDiscordConfigHttpConfigBasicAuthModule);
        default = null;
      };
      "bearerTokenSecret" = mkOption {
        description = "The secret's key that contains the bearer token to be used by the client\nfor authentication.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.";
        type = (types.nullOr ReceiverDiscordConfigHttpConfigBearerTokenSecretModule);
        default = null;
      };
      "followRedirects" = mkOption {
        description = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "OAuth2 client credentials used to fetch a token for the targets.";
        type = (types.nullOr ReceiverDiscordConfigHttpConfigOauth2Module);
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
      "proxyURL" = mkOption {
        description = "Optional proxy URL.\n\nIf defined, this field takes precedence over `proxyUrl`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "proxyUrl" = mkOption {
        description = "`proxyURL` defines the HTTP proxy server to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration for the client.";
        type = (types.nullOr ReceiverDiscordConfigHttpConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkReceiverDiscordConfigHttpConfig =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkReceiverDiscordConfigHttpConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkReceiverDiscordConfigHttpConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs (res."bearerTokenSecret" != null) {
      "bearerTokenSecret" = mkReceiverDiscordConfigHttpConfigBearerTokenSecret res."bearerTokenSecret";
    }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) {
      "oauth2" = mkReceiverDiscordConfigHttpConfigOauth2 res."oauth2";
    }
    // {
    }
    // optionalAttrs (res."proxyConnectHeader" != { }) { inherit (res) "proxyConnectHeader"; }
    // {
    }
    // optionalAttrs res."proxyFromEnvironment" { inherit (res) "proxyFromEnvironment"; }
    // {
    }
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."proxyUrl" != null) { inherit (res) "proxyUrl"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkReceiverDiscordConfigHttpConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  ReceiverDiscordConfigHttpConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkReceiverDiscordConfigHttpConfigOauth2ClientIdConfigMap =
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
  ReceiverDiscordConfigHttpConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverDiscordConfigHttpConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverDiscordConfigHttpConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkReceiverDiscordConfigHttpConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverDiscordConfigHttpConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverDiscordConfigHttpConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  ReceiverDiscordConfigHttpConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkReceiverDiscordConfigHttpConfigOauth2ClientIdSecret =
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
  ReceiverDiscordConfigHttpConfigOauth2ClientSecretModule = types.submodule {
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
  mkReceiverDiscordConfigHttpConfigOauth2ClientSecret =
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
  ReceiverDiscordConfigHttpConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = ReceiverDiscordConfigHttpConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = ReceiverDiscordConfigHttpConfigOauth2ClientSecretModule;
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
        type = (types.nullOr ReceiverDiscordConfigHttpConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkReceiverDiscordConfigHttpConfigOauth2 =
    res:
    {
      "clientId" = mkReceiverDiscordConfigHttpConfigOauth2ClientId res."clientId";
      "clientSecret" = mkReceiverDiscordConfigHttpConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkReceiverDiscordConfigHttpConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  ReceiverDiscordConfigHttpConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverDiscordConfigHttpConfigOauth2TlsConfigCaConfigMap =
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
  ReceiverDiscordConfigHttpConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverDiscordConfigHttpConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverDiscordConfigHttpConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverDiscordConfigHttpConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverDiscordConfigHttpConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverDiscordConfigHttpConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverDiscordConfigHttpConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkReceiverDiscordConfigHttpConfigOauth2TlsConfigCaSecret =
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
  ReceiverDiscordConfigHttpConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverDiscordConfigHttpConfigOauth2TlsConfigCertConfigMap =
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
  ReceiverDiscordConfigHttpConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverDiscordConfigHttpConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverDiscordConfigHttpConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverDiscordConfigHttpConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverDiscordConfigHttpConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverDiscordConfigHttpConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverDiscordConfigHttpConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkReceiverDiscordConfigHttpConfigOauth2TlsConfigCertSecret =
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
  ReceiverDiscordConfigHttpConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkReceiverDiscordConfigHttpConfigOauth2TlsConfigKeySecret =
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
  ReceiverDiscordConfigHttpConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverDiscordConfigHttpConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverDiscordConfigHttpConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverDiscordConfigHttpConfigOauth2TlsConfigKeySecretModule);
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
  mkReceiverDiscordConfigHttpConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverDiscordConfigHttpConfigOauth2TlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverDiscordConfigHttpConfigOauth2TlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverDiscordConfigHttpConfigOauth2TlsConfigKeySecret res."keySecret";
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
  ReceiverDiscordConfigHttpConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverDiscordConfigHttpConfigTlsConfigCaConfigMap =
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
  ReceiverDiscordConfigHttpConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverDiscordConfigHttpConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverDiscordConfigHttpConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverDiscordConfigHttpConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverDiscordConfigHttpConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverDiscordConfigHttpConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverDiscordConfigHttpConfigTlsConfigCaSecretModule = types.submodule {
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
  mkReceiverDiscordConfigHttpConfigTlsConfigCaSecret =
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
  ReceiverDiscordConfigHttpConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverDiscordConfigHttpConfigTlsConfigCertConfigMap =
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
  ReceiverDiscordConfigHttpConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverDiscordConfigHttpConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverDiscordConfigHttpConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverDiscordConfigHttpConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverDiscordConfigHttpConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverDiscordConfigHttpConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverDiscordConfigHttpConfigTlsConfigCertSecretModule = types.submodule {
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
  mkReceiverDiscordConfigHttpConfigTlsConfigCertSecret =
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
  ReceiverDiscordConfigHttpConfigTlsConfigKeySecretModule = types.submodule {
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
  mkReceiverDiscordConfigHttpConfigTlsConfigKeySecret =
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
  ReceiverDiscordConfigHttpConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverDiscordConfigHttpConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverDiscordConfigHttpConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverDiscordConfigHttpConfigTlsConfigKeySecretModule);
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
  mkReceiverDiscordConfigHttpConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverDiscordConfigHttpConfigTlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverDiscordConfigHttpConfigTlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverDiscordConfigHttpConfigTlsConfigKeySecret res."keySecret";
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
  ReceiverDiscordConfigModule = types.submodule {
    options = {
      "apiURL" = mkOption {
        description = "The secret's key that contains the Discord webhook URL.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.";
        type = ReceiverDiscordConfigApiURLModule;
      };
      "avatarURL" = mkOption {
        description = "The avatar url of the message sender.";
        type = (types.nullOr types.str);
        default = null;
      };
      "content" = mkOption {
        description = "The template of the content's body.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpConfig" = mkOption {
        description = "HTTP client configuration.";
        type = (types.nullOr ReceiverDiscordConfigHttpConfigModule);
        default = null;
      };
      "message" = mkOption {
        description = "The template of the message's body.";
        type = (types.nullOr types.str);
        default = null;
      };
      "sendResolved" = mkOption {
        description = "Whether or not to notify about resolved alerts.";
        type = types.bool;
        default = false;
      };
      "title" = mkOption {
        description = "The template of the message's title.";
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
        description = "The username of the message sender.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverDiscordConfig =
    res:
    {
      "apiURL" = mkReceiverDiscordConfigApiURL res."apiURL";
    }
    // optionalAttrs (res."avatarURL" != null) { inherit (res) "avatarURL"; }
    // {
    }
    // optionalAttrs (res."content" != null) { inherit (res) "content"; }
    // {
    }
    // optionalAttrs (res."httpConfig" != null) {
      "httpConfig" = mkReceiverDiscordConfigHttpConfig res."httpConfig";
    }
    // {
    }
    // optionalAttrs (res."message" != null) { inherit (res) "message"; }
    // {
    }
    // optionalAttrs res."sendResolved" { inherit (res) "sendResolved"; }
    // {
    }
    // optionalAttrs (res."title" != null) { inherit (res) "title"; }
    // {
    }
    // optionalAttrs (res."username" != null) { inherit (res) "username"; }
    // {
    };
  ReceiverEmailConfigAuthPasswordModule = types.submodule {
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
  mkReceiverEmailConfigAuthPassword =
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
  ReceiverEmailConfigAuthSecretModule = types.submodule {
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
  mkReceiverEmailConfigAuthSecret =
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
  ReceiverEmailConfigHeaderModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "Key of the tuple.";
        type = types.str;
      };
      "value" = mkOption {
        description = "Value of the tuple.";
        type = types.str;
      };
    };
  };
  mkReceiverEmailConfigHeader = res: {
    inherit (res) "key";
    inherit (res) "value";
  };
  ReceiverEmailConfigModule = types.submodule {
    options = {
      "authIdentity" = mkOption {
        description = "The identity to use for authentication.";
        type = (types.nullOr types.str);
        default = null;
      };
      "authPassword" = mkOption {
        description = "The secret's key that contains the password to use for authentication.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.";
        type = (types.nullOr ReceiverEmailConfigAuthPasswordModule);
        default = null;
      };
      "authSecret" = mkOption {
        description = "The secret's key that contains the CRAM-MD5 secret.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.";
        type = (types.nullOr ReceiverEmailConfigAuthSecretModule);
        default = null;
      };
      "authUsername" = mkOption {
        description = "The username to use for authentication.";
        type = (types.nullOr types.str);
        default = null;
      };
      "from" = mkOption {
        description = "The sender address.";
        type = (types.nullOr types.str);
        default = null;
      };
      "headers" = mkOption {
        description = "Further headers email header key/value pairs. Overrides any headers\npreviously set by the notification implementation.";
        type = (types.listOf ReceiverEmailConfigHeaderModule);
        default = [ ];
      };
      "hello" = mkOption {
        description = "The hostname to identify to the SMTP server.";
        type = (types.nullOr types.str);
        default = null;
      };
      "html" = mkOption {
        description = "The HTML body of the email notification.";
        type = (types.nullOr types.str);
        default = null;
      };
      "requireTLS" = mkOption {
        description = "The SMTP TLS requirement.\nNote that Go does not support unencrypted connections to remote SMTP endpoints.";
        type = types.bool;
        default = false;
      };
      "sendResolved" = mkOption {
        description = "Whether or not to notify about resolved alerts.";
        type = types.bool;
        default = false;
      };
      "smarthost" = mkOption {
        description = "The SMTP host and port through which emails are sent. E.g. example.com:25";
        type = (types.nullOr types.str);
        default = null;
      };
      "text" = mkOption {
        description = "The text body of the email notification.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration";
        type = (types.nullOr ReceiverEmailConfigTlsConfigModule);
        default = null;
      };
      "to" = mkOption {
        description = "The email address to send notifications to.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverEmailConfig =
    res:
    {
    }
    // optionalAttrs (res."authIdentity" != null) { inherit (res) "authIdentity"; }
    // {
    }
    // optionalAttrs (res."authPassword" != null) {
      "authPassword" = mkReceiverEmailConfigAuthPassword res."authPassword";
    }
    // {
    }
    // optionalAttrs (res."authSecret" != null) {
      "authSecret" = mkReceiverEmailConfigAuthSecret res."authSecret";
    }
    // {
    }
    // optionalAttrs (res."authUsername" != null) { inherit (res) "authUsername"; }
    // {
    }
    // optionalAttrs (res."from" != null) { inherit (res) "from"; }
    // {
    }
    // optionalAttrs (res."headers" != [ ]) {
      "headers" = map mkReceiverEmailConfigHeader res."headers";
    }
    // {
    }
    // optionalAttrs (res."hello" != null) { inherit (res) "hello"; }
    // {
    }
    // optionalAttrs (res."html" != null) { inherit (res) "html"; }
    // {
    }
    // optionalAttrs res."requireTLS" { inherit (res) "requireTLS"; }
    // {
    }
    // optionalAttrs res."sendResolved" { inherit (res) "sendResolved"; }
    // {
    }
    // optionalAttrs (res."smarthost" != null) { inherit (res) "smarthost"; }
    // {
    }
    // optionalAttrs (res."text" != null) { inherit (res) "text"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkReceiverEmailConfigTlsConfig res."tlsConfig";
    }
    // {
    }
    // optionalAttrs (res."to" != null) { inherit (res) "to"; }
    // {
    };
  ReceiverEmailConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverEmailConfigTlsConfigCaConfigMap =
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
  ReceiverEmailConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverEmailConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverEmailConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverEmailConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverEmailConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverEmailConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverEmailConfigTlsConfigCaSecretModule = types.submodule {
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
  mkReceiverEmailConfigTlsConfigCaSecret =
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
  ReceiverEmailConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverEmailConfigTlsConfigCertConfigMap =
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
  ReceiverEmailConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverEmailConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverEmailConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverEmailConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverEmailConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverEmailConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverEmailConfigTlsConfigCertSecretModule = types.submodule {
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
  mkReceiverEmailConfigTlsConfigCertSecret =
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
  ReceiverEmailConfigTlsConfigKeySecretModule = types.submodule {
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
  mkReceiverEmailConfigTlsConfigKeySecret =
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
  ReceiverEmailConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverEmailConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverEmailConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverEmailConfigTlsConfigKeySecretModule);
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
  mkReceiverEmailConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkReceiverEmailConfigTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkReceiverEmailConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverEmailConfigTlsConfigKeySecret res."keySecret";
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
  ReceiverModule = types.submodule {
    options = {
      "discordConfigs" = mkOption {
        description = "List of Discord configurations.";
        type = (types.listOf ReceiverDiscordConfigModule);
        default = [ ];
      };
      "emailConfigs" = mkOption {
        description = "List of Email configurations.";
        type = (types.listOf ReceiverEmailConfigModule);
        default = [ ];
      };
      "msteamsConfigs" = mkOption {
        description = "List of MSTeams configurations.\nIt requires Alertmanager >= 0.26.0.";
        type = (types.listOf ReceiverMsteamsConfigModule);
        default = [ ];
      };
      "msteamsv2Configs" = mkOption {
        description = "List of MSTeamsV2 configurations.\nIt requires Alertmanager >= 0.28.0.";
        type = (types.listOf ReceiverMsteamsv2ConfigModule);
        default = [ ];
      };
      "name" = mkOption {
        description = "Name of the receiver. Must be unique across all items from the list.";
        type = types.str;
      };
      "opsgenieConfigs" = mkOption {
        description = "List of OpsGenie configurations.";
        type = (types.listOf ReceiverOpsgenieConfigModule);
        default = [ ];
      };
      "pagerdutyConfigs" = mkOption {
        description = "List of PagerDuty configurations.";
        type = (types.listOf ReceiverPagerdutyConfigModule);
        default = [ ];
      };
      "pushoverConfigs" = mkOption {
        description = "List of Pushover configurations.";
        type = (types.listOf ReceiverPushoverConfigModule);
        default = [ ];
      };
      "rocketchatConfigs" = mkOption {
        description = "List of RocketChat configurations.\nIt requires Alertmanager >= 0.28.0.";
        type = (types.listOf ReceiverRocketchatConfigModule);
        default = [ ];
      };
      "slackConfigs" = mkOption {
        description = "List of Slack configurations.";
        type = (types.listOf ReceiverSlackConfigModule);
        default = [ ];
      };
      "snsConfigs" = mkOption {
        description = "List of SNS configurations";
        type = (types.listOf ReceiverSnsConfigModule);
        default = [ ];
      };
      "telegramConfigs" = mkOption {
        description = "List of Telegram configurations.";
        type = (types.listOf ReceiverTelegramConfigModule);
        default = [ ];
      };
      "victoropsConfigs" = mkOption {
        description = "List of VictorOps configurations.";
        type = (types.listOf ReceiverVictoropsConfigModule);
        default = [ ];
      };
      "webexConfigs" = mkOption {
        description = "List of Webex configurations.";
        type = (types.listOf ReceiverWebexConfigModule);
        default = [ ];
      };
      "webhookConfigs" = mkOption {
        description = "List of webhook configurations.";
        type = (types.listOf ReceiverWebhookConfigModule);
        default = [ ];
      };
      "wechatConfigs" = mkOption {
        description = "List of WeChat configurations.";
        type = (types.listOf ReceiverWechatConfigModule);
        default = [ ];
      };
    };
  };
  mkReceiver =
    res:
    {
    }
    // optionalAttrs (res."discordConfigs" != [ ]) {
      "discordConfigs" = map mkReceiverDiscordConfig res."discordConfigs";
    }
    // {
    }
    // optionalAttrs (res."emailConfigs" != [ ]) {
      "emailConfigs" = map mkReceiverEmailConfig res."emailConfigs";
    }
    // {
    }
    // optionalAttrs (res."msteamsConfigs" != [ ]) {
      "msteamsConfigs" = map mkReceiverMsteamsConfig res."msteamsConfigs";
    }
    // {
    }
    // optionalAttrs (res."msteamsv2Configs" != [ ]) {
      "msteamsv2Configs" = map mkReceiverMsteamsv2Config res."msteamsv2Configs";
    }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."opsgenieConfigs" != [ ]) {
      "opsgenieConfigs" = map mkReceiverOpsgenieConfig res."opsgenieConfigs";
    }
    // {
    }
    // optionalAttrs (res."pagerdutyConfigs" != [ ]) {
      "pagerdutyConfigs" = map mkReceiverPagerdutyConfig res."pagerdutyConfigs";
    }
    // {
    }
    // optionalAttrs (res."pushoverConfigs" != [ ]) {
      "pushoverConfigs" = map mkReceiverPushoverConfig res."pushoverConfigs";
    }
    // {
    }
    // optionalAttrs (res."rocketchatConfigs" != [ ]) {
      "rocketchatConfigs" = map mkReceiverRocketchatConfig res."rocketchatConfigs";
    }
    // {
    }
    // optionalAttrs (res."slackConfigs" != [ ]) {
      "slackConfigs" = map mkReceiverSlackConfig res."slackConfigs";
    }
    // {
    }
    // optionalAttrs (res."snsConfigs" != [ ]) {
      "snsConfigs" = map mkReceiverSnsConfig res."snsConfigs";
    }
    // {
    }
    // optionalAttrs (res."telegramConfigs" != [ ]) {
      "telegramConfigs" = map mkReceiverTelegramConfig res."telegramConfigs";
    }
    // {
    }
    // optionalAttrs (res."victoropsConfigs" != [ ]) {
      "victoropsConfigs" = map mkReceiverVictoropsConfig res."victoropsConfigs";
    }
    // {
    }
    // optionalAttrs (res."webexConfigs" != [ ]) {
      "webexConfigs" = map mkReceiverWebexConfig res."webexConfigs";
    }
    // {
    }
    // optionalAttrs (res."webhookConfigs" != [ ]) {
      "webhookConfigs" = map mkReceiverWebhookConfig res."webhookConfigs";
    }
    // {
    }
    // optionalAttrs (res."wechatConfigs" != [ ]) {
      "wechatConfigs" = map mkReceiverWechatConfig res."wechatConfigs";
    }
    // {
    };
  ReceiverMsteamsConfigHttpConfigAuthorizationCredentialsModule = types.submodule {
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
  mkReceiverMsteamsConfigHttpConfigAuthorizationCredentials =
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
  ReceiverMsteamsConfigHttpConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverMsteamsConfigHttpConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkReceiverMsteamsConfigHttpConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ReceiverMsteamsConfigHttpConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkReceiverMsteamsConfigHttpConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkReceiverMsteamsConfigHttpConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkReceiverMsteamsConfigHttpConfigBasicAuthUsername res."username";
    }
    // {
    };
  ReceiverMsteamsConfigHttpConfigBasicAuthPasswordModule = types.submodule {
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
  mkReceiverMsteamsConfigHttpConfigBasicAuthPassword =
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
  ReceiverMsteamsConfigHttpConfigBasicAuthUsernameModule = types.submodule {
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
  mkReceiverMsteamsConfigHttpConfigBasicAuthUsername =
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
  ReceiverMsteamsConfigHttpConfigBearerTokenSecretModule = types.submodule {
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
  mkReceiverMsteamsConfigHttpConfigBearerTokenSecret =
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
  ReceiverMsteamsConfigHttpConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization header configuration for the client.\nThis is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+.";
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "BasicAuth for the client.\nThis is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence.";
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigBasicAuthModule);
        default = null;
      };
      "bearerTokenSecret" = mkOption {
        description = "The secret's key that contains the bearer token to be used by the client\nfor authentication.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.";
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigBearerTokenSecretModule);
        default = null;
      };
      "followRedirects" = mkOption {
        description = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "OAuth2 client credentials used to fetch a token for the targets.";
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigOauth2Module);
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
      "proxyURL" = mkOption {
        description = "Optional proxy URL.\n\nIf defined, this field takes precedence over `proxyUrl`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "proxyUrl" = mkOption {
        description = "`proxyURL` defines the HTTP proxy server to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration for the client.";
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkReceiverMsteamsConfigHttpConfig =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkReceiverMsteamsConfigHttpConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkReceiverMsteamsConfigHttpConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs (res."bearerTokenSecret" != null) {
      "bearerTokenSecret" = mkReceiverMsteamsConfigHttpConfigBearerTokenSecret res."bearerTokenSecret";
    }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) {
      "oauth2" = mkReceiverMsteamsConfigHttpConfigOauth2 res."oauth2";
    }
    // {
    }
    // optionalAttrs (res."proxyConnectHeader" != { }) { inherit (res) "proxyConnectHeader"; }
    // {
    }
    // optionalAttrs res."proxyFromEnvironment" { inherit (res) "proxyFromEnvironment"; }
    // {
    }
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."proxyUrl" != null) { inherit (res) "proxyUrl"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkReceiverMsteamsConfigHttpConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  ReceiverMsteamsConfigHttpConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkReceiverMsteamsConfigHttpConfigOauth2ClientIdConfigMap =
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
  ReceiverMsteamsConfigHttpConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkReceiverMsteamsConfigHttpConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverMsteamsConfigHttpConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverMsteamsConfigHttpConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  ReceiverMsteamsConfigHttpConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkReceiverMsteamsConfigHttpConfigOauth2ClientIdSecret =
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
  ReceiverMsteamsConfigHttpConfigOauth2ClientSecretModule = types.submodule {
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
  mkReceiverMsteamsConfigHttpConfigOauth2ClientSecret =
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
  ReceiverMsteamsConfigHttpConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = ReceiverMsteamsConfigHttpConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = ReceiverMsteamsConfigHttpConfigOauth2ClientSecretModule;
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
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkReceiverMsteamsConfigHttpConfigOauth2 =
    res:
    {
      "clientId" = mkReceiverMsteamsConfigHttpConfigOauth2ClientId res."clientId";
      "clientSecret" = mkReceiverMsteamsConfigHttpConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkReceiverMsteamsConfigHttpConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  ReceiverMsteamsConfigHttpConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverMsteamsConfigHttpConfigOauth2TlsConfigCaConfigMap =
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
  ReceiverMsteamsConfigHttpConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverMsteamsConfigHttpConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverMsteamsConfigHttpConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverMsteamsConfigHttpConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverMsteamsConfigHttpConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkReceiverMsteamsConfigHttpConfigOauth2TlsConfigCaSecret =
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
  ReceiverMsteamsConfigHttpConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverMsteamsConfigHttpConfigOauth2TlsConfigCertConfigMap =
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
  ReceiverMsteamsConfigHttpConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverMsteamsConfigHttpConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverMsteamsConfigHttpConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverMsteamsConfigHttpConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverMsteamsConfigHttpConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkReceiverMsteamsConfigHttpConfigOauth2TlsConfigCertSecret =
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
  ReceiverMsteamsConfigHttpConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkReceiverMsteamsConfigHttpConfigOauth2TlsConfigKeySecret =
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
  ReceiverMsteamsConfigHttpConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigOauth2TlsConfigKeySecretModule);
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
  mkReceiverMsteamsConfigHttpConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverMsteamsConfigHttpConfigOauth2TlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverMsteamsConfigHttpConfigOauth2TlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverMsteamsConfigHttpConfigOauth2TlsConfigKeySecret res."keySecret";
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
  ReceiverMsteamsConfigHttpConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverMsteamsConfigHttpConfigTlsConfigCaConfigMap =
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
  ReceiverMsteamsConfigHttpConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverMsteamsConfigHttpConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverMsteamsConfigHttpConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverMsteamsConfigHttpConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverMsteamsConfigHttpConfigTlsConfigCaSecretModule = types.submodule {
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
  mkReceiverMsteamsConfigHttpConfigTlsConfigCaSecret =
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
  ReceiverMsteamsConfigHttpConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverMsteamsConfigHttpConfigTlsConfigCertConfigMap =
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
  ReceiverMsteamsConfigHttpConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverMsteamsConfigHttpConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverMsteamsConfigHttpConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverMsteamsConfigHttpConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverMsteamsConfigHttpConfigTlsConfigCertSecretModule = types.submodule {
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
  mkReceiverMsteamsConfigHttpConfigTlsConfigCertSecret =
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
  ReceiverMsteamsConfigHttpConfigTlsConfigKeySecretModule = types.submodule {
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
  mkReceiverMsteamsConfigHttpConfigTlsConfigKeySecret =
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
  ReceiverMsteamsConfigHttpConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigTlsConfigKeySecretModule);
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
  mkReceiverMsteamsConfigHttpConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverMsteamsConfigHttpConfigTlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverMsteamsConfigHttpConfigTlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverMsteamsConfigHttpConfigTlsConfigKeySecret res."keySecret";
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
  ReceiverMsteamsConfigModule = types.submodule {
    options = {
      "httpConfig" = mkOption {
        description = "HTTP client configuration.";
        type = (types.nullOr ReceiverMsteamsConfigHttpConfigModule);
        default = null;
      };
      "sendResolved" = mkOption {
        description = "Whether to notify about resolved alerts.";
        type = types.bool;
        default = false;
      };
      "summary" = mkOption {
        description = "Message summary template.\nIt requires Alertmanager >= 0.27.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "text" = mkOption {
        description = "Message body template.";
        type = (types.nullOr types.str);
        default = null;
      };
      "title" = mkOption {
        description = "Message title template.";
        type = (types.nullOr types.str);
        default = null;
      };
      "webhookUrl" = mkOption {
        description = "MSTeams webhook URL.";
        type = ReceiverMsteamsConfigWebhookUrlModule;
      };
    };
  };
  mkReceiverMsteamsConfig =
    res:
    {
    }
    // optionalAttrs (res."httpConfig" != null) {
      "httpConfig" = mkReceiverMsteamsConfigHttpConfig res."httpConfig";
    }
    // {
    }
    // optionalAttrs res."sendResolved" { inherit (res) "sendResolved"; }
    // {
    }
    // optionalAttrs (res."summary" != null) { inherit (res) "summary"; }
    // {
    }
    // optionalAttrs (res."text" != null) { inherit (res) "text"; }
    // {
    }
    // optionalAttrs (res."title" != null) { inherit (res) "title"; }
    // {
      "webhookUrl" = mkReceiverMsteamsConfigWebhookUrl res."webhookUrl";
    };
  ReceiverMsteamsConfigWebhookUrlModule = types.submodule {
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
  mkReceiverMsteamsConfigWebhookUrl =
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
  ReceiverMsteamsv2ConfigHttpConfigAuthorizationCredentialsModule = types.submodule {
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
  mkReceiverMsteamsv2ConfigHttpConfigAuthorizationCredentials =
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
  ReceiverMsteamsv2ConfigHttpConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverMsteamsv2ConfigHttpConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkReceiverMsteamsv2ConfigHttpConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ReceiverMsteamsv2ConfigHttpConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkReceiverMsteamsv2ConfigHttpConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkReceiverMsteamsv2ConfigHttpConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkReceiverMsteamsv2ConfigHttpConfigBasicAuthUsername res."username";
    }
    // {
    };
  ReceiverMsteamsv2ConfigHttpConfigBasicAuthPasswordModule = types.submodule {
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
  mkReceiverMsteamsv2ConfigHttpConfigBasicAuthPassword =
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
  ReceiverMsteamsv2ConfigHttpConfigBasicAuthUsernameModule = types.submodule {
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
  mkReceiverMsteamsv2ConfigHttpConfigBasicAuthUsername =
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
  ReceiverMsteamsv2ConfigHttpConfigBearerTokenSecretModule = types.submodule {
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
  mkReceiverMsteamsv2ConfigHttpConfigBearerTokenSecret =
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
  ReceiverMsteamsv2ConfigHttpConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization header configuration for the client.\nThis is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+.";
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "BasicAuth for the client.\nThis is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence.";
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigBasicAuthModule);
        default = null;
      };
      "bearerTokenSecret" = mkOption {
        description = "The secret's key that contains the bearer token to be used by the client\nfor authentication.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.";
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigBearerTokenSecretModule);
        default = null;
      };
      "followRedirects" = mkOption {
        description = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "OAuth2 client credentials used to fetch a token for the targets.";
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigOauth2Module);
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
      "proxyURL" = mkOption {
        description = "Optional proxy URL.\n\nIf defined, this field takes precedence over `proxyUrl`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "proxyUrl" = mkOption {
        description = "`proxyURL` defines the HTTP proxy server to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration for the client.";
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkReceiverMsteamsv2ConfigHttpConfig =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkReceiverMsteamsv2ConfigHttpConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkReceiverMsteamsv2ConfigHttpConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs (res."bearerTokenSecret" != null) {
      "bearerTokenSecret" = mkReceiverMsteamsv2ConfigHttpConfigBearerTokenSecret res."bearerTokenSecret";
    }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) {
      "oauth2" = mkReceiverMsteamsv2ConfigHttpConfigOauth2 res."oauth2";
    }
    // {
    }
    // optionalAttrs (res."proxyConnectHeader" != { }) { inherit (res) "proxyConnectHeader"; }
    // {
    }
    // optionalAttrs res."proxyFromEnvironment" { inherit (res) "proxyFromEnvironment"; }
    // {
    }
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."proxyUrl" != null) { inherit (res) "proxyUrl"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkReceiverMsteamsv2ConfigHttpConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  ReceiverMsteamsv2ConfigHttpConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkReceiverMsteamsv2ConfigHttpConfigOauth2ClientIdConfigMap =
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
  ReceiverMsteamsv2ConfigHttpConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkReceiverMsteamsv2ConfigHttpConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverMsteamsv2ConfigHttpConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverMsteamsv2ConfigHttpConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  ReceiverMsteamsv2ConfigHttpConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkReceiverMsteamsv2ConfigHttpConfigOauth2ClientIdSecret =
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
  ReceiverMsteamsv2ConfigHttpConfigOauth2ClientSecretModule = types.submodule {
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
  mkReceiverMsteamsv2ConfigHttpConfigOauth2ClientSecret =
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
  ReceiverMsteamsv2ConfigHttpConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = ReceiverMsteamsv2ConfigHttpConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = ReceiverMsteamsv2ConfigHttpConfigOauth2ClientSecretModule;
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
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkReceiverMsteamsv2ConfigHttpConfigOauth2 =
    res:
    {
      "clientId" = mkReceiverMsteamsv2ConfigHttpConfigOauth2ClientId res."clientId";
      "clientSecret" = mkReceiverMsteamsv2ConfigHttpConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  ReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigCaConfigMap =
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
  ReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigCaSecret =
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
  ReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigCertConfigMap =
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
  ReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigCertSecret =
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
  ReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigKeySecret =
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
  ReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigKeySecretModule);
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
  mkReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverMsteamsv2ConfigHttpConfigOauth2TlsConfigKeySecret res."keySecret";
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
  ReceiverMsteamsv2ConfigHttpConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverMsteamsv2ConfigHttpConfigTlsConfigCaConfigMap =
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
  ReceiverMsteamsv2ConfigHttpConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverMsteamsv2ConfigHttpConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverMsteamsv2ConfigHttpConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverMsteamsv2ConfigHttpConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverMsteamsv2ConfigHttpConfigTlsConfigCaSecretModule = types.submodule {
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
  mkReceiverMsteamsv2ConfigHttpConfigTlsConfigCaSecret =
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
  ReceiverMsteamsv2ConfigHttpConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverMsteamsv2ConfigHttpConfigTlsConfigCertConfigMap =
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
  ReceiverMsteamsv2ConfigHttpConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverMsteamsv2ConfigHttpConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverMsteamsv2ConfigHttpConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverMsteamsv2ConfigHttpConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverMsteamsv2ConfigHttpConfigTlsConfigCertSecretModule = types.submodule {
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
  mkReceiverMsteamsv2ConfigHttpConfigTlsConfigCertSecret =
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
  ReceiverMsteamsv2ConfigHttpConfigTlsConfigKeySecretModule = types.submodule {
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
  mkReceiverMsteamsv2ConfigHttpConfigTlsConfigKeySecret =
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
  ReceiverMsteamsv2ConfigHttpConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigTlsConfigKeySecretModule);
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
  mkReceiverMsteamsv2ConfigHttpConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverMsteamsv2ConfigHttpConfigTlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverMsteamsv2ConfigHttpConfigTlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverMsteamsv2ConfigHttpConfigTlsConfigKeySecret res."keySecret";
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
  ReceiverMsteamsv2ConfigModule = types.submodule {
    options = {
      "httpConfig" = mkOption {
        description = "HTTP client configuration.";
        type = (types.nullOr ReceiverMsteamsv2ConfigHttpConfigModule);
        default = null;
      };
      "sendResolved" = mkOption {
        description = "Whether to notify about resolved alerts.";
        type = types.bool;
        default = false;
      };
      "text" = mkOption {
        description = "Message body template.";
        type = (types.nullOr types.str);
        default = null;
      };
      "title" = mkOption {
        description = "Message title template.";
        type = (types.nullOr types.str);
        default = null;
      };
      "webhookURL" = mkOption {
        description = "MSTeams incoming webhook URL.";
        type = (types.nullOr ReceiverMsteamsv2ConfigWebhookURLModule);
        default = null;
      };
    };
  };
  mkReceiverMsteamsv2Config =
    res:
    {
    }
    // optionalAttrs (res."httpConfig" != null) {
      "httpConfig" = mkReceiverMsteamsv2ConfigHttpConfig res."httpConfig";
    }
    // {
    }
    // optionalAttrs res."sendResolved" { inherit (res) "sendResolved"; }
    // {
    }
    // optionalAttrs (res."text" != null) { inherit (res) "text"; }
    // {
    }
    // optionalAttrs (res."title" != null) { inherit (res) "title"; }
    // {
    }
    // optionalAttrs (res."webhookURL" != null) {
      "webhookURL" = mkReceiverMsteamsv2ConfigWebhookURL res."webhookURL";
    }
    // {
    };
  ReceiverMsteamsv2ConfigWebhookURLModule = types.submodule {
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
  mkReceiverMsteamsv2ConfigWebhookURL =
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
  ReceiverOpsgenieConfigApiKeyModule = types.submodule {
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
  mkReceiverOpsgenieConfigApiKey =
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
  ReceiverOpsgenieConfigDetailModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "Key of the tuple.";
        type = types.str;
      };
      "value" = mkOption {
        description = "Value of the tuple.";
        type = types.str;
      };
    };
  };
  mkReceiverOpsgenieConfigDetail = res: {
    inherit (res) "key";
    inherit (res) "value";
  };
  ReceiverOpsgenieConfigHttpConfigAuthorizationCredentialsModule = types.submodule {
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
  mkReceiverOpsgenieConfigHttpConfigAuthorizationCredentials =
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
  ReceiverOpsgenieConfigHttpConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverOpsgenieConfigHttpConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkReceiverOpsgenieConfigHttpConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ReceiverOpsgenieConfigHttpConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkReceiverOpsgenieConfigHttpConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkReceiverOpsgenieConfigHttpConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkReceiverOpsgenieConfigHttpConfigBasicAuthUsername res."username";
    }
    // {
    };
  ReceiverOpsgenieConfigHttpConfigBasicAuthPasswordModule = types.submodule {
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
  mkReceiverOpsgenieConfigHttpConfigBasicAuthPassword =
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
  ReceiverOpsgenieConfigHttpConfigBasicAuthUsernameModule = types.submodule {
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
  mkReceiverOpsgenieConfigHttpConfigBasicAuthUsername =
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
  ReceiverOpsgenieConfigHttpConfigBearerTokenSecretModule = types.submodule {
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
  mkReceiverOpsgenieConfigHttpConfigBearerTokenSecret =
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
  ReceiverOpsgenieConfigHttpConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization header configuration for the client.\nThis is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+.";
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "BasicAuth for the client.\nThis is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence.";
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigBasicAuthModule);
        default = null;
      };
      "bearerTokenSecret" = mkOption {
        description = "The secret's key that contains the bearer token to be used by the client\nfor authentication.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.";
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigBearerTokenSecretModule);
        default = null;
      };
      "followRedirects" = mkOption {
        description = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "OAuth2 client credentials used to fetch a token for the targets.";
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigOauth2Module);
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
      "proxyURL" = mkOption {
        description = "Optional proxy URL.\n\nIf defined, this field takes precedence over `proxyUrl`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "proxyUrl" = mkOption {
        description = "`proxyURL` defines the HTTP proxy server to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration for the client.";
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkReceiverOpsgenieConfigHttpConfig =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkReceiverOpsgenieConfigHttpConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkReceiverOpsgenieConfigHttpConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs (res."bearerTokenSecret" != null) {
      "bearerTokenSecret" = mkReceiverOpsgenieConfigHttpConfigBearerTokenSecret res."bearerTokenSecret";
    }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) {
      "oauth2" = mkReceiverOpsgenieConfigHttpConfigOauth2 res."oauth2";
    }
    // {
    }
    // optionalAttrs (res."proxyConnectHeader" != { }) { inherit (res) "proxyConnectHeader"; }
    // {
    }
    // optionalAttrs res."proxyFromEnvironment" { inherit (res) "proxyFromEnvironment"; }
    // {
    }
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."proxyUrl" != null) { inherit (res) "proxyUrl"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkReceiverOpsgenieConfigHttpConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  ReceiverOpsgenieConfigHttpConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkReceiverOpsgenieConfigHttpConfigOauth2ClientIdConfigMap =
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
  ReceiverOpsgenieConfigHttpConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkReceiverOpsgenieConfigHttpConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverOpsgenieConfigHttpConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverOpsgenieConfigHttpConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  ReceiverOpsgenieConfigHttpConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkReceiverOpsgenieConfigHttpConfigOauth2ClientIdSecret =
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
  ReceiverOpsgenieConfigHttpConfigOauth2ClientSecretModule = types.submodule {
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
  mkReceiverOpsgenieConfigHttpConfigOauth2ClientSecret =
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
  ReceiverOpsgenieConfigHttpConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = ReceiverOpsgenieConfigHttpConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = ReceiverOpsgenieConfigHttpConfigOauth2ClientSecretModule;
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
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkReceiverOpsgenieConfigHttpConfigOauth2 =
    res:
    {
      "clientId" = mkReceiverOpsgenieConfigHttpConfigOauth2ClientId res."clientId";
      "clientSecret" = mkReceiverOpsgenieConfigHttpConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkReceiverOpsgenieConfigHttpConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  ReceiverOpsgenieConfigHttpConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverOpsgenieConfigHttpConfigOauth2TlsConfigCaConfigMap =
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
  ReceiverOpsgenieConfigHttpConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverOpsgenieConfigHttpConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverOpsgenieConfigHttpConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverOpsgenieConfigHttpConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverOpsgenieConfigHttpConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkReceiverOpsgenieConfigHttpConfigOauth2TlsConfigCaSecret =
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
  ReceiverOpsgenieConfigHttpConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverOpsgenieConfigHttpConfigOauth2TlsConfigCertConfigMap =
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
  ReceiverOpsgenieConfigHttpConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverOpsgenieConfigHttpConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverOpsgenieConfigHttpConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverOpsgenieConfigHttpConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverOpsgenieConfigHttpConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkReceiverOpsgenieConfigHttpConfigOauth2TlsConfigCertSecret =
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
  ReceiverOpsgenieConfigHttpConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkReceiverOpsgenieConfigHttpConfigOauth2TlsConfigKeySecret =
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
  ReceiverOpsgenieConfigHttpConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigOauth2TlsConfigKeySecretModule);
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
  mkReceiverOpsgenieConfigHttpConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverOpsgenieConfigHttpConfigOauth2TlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverOpsgenieConfigHttpConfigOauth2TlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverOpsgenieConfigHttpConfigOauth2TlsConfigKeySecret res."keySecret";
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
  ReceiverOpsgenieConfigHttpConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverOpsgenieConfigHttpConfigTlsConfigCaConfigMap =
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
  ReceiverOpsgenieConfigHttpConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverOpsgenieConfigHttpConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverOpsgenieConfigHttpConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverOpsgenieConfigHttpConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverOpsgenieConfigHttpConfigTlsConfigCaSecretModule = types.submodule {
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
  mkReceiverOpsgenieConfigHttpConfigTlsConfigCaSecret =
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
  ReceiverOpsgenieConfigHttpConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverOpsgenieConfigHttpConfigTlsConfigCertConfigMap =
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
  ReceiverOpsgenieConfigHttpConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverOpsgenieConfigHttpConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverOpsgenieConfigHttpConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverOpsgenieConfigHttpConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverOpsgenieConfigHttpConfigTlsConfigCertSecretModule = types.submodule {
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
  mkReceiverOpsgenieConfigHttpConfigTlsConfigCertSecret =
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
  ReceiverOpsgenieConfigHttpConfigTlsConfigKeySecretModule = types.submodule {
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
  mkReceiverOpsgenieConfigHttpConfigTlsConfigKeySecret =
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
  ReceiverOpsgenieConfigHttpConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigTlsConfigKeySecretModule);
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
  mkReceiverOpsgenieConfigHttpConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverOpsgenieConfigHttpConfigTlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverOpsgenieConfigHttpConfigTlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverOpsgenieConfigHttpConfigTlsConfigKeySecret res."keySecret";
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
  ReceiverOpsgenieConfigModule = types.submodule {
    options = {
      "actions" = mkOption {
        description = "Comma separated list of actions that will be available for the alert.";
        type = (types.nullOr types.str);
        default = null;
      };
      "apiKey" = mkOption {
        description = "The secret's key that contains the OpsGenie API key.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.";
        type = (types.nullOr ReceiverOpsgenieConfigApiKeyModule);
        default = null;
      };
      "apiURL" = mkOption {
        description = "The URL to send OpsGenie API requests to.";
        type = (types.nullOr types.str);
        default = null;
      };
      "description" = mkOption {
        description = "Description of the incident.";
        type = (types.nullOr types.str);
        default = null;
      };
      "details" = mkOption {
        description = "A set of arbitrary key/value pairs that provide further detail about the incident.";
        type = (types.listOf ReceiverOpsgenieConfigDetailModule);
        default = [ ];
      };
      "entity" = mkOption {
        description = "Optional field that can be used to specify which domain alert is related to.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpConfig" = mkOption {
        description = "HTTP client configuration.";
        type = (types.nullOr ReceiverOpsgenieConfigHttpConfigModule);
        default = null;
      };
      "message" = mkOption {
        description = "Alert text limited to 130 characters.";
        type = (types.nullOr types.str);
        default = null;
      };
      "note" = mkOption {
        description = "Additional alert note.";
        type = (types.nullOr types.str);
        default = null;
      };
      "priority" = mkOption {
        description = "Priority level of alert. Possible values are P1, P2, P3, P4, and P5.";
        type = (types.nullOr types.str);
        default = null;
      };
      "responders" = mkOption {
        description = "List of responders responsible for notifications.";
        type = (types.listOf ReceiverOpsgenieConfigResponderModule);
        default = [ ];
      };
      "sendResolved" = mkOption {
        description = "Whether or not to notify about resolved alerts.";
        type = types.bool;
        default = false;
      };
      "source" = mkOption {
        description = "Backlink to the sender of the notification.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tags" = mkOption {
        description = "Comma separated list of tags attached to the notifications.";
        type = (types.nullOr types.str);
        default = null;
      };
      "updateAlerts" = mkOption {
        description = "Whether to update message and description of the alert in OpsGenie if it already exists\nBy default, the alert is never updated in OpsGenie, the new message only appears in activity log.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkReceiverOpsgenieConfig =
    res:
    {
    }
    // optionalAttrs (res."actions" != null) { inherit (res) "actions"; }
    // {
    }
    // optionalAttrs (res."apiKey" != null) { "apiKey" = mkReceiverOpsgenieConfigApiKey res."apiKey"; }
    // {
    }
    // optionalAttrs (res."apiURL" != null) { inherit (res) "apiURL"; }
    // {
    }
    // optionalAttrs (res."description" != null) { inherit (res) "description"; }
    // {
    }
    // optionalAttrs (res."details" != [ ]) {
      "details" = map mkReceiverOpsgenieConfigDetail res."details";
    }
    // {
    }
    // optionalAttrs (res."entity" != null) { inherit (res) "entity"; }
    // {
    }
    // optionalAttrs (res."httpConfig" != null) {
      "httpConfig" = mkReceiverOpsgenieConfigHttpConfig res."httpConfig";
    }
    // {
    }
    // optionalAttrs (res."message" != null) { inherit (res) "message"; }
    // {
    }
    // optionalAttrs (res."note" != null) { inherit (res) "note"; }
    // {
    }
    // optionalAttrs (res."priority" != null) { inherit (res) "priority"; }
    // {
    }
    // optionalAttrs (res."responders" != [ ]) {
      "responders" = map mkReceiverOpsgenieConfigResponder res."responders";
    }
    // {
    }
    // optionalAttrs res."sendResolved" { inherit (res) "sendResolved"; }
    // {
    }
    // optionalAttrs (res."source" != null) { inherit (res) "source"; }
    // {
    }
    // optionalAttrs (res."tags" != null) { inherit (res) "tags"; }
    // {
    }
    // optionalAttrs res."updateAlerts" { inherit (res) "updateAlerts"; }
    // {
    };
  ReceiverOpsgenieConfigResponderModule = types.submodule {
    options = {
      "id" = mkOption {
        description = "ID of the responder.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the responder.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Type of responder.";
        type = types.str;
      };
      "username" = mkOption {
        description = "Username of the responder.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverOpsgenieConfigResponder =
    res:
    {
    }
    // optionalAttrs (res."id" != null) { inherit (res) "id"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
      inherit (res) "type";
    }
    // optionalAttrs (res."username" != null) { inherit (res) "username"; }
    // {
    };
  ReceiverPagerdutyConfigDetailModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "Key of the tuple.";
        type = types.str;
      };
      "value" = mkOption {
        description = "Value of the tuple.";
        type = types.str;
      };
    };
  };
  mkReceiverPagerdutyConfigDetail = res: {
    inherit (res) "key";
    inherit (res) "value";
  };
  ReceiverPagerdutyConfigHttpConfigAuthorizationCredentialsModule = types.submodule {
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
  mkReceiverPagerdutyConfigHttpConfigAuthorizationCredentials =
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
  ReceiverPagerdutyConfigHttpConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverPagerdutyConfigHttpConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkReceiverPagerdutyConfigHttpConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ReceiverPagerdutyConfigHttpConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkReceiverPagerdutyConfigHttpConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkReceiverPagerdutyConfigHttpConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkReceiverPagerdutyConfigHttpConfigBasicAuthUsername res."username";
    }
    // {
    };
  ReceiverPagerdutyConfigHttpConfigBasicAuthPasswordModule = types.submodule {
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
  mkReceiverPagerdutyConfigHttpConfigBasicAuthPassword =
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
  ReceiverPagerdutyConfigHttpConfigBasicAuthUsernameModule = types.submodule {
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
  mkReceiverPagerdutyConfigHttpConfigBasicAuthUsername =
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
  ReceiverPagerdutyConfigHttpConfigBearerTokenSecretModule = types.submodule {
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
  mkReceiverPagerdutyConfigHttpConfigBearerTokenSecret =
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
  ReceiverPagerdutyConfigHttpConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization header configuration for the client.\nThis is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+.";
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "BasicAuth for the client.\nThis is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence.";
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigBasicAuthModule);
        default = null;
      };
      "bearerTokenSecret" = mkOption {
        description = "The secret's key that contains the bearer token to be used by the client\nfor authentication.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.";
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigBearerTokenSecretModule);
        default = null;
      };
      "followRedirects" = mkOption {
        description = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "OAuth2 client credentials used to fetch a token for the targets.";
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigOauth2Module);
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
      "proxyURL" = mkOption {
        description = "Optional proxy URL.\n\nIf defined, this field takes precedence over `proxyUrl`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "proxyUrl" = mkOption {
        description = "`proxyURL` defines the HTTP proxy server to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration for the client.";
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkReceiverPagerdutyConfigHttpConfig =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkReceiverPagerdutyConfigHttpConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkReceiverPagerdutyConfigHttpConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs (res."bearerTokenSecret" != null) {
      "bearerTokenSecret" = mkReceiverPagerdutyConfigHttpConfigBearerTokenSecret res."bearerTokenSecret";
    }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) {
      "oauth2" = mkReceiverPagerdutyConfigHttpConfigOauth2 res."oauth2";
    }
    // {
    }
    // optionalAttrs (res."proxyConnectHeader" != { }) { inherit (res) "proxyConnectHeader"; }
    // {
    }
    // optionalAttrs res."proxyFromEnvironment" { inherit (res) "proxyFromEnvironment"; }
    // {
    }
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."proxyUrl" != null) { inherit (res) "proxyUrl"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkReceiverPagerdutyConfigHttpConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  ReceiverPagerdutyConfigHttpConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkReceiverPagerdutyConfigHttpConfigOauth2ClientIdConfigMap =
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
  ReceiverPagerdutyConfigHttpConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkReceiverPagerdutyConfigHttpConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverPagerdutyConfigHttpConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverPagerdutyConfigHttpConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  ReceiverPagerdutyConfigHttpConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkReceiverPagerdutyConfigHttpConfigOauth2ClientIdSecret =
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
  ReceiverPagerdutyConfigHttpConfigOauth2ClientSecretModule = types.submodule {
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
  mkReceiverPagerdutyConfigHttpConfigOauth2ClientSecret =
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
  ReceiverPagerdutyConfigHttpConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = ReceiverPagerdutyConfigHttpConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = ReceiverPagerdutyConfigHttpConfigOauth2ClientSecretModule;
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
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkReceiverPagerdutyConfigHttpConfigOauth2 =
    res:
    {
      "clientId" = mkReceiverPagerdutyConfigHttpConfigOauth2ClientId res."clientId";
      "clientSecret" = mkReceiverPagerdutyConfigHttpConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkReceiverPagerdutyConfigHttpConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  ReceiverPagerdutyConfigHttpConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverPagerdutyConfigHttpConfigOauth2TlsConfigCaConfigMap =
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
  ReceiverPagerdutyConfigHttpConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverPagerdutyConfigHttpConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverPagerdutyConfigHttpConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverPagerdutyConfigHttpConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverPagerdutyConfigHttpConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkReceiverPagerdutyConfigHttpConfigOauth2TlsConfigCaSecret =
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
  ReceiverPagerdutyConfigHttpConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverPagerdutyConfigHttpConfigOauth2TlsConfigCertConfigMap =
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
  ReceiverPagerdutyConfigHttpConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverPagerdutyConfigHttpConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverPagerdutyConfigHttpConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverPagerdutyConfigHttpConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverPagerdutyConfigHttpConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkReceiverPagerdutyConfigHttpConfigOauth2TlsConfigCertSecret =
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
  ReceiverPagerdutyConfigHttpConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkReceiverPagerdutyConfigHttpConfigOauth2TlsConfigKeySecret =
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
  ReceiverPagerdutyConfigHttpConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigOauth2TlsConfigKeySecretModule);
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
  mkReceiverPagerdutyConfigHttpConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverPagerdutyConfigHttpConfigOauth2TlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverPagerdutyConfigHttpConfigOauth2TlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverPagerdutyConfigHttpConfigOauth2TlsConfigKeySecret res."keySecret";
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
  ReceiverPagerdutyConfigHttpConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverPagerdutyConfigHttpConfigTlsConfigCaConfigMap =
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
  ReceiverPagerdutyConfigHttpConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverPagerdutyConfigHttpConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverPagerdutyConfigHttpConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverPagerdutyConfigHttpConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverPagerdutyConfigHttpConfigTlsConfigCaSecretModule = types.submodule {
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
  mkReceiverPagerdutyConfigHttpConfigTlsConfigCaSecret =
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
  ReceiverPagerdutyConfigHttpConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverPagerdutyConfigHttpConfigTlsConfigCertConfigMap =
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
  ReceiverPagerdutyConfigHttpConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverPagerdutyConfigHttpConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverPagerdutyConfigHttpConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverPagerdutyConfigHttpConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverPagerdutyConfigHttpConfigTlsConfigCertSecretModule = types.submodule {
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
  mkReceiverPagerdutyConfigHttpConfigTlsConfigCertSecret =
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
  ReceiverPagerdutyConfigHttpConfigTlsConfigKeySecretModule = types.submodule {
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
  mkReceiverPagerdutyConfigHttpConfigTlsConfigKeySecret =
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
  ReceiverPagerdutyConfigHttpConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigTlsConfigKeySecretModule);
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
  mkReceiverPagerdutyConfigHttpConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverPagerdutyConfigHttpConfigTlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverPagerdutyConfigHttpConfigTlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverPagerdutyConfigHttpConfigTlsConfigKeySecret res."keySecret";
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
  ReceiverPagerdutyConfigModule = types.submodule {
    options = {
      "class" = mkOption {
        description = "The class/type of the event.";
        type = (types.nullOr types.str);
        default = null;
      };
      "client" = mkOption {
        description = "Client identification.";
        type = (types.nullOr types.str);
        default = null;
      };
      "clientURL" = mkOption {
        description = "Backlink to the sender of notification.";
        type = (types.nullOr types.str);
        default = null;
      };
      "component" = mkOption {
        description = "The part or component of the affected system that is broken.";
        type = (types.nullOr types.str);
        default = null;
      };
      "description" = mkOption {
        description = "Description of the incident.";
        type = (types.nullOr types.str);
        default = null;
      };
      "details" = mkOption {
        description = "Arbitrary key/value pairs that provide further detail about the incident.";
        type = (types.listOf ReceiverPagerdutyConfigDetailModule);
        default = [ ];
      };
      "group" = mkOption {
        description = "A cluster or grouping of sources.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpConfig" = mkOption {
        description = "HTTP client configuration.";
        type = (types.nullOr ReceiverPagerdutyConfigHttpConfigModule);
        default = null;
      };
      "pagerDutyImageConfigs" = mkOption {
        description = "A list of image details to attach that provide further detail about an incident.";
        type = (types.listOf ReceiverPagerdutyConfigPagerDutyImageConfigModule);
        default = [ ];
      };
      "pagerDutyLinkConfigs" = mkOption {
        description = "A list of link details to attach that provide further detail about an incident.";
        type = (types.listOf ReceiverPagerdutyConfigPagerDutyLinkConfigModule);
        default = [ ];
      };
      "routingKey" = mkOption {
        description = "The secret's key that contains the PagerDuty integration key (when using\nEvents API v2). Either this field or `serviceKey` needs to be defined.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.";
        type = (types.nullOr ReceiverPagerdutyConfigRoutingKeyModule);
        default = null;
      };
      "sendResolved" = mkOption {
        description = "Whether or not to notify about resolved alerts.";
        type = types.bool;
        default = false;
      };
      "serviceKey" = mkOption {
        description = "The secret's key that contains the PagerDuty service key (when using\nintegration type \"Prometheus\"). Either this field or `routingKey` needs to\nbe defined.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.";
        type = (types.nullOr ReceiverPagerdutyConfigServiceKeyModule);
        default = null;
      };
      "severity" = mkOption {
        description = "Severity of the incident.";
        type = (types.nullOr types.str);
        default = null;
      };
      "source" = mkOption {
        description = "Unique location of the affected system.";
        type = (types.nullOr types.str);
        default = null;
      };
      "url" = mkOption {
        description = "The URL to send requests to.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverPagerdutyConfig =
    res:
    {
    }
    // optionalAttrs (res."class" != null) { inherit (res) "class"; }
    // {
    }
    // optionalAttrs (res."client" != null) { inherit (res) "client"; }
    // {
    }
    // optionalAttrs (res."clientURL" != null) { inherit (res) "clientURL"; }
    // {
    }
    // optionalAttrs (res."component" != null) { inherit (res) "component"; }
    // {
    }
    // optionalAttrs (res."description" != null) { inherit (res) "description"; }
    // {
    }
    // optionalAttrs (res."details" != [ ]) {
      "details" = map mkReceiverPagerdutyConfigDetail res."details";
    }
    // {
    }
    // optionalAttrs (res."group" != null) { inherit (res) "group"; }
    // {
    }
    // optionalAttrs (res."httpConfig" != null) {
      "httpConfig" = mkReceiverPagerdutyConfigHttpConfig res."httpConfig";
    }
    // {
    }
    // optionalAttrs (res."pagerDutyImageConfigs" != [ ]) {
      "pagerDutyImageConfigs" =
        map mkReceiverPagerdutyConfigPagerDutyImageConfig
          res."pagerDutyImageConfigs";
    }
    // {
    }
    // optionalAttrs (res."pagerDutyLinkConfigs" != [ ]) {
      "pagerDutyLinkConfigs" =
        map mkReceiverPagerdutyConfigPagerDutyLinkConfig
          res."pagerDutyLinkConfigs";
    }
    // {
    }
    // optionalAttrs (res."routingKey" != null) {
      "routingKey" = mkReceiverPagerdutyConfigRoutingKey res."routingKey";
    }
    // {
    }
    // optionalAttrs res."sendResolved" { inherit (res) "sendResolved"; }
    // {
    }
    // optionalAttrs (res."serviceKey" != null) {
      "serviceKey" = mkReceiverPagerdutyConfigServiceKey res."serviceKey";
    }
    // {
    }
    // optionalAttrs (res."severity" != null) { inherit (res) "severity"; }
    // {
    }
    // optionalAttrs (res."source" != null) { inherit (res) "source"; }
    // {
    }
    // optionalAttrs (res."url" != null) { inherit (res) "url"; }
    // {
    };
  ReceiverPagerdutyConfigPagerDutyImageConfigModule = types.submodule {
    options = {
      "alt" = mkOption {
        description = "Alt is the optional alternative text for the image.";
        type = (types.nullOr types.str);
        default = null;
      };
      "href" = mkOption {
        description = "Optional URL; makes the image a clickable link.";
        type = (types.nullOr types.str);
        default = null;
      };
      "src" = mkOption {
        description = "Src of the image being attached to the incident";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverPagerdutyConfigPagerDutyImageConfig =
    res:
    {
    }
    // optionalAttrs (res."alt" != null) { inherit (res) "alt"; }
    // {
    }
    // optionalAttrs (res."href" != null) { inherit (res) "href"; }
    // {
    }
    // optionalAttrs (res."src" != null) { inherit (res) "src"; }
    // {
    };
  ReceiverPagerdutyConfigPagerDutyLinkConfigModule = types.submodule {
    options = {
      "alt" = mkOption {
        description = "Text that describes the purpose of the link, and can be used as the link's text.";
        type = (types.nullOr types.str);
        default = null;
      };
      "href" = mkOption {
        description = "Href is the URL of the link to be attached";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverPagerdutyConfigPagerDutyLinkConfig =
    res:
    {
    }
    // optionalAttrs (res."alt" != null) { inherit (res) "alt"; }
    // {
    }
    // optionalAttrs (res."href" != null) { inherit (res) "href"; }
    // {
    };
  ReceiverPagerdutyConfigRoutingKeyModule = types.submodule {
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
  mkReceiverPagerdutyConfigRoutingKey =
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
  ReceiverPagerdutyConfigServiceKeyModule = types.submodule {
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
  mkReceiverPagerdutyConfigServiceKey =
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
  ReceiverPushoverConfigHttpConfigAuthorizationCredentialsModule = types.submodule {
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
  mkReceiverPushoverConfigHttpConfigAuthorizationCredentials =
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
  ReceiverPushoverConfigHttpConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr ReceiverPushoverConfigHttpConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverPushoverConfigHttpConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkReceiverPushoverConfigHttpConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ReceiverPushoverConfigHttpConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr ReceiverPushoverConfigHttpConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr ReceiverPushoverConfigHttpConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkReceiverPushoverConfigHttpConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkReceiverPushoverConfigHttpConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkReceiverPushoverConfigHttpConfigBasicAuthUsername res."username";
    }
    // {
    };
  ReceiverPushoverConfigHttpConfigBasicAuthPasswordModule = types.submodule {
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
  mkReceiverPushoverConfigHttpConfigBasicAuthPassword =
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
  ReceiverPushoverConfigHttpConfigBasicAuthUsernameModule = types.submodule {
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
  mkReceiverPushoverConfigHttpConfigBasicAuthUsername =
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
  ReceiverPushoverConfigHttpConfigBearerTokenSecretModule = types.submodule {
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
  mkReceiverPushoverConfigHttpConfigBearerTokenSecret =
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
  ReceiverPushoverConfigHttpConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization header configuration for the client.\nThis is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+.";
        type = (types.nullOr ReceiverPushoverConfigHttpConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "BasicAuth for the client.\nThis is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence.";
        type = (types.nullOr ReceiverPushoverConfigHttpConfigBasicAuthModule);
        default = null;
      };
      "bearerTokenSecret" = mkOption {
        description = "The secret's key that contains the bearer token to be used by the client\nfor authentication.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.";
        type = (types.nullOr ReceiverPushoverConfigHttpConfigBearerTokenSecretModule);
        default = null;
      };
      "followRedirects" = mkOption {
        description = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "OAuth2 client credentials used to fetch a token for the targets.";
        type = (types.nullOr ReceiverPushoverConfigHttpConfigOauth2Module);
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
      "proxyURL" = mkOption {
        description = "Optional proxy URL.\n\nIf defined, this field takes precedence over `proxyUrl`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "proxyUrl" = mkOption {
        description = "`proxyURL` defines the HTTP proxy server to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration for the client.";
        type = (types.nullOr ReceiverPushoverConfigHttpConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkReceiverPushoverConfigHttpConfig =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkReceiverPushoverConfigHttpConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkReceiverPushoverConfigHttpConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs (res."bearerTokenSecret" != null) {
      "bearerTokenSecret" = mkReceiverPushoverConfigHttpConfigBearerTokenSecret res."bearerTokenSecret";
    }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) {
      "oauth2" = mkReceiverPushoverConfigHttpConfigOauth2 res."oauth2";
    }
    // {
    }
    // optionalAttrs (res."proxyConnectHeader" != { }) { inherit (res) "proxyConnectHeader"; }
    // {
    }
    // optionalAttrs res."proxyFromEnvironment" { inherit (res) "proxyFromEnvironment"; }
    // {
    }
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."proxyUrl" != null) { inherit (res) "proxyUrl"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkReceiverPushoverConfigHttpConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  ReceiverPushoverConfigHttpConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkReceiverPushoverConfigHttpConfigOauth2ClientIdConfigMap =
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
  ReceiverPushoverConfigHttpConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverPushoverConfigHttpConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverPushoverConfigHttpConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkReceiverPushoverConfigHttpConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverPushoverConfigHttpConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverPushoverConfigHttpConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  ReceiverPushoverConfigHttpConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkReceiverPushoverConfigHttpConfigOauth2ClientIdSecret =
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
  ReceiverPushoverConfigHttpConfigOauth2ClientSecretModule = types.submodule {
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
  mkReceiverPushoverConfigHttpConfigOauth2ClientSecret =
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
  ReceiverPushoverConfigHttpConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = ReceiverPushoverConfigHttpConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = ReceiverPushoverConfigHttpConfigOauth2ClientSecretModule;
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
        type = (types.nullOr ReceiverPushoverConfigHttpConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkReceiverPushoverConfigHttpConfigOauth2 =
    res:
    {
      "clientId" = mkReceiverPushoverConfigHttpConfigOauth2ClientId res."clientId";
      "clientSecret" = mkReceiverPushoverConfigHttpConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkReceiverPushoverConfigHttpConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  ReceiverPushoverConfigHttpConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverPushoverConfigHttpConfigOauth2TlsConfigCaConfigMap =
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
  ReceiverPushoverConfigHttpConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverPushoverConfigHttpConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverPushoverConfigHttpConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverPushoverConfigHttpConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverPushoverConfigHttpConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverPushoverConfigHttpConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverPushoverConfigHttpConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkReceiverPushoverConfigHttpConfigOauth2TlsConfigCaSecret =
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
  ReceiverPushoverConfigHttpConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverPushoverConfigHttpConfigOauth2TlsConfigCertConfigMap =
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
  ReceiverPushoverConfigHttpConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverPushoverConfigHttpConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverPushoverConfigHttpConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverPushoverConfigHttpConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverPushoverConfigHttpConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverPushoverConfigHttpConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverPushoverConfigHttpConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkReceiverPushoverConfigHttpConfigOauth2TlsConfigCertSecret =
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
  ReceiverPushoverConfigHttpConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkReceiverPushoverConfigHttpConfigOauth2TlsConfigKeySecret =
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
  ReceiverPushoverConfigHttpConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverPushoverConfigHttpConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverPushoverConfigHttpConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverPushoverConfigHttpConfigOauth2TlsConfigKeySecretModule);
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
  mkReceiverPushoverConfigHttpConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverPushoverConfigHttpConfigOauth2TlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverPushoverConfigHttpConfigOauth2TlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverPushoverConfigHttpConfigOauth2TlsConfigKeySecret res."keySecret";
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
  ReceiverPushoverConfigHttpConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverPushoverConfigHttpConfigTlsConfigCaConfigMap =
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
  ReceiverPushoverConfigHttpConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverPushoverConfigHttpConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverPushoverConfigHttpConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverPushoverConfigHttpConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverPushoverConfigHttpConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverPushoverConfigHttpConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverPushoverConfigHttpConfigTlsConfigCaSecretModule = types.submodule {
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
  mkReceiverPushoverConfigHttpConfigTlsConfigCaSecret =
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
  ReceiverPushoverConfigHttpConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverPushoverConfigHttpConfigTlsConfigCertConfigMap =
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
  ReceiverPushoverConfigHttpConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverPushoverConfigHttpConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverPushoverConfigHttpConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverPushoverConfigHttpConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverPushoverConfigHttpConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverPushoverConfigHttpConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverPushoverConfigHttpConfigTlsConfigCertSecretModule = types.submodule {
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
  mkReceiverPushoverConfigHttpConfigTlsConfigCertSecret =
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
  ReceiverPushoverConfigHttpConfigTlsConfigKeySecretModule = types.submodule {
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
  mkReceiverPushoverConfigHttpConfigTlsConfigKeySecret =
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
  ReceiverPushoverConfigHttpConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverPushoverConfigHttpConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverPushoverConfigHttpConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverPushoverConfigHttpConfigTlsConfigKeySecretModule);
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
  mkReceiverPushoverConfigHttpConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverPushoverConfigHttpConfigTlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverPushoverConfigHttpConfigTlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverPushoverConfigHttpConfigTlsConfigKeySecret res."keySecret";
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
  ReceiverPushoverConfigModule = types.submodule {
    options = {
      "device" = mkOption {
        description = "The name of a device to send the notification to";
        type = (types.nullOr types.str);
        default = null;
      };
      "expire" = mkOption {
        description = "How long your notification will continue to be retried for, unless the user\nacknowledges the notification.";
        type = (types.nullOr types.str);
        default = null;
      };
      "html" = mkOption {
        description = "Whether notification message is HTML or plain text.";
        type = types.bool;
        default = false;
      };
      "httpConfig" = mkOption {
        description = "HTTP client configuration.";
        type = (types.nullOr ReceiverPushoverConfigHttpConfigModule);
        default = null;
      };
      "message" = mkOption {
        description = "Notification message.";
        type = (types.nullOr types.str);
        default = null;
      };
      "priority" = mkOption {
        description = "Priority, see https://pushover.net/api#priority";
        type = (types.nullOr types.str);
        default = null;
      };
      "retry" = mkOption {
        description = "How often the Pushover servers will send the same notification to the user.\nMust be at least 30 seconds.";
        type = (types.nullOr types.str);
        default = null;
      };
      "sendResolved" = mkOption {
        description = "Whether or not to notify about resolved alerts.";
        type = types.bool;
        default = false;
      };
      "sound" = mkOption {
        description = "The name of one of the sounds supported by device clients to override the user's default sound choice";
        type = (types.nullOr types.str);
        default = null;
      };
      "title" = mkOption {
        description = "Notification title.";
        type = (types.nullOr types.str);
        default = null;
      };
      "token" = mkOption {
        description = "The secret's key that contains the registered application's API token, see https://pushover.net/apps.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.\nEither `token` or `tokenFile` is required.";
        type = (types.nullOr ReceiverPushoverConfigTokenModule);
        default = null;
      };
      "tokenFile" = mkOption {
        description = "The token file that contains the registered application's API token, see https://pushover.net/apps.\nEither `token` or `tokenFile` is required.\nIt requires Alertmanager >= v0.26.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "ttl" = mkOption {
        description = "The time to live definition for the alert notification";
        type = (types.nullOr types.str);
        default = null;
      };
      "url" = mkOption {
        description = "A supplementary URL shown alongside the message.";
        type = (types.nullOr types.str);
        default = null;
      };
      "urlTitle" = mkOption {
        description = "A title for supplementary URL, otherwise just the URL is shown";
        type = (types.nullOr types.str);
        default = null;
      };
      "userKey" = mkOption {
        description = "The secret's key that contains the recipient user's user key.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.\nEither `userKey` or `userKeyFile` is required.";
        type = (types.nullOr ReceiverPushoverConfigUserKeyModule);
        default = null;
      };
      "userKeyFile" = mkOption {
        description = "The user key file that contains the recipient user's user key.\nEither `userKey` or `userKeyFile` is required.\nIt requires Alertmanager >= v0.26.0.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverPushoverConfig =
    res:
    {
    }
    // optionalAttrs (res."device" != null) { inherit (res) "device"; }
    // {
    }
    // optionalAttrs (res."expire" != null) { inherit (res) "expire"; }
    // {
    }
    // optionalAttrs res."html" { inherit (res) "html"; }
    // {
    }
    // optionalAttrs (res."httpConfig" != null) {
      "httpConfig" = mkReceiverPushoverConfigHttpConfig res."httpConfig";
    }
    // {
    }
    // optionalAttrs (res."message" != null) { inherit (res) "message"; }
    // {
    }
    // optionalAttrs (res."priority" != null) { inherit (res) "priority"; }
    // {
    }
    // optionalAttrs (res."retry" != null) { inherit (res) "retry"; }
    // {
    }
    // optionalAttrs res."sendResolved" { inherit (res) "sendResolved"; }
    // {
    }
    // optionalAttrs (res."sound" != null) { inherit (res) "sound"; }
    // {
    }
    // optionalAttrs (res."title" != null) { inherit (res) "title"; }
    // {
    }
    // optionalAttrs (res."token" != null) { "token" = mkReceiverPushoverConfigToken res."token"; }
    // {
    }
    // optionalAttrs (res."tokenFile" != null) { inherit (res) "tokenFile"; }
    // {
    }
    // optionalAttrs (res."ttl" != null) { inherit (res) "ttl"; }
    // {
    }
    // optionalAttrs (res."url" != null) { inherit (res) "url"; }
    // {
    }
    // optionalAttrs (res."urlTitle" != null) { inherit (res) "urlTitle"; }
    // {
    }
    // optionalAttrs (res."userKey" != null) {
      "userKey" = mkReceiverPushoverConfigUserKey res."userKey";
    }
    // {
    }
    // optionalAttrs (res."userKeyFile" != null) { inherit (res) "userKeyFile"; }
    // {
    };
  ReceiverPushoverConfigTokenModule = types.submodule {
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
  mkReceiverPushoverConfigToken =
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
  ReceiverPushoverConfigUserKeyModule = types.submodule {
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
  mkReceiverPushoverConfigUserKey =
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
  ReceiverRocketchatConfigActionModule = types.submodule {
    options = {
      "msg" = mkOption {
        description = "The message to send when the button is clicked.";
        type = (types.nullOr types.str);
        default = null;
      };
      "text" = mkOption {
        description = "The button text.";
        type = (types.nullOr types.str);
        default = null;
      };
      "url" = mkOption {
        description = "The URL the button links to.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverRocketchatConfigAction =
    res:
    {
    }
    // optionalAttrs (res."msg" != null) { inherit (res) "msg"; }
    // {
    }
    // optionalAttrs (res."text" != null) { inherit (res) "text"; }
    // {
    }
    // optionalAttrs (res."url" != null) { inherit (res) "url"; }
    // {
    };
  ReceiverRocketchatConfigFieldModule = types.submodule {
    options = {
      "short" = mkOption {
        description = "Whether this field should be a short field.";
        type = types.bool;
        default = false;
      };
      "title" = mkOption {
        description = "The title of this field.";
        type = (types.nullOr types.str);
        default = null;
      };
      "value" = mkOption {
        description = "The value of this field, displayed underneath the title value.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverRocketchatConfigField =
    res:
    {
    }
    // optionalAttrs res."short" { inherit (res) "short"; }
    // {
    }
    // optionalAttrs (res."title" != null) { inherit (res) "title"; }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  ReceiverRocketchatConfigHttpConfigAuthorizationCredentialsModule = types.submodule {
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
  mkReceiverRocketchatConfigHttpConfigAuthorizationCredentials =
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
  ReceiverRocketchatConfigHttpConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverRocketchatConfigHttpConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkReceiverRocketchatConfigHttpConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ReceiverRocketchatConfigHttpConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkReceiverRocketchatConfigHttpConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkReceiverRocketchatConfigHttpConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkReceiverRocketchatConfigHttpConfigBasicAuthUsername res."username";
    }
    // {
    };
  ReceiverRocketchatConfigHttpConfigBasicAuthPasswordModule = types.submodule {
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
  mkReceiverRocketchatConfigHttpConfigBasicAuthPassword =
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
  ReceiverRocketchatConfigHttpConfigBasicAuthUsernameModule = types.submodule {
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
  mkReceiverRocketchatConfigHttpConfigBasicAuthUsername =
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
  ReceiverRocketchatConfigHttpConfigBearerTokenSecretModule = types.submodule {
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
  mkReceiverRocketchatConfigHttpConfigBearerTokenSecret =
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
  ReceiverRocketchatConfigHttpConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization header configuration for the client.\nThis is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+.";
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "BasicAuth for the client.\nThis is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence.";
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigBasicAuthModule);
        default = null;
      };
      "bearerTokenSecret" = mkOption {
        description = "The secret's key that contains the bearer token to be used by the client\nfor authentication.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.";
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigBearerTokenSecretModule);
        default = null;
      };
      "followRedirects" = mkOption {
        description = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "OAuth2 client credentials used to fetch a token for the targets.";
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigOauth2Module);
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
      "proxyURL" = mkOption {
        description = "Optional proxy URL.\n\nIf defined, this field takes precedence over `proxyUrl`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "proxyUrl" = mkOption {
        description = "`proxyURL` defines the HTTP proxy server to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration for the client.";
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkReceiverRocketchatConfigHttpConfig =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkReceiverRocketchatConfigHttpConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkReceiverRocketchatConfigHttpConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs (res."bearerTokenSecret" != null) {
      "bearerTokenSecret" = mkReceiverRocketchatConfigHttpConfigBearerTokenSecret res."bearerTokenSecret";
    }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) {
      "oauth2" = mkReceiverRocketchatConfigHttpConfigOauth2 res."oauth2";
    }
    // {
    }
    // optionalAttrs (res."proxyConnectHeader" != { }) { inherit (res) "proxyConnectHeader"; }
    // {
    }
    // optionalAttrs res."proxyFromEnvironment" { inherit (res) "proxyFromEnvironment"; }
    // {
    }
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."proxyUrl" != null) { inherit (res) "proxyUrl"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkReceiverRocketchatConfigHttpConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  ReceiverRocketchatConfigHttpConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkReceiverRocketchatConfigHttpConfigOauth2ClientIdConfigMap =
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
  ReceiverRocketchatConfigHttpConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkReceiverRocketchatConfigHttpConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverRocketchatConfigHttpConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverRocketchatConfigHttpConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  ReceiverRocketchatConfigHttpConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkReceiverRocketchatConfigHttpConfigOauth2ClientIdSecret =
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
  ReceiverRocketchatConfigHttpConfigOauth2ClientSecretModule = types.submodule {
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
  mkReceiverRocketchatConfigHttpConfigOauth2ClientSecret =
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
  ReceiverRocketchatConfigHttpConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = ReceiverRocketchatConfigHttpConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = ReceiverRocketchatConfigHttpConfigOauth2ClientSecretModule;
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
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkReceiverRocketchatConfigHttpConfigOauth2 =
    res:
    {
      "clientId" = mkReceiverRocketchatConfigHttpConfigOauth2ClientId res."clientId";
      "clientSecret" = mkReceiverRocketchatConfigHttpConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkReceiverRocketchatConfigHttpConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  ReceiverRocketchatConfigHttpConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverRocketchatConfigHttpConfigOauth2TlsConfigCaConfigMap =
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
  ReceiverRocketchatConfigHttpConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverRocketchatConfigHttpConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverRocketchatConfigHttpConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverRocketchatConfigHttpConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverRocketchatConfigHttpConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkReceiverRocketchatConfigHttpConfigOauth2TlsConfigCaSecret =
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
  ReceiverRocketchatConfigHttpConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverRocketchatConfigHttpConfigOauth2TlsConfigCertConfigMap =
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
  ReceiverRocketchatConfigHttpConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverRocketchatConfigHttpConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverRocketchatConfigHttpConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverRocketchatConfigHttpConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverRocketchatConfigHttpConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkReceiverRocketchatConfigHttpConfigOauth2TlsConfigCertSecret =
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
  ReceiverRocketchatConfigHttpConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkReceiverRocketchatConfigHttpConfigOauth2TlsConfigKeySecret =
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
  ReceiverRocketchatConfigHttpConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigOauth2TlsConfigKeySecretModule);
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
  mkReceiverRocketchatConfigHttpConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverRocketchatConfigHttpConfigOauth2TlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverRocketchatConfigHttpConfigOauth2TlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverRocketchatConfigHttpConfigOauth2TlsConfigKeySecret res."keySecret";
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
  ReceiverRocketchatConfigHttpConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverRocketchatConfigHttpConfigTlsConfigCaConfigMap =
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
  ReceiverRocketchatConfigHttpConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverRocketchatConfigHttpConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverRocketchatConfigHttpConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverRocketchatConfigHttpConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverRocketchatConfigHttpConfigTlsConfigCaSecretModule = types.submodule {
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
  mkReceiverRocketchatConfigHttpConfigTlsConfigCaSecret =
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
  ReceiverRocketchatConfigHttpConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverRocketchatConfigHttpConfigTlsConfigCertConfigMap =
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
  ReceiverRocketchatConfigHttpConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverRocketchatConfigHttpConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverRocketchatConfigHttpConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverRocketchatConfigHttpConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverRocketchatConfigHttpConfigTlsConfigCertSecretModule = types.submodule {
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
  mkReceiverRocketchatConfigHttpConfigTlsConfigCertSecret =
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
  ReceiverRocketchatConfigHttpConfigTlsConfigKeySecretModule = types.submodule {
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
  mkReceiverRocketchatConfigHttpConfigTlsConfigKeySecret =
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
  ReceiverRocketchatConfigHttpConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigTlsConfigKeySecretModule);
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
  mkReceiverRocketchatConfigHttpConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverRocketchatConfigHttpConfigTlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverRocketchatConfigHttpConfigTlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverRocketchatConfigHttpConfigTlsConfigKeySecret res."keySecret";
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
  ReceiverRocketchatConfigModule = types.submodule {
    options = {
      "actions" = mkOption {
        description = "Actions to include in the message.";
        type = (types.listOf ReceiverRocketchatConfigActionModule);
        default = [ ];
      };
      "apiURL" = mkOption {
        description = "The API URL for RocketChat.\nDefaults to https://open.rocket.chat/ if not specified.";
        type = (types.nullOr types.str);
        default = null;
      };
      "channel" = mkOption {
        description = "The channel to send alerts to.";
        type = (types.nullOr types.str);
        default = null;
      };
      "color" = mkOption {
        description = "The message color.";
        type = (types.nullOr types.str);
        default = null;
      };
      "emoji" = mkOption {
        description = "If provided, the avatar will be displayed as an emoji.";
        type = (types.nullOr types.str);
        default = null;
      };
      "fields" = mkOption {
        description = "Additional fields for the message.";
        type = (types.listOf ReceiverRocketchatConfigFieldModule);
        default = [ ];
      };
      "httpConfig" = mkOption {
        description = "HTTP client configuration.";
        type = (types.nullOr ReceiverRocketchatConfigHttpConfigModule);
        default = null;
      };
      "iconURL" = mkOption {
        description = "Icon URL for the message.";
        type = (types.nullOr types.str);
        default = null;
      };
      "imageURL" = mkOption {
        description = "Image URL for the message.";
        type = (types.nullOr types.str);
        default = null;
      };
      "linkNames" = mkOption {
        description = "Whether to enable link names.";
        type = types.bool;
        default = false;
      };
      "sendResolved" = mkOption {
        description = "Whether to notify about resolved alerts.";
        type = types.bool;
        default = false;
      };
      "shortFields" = mkOption {
        description = "Whether to use short fields.";
        type = types.bool;
        default = false;
      };
      "text" = mkOption {
        description = "The message text to send, it is optional because of attachments.";
        type = (types.nullOr types.str);
        default = null;
      };
      "thumbURL" = mkOption {
        description = "Thumbnail URL for the message.";
        type = (types.nullOr types.str);
        default = null;
      };
      "title" = mkOption {
        description = "The message title.";
        type = (types.nullOr types.str);
        default = null;
      };
      "titleLink" = mkOption {
        description = "The title link for the message.";
        type = (types.nullOr types.str);
        default = null;
      };
      "token" = mkOption {
        description = "The sender token.";
        type = ReceiverRocketchatConfigTokenModule;
      };
      "tokenID" = mkOption {
        description = "The sender token ID.";
        type = ReceiverRocketchatConfigTokenIDModule;
      };
    };
  };
  mkReceiverRocketchatConfig =
    res:
    {
    }
    // optionalAttrs (res."actions" != [ ]) {
      "actions" = map mkReceiverRocketchatConfigAction res."actions";
    }
    // {
    }
    // optionalAttrs (res."apiURL" != null) { inherit (res) "apiURL"; }
    // {
    }
    // optionalAttrs (res."channel" != null) { inherit (res) "channel"; }
    // {
    }
    // optionalAttrs (res."color" != null) { inherit (res) "color"; }
    // {
    }
    // optionalAttrs (res."emoji" != null) { inherit (res) "emoji"; }
    // {
    }
    // optionalAttrs (res."fields" != [ ]) {
      "fields" = map mkReceiverRocketchatConfigField res."fields";
    }
    // {
    }
    // optionalAttrs (res."httpConfig" != null) {
      "httpConfig" = mkReceiverRocketchatConfigHttpConfig res."httpConfig";
    }
    // {
    }
    // optionalAttrs (res."iconURL" != null) { inherit (res) "iconURL"; }
    // {
    }
    // optionalAttrs (res."imageURL" != null) { inherit (res) "imageURL"; }
    // {
    }
    // optionalAttrs res."linkNames" { inherit (res) "linkNames"; }
    // {
    }
    // optionalAttrs res."sendResolved" { inherit (res) "sendResolved"; }
    // {
    }
    // optionalAttrs res."shortFields" { inherit (res) "shortFields"; }
    // {
    }
    // optionalAttrs (res."text" != null) { inherit (res) "text"; }
    // {
    }
    // optionalAttrs (res."thumbURL" != null) { inherit (res) "thumbURL"; }
    // {
    }
    // optionalAttrs (res."title" != null) { inherit (res) "title"; }
    // {
    }
    // optionalAttrs (res."titleLink" != null) { inherit (res) "titleLink"; }
    // {
      "token" = mkReceiverRocketchatConfigToken res."token";
      "tokenID" = mkReceiverRocketchatConfigTokenID res."tokenID";
    };
  ReceiverRocketchatConfigTokenIDModule = types.submodule {
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
  mkReceiverRocketchatConfigTokenID =
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
  ReceiverRocketchatConfigTokenModule = types.submodule {
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
  mkReceiverRocketchatConfigToken =
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
  ReceiverSlackConfigActionConfirmModule = types.submodule {
    options = {
      "dismissText" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "okText" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "text" = mkOption {
        type = types.str;
      };
      "title" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverSlackConfigActionConfirm =
    res:
    {
    }
    // optionalAttrs (res."dismissText" != null) { inherit (res) "dismissText"; }
    // {
    }
    // optionalAttrs (res."okText" != null) { inherit (res) "okText"; }
    // {
      inherit (res) "text";
    }
    // optionalAttrs (res."title" != null) { inherit (res) "title"; }
    // {
    };
  ReceiverSlackConfigActionModule = types.submodule {
    options = {
      "confirm" = mkOption {
        description = "SlackConfirmationField protect users from destructive actions or\nparticularly distinguished decisions by asking them to confirm their button\nclick one more time.\nSee https://api.slack.com/docs/interactive-message-field-guide#confirmation_fields\nfor more information.";
        type = (types.nullOr ReceiverSlackConfigActionConfirmModule);
        default = null;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "style" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "text" = mkOption {
        type = types.str;
      };
      "type" = mkOption {
        type = types.str;
      };
      "url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "value" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverSlackConfigAction =
    res:
    {
    }
    // optionalAttrs (res."confirm" != null) {
      "confirm" = mkReceiverSlackConfigActionConfirm res."confirm";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."style" != null) { inherit (res) "style"; }
    // {
      inherit (res) "text";
      inherit (res) "type";
    }
    // optionalAttrs (res."url" != null) { inherit (res) "url"; }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  ReceiverSlackConfigApiURLModule = types.submodule {
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
  mkReceiverSlackConfigApiURL =
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
  ReceiverSlackConfigFieldModule = types.submodule {
    options = {
      "short" = mkOption {
        type = types.bool;
        default = false;
      };
      "title" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        type = types.str;
      };
    };
  };
  mkReceiverSlackConfigField =
    res:
    {
    }
    // optionalAttrs res."short" { inherit (res) "short"; }
    // {
      inherit (res) "title";
      inherit (res) "value";
    };
  ReceiverSlackConfigHttpConfigAuthorizationCredentialsModule = types.submodule {
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
  mkReceiverSlackConfigHttpConfigAuthorizationCredentials =
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
  ReceiverSlackConfigHttpConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr ReceiverSlackConfigHttpConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverSlackConfigHttpConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkReceiverSlackConfigHttpConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ReceiverSlackConfigHttpConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr ReceiverSlackConfigHttpConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr ReceiverSlackConfigHttpConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkReceiverSlackConfigHttpConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkReceiverSlackConfigHttpConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkReceiverSlackConfigHttpConfigBasicAuthUsername res."username";
    }
    // {
    };
  ReceiverSlackConfigHttpConfigBasicAuthPasswordModule = types.submodule {
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
  mkReceiverSlackConfigHttpConfigBasicAuthPassword =
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
  ReceiverSlackConfigHttpConfigBasicAuthUsernameModule = types.submodule {
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
  mkReceiverSlackConfigHttpConfigBasicAuthUsername =
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
  ReceiverSlackConfigHttpConfigBearerTokenSecretModule = types.submodule {
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
  mkReceiverSlackConfigHttpConfigBearerTokenSecret =
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
  ReceiverSlackConfigHttpConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization header configuration for the client.\nThis is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+.";
        type = (types.nullOr ReceiverSlackConfigHttpConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "BasicAuth for the client.\nThis is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence.";
        type = (types.nullOr ReceiverSlackConfigHttpConfigBasicAuthModule);
        default = null;
      };
      "bearerTokenSecret" = mkOption {
        description = "The secret's key that contains the bearer token to be used by the client\nfor authentication.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.";
        type = (types.nullOr ReceiverSlackConfigHttpConfigBearerTokenSecretModule);
        default = null;
      };
      "followRedirects" = mkOption {
        description = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "OAuth2 client credentials used to fetch a token for the targets.";
        type = (types.nullOr ReceiverSlackConfigHttpConfigOauth2Module);
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
      "proxyURL" = mkOption {
        description = "Optional proxy URL.\n\nIf defined, this field takes precedence over `proxyUrl`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "proxyUrl" = mkOption {
        description = "`proxyURL` defines the HTTP proxy server to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration for the client.";
        type = (types.nullOr ReceiverSlackConfigHttpConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkReceiverSlackConfigHttpConfig =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkReceiverSlackConfigHttpConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkReceiverSlackConfigHttpConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs (res."bearerTokenSecret" != null) {
      "bearerTokenSecret" = mkReceiverSlackConfigHttpConfigBearerTokenSecret res."bearerTokenSecret";
    }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) {
      "oauth2" = mkReceiverSlackConfigHttpConfigOauth2 res."oauth2";
    }
    // {
    }
    // optionalAttrs (res."proxyConnectHeader" != { }) { inherit (res) "proxyConnectHeader"; }
    // {
    }
    // optionalAttrs res."proxyFromEnvironment" { inherit (res) "proxyFromEnvironment"; }
    // {
    }
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."proxyUrl" != null) { inherit (res) "proxyUrl"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkReceiverSlackConfigHttpConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  ReceiverSlackConfigHttpConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkReceiverSlackConfigHttpConfigOauth2ClientIdConfigMap =
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
  ReceiverSlackConfigHttpConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverSlackConfigHttpConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverSlackConfigHttpConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkReceiverSlackConfigHttpConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverSlackConfigHttpConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverSlackConfigHttpConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  ReceiverSlackConfigHttpConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkReceiverSlackConfigHttpConfigOauth2ClientIdSecret =
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
  ReceiverSlackConfigHttpConfigOauth2ClientSecretModule = types.submodule {
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
  mkReceiverSlackConfigHttpConfigOauth2ClientSecret =
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
  ReceiverSlackConfigHttpConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = ReceiverSlackConfigHttpConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = ReceiverSlackConfigHttpConfigOauth2ClientSecretModule;
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
        type = (types.nullOr ReceiverSlackConfigHttpConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkReceiverSlackConfigHttpConfigOauth2 =
    res:
    {
      "clientId" = mkReceiverSlackConfigHttpConfigOauth2ClientId res."clientId";
      "clientSecret" = mkReceiverSlackConfigHttpConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkReceiverSlackConfigHttpConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  ReceiverSlackConfigHttpConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverSlackConfigHttpConfigOauth2TlsConfigCaConfigMap =
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
  ReceiverSlackConfigHttpConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverSlackConfigHttpConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverSlackConfigHttpConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverSlackConfigHttpConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverSlackConfigHttpConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverSlackConfigHttpConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverSlackConfigHttpConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkReceiverSlackConfigHttpConfigOauth2TlsConfigCaSecret =
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
  ReceiverSlackConfigHttpConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverSlackConfigHttpConfigOauth2TlsConfigCertConfigMap =
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
  ReceiverSlackConfigHttpConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverSlackConfigHttpConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverSlackConfigHttpConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverSlackConfigHttpConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverSlackConfigHttpConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverSlackConfigHttpConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverSlackConfigHttpConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkReceiverSlackConfigHttpConfigOauth2TlsConfigCertSecret =
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
  ReceiverSlackConfigHttpConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkReceiverSlackConfigHttpConfigOauth2TlsConfigKeySecret =
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
  ReceiverSlackConfigHttpConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverSlackConfigHttpConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverSlackConfigHttpConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverSlackConfigHttpConfigOauth2TlsConfigKeySecretModule);
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
  mkReceiverSlackConfigHttpConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverSlackConfigHttpConfigOauth2TlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverSlackConfigHttpConfigOauth2TlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverSlackConfigHttpConfigOauth2TlsConfigKeySecret res."keySecret";
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
  ReceiverSlackConfigHttpConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverSlackConfigHttpConfigTlsConfigCaConfigMap =
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
  ReceiverSlackConfigHttpConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverSlackConfigHttpConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverSlackConfigHttpConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverSlackConfigHttpConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverSlackConfigHttpConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverSlackConfigHttpConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverSlackConfigHttpConfigTlsConfigCaSecretModule = types.submodule {
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
  mkReceiverSlackConfigHttpConfigTlsConfigCaSecret =
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
  ReceiverSlackConfigHttpConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverSlackConfigHttpConfigTlsConfigCertConfigMap =
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
  ReceiverSlackConfigHttpConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverSlackConfigHttpConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverSlackConfigHttpConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverSlackConfigHttpConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverSlackConfigHttpConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverSlackConfigHttpConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverSlackConfigHttpConfigTlsConfigCertSecretModule = types.submodule {
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
  mkReceiverSlackConfigHttpConfigTlsConfigCertSecret =
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
  ReceiverSlackConfigHttpConfigTlsConfigKeySecretModule = types.submodule {
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
  mkReceiverSlackConfigHttpConfigTlsConfigKeySecret =
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
  ReceiverSlackConfigHttpConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverSlackConfigHttpConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverSlackConfigHttpConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverSlackConfigHttpConfigTlsConfigKeySecretModule);
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
  mkReceiverSlackConfigHttpConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkReceiverSlackConfigHttpConfigTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverSlackConfigHttpConfigTlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverSlackConfigHttpConfigTlsConfigKeySecret res."keySecret";
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
  ReceiverSlackConfigModule = types.submodule {
    options = {
      "actions" = mkOption {
        description = "A list of Slack actions that are sent with each notification.";
        type = (types.listOf ReceiverSlackConfigActionModule);
        default = [ ];
      };
      "apiURL" = mkOption {
        description = "The secret's key that contains the Slack webhook URL.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.";
        type = (types.nullOr ReceiverSlackConfigApiURLModule);
        default = null;
      };
      "callbackId" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "channel" = mkOption {
        description = "The channel or user to send notifications to.";
        type = (types.nullOr types.str);
        default = null;
      };
      "color" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "fallback" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "fields" = mkOption {
        description = "A list of Slack fields that are sent with each notification.";
        type = (types.listOf ReceiverSlackConfigFieldModule);
        default = [ ];
      };
      "footer" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "httpConfig" = mkOption {
        description = "HTTP client configuration.";
        type = (types.nullOr ReceiverSlackConfigHttpConfigModule);
        default = null;
      };
      "iconEmoji" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "iconURL" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "imageURL" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "linkNames" = mkOption {
        type = types.bool;
        default = false;
      };
      "mrkdwnIn" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "pretext" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "sendResolved" = mkOption {
        description = "Whether or not to notify about resolved alerts.";
        type = types.bool;
        default = false;
      };
      "shortFields" = mkOption {
        type = types.bool;
        default = false;
      };
      "text" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "thumbURL" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "title" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "titleLink" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverSlackConfig =
    res:
    {
    }
    // optionalAttrs (res."actions" != [ ]) {
      "actions" = map mkReceiverSlackConfigAction res."actions";
    }
    // {
    }
    // optionalAttrs (res."apiURL" != null) { "apiURL" = mkReceiverSlackConfigApiURL res."apiURL"; }
    // {
    }
    // optionalAttrs (res."callbackId" != null) { inherit (res) "callbackId"; }
    // {
    }
    // optionalAttrs (res."channel" != null) { inherit (res) "channel"; }
    // {
    }
    // optionalAttrs (res."color" != null) { inherit (res) "color"; }
    // {
    }
    // optionalAttrs (res."fallback" != null) { inherit (res) "fallback"; }
    // {
    }
    // optionalAttrs (res."fields" != [ ]) { "fields" = map mkReceiverSlackConfigField res."fields"; }
    // {
    }
    // optionalAttrs (res."footer" != null) { inherit (res) "footer"; }
    // {
    }
    // optionalAttrs (res."httpConfig" != null) {
      "httpConfig" = mkReceiverSlackConfigHttpConfig res."httpConfig";
    }
    // {
    }
    // optionalAttrs (res."iconEmoji" != null) { inherit (res) "iconEmoji"; }
    // {
    }
    // optionalAttrs (res."iconURL" != null) { inherit (res) "iconURL"; }
    // {
    }
    // optionalAttrs (res."imageURL" != null) { inherit (res) "imageURL"; }
    // {
    }
    // optionalAttrs res."linkNames" { inherit (res) "linkNames"; }
    // {
    }
    // optionalAttrs (res."mrkdwnIn" != [ ]) { inherit (res) "mrkdwnIn"; }
    // {
    }
    // optionalAttrs (res."pretext" != null) { inherit (res) "pretext"; }
    // {
    }
    // optionalAttrs res."sendResolved" { inherit (res) "sendResolved"; }
    // {
    }
    // optionalAttrs res."shortFields" { inherit (res) "shortFields"; }
    // {
    }
    // optionalAttrs (res."text" != null) { inherit (res) "text"; }
    // {
    }
    // optionalAttrs (res."thumbURL" != null) { inherit (res) "thumbURL"; }
    // {
    }
    // optionalAttrs (res."title" != null) { inherit (res) "title"; }
    // {
    }
    // optionalAttrs (res."titleLink" != null) { inherit (res) "titleLink"; }
    // {
    }
    // optionalAttrs (res."username" != null) { inherit (res) "username"; }
    // {
    };
  ReceiverSnsConfigHttpConfigAuthorizationCredentialsModule = types.submodule {
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
  mkReceiverSnsConfigHttpConfigAuthorizationCredentials =
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
  ReceiverSnsConfigHttpConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr ReceiverSnsConfigHttpConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverSnsConfigHttpConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkReceiverSnsConfigHttpConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ReceiverSnsConfigHttpConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr ReceiverSnsConfigHttpConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr ReceiverSnsConfigHttpConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkReceiverSnsConfigHttpConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkReceiverSnsConfigHttpConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkReceiverSnsConfigHttpConfigBasicAuthUsername res."username";
    }
    // {
    };
  ReceiverSnsConfigHttpConfigBasicAuthPasswordModule = types.submodule {
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
  mkReceiverSnsConfigHttpConfigBasicAuthPassword =
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
  ReceiverSnsConfigHttpConfigBasicAuthUsernameModule = types.submodule {
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
  mkReceiverSnsConfigHttpConfigBasicAuthUsername =
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
  ReceiverSnsConfigHttpConfigBearerTokenSecretModule = types.submodule {
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
  mkReceiverSnsConfigHttpConfigBearerTokenSecret =
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
  ReceiverSnsConfigHttpConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization header configuration for the client.\nThis is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+.";
        type = (types.nullOr ReceiverSnsConfigHttpConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "BasicAuth for the client.\nThis is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence.";
        type = (types.nullOr ReceiverSnsConfigHttpConfigBasicAuthModule);
        default = null;
      };
      "bearerTokenSecret" = mkOption {
        description = "The secret's key that contains the bearer token to be used by the client\nfor authentication.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.";
        type = (types.nullOr ReceiverSnsConfigHttpConfigBearerTokenSecretModule);
        default = null;
      };
      "followRedirects" = mkOption {
        description = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "OAuth2 client credentials used to fetch a token for the targets.";
        type = (types.nullOr ReceiverSnsConfigHttpConfigOauth2Module);
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
      "proxyURL" = mkOption {
        description = "Optional proxy URL.\n\nIf defined, this field takes precedence over `proxyUrl`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "proxyUrl" = mkOption {
        description = "`proxyURL` defines the HTTP proxy server to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration for the client.";
        type = (types.nullOr ReceiverSnsConfigHttpConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkReceiverSnsConfigHttpConfig =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkReceiverSnsConfigHttpConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkReceiverSnsConfigHttpConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs (res."bearerTokenSecret" != null) {
      "bearerTokenSecret" = mkReceiverSnsConfigHttpConfigBearerTokenSecret res."bearerTokenSecret";
    }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) {
      "oauth2" = mkReceiverSnsConfigHttpConfigOauth2 res."oauth2";
    }
    // {
    }
    // optionalAttrs (res."proxyConnectHeader" != { }) { inherit (res) "proxyConnectHeader"; }
    // {
    }
    // optionalAttrs res."proxyFromEnvironment" { inherit (res) "proxyFromEnvironment"; }
    // {
    }
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."proxyUrl" != null) { inherit (res) "proxyUrl"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkReceiverSnsConfigHttpConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  ReceiverSnsConfigHttpConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkReceiverSnsConfigHttpConfigOauth2ClientIdConfigMap =
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
  ReceiverSnsConfigHttpConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverSnsConfigHttpConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverSnsConfigHttpConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkReceiverSnsConfigHttpConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverSnsConfigHttpConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverSnsConfigHttpConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  ReceiverSnsConfigHttpConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkReceiverSnsConfigHttpConfigOauth2ClientIdSecret =
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
  ReceiverSnsConfigHttpConfigOauth2ClientSecretModule = types.submodule {
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
  mkReceiverSnsConfigHttpConfigOauth2ClientSecret =
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
  ReceiverSnsConfigHttpConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = ReceiverSnsConfigHttpConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = ReceiverSnsConfigHttpConfigOauth2ClientSecretModule;
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
        type = (types.nullOr ReceiverSnsConfigHttpConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkReceiverSnsConfigHttpConfigOauth2 =
    res:
    {
      "clientId" = mkReceiverSnsConfigHttpConfigOauth2ClientId res."clientId";
      "clientSecret" = mkReceiverSnsConfigHttpConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkReceiverSnsConfigHttpConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  ReceiverSnsConfigHttpConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverSnsConfigHttpConfigOauth2TlsConfigCaConfigMap =
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
  ReceiverSnsConfigHttpConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverSnsConfigHttpConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverSnsConfigHttpConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverSnsConfigHttpConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverSnsConfigHttpConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverSnsConfigHttpConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverSnsConfigHttpConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkReceiverSnsConfigHttpConfigOauth2TlsConfigCaSecret =
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
  ReceiverSnsConfigHttpConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverSnsConfigHttpConfigOauth2TlsConfigCertConfigMap =
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
  ReceiverSnsConfigHttpConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverSnsConfigHttpConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverSnsConfigHttpConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverSnsConfigHttpConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverSnsConfigHttpConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverSnsConfigHttpConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverSnsConfigHttpConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkReceiverSnsConfigHttpConfigOauth2TlsConfigCertSecret =
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
  ReceiverSnsConfigHttpConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkReceiverSnsConfigHttpConfigOauth2TlsConfigKeySecret =
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
  ReceiverSnsConfigHttpConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverSnsConfigHttpConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverSnsConfigHttpConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverSnsConfigHttpConfigOauth2TlsConfigKeySecretModule);
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
  mkReceiverSnsConfigHttpConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverSnsConfigHttpConfigOauth2TlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverSnsConfigHttpConfigOauth2TlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverSnsConfigHttpConfigOauth2TlsConfigKeySecret res."keySecret";
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
  ReceiverSnsConfigHttpConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverSnsConfigHttpConfigTlsConfigCaConfigMap =
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
  ReceiverSnsConfigHttpConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverSnsConfigHttpConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverSnsConfigHttpConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverSnsConfigHttpConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverSnsConfigHttpConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverSnsConfigHttpConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverSnsConfigHttpConfigTlsConfigCaSecretModule = types.submodule {
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
  mkReceiverSnsConfigHttpConfigTlsConfigCaSecret =
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
  ReceiverSnsConfigHttpConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverSnsConfigHttpConfigTlsConfigCertConfigMap =
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
  ReceiverSnsConfigHttpConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverSnsConfigHttpConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverSnsConfigHttpConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverSnsConfigHttpConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverSnsConfigHttpConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverSnsConfigHttpConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverSnsConfigHttpConfigTlsConfigCertSecretModule = types.submodule {
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
  mkReceiverSnsConfigHttpConfigTlsConfigCertSecret =
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
  ReceiverSnsConfigHttpConfigTlsConfigKeySecretModule = types.submodule {
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
  mkReceiverSnsConfigHttpConfigTlsConfigKeySecret =
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
  ReceiverSnsConfigHttpConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverSnsConfigHttpConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverSnsConfigHttpConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverSnsConfigHttpConfigTlsConfigKeySecretModule);
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
  mkReceiverSnsConfigHttpConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkReceiverSnsConfigHttpConfigTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverSnsConfigHttpConfigTlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverSnsConfigHttpConfigTlsConfigKeySecret res."keySecret";
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
  ReceiverSnsConfigModule = types.submodule {
    options = {
      "apiURL" = mkOption {
        description = "The SNS API URL i.e. https://sns.us-east-2.amazonaws.com.\nIf not specified, the SNS API URL from the SNS SDK will be used.";
        type = (types.nullOr types.str);
        default = null;
      };
      "attributes" = mkOption {
        description = "SNS message attributes.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "httpConfig" = mkOption {
        description = "HTTP client configuration.";
        type = (types.nullOr ReceiverSnsConfigHttpConfigModule);
        default = null;
      };
      "message" = mkOption {
        description = "The message content of the SNS notification.";
        type = (types.nullOr types.str);
        default = null;
      };
      "phoneNumber" = mkOption {
        description = "Phone number if message is delivered via SMS in E.164 format.\nIf you don't specify this value, you must specify a value for the TopicARN or TargetARN.";
        type = (types.nullOr types.str);
        default = null;
      };
      "sendResolved" = mkOption {
        description = "Whether or not to notify about resolved alerts.";
        type = types.bool;
        default = false;
      };
      "sigv4" = mkOption {
        description = "Configures AWS's Signature Verification 4 signing process to sign requests.";
        type = (types.nullOr ReceiverSnsConfigSigv4Module);
        default = null;
      };
      "subject" = mkOption {
        description = "Subject line when the message is delivered to email endpoints.";
        type = (types.nullOr types.str);
        default = null;
      };
      "targetARN" = mkOption {
        description = "The  mobile platform endpoint ARN if message is delivered via mobile notifications.\nIf you don't specify this value, you must specify a value for the topic_arn or PhoneNumber.";
        type = (types.nullOr types.str);
        default = null;
      };
      "topicARN" = mkOption {
        description = "SNS topic ARN, i.e. arn:aws:sns:us-east-2:698519295917:My-Topic\nIf you don't specify this value, you must specify a value for the PhoneNumber or TargetARN.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverSnsConfig =
    res:
    {
    }
    // optionalAttrs (res."apiURL" != null) { inherit (res) "apiURL"; }
    // {
    }
    // optionalAttrs (res."attributes" != { }) { inherit (res) "attributes"; }
    // {
    }
    // optionalAttrs (res."httpConfig" != null) {
      "httpConfig" = mkReceiverSnsConfigHttpConfig res."httpConfig";
    }
    // {
    }
    // optionalAttrs (res."message" != null) { inherit (res) "message"; }
    // {
    }
    // optionalAttrs (res."phoneNumber" != null) { inherit (res) "phoneNumber"; }
    // {
    }
    // optionalAttrs res."sendResolved" { inherit (res) "sendResolved"; }
    // {
    }
    // optionalAttrs (res."sigv4" != null) { "sigv4" = mkReceiverSnsConfigSigv4 res."sigv4"; }
    // {
    }
    // optionalAttrs (res."subject" != null) { inherit (res) "subject"; }
    // {
    }
    // optionalAttrs (res."targetARN" != null) { inherit (res) "targetARN"; }
    // {
    }
    // optionalAttrs (res."topicARN" != null) { inherit (res) "topicARN"; }
    // {
    };
  ReceiverSnsConfigSigv4AccessKeyModule = types.submodule {
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
  mkReceiverSnsConfigSigv4AccessKey =
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
  ReceiverSnsConfigSigv4Module = types.submodule {
    options = {
      "accessKey" = mkOption {
        description = "AccessKey is the AWS API key. If not specified, the environment variable\n`AWS_ACCESS_KEY_ID` is used.";
        type = (types.nullOr ReceiverSnsConfigSigv4AccessKeyModule);
        default = null;
      };
      "profile" = mkOption {
        description = "Profile is the named AWS profile used to authenticate.";
        type = (types.nullOr types.str);
        default = null;
      };
      "region" = mkOption {
        description = "Region is the AWS region. If blank, the region from the default credentials chain used.";
        type = (types.nullOr types.str);
        default = null;
      };
      "roleArn" = mkOption {
        description = "RoleArn is the named AWS profile used to authenticate.";
        type = (types.nullOr types.str);
        default = null;
      };
      "secretKey" = mkOption {
        description = "SecretKey is the AWS API secret. If not specified, the environment\nvariable `AWS_SECRET_ACCESS_KEY` is used.";
        type = (types.nullOr ReceiverSnsConfigSigv4SecretKeyModule);
        default = null;
      };
    };
  };
  mkReceiverSnsConfigSigv4 =
    res:
    {
    }
    // optionalAttrs (res."accessKey" != null) {
      "accessKey" = mkReceiverSnsConfigSigv4AccessKey res."accessKey";
    }
    // {
    }
    // optionalAttrs (res."profile" != null) { inherit (res) "profile"; }
    // {
    }
    // optionalAttrs (res."region" != null) { inherit (res) "region"; }
    // {
    }
    // optionalAttrs (res."roleArn" != null) { inherit (res) "roleArn"; }
    // {
    }
    // optionalAttrs (res."secretKey" != null) {
      "secretKey" = mkReceiverSnsConfigSigv4SecretKey res."secretKey";
    }
    // {
    };
  ReceiverSnsConfigSigv4SecretKeyModule = types.submodule {
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
  mkReceiverSnsConfigSigv4SecretKey =
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
  ReceiverTelegramConfigBotTokenModule = types.submodule {
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
  mkReceiverTelegramConfigBotToken =
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
  ReceiverTelegramConfigHttpConfigAuthorizationCredentialsModule = types.submodule {
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
  mkReceiverTelegramConfigHttpConfigAuthorizationCredentials =
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
  ReceiverTelegramConfigHttpConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr ReceiverTelegramConfigHttpConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverTelegramConfigHttpConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkReceiverTelegramConfigHttpConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ReceiverTelegramConfigHttpConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr ReceiverTelegramConfigHttpConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr ReceiverTelegramConfigHttpConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkReceiverTelegramConfigHttpConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkReceiverTelegramConfigHttpConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkReceiverTelegramConfigHttpConfigBasicAuthUsername res."username";
    }
    // {
    };
  ReceiverTelegramConfigHttpConfigBasicAuthPasswordModule = types.submodule {
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
  mkReceiverTelegramConfigHttpConfigBasicAuthPassword =
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
  ReceiverTelegramConfigHttpConfigBasicAuthUsernameModule = types.submodule {
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
  mkReceiverTelegramConfigHttpConfigBasicAuthUsername =
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
  ReceiverTelegramConfigHttpConfigBearerTokenSecretModule = types.submodule {
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
  mkReceiverTelegramConfigHttpConfigBearerTokenSecret =
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
  ReceiverTelegramConfigHttpConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization header configuration for the client.\nThis is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+.";
        type = (types.nullOr ReceiverTelegramConfigHttpConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "BasicAuth for the client.\nThis is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence.";
        type = (types.nullOr ReceiverTelegramConfigHttpConfigBasicAuthModule);
        default = null;
      };
      "bearerTokenSecret" = mkOption {
        description = "The secret's key that contains the bearer token to be used by the client\nfor authentication.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.";
        type = (types.nullOr ReceiverTelegramConfigHttpConfigBearerTokenSecretModule);
        default = null;
      };
      "followRedirects" = mkOption {
        description = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "OAuth2 client credentials used to fetch a token for the targets.";
        type = (types.nullOr ReceiverTelegramConfigHttpConfigOauth2Module);
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
      "proxyURL" = mkOption {
        description = "Optional proxy URL.\n\nIf defined, this field takes precedence over `proxyUrl`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "proxyUrl" = mkOption {
        description = "`proxyURL` defines the HTTP proxy server to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration for the client.";
        type = (types.nullOr ReceiverTelegramConfigHttpConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkReceiverTelegramConfigHttpConfig =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkReceiverTelegramConfigHttpConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkReceiverTelegramConfigHttpConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs (res."bearerTokenSecret" != null) {
      "bearerTokenSecret" = mkReceiverTelegramConfigHttpConfigBearerTokenSecret res."bearerTokenSecret";
    }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) {
      "oauth2" = mkReceiverTelegramConfigHttpConfigOauth2 res."oauth2";
    }
    // {
    }
    // optionalAttrs (res."proxyConnectHeader" != { }) { inherit (res) "proxyConnectHeader"; }
    // {
    }
    // optionalAttrs res."proxyFromEnvironment" { inherit (res) "proxyFromEnvironment"; }
    // {
    }
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."proxyUrl" != null) { inherit (res) "proxyUrl"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkReceiverTelegramConfigHttpConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  ReceiverTelegramConfigHttpConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkReceiverTelegramConfigHttpConfigOauth2ClientIdConfigMap =
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
  ReceiverTelegramConfigHttpConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverTelegramConfigHttpConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverTelegramConfigHttpConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkReceiverTelegramConfigHttpConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverTelegramConfigHttpConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverTelegramConfigHttpConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  ReceiverTelegramConfigHttpConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkReceiverTelegramConfigHttpConfigOauth2ClientIdSecret =
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
  ReceiverTelegramConfigHttpConfigOauth2ClientSecretModule = types.submodule {
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
  mkReceiverTelegramConfigHttpConfigOauth2ClientSecret =
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
  ReceiverTelegramConfigHttpConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = ReceiverTelegramConfigHttpConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = ReceiverTelegramConfigHttpConfigOauth2ClientSecretModule;
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
        type = (types.nullOr ReceiverTelegramConfigHttpConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkReceiverTelegramConfigHttpConfigOauth2 =
    res:
    {
      "clientId" = mkReceiverTelegramConfigHttpConfigOauth2ClientId res."clientId";
      "clientSecret" = mkReceiverTelegramConfigHttpConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkReceiverTelegramConfigHttpConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  ReceiverTelegramConfigHttpConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverTelegramConfigHttpConfigOauth2TlsConfigCaConfigMap =
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
  ReceiverTelegramConfigHttpConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverTelegramConfigHttpConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverTelegramConfigHttpConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverTelegramConfigHttpConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverTelegramConfigHttpConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverTelegramConfigHttpConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverTelegramConfigHttpConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkReceiverTelegramConfigHttpConfigOauth2TlsConfigCaSecret =
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
  ReceiverTelegramConfigHttpConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverTelegramConfigHttpConfigOauth2TlsConfigCertConfigMap =
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
  ReceiverTelegramConfigHttpConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverTelegramConfigHttpConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverTelegramConfigHttpConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverTelegramConfigHttpConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverTelegramConfigHttpConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverTelegramConfigHttpConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverTelegramConfigHttpConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkReceiverTelegramConfigHttpConfigOauth2TlsConfigCertSecret =
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
  ReceiverTelegramConfigHttpConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkReceiverTelegramConfigHttpConfigOauth2TlsConfigKeySecret =
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
  ReceiverTelegramConfigHttpConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverTelegramConfigHttpConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverTelegramConfigHttpConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverTelegramConfigHttpConfigOauth2TlsConfigKeySecretModule);
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
  mkReceiverTelegramConfigHttpConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverTelegramConfigHttpConfigOauth2TlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverTelegramConfigHttpConfigOauth2TlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverTelegramConfigHttpConfigOauth2TlsConfigKeySecret res."keySecret";
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
  ReceiverTelegramConfigHttpConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverTelegramConfigHttpConfigTlsConfigCaConfigMap =
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
  ReceiverTelegramConfigHttpConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverTelegramConfigHttpConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverTelegramConfigHttpConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverTelegramConfigHttpConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverTelegramConfigHttpConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverTelegramConfigHttpConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverTelegramConfigHttpConfigTlsConfigCaSecretModule = types.submodule {
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
  mkReceiverTelegramConfigHttpConfigTlsConfigCaSecret =
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
  ReceiverTelegramConfigHttpConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverTelegramConfigHttpConfigTlsConfigCertConfigMap =
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
  ReceiverTelegramConfigHttpConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverTelegramConfigHttpConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverTelegramConfigHttpConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverTelegramConfigHttpConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverTelegramConfigHttpConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverTelegramConfigHttpConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverTelegramConfigHttpConfigTlsConfigCertSecretModule = types.submodule {
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
  mkReceiverTelegramConfigHttpConfigTlsConfigCertSecret =
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
  ReceiverTelegramConfigHttpConfigTlsConfigKeySecretModule = types.submodule {
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
  mkReceiverTelegramConfigHttpConfigTlsConfigKeySecret =
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
  ReceiverTelegramConfigHttpConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverTelegramConfigHttpConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverTelegramConfigHttpConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverTelegramConfigHttpConfigTlsConfigKeySecretModule);
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
  mkReceiverTelegramConfigHttpConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverTelegramConfigHttpConfigTlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverTelegramConfigHttpConfigTlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverTelegramConfigHttpConfigTlsConfigKeySecret res."keySecret";
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
  ReceiverTelegramConfigModule = types.submodule {
    options = {
      "apiURL" = mkOption {
        description = "The Telegram API URL i.e. https://api.telegram.org.\nIf not specified, default API URL will be used.";
        type = (types.nullOr types.str);
        default = null;
      };
      "botToken" = mkOption {
        description = "Telegram bot token. It is mutually exclusive with `botTokenFile`.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.\n\nEither `botToken` or `botTokenFile` is required.";
        type = (types.nullOr ReceiverTelegramConfigBotTokenModule);
        default = null;
      };
      "botTokenFile" = mkOption {
        description = "File to read the Telegram bot token from. It is mutually exclusive with `botToken`.\nEither `botToken` or `botTokenFile` is required.\n\nIt requires Alertmanager >= v0.26.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "chatID" = mkOption {
        description = "The Telegram chat ID.";
        type = types.int;
      };
      "disableNotifications" = mkOption {
        description = "Disable telegram notifications";
        type = types.bool;
        default = false;
      };
      "httpConfig" = mkOption {
        description = "HTTP client configuration.";
        type = (types.nullOr ReceiverTelegramConfigHttpConfigModule);
        default = null;
      };
      "message" = mkOption {
        description = "Message template";
        type = (types.nullOr types.str);
        default = null;
      };
      "messageThreadID" = mkOption {
        description = "The Telegram Group Topic ID.\nIt requires Alertmanager >= 0.26.0.";
        type = (types.nullOr types.int);
        default = null;
      };
      "parseMode" = mkOption {
        description = "Parse mode for telegram message";
        type = (
          types.nullOr (
            types.enum [
              "MarkdownV2"
              "Markdown"
              "HTML"
            ]
          )
        );
        default = null;
      };
      "sendResolved" = mkOption {
        description = "Whether to notify about resolved alerts.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkReceiverTelegramConfig =
    res:
    {
    }
    // optionalAttrs (res."apiURL" != null) { inherit (res) "apiURL"; }
    // {
    }
    // optionalAttrs (res."botToken" != null) {
      "botToken" = mkReceiverTelegramConfigBotToken res."botToken";
    }
    // {
    }
    // optionalAttrs (res."botTokenFile" != null) { inherit (res) "botTokenFile"; }
    // {
      inherit (res) "chatID";
    }
    // optionalAttrs res."disableNotifications" { inherit (res) "disableNotifications"; }
    // {
    }
    // optionalAttrs (res."httpConfig" != null) {
      "httpConfig" = mkReceiverTelegramConfigHttpConfig res."httpConfig";
    }
    // {
    }
    // optionalAttrs (res."message" != null) { inherit (res) "message"; }
    // {
    }
    // optionalAttrs (res."messageThreadID" != null) { inherit (res) "messageThreadID"; }
    // {
    }
    // optionalAttrs (res."parseMode" != null) { inherit (res) "parseMode"; }
    // {
    }
    // optionalAttrs res."sendResolved" { inherit (res) "sendResolved"; }
    // {
    };
  ReceiverVictoropsConfigApiKeyModule = types.submodule {
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
  mkReceiverVictoropsConfigApiKey =
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
  ReceiverVictoropsConfigCustomFieldModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "Key of the tuple.";
        type = types.str;
      };
      "value" = mkOption {
        description = "Value of the tuple.";
        type = types.str;
      };
    };
  };
  mkReceiverVictoropsConfigCustomField = res: {
    inherit (res) "key";
    inherit (res) "value";
  };
  ReceiverVictoropsConfigHttpConfigAuthorizationCredentialsModule = types.submodule {
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
  mkReceiverVictoropsConfigHttpConfigAuthorizationCredentials =
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
  ReceiverVictoropsConfigHttpConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverVictoropsConfigHttpConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkReceiverVictoropsConfigHttpConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ReceiverVictoropsConfigHttpConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkReceiverVictoropsConfigHttpConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkReceiverVictoropsConfigHttpConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkReceiverVictoropsConfigHttpConfigBasicAuthUsername res."username";
    }
    // {
    };
  ReceiverVictoropsConfigHttpConfigBasicAuthPasswordModule = types.submodule {
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
  mkReceiverVictoropsConfigHttpConfigBasicAuthPassword =
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
  ReceiverVictoropsConfigHttpConfigBasicAuthUsernameModule = types.submodule {
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
  mkReceiverVictoropsConfigHttpConfigBasicAuthUsername =
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
  ReceiverVictoropsConfigHttpConfigBearerTokenSecretModule = types.submodule {
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
  mkReceiverVictoropsConfigHttpConfigBearerTokenSecret =
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
  ReceiverVictoropsConfigHttpConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization header configuration for the client.\nThis is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+.";
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "BasicAuth for the client.\nThis is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence.";
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigBasicAuthModule);
        default = null;
      };
      "bearerTokenSecret" = mkOption {
        description = "The secret's key that contains the bearer token to be used by the client\nfor authentication.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.";
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigBearerTokenSecretModule);
        default = null;
      };
      "followRedirects" = mkOption {
        description = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "OAuth2 client credentials used to fetch a token for the targets.";
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigOauth2Module);
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
      "proxyURL" = mkOption {
        description = "Optional proxy URL.\n\nIf defined, this field takes precedence over `proxyUrl`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "proxyUrl" = mkOption {
        description = "`proxyURL` defines the HTTP proxy server to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration for the client.";
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkReceiverVictoropsConfigHttpConfig =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkReceiverVictoropsConfigHttpConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkReceiverVictoropsConfigHttpConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs (res."bearerTokenSecret" != null) {
      "bearerTokenSecret" = mkReceiverVictoropsConfigHttpConfigBearerTokenSecret res."bearerTokenSecret";
    }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) {
      "oauth2" = mkReceiverVictoropsConfigHttpConfigOauth2 res."oauth2";
    }
    // {
    }
    // optionalAttrs (res."proxyConnectHeader" != { }) { inherit (res) "proxyConnectHeader"; }
    // {
    }
    // optionalAttrs res."proxyFromEnvironment" { inherit (res) "proxyFromEnvironment"; }
    // {
    }
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."proxyUrl" != null) { inherit (res) "proxyUrl"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkReceiverVictoropsConfigHttpConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  ReceiverVictoropsConfigHttpConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkReceiverVictoropsConfigHttpConfigOauth2ClientIdConfigMap =
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
  ReceiverVictoropsConfigHttpConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkReceiverVictoropsConfigHttpConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverVictoropsConfigHttpConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverVictoropsConfigHttpConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  ReceiverVictoropsConfigHttpConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkReceiverVictoropsConfigHttpConfigOauth2ClientIdSecret =
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
  ReceiverVictoropsConfigHttpConfigOauth2ClientSecretModule = types.submodule {
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
  mkReceiverVictoropsConfigHttpConfigOauth2ClientSecret =
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
  ReceiverVictoropsConfigHttpConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = ReceiverVictoropsConfigHttpConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = ReceiverVictoropsConfigHttpConfigOauth2ClientSecretModule;
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
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkReceiverVictoropsConfigHttpConfigOauth2 =
    res:
    {
      "clientId" = mkReceiverVictoropsConfigHttpConfigOauth2ClientId res."clientId";
      "clientSecret" = mkReceiverVictoropsConfigHttpConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkReceiverVictoropsConfigHttpConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  ReceiverVictoropsConfigHttpConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverVictoropsConfigHttpConfigOauth2TlsConfigCaConfigMap =
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
  ReceiverVictoropsConfigHttpConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverVictoropsConfigHttpConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverVictoropsConfigHttpConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverVictoropsConfigHttpConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverVictoropsConfigHttpConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkReceiverVictoropsConfigHttpConfigOauth2TlsConfigCaSecret =
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
  ReceiverVictoropsConfigHttpConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverVictoropsConfigHttpConfigOauth2TlsConfigCertConfigMap =
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
  ReceiverVictoropsConfigHttpConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverVictoropsConfigHttpConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverVictoropsConfigHttpConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverVictoropsConfigHttpConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverVictoropsConfigHttpConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkReceiverVictoropsConfigHttpConfigOauth2TlsConfigCertSecret =
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
  ReceiverVictoropsConfigHttpConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkReceiverVictoropsConfigHttpConfigOauth2TlsConfigKeySecret =
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
  ReceiverVictoropsConfigHttpConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigOauth2TlsConfigKeySecretModule);
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
  mkReceiverVictoropsConfigHttpConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverVictoropsConfigHttpConfigOauth2TlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverVictoropsConfigHttpConfigOauth2TlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverVictoropsConfigHttpConfigOauth2TlsConfigKeySecret res."keySecret";
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
  ReceiverVictoropsConfigHttpConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverVictoropsConfigHttpConfigTlsConfigCaConfigMap =
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
  ReceiverVictoropsConfigHttpConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverVictoropsConfigHttpConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverVictoropsConfigHttpConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverVictoropsConfigHttpConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverVictoropsConfigHttpConfigTlsConfigCaSecretModule = types.submodule {
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
  mkReceiverVictoropsConfigHttpConfigTlsConfigCaSecret =
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
  ReceiverVictoropsConfigHttpConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverVictoropsConfigHttpConfigTlsConfigCertConfigMap =
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
  ReceiverVictoropsConfigHttpConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverVictoropsConfigHttpConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverVictoropsConfigHttpConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverVictoropsConfigHttpConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverVictoropsConfigHttpConfigTlsConfigCertSecretModule = types.submodule {
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
  mkReceiverVictoropsConfigHttpConfigTlsConfigCertSecret =
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
  ReceiverVictoropsConfigHttpConfigTlsConfigKeySecretModule = types.submodule {
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
  mkReceiverVictoropsConfigHttpConfigTlsConfigKeySecret =
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
  ReceiverVictoropsConfigHttpConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigTlsConfigKeySecretModule);
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
  mkReceiverVictoropsConfigHttpConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverVictoropsConfigHttpConfigTlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverVictoropsConfigHttpConfigTlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverVictoropsConfigHttpConfigTlsConfigKeySecret res."keySecret";
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
  ReceiverVictoropsConfigModule = types.submodule {
    options = {
      "apiKey" = mkOption {
        description = "The secret's key that contains the API key to use when talking to the VictorOps API.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.";
        type = (types.nullOr ReceiverVictoropsConfigApiKeyModule);
        default = null;
      };
      "apiUrl" = mkOption {
        description = "The VictorOps API URL.";
        type = (types.nullOr types.str);
        default = null;
      };
      "customFields" = mkOption {
        description = "Additional custom fields for notification.";
        type = (types.listOf ReceiverVictoropsConfigCustomFieldModule);
        default = [ ];
      };
      "entityDisplayName" = mkOption {
        description = "Contains summary of the alerted problem.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpConfig" = mkOption {
        description = "The HTTP client's configuration.";
        type = (types.nullOr ReceiverVictoropsConfigHttpConfigModule);
        default = null;
      };
      "messageType" = mkOption {
        description = "Describes the behavior of the alert (CRITICAL, WARNING, INFO).";
        type = (types.nullOr types.str);
        default = null;
      };
      "monitoringTool" = mkOption {
        description = "The monitoring tool the state message is from.";
        type = (types.nullOr types.str);
        default = null;
      };
      "routingKey" = mkOption {
        description = "A key used to map the alert to a team.";
        type = (types.nullOr types.str);
        default = null;
      };
      "sendResolved" = mkOption {
        description = "Whether or not to notify about resolved alerts.";
        type = types.bool;
        default = false;
      };
      "stateMessage" = mkOption {
        description = "Contains long explanation of the alerted problem.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverVictoropsConfig =
    res:
    {
    }
    // optionalAttrs (res."apiKey" != null) { "apiKey" = mkReceiverVictoropsConfigApiKey res."apiKey"; }
    // {
    }
    // optionalAttrs (res."apiUrl" != null) { inherit (res) "apiUrl"; }
    // {
    }
    // optionalAttrs (res."customFields" != [ ]) {
      "customFields" = map mkReceiverVictoropsConfigCustomField res."customFields";
    }
    // {
    }
    // optionalAttrs (res."entityDisplayName" != null) { inherit (res) "entityDisplayName"; }
    // {
    }
    // optionalAttrs (res."httpConfig" != null) {
      "httpConfig" = mkReceiverVictoropsConfigHttpConfig res."httpConfig";
    }
    // {
    }
    // optionalAttrs (res."messageType" != null) { inherit (res) "messageType"; }
    // {
    }
    // optionalAttrs (res."monitoringTool" != null) { inherit (res) "monitoringTool"; }
    // {
    }
    // optionalAttrs (res."routingKey" != null) { inherit (res) "routingKey"; }
    // {
    }
    // optionalAttrs res."sendResolved" { inherit (res) "sendResolved"; }
    // {
    }
    // optionalAttrs (res."stateMessage" != null) { inherit (res) "stateMessage"; }
    // {
    };
  ReceiverWebexConfigHttpConfigAuthorizationCredentialsModule = types.submodule {
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
  mkReceiverWebexConfigHttpConfigAuthorizationCredentials =
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
  ReceiverWebexConfigHttpConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr ReceiverWebexConfigHttpConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverWebexConfigHttpConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkReceiverWebexConfigHttpConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ReceiverWebexConfigHttpConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr ReceiverWebexConfigHttpConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr ReceiverWebexConfigHttpConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkReceiverWebexConfigHttpConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkReceiverWebexConfigHttpConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkReceiverWebexConfigHttpConfigBasicAuthUsername res."username";
    }
    // {
    };
  ReceiverWebexConfigHttpConfigBasicAuthPasswordModule = types.submodule {
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
  mkReceiverWebexConfigHttpConfigBasicAuthPassword =
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
  ReceiverWebexConfigHttpConfigBasicAuthUsernameModule = types.submodule {
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
  mkReceiverWebexConfigHttpConfigBasicAuthUsername =
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
  ReceiverWebexConfigHttpConfigBearerTokenSecretModule = types.submodule {
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
  mkReceiverWebexConfigHttpConfigBearerTokenSecret =
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
  ReceiverWebexConfigHttpConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization header configuration for the client.\nThis is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+.";
        type = (types.nullOr ReceiverWebexConfigHttpConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "BasicAuth for the client.\nThis is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence.";
        type = (types.nullOr ReceiverWebexConfigHttpConfigBasicAuthModule);
        default = null;
      };
      "bearerTokenSecret" = mkOption {
        description = "The secret's key that contains the bearer token to be used by the client\nfor authentication.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.";
        type = (types.nullOr ReceiverWebexConfigHttpConfigBearerTokenSecretModule);
        default = null;
      };
      "followRedirects" = mkOption {
        description = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "OAuth2 client credentials used to fetch a token for the targets.";
        type = (types.nullOr ReceiverWebexConfigHttpConfigOauth2Module);
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
      "proxyURL" = mkOption {
        description = "Optional proxy URL.\n\nIf defined, this field takes precedence over `proxyUrl`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "proxyUrl" = mkOption {
        description = "`proxyURL` defines the HTTP proxy server to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration for the client.";
        type = (types.nullOr ReceiverWebexConfigHttpConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkReceiverWebexConfigHttpConfig =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkReceiverWebexConfigHttpConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkReceiverWebexConfigHttpConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs (res."bearerTokenSecret" != null) {
      "bearerTokenSecret" = mkReceiverWebexConfigHttpConfigBearerTokenSecret res."bearerTokenSecret";
    }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) {
      "oauth2" = mkReceiverWebexConfigHttpConfigOauth2 res."oauth2";
    }
    // {
    }
    // optionalAttrs (res."proxyConnectHeader" != { }) { inherit (res) "proxyConnectHeader"; }
    // {
    }
    // optionalAttrs res."proxyFromEnvironment" { inherit (res) "proxyFromEnvironment"; }
    // {
    }
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."proxyUrl" != null) { inherit (res) "proxyUrl"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkReceiverWebexConfigHttpConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  ReceiverWebexConfigHttpConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkReceiverWebexConfigHttpConfigOauth2ClientIdConfigMap =
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
  ReceiverWebexConfigHttpConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverWebexConfigHttpConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverWebexConfigHttpConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkReceiverWebexConfigHttpConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverWebexConfigHttpConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverWebexConfigHttpConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  ReceiverWebexConfigHttpConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkReceiverWebexConfigHttpConfigOauth2ClientIdSecret =
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
  ReceiverWebexConfigHttpConfigOauth2ClientSecretModule = types.submodule {
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
  mkReceiverWebexConfigHttpConfigOauth2ClientSecret =
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
  ReceiverWebexConfigHttpConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = ReceiverWebexConfigHttpConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = ReceiverWebexConfigHttpConfigOauth2ClientSecretModule;
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
        type = (types.nullOr ReceiverWebexConfigHttpConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkReceiverWebexConfigHttpConfigOauth2 =
    res:
    {
      "clientId" = mkReceiverWebexConfigHttpConfigOauth2ClientId res."clientId";
      "clientSecret" = mkReceiverWebexConfigHttpConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkReceiverWebexConfigHttpConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  ReceiverWebexConfigHttpConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverWebexConfigHttpConfigOauth2TlsConfigCaConfigMap =
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
  ReceiverWebexConfigHttpConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverWebexConfigHttpConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverWebexConfigHttpConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverWebexConfigHttpConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverWebexConfigHttpConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverWebexConfigHttpConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverWebexConfigHttpConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkReceiverWebexConfigHttpConfigOauth2TlsConfigCaSecret =
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
  ReceiverWebexConfigHttpConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverWebexConfigHttpConfigOauth2TlsConfigCertConfigMap =
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
  ReceiverWebexConfigHttpConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverWebexConfigHttpConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverWebexConfigHttpConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverWebexConfigHttpConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverWebexConfigHttpConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverWebexConfigHttpConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverWebexConfigHttpConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkReceiverWebexConfigHttpConfigOauth2TlsConfigCertSecret =
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
  ReceiverWebexConfigHttpConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkReceiverWebexConfigHttpConfigOauth2TlsConfigKeySecret =
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
  ReceiverWebexConfigHttpConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverWebexConfigHttpConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverWebexConfigHttpConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverWebexConfigHttpConfigOauth2TlsConfigKeySecretModule);
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
  mkReceiverWebexConfigHttpConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverWebexConfigHttpConfigOauth2TlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverWebexConfigHttpConfigOauth2TlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverWebexConfigHttpConfigOauth2TlsConfigKeySecret res."keySecret";
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
  ReceiverWebexConfigHttpConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverWebexConfigHttpConfigTlsConfigCaConfigMap =
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
  ReceiverWebexConfigHttpConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverWebexConfigHttpConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverWebexConfigHttpConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverWebexConfigHttpConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverWebexConfigHttpConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverWebexConfigHttpConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverWebexConfigHttpConfigTlsConfigCaSecretModule = types.submodule {
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
  mkReceiverWebexConfigHttpConfigTlsConfigCaSecret =
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
  ReceiverWebexConfigHttpConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverWebexConfigHttpConfigTlsConfigCertConfigMap =
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
  ReceiverWebexConfigHttpConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverWebexConfigHttpConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverWebexConfigHttpConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverWebexConfigHttpConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverWebexConfigHttpConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverWebexConfigHttpConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverWebexConfigHttpConfigTlsConfigCertSecretModule = types.submodule {
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
  mkReceiverWebexConfigHttpConfigTlsConfigCertSecret =
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
  ReceiverWebexConfigHttpConfigTlsConfigKeySecretModule = types.submodule {
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
  mkReceiverWebexConfigHttpConfigTlsConfigKeySecret =
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
  ReceiverWebexConfigHttpConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverWebexConfigHttpConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverWebexConfigHttpConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverWebexConfigHttpConfigTlsConfigKeySecretModule);
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
  mkReceiverWebexConfigHttpConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkReceiverWebexConfigHttpConfigTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverWebexConfigHttpConfigTlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverWebexConfigHttpConfigTlsConfigKeySecret res."keySecret";
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
  ReceiverWebexConfigModule = types.submodule {
    options = {
      "apiURL" = mkOption {
        description = "The Webex Teams API URL i.e. https://webexapis.com/v1/messages\nProvide if different from the default API URL.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpConfig" = mkOption {
        description = "The HTTP client's configuration.\nYou must supply the bot token via the `httpConfig.authorization` field.";
        type = (types.nullOr ReceiverWebexConfigHttpConfigModule);
        default = null;
      };
      "message" = mkOption {
        description = "Message template";
        type = (types.nullOr types.str);
        default = null;
      };
      "roomID" = mkOption {
        description = "ID of the Webex Teams room where to send the messages.";
        type = types.str;
      };
      "sendResolved" = mkOption {
        description = "Whether to notify about resolved alerts.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkReceiverWebexConfig =
    res:
    {
    }
    // optionalAttrs (res."apiURL" != null) { inherit (res) "apiURL"; }
    // {
    }
    // optionalAttrs (res."httpConfig" != null) {
      "httpConfig" = mkReceiverWebexConfigHttpConfig res."httpConfig";
    }
    // {
    }
    // optionalAttrs (res."message" != null) { inherit (res) "message"; }
    // {
      inherit (res) "roomID";
    }
    // optionalAttrs res."sendResolved" { inherit (res) "sendResolved"; }
    // {
    };
  ReceiverWebhookConfigHttpConfigAuthorizationCredentialsModule = types.submodule {
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
  mkReceiverWebhookConfigHttpConfigAuthorizationCredentials =
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
  ReceiverWebhookConfigHttpConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr ReceiverWebhookConfigHttpConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverWebhookConfigHttpConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkReceiverWebhookConfigHttpConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ReceiverWebhookConfigHttpConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr ReceiverWebhookConfigHttpConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr ReceiverWebhookConfigHttpConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkReceiverWebhookConfigHttpConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkReceiverWebhookConfigHttpConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkReceiverWebhookConfigHttpConfigBasicAuthUsername res."username";
    }
    // {
    };
  ReceiverWebhookConfigHttpConfigBasicAuthPasswordModule = types.submodule {
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
  mkReceiverWebhookConfigHttpConfigBasicAuthPassword =
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
  ReceiverWebhookConfigHttpConfigBasicAuthUsernameModule = types.submodule {
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
  mkReceiverWebhookConfigHttpConfigBasicAuthUsername =
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
  ReceiverWebhookConfigHttpConfigBearerTokenSecretModule = types.submodule {
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
  mkReceiverWebhookConfigHttpConfigBearerTokenSecret =
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
  ReceiverWebhookConfigHttpConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization header configuration for the client.\nThis is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+.";
        type = (types.nullOr ReceiverWebhookConfigHttpConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "BasicAuth for the client.\nThis is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence.";
        type = (types.nullOr ReceiverWebhookConfigHttpConfigBasicAuthModule);
        default = null;
      };
      "bearerTokenSecret" = mkOption {
        description = "The secret's key that contains the bearer token to be used by the client\nfor authentication.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.";
        type = (types.nullOr ReceiverWebhookConfigHttpConfigBearerTokenSecretModule);
        default = null;
      };
      "followRedirects" = mkOption {
        description = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "OAuth2 client credentials used to fetch a token for the targets.";
        type = (types.nullOr ReceiverWebhookConfigHttpConfigOauth2Module);
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
      "proxyURL" = mkOption {
        description = "Optional proxy URL.\n\nIf defined, this field takes precedence over `proxyUrl`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "proxyUrl" = mkOption {
        description = "`proxyURL` defines the HTTP proxy server to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration for the client.";
        type = (types.nullOr ReceiverWebhookConfigHttpConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkReceiverWebhookConfigHttpConfig =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkReceiverWebhookConfigHttpConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkReceiverWebhookConfigHttpConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs (res."bearerTokenSecret" != null) {
      "bearerTokenSecret" = mkReceiverWebhookConfigHttpConfigBearerTokenSecret res."bearerTokenSecret";
    }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) {
      "oauth2" = mkReceiverWebhookConfigHttpConfigOauth2 res."oauth2";
    }
    // {
    }
    // optionalAttrs (res."proxyConnectHeader" != { }) { inherit (res) "proxyConnectHeader"; }
    // {
    }
    // optionalAttrs res."proxyFromEnvironment" { inherit (res) "proxyFromEnvironment"; }
    // {
    }
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."proxyUrl" != null) { inherit (res) "proxyUrl"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkReceiverWebhookConfigHttpConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  ReceiverWebhookConfigHttpConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkReceiverWebhookConfigHttpConfigOauth2ClientIdConfigMap =
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
  ReceiverWebhookConfigHttpConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverWebhookConfigHttpConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverWebhookConfigHttpConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkReceiverWebhookConfigHttpConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverWebhookConfigHttpConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverWebhookConfigHttpConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  ReceiverWebhookConfigHttpConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkReceiverWebhookConfigHttpConfigOauth2ClientIdSecret =
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
  ReceiverWebhookConfigHttpConfigOauth2ClientSecretModule = types.submodule {
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
  mkReceiverWebhookConfigHttpConfigOauth2ClientSecret =
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
  ReceiverWebhookConfigHttpConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = ReceiverWebhookConfigHttpConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = ReceiverWebhookConfigHttpConfigOauth2ClientSecretModule;
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
        type = (types.nullOr ReceiverWebhookConfigHttpConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkReceiverWebhookConfigHttpConfigOauth2 =
    res:
    {
      "clientId" = mkReceiverWebhookConfigHttpConfigOauth2ClientId res."clientId";
      "clientSecret" = mkReceiverWebhookConfigHttpConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkReceiverWebhookConfigHttpConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  ReceiverWebhookConfigHttpConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverWebhookConfigHttpConfigOauth2TlsConfigCaConfigMap =
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
  ReceiverWebhookConfigHttpConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverWebhookConfigHttpConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverWebhookConfigHttpConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverWebhookConfigHttpConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverWebhookConfigHttpConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverWebhookConfigHttpConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverWebhookConfigHttpConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkReceiverWebhookConfigHttpConfigOauth2TlsConfigCaSecret =
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
  ReceiverWebhookConfigHttpConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverWebhookConfigHttpConfigOauth2TlsConfigCertConfigMap =
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
  ReceiverWebhookConfigHttpConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverWebhookConfigHttpConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverWebhookConfigHttpConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverWebhookConfigHttpConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverWebhookConfigHttpConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverWebhookConfigHttpConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverWebhookConfigHttpConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkReceiverWebhookConfigHttpConfigOauth2TlsConfigCertSecret =
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
  ReceiverWebhookConfigHttpConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkReceiverWebhookConfigHttpConfigOauth2TlsConfigKeySecret =
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
  ReceiverWebhookConfigHttpConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverWebhookConfigHttpConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverWebhookConfigHttpConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverWebhookConfigHttpConfigOauth2TlsConfigKeySecretModule);
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
  mkReceiverWebhookConfigHttpConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverWebhookConfigHttpConfigOauth2TlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverWebhookConfigHttpConfigOauth2TlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverWebhookConfigHttpConfigOauth2TlsConfigKeySecret res."keySecret";
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
  ReceiverWebhookConfigHttpConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverWebhookConfigHttpConfigTlsConfigCaConfigMap =
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
  ReceiverWebhookConfigHttpConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverWebhookConfigHttpConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverWebhookConfigHttpConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverWebhookConfigHttpConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverWebhookConfigHttpConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverWebhookConfigHttpConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverWebhookConfigHttpConfigTlsConfigCaSecretModule = types.submodule {
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
  mkReceiverWebhookConfigHttpConfigTlsConfigCaSecret =
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
  ReceiverWebhookConfigHttpConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverWebhookConfigHttpConfigTlsConfigCertConfigMap =
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
  ReceiverWebhookConfigHttpConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverWebhookConfigHttpConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverWebhookConfigHttpConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverWebhookConfigHttpConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverWebhookConfigHttpConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverWebhookConfigHttpConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverWebhookConfigHttpConfigTlsConfigCertSecretModule = types.submodule {
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
  mkReceiverWebhookConfigHttpConfigTlsConfigCertSecret =
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
  ReceiverWebhookConfigHttpConfigTlsConfigKeySecretModule = types.submodule {
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
  mkReceiverWebhookConfigHttpConfigTlsConfigKeySecret =
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
  ReceiverWebhookConfigHttpConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverWebhookConfigHttpConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverWebhookConfigHttpConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverWebhookConfigHttpConfigTlsConfigKeySecretModule);
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
  mkReceiverWebhookConfigHttpConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverWebhookConfigHttpConfigTlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverWebhookConfigHttpConfigTlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverWebhookConfigHttpConfigTlsConfigKeySecret res."keySecret";
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
  ReceiverWebhookConfigModule = types.submodule {
    options = {
      "httpConfig" = mkOption {
        description = "HTTP client configuration.";
        type = (types.nullOr ReceiverWebhookConfigHttpConfigModule);
        default = null;
      };
      "maxAlerts" = mkOption {
        description = "Maximum number of alerts to be sent per webhook message. When 0, all alerts are included.";
        type = (types.nullOr types.int);
        default = null;
      };
      "sendResolved" = mkOption {
        description = "Whether or not to notify about resolved alerts.";
        type = types.bool;
        default = false;
      };
      "timeout" = mkOption {
        description = "The maximum time to wait for a webhook request to complete, before failing the\nrequest and allowing it to be retried.\nIt requires Alertmanager >= v0.28.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "url" = mkOption {
        description = "The URL to send HTTP POST requests to. `urlSecret` takes precedence over\n`url`. One of `urlSecret` and `url` should be defined.";
        type = (types.nullOr types.str);
        default = null;
      };
      "urlSecret" = mkOption {
        description = "The secret's key that contains the webhook URL to send HTTP requests to.\n`urlSecret` takes precedence over `url`. One of `urlSecret` and `url`\nshould be defined.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.";
        type = (types.nullOr ReceiverWebhookConfigUrlSecretModule);
        default = null;
      };
    };
  };
  mkReceiverWebhookConfig =
    res:
    {
    }
    // optionalAttrs (res."httpConfig" != null) {
      "httpConfig" = mkReceiverWebhookConfigHttpConfig res."httpConfig";
    }
    // {
    }
    // optionalAttrs (res."maxAlerts" != null) { inherit (res) "maxAlerts"; }
    // {
    }
    // optionalAttrs res."sendResolved" { inherit (res) "sendResolved"; }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    }
    // optionalAttrs (res."url" != null) { inherit (res) "url"; }
    // {
    }
    // optionalAttrs (res."urlSecret" != null) {
      "urlSecret" = mkReceiverWebhookConfigUrlSecret res."urlSecret";
    }
    // {
    };
  ReceiverWebhookConfigUrlSecretModule = types.submodule {
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
  mkReceiverWebhookConfigUrlSecret =
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
  ReceiverWechatConfigApiSecretModule = types.submodule {
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
  mkReceiverWechatConfigApiSecret =
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
  ReceiverWechatConfigHttpConfigAuthorizationCredentialsModule = types.submodule {
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
  mkReceiverWechatConfigHttpConfigAuthorizationCredentials =
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
  ReceiverWechatConfigHttpConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr ReceiverWechatConfigHttpConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverWechatConfigHttpConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkReceiverWechatConfigHttpConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ReceiverWechatConfigHttpConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr ReceiverWechatConfigHttpConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr ReceiverWechatConfigHttpConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkReceiverWechatConfigHttpConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkReceiverWechatConfigHttpConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkReceiverWechatConfigHttpConfigBasicAuthUsername res."username";
    }
    // {
    };
  ReceiverWechatConfigHttpConfigBasicAuthPasswordModule = types.submodule {
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
  mkReceiverWechatConfigHttpConfigBasicAuthPassword =
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
  ReceiverWechatConfigHttpConfigBasicAuthUsernameModule = types.submodule {
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
  mkReceiverWechatConfigHttpConfigBasicAuthUsername =
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
  ReceiverWechatConfigHttpConfigBearerTokenSecretModule = types.submodule {
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
  mkReceiverWechatConfigHttpConfigBearerTokenSecret =
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
  ReceiverWechatConfigHttpConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization header configuration for the client.\nThis is mutually exclusive with BasicAuth and is only available starting from Alertmanager v0.22+.";
        type = (types.nullOr ReceiverWechatConfigHttpConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "BasicAuth for the client.\nThis is mutually exclusive with Authorization. If both are defined, BasicAuth takes precedence.";
        type = (types.nullOr ReceiverWechatConfigHttpConfigBasicAuthModule);
        default = null;
      };
      "bearerTokenSecret" = mkOption {
        description = "The secret's key that contains the bearer token to be used by the client\nfor authentication.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.";
        type = (types.nullOr ReceiverWechatConfigHttpConfigBearerTokenSecretModule);
        default = null;
      };
      "followRedirects" = mkOption {
        description = "FollowRedirects specifies whether the client should follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "OAuth2 client credentials used to fetch a token for the targets.";
        type = (types.nullOr ReceiverWechatConfigHttpConfigOauth2Module);
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
      "proxyURL" = mkOption {
        description = "Optional proxy URL.\n\nIf defined, this field takes precedence over `proxyUrl`.";
        type = (types.nullOr types.str);
        default = null;
      };
      "proxyUrl" = mkOption {
        description = "`proxyURL` defines the HTTP proxy server to use.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration for the client.";
        type = (types.nullOr ReceiverWechatConfigHttpConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkReceiverWechatConfigHttpConfig =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkReceiverWechatConfigHttpConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkReceiverWechatConfigHttpConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs (res."bearerTokenSecret" != null) {
      "bearerTokenSecret" = mkReceiverWechatConfigHttpConfigBearerTokenSecret res."bearerTokenSecret";
    }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) {
      "oauth2" = mkReceiverWechatConfigHttpConfigOauth2 res."oauth2";
    }
    // {
    }
    // optionalAttrs (res."proxyConnectHeader" != { }) { inherit (res) "proxyConnectHeader"; }
    // {
    }
    // optionalAttrs res."proxyFromEnvironment" { inherit (res) "proxyFromEnvironment"; }
    // {
    }
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."proxyUrl" != null) { inherit (res) "proxyUrl"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkReceiverWechatConfigHttpConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  ReceiverWechatConfigHttpConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkReceiverWechatConfigHttpConfigOauth2ClientIdConfigMap =
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
  ReceiverWechatConfigHttpConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverWechatConfigHttpConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverWechatConfigHttpConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkReceiverWechatConfigHttpConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverWechatConfigHttpConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverWechatConfigHttpConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  ReceiverWechatConfigHttpConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkReceiverWechatConfigHttpConfigOauth2ClientIdSecret =
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
  ReceiverWechatConfigHttpConfigOauth2ClientSecretModule = types.submodule {
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
  mkReceiverWechatConfigHttpConfigOauth2ClientSecret =
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
  ReceiverWechatConfigHttpConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = ReceiverWechatConfigHttpConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = ReceiverWechatConfigHttpConfigOauth2ClientSecretModule;
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
        type = (types.nullOr ReceiverWechatConfigHttpConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkReceiverWechatConfigHttpConfigOauth2 =
    res:
    {
      "clientId" = mkReceiverWechatConfigHttpConfigOauth2ClientId res."clientId";
      "clientSecret" = mkReceiverWechatConfigHttpConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkReceiverWechatConfigHttpConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  ReceiverWechatConfigHttpConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverWechatConfigHttpConfigOauth2TlsConfigCaConfigMap =
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
  ReceiverWechatConfigHttpConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverWechatConfigHttpConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverWechatConfigHttpConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverWechatConfigHttpConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverWechatConfigHttpConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverWechatConfigHttpConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverWechatConfigHttpConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkReceiverWechatConfigHttpConfigOauth2TlsConfigCaSecret =
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
  ReceiverWechatConfigHttpConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverWechatConfigHttpConfigOauth2TlsConfigCertConfigMap =
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
  ReceiverWechatConfigHttpConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverWechatConfigHttpConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverWechatConfigHttpConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverWechatConfigHttpConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverWechatConfigHttpConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverWechatConfigHttpConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverWechatConfigHttpConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkReceiverWechatConfigHttpConfigOauth2TlsConfigCertSecret =
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
  ReceiverWechatConfigHttpConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkReceiverWechatConfigHttpConfigOauth2TlsConfigKeySecret =
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
  ReceiverWechatConfigHttpConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverWechatConfigHttpConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverWechatConfigHttpConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverWechatConfigHttpConfigOauth2TlsConfigKeySecretModule);
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
  mkReceiverWechatConfigHttpConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverWechatConfigHttpConfigOauth2TlsConfigCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverWechatConfigHttpConfigOauth2TlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverWechatConfigHttpConfigOauth2TlsConfigKeySecret res."keySecret";
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
  ReceiverWechatConfigHttpConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkReceiverWechatConfigHttpConfigTlsConfigCaConfigMap =
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
  ReceiverWechatConfigHttpConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverWechatConfigHttpConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverWechatConfigHttpConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverWechatConfigHttpConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverWechatConfigHttpConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverWechatConfigHttpConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  ReceiverWechatConfigHttpConfigTlsConfigCaSecretModule = types.submodule {
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
  mkReceiverWechatConfigHttpConfigTlsConfigCaSecret =
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
  ReceiverWechatConfigHttpConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkReceiverWechatConfigHttpConfigTlsConfigCertConfigMap =
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
  ReceiverWechatConfigHttpConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ReceiverWechatConfigHttpConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ReceiverWechatConfigHttpConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverWechatConfigHttpConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverWechatConfigHttpConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverWechatConfigHttpConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  ReceiverWechatConfigHttpConfigTlsConfigCertSecretModule = types.submodule {
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
  mkReceiverWechatConfigHttpConfigTlsConfigCertSecret =
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
  ReceiverWechatConfigHttpConfigTlsConfigKeySecretModule = types.submodule {
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
  mkReceiverWechatConfigHttpConfigTlsConfigKeySecret =
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
  ReceiverWechatConfigHttpConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ReceiverWechatConfigHttpConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ReceiverWechatConfigHttpConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ReceiverWechatConfigHttpConfigTlsConfigKeySecretModule);
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
  mkReceiverWechatConfigHttpConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkReceiverWechatConfigHttpConfigTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverWechatConfigHttpConfigTlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkReceiverWechatConfigHttpConfigTlsConfigKeySecret res."keySecret";
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
  ReceiverWechatConfigModule = types.submodule {
    options = {
      "agentID" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "apiSecret" = mkOption {
        description = "The secret's key that contains the WeChat API key.\nThe secret needs to be in the same namespace as the AlertmanagerConfig\nobject and accessible by the Prometheus Operator.";
        type = (types.nullOr ReceiverWechatConfigApiSecretModule);
        default = null;
      };
      "apiURL" = mkOption {
        description = "The WeChat API URL.";
        type = (types.nullOr types.str);
        default = null;
      };
      "corpID" = mkOption {
        description = "The corp id for authentication.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpConfig" = mkOption {
        description = "HTTP client configuration.";
        type = (types.nullOr ReceiverWechatConfigHttpConfigModule);
        default = null;
      };
      "message" = mkOption {
        description = "API request data as defined by the WeChat API.";
        type = (types.nullOr types.str);
        default = null;
      };
      "messageType" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "sendResolved" = mkOption {
        description = "Whether or not to notify about resolved alerts.";
        type = types.bool;
        default = false;
      };
      "toParty" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "toTag" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "toUser" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverWechatConfig =
    res:
    {
    }
    // optionalAttrs (res."agentID" != null) { inherit (res) "agentID"; }
    // {
    }
    // optionalAttrs (res."apiSecret" != null) {
      "apiSecret" = mkReceiverWechatConfigApiSecret res."apiSecret";
    }
    // {
    }
    // optionalAttrs (res."apiURL" != null) { inherit (res) "apiURL"; }
    // {
    }
    // optionalAttrs (res."corpID" != null) { inherit (res) "corpID"; }
    // {
    }
    // optionalAttrs (res."httpConfig" != null) {
      "httpConfig" = mkReceiverWechatConfigHttpConfig res."httpConfig";
    }
    // {
    }
    // optionalAttrs (res."message" != null) { inherit (res) "message"; }
    // {
    }
    // optionalAttrs (res."messageType" != null) { inherit (res) "messageType"; }
    // {
    }
    // optionalAttrs res."sendResolved" { inherit (res) "sendResolved"; }
    // {
    }
    // optionalAttrs (res."toParty" != null) { inherit (res) "toParty"; }
    // {
    }
    // optionalAttrs (res."toTag" != null) { inherit (res) "toTag"; }
    // {
    }
    // optionalAttrs (res."toUser" != null) { inherit (res) "toUser"; }
    // {
    };
  RouteMatcherModule = types.submodule {
    options = {
      "matchType" = mkOption {
        description = "Match operation available with AlertManager >= v0.22.0 and\ntakes precedence over Regex (deprecated) if non-empty.";
        type = (
          types.nullOr (
            types.enum [
              "!="
              "="
              "=~"
              "!~"
            ]
          )
        );
        default = null;
      };
      "name" = mkOption {
        description = "Label to match.";
        type = types.str;
      };
      "regex" = mkOption {
        description = "Whether to match on equality (false) or regular-expression (true).\nDeprecated: for AlertManager >= v0.22.0, `matchType` should be used instead.";
        type = types.bool;
        default = false;
      };
      "value" = mkOption {
        description = "Label value to match.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkRouteMatcher =
    res:
    {
    }
    // optionalAttrs (res."matchType" != null) { inherit (res) "matchType"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs res."regex" { inherit (res) "regex"; }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  RouteModule = types.submodule {
    options = {
      "activeTimeIntervals" = mkOption {
        description = "ActiveTimeIntervals is a list of MuteTimeInterval names when this route should be active.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "continue" = mkOption {
        description = "Boolean indicating whether an alert should continue matching subsequent\nsibling nodes. It will always be overridden to true for the first-level\nroute by the Prometheus operator.";
        type = types.bool;
        default = false;
      };
      "groupBy" = mkOption {
        description = "List of labels to group by.\nLabels must not be repeated (unique list).\nSpecial label \"...\" (aggregate by all possible labels), if provided, must be the only element in the list.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "groupInterval" = mkOption {
        description = "How long to wait before sending an updated notification.\nMust match the regular expression`^(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?$`\nExample: \"5m\"";
        type = (types.nullOr types.str);
        default = null;
      };
      "groupWait" = mkOption {
        description = "How long to wait before sending the initial notification.\nMust match the regular expression`^(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?$`\nExample: \"30s\"";
        type = (types.nullOr types.str);
        default = null;
      };
      "matchers" = mkOption {
        description = "List of matchers that the alert's labels should match. For the first\nlevel route, the operator removes any existing equality and regexp\nmatcher on the `namespace` label and adds a `namespace: <object\nnamespace>` matcher.";
        type = (types.listOf RouteMatcherModule);
        default = [ ];
      };
      "muteTimeIntervals" = mkOption {
        description = "Note: this comment applies to the field definition above but appears\nbelow otherwise it gets included in the generated manifest.\nCRD schema doesn't support self-referential types for now (see\nhttps://github.com/kubernetes/kubernetes/issues/62872). We have to use\nan alternative type to circumvent the limitation. The downside is that\nthe Kube API can't validate the data beyond the fact that it is a valid\nJSON representation.\nMuteTimeIntervals is a list of MuteTimeInterval names that will mute this route when matched,";
        type = (types.listOf types.str);
        default = [ ];
      };
      "receiver" = mkOption {
        description = "Name of the receiver for this route. If not empty, it should be listed in\nthe `receivers` field.";
        type = (types.nullOr types.str);
        default = null;
      };
      "repeatInterval" = mkOption {
        description = "How long to wait before repeating the last notification.\nMust match the regular expression`^(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?$`\nExample: \"4h\"";
        type = (types.nullOr types.str);
        default = null;
      };
      "routes" = mkOption {
        description = "Child routes.";
        type = (types.listOf types.anything);
        default = [ ];
      };
    };
  };
  mkRoute =
    res:
    {
    }
    // optionalAttrs (res."activeTimeIntervals" != [ ]) { inherit (res) "activeTimeIntervals"; }
    // {
    }
    // optionalAttrs res."continue" { inherit (res) "continue"; }
    // {
    }
    // optionalAttrs (res."groupBy" != [ ]) { inherit (res) "groupBy"; }
    // {
    }
    // optionalAttrs (res."groupInterval" != null) { inherit (res) "groupInterval"; }
    // {
    }
    // optionalAttrs (res."groupWait" != null) { inherit (res) "groupWait"; }
    // {
    }
    // optionalAttrs (res."matchers" != [ ]) { "matchers" = map mkRouteMatcher res."matchers"; }
    // {
    }
    // optionalAttrs (res."muteTimeIntervals" != [ ]) { inherit (res) "muteTimeIntervals"; }
    // {
    }
    // optionalAttrs (res."receiver" != null) { inherit (res) "receiver"; }
    // {
    }
    // optionalAttrs (res."repeatInterval" != null) { inherit (res) "repeatInterval"; }
    // {
    }
    // optionalAttrs (res."routes" != [ ]) { inherit (res) "routes"; }
    // {
    };
  AlertmanagerconfigsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this AlertmanagerConfig resource.";
        };
        "inhibitRules" = mkOption {
          description = "List of inhibition rules. The rules will only apply to alerts matching\nthe resource's namespace.";
          type = (types.listOf InhibitRuleModule);
          default = [ ];
        };
        "muteTimeIntervals" = mkOption {
          description = "List of MuteTimeInterval specifying when the routes should be muted.";
          type = (types.listOf MuteTimeIntervalModule);
          default = [ ];
        };
        "receivers" = mkOption {
          description = "List of receivers.";
          type = (types.listOf ReceiverModule);
          default = [ ];
        };
        "route" = mkOption {
          description = "The Alertmanager route definition for alerts matching the resource's\nnamespace. If present, it will be added to the generated Alertmanager\nconfiguration as a first-level route.";
          type = (types.nullOr RouteModule);
          default = null;
        };
      };
    }
  );
  mkAlertmanagerConfig = name: res: {
    apiVersion = "monitoring.coreos.com/v1alpha1";
    kind = "AlertmanagerConfig";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."inhibitRules" != [ ]) {
      "inhibitRules" = map mkInhibitRule res."inhibitRules";
    }
    // {
    }
    // optionalAttrs (res."muteTimeIntervals" != [ ]) {
      "muteTimeIntervals" = map mkMuteTimeInterval res."muteTimeIntervals";
    }
    // {
    }
    // optionalAttrs (res."receivers" != [ ]) { "receivers" = map mkReceiver res."receivers"; }
    // {
    }
    // optionalAttrs (res."route" != null) { "route" = mkRoute res."route"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkAlertmanagerConfig cfg."alertmanagerconfigs");
in
{
  options.openkrill.apps."kube-prometheus" = {
    "alertmanagerconfigs" = mkOption {
      type = types.attrsOf AlertmanagerconfigsModule;
      default = { };
      description = "AlertmanagerConfig CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."kube-prometheus".content = allResources;
  };
}
