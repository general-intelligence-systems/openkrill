# apps/lldap/resources.nix — Raw K8s resources for LLDAP
#
# Returns a list of resource attrsets: Deployment + two Services.
# App secrets come from the ExternalSecret declared in default.nix.
# Database credentials come from the shared CNPG cluster's app secret,
# mirrored into this namespace via the externalsecrets typed CRD option
# declared in default.nix.
{ cfg, domain, dbSecretName }:
let
  labels = {
    "app.kubernetes.io/name" = "lldap";
    "app.kubernetes.io/instance" = "lldap";
  };
in
[
  # ── Deployment ───────────────────────────────────────────────────
  {
    apiVersion = "apps/v1";
    kind = "Deployment";
    metadata = {
      name = "lldap";
      namespace = cfg.namespace;
      inherit labels;
    };
    spec = {
      replicas = 1;
      selector.matchLabels = labels;
      template = {
        metadata = { inherit labels; };
        spec = {
          containers = [
            {
              name = "lldap";
              image = "${cfg.image.repository}:${cfg.image.tag}";
              ports = [
                { name = "ldap"; containerPort = 3890; protocol = "TCP"; }
                { name = "http"; containerPort = 17170; protocol = "TCP"; }
              ];
              env = [
                # ── Static config ────────────────────────────────
                {
                  name = "LLDAP_LDAP_BASE_DN";
                  value = cfg.baseDn;
                }
                {
                  name = "LLDAP_LDAP_USER_DN";
                  value = cfg.adminUser;
                }
                {
                  name = "LLDAP_HTTP_URL";
                  value = "https://ldap.${domain}";
                }
                # ── Secrets from ExternalSecret ──────────────────
                {
                  name = "LLDAP_JWT_SECRET";
                  valueFrom.secretKeyRef = {
                    name = "lldap";
                    key = "LLDAP_JWT_SECRET";
                  };
                }
                {
                  name = "LLDAP_KEY_SEED";
                  valueFrom.secretKeyRef = {
                    name = "lldap";
                    key = "LLDAP_KEY_SEED";
                  };
                }
                {
                  name = "LLDAP_LDAP_USER_PASS";
                  valueFrom.secretKeyRef = {
                    name = "lldap";
                    key = "LLDAP_LDAP_USER_PASS";
                  };
                }
                # ── Database from shared CNPG cluster ────────────
                # Templated URI with the lldap database name, built
                # by the ExternalSecret above.
                {
                  name = "LLDAP_DATABASE_URL";
                  valueFrom.secretKeyRef = {
                    name = dbSecretName;
                    key = "uri";
                  };
                }
              ];
              livenessProbe = {
                httpGet = {
                  path = "/";
                  port = "http";
                };
                initialDelaySeconds = 10;
                periodSeconds = 30;
              };
              readinessProbe = {
                httpGet = {
                  path = "/";
                  port = "http";
                };
                initialDelaySeconds = 5;
                periodSeconds = 10;
              };
              resources = {
                requests = {
                  cpu = "50m";
                  memory = "64Mi";
                };
                limits = {
                  memory = "256Mi";
                };
              };
            }
          ];
        };
      };
    };
  }

  # ── Service: LDAP (for Authelia and other LDAP consumers) ────────
  {
    apiVersion = "v1";
    kind = "Service";
    metadata = {
      name = "lldap";
      namespace = cfg.namespace;
      inherit labels;
    };
    spec = {
      selector = labels;
      ports = [
        { name = "ldap"; port = 3890; targetPort = "ldap"; protocol = "TCP"; }
      ];
    };
  }

  # ── Service: HTTP (for the web UI / HTTPRoute) ───────────────────
  {
    apiVersion = "v1";
    kind = "Service";
    metadata = {
      name = "lldap-http";
      namespace = cfg.namespace;
      inherit labels;
    };
    spec = {
      selector = labels;
      ports = [
        { name = "http"; port = 17170; targetPort = "http"; protocol = "TCP"; }
      ];
    };
  }
]
