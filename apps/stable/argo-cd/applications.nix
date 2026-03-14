# Auto-generated openkrill module fragment for argo-cd
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."argo-cd";
  compact = filterAttrs (_: v: v != null);
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
  IgnoreDifferenceModule = types.submodule {
    options = {
      "group" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "jqPathExpressions" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "jsonPointers" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "kind" = mkOption {
        type = types.str;
      };
      "managedFieldsManagers" = mkOption {
        description = "ManagedFieldsManagers is a list of trusted managers. Fields mutated by those managers will take precedence over the\ndesired state defined in the SCM and won't be displayed in diffs";
        type = (types.listOf types.str);
        default = [ ];
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
  mkIgnoreDifference =
    res:
    {
    }
    // optionalAttrs (res."group" != null) { inherit (res) "group"; }
    // {
    }
    // optionalAttrs (res."jqPathExpressions" != [ ]) { inherit (res) "jqPathExpressions"; }
    // {
    }
    // optionalAttrs (res."jsonPointers" != [ ]) { inherit (res) "jsonPointers"; }
    // {
      inherit (res) "kind";
    }
    // optionalAttrs (res."managedFieldsManagers" != [ ]) { inherit (res) "managedFieldsManagers"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  InfoModule = types.submodule {
    options = {
      "name" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        type = types.str;
      };
    };
  };
  mkInfo = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  SourceDirectoryJsonnetExtVarModule = types.submodule {
    options = {
      "code" = mkOption {
        type = types.bool;
        default = false;
      };
      "name" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        type = types.str;
      };
    };
  };
  mkSourceDirectoryJsonnetExtVar =
    res:
    {
    }
    // optionalAttrs res."code" { inherit (res) "code"; }
    // {
      inherit (res) "name";
      inherit (res) "value";
    };
  SourceDirectoryJsonnetModule = types.submodule {
    options = {
      "extVars" = mkOption {
        description = "ExtVars is a list of Jsonnet External Variables";
        type = (types.listOf SourceDirectoryJsonnetExtVarModule);
        default = [ ];
      };
      "libs" = mkOption {
        description = "Additional library search dirs";
        type = (types.listOf types.str);
        default = [ ];
      };
      "tlas" = mkOption {
        description = "TLAS is a list of Jsonnet Top-level Arguments";
        type = (types.listOf SourceDirectoryJsonnetTlaModule);
        default = [ ];
      };
    };
  };
  mkSourceDirectoryJsonnet =
    res:
    {
    }
    // optionalAttrs (res."extVars" != [ ]) {
      "extVars" = map mkSourceDirectoryJsonnetExtVar res."extVars";
    }
    // {
    }
    // optionalAttrs (res."libs" != [ ]) { inherit (res) "libs"; }
    // {
    }
    // optionalAttrs (res."tlas" != [ ]) { "tlas" = map mkSourceDirectoryJsonnetTla res."tlas"; }
    // {
    };
  SourceDirectoryJsonnetTlaModule = types.submodule {
    options = {
      "code" = mkOption {
        type = types.bool;
        default = false;
      };
      "name" = mkOption {
        type = types.str;
      };
      "value" = mkOption {
        type = types.str;
      };
    };
  };
  mkSourceDirectoryJsonnetTla =
    res:
    {
    }
    // optionalAttrs res."code" { inherit (res) "code"; }
    // {
      inherit (res) "name";
      inherit (res) "value";
    };
  SourceDirectoryModule = types.submodule {
    options = {
      "exclude" = mkOption {
        description = "Exclude contains a glob pattern to match paths against that should be explicitly excluded from being used during manifest generation";
        type = (types.nullOr types.str);
        default = null;
      };
      "include" = mkOption {
        description = "Include contains a glob pattern to match paths against that should be explicitly included during manifest generation";
        type = (types.nullOr types.str);
        default = null;
      };
      "jsonnet" = mkOption {
        description = "Jsonnet holds options specific to Jsonnet";
        type = (types.nullOr SourceDirectoryJsonnetModule);
        default = null;
      };
      "recurse" = mkOption {
        description = "Recurse specifies whether to scan a directory recursively for manifests";
        type = types.bool;
        default = false;
      };
    };
  };
  mkSourceDirectory =
    res:
    {
    }
    // optionalAttrs (res."exclude" != null) { inherit (res) "exclude"; }
    // {
    }
    // optionalAttrs (res."include" != null) { inherit (res) "include"; }
    // {
    }
    // optionalAttrs (res."jsonnet" != null) { "jsonnet" = mkSourceDirectoryJsonnet res."jsonnet"; }
    // {
    }
    // optionalAttrs res."recurse" { inherit (res) "recurse"; }
    // {
    };
  SourceHelmFileParameterModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the name of the Helm parameter";
        type = (types.nullOr types.str);
        default = null;
      };
      "path" = mkOption {
        description = "Path is the path to the file containing the values for the Helm parameter";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSourceHelmFileParameter =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    };
  SourceHelmModule = types.submodule {
    options = {
      "apiVersions" = mkOption {
        description = "APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,\nArgo CD uses the API versions of the target cluster. The format is [group/]version/kind.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "fileParameters" = mkOption {
        description = "FileParameters are file parameters to the helm template";
        type = (types.listOf SourceHelmFileParameterModule);
        default = [ ];
      };
      "ignoreMissingValueFiles" = mkOption {
        description = "IgnoreMissingValueFiles prevents helm template from failing when valueFiles do not exist locally by not appending them to helm template --values";
        type = types.bool;
        default = false;
      };
      "kubeVersion" = mkOption {
        description = "KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD\nuses the Kubernetes version of the target cluster.";
        type = (types.nullOr types.str);
        default = null;
      };
      "namespace" = mkOption {
        description = "Namespace is an optional namespace to template with. If left empty, defaults to the app's destination namespace.";
        type = (types.nullOr types.str);
        default = null;
      };
      "parameters" = mkOption {
        description = "Parameters is a list of Helm parameters which are passed to the helm template command upon manifest generation";
        type = (types.listOf SourceHelmParameterModule);
        default = [ ];
      };
      "passCredentials" = mkOption {
        description = "PassCredentials pass credentials to all domains (Helm's --pass-credentials)";
        type = types.bool;
        default = false;
      };
      "releaseName" = mkOption {
        description = "ReleaseName is the Helm release name to use. If omitted it will use the application name";
        type = (types.nullOr types.str);
        default = null;
      };
      "skipCrds" = mkOption {
        description = "SkipCrds skips custom resource definition installation step (Helm's --skip-crds)";
        type = types.bool;
        default = false;
      };
      "skipSchemaValidation" = mkOption {
        description = "SkipSchemaValidation skips JSON schema validation (Helm's --skip-schema-validation)";
        type = types.bool;
        default = false;
      };
      "skipTests" = mkOption {
        description = "SkipTests skips test manifest installation step (Helm's --skip-tests).";
        type = types.bool;
        default = false;
      };
      "valueFiles" = mkOption {
        description = "ValuesFiles is a list of Helm value files to use when generating a template";
        type = (types.listOf types.str);
        default = [ ];
      };
      "values" = mkOption {
        description = "Values specifies Helm values to be passed to helm template, typically defined as a block. ValuesObject takes precedence over Values, so use one or the other.";
        type = (types.nullOr types.str);
        default = null;
      };
      "valuesObject" = mkOption {
        description = "ValuesObject specifies Helm values to be passed to helm template, defined as a map. This takes precedence over Values.";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "version" = mkOption {
        description = "Version is the Helm version to use for templating (\"3\")";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSourceHelm =
    res:
    {
    }
    // optionalAttrs (res."apiVersions" != [ ]) { inherit (res) "apiVersions"; }
    // {
    }
    // optionalAttrs (res."fileParameters" != [ ]) {
      "fileParameters" = map mkSourceHelmFileParameter res."fileParameters";
    }
    // {
    }
    // optionalAttrs res."ignoreMissingValueFiles" { inherit (res) "ignoreMissingValueFiles"; }
    // {
    }
    // optionalAttrs (res."kubeVersion" != null) { inherit (res) "kubeVersion"; }
    // {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    }
    // optionalAttrs (res."parameters" != [ ]) {
      "parameters" = map mkSourceHelmParameter res."parameters";
    }
    // {
    }
    // optionalAttrs res."passCredentials" { inherit (res) "passCredentials"; }
    // {
    }
    // optionalAttrs (res."releaseName" != null) { inherit (res) "releaseName"; }
    // {
    }
    // optionalAttrs res."skipCrds" { inherit (res) "skipCrds"; }
    // {
    }
    // optionalAttrs res."skipSchemaValidation" { inherit (res) "skipSchemaValidation"; }
    // {
    }
    // optionalAttrs res."skipTests" { inherit (res) "skipTests"; }
    // {
    }
    // optionalAttrs (res."valueFiles" != [ ]) { inherit (res) "valueFiles"; }
    // {
    }
    // optionalAttrs (res."values" != null) { inherit (res) "values"; }
    // {
    }
    // optionalAttrs (res."valuesObject" != { }) { inherit (res) "valuesObject"; }
    // {
    }
    // optionalAttrs (res."version" != null) { inherit (res) "version"; }
    // {
    };
  SourceHelmParameterModule = types.submodule {
    options = {
      "forceString" = mkOption {
        description = "ForceString determines whether to tell Helm to interpret booleans and numbers as strings";
        type = types.bool;
        default = false;
      };
      "name" = mkOption {
        description = "Name is the name of the Helm parameter";
        type = (types.nullOr types.str);
        default = null;
      };
      "value" = mkOption {
        description = "Value is the value for the Helm parameter";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSourceHelmParameter =
    res:
    {
    }
    // optionalAttrs res."forceString" { inherit (res) "forceString"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    };
  SourceHydratorDrySourceModule = types.submodule {
    options = {
      "path" = mkOption {
        description = "Path is a directory path within the Git repository where the manifests are located";
        type = types.str;
      };
      "repoURL" = mkOption {
        description = "RepoURL is the URL to the git repository that contains the application manifests";
        type = types.str;
      };
      "targetRevision" = mkOption {
        description = "TargetRevision defines the revision of the source to hydrate";
        type = types.str;
      };
    };
  };
  mkSourceHydratorDrySource = res: {
    inherit (res) "path";
    inherit (res) "repoURL";
    inherit (res) "targetRevision";
  };
  SourceHydratorHydrateToModule = types.submodule {
    options = {
      "targetBranch" = mkOption {
        description = "TargetBranch is the branch to which hydrated manifests should be committed";
        type = types.str;
      };
    };
  };
  mkSourceHydratorHydrateTo = res: {
    inherit (res) "targetBranch";
  };
  SourceHydratorModule = types.submodule {
    options = {
      "drySource" = mkOption {
        description = "DrySource specifies where the dry \"don't repeat yourself\" manifest source lives.";
        type = SourceHydratorDrySourceModule;
      };
      "hydrateTo" = mkOption {
        description = "HydrateTo specifies an optional \"staging\" location to push hydrated manifests to. An external system would then\nhave to move manifests to the SyncSource, e.g. by pull request.";
        type = (types.nullOr SourceHydratorHydrateToModule);
        default = null;
      };
      "syncSource" = mkOption {
        description = "SyncSource specifies where to sync hydrated manifests from.";
        type = SourceHydratorSyncSourceModule;
      };
    };
  };
  mkSourceHydrator =
    res:
    {
      "drySource" = mkSourceHydratorDrySource res."drySource";
    }
    // optionalAttrs (res."hydrateTo" != null) {
      "hydrateTo" = mkSourceHydratorHydrateTo res."hydrateTo";
    }
    // {
      "syncSource" = mkSourceHydratorSyncSource res."syncSource";
    };
  SourceHydratorSyncSourceModule = types.submodule {
    options = {
      "path" = mkOption {
        description = "Path is a directory path within the git repository where hydrated manifests should be committed to and synced\nfrom. If hydrateTo is set, this is just the path from which hydrated manifests will be synced.";
        type = types.str;
      };
      "targetBranch" = mkOption {
        description = "TargetBranch is the branch to which hydrated manifests should be committed";
        type = types.str;
      };
    };
  };
  mkSourceHydratorSyncSource = res: {
    inherit (res) "path";
    inherit (res) "targetBranch";
  };
  SourceKustomizeModule = types.submodule {
    options = {
      "apiVersions" = mkOption {
        description = "APIVersions specifies the Kubernetes resource API versions to pass to Helm when templating manifests. By default,\nArgo CD uses the API versions of the target cluster. The format is [group/]version/kind.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "commonAnnotations" = mkOption {
        description = "CommonAnnotations is a list of additional annotations to add to rendered manifests";
        type = (types.attrsOf types.str);
        default = { };
      };
      "commonAnnotationsEnvsubst" = mkOption {
        description = "CommonAnnotationsEnvsubst specifies whether to apply env variables substitution for annotation values";
        type = types.bool;
        default = false;
      };
      "commonLabels" = mkOption {
        description = "CommonLabels is a list of additional labels to add to rendered manifests";
        type = (types.attrsOf types.str);
        default = { };
      };
      "components" = mkOption {
        description = "Components specifies a list of kustomize components to add to the kustomization before building";
        type = (types.listOf types.str);
        default = [ ];
      };
      "forceCommonAnnotations" = mkOption {
        description = "ForceCommonAnnotations specifies whether to force applying common annotations to resources for Kustomize apps";
        type = types.bool;
        default = false;
      };
      "forceCommonLabels" = mkOption {
        description = "ForceCommonLabels specifies whether to force applying common labels to resources for Kustomize apps";
        type = types.bool;
        default = false;
      };
      "ignoreMissingComponents" = mkOption {
        description = "IgnoreMissingComponents prevents kustomize from failing when components do not exist locally by not appending them to kustomization file";
        type = types.bool;
        default = false;
      };
      "images" = mkOption {
        description = "Images is a list of Kustomize image override specifications";
        type = (types.listOf types.str);
        default = [ ];
      };
      "kubeVersion" = mkOption {
        description = "KubeVersion specifies the Kubernetes API version to pass to Helm when templating manifests. By default, Argo CD\nuses the Kubernetes version of the target cluster.";
        type = (types.nullOr types.str);
        default = null;
      };
      "labelIncludeTemplates" = mkOption {
        description = "LabelIncludeTemplates specifies whether to apply common labels to resource templates or not";
        type = types.bool;
        default = false;
      };
      "labelWithoutSelector" = mkOption {
        description = "LabelWithoutSelector specifies whether to apply common labels to resource selectors or not";
        type = types.bool;
        default = false;
      };
      "namePrefix" = mkOption {
        description = "NamePrefix is a prefix appended to resources for Kustomize apps";
        type = (types.nullOr types.str);
        default = null;
      };
      "nameSuffix" = mkOption {
        description = "NameSuffix is a suffix appended to resources for Kustomize apps";
        type = (types.nullOr types.str);
        default = null;
      };
      "namespace" = mkOption {
        description = "Namespace sets the namespace that Kustomize adds to all resources";
        type = (types.nullOr types.str);
        default = null;
      };
      "patches" = mkOption {
        description = "Patches is a list of Kustomize patches";
        type = (types.listOf SourceKustomizePatcheModule);
        default = [ ];
      };
      "replicas" = mkOption {
        description = "Replicas is a list of Kustomize Replicas override specifications";
        type = (types.listOf SourceKustomizeReplicaModule);
        default = [ ];
      };
      "version" = mkOption {
        description = "Version controls which version of Kustomize to use for rendering manifests";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSourceKustomize =
    res:
    {
    }
    // optionalAttrs (res."apiVersions" != [ ]) { inherit (res) "apiVersions"; }
    // {
    }
    // optionalAttrs (res."commonAnnotations" != { }) { inherit (res) "commonAnnotations"; }
    // {
    }
    // optionalAttrs res."commonAnnotationsEnvsubst" { inherit (res) "commonAnnotationsEnvsubst"; }
    // {
    }
    // optionalAttrs (res."commonLabels" != { }) { inherit (res) "commonLabels"; }
    // {
    }
    // optionalAttrs (res."components" != [ ]) { inherit (res) "components"; }
    // {
    }
    // optionalAttrs res."forceCommonAnnotations" { inherit (res) "forceCommonAnnotations"; }
    // {
    }
    // optionalAttrs res."forceCommonLabels" { inherit (res) "forceCommonLabels"; }
    // {
    }
    // optionalAttrs res."ignoreMissingComponents" { inherit (res) "ignoreMissingComponents"; }
    // {
    }
    // optionalAttrs (res."images" != [ ]) { inherit (res) "images"; }
    // {
    }
    // optionalAttrs (res."kubeVersion" != null) { inherit (res) "kubeVersion"; }
    // {
    }
    // optionalAttrs res."labelIncludeTemplates" { inherit (res) "labelIncludeTemplates"; }
    // {
    }
    // optionalAttrs res."labelWithoutSelector" { inherit (res) "labelWithoutSelector"; }
    // {
    }
    // optionalAttrs (res."namePrefix" != null) { inherit (res) "namePrefix"; }
    // {
    }
    // optionalAttrs (res."nameSuffix" != null) { inherit (res) "nameSuffix"; }
    // {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    }
    // optionalAttrs (res."patches" != [ ]) { "patches" = map mkSourceKustomizePatche res."patches"; }
    // {
    }
    // optionalAttrs (res."replicas" != [ ]) {
      "replicas" = map mkSourceKustomizeReplica res."replicas";
    }
    // {
    }
    // optionalAttrs (res."version" != null) { inherit (res) "version"; }
    // {
    };
  SourceKustomizePatcheModule = types.submodule {
    options = {
      "options" = mkOption {
        type = (types.attrsOf types.bool);
        default = { };
      };
      "patch" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "path" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "target" = mkOption {
        type = (types.nullOr SourceKustomizePatcheTargetModule);
        default = null;
      };
    };
  };
  mkSourceKustomizePatche =
    res:
    {
    }
    // optionalAttrs (res."options" != { }) { inherit (res) "options"; }
    // {
    }
    // optionalAttrs (res."patch" != null) { inherit (res) "patch"; }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs (res."target" != null) { "target" = mkSourceKustomizePatcheTarget res."target"; }
    // {
    };
  SourceKustomizePatcheTargetModule = types.submodule {
    options = {
      "annotationSelector" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "group" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "kind" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "labelSelector" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "namespace" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "version" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSourceKustomizePatcheTarget =
    res:
    {
    }
    // optionalAttrs (res."annotationSelector" != null) { inherit (res) "annotationSelector"; }
    // {
    }
    // optionalAttrs (res."group" != null) { inherit (res) "group"; }
    // {
    }
    // optionalAttrs (res."kind" != null) { inherit (res) "kind"; }
    // {
    }
    // optionalAttrs (res."labelSelector" != null) { inherit (res) "labelSelector"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    }
    // optionalAttrs (res."version" != null) { inherit (res) "version"; }
    // {
    };
  SourceKustomizeReplicaModule = types.submodule {
    options = {
      "count" = mkOption {
        description = "Number of replicas";
        type = types.anything;
      };
      "name" = mkOption {
        description = "Name of Deployment or StatefulSet";
        type = types.str;
      };
    };
  };
  mkSourceKustomizeReplica = res: {
    inherit (res) "count";
    inherit (res) "name";
  };
  SourceModule = types.submodule {
    options = {
      "chart" = mkOption {
        description = "Chart is a Helm chart name, and must be specified for applications sourced from a Helm repo.";
        type = (types.nullOr types.str);
        default = null;
      };
      "directory" = mkOption {
        description = "Directory holds path/directory specific options";
        type = (types.nullOr SourceDirectoryModule);
        default = null;
      };
      "helm" = mkOption {
        description = "Helm holds helm specific options";
        type = (types.nullOr SourceHelmModule);
        default = null;
      };
      "kustomize" = mkOption {
        description = "Kustomize holds kustomize specific options";
        type = (types.nullOr SourceKustomizeModule);
        default = null;
      };
      "name" = mkOption {
        description = "Name is used to refer to a source and is displayed in the UI. It is used in multi-source Applications.";
        type = (types.nullOr types.str);
        default = null;
      };
      "path" = mkOption {
        description = "Path is a directory path within the Git repository, and is only valid for applications sourced from Git.";
        type = (types.nullOr types.str);
        default = null;
      };
      "plugin" = mkOption {
        description = "Plugin holds config management plugin specific options";
        type = (types.nullOr SourcePluginModule);
        default = null;
      };
      "ref" = mkOption {
        description = "Ref is reference to another source within sources field. This field will not be used if used with a `source` tag.";
        type = (types.nullOr types.str);
        default = null;
      };
      "repoURL" = mkOption {
        description = "RepoURL is the URL to the repository (Git or Helm) that contains the application manifests";
        type = types.str;
      };
      "targetRevision" = mkOption {
        description = "TargetRevision defines the revision of the source to sync the application to.\nIn case of Git, this can be commit, tag, or branch. If omitted, will equal to HEAD.\nIn case of Helm, this is a semver tag for the Chart's version.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSource =
    res:
    {
    }
    // optionalAttrs (res."chart" != null) { inherit (res) "chart"; }
    // {
    }
    // optionalAttrs (res."directory" != null) { "directory" = mkSourceDirectory res."directory"; }
    // {
    }
    // optionalAttrs (res."helm" != null) { "helm" = mkSourceHelm res."helm"; }
    // {
    }
    // optionalAttrs (res."kustomize" != null) { "kustomize" = mkSourceKustomize res."kustomize"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs (res."plugin" != null) { "plugin" = mkSourcePlugin res."plugin"; }
    // {
    }
    // optionalAttrs (res."ref" != null) { inherit (res) "ref"; }
    // {
      inherit (res) "repoURL";
    }
    // optionalAttrs (res."targetRevision" != null) { inherit (res) "targetRevision"; }
    // {
    };
  SourcePluginEnvModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name is the name of the variable, usually expressed in uppercase";
        type = types.str;
      };
      "value" = mkOption {
        description = "Value is the value of the variable";
        type = types.str;
      };
    };
  };
  mkSourcePluginEnv = res: {
    inherit (res) "name";
    inherit (res) "value";
  };
  SourcePluginModule = types.submodule {
    options = {
      "env" = mkOption {
        description = "Env is a list of environment variable entries";
        type = (types.listOf SourcePluginEnvModule);
        default = [ ];
      };
      "name" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "parameters" = mkOption {
        type = (types.listOf SourcePluginParameterModule);
        default = [ ];
      };
    };
  };
  mkSourcePlugin =
    res:
    {
    }
    // optionalAttrs (res."env" != [ ]) { "env" = map mkSourcePluginEnv res."env"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."parameters" != [ ]) {
      "parameters" = map mkSourcePluginParameter res."parameters";
    }
    // {
    };
  SourcePluginParameterModule = types.submodule {
    options = {
      "array" = mkOption {
        description = "Array is the value of an array type parameter.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "map" = mkOption {
        description = "Map is the value of a map type parameter.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "name" = mkOption {
        description = "Name is the name identifying a parameter.";
        type = (types.nullOr types.str);
        default = null;
      };
      "string" = mkOption {
        description = "String_ is the value of a string type parameter.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSourcePluginParameter =
    res:
    {
    }
    // optionalAttrs (res."array" != [ ]) { inherit (res) "array"; }
    // {
    }
    // optionalAttrs (res."map" != { }) { inherit (res) "map"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."string" != null) { inherit (res) "string"; }
    // {
    };
  SyncPolicyAutomatedModule = types.submodule {
    options = {
      "allowEmpty" = mkOption {
        description = "AllowEmpty allows apps have zero live resources (default: false)";
        type = types.bool;
        default = false;
      };
      "enabled" = mkOption {
        description = "Enable allows apps to explicitly control automated sync";
        type = types.bool;
        default = false;
      };
      "prune" = mkOption {
        description = "Prune specifies whether to delete resources from the cluster that are not found in the sources anymore as part of automated sync (default: false)";
        type = types.bool;
        default = false;
      };
      "selfHeal" = mkOption {
        description = "SelfHeal specifies whether to revert resources back to their desired state upon modification in the cluster (default: false)";
        type = types.bool;
        default = false;
      };
    };
  };
  mkSyncPolicyAutomated =
    res:
    {
    }
    // optionalAttrs res."allowEmpty" { inherit (res) "allowEmpty"; }
    // {
    }
    // optionalAttrs res."enabled" { inherit (res) "enabled"; }
    // {
    }
    // optionalAttrs res."prune" { inherit (res) "prune"; }
    // {
    }
    // optionalAttrs res."selfHeal" { inherit (res) "selfHeal"; }
    // {
    };
  SyncPolicyManagedNamespaceMetadataModule = types.submodule {
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
  mkSyncPolicyManagedNamespaceMetadata =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    };
  SyncPolicyModule = types.submodule {
    options = {
      "automated" = mkOption {
        description = "Automated will keep an application synced to the target revision";
        type = (types.nullOr SyncPolicyAutomatedModule);
        default = null;
      };
      "managedNamespaceMetadata" = mkOption {
        description = "ManagedNamespaceMetadata controls metadata in the given namespace (if CreateNamespace=true)";
        type = (types.nullOr SyncPolicyManagedNamespaceMetadataModule);
        default = null;
      };
      "retry" = mkOption {
        description = "Retry controls failed sync retry behavior";
        type = (types.nullOr SyncPolicyRetryModule);
        default = null;
      };
      "syncOptions" = mkOption {
        description = "Options allow you to specify whole app sync-options";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkSyncPolicy =
    res:
    {
    }
    // optionalAttrs (res."automated" != null) { "automated" = mkSyncPolicyAutomated res."automated"; }
    // {
    }
    // optionalAttrs (res."managedNamespaceMetadata" != null) {
      "managedNamespaceMetadata" = mkSyncPolicyManagedNamespaceMetadata res."managedNamespaceMetadata";
    }
    // {
    }
    // optionalAttrs (res."retry" != null) { "retry" = mkSyncPolicyRetry res."retry"; }
    // {
    }
    // optionalAttrs (res."syncOptions" != [ ]) { inherit (res) "syncOptions"; }
    // {
    };
  SyncPolicyRetryBackoffModule = types.submodule {
    options = {
      "duration" = mkOption {
        description = "Duration is the amount to back off. Default unit is seconds, but could also be a duration (e.g. \"2m\", \"1h\")";
        type = (types.nullOr types.str);
        default = null;
      };
      "factor" = mkOption {
        description = "Factor is a factor to multiply the base duration after each failed retry";
        type = (types.nullOr types.int);
        default = null;
      };
      "maxDuration" = mkOption {
        description = "MaxDuration is the maximum amount of time allowed for the backoff strategy";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkSyncPolicyRetryBackoff =
    res:
    {
    }
    // optionalAttrs (res."duration" != null) { inherit (res) "duration"; }
    // {
    }
    // optionalAttrs (res."factor" != null) { inherit (res) "factor"; }
    // {
    }
    // optionalAttrs (res."maxDuration" != null) { inherit (res) "maxDuration"; }
    // {
    };
  SyncPolicyRetryModule = types.submodule {
    options = {
      "backoff" = mkOption {
        description = "Backoff controls how to backoff on subsequent retries of failed syncs";
        type = (types.nullOr SyncPolicyRetryBackoffModule);
        default = null;
      };
      "limit" = mkOption {
        description = "Limit is the maximum number of attempts for retrying a failed sync. If set to 0, no retries will be performed.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkSyncPolicyRetry =
    res:
    {
    }
    // optionalAttrs (res."backoff" != null) { "backoff" = mkSyncPolicyRetryBackoff res."backoff"; }
    // {
    }
    // optionalAttrs (res."limit" != null) { inherit (res) "limit"; }
    // {
    };
  ApplicationsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this Application resource.";
        };
        "destination" = mkOption {
          description = "Destination is a reference to the target Kubernetes server and namespace";
          type = DestinationModule;
        };
        "ignoreDifferences" = mkOption {
          description = "IgnoreDifferences is a list of resources and their fields which should be ignored during comparison";
          type = (types.listOf IgnoreDifferenceModule);
          default = [ ];
        };
        "info" = mkOption {
          description = "Info contains a list of information (URLs, email addresses, and plain text) that relates to the application";
          type = (types.listOf InfoModule);
          default = [ ];
        };
        "project" = mkOption {
          description = "Project is a reference to the project this application belongs to.\nThe empty string means that application belongs to the 'default' project.";
          type = types.str;
        };
        "revisionHistoryLimit" = mkOption {
          description = "RevisionHistoryLimit limits the number of items kept in the application's revision history, which is used for informational purposes as well as for rollbacks to previous versions.\nThis should only be changed in exceptional circumstances.\nSetting to zero will store no history. This will reduce storage used.\nIncreasing will increase the space used to store the history, so we do not recommend increasing it.\nDefault is 10.";
          type = (types.nullOr types.int);
          default = null;
        };
        "source" = mkOption {
          description = "Source is a reference to the location of the application's manifests or chart";
          type = (types.nullOr SourceModule);
          default = null;
        };
        "sourceHydrator" = mkOption {
          description = "SourceHydrator provides a way to push hydrated manifests back to git before syncing them to the cluster.";
          type = (types.nullOr SourceHydratorModule);
          default = null;
        };
        "sources" = mkOption {
          description = "Sources is a reference to the location of the application's manifests or chart";
          type = (types.listOf SourceModule);
          default = [ ];
        };
        "syncPolicy" = mkOption {
          description = "SyncPolicy controls when and how a sync will be performed";
          type = (types.nullOr SyncPolicyModule);
          default = null;
        };
      };
    }
  );
  mkApplication = name: res: {
    apiVersion = "argoproj.io/v1alpha1";
    kind = "Application";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
      "destination" = mkDestination res."destination";
    }
    // optionalAttrs (res."ignoreDifferences" != [ ]) {
      "ignoreDifferences" = map mkIgnoreDifference res."ignoreDifferences";
    }
    // {
    }
    // optionalAttrs (res."info" != [ ]) { "info" = map mkInfo res."info"; }
    // {
      inherit (res) "project";
    }
    // optionalAttrs (res."revisionHistoryLimit" != null) { inherit (res) "revisionHistoryLimit"; }
    // {
    }
    // optionalAttrs (res."source" != null) { "source" = mkSource res."source"; }
    // {
    }
    // optionalAttrs (res."sourceHydrator" != null) {
      "sourceHydrator" = mkSourceHydrator res."sourceHydrator";
    }
    // {
    }
    // optionalAttrs (res."sources" != [ ]) { "sources" = map mkSource res."sources"; }
    // {
    }
    // optionalAttrs (res."syncPolicy" != null) { "syncPolicy" = mkSyncPolicy res."syncPolicy"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkApplication cfg."applications");
in
{
  options.openkrill.apps."argo-cd" = {
    "applications" = mkOption {
      type = types.attrsOf ApplicationsModule;
      default = { };
      description = "Application CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."argo-cd".content = allResources;
  };
}
