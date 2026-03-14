# Auto-generated from Bitnami values.schema.json
# Do not edit — regenerate with bin/create-module-bitnami
{ lib, ... }:
with lib;
let
  AlertmanagerContainerPortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "cluster" = mkOption {
        description = "Alertmanager Cluster HA port";
        type = (types.nullOr types.int);
        default = 9094;
      };
      "http" = mkOption {
        description = "Alertmanager HTTP container port";
        type = (types.nullOr types.int);
        default = 9093;
      };
    };
  };
  AlertmanagerContainerSecurityContextCapabilitiesModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "drop" = mkOption {
        description = "List of capabilities to be dropped";
        type = (types.listOf types.str);
        default = [ "ALL" ];
      };
    };
  };
  AlertmanagerContainerSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "allowPrivilegeEscalation" = mkOption {
        description = "Set container's Security Context allowPrivilegeEscalation";
        type = types.bool;
        default = false;
      };
      "capabilities" = mkOption {
        type = AlertmanagerContainerSecurityContextCapabilitiesModule;
        default = { };
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
        type = AlertmanagerContainerSecurityContextSeccompProfileModule;
        default = { };
      };
    };
  };
  AlertmanagerContainerSecurityContextSeccompProfileModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "type" = mkOption {
        description = "Set container's Security Context seccomp profile";
        type = (types.nullOr types.str);
        default = "RuntimeDefault";
      };
    };
  };
  AlertmanagerImageModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "digest" = mkOption {
        description = "Alertmanager image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag image tag (immutable tags are recommended)";
        type = (types.nullOr types.str);
        default = "";
      };
      "pullPolicy" = mkOption {
        description = "Alertmanager image pull policy";
        type = (types.nullOr types.str);
        default = "IfNotPresent";
      };
      "pullSecrets" = mkOption {
        description = "Alertmanager image pull secrets";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "registry" = mkOption {
        description = "Alertmanager image registry";
        type = (types.nullOr types.str);
        default = "REGISTRY_NAME";
      };
      "repository" = mkOption {
        description = "Alertmanager image repository";
        type = (types.nullOr types.str);
        default = "REPOSITORY_NAME/alertmanager";
      };
    };
  };
  AlertmanagerIngressModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations.";
        type = types.anything;
        default = { };
      };
      "enabled" = mkOption {
        description = "Enable ingress record generation for Alertmanager";
        type = types.bool;
        default = false;
      };
      "extraHosts" = mkOption {
        description = "An array with additional hostname(s) to be covered with the ingress record";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraPaths" = mkOption {
        description = "An array with additional arbitrary paths that may need to be added to the ingress under the main host";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraRules" = mkOption {
        description = "Additional rules to be covered with this ingress record";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraTls" = mkOption {
        description = "TLS configuration for additional hostname(s) to be covered with this ingress record";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "hostname" = mkOption {
        description = "Default host for the ingress record";
        type = (types.nullOr types.str);
        default = "alertmanager.prometheus.local";
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
        default = [ ];
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
  AlertmanagerLivenessProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable livenessProbe on Alertmanager containers";
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
        default = 5;
      };
      "periodSeconds" = mkOption {
        description = "Period seconds for livenessProbe";
        type = (types.nullOr types.int);
        default = 20;
      };
      "successThreshold" = mkOption {
        description = "Success threshold for livenessProbe";
        type = (types.nullOr types.int);
        default = 1;
      };
      "timeoutSeconds" = mkOption {
        description = "Timeout seconds for livenessProbe";
        type = (types.nullOr types.int);
        default = 3;
      };
    };
  };
  AlertmanagerModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "affinity" = mkOption {
        description = "Affinity for Alertmanager pods assignment";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "args" = mkOption {
        description = "Override default container args (useful when using custom images)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "automountServiceAccountToken" = mkOption {
        description = "Mount Service Account token in pod";
        type = types.bool;
        default = false;
      };
      "command" = mkOption {
        description = "Override default container command (useful when using custom images)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "configuration" = mkOption {
        description = "Alertmanager configuration. This content will be stored in the the alertmanager.yaml file and the content can be a template.";
        type = (types.nullOr types.str);
        default = "" "";
      };
      "containerPorts" = mkOption {
        type = AlertmanagerContainerPortsModule;
        default = { };
      };
      "containerSecurityContext" = mkOption {
        type = AlertmanagerContainerSecurityContextModule;
        default = { };
      };
      "customLivenessProbe" = mkOption {
        description = "Custom livenessProbe that overrides the default one";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "customReadinessProbe" = mkOption {
        description = "Custom readinessProbe that overrides the default one";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "customStartupProbe" = mkOption {
        description = "Custom startupProbe that overrides the default one";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "enabled" = mkOption {
        description = "Alertmanager enabled";
        type = types.bool;
        default = true;
      };
      "existingConfigmap" = mkOption {
        description = "The name of an existing ConfigMap with your custom configuration for Alertmanager";
        type = (types.nullOr types.str);
        default = "";
      };
      "existingConfigmapKey" = mkOption {
        description = "The name of the key with the Alertmanager config file";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraArgs" = mkOption {
        description = "Additional arguments passed to the Prometheus server container";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraEnvVars" = mkOption {
        description = "Array with extra environment variables to add to Alertmanager nodes";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraEnvVarsCM" = mkOption {
        description = "Name of existing ConfigMap containing extra env vars for Alertmanager nodes";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraEnvVarsSecret" = mkOption {
        description = "Name of existing Secret containing extra env vars for Alertmanager nodes";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraVolumeMounts" = mkOption {
        description = "Optionally specify extra list of additional volumeMounts for the Alertmanager container(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraVolumes" = mkOption {
        description = "Optionally specify extra list of additional volumes for the Alertmanager pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "hostAliases" = mkOption {
        description = "Alertmanager pods host aliases";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "image" = mkOption {
        type = AlertmanagerImageModule;
        default = { };
      };
      "ingress" = mkOption {
        type = AlertmanagerIngressModule;
        default = { };
      };
      "initContainers" = mkOption {
        description = "Add additional init containers to the Alertmanager pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "lifecycleHooks" = mkOption {
        description = "for the Alertmanager container(s) to automate configuration before or after startup";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "livenessProbe" = mkOption {
        type = AlertmanagerLivenessProbeModule;
        default = { };
      };
      "networkPolicy" = mkOption {
        type = AlertmanagerNetworkPolicyModule;
        default = { };
      };
      "nodeAffinityPreset" = mkOption {
        type = AlertmanagerNodeAffinityPresetModule;
        default = { };
      };
      "nodeSelector" = mkOption {
        description = "Node labels for Alertmanager pods assignment";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "pdb" = mkOption {
        type = AlertmanagerPdbModule;
        default = { };
      };
      "persistence" = mkOption {
        type = AlertmanagerPersistenceModule;
        default = { };
      };
      "podAffinityPreset" = mkOption {
        description = "Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "";
      };
      "podAnnotations" = mkOption {
        description = "Annotations for Alertmanager pods";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "podAntiAffinityPreset" = mkOption {
        description = "Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "soft";
      };
      "podLabels" = mkOption {
        description = "Extra labels for Alertmanager pods";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "podManagementPolicy" = mkOption {
        description = "Statefulset Pod management policy, it needs to be Parallel to be able to complete the cluster join";
        type = (types.nullOr types.str);
        default = "OrderedReady";
      };
      "podSecurityContext" = mkOption {
        type = AlertmanagerPodSecurityContextModule;
        default = { };
      };
      "priorityClassName" = mkOption {
        description = "Alertmanager pods' priorityClassName";
        type = (types.nullOr types.str);
        default = "";
      };
      "readinessProbe" = mkOption {
        type = AlertmanagerReadinessProbeModule;
        default = { };
      };
      "replicaCount" = mkOption {
        description = "Number of Alertmanager replicas to deploy";
        type = (types.nullOr types.int);
        default = 1;
      };
      "resources" = mkOption {
        description = "Set container requests and limits for different resources like CPU or memory (essential for production workloads)";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "resourcesPreset" = mkOption {
        description = "Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if alertmanager.resources is set (alertmanager.resources is recommended for production).";
        type = (types.nullOr types.str);
        default = "nano";
      };
      "schedulerName" = mkOption {
        description = "Name of the k8s scheduler (other than default) for Alertmanager pods";
        type = (types.nullOr types.str);
        default = "";
      };
      "service" = mkOption {
        type = AlertmanagerServiceModule;
        default = { };
      };
      "serviceAccount" = mkOption {
        type = AlertmanagerServiceAccountModule;
        default = { };
      };
      "sidecars" = mkOption {
        description = "Add additional sidecar containers to the Alertmanager pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "startupProbe" = mkOption {
        type = AlertmanagerStartupProbeModule;
        default = { };
      };
      "terminationGracePeriodSeconds" = mkOption {
        description = "Seconds Redmine pod needs to terminate gracefully";
        type = (types.nullOr types.str);
        default = "";
      };
      "tolerations" = mkOption {
        description = "Tolerations for Alertmanager pods assignment";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "topologySpreadConstraints" = mkOption {
        description = "Topology Spread Constraints for pod assignment spread across your cluster among failure-domains. Evaluated as a template";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "updateStrategy" = mkOption {
        type = AlertmanagerUpdateStrategyModule;
        default = { };
      };
    };
  };
  AlertmanagerNetworkPolicyModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "addExternalClientAccess" = mkOption {
        description = "Allow access from pods with client label set to \"true\". Ignored if `alertmanager.networkPolicy.allowExternal` is true.";
        type = types.bool;
        default = true;
      };
      "allowExternal" = mkOption {
        description = "Don't require alertmanager label for connections";
        type = types.bool;
        default = true;
      };
      "allowExternalEgress" = mkOption {
        description = "Allow the pod to access any range of port and all destinations.";
        type = types.bool;
        default = true;
      };
      "enabled" = mkOption {
        description = "Specifies whether a NetworkPolicy should be created";
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
  AlertmanagerNodeAffinityPresetModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "key" = mkOption {
        description = "Node label key to match. Ignored if `affinity` is set";
        type = (types.nullOr types.str);
        default = "";
      };
      "type" = mkOption {
        description = "Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "";
      };
      "values" = mkOption {
        description = "Node label values to match. Ignored if `affinity` is set";
        type = (types.listOf types.anything);
        default = [ ];
      };
    };
  };
  AlertmanagerPdbModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "create" = mkOption {
        description = "Enable/disable a Pod Disruption Budget creation";
        type = types.bool;
        default = true;
      };
    };
  };
  AlertmanagerPersistenceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "accessModes" = mkOption {
        description = "PVC Access Mode for Concourse worker volume";
        type = (types.listOf types.str);
        default = [ "ReadWriteOnce" ];
      };
      "annotations" = mkOption {
        description = "Annotations for the PVC";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "enabled" = mkOption {
        description = "Enable Alertmanager data persistence using VolumeClaimTemplates";
        type = types.bool;
        default = false;
      };
      "mountPath" = mkOption {
        description = "Path to mount the volume at.";
        type = (types.nullOr types.str);
        default = "/bitnami/alertmanager/data";
      };
      "selector" = mkOption {
        description = "Selector to match an existing Persistent Volume (this value is evaluated as a template)";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "size" = mkOption {
        description = "PVC Storage Request for Concourse worker volume";
        type = (types.nullOr types.str);
        default = "8Gi";
      };
      "storageClass" = mkOption {
        description = "PVC Storage Class for Concourse worker data volume";
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
  AlertmanagerPodSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enabled Alertmanager pods' Security Context";
        type = types.bool;
        default = true;
      };
      "fsGroup" = mkOption {
        description = "Set Alertmanager pod's Security Context fsGroup";
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
        default = [ ];
      };
      "sysctls" = mkOption {
        description = "Set kernel settings using the sysctl interface";
        type = (types.listOf types.anything);
        default = [ ];
      };
    };
  };
  AlertmanagerReadinessProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable readinessProbe on Alertmanager containers";
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
        default = 2;
      };
    };
  };
  AlertmanagerServiceAccountModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Additional Service Account annotations (evaluated as a template)";
        type = (types.attrsOf types.anything);
        default = { };
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
  AlertmanagerServiceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Additional custom annotations for Alertmanager service";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "clusterIP" = mkOption {
        description = "Alertmanager service Cluster IP";
        type = (types.nullOr types.str);
        default = "";
      };
      "externalTrafficPolicy" = mkOption {
        description = "Alertmanager service external traffic policy";
        type = (types.nullOr types.str);
        default = "Cluster";
      };
      "extraPorts" = mkOption {
        description = "Extra ports to expose in Alertmanager service (normally used with the `sidecars` value)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "loadBalancerClass" = mkOption {
        description = "Alertmanager service Load Balancer class if service type is `LoadBalancer` (optional, cloud specific)";
        type = (types.nullOr types.str);
        default = "";
      };
      "loadBalancerIP" = mkOption {
        description = "Alertmanager service Load Balancer IP";
        type = (types.nullOr types.str);
        default = "";
      };
      "loadBalancerSourceRanges" = mkOption {
        description = "Alertmanager service Load Balancer sources";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "nodePorts" = mkOption {
        type = AlertmanagerServiceNodePortsModule;
        default = { };
      };
      "ports" = mkOption {
        type = AlertmanagerServicePortsModule;
        default = { };
      };
      "sessionAffinity" = mkOption {
        description = "Control where client requests go, to the same pod or round-robin";
        type = (types.nullOr types.str);
        default = "None";
      };
      "sessionAffinityConfig" = mkOption {
        description = "Additional settings for the sessionAffinity";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "type" = mkOption {
        description = "Alertmanager service type";
        type = (types.nullOr types.str);
        default = "LoadBalancer";
      };
    };
  };
  AlertmanagerServiceNodePortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "http" = mkOption {
        description = "Node port for HTTP";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  AlertmanagerServicePortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "cluster" = mkOption {
        description = "Alertmanager cluster HA port";
        type = (types.nullOr types.int);
        default = 9094;
      };
      "http" = mkOption {
        description = "Alertmanager service HTTP port";
        type = (types.nullOr types.int);
        default = 80;
      };
    };
  };
  AlertmanagerStartupProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable startupProbe on Alertmanager containers";
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
        default = 2;
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
        default = 2;
      };
    };
  };
  AlertmanagerUpdateStrategyModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "type" = mkOption {
        description = "Alertmanager statefulset strategy type";
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
        default = { };
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
        default = { };
      };
      "defaultStorageClass" = mkOption {
        description = "Global default StorageClass for Persistent Volume(s)";
        type = (types.nullOr types.str);
        default = "";
      };
      "imagePullSecrets" = mkOption {
        description = "Global Docker registry secret names as an array";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "imageRegistry" = mkOption {
        description = "Global Docker image registry";
        type = (types.nullOr types.str);
        default = "";
      };
      "security" = mkOption {
        type = GlobalSecurityModule;
        default = { };
      };
      "storageClass" = mkOption {
        description = "DEPRECATED: use global.defaultStorageClass instead";
        type = (types.nullOr types.str);
        default = "";
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
  IngressModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "apiVersion" = mkOption {
        description = "Force Ingress API version (automatically detected if not set)";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  ServerContainerPortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "http" = mkOption {
        description = "Prometheus HTTP container port";
        type = (types.nullOr types.int);
        default = 9090;
      };
    };
  };
  ServerContainerSecurityContextCapabilitiesModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "drop" = mkOption {
        description = "List of capabilities to be dropped";
        type = (types.listOf types.str);
        default = [ "ALL" ];
      };
    };
  };
  ServerContainerSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "allowPrivilegeEscalation" = mkOption {
        description = "Set container's Security Context allowPrivilegeEscalation";
        type = types.bool;
        default = false;
      };
      "capabilities" = mkOption {
        type = ServerContainerSecurityContextCapabilitiesModule;
        default = { };
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
        type = ServerContainerSecurityContextSeccompProfileModule;
        default = { };
      };
    };
  };
  ServerContainerSecurityContextSeccompProfileModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "type" = mkOption {
        description = "Set container's Security Context seccomp profile";
        type = (types.nullOr types.str);
        default = "RuntimeDefault";
      };
    };
  };
  ServerImageModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "digest" = mkOption {
        description = "Prometheus image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag image tag (immutable tags are recommended)";
        type = (types.nullOr types.str);
        default = "";
      };
      "pullPolicy" = mkOption {
        description = "Prometheus image pull policy";
        type = (types.nullOr types.str);
        default = "IfNotPresent";
      };
      "pullSecrets" = mkOption {
        description = "Prometheus image pull secrets";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "registry" = mkOption {
        description = "Prometheus image registry";
        type = (types.nullOr types.str);
        default = "REGISTRY_NAME";
      };
      "repository" = mkOption {
        description = "Prometheus image repository";
        type = (types.nullOr types.str);
        default = "REPOSITORY_NAME/prometheus";
      };
    };
  };
  ServerIngressModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations.";
        type = types.anything;
        default = { };
      };
      "enabled" = mkOption {
        description = "Enable ingress record generation for Prometheus";
        type = types.bool;
        default = false;
      };
      "extraHosts" = mkOption {
        description = "An array with additional hostname(s) to be covered with the ingress record";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraPaths" = mkOption {
        description = "An array with additional arbitrary paths that may need to be added to the ingress under the main host";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraRules" = mkOption {
        description = "Additional rules to be covered with this ingress record";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraTls" = mkOption {
        description = "TLS configuration for additional hostname(s) to be covered with this ingress record";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "hostname" = mkOption {
        description = "Default host for the ingress record";
        type = (types.nullOr types.str);
        default = "server.prometheus.local";
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
        default = [ ];
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
  ServerLivenessProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable livenessProbe on Prometheus containers";
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
        default = 5;
      };
      "periodSeconds" = mkOption {
        description = "Period seconds for livenessProbe";
        type = (types.nullOr types.int);
        default = 20;
      };
      "successThreshold" = mkOption {
        description = "Success threshold for livenessProbe";
        type = (types.nullOr types.int);
        default = 1;
      };
      "timeoutSeconds" = mkOption {
        description = "Timeout seconds for livenessProbe";
        type = (types.nullOr types.int);
        default = 3;
      };
    };
  };
  ServerModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "affinity" = mkOption {
        description = "Affinity for Prometheus pods assignment";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "alertingEndpoints" = mkOption {
        description = "Alertmanagers to which alerts will be sent";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "alertingRules" = mkOption {
        description = "Prometheus alerting rules. This content will be stored in the the rules.yaml file and the content can be a template.";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "args" = mkOption {
        description = "Override default container args (useful when using custom images)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "automountServiceAccountToken" = mkOption {
        description = "Mount Service Account token in pod";
        type = types.bool;
        default = true;
      };
      "command" = mkOption {
        description = "Override default container command (useful when using custom images)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "configuration" = mkOption {
        description = "Promethus configuration. This content will be stored in the the prometheus.yaml file and the content can be a template.";
        type = (types.nullOr types.str);
        default = "" "";
      };
      "containerPorts" = mkOption {
        type = ServerContainerPortsModule;
        default = { };
      };
      "containerSecurityContext" = mkOption {
        type = ServerContainerSecurityContextModule;
        default = { };
      };
      "customLivenessProbe" = mkOption {
        description = "Custom livenessProbe that overrides the default one";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "customReadinessProbe" = mkOption {
        description = "Custom readinessProbe that overrides the default one";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "customStartupProbe" = mkOption {
        description = "Custom startupProbe that overrides the default one";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "enableAdminAPI" = mkOption {
        description = "Enable Prometheus adminitrative API";
        type = types.bool;
        default = false;
      };
      "enableFeatures" = mkOption {
        description = "Enable access to Prometheus disabled features.";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "enableRemoteWriteReceiver" = mkOption {
        description = "Enable Prometheus to be used as a receiver for the Prometheus remote write protocol.";
        type = types.bool;
        default = false;
      };
      "evaluationInterval" = mkOption {
        description = "Interval between consecutive evaluations. Example: \"1m\"";
        type = (types.nullOr types.str);
        default = "";
      };
      "existingConfigmap" = mkOption {
        description = "The name of an existing ConfigMap with your custom configuration for Prometheus";
        type = (types.nullOr types.str);
        default = "";
      };
      "existingConfigmapKey" = mkOption {
        description = "The name of the key with the Prometheus config file";
        type = (types.nullOr types.str);
        default = "";
      };
      "externalLabels" = mkOption {
        description = "External labels to add to any time series or alerts when communicating with external systems";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "extraArgs" = mkOption {
        description = "Additional arguments passed to the Prometheus server container";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraEnvVars" = mkOption {
        description = "Array with extra environment variables to add to Prometheus nodes";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraEnvVarsCM" = mkOption {
        description = "Name of existing ConfigMap containing extra env vars for Prometheus nodes";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraEnvVarsSecret" = mkOption {
        description = "Name of existing Secret containing extra env vars for Prometheus nodes";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraScrapeConfigs" = mkOption {
        description = "Promethus configuration, useful to declare new scrape_configs. This content will be merged with the 'server.configuration' value and stored in the the prometheus.yaml file.";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraVolumeMounts" = mkOption {
        description = "Optionally specify extra list of additional volumeMounts for the Prometheus container(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraVolumes" = mkOption {
        description = "Optionally specify extra list of additional volumes for the Prometheus pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "hostAliases" = mkOption {
        description = "Prometheus pods host aliases";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "image" = mkOption {
        type = ServerImageModule;
        default = { };
      };
      "ingress" = mkOption {
        type = ServerIngressModule;
        default = { };
      };
      "initContainers" = mkOption {
        description = "Add additional init containers to the Prometheus pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "lifecycleHooks" = mkOption {
        description = "for the Prometheus container(s) to automate configuration before or after startup";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "livenessProbe" = mkOption {
        type = ServerLivenessProbeModule;
        default = { };
      };
      "logFormat" = mkOption {
        description = "Log format for Prometheus";
        type = (types.nullOr types.str);
        default = "logfmt";
      };
      "logLevel" = mkOption {
        description = "Log level for Prometheus";
        type = (types.nullOr types.str);
        default = "info";
      };
      "networkPolicy" = mkOption {
        type = ServerNetworkPolicyModule;
        default = { };
      };
      "nodeAffinityPreset" = mkOption {
        type = ServerNodeAffinityPresetModule;
        default = { };
      };
      "nodeSelector" = mkOption {
        description = "Node labels for Prometheus pods assignment";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "pdb" = mkOption {
        type = ServerPdbModule;
        default = { };
      };
      "persistence" = mkOption {
        type = ServerPersistenceModule;
        default = { };
      };
      "podAffinityPreset" = mkOption {
        description = "Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "";
      };
      "podAnnotations" = mkOption {
        description = "Annotations for Prometheus pods";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "podAntiAffinityPreset" = mkOption {
        description = "Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "soft";
      };
      "podLabels" = mkOption {
        description = "Extra labels for Prometheus pods";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "podSecurityContext" = mkOption {
        type = ServerPodSecurityContextModule;
        default = { };
      };
      "priorityClassName" = mkOption {
        description = "Prometheus pods' priorityClassName";
        type = (types.nullOr types.str);
        default = "";
      };
      "rbac" = mkOption {
        type = ServerRbacModule;
        default = { };
      };
      "readinessProbe" = mkOption {
        type = ServerReadinessProbeModule;
        default = { };
      };
      "remoteWrite" = mkOption {
        description = "The remote_write spec configuration for Prometheus";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "replicaCount" = mkOption {
        description = "Number of Prometheus replicas to deploy";
        type = (types.nullOr types.int);
        default = 1;
      };
      "resources" = mkOption {
        description = "Set container requests and limits for different resources like CPU or memory (essential for production workloads)";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "resourcesPreset" = mkOption {
        description = "Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if server.resources is set (server.resources is recommended for production).";
        type = (types.nullOr types.str);
        default = "nano";
      };
      "retention" = mkOption {
        description = "Metrics retention days";
        type = (types.nullOr types.str);
        default = "10d";
      };
      "retentionSize" = mkOption {
        description = "Maximum size of metrics";
        type = (types.nullOr types.str);
        default = "0";
      };
      "routePrefix" = mkOption {
        description = "Prefix for the internal routes of web endpoints";
        type = (types.nullOr types.str);
        default = "/";
      };
      "schedulerName" = mkOption {
        description = "Name of the k8s scheduler (other than default) for Prometheus pods";
        type = (types.nullOr types.str);
        default = "";
      };
      "scrapeAlertmanagerHost" = mkOption {
        description = "Specifies whether to include alertmanager host scraping job";
        type = types.bool;
        default = true;
      };
      "scrapeInterval" = mkOption {
        description = "Interval between consecutive scrapes. Example: \"1m\"";
        type = (types.nullOr types.str);
        default = "";
      };
      "scrapePrometheusHost" = mkOption {
        description = "Specifies whether to include prometheus host scraping job";
        type = types.bool;
        default = true;
      };
      "scrapeTimeout" = mkOption {
        description = "Interval between consecutive scrapes. Example: \"10s\"";
        type = (types.nullOr types.str);
        default = "";
      };
      "service" = mkOption {
        type = ServerServiceModule;
        default = { };
      };
      "serviceAccount" = mkOption {
        type = ServerServiceAccountModule;
        default = { };
      };
      "sidecars" = mkOption {
        description = "Add additional sidecar containers to the Prometheus pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "startupProbe" = mkOption {
        type = ServerStartupProbeModule;
        default = { };
      };
      "terminationGracePeriodSeconds" = mkOption {
        description = "Seconds Redmine pod needs to terminate gracefully";
        type = (types.nullOr types.str);
        default = "";
      };
      "thanos" = mkOption {
        type = ServerThanosModule;
        default = { };
      };
      "tolerations" = mkOption {
        description = "Tolerations for Prometheus pods assignment";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "topologySpreadConstraints" = mkOption {
        description = "Topology Spread Constraints for pod assignment spread across your cluster among failure-domains. Evaluated as a template";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "updateStrategy" = mkOption {
        type = ServerUpdateStrategyModule;
        default = { };
      };
    };
  };
  ServerNetworkPolicyModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "addExternalClientAccess" = mkOption {
        description = "Allow access from pods with client label set to \"true\". Ignored if `server.networkPolicy.allowExternal` is true.";
        type = types.bool;
        default = true;
      };
      "allowExternal" = mkOption {
        description = "Don't require server label for connections";
        type = types.bool;
        default = true;
      };
      "allowExternalEgress" = mkOption {
        description = "Allow the pod to access any range of port and all destinations.";
        type = types.bool;
        default = true;
      };
      "enabled" = mkOption {
        description = "Specifies whether a NetworkPolicy should be created";
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
  ServerNodeAffinityPresetModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "key" = mkOption {
        description = "Node label key to match. Ignored if `affinity` is set";
        type = (types.nullOr types.str);
        default = "";
      };
      "type" = mkOption {
        description = "Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "";
      };
      "values" = mkOption {
        description = "Node label values to match. Ignored if `affinity` is set";
        type = (types.listOf types.anything);
        default = [ ];
      };
    };
  };
  ServerPdbModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "create" = mkOption {
        description = "Enable/disable a Pod Disruption Budget creation";
        type = types.bool;
        default = true;
      };
    };
  };
  ServerPersistenceModule = types.submodule {
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
        default = { };
      };
      "dataSource" = mkOption {
        description = "Custom PVC data source";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "enabled" = mkOption {
        description = "Enable persistence using Persistent Volume Claims. If you have multiple instances (server.repicacount > 1), please considere using an external storage service like Thanos or Grafana Mimir";
        type = types.bool;
        default = false;
      };
      "existingClaim" = mkOption {
        description = "The name of an existing PVC to use for persistence";
        type = (types.nullOr types.str);
        default = "";
      };
      "mountPath" = mkOption {
        description = "Path to mount the volume at.";
        type = (types.nullOr types.str);
        default = "/bitnami/prometheus/data";
      };
      "selector" = mkOption {
        description = "Selector to match an existing Persistent Volume for Prometheus data PVC";
        type = (types.attrsOf types.anything);
        default = { };
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
  ServerPodSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enabled Prometheus pods' Security Context";
        type = types.bool;
        default = true;
      };
      "fsGroup" = mkOption {
        description = "Set Prometheus pod's Security Context fsGroup";
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
        default = [ ];
      };
      "sysctls" = mkOption {
        description = "Set kernel settings using the sysctl interface";
        type = (types.listOf types.anything);
        default = [ ];
      };
    };
  };
  ServerRbacModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "create" = mkOption {
        description = "Specifies whether RBAC resources should be created";
        type = types.bool;
        default = true;
      };
      "includeDefaultRules" = mkOption {
        description = "Specifies whether to include default rules from official prometheus helm chart";
        type = types.bool;
        default = true;
      };
      "rules" = mkOption {
        description = "Custom RBAC rules to set";
        type = (types.listOf types.anything);
        default = [ ];
      };
    };
  };
  ServerReadinessProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable readinessProbe on Prometheus containers";
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
        default = 2;
      };
    };
  };
  ServerServiceAccountModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Additional Service Account annotations (evaluated as a template)";
        type = (types.attrsOf types.anything);
        default = { };
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
  ServerServiceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Additional custom annotations for Prometheus service";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "clusterIP" = mkOption {
        description = "Prometheus service Cluster IP";
        type = (types.nullOr types.str);
        default = "";
      };
      "externalTrafficPolicy" = mkOption {
        description = "Prometheus service external traffic policy";
        type = (types.nullOr types.str);
        default = "Cluster";
      };
      "extraPorts" = mkOption {
        description = "Extra ports to expose in Prometheus service (normally used with the `sidecars` value)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "loadBalancerClass" = mkOption {
        description = "Prometheus service Load Balancer class if service type is `LoadBalancer` (optional, cloud specific)";
        type = (types.nullOr types.str);
        default = "";
      };
      "loadBalancerIP" = mkOption {
        description = "Prometheus service Load Balancer IP";
        type = (types.nullOr types.str);
        default = "";
      };
      "loadBalancerSourceRanges" = mkOption {
        description = "Prometheus service Load Balancer sources";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "nodePorts" = mkOption {
        type = ServerServiceNodePortsModule;
        default = { };
      };
      "ports" = mkOption {
        type = ServerServicePortsModule;
        default = { };
      };
      "sessionAffinity" = mkOption {
        description = "Control where client requests go, to the same pod or round-robin. ClientIP by default.";
        type = (types.nullOr types.str);
        default = "ClientIP";
      };
      "sessionAffinityConfig" = mkOption {
        description = "Additional settings for the sessionAffinity";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "type" = mkOption {
        description = "Prometheus service type";
        type = (types.nullOr types.str);
        default = "LoadBalancer";
      };
    };
  };
  ServerServiceNodePortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "http" = mkOption {
        description = "Node port for HTTP";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  ServerServicePortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "http" = mkOption {
        description = "Prometheus service HTTP port";
        type = (types.nullOr types.int);
        default = 80;
      };
    };
  };
  ServerStartupProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable startupProbe on Prometheus containers";
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
        default = 2;
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
        default = 2;
      };
    };
  };
  ServerThanosContainerSecurityContextCapabilitiesModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "drop" = mkOption {
        description = "List of capabilities to be dropped";
        type = (types.listOf types.str);
        default = [ "ALL" ];
      };
    };
  };
  ServerThanosContainerSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "allowPrivilegeEscalation" = mkOption {
        description = "Set container's Security Context allowPrivilegeEscalation";
        type = types.bool;
        default = false;
      };
      "capabilities" = mkOption {
        type = ServerThanosContainerSecurityContextCapabilitiesModule;
        default = { };
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
        type = ServerThanosContainerSecurityContextSeccompProfileModule;
        default = { };
      };
    };
  };
  ServerThanosContainerSecurityContextSeccompProfileModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "type" = mkOption {
        description = "Set container's Security Context seccomp profile";
        type = (types.nullOr types.str);
        default = "RuntimeDefault";
      };
    };
  };
  ServerThanosImageModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "digest" = mkOption {
        description = "Thanos image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag";
        type = (types.nullOr types.str);
        default = "";
      };
      "pullPolicy" = mkOption {
        description = "Thanos image pull policy";
        type = (types.nullOr types.str);
        default = "IfNotPresent";
      };
      "pullSecrets" = mkOption {
        description = "Specify docker-registry secret names as an array";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "registry" = mkOption {
        description = "Thanos image registry";
        type = (types.nullOr types.str);
        default = "REGISTRY_NAME";
      };
      "repository" = mkOption {
        description = "Thanos image name";
        type = (types.nullOr types.str);
        default = "REPOSITORY_NAME/thanos";
      };
    };
  };
  ServerThanosIngressModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations.";
        type = types.anything;
        default = { };
      };
      "enabled" = mkOption {
        description = "Enable ingress controller resource";
        type = types.bool;
        default = false;
      };
      "extraHosts" = mkOption {
        description = "An array with additional hostname(s) to be covered with the ingress record";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraPaths" = mkOption {
        description = "An array with additional arbitrary paths that may need to be added to the ingress under the main host";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraRules" = mkOption {
        description = "The list of additional rules to be added to this ingress record. Evaluated as a template";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraTls" = mkOption {
        description = "TLS configuration for additional hostname(s) to be covered with this ingress record";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "hostname" = mkOption {
        description = "Default host for the ingress record";
        type = (types.nullOr types.str);
        default = "thanos.prometheus.local";
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
        default = [ ];
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
  ServerThanosLivenessProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Turn on and off liveness probe";
        type = types.bool;
        default = true;
      };
      "failureThreshold" = mkOption {
        description = "Minimum consecutive failures for the probe";
        type = (types.nullOr types.int);
        default = 120;
      };
      "initialDelaySeconds" = mkOption {
        description = "Delay before liveness probe is initiated";
        type = (types.nullOr types.int);
        default = 0;
      };
      "periodSeconds" = mkOption {
        description = "How often to perform the probe";
        type = (types.nullOr types.int);
        default = 5;
      };
      "successThreshold" = mkOption {
        description = "Minimum consecutive successes for the probe";
        type = (types.nullOr types.int);
        default = 1;
      };
      "timeoutSeconds" = mkOption {
        description = "When the probe times out";
        type = (types.nullOr types.int);
        default = 3;
      };
    };
  };
  ServerThanosModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "containerSecurityContext" = mkOption {
        type = ServerThanosContainerSecurityContextModule;
        default = { };
      };
      "create" = mkOption {
        description = "Create a Thanos sidecar container";
        type = types.bool;
        default = false;
      };
      "customLivenessProbe" = mkOption {
        description = "Custom livenessProbe that overrides the default one";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "customReadinessProbe" = mkOption {
        description = "Custom readinessProbe that overrides the default one";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "extraArgs" = mkOption {
        description = "Additional arguments passed to the thanos sidecar container";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraEnvVars" = mkOption {
        description = "Array with extra environment variables to add to the thanos sidecar container";
        type = types.anything;
        default = [ ];
      };
      "extraEnvVarsCM" = mkOption {
        description = "Name of existing ConfigMap containing extra env vars for the thanos sidecar container";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraEnvVarsSecret" = mkOption {
        description = "Name of existing Secret containing extra env vars for the thanos sidecar container";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraVolumeMounts" = mkOption {
        description = "Additional volumeMounts from `server.volumes` for thanos sidecar container";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "image" = mkOption {
        type = ServerThanosImageModule;
        default = { };
      };
      "ingress" = mkOption {
        type = ServerThanosIngressModule;
        default = { };
      };
      "livenessProbe" = mkOption {
        type = ServerThanosLivenessProbeModule;
        default = { };
      };
      "objectStorageConfig" = mkOption {
        type = ServerThanosObjectStorageConfigModule;
        default = { };
      };
      "prometheusUrl" = mkOption {
        description = "Override default prometheus url `http://localhost:9090`";
        type = (types.nullOr types.str);
        default = "";
      };
      "readinessProbe" = mkOption {
        type = ServerThanosReadinessProbeModule;
        default = { };
      };
      "resources" = mkOption {
        description = "Set container requests and limits for different resources like CPU or memory (essential for production workloads)";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "resourcesPreset" = mkOption {
        description = "Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if server.thanos.resources is set (server.thanos.resources is recommended for production).";
        type = (types.nullOr types.str);
        default = "nano";
      };
      "service" = mkOption {
        type = ServerThanosServiceModule;
        default = { };
      };
    };
  };
  ServerThanosObjectStorageConfigModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "secretKey" = mkOption {
        description = "Secret key with the configuration file.";
        type = (types.nullOr types.str);
        default = "thanos.yaml";
      };
      "secretName" = mkOption {
        description = "Support mounting a Secret for the objectStorageConfig of the sideCar container.";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  ServerThanosReadinessProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Turn on and off readiness probe";
        type = types.bool;
        default = true;
      };
      "failureThreshold" = mkOption {
        description = "Minimum consecutive failures for the probe";
        type = (types.nullOr types.int);
        default = 120;
      };
      "initialDelaySeconds" = mkOption {
        description = "Delay before readiness probe is initiated";
        type = (types.nullOr types.int);
        default = 0;
      };
      "periodSeconds" = mkOption {
        description = "How often to perform the probe";
        type = (types.nullOr types.int);
        default = 5;
      };
      "successThreshold" = mkOption {
        description = "Minimum consecutive successes for the probe";
        type = (types.nullOr types.int);
        default = 1;
      };
      "timeoutSeconds" = mkOption {
        description = "When the probe times out";
        type = (types.nullOr types.int);
        default = 3;
      };
    };
  };
  ServerThanosServiceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Additional annotations for Prometheus service";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "clusterIP" = mkOption {
        description = "Specific cluster IP when service type is cluster IP. Use `None` to create headless service by default.";
        type = (types.nullOr types.str);
        default = "None";
      };
      "externalTrafficPolicy" = mkOption {
        description = "Prometheus service external traffic policy";
        type = (types.nullOr types.str);
        default = "Cluster";
      };
      "extraPorts" = mkOption {
        description = "Additional ports to expose from the Thanos sidecar container";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "loadBalancerClass" = mkOption {
        description = "Thanos service Load Balancer class if service type is `LoadBalancer` (optional, cloud specific)";
        type = (types.nullOr types.str);
        default = "";
      };
      "loadBalancerIP" = mkOption {
        description = "`loadBalancerIP` if service type is `LoadBalancer`";
        type = (types.nullOr types.str);
        default = "";
      };
      "loadBalancerSourceRanges" = mkOption {
        description = "Address that are allowed when svc is `LoadBalancer`";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "nodePorts" = mkOption {
        type = ServerThanosServiceNodePortsModule;
        default = { };
      };
      "ports" = mkOption {
        type = ServerThanosServicePortsModule;
        default = { };
      };
      "sessionAffinity" = mkOption {
        description = "Session Affinity for Kubernetes service, can be \"None\" or \"ClientIP\"";
        type = (types.nullOr types.str);
        default = "None";
      };
      "sessionAffinityConfig" = mkOption {
        description = "Additional settings for the sessionAffinity";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "type" = mkOption {
        description = "Kubernetes service type";
        type = (types.nullOr types.str);
        default = "ClusterIP";
      };
    };
  };
  ServerThanosServiceNodePortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "grpc" = mkOption {
        description = "Specify the nodePort value for the LoadBalancer and NodePort service types.";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  ServerThanosServicePortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "grpc" = mkOption {
        description = "Thanos service port";
        type = (types.nullOr types.int);
        default = 10901;
      };
    };
  };
  ServerUpdateStrategyModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "type" = mkOption {
        description = "Prometheus deployment strategy type. If persistence is enabled, strategy type should be set to Recreate to avoid dead locks.";
        type = (types.nullOr types.str);
        default = "RollingUpdate";
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
      "pullPolicy" = mkOption {
        description = "OS Shell + Utility image pull policy";
        type = (types.nullOr types.str);
        default = "IfNotPresent";
      };
      "pullSecrets" = mkOption {
        description = "OS Shell + Utility image pull secrets";
        type = (types.listOf types.anything);
        default = [ ];
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
        default = { };
      };
      "enabled" = mkOption {
        description = "Enable init container that changes the owner/group of the PV mount point to `runAsUser:fsGroup`";
        type = types.bool;
        default = false;
      };
      "image" = mkOption {
        type = VolumePermissionsImageModule;
        default = { };
      };
      "resources" = mkOption {
        description = "Set container requests and limits for different resources like CPU or memory (essential for production workloads)";
        type = (types.attrsOf types.anything);
        default = { };
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
    "alertmanager" = mkOption {
      type = AlertmanagerModule;
      default = { };
    };
    "clusterDomain" = mkOption {
      description = "Kubernetes cluster domain name";
      type = (types.nullOr types.str);
      default = "cluster.local";
    };
    "commonAnnotations" = mkOption {
      description = "Annotations to add to all deployed objects";
      type = (types.attrsOf types.anything);
      default = { };
    };
    "commonLabels" = mkOption {
      description = "Labels to add to all deployed objects";
      type = (types.attrsOf types.anything);
      default = { };
    };
    "diagnosticMode" = mkOption {
      type = DiagnosticModeModule;
      default = { };
    };
    "extraDeploy" = mkOption {
      description = "Array of extra objects to deploy with the release";
      type = (types.listOf types.anything);
      default = [ ];
    };
    "fullnameOverride" = mkOption {
      description = "String to fully override common.names.fullname";
      type = (types.nullOr types.str);
      default = "";
    };
    "global" = mkOption {
      type = GlobalModule;
      default = { };
    };
    "ingress" = mkOption {
      type = IngressModule;
      default = { };
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
    "server" = mkOption {
      type = ServerModule;
      default = { };
    };
    "volumePermissions" = mkOption {
      type = VolumePermissionsModule;
      default = { };
    };
  };
}
