{
  imports = [
    ../../home/programs/gnome
    ../../home/theme
  ];

  home = {
    username = "chronos";
    homeDirectory = "/home/chronos";
  };

  programs = {
    home-manager.enable = true;
  };

  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
