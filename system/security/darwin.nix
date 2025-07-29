{...}: {
  services = {
    openssh.enable = false;
  };

  security = {
    #NOTE: need to rebuild to reapply after every os update
    pam.services.sudo_local.touchIdAuth =
      true;
  };
}
