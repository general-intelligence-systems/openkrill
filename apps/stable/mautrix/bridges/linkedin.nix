# Bridge-specific defaults for mautrix-linkedin.
{
  image = {
    repository = "dock.mau.dev/mautrix/linkedin";
    tag = "latest";
  };

  port = 29339;

  bot.username = "linkedinbot";

  appservice.id = "linkedin";

  userRegex = "@linkedin_.*";
}
