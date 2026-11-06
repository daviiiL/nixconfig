{
  config,
  lib,
  ...
}: let
  cfg = config.localSystem.darwin.defaults;
in {
  options.localSystem.darwin.defaults = {
    enable = lib.mkEnableOption "Darwin hardware tweaks (trackpad, startup chime)";
  };

  config = lib.mkIf cfg.enable {
    system = {
      startup.chime = true;
      defaults.trackpad.TrackpadThreeFingerDrag = true;
    };
  };
}
