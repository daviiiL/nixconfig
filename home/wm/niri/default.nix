{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localHome.wm.niri;
in {
  imports = [
    ./quickshell.nix
  ];

  options.localHome.wm.niri.enable =
    lib.mkEnableOption "niri session (quickshell shell, launchers, wayland userland)";

  config = lib.mkIf cfg.enable {
    # quickshell is the notification daemon; libnotify provides notify-send
    home.packages = with pkgs; [
      brightnessctl
      libnotify
      playerctl
    ];
  };
}
