{
  xdg.configFile."hypr/hyprlock.conf".text = ''
    # BACKGROUND
    background {
        monitor =
        color = rgba(17, 17, 27, 1)
        blur_passes = 3
        contrast = 0.8916
        brightness = 0.8172
        vibrancy = 0.1696
        vibrancy_darkness = 0.0
    }

    # GENERAL
    general {
        no_fade_in = false
        ignore_empty_input = true
        grace = 0
        disable_loading_bar = true
        fractional_scaling = 1
        enable_fingerprint = true
        hide_cursor = true
    }

    # INPUT FIELD
    input-field {
        monitor =
        size = 300, 70
        outline_thickness = 1
        dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.2 # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true
        fade_on_empty = true
        hide_input = false
        font_family = Inter 28pt,Inter 28pt
        position = 0, 100
        halign = center
        valign = bottom
        inner_color = rgba(255,255,255,0.5)
        outer_color = rgba(14,14,24,1)
        rounding = 10
        font_size = 20
        placeholder_text = <span>locked</span>
    }

    # clock
    label {
        monitor =
        text = cmd[update:1000] echo "$(date +"%-H:%M")"
        font_size = 170
        position = 0, -300
        font_family = Inter 28pt,Inter 28pt SemiBold
        halign = center
        valign = top
        color = rgba(255, 255, 255, 0.5)
    }

    # date
    label {
        monitor =
        text = cmd[update:1000] echo "$(date +"%A, %d %B")"
        font_size = 34
        position = 0, -280
        font_family = Inter 28pt,Inter 28pt
        color = rgba(255,255,255,0.5)
        halign = center
        valign = top
    }
  '';
}
