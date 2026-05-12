{
  config,
  lib,
  unstablePkgs,
  ...
}: let
  cfg = config.localHome.wm.niri;
in {
  config = lib.mkIf cfg.enable {
    home.packages = with unstablePkgs; [
      # screen stuff
      brillo
      awww
      brightnessctl

      # app launchers
      fuzzel
      bemenu
      anyrun

      # media controls
      playerctl

      # clipboard tools
      wl-clipboard
      cliphist

      # notifications (daemon provided by quickshell; libnotify gives notify-send)
      libnotify

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
