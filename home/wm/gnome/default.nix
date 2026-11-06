{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localHome.wm.gnome;
in {
  imports = [
    ./extensions.nix
  ];

  options.localHome.wm.gnome.enable =
    lib.mkEnableOption "GNOME desktop userland (extensions, dconf, tweaks)";

  config = lib.mkIf cfg.enable {
    localHome.wm.gnome.extensions.enable = lib.mkDefault true;

    home.packages = with pkgs; [
      gnome-control-center
      # tweaks & inspectors
      gnome-tweaks
      gnome-browser-connector
      dconf-editor
    ];

    dconf.settings = {
      # fractional scaling
      "org/gnome/mutter" = {
        experimental-features = ["scale-monitor-framebuffer"];
      };

      "org/gnome/desktop/wm/keybindings" = {
        close = ["<Super>q"];
      };

      # super+return -> ghostty
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
