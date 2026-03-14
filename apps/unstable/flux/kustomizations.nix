# Auto-generated openkrill module fragment for flux
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."flux";
  compact = filterAttrs (_: v: v != null);
  CommonMetadataModule = types.submodule {
    options = {
      "annotations" = mkOption {
        description = "Annotations to be added to the object's metadata.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "labels" = mkOption {
        description = "Labels to be added to the object's metadata.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  mkCommonMetadata =
    res:
    {
    }
    // optionalAttrs (res."annotations" != { }) { inherit (res) "annotations"; }
    // {
    }
    // optionalAttrs (res."labels" != { }) { inherit (res) "labels"; }
    // {
    };
  DecryptionModule = types.submodule {
    options = {
      "provider" = mkOption {
        description = "Provider is the name of the decryption engine.";
        type = (types.enum [ "sops" ]);
      };
      "secretRef" = mkOption {
        description = "The secret name containing the private OpenPGP keys used for decryption.\nA static credential for a cloud provider defined inside the Secret\ntakes priority to secret-less authentication with the ServiceAccountName\nfield.";
        type = (types.nullOr DecryptionSecretRefModule);
        default = null;
      };
      "serviceAccountName" = mkOption {
        description = "ServiceAccountName is the name of the service account used to\nauthenticate with KMS services from cloud providers. If a\nstatic credential for a given cloud provider is defined\ninside the Secret referenced by SecretRef, that static\ncredential takes priority.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDecryption =
    res:
    {
      inherit (res) "provider";
    }
    // optionalAttrs (res."secretRef" != null) { "secretRef" = mkDecryptionSecretRef res."secretRef"; }
    // {
    }
    // optionalAttrs (res."serviceAccountName" != null) { inherit (res) "serviceAccountName"; }
    // {
    };
  DecryptionSecretRefModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkDecryptionSecretRef = res: {
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
  HealthCheckExprModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        description = "APIVersion of the custom resource under evaluation.";
        type = types.str;
      };
      "current" = mkOption {
        description = "Current is the CEL expression that determines if the status\nof the custom resource has reached the desired state.";
        type = types.str;
      };
      "failed" = mkOption {
        description = "Failed is the CEL expression that determines if the status\nof the custom resource has failed to reach the desired state.";
        type = (types.nullOr types.str);
        default = null;
      };
      "inProgress" = mkOption {
        description = "InProgress is the CEL expression that determines if the status\nof the custom resource has not yet reached the desired state.";
        type = (types.nullOr types.str);
        default = null;
      };
      "kind" = mkOption {
        description = "Kind of the custom resource under evaluation.";
        type = types.str;
      };
    };
  };
  mkHealthCheckExpr =
    res:
    {
      inherit (res) "apiVersion";
      inherit (res) "current";
    }
    // optionalAttrs (res."failed" != null) { inherit (res) "failed"; }
    // {
    }
    // optionalAttrs (res."inProgress" != null) { inherit (res) "inProgress"; }
    // {
      inherit (res) "kind";
    };
  HealthCheckModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        description = "API version of the referent, if not specified the Kubernetes preferred version will be used.";
        type = (types.nullOr types.str);
        default = null;
      };
      "kind" = mkOption {
        description = "Kind of the referent.";
        type = types.str;
      };
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
  mkHealthCheck =
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
  ImageModule = types.submodule {
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
  mkImage =
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
  PatcheModule = types.submodule {
    options = {
      "patch" = mkOption {
        description = "Patch contains an inline StrategicMerge patch or an inline JSON6902 patch with\nan array of operation objects.";
        type = types.str;
      };
      "target" = mkOption {
        description = "Target points to the resources that the patch document should be applied to.";
        type = (types.nullOr PatcheTargetModule);
        default = null;
      };
    };
  };
  mkPatche =
    res:
    {
      inherit (res) "patch";
    }
    // optionalAttrs (res."target" != null) { "target" = mkPatcheTarget res."target"; }
    // {
    };
  PatcheTargetModule = types.submodule {
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
  mkPatcheTarget =
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
  PostBuildModule = types.submodule {
    options = {
      "substitute" = mkOption {
        description = "Substitute holds a map of key/value pairs.\nThe variables defined in your YAML manifests that match any of the keys\ndefined in the map will be substituted with the set value.\nIncludes support for bash string replacement functions\ne.g. ${"var:=default"}, ${"var:position"} and ${var/substring/replacement}.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "substituteFrom" = mkOption {
        description = "SubstituteFrom holds references to ConfigMaps and Secrets containing\nthe variables and their values to be substituted in the YAML manifests.\nThe ConfigMap and the Secret data keys represent the var names, and they\nmust match the vars declared in the manifests for the substitution to\nhappen.";
        type = (types.listOf PostBuildSubstituteFromModule);
        default = [ ];
      };
    };
  };
  mkPostBuild =
    res:
    {
    }
    // optionalAttrs (res."substitute" != { }) { inherit (res) "substitute"; }
    // {
    }
    // optionalAttrs (res."substituteFrom" != [ ]) {
      "substituteFrom" = map mkPostBuildSubstituteFrom res."substituteFrom";
    }
    // {
    };
  PostBuildSubstituteFromModule = types.submodule {
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
        description = "Optional indicates whether the referenced resource must exist, or whether to\ntolerate its absence. If true and the referenced resource is absent, proceed\nas if the resource was present but empty, without any variables defined.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkPostBuildSubstituteFrom =
    res:
    {
      inherit (res) "kind";
      inherit (res) "name";
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
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
        type = (
          types.enum [
            "OCIRepository"
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
        description = "Namespace of the referent, defaults to the namespace of the Kubernetes\nresource object that contains the reference.";
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
  KustomizationsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this Kustomization resource.";
        };
        "commonMetadata" = mkOption {
          description = "CommonMetadata specifies the common labels and annotations that are\napplied to all resources. Any existing label or annotation will be\noverridden if its key matches a common one.";
          type = (types.nullOr CommonMetadataModule);
          default = null;
        };
        "components" = mkOption {
          description = "Components specifies relative paths to specifications of other Components.";
          type = (types.listOf types.str);
          default = [ ];
        };
        "decryption" = mkOption {
          description = "Decrypt Kubernetes secrets before applying them on the cluster.";
          type = (types.nullOr DecryptionModule);
          default = null;
        };
        "deletionPolicy" = mkOption {
          description = "DeletionPolicy can be used to control garbage collection when this\nKustomization is deleted. Valid values are ('MirrorPrune', 'Delete',\n'WaitForTermination', 'Orphan'). 'MirrorPrune' mirrors the Prune field\n(orphan if false, delete if true). Defaults to 'MirrorPrune'.";
          type = (
            types.nullOr (
              types.enum [
                "MirrorPrune"
                "Delete"
                "WaitForTermination"
                "Orphan"
              ]
            )
          );
          default = null;
        };
        "dependsOn" = mkOption {
          description = "DependsOn may contain a meta.NamespacedObjectReference slice\nwith references to Kustomization resources that must be ready before this\nKustomization can be reconciled.";
          type = (types.listOf DependsOnModule);
          default = [ ];
        };
        "force" = mkOption {
          description = "Force instructs the controller to recreate resources\nwhen patching fails due to an immutable field change.";
          type = types.bool;
          default = false;
        };
        "healthCheckExprs" = mkOption {
          description = "HealthCheckExprs is a list of healthcheck expressions for evaluating the\nhealth of custom resources using Common Expression Language (CEL).\nThe expressions are evaluated only when Wait or HealthChecks are specified.";
          type = (types.listOf HealthCheckExprModule);
          default = [ ];
        };
        "healthChecks" = mkOption {
          description = "A list of resources to be included in the health assessment.";
          type = (types.listOf HealthCheckModule);
          default = [ ];
        };
        "images" = mkOption {
          description = "Images is a list of (image name, new name, new tag or digest)\nfor changing image names, tags or digests. This can also be achieved with a\npatch, but this operator is simpler to specify.";
          type = (types.listOf ImageModule);
          default = [ ];
        };
        "interval" = mkOption {
          description = "The interval at which to reconcile the Kustomization.\nThis interval is approximate and may be subject to jitter to ensure\nefficient use of resources.";
          type = types.str;
        };
        "kubeConfig" = mkOption {
          description = "The KubeConfig for reconciling the Kustomization on a remote cluster.\nWhen used in combination with KustomizationSpec.ServiceAccountName,\nforces the controller to act on behalf of that Service Account at the\ntarget cluster.\nIf the --default-service-account flag is set, its value will be used as\na controller level fallback for when KustomizationSpec.ServiceAccountName\nis empty.";
          type = (types.nullOr KubeConfigModule);
          default = null;
        };
        "namePrefix" = mkOption {
          description = "NamePrefix will prefix the names of all managed resources.";
          type = (types.nullOr types.str);
          default = null;
        };
        "nameSuffix" = mkOption {
          description = "NameSuffix will suffix the names of all managed resources.";
          type = (types.nullOr types.str);
          default = null;
        };
        "patches" = mkOption {
          description = "Strategic merge and JSON patches, defined as inline YAML objects,\ncapable of targeting objects based on kind, label and annotation selectors.";
          type = (types.listOf PatcheModule);
          default = [ ];
        };
        "path" = mkOption {
          description = "Path to the directory containing the kustomization.yaml file, or the\nset of plain YAMLs a kustomization.yaml should be generated for.\nDefaults to 'None', which translates to the root path of the SourceRef.";
          type = (types.nullOr types.str);
          default = null;
        };
        "postBuild" = mkOption {
          description = "PostBuild describes which actions to perform on the YAML manifest\ngenerated by building the kustomize overlay.";
          type = (types.nullOr PostBuildModule);
          default = null;
        };
        "prune" = mkOption {
          description = "Prune enables garbage collection.";
          type = types.bool;
        };
        "retryInterval" = mkOption {
          description = "The interval at which to retry a previously failed reconciliation.\nWhen not specified, the controller uses the KustomizationSpec.Interval\nvalue to retry failures.";
          type = (types.nullOr types.str);
          default = null;
        };
        "serviceAccountName" = mkOption {
          description = "The name of the Kubernetes service account to impersonate\nwhen reconciling this Kustomization.";
          type = (types.nullOr types.str);
          default = null;
        };
        "sourceRef" = mkOption {
          description = "Reference of the source where the kustomization file is.";
          type = SourceRefModule;
        };
        "suspend" = mkOption {
          description = "This flag tells the controller to suspend subsequent kustomize executions,\nit does not apply to already started executions. Defaults to false.";
          type = types.bool;
          default = false;
        };
        "targetNamespace" = mkOption {
          description = "TargetNamespace sets or overrides the namespace in the\nkustomization.yaml file.";
          type = (types.nullOr types.str);
          default = null;
        };
        "timeout" = mkOption {
          description = "Timeout for validation, apply and health checking operations.\nDefaults to 'Interval' duration.";
          type = (types.nullOr types.str);
          default = null;
        };
        "wait" = mkOption {
          description = "Wait instructs the controller to check the health of all the reconciled\nresources. When enabled, the HealthChecks are ignored. Defaults to false.";
          type = types.bool;
          default = false;
        };
      };
    }
  );
  mkKustomization = name: res: {
    apiVersion = "kustomize.toolkit.fluxcd.io/v1";
    kind = "Kustomization";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."commonMetadata" != null) {
      "commonMetadata" = mkCommonMetadata res."commonMetadata";
    }
    // {
    }
    // optionalAttrs (res."components" != [ ]) { inherit (res) "components"; }
    // {
    }
    // optionalAttrs (res."decryption" != null) { "decryption" = mkDecryption res."decryption"; }
    // {
    }
    // optionalAttrs (res."deletionPolicy" != null) { inherit (res) "deletionPolicy"; }
    // {
    }
    // optionalAttrs (res."dependsOn" != [ ]) { "dependsOn" = map mkDependsOn res."dependsOn"; }
    // {
    }
    // optionalAttrs res."force" { inherit (res) "force"; }
    // {
    }
    // optionalAttrs (res."healthCheckExprs" != [ ]) {
      "healthCheckExprs" = map mkHealthCheckExpr res."healthCheckExprs";
    }
    // {
    }
    // optionalAttrs (res."healthChecks" != [ ]) {
      "healthChecks" = map mkHealthCheck res."healthChecks";
    }
    // {
    }
    // optionalAttrs (res."images" != [ ]) { "images" = map mkImage res."images"; }
    // {
      inherit (res) "interval";
    }
    // optionalAttrs (res."kubeConfig" != null) { "kubeConfig" = mkKubeConfig res."kubeConfig"; }
    // {
    }
    // optionalAttrs (res."namePrefix" != null) { inherit (res) "namePrefix"; }
    // {
    }
    // optionalAttrs (res."nameSuffix" != null) { inherit (res) "nameSuffix"; }
    // {
    }
    // optionalAttrs (res."patches" != [ ]) { "patches" = map mkPatche res."patches"; }
    // {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs (res."postBuild" != null) { "postBuild" = mkPostBuild res."postBuild"; }
    // {
      inherit (res) "prune";
    }
    // optionalAttrs (res."retryInterval" != null) { inherit (res) "retryInterval"; }
    // {
    }
    // optionalAttrs (res."serviceAccountName" != null) { inherit (res) "serviceAccountName"; }
    // {
      "sourceRef" = mkSourceRef res."sourceRef";
    }
    // optionalAttrs res."suspend" { inherit (res) "suspend"; }
    // {
    }
    // optionalAttrs (res."targetNamespace" != null) { inherit (res) "targetNamespace"; }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    }
    // optionalAttrs res."wait" { inherit (res) "wait"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkKustomization cfg."kustomizations");
in
{
  options.openkrill.apps."flux" = {
    "kustomizations" = mkOption {
      type = types.attrsOf KustomizationsModule;
      default = { };
      description = "Kustomization CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."flux".content = allResources;
  };
}
