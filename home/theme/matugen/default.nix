{pkgs, ...}: {
  imports = [
    ../common
  ];

  home.packages = with pkgs; [
    adw-gtk3
    matugen
  ];
}
