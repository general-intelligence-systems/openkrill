# Bridge-specific defaults for mautrix-twitter.
{
  image = {
    repository = "dock.mau.dev/mautrix/twitter";
    tag = "latest";
  };

  port = 29327;

  bot.username = "twitterbot";

  appservice.id = "twitter";

  userRegex = "@twitter_.*";
}
