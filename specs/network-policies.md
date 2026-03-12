# HOW-TO: Network Policies with Cilium

How network segmentation is enforced using Cilium as the CNI and
typed CiliumNetworkPolicy CRD instances generated from per-app
declarations in the module system.

---

## Table of Contents

1. [Problem](#problem)
2. [Architecture Overview](#architecture-overview)
3. [Cilium Module (`apps/cilium/`)](#cilium-module)
4. [Declaring Network Policy in an App Module](#declaring-network-policy-in-an-app-module)
5. [Policy Compilation](#policy-compilation)
6. [Baseline Policies](#baseline-policies)
7. [Identifier Resolution](#identifier-resolution)
8. [Agent Pod Policies (openkrill-operator)](#agent-pod-policies)
9. [Options Reference](#options-reference)
10. [Consumer Examples](#consumer-examples)
11. [Implementation Checklist](#implementation-checklist)

---

## Problem

Without network policies, every pod can communicate with every other
pod and with external endpoints.  This is problematic because:

- **Identity backends** (LDAP, SSO) should only be reachable by the
  services that authenticate against them.
- **Secret storage namespaces** should only be reachable by the
  secret distribution operator.
- **Dynamically spawned workloads** (CI runners, LLM agent pods) are
  high-risk -- if compromised via supply chain attack or prompt
  injection, unrestricted networking enables lateral movement and
  data exfiltration.
- **Inter-service communication is unauthenticated.**  Without mTLS,
  network policies are the primary isolation mechanism.

---

## Architecture Overview

The cilium module handles both CNI deployment and network policy
generation in a single module, using auto-generated typed CRD
fragments for CiliumNetworkPolicy and CiliumClusterwideNetworkPolicy:

```
+---------------------------------+
|  apps/cilium/                   |  Cilium CNI + policy generation
|  - Helm chart deployment        |  - BPF-based enforcement
|  - k3s CNI integration          |  - policyEnforcementMode: always
|  - Hubble observability         |  - Typed CRD fragments
|  - Policy compiler              |  - Baseline policies
|  - Identifier resolution        |  - Per-app policy assembly
+----------------+----------------+
                 ^
+----------------+----------------+
|  Per-app networkPolicy options  |  Each app module declares its needs
|  - ingress: who can reach me    |  - Declared alongside other options
|  - egress: who I need to reach  |  - Uses shared option type
|  - Follows existing patterns    |
+---------------------------------+
```

The cilium module reads all per-app `networkPolicy` declarations,
resolves identifiers to Cilium endpoint/entity selectors, and writes
the results into typed `ciliumnetworkpolicies` options provided by
the auto-generated CRD fragment.

For dynamic workloads (openkrill-operator Heartbeat pods), the
operator itself generates CiliumNetworkPolicy resources as child
resources of each Heartbeat CR.  See [Agent Pod Policies](#agent-pod-policies).

---

## Cilium Module

### Purpose

Deploys Cilium as the cluster CNI, replacing k3s's bundled Flannel.
Cilium provides BPF-based networking, CiliumNetworkPolicy CRDs,
L7-aware enforcement, FQDN-based egress rules, and Hubble
observability.

The module also owns all network policy generation -- reading per-app
declarations, compiling them into typed CiliumNetworkPolicy CRD
instances, and generating baseline infrastructure policies.

### Module Structure

```
apps/cilium/
  default.nix                          # Helm chart + policy compiler
  ciliumnetworkpolicies.nix            # Auto-generated CRD fragment
  ciliumclusterwidenetworkpolicies.nix # Auto-generated CRD fragment
```

The CRD fragments are generated from upstream Cilium CRD YAML using
`bin/create-module-crds --fragment`:

```sh
curl -sL "https://raw.githubusercontent.com/cilium/cilium/v1.19.1/\
pkg/k8s/apis/cilium.io/client/crds/v2/ciliumnetworkpolicies.yaml" \
  -o crds/cilium/ciliumnetworkpolicies.yaml

bin/create-module-crds --fragment cilium \
  crds/cilium/ciliumnetworkpolicies.yaml \
  > apps/cilium/ciliumnetworkpolicies.nix
```

### k3s Integration

k3s must be told not to install its own CNI and network policy
controller.  The cilium module sets additional flags on the k3s
service:

```nix
services.k3s.extraFlags = lib.mkAfter
  "--flannel-backend=none --disable-network-policy";
```

Cilium must be deployed before any other workloads start.  The module
writes Cilium manifests to the k3s auto-deploy directory
(`/var/lib/rancher/k3s/server/manifests/`) so they are applied at
first boot, before ArgoCD or any app pods exist.

### Key Helm Values

| Setting | Value | Why |
|---------|-------|-----|
| `policyEnforcementMode` | `"always"` | Default-deny posture: pods with a CiliumNetworkPolicy get only explicitly allowed traffic |
| `k8sServiceHost` | `"localhost"` | k3s API server location |
| `k8sServicePort` | `6443` | k3s API server port |
| `kubeProxyReplacement` | `true` | Cilium replaces kube-proxy |
| `hubble.enabled` | `true` | Network flow observability |
| `hubble.relay.enabled` | `true` | Hubble Relay for CLI/UI access |
| `operator.replicas` | `1` | Single-node clusters |
| `ipam.mode` | `"kubernetes"` | Use k8s IPAM |
| `bpf.masquerade` | `true` | BPF-based masquerading |

---

## Declaring Network Policy in an App Module

### Shared Option Type

A helper provides the `networkPolicy` option type, following the
same pattern as `mkHTTPRoute` and `mkExtraManifestsOption`.  Defined
in `modules/lib/network-policy.nix` and imported by app modules.

An app's network policy declaration has three parts:

- **`podSelector`** -- Which pods in the namespace this policy applies
  to.  Defaults to all pods (`{}`).
- **`ingress`** -- List of rules describing allowed inbound traffic.
  Each rule has a `from` identifier and optional `ports`.
- **`egress`** -- List of rules describing allowed outbound traffic.
  Each rule has a `to` identifier and optional `ports`.

```nix
# modules/lib/network-policy.nix

ingressRuleModule = types.submodule {
  options = {
    from = mkOption {
      type = types.str;
      description = ''
        Source identifier.  See "Identifier Resolution" in the
        network-policies spec for the full list.
      '';
    };
    ports = mkOption {
      type = types.listOf portModule;
      default = [];
      description = "Ports to allow.  Empty means all ports.";
    };
  };
};

egressRuleModule = types.submodule {
  options = {
    to = mkOption {
      type = types.str;
      description = ''
        Destination identifier.  See "Identifier Resolution" in the
        network-policies spec for the full list.
      '';
    };
    ports = mkOption {
      type = types.listOf portModule;
      default = [];
    };
  };
};

portModule = types.submodule {
  options = {
    port = mkOption { type = types.port; };
    protocol = mkOption {
      type = types.enum [ "TCP" "UDP" ];
      default = "TCP";
    };
  };
};
```

### Adding to an App Module

Each app module adds `networkPolicy` to its options and sets defaults
in its `config` block.  The pattern mirrors how apps already declare
`extraManifests`, `values`, or `oidcClients`:

```nix
# apps/<name>/default.nix
{ config, lib, ... }:
let
  cfg = config.openkrill.apps.<name>;
  networkPolicyLib = import ../../modules/lib/network-policy.nix { inherit lib; };
in
{
  options.openkrill.apps.<name> = {
    # ... existing options (enable, namespace, values, etc.) ...
    networkPolicy = networkPolicyLib.mkNetworkPolicyOption;
  };

  config = lib.mkIf cfg.enable {
    # Declare what this app needs
    openkrill.apps.<name>.networkPolicy = {
      ingress = [
        { from = "traefik"; ports = [{ port = 80; }]; }
      ];
      egress = [
        { to = "cloudnative-pg"; ports = [{ port = 5432; }]; }
        { to = "dns"; }
      ];
    };

    # ... existing config (manifests, secrets, ArgoCD app, etc.) ...
  };
}
```

### Overriding from Consumer Configuration

Consumers can extend or replace declarations using standard NixOS
module merging:

```nix
# Extend: add an additional ingress source
openkrill.apps.<name>.networkPolicy.ingress = [
  { from = "my-custom-service"; ports = [{ port = 8080; }]; }
];

# Replace entirely
openkrill.apps.<name>.networkPolicy.ingress = lib.mkForce [
  { from = "traefik"; ports = [{ port = 80; }]; }
  { from = "my-custom-service"; ports = [{ port = 8080; }]; }
];

# Disable policy for a specific app (it will have no
# CiliumNetworkPolicy, meaning Cilium's "always" enforcement
# denies all traffic -- use with caution)
openkrill.apps.<name>.networkPolicy = lib.mkForce null;
```

---

## Policy Compilation

### How It Works

The cilium module's `default.nix` reads all per-app `networkPolicy`
declarations and compiles them into typed CiliumNetworkPolicy CRD
instances via the auto-generated `ciliumnetworkpolicies` option.

For each app where `networkPolicy != null`:

1. Create a typed CiliumNetworkPolicy keyed by the app name
2. Set `namespace` from the app's namespace
3. Set `endpointSelector` from the app's `podSelector`
4. Generate `ingress` rules by resolving each `from` identifier
5. Generate `egress` rules by resolving each `to` identifier
6. DNS egress (`to = "dns"`) is recommended for every app -- without
   it, pods cannot resolve service names

### Generated Output

Each declaration produces a typed CiliumNetworkPolicy entry in
`openkrill.apps.cilium.ciliumnetworkpolicies.<name>`.  The CRD
fragment converts these into Kubernetes resources written to
`openkrill.manifests.cilium.content`.  All policies are bundled
with the Cilium Helm chart output and deployed via ArgoCD.

---

## Baseline Policies

The cilium module generates baseline policies regardless of per-app
declarations.  They protect infrastructure that every cluster has.

### Secret Storage Isolation

The namespace holding source secrets should only be reachable by the
secret distribution operator:

```nix
# Written as: openkrill.apps.cilium.ciliumnetworkpolicies.secret-store-isolation
{
  namespace = "secret-store";
  ingress = [{
    fromEndpoints = [{
      matchLabels."k8s:io.kubernetes.pod.namespace" = "external-secrets";
    }];
  }];
}
```

### DNS Policy

DNS pods accept queries from all cluster pods, but only DNS pods
have upstream (external) DNS egress.  This prevents DNS-based data
exfiltration from compromised pods:

```nix
# Written as: openkrill.apps.cilium.ciliumnetworkpolicies.dns-policy
{
  namespace = "kube-system";
  endpointSelector.matchLabels."k8s-app" = "kube-dns";
  ingress = [{
    fromEndpoints = [{}];
    toPorts = [{
      ports = [
        { port = "53"; protocol = "UDP"; }
        { port = "53"; protocol = "TCP"; }
      ];
    }];
  }];
  egress = [{
    toEntities = [ "world" ];
    toPorts = [{
      ports = [
        { port = "53"; protocol = "UDP"; }
        { port = "53"; protocol = "TCP"; }
      ];
    }];
  }];
}
```

### Cilium Internal

Cilium's own pods need inter-node communication and API server
access for health checks, Hubble, and policy distribution:

```nix
# Written as: openkrill.apps.cilium.ciliumnetworkpolicies.cilium-internal
{
  namespace = "kube-system";
  endpointSelector.matchLabels."k8s-app" = "cilium";
  ingress = [{
    fromEntities = [ "remote-node" "health" ];
  }];
  egress = [{
    toEntities = [ "remote-node" "health" "kube-apiserver" ];
  }];
}
```

### Host-Gateway

If the core-dns module's host-gateway is enabled, its pods need
cluster ingress and host egress:

```nix
# Written as: openkrill.apps.cilium.ciliumnetworkpolicies.host-gateway
{
  namespace = "kube-system";
  endpointSelector.matchLabels.app = "host-gateway";
  ingress = [{
    fromEntities = [ "cluster" ];
  }];
  egress = [{
    toEntities = [ "host" ];
  }];
}
```

---

## Identifier Resolution

The `from` and `to` strings in policy declarations are resolved to
Cilium policy constructs by the cilium module's policy compiler.
This is the mapping:

| Identifier | Type | Resolved To |
|-----------|------|-------------|
| App name (e.g. `"authelia"`) | Cluster service | `fromEndpoints`/`toEndpoints` with namespace label matching the app's configured namespace |
| `"traefik"` | Ingress controller | Endpoints in `kube-system` with traefik pod labels |
| `"dns"` | DNS shorthand | Endpoints in `kube-system` with CoreDNS labels, ports 53 TCP+UDP |
| `"kubernetes-api"` | API server | `toEntities: ["kube-apiserver"]` |
| `"world"` | External | `fromEntities: ["world"]` or `toEntities: ["world"]` |
| `"cluster"` | All internal | `fromEntities: ["cluster"]` or `toEntities: ["cluster"]` |
| String containing `.` (e.g. `"api.example.com"`) | FQDN | `toFQDNs: [{ matchName: "..." }]` (egress only) |

### App Name Resolution

When an identifier matches an enabled app name in
`config.openkrill.apps`, the module resolves it to a namespace
selector using that app's `namespace` option:

```nix
# "authelia" resolves to:
fromEndpoints = [{
  matchLabels."k8s:io.kubernetes.pod.namespace" =
    config.openkrill.apps.authelia.namespace;  # "authelia"
}];
```

This means app modules don't need to know each other's internal pod
labels -- namespace-level selection is sufficient for most cases.  For
finer-grained selection, use `extraPolicies` with typed
CiliumNetworkPolicy attributes.

---

## Agent Pod Policies

### Problem

The openkrill-operator creates Heartbeat CronJob pods dynamically at
runtime.  These pods run LLM agents with MCP access to cluster
services.  Their network requirements vary per-Heartbeat based on
which MCPs, Skills, and Tools they reference.

Network policies generated at Nix eval time cannot cover these
dynamic workloads.

### Solution: Per-Heartbeat CiliumNetworkPolicy

The HeartbeatController in the openkrill-operator is extended to
produce a third child resource alongside the CronJob and Secret:

```
Heartbeat CR
  |
  +---> Secret                ({name}-credentials)
  +---> CronJob               ({name})
  +---> CiliumNetworkPolicy   ({name}-netpol)       <-- NEW
```

### networkAccess Field on Resource CRDs

MCP, Skill, and Tool CRDs each gain an optional `spec.networkAccess`
field describing what network access agents using this resource need:

```yaml
apiVersion: openkrill.ai/v1alpha1
kind: MCP
metadata:
  name: my-git-server
  namespace: agents
spec:
  description: "Git server MCP"
  config:
    command: "git-mcp"
  networkAccess:
    - endpoint: "forgejo.forgejo.svc.cluster.local"
      port: 3000
      protocol: TCP
```

```yaml
apiVersion: openkrill.ai/v1alpha1
kind: Skill
metadata:
  name: web-research
  namespace: agents
spec:
  type: opencode
  files:
    skill.md: |
      # Web Research Skill
  networkAccess:
    - endpoint: "api.duckduckgo.com"
      port: 443
      protocol: TCP
```

### Policy Generation Logic

The HeartbeatController:

1. Reads `networkAccess` from all referenced MCPs, Skills, and Tools
   (via KubeClient lookups)
2. Merges all endpoint declarations into a single policy
3. Adds DNS egress (always)
4. Adds LLM API provider egress (from `LlmProvider.spec.apiEndpoint`)
5. Generates a CiliumNetworkPolicy selecting pods created by this
   Heartbeat's CronJob

### LLM API Provider Egress

The LlmProvider CRD gains an optional `spec.apiEndpoint` field:

```yaml
apiVersion: openkrill.ai/v1alpha1
kind: LlmProvider
metadata:
  name: my-provider
spec:
  name: my-provider
  image: ghcr.io/example/agent-runner:latest
  apiEndpoint: "api.anthropic.com"
  mounts:
    skills: /home/user/.opencode/skills
```

The HeartbeatController uses this to add an FQDN-based egress rule so
the agent can reach the LLM API.

### Fail-Closed Default

If an MCP or Skill does not declare `networkAccess`, the agent pod
gets a restrictive default:

- DNS egress (to CoreDNS)
- LLM API egress (from provider)
- **No other egress**
- **No ingress**

Agents with undeclared network needs fail closed rather than fail
open.

### RBAC

The Metacontroller service account needs permissions to manage
CiliumNetworkPolicy child resources:

```yaml
- apiGroups: ["cilium.io"]
  resources: ["ciliumnetworkpolicies"]
  verbs: ["get", "list", "create", "update", "delete"]
```

### CompositeController Update

The heartbeat CompositeController definition adds
ciliumnetworkpolicies as a child resource type:

```yaml
childResources:
  - apiVersion: batch/v1
    resource: cronjobs
    updateStrategy:
      method: InPlace
  - apiVersion: v1
    resource: secrets
    updateStrategy:
      method: InPlace
  - apiVersion: cilium.io/v2          # NEW
    resource: ciliumnetworkpolicies
    updateStrategy:
      method: InPlace
```

---

## Options Reference

### Cilium Module

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `openkrill.apps.cilium.enable` | bool | `false` | Enable Cilium CNI and network policy generation |
| `openkrill.apps.cilium.namespace` | str | `"kube-system"` | Namespace for Cilium |
| `openkrill.apps.cilium.values` | attrs | `{}` | Helm value overrides |
| `openkrill.apps.cilium.defaultDeny` | bool | `true` | Reserved for future use (empty policies per namespace) |
| `openkrill.apps.cilium.extraPolicies` | attrsOf attrs | `{}` | Additional typed CiliumNetworkPolicy instances |
| `openkrill.apps.cilium.extraManifests` | list | `[]` | Additional raw manifests |
| `openkrill.apps.cilium.ciliumnetworkpolicies` | attrsOf submodule | `{}` | Typed CiliumNetworkPolicy CRD instances (populated by compiler) |
| `openkrill.apps.cilium.ciliumclusterwidenetworkpolicies` | attrsOf submodule | `{}` | Typed CiliumClusterwideNetworkPolicy CRD instances |

### Per-App networkPolicy Option

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `openkrill.apps.<name>.networkPolicy` | null or submodule | `null` | Network policy declaration |
| `.podSelector` | attrs | `{}` | Label selector (empty = all pods) |
| `.ingress[].from` | str | -- | Source identifier |
| `.ingress[].ports[]` | `{ port, protocol }` | -- | Allowed ports |
| `.egress[].to` | str | -- | Destination identifier |
| `.egress[].ports[]` | `{ port, protocol }` | -- | Allowed ports |

---

## Consumer Examples

### Minimal (defaults only)

```nix
{
  services.openkrill.enable = true;
  openkrill.apps.cilium.enable = true;
  # Each app module provides sensible default policy declarations.
  # The cilium module compiles them into CiliumNetworkPolicy resources.
}
```

### Adding a custom app with network policy

```nix
openkrill.apps.cilium.extraPolicies = {
  my-api = {
    namespace = "my-api";
    ingress = [{ fromEndpoints = [{
      matchLabels."k8s:io.kubernetes.pod.namespace" = "kube-system";
    }]; }];
    egress = [{ toEndpoints = [{
      matchLabels."k8s:io.kubernetes.pod.namespace" = "kube-system";
    }]; toPorts = [{
      ports = [
        { port = "53"; protocol = "UDP"; }
        { port = "53"; protocol = "TCP"; }
      ];
    }]; }];
  };
};
```

### Relaxing a default policy

```nix
# Add an additional ingress source to an app
openkrill.apps.<name>.networkPolicy.ingress = lib.mkForce [
  { from = "traefik"; ports = [{ port = 80; }]; }
  { from = "my-sidecar"; ports = [{ port = 8080; }]; }
];
```

### Disabling enforcement

```nix
# Disable Cilium entirely (no CNI replacement, no policies)
openkrill.apps.cilium.enable = false;

# Or keep Cilium but switch to permissive mode:
openkrill.apps.cilium.values.policyEnforcementMode = "default";
```

---

## Implementation Checklist

### Phase 1: Cilium CNI + Network Policy Module

- [x] Create `apps/cilium/default.nix` with Helm chart deployment
- [x] Generate typed CRD fragments for CiliumNetworkPolicy and
      CiliumClusterwideNetworkPolicy via `bin/create-module-crds`
- [x] Implement identifier resolution (per-app policy compiler)
- [x] Generate baseline policies (secret-store, DNS, cilium-internal,
      host-gateway)
- [x] Modify `modules/openkrill.nix` to set k3s flags when cilium
      is enabled
- [x] Add ArgoCD Application CR
- [ ] Test: k3s boots with Cilium, pods get IPs, DNS works

### Phase 2: Shared Network Policy Option Type

- [x] Define option types in `modules/lib/network-policy.nix`
- [x] Add `networkPolicy` option to each app module
- [x] Set default declarations per app

### Phase 3: Integration Testing

- [ ] Test: services communicate, unauthorized traffic blocked
- [ ] Test: `extraPolicies` escape hatch works

### Phase 4: Operator Integration

- [ ] Add `networkAccess` to MCP, Skill, Tool CRD schemas
- [ ] Add `apiEndpoint` to LlmProvider CRD schema
- [ ] Extend HeartbeatController to produce CiliumNetworkPolicy
- [ ] Update CompositeController child resources
- [ ] Extend Metacontroller RBAC
- [ ] Test: agent pods get correct per-Heartbeat policies
