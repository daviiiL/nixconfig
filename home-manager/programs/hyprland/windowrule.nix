{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "suppressevent maximize, class:.*"
      "noborder, onworkspace:w[t1]"
    ];
    layerrule = [
      "noanim, anyrun"
    ];
    # windowrule = [
    # "noblur,^(?!(dev\.zed\.Zed))$"
    # ];
  };
}
