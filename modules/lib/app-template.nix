# Auto-generated typed options for the bjw-s app-template Helm chart.
# Generated from lib/helm-app-schema/values.schema.json.
# See specs/nix-module-app-generator.md for the generator pattern.
#
# DO NOT EDIT — regenerate with: bin/create-module-app-template
{ lib }:
with lib;
let
  ConfigMapModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "binaryData" = mkOption {
        description = "ConfigMap binaryData content.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "data" = mkOption {
        description = "ConfigMap data content. Helm templates are supported.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "enabled" = mkOption {
        description = "Set to false to disable the ConfigMap.";
        type = types.bool;
        default = true;
      };
      "forceRename" = mkOption {
        type = types.anything;
        default = null;
      };
      "includeChecksumInControllers" = mkOption {
        description = "Specify a list of controller identifiers for which to include this ConfigMap in the checksum calculation for rolling updates.";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "includeInChecksum" = mkOption {
        description = "Set to true to include this ConfigMap in the checksum calculation for rolling updates.";
        type = types.bool;
        default = true;
      };
      "labels" = mkOption {
        description = "Labels to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "prefix" = mkOption {
        type = types.anything;
        default = null;
      };
      "suffix" = mkOption {
        type = types.anything;
        default = null;
      };
    };
  };
  ConfigMapsFromFolderConfigMapsOverrideFileAttributeOverrideModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "binary" = mkOption {
        type = types.bool;
        default = false;
      };
      "escaped" = mkOption {
        type = types.bool;
        default = false;
      };
      "exclude" = mkOption {
        type = types.bool;
        default = false;
      };
      "isEnvFile" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  ConfigMapsFromFolderConfigMapsOverrideModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "fileAttributeOverrides" = mkOption {
        type = (types.attrsOf ConfigMapsFromFolderConfigMapsOverrideFileAttributeOverrideModule);
        default = { };
      };
      "forceRename" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "labels" = mkOption {
        description = "Labels to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
    };
  };
  ConfigMapsFromFolderModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "autoDetectBinary" = mkOption {
        type = types.bool;
        default = false;
      };
      "basePath" = mkOption {
        description = "Base path containing configmap subfolders";
        type = types.str;
        default = null;
      };
      "configMapsOverrides" = mkOption {
        type = (types.attrsOf ConfigMapsFromFolderConfigMapsOverrideModule);
        default = { };
      };
      "enabled" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  ControllerContainerEnvFromConfigMapRefModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "identifier" = mkOption {
        type = types.str;
        default = null;
      };
      "name" = mkOption {
        type = types.str;
        default = null;
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  ControllerContainerEnvFromModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "configMap" = mkOption {
        type = types.str;
        default = null;
      };
      "configMapRef" = mkOption {
        type = (types.nullOr ControllerContainerEnvFromConfigMapRefModule);
        default = { };
      };
      "prefix" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "secret" = mkOption {
        type = types.str;
        default = null;
      };
      "secretRef" = mkOption {
        type = (types.nullOr ControllerContainerEnvFromSecretRefModule);
        default = { };
      };
    };
  };
  ControllerContainerEnvFromSecretRefModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "identifier" = mkOption {
        type = types.str;
        default = null;
      };
      "name" = mkOption {
        type = types.str;
        default = null;
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  ControllerContainerImageModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "digest" = mkOption {
        type = types.anything;
        default = null;
      };
      "pullPolicy" = mkOption {
        type = (
          types.enum [
            "Always"
            "IfNotPresent"
            "Never"
          ]
        );
      };
      "repository" = mkOption {
        type = types.anything;
        default = null;
      };
      "tag" = mkOption {
        type = types.anything;
        default = null;
      };
    };
  };
  ControllerContainerLifecycleModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "postStart" = mkOption {
        description = "PostStart is called immediately after a container is created. If the handler fails, the container is terminated and restarted according to its restart policy. Other management of the container blocks until the hook completes. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks";
        type = (types.nullOr ControllerContainerLifecyclePostStartModule);
        default = { };
      };
      "preStop" = mkOption {
        description = "PreStop is called immediately before a container is terminated due to an API request or management event such as liveness/startup probe failure, preemption, resource contention, etc. The handler is not called if the container crashes or exits. The Pod's termination grace period countdown begins before the PreStop hook is executed. Regardless of the outcome of the handler, the container will eventually terminate within the Pod's termination grace period (unless delayed by finalizers). Other management of the container blocks until the hook completes or until the termination grace period is reached. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks";
        type = (types.nullOr ControllerContainerLifecyclePreStopModule);
        default = { };
      };
    };
  };
  ControllerContainerLifecyclePostStartExecModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf (types.nullOr types.str));
        default = [ ];
      };
    };
  };
  ControllerContainerLifecyclePostStartHttpGetHttpHeaderModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "name" = mkOption {
        description = "The header field name. This will be canonicalized upon output, so case-variant names will be understood as the same header.";
        type = (types.nullOr types.str);
      };
      "value" = mkOption {
        description = "The header field value";
        type = (types.nullOr types.str);
      };
    };
  };
  ControllerContainerLifecyclePostStartHttpGetModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf ControllerContainerLifecyclePostStartHttpGetHttpHeaderModule);
        default = [ ];
      };
      "path" = mkOption {
        description = "Path to access on the HTTP server.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.";
        type = types.anything;
      };
      "scheme" = mkOption {
        description = "Scheme to use for connecting to the host. Defaults to HTTP.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  ControllerContainerLifecyclePostStartModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "exec" = mkOption {
        description = "Exec specifies the action to take.";
        type = (types.nullOr ControllerContainerLifecyclePostStartExecModule);
        default = { };
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies the http request to perform.";
        type = (types.nullOr ControllerContainerLifecyclePostStartHttpGetModule);
        default = { };
      };
      "sleep" = mkOption {
        description = "Sleep represents the duration that the container should sleep before being terminated.";
        type = (types.nullOr ControllerContainerLifecyclePostStartSleepModule);
        default = { };
      };
      "tcpSocket" = mkOption {
        description = "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept for the backward compatibility. There are no validation of this field and lifecycle hooks will fail in runtime when tcp handler is specified.";
        type = (types.nullOr ControllerContainerLifecyclePostStartTcpSocketModule);
        default = { };
      };
    };
  };
  ControllerContainerLifecyclePostStartSleepModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "seconds" = mkOption {
        description = "Seconds is the number of seconds to sleep.";
        type = types.int;
      };
    };
  };
  ControllerContainerLifecyclePostStartTcpSocketModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "host" = mkOption {
        description = "Optional: Host name to connect to, defaults to the pod IP.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.";
        type = types.anything;
      };
    };
  };
  ControllerContainerLifecyclePreStopExecModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf (types.nullOr types.str));
        default = [ ];
      };
    };
  };
  ControllerContainerLifecyclePreStopHttpGetHttpHeaderModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "name" = mkOption {
        description = "The header field name. This will be canonicalized upon output, so case-variant names will be understood as the same header.";
        type = (types.nullOr types.str);
      };
      "value" = mkOption {
        description = "The header field value";
        type = (types.nullOr types.str);
      };
    };
  };
  ControllerContainerLifecyclePreStopHttpGetModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf ControllerContainerLifecyclePreStopHttpGetHttpHeaderModule);
        default = [ ];
      };
      "path" = mkOption {
        description = "Path to access on the HTTP server.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.";
        type = types.anything;
      };
      "scheme" = mkOption {
        description = "Scheme to use for connecting to the host. Defaults to HTTP.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  ControllerContainerLifecyclePreStopModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "exec" = mkOption {
        description = "Exec specifies the action to take.";
        type = (types.nullOr ControllerContainerLifecyclePreStopExecModule);
        default = { };
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies the http request to perform.";
        type = (types.nullOr ControllerContainerLifecyclePreStopHttpGetModule);
        default = { };
      };
      "sleep" = mkOption {
        description = "Sleep represents the duration that the container should sleep before being terminated.";
        type = (types.nullOr ControllerContainerLifecyclePreStopSleepModule);
        default = { };
      };
      "tcpSocket" = mkOption {
        description = "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept for the backward compatibility. There are no validation of this field and lifecycle hooks will fail in runtime when tcp handler is specified.";
        type = (types.nullOr ControllerContainerLifecyclePreStopTcpSocketModule);
        default = { };
      };
    };
  };
  ControllerContainerLifecyclePreStopSleepModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "seconds" = mkOption {
        description = "Seconds is the number of seconds to sleep.";
        type = types.int;
      };
    };
  };
  ControllerContainerLifecyclePreStopTcpSocketModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "host" = mkOption {
        description = "Optional: Host name to connect to, defaults to the pod IP.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.";
        type = types.anything;
      };
    };
  };
  ControllerContainerModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "args" = mkOption {
        description = "Arguments for the container entrypoint.";
        type = types.anything;
        default = { };
      };
      "command" = mkOption {
        description = "Command for the container entrypoint.";
        type = types.anything;
        default = { };
      };
      "dependsOn" = mkOption {
        description = "Specify container dependencies to determine render order.";
        type = types.anything;
        default = { };
      };
      "enabled" = mkOption {
        description = "Set to false to disable the container.";
        type = types.bool;
        default = true;
      };
      "env" = mkOption {
        description = "Environment variables for the container.";
        type = types.anything;
        default = { };
      };
      "envFrom" = mkOption {
        description = "Secrets and/or ConfigMaps to load as environment variables.";
        type = (types.listOf ControllerContainerEnvFromModule);
        default = [ ];
      };
      "image" = mkOption {
        description = "Image configuration for the container.";
        type = (types.nullOr ControllerContainerImageModule);
        default = { };
      };
      "lifecycle" = mkOption {
        description = "Lifecycle event hooks for the container.";
        type = (types.nullOr ControllerContainerLifecycleModule);
        default = { };
      };
      "nameOverride" = mkOption {
        description = "Override the container name.";
        type = types.str;
        default = null;
      };
      "ports" = mkOption {
        description = "Ports to expose from the container.";
        type = (types.listOf ControllerContainerPortModule);
        default = [ ];
      };
      "probes" = mkOption {
        description = "Probe settings for the container.";
        type = (types.nullOr ControllerContainerProbesModule);
        default = { };
      };
      "resources" = mkOption {
        description = "Resource requests and limits for the container.";
        type = (types.nullOr ControllerContainerResourcesModule);
        default = { };
      };
      "restartPolicy" = mkOption {
        description = "Restart policy for the container.";
        type = types.str;
        default = null;
      };
      "securityContext" = mkOption {
        description = "Security context for the container.";
        type = types.anything;
        default = null;
      };
      "stdin" = mkOption {
        description = "Keep the standard input open on the container.";
        type = types.bool;
        default = false;
      };
      "terminationMessagePath" = mkOption {
        description = "Path for the container's termination message file.";
        type = types.str;
        default = null;
      };
      "terminationMessagePolicy" = mkOption {
        description = "How the container's termination message should be populated. Supported values: 'File', 'FallbackToLogsOnError'.";
        type = (
          types.enum [
            "File"
            "FallbackToLogsOnError"
          ]
        );
      };
      "tty" = mkOption {
        description = "Allocate a TTY for the container.";
        type = types.bool;
        default = false;
      };
      "workingDir" = mkOption {
        description = "Working directory for the container.";
        type = types.str;
        default = null;
      };
    };
  };
  ControllerContainerPortModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "containerPort" = mkOption {
        description = "Number of port to expose on the pod's IP address. This must be a valid port number, 0 < x < 65536.";
        type = (types.nullOr types.int);
      };
      "hostIP" = mkOption {
        description = "What host IP to bind the external port to.";
        type = (types.nullOr types.str);
        default = null;
      };
      "hostPort" = mkOption {
        description = "Number of port to expose on the host. If specified, this must be a valid port number, 0 < x < 65536. If HostNetwork is specified, this must match ContainerPort. Most containers do not need this.";
        type = (types.nullOr types.int);
        default = null;
      };
      "name" = mkOption {
        description = "If specified, this must be an IANA_SVC_NAME and unique within the pod. Each named port in a pod must have a unique name. Name for the port that can be referred to by services.";
        type = (types.nullOr types.str);
        default = null;
      };
      "protocol" = mkOption {
        description = "Protocol for port. Must be UDP, TCP, or SCTP. Defaults to \"TCP\".";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  ControllerContainerProbesModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "liveness" = mkOption {
        description = "Liveness probe configuration.";
        type = types.anything;
        default = null;
      };
      "readiness" = mkOption {
        description = "Readiness probe configuration.";
        type = types.anything;
        default = null;
      };
      "startup" = mkOption {
        description = "Startup probe configuration.";
        type = types.anything;
        default = null;
      };
    };
  };
  ControllerContainerResourcesModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "claims" = mkOption {
        description = "Claims lists the names of resources, defined in spec.resourceClaims, that are used by this container.\n\nThis is an alpha field and requires enabling the DynamicResourceAllocation feature gate.\n\nThis field is immutable. It can only be set for containers.";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "limits" = mkOption {
        description = "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.attrsOf (types.either types.str types.number));
        default = { };
      };
      "requests" = mkOption {
        description = "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. Requests cannot exceed Limits. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.attrsOf (types.either types.str types.number));
        default = { };
      };
    };
  };
  ControllerCronjobModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "activeDeadlineSeconds" = mkOption {
        type = types.int;
        default = null;
      };
      "backoffLimit" = mkOption {
        type = types.int;
        default = 6;
      };
      "concurrencyPolicy" = mkOption {
        type = types.str;
        default = "Forbid";
      };
      "failedJobsHistory" = mkOption {
        type = types.int;
        default = 1;
      };
      "parallelism" = mkOption {
        type = types.int;
        default = null;
      };
      "schedule" = mkOption {
        type = types.str;
      };
      "startingDeadlineSeconds" = mkOption {
        type = types.int;
        default = 30;
      };
      "successfulJobsHistory" = mkOption {
        type = types.int;
        default = 1;
      };
      "suspend" = mkOption {
        type = types.bool;
        default = false;
      };
      "timeZone" = mkOption {
        type = types.str;
        default = null;
      };
      "ttlSecondsAfterFinished" = mkOption {
        type = types.int;
        default = null;
      };
    };
  };
  ControllerDefaultContainerOptionsEnvFromConfigMapRefModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "identifier" = mkOption {
        type = types.str;
        default = null;
      };
      "name" = mkOption {
        type = types.str;
        default = null;
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  ControllerDefaultContainerOptionsEnvFromModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "configMap" = mkOption {
        type = types.str;
        default = null;
      };
      "configMapRef" = mkOption {
        type = (types.nullOr ControllerDefaultContainerOptionsEnvFromConfigMapRefModule);
        default = { };
      };
      "prefix" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "secret" = mkOption {
        type = types.str;
        default = null;
      };
      "secretRef" = mkOption {
        type = (types.nullOr ControllerDefaultContainerOptionsEnvFromSecretRefModule);
        default = { };
      };
    };
  };
  ControllerDefaultContainerOptionsEnvFromSecretRefModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "identifier" = mkOption {
        type = types.str;
        default = null;
      };
      "name" = mkOption {
        type = types.str;
        default = null;
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  ControllerDefaultContainerOptionsImageModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "digest" = mkOption {
        type = types.anything;
        default = null;
      };
      "pullPolicy" = mkOption {
        type = (
          types.enum [
            "Always"
            "IfNotPresent"
            "Never"
          ]
        );
      };
      "repository" = mkOption {
        type = types.anything;
        default = null;
      };
      "tag" = mkOption {
        type = types.anything;
        default = null;
      };
    };
  };
  ControllerDefaultContainerOptionsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "args" = mkOption {
        type = types.anything;
        default = { };
      };
      "command" = mkOption {
        type = types.anything;
        default = { };
      };
      "env" = mkOption {
        type = types.anything;
        default = { };
      };
      "envFrom" = mkOption {
        type = (types.listOf ControllerDefaultContainerOptionsEnvFromModule);
        default = [ ];
      };
      "image" = mkOption {
        type = (types.nullOr ControllerDefaultContainerOptionsImageModule);
        default = { };
      };
      "resources" = mkOption {
        description = "ResourceRequirements describes the compute resource requirements.";
        type = (types.nullOr ControllerDefaultContainerOptionsResourcesModule);
        default = { };
      };
      "securityContext" = mkOption {
        type = types.anything;
        default = null;
      };
    };
  };
  ControllerDefaultContainerOptionsResourcesModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "claims" = mkOption {
        description = "Claims lists the names of resources, defined in spec.resourceClaims, that are used by this container.\n\nThis is an alpha field and requires enabling the DynamicResourceAllocation feature gate.\n\nThis field is immutable. It can only be set for containers.";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "limits" = mkOption {
        description = "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.attrsOf (types.either types.str types.number));
        default = { };
      };
      "requests" = mkOption {
        description = "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. Requests cannot exceed Limits. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.attrsOf (types.either types.str types.number));
        default = { };
      };
    };
  };
  ControllerInitContainerEnvFromConfigMapRefModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "identifier" = mkOption {
        type = types.str;
        default = null;
      };
      "name" = mkOption {
        type = types.str;
        default = null;
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  ControllerInitContainerEnvFromModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "configMap" = mkOption {
        type = types.str;
        default = null;
      };
      "configMapRef" = mkOption {
        type = (types.nullOr ControllerInitContainerEnvFromConfigMapRefModule);
        default = { };
      };
      "prefix" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "secret" = mkOption {
        type = types.str;
        default = null;
      };
      "secretRef" = mkOption {
        type = (types.nullOr ControllerInitContainerEnvFromSecretRefModule);
        default = { };
      };
    };
  };
  ControllerInitContainerEnvFromSecretRefModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "identifier" = mkOption {
        type = types.str;
        default = null;
      };
      "name" = mkOption {
        type = types.str;
        default = null;
      };
      "optional" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  ControllerInitContainerImageModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "digest" = mkOption {
        type = types.anything;
        default = null;
      };
      "pullPolicy" = mkOption {
        type = (
          types.enum [
            "Always"
            "IfNotPresent"
            "Never"
          ]
        );
      };
      "repository" = mkOption {
        type = types.anything;
        default = null;
      };
      "tag" = mkOption {
        type = types.anything;
        default = null;
      };
    };
  };
  ControllerInitContainerLifecycleModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "postStart" = mkOption {
        description = "PostStart is called immediately after a container is created. If the handler fails, the container is terminated and restarted according to its restart policy. Other management of the container blocks until the hook completes. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks";
        type = (types.nullOr ControllerInitContainerLifecyclePostStartModule);
        default = { };
      };
      "preStop" = mkOption {
        description = "PreStop is called immediately before a container is terminated due to an API request or management event such as liveness/startup probe failure, preemption, resource contention, etc. The handler is not called if the container crashes or exits. The Pod's termination grace period countdown begins before the PreStop hook is executed. Regardless of the outcome of the handler, the container will eventually terminate within the Pod's termination grace period (unless delayed by finalizers). Other management of the container blocks until the hook completes or until the termination grace period is reached. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks";
        type = (types.nullOr ControllerInitContainerLifecyclePreStopModule);
        default = { };
      };
    };
  };
  ControllerInitContainerLifecyclePostStartExecModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf (types.nullOr types.str));
        default = [ ];
      };
    };
  };
  ControllerInitContainerLifecyclePostStartHttpGetHttpHeaderModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "name" = mkOption {
        description = "The header field name. This will be canonicalized upon output, so case-variant names will be understood as the same header.";
        type = (types.nullOr types.str);
      };
      "value" = mkOption {
        description = "The header field value";
        type = (types.nullOr types.str);
      };
    };
  };
  ControllerInitContainerLifecyclePostStartHttpGetModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf ControllerInitContainerLifecyclePostStartHttpGetHttpHeaderModule);
        default = [ ];
      };
      "path" = mkOption {
        description = "Path to access on the HTTP server.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.";
        type = types.anything;
      };
      "scheme" = mkOption {
        description = "Scheme to use for connecting to the host. Defaults to HTTP.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  ControllerInitContainerLifecyclePostStartModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "exec" = mkOption {
        description = "Exec specifies the action to take.";
        type = (types.nullOr ControllerInitContainerLifecyclePostStartExecModule);
        default = { };
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies the http request to perform.";
        type = (types.nullOr ControllerInitContainerLifecyclePostStartHttpGetModule);
        default = { };
      };
      "sleep" = mkOption {
        description = "Sleep represents the duration that the container should sleep before being terminated.";
        type = (types.nullOr ControllerInitContainerLifecyclePostStartSleepModule);
        default = { };
      };
      "tcpSocket" = mkOption {
        description = "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept for the backward compatibility. There are no validation of this field and lifecycle hooks will fail in runtime when tcp handler is specified.";
        type = (types.nullOr ControllerInitContainerLifecyclePostStartTcpSocketModule);
        default = { };
      };
    };
  };
  ControllerInitContainerLifecyclePostStartSleepModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "seconds" = mkOption {
        description = "Seconds is the number of seconds to sleep.";
        type = types.int;
      };
    };
  };
  ControllerInitContainerLifecyclePostStartTcpSocketModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "host" = mkOption {
        description = "Optional: Host name to connect to, defaults to the pod IP.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.";
        type = types.anything;
      };
    };
  };
  ControllerInitContainerLifecyclePreStopExecModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "command" = mkOption {
        description = "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy.";
        type = (types.listOf (types.nullOr types.str));
        default = [ ];
      };
    };
  };
  ControllerInitContainerLifecyclePreStopHttpGetHttpHeaderModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "name" = mkOption {
        description = "The header field name. This will be canonicalized upon output, so case-variant names will be understood as the same header.";
        type = (types.nullOr types.str);
      };
      "value" = mkOption {
        description = "The header field value";
        type = (types.nullOr types.str);
      };
    };
  };
  ControllerInitContainerLifecyclePreStopHttpGetModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "host" = mkOption {
        description = "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead.";
        type = (types.nullOr types.str);
        default = null;
      };
      "httpHeaders" = mkOption {
        description = "Custom headers to set in the request. HTTP allows repeated headers.";
        type = (types.listOf ControllerInitContainerLifecyclePreStopHttpGetHttpHeaderModule);
        default = [ ];
      };
      "path" = mkOption {
        description = "Path to access on the HTTP server.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.";
        type = types.anything;
      };
      "scheme" = mkOption {
        description = "Scheme to use for connecting to the host. Defaults to HTTP.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  ControllerInitContainerLifecyclePreStopModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "exec" = mkOption {
        description = "Exec specifies the action to take.";
        type = (types.nullOr ControllerInitContainerLifecyclePreStopExecModule);
        default = { };
      };
      "httpGet" = mkOption {
        description = "HTTPGet specifies the http request to perform.";
        type = (types.nullOr ControllerInitContainerLifecyclePreStopHttpGetModule);
        default = { };
      };
      "sleep" = mkOption {
        description = "Sleep represents the duration that the container should sleep before being terminated.";
        type = (types.nullOr ControllerInitContainerLifecyclePreStopSleepModule);
        default = { };
      };
      "tcpSocket" = mkOption {
        description = "Deprecated. TCPSocket is NOT supported as a LifecycleHandler and kept for the backward compatibility. There are no validation of this field and lifecycle hooks will fail in runtime when tcp handler is specified.";
        type = (types.nullOr ControllerInitContainerLifecyclePreStopTcpSocketModule);
        default = { };
      };
    };
  };
  ControllerInitContainerLifecyclePreStopSleepModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "seconds" = mkOption {
        description = "Seconds is the number of seconds to sleep.";
        type = types.int;
      };
    };
  };
  ControllerInitContainerLifecyclePreStopTcpSocketModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "host" = mkOption {
        description = "Optional: Host name to connect to, defaults to the pod IP.";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.";
        type = types.anything;
      };
    };
  };
  ControllerInitContainerModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "args" = mkOption {
        description = "Arguments for the container entrypoint.";
        type = types.anything;
        default = { };
      };
      "command" = mkOption {
        description = "Command for the container entrypoint.";
        type = types.anything;
        default = { };
      };
      "dependsOn" = mkOption {
        description = "Specify container dependencies to determine render order.";
        type = types.anything;
        default = { };
      };
      "enabled" = mkOption {
        description = "Set to false to disable the container.";
        type = types.bool;
        default = true;
      };
      "env" = mkOption {
        description = "Environment variables for the container.";
        type = types.anything;
        default = { };
      };
      "envFrom" = mkOption {
        description = "Secrets and/or ConfigMaps to load as environment variables.";
        type = (types.listOf ControllerInitContainerEnvFromModule);
        default = [ ];
      };
      "image" = mkOption {
        description = "Image configuration for the container.";
        type = (types.nullOr ControllerInitContainerImageModule);
        default = { };
      };
      "lifecycle" = mkOption {
        description = "Lifecycle event hooks for the container.";
        type = (types.nullOr ControllerInitContainerLifecycleModule);
        default = { };
      };
      "nameOverride" = mkOption {
        description = "Override the container name.";
        type = types.str;
        default = null;
      };
      "ports" = mkOption {
        description = "Ports to expose from the container.";
        type = (types.listOf ControllerInitContainerPortModule);
        default = [ ];
      };
      "probes" = mkOption {
        description = "Probe settings for the container.";
        type = (types.nullOr ControllerInitContainerProbesModule);
        default = { };
      };
      "resources" = mkOption {
        description = "Resource requests and limits for the container.";
        type = (types.nullOr ControllerInitContainerResourcesModule);
        default = { };
      };
      "restartPolicy" = mkOption {
        description = "Restart policy for the container.";
        type = types.str;
        default = null;
      };
      "securityContext" = mkOption {
        description = "Security context for the container.";
        type = types.anything;
        default = null;
      };
      "stdin" = mkOption {
        description = "Keep the standard input open on the container.";
        type = types.bool;
        default = false;
      };
      "terminationMessagePath" = mkOption {
        description = "Path for the container's termination message file.";
        type = types.str;
        default = null;
      };
      "terminationMessagePolicy" = mkOption {
        description = "How the container's termination message should be populated. Supported values: 'File', 'FallbackToLogsOnError'.";
        type = (
          types.enum [
            "File"
            "FallbackToLogsOnError"
          ]
        );
      };
      "tty" = mkOption {
        description = "Allocate a TTY for the container.";
        type = types.bool;
        default = false;
      };
      "workingDir" = mkOption {
        description = "Working directory for the container.";
        type = types.str;
        default = null;
      };
    };
  };
  ControllerInitContainerPortModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "containerPort" = mkOption {
        description = "Number of port to expose on the pod's IP address. This must be a valid port number, 0 < x < 65536.";
        type = (types.nullOr types.int);
      };
      "hostIP" = mkOption {
        description = "What host IP to bind the external port to.";
        type = (types.nullOr types.str);
        default = null;
      };
      "hostPort" = mkOption {
        description = "Number of port to expose on the host. If specified, this must be a valid port number, 0 < x < 65536. If HostNetwork is specified, this must match ContainerPort. Most containers do not need this.";
        type = (types.nullOr types.int);
        default = null;
      };
      "name" = mkOption {
        description = "If specified, this must be an IANA_SVC_NAME and unique within the pod. Each named port in a pod must have a unique name. Name for the port that can be referred to by services.";
        type = (types.nullOr types.str);
        default = null;
      };
      "protocol" = mkOption {
        description = "Protocol for port. Must be UDP, TCP, or SCTP. Defaults to \"TCP\".";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  ControllerInitContainerProbesModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "liveness" = mkOption {
        description = "Liveness probe configuration.";
        type = types.anything;
        default = null;
      };
      "readiness" = mkOption {
        description = "Readiness probe configuration.";
        type = types.anything;
        default = null;
      };
      "startup" = mkOption {
        description = "Startup probe configuration.";
        type = types.anything;
        default = null;
      };
    };
  };
  ControllerInitContainerResourcesModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "claims" = mkOption {
        description = "Claims lists the names of resources, defined in spec.resourceClaims, that are used by this container.\n\nThis is an alpha field and requires enabling the DynamicResourceAllocation feature gate.\n\nThis field is immutable. It can only be set for containers.";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "limits" = mkOption {
        description = "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.attrsOf (types.either types.str types.number));
        default = { };
      };
      "requests" = mkOption {
        description = "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. Requests cannot exceed Limits. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.attrsOf (types.either types.str types.number));
        default = { };
      };
    };
  };
  ControllerJobModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "activeDeadlineSeconds" = mkOption {
        type = types.int;
        default = null;
      };
      "backoffLimit" = mkOption {
        type = types.int;
        default = 6;
      };
      "completionMode" = mkOption {
        type = types.anything;
        default = null;
      };
      "completions" = mkOption {
        type = types.anything;
        default = null;
      };
      "parallelism" = mkOption {
        type = types.int;
        default = null;
      };
      "suspend" = mkOption {
        type = types.bool;
        default = false;
      };
      "ttlSecondsAfterFinished" = mkOption {
        type = types.int;
        default = null;
      };
    };
  };
  ControllerModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "applyDefaultContainerOptionsToInitContainers" = mkOption {
        description = "Apply defaultContainerOptions to initContainers.";
        type = types.bool;
        default = true;
      };
      "containers" = mkOption {
        description = "Containers as dictionary items.";
        type = (types.attrsOf ControllerContainerModule);
        default = { };
      };
      "cronjob" = mkOption {
        description = "CronJob-specific options. Required when type is cronjob.";
        type = (types.nullOr ControllerCronjobModule);
        default = { };
      };
      "defaultContainerOptions" = mkOption {
        description = "Default options for all (init)Containers. Each can be overridden on a container level.";
        type = (types.nullOr ControllerDefaultContainerOptionsModule);
        default = { };
      };
      "defaultContainerOptionsStrategy" = mkOption {
        description = "Strategy for default container options.\noverwrite: use container-level options if set.\nmerge: merge container-level options with defaults.";
        type = (
          types.enum [
            "overwrite"
            "merge"
          ]
        );
        default = "overwrite";
      };
      "enabled" = mkOption {
        description = "Set to false to disable the controller.";
        type = types.bool;
        default = true;
      };
      "forceRename" = mkOption {
        type = types.anything;
        default = null;
      };
      "initContainers" = mkOption {
        description = "InitContainers as dictionary items.";
        type = (types.attrsOf ControllerInitContainerModule);
        default = { };
      };
      "job" = mkOption {
        description = "Job-specific options. Required when type is job.";
        type = (types.nullOr ControllerJobModule);
        default = { };
      };
      "labels" = mkOption {
        description = "Labels to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "pod" = mkOption {
        description = "Pod-level options for this controller.";
        type = (types.nullOr ControllerPodModule);
        default = { };
      };
      "podDisruptionBudget" = mkOption {
        description = "PodDisruptionBudget Policy for this controller.";
        type = (types.nullOr ControllerPodDisruptionBudgetModule);
        default = { };
      };
      "prefix" = mkOption {
        type = types.anything;
        default = null;
      };
      "replicas" = mkOption {
        description = "Number of desired pods. Set to null when using a HorizontalPodAutoscaler.";
        type = (types.nullOr types.int);
        default = 1;
      };
      "revisionHistoryLimit" = mkOption {
        description = "ReplicaSet revision history limit.";
        type = types.int;
        default = null;
      };
      "rollingUpdate" = mkOption {
        description = "Controller upgrade strategy options.";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "serviceAccount" = mkOption {
        description = "ServiceAccount used by the controller.";
        type = (types.nullOr ControllerServiceAccountModule);
        default = { };
      };
      "statefulset" = mkOption {
        description = "StatefulSet-specific options. Required when type is statefulset.";
        type = (types.nullOr ControllerStatefulsetModule);
        default = { };
      };
      "strategy" = mkOption {
        description = "Controller upgrade strategy.";
        type = types.str;
        default = null;
      };
      "suffix" = mkOption {
        type = types.anything;
        default = null;
      };
      "type" = mkOption {
        description = "Controller type. Supported values: deployment, daemonset, statefulset, cronjob, job.";
        type = (
          types.enum [
            "deployment"
            "statefulset"
            "daemonset"
            "cronjob"
            "job"
          ]
        );
        default = "deployment";
      };
    };
  };
  ControllerPodAffinityModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "nodeAffinity" = mkOption {
        description = "Describes node affinity scheduling rules for the pod.";
        type = (types.nullOr ControllerPodAffinityNodeAffinityModule);
        default = { };
      };
      "podAffinity" = mkOption {
        description = "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s)).";
        type = (types.nullOr ControllerPodAffinityPodAffinityModule);
        default = { };
      };
      "podAntiAffinity" = mkOption {
        description = "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s)).";
        type = (types.nullOr ControllerPodAffinityPodAntiAffinityModule);
        default = { };
      };
    };
  };
  ControllerPodAffinityNodeAffinityModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred.";
        type = (
          types.listOf ControllerPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node.";
        type = (
          types.nullOr ControllerPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = { };
      };
    };
  };
  ControllerPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "preference" = mkOption {
            description = "A node selector term, associated with the corresponding weight.";
            type =
              ControllerPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceModule;
          };
          "weight" = mkOption {
            description = "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100.";
            type = types.int;
          };
        };
      };
  ControllerPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpressionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "key" = mkOption {
            description = "The label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.";
            type = types.str;
          };
          "values" = mkOption {
            description = "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  ControllerPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchFieldModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "key" = mkOption {
            description = "The label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.";
            type = types.str;
          };
          "values" = mkOption {
            description = "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  ControllerPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "matchExpressions" = mkOption {
            description = "A list of node selector requirements by node's labels.";
            type = (
              types.listOf ControllerPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpressionModule
            );
            default = [ ];
          };
          "matchFields" = mkOption {
            description = "A list of node selector requirements by node's fields.";
            type = (
              types.listOf ControllerPodAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchFieldModule
            );
            default = [ ];
          };
        };
      };
  ControllerPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "nodeSelectorTerms" = mkOption {
            description = "Required. A list of node selector terms. The terms are ORed.";
            type = (
              types.listOf ControllerPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermModule
            );
          };
        };
      };
  ControllerPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpressionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "key" = mkOption {
            description = "The label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.";
            type = types.str;
          };
          "values" = mkOption {
            description = "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  ControllerPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchFieldModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "key" = mkOption {
            description = "The label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.";
            type = types.str;
          };
          "values" = mkOption {
            description = "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  ControllerPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "matchExpressions" = mkOption {
            description = "A list of node selector requirements by node's labels.";
            type = (
              types.listOf ControllerPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpressionModule
            );
            default = [ ];
          };
          "matchFields" = mkOption {
            description = "A list of node selector requirements by node's fields.";
            type = (
              types.listOf ControllerPodAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchFieldModule
            );
            default = [ ];
          };
        };
      };
  ControllerPodAffinityPodAffinityModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.";
        type = (
          types.listOf ControllerPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.";
        type = (
          types.listOf ControllerPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
    };
  };
  ControllerPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "podAffinityTerm" = mkOption {
            description = "Required. A pod affinity term, associated with the corresponding weight.";
            type =
              ControllerPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule;
          };
          "weight" = mkOption {
            description = "weight associated with matching the corresponding podAffinityTerm, in the range 1-100.";
            type = types.int;
          };
        };
      };
  ControllerPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "key" = mkOption {
            description = "key is the label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
            type = types.str;
          };
          "values" = mkOption {
            description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  ControllerPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ControllerPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  ControllerPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods. If it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr ControllerPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule
            );
            default = { };
          };
          "matchLabelKeys" = mkOption {
            description = "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `LabelSelector` as `key in (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both MatchLabelKeys and LabelSelector. Also, MatchLabelKeys cannot be set when LabelSelector isn't set. This is an alpha field and requires enabling MatchLabelKeysInPodAffinity feature gate.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "mismatchLabelKeys" = mkOption {
            description = "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `LabelSelector` as `key notin (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both MismatchLabelKeys and LabelSelector. Also, MismatchLabelKeys cannot be set when LabelSelector isn't set. This is an alpha field and requires enabling MatchLabelKeysInPodAffinity feature gate.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr ControllerPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule
            );
            default = { };
          };
          "namespaces" = mkOption {
            description = "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\".";
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            description = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.";
            type = types.str;
          };
        };
      };
  ControllerPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "key" = mkOption {
            description = "key is the label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
            type = types.str;
          };
          "values" = mkOption {
            description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  ControllerPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ControllerPodAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  ControllerPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "key" = mkOption {
            description = "key is the label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
            type = types.str;
          };
          "values" = mkOption {
            description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  ControllerPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ControllerPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  ControllerPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods. If it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr ControllerPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule
            );
            default = { };
          };
          "matchLabelKeys" = mkOption {
            description = "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `LabelSelector` as `key in (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both MatchLabelKeys and LabelSelector. Also, MatchLabelKeys cannot be set when LabelSelector isn't set. This is an alpha field and requires enabling MatchLabelKeysInPodAffinity feature gate.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "mismatchLabelKeys" = mkOption {
            description = "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `LabelSelector` as `key notin (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both MismatchLabelKeys and LabelSelector. Also, MismatchLabelKeys cannot be set when LabelSelector isn't set. This is an alpha field and requires enabling MatchLabelKeysInPodAffinity feature gate.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr ControllerPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule
            );
            default = { };
          };
          "namespaces" = mkOption {
            description = "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\".";
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            description = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.";
            type = types.str;
          };
        };
      };
  ControllerPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "key" = mkOption {
            description = "key is the label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
            type = types.str;
          };
          "values" = mkOption {
            description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  ControllerPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ControllerPodAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  ControllerPodAffinityPodAntiAffinityModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.";
        type = (
          types.listOf ControllerPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.";
        type = (
          types.listOf ControllerPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
    };
  };
  ControllerPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "podAffinityTerm" = mkOption {
            description = "Required. A pod affinity term, associated with the corresponding weight.";
            type =
              ControllerPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule;
          };
          "weight" = mkOption {
            description = "weight associated with matching the corresponding podAffinityTerm, in the range 1-100.";
            type = types.int;
          };
        };
      };
  ControllerPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "key" = mkOption {
            description = "key is the label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
            type = types.str;
          };
          "values" = mkOption {
            description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  ControllerPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ControllerPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  ControllerPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods. If it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr ControllerPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule
            );
            default = { };
          };
          "matchLabelKeys" = mkOption {
            description = "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `LabelSelector` as `key in (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both MatchLabelKeys and LabelSelector. Also, MatchLabelKeys cannot be set when LabelSelector isn't set. This is an alpha field and requires enabling MatchLabelKeysInPodAffinity feature gate.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "mismatchLabelKeys" = mkOption {
            description = "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `LabelSelector` as `key notin (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both MismatchLabelKeys and LabelSelector. Also, MismatchLabelKeys cannot be set when LabelSelector isn't set. This is an alpha field and requires enabling MatchLabelKeysInPodAffinity feature gate.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr ControllerPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule
            );
            default = { };
          };
          "namespaces" = mkOption {
            description = "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\".";
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            description = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.";
            type = types.str;
          };
        };
      };
  ControllerPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "key" = mkOption {
            description = "key is the label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
            type = types.str;
          };
          "values" = mkOption {
            description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  ControllerPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ControllerPodAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  ControllerPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "key" = mkOption {
            description = "key is the label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
            type = types.str;
          };
          "values" = mkOption {
            description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  ControllerPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ControllerPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  ControllerPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods. If it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr ControllerPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule
            );
            default = { };
          };
          "matchLabelKeys" = mkOption {
            description = "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `LabelSelector` as `key in (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both MatchLabelKeys and LabelSelector. Also, MatchLabelKeys cannot be set when LabelSelector isn't set. This is an alpha field and requires enabling MatchLabelKeysInPodAffinity feature gate.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "mismatchLabelKeys" = mkOption {
            description = "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `LabelSelector` as `key notin (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both MismatchLabelKeys and LabelSelector. Also, MismatchLabelKeys cannot be set when LabelSelector isn't set. This is an alpha field and requires enabling MatchLabelKeysInPodAffinity feature gate.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr ControllerPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule
            );
            default = { };
          };
          "namespaces" = mkOption {
            description = "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\".";
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            description = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.";
            type = types.str;
          };
        };
      };
  ControllerPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "key" = mkOption {
            description = "key is the label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
            type = types.str;
          };
          "values" = mkOption {
            description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  ControllerPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf ControllerPodAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  ControllerPodDisruptionBudgetModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "maxUnavailable" = mkOption {
        type = types.anything;
        default = null;
      };
      "minAvailable" = mkOption {
        type = types.anything;
        default = null;
      };
    };
  };
  ControllerPodDnsConfigModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "nameservers" = mkOption {
        description = "A list of DNS name server IP addresses. This will be appended to the base nameservers generated from DNSPolicy. Duplicated nameservers will be removed.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "options" = mkOption {
        description = "A list of DNS resolver options. This will be merged with the base options generated from DNSPolicy. Duplicated entries will be removed. Resolution options given in Options will override those that appear in the base DNSPolicy.";
        type = (types.listOf ControllerPodDnsConfigOptionModule);
        default = [ ];
      };
      "searches" = mkOption {
        description = "A list of DNS search domains for host-name lookup. This will be appended to the base search paths generated from DNSPolicy. Duplicated search paths will be removed.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  ControllerPodDnsConfigOptionModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "name" = mkOption {
        description = "Required.";
        type = types.str;
        default = null;
      };
      "value" = mkOption {
        type = types.str;
        default = null;
      };
    };
  };
  ControllerPodHostAliaseModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "hostnames" = mkOption {
        description = "Hostnames for the above IP address.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "ip" = mkOption {
        description = "IP address of the host file entry.";
        type = types.str;
        default = null;
      };
    };
  };
  ControllerPodImagePullSecretModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "name" = mkOption {
        description = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = types.str;
        default = null;
      };
    };
  };
  ControllerPodModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "affinity" = mkOption {
        description = "Set affinity constraint rules. Helm templates can be used.\nSee https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity";
        type = (types.nullOr ControllerPodAffinityModule);
        default = { };
      };
      "annotations" = mkOption {
        description = "Annotations to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "automountServiceAccountToken" = mkOption {
        description = "Set to true to automatically mount the service account token.";
        type = types.bool;
        default = true;
      };
      "dnsConfig" = mkOption {
        description = "Specifies the DNS parameters of a pod. Parameters specified here will be merged to the generated DNS configuration based on DNSPolicy.";
        type = (types.nullOr ControllerPodDnsConfigModule);
        default = { };
      };
      "dnsPolicy" = mkOption {
        description = "Configure the Pod DNS policy. Defaults to 'ClusterFirst' if hostNetwork is false and 'ClusterFirstWithHostNet' if hostNetwork is true.";
        type = types.str;
        default = null;
      };
      "enableServiceLinks" = mkOption {
        description = "Enable/disable the generation of environment variables for services.\nSee https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/#accessing-the-service";
        type = types.bool;
        default = false;
      };
      "hostAliases" = mkOption {
        description = "Use hostAliases to add custom entries to /etc/hosts - mapping IP addresses to hostnames.\nSee https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/";
        type = (types.listOf ControllerPodHostAliaseModule);
        default = [ ];
      };
      "hostIPC" = mkOption {
        description = "Set to true to use the host's ipc namespace.";
        type = types.bool;
        default = false;
      };
      "hostNetwork" = mkOption {
        description = "Set to false to disable host networking on the Pod. When using hostNetwork, make sure you set dnsPolicy to 'ClusterFirstWithHostNet'";
        type = types.bool;
        default = false;
      };
      "hostPID" = mkOption {
        description = "Set to true to use the host's pid namespace.";
        type = types.bool;
        default = false;
      };
      "hostUsers" = mkOption {
        description = "Set to false to create a new userns for the Pod. (Requires Kubernetes 1.29 or newer)";
        type = (types.nullOr types.bool);
        default = null;
      };
      "hostname" = mkOption {
        description = "Set the Pod's hostname.";
        type = types.str;
        default = null;
      };
      "imagePullSecrets" = mkOption {
        description = "Set image pull secrets.";
        type = (types.listOf ControllerPodImagePullSecretModule);
        default = [ ];
      };
      "labels" = mkOption {
        description = "Annotations to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "nodeSelector" = mkOption {
        description = "Node selection constraint.\nSee https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector";
        type = (types.attrsOf types.str);
        default = { };
      };
      "priorityClassName" = mkOption {
        description = "Custom priority class for different treatment by the scheduler.";
        type = types.str;
        default = null;
      };
      "resourceClaims" = mkOption {
        description = "ResourceClaims defines which ResourceClaims must be allocated and reserved before the Pod is allowed to start. The resources will be made available to those containers which consume them by name. (Requires Kubernetes 1.32 or newer)";
        type = (types.listOf ControllerPodResourceClaimModule);
        default = [ ];
      };
      "resources" = mkOption {
        description = "Set the resource requests / limits for the Pod. (Requires Kubernetes 1.32 or newer)";
        type = (types.nullOr ControllerPodResourcesModule);
        default = { };
      };
      "restartPolicy" = mkOption {
        description = "Set container restart policy. Defaults to 'Always'. When controller.type is 'cronjob' it defaults to 'Never'.";
        type = types.str;
        default = null;
      };
      "runtimeClassName" = mkOption {
        description = "Set a runtimeClassName other than the default one (ie: `nvidia`).";
        type = types.str;
        default = null;
      };
      "schedulerName" = mkOption {
        description = "Set a custom scheduler name.";
        type = types.str;
        default = null;
      };
      "schedulingGates" = mkOption {
        description = "SchedulingGates is an opaque list of values that if specified will block scheduling the pod. If schedulingGates is not empty, the pod will stay in the SchedulingGated state and the scheduler will not attempt to schedule the pod.\nSee https://kubernetes.io/docs/concepts/scheduling-eviction/pod-scheduling-readiness/";
        type = (types.listOf ControllerPodSchedulingGateModule);
        default = [ ];
      };
      "securityContext" = mkOption {
        description = "Configure the Security Context for the Pod.";
        type = (types.nullOr ControllerPodSecurityContextModule);
        default = { };
      };
      "shareProcessNamespace" = mkOption {
        description = "Allows sharing process namespace between containers in a Pod.\nSee https://kubernetes.io/docs/tasks/configure-pod-container/share-process-namespace/";
        type = (types.nullOr types.bool);
        default = false;
      };
      "terminationGracePeriodSeconds" = mkOption {
        description = "Duration in seconds the pod needs to terminate gracefully.\nSee https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#lifecycle";
        type = (types.nullOr types.int);
        default = null;
      };
      "tolerations" = mkOption {
        description = "Specify taint tolerations.\nSee https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/";
        type = (types.listOf ControllerPodTolerationModule);
        default = [ ];
      };
      "topologySpreadConstraints" = mkOption {
        description = "Defines topologySpreadConstraint rules.\nSee https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/";
        type = (types.listOf ControllerPodTopologySpreadConstraintModule);
        default = [ ];
      };
    };
  };
  ControllerPodResourceClaimModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "name" = mkOption {
        description = "Name uniquely identifies this resource claim inside the pod. This must be a DNS_LABEL.";
        type = types.str;
      };
      "resourceClaimName" = mkOption {
        description = "ResourceClaimName is the name of a ResourceClaim object in the same namespace as this pod.\n\nExactly one of ResourceClaimName and ResourceClaimTemplateName must be set.";
        type = types.str;
        default = null;
      };
      "resourceClaimTemplateName" = mkOption {
        description = "ResourceClaimTemplateName is the name of a ResourceClaimTemplate object in the same namespace as this pod.\n\nThe template will be used to create a new ResourceClaim, which will be bound to this pod. When this pod is deleted, the ResourceClaim will also be deleted. The pod name and resource name, along with a generated component, will be used to form a unique name for the ResourceClaim, which will be recorded in pod.status.resourceClaimStatuses.\n\nThis field is immutable and no changes will be made to the corresponding ResourceClaim by the control plane after creating the ResourceClaim.\n\nExactly one of ResourceClaimName and ResourceClaimTemplateName must be set.";
        type = types.str;
        default = null;
      };
    };
  };
  ControllerPodResourcesModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "claims" = mkOption {
        description = "Claims lists the names of resources, defined in spec.resourceClaims, that are used by this container.\n\nThis is an alpha field and requires enabling the DynamicResourceAllocation feature gate.\n\nThis field is immutable. It can only be set for containers.";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "limits" = mkOption {
        description = "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.attrsOf (types.either types.str types.number));
        default = { };
      };
      "requests" = mkOption {
        description = "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. Requests cannot exceed Limits. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.attrsOf (types.either types.str types.number));
        default = { };
      };
    };
  };
  ControllerPodSchedulingGateModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "name" = mkOption {
        description = "Name of the scheduling gate. Each gate is a string literal that represents a criteria that Pod should be satisfied before considered schedulable.";
        type = types.str;
      };
    };
  };
  ControllerPodSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "fsGroup" = mkOption {
        description = "A special supplemental group that applies to all containers in a pod. Some volume types allow the Kubelet to change the ownership of that volume to be owned by the pod:\n\n1. The owning GID will be the FSGroup 2. The setgid bit is set (new files created in the volume will be owned by FSGroup) 3. The permission bits are OR'd with rw-rw----\n\nIf unset, the Kubelet will not modify the ownership and permissions of any volume. Note that this field cannot be set when spec.os.name is windows.";
        type = types.int;
        default = null;
      };
      "fsGroupChangePolicy" = mkOption {
        description = "fsGroupChangePolicy defines behavior of changing ownership and permission of the volume before being exposed inside Pod. This field will only apply to volume types which support fsGroup based ownership(and permissions). It will have no effect on ephemeral volume types such as: secret, configmaps and emptydir. Valid values are \"OnRootMismatch\" and \"Always\". If not specified, \"Always\" is used. Note that this field cannot be set when spec.os.name is windows.";
        type = types.str;
        default = null;
      };
      "runAsGroup" = mkOption {
        description = "The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container. Note that this field cannot be set when spec.os.name is windows.";
        type = types.int;
        default = null;
      };
      "runAsNonRoot" = mkOption {
        description = "Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.";
        type = types.bool;
        default = false;
      };
      "runAsUser" = mkOption {
        description = "The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container. Note that this field cannot be set when spec.os.name is windows.";
        type = types.int;
        default = null;
      };
      "seLinuxOptions" = mkOption {
        description = "The SELinux context to be applied to all containers. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container. Note that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr ControllerPodSecurityContextSeLinuxOptionsModule);
        default = { };
      };
      "seccompProfile" = mkOption {
        description = "The seccomp options to use by the containers in this pod. Note that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr ControllerPodSecurityContextSeccompProfileModule);
        default = { };
      };
      "supplementalGroups" = mkOption {
        description = "A list of groups applied to the first process run in each container, in addition to the container's primary GID, the fsGroup (if specified), and group memberships defined in the container image for the uid of the container process. If unspecified, no additional groups are added to any container. Note that group memberships defined in the container image for the uid of the container process are still effective, even if they are not included in this list. Note that this field cannot be set when spec.os.name is windows.";
        type = (types.listOf types.int);
        default = [ ];
      };
      "supplementalGroupsPolicy" = mkOption {
        description = "Defines how supplemental groups of the the first process in each container are calculated. Valid values are \"Merge\" and \"Strict\". If not specified, \"Merge\" is used. Note that this field cannot be set when spec.os.name is windows.";
        type = (
          types.enum [
            "Merge"
            "Strict"
          ]
        );
      };
      "sysctls" = mkOption {
        description = "Sysctls hold a list of namespaced sysctls used for the pod. Pods with unsupported sysctls (by the container runtime) might fail to launch. Note that this field cannot be set when spec.os.name is windows.";
        type = (types.listOf ControllerPodSecurityContextSysctlModule);
        default = [ ];
      };
    };
  };
  ControllerPodSecurityContextSeLinuxOptionsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "level" = mkOption {
        description = "Level is SELinux level label that applies to the container.";
        type = types.str;
        default = null;
      };
      "role" = mkOption {
        description = "Role is a SELinux role label that applies to the container.";
        type = types.str;
        default = null;
      };
      "type" = mkOption {
        description = "Type is a SELinux type label that applies to the container.";
        type = types.str;
        default = null;
      };
      "user" = mkOption {
        description = "User is a SELinux user label that applies to the container.";
        type = types.str;
        default = null;
      };
    };
  };
  ControllerPodSecurityContextSeccompProfileModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "localhostProfile" = mkOption {
        description = "localhostProfile indicates a profile defined in a file on the node should be used. The profile must be preconfigured on the node to work. Must be a descending path, relative to the kubelet's configured seccomp profile location. Must be set if type is \"Localhost\". Must NOT be set for any other type.";
        type = types.str;
        default = null;
      };
      "type" = mkOption {
        description = "type indicates which kind of seccomp profile will be applied. Valid options are:\n\nLocalhost - a profile defined in a file on the node should be used. RuntimeDefault - the container runtime default profile should be used. Unconfined - no profile should be applied.";
        type = types.str;
      };
    };
  };
  ControllerPodSecurityContextSysctlModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "name" = mkOption {
        description = "Name of a property to set";
        type = types.str;
      };
      "value" = mkOption {
        description = "Value of a property to set";
        type = types.str;
      };
    };
  };
  ControllerPodTolerationModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "effect" = mkOption {
        description = "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute.";
        type = types.str;
        default = null;
      };
      "key" = mkOption {
        description = "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys.";
        type = types.str;
        default = null;
      };
      "operator" = mkOption {
        description = "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category.";
        type = types.str;
        default = null;
      };
      "tolerationSeconds" = mkOption {
        description = "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system.";
        type = types.int;
        default = null;
      };
      "value" = mkOption {
        description = "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string.";
        type = types.str;
        default = null;
      };
    };
  };
  ControllerPodTopologySpreadConstraintLabelSelectorMatchExpressionModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "key" = mkOption {
        description = "key is the label key that the selector applies to.";
        type = types.str;
      };
      "operator" = mkOption {
        description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
        type = types.str;
      };
      "values" = mkOption {
        description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  ControllerPodTopologySpreadConstraintLabelSelectorModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf ControllerPodTopologySpreadConstraintLabelSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  ControllerPodTopologySpreadConstraintModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "labelSelector" = mkOption {
        description = "LabelSelector is used to find matching pods. Pods that match this label selector are counted to determine the number of pods in their corresponding topology domain.";
        type = (types.nullOr ControllerPodTopologySpreadConstraintLabelSelectorModule);
        default = { };
      };
      "matchLabelKeys" = mkOption {
        description = "MatchLabelKeys is a set of pod label keys to select the pods over which spreading will be calculated. The keys are used to lookup values from the incoming pod labels, those key-value labels are ANDed with labelSelector to select the group of existing pods over which spreading will be calculated for the incoming pod. The same key is forbidden to exist in both MatchLabelKeys and LabelSelector. MatchLabelKeys cannot be set when LabelSelector isn't set. Keys that don't exist in the incoming pod labels will be ignored. A null or empty list means only match against labelSelector.\n\nThis is a beta field and requires the MatchLabelKeysInPodTopologySpread feature gate to be enabled (enabled by default).";
        type = (types.listOf types.str);
        default = [ ];
      };
      "maxSkew" = mkOption {
        description = "MaxSkew describes the degree to which pods may be unevenly distributed. When `whenUnsatisfiable=DoNotSchedule`, it is the maximum permitted difference between the number of matching pods in the target topology and the global minimum. The global minimum is the minimum number of matching pods in an eligible domain or zero if the number of eligible domains is less than MinDomains. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 2/2/1: In this case, the global minimum is 1. | zone1 | zone2 | zone3 | |  P P  |  P P  |   P   | - if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 2/2/2; scheduling it onto zone1(zone2) would make the ActualSkew(3-1) on zone1(zone2) violate MaxSkew(1). - if MaxSkew is 2, incoming pod can be scheduled onto any zone. When `whenUnsatisfiable=ScheduleAnyway`, it is used to give higher precedence to topologies that satisfy it. It's a required field. Default value is 1 and 0 is not allowed.";
        type = types.int;
      };
      "minDomains" = mkOption {
        description = "MinDomains indicates a minimum number of eligible domains. When the number of eligible domains with matching topology keys is less than minDomains, Pod Topology Spread treats \"global minimum\" as 0, and then the calculation of Skew is performed. And when the number of eligible domains with matching topology keys equals or greater than minDomains, this value has no effect on scheduling. As a result, when the number of eligible domains is less than minDomains, scheduler won't schedule more than maxSkew Pods to those domains. If value is nil, the constraint behaves as if MinDomains is equal to 1. Valid values are integers greater than 0. When value is not nil, WhenUnsatisfiable must be DoNotSchedule.\n\nFor example, in a 3-zone cluster, MaxSkew is set to 2, MinDomains is set to 5 and pods with the same labelSelector spread as 2/2/2: | zone1 | zone2 | zone3 | |  P P  |  P P  |  P P  | The number of domains is less than 5(MinDomains), so \"global minimum\" is treated as 0. In this situation, new pod with the same labelSelector cannot be scheduled, because computed skew will be 3(3 - 0) if new Pod is scheduled to any of the three zones, it will violate MaxSkew.\n\nThis is a beta field and requires the MinDomainsInPodTopologySpread feature gate to be enabled (enabled by default).";
        type = types.int;
        default = null;
      };
      "nodeAffinityPolicy" = mkOption {
        description = "NodeAffinityPolicy indicates how we will treat Pod's nodeAffinity/nodeSelector when calculating pod topology spread skew. Options are: - Honor: only nodes matching nodeAffinity/nodeSelector are included in the calculations. - Ignore: nodeAffinity/nodeSelector are ignored. All nodes are included in the calculations.\n\nIf this value is nil, the behavior is equivalent to the Honor policy. This is a beta-level feature default enabled by the NodeInclusionPolicyInPodTopologySpread feature flag.";
        type = types.str;
        default = null;
      };
      "nodeTaintsPolicy" = mkOption {
        description = "NodeTaintsPolicy indicates how we will treat node taints when calculating pod topology spread skew. Options are: - Honor: nodes without taints, along with tainted nodes for which the incoming pod has a toleration, are included. - Ignore: node taints are ignored. All nodes are included.\n\nIf this value is nil, the behavior is equivalent to the Ignore policy. This is a beta-level feature default enabled by the NodeInclusionPolicyInPodTopologySpread feature flag.";
        type = types.str;
        default = null;
      };
      "topologyKey" = mkOption {
        description = "TopologyKey is the key of node labels. Nodes that have a label with this key and identical values are considered to be in the same topology. We consider each <key, value> as a \"bucket\", and try to put balanced number of pods into each bucket. We define a domain as a particular instance of a topology. Also, we define an eligible domain as a domain whose nodes meet the requirements of nodeAffinityPolicy and nodeTaintsPolicy. e.g. If TopologyKey is \"kubernetes.io/hostname\", each Node is a domain of that topology. And, if TopologyKey is \"topology.kubernetes.io/zone\", each zone is a domain of that topology. It's a required field.";
        type = types.str;
      };
      "whenUnsatisfiable" = mkOption {
        description = "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint. - DoNotSchedule (default) tells the scheduler not to schedule it. - ScheduleAnyway tells the scheduler to schedule the pod in any location,\n  but giving higher precedence to topologies that would help reduce the\n  skew.\nA constraint is considered \"Unsatisfiable\" for an incoming pod if and only if every possible node assignment for that pod would violate \"MaxSkew\" on some topology. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 3/1/1: | zone1 | zone2 | zone3 | | P P P |   P   |   P   | If WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled to zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies MaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler won't make it *more* imbalanced. It's a required field.";
        type = types.str;
      };
    };
  };
  ControllerServiceAccountModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "identifier" = mkOption {
        description = "Reference a serviceAccount configured in this chart by its key.";
        type = types.str;
        default = null;
      };
      "name" = mkOption {
        description = "Reference a serviceAccount by its name. Helm templates are supported.";
        type = types.str;
        default = null;
      };
    };
  };
  ControllerStatefulsetModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "persistentVolumeClaimRetentionPolicy" = mkOption {
        type = (types.nullOr ControllerStatefulsetPersistentVolumeClaimRetentionPolicyModule);
        default = { };
      };
      "podManagementPolicy" = mkOption {
        type = types.str;
        default = null;
      };
      "serviceName" = mkOption {
        type = types.anything;
        default = { };
      };
      "startOrdinal" = mkOption {
        type = types.int;
        default = 0;
      };
      "volumeClaimTemplates" = mkOption {
        type = (types.listOf ControllerStatefulsetVolumeClaimTemplateModule);
        default = [ ];
      };
    };
  };
  ControllerStatefulsetPersistentVolumeClaimRetentionPolicyModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "whenDeleted" = mkOption {
        type = (
          types.enum [
            "Delete"
            "Retain"
          ]
        );
        default = "Retain";
      };
      "whenScaled" = mkOption {
        type = (
          types.enum [
            "Delete"
            "Retain"
          ]
        );
        default = "Retain";
      };
    };
  };
  ControllerStatefulsetVolumeClaimTemplateDataSourceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "apiGroup" = mkOption {
        type = types.str;
        default = null;
      };
      "kind" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = types.str;
      };
    };
  };
  ControllerStatefulsetVolumeClaimTemplateDataSourceRefModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "apiGroup" = mkOption {
        type = types.str;
        default = null;
      };
      "kind" = mkOption {
        type = types.str;
      };
      "name" = mkOption {
        type = types.str;
      };
    };
  };
  ControllerStatefulsetVolumeClaimTemplateModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "accessMode" = mkOption {
        type = types.str;
        default = null;
      };
      "advancedMounts" = mkOption {
        type = (types.attrsOf (types.listOf types.anything));
        default = { };
      };
      "annotations" = mkOption {
        description = "Annotations to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "dataSource" = mkOption {
        type = (types.nullOr ControllerStatefulsetVolumeClaimTemplateDataSourceModule);
        default = { };
      };
      "dataSourceRef" = mkOption {
        type = (types.nullOr ControllerStatefulsetVolumeClaimTemplateDataSourceRefModule);
        default = { };
      };
      "enabled" = mkOption {
        type = types.bool;
        default = true;
      };
      "globalMounts" = mkOption {
        type = (types.listOf types.anything);
        default = [ ];
      };
      "labels" = mkOption {
        description = "Labels to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "name" = mkOption {
        type = types.str;
      };
      "size" = mkOption {
        type = types.str;
      };
      "storageClass" = mkOption {
        type = types.str;
        default = null;
      };
    };
  };
  DefaultPodOptionsAffinityModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "nodeAffinity" = mkOption {
        description = "Describes node affinity scheduling rules for the pod.";
        type = (types.nullOr DefaultPodOptionsAffinityNodeAffinityModule);
        default = { };
      };
      "podAffinity" = mkOption {
        description = "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s)).";
        type = (types.nullOr DefaultPodOptionsAffinityPodAffinityModule);
        default = { };
      };
      "podAntiAffinity" = mkOption {
        description = "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s)).";
        type = (types.nullOr DefaultPodOptionsAffinityPodAntiAffinityModule);
        default = { };
      };
    };
  };
  DefaultPodOptionsAffinityNodeAffinityModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred.";
        type = (
          types.listOf DefaultPodOptionsAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node.";
        type = (
          types.nullOr DefaultPodOptionsAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = { };
      };
    };
  };
  DefaultPodOptionsAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "preference" = mkOption {
            description = "A node selector term, associated with the corresponding weight.";
            type =
              DefaultPodOptionsAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceModule;
          };
          "weight" = mkOption {
            description = "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100.";
            type = types.int;
          };
        };
      };
  DefaultPodOptionsAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpressionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "key" = mkOption {
            description = "The label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.";
            type = types.str;
          };
          "values" = mkOption {
            description = "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  DefaultPodOptionsAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchFieldModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "key" = mkOption {
            description = "The label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.";
            type = types.str;
          };
          "values" = mkOption {
            description = "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  DefaultPodOptionsAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "matchExpressions" = mkOption {
            description = "A list of node selector requirements by node's labels.";
            type = (
              types.listOf DefaultPodOptionsAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchExpressionModule
            );
            default = [ ];
          };
          "matchFields" = mkOption {
            description = "A list of node selector requirements by node's fields.";
            type = (
              types.listOf DefaultPodOptionsAffinityNodeAffinityPreferredDuringSchedulingIgnoredDuringExecutionPreferenceMatchFieldModule
            );
            default = [ ];
          };
        };
      };
  DefaultPodOptionsAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "nodeSelectorTerms" = mkOption {
            description = "Required. A list of node selector terms. The terms are ORed.";
            type = (
              types.listOf DefaultPodOptionsAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermModule
            );
          };
        };
      };
  DefaultPodOptionsAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpressionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "key" = mkOption {
            description = "The label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.";
            type = types.str;
          };
          "values" = mkOption {
            description = "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  DefaultPodOptionsAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchFieldModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "key" = mkOption {
            description = "The label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.";
            type = types.str;
          };
          "values" = mkOption {
            description = "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  DefaultPodOptionsAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "matchExpressions" = mkOption {
            description = "A list of node selector requirements by node's labels.";
            type = (
              types.listOf DefaultPodOptionsAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchExpressionModule
            );
            default = [ ];
          };
          "matchFields" = mkOption {
            description = "A list of node selector requirements by node's fields.";
            type = (
              types.listOf DefaultPodOptionsAffinityNodeAffinityRequiredDuringSchedulingIgnoredDuringExecutionNodeSelectorTermMatchFieldModule
            );
            default = [ ];
          };
        };
      };
  DefaultPodOptionsAffinityPodAffinityModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.";
        type = (
          types.listOf DefaultPodOptionsAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.";
        type = (
          types.listOf DefaultPodOptionsAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
    };
  };
  DefaultPodOptionsAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "podAffinityTerm" = mkOption {
            description = "Required. A pod affinity term, associated with the corresponding weight.";
            type =
              DefaultPodOptionsAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule;
          };
          "weight" = mkOption {
            description = "weight associated with matching the corresponding podAffinityTerm, in the range 1-100.";
            type = types.int;
          };
        };
      };
  DefaultPodOptionsAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "key" = mkOption {
            description = "key is the label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
            type = types.str;
          };
          "values" = mkOption {
            description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  DefaultPodOptionsAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf DefaultPodOptionsAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  DefaultPodOptionsAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods. If it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr DefaultPodOptionsAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule
            );
            default = { };
          };
          "matchLabelKeys" = mkOption {
            description = "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `LabelSelector` as `key in (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both MatchLabelKeys and LabelSelector. Also, MatchLabelKeys cannot be set when LabelSelector isn't set. This is an alpha field and requires enabling MatchLabelKeysInPodAffinity feature gate.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "mismatchLabelKeys" = mkOption {
            description = "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `LabelSelector` as `key notin (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both MismatchLabelKeys and LabelSelector. Also, MismatchLabelKeys cannot be set when LabelSelector isn't set. This is an alpha field and requires enabling MatchLabelKeysInPodAffinity feature gate.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr DefaultPodOptionsAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule
            );
            default = { };
          };
          "namespaces" = mkOption {
            description = "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\".";
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            description = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.";
            type = types.str;
          };
        };
      };
  DefaultPodOptionsAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "key" = mkOption {
            description = "key is the label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
            type = types.str;
          };
          "values" = mkOption {
            description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  DefaultPodOptionsAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf DefaultPodOptionsAffinityPodAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  DefaultPodOptionsAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "key" = mkOption {
            description = "key is the label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
            type = types.str;
          };
          "values" = mkOption {
            description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  DefaultPodOptionsAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf DefaultPodOptionsAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  DefaultPodOptionsAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods. If it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr DefaultPodOptionsAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule
            );
            default = { };
          };
          "matchLabelKeys" = mkOption {
            description = "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `LabelSelector` as `key in (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both MatchLabelKeys and LabelSelector. Also, MatchLabelKeys cannot be set when LabelSelector isn't set. This is an alpha field and requires enabling MatchLabelKeysInPodAffinity feature gate.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "mismatchLabelKeys" = mkOption {
            description = "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `LabelSelector` as `key notin (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both MismatchLabelKeys and LabelSelector. Also, MismatchLabelKeys cannot be set when LabelSelector isn't set. This is an alpha field and requires enabling MatchLabelKeysInPodAffinity feature gate.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr DefaultPodOptionsAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule
            );
            default = { };
          };
          "namespaces" = mkOption {
            description = "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\".";
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            description = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.";
            type = types.str;
          };
        };
      };
  DefaultPodOptionsAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "key" = mkOption {
            description = "key is the label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
            type = types.str;
          };
          "values" = mkOption {
            description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  DefaultPodOptionsAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf DefaultPodOptionsAffinityPodAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  DefaultPodOptionsAffinityPodAntiAffinityModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "preferredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.";
        type = (
          types.listOf DefaultPodOptionsAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
      "requiredDuringSchedulingIgnoredDuringExecution" = mkOption {
        description = "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.";
        type = (
          types.listOf DefaultPodOptionsAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule
        );
        default = [ ];
      };
    };
  };
  DefaultPodOptionsAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "podAffinityTerm" = mkOption {
            description = "Required. A pod affinity term, associated with the corresponding weight.";
            type =
              DefaultPodOptionsAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule;
          };
          "weight" = mkOption {
            description = "weight associated with matching the corresponding podAffinityTerm, in the range 1-100.";
            type = types.int;
          };
        };
      };
  DefaultPodOptionsAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "key" = mkOption {
            description = "key is the label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
            type = types.str;
          };
          "values" = mkOption {
            description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  DefaultPodOptionsAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf DefaultPodOptionsAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  DefaultPodOptionsAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods. If it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr DefaultPodOptionsAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermLabelSelectorModule
            );
            default = { };
          };
          "matchLabelKeys" = mkOption {
            description = "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `LabelSelector` as `key in (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both MatchLabelKeys and LabelSelector. Also, MatchLabelKeys cannot be set when LabelSelector isn't set. This is an alpha field and requires enabling MatchLabelKeysInPodAffinity feature gate.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "mismatchLabelKeys" = mkOption {
            description = "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `LabelSelector` as `key notin (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both MismatchLabelKeys and LabelSelector. Also, MismatchLabelKeys cannot be set when LabelSelector isn't set. This is an alpha field and requires enabling MatchLabelKeysInPodAffinity feature gate.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr DefaultPodOptionsAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule
            );
            default = { };
          };
          "namespaces" = mkOption {
            description = "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\".";
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            description = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.";
            type = types.str;
          };
        };
      };
  DefaultPodOptionsAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "key" = mkOption {
            description = "key is the label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
            type = types.str;
          };
          "values" = mkOption {
            description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  DefaultPodOptionsAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf DefaultPodOptionsAffinityPodAntiAffinityPreferredDuringSchedulingIgnoredDuringExecutionPodAffinityTermNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  DefaultPodOptionsAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "key" = mkOption {
            description = "key is the label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
            type = types.str;
          };
          "values" = mkOption {
            description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  DefaultPodOptionsAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf DefaultPodOptionsAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  DefaultPodOptionsAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "labelSelector" = mkOption {
            description = "A label query over a set of resources, in this case pods. If it's null, this PodAffinityTerm matches with no Pods.";
            type = (
              types.nullOr DefaultPodOptionsAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionLabelSelectorModule
            );
            default = { };
          };
          "matchLabelKeys" = mkOption {
            description = "MatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `LabelSelector` as `key in (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both MatchLabelKeys and LabelSelector. Also, MatchLabelKeys cannot be set when LabelSelector isn't set. This is an alpha field and requires enabling MatchLabelKeysInPodAffinity feature gate.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "mismatchLabelKeys" = mkOption {
            description = "MismatchLabelKeys is a set of pod label keys to select which pods will be taken into consideration. The keys are used to lookup values from the incoming pod labels, those key-value labels are merged with `LabelSelector` as `key notin (value)` to select the group of existing pods which pods will be taken into consideration for the incoming pod's pod (anti) affinity. Keys that don't exist in the incoming pod labels will be ignored. The default value is empty. The same key is forbidden to exist in both MismatchLabelKeys and LabelSelector. Also, MismatchLabelKeys cannot be set when LabelSelector isn't set. This is an alpha field and requires enabling MatchLabelKeysInPodAffinity feature gate.";
            type = (types.listOf types.str);
            default = [ ];
          };
          "namespaceSelector" = mkOption {
            description = "A label query over the set of namespaces that the term applies to. The term is applied to the union of the namespaces selected by this field and the ones listed in the namespaces field. null selector and null or empty namespaces list means \"this pod's namespace\". An empty selector ({}) matches all namespaces.";
            type = (
              types.nullOr DefaultPodOptionsAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule
            );
            default = { };
          };
          "namespaces" = mkOption {
            description = "namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \"this pod's namespace\".";
            type = (types.listOf types.str);
            default = [ ];
          };
          "topologyKey" = mkOption {
            description = "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.";
            type = types.str;
          };
        };
      };
  DefaultPodOptionsAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "key" = mkOption {
            description = "key is the label key that the selector applies to.";
            type = types.str;
          };
          "operator" = mkOption {
            description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
            type = types.str;
          };
          "values" = mkOption {
            description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
            type = (types.listOf types.str);
            default = [ ];
          };
        };
      };
  DefaultPodOptionsAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorModule =
    types.submodule
      {
        freeformType = types.attrsOf types.anything;
        options = {
          "matchExpressions" = mkOption {
            description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
            type = (
              types.listOf DefaultPodOptionsAffinityPodAntiAffinityRequiredDuringSchedulingIgnoredDuringExecutionNamespaceSelectorMatchExpressionModule
            );
            default = [ ];
          };
          "matchLabels" = mkOption {
            description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
            type = (types.attrsOf types.str);
            default = { };
          };
        };
      };
  DefaultPodOptionsDnsConfigModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "nameservers" = mkOption {
        description = "A list of DNS name server IP addresses. This will be appended to the base nameservers generated from DNSPolicy. Duplicated nameservers will be removed.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "options" = mkOption {
        description = "A list of DNS resolver options. This will be merged with the base options generated from DNSPolicy. Duplicated entries will be removed. Resolution options given in Options will override those that appear in the base DNSPolicy.";
        type = (types.listOf DefaultPodOptionsDnsConfigOptionModule);
        default = [ ];
      };
      "searches" = mkOption {
        description = "A list of DNS search domains for host-name lookup. This will be appended to the base search paths generated from DNSPolicy. Duplicated search paths will be removed.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  DefaultPodOptionsDnsConfigOptionModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "name" = mkOption {
        description = "Required.";
        type = types.str;
        default = null;
      };
      "value" = mkOption {
        type = types.str;
        default = null;
      };
    };
  };
  DefaultPodOptionsHostAliaseModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "hostnames" = mkOption {
        description = "Hostnames for the above IP address.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "ip" = mkOption {
        description = "IP address of the host file entry.";
        type = types.str;
        default = null;
      };
    };
  };
  DefaultPodOptionsImagePullSecretModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "name" = mkOption {
        description = "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = types.str;
        default = null;
      };
    };
  };
  DefaultPodOptionsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "affinity" = mkOption {
        description = "Set affinity constraint rules. Helm templates can be used.\nSee https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity";
        type = (types.nullOr DefaultPodOptionsAffinityModule);
        default = { };
      };
      "annotations" = mkOption {
        description = "Annotations to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "automountServiceAccountToken" = mkOption {
        description = "Set to true to automatically mount the service account token.";
        type = types.bool;
        default = true;
      };
      "dnsConfig" = mkOption {
        description = "Specifies the DNS parameters of a pod. Parameters specified here will be merged to the generated DNS configuration based on DNSPolicy.";
        type = (types.nullOr DefaultPodOptionsDnsConfigModule);
        default = { };
      };
      "dnsPolicy" = mkOption {
        description = "Configure the Pod DNS policy. Defaults to 'ClusterFirst' if hostNetwork is false and 'ClusterFirstWithHostNet' if hostNetwork is true.";
        type = types.str;
        default = null;
      };
      "enableServiceLinks" = mkOption {
        description = "Enable/disable the generation of environment variables for services.\nSee https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/#accessing-the-service";
        type = types.bool;
        default = false;
      };
      "hostAliases" = mkOption {
        description = "Use hostAliases to add custom entries to /etc/hosts - mapping IP addresses to hostnames.\nSee https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/";
        type = (types.listOf DefaultPodOptionsHostAliaseModule);
        default = [ ];
      };
      "hostIPC" = mkOption {
        description = "Set to true to use the host's ipc namespace.";
        type = types.bool;
        default = false;
      };
      "hostNetwork" = mkOption {
        description = "Set to false to disable host networking on the Pod. When using hostNetwork, make sure you set dnsPolicy to 'ClusterFirstWithHostNet'";
        type = types.bool;
        default = false;
      };
      "hostPID" = mkOption {
        description = "Set to true to use the host's pid namespace.";
        type = types.bool;
        default = false;
      };
      "hostUsers" = mkOption {
        description = "Set to false to create a new userns for the Pod. (Requires Kubernetes 1.29 or newer)";
        type = (types.nullOr types.bool);
        default = null;
      };
      "hostname" = mkOption {
        description = "Set the Pod's hostname.";
        type = types.str;
        default = null;
      };
      "imagePullSecrets" = mkOption {
        description = "Set image pull secrets.";
        type = (types.listOf DefaultPodOptionsImagePullSecretModule);
        default = [ ];
      };
      "labels" = mkOption {
        description = "Annotations to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "nodeSelector" = mkOption {
        description = "Node selection constraint.\nSee https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector";
        type = (types.attrsOf types.str);
        default = { };
      };
      "priorityClassName" = mkOption {
        description = "Custom priority class for different treatment by the scheduler.";
        type = types.str;
        default = null;
      };
      "resourceClaims" = mkOption {
        description = "ResourceClaims defines which ResourceClaims must be allocated and reserved before the Pod is allowed to start. The resources will be made available to those containers which consume them by name. (Requires Kubernetes 1.32 or newer)";
        type = (types.listOf DefaultPodOptionsResourceClaimModule);
        default = [ ];
      };
      "resources" = mkOption {
        description = "Set the resource requests / limits for the Pod. (Requires Kubernetes 1.32 or newer)";
        type = (types.nullOr DefaultPodOptionsResourcesModule);
        default = { };
      };
      "restartPolicy" = mkOption {
        description = "Set container restart policy. Defaults to 'Always'. When controller.type is 'cronjob' it defaults to 'Never'.";
        type = types.str;
        default = null;
      };
      "runtimeClassName" = mkOption {
        description = "Set a runtimeClassName other than the default one (ie: `nvidia`).";
        type = types.str;
        default = null;
      };
      "schedulerName" = mkOption {
        description = "Set a custom scheduler name.";
        type = types.str;
        default = null;
      };
      "schedulingGates" = mkOption {
        description = "SchedulingGates is an opaque list of values that if specified will block scheduling the pod. If schedulingGates is not empty, the pod will stay in the SchedulingGated state and the scheduler will not attempt to schedule the pod.\nSee https://kubernetes.io/docs/concepts/scheduling-eviction/pod-scheduling-readiness/";
        type = (types.listOf DefaultPodOptionsSchedulingGateModule);
        default = [ ];
      };
      "securityContext" = mkOption {
        description = "Configure the Security Context for the Pod.";
        type = (types.nullOr DefaultPodOptionsSecurityContextModule);
        default = { };
      };
      "shareProcessNamespace" = mkOption {
        description = "Allows sharing process namespace between containers in a Pod.\nSee https://kubernetes.io/docs/tasks/configure-pod-container/share-process-namespace/";
        type = (types.nullOr types.bool);
        default = false;
      };
      "terminationGracePeriodSeconds" = mkOption {
        description = "Duration in seconds the pod needs to terminate gracefully.\nSee https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#lifecycle";
        type = (types.nullOr types.int);
        default = null;
      };
      "tolerations" = mkOption {
        description = "Specify taint tolerations.\nSee https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/";
        type = (types.listOf DefaultPodOptionsTolerationModule);
        default = [ ];
      };
      "topologySpreadConstraints" = mkOption {
        description = "Defines topologySpreadConstraint rules.\nSee https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/";
        type = (types.listOf DefaultPodOptionsTopologySpreadConstraintModule);
        default = [ ];
      };
    };
  };
  DefaultPodOptionsResourceClaimModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "name" = mkOption {
        description = "Name uniquely identifies this resource claim inside the pod. This must be a DNS_LABEL.";
        type = types.str;
      };
      "resourceClaimName" = mkOption {
        description = "ResourceClaimName is the name of a ResourceClaim object in the same namespace as this pod.\n\nExactly one of ResourceClaimName and ResourceClaimTemplateName must be set.";
        type = types.str;
        default = null;
      };
      "resourceClaimTemplateName" = mkOption {
        description = "ResourceClaimTemplateName is the name of a ResourceClaimTemplate object in the same namespace as this pod.\n\nThe template will be used to create a new ResourceClaim, which will be bound to this pod. When this pod is deleted, the ResourceClaim will also be deleted. The pod name and resource name, along with a generated component, will be used to form a unique name for the ResourceClaim, which will be recorded in pod.status.resourceClaimStatuses.\n\nThis field is immutable and no changes will be made to the corresponding ResourceClaim by the control plane after creating the ResourceClaim.\n\nExactly one of ResourceClaimName and ResourceClaimTemplateName must be set.";
        type = types.str;
        default = null;
      };
    };
  };
  DefaultPodOptionsResourcesModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "claims" = mkOption {
        description = "Claims lists the names of resources, defined in spec.resourceClaims, that are used by this container.\n\nThis is an alpha field and requires enabling the DynamicResourceAllocation feature gate.\n\nThis field is immutable. It can only be set for containers.";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "limits" = mkOption {
        description = "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.attrsOf (types.either types.str types.number));
        default = { };
      };
      "requests" = mkOption {
        description = "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. Requests cannot exceed Limits. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.attrsOf (types.either types.str types.number));
        default = { };
      };
    };
  };
  DefaultPodOptionsSchedulingGateModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "name" = mkOption {
        description = "Name of the scheduling gate. Each gate is a string literal that represents a criteria that Pod should be satisfied before considered schedulable.";
        type = types.str;
      };
    };
  };
  DefaultPodOptionsSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "fsGroup" = mkOption {
        description = "A special supplemental group that applies to all containers in a pod. Some volume types allow the Kubelet to change the ownership of that volume to be owned by the pod:\n\n1. The owning GID will be the FSGroup 2. The setgid bit is set (new files created in the volume will be owned by FSGroup) 3. The permission bits are OR'd with rw-rw----\n\nIf unset, the Kubelet will not modify the ownership and permissions of any volume. Note that this field cannot be set when spec.os.name is windows.";
        type = types.int;
        default = null;
      };
      "fsGroupChangePolicy" = mkOption {
        description = "fsGroupChangePolicy defines behavior of changing ownership and permission of the volume before being exposed inside Pod. This field will only apply to volume types which support fsGroup based ownership(and permissions). It will have no effect on ephemeral volume types such as: secret, configmaps and emptydir. Valid values are \"OnRootMismatch\" and \"Always\". If not specified, \"Always\" is used. Note that this field cannot be set when spec.os.name is windows.";
        type = types.str;
        default = null;
      };
      "runAsGroup" = mkOption {
        description = "The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container. Note that this field cannot be set when spec.os.name is windows.";
        type = types.int;
        default = null;
      };
      "runAsNonRoot" = mkOption {
        description = "Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence.";
        type = types.bool;
        default = false;
      };
      "runAsUser" = mkOption {
        description = "The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container. Note that this field cannot be set when spec.os.name is windows.";
        type = types.int;
        default = null;
      };
      "seLinuxOptions" = mkOption {
        description = "The SELinux context to be applied to all containers. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container. Note that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr DefaultPodOptionsSecurityContextSeLinuxOptionsModule);
        default = { };
      };
      "seccompProfile" = mkOption {
        description = "The seccomp options to use by the containers in this pod. Note that this field cannot be set when spec.os.name is windows.";
        type = (types.nullOr DefaultPodOptionsSecurityContextSeccompProfileModule);
        default = { };
      };
      "supplementalGroups" = mkOption {
        description = "A list of groups applied to the first process run in each container, in addition to the container's primary GID, the fsGroup (if specified), and group memberships defined in the container image for the uid of the container process. If unspecified, no additional groups are added to any container. Note that group memberships defined in the container image for the uid of the container process are still effective, even if they are not included in this list. Note that this field cannot be set when spec.os.name is windows.";
        type = (types.listOf types.int);
        default = [ ];
      };
      "supplementalGroupsPolicy" = mkOption {
        description = "Defines how supplemental groups of the the first process in each container are calculated. Valid values are \"Merge\" and \"Strict\". If not specified, \"Merge\" is used. Note that this field cannot be set when spec.os.name is windows.";
        type = (
          types.enum [
            "Merge"
            "Strict"
          ]
        );
      };
      "sysctls" = mkOption {
        description = "Sysctls hold a list of namespaced sysctls used for the pod. Pods with unsupported sysctls (by the container runtime) might fail to launch. Note that this field cannot be set when spec.os.name is windows.";
        type = (types.listOf DefaultPodOptionsSecurityContextSysctlModule);
        default = [ ];
      };
    };
  };
  DefaultPodOptionsSecurityContextSeLinuxOptionsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "level" = mkOption {
        description = "Level is SELinux level label that applies to the container.";
        type = types.str;
        default = null;
      };
      "role" = mkOption {
        description = "Role is a SELinux role label that applies to the container.";
        type = types.str;
        default = null;
      };
      "type" = mkOption {
        description = "Type is a SELinux type label that applies to the container.";
        type = types.str;
        default = null;
      };
      "user" = mkOption {
        description = "User is a SELinux user label that applies to the container.";
        type = types.str;
        default = null;
      };
    };
  };
  DefaultPodOptionsSecurityContextSeccompProfileModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "localhostProfile" = mkOption {
        description = "localhostProfile indicates a profile defined in a file on the node should be used. The profile must be preconfigured on the node to work. Must be a descending path, relative to the kubelet's configured seccomp profile location. Must be set if type is \"Localhost\". Must NOT be set for any other type.";
        type = types.str;
        default = null;
      };
      "type" = mkOption {
        description = "type indicates which kind of seccomp profile will be applied. Valid options are:\n\nLocalhost - a profile defined in a file on the node should be used. RuntimeDefault - the container runtime default profile should be used. Unconfined - no profile should be applied.";
        type = types.str;
      };
    };
  };
  DefaultPodOptionsSecurityContextSysctlModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "name" = mkOption {
        description = "Name of a property to set";
        type = types.str;
      };
      "value" = mkOption {
        description = "Value of a property to set";
        type = types.str;
      };
    };
  };
  DefaultPodOptionsTolerationModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "effect" = mkOption {
        description = "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute.";
        type = types.str;
        default = null;
      };
      "key" = mkOption {
        description = "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys.";
        type = types.str;
        default = null;
      };
      "operator" = mkOption {
        description = "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category.";
        type = types.str;
        default = null;
      };
      "tolerationSeconds" = mkOption {
        description = "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system.";
        type = types.int;
        default = null;
      };
      "value" = mkOption {
        description = "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string.";
        type = types.str;
        default = null;
      };
    };
  };
  DefaultPodOptionsTopologySpreadConstraintLabelSelectorMatchExpressionModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "key" = mkOption {
        description = "key is the label key that the selector applies to.";
        type = types.str;
      };
      "operator" = mkOption {
        description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
        type = types.str;
      };
      "values" = mkOption {
        description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  DefaultPodOptionsTopologySpreadConstraintLabelSelectorModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf DefaultPodOptionsTopologySpreadConstraintLabelSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  DefaultPodOptionsTopologySpreadConstraintModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "labelSelector" = mkOption {
        description = "LabelSelector is used to find matching pods. Pods that match this label selector are counted to determine the number of pods in their corresponding topology domain.";
        type = (types.nullOr DefaultPodOptionsTopologySpreadConstraintLabelSelectorModule);
        default = { };
      };
      "matchLabelKeys" = mkOption {
        description = "MatchLabelKeys is a set of pod label keys to select the pods over which spreading will be calculated. The keys are used to lookup values from the incoming pod labels, those key-value labels are ANDed with labelSelector to select the group of existing pods over which spreading will be calculated for the incoming pod. The same key is forbidden to exist in both MatchLabelKeys and LabelSelector. MatchLabelKeys cannot be set when LabelSelector isn't set. Keys that don't exist in the incoming pod labels will be ignored. A null or empty list means only match against labelSelector.\n\nThis is a beta field and requires the MatchLabelKeysInPodTopologySpread feature gate to be enabled (enabled by default).";
        type = (types.listOf types.str);
        default = [ ];
      };
      "maxSkew" = mkOption {
        description = "MaxSkew describes the degree to which pods may be unevenly distributed. When `whenUnsatisfiable=DoNotSchedule`, it is the maximum permitted difference between the number of matching pods in the target topology and the global minimum. The global minimum is the minimum number of matching pods in an eligible domain or zero if the number of eligible domains is less than MinDomains. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 2/2/1: In this case, the global minimum is 1. | zone1 | zone2 | zone3 | |  P P  |  P P  |   P   | - if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 2/2/2; scheduling it onto zone1(zone2) would make the ActualSkew(3-1) on zone1(zone2) violate MaxSkew(1). - if MaxSkew is 2, incoming pod can be scheduled onto any zone. When `whenUnsatisfiable=ScheduleAnyway`, it is used to give higher precedence to topologies that satisfy it. It's a required field. Default value is 1 and 0 is not allowed.";
        type = types.int;
      };
      "minDomains" = mkOption {
        description = "MinDomains indicates a minimum number of eligible domains. When the number of eligible domains with matching topology keys is less than minDomains, Pod Topology Spread treats \"global minimum\" as 0, and then the calculation of Skew is performed. And when the number of eligible domains with matching topology keys equals or greater than minDomains, this value has no effect on scheduling. As a result, when the number of eligible domains is less than minDomains, scheduler won't schedule more than maxSkew Pods to those domains. If value is nil, the constraint behaves as if MinDomains is equal to 1. Valid values are integers greater than 0. When value is not nil, WhenUnsatisfiable must be DoNotSchedule.\n\nFor example, in a 3-zone cluster, MaxSkew is set to 2, MinDomains is set to 5 and pods with the same labelSelector spread as 2/2/2: | zone1 | zone2 | zone3 | |  P P  |  P P  |  P P  | The number of domains is less than 5(MinDomains), so \"global minimum\" is treated as 0. In this situation, new pod with the same labelSelector cannot be scheduled, because computed skew will be 3(3 - 0) if new Pod is scheduled to any of the three zones, it will violate MaxSkew.\n\nThis is a beta field and requires the MinDomainsInPodTopologySpread feature gate to be enabled (enabled by default).";
        type = types.int;
        default = null;
      };
      "nodeAffinityPolicy" = mkOption {
        description = "NodeAffinityPolicy indicates how we will treat Pod's nodeAffinity/nodeSelector when calculating pod topology spread skew. Options are: - Honor: only nodes matching nodeAffinity/nodeSelector are included in the calculations. - Ignore: nodeAffinity/nodeSelector are ignored. All nodes are included in the calculations.\n\nIf this value is nil, the behavior is equivalent to the Honor policy. This is a beta-level feature default enabled by the NodeInclusionPolicyInPodTopologySpread feature flag.";
        type = types.str;
        default = null;
      };
      "nodeTaintsPolicy" = mkOption {
        description = "NodeTaintsPolicy indicates how we will treat node taints when calculating pod topology spread skew. Options are: - Honor: nodes without taints, along with tainted nodes for which the incoming pod has a toleration, are included. - Ignore: node taints are ignored. All nodes are included.\n\nIf this value is nil, the behavior is equivalent to the Ignore policy. This is a beta-level feature default enabled by the NodeInclusionPolicyInPodTopologySpread feature flag.";
        type = types.str;
        default = null;
      };
      "topologyKey" = mkOption {
        description = "TopologyKey is the key of node labels. Nodes that have a label with this key and identical values are considered to be in the same topology. We consider each <key, value> as a \"bucket\", and try to put balanced number of pods into each bucket. We define a domain as a particular instance of a topology. Also, we define an eligible domain as a domain whose nodes meet the requirements of nodeAffinityPolicy and nodeTaintsPolicy. e.g. If TopologyKey is \"kubernetes.io/hostname\", each Node is a domain of that topology. And, if TopologyKey is \"topology.kubernetes.io/zone\", each zone is a domain of that topology. It's a required field.";
        type = types.str;
      };
      "whenUnsatisfiable" = mkOption {
        description = "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint. - DoNotSchedule (default) tells the scheduler not to schedule it. - ScheduleAnyway tells the scheduler to schedule the pod in any location,\n  but giving higher precedence to topologies that would help reduce the\n  skew.\nA constraint is considered \"Unsatisfiable\" for an incoming pod if and only if every possible node assignment for that pod would violate \"MaxSkew\" on some topology. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 3/1/1: | zone1 | zone2 | zone3 | | P P P |   P   |   P   | If WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled to zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies MaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler won't make it *more* imbalanced. It's a required field.";
        type = types.str;
      };
    };
  };
  GlobalModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "alwaysAppendIdentifierToResourceName" = mkOption {
        description = "Always append identifier slugs to resource names, regardless of the enabled resource count.";
        type = types.bool;
        default = false;
      };
      "annotations" = mkOption {
        description = "Set additional global annotations. Helm templates can be used.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "fullnameOverride" = mkOption {
        description = "Set the chart fullname definition";
        type = (types.nullOr types.str);
        default = null;
      };
      "labels" = mkOption {
        description = "Set additional global labels. Helm templates can be used.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "nameOverride" = mkOption {
        description = "Set the chart name";
        type = (types.nullOr types.str);
        default = null;
      };
      "propagateGlobalMetadataToPods" = mkOption {
        description = "Set to true to propagate global metadata to Pod labels.";
        type = types.bool;
        default = false;
      };
    };
  };
  IngresDefaultBackendModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "resource" = mkOption {
        description = "resource is an ObjectRef to another Kubernetes resource in the namespace of the Ingress object. If resource is specified, a service.Name and service.Port must not be specified. This is a mutually exclusive setting with \"Service\".";
        type = (types.nullOr IngresDefaultBackendResourceModule);
        default = { };
      };
      "service" = mkOption {
        description = "service references a service as a backend. This is a mutually exclusive setting with \"Resource\".";
        type = (types.nullOr IngresDefaultBackendServiceModule);
        default = { };
      };
    };
  };
  IngresDefaultBackendResourceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "apiGroup" = mkOption {
        description = "APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required.";
        type = types.str;
        default = null;
      };
      "kind" = mkOption {
        description = "Kind is the type of resource being referenced";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name is the name of resource being referenced";
        type = types.str;
      };
    };
  };
  IngresDefaultBackendServiceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "name" = mkOption {
        description = "name is the referenced service. The service must exist in the same namespace as the Ingress object.";
        type = types.str;
      };
      "port" = mkOption {
        description = "port of the referenced service. A port name or port number is required for a IngressServiceBackend.";
        type = (types.nullOr IngresDefaultBackendServicePortModule);
        default = { };
      };
    };
  };
  IngresDefaultBackendServicePortModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "name" = mkOption {
        description = "name is the name of the port on the Service. This is a mutually exclusive setting with \"Number\".";
        type = types.str;
        default = null;
      };
      "number" = mkOption {
        description = "number is the numerical port number (e.g. 80) on the Service. This is a mutually exclusive setting with \"Name\".";
        type = types.int;
        default = null;
      };
    };
  };
  IngresModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "className" = mkOption {
        description = "Set the ingressClass used for this Ingress.";
        type = types.str;
        default = null;
      };
      "defaultBackend" = mkOption {
        description = "Set the defaultBackend for this Ingress. This disables any other rules.";
        type = (types.nullOr IngresDefaultBackendModule);
        default = { };
      };
      "enabled" = mkOption {
        description = "Set to false to disable the Ingress.";
        type = types.bool;
        default = true;
      };
      "forceRename" = mkOption {
        type = types.anything;
        default = null;
      };
      "hosts" = mkOption {
        description = "Configure the hosts for the Ingress.";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "labels" = mkOption {
        description = "Labels to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "prefix" = mkOption {
        type = types.anything;
        default = null;
      };
      "suffix" = mkOption {
        type = types.anything;
        default = null;
      };
      "tls" = mkOption {
        description = "Configure TLS for the Ingress.";
        type = (types.listOf types.anything);
        default = [ ];
      };
    };
  };
  NetworkpolicieModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "controller" = mkOption {
        description = "Controller this NetworkPolicy should target.";
        type = types.str;
        default = null;
      };
      "enabled" = mkOption {
        description = "Set to false to disable the NetworkPolicy.";
        type = types.bool;
        default = true;
      };
      "forceRename" = mkOption {
        type = types.anything;
        default = null;
      };
      "labels" = mkOption {
        description = "Labels to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "podSelector" = mkOption {
        description = "Custom podSelector for the NetworkPolicy. Takes precedence over targeting a controller.";
        type = types.anything;
        default = null;
      };
      "policyTypes" = mkOption {
        description = "Policy types for the NetworkPolicy.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "prefix" = mkOption {
        type = types.anything;
        default = null;
      };
      "rules" = mkOption {
        description = "Ingress and egress rules for the NetworkPolicy.";
        type = NetworkpolicieRulesModule;
      };
      "suffix" = mkOption {
        type = types.anything;
        default = null;
      };
    };
  };
  NetworkpolicieRulesEgresModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "ports" = mkOption {
        description = "ports is a list of destination ports for outgoing traffic. Each item in this list is combined using a logical OR. If this field is empty or missing, this rule matches all ports (traffic not restricted by port). If this field is present and contains at least one item, then this rule allows traffic only if the traffic matches at least one port in the list.";
        type = (types.listOf NetworkpolicieRulesEgresPortModule);
        default = [ ];
      };
      "to" = mkOption {
        description = "to is a list of destinations for outgoing traffic of pods selected for this rule. Items in this list are combined using a logical OR operation. If this field is empty or missing, this rule matches all destinations (traffic not restricted by destination). If this field is present and contains at least one item, this rule allows traffic only if the traffic matches at least one item in the to list.";
        type = (types.listOf NetworkpolicieRulesEgresToModule);
        default = [ ];
      };
    };
  };
  NetworkpolicieRulesEgresPortModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "endPort" = mkOption {
        description = "endPort indicates that the range of ports from port to endPort if set, inclusive, should be allowed by the policy. This field cannot be defined if the port field is not defined or if the port field is defined as a named (string) port. The endPort must be equal or greater than port.";
        type = types.int;
        default = null;
      };
      "port" = mkOption {
        description = "port represents the port on the given protocol. This can either be a numerical or named port on a pod. If this field is not provided, this matches all port names and numbers. If present, only traffic on the specified protocol AND port will be matched.";
        type = types.anything;
        default = null;
      };
      "protocol" = mkOption {
        description = "protocol represents the protocol (TCP, UDP, or SCTP) which traffic must match. If not specified, this field defaults to TCP.";
        type = types.str;
        default = null;
      };
    };
  };
  NetworkpolicieRulesEgresToIpBlockModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "cidr" = mkOption {
        description = "cidr is a string representing the IPBlock Valid examples are \"192.168.1.0/24\" or \"2001:db8::/64\"";
        type = types.str;
      };
      "except" = mkOption {
        description = "except is a slice of CIDRs that should not be included within an IPBlock Valid examples are \"192.168.1.0/24\" or \"2001:db8::/64\" Except values will be rejected if they are outside the cidr range";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  NetworkpolicieRulesEgresToModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "ipBlock" = mkOption {
        description = "ipBlock defines policy on a particular IPBlock. If this field is set then neither of the other fields can be.";
        type = (types.nullOr NetworkpolicieRulesEgresToIpBlockModule);
        default = { };
      };
      "namespaceSelector" = mkOption {
        description = "namespaceSelector selects namespaces using cluster-scoped labels. This field follows standard label selector semantics; if present but empty, it selects all namespaces.\n\nIf podSelector is also set, then the NetworkPolicyPeer as a whole selects the pods matching podSelector in the namespaces selected by namespaceSelector. Otherwise it selects all pods in the namespaces selected by namespaceSelector.";
        type = (types.nullOr NetworkpolicieRulesEgresToNamespaceSelectorModule);
        default = { };
      };
      "podSelector" = mkOption {
        description = "podSelector is a label selector which selects pods. This field follows standard label selector semantics; if present but empty, it selects all pods.\n\nIf namespaceSelector is also set, then the NetworkPolicyPeer as a whole selects the pods matching podSelector in the Namespaces selected by NamespaceSelector. Otherwise it selects the pods matching podSelector in the policy's own namespace.";
        type = (types.nullOr NetworkpolicieRulesEgresToPodSelectorModule);
        default = { };
      };
    };
  };
  NetworkpolicieRulesEgresToNamespaceSelectorMatchExpressionModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "key" = mkOption {
        description = "key is the label key that the selector applies to.";
        type = types.str;
      };
      "operator" = mkOption {
        description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
        type = types.str;
      };
      "values" = mkOption {
        description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  NetworkpolicieRulesEgresToNamespaceSelectorModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf NetworkpolicieRulesEgresToNamespaceSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  NetworkpolicieRulesEgresToPodSelectorMatchExpressionModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "key" = mkOption {
        description = "key is the label key that the selector applies to.";
        type = types.str;
      };
      "operator" = mkOption {
        description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
        type = types.str;
      };
      "values" = mkOption {
        description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  NetworkpolicieRulesEgresToPodSelectorModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf NetworkpolicieRulesEgresToPodSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  NetworkpolicieRulesIngresFromIpBlockModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "cidr" = mkOption {
        description = "cidr is a string representing the IPBlock Valid examples are \"192.168.1.0/24\" or \"2001:db8::/64\"";
        type = types.str;
      };
      "except" = mkOption {
        description = "except is a slice of CIDRs that should not be included within an IPBlock Valid examples are \"192.168.1.0/24\" or \"2001:db8::/64\" Except values will be rejected if they are outside the cidr range";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  NetworkpolicieRulesIngresFromModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "ipBlock" = mkOption {
        description = "ipBlock defines policy on a particular IPBlock. If this field is set then neither of the other fields can be.";
        type = (types.nullOr NetworkpolicieRulesIngresFromIpBlockModule);
        default = { };
      };
      "namespaceSelector" = mkOption {
        description = "namespaceSelector selects namespaces using cluster-scoped labels. This field follows standard label selector semantics; if present but empty, it selects all namespaces.\n\nIf podSelector is also set, then the NetworkPolicyPeer as a whole selects the pods matching podSelector in the namespaces selected by namespaceSelector. Otherwise it selects all pods in the namespaces selected by namespaceSelector.";
        type = (types.nullOr NetworkpolicieRulesIngresFromNamespaceSelectorModule);
        default = { };
      };
      "podSelector" = mkOption {
        description = "podSelector is a label selector which selects pods. This field follows standard label selector semantics; if present but empty, it selects all pods.\n\nIf namespaceSelector is also set, then the NetworkPolicyPeer as a whole selects the pods matching podSelector in the Namespaces selected by NamespaceSelector. Otherwise it selects the pods matching podSelector in the policy's own namespace.";
        type = (types.nullOr NetworkpolicieRulesIngresFromPodSelectorModule);
        default = { };
      };
    };
  };
  NetworkpolicieRulesIngresFromNamespaceSelectorMatchExpressionModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "key" = mkOption {
        description = "key is the label key that the selector applies to.";
        type = types.str;
      };
      "operator" = mkOption {
        description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
        type = types.str;
      };
      "values" = mkOption {
        description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  NetworkpolicieRulesIngresFromNamespaceSelectorModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf NetworkpolicieRulesIngresFromNamespaceSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  NetworkpolicieRulesIngresFromPodSelectorMatchExpressionModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "key" = mkOption {
        description = "key is the label key that the selector applies to.";
        type = types.str;
      };
      "operator" = mkOption {
        description = "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.";
        type = types.str;
      };
      "values" = mkOption {
        description = "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  NetworkpolicieRulesIngresFromPodSelectorModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf NetworkpolicieRulesIngresFromPodSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  NetworkpolicieRulesIngresModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "from" = mkOption {
        description = "from is a list of sources which should be able to access the pods selected for this rule. Items in this list are combined using a logical OR operation. If this field is empty or missing, this rule matches all sources (traffic not restricted by source). If this field is present and contains at least one item, this rule allows traffic only if the traffic matches at least one item in the from list.";
        type = (types.listOf NetworkpolicieRulesIngresFromModule);
        default = [ ];
      };
      "ports" = mkOption {
        description = "ports is a list of ports which should be made accessible on the pods selected for this rule. Each item in this list is combined using a logical OR. If this field is empty or missing, this rule matches all ports (traffic not restricted by port). If this field is present and contains at least one item, then this rule allows traffic only if the traffic matches at least one port in the list.";
        type = (types.listOf NetworkpolicieRulesIngresPortModule);
        default = [ ];
      };
    };
  };
  NetworkpolicieRulesIngresPortModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "endPort" = mkOption {
        description = "endPort indicates that the range of ports from port to endPort if set, inclusive, should be allowed by the policy. This field cannot be defined if the port field is not defined or if the port field is defined as a named (string) port. The endPort must be equal or greater than port.";
        type = types.int;
        default = null;
      };
      "port" = mkOption {
        description = "port represents the port on the given protocol. This can either be a numerical or named port on a pod. If this field is not provided, this matches all port names and numbers. If present, only traffic on the specified protocol AND port will be matched.";
        type = types.anything;
        default = null;
      };
      "protocol" = mkOption {
        description = "protocol represents the protocol (TCP, UDP, or SCTP) which traffic must match. If not specified, this field defaults to TCP.";
        type = types.str;
        default = null;
      };
    };
  };
  NetworkpolicieRulesModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "egress" = mkOption {
        type = (types.listOf NetworkpolicieRulesEgresModule);
        default = [ ];
      };
      "ingress" = mkOption {
        type = (types.listOf NetworkpolicieRulesIngresModule);
        default = [ ];
      };
    };
  };
  RawResourceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "apiVersion" = mkOption {
        description = "apiVersion of the resource.";
        type = types.str;
      };
      "enabled" = mkOption {
        description = "Set to false to disable the resource.";
        type = types.bool;
        default = true;
      };
      "forceRename" = mkOption {
        type = types.anything;
        default = null;
      };
      "kind" = mkOption {
        description = "Kind of the resource.";
        type = types.str;
      };
      "labels" = mkOption {
        description = "Labels to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "prefix" = mkOption {
        type = types.anything;
        default = null;
      };
      "spec" = mkOption {
        description = "Contents of the raw resource to be rendered.";
        type = types.anything;
      };
      "suffix" = mkOption {
        type = types.anything;
        default = null;
      };
    };
  };
  RbacBindingModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "enabled" = mkOption {
        description = "Set to false to disable the RoleBinding or ClusterRoleBinding.";
        type = types.bool;
        default = true;
      };
      "forceRename" = mkOption {
        type = types.anything;
        default = null;
      };
      "labels" = mkOption {
        description = "Labels to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "prefix" = mkOption {
        type = types.anything;
        default = null;
      };
      "roleRef" = mkOption {
        description = "Reference the Role or ClusterRole to bind to.";
        type = RbacBindingRoleRefModule;
      };
      "subjects" = mkOption {
        description = "Set the subjects for the RoleBinding or ClusterRoleBinding.";
        type = (types.listOf RbacBindingSubjectModule);
      };
      "suffix" = mkOption {
        type = types.anything;
        default = null;
      };
      "type" = mkOption {
        description = "Set the type of RBAC binding. Supported values: RoleBinding, ClusterRoleBinding.";
        type = (
          types.enum [
            "RoleBinding"
            "ClusterRoleBinding"
          ]
        );
      };
    };
  };
  RbacBindingRoleRefModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "identifier" = mkOption {
        description = "Reference an Role or ClusterRole configured in this chart by its key.";
        type = types.str;
        default = null;
      };
      "kind" = mkOption {
        description = "The kind of the referenced object. Supported values: Role, ClusterRole.";
        type = (
          types.enum [
            "Role"
            "ClusterRole"
          ]
        );
      };
      "name" = mkOption {
        description = "Reference a Role or ClusterRole by its name. Helm template enabled.";
        type = types.str;
        default = null;
      };
    };
  };
  RbacBindingSubjectModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "identifier" = mkOption {
        description = "Reference a serviceAccount configured in this chart by its key.";
        type = types.str;
        default = null;
      };
      "kind" = mkOption {
        description = "The kind of the referenced subject. Supported values: ServiceAccount, User, Group.";
        type = types.str;
        default = null;
      };
      "name" = mkOption {
        description = "Reference an subject by its name.";
        type = types.str;
        default = null;
      };
      "namespace" = mkOption {
        description = "The namespace of the referenced subject. Do not define if kind is User or Group.";
        type = types.str;
        default = null;
      };
    };
  };
  RbacModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "bindings" = mkOption {
        description = "(Cluster)RoleBinding objects to be generated by the chart";
        type = (types.attrsOf RbacBindingModule);
        default = { };
      };
      "roles" = mkOption {
        description = "(Cluster)Role objects to be generated by the chart";
        type = (types.attrsOf RbacRoleModule);
        default = { };
      };
    };
  };
  RbacRoleModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "enabled" = mkOption {
        description = "Set to false to disable the Role or ClusterRole.";
        type = types.bool;
        default = true;
      };
      "forceRename" = mkOption {
        type = types.anything;
        default = null;
      };
      "labels" = mkOption {
        description = "Labels to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "prefix" = mkOption {
        type = types.anything;
        default = null;
      };
      "rules" = mkOption {
        description = "Set the rules for the Role or ClusterRole.";
        type = (types.listOf types.anything);
      };
      "suffix" = mkOption {
        type = types.anything;
        default = null;
      };
      "type" = mkOption {
        description = "Set the type of RBAC resource. Supported values: Role, ClusterRole.";
        type = (
          types.enum [
            "Role"
            "ClusterRole"
          ]
        );
      };
    };
  };
  RouteModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "enabled" = mkOption {
        description = "Set to false to disable the Route.";
        type = types.bool;
        default = true;
      };
      "forceRename" = mkOption {
        type = types.anything;
        default = null;
      };
      "hostnames" = mkOption {
        description = "Host addresses for the Route. Helm templates are supported.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "kind" = mkOption {
        description = "Route kind. Supported values: GRPCRoute, HTTPRoute, TCPRoute, TLSRoute, UDPRoute.";
        type = (
          types.enum [
            "GRPCRoute"
            "HTTPRoute"
            "TCPRoute"
            "TLSRoute"
            "UDPRoute"
          ]
        );
      };
      "labels" = mkOption {
        description = "Labels to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "parentRefs" = mkOption {
        description = "Resource the Route attaches to.";
        type = (types.listOf RouteParentRefModule);
        default = [ ];
      };
      "prefix" = mkOption {
        type = types.anything;
        default = null;
      };
      "rules" = mkOption {
        description = "Rules for routing. Defaults to the primary service.";
        type = (types.listOf RouteRuleModule);
        default = [ ];
      };
      "suffix" = mkOption {
        type = types.anything;
        default = null;
      };
    };
  };
  RouteParentRefModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "group" = mkOption {
        type = types.str;
        default = null;
      };
      "kind" = mkOption {
        type = types.str;
        default = null;
      };
      "name" = mkOption {
        type = types.str;
      };
      "namespace" = mkOption {
        type = types.str;
        default = null;
      };
      "port" = mkOption {
        type = types.int;
        default = null;
      };
      "sectionName" = mkOption {
        type = types.str;
        default = null;
      };
    };
  };
  RouteRuleBackendRefModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "group" = mkOption {
        type = types.str;
        default = null;
      };
      "identifier" = mkOption {
        description = "Reference to a service identifier defined within the chart values.";
        type = types.str;
        default = null;
      };
      "kind" = mkOption {
        type = types.str;
        default = null;
      };
      "name" = mkOption {
        description = "Reference to a backend Service name.";
        type = types.str;
        default = null;
      };
      "namespace" = mkOption {
        type = types.str;
        default = null;
      };
      "port" = mkOption {
        type = types.anything;
        default = null;
      };
      "weight" = mkOption {
        type = types.int;
        default = null;
      };
    };
  };
  RouteRuleModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "backendRefs" = mkOption {
        description = "Backend references.";
        type = (types.listOf RouteRuleBackendRefModule);
        default = [ ];
      };
      "filters" = mkOption {
        description = "Filters define processing steps that must be completed during the\nrequest or response lifecycle.";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "matches" = mkOption {
        description = "Matches define conditions used for matching the rule against incoming requests. Each match is independent, i.e. this rule will be matched\nif **any** one of the matches is satisfied.";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "name" = mkOption {
        description = "Optional name of the route rule. This name must be unique within a Route if it is set.";
        type = types.str;
        default = null;
      };
      "sessionPersistence" = mkOption {
        description = "SessionPersistence defines the desired state of SessionPersistence.";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "timeouts" = mkOption {
        description = "Timeouts for the route.";
        type = (types.attrsOf types.anything);
        default = { };
      };
    };
  };
  SecretModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "enabled" = mkOption {
        description = "Set to false to disable the Secret.";
        type = types.bool;
        default = true;
      };
      "forceRename" = mkOption {
        type = types.anything;
        default = null;
      };
      "includeChecksumInControllers" = mkOption {
        description = "Specify a list of controller identifiers for which to include this Secret in the checksum calculation for rolling updates.";
        type = (types.listOf types.anything);
        default = [ ];
      };
      "includeInChecksum" = mkOption {
        description = "Set to true to include this Secret in the checksum calculation for rolling updates.";
        type = types.bool;
        default = true;
      };
      "labels" = mkOption {
        description = "Labels to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "prefix" = mkOption {
        type = types.anything;
        default = null;
      };
      "stringData" = mkOption {
        description = "Secret stringData content. Helm templates are supported.";
        type = (types.attrsOf types.str);
      };
      "suffix" = mkOption {
        type = types.anything;
        default = null;
      };
      "type" = mkOption {
        description = "Secret type.";
        type = types.str;
        default = null;
      };
    };
  };
  SecretsFromFolderModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "basePath" = mkOption {
        description = "Base path containing secret subfolders";
        type = types.str;
        default = null;
      };
      "enabled" = mkOption {
        type = types.bool;
        default = false;
      };
      "overrides" = mkOption {
        type = (types.attrsOf SecretsFromFolderOverrideModule);
        default = { };
      };
    };
  };
  SecretsFromFolderOverrideFileAttributeOverrideModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "binary" = mkOption {
        type = types.bool;
        default = false;
      };
      "escaped" = mkOption {
        type = types.bool;
        default = false;
      };
      "exclude" = mkOption {
        type = types.bool;
        default = false;
      };
      "isEnvFile" = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  SecretsFromFolderOverrideModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "fileAttributeOverrides" = mkOption {
        type = (types.attrsOf SecretsFromFolderOverrideFileAttributeOverrideModule);
        default = { };
      };
      "forceRename" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "labels" = mkOption {
        description = "Labels to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
    };
  };
  ServiceAccountModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "enabled" = mkOption {
        description = "Set to false to disable the ServiceAccount.";
        type = types.bool;
        default = true;
      };
      "forceRename" = mkOption {
        type = types.anything;
        default = null;
      };
      "labels" = mkOption {
        description = "Labels to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "prefix" = mkOption {
        type = types.anything;
        default = null;
      };
      "staticToken" = mkOption {
        description = "Set to true to create a long-lived static token for the ServiceAccount.";
        type = types.bool;
        default = false;
      };
      "suffix" = mkOption {
        type = types.anything;
        default = null;
      };
    };
  };
  ServiceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "allocateLoadBalancerNodePorts" = mkOption {
        type = types.bool;
        default = false;
      };
      "annotations" = mkOption {
        description = "Annotations to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "clusterIP" = mkOption {
        type = types.str;
        default = null;
      };
      "controller" = mkOption {
        description = "Controller this Service should target.";
        type = types.str;
        default = null;
      };
      "enabled" = mkOption {
        description = "Set to false to disable the Service.";
        type = types.bool;
        default = true;
      };
      "externalIPs" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "externalName" = mkOption {
        type = types.str;
        default = null;
      };
      "externalTrafficPolicy" = mkOption {
        description = "externalTrafficPolicy for the Service. Supported values: Cluster, Local.\nSee https://kubernetes.io/docs/tutorials/services/source-ip/";
        type = (
          types.enum [
            "Cluster"
            "Local"
          ]
        );
      };
      "extraSelectorLabels" = mkOption {
        description = "Additional match labels for the Service selector.";
        type = types.anything;
        default = null;
      };
      "forceRename" = mkOption {
        type = types.anything;
        default = null;
      };
      "internalTrafficPolicy" = mkOption {
        description = "internalTrafficPolicy for the Service. Supported values: Cluster, Local.\nSee https://kubernetes.io/docs/concepts/services-networking/service-traffic-policy/";
        type = (
          types.enum [
            "Cluster"
            "Local"
          ]
        );
      };
      "ipFamilies" = mkOption {
        description = "IP families for the Service. Supported values: IPv4, IPv6.";
        type = (
          types.listOf (
            types.enum [
              "IPv4"
              "IPv6"
            ]
          )
        );
        default = [ ];
      };
      "ipFamilyPolicy" = mkOption {
        description = "ipFamilyPolicy for the Service. Supported values: SingleStack, PreferDualStack, RequireDualStack.";
        type = (
          types.enum [
            "SingleStack"
            "PreferDualStack"
            "RequireDualStack"
          ]
        );
      };
      "labels" = mkOption {
        description = "Labels to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "loadBalancerClass" = mkOption {
        type = types.str;
        default = null;
      };
      "loadBalancerIP" = mkOption {
        type = types.str;
        default = null;
      };
      "loadBalancerSourceRanges" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
      "ports" = mkOption {
        description = "Service port(s) configuration.";
        type = (types.attrsOf ServicePortModule);
        default = { };
      };
      "prefix" = mkOption {
        type = types.anything;
        default = null;
      };
      "primary" = mkOption {
        description = "Set to true to make this the primary Service for the controller (used in probes, notes, etc). Only one Service can be marked as primary.";
        type = types.bool;
        default = false;
      };
      "publishNotReadyAddresses" = mkOption {
        type = types.bool;
        default = false;
      };
      "sessionAffinity" = mkOption {
        type = (
          types.enum [
            "None"
            "ClientIP"
          ]
        );
      };
      "sessionAffinityConfig" = mkOption {
        type = (types.attrsOf types.anything);
        default = { };
      };
      "suffix" = mkOption {
        type = types.anything;
        default = null;
      };
      "trafficDistribution" = mkOption {
        description = "trafficDistribution for the Service. Supported values: PreferClose, PreferSameZone, PreferSameNode.";
        type = (
          types.enum [
            "PreferClose"
            "PreferSameZone"
            "PreferSameNode"
          ]
        );
      };
      "type" = mkOption {
        description = "Service type. Supported values: ClusterIP, NodePort, LoadBalancer, ExternalName.";
        type = (
          types.enum [
            "ClusterIP"
            "NodePort"
            "LoadBalancer"
            "ExternalName"
          ]
        );
      };
    };
  };
  ServiceMonitorModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "annotations" = mkOption {
        description = "Annotations to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "enabled" = mkOption {
        description = "Set to false to disable the ServiceMonitor.";
        type = types.bool;
        default = true;
      };
      "endpoints" = mkOption {
        description = "Endpoints allowed as part of this ServiceMonitor.";
        type = (types.listOf (types.attrsOf types.anything));
        default = [ ];
      };
      "forceRename" = mkOption {
        type = types.anything;
        default = null;
      };
      "jobLabel" = mkOption {
        description = "The label to use to retrieve the job name from the target service's metadata. Defaults to the ServiceMonitor's 'metadata.name'. Helm templates can be used.";
        type = types.str;
        default = null;
      };
      "labels" = mkOption {
        description = "Labels to set on the item.";
        type = (types.attrsOf (types.nullOr types.str));
        default = { };
      };
      "prefix" = mkOption {
        type = types.anything;
        default = null;
      };
      "selector" = mkOption {
        description = "Selector to select Endpoints objects.";
        type = (types.nullOr ServiceMonitorSelectorModule);
        default = { };
      };
      "service" = mkOption {
        description = "Service to monitor. Either 'serviceName' or 'service' must be specified.";
        type = types.anything;
        default = { };
      };
      "serviceName" = mkOption {
        description = "Reference to a Service name to monitor. Helm templates are supported. Deprecated in favor of 'service'.";
        type = types.str;
        default = null;
      };
      "suffix" = mkOption {
        type = types.anything;
        default = null;
      };
      "targetLabels" = mkOption {
        description = "Transfers labels from the Kubernetes Service onto the created metrics.";
        type = (types.listOf types.anything);
        default = [ ];
      };
    };
  };
  ServiceMonitorSelectorMatchExpressionModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "key" = mkOption {
        type = types.str;
        default = null;
      };
      "operator" = mkOption {
        type = types.str;
        default = null;
      };
      "values" = mkOption {
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  ServiceMonitorSelectorModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "matchExpressions" = mkOption {
        description = "matchExpressions is a list of label selector requirements. The requirements are ANDed.";
        type = (types.listOf ServiceMonitorSelectorMatchExpressionModule);
        default = [ ];
      };
      "matchLabels" = mkOption {
        description = "matchLabels is a map of {key,value} pairs. The requirements are ANDed.";
        type = (types.attrsOf types.str);
        default = { };
      };
    };
  };
  ServicePortModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "appProtocol" = mkOption {
        description = "appProtocol value for the port.\nSee https://kubernetes.io/docs/concepts/services-networking/service/#application-protocol";
        type = types.str;
        default = null;
      };
      "enabled" = mkOption {
        description = "Set to false to disable the port.";
        type = types.bool;
        default = true;
      };
      "nodePort" = mkOption {
        description = "nodePort value for LoadBalancer and NodePort Service types.\nSee https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport";
        type = types.anything;
        default = null;
      };
      "port" = mkOption {
        description = "Port name / number.";
        type = types.anything;
        default = null;
      };
      "portRange" = mkOption {
        description = "A range of ports to include in the Service.";
        type = (types.nullOr ServicePortPortRangeModule);
        default = { };
      };
      "primary" = mkOption {
        description = "Set to true to make this the primary port (used in probes, notes, etc).\nOnly one port can be marked as primary.";
        type = types.bool;
        default = false;
      };
      "protocol" = mkOption {
        description = "Port protocol. Supported values: HTTP, HTTPS, TCP, UDP.\nHTTP and HTTPS spawn a TCP service and are used for internal URL and name generation.";
        type = (
          types.enum [
            "HTTP"
            "HTTPS"
            "TCP"
            "UDP"
          ]
        );
      };
      "targetPort" = mkOption {
        description = "Set the targetPort if you want the Service port to differ from the application port. If set, this value is used in the container definition instead of 'port'.\nNamed ports are not supported for this field.";
        type = types.anything;
        default = null;
      };
    };
  };
  ServicePortPortRangeModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "end" = mkOption {
        description = "End of the port range (inclusive).";
        type = types.int;
      };
      "start" = mkOption {
        description = "Start of the port range.";
        type = types.int;
      };
    };
  };
