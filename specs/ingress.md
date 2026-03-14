# HOW-TO: Ingress Routes

How external traffic reaches cluster services via the openkrill
ingress module, Gateway API, and cert-manager TLS certificates.

---

## Table of Contents

1. [Problem](#problem)
2. [Architecture Overview](#architecture-overview)
3. [Declaring a Route in an App Module](#declaring-a-route-in-an-app-module)
4. [What the Ingress Module Produces](#what-the-ingress-module-produces)
5. [TLS Certificate Lifecycle](#tls-certificate-lifecycle)
6. [Filters](#filters)
7. [Options Reference](#options-reference)
8. [Consumer Examples](#consumer-examples)
9. [Dependency Chain](#dependency-chain)
10. [Checklist](#checklist)

---

## Problem

Without the ingress module, exposing a service required:

- **Each app reaching into gateway-api internals.**  App modules
  directly set `openkrill.apps."gateway-api".httproutes.<name>` via a
  `helpers.mkHTTPRoute` helper, coupling every app to the Gateway API
  resource structure (parentRefs, sectionNames, backendRefs).

- **A dangling TLS Secret reference.**  The default Gateway used a
  single wildcard listener (`*.domain`) referencing a
  `wildcard-tls` Secret that nothing in the codebase created.

- **No connection between cert-manager and the Gateway.**  cert-manager
  had a self-signed CA chain (`ClusterIssuer/openkrill-signing-authority`)
  ready to issue certificates, but no Certificate resources existed to
  provision the TLS Secrets the Gateway needed.

- **A single wildcard listener.**  All routes shared one HTTPS listener
  with one TLS Secret, giving no per-service cert isolation.

---

## Architecture Overview

The ingress module (`modules/routes.nix`) sits between app modules and
the gateway-api CRD layer, reading declarative route definitions and
producing all the Gateway API and cert-manager resources needed:

```
+-----------------------------------+
|  App modules                      |  Each app declares what it needs
|  openkrill.ingress.routes.<name>  |  subdomain, namespace, service,
|  = { subdomain; port; ... }       |  port, optional filters
+----------------+------------------+
                 |
                 v
+----------------+------------------+
|  modules/routes.nix               |  Aggregates all route definitions
|  openkrill.ingress.enable = true  |  and produces:
|                                   |
|  For each route:                  |
|  1. HTTPS listener on Gateway     |  - Per-hostname, port 443
|  2. HTTP listener on Gateway      |  - Per-hostname, port 80
|  3. cert-manager Certificate      |  - Signed by openkrill CA
|  4. HTTPRoute (app traffic)       |  - In app namespace
|  5. HTTPRoute (HTTP→HTTPS redir)  |  - In kube-system
+----------------+------------------+
                 |
        +--------+--------+
        |                 |
        v                 v
+-------+-------+  +-----+----------+
| gateway-api   |  | cert-manager   |
| Typed CRD     |  | Certificate    |
| options for   |  | resources →    |
| Gateway,      |  | TLS Secrets    |
| HTTPRoute     |  | in kube-system |
+-------+-------+  +----------------+
        |
        v
+-------+-------+
| traefik       |  GatewayClass controller
| Reads Gateway |  Configures data-plane
| + HTTPRoutes  |  routing and TLS
+---------------+
```

All generated resources flow through the standard manifest pipeline
(`openkrill.manifests`) and are deployed via ArgoCD and k3s bootstrap.

---

## Declaring a Route in an App Module

An app module declares its ingress route in the `config` block:

```nix
{ config, lib, ... }:
let
  cfg = config.openkrill.apps.my-app;
in
{
  config = lib.mkIf cfg.enable {
    openkrill.ingress.routes.my-app = {
      subdomain = "app";          # → app.<openkrill.domain>
      namespace = cfg.namespace;
      service   = "my-app";       # defaults to the route name
      port      = 8080;
    };
  };
}
```

The route name (the attrset key, `my-app` above) is used as the
HTTPRoute resource name.  The `service` option defaults to the route
name, so it can be omitted when they match.

No `mkIf` guard on `openkrill.ingress.enable` is needed in the app
module -- the ingress module's own `mkIf` prevents resource generation
when ingress is disabled.  The route definition is simply inert.

### Naming Convention

The `subdomain` determines several derived names:

| Derived from `subdomain` + `domain` | Example (`subdomain = "git"`, default domain) |
|--------------------------------------|------------------------------------------------|
| FQDN hostname                        | `git.example.com`                              |
| HTTPS listener name      | `git-https`                   |
| HTTP listener name        | `git-http`                    |
| TLS Secret name           | `git-tls`                     |
| Certificate name          | `git-tls`                     |
| Redirect HTTPRoute name   | `git-http-to-https`           |

---

## What the Ingress Module Produces

For each `openkrill.ingress.routes.<name>` entry, five resources are
created.  Using `forgejo` with `subdomain = "git"` as an example:

### 1. HTTPS Listener on Gateway/main

Added to the `Gateway/main` resource in `kube-system`:

```yaml
name: git-https
port: 443
protocol: HTTPS
hostname: git.example.com      # exact hostname, not wildcard
tls:
  mode: Terminate
  certificateRefs:
    - kind: Secret
      name: git-tls            # per-route TLS Secret
allowedRoutes:
  namespaces:
    from: All
```

### 2. HTTP Listener on Gateway/main

```yaml
name: git-http
port: 80
protocol: HTTP
hostname: git.example.com
allowedRoutes:
  namespaces:
    from: All
```

### 3. cert-manager Certificate

Created in `kube-system` alongside the Gateway:

```yaml
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: git-tls
  namespace: kube-system
spec:
  secretName: git-tls
  dnsNames:
    - git.example.com
  issuerRef:
    name: openkrill-signing-authority
    kind: ClusterIssuer
```

### 4. HTTPRoute (app traffic)

Created in the app's namespace:

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: forgejo
  namespace: forgejo
spec:
  hostnames:
    - git.example.com
  parentRefs:
    - name: main
      namespace: kube-system
      sectionName: git-https    # binds to the per-route listener
  rules:
    - backendRefs:
        - name: forgejo-http
          namespace: forgejo
          port: 3000
```

### 5. HTTPRoute (HTTP-to-HTTPS redirect)

Created in `kube-system`:

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: git-http-to-https
  namespace: kube-system
spec:
  hostnames:
    - git.example.com
  parentRefs:
    - name: main
      namespace: kube-system
      sectionName: git-http     # binds to the per-route HTTP listener
  rules:
    - filters:
        - type: RequestRedirect
          requestRedirect:
            scheme: https
            statusCode: 301
```

### Resource Placement Summary

| Resource | Namespace | Manifest Key |
|----------|-----------|--------------|
| Gateway/main | kube-system | `gateway-api` (via CRD typed options) |
| Certificate/<subdomain>-tls | kube-system | `ingress` |
| HTTPRoute/<name> (app traffic) | app namespace | `gateway-api` (via CRD typed options) |
| HTTPRoute/<subdomain>-http-to-https | kube-system | `gateway-api` (via CRD typed options) |

---

## TLS Certificate Lifecycle

The ingress module creates one cert-manager `Certificate` resource per
route.  Each Certificate:

- Lives in `kube-system`, alongside the Gateway that references its
  Secret.  This avoids the need for cross-namespace ReferenceGrants.
- Is signed by `ClusterIssuer/openkrill-signing-authority`, the CA
  issuer from the cert-manager module's self-signed CA chain.
- Targets a Secret named `<subdomain>-tls` with a single dnsName
  (`<subdomain>.<domain>`).
- Is automatically renewed by cert-manager before expiry.

The CA chain (created by `apps/stable/cert-manager/default.nix`):

```
ClusterIssuer/openkrill-origin-authority    (self-signed bootstrap)
        |
        v
Certificate/openkrill-internal-certificate  (isCA=true, 10yr)
        |
        v
ClusterIssuer/openkrill-signing-authority   (CA issuer)
        |
        v
Certificate/<subdomain>-tls                (per-route, signed by CA)
        |
        v
Secret/<subdomain>-tls                     (in kube-system)
        |
        v
Gateway/main listener                      (references the Secret)
```

The CA certificate is distributed cluster-wide by trust-manager as a
ConfigMap (`openkrill-ca-bundle`), so internal clients can verify the
self-signed certificates.

---

## Filters

Gateway API HTTPRoute filters can be passed via the `filters` option.
These are inserted directly into the HTTPRoute rule alongside the
`backendRefs`.

The most common use case is Traefik's ForwardAuth middleware for
Authelia-based authentication:

```nix
let
  authFilters = if config.openkrill.apps.authelia.enable
                && config.openkrill.apps.traefik.enable
    then [
      {
        type = "ExtensionRef";
        extensionRef = {
          group = "traefik.io";
          kind = "Middleware";
          name = "forwardauth-authelia";
        };
      }
    ]
    else [];
in
{
  config = lib.mkIf cfg.enable {
    openkrill.ingress.routes.my-app = {
      subdomain = "app";
      namespace = cfg.namespace;
      port = 8080;
      filters = authFilters;
    };
  };
}
```

When `filters` is non-empty, the generated HTTPRoute rule includes
both `backendRefs` and `filters`:

```yaml
rules:
  - backendRefs:
      - name: my-app
        namespace: my-app
        port: 8080
    filters:
      - type: ExtensionRef
        extensionRef:
          group: traefik.io
          kind: Middleware
          name: forwardauth-authelia
```

When `filters` is empty (the default), the `filters` key is omitted
from the rule entirely.

---

## Options Reference

### `openkrill.ingress`

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `enable` | `bool` | `false` | Enable the ingress module.  Creates the default Gateway and processes all route definitions. |
| `routes` | `attrsOf routeSubmodule` | `{}` | Per-app route definitions (see below). |

### `openkrill.ingress.routes.<name>`

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `enable` | `bool` | `true` | Whether this route is active.  Set to `false` to disable without removing the declaration. |
| `subdomain` | `str` | *(required)* | Subdomain prefix.  Full hostname: `<subdomain>.<domain>`. |
| `domain` | `str` | `openkrill.domain` | Domain suffix.  Override for routes on external domains (e.g. `tradecrm.pro`). |
| `namespace` | `str` | *(required)* | Kubernetes namespace where the backend Service lives. |
| `service` | `str` | `<name>` | Backend Service name.  Defaults to the route's attrset key. |
| `port` | `port` | *(required)* | Port on the backend Service. |
| `filters` | `listOf attrs` | `[]` | Gateway API HTTPRoute filters (e.g. ForwardAuth).  Passed directly into the HTTPRoute rule. |

### Assertions

The module asserts that the following are enabled:

- `openkrill.apps.gateway-api.enable` -- provides the typed CRD
  options for Gateway and HTTPRoute resources.
- `openkrill.apps.cert-manager.enable` -- provides the cert-manager
  controller.
- `openkrill.apps.cert-manager.selfSignedCA.enable` -- provides
  `ClusterIssuer/openkrill-signing-authority` used to sign route
  certificates.

---

## Consumer Examples

### Minimal

```nix
{
  services.openkrill.enable = true;
  openkrill.domain = "example.com";

  openkrill.apps.gateway-api.enable = true;
  openkrill.apps.cert-manager.enable = true;
  openkrill.apps.traefik.enable = true;

  openkrill.ingress.enable = true;
}
```

With no routes defined, the Gateway is created with zero listeners.
Routes are added by enabling app modules:

```nix
{
  openkrill.apps.forgejo.enable = true;
  # The forgejo module declares:
  #   openkrill.ingress.routes.forgejo = {
  #     subdomain = "git";
  #     namespace = "forgejo";
  #     service = "forgejo-http";
  #     port = 3000;
  #   };
}
```

### Multiple apps with auth

```nix
{
  openkrill.apps.forgejo.enable = true;    # git.example.com
  openkrill.apps.authelia.enable = true;   # auth.example.com
  openkrill.apps.lldap.enable = true;      # ldap.example.com
  openkrill.apps.theia-ide.enable = true;  # theia.example.com (+ auth filter)
  openkrill.apps.opencloud.enable = true;  # cloud.example.com (+ auth filter)
                                           # office.example.com (+ auth filter)
}
```

This produces a Gateway with 12 listeners (6 routes x 2 listeners
each), 6 Certificates, 6 app HTTPRoutes, and 6 redirect HTTPRoutes.

### Route on an external domain

When a route serves on a domain other than `openkrill.domain`, set the
`domain` option:

```nix
{
  openkrill.ingress.routes.my-app = {
    subdomain = "staging";
    domain    = "tradecrm.pro";   # → staging.tradecrm.pro
    namespace = "staging";
    service   = "web";
    port      = 3000;
  };
}
```

The ingress module creates the same five resources (Gateway listener,
TLS Certificate, app HTTPRoute, HTTP redirect) using the overridden
domain.  All other routes that omit `domain` continue to use the
default `openkrill.domain`.

---

## Dependency Chain

```
cert-manager                    Provides ClusterIssuer/openkrill-signing-authority
    |
    v
modules/routes.nix              Creates Certificates + Gateway + HTTPRoutes
    |
    v
apps/stable/gateway-api/               Provides typed CRD options for Gateway, HTTPRoute
    |                            Provides safe-upgrades VAP
    v
apps/stable/traefik/                   Provides GatewayClass/traefik
                                Configures Traefik data-plane from Gateway API
```

The module file is `modules/routes.nix`, imported by `modules/default.nix`.
It writes to:

- `openkrill.apps."gateway-api".gateways.main` -- the Gateway resource
- `openkrill.apps."gateway-api".httproutes.*` -- app and redirect routes
- `openkrill.manifests.ingress.content` -- cert-manager Certificate resources

---

## Checklist

When adding ingress to a new app module:

- [ ] Route declared: `openkrill.ingress.routes.<name> = { subdomain; namespace; service; port; }`
- [ ] `service` option set if it differs from the route name
- [ ] `filters` set if authentication or other middleware is needed
- [ ] Network policy allows Traefik ingress on the service port:
      `{ from = "traefik"; ports = [{ port = <port>; }]; }`
- [ ] Consumer config has `openkrill.ingress.enable = true`
- [ ] Consumer config has `openkrill.apps.gateway-api.enable = true`
- [ ] Consumer config has `openkrill.apps.cert-manager.enable = true`
