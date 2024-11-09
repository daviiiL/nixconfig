{pkgs, ...}: {
  home.packages = with pkgs; [
    hypridle
    hyprpicker
    hyprshot
    anyrun
    grim
    slurp
    wl-clipboard
    swww
    waypaper
    nwg-look
    qt6ct
    qt5ct
    wdisplays
    waybar
    autotiling-rs
    swayidle
    wofi
    cliphist
  ];
}
