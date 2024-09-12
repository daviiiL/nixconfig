{
  inputs,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    # package = inputs.hyprland.packages.${pkgs.system}.default;
    #
    # plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
    #   hyprbars
    #   hyprexpo
    # ];
    plugins = with pkgs; [
      hyprlandPlugins.hyprbars
      hyprlandPlugins.hyprexpo
    ];
  };
}
