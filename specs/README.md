<!--
 Copyright (c) 2025 Nathan Kidd <nathankidd@hey.com>. All rights reserved.
 SPDX-License-Identifier: Proprietary
-->

<!--
  HOW TO MAINTAIN THIS FILE

  This is the index of all design specifications for Openkrill.
  Each row links a spec document to its implementation code and a short purpose summary.

  When adding a new spec:
  1. Create the markdown file in this directory (specs/)
  2. Add a row to the appropriate table section below
  3. Link the spec file, the code path it describes, and a brief purpose

  Table format:
    | [spec-name.md](./spec-name.md) | [path/to/code](../path/to/code) | Lines | Short description |

  Use "—" in the Code column if the spec has no implementation yet.
  Group specs under heading sections by domain area.
-->

# Spec Index

Design documentation for Openkrill.

## Kubernetes

| Spec | Code | Lines | Purpose |
|------|------|------:|---------|
| [k8s-manifests.md](./k8s-manifests.md) | [cluster/](../cluster/) | 561 | How the Nix module system produces K8s manifests for management and tenant clusters, and how to add apps to each |
| [k8s-manifests-architecture.md](./k8s-manifests-architecture.md) | [cluster/](../cluster/) | 38 | Architecture overview of the openkrill NixOS module system: manifests, apps, and gitops layers |
| [k8s-manifests-helm.md](./k8s-manifests-helm.md) | [cluster/modules/](../cluster/modules/) | 170 | How to create a Helm-based app module under `modules/` |
| [nix-module-apps.md](./nix-module-apps.md) | [cluster/modules/](../cluster/modules/) | 1004 | How-to guide for creating NixOS-style cluster app modules under `cluster/modules/` |
| [nix-module-crds.md](./nix-module-crds.md) | [modules/](../modules/) | 269 | How to create a CRD-only module from a CRD specification |
| [argocd.md](./argocd.md) | [modules/](../modules/) | 191 | ArgoCD bootstrap via k3s and per-module Application CR pattern |
| [core-dns.md](./core-dns.md) | [modules/core-dns/](../modules/core-dns/) | 506 | Host-gateway access and custom CoreDNS entries for reaching host services from pods |

