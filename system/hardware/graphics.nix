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

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
    videoDrivers = ["amdgpu"];
  };
}
