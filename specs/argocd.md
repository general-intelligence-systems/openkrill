# ArgoCD Bootstrap & Application Pattern

How ArgoCD gets into the cluster and how each app module declares its
ArgoCD Application CR.

---

## Table of Contents

1. [Bootstrap](#bootstrap)
2. [Application CR Pattern](#application-cr-pattern)
3. [ServerSideApply](#serversideapply)
4. [Cluster-Scoped Resources](#cluster-scoped-resources)
5. [Consumer Requirements](#consumer-requirements)
6. [Checklist](#checklist)

---

## Bootstrap

Core infrastructure is bootstrapped into the cluster via k3s
auto-deploy.  `modules/manifests.nix` feeds the rendered manifests for
all enabled app modules into `services.k3s.manifests`,
which symlinks the YAML into
`/var/lib/rancher/k3s/server/manifests/`.  k3s applies everything in
that directory on startup.

```nix
# modules/manifests.nix
services.k3s.manifests = mapAttrs' (name: manifest:
  nameValuePair "openkrill-${name}" { content = manifest.content; }
) cfg.manifests;
```

cert-manager and trust-manager are bootstrapped alongside ArgoCD so
they are running before ArgoCD begins syncing apps that depend on TLS
certificates or the cluster CA bundle.  All three still declare their
own ArgoCD Application CRs for ongoing self-management — the same
dual-write pattern ArgoCD itself uses (k3s gets them started, ArgoCD
takes over with self-heal and auto-prune).

k3s auto-deploy applies manifests in alphabetical order by filename.
The resulting order is `openkrill-argocd.yaml`,
`openkrill-cert-manager.yaml`, `openkrill-trust-manager.yaml` — which
is fine since ArgoCD does not depend on the other two for initial
startup, and cert-manager correctly precedes trust-manager (trust-manager
depends on cert-manager CRDs).

The flow:

```
nixos-rebuild switch
  -> k3s auto-deploys cert-manager, trust-manager, and ArgoCD
     from /var/lib/rancher/k3s/server/manifests/
  -> cert-manager and trust-manager controllers start, CRDs become available
  -> ArgoCD starts, reads Application CRs (bundled in the same manifest)
  -> ArgoCD syncs each app from the git-daemon repo
     (apps can now safely create Certificates and use the CA bundle)
  -> ArgoCD manages all three + every other app going forward
```

---

## Application CR Pattern

Every app module declares its own ArgoCD Application CR in its
`config` block via `openkrill.apps.argocd.applications.<name>`.
The Application CR points at the git-daemon manifest repo and scopes
itself to the module's manifest file using `directory.include`.

All Application CRs merge into `openkrill.manifests."argo-cd".content`
via `applications.nix`.  The NixOS module system concatenates the
lists.  The result is a single `argocd.yaml` manifest containing the
Helm chart resources **and** all Application CRs, which k3s
auto-deploys at bootstrap.

### Template

```nix
config = mkIf cfg.enable {
  openkrill.apps.argocd.applications.my-app = {
    namespace = "argo-cd";
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

  openkrill.manifests.my-app.content = [ ... ];
};
```

### Key fields

| Field | Value | Notes |
|-------|-------|-------|
| `namespace` | `"argo-cd"` | The Application CR itself lives in the argo-cd namespace |
| `project` | `"default"` | ArgoCD project; use `"default"` unless you have custom AppProjects |
| `source.repoURL` | `config.openkrill.gitops.repoURL` | Set by the consumer; must be reachable from inside the cluster |
| `source.targetRevision` | `"rendered-manifests"` | Branch name in the bare git repo |
| `source.path` | `"."` | Manifests live at the repo root |
| `source.directory.include` | `"<name>.yaml"` | Must match the key used in `openkrill.manifests."<name>".content` |
| `destination.server` | `"https://kubernetes.default.svc"` | Local cluster API |
| `destination.namespace` | `cfg.namespace` | Target namespace for the app's resources |
| `syncPolicy.automated` | `{ prune = true; selfHeal = true; }` | Always set both |
| `syncOptions` | `[ "CreateNamespace=true" ]` | Ensures the namespace is created if it doesn't exist |

### directory.include

The `directory.include` field scopes each Application to its own
manifest file.  The value must match the key in
`openkrill.manifests."<name>".content` with a `.yaml` suffix.
`manifests.nix` serializes each manifest entry as `<name>.yaml` at the
repo root.

---

## ServerSideApply

`"ServerSideApply=true"` is included in `syncOptions` by default for
all ArgoCD applications.  This avoids the 262144-byte annotation size
limit that affects CRDs and other large resources when using
client-side apply.  No per-module opt-in is needed.

---

## Cluster-Scoped Resources

For modules that produce cluster-scoped resources with no single
target namespace (e.g. gateway-api, traefik), omit
`destination.namespace` and `CreateNamespace=true`:

```nix
openkrill.apps.argocd.applications.gateway-api = {
  namespace = "argo-cd";
  project = "default";
  source = {
    repoURL = config.openkrill.gitops.repoURL;
    targetRevision = "rendered-manifests";
    path = ".";
    directory.include = "gateway-api.yaml";
  };
  destination = {
    server = "https://kubernetes.default.svc";
  };
  syncPolicy = {
    automated = { prune = true; selfHeal = true; };
  };
};
```

Resources that already set `.metadata.namespace` in their attrsets
will deploy to that namespace.  The `destination.namespace` field only
applies to resources that don't set it themselves.

---

## Consumer Requirements

The consumer must set `openkrill.gitops.repoURL` to a URL reachable
from inside the cluster:

```nix
openkrill.gitops = {
  enable = true;
  repoURL = "git://10.0.0.1/openkrill-manifests.git";
};
```

The URL must be the node's IP or a DNS name that resolves from within
pods.  `config.networking.hostName` won't work unless cluster DNS is
configured to resolve it.

---

## Checklist

When adding a new app module:

1. Add an ArgoCD Application CR in the `config` block (see template)
2. Set `directory.include` to `"<name>.yaml"` matching the manifest key
3. Set `destination.namespace` to `cfg.namespace` (or omit for cluster-scoped)
4. Add `"CreateNamespace=true"` if the module targets a specific namespace
   (`"ServerSideApply=true"` is already included by default)
6. The Application CR goes **before** the `openkrill.manifests` block in the config
