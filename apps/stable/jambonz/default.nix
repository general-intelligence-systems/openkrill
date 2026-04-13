# apps/stable/jambonz — jambonz open-source CPaaS
#
# Deploys jambonz via the general-intelligence-systems/jambonz Helm
# chart.  Includes SIP/RTP SBC edge services, feature servers,
# webapp portal, API server, and bundled data stores (MySQL, Redis).
#
# The `clusterNodes` option taints the target node(s) with
#   jambonz=dedicated:NoSchedule
# so that SBC SIP/RTP DaemonSets have exclusive access to the host
# network stack for SIP signalling and RTP media traffic.
#
# Required ports (handled by host networking on dedicated nodes):
#   TCP/UDP 5060       — SIP signalling
#   UDP 40000–60000    — RTP media
{ config, lib, pkgs, charts, kubelib, k8s, ... }:
with lib;
let
  cfg          = config.openkrill.apps.jambonz;
  route        = config.openkrill.ingress.routes.jambonz;
  apiRoute     = config.openkrill.ingress.routes.jambonz-api;
  grafanaRoute = config.openkrill.ingress.routes.jambonz-grafana;
  homerRoute   = config.openkrill.ingress.routes.jambonz-homer;
  helpers      = import ../../../modules/lib/helpers.nix { inherit lib; };

  # ── Node taint resources ───────────────────────────────────────
  # A Job that taints + labels the target node(s) so only pods with
  # the matching toleration (i.e. jambonz SBC) can schedule there.
  taintResources = [
    {
      apiVersion = "v1";
      kind = "ServiceAccount";
      metadata = { name = "jambonz-taint-manager"; namespace = cfg.namespace; };
    }
    {
      apiVersion = "rbac.authorization.k8s.io/v1";
      kind = "ClusterRole";
      metadata.name = "jambonz-taint-manager";
      rules = [{
        apiGroups = [ "" ];
        resources = [ "nodes" ];
        verbs = [ "get" "patch" ];
      }];
    }
    {
      apiVersion = "rbac.authorization.k8s.io/v1";
      kind = "ClusterRoleBinding";
      metadata.name = "jambonz-taint-manager";
      roleRef = {
        apiGroup = "rbac.authorization.k8s.io";
        kind = "ClusterRole";
        name = "jambonz-taint-manager";
      };
      subjects = [{
        kind = "ServiceAccount";
        name = "jambonz-taint-manager";
        namespace = cfg.namespace;
      }];
    }
    {
      apiVersion = "batch/v1";
      kind = "Job";
      metadata = { name = "jambonz-taint-node"; namespace = cfg.namespace; };
      spec = {
        backoffLimit = 5;
        template = {
          metadata.labels."app.kubernetes.io/name" = "jambonz-taint-node";
          spec = {
            serviceAccountName = "jambonz-taint-manager";
            restartPolicy = "OnFailure";
            containers = [{
              name = "taint";
              image = "bitnami/kubectl:latest";
              command = [ "sh" "-c" ''
                for NODE in ${concatStringsSep " " cfg.clusterNodes}; do
                  echo "Tainting node $NODE ..."
                  kubectl taint nodes "$NODE" jambonz=dedicated:NoSchedule --overwrite
                  kubectl label nodes "$NODE" jambonz-dedicated=true --overwrite
                done
              '' ];
            }];
          };
        };
      };
    }
  ];

