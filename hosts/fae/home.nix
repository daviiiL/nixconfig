{user, ...}: {
  imports = [
    ../../home
    ../../home/presets/linux-laptop.nix
  ];

  localHome = {
    wm.gnome.enable = true;
    theme.gnome-custom.enable = true;
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
