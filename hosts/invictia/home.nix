{
  imports = [
    ../../home/programs/gnome
    ../../home/programs/common
    ../../home/programs/niri
    ../../home/theme
  ];

  home = {
    username = "chronos";
    homeDirectory = "/home/chronos";
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
  home.stateVersion = import ../state-version.nix;
}
