{
  config,
  lib,
  ...
}: {
  options.localSystem.hardware.laptop = {
    enable = lib.mkEnableOption "laptop preset (libinput + audio + power + bluetooth)";
  };

  config = lib.mkIf config.localSystem.hardware.laptop.enable {
    localSystem.hardware.audio.enable = lib.mkDefault true;
    localSystem.hardware.power.enable = lib.mkDefault true;
    localSystem.hardware.bluetooth.enable = lib.mkDefault true;

    services.libinput = {
      enable = true;
      mouse.accelProfile = "flat";
      touchpad = {
        tapping = true;
        naturalScrolling = true;
      };
    };
  };
}
