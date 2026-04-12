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
{ config, lib, charts, kubelib, k8s, ... }:
with lib;
let
  cfg   = config.openkrill.apps.jambonz;
  route = config.openkrill.ingress.routes.jambonz;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };

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
    # ── Route ──────────────────────────────────────────────────────
    openkrill.ingress.routes.jambonz = {
      subdomain = "jambonz";
      namespace = cfg.namespace;
      service   = "jambonz-webapp";
      port      = 3001;
      issuerRef.name = "letsencrypt";
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
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ taintResources
      ++ import ./helm.nix { inherit lib charts kubelib cfg route; };
  };
}
