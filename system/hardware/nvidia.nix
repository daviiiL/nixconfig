{
  inputs,
  pkgs,
  lib,
  ...
}: let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in {
  boot.kernelPackages =  pkgs.linuxPackagesFor (
    pkgs.linuxKernel.kernels.linux_6_12.override {
      argsOverride = rec {
        src = pkgs.fetchurl {
          url = "mirror://kernel/linux/kernel/v${lib.versions.major version}.x/linux-${version}.tar.xz";
	  hash = "sha256-6Y1C0X73Bjs/LW12kr8kiZ4uAhz4MtGbVTCOyOjgjv8=";
        };
        version = "6.12.12";
        modDirVersion = "6.12.12";
      };
    }
  );
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      package = unstable.linuxPackages.nvidiaPackages.beta;
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = true;
      };
      # will switch to open source driver once its more stable
      open = false;
      nvidiaSettings = true;
      prime = {
        offload.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
  services.xserver.videoDrivers = ["nvidia"];
}
