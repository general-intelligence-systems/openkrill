# HOW-TO: Network Policies with Cilium

How network segmentation is enforced using Cilium as the CNI and
CiliumNetworkPolicy resources generated from per-app declarations in
the module system.

---

## Table of Contents

1. [Problem](#problem)
2. [Architecture Overview](#architecture-overview)
3. [Cilium Module (`apps/cilium/`)](#cilium-module)
4. [Declaring Network Policy in an App Module](#declaring-network-policy-in-an-app-module)
5. [Network Policies Module (`apps/network-policies/`)](#network-policies-module)
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

Three components work together:

```
+---------------------------------+
|  apps/cilium/                   |  Cilium CNI (replaces Flannel)
|  - Helm chart deployment        |  - BPF-based enforcement
|  - k3s CNI integration          |  - policyEnforcementMode: always
|  - Hubble observability         |  - CiliumNetworkPolicy CRDs
+----------------+----------------+
                 |
+----------------v----------------+
|  Per-app networkPolicy options  |  Each app module declares its needs
|  - ingress: who can reach me    |  - Declared alongside other options
|  - egress: who I need to reach  |  - Uses shared option type
|  - Follows existing patterns    |
+----------------+----------------+
                 |
+----------------v----------------+
|  apps/network-policies/         |  Central assembly
|  - Reads all app declarations   |  - Generates CiliumNetworkPolicy
|  - Baseline policies            |  - Escape hatch for custom rules
+---------------------------------+
```

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

### Default Stack

Added to `modules/openkrill.nix` alongside the other default apps:

```nix
openkrill.apps.cilium.enable = lib.mkDefault true;
```

When cilium is enabled, the network-policies module is also enabled
by default.

---

## Declaring Network Policy in an App Module

### Shared Option Type

A helper provides the `networkPolicy` option type, following the
same pattern as `mkHTTPRoute` and `mkExtraManifestsOption`.  Defined
in `modules/lib/` and imported by app modules.

An app's network policy declaration has three parts:

- **`podSelector`** -- Which pods in the namespace this policy applies
  to.  Defaults to all pods (`{}`).
- **`ingress`** -- List of rules describing allowed inbound traffic.
  Each rule has a `from` identifier and optional `ports`.
- **`egress`** -- List of rules describing allowed outbound traffic.
  Each rule has a `to` identifier and optional `ports`.

```nix
# modules/lib/network-policy.nix (or added to helpers.nix)

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
  helpers = import ../../modules/lib/helpers.nix { inherit lib; };
in
{
  options.openkrill.apps.<name> = {
    # ... existing options (enable, namespace, values, etc.) ...
    networkPolicy = helpers.mkNetworkPolicyOption;
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

## Network Policies Module

### Purpose

Reads all app `networkPolicy` declarations across the module system
and generates CiliumNetworkPolicy resources.  Also applies baseline
policies for infrastructure concerns that aren't tied to a specific
app.

### How It Works

For each app where `networkPolicy != null`:

1. Create a `CiliumNetworkPolicy` in the app's namespace
2. Set `endpointSelector` from the app's `podSelector`
3. Generate `ingress` rules by resolving each `from` identifier
4. Generate `egress` rules by resolving each `to` identifier
5. DNS egress (`to = "dns"`) is recommended for every app -- without
   it, pods cannot resolve service names

The module collects all declarations by iterating
`config.openkrill.apps` and checking for enabled apps with non-null
`networkPolicy`.

### Generated Output

Each declaration produces a single `CiliumNetworkPolicy` resource
written to `openkrill.manifests.network-policies.content`.  All
policies are bundled into one manifest file, deployed and managed by
ArgoCD like any other app.

---

## Baseline Policies

The network-policies module generates these regardless of per-app
declarations.  They protect infrastructure that every cluster has.

### Secret Storage Isolation

The namespace holding source secrets should only be reachable by the
secret distribution operator:

```yaml
apiVersion: cilium.io/v2
kind: CiliumNetworkPolicy
metadata:
  name: secret-store-isolation
  namespace: secret-store
spec:
  endpointSelector: {}
  ingress:
    - fromEndpoints:
        - matchLabels:
            k8s:io.kubernetes.pod.namespace: external-secrets
```

### DNS Policy

DNS pods accept queries from all cluster pods, but only DNS pods
have upstream (external) DNS egress.  This prevents DNS-based data
exfiltration from compromised pods:

```yaml
apiVersion: cilium.io/v2
kind: CiliumNetworkPolicy
metadata:
  name: dns-policy
  namespace: kube-system
spec:
  endpointSelector:
    matchLabels:
      k8s-app: kube-dns
  ingress:
    - fromEndpoints:
        - {}
      toPorts:
        - ports:
            - port: "53"
              protocol: UDP
            - port: "53"
              protocol: TCP
  egress:
    - toEntities:
        - world
      toPorts:
        - ports:
            - port: "53"
              protocol: UDP
            - port: "53"
              protocol: TCP
```

### Cilium Internal

Cilium's own pods need inter-node communication and API server
access for health checks, Hubble, and policy distribution:

```yaml
apiVersion: cilium.io/v2
kind: CiliumNetworkPolicy
metadata:
  name: cilium-internal
  namespace: kube-system
spec:
  endpointSelector:
    matchLabels:
      k8s-app: cilium
  ingress:
    - fromEntities:
        - remote-node
        - health
  egress:
    - toEntities:
        - remote-node
        - health
        - kube-apiserver
```

### Host-Gateway

If the core-dns module's host-gateway is enabled, its pods need
cluster ingress and host egress:

```yaml
apiVersion: cilium.io/v2
kind: CiliumNetworkPolicy
metadata:
  name: host-gateway
  namespace: kube-system
spec:
  endpointSelector:
    matchLabels:
      app: host-gateway
  ingress:
    - fromEntities:
        - cluster
  egress:
    - toEntities:
        - host
```

---

## Identifier Resolution

The `from` and `to` strings in policy declarations are resolved to
Cilium policy constructs by the network-policies module.  This is the
mapping:

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
finer-grained selection, use `extraPolicies` with raw
CiliumNetworkPolicy resources.

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
| `openkrill.apps.cilium.enable` | bool | `true` (mkDefault) | Enable Cilium CNI |
| `openkrill.apps.cilium.namespace` | str | `"kube-system"` | Namespace for Cilium |
| `openkrill.apps.cilium.values` | attrs | `{}` | Helm value overrides |
| `openkrill.apps.cilium.extraManifests` | list | `[]` | Additional manifests |

### Network Policies Module

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `openkrill.apps.network-policies.enable` | bool | `true` (when cilium enabled) | Enable policy generation |
| `openkrill.apps.network-policies.defaultDeny` | bool | `true` | Generate empty policy per app namespace to trigger Cilium's implicit deny |
| `openkrill.apps.network-policies.extraPolicies` | list of attrs | `[]` | Raw CiliumNetworkPolicy resources |

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
  # Cilium and network-policies are enabled by default.
  # Each app module provides sensible default policy declarations.
}
```

### Adding a custom app with network policy

```nix
openkrill.apps.network-policies.extraPolicies = [
  {
    apiVersion = "cilium.io/v2";
    kind = "CiliumNetworkPolicy";
    metadata = {
      name = "my-api";
      namespace = "my-api";
    };
    spec = {
      endpointSelector = {};
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
  }
];
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
# Disable policy generation (Cilium still runs but no policies
# are created -- with policyEnforcementMode=always this means
# all traffic is denied for pods with any policy)
openkrill.apps.network-policies.enable = false;

# To also switch to permissive mode:
openkrill.apps.cilium.values.policyEnforcementMode = "default";
```

---

## Implementation Checklist

### Phase 1: Cilium CNI Module

- [ ] Create `apps/cilium/default.nix` with options and Helm chart
- [ ] Modify `modules/openkrill.nix` to set k3s flags when cilium
      is enabled
- [ ] Add to default app stack
- [ ] Ensure bootstrap via k3s auto-deploy
- [ ] Add ArgoCD Application CR
- [ ] Test: k3s boots with Cilium, pods get IPs, DNS works

### Phase 2: Shared Network Policy Option Type

- [ ] Define option types in `modules/lib/`
- [ ] Add `networkPolicy` option to each app module
- [ ] Set default declarations per app

### Phase 3: Network Policies Module

- [ ] Create `apps/network-policies/default.nix`
- [ ] Implement identifier resolution
- [ ] Generate CiliumNetworkPolicy per app
- [ ] Generate baseline policies
- [ ] Add to default app stack (when cilium enabled)
- [ ] Test: services communicate, unauthorized traffic blocked

### Phase 4: Operator Integration

- [ ] Add `networkAccess` to MCP, Skill, Tool CRD schemas
- [ ] Add `apiEndpoint` to LlmProvider CRD schema
- [ ] Extend HeartbeatController to produce CiliumNetworkPolicy
- [ ] Update CompositeController child resources
- [ ] Extend Metacontroller RBAC
- [ ] Test: agent pods get correct per-Heartbeat policies
