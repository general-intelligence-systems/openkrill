# Auto-generated openkrill module fragment for flux
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."flux";
  compact = filterAttrs (_: v: v != null);
  CertSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkCertSecretRef = res: {
    inherit (res) "name";
  };
  LayerSelectorModule = types.submodule {
    options = {
      "mediaType" = mkOption {
        description = "MediaType specifies the OCI media type of the layer\nwhich should be extracted from the OCI Artifact. The\nfirst layer matching this type is selected.";
        type = (types.nullOr types.str);
        default = null;
      };
      "operation" = mkOption {
        description = "Operation specifies how the selected layer should be processed.\nBy default, the layer compressed content is extracted to storage.\nWhen the operation is set to 'copy', the layer compressed content\nis persisted to storage as it is.";
        type = (
          types.nullOr (
            types.enum [
              "extract"
              "copy"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkLayerSelector =
    res:
    {
    }
    // optionalAttrs (res."mediaType" != null) { inherit (res) "mediaType"; }
    // {
    }
    // optionalAttrs (res."operation" != null) { inherit (res) "operation"; }
    // {
    };
  ProxySecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkProxySecretRef = res: {
    inherit (res) "name";
  };
  RefModule = types.submodule {
    options = {
      "digest" = mkOption {
        description = "Digest is the image digest to pull, takes precedence over SemVer.\nThe value should be in the format 'sha256:<HASH>'.";
        type = (types.nullOr types.str);
        default = null;
      };
      "semver" = mkOption {
        description = "SemVer is the range of tags to pull selecting the latest within\nthe range, takes precedence over Tag.";
        type = (types.nullOr types.str);
        default = null;
      };
      "semverFilter" = mkOption {
        description = "SemverFilter is a regex pattern to filter the tags within the SemVer range.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tag" = mkOption {
        description = "Tag is the image tag to pull, defaults to latest.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkRef =
    res:
    {
    }
    // optionalAttrs (res."digest" != null) { inherit (res) "digest"; }
    // {
    }
    // optionalAttrs (res."semver" != null) { inherit (res) "semver"; }
    // {
    }
    // optionalAttrs (res."semverFilter" != null) { inherit (res) "semverFilter"; }
    // {
    }
    // optionalAttrs (res."tag" != null) { inherit (res) "tag"; }
    // {
    };
  SecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkSecretRef = res: {
    inherit (res) "name";
  };
  VerifyMatchOIDCIdentityModule = types.submodule {
    options = {
      "issuer" = mkOption {
        description = "Issuer specifies the regex pattern to match against to verify\nthe OIDC issuer in the Fulcio certificate. The pattern must be a\nvalid Go regular expression.";
        type = types.str;
      };
      "subject" = mkOption {
        description = "Subject specifies the regex pattern to match against to verify\nthe identity subject in the Fulcio certificate. The pattern must\nbe a valid Go regular expression.";
        type = types.str;
      };
    };
  };
  mkVerifyMatchOIDCIdentity = res: {
    inherit (res) "issuer";
    inherit (res) "subject";
  };
  VerifyModule = types.submodule {
    options = {
      "matchOIDCIdentity" = mkOption {
        description = "MatchOIDCIdentity specifies the identity matching criteria to use\nwhile verifying an OCI artifact which was signed using Cosign keyless\nsigning. The artifact's identity is deemed to be verified if any of the\nspecified matchers match against the identity.";
        type = (types.listOf VerifyMatchOIDCIdentityModule);
        default = [ ];
      };
      "provider" = mkOption {
        description = "Provider specifies the technology used to sign the OCI Artifact.";
        type = (
          types.enum [
            "cosign"
            "notation"
          ]
        );
      };
      "secretRef" = mkOption {
        description = "SecretRef specifies the Kubernetes Secret containing the\ntrusted public keys.";
        type = (types.nullOr VerifySecretRefModule);
        default = null;
      };
    };
  };
  mkVerify =
    res:
    {
    }
    // optionalAttrs (res."matchOIDCIdentity" != [ ]) {
      "matchOIDCIdentity" = map mkVerifyMatchOIDCIdentity res."matchOIDCIdentity";
    }
    // {
      inherit (res) "provider";
    }
    // optionalAttrs (res."secretRef" != null) { "secretRef" = mkVerifySecretRef res."secretRef"; }
    // {
    };
  VerifySecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkVerifySecretRef = res: {
    inherit (res) "name";
  };
  OcirepositoriesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this OCIRepository resource.";
        };
        "certSecretRef" = mkOption {
          description = "CertSecretRef can be given the name of a Secret containing\neither or both of\n\n- a PEM-encoded client certificate (`tls.crt`) and private\nkey (`tls.key`);\n- a PEM-encoded CA certificate (`ca.crt`)\n\nand whichever are supplied, will be used for connecting to the\nregistry. The client cert and key are useful if you are\nauthenticating with a certificate; the CA cert is useful if\nyou are using a self-signed server certificate. The Secret must\nbe of type `Opaque` or `kubernetes.io/tls`.";
          type = (types.nullOr CertSecretRefModule);
          default = null;
        };
        "ignore" = mkOption {
          description = "Ignore overrides the set of excluded patterns in the .sourceignore format\n(which is the same as .gitignore). If not provided, a default will be used,\nconsult the documentation for your version to find out what those are.";
          type = (types.nullOr types.str);
          default = null;
        };
        "insecure" = mkOption {
          description = "Insecure allows connecting to a non-TLS HTTP container registry.";
          type = types.bool;
          default = false;
        };
        "interval" = mkOption {
          description = "Interval at which the OCIRepository URL is checked for updates.\nThis interval is approximate and may be subject to jitter to ensure\nefficient use of resources.";
          type = types.str;
        };
        "layerSelector" = mkOption {
          description = "LayerSelector specifies which layer should be extracted from the OCI artifact.\nWhen not specified, the first layer found in the artifact is selected.";
          type = (types.nullOr LayerSelectorModule);
          default = null;
        };
        "provider" = mkOption {
          description = "The provider used for authentication, can be 'aws', 'azure', 'gcp' or 'generic'.\nWhen not specified, defaults to 'generic'.";
          type = (
            types.nullOr (
              types.enum [
                "generic"
                "aws"
                "azure"
                "gcp"
              ]
            )
          );
          default = "generic";
        };
        "proxySecretRef" = mkOption {
          description = "ProxySecretRef specifies the Secret containing the proxy configuration\nto use while communicating with the container registry.";
          type = (types.nullOr ProxySecretRefModule);
          default = null;
        };
        "ref" = mkOption {
          description = "The OCI reference to pull and monitor for changes,\ndefaults to the latest tag.";
          type = (types.nullOr RefModule);
          default = null;
        };
        "secretRef" = mkOption {
          description = "SecretRef contains the secret name containing the registry login\ncredentials to resolve image metadata.\nThe secret must be of type kubernetes.io/dockerconfigjson.";
          type = (types.nullOr SecretRefModule);
          default = null;
        };
        "serviceAccountName" = mkOption {
          description = "ServiceAccountName is the name of the Kubernetes ServiceAccount used to authenticate\nthe image pull if the service account has attached pull secrets. For more information:\nhttps://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#add-imagepullsecrets-to-a-service-account";
          type = (types.nullOr types.str);
          default = null;
        };
        "suspend" = mkOption {
          description = "This flag tells the controller to suspend the reconciliation of this source.";
          type = types.bool;
          default = false;
        };
        "timeout" = mkOption {
          description = "The timeout for remote OCI Repository operations like pulling, defaults to 60s.";
          type = (types.nullOr types.str);
          default = "60s";
        };
        "url" = mkOption {
          description = "URL is a reference to an OCI artifact repository hosted\non a remote container registry.";
          type = types.str;
        };
        "verify" = mkOption {
          description = "Verify contains the secret name containing the trusted public keys\nused to verify the signature and specifies which provider to use to check\nwhether OCI image is authentic.";
          type = (types.nullOr VerifyModule);
          default = null;
        };
      };
    }
  );
  mkOCIRepository = name: res: {
    apiVersion = "source.toolkit.fluxcd.io/v1";
    kind = "OCIRepository";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."certSecretRef" != null) {
      "certSecretRef" = mkCertSecretRef res."certSecretRef";
    }
    // {
    }
    // optionalAttrs (res."ignore" != null) { inherit (res) "ignore"; }
    // {
    }
    // optionalAttrs res."insecure" { inherit (res) "insecure"; }
    // {
      inherit (res) "interval";
    }
    // optionalAttrs (res."layerSelector" != null) {
      "layerSelector" = mkLayerSelector res."layerSelector";
    }
    // {
    }
    // optionalAttrs (res."provider" != null) { inherit (res) "provider"; }
    // {
    }
    // optionalAttrs (res."proxySecretRef" != null) {
      "proxySecretRef" = mkProxySecretRef res."proxySecretRef";
    }
    // {
    }
    // optionalAttrs (res."ref" != null) { "ref" = mkRef res."ref"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) { "secretRef" = mkSecretRef res."secretRef"; }
    // {
    }
    // optionalAttrs (res."serviceAccountName" != null) { inherit (res) "serviceAccountName"; }
    // {
    }
    // optionalAttrs res."suspend" { inherit (res) "suspend"; }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
      inherit (res) "url";
    }
    // optionalAttrs (res."verify" != null) { "verify" = mkVerify res."verify"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkOCIRepository cfg."ocirepositories");
in
{
  options.openkrill.apps."flux" = {
    "ocirepositories" = mkOption {
      type = types.attrsOf OcirepositoriesModule;
      default = { };
      description = "OCIRepository CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."flux".content = allResources;
  };
}
