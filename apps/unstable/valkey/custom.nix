# Custom overrides for this module.
# This file is never overwritten by the generator.
{ lib, config, ... }:
let
  cfg = config.openkrill.apps.valkey;
in
{
  config = lib.mkIf cfg.enable {
    openkrill.apps.valkey.values = {
      architecture = lib.mkDefault "standalone";
      auth.enabled = lib.mkDefault false;
      primary.kind = lib.mkDefault "Deployment";
      primary.persistence.enabled = lib.mkDefault false;
      replica.replicaCount = lib.mkDefault 0;
    };
  };
}
