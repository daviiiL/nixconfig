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
  boot.kernelPackages = pkgs.linuxPackagesFor (
    lib.mkForce pkgs.linuxKernel.kernels.linux_6_12.override {
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
