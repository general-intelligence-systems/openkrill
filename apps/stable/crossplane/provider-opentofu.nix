{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps.crossplane.provider-opentofu;
in
{
  options.openkrill.apps.crossplane.provider-opentofu = {
    enable = mkEnableOption "provider-opentofu";
    package = mkOption {
      type = types.str;
      default = "xpkg.upbound.io/upbound/provider-opentofu:v1.1.1";
    };
  };

  config = mkIf cfg.enable {
    openkrill.apps.crossplane.providers.provider-opentofu = {
      inherit (cfg) package;
    };
  };
}
