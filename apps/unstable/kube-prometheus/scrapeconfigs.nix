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
  AzureSDConfigAuthorizationCredentialsModule = types.submodule {
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
  mkAzureSDConfigAuthorizationCredentials =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  AzureSDConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr AzureSDConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkAzureSDConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkAzureSDConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  AzureSDConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr AzureSDConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr AzureSDConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkAzureSDConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkAzureSDConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkAzureSDConfigBasicAuthUsername res."username";
    }
    // {
    };
  AzureSDConfigBasicAuthPasswordModule = types.submodule {
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
  mkAzureSDConfigBasicAuthPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  AzureSDConfigBasicAuthUsernameModule = types.submodule {
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
  mkAzureSDConfigBasicAuthUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  AzureSDConfigClientSecretModule = types.submodule {
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
  mkAzureSDConfigClientSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  AzureSDConfigModule = types.submodule {
    options = {
      "authenticationMethod" = mkOption {
        description = "# The authentication method, either `OAuth` or `ManagedIdentity` or `SDK`.\nSee https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview\nSDK authentication method uses environment variables by default.\nSee https://learn.microsoft.com/en-us/azure/developer/go/azure-sdk-authentication";
        type = (
          types.nullOr (
            types.enum [
              "OAuth"
              "ManagedIdentity"
              "SDK"
            ]
          )
        );
        default = null;
      };
      "authorization" = mkOption {
        description = "Authorization header configuration to authenticate against the target HTTP endpoint.\nCannot be set at the same time as `oAuth2`, or `basicAuth`.";
        type = (types.nullOr AzureSDConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "BasicAuth information to authenticate against the target HTTP endpoint.\nMore info: https://prometheus.io/docs/operating/configuration/#endpoints\nCannot be set at the same time as `authorization`, or `oAuth2`.";
        type = (types.nullOr AzureSDConfigBasicAuthModule);
        default = null;
      };
      "clientID" = mkOption {
        description = "Optional client ID. Only required with the OAuth authentication method.";
        type = (types.nullOr types.str);
        default = null;
      };
      "clientSecret" = mkOption {
        description = "Optional client secret. Only required with the OAuth authentication method.";
        type = (types.nullOr AzureSDConfigClientSecretModule);
        default = null;
      };
      "enableHTTP2" = mkOption {
        description = "Whether to enable HTTP2.";
        type = types.bool;
        default = false;
      };
      "environment" = mkOption {
        description = "The Azure environment.";
        type = (types.nullOr types.str);
        default = null;
      };
      "followRedirects" = mkOption {
        description = "Configure whether HTTP requests follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "Optional OAuth 2.0 configuration to authenticate against the target HTTP endpoint.\nCannot be set at the same time as `authorization`, or `basicAuth`.";
        type = (types.nullOr AzureSDConfigOauth2Module);
        default = null;
      };
      "port" = mkOption {
        description = "The port to scrape metrics from. If using the public IP address, this must\ninstead be specified in the relabeling rule.";
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
      "refreshInterval" = mkOption {
        description = "RefreshInterval configures the refresh interval at which Prometheus will re-read the instance list.";
        type = (types.nullOr types.str);
        default = null;
      };
      "resourceGroup" = mkOption {
        description = "Optional resource group name. Limits discovery to this resource group.\nRequires  Prometheus v2.35.0 and above";
        type = (types.nullOr types.str);
        default = null;
      };
      "subscriptionID" = mkOption {
        description = "The subscription ID. Always required.";
        type = types.str;
      };
      "tenantID" = mkOption {
        description = "Optional tenant ID. Only required with the OAuth authentication method.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration applying to the target HTTP endpoint.";
        type = (types.nullOr AzureSDConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkAzureSDConfig =
    res:
    {
    }
    // optionalAttrs (res."authenticationMethod" != null) { inherit (res) "authenticationMethod"; }
    // {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkAzureSDConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkAzureSDConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs (res."clientID" != null) { inherit (res) "clientID"; }
    // {
    }
    // optionalAttrs (res."clientSecret" != null) {
      "clientSecret" = mkAzureSDConfigClientSecret res."clientSecret";
    }
    // {
    }
    // optionalAttrs res."enableHTTP2" { inherit (res) "enableHTTP2"; }
    // {
    }
    // optionalAttrs (res."environment" != null) { inherit (res) "environment"; }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) { "oauth2" = mkAzureSDConfigOauth2 res."oauth2"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
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
    // optionalAttrs (res."refreshInterval" != null) { inherit (res) "refreshInterval"; }
    // {
    }
    // optionalAttrs (res."resourceGroup" != null) { inherit (res) "resourceGroup"; }
    // {
      inherit (res) "subscriptionID";
    }
    // optionalAttrs (res."tenantID" != null) { inherit (res) "tenantID"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkAzureSDConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  AzureSDConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkAzureSDConfigOauth2ClientIdConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  AzureSDConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr AzureSDConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr AzureSDConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkAzureSDConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkAzureSDConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkAzureSDConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  AzureSDConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkAzureSDConfigOauth2ClientIdSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  AzureSDConfigOauth2ClientSecretModule = types.submodule {
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
  mkAzureSDConfigOauth2ClientSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  AzureSDConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = AzureSDConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = AzureSDConfigOauth2ClientSecretModule;
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
        type = (types.nullOr AzureSDConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkAzureSDConfigOauth2 =
    res:
    {
      "clientId" = mkAzureSDConfigOauth2ClientId res."clientId";
      "clientSecret" = mkAzureSDConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkAzureSDConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  AzureSDConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkAzureSDConfigOauth2TlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  AzureSDConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr AzureSDConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr AzureSDConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkAzureSDConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkAzureSDConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkAzureSDConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  AzureSDConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkAzureSDConfigOauth2TlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  AzureSDConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkAzureSDConfigOauth2TlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  AzureSDConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr AzureSDConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr AzureSDConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkAzureSDConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkAzureSDConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkAzureSDConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  AzureSDConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkAzureSDConfigOauth2TlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  AzureSDConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkAzureSDConfigOauth2TlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  AzureSDConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr AzureSDConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr AzureSDConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr AzureSDConfigOauth2TlsConfigKeySecretModule);
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
  mkAzureSDConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkAzureSDConfigOauth2TlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkAzureSDConfigOauth2TlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkAzureSDConfigOauth2TlsConfigKeySecret res."keySecret";
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
  AzureSDConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkAzureSDConfigTlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  AzureSDConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr AzureSDConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr AzureSDConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkAzureSDConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkAzureSDConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkAzureSDConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  AzureSDConfigTlsConfigCaSecretModule = types.submodule {
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
  mkAzureSDConfigTlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  AzureSDConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkAzureSDConfigTlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  AzureSDConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr AzureSDConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr AzureSDConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkAzureSDConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkAzureSDConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkAzureSDConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  AzureSDConfigTlsConfigCertSecretModule = types.submodule {
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
  mkAzureSDConfigTlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  AzureSDConfigTlsConfigKeySecretModule = types.submodule {
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
  mkAzureSDConfigTlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  AzureSDConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr AzureSDConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr AzureSDConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr AzureSDConfigTlsConfigKeySecretModule);
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
  mkAzureSDConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkAzureSDConfigTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkAzureSDConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkAzureSDConfigTlsConfigKeySecret res."keySecret";
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
  ConsulSDConfigAuthorizationCredentialsModule = types.submodule {
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
  mkConsulSDConfigAuthorizationCredentials =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ConsulSDConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr ConsulSDConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkConsulSDConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkConsulSDConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ConsulSDConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr ConsulSDConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr ConsulSDConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkConsulSDConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkConsulSDConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkConsulSDConfigBasicAuthUsername res."username";
    }
    // {
    };
  ConsulSDConfigBasicAuthPasswordModule = types.submodule {
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
  mkConsulSDConfigBasicAuthPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ConsulSDConfigBasicAuthUsernameModule = types.submodule {
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
  mkConsulSDConfigBasicAuthUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ConsulSDConfigModule = types.submodule {
    options = {
      "allowStale" = mkOption {
        description = "Allow stale Consul results (see https://www.consul.io/api/features/consistency.html). Will reduce load on Consul.\nIf unset, Prometheus uses its default value.";
        type = types.bool;
        default = false;
      };
      "authorization" = mkOption {
        description = "Optional Authorization header configuration to authenticate against the Consul Server.\nCannot be set at the same time as `basicAuth`, or `oauth2`.";
        type = (types.nullOr ConsulSDConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "Optional BasicAuth information to authenticate against the Consul Server.\nMore info: https://prometheus.io/docs/operating/configuration/#endpoints\nCannot be set at the same time as `authorization`, or `oauth2`.";
        type = (types.nullOr ConsulSDConfigBasicAuthModule);
        default = null;
      };
      "datacenter" = mkOption {
        description = "Consul Datacenter name, if not provided it will use the local Consul Agent Datacenter.";
        type = (types.nullOr types.str);
        default = null;
      };
      "enableHTTP2" = mkOption {
        description = "Whether to enable HTTP2.\nIf unset, Prometheus uses its default value.";
        type = types.bool;
        default = false;
      };
      "filter" = mkOption {
        description = "Filter expression used to filter the catalog results.\nSee https://www.consul.io/api-docs/catalog#list-services\nIt requires Prometheus >= 3.0.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "followRedirects" = mkOption {
        description = "Configure whether HTTP requests follow HTTP 3xx redirects.\nIf unset, Prometheus uses its default value.";
        type = types.bool;
        default = false;
      };
      "namespace" = mkOption {
        description = "Namespaces are only supported in Consul Enterprise.\n\nIt requires Prometheus >= 2.28.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "nodeMeta" = mkOption {
        description = "Node metadata key/value pairs to filter nodes for a given service.\nStarting with Consul 1.14, it is recommended to use `filter` with the `NodeMeta` selector instead.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "oauth2" = mkOption {
        description = "Optional OAuth2.0 configuration.\nCannot be set at the same time as `basicAuth`, or `authorization`.";
        type = (types.nullOr ConsulSDConfigOauth2Module);
        default = null;
      };
      "partition" = mkOption {
        description = "Admin Partitions are only supported in Consul Enterprise.";
        type = (types.nullOr types.str);
        default = null;
      };
      "pathPrefix" = mkOption {
        description = "Prefix for URIs for when consul is behind an API gateway (reverse proxy).\n\nIt requires Prometheus >= 2.45.0.";
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
      "refreshInterval" = mkOption {
        description = "The time after which the provided names are refreshed.\nOn large setup it might be a good idea to increase this value because the catalog will change all the time.\nIf unset, Prometheus uses its default value.";
        type = (types.nullOr types.str);
        default = null;
      };
      "scheme" = mkOption {
        description = "HTTP Scheme default \"http\"";
        type = (
          types.nullOr (
            types.enum [
              "HTTP"
              "HTTPS"
            ]
          )
        );
        default = null;
      };
      "server" = mkOption {
        description = "Consul server address. A valid string consisting of a hostname or IP followed by an optional port number.";
        type = types.str;
      };
      "services" = mkOption {
        description = "A list of services for which targets are retrieved. If omitted, all services are scraped.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "tagSeparator" = mkOption {
        description = "The string by which Consul tags are joined into the tag label.\nIf unset, Prometheus uses its default value.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tags" = mkOption {
        description = "An optional list of tags used to filter nodes for a given service. Services must contain all tags in the list.\nStarting with Consul 1.14, it is recommended to use `filter` with the `ServiceTags` selector instead.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration to connect to the Consul API.";
        type = (types.nullOr ConsulSDConfigTlsConfigModule);
        default = null;
      };
      "tokenRef" = mkOption {
        description = "Consul ACL TokenRef, if not provided it will use the ACL from the local Consul Agent.";
        type = (types.nullOr ConsulSDConfigTokenRefModule);
        default = null;
      };
    };
  };
  mkConsulSDConfig =
    res:
    {
    }
    // optionalAttrs res."allowStale" { inherit (res) "allowStale"; }
    // {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkConsulSDConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkConsulSDConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs (res."datacenter" != null) { inherit (res) "datacenter"; }
    // {
    }
    // optionalAttrs res."enableHTTP2" { inherit (res) "enableHTTP2"; }
    // {
    }
    // optionalAttrs (res."filter" != null) { inherit (res) "filter"; }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."nodeMeta" != { }) { inherit (res) "nodeMeta"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) { "oauth2" = mkConsulSDConfigOauth2 res."oauth2"; }
    // {
    }
    // optionalAttrs (res."partition" != null) { inherit (res) "partition"; }
    // {
    }
    // optionalAttrs (res."pathPrefix" != null) { inherit (res) "pathPrefix"; }
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
    // optionalAttrs (res."refreshInterval" != null) { inherit (res) "refreshInterval"; }
    // {
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
      inherit (res) "server";
    }
    // optionalAttrs (res."services" != [ ]) { inherit (res) "services"; }
    // {
    }
    // optionalAttrs (res."tagSeparator" != null) { inherit (res) "tagSeparator"; }
    // {
    }
    // optionalAttrs (res."tags" != [ ]) { inherit (res) "tags"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkConsulSDConfigTlsConfig res."tlsConfig";
    }
    // {
    }
    // optionalAttrs (res."tokenRef" != null) { "tokenRef" = mkConsulSDConfigTokenRef res."tokenRef"; }
    // {
    };
  ConsulSDConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkConsulSDConfigOauth2ClientIdConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ConsulSDConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ConsulSDConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ConsulSDConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkConsulSDConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkConsulSDConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkConsulSDConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  ConsulSDConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkConsulSDConfigOauth2ClientIdSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ConsulSDConfigOauth2ClientSecretModule = types.submodule {
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
  mkConsulSDConfigOauth2ClientSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ConsulSDConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = ConsulSDConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = ConsulSDConfigOauth2ClientSecretModule;
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
        type = (types.nullOr ConsulSDConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkConsulSDConfigOauth2 =
    res:
    {
      "clientId" = mkConsulSDConfigOauth2ClientId res."clientId";
      "clientSecret" = mkConsulSDConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkConsulSDConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  ConsulSDConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkConsulSDConfigOauth2TlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ConsulSDConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ConsulSDConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ConsulSDConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkConsulSDConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkConsulSDConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkConsulSDConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  ConsulSDConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkConsulSDConfigOauth2TlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ConsulSDConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkConsulSDConfigOauth2TlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ConsulSDConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ConsulSDConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ConsulSDConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkConsulSDConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkConsulSDConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkConsulSDConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  ConsulSDConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkConsulSDConfigOauth2TlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ConsulSDConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkConsulSDConfigOauth2TlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ConsulSDConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ConsulSDConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ConsulSDConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ConsulSDConfigOauth2TlsConfigKeySecretModule);
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
  mkConsulSDConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkConsulSDConfigOauth2TlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkConsulSDConfigOauth2TlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkConsulSDConfigOauth2TlsConfigKeySecret res."keySecret";
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
  ConsulSDConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkConsulSDConfigTlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ConsulSDConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ConsulSDConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ConsulSDConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkConsulSDConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkConsulSDConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkConsulSDConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  ConsulSDConfigTlsConfigCaSecretModule = types.submodule {
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
  mkConsulSDConfigTlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ConsulSDConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkConsulSDConfigTlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ConsulSDConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ConsulSDConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ConsulSDConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkConsulSDConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkConsulSDConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkConsulSDConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  ConsulSDConfigTlsConfigCertSecretModule = types.submodule {
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
  mkConsulSDConfigTlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ConsulSDConfigTlsConfigKeySecretModule = types.submodule {
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
  mkConsulSDConfigTlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ConsulSDConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ConsulSDConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ConsulSDConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ConsulSDConfigTlsConfigKeySecretModule);
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
  mkConsulSDConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkConsulSDConfigTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkConsulSDConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkConsulSDConfigTlsConfigKeySecret res."keySecret";
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
  ConsulSDConfigTokenRefModule = types.submodule {
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
  mkConsulSDConfigTokenRef =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DigitalOceanSDConfigAuthorizationCredentialsModule = types.submodule {
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
  mkDigitalOceanSDConfigAuthorizationCredentials =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DigitalOceanSDConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr DigitalOceanSDConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDigitalOceanSDConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkDigitalOceanSDConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  DigitalOceanSDConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization header configuration to authenticate against the DigitalOcean API.\nCannot be set at the same time as `oauth2`.";
        type = (types.nullOr DigitalOceanSDConfigAuthorizationModule);
        default = null;
      };
      "enableHTTP2" = mkOption {
        description = "Whether to enable HTTP2.";
        type = types.bool;
        default = false;
      };
      "followRedirects" = mkOption {
        description = "Configure whether HTTP requests follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "Optional OAuth 2.0 configuration.\nCannot be set at the same time as `authorization`.";
        type = (types.nullOr DigitalOceanSDConfigOauth2Module);
        default = null;
      };
      "port" = mkOption {
        description = "The port to scrape metrics from.";
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
      "refreshInterval" = mkOption {
        description = "Refresh interval to re-read the instance list.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration applying to the target HTTP endpoint.";
        type = (types.nullOr DigitalOceanSDConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkDigitalOceanSDConfig =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkDigitalOceanSDConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs res."enableHTTP2" { inherit (res) "enableHTTP2"; }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) { "oauth2" = mkDigitalOceanSDConfigOauth2 res."oauth2"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
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
    // optionalAttrs (res."refreshInterval" != null) { inherit (res) "refreshInterval"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkDigitalOceanSDConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  DigitalOceanSDConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkDigitalOceanSDConfigOauth2ClientIdConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DigitalOceanSDConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr DigitalOceanSDConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr DigitalOceanSDConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkDigitalOceanSDConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkDigitalOceanSDConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkDigitalOceanSDConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  DigitalOceanSDConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkDigitalOceanSDConfigOauth2ClientIdSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DigitalOceanSDConfigOauth2ClientSecretModule = types.submodule {
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
  mkDigitalOceanSDConfigOauth2ClientSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DigitalOceanSDConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = DigitalOceanSDConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = DigitalOceanSDConfigOauth2ClientSecretModule;
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
        type = (types.nullOr DigitalOceanSDConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkDigitalOceanSDConfigOauth2 =
    res:
    {
      "clientId" = mkDigitalOceanSDConfigOauth2ClientId res."clientId";
      "clientSecret" = mkDigitalOceanSDConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkDigitalOceanSDConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  DigitalOceanSDConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkDigitalOceanSDConfigOauth2TlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DigitalOceanSDConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr DigitalOceanSDConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr DigitalOceanSDConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkDigitalOceanSDConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkDigitalOceanSDConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkDigitalOceanSDConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  DigitalOceanSDConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkDigitalOceanSDConfigOauth2TlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DigitalOceanSDConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkDigitalOceanSDConfigOauth2TlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DigitalOceanSDConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr DigitalOceanSDConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr DigitalOceanSDConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkDigitalOceanSDConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkDigitalOceanSDConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkDigitalOceanSDConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  DigitalOceanSDConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkDigitalOceanSDConfigOauth2TlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DigitalOceanSDConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkDigitalOceanSDConfigOauth2TlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DigitalOceanSDConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr DigitalOceanSDConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr DigitalOceanSDConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr DigitalOceanSDConfigOauth2TlsConfigKeySecretModule);
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
  mkDigitalOceanSDConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkDigitalOceanSDConfigOauth2TlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkDigitalOceanSDConfigOauth2TlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkDigitalOceanSDConfigOauth2TlsConfigKeySecret res."keySecret";
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
  DigitalOceanSDConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkDigitalOceanSDConfigTlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DigitalOceanSDConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr DigitalOceanSDConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr DigitalOceanSDConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkDigitalOceanSDConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkDigitalOceanSDConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkDigitalOceanSDConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  DigitalOceanSDConfigTlsConfigCaSecretModule = types.submodule {
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
  mkDigitalOceanSDConfigTlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DigitalOceanSDConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkDigitalOceanSDConfigTlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DigitalOceanSDConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr DigitalOceanSDConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr DigitalOceanSDConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkDigitalOceanSDConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkDigitalOceanSDConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkDigitalOceanSDConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  DigitalOceanSDConfigTlsConfigCertSecretModule = types.submodule {
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
  mkDigitalOceanSDConfigTlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DigitalOceanSDConfigTlsConfigKeySecretModule = types.submodule {
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
  mkDigitalOceanSDConfigTlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DigitalOceanSDConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr DigitalOceanSDConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr DigitalOceanSDConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr DigitalOceanSDConfigTlsConfigKeySecretModule);
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
  mkDigitalOceanSDConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkDigitalOceanSDConfigTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkDigitalOceanSDConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkDigitalOceanSDConfigTlsConfigKeySecret res."keySecret";
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
  DnsSDConfigModule = types.submodule {
    options = {
      "names" = mkOption {
        description = "A list of DNS domain names to be queried.";
        type = (types.listOf types.str);
      };
      "port" = mkOption {
        description = "The port number used if the query type is not SRV\nIgnored for SRV records";
        type = (types.nullOr types.int);
        default = null;
      };
      "refreshInterval" = mkOption {
        description = "RefreshInterval configures the time after which the provided names are refreshed.\nIf not set, Prometheus uses its default value.";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "The type of DNS query to perform. One of SRV, A, AAAA, MX or NS.\nIf not set, Prometheus uses its default value.\n\nWhen set to NS, it requires Prometheus >= v2.49.0.\nWhen set to MX, it requires Prometheus >= v2.38.0";
        type = (
          types.nullOr (
            types.enum [
              "A"
              "AAAA"
              "MX"
              "NS"
              "SRV"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkDnsSDConfig =
    res:
    {
      inherit (res) "names";
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
    }
    // optionalAttrs (res."refreshInterval" != null) { inherit (res) "refreshInterval"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  DockerSDConfigAuthorizationCredentialsModule = types.submodule {
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
  mkDockerSDConfigAuthorizationCredentials =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSDConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr DockerSDConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDockerSDConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkDockerSDConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  DockerSDConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr DockerSDConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr DockerSDConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkDockerSDConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkDockerSDConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkDockerSDConfigBasicAuthUsername res."username";
    }
    // {
    };
  DockerSDConfigBasicAuthPasswordModule = types.submodule {
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
  mkDockerSDConfigBasicAuthPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSDConfigBasicAuthUsernameModule = types.submodule {
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
  mkDockerSDConfigBasicAuthUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSDConfigFilterModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the Filter.";
        type = types.str;
      };
      "values" = mkOption {
        description = "Value to filter on.";
        type = (types.listOf types.str);
      };
    };
  };
  mkDockerSDConfigFilter = res: {
    inherit (res) "name";
    inherit (res) "values";
  };
  DockerSDConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization header configuration to authenticate against the Docker API.\nCannot be set at the same time as `oauth2`.";
        type = (types.nullOr DockerSDConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "BasicAuth information to use on every scrape request.";
        type = (types.nullOr DockerSDConfigBasicAuthModule);
        default = null;
      };
      "enableHTTP2" = mkOption {
        description = "Whether to enable HTTP2.";
        type = types.bool;
        default = false;
      };
      "filters" = mkOption {
        description = "Optional filters to limit the discovery process to a subset of the available resources.";
        type = (types.listOf DockerSDConfigFilterModule);
        default = [ ];
      };
      "followRedirects" = mkOption {
        description = "Configure whether HTTP requests follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "host" = mkOption {
        description = "Address of the docker daemon";
        type = types.str;
      };
      "hostNetworkingHost" = mkOption {
        description = "The host to use if the container is in host networking mode.";
        type = (types.nullOr types.str);
        default = null;
      };
      "matchFirstNetwork" = mkOption {
        description = "Configure whether to match the first network if the container has multiple networks defined.\nIf unset, Prometheus uses true by default.\nIt requires Prometheus >= v2.54.1.";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "Optional OAuth 2.0 configuration.\nCannot be set at the same time as `authorization`.";
        type = (types.nullOr DockerSDConfigOauth2Module);
        default = null;
      };
      "port" = mkOption {
        description = "The port to scrape metrics from.";
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
      "refreshInterval" = mkOption {
        description = "Time after which the container is refreshed.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration applying to the target HTTP endpoint.";
        type = (types.nullOr DockerSDConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkDockerSDConfig =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkDockerSDConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkDockerSDConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs res."enableHTTP2" { inherit (res) "enableHTTP2"; }
    // {
    }
    // optionalAttrs (res."filters" != [ ]) { "filters" = map mkDockerSDConfigFilter res."filters"; }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
      inherit (res) "host";
    }
    // optionalAttrs (res."hostNetworkingHost" != null) { inherit (res) "hostNetworkingHost"; }
    // {
    }
    // optionalAttrs res."matchFirstNetwork" { inherit (res) "matchFirstNetwork"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) { "oauth2" = mkDockerSDConfigOauth2 res."oauth2"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
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
    // optionalAttrs (res."refreshInterval" != null) { inherit (res) "refreshInterval"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkDockerSDConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  DockerSDConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkDockerSDConfigOauth2ClientIdConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSDConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr DockerSDConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr DockerSDConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkDockerSDConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkDockerSDConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkDockerSDConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  DockerSDConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkDockerSDConfigOauth2ClientIdSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSDConfigOauth2ClientSecretModule = types.submodule {
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
  mkDockerSDConfigOauth2ClientSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSDConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = DockerSDConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = DockerSDConfigOauth2ClientSecretModule;
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
        type = (types.nullOr DockerSDConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkDockerSDConfigOauth2 =
    res:
    {
      "clientId" = mkDockerSDConfigOauth2ClientId res."clientId";
      "clientSecret" = mkDockerSDConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkDockerSDConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  DockerSDConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkDockerSDConfigOauth2TlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSDConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr DockerSDConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr DockerSDConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkDockerSDConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkDockerSDConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkDockerSDConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  DockerSDConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkDockerSDConfigOauth2TlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSDConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkDockerSDConfigOauth2TlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSDConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr DockerSDConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr DockerSDConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkDockerSDConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkDockerSDConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkDockerSDConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  DockerSDConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkDockerSDConfigOauth2TlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSDConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkDockerSDConfigOauth2TlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSDConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr DockerSDConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr DockerSDConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr DockerSDConfigOauth2TlsConfigKeySecretModule);
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
  mkDockerSDConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkDockerSDConfigOauth2TlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkDockerSDConfigOauth2TlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkDockerSDConfigOauth2TlsConfigKeySecret res."keySecret";
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
  DockerSDConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkDockerSDConfigTlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSDConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr DockerSDConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr DockerSDConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkDockerSDConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkDockerSDConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkDockerSDConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  DockerSDConfigTlsConfigCaSecretModule = types.submodule {
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
  mkDockerSDConfigTlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSDConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkDockerSDConfigTlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSDConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr DockerSDConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr DockerSDConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkDockerSDConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkDockerSDConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkDockerSDConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  DockerSDConfigTlsConfigCertSecretModule = types.submodule {
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
  mkDockerSDConfigTlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSDConfigTlsConfigKeySecretModule = types.submodule {
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
  mkDockerSDConfigTlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSDConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr DockerSDConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr DockerSDConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr DockerSDConfigTlsConfigKeySecretModule);
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
  mkDockerSDConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkDockerSDConfigTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkDockerSDConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkDockerSDConfigTlsConfigKeySecret res."keySecret";
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
  DockerSwarmSDConfigAuthorizationCredentialsModule = types.submodule {
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
  mkDockerSwarmSDConfigAuthorizationCredentials =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSwarmSDConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr DockerSwarmSDConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDockerSwarmSDConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkDockerSwarmSDConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  DockerSwarmSDConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr DockerSwarmSDConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr DockerSwarmSDConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkDockerSwarmSDConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkDockerSwarmSDConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkDockerSwarmSDConfigBasicAuthUsername res."username";
    }
    // {
    };
  DockerSwarmSDConfigBasicAuthPasswordModule = types.submodule {
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
  mkDockerSwarmSDConfigBasicAuthPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSwarmSDConfigBasicAuthUsernameModule = types.submodule {
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
  mkDockerSwarmSDConfigBasicAuthUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSwarmSDConfigFilterModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the Filter.";
        type = types.str;
      };
      "values" = mkOption {
        description = "Value to filter on.";
        type = (types.listOf types.str);
      };
    };
  };
  mkDockerSwarmSDConfigFilter = res: {
    inherit (res) "name";
    inherit (res) "values";
  };
  DockerSwarmSDConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization header configuration to authenticate against the target HTTP endpoint.";
        type = (types.nullOr DockerSwarmSDConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "Optional HTTP basic authentication information.";
        type = (types.nullOr DockerSwarmSDConfigBasicAuthModule);
        default = null;
      };
      "enableHTTP2" = mkOption {
        description = "Whether to enable HTTP2.";
        type = types.bool;
        default = false;
      };
      "filters" = mkOption {
        description = "Optional filters to limit the discovery process to a subset of available\nresources.\nThe available filters are listed in the upstream documentation:\nServices: https://docs.docker.com/engine/api/v1.40/#operation/ServiceList\nTasks: https://docs.docker.com/engine/api/v1.40/#operation/TaskList\nNodes: https://docs.docker.com/engine/api/v1.40/#operation/NodeList";
        type = (types.listOf DockerSwarmSDConfigFilterModule);
        default = [ ];
      };
      "followRedirects" = mkOption {
        description = "Configure whether HTTP requests follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "host" = mkOption {
        description = "Address of the Docker daemon";
        type = types.str;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "Optional OAuth 2.0 configuration.\nCannot be set at the same time as `authorization`, or `basicAuth`.";
        type = (types.nullOr DockerSwarmSDConfigOauth2Module);
        default = null;
      };
      "port" = mkOption {
        description = "The port to scrape metrics from, when `role` is nodes, and for discovered\ntasks and services that don't have published ports.";
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
      "refreshInterval" = mkOption {
        description = "The time after which the service discovery data is refreshed.";
        type = (types.nullOr types.str);
        default = null;
      };
      "role" = mkOption {
        description = "Role of the targets to retrieve. Must be `Services`, `Tasks`, or `Nodes`.";
        type = (
          types.enum [
            "Services"
            "Tasks"
            "Nodes"
          ]
        );
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration to use on every scrape request";
        type = (types.nullOr DockerSwarmSDConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkDockerSwarmSDConfig =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkDockerSwarmSDConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkDockerSwarmSDConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs res."enableHTTP2" { inherit (res) "enableHTTP2"; }
    // {
    }
    // optionalAttrs (res."filters" != [ ]) {
      "filters" = map mkDockerSwarmSDConfigFilter res."filters";
    }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
      inherit (res) "host";
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) { "oauth2" = mkDockerSwarmSDConfigOauth2 res."oauth2"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
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
    // optionalAttrs (res."refreshInterval" != null) { inherit (res) "refreshInterval"; }
    // {
      inherit (res) "role";
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkDockerSwarmSDConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  DockerSwarmSDConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkDockerSwarmSDConfigOauth2ClientIdConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSwarmSDConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr DockerSwarmSDConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr DockerSwarmSDConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkDockerSwarmSDConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkDockerSwarmSDConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkDockerSwarmSDConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  DockerSwarmSDConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkDockerSwarmSDConfigOauth2ClientIdSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSwarmSDConfigOauth2ClientSecretModule = types.submodule {
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
  mkDockerSwarmSDConfigOauth2ClientSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSwarmSDConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = DockerSwarmSDConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = DockerSwarmSDConfigOauth2ClientSecretModule;
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
        type = (types.nullOr DockerSwarmSDConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkDockerSwarmSDConfigOauth2 =
    res:
    {
      "clientId" = mkDockerSwarmSDConfigOauth2ClientId res."clientId";
      "clientSecret" = mkDockerSwarmSDConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkDockerSwarmSDConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  DockerSwarmSDConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkDockerSwarmSDConfigOauth2TlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSwarmSDConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr DockerSwarmSDConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr DockerSwarmSDConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkDockerSwarmSDConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkDockerSwarmSDConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkDockerSwarmSDConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  DockerSwarmSDConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkDockerSwarmSDConfigOauth2TlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSwarmSDConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkDockerSwarmSDConfigOauth2TlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSwarmSDConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr DockerSwarmSDConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr DockerSwarmSDConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkDockerSwarmSDConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkDockerSwarmSDConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkDockerSwarmSDConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  DockerSwarmSDConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkDockerSwarmSDConfigOauth2TlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSwarmSDConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkDockerSwarmSDConfigOauth2TlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSwarmSDConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr DockerSwarmSDConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr DockerSwarmSDConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr DockerSwarmSDConfigOauth2TlsConfigKeySecretModule);
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
  mkDockerSwarmSDConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkDockerSwarmSDConfigOauth2TlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkDockerSwarmSDConfigOauth2TlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkDockerSwarmSDConfigOauth2TlsConfigKeySecret res."keySecret";
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
  DockerSwarmSDConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkDockerSwarmSDConfigTlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSwarmSDConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr DockerSwarmSDConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr DockerSwarmSDConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkDockerSwarmSDConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkDockerSwarmSDConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkDockerSwarmSDConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  DockerSwarmSDConfigTlsConfigCaSecretModule = types.submodule {
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
  mkDockerSwarmSDConfigTlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSwarmSDConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkDockerSwarmSDConfigTlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSwarmSDConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr DockerSwarmSDConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr DockerSwarmSDConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkDockerSwarmSDConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkDockerSwarmSDConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkDockerSwarmSDConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  DockerSwarmSDConfigTlsConfigCertSecretModule = types.submodule {
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
  mkDockerSwarmSDConfigTlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSwarmSDConfigTlsConfigKeySecretModule = types.submodule {
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
  mkDockerSwarmSDConfigTlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DockerSwarmSDConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr DockerSwarmSDConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr DockerSwarmSDConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr DockerSwarmSDConfigTlsConfigKeySecretModule);
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
  mkDockerSwarmSDConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkDockerSwarmSDConfigTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkDockerSwarmSDConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkDockerSwarmSDConfigTlsConfigKeySecret res."keySecret";
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
  Ec2SDConfigAccessKeyModule = types.submodule {
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
  mkEc2SDConfigAccessKey =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  Ec2SDConfigFilterModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the Filter.";
        type = types.str;
      };
      "values" = mkOption {
        description = "Value to filter on.";
        type = (types.listOf types.str);
      };
    };
  };
  mkEc2SDConfigFilter = res: {
    inherit (res) "name";
    inherit (res) "values";
  };
  Ec2SDConfigModule = types.submodule {
    options = {
      "accessKey" = mkOption {
        description = "AccessKey is the AWS API key.";
        type = (types.nullOr Ec2SDConfigAccessKeyModule);
        default = null;
      };
      "enableHTTP2" = mkOption {
        description = "Whether to enable HTTP2.\nIt requires Prometheus >= v2.41.0";
        type = types.bool;
        default = false;
      };
      "filters" = mkOption {
        description = "Filters can be used optionally to filter the instance list by other criteria.\nAvailable filter criteria can be found here:\nhttps://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInstances.html\nFilter API documentation: https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Filter.html\nIt requires Prometheus >= v2.3.0";
        type = (types.listOf Ec2SDConfigFilterModule);
        default = [ ];
      };
      "followRedirects" = mkOption {
        description = "Configure whether HTTP requests follow HTTP 3xx redirects.\nIt requires Prometheus >= v2.41.0";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "The port to scrape metrics from. If using the public IP address, this must\ninstead be specified in the relabeling rule.";
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
      "refreshInterval" = mkOption {
        description = "RefreshInterval configures the refresh interval at which Prometheus will re-read the instance list.";
        type = (types.nullOr types.str);
        default = null;
      };
      "region" = mkOption {
        description = "The AWS region.";
        type = (types.nullOr types.str);
        default = null;
      };
      "roleARN" = mkOption {
        description = "AWS Role ARN, an alternative to using AWS API keys.";
        type = (types.nullOr types.str);
        default = null;
      };
      "secretKey" = mkOption {
        description = "SecretKey is the AWS API secret.";
        type = (types.nullOr Ec2SDConfigSecretKeyModule);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration to connect to the AWS EC2 API.\nIt requires Prometheus >= v2.41.0";
        type = (types.nullOr Ec2SDConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkEc2SDConfig =
    res:
    {
    }
    // optionalAttrs (res."accessKey" != null) { "accessKey" = mkEc2SDConfigAccessKey res."accessKey"; }
    // {
    }
    // optionalAttrs res."enableHTTP2" { inherit (res) "enableHTTP2"; }
    // {
    }
    // optionalAttrs (res."filters" != [ ]) { "filters" = map mkEc2SDConfigFilter res."filters"; }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
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
    // optionalAttrs (res."refreshInterval" != null) { inherit (res) "refreshInterval"; }
    // {
    }
    // optionalAttrs (res."region" != null) { inherit (res) "region"; }
    // {
    }
    // optionalAttrs (res."roleARN" != null) { inherit (res) "roleARN"; }
    // {
    }
    // optionalAttrs (res."secretKey" != null) { "secretKey" = mkEc2SDConfigSecretKey res."secretKey"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) { "tlsConfig" = mkEc2SDConfigTlsConfig res."tlsConfig"; }
    // {
    };
  Ec2SDConfigSecretKeyModule = types.submodule {
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
  mkEc2SDConfigSecretKey =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  Ec2SDConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkEc2SDConfigTlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  Ec2SDConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr Ec2SDConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr Ec2SDConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkEc2SDConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkEc2SDConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkEc2SDConfigTlsConfigCaSecret res."secret"; }
    // {
    };
  Ec2SDConfigTlsConfigCaSecretModule = types.submodule {
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
  mkEc2SDConfigTlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  Ec2SDConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkEc2SDConfigTlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  Ec2SDConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr Ec2SDConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr Ec2SDConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkEc2SDConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkEc2SDConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkEc2SDConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  Ec2SDConfigTlsConfigCertSecretModule = types.submodule {
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
  mkEc2SDConfigTlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  Ec2SDConfigTlsConfigKeySecretModule = types.submodule {
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
  mkEc2SDConfigTlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  Ec2SDConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr Ec2SDConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr Ec2SDConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr Ec2SDConfigTlsConfigKeySecretModule);
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
  mkEc2SDConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkEc2SDConfigTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkEc2SDConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkEc2SDConfigTlsConfigKeySecret res."keySecret";
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
  EurekaSDConfigAuthorizationCredentialsModule = types.submodule {
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
  mkEurekaSDConfigAuthorizationCredentials =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EurekaSDConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr EurekaSDConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkEurekaSDConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkEurekaSDConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  EurekaSDConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr EurekaSDConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr EurekaSDConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkEurekaSDConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkEurekaSDConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkEurekaSDConfigBasicAuthUsername res."username";
    }
    // {
    };
  EurekaSDConfigBasicAuthPasswordModule = types.submodule {
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
  mkEurekaSDConfigBasicAuthPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EurekaSDConfigBasicAuthUsernameModule = types.submodule {
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
  mkEurekaSDConfigBasicAuthUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EurekaSDConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization header to use on every scrape request.";
        type = (types.nullOr EurekaSDConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "BasicAuth information to use on every scrape request.";
        type = (types.nullOr EurekaSDConfigBasicAuthModule);
        default = null;
      };
      "enableHTTP2" = mkOption {
        description = "Whether to enable HTTP2.";
        type = types.bool;
        default = false;
      };
      "followRedirects" = mkOption {
        description = "Configure whether HTTP requests follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "Optional OAuth 2.0 configuration.\nCannot be set at the same time as `authorization` or `basic_auth`.";
        type = (types.nullOr EurekaSDConfigOauth2Module);
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
      "refreshInterval" = mkOption {
        description = "Refresh interval to re-read the instance list.";
        type = (types.nullOr types.str);
        default = null;
      };
      "server" = mkOption {
        description = "The URL to connect to the Eureka server.";
        type = types.str;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration applying to the target HTTP endpoint.";
        type = (types.nullOr EurekaSDConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkEurekaSDConfig =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkEurekaSDConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkEurekaSDConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs res."enableHTTP2" { inherit (res) "enableHTTP2"; }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) { "oauth2" = mkEurekaSDConfigOauth2 res."oauth2"; }
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
    // optionalAttrs (res."refreshInterval" != null) { inherit (res) "refreshInterval"; }
    // {
      inherit (res) "server";
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkEurekaSDConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  EurekaSDConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkEurekaSDConfigOauth2ClientIdConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EurekaSDConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr EurekaSDConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr EurekaSDConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkEurekaSDConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkEurekaSDConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkEurekaSDConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  EurekaSDConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkEurekaSDConfigOauth2ClientIdSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EurekaSDConfigOauth2ClientSecretModule = types.submodule {
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
  mkEurekaSDConfigOauth2ClientSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EurekaSDConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = EurekaSDConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = EurekaSDConfigOauth2ClientSecretModule;
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
        type = (types.nullOr EurekaSDConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkEurekaSDConfigOauth2 =
    res:
    {
      "clientId" = mkEurekaSDConfigOauth2ClientId res."clientId";
      "clientSecret" = mkEurekaSDConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkEurekaSDConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  EurekaSDConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkEurekaSDConfigOauth2TlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EurekaSDConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr EurekaSDConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr EurekaSDConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkEurekaSDConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkEurekaSDConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkEurekaSDConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  EurekaSDConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkEurekaSDConfigOauth2TlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EurekaSDConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkEurekaSDConfigOauth2TlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EurekaSDConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr EurekaSDConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr EurekaSDConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkEurekaSDConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkEurekaSDConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkEurekaSDConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  EurekaSDConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkEurekaSDConfigOauth2TlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EurekaSDConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkEurekaSDConfigOauth2TlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EurekaSDConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr EurekaSDConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr EurekaSDConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr EurekaSDConfigOauth2TlsConfigKeySecretModule);
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
  mkEurekaSDConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkEurekaSDConfigOauth2TlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkEurekaSDConfigOauth2TlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkEurekaSDConfigOauth2TlsConfigKeySecret res."keySecret";
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
  EurekaSDConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkEurekaSDConfigTlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EurekaSDConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr EurekaSDConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr EurekaSDConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkEurekaSDConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkEurekaSDConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkEurekaSDConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  EurekaSDConfigTlsConfigCaSecretModule = types.submodule {
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
  mkEurekaSDConfigTlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EurekaSDConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkEurekaSDConfigTlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EurekaSDConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr EurekaSDConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr EurekaSDConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkEurekaSDConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkEurekaSDConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkEurekaSDConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  EurekaSDConfigTlsConfigCertSecretModule = types.submodule {
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
  mkEurekaSDConfigTlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EurekaSDConfigTlsConfigKeySecretModule = types.submodule {
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
  mkEurekaSDConfigTlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EurekaSDConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr EurekaSDConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr EurekaSDConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr EurekaSDConfigTlsConfigKeySecretModule);
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
  mkEurekaSDConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkEurekaSDConfigTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkEurekaSDConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkEurekaSDConfigTlsConfigKeySecret res."keySecret";
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
  FileSDConfigModule = types.submodule {
    options = {
      "files" = mkOption {
        description = "List of files to be used for file discovery. Recommendation: use absolute paths. While relative paths work, the\nprometheus-operator project makes no guarantees about the working directory where the configuration file is\nstored.\nFiles must be mounted using Prometheus.ConfigMaps or Prometheus.Secrets.";
        type = (types.listOf types.str);
      };
      "refreshInterval" = mkOption {
        description = "RefreshInterval configures the refresh interval at which Prometheus will reload the content of the files.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkFileSDConfig =
    res:
    {
      inherit (res) "files";
    }
    // optionalAttrs (res."refreshInterval" != null) { inherit (res) "refreshInterval"; }
    // {
    };
  GceSDConfigModule = types.submodule {
    options = {
      "filter" = mkOption {
        description = "Filter can be used optionally to filter the instance list by other criteria\nSyntax of this filter is described in the filter query parameter section:\nhttps://cloud.google.com/compute/docs/reference/latest/instances/list";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "The port to scrape metrics from. If using the public IP address, this must\ninstead be specified in the relabeling rule.";
        type = (types.nullOr types.int);
        default = null;
      };
      "project" = mkOption {
        description = "The Google Cloud Project ID";
        type = types.str;
      };
      "refreshInterval" = mkOption {
        description = "RefreshInterval configures the refresh interval at which Prometheus will re-read the instance list.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tagSeparator" = mkOption {
        description = "The tag separator is used to separate the tags on concatenation";
        type = (types.nullOr types.str);
        default = null;
      };
      "zone" = mkOption {
        description = "The zone of the scrape targets. If you need multiple zones use multiple GCESDConfigs.";
        type = types.str;
      };
    };
  };
  mkGceSDConfig =
    res:
    {
    }
    // optionalAttrs (res."filter" != null) { inherit (res) "filter"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
      inherit (res) "project";
    }
    // optionalAttrs (res."refreshInterval" != null) { inherit (res) "refreshInterval"; }
    // {
    }
    // optionalAttrs (res."tagSeparator" != null) { inherit (res) "tagSeparator"; }
    // {
      inherit (res) "zone";
    };
  HetznerSDConfigAuthorizationCredentialsModule = types.submodule {
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
  mkHetznerSDConfigAuthorizationCredentials =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HetznerSDConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr HetznerSDConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkHetznerSDConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkHetznerSDConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  HetznerSDConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr HetznerSDConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr HetznerSDConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkHetznerSDConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkHetznerSDConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkHetznerSDConfigBasicAuthUsername res."username";
    }
    // {
    };
  HetznerSDConfigBasicAuthPasswordModule = types.submodule {
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
  mkHetznerSDConfigBasicAuthPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HetznerSDConfigBasicAuthUsernameModule = types.submodule {
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
  mkHetznerSDConfigBasicAuthUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HetznerSDConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization header configuration, required when role is hcloud.\nRole robot does not support bearer token authentication.";
        type = (types.nullOr HetznerSDConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "BasicAuth information to use on every scrape request, required when role is robot.\nRole hcloud does not support basic auth.";
        type = (types.nullOr HetznerSDConfigBasicAuthModule);
        default = null;
      };
      "enableHTTP2" = mkOption {
        description = "Whether to enable HTTP2.";
        type = types.bool;
        default = false;
      };
      "followRedirects" = mkOption {
        description = "Configure whether HTTP requests follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "labelSelector" = mkOption {
        description = "Label selector used to filter the servers when fetching them from the API.\nIt requires Prometheus >= v3.5.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "Optional OAuth 2.0 configuration.\nCannot be used at the same time as `basic_auth` or `authorization`.";
        type = (types.nullOr HetznerSDConfigOauth2Module);
        default = null;
      };
      "port" = mkOption {
        description = "The port to scrape metrics from.";
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
      "refreshInterval" = mkOption {
        description = "The time after which the servers are refreshed.";
        type = (types.nullOr types.str);
        default = null;
      };
      "role" = mkOption {
        description = "The Hetzner role of entities that should be discovered.";
        type = (
          types.enum [
            "hcloud"
            "Hcloud"
            "robot"
            "Robot"
          ]
        );
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration to use on every scrape request.";
        type = (types.nullOr HetznerSDConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkHetznerSDConfig =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkHetznerSDConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkHetznerSDConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs res."enableHTTP2" { inherit (res) "enableHTTP2"; }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."labelSelector" != null) { inherit (res) "labelSelector"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) { "oauth2" = mkHetznerSDConfigOauth2 res."oauth2"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
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
    // optionalAttrs (res."refreshInterval" != null) { inherit (res) "refreshInterval"; }
    // {
      inherit (res) "role";
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkHetznerSDConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  HetznerSDConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkHetznerSDConfigOauth2ClientIdConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HetznerSDConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr HetznerSDConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr HetznerSDConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkHetznerSDConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkHetznerSDConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkHetznerSDConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  HetznerSDConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkHetznerSDConfigOauth2ClientIdSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HetznerSDConfigOauth2ClientSecretModule = types.submodule {
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
  mkHetznerSDConfigOauth2ClientSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HetznerSDConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = HetznerSDConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = HetznerSDConfigOauth2ClientSecretModule;
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
        type = (types.nullOr HetznerSDConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkHetznerSDConfigOauth2 =
    res:
    {
      "clientId" = mkHetznerSDConfigOauth2ClientId res."clientId";
      "clientSecret" = mkHetznerSDConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkHetznerSDConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  HetznerSDConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkHetznerSDConfigOauth2TlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HetznerSDConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr HetznerSDConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr HetznerSDConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkHetznerSDConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkHetznerSDConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkHetznerSDConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  HetznerSDConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkHetznerSDConfigOauth2TlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HetznerSDConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkHetznerSDConfigOauth2TlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HetznerSDConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr HetznerSDConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr HetznerSDConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkHetznerSDConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkHetznerSDConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkHetznerSDConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  HetznerSDConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkHetznerSDConfigOauth2TlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HetznerSDConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkHetznerSDConfigOauth2TlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HetznerSDConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr HetznerSDConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr HetznerSDConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr HetznerSDConfigOauth2TlsConfigKeySecretModule);
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
  mkHetznerSDConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkHetznerSDConfigOauth2TlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkHetznerSDConfigOauth2TlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkHetznerSDConfigOauth2TlsConfigKeySecret res."keySecret";
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
  HetznerSDConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkHetznerSDConfigTlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HetznerSDConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr HetznerSDConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr HetznerSDConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkHetznerSDConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkHetznerSDConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkHetznerSDConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  HetznerSDConfigTlsConfigCaSecretModule = types.submodule {
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
  mkHetznerSDConfigTlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HetznerSDConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkHetznerSDConfigTlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HetznerSDConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr HetznerSDConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr HetznerSDConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkHetznerSDConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkHetznerSDConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkHetznerSDConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  HetznerSDConfigTlsConfigCertSecretModule = types.submodule {
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
  mkHetznerSDConfigTlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HetznerSDConfigTlsConfigKeySecretModule = types.submodule {
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
  mkHetznerSDConfigTlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HetznerSDConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr HetznerSDConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr HetznerSDConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr HetznerSDConfigTlsConfigKeySecretModule);
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
  mkHetznerSDConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkHetznerSDConfigTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkHetznerSDConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkHetznerSDConfigTlsConfigKeySecret res."keySecret";
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
  HttpSDConfigAuthorizationCredentialsModule = types.submodule {
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
  mkHttpSDConfigAuthorizationCredentials =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HttpSDConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr HttpSDConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkHttpSDConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkHttpSDConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  HttpSDConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr HttpSDConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr HttpSDConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkHttpSDConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkHttpSDConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkHttpSDConfigBasicAuthUsername res."username";
    }
    // {
    };
  HttpSDConfigBasicAuthPasswordModule = types.submodule {
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
  mkHttpSDConfigBasicAuthPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HttpSDConfigBasicAuthUsernameModule = types.submodule {
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
  mkHttpSDConfigBasicAuthUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HttpSDConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization header configuration to authenticate against the target HTTP endpoint.\nCannot be set at the same time as `oAuth2`, or `basicAuth`.";
        type = (types.nullOr HttpSDConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "BasicAuth information to authenticate against the target HTTP endpoint.\nMore info: https://prometheus.io/docs/operating/configuration/#endpoints\nCannot be set at the same time as `authorization`, or `oAuth2`.";
        type = (types.nullOr HttpSDConfigBasicAuthModule);
        default = null;
      };
      "enableHTTP2" = mkOption {
        description = "Whether to enable HTTP2.";
        type = types.bool;
        default = false;
      };
      "followRedirects" = mkOption {
        description = "Configure whether HTTP requests follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "Optional OAuth 2.0 configuration to authenticate against the target HTTP endpoint.\nCannot be set at the same time as `authorization`, or `basicAuth`.";
        type = (types.nullOr HttpSDConfigOauth2Module);
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
      "refreshInterval" = mkOption {
        description = "RefreshInterval configures the refresh interval at which Prometheus will re-query the\nendpoint to update the target list.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration applying to the target HTTP endpoint.";
        type = (types.nullOr HttpSDConfigTlsConfigModule);
        default = null;
      };
      "url" = mkOption {
        description = "URL from which the targets are fetched.";
        type = types.str;
      };
    };
  };
  mkHttpSDConfig =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkHttpSDConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkHttpSDConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs res."enableHTTP2" { inherit (res) "enableHTTP2"; }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) { "oauth2" = mkHttpSDConfigOauth2 res."oauth2"; }
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
    // optionalAttrs (res."refreshInterval" != null) { inherit (res) "refreshInterval"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkHttpSDConfigTlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "url";
    };
  HttpSDConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkHttpSDConfigOauth2ClientIdConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HttpSDConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr HttpSDConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr HttpSDConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkHttpSDConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkHttpSDConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkHttpSDConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  HttpSDConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkHttpSDConfigOauth2ClientIdSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HttpSDConfigOauth2ClientSecretModule = types.submodule {
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
  mkHttpSDConfigOauth2ClientSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HttpSDConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = HttpSDConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = HttpSDConfigOauth2ClientSecretModule;
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
        type = (types.nullOr HttpSDConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkHttpSDConfigOauth2 =
    res:
    {
      "clientId" = mkHttpSDConfigOauth2ClientId res."clientId";
      "clientSecret" = mkHttpSDConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkHttpSDConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  HttpSDConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkHttpSDConfigOauth2TlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HttpSDConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr HttpSDConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr HttpSDConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkHttpSDConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkHttpSDConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkHttpSDConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  HttpSDConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkHttpSDConfigOauth2TlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HttpSDConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkHttpSDConfigOauth2TlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HttpSDConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr HttpSDConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr HttpSDConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkHttpSDConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkHttpSDConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkHttpSDConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  HttpSDConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkHttpSDConfigOauth2TlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HttpSDConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkHttpSDConfigOauth2TlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HttpSDConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr HttpSDConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr HttpSDConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr HttpSDConfigOauth2TlsConfigKeySecretModule);
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
  mkHttpSDConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkHttpSDConfigOauth2TlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkHttpSDConfigOauth2TlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkHttpSDConfigOauth2TlsConfigKeySecret res."keySecret";
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
  HttpSDConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkHttpSDConfigTlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HttpSDConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr HttpSDConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr HttpSDConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkHttpSDConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkHttpSDConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkHttpSDConfigTlsConfigCaSecret res."secret"; }
    // {
    };
  HttpSDConfigTlsConfigCaSecretModule = types.submodule {
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
  mkHttpSDConfigTlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HttpSDConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkHttpSDConfigTlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HttpSDConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr HttpSDConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr HttpSDConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkHttpSDConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkHttpSDConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkHttpSDConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  HttpSDConfigTlsConfigCertSecretModule = types.submodule {
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
  mkHttpSDConfigTlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HttpSDConfigTlsConfigKeySecretModule = types.submodule {
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
  mkHttpSDConfigTlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HttpSDConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr HttpSDConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr HttpSDConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr HttpSDConfigTlsConfigKeySecretModule);
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
  mkHttpSDConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkHttpSDConfigTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkHttpSDConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkHttpSDConfigTlsConfigKeySecret res."keySecret";
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
  IonosSDConfigAuthorizationCredentialsModule = types.submodule {
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
  mkIonosSDConfigAuthorizationCredentials =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  IonosSDConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr IonosSDConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkIonosSDConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkIonosSDConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  IonosSDConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization` header configuration, required when using IONOS.";
        type = IonosSDConfigAuthorizationModule;
      };
      "datacenterID" = mkOption {
        description = "The unique ID of the IONOS data center.";
        type = types.str;
      };
      "enableHTTP2" = mkOption {
        description = "Configure whether to enable HTTP2.";
        type = types.bool;
        default = false;
      };
      "followRedirects" = mkOption {
        description = "Configure whether the HTTP requests should follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "Configure whether to enable OAuth2.";
        type = (types.nullOr IonosSDConfigOauth2Module);
        default = null;
      };
      "port" = mkOption {
        description = "Port to scrape the metrics from.";
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
      "refreshInterval" = mkOption {
        description = "Refresh interval to re-read the list of resources.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration to use when connecting to the IONOS API.";
        type = (types.nullOr IonosSDConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkIonosSDConfig =
    res:
    {
      "authorization" = mkIonosSDConfigAuthorization res."authorization";
      inherit (res) "datacenterID";
    }
    // optionalAttrs res."enableHTTP2" { inherit (res) "enableHTTP2"; }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) { "oauth2" = mkIonosSDConfigOauth2 res."oauth2"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
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
    // optionalAttrs (res."refreshInterval" != null) { inherit (res) "refreshInterval"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkIonosSDConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  IonosSDConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkIonosSDConfigOauth2ClientIdConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  IonosSDConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr IonosSDConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr IonosSDConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkIonosSDConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkIonosSDConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkIonosSDConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  IonosSDConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkIonosSDConfigOauth2ClientIdSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  IonosSDConfigOauth2ClientSecretModule = types.submodule {
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
  mkIonosSDConfigOauth2ClientSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  IonosSDConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = IonosSDConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = IonosSDConfigOauth2ClientSecretModule;
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
        type = (types.nullOr IonosSDConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkIonosSDConfigOauth2 =
    res:
    {
      "clientId" = mkIonosSDConfigOauth2ClientId res."clientId";
      "clientSecret" = mkIonosSDConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkIonosSDConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  IonosSDConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkIonosSDConfigOauth2TlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  IonosSDConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr IonosSDConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr IonosSDConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkIonosSDConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkIonosSDConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkIonosSDConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  IonosSDConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkIonosSDConfigOauth2TlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  IonosSDConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkIonosSDConfigOauth2TlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  IonosSDConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr IonosSDConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr IonosSDConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkIonosSDConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkIonosSDConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkIonosSDConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  IonosSDConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkIonosSDConfigOauth2TlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  IonosSDConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkIonosSDConfigOauth2TlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  IonosSDConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr IonosSDConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr IonosSDConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr IonosSDConfigOauth2TlsConfigKeySecretModule);
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
  mkIonosSDConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkIonosSDConfigOauth2TlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkIonosSDConfigOauth2TlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkIonosSDConfigOauth2TlsConfigKeySecret res."keySecret";
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
  IonosSDConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkIonosSDConfigTlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  IonosSDConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr IonosSDConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr IonosSDConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkIonosSDConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkIonosSDConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkIonosSDConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  IonosSDConfigTlsConfigCaSecretModule = types.submodule {
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
  mkIonosSDConfigTlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  IonosSDConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkIonosSDConfigTlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  IonosSDConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr IonosSDConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr IonosSDConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkIonosSDConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkIonosSDConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkIonosSDConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  IonosSDConfigTlsConfigCertSecretModule = types.submodule {
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
  mkIonosSDConfigTlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  IonosSDConfigTlsConfigKeySecretModule = types.submodule {
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
  mkIonosSDConfigTlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  IonosSDConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr IonosSDConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr IonosSDConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr IonosSDConfigTlsConfigKeySecretModule);
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
  mkIonosSDConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkIonosSDConfigTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkIonosSDConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkIonosSDConfigTlsConfigKeySecret res."keySecret";
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
  KubernetesSDConfigAttachMetadataModule = types.submodule {
    options = {
      "node" = mkOption {
        description = "Attaches node metadata to discovered targets.\nWhen set to true, Prometheus must have the `get` permission on the\n`Nodes` objects.\nOnly valid for Pod, Endpoint and Endpointslice roles.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkKubernetesSDConfigAttachMetadata =
    res:
    {
    }
    // optionalAttrs res."node" { inherit (res) "node"; }
    // {
    };
  KubernetesSDConfigAuthorizationCredentialsModule = types.submodule {
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
  mkKubernetesSDConfigAuthorizationCredentials =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KubernetesSDConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr KubernetesSDConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkKubernetesSDConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkKubernetesSDConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  KubernetesSDConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr KubernetesSDConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr KubernetesSDConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkKubernetesSDConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkKubernetesSDConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkKubernetesSDConfigBasicAuthUsername res."username";
    }
    // {
    };
  KubernetesSDConfigBasicAuthPasswordModule = types.submodule {
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
  mkKubernetesSDConfigBasicAuthPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KubernetesSDConfigBasicAuthUsernameModule = types.submodule {
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
  mkKubernetesSDConfigBasicAuthUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KubernetesSDConfigModule = types.submodule {
    options = {
      "apiServer" = mkOption {
        description = "The API server address consisting of a hostname or IP address followed\nby an optional port number.\nIf left empty, Prometheus is assumed to run inside\nof the cluster. It will discover API servers automatically and use the pod's\nCA certificate and bearer token file at /var/run/secrets/kubernetes.io/serviceaccount/.";
        type = (types.nullOr types.str);
        default = null;
      };
      "attachMetadata" = mkOption {
        description = "Optional metadata to attach to discovered targets.\nIt requires Prometheus >= v2.35.0 when using the `Pod` role and\nPrometheus >= v2.37.0 for `Endpoints` and `Endpointslice` roles.";
        type = (types.nullOr KubernetesSDConfigAttachMetadataModule);
        default = null;
      };
      "authorization" = mkOption {
        description = "Authorization header to use on every scrape request.\nCannot be set at the same time as `basicAuth`, or `oauth2`.";
        type = (types.nullOr KubernetesSDConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "BasicAuth information to use on every scrape request.\nCannot be set at the same time as `authorization`, or `oauth2`.";
        type = (types.nullOr KubernetesSDConfigBasicAuthModule);
        default = null;
      };
      "enableHTTP2" = mkOption {
        description = "Whether to enable HTTP2.";
        type = types.bool;
        default = false;
      };
      "followRedirects" = mkOption {
        description = "Configure whether HTTP requests follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "namespaces" = mkOption {
        description = "Optional namespace discovery. If omitted, Prometheus discovers targets across all namespaces.";
        type = (types.nullOr KubernetesSDConfigNamespacesModule);
        default = null;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "Optional OAuth 2.0 configuration.\nCannot be set at the same time as `authorization`, or `basicAuth`.";
        type = (types.nullOr KubernetesSDConfigOauth2Module);
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
      "role" = mkOption {
        description = "Role of the Kubernetes entities that should be discovered.\nRole `Endpointslice` requires Prometheus >= v2.21.0";
        type = (
          types.enum [
            "Pod"
            "Endpoints"
            "Ingress"
            "Service"
            "Node"
            "EndpointSlice"
          ]
        );
      };
      "selectors" = mkOption {
        description = "Selector to select objects.\nIt requires Prometheus >= v2.17.0";
        type = (types.listOf KubernetesSDConfigSelectorModule);
        default = [ ];
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration to connect to the Kubernetes API.";
        type = (types.nullOr KubernetesSDConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkKubernetesSDConfig =
    res:
    {
    }
    // optionalAttrs (res."apiServer" != null) { inherit (res) "apiServer"; }
    // {
    }
    // optionalAttrs (res."attachMetadata" != null) {
      "attachMetadata" = mkKubernetesSDConfigAttachMetadata res."attachMetadata";
    }
    // {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkKubernetesSDConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkKubernetesSDConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs res."enableHTTP2" { inherit (res) "enableHTTP2"; }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."namespaces" != null) {
      "namespaces" = mkKubernetesSDConfigNamespaces res."namespaces";
    }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) { "oauth2" = mkKubernetesSDConfigOauth2 res."oauth2"; }
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
      inherit (res) "role";
    }
    // optionalAttrs (res."selectors" != [ ]) {
      "selectors" = map mkKubernetesSDConfigSelector res."selectors";
    }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkKubernetesSDConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  KubernetesSDConfigNamespacesModule = types.submodule {
    options = {
      "names" = mkOption {
        description = "List of namespaces where to watch for resources.\nIf empty and `ownNamespace` isn't true, Prometheus watches for resources in all namespaces.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "ownNamespace" = mkOption {
        description = "Includes the namespace in which the Prometheus pod runs to the list of watched namespaces.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkKubernetesSDConfigNamespaces =
    res:
    {
    }
    // optionalAttrs (res."names" != [ ]) { inherit (res) "names"; }
    // {
    }
    // optionalAttrs res."ownNamespace" { inherit (res) "ownNamespace"; }
    // {
    };
  KubernetesSDConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkKubernetesSDConfigOauth2ClientIdConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KubernetesSDConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr KubernetesSDConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr KubernetesSDConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkKubernetesSDConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkKubernetesSDConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkKubernetesSDConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  KubernetesSDConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkKubernetesSDConfigOauth2ClientIdSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KubernetesSDConfigOauth2ClientSecretModule = types.submodule {
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
  mkKubernetesSDConfigOauth2ClientSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KubernetesSDConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = KubernetesSDConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = KubernetesSDConfigOauth2ClientSecretModule;
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
        type = (types.nullOr KubernetesSDConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkKubernetesSDConfigOauth2 =
    res:
    {
      "clientId" = mkKubernetesSDConfigOauth2ClientId res."clientId";
      "clientSecret" = mkKubernetesSDConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkKubernetesSDConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  KubernetesSDConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkKubernetesSDConfigOauth2TlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KubernetesSDConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr KubernetesSDConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr KubernetesSDConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkKubernetesSDConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkKubernetesSDConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkKubernetesSDConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  KubernetesSDConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkKubernetesSDConfigOauth2TlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KubernetesSDConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkKubernetesSDConfigOauth2TlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KubernetesSDConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr KubernetesSDConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr KubernetesSDConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkKubernetesSDConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkKubernetesSDConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkKubernetesSDConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  KubernetesSDConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkKubernetesSDConfigOauth2TlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KubernetesSDConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkKubernetesSDConfigOauth2TlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KubernetesSDConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr KubernetesSDConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr KubernetesSDConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr KubernetesSDConfigOauth2TlsConfigKeySecretModule);
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
  mkKubernetesSDConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkKubernetesSDConfigOauth2TlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkKubernetesSDConfigOauth2TlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkKubernetesSDConfigOauth2TlsConfigKeySecret res."keySecret";
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
  KubernetesSDConfigSelectorModule = types.submodule {
    options = {
      "field" = mkOption {
        description = "An optional field selector to limit the service discovery to resources which have fields with specific values.\ne.g: `metadata.name=foobar`";
        type = (types.nullOr types.str);
        default = null;
      };
      "label" = mkOption {
        description = "An optional label selector to limit the service discovery to resources with specific labels and label values.\ne.g: `node.kubernetes.io/instance-type=master`";
        type = (types.nullOr types.str);
        default = null;
      };
      "role" = mkOption {
        description = "Role specifies the type of Kubernetes resource to limit the service discovery to.\nAccepted values are: Node, Pod, Endpoints, EndpointSlice, Service, Ingress.";
        type = (
          types.enum [
            "Pod"
            "Endpoints"
            "Ingress"
            "Service"
            "Node"
            "EndpointSlice"
          ]
        );
      };
    };
  };
  mkKubernetesSDConfigSelector =
    res:
    {
    }
    // optionalAttrs (res."field" != null) { inherit (res) "field"; }
    // {
    }
    // optionalAttrs (res."label" != null) { inherit (res) "label"; }
    // {
      inherit (res) "role";
    };
  KubernetesSDConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkKubernetesSDConfigTlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KubernetesSDConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr KubernetesSDConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr KubernetesSDConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkKubernetesSDConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkKubernetesSDConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkKubernetesSDConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  KubernetesSDConfigTlsConfigCaSecretModule = types.submodule {
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
  mkKubernetesSDConfigTlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KubernetesSDConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkKubernetesSDConfigTlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KubernetesSDConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr KubernetesSDConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr KubernetesSDConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkKubernetesSDConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkKubernetesSDConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkKubernetesSDConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  KubernetesSDConfigTlsConfigCertSecretModule = types.submodule {
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
  mkKubernetesSDConfigTlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KubernetesSDConfigTlsConfigKeySecretModule = types.submodule {
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
  mkKubernetesSDConfigTlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KubernetesSDConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr KubernetesSDConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr KubernetesSDConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr KubernetesSDConfigTlsConfigKeySecretModule);
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
  mkKubernetesSDConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkKubernetesSDConfigTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkKubernetesSDConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkKubernetesSDConfigTlsConfigKeySecret res."keySecret";
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
  KumaSDConfigAuthorizationCredentialsModule = types.submodule {
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
  mkKumaSDConfigAuthorizationCredentials =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KumaSDConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr KumaSDConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkKumaSDConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkKumaSDConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  KumaSDConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr KumaSDConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr KumaSDConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkKumaSDConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkKumaSDConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkKumaSDConfigBasicAuthUsername res."username";
    }
    // {
    };
  KumaSDConfigBasicAuthPasswordModule = types.submodule {
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
  mkKumaSDConfigBasicAuthPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KumaSDConfigBasicAuthUsernameModule = types.submodule {
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
  mkKumaSDConfigBasicAuthUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KumaSDConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization header to use on every scrape request.";
        type = (types.nullOr KumaSDConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "BasicAuth information to use on every scrape request.";
        type = (types.nullOr KumaSDConfigBasicAuthModule);
        default = null;
      };
      "clientID" = mkOption {
        description = "Client id is used by Kuma Control Plane to compute Monitoring Assignment for specific Prometheus backend.";
        type = (types.nullOr types.str);
        default = null;
      };
      "enableHTTP2" = mkOption {
        description = "Whether to enable HTTP2.";
        type = types.bool;
        default = false;
      };
      "fetchTimeout" = mkOption {
        description = "The time after which the monitoring assignments are refreshed.";
        type = (types.nullOr types.str);
        default = null;
      };
      "followRedirects" = mkOption {
        description = "Configure whether HTTP requests follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "Optional OAuth 2.0 configuration.\nCannot be set at the same time as `authorization`, or `basicAuth`.";
        type = (types.nullOr KumaSDConfigOauth2Module);
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
      "refreshInterval" = mkOption {
        description = "The time to wait between polling update requests.";
        type = (types.nullOr types.str);
        default = null;
      };
      "server" = mkOption {
        description = "Address of the Kuma Control Plane's MADS xDS server.";
        type = types.str;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration to use on every scrape request";
        type = (types.nullOr KumaSDConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkKumaSDConfig =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkKumaSDConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkKumaSDConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs (res."clientID" != null) { inherit (res) "clientID"; }
    // {
    }
    // optionalAttrs res."enableHTTP2" { inherit (res) "enableHTTP2"; }
    // {
    }
    // optionalAttrs (res."fetchTimeout" != null) { inherit (res) "fetchTimeout"; }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) { "oauth2" = mkKumaSDConfigOauth2 res."oauth2"; }
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
    // optionalAttrs (res."refreshInterval" != null) { inherit (res) "refreshInterval"; }
    // {
      inherit (res) "server";
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkKumaSDConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  KumaSDConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkKumaSDConfigOauth2ClientIdConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KumaSDConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr KumaSDConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr KumaSDConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkKumaSDConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkKumaSDConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkKumaSDConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  KumaSDConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkKumaSDConfigOauth2ClientIdSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KumaSDConfigOauth2ClientSecretModule = types.submodule {
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
  mkKumaSDConfigOauth2ClientSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KumaSDConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = KumaSDConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = KumaSDConfigOauth2ClientSecretModule;
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
        type = (types.nullOr KumaSDConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkKumaSDConfigOauth2 =
    res:
    {
      "clientId" = mkKumaSDConfigOauth2ClientId res."clientId";
      "clientSecret" = mkKumaSDConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkKumaSDConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  KumaSDConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkKumaSDConfigOauth2TlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KumaSDConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr KumaSDConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr KumaSDConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkKumaSDConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkKumaSDConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkKumaSDConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  KumaSDConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkKumaSDConfigOauth2TlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KumaSDConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkKumaSDConfigOauth2TlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KumaSDConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr KumaSDConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr KumaSDConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkKumaSDConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkKumaSDConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkKumaSDConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  KumaSDConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkKumaSDConfigOauth2TlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KumaSDConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkKumaSDConfigOauth2TlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KumaSDConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr KumaSDConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr KumaSDConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr KumaSDConfigOauth2TlsConfigKeySecretModule);
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
  mkKumaSDConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkKumaSDConfigOauth2TlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkKumaSDConfigOauth2TlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkKumaSDConfigOauth2TlsConfigKeySecret res."keySecret";
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
  KumaSDConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkKumaSDConfigTlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KumaSDConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr KumaSDConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr KumaSDConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkKumaSDConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkKumaSDConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkKumaSDConfigTlsConfigCaSecret res."secret"; }
    // {
    };
  KumaSDConfigTlsConfigCaSecretModule = types.submodule {
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
  mkKumaSDConfigTlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KumaSDConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkKumaSDConfigTlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KumaSDConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr KumaSDConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr KumaSDConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkKumaSDConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkKumaSDConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkKumaSDConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  KumaSDConfigTlsConfigCertSecretModule = types.submodule {
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
  mkKumaSDConfigTlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KumaSDConfigTlsConfigKeySecretModule = types.submodule {
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
  mkKumaSDConfigTlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KumaSDConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr KumaSDConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr KumaSDConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr KumaSDConfigTlsConfigKeySecretModule);
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
  mkKumaSDConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkKumaSDConfigTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkKumaSDConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkKumaSDConfigTlsConfigKeySecret res."keySecret";
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
  LightSailSDConfigAccessKeyModule = types.submodule {
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
  mkLightSailSDConfigAccessKey =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LightSailSDConfigAuthorizationCredentialsModule = types.submodule {
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
  mkLightSailSDConfigAuthorizationCredentials =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LightSailSDConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr LightSailSDConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkLightSailSDConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkLightSailSDConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  LightSailSDConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr LightSailSDConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr LightSailSDConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkLightSailSDConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkLightSailSDConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkLightSailSDConfigBasicAuthUsername res."username";
    }
    // {
    };
  LightSailSDConfigBasicAuthPasswordModule = types.submodule {
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
  mkLightSailSDConfigBasicAuthPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LightSailSDConfigBasicAuthUsernameModule = types.submodule {
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
  mkLightSailSDConfigBasicAuthUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LightSailSDConfigModule = types.submodule {
    options = {
      "accessKey" = mkOption {
        description = "AccessKey is the AWS API key.";
        type = (types.nullOr LightSailSDConfigAccessKeyModule);
        default = null;
      };
      "authorization" = mkOption {
        description = "Optional `authorization` HTTP header configuration.\nCannot be set at the same time as `basicAuth`, or `oauth2`.";
        type = (types.nullOr LightSailSDConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "Optional HTTP basic authentication information.\nCannot be set at the same time as `authorization`, or `oauth2`.";
        type = (types.nullOr LightSailSDConfigBasicAuthModule);
        default = null;
      };
      "enableHTTP2" = mkOption {
        description = "Configure whether to enable HTTP2.";
        type = types.bool;
        default = false;
      };
      "endpoint" = mkOption {
        description = "Custom endpoint to be used.";
        type = (types.nullOr types.str);
        default = null;
      };
      "followRedirects" = mkOption {
        description = "Configure whether the HTTP requests should follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "Optional OAuth2.0 configuration.\nCannot be set at the same time as `basicAuth`, or `authorization`.";
        type = (types.nullOr LightSailSDConfigOauth2Module);
        default = null;
      };
      "port" = mkOption {
        description = "Port to scrape the metrics from.\nIf using the public IP address, this must instead be specified in the relabeling rule.";
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
      "refreshInterval" = mkOption {
        description = "Refresh interval to re-read the list of instances.";
        type = (types.nullOr types.str);
        default = null;
      };
      "region" = mkOption {
        description = "The AWS region.";
        type = (types.nullOr types.str);
        default = null;
      };
      "roleARN" = mkOption {
        description = "AWS Role ARN, an alternative to using AWS API keys.";
        type = (types.nullOr types.str);
        default = null;
      };
      "secretKey" = mkOption {
        description = "SecretKey is the AWS API secret.";
        type = (types.nullOr LightSailSDConfigSecretKeyModule);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration to connect to the Puppet DB.";
        type = (types.nullOr LightSailSDConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkLightSailSDConfig =
    res:
    {
    }
    // optionalAttrs (res."accessKey" != null) {
      "accessKey" = mkLightSailSDConfigAccessKey res."accessKey";
    }
    // {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkLightSailSDConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkLightSailSDConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs res."enableHTTP2" { inherit (res) "enableHTTP2"; }
    // {
    }
    // optionalAttrs (res."endpoint" != null) { inherit (res) "endpoint"; }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) { "oauth2" = mkLightSailSDConfigOauth2 res."oauth2"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
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
    // optionalAttrs (res."refreshInterval" != null) { inherit (res) "refreshInterval"; }
    // {
    }
    // optionalAttrs (res."region" != null) { inherit (res) "region"; }
    // {
    }
    // optionalAttrs (res."roleARN" != null) { inherit (res) "roleARN"; }
    // {
    }
    // optionalAttrs (res."secretKey" != null) {
      "secretKey" = mkLightSailSDConfigSecretKey res."secretKey";
    }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkLightSailSDConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  LightSailSDConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkLightSailSDConfigOauth2ClientIdConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LightSailSDConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr LightSailSDConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr LightSailSDConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkLightSailSDConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkLightSailSDConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkLightSailSDConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  LightSailSDConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkLightSailSDConfigOauth2ClientIdSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LightSailSDConfigOauth2ClientSecretModule = types.submodule {
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
  mkLightSailSDConfigOauth2ClientSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LightSailSDConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = LightSailSDConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = LightSailSDConfigOauth2ClientSecretModule;
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
        type = (types.nullOr LightSailSDConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkLightSailSDConfigOauth2 =
    res:
    {
      "clientId" = mkLightSailSDConfigOauth2ClientId res."clientId";
      "clientSecret" = mkLightSailSDConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkLightSailSDConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  LightSailSDConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkLightSailSDConfigOauth2TlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LightSailSDConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr LightSailSDConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr LightSailSDConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkLightSailSDConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkLightSailSDConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkLightSailSDConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  LightSailSDConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkLightSailSDConfigOauth2TlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LightSailSDConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkLightSailSDConfigOauth2TlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LightSailSDConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr LightSailSDConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr LightSailSDConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkLightSailSDConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkLightSailSDConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkLightSailSDConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  LightSailSDConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkLightSailSDConfigOauth2TlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LightSailSDConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkLightSailSDConfigOauth2TlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LightSailSDConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr LightSailSDConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr LightSailSDConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr LightSailSDConfigOauth2TlsConfigKeySecretModule);
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
  mkLightSailSDConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkLightSailSDConfigOauth2TlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkLightSailSDConfigOauth2TlsConfigCert res."cert";
    }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkLightSailSDConfigOauth2TlsConfigKeySecret res."keySecret";
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
  LightSailSDConfigSecretKeyModule = types.submodule {
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
  mkLightSailSDConfigSecretKey =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LightSailSDConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkLightSailSDConfigTlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LightSailSDConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr LightSailSDConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr LightSailSDConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkLightSailSDConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkLightSailSDConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkLightSailSDConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  LightSailSDConfigTlsConfigCaSecretModule = types.submodule {
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
  mkLightSailSDConfigTlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LightSailSDConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkLightSailSDConfigTlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LightSailSDConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr LightSailSDConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr LightSailSDConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkLightSailSDConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkLightSailSDConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkLightSailSDConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  LightSailSDConfigTlsConfigCertSecretModule = types.submodule {
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
  mkLightSailSDConfigTlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LightSailSDConfigTlsConfigKeySecretModule = types.submodule {
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
  mkLightSailSDConfigTlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LightSailSDConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr LightSailSDConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr LightSailSDConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr LightSailSDConfigTlsConfigKeySecretModule);
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
  mkLightSailSDConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkLightSailSDConfigTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkLightSailSDConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkLightSailSDConfigTlsConfigKeySecret res."keySecret";
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
  LinodeSDConfigAuthorizationCredentialsModule = types.submodule {
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
  mkLinodeSDConfigAuthorizationCredentials =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LinodeSDConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr LinodeSDConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkLinodeSDConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkLinodeSDConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  LinodeSDConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Authorization header configuration.";
        type = (types.nullOr LinodeSDConfigAuthorizationModule);
        default = null;
      };
      "enableHTTP2" = mkOption {
        description = "Whether to enable HTTP2.";
        type = types.bool;
        default = false;
      };
      "followRedirects" = mkOption {
        description = "Configure whether HTTP requests follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "Optional OAuth 2.0 configuration.\nCannot be used at the same time as `authorization`.";
        type = (types.nullOr LinodeSDConfigOauth2Module);
        default = null;
      };
      "port" = mkOption {
        description = "Default port to scrape metrics from.";
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
      "refreshInterval" = mkOption {
        description = "Time after which the linode instances are refreshed.";
        type = (types.nullOr types.str);
        default = null;
      };
      "region" = mkOption {
        description = "Optional region to filter on.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tagSeparator" = mkOption {
        description = "The string by which Linode Instance tags are joined into the tag label.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration applying to the target HTTP endpoint.";
        type = (types.nullOr LinodeSDConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkLinodeSDConfig =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkLinodeSDConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs res."enableHTTP2" { inherit (res) "enableHTTP2"; }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) { "oauth2" = mkLinodeSDConfigOauth2 res."oauth2"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
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
    // optionalAttrs (res."refreshInterval" != null) { inherit (res) "refreshInterval"; }
    // {
    }
    // optionalAttrs (res."region" != null) { inherit (res) "region"; }
    // {
    }
    // optionalAttrs (res."tagSeparator" != null) { inherit (res) "tagSeparator"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkLinodeSDConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  LinodeSDConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkLinodeSDConfigOauth2ClientIdConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LinodeSDConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr LinodeSDConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr LinodeSDConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkLinodeSDConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkLinodeSDConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkLinodeSDConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  LinodeSDConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkLinodeSDConfigOauth2ClientIdSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LinodeSDConfigOauth2ClientSecretModule = types.submodule {
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
  mkLinodeSDConfigOauth2ClientSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LinodeSDConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = LinodeSDConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = LinodeSDConfigOauth2ClientSecretModule;
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
        type = (types.nullOr LinodeSDConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkLinodeSDConfigOauth2 =
    res:
    {
      "clientId" = mkLinodeSDConfigOauth2ClientId res."clientId";
      "clientSecret" = mkLinodeSDConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkLinodeSDConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  LinodeSDConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkLinodeSDConfigOauth2TlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LinodeSDConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr LinodeSDConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr LinodeSDConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkLinodeSDConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkLinodeSDConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkLinodeSDConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  LinodeSDConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkLinodeSDConfigOauth2TlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LinodeSDConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkLinodeSDConfigOauth2TlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LinodeSDConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr LinodeSDConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr LinodeSDConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkLinodeSDConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkLinodeSDConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkLinodeSDConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  LinodeSDConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkLinodeSDConfigOauth2TlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LinodeSDConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkLinodeSDConfigOauth2TlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LinodeSDConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr LinodeSDConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr LinodeSDConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr LinodeSDConfigOauth2TlsConfigKeySecretModule);
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
  mkLinodeSDConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkLinodeSDConfigOauth2TlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkLinodeSDConfigOauth2TlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkLinodeSDConfigOauth2TlsConfigKeySecret res."keySecret";
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
  LinodeSDConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkLinodeSDConfigTlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LinodeSDConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr LinodeSDConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr LinodeSDConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkLinodeSDConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkLinodeSDConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkLinodeSDConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  LinodeSDConfigTlsConfigCaSecretModule = types.submodule {
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
  mkLinodeSDConfigTlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LinodeSDConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkLinodeSDConfigTlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LinodeSDConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr LinodeSDConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr LinodeSDConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkLinodeSDConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkLinodeSDConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkLinodeSDConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  LinodeSDConfigTlsConfigCertSecretModule = types.submodule {
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
  mkLinodeSDConfigTlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LinodeSDConfigTlsConfigKeySecretModule = types.submodule {
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
  mkLinodeSDConfigTlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  LinodeSDConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr LinodeSDConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr LinodeSDConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr LinodeSDConfigTlsConfigKeySecretModule);
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
  mkLinodeSDConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkLinodeSDConfigTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkLinodeSDConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkLinodeSDConfigTlsConfigKeySecret res."keySecret";
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
  NomadSDConfigAuthorizationCredentialsModule = types.submodule {
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
  mkNomadSDConfigAuthorizationCredentials =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  NomadSDConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr NomadSDConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkNomadSDConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkNomadSDConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  NomadSDConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr NomadSDConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr NomadSDConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkNomadSDConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkNomadSDConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkNomadSDConfigBasicAuthUsername res."username";
    }
    // {
    };
  NomadSDConfigBasicAuthPasswordModule = types.submodule {
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
  mkNomadSDConfigBasicAuthPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  NomadSDConfigBasicAuthUsernameModule = types.submodule {
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
  mkNomadSDConfigBasicAuthUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  NomadSDConfigModule = types.submodule {
    options = {
      "allowStale" = mkOption {
        description = "The information to access the Nomad API. It is to be defined\nas the Nomad documentation requires.";
        type = types.bool;
        default = false;
      };
      "authorization" = mkOption {
        description = "Authorization header to use on every scrape request.";
        type = (types.nullOr NomadSDConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "BasicAuth information to use on every scrape request.";
        type = (types.nullOr NomadSDConfigBasicAuthModule);
        default = null;
      };
      "enableHTTP2" = mkOption {
        description = "Whether to enable HTTP2.";
        type = types.bool;
        default = false;
      };
      "followRedirects" = mkOption {
        description = "Configure whether HTTP requests follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "namespace" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "Optional OAuth 2.0 configuration.\nCannot be set at the same time as `authorization` or `basic_auth`.";
        type = (types.nullOr NomadSDConfigOauth2Module);
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
      "refreshInterval" = mkOption {
        description = "Duration is a valid time duration that can be parsed by Prometheus model.ParseDuration() function.\nSupported units: y, w, d, h, m, s, ms\nExamples: `30s`, `1m`, `1h20m15s`, `15d`";
        type = (types.nullOr types.str);
        default = null;
      };
      "region" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "server" = mkOption {
        type = types.str;
      };
      "tagSeparator" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration applying to the target HTTP endpoint.";
        type = (types.nullOr NomadSDConfigTlsConfigModule);
        default = null;
      };
    };
  };
  mkNomadSDConfig =
    res:
    {
    }
    // optionalAttrs res."allowStale" { inherit (res) "allowStale"; }
    // {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkNomadSDConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkNomadSDConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs res."enableHTTP2" { inherit (res) "enableHTTP2"; }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) { "oauth2" = mkNomadSDConfigOauth2 res."oauth2"; }
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
    // optionalAttrs (res."refreshInterval" != null) { inherit (res) "refreshInterval"; }
    // {
    }
    // optionalAttrs (res."region" != null) { inherit (res) "region"; }
    // {
      inherit (res) "server";
    }
    // optionalAttrs (res."tagSeparator" != null) { inherit (res) "tagSeparator"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkNomadSDConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  NomadSDConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkNomadSDConfigOauth2ClientIdConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  NomadSDConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr NomadSDConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr NomadSDConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkNomadSDConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkNomadSDConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkNomadSDConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  NomadSDConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkNomadSDConfigOauth2ClientIdSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  NomadSDConfigOauth2ClientSecretModule = types.submodule {
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
  mkNomadSDConfigOauth2ClientSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  NomadSDConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = NomadSDConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = NomadSDConfigOauth2ClientSecretModule;
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
        type = (types.nullOr NomadSDConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkNomadSDConfigOauth2 =
    res:
    {
      "clientId" = mkNomadSDConfigOauth2ClientId res."clientId";
      "clientSecret" = mkNomadSDConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkNomadSDConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  NomadSDConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkNomadSDConfigOauth2TlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  NomadSDConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr NomadSDConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr NomadSDConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkNomadSDConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkNomadSDConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkNomadSDConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  NomadSDConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkNomadSDConfigOauth2TlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  NomadSDConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkNomadSDConfigOauth2TlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  NomadSDConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr NomadSDConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr NomadSDConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkNomadSDConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkNomadSDConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkNomadSDConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  NomadSDConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkNomadSDConfigOauth2TlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  NomadSDConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkNomadSDConfigOauth2TlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  NomadSDConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr NomadSDConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr NomadSDConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr NomadSDConfigOauth2TlsConfigKeySecretModule);
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
  mkNomadSDConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkNomadSDConfigOauth2TlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkNomadSDConfigOauth2TlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkNomadSDConfigOauth2TlsConfigKeySecret res."keySecret";
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
  NomadSDConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkNomadSDConfigTlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  NomadSDConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr NomadSDConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr NomadSDConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkNomadSDConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkNomadSDConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkNomadSDConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  NomadSDConfigTlsConfigCaSecretModule = types.submodule {
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
  mkNomadSDConfigTlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  NomadSDConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkNomadSDConfigTlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  NomadSDConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr NomadSDConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr NomadSDConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkNomadSDConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkNomadSDConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkNomadSDConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  NomadSDConfigTlsConfigCertSecretModule = types.submodule {
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
  mkNomadSDConfigTlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  NomadSDConfigTlsConfigKeySecretModule = types.submodule {
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
  mkNomadSDConfigTlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  NomadSDConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr NomadSDConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr NomadSDConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr NomadSDConfigTlsConfigKeySecretModule);
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
  mkNomadSDConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkNomadSDConfigTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkNomadSDConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkNomadSDConfigTlsConfigKeySecret res."keySecret";
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
  OpenstackSDConfigApplicationCredentialSecretModule = types.submodule {
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
  mkOpenstackSDConfigApplicationCredentialSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  OpenstackSDConfigModule = types.submodule {
    options = {
      "allTenants" = mkOption {
        description = "Whether the service discovery should list all instances for all projects.\nIt is only relevant for the 'instance' role and usually requires admin permissions.";
        type = types.bool;
        default = false;
      };
      "applicationCredentialId" = mkOption {
        description = "ApplicationCredentialID";
        type = (types.nullOr types.str);
        default = null;
      };
      "applicationCredentialName" = mkOption {
        description = "The ApplicationCredentialID or ApplicationCredentialName fields are\nrequired if using an application credential to authenticate. Some providers\nallow you to create an application credential to authenticate rather than a\npassword.";
        type = (types.nullOr types.str);
        default = null;
      };
      "applicationCredentialSecret" = mkOption {
        description = "The applicationCredentialSecret field is required if using an application\ncredential to authenticate.";
        type = (types.nullOr OpenstackSDConfigApplicationCredentialSecretModule);
        default = null;
      };
      "availability" = mkOption {
        description = "Availability of the endpoint to connect to.";
        type = (
          types.nullOr (
            types.enum [
              "Public"
              "public"
              "Admin"
              "admin"
              "Internal"
              "internal"
            ]
          )
        );
        default = null;
      };
      "domainID" = mkOption {
        description = "DomainID";
        type = (types.nullOr types.str);
        default = null;
      };
      "domainName" = mkOption {
        description = "At most one of domainId and domainName must be provided if using username\nwith Identity V3. Otherwise, either are optional.";
        type = (types.nullOr types.str);
        default = null;
      };
      "identityEndpoint" = mkOption {
        description = "IdentityEndpoint specifies the HTTP endpoint that is required to work with\nthe Identity API of the appropriate version.";
        type = (types.nullOr types.str);
        default = null;
      };
      "password" = mkOption {
        description = "Password for the Identity V2 and V3 APIs. Consult with your provider's\ncontrol panel to discover your account's preferred method of authentication.";
        type = (types.nullOr OpenstackSDConfigPasswordModule);
        default = null;
      };
      "port" = mkOption {
        description = "The port to scrape metrics from. If using the public IP address, this must\ninstead be specified in the relabeling rule.";
        type = (types.nullOr types.int);
        default = null;
      };
      "projectID" = mkOption {
        description = " ProjectID";
        type = (types.nullOr types.str);
        default = null;
      };
      "projectName" = mkOption {
        description = "The ProjectId and ProjectName fields are optional for the Identity V2 API.\nSome providers allow you to specify a ProjectName instead of the ProjectId.\nSome require both. Your provider's authentication policies will determine\nhow these fields influence authentication.";
        type = (types.nullOr types.str);
        default = null;
      };
      "refreshInterval" = mkOption {
        description = "Refresh interval to re-read the instance list.";
        type = (types.nullOr types.str);
        default = null;
      };
      "region" = mkOption {
        description = "The OpenStack Region.";
        type = types.str;
      };
      "role" = mkOption {
        description = "The OpenStack role of entities that should be discovered.\n\nNote: The `LoadBalancer` role requires Prometheus >= v3.2.0.";
        type = (
          types.enum [
            "Instance"
            "Hypervisor"
            "LoadBalancer"
          ]
        );
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration applying to the target HTTP endpoint.";
        type = (types.nullOr OpenstackSDConfigTlsConfigModule);
        default = null;
      };
      "userid" = mkOption {
        description = "UserID";
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
        description = "Username is required if using Identity V2 API. Consult with your provider's\ncontrol panel to discover your account's username.\nIn Identity V3, either userid or a combination of username\nand domainId or domainName are needed";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkOpenstackSDConfig =
    res:
    {
    }
    // optionalAttrs res."allTenants" { inherit (res) "allTenants"; }
    // {
    }
    // optionalAttrs (res."applicationCredentialId" != null) {
      inherit (res) "applicationCredentialId";
    }
    // {
    }
    // optionalAttrs (res."applicationCredentialName" != null) {
      inherit (res) "applicationCredentialName";
    }
    // {
    }
    // optionalAttrs (res."applicationCredentialSecret" != null) {
      "applicationCredentialSecret" =
        mkOpenstackSDConfigApplicationCredentialSecret
          res."applicationCredentialSecret";
    }
    // {
    }
    // optionalAttrs (res."availability" != null) { inherit (res) "availability"; }
    // {
    }
    // optionalAttrs (res."domainID" != null) { inherit (res) "domainID"; }
    // {
    }
    // optionalAttrs (res."domainName" != null) { inherit (res) "domainName"; }
    // {
    }
    // optionalAttrs (res."identityEndpoint" != null) { inherit (res) "identityEndpoint"; }
    // {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkOpenstackSDConfigPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
    }
    // optionalAttrs (res."projectID" != null) { inherit (res) "projectID"; }
    // {
    }
    // optionalAttrs (res."projectName" != null) { inherit (res) "projectName"; }
    // {
    }
    // optionalAttrs (res."refreshInterval" != null) { inherit (res) "refreshInterval"; }
    // {
      inherit (res) "region";
      inherit (res) "role";
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkOpenstackSDConfigTlsConfig res."tlsConfig";
    }
    // {
    }
    // optionalAttrs (res."userid" != null) { inherit (res) "userid"; }
    // {
    }
    // optionalAttrs (res."username" != null) { inherit (res) "username"; }
    // {
    };
  OpenstackSDConfigPasswordModule = types.submodule {
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
  mkOpenstackSDConfigPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  OpenstackSDConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkOpenstackSDConfigTlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  OpenstackSDConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr OpenstackSDConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr OpenstackSDConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkOpenstackSDConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkOpenstackSDConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkOpenstackSDConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  OpenstackSDConfigTlsConfigCaSecretModule = types.submodule {
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
  mkOpenstackSDConfigTlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  OpenstackSDConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkOpenstackSDConfigTlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  OpenstackSDConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr OpenstackSDConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr OpenstackSDConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkOpenstackSDConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkOpenstackSDConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkOpenstackSDConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  OpenstackSDConfigTlsConfigCertSecretModule = types.submodule {
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
  mkOpenstackSDConfigTlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  OpenstackSDConfigTlsConfigKeySecretModule = types.submodule {
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
  mkOpenstackSDConfigTlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  OpenstackSDConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr OpenstackSDConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr OpenstackSDConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr OpenstackSDConfigTlsConfigKeySecretModule);
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
  mkOpenstackSDConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkOpenstackSDConfigTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkOpenstackSDConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkOpenstackSDConfigTlsConfigKeySecret res."keySecret";
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
  OvhcloudSDConfigApplicationSecretModule = types.submodule {
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
  mkOvhcloudSDConfigApplicationSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  OvhcloudSDConfigConsumerKeyModule = types.submodule {
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
  mkOvhcloudSDConfigConsumerKey =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  OvhcloudSDConfigModule = types.submodule {
    options = {
      "applicationKey" = mkOption {
        description = "Access key to use. https://api.ovh.com.";
        type = types.str;
      };
      "applicationSecret" = mkOption {
        description = "SecretKeySelector selects a key of a Secret.";
        type = OvhcloudSDConfigApplicationSecretModule;
      };
      "consumerKey" = mkOption {
        description = "SecretKeySelector selects a key of a Secret.";
        type = OvhcloudSDConfigConsumerKeyModule;
      };
      "endpoint" = mkOption {
        description = "Custom endpoint to be used.";
        type = (types.nullOr types.str);
        default = null;
      };
      "refreshInterval" = mkOption {
        description = "Refresh interval to re-read the resources list.";
        type = (types.nullOr types.str);
        default = null;
      };
      "service" = mkOption {
        description = "Service of the targets to retrieve. Must be `VPS` or `DedicatedServer`.";
        type = types.str;
      };
    };
  };
  mkOvhcloudSDConfig =
    res:
    {
      inherit (res) "applicationKey";
      "applicationSecret" = mkOvhcloudSDConfigApplicationSecret res."applicationSecret";
      "consumerKey" = mkOvhcloudSDConfigConsumerKey res."consumerKey";
    }
    // optionalAttrs (res."endpoint" != null) { inherit (res) "endpoint"; }
    // {
    }
    // optionalAttrs (res."refreshInterval" != null) { inherit (res) "refreshInterval"; }
    // {
      inherit (res) "service";
    };
  PuppetDBSDConfigAuthorizationCredentialsModule = types.submodule {
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
  mkPuppetDBSDConfigAuthorizationCredentials =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  PuppetDBSDConfigAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        description = "Selects a key of a Secret in the namespace that contains the credentials for authentication.";
        type = (types.nullOr PuppetDBSDConfigAuthorizationCredentialsModule);
        default = null;
      };
      "type" = mkOption {
        description = "Defines the authentication type. The value is case-insensitive.\n\n\"Basic\" is not a supported value.\n\nDefault: \"Bearer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkPuppetDBSDConfigAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkPuppetDBSDConfigAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  PuppetDBSDConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "`password` specifies a key of a Secret containing the password for\nauthentication.";
        type = (types.nullOr PuppetDBSDConfigBasicAuthPasswordModule);
        default = null;
      };
      "username" = mkOption {
        description = "`username` specifies a key of a Secret containing the username for\nauthentication.";
        type = (types.nullOr PuppetDBSDConfigBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkPuppetDBSDConfigBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkPuppetDBSDConfigBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkPuppetDBSDConfigBasicAuthUsername res."username";
    }
    // {
    };
  PuppetDBSDConfigBasicAuthPasswordModule = types.submodule {
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
  mkPuppetDBSDConfigBasicAuthPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  PuppetDBSDConfigBasicAuthUsernameModule = types.submodule {
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
  mkPuppetDBSDConfigBasicAuthUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  PuppetDBSDConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        description = "Optional `authorization` HTTP header configuration.\nCannot be set at the same time as `basicAuth`, or `oauth2`.";
        type = (types.nullOr PuppetDBSDConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        description = "Optional HTTP basic authentication information.\nCannot be set at the same time as `authorization`, or `oauth2`.";
        type = (types.nullOr PuppetDBSDConfigBasicAuthModule);
        default = null;
      };
      "enableHTTP2" = mkOption {
        description = "Configure whether to enable HTTP2.";
        type = types.bool;
        default = false;
      };
      "followRedirects" = mkOption {
        description = "Configure whether the HTTP requests should follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "includeParameters" = mkOption {
        description = "Whether to include the parameters as meta labels.\nNote: Enabling this exposes parameters in the Prometheus UI and API. Make sure\nthat you don't have secrets exposed as parameters if you enable this.";
        type = types.bool;
        default = false;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        description = "Optional OAuth2.0 configuration.\nCannot be set at the same time as `basicAuth`, or `authorization`.";
        type = (types.nullOr PuppetDBSDConfigOauth2Module);
        default = null;
      };
      "port" = mkOption {
        description = "Port to scrape the metrics from.";
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
      "query" = mkOption {
        description = "Puppet Query Language (PQL) query. Only resources are supported.\nhttps://puppet.com/docs/puppetdb/latest/api/query/v4/pql.html";
        type = types.str;
      };
      "refreshInterval" = mkOption {
        description = "Refresh interval to re-read the list of resources.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration to connect to the Puppet DB.";
        type = (types.nullOr PuppetDBSDConfigTlsConfigModule);
        default = null;
      };
      "url" = mkOption {
        description = "The URL of the PuppetDB root query endpoint.";
        type = types.str;
      };
    };
  };
  mkPuppetDBSDConfig =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkPuppetDBSDConfigAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkPuppetDBSDConfigBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs res."enableHTTP2" { inherit (res) "enableHTTP2"; }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs res."includeParameters" { inherit (res) "includeParameters"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) { "oauth2" = mkPuppetDBSDConfigOauth2 res."oauth2"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
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
      inherit (res) "query";
    }
    // optionalAttrs (res."refreshInterval" != null) { inherit (res) "refreshInterval"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkPuppetDBSDConfigTlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "url";
    };
  PuppetDBSDConfigOauth2ClientIdConfigMapModule = types.submodule {
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
  mkPuppetDBSDConfigOauth2ClientIdConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  PuppetDBSDConfigOauth2ClientIdModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr PuppetDBSDConfigOauth2ClientIdConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr PuppetDBSDConfigOauth2ClientIdSecretModule);
        default = null;
      };
    };
  };
  mkPuppetDBSDConfigOauth2ClientId =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkPuppetDBSDConfigOauth2ClientIdConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkPuppetDBSDConfigOauth2ClientIdSecret res."secret";
    }
    // {
    };
  PuppetDBSDConfigOauth2ClientIdSecretModule = types.submodule {
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
  mkPuppetDBSDConfigOauth2ClientIdSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  PuppetDBSDConfigOauth2ClientSecretModule = types.submodule {
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
  mkPuppetDBSDConfigOauth2ClientSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  PuppetDBSDConfigOauth2Module = types.submodule {
    options = {
      "clientId" = mkOption {
        description = "`clientId` specifies a key of a Secret or ConfigMap containing the\nOAuth2 client's ID.";
        type = PuppetDBSDConfigOauth2ClientIdModule;
      };
      "clientSecret" = mkOption {
        description = "`clientSecret` specifies a key of a Secret containing the OAuth2\nclient's secret.";
        type = PuppetDBSDConfigOauth2ClientSecretModule;
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
        type = (types.nullOr PuppetDBSDConfigOauth2TlsConfigModule);
        default = null;
      };
      "tokenUrl" = mkOption {
        description = "`tokenURL` configures the URL to fetch the token from.";
        type = types.str;
      };
    };
  };
  mkPuppetDBSDConfigOauth2 =
    res:
    {
      "clientId" = mkPuppetDBSDConfigOauth2ClientId res."clientId";
      "clientSecret" = mkPuppetDBSDConfigOauth2ClientSecret res."clientSecret";
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
      "tlsConfig" = mkPuppetDBSDConfigOauth2TlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "tokenUrl";
    };
  PuppetDBSDConfigOauth2TlsConfigCaConfigMapModule = types.submodule {
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
  mkPuppetDBSDConfigOauth2TlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  PuppetDBSDConfigOauth2TlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr PuppetDBSDConfigOauth2TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr PuppetDBSDConfigOauth2TlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkPuppetDBSDConfigOauth2TlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkPuppetDBSDConfigOauth2TlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkPuppetDBSDConfigOauth2TlsConfigCaSecret res."secret";
    }
    // {
    };
  PuppetDBSDConfigOauth2TlsConfigCaSecretModule = types.submodule {
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
  mkPuppetDBSDConfigOauth2TlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  PuppetDBSDConfigOauth2TlsConfigCertConfigMapModule = types.submodule {
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
  mkPuppetDBSDConfigOauth2TlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  PuppetDBSDConfigOauth2TlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr PuppetDBSDConfigOauth2TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr PuppetDBSDConfigOauth2TlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkPuppetDBSDConfigOauth2TlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkPuppetDBSDConfigOauth2TlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkPuppetDBSDConfigOauth2TlsConfigCertSecret res."secret";
    }
    // {
    };
  PuppetDBSDConfigOauth2TlsConfigCertSecretModule = types.submodule {
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
  mkPuppetDBSDConfigOauth2TlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  PuppetDBSDConfigOauth2TlsConfigKeySecretModule = types.submodule {
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
  mkPuppetDBSDConfigOauth2TlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  PuppetDBSDConfigOauth2TlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr PuppetDBSDConfigOauth2TlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr PuppetDBSDConfigOauth2TlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr PuppetDBSDConfigOauth2TlsConfigKeySecretModule);
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
  mkPuppetDBSDConfigOauth2TlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkPuppetDBSDConfigOauth2TlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkPuppetDBSDConfigOauth2TlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkPuppetDBSDConfigOauth2TlsConfigKeySecret res."keySecret";
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
  PuppetDBSDConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkPuppetDBSDConfigTlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  PuppetDBSDConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr PuppetDBSDConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr PuppetDBSDConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkPuppetDBSDConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkPuppetDBSDConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkPuppetDBSDConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  PuppetDBSDConfigTlsConfigCaSecretModule = types.submodule {
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
  mkPuppetDBSDConfigTlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  PuppetDBSDConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkPuppetDBSDConfigTlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  PuppetDBSDConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr PuppetDBSDConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr PuppetDBSDConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkPuppetDBSDConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkPuppetDBSDConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkPuppetDBSDConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  PuppetDBSDConfigTlsConfigCertSecretModule = types.submodule {
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
  mkPuppetDBSDConfigTlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  PuppetDBSDConfigTlsConfigKeySecretModule = types.submodule {
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
  mkPuppetDBSDConfigTlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  PuppetDBSDConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr PuppetDBSDConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr PuppetDBSDConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr PuppetDBSDConfigTlsConfigKeySecretModule);
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
  mkPuppetDBSDConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkPuppetDBSDConfigTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkPuppetDBSDConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkPuppetDBSDConfigTlsConfigKeySecret res."keySecret";
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
  RelabelingModule = types.submodule {
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
  mkRelabeling =
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
  ScalewaySDConfigModule = types.submodule {
    options = {
      "accessKey" = mkOption {
        description = "Access key to use. https://console.scaleway.com/project/credentials";
        type = types.str;
      };
      "apiURL" = mkOption {
        description = "API URL to use when doing the server listing requests.";
        type = (types.nullOr types.str);
        default = null;
      };
      "enableHTTP2" = mkOption {
        description = "Whether to enable HTTP2.";
        type = types.bool;
        default = false;
      };
      "followRedirects" = mkOption {
        description = "Configure whether HTTP requests follow HTTP 3xx redirects.";
        type = types.bool;
        default = false;
      };
      "nameFilter" = mkOption {
        description = "NameFilter specify a name filter (works as a LIKE) to apply on the server listing request.";
        type = (types.nullOr types.str);
        default = null;
      };
      "noProxy" = mkOption {
        description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "The port to scrape metrics from.";
        type = (types.nullOr types.int);
        default = null;
      };
      "projectID" = mkOption {
        description = "Project ID of the targets.";
        type = types.str;
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
      "refreshInterval" = mkOption {
        description = "Refresh interval to re-read the list of instances.";
        type = (types.nullOr types.str);
        default = null;
      };
      "role" = mkOption {
        description = "Service of the targets to retrieve. Must be `Instance` or `Baremetal`.";
        type = (
          types.enum [
            "Instance"
            "Baremetal"
          ]
        );
      };
      "secretKey" = mkOption {
        description = "Secret key to use when listing targets.";
        type = ScalewaySDConfigSecretKeyModule;
      };
      "tagsFilter" = mkOption {
        description = "TagsFilter specify a tag filter (a server needs to have all defined tags to be listed) to apply on the server listing request.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "tlsConfig" = mkOption {
        description = "TLS configuration to use on every scrape request";
        type = (types.nullOr ScalewaySDConfigTlsConfigModule);
        default = null;
      };
      "zone" = mkOption {
        description = "Zone is the availability zone of your targets (e.g. fr-par-1).";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkScalewaySDConfig =
    res:
    {
      inherit (res) "accessKey";
    }
    // optionalAttrs (res."apiURL" != null) { inherit (res) "apiURL"; }
    // {
    }
    // optionalAttrs res."enableHTTP2" { inherit (res) "enableHTTP2"; }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."nameFilter" != null) { inherit (res) "nameFilter"; }
    // {
    }
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
      inherit (res) "projectID";
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
    // optionalAttrs (res."refreshInterval" != null) { inherit (res) "refreshInterval"; }
    // {
      inherit (res) "role";
      "secretKey" = mkScalewaySDConfigSecretKey res."secretKey";
    }
    // optionalAttrs (res."tagsFilter" != [ ]) { inherit (res) "tagsFilter"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkScalewaySDConfigTlsConfig res."tlsConfig";
    }
    // {
    }
    // optionalAttrs (res."zone" != null) { inherit (res) "zone"; }
    // {
    };
  ScalewaySDConfigSecretKeyModule = types.submodule {
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
  mkScalewaySDConfigSecretKey =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ScalewaySDConfigTlsConfigCaConfigMapModule = types.submodule {
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
  mkScalewaySDConfigTlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ScalewaySDConfigTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ScalewaySDConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ScalewaySDConfigTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkScalewaySDConfigTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkScalewaySDConfigTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkScalewaySDConfigTlsConfigCaSecret res."secret";
    }
    // {
    };
  ScalewaySDConfigTlsConfigCaSecretModule = types.submodule {
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
  mkScalewaySDConfigTlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ScalewaySDConfigTlsConfigCertConfigMapModule = types.submodule {
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
  mkScalewaySDConfigTlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ScalewaySDConfigTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "ConfigMap containing data to use for the targets.";
        type = (types.nullOr ScalewaySDConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        description = "Secret containing data to use for the targets.";
        type = (types.nullOr ScalewaySDConfigTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkScalewaySDConfigTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkScalewaySDConfigTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkScalewaySDConfigTlsConfigCertSecret res."secret";
    }
    // {
    };
  ScalewaySDConfigTlsConfigCertSecretModule = types.submodule {
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
  mkScalewaySDConfigTlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ScalewaySDConfigTlsConfigKeySecretModule = types.submodule {
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
  mkScalewaySDConfigTlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ScalewaySDConfigTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        description = "Certificate authority used when verifying server certificates.";
        type = (types.nullOr ScalewaySDConfigTlsConfigCaModule);
        default = null;
      };
      "cert" = mkOption {
        description = "Client certificate to present when doing client-authentication.";
        type = (types.nullOr ScalewaySDConfigTlsConfigCertModule);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        description = "Disable target certificate validation.";
        type = types.bool;
        default = false;
      };
      "keySecret" = mkOption {
        description = "Secret containing the client key file for the targets.";
        type = (types.nullOr ScalewaySDConfigTlsConfigKeySecretModule);
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
  mkScalewaySDConfigTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkScalewaySDConfigTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkScalewaySDConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkScalewaySDConfigTlsConfigKeySecret res."keySecret";
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
  StaticConfigModule = types.submodule {
    options = {
      "labels" = mkOption {
        description = "Labels assigned to all metrics scraped from the targets.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "targets" = mkOption {
        description = "List of targets for this static configuration.";
        type = (types.listOf types.str);
      };
    };
  };
  mkStaticConfig =
    res:
    {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
      inherit (res) "targets";
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
  ScrapeconfigsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this ScrapeConfig resource.";
        };
        "authorization" = mkOption {
          description = "Authorization header to use on every scrape request.";
          type = (types.nullOr AuthorizationModule);
          default = null;
        };
        "azureSDConfigs" = mkOption {
          description = "AzureSDConfigs defines a list of Azure service discovery configurations.";
          type = (types.listOf AzureSDConfigModule);
          default = [ ];
        };
        "basicAuth" = mkOption {
          description = "BasicAuth information to use on every scrape request.";
          type = (types.nullOr BasicAuthModule);
          default = null;
        };
        "consulSDConfigs" = mkOption {
          description = "ConsulSDConfigs defines a list of Consul service discovery configurations.";
          type = (types.listOf ConsulSDConfigModule);
          default = [ ];
        };
        "convertClassicHistogramsToNHCB" = mkOption {
          description = "Whether to convert all scraped classic histograms into a native histogram with custom buckets.\nIt requires Prometheus >= v3.0.0.";
          type = types.bool;
          default = false;
        };
        "digitalOceanSDConfigs" = mkOption {
          description = "DigitalOceanSDConfigs defines a list of DigitalOcean service discovery configurations.";
          type = (types.listOf DigitalOceanSDConfigModule);
          default = [ ];
        };
        "dnsSDConfigs" = mkOption {
          description = "DNSSDConfigs defines a list of DNS service discovery configurations.";
          type = (types.listOf DnsSDConfigModule);
          default = [ ];
        };
        "dockerSDConfigs" = mkOption {
          description = "DockerSDConfigs defines a list of Docker service discovery configurations.";
          type = (types.listOf DockerSDConfigModule);
          default = [ ];
        };
        "dockerSwarmSDConfigs" = mkOption {
          description = "DockerswarmSDConfigs defines a list of Dockerswarm service discovery configurations.";
          type = (types.listOf DockerSwarmSDConfigModule);
          default = [ ];
        };
        "ec2SDConfigs" = mkOption {
          description = "EC2SDConfigs defines a list of EC2 service discovery configurations.";
          type = (types.listOf Ec2SDConfigModule);
          default = [ ];
        };
        "enableCompression" = mkOption {
          description = "When false, Prometheus will request uncompressed response from the scraped target.\n\nIt requires Prometheus >= v2.49.0.\n\nIf unset, Prometheus uses true by default.";
          type = types.bool;
          default = false;
        };
        "enableHTTP2" = mkOption {
          description = "Whether to enable HTTP2.";
          type = types.bool;
          default = false;
        };
        "eurekaSDConfigs" = mkOption {
          description = "EurekaSDConfigs defines a list of Eureka service discovery configurations.";
          type = (types.listOf EurekaSDConfigModule);
          default = [ ];
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
        "fileSDConfigs" = mkOption {
          description = "FileSDConfigs defines a list of file service discovery configurations.";
          type = (types.listOf FileSDConfigModule);
          default = [ ];
        };
        "gceSDConfigs" = mkOption {
          description = "GCESDConfigs defines a list of GCE service discovery configurations.";
          type = (types.listOf GceSDConfigModule);
          default = [ ];
        };
        "hetznerSDConfigs" = mkOption {
          description = "HetznerSDConfigs defines a list of Hetzner service discovery configurations.";
          type = (types.listOf HetznerSDConfigModule);
          default = [ ];
        };
        "honorLabels" = mkOption {
          description = "HonorLabels chooses the metric's labels on collisions with target labels.";
          type = types.bool;
          default = false;
        };
        "honorTimestamps" = mkOption {
          description = "HonorTimestamps controls whether Prometheus respects the timestamps present in scraped data.";
          type = types.bool;
          default = false;
        };
        "httpSDConfigs" = mkOption {
          description = "HTTPSDConfigs defines a list of HTTP service discovery configurations.";
          type = (types.listOf HttpSDConfigModule);
          default = [ ];
        };
        "ionosSDConfigs" = mkOption {
          description = "IonosSDConfigs defines a list of IONOS service discovery configurations.";
          type = (types.listOf IonosSDConfigModule);
          default = [ ];
        };
        "jobName" = mkOption {
          description = "The value of the `job` label assigned to the scraped metrics by default.\n\nThe `job_name` field in the rendered scrape configuration is always controlled by the\noperator to prevent duplicate job names, which Prometheus does not allow. Instead the\n`job` label is set by means of relabeling configs.";
          type = (types.nullOr types.str);
          default = null;
        };
        "keepDroppedTargets" = mkOption {
          description = "Per-scrape limit on the number of targets dropped by relabeling\nthat will be kept in memory. 0 means no limit.\n\nIt requires Prometheus >= v2.47.0.";
          type = (types.nullOr types.int);
          default = null;
        };
        "kubernetesSDConfigs" = mkOption {
          description = "KubernetesSDConfigs defines a list of Kubernetes service discovery configurations.";
          type = (types.listOf KubernetesSDConfigModule);
          default = [ ];
        };
        "kumaSDConfigs" = mkOption {
          description = "KumaSDConfigs defines a list of Kuma service discovery configurations.";
          type = (types.listOf KumaSDConfigModule);
          default = [ ];
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
        "lightSailSDConfigs" = mkOption {
          description = "LightsailSDConfigs defines a list of Lightsail service discovery configurations.";
          type = (types.listOf LightSailSDConfigModule);
          default = [ ];
        };
        "linodeSDConfigs" = mkOption {
          description = "LinodeSDConfigs defines a list of Linode service discovery configurations.";
          type = (types.listOf LinodeSDConfigModule);
          default = [ ];
        };
        "metricRelabelings" = mkOption {
          description = "MetricRelabelConfigs to apply to samples before ingestion.";
          type = (types.listOf MetricRelabelingModule);
          default = [ ];
        };
        "metricsPath" = mkOption {
          description = "MetricsPath HTTP path to scrape for metrics. If empty, Prometheus uses the default value (e.g. /metrics).";
          type = (types.nullOr types.str);
          default = null;
        };
        "nameEscapingScheme" = mkOption {
          description = "Metric name escaping mode to request through content negotiation.\n\nIt requires Prometheus >= v3.4.0.";
          type = (
            types.nullOr (
              types.enum [
                "AllowUTF8"
                "Underscores"
                "Dots"
                "Values"
              ]
            )
          );
          default = null;
        };
        "nameValidationScheme" = mkOption {
          description = "Specifies the validation scheme for metric and label names.\n\nIt requires Prometheus >= v3.0.0.";
          type = (
            types.nullOr (
              types.enum [
                "UTF8"
                "Legacy"
              ]
            )
          );
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
        "noProxy" = mkOption {
          description = "`noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names\nthat should be excluded from proxying. IP and domain names can\ncontain port numbers.\n\nIt requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.";
          type = (types.nullOr types.str);
          default = null;
        };
        "nomadSDConfigs" = mkOption {
          description = "NomadSDConfigs defines a list of Nomad service discovery configurations.";
          type = (types.listOf NomadSDConfigModule);
          default = [ ];
        };
        "oauth2" = mkOption {
          description = "OAuth2 configuration to use on every scrape request.";
          type = (types.nullOr Oauth2Module);
          default = null;
        };
        "openstackSDConfigs" = mkOption {
          description = "OpenStackSDConfigs defines a list of OpenStack service discovery configurations.";
          type = (types.listOf OpenstackSDConfigModule);
          default = [ ];
        };
        "ovhcloudSDConfigs" = mkOption {
          description = "OVHCloudSDConfigs defines a list of OVHcloud service discovery configurations.";
          type = (types.listOf OvhcloudSDConfigModule);
          default = [ ];
        };
        "params" = mkOption {
          description = "Optional HTTP URL parameters";
          type = (types.attrsOf (types.listOf types.str));
          default = { };
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
        "puppetDBSDConfigs" = mkOption {
          description = "PuppetDBSDConfigs defines a list of PuppetDB service discovery configurations.";
          type = (types.listOf PuppetDBSDConfigModule);
          default = [ ];
        };
        "relabelings" = mkOption {
          description = "RelabelConfigs defines how to rewrite the target's labels before scraping.\nPrometheus Operator automatically adds relabelings for a few standard Kubernetes fields.\nThe original scrape job's name is available via the `__tmp_prometheus_job_name` label.\nMore info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config";
          type = (types.listOf RelabelingModule);
          default = [ ];
        };
        "sampleLimit" = mkOption {
          description = "SampleLimit defines per-scrape limit on number of scraped samples that will be accepted.";
          type = (types.nullOr types.int);
          default = null;
        };
        "scalewaySDConfigs" = mkOption {
          description = "ScalewaySDConfigs defines a list of Scaleway instances and baremetal service discovery configurations.";
          type = (types.listOf ScalewaySDConfigModule);
          default = [ ];
        };
        "scheme" = mkOption {
          description = "Configures the protocol scheme used for requests.\nIf empty, Prometheus uses HTTP by default.";
          type = (
            types.nullOr (
              types.enum [
                "HTTP"
                "HTTPS"
              ]
            )
          );
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
        "scrapeInterval" = mkOption {
          description = "ScrapeInterval is the interval between consecutive scrapes.";
          type = (types.nullOr types.str);
          default = null;
        };
        "scrapeProtocols" = mkOption {
          description = "The protocols to negotiate during a scrape. It tells clients the\nprotocols supported by Prometheus in order of preference (from most to least preferred).\n\nIf unset, Prometheus uses its default value.\n\nIt requires Prometheus >= v2.49.0.";
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
          description = "ScrapeTimeout is the number of seconds to wait until a scrape request times out.\nThe value cannot be greater than the scrape interval otherwise the operator will reject the resource.";
          type = (types.nullOr types.str);
          default = null;
        };
        "staticConfigs" = mkOption {
          description = "StaticConfigs defines a list of static targets with a common label set.";
          type = (types.listOf StaticConfigModule);
          default = [ ];
        };
        "targetLimit" = mkOption {
          description = "TargetLimit defines a limit on the number of scraped targets that will be accepted.";
          type = (types.nullOr types.int);
          default = null;
        };
        "tlsConfig" = mkOption {
          description = "TLS configuration to use on every scrape request";
          type = (types.nullOr TlsConfigModule);
          default = null;
        };
        "trackTimestampsStaleness" = mkOption {
          description = "TrackTimestampsStaleness whether Prometheus tracks staleness of\nthe metrics that have an explicit timestamp present in scraped data.\nHas no effect if `honorTimestamps` is false.\nIt requires Prometheus >= v2.48.0.";
          type = types.bool;
          default = false;
        };
      };
    }
  );
  mkScrapeConfig = name: res: {
    apiVersion = "monitoring.coreos.com/v1alpha1";
    kind = "ScrapeConfig";
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
    // optionalAttrs (res."azureSDConfigs" != [ ]) {
      "azureSDConfigs" = map mkAzureSDConfig res."azureSDConfigs";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) { "basicAuth" = mkBasicAuth res."basicAuth"; }
    // {
    }
    // optionalAttrs (res."consulSDConfigs" != [ ]) {
      "consulSDConfigs" = map mkConsulSDConfig res."consulSDConfigs";
    }
    // {
    }
    // optionalAttrs res."convertClassicHistogramsToNHCB" {
      inherit (res) "convertClassicHistogramsToNHCB";
    }
    // {
    }
    // optionalAttrs (res."digitalOceanSDConfigs" != [ ]) {
      "digitalOceanSDConfigs" = map mkDigitalOceanSDConfig res."digitalOceanSDConfigs";
    }
    // {
    }
    // optionalAttrs (res."dnsSDConfigs" != [ ]) {
      "dnsSDConfigs" = map mkDnsSDConfig res."dnsSDConfigs";
    }
    // {
    }
    // optionalAttrs (res."dockerSDConfigs" != [ ]) {
      "dockerSDConfigs" = map mkDockerSDConfig res."dockerSDConfigs";
    }
    // {
    }
    // optionalAttrs (res."dockerSwarmSDConfigs" != [ ]) {
      "dockerSwarmSDConfigs" = map mkDockerSwarmSDConfig res."dockerSwarmSDConfigs";
    }
    // {
    }
    // optionalAttrs (res."ec2SDConfigs" != [ ]) {
      "ec2SDConfigs" = map mkEc2SDConfig res."ec2SDConfigs";
    }
    // {
    }
    // optionalAttrs res."enableCompression" { inherit (res) "enableCompression"; }
    // {
    }
    // optionalAttrs res."enableHTTP2" { inherit (res) "enableHTTP2"; }
    // {
    }
    // optionalAttrs (res."eurekaSDConfigs" != [ ]) {
      "eurekaSDConfigs" = map mkEurekaSDConfig res."eurekaSDConfigs";
    }
    // {
    }
    // optionalAttrs (res."fallbackScrapeProtocol" != null) { inherit (res) "fallbackScrapeProtocol"; }
    // {
    }
    // optionalAttrs (res."fileSDConfigs" != [ ]) {
      "fileSDConfigs" = map mkFileSDConfig res."fileSDConfigs";
    }
    // {
    }
    // optionalAttrs (res."gceSDConfigs" != [ ]) {
      "gceSDConfigs" = map mkGceSDConfig res."gceSDConfigs";
    }
    // {
    }
    // optionalAttrs (res."hetznerSDConfigs" != [ ]) {
      "hetznerSDConfigs" = map mkHetznerSDConfig res."hetznerSDConfigs";
    }
    // {
    }
    // optionalAttrs res."honorLabels" { inherit (res) "honorLabels"; }
    // {
    }
    // optionalAttrs res."honorTimestamps" { inherit (res) "honorTimestamps"; }
    // {
    }
    // optionalAttrs (res."httpSDConfigs" != [ ]) {
      "httpSDConfigs" = map mkHttpSDConfig res."httpSDConfigs";
    }
    // {
    }
    // optionalAttrs (res."ionosSDConfigs" != [ ]) {
      "ionosSDConfigs" = map mkIonosSDConfig res."ionosSDConfigs";
    }
    // {
    }
    // optionalAttrs (res."jobName" != null) { inherit (res) "jobName"; }
    // {
    }
    // optionalAttrs (res."keepDroppedTargets" != null) { inherit (res) "keepDroppedTargets"; }
    // {
    }
    // optionalAttrs (res."kubernetesSDConfigs" != [ ]) {
      "kubernetesSDConfigs" = map mkKubernetesSDConfig res."kubernetesSDConfigs";
    }
    // {
    }
    // optionalAttrs (res."kumaSDConfigs" != [ ]) {
      "kumaSDConfigs" = map mkKumaSDConfig res."kumaSDConfigs";
    }
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
    // optionalAttrs (res."lightSailSDConfigs" != [ ]) {
      "lightSailSDConfigs" = map mkLightSailSDConfig res."lightSailSDConfigs";
    }
    // {
    }
    // optionalAttrs (res."linodeSDConfigs" != [ ]) {
      "linodeSDConfigs" = map mkLinodeSDConfig res."linodeSDConfigs";
    }
    // {
    }
    // optionalAttrs (res."metricRelabelings" != [ ]) {
      "metricRelabelings" = map mkMetricRelabeling res."metricRelabelings";
    }
    // {
    }
    // optionalAttrs (res."metricsPath" != null) { inherit (res) "metricsPath"; }
    // {
    }
    // optionalAttrs (res."nameEscapingScheme" != null) { inherit (res) "nameEscapingScheme"; }
    // {
    }
    // optionalAttrs (res."nameValidationScheme" != null) { inherit (res) "nameValidationScheme"; }
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
    // optionalAttrs (res."noProxy" != null) { inherit (res) "noProxy"; }
    // {
    }
    // optionalAttrs (res."nomadSDConfigs" != [ ]) {
      "nomadSDConfigs" = map mkNomadSDConfig res."nomadSDConfigs";
    }
    // {
    }
    // optionalAttrs (res."oauth2" != null) { "oauth2" = mkOauth2 res."oauth2"; }
    // {
    }
    // optionalAttrs (res."openstackSDConfigs" != [ ]) {
      "openstackSDConfigs" = map mkOpenstackSDConfig res."openstackSDConfigs";
    }
    // {
    }
    // optionalAttrs (res."ovhcloudSDConfigs" != [ ]) {
      "ovhcloudSDConfigs" = map mkOvhcloudSDConfig res."ovhcloudSDConfigs";
    }
    // {
    }
    // optionalAttrs (res."params" != { }) { inherit (res) "params"; }
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
    // optionalAttrs (res."puppetDBSDConfigs" != [ ]) {
      "puppetDBSDConfigs" = map mkPuppetDBSDConfig res."puppetDBSDConfigs";
    }
    // {
    }
    // optionalAttrs (res."relabelings" != [ ]) { "relabelings" = map mkRelabeling res."relabelings"; }
    // {
    }
    // optionalAttrs (res."sampleLimit" != null) { inherit (res) "sampleLimit"; }
    // {
    }
    // optionalAttrs (res."scalewaySDConfigs" != [ ]) {
      "scalewaySDConfigs" = map mkScalewaySDConfig res."scalewaySDConfigs";
    }
    // {
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    }
    // optionalAttrs (res."scrapeClass" != null) { inherit (res) "scrapeClass"; }
    // {
    }
    // optionalAttrs res."scrapeClassicHistograms" { inherit (res) "scrapeClassicHistograms"; }
    // {
    }
    // optionalAttrs (res."scrapeInterval" != null) { inherit (res) "scrapeInterval"; }
    // {
    }
    // optionalAttrs (res."scrapeProtocols" != [ ]) { inherit (res) "scrapeProtocols"; }
    // {
    }
    // optionalAttrs (res."scrapeTimeout" != null) { inherit (res) "scrapeTimeout"; }
    // {
    }
    // optionalAttrs (res."staticConfigs" != [ ]) {
      "staticConfigs" = map mkStaticConfig res."staticConfigs";
    }
    // {
    }
    // optionalAttrs (res."targetLimit" != null) { inherit (res) "targetLimit"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) { "tlsConfig" = mkTlsConfig res."tlsConfig"; }
    // {
    }
    // optionalAttrs res."trackTimestampsStaleness" { inherit (res) "trackTimestampsStaleness"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkScrapeConfig cfg."scrapeconfigs");
in
{
  options.openkrill.apps."kube-prometheus" = {
    "scrapeconfigs" = mkOption {
      type = types.attrsOf ScrapeconfigsModule;
      default = { };
      description = "ScrapeConfig CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."kube-prometheus".content = allResources;
  };
}
