{
  pkgs,
  lib,
  inputs,
  ...
}: let
  unstable-pkgs = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in {
  home.packages = with unstable-pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.blur-my-shell
    gnomeExtensions.search-light
    gnomeExtensions.kimpanel
    gnomeExtensions.rounded-window-corners-reborn
    gnomeExtensions.removable-drive-menu
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.user-themes
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with unstable-pkgs.gnomeExtensions; [
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
}