in
{
  options.openkrill.apps.jambonz = {
    enable = mkEnableOption "jambonz open-source CPaaS";

    namespace = mkOption {
      type = types.str;
      default = "jambonz";
      description = "Namespace for the jambonz deployment.";
    };

    clusterNodes = mkOption {
      type = types.listOf types.str;
      description = ''
        Kubernetes node names to taint with
        `jambonz=dedicated:NoSchedule` and label with
        `jambonz-dedicated=true`.  The jambonz SBC SIP and RTP
        DaemonSets will be the only workloads on these nodes, giving
        them exclusive access to the host network stack for SIP
        signalling and RTP media traffic.
      '';
      example = [ "worker-voip-01" ];
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Routes ─────────────────────────────────────────────────────
    openkrill.ingress.routes.jambonz = {
      subdomain = "jambonz";
      namespace = cfg.namespace;
      service   = "webapp";
      port      = 3001;
      auth      = "none";
      issuerRef.name = "letsencrypt";
    };

    openkrill.ingress.routes.jambonz-api = {
      subdomain = "jambonz-api";
      domain    = route.domain;
      namespace = cfg.namespace;
      service   = "api-server";
      port      = 3000;
      auth      = "none";
      issuerRef.name = "letsencrypt";
    };

    openkrill.ingress.routes.jambonz-grafana = {
      subdomain = "jambonz-grafana";
      domain    = route.domain;
      namespace = cfg.namespace;
      service   = "grafana";
      port      = 3000;
      auth      = "none";
      issuerRef.name = "letsencrypt";
    };

    openkrill.ingress.routes.jambonz-homer = {
      subdomain = "jambonz-homer";
      domain    = route.domain;
      namespace = cfg.namespace;
      service   = "homer-webapp";
      port      = 80;
      auth      = "none";
      issuerRef.name = "letsencrypt";
    };

    # ── Secret generator (reads LLDAP admin password) ──────────────
    # Runs after lldap.  Reads the LLDAP admin password and stores it
    # as ADMIN_PASSWORD alongside the other jambonz credentials so
    # the webapp login uses the same password as the rest of the stack.
    openkrill.secrets.generators.jambonz = {
      packages = with pkgs; [ openssl ];
      after = [ "lldap" ];
      script = ''
        LLDAP_PASS=""
        if kubectl -n "$NS" get secret openkrill-lldap >/dev/null 2>&1; then
          LLDAP_PASS=$(kubectl -n "$NS" get secret openkrill-lldap \
            -o jsonpath='{.data.LLDAP_LDAP_USER_PASS}' | base64 -d)
        fi

        create_secret openkrill-jambonz \
          --from-literal=MYSQL_PASSWORD="$(openssl rand -hex 16)" \
          --from-literal=DRACHTIO_SECRET="$(openssl rand -hex 16)" \
          --from-literal=JWT_SECRET="$(openssl rand -hex 32)" \
          --from-literal=POSTGRES_PASSWORD="$(openssl rand -hex 16)" \
          --from-literal=ADMIN_PASSWORD="''${LLDAP_PASS:-$(openssl rand -hex 16)}"
      '';
    };

    # ── External Secrets (distribution) ────────────────────────────
    # ESO syncs the generated secrets from secret-store into the
    # jambonz namespace as "jambonz-secrets" — the hardcoded name
    # expected by every deployment in the Helm chart.
    openkrill.apps.external-secrets.secrets.jambonz = {
      namespace = cfg.namespace;
      remoteSecretName = "openkrill-jambonz";
      targetSecretName = "jambonz-secrets";
      keys = [
        "MYSQL_PASSWORD"
        "DRACHTIO_SECRET"
        "JWT_SECRET"
        "POSTGRES_PASSWORD"
        "ADMIN_PASSWORD"
      ];
    };

    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.jambonz = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project   = "default";
      source = {
        repoURL        = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path           = ".";
        directory.include = "jambonz.yaml";
      };
      destination = {
        server    = "https://kubernetes.default.svc";
        namespace = cfg.namespace;
      };
      syncPolicy = {
        automated   = { prune = true; selfHeal = true; };
        syncOptions = [ "CreateNamespace=true" ];
      };
    };

    # ── Manifests ───────────────────────────────────────────────────
    openkrill.manifests.jambonz.content =
      let
        rawChartResources =
          import ./helm.nix { inherit lib charts kubelib cfg route; };

        # The chart hardcodes "api.<baseUrl>", "grafana.<baseUrl>",
        # and "homer.<baseUrl>".  We rewrite all three to single-level
        # subdomains for Cloudflare compatibility.
        patchHosts = r:
          builtins.fromJSON (builtins.replaceStrings
            [ "api.${route.subdomain}.${route.domain}"
              "grafana.${route.subdomain}.${route.domain}"
              "homer.${route.subdomain}.${route.domain}" ]
            [ "${apiRoute.subdomain}.${apiRoute.domain}"
              "${grafanaRoute.subdomain}.${grafanaRoute.domain}"
              "${homerRoute.subdomain}.${homerRoute.domain}" ]
            (builtins.toJSON r));
        chartResources = map patchHosts rawChartResources;

        # The Helm chart bakes secret values into a Secret and
        # several ConfigMaps.  We filter them all out and let ESO
        # manage them with generated credentials instead.
        esoManagedNames = [
          "jambonz-secrets"       # Secret
          "homer-conf"            # ConfigMap — POSTGRES_PASSWORD
          "heplify-server-conf"   # ConfigMap — POSTGRES_PASSWORD
          "jambonz-sbc-sip-conf"  # ConfigMap — DRACHTIO_SECRET
        ];
        isESOManaged = r:
          builtins.elem (r.metadata.name or "") esoManagedNames;

        # ── ESO ExternalSecrets targeting ConfigMaps ───────────────
        # Extract each ConfigMap from the Helm output, replace the
        # hardcoded secret values with ESO Go-template placeholders,
        # and wrap it in an ExternalSecret that targets a ConfigMap.
        findCM = name:
          lib.findFirst
            (r: (r.kind or "") == "ConfigMap" && (r.metadata.name or "") == name)
            (throw "ConfigMap '${name}' not found in chart output")
            chartResources;

        mkConfigMapES = { cmName, esName, keys, replacements }:
          let
            cm = findCM cmName;
            patch = v: builtins.replaceStrings
              (map (r: r.from) replacements)
              (map (r: r.to)   replacements)
              v;
          in {
            apiVersion = "external-secrets.io/v1";
            kind = "ExternalSecret";
            metadata = { inherit (cfg) namespace; name = esName; };
            spec = {
              refreshInterval = "1h";
              secretStoreRef = {
                name = "kubernetes";
                kind = "ClusterSecretStore";
              };
              target = {
                name = cmName;
                manifest = { apiVersion = "v1"; kind = "ConfigMap"; };
                template = {
                  engineVersion = "v2";
                  data = lib.mapAttrs (_: patch) cm.data;
                };
              };
              data = map (key: {
                secretKey = key;
                remoteRef = {
                  key = "openkrill-jambonz";
                  property = key;
                };
              }) keys;
            };
          };

        homerConfES = mkConfigMapES {
          cmName = "homer-conf";
          esName = "jambonz-homer-conf";
          keys   = [ "POSTGRES_PASSWORD" ];
          replacements = [
            { from = "homerSeven"; to = ''{{ .POSTGRES_PASSWORD }}''; }
          ];
        };

        heplifyConfES = mkConfigMapES {
          cmName = "heplify-server-conf";
          esName = "jambonz-heplify-conf";
          keys   = [ "POSTGRES_PASSWORD" ];
          replacements = [
            { from = "homerSeven"; to = ''{{ .POSTGRES_PASSWORD }}''; }
          ];
        };

        drachtioConfES = mkConfigMapES {
          cmName = "jambonz-sbc-sip-conf";
          esName = "jambonz-sbc-sip-conf";
          keys   = [ "DRACHTIO_SECRET" ];
          replacements = [
            { from = ''secret="cymru"''; to = ''secret="{{ .DRACHTIO_SECRET }}"''; }
          ];
        };

        # ── Admin password reset Job ─────────────────────────────────
        # Uses the db-create image (Node.js + argon2) to hash the LLDAP
        # admin password and update the jambonz admin user in MySQL.
        passwordResetJob = {
          apiVersion = "batch/v1";
          kind = "Job";
          metadata = { name = "admin-password-reset"; namespace = cfg.namespace; };
          spec = {
            backoffLimit = 5;
            template = {
              metadata.labels."app.kubernetes.io/name" = "admin-password-reset";
              spec = {
                initContainers = [{
                  name = "wait-for-schema";
                  image = "mysql:5.7";
                  command = [ "sh" "-c" ''
                    until mysql -h mysql.${cfg.namespace} -u jambones -p"$MYSQL_PASSWORD" jambones \
                      -e "SELECT 1 FROM users LIMIT 1" 2>/dev/null; do
                      echo "Waiting for schema..."
                      sleep 5
                    done
                  '' ];
                  env = [{
                    name = "MYSQL_PASSWORD";
                    valueFrom.secretKeyRef = { name = "jambonz-secrets"; key = "MYSQL_PASSWORD"; };
                  }];
                }];
                containers = [{
                  name = "reset-password";
                  image = "jambonz/db-create:10.0.3";
                  command = [ "node" "-e" ''
                    const argon2 = require('argon2');
                    const mysql = require('mysql2/promise');
                    (async () => {
                      const pass = process.env.ADMIN_PASSWORD;
                      if (!pass) { console.log('No ADMIN_PASSWORD set, skipping'); process.exit(0); }
                      const hash = await argon2.hash(pass, { type: argon2.argon2i });
                      const conn = await mysql.createConnection({
                        host: 'mysql.${cfg.namespace}',
                        user: 'jambones',
                        password: process.env.MYSQL_PASSWORD,
                        database: 'jambones'
                      });
                      const [rows] = await conn.execute(
                        'UPDATE users SET hashed_password = ?, force_change = 0 WHERE name = ?',
                        [hash, 'admin']
                      );
                      console.log('Admin password updated:', rows.affectedRows, 'row(s)');
                      await conn.end();
                    })().catch(e => { console.error(e); process.exit(1); });
                  '' ];
                  env = [
                    {
                      name = "MYSQL_PASSWORD";
                      valueFrom.secretKeyRef = { name = "jambonz-secrets"; key = "MYSQL_PASSWORD"; };
                    }
                    {
                      name = "ADMIN_PASSWORD";
                      valueFrom.secretKeyRef = { name = "jambonz-secrets"; key = "ADMIN_PASSWORD"; };
                    }
                  ];
                }];
                restartPolicy = "OnFailure";
              };
            };
          };
        };
      in
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ taintResources
      ++ (builtins.filter (r: !(isESOManaged r)) chartResources)
      ++ [ homerConfES heplifyConfES drachtioConfES passwordResetJob ];
  };
}
