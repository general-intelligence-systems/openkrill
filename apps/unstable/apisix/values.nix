# Auto-generated from Bitnami values.schema.json
# Do not edit — regenerate with bin/create-module-bitnami
{ lib, ... }:
with lib;
let
  ControlPlaneAutoscalingHpaModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable HPA for APISIX Data Plane";
  type = types.bool;
  default = false;
};
"maxReplicas" = mkOption {
  description = "Maximum number of APISIX Data Plane replicas";
  type = (types.nullOr types.str);
  default = "";
};
"minReplicas" = mkOption {
  description = "Minimum number of APISIX Data Plane replicas";
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
ControlPlaneAutoscalingModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "hpa" = mkOption {
  type = ControlPlaneAutoscalingHpaModule;
  default = {  };
};
"vpa" = mkOption {
  type = ControlPlaneAutoscalingVpaModule;
  default = {  };
};
  };
};
ControlPlaneAutoscalingVpaModule = types.submodule {
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
  type = ControlPlaneAutoscalingVpaUpdatePolicyModule;
  default = {  };
};
  };
};
ControlPlaneAutoscalingVpaUpdatePolicyModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "updateMode" = mkOption {
  description = "Autoscaling update policy Specifies whether recommended updates are applied when a Pod is started and whether recommended updates are applied during the life of a Pod";
  type = (types.nullOr types.str);
  default = "Auto";
};
  };
};
ControlPlaneContainerPortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "adminAPI" = mkOption {
  description = "APISIX Admin API port";
  type = (types.nullOr types.int);
  default = 9180;
};
"configServer" = mkOption {
  description = "APISIX config port";
  type = (types.nullOr types.int);
  default = 9280;
};
"control" = mkOption {
  description = "APISIX control port";
  type = (types.nullOr types.int);
  default = 9090;
};
"metrics" = mkOption {
  description = "APISIX metrics port";
  type = (types.nullOr types.int);
  default = 9099;
};
  };
};
ControlPlaneContainerSecurityContextCapabilitiesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "drop" = mkOption {
  description = "Set APISIX container's Security Context runAsNonRoot";
  type = (types.listOf types.str);
  default = [ "ALL" ];
};
  };
};
ControlPlaneContainerSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "allowPrivilegeEscalation" = mkOption {
  description = "Set APISIX container's privilege escalation";
  type = types.bool;
  default = false;
};
"capabilities" = mkOption {
  type = ControlPlaneContainerSecurityContextCapabilitiesModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Enabled APISIX containers' Security Context";
  type = types.bool;
  default = true;
};
"readOnlyRootFilesystem" = mkOption {
  description = "Set APISIX containers' Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsNonRoot" = mkOption {
  description = "Set APISIX containers' Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsUser" = mkOption {
  description = "Set APISIX containers' Security Context runAsUser";
  type = (types.nullOr types.int);
  default = 1001;
};
  };
};
ControlPlaneIngressModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations.";
  type = (types.attrsOf types.anything);
  default = {  };
};
"apiVersion" = mkOption {
  description = "Force Ingress API version (automatically detected if not set)";
  type = (types.nullOr types.str);
  default = "";
};
"enabled" = mkOption {
  description = "Enable ingress record generation for APISIX";
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
  type = types.anything;
  default = [  ];
};
"extraTls" = mkOption {
  description = "TLS configuration for additional hostname(s) to be covered with this ingress record";
  type = types.anything;
  default = [  ];
};
"hostname" = mkOption {
  description = "Default host for the ingress record";
  type = (types.nullOr types.str);
  default = "apisix-control-plane.local";
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
  description = "Enable TLS configuration for the host defined at `controlPlane.ingress.hostname` parameter";
  type = types.bool;
  default = false;
};
  };
};
ControlPlaneLivenessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable livenessProbe on APISIX containers";
  type = types.bool;
  default = false;
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
ControlPlaneMetricsAnnotationsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "prometheus" = mkOption {
  type = ControlPlaneMetricsAnnotationsPrometheusModule;
  default = {  };
};
  };
};
ControlPlaneMetricsAnnotationsPrometheusModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "io/path" = mkOption {
  type = (types.nullOr types.str);
  default = "/apisix/prometheus/metrics";
};
"io/port" = mkOption {
  type = (types.nullOr types.str);
  default = "";
};
"io/scrape" = mkOption {
  type = (types.nullOr types.str);
  default = "true";
};
  };
};
ControlPlaneMetricsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  type = ControlPlaneMetricsAnnotationsModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Enable the export of Prometheus metrics";
  type = types.bool;
  default = false;
};
"serviceMonitor" = mkOption {
  type = ControlPlaneMetricsServiceMonitorModule;
  default = {  };
};
  };
};
ControlPlaneMetricsServiceMonitorModule = types.submodule {
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
  type = types.anything;
  default = [  ];
};
"namespace" = mkOption {
  description = "Namespace in which Prometheus is running";
  type = (types.nullOr types.str);
  default = "";
};
"relabelings" = mkOption {
  description = "Specify general relabeling";
  type = types.anything;
  default = [  ];
};
"scrapeTimeout" = mkOption {
  description = "Timeout after which the scrape is ended";
  type = (types.nullOr types.str);
  default = "";
};
"selector" = mkOption {
  description = "Prometheus instance selector labels";
  type = types.anything;
  default = {  };
};
  };
};
ControlPlaneModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "affinity" = mkOption {
  description = "Affinity for APISIX pods assignment";
  type = types.anything;
  default = {  };
};
"apiTokenAdmin" = mkOption {
  description = "Admin API Token for APISIX control plane";
  type = (types.nullOr types.str);
  default = "";
};
"apiTokenViewer" = mkOption {
  description = "Viewer API Token for APISIX control plane";
  type = (types.nullOr types.str);
  default = "";
};
"args" = mkOption {
  description = "Override default container args (useful when using custom images)";
  type = types.anything;
  default = [  ];
};
"autoscaling" = mkOption {
  type = ControlPlaneAutoscalingModule;
  default = {  };
};
"command" = mkOption {
  description = "Override default container command (useful when using custom images)";
  type = types.anything;
  default = [  ];
};
"containerPorts" = mkOption {
  type = ControlPlaneContainerPortsModule;
  default = {  };
};
"containerSecurityContext" = mkOption {
  type = ControlPlaneContainerSecurityContextModule;
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
"defaultConfig" = mkOption {
  description = "APISIX apisix configuration (evaluated as a template)";
  type = (types.nullOr types.str);
  default = "";
};
"dnsPolicy" = mkOption {
  description = "DNS policy for controlPlane pods";
  type = (types.nullOr types.str);
  default = "ClusterFirst";
};
"enabled" = mkOption {
  description = "Enable APISIX";
  type = types.bool;
  default = true;
};
"existingConfigMap" = mkOption {
  description = "name of a ConfigMap with existing configuration for the apisix";
  type = (types.nullOr types.str);
  default = "";
};
"existingSecret" = mkOption {
  description = "Name of a secret containing API Tokens for APISIX control plane";
  type = (types.nullOr types.str);
  default = "";
};
"existingSecretAdminTokenKey" = mkOption {
  description = "Key inside the secret containing the Admin API Tokens for APISIX control plane";
  type = (types.nullOr types.str);
  default = "";
};
"existingSecretViewerTokenKey" = mkOption {
  description = "Key inside the secret containing the Viewer API Tokens for APISIX control plane";
  type = (types.nullOr types.str);
  default = "";
};
"extraConfigExistingConfigMap" = mkOption {
  description = "name of a ConfigMap with existing configuration for the conrol plane";
  type = (types.nullOr types.str);
  default = "";
};
"extraEnvVars" = mkOption {
  description = "Array with extra environment variables to add to APISIX nodes";
  type = types.anything;
  default = [  ];
};
"extraEnvVarsCM" = mkOption {
  description = "Name of existing ConfigMap containing extra env vars for APISIX nodes";
  type = (types.nullOr types.str);
  default = "";
};
"extraEnvVarsSecret" = mkOption {
  description = "Name of existing Secret containing extra env vars for APISIX nodes";
  type = (types.nullOr types.str);
  default = "";
};
"extraVolumeMounts" = mkOption {
  description = "Optionally specify extra list of additional volumeMounts for the APISIX container(s)";
  type = types.anything;
  default = [  ];
};
"extraVolumes" = mkOption {
  description = "Optionally specify extra list of additional volumes for the APISIX pod(s)";
  type = types.anything;
  default = [  ];
};
"hostAliases" = mkOption {
  description = "APISIX pods host aliases";
  type = types.anything;
  default = [  ];
};
"hostNetwork" = mkOption {
  description = "Use hostNetwork";
  type = types.bool;
  default = false;
};
"ingress" = mkOption {
  type = ControlPlaneIngressModule;
  default = {  };
};
"initContainers" = mkOption {
  description = "Add additional init containers to the APISIX pod(s)";
  type = types.anything;
  default = [  ];
};
"lifecycleHooks" = mkOption {
  description = "for the APISIX container(s) to automate configuration before or after startup";
  type = types.anything;
  default = {  };
};
"livenessProbe" = mkOption {
  type = ControlPlaneLivenessProbeModule;
  default = {  };
};
"metrics" = mkOption {
  type = ControlPlaneMetricsModule;
  default = {  };
};
"nodeAffinityPreset" = mkOption {
  type = ControlPlaneNodeAffinityPresetModule;
  default = {  };
};
"nodeSelector" = mkOption {
  description = "Node labels for APISIX pods assignment";
  type = types.anything;
  default = {  };
};
"pdb" = mkOption {
  type = ControlPlanePdbModule;
  default = {  };
};
"podAffinityPreset" = mkOption {
  description = "Pod affinity preset. Ignored if `apisix.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "";
};
"podAnnotations" = mkOption {
  description = "Annotations for APISIX pods";
  type = types.anything;
  default = {  };
};
"podAntiAffinityPreset" = mkOption {
  description = "Pod anti-affinity preset. Ignored if `apisix.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "soft";
};
"podLabels" = mkOption {
  description = "Extra labels for APISIX pods";
  type = (types.attrsOf types.anything);
  default = {  };
};
"podSecurityContext" = mkOption {
  type = ControlPlanePodSecurityContextModule;
  default = {  };
};
"priorityClassName" = mkOption {
  description = "APISIX pods' priorityClassName";
  type = (types.nullOr types.str);
  default = "";
};
"rbac" = mkOption {
  type = ControlPlaneRbacModule;
  default = {  };
};
"readinessProbe" = mkOption {
  type = ControlPlaneReadinessProbeModule;
  default = {  };
};
"replicaCount" = mkOption {
  description = "Number of APISIX replicas to deploy";
  type = (types.nullOr types.int);
  default = 1;
};
"resources" = mkOption {
  type = ControlPlaneResourcesModule;
  default = {  };
};
"schedulerName" = mkOption {
  description = "Name of the k8s scheduler (other than default) for APISIX pods";
  type = (types.nullOr types.str);
  default = "";
};
"service" = mkOption {
  type = ControlPlaneServiceModule;
  default = {  };
};
"serviceAccount" = mkOption {
  type = ControlPlaneServiceAccountModule;
  default = {  };
};
"sidecars" = mkOption {
  description = "Add additional sidecar containers to the APISIX pod(s)";
  type = types.anything;
  default = [  ];
};
"startupProbe" = mkOption {
  type = ControlPlaneStartupProbeModule;
  default = {  };
};
"terminationGracePeriodSeconds" = mkOption {
  description = "Seconds Redmine pod needs to terminate gracefully";
  type = (types.nullOr types.str);
  default = "";
};
"tls" = mkOption {
  type = ControlPlaneTlsModule;
  default = {  };
};
"tolerations" = mkOption {
  description = "Tolerations for APISIX pods assignment";
  type = types.anything;
  default = [  ];
};
"topologySpreadConstraints" = mkOption {
  description = "Topology Spread Constraints for pod assignment spread across your cluster among failure-domains. Evaluated as a template";
  type = types.anything;
  default = [  ];
};
"updateStrategy" = mkOption {
  type = ControlPlaneUpdateStrategyModule;
  default = {  };
};
"useDaemonSet" = mkOption {
  description = "Deploy as DaemonSet";
  type = types.bool;
  default = false;
};
  };
};
ControlPlaneNodeAffinityPresetModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "key" = mkOption {
  description = "Node label key to match. Ignored if `apisix.affinity` is set";
  type = (types.nullOr types.str);
  default = "";
};
"type" = mkOption {
  description = "Node affinity preset type. Ignored if `apisix.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "";
};
"values" = mkOption {
  description = "Node label values to match. Ignored if `apisix.affinity` is set";
  type = (types.listOf types.anything);
  default = [  ];
};
  };
};
ControlPlanePdbModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "create" = mkOption {
  description = "Enable/disable a Pod Disruption Budget creation";
  type = types.bool;
  default = false;
};
"maxUnavailable" = mkOption {
  description = "Maximum number/percentage of pods that may be made unavailable";
  type = types.anything;
  default = "";
};
"minAvailable" = mkOption {
  description = "Minimum number/percentage of pods that should remain scheduled";
  type = types.anything;
  default = 1;
};
  };
};
ControlPlanePodSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enabled APISIX pods' Security Context";
  type = types.bool;
  default = true;
};
"fsGroup" = mkOption {
  description = "Set APISIX pod's Security Context fsGroup";
  type = (types.nullOr types.int);
  default = 1001;
};
"seccompProfile" = mkOption {
  type = ControlPlanePodSecurityContextSeccompProfileModule;
  default = {  };
};
  };
};
ControlPlanePodSecurityContextSeccompProfileModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "type" = mkOption {
  description = "Set APISIX container's Security Context seccomp profile";
  type = (types.nullOr types.str);
  default = "RuntimeDefault";
};
  };
};
ControlPlaneRbacModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "create" = mkOption {
  description = "Specifies whether RBAC resources should be created";
  type = types.bool;
  default = true;
};
"rules" = mkOption {
  description = "Custom RBAC rules to set";
  type = types.anything;
  default = [  ];
};
  };
};
ControlPlaneReadinessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable readinessProbe on APISIX containers";
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
ControlPlaneResourcesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "limits" = mkOption {
  description = "The resources limits for the APISIX containers";
  type = (types.attrsOf types.anything);
  default = {  };
};
"requests" = mkOption {
  description = "The requested resources for the APISIX containers";
  type = (types.attrsOf types.anything);
  default = {  };
};
  };
};
ControlPlaneServiceAccountModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Additional Service Account annotations (evaluated as a template)";
  type = (types.attrsOf types.anything);
  default = {  };
};
"automountServiceAccountToken" = mkOption {
  description = "Automount service account token for the apisix service account";
  type = types.bool;
  default = true;
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
ControlPlaneServiceModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Additional custom annotations for APISIX service";
  type = (types.attrsOf types.anything);
  default = {  };
};
"clusterIP" = mkOption {
  description = "APISIX service Cluster IP";
  type = (types.nullOr types.str);
  default = "";
};
"externalTrafficPolicy" = mkOption {
  description = "APISIX service external traffic policy";
  type = (types.nullOr types.str);
  default = "Cluster";
};
"extraPorts" = mkOption {
  description = "Extra ports to expose in APISIX service (normally used with the `sidecars` value)";
  type = types.anything;
  default = [  ];
};
"loadBalancerIP" = mkOption {
  description = "APISIX service Load Balancer IP";
  type = (types.nullOr types.str);
  default = "";
};
"loadBalancerSourceRanges" = mkOption {
  description = "APISIX service Load Balancer sources";
  type = (types.listOf types.anything);
  default = [  ];
};
"nodePorts" = mkOption {
  type = ControlPlaneServiceNodePortsModule;
  default = {  };
};
"ports" = mkOption {
  type = ControlPlaneServicePortsModule;
  default = {  };
};
"sessionAffinity" = mkOption {
  description = "Control where web requests go, to the same pod or round-robin";
  type = (types.nullOr types.str);
  default = "None";
};
"sessionAffinityConfig" = mkOption {
  description = "Additional settings for the sessionAffinity";
  type = types.anything;
  default = {  };
};
"type" = mkOption {
  description = "APISIX service type";
  type = (types.nullOr types.str);
  default = "ClusterIP";
};
  };
};
ControlPlaneServiceNodePortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "adminAPI" = mkOption {
  description = "Node port for Admin API";
  type = (types.nullOr types.str);
  default = "";
};
"configServer" = mkOption {
  description = "Node port for Config Server";
  type = (types.nullOr types.str);
  default = "";
};
"metrics" = mkOption {
  description = "Node port for Metrics";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
ControlPlaneServicePortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "adminAPI" = mkOption {
  description = "APISIX service Admin API port";
  type = (types.nullOr types.int);
  default = 9180;
};
"configServer" = mkOption {
  description = "APISIX service Config Server port";
  type = (types.nullOr types.int);
  default = 9280;
};
"metrics" = mkOption {
  description = "APISIX service metrics port";
  type = (types.nullOr types.int);
  default = 8080;
};
  };
};
ControlPlaneStartupProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable startupProbe on APISIX containers";
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
ControlPlaneTlsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "autoGenerated" = mkOption {
  description = "Auto-generate self-signed certificates";
  type = types.bool;
  default = true;
};
"ca" = mkOption {
  description = "Content of the certificate CA to be added to the secret";
  type = (types.nullOr types.str);
  default = "";
};
"cert" = mkOption {
  description = "Content of the certificate to be added to the secret";
  type = (types.nullOr types.str);
  default = "";
};
"certCAFilename" = mkOption {
  description = "Path of the certificate CA file when mounted as a secret";
  type = (types.nullOr types.str);
  default = "ca.crt";
};
"certFilename" = mkOption {
  description = "Path of the certificate file when mounted as a secret";
  type = (types.nullOr types.str);
  default = "tls.crt";
};
"certKeyFilename" = mkOption {
  description = "Path of the certificate key file when mounted as a secret";
  type = (types.nullOr types.str);
  default = "tls.key";
};
"enabled" = mkOption {
  description = "Enable TLS transport in Control Plane";
  type = types.bool;
  default = true;
};
"existingSecret" = mkOption {
  description = "Name of a secret containing the certificates";
  type = (types.nullOr types.str);
  default = "";
};
"key" = mkOption {
  description = "Content of the certificate key to be added to the secret";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
ControlPlaneUpdateStrategyModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "type" = mkOption {
  description = "APISIX statefulset strategy type";
  type = (types.nullOr types.str);
  default = "RollingUpdate";
};
  };
};
DataPlaneAutoscalingHpaModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable HPA for APISIX Data Plane";
  type = types.bool;
  default = false;
};
"maxReplicas" = mkOption {
  description = "Maximum number of APISIX Data Plane replicas";
  type = (types.nullOr types.str);
  default = "";
};
"minReplicas" = mkOption {
  description = "Minimum number of APISIX Data Plane replicas";
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
DataPlaneAutoscalingModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "hpa" = mkOption {
  type = DataPlaneAutoscalingHpaModule;
  default = {  };
};
"vpa" = mkOption {
  type = DataPlaneAutoscalingVpaModule;
  default = {  };
};
  };
};
DataPlaneAutoscalingVpaModule = types.submodule {
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
  type = DataPlaneAutoscalingVpaUpdatePolicyModule;
  default = {  };
};
  };
};
DataPlaneAutoscalingVpaUpdatePolicyModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "updateMode" = mkOption {
  description = "Autoscaling update policy Specifies whether recommended updates are applied when a Pod is started and whether recommended updates are applied during the life of a Pod";
  type = (types.nullOr types.str);
  default = "Auto";
};
  };
};
DataPlaneContainerPortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "control" = mkOption {
  description = "APISIX control container port";
  type = (types.nullOr types.int);
  default = 9090;
};
"http" = mkOption {
  description = "APISIX HTTP container port";
  type = (types.nullOr types.int);
  default = 9080;
};
"https" = mkOption {
  description = "APISIX HTTPS container port";
  type = (types.nullOr types.int);
  default = 9443;
};
"metrics" = mkOption {
  description = "APISIX metrics container port";
  type = (types.nullOr types.int);
  default = 9099;
};
  };
};
DataPlaneContainerSecurityContextCapabilitiesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "drop" = mkOption {
  description = "Set APISIX container's Security Context runAsNonRoot";
  type = (types.listOf types.str);
  default = [ "ALL" ];
};
  };
};
DataPlaneContainerSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "allowPrivilegeEscalation" = mkOption {
  description = "Set APISIX container's privilege escalation";
  type = types.bool;
  default = false;
};
"capabilities" = mkOption {
  type = DataPlaneContainerSecurityContextCapabilitiesModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Enabled APISIX containers' Security Context";
  type = types.bool;
  default = true;
};
"readOnlyRootFilesystem" = mkOption {
  description = "Set APISIX containers' Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsNonRoot" = mkOption {
  description = "Set APISIX containers' Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsUser" = mkOption {
  description = "Set APISIX containers' Security Context runAsUser";
  type = (types.nullOr types.int);
  default = 1001;
};
  };
};
DataPlaneIngressModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations.";
  type = (types.attrsOf types.anything);
  default = {  };
};
"apiVersion" = mkOption {
  description = "Force Ingress API version (automatically detected if not set)";
  type = (types.nullOr types.str);
  default = "";
};
"enabled" = mkOption {
  description = "Enable ingress record generation for APISIX";
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
  type = types.anything;
  default = [  ];
};
"extraTls" = mkOption {
  description = "TLS configuration for additional hostname(s) to be covered with this ingress record";
  type = types.anything;
  default = [  ];
};
"hostname" = mkOption {
  description = "Default host for the ingress record";
  type = (types.nullOr types.str);
  default = "apisix-data-plane.local";
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
  description = "Enable TLS configuration for the host defined at `dataPlane.ingress.hostname` parameter";
  type = types.bool;
  default = false;
};
  };
};
DataPlaneLivenessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable livenessProbe on APISIX containers";
  type = types.bool;
  default = false;
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
DataPlaneMetricsAnnotationsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "prometheus" = mkOption {
  type = DataPlaneMetricsAnnotationsPrometheusModule;
  default = {  };
};
  };
};
DataPlaneMetricsAnnotationsPrometheusModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "io/path" = mkOption {
  type = (types.nullOr types.str);
  default = "/apisix/prometheus/metrics";
};
"io/port" = mkOption {
  type = (types.nullOr types.str);
  default = "";
};
"io/scrape" = mkOption {
  type = (types.nullOr types.str);
  default = "true";
};
  };
};
DataPlaneMetricsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  type = DataPlaneMetricsAnnotationsModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Enable the export of Prometheus metrics";
  type = types.bool;
  default = false;
};
"serviceMonitor" = mkOption {
  type = DataPlaneMetricsServiceMonitorModule;
  default = {  };
};
  };
};
DataPlaneMetricsServiceMonitorModule = types.submodule {
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
  type = types.anything;
  default = [  ];
};
"namespace" = mkOption {
  description = "Namespace in which Prometheus is running";
  type = (types.nullOr types.str);
  default = "";
};
"relabelings" = mkOption {
  description = "Specify general relabeling";
  type = types.anything;
  default = [  ];
};
"scrapeTimeout" = mkOption {
  description = "Timeout after which the scrape is ended";
  type = (types.nullOr types.str);
  default = "";
};
"selector" = mkOption {
  description = "Prometheus instance selector labels";
  type = types.anything;
  default = {  };
};
  };
};
DataPlaneModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "affinity" = mkOption {
  description = "Affinity for APISIX pods assignment";
  type = types.anything;
  default = {  };
};
"args" = mkOption {
  description = "Override default container args (useful when using custom images)";
  type = types.anything;
  default = [  ];
};
"autoscaling" = mkOption {
  type = DataPlaneAutoscalingModule;
  default = {  };
};
"command" = mkOption {
  description = "Override default container command (useful when using custom images)";
  type = types.anything;
  default = [  ];
};
"containerPorts" = mkOption {
  type = DataPlaneContainerPortsModule;
  default = {  };
};
"containerSecurityContext" = mkOption {
  type = DataPlaneContainerSecurityContextModule;
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
"defaultConfig" = mkOption {
  description = "APISIX apisix configuration (evaluated as a template)";
  type = (types.nullOr types.str);
  default = "";
};
"dnsPolicy" = mkOption {
  description = "DNS policy for dataPlane pods";
  type = (types.nullOr types.str);
  default = "ClusterFirstWithHostNet";
};
"enabled" = mkOption {
  description = "Enable APISIX";
  type = types.bool;
  default = true;
};
"existingConfigMap" = mkOption {
  description = "name of a ConfigMap with existing configuration for the apisix";
  type = (types.nullOr types.str);
  default = "";
};
"extraConfigExistingConfigMap" = mkOption {
  description = "name of a ConfigMap with existing configuration for the data plane";
  type = (types.nullOr types.str);
  default = "";
};
"extraEnvVars" = mkOption {
  description = "Array with extra environment variables to add to APISIX nodes";
  type = types.anything;
  default = [  ];
};
"extraEnvVarsCM" = mkOption {
  description = "Name of existing ConfigMap containing extra env vars for APISIX nodes";
  type = (types.nullOr types.str);
  default = "";
};
"extraEnvVarsSecret" = mkOption {
  description = "Name of existing Secret containing extra env vars for APISIX nodes";
  type = (types.nullOr types.str);
  default = "";
};
"extraVolumeMounts" = mkOption {
  description = "Optionally specify extra list of additional volumeMounts for the APISIX container(s)";
  type = types.anything;
  default = [  ];
};
"extraVolumes" = mkOption {
  description = "Optionally specify extra list of additional volumes for the APISIX pod(s)";
  type = types.anything;
  default = [  ];
};
"hostAliases" = mkOption {
  description = "APISIX pods host aliases";
  type = types.anything;
  default = [  ];
};
"hostNetwork" = mkOption {
  description = "Use hostNetwork";
  type = types.bool;
  default = false;
};
"ingress" = mkOption {
  type = DataPlaneIngressModule;
  default = {  };
};
"initContainers" = mkOption {
  description = "Add additional init containers to the APISIX pod(s)";
  type = types.anything;
  default = [  ];
};
"lifecycleHooks" = mkOption {
  description = "for the APISIX container(s) to automate configuration before or after startup";
  type = types.anything;
  default = {  };
};
"livenessProbe" = mkOption {
  type = DataPlaneLivenessProbeModule;
  default = {  };
};
"metrics" = mkOption {
  type = DataPlaneMetricsModule;
  default = {  };
};
"nodeAffinityPreset" = mkOption {
  type = DataPlaneNodeAffinityPresetModule;
  default = {  };
};
"nodeSelector" = mkOption {
  description = "Node labels for APISIX pods assignment";
  type = types.anything;
  default = {  };
};
"pdb" = mkOption {
  type = DataPlanePdbModule;
  default = {  };
};
"podAffinityPreset" = mkOption {
  description = "Pod affinity preset. Ignored if `apisix.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "";
};
"podAnnotations" = mkOption {
  description = "Annotations for APISIX pods";
  type = types.anything;
  default = {  };
};
"podAntiAffinityPreset" = mkOption {
  description = "Pod anti-affinity preset. Ignored if `apisix.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "soft";
};
"podLabels" = mkOption {
  description = "Extra labels for APISIX pods";
  type = (types.attrsOf types.anything);
  default = {  };
};
"podSecurityContext" = mkOption {
  type = DataPlanePodSecurityContextModule;
  default = {  };
};
"priorityClassName" = mkOption {
  description = "APISIX pods' priorityClassName";
  type = (types.nullOr types.str);
  default = "";
};
"rbac" = mkOption {
  type = DataPlaneRbacModule;
  default = {  };
};
"readinessProbe" = mkOption {
  type = DataPlaneReadinessProbeModule;
  default = {  };
};
"replicaCount" = mkOption {
  description = "Number of APISIX replicas to deploy";
  type = (types.nullOr types.int);
  default = 1;
};
"resources" = mkOption {
  type = DataPlaneResourcesModule;
  default = {  };
};
"schedulerName" = mkOption {
  description = "Name of the k8s scheduler (other than default) for APISIX pods";
  type = (types.nullOr types.str);
  default = "";
};
"service" = mkOption {
  type = DataPlaneServiceModule;
  default = {  };
};
"serviceAccount" = mkOption {
  type = DataPlaneServiceAccountModule;
  default = {  };
};
"sidecars" = mkOption {
  description = "Add additional sidecar containers to the APISIX pod(s)";
  type = types.anything;
  default = [  ];
};
"startupProbe" = mkOption {
  type = DataPlaneStartupProbeModule;
  default = {  };
};
"terminationGracePeriodSeconds" = mkOption {
  description = "Seconds Redmine pod needs to terminate gracefully";
  type = (types.nullOr types.str);
  default = "";
};
"tls" = mkOption {
  type = DataPlaneTlsModule;
  default = {  };
};
"tolerations" = mkOption {
  description = "Tolerations for APISIX pods assignment";
  type = types.anything;
  default = [  ];
};
"topologySpreadConstraints" = mkOption {
  description = "Topology Spread Constraints for pod assignment spread across your cluster among failure-domains. Evaluated as a template";
  type = types.anything;
  default = [  ];
};
"updateStrategy" = mkOption {
  type = DataPlaneUpdateStrategyModule;
  default = {  };
};
"useDaemonSet" = mkOption {
  description = "Deploy as DaemonSet";
  type = types.bool;
  default = false;
};
  };
};
DataPlaneNodeAffinityPresetModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "key" = mkOption {
  description = "Node label key to match. Ignored if `apisix.affinity` is set";
  type = (types.nullOr types.str);
  default = "";
};
"type" = mkOption {
  description = "Node affinity preset type. Ignored if `apisix.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "";
};
"values" = mkOption {
  description = "Node label values to match. Ignored if `apisix.affinity` is set";
  type = (types.listOf types.anything);
  default = [  ];
};
  };
};
DataPlanePdbModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "create" = mkOption {
  description = "Enable/disable a Pod Disruption Budget creation";
  type = types.bool;
  default = false;
};
"maxUnavailable" = mkOption {
  description = "Maximum number/percentage of pods that may be made unavailable";
  type = types.anything;
  default = "";
};
"minAvailable" = mkOption {
  description = "Minimum number/percentage of pods that should remain scheduled";
  type = types.anything;
  default = 1;
};
  };
};
DataPlanePodSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enabled APISIX pods' Security Context";
  type = types.bool;
  default = true;
};
"fsGroup" = mkOption {
  description = "Set APISIX pod's Security Context fsGroup";
  type = (types.nullOr types.int);
  default = 1001;
};
"seccompProfile" = mkOption {
  type = DataPlanePodSecurityContextSeccompProfileModule;
  default = {  };
};
  };
};
DataPlanePodSecurityContextSeccompProfileModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "type" = mkOption {
  description = "Set APISIX container's Security Context seccomp profile";
  type = (types.nullOr types.str);
  default = "RuntimeDefault";
};
  };
};
DataPlaneRbacModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "create" = mkOption {
  description = "Specifies whether RBAC resources should be created";
  type = types.bool;
  default = true;
};
"rules" = mkOption {
  description = "Custom RBAC rules to set";
  type = types.anything;
  default = [  ];
};
  };
};
DataPlaneReadinessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable readinessProbe on APISIX containers";
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
DataPlaneResourcesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "limits" = mkOption {
  description = "The resources limits for the APISIX containers";
  type = (types.attrsOf types.anything);
  default = {  };
};
"requests" = mkOption {
  description = "The requested resources for the APISIX containers";
  type = (types.attrsOf types.anything);
  default = {  };
};
  };
};
DataPlaneServiceAccountModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Additional Service Account annotations (evaluated as a template)";
  type = (types.attrsOf types.anything);
  default = {  };
};
"automountServiceAccountToken" = mkOption {
  description = "Automount service account token for the apisix service account";
  type = types.bool;
  default = true;
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
DataPlaneServiceModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Additional custom annotations for APISIX service";
  type = (types.attrsOf types.anything);
  default = {  };
};
"clusterIP" = mkOption {
  description = "APISIX service Cluster IP";
  type = (types.nullOr types.str);
  default = "";
};
"externalTrafficPolicy" = mkOption {
  description = "APISIX service external traffic policy";
  type = (types.nullOr types.str);
  default = "Cluster";
};
"extraPorts" = mkOption {
  description = "Extra ports to expose in APISIX service (normally used with the `sidecars` value)";
  type = types.anything;
  default = [  ];
};
"loadBalancerIP" = mkOption {
  description = "APISIX service Load Balancer IP";
  type = (types.nullOr types.str);
  default = "";
};
"loadBalancerSourceRanges" = mkOption {
  description = "APISIX service Load Balancer sources";
  type = (types.listOf types.anything);
  default = [  ];
};
"nodePorts" = mkOption {
  type = DataPlaneServiceNodePortsModule;
  default = {  };
};
"ports" = mkOption {
  type = DataPlaneServicePortsModule;
  default = {  };
};
"sessionAffinity" = mkOption {
  description = "Control where web requests go, to the same pod or round-robin";
  type = (types.nullOr types.str);
  default = "None";
};
"sessionAffinityConfig" = mkOption {
  description = "Additional settings for the sessionAffinity";
  type = types.anything;
  default = {  };
};
"type" = mkOption {
  description = "APISIX service type";
  type = (types.nullOr types.str);
  default = "LoadBalancer";
};
  };
};
DataPlaneServiceNodePortsModule = types.submodule {
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
"metrics" = mkOption {
  description = "Node port for metrics";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
DataPlaneServicePortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "http" = mkOption {
  description = "APISIX service HTTP port";
  type = (types.nullOr types.int);
  default = 80;
};
"https" = mkOption {
  description = "APISIX service HTTPS port";
  type = (types.nullOr types.int);
  default = 443;
};
"metrics" = mkOption {
  description = "APISIX service HTTPS port";
  type = (types.nullOr types.int);
  default = 8080;
};
  };
};
DataPlaneStartupProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable startupProbe on APISIX containers";
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
DataPlaneTlsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "autoGenerated" = mkOption {
  description = "Auto-generate self-signed certificates";
  type = types.bool;
  default = true;
};
"ca" = mkOption {
  description = "Content of the certificate CA to be added to the secret";
  type = (types.nullOr types.str);
  default = "";
};
"cert" = mkOption {
  description = "Content of the certificate to be added to the secret";
  type = (types.nullOr types.str);
  default = "";
};
"certCAFilename" = mkOption {
  description = "Path of the certificate CA file when mounted as a secret";
  type = (types.nullOr types.str);
  default = "ca.crt";
};
"certFilename" = mkOption {
  description = "Path of the certificate file when mounted as a secret";
  type = (types.nullOr types.str);
  default = "tls.crt";
};
"certKeyFilename" = mkOption {
  description = "Path of the certificate key file when mounted as a secret";
  type = (types.nullOr types.str);
  default = "tls.key";
};
"enabled" = mkOption {
  description = "Enable TLS transport in Data Plane";
  type = types.bool;
  default = true;
};
"existingSecret" = mkOption {
  description = "Name of a secret containing the certificates";
  type = (types.nullOr types.str);
  default = "";
};
"key" = mkOption {
  description = "Content of the certificate key to be added to the secret";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
DataPlaneUpdateStrategyModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "type" = mkOption {
  description = "APISIX statefulset strategy type";
  type = (types.nullOr types.str);
  default = "RollingUpdate";
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
EtcdAuthClientModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "secureTransport" = mkOption {
  description = "use TLS for client-to-server communications";
  type = types.bool;
  default = false;
};
  };
};
EtcdAuthModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "client" = mkOption {
  type = EtcdAuthClientModule;
  default = {  };
};
"rbac" = mkOption {
  type = EtcdAuthRbacModule;
  default = {  };
};
  };
};
EtcdAuthRbacModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "create" = mkOption {
  description = "Switch to enable RBAC authentication";
  type = types.bool;
  default = false;
};
"rootPassword" = mkOption {
  description = "etcd root password";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
EtcdContainerPortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "client" = mkOption {
  description = "Container port for etcd";
  type = (types.nullOr types.int);
  default = 2379;
};
  };
};
EtcdModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "auth" = mkOption {
  type = EtcdAuthModule;
  default = {  };
};
"containerPorts" = mkOption {
  type = EtcdContainerPortsModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Deploy etcd sub-chart";
  type = types.bool;
  default = true;
};
"replicaCount" = mkOption {
  description = "Number of etcd replicas";
  type = (types.nullOr types.int);
  default = 3;
};
  };
};
ExternalEtcdModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "existingSecret" = mkOption {
  description = "Name of a secret containing the external etcd password";
  type = (types.nullOr types.str);
  default = "";
};
"existingSecretPasswordKey" = mkOption {
  description = "Key inside the secret containing the external etcd password";
  type = (types.nullOr types.str);
  default = "etcd-root-password";
};
"password" = mkOption {
  description = "Password of the external etcd instance";
  type = (types.nullOr types.str);
  default = "";
};
"port" = mkOption {
  description = "Port of the external etcd instance";
  type = (types.nullOr types.int);
  default = 2379;
};
"secureTransport" = mkOption {
  description = "Use TLS for client-to-server communications";
  type = types.bool;
  default = false;
};
"servers" = mkOption {
  description = "List of hostnames of the external etcd";
  type = (types.listOf types.anything);
  default = [  ];
};
"user" = mkOption {
  description = "User of the external etcd instance";
  type = (types.nullOr types.str);
  default = "root";
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
  description = "Enable APISIX image debug mode";
  type = types.bool;
  default = false;
};
"digest" = mkOption {
  description = "APISIX image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag image tag (immutable tags are recommended)";
  type = (types.nullOr types.str);
  default = "";
};
"pullPolicy" = mkOption {
  description = "APISIX image pull policy";
  type = (types.nullOr types.str);
  default = "IfNotPresent";
};
"pullSecrets" = mkOption {
  description = "APISIX image pull secrets";
  type = (types.listOf types.anything);
  default = [  ];
};
"registry" = mkOption {
  description = "APISIX image registry";
  type = (types.nullOr types.str);
  default = "docker.io";
};
"repository" = mkOption {
  description = "APISIX image repository";
  type = (types.nullOr types.str);
  default = "bitnami/apisix";
};
"tag" = mkOption {
  description = "APISIX image tag (immutable tags are recommended)";
  type = (types.nullOr types.str);
  default = "3.3.0-debian-11-r3";
};
  };
};
IngressControllerAutoscalingHpaModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable HPA for APISIX Ingress Controller";
  type = types.bool;
  default = false;
};
"maxReplicas" = mkOption {
  description = "Maximum number of APISIX Ingress Controller replicas";
  type = (types.nullOr types.str);
  default = "";
};
"minReplicas" = mkOption {
  description = "Minimum number of APISIX Ingress Controller replicas";
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
IngressControllerAutoscalingModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "hpa" = mkOption {
  type = IngressControllerAutoscalingHpaModule;
  default = {  };
};
"vpa" = mkOption {
  type = IngressControllerAutoscalingVpaModule;
  default = {  };
};
  };
};
IngressControllerAutoscalingVpaModule = types.submodule {
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
  type = IngressControllerAutoscalingVpaUpdatePolicyModule;
  default = {  };
};
  };
};
IngressControllerAutoscalingVpaUpdatePolicyModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "updateMode" = mkOption {
  description = "Autoscaling update policy Specifies whether recommended updates are applied when a Pod is started and whether recommended updates are applied during the life of a Pod";
  type = (types.nullOr types.str);
  default = "Auto";
};
  };
};
IngressControllerContainerPortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "http" = mkOption {
  description = "APISIX Ingress Controller http container port";
  type = (types.nullOr types.int);
  default = 8080;
};
"https" = mkOption {
  description = "APISIX Ingress Controller https container port";
  type = (types.nullOr types.int);
  default = 8443;
};
  };
};
IngressControllerContainerSecurityContextCapabilitiesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "drop" = mkOption {
  description = "Set APISIX Ingress Controller container's Security Context runAsNonRoot";
  type = (types.listOf types.str);
  default = [ "ALL" ];
};
  };
};
IngressControllerContainerSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "allowPrivilegeEscalation" = mkOption {
  description = "Set APISIX Ingress Controller container's privilege escalation";
  type = types.bool;
  default = false;
};
"capabilities" = mkOption {
  type = IngressControllerContainerSecurityContextCapabilitiesModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Enabled APISIX Ingress Controller containers' Security Context";
  type = types.bool;
  default = true;
};
"readOnlyRootFilesystem" = mkOption {
  description = "Set APISIX Ingress Controller containers' Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsNonRoot" = mkOption {
  description = "Set APISIX Ingress Controller containers' Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsUser" = mkOption {
  description = "Set APISIX Ingress Controller containers' Security Context runAsUser";
  type = (types.nullOr types.int);
  default = 1001;
};
  };
};
IngressControllerImageModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "debug" = mkOption {
  description = "Enable APISIX Ingress Controller image debug mode";
  type = types.bool;
  default = false;
};
"digest" = mkOption {
  description = "APISIX Ingress Controller image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag image tag (immutable tags are recommended)";
  type = (types.nullOr types.str);
  default = "";
};
"pullPolicy" = mkOption {
  description = "APISIX Ingress Controller image pull policy";
  type = (types.nullOr types.str);
  default = "IfNotPresent";
};
"pullSecrets" = mkOption {
  description = "APISIX Ingress Controller image pull secrets";
  type = (types.listOf types.anything);
  default = [  ];
};
"registry" = mkOption {
  description = "APISIX Ingress Controller image registry";
  type = (types.nullOr types.str);
  default = "docker.io";
};
"repository" = mkOption {
  description = "APISIX Ingress Controller image repository";
  type = (types.nullOr types.str);
  default = "bitnami/apisix-ingress-controller";
};
"tag" = mkOption {
  description = "APISIX Ingress Controller image tag (immutable tags are recommended)";
  type = (types.nullOr types.str);
  default = "1.6.1-debian-11-r3";
};
  };
};
IngressControllerIngressModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations.";
  type = (types.attrsOf types.anything);
  default = {  };
};
"apiVersion" = mkOption {
  description = "Force Ingress API version (automatically detected if not set)";
  type = (types.nullOr types.str);
  default = "";
};
"enabled" = mkOption {
  description = "Enable ingress record generation for APISIX";
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
  type = types.anything;
  default = [  ];
};
"extraTls" = mkOption {
  description = "TLS configuration for additional hostname(s) to be covered with this ingress record";
  type = types.anything;
  default = [  ];
};
"hostname" = mkOption {
  description = "Default host for the ingress record";
  type = (types.nullOr types.str);
  default = "apisix-ingress-controller.local";
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
  description = "Enable TLS configuration for the host defined at `ingressController.ingress.hostname` parameter";
  type = types.bool;
  default = false;
};
  };
};
IngressControllerLivenessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable livenessProbe on APISIX Ingress Controller containers";
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
IngressControllerMetricsAnnotationsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "prometheus" = mkOption {
  type = IngressControllerMetricsAnnotationsPrometheusModule;
  default = {  };
};
  };
};
IngressControllerMetricsAnnotationsPrometheusModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "io/port" = mkOption {
  type = (types.nullOr types.str);
  default = "";
};
"io/scrape" = mkOption {
  type = (types.nullOr types.str);
  default = "true";
};
  };
};
IngressControllerMetricsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  type = IngressControllerMetricsAnnotationsModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Enable the export of Prometheus metrics";
  type = types.bool;
  default = false;
};
"serviceMonitor" = mkOption {
  type = IngressControllerMetricsServiceMonitorModule;
  default = {  };
};
  };
};
IngressControllerMetricsServiceMonitorModule = types.submodule {
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
  type = types.anything;
  default = [  ];
};
"namespace" = mkOption {
  description = "Namespace in which Prometheus is running";
  type = (types.nullOr types.str);
  default = "";
};
"relabelings" = mkOption {
  description = "Specify general relabeling";
  type = types.anything;
  default = [  ];
};
"scrapeTimeout" = mkOption {
  description = "Timeout after which the scrape is ended";
  type = (types.nullOr types.str);
  default = "";
};
"selector" = mkOption {
  description = "Prometheus instance selector labels";
  type = types.anything;
  default = {  };
};
  };
};
IngressControllerModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "affinity" = mkOption {
  description = "Affinity for APISIX Ingress Controller pods assignment";
  type = types.anything;
  default = {  };
};
"args" = mkOption {
  description = "Override default container args (useful when using custom images)";
  type = types.anything;
  default = [  ];
};
"autoscaling" = mkOption {
  type = IngressControllerAutoscalingModule;
  default = {  };
};
"command" = mkOption {
  description = "Override default container command (useful when using custom images)";
  type = types.anything;
  default = [  ];
};
"containerPorts" = mkOption {
  type = IngressControllerContainerPortsModule;
  default = {  };
};
"containerSecurityContext" = mkOption {
  type = IngressControllerContainerSecurityContextModule;
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
"defaultConfig" = mkOption {
  description = "APISIX Dashboard configuration (evaluated as a template)";
  type = (types.nullOr types.str);
  default = "";
};
"enabled" = mkOption {
  description = "Enable APISIX Ingress Controller";
  type = types.bool;
  default = true;
};
"existingConfigMap" = mkOption {
  description = "name of a ConfigMap with existing configuration for the Dashboard";
  type = (types.nullOr types.str);
  default = "";
};
"extraConfig" = mkOption {
  description = "Extra configuration parameters for APISIX Ingress Controller";
  type = types.anything;
  default = {  };
};
"extraConfigExistingConfigMap" = mkOption {
  description = "name of a ConfigMap with existing configuration for the Dashboard";
  type = (types.nullOr types.str);
  default = "";
};
"extraEnvVars" = mkOption {
  description = "Array with extra environment variables to add to APISIX Ingress Controller nodes";
  type = types.anything;
  default = [  ];
};
"extraEnvVarsCM" = mkOption {
  description = "Name of existing ConfigMap containing extra env vars for APISIX Ingress Controller nodes";
  type = (types.nullOr types.str);
  default = "";
};
"extraEnvVarsSecret" = mkOption {
  description = "Name of existing Secret containing extra env vars for APISIX Ingress Controller nodes";
  type = (types.nullOr types.str);
  default = "";
};
"extraVolumeMounts" = mkOption {
  description = "Optionally specify extra list of additional volumeMounts for the APISIX Ingress Controller container(s)";
  type = types.anything;
  default = [  ];
};
"extraVolumes" = mkOption {
  description = "Optionally specify extra list of additional volumes for the APISIX Ingress Controller pod(s)";
  type = types.anything;
  default = [  ];
};
"hostAliases" = mkOption {
  description = "APISIX Ingress Controller pods host aliases";
  type = types.anything;
  default = [  ];
};
"image" = mkOption {
  type = IngressControllerImageModule;
  default = {  };
};
"ingress" = mkOption {
  type = IngressControllerIngressModule;
  default = {  };
};
"initContainers" = mkOption {
  description = "Add additional init containers to the APISIX Ingress Controller pod(s)";
  type = types.anything;
  default = [  ];
};
"lifecycleHooks" = mkOption {
  description = "for the APISIX Ingress Controller container(s) to automate configuration before or after startup";
  type = types.anything;
  default = {  };
};
"livenessProbe" = mkOption {
  type = IngressControllerLivenessProbeModule;
  default = {  };
};
"metrics" = mkOption {
  type = IngressControllerMetricsModule;
  default = {  };
};
"nodeAffinityPreset" = mkOption {
  type = IngressControllerNodeAffinityPresetModule;
  default = {  };
};
"nodeSelector" = mkOption {
  description = "Node labels for APISIX Ingress Controller pods assignment";
  type = types.anything;
  default = {  };
};
"pdb" = mkOption {
  type = IngressControllerPdbModule;
  default = {  };
};
"podAffinityPreset" = mkOption {
  description = "Pod affinity preset. Ignored if `injector.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "";
};
"podAnnotations" = mkOption {
  description = "Annotations for APISIX Ingress Controller pods";
  type = types.anything;
  default = {  };
};
"podAntiAffinityPreset" = mkOption {
  description = "Pod anti-affinity preset. Ignored if `injector.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "soft";
};
"podLabels" = mkOption {
  description = "Extra labels for APISIX Ingress Controller pods";
  type = (types.attrsOf types.anything);
  default = {  };
};
"podSecurityContext" = mkOption {
  type = IngressControllerPodSecurityContextModule;
  default = {  };
};
"priorityClassName" = mkOption {
  description = "APISIX Ingress Controller pods' priorityClassName";
  type = (types.nullOr types.str);
  default = "";
};
"rbac" = mkOption {
  type = IngressControllerRbacModule;
  default = {  };
};
"readinessProbe" = mkOption {
  type = IngressControllerReadinessProbeModule;
  default = {  };
};
"replicaCount" = mkOption {
  description = "Number of APISIX Ingress Controller replicas to deploy";
  type = (types.nullOr types.int);
  default = 1;
};
"resources" = mkOption {
  type = IngressControllerResourcesModule;
  default = {  };
};
"schedulerName" = mkOption {
  description = "Name of the k8s scheduler (other than default) for APISIX Ingress Controller pods";
  type = (types.nullOr types.str);
  default = "";
};
"service" = mkOption {
  type = IngressControllerServiceModule;
  default = {  };
};
"serviceAccount" = mkOption {
  type = IngressControllerServiceAccountModule;
  default = {  };
};
"sidecars" = mkOption {
  description = "Add additional sidecar containers to the APISIX Ingress Controller pod(s)";
  type = types.anything;
  default = [  ];
};
"startupProbe" = mkOption {
  type = IngressControllerStartupProbeModule;
  default = {  };
};
"terminationGracePeriodSeconds" = mkOption {
  description = "Seconds Redmine pod needs to terminate gracefully";
  type = (types.nullOr types.str);
  default = "";
};
"tls" = mkOption {
  type = IngressControllerTlsModule;
  default = {  };
};
"tolerations" = mkOption {
  description = "Tolerations for APISIX Ingress Controller pods assignment";
  type = types.anything;
  default = [  ];
};
"topologySpreadConstraints" = mkOption {
  description = "Topology Spread Constraints for pod assignment spread across your cluster among failure-domains. Evaluated as a template";
  type = types.anything;
  default = [  ];
};
"updateStrategy" = mkOption {
  type = IngressControllerUpdateStrategyModule;
  default = {  };
};
  };
};
IngressControllerNodeAffinityPresetModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "key" = mkOption {
  description = "Node label key to match. Ignored if `injector.affinity` is set";
  type = (types.nullOr types.str);
  default = "";
};
"type" = mkOption {
  description = "Node affinity preset type. Ignored if `injector.affinity` is set. Allowed values: `soft` or `hard`";
  type = (types.nullOr types.str);
  default = "";
};
"values" = mkOption {
  description = "Node label values to match. Ignored if `injector.affinity` is set";
  type = (types.listOf types.anything);
  default = [  ];
};
  };
};
IngressControllerPdbModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "create" = mkOption {
  description = "Enable/disable a Pod Disruption Budget creation";
  type = types.bool;
  default = false;
};
"maxUnavailable" = mkOption {
  description = "Maximum number/percentage of pods that may be made unavailable";
  type = types.anything;
  default = "";
};
"minAvailable" = mkOption {
  description = "Minimum number/percentage of pods that should remain scheduled";
  type = types.anything;
  default = 1;
};
  };
};
IngressControllerPodSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enabled APISIX Ingress Controller pods' Security Context";
  type = types.bool;
  default = true;
};
"fsGroup" = mkOption {
  description = "Set APISIX Ingress Controller pod's Security Context fsGroup";
  type = (types.nullOr types.int);
  default = 1001;
};
"seccompProfile" = mkOption {
  type = IngressControllerPodSecurityContextSeccompProfileModule;
  default = {  };
};
  };
};
IngressControllerPodSecurityContextSeccompProfileModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "type" = mkOption {
  description = "Set APISIX Ingress Controller container's Security Context seccomp profile";
  type = (types.nullOr types.str);
  default = "RuntimeDefault";
};
  };
};
IngressControllerRbacModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "create" = mkOption {
  description = "Specifies whether RBAC resources should be created";
  type = types.bool;
  default = true;
};
"rules" = mkOption {
  description = "Custom RBAC rules to set";
  type = types.anything;
  default = [  ];
};
  };
};
IngressControllerReadinessProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable readinessProbe on APISIX Ingress Controller containers";
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
IngressControllerResourcesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "limits" = mkOption {
  description = "The resources limits for the APISIX Ingress Controller containers";
  type = (types.attrsOf types.anything);
  default = {  };
};
"requests" = mkOption {
  description = "The requested resources for the APISIX Ingress Controller containers";
  type = (types.attrsOf types.anything);
  default = {  };
};
  };
};
IngressControllerServiceAccountModule = types.submodule {
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
  default = true;
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
IngressControllerServiceModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "annotations" = mkOption {
  description = "Additional custom annotations for APISIX Ingress Controller service";
  type = (types.attrsOf types.anything);
  default = {  };
};
"clusterIP" = mkOption {
  description = "APISIX Ingress Controller service Cluster IP";
  type = (types.nullOr types.str);
  default = "";
};
"externalTrafficPolicy" = mkOption {
  description = "APISIX Ingress Controller service external traffic policy";
  type = (types.nullOr types.str);
  default = "Cluster";
};
"extraPorts" = mkOption {
  description = "Extra ports to expose in APISIX Ingress Controller service (normally used with the `sidecars` value)";
  type = types.anything;
  default = [  ];
};
"loadBalancerIP" = mkOption {
  description = "APISIX Ingress Controller service Load Balancer IP";
  type = (types.nullOr types.str);
  default = "";
};
"loadBalancerSourceRanges" = mkOption {
  description = "APISIX Ingress Controller service Load Balancer sources";
  type = (types.listOf types.anything);
  default = [  ];
};
"nodePorts" = mkOption {
  type = IngressControllerServiceNodePortsModule;
  default = {  };
};
"ports" = mkOption {
  type = IngressControllerServicePortsModule;
  default = {  };
};
"sessionAffinity" = mkOption {
  description = "Control where web requests go, to the same pod or round-robin";
  type = (types.nullOr types.str);
  default = "None";
};
"sessionAffinityConfig" = mkOption {
  description = "Additional settings for the sessionAffinity";
  type = types.anything;
  default = {  };
};
"type" = mkOption {
  description = "APISIX Ingress Controller service type";
  type = (types.nullOr types.str);
  default = "ClusterIP";
};
  };
};
IngressControllerServiceNodePortsModule = types.submodule {
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
IngressControllerServicePortsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "http" = mkOption {
  description = "APISIX Ingress Controller service HTTP port";
  type = (types.nullOr types.int);
  default = 80;
};
"https" = mkOption {
  description = "APISIX Ingress Controller service HTTPS port";
  type = (types.nullOr types.int);
  default = 443;
};
  };
};
IngressControllerStartupProbeModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable startupProbe on APISIX Ingress Controller containers";
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
IngressControllerTlsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "autoGenerated" = mkOption {
  description = "Auto-generate self-signed certificates";
  type = types.bool;
  default = true;
};
"ca" = mkOption {
  description = "Content of the certificate CA to be added to the secret";
  type = (types.nullOr types.str);
  default = "";
};
"cert" = mkOption {
  description = "Content of the certificate to be added to the secret";
  type = (types.nullOr types.str);
  default = "";
};
"certCAFilename" = mkOption {
  description = "Path of the certificate CA file when mounted as a secret";
  type = (types.nullOr types.str);
  default = "ca.crt";
};
"certFilename" = mkOption {
  description = "Path of the certificate file when mounted as a secret";
  type = (types.nullOr types.str);
  default = "tls.crt";
};
"certKeyFilename" = mkOption {
  description = "Path of the certificate key file when mounted as a secret";
  type = (types.nullOr types.str);
  default = "tls.key";
};
"enabled" = mkOption {
  description = "Enable TLS transport in Ingress Controller";
  type = types.bool;
  default = true;
};
"existingSecret" = mkOption {
  description = "Name of a secret containing the certificates";
  type = (types.nullOr types.str);
  default = "";
};
"key" = mkOption {
  description = "Content of the certificate key to be added to the secret";
  type = (types.nullOr types.str);
  default = "";
};
  };
};
IngressControllerUpdateStrategyModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "type" = mkOption {
  description = "APISIX Ingress Controller statefulset strategy type";
  type = (types.nullOr types.str);
  default = "RollingUpdate";
};
  };
};
WaitContainerContainerSecurityContextCapabilitiesModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "drop" = mkOption {
  description = "Set APISIX container's Security Context runAsNonRoot";
  type = (types.listOf types.str);
  default = [ "ALL" ];
};
  };
};
WaitContainerContainerSecurityContextModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "allowPrivilegeEscalation" = mkOption {
  description = "Set APISIX container's privilege escalation";
  type = types.bool;
  default = false;
};
"capabilities" = mkOption {
  type = WaitContainerContainerSecurityContextCapabilitiesModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Enabled APISIX containers' Security Context";
  type = types.bool;
  default = true;
};
"readOnlyRootFilesystem" = mkOption {
  description = "Set APISIX containers' Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsNonRoot" = mkOption {
  description = "Set APISIX containers' Security Context runAsNonRoot";
  type = types.bool;
  default = true;
};
"runAsUser" = mkOption {
  description = "Set APISIX containers' Security Context runAsUser";
  type = (types.nullOr types.int);
  default = 1001;
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
  type = (types.listOf types.anything);
  default = [  ];
};
"registry" = mkOption {
  description = "Init container wait-container image registry";
  type = (types.nullOr types.str);
  default = "docker.io";
};
"repository" = mkOption {
  description = "Init container wait-container image name";
  type = (types.nullOr types.str);
  default = "bitnami/os-shell";
};
"tag" = mkOption {
  description = "Init container wait-container image tag";
  type = (types.nullOr types.str);
  default = "11-debian-11-r2";
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
  type = types.anything;
  default = {  };
};
"commonLabels" = mkOption {
  description = "Labels to add to all deployed objects";
  type = (types.attrsOf types.anything);
  default = {  };
};
"controlPlane" = mkOption {
  type = ControlPlaneModule;
  default = {  };
};
"dataPlane" = mkOption {
  type = DataPlaneModule;
  default = {  };
};
"diagnosticMode" = mkOption {
  type = DiagnosticModeModule;
  default = {  };
};
"etcd" = mkOption {
  type = EtcdModule;
  default = {  };
};
"externalEtcd" = mkOption {
  type = ExternalEtcdModule;
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
"global" = mkOption {
  type = GlobalModule;
  default = {  };
};
"image" = mkOption {
  type = ImageModule;
  default = {  };
};
"ingressController" = mkOption {
  type = IngressControllerModule;
  default = {  };
};
"kubeVersion" = mkOption {
  description = "Override Kubernetes version";
  type = (types.nullOr types.str);
  default = "";
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
"waitContainer" = mkOption {
  type = WaitContainerModule;
  default = {  };
};
  };
}
