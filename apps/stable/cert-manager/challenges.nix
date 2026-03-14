# Auto-generated openkrill module fragment for cert-manager
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."cert-manager";
  compact = filterAttrs (_: v: v != null);
  IssuerRefModule = types.submodule {
    options = {
      "group" = mkOption {
        description = "Group of the resource being referred to.";
        type = (types.nullOr types.str);
        default = null;
      };
      "kind" = mkOption {
        description = "Kind of the resource being referred to.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the resource being referred to.";
        type = types.str;
      };
    };
  };
  mkIssuerRef =
    res:
    {
    }
    // optionalAttrs (res."group" != null) { inherit (res) "group"; }
    // {
    }
    // optionalAttrs (res."kind" != null) { inherit (res) "kind"; }
    // {
      inherit (res) "name";
    };
  SolverDns01AcmeDNSAccountSecretRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = types.str;
      };
    };
  };
  mkSolverDns01AcmeDNSAccountSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  SolverDns01AcmeDNSModule = types.submodule {
    options = {
      "accountSecretRef" = mkOption {
        description = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field.";
        type = SolverDns01AcmeDNSAccountSecretRefModule;
      };
      "host" = mkOption {
        type = types.str;
      };
    };
  };
  mkSolverDns01AcmeDNS = res: {
    "accountSecretRef" = mkSolverDns01AcmeDNSAccountSecretRef res."accountSecretRef";
    inherit (res) "host";
  };
  SolverDns01AkamaiAccessTokenSecretRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = types.str;
      };
    };
  };
  mkSolverDns01AkamaiAccessTokenSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  SolverDns01AkamaiClientSecretSecretRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = types.str;
      };
    };
  };
  mkSolverDns01AkamaiClientSecretSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  SolverDns01AkamaiClientTokenSecretRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = types.str;
      };
    };
  };
  mkSolverDns01AkamaiClientTokenSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  SolverDns01AkamaiModule = types.submodule {
    options = {
      "accessTokenSecretRef" = mkOption {
        description = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field.";
        type = SolverDns01AkamaiAccessTokenSecretRefModule;
      };
      "clientSecretSecretRef" = mkOption {
        description = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field.";
        type = SolverDns01AkamaiClientSecretSecretRefModule;
      };
      "clientTokenSecretRef" = mkOption {
        description = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field.";
        type = SolverDns01AkamaiClientTokenSecretRefModule;
      };
      "serviceConsumerDomain" = mkOption {
        type = types.str;
      };
    };
  };
  mkSolverDns01Akamai = res: {
    "accessTokenSecretRef" = mkSolverDns01AkamaiAccessTokenSecretRef res."accessTokenSecretRef";
    "clientSecretSecretRef" = mkSolverDns01AkamaiClientSecretSecretRef res."clientSecretSecretRef";
    "clientTokenSecretRef" = mkSolverDns01AkamaiClientTokenSecretRef res."clientTokenSecretRef";
    inherit (res) "serviceConsumerDomain";
  };
  SolverDns01AzureDNSClientSecretSecretRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = types.str;
      };
    };
  };
  mkSolverDns01AzureDNSClientSecretSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  SolverDns01AzureDNSManagedIdentityModule = types.submodule {
    options = {
      "clientID" = mkOption {
        description = "client ID of the managed identity, can not be used at the same time as resourceID";
        type = (types.nullOr types.str);
        default = null;
      };
      "resourceID" = mkOption {
        description = "resource ID of the managed identity, can not be used at the same time as clientID";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSolverDns01AzureDNSManagedIdentity =
    res:
    {
    }
    // optionalAttrs (res."clientID" != null) { inherit (res) "clientID"; }
    // {
    }
    // optionalAttrs (res."resourceID" != null) { inherit (res) "resourceID"; }
    // {
    };
  SolverDns01AzureDNSModule = types.submodule {
    options = {
      "clientID" = mkOption {
        description = "if both this and ClientSecret are left unset MSI will be used";
        type = (types.nullOr types.str);
        default = null;
      };
      "clientSecretSecretRef" = mkOption {
        description = "if both this and ClientID are left unset MSI will be used";
        type = (types.nullOr SolverDns01AzureDNSClientSecretSecretRefModule);
        default = null;
      };
      "environment" = mkOption {
        description = "name of the Azure environment (default AzurePublicCloud)";
        type = (
          types.nullOr (
            types.enum [
              "AzurePublicCloud"
              "AzureChinaCloud"
              "AzureGermanCloud"
              "AzureUSGovernmentCloud"
            ]
          )
        );
        default = null;
      };
      "hostedZoneName" = mkOption {
        description = "name of the DNS zone that should be used";
        type = (types.nullOr types.str);
        default = null;
      };
      "managedIdentity" = mkOption {
        description = "managed identity configuration, can not be used at the same time as clientID, clientSecretSecretRef or tenantID";
        type = (types.nullOr SolverDns01AzureDNSManagedIdentityModule);
        default = null;
      };
      "resourceGroupName" = mkOption {
        description = "resource group the DNS zone is located in";
        type = types.str;
      };
      "subscriptionID" = mkOption {
        description = "ID of the Azure subscription";
        type = types.str;
      };
      "tenantID" = mkOption {
        description = "when specifying ClientID and ClientSecret then this field is also needed";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSolverDns01AzureDNS =
    res:
    {
    }
    // optionalAttrs (res."clientID" != null) { inherit (res) "clientID"; }
    // {
    }
    // optionalAttrs (res."clientSecretSecretRef" != null) {
      "clientSecretSecretRef" = mkSolverDns01AzureDNSClientSecretSecretRef res."clientSecretSecretRef";
    }
    // {
    }
    // optionalAttrs (res."environment" != null) { inherit (res) "environment"; }
    // {
    }
    // optionalAttrs (res."hostedZoneName" != null) { inherit (res) "hostedZoneName"; }
    // {
    }
    // optionalAttrs (res."managedIdentity" != null) {
      "managedIdentity" = mkSolverDns01AzureDNSManagedIdentity res."managedIdentity";
    }
    // {
      inherit (res) "resourceGroupName";
      inherit (res) "subscriptionID";
    }
    // optionalAttrs (res."tenantID" != null) { inherit (res) "tenantID"; }
    // {
    };
  SolverDns01CloudDNSModule = types.submodule {
    options = {
      "hostedZoneName" = mkOption {
        description = "HostedZoneName is an optional field that tells cert-manager in which Cloud DNS zone the challenge record has to be created. If left empty cert-manager will automatically choose a zone.";
        type = (types.nullOr types.str);
        default = null;
      };
      "project" = mkOption {
        type = types.str;
      };
      "serviceAccountSecretRef" = mkOption {
        description = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field.";
        type = (types.nullOr SolverDns01CloudDNSServiceAccountSecretRefModule);
        default = null;
      };
    };
  };
  mkSolverDns01CloudDNS =
    res:
    {
    }
    // optionalAttrs (res."hostedZoneName" != null) { inherit (res) "hostedZoneName"; }
    // {
      inherit (res) "project";
    }
    // optionalAttrs (res."serviceAccountSecretRef" != null) {
      "serviceAccountSecretRef" =
        mkSolverDns01CloudDNSServiceAccountSecretRef
          res."serviceAccountSecretRef";
    }
    // {
    };
  SolverDns01CloudDNSServiceAccountSecretRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = types.str;
      };
    };
  };
  mkSolverDns01CloudDNSServiceAccountSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  SolverDns01CloudflareApiKeySecretRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = types.str;
      };
    };
  };
  mkSolverDns01CloudflareApiKeySecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  SolverDns01CloudflareApiTokenSecretRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = types.str;
      };
    };
  };
  mkSolverDns01CloudflareApiTokenSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  SolverDns01CloudflareModule = types.submodule {
    options = {
      "apiKeySecretRef" = mkOption {
        description = "API key to use to authenticate with Cloudflare. Note: using an API token to authenticate is now the recommended method as it allows greater control of permissions.";
        type = (types.nullOr SolverDns01CloudflareApiKeySecretRefModule);
        default = null;
      };
      "apiTokenSecretRef" = mkOption {
        description = "API token used to authenticate with Cloudflare.";
        type = (types.nullOr SolverDns01CloudflareApiTokenSecretRefModule);
        default = null;
      };
      "email" = mkOption {
        description = "Email of the account, only required when using API key based authentication.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSolverDns01Cloudflare =
    res:
    {
    }
    // optionalAttrs (res."apiKeySecretRef" != null) {
      "apiKeySecretRef" = mkSolverDns01CloudflareApiKeySecretRef res."apiKeySecretRef";
    }
    // {
    }
    // optionalAttrs (res."apiTokenSecretRef" != null) {
      "apiTokenSecretRef" = mkSolverDns01CloudflareApiTokenSecretRef res."apiTokenSecretRef";
    }
    // {
    }
    // optionalAttrs (res."email" != null) { inherit (res) "email"; }
    // {
    };
  SolverDns01DigitaloceanModule = types.submodule {
    options = {
      "tokenSecretRef" = mkOption {
        description = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field.";
        type = SolverDns01DigitaloceanTokenSecretRefModule;
      };
    };
  };
  mkSolverDns01Digitalocean = res: {
    "tokenSecretRef" = mkSolverDns01DigitaloceanTokenSecretRef res."tokenSecretRef";
  };
  SolverDns01DigitaloceanTokenSecretRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = types.str;
      };
    };
  };
  mkSolverDns01DigitaloceanTokenSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  SolverDns01Module = types.submodule {
    options = {
      "acmeDNS" = mkOption {
        description = "Use the 'ACME DNS' (https://github.com/joohoi/acme-dns) API to manage DNS01 challenge records.";
        type = (types.nullOr SolverDns01AcmeDNSModule);
        default = null;
      };
      "akamai" = mkOption {
        description = "Use the Akamai DNS zone management API to manage DNS01 challenge records.";
        type = (types.nullOr SolverDns01AkamaiModule);
        default = null;
      };
      "azureDNS" = mkOption {
        description = "Use the Microsoft Azure DNS API to manage DNS01 challenge records.";
        type = (types.nullOr SolverDns01AzureDNSModule);
        default = null;
      };
      "cloudDNS" = mkOption {
        description = "Use the Google Cloud DNS API to manage DNS01 challenge records.";
        type = (types.nullOr SolverDns01CloudDNSModule);
        default = null;
      };
      "cloudflare" = mkOption {
        description = "Use the Cloudflare API to manage DNS01 challenge records.";
        type = (types.nullOr SolverDns01CloudflareModule);
        default = null;
      };
      "cnameStrategy" = mkOption {
        description = "CNAMEStrategy configures how the DNS01 provider should handle CNAME records when found in DNS zones.";
        type = (
          types.nullOr (
            types.enum [
              "None"
              "Follow"
            ]
          )
        );
        default = null;
      };
      "digitalocean" = mkOption {
        description = "Use the DigitalOcean DNS API to manage DNS01 challenge records.";
        type = (types.nullOr SolverDns01DigitaloceanModule);
        default = null;
      };
      "rfc2136" = mkOption {
        description = "Use RFC2136 (\"Dynamic Updates in the Domain Name System\") (https://datatracker.ietf.org/doc/rfc2136/) to manage DNS01 challenge records.";
        type = (types.nullOr SolverDns01Rfc2136Module);
        default = null;
      };
      "route53" = mkOption {
        description = "Use the AWS Route53 API to manage DNS01 challenge records.";
        type = (types.nullOr SolverDns01Route53Module);
        default = null;
      };
      "webhook" = mkOption {
        description = "Configure an external webhook based DNS01 challenge solver to manage DNS01 challenge records.";
        type = (types.nullOr SolverDns01WebhookModule);
        default = null;
      };
    };
  };
  mkSolverDns01 =
    res:
    {
    }
    // optionalAttrs (res."acmeDNS" != null) { "acmeDNS" = mkSolverDns01AcmeDNS res."acmeDNS"; }
    // {
    }
    // optionalAttrs (res."akamai" != null) { "akamai" = mkSolverDns01Akamai res."akamai"; }
    // {
    }
    // optionalAttrs (res."azureDNS" != null) { "azureDNS" = mkSolverDns01AzureDNS res."azureDNS"; }
    // {
    }
    // optionalAttrs (res."cloudDNS" != null) { "cloudDNS" = mkSolverDns01CloudDNS res."cloudDNS"; }
    // {
    }
    // optionalAttrs (res."cloudflare" != null) {
      "cloudflare" = mkSolverDns01Cloudflare res."cloudflare";
    }
    // {
    }
    // optionalAttrs (res."cnameStrategy" != null) { inherit (res) "cnameStrategy"; }
    // {
    }
    // optionalAttrs (res."digitalocean" != null) {
      "digitalocean" = mkSolverDns01Digitalocean res."digitalocean";
    }
    // {
    }
    // optionalAttrs (res."rfc2136" != null) { "rfc2136" = mkSolverDns01Rfc2136 res."rfc2136"; }
    // {
    }
    // optionalAttrs (res."route53" != null) { "route53" = mkSolverDns01Route53 res."route53"; }
    // {
    }
    // optionalAttrs (res."webhook" != null) { "webhook" = mkSolverDns01Webhook res."webhook"; }
    // {
    };
  SolverDns01Rfc2136Module = types.submodule {
    options = {
      "nameserver" = mkOption {
        description = "The IP address or hostname of an authoritative DNS server supporting RFC2136 in the form host:port. If the host is an IPv6 address it must be enclosed in square brackets (e.g [2001:db8::1]) ; port is optional. This field is required.";
        type = types.str;
      };
      "tsigAlgorithm" = mkOption {
        description = "The TSIG Algorithm configured in the DNS supporting RFC2136. Used only when ``tsigSecretSecretRef`` and ``tsigKeyName`` are defined. Supported values are (case-insensitive): ``HMACMD5`` (default), ``HMACSHA1``, ``HMACSHA256`` or ``HMACSHA512``.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tsigKeyName" = mkOption {
        description = "The TSIG Key name configured in the DNS. If ``tsigSecretSecretRef`` is defined, this field is required.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tsigSecretSecretRef" = mkOption {
        description = "The name of the secret containing the TSIG value. If ``tsigKeyName`` is defined, this field is required.";
        type = (types.nullOr SolverDns01Rfc2136TsigSecretSecretRefModule);
        default = null;
      };
    };
  };
  mkSolverDns01Rfc2136 =
    res:
    {
      inherit (res) "nameserver";
    }
    // optionalAttrs (res."tsigAlgorithm" != null) { inherit (res) "tsigAlgorithm"; }
    // {
    }
    // optionalAttrs (res."tsigKeyName" != null) { inherit (res) "tsigKeyName"; }
    // {
    }
    // optionalAttrs (res."tsigSecretSecretRef" != null) {
      "tsigSecretSecretRef" = mkSolverDns01Rfc2136TsigSecretSecretRef res."tsigSecretSecretRef";
    }
    // {
    };
  SolverDns01Rfc2136TsigSecretSecretRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = types.str;
      };
    };
  };
  mkSolverDns01Rfc2136TsigSecretSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  SolverDns01Route53AccessKeyIDSecretRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = types.str;
      };
    };
  };
  mkSolverDns01Route53AccessKeyIDSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  SolverDns01Route53Module = types.submodule {
    options = {
      "accessKeyID" = mkOption {
        description = "The AccessKeyID is used for authentication. Cannot be set when SecretAccessKeyID is set. If neither the Access Key nor Key ID are set, we fall-back to using env vars, shared credentials file or AWS Instance metadata, see: https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials";
        type = (types.nullOr types.str);
        default = null;
      };
      "accessKeyIDSecretRef" = mkOption {
        description = "The SecretAccessKey is used for authentication. If set, pull the AWS access key ID from a key within a Kubernetes Secret. Cannot be set when AccessKeyID is set. If neither the Access Key nor Key ID are set, we fall-back to using env vars, shared credentials file or AWS Instance metadata, see: https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials";
        type = (types.nullOr SolverDns01Route53AccessKeyIDSecretRefModule);
        default = null;
      };
      "hostedZoneID" = mkOption {
        description = "If set, the provider will manage only this zone in Route53 and will not do an lookup using the route53:ListHostedZonesByName api call.";
        type = (types.nullOr types.str);
        default = null;
      };
      "region" = mkOption {
        description = "Always set the region when using AccessKeyID and SecretAccessKey";
        type = types.str;
      };
      "role" = mkOption {
        description = "Role is a Role ARN which the Route53 provider will assume using either the explicit credentials AccessKeyID/SecretAccessKey or the inferred credentials from environment variables, shared credentials file or AWS Instance metadata";
        type = (types.nullOr types.str);
        default = null;
      };
      "secretAccessKeySecretRef" = mkOption {
        description = "The SecretAccessKey is used for authentication. If neither the Access Key nor Key ID are set, we fall-back to using env vars, shared credentials file or AWS Instance metadata, see: https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials";
        type = (types.nullOr SolverDns01Route53SecretAccessKeySecretRefModule);
        default = null;
      };
    };
  };
  mkSolverDns01Route53 =
    res:
    {
    }
    // optionalAttrs (res."accessKeyID" != null) { inherit (res) "accessKeyID"; }
    // {
    }
    // optionalAttrs (res."accessKeyIDSecretRef" != null) {
      "accessKeyIDSecretRef" = mkSolverDns01Route53AccessKeyIDSecretRef res."accessKeyIDSecretRef";
    }
    // {
    }
    // optionalAttrs (res."hostedZoneID" != null) { inherit (res) "hostedZoneID"; }
    // {
      inherit (res) "region";
    }
    // optionalAttrs (res."role" != null) { inherit (res) "role"; }
    // {
    }
    // optionalAttrs (res."secretAccessKeySecretRef" != null) {
      "secretAccessKeySecretRef" =
        mkSolverDns01Route53SecretAccessKeySecretRef
          res."secretAccessKeySecretRef";
    }
    // {
    };
  SolverDns01Route53SecretAccessKeySecretRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key of the entry in the Secret resource's `data` field to be used. Some instances of this field may be defaulted, in others it may be required.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = types.str;
      };
    };
  };
  mkSolverDns01Route53SecretAccessKeySecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  SolverDns01WebhookModule = types.submodule {
    options = {
      "config" = mkOption {
        description = "Additional configuration that should be passed to the webhook apiserver when challenges are processed. This can contain arbitrary JSON data. Secret values should not be specified in this stanza. If secret values are needed (e.g. credentials for a DNS service), you should use a SecretKeySelector to reference a Secret resource. For details on the schema of this field, consult the webhook provider implementation's documentation.";
        type = (types.nullOr types.anything);
        default = null;
      };
      "groupName" = mkOption {
        description = "The API group name that should be used when POSTing ChallengePayload resources to the webhook apiserver. This should be the same as the GroupName specified in the webhook provider implementation.";
        type = types.str;
      };
      "solverName" = mkOption {
        description = "The name of the solver to use, as defined in the webhook provider implementation. This will typically be the name of the provider, e.g. 'cloudflare'.";
        type = types.str;
      };
    };
  };
  mkSolverDns01Webhook =
    res:
    {
    }
    // optionalAttrs (res."config" != null) { inherit (res) "config"; }
    // {
      inherit (res) "groupName";
      inherit (res) "solverName";
    };
  SolverHttp01GatewayHTTPRouteModule = types.submodule {
    options = {
      "labels" = mkOption {
        description = "Custom labels that will be applied to HTTPRoutes created by cert-manager while solving HTTP-01 challenges.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "parentRefs" = mkOption {
        description = "When solving an HTTP-01 challenge, cert-manager creates an HTTPRoute. cert-manager needs to know which parentRefs should be used when creating the HTTPRoute. Usually, the parentRef references a Gateway. See: https://gateway-api.sigs.k8s.io/api-types/httproute/#attaching-to-gateways";
        type = (types.listOf SolverHttp01GatewayHTTPRouteParentRefModule);
        default = [ ];
      };
      "serviceType" = mkOption {
        description = "Optional service type for Kubernetes solver service. Supported values are NodePort or ClusterIP. If unset, defaults to NodePort.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSolverHttp01GatewayHTTPRoute =
    res:
    {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."parentRefs" != [ ]) {
      "parentRefs" = map mkSolverHttp01GatewayHTTPRouteParentRef res."parentRefs";
    }
    // {
    }
    // optionalAttrs (res."serviceType" != null) { inherit (res) "serviceType"; }
    // {
    };
  SolverHttp01GatewayHTTPRouteParentRefModule = types.submodule {
    options = {
      "group" = mkOption {
        description = "Group is the group of the referent. When unspecified, \"gateway.networking.k8s.io\" is inferred. To set the core API group (such as for a \"Service\" kind referent), Group must be explicitly set to \"\" (empty string). \n Support: Core";
        type = (types.nullOr types.str);
        default = "gateway.networking.k8s.io";
      };
      "kind" = mkOption {
        description = "Kind is kind of the referent. \n Support: Core (Gateway) \n Support: Implementation-specific (Other Resources)";
        type = (types.nullOr types.str);
        default = "Gateway";
      };
      "name" = mkOption {
        description = "Name is the name of the referent. \n Support: Core";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "Namespace is the namespace of the referent. When unspecified, this refers to the local namespace of the Route. \n Note that there are specific rules for ParentRefs which cross namespace boundaries. Cross-namespace references are only valid if they are explicitly allowed by something in the namespace they are referring to. For example: Gateway has the AllowedRoutes field, and ReferenceGrant provides a generic way to enable any other kind of cross-namespace reference. \n Support: Core";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Port is the network port this Route targets. It can be interpreted differently based on the type of parent resource. \n When the parent resource is a Gateway, this targets all listeners listening on the specified port that also support this kind of Route(and select this Route). It's not recommended to set `Port` unless the networking behaviors specified in a Route must apply to a specific port as opposed to a listener(s) whose port(s) may be changed. When both Port and SectionName are specified, the name and port of the selected listener must match both specified values. \n Implementations MAY choose to support other parent resources. Implementations supporting other types of parent resources MUST clearly document how/if Port is interpreted. \n For the purpose of status, an attachment is considered successful as long as the parent resource accepts it partially. For example, Gateway listeners can restrict which Routes can attach to them by Route kind, namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from the referencing Route, the Route MUST be considered successfully attached. If no Gateway listeners accept attachment from this Route, the Route MUST be considered detached from the Gateway. \n Support: Extended \n <gateway:experimental>";
        type = (types.nullOr types.int);
        default = null;
      };
      "sectionName" = mkOption {
        description = "SectionName is the name of a section within the target resource. In the following resources, SectionName is interpreted as the following: \n * Gateway: Listener Name. When both Port (experimental) and SectionName are specified, the name and port of the selected listener must match both specified values. \n Implementations MAY choose to support attaching Routes to other resources. If that is the case, they MUST clearly document how SectionName is interpreted. \n When unspecified (empty string), this will reference the entire resource. For the purpose of status, an attachment is considered successful if at least one section in the parent resource accepts it. For example, Gateway listeners can restrict which Routes can attach to them by Route kind, namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from the referencing Route, the Route MUST be considered successfully attached. If no Gateway listeners accept attachment from this Route, the Route MUST be considered detached from the Gateway. \n Support: Core";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSolverHttp01GatewayHTTPRouteParentRef =
    res:
    {
    }
    // optionalAttrs (res."group" != null) { inherit (res) "group"; }
    // {
    }
    // optionalAttrs (res."kind" != null) { inherit (res) "kind"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
    }
    // optionalAttrs (res."sectionName" != null) { inherit (res) "sectionName"; }
    // {
    };
  SolverHttp01IngressIngressTemplateMetadataModule = types.submodule {
    options = {
      "annotations" = mkOption {
        description = "Annotations that should be added to the created ACME HTTP01 solver ingress.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "labels" = mkOption {
        description = "Labels that should be added to the created ACME HTTP01 solver ingress.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkSolverHttp01IngressIngressTemplateMetadata =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    };
  SolverHttp01IngressIngressTemplateModule = types.submodule {
    options = {
      "metadata" = mkOption {
        description = "ObjectMeta overrides for the ingress used to solve HTTP01 challenges. Only the 'labels' and 'annotations' fields may be set. If labels or annotations overlap with in-built values, the values here will override the in-built values.";
        type = (types.nullOr SolverHttp01IngressIngressTemplateMetadataModule);
        default = null;
      };
    };
  };
  mkSolverHttp01IngressIngressTemplate =
    res:
    {
    }
    // optionalAttrs (res."metadata" != null) {
      "metadata" = mkSolverHttp01IngressIngressTemplateMetadata res."metadata";
    }
    // {
    };
  SolverHttp01IngressModule = types.submodule {
    options = {
      "class" = mkOption {
        description = "This field configures the annotation `kubernetes.io/ingress.class` when creating Ingress resources to solve ACME challenges that use this challenge solver. Only one of `class`, `name` or `ingressClassName` may be specified.";
        type = (types.nullOr types.str);
        default = null;
      };
      "ingressClassName" = mkOption {
        description = "This field configures the field `ingressClassName` on the created Ingress resources used to solve ACME challenges that use this challenge solver. This is the recommended way of configuring the ingress class. Only one of `class`, `name` or `ingressClassName` may be specified.";
        type = (types.nullOr types.str);
        default = null;
      };
      "ingressTemplate" = mkOption {
        description = "Optional ingress template used to configure the ACME challenge solver ingress used for HTTP01 challenges.";
        type = (types.nullOr SolverHttp01IngressIngressTemplateModule);
        default = null;
      };
      "name" = mkOption {
        description = "The name of the ingress resource that should have ACME challenge solving routes inserted into it in order to solve HTTP01 challenges. This is typically used in conjunction with ingress controllers like ingress-gce, which maintains a 1:1 mapping between external IPs and ingress resources. Only one of `class`, `name` or `ingressClassName` may be specified.";
        type = (types.nullOr types.str);
        default = null;
      };
      "podTemplate" = mkOption {
        description = "Optional pod template used to configure the ACME challenge solver pods used for HTTP01 challenges.";
        type = (types.nullOr SolverHttp01IngressPodTemplateModule);
        default = null;
      };
      "serviceType" = mkOption {
        description = "Optional service type for Kubernetes solver service. Supported values are NodePort or ClusterIP. If unset, defaults to NodePort.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSolverHttp01Ingress =
    res:
    {
    }
    // optionalAttrs (res."class" != null) { inherit (res) "class"; }
    // {
    }
    // optionalAttrs (res."ingressClassName" != null) { inherit (res) "ingressClassName"; }
    // {
    }
    // optionalAttrs (res."ingressTemplate" != null) {
      "ingressTemplate" = mkSolverHttp01IngressIngressTemplate res."ingressTemplate";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."podTemplate" != null) {
      "podTemplate" = mkSolverHttp01IngressPodTemplate res."podTemplate";
    }
    // {
    }
    // optionalAttrs (res."serviceType" != null) { inherit (res) "serviceType"; }
    // {
    };
  SolverHttp01IngressPodTemplateMetadataModule = types.submodule {
    options = {
      "annotations" = mkOption {
        description = "Annotations that should be added to the create ACME HTTP01 solver pods.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "labels" = mkOption {
        description = "Labels that should be added to the created ACME HTTP01 solver pods.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkSolverHttp01IngressPodTemplateMetadata =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    };
  SolverHttp01IngressPodTemplateModule = types.submodule {
    options = {
      "metadata" = mkOption {
        description = "ObjectMeta overrides for the pod used to solve HTTP01 challenges. Only the 'labels' and 'annotations' fields may be set. If labels or annotations overlap with in-built values, the values here will override the in-built values.";
        type = (types.nullOr SolverHttp01IngressPodTemplateMetadataModule);
        default = null;
      };
      "spec" = mkOption {
        description = "PodSpec defines overrides for the HTTP01 challenge solver pod. Check ACMEChallengeSolverHTTP01IngressPodSpec to find out currently supported fields. All other fields will be ignored.";
        type = (types.nullOr SolverHttp01IngressPodTemplateSpecModule);
        default = null;
      };
    };
  };
  mkSolverHttp01IngressPodTemplate =
    res:
    {
    }
    // optionalAttrs (res."metadata" != null) {
      "metadata" = mkSolverHttp01IngressPodTemplateMetadata res."metadata";
    }
    // {
    }
    // optionalAttrs (res."spec" != null) { "spec" = mkSolverHttp01IngressPodTemplateSpec res."spec"; }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityModule = types.submodule {
    options = {
      "nodeAffinity" = mkOption {
        description = "Describes node affinity scheduling rules for the pod.";
        type = (types.nullOr SolverHttp01IngressPodTemplateSpecAffinityNodeAffinityModule);
        default = null;
      };
      "podAffinity" = mkOption {
        description = "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s)).";
        type = (types.nullOr SolverHttp01IngressPodTemplateSpecAffinityPodAffinityModule);
        default = null;
      };
      "podAntiAffinity" = mkOption {
        description = "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s)).";
        type = (types.nullOr SolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityModule);
        default = null;
      };
    };
  };
  mkSolverHttp01IngressPodTemplateSpecAffinity =
    res:
    {
    }
    // optionalAttrs (res."nodeAffinity" != null) {
      "nodeAffinity" = mkSolverHttp01IngressPodTemplateSpecAffinityNodeAffinity res."nodeAffinity";
    }
    // {
    }
    // optionalAttrs (res."podAffinity" != null) {
      "podAffinity" = mkSolverHttp01IngressPodTemplateSpecAffinityPodAffinity res."podAffinity";
    }
    // {
    }
    // optionalAttrs (res."podAntiAffinity" != null) {
      "podAntiAffinity" =
        mkSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinity
          res."podAntiAffinity";
    }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityNodeAffinityModule = types.submodule {
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred.";
        type = (
          types.listOf SolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node.";
        type = (
          types.nullOr SolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = null;
      };
    };
  };
  mkSolverHttp01IngressPodTemplateSpecAffinityNodeAffinity =
    res:
    {
    }
    // optionalAttrs (res."preferredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "preferredDuringSchedulingIgnoredDuringExecution" =
        map
          mkSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecution
          res."preferredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    }
    // optionalAttrs (res."requiredDuringSchedulingIgnoredDuringExecution" != null) {
      "requiredDuringSchedulingIgnoredDuringExecution" =
        mkSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecution
          res."requiredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "preference" = mkOption {
            description = "A node selector term, associated with the corresponding weight.";
            type =
              SolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceModule;
          };
          "weight" = mkOption {
            description = "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100.";
            type = types.int;
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecution =
    res: {
      "preference" =
        mkSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreference
          res."preference";
      inherit (res) "weight";
    };
  SolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            description = "The label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.";
            type = types.str;
          };
          "values" = mkOption {
            description = "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchFieldModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            description = "The label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.";
            type = types.str;
          };
          "values" = mkOption {
            description = "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchField =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "A list of node selector requirements by node's labels.";
            type = (
              types.listOf SolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpressionModule
            );
            default = [ ];
          };
          "matchFields" = mkOption {
            description = "A list of node selector requirements by node's fields.";
            type = (
              types.listOf SolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchFieldModule
            );
            default = [ ];
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreference =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchFields" != [ ]) {
      "matchFields" =
        map
          mkSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchField
          res."matchFields";
    }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "nodeSelectorTerms" = mkOption {
            description = "Required. A list of node selector terms. The terms are ORed.";
            type = (
              types.listOf SolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermModule
            );
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecution =
    res: {
      "nodeSelectorTerms" =
        map
          mkSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTerm
          res."nodeSelectorTerms";
    };
  SolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            description = "The label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.";
            type = types.str;
          };
          "values" = mkOption {
            description = "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchFieldModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            description = "The label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.";
            type = types.str;
          };
          "values" = mkOption {
            description = "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchField =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "A list of node selector requirements by node's labels.";
            type = (
              types.listOf SolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpressionModule
            );
            default = [ ];
          };
          "matchFields" = mkOption {
            description = "A list of node selector requirements by node's fields.";
            type = (
              types.listOf SolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchFieldModule
            );
            default = [ ];
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTerm =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchFields" != [ ]) {
      "matchFields" =
        map
          mkSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchField
          res."matchFields";
    }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityPodAffinityModule = types.submodule {
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.";
        type = (
          types.listOf SolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.";
        type = (
          types.listOf SolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
    };
  };
  mkSolverHttp01IngressPodTemplateSpecAffinityPodAffinity =
    res:
    {
    }
    // optionalAttrs (res."preferredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "preferredDuringSchedulingIgnoredDuringExecution" =
        map
          mkSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecution
          res."preferredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    }
    // optionalAttrs (res."requiredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "requiredDuringSchedulingIgnoredDuringExecution" =
        map
          mkSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecution
          res."requiredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "podAffinityTerm" = mkOption {
            description = "Required. A pod affinity term, associated with the corresponding weight.";
            type =
              SolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule;
          };
          "weight" = mkOption {
            description = "weight associated with matching the corresponding podAffinityTerm, in the range 1-100.";
            type = types.int;
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecution =
    res: {
      "podAffinityTerm" =
        mkSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm
          res."podAffinityTerm";
      inherit (res) "weight";
    };
  SolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            description = "key is the label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
            type = types.str;
          };
          "values" = mkOption {
            description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf SolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.";
            type = (
              types.nullOr SolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule
            );
            default = null;
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr SolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule
            );
            default = null;
          };
          "namespaces" = mkOption {
            description = "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\".";
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            description = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.";
            type = types.str;
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaceSelector" != null) {
      "namespaceSelector" =
        mkSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  SolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            description = "key is the label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
            type = types.str;
          };
          "values" = mkOption {
            description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf SolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            description = "key is the label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
            type = types.str;
          };
          "values" = mkOption {
            description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf SolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.";
            type = (
              types.nullOr SolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule
            );
            default = null;
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr SolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule
            );
            default = null;
          };
          "namespaces" = mkOption {
            description = "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\".";
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            description = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.";
            type = types.str;
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecution =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaceSelector" != null) {
      "namespaceSelector" =
        mkSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  SolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            description = "key is the label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
            type = types.str;
          };
          "values" = mkOption {
            description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf SolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityModule = types.submodule {
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.";
        type = (
          types.listOf SolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.";
        type = (
          types.listOf SolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
    };
  };
  mkSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinity =
    res:
    {
    }
    // optionalAttrs (res."preferredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "preferredDuringSchedulingIgnoredDuringExecution" =
        map
          mkSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecution
          res."preferredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    }
    // optionalAttrs (res."requiredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "requiredDuringSchedulingIgnoredDuringExecution" =
        map
          mkSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecution
          res."requiredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "podAffinityTerm" = mkOption {
            description = "Required. A pod affinity term, associated with the corresponding weight.";
            type =
              SolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule;
          };
          "weight" = mkOption {
            description = "weight associated with matching the corresponding podAffinityTerm, in the range 1-100.";
            type = types.int;
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecution =
    res: {
      "podAffinityTerm" =
        mkSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm
          res."podAffinityTerm";
      inherit (res) "weight";
    };
  SolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            description = "key is the label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
            type = types.str;
          };
          "values" = mkOption {
            description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf SolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.";
            type = (
              types.nullOr SolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule
            );
            default = null;
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr SolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule
            );
            default = null;
          };
          "namespaces" = mkOption {
            description = "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\".";
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            description = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.";
            type = types.str;
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaceSelector" != null) {
      "namespaceSelector" =
        mkSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  SolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            description = "key is the label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
            type = types.str;
          };
          "values" = mkOption {
            description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf SolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            description = "key is the label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
            type = types.str;
          };
          "values" = mkOption {
            description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf SolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.";
            type = (
              types.nullOr SolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule
            );
            default = null;
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr SolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule
            );
            default = null;
          };
          "namespaces" = mkOption {
            description = "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\".";
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            description = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.";
            type = types.str;
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecution =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaceSelector" != null) {
      "namespaceSelector" =
        mkSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  SolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
        options = {
          "key" = mkOption {
            description = "key is the label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
            type = types.str;
          };
          "values" = mkOption {
            description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  SolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf SolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  mkSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  SolverHttp01IngressPodTemplateSpecImagePullSecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSolverHttp01IngressPodTemplateSpecImagePullSecret =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  SolverHttp01IngressPodTemplateSpecModule = types.submodule {
    options = {
      "affinity" = mkOption {
        description = "If specified, the pod's scheduling constraints";
        type = (types.nullOr SolverHttp01IngressPodTemplateSpecAffinityModule);
        default = null;
      };
      "imagePullSecrets" = mkOption {
        description = "If specified, the pod's imagePullSecrets";
        type = (types.listOf SolverHttp01IngressPodTemplateSpecImagePullSecretModule);
        default = [ ];
      };
      "nodeSelector" = mkOption {
        description = "NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/";
        type = (types.attrsOf types.str);
        default = { };
      };
      "priorityClassName" = mkOption {
        description = "If specified, the pod's priorityClassName.";
        type = (types.nullOr types.str);
        default = null;
      };
      "serviceAccountName" = mkOption {
        description = "If specified, the pod's service account";
        type = (types.nullOr types.str);
        default = null;
      };
      "tolerations" = mkOption {
        description = "If specified, the pod's tolerations.";
        type = (types.listOf SolverHttp01IngressPodTemplateSpecTolerationModule);
        default = [ ];
      };
    };
  };
  mkSolverHttp01IngressPodTemplateSpec =
    res:
    {
    }
    // optionalAttrs (res."affinity" != null) {
      "affinity" = mkSolverHttp01IngressPodTemplateSpecAffinity res."affinity";
    }
    // {
    }
    // optionalAttrs (res."imagePullSecrets" != [ ]) {
      "imagePullSecrets" = map mkSolverHttp01IngressPodTemplateSpecImagePullSecret res."imagePullSecrets";
    }
    // {
    }
    // optionalAttrs (res."nodeSelector" != { }) { inherit (res) "nodeSelector"; }
    // {
    }
    // optionalAttrs (res."priorityClassName" != null) { inherit (res) "priorityClassName"; }
    // {
    }
    // optionalAttrs (res."serviceAccountName" != null) { inherit (res) "serviceAccountName"; }
    // {
    }
    // optionalAttrs (res."tolerations" != [ ]) {
      "tolerations" = map mkSolverHttp01IngressPodTemplateSpecToleration res."tolerations";
    }
    // {
    };
  SolverHttp01IngressPodTemplateSpecTolerationModule = types.submodule {
    options = {
      "effect" = mkOption {
        description = "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute.";
        type = (types.nullOr types.str);
        default = null;
      };
      "key" = mkOption {
        description = "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys.";
        type = (types.nullOr types.str);
        default = null;
      };
      "operator" = mkOption {
        description = "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tolerationSeconds" = mkOption {
        description = "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system.";
        type = (types.nullOr types.int);
        default = null;
      };
      "value" = mkOption {
        description = "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSolverHttp01IngressPodTemplateSpecToleration =
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
  SolverHttp01Module = types.submodule {
    options = {
      "gatewayHTTPRoute" = mkOption {
        description = "The Gateway API is a sig-network community API that models service networking in Kubernetes (https://gateway-api.sigs.k8s.io/). The Gateway solver will create HTTPRoutes with the specified labels in the same namespace as the challenge. This solver is experimental, and fields / behaviour may change in the future.";
        type = (types.nullOr SolverHttp01GatewayHTTPRouteModule);
        default = null;
      };
      "ingress" = mkOption {
        description = "The ingress based HTTP01 challenge solver will solve challenges by creating or modifying Ingress resources in order to route requests for '/.well-known/acme-challenge/XYZ' to 'challenge solver' pods that are provisioned by cert-manager for each Challenge to be completed.";
        type = (types.nullOr SolverHttp01IngressModule);
        default = null;
      };
    };
  };
  mkSolverHttp01 =
    res:
    {
    }
    // optionalAttrs (res."gatewayHTTPRoute" != null) {
      "gatewayHTTPRoute" = mkSolverHttp01GatewayHTTPRoute res."gatewayHTTPRoute";
    }
    // {
    }
    // optionalAttrs (res."ingress" != null) { "ingress" = mkSolverHttp01Ingress res."ingress"; }
    // {
    };
  SolverModule = types.submodule {
    options = {
      "dns01" = mkOption {
        description = "Configures cert-manager to attempt to complete authorizations by performing the DNS01 challenge flow.";
        type = (types.nullOr SolverDns01Module);
        default = null;
      };
      "http01" = mkOption {
        description = "Configures cert-manager to attempt to complete authorizations by performing the HTTP01 challenge flow. It is not possible to obtain certificates for wildcard domain names (e.g. `*.example.com`) using the HTTP01 challenge mechanism.";
        type = (types.nullOr SolverHttp01Module);
        default = null;
      };
      "selector" = mkOption {
        description = "Selector selects a set of DNSNames on the Certificate resource that should be solved using this challenge solver. If not specified, the solver will be treated as the 'default' solver with the lowest priority, i.e. if any other solver has a more specific match, it will be used instead.";
        type = (types.nullOr SolverSelectorModule);
        default = null;
      };
    };
  };
  mkSolver =
    res:
    {
    }
    // optionalAttrs (res."dns01" != null) { "dns01" = mkSolverDns01 res."dns01"; }
    // {
    }
    // optionalAttrs (res."http01" != null) { "http01" = mkSolverHttp01 res."http01"; }
    // {
    }
    // optionalAttrs (res."selector" != null) { "selector" = mkSolverSelector res."selector"; }
    // {
    };
  SolverSelectorModule = types.submodule {
    options = {
      "dnsNames" = mkOption {
        description = "List of DNSNames that this solver will be used to solve. If specified and a match is found, a dnsNames selector will take precedence over a dnsZones selector. If multiple solvers match with the same dnsNames value, the solver with the most matching labels in matchLabels will be selected. If neither has more matches, the solver defined earlier in the list will be selected.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "dnsZones" = mkOption {
        description = "List of DNSZones that this solver will be used to solve. The most specific DNS zone match specified here will take precedence over other DNS zone matches, so a solver specifying sys.example.com will be selected over one specifying example.com for the domain www.sys.example.com. If multiple solvers match with the same dnsZones value, the solver with the most matching labels in matchLabels will be selected. If neither has more matches, the solver defined earlier in the list will be selected.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "A label selector that is used to refine the set of certificate's that this challenge solver will apply to.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkSolverSelector =
    res:
    {
    }
    // optionalAttrs (res."dnsNames" != [ ]) { inherit (res) "dnsNames"; }
    // {
    }
    // optionalAttrs (res."dnsZones" != [ ]) { inherit (res) "dnsZones"; }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  ChallengesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this Challenge resource.";
        };
        "authorizationURL" = mkOption {
          description = "The URL to the ACME Authorization resource that this challenge is a part of.";
          type = types.str;
        };
        "dnsName" = mkOption {
          description = "dnsName is the identifier that this challenge is for, e.g. example.com. If the requested DNSName is a 'wildcard', this field MUST be set to the non-wildcard domain, e.g. for `*.example.com`, it must be `example.com`.";
          type = types.str;
        };
        "issuerRef" = mkOption {
          description = "References a properly configured ACME-type Issuer which should be used to create this Challenge. If the Issuer does not exist, processing will be retried. If the Issuer is not an 'ACME' Issuer, an error will be returned and the Challenge will be marked as failed.";
          type = IssuerRefModule;
        };
        "key" = mkOption {
          description = "The ACME challenge key for this challenge For HTTP01 challenges, this is the value that must be responded with to complete the HTTP01 challenge in the format: `<private key JWK thumbprint>.<key from acme server for challenge>`. For DNS01 challenges, this is the base64 encoded SHA256 sum of the `<private key JWK thumbprint>.<key from acme server for challenge>` text that must be set as the TXT record content.";
          type = types.str;
        };
        "solver" = mkOption {
          description = "Contains the domain solving configuration that should be used to solve this challenge resource.";
          type = SolverModule;
        };
        "token" = mkOption {
          description = "The ACME challenge token for this challenge. This is the raw value returned from the ACME server.";
          type = types.str;
        };
        "type" = mkOption {
          description = "The type of ACME challenge this resource represents. One of \"HTTP-01\" or \"DNS-01\".";
          type = (
            types.enum [
              "HTTP-01"
              "DNS-01"
            ]
          );
        };
        "url" = mkOption {
          description = "The URL of the ACME Challenge resource for this challenge. This can be used to lookup details about the status of this challenge.";
          type = types.str;
        };
        "wildcard" = mkOption {
          description = "wildcard will be true if this challenge is for a wildcard identifier, for example '*.example.com'.";
          type = types.bool;
          default = false;
        };
      };
    }
  );
  mkChallenge = name: res: {
    apiVersion = "acme.cert-manager.io/v1";
    kind = "Challenge";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
      inherit (res) "authorizationURL";
      inherit (res) "dnsName";
      "issuerRef" = mkIssuerRef res."issuerRef";
      inherit (res) "key";
      "solver" = mkSolver res."solver";
      inherit (res) "token";
      inherit (res) "type";
      inherit (res) "url";
    }
    // optionalAttrs res."wildcard" { inherit (res) "wildcard"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkChallenge cfg."challenges");
in
{
  options.openkrill.apps."cert-manager" = {
    "challenges" = mkOption {
      type = types.attrsOf ChallengesModule;
      default = { };
      description = "Challenge CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."cert-manager".content = allResources;
  };
}
