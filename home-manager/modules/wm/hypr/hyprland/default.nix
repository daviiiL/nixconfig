{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    # ./plugins.nix
    ./autostart.nix
    ./env.nix
    ./general.nix
    ./windowrule.nix
    ./keybind.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
  };
}
