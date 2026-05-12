{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localHome.theme.base;
in {
  imports = [
    ./font.nix
  ];

  options.localHome.theme.base.enable =
    lib.mkEnableOption "shared theme base (adw-gtk3, Papirus icons, Bibata cursor, font)";

  config = lib.mkIf cfg.enable {
    localHome.theme.base.font.enable = lib.mkDefault true;

    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    gtk = {
      enable = true;
      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
    };
  };
}
