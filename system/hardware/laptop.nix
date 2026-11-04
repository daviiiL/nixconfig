{
  config,
  lib,
  ...
}: let
  cfg = config.localSystem.hardware.laptop;
in {
  options.localSystem.hardware.laptop = {
    enable = lib.mkEnableOption "laptop input (libinput touchpad + flat mouse accel)";
  };

  config = lib.mkIf cfg.enable {
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
