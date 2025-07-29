{
  inputs,
  # outputs,
  # config,
  pkgs,
  ...
}: {
  imports = [
    ../../home/darwin
    ../../home/programs/common/fun
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

  programs = {
    home-manager.enable = true;
  };

  home.stateVersion = import ../state-version.nix;
}
