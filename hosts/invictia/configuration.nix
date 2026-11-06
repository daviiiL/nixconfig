{host, ...}: {
  localSystem = {
    cachix.enable = true;
    core = {
      boot.enable = true;
      boot.secureBoot = true;
      locale.enable = true;
      network.enable = true;
      settings.enable = true;
      shell.enable = true;
      user.enable = true;
      user.description = "David Liu";
      user.hashedPassword = "$6$AU1bIgovbLPieXVT$eZ9JcP1/jqGtSyoSWbpEkgF0BYe.DkDHYv6CqQAUmmwJByadVc6s1g9No9zmHg7yn.cG2PDM/PFQ/UzlgcjB60";
    };
    disko = {
      enable = true;
      device = "/dev/disk/by-id/nvme-eui.ace42e002aef7f9f2ee4ac0000000001";
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
