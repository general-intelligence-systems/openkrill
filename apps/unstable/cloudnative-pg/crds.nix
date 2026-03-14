# Auto-generated openkrill module fragment for cloudnative-pg
# Generated from CRD specification. See specs/nix-module-crds.md.
# This is a fragment — import from a composing module that declares
# enable, extraManifests, and other shared options.
{ config, lib, ... }:
with lib;
let
  cfg = config.openkrill.apps."cloudnative-pg";
  compact = filterAttrs (_: v: v != null);
  ConfigurationAzureCredentialsConnectionStringModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkConfigurationAzureCredentialsConnectionString = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  ConfigurationAzureCredentialsModule = types.submodule {
    options = {
      "connectionString" = mkOption {
        description = "The connection string to be used";
        type = (types.nullOr ConfigurationAzureCredentialsConnectionStringModule);
        default = null;
      };
      "inheritFromAzureAD" = mkOption {
        description = "Use the Azure AD based authentication without providing explicitly the keys.";
        type = types.bool;
        default = false;
      };
      "storageAccount" = mkOption {
        description = "The storage account where to upload data";
        type = (types.nullOr ConfigurationAzureCredentialsStorageAccountModule);
        default = null;
      };
      "storageKey" = mkOption {
        description = "The storage account key to be used in conjunction\nwith the storage account name";
        type = (types.nullOr ConfigurationAzureCredentialsStorageKeyModule);
        default = null;
      };
      "storageSasToken" = mkOption {
        description = "A shared-access-signature to be used in conjunction with\nthe storage account name";
        type = (types.nullOr ConfigurationAzureCredentialsStorageSasTokenModule);
        default = null;
      };
    };
  };
  mkConfigurationAzureCredentials =
    res:
    {
    }
    // optionalAttrs (res."connectionString" != null) {
      "connectionString" = mkConfigurationAzureCredentialsConnectionString res."connectionString";
    }
    // {
    }
    // optionalAttrs res."inheritFromAzureAD" { inherit (res) "inheritFromAzureAD"; }
    // {
    }
    // optionalAttrs (res."storageAccount" != null) {
      "storageAccount" = mkConfigurationAzureCredentialsStorageAccount res."storageAccount";
    }
    // {
    }
    // optionalAttrs (res."storageKey" != null) {
      "storageKey" = mkConfigurationAzureCredentialsStorageKey res."storageKey";
    }
    // {
    }
    // optionalAttrs (res."storageSasToken" != null) {
      "storageSasToken" = mkConfigurationAzureCredentialsStorageSasToken res."storageSasToken";
    }
    // {
    };
  ConfigurationAzureCredentialsStorageAccountModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkConfigurationAzureCredentialsStorageAccount = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  ConfigurationAzureCredentialsStorageKeyModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkConfigurationAzureCredentialsStorageKey = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  ConfigurationAzureCredentialsStorageSasTokenModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkConfigurationAzureCredentialsStorageSasToken = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  ConfigurationDataModule = types.submodule {
    options = {
      "additionalCommandArgs" = mkOption {
        description = "AdditionalCommandArgs represents additional arguments that can be appended\nto the 'barman-cloud-backup' command-line invocation. These arguments\nprovide flexibility to customize the backup process further according to\nspecific requirements or configurations.\n\nExample:\nIn a scenario where specialized backup options are required, such as setting\na specific timeout or defining custom behavior, users can use this field\nto specify additional command arguments.\n\nNote:\nIt's essential to ensure that the provided arguments are valid and supported\nby the 'barman-cloud-backup' command, to avoid potential errors or unintended\nbehavior during execution.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "compression" = mkOption {
        description = "Compress a backup file (a tar file per tablespace) while streaming it\nto the object store. Available options are empty string (no\ncompression, default), `gzip`, `bzip2`, and `snappy`.";
        type = (
          types.nullOr (
            types.enum [
              "bzip2"
              "gzip"
              "snappy"
            ]
          )
        );
        default = null;
      };
      "encryption" = mkOption {
        description = "Whenever to force the encryption of files (if the bucket is\nnot already configured for that).\nAllowed options are empty string (use the bucket policy, default),\n`AES256` and `aws:kms`";
        type = (
          types.nullOr (
            types.enum [
              "AES256"
              "aws:kms"
            ]
          )
        );
        default = null;
      };
      "immediateCheckpoint" = mkOption {
        description = "Control whether the I/O workload for the backup initial checkpoint will\nbe limited, according to the `checkpoint_completion_target` setting on\nthe PostgreSQL server. If set to true, an immediate checkpoint will be\nused, meaning PostgreSQL will complete the checkpoint as soon as\npossible. `false` by default.";
        type = types.bool;
        default = false;
      };
      "jobs" = mkOption {
        description = "The number of parallel jobs to be used to upload the backup, defaults\nto 2";
        type = (types.nullOr types.int);
        default = null;
      };
    };
  };
  mkConfigurationData =
    res:
    {
    }
    // optionalAttrs (res."additionalCommandArgs" != [ ]) { inherit (res) "additionalCommandArgs"; }
    // {
    }
    // optionalAttrs (res."compression" != null) { inherit (res) "compression"; }
    // {
    }
    // optionalAttrs (res."encryption" != null) { inherit (res) "encryption"; }
    // {
    }
    // optionalAttrs res."immediateCheckpoint" { inherit (res) "immediateCheckpoint"; }
    // {
    }
    // optionalAttrs (res."jobs" != null) { inherit (res) "jobs"; }
    // {
    };
  ConfigurationEndpointCAModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkConfigurationEndpointCA = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  ConfigurationGoogleCredentialsApplicationCredentialsModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkConfigurationGoogleCredentialsApplicationCredentials = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  ConfigurationGoogleCredentialsModule = types.submodule {
    options = {
      "applicationCredentials" = mkOption {
        description = "The secret containing the Google Cloud Storage JSON file with the credentials";
        type = (types.nullOr ConfigurationGoogleCredentialsApplicationCredentialsModule);
        default = null;
      };
      "gkeEnvironment" = mkOption {
        description = "If set to true, will presume that it's running inside a GKE environment,\ndefault to false.";
        type = types.bool;
        default = false;
      };
    };
  };
  mkConfigurationGoogleCredentials =
    res:
    {
    }
    // optionalAttrs (res."applicationCredentials" != null) {
      "applicationCredentials" =
        mkConfigurationGoogleCredentialsApplicationCredentials
          res."applicationCredentials";
    }
    // {
    }
    // optionalAttrs res."gkeEnvironment" { inherit (res) "gkeEnvironment"; }
    // {
    };
  ConfigurationModule = types.submodule {
    options = {
      "azureCredentials" = mkOption {
        description = "The credentials to use to upload data to Azure Blob Storage";
        type = (types.nullOr ConfigurationAzureCredentialsModule);
        default = null;
      };
      "data" = mkOption {
        description = "The configuration to be used to backup the data files\nWhen not defined, base backups files will be stored uncompressed and may\nbe unencrypted in the object store, according to the bucket default\npolicy.";
        type = (types.nullOr ConfigurationDataModule);
        default = null;
      };
      "destinationPath" = mkOption {
        description = "The path where to store the backup (i.e. s3://bucket/path/to/folder)\nthis path, with different destination folders, will be used for WALs\nand for data";
        type = types.str;
      };
      "endpointCA" = mkOption {
        description = "EndpointCA store the CA bundle of the barman endpoint.\nUseful when using self-signed certificates to avoid\nerrors with certificate issuer and barman-cloud-wal-archive";
        type = (types.nullOr ConfigurationEndpointCAModule);
        default = null;
      };
      "endpointURL" = mkOption {
        description = "Endpoint to be used to upload data to the cloud,\noverriding the automatic endpoint discovery";
        type = (types.nullOr types.str);
        default = null;
      };
      "googleCredentials" = mkOption {
        description = "The credentials to use to upload data to Google Cloud Storage";
        type = (types.nullOr ConfigurationGoogleCredentialsModule);
        default = null;
      };
      "historyTags" = mkOption {
        description = "HistoryTags is a list of key value pairs that will be passed to the\nBarman --history-tags option.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "s3Credentials" = mkOption {
        description = "The credentials to use to upload data to S3";
        type = (types.nullOr ConfigurationS3CredentialsModule);
        default = null;
      };
      "serverName" = mkOption {
        description = "The server name on S3, the cluster name is used if this\nparameter is omitted";
        type = (types.nullOr types.str);
        default = null;
      };
      "tags" = mkOption {
        description = "Tags is a list of key value pairs that will be passed to the\nBarman --tags option.";
        type = (types.attrsOf types.str);
        default = { };
      };
      "wal" = mkOption {
        description = "The configuration for the backup of the WAL stream.\nWhen not defined, WAL files will be stored uncompressed and may be\nunencrypted in the object store, according to the bucket default policy.";
        type = (types.nullOr ConfigurationWalModule);
        default = null;
      };
    };
  };
  mkConfiguration =
    res:
    {
    }
    // optionalAttrs (res."azureCredentials" != null) {
      "azureCredentials" = mkConfigurationAzureCredentials res."azureCredentials";
    }
    // {
    }
    // optionalAttrs (res."data" != null) { "data" = mkConfigurationData res."data"; }
    // {
      inherit (res) "destinationPath";
    }
    // optionalAttrs (res."endpointCA" != null) {
      "endpointCA" = mkConfigurationEndpointCA res."endpointCA";
    }
    // {
    }
    // optionalAttrs (res."endpointURL" != null) { inherit (res) "endpointURL"; }
    // {
    }
    // optionalAttrs (res."googleCredentials" != null) {
      "googleCredentials" = mkConfigurationGoogleCredentials res."googleCredentials";
    }
    // {
    }
    // optionalAttrs (res."historyTags" != { }) { inherit (res) "historyTags"; }
    // {
    }
    // optionalAttrs (res."s3Credentials" != null) {
      "s3Credentials" = mkConfigurationS3Credentials res."s3Credentials";
    }
    // {
    }
    // optionalAttrs (res."serverName" != null) { inherit (res) "serverName"; }
    // {
    }
    // optionalAttrs (res."tags" != { }) { inherit (res) "tags"; }
    // {
    }
    // optionalAttrs (res."wal" != null) { "wal" = mkConfigurationWal res."wal"; }
    // {
    };
  ConfigurationS3CredentialsAccessKeyIdModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkConfigurationS3CredentialsAccessKeyId = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  ConfigurationS3CredentialsModule = types.submodule {
    options = {
      "accessKeyId" = mkOption {
        description = "The reference to the access key id";
        type = (types.nullOr ConfigurationS3CredentialsAccessKeyIdModule);
        default = null;
      };
      "inheritFromIAMRole" = mkOption {
        description = "Use the role based authentication without providing explicitly the keys.";
        type = types.bool;
        default = false;
      };
      "region" = mkOption {
        description = "The reference to the secret containing the region name";
        type = (types.nullOr ConfigurationS3CredentialsRegionModule);
        default = null;
      };
      "secretAccessKey" = mkOption {
        description = "The reference to the secret access key";
        type = (types.nullOr ConfigurationS3CredentialsSecretAccessKeyModule);
        default = null;
      };
      "sessionToken" = mkOption {
        description = "The references to the session key";
        type = (types.nullOr ConfigurationS3CredentialsSessionTokenModule);
        default = null;
      };
    };
  };
  mkConfigurationS3Credentials =
    res:
    {
    }
    // optionalAttrs (res."accessKeyId" != null) {
      "accessKeyId" = mkConfigurationS3CredentialsAccessKeyId res."accessKeyId";
    }
    // {
    }
    // optionalAttrs res."inheritFromIAMRole" { inherit (res) "inheritFromIAMRole"; }
    // {
    }
    // optionalAttrs (res."region" != null) {
      "region" = mkConfigurationS3CredentialsRegion res."region";
    }
    // {
    }
    // optionalAttrs (res."secretAccessKey" != null) {
      "secretAccessKey" = mkConfigurationS3CredentialsSecretAccessKey res."secretAccessKey";
    }
    // {
    }
    // optionalAttrs (res."sessionToken" != null) {
      "sessionToken" = mkConfigurationS3CredentialsSessionToken res."sessionToken";
    }
    // {
    };
  ConfigurationS3CredentialsRegionModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkConfigurationS3CredentialsRegion = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  ConfigurationS3CredentialsSecretAccessKeyModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkConfigurationS3CredentialsSecretAccessKey = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  ConfigurationS3CredentialsSessionTokenModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.";
        type = types.str;
      };
    };
  };
  mkConfigurationS3CredentialsSessionToken = res: {
    inherit (res) "key";
    inherit (res) "name";
  };
  ConfigurationWalModule = types.submodule {
    options = {
      "archiveAdditionalCommandArgs" = mkOption {
        description = "Additional arguments that can be appended to the 'barman-cloud-wal-archive'\ncommand-line invocation. These arguments provide flexibility to customize\nthe WAL archive process further, according to specific requirements or configurations.\n\nExample:\nIn a scenario where specialized backup options are required, such as setting\na specific timeout or defining custom behavior, users can use this field\nto specify additional command arguments.\n\nNote:\nIt's essential to ensure that the provided arguments are valid and supported\nby the 'barman-cloud-wal-archive' command, to avoid potential errors or unintended\nbehavior during execution.";
        type = (types.listOf types.str);
        default = [ ];
      };
      "compression" = mkOption {
        description = "Compress a WAL file before sending it to the object store. Available\noptions are empty string (no compression, default), `gzip`, `bzip2`,\n`lz4`, `snappy`, `xz`, and `zstd`.";
        type = (
          types.nullOr (
            types.enum [
              "bzip2"
              "gzip"
              "lz4"
              "snappy"
              "xz"
              "zstd"
            ]
          )
        );
        default = null;
      };
      "encryption" = mkOption {
        description = "Whenever to force the encryption of files (if the bucket is\nnot already configured for that).\nAllowed options are empty string (use the bucket policy, default),\n`AES256` and `aws:kms`";
        type = (
          types.nullOr (
            types.enum [
              "AES256"
              "aws:kms"
            ]
          )
        );
        default = null;
      };
      "maxParallel" = mkOption {
        description = "Number of WAL files to be either archived in parallel (when the\nPostgreSQL instance is archiving to a backup object store) or\nrestored in parallel (when a PostgreSQL standby is fetching WAL\nfiles from a recovery object store). If not specified, WAL files\nwill be processed one at a time. It accepts a positive integer as a\nvalue - with 1 being the minimum accepted value.";
        type = (types.nullOr types.int);
        default = null;
      };
      "restoreAdditionalCommandArgs" = mkOption {
        description = "Additional arguments that can be appended to the 'barman-cloud-wal-restore'\ncommand-line invocation. These arguments provide flexibility to customize\nthe WAL restore process further, according to specific requirements or configurations.\n\nExample:\nIn a scenario where specialized backup options are required, such as setting\na specific timeout or defining custom behavior, users can use this field\nto specify additional command arguments.\n\nNote:\nIt's essential to ensure that the provided arguments are valid and supported\nby the 'barman-cloud-wal-restore' command, to avoid potential errors or unintended\nbehavior during execution.";
        type = (types.listOf types.str);
        default = [ ];
      };
    };
  };
  mkConfigurationWal =
    res:
    {
    }
    // optionalAttrs (res."archiveAdditionalCommandArgs" != [ ]) {
      inherit (res) "archiveAdditionalCommandArgs";
    }
    // {
    }
    // optionalAttrs (res."compression" != null) { inherit (res) "compression"; }
    // {
    }
    // optionalAttrs (res."encryption" != null) { inherit (res) "encryption"; }
    // {
    }
    // optionalAttrs (res."maxParallel" != null) { inherit (res) "maxParallel"; }
    // {
    }
    // optionalAttrs (res."restoreAdditionalCommandArgs" != [ ]) {
      inherit (res) "restoreAdditionalCommandArgs";
    }
    // {
    };
  InstanceSidecarConfigurationEnvModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name of the environment variable. Must be a C_IDENTIFIER.";
        type = types.str;
      };
      "value" = mkOption {
        description = "Variable references $(VAR_NAME) are expanded\nusing the previously defined environment variables in the container and\nany service environment variables. If a variable cannot be resolved,\nthe reference in the input string will be unchanged. Double $$ are reduced\nto a single $, which allows for escaping the $(VAR_NAME) syntax: i.e.\n\"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\".\nEscaped references will never be expanded, regardless of whether the variable\nexists or not.\nDefaults to \"\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "valueFrom" = mkOption {
        description = "Source for the environment variable's value. Cannot be used if value is not empty.";
        type = (types.nullOr InstanceSidecarConfigurationEnvValueFromModule);
        default = null;
      };
    };
  };
  mkInstanceSidecarConfigurationEnv =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."value" != null) { inherit (res) "value"; }
    // {
    }
    // optionalAttrs (res."valueFrom" != null) {
      "valueFrom" = mkInstanceSidecarConfigurationEnvValueFrom res."valueFrom";
    }
    // {
    };
  InstanceSidecarConfigurationEnvValueFromConfigMapKeyRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key to select.";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "Specify whether the ConfigMap or its key must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkInstanceSidecarConfigurationEnvValueFromConfigMapKeyRef =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  InstanceSidecarConfigurationEnvValueFromFieldRefModule = types.submodule {
    options = {
      "apiVersion" = mkOption {
        description = "Version of the schema the FieldPath is written in terms of, defaults to \"v1\".";
        type = (types.nullOr types.str);
        default = null;
      };
      "fieldPath" = mkOption {
        description = "Path of the field to select in the specified API version.";
        type = types.str;
      };
    };
  };
  mkInstanceSidecarConfigurationEnvValueFromFieldRef =
    res:
    {
    }
    // optionalAttrs (res."apiVersion" != null) { inherit (res) "apiVersion"; }
    // {
      inherit (res) "fieldPath";
    };
  InstanceSidecarConfigurationEnvValueFromModule = types.submodule {
    options = {
      "configMapKeyRef" = mkOption {
        description = "Selects a key of a ConfigMap.";
        type = (types.nullOr InstanceSidecarConfigurationEnvValueFromConfigMapKeyRefModule);
        default = null;
      };
      "fieldRef" = mkOption {
        description = "Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`,\nspec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs.";
        type = (types.nullOr InstanceSidecarConfigurationEnvValueFromFieldRefModule);
        default = null;
      };
      "resourceFieldRef" = mkOption {
        description = "Selects a resource of the container: only resources limits and requests\n(limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported.";
        type = (types.nullOr InstanceSidecarConfigurationEnvValueFromResourceFieldRefModule);
        default = null;
      };
      "secretKeyRef" = mkOption {
        description = "Selects a key of a secret in the pod's namespace";
        type = (types.nullOr InstanceSidecarConfigurationEnvValueFromSecretKeyRefModule);
        default = null;
      };
    };
  };
  mkInstanceSidecarConfigurationEnvValueFrom =
    res:
    {
    }
    // optionalAttrs (res."configMapKeyRef" != null) {
      "configMapKeyRef" = mkInstanceSidecarConfigurationEnvValueFromConfigMapKeyRef res."configMapKeyRef";
    }
    // {
    }
    // optionalAttrs (res."fieldRef" != null) {
      "fieldRef" = mkInstanceSidecarConfigurationEnvValueFromFieldRef res."fieldRef";
    }
    // {
    }
    // optionalAttrs (res."resourceFieldRef" != null) {
      "resourceFieldRef" =
        mkInstanceSidecarConfigurationEnvValueFromResourceFieldRef
          res."resourceFieldRef";
    }
    // {
    }
    // optionalAttrs (res."secretKeyRef" != null) {
      "secretKeyRef" = mkInstanceSidecarConfigurationEnvValueFromSecretKeyRef res."secretKeyRef";
    }
    // {
    };
  InstanceSidecarConfigurationEnvValueFromResourceFieldRefModule = types.submodule {
    options = {
      "containerName" = mkOption {
        description = "Container name: required for volumes, optional for env vars";
        type = (types.nullOr types.str);
        default = null;
      };
      "divisor" = mkOption {
        description = "Specifies the output format of the exposed resources, defaults to \"1\"";
        type = types.anything;
        default = { };
      };
      "resource" = mkOption {
        description = "Required: resource to select";
        type = types.str;
      };
    };
  };
  mkInstanceSidecarConfigurationEnvValueFromResourceFieldRef =
    res:
    {
    }
    // optionalAttrs (res."containerName" != null) { inherit (res) "containerName"; }
    // {
    }
    // optionalAttrs (res."divisor" != null) { inherit (res) "divisor"; }
    // {
      inherit (res) "resource";
    };
  InstanceSidecarConfigurationEnvValueFromSecretKeyRefModule = types.submodule {
    options = {
      "key" = mkOption {
        description = "The key of the secret to select from.  Must be a valid secret key.";
        type = types.str;
      };
      "name" = mkOption {
        description = "Name of the referent.\nThis field is effectively required, but due to backwards compatibility is\nallowed to be empty. Instances of this type with an empty value here are\nalmost certainly wrong.\nMore info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names";
        type = (types.nullOr types.str);
        default = "";
      };
      "optional" = mkOption {
        description = "Specify whether the Secret or its key must be defined";
        type = types.bool;
        default = false;
      };
    };
  };
  mkInstanceSidecarConfigurationEnvValueFromSecretKeyRef =
    res:
    {
      inherit (res) "key";
    }
    // optionalAttrs (res."name" != null) { inherit (res) "name"; }
    // {
    }
    // optionalAttrs res."optional" { inherit (res) "optional"; }
    // {
    };
  InstanceSidecarConfigurationModule = types.submodule {
    options = {
      "env" = mkOption {
        description = "The environment to be explicitly passed to the sidecar";
        type = (types.listOf InstanceSidecarConfigurationEnvModule);
        default = [ ];
      };
      "resources" = mkOption {
        description = "Resources define cpu/memory requests and limits for the sidecar that runs in the instance pods.";
        type = (types.nullOr InstanceSidecarConfigurationResourcesModule);
        default = null;
      };
      "retentionPolicyIntervalSeconds" = mkOption {
        description = "The retentionCheckInterval defines the frequency at which the\nsystem checks and enforces retention policies.";
        type = (types.nullOr types.int);
        default = 1800;
      };
    };
  };
  mkInstanceSidecarConfiguration =
    res:
    {
    }
    // optionalAttrs (res."env" != [ ]) { "env" = map mkInstanceSidecarConfigurationEnv res."env"; }
    // {
    }
    // optionalAttrs (res."resources" != null) {
      "resources" = mkInstanceSidecarConfigurationResources res."resources";
    }
    // {
    }
    // optionalAttrs (res."retentionPolicyIntervalSeconds" != null) {
      inherit (res) "retentionPolicyIntervalSeconds";
    }
    // {
    };
  InstanceSidecarConfigurationResourcesClaimModule = types.submodule {
    options = {
      "name" = mkOption {
        description = "Name must match the name of one entry in pod.spec.resourceClaims of\nthe Pod where this field is used. It makes that resource available\ninside a container.";
        type = types.str;
      };
      "request" = mkOption {
        description = "Request is the name chosen for a request in the referenced claim.\nIf empty, everything from the claim is made available, otherwise\nonly the result of this request.";
        type = (types.nullOr types.str);
        default = null;
      };
    };
  };
  mkInstanceSidecarConfigurationResourcesClaim =
    res:
    {
      inherit (res) "name";
    }
    // optionalAttrs (res."request" != null) { inherit (res) "request"; }
    // {
    };
  InstanceSidecarConfigurationResourcesModule = types.submodule {
    options = {
      "claims" = mkOption {
        description = "Claims lists the names of resources, defined in spec.resourceClaims,\nthat are used by this container.\n\nThis is an alpha field and requires enabling the\nDynamicResourceAllocation feature gate.\n\nThis field is immutable. It can only be set for containers.";
        type = (types.listOf InstanceSidecarConfigurationResourcesClaimModule);
        default = [ ];
      };
      "limits" = mkOption {
        description = "Limits describes the maximum amount of compute resources allowed.\nMore info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.attrsOf types.anything);
        default = { };
      };
      "requests" = mkOption {
        description = "Requests describes the minimum amount of compute resources required.\nIf Requests is omitted for a container, it defaults to Limits if that is explicitly specified,\notherwise to an implementation-defined value. Requests cannot exceed Limits.\nMore info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/";
        type = (types.attrsOf types.anything);
        default = { };
      };
    };
  };
  mkInstanceSidecarConfigurationResources =
    res:
    {
    }
    // optionalAttrs (res."claims" != [ ]) {
      "claims" = map mkInstanceSidecarConfigurationResourcesClaim res."claims";
    }
    // {
    }
    // optionalAttrs (res."limits" != { }) { inherit (res) "limits"; }
    // {
    }
    // optionalAttrs (res."requests" != { }) { inherit (res) "requests"; }
    // {
    };
  ObjectstoresModule = types.submodule (
    { name, ... }:
    {
      options = {
        "namespace" = mkOption {
          type = types.str;
          description = "Namespace for this ObjectStore resource.";
        };
        "configuration" = mkOption {
          description = "The configuration for the barman-cloud tool suite";
          type = ConfigurationModule;
        };
        "instanceSidecarConfiguration" = mkOption {
          description = "The configuration for the sidecar that runs in the instance pods";
          type = (types.nullOr InstanceSidecarConfigurationModule);
          default = null;
        };
        "retentionPolicy" = mkOption {
          description = "RetentionPolicy is the retention policy to be used for backups\nand WALs (i.e. '60d'). The retention policy is expressed in the form\nof `XXu` where `XX` is a positive integer and `u` is in `[dwm]` -\ndays, weeks, months.";
          type = (types.nullOr types.str);
          default = null;
        };
      };
    }
  );
  mkObjectStore = name: res: {
    apiVersion = "barmancloud.cnpg.io/v1";
    kind = "ObjectStore";
    metadata = {
      inherit name;
      namespace = res.namespace;
    };
    spec = {
      "configuration" = mkConfiguration res."configuration";
    }
    // optionalAttrs (res."instanceSidecarConfiguration" != null) {
      "instanceSidecarConfiguration" = mkInstanceSidecarConfiguration res."instanceSidecarConfiguration";
    }
    // {
    }
    // optionalAttrs (res."retentionPolicy" != null) { inherit (res) "retentionPolicy"; }
    // {
    };
  };
  allResources = (mapAttrsToList mkObjectStore cfg."objectstores");
in
{
  options.openkrill.apps."cloudnative-pg" = {
    "objectstores" = mkOption {
      type = types.attrsOf ObjectstoresModule;
      default = { };
      description = "ObjectStore CRD instances.";
    };
  };
  config = mkIf cfg.enable {
    openkrill.manifests."cloudnative-pg".content = allResources;
  };
}
