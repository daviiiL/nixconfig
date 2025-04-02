{...}: {
  imports = [
    ../../home/programs/hyprland
    ../../home/services
    ../../home/theme
    ../../home/theme/font.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

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
