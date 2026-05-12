{
  config,
  lib,
  ...
}: let
  cfg = config.localHome.wm.niri;
in {
  imports = [
    ./session.nix
  ];

  options.localHome.wm.niri.enable =
    lib.mkEnableOption "niri session userland (wayland packages)";

  config = lib.mkIf cfg.enable {
    localHome.programs.desktop-shells.quickshell = {
      enable = lib.mkDefault true;
      niriPlugin.enable = lib.mkDefault true;
    };
  };
}
