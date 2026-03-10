# modules/lib/helpers.nix
#
# Shared option types and helpers for openkrill app modules.
#
# mkExtraManifestsOption: creates the extraManifests option for a module.
# mkExtraManifestsConfig: fans extraManifests into openkrill.manifests
#   with a prefix to avoid name collisions.

{ lib }:
with lib;
rec {
  # The content type shared by openkrill.manifests and extraManifests
  manifestContentType = with types; either attrs (listOf attrs);

  # Produces the `extraManifests` option to embed in any app module
  mkExtraManifestsOption = mkOption {
    type = types.attrsOf manifestContentType;
    default = { };
    description = ''
      Extra Kubernetes manifests to deploy alongside this app.
      Each key becomes a manifest name prefixed with the app name.
      Values are either a single resource attrset or a list of
      resource attrsets (rendered as a Kubernetes List).
    '';
  };

  # Takes a prefix and the extraManifests attrset, returns config
  # to merge into openkrill.manifests
  mkExtraManifestsConfig = prefix: extraManifests:
    mapAttrs' (name: content: {
      name = "${prefix}/${name}";
      value = { inherit content; };
    }) extraManifests;

  # Generates a standard Gateway API HTTPRoute attrset.
  #
  # Example:
  #   mkHTTPRoute {
  #     subdomain = "auth";
  #     namespace = "authelia";
  #     port = 80;
  #     domain = config.openkrill.domain;
  #   }
  #
  # All fields are overridable via normal Nix module merging since the
  # result is assigned to openkrill.apps."gateway-api".httproutes.<name>.
  mkHTTPRoute = {
    subdomain,
    port,
    namespace,
    domain,
    service ? subdomain,
    gateway ? "main",
    gatewayNamespace ? "kube-system",
    filters ? [],
  }: {
    inherit namespace;
    hostnames = [ "${subdomain}.${domain}" ];
    parentRefs = [{
      name = gateway;
      namespace = gatewayNamespace;
      sectionName = "https";
    }];
    rules = [
      ({
        backendRefs = [{
          inherit namespace port;
          name = service;
        }];
      } // lib.optionalAttrs (filters != []) { inherit filters; })
    ];
  };

  # Generates a ServiceAccount + ClusterRole + ClusterRoleBinding triple.
  # Returns a list of three K8s resource attrsets.
  #
  # Example:
  #   mkClusterRBAC {
  #     name = "eso-secret-store-reader";
  #     namespace = "external-secrets";
  #     rules = [
  #       { apiGroups = [ "" ]; resources = [ "secrets" ]; verbs = [ "get" "list" "watch" ]; }
  #     ];
  #   }
  mkClusterRBAC = { name, namespace, rules }: [
    {
      apiVersion = "v1";
      kind = "ServiceAccount";
      metadata = { inherit name namespace; };
    }
    {
      apiVersion = "rbac.authorization.k8s.io/v1";
      kind = "ClusterRole";
      metadata = { inherit name; };
      inherit rules;
    }
    {
      apiVersion = "rbac.authorization.k8s.io/v1";
      kind = "ClusterRoleBinding";
      metadata = { inherit name; };
      roleRef = {
        apiGroup = "rbac.authorization.k8s.io";
        kind = "ClusterRole";
        inherit name;
      };
      subjects = [
        {
          kind = "ServiceAccount";
          inherit name namespace;
        }
      ];
    }
  ];
}
