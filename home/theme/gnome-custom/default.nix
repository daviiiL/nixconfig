{pkgs, ...}: {
  imports = [
    ../common/font.nix
    ./program-themes
  ];

  # gtk = {
  #   enable = true;
  #   iconTheme = {
  #     name = "WhiteSur-dark";
  #     package = pkgs.whitesur-icon-theme;
  #   };
  #   theme = {
  #     name = "WhiteSur-Dark-solid";
  #     package = pkgs.whitesur-gtk-theme;
  #   };
  # };
  #
  # home.pointerCursor = {
  #   gtk.enable = true;
  #   x11.enable = true;
  #   package = pkgs.whitesur-cursors;
  #   name = "WhiteSur-cursors";
  #   size = 24;
  # };
}
