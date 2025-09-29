let
  default-terminal = "ghostty";
in {
  imports = [
    ./ghostty.nix
  ];

  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = default-terminal;
      name = "Launch Terminal";
    };
  };
}
