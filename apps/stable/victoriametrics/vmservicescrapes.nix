# Auto-generated openkrill module fragment for victoriametrics
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."victoriametrics";
  compact = filterAttrs (_: v: v != null);
  Attach_metadataModule = types.submodule {
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
  mkAttach_metadata =
    res:
    {
    }
    // optionalAttrs res."namespace" { inherit (res) "namespace"; }
    // {
    }
    // optionalAttrs res."node" { inherit (res) "node"; }
    // {
    };
  EndpointAttach_metadataModule = types.submodule {
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
  mkEndpointAttach_metadata =
    res:
    {
    }
    // optionalAttrs res."namespace" { inherit (res) "namespace"; }
    // {
    }
    // optionalAttrs res."node" { inherit (res) "node"; }
    // {
    };
  EndpointAuthorizationCredentialsModule = types.submodule {
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
  mkEndpointAuthorizationCredentials =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EndpointAuthorizationModule = types.submodule {
    options = {
      "credentials" = mkOption {
        type = (types.nullOr EndpointAuthorizationCredentialsModule);
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
  mkEndpointAuthorization =
    res:
    {
    }
    // optionalAttrs (res."credentials" != null) {
      "credentials" = mkEndpointAuthorizationCredentials res."credentials";
    }
    // {
    }
    // optionalAttrs (res."credentialsFile" != null) { inherit (res) "credentialsFile"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  EndpointBasicAuthModule = types.submodule {
    options = {
      "password" = mkOption {
        type = (types.nullOr EndpointBasicAuthPasswordModule);
        default = null;
      };
      "password_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
        type = (types.nullOr EndpointBasicAuthUsernameModule);
        default = null;
      };
    };
  };
  mkEndpointBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkEndpointBasicAuthPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."password_file" != null) { inherit (res) "password_file"; }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkEndpointBasicAuthUsername res."username";
    }
    // {
    };
  EndpointBasicAuthPasswordModule = types.submodule {
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
  mkEndpointBasicAuthPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EndpointBasicAuthUsernameModule = types.submodule {
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
  mkEndpointBasicAuthUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EndpointBearerTokenSecretModule = types.submodule {
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
  mkEndpointBearerTokenSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EndpointMetricRelabelConfigModule = types.submodule {
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
  mkEndpointMetricRelabelConfig =
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
  EndpointModule = types.submodule {
    options = {
      "attach_metadata" = mkOption {
        type = (types.nullOr EndpointAttach_metadataModule);
        default = null;
      };
      "authorization" = mkOption {
        type = (types.nullOr EndpointAuthorizationModule);
        default = null;
      };
      "basicAuth" = mkOption {
        type = (types.nullOr EndpointBasicAuthModule);
        default = null;
      };
      "bearerTokenFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "bearerTokenSecret" = mkOption {
        type = (types.nullOr EndpointBearerTokenSecretModule);
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
      "max_scrape_size" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "metricRelabelConfigs" = mkOption {
        type = (types.listOf EndpointMetricRelabelConfigModule);
        default = [ ];
      };
      "oauth2" = mkOption {
        type = (types.nullOr EndpointOauth2Module);
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
        type = (types.listOf EndpointRelabelConfigModule);
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
      "targetPort" = mkOption {
        type = types.anything;
        default = { };
      };
      "tlsConfig" = mkOption {
        type = (types.nullOr EndpointTlsConfigModule);
        default = null;
      };
      "vm_scrape_params" = mkOption {
        type = (types.nullOr EndpointVm_scrape_paramsModule);
        default = null;
      };
    };
  };
  mkEndpoint =
    res:
    {
    }
    // optionalAttrs (res."attach_metadata" != null) {
      "attach_metadata" = mkEndpointAttach_metadata res."attach_metadata";
    }
    // {
    }
    // optionalAttrs (res."authorization" != null) {
      "authorization" = mkEndpointAuthorization res."authorization";
    }
    // {
    }
    // optionalAttrs (res."basicAuth" != null) { "basicAuth" = mkEndpointBasicAuth res."basicAuth"; }
    // {
    }
    // optionalAttrs (res."bearerTokenFile" != null) { inherit (res) "bearerTokenFile"; }
    // {
    }
    // optionalAttrs (res."bearerTokenSecret" != null) {
      "bearerTokenSecret" = mkEndpointBearerTokenSecret res."bearerTokenSecret";
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
    // optionalAttrs (res."max_scrape_size" != null) { inherit (res) "max_scrape_size"; }
    // {
    }
    // optionalAttrs (res."metricRelabelConfigs" != [ ]) {
      "metricRelabelConfigs" = map mkEndpointMetricRelabelConfig res."metricRelabelConfigs";
    }
    // {
    }
    // optionalAttrs (res."oauth2" != null) { "oauth2" = mkEndpointOauth2 res."oauth2"; }
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
      "relabelConfigs" = map mkEndpointRelabelConfig res."relabelConfigs";
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
    }
    // optionalAttrs (res."targetPort" != null) { inherit (res) "targetPort"; }
    // {
    }
    // optionalAttrs (res."tlsConfig" != null) { "tlsConfig" = mkEndpointTlsConfig res."tlsConfig"; }
    // {
    }
    // optionalAttrs (res."vm_scrape_params" != null) {
      "vm_scrape_params" = mkEndpointVm_scrape_params res."vm_scrape_params";
    }
    // {
    };
  EndpointOauth2Client_idConfigMapModule = types.submodule {
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
  mkEndpointOauth2Client_idConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EndpointOauth2Client_idModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr EndpointOauth2Client_idConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr EndpointOauth2Client_idSecretModule);
        default = null;
      };
    };
  };
  mkEndpointOauth2Client_id =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkEndpointOauth2Client_idConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkEndpointOauth2Client_idSecret res."secret"; }
    // {
    };
  EndpointOauth2Client_idSecretModule = types.submodule {
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
  mkEndpointOauth2Client_idSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EndpointOauth2Client_secretModule = types.submodule {
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
  mkEndpointOauth2Client_secret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EndpointOauth2Module = types.submodule {
    options = {
      "client_id" = mkOption {
        type = EndpointOauth2Client_idModule;
      };
      "client_secret" = mkOption {
        type = (types.nullOr EndpointOauth2Client_secretModule);
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
  mkEndpointOauth2 =
    res:
    {
      "client_id" = mkEndpointOauth2Client_id res."client_id";
    }
    // optionalAttrs (res."client_secret" != null) {
      "client_secret" = mkEndpointOauth2Client_secret res."client_secret";
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
  EndpointRelabelConfigModule = types.submodule {
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
  mkEndpointRelabelConfig =
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
  EndpointTlsConfigCaConfigMapModule = types.submodule {
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
  mkEndpointTlsConfigCaConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EndpointTlsConfigCaModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr EndpointTlsConfigCaConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr EndpointTlsConfigCaSecretModule);
        default = null;
      };
    };
  };
  mkEndpointTlsConfigCa =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkEndpointTlsConfigCaConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkEndpointTlsConfigCaSecret res."secret"; }
    // {
    };
  EndpointTlsConfigCaSecretModule = types.submodule {
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
  mkEndpointTlsConfigCaSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EndpointTlsConfigCertConfigMapModule = types.submodule {
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
  mkEndpointTlsConfigCertConfigMap =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EndpointTlsConfigCertModule = types.submodule {
    options = {
      "configMap" = mkOption {
        type = (types.nullOr EndpointTlsConfigCertConfigMapModule);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr EndpointTlsConfigCertSecretModule);
        default = null;
      };
    };
  };
  mkEndpointTlsConfigCert =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) {
      "configMap" = mkEndpointTlsConfigCertConfigMap res."configMap";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkEndpointTlsConfigCertSecret res."secret"; }
    // {
    };
  EndpointTlsConfigCertSecretModule = types.submodule {
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
  mkEndpointTlsConfigCertSecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EndpointTlsConfigKeySecretModule = types.submodule {
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
  mkEndpointTlsConfigKeySecret =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EndpointTlsConfigModule = types.submodule {
    options = {
      "ca" = mkOption {
        type = (types.nullOr EndpointTlsConfigCaModule);
        default = null;
      };
      "caFile" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "cert" = mkOption {
        type = (types.nullOr EndpointTlsConfigCertModule);
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
        type = (types.nullOr EndpointTlsConfigKeySecretModule);
        default = null;
      };
      "serverName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkEndpointTlsConfig =
    res:
    {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkEndpointTlsConfigCa res."ca"; }
    // {
    }
    // optionalAttrs (res."caFile" != null) { inherit (res) "caFile"; }
    // {
    }
    // optionalAttrs (res."cert" != null) { "cert" = mkEndpointTlsConfigCert res."cert"; }
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
      "keySecret" = mkEndpointTlsConfigKeySecret res."keySecret";
    }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    };
  EndpointVm_scrape_paramsModule = types.submodule {
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
        type = (types.nullOr EndpointVm_scrape_paramsProxy_client_configModule);
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
  mkEndpointVm_scrape_params =
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
      "proxy_client_config" = mkEndpointVm_scrape_paramsProxy_client_config res."proxy_client_config";
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
  EndpointVm_scrape_paramsProxy_client_configBasic_authModule = types.submodule {
    options = {
      "password" = mkOption {
        type = (types.nullOr EndpointVm_scrape_paramsProxy_client_configBasic_authPasswordModule);
        default = null;
      };
      "password_file" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "username" = mkOption {
        type = (types.nullOr EndpointVm_scrape_paramsProxy_client_configBasic_authUsernameModule);
        default = null;
      };
    };
  };
  mkEndpointVm_scrape_paramsProxy_client_configBasic_auth =
    res:
    {
    }
    // optionalAttrs (res."password" != null) {
      "password" = mkEndpointVm_scrape_paramsProxy_client_configBasic_authPassword res."password";
    }
    // {
    }
    // optionalAttrs (res."password_file" != null) { inherit (res) "password_file"; }
    // {
    }
    // optionalAttrs (res."username" != null) {
      "username" = mkEndpointVm_scrape_paramsProxy_client_configBasic_authUsername res."username";
    }
    // {
    };
  EndpointVm_scrape_paramsProxy_client_configBasic_authPasswordModule = types.submodule {
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
  mkEndpointVm_scrape_paramsProxy_client_configBasic_authPassword =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EndpointVm_scrape_paramsProxy_client_configBasic_authUsernameModule = types.submodule {
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
  mkEndpointVm_scrape_paramsProxy_client_configBasic_authUsername =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EndpointVm_scrape_paramsProxy_client_configBearer_tokenModule = types.submodule {
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
  mkEndpointVm_scrape_paramsProxy_client_configBearer_token =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  EndpointVm_scrape_paramsProxy_client_configModule = types.submodule {
    options = {
      "basic_auth" = mkOption {
        type = (types.nullOr EndpointVm_scrape_paramsProxy_client_configBasic_authModule);
        default = null;
      };
      "bearer_token" = mkOption {
        type = (types.nullOr EndpointVm_scrape_paramsProxy_client_configBearer_tokenModule);
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
  mkEndpointVm_scrape_paramsProxy_client_config =
    res:
    {
    }
    // optionalAttrs (res."basic_auth" != null) {
      "basic_auth" = mkEndpointVm_scrape_paramsProxy_client_configBasic_auth res."basic_auth";
    }
    // {
    }
    // optionalAttrs (res."bearer_token" != null) {
      "bearer_token" = mkEndpointVm_scrape_paramsProxy_client_configBearer_token res."bearer_token";
    }
    // {
    }
    // optionalAttrs (res."bearer_token_file" != null) { inherit (res) "bearer_token_file"; }
    // {
    }
    // optionalAttrs (res."tls_config" != null) { inherit (res) "tls_config"; }
    // {
    };
  NamespaceSelectorModule = types.submodule {
    options = {
      "any" = mkOption {
        type = types.bool;
        default = false;
      };
      "matchNames" = mkOption {
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
  VmservicescrapesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this VMServiceScrape resource.";
        };
        "attach_metadata" = mkOption {
          type = (types.nullOr Attach_metadataModule);
          default = null;
        };
        "discoveryRole" = mkOption {
          type = (
            types.nullOr (
              types.enum [
                "endpoints"
                "service"
                "endpointslices"
                "endpointslice"
              ]
            )
          );
          default = null;
        };
        "endpoints" = mkOption {
          type = (types.listOf EndpointModule);
        };
        "jobLabel" = mkOption {
          type = (types.nullOr types.str);
          default = null;
        };
        "namespaceSelector" = mkOption {
          type = (types.nullOr NamespaceSelectorModule);
          default = null;
        };
        "podTargetLabels" = mkOption {
          type = (types.listOf types.str);
          default = [ ];
        };
        "sampleLimit" = mkOption {
          type = (types.nullOr types.int);
          default = null;
        };
        "scrapeClass" = mkOption {
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
      };
    }
  );
  mkVMServiceScrape = name: res: {
    apiVersion = "operator.victoriametrics.com/v1beta1";
    kind = "VMServiceScrape";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."attach_metadata" != null) {
      "attach_metadata" = mkAttach_metadata res."attach_metadata";
    }
    // {
    }
    // optionalAttrs (res."discoveryRole" != null) { inherit (res) "discoveryRole"; }
    // {
      "endpoints" = map mkEndpoint res."endpoints";
    }
    // optionalAttrs (res."jobLabel" != null) { inherit (res) "jobLabel"; }
    // {
    }
    // optionalAttrs (res."namespaceSelector" != null) {
      "namespaceSelector" = mkNamespaceSelector res."namespaceSelector";
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
    // optionalAttrs (res."selector" != null) { "selector" = mkSelector res."selector"; }
    // {
    }
    // optionalAttrs (res."seriesLimit" != null) { inherit (res) "seriesLimit"; }
    // {
    }
    // optionalAttrs (res."targetLabels" != [ ]) { inherit (res) "targetLabels"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkVMServiceScrape cfg."vmservicescrapes");
in
{
  options.openkrill.apps."victoriametrics" = {
    "vmservicescrapes" = mkOption {
      type = types.attrsOf VmservicescrapesModule;
      default = { };
      description = "VMServiceScrape CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."victoriametrics".content = allResources;
  };
}
