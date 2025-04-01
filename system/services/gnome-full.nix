{
  imports = [
    ./gnome-services.nix
    ./printing.nix
  ];
  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
}
