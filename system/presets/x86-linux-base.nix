{lib, ...}: {
  imports = [
    ../cachix
    ../core
    ../packages
    ../security
    ../services
  ];

  localSystem = {
    core = {
      boot.enable = lib.mkDefault true;
      locale.enable = lib.mkDefault true;
      network.enable = lib.mkDefault true;
      settings.enable = lib.mkDefault true;
      shell.enable = lib.mkDefault true;
    };

    packages = {
      core.enable = lib.mkDefault true;
      fonts.enable = lib.mkDefault true;
    };

    security.linux = {
      enable = lib.mkDefault true;
      doas = lib.mkDefault true;
      apparmor = lib.mkDefault true;
      firewall = lib.mkDefault true;
    };
  };
}
