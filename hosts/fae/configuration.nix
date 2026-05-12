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

  boot.initrd.luks = {
    reusePassphrases = true;
    devices."luks-80f98bd2-cded-407a-a0fc-9bfbce219dfd".device = "/dev/disk/by-uuid/80f98bd2-cded-407a-a0fc-9bfbce219dfd";
  };

  networking.hostName = "fae";

  users.users.chronos = {
    isNormalUser = true;
    description = "chronos";
    extraGroups = ["networkmanager" "wheel" "video" "input"];
  };

  system.stateVersion = import ../state-version.nix;
}
