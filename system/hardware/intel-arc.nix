{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localSystem.hardware.intelArc;
in {
  options.localSystem.hardware.intelArc = {
    enable = lib.mkEnableOption "Intel Arc / Xe GPU (VAAPI/QSV via iHD)";

    compute.enable = lib.mkEnableOption "Intel compute runtime (OpenCL NEO + Level Zero)";

    enableGuc = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Pass `i915.enable_guc=3` so the i915 driver loads GuC/HuC firmware.
        Often required for stable FFmpeg/VAAPI/QSV on Arc.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs;
          [
            intel-media-driver
            vpl-gpu-rt
          ]
          ++ lib.optionals cfg.compute.enable [
            intel-compute-runtime
          ];
      };

      enableRedistributableFirmware = true;
    };

    services.xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      videoDrivers = ["modesetting"];
    };

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
    };

    boot.kernelParams = lib.optionals cfg.enableGuc ["i915.enable_guc=3"];
  };
}
