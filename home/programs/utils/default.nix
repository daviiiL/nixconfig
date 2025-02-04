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
  imports = [
    ./starship.nix
  ];

  home.packages = with unstable-pkgs; [
    #dev
    gh
    devenv

    #system tools
    tre-command
    eza
    brillo
    fuzzel
    wl-clipboard
    yad
    bc
    cliphist
    powertop
    btop

    #wayland necessity
    swww

    #wm
    anyrun
    blueberry
    gnome-control-center
    hypridle
    hyprlock
  ];
}
