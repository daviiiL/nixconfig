{
  imports = [
    ./packages.nix
    ./programs
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  programs = {
    home-manager.enable = true;
  };

  # reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
