# Bridge-specific defaults for mautrix-slack.
{
  image = {
    repository = "dock.mau.dev/mautrix/slack";
    tag = "latest";
  };

  port = 29335;

  bot.username = "slackbot";

  appservice.id = "slack";

  userRegex = "@slack_.*";
}
