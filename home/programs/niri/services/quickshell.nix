{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.quickshell.packages.${pkgs.system}.default
    ghostty
    kdePackages.qtbase
    kdePackages.qt5compat
    kdePackages.qtdeclarative
    kdePackages.qtsvg
    material-symbols
    xdg-desktop-portal
  ];
}
