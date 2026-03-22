# Bridge-specific defaults for mautrix-whatsapp.
#
# These values are consumed by default.nix when building the whatsapp
# bridge options and by resources.nix when generating K8s manifests.
{
  image = {
    repository = "dock.mau.dev/mautrix/whatsapp";
    tag = "v0.2602.0";
  };

  port = 29318;

  bot.username = "whatsappbot";

  appservice.id = "whatsapp";

  # Regex prefix for ghost user IDs (domain is appended by resources.nix).
  userRegex = "@whatsapp_.*";
}
