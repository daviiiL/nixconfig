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

  # opencode 2.2.5 has a darwin node_modules hash mismatch; drop once fixed
  # upstream (along with the nixpkgs-opencode input).
  inherit (inputs.nixpkgs-opencode.legacyPackages.${final.stdenv.hostPlatform.system}) opencode;

  # nixpkgs lags the Dart stable channel; pin the latest release (macOS arm64 only).
  # Bump: check https://storage.googleapis.com/dart-archive/channels/stable/release/latest/VERSION
  # then `nix hash convert --hash-algo sha256 --to sri <sha256 from the .zip.sha256sum file>`.
  dart =
    if final.stdenv.hostPlatform.system == "aarch64-darwin"
    then
      prev.dart.overrideAttrs (finalAttrs: _prev: {
        version = "3.13.3";
        src = final.fetchurl {
          url = "https://storage.googleapis.com/dart-archive/channels/stable/release/${finalAttrs.version}/sdk/dartsdk-macos-arm64-release.zip";
          hash = "sha256-xwO8uyXKDMXfkQn7gnLVJ4asFHgkN72eNloBmFJzwcw=";
        };
      })
    else prev.dart;
}
