# modules/api-docs.nix
#
# Declarative API documentation ConfigMaps.
#
# App modules declare `openkrill."api-docs".<name>.content = readFile ./API_DOCS.md;`
# and this module creates a ConfigMap per entry in the `api-docs` namespace.
#
# Each ConfigMap is named `<name>-api-docs` with a single data key
# `<name>-api-docs.md` containing the markdown content.
#
# The api-docs Namespace is auto-created when any entries exist.
#
# Usage in an app module:
#
#   openkrill."api-docs".my-app.content = builtins.readFile ./API_DOCS.md;

{ config, lib, k8s, ... }:
with lib;
let
  cfg = config.openkrill."api-docs";

  ns = "api-docs";

  mkConfigMap = name: entry: {
    apiVersion = "v1";
    kind = "ConfigMap";
    metadata = {
      name = "${name}-api-docs";
      namespace = ns;
    };
    data."${name}-api-docs.md" = entry.content;
  };

in
{
  options.openkrill."api-docs" = mkOption {
    type = types.attrsOf (types.submodule {
      options.content = mkOption {
        type = types.str;
        description = ''
          API documentation content (typically markdown).
          Example: builtins.readFile ./API_DOCS.md
        '';
      };
    });
    default = {};
    description = ''
      Per-app API documentation. Each entry creates a ConfigMap
      named <name>-api-docs in the api-docs namespace, with the
      content stored under the <name>-api-docs.md data key.
    '';
  };

  config = mkIf (cfg != {}) {
    openkrill.manifests."api-docs".content =
      [ (k8s.mkNamespace ns) ]
      ++ mapAttrsToList mkConfigMap cfg;
  };
}
