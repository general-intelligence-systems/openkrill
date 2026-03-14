# Auto-generated openkrill module fragment for flux
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."flux";
  compact = filterAttrs (_: v: v != null);
  GitCheckoutModule = types.submodule {
    options = {
      "ref" = mkOption {
        description = "Reference gives a branch, tag or commit to clone from the Git\nrepository.";
        type = GitCheckoutRefModule;
      };
    };
  };
  mkGitCheckout = res: {
    "ref" = mkGitCheckoutRef res."ref";
  };
  GitCheckoutRefModule = types.submodule {
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
  mkGitCheckoutRef =
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
  GitCommitAuthorModule = types.submodule {
    options = {
      "email" = mkOption {
        description = "Email gives the email to provide when making a commit.";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name gives the name to provide when making a commit.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkGitCommitAuthor =
    res:
    {
      inherit (res) "email";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  GitCommitModule = types.submodule {
    options = {
      "author" = mkOption {
        description = "Author gives the email and optionally the name to use as the\nauthor of commits.";
        type = GitCommitAuthorModule;
      };
      "messageTemplate" = mkOption {
        description = "MessageTemplate provides a template for the commit message,\ninto which will be interpolated the details of the change made.";
        type = (types.nullOr types.str);
        default = null;
      };
      "messageTemplateValues" = mkOption {
        description = "MessageTemplateValues provides additional values to be available to the\ntemplating rendering.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "signingKey" = mkOption {
        description = "SigningKey provides the option to sign commits with a GPG key";
        type = (types.nullOr GitCommitSigningKeyModule);
        default = null;
      };
    };
  };
  mkGitCommit =
    res:
    {
      "author" = mkGitCommitAuthor res."author";
    }
    // optionalAttrs (res."messageTemplate" != null) { inherit (res) "messageTemplate"; }
    // {
    }
    // optionalAttrs (res."messageTemplateValues" != { }) { inherit (res) "messageTemplateValues"; }
    // {
    }
    // optionalAttrs (res."signingKey" != null) {
      "signingKey" = mkGitCommitSigningKey res."signingKey";
    }
    // {
    };
  GitCommitSigningKeyModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "SecretRef holds the name to a secret that contains a 'git.asc' key\ncorresponding to the ASCII Armored file containing the GPG signing\nkeypair as the value. It must be in the same namespace as the\nImageUpdateAutomation.";
        type = GitCommitSigningKeySecretRefModule;
      };
    };
  };
  mkGitCommitSigningKey = res: {
    "secretRef" = mkGitCommitSigningKeySecretRef res."secretRef";
  };
  GitCommitSigningKeySecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkGitCommitSigningKeySecretRef = res: {
    inherit (res) "name";
  };
  GitModule = types.submodule {
    options = {
      "checkout" = mkOption {
        description = "Checkout gives the parameters for cloning the git repository,\nready to make changes. If not present, the `spec.ref` field from the\nreferenced `GitRepository` or its default will be used.";
        type = (types.nullOr GitCheckoutModule);
        default = null;
      };
      "commit" = mkOption {
        description = "Commit specifies how to commit to the git repository.";
        type = GitCommitModule;
      };
      "push" = mkOption {
        description = "Push specifies how and where to push commits made by the\nautomation. If missing, commits are pushed (back) to\n`.spec.checkout.branch` or its default.";
        type = (types.nullOr GitPushModule);
        default = null;
      };
    };
  };
  mkGit =
    res:
    {
    }
    // optionalAttrs (res."checkout" != null) { "checkout" = mkGitCheckout res."checkout"; }
    // {
      "commit" = mkGitCommit res."commit";
    }
    // optionalAttrs (res."push" != null) { "push" = mkGitPush res."push"; }
    // {
    };
  GitPushModule = types.submodule {
    options = {
      "branch" = mkOption {
        description = "Branch specifies that commits should be pushed to the branch\nnamed. The branch is created using `.spec.checkout.branch` as the\nstarting point, if it doesn't already exist.";
        type = (types.nullOr types.str);
        default = null;
      };
      "options" = mkOption {
        description = "Options specifies the push options that are sent to the Git\nserver when performing a push operation. For details, see:\nhttps://git-scm.com/docs/git-push#Documentation/git-push.txt---push-optionltoptiongt";
        type = (types.attrsOf types.str);
        default = { };
      };
      "refspec" = mkOption {
        description = "Refspec specifies the Git Refspec to use for a push operation.\nIf both Branch and Refspec are provided, then the commit is pushed\nto the branch and also using the specified refspec.\nFor more details about Git Refspecs, see:\nhttps://git-scm.com/book/en/v2/Git-Internals-The-Refspec";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkGitPush =
    res:
    {
    }
    // optionalAttrs (res."branch" != null) { inherit (res) "branch"; }
    // {
    }
    // optionalAttrs (res."options" != { }) { inherit (res) "options"; }
    // {
    }
    // optionalAttrs (res."refspec" != null) { inherit (res) "refspec"; }
    // {
    };
  PolicySelectorMatchExpressionModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "key is the label key that the selector applies to.";
        type = types.str;
      };
      "operator" = mkOption {
        description = "operator represents a key's relationship to a set of values.\nValid operators are In, NotIn, Exists and DoesNotExist.";
        type = types.str;
      };
      "values" = mkOption {
        description = "values is an array of string values. If the operator is In or NotIn,\nthe values array must be non-empty. If the operator is Exists or DoesNotExist,\nthe values array must be empty. This array is replaced during a strategic\nmerge patch.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkPolicySelectorMatchExpression =
    res:
    {
      inherit (res) "key";
      inherit (res) "operator";
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  PolicySelectorModule = types.submodule {
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf PolicySelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels\nmap is equivalent to an element of matchExpressions, whose key field is \"key\", the\noperator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkPolicySelector =
    res:
    {
    }
    // optionalAttrs (res."matchExpressions" != [ ]) {
      "matchExpressions" = map mkPolicySelectorMatchExpression res."matchExpressions";
    }
    // {
    }
    // optionalAttrs (res."matchLabels" != { }) { inherit (res) "matchLabels"; }
    // {
    };
  SourceRefModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        description = "API version of the referent.";
        type = (types.nullOr types.str);
        default = null;
      };
      "kind" = mkOption {
        description = "Kind of the referent.";
        type = (types.enum [ "GitRepository" ]);
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "Namespace of the referent, defaults to the namespace of the Kubernetes resource object that contains the reference.";
        type = (types.nullOr types.str);
        default = null;
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
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  UpdateModule = types.submodule {
    options = {
      "path" = mkOption {
        description = "Path to the directory containing the manifests to be updated.\nDefaults to 'None', which translates to the root path\nof the GitRepositoryRef.";
        type = (types.nullOr types.str);
        default = null;
      };
      "strategy" = mkOption {
        description = "Strategy names the strategy to be used.";
        type = (types.enum [ "Setters" ]);
      };
    };
  };
  mkUpdate =
    res:
    {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
      inherit (res) "strategy";
    };
  ImageupdateautomationsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this ImageUpdateAutomation resource.";
        };
        "git" = mkOption {
          description = "GitSpec contains all the git-specific definitions. This is\ntechnically optional, but in practice mandatory until there are\nother kinds of source allowed.";
          type = (types.nullOr GitModule);
          default = null;
        };
        "interval" = mkOption {
          description = "Interval gives an lower bound for how often the automation\nrun should be attempted.";
          type = types.str;
        };
        "policySelector" = mkOption {
          description = "PolicySelector allows to filter applied policies based on labels.\nBy default includes all policies in namespace.";
          type = (types.nullOr PolicySelectorModule);
          default = null;
        };
        "sourceRef" = mkOption {
          description = "SourceRef refers to the resource giving access details\nto a git repository.";
          type = SourceRefModule;
        };
        "suspend" = mkOption {
          description = "Suspend tells the controller to not run this automation, until\nit is unset (or set to false). Defaults to false.";
          type = types.bool;
          default = false;
        };
        "update" = mkOption {
          description = "Update gives the specification for how to update the files in\nthe repository. This can be left empty, to use the default\nvalue.";
          type = (types.nullOr UpdateModule);
          default = {
            "strategy" = "Setters";
          };
        };
      };
    }
  );
  mkImageUpdateAutomation = name: res: {
    apiVersion = "image.toolkit.fluxcd.io/v1beta2";
    kind = "ImageUpdateAutomation";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."git" != null) { "git" = mkGit res."git"; }
    // {
      inherit (res) "interval";
    }
    // optionalAttrs (res."policySelector" != null) {
      "policySelector" = mkPolicySelector res."policySelector";
    }
    // {
      "sourceRef" = mkSourceRef res."sourceRef";
    }
    // optionalAttrs res."suspend" { inherit (res) "suspend"; }
    // {
    }
    // optionalAttrs (res."update" != null) { "update" = mkUpdate res."update"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkImageUpdateAutomation cfg."imageupdateautomations");
in
{
  options.openkrill.apps."flux" = {
    "imageupdateautomations" = mkOption {
      type = types.attrsOf ImageupdateautomationsModule;
      default = { };
      description = "ImageUpdateAutomation CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."flux".content = allResources;
  };
}
