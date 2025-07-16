# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../system/cachix
    ../../system/core
    ../../system/hardware/framework.nix
    ../../system/packages
    ../../system/security
    ../../system/services/gnome-full.nix
  ];

  networking.hostName = "portal";

  users.users.chronos = {
    isNormalUser = true;
    description = "chronos";
    extraGroups = ["networkmanager" "wheel" "wireshark" "plugdev" "libvirt" "seat" "users" "video" "kvm" "input"];
  };

  system.stateVersion = import ../state-version.nix;
}
