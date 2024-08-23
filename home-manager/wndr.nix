# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs
, outputs
, lib
, config
, pkgs
, ...
}:
{
  imports = [
    ./home.nix
    ./services
    ./shells
    ./programs
  ];
  programs.zsh.shellAliases = {
    la = "eza -la";
    ls = "eza";
    laa = "eza -l --git -T --hyperlink --header --git-ignore .";
    code = "code --enable-features=UseOzonePlatform --ozone-platform=wayland";
    nixrebuild = "cd ~/nixconfig && sudo nixos-rebuild switch --flake .#wndr";
    switchhome = "cd ~/nixconfig && home-manager switch --flake .#rudeus@wndr";
  };
  wayland.windowManager.hyprland.extraConfig = "
      monitor=HDMI-A-1,3840x2160@120,0x0,1.5,bitdepth,12
      monitor=DP-2,3840x2160@144,2560x297,2,bitdepth,10
    ";
}
