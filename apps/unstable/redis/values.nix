# Auto-generated from Bitnami values.schema.json
# Do not edit — regenerate with bin/create-module-bitnami
{ lib, ... }:
with lib;
let
  AuthAclModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enables the support of the Redis ACL system";
  type = types.bool;
  default = false;
};
"users" = mkOption {
  description = "A list of the configured users in the Redis ACL system";
  type = (types.listOf types.anything);
  default = [  ];
};
  };
};
AuthModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "acl" = mkOption {
  type = AuthAclModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Enable password authentication";
  type = types.bool;
  default = true;
};
"existingSecret" = mkOption {
  description = "The name of an existing secret with Redis&reg; credentials";
  type = (types.nullOr types.str);
  default = "";
};
"existingSecretPasswordKey" = mkOption {
  description = "Password key to be retrieved from existing secret";
  type = (types.nullOr types.str);
  default = "";
};
"password" = mkOption {
  description = "Redis&reg; password";
  type = (types.nullOr types.str);
  default = "";
};
"sentinel" = mkOption {
  description = "Enable password authentication on sentinels too";
  type = types.bool;
  default = true;
};
"usePasswordFileFromSecret" = mkOption {
  description = "Mount password file from secret";
  type = types.bool;
  default = true;
};
"usePasswordFiles" = mkOption {
  description = "Mount credentials as files instead of using an environment variable";
  type = types.bool;
  default = false;
};
  };
};
DiagnosticModeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "args" = mkOption {
  description = "Args to override all containers in the deployment";
  type = types.anything;
  default = [ "infinity" ];
};
"command" = mkOption {
  description = "Command to override all containers in the deployment";
  type = types.anything;
  default = [ "sleep" ];
};
"enabled" = mkOption {
  description = "Enable diagnostic mode (all probes will be disabled and the command will be overridden)";
  type = types.bool;
  default = false;
};
  };
};
GlobalCompatibilityModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "openshift" = mkOption {
  type = GlobalCompatibilityOpenshiftModule;
  default = {  };
};
  };
};
GlobalCompatibilityOpenshiftModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "adaptSecurityContext" = mkOption {
  description = "Adapt the securityContext sections of the deployment to make them compatible with Openshift restricted-v2 SCC: remove runAsUser, runAsGroup and fsGroup and let the platform use their allowed default IDs. Possible values: auto (apply if the detected running cluster is Openshift), force (perform the adaptation always), disabled (do not perform adaptation)";
  type = (types.nullOr types.str);
  default = "auto";
};
  };
};
GlobalModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "compatibility" = mkOption {
  type = GlobalCompatibilityModule;
  default = {  };
};
"defaultStorageClass" = mkOption {
  description = "Global default StorageClass for Persistent Volume(s)";
  type = (types.nullOr types.str);
  default = "";
};
"imagePullSecrets" = mkOption {
  description = "Global Docker registry secret names as an array";
  type = (types.listOf types.anything);
  default = [  ];
};
"imageRegistry" = mkOption {
  description = "Global Docker image registry";
  type = (types.nullOr types.str);
  default = "";
};
"redis" = mkOption {
  type = GlobalRedisModule;
  default = {  };
};
"storageClass" = mkOption {
  description = "DEPRECATED: use global.defaultStorageClass instead";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
GlobalRedisModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "password" = mkOption {
  description = "Global Redis&reg; password (overrides `auth.password`)";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
ImageModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "debug" = mkOption {
  description = "Enable image debug mode";
  type = types.bool;
  default = false;
};
"digest" = mkOption {
  description = "Redis&reg; image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag";
  type = (types.nullOr types.str);
  default = "";
};
"pullPolicy" = mkOption {
  description = "Redis&reg; image pull policy";
  type = (types.nullOr types.str);
  default = "IfNotPresent";
};
"pullSecrets" = mkOption {
  description = "Redis&reg; image pull secrets";
  type = (types.listOf types.anything);
  default = [  ];
};
"registry" = mkOption {
  description = "Redis&reg; image registry";
  type = (types.nullOr types.str);
  default = "REGISTRY_NAME";
};
"repository" = mkOption {
  description = "Redis&reg; image repository";
  type = (types.nullOr types.str);
  default = "REPOSITORY_NAME/redis";
};
  };
};
KubectlContainerSecurityContextCapabilitiesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "drop" = mkOption {
  description = "Set kubectl containers' Security Context capabilities to drop";
  type = (types.listOf types.str);
  default = [ "ALL" ];
};
  };
};
KubectlContainerSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "allowPrivilegeEscalation" = mkOption {
  description = "Set kubectl containers' Security Context allowPrivilegeEscalation";
  type = types.bool;
  default = false;
};
"capabilities" = mkOption {
  type = KubectlContainerSecurityContextCapabilitiesModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Enabled kubectl containers' Security Context";
  type = types.bool;
  default = true;
};
"readOnlyRootFilesystem" = mkOption {
  description = "Set container's Security Context read-only root filesystem";
  type = types.bool;
  default = true;
};
"runAsGroup" = mkOption {
  description = "Set kubectl containers' Security Context runAsGroup";
  type = (types.nullOr types.int);
  default = 1001;
};
"runAsNonRoot" = mkOption {
  description = "Set kubectl containers' Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsUser" = mkOption {
  description = "Set kubectl containers' Security Context runAsUser";
  type = (types.nullOr types.int);
  default = 1001;
};
"seccompProfile" = mkOption {
  type = KubectlContainerSecurityContextSeccompProfileModule;
  default = {  };
};
  };
};
KubectlContainerSecurityContextSeccompProfileModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "type" = mkOption {
  description = "Set kubectl containers' Security Context seccompProfile";
  type = (types.nullOr types.str);
  default = "RuntimeDefault";
};
  };
};
KubectlImageModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "digest" = mkOption {
  description = "Kubectl image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag";
  type = (types.nullOr types.str);
  default = "";
};
"pullPolicy" = mkOption {
  description = "Kubectl image pull policy";
  type = (types.nullOr types.str);
  default = "IfNotPresent";
};
"pullSecrets" = mkOption {
  description = "Kubectl pull secrets";
  type = (types.listOf types.anything);
  default = [  ];
};
"registry" = mkOption {
  description = "Kubectl image registry";
  type = (types.nullOr types.str);
  default = "REGISTRY_NAME";
};
"repository" = mkOption {
  description = "Kubectl image repository";
  type = (types.nullOr types.str);
  default = "REPOSITORY_NAME/kubectl";
};
  };
};
KubectlModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "command" = mkOption {
  description = "kubectl command to execute";
  type = (types.listOf types.str);
  default = [ "/opt/bitnami/scripts/kubectl-scripts/update-master-label.sh" ];
};
"containerSecurityContext" = mkOption {
  type = KubectlContainerSecurityContextModule;
  default = {  };
};
"image" = mkOption {
  type = KubectlImageModule;
  default = {  };
};
"resources" = mkOption {
  type = KubectlResourcesModule;
  default = {  };
};
  };
};
KubectlResourcesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "limits" = mkOption {
  description = "The resources limits for the kubectl containers";
  type = (types.attrsOf types.anything);
  default = {  };
};
"requests" = mkOption {
  description = "The requested resources for the kubectl containers";
  type = (types.attrsOf types.anything);
  default = {  };
};
  };
};
MasterContainerPortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "redis" = mkOption {
  description = "Container port to open on Redis&reg; master nodes";
  type = (types.nullOr types.int);
  default = 6379;
};
  };
};
MasterContainerSecurityContextCapabilitiesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "drop" = mkOption {
  description = "Set Redis&reg; master containers' Security Context capabilities to drop";
  type = (types.listOf types.str);
  default = [ "ALL" ];
};
  };
};
MasterContainerSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "allowPrivilegeEscalation" = mkOption {
  description = "Is it possible to escalate Redis&reg; pod(s) privileges";
  type = types.bool;
  default = false;
};
"capabilities" = mkOption {
  type = MasterContainerSecurityContextCapabilitiesModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Enabled Redis&reg; master containers' Security Context";
  type = types.bool;
  default = true;
};
"readOnlyRootFilesystem" = mkOption {
  description = "Set container's Security Context read-only root filesystem";
  type = types.bool;
  default = true;
};
"runAsGroup" = mkOption {
  description = "Set Redis&reg; master containers' Security Context runAsGroup";
  type = (types.nullOr types.int);
  default = 1001;
};
"runAsNonRoot" = mkOption {
  description = "Set Redis&reg; master containers' Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsUser" = mkOption {
  description = "Set Redis&reg; master containers' Security Context runAsUser";
  type = (types.nullOr types.int);
  default = 1001;
};
"seccompProfile" = mkOption {
  type = MasterContainerSecurityContextSeccompProfileModule;
  default = {  };
};
  };
};
MasterContainerSecurityContextSeccompProfileModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "type" = mkOption {
  description = "Set Redis&reg; master containers' Security Context seccompProfile";
  type = (types.nullOr types.str);
  default = "RuntimeDefault";
};
  };
};
MasterLivenessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable livenessProbe on Redis&reg; master nodes";
  type = types.bool;
  default = true;
};
"failureThreshold" = mkOption {
  description = "Failure threshold for livenessProbe";
  type = (types.nullOr types.int);
  default = 5;
};
"initialDelaySeconds" = mkOption {
  description = "Initial delay seconds for livenessProbe";
  type = (types.nullOr types.int);
  default = 20;
};
"periodSeconds" = mkOption {
  description = "Period seconds for livenessProbe";
  type = (types.nullOr types.int);
  default = 5;
};
"successThreshold" = mkOption {
  description = "Success threshold for livenessProbe";
  type = (types.nullOr types.int);
  default = 1;
};
"timeoutSeconds" = mkOption {
  description = "Timeout seconds for livenessProbe";
  type = (types.nullOr types.int);
  default = 5;
};
  };
};
MasterModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "affinity" = mkOption {
  description = "Affinity for Redis&reg; master pods assignment";
  type = types.anything;
  default = {  };
};
"args" = mkOption {
  description = "Override default container args (useful when using custom images)";
  type = types.anything;
  default = [  ];
};
"automountServiceAccountToken" = mkOption {
  description = "Mount Service Account token in pod";
  type = types.bool;
  default = false;
};
"command" = mkOption {
  description = "Override default container command (useful when using custom images)";
  type = types.anything;
  default = [  ];
};
"configuration" = mkOption {
  description = "Configuration for Redis&reg; master nodes";
  type = (types.nullOr types.str);
  default = "";
};
"containerPorts" = mkOption {
  type = MasterContainerPortsModule;
  default = {  };
};
"containerSecurityContext" = mkOption {
  type = MasterContainerSecurityContextModule;
  default = {  };
};
"count" = mkOption {
  description = "Number of Redis&reg; master instances to deploy (experimental, requires additional configuration)";
  type = (types.nullOr types.int);
  default = 1;
};
"customLivenessProbe" = mkOption {
  description = "Custom livenessProbe that overrides the default one";
  type = types.anything;
  default = {  };
};
"customReadinessProbe" = mkOption {
  description = "Custom readinessProbe that overrides the default one";
  type = types.anything;
  default = {  };
};
"customStartupProbe" = mkOption {
  description = "Custom startupProbe that overrides the default one";
  type = types.anything;
  default = {  };
};
"disableCommands" = mkOption {
  description = "Array with Redis&reg; commands to disable on master nodes";
  type = (types.listOf types.str);
  default = [ "FLUSHDB" "FLUSHALL" ];
};
"dnsConfig" = mkOption {
  description = "DNS Configuration for Redis&reg; master pod";
  type = types.anything;
  default = {  };
};
"dnsPolicy" = mkOption {
  description = "DNS Policy for Redis&reg; master pod";
  type = (types.nullOr types.str);
  default = "";
};
"enableServiceLinks" = mkOption {
  description = "Whether information about services should be injected into pod's environment variable";
  type = types.bool;
  default = true;
};
"extraEnvVars" = mkOption {
  description = "Array with extra environment variables to add to Redis&reg; master nodes";
  type = types.anything;
  default = [  ];
};
"extraEnvVarsCM" = mkOption {
  description = "Name of existing ConfigMap containing extra env vars for Redis&reg; master nodes";
  type = (types.nullOr types.str);
  default = "";
};
"extraEnvVarsSecret" = mkOption {
  description = "Name of existing Secret containing extra env vars for Redis&reg; master nodes";
  type = (types.nullOr types.str);
  default = "";
};
"extraFlags" = mkOption {
  description = "Array with additional command line flags for Redis&reg; master";
  type = (types.listOf types.anything);
  default = [  ];
};
"extraVolumeMounts" = mkOption {
  description = "Optionally specify extra list of additional volumeMounts for the Redis&reg; master container(s)";
  type = types.anything;
  default = [  ];
};
"extraVolumes" = mkOption {
  description = "Optionally specify extra list of additional volumes for the Redis&reg; master pod(s)";
  type = types.anything;
  default = [  ];
};
"hostAliases" = mkOption {
  description = "Redis&reg; master pods host aliases";
  type = types.anything;
  default = [  ];
};
"initContainers" = mkOption {
  description = "Add additional init containers to the Redis&reg; master pod(s)";
  type = types.anything;
  default = [  ];
};
"kind" = mkOption {
  description = "Use either Deployment, StatefulSet (default) or DaemonSet";
  type = (types.nullOr types.str);
  default = "StatefulSet";
};
"lifecycleHooks" = mkOption {
  description = "for the Redis&reg; master container(s) to automate configuration before or after startup";
  type = types.anything;
  default = {  };
};
"livenessProbe" = mkOption {
  type = MasterLivenessProbeModule;
  default = {  };
};
"minReadySeconds" = mkOption {
  description = "How many seconds a pod needs to be ready before killing the next, during update";
  type = (types.nullOr types.int);
  default = 0;
};
"nodeAffinityPreset" = mkOption {
  type = MasterNodeAffinityPresetModule;
  default = {  };
};
"nodeSelector" = mkOption {
  description = "Node labels for Redis&reg; master pods assignment";
  type = types.anything;
  default = {  };
};
"pdb" = mkOption {
  type = MasterPdbModule;
  default = {  };
};
"persistence" = mkOption {
  type = MasterPersistenceModule;
  default = {  };
};
"persistentVolumeClaimRetentionPolicy" = mkOption {
  type = MasterPersistentVolumeClaimRetentionPolicyModule;
  default = {  };
};
"podAffinityPreset" = mkOption {
  description = "Pod affinity preset. Ignored if `master.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "";
};
"podAnnotations" = mkOption {
  description = "Annotations for Redis&reg; master pods";
  type = types.anything;
  default = {  };
};
"podAntiAffinityPreset" = mkOption {
  description = "Pod anti-affinity preset. Ignored if `master.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "soft";
};
"podLabels" = mkOption {
  description = "Extra labels for Redis&reg; master pods";
  type = (types.attrsOf types.anything);
  default = {  };
};
"podSecurityContext" = mkOption {
  type = MasterPodSecurityContextModule;
  default = {  };
};
"preExecCmds" = mkOption {
  description = "Additional commands to run prior to starting Redis&reg; master";
  type = (types.listOf types.anything);
  default = [  ];
};
"priorityClassName" = mkOption {
  description = "Redis&reg; master pods' priorityClassName";
  type = (types.nullOr types.str);
  default = "";
};
"readinessProbe" = mkOption {
  type = MasterReadinessProbeModule;
  default = {  };
};
"resources" = mkOption {
  description = "Set container requests and limits for different resources like CPU or memory (essential for production workloads)";
  type = (types.attrsOf types.anything);
  default = {  };
};
"resourcesPreset" = mkOption {
  description = "Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if master.resources is set (master.resources is recommended for production).";
  type = (types.nullOr types.str);
  default = "nano";
};
"revisionHistoryLimit" = mkOption {
  description = "The number of old history to retain to allow rollback";
  type = (types.nullOr types.int);
  default = 10;
};
"schedulerName" = mkOption {
  description = "Alternate scheduler for Redis&reg; master pods";
  type = (types.nullOr types.str);
  default = "";
};
"service" = mkOption {
  type = MasterServiceModule;
  default = {  };
};
"serviceAccount" = mkOption {
  type = MasterServiceAccountModule;
  default = {  };
};
"shareProcessNamespace" = mkOption {
  description = "Share a single process namespace between all of the containers in Redis&reg; master pods";
  type = types.bool;
  default = false;
};
"sidecars" = mkOption {
  description = "Add additional sidecar containers to the Redis&reg; master pod(s)";
  type = types.anything;
  default = [  ];
};
"startupProbe" = mkOption {
  type = MasterStartupProbeModule;
  default = {  };
};
"terminationGracePeriodSeconds" = mkOption {
  description = "Integer setting the termination grace period for the redis-master pods";
  type = (types.nullOr types.int);
  default = 30;
};
"tolerations" = mkOption {
  description = "Tolerations for Redis&reg; master pods assignment";
  type = types.anything;
  default = [  ];
};
"topologySpreadConstraints" = mkOption {
  description = "Spread Constraints for Redis&reg; master pod assignment";
  type = types.anything;
  default = [  ];
};
"updateStrategy" = mkOption {
  type = MasterUpdateStrategyModule;
  default = {  };
};
  };
};
MasterNodeAffinityPresetModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "key" = mkOption {
  description = "Node label key to match. Ignored if `master.affinity` is set";
  type = (types.nullOr types.str);
  default = "";
};
"type" = mkOption {
  description = "Node affinity preset type. Ignored if `master.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "";
};
"values" = mkOption {
  description = "Node label values to match. Ignored if `master.affinity` is set";
  type = (types.listOf types.anything);
  default = [  ];
};
  };
};
MasterPdbModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "create" = mkOption {
  description = "Enable/disable a Pod Disruption Budget creation";
  type = types.bool;
  default = true;
};
  };
};
MasterPersistenceModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "accessModes" = mkOption {
  description = "Persistent Volume access modes";
  type = (types.listOf types.str);
  default = [ "ReadWriteOnce" ];
};
"annotations" = mkOption {
  description = "Additional custom annotations for the PVC";
  type = (types.attrsOf types.anything);
  default = {  };
};
"dataSource" = mkOption {
  description = "Custom PVC data source";
  type = types.anything;
  default = {  };
};
"enabled" = mkOption {
  description = "Enable persistence on Redis&reg; master nodes using Persistent Volume Claims";
  type = types.bool;
  default = true;
};
"existingClaim" = mkOption {
  description = "Use a existing PVC which must be created manually before bound";
  type = (types.nullOr types.str);
  default = "";
};
"labels" = mkOption {
  description = "Additional custom labels for the PVC";
  type = types.anything;
  default = {  };
};
"medium" = mkOption {
  description = "Provide a medium for `emptyDir` volumes.";
  type = (types.nullOr types.str);
  default = "";
};
"path" = mkOption {
  description = "The path the volume will be mounted at on Redis&reg; master containers";
  type = (types.nullOr types.str);
  default = "/data";
};
"selector" = mkOption {
  description = "Additional labels to match for the PVC";
  type = types.anything;
  default = {  };
};
"size" = mkOption {
  description = "Persistent Volume size";
  type = (types.nullOr types.str);
  default = "8Gi";
};
"sizeLimit" = mkOption {
  description = "Set this to enable a size limit for `emptyDir` volumes.";
  type = (types.nullOr types.str);
  default = "";
};
"storageClass" = mkOption {
  description = "Persistent Volume storage class";
  type = (types.nullOr types.str);
  default = "";
};
"subPath" = mkOption {
  description = "The subdirectory of the volume to mount on Redis&reg; master containers";
  type = (types.nullOr types.str);
  default = "";
};
"subPathExpr" = mkOption {
  description = "Used to construct the subPath subdirectory of the volume to mount on Redis&reg; master containers";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
MasterPersistentVolumeClaimRetentionPolicyModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Controls if and how PVCs are deleted during the lifecycle of a StatefulSet";
  type = types.bool;
  default = false;
};
"whenDeleted" = mkOption {
  description = "Volume retention behavior that applies when the StatefulSet is deleted";
  type = (types.nullOr types.str);
  default = "Retain";
};
"whenScaled" = mkOption {
  description = "Volume retention behavior when the replica count of the StatefulSet is reduced";
  type = (types.nullOr types.str);
  default = "Retain";
};
  };
};
MasterPodSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enabled Redis&reg; master pods' Security Context";
  type = types.bool;
  default = true;
};
"fsGroup" = mkOption {
  description = "Set Redis&reg; master pod's Security Context fsGroup";
  type = (types.nullOr types.int);
  default = 1001;
};
"fsGroupChangePolicy" = mkOption {
  description = "Set filesystem group change policy";
  type = (types.nullOr types.str);
  default = "Always";
};
"supplementalGroups" = mkOption {
  description = "Set filesystem extra groups";
  type = (types.listOf types.anything);
  default = [  ];
};
"sysctls" = mkOption {
  description = "Set kernel settings using the sysctl interface";
  type = (types.listOf types.anything);
  default = [  ];
};
  };
};
MasterReadinessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable readinessProbe on Redis&reg; master nodes";
  type = types.bool;
  default = true;
};
"failureThreshold" = mkOption {
  description = "Failure threshold for readinessProbe";
  type = (types.nullOr types.int);
  default = 5;
};
"initialDelaySeconds" = mkOption {
  description = "Initial delay seconds for readinessProbe";
  type = (types.nullOr types.int);
  default = 20;
};
"periodSeconds" = mkOption {
  description = "Period seconds for readinessProbe";
  type = (types.nullOr types.int);
  default = 5;
};
"successThreshold" = mkOption {
  description = "Success threshold for readinessProbe";
  type = (types.nullOr types.int);
  default = 1;
};
"timeoutSeconds" = mkOption {
  description = "Timeout seconds for readinessProbe";
  type = (types.nullOr types.int);
  default = 1;
};
  };
};
MasterServiceAccountModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Additional custom annotations for the ServiceAccount";
  type = types.anything;
  default = {  };
};
"automountServiceAccountToken" = mkOption {
  description = "Whether to auto mount the service account token";
  type = types.bool;
  default = false;
};
"create" = mkOption {
  description = "Specifies whether a ServiceAccount should be created";
  type = types.bool;
  default = true;
};
"name" = mkOption {
  description = "The name of the ServiceAccount to use.";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
MasterServiceModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Additional custom annotations for Redis&reg; master service";
  type = types.anything;
  default = {  };
};
"clusterIP" = mkOption {
  description = "Redis&reg; master service Cluster IP";
  type = (types.nullOr types.str);
  default = "";
};
"externalIPs" = mkOption {
  description = "Redis&reg; master service External IPs";
  type = types.anything;
  default = [  ];
};
"externalTrafficPolicy" = mkOption {
  description = "Redis&reg; master service external traffic policy";
  type = (types.nullOr types.str);
  default = "Cluster";
};
"extraPorts" = mkOption {
  description = "Extra ports to expose (normally used with the `sidecar` value)";
  type = types.anything;
  default = [  ];
};
"internalTrafficPolicy" = mkOption {
  description = "Redis&reg; master service internal traffic policy (requires Kubernetes v1.22 or greater to be usable)";
  type = (types.nullOr types.str);
  default = "Cluster";
};
"loadBalancerClass" = mkOption {
  description = "master service Load Balancer class if service type is `LoadBalancer` (optional, cloud specific)";
  type = (types.nullOr types.str);
  default = "";
};
"loadBalancerIP" = mkOption {
  description = "Redis&reg; master service Load Balancer IP";
  type = (types.nullOr types.str);
  default = "";
};
"loadBalancerSourceRanges" = mkOption {
  description = "Redis&reg; master service Load Balancer sources";
  type = (types.listOf types.anything);
  default = [  ];
};
"nodePorts" = mkOption {
  type = MasterServiceNodePortsModule;
  default = {  };
};
"portNames" = mkOption {
  type = MasterServicePortNamesModule;
  default = {  };
};
"ports" = mkOption {
  type = MasterServicePortsModule;
  default = {  };
};
"sessionAffinity" = mkOption {
  description = "Session Affinity for Kubernetes service, can be \"None\" or \"ClientIP\"";
  type = (types.nullOr types.str);
  default = "None";
};
"sessionAffinityConfig" = mkOption {
  description = "Additional settings for the sessionAffinity";
  type = types.anything;
  default = {  };
};
"type" = mkOption {
  description = "Redis&reg; master service type";
  type = (types.nullOr types.str);
  default = "ClusterIP";
};
  };
};
MasterServiceNodePortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "redis" = mkOption {
  description = "Node port for Redis&reg; master";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
MasterServicePortNamesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "redis" = mkOption {
  description = "Redis&reg; master service port name";
  type = (types.nullOr types.str);
  default = "tcp-redis";
};
  };
};
MasterServicePortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "redis" = mkOption {
  description = "Redis&reg; master service port";
  type = (types.nullOr types.int);
  default = 6379;
};
  };
};
MasterStartupProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable startupProbe on Redis&reg; master nodes";
  type = types.bool;
  default = false;
};
"failureThreshold" = mkOption {
  description = "Failure threshold for startupProbe";
  type = (types.nullOr types.int);
  default = 5;
};
"initialDelaySeconds" = mkOption {
  description = "Initial delay seconds for startupProbe";
  type = (types.nullOr types.int);
  default = 20;
};
"periodSeconds" = mkOption {
  description = "Period seconds for startupProbe";
  type = (types.nullOr types.int);
  default = 5;
};
"successThreshold" = mkOption {
  description = "Success threshold for startupProbe";
  type = (types.nullOr types.int);
  default = 1;
};
"timeoutSeconds" = mkOption {
  description = "Timeout seconds for startupProbe";
  type = (types.nullOr types.int);
  default = 5;
};
  };
};
MasterUpdateStrategyModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "type" = mkOption {
  description = "Redis&reg; master statefulset strategy type";
  type = (types.nullOr types.str);
  default = "RollingUpdate";
};
  };
};
MetricsContainerPortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "http" = mkOption {
  description = "Metrics HTTP container port";
  type = (types.nullOr types.int);
  default = 9121;
};
  };
};
MetricsContainerSecurityContextCapabilitiesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "drop" = mkOption {
  description = "Set Redis&reg; exporter containers' Security Context capabilities to drop";
  type = (types.listOf types.str);
  default = [ "ALL" ];
};
  };
};
MetricsContainerSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "allowPrivilegeEscalation" = mkOption {
  description = "Set Redis&reg; exporter containers' Security Context allowPrivilegeEscalation";
  type = types.bool;
  default = false;
};
"capabilities" = mkOption {
  type = MetricsContainerSecurityContextCapabilitiesModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Enabled Redis&reg; exporter containers' Security Context";
  type = types.bool;
  default = true;
};
"readOnlyRootFilesystem" = mkOption {
  description = "Set container's Security Context read-only root filesystem";
  type = types.bool;
  default = true;
};
"runAsGroup" = mkOption {
  description = "Set Redis&reg; exporter containers' Security Context runAsGroup";
  type = (types.nullOr types.int);
  default = 1001;
};
"runAsNonRoot" = mkOption {
  description = "Set Redis&reg; exporter containers' Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsUser" = mkOption {
  description = "Set Redis&reg; exporter containers' Security Context runAsUser";
  type = (types.nullOr types.int);
  default = 1001;
};
"seccompProfile" = mkOption {
  type = MetricsContainerSecurityContextSeccompProfileModule;
  default = {  };
};
  };
};
MetricsContainerSecurityContextSeccompProfileModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "type" = mkOption {
  description = "Set Redis&reg; exporter containers' Security Context seccompProfile";
  type = (types.nullOr types.str);
  default = "RuntimeDefault";
};
  };
};
MetricsImageModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "digest" = mkOption {
  description = "Redis&reg; Exporter image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag";
  type = (types.nullOr types.str);
  default = "";
};
"pullPolicy" = mkOption {
  description = "Redis&reg; Exporter image pull policy";
  type = (types.nullOr types.str);
  default = "IfNotPresent";
};
"pullSecrets" = mkOption {
  description = "Redis&reg; Exporter image pull secrets";
  type = (types.listOf types.anything);
  default = [  ];
};
"registry" = mkOption {
  description = "Redis&reg; Exporter image registry";
  type = (types.nullOr types.str);
  default = "REGISTRY_NAME";
};
"repository" = mkOption {
  description = "Redis&reg; Exporter image repository";
  type = (types.nullOr types.str);
  default = "REPOSITORY_NAME/redis-exporter";
};
  };
};
MetricsLivenessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable livenessProbe on Redis&reg; replicas nodes";
  type = types.bool;
  default = true;
};
"failureThreshold" = mkOption {
  description = "Failure threshold for livenessProbe";
  type = (types.nullOr types.int);
  default = 5;
};
"initialDelaySeconds" = mkOption {
  description = "Initial delay seconds for livenessProbe";
  type = (types.nullOr types.int);
  default = 10;
};
"periodSeconds" = mkOption {
  description = "Period seconds for livenessProbe";
  type = (types.nullOr types.int);
  default = 10;
};
"successThreshold" = mkOption {
  description = "Success threshold for livenessProbe";
  type = (types.nullOr types.int);
  default = 1;
};
"timeoutSeconds" = mkOption {
  description = "Timeout seconds for livenessProbe";
  type = (types.nullOr types.int);
  default = 5;
};
  };
};
MetricsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "command" = mkOption {
  description = "Override default metrics container init command (useful when using custom images)";
  type = types.anything;
  default = [  ];
};
"containerPorts" = mkOption {
  type = MetricsContainerPortsModule;
  default = {  };
};
"containerSecurityContext" = mkOption {
  type = MetricsContainerSecurityContextModule;
  default = {  };
};
"customLivenessProbe" = mkOption {
  description = "Custom livenessProbe that overrides the default one";
  type = types.anything;
  default = {  };
};
"customReadinessProbe" = mkOption {
  description = "Custom readinessProbe that overrides the default one";
  type = types.anything;
  default = {  };
};
"customStartupProbe" = mkOption {
  description = "Custom startupProbe that overrides the default one";
  type = types.anything;
  default = {  };
};
"enabled" = mkOption {
  description = "Start a sidecar prometheus exporter to expose Redis&reg; metrics";
  type = types.bool;
  default = false;
};
"extraArgs" = mkOption {
  description = "Extra arguments for Redis&reg; exporter, for example:";
  type = (types.attrsOf types.anything);
  default = {  };
};
"extraEnvVars" = mkOption {
  description = "Array with extra environment variables to add to Redis&reg; exporter";
  type = types.anything;
  default = [  ];
};
"extraVolumeMounts" = mkOption {
  description = "Optionally specify extra list of additional volumeMounts for the Redis&reg; metrics sidecar";
  type = types.anything;
  default = [  ];
};
"extraVolumes" = mkOption {
  description = "Optionally specify extra list of additional volumes for the Redis&reg; metrics sidecar";
  type = types.anything;
  default = [  ];
};
"image" = mkOption {
  type = MetricsImageModule;
  default = {  };
};
"livenessProbe" = mkOption {
  type = MetricsLivenessProbeModule;
  default = {  };
};
"podLabels" = mkOption {
  description = "Extra labels for Redis&reg; exporter pods";
  type = (types.attrsOf types.anything);
  default = {  };
};
"podMonitor" = mkOption {
  type = MetricsPodMonitorModule;
  default = {  };
};
"prometheusRule" = mkOption {
  type = MetricsPrometheusRuleModule;
  default = {  };
};
"readinessProbe" = mkOption {
  type = MetricsReadinessProbeModule;
  default = {  };
};
"redisTargetHost" = mkOption {
  description = "A way to specify an alternative Redis&reg; hostname";
  type = (types.nullOr types.str);
  default = "localhost";
};
"resources" = mkOption {
  description = "Set container requests and limits for different resources like CPU or memory (essential for production workloads)";
  type = (types.attrsOf types.anything);
  default = {  };
};
"resourcesPreset" = mkOption {
  description = "Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if metrics.resources is set (metrics.resources is recommended for production).";
  type = (types.nullOr types.str);
  default = "nano";
};
"service" = mkOption {
  type = MetricsServiceModule;
  default = {  };
};
"serviceMonitor" = mkOption {
  type = MetricsServiceMonitorModule;
  default = {  };
};
"startupProbe" = mkOption {
  type = MetricsStartupProbeModule;
  default = {  };
};
  };
};
MetricsPodMonitorModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "additionalEndpoints" = mkOption {
  description = "Additional endpoints to scrape (e.g sentinel)";
  type = (types.listOf types.anything);
  default = [  ];
};
"additionalLabels" = mkOption {
  description = "Additional labels that can be used so PodMonitor resource(s) can be discovered by Prometheus";
  type = types.anything;
  default = {  };
};
"enabled" = mkOption {
  description = "Create PodMonitor resource(s) for scraping metrics using PrometheusOperator";
  type = types.bool;
  default = false;
};
"honorLabels" = mkOption {
  description = "Specify honorLabels parameter to add the scrape endpoint";
  type = types.bool;
  default = false;
};
"interval" = mkOption {
  description = "The interval at which metrics should be scraped";
  type = (types.nullOr types.str);
  default = "30s";
};
"metricRelabelings" = mkOption {
  description = "Metrics RelabelConfigs to apply to samples before ingestion.";
  type = (types.listOf types.anything);
  default = [  ];
};
"namespace" = mkOption {
  description = "The namespace in which the PodMonitor will be created";
  type = (types.nullOr types.str);
  default = "";
};
"podTargetLabels" = mkOption {
  description = "Labels from the Kubernetes pod to be transferred to the created metrics";
  type = (types.listOf types.anything);
  default = [  ];
};
"port" = mkOption {
  description = "the pod port to scrape metrics from";
  type = (types.nullOr types.str);
  default = "metrics";
};
"relabelings" = mkOption {
  description = "Metrics RelabelConfigs to apply to samples before scraping.";
  type = (types.listOf types.anything);
  default = [  ];
};
"sampleLimit" = mkOption {
  description = "Limit of how many samples should be scraped from every Pod";
  type = types.bool;
  default = false;
};
"scrapeTimeout" = mkOption {
  description = "The timeout after which the scrape is ended";
  type = (types.nullOr types.str);
  default = "";
};
"targetLimit" = mkOption {
  description = "Limit of how many targets should be scraped";
  type = types.bool;
  default = false;
};
"tlsConfig" = mkOption {
  description = "TLS configuration used for scrape endpoints used by Prometheus";
  type = (types.attrsOf types.anything);
  default = {  };
};
  };
};
MetricsPrometheusRuleModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "additionalLabels" = mkOption {
  description = "Additional labels for the prometheusRule";
  type = types.anything;
  default = {  };
};
"enabled" = mkOption {
  description = "Create a custom prometheusRule Resource for scraping metrics using PrometheusOperator";
  type = types.bool;
  default = false;
};
"namespace" = mkOption {
  description = "The namespace in which the prometheusRule will be created";
  type = (types.nullOr types.str);
  default = "";
};
"rules" = mkOption {
  description = "Custom Prometheus rules";
  type = types.anything;
  default = [  ];
};
  };
};
MetricsReadinessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable readinessProbe on Redis&reg; replicas nodes";
  type = types.bool;
  default = true;
};
"failureThreshold" = mkOption {
  description = "Failure threshold for readinessProbe";
  type = (types.nullOr types.int);
  default = 3;
};
"initialDelaySeconds" = mkOption {
  description = "Initial delay seconds for readinessProbe";
  type = (types.nullOr types.int);
  default = 5;
};
"periodSeconds" = mkOption {
  description = "Period seconds for readinessProbe";
  type = (types.nullOr types.int);
  default = 10;
};
"successThreshold" = mkOption {
  description = "Success threshold for readinessProbe";
  type = (types.nullOr types.int);
  default = 1;
};
"timeoutSeconds" = mkOption {
  description = "Timeout seconds for readinessProbe";
  type = (types.nullOr types.int);
  default = 1;
};
  };
};
MetricsServiceModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Additional custom annotations for Redis&reg; exporter service";
  type = types.anything;
  default = {  };
};
"clusterIP" = mkOption {
  description = "Redis&reg; exporter service Cluster IP";
  type = (types.nullOr types.str);
  default = "";
};
"enabled" = mkOption {
  description = "Create Service resource(s) for scraping metrics using PrometheusOperator ServiceMonitor, can be disabled when using a PodMonitor";
  type = types.bool;
  default = true;
};
"externalTrafficPolicy" = mkOption {
  description = "Redis&reg; exporter service external traffic policy";
  type = (types.nullOr types.str);
  default = "Cluster";
};
"extraPorts" = mkOption {
  description = "Extra ports to expose (normally used with the `sidecar` value)";
  type = types.anything;
  default = [  ];
};
"loadBalancerClass" = mkOption {
  description = "exporter service Load Balancer class if service type is `LoadBalancer` (optional, cloud specific)";
  type = (types.nullOr types.str);
  default = "";
};
"loadBalancerIP" = mkOption {
  description = "Redis&reg; exporter service Load Balancer IP";
  type = (types.nullOr types.str);
  default = "";
};
"loadBalancerSourceRanges" = mkOption {
  description = "Redis&reg; exporter service Load Balancer sources";
  type = (types.listOf types.anything);
  default = [  ];
};
"ports" = mkOption {
  type = MetricsServicePortsModule;
  default = {  };
};
"type" = mkOption {
  description = "Redis&reg; exporter service type";
  type = (types.nullOr types.str);
  default = "ClusterIP";
};
  };
};
MetricsServiceMonitorModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "additionalEndpoints" = mkOption {
  description = "Additional endpoints to scrape (e.g sentinel)";
  type = (types.listOf types.anything);
  default = [  ];
};
"additionalLabels" = mkOption {
  description = "Additional labels that can be used so ServiceMonitor resource(s) can be discovered by Prometheus";
  type = types.anything;
  default = {  };
};
"enabled" = mkOption {
  description = "Create ServiceMonitor resource(s) for scraping metrics using PrometheusOperator";
  type = types.bool;
  default = false;
};
"honorLabels" = mkOption {
  description = "Specify honorLabels parameter to add the scrape endpoint";
  type = types.bool;
  default = false;
};
"interval" = mkOption {
  description = "The interval at which metrics should be scraped";
  type = (types.nullOr types.str);
  default = "30s";
};
"metricRelabelings" = mkOption {
  description = "Metrics RelabelConfigs to apply to samples before ingestion.";
  type = (types.listOf types.anything);
  default = [  ];
};
"namespace" = mkOption {
  description = "The namespace in which the ServiceMonitor will be created";
  type = (types.nullOr types.str);
  default = "";
};
"podTargetLabels" = mkOption {
  description = "Labels from the Kubernetes pod to be transferred to the created metrics";
  type = (types.listOf types.anything);
  default = [  ];
};
"port" = mkOption {
  description = "the service port to scrape metrics from";
  type = (types.nullOr types.str);
  default = "http-metrics";
};
"relabelings" = mkOption {
  description = "Metrics RelabelConfigs to apply to samples before scraping.";
  type = (types.listOf types.anything);
  default = [  ];
};
"sampleLimit" = mkOption {
  description = "Limit of how many samples should be scraped from every Pod";
  type = types.bool;
  default = false;
};
"scrapeTimeout" = mkOption {
  description = "The timeout after which the scrape is ended";
  type = (types.nullOr types.str);
  default = "";
};
"targetLimit" = mkOption {
  description = "Limit of how many targets should be scraped";
  type = types.bool;
  default = false;
};
"tlsConfig" = mkOption {
  description = "TLS configuration used for scrape endpoints used by Prometheus";
  type = (types.attrsOf types.anything);
  default = {  };
};
  };
};
MetricsServicePortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "http" = mkOption {
  description = "Redis&reg; exporter service port";
  type = (types.nullOr types.int);
  default = 9121;
};
  };
};
MetricsStartupProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable startupProbe on Redis&reg; replicas nodes";
  type = types.bool;
  default = false;
};
"failureThreshold" = mkOption {
  description = "Failure threshold for startupProbe";
  type = (types.nullOr types.int);
  default = 5;
};
"initialDelaySeconds" = mkOption {
  description = "Initial delay seconds for startupProbe";
  type = (types.nullOr types.int);
  default = 10;
};
"periodSeconds" = mkOption {
  description = "Period seconds for startupProbe";
  type = (types.nullOr types.int);
  default = 10;
};
"successThreshold" = mkOption {
  description = "Success threshold for startupProbe";
  type = (types.nullOr types.int);
  default = 1;
};
"timeoutSeconds" = mkOption {
  description = "Timeout seconds for startupProbe";
  type = (types.nullOr types.int);
  default = 5;
};
  };
};
NetworkPolicyMetricsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "allowExternal" = mkOption {
  description = "Don't require client label for connections for metrics endpoint";
  type = types.bool;
  default = true;
};
"ingressNSMatchLabels" = mkOption {
  description = "Labels to match to allow traffic from other namespaces to metrics endpoint";
  type = (types.attrsOf types.anything);
  default = {  };
};
"ingressNSPodMatchLabels" = mkOption {
  description = "Pod labels to match to allow traffic from other namespaces to metrics endpoint";
  type = (types.attrsOf types.anything);
  default = {  };
};
  };
};
NetworkPolicyModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "allowExternal" = mkOption {
  description = "Don't require client label for connections";
  type = types.bool;
  default = true;
};
"allowExternalEgress" = mkOption {
  description = "Allow the pod to access any range of port and all destinations.";
  type = types.bool;
  default = true;
};
"enabled" = mkOption {
  description = "Enable creation of NetworkPolicy resources";
  type = types.bool;
  default = true;
};
"extraEgress" = mkOption {
  description = "Add extra egress rules to the NetworkPolicy";
  type = types.anything;
  default = [  ];
};
"extraIngress" = mkOption {
  description = "Add extra ingress rules to the NetworkPolicy";
  type = types.anything;
  default = [  ];
};
"ingressNSMatchLabels" = mkOption {
  description = "Labels to match to allow traffic from other namespaces";
  type = (types.attrsOf types.anything);
  default = {  };
};
"ingressNSPodMatchLabels" = mkOption {
  description = "Pod labels to match to allow traffic from other namespaces";
  type = (types.attrsOf types.anything);
  default = {  };
};
"metrics" = mkOption {
  type = NetworkPolicyMetricsModule;
  default = {  };
};
  };
};
PodSecurityPolicyModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "create" = mkOption {
  description = "Whether to create a PodSecurityPolicy. WARNING: PodSecurityPolicy is deprecated in Kubernetes v1.21 or later, unavailable in v1.25 or later";
  type = types.bool;
  default = false;
};
"enabled" = mkOption {
  description = "Enable PodSecurityPolicy's RBAC rules";
  type = types.bool;
  default = false;
};
  };
};
RbacModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "create" = mkOption {
  description = "Specifies whether RBAC resources should be created";
  type = types.bool;
  default = false;
};
"rules" = mkOption {
  description = "Custom RBAC rules to set";
  type = types.anything;
  default = [  ];
};
  };
};
ReplicaAutoscalingModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable replica autoscaling settings";
  type = types.bool;
  default = false;
};
"maxReplicas" = mkOption {
  description = "Maximum replicas for the pod autoscaling";
  type = (types.nullOr types.int);
  default = 11;
};
"minReplicas" = mkOption {
  description = "Minimum replicas for the pod autoscaling";
  type = (types.nullOr types.int);
  default = 1;
};
"targetCPU" = mkOption {
  description = "Percentage of CPU to consider when autoscaling";
  type = (types.nullOr types.str);
  default = "";
};
"targetMemory" = mkOption {
  description = "Percentage of Memory to consider when autoscaling";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
ReplicaContainerPortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "redis" = mkOption {
  description = "Container port to open on Redis&reg; replicas nodes";
  type = (types.nullOr types.int);
  default = 6379;
};
  };
};
ReplicaContainerSecurityContextCapabilitiesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "drop" = mkOption {
  description = "Set Redis&reg; replicas containers' Security Context capabilities to drop";
  type = (types.listOf types.str);
  default = [ "ALL" ];
};
  };
};
ReplicaContainerSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "allowPrivilegeEscalation" = mkOption {
  description = "Set Redis&reg; replicas pod's Security Context allowPrivilegeEscalation";
  type = types.bool;
  default = false;
};
"capabilities" = mkOption {
  type = ReplicaContainerSecurityContextCapabilitiesModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Enabled Redis&reg; replicas containers' Security Context";
  type = types.bool;
  default = true;
};
"readOnlyRootFilesystem" = mkOption {
  description = "Set container's Security Context read-only root filesystem";
  type = types.bool;
  default = true;
};
"runAsGroup" = mkOption {
  description = "Set Redis&reg; replicas containers' Security Context runAsGroup";
  type = (types.nullOr types.int);
  default = 1001;
};
"runAsNonRoot" = mkOption {
  description = "Set Redis&reg; replicas containers' Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsUser" = mkOption {
  description = "Set Redis&reg; replicas containers' Security Context runAsUser";
  type = (types.nullOr types.int);
  default = 1001;
};
"seccompProfile" = mkOption {
  type = ReplicaContainerSecurityContextSeccompProfileModule;
  default = {  };
};
  };
};
ReplicaContainerSecurityContextSeccompProfileModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "type" = mkOption {
  description = "Set Redis&reg; replicas containers' Security Context seccompProfile";
  type = (types.nullOr types.str);
  default = "RuntimeDefault";
};
  };
};
ReplicaExternalMasterModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Use external master for bootstrapping";
  type = types.bool;
  default = false;
};
"host" = mkOption {
  description = "External master host to bootstrap from";
  type = (types.nullOr types.str);
  default = "";
};
"port" = mkOption {
  description = "Port for Redis service external master host";
  type = (types.nullOr types.int);
  default = 6379;
};
  };
};
ReplicaLivenessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable livenessProbe on Redis&reg; replicas nodes";
  type = types.bool;
  default = true;
};
"failureThreshold" = mkOption {
  description = "Failure threshold for livenessProbe";
  type = (types.nullOr types.int);
  default = 5;
};
"initialDelaySeconds" = mkOption {
  description = "Initial delay seconds for livenessProbe";
  type = (types.nullOr types.int);
  default = 20;
};
"periodSeconds" = mkOption {
  description = "Period seconds for livenessProbe";
  type = (types.nullOr types.int);
  default = 5;
};
"successThreshold" = mkOption {
  description = "Success threshold for livenessProbe";
  type = (types.nullOr types.int);
  default = 1;
};
"timeoutSeconds" = mkOption {
  description = "Timeout seconds for livenessProbe";
  type = (types.nullOr types.int);
  default = 5;
};
  };
};
ReplicaModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "affinity" = mkOption {
  description = "Affinity for Redis&reg; replicas pods assignment";
  type = types.anything;
  default = {  };
};
"args" = mkOption {
  description = "Override default container args (useful when using custom images)";
  type = types.anything;
  default = [  ];
};
"automountServiceAccountToken" = mkOption {
  description = "Mount Service Account token in pod";
  type = types.bool;
  default = false;
};
"autoscaling" = mkOption {
  type = ReplicaAutoscalingModule;
  default = {  };
};
"command" = mkOption {
  description = "Override default container command (useful when using custom images)";
  type = types.anything;
  default = [  ];
};
"configuration" = mkOption {
  description = "Configuration for Redis&reg; replicas nodes";
  type = (types.nullOr types.str);
  default = "";
};
"containerPorts" = mkOption {
  type = ReplicaContainerPortsModule;
  default = {  };
};
"containerSecurityContext" = mkOption {
  type = ReplicaContainerSecurityContextModule;
  default = {  };
};
"customLivenessProbe" = mkOption {
  description = "Custom livenessProbe that overrides the default one";
  type = types.anything;
  default = {  };
};
"customReadinessProbe" = mkOption {
  description = "Custom readinessProbe that overrides the default one";
  type = types.anything;
  default = {  };
};
"customStartupProbe" = mkOption {
  description = "Custom startupProbe that overrides the default one";
  type = types.anything;
  default = {  };
};
"disableCommands" = mkOption {
  description = "Array with Redis&reg; commands to disable on replicas nodes";
  type = (types.listOf types.str);
  default = [ "FLUSHDB" "FLUSHALL" ];
};
"dnsConfig" = mkOption {
  description = "DNS Configuration for Redis&reg; replica pods";
  type = types.anything;
  default = {  };
};
"dnsPolicy" = mkOption {
  description = "DNS Policy for Redis&reg; replica pods";
  type = (types.nullOr types.str);
  default = "";
};
"enableServiceLinks" = mkOption {
  description = "Whether information about services should be injected into pod's environment variable";
  type = types.bool;
  default = true;
};
"externalMaster" = mkOption {
  type = ReplicaExternalMasterModule;
  default = {  };
};
"extraEnvVars" = mkOption {
  description = "Array with extra environment variables to add to Redis&reg; replicas nodes";
  type = types.anything;
  default = [  ];
};
"extraEnvVarsCM" = mkOption {
  description = "Name of existing ConfigMap containing extra env vars for Redis&reg; replicas nodes";
  type = (types.nullOr types.str);
  default = "";
};
"extraEnvVarsSecret" = mkOption {
  description = "Name of existing Secret containing extra env vars for Redis&reg; replicas nodes";
  type = (types.nullOr types.str);
  default = "";
};
"extraFlags" = mkOption {
  description = "Array with additional command line flags for Redis&reg; replicas";
  type = (types.listOf types.anything);
  default = [  ];
};
"extraVolumeMounts" = mkOption {
  description = "Optionally specify extra list of additional volumeMounts for the Redis&reg; replicas container(s)";
  type = types.anything;
  default = [  ];
};
"extraVolumes" = mkOption {
  description = "Optionally specify extra list of additional volumes for the Redis&reg; replicas pod(s)";
  type = types.anything;
  default = [  ];
};
"hostAliases" = mkOption {
  description = "Redis&reg; replicas pods host aliases";
  type = types.anything;
  default = [  ];
};
"initContainers" = mkOption {
  description = "Add additional init containers to the Redis&reg; replicas pod(s)";
  type = types.anything;
  default = [  ];
};
"kind" = mkOption {
  description = "Use either DaemonSet or StatefulSet (default)";
  type = (types.nullOr types.str);
  default = "StatefulSet";
};
"lifecycleHooks" = mkOption {
  description = "for the Redis&reg; replica container(s) to automate configuration before or after startup";
  type = types.anything;
  default = {  };
};
"livenessProbe" = mkOption {
  type = ReplicaLivenessProbeModule;
  default = {  };
};
"minReadySeconds" = mkOption {
  description = "How many seconds a pod needs to be ready before killing the next, during update";
  type = (types.nullOr types.int);
  default = 0;
};
"nodeAffinityPreset" = mkOption {
  type = ReplicaNodeAffinityPresetModule;
  default = {  };
};
"nodeSelector" = mkOption {
  description = "Node labels for Redis&reg; replicas pods assignment";
  type = types.anything;
  default = {  };
};
"pdb" = mkOption {
  type = ReplicaPdbModule;
  default = {  };
};
"persistence" = mkOption {
  type = ReplicaPersistenceModule;
  default = {  };
};
"persistentVolumeClaimRetentionPolicy" = mkOption {
  type = ReplicaPersistentVolumeClaimRetentionPolicyModule;
  default = {  };
};
"podAffinityPreset" = mkOption {
  description = "Pod affinity preset. Ignored if `replica.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "";
};
"podAnnotations" = mkOption {
  description = "Annotations for Redis&reg; replicas pods";
  type = types.anything;
  default = {  };
};
"podAntiAffinityPreset" = mkOption {
  description = "Pod anti-affinity preset. Ignored if `replica.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "soft";
};
"podLabels" = mkOption {
  description = "Extra labels for Redis&reg; replicas pods";
  type = (types.attrsOf types.anything);
  default = {  };
};
"podManagementPolicy" = mkOption {
  description = "podManagementPolicy to manage scaling operation of %%MAIN_CONTAINER_NAME%% pods";
  type = (types.nullOr types.str);
  default = "";
};
"podSecurityContext" = mkOption {
  type = ReplicaPodSecurityContextModule;
  default = {  };
};
"preExecCmds" = mkOption {
  description = "Additional commands to run prior to starting Redis&reg; replicas";
  type = (types.listOf types.anything);
  default = [  ];
};
"priorityClassName" = mkOption {
  description = "Redis&reg; replicas pods' priorityClassName";
  type = (types.nullOr types.str);
  default = "";
};
"readinessProbe" = mkOption {
  type = ReplicaReadinessProbeModule;
  default = {  };
};
"replicaCount" = mkOption {
  description = "Number of Redis&reg; replicas to deploy";
  type = (types.nullOr types.int);
  default = 3;
};
"resources" = mkOption {
  description = "Set container requests and limits for different resources like CPU or memory (essential for production workloads)";
  type = (types.attrsOf types.anything);
  default = {  };
};
"resourcesPreset" = mkOption {
  description = "Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if replica.resources is set (replica.resources is recommended for production).";
  type = (types.nullOr types.str);
  default = "nano";
};
"revisionHistoryLimit" = mkOption {
  description = "The number of old history to retain to allow rollback";
  type = (types.nullOr types.int);
  default = 10;
};
"schedulerName" = mkOption {
  description = "Alternate scheduler for Redis&reg; replicas pods";
  type = (types.nullOr types.str);
  default = "";
};
"service" = mkOption {
  type = ReplicaServiceModule;
  default = {  };
};
"serviceAccount" = mkOption {
  type = ReplicaServiceAccountModule;
  default = {  };
};
"shareProcessNamespace" = mkOption {
  description = "Share a single process namespace between all of the containers in Redis&reg; replicas pods";
  type = types.bool;
  default = false;
};
"sidecars" = mkOption {
  description = "Add additional sidecar containers to the Redis&reg; replicas pod(s)";
  type = types.anything;
  default = [  ];
};
"startupProbe" = mkOption {
  type = ReplicaStartupProbeModule;
  default = {  };
};
"terminationGracePeriodSeconds" = mkOption {
  description = "Integer setting the termination grace period for the redis-replicas pods";
  type = (types.nullOr types.int);
  default = 30;
};
"tolerations" = mkOption {
  description = "Tolerations for Redis&reg; replicas pods assignment";
  type = types.anything;
  default = [  ];
};
"topologySpreadConstraints" = mkOption {
  description = "Spread Constraints for Redis&reg; replicas pod assignment";
  type = types.anything;
  default = [  ];
};
"updateStrategy" = mkOption {
  type = ReplicaUpdateStrategyModule;
  default = {  };
};
  };
};
ReplicaNodeAffinityPresetModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "key" = mkOption {
  description = "Node label key to match. Ignored if `replica.affinity` is set";
  type = (types.nullOr types.str);
  default = "";
};
"type" = mkOption {
  description = "Node affinity preset type. Ignored if `replica.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "";
};
"values" = mkOption {
  description = "Node label values to match. Ignored if `replica.affinity` is set";
  type = (types.listOf types.anything);
  default = [  ];
};
  };
};
ReplicaPdbModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "create" = mkOption {
  description = "Enable/disable a Pod Disruption Budget creation";
  type = types.bool;
  default = true;
};
  };
};
ReplicaPersistenceModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "accessModes" = mkOption {
  description = "Persistent Volume access modes";
  type = (types.listOf types.str);
  default = [ "ReadWriteOnce" ];
};
"annotations" = mkOption {
  description = "Additional custom annotations for the PVC";
  type = (types.attrsOf types.anything);
  default = {  };
};
"dataSource" = mkOption {
  description = "Custom PVC data source";
  type = types.anything;
  default = {  };
};
"enabled" = mkOption {
  description = "Enable persistence on Redis&reg; replicas nodes using Persistent Volume Claims";
  type = types.bool;
  default = true;
};
"existingClaim" = mkOption {
  description = "Use a existing PVC which must be created manually before bound";
  type = (types.nullOr types.str);
  default = "";
};
"labels" = mkOption {
  description = "Additional custom labels for the PVC";
  type = types.anything;
  default = {  };
};
"medium" = mkOption {
  description = "Provide a medium for `emptyDir` volumes.";
  type = (types.nullOr types.str);
  default = "";
};
"path" = mkOption {
  description = "The path the volume will be mounted at on Redis&reg; replicas containers";
  type = (types.nullOr types.str);
  default = "/data";
};
"selector" = mkOption {
  description = "Additional labels to match for the PVC";
  type = types.anything;
  default = {  };
};
"size" = mkOption {
  description = "Persistent Volume size";
  type = (types.nullOr types.str);
  default = "8Gi";
};
"sizeLimit" = mkOption {
  description = "Set this to enable a size limit for `emptyDir` volumes.";
  type = (types.nullOr types.str);
  default = "";
};
"storageClass" = mkOption {
  description = "Persistent Volume storage class";
  type = (types.nullOr types.str);
  default = "";
};
"subPath" = mkOption {
  description = "The subdirectory of the volume to mount on Redis&reg; replicas containers";
  type = (types.nullOr types.str);
  default = "";
};
"subPathExpr" = mkOption {
  description = "Used to construct the subPath subdirectory of the volume to mount on Redis&reg; replicas containers";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
ReplicaPersistentVolumeClaimRetentionPolicyModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Controls if and how PVCs are deleted during the lifecycle of a StatefulSet";
  type = types.bool;
  default = false;
};
"whenDeleted" = mkOption {
  description = "Volume retention behavior that applies when the StatefulSet is deleted";
  type = (types.nullOr types.str);
  default = "Retain";
};
"whenScaled" = mkOption {
  description = "Volume retention behavior when the replica count of the StatefulSet is reduced";
  type = (types.nullOr types.str);
  default = "Retain";
};
  };
};
ReplicaPodSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enabled Redis&reg; replicas pods' Security Context";
  type = types.bool;
  default = true;
};
"fsGroup" = mkOption {
  description = "Set Redis&reg; replicas pod's Security Context fsGroup";
  type = (types.nullOr types.int);
  default = 1001;
};
"fsGroupChangePolicy" = mkOption {
  description = "Set filesystem group change policy";
  type = (types.nullOr types.str);
  default = "Always";
};
"supplementalGroups" = mkOption {
  description = "Set filesystem extra groups";
  type = (types.listOf types.anything);
  default = [  ];
};
"sysctls" = mkOption {
  description = "Set kernel settings using the sysctl interface";
  type = (types.listOf types.anything);
  default = [  ];
};
  };
};
ReplicaReadinessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable readinessProbe on Redis&reg; replicas nodes";
  type = types.bool;
  default = true;
};
"failureThreshold" = mkOption {
  description = "Failure threshold for readinessProbe";
  type = (types.nullOr types.int);
  default = 5;
};
"initialDelaySeconds" = mkOption {
  description = "Initial delay seconds for readinessProbe";
  type = (types.nullOr types.int);
  default = 20;
};
"periodSeconds" = mkOption {
  description = "Period seconds for readinessProbe";
  type = (types.nullOr types.int);
  default = 5;
};
"successThreshold" = mkOption {
  description = "Success threshold for readinessProbe";
  type = (types.nullOr types.int);
  default = 1;
};
"timeoutSeconds" = mkOption {
  description = "Timeout seconds for readinessProbe";
  type = (types.nullOr types.int);
  default = 1;
};
  };
};
ReplicaServiceAccountModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Additional custom annotations for the ServiceAccount";
  type = types.anything;
  default = {  };
};
"automountServiceAccountToken" = mkOption {
  description = "Whether to auto mount the service account token";
  type = types.bool;
  default = false;
};
"create" = mkOption {
  description = "Specifies whether a ServiceAccount should be created";
  type = types.bool;
  default = true;
};
"name" = mkOption {
  description = "The name of the ServiceAccount to use.";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
ReplicaServiceModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Additional custom annotations for Redis&reg; replicas service";
  type = types.anything;
  default = {  };
};
"clusterIP" = mkOption {
  description = "Redis&reg; replicas service Cluster IP";
  type = (types.nullOr types.str);
  default = "";
};
"externalTrafficPolicy" = mkOption {
  description = "Redis&reg; replicas service external traffic policy";
  type = (types.nullOr types.str);
  default = "Cluster";
};
"extraPorts" = mkOption {
  description = "Extra ports to expose (normally used with the `sidecar` value)";
  type = types.anything;
  default = [  ];
};
"internalTrafficPolicy" = mkOption {
  description = "Redis&reg; replicas service internal traffic policy (requires Kubernetes v1.22 or greater to be usable)";
  type = (types.nullOr types.str);
  default = "Cluster";
};
"loadBalancerClass" = mkOption {
  description = "replicas service Load Balancer class if service type is `LoadBalancer` (optional, cloud specific)";
  type = (types.nullOr types.str);
  default = "";
};
"loadBalancerIP" = mkOption {
  description = "Redis&reg; replicas service Load Balancer IP";
  type = (types.nullOr types.str);
  default = "";
};
"loadBalancerSourceRanges" = mkOption {
  description = "Redis&reg; replicas service Load Balancer sources";
  type = (types.listOf types.anything);
  default = [  ];
};
"nodePorts" = mkOption {
  type = ReplicaServiceNodePortsModule;
  default = {  };
};
"ports" = mkOption {
  type = ReplicaServicePortsModule;
  default = {  };
};
"sessionAffinity" = mkOption {
  description = "Session Affinity for Kubernetes service, can be \"None\" or \"ClientIP\"";
  type = (types.nullOr types.str);
  default = "None";
};
"sessionAffinityConfig" = mkOption {
  description = "Additional settings for the sessionAffinity";
  type = types.anything;
  default = {  };
};
"type" = mkOption {
  description = "Redis&reg; replicas service type";
  type = (types.nullOr types.str);
  default = "ClusterIP";
};
  };
};
ReplicaServiceNodePortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "redis" = mkOption {
  description = "Node port for Redis&reg; replicas";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
ReplicaServicePortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "redis" = mkOption {
  description = "Redis&reg; replicas service port";
  type = (types.nullOr types.int);
  default = 6379;
};
  };
};
ReplicaStartupProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable startupProbe on Redis&reg; replicas nodes";
  type = types.bool;
  default = true;
};
"failureThreshold" = mkOption {
  description = "Failure threshold for startupProbe";
  type = (types.nullOr types.int);
  default = 22;
};
"initialDelaySeconds" = mkOption {
  description = "Initial delay seconds for startupProbe";
  type = (types.nullOr types.int);
  default = 10;
};
"periodSeconds" = mkOption {
  description = "Period seconds for startupProbe";
  type = (types.nullOr types.int);
  default = 10;
};
"successThreshold" = mkOption {
  description = "Success threshold for startupProbe";
  type = (types.nullOr types.int);
  default = 1;
};
"timeoutSeconds" = mkOption {
  description = "Timeout seconds for startupProbe";
  type = (types.nullOr types.int);
  default = 5;
};
  };
};
ReplicaUpdateStrategyModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "type" = mkOption {
  description = "Redis&reg; replicas statefulset strategy type";
  type = (types.nullOr types.str);
  default = "RollingUpdate";
};
  };
};
SentinelContainerPortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "sentinel" = mkOption {
  description = "Container port to open on Redis&reg; Sentinel nodes";
  type = (types.nullOr types.int);
  default = 26379;
};
  };
};
SentinelContainerSecurityContextCapabilitiesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "drop" = mkOption {
  description = "Set Redis&reg; Sentinel containers' Security Context capabilities to drop";
  type = (types.listOf types.str);
  default = [ "ALL" ];
};
  };
};
SentinelContainerSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "allowPrivilegeEscalation" = mkOption {
  description = "Set Redis&reg; Sentinel containers' Security Context allowPrivilegeEscalation";
  type = types.bool;
  default = false;
};
"capabilities" = mkOption {
  type = SentinelContainerSecurityContextCapabilitiesModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Enabled Redis&reg; Sentinel containers' Security Context";
  type = types.bool;
  default = true;
};
"readOnlyRootFilesystem" = mkOption {
  description = "Set container's Security Context read-only root filesystem";
  type = types.bool;
  default = true;
};
"runAsGroup" = mkOption {
  description = "Set Redis&reg; Sentinel containers' Security Context runAsGroup";
  type = (types.nullOr types.int);
  default = 1001;
};
"runAsNonRoot" = mkOption {
  description = "Set Redis&reg; Sentinel containers' Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsUser" = mkOption {
  description = "Set Redis&reg; Sentinel containers' Security Context runAsUser";
  type = (types.nullOr types.int);
  default = 1001;
};
"seccompProfile" = mkOption {
  type = SentinelContainerSecurityContextSeccompProfileModule;
  default = {  };
};
  };
};
SentinelContainerSecurityContextSeccompProfileModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "type" = mkOption {
  description = "Set Redis&reg; Sentinel containers' Security Context seccompProfile";
  type = (types.nullOr types.str);
  default = "RuntimeDefault";
};
  };
};
SentinelExternalMasterModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Use external master for bootstrapping";
  type = types.bool;
  default = false;
};
"host" = mkOption {
  description = "External master host to bootstrap from";
  type = (types.nullOr types.str);
  default = "";
};
"port" = mkOption {
  description = "Port for Redis service external master host";
  type = (types.nullOr types.int);
  default = 6379;
};
  };
};
SentinelImageModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "debug" = mkOption {
  description = "Enable image debug mode";
  type = types.bool;
  default = false;
};
"digest" = mkOption {
  description = "Redis&reg; Sentinel image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag";
  type = (types.nullOr types.str);
  default = "";
};
"pullPolicy" = mkOption {
  description = "Redis&reg; Sentinel image pull policy";
  type = (types.nullOr types.str);
  default = "IfNotPresent";
};
"pullSecrets" = mkOption {
  description = "Redis&reg; Sentinel image pull secrets";
  type = (types.listOf types.anything);
  default = [  ];
};
"registry" = mkOption {
  description = "Redis&reg; Sentinel image registry";
  type = (types.nullOr types.str);
  default = "REGISTRY_NAME";
};
"repository" = mkOption {
  description = "Redis&reg; Sentinel image repository";
  type = (types.nullOr types.str);
  default = "REPOSITORY_NAME/redis-sentinel";
};
  };
};
SentinelLivenessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable livenessProbe on Redis&reg; Sentinel nodes";
  type = types.bool;
  default = true;
};
"failureThreshold" = mkOption {
  description = "Failure threshold for livenessProbe";
  type = (types.nullOr types.int);
  default = 6;
};
"initialDelaySeconds" = mkOption {
  description = "Initial delay seconds for livenessProbe";
  type = (types.nullOr types.int);
  default = 20;
};
"periodSeconds" = mkOption {
  description = "Period seconds for livenessProbe";
  type = (types.nullOr types.int);
  default = 10;
};
"successThreshold" = mkOption {
  description = "Success threshold for livenessProbe";
  type = (types.nullOr types.int);
  default = 1;
};
"timeoutSeconds" = mkOption {
  description = "Timeout seconds for livenessProbe";
  type = (types.nullOr types.int);
  default = 5;
};
  };
};
SentinelMasterServiceModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Additional custom annotations for Redis&reg; master service";
  type = (types.attrsOf types.anything);
  default = {  };
};
"clusterIP" = mkOption {
  description = "Redis&reg; master service Cluster IP";
  type = (types.nullOr types.str);
  default = "";
};
"enabled" = mkOption {
  description = "Enable master service pointing to the current master (experimental)";
  type = types.bool;
  default = false;
};
"externalTrafficPolicy" = mkOption {
  description = "Redis&reg; master service external traffic policy";
  type = (types.nullOr types.str);
  default = "";
};
"extraPorts" = mkOption {
  description = "Extra ports to expose (normally used with the `sidecar` value)";
  type = types.anything;
  default = [  ];
};
"loadBalancerClass" = mkOption {
  description = "master service Load Balancer class if service type is `LoadBalancer` (optional, cloud specific)";
  type = (types.nullOr types.str);
  default = "";
};
"loadBalancerIP" = mkOption {
  description = "Redis&reg; master service Load Balancer IP";
  type = (types.nullOr types.str);
  default = "";
};
"loadBalancerSourceRanges" = mkOption {
  description = "Redis&reg; master service Load Balancer sources";
  type = (types.listOf types.anything);
  default = [  ];
};
"nodePorts" = mkOption {
  type = SentinelMasterServiceNodePortsModule;
  default = {  };
};
"ports" = mkOption {
  type = SentinelMasterServicePortsModule;
  default = {  };
};
"sessionAffinity" = mkOption {
  description = "Session Affinity for Kubernetes service, can be \"None\" or \"ClientIP\"";
  type = (types.nullOr types.str);
  default = "None";
};
"sessionAffinityConfig" = mkOption {
  description = "Additional settings for the sessionAffinity";
  type = types.anything;
  default = {  };
};
"type" = mkOption {
  description = "Redis&reg; Sentinel master service type";
  type = (types.nullOr types.str);
  default = "ClusterIP";
};
  };
};
SentinelMasterServiceNodePortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "redis" = mkOption {
  description = "Node port for Redis&reg;";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
SentinelMasterServicePortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "redis" = mkOption {
  description = "Redis&reg; service port for Redis&reg;";
  type = (types.nullOr types.int);
  default = 6379;
};
  };
};
SentinelModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Additional custom annotations for Redis&reg; Sentinel resource";
  type = types.anything;
  default = {  };
};
"args" = mkOption {
  description = "Override default container args (useful when using custom images)";
  type = types.anything;
  default = [  ];
};
"automateClusterRecovery" = mkOption {
  description = "Automate cluster recovery in cases where the last replica is not considered a good replica and Sentinel won't automatically failover to it.";
  type = types.bool;
  default = false;
};
"command" = mkOption {
  description = "Override default container command (useful when using custom images)";
  type = types.anything;
  default = [  ];
};
"configuration" = mkOption {
  description = "Configuration for Redis&reg; Sentinel nodes";
  type = (types.nullOr types.str);
  default = "";
};
"containerPorts" = mkOption {
  type = SentinelContainerPortsModule;
  default = {  };
};
"containerSecurityContext" = mkOption {
  type = SentinelContainerSecurityContextModule;
  default = {  };
};
"customLivenessProbe" = mkOption {
  description = "Custom livenessProbe that overrides the default one";
  type = types.anything;
  default = {  };
};
"customReadinessProbe" = mkOption {
  description = "Custom readinessProbe that overrides the default one";
  type = types.anything;
  default = {  };
};
"customStartupProbe" = mkOption {
  description = "Custom startupProbe that overrides the default one";
  type = types.anything;
  default = {  };
};
"downAfterMilliseconds" = mkOption {
  description = "Timeout for detecting a Redis&reg; node is down";
  type = (types.nullOr types.int);
  default = 60000;
};
"enableServiceLinks" = mkOption {
  description = "Whether information about services should be injected into pod's environment variable";
  type = types.bool;
  default = true;
};
"enabled" = mkOption {
  description = "Use Redis&reg; Sentinel on Redis&reg; pods.";
  type = types.bool;
  default = false;
};
"externalMaster" = mkOption {
  type = SentinelExternalMasterModule;
  default = {  };
};
"extraEnvVars" = mkOption {
  description = "Array with extra environment variables to add to Redis&reg; Sentinel nodes";
  type = types.anything;
  default = [  ];
};
"extraEnvVarsCM" = mkOption {
  description = "Name of existing ConfigMap containing extra env vars for Redis&reg; Sentinel nodes";
  type = (types.nullOr types.str);
  default = "";
};
"extraEnvVarsSecret" = mkOption {
  description = "Name of existing Secret containing extra env vars for Redis&reg; Sentinel nodes";
  type = (types.nullOr types.str);
  default = "";
};
"extraVolumeMounts" = mkOption {
  description = "Optionally specify extra list of additional volumeMounts for the Redis&reg; Sentinel container(s)";
  type = types.anything;
  default = [  ];
};
"extraVolumes" = mkOption {
  description = "Optionally specify extra list of additional volumes for the Redis&reg; Sentinel";
  type = types.anything;
  default = [  ];
};
"failoverTimeout" = mkOption {
  description = "Timeout for performing a election failover";
  type = (types.nullOr types.int);
  default = 180000;
};
"getMasterTimeout" = mkOption {
  description = "Amount of time to allow before get_sentinel_master_info() times out.";
  type = (types.nullOr types.int);
  default = 90;
};
"image" = mkOption {
  type = SentinelImageModule;
  default = {  };
};
"lifecycleHooks" = mkOption {
  description = "for the Redis&reg; sentinel container(s) to automate configuration before or after startup";
  type = types.anything;
  default = {  };
};
"livenessProbe" = mkOption {
  type = SentinelLivenessProbeModule;
  default = {  };
};
"masterService" = mkOption {
  type = SentinelMasterServiceModule;
  default = {  };
};
"masterSet" = mkOption {
  description = "Master set name";
  type = (types.nullOr types.str);
  default = "mymaster";
};
"parallelSyncs" = mkOption {
  description = "Number of replicas that can be reconfigured in parallel to use the new master after a failover";
  type = (types.nullOr types.int);
  default = 1;
};
"persistence" = mkOption {
  type = SentinelPersistenceModule;
  default = {  };
};
"persistentVolumeClaimRetentionPolicy" = mkOption {
  type = SentinelPersistentVolumeClaimRetentionPolicyModule;
  default = {  };
};
"preExecCmds" = mkOption {
  description = "Additional commands to run prior to starting Redis&reg; Sentinel";
  type = (types.listOf types.anything);
  default = [  ];
};
"quorum" = mkOption {
  description = "Sentinel Quorum";
  type = (types.nullOr types.int);
  default = 2;
};
"readinessProbe" = mkOption {
  type = SentinelReadinessProbeModule;
  default = {  };
};
"redisShutdownWaitFailover" = mkOption {
  description = "Whether the Redis&reg; master container waits for the failover at shutdown (in addition to the Redis&reg; Sentinel container).";
  type = types.bool;
  default = true;
};
"resources" = mkOption {
  description = "Set container requests and limits for different resources like CPU or memory (essential for production workloads)";
  type = (types.attrsOf types.anything);
  default = {  };
};
"resourcesPreset" = mkOption {
  description = "Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if sentinel.resources is set (sentinel.resources is recommended for production).";
  type = (types.nullOr types.str);
  default = "nano";
};
"service" = mkOption {
  type = SentinelServiceModule;
  default = {  };
};
"startupProbe" = mkOption {
  type = SentinelStartupProbeModule;
  default = {  };
};
"terminationGracePeriodSeconds" = mkOption {
  description = "Integer setting the termination grace period for the redis-node pods";
  type = (types.nullOr types.int);
  default = 30;
};
  };
};
SentinelPersistenceModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "accessModes" = mkOption {
  description = "Persistent Volume access modes";
  type = (types.listOf types.str);
  default = [ "ReadWriteOnce" ];
};
"annotations" = mkOption {
  description = "Additional custom annotations for the PVC";
  type = (types.attrsOf types.anything);
  default = {  };
};
"dataSource" = mkOption {
  description = "Custom PVC data source";
  type = types.anything;
  default = {  };
};
"enabled" = mkOption {
  description = "Enable persistence on Redis&reg; sentinel nodes using Persistent Volume Claims (Experimental)";
  type = types.bool;
  default = false;
};
"labels" = mkOption {
  description = "Additional custom labels for the PVC";
  type = types.anything;
  default = {  };
};
"medium" = mkOption {
  description = "Provide a medium for `emptyDir` volumes.";
  type = (types.nullOr types.str);
  default = "";
};
"selector" = mkOption {
  description = "Additional labels to match for the PVC";
  type = types.anything;
  default = {  };
};
"size" = mkOption {
  description = "Persistent Volume size";
  type = (types.nullOr types.str);
  default = "100Mi";
};
"sizeLimit" = mkOption {
  description = "Set this to enable a size limit for `emptyDir` volumes.";
  type = (types.nullOr types.str);
  default = "";
};
"storageClass" = mkOption {
  description = "Persistent Volume storage class";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
SentinelPersistentVolumeClaimRetentionPolicyModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Controls if and how PVCs are deleted during the lifecycle of a StatefulSet";
  type = types.bool;
  default = false;
};
"whenDeleted" = mkOption {
  description = "Volume retention behavior that applies when the StatefulSet is deleted";
  type = (types.nullOr types.str);
  default = "Retain";
};
"whenScaled" = mkOption {
  description = "Volume retention behavior when the replica count of the StatefulSet is reduced";
  type = (types.nullOr types.str);
  default = "Retain";
};
  };
};
SentinelReadinessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable readinessProbe on Redis&reg; Sentinel nodes";
  type = types.bool;
  default = true;
};
"failureThreshold" = mkOption {
  description = "Failure threshold for readinessProbe";
  type = (types.nullOr types.int);
  default = 6;
};
"initialDelaySeconds" = mkOption {
  description = "Initial delay seconds for readinessProbe";
  type = (types.nullOr types.int);
  default = 20;
};
"periodSeconds" = mkOption {
  description = "Period seconds for readinessProbe";
  type = (types.nullOr types.int);
  default = 5;
};
"successThreshold" = mkOption {
  description = "Success threshold for readinessProbe";
  type = (types.nullOr types.int);
  default = 1;
};
"timeoutSeconds" = mkOption {
  description = "Timeout seconds for readinessProbe";
  type = (types.nullOr types.int);
  default = 1;
};
  };
};
SentinelServiceHeadlessModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Annotations for the headless service.";
  type = types.anything;
  default = {  };
};
"extraPorts" = mkOption {
  description = "Extra ports to expose for the headless service";
  type = (types.listOf types.anything);
  default = [  ];
};
  };
};
SentinelServiceModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Additional custom annotations for Redis&reg; Sentinel service";
  type = types.anything;
  default = {  };
};
"clusterIP" = mkOption {
  description = "Redis&reg; Sentinel service Cluster IP";
  type = (types.nullOr types.str);
  default = "";
};
"createMaster" = mkOption {
  description = "Enable master service pointing to the current master (experimental)";
  type = types.bool;
  default = false;
};
"externalTrafficPolicy" = mkOption {
  description = "Redis&reg; Sentinel service external traffic policy";
  type = (types.nullOr types.str);
  default = "Cluster";
};
"extraPorts" = mkOption {
  description = "Extra ports to expose (normally used with the `sidecar` value)";
  type = types.anything;
  default = [  ];
};
"headless" = mkOption {
  type = SentinelServiceHeadlessModule;
  default = {  };
};
"loadBalancerClass" = mkOption {
  description = "sentinel service Load Balancer class if service type is `LoadBalancer` (optional, cloud specific)";
  type = (types.nullOr types.str);
  default = "";
};
"loadBalancerIP" = mkOption {
  description = "Redis&reg; Sentinel service Load Balancer IP";
  type = (types.nullOr types.str);
  default = "";
};
"loadBalancerSourceRanges" = mkOption {
  description = "Redis&reg; Sentinel service Load Balancer sources";
  type = (types.listOf types.anything);
  default = [  ];
};
"nodePorts" = mkOption {
  type = SentinelServiceNodePortsModule;
  default = {  };
};
"ports" = mkOption {
  type = SentinelServicePortsModule;
  default = {  };
};
"sessionAffinity" = mkOption {
  description = "Session Affinity for Kubernetes service, can be \"None\" or \"ClientIP\"";
  type = (types.nullOr types.str);
  default = "None";
};
"sessionAffinityConfig" = mkOption {
  description = "Additional settings for the sessionAffinity";
  type = types.anything;
  default = {  };
};
"type" = mkOption {
  description = "Redis&reg; Sentinel service type";
  type = (types.nullOr types.str);
  default = "ClusterIP";
};
  };
};
SentinelServiceNodePortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "redis" = mkOption {
  description = "Node port for Redis&reg;";
  type = (types.nullOr types.str);
  default = "";
};
"sentinel" = mkOption {
  description = "Node port for Sentinel";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
SentinelServicePortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "redis" = mkOption {
  description = "Redis&reg; service port for Redis&reg;";
  type = (types.nullOr types.int);
  default = 6379;
};
"sentinel" = mkOption {
  description = "Redis&reg; service port for Redis&reg; Sentinel";
  type = (types.nullOr types.int);
  default = 26379;
};
  };
};
SentinelStartupProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable startupProbe on Redis&reg; Sentinel nodes";
  type = types.bool;
  default = true;
};
"failureThreshold" = mkOption {
  description = "Failure threshold for startupProbe";
  type = (types.nullOr types.int);
  default = 22;
};
"initialDelaySeconds" = mkOption {
  description = "Initial delay seconds for startupProbe";
  type = (types.nullOr types.int);
  default = 10;
};
"periodSeconds" = mkOption {
  description = "Period seconds for startupProbe";
  type = (types.nullOr types.int);
  default = 10;
};
"successThreshold" = mkOption {
  description = "Success threshold for startupProbe";
  type = (types.nullOr types.int);
  default = 1;
};
"timeoutSeconds" = mkOption {
  description = "Timeout seconds for startupProbe";
  type = (types.nullOr types.int);
  default = 5;
};
  };
};
ServiceAccountModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Additional custom annotations for the ServiceAccount";
  type = types.anything;
  default = {  };
};
"automountServiceAccountToken" = mkOption {
  description = "Whether to auto mount the service account token";
  type = types.bool;
  default = false;
};
"create" = mkOption {
  description = "Specifies whether a ServiceAccount should be created";
  type = types.bool;
  default = true;
};
"name" = mkOption {
  description = "The name of the ServiceAccount to use.";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
ServiceBindingsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Create secret for service binding (Experimental)";
  type = types.bool;
  default = false;
};
  };
};
SysctlImageModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "digest" = mkOption {
  description = "OS Shell + Utility image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag";
  type = (types.nullOr types.str);
  default = "";
};
"pullPolicy" = mkOption {
  description = "OS Shell + Utility image pull policy";
  type = (types.nullOr types.str);
  default = "IfNotPresent";
};
"pullSecrets" = mkOption {
  description = "OS Shell + Utility image pull secrets";
  type = (types.listOf types.anything);
  default = [  ];
};
"registry" = mkOption {
  description = "OS Shell + Utility image registry";
  type = (types.nullOr types.str);
  default = "REGISTRY_NAME";
};
"repository" = mkOption {
  description = "OS Shell + Utility image repository";
  type = (types.nullOr types.str);
  default = "REPOSITORY_NAME/os-shell";
};
  };
};
SysctlModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "command" = mkOption {
  description = "Override default init-sysctl container command (useful when using custom images)";
  type = types.anything;
  default = [  ];
};
"enabled" = mkOption {
  description = "Enable init container to modify Kernel settings";
  type = types.bool;
  default = false;
};
"image" = mkOption {
  type = SysctlImageModule;
  default = {  };
};
"mountHostSys" = mkOption {
  description = "Mount the host `/sys` folder to `/host-sys`";
  type = types.bool;
  default = false;
};
"resources" = mkOption {
  description = "Set container requests and limits for different resources like CPU or memory (essential for production workloads)";
  type = (types.attrsOf types.anything);
  default = {  };
};
"resourcesPreset" = mkOption {
  description = "Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if sysctl.resources is set (sysctl.resources is recommended for production).";
  type = (types.nullOr types.str);
  default = "nano";
};
  };
};
TlsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "authClients" = mkOption {
  description = "Require clients to authenticate";
  type = types.bool;
  default = true;
};
"autoGenerated" = mkOption {
  description = "Enable autogenerated certificates";
  type = types.bool;
  default = false;
};
"certCAFilename" = mkOption {
  description = "CA Certificate filename";
  type = (types.nullOr types.str);
  default = "";
};
"certFilename" = mkOption {
  description = "Certificate filename";
  type = (types.nullOr types.str);
  default = "";
};
"certKeyFilename" = mkOption {
  description = "Certificate Key filename";
  type = (types.nullOr types.str);
  default = "";
};
"certificatesSecret" = mkOption {
  description = "DEPRECATED. Use existingSecret instead.";
  type = (types.nullOr types.str);
  default = "";
};
"dhParamsFilename" = mkOption {
  description = "File containing DH params (in order to support DH based ciphers)";
  type = (types.nullOr types.str);
  default = "";
};
"enabled" = mkOption {
  description = "Enable TLS traffic";
  type = types.bool;
  default = false;
};
"existingSecret" = mkOption {
  description = "The name of the existing secret that contains the TLS certificates";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
UseExternalDNSModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "additionalAnnotations" = mkOption {
  description = "Extra annotations to be utilized when `external-dns` is enabled.";
  type = (types.attrsOf types.anything);
  default = {  };
};
"annotationKey" = mkOption {
  description = "The annotation key utilized when `external-dns` is enabled. Setting this to `false` will disable annotations.";
  type = (types.nullOr types.str);
  default = "external-dns.alpha.kubernetes.io/";
};
"enabled" = mkOption {
  description = "Enable various syntax that would enable external-dns to work.  Note this requires a working installation of `external-dns` to be usable.";
  type = types.bool;
  default = false;
};
"suffix" = mkOption {
  description = "The DNS suffix utilized when `external-dns` is enabled.  Note that we prepend the suffix with the full name of the release.";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
VolumePermissionsContainerSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "runAsUser" = mkOption {
  description = "Set init container's Security Context runAsUser";
  type = (types.nullOr types.int);
  default = 0;
};
  };
};
VolumePermissionsImageModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "digest" = mkOption {
  description = "OS Shell + Utility image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag";
  type = (types.nullOr types.str);
  default = "";
};
"pullPolicy" = mkOption {
  description = "OS Shell + Utility image pull policy";
  type = (types.nullOr types.str);
  default = "IfNotPresent";
};
"pullSecrets" = mkOption {
  description = "OS Shell + Utility image pull secrets";
  type = (types.listOf types.anything);
  default = [  ];
};
"registry" = mkOption {
  description = "OS Shell + Utility image registry";
  type = (types.nullOr types.str);
  default = "REGISTRY_NAME";
};
"repository" = mkOption {
  description = "OS Shell + Utility image repository";
  type = (types.nullOr types.str);
  default = "REPOSITORY_NAME/os-shell";
};
  };
};
VolumePermissionsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "containerSecurityContext" = mkOption {
  type = VolumePermissionsContainerSecurityContextModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Enable init container that changes the owner/group of the PV mount point to `runAsUser:fsGroup`";
  type = types.bool;
  default = false;
};
"image" = mkOption {
  type = VolumePermissionsImageModule;
  default = {  };
};
"resources" = mkOption {
  description = "Set container requests and limits for different resources like CPU or memory (essential for production workloads)";
  type = (types.attrsOf types.anything);
  default = {  };
};
"resourcesPreset" = mkOption {
  description = "Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if volumePermissions.resources is set (volumePermissions.resources is recommended for production).";
  type = (types.nullOr types.str);
  default = "nano";
};
  };
};
in
{
  freeformType = types.attrsOf types.anything;
  options = {
    "architecture" = mkOption {
  description = "Redis&reg; architecture. Allowed values: `standalone` or `replication`";
  type = (types.nullOr types.str);
  default = "replication";
};
"auth" = mkOption {
  type = AuthModule;
  default = {  };
};
"clusterDomain" = mkOption {
  description = "Kubernetes cluster domain name";
  type = (types.nullOr types.str);
  default = "cluster.local";
};
"commonAnnotations" = mkOption {
  description = "Annotations to add to all deployed objects";
  type = types.anything;
  default = {  };
};
"commonConfiguration" = mkOption {
  description = "Common configuration to be added into the ConfigMap";
  type = (types.nullOr types.str);
  default = """";
};
"commonLabels" = mkOption {
  description = "Labels to add to all deployed objects";
  type = types.anything;
  default = {  };
};
"diagnosticMode" = mkOption {
  type = DiagnosticModeModule;
  default = {  };
};
"existingConfigmap" = mkOption {
  description = "The name of an existing ConfigMap with your custom configuration for Redis&reg; nodes";
  type = (types.nullOr types.str);
  default = "";
};
"extraDeploy" = mkOption {
  description = "Array of extra objects to deploy with the release";
  type = (types.listOf types.anything);
  default = [  ];
};
"fullnameOverride" = mkOption {
  description = "String to fully override common.names.fullname";
  type = (types.nullOr types.str);
  default = "";
};
"global" = mkOption {
  type = GlobalModule;
  default = {  };
};
"image" = mkOption {
  type = ImageModule;
  default = {  };
};
"kubeVersion" = mkOption {
  description = "Override Kubernetes version";
  type = (types.nullOr types.str);
  default = "";
};
"kubectl" = mkOption {
  type = KubectlModule;
  default = {  };
};
"master" = mkOption {
  type = MasterModule;
  default = {  };
};
"metrics" = mkOption {
  type = MetricsModule;
  default = {  };
};
"nameOverride" = mkOption {
  description = "String to partially override common.names.fullname";
  type = (types.nullOr types.str);
  default = "";
};
"nameResolutionThreshold" = mkOption {
  description = "Failure threshold for internal hostnames resolution";
  type = (types.nullOr types.int);
  default = 5;
};
"nameResolutionTimeout" = mkOption {
  description = "Timeout seconds between probes for internal hostnames resolution";
  type = (types.nullOr types.int);
  default = 5;
};
"namespaceOverride" = mkOption {
  description = "String to fully override common.names.namespace";
  type = (types.nullOr types.str);
  default = "";
};
"networkPolicy" = mkOption {
  type = NetworkPolicyModule;
  default = {  };
};
"pdb" = mkOption {
  description = "DEPRECATED Please use `master.pdb` and `replica.pdb` values instead";
  type = (types.attrsOf types.anything);
  default = {  };
};
"podSecurityPolicy" = mkOption {
  type = PodSecurityPolicyModule;
  default = {  };
};
"rbac" = mkOption {
  type = RbacModule;
  default = {  };
};
"replica" = mkOption {
  type = ReplicaModule;
  default = {  };
};
"secretAnnotations" = mkOption {
  description = "Annotations to add to secret";
  type = types.anything;
  default = {  };
};
"sentinel" = mkOption {
  type = SentinelModule;
  default = {  };
};
"serviceAccount" = mkOption {
  type = ServiceAccountModule;
  default = {  };
};
"serviceBindings" = mkOption {
  type = ServiceBindingsModule;
  default = {  };
};
"sysctl" = mkOption {
  type = SysctlModule;
  default = {  };
};
"tls" = mkOption {
  type = TlsModule;
  default = {  };
};
"useExternalDNS" = mkOption {
  type = UseExternalDNSModule;
  default = {  };
};
"useHostnames" = mkOption {
  description = "Use hostnames internally when announcing replication. If false, the hostname will be resolved to an IP address";
  type = types.bool;
  default = true;
};
"volumePermissions" = mkOption {
  type = VolumePermissionsModule;
  default = {  };
};
  };
}
