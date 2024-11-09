{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./hyprland
    ./hypridle.nix
    ./hyprlock.nix
    ./ags
  ];

  home.file = {
    ".config/ags" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixconfig/home-manager/modules/ui/ags";
      recursive = true;
    };
  };
}
