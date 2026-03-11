# HOW-TO: Adding and Managing Secrets

This guide explains how secrets flow through the cluster, how to add a new
secret, and the edge cases to watch for.

---

## Table of Contents

1. [Architecture Overview](#architecture-overview)
2. [Secret Categories](#secret-categories)
3. [Step-by-Step: Adding a New Secret](#step-by-step-adding-a-new-secret)
4. [Edge Cases](#edge-cases)
5. [Retrieving Secrets](#retrieving-secrets)
6. [Reference: All Source Secrets](#reference-all-source-secrets)

---

## Architecture Overview

All application secrets are managed through a three-stage pipeline:

```
Stage 1: Generation             Stage 2: Storage           Stage 3: Distribution
(host systemd oneshots)         (secret-store namespace)   (ESO ExternalSecrets)

┌─────────────────────┐    ┌───────────────────────────┐    ┌─────────────────────────┐
│ openkrill-generate-  │───>│ secret-store/              │───>│ authelia/               │
│   lldap.service      │    │   openkrill-lldap          │    │   lldap                 │
│   authelia.service   │    │   openkrill-authelia       │    │   authelia               │
│   argocd.service     │    │   openkrill-argocd-oidc-*  │    │                         │
│   <runner>.service   │    │   openkrill-<runner>-*     │    │ argocd/                 │
│   ...                │    │   ...                      │    │   argocd-oidc-secret    │
└─────────────────────┘    └───────────────────────────┘    │                         │
                                                             │ forgejo-runners/        │
                                                             │   <runner>-secret       │
                                                             └─────────────────────────┘
                                  ▲                          ▲
                                  │                          │
                            ClusterSecretStore          ExternalSecret CRs
                            (kubernetes provider)       (per-app namespace)
                                  │                          │
                            ┌─────┴──────┐                   │
                            │ ESO        │───────────────────┘
                            │ Operator   │
                            └────────────┘
```

### Stage 1: Generation (`openkrill.secrets.generators`)

Each app module declares an `openkrill.secrets.generators.<name>` entry.
The `secret-generators.nix` module (`modules/secret-generators.nix`)
assembles each entry into a systemd oneshot service that runs on the VM
host at boot time, after `k3s.service`.

Generators use `kubectl` against the local k3s API server to create secrets
in the `secret-store` namespace. A shared `create_secret` helper makes
generation **idempotent** -- if a secret already exists, the generator
skips it.

Generators run as NixOS systemd services, not Kubernetes Jobs. This avoids
the chicken-and-egg problem of needing container images to create secrets
that containers need.

Cross-referenced secrets (e.g. LLDAP admin password reused by Authelia)
are handled via systemd `After=` ordering. The downstream generator reads
the already-created secret via `kubectl get`.

### Stage 2: Storage (`secret-store` namespace)

A dedicated namespace that acts as the single source of truth for all
application secrets. Nothing runs here -- it's purely a storage namespace.

The External Secrets Operator's `ClusterSecretStore` (named `kubernetes`)
is configured to read from this namespace using the Kubernetes provider.
The ClusterSecretStore is auto-created by the ESO module alongside the
RBAC and source namespace.

### Stage 3: Distribution (ExternalSecrets)

App modules declare `openkrill.apps.external-secrets.secrets.<name>` entries.
The ESO module generates `ExternalSecret` CRs from these. Each CR tells ESO
to read keys from a source secret in `secret-store` and create a target
secret in the application's namespace.

ESO owns the target secrets (`creationPolicy: Owner`). It re-syncs every
hour by default.

### What lives where

| Component | Location | Declared by |
|-----------|----------|-------------|
| ESO operator + CRDs | `external-secrets` namespace | `openkrill.apps.external-secrets` module |
| ClusterSecretStore + RBAC | `external-secrets` namespace | `openkrill.apps.external-secrets` module (auto-created) |
| `secret-store` namespace | -- | `openkrill.apps.external-secrets` module (auto-created) |
| Generator systemd services | VM host | `openkrill.secrets.generators` (declared by each app module) |
| Source secrets | `secret-store` namespace | Generator services (created at boot) |
| ExternalSecret CRs | Per-app namespaces | `openkrill.apps.external-secrets.secrets` (declared by each app module) |
| Target secrets | Per-app namespaces | ESO (created automatically from ExternalSecrets) |

---

## Secret Categories

### 1. Random credentials (most common)

Generated with `openssl rand -hex <length>`. Examples: database passwords,
session keys, HMAC secrets, JWT secrets, API keys.

```sh
openssl rand -hex 24   # 48-char hex string -- good for passwords
openssl rand -hex 32   # 64-char hex string -- good for encryption keys
```

### 2. Cryptographic keys

Generated with specific tools:

| Type | Tool | Example |
|------|------|---------|
| RSA 2048 private key | `openssl genrsa 2048` | Authelia OIDC JWKS |

### 3. Static values

Not generated -- hardcoded strings baked into the source secret alongside
generated values. Examples: usernames, email addresses, LDAP base DNs,
OIDC client secret strings.

### 4. Derived values

Composed from other generated values. Example: a database URL that
embeds the generated password:

```
postgres://windmill:$PASSWORD@windmill-pg-rw.windmill.svc:5432/windmill?sslmode=require
```

These must be generated in the same generator script as the password they
reference, since generators are idempotent and won't re-read an existing
secret to compose a new one.

### 5. Cross-referenced values

A value from one source secret that must appear in another. Example:
the LLDAP admin password must also appear in the Authelia secret as
`authentication.ldap.password.txt`.

Cross-references are handled via systemd ordering (`after` option) and
`kubectl get` to read the already-created secret.

---

## Step-by-Step: Adding a New Secret

### Example: Adding secrets for a new app module called `myapp`

Suppose `myapp` needs a database password and a session key.

### 1. Add a generator to your app module

In `apps/myapp/default.nix`, inside the `config` block:

```nix
{ config, lib, pkgs, ... }:
let cfg = config.openkrill.apps.myapp;
in {
  # ... options ...

  config = lib.mkIf cfg.enable {
    # ── Secret generator ─────────────────────────────────────────
    openkrill.secrets.generators.myapp = {
      packages = with pkgs; [ openssl ];
      script = ''
        MYAPP_PG_PASS=$(openssl rand -hex 24)
        create_secret myapp-pg-credentials \
          --from-literal=username=myapp \
          --from-literal=password="$MYAPP_PG_PASS"

        create_secret myapp-session \
          --from-literal=key="$(openssl rand -hex 32)"
      '';
    };

    # ── ExternalSecret mappings ──────────────────────────────────
    openkrill.apps.external-secrets.secrets = {
      myapp-pg-credentials = {
        namespace = cfg.namespace;
        keys = [ "username" "password" ];
      };
      myapp-session = {
        namespace = cfg.namespace;
        keys = [ "key" ];
      };
    };

    # ... rest of module config ...
  };
}
```

The `create_secret` helper is provided automatically by the preamble.
It is idempotent -- skips creation if the secret already exists.

### 2. Enable secret generation in your consumer config

In your consumer's NixOS configuration (e.g. `configuration.nix`):

```nix
openkrill.secrets.enable = true;
```

This is a one-time setup. Once enabled, all modules' generators are active.

### 3. Reference the secret in your app's Helm values

In your app's Helm values or raw resources, reference the target secret:

```nix
defaults = {
  env = [
    { name = "DATABASE_URL"; valueFrom.secretKeyRef = {
      name = "myapp-pg-credentials"; key = "password";
    }; }
    { name = "SESSION_KEY"; valueFrom.secretKeyRef = {
      name = "myapp-session"; key = "key";
    }; }
  ];
};
```

### 4. Test

Rebuild the VM image and deploy. The generator will run at boot:

```sh
# Check the generator ran
systemctl status openkrill-generate-myapp

# Check the source secret was created
kubectl -n secret-store get secret myapp-pg-credentials

# Check ESO synced the target secret
kubectl get externalsecret -n myapp
```

---

## Edge Cases

### Key renaming

When the source key name doesn't match what the app expects, use the
`{sourceKey, targetKey}` form:

```nix
my-app-keys = {
  namespace = "my-app";
  remoteSecretName = "my-app-credentials";
  keys = [
    { sourceKey = "sshPublicKey"; targetKey = "authorized_keys"; }
  ];
};
```

`sourceKey` is the key in the `secret-store` source secret.
`targetKey` is the key in the target secret the app sees.

### Different source and target secret names

By default, the ESO mapping name is used as both the source secret name
(in `secret-store`) and the target secret name (in the app namespace).
Override with `remoteSecretName` when they differ:

```nix
argocd-oidc-secret = {
  namespace = "argocd";
  remoteSecretName = "openkrill-argocd-oidc-secret";   # source in secret-store
  # target secret name defaults to "argocd-oidc-secret"
  keys = [ "oidc.authelia.clientSecret" ];
};
```

### Mixing static and dynamic values (templateData)

Some target secrets need a mix of generated values (from ESO) and static
values (hardcoded). Use `templateData` for the static parts:

```nix
argocd-repo-my-git = {
  namespace = "argocd";
  remoteSecretName = "my-git-credentials";
  labels = { "argocd.argoproj.io/secret-type" = "repository"; };
  templateData = {
    type = "git";
    url = "ssh://git@my-git.my-git.svc.cluster.local/srv/git/manifests.git";
    insecure = "true";
  };
  keys = [
    { sourceKey = "sshPrivateKey"; targetKey = "sshPrivateKey"; }
  ];
};
```

The resulting target secret contains both the static `type`, `url`,
`insecure` keys and the dynamic `sshPrivateKey` from ESO.

Under the hood, ESO's `template.data` uses Go template syntax. The module
automatically generates `{{ .sshPrivateKey }}` placeholders for each key
entry alongside the static values.

### Adding labels to target secrets

Some consumers require specific labels on secrets (e.g. ArgoCD repo
secrets need `argocd.argoproj.io/secret-type: repository`). Use the
`labels` option:

```nix
my-secret = {
  namespace = "argocd";
  labels = { "argocd.argoproj.io/secret-type" = "repository"; };
  keys = [ "token" ];
};
```

### Cross-referenced secrets

When two source secrets must share a value (e.g. LLDAP admin password =
Authelia LDAP bind password), use the `after` option to order generators,
then read the existing secret:

```nix
# In the authelia module:
openkrill.secrets.generators.authelia = {
  packages = with pkgs; [ openssl ];
  after = [ "lldap" ];
  script = ''
    # Read LLDAP password from the already-created source secret
    LLDAP_PASS=""
    if kubectl -n "$NS" get secret openkrill-lldap >/dev/null 2>&1; then
      LLDAP_PASS=$(kubectl -n "$NS" get secret openkrill-lldap \
        -o jsonpath='{.data.LLDAP_LDAP_USER_PASS}' | base64 -d)
    fi

    create_secret openkrill-authelia \
      --from-literal=authentication.ldap.password.txt="''${LLDAP_PASS:-$(openssl rand -hex 16)}" \
      ...
  '';
};
```

The `after = [ "lldap" ]` ensures `openkrill-generate-lldap.service`
runs before `openkrill-generate-authelia.service`. The generator reads
the LLDAP password from the existing secret, or falls back to a random
value if LLDAP is disabled.

**Caution:** Because generators are idempotent (skip existing secrets),
if you delete only one of two cross-referenced secrets and re-run,
the regenerated secret will have a different password than the surviving
one. Always delete both and re-run together, or delete neither.

### Derived secrets and ordering

Derived secrets (like database URLs) must be generated in the same
generator script as the password they embed. Generate them in one block:

```nix
openkrill.secrets.generators.myapp = {
  packages = with pkgs; [ openssl ];
  script = ''
    MYAPP_PG_PASS=$(openssl rand -hex 24)
    create_secret myapp-pg-credentials \
      --from-literal=username=myapp \
      --from-literal=password="$MYAPP_PG_PASS"
    create_secret myapp-db-url \
      --from-literal=url="postgres://myapp:$MYAPP_PG_PASS@myapp-pg-rw:5432/myapp"
  '';
};
```

If you need to regenerate, delete all related secrets:

```sh
kubectl -n secret-store delete secret myapp-pg-credentials myapp-db-url
```

Then restart the generator:

```sh
systemctl restart openkrill-generate-myapp
```

### SSH keypairs

SSH keys require special handling because `kubectl create secret` can't
generate them inline. Use a temp directory in the generator script:

```nix
openkrill.secrets.generators.my-git = {
  packages = with pkgs; [ openssh ];
  script = ''
    if ! kubectl -n "$NS" get secret my-git-credentials >/dev/null 2>&1; then
      TMPDIR=$(mktemp -d)
      ssh-keygen -t ed25519 -C "my-git" -N "" -f "$TMPDIR/id" >/dev/null 2>&1
      kubectl -n "$NS" create secret generic my-git-credentials \
        --from-file=sshPrivateKey="$TMPDIR/id" \
        --from-file=sshPublicKey="$TMPDIR/id.pub"
      rm -rf "$TMPDIR"
      echo "  created my-git-credentials"
    else
      echo "  skip my-git-credentials (exists)"
    fi
  '';
};
```

Note: `--from-file` is used instead of `--from-literal` because the
private key contains newlines. The `create_secret` helper is not used
here because it only supports `--from-literal`.

### Dynamic / multiple generators

When a module manages a collection of similar things (e.g. runner
instances), use `mapAttrs` to produce one generator per item:

```nix
# In the forgejo-runner module:
openkrill.secrets.generators = mapAttrs (_name: runner: {
  packages = with pkgs; [ openssl ];
  script = ''
    create_secret openkrill-${runner.secretName} \
      --from-literal=secret="$(openssl rand -hex 20)"
  '';
}) cfg.runners;

openkrill.apps.external-secrets.secrets = listToAttrs (mapAttrsToList (_name: runner:
  nameValuePair runner.secretName {
    namespace = cfg.namespace;
    remoteSecretName = "openkrill-${runner.secretName}";
    keys = [ "secret" ];
  }
) cfg.runners);
```

This creates N generators and N ExternalSecrets, one per runner instance.
The secret names are determined by the consumer's `runners` config.

### Re-running a generator

Generators are systemd oneshot services with `RemainAfterExit=true`.
To re-run one:

```sh
systemctl restart openkrill-generate-<name>
```

The generator will skip secrets that already exist. To regenerate,
first delete the source secret(s), then restart the service.

### Adding custom packages

Each generator can declare its own package dependencies via `packages`:

```nix
openkrill.secrets.generators.myapp = {
  packages = with pkgs; [ openssl htpasswd python3 ];
  script = ''
    # openssl, htpasswd, and python3 are all on $PATH
    HASH=$(htpasswd -nbBC 10 "" "$(openssl rand -hex 16)" | cut -d: -f2)
    create_secret myapp --from-literal=hash="$HASH"
  '';
};
```

`kubectl` is always included automatically.

---

## Retrieving Secrets

### Read a source secret

```sh
kubectl -n secret-store get secret <name> -o jsonpath='{.data.<key>}' | base64 -d
```

### Read a target secret (in app namespace)

```sh
kubectl -n <namespace> get secret <name> -o jsonpath='{.data.<key>}' | base64 -d
```

### Check ESO sync status

```sh
kubectl get externalsecret -A
```

Look for `SecretSynced` condition = `True`.

### Force ESO to re-sync

```sh
kubectl annotate externalsecret -n <namespace> <name> force-sync=$(date +%s) --overwrite
```

### Check generator status

```sh
# List all generators
systemctl list-units 'openkrill-generate-*'

# Check a specific generator's logs
journalctl -u openkrill-generate-authelia --no-pager
```

---

## Reference: All Source Secrets

Every secret in `secret-store` and its keys (as declared by the bundled
app modules):

| Source secret | Keys | Type | Generator |
|---------------|------|------|-----------|
| `openkrill-lldap` | `LLDAP_JWT_SECRET`, `LLDAP_KEY_SEED`, `LLDAP_LDAP_USER_PASS` | random | `lldap` |
| `openkrill-authelia` | `authentication.ldap.password.txt`, `session.encryption_key`, `storage.encryption_key`, `identity_providers.oidc.hmac_secret`, `identity_providers.oidc.jwks.0.key` | random + cross-ref + RSA key | `authelia` |
| `openkrill-argocd-oidc-secret` | `oidc.authelia.clientSecret` | deterministic | `argocd` |
| `openkrill-<runner.secretName>` | `secret` | random | `<runner-name>` (dynamic, one per runner) |

Note: The forgejo-runner module creates generators dynamically from
`cfg.runners`. The exact secret names depend on the consumer's
configuration (e.g. `openkrill-default-runner-secret`,
`openkrill-opencode-runner-secret`).

### Generator option reference

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `script` | `types.lines` | (required) | Shell script fragment for creating secrets |
| `after` | `types.listOf types.str` | `[]` | Other generator names to run after (systemd ordering) |
| `packages` | `types.listOf types.package` | `[]` | Extra packages on $PATH (kubectl is always included) |

### ExternalSecret option reference

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `namespace` | `types.str` | (required) | Target namespace for the synced secret |
| `keys` | list | (required) | List of key mappings (string or `{sourceKey, targetKey}`) |
| `remoteSecretName` | `types.str` | same as entry name | Source secret name in `secret-store` |
| `targetSecretName` | `types.str` | same as entry name | Target secret name in the app namespace |
| `refreshInterval` | `types.str` | `"1h"` | How often ESO re-syncs |
| `labels` | `types.attrsOf types.str` | `{}` | Extra labels on the target secret |
| `templateData` | `types.attrsOf types.str` | `{}` | Static key/value pairs mixed into the target secret |

### Low-level CRD option (advanced)

For cases where the convenience `secrets` option is insufficient, the
full ExternalSecret CRD schema is available as NixOS options at
`openkrill.apps."external-secrets".externalsecrets.<name>`. This provides
complete control over `data`, `dataFrom`, `target.template`,
`secretStoreRef`, `refreshPolicy`, etc. See `apps/external-secrets/externalsecrets.nix`
for the full type definition.
