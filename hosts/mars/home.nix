{
  imports = [
    ../../home
    ../../home/presets/minimal-cli.nix
  ];

  home = {
    username = "davidl";
    homeDirectory = "/home/davidl";
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";
  home.stateVersion = import ../state-version.nix;
}
