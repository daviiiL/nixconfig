{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "suppressevent maximize, class:.*"
      "noborder, onworkspace:w[t1]"
      "stayfocused, title:^()$,class:^(steam)$"
      "minsize 1 1, title:^()$,class:^(steam)$"
    ];
    layerrule = [
      "noanim, anyrun"
    ];
    # windowrule = [
    # "noblur,^(?!(dev\.zed\.Zed))$"
    # ];
  };
}
