{
  imports = [
    ./base
    ./matugen.nix
    ./gnome-custom
  ];

  # ./catppuccin.nix is opt-in (import it from the host): its module breaks on
  # a stale `programs.antigravity` option when programs.vscode is enabled.
}
