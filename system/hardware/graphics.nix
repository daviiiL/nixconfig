# Shared GPU plumbing; amd/intel-arc/nvidia enable it and add driver bits.
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localSystem.hardware.graphics;
in {
  options.localSystem.hardware.graphics = {
    enable = lib.mkEnableOption "hardware graphics acceleration + X server (us keyboard)";

    amd = {
      enable = lib.mkEnableOption "AMD GPU (amdgpu) driver with Mesa/Vulkan/VAAPI/ROCm userspace";
      extraKernelParams = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = ["amdgpu.sg_display=0"];
        description = "Extra kernel parameters applied when AMD GPU is enabled.";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      services.xserver = {
        enable = true;
        xkb = {
          layout = "us";
          variant = "";
        };
      };
    })

    (lib.mkIf cfg.amd.enable {
      localSystem.hardware.graphics.enable = lib.mkDefault true;

      hardware.graphics.extraPackages = with pkgs; [
        mesa
        vulkan-loader
        vulkan-validation-layers
        libva
        libva-vdpau-driver
        libvdpau-va-gl
        rocmPackages.clr.icd
      ];

      hardware.amdgpu.initrd.enable = true;
      boot.kernelParams = cfg.amd.extraKernelParams;
      services.xserver.videoDrivers = ["amdgpu"];
    })
  ];
}
