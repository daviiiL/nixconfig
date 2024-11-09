{config, ...}: {
  imports = [
    ./gtk.nix
    ./packages.nix
  ];
  home.file = {
    ".config/anyrun" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixconfig/submodules/anyrun";
      recursive = true;
    };
    ".config/wofi" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixconfig/submodules/wofi";
      recursive = true;
    };
  };
}
