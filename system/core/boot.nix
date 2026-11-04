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
  };

  config = lib.mkIf cfg.enable {
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
      kernelPackages = pkgs.linuxPackages_latest;
    };
  };
}
