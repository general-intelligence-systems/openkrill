# Central registry of all openkrill app modules.
# Add new modules here — they will be automatically loaded by the
# module framework. Each module should use mkEnableOption so it's
# disabled by default.
#
# This follows the same pattern as nixpkgs' nixos/modules/module-list.nix.
[
  ./argocd
  ./authelia
  ./cert-manager
  ./cloudnative-pg
  ./core-dns
  ./external-secrets
  ./forgejo-runner
  ./gateway-api
  ./helm
  ./kamaji
  ./lldap
  ./lago
  ./metacontroller
  ./opencloud
  ./theia-ide
  ./traefik
  ./trust-manager
  ./victoriametrics
]