in
{
  valuesType = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "configMaps" = mkOption {
        description = "Kubernetes ConfigMaps to be generated by the chart";
        type = (types.attrsOf ConfigMapModule);
        default = { };
      };
      "configMapsFromFolder" = mkOption {
        description = "Generate ConfigMaps from files in the chart filesystem";
        type = (types.nullOr ConfigMapsFromFolderModule);
        default = { };
      };
      "controllers" = mkOption {
        description = "Define the Pod controllers to be generated by the chart";
        type = (types.attrsOf ControllerModule);
        default = { };
      };
      "defaultPodOptions" = mkOption {
        description = "Set default options for all controllers / pods here. Each of these options can be overridden on a controller level.";
        type = (types.nullOr DefaultPodOptionsModule);
        default = { };
      };
      "defaultPodOptionsStrategy" = mkOption {
        description = "Set the strategy for the default pod options. Defaults to overwrite.\noverwrite: If pod-level options are set, use those instead of the defaults.\nmerge: If pod-level options are set, merge them with the defaults.";
        type = (
          types.enum [
            "overwrite"
            "merge"
          ]
        );
        default = "overwrite";
      };
      "global" = mkOption {
        description = "Allows for configuring chart-wide settings";
        type = (types.nullOr GlobalModule);
        default = { };
      };
      "ingress" = mkOption {
        description = "Kubernetes Ingress objects to be generated by the chart";
        type = (types.attrsOf IngresModule);
        default = { };
      };
      "networkpolicies" = mkOption {
        description = "networkPolicy objects to be generated by the chart";
        type = (types.attrsOf NetworkpolicieModule);
        default = { };
      };
      "persistence" = mkOption {
        description = "Options to configure persistent storage and mount options";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "rawResources" = mkOption {
        description = "Allows for the inclusion of raw Kubernetes resources that are not supported by the chart otherwise​";
        type = (types.attrsOf RawResourceModule);
        default = { };
      };
      "rbac" = mkOption {
        description = "Configure the Roles and Role Bindings for the chart here";
        type = (types.nullOr RbacModule);
        default = { };
      };
      "route" = mkOption {
        description = "Kubernetes Gateway API *Route objects to be generated by the chart";
        type = (types.attrsOf RouteModule);
        default = { };
      };
      "secrets" = mkOption {
        description = "Kubernetes Secrets to be generated by the chart";
        type = (types.attrsOf SecretModule);
        default = { };
      };
      "secretsFromFolder" = mkOption {
        description = "Generate Secrets from files in the chart filesystem";
        type = (types.nullOr SecretsFromFolderModule);
        default = { };
      };
      "service" = mkOption {
        description = "Kubernetes Service objects to be generated by the chart";
        type = (types.attrsOf ServiceModule);
        default = { };
      };
      "serviceAccount" = mkOption {
        description = "Kubernetes serviceAccount objects to be generated by the chart";
        type = (types.attrsOf ServiceAccountModule);
        default = { };
      };
      "serviceMonitor" = mkOption {
        description = "serviceMonitor objects to be generated by the chart";
        type = (types.attrsOf ServiceMonitorModule);
        default = { };
      };
    };
  };
}
