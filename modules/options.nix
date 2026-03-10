# Shared option declarations for openkrill app modules.
#
# Cross-cutting options that multiple app modules read from.
# The manifest option type and output pipeline live in manifests.nix.
{ config, lib, ... }:
{
  options.openkrill = {
    domain = lib.mkOption {
      type = lib.types.str;
      default = "cluster.local";
      description = "Base domain for cluster services (e.g. mycompany.com).";
    };


  };
}
