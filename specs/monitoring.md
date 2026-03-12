<!--
 Copyright (c) 2025 Nathan Kidd <nathankidd@hey.com>. All rights reserved.
 SPDX-License-Identifier: Proprietary
-->

# HOW-TO: Monitoring with VictoriaMetrics

How app modules declare VictoriaMetrics scrape configs and alert rules
using the cross-module aggregation pattern, so that enabling
VictoriaMetrics automatically discovers metrics from every instrumented
app.

---

## Table of Contents

1. [Problem](#problem)
2. [Architecture Overview](#architecture-overview)
3. [VictoriaMetrics Module](#victoriametrics-module)
4. [CRD Fragment Generation](#crd-fragment-generation)
5. [Adding Monitoring to an App Module](#adding-monitoring-to-an-app-module)
6. [Available CRD Types](#available-crd-types)
7. [Network Policy Integration](#network-policy-integration)
8. [Helm Value Defaults for Metrics](#helm-value-defaults-for-metrics)
9. [Options Reference](#options-reference)
10. [Consumer Examples](#consumer-examples)
11. [Apps with Monitoring Configured](#apps-with-monitoring-configured)
12. [Implementation Checklist](#implementation-checklist)

---

## Problem

VictoriaMetrics needs to know which services expose Prometheus metrics,
on which ports, and with which label selectors.  Without per-app
declarations:

- **VMAgent has no scrape targets** beyond the defaults shipped by the
  Helm chart (kubelet, kube-state-metrics, node-exporter).  App-specific
  metrics (ArgoCD sync status, CNPG replication lag, Authelia auth
  failures) are invisible.
- **No alerting rules exist** for application-level failures.  The
  default rules only cover Kubernetes infrastructure.
- **Network policies block scraping** because VMAgent runs in the
  `victoriametrics` namespace and app pods are in their own namespaces.
  Without explicit ingress rules for the metrics port, scrapes are
  denied by Cilium's default-deny posture.

The solution follows the same cross-module aggregation pattern used by
`networkPolicy`, `argocd.applications`, `ingress.routes`,
`external-secrets.secrets`, and `cloudnative-pg.databases`: each app
module declares what it needs under a shared option namespace, and a
central module assembles the result.

---

## Architecture Overview

Three things work together to make an app's metrics visible:

```
+--------------------------------------------+
|  apps/victoriametrics/                     |  Central monitoring stack
|  - Helm chart (operator, VMSingle, etc.)   |  - Deploys VMAgent, VMAlert, Grafana
|  - 8 CRD fragment imports                  |  - selectAllByDefault = true
|  - Assembles all VM CRs into manifests     |  - VMAgent auto-discovers all CRs
+---------------------+----------------------+
                      |
+---------------------v----------------------+
|  Per-app VM declarations                   |  Each app module declares:
|  openkrill.apps.victoriametrics            |  (a) VMServiceScrape — what to scrape
|    .vmservicescrapes.<name>                 |  (b) VMRule — alerting rules
|    .vmrules.<name>                         |  Guarded by mkIf vm.enable
|  Declared in each app's default.nix        |
+---------------------+----------------------+
                      |
+---------------------v----------------------+
|  Network policy ingress                    |  Each app adds:
|  openkrill.apps.<name>.networkPolicy       |  { from = "victoriametrics";
|    .ingress += [{ from = "victoriametrics" |    ports = [{ port = <metrics>; }]; }
|                   ports = [...]; }]        |
+--------------------------------------------+
```

This mirrors the network-policies pattern exactly:

| Concern | Declares under | Assembled by |
|---------|---------------|--------------|
| Network policy | `openkrill.apps.<name>.networkPolicy` | `apps/cilium/` (policy compiler) |
| Monitoring | `openkrill.apps.victoriametrics.vmservicescrapes.<name>` | `apps/victoriametrics/` (via fragments) |

Both use a cross-cutting compilation approach: app modules declare
their needs, and a central module assembles the results into typed
CRD instances.

---

## VictoriaMetrics Module

### Composing Module

`apps/victoriametrics/default.nix` is a standard Helm-based app module
that also imports 8 CRD fragment files:

```nix
imports = [
  ./vmalertmanagerconfigs.nix
  ./vmnodescrapes.nix
  ./vmpodscrapes.nix
  ./vmprobes.nix
  ./vmrules.nix
  ./vmscrapeconfigs.nix
  ./vmservicescrapes.nix
  ./vmstaticscrapes.nix
];
```

### Helm Stack

The Helm chart deploys the full VictoriaMetrics k8s stack:

| Component | Purpose |
|-----------|---------|
| VM Operator | Watches VM CRDs, manages VM components |
| VMSingle | Time-series database (single-node, 90d retention) |
| VMAgent | Scrapes targets, ships to VMSingle |
| VMAlert | Evaluates alerting/recording rules |
| VMAlertmanager | Alert routing and notification |
| Grafana | Dashboards (auth-proxied via Authelia) |
| node-exporter | Host-level metrics |
| kube-state-metrics | Kubernetes object metrics |

### selectAllByDefault

The critical Helm value is `vmagent.spec.selectAllByDefault = true`.
This tells VMAgent to discover **all** VMServiceScrape, VMPodScrape,
VMProbe, etc. CRs across the entire cluster, regardless of namespace or
label.  App modules don't need to register with VMAgent — they just
create the CR and VMAgent finds it.

---

## CRD Fragment Generation

The 8 fragment files were auto-generated using `bin/create-module-crds`
in fragment mode.  See [nix-module-app-generator.md](./nix-module-app-generator.md)
for the full generator documentation.

### How Fragments Work

Each fragment:

1. **Declares a typed option** —
   `openkrill.apps.victoriametrics.<type>` as `attrsOf submodule`, where
   the submodule options mirror the CRD spec fields.

2. **Builds K8s resources** — a `mk<Kind>` function serializes each
   submodule entry into a proper K8s resource attrset with `apiVersion`,
   `kind`, `metadata`, and `spec`.

3. **Contributes to manifests** — in the `config` block (guarded by
   `mkIf cfg.enable`), the fragment appends all resources to
   `openkrill.manifests.victoriametrics.content`.

Example from `vmrules.nix`:

```nix
# Simplified — the real file has full CRD-derived submodule types
allResources = mapAttrsToList mkVMRule cfg.vmrules;

config = mkIf cfg.enable {
  openkrill.manifests.victoriametrics.content = allResources;
};
```

Because multiple fragments all write to the same manifest key
(`victoriametrics`), NixOS module merging combines them into a single
list of resources.

---

## Adding Monitoring to an App Module

Every monitored app needs up to three things:

1. **VMServiceScrape** — tells VMAgent how to scrape the app
2. **VMRule** — alerting rules (optional but recommended)
3. **Network policy ingress** — allows VMAgent to reach the metrics port

All three are declared in the app's `config` block, guarded by
`mkIf config.openkrill.apps.victoriametrics.enable`.

### Full Annotated Example

Using CloudNativePG as the reference implementation
(`apps/cloudnative-pg/default.nix`):

```nix
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps.cloudnative-pg;
in
{
  # options block unchanged — no new options needed for monitoring

  config = mkIf cfg.enable {

    # ── (1) VMServiceScrape ──────────────────────────────────────────
    # Tells VMAgent: "scrape pods matching these labels, in this
    # namespace, on this port."
    #
    # The CR is created in the victoriametrics namespace (where
    # VMAgent runs) but uses namespaceSelector to target the app's
    # own namespace.
    openkrill.apps.victoriametrics.vmservicescrapes.cnpg =
      mkIf config.openkrill.apps.victoriametrics.enable {
        # CR lives in VM's namespace
        namespace = config.openkrill.apps.victoriametrics.namespace;
        # Select pods by label
        selector.matchLabels."cnpg.io/cluster" = cfg.clusterName;
        # Look in the app's namespace
        namespaceSelector.matchNames = [ cfg.namespace ];
        # Scrape config
        endpoints = [{
          port = "metrics";
          path = "/metrics";
        }];
      };

    # ── (2) VMRule ───────────────────────────────────────────────────
    # Alerting rules evaluated by VMAlert.  Each rule group contains
    # PromQL expressions and firing conditions.
    openkrill.apps.victoriametrics.vmrules.cnpg-alerts =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        groups = [{
          name = "cnpg";
          rules = [
            {
              alert = "CNPGClusterNotHealthy";
              expr = ''cnpg_collector_up == 0'';
              "for" = "5m";
              labels.severity = "critical";
              annotations = {
                summary = "CNPG cluster {{ $labels.cluster }} is not healthy";
                description = "CNPG metrics collector has been down for 5 minutes.";
              };
            }
            {
              alert = "CNPGHighReplicationLag";
              expr = ''cnpg_pg_replication_lag > 30'';
              "for" = "5m";
              labels.severity = "warning";
              annotations = {
                summary = "CNPG replication lag on {{ $labels.cluster }}";
                description = "Replication lag exceeds 30 seconds for 5 minutes.";
              };
            }
          ];
        }];
      };

    # ── (3) Network policy ingress ───────────────────────────────────
    # Allow VMAgent (in the victoriametrics namespace) to reach the
    # app's metrics port.  Without this, Cilium's default-deny blocks
    # the scrape.
    openkrill.apps.cloudnative-pg.networkPolicy = {
      ingress = [
        # ... other ingress rules ...
        { from = "victoriametrics"; ports = [{ port = 5432; }]; }
      ];
      egress = [ { to = "dns"; } ];
    };

    # ... rest of config (manifests, ArgoCD app, secrets, etc.) ...
  };
}
```

### Key Points

- **Guard with mkIf** — The VM declarations are wrapped in
  `mkIf config.openkrill.apps.victoriametrics.enable`.  If VM isn't
  enabled, no CRs are generated and no evaluation errors occur.

- **Namespace is VM's namespace** — VMServiceScrape and VMRule CRs are
  created in the `victoriametrics` namespace (where VMAgent and VMAlert
  run), not the app's namespace.  The `namespaceSelector` field tells
  VMAgent which namespace to look in for the actual pods.

- **selector.matchLabels** — Must match labels on the app's Service (for
  VMServiceScrape) or Pods.  Check the Helm chart output to find the
  right labels.  Common patterns:
  - `app.kubernetes.io/name` = `"<app>"` (most Helm charts)
  - `app.kubernetes.io/part-of` = `"<app>"` (ArgoCD)
  - CRD-specific labels like `cnpg.io/cluster` (CNPG)

- **endpoints[].port** — The port **name** (string) from the Service
  spec, not the port number.  If the chart's Service doesn't name its
  metrics port, use the port number as a string.

- **Network policy port** — This is the port **number** (integer) in
  the networkPolicy declaration.  It must match the actual container port
  the metrics endpoint listens on.

### Minimal Example (scrape only, no alerts)

For apps that expose metrics but don't need custom alerting rules:

```nix
# apps/trust-manager/default.nix (excerpt)
openkrill.apps.victoriametrics.vmservicescrapes.trust-manager =
  mkIf config.openkrill.apps.victoriametrics.enable {
    namespace = config.openkrill.apps.victoriametrics.namespace;
    selector.matchLabels."app.kubernetes.io/name" = "trust-manager";
    namespaceSelector.matchNames = [ cfg.namespace ];
    endpoints = [{ port = "metrics"; }];
  };
```

---

## Available CRD Types

Eight CRD fragment types are available under
`openkrill.apps.victoriametrics.<type>`:

| Type | CRD Kind | When to Use |
|------|----------|-------------|
| `vmservicescrapes` | VMServiceScrape | Scrape a Kubernetes Service's pods (most common) |
| `vmpodscrapes` | VMPodScrape | Scrape pods directly without a Service |
| `vmnodescrapes` | VMNodeScrape | Scrape node-level exporters (e.g. node-exporter) |
| `vmstaticscrapes` | VMStaticScrape | Scrape static targets by IP/hostname |
| `vmscrapeconfigs` | VMScrapeConfig | Advanced scrape config (service discovery, relabeling) |
| `vmprobes` | VMProbe | Probe URLs for availability (blackbox-style) |
| `vmrules` | VMRule | Alerting and recording rules |
| `vmalertmanagerconfigs` | VMAlertmanagerConfig | Alert routing, receivers, inhibit rules |

For the vast majority of app modules, you only need **`vmservicescrapes`**
and **`vmrules`**.

---

## Network Policy Integration

VMAgent runs in the `victoriametrics` namespace and scrapes pods in
other namespaces.  With Cilium's `policyEnforcementMode = "always"`,
this traffic is denied unless the target app explicitly allows it.

### Pattern

Add an ingress rule to the app's `networkPolicy` allowing traffic from
the `victoriametrics` namespace on the metrics port:

```nix
openkrill.apps.<name>.networkPolicy.ingress = [
  # ... existing rules ...
  { from = "victoriametrics"; ports = [{ port = <metrics-port>; }]; }
];
```

The `"victoriametrics"` identifier is resolved by the cilium module's
policy compiler to an endpoint selector matching the victoriametrics
namespace (see [network-policies.md](./network-policies.md) for
identifier resolution rules).

### Finding the Metrics Port

Check the Helm chart's rendered Service or the container spec:

```sh
# Look at rendered manifests for port names/numbers
nix eval .#nixosConfigurations.<host>.config.openkrill.manifests.<app>.content --json | jq '.. | .ports? // empty'
```

Or check the upstream chart documentation for the metrics port.

### Apps in kube-system

Apps deployed to `kube-system` (cilium, traefik) don't need network
policy ingress rules for metrics because Cilium doesn't enforce policy
on its own namespace by default.

---

## Helm Value Defaults for Metrics

Some Helm charts don't expose Prometheus metrics by default.  The app
module must set Helm values to enable them.  These are set in the
`defaults` let-binding in each module, not in the VM declarations.

| App | Helm Values Set | Why |
|-----|----------------|-----|
| argocd | `controller.metrics.enabled = true`, `server.metrics.enabled = true`, `repoServer.metrics.enabled = true`, `applicationSet.metrics.enabled = true`, `notifications.metrics.enabled = true` | Each ArgoCD component has its own metrics toggle |
| authelia | `configMap.telemetry.metrics.enabled = true` | Authelia's metrics are behind a telemetry config |
| cilium | `prometheus.enabled = true`, `operator.prometheus.enabled = true` | Enables `/metrics` on agent and operator |
| forgejo | `gitea.config.metrics.ENABLED = "true"` | Forgejo metrics are a gitea.ini setting |
| kamaji | `telemetry.disabled = false` | Kamaji defaults to disabled telemetry |

Apps like cert-manager, cloudnative-pg, external-secrets, traefik,
trust-manager, and metacontroller expose metrics by default and need no
Helm value changes.

---

## Options Reference

### VMServiceScrape

| Option | Type | Required | Description |
|--------|------|:--------:|-------------|
| `namespace` | str | yes | Namespace for the CR (use VM's namespace) |
| `selector.matchLabels` | attrsOf str | yes | Label selector for target Services |
| `namespaceSelector.matchNames` | listOf str | yes | Namespaces to search for matching Services |
| `endpoints` | listOf submodule | yes | Scrape endpoints |
| `endpoints[].port` | str | yes | Port name from the Service spec |
| `endpoints[].path` | str | no | Metrics path (default `/metrics`) |
| `endpoints[].interval` | str | no | Scrape interval (default from VMAgent) |
| `endpoints[].scheme` | str | no | `http` or `https` |

### VMRule

| Option | Type | Required | Description |
|--------|------|:--------:|-------------|
| `namespace` | str | yes | Namespace for the CR (use VM's namespace) |
| `groups` | listOf submodule | yes | Rule groups |
| `groups[].name` | str | yes | Group name |
| `groups[].rules` | listOf submodule | yes | Rules in this group |
| `groups[].rules[].alert` | str | no | Alert name (omit for recording rules) |
| `groups[].rules[].expr` | str | yes | PromQL expression |
| `groups[].rules[].for` | str | no | Duration before firing |
| `groups[].rules[].labels` | attrsOf str | no | Labels to attach |
| `groups[].rules[].annotations` | attrsOf str | no | Annotations (summary, description) |
| `groups[].rules[].record` | str | no | Recording rule name (omit for alerts) |

For the full option schema of all 8 CRD types, see the generated
fragment files in `apps/victoriametrics/`.  The options mirror the
upstream VictoriaMetrics operator CRD spec exactly.

---

## Consumer Examples

### Minimal (defaults only)

```nix
{
  services.openkrill.enable = true;
  openkrill.apps.victoriametrics.enable = true;
  # All app modules with VM declarations automatically contribute
  # scrape configs and alert rules.
}
```

### Adding a scrape target from consumer config

```nix
# Scrape a custom app not managed by an openkrill module
openkrill.apps.victoriametrics.vmservicescrapes.my-api = {
  namespace = "victoriametrics";
  selector.matchLabels."app" = "my-api";
  namespaceSelector.matchNames = [ "my-api" ];
  endpoints = [{ port = "http-metrics"; interval = "15s"; }];
};
```

### Adding custom alert rules

```nix
openkrill.apps.victoriametrics.vmrules.my-alerts = {
  namespace = "victoriametrics";
  groups = [{
    name = "my-api";
    rules = [{
      alert = "MyAPIHighLatency";
      expr = ''histogram_quantile(0.99, rate(http_duration_seconds_bucket[5m])) > 1'';
      "for" = "10m";
      labels.severity = "warning";
      annotations = {
        summary = "My API p99 latency above 1s";
        description = "99th percentile latency has exceeded 1 second for 10 minutes.";
      };
    }];
  }];
};
```

### Overriding an app's default scrape config

```nix
# Change cert-manager's scrape interval
openkrill.apps.victoriametrics.vmservicescrapes.cert-manager = lib.mkForce {
  namespace = "victoriametrics";
  selector.matchLabels."app.kubernetes.io/name" = "cert-manager";
  namespaceSelector.matchNames = [ "cert-manager" ];
  endpoints = [{ port = "http-metrics"; interval = "10s"; }];
};
```

---

## Apps with Monitoring Configured

These app modules currently declare VMServiceScrape and/or VMRule
resources:

| App | VMServiceScrape | VMRule | Alerts | Metrics Port |
|-----|:-:|:-:|--------|:---:|
| argocd | yes | yes | `ArgoAppOutOfSync`, `ArgoAppDegraded` | 8082/8083/8084 |
| authelia | yes | yes | `AutheliaDown` | 9959 |
| cert-manager | yes | yes | `CertExpiringSoon`, `CertNotReady` | 9402 |
| cilium | yes | yes | `CiliumAgentUnhealthy`, `CiliumEndpointNotReady` | 9962/9963 |
| cloudnative-pg | yes | yes | `CNPGClusterNotHealthy`, `CNPGHighReplicationLag` | metrics |
| external-secrets | yes | yes | `ExternalSecretSyncFailed` | 8080 |
| forgejo | yes | yes | `ForgejoDown` | 3000 |
| kamaji | yes | yes | `KamajiDown` | 8080 |
| metacontroller | yes | yes | `MetacontrollerDown` | 9999 |
| traefik | yes | yes | `TraefikHighHTTP5xxRate`, `TraefikBackendDown` | 9100 |
| trust-manager | yes | no | — | 9402 |

Apps **not** instrumented (and why):

| App | Reason |
|-----|--------|
| core-dns | Covered by VM stack's built-in CoreDNS scrape |
| forgejo-runner | No Prometheus metrics endpoint |
| gateway-api | CRD-only module, no pods |
| helm | CRD-only module, no pods |
| (network policies are part of the cilium module) | |
| lago | No Prometheus metrics support |
| lldap | No Prometheus metrics endpoint |
| opencloud | No metrics port exposed in current manifests |
| theia-ide | No Prometheus metrics endpoint |

---

## Implementation Checklist

When adding monitoring to a new or existing app module:

- [ ] **Verify metrics endpoint** — Confirm the app exposes `/metrics`
      (or similar) on a known port.  Check Helm chart docs or container
      image docs.
- [ ] **Enable metrics in Helm values** — If the chart requires it,
      add the appropriate `metrics.enabled = true` (or equivalent) to
      the module's `defaults` in `helm.nix` or `default.nix`.
- [ ] **Declare VMServiceScrape** — Add
      `openkrill.apps.victoriametrics.vmservicescrapes.<name>` in the
      app's `config` block, guarded by
      `mkIf config.openkrill.apps.victoriametrics.enable`.
- [ ] **Declare VMRule** (recommended) — Add
      `openkrill.apps.victoriametrics.vmrules.<name>-alerts` with at
      least a basic "is the app down?" alert.
- [ ] **Add network policy ingress** — Add
      `{ from = "victoriametrics"; ports = [{ port = <N>; }]; }` to the
      app's `networkPolicy.ingress` list (skip for `kube-system` apps).
- [ ] **Test** — Run `bin/test` to verify the module evaluates cleanly.
- [ ] **Verify in Grafana** — After deployment, check that the target
      appears in VMAgent's target list and metrics flow into Grafana.
