# Bridge-specific defaults for mautrix-bluesky.
{
  image = {
    repository = "dock.mau.dev/mautrix/bluesky";
    tag = "latest";
  };

  port = 29338;

  bot.username = "blueskybot";

  appservice.id = "bluesky";

  userRegex = "@bluesky_.*";
}
