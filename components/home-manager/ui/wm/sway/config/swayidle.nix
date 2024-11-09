{pkgs, ...}: {
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 60;
        command = "hyprlock";
      }
      {
        timeout = 90;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = "hyprlock";
      }
      {
        event = "lock";
        command = "lock";
      }
    ];
  };
}
