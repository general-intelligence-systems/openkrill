# Custom Apps

## Location

`modules/custom.nix`

## Overview

`openkrill.apps.custom` lets users group related manifests under a name with an enable flag — without writing a NixOS module. It's the middle ground between raw `openkrill.manifests` (no grouping) and a full app module (typed options, helm charts).

## Option shape

```nix
openkrill.apps.custom = mkOption {
  type = types.attrsOf (types.submodule {
    options = {
      enable = mkOption { type = types.bool; default = true; };
      manifests = mkOption {
        type = types.attrsOf manifestContentType;
        default = { };
      };
    };
  });
};
```

The outer key is the app name. The inner `manifests` keys become manifest names prefixed with the app name.

## How it works

The config block filters to enabled apps and uses `helpers.mkExtraManifestsConfig` to prefix each manifest with the app name:

```nix
config.openkrill.manifests = mkMerge (
  mapAttrsToList (appName: app:
    helpers.mkExtraManifestsConfig appName app.manifests
  ) enabledApps
);
```

So `openkrill.apps.custom.redis.manifests.deployment` becomes `openkrill.manifests."redis/deployment".content`.

## Usage

```nix
openkrill.apps.custom.redis = {
  enable = true;
  manifests = {
    namespace = { apiVersion = "v1"; kind = "Namespace"; ... };
    deployment = { apiVersion = "apps/v1"; kind = "Deployment"; ... };
    service = { apiVersion = "v1"; kind = "Service"; ... };
  };
};
```

Disable everything at once:

```nix
openkrill.apps.custom.redis.enable = false;
```

## Manifest repo output

```
redis/namespace.yaml
redis/deployment.yaml
redis/service.yaml
```

## When to use custom vs a full module

Use `apps.custom` when:

- You have a handful of static manifests to group together
- No typed validation is needed beyond valid Nix attrsets
- No helm chart rendering is involved
- No cross-module wiring is needed

Graduate to a full module when:

- You want typed options (`replicas`, `image`, `host`, etc.)
- You need `kubelib.fromHelm` to render a chart
- You need cross-module references (`config.openkrill.apps.prometheus.enable`)
- The app definition will be reused across environments
