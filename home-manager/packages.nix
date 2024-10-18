{
  inputs,
  pkgs,
  ...
}: let
  unstable-pkgs = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in {
  home.packages = with pkgs; [
    # essentials
    git
    neofetch
    zip
    xz
    unzip
    p7zip
    xdg-utils
    gh
    nerdfonts
    gnome.seahorse
    libnotify
    alsa-utils
    playerctl

    # communications
    vesktop
    unstable-pkgs.zoom-us
    element-desktop

    # wm specifics
    inputs.hyprlock.packages.${pkgs.system}.default
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

    # lsps & formatters
    typescript
    alejandra
    prettierd
    black
    isort
    jq
    stylua
    shellcheck
    shfmt
    shellharden
    bicep
    nil

    # editors
    inputs.nixvim.packages.${pkgs.system}.default
    unstable-pkgs.zed-editor
    helix

    #ags dependencies
    coreutils
    dart-sass
    gawk
    imagemagick
    procps
    ripgrep
    util-linux
    gnome.gnome-control-center
    mission-center
    overskride
    wlogout

    # dev environment
    # devbox

    # hardware related
    stress
    s-tui
    lm_sensors
    corectrl
    glxinfo

    # productivity & entertainment
    todoist-electron
    pavucontrol
    spotify
    obsidian

    # clipboard management
    wofi
    cliphist
  ];
}
