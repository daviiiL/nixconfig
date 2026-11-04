{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.localHome.wm.hyprland;
  agsPkgs = inputs.ags.packages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  config = lib.mkIf cfg.enable {
    # sassc builds the styles; the rest are what the shell config shells out to
    home.packages = with pkgs; [
      sassc
      brightnessctl
      playerctl
      libnotify
    ];

    programs.ags = {
      enable = true;
      configDir = null;
      extraPackages = with agsPkgs; [
        astal3
        io
        battery
        bluetooth
        mpris
        network
        notifd
        wireplumber
        tray
        hyprland
      ];
    };
  };
}
