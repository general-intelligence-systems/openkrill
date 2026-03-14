# Auto-generated from Bitnami values.schema.json
# Do not edit — regenerate with bin/create-module-bitnami
{ lib, ... }:
with lib;
let
  ClientContainerSecurityContextCapabilitiesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "drop" = mkOption {
  description = "Set Client container's Security Context runAsNonRoot";
  type = (types.listOf types.str);
  default = [ "ALL" ];
};
  };
};
ClientContainerSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "allowPrivilegeEscalation" = mkOption {
  description = "Set Client container's privilege escalation";
  type = types.bool;
  default = false;
};
"capabilities" = mkOption {
  type = ClientContainerSecurityContextCapabilitiesModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Enabled Client containers' Security Context";
  type = types.bool;
  default = true;
};
"readOnlyRootFilesystem" = mkOption {
  description = "Set Client containers' Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsGroup" = mkOption {
  description = "Set Client containers' Security Context runAsGroup";
  type = (types.nullOr types.int);
  default = 1001;
};
"runAsNonRoot" = mkOption {
  description = "Set Client containers' Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsUser" = mkOption {
  description = "Set Client containers' Security Context runAsUser";
  type = (types.nullOr types.int);
  default = 1001;
};
  };
};
ClientLivenessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable livenessProbe on Client nodes";
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
  default = 5;
};
"periodSeconds" = mkOption {
  description = "Period seconds for livenessProbe";
  type = (types.nullOr types.int);
  default = 30;
};
"successThreshold" = mkOption {
  description = "Success threshold for livenessProbe";
  type = (types.nullOr types.int);
  default = 1;
};
"timeoutSeconds" = mkOption {
  description = "Timeout seconds for livenessProbe";
  type = (types.nullOr types.int);
  default = 20;
};
  };
};
ClientModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "affinity" = mkOption {
  description = "Affinity for Client pods assignment";
  type = (types.attrsOf types.anything);
  default = {  };
};
"annotations" = mkOption {
  description = "Annotations for the client deployment";
  type = (types.attrsOf types.anything);
  default = {  };
};
"args" = mkOption {
  description = "Override default container args (useful when using custom images)";
  type = (types.listOf types.anything);
  default = [  ];
};
"backoffLimit" = mkOption {
  description = "set backoff limit of the job";
  type = (types.nullOr types.int);
  default = 10;
};
"command" = mkOption {
  description = "Override default container command (useful when using custom images)";
  type = (types.listOf types.anything);
  default = [  ];
};
"containerSecurityContext" = mkOption {
  type = ClientContainerSecurityContextModule;
  default = {  };
};
"customLivenessProbe" = mkOption {
  description = "Custom livenessProbe that overrides the default one";
  type = (types.attrsOf types.anything);
  default = {  };
};
"customReadinessProbe" = mkOption {
  description = "Custom readinessProbe that overrides the default one";
  type = (types.attrsOf types.anything);
  default = {  };
};
"customStartupProbe" = mkOption {
  description = "Custom startupProbe that overrides the default one";
  type = (types.attrsOf types.anything);
  default = {  };
};
"enableDefaultInitContainers" = mkOption {
  description = "Deploy default init containers";
  type = types.bool;
  default = true;
};
"enabled" = mkOption {
  description = "Enable Client deployment";
  type = types.bool;
  default = true;
};
"extraEnvVars" = mkOption {
  description = "Array with extra environment variables to add to client nodes";
  type = (types.listOf types.anything);
  default = [  ];
};
"extraEnvVarsCM" = mkOption {
  description = "Name of existing ConfigMap containing extra env vars for client nodes";
  type = (types.nullOr types.str);
  default = "";
};
"extraEnvVarsSecret" = mkOption {
  description = "Name of existing Secret containing extra env vars for client nodes";
  type = (types.nullOr types.str);
  default = "";
};
"extraVolumeMounts" = mkOption {
  description = "Optionally specify extra list of additional volumeMounts for the Client container(s)";
  type = (types.listOf types.anything);
  default = [  ];
};
"extraVolumes" = mkOption {
  description = "Optionally specify extra list of additional volumes for the Client pod(s)";
  type = (types.listOf types.anything);
  default = [  ];
};
"hostAliases" = mkOption {
  description = "client pods host aliases";
  type = (types.listOf types.anything);
  default = [  ];
};
"initContainers" = mkOption {
  description = "Add additional init containers to the Client pod(s)";
  type = (types.listOf types.anything);
  default = [  ];
};
"labels" = mkOption {
  description = "Extra labels for the client deployment";
  type = (types.attrsOf types.anything);
  default = {  };
};
"lifecycleHooks" = mkOption {
  description = "for the client container(s) to automate configuration before or after startup";
  type = (types.attrsOf types.anything);
  default = {  };
};
"livenessProbe" = mkOption {
  type = ClientLivenessProbeModule;
  default = {  };
};
"networkPolicy" = mkOption {
  type = ClientNetworkPolicyModule;
  default = {  };
};
"nodeAffinityPreset" = mkOption {
  type = ClientNodeAffinityPresetModule;
  default = {  };
};
"nodeSelector" = mkOption {
  description = "Node labels for Client pods assignment";
  type = (types.attrsOf types.anything);
  default = {  };
};
"persistence" = mkOption {
  type = ClientPersistenceModule;
  default = {  };
};
"podAffinityPreset" = mkOption {
  description = "Pod affinity preset. Ignored if `client.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "";
};
"podAnnotations" = mkOption {
  description = "Annotations for client pods";
  type = (types.attrsOf types.anything);
  default = {  };
};
"podAntiAffinityPreset" = mkOption {
  description = "Pod anti-affinity preset. Ignored if `client.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "soft";
};
"podLabels" = mkOption {
  description = "Extra labels for client pods";
  type = (types.attrsOf types.anything);
  default = {  };
};
"podSecurityContext" = mkOption {
  type = ClientPodSecurityContextModule;
  default = {  };
};
"priorityClassName" = mkOption {
  description = "Client pods' priorityClassName";
  type = (types.nullOr types.str);
  default = "";
};
"readinessProbe" = mkOption {
  type = ClientReadinessProbeModule;
  default = {  };
};
"resources" = mkOption {
  type = ClientResourcesModule;
  default = {  };
};
"runtimeClassName" = mkOption {
  description = "Name of the runtime class to be used by pod(s)";
  type = (types.nullOr types.str);
  default = "";
};
"schedulerName" = mkOption {
  description = "Kubernetes pod scheduler registry";
  type = (types.nullOr types.str);
  default = "";
};
"serviceAccount" = mkOption {
  type = ClientServiceAccountModule;
  default = {  };
};
"sidecars" = mkOption {
  description = "Add additional sidecar containers to the Client pod(s)";
  type = (types.listOf types.anything);
  default = [  ];
};
"startupProbe" = mkOption {
  type = ClientStartupProbeModule;
  default = {  };
};
"terminationGracePeriodSeconds" = mkOption {
  description = "Client termination grace period (in seconds)";
  type = (types.nullOr types.str);
  default = "";
};
"tolerations" = mkOption {
  description = "Tolerations for Client pods assignment";
  type = (types.listOf types.anything);
  default = [  ];
};
"topologySpreadConstraints" = mkOption {
  description = "Topology Spread Constraints for pod assignment spread across your cluster among failure-domains";
  type = (types.listOf types.anything);
  default = [  ];
};
"updateStrategy" = mkOption {
  type = ClientUpdateStrategyModule;
  default = {  };
};
"useJob" = mkOption {
  description = "Deploy as job";
  type = types.bool;
  default = false;
};
  };
};
ClientNetworkPolicyModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable creation of NetworkPolicy resources";
  type = types.bool;
  default = false;
};
"extraEgress" = mkOption {
  description = "Add extra ingress rules to the NetworkPolicy";
  type = (types.listOf types.anything);
  default = [  ];
};
"extraIngress" = mkOption {
  description = "Add extra ingress rules to the NetworkPolicy";
  type = (types.listOf types.anything);
  default = [  ];
};
  };
};
ClientNodeAffinityPresetModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "key" = mkOption {
  description = "Node label key to match. Ignored if `client.affinity` is set";
  type = (types.nullOr types.str);
  default = "";
};
"type" = mkOption {
  description = "Node affinity preset type. Ignored if `client.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "";
};
"values" = mkOption {
  description = "Node label values to match. Ignored if `client.affinity` is set";
  type = (types.listOf types.anything);
  default = [  ];
};
  };
};
ClientPersistenceModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "accessModes" = mkOption {
  description = "Persistent Volume Access Mode";
  type = (types.listOf types.str);
  default = [ "ReadWriteOnce" ];
};
"annotations" = mkOption {
  description = "Persistent Volume annotations";
  type = (types.attrsOf types.anything);
  default = {  };
};
"dataSource" = mkOption {
  description = "Custom PVC data source";
  type = (types.attrsOf types.anything);
  default = {  };
};
"enabled" = mkOption {
  description = "Use a PVC to persist data";
  type = types.bool;
  default = false;
};
"existingClaim" = mkOption {
  description = "Use a existing PVC which must be created manually before bound";
  type = (types.nullOr types.str);
  default = "";
};
"labels" = mkOption {
  description = "Persistent Volume labels";
  type = (types.attrsOf types.anything);
  default = {  };
};
"mountPath" = mkOption {
  description = "Path to mount the volume at";
  type = (types.nullOr types.str);
  default = "/bitnami/deepspeed/data";
};
"selector" = mkOption {
  description = "Selector to match an existing Persistent Volume for the client data PVC";
  type = (types.attrsOf types.anything);
  default = {  };
};
"size" = mkOption {
  description = "Size of data volume";
  type = (types.nullOr types.str);
  default = "8Gi";
};
"storageClass" = mkOption {
  description = "discourse & sidekiq data Persistent Volume Storage Class";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
ClientPodSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enabled Client pods' Security Context";
  type = types.bool;
  default = true;
};
"fsGroup" = mkOption {
  description = "Set Client pod's Security Context fsGroup";
  type = (types.nullOr types.int);
  default = 1001;
};
"seccompProfile" = mkOption {
  type = ClientPodSecurityContextSeccompProfileModule;
  default = {  };
};
  };
};
ClientPodSecurityContextSeccompProfileModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "type" = mkOption {
  description = "Set Client container's Security Context seccomp profile";
  type = (types.nullOr types.str);
  default = "RuntimeDefault";
};
  };
};
ClientReadinessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable readinessProbe on Client nodes";
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
  default = 5;
};
"periodSeconds" = mkOption {
  description = "Period seconds for readinessProbe";
  type = (types.nullOr types.int);
  default = 30;
};
"successThreshold" = mkOption {
  description = "Success threshold for readinessProbe";
  type = (types.nullOr types.int);
  default = 1;
};
"timeoutSeconds" = mkOption {
  description = "Timeout seconds for readinessProbe";
  type = (types.nullOr types.int);
  default = 20;
};
  };
};
ClientResourcesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "limits" = mkOption {
  description = "The resources limits for the client containers";
  type = (types.attrsOf types.anything);
  default = {  };
};
"requests" = mkOption {
  description = "The requested resources for the client containers";
  type = (types.attrsOf types.anything);
  default = {  };
};
  };
};
ClientServiceAccountModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Additional custom annotations for the ServiceAccount";
  type = (types.attrsOf types.anything);
  default = {  };
};
"automountServiceAccountToken" = mkOption {
  description = "Allows auto mount of ServiceAccountToken on the serviceAccount created";
  type = types.bool;
  default = false;
};
"create" = mkOption {
  description = "Enable creation of ServiceAccount for Client pods";
  type = types.bool;
  default = false;
};
"name" = mkOption {
  description = "The name of the ServiceAccount to use";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
ClientStartupProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable startupProbe on Client containers";
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
  default = 5;
};
"periodSeconds" = mkOption {
  description = "Period seconds for startupProbe";
  type = (types.nullOr types.int);
  default = 30;
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
ClientUpdateStrategyModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "rollingUpdate" = mkOption {
  description = "Client statefulset rolling update configuration parameters";
  type = (types.attrsOf types.anything);
  default = {  };
};
"type" = mkOption {
  description = "Client statefulset strategy type";
  type = (types.nullOr types.str);
  default = "RollingUpdate";
};
  };
};
ConfigModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "defaultHostFile" = mkOption {
  description = "Host file generated by default (only edit if you know what you are doing)";
  type = (types.nullOr types.str);
  default = "";
};
"defaultSSHClient" = mkOption {
  description = "Default SSH client configuration for the client node (only edit if you know what you are doing)";
  type = (types.nullOr types.str);
  default = "";
};
"defaultSSHServer" = mkOption {
  description = "Default SSH Server configuration for the worker nodes (only edit if you know what you are doing)";
  type = (types.nullOr types.str);
  default = "";
};
"existingHostFileConfigMap" = mkOption {
  description = "Name of a ConfigMap containing the hostfile";
  type = (types.nullOr types.str);
  default = "";
};
"existingSSHClientConfigMap" = mkOption {
  description = "Name of a ConfigMap containing the SSH client configuration";
  type = (types.nullOr types.str);
  default = "";
};
"existingSSHKeySecret" = mkOption {
  description = "Name of a secret containing the ssh private key";
  type = (types.nullOr types.str);
  default = "";
};
"existingSSHServerConfigMap" = mkOption {
  description = "Name of a ConfigMap with with the SSH Server configuration";
  type = (types.nullOr types.str);
  default = "";
};
"overrideHostFile" = mkOption {
  description = "Override default host file with the content in this value";
  type = (types.nullOr types.str);
  default = "";
};
"overrideSSHClient" = mkOption {
  description = "Override default SSH cliient configuration with the content in this value";
  type = (types.nullOr types.str);
  default = "";
};
"overrideSSHServer" = mkOption {
  description = "Overidde SSH Server configuration with the content in this value";
  type = (types.nullOr types.str);
  default = "";
};
"sshPrivateKey" = mkOption {
  description = "Private key for the client node to connect to the worker nodes";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
DiagnosticModeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "args" = mkOption {
  description = "Args to override all containers in the deployments/statefulsets";
  type = (types.listOf types.str);
  default = [ "infinity" ];
};
"command" = mkOption {
  description = "Command to override all containers in the deployments/statefulsets";
  type = (types.listOf types.str);
  default = [ "sleep" ];
};
"enabled" = mkOption {
  description = "Enable diagnostic mode (all probes will be disabled and the command will be overridden)";
  type = types.bool;
  default = false;
};
  };
};
GitImageModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "digest" = mkOption {
  description = "Git image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag";
  type = (types.nullOr types.str);
  default = "";
};
"pullPolicy" = mkOption {
  description = "Git image pull policy";
  type = (types.nullOr types.str);
  default = "IfNotPresent";
};
"pullSecrets" = mkOption {
  description = "Specify docker-registry secret names as an array";
  type = (types.listOf types.anything);
  default = [  ];
};
"registry" = mkOption {
  description = "Git image registry";
  type = (types.nullOr types.str);
  default = "docker.io";
};
"repository" = mkOption {
  description = "Git image repository";
  type = (types.nullOr types.str);
  default = "bitnami/git";
};
"tag" = mkOption {
  description = "Git image tag (immutable tags are recommended)";
  type = (types.nullOr types.str);
  default = "2.41.0-debian-11-r16";
};
  };
};
GlobalModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
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
"storageClass" = mkOption {
  description = "Global StorageClass for Persistent Volume(s)";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
ImageModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "digest" = mkOption {
  description = "Deepspeed image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag";
  type = (types.nullOr types.str);
  default = "";
};
"pullPolicy" = mkOption {
  description = "Deepspeed image pull policy";
  type = (types.nullOr types.str);
  default = "IfNotPresent";
};
"pullSecrets" = mkOption {
  description = "Specify docker-registry secret names as an array";
  type = (types.listOf types.anything);
  default = [  ];
};
"registry" = mkOption {
  description = "Deepspeed image registry";
  type = (types.nullOr types.str);
  default = "docker.io";
};
"repository" = mkOption {
  description = "Deepspeed image repository";
  type = (types.nullOr types.str);
  default = "bitnami/deepspeed";
};
"tag" = mkOption {
  description = "Deepspeed image tag (immutable tags are recommended)";
  type = (types.nullOr types.str);
  default = "0.10.0-debian-11-r17";
};
  };
};
SourceGitModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "extraVolumeMounts" = mkOption {
  description = "Add extra volume mounts for the Git container";
  type = (types.listOf types.anything);
  default = [  ];
};
"repository" = mkOption {
  description = "Repository that holds the files";
  type = (types.nullOr types.str);
  default = "";
};
"revision" = mkOption {
  description = "Revision from the repository to checkout";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
SourceModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "configMap" = mkOption {
  description = "List of files of the project";
  type = (types.attrsOf types.anything);
  default = {  };
};
"existingConfigMap" = mkOption {
  description = "Name of a configmap containing the files of the project";
  type = (types.nullOr types.str);
  default = "";
};
"git" = mkOption {
  type = SourceGitModule;
  default = {  };
};
"launchCommand" = mkOption {
  description = "deepspeed command to run over the project";
  type = (types.nullOr types.str);
  default = "";
};
"type" = mkOption {
  description = "Where the source comes from: Possible values: configmap, git, custom";
  type = (types.nullOr types.str);
  default = "configmap";
};
  };
};
VolumePermissionsImageModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "digest" = mkOption {
  description = "Init container volume-permissions image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag";
  type = (types.nullOr types.str);
  default = "";
};
"pullPolicy" = mkOption {
  description = "Init container volume-permissions image pull policy";
  type = (types.nullOr types.str);
  default = "IfNotPresent";
};
"pullSecrets" = mkOption {
  description = "Specify docker-registry secret names as an array";
  type = (types.listOf types.anything);
  default = [  ];
};
"registry" = mkOption {
  description = "Init container volume-permissions image registry";
  type = (types.nullOr types.str);
  default = "docker.io";
};
"repository" = mkOption {
  description = "Init container volume-permissions image repository";
  type = (types.nullOr types.str);
  default = "bitnami/os-shell";
};
"tag" = mkOption {
  description = "Init container volume-permissions image tag (immutable tags are recommended)";
  type = (types.nullOr types.str);
  default = "11-debian-11-r16";
};
  };
};
VolumePermissionsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable init container that changes volume permissions in the data directory";
  type = types.bool;
  default = false;
};
"image" = mkOption {
  type = VolumePermissionsImageModule;
  default = {  };
};
"resources" = mkOption {
  type = VolumePermissionsResourcesModule;
  default = {  };
};
  };
};
VolumePermissionsResourcesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "limits" = mkOption {
  description = "The resources limits for the container";
  type = (types.attrsOf types.anything);
  default = {  };
};
"requests" = mkOption {
  description = "The requested resources for the container";
  type = (types.attrsOf types.anything);
  default = {  };
};
  };
};
WorkerContainerPortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "ssh" = mkOption {
  description = "SSH port for Worker";
  type = (types.nullOr types.int);
  default = 2222;
};
  };
};
WorkerContainerSecurityContextCapabilitiesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "drop" = mkOption {
  description = "Set Worker container's Security Context runAsNonRoot";
  type = (types.listOf types.str);
  default = [ "ALL" ];
};
  };
};
WorkerContainerSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "allowPrivilegeEscalation" = mkOption {
  description = "Set Worker container's privilege escalation";
  type = types.bool;
  default = false;
};
"capabilities" = mkOption {
  type = WorkerContainerSecurityContextCapabilitiesModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Enabled Worker containers' Security Context";
  type = types.bool;
  default = true;
};
"readOnlyRootFilesystem" = mkOption {
  description = "Set Worker containers' Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsGroup" = mkOption {
  description = "Set Worker containers' Security Context runAsGroup";
  type = (types.nullOr types.int);
  default = 1001;
};
"runAsNonRoot" = mkOption {
  description = "Set Worker containers' Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsUser" = mkOption {
  description = "Set Worker containers' Security Context runAsUser";
  type = (types.nullOr types.int);
  default = 1001;
};
  };
};
WorkerExternalAccessModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Create a service per worker node";
  type = types.bool;
  default = false;
};
"service" = mkOption {
  type = WorkerExternalAccessServiceModule;
  default = {  };
};
  };
};
WorkerExternalAccessServiceModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Additional custom annotations for Worker service";
  type = (types.attrsOf types.anything);
  default = {  };
};
"externalIPs" = mkOption {
  description = "Use distinct service host IPs to configure Kafka external listener when service type is NodePort. Length must be the same as replicaCount";
  type = (types.listOf types.anything);
  default = [  ];
};
"externalTrafficPolicy" = mkOption {
  description = "Worker service external traffic policy";
  type = (types.nullOr types.str);
  default = "Cluster";
};
"extraPorts" = mkOption {
  description = "Extra ports to expose in the Worker service";
  type = (types.listOf types.anything);
  default = [  ];
};
"labels" = mkOption {
  description = "Additional custom labels for Worker service";
  type = (types.attrsOf types.anything);
  default = {  };
};
"loadBalancerAnnotations" = mkOption {
  description = "Array of load balancer annotations for each Kafka broker. Length must be the same as replicaCount";
  type = (types.listOf types.anything);
  default = [  ];
};
"loadBalancerIPs" = mkOption {
  description = "Array of load balancer IPs for each Kafka broker. Length must be the same as replicaCount";
  type = (types.listOf types.anything);
  default = [  ];
};
"loadBalancerSourceRanges" = mkOption {
  description = "Worker service Load Balancer sources";
  type = (types.listOf types.anything);
  default = [  ];
};
"nodePorts" = mkOption {
  description = "Array of node ports used for each Kafka broker. Length must be the same as replicaCount";
  type = (types.listOf types.anything);
  default = [  ];
};
"ports" = mkOption {
  type = WorkerExternalAccessServicePortsModule;
  default = {  };
};
"publishNotReadyAddresses" = mkOption {
  description = "Indicates that any agent which deals with endpoints for this Service should disregard any indications of ready/not-ready";
  type = types.bool;
  default = false;
};
"sessionAffinity" = mkOption {
  description = "Control where client requests go, to the same pod or round-robin";
  type = (types.nullOr types.str);
  default = "None";
};
"sessionAffinityConfig" = mkOption {
  description = "Additional settings for the sessionAffinity";
  type = (types.attrsOf types.anything);
  default = {  };
};
"type" = mkOption {
  description = "Worker service type";
  type = (types.nullOr types.str);
  default = "ClusterIP";
};
  };
};
WorkerExternalAccessServicePortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "ssh" = mkOption {
  description = "Worker GRPC service port";
  type = (types.nullOr types.int);
  default = 22;
};
  };
};
WorkerLivenessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable livenessProbe on Worker nodes";
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
  default = 5;
};
"periodSeconds" = mkOption {
  description = "Period seconds for livenessProbe";
  type = (types.nullOr types.int);
  default = 30;
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
WorkerModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "affinity" = mkOption {
  description = "Affinity for Worker pods assignment";
  type = (types.attrsOf types.anything);
  default = {  };
};
"annotations" = mkOption {
  description = "Annotations for the worker deployment";
  type = (types.attrsOf types.anything);
  default = {  };
};
"args" = mkOption {
  description = "Override default container args (useful when using custom images)";
  type = (types.listOf types.anything);
  default = [  ];
};
"command" = mkOption {
  description = "Override default container command (useful when using custom images)";
  type = (types.listOf types.anything);
  default = [  ];
};
"containerPorts" = mkOption {
  type = WorkerContainerPortsModule;
  default = {  };
};
"containerSecurityContext" = mkOption {
  type = WorkerContainerSecurityContextModule;
  default = {  };
};
"customLivenessProbe" = mkOption {
  description = "Custom livenessProbe that overrides the default one";
  type = (types.attrsOf types.anything);
  default = {  };
};
"customReadinessProbe" = mkOption {
  description = "Custom readinessProbe that overrides the default one";
  type = (types.attrsOf types.anything);
  default = {  };
};
"customStartupProbe" = mkOption {
  description = "Custom startupProbe that overrides the default one";
  type = (types.attrsOf types.anything);
  default = {  };
};
"enableDefaultInitContainers" = mkOption {
  description = "Deploy default init containers";
  type = types.bool;
  default = true;
};
"enabled" = mkOption {
  description = "Enable Worker deployment";
  type = types.bool;
  default = true;
};
"externalAccess" = mkOption {
  type = WorkerExternalAccessModule;
  default = {  };
};
"extraEnvVars" = mkOption {
  description = "Array with extra environment variables to add to client nodes";
  type = (types.listOf types.anything);
  default = [  ];
};
"extraEnvVarsCM" = mkOption {
  description = "Name of existing ConfigMap containing extra env vars for client nodes";
  type = (types.nullOr types.str);
  default = "";
};
"extraEnvVarsSecret" = mkOption {
  description = "Name of existing Secret containing extra env vars for client nodes";
  type = (types.nullOr types.str);
  default = "";
};
"extraVolumeMounts" = mkOption {
  description = "Optionally specify extra list of additional volumeMounts for the Worker container(s)";
  type = (types.listOf types.anything);
  default = [  ];
};
"extraVolumes" = mkOption {
  description = "Optionally specify extra list of additional volumes for the Worker pod(s)";
  type = (types.listOf types.anything);
  default = [  ];
};
"headlessServiceAnnotations" = mkOption {
  description = "Annotations for the headless service";
  type = (types.attrsOf types.anything);
  default = {  };
};
"hostAliases" = mkOption {
  description = "client pods host aliases";
  type = (types.listOf types.anything);
  default = [  ];
};
"initContainers" = mkOption {
  description = "Add additional init containers to the Worker pod(s)";
  type = (types.listOf types.anything);
  default = [  ];
};
"labels" = mkOption {
  description = "Labels for the worker deployment";
  type = (types.attrsOf types.anything);
  default = {  };
};
"lifecycleHooks" = mkOption {
  description = "for the client container(s) to automate configuration before or after startup";
  type = (types.attrsOf types.anything);
  default = {  };
};
"livenessProbe" = mkOption {
  type = WorkerLivenessProbeModule;
  default = {  };
};
"networkPolicy" = mkOption {
  type = WorkerNetworkPolicyModule;
  default = {  };
};
"nodeAffinityPreset" = mkOption {
  type = WorkerNodeAffinityPresetModule;
  default = {  };
};
"nodeSelector" = mkOption {
  description = "Node labels for Worker pods assignment";
  type = (types.attrsOf types.anything);
  default = {  };
};
"persistence" = mkOption {
  type = WorkerPersistenceModule;
  default = {  };
};
"podAffinityPreset" = mkOption {
  description = "Pod affinity preset. Ignored if `client.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "";
};
"podAnnotations" = mkOption {
  description = "Annotations for client pods";
  type = (types.attrsOf types.anything);
  default = {  };
};
"podAntiAffinityPreset" = mkOption {
  description = "Pod anti-affinity preset. Ignored if `client.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "soft";
};
"podLabels" = mkOption {
  description = "Extra labels for client pods";
  type = (types.attrsOf types.anything);
  default = {  };
};
"podManagementPolicy" = mkOption {
  description = "Statefulset Pod management policy, it needs to be Parallel to be able to complete the cluster join";
  type = (types.nullOr types.str);
  default = "Parallel";
};
"podSecurityContext" = mkOption {
  type = WorkerPodSecurityContextModule;
  default = {  };
};
"priorityClassName" = mkOption {
  description = "Worker pods' priorityClassName";
  type = (types.nullOr types.str);
  default = "";
};
"readinessProbe" = mkOption {
  type = WorkerReadinessProbeModule;
  default = {  };
};
"replicaCount" = mkOption {
  description = "Number of Worker replicas to deploy";
  type = (types.nullOr types.int);
  default = 3;
};
"resources" = mkOption {
  type = WorkerResourcesModule;
  default = {  };
};
"runtimeClassName" = mkOption {
  description = "Name of the runtime class to be used by pod(s)";
  type = (types.nullOr types.str);
  default = "";
};
"schedulerName" = mkOption {
  description = "Kubernetes pod scheduler registry";
  type = (types.nullOr types.str);
  default = "";
};
"serviceAccount" = mkOption {
  type = WorkerServiceAccountModule;
  default = {  };
};
"sidecars" = mkOption {
  description = "Add additional sidecar containers to the Worker pod(s)";
  type = (types.listOf types.anything);
  default = [  ];
};
"slotsPerNode" = mkOption {
  description = "Number of slots available per worker node";
  type = (types.nullOr types.int);
  default = 1;
};
"startupProbe" = mkOption {
  type = WorkerStartupProbeModule;
  default = {  };
};
"terminationGracePeriodSeconds" = mkOption {
  description = "Worker termination grace period (in seconds)";
  type = (types.nullOr types.str);
  default = "";
};
"tolerations" = mkOption {
  description = "Tolerations for Worker pods assignment";
  type = (types.listOf types.anything);
  default = [  ];
};
"topologySpreadConstraints" = mkOption {
  description = "Topology Spread Constraints for pod assignment spread across your cluster among failure-domains";
  type = (types.listOf types.anything);
  default = [  ];
};
"updateStrategy" = mkOption {
  type = WorkerUpdateStrategyModule;
  default = {  };
};
  };
};
WorkerNetworkPolicyModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "allowExternal" = mkOption {
  description = "The Policy model to apply";
  type = types.bool;
  default = true;
};
"enabled" = mkOption {
  description = "Enable creation of NetworkPolicy resources";
  type = types.bool;
  default = false;
};
"extraEgress" = mkOption {
  description = "Add extra ingress rules to the NetworkPolicy";
  type = (types.listOf types.anything);
  default = [  ];
};
"extraIngress" = mkOption {
  description = "Add extra ingress rules to the NetworkPolicy";
  type = (types.listOf types.anything);
  default = [  ];
};
  };
};
WorkerNodeAffinityPresetModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "key" = mkOption {
  description = "Node label key to match. Ignored if `client.affinity` is set";
  type = (types.nullOr types.str);
  default = "";
};
"type" = mkOption {
  description = "Node affinity preset type. Ignored if `client.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "";
};
"values" = mkOption {
  description = "Node label values to match. Ignored if `client.affinity` is set";
  type = (types.listOf types.anything);
  default = [  ];
};
  };
};
WorkerPersistenceModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "accessModes" = mkOption {
  description = "Persistent Volume Access Mode";
  type = (types.listOf types.str);
  default = [ "ReadWriteOnce" ];
};
"annotations" = mkOption {
  description = "Persistent Volume annotations";
  type = (types.attrsOf types.anything);
  default = {  };
};
"dataSource" = mkOption {
  description = "Custom PVC data source";
  type = (types.attrsOf types.anything);
  default = {  };
};
"enabled" = mkOption {
  description = "Use a PVC to persist data";
  type = types.bool;
  default = false;
};
"existingClaim" = mkOption {
  description = "Use a existing PVC which must be created manually before bound";
  type = (types.nullOr types.str);
  default = "";
};
"labels" = mkOption {
  description = "Persistent Volume labels";
  type = (types.attrsOf types.anything);
  default = {  };
};
"mountPath" = mkOption {
  description = "Path to mount the volume at";
  type = (types.nullOr types.str);
  default = "/bitnami/deepspeed/data";
};
"selector" = mkOption {
  description = "Selector to match an existing Persistent Volume for the worker data PVC";
  type = (types.attrsOf types.anything);
  default = {  };
};
"size" = mkOption {
  description = "Size of data volume";
  type = (types.nullOr types.str);
  default = "8Gi";
};
"storageClass" = mkOption {
  description = "discourse & sidekiq data Persistent Volume Storage Class";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
WorkerPodSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enabled Worker pods' Security Context";
  type = types.bool;
  default = true;
};
"fsGroup" = mkOption {
  description = "Set Worker pod's Security Context fsGroup";
  type = (types.nullOr types.int);
  default = 1001;
};
"seccompProfile" = mkOption {
  type = WorkerPodSecurityContextSeccompProfileModule;
  default = {  };
};
  };
};
WorkerPodSecurityContextSeccompProfileModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "type" = mkOption {
  description = "Set Worker container's Security Context seccomp profile";
  type = (types.nullOr types.str);
  default = "RuntimeDefault";
};
  };
};
WorkerReadinessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable readinessProbe on Worker nodes";
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
  default = 5;
};
"periodSeconds" = mkOption {
  description = "Period seconds for readinessProbe";
  type = (types.nullOr types.int);
  default = 30;
};
"successThreshold" = mkOption {
  description = "Success threshold for readinessProbe";
  type = (types.nullOr types.int);
  default = 1;
};
"timeoutSeconds" = mkOption {
  description = "Timeout seconds for readinessProbe";
  type = (types.nullOr types.int);
  default = 5;
};
  };
};
WorkerResourcesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "limits" = mkOption {
  description = "The resources limits for the client containers";
  type = (types.attrsOf types.anything);
  default = {  };
};
"requests" = mkOption {
  description = "The requested resources for the client containers";
  type = (types.attrsOf types.anything);
  default = {  };
};
  };
};
WorkerServiceAccountModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Additional custom annotations for the ServiceAccount";
  type = (types.attrsOf types.anything);
  default = {  };
};
"automountServiceAccountToken" = mkOption {
  description = "Allows auto mount of ServiceAccountToken on the serviceAccount created";
  type = types.bool;
  default = false;
};
"create" = mkOption {
  description = "Enable creation of ServiceAccount for Data Coordinator pods";
  type = types.bool;
  default = false;
};
"name" = mkOption {
  description = "The name of the ServiceAccount to use";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
WorkerStartupProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable startupProbe on Worker containers";
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
  default = 5;
};
"periodSeconds" = mkOption {
  description = "Period seconds for startupProbe";
  type = (types.nullOr types.int);
  default = 30;
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
WorkerUpdateStrategyModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "rollingUpdate" = mkOption {
  description = "Worker statefulset rolling update configuration parameters";
  type = (types.attrsOf types.anything);
  default = {  };
};
"type" = mkOption {
  description = "Worker statefulset strategy type";
  type = (types.nullOr types.str);
  default = "RollingUpdate";
};
  };
};
in
{
  freeformType = types.attrsOf types.anything;
  options = {
    "client" = mkOption {
  type = ClientModule;
  default = {  };
};
"clusterDomain" = mkOption {
  description = "Kubernetes cluster domain name";
  type = (types.nullOr types.str);
  default = "cluster.local";
};
"commonAnnotations" = mkOption {
  description = "Annotations to add to all deployed objects";
  type = (types.attrsOf types.anything);
  default = {  };
};
"commonLabels" = mkOption {
  description = "Labels to add to all deployed objects";
  type = (types.attrsOf types.anything);
  default = {  };
};
"config" = mkOption {
  type = ConfigModule;
  default = {  };
};
"diagnosticMode" = mkOption {
  type = DiagnosticModeModule;
  default = {  };
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
"gitImage" = mkOption {
  type = GitImageModule;
  default = {  };
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
"nameOverride" = mkOption {
  description = "String to partially override common.names.fullname";
  type = (types.nullOr types.str);
  default = "";
};
"source" = mkOption {
  type = SourceModule;
  default = {  };
};
"volumePermissions" = mkOption {
  type = VolumePermissionsModule;
  default = {  };
};
"worker" = mkOption {
  type = WorkerModule;
  default = {  };
};
  };
}
