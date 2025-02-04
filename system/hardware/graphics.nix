{pkgs, ...}: {
  # graphics drivers / HW accel
  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        mesa
        mesa.drivers
        vulkan-loader
        vulkan-validation-layers
        libva
        vaapiVdpau
        libvdpau-va-gl
        rocmPackages.clr.icd
      ];
      enable32Bit = true;
    };
    amdgpu.initrd.enable = true;
  };

  boot = {
    kernelParams = ["amdgpu.sg_display=0"];
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.xserver.videoDrivers = ["amdgpu"];
}
