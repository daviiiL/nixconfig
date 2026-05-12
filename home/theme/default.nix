{
  imports = [
    ./base
    ./matugen
    ./gnome-custom
  ];

  # theme/catppuccin is intentionally NOT auto-imported.
  # Its homeModule eagerly themes home-manager programs (e.g. vscode), and
  # currently breaks on a stale `programs.antigravity` option when loaded
  # alongside `programs.vscode.enable = true`. Hosts that want catppuccin
  # must import it explicitly:  imports = [ ../../home/theme/catppuccin ];
}
