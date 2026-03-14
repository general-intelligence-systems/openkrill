# Auto-generated from Bitnami values.schema.json
# Do not edit — regenerate with bin/create-module-bitnami
{ lib, ... }:
with lib;
let
  IngressModule = types.submodule {
  freeformType = types.attrsOf types.anything;
  options = {
    "enabled" = mkOption {
  description = "Enable the ingress resource that allows you to access the Apache installation.";
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
  type = types.bool;
  default = false;
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
  default = {  };
};
"metrics" = mkOption {
  type = MetricsModule;
  default = {  };
};
"replicaCount" = mkOption {
  type = (types.nullOr types.int);
  default = null;
};
"service" = mkOption {
  type = ServiceModule;
  default = {  };
};
  };
}
