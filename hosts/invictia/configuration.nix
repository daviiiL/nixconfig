{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../system/cachix
    ../../system/core
    ../../system/hardware/laptop.nix
    ../../system/hardware/nvidia.nix
    ../../system/packages
    ../../system/packages/docker.nix
    ../../system/security
    ../../system/services/gnome-full.nix
  ];

  networking.hostName = "invictia";
  users.users.chronos = {
    isNormalUser = true;
    description = "David Liu";
    extraGroups = ["networkmanager" "wheel" "video" "input"];
  };

  system.stateVersion = import ../state-version.nix;
}
