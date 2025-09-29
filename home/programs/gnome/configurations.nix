{
  dconf.settings = {
    # fractional scaling
    "org/gnome/mutter" = {
      experimental-features = ["scale-monitor-framebuffer"];
    };

    # system keyboard shortcuts
    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Super>q"];
    };
  };
}
