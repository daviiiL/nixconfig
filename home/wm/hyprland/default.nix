{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localHome.wm.hyprland;
in {
  imports = [
    ./ags.nix
  ];

  options.localHome.wm.hyprland.enable =
    lib.mkEnableOption "Hyprland session (ags shell, launchers, wayland userland)";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      xdg-desktop-portal-hyprland
      hyprshot
    ];
  };
}
