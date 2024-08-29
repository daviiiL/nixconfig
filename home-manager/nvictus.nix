# { inputs
# , outputs
# , lib
# , config
# , pkgs
# , ...
# }:
{
  imports = [
    ./home.nix
    ./programs
    ./shells
    ./mservices
  ];
  programs.zsh.shellAliases = {
    la = "eza -la";
    ls = "eza";
    laa = "eza -l --git -T --hyperlink --header --git-ignore .";
    code = "code --enable-features=UseOzonePlatform --ozone-platform=wayland";
    nixrebuild = "cd ~/nixconfig && sudo nixos-rebuild switch --flake .#nvictus";
    switchhome = "cd ~/nixconfig && home-manager switch --flake .#rudeus@nvictus";
  };
  wayland.windowManager.hyprland.extraConfig = "
	monitor=,preferred,auto,2
	"; 
}
