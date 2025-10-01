{user, ...}:{
  imports = [
    ../../home/programs/common
    ../../home/programs/gnome
    ../../home/theme/gnome-custom
  ];

  home = {
    username = builtins.toString user;
    homeDirectory = "/home/${builtins.toString user}";
  };

  programs = {

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
  home.stateVersion = import ../state-version.nix;
}
