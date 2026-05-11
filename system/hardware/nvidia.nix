{
  config,
  lib,
  ...
}: let
  cfg = config.localSystem.hardware.nvidia;
in {
  options.localSystem.hardware.nvidia = {
    enable = lib.mkEnableOption "NVIDIA proprietary driver";

    driverPackage = lib.mkOption {
      type = lib.types.nullOr lib.types.package;
      default = null;
      description = ''
        Override NVIDIA driver package (e.g. a pinned `mkDriver { ... }`).
        Null = use the nixpkgs default for the active kernel.
      '';
    };

    prime = {
      enable = lib.mkEnableOption "PRIME offload (hybrid Intel + NVIDIA)";

      intelBusId = lib.mkOption {
        type = lib.types.str;
        example = "PCI:0:2:0";
        default = "";
        description = "PCI bus ID of the Intel GPU.";
      };

      nvidiaBusId = lib.mkOption {
        type = lib.types.str;
        example = "PCI:1:0:0";
        default = "";
        description = "PCI bus ID of the NVIDIA GPU.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };

      nvidia = lib.mkMerge [
        {
          modesetting.enable = true;
          powerManagement = {
            enable = true;
            finegrained = cfg.prime.enable;
          };
          open = true;
          nvidiaSettings = true;
        }
        (lib.mkIf (cfg.driverPackage != null) {
          package = cfg.driverPackage;
        })
        (lib.mkIf cfg.prime.enable {
          prime = {
            offload.enable = true;
            intelBusId = cfg.prime.intelBusId;
            nvidiaBusId = cfg.prime.nvidiaBusId;
          };
        })
      ];
    };

    services.xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      videoDrivers = ["nvidia"];
    };
  };
}
