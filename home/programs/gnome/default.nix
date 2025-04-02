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
    ../common
  ];

  home.packages = with unstable-pkgs; [
    gnome-tweaks
    gnome-browser-connector
    gnomeExtensions.dash-to-dock
  ];
}
