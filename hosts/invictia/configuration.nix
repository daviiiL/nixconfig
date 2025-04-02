{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../system/cachix
    ../../system/core
    ../../system/hardware/laptop.nix
    ../../system/hardware/nvidia.nix
    ../../system/packages
    ../../system/security
    ../../system/services/gnome-full.nix
  ];

  boot.initrd.luks.devices."luks-0764ce18-d651-43e8-875e-ba3fec52d432".device = "/dev/disk/by-uuid/0764ce18-d651-43e8-875e-ba3fec52d432";
  networking.hostName = "invictia";
  users.users.chronos = {
    isNormalUser = true;
    description = "David Liu";
    extraGroups = ["networkmanager" "wheel" "video" "input"];
  };

  system.stateVersion = "24.11";
}
