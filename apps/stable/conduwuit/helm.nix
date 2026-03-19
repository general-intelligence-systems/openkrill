# Helm values for the magikid/conduwuit chart.
#
# The chart expects server_name at the top level and nests all Conduwuit
# configuration under config.global.  Defaults here are deliberately
# conservative: federation off, registration gated by a generated token
# (injected via ESO secret + extraEnv), headless ClusterIP, no ingress,
# 4Gi PVC.
#
# When lldap is enabled, LDAP config is auto-wired under config.global.ldap
# and the bind password is injected via env var from the ESO secret.
{ lib, charts, kubelib, cfg, lldapCfg, lldapEnabled }:
let
  defaults = {
    # ── Matrix identity ───────────────────────────────────────────────
    server_name = cfg.serverName;

    # ── Image — use Continuwuity's maxperf build ─────────────────────
    image = {
      repository = "forgejo.ellis.link/continuwuation/continuwuity";
      tag = "latest-maxperf";
      pullPolicy = "IfNotPresent";
    };

    # ── Conduwuit configuration ──────────────────────────────────────
    config.global = {
      # Registration is open but gated by a token injected from the
      # ESO-managed secret via extraEnv (CONDUWUIT_REGISTRATION_TOKEN).
      allow_registration = true;

      # Federation disabled by default; enable and populate
      # trusted_servers when ready to federate.
      allow_federation = false;
      trusted_servers = [];

      # Empty sections — chart renders them as-is; override via values
      # to configure TLS termination, well-known delegation, etc.
      tls = {};
      well_known = {};
      blurhashing = {};
      antispam = {};
    }
    # ── LDAP — auto-wired when lldap is enabled ──────────────────────
    # The bind password is NOT in this attrset; it's injected via the
    # CONDUWUIT_LDAP_BIND_PASSWORD env var from the ESO secret.
    // lib.optionalAttrs lldapEnabled {
      ldap = {
        enabled = true;
        url = "ldap://lldap.${lldapCfg.namespace}.svc.cluster.local:3890";
        base_dn = lldapCfg.baseDn;
        bind_dn = "UID=${lldapCfg.adminUser},OU=people,${lldapCfg.baseDn}";
        filter = "(uid={username})";
        uid_attribute = "uid";
      };
    }
    // lib.optionalAttrs (!lldapEnabled) {
      ldap = {};
    };

    # ── Secret injection ─────────────────────────────────────────────
    # NOTE: The chart's extraEnv template only supports plain `value:`
    # fields, not `valueFrom.secretKeyRef`.  Secret env vars are
    # injected by post-processing the rendered StatefulSet below.
    extraEnv = [];

    extraLabels = {};

    # ── Service — headless ClusterIP ─────────────────────────────────
    service = {
      type = "ClusterIP";
      clusterIP = "None";
      port = 80;
      annotations = {};
      externalIPs = [];
      loadBalancerIP = "";
      loadBalancerSourceRanges = [];
    };

    # ── Ingress — disabled; consumers wire via openkrill routes ──────
    ingress = {
      enabled = false;
      class = "";
      annotations = {};
      path = "/";
      extraHosts = [];
      tls = false;
    };

    # ── Persistence — 4Gi RWO PVC for the database + uploads ────────
    # Use local-path rather than longhorn: Longhorn's sparse-file
    # replica engine relies on FIEMAP/SEEK_HOLE which ZFS does not
    # support, causing "file extent is unsupported" crashes.
    persistence.data = {
      enabled = true;
      existingClaim = "";
      storageClass = "local-path";
      accessMode = "ReadWriteOnce";
      size = "4Gi";
    };

    # ── Resources ────────────────────────────────────────────────────
    resources = {
      requests = { cpu = "500m"; memory = "256Mi"; };
      limits   = { cpu = "2";    memory = "512Mi"; };
    };

    nodeSelector = {};
    tolerations = [];
    affinity = {};
  };

  # Extra env vars with secretKeyRef — injected by patching the
  # rendered StatefulSet since the chart template doesn't support
  # valueFrom.
  secretEnvVars = [
    {
      name = "CONDUWUIT_REGISTRATION_TOKEN";
      valueFrom.secretKeyRef = {
        name = "conduwuit";
        key = "CONDUWUIT_REGISTRATION_TOKEN";
      };
    }
  ] ++ lib.optionals lldapEnabled [
    {
      name = "CONDUWUIT_LDAP_BIND_PASSWORD";
      valueFrom.secretKeyRef = {
        name = "conduwuit";
        key = "CONDUWUIT_LDAP_BIND_PASSWORD";
      };
    }
  ];

  # Patch a single container's env list and readiness probe.
  # The chart hardcodes the federation /version endpoint for readiness
  # which returns 403 when allow_federation is false.
  patchContainer = c:
    if c.name or "" == "tuwunel"
    then c // {
      env = (c.env or []) ++ secretEnvVars;
      readinessProbe = (c.readinessProbe or {}) // {
        httpGet = {
          path = "/_matrix/client/versions";
          port = "http";
        };
      };
    }
    else c;

  # Patch a StatefulSet resource to inject secret env vars.
  patchResource = res:
    if (res.kind or "") == "StatefulSet"
    then res // {
      spec = res.spec // {
        template = res.spec.template // {
          spec = res.spec.template.spec // {
            containers = map patchContainer res.spec.template.spec.containers;
          };
        };
      };
    }
    else res;

  rendered = kubelib.fromHelm {
    name = "conduwuit";
    chart = charts.magikid.conduwuit.latest;
    namespace = cfg.namespace;
    values = lib.recursiveUpdate defaults cfg.values;
  };
in
map patchResource rendered
