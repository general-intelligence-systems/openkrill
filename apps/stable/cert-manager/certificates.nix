# Auto-generated openkrill module fragment for cert-manager
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."cert-manager";
  compact = filterAttrs (_: v: v != null);
  AdditionalOutputFormatModule = types.submodule {
    options = {
      "type" = mkOption {
        description = "Type is the name of the format type that should be written to the Certificate's target Secret.";
        type = (
          types.enum [
            "DER"
            "CombinedPEM"
          ]
        );
      };
    };
  };
  mkAdditionalOutputFormat = res: {
    inherit (res) "type";
  };
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
  KeystoresJksModule = types.submodule {
    options = {
      "create" = mkOption {
        description = "Create enables JKS keystore creation for the Certificate. If true, a file named `keystore.jks` will be created in the target Secret resource, encrypted using the password stored in `passwordSecretRef`. The keystore file will be updated immediately. If the issuer provided a CA certificate, a file named `truststore.jks` will also be created in the target Secret resource, encrypted using the password stored in `passwordSecretRef` containing the issuing Certificate Authority";
        type = types.bool;
      };
      "passwordSecretRef" = mkOption {
        description = "PasswordSecretRef is a reference to a key in a Secret resource containing the password used to encrypt the JKS keystore.";
        type = KeystoresJksPasswordSecretRefModule;
      };
    };
  };
  mkKeystoresJks = res: {
    inherit (res) "create";
    "passwordSecretRef" = mkKeystoresJksPasswordSecretRef res."passwordSecretRef";
  };
  KeystoresJksPasswordSecretRefModule = types.submodule {
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
  mkKeystoresJksPasswordSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  KeystoresModule = types.submodule {
    options = {
      "jks" = mkOption {
        description = "JKS configures options for storing a JKS keystore in the `spec.secretName` Secret resource.";
        type = (types.nullOr KeystoresJksModule);
        default = null;
      };
      "pkcs12" = mkOption {
        description = "PKCS12 configures options for storing a PKCS12 keystore in the `spec.secretName` Secret resource.";
        type = (types.nullOr KeystoresPkcs12Module);
        default = null;
      };
    };
  };
  mkKeystores =
    res:
    {
    }
    // optionalAttrs (res."jks" != null) { "jks" = mkKeystoresJks res."jks"; }
    // {
    }
    // optionalAttrs (res."pkcs12" != null) { "pkcs12" = mkKeystoresPkcs12 res."pkcs12"; }
    // {
    };
  KeystoresPkcs12Module = types.submodule {
    options = {
      "create" = mkOption {
        description = "Create enables PKCS12 keystore creation for the Certificate. If true, a file named `keystore.p12` will be created in the target Secret resource, encrypted using the password stored in `passwordSecretRef`. The keystore file will be updated immediately. If the issuer provided a CA certificate, a file named `truststore.p12` will also be created in the target Secret resource, encrypted using the password stored in `passwordSecretRef` containing the issuing Certificate Authority";
        type = types.bool;
      };
      "passwordSecretRef" = mkOption {
        description = "PasswordSecretRef is a reference to a key in a Secret resource containing the password used to encrypt the PKCS12 keystore.";
        type = KeystoresPkcs12PasswordSecretRefModule;
      };
    };
  };
  mkKeystoresPkcs12 = res: {
    inherit (res) "create";
    "passwordSecretRef" = mkKeystoresPkcs12PasswordSecretRef res."passwordSecretRef";
  };
  KeystoresPkcs12PasswordSecretRefModule = types.submodule {
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
  mkKeystoresPkcs12PasswordSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  PrivateKeyModule = types.submodule {
    options = {
      "algorithm" = mkOption {
        description = "Algorithm is the private key algorithm of the corresponding private key for this certificate. If provided, allowed values are either `RSA`,`Ed25519` or `ECDSA` If `algorithm` is specified and `size` is not provided, key size of 256 will be used for `ECDSA` key algorithm and key size of 2048 will be used for `RSA` key algorithm. key size is ignored when using the `Ed25519` key algorithm.";
        type = (
          types.nullOr (
            types.enum [
              "RSA"
              "ECDSA"
              "Ed25519"
            ]
          )
        );
        default = null;
      };
      "encoding" = mkOption {
        description = "The private key cryptography standards (PKCS) encoding for this certificate's private key to be encoded in. If provided, allowed values are `PKCS1` and `PKCS8` standing for PKCS#1 and PKCS#8, respectively. Defaults to `PKCS1` if not specified.";
        type = (
          types.nullOr (
            types.enum [
              "PKCS1"
              "PKCS8"
            ]
          )
        );
        default = null;
      };
      "rotationPolicy" = mkOption {
        description = "RotationPolicy controls how private keys should be regenerated when a re-issuance is being processed. If set to Never, a private key will only be generated if one does not already exist in the target `spec.secretName`. If one does exists but it does not have the correct algorithm or size, a warning will be raised to await user intervention. If set to Always, a private key matching the specified requirements will be generated whenever a re-issuance occurs. Default is 'Never' for backward compatibility.";
        type = (
          types.nullOr (
            types.enum [
              "Never"
              "Always"
            ]
          )
        );
        default = null;
      };
      "size" = mkOption {
        description = "Size is the key bit size of the corresponding private key for this certificate. If `algorithm` is set to `RSA`, valid values are `2048`, `4096` or `8192`, and will default to `2048` if not specified. If `algorithm` is set to `ECDSA`, valid values are `256`, `384` or `521`, and will default to `256` if not specified. If `algorithm` is set to `Ed25519`, Size is ignored. No other values are allowed.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkPrivateKey =
    res:
    {
    }
    // optionalAttrs (res."algorithm" != null) { inherit (res) "algorithm"; }
    // {
    }
    // optionalAttrs (res."encoding" != null) { inherit (res) "encoding"; }
    // {
    }
    // optionalAttrs (res."rotationPolicy" != null) { inherit (res) "rotationPolicy"; }
    // {
    }
    // optionalAttrs (res."size" != null) { inherit (res) "size"; }
    // {
    };
  SecretTemplateModule = types.submodule {
    options = {
      "annotations" = mkOption {
        description = "Annotations is a key value map to be copied to the target Kubernetes Secret.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "labels" = mkOption {
        description = "Labels is a key value map to be copied to the target Kubernetes Secret.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkSecretTemplate =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    };
  SubjectModule = types.submodule {
    options = {
      "countries" = mkOption {
        description = "Countries to be used on the Certificate.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "localities" = mkOption {
        description = "Cities to be used on the Certificate.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "organizationalUnits" = mkOption {
        description = "Organizational Units to be used on the Certificate.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "organizations" = mkOption {
        description = "Organizations to be used on the Certificate.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "postalCodes" = mkOption {
        description = "Postal codes to be used on the Certificate.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "provinces" = mkOption {
        description = "State/Provinces to be used on the Certificate.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "serialNumber" = mkOption {
        description = "Serial number to be used on the Certificate.";
        type = (types.nullOr types.str);
        default = null;
      };
      "streetAddresses" = mkOption {
        description = "Street addresses to be used on the Certificate.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkSubject =
    res:
    {
    }
    // optionalAttrs (res."countries" != [ ]) { inherit (res) "countries"; }
    // {
    }
    // optionalAttrs (res."localities" != [ ]) { inherit (res) "localities"; }
    // {
    }
    // optionalAttrs (res."organizationalUnits" != [ ]) { inherit (res) "organizationalUnits"; }
    // {
    }
    // optionalAttrs (res."organizations" != [ ]) { inherit (res) "organizations"; }
    // {
    }
    // optionalAttrs (res."postalCodes" != [ ]) { inherit (res) "postalCodes"; }
    // {
    }
    // optionalAttrs (res."provinces" != [ ]) { inherit (res) "provinces"; }
    // {
    }
    // optionalAttrs (res."serialNumber" != null) { inherit (res) "serialNumber"; }
    // {
    }
    // optionalAttrs (res."streetAddresses" != [ ]) { inherit (res) "streetAddresses"; }
    // {
    };
  CertificatesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this Certificate resource.";
        };
        "additionalOutputFormats" = mkOption {
          description = "AdditionalOutputFormats defines extra output formats of the private key and signed certificate chain to be written to this Certificate's target Secret. This is an Alpha Feature and is only enabled with the `--feature-gates=AdditionalCertificateOutputFormats=true` option on both the controller and webhook components.";
          type = (types.listOf AdditionalOutputFormatModule);
          default = [ ];
        };
        "commonName" = mkOption {
          description = "CommonName is a common name to be used on the Certificate. The CommonName should have a length of 64 characters or fewer to avoid generating invalid CSRs. This value is ignored by TLS clients when any subject alt name is set. This is x509 behaviour: https://tools.ietf.org/html/rfc6125#section-6.4.4";
          type = (types.nullOr types.str);
          default = null;
        };
        "dnsNames" = mkOption {
          description = "DNSNames is a list of DNS subjectAltNames to be set on the Certificate.";
          type = (types.listOf types.str);
          default = [ ];
        };
        "duration" = mkOption {
          description = "The requested 'duration' (i.e. lifetime) of the Certificate. This option may be ignored/overridden by some issuer types. If unset this defaults to 90 days. Certificate will be renewed either 2/3 through its duration or `renewBefore` period before its expiry, whichever is later. Minimum accepted duration is 1 hour. Value must be in units accepted by Go time.ParseDuration https://golang.org/pkg/time/#ParseDuration";
          type = (types.nullOr types.str);
          default = null;
        };
        "emailAddresses" = mkOption {
          description = "EmailAddresses is a list of email subjectAltNames to be set on the Certificate.";
          type = (types.listOf types.str);
          default = [ ];
        };
        "encodeUsagesInRequest" = mkOption {
          description = "EncodeUsagesInRequest controls whether key usages should be present in the CertificateRequest";
          type = types.bool;
          default = false;
        };
        "ipAddresses" = mkOption {
          description = "IPAddresses is a list of IP address subjectAltNames to be set on the Certificate.";
          type = (types.listOf types.str);
          default = [ ];
        };
        "isCA" = mkOption {
          description = "IsCA will mark this Certificate as valid for certificate signing. This will automatically add the `cert sign` usage to the list of `usages`.";
          type = types.bool;
          default = false;
        };
        "issuerRef" = mkOption {
          description = "IssuerRef is a reference to the issuer for this certificate. If the `kind` field is not set, or set to `Issuer`, an Issuer resource with the given name in the same namespace as the Certificate will be used. If the `kind` field is set to `ClusterIssuer`, a ClusterIssuer with the provided name will be used. The `name` field in this stanza is required at all times.";
          type = IssuerRefModule;
        };
        "keystores" = mkOption {
          description = "Keystores configures additional keystore output formats stored in the `secretName` Secret resource.";
          type = (types.nullOr KeystoresModule);
          default = null;
        };
        "literalSubject" = mkOption {
          description = "LiteralSubject is an LDAP formatted string that represents the [X.509 Subject field](https://datatracker.ietf.org/doc/html/rfc5280#section-4.1.2.6). Use this *instead* of the Subject field if you need to ensure the correct ordering of the RDN sequence, such as when issuing certs for LDAP authentication. See https://github.com/cert-manager/cert-manager/issues/3203, https://github.com/cert-manager/cert-manager/issues/4424. This field is alpha level and is only supported by cert-manager installations where LiteralCertificateSubject feature gate is enabled on both cert-manager controller and webhook.";
          type = (types.nullOr types.str);
          default = null;
        };
        "privateKey" = mkOption {
          description = "Options to control private keys used for the Certificate.";
          type = (types.nullOr PrivateKeyModule);
          default = null;
        };
        "renewBefore" = mkOption {
          description = "How long before the currently issued certificate's expiry cert-manager should renew the certificate. The default is 2/3 of the issued certificate's duration. Minimum accepted value is 5 minutes. Value must be in units accepted by Go time.ParseDuration https://golang.org/pkg/time/#ParseDuration";
          type = (types.nullOr types.str);
          default = null;
        };
        "revisionHistoryLimit" = mkOption {
          description = "revisionHistoryLimit is the maximum number of CertificateRequest revisions that are maintained in the Certificate's history. Each revision represents a single `CertificateRequest` created by this Certificate, either when it was created, renewed, or Spec was changed. Revisions will be removed by oldest first if the number of revisions exceeds this number. If set, revisionHistoryLimit must be a value of `1` or greater. If unset (`nil`), revisions will not be garbage collected. Default value is `nil`.";
          type = (types.nullOr types.int);
          default = null;
        };
        "secretName" = mkOption {
          description = "SecretName is the name of the secret resource that will be automatically created and managed by this Certificate resource. It will be populated with a private key and certificate, signed by the denoted issuer.";
          type = types.str;
        };
        "secretTemplate" = mkOption {
          description = "SecretTemplate defines annotations and labels to be copied to the Certificate's Secret. Labels and annotations on the Secret will be changed as they appear on the SecretTemplate when added or removed. SecretTemplate annotations are added in conjunction with, and cannot overwrite, the base set of annotations cert-manager sets on the Certificate's Secret.";
          type = (types.nullOr SecretTemplateModule);
          default = null;
        };
        "subject" = mkOption {
          description = "Full X509 name specification (https://golang.org/pkg/crypto/x509/pkix/#Name).";
          type = (types.nullOr SubjectModule);
          default = null;
        };
        "uris" = mkOption {
          description = "URIs is a list of URI subjectAltNames to be set on the Certificate.";
          type = (types.listOf types.str);
          default = [ ];
        };
        "usages" = mkOption {
          description = "Usages is the set of x509 usages that are requested for the certificate. Defaults to `digital signature` and `key encipherment` if not specified.";
          type = (
            types.listOf (
              types.enum [
                "signing"
                "digital signature"
                "content commitment"
                "key encipherment"
                "key agreement"
                "data encipherment"
                "cert sign"
                "crl sign"
                "encipher only"
                "decipher only"
                "any"
                "server auth"
                "client auth"
                "code signing"
                "email protection"
                "s/mime"
                "ipsec end system"
                "ipsec tunnel"
                "ipsec user"
                "timestamping"
                "ocsp signing"
                "microsoft sgc"
                "netscape sgc"
              ]
            )
          );
          default = [ ];
        };
      };
    }
  );
  mkCertificate = name: res: {
    apiVersion = "cert-manager.io/v1";
    kind = "Certificate";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."additionalOutputFormats" != [ ]) {
      "additionalOutputFormats" = map mkAdditionalOutputFormat res."additionalOutputFormats";
    }
    // {
    }
    // optionalAttrs (res."commonName" != null) { inherit (res) "commonName"; }
    // {
    }
    // optionalAttrs (res."dnsNames" != [ ]) { inherit (res) "dnsNames"; }
    // {
    }
    // optionalAttrs (res."duration" != null) { inherit (res) "duration"; }
    // {
    }
    // optionalAttrs (res."emailAddresses" != [ ]) { inherit (res) "emailAddresses"; }
    // {
    }
    // optionalAttrs res."encodeUsagesInRequest" { inherit (res) "encodeUsagesInRequest"; }
    // {
    }
    // optionalAttrs (res."ipAddresses" != [ ]) { inherit (res) "ipAddresses"; }
    // {
    }
    // optionalAttrs res."isCA" { inherit (res) "isCA"; }
    // {
      "issuerRef" = mkIssuerRef res."issuerRef";
    }
    // optionalAttrs (res."keystores" != null) { "keystores" = mkKeystores res."keystores"; }
    // {
    }
    // optionalAttrs (res."literalSubject" != null) { inherit (res) "literalSubject"; }
    // {
    }
    // optionalAttrs (res."privateKey" != null) { "privateKey" = mkPrivateKey res."privateKey"; }
    // {
    }
    // optionalAttrs (res."renewBefore" != null) { inherit (res) "renewBefore"; }
    // {
    }
    // optionalAttrs (res."revisionHistoryLimit" != null) { inherit (res) "revisionHistoryLimit"; }
    // {
      inherit (res) "secretName";
    }
    // optionalAttrs (res."secretTemplate" != null) {
      "secretTemplate" = mkSecretTemplate res."secretTemplate";
    }
    // {
    }
    // optionalAttrs (res."subject" != null) { "subject" = mkSubject res."subject"; }
    // {
    }
    // optionalAttrs (res."uris" != [ ]) { inherit (res) "uris"; }
    // {
    }
    // optionalAttrs (res."usages" != [ ]) { inherit (res) "usages"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkCertificate cfg."certificates");
in
{
  options.openkrill.apps."cert-manager" = {
    "certificates" = mkOption {
      type = types.attrsOf CertificatesModule;
      default = { };
      description = "Certificate CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."cert-manager".content = allResources;
  };
}
