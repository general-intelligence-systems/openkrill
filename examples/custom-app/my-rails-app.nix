# my-rails-app.nix
#
# Example of writing your own openkrill app module.
# This lives in your repo, not in openkrill. Import it
# alongside the openkrill module and your config.
#
# Gives you typed options, cross-module references, and
# the same enable/disable pattern as built-in apps.

{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps.myRailsApp;
in
{
  options.openkrill.apps.myRailsApp = {
    enable = mkEnableOption "my Rails application";

    image = mkOption {
      type = types.str;
      default = "registry.example.com/myapp:latest";
    };

    replicas = mkOption {
      type = types.int;
      default = 2;
    };

    host = mkOption {
      type = types.str;
      default = "myapp.example.com";
    };

    env = mkOption {
      type = types.attrsOf types.str;
      default = { };
      description = "Environment variables as plain key-value pairs.";
    };
  };

  config = mkIf cfg.enable {
    openkrill.manifests = mkMerge [
      {
        "myapp-ns".content = {
          apiVersion = "v1";
          kind = "Namespace";
          metadata.name = "myapp";
        };

        "myapp-deployment".content = {
          apiVersion = "apps/v1";
          kind = "Deployment";
          metadata = {
            name = "myapp-web";
            namespace = "myapp";
          };
          spec = {
            replicas = cfg.replicas;
            selector.matchLabels.app = "myapp";
            template = {
              metadata.labels.app = "myapp";
              spec.containers = [{
                name = "web";
                image = cfg.image;
                ports = [{ containerPort = 3000; }];
                env = mapAttrsToList (name: value: {
                  inherit name value;
                }) cfg.env;
              }];
            };
          };
        };

        "myapp-service".content = {
          apiVersion = "v1";
          kind = "Service";
          metadata = {
            name = "myapp-web";
            namespace = "myapp";
          };
          spec = {
            selector.app = "myapp";
            ports = [{ port = 80; targetPort = 3000; }];
          };
        };

        "myapp-ingress".content = {
          apiVersion = "networking.k8s.io/v1";
          kind = "Ingress";
          metadata = {
            name = "myapp";
            namespace = "myapp";
            annotations."cert-manager.io/cluster-issuer" = "letsencrypt";
          };
          spec = {
            ingressClassName = "nginx";
            rules = [{
              host = cfg.host;
              http.paths = [{
                path = "/";
                pathType = "Prefix";
                backend.service = {
                  name = "myapp-web";
                  port.number = 80;
                };
              }];
            }];
            tls = [{
              secretName = "myapp-tls";
              hosts = [ cfg.host ];
            }];
          };
        };
      }

      # Wire up a ServiceMonitor when cert-manager is available
      # (demonstrates cross-module references between your app
      # and built-in openkrill modules).
      (mkIf (config.openkrill.apps.cert-manager.enable or false) {
        "myapp-certificate".content = {
          apiVersion = "cert-manager.io/v1";
          kind = "Certificate";
          metadata = {
            name = "myapp-tls";
            namespace = "myapp";
          };
          spec = {
            secretName = "myapp-tls";
            issuerRef = {
              name = "letsencrypt";
              kind = "ClusterIssuer";
            };
            dnsNames = [ cfg.host ];
          };
        };
      })
    ];
  };
}
