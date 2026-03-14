# Auto-generated openkrill module fragment for victoriametrics
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."victoriametrics";
  compact = filterAttrs (_: v: v != null);
  Inhibit_ruleModule = types.submodule {
    options = {
      "equal" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "source_matchers" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "target_matchers" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkInhibit_rule =
    res:
    {
    }
    // optionalAttrs (res."equal" != [ ]) { inherit (res) "equal"; }
    // {
    }
    // optionalAttrs (res."source_matchers" != [ ]) { inherit (res) "source_matchers"; }
    // {
    }
    // optionalAttrs (res."target_matchers" != [ ]) { inherit (res) "target_matchers"; }
    // {
    };
  ReceiverDiscord_configHttp_configAuthorizationCredentialsModule = types.submodule {
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
  mkReceiverDiscord_configHttp_configAuthorizationCredentials =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverDiscord_configHttp_configAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        type = (types.nullOr ReceiverDiscord_configHttp_configAuthorizationCredentialsModule);
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
  mkReceiverDiscord_configHttp_configAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkReceiverDiscord_configHttp_configAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."credentialsFile" != null) { inherit (res) "credentialsFile"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ReceiverDiscord_configHttp_configBasic_authModule = types.submodule {
    options = {
      "password" = mkOption {
        type = (types.nullOr ReceiverDiscord_configHttp_configBasic_authPasswordModule);
        default = null;
      };
      "password_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
        type = (types.nullOr ReceiverDiscord_configHttp_configBasic_authUsernameModule);
        default = null;
      };
    };
  };
  mkReceiverDiscord_configHttp_configBasic_auth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkReceiverDiscord_configHttp_configBasic_authPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."password_file" != null) { inherit (res) "password_file"; }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkReceiverDiscord_configHttp_configBasic_authUsername res."username";
    }
    // {
    };
  ReceiverDiscord_configHttp_configBasic_authPasswordModule = types.submodule {
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
  mkReceiverDiscord_configHttp_configBasic_authPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverDiscord_configHttp_configBasic_authUsernameModule = types.submodule {
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
  mkReceiverDiscord_configHttp_configBasic_authUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverDiscord_configHttp_configBearer_token_secretModule = types.submodule {
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
  mkReceiverDiscord_configHttp_configBearer_token_secret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverDiscord_configHttp_configModule = types.submodule {
    options = {
      "authorization" = mkOption {
        type = (types.nullOr ReceiverDiscord_configHttp_configAuthorizationModule);
        default = null;
      };
      "basic_auth" = mkOption {
        type = (types.nullOr ReceiverDiscord_configHttp_configBasic_authModule);
        default = null;
      };
      "bearer_token_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "bearer_token_secret" = mkOption {
        type = (types.nullOr ReceiverDiscord_configHttp_configBearer_token_secretModule);
        default = null;
      };
      "oauth2" = mkOption {
        type = (types.nullOr ReceiverDiscord_configHttp_configOauth2Module);
        default = null;
      };
      "proxyURL" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "tls_config" = mkOption {
        type = (types.nullOr ReceiverDiscord_configHttp_configTls_configModule);
        default = null;
      };
    };
  };
  mkReceiverDiscord_configHttp_config =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkReceiverDiscord_configHttp_configAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basic_auth" != null) {
      "basic_auth" = mkReceiverDiscord_configHttp_configBasic_auth res."basic_auth";
    }
    // {
    }
    // optionalAttrs (res."bearer_token_file" != null) { inherit (res) "bearer_token_file"; }
    // {
    }
    // optionalAttrs (res."bearer_token_secret" != null) {
      "bearer_token_secret" =
        mkReceiverDiscord_configHttp_configBearer_token_secret
          res."bearer_token_secret";
    }
    // {
    }
    // optionalAttrs (res."oauth2" != null) {
      "oauth2" = mkReceiverDiscord_configHttp_configOauth2 res."oauth2";
    }
    // {
    }
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."tls_config" != null) {
      "tls_config" = mkReceiverDiscord_configHttp_configTls_config res."tls_config";
    }
    // {
    };
  ReceiverDiscord_configHttp_configOauth2Client_idConfigMapModule = types.submodule {
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
  mkReceiverDiscord_configHttp_configOauth2Client_idConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverDiscord_configHttp_configOauth2Client_idModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr ReceiverDiscord_configHttp_configOauth2Client_idConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr ReceiverDiscord_configHttp_configOauth2Client_idSecretModule);
        default = null;
      };
    };
  };
  mkReceiverDiscord_configHttp_configOauth2Client_id =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverDiscord_configHttp_configOauth2Client_idConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverDiscord_configHttp_configOauth2Client_idSecret res."secret";
    }
    // {
    };
  ReceiverDiscord_configHttp_configOauth2Client_idSecretModule = types.submodule {
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
  mkReceiverDiscord_configHttp_configOauth2Client_idSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverDiscord_configHttp_configOauth2Client_secretModule = types.submodule {
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
  mkReceiverDiscord_configHttp_configOauth2Client_secret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverDiscord_configHttp_configOauth2Module = types.submodule {
    options = {
      "client_id" = mkOption {
        type = ReceiverDiscord_configHttp_configOauth2Client_idModule;
      };
      "client_secret" = mkOption {
        type = (types.nullOr ReceiverDiscord_configHttp_configOauth2Client_secretModule);
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
  mkReceiverDiscord_configHttp_configOauth2 =
    res:
    {
      "client_id" = mkReceiverDiscord_configHttp_configOauth2Client_id res."client_id";
    }
    // optionalAttrs (res."client_secret" != null) {
      "client_secret" = mkReceiverDiscord_configHttp_configOauth2Client_secret res."client_secret";
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
  ReceiverDiscord_configHttp_configTls_configCaConfigMapModule = types.submodule {
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
  mkReceiverDiscord_configHttp_configTls_configCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverDiscord_configHttp_configTls_configCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr ReceiverDiscord_configHttp_configTls_configCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr ReceiverDiscord_configHttp_configTls_configCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverDiscord_configHttp_configTls_configCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverDiscord_configHttp_configTls_configCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverDiscord_configHttp_configTls_configCaSecret res."secret";
    }
    // {
    };
  ReceiverDiscord_configHttp_configTls_configCaSecretModule = types.submodule {
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
  mkReceiverDiscord_configHttp_configTls_configCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverDiscord_configHttp_configTls_configCertConfigMapModule = types.submodule {
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
  mkReceiverDiscord_configHttp_configTls_configCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverDiscord_configHttp_configTls_configCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr ReceiverDiscord_configHttp_configTls_configCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr ReceiverDiscord_configHttp_configTls_configCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverDiscord_configHttp_configTls_configCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverDiscord_configHttp_configTls_configCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverDiscord_configHttp_configTls_configCertSecret res."secret";
    }
    // {
    };
  ReceiverDiscord_configHttp_configTls_configCertSecretModule = types.submodule {
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
  mkReceiverDiscord_configHttp_configTls_configCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverDiscord_configHttp_configTls_configKeySecretModule = types.submodule {
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
  mkReceiverDiscord_configHttp_configTls_configKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverDiscord_configHttp_configTls_configModule = types.submodule {
    options = {
      "ca" = mkOption {
        type = (types.nullOr ReceiverDiscord_configHttp_configTls_configCaModule);
        default = null;
      };
      "caFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "cert" = mkOption {
        type = (types.nullOr ReceiverDiscord_configHttp_configTls_configCertModule);
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
        type = (types.nullOr ReceiverDiscord_configHttp_configTls_configKeySecretModule);
        default = null;
      };
      "serverName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverDiscord_configHttp_configTls_config =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverDiscord_configHttp_configTls_configCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."caFile" != null) { inherit (res) "caFile"; }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverDiscord_configHttp_configTls_configCert res."cert";
    }
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
      "keySecret" = mkReceiverDiscord_configHttp_configTls_configKeySecret res."keySecret";
    }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    };
  ReceiverDiscord_configModule = types.submodule {
    options = {
      "avatar_url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "content" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "http_config" = mkOption {
        type = (types.nullOr ReceiverDiscord_configHttp_configModule);
        default = null;
      };
      "message" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "send_resolved" = mkOption {
        type = types.bool;
        default = false;
      };
      "title" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "webhook_url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "webhook_url_secret" = mkOption {
        type = (types.nullOr ReceiverDiscord_configWebhook_url_secretModule);
        default = null;
      };
    };
  };
  mkReceiverDiscord_config =
    res:
    {
    }
    // optionalAttrs (res."avatar_url" != null) { inherit (res) "avatar_url"; }
    // {
    }
    // optionalAttrs (res."content" != null) { inherit (res) "content"; }
    // {
    }
    // optionalAttrs (res."http_config" != null) {
      "http_config" = mkReceiverDiscord_configHttp_config res."http_config";
    }
    // {
    }
    // optionalAttrs (res."message" != null) { inherit (res) "message"; }
    // {
    }
    // optionalAttrs res."send_resolved" { inherit (res) "send_resolved"; }
    // {
    }
    // optionalAttrs (res."title" != null) { inherit (res) "title"; }
    // {
    }
    // optionalAttrs (res."username" != null) { inherit (res) "username"; }
    // {
    }
    // optionalAttrs (res."webhook_url" != null) { inherit (res) "webhook_url"; }
    // {
    }
    // optionalAttrs (res."webhook_url_secret" != null) {
      "webhook_url_secret" = mkReceiverDiscord_configWebhook_url_secret res."webhook_url_secret";
    }
    // {
    };
  ReceiverDiscord_configWebhook_url_secretModule = types.submodule {
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
  mkReceiverDiscord_configWebhook_url_secret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverEmail_configAuth_passwordModule = types.submodule {
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
  mkReceiverEmail_configAuth_password =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverEmail_configAuth_secretModule = types.submodule {
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
  mkReceiverEmail_configAuth_secret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverEmail_configModule = types.submodule {
    options = {
      "auth_identity" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "auth_password" = mkOption {
        type = (types.nullOr ReceiverEmail_configAuth_passwordModule);
        default = null;
      };
      "auth_secret" = mkOption {
        type = (types.nullOr ReceiverEmail_configAuth_secretModule);
        default = null;
      };
      "auth_username" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "from" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "headers" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "hello" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "html" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "require_tls" = mkOption {
        type = types.bool;
        default = false;
      };
      "send_resolved" = mkOption {
        type = types.bool;
        default = false;
      };
      "smarthost" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "text" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "tls_config" = mkOption {
        type = (types.nullOr ReceiverEmail_configTls_configModule);
        default = null;
      };
      "to" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverEmail_config =
    res:
    {
    }
    // optionalAttrs (res."auth_identity" != null) { inherit (res) "auth_identity"; }
    // {
    }
    // optionalAttrs (res."auth_password" != null) {
      "auth_password" = mkReceiverEmail_configAuth_password res."auth_password";
    }
    // {
    }
    // optionalAttrs (res."auth_secret" != null) {
      "auth_secret" = mkReceiverEmail_configAuth_secret res."auth_secret";
    }
    // {
    }
    // optionalAttrs (res."auth_username" != null) { inherit (res) "auth_username"; }
    // {
    }
    // optionalAttrs (res."from" != null) { inherit (res) "from"; }
    // {
    }
    // optionalAttrs (res."headers" != { }) { inherit (res) "headers"; }
    // {
    }
    // optionalAttrs (res."hello" != null) { inherit (res) "hello"; }
    // {
    }
    // optionalAttrs (res."html" != null) { inherit (res) "html"; }
    // {
    }
    // optionalAttrs res."require_tls" { inherit (res) "require_tls"; }
    // {
    }
    // optionalAttrs res."send_resolved" { inherit (res) "send_resolved"; }
    // {
    }
    // optionalAttrs (res."smarthost" != null) { inherit (res) "smarthost"; }
    // {
    }
    // optionalAttrs (res."text" != null) { inherit (res) "text"; }
    // {
    }
    // optionalAttrs (res."tls_config" != null) {
      "tls_config" = mkReceiverEmail_configTls_config res."tls_config";
    }
    // {
    }
    // optionalAttrs (res."to" != null) { inherit (res) "to"; }
    // {
    };
  ReceiverEmail_configTls_configCaConfigMapModule = types.submodule {
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
  mkReceiverEmail_configTls_configCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverEmail_configTls_configCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr ReceiverEmail_configTls_configCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr ReceiverEmail_configTls_configCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverEmail_configTls_configCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverEmail_configTls_configCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverEmail_configTls_configCaSecret res."secret";
    }
    // {
    };
  ReceiverEmail_configTls_configCaSecretModule = types.submodule {
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
  mkReceiverEmail_configTls_configCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverEmail_configTls_configCertConfigMapModule = types.submodule {
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
  mkReceiverEmail_configTls_configCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverEmail_configTls_configCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr ReceiverEmail_configTls_configCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr ReceiverEmail_configTls_configCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverEmail_configTls_configCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverEmail_configTls_configCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverEmail_configTls_configCertSecret res."secret";
    }
    // {
    };
  ReceiverEmail_configTls_configCertSecretModule = types.submodule {
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
  mkReceiverEmail_configTls_configCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverEmail_configTls_configKeySecretModule = types.submodule {
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
  mkReceiverEmail_configTls_configKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverEmail_configTls_configModule = types.submodule {
    options = {
      "ca" = mkOption {
        type = (types.nullOr ReceiverEmail_configTls_configCaModule);
        default = null;
      };
      "caFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "cert" = mkOption {
        type = (types.nullOr ReceiverEmail_configTls_configCertModule);
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
        type = (types.nullOr ReceiverEmail_configTls_configKeySecretModule);
        default = null;
      };
      "serverName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverEmail_configTls_config =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkReceiverEmail_configTls_configCa res."ca"; }
    // {
    }
    // optionalAttrs (res."caFile" != null) { inherit (res) "caFile"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkReceiverEmail_configTls_configCert res."cert"; }
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
      "keySecret" = mkReceiverEmail_configTls_configKeySecret res."keySecret";
    }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    };
  ReceiverIncidentio_configAlert_source_tokenModule = types.submodule {
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
  mkReceiverIncidentio_configAlert_source_token =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverIncidentio_configModule = types.submodule {
    options = {
      "alert_source_token" = mkOption {
        type = (types.nullOr ReceiverIncidentio_configAlert_source_tokenModule);
        default = null;
      };
      "http_config" = mkOption {
        type = (types.nullOr types.anything);
        default = null;
      };
      "max_alerts" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "send_resolved" = mkOption {
        type = types.bool;
        default = false;
      };
      "timeout" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverIncidentio_config =
    res:
    {
    }
    // optionalAttrs (res."alert_source_token" != null) {
      "alert_source_token" = mkReceiverIncidentio_configAlert_source_token res."alert_source_token";
    }
    // {
    }
    // optionalAttrs (res."http_config" != null) { inherit (res) "http_config"; }
    // {
    }
    // optionalAttrs (res."max_alerts" != null) { inherit (res) "max_alerts"; }
    // {
    }
    // optionalAttrs res."send_resolved" { inherit (res) "send_resolved"; }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    }
    // optionalAttrs (res."url" != null) { inherit (res) "url"; }
    // {
    };
  ReceiverJira_configModule = types.submodule {
    options = {
      "api_url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "custom_fields" = mkOption {
        type = (types.attrsOf types.anything);
        default = { };
      };
      "description" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "http_config" = mkOption {
        type = (types.nullOr types.anything);
        default = null;
      };
      "issue_type" = mkOption {
        type = types.str;
      };
      "labels" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "priority" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "project" = mkOption {
        type = types.str;
      };
      "reopen_duration" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "reopen_transition" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "resolve_transition" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "send_resolved" = mkOption {
        type = types.bool;
        default = false;
      };
      "summary" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "wont_fix_resolution" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverJira_config =
    res:
    {
    }
    // optionalAttrs (res."api_url" != null) { inherit (res) "api_url"; }
    // {
    }
    // optionalAttrs (res."custom_fields" != { }) { inherit (res) "custom_fields"; }
    // {
    }
    // optionalAttrs (res."description" != null) { inherit (res) "description"; }
    // {
    }
    // optionalAttrs (res."http_config" != null) { inherit (res) "http_config"; }
    // {
      inherit (res) "issue_type";
    }
    // optionalAttrs (res."labels" != [ ]) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."priority" != null) { inherit (res) "priority"; }
    // {
      inherit (res) "project";
    }
    // optionalAttrs (res."reopen_duration" != null) { inherit (res) "reopen_duration"; }
    // {
    }
    // optionalAttrs (res."reopen_transition" != null) { inherit (res) "reopen_transition"; }
    // {
    }
    // optionalAttrs (res."resolve_transition" != null) { inherit (res) "resolve_transition"; }
    // {
    }
    // optionalAttrs res."send_resolved" { inherit (res) "send_resolved"; }
    // {
    }
    // optionalAttrs (res."summary" != null) { inherit (res) "summary"; }
    // {
    }
    // optionalAttrs (res."wont_fix_resolution" != null) { inherit (res) "wont_fix_resolution"; }
    // {
    };
  ReceiverModule = types.submodule {
    options = {
      "discord_configs" = mkOption {
        type = (types.listOf ReceiverDiscord_configModule);
        default = [ ];
      };
      "email_configs" = mkOption {
        type = (types.listOf ReceiverEmail_configModule);
        default = [ ];
      };
      "incidentio_configs" = mkOption {
        type = (types.listOf ReceiverIncidentio_configModule);
        default = [ ];
      };
      "jira_configs" = mkOption {
        type = (types.listOf ReceiverJira_configModule);
        default = [ ];
      };
      "msteams_configs" = mkOption {
        type = (types.listOf ReceiverMsteams_configModule);
        default = [ ];
      };
      "msteamsv2_configs" = mkOption {
        type = (types.listOf ReceiverMsteamsv2_configModule);
        default = [ ];
      };
      "name" = mkOption {
        type = types.str;
      };
      "opsgenie_configs" = mkOption {
        type = (types.listOf ReceiverOpsgenie_configModule);
        default = [ ];
      };
      "pagerduty_configs" = mkOption {
        type = (types.listOf ReceiverPagerduty_configModule);
        default = [ ];
      };
      "pushover_configs" = mkOption {
        type = (types.listOf ReceiverPushover_configModule);
        default = [ ];
      };
      "rocketchat_configs" = mkOption {
        type = (types.listOf ReceiverRocketchat_configModule);
        default = [ ];
      };
      "slack_configs" = mkOption {
        type = (types.listOf ReceiverSlack_configModule);
        default = [ ];
      };
      "sns_configs" = mkOption {
        type = (types.listOf ReceiverSns_configModule);
        default = [ ];
      };
      "telegram_configs" = mkOption {
        type = (types.listOf ReceiverTelegram_configModule);
        default = [ ];
      };
      "victorops_configs" = mkOption {
        type = (types.listOf ReceiverVictorops_configModule);
        default = [ ];
      };
      "webex_configs" = mkOption {
        type = (types.listOf ReceiverWebex_configModule);
        default = [ ];
      };
      "webhook_configs" = mkOption {
        type = (types.listOf ReceiverWebhook_configModule);
        default = [ ];
      };
      "wechat_configs" = mkOption {
        type = (types.listOf ReceiverWechat_configModule);
        default = [ ];
      };
    };
  };
  mkReceiver =
    res:
    {
    }
    // optionalAttrs (res."discord_configs" != [ ]) {
      "discord_configs" = map mkReceiverDiscord_config res."discord_configs";
    }
    // {
    }
    // optionalAttrs (res."email_configs" != [ ]) {
      "email_configs" = map mkReceiverEmail_config res."email_configs";
    }
    // {
    }
    // optionalAttrs (res."incidentio_configs" != [ ]) {
      "incidentio_configs" = map mkReceiverIncidentio_config res."incidentio_configs";
    }
    // {
    }
    // optionalAttrs (res."jira_configs" != [ ]) {
      "jira_configs" = map mkReceiverJira_config res."jira_configs";
    }
    // {
    }
    // optionalAttrs (res."msteams_configs" != [ ]) {
      "msteams_configs" = map mkReceiverMsteams_config res."msteams_configs";
    }
    // {
    }
    // optionalAttrs (res."msteamsv2_configs" != [ ]) {
      "msteamsv2_configs" = map mkReceiverMsteamsv2_config res."msteamsv2_configs";
    }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."opsgenie_configs" != [ ]) {
      "opsgenie_configs" = map mkReceiverOpsgenie_config res."opsgenie_configs";
    }
    // {
    }
    // optionalAttrs (res."pagerduty_configs" != [ ]) {
      "pagerduty_configs" = map mkReceiverPagerduty_config res."pagerduty_configs";
    }
    // {
    }
    // optionalAttrs (res."pushover_configs" != [ ]) {
      "pushover_configs" = map mkReceiverPushover_config res."pushover_configs";
    }
    // {
    }
    // optionalAttrs (res."rocketchat_configs" != [ ]) {
      "rocketchat_configs" = map mkReceiverRocketchat_config res."rocketchat_configs";
    }
    // {
    }
    // optionalAttrs (res."slack_configs" != [ ]) {
      "slack_configs" = map mkReceiverSlack_config res."slack_configs";
    }
    // {
    }
    // optionalAttrs (res."sns_configs" != [ ]) {
      "sns_configs" = map mkReceiverSns_config res."sns_configs";
    }
    // {
    }
    // optionalAttrs (res."telegram_configs" != [ ]) {
      "telegram_configs" = map mkReceiverTelegram_config res."telegram_configs";
    }
    // {
    }
    // optionalAttrs (res."victorops_configs" != [ ]) {
      "victorops_configs" = map mkReceiverVictorops_config res."victorops_configs";
    }
    // {
    }
    // optionalAttrs (res."webex_configs" != [ ]) {
      "webex_configs" = map mkReceiverWebex_config res."webex_configs";
    }
    // {
    }
    // optionalAttrs (res."webhook_configs" != [ ]) {
      "webhook_configs" = map mkReceiverWebhook_config res."webhook_configs";
    }
    // {
    }
    // optionalAttrs (res."wechat_configs" != [ ]) {
      "wechat_configs" = map mkReceiverWechat_config res."wechat_configs";
    }
    // {
    };
  ReceiverMsteams_configHttp_configAuthorizationCredentialsModule = types.submodule {
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
  mkReceiverMsteams_configHttp_configAuthorizationCredentials =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverMsteams_configHttp_configAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        type = (types.nullOr ReceiverMsteams_configHttp_configAuthorizationCredentialsModule);
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
  mkReceiverMsteams_configHttp_configAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkReceiverMsteams_configHttp_configAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."credentialsFile" != null) { inherit (res) "credentialsFile"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ReceiverMsteams_configHttp_configBasic_authModule = types.submodule {
    options = {
      "password" = mkOption {
        type = (types.nullOr ReceiverMsteams_configHttp_configBasic_authPasswordModule);
        default = null;
      };
      "password_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
        type = (types.nullOr ReceiverMsteams_configHttp_configBasic_authUsernameModule);
        default = null;
      };
    };
  };
  mkReceiverMsteams_configHttp_configBasic_auth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkReceiverMsteams_configHttp_configBasic_authPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."password_file" != null) { inherit (res) "password_file"; }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkReceiverMsteams_configHttp_configBasic_authUsername res."username";
    }
    // {
    };
  ReceiverMsteams_configHttp_configBasic_authPasswordModule = types.submodule {
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
  mkReceiverMsteams_configHttp_configBasic_authPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverMsteams_configHttp_configBasic_authUsernameModule = types.submodule {
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
  mkReceiverMsteams_configHttp_configBasic_authUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverMsteams_configHttp_configBearer_token_secretModule = types.submodule {
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
  mkReceiverMsteams_configHttp_configBearer_token_secret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverMsteams_configHttp_configModule = types.submodule {
    options = {
      "authorization" = mkOption {
        type = (types.nullOr ReceiverMsteams_configHttp_configAuthorizationModule);
        default = null;
      };
      "basic_auth" = mkOption {
        type = (types.nullOr ReceiverMsteams_configHttp_configBasic_authModule);
        default = null;
      };
      "bearer_token_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "bearer_token_secret" = mkOption {
        type = (types.nullOr ReceiverMsteams_configHttp_configBearer_token_secretModule);
        default = null;
      };
      "oauth2" = mkOption {
        type = (types.nullOr ReceiverMsteams_configHttp_configOauth2Module);
        default = null;
      };
      "proxyURL" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "tls_config" = mkOption {
        type = (types.nullOr ReceiverMsteams_configHttp_configTls_configModule);
        default = null;
      };
    };
  };
  mkReceiverMsteams_configHttp_config =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkReceiverMsteams_configHttp_configAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basic_auth" != null) {
      "basic_auth" = mkReceiverMsteams_configHttp_configBasic_auth res."basic_auth";
    }
    // {
    }
    // optionalAttrs (res."bearer_token_file" != null) { inherit (res) "bearer_token_file"; }
    // {
    }
    // optionalAttrs (res."bearer_token_secret" != null) {
      "bearer_token_secret" =
        mkReceiverMsteams_configHttp_configBearer_token_secret
          res."bearer_token_secret";
    }
    // {
    }
    // optionalAttrs (res."oauth2" != null) {
      "oauth2" = mkReceiverMsteams_configHttp_configOauth2 res."oauth2";
    }
    // {
    }
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."tls_config" != null) {
      "tls_config" = mkReceiverMsteams_configHttp_configTls_config res."tls_config";
    }
    // {
    };
  ReceiverMsteams_configHttp_configOauth2Client_idConfigMapModule = types.submodule {
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
  mkReceiverMsteams_configHttp_configOauth2Client_idConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverMsteams_configHttp_configOauth2Client_idModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr ReceiverMsteams_configHttp_configOauth2Client_idConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr ReceiverMsteams_configHttp_configOauth2Client_idSecretModule);
        default = null;
      };
    };
  };
  mkReceiverMsteams_configHttp_configOauth2Client_id =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverMsteams_configHttp_configOauth2Client_idConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverMsteams_configHttp_configOauth2Client_idSecret res."secret";
    }
    // {
    };
  ReceiverMsteams_configHttp_configOauth2Client_idSecretModule = types.submodule {
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
  mkReceiverMsteams_configHttp_configOauth2Client_idSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverMsteams_configHttp_configOauth2Client_secretModule = types.submodule {
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
  mkReceiverMsteams_configHttp_configOauth2Client_secret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverMsteams_configHttp_configOauth2Module = types.submodule {
    options = {
      "client_id" = mkOption {
        type = ReceiverMsteams_configHttp_configOauth2Client_idModule;
      };
      "client_secret" = mkOption {
        type = (types.nullOr ReceiverMsteams_configHttp_configOauth2Client_secretModule);
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
  mkReceiverMsteams_configHttp_configOauth2 =
    res:
    {
      "client_id" = mkReceiverMsteams_configHttp_configOauth2Client_id res."client_id";
    }
    // optionalAttrs (res."client_secret" != null) {
      "client_secret" = mkReceiverMsteams_configHttp_configOauth2Client_secret res."client_secret";
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
  ReceiverMsteams_configHttp_configTls_configCaConfigMapModule = types.submodule {
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
  mkReceiverMsteams_configHttp_configTls_configCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverMsteams_configHttp_configTls_configCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr ReceiverMsteams_configHttp_configTls_configCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr ReceiverMsteams_configHttp_configTls_configCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverMsteams_configHttp_configTls_configCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverMsteams_configHttp_configTls_configCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverMsteams_configHttp_configTls_configCaSecret res."secret";
    }
    // {
    };
  ReceiverMsteams_configHttp_configTls_configCaSecretModule = types.submodule {
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
  mkReceiverMsteams_configHttp_configTls_configCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverMsteams_configHttp_configTls_configCertConfigMapModule = types.submodule {
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
  mkReceiverMsteams_configHttp_configTls_configCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverMsteams_configHttp_configTls_configCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr ReceiverMsteams_configHttp_configTls_configCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr ReceiverMsteams_configHttp_configTls_configCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverMsteams_configHttp_configTls_configCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverMsteams_configHttp_configTls_configCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverMsteams_configHttp_configTls_configCertSecret res."secret";
    }
    // {
    };
  ReceiverMsteams_configHttp_configTls_configCertSecretModule = types.submodule {
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
  mkReceiverMsteams_configHttp_configTls_configCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverMsteams_configHttp_configTls_configKeySecretModule = types.submodule {
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
  mkReceiverMsteams_configHttp_configTls_configKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverMsteams_configHttp_configTls_configModule = types.submodule {
    options = {
      "ca" = mkOption {
        type = (types.nullOr ReceiverMsteams_configHttp_configTls_configCaModule);
        default = null;
      };
      "caFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "cert" = mkOption {
        type = (types.nullOr ReceiverMsteams_configHttp_configTls_configCertModule);
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
        type = (types.nullOr ReceiverMsteams_configHttp_configTls_configKeySecretModule);
        default = null;
      };
      "serverName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverMsteams_configHttp_configTls_config =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverMsteams_configHttp_configTls_configCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."caFile" != null) { inherit (res) "caFile"; }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverMsteams_configHttp_configTls_configCert res."cert";
    }
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
      "keySecret" = mkReceiverMsteams_configHttp_configTls_configKeySecret res."keySecret";
    }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    };
  ReceiverMsteams_configModule = types.submodule {
    options = {
      "http_config" = mkOption {
        type = (types.nullOr ReceiverMsteams_configHttp_configModule);
        default = null;
      };
      "send_resolved" = mkOption {
        type = types.bool;
        default = false;
      };
      "text" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "title" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "webhook_url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "webhook_url_secret" = mkOption {
        type = (types.nullOr ReceiverMsteams_configWebhook_url_secretModule);
        default = null;
      };
    };
  };
  mkReceiverMsteams_config =
    res:
    {
    }
    // optionalAttrs (res."http_config" != null) {
      "http_config" = mkReceiverMsteams_configHttp_config res."http_config";
    }
    // {
    }
    // optionalAttrs res."send_resolved" { inherit (res) "send_resolved"; }
    // {
    }
    // optionalAttrs (res."text" != null) { inherit (res) "text"; }
    // {
    }
    // optionalAttrs (res."title" != null) { inherit (res) "title"; }
    // {
    }
    // optionalAttrs (res."webhook_url" != null) { inherit (res) "webhook_url"; }
    // {
    }
    // optionalAttrs (res."webhook_url_secret" != null) {
      "webhook_url_secret" = mkReceiverMsteams_configWebhook_url_secret res."webhook_url_secret";
    }
    // {
    };
  ReceiverMsteams_configWebhook_url_secretModule = types.submodule {
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
  mkReceiverMsteams_configWebhook_url_secret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverMsteamsv2_configModule = types.submodule {
    options = {
      "http_config" = mkOption {
        type = (types.nullOr types.anything);
        default = null;
      };
      "send_resolved" = mkOption {
        type = types.bool;
        default = false;
      };
      "text" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "title" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "webhook_url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "webhook_url_secret" = mkOption {
        type = (types.nullOr ReceiverMsteamsv2_configWebhook_url_secretModule);
        default = null;
      };
    };
  };
  mkReceiverMsteamsv2_config =
    res:
    {
    }
    // optionalAttrs (res."http_config" != null) { inherit (res) "http_config"; }
    // {
    }
    // optionalAttrs res."send_resolved" { inherit (res) "send_resolved"; }
    // {
    }
    // optionalAttrs (res."text" != null) { inherit (res) "text"; }
    // {
    }
    // optionalAttrs (res."title" != null) { inherit (res) "title"; }
    // {
    }
    // optionalAttrs (res."webhook_url" != null) { inherit (res) "webhook_url"; }
    // {
    }
    // optionalAttrs (res."webhook_url_secret" != null) {
      "webhook_url_secret" = mkReceiverMsteamsv2_configWebhook_url_secret res."webhook_url_secret";
    }
    // {
    };
  ReceiverMsteamsv2_configWebhook_url_secretModule = types.submodule {
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
  mkReceiverMsteamsv2_configWebhook_url_secret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverOpsgenie_configApi_keyModule = types.submodule {
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
  mkReceiverOpsgenie_configApi_key =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverOpsgenie_configModule = types.submodule {
    options = {
      "actions" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "apiURL" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "api_key" = mkOption {
        type = (types.nullOr ReceiverOpsgenie_configApi_keyModule);
        default = null;
      };
      "description" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "details" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "entity" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "http_config" = mkOption {
        type = (types.attrsOf types.anything);
        default = { };
      };
      "message" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "note" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "priority" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "responders" = mkOption {
        type = (types.listOf ReceiverOpsgenie_configResponderModule);
        default = [ ];
      };
      "send_resolved" = mkOption {
        type = types.bool;
        default = false;
      };
      "source" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "tags" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "update_alerts" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkReceiverOpsgenie_config =
    res:
    {
    }
    // optionalAttrs (res."actions" != null) { inherit (res) "actions"; }
    // {
    }
    // optionalAttrs (res."apiURL" != null) { inherit (res) "apiURL"; }
    // {
    }
    // optionalAttrs (res."api_key" != null) {
      "api_key" = mkReceiverOpsgenie_configApi_key res."api_key";
    }
    // {
    }
    // optionalAttrs (res."description" != null) { inherit (res) "description"; }
    // {
    }
    // optionalAttrs (res."details" != { }) { inherit (res) "details"; }
    // {
    }
    // optionalAttrs (res."entity" != null) { inherit (res) "entity"; }
    // {
    }
    // optionalAttrs (res."http_config" != { }) { inherit (res) "http_config"; }
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
      "responders" = map mkReceiverOpsgenie_configResponder res."responders";
    }
    // {
    }
    // optionalAttrs res."send_resolved" { inherit (res) "send_resolved"; }
    // {
    }
    // optionalAttrs (res."source" != null) { inherit (res) "source"; }
    // {
    }
    // optionalAttrs (res."tags" != null) { inherit (res) "tags"; }
    // {
    }
    // optionalAttrs res."update_alerts" { inherit (res) "update_alerts"; }
    // {
    };
  ReceiverOpsgenie_configResponderModule = types.submodule {
    options = {
      "id" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        type = types.str;
      };
      "username" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverOpsgenie_configResponder =
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
  ReceiverPagerduty_configImageModule = types.submodule {
    options = {
      "alt" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "href" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "source" = mkOption {
        type = types.str;
      };
    };
  };
  mkReceiverPagerduty_configImage =
    res:
    {
    }
    // optionalAttrs (res."alt" != null) { inherit (res) "alt"; }
    // {
    }
    // optionalAttrs (res."href" != null) { inherit (res) "href"; }
    // {
      inherit (res) "source";
    };
  ReceiverPagerduty_configLinkModule = types.submodule {
    options = {
      "href" = mkOption {
        type = types.str;
      };
      "text" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverPagerduty_configLink =
    res:
    {
      inherit (res) "href";
    }
    // optionalAttrs (res."text" != null) { inherit (res) "text"; }
    // {
    };
  ReceiverPagerduty_configModule = types.submodule {
    options = {
      "class" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "client" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "client_url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "component" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "description" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "details" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "group" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "http_config" = mkOption {
        type = (types.attrsOf types.anything);
        default = { };
      };
      "images" = mkOption {
        type = (types.listOf ReceiverPagerduty_configImageModule);
        default = [ ];
      };
      "links" = mkOption {
        type = (types.listOf ReceiverPagerduty_configLinkModule);
        default = [ ];
      };
      "routing_key" = mkOption {
        type = (types.nullOr ReceiverPagerduty_configRouting_keyModule);
        default = null;
      };
      "send_resolved" = mkOption {
        type = types.bool;
        default = false;
      };
      "service_key" = mkOption {
        type = (types.nullOr ReceiverPagerduty_configService_keyModule);
        default = null;
      };
      "severity" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverPagerduty_config =
    res:
    {
    }
    // optionalAttrs (res."class" != null) { inherit (res) "class"; }
    // {
    }
    // optionalAttrs (res."client" != null) { inherit (res) "client"; }
    // {
    }
    // optionalAttrs (res."client_url" != null) { inherit (res) "client_url"; }
    // {
    }
    // optionalAttrs (res."component" != null) { inherit (res) "component"; }
    // {
    }
    // optionalAttrs (res."description" != null) { inherit (res) "description"; }
    // {
    }
    // optionalAttrs (res."details" != { }) { inherit (res) "details"; }
    // {
    }
    // optionalAttrs (res."group" != null) { inherit (res) "group"; }
    // {
    }
    // optionalAttrs (res."http_config" != { }) { inherit (res) "http_config"; }
    // {
    }
    // optionalAttrs (res."images" != [ ]) {
      "images" = map mkReceiverPagerduty_configImage res."images";
    }
    // {
    }
    // optionalAttrs (res."links" != [ ]) { "links" = map mkReceiverPagerduty_configLink res."links"; }
    // {
    }
    // optionalAttrs (res."routing_key" != null) {
      "routing_key" = mkReceiverPagerduty_configRouting_key res."routing_key";
    }
    // {
    }
    // optionalAttrs res."send_resolved" { inherit (res) "send_resolved"; }
    // {
    }
    // optionalAttrs (res."service_key" != null) {
      "service_key" = mkReceiverPagerduty_configService_key res."service_key";
    }
    // {
    }
    // optionalAttrs (res."severity" != null) { inherit (res) "severity"; }
    // {
    }
    // optionalAttrs (res."url" != null) { inherit (res) "url"; }
    // {
    };
  ReceiverPagerduty_configRouting_keyModule = types.submodule {
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
  mkReceiverPagerduty_configRouting_key =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverPagerduty_configService_keyModule = types.submodule {
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
  mkReceiverPagerduty_configService_key =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverPushover_configModule = types.submodule {
    options = {
      "expire" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "html" = mkOption {
        type = types.bool;
        default = false;
      };
      "http_config" = mkOption {
        type = (types.attrsOf types.anything);
        default = { };
      };
      "message" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "priority" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "retry" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "send_resolved" = mkOption {
        type = types.bool;
        default = false;
      };
      "sound" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "title" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "token" = mkOption {
        type = (types.nullOr ReceiverPushover_configTokenModule);
        default = null;
      };
      "url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "url_title" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "user_key" = mkOption {
        type = (types.nullOr ReceiverPushover_configUser_keyModule);
        default = null;
      };
    };
  };
  mkReceiverPushover_config =
    res:
    {
    }
    // optionalAttrs (res."expire" != null) { inherit (res) "expire"; }
    // {
    }
    // optionalAttrs res."html" { inherit (res) "html"; }
    // {
    }
    // optionalAttrs (res."http_config" != { }) { inherit (res) "http_config"; }
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
    // optionalAttrs res."send_resolved" { inherit (res) "send_resolved"; }
    // {
    }
    // optionalAttrs (res."sound" != null) { inherit (res) "sound"; }
    // {
    }
    // optionalAttrs (res."title" != null) { inherit (res) "title"; }
    // {
    }
    // optionalAttrs (res."token" != null) { "token" = mkReceiverPushover_configToken res."token"; }
    // {
    }
    // optionalAttrs (res."url" != null) { inherit (res) "url"; }
    // {
    }
    // optionalAttrs (res."url_title" != null) { inherit (res) "url_title"; }
    // {
    }
    // optionalAttrs (res."user_key" != null) {
      "user_key" = mkReceiverPushover_configUser_key res."user_key";
    }
    // {
    };
  ReceiverPushover_configTokenModule = types.submodule {
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
  mkReceiverPushover_configToken =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverPushover_configUser_keyModule = types.submodule {
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
  mkReceiverPushover_configUser_key =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverRocketchat_configActionModule = types.submodule {
    options = {
      "msg" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "text" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverRocketchat_configAction =
    res:
    {
    }
    // optionalAttrs (res."msg" != null) { inherit (res) "msg"; }
    // {
    }
    // optionalAttrs (res."text" != null) { inherit (res) "text"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    }
    // optionalAttrs (res."url" != null) { inherit (res) "url"; }
    // {
    };
  ReceiverRocketchat_configFieldModule = types.submodule {
    options = {
      "short" = mkOption {
        type = types.bool;
        default = false;
      };
      "title" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "value" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverRocketchat_configField =
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
  ReceiverRocketchat_configModule = types.submodule {
    options = {
      "actions" = mkOption {
        type = (types.listOf ReceiverRocketchat_configActionModule);
        default = [ ];
      };
      "api_url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "channel" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "color" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "emoji" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "fields" = mkOption {
        type = (types.listOf ReceiverRocketchat_configFieldModule);
        default = [ ];
      };
      "http_config" = mkOption {
        type = (types.nullOr types.anything);
        default = null;
      };
      "icon_url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "image_url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "link_names" = mkOption {
        type = types.bool;
        default = false;
      };
      "send_resolved" = mkOption {
        type = types.bool;
        default = false;
      };
      "short_fields" = mkOption {
        type = types.bool;
        default = false;
      };
      "text" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "thumb_url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "title" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "title_link" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "token" = mkOption {
        type = (types.nullOr ReceiverRocketchat_configTokenModule);
        default = null;
      };
      "token_id" = mkOption {
        type = (types.nullOr ReceiverRocketchat_configToken_idModule);
        default = null;
      };
    };
  };
  mkReceiverRocketchat_config =
    res:
    {
    }
    // optionalAttrs (res."actions" != [ ]) {
      "actions" = map mkReceiverRocketchat_configAction res."actions";
    }
    // {
    }
    // optionalAttrs (res."api_url" != null) { inherit (res) "api_url"; }
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
      "fields" = map mkReceiverRocketchat_configField res."fields";
    }
    // {
    }
    // optionalAttrs (res."http_config" != null) { inherit (res) "http_config"; }
    // {
    }
    // optionalAttrs (res."icon_url" != null) { inherit (res) "icon_url"; }
    // {
    }
    // optionalAttrs (res."image_url" != null) { inherit (res) "image_url"; }
    // {
    }
    // optionalAttrs res."link_names" { inherit (res) "link_names"; }
    // {
    }
    // optionalAttrs res."send_resolved" { inherit (res) "send_resolved"; }
    // {
    }
    // optionalAttrs res."short_fields" { inherit (res) "short_fields"; }
    // {
    }
    // optionalAttrs (res."text" != null) { inherit (res) "text"; }
    // {
    }
    // optionalAttrs (res."thumb_url" != null) { inherit (res) "thumb_url"; }
    // {
    }
    // optionalAttrs (res."title" != null) { inherit (res) "title"; }
    // {
    }
    // optionalAttrs (res."title_link" != null) { inherit (res) "title_link"; }
    // {
    }
    // optionalAttrs (res."token" != null) { "token" = mkReceiverRocketchat_configToken res."token"; }
    // {
    }
    // optionalAttrs (res."token_id" != null) {
      "token_id" = mkReceiverRocketchat_configToken_id res."token_id";
    }
    // {
    };
  ReceiverRocketchat_configTokenModule = types.submodule {
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
  mkReceiverRocketchat_configToken =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverRocketchat_configToken_idModule = types.submodule {
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
  mkReceiverRocketchat_configToken_id =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverSlack_configActionConfirmModule = types.submodule {
    options = {
      "dismiss_text" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "ok_text" = mkOption {
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
  mkReceiverSlack_configActionConfirm =
    res:
    {
    }
    // optionalAttrs (res."dismiss_text" != null) { inherit (res) "dismiss_text"; }
    // {
    }
    // optionalAttrs (res."ok_text" != null) { inherit (res) "ok_text"; }
    // {
      inherit (res) "text";
    }
    // optionalAttrs (res."title" != null) { inherit (res) "title"; }
    // {
    };
  ReceiverSlack_configActionModule = types.submodule {
    options = {
      "confirm" = mkOption {
        type = (types.nullOr ReceiverSlack_configActionConfirmModule);
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
  mkReceiverSlack_configAction =
    res:
    {
    }
    // optionalAttrs (res."confirm" != null) {
      "confirm" = mkReceiverSlack_configActionConfirm res."confirm";
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
  ReceiverSlack_configApi_urlModule = types.submodule {
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
  mkReceiverSlack_configApi_url =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverSlack_configFieldModule = types.submodule {
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
  mkReceiverSlack_configField =
    res:
    {
    }
    // optionalAttrs res."short" { inherit (res) "short"; }
    // {
      inherit (res) "title";
      inherit (res) "value";
    };
  ReceiverSlack_configModule = types.submodule {
    options = {
      "actions" = mkOption {
        type = (types.listOf ReceiverSlack_configActionModule);
        default = [ ];
      };
      "api_url" = mkOption {
        type = (types.nullOr ReceiverSlack_configApi_urlModule);
        default = null;
      };
      "callback_id" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "channel" = mkOption {
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
        type = (types.listOf ReceiverSlack_configFieldModule);
        default = [ ];
      };
      "footer" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "http_config" = mkOption {
        type = (types.attrsOf types.anything);
        default = { };
      };
      "icon_emoji" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "icon_url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "image_url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "link_names" = mkOption {
        type = types.bool;
        default = false;
      };
      "mrkdwn_in" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "pretext" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "send_resolved" = mkOption {
        type = types.bool;
        default = false;
      };
      "short_fields" = mkOption {
        type = types.bool;
        default = false;
      };
      "text" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "thumb_url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "title" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "title_link" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverSlack_config =
    res:
    {
    }
    // optionalAttrs (res."actions" != [ ]) {
      "actions" = map mkReceiverSlack_configAction res."actions";
    }
    // {
    }
    // optionalAttrs (res."api_url" != null) {
      "api_url" = mkReceiverSlack_configApi_url res."api_url";
    }
    // {
    }
    // optionalAttrs (res."callback_id" != null) { inherit (res) "callback_id"; }
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
    // optionalAttrs (res."fields" != [ ]) { "fields" = map mkReceiverSlack_configField res."fields"; }
    // {
    }
    // optionalAttrs (res."footer" != null) { inherit (res) "footer"; }
    // {
    }
    // optionalAttrs (res."http_config" != { }) { inherit (res) "http_config"; }
    // {
    }
    // optionalAttrs (res."icon_emoji" != null) { inherit (res) "icon_emoji"; }
    // {
    }
    // optionalAttrs (res."icon_url" != null) { inherit (res) "icon_url"; }
    // {
    }
    // optionalAttrs (res."image_url" != null) { inherit (res) "image_url"; }
    // {
    }
    // optionalAttrs res."link_names" { inherit (res) "link_names"; }
    // {
    }
    // optionalAttrs (res."mrkdwn_in" != [ ]) { inherit (res) "mrkdwn_in"; }
    // {
    }
    // optionalAttrs (res."pretext" != null) { inherit (res) "pretext"; }
    // {
    }
    // optionalAttrs res."send_resolved" { inherit (res) "send_resolved"; }
    // {
    }
    // optionalAttrs res."short_fields" { inherit (res) "short_fields"; }
    // {
    }
    // optionalAttrs (res."text" != null) { inherit (res) "text"; }
    // {
    }
    // optionalAttrs (res."thumb_url" != null) { inherit (res) "thumb_url"; }
    // {
    }
    // optionalAttrs (res."title" != null) { inherit (res) "title"; }
    // {
    }
    // optionalAttrs (res."title_link" != null) { inherit (res) "title_link"; }
    // {
    }
    // optionalAttrs (res."username" != null) { inherit (res) "username"; }
    // {
    };
  ReceiverSns_configHttp_configAuthorizationCredentialsModule = types.submodule {
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
  mkReceiverSns_configHttp_configAuthorizationCredentials =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverSns_configHttp_configAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        type = (types.nullOr ReceiverSns_configHttp_configAuthorizationCredentialsModule);
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
  mkReceiverSns_configHttp_configAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkReceiverSns_configHttp_configAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."credentialsFile" != null) { inherit (res) "credentialsFile"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ReceiverSns_configHttp_configBasic_authModule = types.submodule {
    options = {
      "password" = mkOption {
        type = (types.nullOr ReceiverSns_configHttp_configBasic_authPasswordModule);
        default = null;
      };
      "password_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
        type = (types.nullOr ReceiverSns_configHttp_configBasic_authUsernameModule);
        default = null;
      };
    };
  };
  mkReceiverSns_configHttp_configBasic_auth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkReceiverSns_configHttp_configBasic_authPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."password_file" != null) { inherit (res) "password_file"; }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkReceiverSns_configHttp_configBasic_authUsername res."username";
    }
    // {
    };
  ReceiverSns_configHttp_configBasic_authPasswordModule = types.submodule {
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
  mkReceiverSns_configHttp_configBasic_authPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverSns_configHttp_configBasic_authUsernameModule = types.submodule {
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
  mkReceiverSns_configHttp_configBasic_authUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverSns_configHttp_configBearer_token_secretModule = types.submodule {
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
  mkReceiverSns_configHttp_configBearer_token_secret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverSns_configHttp_configModule = types.submodule {
    options = {
      "authorization" = mkOption {
        type = (types.nullOr ReceiverSns_configHttp_configAuthorizationModule);
        default = null;
      };
      "basic_auth" = mkOption {
        type = (types.nullOr ReceiverSns_configHttp_configBasic_authModule);
        default = null;
      };
      "bearer_token_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "bearer_token_secret" = mkOption {
        type = (types.nullOr ReceiverSns_configHttp_configBearer_token_secretModule);
        default = null;
      };
      "oauth2" = mkOption {
        type = (types.nullOr ReceiverSns_configHttp_configOauth2Module);
        default = null;
      };
      "proxyURL" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "tls_config" = mkOption {
        type = (types.nullOr ReceiverSns_configHttp_configTls_configModule);
        default = null;
      };
    };
  };
  mkReceiverSns_configHttp_config =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkReceiverSns_configHttp_configAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basic_auth" != null) {
      "basic_auth" = mkReceiverSns_configHttp_configBasic_auth res."basic_auth";
    }
    // {
    }
    // optionalAttrs (res."bearer_token_file" != null) { inherit (res) "bearer_token_file"; }
    // {
    }
    // optionalAttrs (res."bearer_token_secret" != null) {
      "bearer_token_secret" =
        mkReceiverSns_configHttp_configBearer_token_secret
          res."bearer_token_secret";
    }
    // {
    }
    // optionalAttrs (res."oauth2" != null) {
      "oauth2" = mkReceiverSns_configHttp_configOauth2 res."oauth2";
    }
    // {
    }
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."tls_config" != null) {
      "tls_config" = mkReceiverSns_configHttp_configTls_config res."tls_config";
    }
    // {
    };
  ReceiverSns_configHttp_configOauth2Client_idConfigMapModule = types.submodule {
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
  mkReceiverSns_configHttp_configOauth2Client_idConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverSns_configHttp_configOauth2Client_idModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr ReceiverSns_configHttp_configOauth2Client_idConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr ReceiverSns_configHttp_configOauth2Client_idSecretModule);
        default = null;
      };
    };
  };
  mkReceiverSns_configHttp_configOauth2Client_id =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverSns_configHttp_configOauth2Client_idConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverSns_configHttp_configOauth2Client_idSecret res."secret";
    }
    // {
    };
  ReceiverSns_configHttp_configOauth2Client_idSecretModule = types.submodule {
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
  mkReceiverSns_configHttp_configOauth2Client_idSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverSns_configHttp_configOauth2Client_secretModule = types.submodule {
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
  mkReceiverSns_configHttp_configOauth2Client_secret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverSns_configHttp_configOauth2Module = types.submodule {
    options = {
      "client_id" = mkOption {
        type = ReceiverSns_configHttp_configOauth2Client_idModule;
      };
      "client_secret" = mkOption {
        type = (types.nullOr ReceiverSns_configHttp_configOauth2Client_secretModule);
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
  mkReceiverSns_configHttp_configOauth2 =
    res:
    {
      "client_id" = mkReceiverSns_configHttp_configOauth2Client_id res."client_id";
    }
    // optionalAttrs (res."client_secret" != null) {
      "client_secret" = mkReceiverSns_configHttp_configOauth2Client_secret res."client_secret";
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
  ReceiverSns_configHttp_configTls_configCaConfigMapModule = types.submodule {
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
  mkReceiverSns_configHttp_configTls_configCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverSns_configHttp_configTls_configCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr ReceiverSns_configHttp_configTls_configCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr ReceiverSns_configHttp_configTls_configCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverSns_configHttp_configTls_configCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverSns_configHttp_configTls_configCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverSns_configHttp_configTls_configCaSecret res."secret";
    }
    // {
    };
  ReceiverSns_configHttp_configTls_configCaSecretModule = types.submodule {
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
  mkReceiverSns_configHttp_configTls_configCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverSns_configHttp_configTls_configCertConfigMapModule = types.submodule {
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
  mkReceiverSns_configHttp_configTls_configCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverSns_configHttp_configTls_configCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr ReceiverSns_configHttp_configTls_configCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr ReceiverSns_configHttp_configTls_configCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverSns_configHttp_configTls_configCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverSns_configHttp_configTls_configCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverSns_configHttp_configTls_configCertSecret res."secret";
    }
    // {
    };
  ReceiverSns_configHttp_configTls_configCertSecretModule = types.submodule {
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
  mkReceiverSns_configHttp_configTls_configCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverSns_configHttp_configTls_configKeySecretModule = types.submodule {
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
  mkReceiverSns_configHttp_configTls_configKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverSns_configHttp_configTls_configModule = types.submodule {
    options = {
      "ca" = mkOption {
        type = (types.nullOr ReceiverSns_configHttp_configTls_configCaModule);
        default = null;
      };
      "caFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "cert" = mkOption {
        type = (types.nullOr ReceiverSns_configHttp_configTls_configCertModule);
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
        type = (types.nullOr ReceiverSns_configHttp_configTls_configKeySecretModule);
        default = null;
      };
      "serverName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverSns_configHttp_configTls_config =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkReceiverSns_configHttp_configTls_configCa res."ca"; }
    // {
    }
    // optionalAttrs (res."caFile" != null) { inherit (res) "caFile"; }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverSns_configHttp_configTls_configCert res."cert";
    }
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
      "keySecret" = mkReceiverSns_configHttp_configTls_configKeySecret res."keySecret";
    }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    };
  ReceiverSns_configModule = types.submodule {
    options = {
      "api_url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "attributes" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "http_config" = mkOption {
        type = (types.nullOr ReceiverSns_configHttp_configModule);
        default = null;
      };
      "message" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "phone_number" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "send_resolved" = mkOption {
        type = types.bool;
        default = false;
      };
      "sigv4" = mkOption {
        type = (types.nullOr ReceiverSns_configSigv4Module);
        default = null;
      };
      "subject" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "target_arn" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "topic_arn" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverSns_config =
    res:
    {
    }
    // optionalAttrs (res."api_url" != null) { inherit (res) "api_url"; }
    // {
    }
    // optionalAttrs (res."attributes" != { }) { inherit (res) "attributes"; }
    // {
    }
    // optionalAttrs (res."http_config" != null) {
      "http_config" = mkReceiverSns_configHttp_config res."http_config";
    }
    // {
    }
    // optionalAttrs (res."message" != null) { inherit (res) "message"; }
    // {
    }
    // optionalAttrs (res."phone_number" != null) { inherit (res) "phone_number"; }
    // {
    }
    // optionalAttrs res."send_resolved" { inherit (res) "send_resolved"; }
    // {
    }
    // optionalAttrs (res."sigv4" != null) { "sigv4" = mkReceiverSns_configSigv4 res."sigv4"; }
    // {
    }
    // optionalAttrs (res."subject" != null) { inherit (res) "subject"; }
    // {
    }
    // optionalAttrs (res."target_arn" != null) { inherit (res) "target_arn"; }
    // {
    }
    // optionalAttrs (res."topic_arn" != null) { inherit (res) "topic_arn"; }
    // {
    };
  ReceiverSns_configSigv4Access_key_selectorModule = types.submodule {
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
  mkReceiverSns_configSigv4Access_key_selector =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverSns_configSigv4Module = types.submodule {
    options = {
      "access_key" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "access_key_selector" = mkOption {
        type = (types.nullOr ReceiverSns_configSigv4Access_key_selectorModule);
        default = null;
      };
      "profile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "region" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "role_arn" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "secret_key_selector" = mkOption {
        type = (types.nullOr ReceiverSns_configSigv4Secret_key_selectorModule);
        default = null;
      };
    };
  };
  mkReceiverSns_configSigv4 =
    res:
    {
    }
    // optionalAttrs (res."access_key" != null) { inherit (res) "access_key"; }
    // {
    }
    // optionalAttrs (res."access_key_selector" != null) {
      "access_key_selector" = mkReceiverSns_configSigv4Access_key_selector res."access_key_selector";
    }
    // {
    }
    // optionalAttrs (res."profile" != null) { inherit (res) "profile"; }
    // {
    }
    // optionalAttrs (res."region" != null) { inherit (res) "region"; }
    // {
    }
    // optionalAttrs (res."role_arn" != null) { inherit (res) "role_arn"; }
    // {
    }
    // optionalAttrs (res."secret_key_selector" != null) {
      "secret_key_selector" = mkReceiverSns_configSigv4Secret_key_selector res."secret_key_selector";
    }
    // {
    };
  ReceiverSns_configSigv4Secret_key_selectorModule = types.submodule {
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
  mkReceiverSns_configSigv4Secret_key_selector =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverTelegram_configBot_tokenModule = types.submodule {
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
  mkReceiverTelegram_configBot_token =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverTelegram_configModule = types.submodule {
    options = {
      "api_url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "bot_token" = mkOption {
        type = ReceiverTelegram_configBot_tokenModule;
      };
      "chat_id" = mkOption {
        type = types.int;
      };
      "disable_notifications" = mkOption {
        type = types.bool;
        default = false;
      };
      "http_config" = mkOption {
        type = (types.attrsOf types.anything);
        default = { };
      };
      "message" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "message_thread_id" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "parse_mode" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "send_resolved" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkReceiverTelegram_config =
    res:
    {
    }
    // optionalAttrs (res."api_url" != null) { inherit (res) "api_url"; }
    // {
      "bot_token" = mkReceiverTelegram_configBot_token res."bot_token";
      inherit (res) "chat_id";
    }
    // optionalAttrs res."disable_notifications" { inherit (res) "disable_notifications"; }
    // {
    }
    // optionalAttrs (res."http_config" != { }) { inherit (res) "http_config"; }
    // {
    }
    // optionalAttrs (res."message" != null) { inherit (res) "message"; }
    // {
    }
    // optionalAttrs (res."message_thread_id" != null) { inherit (res) "message_thread_id"; }
    // {
    }
    // optionalAttrs (res."parse_mode" != null) { inherit (res) "parse_mode"; }
    // {
    }
    // optionalAttrs res."send_resolved" { inherit (res) "send_resolved"; }
    // {
    };
  ReceiverVictorops_configApi_keyModule = types.submodule {
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
  mkReceiverVictorops_configApi_key =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverVictorops_configHttp_configAuthorizationCredentialsModule = types.submodule {
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
  mkReceiverVictorops_configHttp_configAuthorizationCredentials =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverVictorops_configHttp_configAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        type = (types.nullOr ReceiverVictorops_configHttp_configAuthorizationCredentialsModule);
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
  mkReceiverVictorops_configHttp_configAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkReceiverVictorops_configHttp_configAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."credentialsFile" != null) { inherit (res) "credentialsFile"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ReceiverVictorops_configHttp_configBasic_authModule = types.submodule {
    options = {
      "password" = mkOption {
        type = (types.nullOr ReceiverVictorops_configHttp_configBasic_authPasswordModule);
        default = null;
      };
      "password_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
        type = (types.nullOr ReceiverVictorops_configHttp_configBasic_authUsernameModule);
        default = null;
      };
    };
  };
  mkReceiverVictorops_configHttp_configBasic_auth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkReceiverVictorops_configHttp_configBasic_authPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."password_file" != null) { inherit (res) "password_file"; }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkReceiverVictorops_configHttp_configBasic_authUsername res."username";
    }
    // {
    };
  ReceiverVictorops_configHttp_configBasic_authPasswordModule = types.submodule {
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
  mkReceiverVictorops_configHttp_configBasic_authPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverVictorops_configHttp_configBasic_authUsernameModule = types.submodule {
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
  mkReceiverVictorops_configHttp_configBasic_authUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverVictorops_configHttp_configBearer_token_secretModule = types.submodule {
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
  mkReceiverVictorops_configHttp_configBearer_token_secret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverVictorops_configHttp_configModule = types.submodule {
    options = {
      "authorization" = mkOption {
        type = (types.nullOr ReceiverVictorops_configHttp_configAuthorizationModule);
        default = null;
      };
      "basic_auth" = mkOption {
        type = (types.nullOr ReceiverVictorops_configHttp_configBasic_authModule);
        default = null;
      };
      "bearer_token_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "bearer_token_secret" = mkOption {
        type = (types.nullOr ReceiverVictorops_configHttp_configBearer_token_secretModule);
        default = null;
      };
      "oauth2" = mkOption {
        type = (types.nullOr ReceiverVictorops_configHttp_configOauth2Module);
        default = null;
      };
      "proxyURL" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "tls_config" = mkOption {
        type = (types.nullOr ReceiverVictorops_configHttp_configTls_configModule);
        default = null;
      };
    };
  };
  mkReceiverVictorops_configHttp_config =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkReceiverVictorops_configHttp_configAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basic_auth" != null) {
      "basic_auth" = mkReceiverVictorops_configHttp_configBasic_auth res."basic_auth";
    }
    // {
    }
    // optionalAttrs (res."bearer_token_file" != null) { inherit (res) "bearer_token_file"; }
    // {
    }
    // optionalAttrs (res."bearer_token_secret" != null) {
      "bearer_token_secret" =
        mkReceiverVictorops_configHttp_configBearer_token_secret
          res."bearer_token_secret";
    }
    // {
    }
    // optionalAttrs (res."oauth2" != null) {
      "oauth2" = mkReceiverVictorops_configHttp_configOauth2 res."oauth2";
    }
    // {
    }
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."tls_config" != null) {
      "tls_config" = mkReceiverVictorops_configHttp_configTls_config res."tls_config";
    }
    // {
    };
  ReceiverVictorops_configHttp_configOauth2Client_idConfigMapModule = types.submodule {
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
  mkReceiverVictorops_configHttp_configOauth2Client_idConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverVictorops_configHttp_configOauth2Client_idModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr ReceiverVictorops_configHttp_configOauth2Client_idConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr ReceiverVictorops_configHttp_configOauth2Client_idSecretModule);
        default = null;
      };
    };
  };
  mkReceiverVictorops_configHttp_configOauth2Client_id =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverVictorops_configHttp_configOauth2Client_idConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverVictorops_configHttp_configOauth2Client_idSecret res."secret";
    }
    // {
    };
  ReceiverVictorops_configHttp_configOauth2Client_idSecretModule = types.submodule {
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
  mkReceiverVictorops_configHttp_configOauth2Client_idSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverVictorops_configHttp_configOauth2Client_secretModule = types.submodule {
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
  mkReceiverVictorops_configHttp_configOauth2Client_secret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverVictorops_configHttp_configOauth2Module = types.submodule {
    options = {
      "client_id" = mkOption {
        type = ReceiverVictorops_configHttp_configOauth2Client_idModule;
      };
      "client_secret" = mkOption {
        type = (types.nullOr ReceiverVictorops_configHttp_configOauth2Client_secretModule);
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
  mkReceiverVictorops_configHttp_configOauth2 =
    res:
    {
      "client_id" = mkReceiverVictorops_configHttp_configOauth2Client_id res."client_id";
    }
    // optionalAttrs (res."client_secret" != null) {
      "client_secret" = mkReceiverVictorops_configHttp_configOauth2Client_secret res."client_secret";
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
  ReceiverVictorops_configHttp_configTls_configCaConfigMapModule = types.submodule {
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
  mkReceiverVictorops_configHttp_configTls_configCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverVictorops_configHttp_configTls_configCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr ReceiverVictorops_configHttp_configTls_configCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr ReceiverVictorops_configHttp_configTls_configCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverVictorops_configHttp_configTls_configCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverVictorops_configHttp_configTls_configCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverVictorops_configHttp_configTls_configCaSecret res."secret";
    }
    // {
    };
  ReceiverVictorops_configHttp_configTls_configCaSecretModule = types.submodule {
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
  mkReceiverVictorops_configHttp_configTls_configCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverVictorops_configHttp_configTls_configCertConfigMapModule = types.submodule {
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
  mkReceiverVictorops_configHttp_configTls_configCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverVictorops_configHttp_configTls_configCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr ReceiverVictorops_configHttp_configTls_configCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr ReceiverVictorops_configHttp_configTls_configCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverVictorops_configHttp_configTls_configCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverVictorops_configHttp_configTls_configCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverVictorops_configHttp_configTls_configCertSecret res."secret";
    }
    // {
    };
  ReceiverVictorops_configHttp_configTls_configCertSecretModule = types.submodule {
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
  mkReceiverVictorops_configHttp_configTls_configCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverVictorops_configHttp_configTls_configKeySecretModule = types.submodule {
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
  mkReceiverVictorops_configHttp_configTls_configKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverVictorops_configHttp_configTls_configModule = types.submodule {
    options = {
      "ca" = mkOption {
        type = (types.nullOr ReceiverVictorops_configHttp_configTls_configCaModule);
        default = null;
      };
      "caFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "cert" = mkOption {
        type = (types.nullOr ReceiverVictorops_configHttp_configTls_configCertModule);
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
        type = (types.nullOr ReceiverVictorops_configHttp_configTls_configKeySecretModule);
        default = null;
      };
      "serverName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverVictorops_configHttp_configTls_config =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverVictorops_configHttp_configTls_configCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."caFile" != null) { inherit (res) "caFile"; }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverVictorops_configHttp_configTls_configCert res."cert";
    }
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
      "keySecret" = mkReceiverVictorops_configHttp_configTls_configKeySecret res."keySecret";
    }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    };
  ReceiverVictorops_configModule = types.submodule {
    options = {
      "api_key" = mkOption {
        type = (types.nullOr ReceiverVictorops_configApi_keyModule);
        default = null;
      };
      "api_url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "custom_fields" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "entity_display_name" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "http_config" = mkOption {
        type = (types.nullOr ReceiverVictorops_configHttp_configModule);
        default = null;
      };
      "message_type" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "monitoring_tool" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "routing_key" = mkOption {
        type = types.str;
      };
      "send_resolved" = mkOption {
        type = types.bool;
        default = false;
      };
      "state_message" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverVictorops_config =
    res:
    {
    }
    // optionalAttrs (res."api_key" != null) {
      "api_key" = mkReceiverVictorops_configApi_key res."api_key";
    }
    // {
    }
    // optionalAttrs (res."api_url" != null) { inherit (res) "api_url"; }
    // {
    }
    // optionalAttrs (res."custom_fields" != { }) { inherit (res) "custom_fields"; }
    // {
    }
    // optionalAttrs (res."entity_display_name" != null) { inherit (res) "entity_display_name"; }
    // {
    }
    // optionalAttrs (res."http_config" != null) {
      "http_config" = mkReceiverVictorops_configHttp_config res."http_config";
    }
    // {
    }
    // optionalAttrs (res."message_type" != null) { inherit (res) "message_type"; }
    // {
    }
    // optionalAttrs (res."monitoring_tool" != null) { inherit (res) "monitoring_tool"; }
    // {
      inherit (res) "routing_key";
    }
    // optionalAttrs res."send_resolved" { inherit (res) "send_resolved"; }
    // {
    }
    // optionalAttrs (res."state_message" != null) { inherit (res) "state_message"; }
    // {
    };
  ReceiverWebex_configHttp_configAuthorizationCredentialsModule = types.submodule {
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
  mkReceiverWebex_configHttp_configAuthorizationCredentials =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWebex_configHttp_configAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        type = (types.nullOr ReceiverWebex_configHttp_configAuthorizationCredentialsModule);
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
  mkReceiverWebex_configHttp_configAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkReceiverWebex_configHttp_configAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."credentialsFile" != null) { inherit (res) "credentialsFile"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ReceiverWebex_configHttp_configBasic_authModule = types.submodule {
    options = {
      "password" = mkOption {
        type = (types.nullOr ReceiverWebex_configHttp_configBasic_authPasswordModule);
        default = null;
      };
      "password_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
        type = (types.nullOr ReceiverWebex_configHttp_configBasic_authUsernameModule);
        default = null;
      };
    };
  };
  mkReceiverWebex_configHttp_configBasic_auth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkReceiverWebex_configHttp_configBasic_authPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."password_file" != null) { inherit (res) "password_file"; }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkReceiverWebex_configHttp_configBasic_authUsername res."username";
    }
    // {
    };
  ReceiverWebex_configHttp_configBasic_authPasswordModule = types.submodule {
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
  mkReceiverWebex_configHttp_configBasic_authPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWebex_configHttp_configBasic_authUsernameModule = types.submodule {
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
  mkReceiverWebex_configHttp_configBasic_authUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWebex_configHttp_configBearer_token_secretModule = types.submodule {
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
  mkReceiverWebex_configHttp_configBearer_token_secret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWebex_configHttp_configModule = types.submodule {
    options = {
      "authorization" = mkOption {
        type = (types.nullOr ReceiverWebex_configHttp_configAuthorizationModule);
        default = null;
      };
      "basic_auth" = mkOption {
        type = (types.nullOr ReceiverWebex_configHttp_configBasic_authModule);
        default = null;
      };
      "bearer_token_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "bearer_token_secret" = mkOption {
        type = (types.nullOr ReceiverWebex_configHttp_configBearer_token_secretModule);
        default = null;
      };
      "oauth2" = mkOption {
        type = (types.nullOr ReceiverWebex_configHttp_configOauth2Module);
        default = null;
      };
      "proxyURL" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "tls_config" = mkOption {
        type = (types.nullOr ReceiverWebex_configHttp_configTls_configModule);
        default = null;
      };
    };
  };
  mkReceiverWebex_configHttp_config =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkReceiverWebex_configHttp_configAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basic_auth" != null) {
      "basic_auth" = mkReceiverWebex_configHttp_configBasic_auth res."basic_auth";
    }
    // {
    }
    // optionalAttrs (res."bearer_token_file" != null) { inherit (res) "bearer_token_file"; }
    // {
    }
    // optionalAttrs (res."bearer_token_secret" != null) {
      "bearer_token_secret" =
        mkReceiverWebex_configHttp_configBearer_token_secret
          res."bearer_token_secret";
    }
    // {
    }
    // optionalAttrs (res."oauth2" != null) {
      "oauth2" = mkReceiverWebex_configHttp_configOauth2 res."oauth2";
    }
    // {
    }
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."tls_config" != null) {
      "tls_config" = mkReceiverWebex_configHttp_configTls_config res."tls_config";
    }
    // {
    };
  ReceiverWebex_configHttp_configOauth2Client_idConfigMapModule = types.submodule {
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
  mkReceiverWebex_configHttp_configOauth2Client_idConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWebex_configHttp_configOauth2Client_idModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr ReceiverWebex_configHttp_configOauth2Client_idConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr ReceiverWebex_configHttp_configOauth2Client_idSecretModule);
        default = null;
      };
    };
  };
  mkReceiverWebex_configHttp_configOauth2Client_id =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverWebex_configHttp_configOauth2Client_idConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverWebex_configHttp_configOauth2Client_idSecret res."secret";
    }
    // {
    };
  ReceiverWebex_configHttp_configOauth2Client_idSecretModule = types.submodule {
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
  mkReceiverWebex_configHttp_configOauth2Client_idSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWebex_configHttp_configOauth2Client_secretModule = types.submodule {
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
  mkReceiverWebex_configHttp_configOauth2Client_secret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWebex_configHttp_configOauth2Module = types.submodule {
    options = {
      "client_id" = mkOption {
        type = ReceiverWebex_configHttp_configOauth2Client_idModule;
      };
      "client_secret" = mkOption {
        type = (types.nullOr ReceiverWebex_configHttp_configOauth2Client_secretModule);
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
  mkReceiverWebex_configHttp_configOauth2 =
    res:
    {
      "client_id" = mkReceiverWebex_configHttp_configOauth2Client_id res."client_id";
    }
    // optionalAttrs (res."client_secret" != null) {
      "client_secret" = mkReceiverWebex_configHttp_configOauth2Client_secret res."client_secret";
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
  ReceiverWebex_configHttp_configTls_configCaConfigMapModule = types.submodule {
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
  mkReceiverWebex_configHttp_configTls_configCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWebex_configHttp_configTls_configCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr ReceiverWebex_configHttp_configTls_configCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr ReceiverWebex_configHttp_configTls_configCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverWebex_configHttp_configTls_configCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverWebex_configHttp_configTls_configCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverWebex_configHttp_configTls_configCaSecret res."secret";
    }
    // {
    };
  ReceiverWebex_configHttp_configTls_configCaSecretModule = types.submodule {
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
  mkReceiverWebex_configHttp_configTls_configCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWebex_configHttp_configTls_configCertConfigMapModule = types.submodule {
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
  mkReceiverWebex_configHttp_configTls_configCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWebex_configHttp_configTls_configCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr ReceiverWebex_configHttp_configTls_configCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr ReceiverWebex_configHttp_configTls_configCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverWebex_configHttp_configTls_configCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverWebex_configHttp_configTls_configCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverWebex_configHttp_configTls_configCertSecret res."secret";
    }
    // {
    };
  ReceiverWebex_configHttp_configTls_configCertSecretModule = types.submodule {
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
  mkReceiverWebex_configHttp_configTls_configCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWebex_configHttp_configTls_configKeySecretModule = types.submodule {
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
  mkReceiverWebex_configHttp_configTls_configKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWebex_configHttp_configTls_configModule = types.submodule {
    options = {
      "ca" = mkOption {
        type = (types.nullOr ReceiverWebex_configHttp_configTls_configCaModule);
        default = null;
      };
      "caFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "cert" = mkOption {
        type = (types.nullOr ReceiverWebex_configHttp_configTls_configCertModule);
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
        type = (types.nullOr ReceiverWebex_configHttp_configTls_configKeySecretModule);
        default = null;
      };
      "serverName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverWebex_configHttp_configTls_config =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverWebex_configHttp_configTls_configCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."caFile" != null) { inherit (res) "caFile"; }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverWebex_configHttp_configTls_configCert res."cert";
    }
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
      "keySecret" = mkReceiverWebex_configHttp_configTls_configKeySecret res."keySecret";
    }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    };
  ReceiverWebex_configModule = types.submodule {
    options = {
      "api_url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "http_config" = mkOption {
        type = (types.nullOr ReceiverWebex_configHttp_configModule);
        default = null;
      };
      "message" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "room_id" = mkOption {
        type = types.str;
      };
      "send_resolved" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkReceiverWebex_config =
    res:
    {
    }
    // optionalAttrs (res."api_url" != null) { inherit (res) "api_url"; }
    // {
    }
    // optionalAttrs (res."http_config" != null) {
      "http_config" = mkReceiverWebex_configHttp_config res."http_config";
    }
    // {
    }
    // optionalAttrs (res."message" != null) { inherit (res) "message"; }
    // {
      inherit (res) "room_id";
    }
    // optionalAttrs res."send_resolved" { inherit (res) "send_resolved"; }
    // {
    };
  ReceiverWebhook_configModule = types.submodule {
    options = {
      "http_config" = mkOption {
        type = (types.attrsOf types.anything);
        default = { };
      };
      "max_alerts" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "send_resolved" = mkOption {
        type = types.bool;
        default = false;
      };
      "timeout" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "url_secret" = mkOption {
        type = (types.nullOr ReceiverWebhook_configUrl_secretModule);
        default = null;
      };
    };
  };
  mkReceiverWebhook_config =
    res:
    {
    }
    // optionalAttrs (res."http_config" != { }) { inherit (res) "http_config"; }
    // {
    }
    // optionalAttrs (res."max_alerts" != null) { inherit (res) "max_alerts"; }
    // {
    }
    // optionalAttrs res."send_resolved" { inherit (res) "send_resolved"; }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    }
    // optionalAttrs (res."url" != null) { inherit (res) "url"; }
    // {
    }
    // optionalAttrs (res."url_secret" != null) {
      "url_secret" = mkReceiverWebhook_configUrl_secret res."url_secret";
    }
    // {
    };
  ReceiverWebhook_configUrl_secretModule = types.submodule {
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
  mkReceiverWebhook_configUrl_secret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWechat_configApi_secretModule = types.submodule {
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
  mkReceiverWechat_configApi_secret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWechat_configHttp_configAuthorizationCredentialsModule = types.submodule {
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
  mkReceiverWechat_configHttp_configAuthorizationCredentials =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWechat_configHttp_configAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        type = (types.nullOr ReceiverWechat_configHttp_configAuthorizationCredentialsModule);
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
  mkReceiverWechat_configHttp_configAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkReceiverWechat_configHttp_configAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."credentialsFile" != null) { inherit (res) "credentialsFile"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  ReceiverWechat_configHttp_configBasic_authModule = types.submodule {
    options = {
      "password" = mkOption {
        type = (types.nullOr ReceiverWechat_configHttp_configBasic_authPasswordModule);
        default = null;
      };
      "password_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
        type = (types.nullOr ReceiverWechat_configHttp_configBasic_authUsernameModule);
        default = null;
      };
    };
  };
  mkReceiverWechat_configHttp_configBasic_auth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkReceiverWechat_configHttp_configBasic_authPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."password_file" != null) { inherit (res) "password_file"; }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkReceiverWechat_configHttp_configBasic_authUsername res."username";
    }
    // {
    };
  ReceiverWechat_configHttp_configBasic_authPasswordModule = types.submodule {
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
  mkReceiverWechat_configHttp_configBasic_authPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWechat_configHttp_configBasic_authUsernameModule = types.submodule {
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
  mkReceiverWechat_configHttp_configBasic_authUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWechat_configHttp_configBearer_token_secretModule = types.submodule {
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
  mkReceiverWechat_configHttp_configBearer_token_secret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWechat_configHttp_configModule = types.submodule {
    options = {
      "authorization" = mkOption {
        type = (types.nullOr ReceiverWechat_configHttp_configAuthorizationModule);
        default = null;
      };
      "basic_auth" = mkOption {
        type = (types.nullOr ReceiverWechat_configHttp_configBasic_authModule);
        default = null;
      };
      "bearer_token_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "bearer_token_secret" = mkOption {
        type = (types.nullOr ReceiverWechat_configHttp_configBearer_token_secretModule);
        default = null;
      };
      "oauth2" = mkOption {
        type = (types.nullOr ReceiverWechat_configHttp_configOauth2Module);
        default = null;
      };
      "proxyURL" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "tls_config" = mkOption {
        type = (types.nullOr ReceiverWechat_configHttp_configTls_configModule);
        default = null;
      };
    };
  };
  mkReceiverWechat_configHttp_config =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkReceiverWechat_configHttp_configAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basic_auth" != null) {
      "basic_auth" = mkReceiverWechat_configHttp_configBasic_auth res."basic_auth";
    }
    // {
    }
    // optionalAttrs (res."bearer_token_file" != null) { inherit (res) "bearer_token_file"; }
    // {
    }
    // optionalAttrs (res."bearer_token_secret" != null) {
      "bearer_token_secret" =
        mkReceiverWechat_configHttp_configBearer_token_secret
          res."bearer_token_secret";
    }
    // {
    }
    // optionalAttrs (res."oauth2" != null) {
      "oauth2" = mkReceiverWechat_configHttp_configOauth2 res."oauth2";
    }
    // {
    }
    // optionalAttrs (res."proxyURL" != null) { inherit (res) "proxyURL"; }
    // {
    }
    // optionalAttrs (res."tls_config" != null) {
      "tls_config" = mkReceiverWechat_configHttp_configTls_config res."tls_config";
    }
    // {
    };
  ReceiverWechat_configHttp_configOauth2Client_idConfigMapModule = types.submodule {
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
  mkReceiverWechat_configHttp_configOauth2Client_idConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWechat_configHttp_configOauth2Client_idModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr ReceiverWechat_configHttp_configOauth2Client_idConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr ReceiverWechat_configHttp_configOauth2Client_idSecretModule);
        default = null;
      };
    };
  };
  mkReceiverWechat_configHttp_configOauth2Client_id =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverWechat_configHttp_configOauth2Client_idConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverWechat_configHttp_configOauth2Client_idSecret res."secret";
    }
    // {
    };
  ReceiverWechat_configHttp_configOauth2Client_idSecretModule = types.submodule {
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
  mkReceiverWechat_configHttp_configOauth2Client_idSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWechat_configHttp_configOauth2Client_secretModule = types.submodule {
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
  mkReceiverWechat_configHttp_configOauth2Client_secret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWechat_configHttp_configOauth2Module = types.submodule {
    options = {
      "client_id" = mkOption {
        type = ReceiverWechat_configHttp_configOauth2Client_idModule;
      };
      "client_secret" = mkOption {
        type = (types.nullOr ReceiverWechat_configHttp_configOauth2Client_secretModule);
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
  mkReceiverWechat_configHttp_configOauth2 =
    res:
    {
      "client_id" = mkReceiverWechat_configHttp_configOauth2Client_id res."client_id";
    }
    // optionalAttrs (res."client_secret" != null) {
      "client_secret" = mkReceiverWechat_configHttp_configOauth2Client_secret res."client_secret";
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
  ReceiverWechat_configHttp_configTls_configCaConfigMapModule = types.submodule {
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
  mkReceiverWechat_configHttp_configTls_configCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWechat_configHttp_configTls_configCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr ReceiverWechat_configHttp_configTls_configCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr ReceiverWechat_configHttp_configTls_configCaSecretModule);
        default = null;
      };
    };
  };
  mkReceiverWechat_configHttp_configTls_configCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverWechat_configHttp_configTls_configCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverWechat_configHttp_configTls_configCaSecret res."secret";
    }
    // {
    };
  ReceiverWechat_configHttp_configTls_configCaSecretModule = types.submodule {
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
  mkReceiverWechat_configHttp_configTls_configCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWechat_configHttp_configTls_configCertConfigMapModule = types.submodule {
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
  mkReceiverWechat_configHttp_configTls_configCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWechat_configHttp_configTls_configCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr ReceiverWechat_configHttp_configTls_configCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr ReceiverWechat_configHttp_configTls_configCertSecretModule);
        default = null;
      };
    };
  };
  mkReceiverWechat_configHttp_configTls_configCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkReceiverWechat_configHttp_configTls_configCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkReceiverWechat_configHttp_configTls_configCertSecret res."secret";
    }
    // {
    };
  ReceiverWechat_configHttp_configTls_configCertSecretModule = types.submodule {
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
  mkReceiverWechat_configHttp_configTls_configCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWechat_configHttp_configTls_configKeySecretModule = types.submodule {
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
  mkReceiverWechat_configHttp_configTls_configKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ReceiverWechat_configHttp_configTls_configModule = types.submodule {
    options = {
      "ca" = mkOption {
        type = (types.nullOr ReceiverWechat_configHttp_configTls_configCaModule);
        default = null;
      };
      "caFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "cert" = mkOption {
        type = (types.nullOr ReceiverWechat_configHttp_configTls_configCertModule);
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
        type = (types.nullOr ReceiverWechat_configHttp_configTls_configKeySecretModule);
        default = null;
      };
      "serverName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverWechat_configHttp_configTls_config =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) {
      "ca" = mkReceiverWechat_configHttp_configTls_configCa res."ca";
    }
    // {
    }
    // optionalAttrs (res."caFile" != null) { inherit (res) "caFile"; }
    // {
    }
    // optionalAttrs (res."cert" != null) {
      "cert" = mkReceiverWechat_configHttp_configTls_configCert res."cert";
    }
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
      "keySecret" = mkReceiverWechat_configHttp_configTls_configKeySecret res."keySecret";
    }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    };
  ReceiverWechat_configModule = types.submodule {
    options = {
      "agent_id" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "api_secret" = mkOption {
        type = (types.nullOr ReceiverWechat_configApi_secretModule);
        default = null;
      };
      "api_url" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "corp_id" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "http_config" = mkOption {
        type = (types.nullOr ReceiverWechat_configHttp_configModule);
        default = null;
      };
      "message" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "message_type" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "send_resolved" = mkOption {
        type = types.bool;
        default = false;
      };
      "to_party" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "to_tag" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "to_user" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReceiverWechat_config =
    res:
    {
    }
    // optionalAttrs (res."agent_id" != null) { inherit (res) "agent_id"; }
    // {
    }
    // optionalAttrs (res."api_secret" != null) {
      "api_secret" = mkReceiverWechat_configApi_secret res."api_secret";
    }
    // {
    }
    // optionalAttrs (res."api_url" != null) { inherit (res) "api_url"; }
    // {
    }
    // optionalAttrs (res."corp_id" != null) { inherit (res) "corp_id"; }
    // {
    }
    // optionalAttrs (res."http_config" != null) {
      "http_config" = mkReceiverWechat_configHttp_config res."http_config";
    }
    // {
    }
    // optionalAttrs (res."message" != null) { inherit (res) "message"; }
    // {
    }
    // optionalAttrs (res."message_type" != null) { inherit (res) "message_type"; }
    // {
    }
    // optionalAttrs res."send_resolved" { inherit (res) "send_resolved"; }
    // {
    }
    // optionalAttrs (res."to_party" != null) { inherit (res) "to_party"; }
    // {
    }
    // optionalAttrs (res."to_tag" != null) { inherit (res) "to_tag"; }
    // {
    }
    // optionalAttrs (res."to_user" != null) { inherit (res) "to_user"; }
    // {
    };
  RouteModule = types.submodule {
    options = {
      "active_time_intervals" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "continue" = mkOption {
        type = types.bool;
        default = false;
      };
      "group_by" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "group_interval" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "group_wait" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "matchers" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "mute_time_intervals" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "receiver" = mkOption {
        type = types.str;
      };
      "repeat_interval" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "routes" = mkOption {
        type = (types.listOf types.anything);
        default = [ ];
      };
    };
  };
  mkRoute =
    res:
    {
    }
    // optionalAttrs (res."active_time_intervals" != [ ]) { inherit (res) "active_time_intervals"; }
    // {
    }
    // optionalAttrs res."continue" { inherit (res) "continue"; }
    // {
    }
    // optionalAttrs (res."group_by" != [ ]) { inherit (res) "group_by"; }
    // {
    }
    // optionalAttrs (res."group_interval" != null) { inherit (res) "group_interval"; }
    // {
    }
    // optionalAttrs (res."group_wait" != null) { inherit (res) "group_wait"; }
    // {
    }
    // optionalAttrs (res."matchers" != [ ]) { inherit (res) "matchers"; }
    // {
    }
    // optionalAttrs (res."mute_time_intervals" != [ ]) { inherit (res) "mute_time_intervals"; }
    // {
      inherit (res) "receiver";
    }
    // optionalAttrs (res."repeat_interval" != null) { inherit (res) "repeat_interval"; }
    // {
    }
    // optionalAttrs (res."routes" != [ ]) { inherit (res) "routes"; }
    // {
    };
  Time_intervalModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "time_intervals" = mkOption {
        type = (types.listOf Time_intervalTime_intervalModule);
      };
    };
  };
  mkTime_interval = res: {
    inherit (res) "name";
    "time_intervals" = map mkTime_intervalTime_interval res."time_intervals";
  };
  Time_intervalTime_intervalModule = types.submodule {
    options = {
      "days_of_month" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "location" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "months" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "times" = mkOption {
        type = (types.listOf Time_intervalTime_intervalTimeModule);
        default = [ ];
      };
      "weekdays" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "years" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkTime_intervalTime_interval =
    res:
    {
    }
    // optionalAttrs (res."days_of_month" != [ ]) { inherit (res) "days_of_month"; }
    // {
    }
    // optionalAttrs (res."location" != null) { inherit (res) "location"; }
    // {
    }
    // optionalAttrs (res."months" != [ ]) { inherit (res) "months"; }
    // {
    }
    // optionalAttrs (res."times" != [ ]) {
      "times" = map mkTime_intervalTime_intervalTime res."times";
    }
    // {
    }
    // optionalAttrs (res."weekdays" != [ ]) { inherit (res) "weekdays"; }
    // {
    }
    // optionalAttrs (res."years" != [ ]) { inherit (res) "years"; }
    // {
    };
  Time_intervalTime_intervalTimeModule = types.submodule {
    options = {
      "end_time" = mkOption {
        type = types.str;
      };
      "start_time" = mkOption {
        type = types.str;
      };
    };
  };
  mkTime_intervalTime_intervalTime = res: {
    inherit (res) "end_time";
    inherit (res) "start_time";
  };
  VmalertmanagerconfigsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this VMAlertmanagerConfig resource.";
        };
        "inhibit_rules" = mkOption {
          type = (types.listOf Inhibit_ruleModule);
          default = [ ];
        };
        "receivers" = mkOption {
          type = (types.listOf ReceiverModule);
          default = [ ];
        };
        "route" = mkOption {
          type = (types.nullOr RouteModule);
          default = null;
        };
        "time_intervals" = mkOption {
          type = (types.listOf Time_intervalModule);
          default = [ ];
        };
      };
    }
  );
  mkVMAlertmanagerConfig = name: res: {
    apiVersion = "operator.victoriametrics.com/v1beta1";
    kind = "VMAlertmanagerConfig";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."inhibit_rules" != [ ]) {
      "inhibit_rules" = map mkInhibit_rule res."inhibit_rules";
    }
    // {
    }
    // optionalAttrs (res."receivers" != [ ]) { "receivers" = map mkReceiver res."receivers"; }
    // {
    }
    // optionalAttrs (res."route" != null) { "route" = mkRoute res."route"; }
    // {
    }
    // optionalAttrs (res."time_intervals" != [ ]) {
      "time_intervals" = map mkTime_interval res."time_intervals";
    }
    // {
    };
  };
  allResources = (mapAttrsToList mkVMAlertmanagerConfig cfg."vmalertmanagerconfigs");
in
{
  options.openkrill.apps."victoriametrics" = {
    "vmalertmanagerconfigs" = mkOption {
      type = types.attrsOf VmalertmanagerconfigsModule;
      default = { };
      description = "VMAlertmanagerConfig CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."victoriametrics".content = allResources;
  };
}
