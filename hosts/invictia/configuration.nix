{inputs, ...}: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.dell-xps-15-9530-nvidia
    ../../system/hardware/nvidia.nix
    ../../system/presets/x86-linux-laptop.nix
    ../../system/presets/vm-docker.nix
    ../../system/services/gnome-full.nix
    ../../system/services/flatpak.nix
    ../../system/services/input-methods.nix
  ];

  networking.hostName = "invictia";
  users.users.chronos = {
    isNormalUser = true;
    description = "David Liu";
    extraGroups = ["networkmanager" "wheel" "video" "input"];
  };

  system.stateVersion = import ../state-version.nix;
}
