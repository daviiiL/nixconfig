{
  programs = {
    btop = {
      enable = true;
    };
    eza = {
      enable = true;
      enableZshIntegration = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
      icons = true;
    };
  };
  fastfetch = {
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
