{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../components/gdm.nix
    ../components/gnome.nix
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
      extraGroups = ["networkmanager" "wheel" "video" "wireshark"];
      packages = with pkgs; [
        alacritty
        pass
      ];
      shell = pkgs.zsh;
    };
  };

  # nvidia settings
  services.xserver.videoDrivers = ["nvidia"];

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
