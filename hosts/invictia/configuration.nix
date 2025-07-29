{inputs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../system/presets/x86-linux-laptop.nix
    ../../system/hardware/nvidia.nix
    ../../system/presets/vm-docker.nix
    ../../system/services/gnome-full.nix
  ];

  networking.hostName = "invictia";
  users.users.chronos = {
    isNormalUser = true;
    description = "David Liu";
    extraGroups = ["networkmanager" "wheel" "video" "input"];
  };

  system.stateVersion = import ../state-version.nix;
}
