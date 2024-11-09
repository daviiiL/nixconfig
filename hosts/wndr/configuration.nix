{pkgs, ...}: {
  imports = [
    ../../components/nixos/secureboot.nix
    ../../components/nixos/system-templates/workstation.nix
    ../../components/nixos/system-templates/hyprland.nix
    ../../components/nixos/colorscheme/catppuccin.nix
  ];

  networking = {
    hostName = "wndr";
    networkmanager.enable = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.rudeus = {
      name = "rudeus";
      home = "/home/rudeus/";
      isNormalUser = true;
      description = "David Liu";
      extraGroups = ["networkmanager" "wheel" "video"];
      packages = with pkgs; [
        foot
        pass
        helix
      ];
      shell = pkgs.zsh;
    };
  };
}
