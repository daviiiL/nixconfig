{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../system/presets/x86-linux-desktop.nix
    ../../system/services/gnome-full.nix
  ];

  networking.hostName = "wndr";

  users.users.chronos = {
    isNormalUser = true;
    description = "chronos";
    extraGroups = ["networkmanager" "wheel" "wireshark" "plugdev" "libvirt" "seat" "users" "video" "kvm" "input"];
  };

  system.stateVersion = import ../state-version.nix;
}
