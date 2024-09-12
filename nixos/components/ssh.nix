{
  services.fail2ban.enable = true;
  services.openssh = {
    enable = true;
    ports = [
      22
    ];
    PasswordAuthentication = true;
    AllowUsers = ["rudues"];
    X11Forwarding = false;
    PermitRootLogin = "no";
  };
}
