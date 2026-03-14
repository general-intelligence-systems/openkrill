# Auto-generated from Bitnami values.schema.json
# Do not edit — regenerate with bin/create-module-bitnami
{ lib, ... }:
with lib;
let
  DiagnosticModeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "args" = mkOption {
  description = "Args to override all containers in the deployment";
  type = (types.listOf types.str);
  default = [ "infinity" ];
};
"command" = mkOption {
  description = "Command to override all containers in the deployment";
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
ExternalDatabaseModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "authDatabase" = mkOption {
  description = "Database name for the auth module (only if tracking.auth.enabled=true)";
  type = (types.nullOr types.str);
  default = "mlflow_auth";
};
"database" = mkOption {
  description = "Database name";
  type = (types.nullOr types.str);
  default = "mlflow";
};
"dialectDriver" = mkOption {
  description = "Database dialect(+driver)";
  type = (types.nullOr types.str);
  default = "postgresql";
};
"existingSecret" = mkOption {
  description = "Name of an existing secret resource containing the database credentials";
  type = (types.nullOr types.str);
  default = "";
};
"existingSecretPasswordKey" = mkOption {
  description = "Name of an existing secret key containing the database credentials";
  type = (types.nullOr types.str);
  default = "db-password";
};
"host" = mkOption {
  description = "Database host";
  type = (types.nullOr types.str);
  default = "";
};
"password" = mkOption {
  description = "Password for the non-root username";
  type = (types.nullOr types.str);
  default = "";
};
"port" = mkOption {
  description = "Database port number";
  type = (types.nullOr types.int);
  default = 5432;
};
"user" = mkOption {
  description = "Non-root username";
  type = (types.nullOr types.str);
  default = "postgres";
};
  };
};
ExternalS3Module = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "accessKeyID" = mkOption {
  description = "External S3 access key ID";
  type = (types.nullOr types.str);
  default = "";
};
"accessKeySecret" = mkOption {
  description = "External S3 access key secret";
  type = (types.nullOr types.str);
  default = "";
};
"bucket" = mkOption {
  description = "External S3 bucket";
  type = (types.nullOr types.str);
  default = "mlflow";
};
"existingSecret" = mkOption {
  description = "Name of an existing secret resource containing the S3 credentials";
  type = (types.nullOr types.str);
  default = "";
};
"existingSecretAccessKeyIDKey" = mkOption {
  description = "Name of an existing secret key containing the S3 access key ID";
  type = (types.nullOr types.str);
  default = "root-user";
};
"existingSecretKeySecretKey" = mkOption {
  description = "Name of an existing secret key containing the S3 access key secret";
  type = (types.nullOr types.str);
  default = "root-password";
};
"host" = mkOption {
  description = "External S3 host";
  type = (types.nullOr types.str);
  default = "";
};
"port" = mkOption {
  description = "External S3 port number";
  type = (types.nullOr types.int);
  default = 443;
};
"protocol" = mkOption {
  description = "External S3 protocol";
  type = (types.nullOr types.str);
  default = "https";
};
"serveArtifacts" = mkOption {
  description = "Whether artifact serving is enabled";
  type = types.bool;
  default = true;
};
"useCredentialsInSecret" = mkOption {
  description = "Whether to use a secret to store the S3 credentials";
  type = types.bool;
  default = true;
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
  default = "REGISTRY_NAME";
};
"repository" = mkOption {
  description = "Git image repository";
  type = (types.nullOr types.str);
  default = "REPOSITORY_NAME/git";
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
    "debug" = mkOption {
  description = "Enable mlflow image debug mode";
  type = types.bool;
  default = false;
};
"digest" = mkOption {
  description = "mlflow image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag image tag (immutable tags are recommended)";
  type = (types.nullOr types.str);
  default = "";
};
"pullPolicy" = mkOption {
  description = "mlflow image pull policy";
  type = (types.nullOr types.str);
  default = "IfNotPresent";
};
"pullSecrets" = mkOption {
  description = "mlflow image pull secrets";
  type = (types.listOf types.anything);
  default = [  ];
};
"registry" = mkOption {
  description = "mlflow image registry";
  type = (types.nullOr types.str);
  default = "REGISTRY_NAME";
};
"repository" = mkOption {
  description = "mlflow image repository";
  type = (types.nullOr types.str);
  default = "REPOSITORY_NAME/mlflow";
};
  };
};
MinioAuthModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "existingSecret" = mkOption {
  description = "Name of an existing secret containing the MinIO&reg; credentials";
  type = (types.nullOr types.str);
  default = "";
};
"rootPassword" = mkOption {
  description = "Password for MinIO&reg; root user";
  type = (types.nullOr types.str);
  default = "";
};
"rootUser" = mkOption {
  description = "MinIO&reg; root username";
  type = (types.nullOr types.str);
  default = "admin";
};
  };
};
MinioModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "auth" = mkOption {
  type = MinioAuthModule;
  default = {  };
};
"defaultBuckets" = mkOption {
  description = "Comma, semi-colon or space separated list of MinIO&reg; buckets to create";
  type = (types.nullOr types.str);
  default = "mlflow";
};
"enabled" = mkOption {
  description = "Enable/disable MinIO&reg; chart installation";
  type = types.bool;
  default = true;
};
"provisioning" = mkOption {
  type = MinioProvisioningModule;
  default = {  };
};
"service" = mkOption {
  type = MinioServiceModule;
  default = {  };
};
"tls" = mkOption {
  type = MinioTlsModule;
  default = {  };
};
  };
};
MinioProvisioningModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable/disable MinIO&reg; provisioning job";
  type = types.bool;
  default = true;
};
"extraCommands" = mkOption {
  description = "Extra commands to run on MinIO&reg; provisioning job";
  type = (types.listOf types.str);
  default = [ "mc anonymous set download provisioning/mlflow" ];
};
  };
};
MinioServiceModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "loadBalancerIP" = mkOption {
  description = "MinIO&reg; service LoadBalancer IP";
  type = (types.nullOr types.str);
  default = "";
};
"ports" = mkOption {
  type = MinioServicePortsModule;
  default = {  };
};
"type" = mkOption {
  description = "MinIO&reg; service type";
  type = (types.nullOr types.str);
  default = "ClusterIP";
};
  };
};
MinioServicePortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "api" = mkOption {
  description = "MinIO&reg; service port";
  type = (types.nullOr types.int);
  default = 80;
};
  };
};
MinioTlsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable/disable MinIO&reg; TLS support";
  type = types.bool;
  default = false;
};
  };
};
PostgresqlAuthModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "database" = mkOption {
  description = "Name for a custom database to create";
  type = (types.nullOr types.str);
  default = "bitnami_mlflow";
};
"existingSecret" = mkOption {
  description = "Name of existing secret to use for PostgreSQL credentials";
  type = (types.nullOr types.str);
  default = "";
};
"password" = mkOption {
  description = "Password for the custom user to create";
  type = (types.nullOr types.str);
  default = "";
};
"username" = mkOption {
  description = "Name for a custom user to create";
  type = (types.nullOr types.str);
  default = "bn_mlflow";
};
  };
};
PostgresqlModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "architecture" = mkOption {
  description = "PostgreSQL architecture (`standalone` or `replication`)";
  type = (types.nullOr types.str);
  default = "standalone";
};
"auth" = mkOption {
  type = PostgresqlAuthModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Switch to enable or disable the PostgreSQL helm chart";
  type = types.bool;
  default = true;
};
"primary" = mkOption {
  type = PostgresqlPrimaryModule;
  default = {  };
};
  };
};
PostgresqlPrimaryModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "service" = mkOption {
  type = PostgresqlPrimaryServiceModule;
  default = {  };
};
  };
};
PostgresqlPrimaryServiceModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "ports" = mkOption {
  type = PostgresqlPrimaryServicePortsModule;
  default = {  };
};
  };
};
PostgresqlPrimaryServicePortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "postgresql" = mkOption {
  description = "PostgreSQL service port";
  type = (types.nullOr types.int);
  default = 5432;
};
  };
};
RunContainerSecurityContextCapabilitiesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "drop" = mkOption {
  description = "Set Run container's Security Context runAsNonRoot";
  type = (types.listOf types.str);
  default = [ "ALL" ];
};
  };
};
RunContainerSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "allowPrivilegeEscalation" = mkOption {
  description = "Set Run container's privilege escalation";
  type = types.bool;
  default = false;
};
"capabilities" = mkOption {
  type = RunContainerSecurityContextCapabilitiesModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Enabled Run containers' Security Context";
  type = types.bool;
  default = true;
};
"privileged" = mkOption {
  description = "Set Run containers' Security Context privileged";
  type = types.bool;
  default = false;
};
"readOnlyRootFilesystem" = mkOption {
  description = "Set Run containers' Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsGroup" = mkOption {
  description = "Set Run containers' Security Context runAsGroup";
  type = (types.nullOr types.int);
  default = 1001;
};
"runAsNonRoot" = mkOption {
  description = "Set Run containers' Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsUser" = mkOption {
  description = "Set Run containers' Security Context runAsUser";
  type = (types.nullOr types.int);
  default = 1001;
};
"seccompProfile" = mkOption {
  type = RunContainerSecurityContextSeccompProfileModule;
  default = {  };
};
  };
};
RunContainerSecurityContextSeccompProfileModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "type" = mkOption {
  description = "Set Run container's Security Context seccomp profile";
  type = (types.nullOr types.str);
  default = "RuntimeDefault";
};
  };
};
RunLivenessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable livenessProbe on Run nodes";
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
RunModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "affinity" = mkOption {
  description = "Affinity for Run pods assignment";
  type = (types.attrsOf types.anything);
  default = {  };
};
"annotations" = mkOption {
  description = "Annotations for the run deployment";
  type = (types.attrsOf types.anything);
  default = {  };
};
"args" = mkOption {
  description = "Override default container args (useful when using custom images)";
  type = (types.listOf types.anything);
  default = [  ];
};
"automountServiceAccountToken" = mkOption {
  description = "Mount Service Account token in pod";
  type = types.bool;
  default = false;
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
  type = RunContainerSecurityContextModule;
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
  description = "Enable Run deployment";
  type = types.bool;
  default = true;
};
"extraEnvVars" = mkOption {
  description = "Array with extra environment variables to add to run nodes";
  type = (types.listOf types.anything);
  default = [  ];
};
"extraEnvVarsCM" = mkOption {
  description = "Name of existing ConfigMap containing extra env vars for run nodes";
  type = (types.nullOr types.str);
  default = "";
};
"extraEnvVarsSecret" = mkOption {
  description = "Name of existing Secret containing extra env vars for run nodes";
  type = (types.nullOr types.str);
  default = "";
};
"extraVolumeMounts" = mkOption {
  description = "Optionally specify extra list of additional volumeMounts for the Run container(s)";
  type = (types.listOf types.anything);
  default = [  ];
};
"extraVolumes" = mkOption {
  description = "Optionally specify extra list of additional volumes for the Run pod(s)";
  type = (types.listOf types.anything);
  default = [  ];
};
"hostAliases" = mkOption {
  description = "run pods host aliases";
  type = (types.listOf types.anything);
  default = [  ];
};
"initContainers" = mkOption {
  description = "Add additional init containers to the Run pod(s)";
  type = (types.listOf types.anything);
  default = [  ];
};
"labels" = mkOption {
  description = "Extra labels for the run deployment";
  type = (types.attrsOf types.anything);
  default = {  };
};
"lifecycleHooks" = mkOption {
  description = "for the run container(s) to automate configuration before or after startup";
  type = (types.attrsOf types.anything);
  default = {  };
};
"livenessProbe" = mkOption {
  type = RunLivenessProbeModule;
  default = {  };
};
"networkPolicy" = mkOption {
  type = RunNetworkPolicyModule;
  default = {  };
};
"nodeAffinityPreset" = mkOption {
  type = RunNodeAffinityPresetModule;
  default = {  };
};
"nodeSelector" = mkOption {
  description = "Node labels for Run pods assignment";
  type = (types.attrsOf types.anything);
  default = {  };
};
"persistence" = mkOption {
  type = RunPersistenceModule;
  default = {  };
};
"podAffinityPreset" = mkOption {
  description = "Pod affinity preset. Ignored if `run.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "";
};
"podAnnotations" = mkOption {
  description = "Annotations for run pods";
  type = (types.attrsOf types.anything);
  default = {  };
};
"podAntiAffinityPreset" = mkOption {
  description = "Pod anti-affinity preset. Ignored if `run.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "soft";
};
"podLabels" = mkOption {
  description = "Extra labels for run pods";
  type = (types.attrsOf types.anything);
  default = {  };
};
"podSecurityContext" = mkOption {
  type = RunPodSecurityContextModule;
  default = {  };
};
"priorityClassName" = mkOption {
  description = "Run pods' priorityClassName";
  type = (types.nullOr types.str);
  default = "";
};
"readinessProbe" = mkOption {
  type = RunReadinessProbeModule;
  default = {  };
};
"resources" = mkOption {
  type = RunResourcesModule;
  default = {  };
};
"restartPolicy" = mkOption {
  description = "set restart policy of the job";
  type = (types.nullOr types.str);
  default = "OnFailure";
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
  type = RunServiceAccountModule;
  default = {  };
};
"sidecars" = mkOption {
  description = "Add additional sidecar containers to the Run pod(s)";
  type = (types.listOf types.anything);
  default = [  ];
};
"source" = mkOption {
  type = RunSourceModule;
  default = {  };
};
"startupProbe" = mkOption {
  type = RunStartupProbeModule;
  default = {  };
};
"terminationGracePeriodSeconds" = mkOption {
  description = "Run termination grace period (in seconds)";
  type = (types.nullOr types.str);
  default = "";
};
"tolerations" = mkOption {
  description = "Tolerations for Run pods assignment";
  type = (types.listOf types.anything);
  default = [  ];
};
"topologySpreadConstraints" = mkOption {
  description = "Topology Spread Constraints for pod assignment spread across your cluster among failure-domains";
  type = (types.listOf types.anything);
  default = [  ];
};
"updateStrategy" = mkOption {
  type = RunUpdateStrategyModule;
  default = {  };
};
"useJob" = mkOption {
  description = "Deploy as job";
  type = types.bool;
  default = false;
};
  };
};
RunNetworkPolicyModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "allowExternal" = mkOption {
  description = "The Policy model to apply";
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
  description = "Add extra ingress rules to the NetworkPolicy";
  type = (types.listOf types.anything);
  default = "[]";
};
"extraIngress" = mkOption {
  description = "Add extra ingress rules to the NetworkPolicy";
  type = (types.listOf types.anything);
  default = "[]";
};
  };
};
RunNodeAffinityPresetModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "key" = mkOption {
  description = "Node label key to match. Ignored if `run.affinity` is set";
  type = (types.nullOr types.str);
  default = "";
};
"type" = mkOption {
  description = "Node affinity preset type. Ignored if `run.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "";
};
"values" = mkOption {
  description = "Node label values to match. Ignored if `run.affinity` is set";
  type = (types.listOf types.anything);
  default = [  ];
};
  };
};
RunPersistenceModule = types.submodule {
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
  default = "/bitnami/mlflow/data";
};
"selector" = mkOption {
  description = "Selector to match an existing Persistent Volume for the run data PVC";
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
"subPath" = mkOption {
  description = "subPath to use for mounting the volume";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
RunPodSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enabled Run pods' Security Context";
  type = types.bool;
  default = true;
};
"fsGroup" = mkOption {
  description = "Set Run pod's Security Context fsGroup";
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
RunReadinessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable readinessProbe on Run nodes";
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
RunResourcesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "limits" = mkOption {
  description = "The resources limits for the run containers";
  type = (types.attrsOf types.anything);
  default = {  };
};
"requests" = mkOption {
  description = "The requested resources for the run containers";
  type = (types.attrsOf types.anything);
  default = {  };
};
  };
};
RunServiceAccountModule = types.submodule {
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
  description = "Enable creation of ServiceAccount for Run pods";
  type = types.bool;
  default = true;
};
"name" = mkOption {
  description = "The name of the ServiceAccount to use";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
RunSourceGitModule = types.submodule {
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
RunSourceModule = types.submodule {
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
  type = RunSourceGitModule;
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
RunStartupProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable startupProbe on Run containers";
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
RunUpdateStrategyModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "rollingUpdate" = mkOption {
  description = "Run statefulset rolling update configuration parameters";
  type = (types.attrsOf types.anything);
  default = {  };
};
"type" = mkOption {
  description = "Run statefulset strategy type";
  type = (types.nullOr types.str);
  default = "RollingUpdate";
};
  };
};
TrackingAuthModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable basic authentication";
  type = types.bool;
  default = true;
};
"existingSecret" = mkOption {
  description = "Name of a secret containing the admin password";
  type = (types.nullOr types.str);
  default = "";
};
"existingSecretPasswordKey" = mkOption {
  description = "Key inside the secret containing the admin password";
  type = (types.nullOr types.str);
  default = "";
};
"existingSecretUserKey" = mkOption {
  description = "Key inside the secret containing the admin password";
  type = (types.nullOr types.str);
  default = "";
};
"extraOverrides" = mkOption {
  description = "Add extra settings to the basic_auth.ini file";
  type = (types.attrsOf types.anything);
  default = {  };
};
"overridesConfigMap" = mkOption {
  description = "Name of a ConfigMap containing overrides to the basic_auth.ini file";
  type = (types.nullOr types.str);
  default = "";
};
"password" = mkOption {
  description = "Admin password";
  type = (types.nullOr types.str);
  default = "";
};
"username" = mkOption {
  description = "Admin username";
  type = (types.nullOr types.str);
  default = "user";
};
  };
};
TrackingAutoscalingHpaModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable HPA";
  type = types.bool;
  default = false;
};
"maxReplicas" = mkOption {
  description = "Maximum number of replicas";
  type = (types.nullOr types.str);
  default = "";
};
"minReplicas" = mkOption {
  description = "Minimum number of replicas";
  type = (types.nullOr types.str);
  default = "";
};
"targetCPU" = mkOption {
  description = "Target CPU utilization percentage";
  type = (types.nullOr types.str);
  default = "";
};
"targetMemory" = mkOption {
  description = "Target Memory utilization percentage";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
TrackingAutoscalingModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "hpa" = mkOption {
  type = TrackingAutoscalingHpaModule;
  default = {  };
};
"vpa" = mkOption {
  type = TrackingAutoscalingVpaModule;
  default = {  };
};
  };
};
TrackingAutoscalingVpaModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Annotations for VPA resource";
  type = (types.attrsOf types.anything);
  default = {  };
};
"controlledResources" = mkOption {
  description = "VPA List of resources that the vertical pod autoscaler can control. Defaults to cpu and memory";
  type = (types.listOf types.anything);
  default = [  ];
};
"enabled" = mkOption {
  description = "Enable VPA";
  type = types.bool;
  default = false;
};
"maxAllowed" = mkOption {
  description = "VPA Max allowed resources for the pod";
  type = (types.attrsOf types.anything);
  default = {  };
};
"minAllowed" = mkOption {
  description = "VPA Min allowed resources for the pod";
  type = (types.attrsOf types.anything);
  default = {  };
};
"updatePolicy" = mkOption {
  type = TrackingAutoscalingVpaUpdatePolicyModule;
  default = {  };
};
  };
};
TrackingAutoscalingVpaUpdatePolicyModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "updateMode" = mkOption {
  description = "Autoscaling update policy Specifies whether recommended updates are applied when a Pod is started and whether recommended updates are applied during the life of a Pod";
  type = (types.nullOr types.str);
  default = "Auto";
};
  };
};
TrackingContainerPortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "http" = mkOption {
  description = "mlflow HTTP container port";
  type = (types.nullOr types.int);
  default = 5000;
};
  };
};
TrackingContainerSecurityContextCapabilitiesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "drop" = mkOption {
  description = "Set container's Security Context runAsNonRoot";
  type = (types.listOf types.str);
  default = [ "ALL" ];
};
  };
};
TrackingContainerSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "allowPrivilegeEscalation" = mkOption {
  description = "Set container's privilege escalation";
  type = types.bool;
  default = false;
};
"capabilities" = mkOption {
  type = TrackingContainerSecurityContextCapabilitiesModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Enabled containers' Security Context";
  type = types.bool;
  default = true;
};
"privileged" = mkOption {
  description = "Set containers' Security Context privileged";
  type = types.bool;
  default = false;
};
"readOnlyRootFilesystem" = mkOption {
  description = "Set containers' Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsGroup" = mkOption {
  description = "Set containers' Security Context runAsGroup";
  type = (types.nullOr types.int);
  default = 1001;
};
"runAsNonRoot" = mkOption {
  description = "Set containers' Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsUser" = mkOption {
  description = "Set containers' Security Context runAsUser";
  type = (types.nullOr types.int);
  default = 1001;
};
"seccompProfile" = mkOption {
  type = TrackingContainerSecurityContextSeccompProfileModule;
  default = {  };
};
  };
};
TrackingContainerSecurityContextSeccompProfileModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "type" = mkOption {
  description = "Set container's Security Context seccomp profile";
  type = (types.nullOr types.str);
  default = "RuntimeDefault";
};
  };
};
TrackingIngressModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations.";
  type = (types.attrsOf types.anything);
  default = {  };
};
"enabled" = mkOption {
  description = "Enable ingress record generation for mlflow";
  type = types.bool;
  default = false;
};
"extraHosts" = mkOption {
  description = "An array with additional hostname(s) to be covered with the ingress record";
  type = (types.listOf types.anything);
  default = [  ];
};
"extraPaths" = mkOption {
  description = "An array with additional arbitrary paths that may need to be added to the ingress under the main host";
  type = (types.listOf types.anything);
  default = [  ];
};
"extraRules" = mkOption {
  description = "Additional rules to be covered with this ingress record";
  type = (types.listOf types.anything);
  default = [  ];
};
"extraTls" = mkOption {
  description = "TLS configuration for additional hostname(s) to be covered with this ingress record";
  type = (types.listOf types.anything);
  default = [  ];
};
"hostname" = mkOption {
  description = "Default host for the ingress record";
  type = (types.nullOr types.str);
  default = "mlflow.local";
};
"ingressClassName" = mkOption {
  description = "IngressClass that will be be used to implement the Ingress (Kubernetes 1.18+)";
  type = (types.nullOr types.str);
  default = "";
};
"path" = mkOption {
  description = "Default path for the ingress record";
  type = (types.nullOr types.str);
  default = "/";
};
"pathType" = mkOption {
  description = "Ingress path type";
  type = (types.nullOr types.str);
  default = "ImplementationSpecific";
};
"secrets" = mkOption {
  description = "Custom TLS certificates as secrets";
  type = (types.listOf types.anything);
  default = [  ];
};
"selfSigned" = mkOption {
  description = "Create a TLS secret for this ingress record using self-signed certificates generated by Helm";
  type = types.bool;
  default = false;
};
"tls" = mkOption {
  description = "Enable TLS configuration for the host defined at `ingress.hostname` parameter";
  type = types.bool;
  default = false;
};
  };
};
TrackingLivenessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable livenessProbe on mlflow containers";
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
TrackingMetricsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable the export of Prometheus metrics";
  type = types.bool;
  default = false;
};
"serviceMonitor" = mkOption {
  type = TrackingMetricsServiceMonitorModule;
  default = {  };
};
  };
};
TrackingMetricsServiceMonitorModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Additional custom annotations for the ServiceMonitor";
  type = (types.attrsOf types.anything);
  default = {  };
};
"enabled" = mkOption {
  description = "if `true`, creates a Prometheus Operator ServiceMonitor (also requires `metrics.enabled` to be `true`)";
  type = types.bool;
  default = false;
};
"honorLabels" = mkOption {
  description = "honorLabels chooses the metric's labels on collisions with target labels";
  type = types.bool;
  default = false;
};
"interval" = mkOption {
  description = "Interval at which metrics should be scraped.";
  type = (types.nullOr types.str);
  default = "";
};
"jobLabel" = mkOption {
  description = "The name of the label on the target service to use as the job name in Prometheus";
  type = (types.nullOr types.str);
  default = "";
};
"labels" = mkOption {
  description = "Extra labels for the ServiceMonitor";
  type = (types.attrsOf types.anything);
  default = {  };
};
"metricRelabelings" = mkOption {
  description = "Specify additional relabeling of metrics";
  type = (types.listOf types.anything);
  default = [  ];
};
"namespace" = mkOption {
  description = "Namespace in which Prometheus is running";
  type = (types.nullOr types.str);
  default = "";
};
"relabelings" = mkOption {
  description = "Specify general relabeling";
  type = (types.listOf types.anything);
  default = [  ];
};
"scrapeTimeout" = mkOption {
  description = "Timeout after which the scrape is ended";
  type = (types.nullOr types.str);
  default = "";
};
"selector" = mkOption {
  description = "Prometheus instance selector labels";
  type = (types.attrsOf types.anything);
  default = {  };
};
  };
};
TrackingModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "affinity" = mkOption {
  description = "Affinity for mlflow pods assignment";
  type = (types.attrsOf types.anything);
  default = {  };
};
"args" = mkOption {
  description = "Override default container args (useful when using custom images)";
  type = (types.listOf types.anything);
  default = [  ];
};
"auth" = mkOption {
  type = TrackingAuthModule;
  default = {  };
};
"automountServiceAccountToken" = mkOption {
  description = "Mount Service Account token in pod";
  type = types.bool;
  default = false;
};
"autoscaling" = mkOption {
  type = TrackingAutoscalingModule;
  default = {  };
};
"command" = mkOption {
  description = "Override default container command (useful when using custom images)";
  type = (types.listOf types.anything);
  default = [  ];
};
"containerPorts" = mkOption {
  type = TrackingContainerPortsModule;
  default = {  };
};
"containerSecurityContext" = mkOption {
  type = TrackingContainerSecurityContextModule;
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
  description = "Add default init containers to the deployment";
  type = types.bool;
  default = true;
};
"enabled" = mkOption {
  description = "Enable Tracking server";
  type = types.bool;
  default = true;
};
"extraArgs" = mkOption {
  description = "Add extra arguments together with the default ones";
  type = (types.listOf types.anything);
  default = [  ];
};
"extraEnvVars" = mkOption {
  description = "Array with extra environment variables to add to mlflow nodes";
  type = (types.listOf types.anything);
  default = [  ];
};
"extraEnvVarsCM" = mkOption {
  description = "Name of existing ConfigMap containing extra env vars for mlflow nodes";
  type = (types.nullOr types.str);
  default = "";
};
"extraEnvVarsSecret" = mkOption {
  description = "Name of existing Secret containing extra env vars for mlflow nodes";
  type = (types.nullOr types.str);
  default = "";
};
"extraVolumeMounts" = mkOption {
  description = "Optionally specify extra list of additional volumeMounts for the mlflow container(s)";
  type = (types.listOf types.anything);
  default = [  ];
};
"extraVolumes" = mkOption {
  description = "Optionally specify extra list of additional volumes for the mlflow pod(s)";
  type = (types.listOf types.anything);
  default = [  ];
};
"hostAliases" = mkOption {
  description = "mlflow pods host aliases";
  type = (types.listOf types.anything);
  default = [  ];
};
"ingress" = mkOption {
  type = TrackingIngressModule;
  default = {  };
};
"initContainers" = mkOption {
  description = "Add additional init containers to the mlflow pod(s)";
  type = (types.listOf types.anything);
  default = [  ];
};
"lifecycleHooks" = mkOption {
  description = "for the mlflow container(s) to automate configuration before or after startup";
  type = (types.attrsOf types.anything);
  default = {  };
};
"livenessProbe" = mkOption {
  type = TrackingLivenessProbeModule;
  default = {  };
};
"metrics" = mkOption {
  type = TrackingMetricsModule;
  default = {  };
};
"networkPolicy" = mkOption {
  type = TrackingNetworkPolicyModule;
  default = {  };
};
"nodeAffinityPreset" = mkOption {
  type = TrackingNodeAffinityPresetModule;
  default = {  };
};
"nodeSelector" = mkOption {
  description = "Node labels for mlflow pods assignment";
  type = (types.attrsOf types.anything);
  default = {  };
};
"pdb" = mkOption {
  type = TrackingPdbModule;
  default = {  };
};
"persistence" = mkOption {
  type = TrackingPersistenceModule;
  default = {  };
};
"podAffinityPreset" = mkOption {
  description = "Pod affinity preset. Ignored if `.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "";
};
"podAnnotations" = mkOption {
  description = "Annotations for mlflow pods";
  type = (types.attrsOf types.anything);
  default = {  };
};
"podAntiAffinityPreset" = mkOption {
  description = "Pod anti-affinity preset. Ignored if `.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "soft";
};
"podLabels" = mkOption {
  description = "Extra labels for mlflow pods";
  type = (types.attrsOf types.anything);
  default = {  };
};
"podSecurityContext" = mkOption {
  type = TrackingPodSecurityContextModule;
  default = {  };
};
"priorityClassName" = mkOption {
  description = "mlflow pods' priorityClassName";
  type = (types.nullOr types.str);
  default = "";
};
"readinessProbe" = mkOption {
  type = TrackingReadinessProbeModule;
  default = {  };
};
"replicaCount" = mkOption {
  description = "Number of mlflow replicas to deploy";
  type = (types.nullOr types.int);
  default = 1;
};
"resources" = mkOption {
  type = TrackingResourcesModule;
  default = {  };
};
"runUpgradeDB" = mkOption {
  description = "Add an init container to run mlflow db upgrade";
  type = types.bool;
  default = false;
};
"schedulerName" = mkOption {
  description = "Name of the k8s scheduler (other than default) for mlflow pods";
  type = (types.nullOr types.str);
  default = "";
};
"service" = mkOption {
  type = TrackingServiceModule;
  default = {  };
};
"serviceAccount" = mkOption {
  type = TrackingServiceAccountModule;
  default = {  };
};
"sidecars" = mkOption {
  description = "Add additional sidecar containers to the mlflow pod(s)";
  type = (types.listOf types.anything);
  default = [  ];
};
"startupProbe" = mkOption {
  type = TrackingStartupProbeModule;
  default = {  };
};
"terminationGracePeriodSeconds" = mkOption {
  description = "Seconds Redmine pod needs to terminate gracefully";
  type = (types.nullOr types.str);
  default = "";
};
"tls" = mkOption {
  type = TrackingTlsModule;
  default = {  };
};
"tmpVolume" = mkOption {
  type = TrackingTmpVolumeModule;
  default = {  };
};
"tolerations" = mkOption {
  description = "Tolerations for mlflow pods assignment";
  type = (types.listOf types.anything);
  default = [  ];
};
"topologySpreadConstraints" = mkOption {
  description = "Topology Spread Constraints for pod assignment spread across your cluster among failure-domains. Evaluated as a template";
  type = (types.listOf types.anything);
  default = [  ];
};
"updateStrategy" = mkOption {
  type = TrackingUpdateStrategyModule;
  default = {  };
};
  };
};
TrackingNetworkPolicyModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "allowExternal" = mkOption {
  description = "The Policy model to apply";
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
  description = "Add extra ingress rules to the NetworkPolicy";
  type = (types.listOf types.anything);
  default = "[]";
};
"extraIngress" = mkOption {
  description = "Add extra ingress rules to the NetworkPolicy";
  type = (types.listOf types.anything);
  default = "[]";
};
  };
};
TrackingNodeAffinityPresetModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "key" = mkOption {
  description = "Node label key to match. Ignored if `.affinity` is set";
  type = (types.nullOr types.str);
  default = "";
};
"type" = mkOption {
  description = "Node affinity preset type. Ignored if `.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "";
};
"values" = mkOption {
  description = "Node label values to match. Ignored if `.affinity` is set";
  type = (types.listOf types.anything);
  default = [  ];
};
  };
};
TrackingPdbModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "create" = mkOption {
  description = "Enable/disable a Pod Disruption Budget creation";
  type = types.bool;
  default = false;
};
"maxUnavailable" = mkOption {
  description = "Maximum number/percentage of pods that may be made unavailable";
  type = (types.nullOr types.str);
  default = "";
};
"minAvailable" = mkOption {
  description = "Minimum number/percentage of pods that should remain scheduled";
  type = (types.nullOr types.str);
  default = "1";
};
  };
};
TrackingPersistenceModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "accessModes" = mkOption {
  description = "Persistent Volume Access Modes";
  type = (types.listOf types.str);
  default = [ "ReadWriteOnce" ];
};
"annotations" = mkOption {
  description = "Persistent Volume Claim annotations";
  type = (types.attrsOf types.anything);
  default = {  };
};
"dataSource" = mkOption {
  description = "Custom PVC data source";
  type = (types.attrsOf types.anything);
  default = {  };
};
"enabled" = mkOption {
  description = "Enable persistence using Persistent Volume Claims";
  type = types.bool;
  default = true;
};
"existingClaim" = mkOption {
  description = "The name of an existing PVC to use for persistence";
  type = (types.nullOr types.str);
  default = "";
};
"labels" = mkOption {
  description = "Persistent Volume labels";
  type = (types.attrsOf types.anything);
  default = {  };
};
"mountPath" = mkOption {
  description = "Path to mount the volume at.";
  type = (types.nullOr types.str);
  default = "/bitnami/mlflow";
};
"selector" = mkOption {
  description = "Selector to match an existing Persistent Volume for WordPress data PVC";
  type = (types.attrsOf types.anything);
  default = {  };
};
"size" = mkOption {
  description = "Size of data volume";
  type = (types.nullOr types.str);
  default = "8Gi";
};
"storageClass" = mkOption {
  description = "Storage class of backing PVC";
  type = (types.nullOr types.str);
  default = "";
};
"subPath" = mkOption {
  description = "The subdirectory of the volume to mount to, useful in dev environments and one PV for multiple services";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
TrackingPodSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enabled mlflow pods' Security Context";
  type = types.bool;
  default = true;
};
"fsGroup" = mkOption {
  description = "Set mlflow pod's Security Context fsGroup";
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
TrackingReadinessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable readinessProbe on mlflow containers";
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
  default = 5;
};
  };
};
TrackingResourcesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "limits" = mkOption {
  description = "The resources limits for the mlflow containers";
  type = (types.attrsOf types.anything);
  default = {  };
};
"requests" = mkOption {
  description = "The requested resources for the mlflow containers";
  type = (types.attrsOf types.anything);
  default = {  };
};
  };
};
TrackingServiceAccountModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Additional Service Account annotations (evaluated as a template)";
  type = (types.attrsOf types.anything);
  default = {  };
};
"automountServiceAccountToken" = mkOption {
  description = "Automount service account token for the server service account";
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
TrackingServiceModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Additional custom annotations for mlflow service";
  type = (types.attrsOf types.anything);
  default = {  };
};
"clusterIP" = mkOption {
  description = "mlflow service Cluster IP";
  type = (types.nullOr types.str);
  default = "";
};
"externalTrafficPolicy" = mkOption {
  description = "mlflow service external traffic policy";
  type = (types.nullOr types.str);
  default = "Cluster";
};
"extraPorts" = mkOption {
  description = "Extra ports to expose in mlflow service (normally used with the `sidecars` value)";
  type = (types.listOf types.anything);
  default = [  ];
};
"labels" = mkOption {
  description = "Add labels to the service object";
  type = (types.attrsOf types.anything);
  default = {  };
};
"loadBalancerIP" = mkOption {
  description = "mlflow service Load Balancer IP";
  type = (types.nullOr types.str);
  default = "";
};
"loadBalancerSourceRanges" = mkOption {
  description = "mlflow service Load Balancer sources";
  type = (types.listOf types.anything);
  default = [  ];
};
"nodePorts" = mkOption {
  type = TrackingServiceNodePortsModule;
  default = {  };
};
"ports" = mkOption {
  type = TrackingServicePortsModule;
  default = {  };
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
  description = "mlflow service type";
  type = (types.nullOr types.str);
  default = "LoadBalancer";
};
  };
};
TrackingServiceNodePortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "http" = mkOption {
  description = "Node port for HTTP";
  type = (types.nullOr types.str);
  default = "";
};
"https" = mkOption {
  description = "Node port for HTTPS";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
TrackingServicePortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "http" = mkOption {
  description = "mlflow service HTTP port";
  type = (types.nullOr types.int);
  default = 80;
};
"https" = mkOption {
  description = "mlflow service HTTPS port";
  type = (types.nullOr types.int);
  default = 443;
};
  };
};
TrackingStartupProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable startupProbe on mlflow containers";
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
TrackingTlsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "autoGenerated" = mkOption {
  description = "Generate automatically self-signed TLS certificates";
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
  description = "Certificate key filename";
  type = (types.nullOr types.str);
  default = "";
};
"certificatesSecret" = mkOption {
  description = "Name of an existing secret that contains the certificates";
  type = (types.nullOr types.str);
  default = "";
};
"enabled" = mkOption {
  description = "Enable TLS traffic support";
  type = types.bool;
  default = false;
};
  };
};
TrackingTmpVolumeEphemeralModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Use a generic ephemeral volume for `/tmp` instead of `emptyDir`";
  type = types.bool;
  default = false;
};
"volumeClaimTemplate" = mkOption {
  description = "Custom `volumeClaimTemplate` for the ephemeral volume (YAML map)";
  type = (types.attrsOf types.anything);
  default = {  };
};
  };
};
TrackingTmpVolumeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "ephemeral" = mkOption {
  type = TrackingTmpVolumeEphemeralModule;
  default = {  };
};
  };
};
TrackingUpdateStrategyModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "type" = mkOption {
  description = "mlflow statefulset strategy type";
  type = (types.nullOr types.str);
  default = "RollingUpdate";
};
  };
};
VolumePermissionsContainerSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Set container security context settings";
  type = types.bool;
  default = true;
};
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
  type = VolumePermissionsResourcesModule;
  default = {  };
};
  };
};
VolumePermissionsResourcesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "limits" = mkOption {
  description = "The resources limits for the init container";
  type = (types.attrsOf types.anything);
  default = {  };
};
"requests" = mkOption {
  description = "The requested resources for the init container";
  type = (types.attrsOf types.anything);
  default = {  };
};
  };
};
WaitContainerContainerSecurityContextCapabilitiesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "drop" = mkOption {
  description = "Set container's Security Context runAsNonRoot";
  type = (types.listOf types.str);
  default = [ "ALL" ];
};
  };
};
WaitContainerContainerSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "allowPrivilegeEscalation" = mkOption {
  description = "Set container's privilege escalation";
  type = types.bool;
  default = false;
};
"capabilities" = mkOption {
  type = WaitContainerContainerSecurityContextCapabilitiesModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Enabled containers' Security Context";
  type = types.bool;
  default = true;
};
"privileged" = mkOption {
  description = "Set containers' Security Context privileged";
  type = types.bool;
  default = false;
};
"readOnlyRootFilesystem" = mkOption {
  description = "Set containers' Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsNonRoot" = mkOption {
  description = "Set containers' Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsUser" = mkOption {
  description = "Set containers' Security Context runAsUser";
  type = (types.nullOr types.int);
  default = 1001;
};
"seccompProfile" = mkOption {
  type = WaitContainerContainerSecurityContextSeccompProfileModule;
  default = {  };
};
  };
};
WaitContainerContainerSecurityContextSeccompProfileModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "type" = mkOption {
  description = "Set container's Security Context seccomp profile";
  type = (types.nullOr types.str);
  default = "RuntimeDefault";
};
  };
};
WaitContainerImageModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "digest" = mkOption {
  description = "Init container wait-container image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag";
  type = (types.nullOr types.str);
  default = "";
};
"pullPolicy" = mkOption {
  description = "Init container wait-container image pull policy";
  type = (types.nullOr types.str);
  default = "IfNotPresent";
};
"pullSecrets" = mkOption {
  description = "Specify docker-registry secret names as an array";
  type = (types.listOf types.str);
  default = "[]";
};
"registry" = mkOption {
  description = "Init container wait-container image registry";
  type = (types.nullOr types.str);
  default = "REGISTRY_NAME";
};
"repository" = mkOption {
  description = "Init container wait-container image name";
  type = (types.nullOr types.str);
  default = "REPOSITORY_NAME/os-shell";
};
  };
};
WaitContainerModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "containerSecurityContext" = mkOption {
  type = WaitContainerContainerSecurityContextModule;
  default = {  };
};
"image" = mkOption {
  type = WaitContainerImageModule;
  default = {  };
};
  };
};
in
{
  freeformType = types.attrsOf types.anything;
  options = {
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
"diagnosticMode" = mkOption {
  type = DiagnosticModeModule;
  default = {  };
};
"externalDatabase" = mkOption {
  type = ExternalDatabaseModule;
  default = {  };
};
"externalS3" = mkOption {
  type = ExternalS3Module;
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
"minio" = mkOption {
  type = MinioModule;
  default = {  };
};
"nameOverride" = mkOption {
  description = "String to partially override common.names.name";
  type = (types.nullOr types.str);
  default = "";
};
"namespaceOverride" = mkOption {
  description = "String to fully override common.names.namespace";
  type = (types.nullOr types.str);
  default = "";
};
"postgresql" = mkOption {
  type = PostgresqlModule;
  default = {  };
};
"run" = mkOption {
  type = RunModule;
  default = {  };
};
"tracking" = mkOption {
  type = TrackingModule;
  default = {  };
};
"volumePermissions" = mkOption {
  type = VolumePermissionsModule;
  default = {  };
};
"waitContainer" = mkOption {
  type = WaitContainerModule;
  default = {  };
};
  };
}
