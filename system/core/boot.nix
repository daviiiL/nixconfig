{pkgs, ...}: {
  # Bootloader.
  boot = {
    loader = {
      #systemd-boot
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;
  };
}
