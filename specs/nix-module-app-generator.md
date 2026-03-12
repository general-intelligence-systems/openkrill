# App Module Generator

How to use `bin/create-module-crds` and `lib/generate-module.nix` to
auto-generate typed Nix options from Kubernetes CRD YAML specifications.

For hand-writing a CRD module without the generator, see
[nix-module-crds.md](./nix-module-crds.md).  For general module
authoring, see [nix-module-apps.md](./nix-module-apps.md).

---

## Table of Contents

1. [Overview](#overview)
2. [Standalone vs Fragment Mode](#standalone-vs-fragment-mode)
3. [Workflow: Adding CRD Types to an App Module](#workflow-adding-crd-types-to-an-app-module)
4. [Real Examples](#real-examples)
5. [Regenerating After CRD Updates](#regenerating-after-crd-updates)
6. [Generator Internals](#generator-internals)
7. [Checklist](#checklist)

---

## Overview

Most app modules deploy a controller via Helm and then need typed options
for the CRDs that controller manages.  Writing these by hand is tedious
and error-prone — a single CRD can have dozens of nested spec fields.

The generator reads the OpenAPI v3 schema embedded in a CRD YAML
definition and emits valid Nix source code containing:

- **Typed options** — one `mkOption` per spec field, with correct types,
  defaults, and descriptions pulled from the CRD schema.
- **Builder functions** — `mk<Kind>` functions that serialize the option
  values back into a K8s resource attrset, using `optionalAttrs` and
  `compact` to omit unset fields.
- **Submodules** — nested CRD objects become Nix `types.submodule`
  definitions automatically.

The generated code is written to a `.nix` file and checked into the
repo.  It is **not** evaluated at build time — the generator is a
development tool, not a build dependency.

---

## Standalone vs Fragment Mode

The generator has two modes, controlled by the `--fragment` flag:

### Standalone (default)

Generates a **complete app module** — the output is a self-contained
`default.nix` with `mkEnableOption`, `extraManifests`,
`mkIf cfg.enable` guard.

Use standalone mode when the app **is** just a set of CRD instances
with no Helm chart, RBAC, or other resources alongside them.

```sh
bin/create-module-crds my-crd crd.yaml > apps/my-crd/default.nix
```

Generated structure:

```nix
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."my-crd";
  helpers = import ../../modules/lib/helpers.nix { inherit lib; };
  # ... submodules, builders ...
in
{
  options.openkrill.apps."my-crd" = {
    enable = mkEnableOption "my-crd CRD resources";
    # ... typed CRD options ...
    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    openkrill.manifests."my-crd".content = allResources;
  };
}
```

### Fragment (`--fragment`)

Generates a **module fragment** — just the options and config, with no
`enable`, `extraManifests`, or `mkIf` guard.  The fragment is designed
to be imported by a hand-written composing `default.nix` that provides
the shared plumbing.

**This is the common case.**  Most app modules deploy a Helm chart for
the controller and then compose one fragment per CRD kind for the
typed resource options.

```sh
bin/create-module-crds --fragment gateway-api gateways.yaml > apps/gateway-api/gateways.nix
```

Generated structure:

```nix
# Auto-generated openkrill module fragment for gateway-api
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."gateway-api";
  # ... submodules, builders ...
in
{
  options.openkrill.apps."gateway-api" = {
    # ... typed CRD options (no enable, no extraManifests) ...
  };

  config = mkIf cfg.enable {
    openkrill.manifests."gateway-api".content = allResources;
  };
}
```

The fragment still guards its config with `mkIf cfg.enable`, but it
relies on the composing module to declare the `enable` option.  Since
NixOS merges all module options, the fragment's options are added to the
same `openkrill.apps."gateway-api"` attrset as the composing module's
`enable` and `extraManifests`.

---

## Workflow: Adding CRD Types to an App Module

### 1. Obtain the CRD YAML

Get the CRD definitions from upstream.  Common sources:

```sh
# From a running cluster
kubectl get crd gateways.gateway.networking.k8s.io -o yaml > gateways.yaml

# From a Helm chart's templates
helm template my-release my-repo/my-chart | yq 'select(.kind == "CustomResourceDefinition")' > crd.yaml

# From an upstream GitHub release
curl -LO https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.5.0/standard-install.yaml
# Then split out individual CRDs with yq
```

Each CRD YAML must contain `spec.group`, `spec.names`, and
`spec.versions[].schema.openAPIV3Schema` — the standard structure for
a `CustomResourceDefinition` resource.

### 2. Generate one fragment per CRD kind

Run the generator with `--fragment` for each CRD kind.  One CRD YAML
produces one fragment file:

```sh
mkdir -p apps/my-app

bin/create-module-crds --fragment my-app gateways.yaml    > apps/my-app/gateways.nix
bin/create-module-crds --fragment my-app httproutes.yaml   > apps/my-app/httproutes.nix
bin/create-module-crds --fragment my-app grpcroutes.yaml   > apps/my-app/grpcroutes.nix
```

Each fragment adds its own `attrsOf submodule` option (e.g.
`openkrill.apps.my-app.gateways`, `openkrill.apps.my-app.httproutes`)
and contributes resources to `openkrill.manifests."my-app".content`.

If you pass multiple CRD YAML files to a single invocation, the
generator combines them into one file with multiple `attrsOf submodule`
options.  Use separate invocations when you want one file per CRD kind
(recommended for readability).

### 3. Write the composing `default.nix`

The composing module imports all fragments and provides the shared
plumbing that fragments don't generate:

```nix
# apps/my-app — My App description
{ config, lib, charts, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.my-app;
  helpers = import ../../modules/lib/helpers.nix { inherit lib; };
in
{
  imports = [
    ./gateways.nix
    ./httproutes.nix
    ./grpcroutes.nix
  ];

  options.openkrill.apps.my-app = {
    enable = mkEnableOption "My App";

    namespace = mkOption {
      type = types.str;
      default = "my-app";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ArgoCD Application CR
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
        syncOptions = [ "CreateNamespace=true" "ServerSideApply=true" ];
      };
    };

    # Helm chart + namespace
    openkrill.manifests.my-app.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ (kubelib.fromHelm {
        name = "my-app";
        chart = charts.my-repo.my-chart;
        namespace = cfg.namespace;
        values = lib.recursiveUpdate {} cfg.values;
      });
  };
}
```

Key elements the composing module provides that fragments do not:

| Element | Why |
|---------|-----|
| `enable = mkEnableOption` | Module-level enable/disable toggle |
| `namespace` option | Shared namespace for all resources |
| `values` option | Helm chart value overrides |
| `extraManifests` | Consumer-injectable extra resources |
| ArgoCD Application CR | Self-management via ArgoCD |
| Helm chart rendering | Controller deployment |
| Namespace resource | See below |
| RBAC, Secrets, ConfigMaps | Any non-CRD resources the app needs |

### 4. Create a Namespace resource

The generator does not emit Namespace resources.  Always create one
explicitly in the composing `default.nix` — don't rely on Helm's
`--create-namespace` or ArgoCD's `CreateNamespace=true` alone, because
the namespace needs to exist in the rendered manifest repo as a
tracked resource:

```nix
my-app.content =
  [ (k8s.mkNamespace cfg.namespace) ]
  ++ (kubelib.fromHelm { ... });
```

Or if you don't use the `k8s` helper:

```nix
my-app.content = [
  {
    apiVersion = "v1";
    kind = "Namespace";
    metadata.name = cfg.namespace;
  }
] ++ otherResources;
```

This ensures the namespace is:
- Visible in the rendered manifest repo
- Managed by ArgoCD (pruned if the app is disabled)
- Created before resources that depend on it

### 5. Test

App modules are auto-discovered by `modules/module-list.nix` via `builtins.readDir`
-- no manual registration is needed. Just stage the files and test:

```sh
git add apps/my-app/
bin/test
```

---

## Real Examples

### gateway-api (8 CRD fragments)

The gateway-api module provides typed options for all Gateway API CRD
kinds.  It does not deploy a controller — Traefik (bundled with k3s)
provides the Gateway API implementation.

```
apps/gateway-api/
  default.nix              # Composing module: enable, safeUpgrades VAP, ArgoCD App
  backendtlspolicies.nix   # Fragment: BackendTLSPolicy CRD
  gatewayclasses.nix       # Fragment: GatewayClass CRD
  gateways.nix             # Fragment: Gateway CRD
  grpcroutes.nix           # Fragment: GRPCRoute CRD
  httproutes.nix           # Fragment: HTTPRoute CRD
  listenersets.nix         # Fragment: ListenerSet CRD (experimental)
  referencegrants.nix      # Fragment: ReferenceGrant CRD
  tlsroutes.nix            # Fragment: TLSRoute CRD
```

The `default.nix` imports all 8 fragments and adds a
`ValidatingAdmissionPolicy` for safe CRD channel upgrades — something
that can't be generated from a CRD spec.

### external-secrets (22 CRD fragments)

The External Secrets Operator has 22 CRD kinds.  Each gets its own
fragment file.  The composing `default.nix` provides the Helm chart,
RBAC, `ClusterSecretStore`, source namespace, and a high-level
`secrets` submodule for declaring `ExternalSecret` resources with a
simpler interface.

### argocd (3 CRD fragments)

ArgoCD has `Application`, `ApplicationSet`, and `AppProject` CRDs.
The composing module deploys ArgoCD via Helm with Authelia OIDC
integration, trust-manager CA bundle mounting, and RBAC defaults.

### cloudnative-pg (9 CRD fragments)

CloudNativePG has CRDs for `Cluster`, `Database`, `Backup`,
`ScheduledBackup`, `Pooler`, etc.  The composing module deploys the
CNPG operator Helm chart, a shared PostgreSQL `Cluster`, and a
`ClusterSecretStore` with RBAC so other app modules can read
credentials via `ExternalSecret`.

---

## Regenerating After CRD Updates

When upstream CRDs are updated (new fields, changed types, new CRD
kinds), re-run the generator and review the diff:

```sh
# Fetch updated CRD YAML
kubectl get crd gateways.gateway.networking.k8s.io -o yaml > gateways.yaml

# Regenerate the fragment
bin/create-module-crds --fragment gateway-api gateways.yaml > apps/gateway-api/gateways.nix

# Review changes
git diff apps/gateway-api/gateways.nix
```

Common diff patterns:

| Change | Action |
|--------|--------|
| New optional field added | Usually safe — existing configs unaffected |
| Field type changed | Review existing consumer configs |
| New required field added | Consumers will need to set it — may need a default in the composing module |
| Field removed | Consumers using it will get eval errors — add a deprecation path if needed |

The generator is deterministic — same CRD input always produces the
same output.  Run `nixfmt` on the output if the generator's formatting
doesn't match your conventions (the `bin/create-module-crds` script
pipes through `nixfmt` automatically).

---

## Generator Internals

### Type mapping

The generator maps OpenAPI v3 schema types to Nix option types:

| OpenAPI type | Required | Optional |
|---|---|---|
| `string` | `types.str` | `types.nullOr types.str` (default `null`) |
| `string` with `format: int-or-string` | `types.either types.int types.str` | `types.nullOr (types.either types.int types.str)` |
| `string` with `enum` | `types.enum [...]` | `types.enum [...]` |
| `integer` / `number` | `types.int` | `types.nullOr types.int` (default `null`) |
| `boolean` | `types.bool` | `types.bool` (default `false`) |
| `array` of scalars | `types.listOf types.<inner>` | `types.listOf types.<inner>` (default `[]`) |
| `array` of objects | `types.listOf <SubModule>` | `types.listOf <SubModule>` (default `[]`) |
| `object` with `properties` | `<SubModule>` | `types.nullOr <SubModule>` (default `null`) |
| `object` with `additionalProperties` | `types.attrsOf types.<inner>` | `types.attrsOf types.<inner>` (default `{}`) |
| `object` (no schema / `oneOf` / `anyOf`) | `types.attrsOf types.anything` | `types.attrsOf types.anything` (default `{}`) |

Required fields have no default — the consumer must set them.
Optional fields get sensible zero-value defaults (`null`, `false`,
`[]`, `{}`).

### Submodule generation

Nested CRD objects with `properties` become Nix `types.submodule`
definitions.  Names are derived from the field path:

```
spec.listeners[].tls.certificateRefs[]
  → ListenerModule (submodule for each listener)
  → TlsModule (submodule for TLS config)
  → CertificateRefModule (submodule for each cert ref)
```

Arrays of objects use `types.listOf <SubModule>`.  Single nested
objects use `<SubModule>` (required) or `types.nullOr <SubModule>`
(optional).

Shared submodule names across multiple CRD kinds are deduplicated —
if two CRDs in the same module both define a `ParentRefModule`, only
one definition is emitted.

### Builder functions

For each CRD kind and each nested object, the generator emits a
builder function (`mk<Kind>`, `mk<NestedType>`) that converts the
option values back to a K8s resource attrset.

Builders use two patterns to omit unset optional fields:

```nix
# For individual nullable/boolean/list fields
// optionalAttrs (res.timeout != null) { inherit (res) timeout; }
// optionalAttrs res.bootstrap { inherit (res) bootstrap; }
// optionalAttrs (res.items != []) { inherit (res) items; }

# For objects with many nullable fields
compact = filterAttrs (_: v: v != null);
mkRef = ref: compact { inherit (ref) name namespace port; };
```

This keeps the generated YAML clean — only fields the consumer
actually sets appear in the output.

### CRD info extraction

The generator reads `spec.versions` from the CRD and picks the
**storage version** (`storage: true`).  It extracts:

- `apiVersion` — from `spec.group` + version name
- `kind` — from `spec.names.kind`
- `plural` — from `spec.names.plural` (used as the option name)
- `specSchema` — the OpenAPI v3 schema under `spec.versions[].schema.openAPIV3Schema.properties.spec`

The top-level `metadata` fields (name, namespace) are handled by the
generator's wrapper — only `spec` fields are walked from the schema.

---

## Checklist

Before submitting a module with generated CRD fragments:

- [ ] CRD YAML obtained from upstream (pinned version)
- [ ] One fragment generated per CRD kind (`--fragment`)
- [ ] Composing `default.nix` written with `enable`, `extraManifests`, ArgoCD Application
- [ ] Namespace resource created explicitly in `default.nix`
- [ ] All fragments imported in `default.nix`
- [ ] `ServerSideApply=true` in ArgoCD `syncOptions` (required for CRD-heavy modules)
- [ ] App module auto-discovered via `modules/module-list.nix` (no manual registration needed)
- [ ] Files staged: `git add apps/<name>/`
- [ ] `bin/test` passes
