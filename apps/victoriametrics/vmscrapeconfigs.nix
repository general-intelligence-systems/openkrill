# Auto-generated openkrill module fragment for victoriametrics
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."victoriametrics";
  compact = filterAttrs (_: v: v != null);
  AuthorizationCredentialsModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr AuthorizationCredentialsModule);
        default = null;
      };
      "credentialsFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
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
    // optionalAttrs (res."credentialsFile" != null) { inherit (res) "credentialsFile"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  AzureSDConfigClientSecretModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (
          types.nullOr (
            types.enum [
              "OAuth"
              "ManagedIdentity"
            ]
          )
        );
        default = null;
      };
      "clientID" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "clientSecret" = mkOption {
        type = (types.nullOr AzureSDConfigClientSecretModule);
        default = null;
      };
      "environment" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "resourceGroup" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "subscriptionID" = mkOption {
        type = types.str;
      };
      "tenantID" = mkOption {
        type = (types.nullOr types.str);
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
    // optionalAttrs (res."clientID" != null) { inherit (res) "clientID"; }
    // {
    }
    // optionalAttrs (res."clientSecret" != null) {
      "clientSecret" = mkAzureSDConfigClientSecret res."clientSecret";
    }
    // {
    }
    // optionalAttrs (res."environment" != null) { inherit (res) "environment"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
    }
    // optionalAttrs (res."resourceGroup" != null) { inherit (res) "resourceGroup"; }
    // {
      inherit (res) "subscriptionID";
    }
    // optionalAttrs (res."tenantID" != null) { inherit (res) "tenantID"; }
    // {
    };
  BasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        type = (types.nullOr BasicAuthPasswordModule);
        default = null;
      };
      "password_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
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
    // optionalAttrs (res."password_file" != null) { inherit (res) "password_file"; }
    // {
    }
    // optionalAttrs (res."username" != null) { "username" = mkBasicAuthUsername res."username"; }
    // {
    };
  BasicAuthPasswordModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
  ConsulSDConfigAuthorizationCredentialsModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr ConsulSDConfigAuthorizationCredentialsModule);
        default = null;
      };
      "credentialsFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
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
    // optionalAttrs (res."credentialsFile" != null) { inherit (res) "credentialsFile"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ConsulSDConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        type = (types.nullOr ConsulSDConfigBasicAuthPasswordModule);
        default = null;
      };
      "password_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
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
    // optionalAttrs (res."password_file" != null) { inherit (res) "password_file"; }
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.bool;
        default = false;
      };
      "authorization" = mkOption {
        type = (types.nullOr ConsulSDConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        type = (types.nullOr ConsulSDConfigBasicAuthModule);
        default = null;
      };
      "datacenter" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "filter" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "followRedirects" = mkOption {
        type = types.bool;
        default = false;
      };
      "namespace" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "nodeMeta" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "oauth2" = mkOption {
        type = (types.nullOr ConsulSDConfigOauth2Module);
        default = null;
      };
      "partition" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "proxyURL" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "proxy_client_config" = mkOption {
        type = (types.nullOr ConsulSDConfigProxy_client_configModule);
        default = null;
      };
      "scheme" = mkOption {
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
        type = types.str;
      };
      "services" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "tagSeparator" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "tags" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "tlsConfig" = mkOption {
        type = (types.nullOr ConsulSDConfigTlsConfigModule);
        default = null;
      };
      "tokenRef" = mkOption {
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
    // optionalAttrs (res."filter" != null) { inherit (res) "filter"; }
    // {
    }
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
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
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."proxy_client_config" != null) {
      "proxy_client_config" = mkConsulSDConfigProxy_client_config res."proxy_client_config";
    }
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
  ConsulSDConfigOauth2Client_idConfigMapModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkConsulSDConfigOauth2Client_idConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ConsulSDConfigOauth2Client_idModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr ConsulSDConfigOauth2Client_idConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr ConsulSDConfigOauth2Client_idSecretModule);
        default = null;
      };
    };
  };
  mkConsulSDConfigOauth2Client_id =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkConsulSDConfigOauth2Client_idConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkConsulSDConfigOauth2Client_idSecret res."secret";
    }
    // {
    };
  ConsulSDConfigOauth2Client_idSecretModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkConsulSDConfigOauth2Client_idSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ConsulSDConfigOauth2Client_secretModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkConsulSDConfigOauth2Client_secret =
    res:
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
      "client_id" = mkOption {
        type = ConsulSDConfigOauth2Client_idModule;
      };
      "client_secret" = mkOption {
        type = (types.nullOr ConsulSDConfigOauth2Client_secretModule);
        default = null;
      };
      "client_secret_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "endpoint_params" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "proxy_url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "scopes" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "tls_config" = mkOption {
        type = (types.nullOr types.anything);
        default = null;
      };
      "token_url" = mkOption {
        type = types.str;
      };
    };
  };
  mkConsulSDConfigOauth2 =
    res:
    {
      "client_id" = mkConsulSDConfigOauth2Client_id res."client_id";
    }
    // optionalAttrs (res."client_secret" != null) {
      "client_secret" = mkConsulSDConfigOauth2Client_secret res."client_secret";
    }
    // {
    }
    // optionalAttrs (res."client_secret_file" != null) { inherit (res) "client_secret_file"; }
    // {
    }
    // optionalAttrs (res."endpoint_params" != { }) { inherit (res) "endpoint_params"; }
    // {
    }
    // optionalAttrs (res."proxy_url" != null) { inherit (res) "proxy_url"; }
    // {
    }
    // optionalAttrs (res."scopes" != [ ]) { inherit (res) "scopes"; }
    // {
    }
    // optionalAttrs (res."tls_config" != null) { inherit (res) "tls_config"; }
    // {
      inherit (res) "token_url";
    };
  ConsulSDConfigProxy_client_configBasic_authModule = types.submodule {
    options = {
      "password" = mkOption {
        type = (types.nullOr ConsulSDConfigProxy_client_configBasic_authPasswordModule);
        default = null;
      };
      "password_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
        type = (types.nullOr ConsulSDConfigProxy_client_configBasic_authUsernameModule);
        default = null;
      };
    };
  };
  mkConsulSDConfigProxy_client_configBasic_auth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkConsulSDConfigProxy_client_configBasic_authPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."password_file" != null) { inherit (res) "password_file"; }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkConsulSDConfigProxy_client_configBasic_authUsername res."username";
    }
    // {
    };
  ConsulSDConfigProxy_client_configBasic_authPasswordModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkConsulSDConfigProxy_client_configBasic_authPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ConsulSDConfigProxy_client_configBasic_authUsernameModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkConsulSDConfigProxy_client_configBasic_authUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ConsulSDConfigProxy_client_configBearer_tokenModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkConsulSDConfigProxy_client_configBearer_token =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ConsulSDConfigProxy_client_configModule = types.submodule {
    options = {
      "basic_auth" = mkOption {
        type = (types.nullOr ConsulSDConfigProxy_client_configBasic_authModule);
        default = null;
      };
      "bearer_token" = mkOption {
        type = (types.nullOr ConsulSDConfigProxy_client_configBearer_tokenModule);
        default = null;
      };
      "bearer_token_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "tls_config" = mkOption {
        type = (types.nullOr types.anything);
        default = null;
      };
    };
  };
  mkConsulSDConfigProxy_client_config =
    res:
    {
    }
    // optionalAttrs (res."basic_auth" != null) {
      "basic_auth" = mkConsulSDConfigProxy_client_configBasic_auth res."basic_auth";
    }
    // {
    }
    // optionalAttrs (res."bearer_token" != null) {
      "bearer_token" = mkConsulSDConfigProxy_client_configBearer_token res."bearer_token";
    }
    // {
    }
    // optionalAttrs (res."bearer_token_file" != null) { inherit (res) "bearer_token_file"; }
    // {
    }
    // optionalAttrs (res."tls_config" != null) { inherit (res) "tls_config"; }
    // {
    };
  ConsulSDConfigTlsConfigCaConfigMapModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr ConsulSDConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr ConsulSDConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr ConsulSDConfigTlsConfigCaModule);
        default = null;
      };
      "caFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "cert" = mkOption {
        type = (types.nullOr ConsulSDConfigTlsConfigCertModule);
        default = null;
      };
      "certFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        type = types.bool;
        default = false;
      };
      "keyFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "keySecret" = mkOption {
        type = (types.nullOr ConsulSDConfigTlsConfigKeySecretModule);
        default = null;
      };
      "serverName" = mkOption {
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
    // optionalAttrs (res."caFile" != null) { inherit (res) "caFile"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkConsulSDConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs (res."certFile" != null) { inherit (res) "certFile"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keyFile" != null) { inherit (res) "keyFile"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkConsulSDConfigTlsConfigKeySecret res."keySecret";
    }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    };
  ConsulSDConfigTokenRefModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr DigitalOceanSDConfigAuthorizationCredentialsModule);
        default = null;
      };
      "credentialsFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
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
    // optionalAttrs (res."credentialsFile" != null) { inherit (res) "credentialsFile"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  DigitalOceanSDConfigModule = types.submodule {
    options = {
      "authorization" = mkOption {
        type = (types.nullOr DigitalOceanSDConfigAuthorizationModule);
        default = null;
      };
      "followRedirects" = mkOption {
        type = types.bool;
        default = false;
      };
      "oauth2" = mkOption {
        type = (types.nullOr DigitalOceanSDConfigOauth2Module);
        default = null;
      };
      "port" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "proxyURL" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "proxy_client_config" = mkOption {
        type = (types.nullOr DigitalOceanSDConfigProxy_client_configModule);
        default = null;
      };
      "tlsConfig" = mkOption {
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
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) { "oauth2" = mkDigitalOceanSDConfigOauth2 res."oauth2"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
    }
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."proxy_client_config" != null) {
      "proxy_client_config" = mkDigitalOceanSDConfigProxy_client_config res."proxy_client_config";
    }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkDigitalOceanSDConfigTlsConfig res."tlsConfig";
    }
    // {
    };
  DigitalOceanSDConfigOauth2Client_idConfigMapModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkDigitalOceanSDConfigOauth2Client_idConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DigitalOceanSDConfigOauth2Client_idModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr DigitalOceanSDConfigOauth2Client_idConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr DigitalOceanSDConfigOauth2Client_idSecretModule);
        default = null;
      };
    };
  };
  mkDigitalOceanSDConfigOauth2Client_id =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkDigitalOceanSDConfigOauth2Client_idConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkDigitalOceanSDConfigOauth2Client_idSecret res."secret";
    }
    // {
    };
  DigitalOceanSDConfigOauth2Client_idSecretModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkDigitalOceanSDConfigOauth2Client_idSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DigitalOceanSDConfigOauth2Client_secretModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkDigitalOceanSDConfigOauth2Client_secret =
    res:
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
      "client_id" = mkOption {
        type = DigitalOceanSDConfigOauth2Client_idModule;
      };
      "client_secret" = mkOption {
        type = (types.nullOr DigitalOceanSDConfigOauth2Client_secretModule);
        default = null;
      };
      "client_secret_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "endpoint_params" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "proxy_url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "scopes" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "tls_config" = mkOption {
        type = (types.nullOr types.anything);
        default = null;
      };
      "token_url" = mkOption {
        type = types.str;
      };
    };
  };
  mkDigitalOceanSDConfigOauth2 =
    res:
    {
      "client_id" = mkDigitalOceanSDConfigOauth2Client_id res."client_id";
    }
    // optionalAttrs (res."client_secret" != null) {
      "client_secret" = mkDigitalOceanSDConfigOauth2Client_secret res."client_secret";
    }
    // {
    }
    // optionalAttrs (res."client_secret_file" != null) { inherit (res) "client_secret_file"; }
    // {
    }
    // optionalAttrs (res."endpoint_params" != { }) { inherit (res) "endpoint_params"; }
    // {
    }
    // optionalAttrs (res."proxy_url" != null) { inherit (res) "proxy_url"; }
    // {
    }
    // optionalAttrs (res."scopes" != [ ]) { inherit (res) "scopes"; }
    // {
    }
    // optionalAttrs (res."tls_config" != null) { inherit (res) "tls_config"; }
    // {
      inherit (res) "token_url";
    };
  DigitalOceanSDConfigProxy_client_configBasic_authModule = types.submodule {
    options = {
      "password" = mkOption {
        type = (types.nullOr DigitalOceanSDConfigProxy_client_configBasic_authPasswordModule);
        default = null;
      };
      "password_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
        type = (types.nullOr DigitalOceanSDConfigProxy_client_configBasic_authUsernameModule);
        default = null;
      };
    };
  };
  mkDigitalOceanSDConfigProxy_client_configBasic_auth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkDigitalOceanSDConfigProxy_client_configBasic_authPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."password_file" != null) { inherit (res) "password_file"; }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkDigitalOceanSDConfigProxy_client_configBasic_authUsername res."username";
    }
    // {
    };
  DigitalOceanSDConfigProxy_client_configBasic_authPasswordModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkDigitalOceanSDConfigProxy_client_configBasic_authPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DigitalOceanSDConfigProxy_client_configBasic_authUsernameModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkDigitalOceanSDConfigProxy_client_configBasic_authUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DigitalOceanSDConfigProxy_client_configBearer_tokenModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkDigitalOceanSDConfigProxy_client_configBearer_token =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  DigitalOceanSDConfigProxy_client_configModule = types.submodule {
    options = {
      "basic_auth" = mkOption {
        type = (types.nullOr DigitalOceanSDConfigProxy_client_configBasic_authModule);
        default = null;
      };
      "bearer_token" = mkOption {
        type = (types.nullOr DigitalOceanSDConfigProxy_client_configBearer_tokenModule);
        default = null;
      };
      "bearer_token_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "tls_config" = mkOption {
        type = (types.nullOr types.anything);
        default = null;
      };
    };
  };
  mkDigitalOceanSDConfigProxy_client_config =
    res:
    {
    }
    // optionalAttrs (res."basic_auth" != null) {
      "basic_auth" = mkDigitalOceanSDConfigProxy_client_configBasic_auth res."basic_auth";
    }
    // {
    }
    // optionalAttrs (res."bearer_token" != null) {
      "bearer_token" = mkDigitalOceanSDConfigProxy_client_configBearer_token res."bearer_token";
    }
    // {
    }
    // optionalAttrs (res."bearer_token_file" != null) { inherit (res) "bearer_token_file"; }
    // {
    }
    // optionalAttrs (res."tls_config" != null) { inherit (res) "tls_config"; }
    // {
    };
  DigitalOceanSDConfigTlsConfigCaConfigMapModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr DigitalOceanSDConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr DigitalOceanSDConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr DigitalOceanSDConfigTlsConfigCaModule);
        default = null;
      };
      "caFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "cert" = mkOption {
        type = (types.nullOr DigitalOceanSDConfigTlsConfigCertModule);
        default = null;
      };
      "certFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        type = types.bool;
        default = false;
      };
      "keyFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "keySecret" = mkOption {
        type = (types.nullOr DigitalOceanSDConfigTlsConfigKeySecretModule);
        default = null;
      };
      "serverName" = mkOption {
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
    // optionalAttrs (res."caFile" != null) { inherit (res) "caFile"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkDigitalOceanSDConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs (res."certFile" != null) { inherit (res) "certFile"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keyFile" != null) { inherit (res) "keyFile"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkDigitalOceanSDConfigTlsConfigKeySecret res."keySecret";
    }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    };
  DnsSDConfigModule = types.submodule {
    options = {
      "names" = mkOption {
        type = (types.listOf types.str);
      };
      "port" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "type" = mkOption {
        type = (
          types.nullOr (
            types.enum [
              "SRV"
              "A"
              "AAAA"
              "MX"
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
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  Ec2SDConfigAccessKeyModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.str;
      };
      "values" = mkOption {
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
        type = (types.nullOr Ec2SDConfigAccessKeyModule);
        default = null;
      };
      "filters" = mkOption {
        type = (types.listOf Ec2SDConfigFilterModule);
        default = [ ];
      };
      "port" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "region" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "roleARN" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "secretKey" = mkOption {
        type = (types.nullOr Ec2SDConfigSecretKeyModule);
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
    // optionalAttrs (res."filters" != [ ]) { "filters" = map mkEc2SDConfigFilter res."filters"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
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
    };
  Ec2SDConfigSecretKeyModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
  FileSDConfigModule = types.submodule {
    options = {
      "files" = mkOption {
        type = (types.listOf types.str);
      };
    };
  };
  mkFileSDConfig = res: {
    inherit (res) "files";
  };
  GceSDConfigModule = types.submodule {
    options = {
      "filter" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "project" = mkOption {
        type = types.str;
      };
      "tagSeparator" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "zone" = mkOption {
        type = types.anything;
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
    // optionalAttrs (res."tagSeparator" != null) { inherit (res) "tagSeparator"; }
    // {
      inherit (res) "zone";
    };
  HttpSDConfigAuthorizationCredentialsModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr HttpSDConfigAuthorizationCredentialsModule);
        default = null;
      };
      "credentialsFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
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
    // optionalAttrs (res."credentialsFile" != null) { inherit (res) "credentialsFile"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  HttpSDConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        type = (types.nullOr HttpSDConfigBasicAuthPasswordModule);
        default = null;
      };
      "password_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
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
    // optionalAttrs (res."password_file" != null) { inherit (res) "password_file"; }
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr HttpSDConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        type = (types.nullOr HttpSDConfigBasicAuthModule);
        default = null;
      };
      "proxyURL" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "proxy_client_config" = mkOption {
        type = (types.nullOr HttpSDConfigProxy_client_configModule);
        default = null;
      };
      "tlsConfig" = mkOption {
        type = (types.nullOr HttpSDConfigTlsConfigModule);
        default = null;
      };
      "url" = mkOption {
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
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."proxy_client_config" != null) {
      "proxy_client_config" = mkHttpSDConfigProxy_client_config res."proxy_client_config";
    }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkHttpSDConfigTlsConfig res."tlsConfig";
    }
    // {
      inherit (res) "url";
    };
  HttpSDConfigProxy_client_configBasic_authModule = types.submodule {
    options = {
      "password" = mkOption {
        type = (types.nullOr HttpSDConfigProxy_client_configBasic_authPasswordModule);
        default = null;
      };
      "password_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
        type = (types.nullOr HttpSDConfigProxy_client_configBasic_authUsernameModule);
        default = null;
      };
    };
  };
  mkHttpSDConfigProxy_client_configBasic_auth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkHttpSDConfigProxy_client_configBasic_authPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."password_file" != null) { inherit (res) "password_file"; }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkHttpSDConfigProxy_client_configBasic_authUsername res."username";
    }
    // {
    };
  HttpSDConfigProxy_client_configBasic_authPasswordModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkHttpSDConfigProxy_client_configBasic_authPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HttpSDConfigProxy_client_configBasic_authUsernameModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkHttpSDConfigProxy_client_configBasic_authUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HttpSDConfigProxy_client_configBearer_tokenModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkHttpSDConfigProxy_client_configBearer_token =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  HttpSDConfigProxy_client_configModule = types.submodule {
    options = {
      "basic_auth" = mkOption {
        type = (types.nullOr HttpSDConfigProxy_client_configBasic_authModule);
        default = null;
      };
      "bearer_token" = mkOption {
        type = (types.nullOr HttpSDConfigProxy_client_configBearer_tokenModule);
        default = null;
      };
      "bearer_token_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "tls_config" = mkOption {
        type = (types.nullOr types.anything);
        default = null;
      };
    };
  };
  mkHttpSDConfigProxy_client_config =
    res:
    {
    }
    // optionalAttrs (res."basic_auth" != null) {
      "basic_auth" = mkHttpSDConfigProxy_client_configBasic_auth res."basic_auth";
    }
    // {
    }
    // optionalAttrs (res."bearer_token" != null) {
      "bearer_token" = mkHttpSDConfigProxy_client_configBearer_token res."bearer_token";
    }
    // {
    }
    // optionalAttrs (res."bearer_token_file" != null) { inherit (res) "bearer_token_file"; }
    // {
    }
    // optionalAttrs (res."tls_config" != null) { inherit (res) "tls_config"; }
    // {
    };
  HttpSDConfigTlsConfigCaConfigMapModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr HttpSDConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr HttpSDConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr HttpSDConfigTlsConfigCaModule);
        default = null;
      };
      "caFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "cert" = mkOption {
        type = (types.nullOr HttpSDConfigTlsConfigCertModule);
        default = null;
      };
      "certFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        type = types.bool;
        default = false;
      };
      "keyFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "keySecret" = mkOption {
        type = (types.nullOr HttpSDConfigTlsConfigKeySecretModule);
        default = null;
      };
      "serverName" = mkOption {
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
    // optionalAttrs (res."caFile" != null) { inherit (res) "caFile"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkHttpSDConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs (res."certFile" != null) { inherit (res) "certFile"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keyFile" != null) { inherit (res) "keyFile"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkHttpSDConfigTlsConfigKeySecret res."keySecret";
    }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    };
  KubernetesSDConfigAttach_metadataModule = types.submodule {
    options = {
      "namespace" = mkOption {
        type = types.bool;
        default = false;
      };
      "node" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkKubernetesSDConfigAttach_metadata =
    res:
    {
    }
    // optionalAttrs res."namespace" { inherit (res) "namespace"; }
    // {
    }
    // optionalAttrs res."node" { inherit (res) "node"; }
    // {
    };
  KubernetesSDConfigAuthorizationCredentialsModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr KubernetesSDConfigAuthorizationCredentialsModule);
        default = null;
      };
      "credentialsFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
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
    // optionalAttrs (res."credentialsFile" != null) { inherit (res) "credentialsFile"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  KubernetesSDConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        type = (types.nullOr KubernetesSDConfigBasicAuthPasswordModule);
        default = null;
      };
      "password_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
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
    // optionalAttrs (res."password_file" != null) { inherit (res) "password_file"; }
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr types.str);
        default = null;
      };
      "attach_metadata" = mkOption {
        type = (types.nullOr KubernetesSDConfigAttach_metadataModule);
        default = null;
      };
      "authorization" = mkOption {
        type = (types.nullOr KubernetesSDConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        type = (types.nullOr KubernetesSDConfigBasicAuthModule);
        default = null;
      };
      "followRedirects" = mkOption {
        type = types.bool;
        default = false;
      };
      "namespaces" = mkOption {
        type = (types.nullOr KubernetesSDConfigNamespacesModule);
        default = null;
      };
      "oauth2" = mkOption {
        type = (types.nullOr KubernetesSDConfigOauth2Module);
        default = null;
      };
      "proxyURL" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "proxy_client_config" = mkOption {
        type = (types.nullOr KubernetesSDConfigProxy_client_configModule);
        default = null;
      };
      "role" = mkOption {
        type = (
          types.enum [
            "node"
            "pod"
            "service"
            "endpoints"
            "endpointslice"
            "ingress"
          ]
        );
      };
      "selectors" = mkOption {
        type = (types.listOf KubernetesSDConfigSelectorModule);
        default = [ ];
      };
      "tlsConfig" = mkOption {
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
    // optionalAttrs (res."attach_metadata" != null) {
      "attach_metadata" = mkKubernetesSDConfigAttach_metadata res."attach_metadata";
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
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."namespaces" != null) {
      "namespaces" = mkKubernetesSDConfigNamespaces res."namespaces";
    }
    // {
    }
    // optionalAttrs (res."oauth2" != null) { "oauth2" = mkKubernetesSDConfigOauth2 res."oauth2"; }
    // {
    }
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."proxy_client_config" != null) {
      "proxy_client_config" = mkKubernetesSDConfigProxy_client_config res."proxy_client_config";
    }
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
        type = (types.listOf types.str);
        default = [ ];
      };
      "ownNamespace" = mkOption {
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
  KubernetesSDConfigOauth2Client_idConfigMapModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkKubernetesSDConfigOauth2Client_idConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KubernetesSDConfigOauth2Client_idModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr KubernetesSDConfigOauth2Client_idConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr KubernetesSDConfigOauth2Client_idSecretModule);
        default = null;
      };
    };
  };
  mkKubernetesSDConfigOauth2Client_id =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkKubernetesSDConfigOauth2Client_idConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkKubernetesSDConfigOauth2Client_idSecret res."secret";
    }
    // {
    };
  KubernetesSDConfigOauth2Client_idSecretModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkKubernetesSDConfigOauth2Client_idSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KubernetesSDConfigOauth2Client_secretModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkKubernetesSDConfigOauth2Client_secret =
    res:
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
      "client_id" = mkOption {
        type = KubernetesSDConfigOauth2Client_idModule;
      };
      "client_secret" = mkOption {
        type = (types.nullOr KubernetesSDConfigOauth2Client_secretModule);
        default = null;
      };
      "client_secret_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "endpoint_params" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "proxy_url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "scopes" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "tls_config" = mkOption {
        type = (types.nullOr types.anything);
        default = null;
      };
      "token_url" = mkOption {
        type = types.str;
      };
    };
  };
  mkKubernetesSDConfigOauth2 =
    res:
    {
      "client_id" = mkKubernetesSDConfigOauth2Client_id res."client_id";
    }
    // optionalAttrs (res."client_secret" != null) {
      "client_secret" = mkKubernetesSDConfigOauth2Client_secret res."client_secret";
    }
    // {
    }
    // optionalAttrs (res."client_secret_file" != null) { inherit (res) "client_secret_file"; }
    // {
    }
    // optionalAttrs (res."endpoint_params" != { }) { inherit (res) "endpoint_params"; }
    // {
    }
    // optionalAttrs (res."proxy_url" != null) { inherit (res) "proxy_url"; }
    // {
    }
    // optionalAttrs (res."scopes" != [ ]) { inherit (res) "scopes"; }
    // {
    }
    // optionalAttrs (res."tls_config" != null) { inherit (res) "tls_config"; }
    // {
      inherit (res) "token_url";
    };
  KubernetesSDConfigProxy_client_configBasic_authModule = types.submodule {
    options = {
      "password" = mkOption {
        type = (types.nullOr KubernetesSDConfigProxy_client_configBasic_authPasswordModule);
        default = null;
      };
      "password_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
        type = (types.nullOr KubernetesSDConfigProxy_client_configBasic_authUsernameModule);
        default = null;
      };
    };
  };
  mkKubernetesSDConfigProxy_client_configBasic_auth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkKubernetesSDConfigProxy_client_configBasic_authPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."password_file" != null) { inherit (res) "password_file"; }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkKubernetesSDConfigProxy_client_configBasic_authUsername res."username";
    }
    // {
    };
  KubernetesSDConfigProxy_client_configBasic_authPasswordModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkKubernetesSDConfigProxy_client_configBasic_authPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KubernetesSDConfigProxy_client_configBasic_authUsernameModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkKubernetesSDConfigProxy_client_configBasic_authUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KubernetesSDConfigProxy_client_configBearer_tokenModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkKubernetesSDConfigProxy_client_configBearer_token =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  KubernetesSDConfigProxy_client_configModule = types.submodule {
    options = {
      "basic_auth" = mkOption {
        type = (types.nullOr KubernetesSDConfigProxy_client_configBasic_authModule);
        default = null;
      };
      "bearer_token" = mkOption {
        type = (types.nullOr KubernetesSDConfigProxy_client_configBearer_tokenModule);
        default = null;
      };
      "bearer_token_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "tls_config" = mkOption {
        type = (types.nullOr types.anything);
        default = null;
      };
    };
  };
  mkKubernetesSDConfigProxy_client_config =
    res:
    {
    }
    // optionalAttrs (res."basic_auth" != null) {
      "basic_auth" = mkKubernetesSDConfigProxy_client_configBasic_auth res."basic_auth";
    }
    // {
    }
    // optionalAttrs (res."bearer_token" != null) {
      "bearer_token" = mkKubernetesSDConfigProxy_client_configBearer_token res."bearer_token";
    }
    // {
    }
    // optionalAttrs (res."bearer_token_file" != null) { inherit (res) "bearer_token_file"; }
    // {
    }
    // optionalAttrs (res."tls_config" != null) { inherit (res) "tls_config"; }
    // {
    };
  KubernetesSDConfigSelectorModule = types.submodule {
    options = {
      "field" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "label" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "role" = mkOption {
        type = (
          types.enum [
            "node"
            "pod"
            "service"
            "endpoints"
            "endpointslice"
            "ingress"
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr KubernetesSDConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr KubernetesSDConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr KubernetesSDConfigTlsConfigCaModule);
        default = null;
      };
      "caFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "cert" = mkOption {
        type = (types.nullOr KubernetesSDConfigTlsConfigCertModule);
        default = null;
      };
      "certFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        type = types.bool;
        default = false;
      };
      "keyFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "keySecret" = mkOption {
        type = (types.nullOr KubernetesSDConfigTlsConfigKeySecretModule);
        default = null;
      };
      "serverName" = mkOption {
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
    // optionalAttrs (res."caFile" != null) { inherit (res) "caFile"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkKubernetesSDConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs (res."certFile" != null) { inherit (res) "certFile"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keyFile" != null) { inherit (res) "keyFile"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkKubernetesSDConfigTlsConfigKeySecret res."keySecret";
    }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    };
  MetricRelabelConfigModule = types.submodule {
    options = {
      "action" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "if" = mkOption {
        type = (types.nullOr types.anything);
        default = null;
      };
      "labels" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "match" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "modulus" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "regex" = mkOption {
        type = (types.nullOr types.anything);
        default = null;
      };
      "replacement" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "separator" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "sourceLabels" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "source_labels" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "targetLabel" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "target_label" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkMetricRelabelConfig =
    res:
    {
    }
    // optionalAttrs (res."action" != null) { inherit (res) "action"; }
    // {
    }
    // optionalAttrs (res."if" != null) { inherit (res) "if"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."match" != null) { inherit (res) "match"; }
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
    // optionalAttrs (res."source_labels" != [ ]) { inherit (res) "source_labels"; }
    // {
    }
    // optionalAttrs (res."targetLabel" != null) { inherit (res) "targetLabel"; }
    // {
    }
    // optionalAttrs (res."target_label" != null) { inherit (res) "target_label"; }
    // {
    };
  NomadSDConfigAuthorizationCredentialsModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr NomadSDConfigAuthorizationCredentialsModule);
        default = null;
      };
      "credentialsFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
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
    // optionalAttrs (res."credentialsFile" != null) { inherit (res) "credentialsFile"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  NomadSDConfigBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        type = (types.nullOr NomadSDConfigBasicAuthPasswordModule);
        default = null;
      };
      "password_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
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
    // optionalAttrs (res."password_file" != null) { inherit (res) "password_file"; }
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.bool;
        default = false;
      };
      "authorization" = mkOption {
        type = (types.nullOr NomadSDConfigAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        type = (types.nullOr NomadSDConfigBasicAuthModule);
        default = null;
      };
      "followRedirects" = mkOption {
        type = types.bool;
        default = false;
      };
      "namespace" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "oauth2" = mkOption {
        type = (types.nullOr NomadSDConfigOauth2Module);
        default = null;
      };
      "proxyURL" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "proxy_client_config" = mkOption {
        type = (types.nullOr NomadSDConfigProxy_client_configModule);
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
    // optionalAttrs res."followRedirects" { inherit (res) "followRedirects"; }
    // {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    }
    // optionalAttrs (res."oauth2" != null) { "oauth2" = mkNomadSDConfigOauth2 res."oauth2"; }
    // {
    }
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."proxy_client_config" != null) {
      "proxy_client_config" = mkNomadSDConfigProxy_client_config res."proxy_client_config";
    }
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
  NomadSDConfigOauth2Client_idConfigMapModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkNomadSDConfigOauth2Client_idConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  NomadSDConfigOauth2Client_idModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr NomadSDConfigOauth2Client_idConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr NomadSDConfigOauth2Client_idSecretModule);
        default = null;
      };
    };
  };
  mkNomadSDConfigOauth2Client_id =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkNomadSDConfigOauth2Client_idConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkNomadSDConfigOauth2Client_idSecret res."secret";
    }
    // {
    };
  NomadSDConfigOauth2Client_idSecretModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkNomadSDConfigOauth2Client_idSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  NomadSDConfigOauth2Client_secretModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkNomadSDConfigOauth2Client_secret =
    res:
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
      "client_id" = mkOption {
        type = NomadSDConfigOauth2Client_idModule;
      };
      "client_secret" = mkOption {
        type = (types.nullOr NomadSDConfigOauth2Client_secretModule);
        default = null;
      };
      "client_secret_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "endpoint_params" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "proxy_url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "scopes" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "tls_config" = mkOption {
        type = (types.nullOr types.anything);
        default = null;
      };
      "token_url" = mkOption {
        type = types.str;
      };
    };
  };
  mkNomadSDConfigOauth2 =
    res:
    {
      "client_id" = mkNomadSDConfigOauth2Client_id res."client_id";
    }
    // optionalAttrs (res."client_secret" != null) {
      "client_secret" = mkNomadSDConfigOauth2Client_secret res."client_secret";
    }
    // {
    }
    // optionalAttrs (res."client_secret_file" != null) { inherit (res) "client_secret_file"; }
    // {
    }
    // optionalAttrs (res."endpoint_params" != { }) { inherit (res) "endpoint_params"; }
    // {
    }
    // optionalAttrs (res."proxy_url" != null) { inherit (res) "proxy_url"; }
    // {
    }
    // optionalAttrs (res."scopes" != [ ]) { inherit (res) "scopes"; }
    // {
    }
    // optionalAttrs (res."tls_config" != null) { inherit (res) "tls_config"; }
    // {
      inherit (res) "token_url";
    };
  NomadSDConfigProxy_client_configBasic_authModule = types.submodule {
    options = {
      "password" = mkOption {
        type = (types.nullOr NomadSDConfigProxy_client_configBasic_authPasswordModule);
        default = null;
      };
      "password_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
        type = (types.nullOr NomadSDConfigProxy_client_configBasic_authUsernameModule);
        default = null;
      };
    };
  };
  mkNomadSDConfigProxy_client_configBasic_auth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkNomadSDConfigProxy_client_configBasic_authPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."password_file" != null) { inherit (res) "password_file"; }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkNomadSDConfigProxy_client_configBasic_authUsername res."username";
    }
    // {
    };
  NomadSDConfigProxy_client_configBasic_authPasswordModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkNomadSDConfigProxy_client_configBasic_authPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  NomadSDConfigProxy_client_configBasic_authUsernameModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkNomadSDConfigProxy_client_configBasic_authUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  NomadSDConfigProxy_client_configBearer_tokenModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkNomadSDConfigProxy_client_configBearer_token =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  NomadSDConfigProxy_client_configModule = types.submodule {
    options = {
      "basic_auth" = mkOption {
        type = (types.nullOr NomadSDConfigProxy_client_configBasic_authModule);
        default = null;
      };
      "bearer_token" = mkOption {
        type = (types.nullOr NomadSDConfigProxy_client_configBearer_tokenModule);
        default = null;
      };
      "bearer_token_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "tls_config" = mkOption {
        type = (types.nullOr types.anything);
        default = null;
      };
    };
  };
  mkNomadSDConfigProxy_client_config =
    res:
    {
    }
    // optionalAttrs (res."basic_auth" != null) {
      "basic_auth" = mkNomadSDConfigProxy_client_configBasic_auth res."basic_auth";
    }
    // {
    }
    // optionalAttrs (res."bearer_token" != null) {
      "bearer_token" = mkNomadSDConfigProxy_client_configBearer_token res."bearer_token";
    }
    // {
    }
    // optionalAttrs (res."bearer_token_file" != null) { inherit (res) "bearer_token_file"; }
    // {
    }
    // optionalAttrs (res."tls_config" != null) { inherit (res) "tls_config"; }
    // {
    };
  NomadSDConfigTlsConfigCaConfigMapModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr NomadSDConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr NomadSDConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr NomadSDConfigTlsConfigCaModule);
        default = null;
      };
      "caFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "cert" = mkOption {
        type = (types.nullOr NomadSDConfigTlsConfigCertModule);
        default = null;
      };
      "certFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        type = types.bool;
        default = false;
      };
      "keyFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "keySecret" = mkOption {
        type = (types.nullOr NomadSDConfigTlsConfigKeySecretModule);
        default = null;
      };
      "serverName" = mkOption {
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
    // optionalAttrs (res."caFile" != null) { inherit (res) "caFile"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkNomadSDConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs (res."certFile" != null) { inherit (res) "certFile"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keyFile" != null) { inherit (res) "keyFile"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkNomadSDConfigTlsConfigKeySecret res."keySecret";
    }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    };
  Oauth2Client_idConfigMapModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkOauth2Client_idConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  Oauth2Client_idModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr Oauth2Client_idConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr Oauth2Client_idSecretModule);
        default = null;
      };
    };
  };
  mkOauth2Client_id =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkOauth2Client_idConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkOauth2Client_idSecret res."secret"; }
    // {
    };
  Oauth2Client_idSecretModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkOauth2Client_idSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  Oauth2Client_secretModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkOauth2Client_secret =
    res:
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
      "client_id" = mkOption {
        type = Oauth2Client_idModule;
      };
      "client_secret" = mkOption {
        type = (types.nullOr Oauth2Client_secretModule);
        default = null;
      };
      "client_secret_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "endpoint_params" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "proxy_url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "scopes" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "tls_config" = mkOption {
        type = (types.nullOr types.anything);
        default = null;
      };
      "token_url" = mkOption {
        type = types.str;
      };
    };
  };
  mkOauth2 =
    res:
    {
      "client_id" = mkOauth2Client_id res."client_id";
    }
    // optionalAttrs (res."client_secret" != null) {
      "client_secret" = mkOauth2Client_secret res."client_secret";
    }
    // {
    }
    // optionalAttrs (res."client_secret_file" != null) { inherit (res) "client_secret_file"; }
    // {
    }
    // optionalAttrs (res."endpoint_params" != { }) { inherit (res) "endpoint_params"; }
    // {
    }
    // optionalAttrs (res."proxy_url" != null) { inherit (res) "proxy_url"; }
    // {
    }
    // optionalAttrs (res."scopes" != [ ]) { inherit (res) "scopes"; }
    // {
    }
    // optionalAttrs (res."tls_config" != null) { inherit (res) "tls_config"; }
    // {
      inherit (res) "token_url";
    };
  OpenstackSDConfigApplicationCredentialSecretModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.bool;
        default = false;
      };
      "applicationCredentialId" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "applicationCredentialName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "applicationCredentialSecret" = mkOption {
        type = (types.nullOr OpenstackSDConfigApplicationCredentialSecretModule);
        default = null;
      };
      "availability" = mkOption {
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
        type = (types.nullOr types.str);
        default = null;
      };
      "domainName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "identityEndpoint" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "password" = mkOption {
        type = (types.nullOr OpenstackSDConfigPasswordModule);
        default = null;
      };
      "port" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "projectID" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "projectName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "region" = mkOption {
        type = types.str;
      };
      "role" = mkOption {
        type = (
          types.enum [
            "Instance"
            "instance"
            "Hypervisor"
            "hypervisor"
          ]
        );
      };
      "tlsConfig" = mkOption {
        type = (types.nullOr OpenstackSDConfigTlsConfigModule);
        default = null;
      };
      "userid" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr OpenstackSDConfigTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr OpenstackSDConfigTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr OpenstackSDConfigTlsConfigCaModule);
        default = null;
      };
      "caFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "cert" = mkOption {
        type = (types.nullOr OpenstackSDConfigTlsConfigCertModule);
        default = null;
      };
      "certFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        type = types.bool;
        default = false;
      };
      "keyFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "keySecret" = mkOption {
        type = (types.nullOr OpenstackSDConfigTlsConfigKeySecretModule);
        default = null;
      };
      "serverName" = mkOption {
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
    // optionalAttrs (res."caFile" != null) { inherit (res) "caFile"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkOpenstackSDConfigTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs (res."certFile" != null) { inherit (res) "certFile"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keyFile" != null) { inherit (res) "keyFile"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) {
      "keySecret" = mkOpenstackSDConfigTlsConfigKeySecret res."keySecret";
    }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    };
  RelabelConfigModule = types.submodule {
    options = {
      "action" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "if" = mkOption {
        type = (types.nullOr types.anything);
        default = null;
      };
      "labels" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "match" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "modulus" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "regex" = mkOption {
        type = (types.nullOr types.anything);
        default = null;
      };
      "replacement" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "separator" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "sourceLabels" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "source_labels" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "targetLabel" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "target_label" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkRelabelConfig =
    res:
    {
    }
    // optionalAttrs (res."action" != null) { inherit (res) "action"; }
    // {
    }
    // optionalAttrs (res."if" != null) { inherit (res) "if"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."match" != null) { inherit (res) "match"; }
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
    // optionalAttrs (res."source_labels" != [ ]) { inherit (res) "source_labels"; }
    // {
    }
    // optionalAttrs (res."targetLabel" != null) { inherit (res) "targetLabel"; }
    // {
    }
    // optionalAttrs (res."target_label" != null) { inherit (res) "target_label"; }
    // {
    };
  StaticConfigModule = types.submodule {
    options = {
      "labels" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "targets" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkStaticConfig =
    res:
    {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."targets" != [ ]) { inherit (res) "targets"; }
    // {
    };
  TlsConfigCaConfigMapModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr TlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr TlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
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
        type = (types.nullOr TlsConfigCaModule);
        default = null;
      };
      "caFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "cert" = mkOption {
        type = (types.nullOr TlsConfigCertModule);
        default = null;
      };
      "certFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "insecureSkipVerify" = mkOption {
        type = types.bool;
        default = false;
      };
      "keyFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "keySecret" = mkOption {
        type = (types.nullOr TlsConfigKeySecretModule);
        default = null;
      };
      "serverName" = mkOption {
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
    // optionalAttrs (res."caFile" != null) { inherit (res) "caFile"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkTlsConfigCert res."cert"; }
    // {
    }
    // optionalAttrs (res."certFile" != null) { inherit (res) "certFile"; }
    // {
    }
    // optionalAttrs res."insecureSkipVerify" { inherit (res) "insecureSkipVerify"; }
    // {
    }
    // optionalAttrs (res."keyFile" != null) { inherit (res) "keyFile"; }
    // {
    }
    // optionalAttrs (res."keySecret" != null) { "keySecret" = mkTlsConfigKeySecret res."keySecret"; }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    };
  Vm_scrape_paramsModule = types.submodule {
    options = {
      "disable_compression" = mkOption {
        type = types.bool;
        default = false;
      };
      "disable_keep_alive" = mkOption {
        type = types.bool;
        default = false;
      };
      "headers" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "no_stale_markers" = mkOption {
        type = types.bool;
        default = false;
      };
      "proxy_client_config" = mkOption {
        type = (types.nullOr Vm_scrape_paramsProxy_client_configModule);
        default = null;
      };
      "scrape_align_interval" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "scrape_offset" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "stream_parse" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkVm_scrape_params =
    res:
    {
    }
    // optionalAttrs res."disable_compression" { inherit (res) "disable_compression"; }
    // {
    }
    // optionalAttrs res."disable_keep_alive" { inherit (res) "disable_keep_alive"; }
    // {
    }
    // optionalAttrs (res."headers" != [ ]) { inherit (res) "headers"; }
    // {
    }
    // optionalAttrs res."no_stale_markers" { inherit (res) "no_stale_markers"; }
    // {
    }
    // optionalAttrs (res."proxy_client_config" != null) {
      "proxy_client_config" = mkVm_scrape_paramsProxy_client_config res."proxy_client_config";
    }
    // {
    }
    // optionalAttrs (res."scrape_align_interval" != null) { inherit (res) "scrape_align_interval"; }
    // {
    }
    // optionalAttrs (res."scrape_offset" != null) { inherit (res) "scrape_offset"; }
    // {
    }
    // optionalAttrs res."stream_parse" { inherit (res) "stream_parse"; }
    // {
    };
  Vm_scrape_paramsProxy_client_configBasic_authModule = types.submodule {
    options = {
      "password" = mkOption {
        type = (types.nullOr Vm_scrape_paramsProxy_client_configBasic_authPasswordModule);
        default = null;
      };
      "password_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
        type = (types.nullOr Vm_scrape_paramsProxy_client_configBasic_authUsernameModule);
        default = null;
      };
    };
  };
  mkVm_scrape_paramsProxy_client_configBasic_auth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkVm_scrape_paramsProxy_client_configBasic_authPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."password_file" != null) { inherit (res) "password_file"; }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkVm_scrape_paramsProxy_client_configBasic_authUsername res."username";
    }
    // {
    };
  Vm_scrape_paramsProxy_client_configBasic_authPasswordModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkVm_scrape_paramsProxy_client_configBasic_authPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  Vm_scrape_paramsProxy_client_configBasic_authUsernameModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkVm_scrape_paramsProxy_client_configBasic_authUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  Vm_scrape_paramsProxy_client_configBearer_tokenModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkVm_scrape_paramsProxy_client_configBearer_token =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  Vm_scrape_paramsProxy_client_configModule = types.submodule {
    options = {
      "basic_auth" = mkOption {
        type = (types.nullOr Vm_scrape_paramsProxy_client_configBasic_authModule);
        default = null;
      };
      "bearer_token" = mkOption {
        type = (types.nullOr Vm_scrape_paramsProxy_client_configBearer_tokenModule);
        default = null;
      };
      "bearer_token_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "tls_config" = mkOption {
        type = (types.nullOr types.anything);
        default = null;
      };
    };
  };
  mkVm_scrape_paramsProxy_client_config =
    res:
    {
    }
    // optionalAttrs (res."basic_auth" != null) {
      "basic_auth" = mkVm_scrape_paramsProxy_client_configBasic_auth res."basic_auth";
    }
    // {
    }
    // optionalAttrs (res."bearer_token" != null) {
      "bearer_token" = mkVm_scrape_paramsProxy_client_configBearer_token res."bearer_token";
    }
    // {
    }
    // optionalAttrs (res."bearer_token_file" != null) { inherit (res) "bearer_token_file"; }
    // {
    }
    // optionalAttrs (res."tls_config" != null) { inherit (res) "tls_config"; }
    // {
    };
  VmscrapeconfigsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this VMScrapeConfig resource.";
        };
        "authorization" = mkOption {
          type = (types.nullOr AuthorizationModule);
          default = null;
        };
        "azureSDConfigs" = mkOption {
          type = (types.listOf AzureSDConfigModule);
          default = [ ];
        };
        "basicAuth" = mkOption {
          type = (types.nullOr BasicAuthModule);
          default = null;
        };
        "bearerTokenFile" = mkOption {
          type = (types.nullOr types.str);
          default = null;
        };
        "bearerTokenSecret" = mkOption {
          type = (types.nullOr BearerTokenSecretModule);
          default = null;
        };
        "consulSDConfigs" = mkOption {
          type = (types.listOf ConsulSDConfigModule);
          default = [ ];
        };
        "digitalOceanSDConfigs" = mkOption {
          type = (types.listOf DigitalOceanSDConfigModule);
          default = [ ];
        };
        "dnsSDConfigs" = mkOption {
          type = (types.listOf DnsSDConfigModule);
          default = [ ];
        };
        "ec2SDConfigs" = mkOption {
          type = (types.listOf Ec2SDConfigModule);
          default = [ ];
        };
        "fileSDConfigs" = mkOption {
          type = (types.listOf FileSDConfigModule);
          default = [ ];
        };
        "follow_redirects" = mkOption {
          type = types.bool;
          default = false;
        };
        "gceSDConfigs" = mkOption {
          type = (types.listOf GceSDConfigModule);
          default = [ ];
        };
        "honorLabels" = mkOption {
          type = types.bool;
          default = false;
        };
        "honorTimestamps" = mkOption {
          type = types.bool;
          default = false;
        };
        "httpSDConfigs" = mkOption {
          type = (types.listOf HttpSDConfigModule);
          default = [ ];
        };
        "interval" = mkOption {
          type = (types.nullOr types.str);
          default = null;
        };
        "kubernetesSDConfigs" = mkOption {
          type = (types.listOf KubernetesSDConfigModule);
          default = [ ];
        };
        "max_scrape_size" = mkOption {
          type = (types.nullOr types.str);
          default = null;
        };
        "metricRelabelConfigs" = mkOption {
          type = (types.listOf MetricRelabelConfigModule);
          default = [ ];
        };
        "nomadSDConfigs" = mkOption {
          type = (types.listOf NomadSDConfigModule);
          default = [ ];
        };
        "oauth2" = mkOption {
          type = (types.nullOr Oauth2Module);
          default = null;
        };
        "openstackSDConfigs" = mkOption {
          type = (types.listOf OpenstackSDConfigModule);
          default = [ ];
        };
        "params" = mkOption {
          type = (types.attrsOf (types.listOf types.str));
          default = { };
        };
        "path" = mkOption {
          type = (types.nullOr types.str);
          default = null;
        };
        "proxyURL" = mkOption {
          type = (types.nullOr types.str);
          default = null;
        };
        "relabelConfigs" = mkOption {
          type = (types.listOf RelabelConfigModule);
          default = [ ];
        };
        "sampleLimit" = mkOption {
          type = (types.nullOr types.int);
          default = null;
        };
        "scheme" = mkOption {
          type = (
            types.nullOr (
              types.enum [
                "http"
                "https"
                "HTTPS"
                "HTTP"
              ]
            )
          );
          default = null;
        };
        "scrapeClass" = mkOption {
          type = (types.nullOr types.str);
          default = null;
        };
        "scrapeTimeout" = mkOption {
          type = (types.nullOr types.str);
          default = null;
        };
        "scrape_interval" = mkOption {
          type = (types.nullOr types.str);
          default = null;
        };
        "seriesLimit" = mkOption {
          type = (types.nullOr types.int);
          default = null;
        };
        "staticConfigs" = mkOption {
          type = (types.listOf StaticConfigModule);
          default = [ ];
        };
        "tlsConfig" = mkOption {
          type = (types.nullOr TlsConfigModule);
          default = null;
        };
        "vm_scrape_params" = mkOption {
          type = (types.nullOr Vm_scrape_paramsModule);
          default = null;
        };
      };
    }
  );
  mkVMScrapeConfig = name: res: {
    apiVersion = "operator.victoriametrics.com/v1beta1";
    kind = "VMScrapeConfig";
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
    // optionalAttrs (res."bearerTokenFile" != null) { inherit (res) "bearerTokenFile"; }
    // {
    }
    // optionalAttrs (res."bearerTokenSecret" != null) {
      "bearerTokenSecret" = mkBearerTokenSecret res."bearerTokenSecret";
    }
    // {
    }
    // optionalAttrs (res."consulSDConfigs" != [ ]) {
      "consulSDConfigs" = map mkConsulSDConfig res."consulSDConfigs";
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
    // optionalAttrs (res."ec2SDConfigs" != [ ]) {
      "ec2SDConfigs" = map mkEc2SDConfig res."ec2SDConfigs";
    }
    // {
    }
    // optionalAttrs (res."fileSDConfigs" != [ ]) {
      "fileSDConfigs" = map mkFileSDConfig res."fileSDConfigs";
    }
    // {
    }
    // optionalAttrs res."follow_redirects" { inherit (res) "follow_redirects"; }
    // {
    }
    // optionalAttrs (res."gceSDConfigs" != [ ]) {
      "gceSDConfigs" = map mkGceSDConfig res."gceSDConfigs";
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
    // optionalAttrs (res."interval" != null) { inherit (res) "interval"; }
    // {
    }
    // optionalAttrs (res."kubernetesSDConfigs" != [ ]) {
      "kubernetesSDConfigs" = map mkKubernetesSDConfig res."kubernetesSDConfigs";
    }
    // {
    }
    // optionalAttrs (res."max_scrape_size" != null) { inherit (res) "max_scrape_size"; }
    // {
    }
    // optionalAttrs (res."metricRelabelConfigs" != [ ]) {
      "metricRelabelConfigs" = map mkMetricRelabelConfig res."metricRelabelConfigs";
    }
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
    // optionalAttrs (res."params" != { }) { inherit (res) "params"; }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."relabelConfigs" != [ ]) {
      "relabelConfigs" = map mkRelabelConfig res."relabelConfigs";
    }
    // {
    }
    // optionalAttrs (res."sampleLimit" != null) { inherit (res) "sampleLimit"; }
    // {
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    }
    // optionalAttrs (res."scrapeClass" != null) { inherit (res) "scrapeClass"; }
    // {
    }
    // optionalAttrs (res."scrapeTimeout" != null) { inherit (res) "scrapeTimeout"; }
    // {
    }
    // optionalAttrs (res."scrape_interval" != null) { inherit (res) "scrape_interval"; }
    // {
    }
    // optionalAttrs (res."seriesLimit" != null) { inherit (res) "seriesLimit"; }
    // {
    }
    // optionalAttrs (res."staticConfigs" != [ ]) {
      "staticConfigs" = map mkStaticConfig res."staticConfigs";
    }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) { "tlsConfig" = mkTlsConfig res."tlsConfig"; }
    // {
    }
    // optionalAttrs (res."vm_scrape_params" != null) {
      "vm_scrape_params" = mkVm_scrape_params res."vm_scrape_params";
    }
    // {
    };
  };
  allResources = (mapAttrsToList mkVMScrapeConfig cfg."vmscrapeconfigs");
in
{
  options.openkrill.apps."victoriametrics" = {
    "vmscrapeconfigs" = mkOption {
      type = types.attrsOf VmscrapeconfigsModule;
      default = { };
      description = "VMScrapeConfig CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."victoriametrics".content = allResources;
  };
}
