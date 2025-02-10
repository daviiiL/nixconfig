{pkgs, ...}: {
  # Bootloader.
  boot = {
    loader = {
      #systemd-boot
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    #using the latest kernel instead of 6.6
    kernelPackages = pkgs.linuxPackages_latest;
  };
}
