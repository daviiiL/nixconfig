{
  imports = [
    ./core.nix
    ./docker.nix
    ./fonts.nix
    ./hyprland.nix
    ./microvm.nix
    ./niri.nix
    # ./theme.nix is opt-in: catppuccin's module needs
    # services.displayManager.generic (unstable only) and breaks 25.11 eval.
  ];
}
