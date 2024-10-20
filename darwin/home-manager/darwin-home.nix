{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./shell
    # ./terminals
  ];

  home.packages = with pkgs; [
    eza
  ];

  # write dotfiles to the home directory
  home.file = {
    ".config/sketchybar" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixconfig/modules/sketchybar";
      recursive = true;
    };
    ".config/alacritty" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixconfig/modules/alacritty";
      recursive = true;
    };
  };

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
