{
  imports = [
    ../home.nix
    ../modules/programs
    ../modules/shells
    ../modules/services
    ../modules/wm/sway
    ../modules/wm/hypr
    ../modules/framework
    ../modules/laptop
  ];

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
    nixrebuild = "cd ~/nixconfig && sudo nixos-rebuild switch --flake .#wndrportal";
    switchhome = "cd ~/nixconfig && home-manager switch --flake .#rudeus@wndrportal";
  };

  wayland.windowManager.hyprland.extraConfig = "
    monitor = ,preferred, auto, 2
    ";
}
