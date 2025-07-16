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
    packages = [
      # inputs.nixvim.packages.${pkgs.system}.default
    ];
  };

  programs = {
    home-manager.enable = true;
  };

  home.stateVersion = import ../state-version.nix;
}
