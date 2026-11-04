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
      user.description = "David Liu";
    };
    packages = {
      core.enable = true;
      fonts.enable = true;
      microvm.enable = true;
      docker.enable = true;
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
  };

  networking.hostName = host.name;

  system.stateVersion = host.stateVersion;
}
