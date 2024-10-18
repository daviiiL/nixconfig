{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos_small";
        padding = {
          right = 1;
        };
      };
      display = {
        size = {
          binaryPrefix = "si";
        };
        color = "blue";
        separator = "  ";
      };
      modules = [
        "OS"
        "Kernel"
        "CPU"
        "Display"
        "Shell"
        "WM"
        "Colors"
      ];
    };
  };
}
