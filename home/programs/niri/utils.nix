{
  inputs,
  pkgs,
  ...
}: let
  unstable-pkgs = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in {
  home.packages = with unstable-pkgs; [
    # screen stuff
    brillo
    swww
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

    # notifications
    libnotify
    swaynotificationcenter

    # settings & controls
    blueberry
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
}
