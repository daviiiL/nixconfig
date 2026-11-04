{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localSystem.services.gnome.services;
in {
  options.localSystem.services.gnome.services = {
    enable = lib.mkEnableOption "GNOME-adjacent services (keyring, gvfs, gcr) — usable outside the full GNOME desktop";
  };

  config = lib.mkIf cfg.enable {
    services = {
      dbus.packages = with pkgs; [
        gcr
        gnome-settings-daemon
      ];

      gnome.gnome-keyring.enable = true;
      gvfs.enable = true;
    };
  };
}
