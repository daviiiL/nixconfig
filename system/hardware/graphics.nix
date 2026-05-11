{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localSystem.hardware.graphics;
in {
  options.localSystem.hardware.graphics = {
    enable = lib.mkEnableOption "hardware graphics acceleration (Vulkan/VAAPI/Mesa)";

    amd = {
      enable = lib.mkEnableOption "AMD GPU (amdgpu) driver and xserver";
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
        extraPackages = with pkgs; [
          mesa
          vulkan-loader
          vulkan-validation-layers
          libva
          vaapiVdpau
          libvdpau-va-gl
          rocmPackages.clr.icd
        ];
      };
    })

    (lib.mkIf cfg.amd.enable {
      hardware.amdgpu.initrd.enable = true;
      boot.kernelParams = cfg.amd.extraKernelParams;

      services.xserver = {
        enable = true;
        xkb = {
          layout = "us";
          variant = "";
        };
        videoDrivers = ["amdgpu"];
      };
    })
  ];
}
