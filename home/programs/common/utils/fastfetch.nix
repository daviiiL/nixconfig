{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos_small";
        padding = {
          left = 1;
          right = 1;
        };
      };

      modules = [
        "title"
        "separator"
        "host"
        "os"
        "kernel"
        "initsystem"
        "uptime"
        "loadavg"
        "processes"
        "packages"
        "shell"
        "editor"
        "display"
        "lm"
        "de"
        "wm"
        "theme"
        "terminal"
        {
          "type" = "cpu";
          "showPeCoreCount" = true;
          "temp" = true;
        }
        "cpuusage"
        {
          "type" = "gpu";
          "driverSpecific" = true;
          "temp" = true;
        }
        "memory"
        "physicalmemory"
        "swap"
        "disk"
        "btrfs"
        "zpool"
        {
          "type" = "battery";
          "temp" = true;
        }
        "poweradapter"
        {
          "type" = "localip";
        }
        "datetime"
        {
          "type" = "weather";
          "timeout" = 1000;
        }
        "break"
        "colors"
      ];
    };
  };
}
