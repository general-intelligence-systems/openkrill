# Auto-generated openkrill module fragment for flux
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."flux";
  compact = filterAttrs (_: v: v != null);
  FilterTagsModule = types.submodule {
    options = {
      "extract" = mkOption {
        description = "Extract allows a capture group to be extracted from the specified regular\nexpression pattern, useful before tag evaluation.";
        type = (types.nullOr types.str);
        default = null;
      };
      "pattern" = mkOption {
        description = "Pattern specifies a regular expression pattern used to filter for image\ntags.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkFilterTags =
    res:
    {
    }
    // optionalAttrs (res."extract" != null) { inherit (res) "extract"; }
    // {
    }
    // optionalAttrs (res."pattern" != null) { inherit (res) "pattern"; }
    // {
    };
  ImageRepositoryRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "Namespace of the referent, when not specified it acts as LocalObjectReference.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkImageRepositoryRef =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  PolicyAlphabeticalModule = types.submodule {
    options = {
      "order" = mkOption {
        description = "Order specifies the sorting order of the tags. Given the letters of the\nalphabet as tags, ascending order would select Z, and descending order\nwould select A.";
        type = (
          types.nullOr (
            types.enum [
              "asc"
              "desc"
            ]
          )
        );
        default = "asc";
      };
    };
  };
  mkPolicyAlphabetical =
    res:
    {
    }
    // optionalAttrs (res."order" != null) { inherit (res) "order"; }
    // {
    };
  PolicyModule = types.submodule {
    options = {
      "alphabetical" = mkOption {
        description = "Alphabetical set of rules to use for alphabetical ordering of the tags.";
        type = (types.nullOr PolicyAlphabeticalModule);
        default = null;
      };
      "numerical" = mkOption {
        description = "Numerical set of rules to use for numerical ordering of the tags.";
        type = (types.nullOr PolicyNumericalModule);
        default = null;
      };
      "semver" = mkOption {
        description = "SemVer gives a semantic version range to check against the tags\navailable.";
        type = (types.nullOr PolicySemverModule);
        default = null;
      };
    };
  };
  mkPolicy =
    res:
    {
    }
    // optionalAttrs (res."alphabetical" != null) {
      "alphabetical" = mkPolicyAlphabetical res."alphabetical";
    }
    // {
    }
    // optionalAttrs (res."numerical" != null) { "numerical" = mkPolicyNumerical res."numerical"; }
    // {
    }
    // optionalAttrs (res."semver" != null) { "semver" = mkPolicySemver res."semver"; }
    // {
    };
  PolicyNumericalModule = types.submodule {
    options = {
      "order" = mkOption {
        description = "Order specifies the sorting order of the tags. Given the integer values\nfrom 0 to 9 as tags, ascending order would select 9, and descending order\nwould select 0.";
        type = (
          types.nullOr (
            types.enum [
              "asc"
              "desc"
            ]
          )
        );
        default = "asc";
      };
    };
  };
  mkPolicyNumerical =
    res:
    {
    }
    // optionalAttrs (res."order" != null) { inherit (res) "order"; }
    // {
    };
  PolicySemverModule = types.submodule {
    options = {
      "range" = mkOption {
        description = "Range gives a semver range for the image tag; the highest\nversion within the range that's a tag yields the latest image.";
        type = types.str;
      };
    };
  };
  mkPolicySemver = res: {
    inherit (res) "range";
  };
  ImagepoliciesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this ImagePolicy resource.";
        };
        "digestReflectionPolicy" = mkOption {
          description = "DigestReflectionPolicy governs the setting of the `.status.latestRef.digest` field.\n\nNever: The digest field will always be set to the empty string.\n\nIfNotPresent: The digest field will be set to the digest of the elected\nlatest image if the field is empty and the image did not change.\n\nAlways: The digest field will always be set to the digest of the elected\nlatest image.\n\nDefault: Never.";
          type = (
            types.nullOr (
              types.enum [
                "Always"
                "IfNotPresent"
                "Never"
              ]
            )
          );
          default = "Never";
        };
        "filterTags" = mkOption {
          description = "FilterTags enables filtering for only a subset of tags based on a set of\nrules. If no rules are provided, all the tags from the repository will be\nordered and compared.";
          type = (types.nullOr FilterTagsModule);
          default = null;
        };
        "imageRepositoryRef" = mkOption {
          description = "ImageRepositoryRef points at the object specifying the image\nbeing scanned";
          type = ImageRepositoryRefModule;
        };
        "interval" = mkOption {
          description = "Interval is the length of time to wait between\nrefreshing the digest of the latest tag when the\nreflection policy is set to \"Always\".\n\nDefaults to 10m.";
          type = (types.nullOr types.str);
          default = null;
        };
        "policy" = mkOption {
          description = "Policy gives the particulars of the policy to be followed in\nselecting the most recent image";
          type = PolicyModule;
        };
      };
    }
  );
  mkImagePolicy = name: res: {
    apiVersion = "image.toolkit.fluxcd.io/v1beta2";
    kind = "ImagePolicy";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."digestReflectionPolicy" != null) { inherit (res) "digestReflectionPolicy"; }
    // {
    }
    // optionalAttrs (res."filterTags" != null) { "filterTags" = mkFilterTags res."filterTags"; }
    // {
      "imageRepositoryRef" = mkImageRepositoryRef res."imageRepositoryRef";
    }
    // optionalAttrs (res."interval" != null) { inherit (res) "interval"; }
    // {
      "policy" = mkPolicy res."policy";
    };
  };
  allResources = (mapAttrsToList mkImagePolicy cfg."imagepolicies");
in
{
  options.openkrill.apps."flux" = {
    "imagepolicies" = mkOption {
      type = types.attrsOf ImagepoliciesModule;
      default = { };
      description = "ImagePolicy CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."flux".content = allResources;
  };
}
