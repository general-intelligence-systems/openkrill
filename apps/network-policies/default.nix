# apps/network-policies — CiliumNetworkPolicy generation
#
# Reads per-app networkPolicy declarations from all enabled app modules
# and generates CiliumNetworkPolicy resources.  Also applies baseline
# policies for infrastructure (secret-store isolation, DNS, Cilium
# health, host-gateway).
#
# Requires Cilium as the CNI (apps/cilium).
#
# See specs/network-policies.md for the full design.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps.network-policies;
  helpers = import ../../modules/lib/helpers.nix { inherit lib; };
  allApps = config.openkrill.apps;

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

  # Build a Cilium port spec from our port module
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

  # Resolve a "from" identifier to a Cilium ingress rule
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

  # Resolve a "to" identifier to a Cilium egress rule
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

  # Generate a CiliumNetworkPolicy for one app
  mkAppPolicy = name: app:
    let
      np = app.networkPolicy;
      ns = if app ? namespace then app.namespace else name;
    in {
      apiVersion = "cilium.io/v2";
      kind = "CiliumNetworkPolicy";
      metadata = {
        inherit name;
        namespace = ns;
      };
      spec = {
        endpointSelector = np.podSelector;
      }
      // optionalAttrs (np.ingress != []) {
        ingress = map resolveIngress np.ingress;
      }
      // optionalAttrs (np.egress != []) {
        egress = map resolveEgress np.egress;
      };
    };

  appPolicies = mapAttrsToList mkAppPolicy appsWithPolicy;

  # ── Baseline policies ───────────────────────────────────────────────
  # These protect infrastructure regardless of per-app declarations.

  # Secret-store namespace: only ESO can access
  secretStorePolicy = {
    apiVersion = "cilium.io/v2";
    kind = "CiliumNetworkPolicy";
    metadata = {
      name = "secret-store-isolation";
      namespace = allApps.external-secrets.sourceNamespace or "secret-store";
    };
    spec = {
      endpointSelector = {};
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
    apiVersion = "cilium.io/v2";
    kind = "CiliumNetworkPolicy";
    metadata = {
      name = "dns-policy";
      namespace = "kube-system";
    };
    spec = {
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
    apiVersion = "cilium.io/v2";
    kind = "CiliumNetworkPolicy";
    metadata = {
      name = "cilium-internal";
      namespace = "kube-system";
    };
    spec = {
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
  # Only generated when core-dns module is enabled (it provides the
  # host-gateway DaemonSet)
  hostGatewayPolicy = {
    apiVersion = "cilium.io/v2";
    kind = "CiliumNetworkPolicy";
    metadata = {
      name = "host-gateway";
      namespace = "kube-system";
    };
    spec = {
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
    [ secretStorePolicy dnsPolicy ciliumInternalPolicy ]
    ++ optional (allApps.core-dns.enable or false) hostGatewayPolicy;

  # ── Assemble all policies ───────────────────────────────────────────
  allPolicies = appPolicies ++ baselinePolicies ++ cfg.extraPolicies;
in
{
  options.openkrill.apps.network-policies = {
    enable = mkEnableOption "CiliumNetworkPolicy generation from per-app declarations";

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
      type = types.listOf types.attrs;
      default = [];
      description = ''
        Additional CiliumNetworkPolicy resources to include alongside
        the generated policies.  Use this for custom rules that don't
        fit the per-app declaration model.
      '';
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    openkrill.apps.argocd.applications.network-policies = {
      namespace = "argocd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "network-policies.yaml";
      };
      destination = {
        server = "https://kubernetes.default.svc";
        namespace = "kube-system";
      };
      syncPolicy = {
        automated = { prune = true; selfHeal = true; };
      };
    };

    openkrill.manifests = mkMerge [
      {
        network-policies.content = allPolicies;
      }
      (helpers.mkExtraManifestsConfig "network-policies" cfg.extraManifests)
    ];
  };
}
