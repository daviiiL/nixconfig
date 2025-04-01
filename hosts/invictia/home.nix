{
  # inputs,
  # outputs,
  # config,
  # pkgs,
  ...
}: {
  imports = [
    ../../home/programs
    ../../home/programs/gnome
    ../../home/services
  ];

  home = {
    username = "chronos";
    homeDirectory = "/home/chronos";
  };

  programs = {
    home-manager.enable = true;
  };

  # reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
