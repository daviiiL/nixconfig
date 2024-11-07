{lib, ...}: {
  imports = [
    ./hyprland
    ./hypridle.nix
    ./hyprlock.nix
  ];
  services.mako.enable = lib.mkForce false;
}
