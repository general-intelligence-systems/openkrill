# apps/killbill/resources.nix — Raw K8s resources for Kill Bill
#
# Returns a list of resource attrsets: two Deployments (killbill + kaui)
# and two Services.
#
# Kill Bill connects to PostgreSQL via JDBC using credentials from
# ExternalSecrets.  Authentication is configured via a shiro.ini file
# mounted from a Secret, seeded with the platform admin password.
#
# Kaui connects to its own PostgreSQL database and to the Kill Bill API
# at http://killbill:8080 within the cluster.
{ cfg, dbHost, killbillDbSecretName, kauiDbSecretName, authSecretName, adminUser }:
let
  killbillLabels = {
    "app.kubernetes.io/name" = "killbill";
    "app.kubernetes.io/instance" = "killbill";
    "app.kubernetes.io/component" = "api";
  };

  kauiLabels = {
    "app.kubernetes.io/name" = "killbill";
    "app.kubernetes.io/instance" = "killbill";
    "app.kubernetes.io/component" = "admin-ui";
  };
in
[
  # ── Kill Bill Deployment ────────────────────────────────────────────
  {
    apiVersion = "apps/v1";
    kind = "Deployment";
    metadata = {
      name = "killbill";
      namespace = cfg.namespace;
      labels = killbillLabels;
    };
    spec = {
      replicas = 1;
      selector.matchLabels = killbillLabels;
      template = {
        metadata.labels = killbillLabels;
        spec = {
          enableServiceLinks = false;
          containers = [
            {
              name = "killbill";
              image = "${cfg.killbill.image.repository}:${cfg.killbill.image.tag}";
              ports = [
                { name = "http"; containerPort = 8080; protocol = "TCP"; }
              ];
              env = [
                # ── Database credentials from ExternalSecret ──────
                {
                  name = "KILLBILL_DAO_URL";
                  valueFrom.secretKeyRef = {
                    name = killbillDbSecretName;
                    key = "KILLBILL_DAO_URL";
                  };
                }
                {
                  name = "KILLBILL_DAO_USER";
                  valueFrom.secretKeyRef = {
                    name = killbillDbSecretName;
                    key = "KILLBILL_DAO_USER";
                  };
                }
                {
                  name = "KILLBILL_DAO_PASSWORD";
                  valueFrom.secretKeyRef = {
                    name = killbillDbSecretName;
                    key = "KILLBILL_DAO_PASSWORD";
                  };
                }
                # ── shiro.ini for authentication ──────────────────
                {
                  name = "KILLBILL_SECURITY_SHIRO_RESOURCE_PATH";
                  value = "file:/var/lib/killbill/shiro.ini";
                }
              ];
              volumeMounts = [
                {
                  name = "shiro-config";
                  mountPath = "/var/lib/killbill/shiro.ini";
                  subPath = "shiro.ini";
                  readOnly = true;
                }
              ];
              livenessProbe = {
                httpGet = {
                  path = "/api.html";
                  port = "http";
                };
                initialDelaySeconds = 120;
                periodSeconds = 30;
                timeoutSeconds = 5;
              };
              readinessProbe = {
                httpGet = {
                  path = "/api.html";
                  port = "http";
                };
                initialDelaySeconds = 60;
                periodSeconds = 10;
                timeoutSeconds = 5;
              };
              resources = {
                requests = {
                  cpu = "500m";
                  memory = "2Gi";
                };
                limits = {
                  memory = "4Gi";
                };
              };
            }
          ];
          volumes = [
            {
              name = "shiro-config";
              secret = {
                secretName = authSecretName;
                items = [
                  { key = "shiro.ini"; path = "shiro.ini"; }
                ];
              };
            }
          ];
          restartPolicy = "Always";
        };
      };
    };
  }

  # ── Kaui Deployment ─────────────────────────────────────────────────
  {
    apiVersion = "apps/v1";
    kind = "Deployment";
    metadata = {
      name = "kaui";
      namespace = cfg.namespace;
      labels = kauiLabels;
    };
    spec = {
      replicas = 1;
      selector.matchLabels = kauiLabels;
      template = {
        metadata.labels = kauiLabels;
        spec = {
          enableServiceLinks = false;
          containers = [
            {
              name = "kaui";
              image = "${cfg.kaui.image.repository}:${cfg.kaui.image.tag}";
              ports = [
                { name = "http"; containerPort = 8080; protocol = "TCP"; }
              ];
              env = [
                # ── Kaui database credentials from ExternalSecret ──
                {
                  name = "KAUI_CONFIG_DAO_URL";
                  valueFrom.secretKeyRef = {
                    name = kauiDbSecretName;
                    key = "KAUI_CONFIG_DAO_URL";
                  };
                }
                {
                  name = "KAUI_CONFIG_DAO_USER";
                  valueFrom.secretKeyRef = {
                    name = kauiDbSecretName;
                    key = "KAUI_CONFIG_DAO_USER";
                  };
                }
                {
                  name = "KAUI_CONFIG_DAO_PASSWORD";
                  valueFrom.secretKeyRef = {
                    name = kauiDbSecretName;
                    key = "KAUI_CONFIG_DAO_PASSWORD";
                  };
                }
                # ── PostgreSQL adapter override ───────────────────
                {
                  name = "KAUI_CONFIG_DAO_ADAPTER";
                  value = "postgresql";
                }
                # ── Kill Bill API endpoint (cluster-internal) ─────
                {
                  name = "KAUI_KILLBILL_URL";
                  value = "http://killbill:8080";
                }
                # ── Root (super) user matches LLDAP admin ─────────
                {
                  name = "KAUI_ROOT_USERNAME";
                  value = adminUser;
                }
              ];
              livenessProbe = {
                httpGet = {
                  path = "/";
                  port = "http";
                };
                initialDelaySeconds = 120;
                periodSeconds = 30;
                timeoutSeconds = 5;
              };
              readinessProbe = {
                httpGet = {
                  path = "/";
                  port = "http";
                };
                initialDelaySeconds = 60;
                periodSeconds = 10;
                timeoutSeconds = 5;
              };
              resources = {
                requests = {
                  cpu = "200m";
                  memory = "1Gi";
                };
                limits = {
                  memory = "2Gi";
                };
              };
            }
          ];
          restartPolicy = "Always";
        };
      };
    };
  }

  # ── Service: Kill Bill API ──────────────────────────────────────────
  {
    apiVersion = "v1";
    kind = "Service";
    metadata = {
      name = "killbill";
      namespace = cfg.namespace;
      labels = killbillLabels;
    };
    spec = {
      selector = killbillLabels;
      ports = [
        { name = "http"; port = 8080; targetPort = "http"; protocol = "TCP"; }
      ];
    };
  }

  # ── Service: Kaui Admin UI ─────────────────────────────────────────
  {
    apiVersion = "v1";
    kind = "Service";
    metadata = {
      name = "kaui";
      namespace = cfg.namespace;
      labels = kauiLabels;
    };
    spec = {
      selector = kauiLabels;
      ports = [
        { name = "http"; port = 9090; targetPort = "http"; protocol = "TCP"; }
      ];
    };
  }
]
