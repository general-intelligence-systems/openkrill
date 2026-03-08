# modules/external-secrets — External Secrets Operator + ClusterSecretStore
# Deploys ESO, a ClusterSecretStore backed by the Kubernetes provider,
# and ExternalSecret CRs that sync secrets from a central source namespace
# into target namespaces.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.external-secrets;
  helpers = import ../lib/helpers.nix { inherit lib; };

  # ── Normalise a key entry: plain string -> mirrored {sourceKey, targetKey} ─
  normalizeKey = k:
    if builtins.isString k then { sourceKey = k; targetKey = k; } else k;

  # ── Build an ExternalSecret CR from a secret submodule entry ──────────
  mkExternalSecret = _name: sec:
    let
      hasLabels = sec.labels != {};
      hasTemplateData = sec.templateData != {};
      hasTemplate = hasLabels || hasTemplateData;

      # When templateData is used, remote-ref values are injected via
      # Go template syntax ({{ .sshPrivateKey }}) so both static and
      # dynamic values end up in the final Secret.
      templateBlock = optionalAttrs hasTemplate {
        template = {}
          // optionalAttrs hasLabels {
            metadata.labels = sec.labels;
          }
          // optionalAttrs hasTemplateData {
            data = sec.templateData
              // builtins.listToAttrs (map (key:
                let k = normalizeKey key; in
                { name = k.targetKey; value = "{{ .${k.targetKey} }}"; }
              ) sec.keys);
          };
      };
    in
    {
      apiVersion = "external-secrets.io/v1";
      kind = "ExternalSecret";
      metadata = {
        name = sec.name;
        namespace = sec.namespace;
      };
      spec = {
        refreshInterval = sec.refreshInterval;
        secretStoreRef = {
          name = cfg.clusterSecretStoreName;
          kind = "ClusterSecretStore";
        };
        target = {
          name = sec.targetSecretName;
          creationPolicy = "Owner";
        }
        // templateBlock;
        data = map (key: let k = normalizeKey key; in {
          secretKey = k.targetKey;
          remoteRef = {
            key = sec.remoteSecretName;
            property = k.sourceKey;
          };
        }) sec.keys;
      };
    };

  externalSecrets = mapAttrsToList mkExternalSecret cfg.secrets;

  # ── RBAC for the Kubernetes provider ──────────────────────────────────
  # ESO needs permission to read secrets from the source namespace.
  rbacResources = [
    {
      apiVersion = "v1";
      kind = "ServiceAccount";
      metadata = {
        name = "eso-store-sa";
        namespace = cfg.namespace;
      };
    }
    {
      apiVersion = "rbac.authorization.k8s.io/v1";
      kind = "ClusterRole";
      metadata.name = "eso-secret-store-reader";
      rules = [
        {
          apiGroups = [ "" ];
          resources = [ "secrets" ];
          verbs = [ "get" "list" "watch" ];
        }
        {
          apiGroups = [ "" ];
          resources = [ "namespaces" ];
          verbs = [ "get" "list" "watch" ];
        }
      ];
    }
    {
      apiVersion = "rbac.authorization.k8s.io/v1";
      kind = "ClusterRoleBinding";
      metadata.name = "eso-secret-store-reader";
      roleRef = {
        apiGroup = "rbac.authorization.k8s.io";
        kind = "ClusterRole";
        name = "eso-secret-store-reader";
      };
      subjects = [
        {
          kind = "ServiceAccount";
          name = "eso-store-sa";
          namespace = cfg.namespace;
        }
      ];
    }
  ];

  # ── ClusterSecretStore (Kubernetes provider) ──────────────────────────
  clusterSecretStore = {
    apiVersion = "external-secrets.io/v1";
    kind = "ClusterSecretStore";
    metadata.name = cfg.clusterSecretStoreName;
    spec.provider.kubernetes = {
      remoteNamespace = cfg.sourceNamespace;
      server = {
        caProvider = {
          type = "ConfigMap";
          name = "kube-root-ca.crt";
          key = "ca.crt";
          namespace = cfg.namespace;
        };
      };
      auth.serviceAccount = {
        name = "eso-store-sa";
        namespace = cfg.namespace;
      };
    };
  };

  # ── Source namespace ──────────────────────────────────────────────────
  sourceNamespace = k8s.mkNamespace cfg.sourceNamespace;

  # ── Helm chart defaults ──────────────────────────────────────────────
  helmDefaults = {
    installCRDs = true;
  };

in
{
  options.openkrill.apps.external-secrets = {
    enable = mkEnableOption "External Secrets Operator";

    namespace = mkOption {
      type = types.str;
      default = "external-secrets";
      description = "Namespace for the ESO operator pods.";
    };

    sourceNamespace = mkOption {
      type = types.str;
      default = "secret-store";
      description = "Namespace where source secrets are stored (read by the Kubernetes provider).";
    };

    clusterSecretStoreName = mkOption {
      type = types.str;
      default = "kubernetes";
      description = "Name of the ClusterSecretStore resource.";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    secrets = mkOption {
      type = types.attrsOf (types.submodule ({ name, ... }: {
        options = {
          name = mkOption {
            type = types.str;
            default = name;
            description = "ExternalSecret resource name.";
          };

          namespace = mkOption {
            type = types.str;
            description = "Target namespace for the synced Secret.";
          };

          targetSecretName = mkOption {
            type = types.str;
            default = name;
            description = "Name of the K8s Secret created in the target namespace.";
          };

          remoteSecretName = mkOption {
            type = types.str;
            default = name;
            description = "Name of the source Secret in the secret-store namespace.";
          };

          refreshInterval = mkOption {
            type = types.str;
            default = "1h";
            description = "How often ESO re-syncs this secret.";
          };

          labels = mkOption {
            type = types.attrsOf types.str;
            default = {};
            description = "Extra labels to apply to the target Secret.";
          };

          templateData = mkOption {
            type = types.attrsOf types.str;
            default = {};
            description = ''
              Static key/value pairs to include in the target Secret via
              ESO's template.data field. Use this to mix static values
              (e.g. type=git, url=...) with dynamic values from the
              remote secret store.
            '';
          };

          keys = mkOption {
            type = types.listOf (types.either
              types.str
              (types.submodule {
                options = {
                  sourceKey = mkOption {
                    type = types.str;
                    description = "Key name in the source Secret.";
                  };
                  targetKey = mkOption {
                    type = types.str;
                    default = "";
                    description = "Key name in the target Secret. Defaults to sourceKey.";
                  };
                };
              })
            );
            description = ''
              Key mappings from source to target Secret.
              A plain string mirrors the key (sourceKey == targetKey).
            '';
          };
        };
      }));
      default = {};
      description = "ExternalSecret definitions - each entry syncs a secret from the source namespace.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    openkrill.argocd.external-secrets.serverSideApply = true;

    openkrill.manifests = mkMerge [
      {
        external-secrets.content =
          (kubelib.fromHelm {
            name = "external-secrets";
            chart = charts.external-secrets.external-secrets;
            namespace = cfg.namespace;
            values = recursiveUpdate helmDefaults cfg.values;
          })
          ++ [ sourceNamespace clusterSecretStore ]
          ++ rbacResources
          ++ externalSecrets;
      }
      (helpers.mkExtraManifestsConfig "external-secrets" cfg.extraManifests)
    ];
  };
}
