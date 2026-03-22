# Bridge-specific defaults for mautrix-meta (Facebook/Instagram).
{
  image = {
    repository = "dock.mau.dev/mautrix/meta";
    tag = "latest";
  };

  port = 29319;

  bot.username = "metabot";

  appservice.id = "meta";

  userRegex = "@meta_.*";
}
