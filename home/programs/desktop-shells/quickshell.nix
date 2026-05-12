{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.localHome.programs.desktop-shells.quickshell;
  sys = pkgs.stdenv.hostPlatform.system;
  # When niriPlugin.enable, use the qml-niri-provided build of quickshell which
  # bundles the Niri QML plugin. Otherwise use upstream quickshell unchanged.
  quickshellPkg =
    if cfg.niriPlugin.enable
    then inputs.qml-niri.packages.${sys}.quickshell
    else inputs.quickshell.packages.${sys}.default;
in {
  options.localHome.programs.desktop-shells.quickshell = {
    enable =
      lib.mkEnableOption "quickshell QML runtime (Qt6, ghostty, material-symbols, xdg-desktop-portal)";
    niriPlugin.enable =
      lib.mkEnableOption "qml-niri plugin (swaps quickshell for the qml-niri-bundled build)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      quickshellPkg
      ghostty
      kdePackages.qtbase
      kdePackages.qt5compat
      kdePackages.qtdeclarative
      kdePackages.qtsvg
      material-symbols
      xdg-desktop-portal
    ];
  };
}
