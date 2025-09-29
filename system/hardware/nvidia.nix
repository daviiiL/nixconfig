{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in {
  # boot.kernelPackages =
  #   lib.mkForce pkgs.linuxPackages_6_16;
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      # pinning a working version for now
      #
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "580.65.06";
        sha256_64bit = "sha256-BLEIZ69YXnZc+/3POe1fS9ESN1vrqwFy6qGHxqpQJP8=";
        openSha256 = "sha256-BKe6LQ1ZSrHUOSoV6UCksUE0+TIa0WcCHZv4lagfIgA=";
        settingsSha256 = "sha256-9PWmj9qG/Ms8Ol5vLQD3Dlhuw4iaFtVHNC0hSyMCU24=";
        usePersistenced = false;
      };
      # testing if the beta nvidia package build against the 6.16 kernel
      # package = config.boot.kernelPackages.nvidiaPackages.beta;
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = true;
      };
      open = true;
      nvidiaSettings = true;
      prime = {
        offload.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };

    videoDrivers = ["nvidia"];
  };
}
