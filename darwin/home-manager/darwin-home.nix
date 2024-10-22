{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./shell
    ./packages.nix
  ];

  # write dotfiles to the home directory
  home.file = {
    ".config/alacritty" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixconfig/darwin/dotfiles/alacritty";
      recursive = true;
    };
  };

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
