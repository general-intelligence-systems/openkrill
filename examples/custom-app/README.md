# Custom App Example

Demonstrates how to write your own openkrill app as a NixOS module (`my-rails-app.nix`). This gives you:

- **Typed options** (`image`, `replicas`, `host`, `env`) with defaults and validation
- **Cross-module references** (conditionally emit a Certificate resource when cert-manager is enabled)
- **The same enable/disable pattern** as built-in openkrill apps

The module lives in your repo as a plain `.nix` file and is imported alongside `openkrill.nixosModules.default` in the flake.
