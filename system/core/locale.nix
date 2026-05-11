{
  config,
  lib,
  ...
}: {
  options.localSystem.core.locale = {
    enable = lib.mkEnableOption "automatic timezone and default locale";
    defaultLocale = lib.mkOption {
      type = lib.types.str;
      default = "en_US.UTF-8";
      description = "Default system locale.";
    };
  };

  config = lib.mkIf config.localSystem.core.locale.enable {
    services.automatic-timezoned.enable = true;
    i18n.defaultLocale = config.localSystem.core.locale.defaultLocale;
  };
}
