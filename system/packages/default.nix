{
  imports = [
    ./core.nix
    ./fonts.nix
    ./hyprland.nix
    ./microvm.nix
    ./niri.nix
    # ./theme.nix — opt-in: hosts that want catppuccin theming import this directly.
    #   (Auto-importing breaks 25.11 evaluation: gtk submodule references
    #   services.displayManager.generic which only exists in nixpkgs-unstable.)
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };
}
