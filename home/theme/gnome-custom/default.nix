{
  config,
  lib,
  ...
}: let
  cfg = config.localHome.theme.gnome-custom;
in {
  imports = [
    ./program-themes
  ];

  options.localHome.theme.gnome-custom.enable =
    lib.mkEnableOption "gnome-custom theming (ghostty mocha override; pulls font only)";

  config = lib.mkIf cfg.enable {
    localHome.theme.base.font.enable = lib.mkDefault true;
  };
}
