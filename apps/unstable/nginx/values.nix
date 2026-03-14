# Auto-generated from Bitnami values.schema.json
# Do not edit — regenerate with bin/create-module-bitnami
{ lib, ... }:
with lib;
let
  ContainerSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Whether to enable NGINX containers' Security Context";
        type = types.bool;
        default = false;
      };
      "runAsUser" = mkOption {
        description = "The UID of the user NGINX containers will run as";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  ContextIncludesModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "events" = mkOption {
        description = "Custom configuration for the events context";
        type = (types.nullOr types.str);
        default = null;
      };
      "http" = mkOption {
        description = "Custom configuration for the http context";
        type = (types.nullOr types.str);
        default = null;
      };
      "main" = mkOption {
        description = "Custom configuration for the main context";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  IngressModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable the ingress resource that allows you to access the NGINX installation.";
        type = types.bool;
        default = false;
      };
      "hostname" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  MetricsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Create a side-car container to expose Prometheus metrics";
        type = types.bool;
        default = false;
      };
      "serviceMonitor" = mkOption {
        type = MetricsServiceMonitorModule;
        default = { };
      };
    };
  };
  MetricsServiceMonitorModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Create a ServiceMonitor to track metrics using Prometheus Operator";
        type = types.bool;
        default = false;
      };
    };
  };
  PodSecurityContextModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Whether to enable NGINX pods' Security Context";
        type = types.bool;
        default = false;
      };
      "fsGroup" = mkOption {
        description = "The GID of the group NGINX pods will run as";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  ServiceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "type" = mkOption {
        description = "Allowed values: \"ClusterIP\", \"NodePort\" and \"LoadBalancer\"";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
in
{
  freeformType = types.attrsOf types.anything;
  options = {
    "containerSecurityContext" = mkOption {
      type = ContainerSecurityContextModule;
      default = { };
    };
    "contextIncludes" = mkOption {
      type = ContextIncludesModule;
      default = { };
    };
    "existingContextEventsConfigmaps" = mkOption {
      description = "List of existing ConfigMaps with custom events context configuration";
      type = (types.listOf types.str);
      default = [ ];
    };
    "existingContextHttpConfigmaps" = mkOption {
      description = "List of existing ConfigMaps with custom http context configuration";
      type = (types.listOf types.str);
      default = [ ];
    };
    "existingContextMainConfigmaps" = mkOption {
      description = "List of existing ConfigMaps with custom main context configuration";
      type = (types.listOf types.str);
      default = [ ];
    };
    "ingress" = mkOption {
      type = IngressModule;
      default = { };
    };
    "metrics" = mkOption {
      type = MetricsModule;
      default = { };
    };
    "podSecurityContext" = mkOption {
      type = PodSecurityContextModule;
      default = { };
    };
    "replicaCount" = mkOption {
      description = "Number of replicas to deploy";
      type = (types.nullOr types.int);
      default = null;
    };
    "serverBlock" = mkOption {
      description = "Custom server block to be added to NGINX configuration";
      type = (types.nullOr types.str);
      default = null;
    };
    "service" = mkOption {
      type = ServiceModule;
      default = { };
    };
    "streamServerBlock" = mkOption {
      description = "Custom stream server block to be added to NGINX configuration";
      type = (types.nullOr types.str);
      default = null;
    };
  };
}
