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
| [k8s-manifests-helm.md](./k8s-manifests-helm.md) | [apps/](../apps/) | 170 | How to create a Helm-based app module under `apps/` |
| [nix-module-apps.md](./nix-module-apps.md) | [apps/](../apps/) | 1027 | How-to guide for creating NixOS-style app modules under `apps/` |
| [nix-module-crds.md](./nix-module-crds.md) | [apps/](../apps/) | 269 | How to hand-write a CRD-only module from a CRD specification |
| [nix-module-app-generator.md](./nix-module-app-generator.md) | [lib/generate-module.nix](../lib/generate-module.nix) | 493 | How to auto-generate typed CRD fragments with `bin/create-module-crds` |
| [nix-module-app-template.md](./nix-module-app-template.md) | [lib/generate-app-template.nix](../lib/generate-app-template.nix), [modules/lib/app-template.nix](../modules/lib/app-template.nix) | 262 | How to auto-generate typed Helm values from the bjw-s app-template JSON Schema |
| [argocd.md](./argocd.md) | [apps/stable/argocd/](../apps/stable/argocd/) | 191 | ArgoCD bootstrap via k3s and per-module Application CR pattern |
| [ingress.md](./ingress.md) | [modules/routes.nix](../modules/routes.nix) | 228 | Declarative ingress: per-app route definitions that produce Gateway listeners, TLS certificates, and HTTPRoutes |
| [core-dns.md](./core-dns.md) | [apps/stable/core-dns/](../apps/stable/core-dns/) | 506 | Host-gateway access and custom CoreDNS entries for reaching host services from pods |

## Security

| Spec | Code | Lines | Purpose |
|------|------|------:|---------|
| [auth.md](./auth.md) | [modules/routes.nix](../modules/routes.nix), [apps/stable/authelia/](../apps/stable/authelia/) | 228 | Route authentication: auth types, path-based rules, and the provider injection pattern |
| [network-policies.md](./network-policies.md) | — | 688 | How network segmentation is enforced with Cilium CNI and per-app CiliumNetworkPolicy declarations |

## Secrets

| Spec | Code | Lines | Purpose |
|------|------|------:|---------|
| [secrets.md](./secrets.md) | [modules/secret-generators.nix](../modules/secret-generators.nix), [apps/stable/external-secrets/](../apps/stable/external-secrets/) | 395 | How secrets are generated, stored, and distributed via ESO; how to add secrets to an app module |

## Monitoring

| Spec | Code | Lines | Purpose |
|------|------|------:|---------|
| [monitoring.md](./monitoring.md) | [apps/stable/victoriametrics/](../apps/stable/victoriametrics/) | 561 | How app modules declare VictoriaMetrics scrape configs and alert rules via the cross-module aggregation pattern |

