{
  pkgs,
  inputs,
  ...
}: let
  unstable-pkgs = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in {
  imports = [
    ../../components/home-manager/general.nix
    ../../components/home-manager/programs
    ../../components/home-manager/ui/wm/hypr
    ../../components/home-manager/ui/colorscheme/catppuccin.nix
  ];

  home = {
    username = "rudeus";
    homeDirectory = "/home/rudeus";
    packages = with unstable-pkgs; [
      python312Packages.materialyoucolor
    ];
  };

  programs.zsh.shellAliases = {
    # qol
    la = "eza -la --group-directories-first";
    ls = "eza --group-directories-first";
    laa = "eza -l --git -T --hyperlink --header --git-ignore .";
    tree = "lsd --tree --group-directories-first";
    treed = "lsd --tree --group-directories-first --depth";

    # editors
    zed = "zeditor";
    code = "code --enable-features=UseOzonePlatform --ozone-platform=wayland";

    # devbox
    cdpy = "cd $HOME/Codespace/python/ && devbox shell";
    cdjs = "cd $HOME/Codespace/javascript/ && devbox shell";
    cddsa = "cd $HOME/Codespace/python/dsa-template && devbox shell";

    # git shortcuts
    fetchsubmodule = "git submodule update --init --recursive";
    updatesubmodule = "git submodule update --recursive --remote";

    # nix shortcuts
    nixrebuild = "cd ~/nixconfig && sudo nixos-rebuild switch --flake .#wndr";
    switchhome = "cd ~/nixconfig && home-manager switch --flake .#rudeus@wndr";
  };

  wayland.windowManager.hyprland.extraConfig = "
      monitor=HDMI-A-1,3840x2160@120,0x0,1.5,bitdepth,10
      monitor=DP-1, 3840x2160@144, 2560x297,2,bitdepth,10
    
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

      decoration {
        blur {
          enabled true
          passes 4
          size 5
          vibrancy 0.169600
        }
      }
    ";
}
