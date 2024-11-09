{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../components/nixos/secureboot.nix
    ../../components/nixos/system-templates/laptop.nix
    ../../components/nixos/system-templates/hyprland.nix
    ../../components/nixos/colorscheme/catppuccin.nix
  ];

  networking = {
    hostName = "wndrportal";
    networkmanager.enable = true;
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
