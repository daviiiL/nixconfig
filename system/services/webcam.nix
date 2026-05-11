{
  config,
  lib,
  ...
}: {
  options.localSystem.services.webcam = {
    enable = lib.mkEnableOption "webcam dynamic controls (uvcvideo)";
  };

  config = lib.mkIf config.localSystem.services.webcam.enable {
    services.uvcvideo.dynctrl.enable = true;
  };
}
