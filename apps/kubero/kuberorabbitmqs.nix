# Auto-generated openkrill module fragment for kubero
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."kubero";
  compact = filterAttrs (_: v: v != null);
  KuberorabbitmqsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this KuberoRabbitMQ resource.";
        };
        "spec" = mkOption {
          type = types.attrsOf types.anything;
          default = { };
          description = "Spec defines the desired state of this resource. Freeform: the CRD uses x-kubernetes-preserve-unknown-fields.";
        };
      };
    }
  );
  mkKuberoRabbitMQ = name: res: {
    apiVersion = "application.kubero.dev/v1alpha1";
    kind = "KuberoRabbitMQ";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = res.spec;
  };
  allResources = (mapAttrsToList mkKuberoRabbitMQ cfg."kuberorabbitmqs");
in
{
  options.openkrill.apps."kubero" = {
    "kuberorabbitmqs" = mkOption {
      type = types.attrsOf KuberorabbitmqsModule;
      default = { };
      description = "KuberoRabbitMQ CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."kubero".content = allResources;
  };
}
