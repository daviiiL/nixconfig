{
  wayland.windowManager.hyprland.settings = {
    bind = [
      # basics
      "SUPER, Return, exec, foot"
      "SUPER, Q, killactive, "
      # app launcher
      "SUPER, Space, exec, anyrun || pkill anyrun"
      # workspaces
      "SUPER, 1, workspace, 1"
      "SUPER, 2, workspace, 2"
      "SUPER, 3, workspace, 3"
      "SUPER, 4, workspace, 4"
      "SUPER, 5, workspace, 5"
      "SUPER, 6, workspace, 6"
      "SUPER, 7, workspace, 7"
      "SUPER, 8, workspace, 8"
      "SUPER, 9, workspace, 9"
      "SUPER, 0, workspace, 1"
      "SUPER+Shift, 1, movetoworkspace, 1"
      "SUPER+Shift, 2, movetoworkspace, 2"
      "SUPER+Shift, 3, movetoworkspace, 3"
      "SUPER+Shift, 4, movetoworkspace, 4"
      "SUPER+Shift, 5, movetoworkspace, 5"
      "SUPER+Shift, 6, movetoworkspace, 6"
      "SUPER+Shift, 7, movetoworkspace, 7"
      "SUPER+Shift, 8, movetoworkspace, 8"
      "SUPER+Shift, 9, movetoworkspace, 9"
      "SUPER+Shift, 0, movetoworkspace, 10"

      "SUPER+Shift, right, resizeactive, 20 0"
      "SUPER+Shift, left, resizeactive, -20 0"
      "SUPER+Shift, up,   resizeactive, 0 -20"
      "SUPER+Shift, down,  resizeactive, 0 20"

      "SUPER, f, fullscreen"
      "SUPER+Shift, f, togglefloating"

      "SUPER, left, movefocus, l"
      "SUPER, right, movefocus, r"
      "SUPER, up, movefocus, u"
      "SUPER, down, movefocus, d"

      # misc keys
      "XF86AudioPlay, exec, playerctl play-pause"
      "XF86AudioPrev, exec, playerctl previous"
      "XF86AudioNext, exec, playerctl next"

      # wallpaper selector
      "SUPER+Shift, t, exec, waypaper"

      # lock screen
      "SUPER, l, exec, hyprlock"

      # color picker
      "SUPER+Shift, c, exec, hyprpicker -n -a"

      # screenshot
      "SUPER, PRINT, exec, hyprshot -m window"
      "SUPER+Shift, PRINT, exec, hyprshot -m output"
      ", PRINT, exec, hyprshot -m region"

      # clipboard history
      "SUPER, V, exec, cliphist list | wofi --show dmenu | cliphist decode | wl-copy"
    ];

    bindl = [
      "Super+Shift,M, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0% "
      ", switch:Lid Switch, exec, hyprlock"
    ];

    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];

    bindle = [
      ", XF86MonBrightnessUp, exec, brillo -q -A 5"
      ", XF86MonBrightnessDown, exec, brillo -q -U 5"
      ",XF86AudioMute, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%"
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ];
  };
}
