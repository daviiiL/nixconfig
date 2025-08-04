{...}: {
  imports = [
    ../../home/programs/common
    ../../home/programs/hyprland
    ../../home/programs/gnome
    ../../home/theme/matugen
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

  home.stateVersion = import ../state-version.nix;
}
