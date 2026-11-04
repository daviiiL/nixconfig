# Package pins and overrides for NixOS and home-manager. Modules use plain
# pkgs.<name>; each entry says when to drop it.
{inputs}: final: prev: let
  unstable = import inputs.nixpkgs-unstable {
    inherit (final.stdenv.hostPlatform) system;
    config.allowUnfree = true;
  };
in {
  # Unstable versions of tools that 25.11 lags on. Drop each once stable
  # (26.05) catches up.
  inherit (unstable) claude-code devenv vscode leetgo gh;
  inherit (unstable) btop fzf zathura fuzzel anyrun hyprlock;

  # Not packaged in 25.11 (renamed swww).
  inherit (unstable) awww;

  # Only these extensions, so the rest of gnomeExtensions stays on stable.
  gnomeExtensions =
    prev.gnomeExtensions
    // {
      inherit (unstable.gnomeExtensions) appindicator dash-to-dock search-light;
    };
}
