{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../system/presets/x86-linux-laptop.nix
    ../../system/hardware/framework.nix
  ];

  localSystem = {
    hardware.framework.enable = true;
    services.gnome.full.enable = true;
    packages.niri.enable = true;
  };

  networking.hostName = "portal";

  users.users.chronos = {
    isNormalUser = true;
    description = "chronos";
    extraGroups = ["networkmanager" "wheel" "wireshark" "plugdev" "libvirt" "seat" "users" "video" "kvm" "input"];
  };

  system.stateVersion = import ../state-version.nix;
}
