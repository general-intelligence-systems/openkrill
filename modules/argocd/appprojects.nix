# Auto-generated openkrill module fragment for argocd
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."argocd";
  compact = filterAttrs (_: v: v != null);
  ClusterResourceBlacklistModule = types.submodule {
    options = {
      "group" = mkOption {
        type = types.str;
      };
      "kind" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        description = "Name is the name of the restricted resource. Glob patterns using Go's filepath.Match syntax are supported.\nUnlike the group and kind fields, if no name is specified, all resources of the specified group/kind are matched.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkClusterResourceBlacklist =
    res:
    {
      inherit (res) "group";
      inherit (res) "kind";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  ClusterResourceWhitelistModule = types.submodule {
    options = {
      "group" = mkOption {
        type = types.str;
      };
      "kind" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        description = "Name is the name of the restricted resource. Glob patterns using Go's filepath.Match syntax are supported.\nUnlike the group and kind fields, if no name is specified, all resources of the specified group/kind are matched.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkClusterResourceWhitelist =
    res:
    {
      inherit (res) "group";
      inherit (res) "kind";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  DestinationModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is an alternate way of specifying the target cluster by its symbolic name. This must be set if Server is not set.";
        type = (types.nullOr types.str);
        default = null;
      };
      "namespace" = mkOption {
        description = "Namespace specifies the target namespace for the application's resources.\nThe namespace will only be set for namespace-scoped resources that have not set a value for .metadata.namespace";
        type = (types.nullOr types.str);
        default = null;
      };
      "server" = mkOption {
        description = "Server specifies the URL of the target cluster's Kubernetes control plane API. This must be set if Name is not set.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDestination =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    }
    // optionalAttrs (res."server" != null) { inherit (res) "server"; }
    // {
    };
  DestinationServiceAccountModule = types.submodule {
    options = {
      "defaultServiceAccount" = mkOption {
        description = "DefaultServiceAccount to be used for impersonation during the sync operation";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "Namespace specifies the target namespace for the application's resources.";
        type = (types.nullOr types.str);
        default = null;
      };
      "server" = mkOption {
        description = "Server specifies the URL of the target cluster's Kubernetes control plane API.";
        type = types.str;
      };
    };
  };
  mkDestinationServiceAccount =
    res:
    {
      inherit (res) "defaultServiceAccount";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
      inherit (res) "server";
    };
  NamespaceResourceBlacklistModule = types.submodule {
    options = {
      "group" = mkOption {
        type = types.str;
      };
      "kind" = mkOption {
        type = types.str;
      };
    };
  };
  mkNamespaceResourceBlacklist = res: {
    inherit (res) "group";
    inherit (res) "kind";
  };
  NamespaceResourceWhitelistModule = types.submodule {
    options = {
      "group" = mkOption {
        type = types.str;
      };
      "kind" = mkOption {
        type = types.str;
      };
    };
  };
  mkNamespaceResourceWhitelist = res: {
    inherit (res) "group";
    inherit (res) "kind";
  };
  OrphanedResourcesIgnoreModule = types.submodule {
    options = {
      "group" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "kind" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkOrphanedResourcesIgnore =
    res:
    {
    }
    // optionalAttrs (res."group" != null) { inherit (res) "group"; }
    // {
    }
    // optionalAttrs (res."kind" != null) { inherit (res) "kind"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    };
  OrphanedResourcesModule = types.submodule {
    options = {
      "ignore" = mkOption {
        description = "Ignore contains a list of resources that are to be excluded from orphaned resources monitoring";
        type = (types.listOf OrphanedResourcesIgnoreModule);
        default = [ ];
      };
      "warn" = mkOption {
        description = "Warn indicates if warning condition should be created for apps which have orphaned resources";
        type = types.bool;
        default = false;
      };
    };
  };
  mkOrphanedResources =
    res:
    {
    }
    // optionalAttrs (res."ignore" != [ ]) { "ignore" = map mkOrphanedResourcesIgnore res."ignore"; }
    // {
    }
    // optionalAttrs res."warn" { inherit (res) "warn"; }
    // {
    };
  RoleJwtTokenModule = types.submodule {
    options = {
      "exp" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "iat" = mkOption {
        type = types.int;
      };
      "id" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkRoleJwtToken =
    res:
    {
    }
    // optionalAttrs (res."exp" != null) { inherit (res) "exp"; }
    // {
      inherit (res) "iat";
    }
    // optionalAttrs (res."id" != null) { inherit (res) "id"; }
    // {
    };
  RoleModule = types.submodule {
    options = {
      "description" = mkOption {
        description = "Description is a description of the role";
        type = (types.nullOr types.str);
        default = null;
      };
      "groups" = mkOption {
        description = "Groups are a list of OIDC group claims bound to this role";
        type = (types.listOf types.str);
        default = [ ];
      };
      "jwtTokens" = mkOption {
        description = "JWTTokens are a list of generated JWT tokens bound to this role";
        type = (types.listOf RoleJwtTokenModule);
        default = [ ];
      };
      "name" = mkOption {
        description = "Name is a name for this role";
        type = types.str;
      };
      "policies" = mkOption {
        description = "Policies Stores a list of casbin formatted strings that define access policies for the role in the project";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkRole =
    res:
    {
    }
    // optionalAttrs (res."description" != null) { inherit (res) "description"; }
    // {
    }
    // optionalAttrs (res."groups" != [ ]) { inherit (res) "groups"; }
    // {
    }
    // optionalAttrs (res."jwtTokens" != [ ]) { "jwtTokens" = map mkRoleJwtToken res."jwtTokens"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."policies" != [ ]) { inherit (res) "policies"; }
    // {
    };
  SignatureKeyModule = types.submodule {
    options = {
      "keyID" = mkOption {
        description = "The ID of the key in hexadecimal notation";
        type = types.str;
      };
    };
  };
  mkSignatureKey = res: {
    inherit (res) "keyID";
  };
  SyncWindowModule = types.submodule {
    options = {
      "andOperator" = mkOption {
        description = "UseAndOperator use AND operator for matching applications, namespaces and clusters instead of the default OR operator";
        type = types.bool;
        default = false;
      };
      "applications" = mkOption {
        description = "Applications contains a list of applications that the window will apply to";
        type = (types.listOf types.str);
        default = [ ];
      };
      "clusters" = mkOption {
        description = "Clusters contains a list of clusters that the window will apply to";
        type = (types.listOf types.str);
        default = [ ];
      };
      "description" = mkOption {
        description = "Description of the sync that will be applied to the schedule, can be used to add any information such as a ticket number for example";
        type = (types.nullOr types.str);
        default = null;
      };
      "duration" = mkOption {
        description = "Duration is the amount of time the sync window will be open";
        type = (types.nullOr types.str);
        default = null;
      };
      "kind" = mkOption {
        description = "Kind defines if the window allows or blocks syncs";
        type = (types.nullOr types.str);
        default = null;
      };
      "manualSync" = mkOption {
        description = "ManualSync enables manual syncs when they would otherwise be blocked";
        type = types.bool;
        default = false;
      };
      "namespaces" = mkOption {
        description = "Namespaces contains a list of namespaces that the window will apply to";
        type = (types.listOf types.str);
        default = [ ];
      };
      "schedule" = mkOption {
        description = "Schedule is the time the window will begin, specified in cron format";
        type = (types.nullOr types.str);
        default = null;
      };
      "timeZone" = mkOption {
        description = "TimeZone of the sync that will be applied to the schedule";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSyncWindow =
    res:
    {
    }
    // optionalAttrs res."andOperator" { inherit (res) "andOperator"; }
    // {
    }
    // optionalAttrs (res."applications" != [ ]) { inherit (res) "applications"; }
    // {
    }
    // optionalAttrs (res."clusters" != [ ]) { inherit (res) "clusters"; }
    // {
    }
    // optionalAttrs (res."description" != null) { inherit (res) "description"; }
    // {
    }
    // optionalAttrs (res."duration" != null) { inherit (res) "duration"; }
    // {
    }
    // optionalAttrs (res."kind" != null) { inherit (res) "kind"; }
    // {
    }
    // optionalAttrs res."manualSync" { inherit (res) "manualSync"; }
    // {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
    }
    // optionalAttrs (res."schedule" != null) { inherit (res) "schedule"; }
    // {
    }
    // optionalAttrs (res."timeZone" != null) { inherit (res) "timeZone"; }
    // {
    };
  AppprojectsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this AppProject resource.";
        };
        "clusterResourceBlacklist" = mkOption {
          description = "ClusterResourceBlacklist contains list of blacklisted cluster level resources";
          type = (types.listOf ClusterResourceBlacklistModule);
          default = [ ];
        };
        "clusterResourceWhitelist" = mkOption {
          description = "ClusterResourceWhitelist contains list of whitelisted cluster level resources";
          type = (types.listOf ClusterResourceWhitelistModule);
          default = [ ];
        };
        "description" = mkOption {
          description = "Description contains optional project description";
          type = (types.nullOr types.str);
          default = null;
        };
        "destinationServiceAccounts" = mkOption {
          description = "DestinationServiceAccounts holds information about the service accounts to be impersonated for the application sync operation for each destination.";
          type = (types.listOf DestinationServiceAccountModule);
          default = [ ];
        };
        "destinations" = mkOption {
          description = "Destinations contains list of destinations available for deployment";
          type = (types.listOf DestinationModule);
          default = [ ];
        };
        "namespaceResourceBlacklist" = mkOption {
          description = "NamespaceResourceBlacklist contains list of blacklisted namespace level resources";
          type = (types.listOf NamespaceResourceBlacklistModule);
          default = [ ];
        };
        "namespaceResourceWhitelist" = mkOption {
          description = "NamespaceResourceWhitelist contains list of whitelisted namespace level resources";
          type = (types.listOf NamespaceResourceWhitelistModule);
          default = [ ];
        };
        "orphanedResources" = mkOption {
          description = "OrphanedResources specifies if controller should monitor orphaned resources of apps in this project";
          type = (types.nullOr OrphanedResourcesModule);
          default = null;
        };
        "permitOnlyProjectScopedClusters" = mkOption {
          description = "PermitOnlyProjectScopedClusters determines whether destinations can only reference clusters which are project-scoped";
          type = types.bool;
          default = false;
        };
        "roles" = mkOption {
          description = "Roles are user defined RBAC roles associated with this project";
          type = (types.listOf RoleModule);
          default = [ ];
        };
        "signatureKeys" = mkOption {
          description = "SignatureKeys contains a list of PGP key IDs that commits in Git must be signed with in order to be allowed for sync";
          type = (types.listOf SignatureKeyModule);
          default = [ ];
        };
        "sourceNamespaces" = mkOption {
          description = "SourceNamespaces defines the namespaces application resources are allowed to be created in";
          type = (types.listOf types.str);
          default = [ ];
        };
        "sourceRepos" = mkOption {
          description = "SourceRepos contains list of repository URLs which can be used for deployment";
          type = (types.listOf types.str);
          default = [ ];
        };
        "syncWindows" = mkOption {
          description = "SyncWindows controls when syncs can be run for apps in this project";
          type = (types.listOf SyncWindowModule);
          default = [ ];
        };
      };
    }
  );
  mkAppProject = name: res: {
    apiVersion = "argoproj.io/v1alpha1";
    kind = "AppProject";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."clusterResourceBlacklist" != [ ]) {
      "clusterResourceBlacklist" = map mkClusterResourceBlacklist res."clusterResourceBlacklist";
    }
    // {
    }
    // optionalAttrs (res."clusterResourceWhitelist" != [ ]) {
      "clusterResourceWhitelist" = map mkClusterResourceWhitelist res."clusterResourceWhitelist";
    }
    // {
    }
    // optionalAttrs (res."description" != null) { inherit (res) "description"; }
    // {
    }
    // optionalAttrs (res."destinationServiceAccounts" != [ ]) {
      "destinationServiceAccounts" = map mkDestinationServiceAccount res."destinationServiceAccounts";
    }
    // {
    }
    // optionalAttrs (res."destinations" != [ ]) {
      "destinations" = map mkDestination res."destinations";
    }
    // {
    }
    // optionalAttrs (res."namespaceResourceBlacklist" != [ ]) {
      "namespaceResourceBlacklist" = map mkNamespaceResourceBlacklist res."namespaceResourceBlacklist";
    }
    // {
    }
    // optionalAttrs (res."namespaceResourceWhitelist" != [ ]) {
      "namespaceResourceWhitelist" = map mkNamespaceResourceWhitelist res."namespaceResourceWhitelist";
    }
    // {
    }
    // optionalAttrs (res."orphanedResources" != null) {
      "orphanedResources" = mkOrphanedResources res."orphanedResources";
    }
    // {
    }
    // optionalAttrs res."permitOnlyProjectScopedClusters" {
      inherit (res) "permitOnlyProjectScopedClusters";
    }
    // {
    }
    // optionalAttrs (res."roles" != [ ]) { "roles" = map mkRole res."roles"; }
    // {
    }
    // optionalAttrs (res."signatureKeys" != [ ]) {
      "signatureKeys" = map mkSignatureKey res."signatureKeys";
    }
    // {
    }
    // optionalAttrs (res."sourceNamespaces" != [ ]) { inherit (res) "sourceNamespaces"; }
    // {
    }
    // optionalAttrs (res."sourceRepos" != [ ]) { inherit (res) "sourceRepos"; }
    // {
    }
    // optionalAttrs (res."syncWindows" != [ ]) { "syncWindows" = map mkSyncWindow res."syncWindows"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkAppProject cfg."appprojects");
in
{
  options.openkrill.apps."argocd" = {
    "appprojects" = mkOption {
      type = types.attrsOf AppprojectsModule;
      default = { };
      description = "AppProject CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."argocd".content = allResources;
  };
}
