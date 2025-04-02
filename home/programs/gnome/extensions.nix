{pkgs, ...}: {
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          # dash to dock
          pkgs.gnomeExtensions.dash-to-dock.extensionUuid

          # blur my shell
          pkgs.gnomeExtensions.blur-my-shell.extensionUuid
        ];
      };

      "org/gnome/shell/extensions/blur-my-shell" = {
        brightness = 0.75;
        noise-amount = 0;
      };
    };
  };
}
