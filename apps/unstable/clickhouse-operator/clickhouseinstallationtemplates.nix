# Auto-generated openkrill module fragment for clickhouse-operator
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."clickhouse-operator";
  compact = filterAttrs (_: v: v != null);
  ConfigurationClusterLayoutModule = types.submodule {
    options = {
      "replicas" = mkOption {
        description = "optional, allows override top-level `chi.spec.configuration` and cluster-level `chi.spec.configuration.clusters` configuration for each replica and each shard relates to selected replica, use it only if you fully understand what you do";
        type = (types.listOf ConfigurationClusterLayoutReplicaModule);
        default = [ ];
      };
      "replicasCount" = mkOption {
        description = "how much replicas in each shards for current cluster will run in Kubernetes,\neach replica is a separate `StatefulSet` which contains only one `Pod` with `clickhouse-server` instance,\nevery shard contains 1 replica by default\"\n";
        type = (types.nullOr types.int);
        default = null;
      };
      "shards" = mkOption {
        description = "optional, allows override top-level `chi.spec.configuration`, cluster-level\n`chi.spec.configuration.clusters` settings for each shard separately,\nuse it only if you fully understand what you do\"\n";
        type = (types.listOf ConfigurationClusterLayoutShardModule);
        default = [ ];
      };
      "shardsCount" = mkOption {
        description = "how much shards for current ClickHouse cluster will run in Kubernetes,\neach shard contains shared-nothing part of data and contains set of replicas,\ncluster contains 1 shard by default\"\n";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkConfigurationClusterLayout =
    res:
    {
    }
    // optionalAttrs (res."replicas" != [ ]) {
      "replicas" = map mkConfigurationClusterLayoutReplica res."replicas";
    }
    // {
    }
    // optionalAttrs (res."replicasCount" != null) { inherit (res) "replicasCount"; }
    // {
    }
    // optionalAttrs (res."shards" != [ ]) {
      "shards" = map mkConfigurationClusterLayoutShard res."shards";
    }
    // {
    }
    // optionalAttrs (res."shardsCount" != null) { inherit (res) "shardsCount"; }
    // {
    };
  ConfigurationClusterLayoutReplicaModule = types.submodule {
    options = {
      "files" = mkOption {
        description = "optional, allows define content of any setting file inside each `Pod` only in one replica during generate `ConfigMap` which will mount in `/etc/clickhouse-server/config.d/` or `/etc/clickhouse-server/conf.d/` or `/etc/clickhouse-server/users.d/`\noverride top-level `chi.spec.configuration.files` and cluster-level `chi.spec.configuration.clusters.files`, will ignore if `chi.spec.configuration.clusters.layout.shards` presents\n";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "name" = mkOption {
        description = "optional, by default replica name is generated, but you can override it and setup custom name";
        type = (types.nullOr types.str);
        default = null;
      };
      "settings" = mkOption {
        description = "optional, allows configure `clickhouse-server` settings inside <yandex>...</yandex> tag in `Pod` only in one replica during generate `ConfigMap` which will mount in `/etc/clickhouse-server/conf.d/`\noverride top-level `chi.spec.configuration.settings`, cluster-level `chi.spec.configuration.clusters.settings` and will ignore if shard-level `chi.spec.configuration.clusters.layout.shards` present\nMore details: https://clickhouse.tech/docs/en/operations/settings/settings/\n";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "shards" = mkOption {
        description = "optional, list of shards related to current replica, will ignore if `chi.spec.configuration.clusters.layout.shards` presents";
        type = (types.listOf ConfigurationClusterLayoutReplicaShardModule);
        default = [ ];
      };
      "shardsCount" = mkOption {
        description = "optional, count of shards related to current replica, you can override each shard behavior on low-level `chi.spec.configuration.clusters.layout.replicas.shards`";
        type = (types.nullOr types.int);
        default = null;
      };
      "templates" = mkOption {
        description = "optional, configuration of the templates names which will use for generate Kubernetes resources according to selected replica\noverride top-level `chi.spec.configuration.templates`, cluster-level `chi.spec.configuration.clusters.templates`\n";
        type = (types.nullOr ConfigurationClusterLayoutReplicaTemplatesModule);
        default = null;
      };
    };
  };
  mkConfigurationClusterLayoutReplica =
    res:
    {
    }
    // optionalAttrs (res."files" != { }) { inherit (res) "files"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."settings" != { }) { inherit (res) "settings"; }
    // {
    }
    // optionalAttrs (res."shards" != [ ]) {
      "shards" = map mkConfigurationClusterLayoutReplicaShard res."shards";
    }
    // {
    }
    // optionalAttrs (res."shardsCount" != null) { inherit (res) "shardsCount"; }
    // {
    }
    // optionalAttrs (res."templates" != null) {
      "templates" = mkConfigurationClusterLayoutReplicaTemplates res."templates";
    }
    // {
    };
  ConfigurationClusterLayoutReplicaShardModule = types.submodule {
    options = {
      "files" = mkOption {
        description = "optional, allows define content of any setting file inside each `Pod` only in one shard related to current replica during generate `ConfigMap` which will mount in `/etc/clickhouse-server/config.d/` or `/etc/clickhouse-server/conf.d/` or `/etc/clickhouse-server/users.d/`\noverride top-level `chi.spec.configuration.files` and cluster-level `chi.spec.configuration.clusters.files`, will ignore if `chi.spec.configuration.clusters.layout.shards` presents\n";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "httpPort" = mkOption {
        description = "optional, setup `Pod.spec.containers.ports` with name `http` for selected shard, override `chi.spec.templates.hostTemplates.spec.httpPort`\nallows connect to `clickhouse-server` via HTTP protocol via kubernetes `Service`\n";
        type = (types.nullOr types.int);
        default = null;
      };
      "httpsPort" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "insecure" = mkOption {
        description = "optional, open insecure ports for cluster, defaults to \"yes\"\n";
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
      "interserverHTTPPort" = mkOption {
        description = "optional, setup `Pod.spec.containers.ports` with name `interserver` for selected shard, override `chi.spec.templates.hostTemplates.spec.interserverHTTPPort`\nallows connect between replicas inside same shard during fetch replicated data parts HTTP protocol\n";
        type = (types.nullOr types.int);
        default = null;
      };
      "name" = mkOption {
        description = "optional, by default shard name is generated, but you can override it and setup custom name";
        type = (types.nullOr types.str);
        default = null;
      };
      "secure" = mkOption {
        description = "optional, open secure ports\n";
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
      "settings" = mkOption {
        description = "optional, allows configure `clickhouse-server` settings inside <yandex>...</yandex> tag in `Pod` only in one shard related to current replica during generate `ConfigMap` which will mount in `/etc/clickhouse-server/conf.d/`\noverride top-level `chi.spec.configuration.settings`, cluster-level `chi.spec.configuration.clusters.settings` and replica-level `chi.spec.configuration.clusters.layout.replicas.settings`\nMore details: https://clickhouse.tech/docs/en/operations/settings/settings/\n";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "tcpPort" = mkOption {
        description = "optional, setup `Pod.spec.containers.ports` with name `tcp` for selected shard, override `chi.spec.templates.hostTemplates.spec.tcpPort`\nallows connect to `clickhouse-server` via TCP Native protocol via kubernetes `Service`\n";
        type = (types.nullOr types.int);
        default = null;
      };
      "templates" = mkOption {
        description = "optional, configuration of the templates names which will use for generate Kubernetes resources according to selected replica\noverride top-level `chi.spec.configuration.templates`, cluster-level `chi.spec.configuration.clusters.templates`, replica-level `chi.spec.configuration.clusters.layout.replicas.templates`\n";
        type = (types.nullOr ConfigurationClusterLayoutReplicaShardTemplatesModule);
        default = null;
      };
      "tlsPort" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkConfigurationClusterLayoutReplicaShard =
    res:
    {
    }
    // optionalAttrs (res."files" != { }) { inherit (res) "files"; }
    // {
    }
    // optionalAttrs (res."httpPort" != null) { inherit (res) "httpPort"; }
    // {
    }
    // optionalAttrs (res."httpsPort" != null) { inherit (res) "httpsPort"; }
    // {
    }
    // optionalAttrs (res."insecure" != null) { inherit (res) "insecure"; }
    // {
    }
    // optionalAttrs (res."interserverHTTPPort" != null) { inherit (res) "interserverHTTPPort"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."secure" != null) { inherit (res) "secure"; }
    // {
    }
    // optionalAttrs (res."settings" != { }) { inherit (res) "settings"; }
    // {
    }
    // optionalAttrs (res."tcpPort" != null) { inherit (res) "tcpPort"; }
    // {
    }
    // optionalAttrs (res."templates" != null) {
      "templates" = mkConfigurationClusterLayoutReplicaShardTemplates res."templates";
    }
    // {
    }
    // optionalAttrs (res."tlsPort" != null) { inherit (res) "tlsPort"; }
    // {
    };
  ConfigurationClusterLayoutReplicaShardTemplatesModule = types.submodule {
    options = {
      "clusterServiceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates, allows customization for each `Service` resource which will created by `clickhouse-operator` which cover each clickhouse cluster described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "dataVolumeClaimTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.volumeClaimTemplates, allows customization each `PVC` which will mount for clickhouse data directory in each `Pod` during render and reconcile every StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "hostTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.hostTemplates, which will apply to configure every `clickhouse-server` instance during render ConfigMap resources which will mount into `Pod`";
        type = (types.nullOr types.str);
        default = null;
      };
      "logVolumeClaimTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.volumeClaimTemplates, allows customization each `PVC` which will mount for clickhouse log directory in each `Pod` during render and reconcile every StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "podTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.podTemplates, allows customization each `Pod` resource during render and reconcile each StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "replicaServiceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates, allows customization for each `Service` resource which will created by `clickhouse-operator` which cover each replica inside each shard inside each clickhouse cluster described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "serviceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates. used for customization of the `Service` resource, created by `clickhouse-operator` to cover all clusters in whole `chi` resource";
        type = (types.nullOr types.str);
        default = null;
      };
      "serviceTemplates" = mkOption {
        description = "optional, template names from chi.spec.templates.serviceTemplates. used for customization of the `Service` resources, created by `clickhouse-operator` to cover all clusters in whole `chi` resource";
        type = (types.listOf types.str);
        default = [ ];
      };
      "shardServiceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates, allows customization for each `Service` resource which will created by `clickhouse-operator` which cover each shard inside clickhouse cluster described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeClaimTemplate" = mkOption {
        description = "optional, alias for dataVolumeClaimTemplate, template name from chi.spec.templates.volumeClaimTemplates, allows customization each `PVC` which will mount for clickhouse data directory in each `Pod` during render and reconcile every StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkConfigurationClusterLayoutReplicaShardTemplates =
    res:
    {
    }
    // optionalAttrs (res."clusterServiceTemplate" != null) { inherit (res) "clusterServiceTemplate"; }
    // {
    }
    // optionalAttrs (res."dataVolumeClaimTemplate" != null) {
      inherit (res) "dataVolumeClaimTemplate";
    }
    // {
    }
    // optionalAttrs (res."hostTemplate" != null) { inherit (res) "hostTemplate"; }
    // {
    }
    // optionalAttrs (res."logVolumeClaimTemplate" != null) { inherit (res) "logVolumeClaimTemplate"; }
    // {
    }
    // optionalAttrs (res."podTemplate" != null) { inherit (res) "podTemplate"; }
    // {
    }
    // optionalAttrs (res."replicaServiceTemplate" != null) { inherit (res) "replicaServiceTemplate"; }
    // {
    }
    // optionalAttrs (res."serviceTemplate" != null) { inherit (res) "serviceTemplate"; }
    // {
    }
    // optionalAttrs (res."serviceTemplates" != [ ]) { inherit (res) "serviceTemplates"; }
    // {
    }
    // optionalAttrs (res."shardServiceTemplate" != null) { inherit (res) "shardServiceTemplate"; }
    // {
    }
    // optionalAttrs (res."volumeClaimTemplate" != null) { inherit (res) "volumeClaimTemplate"; }
    // {
    };
  ConfigurationClusterLayoutReplicaTemplatesModule = types.submodule {
    options = {
      "clusterServiceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates, allows customization for each `Service` resource which will created by `clickhouse-operator` which cover each clickhouse cluster described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "dataVolumeClaimTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.volumeClaimTemplates, allows customization each `PVC` which will mount for clickhouse data directory in each `Pod` during render and reconcile every StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "hostTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.hostTemplates, which will apply to configure every `clickhouse-server` instance during render ConfigMap resources which will mount into `Pod`";
        type = (types.nullOr types.str);
        default = null;
      };
      "logVolumeClaimTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.volumeClaimTemplates, allows customization each `PVC` which will mount for clickhouse log directory in each `Pod` during render and reconcile every StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "podTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.podTemplates, allows customization each `Pod` resource during render and reconcile each StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "replicaServiceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates, allows customization for each `Service` resource which will created by `clickhouse-operator` which cover each replica inside each shard inside each clickhouse cluster described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "serviceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates. used for customization of the `Service` resource, created by `clickhouse-operator` to cover all clusters in whole `chi` resource";
        type = (types.nullOr types.str);
        default = null;
      };
      "serviceTemplates" = mkOption {
        description = "optional, template names from chi.spec.templates.serviceTemplates. used for customization of the `Service` resources, created by `clickhouse-operator` to cover all clusters in whole `chi` resource";
        type = (types.listOf types.str);
        default = [ ];
      };
      "shardServiceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates, allows customization for each `Service` resource which will created by `clickhouse-operator` which cover each shard inside clickhouse cluster described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeClaimTemplate" = mkOption {
        description = "optional, alias for dataVolumeClaimTemplate, template name from chi.spec.templates.volumeClaimTemplates, allows customization each `PVC` which will mount for clickhouse data directory in each `Pod` during render and reconcile every StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkConfigurationClusterLayoutReplicaTemplates =
    res:
    {
    }
    // optionalAttrs (res."clusterServiceTemplate" != null) { inherit (res) "clusterServiceTemplate"; }
    // {
    }
    // optionalAttrs (res."dataVolumeClaimTemplate" != null) {
      inherit (res) "dataVolumeClaimTemplate";
    }
    // {
    }
    // optionalAttrs (res."hostTemplate" != null) { inherit (res) "hostTemplate"; }
    // {
    }
    // optionalAttrs (res."logVolumeClaimTemplate" != null) { inherit (res) "logVolumeClaimTemplate"; }
    // {
    }
    // optionalAttrs (res."podTemplate" != null) { inherit (res) "podTemplate"; }
    // {
    }
    // optionalAttrs (res."replicaServiceTemplate" != null) { inherit (res) "replicaServiceTemplate"; }
    // {
    }
    // optionalAttrs (res."serviceTemplate" != null) { inherit (res) "serviceTemplate"; }
    // {
    }
    // optionalAttrs (res."serviceTemplates" != [ ]) { inherit (res) "serviceTemplates"; }
    // {
    }
    // optionalAttrs (res."shardServiceTemplate" != null) { inherit (res) "shardServiceTemplate"; }
    // {
    }
    // optionalAttrs (res."volumeClaimTemplate" != null) { inherit (res) "volumeClaimTemplate"; }
    // {
    };
  ConfigurationClusterLayoutShardModule = types.submodule {
    options = {
      "definitionType" = mkOption {
        description = "DEPRECATED - to be removed soon";
        type = (types.nullOr types.str);
        default = null;
      };
      "files" = mkOption {
        description = "optional, allows define content of any setting file inside each `Pod` only in one shard during generate `ConfigMap` which will mount in `/etc/clickhouse-server/config.d/` or `/etc/clickhouse-server/conf.d/` or `/etc/clickhouse-server/users.d/`\noverride top-level `chi.spec.configuration.files` and cluster-level `chi.spec.configuration.clusters.files`\n";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "internalReplication" = mkOption {
        description = "optional, `true` by default when `chi.spec.configuration.clusters[].layout.ReplicaCount` > 1 and 0 otherwise\nallows setup <internal_replication> setting which will use during insert into tables with `Distributed` engine for insert only in one live replica and other replicas will download inserted data during replication,\nwill apply in <remote_servers> inside ConfigMap which will mount in /etc/clickhouse-server/config.d/chop-generated-remote_servers.xml\nMore details: https://clickhouse.tech/docs/en/engines/table-engines/special/distributed/\n";
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
      "name" = mkOption {
        description = "optional, by default shard name is generated, but you can override it and setup custom name";
        type = (types.nullOr types.str);
        default = null;
      };
      "replicas" = mkOption {
        description = "optional, allows override behavior for selected replicas from cluster-level `chi.spec.configuration.clusters` and shard-level `chi.spec.configuration.clusters.layout.shards`\n";
        type = (types.listOf ConfigurationClusterLayoutShardReplicaModule);
        default = [ ];
      };
      "replicasCount" = mkOption {
        description = "optional, how much replicas in selected shard for selected ClickHouse cluster will run in Kubernetes, each replica is a separate `StatefulSet` which contains only one `Pod` with `clickhouse-server` instance,\nshard contains 1 replica by default\noverride cluster-level `chi.spec.configuration.clusters.layout.replicasCount`\n";
        type = (types.nullOr types.int);
        default = null;
      };
      "settings" = mkOption {
        description = "optional, allows configure `clickhouse-server` settings inside <yandex>...</yandex> tag in each `Pod` only in one shard during generate `ConfigMap` which will mount in `/etc/clickhouse-server/config.d/`\noverride top-level `chi.spec.configuration.settings` and cluster-level `chi.spec.configuration.clusters.settings`\nMore details: https://clickhouse.tech/docs/en/operations/settings/settings/\n";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "templates" = mkOption {
        description = "optional, configuration of the templates names which will use for generate Kubernetes resources according to selected shard\noverride top-level `chi.spec.configuration.templates` and cluster-level `chi.spec.configuration.clusters.templates`\n";
        type = (types.nullOr ConfigurationClusterLayoutShardTemplatesModule);
        default = null;
      };
      "weight" = mkOption {
        description = "optional, 1 by default, allows setup shard <weight> setting which will use during insert into tables with `Distributed` engine,\nwill apply in <remote_servers> inside ConfigMap which will mount in /etc/clickhouse-server/config.d/chop-generated-remote_servers.xml\nMore details: https://clickhouse.tech/docs/en/engines/table-engines/special/distributed/\n";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkConfigurationClusterLayoutShard =
    res:
    {
    }
    // optionalAttrs (res."definitionType" != null) { inherit (res) "definitionType"; }
    // {
    }
    // optionalAttrs (res."files" != { }) { inherit (res) "files"; }
    // {
    }
    // optionalAttrs (res."internalReplication" != null) { inherit (res) "internalReplication"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."replicas" != [ ]) {
      "replicas" = map mkConfigurationClusterLayoutShardReplica res."replicas";
    }
    // {
    }
    // optionalAttrs (res."replicasCount" != null) { inherit (res) "replicasCount"; }
    // {
    }
    // optionalAttrs (res."settings" != { }) { inherit (res) "settings"; }
    // {
    }
    // optionalAttrs (res."templates" != null) {
      "templates" = mkConfigurationClusterLayoutShardTemplates res."templates";
    }
    // {
    }
    // optionalAttrs (res."weight" != null) { inherit (res) "weight"; }
    // {
    };
  ConfigurationClusterLayoutShardReplicaModule = types.submodule {
    options = {
      "files" = mkOption {
        description = "optional, allows define content of any setting file inside `Pod` only in one replica during generate `ConfigMap` which will mount in `/etc/clickhouse-server/config.d/` or `/etc/clickhouse-server/conf.d/` or `/etc/clickhouse-server/users.d/`\noverride top-level `chi.spec.configuration.files`, cluster-level `chi.spec.configuration.clusters.files` and shard-level `chi.spec.configuration.clusters.layout.shards.files`\n";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "httpPort" = mkOption {
        description = "optional, setup `Pod.spec.containers.ports` with name `http` for selected replica, override `chi.spec.templates.hostTemplates.spec.httpPort`\nallows connect to `clickhouse-server` via HTTP protocol via kubernetes `Service`\n";
        type = (types.nullOr types.int);
        default = null;
      };
      "httpsPort" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "insecure" = mkOption {
        description = "optional, open insecure ports for cluster, defaults to \"yes\"\n";
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
      "interserverHTTPPort" = mkOption {
        description = "optional, setup `Pod.spec.containers.ports` with name `interserver` for selected replica, override `chi.spec.templates.hostTemplates.spec.interserverHTTPPort`\nallows connect between replicas inside same shard during fetch replicated data parts HTTP protocol\n";
        type = (types.nullOr types.int);
        default = null;
      };
      "name" = mkOption {
        description = "optional, by default replica name is generated, but you can override it and setup custom name";
        type = (types.nullOr types.str);
        default = null;
      };
      "secure" = mkOption {
        description = "optional, open secure ports\n";
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
      "settings" = mkOption {
        description = "optional, allows configure `clickhouse-server` settings inside <yandex>...</yandex> tag in `Pod` only in one replica during generate `ConfigMap` which will mount in `/etc/clickhouse-server/conf.d/`\noverride top-level `chi.spec.configuration.settings`, cluster-level `chi.spec.configuration.clusters.settings` and shard-level `chi.spec.configuration.clusters.layout.shards.settings`\nMore details: https://clickhouse.tech/docs/en/operations/settings/settings/\n";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "tcpPort" = mkOption {
        description = "optional, setup `Pod.spec.containers.ports` with name `tcp` for selected replica, override `chi.spec.templates.hostTemplates.spec.tcpPort`\nallows connect to `clickhouse-server` via TCP Native protocol via kubernetes `Service`\n";
        type = (types.nullOr types.int);
        default = null;
      };
      "templates" = mkOption {
        description = "optional, configuration of the templates names which will use for generate Kubernetes resources according to selected replica\noverride top-level `chi.spec.configuration.templates`, cluster-level `chi.spec.configuration.clusters.templates` and shard-level `chi.spec.configuration.clusters.layout.shards.templates`\n";
        type = (types.nullOr ConfigurationClusterLayoutShardReplicaTemplatesModule);
        default = null;
      };
      "tlsPort" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkConfigurationClusterLayoutShardReplica =
    res:
    {
    }
    // optionalAttrs (res."files" != { }) { inherit (res) "files"; }
    // {
    }
    // optionalAttrs (res."httpPort" != null) { inherit (res) "httpPort"; }
    // {
    }
    // optionalAttrs (res."httpsPort" != null) { inherit (res) "httpsPort"; }
    // {
    }
    // optionalAttrs (res."insecure" != null) { inherit (res) "insecure"; }
    // {
    }
    // optionalAttrs (res."interserverHTTPPort" != null) { inherit (res) "interserverHTTPPort"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."secure" != null) { inherit (res) "secure"; }
    // {
    }
    // optionalAttrs (res."settings" != { }) { inherit (res) "settings"; }
    // {
    }
    // optionalAttrs (res."tcpPort" != null) { inherit (res) "tcpPort"; }
    // {
    }
    // optionalAttrs (res."templates" != null) {
      "templates" = mkConfigurationClusterLayoutShardReplicaTemplates res."templates";
    }
    // {
    }
    // optionalAttrs (res."tlsPort" != null) { inherit (res) "tlsPort"; }
    // {
    };
  ConfigurationClusterLayoutShardReplicaTemplatesModule = types.submodule {
    options = {
      "clusterServiceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates, allows customization for each `Service` resource which will created by `clickhouse-operator` which cover each clickhouse cluster described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "dataVolumeClaimTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.volumeClaimTemplates, allows customization each `PVC` which will mount for clickhouse data directory in each `Pod` during render and reconcile every StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "hostTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.hostTemplates, which will apply to configure every `clickhouse-server` instance during render ConfigMap resources which will mount into `Pod`";
        type = (types.nullOr types.str);
        default = null;
      };
      "logVolumeClaimTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.volumeClaimTemplates, allows customization each `PVC` which will mount for clickhouse log directory in each `Pod` during render and reconcile every StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "podTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.podTemplates, allows customization each `Pod` resource during render and reconcile each StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "replicaServiceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates, allows customization for each `Service` resource which will created by `clickhouse-operator` which cover each replica inside each shard inside each clickhouse cluster described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "serviceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates. used for customization of the `Service` resource, created by `clickhouse-operator` to cover all clusters in whole `chi` resource";
        type = (types.nullOr types.str);
        default = null;
      };
      "serviceTemplates" = mkOption {
        description = "optional, template names from chi.spec.templates.serviceTemplates. used for customization of the `Service` resources, created by `clickhouse-operator` to cover all clusters in whole `chi` resource";
        type = (types.listOf types.str);
        default = [ ];
      };
      "shardServiceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates, allows customization for each `Service` resource which will created by `clickhouse-operator` which cover each shard inside clickhouse cluster described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeClaimTemplate" = mkOption {
        description = "optional, alias for dataVolumeClaimTemplate, template name from chi.spec.templates.volumeClaimTemplates, allows customization each `PVC` which will mount for clickhouse data directory in each `Pod` during render and reconcile every StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkConfigurationClusterLayoutShardReplicaTemplates =
    res:
    {
    }
    // optionalAttrs (res."clusterServiceTemplate" != null) { inherit (res) "clusterServiceTemplate"; }
    // {
    }
    // optionalAttrs (res."dataVolumeClaimTemplate" != null) {
      inherit (res) "dataVolumeClaimTemplate";
    }
    // {
    }
    // optionalAttrs (res."hostTemplate" != null) { inherit (res) "hostTemplate"; }
    // {
    }
    // optionalAttrs (res."logVolumeClaimTemplate" != null) { inherit (res) "logVolumeClaimTemplate"; }
    // {
    }
    // optionalAttrs (res."podTemplate" != null) { inherit (res) "podTemplate"; }
    // {
    }
    // optionalAttrs (res."replicaServiceTemplate" != null) { inherit (res) "replicaServiceTemplate"; }
    // {
    }
    // optionalAttrs (res."serviceTemplate" != null) { inherit (res) "serviceTemplate"; }
    // {
    }
    // optionalAttrs (res."serviceTemplates" != [ ]) { inherit (res) "serviceTemplates"; }
    // {
    }
    // optionalAttrs (res."shardServiceTemplate" != null) { inherit (res) "shardServiceTemplate"; }
    // {
    }
    // optionalAttrs (res."volumeClaimTemplate" != null) { inherit (res) "volumeClaimTemplate"; }
    // {
    };
  ConfigurationClusterLayoutShardTemplatesModule = types.submodule {
    options = {
      "clusterServiceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates, allows customization for each `Service` resource which will created by `clickhouse-operator` which cover each clickhouse cluster described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "dataVolumeClaimTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.volumeClaimTemplates, allows customization each `PVC` which will mount for clickhouse data directory in each `Pod` during render and reconcile every StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "hostTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.hostTemplates, which will apply to configure every `clickhouse-server` instance during render ConfigMap resources which will mount into `Pod`";
        type = (types.nullOr types.str);
        default = null;
      };
      "logVolumeClaimTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.volumeClaimTemplates, allows customization each `PVC` which will mount for clickhouse log directory in each `Pod` during render and reconcile every StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "podTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.podTemplates, allows customization each `Pod` resource during render and reconcile each StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "replicaServiceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates, allows customization for each `Service` resource which will created by `clickhouse-operator` which cover each replica inside each shard inside each clickhouse cluster described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "serviceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates. used for customization of the `Service` resource, created by `clickhouse-operator` to cover all clusters in whole `chi` resource";
        type = (types.nullOr types.str);
        default = null;
      };
      "serviceTemplates" = mkOption {
        description = "optional, template names from chi.spec.templates.serviceTemplates. used for customization of the `Service` resources, created by `clickhouse-operator` to cover all clusters in whole `chi` resource";
        type = (types.listOf types.str);
        default = [ ];
      };
      "shardServiceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates, allows customization for each `Service` resource which will created by `clickhouse-operator` which cover each shard inside clickhouse cluster described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeClaimTemplate" = mkOption {
        description = "optional, alias for dataVolumeClaimTemplate, template name from chi.spec.templates.volumeClaimTemplates, allows customization each `PVC` which will mount for clickhouse data directory in each `Pod` during render and reconcile every StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkConfigurationClusterLayoutShardTemplates =
    res:
    {
    }
    // optionalAttrs (res."clusterServiceTemplate" != null) { inherit (res) "clusterServiceTemplate"; }
    // {
    }
    // optionalAttrs (res."dataVolumeClaimTemplate" != null) {
      inherit (res) "dataVolumeClaimTemplate";
    }
    // {
    }
    // optionalAttrs (res."hostTemplate" != null) { inherit (res) "hostTemplate"; }
    // {
    }
    // optionalAttrs (res."logVolumeClaimTemplate" != null) { inherit (res) "logVolumeClaimTemplate"; }
    // {
    }
    // optionalAttrs (res."podTemplate" != null) { inherit (res) "podTemplate"; }
    // {
    }
    // optionalAttrs (res."replicaServiceTemplate" != null) { inherit (res) "replicaServiceTemplate"; }
    // {
    }
    // optionalAttrs (res."serviceTemplate" != null) { inherit (res) "serviceTemplate"; }
    // {
    }
    // optionalAttrs (res."serviceTemplates" != [ ]) { inherit (res) "serviceTemplates"; }
    // {
    }
    // optionalAttrs (res."shardServiceTemplate" != null) { inherit (res) "shardServiceTemplate"; }
    // {
    }
    // optionalAttrs (res."volumeClaimTemplate" != null) { inherit (res) "volumeClaimTemplate"; }
    // {
    };
  ConfigurationClusterModule = types.submodule {
    options = {
      "files" = mkOption {
        description = "optional, allows define content of any setting file inside each `Pod` on current cluster during generate `ConfigMap` which will mount in `/etc/clickhouse-server/config.d/` or `/etc/clickhouse-server/conf.d/` or `/etc/clickhouse-server/users.d/`\noverride top-level `chi.spec.configuration.files`\n";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "insecure" = mkOption {
        description = "optional, open insecure ports for cluster, defaults to \"yes\"";
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
      "layout" = mkOption {
        description = "describe current cluster layout, how much shards in cluster, how much replica in shard\nallows override settings on each shard and replica separatelly\n";
        type = (types.nullOr ConfigurationClusterLayoutModule);
        default = null;
      };
      "name" = mkOption {
        description = "cluster name, used to identify set of servers and wide used during generate names of related Kubernetes resources";
        type = (types.nullOr types.str);
        default = null;
      };
      "pdbManaged" = mkOption {
        description = "Specifies whether the Pod Disruption Budget (PDB) should be managed.\nDuring the next installation, if PDB management is enabled, the operator will\nattempt to retrieve any existing PDB. If none is found, it will create a new one\nand initiate a reconciliation loop. If PDB management is disabled, the existing PDB\nwill remain intact, and the reconciliation loop will not be executed. By default,\nPDB management is enabled.\n";
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
      "pdbMaxUnavailable" = mkOption {
        description = "Pod eviction is allowed if at most \"pdbMaxUnavailable\" pods are unavailable after the eviction,\ni.e. even in absence of the evicted pod. For example, one can prevent all voluntary evictions\nby specifying 0. This is a mutually exclusive setting with \"minAvailable\".\n";
        type = (types.nullOr types.int);
        default = null;
      };
      "reconcile" = mkOption {
        description = "allow tuning reconciling process";
        type = (types.nullOr ConfigurationClusterReconcileModule);
        default = null;
      };
      "schemaPolicy" = mkOption {
        description = "describes how schema is propagated within replicas and shards\n";
        type = (types.nullOr ConfigurationClusterSchemaPolicyModule);
        default = null;
      };
      "secret" = mkOption {
        description = "optional, shared secret value to secure cluster communications";
        type = (types.nullOr ConfigurationClusterSecretModule);
        default = null;
      };
      "secure" = mkOption {
        description = "optional, open secure ports for cluster";
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
      "settings" = mkOption {
        description = "optional, allows configure `clickhouse-server` settings inside <yandex>...</yandex> tag in each `Pod` only in one cluster during generate `ConfigMap` which will mount in `/etc/clickhouse-server/config.d/`\noverride top-level `chi.spec.configuration.settings`\nMore details: https://clickhouse.tech/docs/en/operations/settings/settings/\n";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "templates" = mkOption {
        description = "optional, configuration of the templates names which will use for generate Kubernetes resources according to selected cluster\noverride top-level `chi.spec.configuration.templates`\n";
        type = (types.nullOr ConfigurationClusterTemplatesModule);
        default = null;
      };
      "zookeeper" = mkOption {
        description = "optional, allows configure <yandex><zookeeper>..</zookeeper></yandex> section in each `Pod` only in current ClickHouse cluster, during generate `ConfigMap` which will mounted in `/etc/clickhouse-server/config.d/`\noverride top-level `chi.spec.configuration.zookeeper` settings\n";
        type = (types.nullOr ConfigurationClusterZookeeperModule);
        default = null;
      };
    };
  };
  mkConfigurationCluster =
    res:
    {
    }
    // optionalAttrs (res."files" != { }) { inherit (res) "files"; }
    // {
    }
    // optionalAttrs (res."insecure" != null) { inherit (res) "insecure"; }
    // {
    }
    // optionalAttrs (res."layout" != null) { "layout" = mkConfigurationClusterLayout res."layout"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."pdbManaged" != null) { inherit (res) "pdbManaged"; }
    // {
    }
    // optionalAttrs (res."pdbMaxUnavailable" != null) { inherit (res) "pdbMaxUnavailable"; }
    // {
    }
    // optionalAttrs (res."reconcile" != null) {
      "reconcile" = mkConfigurationClusterReconcile res."reconcile";
    }
    // {
    }
    // optionalAttrs (res."schemaPolicy" != null) {
      "schemaPolicy" = mkConfigurationClusterSchemaPolicy res."schemaPolicy";
    }
    // {
    }
    // optionalAttrs (res."secret" != null) { "secret" = mkConfigurationClusterSecret res."secret"; }
    // {
    }
    // optionalAttrs (res."secure" != null) { inherit (res) "secure"; }
    // {
    }
    // optionalAttrs (res."settings" != { }) { inherit (res) "settings"; }
    // {
    }
    // optionalAttrs (res."templates" != null) {
      "templates" = mkConfigurationClusterTemplates res."templates";
    }
    // {
    }
    // optionalAttrs (res."zookeeper" != null) {
      "zookeeper" = mkConfigurationClusterZookeeper res."zookeeper";
    }
    // {
    };
  ConfigurationClusterReconcileModule = types.submodule {
    options = {
      "runtime" = mkOption {
        description = "runtime parameters for clickhouse-operator process which are used during reconcile cycle";
        type = (types.nullOr ConfigurationClusterReconcileRuntimeModule);
        default = null;
      };
    };
  };
  mkConfigurationClusterReconcile =
    res:
    {
    }
    // optionalAttrs (res."runtime" != null) {
      "runtime" = mkConfigurationClusterReconcileRuntime res."runtime";
    }
    // {
    };
  ConfigurationClusterReconcileRuntimeModule = types.submodule {
    options = {
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
  mkConfigurationClusterReconcileRuntime =
    res:
    {
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
  ConfigurationClusterSchemaPolicyModule = types.submodule {
    options = {
      "replica" = mkOption {
        description = "how schema is propagated within a replica";
        type = (
          types.nullOr (
            types.enum [
              ""
              "None"
              "All"
            ]
          )
        );
        default = null;
      };
      "shard" = mkOption {
        description = "how schema is propagated between shards";
        type = (
          types.nullOr (
            types.enum [
              ""
              "None"
              "All"
              "DistributedTablesOnly"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkConfigurationClusterSchemaPolicy =
    res:
    {
    }
    // optionalAttrs (res."replica" != null) { inherit (res) "replica"; }
    // {
    }
    // optionalAttrs (res."shard" != null) { inherit (res) "shard"; }
    // {
    };
  ConfigurationClusterSecretModule = types.submodule {
    options = {
      "auto" = mkOption {
        description = "Auto-generate shared secret value to secure cluster communications";
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
      "value" = mkOption {
        description = "Cluster shared secret value in plain text";
        type = (types.nullOr types.str);
        default = null;
      };
      "valueFrom" = mkOption {
        description = "Cluster shared secret source";
        type = (types.nullOr ConfigurationClusterSecretValueFromModule);
        default = null;
      };
    };
  };
  mkConfigurationClusterSecret =
    res:
    {
    }
    // optionalAttrs (res."auto" != null) { inherit (res) "auto"; }
    // {
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    }
    // optionalAttrs (res."valueFrom" != null) {
      "valueFrom" = mkConfigurationClusterSecretValueFrom res."valueFrom";
    }
    // {
    };
  ConfigurationClusterSecretValueFromModule = types.submodule {
    options = {
      "secretKeyRef" = mkOption {
        description = "Selects a key of a secret in the clickhouse installation namespace.\nShould not be used if value is not empty.\n";
        type = (types.nullOr ConfigurationClusterSecretValueFromSecretKeyRefModule);
        default = null;
      };
    };
  };
  mkConfigurationClusterSecretValueFrom =
    res:
    {
    }
    // optionalAttrs (res."secretKeyRef" != null) {
      "secretKeyRef" = mkConfigurationClusterSecretValueFromSecretKeyRef res."secretKeyRef";
    }
    // {
    };
  ConfigurationClusterSecretValueFromSecretKeyRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key of the secret to select from. Must be a valid secret key.";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent. More info:\nhttps://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names\n";
        type = types.str;
      };
      "optional" = mkOption {
        description = "Specify whether the Secret or its key must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkConfigurationClusterSecretValueFromSecretKeyRef =
    res:
    {
      inherit (res) "key";
      inherit (res) "name";
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  ConfigurationClusterTemplatesModule = types.submodule {
    options = {
      "clusterServiceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates, allows customization for each `Service` resource which will created by `clickhouse-operator` which cover each clickhouse cluster described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "dataVolumeClaimTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.volumeClaimTemplates, allows customization each `PVC` which will mount for clickhouse data directory in each `Pod` during render and reconcile every StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "hostTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.hostTemplates, which will apply to configure every `clickhouse-server` instance during render ConfigMap resources which will mount into `Pod`";
        type = (types.nullOr types.str);
        default = null;
      };
      "logVolumeClaimTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.volumeClaimTemplates, allows customization each `PVC` which will mount for clickhouse log directory in each `Pod` during render and reconcile every StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "podTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.podTemplates, allows customization each `Pod` resource during render and reconcile each StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "replicaServiceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates, allows customization for each `Service` resource which will created by `clickhouse-operator` which cover each replica inside each shard inside each clickhouse cluster described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "serviceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates. used for customization of the `Service` resource, created by `clickhouse-operator` to cover all clusters in whole `chi` resource";
        type = (types.nullOr types.str);
        default = null;
      };
      "serviceTemplates" = mkOption {
        description = "optional, template names from chi.spec.templates.serviceTemplates. used for customization of the `Service` resources, created by `clickhouse-operator` to cover all clusters in whole `chi` resource";
        type = (types.listOf types.str);
        default = [ ];
      };
      "shardServiceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates, allows customization for each `Service` resource which will created by `clickhouse-operator` which cover each shard inside clickhouse cluster described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeClaimTemplate" = mkOption {
        description = "optional, alias for dataVolumeClaimTemplate, template name from chi.spec.templates.volumeClaimTemplates, allows customization each `PVC` which will mount for clickhouse data directory in each `Pod` during render and reconcile every StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkConfigurationClusterTemplates =
    res:
    {
    }
    // optionalAttrs (res."clusterServiceTemplate" != null) { inherit (res) "clusterServiceTemplate"; }
    // {
    }
    // optionalAttrs (res."dataVolumeClaimTemplate" != null) {
      inherit (res) "dataVolumeClaimTemplate";
    }
    // {
    }
    // optionalAttrs (res."hostTemplate" != null) { inherit (res) "hostTemplate"; }
    // {
    }
    // optionalAttrs (res."logVolumeClaimTemplate" != null) { inherit (res) "logVolumeClaimTemplate"; }
    // {
    }
    // optionalAttrs (res."podTemplate" != null) { inherit (res) "podTemplate"; }
    // {
    }
    // optionalAttrs (res."replicaServiceTemplate" != null) { inherit (res) "replicaServiceTemplate"; }
    // {
    }
    // optionalAttrs (res."serviceTemplate" != null) { inherit (res) "serviceTemplate"; }
    // {
    }
    // optionalAttrs (res."serviceTemplates" != [ ]) { inherit (res) "serviceTemplates"; }
    // {
    }
    // optionalAttrs (res."shardServiceTemplate" != null) { inherit (res) "shardServiceTemplate"; }
    // {
    }
    // optionalAttrs (res."volumeClaimTemplate" != null) { inherit (res) "volumeClaimTemplate"; }
    // {
    };
  ConfigurationClusterZookeeperModule = types.submodule {
    options = {
      "identity" = mkOption {
        description = "optional access credentials string with `user:password` format used when use digest authorization in Zookeeper";
        type = (types.nullOr types.str);
        default = null;
      };
      "nodes" = mkOption {
        description = "describe every available zookeeper cluster node for interaction";
        type = (types.listOf ConfigurationClusterZookeeperNodeModule);
        default = [ ];
      };
      "operation_timeout_ms" = mkOption {
        description = "one operation timeout during Zookeeper transactions";
        type = (types.nullOr types.int);
        default = null;
      };
      "root" = mkOption {
        description = "optional root znode path inside zookeeper to store ClickHouse related data (replication queue or distributed DDL)";
        type = (types.nullOr types.str);
        default = null;
      };
      "session_timeout_ms" = mkOption {
        description = "session timeout during connect to Zookeeper";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkConfigurationClusterZookeeper =
    res:
    {
    }
    // optionalAttrs (res."identity" != null) { inherit (res) "identity"; }
    // {
    }
    // optionalAttrs (res."nodes" != [ ]) {
      "nodes" = map mkConfigurationClusterZookeeperNode res."nodes";
    }
    // {
    }
    // optionalAttrs (res."operation_timeout_ms" != null) { inherit (res) "operation_timeout_ms"; }
    // {
    }
    // optionalAttrs (res."root" != null) { inherit (res) "root"; }
    // {
    }
    // optionalAttrs (res."session_timeout_ms" != null) { inherit (res) "session_timeout_ms"; }
    // {
    };
  ConfigurationClusterZookeeperNodeModule = types.submodule {
    options = {
      "availabilityZone" = mkOption {
        description = "availability zone for Zookeeper node";
        type = (types.nullOr types.str);
        default = null;
      };
      "host" = mkOption {
        description = "dns name or ip address for Zookeeper node";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "TCP port which used to connect to Zookeeper node";
        type = (types.nullOr types.int);
        default = null;
      };
      "secure" = mkOption {
        description = "if a secure connection to Zookeeper is required";
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
  mkConfigurationClusterZookeeperNode =
    res:
    {
    }
    // optionalAttrs (res."availabilityZone" != null) { inherit (res) "availabilityZone"; }
    // {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
    }
    // optionalAttrs (res."secure" != null) { inherit (res) "secure"; }
    // {
    };
  ConfigurationModule = types.submodule {
    options = {
      "clusters" = mkOption {
        description = "describes clusters layout and allows change settings on cluster-level, shard-level and replica-level\nevery cluster is a set of StatefulSet, one StatefulSet contains only one Pod with `clickhouse-server`\nall Pods will rendered in <remote_server> part of ClickHouse configs, mounted from ConfigMap as `/etc/clickhouse-server/config.d/chop-generated-remote_servers.xml`\nClusters will use for Distributed table engine, more details: https://clickhouse.tech/docs/en/engines/table-engines/special/distributed/\nIf `cluster` contains zookeeper settings (could be inherited from top `chi` level), when you can create *ReplicatedMergeTree tables\n";
        type = (types.listOf ConfigurationClusterModule);
        default = [ ];
      };
      "files" = mkOption {
        description = "allows define content of any setting file inside each `Pod` during generate `ConfigMap` which will mount in `/etc/clickhouse-server/config.d/` or `/etc/clickhouse-server/conf.d/` or `/etc/clickhouse-server/users.d/`\nevery key in this object is the file name\nevery value in this object is the file content\nyou can use `!!binary |` and base64 for binary files, see details here https://yaml.org/type/binary.html\neach key could contains prefix like {common}, {users}, {hosts} or config.d, users.d, conf.d, wrong prefixes will be ignored, subfolders also will be ignored\nMore details: https://github.com/Altinity/clickhouse-operator/blob/master/docs/chi-examples/05-settings-05-files-nested.yaml\n\nany key could contains `valueFrom` with `secretKeyRef` which allow pass values from kubernetes secrets\nsecrets will mounted into pod as separate volume in /etc/clickhouse-server/secrets.d/\nand will automatically update when update secret\nit useful for pass SSL certificates from cert-manager or similar tool\nlook into https://github.com/Altinity/clickhouse-operator/blob/master/docs/chi-examples/05-settings-01-overview.yaml for examples\n";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "profiles" = mkOption {
        description = "allows configure <yandex><profiles>..</profiles></yandex> section in each `Pod` during generate `ConfigMap` which will mount in `/etc/clickhouse-server/users.d/`\nyou can configure any aspect of settings profile\nMore details: https://clickhouse.tech/docs/en/operations/settings/settings-profiles/\nYour yaml code will convert to XML, see examples https://github.com/Altinity/clickhouse-operator/blob/master/docs/custom_resource_explained.md#specconfigurationprofiles\n";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "quotas" = mkOption {
        description = "allows configure <yandex><quotas>..</quotas></yandex> section in each `Pod` during generate `ConfigMap` which will mount in `/etc/clickhouse-server/users.d/`\nyou can configure any aspect of resource quotas\nMore details: https://clickhouse.tech/docs/en/operations/quotas/\nYour yaml code will convert to XML, see examples https://github.com/Altinity/clickhouse-operator/blob/master/docs/custom_resource_explained.md#specconfigurationquotas\n";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "settings" = mkOption {
        description = "allows configure `clickhouse-server` settings inside <yandex>...</yandex> tag in each `Pod` during generate `ConfigMap` which will mount in `/etc/clickhouse-server/config.d/`\nMore details: https://clickhouse.tech/docs/en/operations/settings/settings/\nYour yaml code will convert to XML, see examples https://github.com/Altinity/clickhouse-operator/blob/master/docs/custom_resource_explained.md#specconfigurationsettings\n\nany key could contains `valueFrom` with `secretKeyRef` which allow pass password from kubernetes secrets\nlook into https://github.com/Altinity/clickhouse-operator/blob/master/docs/chi-examples/05-settings-01-overview.yaml for examples\n\nsecret value will pass in `pod.spec.env`, and generate with from_env=XXX in XML in /etc/clickhouse-server/config.d/chop-generated-settings.xml\nit not allow automatically updates when updates `secret`, change spec.taskID for manually trigger reconcile cycle\n";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "users" = mkOption {
        description = "allows configure <yandex><users>..</users></yandex> section in each `Pod` during generate `ConfigMap` which will mount in `/etc/clickhouse-server/users.d/`\nyou can configure password hashed, authorization restrictions, database level security row filters etc.\nMore details: https://clickhouse.tech/docs/en/operations/settings/settings-users/\nYour yaml code will convert to XML, see examples https://github.com/Altinity/clickhouse-operator/blob/master/docs/custom_resource_explained.md#specconfigurationusers\n\nany key could contains `valueFrom` with `secretKeyRef` which allow pass password from kubernetes secrets\nsecret value will pass in `pod.spec.containers.evn`, and generate with from_env=XXX in XML in /etc/clickhouse-server/users.d/chop-generated-users.xml\nit not allow automatically updates when updates `secret`, change spec.taskID for manually trigger reconcile cycle\n\nlook into https://github.com/Altinity/clickhouse-operator/blob/master/docs/chi-examples/05-settings-01-overview.yaml for examples\n\nany key with prefix `k8s_secret_` shall has value with format namespace/secret/key or secret/key\nin this case value from secret will write directly into XML tag during render *-usersd ConfigMap\n\nany key with prefix `k8s_secret_env` shall has value with format namespace/secret/key or secret/key\nin this case value from secret will write into environment variable and write to XML tag via from_env=XXX\n\nlook into https://github.com/Altinity/clickhouse-operator/blob/master/docs/chi-examples/05-settings-01-overview.yaml for examples\n";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "zookeeper" = mkOption {
        description = "allows configure <yandex><zookeeper>..</zookeeper></yandex> section in each `Pod` during generate `ConfigMap` which will mounted in `/etc/clickhouse-server/config.d/`\n`clickhouse-operator` itself doesn't manage Zookeeper, please install Zookeeper separatelly look examples on https://github.com/Altinity/clickhouse-operator/tree/master/deploy/zookeeper/\ncurrently, zookeeper (or clickhouse-keeper replacement) used for *ReplicatedMergeTree table engines and for `distributed_ddl`\nMore details: https://clickhouse.tech/docs/en/operations/server-configuration-parameters/settings/#server-settings_zookeeper\n";
        type = (types.nullOr ConfigurationZookeeperModule);
        default = null;
      };
    };
  };
  mkConfiguration =
    res:
    {
    }
    // optionalAttrs (res."clusters" != [ ]) { "clusters" = map mkConfigurationCluster res."clusters"; }
    // {
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
    }
    // optionalAttrs (res."zookeeper" != null) {
      "zookeeper" = mkConfigurationZookeeper res."zookeeper";
    }
    // {
    };
  ConfigurationZookeeperModule = types.submodule {
    options = {
      "identity" = mkOption {
        description = "optional access credentials string with `user:password` format used when use digest authorization in Zookeeper";
        type = (types.nullOr types.str);
        default = null;
      };
      "nodes" = mkOption {
        description = "describe every available zookeeper cluster node for interaction";
        type = (types.listOf ConfigurationZookeeperNodeModule);
        default = [ ];
      };
      "operation_timeout_ms" = mkOption {
        description = "one operation timeout during Zookeeper transactions";
        type = (types.nullOr types.int);
        default = null;
      };
      "root" = mkOption {
        description = "optional root znode path inside zookeeper to store ClickHouse related data (replication queue or distributed DDL)";
        type = (types.nullOr types.str);
        default = null;
      };
      "session_timeout_ms" = mkOption {
        description = "session timeout during connect to Zookeeper";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkConfigurationZookeeper =
    res:
    {
    }
    // optionalAttrs (res."identity" != null) { inherit (res) "identity"; }
    // {
    }
    // optionalAttrs (res."nodes" != [ ]) { "nodes" = map mkConfigurationZookeeperNode res."nodes"; }
    // {
    }
    // optionalAttrs (res."operation_timeout_ms" != null) { inherit (res) "operation_timeout_ms"; }
    // {
    }
    // optionalAttrs (res."root" != null) { inherit (res) "root"; }
    // {
    }
    // optionalAttrs (res."session_timeout_ms" != null) { inherit (res) "session_timeout_ms"; }
    // {
    };
  ConfigurationZookeeperNodeModule = types.submodule {
    options = {
      "availabilityZone" = mkOption {
        description = "availability zone for Zookeeper node";
        type = (types.nullOr types.str);
        default = null;
      };
      "host" = mkOption {
        description = "dns name or ip address for Zookeeper node";
        type = (types.nullOr types.str);
        default = null;
      };
      "port" = mkOption {
        description = "TCP port which used to connect to Zookeeper node";
        type = (types.nullOr types.int);
        default = null;
      };
      "secure" = mkOption {
        description = "if a secure connection to Zookeeper is required";
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
  mkConfigurationZookeeperNode =
    res:
    {
    }
    // optionalAttrs (res."availabilityZone" != null) { inherit (res) "availabilityZone"; }
    // {
    }
    // optionalAttrs (res."host" != null) { inherit (res) "host"; }
    // {
    }
    // optionalAttrs (res."port" != null) { inherit (res) "port"; }
    // {
    }
    // optionalAttrs (res."secure" != null) { inherit (res) "secure"; }
    // {
    };
  DefaultsDistributedDDLModule = types.submodule {
    options = {
      "profile" = mkOption {
        description = "Settings from this profile will be used to execute DDL queries";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDefaultsDistributedDDL =
    res:
    {
    }
    // optionalAttrs (res."profile" != null) { inherit (res) "profile"; }
    // {
    };
  DefaultsModule = types.submodule {
    options = {
      "distributedDDL" = mkOption {
        description = "allows change `<yandex><distributed_ddl></distributed_ddl></yandex>` settings\nMore info: https://clickhouse.tech/docs/en/operations/server-configuration-parameters/settings/#server-settings-distributed_ddl\n";
        type = (types.nullOr DefaultsDistributedDDLModule);
        default = null;
      };
      "replicasUseFQDN" = mkOption {
        description = "define should replicas be specified by FQDN in `<host></host>`.\nIn case of \"no\" will use short hostname and clickhouse-server will use kubernetes default suffixes for DNS lookup\n\"no\" by default\n";
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
      "storageManagement" = mkOption {
        description = "default storage management options";
        type = (types.nullOr DefaultsStorageManagementModule);
        default = null;
      };
      "templates" = mkOption {
        description = "optional, configuration of the templates names which will use for generate Kubernetes resources according to one or more ClickHouse clusters described in current ClickHouseInstallation (chi) resource";
        type = (types.nullOr DefaultsTemplatesModule);
        default = null;
      };
    };
  };
  mkDefaults =
    res:
    {
    }
    // optionalAttrs (res."distributedDDL" != null) {
      "distributedDDL" = mkDefaultsDistributedDDL res."distributedDDL";
    }
    // {
    }
    // optionalAttrs (res."replicasUseFQDN" != null) { inherit (res) "replicasUseFQDN"; }
    // {
    }
    // optionalAttrs (res."storageManagement" != null) {
      "storageManagement" = mkDefaultsStorageManagement res."storageManagement";
    }
    // {
    }
    // optionalAttrs (res."templates" != null) { "templates" = mkDefaultsTemplates res."templates"; }
    // {
    };
  DefaultsStorageManagementModule = types.submodule {
    options = {
      "provisioner" = mkOption {
        description = "defines `PVC` provisioner - be it StatefulSet or the Operator";
        type = (
          types.nullOr (
            types.enum [
              ""
              "StatefulSet"
              "Operator"
            ]
          )
        );
        default = null;
      };
      "reclaimPolicy" = mkOption {
        description = "defines behavior of `PVC` deletion.\n`Delete` by default, if `Retain` specified then `PVC` will be kept when deleting StatefulSet\n";
        type = (
          types.nullOr (
            types.enum [
              ""
              "Retain"
              "Delete"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkDefaultsStorageManagement =
    res:
    {
    }
    // optionalAttrs (res."provisioner" != null) { inherit (res) "provisioner"; }
    // {
    }
    // optionalAttrs (res."reclaimPolicy" != null) { inherit (res) "reclaimPolicy"; }
    // {
    };
  DefaultsTemplatesModule = types.submodule {
    options = {
      "clusterServiceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates, allows customization for each `Service` resource which will created by `clickhouse-operator` which cover each clickhouse cluster described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "dataVolumeClaimTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.volumeClaimTemplates, allows customization each `PVC` which will mount for clickhouse data directory in each `Pod` during render and reconcile every StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "hostTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.hostTemplates, which will apply to configure every `clickhouse-server` instance during render ConfigMap resources which will mount into `Pod`";
        type = (types.nullOr types.str);
        default = null;
      };
      "logVolumeClaimTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.volumeClaimTemplates, allows customization each `PVC` which will mount for clickhouse log directory in each `Pod` during render and reconcile every StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "podTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.podTemplates, allows customization each `Pod` resource during render and reconcile each StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "replicaServiceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates, allows customization for each `Service` resource which will created by `clickhouse-operator` which cover each replica inside each shard inside each clickhouse cluster described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "serviceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates. used for customization of the `Service` resource, created by `clickhouse-operator` to cover all clusters in whole `chi` resource";
        type = (types.nullOr types.str);
        default = null;
      };
      "serviceTemplates" = mkOption {
        description = "optional, template names from chi.spec.templates.serviceTemplates. used for customization of the `Service` resources, created by `clickhouse-operator` to cover all clusters in whole `chi` resource";
        type = (types.listOf types.str);
        default = [ ];
      };
      "shardServiceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates, allows customization for each `Service` resource which will created by `clickhouse-operator` which cover each shard inside clickhouse cluster described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeClaimTemplate" = mkOption {
        description = "optional, alias for dataVolumeClaimTemplate, template name from chi.spec.templates.volumeClaimTemplates, allows customization each `PVC` which will mount for clickhouse data directory in each `Pod` during render and reconcile every StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkDefaultsTemplates =
    res:
    {
    }
    // optionalAttrs (res."clusterServiceTemplate" != null) { inherit (res) "clusterServiceTemplate"; }
    // {
    }
    // optionalAttrs (res."dataVolumeClaimTemplate" != null) {
      inherit (res) "dataVolumeClaimTemplate";
    }
    // {
    }
    // optionalAttrs (res."hostTemplate" != null) { inherit (res) "hostTemplate"; }
    // {
    }
    // optionalAttrs (res."logVolumeClaimTemplate" != null) { inherit (res) "logVolumeClaimTemplate"; }
    // {
    }
    // optionalAttrs (res."podTemplate" != null) { inherit (res) "podTemplate"; }
    // {
    }
    // optionalAttrs (res."replicaServiceTemplate" != null) { inherit (res) "replicaServiceTemplate"; }
    // {
    }
    // optionalAttrs (res."serviceTemplate" != null) { inherit (res) "serviceTemplate"; }
    // {
    }
    // optionalAttrs (res."serviceTemplates" != [ ]) { inherit (res) "serviceTemplates"; }
    // {
    }
    // optionalAttrs (res."shardServiceTemplate" != null) { inherit (res) "shardServiceTemplate"; }
    // {
    }
    // optionalAttrs (res."volumeClaimTemplate" != null) { inherit (res) "volumeClaimTemplate"; }
    // {
    };
  ReconcilingCleanupModule = types.submodule {
    options = {
      "reconcileFailedObjects" = mkOption {
        description = "Describes what clickhouse-operator should do with Kubernetes resources which are failed during reconcile.\nDefault behavior is `Retain`\"\n";
        type = (types.nullOr ReconcilingCleanupReconcileFailedObjectsModule);
        default = null;
      };
      "unknownObjects" = mkOption {
        description = "Describes what clickhouse-operator should do with found Kubernetes resources which should be managed by clickhouse-operator,\nbut do not have `ownerReference` to any currently managed `ClickHouseInstallation` resource.\nDefault behavior is `Delete`\"\n";
        type = (types.nullOr ReconcilingCleanupUnknownObjectsModule);
        default = null;
      };
    };
  };
  mkReconcilingCleanup =
    res:
    {
    }
    // optionalAttrs (res."reconcileFailedObjects" != null) {
      "reconcileFailedObjects" = mkReconcilingCleanupReconcileFailedObjects res."reconcileFailedObjects";
    }
    // {
    }
    // optionalAttrs (res."unknownObjects" != null) {
      "unknownObjects" = mkReconcilingCleanupUnknownObjects res."unknownObjects";
    }
    // {
    };
  ReconcilingCleanupReconcileFailedObjectsModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "Behavior policy for failed ConfigMap, `Retain` by default";
        type = (
          types.nullOr (
            types.enum [
              ""
              "Retain"
              "Delete"
            ]
          )
        );
        default = null;
      };
      "pvc" = mkOption {
        description = "Behavior policy for failed PVC, `Retain` by default";
        type = (
          types.nullOr (
            types.enum [
              ""
              "Retain"
              "Delete"
            ]
          )
        );
        default = null;
      };
      "service" = mkOption {
        description = "Behavior policy for failed Service, `Retain` by default";
        type = (
          types.nullOr (
            types.enum [
              ""
              "Retain"
              "Delete"
            ]
          )
        );
        default = null;
      };
      "statefulSet" = mkOption {
        description = "Behavior policy for failed StatefulSet, `Retain` by default";
        type = (
          types.nullOr (
            types.enum [
              ""
              "Retain"
              "Delete"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkReconcilingCleanupReconcileFailedObjects =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) { inherit (res) "configMap"; }
    // {
    }
    // optionalAttrs (res."pvc" != null) { inherit (res) "pvc"; }
    // {
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    }
    // optionalAttrs (res."statefulSet" != null) { inherit (res) "statefulSet"; }
    // {
    };
  ReconcilingCleanupUnknownObjectsModule = types.submodule {
    options = {
      "configMap" = mkOption {
        description = "Behavior policy for unknown ConfigMap, `Delete` by default";
        type = (
          types.nullOr (
            types.enum [
              ""
              "Retain"
              "Delete"
            ]
          )
        );
        default = null;
      };
      "pvc" = mkOption {
        description = "Behavior policy for unknown PVC, `Delete` by default";
        type = (
          types.nullOr (
            types.enum [
              ""
              "Retain"
              "Delete"
            ]
          )
        );
        default = null;
      };
      "service" = mkOption {
        description = "Behavior policy for unknown Service, `Delete` by default";
        type = (
          types.nullOr (
            types.enum [
              ""
              "Retain"
              "Delete"
            ]
          )
        );
        default = null;
      };
      "statefulSet" = mkOption {
        description = "Behavior policy for unknown StatefulSet, `Delete` by default";
        type = (
          types.nullOr (
            types.enum [
              ""
              "Retain"
              "Delete"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkReconcilingCleanupUnknownObjects =
    res:
    {
    }
    // optionalAttrs (res."configMap" != null) { inherit (res) "configMap"; }
    // {
    }
    // optionalAttrs (res."pvc" != null) { inherit (res) "pvc"; }
    // {
    }
    // optionalAttrs (res."service" != null) { inherit (res) "service"; }
    // {
    }
    // optionalAttrs (res."statefulSet" != null) { inherit (res) "statefulSet"; }
    // {
    };
  ReconcilingMacrosModule = types.submodule {
    options = {
      "sections" = mkOption {
        description = "sections behaviour for macros";
        type = (types.nullOr ReconcilingMacrosSectionsModule);
        default = null;
      };
    };
  };
  mkReconcilingMacros =
    res:
    {
    }
    // optionalAttrs (res."sections" != null) {
      "sections" = mkReconcilingMacrosSections res."sections";
    }
    // {
    };
  ReconcilingMacrosSectionsFilesModule = types.submodule {
    options = {
      "enabled" = mkOption {
        description = "enabled or not";
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
  mkReconcilingMacrosSectionsFiles =
    res:
    {
    }
    // optionalAttrs (res."enabled" != null) { inherit (res) "enabled"; }
    // {
    };
  ReconcilingMacrosSectionsModule = types.submodule {
    options = {
      "files" = mkOption {
        description = "sections behaviour for macros on files";
        type = (types.nullOr ReconcilingMacrosSectionsFilesModule);
        default = null;
      };
      "profiles" = mkOption {
        description = "sections behaviour for macros on profiles";
        type = (types.nullOr ReconcilingMacrosSectionsProfilesModule);
        default = null;
      };
      "quotas" = mkOption {
        description = "sections behaviour for macros on quotas";
        type = (types.nullOr ReconcilingMacrosSectionsQuotasModule);
        default = null;
      };
      "settings" = mkOption {
        description = "sections behaviour for macros on settings";
        type = (types.nullOr ReconcilingMacrosSectionsSettingsModule);
        default = null;
      };
      "users" = mkOption {
        description = "sections behaviour for macros on users";
        type = (types.nullOr ReconcilingMacrosSectionsUsersModule);
        default = null;
      };
    };
  };
  mkReconcilingMacrosSections =
    res:
    {
    }
    // optionalAttrs (res."files" != null) { "files" = mkReconcilingMacrosSectionsFiles res."files"; }
    // {
    }
    // optionalAttrs (res."profiles" != null) {
      "profiles" = mkReconcilingMacrosSectionsProfiles res."profiles";
    }
    // {
    }
    // optionalAttrs (res."quotas" != null) {
      "quotas" = mkReconcilingMacrosSectionsQuotas res."quotas";
    }
    // {
    }
    // optionalAttrs (res."settings" != null) {
      "settings" = mkReconcilingMacrosSectionsSettings res."settings";
    }
    // {
    }
    // optionalAttrs (res."users" != null) { "users" = mkReconcilingMacrosSectionsUsers res."users"; }
    // {
    };
  ReconcilingMacrosSectionsProfilesModule = types.submodule {
    options = {
      "enabled" = mkOption {
        description = "enabled or not";
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
  mkReconcilingMacrosSectionsProfiles =
    res:
    {
    }
    // optionalAttrs (res."enabled" != null) { inherit (res) "enabled"; }
    // {
    };
  ReconcilingMacrosSectionsQuotasModule = types.submodule {
    options = {
      "enabled" = mkOption {
        description = "enabled or not";
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
  mkReconcilingMacrosSectionsQuotas =
    res:
    {
    }
    // optionalAttrs (res."enabled" != null) { inherit (res) "enabled"; }
    // {
    };
  ReconcilingMacrosSectionsSettingsModule = types.submodule {
    options = {
      "enabled" = mkOption {
        description = "enabled or not";
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
  mkReconcilingMacrosSectionsSettings =
    res:
    {
    }
    // optionalAttrs (res."enabled" != null) { inherit (res) "enabled"; }
    // {
    };
  ReconcilingMacrosSectionsUsersModule = types.submodule {
    options = {
      "enabled" = mkOption {
        description = "enabled or not";
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
  mkReconcilingMacrosSectionsUsers =
    res:
    {
    }
    // optionalAttrs (res."enabled" != null) { inherit (res) "enabled"; }
    // {
    };
  ReconcilingModule = types.submodule {
    options = {
      "cleanup" = mkOption {
        description = "Optional, defines behavior for cleanup Kubernetes resources during reconcile cycle";
        type = (types.nullOr ReconcilingCleanupModule);
        default = null;
      };
      "configMapPropagationTimeout" = mkOption {
        description = "Timeout in seconds for `clickhouse-operator` to wait for modified `ConfigMap` to propagate into the `Pod`\nMore details: https://kubernetes.io/docs/concepts/configuration/configmap/#mounted-configmaps-are-updated-automatically\n";
        type = (types.nullOr types.int);
        default = null;
      };
      "macros" = mkOption {
        description = "macros parameters";
        type = (types.nullOr ReconcilingMacrosModule);
        default = null;
      };
      "policy" = mkOption {
        description = "DISCUSSED TO BE DEPRECATED\nSyntax sugar\nOverrides all three 'reconcile.host.wait.{exclude, queries, include}' values from the operator's config\nPossible values:\n - wait - should wait to exclude host, complete queries and include host back into the cluster\n - nowait - should NOT wait to exclude host, complete queries and include host back into the cluster\n";
        type = (
          types.nullOr (
            types.enum [
              ""
              "wait"
              "nowait"
            ]
          )
        );
        default = null;
      };
      "runtime" = mkOption {
        description = "runtime parameters for clickhouse-operator process which are used during reconcile cycle";
        type = (types.nullOr ReconcilingRuntimeModule);
        default = null;
      };
    };
  };
  mkReconciling =
    res:
    {
    }
    // optionalAttrs (res."cleanup" != null) { "cleanup" = mkReconcilingCleanup res."cleanup"; }
    // {
    }
    // optionalAttrs (res."configMapPropagationTimeout" != null) {
      inherit (res) "configMapPropagationTimeout";
    }
    // {
    }
    // optionalAttrs (res."macros" != null) { "macros" = mkReconcilingMacros res."macros"; }
    // {
    }
    // optionalAttrs (res."policy" != null) { inherit (res) "policy"; }
    // {
    }
    // optionalAttrs (res."runtime" != null) { "runtime" = mkReconcilingRuntime res."runtime"; }
    // {
    };
  ReconcilingRuntimeModule = types.submodule {
    options = {
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
  mkReconcilingRuntime =
    res:
    {
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
  TemplatesHostTemplateModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "template name, could use to link inside top-level `chi.spec.defaults.templates.hostTemplate`, cluster-level `chi.spec.configuration.clusters.templates.hostTemplate`, shard-level `chi.spec.configuration.clusters.layout.shards.temlates.hostTemplate`, replica-level `chi.spec.configuration.clusters.layout.replicas.templates.hostTemplate`";
        type = (types.nullOr types.str);
        default = null;
      };
      "portDistribution" = mkOption {
        description = "define how will distribute numeric values of named ports in `Pod.spec.containers.ports` and clickhouse-server configs";
        type = (types.listOf TemplatesHostTemplatePortDistributionModule);
        default = [ ];
      };
      "spec" = mkOption {
        type = (types.nullOr TemplatesHostTemplateSpecModule);
        default = null;
      };
    };
  };
  mkTemplatesHostTemplate =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."portDistribution" != [ ]) {
      "portDistribution" = map mkTemplatesHostTemplatePortDistribution res."portDistribution";
    }
    // {
    }
    // optionalAttrs (res."spec" != null) { "spec" = mkTemplatesHostTemplateSpec res."spec"; }
    // {
    };
  TemplatesHostTemplatePortDistributionModule = types.submodule {
    options = {
      "type" = mkOption {
        description = "type of distribution, when `Unspecified` (default value) then all listen ports on clickhouse-server configuration in all Pods will have the same value, when `ClusterScopeIndex` then ports will increment to offset from base value depends on shard and replica index inside cluster with combination of `chi.spec.templates.podTemlates.spec.HostNetwork` it allows setup ClickHouse cluster inside Kubernetes and provide access via external network bypass Kubernetes internal network";
        type = (
          types.nullOr (
            types.enum [
              ""
              "Unspecified"
              "ClusterScopeIndex"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkTemplatesHostTemplatePortDistribution =
    res:
    {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  TemplatesHostTemplateSpecModule = types.submodule {
    options = {
      "files" = mkOption {
        description = "optional, allows define content of any setting file inside each `Pod` where this template will apply during generate `ConfigMap` which will mount in `/etc/clickhouse-server/config.d/` or `/etc/clickhouse-server/conf.d/` or `/etc/clickhouse-server/users.d/`\n";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "httpPort" = mkOption {
        description = "optional, setup `http_port` inside `clickhouse-server` settings for each Pod where current template will apply\nif specified, should have equal value with `chi.spec.templates.podTemplates.spec.containers.ports[name=http]`\nMore info: https://clickhouse.tech/docs/en/interfaces/http/\n";
        type = (types.nullOr types.int);
        default = null;
      };
      "httpsPort" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
      "insecure" = mkOption {
        description = "optional, open insecure ports for cluster, defaults to \"yes\"\n";
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
      "interserverHTTPPort" = mkOption {
        description = "optional, setup `interserver_http_port` inside `clickhouse-server` settings for each Pod where current template will apply\nif specified, should have equal value with `chi.spec.templates.podTemplates.spec.containers.ports[name=interserver]`\nMore info: https://clickhouse.tech/docs/en/operations/server-configuration-parameters/settings/#interserver-http-port\n";
        type = (types.nullOr types.int);
        default = null;
      };
      "name" = mkOption {
        description = "by default, hostname will generate, but this allows define custom name for each `clickhuse-server`";
        type = (types.nullOr types.str);
        default = null;
      };
      "secure" = mkOption {
        description = "optional, open secure ports\n";
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
      "settings" = mkOption {
        description = "optional, allows configure `clickhouse-server` settings inside <yandex>...</yandex> tag in each `Pod` where this template will apply during generate `ConfigMap` which will mount in `/etc/clickhouse-server/conf.d/`\nMore details: https://clickhouse.tech/docs/en/operations/settings/settings/\n";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "tcpPort" = mkOption {
        description = "optional, setup `tcp_port` inside `clickhouse-server` settings for each Pod where current template will apply\nif specified, should have equal value with `chi.spec.templates.podTemplates.spec.containers.ports[name=tcp]`\nMore info: https://clickhouse.tech/docs/en/interfaces/tcp/\n";
        type = (types.nullOr types.int);
        default = null;
      };
      "templates" = mkOption {
        description = "be careful, this part of CRD allows override template inside template, don't use it if you don't understand what you do";
        type = (types.nullOr TemplatesHostTemplateSpecTemplatesModule);
        default = null;
      };
      "tlsPort" = mkOption {
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkTemplatesHostTemplateSpec =
    res:
    {
    }
    // optionalAttrs (res."files" != { }) { inherit (res) "files"; }
    // {
    }
    // optionalAttrs (res."httpPort" != null) { inherit (res) "httpPort"; }
    // {
    }
    // optionalAttrs (res."httpsPort" != null) { inherit (res) "httpsPort"; }
    // {
    }
    // optionalAttrs (res."insecure" != null) { inherit (res) "insecure"; }
    // {
    }
    // optionalAttrs (res."interserverHTTPPort" != null) { inherit (res) "interserverHTTPPort"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."secure" != null) { inherit (res) "secure"; }
    // {
    }
    // optionalAttrs (res."settings" != { }) { inherit (res) "settings"; }
    // {
    }
    // optionalAttrs (res."tcpPort" != null) { inherit (res) "tcpPort"; }
    // {
    }
    // optionalAttrs (res."templates" != null) {
      "templates" = mkTemplatesHostTemplateSpecTemplates res."templates";
    }
    // {
    }
    // optionalAttrs (res."tlsPort" != null) { inherit (res) "tlsPort"; }
    // {
    };
  TemplatesHostTemplateSpecTemplatesModule = types.submodule {
    options = {
      "clusterServiceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates, allows customization for each `Service` resource which will created by `clickhouse-operator` which cover each clickhouse cluster described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "dataVolumeClaimTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.volumeClaimTemplates, allows customization each `PVC` which will mount for clickhouse data directory in each `Pod` during render and reconcile every StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "hostTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.hostTemplates, which will apply to configure every `clickhouse-server` instance during render ConfigMap resources which will mount into `Pod`";
        type = (types.nullOr types.str);
        default = null;
      };
      "logVolumeClaimTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.volumeClaimTemplates, allows customization each `PVC` which will mount for clickhouse log directory in each `Pod` during render and reconcile every StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "podTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.podTemplates, allows customization each `Pod` resource during render and reconcile each StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "replicaServiceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates, allows customization for each `Service` resource which will created by `clickhouse-operator` which cover each replica inside each shard inside each clickhouse cluster described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "serviceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates. used for customization of the `Service` resource, created by `clickhouse-operator` to cover all clusters in whole `chi` resource";
        type = (types.nullOr types.str);
        default = null;
      };
      "serviceTemplates" = mkOption {
        description = "optional, template names from chi.spec.templates.serviceTemplates. used for customization of the `Service` resources, created by `clickhouse-operator` to cover all clusters in whole `chi` resource";
        type = (types.listOf types.str);
        default = [ ];
      };
      "shardServiceTemplate" = mkOption {
        description = "optional, template name from chi.spec.templates.serviceTemplates, allows customization for each `Service` resource which will created by `clickhouse-operator` which cover each shard inside clickhouse cluster described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
      "volumeClaimTemplate" = mkOption {
        description = "optional, alias for dataVolumeClaimTemplate, template name from chi.spec.templates.volumeClaimTemplates, allows customization each `PVC` which will mount for clickhouse data directory in each `Pod` during render and reconcile every StatefulSet.spec resource described in `chi.spec.configuration.clusters`";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkTemplatesHostTemplateSpecTemplates =
    res:
    {
    }
    // optionalAttrs (res."clusterServiceTemplate" != null) { inherit (res) "clusterServiceTemplate"; }
    // {
    }
    // optionalAttrs (res."dataVolumeClaimTemplate" != null) {
      inherit (res) "dataVolumeClaimTemplate";
    }
    // {
    }
    // optionalAttrs (res."hostTemplate" != null) { inherit (res) "hostTemplate"; }
    // {
    }
    // optionalAttrs (res."logVolumeClaimTemplate" != null) { inherit (res) "logVolumeClaimTemplate"; }
    // {
    }
    // optionalAttrs (res."podTemplate" != null) { inherit (res) "podTemplate"; }
    // {
    }
    // optionalAttrs (res."replicaServiceTemplate" != null) { inherit (res) "replicaServiceTemplate"; }
    // {
    }
    // optionalAttrs (res."serviceTemplate" != null) { inherit (res) "serviceTemplate"; }
    // {
    }
    // optionalAttrs (res."serviceTemplates" != [ ]) { inherit (res) "serviceTemplates"; }
    // {
    }
    // optionalAttrs (res."shardServiceTemplate" != null) { inherit (res) "shardServiceTemplate"; }
    // {
    }
    // optionalAttrs (res."volumeClaimTemplate" != null) { inherit (res) "volumeClaimTemplate"; }
    // {
    };
  TemplatesModule = types.submodule {
    options = {
      "hostTemplates" = mkOption {
        description = "hostTemplate will use during apply to generate `clickhose-server` config files";
        type = (types.listOf TemplatesHostTemplateModule);
        default = [ ];
      };
      "podTemplates" = mkOption {
        description = "podTemplate will use during render `Pod` inside `StatefulSet.spec` and allows define rendered `Pod.spec`, pod scheduling distribution and pod zone\nMore information: https://github.com/Altinity/clickhouse-operator/blob/master/docs/custom_resource_explained.md#spectemplatespodtemplates\n";
        type = (types.listOf TemplatesPodTemplateModule);
        default = [ ];
      };
      "serviceTemplates" = mkOption {
        description = "allows define template for rendering `Service` which would get endpoint from Pods which scoped chi-wide, cluster-wide, shard-wide, replica-wide level\n";
        type = (types.listOf TemplatesServiceTemplateModule);
        default = [ ];
      };
      "volumeClaimTemplates" = mkOption {
        description = "allows define template for rendering `PVC` kubernetes resource, which would use inside `Pod` for mount clickhouse `data`, clickhouse `logs` or something else\n";
        type = (types.listOf TemplatesVolumeClaimTemplateModule);
        default = [ ];
      };
    };
  };
  mkTemplates =
    res:
    {
    }
    // optionalAttrs (res."hostTemplates" != [ ]) {
      "hostTemplates" = map mkTemplatesHostTemplate res."hostTemplates";
    }
    // {
    }
    // optionalAttrs (res."podTemplates" != [ ]) {
      "podTemplates" = map mkTemplatesPodTemplate res."podTemplates";
    }
    // {
    }
    // optionalAttrs (res."serviceTemplates" != [ ]) {
      "serviceTemplates" = map mkTemplatesServiceTemplate res."serviceTemplates";
    }
    // {
    }
    // optionalAttrs (res."volumeClaimTemplates" != [ ]) {
      "volumeClaimTemplates" = map mkTemplatesVolumeClaimTemplate res."volumeClaimTemplates";
    }
    // {
    };
  TemplatesPodTemplateModule = types.submodule {
    options = {
      "distribution" = mkOption {
        description = "DEPRECATED, shortcut for `chi.spec.templates.podTemplates.spec.affinity.podAntiAffinity`";
        type = (
          types.nullOr (
            types.enum [
              ""
              "Unspecified"
              "OnePerHost"
            ]
          )
        );
        default = null;
      };
      "generateName" = mkOption {
        description = "allows define format for generated `Pod` name, look to https://github.com/Altinity/clickhouse-operator/blob/master/docs/custom_resource_explained.md#spectemplatesservicetemplates for details about available template variables";
        type = (types.nullOr types.str);
        default = null;
      };
      "metadata" = mkOption {
        description = "allows pass standard object's metadata from template to Pod\nMore info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata\n";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "name" = mkOption {
        description = "template name, could use to link inside top-level `chi.spec.defaults.templates.podTemplate`, cluster-level `chi.spec.configuration.clusters.templates.podTemplate`, shard-level `chi.spec.configuration.clusters.layout.shards.temlates.podTemplate`, replica-level `chi.spec.configuration.clusters.layout.replicas.templates.podTemplate`";
        type = (types.nullOr types.str);
        default = null;
      };
      "podDistribution" = mkOption {
        description = "define ClickHouse Pod distribution policy between Kubernetes Nodes inside Shard, Replica, Namespace, CHI, another ClickHouse cluster";
        type = (types.listOf TemplatesPodTemplatePodDistributionModule);
        default = [ ];
      };
      "spec" = mkOption {
        description = "allows define whole Pod.spec inside StaefulSet.spec, look to https://kubernetes.io/docs/concepts/workloads/pods/#pod-templates for details";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "zone" = mkOption {
        description = "allows define custom zone name and will separate ClickHouse `Pods` between nodes, shortcut for `chi.spec.templates.podTemplates.spec.affinity.podAntiAffinity`";
        type = (types.nullOr TemplatesPodTemplateZoneModule);
        default = null;
      };
    };
  };
  mkTemplatesPodTemplate =
    res:
    {
    }
    // optionalAttrs (res."distribution" != null) { inherit (res) "distribution"; }
    // {
    }
    // optionalAttrs (res."generateName" != null) { inherit (res) "generateName"; }
    // {
    }
    // optionalAttrs (res."metadata" != { }) { inherit (res) "metadata"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."podDistribution" != [ ]) {
      "podDistribution" = map mkTemplatesPodTemplatePodDistribution res."podDistribution";
    }
    // {
    }
    // optionalAttrs (res."spec" != { }) { inherit (res) "spec"; }
    // {
    }
    // optionalAttrs (res."zone" != null) { "zone" = mkTemplatesPodTemplateZone res."zone"; }
    // {
    };
  TemplatesPodTemplatePodDistributionModule = types.submodule {
    options = {
      "number" = mkOption {
        description = "define, how much ClickHouse Pods could be inside selected scope with selected distribution type";
        type = (types.nullOr types.int);
        default = null;
      };
      "scope" = mkOption {
        description = "scope for apply each podDistribution";
        type = (
          types.nullOr (
            types.enum [
              ""
              "Unspecified"
              "Shard"
              "Replica"
              "Cluster"
              "ClickHouseInstallation"
              "Namespace"
            ]
          )
        );
        default = null;
      };
      "topologyKey" = mkOption {
        description = "use for inter-pod affinity look to `pod.spec.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution.podAffinityTerm.topologyKey`,\nmore info: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#inter-pod-affinity-and-anti-affinity\"\n";
        type = (types.nullOr types.str);
        default = null;
      };
      "type" = mkOption {
        description = "you can define multiple affinity policy types";
        type = (
          types.nullOr (
            types.enum [
              ""
              "Unspecified"
              "ClickHouseAntiAffinity"
              "ShardAntiAffinity"
              "ReplicaAntiAffinity"
              "AnotherNamespaceAntiAffinity"
              "AnotherClickHouseInstallationAntiAffinity"
              "AnotherClusterAntiAffinity"
              "MaxNumberPerNode"
              "NamespaceAffinity"
              "ClickHouseInstallationAffinity"
              "ClusterAffinity"
              "ShardAffinity"
              "ReplicaAffinity"
              "PreviousTailAffinity"
              "CircularReplication"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkTemplatesPodTemplatePodDistribution =
    res:
    {
    }
    // optionalAttrs (res."number" != null) { inherit (res) "number"; }
    // {
    }
    // optionalAttrs (res."scope" != null) { inherit (res) "scope"; }
    // {
    }
    // optionalAttrs (res."topologyKey" != null) { inherit (res) "topologyKey"; }
    // {
    }
    // optionalAttrs (res."type" != null) { inherit (res) "type"; }
    // {
    };
  TemplatesPodTemplateZoneModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "optional, if defined, allows select kubernetes nodes by label with `name` equal `key`";
        type = (types.nullOr types.str);
        default = null;
      };
      "values" = mkOption {
        description = "optional, if defined, allows select kubernetes nodes by label with `value` in `values`";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkTemplatesPodTemplateZone =
    res:
    {
    }
    // optionalAttrs (res."key" != null) { inherit (res) "key"; }
    // {
    }
    // optionalAttrs (res."values" != [ ]) { inherit (res) "values"; }
    // {
    };
  TemplatesServiceTemplateModule = types.submodule {
    options = {
      "generateName" = mkOption {
        description = "allows define format for generated `Service` name,\nlook to https://github.com/Altinity/clickhouse-operator/blob/master/docs/custom_resource_explained.md#spectemplatesservicetemplates\nfor details about available template variables\"\n";
        type = (types.nullOr types.str);
        default = null;
      };
      "metadata" = mkOption {
        description = "allows pass standard object's metadata from template to Service\nCould be use for define specificly for Cloud Provider metadata which impact to behavior of service\nMore info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata\n";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "name" = mkOption {
        description = "template name, could use to link inside\nchi-level `chi.spec.defaults.templates.serviceTemplate`\ncluster-level `chi.spec.configuration.clusters.templates.clusterServiceTemplate`\nshard-level `chi.spec.configuration.clusters.layout.shards.temlates.shardServiceTemplate`\nreplica-level `chi.spec.configuration.clusters.layout.replicas.templates.replicaServiceTemplate` or `chi.spec.configuration.clusters.layout.shards.replicas.replicaServiceTemplate`\n";
        type = (types.nullOr types.str);
        default = null;
      };
      "spec" = mkOption {
        description = "describe behavior of generated Service\nMore info: https://kubernetes.io/docs/concepts/services-networking/service/\n";
        type = (types.attrsOf types.anything);
        default = { };
      };
    };
  };
  mkTemplatesServiceTemplate =
    res:
    {
    }
    // optionalAttrs (res."generateName" != null) { inherit (res) "generateName"; }
    // {
    }
    // optionalAttrs (res."metadata" != { }) { inherit (res) "metadata"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."spec" != { }) { inherit (res) "spec"; }
    // {
    };
  TemplatesVolumeClaimTemplateModule = types.submodule {
    options = {
      "metadata" = mkOption {
        description = "allows to pass standard object's metadata from template to PVC\nMore info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata\n";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "name" = mkOption {
        description = "template name, could use to link inside\ntop-level `chi.spec.defaults.templates.dataVolumeClaimTemplate` or `chi.spec.defaults.templates.logVolumeClaimTemplate`,\ncluster-level `chi.spec.configuration.clusters.templates.dataVolumeClaimTemplate` or `chi.spec.configuration.clusters.templates.logVolumeClaimTemplate`,\nshard-level `chi.spec.configuration.clusters.layout.shards.temlates.dataVolumeClaimTemplate` or `chi.spec.configuration.clusters.layout.shards.temlates.logVolumeClaimTemplate`\nreplica-level `chi.spec.configuration.clusters.layout.replicas.templates.dataVolumeClaimTemplate` or `chi.spec.configuration.clusters.layout.replicas.templates.logVolumeClaimTemplate`\n";
        type = (types.nullOr types.str);
        default = null;
      };
      "provisioner" = mkOption {
        description = "defines `PVC` provisioner - be it StatefulSet or the Operator";
        type = (
          types.nullOr (
            types.enum [
              ""
              "StatefulSet"
              "Operator"
            ]
          )
        );
        default = null;
      };
      "reclaimPolicy" = mkOption {
        description = "defines behavior of `PVC` deletion.\n`Delete` by default, if `Retain` specified then `PVC` will be kept when deleting StatefulSet\n";
        type = (
          types.nullOr (
            types.enum [
              ""
              "Retain"
              "Delete"
            ]
          )
        );
        default = null;
      };
      "spec" = mkOption {
        description = "allows define all aspects of `PVC` resource\nMore info: https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims\n";
        type = (types.attrsOf types.anything);
        default = { };
      };
    };
  };
  mkTemplatesVolumeClaimTemplate =
    res:
    {
    }
    // optionalAttrs (res."metadata" != { }) { inherit (res) "metadata"; }
    // {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."provisioner" != null) { inherit (res) "provisioner"; }
    // {
    }
    // optionalAttrs (res."reclaimPolicy" != null) { inherit (res) "reclaimPolicy"; }
    // {
    }
    // optionalAttrs (res."spec" != { }) { inherit (res) "spec"; }
    // {
    };
  TemplatingModule = types.submodule {
    options = {
      "chiSelector" = mkOption {
        description = "Optional, defines selector for ClickHouseInstallation(s) to be templated with ClickhouseInstallationTemplate";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "policy" = mkOption {
        description = "When defined as `auto` inside ClickhouseInstallationTemplate, this ClickhouseInstallationTemplate\nwill be auto-added into ClickHouseInstallation, selectable by `chiSelector`.\nDefault value is `manual`, meaning ClickHouseInstallation should request this ClickhouseInstallationTemplate explicitly.\n";
        type = (
          types.nullOr (
            types.enum [
              ""
              "auto"
              "manual"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkTemplating =
    res:
    {
    }
    // optionalAttrs (res."chiSelector" != { }) { inherit (res) "chiSelector"; }
    // {
    }
    // optionalAttrs (res."policy" != null) { inherit (res) "policy"; }
    // {
    };
  UseTemplateModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "name of `ClickHouseInstallationTemplate` (chit) resource";
        type = (types.nullOr types.str);
        default = null;
      };
      "namespace" = mkOption {
        description = "Kubernetes namespace where need search `chit` resource, depending on `watchNamespaces` settings in `clichouse-operator`";
        type = (types.nullOr types.str);
        default = null;
      };
      "useType" = mkOption {
        description = "optional, current strategy is only merge, and current `chi` settings have more priority than merged template `chit`";
        type = (
          types.nullOr (
            types.enum [
              ""
              "merge"
            ]
          )
        );
        default = null;
      };
    };
  };
  mkUseTemplate =
    res:
    {
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs (res."namespace" != null) { inherit (res) "namespace"; }
    // {
    }
    // optionalAttrs (res."useType" != null) { inherit (res) "useType"; }
    // {
    };
  ClickhouseinstallationtemplatesModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this ClickHouseInstallationTemplate resource.";
        };
        "configuration" = mkOption {
          description = "allows configure multiple aspects and behavior for `clickhouse-server` instance and also allows describe multiple `clickhouse-server` clusters inside one `chi` resource";
          type = (types.nullOr ConfigurationModule);
          default = null;
        };
        "defaults" = mkOption {
          description = "define default behavior for whole ClickHouseInstallation, some behavior can be re-define on cluster, shard and replica level\nMore info: https://github.com/Altinity/clickhouse-operator/blob/master/docs/custom_resource_explained.md#specdefaults\n";
          type = (types.nullOr DefaultsModule);
          default = null;
        };
        "namespaceDomainPattern" = mkOption {
          description = "Custom domain pattern which will be used for DNS names of `Service` or `Pod`.\nTypical use scenario - custom cluster domain in Kubernetes cluster\nExample: %s.svc.my.test\n";
          type = (types.nullOr types.str);
          default = null;
        };
        "reconciling" = mkOption {
          description = "Optional, allows tuning reconciling cycle for ClickhouseInstallation from clickhouse-operator side";
          type = (types.nullOr ReconcilingModule);
          default = null;
        };
        "restart" = mkOption {
          description = "In case 'RollingUpdate' specified, the operator will always restart ClickHouse pods during reconcile.\nThis options is used in rare cases when force restart is required and is typically removed after the use in order to avoid unneeded restarts.\n";
          type = (
            types.nullOr (
              types.enum [
                ""
                "RollingUpdate"
              ]
            )
          );
          default = null;
        };
        "stop" = mkOption {
          description = "Allows to stop all ClickHouse clusters defined in a CHI.\nWorks as the following:\n - When `stop` is `1` operator sets `Replicas: 0` in each StatefulSet. Thie leads to having all `Pods` and `Service` deleted. All PVCs are kept intact.\n - When `stop` is `0` operator sets `Replicas: 1` and `Pod`s and `Service`s will created again and all retained PVCs will be attached to `Pod`s.\n";
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
        "suspend" = mkOption {
          description = "Suspend reconciliation of resources managed by a ClickHouse Installation.\nWorks as the following:\n - When `suspend` is `true` operator stops reconciling all resources.\n - When `suspend` is `false` or not set, operator reconciles all resources.\n";
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
        "taskID" = mkOption {
          description = "Allows to define custom taskID for CHI update and watch status of this update execution.\nDisplayed in all .status.taskID* fields.\nBy default (if not filled) every update of CHI manifest will generate random taskID\n";
          type = (types.nullOr types.str);
          default = null;
        };
        "templates" = mkOption {
          description = "allows define templates which will use for render Kubernetes resources like StatefulSet, ConfigMap, Service, PVC, by default, clickhouse-operator have own templates, but you can override it";
          type = (types.nullOr TemplatesModule);
          default = null;
        };
        "templating" = mkOption {
          description = "Optional, applicable inside ClickHouseInstallationTemplate only.\nDefines current ClickHouseInstallationTemplate application options to target ClickHouseInstallation(s).\"\n";
          type = (types.nullOr TemplatingModule);
          default = null;
        };
        "troubleshoot" = mkOption {
          description = "Allows to troubleshoot Pods during CrashLoopBack state.\nThis may happen when wrong configuration applied, in this case `clickhouse-server` wouldn't start.\nCommand within ClickHouse container is modified with `sleep` in order to avoid quick restarts\nand give time to troubleshoot via CLI.\nLiveness and Readiness probes are disabled as well.\n";
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
        "useTemplates" = mkOption {
          description = "list of `ClickHouseInstallationTemplate` (chit) resource names which will merge with current `CHI`\nmanifest during render Kubernetes resources to create related ClickHouse clusters\"\n";
          type = (types.listOf UseTemplateModule);
          default = [ ];
        };
      };
    }
  );
  mkClickHouseInstallationTemplate = name: res: {
    apiVersion = "clickhouse.altinity.com/v1";
    kind = "ClickHouseInstallationTemplate";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
    }
    // optionalAttrs (res."configuration" != null) {
      "configuration" = mkConfiguration res."configuration";
    }
    // {
    }
    // optionalAttrs (res."defaults" != null) { "defaults" = mkDefaults res."defaults"; }
    // {
    }
    // optionalAttrs (res."namespaceDomainPattern" != null) { inherit (res) "namespaceDomainPattern"; }
    // {
    }
    // optionalAttrs (res."reconciling" != null) { "reconciling" = mkReconciling res."reconciling"; }
    // {
    }
    // optionalAttrs (res."restart" != null) { inherit (res) "restart"; }
    // {
    }
    // optionalAttrs (res."stop" != null) { inherit (res) "stop"; }
    // {
    }
    // optionalAttrs (res."suspend" != null) { inherit (res) "suspend"; }
    // {
    }
    // optionalAttrs (res."taskID" != null) { inherit (res) "taskID"; }
    // {
    }
    // optionalAttrs (res."templates" != null) { "templates" = mkTemplates res."templates"; }
    // {
    }
    // optionalAttrs (res."templating" != null) { "templating" = mkTemplating res."templating"; }
    // {
    }
    // optionalAttrs (res."troubleshoot" != null) { inherit (res) "troubleshoot"; }
    // {
    }
    // optionalAttrs (res."useTemplates" != [ ]) {
      "useTemplates" = map mkUseTemplate res."useTemplates";
    }
    // {
    };
  };
  allResources = (
    mapAttrsToList mkClickHouseInstallationTemplate cfg."clickhouseinstallationtemplates"
  );
in
{
  options.openkrill.apps."clickhouse-operator" = {
    "clickhouseinstallationtemplates" = mkOption {
      type = types.attrsOf ClickhouseinstallationtemplatesModule;
      default = { };
      description = "ClickHouseInstallationTemplate CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."clickhouse-operator".content = allResources;
  };
}
