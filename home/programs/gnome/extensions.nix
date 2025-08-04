{
  pkgs,
  lib,
  ...
}: {
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          # dash to dock
          pkgs.gnomeExtensions.dash-to-dock.extensionUuid

          # blur my shell
          # pkgs.gnomeExtensions.blur-my-shell.extensionUuid

          # launcher
          pkgs.gnomeExtensions.search-light.extensionUuid
        ];
      };
      #
      # "org/gnome/shell/extensions/blur-my-shell" = {
      #   brightness = 0.75;
      #   noise-amount = 0;
      # };
      #
      "org/gnome/shell/extensions/search-light" = {
        background-color = lib.hm.gvariant.mkTuple [0.0 0.0 0.0 1.0];
        border-radious = 2.5;
      };

      "org/gnome/shell/extensions/dash-to-dock" = {
        show-apps-at-top = true;
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
