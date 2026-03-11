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
  SelectorMatchExpressionModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "operator" = mkOption {
        type = types.str;
      };
      "values" = mkOption {
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
        type = (types.listOf SelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
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
  VmnodescrapesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this VMNodeScrape resource.";
        };
        "authorization" = mkOption {
          type = (types.nullOr AuthorizationModule);
          default = null;
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
        "follow_redirects" = mkOption {
          type = types.bool;
          default = false;
        };
        "honorLabels" = mkOption {
          type = types.bool;
          default = false;
        };
        "honorTimestamps" = mkOption {
          type = types.bool;
          default = false;
        };
        "interval" = mkOption {
          type = (types.nullOr types.str);
          default = null;
        };
        "jobLabel" = mkOption {
          type = (types.nullOr types.str);
          default = null;
        };
        "max_scrape_size" = mkOption {
          type = (types.nullOr types.str);
          default = null;
        };
        "metricRelabelConfigs" = mkOption {
          type = (types.listOf MetricRelabelConfigModule);
          default = [ ];
        };
        "oauth2" = mkOption {
          type = (types.nullOr Oauth2Module);
          default = null;
        };
        "params" = mkOption {
          type = (types.attrsOf (types.listOf types.str));
          default = { };
        };
        "path" = mkOption {
          type = (types.nullOr types.str);
          default = null;
        };
        "port" = mkOption {
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
        "selector" = mkOption {
          type = (types.nullOr SelectorModule);
          default = null;
        };
        "seriesLimit" = mkOption {
          type = (types.nullOr types.int);
          default = null;
        };
        "targetLabels" = mkOption {
          type = (types.listOf types.str);
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
  mkVMNodeScrape = name: res: {
    apiVersion = "operator.victoriametrics.com/v1beta1";
    kind = "VMNodeScrape";
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
    // optionalAttrs (res."bearerTokenFile" != null) { inherit (res) "bearerTokenFile"; }
    // {
    }
    // optionalAttrs (res."bearerTokenSecret" != null) {
      "bearerTokenSecret" = mkBearerTokenSecret res."bearerTokenSecret";
    }
    // {
    }
    // optionalAttrs res."follow_redirects" { inherit (res) "follow_redirects"; }
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
    // optionalAttrs (res."jobLabel" != null) { inherit (res) "jobLabel"; }
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
    // optionalAttrs (res."oauth2" != null) { "oauth2" = mkOauth2 res."oauth2"; }
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
    // optionalAttrs (res."selector" != null) { "selector" = mkSelector res."selector"; }
    // {
    }
    // optionalAttrs (res."seriesLimit" != null) { inherit (res) "seriesLimit"; }
    // {
    }
    // optionalAttrs (res."targetLabels" != [ ]) { inherit (res) "targetLabels"; }
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
  allResources = (mapAttrsToList mkVMNodeScrape cfg."vmnodescrapes");
in
{
  options.openkrill.apps."victoriametrics" = {
    "vmnodescrapes" = mkOption {
      type = types.attrsOf VmnodescrapesModule;
      default = { };
      description = "VMNodeScrape CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."victoriametrics".content = allResources;
  };
}
