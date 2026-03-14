# Auto-generated openkrill module fragment for envoy-gateway
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."envoy-gateway";
  compact = filterAttrs (_: v: v != null);
  RetryConstraintBudgetModule = types.submodule {
    options = {
      "interval" = mkOption {
        description = "Interval defines the duration in which requests will be considered\nfor calculating the budget for retries.\n\nSupport: Extended";
        type = (types.nullOr types.str);
        default = "10s";
      };
      "percent" = mkOption {
        description = "Percent defines the maximum percentage of active requests that may\nbe made up of retries.\n\nSupport: Extended";
        type = (types.nullOr types.int);
        default = 20;
      };
    };
  };
  mkRetryConstraintBudget =
    res:
    {
    }
    // optionalAttrs (res."interval" != null) { inherit (res) "interval"; }
    // {
    }
    // optionalAttrs (res."percent" != null) { inherit (res) "percent"; }
    // {
    };
  RetryConstraintMinRetryRateModule = types.submodule {
    options = {
      "count" = mkOption {
        description = "Count specifies the number of requests per time interval.\n\nSupport: Extended";
        type = (types.nullOr types.int);
        default = null;
      };
      "interval" = mkOption {
        description = "Interval specifies the divisor of the rate of requests, the amount of\ntime during which the given count of requests occur.\n\nSupport: Extended";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkRetryConstraintMinRetryRate =
    res:
    {
    }
    // optionalAttrs (res."count" != null) { inherit (res) "count"; }
    // {
    }
    // optionalAttrs (res."interval" != null) { inherit (res) "interval"; }
    // {
    };
  RetryConstraintModule = types.submodule {
    options = {
      "budget" = mkOption {
        description = "Budget holds the details of the retry budget configuration.";
        type = (types.nullOr RetryConstraintBudgetModule);
        default = {
          "interval" = "10s";
          "percent" = 20;
        };
      };
      "minRetryRate" = mkOption {
        description = "MinRetryRate defines the minimum rate of retries that will be allowable\nover a specified duration of time.\n\nThe effective overall minimum rate of retries targeting the backend\nservice may be much higher, as there can be any number of clients which\nare applying this setting locally.\n\nThis ensures that requests can still be retried during periods of low\ntraffic, where the budget for retries may be calculated as a very low\nvalue.\n\nSupport: Extended";
        type = (types.nullOr RetryConstraintMinRetryRateModule);
        default = {
          "count" = 10;
          "interval" = "1s";
        };
      };
    };
  };
  mkRetryConstraint =
    res:
    {
    }
    // optionalAttrs (res."budget" != null) { "budget" = mkRetryConstraintBudget res."budget"; }
    // {
    }
    // optionalAttrs (res."minRetryRate" != null) {
      "minRetryRate" = mkRetryConstraintMinRetryRate res."minRetryRate";
    }
    // {
    };
  SessionPersistenceCookieConfigModule = types.submodule {
    options = {
      "lifetimeType" = mkOption {
        description = "LifetimeType specifies whether the cookie has a permanent or\nsession-based lifetime. A permanent cookie persists until its\nspecified expiry time, defined by the Expires or Max-Age cookie\nattributes, while a session cookie is deleted when the current\nsession ends.\n\nWhen set to \"Permanent\", AbsoluteTimeout indicates the\ncookie's lifetime via the Expires or Max-Age cookie attributes\nand is required.\n\nWhen set to \"Session\", AbsoluteTimeout indicates the\nabsolute lifetime of the cookie tracked by the gateway and\nis optional.\n\nDefaults to \"Session\".\n\nSupport: Core for \"Session\" type\n\nSupport: Extended for \"Permanent\" type";
        type = (
          types.nullOr (
            types.enum [
              "Permanent"
              "Session"
            ]
          )
        );
        default = "Session";
      };
    };
  };
  mkSessionPersistenceCookieConfig =
    res:
    {
    }
    // optionalAttrs (res."lifetimeType" != null) { inherit (res) "lifetimeType"; }
    // {
    };
  SessionPersistenceModule = types.submodule {
    options = {
      "absoluteTimeout" = mkOption {
        description = "AbsoluteTimeout defines the absolute timeout of the persistent\nsession. Once the AbsoluteTimeout duration has elapsed, the\nsession becomes invalid.\n\nSupport: Extended";
        type = (types.nullOr types.str);
        default = null;
      };
      "cookieConfig" = mkOption {
        description = "CookieConfig provides configuration settings that are specific\nto cookie-based session persistence.\n\nSupport: Core";
        type = (types.nullOr SessionPersistenceCookieConfigModule);
        default = null;
      };
      "idleTimeout" = mkOption {
        description = "IdleTimeout defines the idle timeout of the persistent session.\nOnce the session has been idle for more than the specified\nIdleTimeout duration, the session becomes invalid.\n\nSupport: Extended";
        type = (types.nullOr types.str);
        default = null;
      };
      "sessionName" = mkOption {
        description = "SessionName defines the name of the persistent session token\nwhich may be reflected in the cookie or the header. Users\nshould avoid reusing session names to prevent unintended\nconsequences, such as rejection or unpredictable behavior.\n\nSupport: Implementation-specific";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "Type defines the type of session persistence such as through\nthe use a header or cookie. Defaults to cookie based session\npersistence.\n\nSupport: Core for \"Cookie\" type\n\nSupport: Extended for \"Header\" type";
        type = (
          types.nullOr (
            types.enum [
              "Cookie"
              "Header"
            ]
          )
        );
        default = "Cookie";
      };
    };
  };
  mkSessionPersistence =
    res:
    {
    }
    // optionalAttrs (res."absoluteTimeout" != null) { inherit (res) "absoluteTimeout"; }
    // {
    }
    // optionalAttrs (res."cookieConfig" != null) {
      "cookieConfig" = mkSessionPersistenceCookieConfig res."cookieConfig";
    }
    // {
    }
    // optionalAttrs (res."idleTimeout" != null) { inherit (res) "idleTimeout"; }
    // {
    }
    // optionalAttrs (res."sessionName" != null) { inherit (res) "sessionName"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  TargetRefModule = types.submodule {
    options = {
      "group" = mkOption {
        description = "Group is the group of the target resource.";
        type = types.str;
      };
      "kind" = mkOption {
        description = "Kind is kind of the target resource.";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name is the name of the target resource.";
        type = types.str;
      };
    };
  };
  mkTargetRef = res: {
    inherit (res) "group";
    inherit (res) "kind";
    inherit (res) "name";
  };
  XbackendtrafficpoliciesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this XBackendTrafficPolicy resource.";
        };
        "retryConstraint" = mkOption {
          description = "RetryConstraint defines the configuration for when to allow or prevent\nfurther retries to a target backend, by dynamically calculating a 'retry\nbudget'. This budget is calculated based on the percentage of incoming\ntraffic composed of retries over a given time interval. Once the budget\nis exceeded, additional retries will be rejected.\n\nFor example, if the retry budget interval is 10 seconds, there have been\n1000 active requests in the past 10 seconds, and the allowed percentage\nof requests that can be retried is 20% (the default), then 200 of those\nrequests may be composed of retries. Active requests will only be\nconsidered for the duration of the interval when calculating the retry\nbudget. Retrying the same original request multiple times within the\nretry budget interval will lead to each retry being counted towards\ncalculating the budget.\n\nConfiguring a RetryConstraint in BackendTrafficPolicy is compatible with\nHTTPRoute Retry settings for each HTTPRouteRule that targets the same\nbackend. While the HTTPRouteRule Retry stanza can specify whether a\nrequest will be retried, and the number of retry attempts each client\nmay perform, RetryConstraint helps prevent cascading failures such as\nretry storms during periods of consistent failures.\n\nAfter the retry budget has been exceeded, additional retries to the\nbackend MUST return a 503 response to the client.\n\nAdditional configurations for defining a constraint on retries MAY be\ndefined in the future.\n\nSupport: Extended";
          type = (types.nullOr RetryConstraintModule);
          default = null;
        };
        "sessionPersistence" = mkOption {
          description = "SessionPersistence defines and configures session persistence\nfor the backend.\n\nSupport: Extended";
          type = (types.nullOr SessionPersistenceModule);
          default = null;
        };
        "targetRefs" = mkOption {
          description = "TargetRefs identifies API object(s) to apply this policy to.\nCurrently, Backends (A grouping of like endpoints such as Service,\nServiceImport, or any implementation-specific backendRef) are the only\nvalid API target references.\n\nCurrently, a TargetRef can not be scoped to a specific port on a\nService.";
          type = (types.listOf TargetRefModule);
        };
      };
    }
  );
  mkXBackendTrafficPolicy = name: res: {
    apiVersion = "gateway.networking.x-k8s.io/v1alpha1";
    kind = "XBackendTrafficPolicy";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."retryConstraint" != null) {
      "retryConstraint" = mkRetryConstraint res."retryConstraint";
    }
    // {
    }
    // optionalAttrs (res."sessionPersistence" != null) {
      "sessionPersistence" = mkSessionPersistence res."sessionPersistence";
    }
    // {
      "targetRefs" = map mkTargetRef res."targetRefs";
    };
  };
  allResources = (mapAttrsToList mkXBackendTrafficPolicy cfg."xbackendtrafficpolicies");
in
{
  options.openkrill.apps."envoy-gateway" = {
    "xbackendtrafficpolicies" = mkOption {
      type = types.attrsOf XbackendtrafficpoliciesModule;
      default = { };
      description = "XBackendTrafficPolicy CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."envoy-gateway".content = allResources;
  };
}
