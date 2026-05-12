{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../system/presets/x86-linux-laptop.nix
  ];

  localSystem = {
    services.gnome.full.enable = true;
    packages.niri.enable = true;
    hardware.intelArc = {
      enable = true;
      compute.enable = true;
      enableGuc = false;
    };
  };

  networking.hostName = "fae";

  users.users.chronos = {
    isNormalUser = true;
    description = "chronos";
    extraGroups = ["networkmanager" "wheel" "video" "input"];
  };

  system.stateVersion = import ../state-version.nix;
}
