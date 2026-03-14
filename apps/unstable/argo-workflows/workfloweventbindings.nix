# Auto-generated openkrill module fragment for argo-workflows
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."argo-workflows";
  compact = filterAttrs (_: v: v != null);
  EventModule = types.submodule {
    options = {
      "selector" = mkOption {
        type = types.str;
      };
    };
  };
  mkEvent = res: {
    inherit (res) "selector";
  };
  SubmitArgumentsArtifactArchiveModule = types.submodule {
    options = {
      "none" = mkOption {
        type = (types.attrsOf types.anything);
        default = { };
      };
      "tar" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactArchiveTarModule);
        default = null;
      };
      "zip" = mkOption {
        type = (types.attrsOf types.anything);
        default = { };
      };
    };
  };
  mkSubmitArgumentsArtifactArchive =
    res:
    {
    }
    // optionalAttrs (res."none" != { }) { inherit (res) "none"; }
    // {
    }
    // optionalAttrs (res."tar" != null) { "tar" = mkSubmitArgumentsArtifactArchiveTar res."tar"; }
    // {
    }
    // optionalAttrs (res."zip" != { }) { inherit (res) "zip"; }
    // {
    };
  SubmitArgumentsArtifactArchiveTarModule = types.submodule {
    options = {
      "compressionLevel" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkSubmitArgumentsArtifactArchiveTar =
    res:
    {
    }
    // optionalAttrs (res."compressionLevel" != null) { inherit (res) "compressionLevel"; }
    // {
    };
  SubmitArgumentsArtifactArtifactGCModule = types.submodule {
    options = {
      "podMetadata" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactArtifactGCPodMetadataModule);
        default = null;
      };
      "serviceAccountName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "strategy" = mkOption {
        type = (
          types.nullOr (
            types.enum [
              ""
              "OnWorkflowCompletion"
              "OnWorkflowDeletion"
              "Never"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkSubmitArgumentsArtifactArtifactGC =
    res:
    {
    }
    // optionalAttrs (res."podMetadata" != null) {
      "podMetadata" = mkSubmitArgumentsArtifactArtifactGCPodMetadata res."podMetadata";
    }
    // {
    }
    // optionalAttrs (res."serviceAccountName" != null) { inherit (res) "serviceAccountName"; }
    // {
    }
    // optionalAttrs (res."strategy" != null) { inherit (res) "strategy"; }
    // {
    };
  SubmitArgumentsArtifactArtifactGCPodMetadataModule = types.submodule {
    options = {
      "annotations" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "labels" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkSubmitArgumentsArtifactArtifactGCPodMetadata =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    };
  SubmitArgumentsArtifactArtifactoryModule = types.submodule {
    options = {
      "passwordSecret" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactArtifactoryPasswordSecretModule);
        default = null;
      };
      "url" = mkOption {
        type = types.str;
      };
      "usernameSecret" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactArtifactoryUsernameSecretModule);
        default = null;
      };
    };
  };
  mkSubmitArgumentsArtifactArtifactory =
    res:
    {
    }
    // optionalAttrs (res."passwordSecret" != null) {
      "passwordSecret" = mkSubmitArgumentsArtifactArtifactoryPasswordSecret res."passwordSecret";
    }
    // {
      inherit (res) "url";
    }
    // optionalAttrs (res."usernameSecret" != null) {
      "usernameSecret" = mkSubmitArgumentsArtifactArtifactoryUsernameSecret res."usernameSecret";
    }
    // {
    };
  SubmitArgumentsArtifactArtifactoryPasswordSecretModule = types.submodule {
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
  mkSubmitArgumentsArtifactArtifactoryPasswordSecret =
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
  SubmitArgumentsArtifactArtifactoryUsernameSecretModule = types.submodule {
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
  mkSubmitArgumentsArtifactArtifactoryUsernameSecret =
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
  SubmitArgumentsArtifactAzureAccountKeySecretModule = types.submodule {
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
  mkSubmitArgumentsArtifactAzureAccountKeySecret =
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
  SubmitArgumentsArtifactAzureModule = types.submodule {
    options = {
      "accountKeySecret" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactAzureAccountKeySecretModule);
        default = null;
      };
      "blob" = mkOption {
        type = types.str;
      };
      "container" = mkOption {
        type = types.str;
      };
      "endpoint" = mkOption {
        type = types.str;
      };
      "useSDKCreds" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkSubmitArgumentsArtifactAzure =
    res:
    {
    }
    // optionalAttrs (res."accountKeySecret" != null) {
      "accountKeySecret" = mkSubmitArgumentsArtifactAzureAccountKeySecret res."accountKeySecret";
    }
    // {
      inherit (res) "blob";
      inherit (res) "container";
      inherit (res) "endpoint";
    }
    // optionalAttrs res."useSDKCreds" { inherit (res) "useSDKCreds"; }
    // {
    };
  SubmitArgumentsArtifactGcsModule = types.submodule {
    options = {
      "bucket" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "key" = mkOption {
        type = types.str;
      };
      "serviceAccountKeySecret" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactGcsServiceAccountKeySecretModule);
        default = null;
      };
    };
  };
  mkSubmitArgumentsArtifactGcs =
    res:
    {
    }
    // optionalAttrs (res."bucket" != null) { inherit (res) "bucket"; }
    // {
      inherit (res) "key";
    }
    // optionalAttrs (res."serviceAccountKeySecret" != null) {
      "serviceAccountKeySecret" =
        mkSubmitArgumentsArtifactGcsServiceAccountKeySecret
          res."serviceAccountKeySecret";
    }
    // {
    };
  SubmitArgumentsArtifactGcsServiceAccountKeySecretModule = types.submodule {
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
  mkSubmitArgumentsArtifactGcsServiceAccountKeySecret =
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
  SubmitArgumentsArtifactGitModule = types.submodule {
    options = {
      "branch" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "depth" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "disableSubmodules" = mkOption {
        type = types.bool;
        default = false;
      };
      "fetch" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "insecureIgnoreHostKey" = mkOption {
        type = types.bool;
        default = false;
      };
      "insecureSkipTLS" = mkOption {
        type = types.bool;
        default = false;
      };
      "passwordSecret" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactGitPasswordSecretModule);
        default = null;
      };
      "repo" = mkOption {
        type = types.str;
      };
      "revision" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "singleBranch" = mkOption {
        type = types.bool;
        default = false;
      };
      "sshPrivateKeySecret" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactGitSshPrivateKeySecretModule);
        default = null;
      };
      "usernameSecret" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactGitUsernameSecretModule);
        default = null;
      };
    };
  };
  mkSubmitArgumentsArtifactGit =
    res:
    {
    }
    // optionalAttrs (res."branch" != null) { inherit (res) "branch"; }
    // {
    }
    // optionalAttrs (res."depth" != null) { inherit (res) "depth"; }
    // {
    }
    // optionalAttrs res."disableSubmodules" { inherit (res) "disableSubmodules"; }
    // {
    }
    // optionalAttrs (res."fetch" != [ ]) { inherit (res) "fetch"; }
    // {
    }
    // optionalAttrs res."insecureIgnoreHostKey" { inherit (res) "insecureIgnoreHostKey"; }
    // {
    }
    // optionalAttrs res."insecureSkipTLS" { inherit (res) "insecureSkipTLS"; }
    // {
    }
    // optionalAttrs (res."passwordSecret" != null) {
      "passwordSecret" = mkSubmitArgumentsArtifactGitPasswordSecret res."passwordSecret";
    }
    // {
      inherit (res) "repo";
    }
    // optionalAttrs (res."revision" != null) { inherit (res) "revision"; }
    // {
    }
    // optionalAttrs res."singleBranch" { inherit (res) "singleBranch"; }
    // {
    }
    // optionalAttrs (res."sshPrivateKeySecret" != null) {
      "sshPrivateKeySecret" = mkSubmitArgumentsArtifactGitSshPrivateKeySecret res."sshPrivateKeySecret";
    }
    // {
    }
    // optionalAttrs (res."usernameSecret" != null) {
      "usernameSecret" = mkSubmitArgumentsArtifactGitUsernameSecret res."usernameSecret";
    }
    // {
    };
  SubmitArgumentsArtifactGitPasswordSecretModule = types.submodule {
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
  mkSubmitArgumentsArtifactGitPasswordSecret =
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
  SubmitArgumentsArtifactGitSshPrivateKeySecretModule = types.submodule {
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
  mkSubmitArgumentsArtifactGitSshPrivateKeySecret =
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
  SubmitArgumentsArtifactGitUsernameSecretModule = types.submodule {
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
  mkSubmitArgumentsArtifactGitUsernameSecret =
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
  SubmitArgumentsArtifactHdfsKrbCCacheSecretModule = types.submodule {
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
  mkSubmitArgumentsArtifactHdfsKrbCCacheSecret =
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
  SubmitArgumentsArtifactHdfsKrbConfigConfigMapModule = types.submodule {
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
  mkSubmitArgumentsArtifactHdfsKrbConfigConfigMap =
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
  SubmitArgumentsArtifactHdfsKrbKeytabSecretModule = types.submodule {
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
  mkSubmitArgumentsArtifactHdfsKrbKeytabSecret =
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
  SubmitArgumentsArtifactHdfsModule = types.submodule {
    options = {
      "addresses" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "dataTransferProtection" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "force" = mkOption {
        type = types.bool;
        default = false;
      };
      "hdfsUser" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "krbCCacheSecret" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactHdfsKrbCCacheSecretModule);
        default = null;
      };
      "krbConfigConfigMap" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactHdfsKrbConfigConfigMapModule);
        default = null;
      };
      "krbKeytabSecret" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactHdfsKrbKeytabSecretModule);
        default = null;
      };
      "krbRealm" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "krbServicePrincipalName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "krbUsername" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "path" = mkOption {
        type = types.str;
      };
    };
  };
  mkSubmitArgumentsArtifactHdfs =
    res:
    {
    }
    // optionalAttrs (res."addresses" != [ ]) { inherit (res) "addresses"; }
    // {
    }
    // optionalAttrs (res."dataTransferProtection" != null) { inherit (res) "dataTransferProtection"; }
    // {
    }
    // optionalAttrs res."force" { inherit (res) "force"; }
    // {
    }
    // optionalAttrs (res."hdfsUser" != null) { inherit (res) "hdfsUser"; }
    // {
    }
    // optionalAttrs (res."krbCCacheSecret" != null) {
      "krbCCacheSecret" = mkSubmitArgumentsArtifactHdfsKrbCCacheSecret res."krbCCacheSecret";
    }
    // {
    }
    // optionalAttrs (res."krbConfigConfigMap" != null) {
      "krbConfigConfigMap" = mkSubmitArgumentsArtifactHdfsKrbConfigConfigMap res."krbConfigConfigMap";
    }
    // {
    }
    // optionalAttrs (res."krbKeytabSecret" != null) {
      "krbKeytabSecret" = mkSubmitArgumentsArtifactHdfsKrbKeytabSecret res."krbKeytabSecret";
    }
    // {
    }
    // optionalAttrs (res."krbRealm" != null) { inherit (res) "krbRealm"; }
    // {
    }
    // optionalAttrs (res."krbServicePrincipalName" != null) {
      inherit (res) "krbServicePrincipalName";
    }
    // {
    }
    // optionalAttrs (res."krbUsername" != null) { inherit (res) "krbUsername"; }
    // {
      inherit (res) "path";
    };
  SubmitArgumentsArtifactHttpAuthBasicAuthModule = types.submodule {
    options = {
      "passwordSecret" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactHttpAuthBasicAuthPasswordSecretModule);
        default = null;
      };
      "usernameSecret" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactHttpAuthBasicAuthUsernameSecretModule);
        default = null;
      };
    };
  };
  mkSubmitArgumentsArtifactHttpAuthBasicAuth =
    res:
    {
    }
    // optionalAttrs (res."passwordSecret" != null) {
      "passwordSecret" = mkSubmitArgumentsArtifactHttpAuthBasicAuthPasswordSecret res."passwordSecret";
    }
    // {
    }
    // optionalAttrs (res."usernameSecret" != null) {
      "usernameSecret" = mkSubmitArgumentsArtifactHttpAuthBasicAuthUsernameSecret res."usernameSecret";
    }
    // {
    };
  SubmitArgumentsArtifactHttpAuthBasicAuthPasswordSecretModule = types.submodule {
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
  mkSubmitArgumentsArtifactHttpAuthBasicAuthPasswordSecret =
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
  SubmitArgumentsArtifactHttpAuthBasicAuthUsernameSecretModule = types.submodule {
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
  mkSubmitArgumentsArtifactHttpAuthBasicAuthUsernameSecret =
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
  SubmitArgumentsArtifactHttpAuthClientCertClientCertSecretModule = types.submodule {
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
  mkSubmitArgumentsArtifactHttpAuthClientCertClientCertSecret =
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
  SubmitArgumentsArtifactHttpAuthClientCertClientKeySecretModule = types.submodule {
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
  mkSubmitArgumentsArtifactHttpAuthClientCertClientKeySecret =
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
  SubmitArgumentsArtifactHttpAuthClientCertModule = types.submodule {
    options = {
      "clientCertSecret" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactHttpAuthClientCertClientCertSecretModule);
        default = null;
      };
      "clientKeySecret" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactHttpAuthClientCertClientKeySecretModule);
        default = null;
      };
    };
  };
  mkSubmitArgumentsArtifactHttpAuthClientCert =
    res:
    {
    }
    // optionalAttrs (res."clientCertSecret" != null) {
      "clientCertSecret" =
        mkSubmitArgumentsArtifactHttpAuthClientCertClientCertSecret
          res."clientCertSecret";
    }
    // {
    }
    // optionalAttrs (res."clientKeySecret" != null) {
      "clientKeySecret" =
        mkSubmitArgumentsArtifactHttpAuthClientCertClientKeySecret
          res."clientKeySecret";
    }
    // {
    };
  SubmitArgumentsArtifactHttpAuthModule = types.submodule {
    options = {
      "basicAuth" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactHttpAuthBasicAuthModule);
        default = null;
      };
      "clientCert" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactHttpAuthClientCertModule);
        default = null;
      };
      "oauth2" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactHttpAuthOauth2Module);
        default = null;
      };
    };
  };
  mkSubmitArgumentsArtifactHttpAuth =
    res:
    {
    }
    // optionalAttrs (res."basicAuth" != null) {
      "basicAuth" = mkSubmitArgumentsArtifactHttpAuthBasicAuth res."basicAuth";
    }
    // {
    }
    // optionalAttrs (res."clientCert" != null) {
      "clientCert" = mkSubmitArgumentsArtifactHttpAuthClientCert res."clientCert";
    }
    // {
    }
    // optionalAttrs (res."oauth2" != null) {
      "oauth2" = mkSubmitArgumentsArtifactHttpAuthOauth2 res."oauth2";
    }
    // {
    };
  SubmitArgumentsArtifactHttpAuthOauth2ClientIDSecretModule = types.submodule {
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
  mkSubmitArgumentsArtifactHttpAuthOauth2ClientIDSecret =
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
  SubmitArgumentsArtifactHttpAuthOauth2ClientSecretSecretModule = types.submodule {
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
  mkSubmitArgumentsArtifactHttpAuthOauth2ClientSecretSecret =
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
  SubmitArgumentsArtifactHttpAuthOauth2EndpointParamModule = types.submodule {
    options = {
      "key" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSubmitArgumentsArtifactHttpAuthOauth2EndpointParam =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  SubmitArgumentsArtifactHttpAuthOauth2Module = types.submodule {
    options = {
      "clientIDSecret" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactHttpAuthOauth2ClientIDSecretModule);
        default = null;
      };
      "clientSecretSecret" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactHttpAuthOauth2ClientSecretSecretModule);
        default = null;
      };
      "endpointParams" = mkOption {
        type = (types.listOf SubmitArgumentsArtifactHttpAuthOauth2EndpointParamModule);
        default = [ ];
      };
      "scopes" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "tokenURLSecret" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactHttpAuthOauth2TokenURLSecretModule);
        default = null;
      };
    };
  };
  mkSubmitArgumentsArtifactHttpAuthOauth2 =
    res:
    {
    }
    // optionalAttrs (res."clientIDSecret" != null) {
      "clientIDSecret" = mkSubmitArgumentsArtifactHttpAuthOauth2ClientIDSecret res."clientIDSecret";
    }
    // {
    }
    // optionalAttrs (res."clientSecretSecret" != null) {
      "clientSecretSecret" =
        mkSubmitArgumentsArtifactHttpAuthOauth2ClientSecretSecret
          res."clientSecretSecret";
    }
    // {
    }
    // optionalAttrs (res."endpointParams" != [ ]) {
      "endpointParams" = map mkSubmitArgumentsArtifactHttpAuthOauth2EndpointParam res."endpointParams";
    }
    // {
    }
    // optionalAttrs (res."scopes" != [ ]) { inherit (res) "scopes"; }
    // {
    }
    // optionalAttrs (res."tokenURLSecret" != null) {
      "tokenURLSecret" = mkSubmitArgumentsArtifactHttpAuthOauth2TokenURLSecret res."tokenURLSecret";
    }
    // {
    };
  SubmitArgumentsArtifactHttpAuthOauth2TokenURLSecretModule = types.submodule {
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
  mkSubmitArgumentsArtifactHttpAuthOauth2TokenURLSecret =
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
  SubmitArgumentsArtifactHttpHeaderModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        type = types.str;
      };
    };
  };
  mkSubmitArgumentsArtifactHttpHeader = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  SubmitArgumentsArtifactHttpModule = types.submodule {
    options = {
      "auth" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactHttpAuthModule);
        default = null;
      };
      "headers" = mkOption {
        type = (types.listOf SubmitArgumentsArtifactHttpHeaderModule);
        default = [ ];
      };
      "url" = mkOption {
        type = types.str;
      };
    };
  };
  mkSubmitArgumentsArtifactHttp =
    res:
    {
    }
    // optionalAttrs (res."auth" != null) { "auth" = mkSubmitArgumentsArtifactHttpAuth res."auth"; }
    // {
    }
    // optionalAttrs (res."headers" != [ ]) {
      "headers" = map mkSubmitArgumentsArtifactHttpHeader res."headers";
    }
    // {
      inherit (res) "url";
    };
  SubmitArgumentsArtifactModule = types.submodule {
    options = {
      "archive" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactArchiveModule);
        default = null;
      };
      "archiveLogs" = mkOption {
        type = types.bool;
        default = false;
      };
      "artifactGC" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactArtifactGCModule);
        default = null;
      };
      "artifactory" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactArtifactoryModule);
        default = null;
      };
      "azure" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactAzureModule);
        default = null;
      };
      "deleted" = mkOption {
        type = types.bool;
        default = false;
      };
      "from" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "fromExpression" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "gcs" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactGcsModule);
        default = null;
      };
      "git" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactGitModule);
        default = null;
      };
      "globalName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "hdfs" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactHdfsModule);
        default = null;
      };
      "http" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactHttpModule);
        default = null;
      };
      "mode" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "name" = mkOption {
        type = types.str;
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
      "oss" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactOssModule);
        default = null;
      };
      "path" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "raw" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactRawModule);
        default = null;
      };
      "recurseMode" = mkOption {
        type = types.bool;
        default = false;
      };
      "s3" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactS3Module);
        default = null;
      };
      "subPath" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSubmitArgumentsArtifact =
    res:
    {
    }
    // optionalAttrs (res."archive" != null) {
      "archive" = mkSubmitArgumentsArtifactArchive res."archive";
    }
    // {
    }
    // optionalAttrs res."archiveLogs" { inherit (res) "archiveLogs"; }
    // {
    }
    // optionalAttrs (res."artifactGC" != null) {
      "artifactGC" = mkSubmitArgumentsArtifactArtifactGC res."artifactGC";
    }
    // {
    }
    // optionalAttrs (res."artifactory" != null) {
      "artifactory" = mkSubmitArgumentsArtifactArtifactory res."artifactory";
    }
    // {
    }
    // optionalAttrs (res."azure" != null) { "azure" = mkSubmitArgumentsArtifactAzure res."azure"; }
    // {
    }
    // optionalAttrs res."deleted" { inherit (res) "deleted"; }
    // {
    }
    // optionalAttrs (res."from" != null) { inherit (res) "from"; }
    // {
    }
    // optionalAttrs (res."fromExpression" != null) { inherit (res) "fromExpression"; }
    // {
    }
    // optionalAttrs (res."gcs" != null) { "gcs" = mkSubmitArgumentsArtifactGcs res."gcs"; }
    // {
    }
    // optionalAttrs (res."git" != null) { "git" = mkSubmitArgumentsArtifactGit res."git"; }
    // {
    }
    // optionalAttrs (res."globalName" != null) { inherit (res) "globalName"; }
    // {
    }
    // optionalAttrs (res."hdfs" != null) { "hdfs" = mkSubmitArgumentsArtifactHdfs res."hdfs"; }
    // {
    }
    // optionalAttrs (res."http" != null) { "http" = mkSubmitArgumentsArtifactHttp res."http"; }
    // {
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    }
    // optionalAttrs (res."oss" != null) { "oss" = mkSubmitArgumentsArtifactOss res."oss"; }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs (res."raw" != null) { "raw" = mkSubmitArgumentsArtifactRaw res."raw"; }
    // {
    }
    // optionalAttrs res."recurseMode" { inherit (res) "recurseMode"; }
    // {
    }
    // optionalAttrs (res."s3" != null) { "s3" = mkSubmitArgumentsArtifactS3 res."s3"; }
    // {
    }
    // optionalAttrs (res."subPath" != null) { inherit (res) "subPath"; }
    // {
    };
  SubmitArgumentsArtifactOssAccessKeySecretModule = types.submodule {
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
  mkSubmitArgumentsArtifactOssAccessKeySecret =
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
  SubmitArgumentsArtifactOssLifecycleRuleModule = types.submodule {
    options = {
      "markDeletionAfterDays" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "markInfrequentAccessAfterDays" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkSubmitArgumentsArtifactOssLifecycleRule =
    res:
    {
    }
    // optionalAttrs (res."markDeletionAfterDays" != null) { inherit (res) "markDeletionAfterDays"; }
    // {
    }
    // optionalAttrs (res."markInfrequentAccessAfterDays" != null) {
      inherit (res) "markInfrequentAccessAfterDays";
    }
    // {
    };
  SubmitArgumentsArtifactOssModule = types.submodule {
    options = {
      "accessKeySecret" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactOssAccessKeySecretModule);
        default = null;
      };
      "bucket" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "createBucketIfNotPresent" = mkOption {
        type = types.bool;
        default = false;
      };
      "endpoint" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "key" = mkOption {
        type = types.str;
      };
      "lifecycleRule" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactOssLifecycleRuleModule);
        default = null;
      };
      "secretKeySecret" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactOssSecretKeySecretModule);
        default = null;
      };
      "securityToken" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "useSDKCreds" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkSubmitArgumentsArtifactOss =
    res:
    {
    }
    // optionalAttrs (res."accessKeySecret" != null) {
      "accessKeySecret" = mkSubmitArgumentsArtifactOssAccessKeySecret res."accessKeySecret";
    }
    // {
    }
    // optionalAttrs (res."bucket" != null) { inherit (res) "bucket"; }
    // {
    }
    // optionalAttrs res."createBucketIfNotPresent" { inherit (res) "createBucketIfNotPresent"; }
    // {
    }
    // optionalAttrs (res."endpoint" != null) { inherit (res) "endpoint"; }
    // {
      inherit (res) "key";
    }
    // optionalAttrs (res."lifecycleRule" != null) {
      "lifecycleRule" = mkSubmitArgumentsArtifactOssLifecycleRule res."lifecycleRule";
    }
    // {
    }
    // optionalAttrs (res."secretKeySecret" != null) {
      "secretKeySecret" = mkSubmitArgumentsArtifactOssSecretKeySecret res."secretKeySecret";
    }
    // {
    }
    // optionalAttrs (res."securityToken" != null) { inherit (res) "securityToken"; }
    // {
    }
    // optionalAttrs res."useSDKCreds" { inherit (res) "useSDKCreds"; }
    // {
    };
  SubmitArgumentsArtifactOssSecretKeySecretModule = types.submodule {
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
  mkSubmitArgumentsArtifactOssSecretKeySecret =
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
  SubmitArgumentsArtifactRawModule = types.submodule {
    options = {
      "data" = mkOption {
        type = types.str;
      };
    };
  };
  mkSubmitArgumentsArtifactRaw = res: {
    inherit (res) "data";
  };
  SubmitArgumentsArtifactS3AccessKeySecretModule = types.submodule {
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
  mkSubmitArgumentsArtifactS3AccessKeySecret =
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
  SubmitArgumentsArtifactS3CaSecretModule = types.submodule {
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
  mkSubmitArgumentsArtifactS3CaSecret =
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
  SubmitArgumentsArtifactS3CreateBucketIfNotPresentModule = types.submodule {
    options = {
      "objectLocking" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkSubmitArgumentsArtifactS3CreateBucketIfNotPresent =
    res:
    {
    }
    // optionalAttrs res."objectLocking" { inherit (res) "objectLocking"; }
    // {
    };
  SubmitArgumentsArtifactS3EncryptionOptionsModule = types.submodule {
    options = {
      "enableEncryption" = mkOption {
        type = types.bool;
        default = false;
      };
      "kmsEncryptionContext" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "kmsKeyId" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "serverSideCustomerKeySecret" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactS3EncryptionOptionsServerSideCustomerKeySecretModule);
        default = null;
      };
    };
  };
  mkSubmitArgumentsArtifactS3EncryptionOptions =
    res:
    {
    }
    // optionalAttrs res."enableEncryption" { inherit (res) "enableEncryption"; }
    // {
    }
    // optionalAttrs (res."kmsEncryptionContext" != null) { inherit (res) "kmsEncryptionContext"; }
    // {
    }
    // optionalAttrs (res."kmsKeyId" != null) { inherit (res) "kmsKeyId"; }
    // {
    }
    // optionalAttrs (res."serverSideCustomerKeySecret" != null) {
      "serverSideCustomerKeySecret" =
        mkSubmitArgumentsArtifactS3EncryptionOptionsServerSideCustomerKeySecret
          res."serverSideCustomerKeySecret";
    }
    // {
    };
  SubmitArgumentsArtifactS3EncryptionOptionsServerSideCustomerKeySecretModule = types.submodule {
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
  mkSubmitArgumentsArtifactS3EncryptionOptionsServerSideCustomerKeySecret =
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
  SubmitArgumentsArtifactS3Module = types.submodule {
    options = {
      "accessKeySecret" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactS3AccessKeySecretModule);
        default = null;
      };
      "bucket" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "caSecret" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactS3CaSecretModule);
        default = null;
      };
      "createBucketIfNotPresent" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactS3CreateBucketIfNotPresentModule);
        default = null;
      };
      "encryptionOptions" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactS3EncryptionOptionsModule);
        default = null;
      };
      "endpoint" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "insecure" = mkOption {
        type = types.bool;
        default = false;
      };
      "key" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "region" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "roleARN" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "secretKeySecret" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactS3SecretKeySecretModule);
        default = null;
      };
      "sessionTokenSecret" = mkOption {
        type = (types.nullOr SubmitArgumentsArtifactS3SessionTokenSecretModule);
        default = null;
      };
      "useSDKCreds" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  mkSubmitArgumentsArtifactS3 =
    res:
    {
    }
    // optionalAttrs (res."accessKeySecret" != null) {
      "accessKeySecret" = mkSubmitArgumentsArtifactS3AccessKeySecret res."accessKeySecret";
    }
    // {
    }
    // optionalAttrs (res."bucket" != null) { inherit (res) "bucket"; }
    // {
    }
    // optionalAttrs (res."caSecret" != null) {
      "caSecret" = mkSubmitArgumentsArtifactS3CaSecret res."caSecret";
    }
    // {
    }
    // optionalAttrs (res."createBucketIfNotPresent" != null) {
      "createBucketIfNotPresent" =
        mkSubmitArgumentsArtifactS3CreateBucketIfNotPresent
          res."createBucketIfNotPresent";
    }
    // {
    }
    // optionalAttrs (res."encryptionOptions" != null) {
      "encryptionOptions" = mkSubmitArgumentsArtifactS3EncryptionOptions res."encryptionOptions";
    }
    // {
    }
    // optionalAttrs (res."endpoint" != null) { inherit (res) "endpoint"; }
    // {
    }
    // optionalAttrs res."insecure" { inherit (res) "insecure"; }
    // {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
    }
    // optionalAttrs (res."region" != null) { inherit (res) "region"; }
    // {
    }
    // optionalAttrs (res."roleARN" != null) { inherit (res) "roleARN"; }
    // {
    }
    // optionalAttrs (res."secretKeySecret" != null) {
      "secretKeySecret" = mkSubmitArgumentsArtifactS3SecretKeySecret res."secretKeySecret";
    }
    // {
    }
    // optionalAttrs (res."sessionTokenSecret" != null) {
      "sessionTokenSecret" = mkSubmitArgumentsArtifactS3SessionTokenSecret res."sessionTokenSecret";
    }
    // {
    }
    // optionalAttrs res."useSDKCreds" { inherit (res) "useSDKCreds"; }
    // {
    };
  SubmitArgumentsArtifactS3SecretKeySecretModule = types.submodule {
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
  mkSubmitArgumentsArtifactS3SecretKeySecret =
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
  SubmitArgumentsArtifactS3SessionTokenSecretModule = types.submodule {
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
  mkSubmitArgumentsArtifactS3SessionTokenSecret =
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
  SubmitArgumentsModule = types.submodule {
    options = {
      "artifacts" = mkOption {
        type = (types.listOf SubmitArgumentsArtifactModule);
        default = [ ];
      };
      "parameters" = mkOption {
        type = (types.listOf SubmitArgumentsParameterModule);
        default = [ ];
      };
    };
  };
  mkSubmitArguments =
    res:
    {
    }
    // optionalAttrs (res."artifacts" != [ ]) {
      "artifacts" = map mkSubmitArgumentsArtifact res."artifacts";
    }
    // {
    }
    // optionalAttrs (res."parameters" != [ ]) {
      "parameters" = map mkSubmitArgumentsParameter res."parameters";
    }
    // {
    };
  SubmitArgumentsParameterModule = types.submodule {
    options = {
      "default" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "description" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "enum" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "globalName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "valueFrom" = mkOption {
        type = (types.nullOr SubmitArgumentsParameterValueFromModule);
        default = null;
      };
    };
  };
  mkSubmitArgumentsParameter =
    res:
    {
    }
    // optionalAttrs (res."default" != null) { inherit (res) "default"; }
    // {
    }
    // optionalAttrs (res."description" != null) { inherit (res) "description"; }
    // {
    }
    // optionalAttrs (res."enum" != [ ]) { inherit (res) "enum"; }
    // {
    }
    // optionalAttrs (res."globalName" != null) { inherit (res) "globalName"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    }
    // optionalAttrs (res."valueFrom" != null) {
      "valueFrom" = mkSubmitArgumentsParameterValueFrom res."valueFrom";
    }
    // {
    };
  SubmitArgumentsParameterValueFromConfigMapKeyRefModule = types.submodule {
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
  mkSubmitArgumentsParameterValueFromConfigMapKeyRef =
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
  SubmitArgumentsParameterValueFromModule = types.submodule {
    options = {
      "configMapKeyRef" = mkOption {
        type = (types.nullOr SubmitArgumentsParameterValueFromConfigMapKeyRefModule);
        default = null;
      };
      "default" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "event" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "expression" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "jqFilter" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "jsonPath" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "parameter" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "path" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "supplied" = mkOption {
        type = (types.attrsOf types.anything);
        default = { };
      };
    };
  };
  mkSubmitArgumentsParameterValueFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapKeyRef" != null) {
      "configMapKeyRef" = mkSubmitArgumentsParameterValueFromConfigMapKeyRef res."configMapKeyRef";
    }
    // {
    }
    // optionalAttrs (res."default" != null) { inherit (res) "default"; }
    // {
    }
    // optionalAttrs (res."event" != null) { inherit (res) "event"; }
    // {
    }
    // optionalAttrs (res."expression" != null) { inherit (res) "expression"; }
    // {
    }
    // optionalAttrs (res."jqFilter" != null) { inherit (res) "jqFilter"; }
    // {
    }
    // optionalAttrs (res."jsonPath" != null) { inherit (res) "jsonPath"; }
    // {
    }
    // optionalAttrs (res."parameter" != null) { inherit (res) "parameter"; }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs (res."supplied" != { }) { inherit (res) "supplied"; }
    // {
    };
  SubmitMetadataModule = types.submodule {
    options = {
      "annotations" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "finalizers" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "generateName" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "labels" = mkOption {
        type = (types.attrsOf types.str);
        default = { };
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "namespace" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSubmitMetadata =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."finalizers" != [ ]) { inherit (res) "finalizers"; }
    // {
    }
    // optionalAttrs (res."generateName" != null) { inherit (res) "generateName"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  SubmitModule = types.submodule {
    options = {
      "arguments" = mkOption {
        type = (types.nullOr SubmitArgumentsModule);
        default = null;
      };
      "metadata" = mkOption {
        type = (types.nullOr SubmitMetadataModule);
        default = null;
      };
      "workflowTemplateRef" = mkOption {
        type = SubmitWorkflowTemplateRefModule;
      };
    };
  };
  mkSubmit =
    res:
    {
    }
    // optionalAttrs (res."arguments" != null) { "arguments" = mkSubmitArguments res."arguments"; }
    // {
    }
    // optionalAttrs (res."metadata" != null) { "metadata" = mkSubmitMetadata res."metadata"; }
    // {
      "workflowTemplateRef" = mkSubmitWorkflowTemplateRef res."workflowTemplateRef";
    };
  SubmitWorkflowTemplateRefModule = types.submodule {
    options = {
      "clusterScope" = mkOption {
        type = types.bool;
        default = false;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSubmitWorkflowTemplateRef =
    res:
    {
    }
    // optionalAttrs res."clusterScope" { inherit (res) "clusterScope"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  WorkfloweventbindingsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this WorkflowEventBinding resource.";
        };
        "event" = mkOption {
          type = EventModule;
        };
        "submit" = mkOption {
          type = (types.nullOr SubmitModule);
          default = null;
        };
      };
    }
  );
  mkWorkflowEventBinding = name: res: {
    apiVersion = "argoproj.io/v1alpha1";
    kind = "WorkflowEventBinding";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
      "event" = mkEvent res."event";
    }
    // optionalAttrs (res."submit" != null) { "submit" = mkSubmit res."submit"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkWorkflowEventBinding cfg."workfloweventbindings");
in
{
  options.openkrill.apps."argo-workflows" = {
    "workfloweventbindings" = mkOption {
      type = types.attrsOf WorkfloweventbindingsModule;
      default = { };
      description = "WorkflowEventBinding CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."argo-workflows".content = allResources;
  };
}
