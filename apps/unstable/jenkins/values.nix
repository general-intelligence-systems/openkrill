# Auto-generated from Bitnami values.schema.json
# Do not edit — regenerate with bin/create-module-bitnami
{ lib, ... }:
with lib;
let
  IngressModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable the ingress resource that allows you to access the Jenkins installation.";
        type = types.bool;
        default = false;
      };
      "hostname" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  PersistenceModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "enabled" = mkOption {
        description = "Enable persistence using Persistent Volume Claims";
        type = types.bool;
        default = false;
      };
      "size" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  ResourcesModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "requests" = mkOption {
        type = ResourcesRequestsModule;
        default = { };
      };
    };
  };
  ResourcesRequestsModule = types.submodule {
    freeformType = types.attrsOf types.anything;
    options = {
      "cpu" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "memory" = mkOption {
        type = (types.nullOr types.str);
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
    "ingress" = mkOption {
      type = IngressModule;
      default = { };
    };
    "jenkinsPassword" = mkOption {
      description = "Defaults to a random 10-character alphanumeric string if not set";
      type = (types.nullOr types.str);
      default = null;
    };
    "jenkinsUser" = mkOption {
      type = (types.nullOr types.str);
      default = null;
    };
    "persistence" = mkOption {
      type = PersistenceModule;
      default = { };
    };
    "resources" = mkOption {
      type = ResourcesModule;
      default = { };
    };
    "service" = mkOption {
      type = ServiceModule;
      default = { };
    };
    "serviceAccountName" = mkOption {
      description = "Defaults to use default if not set";
      type = (types.nullOr types.str);
      default = null;
    };
  };
}
