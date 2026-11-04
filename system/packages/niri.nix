{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localSystem.packages.niri;
in {
  options.localSystem.packages.niri = {
    enable = lib.mkEnableOption "niri compositor (system-level)";
  };

  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;
    qt.enable = true;

    environment.systemPackages = with pkgs; [
      alacritty
    ];

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
