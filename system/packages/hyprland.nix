{
  config,
  lib,
  pkgs,
  ...
}: {
  options.localSystem.packages.hyprland = {
    enable = lib.mkEnableOption "Hyprland compositor (system-level)";
  };

  config = lib.mkIf config.localSystem.packages.hyprland.enable {
    programs.hyprland.enable = true;

    environment.systemPackages = with pkgs; [
      kitty
      hyprcursor
    ];

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
