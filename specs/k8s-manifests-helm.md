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

    openkrill.manifests = mkMerge [
      {
        "my-app".content =
          kubelib.fromHelm {
            name = "my-app";
            chart = charts.my-repo.my-chart;
            namespace = "my-app";
            values = cfg.values;
          };

        "my-app-ns".content = {
          apiVersion = "v1";
          kind = "Namespace";
          metadata.name = "my-app";
        };
      }
      (helpers.mkExtraManifestsConfig "my-app" cfg.extraManifests)
    ];
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
- Manifests written to `openkrill.manifests` via `mkMerge`
- `helpers.mkExtraManifestsConfig` as the last entry in the merge

## Chart references

Charts come from nixhelm via the `charts` module argument. The path matches the nixhelm repository structure:

```
charts.prometheus-community.kube-prometheus-stack
charts.jetstack.cert-manager
charts.ingress-nginx.ingress-nginx
charts.cloudnative-pg.cloudnative-pg
```

Find available charts at https://github.com/farcaller/nixhelm.

## kubelib.fromHelm

Runs `helm template` at build time. Returns a list of parsed k8s resource attrsets.

```nix
kubelib.fromHelm {
  name = "release-name";       # helm release name
  chart = charts.repo.chart;   # chart derivation
  namespace = "target-ns";     # --namespace flag
  values = { ... };            # values.yaml equivalent
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
