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
}
