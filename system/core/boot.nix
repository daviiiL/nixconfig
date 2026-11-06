# systemd-boot, or lanzaboote with secureBoot. keys get generated on first boot
# and enrolled once the firmware is in setup mode
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localSystem.core.boot;
in {
  options.localSystem.core.boot = {
    enable = lib.mkEnableOption "systemd-boot + latest kernel";

    secureBoot = lib.mkEnableOption "Secure Boot via lanzaboote (replaces systemd-boot)";

    firmwareBuiltinKeys = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Keep the OEM certificates when enrolling; needed for vendor firmware updates (e.g. Framework).";
    };
  };

  config = lib.mkIf cfg.enable {
    boot = {
      loader = {
        systemd-boot.enable = !cfg.secureBoot;
        efi.canTouchEfiVariables = true;
      };
      kernelPackages = pkgs.linuxPackages_latest;

      lanzaboote = lib.mkIf cfg.secureBoot {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
        autoGenerateKeys.enable = true;
        autoEnrollKeys = {
          enable = true;
          includeFirmwareBuiltinKeys = cfg.firmwareBuiltinKeys;
        };
      };
    };

    environment.systemPackages = lib.optional cfg.secureBoot pkgs.sbctl;
  };
}
