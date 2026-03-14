# Auto-generated from Bitnami values.schema.json
# Do not edit — regenerate with bin/create-module-bitnami
{ lib, ... }:
with lib;
let
  AuthModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "customPasswordFiles" = mkOption {
  description = "Use custom password files when `auth.usePasswordFiles` is set to `true`. Define path for keys `root` and `user`, also define `replicator` if `architecture` is set to `replication`";
  type = (types.attrsOf types.anything);
  default = {  };
};
"database" = mkOption {
  description = "Name for a custom database to create";
  type = (types.nullOr types.str);
  default = "my_database";
};
"existingSecret" = mkOption {
  description = "Use existing secret for password details (`auth.rootPassword`, `auth.password`, `auth.replicationPassword` will be ignored and picked up from this secret). The secret has to contain the keys `mariadb-root-password`, `mariadb-replication-password` and `mariadb-password`";
  type = (types.nullOr types.str);
  default = "";
};
"forcePassword" = mkOption {
  description = "Force users to specify required passwords";
  type = types.bool;
  default = false;
};
"password" = mkOption {
  description = "Password for the new user. Ignored if existing secret is provided";
  type = (types.nullOr types.str);
  default = "";
};
"replicationPassword" = mkOption {
  description = "MariaDB replication user password. Ignored if existing secret is provided";
  type = (types.nullOr types.str);
  default = "";
};
"replicationUser" = mkOption {
  description = "MariaDB replication user";
  type = (types.nullOr types.str);
  default = "replicator";
};
"rootPassword" = mkOption {
  description = "Password for the `root` user. Ignored if existing secret is provided.";
  type = (types.nullOr types.str);
  default = "";
};
"usePasswordFiles" = mkOption {
  description = "Mount credentials as files instead of using environment variables";
  type = types.bool;
  default = false;
};
"username" = mkOption {
  description = "Name for a custom user to create";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
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
  description = "Global Docker Image registry";
  type = (types.nullOr types.str);
  default = "";
};
"security" = mkOption {
  type = GlobalSecurityModule;
  default = {  };
};
  };
};
GlobalSecurityModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "allowInsecureImages" = mkOption {
  description = "Allows skipping image verification";
  type = types.bool;
  default = false;
};
  };
};
ImageModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "debug" = mkOption {
  description = "Specify if debug logs should be enabled";
  type = types.bool;
  default = false;
};
"digest" = mkOption {
  description = "MariaDB image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag";
  type = (types.nullOr types.str);
  default = "";
};
"pullPolicy" = mkOption {
  description = "MariaDB image pull policy";
  type = (types.nullOr types.str);
  default = "IfNotPresent";
};
"pullSecrets" = mkOption {
  description = "Specify docker-registry secret names as an array";
  type = (types.listOf types.anything);
  default = [  ];
};
"registry" = mkOption {
  description = "MariaDB image registry";
  type = (types.nullOr types.str);
  default = "REGISTRY_NAME";
};
"repository" = mkOption {
  description = "MariaDB image repository";
  type = (types.nullOr types.str);
  default = "REPOSITORY_NAME/mariadb";
};
  };
};
MetricsContainerPortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "http" = mkOption {
  description = "Container port for http";
  type = (types.nullOr types.int);
  default = 9104;
};
  };
};
MetricsContainerSecurityContextCapabilitiesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "drop" = mkOption {
  description = "List of capabilities to be dropped";
  type = (types.listOf types.str);
  default = [ "ALL" ];
};
  };
};
MetricsContainerSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "allowPrivilegeEscalation" = mkOption {
  description = "Set metrics container's Security Context allowPrivilegeEscalation";
  type = types.bool;
  default = false;
};
"capabilities" = mkOption {
  type = MetricsContainerSecurityContextCapabilitiesModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Enable security context for MariaDB metrics container";
  type = types.bool;
  default = false;
};
"privileged" = mkOption {
  description = "Set metrics container's Security Context privileged";
  type = types.bool;
  default = false;
};
"readOnlyRootFilesystem" = mkOption {
  description = "Set container's Security Context readOnlyRootFilesystem";
  type = types.bool;
  default = true;
};
"runAsGroup" = mkOption {
  description = "Group ID for the MariaDB metrics container";
  type = (types.nullOr types.int);
  default = 1001;
};
"runAsNonRoot" = mkOption {
  description = "Set metrics container's Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsUser" = mkOption {
  description = "User ID for the MariaDB metrics container";
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
  description = "Set container's Security Context seccomp profile";
  type = (types.nullOr types.str);
  default = "RuntimeDefault";
};
  };
};
MetricsImageModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "digest" = mkOption {
  description = "Exporter image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag";
  type = (types.nullOr types.str);
  default = "";
};
"pullPolicy" = mkOption {
  description = "Exporter image pull policy";
  type = (types.nullOr types.str);
  default = "IfNotPresent";
};
"pullSecrets" = mkOption {
  description = "Specify docker-registry secret names as an array";
  type = (types.listOf types.anything);
  default = [  ];
};
"registry" = mkOption {
  description = "Exporter image registry";
  type = (types.nullOr types.str);
  default = "REGISTRY_NAME";
};
"repository" = mkOption {
  description = "Exporter image repository";
  type = (types.nullOr types.str);
  default = "REPOSITORY_NAME/mysqld-exporter";
};
  };
};
MetricsLivenessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable livenessProbe";
  type = types.bool;
  default = true;
};
"failureThreshold" = mkOption {
  description = "Failure threshold for livenessProbe";
  type = (types.nullOr types.int);
  default = 3;
};
"initialDelaySeconds" = mkOption {
  description = "Initial delay seconds for livenessProbe";
  type = (types.nullOr types.int);
  default = 120;
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
  default = 1;
};
  };
};
MetricsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "containerPorts" = mkOption {
  type = MetricsContainerPortsModule;
  default = {  };
};
"containerSecurityContext" = mkOption {
  type = MetricsContainerSecurityContextModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Start a side-car prometheus exporter";
  type = types.bool;
  default = false;
};
"image" = mkOption {
  type = MetricsImageModule;
  default = {  };
};
"livenessProbe" = mkOption {
  type = MetricsLivenessProbeModule;
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
"serviceMonitor" = mkOption {
  type = MetricsServiceMonitorModule;
  default = {  };
};
  };
};
MetricsPrometheusRuleModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "additionalLabels" = mkOption {
  description = "Additional labels that can be used so PrometheusRule will be discovered by Prometheus";
  type = (types.attrsOf types.anything);
  default = {  };
};
"enabled" = mkOption {
  description = "if `true`, creates a Prometheus Operator PrometheusRule (also requires `metrics.enabled` to be `true` and `metrics.prometheusRule.rules`)";
  type = types.bool;
  default = false;
};
"namespace" = mkOption {
  description = "Namespace for the PrometheusRule Resource (defaults to the Release Namespace)";
  type = (types.nullOr types.str);
  default = "";
};
"rules" = mkOption {
  description = "Prometheus Rule definitions";
  type = (types.listOf types.anything);
  default = [  ];
};
  };
};
MetricsReadinessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable readinessProbe";
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
  default = 30;
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
MetricsServiceMonitorModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Create ServiceMonitor Resource for scraping metrics using PrometheusOperator";
  type = types.bool;
  default = false;
};
"honorLabels" = mkOption {
  description = "honorLabels chooses the metric's labels on collisions with target labels";
  type = types.bool;
  default = false;
};
"interval" = mkOption {
  description = "Interval at which metrics should be scraped";
  type = (types.nullOr types.str);
  default = "30s";
};
"jobLabel" = mkOption {
  description = "The name of the label on the target service to use as the job name in prometheus.";
  type = (types.nullOr types.str);
  default = "";
};
"labels" = mkOption {
  description = "Extra labels for the ServiceMonitor";
  type = (types.attrsOf types.anything);
  default = {  };
};
"metricRelabelings" = mkOption {
  description = "MetricRelabelConfigs to apply to samples before ingestion";
  type = (types.listOf types.anything);
  default = [  ];
};
"namespace" = mkOption {
  description = "Namespace which Prometheus is running in";
  type = (types.nullOr types.str);
  default = "";
};
"relabelings" = mkOption {
  description = "RelabelConfigs to apply to samples before scraping";
  type = (types.listOf types.anything);
  default = [  ];
};
"scrapeTimeout" = mkOption {
  description = "Specify the timeout after which the scrape is ended";
  type = (types.nullOr types.str);
  default = "";
};
"selector" = mkOption {
  description = "ServiceMonitor selector labels";
  type = (types.attrsOf types.anything);
  default = {  };
};
  };
};
NetworkPolicyModule = types.submodule {
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
  type = (types.listOf types.str);
  default = "[]";
};
"extraIngress" = mkOption {
  description = "Add extra ingress rules to the NetworkPolicy";
  type = (types.listOf types.str);
  default = "[]";
};
  };
};
PasswordUpdateJobContainerSecurityContextCapabilitiesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "drop" = mkOption {
  description = "List of capabilities to be dropped";
  type = (types.listOf types.str);
  default = [ "ALL" ];
};
  };
};
PasswordUpdateJobContainerSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "allowPrivilegeEscalation" = mkOption {
  description = "Set container's Security Context allowPrivilegeEscalation";
  type = types.bool;
  default = false;
};
"capabilities" = mkOption {
  type = PasswordUpdateJobContainerSecurityContextCapabilitiesModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Enabled containers' Security Context";
  type = types.bool;
  default = true;
};
"privileged" = mkOption {
  description = "Set container's Security Context privileged";
  type = types.bool;
  default = false;
};
"readOnlyRootFilesystem" = mkOption {
  description = "Set container's Security Context readOnlyRootFilesystem";
  type = types.bool;
  default = true;
};
"runAsGroup" = mkOption {
  description = "Set containers' Security Context runAsGroup";
  type = (types.nullOr types.int);
  default = 1001;
};
"runAsNonRoot" = mkOption {
  description = "Set container's Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsUser" = mkOption {
  description = "Set containers' Security Context runAsUser";
  type = (types.nullOr types.int);
  default = 1001;
};
"seccompProfile" = mkOption {
  type = PasswordUpdateJobContainerSecurityContextSeccompProfileModule;
  default = {  };
};
  };
};
PasswordUpdateJobContainerSecurityContextSeccompProfileModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "type" = mkOption {
  description = "Set container's Security Context seccomp profile";
  type = (types.nullOr types.str);
  default = "RuntimeDefault";
};
  };
};
PasswordUpdateJobModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "args" = mkOption {
  description = "Override default container args on MariaDB Primary container(s) (useful when using custom images)";
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
  description = "Override default container command on MariaDB Primary container(s) (useful when using custom images)";
  type = (types.listOf types.anything);
  default = [  ];
};
"containerSecurityContext" = mkOption {
  type = PasswordUpdateJobContainerSecurityContextModule;
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
"enabled" = mkOption {
  description = "Enable password update job";
  type = types.bool;
  default = false;
};
"extraCommands" = mkOption {
  description = "Extra commands to pass to the generation job";
  type = (types.nullOr types.str);
  default = "";
};
"extraEnvVars" = mkOption {
  description = "Array containing extra env vars to configure the credential init job";
  type = (types.listOf types.anything);
  default = [  ];
};
"extraEnvVarsCM" = mkOption {
  description = "ConfigMap containing extra env vars to configure the credential init job";
  type = (types.nullOr types.str);
  default = "";
};
"extraEnvVarsSecret" = mkOption {
  description = "Secret containing extra env vars to configure the credential init job (in case of sensitive data)";
  type = (types.nullOr types.str);
  default = "";
};
"extraVolumeMounts" = mkOption {
  description = "Array of extra volume mounts to be added to the jwt Container (evaluated as template). Normally used with `extraVolumes`.";
  type = (types.listOf types.anything);
  default = [  ];
};
"extraVolumes" = mkOption {
  description = "Optionally specify extra list of additional volumes for the credential init job";
  type = (types.listOf types.anything);
  default = [  ];
};
"hostAliases" = mkOption {
  description = "Add deployment host aliases";
  type = (types.listOf types.anything);
  default = [  ];
};
"initContainers" = mkOption {
  description = "Add additional init containers for the MariaDB Primary pod(s)";
  type = (types.listOf types.anything);
  default = [  ];
};
"podAnnotations" = mkOption {
  description = "Additional pod annotations";
  type = (types.attrsOf types.anything);
  default = {  };
};
"podLabels" = mkOption {
  description = "Additional pod labels";
  type = (types.attrsOf types.anything);
  default = {  };
};
"podSecurityContext" = mkOption {
  type = PasswordUpdateJobPodSecurityContextModule;
  default = {  };
};
"previousPasswords" = mkOption {
  type = PasswordUpdateJobPreviousPasswordsModule;
  default = {  };
};
"resources" = mkOption {
  description = "Set container requests and limits for different resources like CPU or memory (essential for production workloads)";
  type = (types.attrsOf types.anything);
  default = {  };
};
"resourcesPreset" = mkOption {
  description = "Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if passwordUpdateJob.resources is set (passwordUpdateJob.resources is recommended for production).";
  type = (types.nullOr types.str);
  default = "micro";
};
  };
};
PasswordUpdateJobPodSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enabled credential init job pods' Security Context";
  type = types.bool;
  default = true;
};
"fsGroup" = mkOption {
  description = "Set credential init job pod's Security Context fsGroup";
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
PasswordUpdateJobPreviousPasswordsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "existingSecret" = mkOption {
  description = "Name of a secret containing the previous passwords (set if the password secret was already changed)";
  type = (types.nullOr types.str);
  default = "";
};
"password" = mkOption {
  description = "Previous password (set if the password secret was already changed)";
  type = (types.nullOr types.str);
  default = "";
};
"replicationPassword" = mkOption {
  description = "Previous replication password (set if the password secret was already changed)";
  type = (types.nullOr types.str);
  default = "";
};
"rootPassword" = mkOption {
  description = "Previous root password (set if the password secret was already changed)";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
PrimaryContainerPortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "mysql" = mkOption {
  description = "Container port for mysql";
  type = (types.nullOr types.int);
  default = 3306;
};
  };
};
PrimaryContainerSecurityContextCapabilitiesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "drop" = mkOption {
  description = "List of capabilities to be dropped";
  type = (types.listOf types.str);
  default = [ "ALL" ];
};
  };
};
PrimaryContainerSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "allowPrivilegeEscalation" = mkOption {
  description = "Set primary container's Security Context allowPrivilegeEscalation";
  type = types.bool;
  default = false;
};
"capabilities" = mkOption {
  type = PrimaryContainerSecurityContextCapabilitiesModule;
  default = {  };
};
"enabled" = mkOption {
  description = "MariaDB primary container securityContext";
  type = types.bool;
  default = true;
};
"privileged" = mkOption {
  description = "Set primary container's Security Context privileged";
  type = types.bool;
  default = false;
};
"readOnlyRootFilesystem" = mkOption {
  description = "Set container's Security Context readOnlyRootFilesystem";
  type = types.bool;
  default = true;
};
"runAsGroup" = mkOption {
  description = "Group ID for the MariaDB primary container";
  type = (types.nullOr types.int);
  default = 1001;
};
"runAsNonRoot" = mkOption {
  description = "Set primary container's Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsUser" = mkOption {
  description = "User ID for the MariaDB primary container";
  type = (types.nullOr types.int);
  default = 1001;
};
"seccompProfile" = mkOption {
  type = PrimaryContainerSecurityContextSeccompProfileModule;
  default = {  };
};
  };
};
PrimaryContainerSecurityContextSeccompProfileModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "type" = mkOption {
  description = "Set container's Security Context seccomp profile";
  type = (types.nullOr types.str);
  default = "RuntimeDefault";
};
  };
};
PrimaryLivenessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable livenessProbe";
  type = types.bool;
  default = true;
};
"failureThreshold" = mkOption {
  description = "Failure threshold for livenessProbe";
  type = (types.nullOr types.int);
  default = 3;
};
"initialDelaySeconds" = mkOption {
  description = "Initial delay seconds for livenessProbe";
  type = (types.nullOr types.int);
  default = 120;
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
  default = 1;
};
  };
};
PrimaryModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "affinity" = mkOption {
  description = "Affinity for MariaDB primary pods assignment";
  type = (types.attrsOf types.anything);
  default = {  };
};
"args" = mkOption {
  description = "Override default container args on MariaDB Primary container(s) (useful when using custom images)";
  type = (types.listOf types.anything);
  default = [  ];
};
"automountServiceAccountToken" = mkOption {
  description = "Mount Service Account token in pod";
  type = types.bool;
  default = false;
};
"command" = mkOption {
  description = "Override default container command on MariaDB Primary container(s) (useful when using custom images)";
  type = (types.listOf types.anything);
  default = [  ];
};
"configuration" = mkOption {
  description = "MariaDB Primary configuration to be injected as ConfigMap";
  type = (types.nullOr types.str);
  default = """";
};
"containerPorts" = mkOption {
  type = PrimaryContainerPortsModule;
  default = {  };
};
"containerSecurityContext" = mkOption {
  type = PrimaryContainerSecurityContextModule;
  default = {  };
};
"customLivenessProbe" = mkOption {
  description = "Override default liveness probe for MariaDB primary containers";
  type = (types.attrsOf types.anything);
  default = {  };
};
"customReadinessProbe" = mkOption {
  description = "Override default readiness probe for MariaDB primary containers";
  type = (types.attrsOf types.anything);
  default = {  };
};
"customStartupProbe" = mkOption {
  description = "Override default startup probe for MariaDB primary containers";
  type = (types.attrsOf types.anything);
  default = {  };
};
"existingConfigmap" = mkOption {
  description = "Name of existing ConfigMap with MariaDB Primary configuration.";
  type = (types.nullOr types.str);
  default = "";
};
"extraEnvVars" = mkOption {
  description = "Extra environment variables to be set on MariaDB primary containers";
  type = (types.listOf types.anything);
  default = [  ];
};
"extraEnvVarsCM" = mkOption {
  description = "Name of existing ConfigMap containing extra env vars for MariaDB primary containers";
  type = (types.nullOr types.str);
  default = "";
};
"extraEnvVarsSecret" = mkOption {
  description = "Name of existing Secret containing extra env vars for MariaDB primary containers";
  type = (types.nullOr types.str);
  default = "";
};
"extraFlags" = mkOption {
  description = "MariaDB primary additional command line flags";
  type = (types.nullOr types.str);
  default = "";
};
"extraVolumeMounts" = mkOption {
  description = "Optionally specify extra list of additional volumeMounts for the MariaDB Primary container(s)";
  type = (types.listOf types.anything);
  default = [  ];
};
"extraVolumes" = mkOption {
  description = "Optionally specify extra list of additional volumes to the MariaDB Primary pod(s)";
  type = (types.listOf types.anything);
  default = [  ];
};
"hostAliases" = mkOption {
  description = "Add deployment host aliases";
  type = (types.listOf types.anything);
  default = [  ];
};
"initContainers" = mkOption {
  description = "Add additional init containers for the MariaDB Primary pod(s)";
  type = (types.listOf types.anything);
  default = [  ];
};
"lifecycleHooks" = mkOption {
  description = "for the MariaDB Primary container(s) to automate configuration before or after startup";
  type = (types.attrsOf types.anything);
  default = {  };
};
"livenessProbe" = mkOption {
  type = PrimaryLivenessProbeModule;
  default = {  };
};
"name" = mkOption {
  description = "Name of the primary database (eg primary, master, leader, ...)";
  type = (types.nullOr types.str);
  default = "primary";
};
"nodeAffinityPreset" = mkOption {
  type = PrimaryNodeAffinityPresetModule;
  default = {  };
};
"nodeSelector" = mkOption {
  description = "Node labels for MariaDB primary pods assignment";
  type = (types.attrsOf types.anything);
  default = {  };
};
"pdb" = mkOption {
  type = PrimaryPdbModule;
  default = {  };
};
"persistence" = mkOption {
  type = PrimaryPersistenceModule;
  default = {  };
};
"podAffinityPreset" = mkOption {
  description = "MariaDB primary pod affinity preset. Ignored if `primary.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "";
};
"podAnnotations" = mkOption {
  description = "Additional pod annotations for MariaDB primary pods";
  type = (types.attrsOf types.anything);
  default = {  };
};
"podAntiAffinityPreset" = mkOption {
  description = "MariaDB primary pod anti-affinity preset. Ignored if `primary.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "soft";
};
"podLabels" = mkOption {
  description = "Extra labels for MariaDB primary pods";
  type = (types.attrsOf types.anything);
  default = {  };
};
"podManagementPolicy" = mkOption {
  description = "podManagementPolicy to manage scaling operation of MariaDB primary pods";
  type = (types.nullOr types.str);
  default = "";
};
"podSecurityContext" = mkOption {
  type = PrimaryPodSecurityContextModule;
  default = {  };
};
"priorityClassName" = mkOption {
  description = "Priority class for MariaDB primary pods assignment";
  type = (types.nullOr types.str);
  default = "";
};
"readinessProbe" = mkOption {
  type = PrimaryReadinessProbeModule;
  default = {  };
};
"resources" = mkOption {
  description = "Set container requests and limits for different resources like CPU or memory (essential for production workloads)";
  type = (types.attrsOf types.anything);
  default = {  };
};
"resourcesPreset" = mkOption {
  description = "Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if primary.resources is set (primary.resources is recommended for production).";
  type = (types.nullOr types.str);
  default = "micro";
};
"revisionHistoryLimit" = mkOption {
  description = "Maximum number of revisions that will be maintained in the StatefulSet";
  type = (types.nullOr types.int);
  default = 10;
};
"rollingUpdatePartition" = mkOption {
  description = "Partition update strategy for Mariadb Primary statefulset";
  type = (types.nullOr types.str);
  default = "";
};
"runtimeClassName" = mkOption {
  description = "Runtime Class for MariaDB primary pods";
  type = (types.nullOr types.str);
  default = "";
};
"schedulerName" = mkOption {
  description = "Name of the k8s scheduler (other than default)";
  type = (types.nullOr types.str);
  default = "";
};
"service" = mkOption {
  type = PrimaryServiceModule;
  default = {  };
};
"sidecars" = mkOption {
  description = "Add additional sidecar containers for the MariaDB Primary pod(s)";
  type = (types.listOf types.anything);
  default = [  ];
};
"startupProbe" = mkOption {
  type = PrimaryStartupProbeModule;
  default = {  };
};
"startupWaitOptions" = mkOption {
  description = "Override default builtin startup wait check options for MariaDB primary containers";
  type = (types.attrsOf types.anything);
  default = {  };
};
"tolerations" = mkOption {
  description = "Tolerations for MariaDB primary pods assignment";
  type = (types.listOf types.anything);
  default = [  ];
};
"topologySpreadConstraints" = mkOption {
  description = "Topology Spread Constraints for MariaDB primary pods assignment";
  type = (types.listOf types.anything);
  default = [  ];
};
"updateStrategy" = mkOption {
  type = PrimaryUpdateStrategyModule;
  default = {  };
};
  };
};
PrimaryNodeAffinityPresetModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "key" = mkOption {
  description = "MariaDB primary node label key to match Ignored if `primary.affinity` is set.";
  type = (types.nullOr types.str);
  default = "";
};
"type" = mkOption {
  description = "MariaDB primary node affinity preset type. Ignored if `primary.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "";
};
"values" = mkOption {
  description = "MariaDB primary node label values to match. Ignored if `primary.affinity` is set.";
  type = (types.listOf types.anything);
  default = [  ];
};
  };
};
PrimaryPdbModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "create" = mkOption {
  description = "Enable/disable a Pod Disruption Budget creation for MariaDB primary pods";
  type = types.bool;
  default = true;
};
"maxUnavailable" = mkOption {
  description = "Maximum number/percentage of MariaDB primary pods that can be unavailable after the eviction. Defaults to `1` if both `primary.pdb.minAvailable` and `primary.pdb.maxUnavailable` are empty.";
  type = (types.nullOr types.str);
  default = "";
};
"minAvailable" = mkOption {
  description = "Minimum number/percentage of MariaDB primary pods that must still be available after the eviction";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
PrimaryPersistenceModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "accessModes" = mkOption {
  description = "MariaDB primary persistent volume access Modes";
  type = (types.listOf types.str);
  default = [ "ReadWriteOnce" ];
};
"annotations" = mkOption {
  description = "MariaDB primary persistent volume claim annotations";
  type = (types.attrsOf types.anything);
  default = {  };
};
"enabled" = mkOption {
  description = "Enable persistence on MariaDB primary replicas using a `PersistentVolumeClaim`. If false, use emptyDir";
  type = types.bool;
  default = true;
};
"existingClaim" = mkOption {
  description = "Name of an existing `PersistentVolumeClaim` for MariaDB primary replicas";
  type = (types.nullOr types.str);
  default = "";
};
"labels" = mkOption {
  description = "Labels for the PVC";
  type = (types.attrsOf types.anything);
  default = {  };
};
"selector" = mkOption {
  description = "Selector to match an existing Persistent Volume";
  type = (types.attrsOf types.anything);
  default = {  };
};
"size" = mkOption {
  description = "MariaDB primary persistent volume size";
  type = (types.nullOr types.str);
  default = "8Gi";
};
"storageClass" = mkOption {
  description = "MariaDB primary persistent volume storage Class";
  type = (types.nullOr types.str);
  default = "";
};
"subPath" = mkOption {
  description = "Subdirectory of the volume to mount at";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
PrimaryPodSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable security context for MariaDB primary pods";
  type = types.bool;
  default = true;
};
"fsGroup" = mkOption {
  description = "Group ID for the mounted volumes' filesystem";
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
PrimaryReadinessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable readinessProbe";
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
  default = 30;
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
PrimaryServiceHeadlessModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Annotations of the headless service";
  type = (types.attrsOf types.anything);
  default = {  };
};
  };
};
PrimaryServiceModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Provide any additional annotations which may be required";
  type = (types.attrsOf types.anything);
  default = {  };
};
"clusterIP" = mkOption {
  description = "MariaDB Primary Kubernetes service clusterIP IP";
  type = (types.nullOr types.str);
  default = "";
};
"externalTrafficPolicy" = mkOption {
  description = "Enable client source IP preservation";
  type = (types.nullOr types.str);
  default = "Cluster";
};
"extraPorts" = mkOption {
  description = "Extra ports to expose (normally used with the `sidecar` value)";
  type = (types.listOf types.anything);
  default = [  ];
};
"headless" = mkOption {
  type = PrimaryServiceHeadlessModule;
  default = {  };
};
"loadBalancerIP" = mkOption {
  description = "MariaDB Primary loadBalancerIP if service type is `LoadBalancer`";
  type = (types.nullOr types.str);
  default = "";
};
"loadBalancerSourceRanges" = mkOption {
  description = "Address that are allowed when MariaDB Primary service is LoadBalancer";
  type = (types.listOf types.anything);
  default = [  ];
};
"nodePorts" = mkOption {
  type = PrimaryServiceNodePortsModule;
  default = {  };
};
"ports" = mkOption {
  type = PrimaryServicePortsModule;
  default = {  };
};
"sessionAffinity" = mkOption {
  description = "Session Affinity for Kubernetes service, can be \"None\" or \"ClientIP\"";
  type = (types.nullOr types.str);
  default = "None";
};
"sessionAffinityConfig" = mkOption {
  description = "Additional settings for the sessionAffinity";
  type = (types.attrsOf types.anything);
  default = {  };
};
"type" = mkOption {
  description = "MariaDB Primary Kubernetes service type";
  type = (types.nullOr types.str);
  default = "ClusterIP";
};
  };
};
PrimaryServiceNodePortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "mysql" = mkOption {
  description = "MariaDB Primary Kubernetes service node port";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
PrimaryServicePortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "metrics" = mkOption {
  description = "MariaDB Primary Kubernetes service port for metrics";
  type = (types.nullOr types.int);
  default = 9104;
};
"mysql" = mkOption {
  description = "MariaDB Primary Kubernetes service port for MariaDB";
  type = (types.nullOr types.int);
  default = 3306;
};
  };
};
PrimaryStartupProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable startupProbe";
  type = types.bool;
  default = false;
};
"failureThreshold" = mkOption {
  description = "Failure threshold for startupProbe";
  type = (types.nullOr types.int);
  default = 10;
};
"initialDelaySeconds" = mkOption {
  description = "Initial delay seconds for startupProbe";
  type = (types.nullOr types.int);
  default = 120;
};
"periodSeconds" = mkOption {
  description = "Period seconds for startupProbe";
  type = (types.nullOr types.int);
  default = 15;
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
PrimaryUpdateStrategyModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "type" = mkOption {
  description = "MariaDB primary statefulset strategy type";
  type = (types.nullOr types.str);
  default = "RollingUpdate";
};
  };
};
RbacModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "create" = mkOption {
  description = "Whether to create and use RBAC resources or not";
  type = types.bool;
  default = false;
};
  };
};
SecondaryContainerPortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "mysql" = mkOption {
  description = "Container port for mysql";
  type = (types.nullOr types.int);
  default = 3306;
};
  };
};
SecondaryContainerSecurityContextCapabilitiesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "drop" = mkOption {
  description = "List of capabilities to be dropped";
  type = (types.listOf types.str);
  default = [ "ALL" ];
};
  };
};
SecondaryContainerSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "allowPrivilegeEscalation" = mkOption {
  description = "Set secondary container's Security Context allowPrivilegeEscalation";
  type = types.bool;
  default = false;
};
"capabilities" = mkOption {
  type = SecondaryContainerSecurityContextCapabilitiesModule;
  default = {  };
};
"enabled" = mkOption {
  description = "MariaDB secondary container securityContext";
  type = types.bool;
  default = true;
};
"privileged" = mkOption {
  description = "Set secondary container's Security Context privileged";
  type = types.bool;
  default = false;
};
"readOnlyRootFilesystem" = mkOption {
  description = "Set container's Security Context readOnlyRootFilesystem";
  type = types.bool;
  default = true;
};
"runAsGroup" = mkOption {
  description = "Group ID for the MariaDB secondary container";
  type = (types.nullOr types.int);
  default = 1001;
};
"runAsNonRoot" = mkOption {
  description = "Set secondary container's Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsUser" = mkOption {
  description = "User ID for the MariaDB secondary container";
  type = (types.nullOr types.int);
  default = 1001;
};
"seccompProfile" = mkOption {
  type = SecondaryContainerSecurityContextSeccompProfileModule;
  default = {  };
};
  };
};
SecondaryContainerSecurityContextSeccompProfileModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "type" = mkOption {
  description = "Set container's Security Context seccomp profile";
  type = (types.nullOr types.str);
  default = "RuntimeDefault";
};
  };
};
SecondaryLivenessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable livenessProbe";
  type = types.bool;
  default = true;
};
"failureThreshold" = mkOption {
  description = "Failure threshold for livenessProbe";
  type = (types.nullOr types.int);
  default = 3;
};
"initialDelaySeconds" = mkOption {
  description = "Initial delay seconds for livenessProbe";
  type = (types.nullOr types.int);
  default = 120;
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
  default = 1;
};
  };
};
SecondaryModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "affinity" = mkOption {
  description = "Affinity for MariaDB secondary pods assignment";
  type = (types.attrsOf types.anything);
  default = {  };
};
"args" = mkOption {
  description = "Override default container args on MariaDB Secondary container(s) (useful when using custom images)";
  type = (types.listOf types.anything);
  default = [  ];
};
"automountServiceAccountToken" = mkOption {
  description = "Mount Service Account token in pod";
  type = types.bool;
  default = false;
};
"command" = mkOption {
  description = "Override default container command on MariaDB Secondary container(s) (useful when using custom images)";
  type = (types.listOf types.anything);
  default = [  ];
};
"configuration" = mkOption {
  description = "MariaDB Secondary configuration to be injected as ConfigMap";
  type = (types.nullOr types.str);
  default = """";
};
"containerPorts" = mkOption {
  type = SecondaryContainerPortsModule;
  default = {  };
};
"containerSecurityContext" = mkOption {
  type = SecondaryContainerSecurityContextModule;
  default = {  };
};
"customLivenessProbe" = mkOption {
  description = "Override default liveness probe for MariaDB secondary containers";
  type = (types.attrsOf types.anything);
  default = {  };
};
"customReadinessProbe" = mkOption {
  description = "Override default readiness probe for MariaDB secondary containers";
  type = (types.attrsOf types.anything);
  default = {  };
};
"customStartupProbe" = mkOption {
  description = "Override default startup probe for MariaDB secondary containers";
  type = (types.attrsOf types.anything);
  default = {  };
};
"existingConfigmap" = mkOption {
  description = "Name of existing ConfigMap with MariaDB Secondary configuration.";
  type = (types.nullOr types.str);
  default = "";
};
"extraEnvVars" = mkOption {
  description = "Extra environment variables to be set on MariaDB secondary containers";
  type = (types.listOf types.anything);
  default = [  ];
};
"extraEnvVarsCM" = mkOption {
  description = "Name of existing ConfigMap containing extra env vars for MariaDB secondary containers";
  type = (types.nullOr types.str);
  default = "";
};
"extraEnvVarsSecret" = mkOption {
  description = "Name of existing Secret containing extra env vars for MariaDB secondary containers";
  type = (types.nullOr types.str);
  default = "";
};
"extraFlags" = mkOption {
  description = "MariaDB secondary additional command line flags";
  type = (types.nullOr types.str);
  default = "";
};
"extraVolumeMounts" = mkOption {
  description = "Optionally specify extra list of additional volumeMounts for the MariaDB secondary container(s)";
  type = (types.listOf types.anything);
  default = [  ];
};
"extraVolumes" = mkOption {
  description = "Optionally specify extra list of additional volumes to the MariaDB secondary pod(s)";
  type = (types.listOf types.anything);
  default = [  ];
};
"hostAliases" = mkOption {
  description = "Add deployment host aliases";
  type = (types.listOf types.anything);
  default = [  ];
};
"initContainers" = mkOption {
  description = "Add additional init containers for the MariaDB secondary pod(s)";
  type = (types.listOf types.anything);
  default = [  ];
};
"lifecycleHooks" = mkOption {
  description = "for the MariaDB Secondary container(s) to automate configuration before or after startup";
  type = (types.attrsOf types.anything);
  default = {  };
};
"livenessProbe" = mkOption {
  type = SecondaryLivenessProbeModule;
  default = {  };
};
"name" = mkOption {
  description = "Name of the secondary database (eg secondary, slave, ...)";
  type = (types.nullOr types.str);
  default = "secondary";
};
"nodeAffinityPreset" = mkOption {
  type = SecondaryNodeAffinityPresetModule;
  default = {  };
};
"nodeSelector" = mkOption {
  description = "Node labels for MariaDB secondary pods assignment";
  type = (types.attrsOf types.anything);
  default = {  };
};
"pdb" = mkOption {
  type = SecondaryPdbModule;
  default = {  };
};
"persistence" = mkOption {
  type = SecondaryPersistenceModule;
  default = {  };
};
"podAffinityPreset" = mkOption {
  description = "MariaDB secondary pod affinity preset. Ignored if `secondary.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "";
};
"podAnnotations" = mkOption {
  description = "Additional pod annotations for MariaDB secondary pods";
  type = (types.attrsOf types.anything);
  default = {  };
};
"podAntiAffinityPreset" = mkOption {
  description = "MariaDB secondary pod anti-affinity preset. Ignored if `secondary.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "soft";
};
"podLabels" = mkOption {
  description = "Extra labels for MariaDB secondary pods";
  type = (types.attrsOf types.anything);
  default = {  };
};
"podManagementPolicy" = mkOption {
  description = "podManagementPolicy to manage scaling operation of MariaDB secondary pods";
  type = (types.nullOr types.str);
  default = "";
};
"podSecurityContext" = mkOption {
  type = SecondaryPodSecurityContextModule;
  default = {  };
};
"priorityClassName" = mkOption {
  description = "Priority class for MariaDB secondary pods assignment";
  type = (types.nullOr types.str);
  default = "";
};
"readinessProbe" = mkOption {
  type = SecondaryReadinessProbeModule;
  default = {  };
};
"replicaCount" = mkOption {
  description = "Number of MariaDB secondary replicas";
  type = (types.nullOr types.int);
  default = 1;
};
"resources" = mkOption {
  description = "Set container requests and limits for different resources like CPU or memory (essential for production workloads)";
  type = (types.attrsOf types.anything);
  default = {  };
};
"resourcesPreset" = mkOption {
  description = "Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if secondary.resources is set (secondary.resources is recommended for production).";
  type = (types.nullOr types.str);
  default = "micro";
};
"revisionHistoryLimit" = mkOption {
  description = "Maximum number of revisions that will be maintained in the StatefulSet";
  type = (types.nullOr types.int);
  default = 10;
};
"rollingUpdatePartition" = mkOption {
  description = "Partition update strategy for Mariadb Secondary statefulset";
  type = (types.nullOr types.str);
  default = "";
};
"runtimeClassName" = mkOption {
  description = "Runtime Class for MariaDB secondary pods";
  type = (types.nullOr types.str);
  default = "";
};
"schedulerName" = mkOption {
  description = "Name of the k8s scheduler (other than default)";
  type = (types.nullOr types.str);
  default = "";
};
"service" = mkOption {
  type = SecondaryServiceModule;
  default = {  };
};
"sidecars" = mkOption {
  description = "Add additional sidecar containers for the MariaDB secondary pod(s)";
  type = (types.listOf types.anything);
  default = [  ];
};
"startupProbe" = mkOption {
  type = SecondaryStartupProbeModule;
  default = {  };
};
"startupWaitOptions" = mkOption {
  description = "Override default builtin startup wait check options for MariaDB secondary containers";
  type = (types.attrsOf types.anything);
  default = {  };
};
"tolerations" = mkOption {
  description = "Tolerations for MariaDB secondary pods assignment";
  type = (types.listOf types.anything);
  default = [  ];
};
"topologySpreadConstraints" = mkOption {
  description = "Topology Spread Constraints for MariaDB secondary pods assignment";
  type = (types.listOf types.anything);
  default = [  ];
};
"updateStrategy" = mkOption {
  type = SecondaryUpdateStrategyModule;
  default = {  };
};
  };
};
SecondaryNodeAffinityPresetModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "key" = mkOption {
  description = "MariaDB secondary node label key to match Ignored if `secondary.affinity` is set.";
  type = (types.nullOr types.str);
  default = "";
};
"type" = mkOption {
  description = "MariaDB secondary node affinity preset type. Ignored if `secondary.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "";
};
"values" = mkOption {
  description = "MariaDB secondary node label values to match. Ignored if `secondary.affinity` is set.";
  type = (types.listOf types.anything);
  default = [  ];
};
  };
};
SecondaryPdbModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "create" = mkOption {
  description = "Enable/disable a Pod Disruption Budget creation for MariaDB secondary pods";
  type = types.bool;
  default = true;
};
"maxUnavailable" = mkOption {
  description = "Maximum number/percentage of MariaDB secondary pods that may be made unavailable. Defaults to `1` if both `secondary.pdb.minAvailable` and `secondary.pdb.maxUnavailable` are empty.";
  type = (types.nullOr types.str);
  default = "";
};
"minAvailable" = mkOption {
  description = "Minimum number/percentage of MariaDB secondary pods that should remain scheduled";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
SecondaryPersistenceModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "accessModes" = mkOption {
  description = "MariaDB secondary persistent volume access Modes";
  type = (types.listOf types.str);
  default = [ "ReadWriteOnce" ];
};
"annotations" = mkOption {
  description = "MariaDB secondary persistent volume claim annotations";
  type = (types.attrsOf types.anything);
  default = {  };
};
"enabled" = mkOption {
  description = "Enable persistence on MariaDB secondary replicas using a `PersistentVolumeClaim`";
  type = types.bool;
  default = true;
};
"labels" = mkOption {
  description = "Labels for the PVC";
  type = (types.attrsOf types.anything);
  default = {  };
};
"selector" = mkOption {
  description = "Selector to match an existing Persistent Volume";
  type = (types.attrsOf types.anything);
  default = {  };
};
"size" = mkOption {
  description = "MariaDB secondary persistent volume size";
  type = (types.nullOr types.str);
  default = "8Gi";
};
"storageClass" = mkOption {
  description = "MariaDB secondary persistent volume storage Class";
  type = (types.nullOr types.str);
  default = "";
};
"subPath" = mkOption {
  description = "Subdirectory of the volume to mount at";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
SecondaryPodSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable security context for MariaDB secondary pods";
  type = types.bool;
  default = true;
};
"fsGroup" = mkOption {
  description = "Group ID for the mounted volumes' filesystem";
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
SecondaryReadinessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable readinessProbe";
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
  default = 30;
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
SecondaryServiceModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Provide any additional annotations which may be required";
  type = (types.attrsOf types.anything);
  default = {  };
};
"clusterIP" = mkOption {
  description = "MariaDB secondary Kubernetes service clusterIP IP";
  type = (types.nullOr types.str);
  default = "";
};
"externalTrafficPolicy" = mkOption {
  description = "Enable client source IP preservation";
  type = (types.nullOr types.str);
  default = "Cluster";
};
"extraPorts" = mkOption {
  description = "Extra ports to expose (normally used with the `sidecar` value)";
  type = (types.listOf types.anything);
  default = [  ];
};
"loadBalancerIP" = mkOption {
  description = "MariaDB secondary loadBalancerIP if service type is `LoadBalancer`";
  type = (types.nullOr types.str);
  default = "";
};
"loadBalancerSourceRanges" = mkOption {
  description = "Address that are allowed when MariaDB secondary service is LoadBalancer";
  type = (types.listOf types.anything);
  default = [  ];
};
"nodePorts" = mkOption {
  type = SecondaryServiceNodePortsModule;
  default = {  };
};
"ports" = mkOption {
  type = SecondaryServicePortsModule;
  default = {  };
};
"sessionAffinity" = mkOption {
  description = "Session Affinity for Kubernetes service, can be \"None\" or \"ClientIP\"";
  type = (types.nullOr types.str);
  default = "None";
};
"sessionAffinityConfig" = mkOption {
  description = "Additional settings for the sessionAffinity";
  type = (types.attrsOf types.anything);
  default = {  };
};
"type" = mkOption {
  description = "MariaDB secondary Kubernetes service type";
  type = (types.nullOr types.str);
  default = "ClusterIP";
};
  };
};
SecondaryServiceNodePortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "mysql" = mkOption {
  description = "MariaDB secondary Kubernetes service node port";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
SecondaryServicePortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "metrics" = mkOption {
  description = "MariaDB secondary Kubernetes service port for metrics";
  type = (types.nullOr types.int);
  default = 9104;
};
"mysql" = mkOption {
  description = "MariaDB secondary Kubernetes service port for MariaDB";
  type = (types.nullOr types.int);
  default = 3306;
};
  };
};
SecondaryStartupProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable startupProbe";
  type = types.bool;
  default = false;
};
"failureThreshold" = mkOption {
  description = "Failure threshold for startupProbe";
  type = (types.nullOr types.int);
  default = 10;
};
"initialDelaySeconds" = mkOption {
  description = "Initial delay seconds for startupProbe";
  type = (types.nullOr types.int);
  default = 120;
};
"periodSeconds" = mkOption {
  description = "Period seconds for startupProbe";
  type = (types.nullOr types.int);
  default = 15;
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
SecondaryUpdateStrategyModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "type" = mkOption {
  description = "MariaDB secondary statefulset strategy type";
  type = (types.nullOr types.str);
  default = "RollingUpdate";
};
  };
};
ServiceAccountModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Annotations for MariaDB Service Account";
  type = (types.attrsOf types.anything);
  default = {  };
};
"automountServiceAccountToken" = mkOption {
  description = "Automount service account token for the server service account";
  type = types.bool;
  default = false;
};
"create" = mkOption {
  description = "Enable the creation of a ServiceAccount for MariaDB pods";
  type = types.bool;
  default = true;
};
"name" = mkOption {
  description = "Name of the created ServiceAccount";
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
TdeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "ariaEncryptTables" = mkOption {
  description = "Enables automatic encryption of all Aria tablespaces (allowed values: ON, OFF | default: ON)";
  type = (types.nullOr types.str);
  default = "ON";
};
"enabled" = mkOption {
  description = "Enable Transparent Data Encryption using the File Key Management Encryption Plugin for MariaDB";
  type = types.bool;
  default = false;
};
"encryptBINLOG" = mkOption {
  description = "Enables encrypting binary logs including relay logs (allowed values: ON, OFF | default: ON)";
  type = (types.nullOr types.str);
  default = "ON";
};
"encryptTmpDiskTables" = mkOption {
  description = "Enables automatic encryption of all internal on-disk temporary tables that are created during query execution (allowed values: ON, OFF | default: ON)";
  type = (types.nullOr types.str);
  default = "ON";
};
"encryptTmpTiles" = mkOption {
  description = "Enables automatic encryption of temporary files, such as those created for filesort operations, binary log file caches, etc. (allowed values: ON, OFF | default: ON)";
  type = (types.nullOr types.str);
  default = "ON";
};
"encryptedKeyFilename" = mkOption {
  description = "File name of the 'encrypted keyfile' when it is different from the default (keyfile.enc), is also used for key name in the existingSecret";
  type = (types.nullOr types.str);
  default = "keyfile.enc";
};
"existingSecret" = mkOption {
  description = "Existing secret that contains Transparent Data Encryption key files used when secretsStoreProvider is not enabled";
  type = (types.nullOr types.str);
  default = "";
};
"fileKeyManagementEncryptionAlgorithm" = mkOption {
  description = "Encryption algorithm used for encrypting data (allowed values: AES_CTR, AES_CBC | default: AES_CTR)";
  type = (types.nullOr types.str);
  default = "AES_CTR";
};
"innodbEncryptLog" = mkOption {
  description = "Enables encryption of the InnoDB redo log (allowed values: ON, OFF | default: ON)";
  type = (types.nullOr types.str);
  default = "ON";
};
"innodbEncryptTables" = mkOption {
  description = "Enables automatic encryption of all InnoDB tablespaces (allowed values: FORCE, ON, OFF | default: FORCE)";
  type = (types.nullOr types.str);
  default = "FORCE";
};
"innodbEncryptTemporaryTables" = mkOption {
  description = "Enables automatic encryption of the InnoDB temporary tablespace (allowed values: ON, OFF | default: ON)";
  type = (types.nullOr types.str);
  default = "ON";
};
"innodbEncryptionThreads" = mkOption {
  description = "Number of threads to use for encryption (default: 4)";
  type = (types.nullOr types.int);
  default = 4;
};
"randomKeyFilename" = mkOption {
  description = "File name of the 'random keyfile' when it is different from the default (keyfile.key), is also used for key name in the existingSecret";
  type = (types.nullOr types.str);
  default = "keyfile.key";
};
"secretsStoreProvider" = mkOption {
  type = TdeSecretsStoreProviderModule;
  default = {  };
};
  };
};
TdeSecretsStoreProviderModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable use of secrets store provider for Transparent Data Encryption key files";
  type = types.bool;
  default = false;
};
"provider" = mkOption {
  description = "Type of provider used in secrets store provider class (allowed values: vault)";
  type = (types.nullOr types.str);
  default = "vault";
};
"vault" = mkOption {
  type = TdeSecretsStoreProviderVaultModule;
  default = {  };
};
  };
};
TdeSecretsStoreProviderVaultModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "address" = mkOption {
  description = "The URL of the HashiCorp Vault server (only for `vault` provider)";
  type = (types.nullOr types.str);
  default = "";
};
"authMountPath" = mkOption {
  description = "The HashiCorp Vault auth mount path (only for `vault` provider)";
  type = (types.nullOr types.str);
  default = "";
};
"encryptedKeySecretKey" = mkOption {
  description = "The HashiCorp Vault secret key for the 'encrypted keyfile' (only for `vault` provider)";
  type = (types.nullOr types.str);
  default = "";
};
"encryptedKeySecretPath" = mkOption {
  description = "The HashiCorp Vault secret path for the 'encrypted keyfile' (only for `vault` provider)";
  type = (types.nullOr types.str);
  default = "";
};
"randomKeySecretKey" = mkOption {
  description = "The HashiCorp Vault secret key for the 'random keyfile' (only for `vault` provider)";
  type = (types.nullOr types.str);
  default = "";
};
"randomKeySecretPath" = mkOption {
  description = "The HashiCorp Vault secret path for the 'random keyfile' (only for `vault` provider)";
  type = (types.nullOr types.str);
  default = "";
};
"roleName" = mkOption {
  description = "The name of the HashiCorp Vault role used for accessing the key files (only for `vault` provider)";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
TlsAutoGeneratedCertManagerModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "duration" = mkOption {
  description = "Duration for the certificates (only for `cert-manager` engine)";
  type = (types.nullOr types.str);
  default = "2160h";
};
"existingIssuer" = mkOption {
  description = "The name of an existing Issuer to use for generating the certificates (only for `cert-manager` engine)";
  type = (types.nullOr types.str);
  default = "";
};
"existingIssuerKind" = mkOption {
  description = "Existing Issuer kind, defaults to Issuer (only for `cert-manager` engine)";
  type = (types.nullOr types.str);
  default = "";
};
"keyAlgorithm" = mkOption {
  description = "Key algorithm for the certificates (only for `cert-manager` engine)";
  type = (types.nullOr types.str);
  default = "RSA";
};
"keySize" = mkOption {
  description = "Key size for the certificates (only for `cert-manager` engine)";
  type = (types.nullOr types.int);
  default = 2048;
};
"renewBefore" = mkOption {
  description = "Renewal period for the certificates (only for `cert-manager` engine)";
  type = (types.nullOr types.str);
  default = "360h";
};
  };
};
TlsAutoGeneratedModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "certManager" = mkOption {
  type = TlsAutoGeneratedCertManagerModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Enable automatic generation of certificates for TLS";
  type = types.bool;
  default = true;
};
"engine" = mkOption {
  description = "Mechanism to generate the certificates (allowed values: helm, cert-manager)";
  type = (types.nullOr types.str);
  default = "helm";
};
  };
};
TlsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "autoGenerated" = mkOption {
  type = TlsAutoGeneratedModule;
  default = {  };
};
"ca" = mkOption {
  description = "CA certificate for TLS. Ignored if `tls.existingSecret` is set";
  type = (types.nullOr types.str);
  default = "";
};
"cert" = mkOption {
  description = "TLS certificate. Ignored if `tls.master.existingSecret` is set";
  type = (types.nullOr types.str);
  default = "";
};
"certCAFilename" = mkOption {
  description = "The secret key from the existingSecret if 'ca' key different from the default (tls.crt)";
  type = (types.nullOr types.str);
  default = "";
};
"certFilename" = mkOption {
  description = "The secret key from the existingSecret if 'cert' key different from the default (tls.crt)";
  type = (types.nullOr types.str);
  default = "tls.crt";
};
"certKeyFilename" = mkOption {
  description = "The secret key from the existingSecret if 'key' key different from the default (tls.key)";
  type = (types.nullOr types.str);
  default = "tls.key";
};
"enabled" = mkOption {
  description = "Enable TLS in MariaDB";
  type = types.bool;
  default = false;
};
"existingSecret" = mkOption {
  description = "Existing secret that contains TLS certificates";
  type = (types.nullOr types.str);
  default = "";
};
"key" = mkOption {
  description = "TLS key. Ignored if `tls.master.existingSecret` is set";
  type = (types.nullOr types.str);
  default = "";
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
  default = "REGISTRY_NAME";
};
"repository" = mkOption {
  description = "Init container volume-permissions image repository";
  type = (types.nullOr types.str);
  default = "REPOSITORY_NAME/os-shell";
};
  };
};
VolumePermissionsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable init container that changes the owner and group of the persistent volume(s) mountpoint to `runAsUser:fsGroup`";
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
  description = "MariaDB architecture (`standalone` or `replication`)";
  type = (types.nullOr types.str);
  default = "standalone";
};
"auth" = mkOption {
  type = AuthModule;
  default = {  };
};
"clusterDomain" = mkOption {
  description = "Default Kubernetes cluster domain";
  type = (types.nullOr types.str);
  default = "cluster.local";
};
"commonAnnotations" = mkOption {
  description = "Common annotations to add to all MariaDB resources (sub-charts are not considered)";
  type = (types.attrsOf types.anything);
  default = {  };
};
"commonLabels" = mkOption {
  description = "Common labels to add to all MariaDB resources (sub-charts are not considered)";
  type = (types.attrsOf types.anything);
  default = {  };
};
"diagnosticMode" = mkOption {
  type = DiagnosticModeModule;
  default = {  };
};
"extraDeploy" = mkOption {
  description = "Array of extra objects to deploy with the release (evaluated as a template)";
  type = (types.listOf types.anything);
  default = [  ];
};
"fullnameOverride" = mkOption {
  description = "String to fully override mariadb.fullname";
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
"initdbScripts" = mkOption {
  description = "Dictionary of initdb scripts";
  type = (types.attrsOf types.anything);
  default = {  };
};
"initdbScriptsConfigMap" = mkOption {
  description = "ConfigMap with the initdb scripts (Note: Overrides `initdbScripts`)";
  type = (types.nullOr types.str);
  default = "";
};
"kubeVersion" = mkOption {
  description = "Force target Kubernetes version (using Helm capabilities if not set)";
  type = (types.nullOr types.str);
  default = "";
};
"metrics" = mkOption {
  type = MetricsModule;
  default = {  };
};
"nameOverride" = mkOption {
  description = "String to partially override mariadb.fullname";
  type = (types.nullOr types.str);
  default = "";
};
"networkPolicy" = mkOption {
  type = NetworkPolicyModule;
  default = {  };
};
"passwordUpdateJob" = mkOption {
  type = PasswordUpdateJobModule;
  default = {  };
};
"primary" = mkOption {
  type = PrimaryModule;
  default = {  };
};
"rbac" = mkOption {
  type = RbacModule;
  default = {  };
};
"runtimeClassName" = mkOption {
  description = "Name of the Runtime Class for all MariaDB pods";
  type = (types.nullOr types.str);
  default = "";
};
"schedulerName" = mkOption {
  description = "Name of the scheduler (other than default) to dispatch pods";
  type = (types.nullOr types.str);
  default = "";
};
"secondary" = mkOption {
  type = SecondaryModule;
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
"tde" = mkOption {
  type = TdeModule;
  default = {  };
};
"tls" = mkOption {
  type = TlsModule;
  default = {  };
};
"volumePermissions" = mkOption {
  type = VolumePermissionsModule;
  default = {  };
};
  };
}
