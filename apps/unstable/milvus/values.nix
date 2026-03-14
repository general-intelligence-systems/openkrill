# Auto-generated from Bitnami values.schema.json
# Do not edit — regenerate with bin/create-module-bitnami
{ lib, ... }:
with lib;
let
  AttuAutoscalingHpaModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations for HPA resource";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "enabled" = mkOption {
        description = "Enable HPA for Milvus Data Plane";
        type = types.bool;
        default = false;
      };
      "maxReplicas" = mkOption {
        description = "Maximum number of Milvus Data Plane replicas";
        type = (types.nullOr types.str);
        default = "";
      };
      "minReplicas" = mkOption {
        description = "Minimum number of Milvus Data Plane replicas";
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
  AttuAutoscalingModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "hpa" = mkOption {
        type = AttuAutoscalingHpaModule;
        default = { };
      };
      "vpa" = mkOption {
        type = AttuAutoscalingVpaModule;
        default = { };
      };
    };
  };
  AttuAutoscalingVpaModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations for VPA resource";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "controlledResources" = mkOption {
        description = "VPA List of resources that the vertical pod autoscaler can control. Defaults to cpu and memory";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "enabled" = mkOption {
        description = "Enable VPA";
        type = types.bool;
        default = false;
      };
      "maxAllowed" = mkOption {
        description = "VPA Max allowed resources for the pod";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "minAllowed" = mkOption {
        description = "VPA Min allowed resources for the pod";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "updatePolicy" = mkOption {
        type = AttuAutoscalingVpaUpdatePolicyModule;
        default = { };
      };
    };
  };
  AttuAutoscalingVpaUpdatePolicyModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "updateMode" = mkOption {
        description = "Autoscaling update policy Specifies whether recommended updates are applied when a Pod is started and whether recommended updates are applied during the life of a Pod";
        type = (types.nullOr types.str);
        default = "Auto";
      };
    };
  };
  AttuContainerPortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "http" = mkOption {
        description = "HTTP port for Attu";
        type = (types.nullOr types.int);
        default = 3000;
      };
    };
  };
  AttuContainerSecurityContextCapabilitiesModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "drop" = mkOption {
        description = "List of capabilities to be dropped";
        type = (types.listOf types.str);
        default = [ "ALL" ];
      };
    };
  };
  AttuContainerSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "allowPrivilegeEscalation" = mkOption {
        description = "Set container's Security Context allowPrivilegeEscalation";
        type = types.bool;
        default = false;
      };
      "capabilities" = mkOption {
        type = AttuContainerSecurityContextCapabilitiesModule;
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
        type = AttuContainerSecurityContextSeccompProfileModule;
        default = { };
      };
    };
  };
  AttuContainerSecurityContextSeccompProfileModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "type" = mkOption {
        description = "Set container's Security Context seccomp profile";
        type = (types.nullOr types.str);
        default = "RuntimeDefault";
      };
    };
  };
  AttuImageModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "debug" = mkOption {
        description = "Enable debug mode";
        type = types.bool;
        default = false;
      };
      "digest" = mkOption {
        description = "Attu image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag";
        type = (types.nullOr types.str);
        default = "";
      };
      "pullPolicy" = mkOption {
        description = "Attu image pull policy";
        type = (types.nullOr types.str);
        default = "IfNotPresent";
      };
      "pullSecrets" = mkOption {
        description = "Attu image pull secrets";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "registry" = mkOption {
        description = "Attu image registry";
        type = (types.nullOr types.str);
        default = "REGISTRY_NAME";
      };
      "repository" = mkOption {
        description = "Attu image repository";
        type = (types.nullOr types.str);
        default = "REPOSITORY_NAME/attu";
      };
    };
  };
  AttuIngressModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations.";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "apiVersion" = mkOption {
        description = "Force Ingress API version (automatically detected if not set)";
        type = (types.nullOr types.str);
        default = "";
      };
      "enabled" = mkOption {
        description = "Enable ingress record generation for Milvus";
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
        default = "milvus.local";
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
        description = "Enable TLS configuration for the host defined at `attu.ingress.hostname` parameter";
        type = types.bool;
        default = false;
      };
    };
  };
  AttuLivenessProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable livenessProbe on Attu nodes";
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
  AttuModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "affinity" = mkOption {
        description = "Affinity for Attu pods assignment";
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
      "autoscaling" = mkOption {
        type = AttuAutoscalingModule;
        default = { };
      };
      "command" = mkOption {
        description = "Override default container command (useful when using custom images)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "containerPorts" = mkOption {
        type = AttuContainerPortsModule;
        default = { };
      };
      "containerSecurityContext" = mkOption {
        type = AttuContainerSecurityContextModule;
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
      "enableDefaultInitContainers" = mkOption {
        description = "Deploy default init containers";
        type = types.bool;
        default = true;
      };
      "enabled" = mkOption {
        description = "Enable Attu deployment";
        type = types.bool;
        default = true;
      };
      "extraEnvVars" = mkOption {
        description = "Array with extra environment variables to add to attu nodes";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraEnvVarsCM" = mkOption {
        description = "Name of existing ConfigMap containing extra env vars for attu nodes";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraEnvVarsSecret" = mkOption {
        description = "Name of existing Secret containing extra env vars for attu nodes";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraVolumeMounts" = mkOption {
        description = "Optionally specify extra list of additional volumeMounts for the Attu container(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraVolumes" = mkOption {
        description = "Optionally specify extra list of additional volumes for the Attu pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "hostAliases" = mkOption {
        description = "attu pods host aliases";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "image" = mkOption {
        type = AttuImageModule;
        default = { };
      };
      "ingress" = mkOption {
        type = AttuIngressModule;
        default = { };
      };
      "initContainers" = mkOption {
        description = "Add additional init containers to the Attu pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "lifecycleHooks" = mkOption {
        description = "for the attu container(s) to automate configuration before or after startup";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "livenessProbe" = mkOption {
        type = AttuLivenessProbeModule;
        default = { };
      };
      "networkPolicy" = mkOption {
        type = AttuNetworkPolicyModule;
        default = { };
      };
      "nodeAffinityPreset" = mkOption {
        type = AttuNodeAffinityPresetModule;
        default = { };
      };
      "nodeSelector" = mkOption {
        description = "Node labels for Attu pods assignment";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "pdb" = mkOption {
        type = AttuPdbModule;
        default = { };
      };
      "podAffinityPreset" = mkOption {
        description = "Pod affinity preset. Ignored if `attu.affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "";
      };
      "podAnnotations" = mkOption {
        description = "Annotations for attu pods";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "podAntiAffinityPreset" = mkOption {
        description = "Pod anti-affinity preset. Ignored if `attu.affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "soft";
      };
      "podLabels" = mkOption {
        description = "Extra labels for attu pods";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "podSecurityContext" = mkOption {
        type = AttuPodSecurityContextModule;
        default = { };
      };
      "priorityClassName" = mkOption {
        description = "Attu pods' priorityClassName";
        type = (types.nullOr types.str);
        default = "";
      };
      "readinessProbe" = mkOption {
        type = AttuReadinessProbeModule;
        default = { };
      };
      "replicaCount" = mkOption {
        description = "Number of Attu replicas to deploy";
        type = (types.nullOr types.int);
        default = 1;
      };
      "resources" = mkOption {
        description = "Set container requests and limits for different resources like CPU or memory (essential for production workloads)";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "resourcesPreset" = mkOption {
        description = "Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if attu.resources is set (attu.resources is recommended for production).";
        type = (types.nullOr types.str);
        default = "micro";
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
      "service" = mkOption {
        type = AttuServiceModule;
        default = { };
      };
      "serviceAccount" = mkOption {
        type = AttuServiceAccountModule;
        default = { };
      };
      "sidecars" = mkOption {
        description = "Add additional sidecar containers to the Attu pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "startupProbe" = mkOption {
        type = AttuStartupProbeModule;
        default = { };
      };
      "tolerations" = mkOption {
        description = "Tolerations for Attu pods assignment";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "topologySpreadConstraints" = mkOption {
        description = "Topology Spread Constraints for pod assignment spread across your cluster among failure-domains";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "updateStrategy" = mkOption {
        type = AttuUpdateStrategyModule;
        default = { };
      };
    };
  };
  AttuNetworkPolicyModule = types.submodule {
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
  AttuNodeAffinityPresetModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "key" = mkOption {
        description = "Node label key to match. Ignored if `attu.affinity` is set";
        type = (types.nullOr types.str);
        default = "";
      };
      "type" = mkOption {
        description = "Node affinity preset type. Ignored if `attu.affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "";
      };
      "values" = mkOption {
        description = "Node label values to match. Ignored if `attu.affinity` is set";
        type = (types.listOf types.anything);
        default = [ ];
      };
    };
  };
  AttuPdbModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "create" = mkOption {
        description = "Enable/disable a Pod Disruption Budget creation";
        type = types.bool;
        default = true;
      };
    };
  };
  AttuPodSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enabled Attu pods' Security Context";
        type = types.bool;
        default = true;
      };
      "fsGroup" = mkOption {
        description = "Set Attu pod's Security Context fsGroup";
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
  AttuReadinessProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable readinessProbe on Attu nodes";
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
  AttuServiceAccountModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Additional custom annotations for the ServiceAccount";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "automountServiceAccountToken" = mkOption {
        description = "Allows auto mount of ServiceAccountToken on the serviceAccount created";
        type = types.bool;
        default = false;
      };
      "create" = mkOption {
        description = "Enable creation of ServiceAccount for Attu pods";
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
  AttuServiceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Additional custom annotations for Attu service";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "clusterIP" = mkOption {
        description = "Attu service Cluster IP";
        type = (types.nullOr types.str);
        default = "";
      };
      "externalTrafficPolicy" = mkOption {
        description = "Attu service external traffic policy";
        type = (types.nullOr types.str);
        default = "Cluster";
      };
      "extraPorts" = mkOption {
        description = "Extra ports to expose in the Attu service";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "loadBalancerIP" = mkOption {
        description = "Attu service Load Balancer IP";
        type = (types.nullOr types.str);
        default = "";
      };
      "loadBalancerSourceRanges" = mkOption {
        description = "Attu service Load Balancer sources";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "nodePorts" = mkOption {
        type = AttuServiceNodePortsModule;
        default = { };
      };
      "ports" = mkOption {
        type = AttuServicePortsModule;
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
        description = "Attu service type";
        type = (types.nullOr types.str);
        default = "LoadBalancer";
      };
    };
  };
  AttuServiceNodePortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "http" = mkOption {
        description = "Node port for HTTP";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  AttuServicePortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "http" = mkOption {
        description = "Attu HTTP service port";
        type = (types.nullOr types.int);
        default = 80;
      };
    };
  };
  AttuStartupProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable startupProbe on Attu containers";
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
  AttuUpdateStrategyModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "rollingUpdate" = mkOption {
        description = "Attu statefulset rolling update configuration parameters";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "type" = mkOption {
        description = "Attu statefulset strategy type";
        type = (types.nullOr types.str);
        default = "RollingUpdate";
      };
    };
  };
  CoordinatorAutoscalingHpaModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations for HPA resource";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "enabled" = mkOption {
        description = "Enable HPA for Milvus Data Plane";
        type = types.bool;
        default = false;
      };
      "maxReplicas" = mkOption {
        description = "Maximum number of Milvus Data Plane replicas";
        type = (types.nullOr types.str);
        default = "";
      };
      "minReplicas" = mkOption {
        description = "Minimum number of Milvus Data Plane replicas";
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
  CoordinatorAutoscalingModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "hpa" = mkOption {
        type = CoordinatorAutoscalingHpaModule;
        default = { };
      };
      "vpa" = mkOption {
        type = CoordinatorAutoscalingVpaModule;
        default = { };
      };
    };
  };
  CoordinatorAutoscalingVpaModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations for VPA resource";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "controlledResources" = mkOption {
        description = "VPA List of resources that the vertical pod autoscaler can control. Defaults to cpu and memory";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "enabled" = mkOption {
        description = "Enable VPA";
        type = types.bool;
        default = false;
      };
      "maxAllowed" = mkOption {
        description = "VPA Max allowed resources for the pod";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "minAllowed" = mkOption {
        description = "VPA Min allowed resources for the pod";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "updatePolicy" = mkOption {
        type = CoordinatorAutoscalingVpaUpdatePolicyModule;
        default = { };
      };
    };
  };
  CoordinatorAutoscalingVpaUpdatePolicyModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "updateMode" = mkOption {
        description = "Autoscaling update policy Specifies whether recommended updates are applied when a Pod is started and whether recommended updates are applied during the life of a Pod";
        type = (types.nullOr types.str);
        default = "Auto";
      };
    };
  };
  CoordinatorContainerPortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "grpc" = mkOption {
        description = "GRPC port for Coordinator";
        type = (types.nullOr types.int);
        default = 19530;
      };
      "metrics" = mkOption {
        description = "Metrics port for Coordinator";
        type = (types.nullOr types.int);
        default = 9091;
      };
    };
  };
  CoordinatorContainerSecurityContextCapabilitiesModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "drop" = mkOption {
        description = "List of capabilities to be dropped";
        type = (types.listOf types.str);
        default = [ "ALL" ];
      };
    };
  };
  CoordinatorContainerSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "allowPrivilegeEscalation" = mkOption {
        description = "Set container's Security Context allowPrivilegeEscalation";
        type = types.bool;
        default = false;
      };
      "capabilities" = mkOption {
        type = CoordinatorContainerSecurityContextCapabilitiesModule;
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
        type = CoordinatorContainerSecurityContextSeccompProfileModule;
        default = { };
      };
    };
  };
  CoordinatorContainerSecurityContextSeccompProfileModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "type" = mkOption {
        description = "Set container's Security Context seccomp profile";
        type = (types.nullOr types.str);
        default = "RuntimeDefault";
      };
    };
  };
  CoordinatorLivenessProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable livenessProbe on Coordinator nodes";
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
  CoordinatorMetricsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable metrics";
        type = types.bool;
        default = false;
      };
      "serviceMonitor" = mkOption {
        type = CoordinatorMetricsServiceMonitorModule;
        default = { };
      };
    };
  };
  CoordinatorMetricsServiceMonitorModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations for the ServiceMonitor Resource";
        type = (types.nullOr types.str);
        default = "";
      };
      "enabled" = mkOption {
        description = "Create ServiceMonitor Resource for scraping metrics using Prometheus Operator";
        type = types.bool;
        default = false;
      };
      "honorLabels" = mkOption {
        description = "Specify honorLabels parameter to add the scrape endpoint";
        type = types.bool;
        default = false;
      };
      "interval" = mkOption {
        description = "Interval at which metrics should be scraped.";
        type = (types.nullOr types.str);
        default = "";
      };
      "jobLabel" = mkOption {
        description = "The name of the label on the target service to use as the job name in prometheus.";
        type = (types.nullOr types.str);
        default = "";
      };
      "labels" = mkOption {
        description = "Additional labels that can be used so ServiceMonitor will be discovered by Prometheus";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "metricRelabelings" = mkOption {
        description = "MetricRelabelConfigs to apply to samples before ingestion";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "namespace" = mkOption {
        description = "Namespace for the ServiceMonitor Resource (defaults to the Release Namespace)";
        type = (types.nullOr types.str);
        default = "";
      };
      "relabelings" = mkOption {
        description = "RelabelConfigs to apply to samples before scraping";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "scrapeTimeout" = mkOption {
        description = "Timeout after which the scrape is ended";
        type = (types.nullOr types.str);
        default = "";
      };
      "selector" = mkOption {
        description = "Prometheus instance selector labels";
        type = (types.attrsOf types.anything);
        default = { };
      };
    };
  };
  CoordinatorModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "affinity" = mkOption {
        description = "Affinity for Coordinator pods assignment";
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
      "autoscaling" = mkOption {
        type = CoordinatorAutoscalingModule;
        default = { };
      };
      "command" = mkOption {
        description = "Override default container command (useful when using custom images)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "containerPorts" = mkOption {
        type = CoordinatorContainerPortsModule;
        default = { };
      };
      "containerSecurityContext" = mkOption {
        type = CoordinatorContainerSecurityContextModule;
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
      "defaultConfig" = mkOption {
        description = "Default override configuration from the common set in milvus.defaultConfig";
        type = (types.nullOr types.str);
        default = "" "";
      };
      "enableDefaultInitContainers" = mkOption {
        description = "Deploy default init containers";
        type = types.bool;
        default = true;
      };
      "enabled" = mkOption {
        description = "Enable Coordinator deployment";
        type = types.bool;
        default = true;
      };
      "existingConfigMap" = mkOption {
        description = "name of a ConfigMap with existing configuration for the default configuration";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraConfig" = mkOption {
        description = "Override configuration";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "extraConfigExistingConfigMap" = mkOption {
        description = "name of a ConfigMap with existing configuration for the Dashboard";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraEnvVars" = mkOption {
        description = "Array with extra environment variables to add to data coordinator nodes";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraEnvVarsCM" = mkOption {
        description = "Name of existing ConfigMap containing extra env vars for data coordinator nodes";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraEnvVarsSecret" = mkOption {
        description = "Name of existing Secret containing extra env vars for data coordinator nodes";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraVolumeMounts" = mkOption {
        description = "Optionally specify extra list of additional volumeMounts for the Coordinator container(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraVolumes" = mkOption {
        description = "Optionally specify extra list of additional volumes for the Coordinator pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "hostAliases" = mkOption {
        description = "data coordinator pods host aliases";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "initContainers" = mkOption {
        description = "Add additional init containers to the Coordinator pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "lifecycleHooks" = mkOption {
        description = "for the data coordinator container(s) to automate configuration before or after startup";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "livenessProbe" = mkOption {
        type = CoordinatorLivenessProbeModule;
        default = { };
      };
      "metrics" = mkOption {
        type = CoordinatorMetricsModule;
        default = { };
      };
      "networkPolicy" = mkOption {
        type = CoordinatorNetworkPolicyModule;
        default = { };
      };
      "nodeAffinityPreset" = mkOption {
        type = CoordinatorNodeAffinityPresetModule;
        default = { };
      };
      "nodeSelector" = mkOption {
        description = "Node labels for Coordinator pods assignment";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "pdb" = mkOption {
        type = CoordinatorPdbModule;
        default = { };
      };
      "podAffinityPreset" = mkOption {
        description = "Pod affinity preset. Ignored if `data coordinator.affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "";
      };
      "podAnnotations" = mkOption {
        description = "Annotations for data coordinator pods";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "podAntiAffinityPreset" = mkOption {
        description = "Pod anti-affinity preset. Ignored if `data coordinator.affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "soft";
      };
      "podLabels" = mkOption {
        description = "Extra labels for data coordinator pods";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "podSecurityContext" = mkOption {
        type = CoordinatorPodSecurityContextModule;
        default = { };
      };
      "priorityClassName" = mkOption {
        description = "Coordinator pods' priorityClassName";
        type = (types.nullOr types.str);
        default = "";
      };
      "readinessProbe" = mkOption {
        type = CoordinatorReadinessProbeModule;
        default = { };
      };
      "replicaCount" = mkOption {
        description = "Number of Coordinator replicas to deploy";
        type = (types.nullOr types.int);
        default = 1;
      };
      "resources" = mkOption {
        description = "Set container requests and limits for different resources like CPU or memory (essential for production workloads)";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "resourcesPreset" = mkOption {
        description = "Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if coordinator.resources is set (coordinator.resources is recommended for production).";
        type = (types.nullOr types.str);
        default = "micro";
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
      "service" = mkOption {
        type = CoordinatorServiceModule;
        default = { };
      };
      "serviceAccount" = mkOption {
        type = CoordinatorServiceAccountModule;
        default = { };
      };
      "sidecars" = mkOption {
        description = "Add additional sidecar containers to the Coordinator pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "startupProbe" = mkOption {
        type = CoordinatorStartupProbeModule;
        default = { };
      };
      "tolerations" = mkOption {
        description = "Tolerations for Coordinator pods assignment";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "topologySpreadConstraints" = mkOption {
        description = "Topology Spread Constraints for pod assignment spread across your cluster among failure-domains";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "updateStrategy" = mkOption {
        type = CoordinatorUpdateStrategyModule;
        default = { };
      };
    };
  };
  CoordinatorNetworkPolicyModule = types.submodule {
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
  CoordinatorNodeAffinityPresetModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "key" = mkOption {
        description = "Node label key to match. Ignored if `data coordinator.affinity` is set";
        type = (types.nullOr types.str);
        default = "";
      };
      "type" = mkOption {
        description = "Node affinity preset type. Ignored if `data coordinator.affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "";
      };
      "values" = mkOption {
        description = "Node label values to match. Ignored if `data coordinator.affinity` is set";
        type = (types.listOf types.anything);
        default = [ ];
      };
    };
  };
  CoordinatorPdbModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "create" = mkOption {
        description = "Enable/disable a Pod Disruption Budget creation";
        type = types.bool;
        default = true;
      };
    };
  };
  CoordinatorPodSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enabled Coordinator pods' Security Context";
        type = types.bool;
        default = true;
      };
      "fsGroup" = mkOption {
        description = "Set Coordinator pod's Security Context fsGroup";
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
  CoordinatorReadinessProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable readinessProbe on Coordinator nodes";
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
  CoordinatorServiceAccountModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Additional custom annotations for the ServiceAccount";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "automountServiceAccountToken" = mkOption {
        description = "Allows auto mount of ServiceAccountToken on the serviceAccount created";
        type = types.bool;
        default = false;
      };
      "create" = mkOption {
        description = "Enable creation of ServiceAccount for Coordinator pods";
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
  CoordinatorServiceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Additional custom annotations for Coordinator service";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "clusterIP" = mkOption {
        description = "Coordinator service Cluster IP";
        type = (types.nullOr types.str);
        default = "";
      };
      "externalTrafficPolicy" = mkOption {
        description = "Coordinator service external traffic policy";
        type = (types.nullOr types.str);
        default = "Cluster";
      };
      "extraPorts" = mkOption {
        description = "Extra ports to expose in the Coordinator service";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "loadBalancerIP" = mkOption {
        description = "Coordinator service Load Balancer IP";
        type = (types.nullOr types.str);
        default = "";
      };
      "loadBalancerSourceRanges" = mkOption {
        description = "Coordinator service Load Balancer sources";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "nodePorts" = mkOption {
        type = CoordinatorServiceNodePortsModule;
        default = { };
      };
      "ports" = mkOption {
        type = CoordinatorServicePortsModule;
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
        description = "Coordinator service type";
        type = (types.nullOr types.str);
        default = "ClusterIP";
      };
    };
  };
  CoordinatorServiceNodePortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "grpc" = mkOption {
        description = "Node port for GRPC";
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
  CoordinatorServicePortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "grpc" = mkOption {
        description = "Coordinator GRPC service port";
        type = (types.nullOr types.int);
        default = 19530;
      };
      "metrics" = mkOption {
        description = "Coordinator Metrics service port";
        type = (types.nullOr types.int);
        default = 9091;
      };
    };
  };
  CoordinatorStartupProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable startupProbe on Coordinator containers";
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
  CoordinatorUpdateStrategyModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "rollingUpdate" = mkOption {
        description = "Coordinator statefulset rolling update configuration parameters";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "type" = mkOption {
        description = "Coordinator statefulset strategy type";
        type = (types.nullOr types.str);
        default = "RollingUpdate";
      };
    };
  };
  DataCoordAutoscalingHpaModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations for HPA resource";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "enabled" = mkOption {
        description = "Enable HPA for Milvus Data Plane";
        type = types.bool;
        default = false;
      };
      "maxReplicas" = mkOption {
        description = "Maximum number of Milvus Data Plane replicas";
        type = (types.nullOr types.str);
        default = "";
      };
      "minReplicas" = mkOption {
        description = "Minimum number of Milvus Data Plane replicas";
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
  DataCoordAutoscalingModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "hpa" = mkOption {
        type = DataCoordAutoscalingHpaModule;
        default = { };
      };
      "vpa" = mkOption {
        type = DataCoordAutoscalingVpaModule;
        default = { };
      };
    };
  };
  DataCoordAutoscalingVpaModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations for VPA resource";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "controlledResources" = mkOption {
        description = "VPA List of resources that the vertical pod autoscaler can control. Defaults to cpu and memory";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "enabled" = mkOption {
        description = "Enable VPA";
        type = types.bool;
        default = false;
      };
      "maxAllowed" = mkOption {
        description = "VPA Max allowed resources for the pod";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "minAllowed" = mkOption {
        description = "VPA Min allowed resources for the pod";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "updatePolicy" = mkOption {
        type = DataCoordAutoscalingVpaUpdatePolicyModule;
        default = { };
      };
    };
  };
  DataCoordAutoscalingVpaUpdatePolicyModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "updateMode" = mkOption {
        description = "Autoscaling update policy Specifies whether recommended updates are applied when a Pod is started and whether recommended updates are applied during the life of a Pod";
        type = (types.nullOr types.str);
        default = "Auto";
      };
    };
  };
  DataCoordContainerPortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "grpc" = mkOption {
        description = "GRPC port for Data Coordinator";
        type = (types.nullOr types.int);
        default = 19530;
      };
      "metrics" = mkOption {
        description = "Metrics port for Data Coordinator";
        type = (types.nullOr types.int);
        default = 9091;
      };
    };
  };
  DataCoordContainerSecurityContextCapabilitiesModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "drop" = mkOption {
        description = "List of capabilities to be dropped";
        type = (types.listOf types.str);
        default = [ "ALL" ];
      };
    };
  };
  DataCoordContainerSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "allowPrivilegeEscalation" = mkOption {
        description = "Set container's Security Context allowPrivilegeEscalation";
        type = types.bool;
        default = false;
      };
      "capabilities" = mkOption {
        type = DataCoordContainerSecurityContextCapabilitiesModule;
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
        type = DataCoordContainerSecurityContextSeccompProfileModule;
        default = { };
      };
    };
  };
  DataCoordContainerSecurityContextSeccompProfileModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "type" = mkOption {
        description = "Set container's Security Context seccomp profile";
        type = (types.nullOr types.str);
        default = "RuntimeDefault";
      };
    };
  };
  DataCoordLivenessProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable livenessProbe on Data Coordinator nodes";
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
  DataCoordMetricsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable metrics";
        type = types.bool;
        default = false;
      };
      "serviceMonitor" = mkOption {
        type = DataCoordMetricsServiceMonitorModule;
        default = { };
      };
    };
  };
  DataCoordMetricsServiceMonitorModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations for the ServiceMonitor Resource";
        type = (types.nullOr types.str);
        default = "";
      };
      "enabled" = mkOption {
        description = "Create ServiceMonitor Resource for scraping metrics using Prometheus Operator";
        type = types.bool;
        default = false;
      };
      "honorLabels" = mkOption {
        description = "Specify honorLabels parameter to add the scrape endpoint";
        type = types.bool;
        default = false;
      };
      "interval" = mkOption {
        description = "Interval at which metrics should be scraped.";
        type = (types.nullOr types.str);
        default = "";
      };
      "jobLabel" = mkOption {
        description = "The name of the label on the target service to use as the job name in prometheus.";
        type = (types.nullOr types.str);
        default = "";
      };
      "labels" = mkOption {
        description = "Additional labels that can be used so ServiceMonitor will be discovered by Prometheus";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "metricRelabelings" = mkOption {
        description = "MetricRelabelConfigs to apply to samples before ingestion";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "namespace" = mkOption {
        description = "Namespace for the ServiceMonitor Resource (defaults to the Release Namespace)";
        type = (types.nullOr types.str);
        default = "";
      };
      "relabelings" = mkOption {
        description = "RelabelConfigs to apply to samples before scraping";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "scrapeTimeout" = mkOption {
        description = "Timeout after which the scrape is ended";
        type = (types.nullOr types.str);
        default = "";
      };
      "selector" = mkOption {
        description = "Prometheus instance selector labels";
        type = (types.attrsOf types.anything);
        default = { };
      };
    };
  };
  DataCoordModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "affinity" = mkOption {
        description = "Affinity for Data Coordinator pods assignment";
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
      "autoscaling" = mkOption {
        type = DataCoordAutoscalingModule;
        default = { };
      };
      "command" = mkOption {
        description = "Override default container command (useful when using custom images)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "containerPorts" = mkOption {
        type = DataCoordContainerPortsModule;
        default = { };
      };
      "containerSecurityContext" = mkOption {
        type = DataCoordContainerSecurityContextModule;
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
      "defaultConfig" = mkOption {
        description = "Default override configuration from the common set in milvus.defaultConfig";
        type = (types.nullOr types.str);
        default = "" "";
      };
      "enableDefaultInitContainers" = mkOption {
        description = "Deploy default init containers";
        type = types.bool;
        default = true;
      };
      "enabled" = mkOption {
        description = "Enable Data Coordinator deployment";
        type = types.bool;
        default = true;
      };
      "existingConfigMap" = mkOption {
        description = "name of a ConfigMap with existing configuration for the default configuration";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraConfig" = mkOption {
        description = "Override configuration";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "extraConfigExistingConfigMap" = mkOption {
        description = "name of a ConfigMap with existing configuration for the Dashboard";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraEnvVars" = mkOption {
        description = "Array with extra environment variables to add to data coordinator nodes";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraEnvVarsCM" = mkOption {
        description = "Name of existing ConfigMap containing extra env vars for data coordinator nodes";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraEnvVarsSecret" = mkOption {
        description = "Name of existing Secret containing extra env vars for data coordinator nodes";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraVolumeMounts" = mkOption {
        description = "Optionally specify extra list of additional volumeMounts for the Data Coordinator container(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraVolumes" = mkOption {
        description = "Optionally specify extra list of additional volumes for the Data Coordinator pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "hostAliases" = mkOption {
        description = "data coordinator pods host aliases";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "initContainers" = mkOption {
        description = "Add additional init containers to the Data Coordinator pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "lifecycleHooks" = mkOption {
        description = "for the data coordinator container(s) to automate configuration before or after startup";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "livenessProbe" = mkOption {
        type = DataCoordLivenessProbeModule;
        default = { };
      };
      "metrics" = mkOption {
        type = DataCoordMetricsModule;
        default = { };
      };
      "networkPolicy" = mkOption {
        type = DataCoordNetworkPolicyModule;
        default = { };
      };
      "nodeAffinityPreset" = mkOption {
        type = DataCoordNodeAffinityPresetModule;
        default = { };
      };
      "nodeSelector" = mkOption {
        description = "Node labels for Data Coordinator pods assignment";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "pdb" = mkOption {
        type = DataCoordPdbModule;
        default = { };
      };
      "podAffinityPreset" = mkOption {
        description = "Pod affinity preset. Ignored if `data coordinator.affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "";
      };
      "podAnnotations" = mkOption {
        description = "Annotations for data coordinator pods";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "podAntiAffinityPreset" = mkOption {
        description = "Pod anti-affinity preset. Ignored if `data coordinator.affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "soft";
      };
      "podLabels" = mkOption {
        description = "Extra labels for data coordinator pods";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "podSecurityContext" = mkOption {
        type = DataCoordPodSecurityContextModule;
        default = { };
      };
      "priorityClassName" = mkOption {
        description = "Data Coordinator pods' priorityClassName";
        type = (types.nullOr types.str);
        default = "";
      };
      "readinessProbe" = mkOption {
        type = DataCoordReadinessProbeModule;
        default = { };
      };
      "replicaCount" = mkOption {
        description = "Number of Data Coordinator replicas to deploy";
        type = (types.nullOr types.int);
        default = 1;
      };
      "resources" = mkOption {
        description = "Set container requests and limits for different resources like CPU or memory (essential for production workloads)";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "resourcesPreset" = mkOption {
        description = "Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if dataCoord.resources is set (dataCoord.resources is recommended for production).";
        type = (types.nullOr types.str);
        default = "micro";
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
      "service" = mkOption {
        type = DataCoordServiceModule;
        default = { };
      };
      "serviceAccount" = mkOption {
        type = DataCoordServiceAccountModule;
        default = { };
      };
      "sidecars" = mkOption {
        description = "Add additional sidecar containers to the Data Coordinator pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "startupProbe" = mkOption {
        type = DataCoordStartupProbeModule;
        default = { };
      };
      "tolerations" = mkOption {
        description = "Tolerations for Data Coordinator pods assignment";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "topologySpreadConstraints" = mkOption {
        description = "Topology Spread Constraints for pod assignment spread across your cluster among failure-domains";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "updateStrategy" = mkOption {
        type = DataCoordUpdateStrategyModule;
        default = { };
      };
    };
  };
  DataCoordNetworkPolicyModule = types.submodule {
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
  DataCoordNodeAffinityPresetModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "key" = mkOption {
        description = "Node label key to match. Ignored if `data coordinator.affinity` is set";
        type = (types.nullOr types.str);
        default = "";
      };
      "type" = mkOption {
        description = "Node affinity preset type. Ignored if `data coordinator.affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "";
      };
      "values" = mkOption {
        description = "Node label values to match. Ignored if `data coordinator.affinity` is set";
        type = (types.listOf types.anything);
        default = [ ];
      };
    };
  };
  DataCoordPdbModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "create" = mkOption {
        description = "Enable/disable a Pod Disruption Budget creation";
        type = types.bool;
        default = true;
      };
    };
  };
  DataCoordPodSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enabled Data Coordinator pods' Security Context";
        type = types.bool;
        default = true;
      };
      "fsGroup" = mkOption {
        description = "Set Data Coordinator pod's Security Context fsGroup";
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
  DataCoordReadinessProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable readinessProbe on Data Coordinator nodes";
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
  DataCoordServiceAccountModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Additional custom annotations for the ServiceAccount";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "automountServiceAccountToken" = mkOption {
        description = "Allows auto mount of ServiceAccountToken on the serviceAccount created";
        type = types.bool;
        default = false;
      };
      "create" = mkOption {
        description = "Enable creation of ServiceAccount for Data Coordinator pods";
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
  DataCoordServiceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Additional custom annotations for Data Coordinator service";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "clusterIP" = mkOption {
        description = "Data Coordinator service Cluster IP";
        type = (types.nullOr types.str);
        default = "";
      };
      "externalTrafficPolicy" = mkOption {
        description = "Data Coordinator service external traffic policy";
        type = (types.nullOr types.str);
        default = "Cluster";
      };
      "extraPorts" = mkOption {
        description = "Extra ports to expose in the Data Coordinator service";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "loadBalancerIP" = mkOption {
        description = "Data Coordinator service Load Balancer IP";
        type = (types.nullOr types.str);
        default = "";
      };
      "loadBalancerSourceRanges" = mkOption {
        description = "Data Coordinator service Load Balancer sources";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "nodePorts" = mkOption {
        type = DataCoordServiceNodePortsModule;
        default = { };
      };
      "ports" = mkOption {
        type = DataCoordServicePortsModule;
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
        description = "Data Coordinator service type";
        type = (types.nullOr types.str);
        default = "ClusterIP";
      };
    };
  };
  DataCoordServiceNodePortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "grpc" = mkOption {
        description = "Node port for GRPC";
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
  DataCoordServicePortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "grpc" = mkOption {
        description = "Data Coordinator GRPC service port";
        type = (types.nullOr types.int);
        default = 19530;
      };
      "metrics" = mkOption {
        description = "Data Coordinator Metrics service port";
        type = (types.nullOr types.int);
        default = 9091;
      };
    };
  };
  DataCoordStartupProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable startupProbe on Data Coordinator containers";
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
  DataCoordUpdateStrategyModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "rollingUpdate" = mkOption {
        description = "Data Coordinator statefulset rolling update configuration parameters";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "type" = mkOption {
        description = "Data Coordinator statefulset strategy type";
        type = (types.nullOr types.str);
        default = "RollingUpdate";
      };
    };
  };
  DataNodeAutoscalingHpaModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations for HPA resource";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "enabled" = mkOption {
        description = "Enable HPA for Milvus Data Plane";
        type = types.bool;
        default = false;
      };
      "maxReplicas" = mkOption {
        description = "Maximum number of Milvus Data Plane replicas";
        type = (types.nullOr types.str);
        default = "";
      };
      "minReplicas" = mkOption {
        description = "Minimum number of Milvus Data Plane replicas";
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
  DataNodeAutoscalingModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "hpa" = mkOption {
        type = DataNodeAutoscalingHpaModule;
        default = { };
      };
      "vpa" = mkOption {
        type = DataNodeAutoscalingVpaModule;
        default = { };
      };
    };
  };
  DataNodeAutoscalingVpaModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations for VPA resource";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "controlledResources" = mkOption {
        description = "VPA List of resources that the vertical pod autoscaler can control. Defaults to cpu and memory";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "enabled" = mkOption {
        description = "Enable VPA";
        type = types.bool;
        default = false;
      };
      "maxAllowed" = mkOption {
        description = "VPA Max allowed resources for the pod";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "minAllowed" = mkOption {
        description = "VPA Min allowed resources for the pod";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "updatePolicy" = mkOption {
        type = DataNodeAutoscalingVpaUpdatePolicyModule;
        default = { };
      };
    };
  };
  DataNodeAutoscalingVpaUpdatePolicyModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "updateMode" = mkOption {
        description = "Autoscaling update policy Specifies whether recommended updates are applied when a Pod is started and whether recommended updates are applied during the life of a Pod";
        type = (types.nullOr types.str);
        default = "Auto";
      };
    };
  };
  DataNodeContainerPortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "grpc" = mkOption {
        description = "GRPC port for Data Node";
        type = (types.nullOr types.int);
        default = 19530;
      };
      "metrics" = mkOption {
        description = "Metrics port for Data Node";
        type = (types.nullOr types.int);
        default = 9091;
      };
    };
  };
  DataNodeContainerSecurityContextCapabilitiesModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "drop" = mkOption {
        description = "List of capabilities to be dropped";
        type = (types.listOf types.str);
        default = [ "ALL" ];
      };
    };
  };
  DataNodeContainerSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "allowPrivilegeEscalation" = mkOption {
        description = "Set container's Security Context allowPrivilegeEscalation";
        type = types.bool;
        default = false;
      };
      "capabilities" = mkOption {
        type = DataNodeContainerSecurityContextCapabilitiesModule;
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
        type = DataNodeContainerSecurityContextSeccompProfileModule;
        default = { };
      };
    };
  };
  DataNodeContainerSecurityContextSeccompProfileModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "type" = mkOption {
        description = "Set container's Security Context seccomp profile";
        type = (types.nullOr types.str);
        default = "RuntimeDefault";
      };
    };
  };
  DataNodeLivenessProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable livenessProbe on Data Node nodes";
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
  DataNodeMetricsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable metrics";
        type = types.bool;
        default = false;
      };
      "serviceMonitor" = mkOption {
        type = DataNodeMetricsServiceMonitorModule;
        default = { };
      };
    };
  };
  DataNodeMetricsServiceMonitorModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations for the ServiceMonitor Resource";
        type = (types.nullOr types.str);
        default = "";
      };
      "enabled" = mkOption {
        description = "Create ServiceMonitor Resource for scraping metrics using Prometheus Operator";
        type = types.bool;
        default = false;
      };
      "honorLabels" = mkOption {
        description = "Specify honorLabels parameter to add the scrape endpoint";
        type = types.bool;
        default = false;
      };
      "interval" = mkOption {
        description = "Interval at which metrics should be scraped.";
        type = (types.nullOr types.str);
        default = "";
      };
      "jobLabel" = mkOption {
        description = "The name of the label on the target service to use as the job name in prometheus.";
        type = (types.nullOr types.str);
        default = "";
      };
      "labels" = mkOption {
        description = "Additional labels that can be used so ServiceMonitor will be discovered by Prometheus";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "metricRelabelings" = mkOption {
        description = "MetricRelabelConfigs to apply to samples before ingestion";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "namespace" = mkOption {
        description = "Namespace for the ServiceMonitor Resource (defaults to the Release Namespace)";
        type = (types.nullOr types.str);
        default = "";
      };
      "relabelings" = mkOption {
        description = "RelabelConfigs to apply to samples before scraping";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "scrapeTimeout" = mkOption {
        description = "Timeout after which the scrape is ended";
        type = (types.nullOr types.str);
        default = "";
      };
      "selector" = mkOption {
        description = "Prometheus instance selector labels";
        type = (types.attrsOf types.anything);
        default = { };
      };
    };
  };
  DataNodeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "affinity" = mkOption {
        description = "Affinity for Data Node pods assignment";
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
      "autoscaling" = mkOption {
        type = DataNodeAutoscalingModule;
        default = { };
      };
      "command" = mkOption {
        description = "Override default container command (useful when using custom images)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "containerPorts" = mkOption {
        type = DataNodeContainerPortsModule;
        default = { };
      };
      "containerSecurityContext" = mkOption {
        type = DataNodeContainerSecurityContextModule;
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
      "defaultConfig" = mkOption {
        description = "Default override configuration from the common set in milvus.defaultConfig";
        type = (types.nullOr types.str);
        default = "" "";
      };
      "enableDefaultInitContainers" = mkOption {
        description = "Deploy default init containers";
        type = types.bool;
        default = true;
      };
      "enabled" = mkOption {
        description = "Enable Data Node deployment";
        type = types.bool;
        default = true;
      };
      "existingConfigMap" = mkOption {
        description = "name of a ConfigMap with existing configuration for the default configuration";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraConfig" = mkOption {
        description = "Override configuration";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "extraConfigExistingConfigMap" = mkOption {
        description = "name of a ConfigMap with existing configuration for the Dashboard";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraEnvVars" = mkOption {
        description = "Array with extra environment variables to add to data node nodes";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraEnvVarsCM" = mkOption {
        description = "Name of existing ConfigMap containing extra env vars for data node nodes";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraEnvVarsSecret" = mkOption {
        description = "Name of existing Secret containing extra env vars for data node nodes";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraVolumeMounts" = mkOption {
        description = "Optionally specify extra list of additional volumeMounts for the Data Node container(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraVolumes" = mkOption {
        description = "Optionally specify extra list of additional volumes for the Data Node pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "hostAliases" = mkOption {
        description = "data node pods host aliases";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "initContainers" = mkOption {
        description = "Add additional init containers to the Data Node pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "lifecycleHooks" = mkOption {
        description = "for the data node container(s) to automate configuration before or after startup";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "livenessProbe" = mkOption {
        type = DataNodeLivenessProbeModule;
        default = { };
      };
      "metrics" = mkOption {
        type = DataNodeMetricsModule;
        default = { };
      };
      "networkPolicy" = mkOption {
        type = DataNodeNetworkPolicyModule;
        default = { };
      };
      "nodeAffinityPreset" = mkOption {
        type = DataNodeNodeAffinityPresetModule;
        default = { };
      };
      "nodeSelector" = mkOption {
        description = "Node labels for Data Node pods assignment";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "pdb" = mkOption {
        type = DataNodePdbModule;
        default = { };
      };
      "podAffinityPreset" = mkOption {
        description = "Pod affinity preset. Ignored if `data node.affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "";
      };
      "podAnnotations" = mkOption {
        description = "Annotations for data node pods";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "podAntiAffinityPreset" = mkOption {
        description = "Pod anti-affinity preset. Ignored if `data node.affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "soft";
      };
      "podLabels" = mkOption {
        description = "Extra labels for data node pods";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "podSecurityContext" = mkOption {
        type = DataNodePodSecurityContextModule;
        default = { };
      };
      "priorityClassName" = mkOption {
        description = "Data Node pods' priorityClassName";
        type = (types.nullOr types.str);
        default = "";
      };
      "readinessProbe" = mkOption {
        type = DataNodeReadinessProbeModule;
        default = { };
      };
      "replicaCount" = mkOption {
        description = "Number of Data Node replicas to deploy";
        type = (types.nullOr types.int);
        default = 1;
      };
      "resources" = mkOption {
        description = "Set container requests and limits for different resources like CPU or memory (essential for production workloads)";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "resourcesPreset" = mkOption {
        description = "Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if dataNode.resources is set (dataNode.resources is recommended for production).";
        type = (types.nullOr types.str);
        default = "micro";
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
      "service" = mkOption {
        type = DataNodeServiceModule;
        default = { };
      };
      "serviceAccount" = mkOption {
        type = DataNodeServiceAccountModule;
        default = { };
      };
      "sidecars" = mkOption {
        description = "Add additional sidecar containers to the Data Node pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "startupProbe" = mkOption {
        type = DataNodeStartupProbeModule;
        default = { };
      };
      "tolerations" = mkOption {
        description = "Tolerations for Data Node pods assignment";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "topologySpreadConstraints" = mkOption {
        description = "Topology Spread Constraints for pod assignment spread across your cluster among failure-domains";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "updateStrategy" = mkOption {
        type = DataNodeUpdateStrategyModule;
        default = { };
      };
    };
  };
  DataNodeNetworkPolicyModule = types.submodule {
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
  DataNodeNodeAffinityPresetModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "key" = mkOption {
        description = "Node label key to match. Ignored if `data node.affinity` is set";
        type = (types.nullOr types.str);
        default = "";
      };
      "type" = mkOption {
        description = "Node affinity preset type. Ignored if `data node.affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "";
      };
      "values" = mkOption {
        description = "Node label values to match. Ignored if `data node.affinity` is set";
        type = (types.listOf types.anything);
        default = [ ];
      };
    };
  };
  DataNodePdbModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "create" = mkOption {
        description = "Enable/disable a Pod Disruption Budget creation";
        type = types.bool;
        default = true;
      };
    };
  };
  DataNodePodSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enabled Data Node pods' Security Context";
        type = types.bool;
        default = true;
      };
      "fsGroup" = mkOption {
        description = "Set Data Node pod's Security Context fsGroup";
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
  DataNodeReadinessProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable readinessProbe on Data Node nodes";
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
  DataNodeServiceAccountModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Additional custom annotations for the ServiceAccount";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "automountServiceAccountToken" = mkOption {
        description = "Allows auto mount of ServiceAccountToken on the serviceAccount created";
        type = types.bool;
        default = false;
      };
      "create" = mkOption {
        description = "Enable creation of ServiceAccount for Data Node pods";
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
  DataNodeServiceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Additional custom annotations for Data Node service";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "clusterIP" = mkOption {
        description = "Data Node service Cluster IP";
        type = (types.nullOr types.str);
        default = "";
      };
      "externalTrafficPolicy" = mkOption {
        description = "Data Node service external traffic policy";
        type = (types.nullOr types.str);
        default = "Cluster";
      };
      "extraPorts" = mkOption {
        description = "Extra ports to expose in the Data Node service";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "loadBalancerIP" = mkOption {
        description = "Data Node service Load Balancer IP";
        type = (types.nullOr types.str);
        default = "";
      };
      "loadBalancerSourceRanges" = mkOption {
        description = "Data Node service Load Balancer sources";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "nodePorts" = mkOption {
        type = DataNodeServiceNodePortsModule;
        default = { };
      };
      "ports" = mkOption {
        type = DataNodeServicePortsModule;
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
        description = "Data Node service type";
        type = (types.nullOr types.str);
        default = "ClusterIP";
      };
    };
  };
  DataNodeServiceNodePortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "grpc" = mkOption {
        description = "Node port for GRPC";
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
  DataNodeServicePortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "grpc" = mkOption {
        description = "Data Node GRPC service port";
        type = (types.nullOr types.int);
        default = 19530;
      };
      "metrics" = mkOption {
        description = "Data Node Metrics service port";
        type = (types.nullOr types.int);
        default = 9091;
      };
    };
  };
  DataNodeStartupProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable startupProbe on Data Node containers";
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
  DataNodeUpdateStrategyModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "rollingUpdate" = mkOption {
        description = "Data Node statefulset rolling update configuration parameters";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "type" = mkOption {
        description = "Data Node statefulset strategy type";
        type = (types.nullOr types.str);
        default = "RollingUpdate";
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
        default = { };
      };
      "rbac" = mkOption {
        type = EtcdAuthRbacModule;
        default = { };
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
        default = { };
      };
      "containerPorts" = mkOption {
        type = EtcdContainerPortsModule;
        default = { };
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
      "servers" = mkOption {
        description = "List of hostnames of the external etcd";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "tls" = mkOption {
        type = ExternalEtcdTlsModule;
        default = { };
      };
      "user" = mkOption {
        description = "User of the external etcd instance";
        type = (types.nullOr types.str);
        default = "root";
      };
    };
  };
  ExternalEtcdTlsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "caCert" = mkOption {
        description = "The secret key from the existingSecret if 'caCert' key different from the default (ca.crt)";
        type = (types.nullOr types.str);
        default = "ca.crt";
      };
      "cert" = mkOption {
        description = "The secret key from the existingSecret if 'cert' key different from the default (tls.crt)";
        type = (types.nullOr types.str);
        default = "tls.crt";
      };
      "enabled" = mkOption {
        description = "Enable TLS for etcd client connections.";
        type = types.bool;
        default = false;
      };
      "existingSecret" = mkOption {
        description = "Name of the existing secret containing the TLS certificates for external etcd client communications.";
        type = (types.nullOr types.str);
        default = "";
      };
      "key" = mkOption {
        description = "The secret key from the existingSecret if 'key' key different from the default (tls.key)";
        type = (types.nullOr types.str);
        default = "tls.key";
      };
      "keyPassword" = mkOption {
        description = "Password to access the password-protected PEM key if necessary.";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  ExternalKafkaListenerModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "protocol" = mkOption {
        description = "Kafka listener protocol. Allowed protocols: PLAINTEXT, SASL_PLAINTEXT, SASL_SSL and SSL";
        type = (types.nullOr types.str);
        default = "PLAINTEXT";
      };
    };
  };
  ExternalKafkaModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "listener" = mkOption {
        type = ExternalKafkaListenerModule;
        default = { };
      };
      "port" = mkOption {
        description = "External Kafka port";
        type = (types.nullOr types.int);
        default = 9092;
      };
      "sasl" = mkOption {
        type = ExternalKafkaSaslModule;
        default = { };
      };
      "servers" = mkOption {
        description = "External Kafka brokers";
        type = (types.listOf types.str);
        default = [ "localhost" ];
      };
      "tls" = mkOption {
        type = ExternalKafkaTlsModule;
        default = { };
      };
    };
  };
  ExternalKafkaSaslModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabledMechanisms" = mkOption {
        description = "Kafka enabled SASL mechanisms";
        type = (types.nullOr types.str);
        default = "PLAIN";
      };
      "existingSecret" = mkOption {
        description = "Name of the existing secret containing a password for SASL authentication (under the key named \"client-passwords\")";
        type = (types.nullOr types.str);
        default = "";
      };
      "existingSecretPasswordKey" = mkOption {
        description = "Name of the secret key containing the Kafka client user password";
        type = (types.nullOr types.str);
        default = "kafka-root-password";
      };
      "password" = mkOption {
        description = "Password for SASL authentication";
        type = (types.nullOr types.str);
        default = "";
      };
      "user" = mkOption {
        description = "User for SASL authentication";
        type = (types.nullOr types.str);
        default = "user";
      };
    };
  };
  ExternalKafkaTlsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "caCert" = mkOption {
        description = "The secret key from the existingSecret if 'caCert' key different from the default (ca.crt)";
        type = (types.nullOr types.str);
        default = "ca.crt";
      };
      "cert" = mkOption {
        description = "The secret key from the existingSecret if 'cert' key different from the default (tls.crt)";
        type = (types.nullOr types.str);
        default = "tls.crt";
      };
      "enabled" = mkOption {
        description = "Enable TLS for external Kafka client connections.";
        type = types.bool;
        default = false;
      };
      "existingSecret" = mkOption {
        description = "Name of the existing secret containing the TLS certificates for external Kafka client communications.";
        type = (types.nullOr types.str);
        default = "";
      };
      "key" = mkOption {
        description = "The secret key from the existingSecret if 'key' key different from the default (tls.key)";
        type = (types.nullOr types.str);
        default = "tls.key";
      };
      "keyPassword" = mkOption {
        description = "Password to access the password-protected PEM key if necessary.";
        type = (types.nullOr types.str);
        default = "";
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
        default = "milvus";
      };
      "cloudProvider" = mkOption {
        description = "External S3 cloud provider";
        type = (types.nullOr types.str);
        default = "";
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
      "iamEndpoint" = mkOption {
        description = "External S3 IAM endpoint";
        type = (types.nullOr types.str);
        default = "";
      };
      "port" = mkOption {
        description = "External S3 port number";
        type = (types.nullOr types.int);
        default = 443;
      };
      "rootPath" = mkOption {
        description = "External S3 root path";
        type = (types.nullOr types.str);
        default = "file";
      };
      "tls" = mkOption {
        type = ExternalS3TlsModule;
        default = { };
      };
    };
  };
  ExternalS3TlsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "caCert" = mkOption {
        description = "The secret key from the existingSecret if 'caCert' key different from the default (ca.crt)";
        type = (types.nullOr types.str);
        default = "ca.crt";
      };
      "enabled" = mkOption {
        description = "Enable TLS for external S3 client connections.";
        type = types.bool;
        default = false;
      };
      "existingSecret" = mkOption {
        description = "Name of the existing secret containing the TLS certificates for external S3 client communications.";
        type = (types.nullOr types.str);
        default = "";
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
      "storageClass" = mkOption {
        description = "Global StorageClass for Persistent Volume(s)";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  InitJobContainerSecurityContextCapabilitiesModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "drop" = mkOption {
        description = "List of capabilities to be dropped";
        type = (types.listOf types.str);
        default = [ "ALL" ];
      };
    };
  };
  InitJobContainerSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "allowPrivilegeEscalation" = mkOption {
        description = "Set container's Security Context allowPrivilegeEscalation";
        type = types.bool;
        default = false;
      };
      "capabilities" = mkOption {
        type = InitJobContainerSecurityContextCapabilitiesModule;
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
        type = InitJobContainerSecurityContextSeccompProfileModule;
        default = { };
      };
    };
  };
  InitJobContainerSecurityContextSeccompProfileModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "type" = mkOption {
        description = "Set container's Security Context seccomp profile";
        type = (types.nullOr types.str);
        default = "RuntimeDefault";
      };
    };
  };
  InitJobImageModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "digest" = mkOption {
        description = "PyMilvus image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag image tag (immutable tags are recommended)";
        type = (types.nullOr types.str);
        default = "";
      };
      "pullPolicy" = mkOption {
        description = "PyMilvus image pull policy";
        type = (types.nullOr types.str);
        default = "IfNotPresent";
      };
      "pullSecrets" = mkOption {
        description = "PyMilvus image pull secrets";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "registry" = mkOption {
        description = "PyMilvus image registry";
        type = (types.nullOr types.str);
        default = "REGISTRY_NAME";
      };
      "repository" = mkOption {
        description = "PyMilvus image repository";
        type = (types.nullOr types.str);
        default = "REPOSITORY_NAME/pymilvus";
      };
    };
  };
  InitJobLivenessProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable livenessProbe on init job";
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
  InitJobModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
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
      "containerSecurityContext" = mkOption {
        type = InitJobContainerSecurityContextModule;
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
      "enableDefaultInitContainers" = mkOption {
        description = "Deploy default init containers";
        type = types.bool;
        default = true;
      };
      "extraCommands" = mkOption {
        description = "Extra commands to pass to the generation job";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraEnvVars" = mkOption {
        description = "Array containing extra env vars to configure the credential init job";
        type = (types.listOf types.anything);
        default = [ ];
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
        default = [ ];
      };
      "extraVolumes" = mkOption {
        description = "Optionally specify extra list of additional volumes for the credential init job";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "forceRun" = mkOption {
        description = "Force the run of the credential job";
        type = types.bool;
        default = false;
      };
      "hostAliases" = mkOption {
        description = "Add deployment host aliases";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "image" = mkOption {
        type = InitJobImageModule;
        default = { };
      };
      "livenessProbe" = mkOption {
        type = InitJobLivenessProbeModule;
        default = { };
      };
      "networkPolicy" = mkOption {
        type = InitJobNetworkPolicyModule;
        default = { };
      };
      "podAnnotations" = mkOption {
        description = "Additional pod annotations";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "podLabels" = mkOption {
        description = "Additional pod labels";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "podSecurityContext" = mkOption {
        type = InitJobPodSecurityContextModule;
        default = { };
      };
      "readinessProbe" = mkOption {
        type = InitJobReadinessProbeModule;
        default = { };
      };
      "resources" = mkOption {
        description = "Set container requests and limits for different resources like CPU or memory (essential for production workloads)";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "resourcesPreset" = mkOption {
        description = "Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if initJob.resources is set (initJob.resources is recommended for production).";
        type = (types.nullOr types.str);
        default = "micro";
      };
      "startupProbe" = mkOption {
        type = InitJobStartupProbeModule;
        default = { };
      };
      "tls" = mkOption {
        type = InitJobTlsModule;
        default = { };
      };
    };
  };
  InitJobNetworkPolicyModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
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
  InitJobPodSecurityContextModule = types.submodule {
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
        default = [ ];
      };
      "sysctls" = mkOption {
        description = "Set kernel settings using the sysctl interface";
        type = (types.listOf types.anything);
        default = [ ];
      };
    };
  };
  InitJobReadinessProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable readinessProbe on init job";
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
  InitJobStartupProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable startupProbe on Data Coordinator containers";
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
  InitJobTlsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "caCert" = mkOption {
        description = "The secret key from the existingSecret if 'caCert' key different from the default (ca.pem)";
        type = (types.nullOr types.str);
        default = "ca.pem";
      };
      "cert" = mkOption {
        description = "The secret key from the existingSecret if 'cert' key different from the default (client.pem)";
        type = (types.nullOr types.str);
        default = "client.pem";
      };
      "existingSecret" = mkOption {
        description = "Name of the existing secret containing the TLS certificates for initJob.";
        type = (types.nullOr types.str);
        default = "";
      };
      "key" = mkOption {
        description = "The secret key from the existingSecret if 'key' key different from the default (client.key)";
        type = (types.nullOr types.str);
        default = "client.key";
      };
      "keyPassword" = mkOption {
        description = "Password to access the password-protected PEM key if necessary.";
        type = (types.nullOr types.str);
        default = "";
      };
    };
  };
  KafkaControllerModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "replicaCount" = mkOption {
        description = "Number of Kafka controller eligible (controller+broker) nodes";
        type = (types.nullOr types.int);
        default = 1;
      };
    };
  };
  KafkaListenersClientModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "protocol" = mkOption {
        description = "Kafka authentication protocol for the client listener";
        type = (types.nullOr types.str);
        default = "SASL_PLAINTEXT";
      };
    };
  };
  KafkaListenersModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "client" = mkOption {
        type = KafkaListenersClientModule;
        default = { };
      };
    };
  };
  KafkaModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "controller" = mkOption {
        type = KafkaControllerModule;
        default = { };
      };
      "enabled" = mkOption {
        description = "Enable/disable Kafka chart installation";
        type = types.bool;
        default = true;
      };
      "extraConfig" = mkOption {
        description = "Additional configuration to be appended at the end of the generated Kafka configuration file.";
        type = (types.nullOr types.str);
        default = "offsets.topic.replication.factor=1";
      };
      "listeners" = mkOption {
        type = KafkaListenersModule;
        default = { };
      };
      "sasl" = mkOption {
        type = KafkaSaslModule;
        default = { };
      };
      "service" = mkOption {
        type = KafkaServiceModule;
        default = { };
      };
    };
  };
  KafkaSaslClientModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "users" = mkOption {
        description = "Kafka client users";
        type = (types.listOf types.str);
        default = [ "user" ];
      };
    };
  };
  KafkaSaslModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "client" = mkOption {
        type = KafkaSaslClientModule;
        default = { };
      };
      "enabledMechanisms" = mkOption {
        description = "Kafka enabled SASL mechanisms";
        type = (types.nullOr types.str);
        default = "PLAIN";
      };
    };
  };
  KafkaServiceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "ports" = mkOption {
        type = KafkaServicePortsModule;
        default = { };
      };
    };
  };
  KafkaServicePortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "client" = mkOption {
        description = "Kafka svc port for client connections";
        type = (types.nullOr types.int);
        default = 9092;
      };
    };
  };
  MilvusAuthModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "enable Milvus authentication";
        type = types.bool;
        default = false;
      };
      "existingSecret" = mkOption {
        description = "Name of a secret containing the Milvus password";
        type = (types.nullOr types.str);
        default = "";
      };
      "existingSecretPasswordKey" = mkOption {
        description = "Name of the secret key containing the Milvus password";
        type = (types.nullOr types.str);
        default = "";
      };
      "password" = mkOption {
        description = "Milvus username password";
        type = (types.nullOr types.str);
        default = "";
      };
      "rootPassword" = mkOption {
        description = "Milvus root password";
        type = (types.nullOr types.str);
        default = "";
      };
      "username" = mkOption {
        description = "Milvus username";
        type = (types.nullOr types.str);
        default = "user";
      };
    };
  };
  MilvusImageModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "debug" = mkOption {
        description = "Enable debug mode";
        type = types.bool;
        default = false;
      };
      "digest" = mkOption {
        description = "Milvus image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag";
        type = (types.nullOr types.str);
        default = "";
      };
      "pullPolicy" = mkOption {
        description = "Milvus image pull policy";
        type = (types.nullOr types.str);
        default = "IfNotPresent";
      };
      "pullSecrets" = mkOption {
        description = "Milvus image pull secrets";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "registry" = mkOption {
        description = "Milvus image registry";
        type = (types.nullOr types.str);
        default = "REGISTRY_NAME";
      };
      "repository" = mkOption {
        description = "Milvus image repository";
        type = (types.nullOr types.str);
        default = "REPOSITORY_NAME/milvus";
      };
    };
  };
  MilvusModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "auth" = mkOption {
        type = MilvusAuthModule;
        default = { };
      };
      "defaultConfig" = mkOption {
        description = "Milvus components default configuration";
        type = (types.nullOr types.str);
        default = "" "";
      };
      "existingConfigMap" = mkOption {
        description = "name of a ConfigMap with existing configuration for the default configuration";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraConfig" = mkOption {
        description = "Extra configuration parameters";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "extraConfigExistingConfigMap" = mkOption {
        description = "name of a ConfigMap with existing configuration for the Dashboard";
        type = (types.nullOr types.str);
        default = "";
      };
      "image" = mkOption {
        type = MilvusImageModule;
        default = { };
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
        default = { };
      };
      "defaultBuckets" = mkOption {
        description = "Comma, semi-colon or space separated list of MinIO&reg; buckets to create";
        type = (types.nullOr types.str);
        default = "milvus";
      };
      "enabled" = mkOption {
        description = "Enable/disable MinIO&reg; chart installation";
        type = types.bool;
        default = true;
      };
      "provisioning" = mkOption {
        type = MinioProvisioningModule;
        default = { };
      };
      "service" = mkOption {
        type = MinioServiceModule;
        default = { };
      };
      "tls" = mkOption {
        type = MinioTlsModule;
        default = { };
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
        default = [ "mc anonymous set download provisioning/milvus" ];
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
        default = { };
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
  ProxyAutoscalingHpaModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations for HPA resource";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "enabled" = mkOption {
        description = "Enable HPA for Milvus Data Plane";
        type = types.bool;
        default = false;
      };
      "maxReplicas" = mkOption {
        description = "Maximum number of Milvus Data Plane replicas";
        type = (types.nullOr types.str);
        default = "";
      };
      "minReplicas" = mkOption {
        description = "Minimum number of Milvus Data Plane replicas";
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
  ProxyAutoscalingModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "hpa" = mkOption {
        type = ProxyAutoscalingHpaModule;
        default = { };
      };
      "vpa" = mkOption {
        type = ProxyAutoscalingVpaModule;
        default = { };
      };
    };
  };
  ProxyAutoscalingVpaModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations for VPA resource";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "controlledResources" = mkOption {
        description = "VPA List of resources that the vertical pod autoscaler can control. Defaults to cpu and memory";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "enabled" = mkOption {
        description = "Enable VPA";
        type = types.bool;
        default = false;
      };
      "maxAllowed" = mkOption {
        description = "VPA Max allowed resources for the pod";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "minAllowed" = mkOption {
        description = "VPA Min allowed resources for the pod";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "updatePolicy" = mkOption {
        type = ProxyAutoscalingVpaUpdatePolicyModule;
        default = { };
      };
    };
  };
  ProxyAutoscalingVpaUpdatePolicyModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "updateMode" = mkOption {
        description = "Autoscaling update policy Specifies whether recommended updates are applied when a Pod is started and whether recommended updates are applied during the life of a Pod";
        type = (types.nullOr types.str);
        default = "Auto";
      };
    };
  };
  ProxyContainerPortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "grpc" = mkOption {
        description = "GRPC port for Proxy";
        type = (types.nullOr types.int);
        default = 19530;
      };
      "grpcInternal" = mkOption {
        description = "GRPC internal port for Proxy";
        type = (types.nullOr types.int);
        default = 19529;
      };
      "metrics" = mkOption {
        description = "Metrics port for Proxy";
        type = (types.nullOr types.int);
        default = 9091;
      };
    };
  };
  ProxyContainerSecurityContextCapabilitiesModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "drop" = mkOption {
        description = "List of capabilities to be dropped";
        type = (types.listOf types.str);
        default = [ "ALL" ];
      };
    };
  };
  ProxyContainerSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "allowPrivilegeEscalation" = mkOption {
        description = "Set container's Security Context allowPrivilegeEscalation";
        type = types.bool;
        default = false;
      };
      "capabilities" = mkOption {
        type = ProxyContainerSecurityContextCapabilitiesModule;
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
        type = ProxyContainerSecurityContextSeccompProfileModule;
        default = { };
      };
    };
  };
  ProxyContainerSecurityContextSeccompProfileModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "type" = mkOption {
        description = "Set container's Security Context seccomp profile";
        type = (types.nullOr types.str);
        default = "RuntimeDefault";
      };
    };
  };
  ProxyLivenessProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable livenessProbe on Proxy nodes";
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
  ProxyMetricsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable metrics";
        type = types.bool;
        default = false;
      };
      "serviceMonitor" = mkOption {
        type = ProxyMetricsServiceMonitorModule;
        default = { };
      };
    };
  };
  ProxyMetricsServiceMonitorModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations for the ServiceMonitor Resource";
        type = (types.nullOr types.str);
        default = "";
      };
      "enabled" = mkOption {
        description = "Create ServiceMonitor Resource for scraping metrics using Prometheus Operator";
        type = types.bool;
        default = false;
      };
      "honorLabels" = mkOption {
        description = "Specify honorLabels parameter to add the scrape endpoint";
        type = types.bool;
        default = false;
      };
      "interval" = mkOption {
        description = "Interval at which metrics should be scraped.";
        type = (types.nullOr types.str);
        default = "";
      };
      "jobLabel" = mkOption {
        description = "The name of the label on the target service to use as the job name in prometheus.";
        type = (types.nullOr types.str);
        default = "";
      };
      "labels" = mkOption {
        description = "Additional labels that can be used so ServiceMonitor will be discovered by Prometheus";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "metricRelabelings" = mkOption {
        description = "MetricRelabelConfigs to apply to samples before ingestion";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "namespace" = mkOption {
        description = "Namespace for the ServiceMonitor Resource (defaults to the Release Namespace)";
        type = (types.nullOr types.str);
        default = "";
      };
      "relabelings" = mkOption {
        description = "RelabelConfigs to apply to samples before scraping";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "scrapeTimeout" = mkOption {
        description = "Timeout after which the scrape is ended";
        type = (types.nullOr types.str);
        default = "";
      };
      "selector" = mkOption {
        description = "Prometheus instance selector labels";
        type = (types.attrsOf types.anything);
        default = { };
      };
    };
  };
  ProxyModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "affinity" = mkOption {
        description = "Affinity for Proxy pods assignment";
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
      "autoscaling" = mkOption {
        type = ProxyAutoscalingModule;
        default = { };
      };
      "command" = mkOption {
        description = "Override default container command (useful when using custom images)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "containerPorts" = mkOption {
        type = ProxyContainerPortsModule;
        default = { };
      };
      "containerSecurityContext" = mkOption {
        type = ProxyContainerSecurityContextModule;
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
      "defaultConfig" = mkOption {
        description = "Default override configuration from the common set in milvus.defaultConfig";
        type = (types.nullOr types.str);
        default = "" "";
      };
      "enableDefaultInitContainers" = mkOption {
        description = "Deploy default init containers";
        type = types.bool;
        default = true;
      };
      "enabled" = mkOption {
        description = "Enable Proxy deployment";
        type = types.bool;
        default = true;
      };
      "existingConfigMap" = mkOption {
        description = "name of a ConfigMap with existing configuration for the default configuration";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraConfig" = mkOption {
        description = "Override configuration";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "extraConfigExistingConfigMap" = mkOption {
        description = "name of a ConfigMap with existing configuration for the Dashboard";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraEnvVars" = mkOption {
        description = "Array with extra environment variables to add to proxy nodes";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraEnvVarsCM" = mkOption {
        description = "Name of existing ConfigMap containing extra env vars for proxy nodes";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraEnvVarsSecret" = mkOption {
        description = "Name of existing Secret containing extra env vars for proxy nodes";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraVolumeMounts" = mkOption {
        description = "Optionally specify extra list of additional volumeMounts for the Proxy container(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraVolumes" = mkOption {
        description = "Optionally specify extra list of additional volumes for the Proxy pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "hostAliases" = mkOption {
        description = "proxy pods host aliases";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "initContainers" = mkOption {
        description = "Add additional init containers to the Proxy pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "lifecycleHooks" = mkOption {
        description = "for the proxy container(s) to automate configuration before or after startup";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "livenessProbe" = mkOption {
        type = ProxyLivenessProbeModule;
        default = { };
      };
      "metrics" = mkOption {
        type = ProxyMetricsModule;
        default = { };
      };
      "networkPolicy" = mkOption {
        type = ProxyNetworkPolicyModule;
        default = { };
      };
      "nodeAffinityPreset" = mkOption {
        type = ProxyNodeAffinityPresetModule;
        default = { };
      };
      "nodeSelector" = mkOption {
        description = "Node labels for Proxy pods assignment";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "pdb" = mkOption {
        type = ProxyPdbModule;
        default = { };
      };
      "podAffinityPreset" = mkOption {
        description = "Pod affinity preset. Ignored if `proxy.affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "";
      };
      "podAnnotations" = mkOption {
        description = "Annotations for proxy pods";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "podAntiAffinityPreset" = mkOption {
        description = "Pod anti-affinity preset. Ignored if `proxy.affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "soft";
      };
      "podLabels" = mkOption {
        description = "Extra labels for proxy pods";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "podSecurityContext" = mkOption {
        type = ProxyPodSecurityContextModule;
        default = { };
      };
      "priorityClassName" = mkOption {
        description = "Proxy pods' priorityClassName";
        type = (types.nullOr types.str);
        default = "";
      };
      "readinessProbe" = mkOption {
        type = ProxyReadinessProbeModule;
        default = { };
      };
      "replicaCount" = mkOption {
        description = "Number of Proxy replicas to deploy";
        type = (types.nullOr types.int);
        default = 1;
      };
      "resources" = mkOption {
        description = "Set container requests and limits for different resources like CPU or memory (essential for production workloads)";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "resourcesPreset" = mkOption {
        description = "Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if proxy.resources is set (proxy.resources is recommended for production).";
        type = (types.nullOr types.str);
        default = "micro";
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
      "service" = mkOption {
        type = ProxyServiceModule;
        default = { };
      };
      "serviceAccount" = mkOption {
        type = ProxyServiceAccountModule;
        default = { };
      };
      "sidecars" = mkOption {
        description = "Add additional sidecar containers to the Proxy pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "startupProbe" = mkOption {
        type = ProxyStartupProbeModule;
        default = { };
      };
      "tls" = mkOption {
        type = ProxyTlsModule;
        default = { };
      };
      "tolerations" = mkOption {
        description = "Tolerations for Proxy pods assignment";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "topologySpreadConstraints" = mkOption {
        description = "Topology Spread Constraints for pod assignment spread across your cluster among failure-domains";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "updateStrategy" = mkOption {
        type = ProxyUpdateStrategyModule;
        default = { };
      };
    };
  };
  ProxyNetworkPolicyModule = types.submodule {
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
  ProxyNodeAffinityPresetModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "key" = mkOption {
        description = "Node label key to match. Ignored if `proxy.affinity` is set";
        type = (types.nullOr types.str);
        default = "";
      };
      "type" = mkOption {
        description = "Node affinity preset type. Ignored if `proxy.affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "";
      };
      "values" = mkOption {
        description = "Node label values to match. Ignored if `proxy.affinity` is set";
        type = (types.listOf types.anything);
        default = [ ];
      };
    };
  };
  ProxyPdbModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "create" = mkOption {
        description = "Enable/disable a Pod Disruption Budget creation";
        type = types.bool;
        default = true;
      };
    };
  };
  ProxyPodSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enabled Proxy pods' Security Context";
        type = types.bool;
        default = true;
      };
      "fsGroup" = mkOption {
        description = "Set Proxy pod's Security Context fsGroup";
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
  ProxyReadinessProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable readinessProbe on Proxy nodes";
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
  ProxyServiceAccountModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Additional custom annotations for the ServiceAccount";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "automountServiceAccountToken" = mkOption {
        description = "Allows auto mount of ServiceAccountToken on the serviceAccount created";
        type = types.bool;
        default = false;
      };
      "create" = mkOption {
        description = "Enable creation of ServiceAccount for Proxy pods";
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
  ProxyServiceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Additional custom annotations for Proxy service";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "clusterIP" = mkOption {
        description = "Proxy service Cluster IP";
        type = (types.nullOr types.str);
        default = "";
      };
      "externalTrafficPolicy" = mkOption {
        description = "Proxy service external traffic policy";
        type = (types.nullOr types.str);
        default = "Cluster";
      };
      "extraPorts" = mkOption {
        description = "Extra ports to expose in the Proxy service";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "loadBalancerIP" = mkOption {
        description = "Proxy service Load Balancer IP";
        type = (types.nullOr types.str);
        default = "";
      };
      "loadBalancerSourceRanges" = mkOption {
        description = "Proxy service Load Balancer sources";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "nodePorts" = mkOption {
        type = ProxyServiceNodePortsModule;
        default = { };
      };
      "ports" = mkOption {
        type = ProxyServicePortsModule;
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
        description = "Proxy service type";
        type = (types.nullOr types.str);
        default = "LoadBalancer";
      };
    };
  };
  ProxyServiceNodePortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "grpc" = mkOption {
        description = "Node port for GRPC";
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
  ProxyServicePortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "grpc" = mkOption {
        description = "Proxy GRPC service port";
        type = (types.nullOr types.int);
        default = 19530;
      };
      "metrics" = mkOption {
        description = "Proxy Metrics service port";
        type = (types.nullOr types.int);
        default = 9091;
      };
    };
  };
  ProxyStartupProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable startupProbe on Proxy containers";
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
  ProxyTlsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "caCert" = mkOption {
        description = "The secret key from the existingSecret if 'caCert' key different from the default (ca.pem)";
        type = (types.nullOr types.str);
        default = "ca.pem";
      };
      "cert" = mkOption {
        description = "The secret key from the existingSecret if 'cert' key different from the default (server.pem)";
        type = (types.nullOr types.str);
        default = "server.pem";
      };
      "existingSecret" = mkOption {
        description = "Name of the existing secret containing the TLS certificates for proxy.";
        type = (types.nullOr types.str);
        default = "";
      };
      "key" = mkOption {
        description = "The secret key from the existingSecret if 'key' key different from the default (server.key)";
        type = (types.nullOr types.str);
        default = "server.key";
      };
      "keyPassword" = mkOption {
        description = "Password to access the password-protected PEM key if necessary.";
        type = (types.nullOr types.str);
        default = "";
      };
      "mode" = mkOption {
        description = "TLS mode for proxy. Allowed values: `0`, `1`, `2`";
        type = (types.nullOr types.int);
        default = 0;
      };
    };
  };
  ProxyUpdateStrategyModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "rollingUpdate" = mkOption {
        description = "Proxy statefulset rolling update configuration parameters";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "type" = mkOption {
        description = "Proxy statefulset strategy type";
        type = (types.nullOr types.str);
        default = "RollingUpdate";
      };
    };
  };
  QueryNodeAutoscalingHpaModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations for HPA resource";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "enabled" = mkOption {
        description = "Enable HPA for Milvus Data Plane";
        type = types.bool;
        default = false;
      };
      "maxReplicas" = mkOption {
        description = "Maximum number of Milvus Data Plane replicas";
        type = (types.nullOr types.str);
        default = "";
      };
      "minReplicas" = mkOption {
        description = "Minimum number of Milvus Data Plane replicas";
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
  QueryNodeAutoscalingModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "hpa" = mkOption {
        type = QueryNodeAutoscalingHpaModule;
        default = { };
      };
      "vpa" = mkOption {
        type = QueryNodeAutoscalingVpaModule;
        default = { };
      };
    };
  };
  QueryNodeAutoscalingVpaModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations for VPA resource";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "controlledResources" = mkOption {
        description = "VPA List of resources that the vertical pod autoscaler can control. Defaults to cpu and memory";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "enabled" = mkOption {
        description = "Enable VPA";
        type = types.bool;
        default = false;
      };
      "maxAllowed" = mkOption {
        description = "VPA Max allowed resources for the pod";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "minAllowed" = mkOption {
        description = "VPA Min allowed resources for the pod";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "updatePolicy" = mkOption {
        type = QueryNodeAutoscalingVpaUpdatePolicyModule;
        default = { };
      };
    };
  };
  QueryNodeAutoscalingVpaUpdatePolicyModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "updateMode" = mkOption {
        description = "Autoscaling update policy Specifies whether recommended updates are applied when a Pod is started and whether recommended updates are applied during the life of a Pod";
        type = (types.nullOr types.str);
        default = "Auto";
      };
    };
  };
  QueryNodeContainerPortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "grpc" = mkOption {
        description = "GRPC port for Query Node";
        type = (types.nullOr types.int);
        default = 19530;
      };
      "metrics" = mkOption {
        description = "Metrics port for Query Node";
        type = (types.nullOr types.int);
        default = 9091;
      };
    };
  };
  QueryNodeContainerSecurityContextCapabilitiesModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "drop" = mkOption {
        description = "List of capabilities to be dropped";
        type = (types.listOf types.str);
        default = [ "ALL" ];
      };
    };
  };
  QueryNodeContainerSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "allowPrivilegeEscalation" = mkOption {
        description = "Set container's Security Context allowPrivilegeEscalation";
        type = types.bool;
        default = false;
      };
      "capabilities" = mkOption {
        type = QueryNodeContainerSecurityContextCapabilitiesModule;
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
        type = QueryNodeContainerSecurityContextSeccompProfileModule;
        default = { };
      };
    };
  };
  QueryNodeContainerSecurityContextSeccompProfileModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "type" = mkOption {
        description = "Set container's Security Context seccomp profile";
        type = (types.nullOr types.str);
        default = "RuntimeDefault";
      };
    };
  };
  QueryNodeLivenessProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable livenessProbe on Query Node nodes";
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
  QueryNodeMetricsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable metrics";
        type = types.bool;
        default = false;
      };
      "serviceMonitor" = mkOption {
        type = QueryNodeMetricsServiceMonitorModule;
        default = { };
      };
    };
  };
  QueryNodeMetricsServiceMonitorModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations for the ServiceMonitor Resource";
        type = (types.nullOr types.str);
        default = "";
      };
      "enabled" = mkOption {
        description = "Create ServiceMonitor Resource for scraping metrics using Prometheus Operator";
        type = types.bool;
        default = false;
      };
      "honorLabels" = mkOption {
        description = "Specify honorLabels parameter to add the scrape endpoint";
        type = types.bool;
        default = false;
      };
      "interval" = mkOption {
        description = "Interval at which metrics should be scraped.";
        type = (types.nullOr types.str);
        default = "";
      };
      "jobLabel" = mkOption {
        description = "The name of the label on the target service to use as the job name in prometheus.";
        type = (types.nullOr types.str);
        default = "";
      };
      "labels" = mkOption {
        description = "Additional labels that can be used so ServiceMonitor will be discovered by Prometheus";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "metricRelabelings" = mkOption {
        description = "MetricRelabelConfigs to apply to samples before ingestion";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "namespace" = mkOption {
        description = "Namespace for the ServiceMonitor Resource (defaults to the Release Namespace)";
        type = (types.nullOr types.str);
        default = "";
      };
      "relabelings" = mkOption {
        description = "RelabelConfigs to apply to samples before scraping";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "scrapeTimeout" = mkOption {
        description = "Timeout after which the scrape is ended";
        type = (types.nullOr types.str);
        default = "";
      };
      "selector" = mkOption {
        description = "Prometheus instance selector labels";
        type = (types.attrsOf types.anything);
        default = { };
      };
    };
  };
  QueryNodeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "affinity" = mkOption {
        description = "Affinity for Query Node pods assignment";
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
      "autoscaling" = mkOption {
        type = QueryNodeAutoscalingModule;
        default = { };
      };
      "command" = mkOption {
        description = "Override default container command (useful when using custom images)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "containerPorts" = mkOption {
        type = QueryNodeContainerPortsModule;
        default = { };
      };
      "containerSecurityContext" = mkOption {
        type = QueryNodeContainerSecurityContextModule;
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
      "defaultConfig" = mkOption {
        description = "Default override configuration from the common set in milvus.defaultConfig";
        type = (types.nullOr types.str);
        default = "" "";
      };
      "enableDefaultInitContainers" = mkOption {
        description = "Deploy default init containers";
        type = types.bool;
        default = true;
      };
      "enabled" = mkOption {
        description = "Enable Query Node deployment";
        type = types.bool;
        default = true;
      };
      "existingConfigMap" = mkOption {
        description = "name of a ConfigMap with existing configuration for the default configuration";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraConfig" = mkOption {
        description = "Override configuration";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "extraConfigExistingConfigMap" = mkOption {
        description = "name of a ConfigMap with existing configuration for the Dashboard";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraEnvVars" = mkOption {
        description = "Array with extra environment variables to add to data node nodes";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraEnvVarsCM" = mkOption {
        description = "Name of existing ConfigMap containing extra env vars for data node nodes";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraEnvVarsSecret" = mkOption {
        description = "Name of existing Secret containing extra env vars for data node nodes";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraVolumeMounts" = mkOption {
        description = "Optionally specify extra list of additional volumeMounts for the Query Node container(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraVolumes" = mkOption {
        description = "Optionally specify extra list of additional volumes for the Query Node pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "hostAliases" = mkOption {
        description = "data node pods host aliases";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "initContainers" = mkOption {
        description = "Add additional init containers to the Query Node pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "lifecycleHooks" = mkOption {
        description = "for the data node container(s) to automate configuration before or after startup";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "livenessProbe" = mkOption {
        type = QueryNodeLivenessProbeModule;
        default = { };
      };
      "metrics" = mkOption {
        type = QueryNodeMetricsModule;
        default = { };
      };
      "networkPolicy" = mkOption {
        type = QueryNodeNetworkPolicyModule;
        default = { };
      };
      "nodeAffinityPreset" = mkOption {
        type = QueryNodeNodeAffinityPresetModule;
        default = { };
      };
      "nodeSelector" = mkOption {
        description = "Node labels for Query Node pods assignment";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "pdb" = mkOption {
        type = QueryNodePdbModule;
        default = { };
      };
      "podAffinityPreset" = mkOption {
        description = "Pod affinity preset. Ignored if `data node.affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "";
      };
      "podAnnotations" = mkOption {
        description = "Annotations for data node pods";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "podAntiAffinityPreset" = mkOption {
        description = "Pod anti-affinity preset. Ignored if `data node.affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "soft";
      };
      "podLabels" = mkOption {
        description = "Extra labels for data node pods";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "podSecurityContext" = mkOption {
        type = QueryNodePodSecurityContextModule;
        default = { };
      };
      "priorityClassName" = mkOption {
        description = "Query Node pods' priorityClassName";
        type = (types.nullOr types.str);
        default = "";
      };
      "readinessProbe" = mkOption {
        type = QueryNodeReadinessProbeModule;
        default = { };
      };
      "replicaCount" = mkOption {
        description = "Number of Query Node replicas to deploy";
        type = (types.nullOr types.int);
        default = 1;
      };
      "resources" = mkOption {
        description = "Set container requests and limits for different resources like CPU or memory (essential for production workloads)";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "resourcesPreset" = mkOption {
        description = "Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if queryNode.resources is set (queryNode.resources is recommended for production).";
        type = (types.nullOr types.str);
        default = "micro";
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
      "service" = mkOption {
        type = QueryNodeServiceModule;
        default = { };
      };
      "serviceAccount" = mkOption {
        type = QueryNodeServiceAccountModule;
        default = { };
      };
      "sidecars" = mkOption {
        description = "Add additional sidecar containers to the Query Node pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "startupProbe" = mkOption {
        type = QueryNodeStartupProbeModule;
        default = { };
      };
      "tolerations" = mkOption {
        description = "Tolerations for Query Node pods assignment";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "topologySpreadConstraints" = mkOption {
        description = "Topology Spread Constraints for pod assignment spread across your cluster among failure-domains";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "updateStrategy" = mkOption {
        type = QueryNodeUpdateStrategyModule;
        default = { };
      };
    };
  };
  QueryNodeNetworkPolicyModule = types.submodule {
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
  QueryNodeNodeAffinityPresetModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "key" = mkOption {
        description = "Node label key to match. Ignored if `data node.affinity` is set";
        type = (types.nullOr types.str);
        default = "";
      };
      "type" = mkOption {
        description = "Node affinity preset type. Ignored if `data node.affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "";
      };
      "values" = mkOption {
        description = "Node label values to match. Ignored if `data node.affinity` is set";
        type = (types.listOf types.anything);
        default = [ ];
      };
    };
  };
  QueryNodePdbModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "create" = mkOption {
        description = "Enable/disable a Pod Disruption Budget creation";
        type = types.bool;
        default = true;
      };
    };
  };
  QueryNodePodSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enabled Query Node pods' Security Context";
        type = types.bool;
        default = true;
      };
      "fsGroup" = mkOption {
        description = "Set Query Node pod's Security Context fsGroup";
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
  QueryNodeReadinessProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable readinessProbe on Query Node nodes";
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
  QueryNodeServiceAccountModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Additional custom annotations for the ServiceAccount";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "automountServiceAccountToken" = mkOption {
        description = "Allows auto mount of ServiceAccountToken on the serviceAccount created";
        type = types.bool;
        default = false;
      };
      "create" = mkOption {
        description = "Enable creation of ServiceAccount for Query Node pods";
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
  QueryNodeServiceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Additional custom annotations for Query Node service";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "clusterIP" = mkOption {
        description = "Query Node service Cluster IP";
        type = (types.nullOr types.str);
        default = "";
      };
      "externalTrafficPolicy" = mkOption {
        description = "Query Node service external traffic policy";
        type = (types.nullOr types.str);
        default = "Cluster";
      };
      "extraPorts" = mkOption {
        description = "Extra ports to expose in the Query Node service";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "loadBalancerIP" = mkOption {
        description = "Query Node service Load Balancer IP";
        type = (types.nullOr types.str);
        default = "";
      };
      "loadBalancerSourceRanges" = mkOption {
        description = "Query Node service Load Balancer sources";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "nodePorts" = mkOption {
        type = QueryNodeServiceNodePortsModule;
        default = { };
      };
      "ports" = mkOption {
        type = QueryNodeServicePortsModule;
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
        description = "Query Node service type";
        type = (types.nullOr types.str);
        default = "ClusterIP";
      };
    };
  };
  QueryNodeServiceNodePortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "grpc" = mkOption {
        description = "Node port for GRPC";
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
  QueryNodeServicePortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "grpc" = mkOption {
        description = "Query Node GRPC service port";
        type = (types.nullOr types.int);
        default = 19530;
      };
      "metrics" = mkOption {
        description = "Query Node Metrics service port";
        type = (types.nullOr types.int);
        default = 9091;
      };
    };
  };
  QueryNodeStartupProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable startupProbe on Query Node containers";
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
  QueryNodeUpdateStrategyModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "rollingUpdate" = mkOption {
        description = "Query Node statefulset rolling update configuration parameters";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "type" = mkOption {
        description = "Query Node statefulset strategy type";
        type = (types.nullOr types.str);
        default = "RollingUpdate";
      };
    };
  };
  StreamingNodeAutoscalingHpaModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations for HPA resource";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "enabled" = mkOption {
        description = "Enable HPA for Milvus Data Plane";
        type = types.bool;
        default = false;
      };
      "maxReplicas" = mkOption {
        description = "Maximum number of Milvus Data Plane replicas";
        type = (types.nullOr types.str);
        default = "";
      };
      "minReplicas" = mkOption {
        description = "Minimum number of Milvus Data Plane replicas";
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
  StreamingNodeAutoscalingModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "hpa" = mkOption {
        type = StreamingNodeAutoscalingHpaModule;
        default = { };
      };
      "vpa" = mkOption {
        type = StreamingNodeAutoscalingVpaModule;
        default = { };
      };
    };
  };
  StreamingNodeAutoscalingVpaModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations for VPA resource";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "controlledResources" = mkOption {
        description = "VPA List of resources that the vertical pod autoscaler can control. Defaults to cpu and memory";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "enabled" = mkOption {
        description = "Enable VPA";
        type = types.bool;
        default = false;
      };
      "maxAllowed" = mkOption {
        description = "VPA Max allowed resources for the pod";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "minAllowed" = mkOption {
        description = "VPA Min allowed resources for the pod";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "updatePolicy" = mkOption {
        type = StreamingNodeAutoscalingVpaUpdatePolicyModule;
        default = { };
      };
    };
  };
  StreamingNodeAutoscalingVpaUpdatePolicyModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "updateMode" = mkOption {
        description = "Autoscaling update policy Specifies whether recommended updates are applied when a Pod is started and whether recommended updates are applied during the life of a Pod";
        type = (types.nullOr types.str);
        default = "Auto";
      };
    };
  };
  StreamingNodeContainerPortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "grpc" = mkOption {
        description = "GRPC port for Streaming Node";
        type = (types.nullOr types.int);
        default = 19530;
      };
      "metrics" = mkOption {
        description = "Metrics port for Streaming Node";
        type = (types.nullOr types.int);
        default = 9091;
      };
    };
  };
  StreamingNodeContainerSecurityContextCapabilitiesModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "drop" = mkOption {
        description = "List of capabilities to be dropped";
        type = (types.listOf types.str);
        default = [ "ALL" ];
      };
    };
  };
  StreamingNodeContainerSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "allowPrivilegeEscalation" = mkOption {
        description = "Set container's Security Context allowPrivilegeEscalation";
        type = types.bool;
        default = false;
      };
      "capabilities" = mkOption {
        type = StreamingNodeContainerSecurityContextCapabilitiesModule;
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
        type = StreamingNodeContainerSecurityContextSeccompProfileModule;
        default = { };
      };
    };
  };
  StreamingNodeContainerSecurityContextSeccompProfileModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "type" = mkOption {
        description = "Set container's Security Context seccomp profile";
        type = (types.nullOr types.str);
        default = "RuntimeDefault";
      };
    };
  };
  StreamingNodeLivenessProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable livenessProbe on Streaming Node nodes";
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
  StreamingNodeMetricsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable metrics";
        type = types.bool;
        default = false;
      };
      "serviceMonitor" = mkOption {
        type = StreamingNodeMetricsServiceMonitorModule;
        default = { };
      };
    };
  };
  StreamingNodeMetricsServiceMonitorModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations for the ServiceMonitor Resource";
        type = (types.nullOr types.str);
        default = "";
      };
      "enabled" = mkOption {
        description = "Create ServiceMonitor Resource for scraping metrics using Prometheus Operator";
        type = types.bool;
        default = false;
      };
      "honorLabels" = mkOption {
        description = "Specify honorLabels parameter to add the scrape endpoint";
        type = types.bool;
        default = false;
      };
      "interval" = mkOption {
        description = "Interval at which metrics should be scraped.";
        type = (types.nullOr types.str);
        default = "";
      };
      "jobLabel" = mkOption {
        description = "The name of the label on the target service to use as the job name in prometheus.";
        type = (types.nullOr types.str);
        default = "";
      };
      "labels" = mkOption {
        description = "Additional labels that can be used so ServiceMonitor will be discovered by Prometheus";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "metricRelabelings" = mkOption {
        description = "MetricRelabelConfigs to apply to samples before ingestion";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "namespace" = mkOption {
        description = "Namespace for the ServiceMonitor Resource (defaults to the Release Namespace)";
        type = (types.nullOr types.str);
        default = "";
      };
      "relabelings" = mkOption {
        description = "RelabelConfigs to apply to samples before scraping";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "scrapeTimeout" = mkOption {
        description = "Timeout after which the scrape is ended";
        type = (types.nullOr types.str);
        default = "";
      };
      "selector" = mkOption {
        description = "Prometheus instance selector labels";
        type = (types.attrsOf types.anything);
        default = { };
      };
    };
  };
  StreamingNodeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "affinity" = mkOption {
        description = "Affinity for Streaming Node pods assignment";
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
      "autoscaling" = mkOption {
        type = StreamingNodeAutoscalingModule;
        default = { };
      };
      "command" = mkOption {
        description = "Override default container command (useful when using custom images)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "containerPorts" = mkOption {
        type = StreamingNodeContainerPortsModule;
        default = { };
      };
      "containerSecurityContext" = mkOption {
        type = StreamingNodeContainerSecurityContextModule;
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
      "defaultConfig" = mkOption {
        description = "Default override configuration from the common set in milvus.defaultConfig";
        type = (types.nullOr types.str);
        default = "" "";
      };
      "enableDefaultInitContainers" = mkOption {
        description = "Deploy default init containers";
        type = types.bool;
        default = true;
      };
      "enabled" = mkOption {
        description = "Enable Streaming Node deployment";
        type = types.bool;
        default = true;
      };
      "existingConfigMap" = mkOption {
        description = "name of a ConfigMap with existing configuration for the default configuration";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraConfig" = mkOption {
        description = "Override configuration";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "extraConfigExistingConfigMap" = mkOption {
        description = "name of a ConfigMap with existing configuration for the Dashboard";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraEnvVars" = mkOption {
        description = "Array with extra environment variables to add to data node nodes";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraEnvVarsCM" = mkOption {
        description = "Name of existing ConfigMap containing extra env vars for data node nodes";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraEnvVarsSecret" = mkOption {
        description = "Name of existing Secret containing extra env vars for data node nodes";
        type = (types.nullOr types.str);
        default = "";
      };
      "extraVolumeMounts" = mkOption {
        description = "Optionally specify extra list of additional volumeMounts for the Streaming Node container(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "extraVolumes" = mkOption {
        description = "Optionally specify extra list of additional volumes for the Streaming Node pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "hostAliases" = mkOption {
        description = "data node pods host aliases";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "initContainers" = mkOption {
        description = "Add additional init containers to the Streaming Node pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "lifecycleHooks" = mkOption {
        description = "for the data node container(s) to automate configuration before or after startup";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "livenessProbe" = mkOption {
        type = StreamingNodeLivenessProbeModule;
        default = { };
      };
      "metrics" = mkOption {
        type = StreamingNodeMetricsModule;
        default = { };
      };
      "networkPolicy" = mkOption {
        type = StreamingNodeNetworkPolicyModule;
        default = { };
      };
      "nodeAffinityPreset" = mkOption {
        type = StreamingNodeNodeAffinityPresetModule;
        default = { };
      };
      "nodeSelector" = mkOption {
        description = "Node labels for Streaming Node pods assignment";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "pdb" = mkOption {
        type = StreamingNodePdbModule;
        default = { };
      };
      "podAffinityPreset" = mkOption {
        description = "Pod affinity preset. Ignored if `data node.affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "";
      };
      "podAnnotations" = mkOption {
        description = "Annotations for data node pods";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "podAntiAffinityPreset" = mkOption {
        description = "Pod anti-affinity preset. Ignored if `data node.affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "soft";
      };
      "podLabels" = mkOption {
        description = "Extra labels for data node pods";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "podSecurityContext" = mkOption {
        type = StreamingNodePodSecurityContextModule;
        default = { };
      };
      "priorityClassName" = mkOption {
        description = "Streaming Node pods' priorityClassName";
        type = (types.nullOr types.str);
        default = "";
      };
      "readinessProbe" = mkOption {
        type = StreamingNodeReadinessProbeModule;
        default = { };
      };
      "replicaCount" = mkOption {
        description = "Number of Streaming Node replicas to deploy";
        type = (types.nullOr types.int);
        default = 1;
      };
      "resources" = mkOption {
        description = "Set container requests and limits for different resources like CPU or memory (essential for production workloads)";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "resourcesPreset" = mkOption {
        description = "Set container resources according to one common preset (allowed values: none, nano, micro, small, medium, large, xlarge, 2xlarge). This is ignored if streamingNode.resources is set (streamingNode.resources is recommended for production).";
        type = (types.nullOr types.str);
        default = "micro";
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
      "service" = mkOption {
        type = StreamingNodeServiceModule;
        default = { };
      };
      "serviceAccount" = mkOption {
        type = StreamingNodeServiceAccountModule;
        default = { };
      };
      "sidecars" = mkOption {
        description = "Add additional sidecar containers to the Streaming Node pod(s)";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "startupProbe" = mkOption {
        type = StreamingNodeStartupProbeModule;
        default = { };
      };
      "tolerations" = mkOption {
        description = "Tolerations for Streaming Node pods assignment";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "topologySpreadConstraints" = mkOption {
        description = "Topology Spread Constraints for pod assignment spread across your cluster among failure-domains";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "updateStrategy" = mkOption {
        type = StreamingNodeUpdateStrategyModule;
        default = { };
      };
    };
  };
  StreamingNodeNetworkPolicyModule = types.submodule {
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
  StreamingNodeNodeAffinityPresetModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "key" = mkOption {
        description = "Node label key to match. Ignored if `data node.affinity` is set";
        type = (types.nullOr types.str);
        default = "";
      };
      "type" = mkOption {
        description = "Node affinity preset type. Ignored if `data node.affinity` is set. Allowed values: `soft` or `hard`";
        type = (types.nullOr types.str);
        default = "";
      };
      "values" = mkOption {
        description = "Node label values to match. Ignored if `data node.affinity` is set";
        type = (types.listOf types.anything);
        default = [ ];
      };
    };
  };
  StreamingNodePdbModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "create" = mkOption {
        description = "Enable/disable a Pod Disruption Budget creation";
        type = types.bool;
        default = true;
      };
    };
  };
  StreamingNodePodSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enabled Streaming Node pods' Security Context";
        type = types.bool;
        default = true;
      };
      "fsGroup" = mkOption {
        description = "Set Streaming Node pod's Security Context fsGroup";
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
  StreamingNodeReadinessProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable readinessProbe on Streaming Node nodes";
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
  StreamingNodeServiceAccountModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Additional custom annotations for the ServiceAccount";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "automountServiceAccountToken" = mkOption {
        description = "Allows auto mount of ServiceAccountToken on the serviceAccount created";
        type = types.bool;
        default = false;
      };
      "create" = mkOption {
        description = "Enable creation of ServiceAccount for Streaming Node pods";
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
  StreamingNodeServiceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Additional custom annotations for Streaming Node service";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "clusterIP" = mkOption {
        description = "Streaming Node service Cluster IP";
        type = (types.nullOr types.str);
        default = "";
      };
      "externalTrafficPolicy" = mkOption {
        description = "Streaming Node service external traffic policy";
        type = (types.nullOr types.str);
        default = "Cluster";
      };
      "extraPorts" = mkOption {
        description = "Extra ports to expose in the Streaming Node service";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "loadBalancerIP" = mkOption {
        description = "Streaming Node service Load Balancer IP";
        type = (types.nullOr types.str);
        default = "";
      };
      "loadBalancerSourceRanges" = mkOption {
        description = "Streaming Node service Load Balancer sources";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "nodePorts" = mkOption {
        type = StreamingNodeServiceNodePortsModule;
        default = { };
      };
      "ports" = mkOption {
        type = StreamingNodeServicePortsModule;
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
        description = "Streaming Node service type";
        type = (types.nullOr types.str);
        default = "ClusterIP";
      };
    };
  };
  StreamingNodeServiceNodePortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "grpc" = mkOption {
        description = "Node port for GRPC";
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
  StreamingNodeServicePortsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "grpc" = mkOption {
        description = "Streaming Node GRPC service port";
        type = (types.nullOr types.int);
        default = 19530;
      };
      "metrics" = mkOption {
        description = "Streaming Node Metrics service port";
        type = (types.nullOr types.int);
        default = 9091;
      };
    };
  };
  StreamingNodeStartupProbeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable startupProbe on Streaming Node containers";
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
  StreamingNodeUpdateStrategyModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "rollingUpdate" = mkOption {
        description = "Streaming Node statefulset rolling update configuration parameters";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "type" = mkOption {
        description = "Streaming Node statefulset strategy type";
        type = (types.nullOr types.str);
        default = "RollingUpdate";
      };
    };
  };
  WaitContainerContainerSecurityContextCapabilitiesModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "drop" = mkOption {
        description = "List of capabilities to be dropped";
        type = (types.listOf types.str);
        default = [ "ALL" ];
      };
    };
  };
  WaitContainerContainerSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "allowPrivilegeEscalation" = mkOption {
        description = "Set container's Security Context allowPrivilegeEscalation";
        type = types.bool;
        default = false;
      };
      "capabilities" = mkOption {
        type = WaitContainerContainerSecurityContextCapabilitiesModule;
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
        type = WaitContainerContainerSecurityContextSeccompProfileModule;
        default = { };
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
        default = { };
      };
      "image" = mkOption {
        type = WaitContainerImageModule;
        default = { };
      };
      "resources" = mkOption {
        description = "Set container requests and limits for different resources like CPU or memory (essential for production workloads)";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "resourcesPreset" = mkOption {
        description = "Set container resources according to one common preset (allowed values: none, nano, small, medium, large, xlarge, 2xlarge). This is ignored if initJob.resources is set (initJob.resources is recommended for production).";
        type = (types.nullOr types.str);
        default = "micro";
      };
    };
  };
in
{
  freeformType = types.attrsOf types.anything;
  options = {
    "attu" = mkOption {
      type = AttuModule;
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
    "coordinator" = mkOption {
      type = CoordinatorModule;
      default = { };
    };
    "dataCoord" = mkOption {
      type = DataCoordModule;
      default = { };
    };
    "dataNode" = mkOption {
      type = DataNodeModule;
      default = { };
    };
    "diagnosticMode" = mkOption {
      type = DiagnosticModeModule;
      default = { };
    };
    "enableServiceLinks" = mkOption {
      description = "Whether information about services should be injected into all pods' environment variable";
      type = types.bool;
      default = false;
    };
    "etcd" = mkOption {
      type = EtcdModule;
      default = { };
    };
    "externalEtcd" = mkOption {
      type = ExternalEtcdModule;
      default = { };
    };
    "externalKafka" = mkOption {
      type = ExternalKafkaModule;
      default = { };
    };
    "externalS3" = mkOption {
      type = ExternalS3Module;
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
    "initJob" = mkOption {
      type = InitJobModule;
      default = { };
    };
    "kafka" = mkOption {
      type = KafkaModule;
      default = { };
    };
    "kubeVersion" = mkOption {
      description = "Override Kubernetes version";
      type = (types.nullOr types.str);
      default = "";
    };
    "milvus" = mkOption {
      type = MilvusModule;
      default = { };
    };
    "minio" = mkOption {
      type = MinioModule;
      default = { };
    };
    "nameOverride" = mkOption {
      description = "String to partially override common.names.fullname";
      type = (types.nullOr types.str);
      default = "";
    };
    "proxy" = mkOption {
      type = ProxyModule;
      default = { };
    };
    "queryNode" = mkOption {
      type = QueryNodeModule;
      default = { };
    };
    "streamingNode" = mkOption {
      type = StreamingNodeModule;
      default = { };
    };
    "waitContainer" = mkOption {
      type = WaitContainerModule;
      default = { };
    };
  };
}
