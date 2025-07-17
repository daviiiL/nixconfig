{user, ...}: {
  imports = [
    ../../home/programs/common
    ../../home/programs/gnome
    ../../home/programs/hyprland
    ../../home/theme
    ../../home/theme/font.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = builtins.toString user;
    homeDirectory = "/home/${builtins.toString user}";
  };

  programs = {
    home-manager.enable = true;
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = import ../state-version.nix;
}
