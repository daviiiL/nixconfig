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
    username = "davidliu";
    homeDirectory = "/Users/davidliu";
  };

  programs = {
    home-manager.enable = true;
  };

  home.stateVersion = import ../state-version.nix;
}
