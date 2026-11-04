{
  outputs,
  host,
  ...
}: {
  imports = [
    ./programs
    ./wm
    ./theme
  ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [outputs.overlays.default];
  };

  home = {
    username = host.user;
    homeDirectory = "/home/${host.user}";
    stateVersion = import ../hosts/state-version.nix;
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";
}
