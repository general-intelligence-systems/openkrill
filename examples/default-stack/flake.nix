# OpenKrill default-stack example.
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
        ];

        # ── k3s server ──────────────────────────────────────────────
        services.openkrill.enable = true;
        networking.hostName = "openkrill";

        # ── Cluster ─────────────────────────────────────────────────
        openkrill.domain = domain;
        openkrill.gitops.enable = true;

        # ── Core infrastructure ──────────────────────────────────────
        openkrill.apps.argocd.enable           = true;
        openkrill.apps.cert-manager.enable     = true;
        openkrill.apps.cilium.enable           = true;
        openkrill.apps.cloudnative-pg.enable   = true;
        openkrill.apps.core-dns.enable         = true;
        openkrill.apps.external-secrets.enable = true;
        openkrill.apps.gateway-api.enable      = true;
        openkrill.apps.helm.enable             = true;
        openkrill.apps.metacontroller.enable   = true;

        openkrill.apps.openkrill-operator.enable = true;
        openkrill.apps.traefik.enable          = true;
        openkrill.apps.trust-manager.enable    = true;

        # ── ArgoCD ───────────────────────────────────────────────────
        openkrill.apps.argocd = {
          domain = "argocd.${domain}";
          oidc.issuer = "https://auth.${domain}";
        };

        # ── LDAP user management ────────────────────────────────────
        openkrill.apps.lldap = {
          enable = true;
          baseDn = "dc=example,dc=com";
        };

        # ── SSO ─────────────────────────────────────────────────────
        openkrill.apps.authelia = {
          enable = true;
          sessionCookies = [
            {
              domain = domain;
              subdomain = "auth";
            }
          ];
          oidcClients = [
            {
              name = "Argo CD";
              redirect_uris = [ "https://argocd.${domain}/auth/callback" ];
            }
            {
              name = "OpenCloud";
              public = true;
              redirect_uris = [
                "https://cloud.${domain}/"
                "https://cloud.${domain}/oidc-callback.html"
                "https://cloud.${domain}/oidc-silent-redirect.html"
              ];
            }
          ];
        };

        # ── File storage ────────────────────────────────────────────
        openkrill.apps.opencloud = {
          enable = true;
          domain = "cloud.${domain}";
          oidc.issuer = "https://auth.${domain}";
          collabora.domain = "office.${domain}";
        };

        # ── Web IDE ─────────────────────────────────────────────────
        openkrill.apps.theia-ide.enable = true;

        # ── Base system ─────────────────────────────────────────────
        # Fallback root filesystem — image modules override this at
        # higher priority with their own disk layout.
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
