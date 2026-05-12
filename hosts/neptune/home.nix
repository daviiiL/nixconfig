{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ../../home
    ../../home/presets/macbook.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "davidas";
    homeDirectory = "/Users/davidas/";
  };

  programs.home-manager.enable = true;
  home.stateVersion = import ../state-version.nix;
}
