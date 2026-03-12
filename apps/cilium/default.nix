# apps/cilium — Cilium CNI + CiliumNetworkPolicy generation
#
# Deploys Cilium as the cluster CNI, replacing k3s's bundled Flannel.
# Provides BPF-based networking, CiliumNetworkPolicy CRDs, L7-aware
# enforcement, FQDN-based egress rules, and Hubble observability.
#
# When enabled, k3s is configured with --flannel-backend=none and
# --disable-network-policy so Cilium takes full ownership of CNI
# and network policy enforcement.
#
# Policy enforcement mode defaults to "always" (default-deny posture).
# Pods with a CiliumNetworkPolicy receive only explicitly allowed
# traffic.
#
# Network policy generation: reads per-app `networkPolicy` declarations
# and compiles them into typed CiliumNetworkPolicy CRD instances.
# Baseline policies protect infrastructure (secret-store isolation,
# DNS, Cilium health, host-gateway).
{ config, lib, charts, kubelib, ... }:
with lib;
let
  cfg = config.openkrill.apps.cilium;
  helpers = import ../../modules/lib/helpers.nix { inherit lib; };
  allApps = config.openkrill.apps;

  # ── Helm chart defaults ──────────────────────────────────────────────
  defaults = {
    # -- k3s integration --
    k8sServiceHost = "localhost";
    k8sServicePort = 6443;

    # -- CNI --
    kubeProxyReplacement = true;
    ipam.mode = "kubernetes";
    bpf.masquerade = true;

    # -- Policy enforcement --
    # "always" = default-deny: pods with a CiliumNetworkPolicy get
    # only explicitly allowed traffic.
    policyEnforcementMode = "always";

    # -- Observability --
    hubble = {
      enabled = true;
      relay.enabled = true;
    };

    # -- Metrics --
    prometheus.enabled = true;
    operator.prometheus.enabled = true;

    # -- Operator --
    operator.replicas = 1;
  };

  helmResources = kubelib.fromHelm {
    name = "cilium";
    chart = charts.cilium.cilium;
    namespace = cfg.namespace;
    values = recursiveUpdate defaults cfg.values;
  };

  # ── Identifier resolution ───────────────────────────────────────────
  # Resolves a string identifier to CiliumNetworkPolicy endpoint/entity
  # selectors.  See specs/network-policies.md "Identifier Resolution".

  # Check if an identifier looks like an FQDN (contains a dot)
  isFQDN = id: hasInfix "." id;

  # Resolve an app name to its configured namespace
  appNamespace = name:
    if allApps ? ${name} && allApps.${name} ? namespace
    then allApps.${name}.namespace
    else name;

  # Build typed Cilium toPorts from our port module
  mkCiliumPorts = ports:
    if ports == [] then {}
    else {
      toPorts = [{
        ports = map (p: {
          port = toString p.port;
          protocol = p.protocol;
        }) ports;
      }];
    };

  # DNS port spec (always UDP+TCP 53)
  dnsPortSpec = {
    toPorts = [{
      ports = [
        { port = "53"; protocol = "UDP"; }
        { port = "53"; protocol = "TCP"; }
      ];
    }];
  };

  # Resolve a "from" identifier to a typed ingress rule
  resolveIngress = rule:
    let id = rule.from; ports = mkCiliumPorts rule.ports; in
    if id == "world" then
      { fromEntities = [ "world" ]; } // ports
    else if id == "cluster" then
      { fromEntities = [ "cluster" ]; } // ports
    else if id == "traefik" then
      { fromEndpoints = [{ matchLabels = {
          "k8s:io.kubernetes.pod.namespace" = "kube-system";
          "app.kubernetes.io/name" = "traefik";
        }; }]; } // ports
    else if id == "dns" then
      { fromEndpoints = [{ matchLabels = {
          "k8s:io.kubernetes.pod.namespace" = "kube-system";
          "k8s-app" = "kube-dns";
        }; }]; } // dnsPortSpec
    else
      # App name -> namespace selector
      { fromEndpoints = [{ matchLabels = {
          "k8s:io.kubernetes.pod.namespace" = appNamespace id;
        }; }]; } // ports;

  # Resolve a "to" identifier to a typed egress rule
  resolveEgress = rule:
    let id = rule.to; ports = mkCiliumPorts rule.ports; in
    if id == "world" then
      { toEntities = [ "world" ]; } // ports
    else if id == "cluster" then
      { toEntities = [ "cluster" ]; } // ports
    else if id == "kubernetes-api" then
      { toEntities = [ "kube-apiserver" ]; } // ports
    else if id == "dns" then
      { toEndpoints = [{ matchLabels = {
          "k8s:io.kubernetes.pod.namespace" = "kube-system";
          "k8s-app" = "kube-dns";
        }; }]; } // dnsPortSpec
    else if isFQDN id then
      { toFQDNs = [{ matchName = id; }]; } // ports
    else
      # App name -> namespace selector
      { toEndpoints = [{ matchLabels = {
          "k8s:io.kubernetes.pod.namespace" = appNamespace id;
        }; }]; } // ports;

  # ── Per-app policy generation ───────────────────────────────────────
  # Collect all enabled apps that have a non-null networkPolicy
  appsWithPolicy = filterAttrs (name: app:
    app ? enable && app.enable
    && app ? networkPolicy && app.networkPolicy != null
  ) allApps;

  # Generate a typed CiliumNetworkPolicy config for one app
  mkAppPolicy = name: app:
    let
      np = app.networkPolicy;
      ns = if app ? namespace then app.namespace else name;
    in {
      namespace = ns;
      endpointSelector = np.podSelector;
    }
    // optionalAttrs (np.ingress != []) {
      ingress = map resolveIngress np.ingress;
    }
    // optionalAttrs (np.egress != []) {
      egress = map resolveEgress np.egress;
    };

  appPolicies = mapAttrs mkAppPolicy appsWithPolicy;

  # ── Baseline policies ───────────────────────────────────────────────
  # These protect infrastructure regardless of per-app declarations.

  # Secret-store namespace: only ESO can access
  secretStorePolicy = {
    secret-store-isolation = {
      namespace = allApps.external-secrets.sourceNamespace or "secret-store";
      ingress = [{
        fromEndpoints = [{
          matchLabels."k8s:io.kubernetes.pod.namespace" =
            allApps.external-secrets.namespace or "external-secrets";
        }];
      }];
    };
  };

  # DNS: CoreDNS accepts from all, egress to upstream
  dnsPolicy = {
    dns-policy = {
      namespace = "kube-system";
      endpointSelector.matchLabels."k8s-app" = "kube-dns";
      ingress = [{
        fromEndpoints = [{}];
        toPorts = [{
          ports = [
            { port = "53"; protocol = "UDP"; }
            { port = "53"; protocol = "TCP"; }
          ];
        }];
      }];
      egress = [{
        toEntities = [ "world" ];
        toPorts = [{
          ports = [
            { port = "53"; protocol = "UDP"; }
            { port = "53"; protocol = "TCP"; }
          ];
        }];
      }];
    };
  };

  # Cilium internal: health checks + API server
  ciliumInternalPolicy = {
    cilium-internal = {
      namespace = "kube-system";
      endpointSelector.matchLabels."k8s-app" = "cilium";
      ingress = [{
        fromEntities = [ "remote-node" "health" ];
      }];
      egress = [{
        toEntities = [ "remote-node" "health" "kube-apiserver" ];
      }];
    };
  };

  # Host-gateway: cluster ingress + host egress
  hostGatewayPolicy = {
    host-gateway = {
      namespace = "kube-system";
      endpointSelector.matchLabels.app = "host-gateway";
      ingress = [{
        fromEntities = [ "cluster" ];
      }];
      egress = [{
        toEntities = [ "host" ];
      }];
    };
  };

  baselinePolicies =
    secretStorePolicy
    // dnsPolicy
    // ciliumInternalPolicy
    // (optionalAttrs (allApps.core-dns.enable or false) hostGatewayPolicy);

  # Merge app-generated + baseline + user-extra policies
  allNetworkPolicies = appPolicies // baselinePolicies // cfg.extraPolicies;
