{
  services = {
    #battery info
    upower.enable = true;
    #lvfs
    fwupd.enable = true;

    # fingerprint
    # fprintd.enable = true;
  };

  hardware = {
    brillo.enable = true;
  };
}
