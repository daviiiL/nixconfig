{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # kitty
    # hyprcursor
    inputs.quickshell.packages.${pkgs.system}.default
    ghostty

    kdePackages.qtbase
    kdePackages.qt5compat
    kdePackages.qtdeclarative
    kdePackages.qtsvg
    material-symbols
    xdg-desktop-portal
  ];

  qt.enable = true;

  programs.niri.enable = true;
  programs.niri.package = pkgs.niri;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
