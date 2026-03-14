# Auto-generated openkrill module fragment for victoriametrics
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."victoriametrics";
  compact = filterAttrs (_: v: v != null);
  TargetEndpointAuthorizationCredentialsModule = types.submodule {
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
  mkTargetEndpointAuthorizationCredentials =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TargetEndpointAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        type = (types.nullOr TargetEndpointAuthorizationCredentialsModule);
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
  mkTargetEndpointAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkTargetEndpointAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."credentialsFile" != null) { inherit (res) "credentialsFile"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  TargetEndpointBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        type = (types.nullOr TargetEndpointBasicAuthPasswordModule);
        default = null;
      };
      "password_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
        type = (types.nullOr TargetEndpointBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkTargetEndpointBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkTargetEndpointBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."password_file" != null) { inherit (res) "password_file"; }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkTargetEndpointBasicAuthUsername res."username";
    }
    // {
    };
  TargetEndpointBasicAuthPasswordModule = types.submodule {
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
  mkTargetEndpointBasicAuthPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TargetEndpointBasicAuthUsernameModule = types.submodule {
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
  mkTargetEndpointBasicAuthUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TargetEndpointBearerTokenSecretModule = types.submodule {
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
  mkTargetEndpointBearerTokenSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TargetEndpointMetricRelabelConfigModule = types.submodule {
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
  mkTargetEndpointMetricRelabelConfig =
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
  TargetEndpointModule = types.submodule {
    options = {
      "authorization" = mkOption {
        type = (types.nullOr TargetEndpointAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        type = (types.nullOr TargetEndpointBasicAuthModule);
        default = null;
      };
      "bearerTokenFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "bearerTokenSecret" = mkOption {
        type = (types.nullOr TargetEndpointBearerTokenSecretModule);
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
      "labels" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "max_scrape_size" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "metricRelabelConfigs" = mkOption {
        type = (types.listOf TargetEndpointMetricRelabelConfigModule);
        default = [ ];
      };
      "oauth2" = mkOption {
        type = (types.nullOr TargetEndpointOauth2Module);
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
      "proxyURL" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "relabelConfigs" = mkOption {
        type = (types.listOf TargetEndpointRelabelConfigModule);
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
      "targets" = mkOption {
        type = (types.listOf types.str);
      };
      "tlsConfig" = mkOption {
        type = (types.nullOr TargetEndpointTlsConfigModule);
        default = null;
      };
      "vm_scrape_params" = mkOption {
        type = (types.nullOr TargetEndpointVm_scrape_paramsModule);
        default = null;
      };
    };
  };
  mkTargetEndpoint =
    res:
    {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkTargetEndpointAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkTargetEndpointBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs (res."bearerTokenFile" != null) { inherit (res) "bearerTokenFile"; }
    // {
    }
    // optionalAttrs (res."bearerTokenSecret" != null) {
      "bearerTokenSecret" = mkTargetEndpointBearerTokenSecret res."bearerTokenSecret";
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
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."max_scrape_size" != null) { inherit (res) "max_scrape_size"; }
    // {
    }
    // optionalAttrs (res."metricRelabelConfigs" != [ ]) {
      "metricRelabelConfigs" = map mkTargetEndpointMetricRelabelConfig res."metricRelabelConfigs";
    }
    // {
    }
    // optionalAttrs (res."oauth2" != null) { "oauth2" = mkTargetEndpointOauth2 res."oauth2"; }
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
      "relabelConfigs" = map mkTargetEndpointRelabelConfig res."relabelConfigs";
    }
    // {
    }
    // optionalAttrs (res."sampleLimit" != null) { inherit (res) "sampleLimit"; }
    // {
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
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
      inherit (res) "targets";
    }
    // optionalAttrs (res."tlsConfig" != null) {
      "tlsConfig" = mkTargetEndpointTlsConfig res."tlsConfig";
    }
    // {
    }
    // optionalAttrs (res."vm_scrape_params" != null) {
      "vm_scrape_params" = mkTargetEndpointVm_scrape_params res."vm_scrape_params";
    }
    // {
    };
  TargetEndpointOauth2Client_idConfigMapModule = types.submodule {
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
  mkTargetEndpointOauth2Client_idConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TargetEndpointOauth2Client_idModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr TargetEndpointOauth2Client_idConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr TargetEndpointOauth2Client_idSecretModule);
        default = null;
      };
    };
  };
  mkTargetEndpointOauth2Client_id =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkTargetEndpointOauth2Client_idConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkTargetEndpointOauth2Client_idSecret res."secret";
    }
    // {
    };
  TargetEndpointOauth2Client_idSecretModule = types.submodule {
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
  mkTargetEndpointOauth2Client_idSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TargetEndpointOauth2Client_secretModule = types.submodule {
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
  mkTargetEndpointOauth2Client_secret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TargetEndpointOauth2Module = types.submodule {
    options = {
      "client_id" = mkOption {
        type = TargetEndpointOauth2Client_idModule;
      };
      "client_secret" = mkOption {
        type = (types.nullOr TargetEndpointOauth2Client_secretModule);
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
  mkTargetEndpointOauth2 =
    res:
    {
      "client_id" = mkTargetEndpointOauth2Client_id res."client_id";
    }
    // optionalAttrs (res."client_secret" != null) {
      "client_secret" = mkTargetEndpointOauth2Client_secret res."client_secret";
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
  TargetEndpointRelabelConfigModule = types.submodule {
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
  mkTargetEndpointRelabelConfig =
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
  TargetEndpointTlsConfigCaConfigMapModule = types.submodule {
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
  mkTargetEndpointTlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TargetEndpointTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr TargetEndpointTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr TargetEndpointTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkTargetEndpointTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkTargetEndpointTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkTargetEndpointTlsConfigCaSecret res."secret";
    }
    // {
    };
  TargetEndpointTlsConfigCaSecretModule = types.submodule {
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
  mkTargetEndpointTlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TargetEndpointTlsConfigCertConfigMapModule = types.submodule {
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
  mkTargetEndpointTlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TargetEndpointTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr TargetEndpointTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr TargetEndpointTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkTargetEndpointTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkTargetEndpointTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) {
      "secret" = mkTargetEndpointTlsConfigCertSecret res."secret";
    }
    // {
    };
  TargetEndpointTlsConfigCertSecretModule = types.submodule {
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
  mkTargetEndpointTlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TargetEndpointTlsConfigKeySecretModule = types.submodule {
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
  mkTargetEndpointTlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TargetEndpointTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        type = (types.nullOr TargetEndpointTlsConfigCaModule);
        default = null;
      };
      "caFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "cert" = mkOption {
        type = (types.nullOr TargetEndpointTlsConfigCertModule);
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
        type = (types.nullOr TargetEndpointTlsConfigKeySecretModule);
        default = null;
      };
      "serverName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTargetEndpointTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkTargetEndpointTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."caFile" != null) { inherit (res) "caFile"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkTargetEndpointTlsConfigCert res."cert"; }
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
      "keySecret" = mkTargetEndpointTlsConfigKeySecret res."keySecret";
    }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    };
  TargetEndpointVm_scrape_paramsModule = types.submodule {
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
        type = (types.nullOr TargetEndpointVm_scrape_paramsProxy_client_configModule);
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
  mkTargetEndpointVm_scrape_params =
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
      "proxy_client_config" =
        mkTargetEndpointVm_scrape_paramsProxy_client_config
          res."proxy_client_config";
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
  TargetEndpointVm_scrape_paramsProxy_client_configBasic_authModule = types.submodule {
    options = {
      "password" = mkOption {
        type = (types.nullOr TargetEndpointVm_scrape_paramsProxy_client_configBasic_authPasswordModule);
        default = null;
      };
      "password_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
        type = (types.nullOr TargetEndpointVm_scrape_paramsProxy_client_configBasic_authUsernameModule);
        default = null;
      };
    };
  };
  mkTargetEndpointVm_scrape_paramsProxy_client_configBasic_auth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkTargetEndpointVm_scrape_paramsProxy_client_configBasic_authPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."password_file" != null) { inherit (res) "password_file"; }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkTargetEndpointVm_scrape_paramsProxy_client_configBasic_authUsername res."username";
    }
    // {
    };
  TargetEndpointVm_scrape_paramsProxy_client_configBasic_authPasswordModule = types.submodule {
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
  mkTargetEndpointVm_scrape_paramsProxy_client_configBasic_authPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TargetEndpointVm_scrape_paramsProxy_client_configBasic_authUsernameModule = types.submodule {
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
  mkTargetEndpointVm_scrape_paramsProxy_client_configBasic_authUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TargetEndpointVm_scrape_paramsProxy_client_configBearer_tokenModule = types.submodule {
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
  mkTargetEndpointVm_scrape_paramsProxy_client_configBearer_token =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  TargetEndpointVm_scrape_paramsProxy_client_configModule = types.submodule {
    options = {
      "basic_auth" = mkOption {
        type = (types.nullOr TargetEndpointVm_scrape_paramsProxy_client_configBasic_authModule);
        default = null;
      };
      "bearer_token" = mkOption {
        type = (types.nullOr TargetEndpointVm_scrape_paramsProxy_client_configBearer_tokenModule);
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
  mkTargetEndpointVm_scrape_paramsProxy_client_config =
    res:
    {
    }
    // optionalAttrs (res."basic_auth" != null) {
      "basic_auth" = mkTargetEndpointVm_scrape_paramsProxy_client_configBasic_auth res."basic_auth";
    }
    // {
    }
    // optionalAttrs (res."bearer_token" != null) {
      "bearer_token" = mkTargetEndpointVm_scrape_paramsProxy_client_configBearer_token res."bearer_token";
    }
    // {
    }
    // optionalAttrs (res."bearer_token_file" != null) { inherit (res) "bearer_token_file"; }
    // {
    }
    // optionalAttrs (res."tls_config" != null) { inherit (res) "tls_config"; }
    // {
    };
  VmstaticscrapesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this VMStaticScrape resource.";
        };
        "jobName" = mkOption {
          type = (types.nullOr types.str);
          default = null;
        };
        "sampleLimit" = mkOption {
          type = (types.nullOr types.int);
          default = null;
        };
        "scrapeClass" = mkOption {
          type = (types.nullOr types.str);
          default = null;
        };
        "seriesLimit" = mkOption {
          type = (types.nullOr types.int);
          default = null;
        };
        "targetEndpoints" = mkOption {
          type = (types.listOf TargetEndpointModule);
        };
      };
    }
  );
  mkVMStaticScrape = name: res: {
    apiVersion = "operator.victoriametrics.com/v1beta1";
    kind = "VMStaticScrape";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."jobName" != null) { inherit (res) "jobName"; }
    // {
    }
    // optionalAttrs (res."sampleLimit" != null) { inherit (res) "sampleLimit"; }
    // {
    }
    // optionalAttrs (res."scrapeClass" != null) { inherit (res) "scrapeClass"; }
    // {
    }
    // optionalAttrs (res."seriesLimit" != null) { inherit (res) "seriesLimit"; }
    // {
      "targetEndpoints" = map mkTargetEndpoint res."targetEndpoints";
    };
  };
  allResources = (mapAttrsToList mkVMStaticScrape cfg."vmstaticscrapes");
in
{
  options.openkrill.apps."victoriametrics" = {
    "vmstaticscrapes" = mkOption {
      type = types.attrsOf VmstaticscrapesModule;
      default = { };
      description = "VMStaticScrape CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."victoriametrics".content = allResources;
  };
}
