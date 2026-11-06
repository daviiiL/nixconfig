{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localSystem.hardware.intel-arc;
in {
  options.localSystem.hardware.intel-arc = {
    enable = lib.mkEnableOption "Intel Arc";

    compute.enable = lib.mkEnableOption "Intel compute runtime";

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
    localSystem.hardware.graphics.enable = lib.mkDefault true;

    hardware = {
      graphics.extraPackages = with pkgs;
        [
          intel-media-driver
          vpl-gpu-rt
        ]
        ++ lib.optionals cfg.compute.enable [
          intel-compute-runtime
        ];

      enableRedistributableFirmware = true;
    };

    services.xserver.videoDrivers = ["modesetting"];

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
    };

    boot.kernelParams = lib.optionals cfg.enableGuc ["i915.enable_guc=3"];
  };
}
