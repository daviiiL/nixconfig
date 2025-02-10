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
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_6_12;
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
