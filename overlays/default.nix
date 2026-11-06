# unstable/pinned stuff so modules can just say pkgs.<name>
{inputs}: final: prev: let
  unstable = import inputs.nixpkgs-unstable {
    inherit (final.stdenv.hostPlatform) system;
    config.allowUnfree = true;
  };
in {
  inherit (unstable) claude-code devenv vscode leetgo gh;
  inherit (unstable) btop fzf zathura fuzzel anyrun hyprlock;
  inherit (unstable) awww;

  gnomeExtensions =
    prev.gnomeExtensions
    // {
      inherit (unstable.gnomeExtensions) appindicator dash-to-dock search-light;
    };

  inherit (inputs.nixpkgs-opencode.legacyPackages.${final.stdenv.hostPlatform.system}) opencode;

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
