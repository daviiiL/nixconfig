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

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
