{
  config,
  lib,
  ...
}: let
  cfg = config.localSystem.hardware.power;
in {
  options.localSystem.hardware.power = {
    enable = lib.mkEnableOption "power management (upower + power-profiles-daemon)";
  };

  config = lib.mkIf cfg.enable {
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
  };
}
