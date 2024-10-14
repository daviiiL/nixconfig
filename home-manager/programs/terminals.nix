{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "FiraCode Nerd Font:size=11";
        pad = "10x10 center";
      };
    };
  };
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraMono Nerd";
    };
    settings = {
      window_padding_width = 10;
      placement_strategy = "center";
      confirm_os_window_close = 0;
    };
  };
}
