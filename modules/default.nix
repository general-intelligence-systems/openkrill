# OpenKrill module framework.
#
# Entry point that loads the k3s service module, shared options,
# manifest pipeline, and all registered app modules from module-list.nix.
#
# Module arguments (charts, kubelib, k8s) are injected by flake.nix
# via _module.args — app modules receive them in their function
# signatures (e.g. { config, lib, charts, kubelib, ... }:).
#
# Usage in flake.nix:
#
#   nixosModules.default = { pkgs, ... }:
#     let
#       charts = nixhelm.charts.${pkgs.system};
#       kubelib = import ./lib/helm.nix { inherit pkgs; };
#       k8s = import ./lib/k8s.nix { inherit pkgs; };
#     in {
#       _module.args = { inherit charts kubelib k8s; };
#       imports = [ ./modules ];
#     };
#
# Usage in a consumer's configuration.nix:
#
#   { inputs, ... }: {
#     imports = [ inputs.openkrill.nixosModules.default ];
#     services.openkrill.enable = true;
#     openkrill.domain = "mycompany.com";
#     openkrill.apps.cert-manager.enable = true;
#   }
{
  imports = [
    ./openkrill.nix
    ./options.nix
    ./manifests.nix
    ./routes.nix
    ./custom.nix
    ./secret-generators.nix
  ] ++ import ./module-list.nix;
}
