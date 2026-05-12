{
  config,
  lib,
  ...
}: let
  cfg = config.localHome.wm.hyprland;
in {
  imports = [
    ./session.nix
  ];

  options.localHome.wm.hyprland.enable =
    lib.mkEnableOption "Hyprland session userland (wayland packages)";

  config = lib.mkIf cfg.enable {
    localHome.programs.desktop-shells.ags = {
      enable = lib.mkDefault true;
      hyprlandBindings.enable = lib.mkDefault true;
    };
  };
}
