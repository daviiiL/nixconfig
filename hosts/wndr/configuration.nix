{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../system/cachix
    ../../system/core
    ../../system/hardware
    ../../system/packages
    ../../system/security
    ../../system/services
  ];

  networking.hostName = "wndr";

  users.users.chronos = {
    isNormalUser = true;
    description = "chronos";
    extraGroups = ["networkmanager" "wheel" "wireshark" "plugdev" "libvirt" "seat" "users" "video" "kvm" "input"];
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}
