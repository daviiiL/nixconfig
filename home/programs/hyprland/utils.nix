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
