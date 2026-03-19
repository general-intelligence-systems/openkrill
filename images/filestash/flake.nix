# images/filestash — Custom Filestash image with reverse-proxy auth + httpsfs.
#
# Clones the upstream Filestash source and overlays our modified files
# on top.  Changes:
#   - server/ctrl/session.go — proxy auth support (Remote-User headers)
#   - server/plugin/index.go — swaps plg_starter_http for plg_starter_httpsfs
#   - server/plugin/plg_starter_httpsfs/ — HTTPS server that reads
#     cert.pem + key.pem from /app/data/state/certs/ (filesystem certs
#     provisioned by cert-manager, not self-signed)
#
# Build:
#   nix build .#source
#   docker build -f Dockerfile $(nix build .#source --print-out-paths)
#
# The custom Dockerfile (not the upstream docker/Dockerfile) is used so
# that overlays are compiled into the binary.  The upstream Dockerfile
# re-clones from GitHub which would discard our changes.
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    filestash-src = {
      url = "github:mickael-kerjean/filestash";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, filestash-src }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f {
        pkgs = nixpkgs.legacyPackages.${system};
      });
    in
    {
      packages = forAllSystems ({ pkgs }: {
        # Patched source tree — upstream + our overlays.
        # Contains the upstream Dockerfile at docker/Dockerfile.
        source = pkgs.runCommand "filestash-source" {} ''
          cp -r ${filestash-src} $out
          chmod -R u+w $out
          cp -rT ${./overlays} $out
        '';

        default = self.packages.${pkgs.system}.source;
      });
    };
}
