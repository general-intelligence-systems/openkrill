# Creating a Helm Module

The simplest module type. One helm chart, a `values` option, and `extraManifests`. Use existing modules as the reference implementation.

## Step 1: Create the file

Create `apps/<my-app>/default.nix`.

## Step 2: Scaffold the module

Every helm module follows this exact structure:

```nix
# apps/my-app/default.nix

{ config, lib, charts, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.myApp;
  helpers = import ../../modules/lib/helpers.nix { inherit lib; };
in
{
  options.openkrill.apps.myApp = {
    enable = mkEnableOption "my app";

    values = mkOption {
      type = types.attrsOf types.anything;
      default = { };
      description = "Helm values for my-app.";
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
        namespace = "my-app";
      };
      syncPolicy = {
        automated = { prune = true; selfHeal = true; };
        syncOptions = [ "CreateNamespace=true" ];
      };
    };

    openkrill.manifests."my-app".content =
      kubelib.fromHelm {
        name = "my-app";
        chart = charts.my-repo.my-chart.latest;
        namespace = "my-app";
        values = cfg.values;
      };

    openkrill.manifests."my-app-ns".content = {
      apiVersion = "v1";
      kind = "Namespace";
      metadata.name = "my-app";
    };
  };
}
```

## Step 3: Auto-discovery

App modules are auto-discovered by `modules/module-list.nix` via `builtins.readDir`
-- no manual registration is needed. Just create your directory under `apps/` and it
will be picked up automatically.

## Required elements

Every module **must** have:

- `enable` via `mkEnableOption`
- `values` as `types.attrsOf types.anything`
- `extraManifests = helpers.mkExtraManifestsOption`
- `config` block guarded by `mkIf cfg.enable`
- Manifests written directly to `openkrill.manifests.<name>.content`
- `extraManifests` fan-out is handled centrally by `modules/manifests.nix`

## Chart references

Charts come from nixhelm2 via the `charts` module argument. Each chart has `.latest` (the latest stable version) and `.versions."X.Y.Z"` attributes:

```
charts.prometheus-community.kube-prometheus-stack.latest
charts.jetstack.cert-manager.latest
charts.ingress-nginx.ingress-nginx.latest
charts.cloudnative-pg.cloudnative-pg.latest

# Or pin a specific version:
charts.jetstack.cert-manager.versions."1.17.2"
```

Find available charts at https://github.com/general-intelligence-systems/nixhelm2.

## kubelib.fromHelm

Runs `helm template` at build time. Returns a list of parsed k8s resource attrsets.

```nix
kubelib.fromHelm {
  name = "release-name";              # helm release name
  chart = charts.repo.chart.latest;   # chart derivation
  namespace = "target-ns";            # --namespace flag
  values = { ... };                   # values.yaml equivalent
}
```

The return value goes directly into `.content`. Since it's a list, `manifests.nix` wraps it in a Kubernetes List when serializing to YAML.

## Namespace manifests

Always create the namespace explicitly as a separate manifest. Don't rely on `helm template` to create it — the namespace resource needs to exist in the git repo as its own file.

```nix
"my-app-ns".content = {
  apiVersion = "v1";
  kind = "Namespace";
  metadata.name = "my-app";
};
```

## Merging default values

To set defaults that the user can override via `values`:

```nix
values = { someDefault = true; } // cfg.values;
```

The user's `values` wins because `//` is right-biased. For deep merging use `lib.recursiveUpdate`:

```nix
values = recursiveUpdate { nested.default = true; } cfg.values;
```

## Cross-module references

Other modules can check your app's enable state:

```nix
default = config.openkrill.apps.myApp.enable or false;
```

This pattern is used for auto-enabling monitoring. If your app exposes metrics, document that other modules can key off `config.openkrill.apps.myApp.enable`.
