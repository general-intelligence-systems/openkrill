# Auto-generated openkrill module fragment for flux
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."flux";
  compact = filterAttrs (_: v: v != null);
  ChartMetadataModule = types.submodule {
    options = {
      "annotations" = mkOption {
        description = "Annotations is an unstructured key value map stored with a resource that may be\nset by external tools to store and retrieve arbitrary metadata. They are not\nqueryable and should be preserved when modifying objects.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/";
        type = (types.attrsOf types.str);
        default = { };
      };
      "labels" = mkOption {
        description = "Map of string keys and values that can be used to organize and categorize\n(scope and select) objects.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkChartMetadata =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    };
  ChartModule = types.submodule {
    options = {
      "metadata" = mkOption {
        description = "ObjectMeta holds the template for metadata like labels and annotations.";
        type = (types.nullOr ChartMetadataModule);
        default = null;
      };
      "spec" = mkOption {
        description = "Spec holds the template for the v1.HelmChartSpec for this HelmRelease.";
        type = ChartSpecModule;
      };
    };
  };
  mkChart =
    res:
    {
    }
    // optionalAttrs (res."metadata" != null) { "metadata" = mkChartMetadata res."metadata"; }
    // {
      "spec" = mkChartSpec res."spec";
    };
  ChartRefModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        description = "APIVersion of the referent.";
        type = (types.nullOr types.str);
        default = null;
      };
      "kind" = mkOption {
        description = "Kind of the referent.";
        type = (
          types.enum [
            "OCIRepository"
            "HelmChart"
          ]
        );
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
      "namespace" = mkOption {
        description = "Namespace of the referent, defaults to the namespace of the Kubernetes\nresource object that contains the reference.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkChartRef =
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
  ChartSpecModule = types.submodule {
    options = {
      "chart" = mkOption {
        description = "The name or path the Helm chart is available at in the SourceRef.";
        type = types.str;
      };
      "ignoreMissingValuesFiles" = mkOption {
        description = "IgnoreMissingValuesFiles controls whether to silently ignore missing values files rather than failing.";
        type = types.bool;
        default = false;
      };
      "interval" = mkOption {
        description = "Interval at which to check the v1.Source for updates. Defaults to\n'HelmReleaseSpec.Interval'.";
        type = (types.nullOr types.str);
        default = null;
      };
      "reconcileStrategy" = mkOption {
        description = "Determines what enables the creation of a new artifact. Valid values are\n('ChartVersion', 'Revision').\nSee the documentation of the values for an explanation on their behavior.\nDefaults to ChartVersion when omitted.";
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
        description = "The name and namespace of the v1.Source the chart is available at.";
        type = ChartSpecSourceRefModule;
      };
      "valuesFiles" = mkOption {
        description = "Alternative list of values files to use as the chart values (values.yaml\nis not included by default), expected to be a relative path in the SourceRef.\nValues files are merged in the order of this list with the last file overriding\nthe first. Ignored when omitted.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "verify" = mkOption {
        description = "Verify contains the secret name containing the trusted public keys\nused to verify the signature and specifies which provider to use to check\nwhether OCI image is authentic.\nThis field is only supported for OCI sources.\nChart dependencies, which are not bundled in the umbrella chart artifact,\nare not verified.";
        type = (types.nullOr ChartSpecVerifyModule);
        default = null;
      };
      "version" = mkOption {
        description = "Version semver expression, ignored for charts from v1.GitRepository and\nv1beta2.Bucket sources. Defaults to latest when omitted.";
        type = (types.nullOr types.str);
        default = "*";
      };
    };
  };
  mkChartSpec =
    res:
    {
      inherit (res) "chart";
    }
    // optionalAttrs res."ignoreMissingValuesFiles" { inherit (res) "ignoreMissingValuesFiles"; }
    // {
    }
    // optionalAttrs (res."interval" != null) { inherit (res) "interval"; }
    // {
    }
    // optionalAttrs (res."reconcileStrategy" != null) { inherit (res) "reconcileStrategy"; }
    // {
      "sourceRef" = mkChartSpecSourceRef res."sourceRef";
    }
    // optionalAttrs (res."valuesFiles" != [ ]) { inherit (res) "valuesFiles"; }
    // {
    }
    // optionalAttrs (res."verify" != null) { "verify" = mkChartSpecVerify res."verify"; }
    // {
    }
    // optionalAttrs (res."version" != null) { inherit (res) "version"; }
    // {
    };
  ChartSpecSourceRefModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        description = "APIVersion of the referent.";
        type = (types.nullOr types.str);
        default = null;
      };
      "kind" = mkOption {
        description = "Kind of the referent.";
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
      "namespace" = mkOption {
        description = "Namespace of the referent.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkChartSpecSourceRef =
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
  ChartSpecVerifyModule = types.submodule {
    options = {
      "provider" = mkOption {
        description = "Provider specifies the technology used to sign the OCI Helm chart.";
        type = (
          types.enum [
            "cosign"
            "notation"
          ]
        );
      };
      "secretRef" = mkOption {
        description = "SecretRef specifies the Kubernetes Secret containing the\ntrusted public keys.";
        type = (types.nullOr ChartSpecVerifySecretRefModule);
        default = null;
      };
    };
  };
  mkChartSpecVerify =
    res:
    {
      inherit (res) "provider";
    }
    // optionalAttrs (res."secretRef" != null) {
      "secretRef" = mkChartSpecVerifySecretRef res."secretRef";
    }
    // {
    };
  ChartSpecVerifySecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkChartSpecVerifySecretRef = res: {
    inherit (res) "name";
  };
  DependsOnModule = types.submodule {
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
  mkDependsOn =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  DriftDetectionIgnoreModule = types.submodule {
    options = {
      "paths" = mkOption {
        description = "Paths is a list of JSON Pointer (RFC 6901) paths to be excluded from\nconsideration in a Kubernetes object.";
        type = (types.listOf types.str);
      };
      "target" = mkOption {
        description = "Target is a selector for specifying Kubernetes objects to which this\nrule applies.\nIf Target is not set, the Paths will be ignored for all Kubernetes\nobjects within the manifest of the Helm release.";
        type = (types.nullOr DriftDetectionIgnoreTargetModule);
        default = null;
      };
    };
  };
  mkDriftDetectionIgnore =
    res:
    {
      inherit (res) "paths";
    }
    // optionalAttrs (res."target" != null) { "target" = mkDriftDetectionIgnoreTarget res."target"; }
    // {
    };
  DriftDetectionIgnoreTargetModule = types.submodule {
    options = {
      "annotationSelector" = mkOption {
        description = "AnnotationSelector is a string that follows the label selection expression\nhttps://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api\nIt matches with the resource annotations.";
        type = (types.nullOr types.str);
        default = null;
      };
      "group" = mkOption {
        description = "Group is the API group to select resources from.\nTogether with Version and Kind it is capable of unambiguously identifying and/or selecting resources.\nhttps://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md";
        type = (types.nullOr types.str);
        default = null;
      };
      "kind" = mkOption {
        description = "Kind of the API Group to select resources from.\nTogether with Group and Version it is capable of unambiguously\nidentifying and/or selecting resources.\nhttps://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md";
        type = (types.nullOr types.str);
        default = null;
      };
      "labelSelector" = mkOption {
        description = "LabelSelector is a string that follows the label selection expression\nhttps://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api\nIt matches with the resource labels.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "Name to match resources with.";
        type = (types.nullOr types.str);
        default = null;
      };
      "namespace" = mkOption {
        description = "Namespace to select resources from.";
        type = (types.nullOr types.str);
        default = null;
      };
      "version" = mkOption {
        description = "Version of the API Group to select resources from.\nTogether with Group and Kind it is capable of unambiguously identifying and/or selecting resources.\nhttps://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDriftDetectionIgnoreTarget =
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
  DriftDetectionModule = types.submodule {
    options = {
      "ignore" = mkOption {
        description = "Ignore contains a list of rules for specifying which changes to ignore\nduring diffing.";
        type = (types.listOf DriftDetectionIgnoreModule);
        default = [ ];
      };
      "mode" = mkOption {
        description = "Mode defines how differences should be handled between the Helm manifest\nand the manifest currently applied to the cluster.\nIf not explicitly set, it defaults to DiffModeDisabled.";
        type = (
          types.nullOr (
            types.enum [
              "enabled"
              "warn"
              "disabled"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkDriftDetection =
    res:
    {
    }
    // optionalAttrs (res."ignore" != [ ]) { "ignore" = map mkDriftDetectionIgnore res."ignore"; }
    // {
    }
    // optionalAttrs (res."mode" != null) { inherit (res) "mode"; }
    // {
    };
  InstallModule = types.submodule {
    options = {
      "crds" = mkOption {
        description = "CRDs upgrade CRDs from the Helm Chart's crds directory according\nto the CRD upgrade policy provided here. Valid values are `Skip`,\n`Create` or `CreateReplace`. Default is `Create` and if omitted\nCRDs are installed but not updated.\n\nSkip: do neither install nor replace (update) any CRDs.\n\nCreate: new CRDs are created, existing CRDs are neither updated nor deleted.\n\nCreateReplace: new CRDs are created, existing CRDs are updated (replaced)\nbut not deleted.\n\nBy default, CRDs are applied (installed) during Helm install action.\nWith this option users can opt in to CRD replace existing CRDs on Helm\ninstall actions, which is not (yet) natively supported by Helm.\nhttps://helm.sh/docs/chart_best_practices/custom_resource_definitions.";
        type = (
          types.nullOr (
            types.enum [
              "Skip"
              "Create"
              "CreateReplace"
            ]
          )
        );
        default = null;
      };
      "createNamespace" = mkOption {
        description = "CreateNamespace tells the Helm install action to create the\nHelmReleaseSpec.TargetNamespace if it does not exist yet.\nOn uninstall, the namespace will not be garbage collected.";
        type = types.bool;
        default = false;
      };
      "disableHooks" = mkOption {
        description = "DisableHooks prevents hooks from running during the Helm install action.";
        type = types.bool;
        default = false;
      };
      "disableOpenAPIValidation" = mkOption {
        description = "DisableOpenAPIValidation prevents the Helm install action from validating\nrendered templates against the Kubernetes OpenAPI Schema.";
        type = types.bool;
        default = false;
      };
      "disableSchemaValidation" = mkOption {
        description = "DisableSchemaValidation prevents the Helm install action from validating\nthe values against the JSON Schema.";
        type = types.bool;
        default = false;
      };
      "disableTakeOwnership" = mkOption {
        description = "DisableTakeOwnership disables taking ownership of existing resources\nduring the Helm install action. Defaults to false.";
        type = types.bool;
        default = false;
      };
      "disableWait" = mkOption {
        description = "DisableWait disables the waiting for resources to be ready after a Helm\ninstall has been performed.";
        type = types.bool;
        default = false;
      };
      "disableWaitForJobs" = mkOption {
        description = "DisableWaitForJobs disables waiting for jobs to complete after a Helm\ninstall has been performed.";
        type = types.bool;
        default = false;
      };
      "remediation" = mkOption {
        description = "Remediation holds the remediation configuration for when the Helm install\naction for the HelmRelease fails. The default is to not perform any action.";
        type = (types.nullOr InstallRemediationModule);
        default = null;
      };
      "replace" = mkOption {
        description = "Replace tells the Helm install action to re-use the 'ReleaseName', but only\nif that name is a deleted release which remains in the history.";
        type = types.bool;
        default = false;
      };
      "skipCRDs" = mkOption {
        description = "SkipCRDs tells the Helm install action to not install any CRDs. By default,\nCRDs are installed if not already present.\n\nDeprecated use CRD policy (`crds`) attribute with value `Skip` instead.";
        type = types.bool;
        default = false;
      };
      "timeout" = mkOption {
        description = "Timeout is the time to wait for any individual Kubernetes operation (like\nJobs for hooks) during the performance of a Helm install action. Defaults to\n'HelmReleaseSpec.Timeout'.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkInstall =
    res:
    {
    }
    // optionalAttrs (res."crds" != null) { inherit (res) "crds"; }
    // {
    }
    // optionalAttrs res."createNamespace" { inherit (res) "createNamespace"; }
    // {
    }
    // optionalAttrs res."disableHooks" { inherit (res) "disableHooks"; }
    // {
    }
    // optionalAttrs res."disableOpenAPIValidation" { inherit (res) "disableOpenAPIValidation"; }
    // {
    }
    // optionalAttrs res."disableSchemaValidation" { inherit (res) "disableSchemaValidation"; }
    // {
    }
    // optionalAttrs res."disableTakeOwnership" { inherit (res) "disableTakeOwnership"; }
    // {
    }
    // optionalAttrs res."disableWait" { inherit (res) "disableWait"; }
    // {
    }
    // optionalAttrs res."disableWaitForJobs" { inherit (res) "disableWaitForJobs"; }
    // {
    }
    // optionalAttrs (res."remediation" != null) {
      "remediation" = mkInstallRemediation res."remediation";
    }
    // {
    }
    // optionalAttrs res."replace" { inherit (res) "replace"; }
    // {
    }
    // optionalAttrs res."skipCRDs" { inherit (res) "skipCRDs"; }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    };
  InstallRemediationModule = types.submodule {
    options = {
      "ignoreTestFailures" = mkOption {
        description = "IgnoreTestFailures tells the controller to skip remediation when the Helm\ntests are run after an install action but fail. Defaults to\n'Test.IgnoreFailures'.";
        type = types.bool;
        default = false;
      };
      "remediateLastFailure" = mkOption {
        description = "RemediateLastFailure tells the controller to remediate the last failure, when\nno retries remain. Defaults to 'false'.";
        type = types.bool;
        default = false;
      };
      "retries" = mkOption {
        description = "Retries is the number of retries that should be attempted on failures before\nbailing. Remediation, using an uninstall, is performed between each attempt.\nDefaults to '0', a negative integer equals to unlimited retries.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkInstallRemediation =
    res:
    {
    }
    // optionalAttrs res."ignoreTestFailures" { inherit (res) "ignoreTestFailures"; }
    // {
    }
    // optionalAttrs res."remediateLastFailure" { inherit (res) "remediateLastFailure"; }
    // {
    }
    // optionalAttrs (res."retries" != null) { inherit (res) "retries"; }
    // {
    };
  KubeConfigModule = types.submodule {
    options = {
      "secretRef" = mkOption {
        description = "SecretRef holds the name of a secret that contains a key with\nthe kubeconfig file as the value. If no key is set, the key will default\nto 'value'.\nIt is recommended that the kubeconfig is self-contained, and the secret\nis regularly updated if credentials such as a cloud-access-token expire.\nCloud specific `cmd-path` auth helpers will not function without adding\nbinaries and credentials to the Pod that is responsible for reconciling\nKubernetes resources.";
        type = KubeConfigSecretRefModule;
      };
    };
  };
  mkKubeConfig = res: {
    "secretRef" = mkKubeConfigSecretRef res."secretRef";
  };
  KubeConfigSecretRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "Key in the Secret, when not specified an implementation-specific default key is used.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "Name of the Secret.";
        type = types.str;
      };
    };
  };
  mkKubeConfigSecretRef =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
      inherit (res) "name";
    };
  PostRendererKustomizeImageModule = types.submodule {
    options = {
      "digest" = mkOption {
        description = "Digest is the value used to replace the original image tag.\nIf digest is present NewTag value is ignored.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "Name is a tag-less image name.";
        type = types.str;
      };
      "newName" = mkOption {
        description = "NewName is the value used to replace the original name.";
        type = (types.nullOr types.str);
        default = null;
      };
      "newTag" = mkOption {
        description = "NewTag is the value used to replace the original tag.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkPostRendererKustomizeImage =
    res:
    {
    }
    // optionalAttrs (res."digest" != null) { inherit (res) "digest"; }
    // {
      inherit (res) "name";
    }
    // optionalAttrs (res."newName" != null) { inherit (res) "newName"; }
    // {
    }
    // optionalAttrs (res."newTag" != null) { inherit (res) "newTag"; }
    // {
    };
  PostRendererKustomizeModule = types.submodule {
    options = {
      "images" = mkOption {
        description = "Images is a list of (image name, new name, new tag or digest)\nfor changing image names, tags or digests. This can also be achieved with a\npatch, but this operator is simpler to specify.";
        type = (types.listOf PostRendererKustomizeImageModule);
        default = [ ];
      };
      "patches" = mkOption {
        description = "Strategic merge and JSON patches, defined as inline YAML objects,\ncapable of targeting objects based on kind, label and annotation selectors.";
        type = (types.listOf PostRendererKustomizePatcheModule);
        default = [ ];
      };
    };
  };
  mkPostRendererKustomize =
    res:
    {
    }
    // optionalAttrs (res."images" != [ ]) { "images" = map mkPostRendererKustomizeImage res."images"; }
    // {
    }
    // optionalAttrs (res."patches" != [ ]) {
      "patches" = map mkPostRendererKustomizePatche res."patches";
    }
    // {
    };
  PostRendererKustomizePatcheModule = types.submodule {
    options = {
      "patch" = mkOption {
        description = "Patch contains an inline StrategicMerge patch or an inline JSON6902 patch with\nan array of operation objects.";
        type = types.str;
      };
      "target" = mkOption {
        description = "Target points to the resources that the patch document should be applied to.";
        type = (types.nullOr PostRendererKustomizePatcheTargetModule);
        default = null;
      };
    };
  };
  mkPostRendererKustomizePatche =
    res:
    {
      inherit (res) "patch";
    }
    // optionalAttrs (res."target" != null) {
      "target" = mkPostRendererKustomizePatcheTarget res."target";
    }
    // {
    };
  PostRendererKustomizePatcheTargetModule = types.submodule {
    options = {
      "annotationSelector" = mkOption {
        description = "AnnotationSelector is a string that follows the label selection expression\nhttps://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api\nIt matches with the resource annotations.";
        type = (types.nullOr types.str);
        default = null;
      };
      "group" = mkOption {
        description = "Group is the API group to select resources from.\nTogether with Version and Kind it is capable of unambiguously identifying and/or selecting resources.\nhttps://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md";
        type = (types.nullOr types.str);
        default = null;
      };
      "kind" = mkOption {
        description = "Kind of the API Group to select resources from.\nTogether with Group and Version it is capable of unambiguously\nidentifying and/or selecting resources.\nhttps://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md";
        type = (types.nullOr types.str);
        default = null;
      };
      "labelSelector" = mkOption {
        description = "LabelSelector is a string that follows the label selection expression\nhttps://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api\nIt matches with the resource labels.";
        type = (types.nullOr types.str);
        default = null;
      };
      "name" = mkOption {
        description = "Name to match resources with.";
        type = (types.nullOr types.str);
        default = null;
      };
      "namespace" = mkOption {
        description = "Namespace to select resources from.";
        type = (types.nullOr types.str);
        default = null;
      };
      "version" = mkOption {
        description = "Version of the API Group to select resources from.\nTogether with Group and Kind it is capable of unambiguously identifying and/or selecting resources.\nhttps://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkPostRendererKustomizePatcheTarget =
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
  PostRendererModule = types.submodule {
    options = {
      "kustomize" = mkOption {
        description = "Kustomization to apply as PostRenderer.";
        type = (types.nullOr PostRendererKustomizeModule);
        default = null;
      };
    };
  };
  mkPostRenderer =
    res:
    {
    }
    // optionalAttrs (res."kustomize" != null) {
      "kustomize" = mkPostRendererKustomize res."kustomize";
    }
    // {
    };
  RollbackModule = types.submodule {
    options = {
      "cleanupOnFail" = mkOption {
        description = "CleanupOnFail allows deletion of new resources created during the Helm\nrollback action when it fails.";
        type = types.bool;
        default = false;
      };
      "disableHooks" = mkOption {
        description = "DisableHooks prevents hooks from running during the Helm rollback action.";
        type = types.bool;
        default = false;
      };
      "disableWait" = mkOption {
        description = "DisableWait disables the waiting for resources to be ready after a Helm\nrollback has been performed.";
        type = types.bool;
        default = false;
      };
      "disableWaitForJobs" = mkOption {
        description = "DisableWaitForJobs disables waiting for jobs to complete after a Helm\nrollback has been performed.";
        type = types.bool;
        default = false;
      };
      "force" = mkOption {
        description = "Force forces resource updates through a replacement strategy.";
        type = types.bool;
        default = false;
      };
      "recreate" = mkOption {
        description = "Recreate performs pod restarts for the resource if applicable.";
        type = types.bool;
        default = false;
      };
      "timeout" = mkOption {
        description = "Timeout is the time to wait for any individual Kubernetes operation (like\nJobs for hooks) during the performance of a Helm rollback action. Defaults to\n'HelmReleaseSpec.Timeout'.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkRollback =
    res:
    {
    }
    // optionalAttrs res."cleanupOnFail" { inherit (res) "cleanupOnFail"; }
    // {
    }
    // optionalAttrs res."disableHooks" { inherit (res) "disableHooks"; }
    // {
    }
    // optionalAttrs res."disableWait" { inherit (res) "disableWait"; }
    // {
    }
    // optionalAttrs res."disableWaitForJobs" { inherit (res) "disableWaitForJobs"; }
    // {
    }
    // optionalAttrs res."force" { inherit (res) "force"; }
    // {
    }
    // optionalAttrs res."recreate" { inherit (res) "recreate"; }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    };
  TestFilterModule = types.submodule {
    options = {
      "exclude" = mkOption {
        description = "Exclude specifies whether the named test should be excluded.";
        type = types.bool;
        default = false;
      };
      "name" = mkOption {
        description = "Name is the name of the test.";
        type = types.str;
      };
    };
  };
  mkTestFilter =
    res:
    {
    }
    // optionalAttrs res."exclude" { inherit (res) "exclude"; }
    // {
      inherit (res) "name";
    };
  TestModule = types.submodule {
    options = {
      "enable" = mkOption {
        description = "Enable enables Helm test actions for this HelmRelease after an Helm install\nor upgrade action has been performed.";
        type = types.bool;
        default = false;
      };
      "filters" = mkOption {
        description = "Filters is a list of tests to run or exclude from running.";
        type = (types.listOf TestFilterModule);
        default = [ ];
      };
      "ignoreFailures" = mkOption {
        description = "IgnoreFailures tells the controller to skip remediation when the Helm tests\nare run but fail. Can be overwritten for tests run after install or upgrade\nactions in 'Install.IgnoreTestFailures' and 'Upgrade.IgnoreTestFailures'.";
        type = types.bool;
        default = false;
      };
      "timeout" = mkOption {
        description = "Timeout is the time to wait for any individual Kubernetes operation during\nthe performance of a Helm test action. Defaults to 'HelmReleaseSpec.Timeout'.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTest =
    res:
    {
    }
    // optionalAttrs res."enable" { inherit (res) "enable"; }
    // {
    }
    // optionalAttrs (res."filters" != [ ]) { "filters" = map mkTestFilter res."filters"; }
    // {
    }
    // optionalAttrs res."ignoreFailures" { inherit (res) "ignoreFailures"; }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    };
  UninstallModule = types.submodule {
    options = {
      "deletionPropagation" = mkOption {
        description = "DeletionPropagation specifies the deletion propagation policy when\na Helm uninstall is performed.";
        type = (
          types.nullOr (
            types.enum [
              "background"
              "foreground"
              "orphan"
            ]
          )
        );
        default = "background";
      };
      "disableHooks" = mkOption {
        description = "DisableHooks prevents hooks from running during the Helm rollback action.";
        type = types.bool;
        default = false;
      };
      "disableWait" = mkOption {
        description = "DisableWait disables waiting for all the resources to be deleted after\na Helm uninstall is performed.";
        type = types.bool;
        default = false;
      };
      "keepHistory" = mkOption {
        description = "KeepHistory tells Helm to remove all associated resources and mark the\nrelease as deleted, but retain the release history.";
        type = types.bool;
        default = false;
      };
      "timeout" = mkOption {
        description = "Timeout is the time to wait for any individual Kubernetes operation (like\nJobs for hooks) during the performance of a Helm uninstall action. Defaults\nto 'HelmReleaseSpec.Timeout'.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkUninstall =
    res:
    {
    }
    // optionalAttrs (res."deletionPropagation" != null) { inherit (res) "deletionPropagation"; }
    // {
    }
    // optionalAttrs res."disableHooks" { inherit (res) "disableHooks"; }
    // {
    }
    // optionalAttrs res."disableWait" { inherit (res) "disableWait"; }
    // {
    }
    // optionalAttrs res."keepHistory" { inherit (res) "keepHistory"; }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    };
  UpgradeModule = types.submodule {
    options = {
      "cleanupOnFail" = mkOption {
        description = "CleanupOnFail allows deletion of new resources created during the Helm\nupgrade action when it fails.";
        type = types.bool;
        default = false;
      };
      "crds" = mkOption {
        description = "CRDs upgrade CRDs from the Helm Chart's crds directory according\nto the CRD upgrade policy provided here. Valid values are `Skip`,\n`Create` or `CreateReplace`. Default is `Skip` and if omitted\nCRDs are neither installed nor upgraded.\n\nSkip: do neither install nor replace (update) any CRDs.\n\nCreate: new CRDs are created, existing CRDs are neither updated nor deleted.\n\nCreateReplace: new CRDs are created, existing CRDs are updated (replaced)\nbut not deleted.\n\nBy default, CRDs are not applied during Helm upgrade action. With this\noption users can opt-in to CRD upgrade, which is not (yet) natively supported by Helm.\nhttps://helm.sh/docs/chart_best_practices/custom_resource_definitions.";
        type = (
          types.nullOr (
            types.enum [
              "Skip"
              "Create"
              "CreateReplace"
            ]
          )
        );
        default = null;
      };
      "disableHooks" = mkOption {
        description = "DisableHooks prevents hooks from running during the Helm upgrade action.";
        type = types.bool;
        default = false;
      };
      "disableOpenAPIValidation" = mkOption {
        description = "DisableOpenAPIValidation prevents the Helm upgrade action from validating\nrendered templates against the Kubernetes OpenAPI Schema.";
        type = types.bool;
        default = false;
      };
      "disableSchemaValidation" = mkOption {
        description = "DisableSchemaValidation prevents the Helm upgrade action from validating\nthe values against the JSON Schema.";
        type = types.bool;
        default = false;
      };
      "disableTakeOwnership" = mkOption {
        description = "DisableTakeOwnership disables taking ownership of existing resources\nduring the Helm upgrade action. Defaults to false.";
        type = types.bool;
        default = false;
      };
      "disableWait" = mkOption {
        description = "DisableWait disables the waiting for resources to be ready after a Helm\nupgrade has been performed.";
        type = types.bool;
        default = false;
      };
      "disableWaitForJobs" = mkOption {
        description = "DisableWaitForJobs disables waiting for jobs to complete after a Helm\nupgrade has been performed.";
        type = types.bool;
        default = false;
      };
      "force" = mkOption {
        description = "Force forces resource updates through a replacement strategy.";
        type = types.bool;
        default = false;
      };
      "preserveValues" = mkOption {
        description = "PreserveValues will make Helm reuse the last release's values and merge in\noverrides from 'Values'. Setting this flag makes the HelmRelease\nnon-declarative.";
        type = types.bool;
        default = false;
      };
      "remediation" = mkOption {
        description = "Remediation holds the remediation configuration for when the Helm upgrade\naction for the HelmRelease fails. The default is to not perform any action.";
        type = (types.nullOr UpgradeRemediationModule);
        default = null;
      };
      "timeout" = mkOption {
        description = "Timeout is the time to wait for any individual Kubernetes operation (like\nJobs for hooks) during the performance of a Helm upgrade action. Defaults to\n'HelmReleaseSpec.Timeout'.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkUpgrade =
    res:
    {
    }
    // optionalAttrs res."cleanupOnFail" { inherit (res) "cleanupOnFail"; }
    // {
    }
    // optionalAttrs (res."crds" != null) { inherit (res) "crds"; }
    // {
    }
    // optionalAttrs res."disableHooks" { inherit (res) "disableHooks"; }
    // {
    }
    // optionalAttrs res."disableOpenAPIValidation" { inherit (res) "disableOpenAPIValidation"; }
    // {
    }
    // optionalAttrs res."disableSchemaValidation" { inherit (res) "disableSchemaValidation"; }
    // {
    }
    // optionalAttrs res."disableTakeOwnership" { inherit (res) "disableTakeOwnership"; }
    // {
    }
    // optionalAttrs res."disableWait" { inherit (res) "disableWait"; }
    // {
    }
    // optionalAttrs res."disableWaitForJobs" { inherit (res) "disableWaitForJobs"; }
    // {
    }
    // optionalAttrs res."force" { inherit (res) "force"; }
    // {
    }
    // optionalAttrs res."preserveValues" { inherit (res) "preserveValues"; }
    // {
    }
    // optionalAttrs (res."remediation" != null) {
      "remediation" = mkUpgradeRemediation res."remediation";
    }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    };
  UpgradeRemediationModule = types.submodule {
    options = {
      "ignoreTestFailures" = mkOption {
        description = "IgnoreTestFailures tells the controller to skip remediation when the Helm\ntests are run after an upgrade action but fail.\nDefaults to 'Test.IgnoreFailures'.";
        type = types.bool;
        default = false;
      };
      "remediateLastFailure" = mkOption {
        description = "RemediateLastFailure tells the controller to remediate the last failure, when\nno retries remain. Defaults to 'false' unless 'Retries' is greater than 0.";
        type = types.bool;
        default = false;
      };
      "retries" = mkOption {
        description = "Retries is the number of retries that should be attempted on failures before\nbailing. Remediation, using 'Strategy', is performed between each attempt.\nDefaults to '0', a negative integer equals to unlimited retries.";
        type = (types.nullOr types.int);
        default = null;
      };
      "strategy" = mkOption {
        description = "Strategy to use for failure remediation. Defaults to 'rollback'.";
        type = (
          types.nullOr (
            types.enum [
              "rollback"
              "uninstall"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkUpgradeRemediation =
    res:
    {
    }
    // optionalAttrs res."ignoreTestFailures" { inherit (res) "ignoreTestFailures"; }
    // {
    }
    // optionalAttrs res."remediateLastFailure" { inherit (res) "remediateLastFailure"; }
    // {
    }
    // optionalAttrs (res."retries" != null) { inherit (res) "retries"; }
    // {
    }
    // optionalAttrs (res."strategy" != null) { inherit (res) "strategy"; }
    // {
    };
  ValuesFromModule = types.submodule {
    options = {
      "kind" = mkOption {
        description = "Kind of the values referent, valid values are ('Secret', 'ConfigMap').";
        type = (
          types.enum [
            "Secret"
            "ConfigMap"
          ]
        );
      };
      "name" = mkOption {
        description = "Name of the values referent. Should reside in the same namespace as the\nreferring resource.";
        type = types.str;
      };
      "optional" = mkOption {
        description = "Optional marks this ValuesReference as optional. When set, a not found error\nfor the values reference is ignored, but any ValuesKey, TargetPath or\ntransient error will still result in a reconciliation failure.";
        type = types.bool;
        default = false;
      };
      "targetPath" = mkOption {
        description = "TargetPath is the YAML dot notation path the value should be merged at. When\nset, the ValuesKey is expected to be a single flat value. Defaults to 'None',\nwhich results in the values getting merged at the root.";
        type = (types.nullOr types.str);
        default = null;
      };
      "valuesKey" = mkOption {
        description = "ValuesKey is the data key where the values.yaml or a specific value can be\nfound at. Defaults to 'values.yaml'.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkValuesFrom =
    res:
    {
      inherit (res) "kind";
      inherit (res) "name";
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    }
    // optionalAttrs (res."targetPath" != null) { inherit (res) "targetPath"; }
    // {
    }
    // optionalAttrs (res."valuesKey" != null) { inherit (res) "valuesKey"; }
    // {
    };
  HelmreleasesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this HelmRelease resource.";
        };
        "chart" = mkOption {
          description = "Chart defines the template of the v1.HelmChart that should be created\nfor this HelmRelease.";
          type = (types.nullOr ChartModule);
          default = null;
        };
        "chartRef" = mkOption {
          description = "ChartRef holds a reference to a source controller resource containing the\nHelm chart artifact.";
          type = (types.nullOr ChartRefModule);
          default = null;
        };
        "dependsOn" = mkOption {
          description = "DependsOn may contain a meta.NamespacedObjectReference slice with\nreferences to HelmRelease resources that must be ready before this HelmRelease\ncan be reconciled.";
          type = (types.listOf DependsOnModule);
          default = [ ];
        };
        "driftDetection" = mkOption {
          description = "DriftDetection holds the configuration for detecting and handling\ndifferences between the manifest in the Helm storage and the resources\ncurrently existing in the cluster.";
          type = (types.nullOr DriftDetectionModule);
          default = null;
        };
        "install" = mkOption {
          description = "Install holds the configuration for Helm install actions for this HelmRelease.";
          type = (types.nullOr InstallModule);
          default = null;
        };
        "interval" = mkOption {
          description = "Interval at which to reconcile the Helm release.";
          type = types.str;
        };
        "kubeConfig" = mkOption {
          description = "KubeConfig for reconciling the HelmRelease on a remote cluster.\nWhen used in combination with HelmReleaseSpec.ServiceAccountName,\nforces the controller to act on behalf of that Service Account at the\ntarget cluster.\nIf the --default-service-account flag is set, its value will be used as\na controller level fallback for when HelmReleaseSpec.ServiceAccountName\nis empty.";
          type = (types.nullOr KubeConfigModule);
          default = null;
        };
        "maxHistory" = mkOption {
          description = "MaxHistory is the number of revisions saved by Helm for this HelmRelease.\nUse '0' for an unlimited number of revisions; defaults to '5'.";
          type = (types.nullOr types.int);
          default = null;
        };
        "persistentClient" = mkOption {
          description = "PersistentClient tells the controller to use a persistent Kubernetes\nclient for this release. When enabled, the client will be reused for the\nduration of the reconciliation, instead of being created and destroyed\nfor each (step of a) Helm action.\n\nThis can improve performance, but may cause issues with some Helm charts\nthat for example do create Custom Resource Definitions during installation\noutside Helm's CRD lifecycle hooks, which are then not observed to be\navailable by e.g. post-install hooks.\n\nIf not set, it defaults to true.";
          type = types.bool;
          default = false;
        };
        "postRenderers" = mkOption {
          description = "PostRenderers holds an array of Helm PostRenderers, which will be applied in order\nof their definition.";
          type = (types.listOf PostRendererModule);
          default = [ ];
        };
        "releaseName" = mkOption {
          description = "ReleaseName used for the Helm release. Defaults to a composition of\n'[TargetNamespace-]Name'.";
          type = (types.nullOr types.str);
          default = null;
        };
        "rollback" = mkOption {
          description = "Rollback holds the configuration for Helm rollback actions for this HelmRelease.";
          type = (types.nullOr RollbackModule);
          default = null;
        };
        "serviceAccountName" = mkOption {
          description = "The name of the Kubernetes service account to impersonate\nwhen reconciling this HelmRelease.";
          type = (types.nullOr types.str);
          default = null;
        };
        "storageNamespace" = mkOption {
          description = "StorageNamespace used for the Helm storage.\nDefaults to the namespace of the HelmRelease.";
          type = (types.nullOr types.str);
          default = null;
        };
        "suspend" = mkOption {
          description = "Suspend tells the controller to suspend reconciliation for this HelmRelease,\nit does not apply to already started reconciliations. Defaults to false.";
          type = types.bool;
          default = false;
        };
        "targetNamespace" = mkOption {
          description = "TargetNamespace to target when performing operations for the HelmRelease.\nDefaults to the namespace of the HelmRelease.";
          type = (types.nullOr types.str);
          default = null;
        };
        "test" = mkOption {
          description = "Test holds the configuration for Helm test actions for this HelmRelease.";
          type = (types.nullOr TestModule);
          default = null;
        };
        "timeout" = mkOption {
          description = "Timeout is the time to wait for any individual Kubernetes operation (like Jobs\nfor hooks) during the performance of a Helm action. Defaults to '5m0s'.";
          type = (types.nullOr types.str);
          default = null;
        };
        "uninstall" = mkOption {
          description = "Uninstall holds the configuration for Helm uninstall actions for this HelmRelease.";
          type = (types.nullOr UninstallModule);
          default = null;
        };
        "upgrade" = mkOption {
          description = "Upgrade holds the configuration for Helm upgrade actions for this HelmRelease.";
          type = (types.nullOr UpgradeModule);
          default = null;
        };
        "values" = mkOption {
          description = "Values holds the values for this Helm release.";
          type = (types.nullOr types.anything);
          default = null;
        };
        "valuesFrom" = mkOption {
          description = "ValuesFrom holds references to resources containing Helm values for this HelmRelease,\nand information about how they should be merged.";
          type = (types.listOf ValuesFromModule);
          default = [ ];
        };
      };
    }
  );
  mkHelmRelease = name: res: {
    apiVersion = "helm.toolkit.fluxcd.io/v2";
    kind = "HelmRelease";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."chart" != null) { "chart" = mkChart res."chart"; }
    // {
    }
    // optionalAttrs (res."chartRef" != null) { "chartRef" = mkChartRef res."chartRef"; }
    // {
    }
    // optionalAttrs (res."dependsOn" != [ ]) { "dependsOn" = map mkDependsOn res."dependsOn"; }
    // {
    }
    // optionalAttrs (res."driftDetection" != null) {
      "driftDetection" = mkDriftDetection res."driftDetection";
    }
    // {
    }
    // optionalAttrs (res."install" != null) { "install" = mkInstall res."install"; }
    // {
      inherit (res) "interval";
    }
    // optionalAttrs (res."kubeConfig" != null) { "kubeConfig" = mkKubeConfig res."kubeConfig"; }
    // {
    }
    // optionalAttrs (res."maxHistory" != null) { inherit (res) "maxHistory"; }
    // {
    }
    // optionalAttrs res."persistentClient" { inherit (res) "persistentClient"; }
    // {
    }
    // optionalAttrs (res."postRenderers" != [ ]) {
      "postRenderers" = map mkPostRenderer res."postRenderers";
    }
    // {
    }
    // optionalAttrs (res."releaseName" != null) { inherit (res) "releaseName"; }
    // {
    }
    // optionalAttrs (res."rollback" != null) { "rollback" = mkRollback res."rollback"; }
    // {
    }
    // optionalAttrs (res."serviceAccountName" != null) { inherit (res) "serviceAccountName"; }
    // {
    }
    // optionalAttrs (res."storageNamespace" != null) { inherit (res) "storageNamespace"; }
    // {
    }
    // optionalAttrs res."suspend" { inherit (res) "suspend"; }
    // {
    }
    // optionalAttrs (res."targetNamespace" != null) { inherit (res) "targetNamespace"; }
    // {
    }
    // optionalAttrs (res."test" != null) { "test" = mkTest res."test"; }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    }
    // optionalAttrs (res."uninstall" != null) { "uninstall" = mkUninstall res."uninstall"; }
    // {
    }
    // optionalAttrs (res."upgrade" != null) { "upgrade" = mkUpgrade res."upgrade"; }
    // {
    }
    // optionalAttrs (res."values" != null) { inherit (res) "values"; }
    // {
    }
    // optionalAttrs (res."valuesFrom" != [ ]) { "valuesFrom" = map mkValuesFrom res."valuesFrom"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkHelmRelease cfg."helmreleases");
in
{
  options.openkrill.apps."flux" = {
    "helmreleases" = mkOption {
      type = types.attrsOf HelmreleasesModule;
      default = { };
      description = "HelmRelease CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."flux".content = allResources;
  };
}
