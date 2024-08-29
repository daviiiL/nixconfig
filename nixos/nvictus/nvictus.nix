# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config
, pkgs
, inputs
, ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Networking
  networking = {
    # system host name 
    hostName = "wndrportal";
    networkmanager.enable = true;
  };

  services = {
    # enable power management
    power-profiles-daemon.enable = true;
    #battery info
    upower.enable = true;
  };

  hardware = {
    brillo.enable = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.rudeus = {
      name = "rudeus";
      home = "/home/rudeus/";
      isNormalUser = true;
      description = "David Liu";
      extraGroups = [ "networkmanager" "wheel" "video" "wireshark" ];
      packages = with pkgs; [
        alacritty
        pass
      ];
      shell = pkgs.zsh;
    };
  };
}
