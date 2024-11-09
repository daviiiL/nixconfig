{pkgs, ...}: {
  # Audio
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
    };
  };

  hardware.pulseaudio.enable = false;

  # Bluetooth
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };

  # USB
  services = {
    devmon.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
  };

  # Printing
  services.printing.enable = true;

  # # OpenGL
  # hardware.opengl = {
  #   enable = true;
  #   extraPackages = with pkgs; [
  #     libva
  #     vaapiVdpau
  #     libvdpau-va-gl
  #   ];
  #   extraPackages32 = with pkgs; [
  #     vaapiVdpau
  #     libvdpau-va-gl
  #   ];
  # };
}
