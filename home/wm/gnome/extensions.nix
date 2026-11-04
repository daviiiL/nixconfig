{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localHome.wm.gnome.extensions;
in {
  options.localHome.wm.gnome.extensions.enable =
    lib.mkEnableOption "GNOME Shell extensions and their settings";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [
      appindicator
      dash-to-dock
      blur-my-shell
      search-light
      kimpanel
      rounded-window-corners-reborn
      removable-drive-menu
      tray-icons-reloaded
      user-themes
    ];

    dconf = {
      enable = true;
      settings = {
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = with pkgs.gnomeExtensions; [
            dash-to-dock.extensionUuid
            search-light.extensionUuid
            kimpanel.extensionUuid
            rounded-window-corners-reborn.extensionUuid
            removable-drive-menu.extensionUuid
            tray-icons-reloaded.extensionUuid
            user-themes.extensionUuid
          ];
        };

        "org/gnome/shell/extensions/search-light" = {
          background-color = lib.hm.gvariant.mkTuple [0.0 0.0 0.0 1.0];
          border-radious = 2.5;
        };

        "org/gnome/shell/extensions/dash-to-dock" = {
          show-apps-at-top = false;
          show-running = true;
          show-favorites = true;
          isolate-workspaces = true;
          dock-fixed = false;
          intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
          background-color = "rgb(0,0,0)";
        };
      };
    };
  };
}
