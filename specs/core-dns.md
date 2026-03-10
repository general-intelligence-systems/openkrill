# CoreDNS & Host-Gateway Access

How pods reach host services (git-daemon, registries, etc.) and how
to add custom DNS entries to k3s's embedded CoreDNS.

---

## Table of Contents

1. [Problem](#problem)
2. [Host-Gateway (DaemonSet + Service)](#host-gateway-daemonset--service)
3. [Custom DNS Hosts (CoreDNS ConfigMap)](#custom-dns-hosts-coredns-configmap)
4. [Auto-Wired gitops.repoURL](#auto-wired-gitopsrepourl)
5. [Options Reference](#options-reference)
6. [Consumer Examples](#consumer-examples)
7. [How It Works](#how-it-works)
8. [Alternatives Considered](#alternatives-considered)

---

## Problem

Pods inside the cluster need to reach services running on the host —
most critically, the git-daemon that serves the rendered manifest repo
for ArgoCD.  Before this module, the consumer had to set
`openkrill.gitops.repoURL` to a hardcoded node IP:

```nix
openkrill.gitops.repoURL = "git://10.0.0.1/openkrill-manifests.git";
```

This is fragile:

- The IP changes across nodes, reboots, and CNI configurations.
- The `cni0` bridge address is a CNI implementation detail — not all
  CNI plugins create it, and its address varies.
- `config.networking.hostName` doesn't resolve from inside pods
  unless cluster DNS is explicitly configured for it.

The `core-dns` module solves both problems:

1. A **host-gateway** gives pods a stable, auto-updating DNS name
   for the host.
2. **Custom DNS hosts** let you map arbitrary names (like
   `ingress.k3s.internal`) to IPs via CoreDNS.

---

## Host-Gateway (DaemonSet + Service)

The host-gateway is the primary feature, enabled by default when the
module is enabled.

### Mechanism

A DaemonSet runs a no-op `pause` container with `hostNetwork: true`
on every node.  Because the pod shares the host's network namespace,
Kubernetes registers the node's real IP as the pod IP in the
Endpoints object.  A ClusterIP Service selecting these pods provides
a single, stable DNS name that round-robins across all node IPs.

Any host service listening on `0.0.0.0` (like git-daemon on port
9418) becomes reachable at that DNS name.

### Resources produced

**DaemonSet** (`modules/core-dns/resources.nix`):

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: host-gateway
  namespace: kube-system
spec:
  selector:
    matchLabels:
      app: host-gateway
  template:
    metadata:
      labels:
        app: host-gateway
    spec:
      hostNetwork: true
      tolerations:
        - key: node-role.kubernetes.io/control-plane
          operator: Exists
          effect: NoSchedule
        - key: node-role.kubernetes.io/master
          operator: Exists
          effect: NoSchedule
      containers:
        - name: pause
          image: registry.k8s.io/pause:3.9
          resources:
            requests: { cpu: 1m, memory: 4Mi }
            limits:   { cpu: 1m, memory: 4Mi }
```

- `hostNetwork: true` is what causes the node IP to appear as the
  pod IP.
- Control-plane tolerations ensure the pod runs on every node,
  including single-node clusters where the only node is the control
  plane.
- The pause container does nothing — it exists solely to keep the
  pod alive so Kubernetes maintains the endpoint registration.
  Resource cost is negligible (~1m CPU, 4Mi RAM per node).

**Service** (`modules/core-dns/resources.nix`):

```yaml
apiVersion: v1
kind: Service
metadata:
  name: host-gateway
  namespace: kube-system
spec:
  selector:
    app: host-gateway
  ports:
    - name: git
      port: 9418
      targetPort: 9418
      protocol: TCP
```

The Service provides the stable DNS name:

```
host-gateway.kube-system.svc.cluster.local
```

The default port (9418) matches git-daemon.  Additional ports can be
added via the `hostGateway.ports` option to expose other host
services (registries, databases, etc.).

### Nix implementation

```nix
# modules/core-dns/resources.nix (simplified)

hostGatewayResources = lib.optionals gw.enable [
  {
    apiVersion = "apps/v1";
    kind = "DaemonSet";
    metadata = { name = "host-gateway"; namespace = ns; };
    spec = {
      selector.matchLabels.app = "host-gateway";
      template = {
        metadata.labels.app = "host-gateway";
        spec = {
          hostNetwork = true;
          tolerations = [ /* control-plane tolerations */ ];
          containers = [{
            name = "pause";
            image = gw.image;
            resources = { requests = { cpu = "1m"; memory = "4Mi"; }; };
          }];
        };
      };
    };
  }
  {
    apiVersion = "v1";
    kind = "Service";
    metadata = { name = "host-gateway"; namespace = ns; };
    spec = {
      selector.app = "host-gateway";
      ports = gw.ports;
    };
  }
];
```

---

## Custom DNS Hosts (CoreDNS ConfigMap)

An optional feature for mapping arbitrary hostnames to IPs from
within the cluster.

### Mechanism

k3s's embedded CoreDNS is pre-configured to import `*.server` and
`*.override` files from the `coredns-custom` ConfigMap in
`kube-system`.  This is a built-in k3s feature — no CoreDNS
reconfiguration is needed.

When `customHosts` is non-empty, the module generates a
`coredns-custom` ConfigMap with a `hosts.server` data key containing
a CoreDNS `hosts` plugin block.

### Resources produced

Given this configuration:

```nix
openkrill.apps.core-dns.customHosts = {
  "ingress.k3s.internal" = "10.42.0.1";
  "registry.k3s.internal" = "10.42.0.1";
};
```

The module produces:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: coredns-custom
  namespace: kube-system
data:
  hosts.server: |
    k3s.internal {
      hosts {
        10.42.0.1 ingress.k3s.internal
        10.42.0.1 registry.k3s.internal
        fallthrough
      }
    }
```

CoreDNS picks up the new server block automatically.  The
`fallthrough` directive ensures unmatched queries continue to the
next plugin in the chain.

### Nix implementation

```nix
# modules/core-dns/resources.nix (simplified)

hostsLines = lib.concatStringsSep "\n"
  (lib.mapAttrsToList (hostname: ip: "${ip} ${hostname}") cfg.customHosts);

customHostsResources = lib.optionals (cfg.customHosts != {}) [
  {
    apiVersion = "v1";
    kind = "ConfigMap";
    metadata = { name = "coredns-custom"; namespace = "kube-system"; };
    data."hosts.server" = ''
      k3s.internal {
        hosts {
          ${hostsLines}
          fallthrough
        }
      }
    '';
  }
];
```

---

## Auto-Wired gitops.repoURL

When the host-gateway is enabled, the module automatically sets
`openkrill.gitops.repoURL` to use the in-cluster Service DNS name:

```nix
# modules/core-dns/default.nix
openkrill.gitops.repoURL = mkIf cfg.hostGateway.enable (
  mkDefault "git://host-gateway.${cfg.namespace}.svc/${config.openkrill.gitops.repoName}"
);
```

With default settings this resolves to:

```
git://host-gateway.kube-system.svc/openkrill-manifests.git
```

Every module's ArgoCD Application CR reads
`config.openkrill.gitops.repoURL`, so all of them — cert-manager,
authelia, victoriametrics, etc. — automatically pick up the
host-gateway DNS name.

The `mkDefault` priority means a consumer can still override:

```nix
# Consumer override wins over mkDefault
openkrill.gitops.repoURL = "git://my-custom-host/manifests.git";
```

### Before and after

**Before** (consumer must hardcode an IP):

```nix
openkrill.gitops = {
  enable = true;
  repoURL = "git://10.0.0.1/openkrill-manifests.git";  # fragile
};
```

**After** (just enable the module):

```nix
openkrill.apps.core-dns.enable = true;
openkrill.gitops.enable = true;
# repoURL is set automatically
```

---

## Options Reference

All options live under `openkrill.apps.core-dns`.

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `enable` | `bool` | `false` | Master switch for the module |
| `namespace` | `str` | `"kube-system"` | Namespace for host-gateway resources |
| `hostGateway.enable` | `bool` | `true` | Deploy the DaemonSet + Service |
| `hostGateway.image` | `str` | `"registry.k8s.io/pause:3.9"` | Pause container image |
| `hostGateway.ports` | `listOf port` | `[{ name="git"; port=9418; targetPort=9418; }]` | Ports exposed by the Service |
| `customHosts` | `attrsOf str` | `{}` | Hostname-to-IP mappings for CoreDNS |
| `extraManifests` | `attrsOf manifest` | `{}` | Additional K8s resources alongside this module |

Each entry in `hostGateway.ports` is a submodule with:

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `name` | `str` | (required) | Port name |
| `port` | `int` | (required) | Service port |
| `targetPort` | `int` | (required) | Target port on the host |
| `protocol` | `str` | `"TCP"` | Protocol |

---

## Consumer Examples

### Minimal — git-daemon access only

```nix
openkrill.apps.core-dns.enable = true;
openkrill.gitops.enable = true;
# repoURL is auto-set to git://host-gateway.kube-system.svc/openkrill-manifests.git
```

### With custom DNS entries

```nix
openkrill.apps.core-dns = {
  enable = true;
  customHosts = {
    "ingress.k3s.internal" = "10.42.0.1";
    "registry.k3s.internal" = "10.42.0.1";
  };
};
```

### With extra ports

```nix
openkrill.apps.core-dns = {
  enable = true;
  hostGateway.ports = [
    { name = "git"; port = 9418; targetPort = 9418; protocol = "TCP"; }
    { name = "registry"; port = 5000; targetPort = 5000; protocol = "TCP"; }
    { name = "http"; port = 80; targetPort = 80; protocol = "TCP"; }
  ];
};
```

### Host-gateway disabled, custom DNS only

```nix
openkrill.apps.core-dns = {
  enable = true;
  hostGateway.enable = false;
  customHosts = {
    "ingress.k3s.internal" = "10.42.0.1";
  };
};
# Consumer must set repoURL manually since host-gateway is off
openkrill.gitops.repoURL = "git://10.0.0.1/openkrill-manifests.git";
```

---

## How It Works

### Data flow: host-gateway

```
┌─────────────────────────────────────────────────────┐
│  Node (host network)                                │
│                                                     │
│  git-daemon :9418 ◄──────────────────────────────┐  │
│                                                  │  │
│  ┌────────────────────────────────────────────┐  │  │
│  │  DaemonSet pod (hostNetwork: true)         │  │  │
│  │  pause container — does nothing            │  │  │
│  │  pod IP = node IP (e.g. 10.0.0.5)         │  │  │
│  └────────────────────────────────────────────┘  │  │
│                    │                             │  │
└────────────────────│─────────────────────────────│──┘
                     │                             │
                     ▼                             │
        ┌────────────────────────┐                 │
        │  Endpoints             │                 │
        │  host-gateway          │                 │
        │  10.0.0.5:9418         │                 │
        └────────────────────────┘                 │
                     │                             │
                     ▼                             │
        ┌────────────────────────┐                 │
        │  Service (ClusterIP)   │                 │
        │  host-gateway          │                 │
        │  :9418 ────────────────┼─────────────────┘
        └────────────────────────┘
                     ▲
                     │
        ┌────────────────────────┐
        │  ArgoCD pod            │
        │  git://host-gateway    │
        │    .kube-system.svc    │
        │    /openkrill-manifests│
        │    .git                │
        └────────────────────────┘
```

### Data flow: custom DNS hosts

```
Consumer config                    CoreDNS
─────────────────                  ───────
customHosts = {           ┌──►  coredns-custom ConfigMap
  "ingress.k3s.internal"  │       data:
    = "10.42.0.1";  ──────┘         hosts.server: |
};                                    k3s.internal {
                                        hosts {
                                          10.42.0.1 ingress.k3s.internal
                                          fallthrough
                                        }
                                      }

                                         │
                                         ▼
                                  CoreDNS auto-imports
                                  *.server from ConfigMap
                                         │
                                         ▼
                                  Pod DNS query:
                                  ingress.k3s.internal
                                    → 10.42.0.1
```

---

## Alternatives Considered

### CoreDNS ConfigMap only (no DaemonSet)

The original approach: template the `cni0` bridge IP into a
`coredns-custom` ConfigMap with a hosts entry.

```yaml
data:
  hosts.server: |
    k3s.internal {
      hosts {
        {{ cni0_ip }} ingress.k3s.internal
        fallthrough
      }
    }
```

**Why we didn't use this as the primary approach:**

- Requires knowing the `cni0` IP at Nix evaluation time — either
  hardcoded or detected via Ansible/scripting.
- `cni0` is a Flannel implementation detail.  Other CNI plugins
  (Cilium, Calico) may not create it or may use a different
  interface name and address.
- Single IP — breaks in multi-node clusters if git-daemon runs on
  a different node than the one whose IP is templated.
- Fragile across reboots if the CNI bridge address changes.

**When to use `customHosts` anyway:** for names that genuinely need
to resolve to a specific IP (e.g. an external load balancer VIP that
the CNI plugin doesn't know about).

### hostAliases in pod specs

Another approach: add `hostAliases` to each pod spec that needs host
access.  This modifies `/etc/hosts` inside individual pods.

**Why we didn't use this:**

- Requires patching every pod spec that needs host access.
- Doesn't compose — each module would need to know about and
  configure the alias.
- Still requires a known IP.

### externalName Service

A `Service` of type `ExternalName` that CNAMEs to the node's hostname.

**Why we didn't use this:**

- `ExternalName` only works with DNS names, not IPs.
- The node hostname typically doesn't resolve from within the cluster
  without additional DNS configuration — which is the problem we're
  trying to solve.
- Doesn't support port mapping.
