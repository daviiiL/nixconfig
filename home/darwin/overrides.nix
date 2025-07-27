{
  pkgs,
  inputs,
  ...
}: let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in {
  programs = {
    ghostty = {
      package = unstable.ghostty-bin;
      settings = {
        keybind = ["global:cmd+shift+T=toggle_quick_terminal"];
      };
    };
  };
}
