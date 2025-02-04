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

    #wm
    anyrun
    fuzzel
    wl-clipboard
    swww
    yad
    bc
    cliphist

    blueberry
    gnome-control-center
    brillo
  ];
}
