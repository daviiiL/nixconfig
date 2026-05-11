{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localSystem.services.greetd;
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
in {
  options.localSystem.services.greetd = {
    enable = lib.mkEnableOption "greetd login manager (tuigreet)";

    defaultSession = lib.mkOption {
      type = lib.types.str;
      default = "Hyprland";
      description = "Session command launched after login.";
    };

    theme = lib.mkOption {
      type = lib.types.str;
      default = "container=black;border=yellow;input=yellow";
      description = "tuigreet --theme value.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings.default_session = {
        command = "${tuigreet} --time --remember --cmd ${cfg.defaultSession} --theme ${cfg.theme}";
        user = "greeter";
      };
    };

    security.pam.services.greetd.enableGnomeKeyring = true;
  };
}
