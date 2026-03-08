# Monitoring Stack Example

Demonstrates the richer parts of the openkrill API:

- **cert-manager** with `extraManifests` (wildcard certificate)
- **cloudnative-pg** database clusters for multiple namespaces
- **Inline custom app** (`openkrill.apps.custom.redis`) — group manifests under a name with an enable flag, no NixOS module needed
- **Raw manifests** (`openkrill.manifests`) for one-off resources
