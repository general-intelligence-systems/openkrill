# Creating a CRD Module

For when you have a CRD specification and want a typed openkrill module that generates custom resource instances. No Helm chart involved -- the controller is assumed to be already running.

Reference implementations: `apps/stable/helm/default.nix`, `apps/stable/traefik/default.nix`.

## Step 1: Read the CRD

From the CRD spec (Go types, OpenAPI schema, or YAML definition), extract:

- **`apiVersion`** and **`kind`** -- hardcoded in the resource builder.
- **`spec` fields** -- each becomes a submodule option.
- **Required vs optional** -- required fields have no default. Optional fields use `nullOr`, `[]`, `{}`, or `false` as defaults.
- **Nested objects** -- become sub-submodules or passthrough (`attrsOf anything`).
- **Resource references** -- objects with `name` + optional `namespace` are a common sub-submodule pattern.

If the CRD defines multiple `kind`s (e.g. HelmChart and HelmChartConfig), create one `attrsOf submodule` option per kind.

## Step 2: Map CRD fields to Nix types

| CRD field type | Nix type | Default |
|----------------|----------|---------|
| required string | `types.str` | (none) |
| optional string | `types.nullOr types.str` | `null` |
| required integer | `types.int` | (none) |
| optional integer | `types.nullOr types.int` | `null` |
| boolean (defaults false) | `types.bool` | `false` |
| optional boolean | `types.nullOr types.bool` | `null` |
| enum | `types.enum [ "a" "b" ]` | first value or (none) |
| required list | `types.listOf types.<inner>` | (none) |
| optional list | `types.listOf types.<inner>` | `[]` |
| nested object (structured) | `types.submodule { ... }` | — |
| nested object (freeform) | `types.attrsOf types.anything` | `{}` |
| array of objects | `types.listOf (types.submodule ...)` | `[]` |
| name + optional namespace ref | sub-submodule (see below) | — |

Resource reference pattern (reusable across the module):

```nix
refModule = types.submodule {
  options = {
    name = mkOption { type = types.str; };
    namespace = mkOption {
      type = types.nullOr types.str;
      default = null;
    };
  };
};
```

## Step 3: Type vs passthrough

Type the fields users will configure structurally -- routes, services, TLS blocks, resource references. These benefit from validation and tab-completion.

Use `types.attrsOf types.anything` for specs that are polymorphic -- where the CRD has many mutually exclusive keys and typing every variant is impractical. Examples:

- **Typed:** Traefik IngressRoute routes, services, TLS (`apps/stable/traefik/default.nix`)
- **Passthrough:** Traefik Middleware spec -- dozens of mutually exclusive middleware types (`spec.headers`, `spec.rateLimit`, `spec.forwardAuth`, etc.)
- **Typed:** HelmChart spec -- every field is well-defined and commonly used (`apps/stable/helm/default.nix`)

When in doubt, type it. Passthrough is a last resort for genuinely polymorphic specs.

## Step 4: Scaffold the module

```nix
# apps/my-crd/default.nix — MyCRD resources
# Generates example.io/v1 MyCRD custom resources.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps.my-crd;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };

  # ── Sub-submodules ───────────────────────────────────────────────

  innerModule = types.submodule {
    options = {
      name = mkOption { type = types.str; };
      value = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
    };
  };

  # ── Top-level CRD submodule ──────────────────────────────────────

  myCrdModule = types.submodule ({ name, ... }: {
    options = {
      namespace = mkOption {
        type = types.str;
        description = "Namespace for this resource.";
      };

      requiredField = mkOption {
        type = types.str;
        description = "A required spec field.";
      };

      optionalField = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "An optional spec field.";
      };

      items = mkOption {
        type = types.listOf innerModule;
        default = [];
        description = "List of nested objects.";
      };
    };
  });

  # ── Resource builder ─────────────────────────────────────────────

  # Remove null values from an attrset (one level deep)
  compact = filterAttrs (_: v: v != null);

  mkInner = item: compact {
    inherit (item) name value;
  };

  mkMyCrd = name: res: {
    apiVersion = "example.io/v1";
    kind = "MyCRD";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
      inherit (res) requiredField;
    }
    // optionalAttrs (res.optionalField != null) {
      inherit (res) optionalField;
    }
    // optionalAttrs (res.items != []) {
      items = map mkInner res.items;
    };
  };

  allResources = mapAttrsToList mkMyCrd cfg.resources;
in
{
  options.openkrill.apps.my-crd = {
    enable = mkEnableOption "MyCRD resources";

    resources = mkOption {
      type = types.attrsOf myCrdModule;
      default = {};
      description = "MyCRD instances.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    openkrill.manifests.my-crd.content = allResources;
  };
}
```

### Omitting optional fields

Two patterns for keeping generated YAML clean:

```nix
# For individual nullable fields — use optionalAttrs
// optionalAttrs (res.timeout != null) { inherit (res) timeout; }
// optionalAttrs (res.items != []) { items = map mkItem res.items; }
// optionalAttrs res.bootstrap { inherit (res) bootstrap; }

# For objects with many nullable fields — use compact (filterAttrs)
compact = filterAttrs (_: v: v != null);

mkRef = ref: compact {
  inherit (ref) name namespace port;
};
```

Use `optionalAttrs` when mixing required and optional fields. Use `compact` for sub-objects where most fields are optional.

## Step 5: Register and test

### Auto-discovery

App modules are auto-discovered by `modules/module-list.nix` via `builtins.readDir`
-- no manual registration is needed. Just create your directory under `apps/stable/` or `apps/unstable/`.

### Write the smoke test

Create `tests/my-crd-module-test.nix`:

```nix
{ pkgs }:
let
  lib = pkgs.lib;

  manifestsStub = { lib, ... }: {
    options.openkrill.manifests = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          enable  = lib.mkOption { type = lib.types.bool; default = true; };
          content = lib.mkOption { type = with lib.types; either attrs (listOf attrs); };
        };
      });
      default = {};
    };
  };

  eval = lib.evalModules {
    modules = [
      manifestsStub
      ../apps/my-crd/default.nix
      {
        config.openkrill.apps.my-crd = {
          enable = true;
          resources.example = {
            namespace = "default";
            requiredField = "hello";
            items = [ { name = "item1"; } ];
          };
        };
      }
    ];
  };

  content = builtins.toJSON eval.config.openkrill.manifests.my-crd.content;
in
pkgs.runCommand "my-crd-module-test" {} ''
  echo ${lib.escapeShellArg content} > $out
''
```

### Add the check to `flake.nix`

```nix
checks = forAllSystems (system:
  let pkgs = import nixpkgs { inherit system; };
  in {
    # ...existing checks...
    my-crd-module-test = import ./tests/my-crd-module-test.nix {
      inherit pkgs;
    };
  }
);
```

## Checklist

- [ ] CRD `apiVersion` and `kind` identified
- [ ] Each CRD kind has an `attrsOf submodule` option
- [ ] Required spec fields have no default
- [ ] Optional fields use `nullOr`/`[]`/`false` defaults
- [ ] Resource builder uses `optionalAttrs`/`compact` to omit unset fields
- [ ] App module auto-discovered via `modules/module-list.nix` (no manual registration needed)
- [ ] Smoke test evaluates representative config via `evalModules` + `toJSON`
- [ ] Check registered in `flake.nix`
- [ ] `git add` and `bin/test` passes
