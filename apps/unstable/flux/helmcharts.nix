# Auto-generated openkrill module fragment for flux
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."flux";
  compact = filterAttrs (_: v: v != null);
  SourceRefModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        description = "APIVersion of the referent.";
        type = (types.nullOr types.str);
        default = null;
      };
      "kind" = mkOption {
        description = "Kind of the referent, valid values are ('HelmRepository', 'GitRepository',\n'Bucket').";
        type = (
          types.enum [
            "HelmRepository"
            "GitRepository"
            "Bucket"
          ]
        );
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkSourceRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "kind";
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
  HelmchartsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this HelmChart resource.";
        };
        "chart" = mkOption {
          description = "Chart is the name or path the Helm chart is available at in the\nSourceRef.";
          type = types.str;
        };
        "ignoreMissingValuesFiles" = mkOption {
          description = "IgnoreMissingValuesFiles controls whether to silently ignore missing values\nfiles rather than failing.";
          type = types.bool;
          default = false;
        };
        "interval" = mkOption {
          description = "Interval at which the HelmChart SourceRef is checked for updates.\nThis interval is approximate and may be subject to jitter to ensure\nefficient use of resources.";
          type = types.str;
        };
        "reconcileStrategy" = mkOption {
          description = "ReconcileStrategy determines what enables the creation of a new artifact.\nValid values are ('ChartVersion', 'Revision').\nSee the documentation of the values for an explanation on their behavior.\nDefaults to ChartVersion when omitted.";
          type = (
            types.nullOr (
              types.enum [
                "ChartVersion"
                "Revision"
              ]
            )
          );
          default = "ChartVersion";
        };
        "sourceRef" = mkOption {
          description = "SourceRef is the reference to the Source the chart is available at.";
          type = SourceRefModule;
        };
        "suspend" = mkOption {
          description = "Suspend tells the controller to suspend the reconciliation of this\nsource.";
          type = types.bool;
          default = false;
        };
        "valuesFiles" = mkOption {
          description = "ValuesFiles is an alternative list of values files to use as the chart\nvalues (values.yaml is not included by default), expected to be a\nrelative path in the SourceRef.\nValues files are merged in the order of this list with the last file\noverriding the first. Ignored when omitted.";
          type = (types.listOf types.str);
          default = [ ];
        };
        "verify" = mkOption {
          description = "Verify contains the secret name containing the trusted public keys\nused to verify the signature and specifies which provider to use to check\nwhether OCI image is authentic.\nThis field is only supported when using HelmRepository source with spec.type 'oci'.\nChart dependencies, which are not bundled in the umbrella chart artifact, are not verified.";
          type = (types.nullOr VerifyModule);
          default = null;
        };
        "version" = mkOption {
          description = "Version is the chart version semver expression, ignored for charts from\nGitRepository and Bucket sources. Defaults to latest when omitted.";
          type = (types.nullOr types.str);
          default = "*";
        };
      };
    }
  );
  mkHelmChart = name: res: {
    apiVersion = "source.toolkit.fluxcd.io/v1";
    kind = "HelmChart";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
      inherit (res) "chart";
    }
    // optionalAttrs res."ignoreMissingValuesFiles" { inherit (res) "ignoreMissingValuesFiles"; }
    // {
      inherit (res) "interval";
    }
    // optionalAttrs (res."reconcileStrategy" != null) { inherit (res) "reconcileStrategy"; }
    // {
      "sourceRef" = mkSourceRef res."sourceRef";
    }
    // optionalAttrs res."suspend" { inherit (res) "suspend"; }
    // {
    }
    // optionalAttrs (res."valuesFiles" != [ ]) { inherit (res) "valuesFiles"; }
    // {
    }
    // optionalAttrs (res."verify" != null) { "verify" = mkVerify res."verify"; }
    // {
    }
    // optionalAttrs (res."version" != null) { inherit (res) "version"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkHelmChart cfg."helmcharts");
in
{
  options.openkrill.apps."flux" = {
    "helmcharts" = mkOption {
      type = types.attrsOf HelmchartsModule;
      default = { };
      description = "HelmChart CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."flux".content = allResources;
  };
}
