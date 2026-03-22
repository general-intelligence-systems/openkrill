# Bridge-specific defaults for mautrix-signal.
{
  image = {
    repository = "dock.mau.dev/mautrix/signal";
    tag = "latest";
  };

  port = 29328;

  bot.username = "signalbot";

  appservice.id = "signal";

  userRegex = "@signal_.*";
}
