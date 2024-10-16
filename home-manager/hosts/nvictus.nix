{inputs, ...}: {
  imports = [
    ./home.nix
    ./programs
    ./shells
    ./mservices
  ];

  # ...
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;

      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "dash-to-panel@jderose9.github.com"
      ];
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "catppuccin-mocha-sapphire-compact";
    };
  };

  home.packages = with inputs.nixpkgs.legacyPackages.x86_64-linux; [
    gnomeExtensions.user-themes
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.vitals
    gnomeExtensions.dash-to-panel
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.space-bar
  ];

  programs.zsh.shellAliases = {
    la = "eza -la";
    ls = "eza";
    laa = "eza -l --git -T --hyperlink --header --git-ignore .";
    code = "code --enable-features=UseOzonePlatform --ozone-platform=wayland";
    nixrebuild = "cd ~/nixconfig && sudo nixos-rebuild switch --flake .#nvictus";
    switchhome = "cd ~/nixconfig && home-manager switch --flake .#rudeus@nvictus";
  };
  wayland.windowManager.hyprland.extraConfig = "
	monitor=,preferred,auto,2
	";
}
