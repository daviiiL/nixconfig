{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localSystem.services.input-methods;
in {
  options.localSystem.services.input-methods = {
    enable = lib.mkEnableOption "fcitx5 input method (Wayland frontend)";
    chinese = lib.mkEnableOption "Chinese addons (pinyin, chewing, rime)";
    japanese = lib.mkEnableOption "Japanese addons (mozc)";
  };

  config = lib.mkIf cfg.enable {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs;
          [fcitx5-gtk]
          ++ lib.optionals cfg.chinese [
            fcitx5-chinese-addons
            fcitx5-chewing
            fcitx5-rime
            rime-data
          ]
          ++ lib.optionals cfg.japanese [fcitx5-mozc];
      };
    };
  };
}
