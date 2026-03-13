# Architecture

## Overview

openkrill is a set of NixOS modules under the `openkrill` option namespace.
There are three layers:

1. **`openkrill.manifests`** — the collection point. An attrset of `{ enable, content }` submodules. Every manifest in the system ends up here.
2. **`openkrill.apps.*`** — app modules that write into `openkrill.manifests`. Each renders helm charts at build time and/or generates typed CRs.
3. **`openkrill.gitops`** — serves the collected manifests. Currently supports `gitDaemon`.

## Data flow

```
openkrill.apps.prometheus   ──┐
openkrill.apps.certManager  ──┤
openkrill.apps.custom.redis ──┼──▶ openkrill.manifests ──▶ renderedManifestRepo ──▶ git-daemon
openkrill.manifests.raw-ns  ──┘
```

App modules call `kubelib.fromHelm` at nix evaluation time. `helm template` runs inside a nix derivation, the output is parsed back into Nix attrsets. Those attrsets are written to `openkrill.manifests."name".content`.

`manifests.nix` collects every enabled manifest, serializes each to YAML via `pkgs.formats.yaml`, and commits them into a bare git repo on the `rendered-manifests` branch.

## Module arguments

The flake's `nixosModules.default` injects three `_module.args`:

- **`charts`** — `nixhelm.charts.${system}`. Attrset of chart derivations keyed by `repo.chart`. Each chart has `.latest` and `.versions."X.Y.Z"` attributes.
- **`kubelib`** — `import ./lib/helm.nix { inherit pkgs; }`. Provides `fromHelm`, `buildHelmChart`, `fromYAML`, and `downloadHelmChart`.
- **`k8s`** — `import ./lib/k8s.nix { inherit pkgs; }`. Helper constructors for common K8s resources (`mkNamespace`, `mkSecret`).

Consumers never set `specialArgs` — the flake handles it.

## Adding a new module

1. Create `apps/<my-app>/default.nix` (auto-discovered by `modules/module-list.nix` via `builtins.readDir`)
2. Follow one of the module authoring specs depending on complexity
