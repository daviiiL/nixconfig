{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localSystem.packages.hyprland;
in {
  options.localSystem.packages.hyprland = {
    enable = lib.mkEnableOption "Hyprland compositor (system-level)";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland.enable = true;

    environment.systemPackages = with pkgs; [
      kitty
      hyprcursor
    ];

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
