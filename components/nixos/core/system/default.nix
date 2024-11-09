{pkgs, ...}: {
  imports = [
    ./fonts.nix
    ./hardware.nix
    ./locale.nix
    ./packages.nix
    ./systemd.nix
    ./console.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
  };

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    systembus-notify.enable = true;
  };
}
