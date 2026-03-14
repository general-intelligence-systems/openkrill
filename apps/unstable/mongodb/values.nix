# Auto-generated from Bitnami values.schema.json
# Do not edit — regenerate with bin/create-module-bitnami
{ lib, ... }:
with lib;
let
  ArbiterModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "configuration" = mkOption {
  type = (types.nullOr types.str);
  default = null;
};
  };
};
AuthModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "database" = mkOption {
  description = "Name of the custom database to be created during the 1st initialization of MongoDB&reg;";
  type = (types.nullOr types.str);
  default = null;
};
"enabled" = mkOption {
  type = types.bool;
  default = false;
};
"password" = mkOption {
  description = "Defaults to a random 10-character alphanumeric string if not set";
  type = (types.nullOr types.str);
  default = null;
};
"replicaSetKey" = mkOption {
  description = "Defaults to a random 10-character alphanumeric string if not set";
  type = (types.nullOr types.str);
  default = null;
};
"rootPassword" = mkOption {
  description = "Defaults to a random 10-character alphanumeric string if not set";
  type = (types.nullOr types.str);
  default = null;
};
"rootUser" = mkOption {
  description = "Name of the admin user. Default is root";
  type = (types.nullOr types.str);
  default = null;
};
"username" = mkOption {
  description = "Name of the custom user to be created during the 1st initialization of MongoDB&reg;. This user only has permissions on the MongoDB&reg; custom database";
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
  default = {  };
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
NetworkPolicyEgressModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "customRules" = mkOption {
  type = (types.listOf types.anything);
  default = [  ];
};
  };
};
NetworkPolicyIngressModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "customRules" = mkOption {
  type = (types.listOf types.anything);
  default = [  ];
};
"namespaceSelector" = mkOption {
  type = (types.attrsOf types.anything);
  default = {  };
};
"podSelector" = mkOption {
  type = (types.attrsOf types.anything);
  default = {  };
};
  };
};
NetworkPolicyModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "egress" = mkOption {
  type = NetworkPolicyEgressModule;
  default = {  };
};
"enabled" = mkOption {
  description = "Enable network policy using Kubernetes native NP";
  type = types.bool;
  default = false;
};
"ingress" = mkOption {
  type = NetworkPolicyIngressModule;
  default = {  };
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
VolumePermissionsModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Use an init container to set required folder permissions on the data volume before mounting it in the final destination";
  type = types.bool;
  default = false;
};
  };
};
in
{
  freeformType = types.attrsOf types.anything;
  options = {
    "arbiter" = mkOption {
  type = ArbiterModule;
  default = {  };
};
"architecture" = mkOption {
  description = "Allowed values: `standalone` or `replicaset`";
  type = (types.nullOr types.str);
  default = null;
};
"auth" = mkOption {
  type = AuthModule;
  default = {  };
};
"configuration" = mkOption {
  type = (types.nullOr types.str);
  default = null;
};
"metrics" = mkOption {
  type = MetricsModule;
  default = {  };
};
"networkPolicy" = mkOption {
  type = NetworkPolicyModule;
  default = {  };
};
"persistence" = mkOption {
  type = PersistenceModule;
  default = {  };
};
"replicaCount" = mkOption {
  type = (types.nullOr types.int);
  default = null;
};
"volumePermissions" = mkOption {
  type = VolumePermissionsModule;
  default = {  };
};
  };
}
