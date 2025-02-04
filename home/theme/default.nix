{pkgs, ...}: {
  home.packages = with pkgs; [
    adw-gtk3
    matugen
  ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  gtk = {
    enable = true;

    font = {
      name = "Noto Sans";
      package = pkgs.inter-nerdfont;
      size = 11;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
