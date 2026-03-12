# apps/victoriametrics — VictoriaMetrics k8s monitoring stack
# Deploys VM Operator + VMSingle + VMAgent + VMAlert + VMAlertmanager
# with node-exporter, kube-state-metrics, Grafana, and default scrape targets.
#
# CRD fragments (auto-generated from upstream CRD specs) let other app
# modules declare VMServiceScrape, VMRule, etc. under
# openkrill.apps.victoriametrics.* with mkIf so that resources are only
# rendered when this module is enabled.
{ config, lib, charts, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.victoriametrics;
  helpers          = import ../../modules/lib/helpers.nix { inherit lib; };
  networkPolicyLib = import ../../modules/lib/network-policy.nix { inherit lib; };
  domain = config.openkrill.domain;
  authFilters = if config.openkrill.apps.authelia.enable && config.openkrill.apps.traefik.enable
    then [{ type = "ExtensionRef"; extensionRef = { group = "traefik.io"; kind = "Middleware"; name = "forwardauth-authelia"; }; }]
    else [];

  defaults = {
    victoria-metrics-operator = {
      enabled = true;
      crds = {
        plain = true;
        cleanup.enabled = true;
      };
    };

    vmsingle = {
      enabled = true;
      spec = {
        retentionPeriod = "90d";
        replicaCount = 1;
        storage = {
          accessModes = [ "ReadWriteOnce" ];
          storageClassName = "local-path";
          resources.requests.storage = "50Gi";
        };
      };
      ingress.enabled = false;
    };

    vmcluster.enabled = false;

    vmagent = {
      enabled = true;
      spec = {
        scrapeInterval = "30s";
        selectAllByDefault = true;
        extraArgs = {
          "promscrape.streamParse" = "true";
          "promscrape.dropOriginalLabels" = "true";
        };
      };
      ingress.enabled = false;
    };

    vmalert = {
      enabled = true;
      spec = {
        selectAllByDefault = true;
        evaluationInterval = "30s";
      };
      ingress.enabled = false;
    };

    alertmanager = {
      enabled = true;
      spec = {
        replicaCount = 1;
        selectAllByDefault = true;
      };
      ingress.enabled = false;
    };

    vmauth.enabled = false;

    grafana = {
      enabled = true;
      ingress.enabled = false;

      persistence = {
        enabled = true;
        size = "10Gi";
        storageClassName = "local-path";
      };

      "grafana.ini" = {
        server = {
          domain = cfg.grafana.domain;
          root_url = "https://${cfg.grafana.domain}/";
        };
        "auth.proxy" = {
          enabled = true;
          header_name = "Remote-User";
          header_property = "username";
          auto_sign_up = true;
          headers = "Email:Remote-Email Groups:Remote-Groups Name:Remote-Name";
          auto_sign_up_org_role = "Admin";
        };
        auth.disable_login_form = true;
      };

      sidecar = {
        dashboards = {
          enabled = true;
          label = "grafana_dashboard";
          labelValue = "1";
        };
        datasources = {
          enabled = true;
          label = "grafana_datasource";
          labelValue = "1";
        };
      };
    };

    defaultDashboards.enabled = true;
    defaultRules.create = true;

    prometheus-node-exporter.enabled = true;
    kube-state-metrics.enabled = true;
    kubelet.enabled = true;
    kubeApiServer.enabled = true;
    coreDns.enabled = true;
    kubeEtcd.enabled = true;
    kubeScheduler.enabled = true;
    kubeControllerManager.enabled = true;
    kubeProxy.enabled = false;
  };
in
{
  imports = [
    ./vmalertmanagerconfigs.nix
    ./vmnodescrapes.nix
    ./vmpodscrapes.nix
    ./vmprobes.nix
    ./vmrules.nix
    ./vmscrapeconfigs.nix
    ./vmservicescrapes.nix
    ./vmstaticscrapes.nix
  ];

  options.openkrill.apps.victoriametrics = {
    enable = mkEnableOption "VictoriaMetrics monitoring stack";

    namespace = mkOption {
      type = types.str;
      default = "victoriametrics";
    };

    grafana.domain = mkOption {
      type = types.str;
      default = "grafana.${config.openkrill.domain}";
      description = "FQDN for Grafana.";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    networkPolicy = networkPolicyLib.mkNetworkPolicyOption;
    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    openkrill.apps.victoriametrics.networkPolicy = {
      ingress = [
        { from = "traefik"; ports = [{ port = 3000; } { port = 8428; }]; }
      ];
      egress = [
        { to = "cluster"; }
        { to = "dns"; }
      ];
    };
    openkrill.apps."gateway-api".httproutes.grafana = helpers.mkHTTPRoute {
      subdomain = "grafana";
      namespace = cfg.namespace;
      service = "victoriametrics-grafana";
      port = 80;
      filters = authFilters;
      inherit domain;
    };

    openkrill.apps.argocd.applications.victoriametrics = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "victoriametrics.yaml";
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

    openkrill.manifests.victoriametrics.content = kubelib.fromHelm {
      name = "victoriametrics";
      chart = charts.victoriametrics.victoria-metrics-k8s-stack;
      namespace = cfg.namespace;
      values = recursiveUpdate defaults cfg.values;
    };
  };
}
