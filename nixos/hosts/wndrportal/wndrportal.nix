{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../components/greetd-sway.nix
    ../../components/sway.nix
    ../../components/tlp.nix
    ../../components/tty.nix
  ];
  environment.systemPackages = with pkgs; [
    fbterm
  ];

  # boot.initrd.kernelModules = ["fbcon"];
  # Networking
  networking = {
    # system host name
    hostName = "wndrportal";
    networkmanager.enable = true;
  };

  services = {
    # see tlp: power management
    power-profiles-daemon.enable = false;
    #battery info
    upower.enable = true;
    #lvfs
    fwupd.enable = true;
    # kmscon = {
    #   enable = true;
    #   hwRender = true;
    # };
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
      extraGroups = ["networkmanager" "wheel" "video" "wireshark"];
      packages = with pkgs; [
        alacritty
        pass
        foot
      ];
      shell = pkgs.zsh;
    };
  };
}
