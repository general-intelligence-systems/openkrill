# modules/lib/helpers.nix
#
# Shared option types and helpers for openkrill app modules.
#
# mkExtraManifestsOption: creates the extraManifests option for a module.
# mkExtraManifestsConfig: fans extraManifests into openkrill.manifests
#   with a prefix to avoid name collisions.

{ lib }:
with lib;
rec {
  # The content type shared by openkrill.manifests and extraManifests
  manifestContentType = with types; either attrs (listOf attrs);

  # Produces the `extraManifests` option to embed in any app module
  mkExtraManifestsOption = mkOption {
    type = types.attrsOf manifestContentType;
    default = { };
    description = ''
      Extra Kubernetes manifests to deploy alongside this app.
      Each key becomes a manifest name prefixed with the app name.
      Values are either a single resource attrset or a list of
      resource attrsets (rendered as a Kubernetes List).
    '';
  };

  # Takes a prefix and the extraManifests attrset, returns config
  # to merge into openkrill.manifests
  mkExtraManifestsConfig = prefix: extraManifests:
    mapAttrs' (name: content: {
      name = "${prefix}/${name}";
      value = { inherit content; };
    }) extraManifests;
}
