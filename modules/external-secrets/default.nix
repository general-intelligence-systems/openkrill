# modules/external-secrets — External Secrets Operator
# Deploys ESO via Helm, RBAC for the Kubernetes provider, and a
# source namespace for central secret storage.
# CRD instances (ExternalSecret, ClusterSecretStore, etc.) are
# declared via the typed options provided by the imported CRD fragments.
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.external-secrets;
  helpers = import ../lib/helpers.nix { inherit lib; };

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

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
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
            values = cfg.values;
          })
          ++ [ sourceNamespace ]
          ++ rbacResources;
      }
      (helpers.mkExtraManifestsConfig "external-secrets" cfg.extraManifests)
    ];
  };
}
