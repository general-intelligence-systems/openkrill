# Auto-generated openkrill module fragment for cloudnative-pg
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."cloudnative-pg";
  compact = filterAttrs (_: v: v != null);
  ImageModule = types.submodule {
    options = {
      "image" = mkOption {
        description = "The image reference";
        type = types.str;
      };
      "major" = mkOption {
        description = "The PostgreSQL major version of the image. Must be unique within the catalog.";
        type = types.int;
      };
    };
  };
  mkImage = res: {
    inherit (res) "image";
    inherit (res) "major";
  };
  ClusterimagecatalogsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this ClusterImageCatalog resource.";
        };
        "images" = mkOption {
          description = "List of CatalogImages available in the catalog";
          type = (types.listOf ImageModule);
        };
      };
    }
  );
  mkClusterImageCatalog = name: res: {
    apiVersion = "postgresql.cnpg.io/v1";
    kind = "ClusterImageCatalog";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
      "images" = map mkImage res."images";
    };
  };
  allResources = (mapAttrsToList mkClusterImageCatalog cfg."clusterimagecatalogs");
in
{
  options.openkrill.apps."cloudnative-pg" = {
    "clusterimagecatalogs" = mkOption {
      type = types.attrsOf ClusterimagecatalogsModule;
      default = { };
      description = "ClusterImageCatalog CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."cloudnative-pg".content = allResources;
  };
}
