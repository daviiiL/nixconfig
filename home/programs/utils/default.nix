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
    ./nixvim.nix
  ];

  home.packages = with unstable-pkgs; [
    #dev
    gh
    devenv
    vscode-fhs

    #boring stuff
    libreoffice
    zathura

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
    xdg-utils
    hyprshot
    zip
    unzip
    nautilus
    gnome-calendar
    ghostty

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
