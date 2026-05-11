{
  config,
  lib,
  pkgs,
  ...
}: {
  options.localSystem.core.boot = {
    enable = lib.mkEnableOption "systemd-boot + latest kernel";
  };

  config = lib.mkIf config.localSystem.core.boot.enable {
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
      kernelPackages = pkgs.linuxPackages_latest;
    };
  };
}
