# Bridge-specific defaults for mautrix-gvoice (Google Voice).
{
  image = {
    repository = "dock.mau.dev/mautrix/gvoice";
    tag = "latest";
  };

  port = 29337;

  bot.username = "gvoicebot";

  appservice.id = "gvoice";

  userRegex = "@gvoice_.*";
}
