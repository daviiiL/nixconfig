{
  config,
  lib,
  ...
}: {
  options.localSystem.hardware.audio = {
    enable = lib.mkEnableOption "PipeWire audio stack";
  };

  config = lib.mkIf config.localSystem.hardware.audio.enable {
    services.pulseaudio.enable = false;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
