# apps/external-secrets — External Secrets Operator
# Deploys ESO via Helm, RBAC for the Kubernetes provider, and a
# source namespace for central secret storage.
# CRD instances (ExternalSecret, ClusterSecretStore, etc.) are
# declared via the typed options provided by the imported CRD fragments.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.external-secrets;
  helpers          = import ../../../modules/lib/helpers.nix { inherit lib; };
  # ── Normalise a key entry: plain string -> mirrored {sourceKey, targetKey} ─
  normalizeKey = k:
    if builtins.isString k then { sourceKey = k; targetKey = k; } else k;



  # ── RBAC for the Kubernetes provider ──────────────────────────────────
  rbacResources = helpers.mkClusterRBAC {
    name = "eso-secret-store-reader";
    namespace = cfg.namespace;
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
  };

  # ── Source namespace ──────────────────────────────────────────────────
  sourceNamespace = k8s.mkNamespace cfg.sourceNamespace;

in
{
  imports = [
    ./acraccesstokens.nix
    ./clusterexternalsecrets.nix
    ./clustergenerators.nix
    ./clusterpushsecrets.nix
    ./clustersecretstores.nix
    ./cloudsmithaccesstokens.nix
    ./ecrauthorizationtokens.nix
    ./externalsecrets.nix
    ./fakes.nix
    ./gcraccesstokens.nix
    ./generatorstates.nix
    ./githubaccesstokens.nix
    ./grafanas.nix
    ./mfas.nix
    ./passwords.nix
    ./pushsecrets.nix
    ./quayaccesstokens.nix
    ./secretstores.nix
    ./sshkeys.nix
    ./stssessiontokens.nix
    ./uuids.nix
    ./vaultdynamicsecrets.nix
    ./webhooks.nix
  ];

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
    # ── ClusterSecretStore (Kubernetes provider) ────────────────────────
    # Reads source secrets from the secret-store namespace using the
    # eso-secret-store-reader ServiceAccount created by rbacResources.
    openkrill.apps.external-secrets.clustersecretstores.${cfg.clusterSecretStoreName} = {
      namespace = cfg.namespace;
      provider.kubernetes = {
        remoteNamespace = cfg.sourceNamespace;
        server.caProvider = {
          type = "ConfigMap";
          name = "kube-root-ca.crt";
          namespace = cfg.namespace;
          key = "ca.crt";
        };
        auth.serviceAccount = {
          name = "eso-secret-store-reader";
          namespace = cfg.namespace;
        };
      };
    };

    # ── Map secrets convenience option → typed externalsecrets CRD ────
    # The secrets.<name> option provides a simplified interface; this
    # wiring delegates to the auto-generated externalsecrets CRD module
    # so resources are type-checked and version-pinned.
    openkrill.apps.external-secrets.externalsecrets = mapAttrs (_name: sec:
      let
        hasLabels = sec.labels != {};
        hasTemplateData = sec.templateData != {};
        hasTemplate = hasLabels || hasTemplateData;
      in {
        namespace = sec.namespace;
        secretStoreRef = {
          name = cfg.clusterSecretStoreName;
          kind = "ClusterSecretStore";
        };
        refreshInterval = sec.refreshInterval;
        target = {
          name = sec.targetSecretName;
          creationPolicy = "Owner";
        } // optionalAttrs hasTemplate {
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
        data = map (key: let k = normalizeKey key; in {
          secretKey = k.targetKey;
          remoteRef = {
            key = sec.remoteSecretName;
            property = k.sourceKey;
          };
        }) sec.keys;
      }
    ) cfg.secrets;

    # ── VictoriaMetrics scrape + alerts ────────────────────────────────
    openkrill.apps.victoriametrics.vmservicescrapes.external-secrets =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        selector.matchLabels."app.kubernetes.io/name" = "external-secrets";
        namespaceSelector.matchNames = [ cfg.namespace ];
        endpoints = [{ port = "metrics"; }];
      };

    openkrill.apps.victoriametrics.vmrules.external-secrets-alerts =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        groups = [{
          name = "external-secrets";
          rules = [{
            alert = "ExternalSecretSyncFailed";
            expr = ''externalsecret_status_condition{status!="True",condition="SecretSynced"} == 1'';
            "for" = "10m";
            labels.severity = "critical";
            annotations = {
              summary = "ExternalSecret {{ $labels.name }} sync failed";
              description = "ExternalSecret {{ $labels.name }} in namespace {{ $labels.namespace }} has not synced for 10 minutes.";
            };
          }];
        }];
      };

    openkrill.apps.argocd.applications.external-secrets = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "external-secrets.yaml";
      };
      destination = {
        server = "https://kubernetes.default.svc";
        namespace = cfg.namespace;
      };
      syncPolicy = {
        automated = { prune = true; selfHeal = true; };
        syncOptions = [ "CreateNamespace=true" "ServerSideApply=true" ];
      };
    };

    openkrill.manifests.external-secrets.content =
      (kubelib.fromHelm {
        name = "external-secrets";
        chart = charts.external-secrets.external-secrets.latest;
        namespace = cfg.namespace;
        values = cfg.values;
      })
      ++ [ sourceNamespace ]
      ++ rbacResources;
  };
}
