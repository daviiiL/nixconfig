{user, ...}: {
  imports = [
    ../../home
    ../../home/presets/linux-desktop.nix
  ];

  localHome = {
    wm.hyprland.enable = true;
    wm.gnome.enable = true;
    theme.matugen.enable = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = builtins.toString user;
    homeDirectory = "/home/${builtins.toString user}";
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";
  home.stateVersion = import ../state-version.nix;
}
