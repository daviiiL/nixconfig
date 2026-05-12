{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localHome.theme.base.font;
in {
  options.localHome.theme.base.font.enable =
    lib.mkEnableOption "GTK font (FiraCode Nerd Font)";

  config = lib.mkIf cfg.enable {
    gtk.font = {
      name = "FiraCode Nerd Font";
      package = pkgs.nerd-fonts.fira-code;
      size = 11;
    };
  };
}
