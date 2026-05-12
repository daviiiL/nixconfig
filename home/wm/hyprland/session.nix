{
  config,
  lib,
  unstablePkgs,
  ...
}: let
  cfg = config.localHome.wm.hyprland;
in {
  config = lib.mkIf cfg.enable {
    home.packages = with unstablePkgs; [
      xdg-desktop-portal-hyprland

      # screen stuff
      brillo
      awww

      # app launchers
      fuzzel
      bemenu
      anyrun

      # clipboard tools
      wl-clipboard
      cliphist

      # screenshots
      hyprshot

      # settings & controls
      blueman
      gnome-control-center

      # gnome apps
      nautilus
      gnome-calendar

      # lock & idle
      hypridle
      hyprlock

      # misc helpers
      yad
      bc
    ];
  };
}
