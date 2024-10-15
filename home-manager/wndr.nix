# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
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
    ./services
    ./shells
    ./programs
    ./colorschemes
  ];
  programs.zsh.shellAliases = {
    la = "eza -la";
    ls = "eza";
    laa = "eza -l --git -T --hyperlink --header --git-ignore .";
    code = "code --enable-features=UseOzonePlatform --ozone-platform=wayland";
    fetchsubmodule = "git submodule update --init --recursive";
    updatesubmodule = "git submodule update --recursive --remote";
    nixrebuild = "cd ~/nixconfig && sudo nixos-rebuild switch --flake .#wndr";
    switchhome = "cd ~/nixconfig && home-manager switch --flake .#rudeus@wndr";
  };
  wayland.windowManager.hyprland.extraConfig = "
      monitor=HDMI-A-1,3840x2160@120,0x0,1.5
      monitor=DP-1, 3840x2160@144, 2560x297,2
    
      workspace = 1, monitor:HDMI-A-1, default:true, rounding:true
      workspace = 2, monitor:HDMI-A-1, rounding: true 
      workspace = 3, monitor:HDMI-A-1, rounding: true 
      workspace = 4, monitor:HDMI-A-1, rounding: true 
      workspace = 5, monitor:HDMI-A-1, rounding: true
      workspace = 6, monitor:DP-1
      workspace = 7, monitor:DP-1
      workspace = 8, monitor:DP-1
      workspace = 9, monitor:DP-1
      workspace = 10, monitor:DP-1
    ";
}
