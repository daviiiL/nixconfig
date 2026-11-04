{host, ...}: {
  localSystem = {
    cachix.enable = true;
    core = {
      boot.enable = true;
      locale.enable = true;
      network.enable = true;
      settings.enable = true;
      shell.enable = true;
      user.enable = true;
      user.extraGroups = ["wireshark" "plugdev" "libvirt" "seat" "users" "kvm"];
    };
    packages = {
      core.enable = true;
      fonts.enable = true;
      microvm.enable = true;
      niri.enable = true;
    };
    security.linux = {
      enable = true;
      doas = true;
      apparmor = true;
      firewall = true;
    };
    hardware = {
      laptop.enable = true;
      audio.enable = true;
      power.enable = true;
      bluetooth.enable = true;
    };
    services = {
      gnome.full.enable = true;
      printing.enable = true;
    };
  };

  networking.hostName = host.name;

  system.stateVersion = host.stateVersion;
}
