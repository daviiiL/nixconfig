{
  # dunno if needed but here's an antivirus daemon
  services = {
    clamav = {
      daemon.enable = true;
      updater.enable = true;
    };
  };
}
