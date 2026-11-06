{
  imports = [
    ./core.nix
    ./docker.nix
    ./fonts.nix
    ./hyprland.nix
    ./microvm.nix
    ./niri.nix
    # theme.nix is opt-in. catppuccin wants services.displayManager.generic,
    # which 25.11 doesn't have
  ];
}
