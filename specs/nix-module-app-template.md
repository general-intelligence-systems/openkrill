# App-Template Module Generator

How to use `bin/create-module-app-template` and
`lib/generate-app-template.nix` to auto-generate typed Nix options from
the bjw-s app-template Helm chart JSON Schema.

For the CRD module generator, see
[nix-module-app-generator.md](./nix-module-app-generator.md).  For
general module authoring, see
[nix-module-apps.md](./nix-module-apps.md).

---

## Table of Contents

1. [Overview](#overview)
2. [Architecture](#architecture)
3. [Workflow: Using Typed Values in an App Module](#workflow-using-typed-values-in-an-app-module)
4. [Regenerating After Chart Updates](#regenerating-after-chart-updates)
5. [Generator Internals](#generator-internals)
6. [Comparison with CRD Generator](#comparison-with-crd-generator)
7. [Checklist](#checklist)

---

## Overview

The [bjw-s app-template](https://bjw-s-labs.github.io/helm-charts/) is a
generic Helm library chart for deploying any containerized application to
Kubernetes.  Its values schema covers controllers (Deployment,
StatefulSet, DaemonSet, CronJob, Job), services, ingress, persistence,
RBAC, ServiceMonitor, Gateway API routes, and more.

Without the generator, app modules that use app-template expose an
untyped `values` option (`types.attrs`) -- no validation, no
tab-completion, no defaults.

The generator reads the chart's JSON Schema
(`lib/helm-app-schema/values.schema.json` plus 18 sub-schemas) and emits
a **reusable Nix library module** at `modules/lib/app-template.nix`
that exports `valuesType` -- a `types.submodule` with typed options for
every chart value.  App modules import this module and use `valuesType`
in place of `types.attrs`.

The generated code is checked into the repo.  It is **not** evaluated at
build time -- the generator is a development tool, not a build
dependency.

---

## Architecture

```
lib/helm-app-schema/                  Input: JSON Schema (19 files)
    values.schema.json                Root schema (references sub-schemas)
    schemas/*.json                    Sub-schemas: k8s-api, gw-api, envVars, etc.
         |
         |  bin/create-module-app-template
         |    Step 1: Ruby resolves all $ref cross-file references
         |    Step 2: nix-instantiate --eval invokes lib/generate-app-template.nix
         |    Step 3: nixfmt formats the output
         v
modules/lib/app-template.nix          Output: reusable library module (5000+ lines)
         |
         |  import ../../../modules/lib/app-template.nix { inherit lib; }
         v
apps/<name>/default.nix               Consumer: values = mkOption { type = appTemplate.valuesType; }
```

### Key difference from CRD generator

The CRD generator (`bin/create-module-crds`) produces **per-app module
fragments** -- one generated file per CRD kind.  The app-template
generator produces **one shared library module** that any app-template
consumer imports.  This avoids duplicating 5000+ lines across every app
that uses the chart.

---

## Workflow: Using Typed Values in an App Module

### 1. Import the library module

In your app's `default.nix`, import `app-template.nix`:

```nix
# apps/my-app/default.nix
{ config, lib, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.my-app;
  helpers     = import ../../../modules/lib/helpers.nix { inherit lib; };
  appTemplate = import ../../../modules/lib/app-template.nix { inherit lib; };

  chart = kubelib.downloadHelmChart {
    repo = "https://bjw-s-labs.github.io/helm-charts/";
    chart = "app-template";
    version = "4.6.2";
    chartHash = "sha256-AAAA...";
  };

  defaults = {
    controllers.main.containers.main.image = {
      repository = "ghcr.io/example/my-app";
      tag = "latest";
    };
    service.main = {
      controller = "main";
      ports.http.port = 8080;
    };
  };
in
{
  options.openkrill.apps.my-app = {
    enable = mkEnableOption "My App";

    namespace = mkOption {
      type = types.str;
      default = "my-app";
    };

    values = mkOption {
      type = appTemplate.valuesType;
      default = {};
      description = "app-template Helm chart values (typed).";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    openkrill.apps.argocd.applications.my-app = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "my-app.yaml";
      };
      destination = {
        server = "https://kubernetes.default.svc";
        namespace = cfg.namespace;
      };
      syncPolicy = {
        automated = { prune = true; selfHeal = true; };
        syncOptions = [ "CreateNamespace=true" ];
      };
    };

    openkrill.manifests.my-app.content = kubelib.fromHelm {
      name = "my-app";
      inherit chart;
      namespace = cfg.namespace;
      values = recursiveUpdate defaults cfg.values;
    };
  };
}
```

### 2. Consumer usage

Consumers get typed values with validation and defaults:

```nix
openkrill.apps.my-app = {
  enable = true;
  values = {
    controllers.main.containers.main.image.tag = "v1.2.3";
    service.main.ports.http.port = 9090;
    persistence.data = {
      type = "persistentVolumeClaim";
      accessMode = "ReadWriteOnce";
      size = "10Gi";
      globalMounts = [{ path = "/data"; }];
    };
  };
};
```

### 3. What gets typed

The `valuesType` submodule provides typed options for all known chart
value keys.  Every submodule also declares
`freeformType = types.attrsOf types.anything`, which means:

- **Known fields** are validated against their declared types (enums,
  bools, ints, strings, submodules, etc.).
- **Unknown fields** pass through without validation -- the chart may
  accept values the schema doesn't cover, and consumers can always set
  arbitrary keys.

This is the "typed with escape hatch" pattern: you get validation where
the schema defines structure, but you're never blocked by the type
system.

---

## Regenerating After Chart Updates

When the bjw-s chart releases a new version with schema changes:

### 1. Update the JSON Schema files

Replace the files in `lib/helm-app-schema/` with the new version's
schema.  The schema lives at:

```
https://github.com/bjw-s-labs/helm-charts/tree/common-X.Y.Z/charts/library/common
```

Copy `values.schema.json` and the `schemas/` directory.

### 2. Regenerate

```sh
bin/create-module-app-template > modules/lib/app-template.nix
```

### 3. Review and test

```sh
git diff modules/lib/app-template.nix
bin/test
```

Common diff patterns:

| Change | Action |
|--------|--------|
| New optional field added | Usually safe -- existing configs unaffected |
| Field type changed | Review existing consumer configs |
| New required field added | Consumers may need to set it (but freeformType prevents breakage) |
| Field removed | Consumers using it will still work (freeformType passes it through), but they lose type checking |

The generator is deterministic -- same schema input always produces the
same output.

---

## Generator Internals

### Pipeline

```
lib/helm-app-schema/*.json
    |
    |  bin/create-module-app-template (bash)
    |    Ruby: resolve all $ref cross-file/within-file references
    |    Output: single flat JSON blob (all refs inlined)
    |
    |  nix-instantiate --eval (nix)
    |    lib/generate-app-template.nix: JSON Schema -> Nix source string
    |
    |  Ruby: unescape JSON string
    |  nixfmt: format
    v
modules/lib/app-template.nix
```

### $ref resolution (Ruby)

JSON Schema uses `$ref` for cross-file references:

```json
{ "$ref": "schemas/controllers.json#/instance" }
```

The Ruby resolver:

1. Loads all `.json` files in `lib/helm-app-schema/` into a registry
   keyed by relative path.
2. Recursively walks the schema tree, replacing every `$ref` with its
   resolved target.
3. Merges sibling keys (e.g. `description` alongside `$ref`).
4. Detects circular references and falls back to `{ "type": "object" }`.
5. Outputs a single flat JSON blob with no remaining `$ref` pointers.

### Schema walking (Nix)

The Nix generator (`lib/generate-app-template.nix`) is modeled after
the CRD generator (`lib/generate-module.nix`) but adapted for JSON
Schema:

**Field classification:**

| Schema pattern | Walker | Nix type |
|----------------|--------|----------|
| `type: "object"` with `properties` | `walkObjectField` | `types.submodule { ... }` |
| `type: "object"` with `additionalProperties` (schema) and no `properties` | `walkDictField` | `types.attrsOf <submodule>` |
| `type: "array"` with `items` (object) | `walkArrayField` | `types.listOf <submodule>` |
| Everything else | `walkScalarField` | Scalar type from `mapScalarType` |
| `allOf` present | Pre-processed by `mergeAllOf` | Properties merged from all items |

**Type mapping:**

| JSON Schema | Nix type |
|---|---|
| `type: "string"` | `types.str` |
| `type: ["string", "null"]` | `types.nullOr types.str` |
| `type: "integer"` / `"number"` | `types.int` |
| `type: ["integer", "null"]` | `types.nullOr types.int` |
| `type: "boolean"` | `types.bool` (default `false`) |
| `type: "array", items: { type: "string" }` | `types.listOf types.str` (default `[]`) |
| `type: "object", additionalProperties: { type: "string" }` | `types.attrsOf types.str` (default `{}`) |
| `enum: [...]` | `types.enum [...]` |
| `const: "value"` | `types.enum [ "value" ]` (default `"value"`) |
| `type: ["string", "integer"]` | `types.either types.str types.int` |
| `oneOf` with 2 scalar variants | `types.either <type1> <type2>` |
| `oneOf`/`anyOf` complex | `types.anything` |
| No type / unresolvable | `types.anything` |

**allOf handling:**

JSON Schema `allOf` is used extensively in the bjw-s schema (e.g.
controllers merge `resourceIdentifier` with controller-specific
properties).  The generator merges all items' `properties`, `required`,
`type`, `description`, and `additionalProperties` into a single combined
schema before walking.

**Recursion safety:**

A max depth of 12 prevents infinite recursion on circular schemas.
Fields beyond this depth are emitted as `types.anything`.

### Submodule naming

Submodule names are derived from the field path:

```
controllers.<name>.containers.<name>.image
  -> ControllerContainerImageModule

service.<name>.ports.<name>
  -> ServicePortModule

controllers.<name>.cronjob
  -> ControllerCronjobModule
```

The naming scheme:
- Each path segment is capitalized and concatenated.
- Hyphens and dots are treated as word separators.
- Dictionary keys use the singular form (e.g. `controllers` ->
  `Controller`, `ports` -> `Port`).
- The suffix `Module` is appended.

Deduplication: `listToAttrs` keeps the first occurrence when multiple
paths produce the same module name.

### freeformType pattern

Every generated submodule declares:

```nix
types.submodule {
  freeformType = types.attrsOf types.anything;
  options = { ... };
};
```

This means:
- **Typed fields** are validated and have defaults/descriptions.
- **Untyped fields** pass through without error -- consumers can set
  any key the chart accepts, even if the schema doesn't define it.
- **No breakage** on schema updates -- new/removed fields don't cause
  eval errors.

---

## Comparison with CRD Generator

| Aspect | CRD generator | App-template generator |
|--------|---------------|------------------------|
| Input | CRD YAML (OpenAPI v3 in `spec.versions`) | JSON Schema files |
| Output | Per-app fragment (one file per CRD kind) | Shared library module (one file for all consumers) |
| Builders | Yes (`mk<Kind>` functions that serialize to K8s resources) | No (values pass directly to `kubelib.fromHelm`) |
| `$ref` handling | Not needed (OpenAPI v3 is self-contained) | Ruby pre-processor resolves cross-file `$ref` |
| `allOf` handling | Not present in CRDs | `mergeAllOf` merges properties from all items |
| `oneOf`/`anyOf` | Passthrough (`types.anything`) | Simple unions use `types.either`, complex use `types.anything` |
| Type arrays | Not present in CRDs | `["string", "null"]` -> `types.nullOr types.str` |
| `freeformType` | No -- strict typing only | Yes -- typed with escape hatch |
| Consumer usage | `openkrill.apps.<name>.<plural>` (CRD instances) | `openkrill.apps.<name>.values` (Helm chart values) |
| Script | `bin/create-module-crds` | `bin/create-module-app-template` |
| Generator | `lib/generate-module.nix` | `lib/generate-app-template.nix` |

---

## Checklist

Before using the app-template typed values in a new module:

- [ ] `modules/lib/app-template.nix` exists (generated)
- [ ] Module imports `app-template.nix`:
      `appTemplate = import ../../../modules/lib/app-template.nix { inherit lib; };`
- [ ] `values` option uses `appTemplate.valuesType` instead of `types.attrs`
- [ ] Module defaults defined in a `defaults` let-binding
- [ ] `values = recursiveUpdate defaults cfg.values` passed to `kubelib.fromHelm`
- [ ] Helm chart pinned with `kubelib.downloadHelmChart` (version + hash)
- [ ] ArgoCD Application CR declared
- [ ] `extraManifests` option declared via `helpers.mkExtraManifestsOption`
- [ ] Files staged: `git add apps/<name>/`
- [ ] `bin/test` passes

When updating the schema:

- [ ] New JSON Schema files placed in `lib/helm-app-schema/`
- [ ] `bin/create-module-app-template > modules/lib/app-template.nix`
- [ ] Diff reviewed: `git diff modules/lib/app-template.nix`
- [ ] `bin/test` passes
- [ ] Chart version in consumer modules updated to match schema version
