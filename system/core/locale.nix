{
  config,
  lib,
  ...
}: let
  cfg = config.localSystem.core.locale;
in {
  options.localSystem.core.locale = {
    enable = lib.mkEnableOption "automatic timezone and default locale";
    defaultLocale = lib.mkOption {
      type = lib.types.str;
      default = "en_US.UTF-8";
      description = "Default system locale.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.automatic-timezoned.enable = true;
    i18n.defaultLocale = cfg.defaultLocale;
  };
}
