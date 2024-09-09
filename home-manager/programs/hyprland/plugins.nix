{ inputs, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    # enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.default;
    #
    # plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
    #   hyprbars
    #   hyprexpo
    # ];
  };
}
