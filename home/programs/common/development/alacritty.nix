{
  programs.alacritty = {
    enable = true;

    settings = {
      font = {
        size = 14;
        normal = {
          family = "SauceCodePro Nerd Font Mono";
          style = "Regular";
        };
        bold = {
          family = "SauceCodePro Nerd Font Mono";
          style = "Bold";
        };
        italic = {
          family = "SauceCodePro Nerd Font Mono";
          style = "Italic";
        };
        bold_italic = {
          family = "SauceCodePro Nerd Font Mono";
          style = "Bold Italic";
        };
      };

      window = {
        padding = {
          x = 10;
          y = 10;
        };
      };
    };
  };
}
