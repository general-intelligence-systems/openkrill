# modules/custom.nix
#
# Ad-hoc app bundles. Group related manifests under a name
# with an enable flag — without writing a NixOS module.
#
# openkrill.apps.custom.my-app = {
#   enable = true;
#   manifests = {
#     deployment = { apiVersion = "apps/v1"; ... };
#     service = { apiVersion = "v1"; ... };
#   };
# };
#
# Each key in `manifests` becomes openkrill.manifests."my-app/deployment"
# etc. Disabling the app disables all its manifests at once.

{ config, lib, ... }:
with lib;
let
  helpers = import ./lib/helpers.nix { inherit lib; };

  customAppOpts = { name, config, ... }: {
    options = {
      enable = mkOption {
        type = types.bool;
        default = true;
      };

      manifests = mkOption {
        type = types.attrsOf helpers.manifestContentType;
        default = { };
        description = ''
          Kubernetes manifests for this app. Each key becomes a
          manifest name prefixed with the app name.
        '';
      };
    };
  };

  cfg = config.openkrill.apps.custom;

  enabledApps = filterAttrs (_: app: app.enable) cfg;
in
{
  options.openkrill.apps.custom = mkOption {
    type = types.attrsOf (types.submodule customAppOpts);
    default = { };
    description = ''
      Ad-hoc application bundles. Group related manifests under
      a name with an enable flag without writing a NixOS module.
    '';
  };

  config.openkrill.manifests = mkMerge (
    mapAttrsToList (appName: app:
      helpers.mkExtraManifestsConfig appName app.manifests
    ) enabledApps
  );
}
