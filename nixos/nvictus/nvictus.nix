# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config
, pkgs
, inputs
, ...
}:
let
  pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # ../modules/nvidia.nix
  ];

  # Networking
  networking = {
    # system host name 
    hostName = "nvictus";
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
    # opengl = {
    #   enable = true;
    #   extraPackages = with pkgs; [
    #     libva
    #     vaapiVdpau
    #     libvdpau-va-gl
    #   ];
    #   extraPackages32 = with pkgs; [
    #     vaapiVdpau
    #     libvdpau-va-gl
    #   ];
    # };
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

  # nvidia settings
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
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
      nvidiaBusId = "PCI:01:00:0";
    };
  };
}