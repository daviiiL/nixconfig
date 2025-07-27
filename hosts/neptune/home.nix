{
  inputs,
  # outputs,
  # config,
  pkgs,
  ...
}: {
  imports = [../../home/darwin];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "davidas";
    homeDirectory = "/Users/davidas/";
  };

  programs = {
    home-manager.enable = true;
  };
  home.stateVersion = import ../state-version.nix;
}
