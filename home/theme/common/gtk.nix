{pkgs, ...}: {
  gtk = {
    theme.package = pkgs.adw-gtk3;
    theme.name = "adw-gtk3-dark";
  };
}
