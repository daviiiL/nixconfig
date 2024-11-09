{config, ...}: {
  imports = [
    ./swayidle.nix
    ./waybar.nix
    ./hyprlock.nix
  ];

  home.file = {
    ".config/sway" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixconfig/submodules/sway";
      recursive = true;
    };
  };
}
