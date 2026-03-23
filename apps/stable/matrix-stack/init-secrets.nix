# init-secrets.nix — Generates the matrix-stack-generated Secret.
#
# The matrix-stack Helm chart normally creates this via a pre-install/
# pre-upgrade hook Job.  Since we deploy via ArgoCD directory source,
# Helm hooks don't run.  This module produces the equivalent resources
# as regular manifests so ArgoCD applies them.
#
# The Job is idempotent: it only generates keys that don't already
# exist in the Secret, so re-running is safe.
{ lib, k8s, namespace }:
let
  name = "matrix-stack-init-secrets";
  labels = {
    "app.kubernetes.io/component" = "matrix-tools";
    "app.kubernetes.io/instance" = name;
    "app.kubernetes.io/managed-by" = "openkrill";
    "app.kubernetes.io/name" = "init-secrets";
    "app.kubernetes.io/part-of" = "matrix-stack";
  };
  image = "ghcr.io/element-hq/ess-helm/matrix-tools:0.7.3";
  secretsArg = lib.concatStringsSep "," [
    "matrix-stack-generated:POSTGRES_SYNAPSE_PASSWORD:rand32"
    "matrix-stack-generated:POSTGRES_MATRIX_AUTHENTICATION_SERVICE_PASSWORD:rand32"
    "matrix-stack-generated:POSTGRES_ADMIN_PASSWORD:rand32"
    "matrix-stack-generated:SYNAPSE_EXTRA:extra"
    "matrix-stack-generated:SYNAPSE_MACAROON:rand32"
    "matrix-stack-generated:SYNAPSE_REGISTRATION_SHARED_SECRET:rand32"
    "matrix-stack-generated:SYNAPSE_SIGNING_KEY:signingkey"
    "matrix-stack-generated:MAS_SYNAPSE_SHARED_SECRET:rand32"
    "matrix-stack-generated:MAS_ENCRYPTION_SECRET:hex32"
    "matrix-stack-generated:MAS_RSA_PRIVATE_KEY:rsa:4096:der"
    "matrix-stack-generated:MAS_ECDSA_PRIME256V1_PRIVATE_KEY:ecdsaprime256v1"
  ];
in
[
  # ── ServiceAccount ──────────────────────────────────────────────
  {
    apiVersion = "v1";
    kind = "ServiceAccount";
    metadata = {
      inherit name namespace labels;
    };
    automountServiceAccountToken = false;
  }

  # ── Role ────────────────────────────────────────────────────────
  {
    apiVersion = "rbac.authorization.k8s.io/v1";
    kind = "Role";
    metadata = {
      inherit name namespace labels;
    };
    rules = [
      {
        apiGroups = [ "" ];
        resources = [ "secrets" ];
        verbs = [ "get" "create" "update" "patch" ];
      }
      {
        apiGroups = [ "" ];
        resources = [ "configmaps" ];
        verbs = [ "get" "create" "update" "patch" ];
      }
    ];
  }

  # ── RoleBinding ─────────────────────────────────────────────────
  {
    apiVersion = "rbac.authorization.k8s.io/v1";
    kind = "RoleBinding";
    metadata = {
      inherit name namespace labels;
    };
    roleRef = {
      apiGroup = "rbac.authorization.k8s.io";
      kind = "Role";
      inherit name;
    };
    subjects = [
      {
        kind = "ServiceAccount";
        inherit name namespace;
      }
    ];
  }

  # ── Job ─────────────────────────────────────────────────────────
  {
    apiVersion = "batch/v1";
    kind = "Job";
    metadata = {
      inherit name namespace labels;
    };
    spec = {
      backoffLimit = 6;
      template = {
        metadata = { inherit labels; };
        spec = {
          serviceAccountName = name;
          automountServiceAccountToken = true;
          restartPolicy = "Never";
          securityContext = {
            runAsUser = 10010;
            runAsGroup = 10010;
            runAsNonRoot = true;
            fsGroup = 10010;
            seccompProfile.type = "RuntimeDefault";
          };
          containers = [
            {
              inherit image;
              name = "init-secrets";
              args = [
                "generate-secrets"
                "-secrets"
                secretsArg
                "-labels"
                "app.kubernetes.io/managed-by=Helm,app.kubernetes.io/part-of=matrix-stack,app.kubernetes.io/component=matrix-tools,app.kubernetes.io/name=init-secrets,app.kubernetes.io/instance=matrix-stack-init-secrets,app.kubernetes.io/version=0.7.3"
              ];
              env = [
                { name = "NAMESPACE"; value = namespace; }
              ];
              resources = {
                requests = { memory = "50Mi"; cpu = "50m"; };
                limits = { memory = "200Mi"; };
              };
              securityContext = {
                allowPrivilegeEscalation = false;
                readOnlyRootFilesystem = true;
                capabilities.drop = [ "ALL" ];
              };
            }
          ];
        };
      };
    };
  }
]
