# Bridge-specific defaults for mautrix-telegram.
{
  image = {
    repository = "dock.mau.dev/mautrix/telegram";
    tag = "latest";
  };

  port = 29317;

  bot.username = "telegrambot";

  appservice.id = "telegram";

  userRegex = "@telegram_.*";
}
