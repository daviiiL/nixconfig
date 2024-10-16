{
  programs.steam.enable = true;

  # have a local dns cache
  services.dnsmasq.enable = true;
  networking.resolvconf.enable = true;
}
