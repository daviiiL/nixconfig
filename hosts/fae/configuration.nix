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
      intel-arc = {
        enable = true;
        compute.enable = true;
        enableGuc = false;
      };
    };
    services = {
      gnome.full.enable = true;
      printing.enable = true;
    };
  };

  boot.initrd.luks = {
    reusePassphrases = true;
    devices."luks-80f98bd2-cded-407a-a0fc-9bfbce219dfd".device = "/dev/disk/by-uuid/80f98bd2-cded-407a-a0fc-9bfbce219dfd";
  };

  networking.hostName = host.name;

  system.stateVersion = import ../state-version.nix;
}