in
{
  imports = [
    ./ciliumnetworkpolicies.nix
    ./ciliumclusterwidenetworkpolicies.nix
  ];

  options.openkrill.apps.cilium = {
    enable = mkEnableOption "Cilium CNI";

    namespace = mkOption {
      type = types.str;
      default = "kube-system";
      description = "Namespace for Cilium.  Defaults to kube-system.";
    };

    values = mkOption {
      type = types.attrs;
      default = {};
      description = "Helm chart value overrides, deep-merged with module defaults.";
    };

    defaultDeny = mkOption {
      type = types.bool;
      default = true;
      description = ''
        With Cilium's policyEnforcementMode=always, any pod with at
        least one CiliumNetworkPolicy gets implicit default-deny for
        all traffic not explicitly allowed.  This option is reserved
        for future use (e.g. generating empty policies per namespace
        to trigger deny for apps without declarations).
      '';
    };

    extraPolicies = mkOption {
      type = types.attrsOf types.attrs;
      default = {};
      description = ''
        Additional CiliumNetworkPolicy resources to include alongside
        the generated policies.  Keyed by policy name, values are
        typed CiliumNetworkPolicy spec attributes (namespace,
        endpointSelector, ingress, egress, etc.).
      '';
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── Compile network policies into typed CRD options ───────────────
    openkrill.apps.cilium.ciliumnetworkpolicies = allNetworkPolicies;

    # ── VictoriaMetrics scrape + alerts ────────────────────────────────
    openkrill.apps.victoriametrics.vmservicescrapes.cilium-agent =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        selector.matchLabels."k8s-app" = "cilium";
        namespaceSelector.matchNames = [ cfg.namespace ];
        endpoints = [{ port = "prometheus"; path = "/metrics"; }];
      };

    openkrill.apps.victoriametrics.vmservicescrapes.cilium-operator =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        selector.matchLabels."io.cilium/app" = "operator";
        namespaceSelector.matchNames = [ cfg.namespace ];
        endpoints = [{ port = "prometheus"; path = "/metrics"; }];
      };

    openkrill.apps.victoriametrics.vmrules.cilium-alerts =
      mkIf config.openkrill.apps.victoriametrics.enable {
        namespace = config.openkrill.apps.victoriametrics.namespace;
        groups = [{
          name = "cilium";
          rules = [
            {
              alert = "CiliumAgentUnhealthy";
              expr = ''cilium_unreachable_nodes > 0'';
              "for" = "10m";
              labels.severity = "warning";
              annotations = {
                summary = "Cilium agent has unreachable nodes";
                description = "Cilium agent on {{ $labels.instance }} reports unreachable nodes for 10 minutes.";
              };
            }
            {
              alert = "CiliumEndpointNotReady";
              expr = ''sum(cilium_endpoint_state{endpoint_state!="ready"}) > 0'';
              "for" = "15m";
              labels.severity = "warning";
              annotations = {
                summary = "Cilium endpoints not ready";
                description = "Some Cilium endpoints have been in a non-ready state for 15 minutes.";
              };
            }
          ];
        }];
      };

    openkrill.apps.argocd.applications.cilium = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "cilium.yaml";
      };
      destination = {
        server = "https://kubernetes.default.svc";
        namespace = cfg.namespace;
      };
      syncPolicy = {
        automated = { prune = true; selfHeal = true; };
        syncOptions = [ "ServerSideApply=true" ];
      };
    };

    openkrill.manifests.cilium.content = helmResources;
  };
}
