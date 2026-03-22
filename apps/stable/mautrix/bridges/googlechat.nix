# Bridge-specific defaults for mautrix-googlechat.
{
  image = {
    repository = "dock.mau.dev/mautrix/googlechat";
    tag = "latest";
  };

  port = 29320;

  bot.username = "googlechatbot";

  appservice.id = "googlechat";

  userRegex = "@googlechat_.*";
}
