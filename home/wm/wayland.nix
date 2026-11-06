# shared by niri and hyprland, no toggle
{
  config,
  lib,
  pkgs,
  ...
}: let
  wm = config.localHome.wm;
in {
  config = lib.mkIf (wm.hyprland.enable || wm.niri.enable) {
    home.packages = with pkgs; [
      # launchers
      fuzzel
      bemenu
      anyrun

      # screen
      awww
      brillo

      # clipboard
      wl-clipboard
      cliphist

      # settings & apps
      blueman
      gnome-control-center
      nautilus
      gnome-calendar

      # lock & idle
      hypridle
      hyprlock

      # script helpers
      yad
      bc
    ];
  };
}
