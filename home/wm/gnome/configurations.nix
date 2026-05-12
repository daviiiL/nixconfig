{
  config,
  lib,
  ...
}: let
  cfg = config.localHome.wm.gnome;
in {
  config = lib.mkIf cfg.enable {
    dconf.settings = {
      # fractional scaling
      "org/gnome/mutter" = {
        experimental-features = ["scale-monitor-framebuffer"];
      };

      # system keyboard shortcuts
      "org/gnome/desktop/wm/keybindings" = {
        close = ["<Super>q"];
      };

      # Super+Return launches ghostty (previously in terminal-emulators/default.nix)
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>Return";
        command = "ghostty";
        name = "Launch Terminal";
      };
    };
  };
}
