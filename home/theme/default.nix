{
  imports = [
    ./base
    ./matugen.nix
    ./gnome-custom
  ];

  # catppuccin.nix gets imported per host. its module trips over a stale
  # programs.antigravity option whenever vscode is on
}
