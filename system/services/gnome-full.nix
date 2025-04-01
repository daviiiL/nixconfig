{pkgs, ...}: {
  imports = [
    ./gnome-services.nix
    ./printing.nix
  ];
  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome = {
      enable = true;
    };
  };
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
    gnome-contacts
    gnome-logs
    gnome-software
  ];
}
