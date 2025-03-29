{
  pkgs,
  lib,
  ...
}: {
  # Bootloader.
  boot = {
    loader = {
      #systemd-boot
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # pinned version for nvidia
    kernelPackages = pkgs.linuxPackagesFor (
      pkgs.linuxKernel.kernels.linux_6_12.override {
        argsOverride = rec {
          src = pkgs.fetchurl {
            url = "https://cdn.kernel.org/pub/linux/kernel/v${lib.versions.major version}.x/linux-${version}.tar.xz";
            sha256 = "1zwfw3lci3ihandx2cpq3h12x7l94jzr4xkd5lzkn1ppgv8l52g9";
          };
          version = "6.12.12";
          modDirVersion = "6.12.12";
        };
      }
    );

    #using the latest kernel instead of 6.6
    # kernelPackages = pkgs.linuxPackages_latest;
  };
}
