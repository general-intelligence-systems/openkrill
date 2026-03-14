# Auto-generated openkrill module fragment for clickhouse-operator
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."clickhouse-operator";
  compact = filterAttrs (_: v: v != null);
  AnnotationModule = types.submodule {
    options = {
      "exclude" = mkOption {
        description = "When propagating labels from the chi's `metadata.annotations` section to child objects' `metadata.annotations`,\nexclude annotations with names from the following list\n";
        type = (types.listOf types.str);
        default = [ ];
      };
      "include" = mkOption {
        description = "When propagating labels from the chi's `metadata.annotations` section to child objects' `metadata.annotations`,\ninclude annotations with names from the following list\n";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkAnnotation =
    res:
    {
    }
    // optionalAttrs (res."exclude" != [ ]) { inherit (res) "exclude"; }
    // {
    }
    // optionalAttrs (res."include" != [ ]) { inherit (res) "include"; }
    // {
    };
  ClickhouseAccessModule = types.submodule {
    options = {
      "password" = mkOption {
        description = "ClickHouse password to be used by operator to connect to ClickHouse instances, deprecated, use chCredentialsSecretName";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "Port to be used by operator to connect to ClickHouse instances";
        type = (types.nullOr types.int);
        default = null;
      };
      "rootCA" = mkOption {
        description = "Root certificate authority that clients use when verifying server certificates. Used for https connection to ClickHouse";
        type = (types.nullOr types.str);
        default = null;
      };
      "scheme" = mkOption {
        description = "The scheme to user for connecting to ClickHouse. Possible values: http, https, auto";
        type = (types.nullOr types.str);
        default = null;
      };
      "secret" = mkOption {
        type = (types.nullOr ClickhouseAccessSecretModule);
        default = null;
      };
      "timeouts" = mkOption {
        description = "Timeouts used to limit connection and queries from the operator to ClickHouse instances, In seconds";
        type = (types.nullOr ClickhouseAccessTimeoutsModule);
        default = null;
      };
      "username" = mkOption {
        description = "ClickHouse username to be used by operator to connect to ClickHouse instances, deprecated, use chCredentialsSecretName";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkClickhouseAccess =
    res:
    {
    }
    // optionalAttrs (res."password" != null) { inherit (res) "password"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
    }
    // optionalAttrs (res."rootCA" != null) { inherit (res) "rootCA"; }
    // {
    }
    // optionalAttrs (res."scheme" != null) { inherit (res) "scheme"; }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkClickhouseAccessSecret res."secret"; }
    // {
    }
    // optionalAttrs (res."timeouts" != null) {
      "timeouts" = mkClickhouseAccessTimeouts res."timeouts";
    }
    // {
    }
    // optionalAttrs (res."username" != null) { inherit (res) "username"; }
    // {
    };
  ClickhouseAccessSecretModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of k8s Secret with username and password to be used by operator to connect to ClickHouse instances";
        type = (types.nullOr types.str);
        default = null;
      };
      "namespace" = mkOption {
        description = "Location of k8s Secret with username and password to be used by operator to connect to ClickHouse instances";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkClickhouseAccessSecret =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    };
  ClickhouseAccessTimeoutsModule = types.submodule {
    options = {
      "connect" = mkOption {
        description = "Timout to setup connection from the operator to ClickHouse instances. In seconds.";
        type = (types.nullOr types.int);
        default = null;
      };
      "query" = mkOption {
        description = "Timout to perform SQL query from the operator to ClickHouse instances. In seconds.";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkClickhouseAccessTimeouts =
    res:
    {
    }
    // optionalAttrs (res."connect" != null) { inherit (res) "connect"; }
    // {
    }
    // optionalAttrs (res."query" != null) { inherit (res) "query"; }
    // {
    };
  ClickhouseAddonsModule = types.submodule {
    options = {
      "rules" = mkOption {
        description = "Array of set of rules per specified ClickHouse versions";
        type = (types.listOf ClickhouseAddonsRuleModule);
        default = [ ];
      };
    };
  };
  mkClickhouseAddons =
    res:
    {
    }
    // optionalAttrs (res."rules" != [ ]) { "rules" = map mkClickhouseAddonsRule res."rules"; }
    // {
    };
  ClickhouseAddonsRuleModule = types.submodule {
    options = {
      "spec" = mkOption {
        description = "spec";
        type = (types.nullOr ClickhouseAddonsRuleSpecModule);
        default = null;
      };
      "version" = mkOption {
        description = "ClickHouse version expression";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkClickhouseAddonsRule =
    res:
    {
    }
    // optionalAttrs (res."spec" != null) { "spec" = mkClickhouseAddonsRuleSpec res."spec"; }
    // {
    }
    // optionalAttrs (res."version" != null) { inherit (res) "version"; }
    // {
    };
  ClickhouseAddonsRuleSpecConfigurationModule = types.submodule {
    options = {
      "files" = mkOption {
        description = "see same section from CR spec";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "profiles" = mkOption {
        description = "see same section from CR spec";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "quotas" = mkOption {
        description = "see same section from CR spec";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "settings" = mkOption {
        description = "see same section from CR spec";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "users" = mkOption {
        description = "see same section from CR spec";
        type = (types.attrsOf types.anything);
        default = { };
      };
    };
  };
  mkClickhouseAddonsRuleSpecConfiguration =
    res:
    {
    }
    // optionalAttrs (res."files" != { }) { inherit (res) "files"; }
    // {
    }
    // optionalAttrs (res."profiles" != { }) { inherit (res) "profiles"; }
    // {
    }
    // optionalAttrs (res."quotas" != { }) { inherit (res) "quotas"; }
    // {
    }
    // optionalAttrs (res."settings" != { }) { inherit (res) "settings"; }
    // {
    }
    // optionalAttrs (res."users" != { }) { inherit (res) "users"; }
    // {
    };
  ClickhouseAddonsRuleSpecModule = types.submodule {
    options = {
      "configuration" = mkOption {
        description = "allows configure multiple aspects and behavior for `clickhouse-server` instance and also allows describe multiple `clickhouse-server` clusters inside one `chi` resource";
        type = (types.nullOr ClickhouseAddonsRuleSpecConfigurationModule);
        default = null;
      };
    };
  };
  mkClickhouseAddonsRuleSpec =
    res:
    {
    }
    // optionalAttrs (res."configuration" != null) {
      "configuration" = mkClickhouseAddonsRuleSpecConfiguration res."configuration";
    }
    // {
    };
  ClickhouseConfigurationFileModule = types.submodule {
    options = {
      "path" = mkOption {
        description = "Each 'path' can be either absolute or relative.\nIn case path is absolute - it is used as is.\nIn case path is relative - it is relative to the folder where configuration file you are reading right now is located.\n";
        type = (types.nullOr ClickhouseConfigurationFilePathModule);
        default = null;
      };
    };
  };
  mkClickhouseConfigurationFile =
    res:
    {
    }
    // optionalAttrs (res."path" != null) { "path" = mkClickhouseConfigurationFilePath res."path"; }
    // {
    };
  ClickhouseConfigurationFilePathModule = types.submodule {
    options = {
      "common" = mkOption {
        description = "Path to the folder where ClickHouse configuration files common for all instances within a CHI are located.\nDefault value - config.d\n";
        type = (types.nullOr types.str);
        default = null;
      };
      "host" = mkOption {
        description = "Path to the folder where ClickHouse configuration files unique for each instance (host) within a CHI are located.\nDefault value - conf.d\n";
        type = (types.nullOr types.str);
        default = null;
      };
      "user" = mkOption {
        description = "Path to the folder where ClickHouse configuration files with users settings are located.\nFiles are common for all instances within a CHI.\nDefault value - users.d\n";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkClickhouseConfigurationFilePath =
    res:
    {
    }
    // optionalAttrs (res."common" != null) { inherit (res) "common"; }
    // {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."user" != null) { inherit (res) "user"; }
    // {
    };
  ClickhouseConfigurationModule = types.submodule {
    options = {
      "file" = mkOption {
        type = (types.nullOr ClickhouseConfigurationFileModule);
        default = null;
      };
      "network" = mkOption {
        description = "Default network parameters for any user which will create";
        type = (types.nullOr ClickhouseConfigurationNetworkModule);
        default = null;
      };
      "user" = mkOption {
        description = "Default parameters for any user which will create";
        type = (types.nullOr ClickhouseConfigurationUserModule);
        default = null;
      };
    };
  };
  mkClickhouseConfiguration =
    res:
    {
    }
    // optionalAttrs (res."file" != null) { "file" = mkClickhouseConfigurationFile res."file"; }
    // {
    }
    // optionalAttrs (res."network" != null) {
      "network" = mkClickhouseConfigurationNetwork res."network";
    }
    // {
    }
    // optionalAttrs (res."user" != null) { "user" = mkClickhouseConfigurationUser res."user"; }
    // {
    };
  ClickhouseConfigurationNetworkModule = types.submodule {
    options = {
      "hostRegexpTemplate" = mkOption {
        description = "ClickHouse server configuration `<host_regexp>...</host_regexp>` for any <user>";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkClickhouseConfigurationNetwork =
    res:
    {
    }
    // optionalAttrs (res."hostRegexpTemplate" != null) { inherit (res) "hostRegexpTemplate"; }
    // {
    };
  ClickhouseConfigurationRestartPolicyModule = types.submodule {
    options = {
      "rules" = mkOption {
        description = "Array of set of rules per specified ClickHouse versions";
        type = (types.listOf ClickhouseConfigurationRestartPolicyRuleModule);
        default = [ ];
      };
    };
  };
  mkClickhouseConfigurationRestartPolicy =
    res:
    {
    }
    // optionalAttrs (res."rules" != [ ]) {
      "rules" = map mkClickhouseConfigurationRestartPolicyRule res."rules";
    }
    // {
    };
  ClickhouseConfigurationRestartPolicyRuleModule = types.submodule {
    options = {
      "rules" = mkOption {
        description = "Set of configuration rules for specified ClickHouse version";
        type = (types.listOf (types.attrsOf types.anything));
        default = [ ];
      };
      "version" = mkOption {
        description = "ClickHouse version expression";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkClickhouseConfigurationRestartPolicyRule =
    res:
    {
    }
    // optionalAttrs (res."rules" != [ ]) { inherit (res) "rules"; }
    // {
    }
    // optionalAttrs (res."version" != null) { inherit (res) "version"; }
    // {
    };
  ClickhouseConfigurationUserDefaultModule = types.submodule {
    options = {
      "networksIP" = mkOption {
        description = "ClickHouse server configuration `<networks><ip>...</ip></networks>` for any <user>";
        type = (types.listOf types.str);
        default = [ ];
      };
      "password" = mkOption {
        description = "ClickHouse server configuration `<password>...</password>` for any <user>";
        type = (types.nullOr types.str);
        default = null;
      };
      "profile" = mkOption {
        description = "ClickHouse server configuration `<profile>...</profile>` for any <user>";
        type = (types.nullOr types.str);
        default = null;
      };
      "quota" = mkOption {
        description = "ClickHouse server configuration `<quota>...</quota>` for any <user>";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkClickhouseConfigurationUserDefault =
    res:
    {
    }
    // optionalAttrs (res."networksIP" != [ ]) { inherit (res) "networksIP"; }
    // {
    }
    // optionalAttrs (res."password" != null) { inherit (res) "password"; }
    // {
    }
    // optionalAttrs (res."profile" != null) { inherit (res) "profile"; }
    // {
    }
    // optionalAttrs (res."quota" != null) { inherit (res) "quota"; }
    // {
    };
  ClickhouseConfigurationUserModule = types.submodule {
    options = {
      "default" = mkOption {
        type = (types.nullOr ClickhouseConfigurationUserDefaultModule);
        default = null;
      };
    };
  };
  mkClickhouseConfigurationUser =
    res:
    {
    }
    // optionalAttrs (res."default" != null) {
      "default" = mkClickhouseConfigurationUserDefault res."default";
    }
    // {
    };
  ClickhouseMetricsModule = types.submodule {
    options = {
      "timeouts" = mkOption {
        description = "Timeouts used to limit connection and queries from the metrics exporter to ClickHouse instances\nSpecified in seconds.\n";
        type = (types.nullOr ClickhouseMetricsTimeoutsModule);
        default = null;
      };
    };
  };
  mkClickhouseMetrics =
    res:
    {
    }
    // optionalAttrs (res."timeouts" != null) {
      "timeouts" = mkClickhouseMetricsTimeouts res."timeouts";
    }
    // {
    };
  ClickhouseMetricsTimeoutsModule = types.submodule {
    options = {
      "collect" = mkOption {
        description = "Timeout used to limit metrics collection request. In seconds.\nUpon reaching this timeout metrics collection is aborted and no more metrics are collected in this cycle.\nAll collected metrics are returned.\n";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkClickhouseMetricsTimeouts =
    res:
    {
    }
    // optionalAttrs (res."collect" != null) { inherit (res) "collect"; }
    // {
    };
  ClickhouseModule = types.submodule {
    options = {
      "access" = mkOption {
        description = "parameters which use for connect to clickhouse from clickhouse-operator deployment";
        type = (types.nullOr ClickhouseAccessModule);
        default = null;
      };
      "addons" = mkOption {
        description = "Configuration addons specifies additional settings";
        type = (types.nullOr ClickhouseAddonsModule);
        default = null;
      };
      "configuration" = mkOption {
        type = (types.nullOr ClickhouseConfigurationModule);
        default = null;
      };
      "configurationRestartPolicy" = mkOption {
        description = "Configuration restart policy describes what configuration changes require ClickHouse restart";
        type = (types.nullOr ClickhouseConfigurationRestartPolicyModule);
        default = null;
      };
      "metrics" = mkOption {
        description = "parameters which use for connect to fetch metrics from clickhouse by clickhouse-operator";
        type = (types.nullOr ClickhouseMetricsModule);
        default = null;
      };
    };
  };
  mkClickhouse =
    res:
    {
    }
    // optionalAttrs (res."access" != null) { "access" = mkClickhouseAccess res."access"; }
    // {
    }
    // optionalAttrs (res."addons" != null) { "addons" = mkClickhouseAddons res."addons"; }
    // {
    }
    // optionalAttrs (res."configuration" != null) {
      "configuration" = mkClickhouseConfiguration res."configuration";
    }
    // {
    }
    // optionalAttrs (res."configurationRestartPolicy" != null) {
      "configurationRestartPolicy" =
        mkClickhouseConfigurationRestartPolicy
          res."configurationRestartPolicy";
    }
    // {
    }
    // optionalAttrs (res."metrics" != null) { "metrics" = mkClickhouseMetrics res."metrics"; }
    // {
    };
  LabelModule = types.submodule {
    options = {
      "appendScope" = mkOption {
        description = "Whether to append *Scope* labels to StatefulSet and Pod\n- \"LabelShardScopeIndex\"\n- \"LabelReplicaScopeIndex\"\n- \"LabelCHIScopeIndex\"\n- \"LabelCHIScopeCycleSize\"\n- \"LabelCHIScopeCycleIndex\"\n- \"LabelCHIScopeCycleOffset\"\n- \"LabelClusterScopeIndex\"\n- \"LabelClusterScopeCycleSize\"\n- \"LabelClusterScopeCycleIndex\"\n- \"LabelClusterScopeCycleOffset\"\n";
        type = (
          types.nullOr (
            types.enum [
              ""
              "0"
              "1"
              "False"
              "false"
              "True"
              "true"
              "No"
              "no"
              "Yes"
              "yes"
              "Off"
              "off"
              "On"
              "on"
              "Disable"
              "disable"
              "Enable"
              "enable"
              "Disabled"
              "disabled"
              "Enabled"
              "enabled"
            ]
          )
        );
        default = null;
      };
      "exclude" = mkOption {
        description = "When propagating labels from the chi's `metadata.labels` section to child objects' `metadata.labels`,\nexclude labels from the following list\n";
        type = (types.listOf types.str);
        default = [ ];
      };
      "include" = mkOption {
        description = "When propagating labels from the chi's `metadata.labels` section to child objects' `metadata.labels`,\ninclude labels from the following list\n";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkLabel =
    res:
    {
    }
    // optionalAttrs (res."appendScope" != null) { inherit (res) "appendScope"; }
    // {
    }
    // optionalAttrs (res."exclude" != [ ]) { inherit (res) "exclude"; }
    // {
    }
    // optionalAttrs (res."include" != [ ]) { inherit (res) "include"; }
    // {
    };
  LoggerModule = types.submodule {
    options = {
      "alsologtostderr" = mkOption {
        description = "boolean allows logs to stderr and files both";
        type = (types.nullOr types.str);
        default = null;
      };
      "log_backtrace_at" = mkOption {
        description = "It can be set to a file and line number with a logging line.\nEx.: file.go:123\nEach time when this line is being executed, a stack trace will be written to the Info log.\n";
        type = (types.nullOr types.str);
        default = null;
      };
      "logtostderr" = mkOption {
        description = "boolean, allows logs to stderr";
        type = (types.nullOr types.str);
        default = null;
      };
      "stderrthreshold" = mkOption {
        type = (types.nullOr types.str);
        default = null;
      };
      "v" = mkOption {
        description = "verbosity level of clickhouse-operator log, default - 1 max - 9";
        type = (types.nullOr types.str);
        default = null;
      };
      "vmodule" = mkOption {
        description = "Comma-separated list of filename=N, where filename (can be a pattern) must have no .go ext, and N is a V level.\nEx.: file*=2 sets the 'V' to 2 in all files with names like file*.\n";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkLogger =
    res:
    {
    }
    // optionalAttrs (res."alsologtostderr" != null) { inherit (res) "alsologtostderr"; }
    // {
    }
    // optionalAttrs (res."log_backtrace_at" != null) { inherit (res) "log_backtrace_at"; }
    // {
    }
    // optionalAttrs (res."logtostderr" != null) { inherit (res) "logtostderr"; }
    // {
    }
    // optionalAttrs (res."stderrthreshold" != null) { inherit (res) "stderrthreshold"; }
    // {
    }
    // optionalAttrs (res."v" != null) { inherit (res) "v"; }
    // {
    }
    // optionalAttrs (res."vmodule" != null) { inherit (res) "vmodule"; }
    // {
    };
  MetricsLabelsModule = types.submodule {
    options = {
      "exclude" = mkOption {
        description = "When adding labels to a metric exclude labels with names from the following list\n";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkMetricsLabels =
    res:
    {
    }
    // optionalAttrs (res."exclude" != [ ]) { inherit (res) "exclude"; }
    // {
    };
  MetricsModule = types.submodule {
    options = {
      "labels" = mkOption {
        description = "defines metric labels options";
        type = (types.nullOr MetricsLabelsModule);
        default = null;
      };
    };
  };
  mkMetrics =
    res:
    {
    }
    // optionalAttrs (res."labels" != null) { "labels" = mkMetricsLabels res."labels"; }
    // {
    };
  PodModule = types.submodule {
    options = {
      "terminationGracePeriod" = mkOption {
        description = "Optional duration in seconds the pod needs to terminate gracefully. \nLook details in `pod.spec.terminationGracePeriodSeconds`\n";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkPod =
    res:
    {
    }
    // optionalAttrs (res."terminationGracePeriod" != null) { inherit (res) "terminationGracePeriod"; }
    // {
    };
  ReconcileHostModule = types.submodule {
    options = {
      "wait" = mkOption {
        type = (types.nullOr ReconcileHostWaitModule);
        default = null;
      };
    };
  };
  mkReconcileHost =
    res:
    {
    }
    // optionalAttrs (res."wait" != null) { "wait" = mkReconcileHostWait res."wait"; }
    // {
    };
  ReconcileHostWaitModule = types.submodule {
    options = {
      "exclude" = mkOption {
        description = "Whether the operator during reconcile procedure should wait for a ClickHouse host to be excluded from a ClickHouse cluster";
        type = (
          types.nullOr (
            types.enum [
              ""
              "0"
              "1"
              "False"
              "false"
              "True"
              "true"
              "No"
              "no"
              "Yes"
              "yes"
              "Off"
              "off"
              "On"
              "on"
              "Disable"
              "disable"
              "Enable"
              "enable"
              "Disabled"
              "disabled"
              "Enabled"
              "enabled"
            ]
          )
        );
        default = null;
      };
      "include" = mkOption {
        description = "Whether the operator during reconcile procedure should wait for a ClickHouse host to be included into a ClickHouse cluster";
        type = (
          types.nullOr (
            types.enum [
              ""
              "0"
              "1"
              "False"
              "false"
              "True"
              "true"
              "No"
              "no"
              "Yes"
              "yes"
              "Off"
              "off"
              "On"
              "on"
              "Disable"
              "disable"
              "Enable"
              "enable"
              "Disabled"
              "disabled"
              "Enabled"
              "enabled"
            ]
          )
        );
        default = null;
      };
      "queries" = mkOption {
        description = "Whether the operator during reconcile procedure should wait for a ClickHouse host to complete all running queries";
        type = (
          types.nullOr (
            types.enum [
              ""
              "0"
              "1"
              "False"
              "false"
              "True"
              "true"
              "No"
              "no"
              "Yes"
              "yes"
              "Off"
              "off"
              "On"
              "on"
              "Disable"
              "disable"
              "Enable"
              "enable"
              "Disabled"
              "disabled"
              "Enabled"
              "enabled"
            ]
          )
        );
        default = null;
      };
      "replicas" = mkOption {
        description = "Whether the operator during reconcile procedure should wait for replicas to catch-up";
        type = (types.nullOr ReconcileHostWaitReplicasModule);
        default = null;
      };
    };
  };
  mkReconcileHostWait =
    res:
    {
    }
    // optionalAttrs (res."exclude" != null) { inherit (res) "exclude"; }
    // {
    }
    // optionalAttrs (res."include" != null) { inherit (res) "include"; }
    // {
    }
    // optionalAttrs (res."queries" != null) { inherit (res) "queries"; }
    // {
    }
    // optionalAttrs (res."replicas" != null) {
      "replicas" = mkReconcileHostWaitReplicas res."replicas";
    }
    // {
    };
  ReconcileHostWaitReplicasModule = types.submodule {
    options = {
      "all" = mkOption {
        description = "Whether the operator during reconcile procedure should wait for all replicas to catch-up";
        type = (
          types.nullOr (
            types.enum [
              ""
              "0"
              "1"
              "False"
              "false"
              "True"
              "true"
              "No"
              "no"
              "Yes"
              "yes"
              "Off"
              "off"
              "On"
              "on"
              "Disable"
              "disable"
              "Enable"
              "enable"
              "Disabled"
              "disabled"
              "Enabled"
              "enabled"
            ]
          )
        );
        default = null;
      };
      "delay" = mkOption {
        description = "replication max absolute delay to consider replica is not delayed";
        type = (types.nullOr types.int);
        default = null;
      };
      "new" = mkOption {
        description = "Whether the operator during reconcile procedure should wait for new replicas to catch-up";
        type = (
          types.nullOr (
            types.enum [
              ""
              "0"
              "1"
              "False"
              "false"
              "True"
              "true"
              "No"
              "no"
              "Yes"
              "yes"
              "Off"
              "off"
              "On"
              "on"
              "Disable"
              "disable"
              "Enable"
              "enable"
              "Disabled"
              "disabled"
              "Enabled"
              "enabled"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkReconcileHostWaitReplicas =
    res:
    {
    }
    // optionalAttrs (res."all" != null) { inherit (res) "all"; }
    // {
    }
    // optionalAttrs (res."delay" != null) { inherit (res) "delay"; }
    // {
    }
    // optionalAttrs (res."new" != null) { inherit (res) "new"; }
    // {
    };
  ReconcileModule = types.submodule {
    options = {
      "host" = mkOption {
        description = "Whether the operator during reconcile procedure should wait for a ClickHouse host:\n  - to be excluded from a ClickHouse cluster\n  - to complete all running queries\n  - to be included into a ClickHouse cluster\nrespectfully before moving forward\n";
        type = (types.nullOr ReconcileHostModule);
        default = null;
      };
      "runtime" = mkOption {
        description = "runtime parameters for clickhouse-operator process which are used during reconcile cycle";
        type = (types.nullOr ReconcileRuntimeModule);
        default = null;
      };
      "statefulSet" = mkOption {
        description = "Allow change default behavior for reconciling StatefulSet which generated by clickhouse-operator";
        type = (types.nullOr ReconcileStatefulSetModule);
        default = null;
      };
    };
  };
  mkReconcile =
    res:
    {
    }
    // optionalAttrs (res."host" != null) { "host" = mkReconcileHost res."host"; }
    // {
    }
    // optionalAttrs (res."runtime" != null) { "runtime" = mkReconcileRuntime res."runtime"; }
    // {
    }
    // optionalAttrs (res."statefulSet" != null) {
      "statefulSet" = mkReconcileStatefulSet res."statefulSet";
    }
    // {
    };
  ReconcileRuntimeModule = types.submodule {
    options = {
      "reconcileCHIsThreadsNumber" = mkOption {
        description = "How many goroutines will be used to reconcile CHIs in parallel, 10 by default";
        type = (types.nullOr types.int);
        default = null;
      };
      "reconcileShardsMaxConcurrencyPercent" = mkOption {
        description = "The maximum percentage of cluster shards that may be reconciled in parallel, 50 percent by default.";
        type = (types.nullOr types.int);
        default = null;
      };
      "reconcileShardsThreadsNumber" = mkOption {
        description = "How many goroutines will be used to reconcile shards of a cluster in parallel, 1 by default";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkReconcileRuntime =
    res:
    {
    }
    // optionalAttrs (res."reconcileCHIsThreadsNumber" != null) {
      inherit (res) "reconcileCHIsThreadsNumber";
    }
    // {
    }
    // optionalAttrs (res."reconcileShardsMaxConcurrencyPercent" != null) {
      inherit (res) "reconcileShardsMaxConcurrencyPercent";
    }
    // {
    }
    // optionalAttrs (res."reconcileShardsThreadsNumber" != null) {
      inherit (res) "reconcileShardsThreadsNumber";
    }
    // {
    };
  ReconcileStatefulSetCreateModule = types.submodule {
    options = {
      "onFailure" = mkOption {
        description = "What to do in case created StatefulSet is not in Ready after `statefulSetUpdateTimeout` seconds\nPossible options:\n1. abort - do nothing, just break the process and wait for admin.\n2. delete - delete newly created problematic StatefulSet.\n3. ignore (default) - ignore error, pretend nothing happened and move on to the next StatefulSet.\n";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkReconcileStatefulSetCreate =
    res:
    {
    }
    // optionalAttrs (res."onFailure" != null) { inherit (res) "onFailure"; }
    // {
    };
  ReconcileStatefulSetModule = types.submodule {
    options = {
      "create" = mkOption {
        description = "Behavior during create StatefulSet";
        type = (types.nullOr ReconcileStatefulSetCreateModule);
        default = null;
      };
      "update" = mkOption {
        description = "Behavior during update StatefulSet";
        type = (types.nullOr ReconcileStatefulSetUpdateModule);
        default = null;
      };
    };
  };
  mkReconcileStatefulSet =
    res:
    {
    }
    // optionalAttrs (res."create" != null) { "create" = mkReconcileStatefulSetCreate res."create"; }
    // {
    }
    // optionalAttrs (res."update" != null) { "update" = mkReconcileStatefulSetUpdate res."update"; }
    // {
    };
  ReconcileStatefulSetUpdateModule = types.submodule {
    options = {
      "onFailure" = mkOption {
        description = "What to do in case updated StatefulSet is not in Ready after `statefulSetUpdateTimeout` seconds\nPossible options:\n1. abort - do nothing, just break the process and wait for admin.\n2. rollback (default) - delete Pod and rollback StatefulSet to previous Generation. Pod would be recreated by StatefulSet based on rollback-ed configuration.\n3. ignore - ignore error, pretend nothing happened and move on to the next StatefulSet.\n";
        type = (types.nullOr types.str);
        default = null;
      };
      "pollInterval" = mkOption {
        description = "How many seconds to wait between checks for created/updated StatefulSet status";
        type = (types.nullOr types.int);
        default = null;
      };
      "timeout" = mkOption {
        description = "How many seconds to wait for created/updated StatefulSet to be Ready";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkReconcileStatefulSetUpdate =
    res:
    {
    }
    // optionalAttrs (res."onFailure" != null) { inherit (res) "onFailure"; }
    // {
    }
    // optionalAttrs (res."pollInterval" != null) { inherit (res) "pollInterval"; }
    // {
    }
    // optionalAttrs (res."timeout" != null) { inherit (res) "timeout"; }
    // {
    };
  StatefulSetModule = types.submodule {
    options = {
      "revisionHistoryLimit" = mkOption {
        description = "revisionHistoryLimit is the maximum number of revisions that will be\nmaintained in the StatefulSet's revision history.                         \nLook details in `statefulset.spec.revisionHistoryLimit`\n";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkStatefulSet =
    res:
    {
    }
    // optionalAttrs (res."revisionHistoryLimit" != null) { inherit (res) "revisionHistoryLimit"; }
    // {
    };
  StatusFieldsModule = types.submodule {
    options = {
      "action" = mkOption {
        description = "Whether the operator should fill status field 'action'";
        type = (
          types.nullOr (
            types.enum [
              ""
              "0"
              "1"
              "False"
              "false"
              "True"
              "true"
              "No"
              "no"
              "Yes"
              "yes"
              "Off"
              "off"
              "On"
              "on"
              "Disable"
              "disable"
              "Enable"
              "enable"
              "Disabled"
              "disabled"
              "Enabled"
              "enabled"
            ]
          )
        );
        default = null;
      };
      "actions" = mkOption {
        description = "Whether the operator should fill status field 'actions'";
        type = (
          types.nullOr (
            types.enum [
              ""
              "0"
              "1"
              "False"
              "false"
              "True"
              "true"
              "No"
              "no"
              "Yes"
              "yes"
              "Off"
              "off"
              "On"
              "on"
              "Disable"
              "disable"
              "Enable"
              "enable"
              "Disabled"
              "disabled"
              "Enabled"
              "enabled"
            ]
          )
        );
        default = null;
      };
      "error" = mkOption {
        description = "Whether the operator should fill status field 'error'";
        type = (
          types.nullOr (
            types.enum [
              ""
              "0"
              "1"
              "False"
              "false"
              "True"
              "true"
              "No"
              "no"
              "Yes"
              "yes"
              "Off"
              "off"
              "On"
              "on"
              "Disable"
              "disable"
              "Enable"
              "enable"
              "Disabled"
              "disabled"
              "Enabled"
              "enabled"
            ]
          )
        );
        default = null;
      };
      "errors" = mkOption {
        description = "Whether the operator should fill status field 'errors'";
        type = (
          types.nullOr (
            types.enum [
              ""
              "0"
              "1"
              "False"
              "false"
              "True"
              "true"
              "No"
              "no"
              "Yes"
              "yes"
              "Off"
              "off"
              "On"
              "on"
              "Disable"
              "disable"
              "Enable"
              "enable"
              "Disabled"
              "disabled"
              "Enabled"
              "enabled"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkStatusFields =
    res:
    {
    }
    // optionalAttrs (res."action" != null) { inherit (res) "action"; }
    // {
    }
    // optionalAttrs (res."actions" != null) { inherit (res) "actions"; }
    // {
    }
    // optionalAttrs (res."error" != null) { inherit (res) "error"; }
    // {
    }
    // optionalAttrs (res."errors" != null) { inherit (res) "errors"; }
    // {
    };
  StatusModule = types.submodule {
    options = {
      "fields" = mkOption {
        description = "defines status fields options";
        type = (types.nullOr StatusFieldsModule);
        default = null;
      };
    };
  };
  mkStatus =
    res:
    {
    }
    // optionalAttrs (res."fields" != null) { "fields" = mkStatusFields res."fields"; }
    // {
    };
  TemplateChiModule = types.submodule {
    options = {
      "path" = mkOption {
        description = "Path to folder where ClickHouseInstallationTemplate .yaml manifests are located.";
        type = (types.nullOr types.str);
        default = null;
      };
      "policy" = mkOption {
        description = "CHI template updates handling policy\nPossible policy values:\n  - ReadOnStart. Accept CHIT updates on the operators start only.\n  - ApplyOnNextReconcile. Accept CHIT updates at all time. Apply news CHITs on next regular reconcile of the CHI\n";
        type = (
          types.nullOr (
            types.enum [
              ""
              "ReadOnStart"
              "ApplyOnNextReconcile"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkTemplateChi =
    res:
    {
    }
    // optionalAttrs (res."path" != null) { inherit (res) "path"; }
    // {
    }
    // optionalAttrs (res."policy" != null) { inherit (res) "policy"; }
    // {
    };
  TemplateModule = types.submodule {
    options = {
      "chi" = mkOption {
        type = (types.nullOr TemplateChiModule);
        default = null;
      };
    };
  };
  mkTemplate =
    res:
    {
    }
    // optionalAttrs (res."chi" != null) { "chi" = mkTemplateChi res."chi"; }
    // {
    };
  WatchModule = types.submodule {
    options = {
      "namespaces" = mkOption {
        description = "List of namespaces where clickhouse-operator watches for events.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkWatch =
    res:
    {
    }
    // optionalAttrs (res."namespaces" != [ ]) { inherit (res) "namespaces"; }
    // {
    };
  ClickhouseoperatorconfigurationsModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this ClickHouseOperatorConfiguration resource.";
        };
        "annotation" = mkOption {
          description = "defines which metadata.annotations items will include or exclude during render StatefulSet, Pod, PVC resources";
          type = (types.nullOr AnnotationModule);
          default = null;
        };
        "clickhouse" = mkOption {
          description = "Clickhouse related parameters used by clickhouse-operator";
          type = (types.nullOr ClickhouseModule);
          default = null;
        };
        "label" = mkOption {
          description = "defines which metadata.labels will include or exclude during render StatefulSet, Pod, PVC resources";
          type = (types.nullOr LabelModule);
          default = null;
        };
        "logger" = mkOption {
          description = "allow setup clickhouse-operator logger behavior";
          type = (types.nullOr LoggerModule);
          default = null;
        };
        "metrics" = mkOption {
          description = "defines metrics exporter options";
          type = (types.nullOr MetricsModule);
          default = null;
        };
        "pod" = mkOption {
          description = "define pod specific parameters";
          type = (types.nullOr PodModule);
          default = null;
        };
        "reconcile" = mkOption {
          description = "allow tuning reconciling process";
          type = (types.nullOr ReconcileModule);
          default = null;
        };
        "statefulSet" = mkOption {
          description = "define StatefulSet-specific parameters";
          type = (types.nullOr StatefulSetModule);
          default = null;
        };
        "status" = mkOption {
          description = "defines status options";
          type = (types.nullOr StatusModule);
          default = null;
        };
        "template" = mkOption {
          description = "Parameters which are used if you want to generate ClickHouseInstallationTemplate custom resources from files which are stored inside clickhouse-operator deployment";
          type = (types.nullOr TemplateModule);
          default = null;
        };
        "watch" = mkOption {
          description = "Parameters for watch kubernetes resources which used by clickhouse-operator deployment";
          type = (types.nullOr WatchModule);
          default = null;
        };
      };
    }
  );
  mkClickHouseOperatorConfiguration = name: res: {
    apiVersion = "clickhouse.altinity.com/v1";
    kind = "ClickHouseOperatorConfiguration";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."annotation" != null) { "annotation" = mkAnnotation res."annotation"; }
    // {
    }
    // optionalAttrs (res."clickhouse" != null) { "clickhouse" = mkClickhouse res."clickhouse"; }
    // {
    }
    // optionalAttrs (res."label" != null) { "label" = mkLabel res."label"; }
    // {
    }
    // optionalAttrs (res."logger" != null) { "logger" = mkLogger res."logger"; }
    // {
    }
    // optionalAttrs (res."metrics" != null) { "metrics" = mkMetrics res."metrics"; }
    // {
    }
    // optionalAttrs (res."pod" != null) { "pod" = mkPod res."pod"; }
    // {
    }
    // optionalAttrs (res."reconcile" != null) { "reconcile" = mkReconcile res."reconcile"; }
    // {
    }
    // optionalAttrs (res."statefulSet" != null) { "statefulSet" = mkStatefulSet res."statefulSet"; }
    // {
    }
    // optionalAttrs (res."status" != null) { "status" = mkStatus res."status"; }
    // {
    }
    // optionalAttrs (res."template" != null) { "template" = mkTemplate res."template"; }
    // {
    }
    // optionalAttrs (res."watch" != null) { "watch" = mkWatch res."watch"; }
    // {
    };
  };
  allResources = (
    mapAttrsToList mkClickHouseOperatorConfiguration cfg."clickhouseoperatorconfigurations"
  );
in
{
  options.openkrill.apps."clickhouse-operator" = {
    "clickhouseoperatorconfigurations" = mkOption {
      type = types.attrsOf ClickhouseoperatorconfigurationsModule;
      default = { };
      description = "ClickHouseOperatorConfiguration CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."clickhouse-operator".content = allResources;
  };
}
