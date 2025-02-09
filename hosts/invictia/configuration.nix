{...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../system/cachix
    ../../system/core
    ../../system/hardware/laptop.nix
    ../../system/hardware/nvidia.nix
    ../../system/packages
    ../../system/security
    ../../system/services
  ];

  boot.initrd.luks.devices."luks-f373743c-cda1-4347-81f8-1a7eb5f176e8".device = "/dev/disk/by-uuid/f373743c-cda1-4347-81f8-1a7eb5f176e8";
  networking.hostName = "invictia"; # Define your hostname.
  users.users.chronos = {
    isNormalUser = true;
    description = "David Liu";
    extraGroups = ["networkmanager" "wheel"];
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}
