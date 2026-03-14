# Auto-generated openkrill module fragment for cert-manager
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."cert-manager";
  compact = filterAttrs (_: v: v != null);
  AcmeExternalAccountBindingKeySecretRefModule = types.submodule {
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
  mkAcmeExternalAccountBindingKeySecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  AcmeExternalAccountBindingModule = types.submodule {
    options = {
      "keyAlgorithm" = mkOption {
        description = "Deprecated: keyAlgorithm field exists for historical compatibility reasons and should not be used. The algorithm is now hardcoded to HS256 in golang/x/crypto/acme.";
        type = (
          types.nullOr (
            types.enum [
              "HS256"
              "HS384"
              "HS512"
            ]
          )
        );
        default = null;
      };
      "keyID" = mkOption {
        description = "keyID is the ID of the CA key that the External Account is bound to.";
        type = types.str;
      };
      "keySecretRef" = mkOption {
        description = "keySecretRef is a Secret Key Selector referencing a data item in a Kubernetes Secret which holds the symmetric MAC key of the External Account Binding. The `key` is the index string that is paired with the key data in the Secret and should not be confused with the key data itself, or indeed with the External Account Binding keyID above. The secret key stored in the Secret **must** be un-padded, base64 URL encoded data.";
        type = AcmeExternalAccountBindingKeySecretRefModule;
      };
    };
  };
  mkAcmeExternalAccountBinding =
    res:
    {
    }
    // optionalAttrs (res."keyAlgorithm" != null) { inherit (res) "keyAlgorithm"; }
    // {
      inherit (res) "keyID";
      "keySecretRef" = mkAcmeExternalAccountBindingKeySecretRef res."keySecretRef";
    };
  AcmeModule = types.submodule {
    options = {
      "caBundle" = mkOption {
        description = "Base64-encoded bundle of PEM CAs which can be used to validate the certificate chain presented by the ACME server. Mutually exclusive with SkipTLSVerify; prefer using CABundle to prevent various kinds of security vulnerabilities. If CABundle and SkipTLSVerify are unset, the system certificate bundle inside the container is used to validate the TLS connection.";
        type = (types.nullOr types.str);
        default = null;
      };
      "disableAccountKeyGeneration" = mkOption {
        description = "Enables or disables generating a new ACME account key. If true, the Issuer resource will *not* request a new account but will expect the account key to be supplied via an existing secret. If false, the cert-manager system will generate a new ACME account key for the Issuer. Defaults to false.";
        type = types.bool;
        default = false;
      };
      "email" = mkOption {
        description = "Email is the email address to be associated with the ACME account. This field is optional, but it is strongly recommended to be set. It will be used to contact you in case of issues with your account or certificates, including expiry notification emails. This field may be updated after the account is initially registered.";
        type = (types.nullOr types.str);
        default = null;
      };
      "enableDurationFeature" = mkOption {
        description = "Enables requesting a Not After date on certificates that matches the duration of the certificate. This is not supported by all ACME servers like Let's Encrypt. If set to true when the ACME server does not support it it will create an error on the Order. Defaults to false.";
        type = types.bool;
        default = false;
      };
      "externalAccountBinding" = mkOption {
        description = "ExternalAccountBinding is a reference to a CA external account of the ACME server. If set, upon registration cert-manager will attempt to associate the given external account credentials with the registered ACME account.";
        type = (types.nullOr AcmeExternalAccountBindingModule);
        default = null;
      };
      "preferredChain" = mkOption {
        description = "PreferredChain is the chain to use if the ACME server outputs multiple. PreferredChain is no guarantee that this one gets delivered by the ACME endpoint. For example, for Let's Encrypt's DST crosssign you would use: \"DST Root CA X3\" or \"ISRG Root X1\" for the newer Let's Encrypt root CA. This value picks the first certificate bundle in the ACME alternative chains that has a certificate with this value as its issuer's CN";
        type = (types.nullOr types.str);
        default = null;
      };
      "privateKeySecretRef" = mkOption {
        description = "PrivateKey is the name of a Kubernetes Secret resource that will be used to store the automatically generated ACME account private key. Optionally, a `key` may be specified to select a specific entry within the named Secret resource. If `key` is not specified, a default of `tls.key` will be used.";
        type = AcmePrivateKeySecretRefModule;
      };
      "server" = mkOption {
        description = "Server is the URL used to access the ACME server's 'directory' endpoint. For example, for Let's Encrypt's staging endpoint, you would use: \"https://acme-staging-v02.api.letsencrypt.org/directory\". Only ACME v2 endpoints (i.e. RFC 8555) are supported.";
        type = types.str;
      };
      "skipTLSVerify" = mkOption {
        description = "INSECURE: Enables or disables validation of the ACME server TLS certificate. If true, requests to the ACME server will not have the TLS certificate chain validated. Mutually exclusive with CABundle; prefer using CABundle to prevent various kinds of security vulnerabilities. Only enable this option in development environments. If CABundle and SkipTLSVerify are unset, the system certificate bundle inside the container is used to validate the TLS connection. Defaults to false.";
        type = types.bool;
        default = false;
      };
      "solvers" = mkOption {
        description = "Solvers is a list of challenge solvers that will be used to solve ACME challenges for the matching domains. Solver configurations must be provided in order to obtain certificates from an ACME server. For more information, see: https://cert-manager.io/docs/configuration/acme/";
        type = (types.listOf AcmeSolverModule);
        default = [ ];
      };
    };
  };
  mkAcme =
    res:
    {
    }
    // optionalAttrs (res."caBundle" != null) { inherit (res) "caBundle"; }
    // {
    }
    // optionalAttrs res."disableAccountKeyGeneration" { inherit (res) "disableAccountKeyGeneration"; }
    // {
    }
    // optionalAttrs (res."email" != null) { inherit (res) "email"; }
    // {
    }
    // optionalAttrs res."enableDurationFeature" { inherit (res) "enableDurationFeature"; }
    // {
    }
    // optionalAttrs (res."externalAccountBinding" != null) {
      "externalAccountBinding" = mkAcmeExternalAccountBinding res."externalAccountBinding";
    }
    // {
    }
    // optionalAttrs (res."preferredChain" != null) { inherit (res) "preferredChain"; }
    // {
      "privateKeySecretRef" = mkAcmePrivateKeySecretRef res."privateKeySecretRef";
      inherit (res) "server";
    }
    // optionalAttrs res."skipTLSVerify" { inherit (res) "skipTLSVerify"; }
    // {
    }
    // optionalAttrs (res."solvers" != [ ]) { "solvers" = map mkAcmeSolver res."solvers"; }
    // {
    };
  AcmePrivateKeySecretRefModule = types.submodule {
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
  mkAcmePrivateKeySecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  AcmeSolverDns01AcmeDNSAccountSecretRefModule = types.submodule {
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
  mkAcmeSolverDns01AcmeDNSAccountSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  AcmeSolverDns01AcmeDNSModule = types.submodule {
    options = {
      "accountSecretRef" = mkOption {
        description = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field.";
        type = AcmeSolverDns01AcmeDNSAccountSecretRefModule;
      };
      "host" = mkOption {
        type = types.str;
      };
    };
  };
  mkAcmeSolverDns01AcmeDNS = res: {
    "accountSecretRef" = mkAcmeSolverDns01AcmeDNSAccountSecretRef res."accountSecretRef";
    inherit (res) "host";
  };
  AcmeSolverDns01AkamaiAccessTokenSecretRefModule = types.submodule {
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
  mkAcmeSolverDns01AkamaiAccessTokenSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  AcmeSolverDns01AkamaiClientSecretSecretRefModule = types.submodule {
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
  mkAcmeSolverDns01AkamaiClientSecretSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  AcmeSolverDns01AkamaiClientTokenSecretRefModule = types.submodule {
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
  mkAcmeSolverDns01AkamaiClientTokenSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  AcmeSolverDns01AkamaiModule = types.submodule {
    options = {
      "accessTokenSecretRef" = mkOption {
        description = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field.";
        type = AcmeSolverDns01AkamaiAccessTokenSecretRefModule;
      };
      "clientSecretSecretRef" = mkOption {
        description = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field.";
        type = AcmeSolverDns01AkamaiClientSecretSecretRefModule;
      };
      "clientTokenSecretRef" = mkOption {
        description = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field.";
        type = AcmeSolverDns01AkamaiClientTokenSecretRefModule;
      };
      "serviceConsumerDomain" = mkOption {
        type = types.str;
      };
    };
  };
  mkAcmeSolverDns01Akamai = res: {
    "accessTokenSecretRef" = mkAcmeSolverDns01AkamaiAccessTokenSecretRef res."accessTokenSecretRef";
    "clientSecretSecretRef" = mkAcmeSolverDns01AkamaiClientSecretSecretRef res."clientSecretSecretRef";
    "clientTokenSecretRef" = mkAcmeSolverDns01AkamaiClientTokenSecretRef res."clientTokenSecretRef";
    inherit (res) "serviceConsumerDomain";
  };
  AcmeSolverDns01AzureDNSClientSecretSecretRefModule = types.submodule {
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
  mkAcmeSolverDns01AzureDNSClientSecretSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  AcmeSolverDns01AzureDNSManagedIdentityModule = types.submodule {
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
  mkAcmeSolverDns01AzureDNSManagedIdentity =
    res:
    {
    }
    // optionalAttrs (res."clientID" != null) { inherit (res) "clientID"; }
    // {
    }
    // optionalAttrs (res."resourceID" != null) { inherit (res) "resourceID"; }
    // {
    };
  AcmeSolverDns01AzureDNSModule = types.submodule {
    options = {
      "clientID" = mkOption {
        description = "if both this and ClientSecret are left unset MSI will be used";
        type = (types.nullOr types.str);
        default = null;
      };
      "clientSecretSecretRef" = mkOption {
        description = "if both this and ClientID are left unset MSI will be used";
        type = (types.nullOr AcmeSolverDns01AzureDNSClientSecretSecretRefModule);
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
        type = (types.nullOr AcmeSolverDns01AzureDNSManagedIdentityModule);
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
  mkAcmeSolverDns01AzureDNS =
    res:
    {
    }
    // optionalAttrs (res."clientID" != null) { inherit (res) "clientID"; }
    // {
    }
    // optionalAttrs (res."clientSecretSecretRef" != null) {
      "clientSecretSecretRef" =
        mkAcmeSolverDns01AzureDNSClientSecretSecretRef
          res."clientSecretSecretRef";
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
      "managedIdentity" = mkAcmeSolverDns01AzureDNSManagedIdentity res."managedIdentity";
    }
    // {
      inherit (res) "resourceGroupName";
      inherit (res) "subscriptionID";
    }
    // optionalAttrs (res."tenantID" != null) { inherit (res) "tenantID"; }
    // {
    };
  AcmeSolverDns01CloudDNSModule = types.submodule {
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
        type = (types.nullOr AcmeSolverDns01CloudDNSServiceAccountSecretRefModule);
        default = null;
      };
    };
  };
  mkAcmeSolverDns01CloudDNS =
    res:
    {
    }
    // optionalAttrs (res."hostedZoneName" != null) { inherit (res) "hostedZoneName"; }
    // {
      inherit (res) "project";
    }
    // optionalAttrs (res."serviceAccountSecretRef" != null) {
      "serviceAccountSecretRef" =
        mkAcmeSolverDns01CloudDNSServiceAccountSecretRef
          res."serviceAccountSecretRef";
    }
    // {
    };
  AcmeSolverDns01CloudDNSServiceAccountSecretRefModule = types.submodule {
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
  mkAcmeSolverDns01CloudDNSServiceAccountSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  AcmeSolverDns01CloudflareApiKeySecretRefModule = types.submodule {
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
  mkAcmeSolverDns01CloudflareApiKeySecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  AcmeSolverDns01CloudflareApiTokenSecretRefModule = types.submodule {
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
  mkAcmeSolverDns01CloudflareApiTokenSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  AcmeSolverDns01CloudflareModule = types.submodule {
    options = {
      "apiKeySecretRef" = mkOption {
        description = "API key to use to authenticate with Cloudflare. Note: using an API token to authenticate is now the recommended method as it allows greater control of permissions.";
        type = (types.nullOr AcmeSolverDns01CloudflareApiKeySecretRefModule);
        default = null;
      };
      "apiTokenSecretRef" = mkOption {
        description = "API token used to authenticate with Cloudflare.";
        type = (types.nullOr AcmeSolverDns01CloudflareApiTokenSecretRefModule);
        default = null;
      };
      "email" = mkOption {
        description = "Email of the account, only required when using API key based authentication.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkAcmeSolverDns01Cloudflare =
    res:
    {
    }
    // optionalAttrs (res."apiKeySecretRef" != null) {
      "apiKeySecretRef" = mkAcmeSolverDns01CloudflareApiKeySecretRef res."apiKeySecretRef";
    }
    // {
    }
    // optionalAttrs (res."apiTokenSecretRef" != null) {
      "apiTokenSecretRef" = mkAcmeSolverDns01CloudflareApiTokenSecretRef res."apiTokenSecretRef";
    }
    // {
    }
    // optionalAttrs (res."email" != null) { inherit (res) "email"; }
    // {
    };
  AcmeSolverDns01DigitaloceanModule = types.submodule {
    options = {
      "tokenSecretRef" = mkOption {
        description = "A reference to a specific 'key' within a Secret resource. In some instances, `key` is a required field.";
        type = AcmeSolverDns01DigitaloceanTokenSecretRefModule;
      };
    };
  };
  mkAcmeSolverDns01Digitalocean = res: {
    "tokenSecretRef" = mkAcmeSolverDns01DigitaloceanTokenSecretRef res."tokenSecretRef";
  };
  AcmeSolverDns01DigitaloceanTokenSecretRefModule = types.submodule {
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
  mkAcmeSolverDns01DigitaloceanTokenSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  AcmeSolverDns01Module = types.submodule {
    options = {
      "acmeDNS" = mkOption {
        description = "Use the 'ACME DNS' (https://github.com/joohoi/acme-dns) API to manage DNS01 challenge records.";
        type = (types.nullOr AcmeSolverDns01AcmeDNSModule);
        default = null;
      };
      "akamai" = mkOption {
        description = "Use the Akamai DNS zone management API to manage DNS01 challenge records.";
        type = (types.nullOr AcmeSolverDns01AkamaiModule);
        default = null;
      };
      "azureDNS" = mkOption {
        description = "Use the Microsoft Azure DNS API to manage DNS01 challenge records.";
        type = (types.nullOr AcmeSolverDns01AzureDNSModule);
        default = null;
      };
      "cloudDNS" = mkOption {
        description = "Use the Google Cloud DNS API to manage DNS01 challenge records.";
        type = (types.nullOr AcmeSolverDns01CloudDNSModule);
        default = null;
      };
      "cloudflare" = mkOption {
        description = "Use the Cloudflare API to manage DNS01 challenge records.";
        type = (types.nullOr AcmeSolverDns01CloudflareModule);
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
        type = (types.nullOr AcmeSolverDns01DigitaloceanModule);
        default = null;
      };
      "rfc2136" = mkOption {
        description = "Use RFC2136 (\"Dynamic Updates in the Domain Name System\") (https://datatracker.ietf.org/doc/rfc2136/) to manage DNS01 challenge records.";
        type = (types.nullOr AcmeSolverDns01Rfc2136Module);
        default = null;
      };
      "route53" = mkOption {
        description = "Use the AWS Route53 API to manage DNS01 challenge records.";
        type = (types.nullOr AcmeSolverDns01Route53Module);
        default = null;
      };
      "webhook" = mkOption {
        description = "Configure an external webhook based DNS01 challenge solver to manage DNS01 challenge records.";
        type = (types.nullOr AcmeSolverDns01WebhookModule);
        default = null;
      };
    };
  };
  mkAcmeSolverDns01 =
    res:
    {
    }
    // optionalAttrs (res."acmeDNS" != null) { "acmeDNS" = mkAcmeSolverDns01AcmeDNS res."acmeDNS"; }
    // {
    }
    // optionalAttrs (res."akamai" != null) { "akamai" = mkAcmeSolverDns01Akamai res."akamai"; }
    // {
    }
    // optionalAttrs (res."azureDNS" != null) { "azureDNS" = mkAcmeSolverDns01AzureDNS res."azureDNS"; }
    // {
    }
    // optionalAttrs (res."cloudDNS" != null) { "cloudDNS" = mkAcmeSolverDns01CloudDNS res."cloudDNS"; }
    // {
    }
    // optionalAttrs (res."cloudflare" != null) {
      "cloudflare" = mkAcmeSolverDns01Cloudflare res."cloudflare";
    }
    // {
    }
    // optionalAttrs (res."cnameStrategy" != null) { inherit (res) "cnameStrategy"; }
    // {
    }
    // optionalAttrs (res."digitalocean" != null) {
      "digitalocean" = mkAcmeSolverDns01Digitalocean res."digitalocean";
    }
    // {
    }
    // optionalAttrs (res."rfc2136" != null) { "rfc2136" = mkAcmeSolverDns01Rfc2136 res."rfc2136"; }
    // {
    }
    // optionalAttrs (res."route53" != null) { "route53" = mkAcmeSolverDns01Route53 res."route53"; }
    // {
    }
    // optionalAttrs (res."webhook" != null) { "webhook" = mkAcmeSolverDns01Webhook res."webhook"; }
    // {
    };
  AcmeSolverDns01Rfc2136Module = types.submodule {
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
        type = (types.nullOr AcmeSolverDns01Rfc2136TsigSecretSecretRefModule);
        default = null;
      };
    };
  };
  mkAcmeSolverDns01Rfc2136 =
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
      "tsigSecretSecretRef" = mkAcmeSolverDns01Rfc2136TsigSecretSecretRef res."tsigSecretSecretRef";
    }
    // {
    };
  AcmeSolverDns01Rfc2136TsigSecretSecretRefModule = types.submodule {
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
  mkAcmeSolverDns01Rfc2136TsigSecretSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  AcmeSolverDns01Route53AccessKeyIDSecretRefModule = types.submodule {
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
  mkAcmeSolverDns01Route53AccessKeyIDSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  AcmeSolverDns01Route53Module = types.submodule {
    options = {
      "accessKeyID" = mkOption {
        description = "The AccessKeyID is used for authentication. Cannot be set when SecretAccessKeyID is set. If neither the Access Key nor Key ID are set, we fall-back to using env vars, shared credentials file or AWS Instance metadata, see: https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials";
        type = (types.nullOr types.str);
        default = null;
      };
      "accessKeyIDSecretRef" = mkOption {
        description = "The SecretAccessKey is used for authentication. If set, pull the AWS access key ID from a key within a Kubernetes Secret. Cannot be set when AccessKeyID is set. If neither the Access Key nor Key ID are set, we fall-back to using env vars, shared credentials file or AWS Instance metadata, see: https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials";
        type = (types.nullOr AcmeSolverDns01Route53AccessKeyIDSecretRefModule);
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
        type = (types.nullOr AcmeSolverDns01Route53SecretAccessKeySecretRefModule);
        default = null;
      };
    };
  };
  mkAcmeSolverDns01Route53 =
    res:
    {
    }
    // optionalAttrs (res."accessKeyID" != null) { inherit (res) "accessKeyID"; }
    // {
    }
    // optionalAttrs (res."accessKeyIDSecretRef" != null) {
      "accessKeyIDSecretRef" = mkAcmeSolverDns01Route53AccessKeyIDSecretRef res."accessKeyIDSecretRef";
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
        mkAcmeSolverDns01Route53SecretAccessKeySecretRef
          res."secretAccessKeySecretRef";
    }
    // {
    };
  AcmeSolverDns01Route53SecretAccessKeySecretRefModule = types.submodule {
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
  mkAcmeSolverDns01Route53SecretAccessKeySecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  AcmeSolverDns01WebhookModule = types.submodule {
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
  mkAcmeSolverDns01Webhook =
    res:
    {
    }
    // optionalAttrs (res."config" != null) { inherit (res) "config"; }
    // {
      inherit (res) "groupName";
      inherit (res) "solverName";
    };
  AcmeSolverHttp01GatewayHTTPRouteModule = types.submodule {
    options = {
      "labels" = mkOption {
        description = "Custom labels that will be applied to HTTPRoutes created by cert-manager while solving HTTP-01 challenges.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "parentRefs" = mkOption {
        description = "When solving an HTTP-01 challenge, cert-manager creates an HTTPRoute. cert-manager needs to know which parentRefs should be used when creating the HTTPRoute. Usually, the parentRef references a Gateway. See: https://gateway-api.sigs.k8s.io/api-types/httproute/#attaching-to-gateways";
        type = (types.listOf AcmeSolverHttp01GatewayHTTPRouteParentRefModule);
        default = [ ];
      };
      "serviceType" = mkOption {
        description = "Optional service type for Kubernetes solver service. Supported values are NodePort or ClusterIP. If unset, defaults to NodePort.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkAcmeSolverHttp01GatewayHTTPRoute =
    res:
    {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."parentRefs" != [ ]) {
      "parentRefs" = map mkAcmeSolverHttp01GatewayHTTPRouteParentRef res."parentRefs";
    }
    // {
    }
    // optionalAttrs (res."serviceType" != null) { inherit (res) "serviceType"; }
    // {
    };
  AcmeSolverHttp01GatewayHTTPRouteParentRefModule = types.submodule {
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
  mkAcmeSolverHttp01GatewayHTTPRouteParentRef =
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
  AcmeSolverHttp01IngressIngressTemplateMetadataModule = types.submodule {
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
  mkAcmeSolverHttp01IngressIngressTemplateMetadata =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    };
  AcmeSolverHttp01IngressIngressTemplateModule = types.submodule {
    options = {
      "metadata" = mkOption {
        description = "ObjectMeta overrides for the ingress used to solve HTTP01 challenges. Only the 'labels' and 'annotations' fields may be set. If labels or annotations overlap with in-built values, the values here will override the in-built values.";
        type = (types.nullOr AcmeSolverHttp01IngressIngressTemplateMetadataModule);
        default = null;
      };
    };
  };
  mkAcmeSolverHttp01IngressIngressTemplate =
    res:
    {
    }
    // optionalAttrs (res."metadata" != null) {
      "metadata" = mkAcmeSolverHttp01IngressIngressTemplateMetadata res."metadata";
    }
    // {
    };
  AcmeSolverHttp01IngressModule = types.submodule {
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
        type = (types.nullOr AcmeSolverHttp01IngressIngressTemplateModule);
        default = null;
      };
      "name" = mkOption {
        description = "The name of the ingress resource that should have ACME challenge solving routes inserted into it in order to solve HTTP01 challenges. This is typically used in conjunction with ingress controllers like ingress-gce, which maintains a 1:1 mapping between external IPs and ingress resources. Only one of `class`, `name` or `ingressClassName` may be specified.";
        type = (types.nullOr types.str);
        default = null;
      };
      "podTemplate" = mkOption {
        description = "Optional pod template used to configure the ACME challenge solver pods used for HTTP01 challenges.";
        type = (types.nullOr AcmeSolverHttp01IngressPodTemplateModule);
        default = null;
      };
      "serviceType" = mkOption {
        description = "Optional service type for Kubernetes solver service. Supported values are NodePort or ClusterIP. If unset, defaults to NodePort.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkAcmeSolverHttp01Ingress =
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
      "ingressTemplate" = mkAcmeSolverHttp01IngressIngressTemplate res."ingressTemplate";
    }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."podTemplate" != null) {
      "podTemplate" = mkAcmeSolverHttp01IngressPodTemplate res."podTemplate";
    }
    // {
    }
    // optionalAttrs (res."serviceType" != null) { inherit (res) "serviceType"; }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateMetadataModule = types.submodule {
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
  mkAcmeSolverHttp01IngressPodTemplateMetadata =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateModule = types.submodule {
    options = {
      "metadata" = mkOption {
        description = "ObjectMeta overrides for the pod used to solve HTTP01 challenges. Only the 'labels' and 'annotations' fields may be set. If labels or annotations overlap with in-built values, the values here will override the in-built values.";
        type = (types.nullOr AcmeSolverHttp01IngressPodTemplateMetadataModule);
        default = null;
      };
      "spec" = mkOption {
        description = "PodSpec defines overrides for the HTTP01 challenge solver pod. Check ACMEChallengeSolverHTTP01IngressPodSpec to find out currently supported fields. All other fields will be ignored.";
        type = (types.nullOr AcmeSolverHttp01IngressPodTemplateSpecModule);
        default = null;
      };
    };
  };
  mkAcmeSolverHttp01IngressPodTemplate =
    res:
    {
    }
    // optionalAttrs (res."metadata" != null) {
      "metadata" = mkAcmeSolverHttp01IngressPodTemplateMetadata res."metadata";
    }
    // {
    }
    // optionalAttrs (res."spec" != null) {
      "spec" = mkAcmeSolverHttp01IngressPodTemplateSpec res."spec";
    }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityModule = types.submodule {
    options = {
      "nodeAffinity" = mkOption {
        description = "Describes node affinity scheduling rules for the pod.";
        type = (types.nullOr AcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityModule);
        default = null;
      };
      "podAffinity" = mkOption {
        description = "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s)).";
        type = (types.nullOr AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityModule);
        default = null;
      };
      "podAntiAffinity" = mkOption {
        description = "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s)).";
        type = (types.nullOr AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityModule);
        default = null;
      };
    };
  };
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinity =
    res:
    {
    }
    // optionalAttrs (res."nodeAffinity" != null) {
      "nodeAffinity" = mkAcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinity res."nodeAffinity";
    }
    // {
    }
    // optionalAttrs (res."podAffinity" != null) {
      "podAffinity" = mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinity res."podAffinity";
    }
    // {
    }
    // optionalAttrs (res."podAntiAffinity" != null) {
      "podAntiAffinity" =
        mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinity
          res."podAntiAffinity";
    }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityModule = types.submodule {
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred.";
        type = (
          types.listOf AcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node.";
        type = (
          types.nullOr AcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = null;
      };
    };
  };
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinity =
    res:
    {
    }
    // optionalAttrs (res."preferredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "preferredDuringSchedulingIgnoredDuringExecution" =
        map
          mkAcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecution
          res."preferredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    }
    // optionalAttrs (res."requiredDuringSchedulingIgnoredDuringExecution" != null) {
      "requiredDuringSchedulingIgnoredDuringExecution" =
        mkAcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecution
          res."requiredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "preference" = mkOption {
            description = "A node selector term, associated with the corresponding weight.";
            type =
              AcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceModule;
          };
          "weight" = mkOption {
            description = "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100.";
            type = types.int;
          };
        };
      };
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecution =
    res: {
      "preference" =
        mkAcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreference
          res."preference";
      inherit (res) "weight";
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpressionModule =
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
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchFieldModule =
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
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchField =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "A list of node selector requirements by node's labels.";
            type = (
              types.listOf AcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpressionModule
            );
            default = [ ];
          };
          "matchFields" = mkOption {
            description = "A list of node selector requirements by node's fields.";
            type = (
              types.listOf AcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchFieldModule
            );
            default = [ ];
          };
        };
      };
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreference =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchFields" != [ ]) {
      "matchFields" =
        map
          mkAcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchField
          res."matchFields";
    }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "nodeSelectorTerms" = mkOption {
            description = "Required. A list of node selector terms. The terms are ORed.";
            type = (
              types.listOf AcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermModule
            );
          };
        };
      };
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecution =
    res: {
      "nodeSelectorTerms" =
        map
          mkAcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTerm
          res."nodeSelectorTerms";
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpressionModule =
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
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchFieldModule =
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
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchField =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "A list of node selector requirements by node's labels.";
            type = (
              types.listOf AcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpressionModule
            );
            default = [ ];
          };
          "matchFields" = mkOption {
            description = "A list of node selector requirements by node's fields.";
            type = (
              types.listOf AcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchFieldModule
            );
            default = [ ];
          };
        };
      };
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTerm =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchFields" != [ ]) {
      "matchFields" =
        map
          mkAcmeSolverHttp01IngressPodTemplateSpecAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchField
          res."matchFields";
    }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityModule = types.submodule {
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.";
        type = (
          types.listOf AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.";
        type = (
          types.listOf AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
    };
  };
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinity =
    res:
    {
    }
    // optionalAttrs (res."preferredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "preferredDuringSchedulingIgnoredDuringExecution" =
        map
          mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecution
          res."preferredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    }
    // optionalAttrs (res."requiredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "requiredDuringSchedulingIgnoredDuringExecution" =
        map
          mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecution
          res."requiredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "podAffinityTerm" = mkOption {
            description = "Required. A pod affinity term, associated with the corresponding weight.";
            type =
              AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule;
          };
          "weight" = mkOption {
            description = "weight associated with matching the corresponding podAffinityTerm, in the range 1-100.";
            type = types.int;
          };
        };
      };
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecution =
    res: {
      "podAffinityTerm" =
        mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm
          res."podAffinityTerm";
      inherit (res) "weight";
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule =
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
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule
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
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.";
            type = (
              types.nullOr AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule
            );
            default = null;
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule
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
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaceSelector" != null) {
      "namespaceSelector" =
        mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule =
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
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule
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
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule =
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
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule
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
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.";
            type = (
              types.nullOr AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule
            );
            default = null;
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule
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
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecution =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaceSelector" != null) {
      "namespaceSelector" =
        mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule =
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
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule
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
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityModule = types.submodule {
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.";
        type = (
          types.listOf AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.";
        type = (
          types.listOf AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
    };
  };
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinity =
    res:
    {
    }
    // optionalAttrs (res."preferredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "preferredDuringSchedulingIgnoredDuringExecution" =
        map
          mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecution
          res."preferredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    }
    // optionalAttrs (res."requiredDuringSchedulingIgnoredDuringExecution" != [ ]) {
      "requiredDuringSchedulingIgnoredDuringExecution" =
        map
          mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecution
          res."requiredDuringSchedulingIgnoredDuringExecution";
    }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "podAffinityTerm" = mkOption {
            description = "Required. A pod affinity term, associated with the corresponding weight.";
            type =
              AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule;
          };
          "weight" = mkOption {
            description = "weight associated with matching the corresponding podAffinityTerm, in the range 1-100.";
            type = types.int;
          };
        };
      };
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecution =
    res: {
      "podAffinityTerm" =
        mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm
          res."podAffinityTerm";
      inherit (res) "weight";
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule =
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
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule
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
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.";
            type = (
              types.nullOr AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule
            );
            default = null;
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule
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
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTerm =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaceSelector" != null) {
      "namespaceSelector" =
        mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule =
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
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule
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
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule =
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
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule
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
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods.";
            type = (
              types.nullOr AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule
            );
            default = null;
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule
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
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecution =
    res:
    {
    }
    // optionalAttrs (res."labelSelector" != null) {
      "labelSelector" =
        mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelector
          res."labelSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaceSelector" != null) {
      "namespaceSelector" =
        mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector
          res."namespaceSelector";
    }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
      inherit (res) "topologyKey";
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule =
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
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule =
    types.submodule
      {
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf AcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule
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
  mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" =
        map
          mkAcmeSolverHttp01IngressPodTemplateSpecAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpression
          res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecImagePullSecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkAcmeSolverHttp01IngressPodTemplateSpecImagePullSecret =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecModule = types.submodule {
    options = {
      "affinity" = mkOption {
        description = "If specified, the pod's scheduling constraints";
        type = (types.nullOr AcmeSolverHttp01IngressPodTemplateSpecAffinityModule);
        default = null;
      };
      "imagePullSecrets" = mkOption {
        description = "If specified, the pod's imagePullSecrets";
        type = (types.listOf AcmeSolverHttp01IngressPodTemplateSpecImagePullSecretModule);
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
        type = (types.listOf AcmeSolverHttp01IngressPodTemplateSpecTolerationModule);
        default = [ ];
      };
    };
  };
  mkAcmeSolverHttp01IngressPodTemplateSpec =
    res:
    {
    }
    // optionalAttrs (res."affinity" != null) {
      "affinity" = mkAcmeSolverHttp01IngressPodTemplateSpecAffinity res."affinity";
    }
    // {
    }
    // optionalAttrs (res."imagePullSecrets" != [ ]) {
      "imagePullSecrets" =
        map mkAcmeSolverHttp01IngressPodTemplateSpecImagePullSecret
          res."imagePullSecrets";
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
      "tolerations" = map mkAcmeSolverHttp01IngressPodTemplateSpecToleration res."tolerations";
    }
    // {
    };
  AcmeSolverHttp01IngressPodTemplateSpecTolerationModule = types.submodule {
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
  mkAcmeSolverHttp01IngressPodTemplateSpecToleration =
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
  AcmeSolverHttp01Module = types.submodule {
    options = {
      "gatewayHTTPRoute" = mkOption {
        description = "The Gateway API is a sig-network community API that models service networking in Kubernetes (https://gateway-api.sigs.k8s.io/). The Gateway solver will create HTTPRoutes with the specified labels in the same namespace as the challenge. This solver is experimental, and fields / behaviour may change in the future.";
        type = (types.nullOr AcmeSolverHttp01GatewayHTTPRouteModule);
        default = null;
      };
      "ingress" = mkOption {
        description = "The ingress based HTTP01 challenge solver will solve challenges by creating or modifying Ingress resources in order to route requests for '/.well-known/acme-challenge/XYZ' to 'challenge solver' pods that are provisioned by cert-manager for each Challenge to be completed.";
        type = (types.nullOr AcmeSolverHttp01IngressModule);
        default = null;
      };
    };
  };
  mkAcmeSolverHttp01 =
    res:
    {
    }
    // optionalAttrs (res."gatewayHTTPRoute" != null) {
      "gatewayHTTPRoute" = mkAcmeSolverHttp01GatewayHTTPRoute res."gatewayHTTPRoute";
    }
    // {
    }
    // optionalAttrs (res."ingress" != null) { "ingress" = mkAcmeSolverHttp01Ingress res."ingress"; }
    // {
    };
  AcmeSolverModule = types.submodule {
    options = {
      "dns01" = mkOption {
        description = "Configures cert-manager to attempt to complete authorizations by performing the DNS01 challenge flow.";
        type = (types.nullOr AcmeSolverDns01Module);
        default = null;
      };
      "http01" = mkOption {
        description = "Configures cert-manager to attempt to complete authorizations by performing the HTTP01 challenge flow. It is not possible to obtain certificates for wildcard domain names (e.g. `*.example.com`) using the HTTP01 challenge mechanism.";
        type = (types.nullOr AcmeSolverHttp01Module);
        default = null;
      };
      "selector" = mkOption {
        description = "Selector selects a set of DNSNames on the Certificate resource that should be solved using this challenge solver. If not specified, the solver will be treated as the 'default' solver with the lowest priority, i.e. if any other solver has a more specific match, it will be used instead.";
        type = (types.nullOr AcmeSolverSelectorModule);
        default = null;
      };
    };
  };
  mkAcmeSolver =
    res:
    {
    }
    // optionalAttrs (res."dns01" != null) { "dns01" = mkAcmeSolverDns01 res."dns01"; }
    // {
    }
    // optionalAttrs (res."http01" != null) { "http01" = mkAcmeSolverHttp01 res."http01"; }
    // {
    }
    // optionalAttrs (res."selector" != null) { "selector" = mkAcmeSolverSelector res."selector"; }
    // {
    };
  AcmeSolverSelectorModule = types.submodule {
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
  mkAcmeSolverSelector =
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
  CaModule = types.submodule {
    options = {
      "crlDistributionPoints" = mkOption {
        description = "The CRL distribution points is an X.509 v3 certificate extension which identifies the location of the CRL from which the revocation of this certificate can be checked. If not set, certificates will be issued without distribution points set.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "ocspServers" = mkOption {
        description = "The OCSP server list is an X.509 v3 extension that defines a list of URLs of OCSP responders. The OCSP responders can be queried for the revocation status of an issued certificate. If not set, the certificate will be issued with no OCSP servers set. For example, an OCSP server URL could be \"http://ocsp.int-x3.letsencrypt.org\".";
        type = (types.listOf types.str);
        default = [ ];
      };
      "secretName" = mkOption {
        description = "SecretName is the name of the secret used to sign Certificates issued by this Issuer.";
        type = types.str;
      };
    };
  };
  mkCa =
    res:
    {
    }
    // optionalAttrs (res."crlDistributionPoints" != [ ]) { inherit (res) "crlDistributionPoints"; }
    // {
    }
    // optionalAttrs (res."ocspServers" != [ ]) { inherit (res) "ocspServers"; }
    // {
      inherit (res) "secretName";
    };
  SelfSignedModule = types.submodule {
    options = {
      "crlDistributionPoints" = mkOption {
        description = "The CRL distribution points is an X.509 v3 certificate extension which identifies the location of the CRL from which the revocation of this certificate can be checked. If not set certificate will be issued without CDP. Values are strings.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkSelfSigned =
    res:
    {
    }
    // optionalAttrs (res."crlDistributionPoints" != [ ]) { inherit (res) "crlDistributionPoints"; }
    // {
    };
  VaultAuthAppRoleModule = types.submodule {
    options = {
      "path" = mkOption {
        description = "Path where the App Role authentication backend is mounted in Vault, e.g: \"approle\"";
        type = types.str;
      };
      "roleId" = mkOption {
        description = "RoleID configured in the App Role authentication backend when setting up the authentication backend in Vault.";
        type = types.str;
      };
      "secretRef" = mkOption {
        description = "Reference to a key in a Secret that contains the App Role secret used to authenticate with Vault. The `key` field must be specified and denotes which entry within the Secret resource is used as the app role secret.";
        type = VaultAuthAppRoleSecretRefModule;
      };
    };
  };
  mkVaultAuthAppRole = res: {
    inherit (res) "path";
    inherit (res) "roleId";
    "secretRef" = mkVaultAuthAppRoleSecretRef res."secretRef";
  };
  VaultAuthAppRoleSecretRefModule = types.submodule {
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
  mkVaultAuthAppRoleSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  VaultAuthKubernetesModule = types.submodule {
    options = {
      "mountPath" = mkOption {
        description = "The Vault mountPath here is the mount path to use when authenticating with Vault. For example, setting a value to `/v1/auth/foo`, will use the path `/v1/auth/foo/login` to authenticate with Vault. If unspecified, the default value \"/v1/auth/kubernetes\" will be used.";
        type = (types.nullOr types.str);
        default = null;
      };
      "role" = mkOption {
        description = "A required field containing the Vault Role to assume. A Role binds a Kubernetes ServiceAccount with a set of Vault policies.";
        type = types.str;
      };
      "secretRef" = mkOption {
        description = "The required Secret field containing a Kubernetes ServiceAccount JWT used for authenticating with Vault. Use of 'ambient credentials' is not supported.";
        type = (types.nullOr VaultAuthKubernetesSecretRefModule);
        default = null;
      };
      "serviceAccountRef" = mkOption {
        description = "A reference to a service account that will be used to request a bound token (also known as \"projected token\"). Compared to using \"secretRef\", using this field means that you don't rely on statically bound tokens. To use this field, you must configure an RBAC rule to let cert-manager request a token.";
        type = (types.nullOr VaultAuthKubernetesServiceAccountRefModule);
        default = null;
      };
    };
  };
  mkVaultAuthKubernetes =
    res:
    {
    }
    // optionalAttrs (res."mountPath" != null) { inherit (res) "mountPath"; }
    // {
      inherit (res) "role";
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkVaultAuthKubernetesSecretRef res."secretRef";
    }
    // {
    }
    // optionalAttrs (res."serviceAccountRef" != null) {
      "serviceAccountRef" = mkVaultAuthKubernetesServiceAccountRef res."serviceAccountRef";
    }
    // {
    };
  VaultAuthKubernetesSecretRefModule = types.submodule {
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
  mkVaultAuthKubernetesSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  VaultAuthKubernetesServiceAccountRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the ServiceAccount used to request a token.";
        type = types.str;
      };
    };
  };
  mkVaultAuthKubernetesServiceAccountRef = res: {
    inherit (res) "name";
  };
  VaultAuthModule = types.submodule {
    options = {
      "appRole" = mkOption {
        description = "AppRole authenticates with Vault using the App Role auth mechanism, with the role and secret stored in a Kubernetes Secret resource.";
        type = (types.nullOr VaultAuthAppRoleModule);
        default = null;
      };
      "kubernetes" = mkOption {
        description = "Kubernetes authenticates with Vault by passing the ServiceAccount token stored in the named Secret resource to the Vault server.";
        type = (types.nullOr VaultAuthKubernetesModule);
        default = null;
      };
      "tokenSecretRef" = mkOption {
        description = "TokenSecretRef authenticates with Vault by presenting a token.";
        type = (types.nullOr VaultAuthTokenSecretRefModule);
        default = null;
      };
    };
  };
  mkVaultAuth =
    res:
    {
    }
    // optionalAttrs (res."appRole" != null) { "appRole" = mkVaultAuthAppRole res."appRole"; }
    // {
    }
    // optionalAttrs (res."kubernetes" != null) {
      "kubernetes" = mkVaultAuthKubernetes res."kubernetes";
    }
    // {
    }
    // optionalAttrs (res."tokenSecretRef" != null) {
      "tokenSecretRef" = mkVaultAuthTokenSecretRef res."tokenSecretRef";
    }
    // {
    };
  VaultAuthTokenSecretRefModule = types.submodule {
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
  mkVaultAuthTokenSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  VaultCaBundleSecretRefModule = types.submodule {
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
  mkVaultCaBundleSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  VaultModule = types.submodule {
    options = {
      "auth" = mkOption {
        description = "Auth configures how cert-manager authenticates with the Vault server.";
        type = VaultAuthModule;
      };
      "caBundle" = mkOption {
        description = "Base64-encoded bundle of PEM CAs which will be used to validate the certificate chain presented by Vault. Only used if using HTTPS to connect to Vault and ignored for HTTP connections. Mutually exclusive with CABundleSecretRef. If neither CABundle nor CABundleSecretRef are defined, the certificate bundle in the cert-manager controller container is used to validate the TLS connection.";
        type = (types.nullOr types.str);
        default = null;
      };
      "caBundleSecretRef" = mkOption {
        description = "Reference to a Secret containing a bundle of PEM-encoded CAs to use when verifying the certificate chain presented by Vault when using HTTPS. Mutually exclusive with CABundle. If neither CABundle nor CABundleSecretRef are defined, the certificate bundle in the cert-manager controller container is used to validate the TLS connection. If no key for the Secret is specified, cert-manager will default to 'ca.crt'.";
        type = (types.nullOr VaultCaBundleSecretRefModule);
        default = null;
      };
      "namespace" = mkOption {
        description = "Name of the vault namespace. Namespaces is a set of features within Vault Enterprise that allows Vault environments to support Secure Multi-tenancy. e.g: \"ns1\" More about namespaces can be found here https://www.vaultproject.io/docs/enterprise/namespaces";
        type = (types.nullOr types.str);
        default = null;
      };
      "path" = mkOption {
        description = "Path is the mount path of the Vault PKI backend's `sign` endpoint, e.g: \"my_pki_mount/sign/my-role-name\".";
        type = types.str;
      };
      "server" = mkOption {
        description = "Server is the connection address for the Vault server, e.g: \"https://vault.example.com:8200\".";
        type = types.str;
      };
    };
  };
  mkVault =
    res:
    {
      "auth" = mkVaultAuth res."auth";
    }
    // optionalAttrs (res."caBundle" != null) { inherit (res) "caBundle"; }
    // {
    }
    // optionalAttrs (res."caBundleSecretRef" != null) {
      "caBundleSecretRef" = mkVaultCaBundleSecretRef res."caBundleSecretRef";
    }
    // {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
      inherit (res) "path";
      inherit (res) "server";
    };
  VenafiCloudApiTokenSecretRefModule = types.submodule {
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
  mkVenafiCloudApiTokenSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  VenafiCloudModule = types.submodule {
    options = {
      "apiTokenSecretRef" = mkOption {
        description = "APITokenSecretRef is a secret key selector for the Venafi Cloud API token.";
        type = VenafiCloudApiTokenSecretRefModule;
      };
      "url" = mkOption {
        description = "URL is the base URL for Venafi Cloud. Defaults to \"https://api.venafi.cloud/v1\".";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkVenafiCloud =
    res:
    {
      "apiTokenSecretRef" = mkVenafiCloudApiTokenSecretRef res."apiTokenSecretRef";
    }
    // optionalAttrs (res."url" != null) { inherit (res) "url"; }
    // {
    };
  VenafiModule = types.submodule {
    options = {
      "cloud" = mkOption {
        description = "Cloud specifies the Venafi cloud configuration settings. Only one of TPP or Cloud may be specified.";
        type = (types.nullOr VenafiCloudModule);
        default = null;
      };
      "tpp" = mkOption {
        description = "TPP specifies Trust Protection Platform configuration settings. Only one of TPP or Cloud may be specified.";
        type = (types.nullOr VenafiTppModule);
        default = null;
      };
      "zone" = mkOption {
        description = "Zone is the Venafi Policy Zone to use for this issuer. All requests made to the Venafi platform will be restricted by the named zone policy. This field is required.";
        type = types.str;
      };
    };
  };
  mkVenafi =
    res:
    {
    }
    // optionalAttrs (res."cloud" != null) { "cloud" = mkVenafiCloud res."cloud"; }
    // {
    }
    // optionalAttrs (res."tpp" != null) { "tpp" = mkVenafiTpp res."tpp"; }
    // {
      inherit (res) "zone";
    };
  VenafiTppCredentialsRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the resource being referred to. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = types.str;
      };
    };
  };
  mkVenafiTppCredentialsRef = res: {
    inherit (res) "name";
  };
  VenafiTppModule = types.submodule {
    options = {
      "caBundle" = mkOption {
        description = "Base64-encoded bundle of PEM CAs which will be used to validate the certificate chain presented by the TPP server. Only used if using HTTPS; ignored for HTTP. If undefined, the certificate bundle in the cert-manager controller container is used to validate the chain.";
        type = (types.nullOr types.str);
        default = null;
      };
      "credentialsRef" = mkOption {
        description = "CredentialsRef is a reference to a Secret containing the username and password for the TPP server. The secret must contain two keys, 'username' and 'password'.";
        type = VenafiTppCredentialsRefModule;
      };
      "url" = mkOption {
        description = "URL is the base URL for the vedsdk endpoint of the Venafi TPP instance, for example: \"https://tpp.example.com/vedsdk\".";
        type = types.str;
      };
    };
  };
  mkVenafiTpp =
    res:
    {
    }
    // optionalAttrs (res."caBundle" != null) { inherit (res) "caBundle"; }
    // {
      "credentialsRef" = mkVenafiTppCredentialsRef res."credentialsRef";
      inherit (res) "url";
    };
  IssuersModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this Issuer resource.";
        };
        "acme" = mkOption {
          description = "ACME configures this issuer to communicate with a RFC8555 (ACME) server to obtain signed x509 certificates.";
          type = (types.nullOr AcmeModule);
          default = null;
        };
        "ca" = mkOption {
          description = "CA configures this issuer to sign certificates using a signing CA keypair stored in a Secret resource. This is used to build internal PKIs that are managed by cert-manager.";
          type = (types.nullOr CaModule);
          default = null;
        };
        "selfSigned" = mkOption {
          description = "SelfSigned configures this issuer to 'self sign' certificates using the private key used to create the CertificateRequest object.";
          type = (types.nullOr SelfSignedModule);
          default = null;
        };
        "vault" = mkOption {
          description = "Vault configures this issuer to sign certificates using a HashiCorp Vault PKI backend.";
          type = (types.nullOr VaultModule);
          default = null;
        };
        "venafi" = mkOption {
          description = "Venafi configures this issuer to sign certificates using a Venafi TPP or Venafi Cloud policy zone.";
          type = (types.nullOr VenafiModule);
          default = null;
        };
      };
    }
  );
  mkIssuer = name: res: {
    apiVersion = "cert-manager.io/v1";
    kind = "Issuer";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."acme" != null) { "acme" = mkAcme res."acme"; }
    // {
    }
    // optionalAttrs (res."ca" != null) { "ca" = mkCa res."ca"; }
    // {
    }
    // optionalAttrs (res."selfSigned" != null) { "selfSigned" = mkSelfSigned res."selfSigned"; }
    // {
    }
    // optionalAttrs (res."vault" != null) { "vault" = mkVault res."vault"; }
    // {
    }
    // optionalAttrs (res."venafi" != null) { "venafi" = mkVenafi res."venafi"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkIssuer cfg."issuers");
in
{
  options.openkrill.apps."cert-manager" = {
    "issuers" = mkOption {
      type = types.attrsOf IssuersModule;
      default = { };
      description = "Issuer CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."cert-manager".content = allResources;
  };
}
