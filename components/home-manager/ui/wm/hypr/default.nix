{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ../common-modules
    ./config
    ./ags
  ];

  home.file = {
    ".config/ags" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixconfig/components/home-manager/ui/wm/hypr/ags";
      recursive = true;
    };
  };
}
