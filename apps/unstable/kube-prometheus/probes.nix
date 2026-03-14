# Auto-generated openkrill module fragment for kube-prometheus
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."kube-prometheus";
  compact = filterAttrs (_: v: v != null);
  AuthorizationCredentialsModule = types.submodule {
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
  mkAuthorizationCredentials =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  AuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr AuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  BasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr BasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr BasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) { "password" = mkBasicAuthPassword res."password"; }
    // {
    }
    // optionalAttrs (res."username" != null) { "username" = mkBasicAuthUsername res."username"; }
    // {
    };
  BasicAuthPasswordModule = types.submodule {
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
  mkBasicAuthPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  BasicAuthUsernameModule = types.submodule {
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
  mkBasicAuthUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  BearerTokenSecretModule = types.submodule {
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
  mkBearerTokenSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  MetricRelabelingModule = types.submodule {
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
  mkMetricRelabeling =
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
  Oauth2ClientIdConfigMapModule = types.submodule {
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
  mkOauth2ClientIdConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  Oauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr Oauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr Oauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkOauth2ClientIdSecret res."secret"; }
    // {
    };
  Oauth2ClientIdSecretModule = types.submodule {
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
  mkOauth2ClientIdSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  Oauth2ClientSecretModule = types.submodule {
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
  mkOauth2ClientSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  Oauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = Oauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = Oauth2ClientSecretModule;
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
        type = (types.nullOr Oauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkOauth2 =
    res:
    {
      "clientId" = mkOauth2ClientId res."clientId";
      "clientSecret" = mkOauth2ClientSecret res."clientSecret";
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
    // optionalAttrs (res."tlsConfig" != null) { "tlsConfig" = mkOauth2TlsConfig res."tlsConfig"; }
    // {
      inherit (res) "tokenUrl";
    };
  Oauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkOauth2TlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  Oauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr Oauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr Oauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkOauth2TlsConfigCaSecret res."secret"; }
    // {
    };
  Oauth2TlsConfigCaSecretModule = types.submodule {
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
  mkOauth2TlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  Oauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkOauth2TlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  Oauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr Oauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr Oauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkOauth2TlsConfigCertSecret res."secret"; }
    // {
    };
  Oauth2TlsConfigCertSecretModule = types.submodule {
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
  mkOauth2TlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  Oauth2TlsConfigKeySecretModule = types.submodule {
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
  mkOauth2TlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  Oauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr Oauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr Oauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr Oauth2TlsConfigKeySecretModule);
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
  mkOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkOauth2TlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkOauth2TlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkOauth2TlsConfigKeySecret res."keySecret";
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
  ParamModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "The parameter name";
        type = types.str;
      };
      "values" = mkOption {
        description = "The parameter values";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkParam =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  ProberModule = types.submodule {
    options = {
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "path" = mkOption {
        description = "Path to collect metrics from.\nDefaults to `/probe`.";
        type = (types.nullOr types.str);
        default = "/probe";
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
      "scheme" = mkOption {
        description = "HTTP scheme to use for scraping.\n`http` and `https` are the expected values unless you rewrite the `__scheme__` label via relabeling.\nIf empty, Prometheus uses the default value `http`.";
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
      "url" = mkOption {
        description = "Mandatory URL of the prober.";
        type = types.str;
      };
    };
  };
  mkProber =
    res:
    {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
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
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
      inherit (res) "url";
    };
  TargetsIngressModule = types.submodule {
    options = {
      "namespaceSelector" = mkOption {
        description = "From which namespaces to select Ingress objects.";
        type = (types.nullOr TargetsIngressNamespaceSelectorModule);
        default = null;
      };
      "relabelingConfigs" = mkOption {
        description = "RelabelConfigs to apply to the label set of the target before it gets\nscraped.\nThe original ingress address is available via the\n`__tmp_prometheus_ingress_address` label. It can be used to customize the\nprobed URL.\nThe original scrape job's name is available via the `__tmp_prometheus_job_name` label.\nMore info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config";
        type = (types.listOf TargetsIngressRelabelingConfigModule);
        default = [ ];
      };
      "selector" = mkOption {
        description = "Selector to select the Ingress objects.";
        type = (types.nullOr TargetsIngressSelectorModule);
        default = null;
      };
    };
  };
  mkTargetsIngress =
    res:
    {
    }
    // optionalAttrs (res."namespaceSelector" != null) {
      "namespaceSelector" = mkTargetsIngressNamespaceSelector res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."relabelingConfigs" != [ ]) {
      "relabelingConfigs" = map mkTargetsIngressRelabelingConfig res."relabelingConfigs";
    }
    // {
    }
    // optionalAttrs (res."selector" != null) { "selector" = mkTargetsIngressSelector res."selector"; }
    // {
    };
  TargetsIngressNamespaceSelectorModule = types.submodule {
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
  mkTargetsIngressNamespaceSelector =
    res:
    {
    }
    // optionalAttrs res."any" { inherit (res) "any"; }
    // {
    }
    // optionalAttrs (res."matchNames" != [ ]) { inherit (res) "matchNames"; }
    // {
    };
  TargetsIngressRelabelingConfigModule = types.submodule {
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
  mkTargetsIngressRelabelingConfig =
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
  TargetsIngressSelectorMatchExpressionModule = types.submodule {
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
  mkTargetsIngressSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  TargetsIngressSelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf TargetsIngressSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkTargetsIngressSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkTargetsIngressSelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  TargetsModule = types.submodule {
    options = {
      "ingress" = mkOption {
        description = "ingress defines the Ingress objects to probe and the relabeling\nconfiguration.\nIf `staticConfig` is also defined, `staticConfig` takes precedence.";
        type = (types.nullOr TargetsIngressModule);
        default = null;
      };
      "staticConfig" = mkOption {
        description = "staticConfig defines the static list of targets to probe and the\nrelabeling configuration.\nIf `ingress` is also defined, `staticConfig` takes precedence.\nMore info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#static_config.";
        type = (types.nullOr TargetsStaticConfigModule);
        default = null;
      };
    };
  };
  mkTargets =
    res:
    {
    }
    // optionalAttrs (res."ingress" != null) { "ingress" = mkTargetsIngress res."ingress"; }
    // {
    }
    // optionalAttrs (res."staticConfig" != null) {
      "staticConfig" = mkTargetsStaticConfig res."staticConfig";
    }
    // {
    };
  TargetsStaticConfigModule = types.submodule {
    options = {
      "labels" = mkOption {
        description = "Labels assigned to all metrics scraped from the targets.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "relabelingConfigs" = mkOption {
        description = "RelabelConfigs to apply to the label set of the targets before it gets\nscraped.\nMore info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config";
        type = (types.listOf TargetsStaticConfigRelabelingConfigModule);
        default = [ ];
      };
      "static" = mkOption {
        description = "The list of hosts to probe.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkTargetsStaticConfig =
    res:
    {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."relabelingConfigs" != [ ]) {
      "relabelingConfigs" = map mkTargetsStaticConfigRelabelingConfig res."relabelingConfigs";
    }
    // {
    }
    // optionalAttrs (res."static" != [ ]) { inherit (res) "static"; }
    // {
    };
  TargetsStaticConfigRelabelingConfigModule = types.submodule {
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
  mkTargetsStaticConfigRelabelingConfig =
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
  TlsConfigCaConfigMapModule = types.submodule {
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
  mkTlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) { "configMap" = mkTlsConfigCaConfigMap res."configMap"; }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkTlsConfigCaSecret res."secret"; }
    // {
    };
  TlsConfigCaSecretModule = types.submodule {
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
  mkTlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TlsConfigCertConfigMapModule = types.submodule {
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
  mkTlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkTlsConfigCertSecret res."secret"; }
    // {
    };
  TlsConfigCertSecretModule = types.submodule {
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
  mkTlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TlsConfigKeySecretModule = types.submodule {
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
  mkTlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr TlsConfigKeySecretModule);
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
  mkTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) { "keySecret" = mkTlsConfigKeySecret res."keySecret"; }
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
  ProbesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this Probe resource.";
        };
        "authorization" = mkOption {
          description = "Authorization section for this endpoint";
          type = (types.nullOr AuthorizationModule);
          default = null;
        };
        "basicAuth" = mkOption {
          description = "BasicAuth allow an endpoint to authenticate over basic authentication.\nMore info: https://prometheus.io/docs/operating/configuration/#endpoint";
          type = (types.nullOr BasicAuthModule);
          default = null;
        };
        "bearerTokenSecret" = mkOption {
          description = "Secret to mount to read bearer token for scraping targets. The secret\nneeds to be in the same namespace as the probe and accessible by\nthe Prometheus Operator.";
          type = (types.nullOr BearerTokenSecretModule);
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
        "interval" = mkOption {
          description = "Interval at which targets are probed using the configured prober.\nIf not specified Prometheus' global scrape interval is used.";
          type = (types.nullOr types.str);
          default = null;
        };
        "jobName" = mkOption {
          description = "The job name assigned to scraped metrics by default.";
          type = (types.nullOr types.str);
          default = null;
        };
        "keepDroppedTargets" = mkOption {
          description = "Per-scrape limit on the number of targets dropped by relabeling\nthat will be kept in memory. 0 means no limit.\n\nIt requires Prometheus >= v2.47.0.";
          type = (types.nullOr types.int);
          default = null;
        };
        "labelLimit" = mkOption {
          description = "Per-scrape limit on number of labels that will be accepted for a sample.\nOnly valid in Prometheus versions 2.27.0 and newer.";
          type = (types.nullOr types.int);
          default = null;
        };
        "labelNameLengthLimit" = mkOption {
          description = "Per-scrape limit on length of labels name that will be accepted for a sample.\nOnly valid in Prometheus versions 2.27.0 and newer.";
          type = (types.nullOr types.int);
          default = null;
        };
        "labelValueLengthLimit" = mkOption {
          description = "Per-scrape limit on length of labels value that will be accepted for a sample.\nOnly valid in Prometheus versions 2.27.0 and newer.";
          type = (types.nullOr types.int);
          default = null;
        };
        "metricRelabelings" = mkOption {
          description = "MetricRelabelConfigs to apply to samples before ingestion.";
          type = (types.listOf MetricRelabelingModule);
          default = [ ];
        };
        "module" = mkOption {
          description = "The module to use for probing specifying how to probe the target.\nExample module configuring in the blackbox exporter:\nhttps://github.com/prometheus/blackbox_exporter/blob/master/example.yml";
          type = (types.nullOr types.str);
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
        "oauth2" = mkOption {
          description = "OAuth2 for the URL. Only valid in Prometheus versions 2.27.0 and newer.";
          type = (types.nullOr Oauth2Module);
          default = null;
        };
        "params" = mkOption {
          description = "The list of HTTP query parameters for the scrape.\nPlease note that the `.spec.module` field takes precedence over the `module` parameter from this list when both are defined.\nThe module name must be added using Module under ProbeSpec.";
          type = (types.listOf ParamModule);
          default = [ ];
        };
        "prober" = mkOption {
          description = "Specification for the prober to use for probing targets.\nThe prober.URL parameter is required. Targets cannot be probed if left empty.";
          type = (types.nullOr ProberModule);
          default = null;
        };
        "sampleLimit" = mkOption {
          description = "SampleLimit defines per-scrape limit on number of scraped samples that will be accepted.";
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
        "scrapeTimeout" = mkOption {
          description = "Timeout for scraping metrics from the Prometheus exporter.\nIf not specified, the Prometheus global scrape timeout is used.\nThe value cannot be greater than the scrape interval otherwise the operator will reject the resource.";
          type = (types.nullOr types.str);
          default = null;
        };
        "targetLimit" = mkOption {
          description = "TargetLimit defines a limit on the number of scraped targets that will be accepted.";
          type = (types.nullOr types.int);
          default = null;
        };
        "targets" = mkOption {
          description = "Targets defines a set of static or dynamically discovered targets to probe.";
          type = (types.nullOr TargetsModule);
          default = null;
        };
        "tlsConfig" = mkOption {
          description = "TLS configuration to use when scraping the endpoint.";
          type = (types.nullOr TlsConfigModule);
          default = null;
        };
      };
    }
  );
  mkProbe = name: res: {
    apiVersion = "monitoring.coreos.com/v1";
    kind = "Probe";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) { "basicAuth" = mkBasicAuth res."basicAuth"; }
    // {
    }
    // optionalAttrs (res."bearerTokenSecret" != null) {
      "bearerTokenSecret" = mkBearerTokenSecret res."bearerTokenSecret";
    }
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
    // optionalAttrs (res."interval" != null) { inherit (res) "interval"; }
    // {
    }
    // optionalAttrs (res."jobName" != null) { inherit (res) "jobName"; }
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
    // optionalAttrs (res."metricRelabelings" != [ ]) {
      "metricRelabelings" = map mkMetricRelabeling res."metricRelabelings";
    }
    // {
    }
    // optionalAttrs (res."module" != null) { inherit (res) "module"; }
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
    // optionalAttrs (res."oauth2" != null) { "oauth2" = mkOauth2 res."oauth2"; }
    // {
    }
    // optionalAttrs (res."params" != [ ]) { "params" = map mkParam res."params"; }
    // {
    }
    // optionalAttrs (res."prober" != null) { "prober" = mkProber res."prober"; }
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
    }
    // optionalAttrs (res."scrapeTimeout" != null) { inherit (res) "scrapeTimeout"; }
    // {
    }
    // optionalAttrs (res."targetLimit" != null) { inherit (res) "targetLimit"; }
    // {
    }
    // optionalAttrs (res."targets" != null) { "targets" = mkTargets res."targets"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) { "tlsConfig" = mkTlsConfig res."tlsConfig"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkProbe cfg."probes");
in
{
  options.openkrill.apps."kube-prometheus" = {
    "probes" = mkOption {
      type = types.attrsOf ProbesModule;
      default = { };
      description = "Probe CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."kube-prometheus".content = allResources;
  };
}
