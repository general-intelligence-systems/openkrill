# Auto-generated openkrill module fragment for flux
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."flux";
  compact = filterAttrs (_: v: v != null);
  IncludeModule = types.submodule {
    options = {
      "fromPath" = mkOption {
        description = "FromPath specifies the path to copy contents from, defaults to the root\nof the Artifact.";
        type = (types.nullOr types.str);
        default = null;
      };
      "repository" = mkOption {
        description = "GitRepositoryRef specifies the GitRepository which Artifact contents\nmust be included.";
        type = IncludeRepositoryModule;
      };
      "toPath" = mkOption {
        description = "ToPath specifies the path to copy contents to, defaults to the name of\nthe GitRepositoryRef.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkInclude =
    res:
    {
    }
    // optionalAttrs (res."fromPath" != null) { inherit (res) "fromPath"; }
    // {
      "repository" = mkIncludeRepository res."repository";
    }
    // optionalAttrs (res."toPath" != null) { inherit (res) "toPath"; }
    // {
    };
  IncludeRepositoryModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkIncludeRepository = res: {
    inherit (res) "name";
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
      "branch" = mkOption {
        description = "Branch to check out, defaults to 'master' if no other field is defined.";
        type = (types.nullOr types.str);
        default = null;
      };
      "commit" = mkOption {
        description = "Commit SHA to check out, takes precedence over all reference fields.\n\nThis can be combined with Branch to shallow clone the branch, in which\nthe commit is expected to exist.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the reference to check out; takes precedence over Branch, Tag and SemVer.\n\nIt must be a valid Git reference: https://git-scm.com/docs/git-check-ref-format#_description\nExamples: \"refs/heads/main\", \"refs/tags/v0.1.0\", \"refs/pull/420/head\", \"refs/merge-requests/1/head\"";
        type = (types.nullOr types.str);
        default = null;
      };
      "semver" = mkOption {
        description = "SemVer tag expression to check out, takes precedence over Tag.";
        type = (types.nullOr types.str);
        default = null;
      };
      "tag" = mkOption {
        description = "Tag to check out, takes precedence over Branch.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkRef =
    res:
    {
    }
    // optionalAttrs (res."branch" != null) { inherit (res) "branch"; }
    // {
    }
    // optionalAttrs (res."commit" != null) { inherit (res) "commit"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."semver" != null) { inherit (res) "semver"; }
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
  VerifyModule = types.submodule {
    options = {
      "mode" = mkOption {
        description = "Mode specifies which Git object(s) should be verified.\n\nThe variants \"head\" and \"HEAD\" both imply the same thing, i.e. verify\nthe commit that the HEAD of the Git repository points to. The variant\n\"head\" solely exists to ensure backwards compatibility.";
        type = (
          types.nullOr (
            types.enum [
              "head"
              "HEAD"
              "Tag"
              "TagAndHEAD"
            ]
          )
        );
        default = "HEAD";
      };
      "secretRef" = mkOption {
        description = "SecretRef specifies the Secret containing the public keys of trusted Git\nauthors.";
        type = VerifySecretRefModule;
      };
    };
  };
  mkVerify =
    res:
    {
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      "secretRef" = mkVerifySecretRef res."secretRef";
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
  GitrepositoriesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this GitRepository resource.";
        };
        "ignore" = mkOption {
          description = "Ignore overrides the set of excluded patterns in the .sourceignore format\n(which is the same as .gitignore). If not provided, a default will be used,\nconsult the documentation for your version to find out what those are.";
          type = (types.nullOr types.str);
          default = null;
        };
        "include" = mkOption {
          description = "Include specifies a list of GitRepository resources which Artifacts\nshould be included in the Artifact produced for this GitRepository.";
          type = (types.listOf IncludeModule);
          default = [ ];
        };
        "interval" = mkOption {
          description = "Interval at which the GitRepository URL is checked for updates.\nThis interval is approximate and may be subject to jitter to ensure\nefficient use of resources.";
          type = types.str;
        };
        "provider" = mkOption {
          description = "Provider used for authentication, can be 'azure', 'github', 'generic'.\nWhen not specified, defaults to 'generic'.";
          type = (
            types.nullOr (
              types.enum [
                "generic"
                "azure"
                "github"
              ]
            )
          );
          default = null;
        };
        "proxySecretRef" = mkOption {
          description = "ProxySecretRef specifies the Secret containing the proxy configuration\nto use while communicating with the Git server.";
          type = (types.nullOr ProxySecretRefModule);
          default = null;
        };
        "recurseSubmodules" = mkOption {
          description = "RecurseSubmodules enables the initialization of all submodules within\nthe GitRepository as cloned from the URL, using their default settings.";
          type = types.bool;
          default = false;
        };
        "ref" = mkOption {
          description = "Reference specifies the Git reference to resolve and monitor for\nchanges, defaults to the 'master' branch.";
          type = (types.nullOr RefModule);
          default = null;
        };
        "secretRef" = mkOption {
          description = "SecretRef specifies the Secret containing authentication credentials for\nthe GitRepository.\nFor HTTPS repositories the Secret must contain 'username' and 'password'\nfields for basic auth or 'bearerToken' field for token auth.\nFor SSH repositories the Secret must contain 'identity'\nand 'known_hosts' fields.";
          type = (types.nullOr SecretRefModule);
          default = null;
        };
        "sparseCheckout" = mkOption {
          description = "SparseCheckout specifies a list of directories to checkout when cloning\nthe repository. If specified, only these directories are included in the\nArtifact produced for this GitRepository.";
          type = (types.listOf types.str);
          default = [ ];
        };
        "suspend" = mkOption {
          description = "Suspend tells the controller to suspend the reconciliation of this\nGitRepository.";
          type = types.bool;
          default = false;
        };
        "timeout" = mkOption {
          description = "Timeout for Git operations like cloning, defaults to 60s.";
          type = (types.nullOr types.str);
          default = "60s";
        };
        "url" = mkOption {
          description = "URL specifies the Git repository URL, it can be an HTTP/S or SSH address.";
          type = types.str;
        };
        "verify" = mkOption {
          description = "Verification specifies the configuration to verify the Git commit\nsignature(s).";
          type = (types.nullOr VerifyModule);
          default = null;
        };
      };
    }
  );
  mkGitRepository = name: res: {
    apiVersion = "source.toolkit.fluxcd.io/v1";
    kind = "GitRepository";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."ignore" != null) { inherit (res) "ignore"; }
    // {
    }
    // optionalAttrs (res."include" != [ ]) { "include" = map mkInclude res."include"; }
    // {
      inherit (res) "interval";
    }
    // optionalAttrs (res."provider" != null) { inherit (res) "provider"; }
    // {
    }
    // optionalAttrs (res."proxySecretRef" != null) {
      "proxySecretRef" = mkProxySecretRef res."proxySecretRef";
    }
    // {
    }
    // optionalAttrs res."recurseSubmodules" { inherit (res) "recurseSubmodules"; }
    // {
    }
    // optionalAttrs (res."ref" != null) { "ref" = mkRef res."ref"; }
    // {
    }
    // optionalAttrs (res."secretRef" != null) { "secretRef" = mkSecretRef res."secretRef"; }
    // {
    }
    // optionalAttrs (res."sparseCheckout" != [ ]) { inherit (res) "sparseCheckout"; }
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
  allResources = (mapAttrsToList mkGitRepository cfg."gitrepositories");
in
{
  options.openkrill.apps."flux" = {
    "gitrepositories" = mkOption {
      type = types.attrsOf GitrepositoriesModule;
      default = { };
      description = "GitRepository CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."flux".content = allResources;
  };
}
