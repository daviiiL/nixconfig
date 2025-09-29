{
  imports = [
    ../../home/programs/common
    ../../home/programs/gnome
    ../../home/theme/gnome-custom
  ];

  home = {
    username = "chronos";
    homeDirectory = "/home/chronos";
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
  home.stateVersion = import ../state-version.nix;
}
