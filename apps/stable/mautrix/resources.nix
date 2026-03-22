# resources.nix — app-template Helm values for a mautrix Go bridge.
#
# Returns an attrset of app-template values that can be passed to
# kubelib.fromHelm.  Called once per enabled bridge from default.nix.
#
# The config uses the bridgev2 (megabridge) format where `database` and
# `homeserver` are top-level keys, not nested under `appservice`.
{ lib }:
{
  name,             # e.g. "whatsapp"
  namespace,        # e.g. "mautrix"
  image,            # { repository, tag }
  port,             # e.g. 29318
  bot,              # { username }
  appservice,       # { id }
  homeserver,       # { address, domain }
  database,         # database name, e.g. "mautrix_whatsapp"
  secretName,       # k8s Secret name, e.g. "mautrix-whatsapp"
  permissions,      # { "*" = "relay"; "@admin:domain" = "admin"; }
  extraConfig ? {}, # deep-merged into bridge config
}:
let
  fullName = "mautrix-${name}";

  asTokenEnvKey = "MAUTRIX_${lib.toUpper name}_AS_TOKEN";
  hsTokenEnvKey = "MAUTRIX_${lib.toUpper name}_HS_TOKEN";

  dbUri = "postgresql://app:$(POSTGRES_PASSWORD)@postgres-rw.cloudnative-pg.svc.cluster.local:5432/${database}?sslmode=disable";

  # The bridge config uses the bridgev2 (megabridge) format.
  # The startup script generates the default config with `-e`, then
  # patches the fields we control.  This ensures all network-specific
  # defaults and the full bridgev2 schema are present.  We only override:
  #   homeserver.address, homeserver.domain, homeserver.software,
  #   appservice.{address,hostname,port,id,bot,as_token,hs_token},
  #   database.uri, bridge.permissions, logging
in
{
  global.nameOverride = fullName;

  controllers.main = {
    strategy = "Recreate";

    containers.main = {
      image = {
        repository = image.repository;
        tag = image.tag;
        pullPolicy = "IfNotPresent";
      };

      command = [ "/bin/sh" "-c" ];
      args = let
        # Build yq commands to set each permission entry.
        permCmds = lib.concatMapStringsSep "\n" (cmd: cmd) (lib.mapAttrsToList (user: level:
          "yq -i '.bridge.permissions.\"${user}\" = \"${level}\"' /data/config.yaml"
        ) permissions);

        # The startup script:
        # 1. Generates the full default bridgev2 config with -e
        # 2. Patches our deployment-specific values using yq (Go version, pre-installed in mautrix images)
        # 3. Starts the bridge
        #
        # This ensures the network-specific example config (WhatsApp
        # settings, history sync, etc.) is always present and up to
        # date with the bridge version.
        script = lib.concatStringsSep "\n" [
          "cd /data"
          "rm -f /data/config.yaml"
          "/usr/bin/${fullName} -c /data/config.yaml -e"
          "yq -i '.homeserver.address = \"${homeserver.address}\"' /data/config.yaml"
          "yq -i '.homeserver.domain = \"${homeserver.domain}\"' /data/config.yaml"
          "yq -i '.homeserver.software = \"standard\"' /data/config.yaml"
          "yq -i '.appservice.address = \"http://${fullName}.${namespace}.svc.cluster.local:${toString port}\"' /data/config.yaml"
          "yq -i '.appservice.hostname = \"0.0.0.0\"' /data/config.yaml"
          "yq -i '.appservice.port = ${toString port}' /data/config.yaml"
          "yq -i '.appservice.id = \"${appservice.id}\"' /data/config.yaml"
          "yq -i '.appservice.bot.username = \"${bot.username}\"' /data/config.yaml"
          ''yq -i '.appservice.as_token = "'"''$${asTokenEnvKey}"'"' /data/config.yaml''
          ''yq -i '.appservice.hs_token = "'"''$${hsTokenEnvKey}"'"' /data/config.yaml''
          ''yq -i '.database.uri = "'"${dbUri}"'"' /data/config.yaml''
          "yq -i '.bridge.permissions = {}' /data/config.yaml"
          permCmds
          "yq -i 'del(.logging.writers[] | select(.type == \"file\"))' /data/config.yaml"
          "yq -i '.logging.min_level = \"info\"' /data/config.yaml"
          # Retry loop: the bridge fatally exits if the as_token isn't
          # registered with the homeserver yet.  Keep retrying every 30s
          # instead of crash-looping with exponential backoff.
          "while true; do"
          "  /usr/bin/${fullName} -c /data/config.yaml --no-update && break"
          "  echo 'Bridge exited, retrying in 30s (is the appservice registered with conduwuit?)...'"
          "  sleep 30"
          "done"
        ];
      in [ script ];

      envFrom = [
        { secretRef.name = secretName; }
      ];

      resources = {
        requests = { cpu = "50m"; memory = "128Mi"; };
        limits   = { memory = "256Mi"; };
      };

      securityContext = {
        allowPrivilegeEscalation = false;
        capabilities.drop = [ "ALL" ];
      };
    };

    pod.securityContext.seccompProfile.type = "RuntimeDefault";
  };

  persistence.data = {
    type = "emptyDir";
    advancedMounts.main.main = [{ path = "/data"; }];
  };

  service.main = {
    controller = "main";
    ports.http = {
      inherit port;
    };
  };
}
