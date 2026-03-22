# Bridge-specific defaults for mautrix-zulip.
{
  image = {
    repository = "dock.mau.dev/mautrix/zulip";
    tag = "latest";
  };

  port = 29340;

  bot.username = "zulipbot";

  appservice.id = "zulip";

  userRegex = "@zulip_.*";
}
