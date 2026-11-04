{
  lib,
  outputs,
  host,
  ...
}: let
  isDarwin = host.kind == "darwin";
in {
  imports = [
    ./programs
    ./platform
    ./wm
    ./theme
  ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [outputs.overlays.default];
  };

  home = {
    username = host.user;
    homeDirectory =
      if isDarwin
      then "/Users/${host.user}"
      else "/home/${host.user}";
    inherit (host) stateVersion;
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = lib.mkIf (!isDarwin) "sd-switch";
}
