{
  services.fail2ban.enable = true;
  services.openssh = {
    enable = false;
    ports = [
      22
    ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = ["rudeus"];
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };
}
