# OpenKrill custom-app example.
#
# Shows how to write your own openkrill app module with typed
# options and cross-module references. The module lives in your
# repo as a plain .nix file alongside the flake.
#
# Build images:
#   nix build .#qcow2
#   nix build .#digitalocean
#   nix build .#google-compute
#   nix build .#incus-vm
#   nix build .#iso
#
# Run dev VM:
#   nix run .#vm
#
# Generate manifests only:
#   nix build .#manifests
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    openkrill.url = "github:general-intelligence-systems/openkrill";
  };

  outputs = { self, nixpkgs, openkrill, ... }:
    let
      system = "x86_64-linux";
      domain = "example.com";

      clusterConfig = { lib, ... }: {
        imports = [
          openkrill.nixosModules.default
          ./my-rails-app.nix
        ];

        # ── k3s server ──────────────────────────────────────────────
        services.openkrill.enable = true;
        networking.hostName = "openkrill";

        # ── Cluster ─────────────────────────────────────────────────
        openkrill.domain = domain;
        openkrill.gitops.enable = true;

        # ── TLS ─────────────────────────────────────────────────────
        openkrill.apps.cert-manager.enable = true;

        # ── Custom app ──────────────────────────────────────────────
        # Enable and configure the app defined in my-rails-app.nix.
        openkrill.apps.myRailsApp = {
          enable = true;
          image = "registry.${domain}/myapp:v1.2.3";
          replicas = 3;
          host = "myapp.${domain}";
          env = {
            RAILS_ENV = "production";
            DATABASE_URL = "postgres://myapp:secret@myapp-rw.myapp:5432/myapp";
          };
        };

        # ── Base system ─────────────────────────────────────────────
        fileSystems."/" = lib.mkOverride 1500 {
          device = "/dev/vda1";
          fsType = "ext4";
        };

        system.stateVersion = "25.11";
      };

      # Build base system, then derive all image variants.
      baseSystem = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ clusterConfig ];
      };

      images = openkrill.lib.buildImages {
        inherit nixpkgs;
        system = baseSystem;
      };
    in
    {
      # ── Hardware deployment target ────────────────────────────────
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          openkrill.nixosModules.default
          clusterConfig
          {
            fileSystems."/" = { device = "/dev/sda1"; fsType = "ext4"; };
            boot.loader.grub.device = "/dev/sda";
          }
        ];
      };

      # ── Dev Shell ─────────────────────────────────────────────────
      devShells.${system}.default = openkrill.devShells.${system}.default;

      # ── Image outputs ─────────────────────────────────────────────
      packages.${system} = {
        qcow2           = images.qcow2.image;
        digitalocean    = images.digitalocean.image;
        google-compute  = images.google-compute.image;
        incus-vm        = images.incus-vm.image;
        iso             = images.iso.image;
        vm              = images.vm.image;
        manifests       = baseSystem.config.openkrill.renderedManifestRepo;
        default         = images.qcow2.image;
      };
    };
}
