{
  config,
  lib,
  ...
}: let
  cfg = config.localSystem.hardware.bluetooth;
in {
  options.localSystem.hardware.bluetooth = {
    enable = lib.mkEnableOption "Bluetooth (BlueZ + Blueman)";
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };

    services.blueman.enable = true;
  };
}
