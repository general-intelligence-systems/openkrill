{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixhelm = {
      url = "github:general-intelligence-systems/nixhelm2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixhelm, ... }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems f;
    in
    {
      # ── Reusable NixOS module ──────────────────────────────────
      #
      #   { inputs, ... }: {
      #     imports = [ inputs.openkrill.nixosModules.default ];
      #     services.openkrill.enable = true;
      #     openkrill.domain = "mycompany.com";
      #     openkrill.apps.cert-manager.enable = true;
      #   }
      #
      # See examples/ for complete usage patterns.
      nixosModules.default = { pkgs, ... }:
        let
          charts = nixhelm.charts.${pkgs.system};
          kubelib = import ./lib/helm.nix { inherit pkgs; };
          k8s = import ./lib/k8s.nix { inherit pkgs; };
        in
        {
          _module.args = { inherit charts kubelib k8s; };
          imports = [ ./modules ];
        };

      # ── Library helpers ─────────────────────────────────────────
      #
      # buildImages — create standard image variants from a base system.
      #
      #   let
      #     base = nixpkgs.lib.nixosSystem { ... };
      #     images = openkrill.lib.buildImages { inherit nixpkgs; system = base; };
      #   in {
      #     packages.x86_64-linux.qcow2 = images.qcow2.image;
      #     packages.x86_64-linux.vm    = images.vm.image;
      #   }
      #
      lib.buildImages = { nixpkgs, system }:
        import ./lib/images.nix { inherit nixpkgs system; };

      # ── Checks (nix flake check) ──────────────────────────────
      checks = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          k3s-test = import ./tests/k3s-test.nix {
            inherit pkgs;
            openkrill-module = self.nixosModules.default;
          };
        }
      );

      # ── Dev shells ─────────────────────────────────────────────
      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              git
              ruby_3_4
              #kubectl
              #kubernetes-helm
              #k9s
            ];
            shellHook = ''
              export BUNDLE_PATH=".bundler"
              export GEM_PATH=".bundler/ruby/3.4.0"

              export PATH="$PWD/bin:$PATH"
              export PATH=".bundler/ruby/3.4.0/bin:$PATH"
            '';
          };
        }
      );
    };
}
