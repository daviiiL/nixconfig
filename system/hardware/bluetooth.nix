{
  config,
  lib,
  ...
}: {
  options.localSystem.hardware.bluetooth = {
    enable = lib.mkEnableOption "Bluetooth (BlueZ + Blueman)";
  };

  config = lib.mkIf config.localSystem.hardware.bluetooth.enable {
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
