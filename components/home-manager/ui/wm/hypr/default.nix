{inputs, ...}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ../common-modules
    ./config
    ./ags
  ];
}
