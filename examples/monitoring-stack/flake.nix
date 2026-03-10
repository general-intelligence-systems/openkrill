# OpenKrill monitoring-stack example.
#
# Demonstrates the richer parts of the openkrill API:
# cert-manager with extraManifests, cloudnative-pg database
# clusters, inline custom apps, and raw manifests.
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

      clusterConfig = { config, lib, ... }: {
        imports = [
          openkrill.nixosModules.default
        ];

        # ── k3s server ──────────────────────────────────────────────
        services.openkrill.enable = true;
        networking.hostName = "openkrill";

        # ── Cluster ─────────────────────────────────────────────────
        openkrill.domain = domain;
        openkrill.gitops.enable = true;

        # ── TLS ─────────────────────────────────────────────────────
        openkrill.apps.cert-manager = {
          enable = true;
          # Extra Certificate resource alongside cert-manager
          extraManifests.wildcard-cert = {
            apiVersion = "cert-manager.io/v1";
            kind = "Certificate";
            metadata = {
              name = "wildcard-example-com";
              namespace = "cert-manager";
            };
            spec = {
              secretName = "wildcard-example-com-tls";
              issuerRef = {
                name = "letsencrypt";
                kind = "ClusterIssuer";
              };
              dnsNames = [ "*.${domain}" ];
            };
          };
        };

        openkrill.apps.trust-manager = {
          enable = true;
          caSecretName = "cluster-ca";
        };

        # ── Database ────────────────────────────────────────────────
        # The shared CNPG cluster ("postgres") and authelia's database
        # are auto-provisioned.  Only declare app-specific databases.
        openkrill.apps.cloudnative-pg.databases.myapp = {
          namespace = config.openkrill.apps.cloudnative-pg.namespace;
          name = "myapp";
          owner = "app";
          cluster.name = config.openkrill.apps.cloudnative-pg.clusterName;
        };

        # ── Custom app bundle ───────────────────────────────────────
        # Group related manifests under one name with an enable flag.
        # No NixOS module needed.
        openkrill.apps.custom.redis = {
          enable = true;
          manifests = {
            namespace = {
              apiVersion = "v1";
              kind = "Namespace";
              metadata.name = "redis";
            };
            deployment = {
              apiVersion = "apps/v1";
              kind = "Deployment";
              metadata = {
                name = "redis";
                namespace = "redis";
              };
              spec = {
                replicas = 1;
                selector.matchLabels.app = "redis";
                template = {
                  metadata.labels.app = "redis";
                  spec.containers = [{
                    name = "redis";
                    image = "redis:7-alpine";
                    ports = [{ containerPort = 6379; }];
                  }];
                };
              };
            };
            service = {
              apiVersion = "v1";
              kind = "Service";
              metadata = {
                name = "redis";
                namespace = "redis";
              };
              spec = {
                selector.app = "redis";
                ports = [{ port = 6379; targetPort = 6379; }];
              };
            };
          };
        };

        # ── Raw manifests ───────────────────────────────────────────
        # One-off resources that don't belong to any app.
        openkrill.manifests.app-ns.content = {
          apiVersion = "v1";
          kind = "Namespace";
          metadata.name = "myapp";
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
