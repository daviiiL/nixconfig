{
  config,
  lib,
  pkgs,
  ...
}: {
  options.localSystem.services.gnome.full = {
    enable = lib.mkEnableOption "Full GNOME desktop (GDM + GNOME Shell)";
  };

  config = lib.mkIf config.localSystem.services.gnome.full.enable {
    localSystem.services.gnome.services.enable = lib.mkDefault true;
    localSystem.services.printing.enable = lib.mkDefault true;

    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-user-docs
      gnome-contacts
      gnome-logs
      gnome-software
      epiphany
    ];
  };
}
