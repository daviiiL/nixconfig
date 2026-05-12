{user, ...}: {
  imports = [
    ../../home
    ../../home/presets/linux-laptop.nix
  ];

  localHome = {
    wm.hyprland.enable = true;
    wm.gnome.enable = true;
    theme.matugen.enable = true;
    programs.development.android.enable = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      android_sdk.accept_license = true;
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
