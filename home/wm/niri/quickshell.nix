{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.localHome.wm.niri;
  # qml-niri's build ships the niri qml plugin
  quickshellPkg = inputs.qml-niri.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
in {
  config = lib.mkIf cfg.enable {
    localHome.programs.terminals.ghostty.enable = lib.mkDefault true;

    home.packages = with pkgs; [
      quickshellPkg
      kdePackages.qtbase
      kdePackages.qt5compat
      kdePackages.qtdeclarative
      kdePackages.qtsvg
      material-symbols
      xdg-desktop-portal
    ];
  };
}
