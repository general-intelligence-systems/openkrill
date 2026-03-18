# HOW-TO: Authentication

How route-level authentication works in openkrill — auth types, path-based
rules, and the provider injection pattern.

---

## Table of Contents

1. [Problem](#problem)
2. [Architecture Overview](#architecture-overview)
3. [Auth Types](#auth-types)
4. [Path-Based Rules](#path-based-rules)
5. [Auth Provider Pattern](#auth-provider-pattern)
6. [Options Reference](#options-reference)
7. [Consumer Examples](#consumer-examples)
8. [Migration from auth bool](#migration-from-auth-bool)

---

## Problem

The previous ingress module had a single `auth = true|false` toggle
per route.  This created several issues:

- **No per-path auth control.**  Apps that need different auth per path
  (e.g. Forgejo: SSO on `/`, token auth on `/api`) had to bypass the
  route abstraction and write raw `gateway-api.httproutes`.

- **Tight coupling to Authelia.**  `routes.nix` directly referenced
  Authelia's ForwardAuth middleware.  Swapping to Authentik or Keycloak
  would require modifying the core ingress module.

- **No path-based backend routing.**  Apps like Lago that serve
  different backends per path (`/` → frontend, `/api` → API service)
  had to use low-level escape hatches.

---

## Architecture Overview

Authentication is decoupled from route declaration:

```
+-----------------------------------+
|  App modules                      |  Declare routes with paths and
|  openkrill.ingress.routes.<name>  |  auth types (forward, none, etc.)
|  paths."/api" = { auth; ... }     |  NO knowledge of auth providers
+----------------+------------------+
                 |
                 v
+----------------+------------------+
|  modules/routes.nix               |  Produces bare HTTPRoutes with
|                                   |  no auth filters.  Reads
|                                   |  authFilters registry to apply
|                                   |  provider-injected filters.
+----------------+------------------+
                 |
        +--------+--------+
        |                 |
        v                 v
+-------+-------+  +-----+----------+
| Auth provider |  | gateway-api    |
| e.g. Authelia |  | Bare HTTPRoutes|
| Registers its |  | get filters    |
| filter under  |  | applied from   |
| authFilters.  |  | the registry   |
| forward       |  |                |
+---------------+  +----------------+
```

`routes.nix` is **auth-provider-agnostic**.  It does not reference
Authelia, Authentik, or any specific middleware.  It reads the
`openkrill.ingress.authFilters` internal option — a map from auth type
name to a list of Gateway API HTTPRoute filters — and applies filters
to rules whose auth type has a registered provider.

Auth provider modules (Authelia, future Authentik, etc.) register
their filters via `mkIf` when enabled:

```nix
# In the Authelia module:
config = mkIf cfg.enable {
  openkrill.ingress.authFilters.forward = [{
    type = "ExtensionRef";
    extensionRef = {
      group = "traefik.io";
      kind = "Middleware";
      name = "forwardauth-authelia";
    };
  }];
};
```

If no provider is enabled, no filters are registered.  Routes with
`auth = "forward"` will have no auth middleware applied — which is
correct: if you haven't deployed an SSO provider, there's nothing to
protect with.

---

## Auth Types

Route paths declare their auth requirement using a string enum:

| Value     | Meaning                              | Behavior                                    |
|-----------|--------------------------------------|---------------------------------------------|
| `forward` | ForwardAuth SSO (Authelia, etc.)     | Provider module injects filter if enabled   |
| `token`   | App handles token/API-key auth       | No filter injected (passthrough)            |
| `basic`   | App handles HTTP Basic auth          | No filter injected (passthrough)            |
| `oauth`   | App handles its own OAuth/OIDC       | No filter injected (passthrough)            |
| `none`    | Completely unprotected               | No filter injected                          |

The default auth type is `"forward"`.

Currently only `forward` has a registered provider (Authelia).  The
other types are semantic labels — they document the route's auth
intent.  Real middleware for `token`, `basic`, or `oauth` can be
added later by registering filters under those names.

---

## Path-Based Rules

Each route can define multiple paths, each with its own auth type and
optional backend override:

```nix
openkrill.ingress.routes.my-app = {
  subdomain = "app";
  namespace = "my-app";
  service   = "frontend";
  port      = 80;

  paths."/" = {
    auth = "forward";
    # service/port inherited from route level
  };

  paths."/api" = {
    auth    = "token";
    service = "api-server";   # different backend
    port    = 8080;
  };
};
```

### Path Matching

The `pathType` option maps directly to Gateway API match types:

| `pathType`          | Gateway API equivalent   | Default |
|---------------------|--------------------------|---------|
| `"PathPrefix"`      | `path.type: PathPrefix`  | Yes     |
| `"Exact"`           | `path.type: Exact`       |         |
| `"RegularExpression"`| `path.type: RegularExpression` |   |

These are Gateway API's native match types — no custom syntax.

### Implicit Default

When `paths` is empty (the default), the route produces a single
catch-all HTTPRoute rule using the route-level `auth`, `service`,
and `port`.  This preserves backward compatibility — routes that
don't need per-path control work identically to before.

### Rule Generation

For each path entry, `routes.nix` produces one HTTPRoute rule:

```yaml
rules:
  - matches:
      - path:
          type: PathPrefix    # from pathType
          value: /api         # from the paths key
    backendRefs:
      - name: api-server     # from path.service or route.service
        namespace: my-app
        port: 8080            # from path.port or route.port
    filters:                  # injected by auth provider (if any)
      - type: ExtensionRef
        ...
```

The catch-all path `/` with `pathType = "PathPrefix"` produces a rule
with no `matches` (Gateway API default matches everything).

---

## Auth Provider Pattern

Auth providers are independent NixOS modules that follow this pattern:

1. **Register filters** — set `openkrill.ingress.authFilters.<type>`
   to a list of Gateway API HTTPRoute filter attrsets.
2. **Guard with `mkIf`** — only register when the provider is enabled.

### Authelia Example

```nix
# In apps/stable/authelia/default.nix
config = mkIf (cfg.enable && config.openkrill.apps.traefik.enable) {
  openkrill.ingress.authFilters.forward = [{
    type = "ExtensionRef";
    extensionRef = {
      group = "traefik.io";
      kind  = "Middleware";
      name  = "forwardauth-authelia";
    };
  }];
};
```

### Future Provider Example (Authentik)

```nix
# In a hypothetical apps/stable/authentik/default.nix
config = mkIf (cfg.enable && config.openkrill.apps.traefik.enable) {
  openkrill.ingress.authFilters.forward = [{
    type = "ExtensionRef";
    extensionRef = {
      group = "traefik.io";
      kind  = "Middleware";
      name  = "forwardauth-authentik";
    };
  }];
};
```

Both register under `forward` — only one should be enabled at a time.
The NixOS module system will merge (or conflict on) the lists if both
are active, which is the correct behavior: enabling two ForwardAuth
providers simultaneously is a misconfiguration.

---

## Options Reference

### `openkrill.ingress.routes.<name>`

| Option      | Type                          | Default              | Description |
|-------------|-------------------------------|----------------------|-------------|
| `enable`    | `bool`                        | `true`               | Whether this route is active. |
| `subdomain` | `str`                         | *(required)*         | Subdomain prefix. Full hostname: `<subdomain>.<domain>`. |
| `domain`    | `str`                         | `openkrill.domain`   | Domain suffix. |
| `namespace` | `str`                         | *(required)*         | K8s namespace of the backend Service. |
| `service`   | `str`                         | `<name>`             | Default backend Service name. |
| `port`      | `port`                        | *(required)*         | Default backend Service port. |
| `auth`      | `enum`                        | `"forward"`          | Default auth type for paths that don't specify one. |
| `paths`     | `attrsOf pathSubmodule`       | `{}`                 | Per-path rules. Keys are URL paths (e.g. `"/api"`). |
| `filters`   | `listOf attrs`                | `[]`                 | Additional HTTPRoute filters (applied to all rules). |

### `openkrill.ingress.routes.<name>.paths.<path>`

| Option     | Type    | Default             | Description |
|------------|---------|---------------------|-------------|
| `auth`     | `enum`  | route-level `auth`  | Auth type for this path. |
| `pathType` | `enum`  | `"PathPrefix"`      | Gateway API path match type. |
| `service`  | `str`   | route-level service  | Backend Service override. |
| `port`     | `port`  | route-level port     | Backend port override. |
| `filters`  | `listOf attrs` | `[]`          | Additional HTTPRoute filters for this path. |

### Auth enum values

`"forward"` | `"token"` | `"basic"` | `"oauth"` | `"none"`

### `openkrill.ingress.authFilters` (internal)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `authFilters` | `attrsOf (listOf attrs)` | `{}` | Auth type → list of HTTPRoute filters. Populated by auth provider modules. |

---

## Consumer Examples

### Simple route (no paths — backward compatible)

```nix
openkrill.ingress.routes.vikunja = {
  subdomain = "tasks";
  namespace = cfg.namespace;
  port      = 3456;
  # auth defaults to "forward" — SSO protected
  # No paths — single catch-all rule
};
```

### Route with no auth

```nix
openkrill.ingress.routes.authelia = {
  subdomain = "auth";
  namespace = cfg.namespace;
  port      = 80;
  auth      = "none";  # Authelia itself must not go through ForwardAuth
};
```

### Route with per-path auth and backend override

```nix
openkrill.ingress.routes.my-app = {
  subdomain = "app";
  namespace = cfg.namespace;
  service   = "frontend";
  port      = 80;

  paths."/" = {
    auth = "forward";
  };

  paths."/api" = {
    auth    = "token";
    service = "api-server";
    port    = 8080;
  };
};
```

---

## Migration from auth bool

The previous `auth` option was a boolean:

| Old                | New                  |
|--------------------|----------------------|
| `auth = true`      | `auth = "forward"`   |
| `auth = false`     | `auth = "none"`      |
| *(default `true`)* | *(default `"forward"`)* |

The default behavior is preserved: routes are SSO-protected unless
explicitly opted out.
