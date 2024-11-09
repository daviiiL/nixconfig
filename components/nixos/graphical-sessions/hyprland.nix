{
  inputs,
  pkgs,
  lib,
  ...
}: let
  pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [
    inputs.hyprland.nixosModules.default
  ];

  programs.hyprland = {
    enable = true;
    # package = lib.mkDefault inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # portalPackage = lib.mkDefault inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  hardware = {
    opengl = {
      enable = true;
      package = lib.mkForce pkgs-unstable.mesa.drivers;
      driSupport32Bit = true;
      package32 = lib.mkForce pkgs-unstable.pkgsi686Linux.mesa.drivers;
    };
  };
}
