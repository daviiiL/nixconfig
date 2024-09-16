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
    plugins = with inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}; [
      hyprlandPlugins.hyprbars
      hyprlandPlugins.hyprexpo
    ];
  };
}
