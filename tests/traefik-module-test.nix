# Smoke test for the traefik module.
# Evaluates with representative config — any type or builder error
# fails the build.
{ pkgs }:
let
  lib = pkgs.lib;

  manifestsStub = { lib, ... }: {
    options.openkrill.manifests = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          enable  = lib.mkOption { type = lib.types.bool; default = true; };
          content = lib.mkOption { type = with lib.types; either attrs (listOf attrs); };
        };
      });
      default = {};
    };
    options.openkrill.gitops = {
      repoURL = lib.mkOption { type = lib.types.str; default = "git://stub/repo.git"; };
    };
    options.openkrill.apps.argocd.applications = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
    # Stubs for cross-module references from traefik module
    options.openkrill.apps."gateway-api" = {
      enable = lib.mkOption { type = lib.types.bool; default = false; };
      gatewayclasses = lib.mkOption { type = lib.types.attrs; default = {}; };
    };
    options.openkrill.apps.helm.chartConfigs = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
    options.openkrill.apps.authelia = {
      enable = lib.mkOption { type = lib.types.bool; default = false; };
      namespace = lib.mkOption { type = lib.types.str; default = "authelia"; };
    };
  };

  eval = lib.evalModules {
    modules = [
      manifestsStub
      ../modules/traefik/default.nix
      {
        config.openkrill.apps.traefik = {
          enable = true;

          middlewares.secure-headers = {
            namespace = "default";
            spec.headers = {
              stsSeconds = 315360000;
              browserXssFilter = true;
            };
          };

          middlewareTCPs.allow-internal = {
            namespace = "default";
            spec.ipAllowList.sourceRange = [ "10.0.0.0/8" ];
          };

          ingressRoutes.web-app = {
            namespace = "my-app";
            entryPoints = [ "websecure" ];
            routes = [
              {
                match = "Host(`app.example.com`)";
                services = [ { name = "web"; port = 8080; } ];
                middlewares = [ { name = "secure-headers"; namespace = "default"; } ];
              }
            ];
            tls.certResolver = "letsencrypt";
          };

          ingressRouteTCPs.postgres = {
            namespace = "databases";
            entryPoints = [ "postgres" ];
            routes = [
              {
                match = "HostSNI(`*`)";
                services = [ { name = "pg"; port = 5432; } ];
              }
            ];
            tls.passthrough = true;
          };
        };
      }
    ];
  };

  # Force full evaluation
  content = builtins.toJSON eval.config.openkrill.manifests.traefik.content;
in
pkgs.runCommand "traefik-module-test" {} ''
  echo ${lib.escapeShellArg content} > $out
''
