# Bridge-specific defaults for mautrix-gmessages (Google Messages).
{
  image = {
    repository = "dock.mau.dev/mautrix/gmessages";
    tag = "latest";
  };

  port = 29336;

  bot.username = "gmessagesbot";

  appservice.id = "gmessages";

  userRegex = "@gmessages_.*";
}
