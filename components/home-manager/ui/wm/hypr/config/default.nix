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
    ./hypridle.nix
    ./hyprlock.nix
  ];

  home.packages = [
    inputs.hyprlock.packages.${pkgs.system}.default
  ];

  wayland.windowManager.hyprland = {
    enable = true;
  };
}