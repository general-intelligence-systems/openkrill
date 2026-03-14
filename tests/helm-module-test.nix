# Smoke test for the helm module.
# Evaluates with representative config — any type or builder error
# fails the build.
{ pkgs }:
let
  lib = pkgs.lib;

  manifestsStub = { lib, ... }: {
    options.openkrill.manifests = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          content = lib.mkOption { type = with lib.types; either attrs (listOf attrs); };
        };
      });
      default = {};
    };
    options.openkrill.gitops = {
      repoURL = lib.mkOption { type = lib.types.str; default = "git://stub/repo.git"; };
    };
    options.openkrill.apps.argo-cd.applications = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
  };

  eval = lib.evalModules {
    modules = [
      manifestsStub
      ../apps/stable/helm/default.nix
      {
        config.openkrill.apps.helm = {
          enable = true;
          charts.traefik = {
            chart = "traefik";
            repo = "https://traefik.github.io/charts";
            version = "34.0.0";
            targetNamespace = "kube-system";
            values = { dashboard.enabled = false; };
            bootstrap = true;
          };
          charts.cert-manager = {
            chart = "cert-manager";
            repo = "https://charts.jetstack.io";
            version = "v1.17.0";
            targetNamespace = "cert-manager";
            authSecret = "repo-creds";
            valuesSecrets = [
              { name = "helm-values"; keys = [ "values.yaml" ]; }
            ];
          };
          chartConfigs.traefik = {
            valuesContent = "dashboard:\n  enabled: false\n";
            failurePolicy = "abort";
          };
        };
      }
    ];
  };

  # Force full evaluation
  content = builtins.toJSON eval.config.openkrill.manifests.helm.content;
in
pkgs.runCommand "helm-module-test" {} ''
  echo ${lib.escapeShellArg content} > $out
''
