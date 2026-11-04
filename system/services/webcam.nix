{
  config,
  lib,
  ...
}: let
  cfg = config.localSystem.services.webcam;
in {
  options.localSystem.services.webcam = {
    enable = lib.mkEnableOption "webcam dynamic controls (uvcvideo)";
  };

  config = lib.mkIf cfg.enable {
    services.uvcvideo.dynctrl.enable = true;
  };
}
