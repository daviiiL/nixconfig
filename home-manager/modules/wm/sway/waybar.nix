{
  programs.waybar = {
    enable = true;
    settings = [
      {
        "layer" = "bottom";
        "position" = "top";
        "height" = 20;
        "modules-left" = [
          "sway/workspaces"
          "sway/mode"
          "tray"
        ];
        "modules-center" = [
          "sway/window"
        ];
        "modules-right" = [
          "battery"
          "backlight"
          "pulseaudio"
          "network"
          "clock"
        ];
        "sway/mode" = {
          "format" = " {}";
        };
        "sway/workspaces" = {
          "format" = "";
          "on-click" = "activate";
          "format-icons" = {
            "default" = " ";
            "focused" = " ";
          };
          "sort-by-number" = true;
          "disable-scroll" = true;
          "persistent-workspaces" = {
            "1" = ["eDP-1"];
            "2" = ["eDP-1"];
            "3" = ["eDP-1"];
            "4" = ["eDP-1"];
            "5" = ["eDP-1"];
          };
        };
        "sway/window" = {
          "format" = "{title}";
          "max-length" = 20;
          "tooltip" = false;
        };
        "clock" = {
          "format" = "{:%a %d %b %H:%M}";
          "tooltip" = false;
          "on-click" = "gnome-clocks";
        };
        "battery" = {
          "format" = "{icon}  {capacity}%";
          "format-alt" = "{time} remaining";
          "format-icons" = [
            "󰁺"
            "󰁼"
            "󰁾"
            "󰂀"
            "󰁹"
          ];
          "format-charging" = "󰂄  {capacity}%";
          "interval" = 30;
          "states" = {
            "full" = 100;
            "good" = 90;
            "warning" = 35;
            "critical" = 15;
          };
          "tooltip" = true;
        };
        "network" = {
          "format" = "{icon}";
          "format-alt" = "{ipaddr}/{cidr} {icon}";
          "format-alt-click" = "click-right";
          "format-icons" = {
            "wifi" = [
              "󰤟"
              "󰤢"
              "󰤥"
              "󰤨"
            ];
            "ethernet" = [""];
            "disconnected" = ["󰤭"];
          };
          "on-click" = "XDG_CURRENT_DESKTOP=gnome gnome-control-center";
          "tooltip" = false;
        };
        "pulseaudio" = {
          "format" = " {icon} {volume}% ";
          "format-muted" = "SOUND OFF";
          "format-icons" = {
            "phone" = [
              "  "
              "  "
              "   "
            ];
            "default" = [
              "  "
              "  "
              "  "
            ];
          };
          "scroll-step" = 10;
          "on-click" = "pavucontrol";
          "tooltip" = false;
        };
        "backlight" = {
          "format" = "{icon}  {percent}%";
          "format-icons" = [
            "󰃞 "
            "󰃟 "
            "󰃠 "
          ];
        };
        "tray" = {
          "icon-size" = 18;
        };
      }
    ];

    style = "
      @define-color background #11111b;
      @define-color foreground #cdd6f4;
      @define-color color2 #89b4fa;
      @define-color color8 #313244;
      @define-color sapphire #74c7ec;
      @define-color color9 #202024;
      
      * {
        font-family: 'Noto Sans';
        text-shadow: none;
        padding: 0;
      }
      
      window#waybar {
        color: @foreground;
        background: @background;
      }
      #workspaces {
        border-radius: 1rem;
        margin: 5px;
        margin-left: 1rem;
      }

      #workspaces button {
        background: @color8;
        border-radius: 0.5rem;
        margin: 0 5px;
        padding: 0rem;
        transition: background 0.3s ease-in-out;
      }

      #workspaces button.empty {
        background: @color9;
        transition: background 0.3s ease-in-out;
      }
      
      #workspaces button.focused {
        background: @color2;
      }
      
      #workspaces button:hover {
        background: #45475a;
        transition: background 0.2s ease-in-out;
      }
      
      #battery {
        margin: 5px;
        padding-top: 0;
        padding-bottom: 0;
        border-radius: 4px;
        padding-left: 10px;
        padding-right: 10px;
        transition: all 0.2s linear;
      }
      
      #battery:hover {
        margin: 1px;
        padding-right: 12px;
        padding-left: 12px;
        transition: all 0.2s linear;
      }
      
      @keyframes blink {
        from {
          background: #abe9b3;
        }
        to {
          background: #698967;
        }
      }
      
      #battery.charging {
        animation-name: blink;
        animation-duration: 1s;
        animation-timing-function: ease-in-out;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
      
      #battery.full {
        background: darkseagreen;
        color: @background;
      }
      
      #battery.good {
        background: #abe9b3;
        color: black;
      }
      
      #battery.warning {
        background: orange;
        color: black;
      }
      #battery.critical {
        background: #cf4b55;
        color: white;
      }
      
      #mode {
        background: @color2;
        color: black;
        font-size: 12pt;
        font-weight: bold;
        padding: 0;
        padding-left: 5px;
        padding-right: 5px;
        border: 3px solid @background;
        border-radius: 10px;
      }
      
      #backlight {
        margin: 5px;
        padding-left: 6px;
        padding-right: 6px;
        border-radius: 4px;
        transition: all 0.2s linear;
      }
      
      #mode,
      #cpu,
      #memory,
      #network,
      #pulseaudio {
        margin: 2px 6px 2px 10px;
        min-width: 25px;
      }
      
      #network,
      #pulseaudio {
        margin: 2px;
        padding-right: 5px;
        transition: all 0.1s linear;
      }
      
      #clock {
        margin: 2px 16px 2px 16px;
        padding: 0 5px 0 5px;
        min-width: 140px;
        font-weight: bold;
        transition: all 0.1s linear;
      }
      
      #ai {
        margin: 0 1rem 0 1rem;
      }
      
      tooltip {
        background-color: @background;
        border: none;
      }
      
      tooltip label {
        background-color: @background;
        color: @foreground;
        margin: 10px;
      }
    ";
  };
}
