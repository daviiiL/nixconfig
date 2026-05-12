{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.localHome.programs.desktop-shells.ags;
  agsPkgs = inputs.ags.packages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  options.localHome.programs.desktop-shells.ags = {
    enable =
      lib.mkEnableOption "ags (Aylur's GTK Shell) runtime with WM-agnostic astal libs";
    hyprlandBindings.enable =
      lib.mkEnableOption "astal hyprland bindings (only useful on Hyprland)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      brightnessctl
      sassc
      playerctl
      libnotify
    ];

    programs.ags = {
      enable = true;
      configDir = null;
      extraPackages =
        (with agsPkgs; [
          astal3
          io
          battery
          bluetooth
          mpris
          network
          notifd
          wireplumber
          tray
        ])
        ++ lib.optionals cfg.hyprlandBindings.enable [agsPkgs.hyprland];
    };
  };
}
