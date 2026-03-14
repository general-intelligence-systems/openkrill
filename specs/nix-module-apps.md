# HOW-TO: Creating an App Module

This guide explains how to add a new application by creating a
NixOS-style app module under `apps/{stable,unstable}/`.

---

## Table of Contents

1. [Architecture Overview](#architecture-overview)
2. [Module Patterns](#module-patterns)
3. [Step-by-Step: Creating a New Module](#step-by-step-creating-a-new-module)
4. [Option Design Guidelines](#option-design-guidelines)
5. [Common Nix Patterns Reference](#common-nix-patterns-reference)
6. [extraManifests Pattern](#extramanifests-pattern)
7. [Ad-hoc App Bundles (custom)](#ad-hoc-app-bundles-custom)
8. [Available Module Arguments](#available-module-arguments)
9. [Cross-Module Integrations](#cross-module-integrations)
10. [Checklist](#checklist)

---

## Architecture Overview

The module system is built in three layers:

### Layer 1: Base Framework

The base framework lives in `modules/` and provides shared options,
the manifest pipeline, ad-hoc app support, and shared types:

- **`modules/options.nix`** — Declares cross-cutting options:

  ```nix
  options.openkrill = {
    domain = lib.mkOption {
      type = lib.types.str;
      default = "cluster.local";
    };
  };
  ```

  - **`openkrill.domain`** — The base domain for cluster services
    (e.g. `mycompany.com`).  Defaults to `"cluster.local"`.

- **`modules/manifests.nix`** — Declares the manifest pipeline:

  ```nix
  options.openkrill.manifests = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        content = lib.mkOption { type = with lib.types; either attrs (listOf attrs); };
      };
    });
  };
  ```

  Each app module writes K8s resource attrsets to
  `openkrill.manifests.<name>.content`.  Keys are the manifest filename
  (without `.yaml`).  Keys containing `/` create subdirectories — this
  is how `extraManifests` prefixing works (`prometheus/dashboards`
  becomes `prometheus/dashboards.yaml`).

  A single attrset is serialized as-is.  A list of attrsets is wrapped
  in a Kubernetes `v1/List`:

  ```nix
  # Single resource -> one YAML document
  "my-ns".content = {
    apiVersion = "v1";
    kind = "Namespace";
    metadata.name = "my-app";
  };

  # Multiple resources -> Kubernetes List
  "prometheus".content = [
    { apiVersion = "v1"; kind = "ServiceAccount"; ... }
    { apiVersion = "apps/v1"; kind = "Deployment"; ... }
  ];
  ```

  The pipeline then:
  1. Wraps lists of resources as Kubernetes `List` objects.
  2. Serializes each entry to YAML via `pkgs.formats.yaml`.
  4. Commits all YAML files into a bare git repo
     (`openkrill.renderedManifestRepo`) on branch `rendered-manifests`
     with fixed identity and timestamps for reproducibility.  Same
     manifest content produces the same store path — no unnecessary
     rebuilds.
  5. When `openkrill.gitops.enable` is set with method `"gitDaemon"`,
     the module applies `mkForce` to `services.gitDaemon` options —
     consumers don't need to configure git-daemon at all.  The repo
     is placed in the git-daemon path via `systemd.tmpfiles` using
     `L+` (create-or-replace symlink).  On `nixos-rebuild`, if the
     derivation changed, the symlink updates atomically and
     git-daemon serves the new content on its next request.

  The `gitops.method` enum currently only has `"gitDaemon"` but exists
  so other methods (Forgejo, HTTP, etc.) can be added without changing
  the consumer interface.

- **`modules/custom.nix`** — Ad-hoc app bundles (see
  [Ad-hoc App Bundles](#ad-hoc-app-bundles-custom)).

- **`modules/lib/helpers.nix`** — Shared types and helpers for
  `extraManifests` (see [extraManifests Pattern](#extramanifests-pattern)).

### Layer 2: App Modules (`apps/<name>/default.nix`)

Each module declares its own options under `openkrill.apps.<name>` and, when
enabled, populates `openkrill.manifests.<name>.content` with a list of K8s
resource attrsets (Deployments, Services, ConfigMaps, CRDs, etc.).

Modules are **auto-discovered** by `modules/module-list.nix` via `builtins.readDir`.
Every directory under `apps/stable/` and `apps/unstable/` is loaded automatically into every NixOS evaluation,
but produces no resources unless explicitly enabled (guarded by `lib.mkIf cfg.enable`).

### Layer 3: Consumer Configuration

Consumers import the openkrill NixOS module and enable apps in their
`configuration.nix`:

```nix
{ inputs, ... }: {
  imports = [ inputs.openkrill.nixosModules.default ];
  services.openkrill.enable = true;
  openkrill.domain = "mycompany.com";
  openkrill.apps.cert-manager.enable = true;
}
```

### How It All Fits Together

```
flake.nix
  │
  └── nixosModules.default
        │
        ├── _module.args = { charts, kubelib, k8s }
        │
        └── imports ./modules
              ├── openkrill.nix      → services.openkrill (k3s service)
              ├── options.nix        → openkrill.domain
              ├── manifests.nix      → openkrill.manifests pipeline → bare git repo
              ├── custom.nix         → openkrill.apps.custom ad-hoc bundles
              └── module-list.nix    → auto-discovers app modules (in ../apps/{stable,unstable}/) via readDir
                    │
                    └── Each app module:
                          options: openkrill.apps.<name> = { enable, namespace, values, extraManifests, ... }
                          config:  openkrill.manifests.<name>.content = [ ...k8s attrsets... ]

Consumer's configuration.nix:
  imports = [ inputs.openkrill.nixosModules.default ];
  openkrill.apps.cert-manager.enable = true;
  openkrill.apps.cert-manager.values = { ... };
```

Modules that aren't enabled simply produce no resources and are omitted
from the output.

---

## Module Patterns

There are six patterns used across the codebase. Pick the one that fits.

### Pattern 1: Helm-Only (simplest)

Use when: the app is a straightforward Helm chart with no post-processing.

**Examples:** cert-manager, trust-manager

**Structure:**
```
apps/my-app/
  default.nix    # module: options + config
  helm.nix       # Helm chart values -> list of K8s attrsets
```

**`default.nix`:**
```nix
{ config, lib, charts, kubelib, ... }:
let
  cfg = config.openkrill.apps.my-app;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  options.openkrill.apps.my-app = {
    enable = lib.mkEnableOption "My App";

    namespace = lib.mkOption {
      type = lib.types.str;
      default = "my-app";
    };

    values = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = lib.mkIf cfg.enable {
    openkrill.manifests.my-app.content = import ./helm.nix {
      inherit lib charts kubelib cfg;
    };
  };
}
```

**`helm.nix`:**
```nix
{ lib, charts, kubelib, cfg }:
let
  defaults = {
    ingress.enabled = false;
    # ... chart values ...
  };
in
kubelib.fromHelm {
  name = "my-app";
  chart = charts.<repo>.<chart>.latest;
  namespace = cfg.namespace;
  values = lib.recursiveUpdate defaults cfg.values;
}
```

`kubelib.fromHelm` returns a list of K8s resource attrsets. That list is
assigned directly to `openkrill.manifests.my-app.content`.

The `values` option allows the consumer to override or extend any
nested helm value without modifying the module itself. Module defaults are
defined in the `defaults` let-binding inside `helm.nix`, and
`lib.recursiveUpdate` deep-merges `cfg.values` on top of those defaults.
This means the caller only needs to specify the keys they want to change.

### Pattern 2: Helm + Post-Processing

Use when: the Helm chart output needs patching (e.g. injecting env vars,
fixing missing namespaces, mounting CA certs).

**Examples:** argocd, authelia, opencloud

**`helm.nix` with post-processing:**
```nix
{ lib, charts, kubelib, cfg }:
let
  defaults = { ... };

  rawHelm = kubelib.fromHelm {
    name = "my-app";
    chart = charts.<repo>.<chart>.latest;
    namespace = cfg.namespace;
    values = lib.recursiveUpdate defaults cfg.values;
  };

  # Ensure every resource has a namespace (some charts omit it)
  setNamespace = r: r // {
    metadata = (r.metadata or {}) // { namespace = cfg.namespace; };
  };

  # Inject an env var into all Deployments
  patchDeployment = r:
    if (r.kind or "") == "Deployment" then
      r // {
        spec = r.spec // {
          template = r.spec.template // {
            spec = r.spec.template.spec // {
              containers = map (c: c // {
                env = (c.env or []) ++ [
                  { name = "MY_VAR"; value = "my-value"; }
                ];
              }) r.spec.template.spec.containers;
            };
          };
        };
      }
    else r;

in
map (r: patchDeployment (setNamespace r)) rawHelm
```

**Common post-processing operations:**

| Operation | Pattern |
|-----------|---------|
| Set namespace on all resources | `map setNamespace resources` |
| Inject env vars into Deployments | `map patchDeployment resources` where patchDeployment drills into `spec.template.spec.containers` |
| Add volumes/volumeMounts | Same drill-down pattern, appending to `volumes` and `volumeMounts` lists |
| Fix null lists from Helm | `orEmpty = v: if v == null then [] else v;` then use `(orEmpty (c.env or null)) ++ newVars` |
| Prepend extra resources | `[ myConfigMap ] ++ helmResources` |
| Chain multiple transforms | `map (r: transform2 (transform1 r)) rawHelm` or compose named functions |

### Pattern 3: Raw Resources (no Helm)

Use when: the resources are simple enough to declare as Nix attrsets directly,
or you're passing through raw attrsets from the config.

**Examples:** opencloud (generates all K8s resources as pure Nix attrsets
in `resources.nix` with no Helm chart involved)

**`default.nix` (passthrough pattern):**
```nix
{ config, lib, charts, kubelib, ... }:
let
  cfg = config.openkrill.apps.my-policies;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  options.openkrill.apps.my-policies = {
    enable = lib.mkEnableOption "My policies";

    policies = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      default = [];
      description = "List of raw K8s policy resource attrsets.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = lib.mkIf cfg.enable {
    openkrill.manifests.my-policies.content = cfg.policies;
  };
}
```

The consumer then passes the actual resource attrsets:

```nix
openkrill.apps.my-policies = {
  enable = true;
  policies = [
    {
      apiVersion = "cilium.io/v2";
      kind = "CiliumNetworkPolicy";
      metadata = { name = "my-policy"; namespace = "my-ns"; };
      spec = { ... };
    }
  ];
};
```

**`default.nix` (pure resources pattern, like opencloud):**
```nix
{ config, lib, charts, kubelib, ... }:
let
  cfg = config.openkrill.apps.my-app;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  options.openkrill.apps.my-app = {
    enable = lib.mkEnableOption "My App";
    namespace = lib.mkOption { type = lib.types.str; default = "my-app"; };
    domain = lib.mkOption { type = lib.types.str; };
    # ... more options ...

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = lib.mkIf cfg.enable {
    openkrill.manifests.my-app.content = import ./resources.nix { inherit cfg; };
  };
}
```

Where `resources.nix` returns a list of hand-crafted K8s resource attrsets.

### Pattern 4: Helm + Conditional Extras

Use when: the module has optional features that add extra K8s resources
(e.g. a setup Job, a seed script).

**`default.nix`:**
```nix
config = lib.mkIf cfg.enable {
  openkrill.manifests.my-app.content =
    (import ./helm.nix { inherit lib charts kubelib cfg; })
    ++ (lib.optionals cfg.oidc.enable (import ./oidc-setup.nix { inherit cfg; }));
};
```

The extra file (e.g. `oidc-setup.nix`) takes `{ cfg }` and returns a list
of K8s resource attrsets (typically a Job, ConfigMap, etc.).

### Pattern 5: Submodule (attrsOf submodule)

Use when: the module manages a dynamic collection of similar things
(databases, runner instances, etc.).

**Examples:** cloudnative-pg (databases)

**`default.nix` with submodule:**
```nix
{ config, lib, charts, kubelib, ... }:
let
  cfg = config.openkrill.apps.my-app;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };

  mkResource = name: sub: {
    apiVersion = "example.io/v1";
    kind = "MyResource";
    metadata = { inherit name; namespace = sub.namespace; };
    spec = { size = sub.size; };
  };
in
{
  options.openkrill.apps.my-app = {
    enable = lib.mkEnableOption "My App";

    things = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule ({ name, ... }: {
        options = {
          namespace = lib.mkOption { type = lib.types.str; };
          size = lib.mkOption {
            type = lib.types.str;
            default = "5Gi";
          };
        };
      }));
      default = {};
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = lib.mkIf cfg.enable {
    openkrill.manifests.my-app.content =
      (import ./helm.nix { inherit lib charts kubelib cfg; })
      ++ (lib.mapAttrsToList mkResource cfg.things);
  };
}
```

Use `lib.mapAttrsToList` to turn the submodule attrset into a list of
resources. Use `lib.concatLists (lib.mapAttrsToList ...)` if each entry
produces multiple resources.

Useful submodule patterns:

| Pattern | Use |
|---------|-----|
| `lib.types.nullOr lib.types.str` | Optional string (e.g. credentialSecretName that defaults to null) |
| `lib.optionalAttrs (x != null) { ... }` | Conditionally include an attrset field |
| `lib.filterAttrs (_: v: v.enable) cfg.things` | Filter to only enabled sub-items |
| Default derived from key: `default = "${name}-pg"` | The `name` arg in the submodule function is the attrset key |

### Pattern 6: App-Template (typed generic chart)

Use when: the app is deployed via the bjw-s `app-template` Helm chart
and you want typed values instead of `types.attrs`.

**Examples:** theia-ide

**`default.nix`:**
```nix
{ config, lib, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.my-app;
  helpers     = import ../../../modules/lib/helpers.nix { inherit lib; };
  appTemplate = import ../../../modules/lib/app-template.nix { inherit lib; };

  chart = kubelib.extractChart (kubelib.fetchChart {
    repo = "https://bjw-s-labs.github.io/helm-charts/";
    chart = "app-template";
    version = "4.6.2";
    chartHash = "sha256-AAAA...";
  });

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
    namespace = mkOption { type = types.str; default = "my-app"; };
    values = mkOption {
      type = appTemplate.valuesType;
      default = {};
      description = "app-template Helm chart values (typed).";
    };
    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    openkrill.manifests.my-app.content = kubelib.fromHelm {
      name = "my-app";
      inherit chart;
      namespace = cfg.namespace;
      values = recursiveUpdate defaults cfg.values;
    };
  };
}
```

The `appTemplate.valuesType` submodule provides typed options for
controllers, services, persistence, ingress, etc. with `freeformType`
passthrough so unknown keys still work.  See
[nix-module-app-template.md](./nix-module-app-template.md) for full
details and regeneration instructions.

---

## Step-by-Step: Creating a New Module

### 1. Create the directory

```sh
mkdir -p apps/my-app
```

### 2. Write `default.nix`

Start from the Helm-only skeleton (Pattern 1) and adjust:

```nix
# apps/my-app — Short description
{ config, lib, charts, kubelib, ... }:
let
  cfg = config.openkrill.apps.my-app;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
in
{
  options.openkrill.apps.my-app = {
    enable = lib.mkEnableOption "My App description";

    namespace = lib.mkOption {
      type = lib.types.str;
      default = "my-app";
    };

    values = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;

    # Add app-specific options here
  };

  config = lib.mkIf cfg.enable {
    openkrill.manifests.my-app.content = import ./helm.nix {
      inherit lib charts kubelib cfg;
    };
  };
}
```

If you need `pkgs` (for `pkgs.fetchurl`, `pkgs.runCommand`, `pkgs.lib`,
etc.), add it to the module function args:

```nix
{ config, lib, pkgs, charts, kubelib, ... }:
```

If you need `config.openkrill.domain`, access it in the config block and pass
it to helm.nix:

```nix
config = lib.mkIf cfg.enable {
  openkrill.manifests.my-app.content = import ./helm.nix {
    inherit charts kubelib cfg;
    clusterDomain = config.openkrill.domain;
  };
};
```

### 3. Write `helm.nix`

```nix
{ lib, charts, kubelib, cfg }:
let
  defaults = {
    # Helm chart values, parameterized by cfg.*
    ingress.enabled = false;
  };
in
kubelib.fromHelm {
  name = "my-app";
  chart = charts.<repo>.<chart>.latest;
  namespace = cfg.namespace;
  values = lib.recursiveUpdate defaults cfg.values;
}
```

For charts not in nixhelm, use `kubelib.fetchChart` + `kubelib.extractChart`:

```nix
{ lib, charts, kubelib, cfg }:
let
  chart = kubelib.extractChart (kubelib.fetchChart {
    repo = "https://example.com/charts";
    chart = "my-chart";
    version = "1.0.0";
    chartHash = "sha256-AAAA...";
  });
in
kubelib.fromHelm {
  name = "my-app";
  inherit chart;
  namespace = cfg.namespace;
  values = { ... };
}
```

### 4. Auto-discovery

App modules are auto-discovered by `modules/module-list.nix` via `builtins.readDir`
-- no manual registration is needed. Just create your directory under `apps/stable/` or `apps/unstable/` and it
will be picked up automatically.

Since the module is guarded by `lib.mkIf cfg.enable`, it produces no
resources unless explicitly enabled in a consumer's configuration.

### 5. Enable in consumer configuration

In the consumer's `configuration.nix`:

```nix
# ── My App ───────────────────────────────────────────────────────
openkrill.apps.my-app = {
  enable = true;
  # set any required options
};
```

### 6. Add ArgoCD Application CR

Each module declares its own ArgoCD Application CR so ArgoCD knows to
sync it from the git-daemon manifest repo.  See
[argocd.md](./argocd.md) for the full pattern.

```nix
config = lib.mkIf cfg.enable {
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

  openkrill.manifests.my-app.content = import ./helm.nix { inherit lib charts kubelib cfg; };
};
```

Add `"ServerSideApply=true"` to `syncOptions` if the module includes CRDs.

### 7. Stage files for flake visibility

Nix flakes only see files tracked by git. Stage your new files:

```sh
git add apps/my-app/
```

### 8. Test

```sh
# Run the full test suite:
bin/test

# This runs `nix flake check`, which exercises the NixOS VM
# integration test (boots k3s, verifies the node is Ready).
```

---

## Option Design Guidelines

### What to parameterize

- **Always parameterize:** `enable`, `namespace`, `values`, `extraManifests`
- **Parameterize if it varies per-deployment:** domain names, CA cert paths,
  database connection details, OIDC endpoints, persistence sizes
- **Parameterize if it's a meaningful behavioral switch:** feature flags
  (e.g. `oidc.enable`), enum modes

### What to hardcode

- **Helm chart references** (`charts.<repo>.<chart>.latest`) — these change
  via nixhelm flake input, not per-deployment
- **Container images** from the chart (the chart controls these)
- **Internal wiring** (service names like
  `my-app.my-app.svc.cluster.local`) — these are determined by the Helm
  chart and namespace
- **Scrape intervals, retention periods, replica counts** — unless you have
  a concrete reason to vary them across deployments

### Option types reference

| Type | Use for |
|------|---------|
| `lib.types.str` | Domain names, namespace names, secret names |
| `lib.types.int` | Replica counts, port numbers |
| `lib.types.bool` | Feature flags (prefer `mkEnableOption` for `enable`) |
| `lib.types.path` | File paths (CA certs, config files) — evaluated at nix eval time |
| `lib.types.enum [...]` | Fixed set of choices |
| `lib.types.listOf lib.types.str` | Lists of domains, SQL statements |
| `lib.types.listOf lib.types.attrs` | Lists of raw K8s resource attrsets |
| `lib.types.attrs` | Single raw K8s resource attrset |
| `lib.types.attrsOf (lib.types.submodule ...)` | Dynamic collections |
| `lib.types.nullOr lib.types.str` | Optional values that default to null |

---

## Common Nix Patterns Reference

### Guard the config block

Every module wraps its config in `lib.mkIf`:

```nix
config = lib.mkIf cfg.enable {
  openkrill.manifests.my-app.content = [ ... ];
};
```

### Conditional resources

Append extra resources only when a feature is enabled:

```nix
my-app.content =
  (import ./helm.nix { inherit lib charts kubelib cfg; })
  ++ (lib.optionals cfg.feature.enable (import ./feature.nix { inherit cfg; }));
```

### Conditional attrset fields

Include a field only when a value is non-null or non-empty:

```nix
spec = {
  instances = 1;
}
// lib.optionalAttrs (secretName != null) {
  secret.name = secretName;
}
// lib.optionalAttrs (initSQL != []) {
  postInitSQL = initSQL;
};
```

### Read files at eval time

```nix
caCert = builtins.readFile cfg.caCertFile;
```

This embeds the file contents into the Nix expression. Use `lib.types.path`
for the option type.

### Null coercion for Helm output

Helm renders missing YAML lists as `null`. Coerce to empty list:

```nix
orEmpty = v: if v == null then [] else v;

# Usage:
env = (orEmpty (c.env or null)) ++ newEnvVars;
```

### Generate resources from a submodule

```nix
lib.mapAttrsToList (name: sub: {
  apiVersion = "...";
  kind = "...";
  metadata = { inherit name; namespace = sub.namespace; };
  spec = { ... };
}) cfg.things
```

If each entry produces multiple resources, flatten with:

```nix
lib.concatLists (lib.mapAttrsToList (name: sub:
  import ./thing.nix { inherit cfg name sub; }
) cfg.things)
```

### Filter enabled items in a submodule

```nix
enabledThings = lib.filterAttrs (_: v: v.enable) cfg.things;
```

### Indexed iteration

```nix
lib.imap0 (i: item: "${toString i}: ${item}") myList
```

---

## extraManifests Pattern

Every app module includes an `extraManifests` option that lets consumers
inject additional K8s resources alongside the module's main manifests,
without modifying the module itself.

### How it works

The shared helpers in `modules/lib/helpers.nix` provide:

- **`helpers.mkExtraManifestsOption`** — The option declaration. Produces
  an `attrsOf` option where each key is a manifest name and each value is
  either a single resource attrset or a list of resource attrsets.

- **`helpers.mkExtraManifestsConfig`** — Takes a prefix and the
  `extraManifests` attrset, fans each key into
  `openkrill.manifests."<prefix>/<key>"`. This is used centrally by
  `modules/manifests.nix` — individual app modules don't need to call it.
  Each key is prefixed with the app name to avoid collisions
  (e.g. `cert-manager/my-issuer`).  Since manifest keys containing `/`
  create subdirectories in the rendered repo, extra manifests end up
  namespaced under their app's directory
  (e.g. `cert-manager/my-issuer.yaml`).

### Module-side usage

In every module's options block, declare the `extraManifests` option.
The fan-out into `openkrill.manifests` is handled centrally by
`modules/manifests.nix` — no per-module wiring needed:

```nix
helpers = import ../../../modules/lib/helpers.nix { inherit lib; };

# In options:
extraManifests = helpers.mkExtraManifestsOption;

# In config — just set your manifest content directly:
config = lib.mkIf cfg.enable {
  openkrill.manifests.my-app.content = ...;
};
```

### Consumer-side usage

```nix
openkrill.apps.cert-manager = {
  enable = true;
  extraManifests = {
    letsencrypt-issuer = {
      apiVersion = "cert-manager.io/v1";
      kind = "ClusterIssuer";
      metadata.name = "letsencrypt";
      spec.acme = {
        server = "https://acme-v02.api.letsencrypt.org/directory";
        # ...
      };
    };
  };
};
```

This creates `openkrill.manifests."cert-manager/letsencrypt-issuer"` with
the given resource as its content.

---

## Ad-hoc App Bundles (custom)

`modules/custom.nix` provides `openkrill.apps.custom` — a way to group
related manifests under a name with an enable flag, without writing a
full NixOS module.

### Usage

```nix
openkrill.apps.custom.my-thing = {
  enable = true;
  manifests = {
    deployment = {
      apiVersion = "apps/v1";
      kind = "Deployment";
      metadata = { name = "my-thing"; namespace = "my-thing"; };
      spec = { ... };
    };
    service = {
      apiVersion = "v1";
      kind = "Service";
      metadata = { name = "my-thing"; namespace = "my-thing"; };
      spec = { ... };
    };
  };
};
```

Each key in `manifests` becomes a manifest name prefixed with the app name
(e.g. `openkrill.manifests."my-thing/deployment"`,
`openkrill.manifests."my-thing/service"`).  Disabling the app disables all
its manifests at once.

### When to use custom vs. a full module

| Situation | Use |
|-----------|-----|
| Quick one-off resources, no Helm chart | `openkrill.apps.custom` |
| Needs Helm chart rendering | Full module (Pattern 1+) |
| Needs typed options, validation, defaults | Full module |
| Shared across multiple deployments | Full module |

---

## Available Module Arguments

These are injected into every module via `_module.args` in `flake.nix`:

### `kubelib`

From nixhelm2's `lib/default.nix`. Key functions:

| Function | Returns | Use |
|----------|---------|-----|
| `kubelib.fromHelm { name, chart, namespace, values, extraOpts? }` | `listOf attrs` | Render a Helm chart to a list of K8s resource attrsets |
| `kubelib.fetchChart { repo, chart, version, chartHash }` | `derivation` | Download a chart tarball (`.tgz`) not tracked in nixhelm |
| `kubelib.extractChart tarball` | `derivation` | Extract a chart tarball into a directory for `helm template` |
| `kubelib.applyValues { chart, name, namespace?, values?, ... }` | `derivation` | Run `helm template` on an extracted chart, producing rendered YAML |
| `kubelib.fromYAML yamlString` | `listOf attrs` | Parse a multi-document YAML string into Nix attrsets |

`kubelib.fromHelm` accepts an optional `extraOpts` parameter (list of
strings) for additional Helm flags, e.g.
`extraOpts = ["--skip-schema-validation"]`.

### `charts`

From the `nixhelm2` flake input (`nixhelm.charts.${pkgs.system}`).
An attrset of all Helm charts keyed by `<repo>.<chart>`. Each chart has
`.latest` and `.versions."X.Y.Z"` attributes:

```nix
charts.jetstack.cert-manager.latest
charts.argoproj.argo-cd.latest
charts.cloudnative-pg.cloudnative-pg.latest

# Pin a specific version:
charts.jetstack.cert-manager.versions."1.17.2"
```

### `k8s`

Produced by `lib/k8s.nix`. Helper constructors for common K8s resources:

| Function | Returns | Use |
|----------|---------|-----|
| `k8s.mkApp { name, path, namespace?, project?, targetRevision?, serverSideApply? }` | `attrs` | Create an ArgoCD Application resource |
| `k8s.mkNamespace name` | `attrs` | Create a Namespace resource |
| `k8s.mkSecret { name, namespace, stringData }` | `attrs` | Create an Opaque Secret |
| `k8s.mkIngress { name, namespace, host, serviceName, servicePort, tlsSecretName?, ingressClass? }` | `attrs` | Create an Ingress with optional cert-manager TLS |

### `pkgs`

The full nixpkgs package set. Available as a module arg:

```nix
{ config, lib, pkgs, charts, kubelib, ... }:
```

Commonly used for:
- `pkgs.fetchurl` (fetching chart tarballs)
- `pkgs.runCommand` (unpacking/patching charts)
- `pkgs.lib` (when you need `lib` inside `helm.nix` which doesn't get it as an arg)

### `config`

The evaluated module config. Access other modules' options:

```nix
clusterDomain = config.openkrill.domain;
otherAppEnabled = config.openkrill.apps.other.enable;
```

---

## Cross-Module Integrations

App modules participate in several cross-module aggregation patterns.
Each pattern follows the same structure: the app module declares what
it needs under a shared option namespace, and a central module assembles
the result.

When creating a new app module, wire up the applicable integrations
from this table:

| Integration | Option Path | Required? | Spec |
|-------------|------------|:---------:|------|
| ArgoCD Application | `openkrill.apps.argocd.applications.<name>` | yes | [argocd.md](./argocd.md) |
| Network Policy | `openkrill.apps.<name>.networkPolicy` | yes | [network-policies.md](./network-policies.md) |
| Secrets | `openkrill.secrets.generators.<name>`, `openkrill.apps.external-secrets.secrets.<name>` | if needed | [secrets.md](./secrets.md) |
| Ingress Routes | `openkrill.ingress.routes.<name>` | if web UI | [ingress.md](./ingress.md) |
| Monitoring | `openkrill.apps.victoriametrics.vmservicescrapes.<name>`, `.vmrules.<name>` | if metrics | [monitoring.md](./monitoring.md) |
| Databases | `openkrill.apps.cloudnative-pg.databases.<name>` | if PostgreSQL | — |
| OIDC Clients | `openkrill.apps.authelia.oidcClients.<name>` | if SSO | — |

**ArgoCD** and **Network Policy** are required for every app module.
The rest depend on what the app needs.

All cross-module declarations are placed in the app's `config` block,
guarded by `mkIf` on the target module's `enable` flag.  For example,
monitoring declarations use
`mkIf config.openkrill.apps.victoriametrics.enable` so they are only
evaluated when VictoriaMetrics is enabled.

---

## Checklist

Before submitting a new module:

- [ ] Directory created: `apps/<name>/`
- [ ] App module auto-discovered via `modules/module-list.nix` (no manual registration needed)
- [ ] `default.nix` has `options` and `config` sections
- [ ] Every option has a type; required options have no default
- [ ] `values` option declared (type `lib.types.attrs`, default `{}`) for helm-based modules
- [ ] `extraManifests` option declared via `helpers.mkExtraManifestsOption`
- [ ] `config` block is guarded with `lib.mkIf cfg.enable`
- [ ] `config` block sets `openkrill.manifests.<name>.content` directly (extraManifests fan-out is centralized)
- [ ] `helm.nix` uses `lib.recursiveUpdate defaults cfg.values` for the `values` arg
- [ ] `helm.nix` (or `resources.nix`) returns a list of K8s resource attrsets
- [ ] ArgoCD Application CR declared via `openkrill.apps.argocd.applications.<name>` (see [argocd.md](./argocd.md))
- [ ] Ingress route declared if app has a web UI (see [ingress.md](./ingress.md))
- [ ] Monitoring declared if app exposes metrics (see [monitoring.md](./monitoring.md))
- [ ] Config enabled in consumer's `configuration.nix`
- [ ] Files staged: `git add apps/<name>/`
- [ ] `bin/test` passes (`nix flake check`)
- [ ] No CNPG Cluster resources emitted by the app module (use cloudnative-pg module instead)
