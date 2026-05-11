{
  config,
  lib,
  ...
}: {
  options.localSystem.hardware.power = {
    enable = lib.mkEnableOption "power management (upower + power-profiles-daemon)";
  };

  config = lib.mkIf config.localSystem.hardware.power.enable {
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
  };
}
