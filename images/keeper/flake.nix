# images/keeper — Custom Keeper image with reverse-proxy auth (Authelia).
#
# Clones the upstream keeper.sh source and overlays our modified files
# on top.  Changes:
#   - packages/auth/src/plugins/proxy-auth/ — new better-auth plugin
#     that auto-creates sessions from Remote-User/Remote-Email headers
#     set by a trusted reverse proxy (Authelia, Authentik, etc.)
#   - packages/auth/src/index.ts — registers the proxy-auth plugin
#   - packages/auth/src/capabilities.ts — advertises proxyAuth support
#   - packages/data-schemas/src/index.ts — adds 'proxy' credential mode
#   - services/api/src/env.ts — adds PROXY_AUTH_ENABLED env var
#   - services/api/src/context.ts — passes proxyAuth flag to createAuth
#   - services/api/src/utils/middleware.ts — checks Remote-User header
#     before falling through to session/bearer auth
#
# Build:
#   nix build .#source
#   docker build -f docker/services/Dockerfile $(nix build .#source --print-out-paths)
#
# The upstream Dockerfile is used directly since it copies from the
# build context (COPY . .) — our overlays are already in the source
# tree by the time Docker sees it.
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    keeper-src = {
      url = "github:ridafkih/keeper.sh";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, keeper-src }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f {
        pkgs = nixpkgs.legacyPackages.${system};
      });
    in
    {
      packages = forAllSystems ({ pkgs }: {
        # Patched source tree — upstream + our overlays.
        source = pkgs.runCommand "keeper-source" {} ''
          cp -r ${keeper-src} $out
          chmod -R u+w $out
          cp -rT ${./overlays} $out
        '';

        default = self.packages.${pkgs.system}.source;
      });
    };
}
